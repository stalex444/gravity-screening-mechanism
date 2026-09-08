#!/usr/bin/env python3
"""Exercise the pinned GWTC-5 spectral-siren likelihood at GR and PDT points.

This is an integration diagnostic, not a model-comparison result. It fixes all
population and background-cosmology nuisance parameters to posterior medians
from an official released cM run and evaluates only the selected event files.
A defensible Bayes factor still requires all 235 events and nuisance-parameter
marginalization.
"""

from __future__ import annotations

import argparse
import importlib.metadata
import json
from pathlib import Path
import subprocess
import time

PINNED_ICAROGW_COMMIT = "c473f3b2f50e11a88a46cc1625933af1f1249d39"
BETA_Q = 0.08333758478067765
CORE_VERSIONS = {
    "numpy": "2.3.5",
    "scipy": "1.17.1",
    "h5py": "3.16.0",
    "astropy": "7.2.0",
    "bilby": "2.6.0",
}


def detected_icarogw_commit(package_file: str) -> str:
    checkout = Path(package_file).resolve().parent.parent
    try:
        process = subprocess.run(
            ["git", "-C", str(checkout), "rev-parse", "HEAD"],
            check=True,
            capture_output=True,
            text=True,
        )
        return process.stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        return "unavailable"


def versions() -> dict[str, str]:
    names = list(CORE_VERSIONS) + ["icarogw", "mhealpy", "ligo.skymap", "nessai", "nessai-bilby"]
    result = {}
    for name in names:
        try:
            result[name] = importlib.metadata.version(name)
        except importlib.metadata.PackageNotFoundError:
            result[name] = "not-installed-as-distribution"
    return result


def check_core_versions(observed: dict[str, str], allow_mismatch: bool) -> None:
    problems = [
        f"{name}: expected {expected}, observed {observed[name]}"
        for name, expected in CORE_VERSIONS.items()
        if observed[name] != expected
    ]
    if problems and not allow_mismatch:
        raise RuntimeError("Core version mismatch:\n  " + "\n  ".join(problems))


def load_reference_medians(path: Path, np) -> tuple[dict[str, float], dict]:
    with path.open(encoding="utf-8") as stream:
        document = json.load(stream)
    content = document["posterior"]["content"]
    search_keys = set(document["search_parameter_keys"])
    medians = {
        key: float(np.median(value))
        for key, value in content.items()
        if key in search_keys and isinstance(value, list)
    }
    fixed = document.get("fixed_parameter_keys", [])
    priors = document["priors"]
    for key in fixed:
        medians[key] = float(priors[key]["kwargs"]["peak"])
    provenance = {
        "filename": path.name,
        "label": document.get("label"),
        "published_log_evidence": document.get("log_evidence"),
        "published_log_evidence_error": document.get("log_evidence_err"),
        "nuisance_rule": "component-wise posterior medians; diagnostic only",
    }
    return medians, provenance


def load_event(path: Path, np, posterior_samples):
    with np.load(path, allow_pickle=False) as archive:
        metadata = json.loads(str(archive["metadata_json"]))
        missing = [name for name in ("mass_1", "mass_2", "luminosity_distance", "prior") if name not in archive]
        if missing:
            raise ValueError(f"{path} is missing {missing}")
        data = {name: np.asarray(archive[name]) for name in ("mass_1", "mass_2", "luminosity_distance")}
        prior = np.asarray(archive["prior"])
    return metadata, posterior_samples(data, prior)


def choose_event_paths(event_dir: Path, event_names: list[str]) -> list[Path]:
    if event_names:
        paths = [event_dir / f"{name}.with-prior.npz" for name in event_names]
    else:
        paths = sorted(event_dir.glob("*.with-prior.npz"))
    missing = [str(path) for path in paths if not path.exists()]
    if missing:
        raise FileNotFoundError("Missing event file(s): " + ", ".join(missing))
    if not paths:
        raise ValueError("No .with-prior.npz event files were selected.")
    return paths


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("--event-dir", type=Path, required=True)
    result.add_argument("--injections", type=Path, required=True)
    result.add_argument("--reference-result", type=Path, required=True)
    result.add_argument("--events", nargs="*", default=[])
    result.add_argument("--nparallel", type=int, default=4096)
    result.add_argument("--neff-pe", type=int, default=20)
    result.add_argument("--seed", type=int, default=260907)
    result.add_argument("--zmax", type=float, default=20.0)
    result.add_argument("--beta-q", type=float, default=BETA_Q)
    result.add_argument("--output", type=Path)
    result.add_argument("--allow-version-mismatch", action="store_true")
    return result


