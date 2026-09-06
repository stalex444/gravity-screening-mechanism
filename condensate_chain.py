#!/usr/bin/env python3
"""Reproduce the conditional pQ -> condensate -> screened Planck chain.

The calculation uses only the Python standard library.  The physical inputs
are the 2022 CODATA electron and Planck mass energy equivalents.  The Planck
value is used only for the final comparison, never in the prediction.
"""

from decimal import Decimal, getcontext


getcontext().prec = 80
D = Decimal

PI = D(
    "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899"
)

# 2022 CODATA recommended values, expressed in GeV.
ELECTRON_MASS_GEV = D("0.51099895069e-3")
ELECTRON_MASS_SIGMA_GEV = D("0.00000000016e-3")
PLANCK_MASS_GEV = D("1.220890e19")
PLANCK_MASS_SIGMA_GEV = D("0.000014e19")


def positive_root(n: int) -> Decimal:
    """Positive root of x^n-x-1 by high-precision Newton iteration."""
    x = D("1.3")
    for _ in range(100):
        x -= (x**n - x - 1) / (D(n) * x ** (n - 1) - 1)
    return x


def main() -> None:
    rho = positive_root(3)
    q = positive_root(4)
    lambda4 = 1 - 1 / q
    survivor = 1 - lambda4**2
    amplitude = survivor.sqrt()

    # Conditional deposited baseline and the conformal induced-gravity chain.
    baseline_ratio = (rho * q) ** 112 / PI**2
    unscreened_planck = ELECTRON_MASS_GEV * baseline_ratio
    conformal_factor = (D(4) * PI / D(3)).sqrt()
    condensate = unscreened_planck / conformal_factor
    screened_planck = unscreened_planck * amplitude

    # Propagate the electron-mass uncertainty.  It is negligible beside the
    # current Planck-mass uncertainty, so unknown covariance cannot affect the
    # displayed two-decimal sigma score.
    unscreened_prediction_sigma = ELECTRON_MASS_SIGMA_GEV * baseline_ratio
    screened_prediction_sigma = unscreened_prediction_sigma * amplitude
    unscreened_combined_sigma = (
        PLANCK_MASS_SIGMA_GEV**2 + unscreened_prediction_sigma**2
    ).sqrt()
    screened_combined_sigma = (
        PLANCK_MASS_SIGMA_GEV**2 + screened_prediction_sigma**2
    ).sqrt()

    unscreened_relative = unscreened_planck / PLANCK_MASS_GEV - 1
    screened_relative = screened_planck / PLANCK_MASS_GEV - 1
    unscreened_sigma = (
        unscreened_planck - PLANCK_MASS_GEV
    ) / unscreened_combined_sigma
    screened_sigma = (
        screened_planck - PLANCK_MASS_GEV
    ) / screened_combined_sigma

    # The equivalent Newton-constant comparison follows from G proportional
    # to M_Pl^(-2), without importing a separate value of G.
    gravity_relative = (PLANCK_MASS_GEV / screened_planck) ** 2 - 1

    # Reverse audit: infer the screening that would be required by the two
    # measured mass scales, then compare it with the quartic value.
    required_survivor = (PLANCK_MASS_GEV / unscreened_planck) ** 2
    required_lambda = (1 - required_survivor).sqrt()
    required_survivor_relative_sigma = 2 * (
        (PLANCK_MASS_SIGMA_GEV / PLANCK_MASS_GEV) ** 2
        + (ELECTRON_MASS_SIGMA_GEV / ELECTRON_MASS_GEV) ** 2
    ).sqrt()
    required_survivor_sigma = (
        required_survivor * required_survivor_relative_sigma
    )
    survivor_score = (
        survivor - required_survivor
    ) / required_survivor_sigma

    assert abs(rho**3 - rho - 1) < D("1e-70")
    assert abs(q**4 - q - 1) < D("1e-70")
    assert abs(survivor - (2 * q - 1) / q**2) < D("1e-70")
    assert abs(
        screened_planck**2
        - (D(4) * PI / D(3)) * condensate**2 * survivor
    ) < D("1e-40") * screened_planck**2
    assert abs(screened_relative) < abs(unscreened_relative)

    print(f"rho                              = {rho}")
    print(f"Q                                = {q}")
    print(f"lambda4                          = {lambda4}")
    print(f"S_Q = 1-lambda4^2               = {survivor}")
    print(f"sqrt(S_Q)                        = {amplitude}")
    print(f"(rho Q)^112/pi^2                 = {baseline_ratio}")
    print(f"unscreened M_Pl,0 [GeV]          = {unscreened_planck}")
    print(f"predicted conformal v [GeV]      = {condensate}")
    print(f"screened M_Pl,Q [GeV]            = {screened_planck}")
    print(f"CODATA M_Pl [GeV]                = {PLANCK_MASS_GEV}")
    print(f"CODATA M_Pl sigma [GeV]          = {PLANCK_MASS_SIGMA_GEV}")
    print(f"unscreened signed deviation      = {100 * unscreened_relative}%")
    print(f"unscreened experimental score    = {unscreened_sigma} sigma")
    print(f"screened signed deviation        = {100 * screened_relative}%")
    print(f"screened experimental score      = {screened_sigma} sigma")
    print(f"equivalent signed G deviation    = {100 * gravity_relative}%")
    print(f"reverse-required S               = {required_survivor}")
    print(f"quartic S - required S           = {survivor - required_survivor}")
    print(f"reverse-required lambda          = {required_lambda}")
    print(f"quartic lambda - required lambda = {lambda4 - required_lambda}")
    print(f"reverse coefficient score        = {survivor_score} sigma")
    print("conditional condensate chain     = PASS")


if __name__ == "__main__":
    main()
