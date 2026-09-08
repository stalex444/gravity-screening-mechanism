# The quartic Perron carrier at an LQG horizon

## Result

The quartic inverse-step residual cannot itself be a static self-adjoint
horizon observable under a faithful adjoint-preserving representation.  The
part that can enter such an observable is its canonical left/right Perron
compression.

On the positive quartic root `Q`, Lean proves the following chain:

```text
full residual R_Q:
  R_Q^T != R_Q,
  R_Q^T R_Q != R_Q R_Q^T,
  D R_Q != R_Q^T D for every diagonal D with first weight nonzero;

Perron compression:
  <l_Q, R_Q r_Q>/<l_Q,r_Q> = lambda4 = 1 - 1/Q;

observable response:
  K_Q = [[1,lambda4],[lambda4,1]],
  K_Q^T = K_Q,
  det(K_Q) = 1-lambda4^2 = (2Q-1)/Q^2 = S_Q.
```

The capstone declaration is
`GravityScreening.quarticPerron_carrier_classification`.  The more general
representation obstruction is
`GravityScreening.quarticResidual_image_not_selfAdjoint`: for every injective
map `f` that preserves transpose,

```text
f(R_Q)^T != f(R_Q).
```

The transpose is the real finite-dimensional adjoint.  Thus the theorem tests
the minimum algebraic features of a faithful star representation.

## Exact history law and the nonsettling branch

The carrier interpretation is now dynamical rather than verbal.  For every
nonzero root `x` of `x^4=x+1`, Lean proves

```text
R_Q^n r_x = lambda4(x)^n r_x
```

for every natural-number step `n`.  On the positive root `Q`,

```text
0 < lambda4(Q) < 1,
lambda4(Q)^n -> 0.
```

The quartic polynomial also has a real conjugate `r` strictly between `-1`
and zero.  On that line,

```text
lambda4(r) = 1-1/r > 2,
R_Q^n r_r = lambda4(r)^n r_r.
```

The single theorem `quarticResidual_settle_escape_dichotomy` packages the
decaying positive line and the expanding negative-real line.  This prevents a
misreading of the Perron compression: the positive line settles, but the full
four-state quartic transfer system does not globally contract.  A calculable
local response and persistent off-Perron information coexist in the same
operator.

## Physical meaning

LQG area and flux quantities are represented by observables.  A physical area
operator must be self-adjoint.  The directed quartic residual fails that test
before any numerical Barbero--Immirzi value is chosen, and changing positive
diagonal coordinate weights cannot repair it.

This does not discard the quartic operator.  It determines where the operator
can live.  A directed, non-normal matrix naturally describes transfer,
transition, or modular evolution.  The measurable symmetric response is then
obtained after projecting that evolution onto its distinguished left and right
Perron modes.  That projection is not an arbitrary fit: its value is exactly
`lambda4`, and its two-channel determinant is exactly the previously derived
screening factor `S_Q`.

The proposed architecture is therefore

```text
quartic four-state history/transfer dynamics
                    |
                    | left/right Perron compression
                    v
       scalar lambda4 = 1 - 1/Q
                    |
                    v
self-adjoint Hodge-paired horizon response K_Q
                    |
                    v
          area/entropy determinant S_Q.
```

This is compatible with a collective horizon description in which many
puncture or flux degrees of freedom produce a thermodynamic area observable.
Ghosh, Noui, and Perez analyze precisely such a statistical horizon sector:
individual puncture-area fluctuations can remain large while total-area
fluctuations become small in the large-area regime.  That makes a collective
receiving sector more plausible than the single-puncture shortcut, which the
BI-free matching audit already showed would merely fix a particular Immirzi
value.

The exact Padovan four-symbol result belongs to a different role.  The
separately registered chiral-Padovan formalization proves that length three
still admits an orientation-ambiguous palindrome, while every allowed factor
of length at least four has a forbidden reversal.  Thus four is the cubic
history's exact local orientation threshold.  It is not being used here as a
quartic relaxation deadline.  The proposed joint reading is: the cubic
language supplies orientation, the quartic carrier supplies persistent
transfer plus its compressed response, and the `rho*Q` modular product
supplies the common clock scale.

## What the theorem rules out

It rules out a direct faithful identification of the complete directed
residual with a static self-adjoint area or flux matrix.  It also rules out
repairing that identification by a nondegenerate diagonal information metric.

It does not rule out a non-injective coarse graining, an open-system dilation,
or a representation of the residual as a generator or transfer operator.  It
does not prove that an LQG horizon realizes the quartic dynamics.  That final
physical bridge must intertwine the quartic modular flow with horizon boost
evolution and preserve the relevant state or KMS condition.

## Next exact construction

The remaining map has two levels.  On the full directed carrier it must be
boost covariant:

```text
iota(sigma_t^Q(B)) = alpha_t^boost(iota(B)).
```

On the observable quotient or compression it must send `lambda4` to the
Hodge-paired area/entropy response without changing the independently fixed
physical area normalization.  A candidate fails if it either turns the full
residual into a static self-adjoint observable or changes the quartic Perron
frequency.

This is now a well-posed representation problem rather than a search for an
Immirzi decimal.

## Primary sources

- E. Bianchi, *Entropy of Non-Extremal Black Holes from Loop Gravity*:
  <https://arxiv.org/abs/1204.5122>.
- A. Ghosh, K. Noui, and A. Perez, *Statistics, Holography, and Black Hole
  Entropy in Loop Quantum Gravity*: <https://arxiv.org/abs/1309.4563>.
- D. Pranzetti, *Geometric Temperature and Entropy of Quantum Isolated
  Horizons*: <https://arxiv.org/abs/1305.6714>.
- A. Ashtekar, J. Baez, and K. Krasnov, *Quantum Geometry of Isolated Horizons
  and Black Hole Entropy*: <https://arxiv.org/abs/gr-qc/0005126>.
