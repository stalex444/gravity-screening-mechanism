#!/usr/bin/env python3
"""Numerical controls for the proposed Fisher interpretation of screening."""

from decimal import Decimal, getcontext


getcontext().prec = 70


def quartic_root():
    q = Decimal("1.22")
    for _ in range(50):
        q -= (q**4 - q - 1) / (4 * q**3 - 1)
    return q


def main():
    q = quartic_root()
    one = Decimal(1)
    beta = q.ln()
    omega = one
    reverse_ratio = one / q
    p_reverse = reverse_ratio / (one + reverse_ratio)
    binary_variance = p_reverse * (one - p_reverse)

    # z = beta*omega is the only identifiable combination.  The Fisher matrix
    # is Var(X) times grad(z) grad(z)^T.
    i_bb = binary_variance * omega**2
    i_bo = binary_variance * omega * beta
    i_oo = binary_variance * beta**2
    determinant = i_bb * i_oo - i_bo**2
    partial_beta = i_bb - i_bo**2 / i_oo
    correlation = i_bo / (i_bb * i_oo).sqrt()

    lambda4 = one - one / q
    target_survivor = one - lambda4**2

    assert abs(q**4 - q - one) < Decimal("1e-65")
    assert abs((one - (-beta * omega).exp()) - lambda4) < Decimal("1e-65")
    assert abs(determinant) < Decimal("1e-65")
    assert abs(partial_beta) < Decimal("1e-65")
    assert abs(correlation - one) < Decimal("1e-65")

    print(f"Q                                  = {q}")
    print(f"lambda4                            = {lambda4}")
    print(f"target Fisher correlation          = {lambda4}")
    print(f"target partial-information fraction= {target_survivor}")
    print(f"KMS beta                           = {beta}")
    print(f"KMS reverse probability            = {p_reverse}")
    print(f"KMS Fisher determinant             = {determinant}")
    print(f"KMS partial Fisher information     = {partial_beta}")
    print(f"KMS normalized score correlation   = {correlation}")
    print("independent pQ score correlation    = 0 EXACT")
    print("independent partial-info fraction   = 1 EXACT")
    print("canonical Fisher candidates         = DO NOT PRODUCE lambda4")


if __name__ == "__main__":
    main()
