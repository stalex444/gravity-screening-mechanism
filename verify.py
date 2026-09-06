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


def polynomial_remainder_mod2(dividend, divisor):
    """Remainder over F_2; coefficients are listed from low to high."""
    out = [coefficient % 2 for coefficient in dividend]
    while out and out[-1] == 0:
        out.pop()
    while len(out) >= len(divisor):
        shift = len(out) - len(divisor)
        for i, coefficient in enumerate(divisor):
            out[i + shift] ^= coefficient % 2
        while out and out[-1] == 0:
            out.pop()
    return out


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


def beta_parry_hole_measure(beta, steps=400):
    """Parry measure of (1/beta,1] from its standard invariant density sum."""
    one = Decimal(1)
    cutoff = one / beta
    orbit = one
    weight = one
    normalizer = Decimal(0)
    hole_mass = Decimal(0)
    for _ in range(steps):
        normalizer += weight * orbit
        if orbit > cutoff:
            hole_mass += weight * (orbit - cutoff)
        orbit = (beta * orbit) % one
        weight /= beta
    return hole_mass / normalizer


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

    # The first Perron coordinate, normalized by total letter frequency, is
    # lambda4: lambda4 * (1+q+q^2+q^3) = 1 exactly.
    perron_mass = one + q + q**2 + q**3
    assert lam * perron_mass == one

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

    # M^10 is strictly positive, so the substitution is primitive.
    companion_power = identity
    for _ in range(10):
        companion_power = matrix_mul(companion_power, companion)
    assert all(x > 0 for row in companion_power for x in row)

    # The cubic founding graph is primitive as well. Together with the quartic
    # graph, it supplies the two discrete KMS factor scales used in the pQ
    # type-III_1 completion argument.
    cubic_companion = [
        [0, 0, 1],
        [1, 0, 1],
        [0, 1, 0],
    ]
    cubic_identity = [[int(i == j) for j in range(3)] for i in range(3)]
    cubic_power = cubic_identity
    for _ in range(5):
        cubic_power = matrix_mul(cubic_power, cubic_companion)
    assert all(x > 0 for row in cubic_power for x in row)

    # Over F_2, x^4+x+1 has no linear root and has remainder 1 on division by
    # the only monic irreducible quadratic x^2+x+1. This certifies the degree-4
    # field used in the coprime-degree multiplicative-independence proof.
    assert all((x**4 + x + 1) % 2 for x in (0, 1))
    assert polynomial_remainder_mod2(
        [1, 1, 0, 0, 1], [1, 1, 1]
    ) == [1]

    residual = [[identity[i][j] - companion_inv[i][j] for j in range(4)]
                for i in range(4)]
    perron = [one, q**3, q**2, q]
    assert matrix_vec_mul(companion, perron) == [q * x for x in perron]
    assert matrix_vec_mul(residual, perron) == [lam * x for x in perron]
    residual_transpose = [list(row) for row in zip(*residual)]
    left_perron = [one, q, q**2, q**3]
    assert matrix_vec_mul(residual_transpose, left_perron) == [
        lam * x for x in left_perron
    ]
    perron_pairing = sum(
        (left_perron[i] * perron[i] for i in range(4)), QElement()
    )
    assert perron_pairing == 3 * q + 4
    paired_residual = sum(
        (
            left_perron[i] * matrix_vec_mul(residual, perron)[i]
            for i in range(4)
        ),
        QElement(),
    )
    assert paired_residual == lam * perron_pairing
    assert matrix_mul(residual_transpose, residual) != matrix_mul(
        residual, residual_transpose
    )

    Q = positive_root_q()
    lambda4 = Decimal(1) - Decimal(1) / Q
    S = Decimal(1) - lambda4**2
    defect = S.sqrt()

    # The graph gauge dynamics has Perron inverse temperature log(Q). KMS
    # detailed balance then gives reverse/forward = exp(-log(Q)) = 1/Q,
    # so its normalized causal-response defect is exactly lambda4.
    beta_q = Q.ln()
    kms_reverse_factor = (-beta_q).exp()
    kms_response_defect = Decimal(1) - kms_reverse_factor
    assert abs(kms_reverse_factor - Decimal(1) / Q) < Decimal("1e-65")
    assert abs(kms_response_defect - lambda4) < Decimal("1e-65")

    # The dual action on the continuous core scales its canonical trace by
    # exp(-s).  At s=log(Q), one step retains 1/Q.  The complement of the
    # twice-applied defect is 2*T_Q-T_Q^2 and reproduces the gravity factor.
    core_trace_one_step = (-beta_q).exp()
    core_trace_two_steps = (-Decimal(2) * beta_q).exp()
    core_trace_defect = Decimal(1) - core_trace_one_step
    core_self_defect_survivor = (
        Decimal(2) * core_trace_one_step - core_trace_two_steps
    )
    assert abs(core_trace_one_step - Decimal(1) / Q) < Decimal("1e-65")
    assert abs(core_trace_defect - lambda4) < Decimal("1e-65")
    assert abs(core_self_defect_survivor - S) < Decimal("1e-65")

    # On a Lorentzian Hodge pair the affine chiral stiffnesses are 1+lambda4
    # and 1-lambda4. Their determinant is S, while the orientation-even mean
    # inverse response is exactly 1/S. A determinant over all three chiral
    # pairs would instead produce S^3.
    chiral_plus = Decimal(1) + lambda4
    chiral_minus = Decimal(1) - lambda4
    chiral_pair_det = chiral_plus * chiral_minus
    chiral_even_compliance = (
        Decimal(1) / chiral_plus + Decimal(1) / chiral_minus
    ) / Decimal(2)
    full_bivector_det = chiral_plus**3 * chiral_minus**3
    assert abs(chiral_pair_det - S) < Decimal("1e-65")
    assert abs(chiral_even_compliance - Decimal(1) / S) < Decimal("1e-65")
    assert abs(full_bivector_det - S**3) < Decimal("1e-65")

    # Real doubled Hodge action.  For J(x1,x2)=(-x2,x1), the auxiliary
    # stationary point y=-lambda4*Jx leaves stiffness S on the sourced mode.
    x1, x2 = Decimal("0.7"), Decimal("-0.3")
    y1, y2 = Decimal("0.2"), Decimal("0.5")
    norm_x = x1**2 + x2**2
    norm_y = y1**2 + y2**2
    hodge_cross = x1 * y2 - x2 * y1
    doubled_kinetic = norm_x + norm_y + Decimal(2) * lambda4 * hodge_cross
    completed_doubled = (
        (y1 - lambda4 * x2) ** 2
        + (y2 + lambda4 * x1) ** 2
        + S * norm_x
    )
    assert abs(doubled_kinetic - completed_doubled) < Decimal("1e-65")

    stationary_y1 = lambda4 * x2
    stationary_y2 = -lambda4 * x1
    stationary_kinetic = (
        norm_x
        + stationary_y1**2
        + stationary_y2**2
        + Decimal(2)
        * lambda4
        * (x1 * stationary_y2 - x2 * stationary_y1)
    )
    assert abs(stationary_kinetic - S * norm_x) < Decimal("1e-65")

    j1, j2 = Decimal("0.6"), Decimal("-0.4")
    response_x1, response_x2 = j1 / S, j2 / S
    response_y1 = lambda4 * response_x2
    response_y2 = -lambda4 * response_x1
    assert abs(response_x1 + lambda4 * response_y2 - j1) < Decimal("1e-65")
    assert abs(response_x2 - lambda4 * response_y1 - j2) < Decimal("1e-65")
    assert abs(response_y1 - lambda4 * response_x2) < Decimal("1e-65")
    assert abs(response_y2 + lambda4 * response_x1) < Decimal("1e-65")

    # A global rescaling of a semifinite trace does not multiply normalized
    # entropy. The same state has density p/c relative to c*tau, so its
    # entropy shifts only by log(c). The shift cancels from differences.
    state1 = [Decimal("0.2"), Decimal("0.3"), Decimal("0.5")]
    state2 = [Decimal("0.1"), Decimal("0.4"), Decimal("0.5")]

    def entropy(state):
        return -sum((p * p.ln() for p in state), Decimal(0))

    def entropy_after_trace_rescale(state, c):
        return -sum(
            (c * (p / c) * (p / c).ln() for p in state), Decimal(0)
        )

    entropy1 = entropy(state1)
    entropy2 = entropy(state2)
    entropy1_scaled_trace = entropy_after_trace_rescale(state1, S)
    entropy2_scaled_trace = entropy_after_trace_rescale(state2, S)
    assert abs(
        entropy1_scaled_trace - entropy1 - S.ln()
    ) < Decimal("1e-65")
    assert abs(
        (entropy1_scaled_trace - entropy2_scaled_trace)
        - (entropy1 - entropy2)
    ) < Decimal("1e-65")

    # Conditional Jacobson algebra with an arbitrary nonzero baseline density.
    # If an independent physical mechanism gives eta -> S*eta, it forces
    # G -> G/S and M_P^2 -> S*M_P^2. Trace normalization alone does not
    # establish the premise, as the calculation above proves.
    eta0 = Decimal("2.375")
    eta_q = S * eta0
    gravity0 = Decimal(1) / (Decimal(4) * eta0)
    gravity_q = Decimal(1) / (Decimal(4) * eta_q)
    planck_sq0 = Decimal(1) / gravity0
    planck_sq_q = Decimal(1) / gravity_q
    assert abs(gravity_q - gravity0 / S) < Decimal("1e-65")
    assert abs(planck_sq_q - S * planck_sq0) < Decimal("1e-65")

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

    parry_hole = beta_parry_hole_measure(Q)
    # The canonical invariant beta measure does not supply the gravity square.
    assert abs(parry_hole - lambda4) > Decimal("0.01")
    assert abs(parry_hole - lambda4**2) > Decimal("0.01")

    # Current-potential diagnostic: the mixed stationary Hessian is indefinite
    # in the PDT bistable regime.
    getcontext().prec = 70
    rho = Decimal("1.3247179572447460259609088544780973407344040569017")
    lambda3 = Decimal(1) - Decimal(1) / rho
    chi = Q / rho
    kappa = chi**2
    bistability_ratio = kappa**2 / (Decimal(4) * lambda3 * lambda4)
    chi_scaled_screen = Decimal(1) - (chi * lambda4) ** 2
    kappa_scaled_screen = Decimal(1) - (kappa * lambda4) ** 2
    assert abs(chi_scaled_screen - S) > Decimal("0.001")
    assert abs(kappa_scaled_screen - S) > Decimal("0.001")

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
    print("left/right residual readout  = lambda4 EXACT")
    print("quartic residual normality   = NON-NORMAL EXACT")
    print("renewal-symbol frequency    = lambda4 EXACT")
    print(f"KMS inverse temperature     = {beta_q}")
    print(f"KMS reverse/forward factor  = {kms_reverse_factor}")
    print("KMS causal response defect  = lambda4 EXACT")
    print("core Q-step trace ratio      = 1/Q EXACT")
    print("core Q-step trace defect     = lambda4 EXACT")
    print("core self-defect survivor    = 1-lambda4^2 EXACT")
    print("Hodge-pair determinant       = 1-lambda4^2 EXACT")
    print("Hodge even inverse response  = 1/(1-lambda4^2) EXACT")
    print("full bivector determinant    = (1-lambda4^2)^3 EXACT")
    print("real doubled-action response = 1/(1-lambda4^2) EXACT")
    print("trace-normalization entropy  = shifts by log(survivor)")
    print("entropy-difference response  = unchanged EXACT")
    print("conditional Jacobson G rule  = divide by survivor EXACT")
    print("conditional Planck-square rule= multiply by survivor EXACT")
    print("companion matrix primitive  = M^10 strictly positive")
    print("cubic matrix primitive      = M^5 strictly positive")
    print("founding field degrees      = 3 and 4 (coprime)")
    print(f"Norm_Q(Q)(1-lambda4^2)    = {norm_screen}")
    print("minimal polynomial         = x^4 + 3*x^3 - 2*x^2 + 22*x - 23")
    print("basis determinant          = -241")
    print("family control (n, root, residue, defect weight)")
    for n, r, l, s in family:
        print(f"  {n}: {r:.12f}  {l:.12f}  {s:.12f}")
    print("quartic residual magnitudes= " + ", ".join(
        f"{m:.12f}" for m in quartic_residual_magnitudes))
    print(f"Parry measure of beta hole = {parry_hole}")
    print("classical horizon measure  = not lambda4 and not lambda4^2")
    print(f"chi-scaled Hodge survivor = {chi_scaled_screen} (wrong)")
    print(f"kappa-scaled survivor     = {kappa_scaled_screen} (wrong)")
    print(f"kappa^2/(4 lambda3 lambda4)= {bistability_ratio}")
    print("portal mixed Hessian sign  = negative" if bistability_ratio > 1 else "portal diagnostic failed")
    print("all exact checks           = PASS")


if __name__ == "__main__":
    main()
