# Gravity screening at the four-dimensional marginal point

This repository isolates one open mechanism in Pisot Dimensional Theory (PDT):
why the gravitational response should contain the factor

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\qquad
\lambda_4=1-\frac1Q,
\qquad
Q^4=Q+1.
\]

It is an exploratory repository. It does not alter the PDT canon and it does
not claim that the physical screening mechanism has been derived.

## The useful result

The factor `1 - lambda^2` is the universal residual coefficient for a
normalized two-channel quadratic response:

\[
x^2+y^2-2\lambda xy
=(y-\lambda x)^2+(1-\lambda^2)x^2.
\]

Eliminating the second channel therefore leaves the Schur complement
`1 - lambda^2`. The same number is:

- the determinant of the normalized response matrix
  `[[1, -lambda], [-lambda, 1]]`;
- the squared norm left after orthogonally projecting one unit channel onto
  another with overlap `lambda`;
- the conditional variance of one standardized variable after conditioning on
  another with correlation `lambda`.

This supplies a real mechanism class for the square and the minus sign. If the
coefficient of a gravitational kinetic term is reduced by `S_Q`, its inverse
coupling is increased by `1/S_Q`, exactly the direction of the correction in
the PDT gravity formula.

## Why Ehrenfest matters

In `d` spatial dimensions, the Newtonian potential has radial homogeneity
`r^(2-d)`, while the centrifugal term has homogeneity `r^(-2)`. Their ratio is
`r^(4-d)`, so it is independent of radius only at `d = 4`.

Ehrenfest's marginal dimension therefore does something precise: it is the
unique dimension in which the gravitational and centrifugal responses can be
mixed by a scale-free, dimensionless constant without inserting another radial
scale. It explains where a pure-number response coefficient can live. It does
not determine that coefficient.

## The remaining physical question

The screening formula would follow from the quadratic response

\[
K_Q=\begin{pmatrix}1&-\lambda_4\\-\lambda_4&1\end{pmatrix}
\]

for a normalized geometric mode and a normalized four-dimensional response
mode. The decisive question is therefore:

> Does a curvature or kinetic expansion of the PDT action produce a positive
> two-channel response whose normalized off-diagonal coefficient is exactly
> `lambda4`?

The currently filed two-scalar potential does not do this at tree level. At
either axis vacuum its mixed Hessian entry is zero. At the nonzero mixed
stationary point in the bistable regime, the Hessian determinant is negative,
so it cannot be the positive Gram or Fisher matrix required by the projection
mechanism. The existing action therefore supplies the arithmetic coefficient
but not this response map.

The full curvature audit is stronger: the filed induced-gravity coefficient is
`f(phi,chi) = xi phi^2`, so the standard frame-covariant field metric has
exactly zero `phi`-`chi` kinetic entry. Together with the unbroken
`chi -> -chi` symmetry at `(v,0)`, this makes the tree-level normalized mixing
`c = 0`, not `lambda4`. See [`CURRENT_ACTION_AUDIT.md`](CURRENT_ACTION_AUDIT.md).

A more promising source is the minimal unitary completion of the Q-sector
residue contraction. On the positive eigenline of the founding quartic
companion matrix, `I-M_Q^(-1)` has the exact eigen-amplitude
`lambda4 = 1-1/Q`. Its minimal unitary completion has the unique defect weight
`1-lambda4^2`. This also produces exactly the square-root factor used by the
Planck-mass formula. The operator mathematics is exact; identifying its
complementary channel with gravity remains the decisive physical premise. See
[`UNITARY_DEFECT_MECHANISM.md`](UNITARY_DEFECT_MECHANISM.md).

The same matrix now supplies a sharper physical bridge. Its Cuntz--Krieger
algebra has a unique gauge-KMS equilibrium at inverse temperature `log Q`.
KMS detailed balance makes the normalized difference between a process and its
thermal reverse exactly `1-exp(-log Q) = lambda4`. Thus the residue is
simultaneously the renewal frequency, the inverse-step transfer eigenvalue, and
the canonical equilibrium causal-response defect. Embedding this graph flow
covariantly into a relativistic wedge algebra would complete the local-horizon
identification; that embedding has not yet been constructed. See
[`PERRON_HORIZON_AUDIT.md`](PERRON_HORIZON_AUDIT.md).

That negative result sharpens the next calculation. A successful derivation
must obtain the matrix from a kinetic or curvature sector, with its
normalization and reality conditions fixed independently. A different
coefficient, an indefinite response, or higher-order terms would falsify this
minimal mechanism.

## Contents

- [`DERIVATION.md`](DERIVATION.md) gives the mathematical and physical chain,
  with assumptions separated from consequences.
- [`CURRENT_ACTION_AUDIT.md`](CURRENT_ACTION_AUDIT.md) applies the decisive
  kinetic and curvature test to the deposited two-scalar action.
- [`UNITARY_DEFECT_MECHANISM.md`](UNITARY_DEFECT_MECHANISM.md) gives a
  norm-conserving channel mechanism for the square-root and screening factors.
- [`PHYSICAL_BRIDGE_AUDIT.md`](PHYSICAL_BRIDGE_AUDIT.md) tests the proposed
  horizon/gravity identification, gives the one-tick Hamiltonian, and records
  the neighboring-family and reverse controls.
- [`PERRON_HORIZON_AUDIT.md`](PERRON_HORIZON_AUDIT.md) proves the exact
  renewal-frequency theorem and reports the classical-horizon obstruction that
  localizes the remaining physical quantization rule.
- [`PQ_MODULAR_HORIZON.md`](PQ_MODULAR_HORIZON.md) proves that the joint cubic
  and quartic KMS factors have the hyperfinite type-`III_1` algebra required by
  a generic relativistic local region, while preserving the quartic response.
- [`GravityScreening/Basic.lean`](GravityScreening/Basic.lean) kernel-checks
  the algebraic core.
- [`verify.py`](verify.py) reproduces the exact quartic arithmetic using only
  the Python standard library.

## Reproduce

```bash
python3 verify.py
lake exe cache get
lake build
```

## Status

The arithmetic, Schur-complement identity, four-dimensional homogeneity
criterion, renewal-frequency identity, and KMS causal-response identity are
exact mathematics. The remaining physical hypothesis is the covariant
state-preserving embedding of the quartic graph dynamics into a local wedge
algebra; the filed two-scalar action does not yet supply it.
