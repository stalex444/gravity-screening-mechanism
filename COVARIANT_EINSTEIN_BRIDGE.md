# A covariant Einstein-term bridge

**Refined scope.**  The safest reading of this bridge is as a constant
post-condensation matching of the infrared metric action.  A common off-shell
factor multiplying both scalar kinetic and curvature terms is removable by
canonical field normalization.  See [`POST_CONDENSATION_MATCHING.md`](POST_CONDENSATION_MATCHING.md)
and [`PERRON_COMPENSATOR_ACTION.md`](PERRON_COMPENSATOR_ACTION.md).

## The smallest completion of the existing action

The induced-gravity companion uses

```text
L_induced = (xi/2) phi^2 R[g]
```

and obtains its gravitational scale when the cubic field condenses at
`phi=v`.  The quartic field does not condense at the selected vacuum, so its
potential and portal Hessian cannot generate the proposed screening there.

The time-gravity trace calculation supplies a different kind of object: a
fixed dimensionless arithmetic background

```text
a_Q = 1/2 + (lambda4/6)(4Q-3Q^2)
```

whose genuine quartic trace square is

```text
Theta_Q = Tr(a_Q^2) = 1-lambda4^2.
```

The minimal scale-free completion of the filed curvature term is

```text
L_induced,Q = (xi/2) phi^2 Theta_Q R[g].
```

It changes no scalar-potential coefficient and adds no adjustable number.
At the selected vacuum,

```text
M_Pl,Q^2 = 8 pi xi v^2 Theta_Q
         = (1-lambda4^2) M_Pl,0^2,

G_Q      = G_0/(1-lambda4^2).
```

This is exactly the correction used in the deposited gravity calculation.

## Two metrics with two different jobs

The quartic trace matrix is constant, so as a coordinate metric it is flat and
cannot itself produce gravitational curvature.  The completion above respects
that result.

- `B(x,y)=Tr(xy)` is an internal arithmetic bilinear form.  It evaluates the
  fixed scalar `Theta_Q`.
- `g_mu_nu(x)` is the dynamical spacetime metric.  Its Ricci scalar `R[g]`
  supplies curvature.

The trace form fixes a coefficient of the curvature action; it is not being
substituted for the spacetime metric.  Consequently the established flatness
of the arithmetic trace matrix and the dynamics of general relativity do not
conflict.

## Why this is the natural two-derivative term

On the spacetime side, Lovelock's four-dimensional result says that, under the
usual locality, metric, divergence-free, and second-derivative assumptions,
the field equation is built from the Einstein tensor and the metric term.  At
the action level this selects the Einstein-Hilbert term, up to its overall
coefficient and a cosmological term.

On the arithmetic side, the kernel-verified theorem
`normalized_even_null_quadratic_forced` shows that a quadratic response which
is normalized at zero residue, even under reversal of the time direction, and
zero on the unit null direction is uniquely `1-t^2`.

These statements constrain different halves of the product:

```text
arithmetic scalar       spacetime curvature
Tr(a_Q^2)          x    R[g].
```

The first fixes the dimensionless response once the geometric premises are
adopted.  The second fixes the lowest-derivative metric dynamics under
Lovelock's assumptions.

## Observer independence

The explicit time construction chose `u=4Q-3Q^2`, but the coefficient does not
depend on that particular representative.  For any trace-zero time direction
`t` satisfying

```text
Tr(t^2)=-1,
Tr((1/2)t)=0,
```

bilinearity gives

```text
Tr((1/2+lambda4 t)^2)=1-lambda4^2.
```

The chosen `u/6` proves that such a direction exists and connects the formula
to the explicit clock and chronological cone.  The scalar coefficient itself
is invariant under changing to another normalized orthogonal time observer.

## What this resolves

This completion explains why the portal calculation returned zero mixing: the
screening is not produced by eliminating the non-condensing scalar.  It is a
constant arithmetic renormalization of the curvature coefficient.  The portal
still selects the cubic vacuum; the quartic trace response then tells the
induced Einstein term how much of the baseline geometric stiffness survives.

It also explains gravity-only selectivity at the action level.  `Theta_Q`
multiplies `R[g]`; the gauge and matter kinetic terms are not multiplied by it.

Because `a_Q` is fixed rather than a spacetime field, no derivatives of
`Theta_Q` appear in the metric equation, and this effective completion adds no
new propagating scalar or fifth-force mode.

## What remains a physical premise

The action is a consistent zero-parameter completion, not yet a microscopic
derivation.  General covariance permits many constants to multiply `R`, and
Lovelock's theorem does not determine that constant.  It also does not exclude
nonquadratic internal functions or higher-curvature operators.

The remaining premise is therefore precise:

> The dimensionless coefficient multiplying the cubic induced-gravity term is
> the normalized quadratic invariant of the quartic time response.

There is also a normalization caveat.  If `v` or the baseline Planck scale is
chosen from the measured value of `G`, `Theta_Q` can be absorbed into that
choice and has no predictive content.  The correction is evidential only when
the unscreened scale `M_Pl,0` is fixed independently by the PDT `rho Q` ruler
before the quartic factor is applied.

The two existing gravity presentations handle this point differently.  The
deposited Newton-constant paper writes the unscreened relation

```text
M_Pl,0/m_e = (rho Q)^112/pi^2
```

and then applies the quartic factor, giving

```text
M_Pl,Q/m_e = (rho Q)^112 sqrt(1-lambda4^2)/pi^2.
```

On that reading, `Theta_Q` cannot be absorbed without changing an independently
stated baseline prediction.  The induced-gravity companion instead describes
`v` as fixed by the observed Planck mass.  In that presentation alone, the
factor is reparametrizable.  A source-level PDT derivation therefore needs the
additional identification

```text
8 pi xi v^2 = M_Pl,0^2
```

with `M_Pl,0` obtained from the unscreened `rho Q` construction rather than
from the measured value of `G`.

## Decisive next test

A deeper PDT action should reproduce

```text
f(phi,Q) = xi phi^2 Tr(a_Q^2)
```

as its coefficient of `R[g]`.  The bridge fails if that construction yields a
different invariant, a nonlinear function of the trace norm, additional
curvature operators at the same order, or a coefficient that can only be fixed
using the observed value of `G`.

## Verification

`GravityScreening/Basic.lean` proves:

- `normalizedLorentzPair_weight`;
- `traceInducedPlanckSq_eq`;
- `traceInducedNewton_eq`.

The quartic trace identity used by these statements is separately proved by
`quarticTimeObserverResponse_sq` and checked by exact arithmetic in
`verify.py`.

## Reference

David Lovelock, "The Einstein Tensor and Its Generalizations," *Journal of
Mathematical Physics* **12** (1971), 498-501,
https://doi.org/10.1063/1.1665613.
