#!/usr/bin/env python3
"""Exact and numerical checks for the gravity-screening note.

No third-party package is required. Exact arithmetic takes place in
Q[q]/(q^4-q-1) with rational coefficients.
"""

import cmath
from decimal import Decimal, getcontext
from fractions import Fraction


class QElement:
    """Element of Q[q]/(q^4-q-1) in the basis 1,q,q^2,q^3."""

    def __init__(self, coeffs=(0, 0, 0, 0)):
        vals = list(coeffs)
        vals += [0] * (4 - len(vals))
        self.c = tuple(Fraction(v) for v in vals[:4])

    def __add__(self, other):
        other = as_qelement(other)
        return QElement(a + b for a, b in zip(self.c, other.c))

    __radd__ = __add__

    def __neg__(self):
        return QElement(-a for a in self.c)

    def __sub__(self, other):
        return self + (-as_qelement(other))

    def __rsub__(self, other):
        return as_qelement(other) - self

    def __mul__(self, other):
        other = as_qelement(other)
        raw = [Fraction(0) for _ in range(7)]
        for i, a in enumerate(self.c):
            for j, b in enumerate(other.c):
                raw[i + j] += a * b
        # q^k = q^(k-3) + q^(k-4), obtained from q^4=q+1.
        for k in range(6, 3, -1):
            raw[k - 3] += raw[k]
            raw[k - 4] += raw[k]
        return QElement(raw[:4])

    __rmul__ = __mul__

    def __pow__(self, n):
        if n < 0:
            raise ValueError("negative powers are not needed")
        out, base = QElement((1,)), self
        while n:
            if n & 1:
                out = out * base
            base = base * base
            n //= 2
        return out

    def __eq__(self, other):
        return self.c == as_qelement(other).c

    def __repr__(self):
        return f"QElement{self.c}"


def as_qelement(value):
    return value if isinstance(value, QElement) else QElement((value,))


def determinant(matrix):
    """Fraction-preserving Gaussian determinant."""
    a = [[Fraction(x) for x in row] for row in matrix]
    det = Fraction(1)
    for col in range(len(a)):
        pivot = next(r for r in range(col, len(a)) if a[r][col])
        if pivot != col:
            a[col], a[pivot] = a[pivot], a[col]
            det = -det
        p = a[col][col]
        det *= p
        for row in range(col + 1, len(a)):
            factor = a[row][col] / p
            for j in range(col, len(a)):
                a[row][j] -= factor * a[col][j]
    return det


def multiplication_matrix(a):
    basis = [QElement((1,)), QElement((0, 1)), QElement((0, 0, 1)), QElement((0, 0, 0, 1))]
    columns = [(a * b).c for b in basis]
    return [[columns[j][i] for j in range(4)] for i in range(4)]


def matrix_mul(a, b):
    return [
        [sum((a[i][k] * b[k][j] for k in range(len(b))), 0)
         for j in range(len(b[0]))]
        for i in range(len(a))
    ]


def matrix_vec_mul(a, v):
    return [sum((a[i][j] * v[j] for j in range(len(v))), QElement())
            for i in range(len(a))]


def positive_root_n(n):
    getcontext().prec = 70
    x = Decimal("1.5")
    one = Decimal(1)
    for _ in range(50):
        x -= (x**n - x - one) / (Decimal(n) * x**(n - 1) - one)
    return x


def positive_root_q():
    return positive_root_n(4)


def polynomial_roots_xn_x_1(n):
    """Durand-Kerner roots, used only for the printed spectral control."""
    roots = [1.4 * cmath.exp(2j * cmath.pi * k / n) for k in range(n)]
    for _ in range(200):
        updated = []
        for i, z in enumerate(roots):
            denom = 1
            for j, w in enumerate(roots):
                if i != j:
                    denom *= z - w
            updated.append(z - (z**n - z - 1) / denom)
        if max(abs(a - b) for a, b in zip(updated, roots)) < 1e-14:
            roots = updated
            break
        roots = updated
    return roots


