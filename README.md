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

That negative result sharpens the next calculation. A successful derivation
must obtain the matrix from a kinetic or curvature sector, with its
normalization and reality conditions fixed independently. A different
coefficient, an indefinite response, or higher-order terms would falsify this
minimal mechanism.

## Contents

- [`DERIVATION.md`](DERIVATION.md) gives the mathematical and physical chain,
  with assumptions separated from consequences.
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

The arithmetic, Schur-complement identity, and four-dimensional homogeneity
criterion are exact mathematics. Identifying `lambda4` with a normalized
curvature or kinetic overlap is an open physical hypothesis.

