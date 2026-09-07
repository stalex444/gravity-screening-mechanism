#!/usr/bin/env python3
"""Prepare the locked GWTC-5 cumulative injections for ICAROGW.

The fiducial selection is fixed before any PDT likelihood is evaluated:

* O1/O2 semianalytic channel: network SNR > 10
* O3/O4 real-search channel: minimum FAR < 0.25 / year

The script verifies the release checksum, reconstructs the draw density in
(detector-frame m1, detector-frame m2, luminosity distance), absorbs the
published run-mixture weight in that effective density, and writes only the
found injections needed by ICAROGW's ``CBC_vanilla_rate``.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import tempfile

import h5py
import numpy as np


DEFAULT_LOCK = Path(__file__).with_name("gwtc5_input_lock.json")
DEFAULT_SNR_THRESHOLD = 10.0
DEFAULT_FAR_THRESHOLD = 0.25
DRAW_FIELD = (
    "lnpdraw_mass1_source_mass2_source_redshift_"
    "spin1_magnitude_spin1_polar_angle_spin1_azimuthal_angle_"
    "spin2_magnitude_spin2_polar_angle_spin2_azimuthal_angle"
)
SNR_FIELD = "semianalytic_observed_phase_maximized_snr_net"
REQUIRED_FIELDS = {
    "mass1_source",
    "mass2_source",
    "luminosity_distance",
    "redshift",
    "dluminosity_distance_dredshift",
    "inclination",
    "lnpdraw_inclination",
    "weights",
    "spin1_magnitude",
    "spin1_polar_angle",
    "spin1_azimuthal_angle",
    "spin2_magnitude",
    "spin2_polar_angle",
    "spin2_azimuthal_angle",
    SNR_FIELD,
    DRAW_FIELD,
}


def md5(path: Path, block_size: int = 8 * 1024 * 1024) -> str:
    digest = hashlib.md5()  # noqa: S324 -- published-data integrity check
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(block_size), b""):
            digest.update(block)
    return digest.hexdigest()


def locked_candidate(lock_path: Path, source: Path) -> tuple[dict, dict]:
    with lock_path.open(encoding="utf-8") as stream:
        lock = json.load(stream)
    candidates = lock["cumulative_injection_record"]["candidates"]
    matches = [item for item in candidates if item["filename"] == source.name]
    if len(matches) != 1:
        known = ", ".join(item["filename"] for item in candidates)
        raise SystemExit(f"Injection file is not uniquely locked: {source.name}\nKnown: {known}")
    return lock, matches[0]


def validate_source(source: Path, candidate: dict) -> str:
    observed_size = source.stat().st_size
    if observed_size != int(candidate["bytes"]):
        raise SystemExit(
            f"Size mismatch for {source.name}: expected {candidate['bytes']}, got {observed_size}"
        )
    observed_md5 = md5(source)
    if observed_md5 != candidate["md5"]:
        raise SystemExit(
            f"MD5 mismatch for {source.name}: expected {candidate['md5']}, got {observed_md5}"
        )
    return observed_md5


def spin_log_density(block: np.ndarray) -> np.ndarray:
    """Uniform magnitudes, isotropic poles, uniform azimuths for two spins."""
    output = np.zeros(len(block), dtype=np.float64)
    for index in (1, 2):
        magnitude = block[f"spin{index}_magnitude"]
        polar = block[f"spin{index}_polar_angle"]
        azimuth = block[f"spin{index}_azimuthal_angle"]
        if not (
            np.all((magnitude >= 0.0) & (magnitude <= 1.0))
            and np.all((polar > 0.0) & (polar < math.pi))
            and np.all((azimuth >= -math.pi) & (azimuth <= math.pi))
        ):
            raise ValueError("A spin sample lies outside the documented default support.")
        output += np.log(np.sin(polar)) - math.log(2.0) - math.log(2.0 * math.pi)
    return output


def inclination_log_density(inclination: np.ndarray) -> np.ndarray:
    return np.log(np.sin(inclination)) - math.log(2.0)


def far_columns(names: tuple[str, ...]) -> list[str]:
    return sorted(name for name in names if name.endswith("_far"))


def read_selected(
    dataset: h5py.Dataset,
    far_names: list[str],
    snr_threshold: float,
    far_threshold: float,
    chunk_size: int,
) -> tuple[dict[str, np.ndarray], dict]:
    buffers: dict[str, list[np.ndarray]] = {
        "mass_1": [],
        "mass_2": [],
        "chirp_mass": [],
        "mass_ratio": [],
        "luminosity_distance": [],
        "redshift_release": [],
        "prior": [],
        "log_prior": [],
        "mixture_weight": [],
        "selection_channel": [],
    }
    total = len(dataset)
    semianalytic_selected = 0
    real_selected = 0
    overlap_selected = 0
    selected = 0
    inclination_residual_max = 0.0
    log_prior_min = math.inf
    log_prior_max = -math.inf

    for start in range(0, total, chunk_size):
        stop = min(start + chunk_size, total)
        block = dataset[start:stop]
        snr = block[SNR_FIELD]
        semianalytic = np.isfinite(snr) & (snr > snr_threshold)

        far = np.full(len(block), np.inf, dtype=np.float64)
        for field in far_names:
            values = block[field]
            far = np.minimum(far, np.where(np.isfinite(values), values, np.inf))
        real = far < far_threshold
        keep = semianalytic | real

        semianalytic_selected += int(np.count_nonzero(semianalytic))
        real_selected += int(np.count_nonzero(real))
        overlap_selected += int(np.count_nonzero(semianalytic & real))
        selected += int(np.count_nonzero(keep))
        if not np.any(keep):
            continue

        kept = block[keep]
        inclination_residual = kept["lnpdraw_inclination"] - inclination_log_density(
            kept["inclination"]
        )
        inclination_residual_max = max(
            inclination_residual_max, float(np.max(np.abs(inclination_residual)))
        )

        z = kept["redshift"].astype(np.float64)
        one_plus_z = 1.0 + z
        m1_source = kept["mass1_source"].astype(np.float64)
        m2_source = kept["mass2_source"].astype(np.float64)
        m1_detector = m1_source * one_plus_z
        m2_detector = m2_source * one_plus_z
        distance = kept["luminosity_distance"].astype(np.float64)
        ddl_dz = kept["dluminosity_distance_dredshift"].astype(np.float64)
        weights = kept["weights"].astype(np.float64)

        if not (
            np.all(m1_detector > 0.0)
            and np.all(m2_detector > 0.0)
            and np.all(distance > 0.0)
            and np.all(ddl_dz > 0.0)
            and np.all(weights > 0.0)
        ):
            raise ValueError("Selected injections contain a nonpositive physical value.")

        # Marginalize the injection spin coordinates against the baseline
        # population's identical uniform-magnitude/isotropic-orientation law.
        log_draw_source_masses_z = kept[DRAW_FIELD] - spin_log_density(kept)

        # J = |d(m1d,m2d,dL) / d(m1s,m2s,z)|.
        log_jacobian = 2.0 * np.log1p(z) + np.log(ddl_dz)

        # The cumulative release's run-mixture weights multiply each Monte
        # Carlo term. ICAROGW has no separate mixture-weight slot, so absorb
        # them into the denominator: p_eff = p_draw_detector / weight.
        log_prior = log_draw_source_masses_z - log_jacobian - np.log(weights)
        prior = np.exp(log_prior)
        if not (np.all(np.isfinite(log_prior)) and np.all(np.isfinite(prior)) and np.all(prior > 0)):
            raise ValueError("The reconstructed detector-frame injection prior is invalid.")
        log_prior_min = min(log_prior_min, float(np.min(log_prior)))
        log_prior_max = max(log_prior_max, float(np.max(log_prior)))

        mass_ratio = m2_detector / m1_detector
        chirp_mass = (m1_detector * m2_detector) ** (3.0 / 5.0) / (
            m1_detector + m2_detector
        ) ** (1.0 / 5.0)
        channel = np.where(semianalytic[keep], 1, 2).astype(np.uint8)

        values = {
            "mass_1": m1_detector,
            "mass_2": m2_detector,
            "chirp_mass": chirp_mass,
            "mass_ratio": mass_ratio,
            "luminosity_distance": distance,
            "redshift_release": z,
            "prior": prior,
            "log_prior": log_prior,
            "mixture_weight": weights,
            "selection_channel": channel,
        }
        for name, value in values.items():
            buffers[name].append(value)

    arrays = {
        name: np.concatenate(parts) if parts else np.empty(0, dtype=np.float64)
        for name, parts in buffers.items()
    }
    if overlap_selected:
        raise ValueError("Semianalytic and real-search selection channels unexpectedly overlap.")
    if selected != len(arrays["prior"]):
        raise AssertionError("Selection accounting disagrees with output length.")
    if inclination_residual_max > 5e-12:
        raise ValueError(
            "The released inclination density is not the documented isotropic law; "
            f"maximum log residual {inclination_residual_max:.3e}."
        )

    report = {
        "rows_in_release": total,
        "rows_selected": selected,
        "semianalytic_rows_snr_gt_threshold": semianalytic_selected,
        "real_search_rows_far_lt_threshold": real_selected,
        "selection_overlap_rows": overlap_selected,
        "inclination_log_density_max_abs_residual": inclination_residual_max,
        "effective_log_prior_min": log_prior_min,
        "effective_log_prior_max": log_prior_max,
    }
    return arrays, report


def write_npz(output: Path, arrays: dict[str, np.ndarray], metadata: dict) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    fd, temporary_name = tempfile.mkstemp(
        dir=output.parent, prefix=f".{output.name}.", suffix=".tmp"
    )
    os.close(fd)
    temporary = Path(temporary_name)
    try:
        with temporary.open("wb") as stream:
            np.savez_compressed(stream, metadata=json.dumps(metadata, sort_keys=True), **arrays)
        os.replace(temporary, output)
    finally:
        if temporary.exists():
            temporary.unlink()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="Checksum-locked cumulative HDF file")
    parser.add_argument(
        "--lock", type=Path, default=DEFAULT_LOCK, help="Input lock JSON (default: repository lock)"
    )
    parser.add_argument("--output", type=Path, help="Compact NPZ destination")
    parser.add_argument("--snr-threshold", type=float, default=DEFAULT_SNR_THRESHOLD)
    parser.add_argument("--far-threshold", type=float, default=DEFAULT_FAR_THRESHOLD)
    parser.add_argument("--chunk-size", type=int, default=100_000)
    parser.add_argument("--dry-run", action="store_true", help="Validate and report without writing")
    args = parser.parse_args()

    if args.snr_threshold <= 0 or args.far_threshold <= 0 or args.chunk_size <= 0:
        raise SystemExit("Thresholds and chunk size must be positive.")
    source = args.source.resolve()
    lock_path = args.lock.resolve()
    _, candidate = locked_candidate(lock_path, source)
    checksum = validate_source(source, candidate)

    with h5py.File(source, "r") as handle:
        dataset = handle["events"]
        names = dataset.dtype.names
        if names is None:
            raise SystemExit("The HDF events dataset is not a compound table.")
        missing = REQUIRED_FIELDS.difference(names)
        if missing:
            raise SystemExit(f"Missing required injection fields: {sorted(missing)}")
        far_names = far_columns(names)
        searches = [item.decode() if isinstance(item, bytes) else str(item) for item in handle.attrs["searches"]]
        expected_far = sorted(f"{search}_far" for search in searches)
        if far_names != expected_far:
            raise SystemExit(
                f"FAR fields disagree with release searches. expected={expected_far}, observed={far_names}"
            )
        arrays, report = read_selected(
            dataset, far_names, args.snr_threshold, args.far_threshold, args.chunk_size
        )
        metadata = {
            "schema_version": 1,
            "source_filename": source.name,
            "source_bytes": source.stat().st_size,
            "source_md5": checksum,
            "source_record": candidate["record_id"],
            "source_url": candidate["url"],
            "snr_selection": f"{SNR_FIELD} > {args.snr_threshold:g}",
            "far_selection": f"min({','.join(far_names)}) < {args.far_threshold:g} / year",
            "selection_union": "snr_selection OR far_selection",
            "total_generated": float(handle.attrs["total_generated"]),
            "total_analysis_time_seconds": float(handle.attrs["total_analysis_time"]),
            "total_analysis_time_years_365_25d": float(handle.attrs["total_analysis_time"])
            / (365.25 * 24 * 3600),
            "searches": searches,
            "prior_coordinates": ["mass_1", "mass_2", "luminosity_distance"],
            "prior_definition": (
                "exp(lnpdraw_joint - log p_default_spins - "
                "log((1+z)^2 dD_L/dz) - log(mixture_weight))"
            ),
            "spin_cancellation": (
                "baseline population and injection draw both use uniform magnitudes, "
                "isotropic polar angles, and uniform azimuths"
            ),
            "selection_channel_codes": {"1": "O1/O2 semianalytic", "2": "O3/O4 real search"},
            **report,
        }

    print(json.dumps(metadata, indent=2, sort_keys=True))
    if args.dry_run:
        return
    output = args.output or source.with_suffix(".icarogw.npz")
    write_npz(output, arrays, metadata)
    print(f"wrote={output}")
    print(f"bytes={output.stat().st_size}")


if __name__ == "__main__":
    main()
