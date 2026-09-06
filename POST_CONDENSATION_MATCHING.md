# Post-condensation Einstein matching

## The correct level of the action

The filed ultraviolet action has an ordinary canonically normalized cubic
scalar and the conformal curvature coupling

```text
(xi/2) phi^2 R[g],        xi=1/6.
```

At the selected vacuum `phi=v`, `chi=0`, this generates the baseline Einstein
coefficient

```text
M_Pl,0^2 = 8 pi xi v^2 = (4 pi/3)v^2.
```

The quartic correction should be applied after this condensation.  Applying a
common quartic factor to both the off-shell scalar kinetic term and its
curvature term would merely rescale the scalar field and would leave their
relative coefficient unchanged.

## The infrared metric action

After the Planck-scale scalar fluctuations have been frozen or integrated out,
the proposed two-derivative metric action is

```text
S_IR = integral sqrt(-g)
       [M_Pl,0^2 Theta_Q R[g]/(16 pi) - Lambda_eff + higher derivatives],

Theta_Q = 1-lambda4^2.
```

The cubic condensate and `xi=1/6` have already generated `M_Pl,0`.  `Theta_Q`
is an infrared matching coefficient, not a replacement for `xi` in the
off-shell scalar theory.  The spacetime metric remains the dynamical field;
the arithmetic trace form supplies only the fixed dimensionless coefficient.

## Why this coefficient is unique

Let a normalized quadratic response of a background coordinate `x` and a time
coordinate `t` be

```text
Theta(x,t) = A x^2 + 2 B x t + C t^2.
```

Normalization at zero time response, invariance under time reversal, and a
unit null boundary force

```text
A=1, B=0, C=-1,
Theta(x,t)=x^2-t^2.
```

At `x=1` and `t=lambda4`,

```text
Theta_Q = 1-lambda4^2
        = Tr(a_Q^2)
        = (2Q-1)/Q^2.
```

The Lean theorems `normalized_even_null_quadratic_forced`,
`quarticTraceResponse_sq`, and `quarticPerron_compensator_curvature` verify this
chain exactly.

## Why the response belongs in the Einstein coefficient

Assume the matching response is local, generally covariant, dimensionless,
metric-sector only, and truncated at two derivatives.  In four dimensions its
constant scalar contribution can change the cosmological term or the
coefficient of `R[g]`.  A correction to the long-range Newton response belongs
to the latter.  The cosmological term remains a separate question.

This identifies the correct available slot for the coefficient.  It does not
derive the physical sector assignment.

## The one remaining microscopic premise

The remaining premise is now narrow:

> After the cubic condensate generates the baseline Einstein coefficient, the
> normalized inverse-step residue of the quartic time direction supplies the
> nondynamical quadratic matching response of the metric sector.

A microscopic calculation should derive a metric two-point or horizon response
of the form

```text
Gamma_metric^(2)[Q response]
  = (1-lambda4^2) Gamma_metric,0^(2).
```

If the same factor also multiplies the scalar kinetic residue, canonical
normalization removes the claimed screening.  If the coefficient is a different
fixed function of `rho` and `Q`, the deposited gravity prediction receives a
definite replacement.  Either outcome is decisive.

## Standard field-theory setting

Lovelock's four-dimensional result motivates the two-derivative Einstein slot.
Bars, Steinhardt and Turok exhibit the standard difference-of-squares conformal
scalar-gravity structure.  Kaiser explains why canonical normalization and
frame changes matter in multifield nonminimal coupling.  These results support
the form of the test; none proves the PDT matching premise.

## References

- D. Lovelock, "The Einstein Tensor and Its Generalizations," *Journal of
  Mathematical Physics* **12**, 498 (1971),
  <https://doi.org/10.1063/1.1665613>.
- I. Bars, P. Steinhardt and N. Turok, "Local Conformal Symmetry in Physics and
  Cosmology," *Physical Review D* **89**, 043515 (2014),
  <https://arxiv.org/abs/1307.1848>.
- D. I. Kaiser, "Conformal Transformations with Multiple Scalar Fields,"
  *Physical Review D* **81**, 084044 (2010),
  <https://arxiv.org/abs/1003.1159>.
