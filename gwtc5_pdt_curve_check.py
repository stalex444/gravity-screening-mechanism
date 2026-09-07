#!/usr/bin/env python3
"""Reproduce the quartic-transport comparison with the GWTC-5.0 cM posterior.

The script uses only the Python standard library.  Pass the official narrow-H0
posterior JSON downloaded from the GWTC-5.0 Zenodo record.  Its checksum is
verified before any posterior summary is reported.
"""

from __future__ import annotations

import argparse
from decimal import Decimal, getcontext
import hashlib
import json
import math
from pathlib import Path
from typing import Iterable


OFFICIAL_FILENAME = "icarogw_fullpop_spectral_cm_narrow.json"
OFFICIAL_MD5 = "5a6d4b63a48c383c07d654649700ee68"
OFFICIAL_URL = (
    "https://zenodo.org/api/records/20378418/files/"
    f"{OFFICIAL_FILENAME}/content"
)


def file_md5(path: Path) -> str:
    digest = hashlib.md5()  # noqa: S324 -- verifying a published data checksum
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def quartic_root() -> Decimal:
    """Positive root of q^4-q-1, by high-precision Newton iteration."""
    getcontext().prec = 80
    q = Decimal("1.22")
    for _ in range(30):
        q -= (q**4 - q - 1) / (4 * q**3 - 1)
    return +q


def quartic_constants() -> dict[str, Decimal]:
    q = quartic_root()
    lam = 1 - 1 / q
    screening = 1 - lam**2
    amplitude = screening.sqrt()
    response = 1 / amplitude
    beta = response.ln() / q.ln()
    return {
        "q": q,
        "lambda4": lam,
        "screening": screening,
        "amplitude": amplitude,
        "response": response,
        "beta": beta,
        "delta": -beta,
        "alpha_M": 2 * beta,
    }


def linear_quantile(sorted_values: list[float], probability: float) -> float:
    """NumPy-style linear quantile, implemented without a dependency."""
    position = probability * (len(sorted_values) - 1)
    lower = math.floor(position)
    upper = math.ceil(position)
    if lower == upper:
        return sorted_values[lower]
    weight = position - lower
    return sorted_values[lower] * (1 - weight) + sorted_values[upper] * weight


def simpson_integral(function, start: float, stop: float, intervals: int = 20000) -> float:
    """Composite Simpson integral with a fixed even interval count."""
    if intervals % 2:
        intervals += 1
    width = (stop - start) / intervals
    total = function(start) + function(stop)
    total += 4 * sum(function(start + width * i) for i in range(1, intervals, 2))
    total += 2 * sum(function(start + width * i) for i in range(2, intervals, 2))
    return total * width / 3


def gwtc5_cm_response(z: float, c_m: float, omega_m: float) -> float:
    """Distance ratio for alpha_M(z)=cM/E(z)^2 in flat LCDM."""
    def integrand(redshift: float) -> float:
        e_squared = omega_m * (1 + redshift) ** 3 + 1 - omega_m
        return 1 / ((1 + redshift) * e_squared)

    integral = simpson_integral(integrand, 0.0, z)
    return math.exp(0.5 * c_m * integral)


def posterior_cm_values(path: Path) -> list[float]:
    with path.open(encoding="utf-8") as stream:
        document = json.load(stream)
    values = document["posterior"]["content"]["cM"]
    return sorted(float(value) for value in values)


def format_decimal(value: Decimal, digits: int = 50) -> str:
    return f"{value:.{digits}f}"


def print_constants(constants: dict[str, Decimal]) -> None:
    print("Quartic transport constants")
    for name in ("q", "lambda4", "screening", "amplitude", "response", "beta", "delta", "alpha_M"):
        print(f"  {name:10s} = {format_decimal(constants[name])}")


def print_posterior_summary(values: list[float], pdt_c_m: float) -> None:
    percentile = 100 * sum(value <= pdt_c_m for value in values) / len(values)
    print("\nGWTC-5.0 narrow-H0 posterior")
    print(f"  equal-weighted samples = {len(values):,}")
    for probability in (0.025, 0.05, 0.16, 0.5, 0.84, 0.95, 0.975):
        print(f"  q({probability:5.3f})             = {linear_quantile(values, probability): .9f}")
    print(f"  PDT local cM          = {pdt_c_m: .15f}")
    print(f"  empirical percentile = {percentile:.4f}%")


def print_curve_comparison(beta: float, omega_m: float, redshifts: Iterable[float]) -> None:
    matched_c_m = 2 * beta
    print("\nFixed PDT curve versus the locally slope-matched GWTC cM ansatz")
    print(f"  Omega_m = {omega_m}")
    print("  z        PDT ratio       GWTC ratio      relative difference")
    for z in redshifts:
        pdt = (1 + z) ** beta
        gwtc = gwtc5_cm_response(z, matched_c_m, omega_m)
        relative = 100 * (pdt / gwtc - 1)
        print(f"  {z:5.2f}    {pdt: .10f}    {gwtc: .10f}      {relative: .6f}%")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("posterior", type=Path, help=f"path to {OFFICIAL_FILENAME}")
    parser.add_argument(
        "--allow-checksum-mismatch",
        action="store_true",
        help="continue with a nonofficial or modified posterior file",
    )
    parser.add_argument(
        "--omega-m",
        type=float,
        default=0.3065,
        help="flat-LCDM matter fraction used only for the curve comparison",
    )
    args = parser.parse_args()

    checksum = file_md5(args.posterior)
    if checksum != OFFICIAL_MD5 and not args.allow_checksum_mismatch:
        raise SystemExit(
            "Checksum mismatch. Expected the official GWTC-5.0 narrow-H0 file:\n"
            f"  filename: {OFFICIAL_FILENAME}\n"
            f"  source:   {OFFICIAL_URL}\n"
            f"  expected: {OFFICIAL_MD5}\n"
            f"  observed: {checksum}"
        )

    constants = quartic_constants()
    values = posterior_cm_values(args.posterior)
    print(f"Data checksum: {checksum}")
    print_constants(constants)
    beta = float(constants["beta"])
    print_posterior_summary(values, 2 * beta)
    print_curve_comparison(beta, args.omega_m, (0.01, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10))


if __name__ == "__main__":
    main()