def main():
    one = QElement((1,))
    q = QElement((0, 1))
    q_inv = q**3 - one
    assert q * q_inv == one

    lam = one - q_inv
    screen = one - lam**2
    assert lam == 2 - q**3
    assert screen == 3 * q**3 - q**2 - 3
    assert q**2 * screen == 2 * q - 1
    assert screen**4 + 3 * screen**3 - 2 * screen**2 + 22 * screen - 23 == 0

    norm_screen = determinant(multiplication_matrix(screen))
    assert norm_screen == -23

    screen_basis = [one, screen, screen**2, screen**3]
    change = [[screen_basis[j].c[i] for j in range(4)] for i in range(4)]
    assert determinant(change) == -241
    recovered_q = (293 - 63 * screen + 49 * screen**2 + 18 * screen**3) * Fraction(1, 241)
    assert recovered_q == q

    # The founding quartic substitution and its exact inverse.
    companion = [
        [0, 0, 0, 1],
        [1, 0, 0, 1],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
    ]
    companion_inv = [
        [-1, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
        [1, 0, 0, 0],
    ]
    identity = [[int(i == j) for j in range(4)] for i in range(4)]
    assert matrix_mul(companion, companion_inv) == identity
    assert matrix_mul(companion_inv, companion) == identity

    residual = [[identity[i][j] - companion_inv[i][j] for j in range(4)]
                for i in range(4)]
    perron = [one, q**3, q**2, q]
    assert matrix_vec_mul(companion, perron) == [q * x for x in perron]
    assert matrix_vec_mul(residual, perron) == [lam * x for x in perron]

    Q = positive_root_q()
    lambda4 = Decimal(1) - Decimal(1) / Q
    S = Decimal(1) - lambda4**2
    defect = S.sqrt()

    # Scalar Julia dilation [[lambda4, defect], [defect, -lambda4]].
    # Its row norms are one and its rows are orthogonal.
    row_norm = lambda4**2 + defect**2
    row_cross = lambda4 * defect + defect * (-lambda4)
    assert abs(row_norm - Decimal(1)) < Decimal("1e-65")
    assert abs(row_cross) < Decimal("1e-65")

    # The Julia block is also an involution, U^2=I.
    julia = [[lambda4, defect], [defect, -lambda4]]
    julia_sq = matrix_mul(julia, julia)
    assert abs(julia_sq[0][0] - Decimal(1)) < Decimal("1e-65")
    assert abs(julia_sq[0][1]) < Decimal("1e-65")
    assert abs(julia_sq[1][0]) < Decimal("1e-65")
    assert abs(julia_sq[1][1] - Decimal(1)) < Decimal("1e-65")

    # Family control: the construction is general. The n=4 selection must
    # come from the dimensional/Pisot boundary, not the defect identity alone.
    family = []
    for n in range(2, 7):
        r = positive_root_n(n)
        l = Decimal(1) - Decimal(1) / r
        family.append((n, r, l, Decimal(1) - l**2))
    assert abs(family[2][1] - Q) < Decimal("1e-65")

    quartic_residual_magnitudes = sorted(
        abs(1 - 1 / z) for z in polynomial_roots_xn_x_1(4)
    )
    assert sum(m < 1 for m in quartic_residual_magnitudes) == 1

    # Current-potential diagnostic: the mixed stationary Hessian is indefinite
    # in the PDT bistable regime.
    getcontext().prec = 70
    rho = Decimal("1.3247179572447460259609088544780973407344040569017")
    lambda3 = Decimal(1) - Decimal(1) / rho
    kappa = (Q / rho) ** 2
    bistability_ratio = kappa**2 / (Decimal(4) * lambda3 * lambda4)

    print(f"Q                         = {Q}")
    print(f"lambda4                   = {lambda4}")
    print(f"1 - lambda4^2             = {S}")
    print(f"sqrt(1 - lambda4^2)       = {defect}")
    print(f"1/(1 - lambda4^2)         = {Decimal(1) / S}")
    print(f"Julia row norm             = {row_norm}")
    print(f"Julia row cross-product    = {row_cross}")
    print("Julia block squared         = identity")
    print("companion inverse           = EXACT")
    print("residual Perron eigenvalue  = lambda4 EXACT")
    print(f"Norm_Q(Q)(1-lambda4^2)    = {norm_screen}")
    print("minimal polynomial         = x^4 + 3*x^3 - 2*x^2 + 22*x - 23")
    print("basis determinant          = -241")
    print("family control (n, root, residue, defect weight)")
    for n, r, l, s in family:
        print(f"  {n}: {r:.12f}  {l:.12f}  {s:.12f}")
    print("quartic residual magnitudes= " + ", ".join(
        f"{m:.12f}" for m in quartic_residual_magnitudes))
    print(f"kappa^2/(4 lambda3 lambda4)= {bistability_ratio}")
    print("portal mixed Hessian sign  = negative" if bistability_ratio > 1 else "portal diagnostic failed")
    print("all exact checks           = PASS")


if __name__ == "__main__":
    main()
