#!/usr/bin/env python3
"""Build or run the pinned GWTC-5 FullPop spectral-siren inference.

Three modes use identical event, injection, population, rate, Hubble, and
sampler treatment:

* reference-cm: reproduce the released GWTC-5 cM evidence;
* gr: fix eps0 = 0;
* pdt: fix eps0 = beta_Q.

The default action writes an auditable plan without starting the expensive
nested sampler. Pass --run-sampler only after all 235 compact event files are
present and the reference-cm configuration has been reviewed.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

from gwtc5_likelihood_smoke import (
    BETA_Q,
    PINNED_ICAROGW_COMMIT,
    check_core_versions,
    detected_icarogw_commit,
    load_event,
    versions,
)


OFFICIAL_RESULT_MD5 = {
    "icarogw_fullpop_spectral_cm_narrow.json": "5a6d4b63a48c383c07d654649700ee68",
    "icarogw_fullpop_spectral_cm_wide.json": "91a6271ae03770f3616baf79719cf0c2",
}


def md5(path: Path) -> str:
    digest = hashlib.md5()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def peak_ordering_conversion(parameters):
    """Supply the serialized FullPop ordering constraint to Bilby.

    The released prior calls this value ``peak_constraint`` with support
    [0, 5000]. Both official cM posteriors contain only mu_g_high > mu_g_low.
    The reference-evidence reproduction is the end-to-end check of this
    reconstructed conversion.
    """

    converted = dict(parameters)
    converted["peak_constraint"] = (
        converted["mu_g_high"] - converted["mu_g_low"]
    )
    return converted


def read_reference(path: Path, decode_bilby_json):
    with path.open(encoding="utf-8") as stream:
        document = json.load(stream)
    priors = json.loads(
        json.dumps(document["priors"]), object_hook=decode_bilby_json
    )
    priors.conversion_function = peak_ordering_conversion
    checksum = md5(path)
    expected = OFFICIAL_RESULT_MD5.get(path.name)
    if expected is not None and checksum != expected:
        raise ValueError(
            f"Reference-result MD5 mismatch: expected {expected}, observed {checksum}"
        )
    return document, priors, checksum


def check_reference_constraint(document, np) -> dict:
    content = document["posterior"]["content"]
    high = np.asarray(content["mu_g_high"], dtype=float)
    low = np.asarray(content["mu_g_low"], dtype=float)
    difference = high - low
    return {
        "posterior_samples": int(len(difference)),
        "minimum_mu_high_minus_mu_low": float(np.min(difference)),
        "maximum_mu_high_minus_mu_low": float(np.max(difference)),
        "all_within_serialized_constraint": bool(
            np.all((difference >= 0.0) & (difference <= 5000.0))
        ),
        "conversion": "peak_constraint = mu_g_high - mu_g_low",
        "validation": "published cM evidence must be reproduced before PDT or GR evidence is interpreted",
    }


def inspect_events(event_dir: Path, lock: dict, np) -> tuple[list[Path], dict]:
    expected = {record["event"]: record for record in lock["events"]}
    actual = {
        path.name.removesuffix(".with-prior.npz"): path
        for path in event_dir.glob("*.with-prior.npz")
    }
    missing = [event for event in expected if event not in actual]
    extra = sorted(set(actual) - set(expected))
    checked = []
    anomalies = []
    for event in expected:
        if event not in actual:
            continue
        path = actual[event]
        try:
            with np.load(path, allow_pickle=False) as archive:
                metadata = json.loads(str(archive["metadata_json"]))
            record = expected[event]
            comparisons = {
                "event": metadata.get("event") == event,
                "run": metadata.get("run") == record["run"],
                "selected_group": metadata.get("selected_group")
                == record["selected_group"],
                "source_md5": metadata.get("source", {}).get("md5")
                == record["source"]["md5"],
            }
            if not all(comparisons.values()):
                anomalies.append({"event": event, "comparisons": comparisons})
            checked.append(path)
        except Exception as exc:  # diagnostic report retains the exact file
            anomalies.append({"event": event, "error": str(exc)})
    return checked, {
        "expected": len(expected),
        "present": len(checked),
        "missing_count": len(missing),
        "missing": missing,
        "extra": extra,
        "metadata_anomalies": anomalies,
        "complete": not missing and not extra and not anomalies,
    }


def inspect_injections(path: Path, lock: dict, np) -> dict:
    with np.load(path, allow_pickle=False) as archive:
        metadata = json.loads(str(archive["metadata"]))
        rows = int(len(archive["prior"]))
    verified = lock["cumulative_injection_record"]["verified_preparation"]
    chosen = lock["cumulative_injection_record"]["candidates"][0]
    checks = {
        "source_md5": metadata.get("source_md5") == verified["candidate_md5"],
        "source_filename": metadata.get("source_filename") == chosen["filename"],
        "selected_rows": rows == verified["rows_selected"],
        "semianalytic_rows": metadata.get("semianalytic_rows_snr_gt_threshold")
        == verified["semianalytic_rows_selected"],
        "real_search_rows": metadata.get("real_search_rows_far_lt_threshold")
        == verified["real_search_rows_selected"],
        "selection_overlap": metadata.get("selection_overlap_rows")
        == verified["selection_overlap_rows"],
        "snr_threshold": metadata.get("snr_selection")
        == "semianalytic_observed_phase_maximized_snr_net > 10",
        "far_threshold": metadata.get("far_selection", "").endswith(
            "< 0.25 / year"
        ),
        "selection_union": metadata.get("selection_union")
        == "snr_selection OR far_selection",
    }
    return {
        "filename": path.name,
        "selected_rows": rows,
        "source_md5": metadata.get("source_md5"),
        "checks": checks,
        "complete": all(checks.values()),
    }


def configure_priors(priors, mode: str, beta_q: float, fixed_h0, DeltaFunction):
    if mode == "reference-cm":
        if fixed_h0 is not None:
            raise ValueError("reference-cm must retain the released H0 prior")
        if "cM" not in priors:
            raise ValueError("Reference prior does not contain cM")
    else:
        priors.pop("cM", None)
        exponent = 0.0 if mode == "gr" else beta_q
        priors["eps0"] = DeltaFunction(exponent, name="eps0")
    if fixed_h0 is not None:
        priors["H0"] = DeltaFunction(fixed_h0, name="H0")
    return priors


def prior_summary(priors) -> dict:
    result = {}
    for key, prior in priors.items():
        entry = {"class": type(prior).__name__}
        for attribute in ("minimum", "maximum", "peak"):
            if hasattr(prior, attribute):
                value = getattr(prior, attribute)
                if value is not None:
                    try:
                        entry[attribute] = float(value)
                    except (TypeError, ValueError):
                        entry[attribute] = str(value)
        result[key] = entry
    return result


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("--mode", choices=("reference-cm", "gr", "pdt"), required=True)
    result.add_argument("--event-dir", type=Path, required=True)
    result.add_argument("--injections", type=Path, required=True)
    result.add_argument("--input-lock", type=Path, default=Path("gwtc5_input_lock.json"))
    result.add_argument("--reference-result", type=Path, required=True)
    result.add_argument("--outdir", type=Path, default=Path("gwtc5-runs"))
    result.add_argument("--label")
    result.add_argument("--plan-output", type=Path)
    result.add_argument("--nparallel", type=int, default=4096)
    result.add_argument("--neff-pe", type=int, default=20)
    result.add_argument("--zmax", type=float, default=20.0)
    result.add_argument("--beta-q", type=float, default=BETA_Q)
    result.add_argument("--fixed-h0", type=float)
    result.add_argument("--nlive", type=int, default=1000)
    result.add_argument("--stopping", type=float, default=0.1)
    result.add_argument("--n-pool", type=int, default=16)
    result.add_argument("--seed", type=int, default=260907)
    result.add_argument("--run-sampler", action="store_true")
    result.add_argument("--allow-version-mismatch", action="store_true")
    return result


def main() -> int:
    args = parser().parse_args()
    observed_versions = versions()
    check_core_versions(observed_versions, args.allow_version_mismatch)

    import numpy as np
    import bilby
    import icarogw
    from bilby.core.prior import DeltaFunction
    from bilby.core.utils import decode_bilby_json
    from icarogw.injections import injections
    from icarogw.likelihood import hierarchical_likelihood
    from icarogw.posterior_samples import posterior_samples, posterior_samples_catalog
    from icarogw.rates import CBC_vanilla_rate
    from icarogw.wrappers import (
        FlatLambdaCDM_wrap,
        cM_mod_wrap,
        eps0_mod_wrap,
        m1m2_paired_massratio_bplmulti_dip,
        rateevolution_Madau,
    )

    commit = detected_icarogw_commit(icarogw.__file__)
    if (
        commit not in ("unavailable", PINNED_ICAROGW_COMMIT)
        and not args.allow_version_mismatch
    ):
        raise RuntimeError(
            f"ICAROGW commit mismatch: expected {PINNED_ICAROGW_COMMIT}, observed {commit}"
        )
    if (
        observed_versions["icarogw"] not in ("2.0.3", "not-installed-as-distribution")
        and not args.allow_version_mismatch
    ):
        raise RuntimeError(
            "ICAROGW version mismatch: expected 2.0.3, "
            f"observed {observed_versions['icarogw']}"
        )

    with args.input_lock.open(encoding="utf-8") as stream:
        lock = json.load(stream)
    document, priors, reference_md5 = read_reference(
        args.reference_result, decode_bilby_json
    )
    serialized_sampler = document.get("sampler_kwargs", {})
    reference_sampler_checks = {
        "sampler_is_nessai": document.get("sampler") == "nessai",
        "nlive": serialized_sampler.get("nlive") == args.nlive,
        "stopping": serialized_sampler.get("stopping") == args.stopping,
        "n_pool": serialized_sampler.get("n_pool") == args.n_pool,
        "checkpoint_interval": serialized_sampler.get("checkpoint_interval") == 600,
        "resume": serialized_sampler.get("resume") is True,
        "nessai_likelihood_constraint": serialized_sampler.get(
            "nessai_likelihood_constraint"
        )
        is True,
        "allow_multi_valued_likelihood": serialized_sampler.get(
            "allow_multi_valued_likelihood"
        )
        is True,
    }
    if not all(reference_sampler_checks.values()):
        raise ValueError(
            "Requested sampler settings disagree with the released result: "
            + json.dumps(reference_sampler_checks, sort_keys=True)
        )
    constraint_audit = check_reference_constraint(document, np)
    if not constraint_audit["all_within_serialized_constraint"]:
        raise ValueError("Released posterior violates reconstructed peak constraint")
    priors = configure_priors(
        priors, args.mode, args.beta_q, args.fixed_h0, DeltaFunction
    )

    event_paths, event_audit = inspect_events(args.event_dir, lock, np)
    injection_audit = inspect_injections(args.injections, lock, np)
    cosmology = (
        cM_mod_wrap(FlatLambdaCDM_wrap(args.zmax))
        if args.mode == "reference-cm"
        else eps0_mod_wrap(FlatLambdaCDM_wrap(args.zmax))
    )
    rate_model = CBC_vanilla_rate(
        cosmology,
        m1m2_paired_massratio_bplmulti_dip(),
        rateevolution_Madau(),
        scale_free=True,
    )
    expected_prior_keys = set(rate_model.population_parameters) | {"peak_constraint"}
    if set(priors) != expected_prior_keys:
        raise ValueError(
            "Prior/model mismatch: missing="
            f"{sorted(expected_prior_keys - set(priors))}, extra={sorted(set(priors) - expected_prior_keys)}"
        )

    label = args.label or (
        f"gwtc5_{args.mode.replace('-', '_')}_"
        f"{'fixed_h0' if args.fixed_h0 is not None else 'marginal_h0'}"
    )
    plan = {
        "schema_version": 1,
        "status": "ready" if event_audit["complete"] and injection_audit["complete"] else "incomplete_inputs",
        "mode": args.mode,
        "physical_parameter": (
            {"cM": "sampled from released prior"}
            if args.mode == "reference-cm"
            else {"eps0": 0.0 if args.mode == "gr" else args.beta_q}
        ),
        "h0": "released prior" if args.fixed_h0 is None else args.fixed_h0,
        "reference_result": {
            "filename": args.reference_result.name,
            "md5": reference_md5,
            "published_log_evidence": document["log_evidence"],
            "published_log_evidence_error": document["log_evidence_err"],
            "sampler_checks": reference_sampler_checks,
            "published_seed": serialized_sampler.get("seed"),
            "rerun_seed": args.seed,
        },
        "reference_constraint": constraint_audit,
        "events": event_audit,
        "injections": injection_audit,
        "software": {
            "versions": observed_versions,
            "icarogw_commit_expected": PINNED_ICAROGW_COMMIT,
            "icarogw_commit_detected": commit,
        },
        "likelihood": {
            "class": "icarogw.likelihood.hierarchical_likelihood",
            "population": "FullPop-4.0 spectral, no explicit spin model",
            "scale_free": True,
            "zmax": args.zmax,
            "nparallel": args.nparallel,
            "neff_pe": args.neff_pe,
            "neff_injections": "4 * observed events",
        },
        "sampler": {
            "name": "nessai",
            "nlive": args.nlive,
            "stopping": args.stopping,
            "n_pool": args.n_pool,
            "seed": args.seed,
            "checkpoint_interval": 600,
            "resume": True,
            "nessai_likelihood_constraint": True,
            "allow_multi_valued_likelihood": True,
        },
        "label": label,
        "outdir": str(args.outdir),
        "priors": prior_summary(priors),
    }
    payload = json.dumps(plan, indent=2, sort_keys=True, allow_nan=False) + "\n"
    plan_output = args.plan_output
    if plan_output is None and args.run_sampler:
        plan_output = args.outdir / f"{label}_plan.json"
    if plan_output:
        plan_output.parent.mkdir(parents=True, exist_ok=True)
        plan_output.write_text(payload, encoding="utf-8")
    print(payload, end="")

    if not args.run_sampler:
        return 0
    if plan["status"] != "ready":
        raise RuntimeError("Full sampler refused: all 235 locked events and injections must validate")

    event_objects = {}
    for path in event_paths:
        metadata, event_object = load_event(path, np, posterior_samples)
        event_objects[metadata["event"]] = event_object
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
    np.random.seed(args.seed)
    likelihood = hierarchical_likelihood(
        posterior_samples_catalog(event_objects),
        injection_object,
        rate_model,
        nparallel=args.nparallel,
        neffPE=args.neff_pe,
        neffINJ=None,
    )
    bilby.run_sampler(
        likelihood=likelihood,
        priors=priors,
        sampler="nessai",
        outdir=str(args.outdir),
        label=label,
        nlive=args.nlive,
        stopping=args.stopping,
        n_pool=args.n_pool,
        seed=args.seed,
        checkpoint_interval=600,
        resume=True,
        nessai_likelihood_constraint=True,
        allow_multi_valued_likelihood=True,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