def main() -> int:
    args = parser().parse_args()
    observed_versions = versions()
    check_core_versions(observed_versions, args.allow_version_mismatch)

    import numpy as np
    import icarogw
    icarogw_commit = detected_icarogw_commit(icarogw.__file__)
    if (
        icarogw_commit not in ("unavailable", PINNED_ICAROGW_COMMIT)
        and not args.allow_version_mismatch
    ):
        raise RuntimeError(
            f"ICAROGW commit mismatch: expected {PINNED_ICAROGW_COMMIT}, observed {icarogw_commit}"
        )
    if (
        observed_versions["icarogw"] not in ("2.0.3", "not-installed-as-distribution")
        and not args.allow_version_mismatch
    ):
        raise RuntimeError(
            f"ICAROGW version mismatch: expected 2.0.3, observed {observed_versions['icarogw']}"
        )
    from icarogw.injections import injections
    from icarogw.likelihood import hierarchical_likelihood
    from icarogw.posterior_samples import posterior_samples, posterior_samples_catalog
    from icarogw.rates import CBC_vanilla_rate
    from icarogw.wrappers import (
        FlatLambdaCDM_wrap,
        eps0_mod_wrap,
        m1m2_paired_massratio_bplmulti_dip,
        rateevolution_Madau,
    )

    event_paths = choose_event_paths(args.event_dir, args.events)
    event_objects = {}
    event_records = []
    for path in event_paths:
        metadata, event_object = load_event(path, np, posterior_samples)
        event = metadata["event"]
        if event in event_objects:
            raise ValueError(f"Duplicate event {event}")
        event_objects[event] = event_object
        event_records.append({
            "event": event,
            "run": metadata["run"],
            "selected_group": metadata["selected_group"],
            "source_md5": metadata["source"]["md5"],
            "posterior_samples": event_object.nsamples,
            "median_luminosity_distance_mpc": float(
                np.median(event_object.posterior_data["luminosity_distance"])
            ),
        })

    with np.load(args.injections, allow_pickle=False) as archive:
        injection_metadata = json.loads(str(archive["metadata"]))
        injection_data = {
            name: np.asarray(archive[name])
            for name in ("mass_1", "mass_2", "luminosity_distance")
        }
        injection_prior = np.asarray(archive["prior"])
    injection_object = injections(
        injection_data,
        injection_prior,
        ntotal=float(injection_metadata["total_generated"]),
        Tobs=float(injection_metadata["total_analysis_time_years_365_25d"]),
    )

    medians, reference = load_reference_medians(args.reference_result, np)
    cosmology = eps0_mod_wrap(FlatLambdaCDM_wrap(args.zmax))
    rate_model = CBC_vanilla_rate(
        cosmology,
        m1m2_paired_massratio_bplmulti_dip(),
        rateevolution_Madau(),
        scale_free=True,
    )
    missing_nuisance = sorted(set(rate_model.population_parameters) - set(medians) - {"eps0"})
    if missing_nuisance:
        raise ValueError("Reference result lacks nuisance parameters: " + ", ".join(missing_nuisance))

    np.random.seed(args.seed)
    likelihood = hierarchical_likelihood(
        posterior_samples_catalog(event_objects),
        injection_object,
        rate_model,
        nparallel=args.nparallel,
        neffPE=args.neff_pe,
        neffINJ=None,
    )

    hypotheses = {}
    event_log_terms = {}
    selection_log_terms = {}
    for label, exponent in (("GR", 0.0), ("PDT", args.beta_q)):
        parameters = {
            key: (exponent if key == "eps0" else medians[key])
            for key in rate_model.population_parameters
        }
        likelihood.parameters.update(parameters)
        started = time.perf_counter()
        log_likelihood = likelihood.log_likelihood()
        elapsed = time.perf_counter() - started
        pe_neff = likelihood.posterior_samples_dict.get_effective_number_of_PE()
        event_log_terms[label] = np.log(
            np.asarray(likelihood.posterior_samples_dict.sum_weights)
        )
        selection_log_terms[label] = float(
            -len(event_records) * np.log(injection_object.pseudo_rate)
        )
        hypotheses[label] = {
            "eps0": exponent,
            "log_likelihood": float(log_likelihood),
            "runtime_seconds": elapsed,
            "effective_injections": float(injection_object.effective_injections_number()),
            "effective_pe_min": float(np.min(pe_neff)),
            "effective_pe_max": float(np.max(pe_neff)),
            "likelihood_variance": float(likelihood.likelihood_variance),
        }

    event_delta = event_log_terms["PDT"] - event_log_terms["GR"]
    selection_delta = selection_log_terms["PDT"] - selection_log_terms["GR"]
    reconstructed_delta = float(np.sum(event_delta) + selection_delta)
    direct_delta = hypotheses["PDT"]["log_likelihood"] - hypotheses["GR"]["log_likelihood"]
    if not np.isclose(reconstructed_delta, direct_delta, rtol=0.0, atol=1e-10):
        raise RuntimeError(
            f"Attribution does not reconstruct likelihood difference: {reconstructed_delta} vs {direct_delta}"
        )

    report = {
        "schema_version": 1,
        "status": "diagnostic_only_not_model_evidence",
        "reason": "selected events and fixed nuisance medians; no nuisance marginalization",
        "icarogw_commit_expected": PINNED_ICAROGW_COMMIT,
        "icarogw_commit_detected": icarogw_commit,
        "versions": observed_versions,
        "settings": {
            "seed": args.seed,
            "zmax": args.zmax,
            "nparallel": args.nparallel,
            "neff_pe": args.neff_pe,
            "neff_injections": 4 * len(event_records),
            "event_count": len(event_records),
        },
        "events": event_records,
        "injections": {
            "filename": args.injections.name,
            "source_md5": injection_metadata["source_md5"],
            "selected_rows": len(injection_prior),
            "total_generated": injection_metadata["total_generated"],
        },
        "reference_result": reference,
        "hypotheses": hypotheses,
        "attribution": {
            "definition": "fixed-nuisance diagnostic only; event log-sum-weight terms plus the model-dependent selection term",
            "event_terms": [
                {
                    "event": record["event"],
                    "run": record["run"],
                    "median_luminosity_distance_mpc": record[
                        "median_luminosity_distance_mpc"
                    ],
                    "delta_log_event_term_pdt_minus_gr": float(delta),
                }
                for record, delta in zip(event_records, event_delta)
            ],
            "sum_event_terms": float(np.sum(event_delta)),
            "selection_term_pdt_minus_gr": selection_delta,
            "reconstructed_delta": reconstructed_delta,
        },
        "delta_log_likelihood_pdt_minus_gr": direct_delta,
    }
    payload = json.dumps(report, indent=2, sort_keys=True, allow_nan=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(payload, encoding="utf-8")
    print(payload, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
