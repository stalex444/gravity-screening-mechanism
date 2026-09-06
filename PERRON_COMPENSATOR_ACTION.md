# The Perron-compensator matching

## The derivation that survives the controls

The filed induced-gravity action contains the conformal coefficient

```text
(xi/2) phi^2 R[g],        xi=1/6,
```

so its curvature term is `phi^2 R[g]/12`.  The filed `phi` is the ordinary,
canonically normalized cubic-sector scalar that condenses at the classical
vacuum.

The quartic companion dynamics supplies a separate dimensionless response.
Let `M_Q` be the founding quartic companion matrix and let `r_Q` be its positive
Perron mode.  The exact inverse-step residue is

```text
(I-M_Q^(-1))r_Q = lambda4 r_Q,
lambda4 = 1-1/Q.
```

After the already verified left/right Perron normalization, its amplitude is
still exactly `lambda4`.  At the condensed vacuum, define the associated
gravitational response by

```text
s_Q(v) = lambda4 v.
```

The Lorentzian quadratic form on the background/time pair is the difference
of squares.  The proposed post-condensation curvature matching is therefore

```text
(1/12)[v^2-s_Q(v)^2]R[g]
  = (1/12)v^2(1-lambda4^2)R[g].
```

This is precisely

```text
(xi/2)v^2 Tr(a_Q^2)R[g]
```

because the global quartic trace form gives
`Tr(a_Q^2)=1-lambda4^2`.  Using `Q^4=Q+1`, the coefficient is also

```text
1-lambda4^2 = (2Q-1)/Q^2.
```

No new numerical parameter appears.  The value of the compensator is the
quartic inverse-step response, rather than a fitted scalar expectation value.

## Why this is a conformal-compensator structure

For a real scalar in four spacetime dimensions, the combination

```text
phi^2 R/12 + (partial phi)^2/2
```

is the standard locally Weyl-invariant unit.  In a two-coordinate conformal
completion, the gravitational coefficient occurs as a difference such as
`(phi^2-s^2)R/12`.  Bars, Steinhardt and Turok derive this relative minus sign
in their Weyl-invariant scalar-gravity construction and emphasize that the
extra scalar can be removed by the local scaling gauge.

The PDT use is narrower.  `s_Q(v)` is not identified with the filed propagating
quartic scalar `chi`, whose vacuum value is zero.  It is the proposed fixed
response of the quartic time direction to one inverse Perron step after the
cubic field has condensed.  The equation above is an infrared matching
condition, not an off-shell replacement of the filed scalar action.

## The field-normalization control

There is a serious trap.  Suppose the same constant `S_Q` multiplies both the
kinetic and curvature terms:

```text
S_Q[(partial phi)^2/2 + phi^2 R/12].
```

The canonical field is then `phi_c=sqrt(S_Q) phi`, and the action becomes

```text
(partial phi_c)^2/2 + phi_c^2 R/12.
```

The screening has disappeared.  A uniform algebra-valued lift is therefore a
field redefinition, not a prediction for Newton's constant.  The Lean theorem
`commonWeight_cancels` records this exactly.

The controlled interpretation avoids this cancellation by separating the two
stages:

```text
UV cubic condensation:      Z_phi = 1 and xi = 1/6,
IR metric matching:         F_Q   = 1-lambda4^2.
```

The invariant relative coefficient after canonical normalization is
`F_Q/Z_phi=1-lambda4^2`, proved by `curvatureOnlyWeight_survives`.  This is why
the quartic object must enter as a post-condensation metric or horizon response,
rather than as a common multiplier of the scalar kinetic multiplet.

## What has actually been derived

The following chain is now kernel-checked:

1. the quartic inverse-step residual has normalized Perron amplitude
   `lambda4`;
2. the quartic time observer is the normalized negative direction of the
   global quartic trace form;
3. subtracting the squared compensator gives `1-lambda4^2`;
4. the coefficient equals `(2Q-1)/Q^2` exactly;
5. inserting it into the induced Einstein coefficient gives the screened
   Planck square and inverse Newton response;
6. a common kinetic-and-curvature factor cancels, while a curvature-relative
   factor survives.

The new theorem `quarticPerron_compensator_curvature` connects steps 1, 3 and 4
in one statement.  The existing conditional Planck theorem then supplies
steps 5 and the numerical comparison.

## The remaining physical axiom

The filed action does not itself contain `s_Q`.  The completion therefore rests
on one physical sector assignment:

> After the cubic condensate generates the baseline Einstein coefficient, the
> normalized inverse-step residue of the quartic time direction supplies the
> nondynamical quadratic matching response of the metric sector.

This assignment is consistent with the paper's description of the cubic field
as the generator of classical spacetime and the quartic sector as the dynamics
that inhabits it.  It is also exactly the condition required to prevent the
screening from becoming a field-redefinition artifact.  It is not yet derived
from the filed two-scalar potential.

The next microscopic calculation is consequently specific: construct the
PDT metric effective action or horizon state count after condensation and show
that its two-derivative curvature coefficient is multiplied by
`1-lambda4^2`, while the already normalized scalar two-point residue is not.
A common factor on both terms rejects the mechanism.

## Relation to the literature

- I. Bars, P. Steinhardt and N. Turok, "Local Conformal Symmetry in Physics and
  Cosmology," *Physical Review D* **89**, 043515 (2014),
  <https://arxiv.org/abs/1307.1848>.
- D. I. Kaiser, "Conformal Transformations with Multiple Scalar Fields,"
  *Physical Review D* **81**, 084044 (2010),
  <https://arxiv.org/abs/1003.1159>.

These references establish the conformal scalar-gravity architecture and the
importance of canonical field normalization.  They do not identify the PDT
Perron residue with a gravitational compensator.
