#!/usr/bin/env python3
"""Compare the fixed PDT local slope with GR in released GWTC-5 posteriors.

This is a sharp-hypothesis comparison *inside the LVK cM/E(z)^2 model*.
Because the published cM prior is uniform, the marginal posterior-density
ratio at cM = alpha_M,Q and cM = 0 equals the nuisance-marginalized
likelihood ratio for those two fixed cM values.  It is not a likelihood
evaluation of the distinct constant-alpha_M PDT curve.

The calculation uses only the Python standard library and verifies the
official Zenodo checksums before reporting a result.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path
import random
import statistics
from typing import Iterable

from gwtc5_pdt_curve_check import linear_quantile, quartic_constants


OFFICIAL_RESULTS = {
    "icarogw_fullpop_spectral_cm_narrow.json": {
        "label": "narrow H0 prior [65, 77]",
        "md5": "5a6d4b63a48c383c07d654649700ee68",
    },
    "icarogw_fullpop_spectral_cm_wide.json": {
        "label": "wide H0 prior [10, 120]",
        "md5": "91a6271ae03770f3616baf79719cf0c2",
    },
}
ZENODO_RECORD = "https://zenodo.org/records/20378418"
SQRT_TWO_PI = math.sqrt(2 * math.pi)


def file_md5(path: Path) -> str:
    digest = hashlib.md5()  # noqa: S324 -- published-data integrity check
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def uniform_prior_bounds(document: dict, parameter: str) -> tuple[float, float]:
    prior = document["priors"][parameter]
    if prior.get("__name__") != "Uniform":
        raise ValueError(
            f"The {parameter} prior is not uniform, so the density ratio needs a prior correction."
        )
    return float(prior["kwargs"]["minimum"]), float(prior["kwargs"]["maximum"])


def load_posterior(
    path: Path,
) -> tuple[list[float], list[float], tuple[float, float], tuple[float, float]]:
    with path.open(encoding="utf-8") as stream:
        document = json.load(stream)

    content = document["posterior"]["content"]
    cm_values = [float(value) for value in content["cM"]]
    h0_values = [float(value) for value in content["H0"]]
    if not cm_values or len(cm_values) != len(h0_values):
        raise ValueError("The posterior contains no cM samples.")
    return (
        cm_values,
        h0_values,
        uniform_prior_bounds(document, "cM"),
        uniform_prior_bounds(document, "H0"),
    )


def gaussian_kde_density(values: Iterable[float], point: float, bandwidth: float) -> float:
    values = list(values)
    scaled_sum = math.fsum(
        math.exp(-0.5 * ((point - value) / bandwidth) ** 2) for value in values
    )
    return scaled_sum / (len(values) * bandwidth * SQRT_TWO_PI)


def scott_bandwidth(values: list[float], multiplier: float = 1.0) -> float:
    return statistics.stdev(values) * len(values) ** (-1 / 5) * multiplier


def density_ratio(
    values: list[float], numerator_point: float, denominator_point: float, multiplier: float
) -> float:
    bandwidth = scott_bandwidth(values, multiplier)
    numerator = gaussian_kde_density(values, numerator_point, bandwidth)
    denominator = gaussian_kde_density(values, denominator_point, bandwidth)
    return numerator / denominator


def correlation(xs: list[float], ys: list[float]) -> float:
    mean_x = math.fsum(xs) / len(xs)
    mean_y = math.fsum(ys) / len(ys)
    numerator = math.fsum((x - mean_x) * (y - mean_y) for x, y in zip(xs, ys))
    denominator = math.sqrt(
        math.fsum((x - mean_x) ** 2 for x in xs)
        * math.fsum((y - mean_y) ** 2 for y in ys)
    )
    return numerator / denominator


def gaussian_kde_2d_density(
    xs: list[float],
    ys: list[float],
    point_x: float,
    point_y: float,
    multiplier: float,
) -> float:
    """Two-dimensional Scott KDE matching scipy.stats.gaussian_kde."""
    sample_size = len(xs)
    mean_x = math.fsum(xs) / len(xs)
    mean_y = math.fsum(ys) / len(ys)
    denominator = sample_size - 1
    covariance_xx = math.fsum((x - mean_x) ** 2 for x in xs) / denominator
    covariance_yy = math.fsum((y - mean_y) ** 2 for y in ys) / denominator
    covariance_xy = math.fsum(
        (x - mean_x) * (y - mean_y) for x, y in zip(xs, ys)
    ) / denominator

    factor = sample_size ** (-1 / 6) * multiplier
    variance_x = factor**2 * covariance_xx
    variance_y = factor**2 * covariance_yy
    covariance = factor**2 * covariance_xy
    determinant = variance_x * variance_y - covariance**2
    inverse_xx = variance_y / determinant
    inverse_yy = variance_x / determinant
    inverse_xy = -covariance / determinant

    kernel_sum = math.fsum(
        math.exp(
            -0.5
            * (
                inverse_xx * (point_x - x) ** 2
                + 2 * inverse_xy * (point_x - x) * (point_y - y)
                + inverse_yy * (point_y - y) ** 2
            )
        )
        for x, y in zip(xs, ys)
    )
    return kernel_sum / (sample_size * 2 * math.pi * math.sqrt(determinant))


def joint_density_ratio(
    h0_values: list[float],
    cm_values: list[float],
    numerator: tuple[float, float],
    denominator: tuple[float, float],
    multiplier: float,
) -> float:
    numerator_density = gaussian_kde_2d_density(
        h0_values, cm_values, numerator[0], numerator[1], multiplier
    )
    denominator_density = gaussian_kde_2d_density(
        h0_values, cm_values, denominator[0], denominator[1], multiplier
    )
    return numerator_density / denominator_density


def bootstrap_log_ratios(
    values: list[float],
    numerator_point: float,
    denominator_point: float,
    repetitions: int,
    seed: int,
) -> list[float]:
    rng = random.Random(seed)
    sample_size = len(values)
    output: list[float] = []
    for _ in range(repetitions):
        resample = rng.choices(values, k=sample_size)
        output.append(
            math.log(density_ratio(resample, numerator_point, denominator_point, 1.0))
        )
    return sorted(output)


def analyze(
    path: Path,
    repetitions: int,
    seed: int,
    allow_mismatch: bool,
    early_h0: float,
) -> None:
    specification = OFFICIAL_RESULTS.get(path.name)
    if specification is None and not allow_mismatch:
        expected = ", ".join(OFFICIAL_RESULTS)
        raise SystemExit(f"Unrecognized filename {path.name!r}; expected {expected}.")

    checksum = file_md5(path)
    if specification is not None and checksum != specification["md5"] and not allow_mismatch:
        raise SystemExit(
            f"Checksum mismatch for {path.name}.\n"
            f"  source:   {ZENODO_RECORD}\n"
            f"  expected: {specification['md5']}\n"
            f"  observed: {checksum}"
        )

    cm_values, h0_values, cm_bounds, h0_bounds = load_posterior(path)
    constants = quartic_constants()
    q = float(constants["q"])
    # Positive root of rho^3-rho-1 by ordinary Newton iteration.  Double
    # precision is ample for posterior-density evaluation.
    rho = 1.32
    for _ in range(20):
        rho -= (rho**3 - rho - 1) / (3 * rho**2 - 1)
    chi = q / rho
    pdt_h0 = early_h0 / chi
    pdt_cm = float(constants["alpha_M"])
    if not (cm_bounds[0] < 0 < cm_bounds[1] and cm_bounds[0] < pdt_cm < cm_bounds[1]):
        raise ValueError("Both sharp hypotheses must lie inside the published cM prior.")
    if not (h0_bounds[0] < early_h0 < h0_bounds[1] and h0_bounds[0] < pdt_h0 < h0_bounds[1]):
        raise ValueError("Both H0 benchmark points must lie inside the published H0 prior.")

    label = specification["label"] if specification else path.name
    print(f"\n{label}")
    print(f"  file                         = {path.name}")
    print(f"  checksum                     = {checksum}")
    print(f"  equal-weight posterior size  = {len(cm_values):,}")
    print(f"  uniform cM prior             = [{cm_bounds[0]}, {cm_bounds[1]}]")
    print(f"  uniform H0 prior             = [{h0_bounds[0]}, {h0_bounds[1]}]")
    print(f"  GR sharp value               = 0")
    print(f"  PDT local-slope sharp value  = {pdt_cm:.15f}")
    print("  ratio definition             = p(cM=PDT | data) / p(cM=0 | data)")
    print("  (uniform prior makes this the nuisance-marginalized likelihood ratio)")

    print("\n  KDE bandwidth sensitivity")
    print("    Scott multiplier    PDT/GR ratio       log ratio")
    for multiplier in (0.5, 0.75, 1.0, 1.25, 1.5, 2.0):
        ratio = density_ratio(cm_values, pdt_cm, 0.0, multiplier)
        print(f"         {multiplier:4.2f}           {ratio: .9f}      {math.log(ratio): .9f}")

    if repetitions:
        logs = bootstrap_log_ratios(cm_values, pdt_cm, 0.0, repetitions, seed)
        q025 = linear_quantile(logs, 0.025)
        q50 = linear_quantile(logs, 0.5)
        q975 = linear_quantile(logs, 0.975)
        print(f"\n  Scott-KDE bootstrap ({repetitions} resamples; seed {seed})")
        print(f"    median PDT/GR ratio        = {math.exp(q50):.9f}")
        print(f"    95% resampling interval    = [{math.exp(q025):.9f}, {math.exp(q975):.9f}]")

    print("\n  Hubble-gravity joint point")
    print(f"    chi = Q/rho                = {chi:.15f}")
    print(f"    early-universe benchmark   = {early_h0:.9f}")
    print(f"    PDT present H0             = {pdt_h0:.9f}")
    print(f"    sample corr(H0, cM)        = {correlation(h0_values, cm_values):.9f}")
    print("    point A (PDT)              = (H0=PDT present, cM=PDT slope)")
    print("    point B (same-H0 GR)       = (H0=PDT present, cM=0)")
    print("    point C (early-H0 GR)      = (H0=early benchmark, cM=0)")
    print("\n    Scott multiplier      density A/B       density A/C")
    for multiplier in (0.5, 0.75, 1.0, 1.25, 1.5, 2.0):
        pdt_point = (pdt_h0, pdt_cm)
        same_h0_gr = (pdt_h0, 0.0)
        early_h0_gr = (early_h0, 0.0)
        ratio_same_h0 = joint_density_ratio(
            h0_values, cm_values, pdt_point, same_h0_gr, multiplier
        )
        ratio_full_point = joint_density_ratio(
            h0_values, cm_values, pdt_point, early_h0_gr, multiplier
        )
        print(f"         {multiplier:4.2f}             {ratio_same_h0: .9f}      {ratio_full_point: .9f}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "posteriors",
        nargs="+",
        type=Path,
        help="one or both official icarogw cM posterior JSON files",
    )
    parser.add_argument(
        "--bootstrap",
        type=int,
        default=500,
        help="number of deterministic nonparametric bootstrap resamples (default: 500)",
    )
    parser.add_argument("--seed", type=int, default=20260907)
    parser.add_argument(
        "--early-h0",
        type=float,
        default=67.4,
        help="early-universe H0 benchmark mapped by H0_present=H0_early/(Q/rho)",
    )
    parser.add_argument("--allow-checksum-mismatch", action="store_true")
    args = parser.parse_args()

    if args.bootstrap < 0:
        parser.error("--bootstrap must be nonnegative")
    for index, path in enumerate(args.posteriors):
        analyze(
            path,
            args.bootstrap,
            args.seed + index,
            args.allow_checksum_mismatch,
            args.early_h0,
        )


if __name__ == "__main__":
    main()
