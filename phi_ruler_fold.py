#!/usr/bin/env python3
"""Reproduce the positive-embedding data for the phi <-> rho*Q fold."""

from decimal import Decimal, getcontext

getcontext().prec = 80


def positive_root(power: int, initial: Decimal) -> Decimal:
    x = initial
    for _ in range(80):
        f = x**power - x - 1
        derivative = power * x ** (power - 1) - 1
        next_x = x - f / derivative
        if next_x == x:
            return x
        x = next_x
    return x


rho = positive_root(3, Decimal("1.3"))
q = positive_root(4, Decimal("1.2"))
phi = (Decimal(1) + Decimal(5).sqrt()) / Decimal(2)
ruler = rho * q
golden_defect = ruler**2 - ruler - 1

print(f"rho                         = {rho}")
print(f"Q                           = {q}")
print(f"rho*Q                       = {ruler}")
print(f"phi                         = {phi}")
print(f"phi-rho*Q                   = {phi-ruler}")
print(f"relative gap                = {(phi-ruler)/phi}")
print(f"golden defect               = {golden_defect}")
print(f"other-conjugate compensation= {-Decimal(1)/golden_defect}")

assert abs(rho**3 - rho - 1) < Decimal("1e-70")
assert abs(q**4 - q - 1) < Decimal("1e-70")
assert golden_defect < 0
assert abs((phi - ruler) / phi - Decimal("0.000551520350345174503288755256246312855877536312313514403394682")) < Decimal("1e-60")
