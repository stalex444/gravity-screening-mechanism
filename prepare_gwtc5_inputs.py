#!/usr/bin/env python3
"""Verify, download, and compact the exact GWTC-5 event inputs.

The lock file is built from the official 235-event cosmology catalog and the
Zenodo file manifests it names. Large HDF5 files are handled sequentially.
The compact files intentionally preserve the PE-prior descriptions but do not
pretend that a numerical marginal prior has already been reconstructed.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import sys
import tempfile
import time
import urllib.error
import urllib.request

CHUNK = 8 * 1024 * 1024
REQUIRED_COLUMNS = ("mass_1", "mass_2", "luminosity_distance")
OPTIONAL_COLUMNS = ("chirp_mass", "mass_ratio", "log_prior")


def file_md5(path: Path) -> str:
    digest = hashlib.md5()  # noqa: S324 -- checksum supplied by the data publisher
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(CHUNK), b""):
            digest.update(block)
    return digest.hexdigest()


def human_bytes(value: int) -> str:
    units = ("B", "KiB", "MiB", "GiB", "TiB")
    amount = float(value)
    for unit in units:
        if amount < 1024 or unit == units[-1]:
            return f"{amount:.3f} {unit}"
        amount /= 1024
    raise AssertionError("unreachable")


def load_lock(path: Path) -> dict:
    with path.open(encoding="utf-8") as stream:
        document = json.load(stream)
    if document.get("schema_version") != 1:
        raise ValueError("Only lock schema version 1 is supported.")
    events = document.get("events", [])
    names = [item["event"] for item in events]
    if len(names) != len(set(names)):
        raise ValueError("The lock file contains duplicate event names.")
    summary = document["summary"]
    if summary["event_count"] != len(events):
        raise ValueError("The lock summary event count is inconsistent.")
    if summary["total_source_bytes"] != sum(x["source"]["bytes"] for x in events):
        raise ValueError("The lock summary byte count is inconsistent.")
    for item in events:
        source = item["source"]
        if len(source["md5"]) != 32 or not source["url"].startswith("https://"):
            raise ValueError(f"Invalid source record for {item['event']}.")
    return document


def select_events(document: dict, names: list[str], runs: list[str], limit: int | None) -> list[dict]:
    events = document["events"]
    by_name = {item["event"]: item for item in events}
    if names:
        unknown = sorted(set(names) - set(by_name))
        if unknown:
            raise ValueError("Unknown event(s): " + ", ".join(unknown))
        wanted = set(names)
        events = [item for item in events if item["event"] in wanted]
    if runs:
        run_set = set(runs)
        events = [item for item in events if item["run"] in run_set]
    if limit is not None:
        events = events[:limit]
    return events


def source_path(cache_dir: Path, item: dict) -> Path:
    source = item["source"]
    return cache_dir / f"{source['record_id']}--{source['filename']}"


def download_with_resume(
    url: str, destination: Path, expected_bytes: int, max_attempts: int = 6
) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    part = destination.with_name(destination.name + ".part")
    if max_attempts < 1:
        raise ValueError("max_attempts must be positive")
    last_problem = None
    for attempt in range(1, max_attempts + 1):
        offset = part.stat().st_size if part.exists() else 0
        if offset > expected_bytes:
            raise ValueError(f"Partial file is larger than the locked source: {part}")
        headers = {"User-Agent": "gravity-screening-mechanism/1.0"}
        if offset:
            headers["Range"] = f"bytes={offset}-"
        request = urllib.request.Request(url, headers=headers)
        try:
            with urllib.request.urlopen(request) as response:  # noqa: S310 -- locked HTTPS URL
                status = getattr(response, "status", response.getcode())
                append = offset > 0 and status == 206
                mode = "ab" if append else "wb"
                with part.open(mode) as stream:
                    while True:
                        block = response.read(CHUNK)
                        if not block:
                            break
                        stream.write(block)
            observed = part.stat().st_size
            if observed == expected_bytes:
                os.replace(part, destination)
                return
            last_problem = (
                f"incomplete response: expected {expected_bytes}, got {observed}"
            )
        except urllib.error.HTTPError as exc:
            if exc.code not in (408, 429, 500, 502, 503, 504):
                raise
            last_problem = f"HTTP {exc.code}: {exc.reason}"
        except (urllib.error.URLError, TimeoutError, ConnectionError) as exc:
            last_problem = str(exc)

        if attempt == max_attempts:
            break
        delay = min(2 ** attempt, 30)
        print(
            f"  transient download failure ({last_problem}); retrying in {delay}s "
            f"[{attempt}/{max_attempts}]",
            file=sys.stderr,
            flush=True,
        )
        time.sleep(delay)
    raise RuntimeError(
        f"Download failed after {max_attempts} attempts for {destination.name}: {last_problem}. "
        "Rerun the same command to resume."
    )


def decode_value(value):
    """Convert small HDF5 scalars/arrays to JSON-safe Python values."""
    try:
        value = value.tolist()
    except AttributeError:
        pass
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    if isinstance(value, list):
        return [decode_value(x) for x in value]
    if isinstance(value, tuple):
        return [decode_value(x) for x in value]
    if isinstance(value, dict):
        return {str(k): decode_value(v) for k, v in value.items()}
    return value


def read_first_dataset(group, candidates: tuple[str, ...]):
    for path in candidates:
        try:
            obj = group[path]
        except KeyError:
            continue
        if hasattr(obj, "shape"):
            value = decode_value(obj[()])
            if isinstance(value, list) and len(value) == 1:
                return value[0]
            return value
    return None


def analytic_prior_strings(group) -> dict[str, object]:
    try:
        priors = group["priors/analytic"]
    except KeyError:
        return {}
    output = {}
    for name, obj in priors.items():
        if hasattr(obj, "shape"):
            value = decode_value(obj[()])
            if isinstance(value, list) and len(value) == 1:
                value = value[0]
            output[name] = value
    return output


def posterior_column(posterior, name: str):
    if hasattr(posterior, "dtype") and posterior.dtype.names:
        if name not in posterior.dtype.names:
            raise KeyError(name)
        return posterior[name]
    if hasattr(posterior, "keys"):
        if name not in posterior:
            raise KeyError(name)
        return posterior[name][()]
    raise TypeError("Unsupported posterior_samples representation.")


def compact_event(source_pathname: Path, output: Path, item: dict) -> tuple[int, int]:
    try:
        import h5py
        import numpy as np
    except ImportError as exc:
        raise SystemExit("Extraction requires numpy and h5py.") from exc

    with h5py.File(source_pathname, "r") as source:
        selected_group = item["selected_group"]
        if selected_group not in source:
            available = ", ".join(source.keys())
            raise KeyError(f"Group {selected_group!r} is absent; available: {available}")
        group = source[selected_group]
        if "posterior_samples" not in group:
            raise KeyError(f"{selected_group!r} has no posterior_samples object.")
        posterior = group["posterior_samples"]
        arrays = {}
        for name in REQUIRED_COLUMNS:
            try:
                arrays[name] = np.asarray(posterior_column(posterior, name))
            except KeyError as exc:
                raise KeyError(f"Required posterior column {name!r} is absent.") from exc
        for name in OPTIONAL_COLUMNS:
            try:
                arrays[name] = np.asarray(posterior_column(posterior, name))
            except KeyError:
                pass
        sample_counts = {len(value) for value in arrays.values()}
        if len(sample_counts) != 1:
            raise ValueError("Posterior columns do not have a common sample count.")
        sample_count = sample_counts.pop()
        metadata = {
            "schema_version": 1,
            "event": item["event"],
            "event_type": item["event_type"],
            "run": item["run"],
            "selected_group": selected_group,
            "source": item["source"],
            "sample_count": sample_count,
            "columns": list(arrays),
            "pe_prior_kind": item.get("pe_prior_kind"),
            "analytic_priors": analytic_prior_strings(group),
            "prior_dict": read_first_dataset(
                group,
                (
                    "config_file/config/prior-dict",
                    "config_file/config/prior_dict",
                    "meta_data/other/command_line_args/prior_dict",
                ),
            ),
            "prior_density_status": (
                "not_evaluated: reconstruct the marginal density in "
                "(mass_1,mass_2,luminosity_distance) before ICAROGW use"
            ),
        }

    output.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(suffix=".npz", dir=output.parent, delete=False) as handle:
        temporary = Path(handle.name)
    try:
        np.savez_compressed(temporary, **arrays, metadata_json=np.asarray(json.dumps(metadata, sort_keys=True)))
        os.replace(temporary, output)
    finally:
        try:
            temporary.unlink()
        except FileNotFoundError:
            pass
    return sample_count, output.stat().st_size


def existing_output_matches(path: Path, item: dict) -> bool:
    if not path.exists():
        return False
    try:
        import numpy as np
        with np.load(path, allow_pickle=False) as archive:
            metadata = json.loads(str(archive["metadata_json"]))
        return (
            metadata["event"] == item["event"]
            and metadata["source"]["md5"] == item["source"]["md5"]
            and metadata["selected_group"] == item["selected_group"]
        )
    except Exception:
        return False


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("--lock", type=Path, default=Path(__file__).with_name("gwtc5_input_lock.json"))
    result.add_argument("--cache-dir", type=Path, default=Path("gwtc5-cache"))
    result.add_argument("--output-dir", type=Path, default=Path("gwtc5-data/events"))
    result.add_argument("--only", nargs="*", default=[], metavar="EVENT")
    result.add_argument("--run", action="append", default=[], choices=("O1", "O2", "O3a", "O3b", "O4a", "O4b"))
    result.add_argument("--limit", type=int)
    result.add_argument("--download", action="store_true", help="Download missing locked source files.")
    result.add_argument("--delete-source", action="store_true", help="Delete each verified HDF5 source after compact extraction.")
    result.add_argument("--max-download-attempts", type=int, default=6, help="Bounded retries for transient HTTP and connection failures.")
    result.add_argument("--dry-run", action="store_true", help="Validate and summarize without downloading or extracting.")
    return result


def main() -> int:
    args = parser().parse_args()
    if args.limit is not None and args.limit < 0:
        raise SystemExit("--limit must be nonnegative.")
    document = load_lock(args.lock)
    events = select_events(document, args.only, args.run, args.limit)
    total = sum(item["source"]["bytes"] for item in events)
    print(f"Selected {len(events)} event(s); locked source transfer {human_bytes(total)} ({total:,} bytes).")
    if events:
        largest = max(events, key=lambda x: x["source"]["bytes"])
        print(f"Largest selected source: {largest['event']} at {human_bytes(largest['source']['bytes'])}.")
    if args.dry_run:
        return 0

    failures = []
    for position, item in enumerate(events, 1):
        event = item["event"]
        source = source_path(args.cache_dir, item)
        output = args.output_dir / f"{event}.npz"
        print(f"[{position}/{len(events)}] {event}")
        if existing_output_matches(output, item):
            print(f"  compact output already verified: {output}")
            continue
        try:
            if not source.exists():
                if not args.download:
                    raise FileNotFoundError(
                        f"Missing {source}. Rerun with --download or place the locked file there."
                    )
                print(f"  downloading {human_bytes(item['source']['bytes'])}")
                download_with_resume(
                    item["source"]["url"],
                    source,
                    item["source"]["bytes"],
                    max_attempts=args.max_download_attempts,
                )
            if source.stat().st_size != item["source"]["bytes"]:
                raise ValueError("Source size does not match the lock.")
            observed_md5 = file_md5(source)
            if observed_md5 != item["source"]["md5"]:
                raise ValueError(
                    f"MD5 mismatch: expected {item['source']['md5']}, observed {observed_md5}"
                )
            print(f"  source checksum verified: {observed_md5}")
            samples, output_bytes = compact_event(source, output, item)
            print(f"  wrote {samples:,} samples to {output} ({human_bytes(output_bytes)})")
            if args.delete_source:
                source.unlink()
                print("  deleted verified source after extraction")
        except Exception as exc:
            failures.append((event, str(exc)))
            print(f"  ERROR: {exc}", file=sys.stderr)

    if failures:
        print("\nFailures:", file=sys.stderr)
        for event, reason in failures:
            print(f"  {event}: {reason}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
