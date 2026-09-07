#!/usr/bin/env python3
"""Reproduce the quartic information-rate / bivector-count audit."""

from decimal import Decimal, getcontext
from math import factorial


getcontext().prec = 80


def root_of_degree(degree):
    """Positive root of x^degree-x-1 by high-precision Newton iteration."""
    x = Decimal("1.5") if degree < 4 else Decimal("1.2")
    d = Decimal(degree)
    for _ in range(100):
        x -= (x ** degree - x - 1) / (d * x ** (degree - 1) - 1)
    return x


def screening(root):
    residue = 1 - 1 / root
    return 1 - residue * residue


def choose(n, k):
    return factorial(n) // factorial(k) // factorial(n - k)


def reduce_quartic(coefficients):
    """Reduce an integer polynomial modulo x^4-x-1; ascending coefficients."""
    result = list(coefficients)
    while len(result) > 4:
        degree = len(result) - 1
        coefficient = result.pop()
        if coefficient:
            while len(result) <= degree - 3:
                result.append(0)
            result[degree - 4] += coefficient
            result[degree - 3] += coefficient
    while len(result) < 4:
        result.append(0)
    return result


def exact_sixth_power_numerator():
    """Numerator of S_Q^6 Q-1 after reduction modulo Q^4-Q-1."""
    coefficients = [0] * 13
    for k in range(7):
        coefficients[k + 1] += choose(6, k) * 2 ** k * (-1) ** (6 - k)
    coefficients[12] -= 1
    return reduce_quartic(coefficients)


def main():
    q = root_of_degree(4)
    s = screening(q)
    rate = -s.ln() / q.ln()

    print("quartic values")
    print("Q                         =", q)
    print("S_Q                       =", s)
    print("-log(S_Q)/log(Q)          =", rate)
    print("difference from 1/6       =", rate - Decimal(1) / Decimal(6))
    print("S_Q^6 Q - 1               =", s ** 6 * q - 1)
    print("S_Q^3 sqrt(Q) - 1         =", s ** 3 * q.sqrt() - 1)
    print("reduced numerator coeffs  =", exact_sixth_power_numerator())
    print()

    print("integer-exponent controls for S_Q^m Q - 1")
    nearest_other = None
    for exponent in range(1, 13):
        residual = s ** exponent * q - 1
        print("m={:2d}  {:+.18E}".format(exponent, residual))
        if exponent != 6:
            size = abs(residual)
            nearest_other = size if nearest_other is None else min(nearest_other, size)
    target_size = abs(s ** 6 * q - 1)
    print("nearest-other / target gap =", nearest_other / target_size)
    print()

    print("degree-family bivector controls")
    print("d  C(d,2)    S_d^C(d,2) r_d - 1       C(d,2)*rate - 1")
    for degree in range(2, 13):
        root = root_of_degree(degree)
        retained = screening(root)
        bivectors = degree * (degree - 1) // 2
        residual = retained ** bivectors * root - 1
        normalized_rate = -retained.ln() / root.ln()
        print(
            "{:2d} {:7d} {:+.18E} {:+.18E}".format(
                degree,
                bivectors,
                residual,
                Decimal(bivectors) * normalized_rate - 1,
            )
        )


if __name__ == "__main__":
    main()
