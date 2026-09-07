# The two-dimensional information-area bridge

## Main result

The quartic erasure channel already supplies the horizon area-density power
that the Jacobson placement audit requires.  No additional squaring rule has
to be inserted if the microscopic horizon density is measured by the local
information-volume form.

For a two-parameter family of horizon-cell states, let

\[
g_{ab}=g^{\rm BKM}(X_a,X_b),\qquad a,b\in\{1,2\},
\]

be the pullback of the BKM information metric.  The fixed-erasure identity
gives the full bilinear relation

\[
g'_{ab}=s\,g_{ab}.
\]

It follows that

\[
\det g'=s^2\det g
\]

and, for the positive information-area element,

\[
\boxed{dA_{\rm info}'=\sqrt{\det g'}\,d^2x
=s\sqrt{\det g}\,d^2x=s\,dA_{\rm info}.}
\]

At the quartic value `s=S_Q`, the information area therefore contracts by
exactly

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

The new Lean module `GravityScreening/InformationArea.lean` proves the Fisher
cross-term scaling, the determinant law, the square-root area law, and the
quartic specialization.  This goes beyond checking the norm of one tangent:
the complete two-dimensional metric, including its off-diagonal entry, is
scaled uniformly.

## Why two dimensions matter

If a metric on an `m`-dimensional parameter surface is multiplied by `s`, its
volume form is multiplied by `s^(m/2)`.  A causal-horizon cross-section in
four-dimensional spacetime has dimension two, so its information-area form
acquires one power of `s`:

\[
m=D-2=2\quad\Longrightarrow\quad s^{m/2}=s.
\]

This is a precise information-geometric reason for the power appearing in the
gravity formula.  In a three-dimensional spacetime the horizon cut would be
one-dimensional and the corresponding line element would scale by
`sqrt(s)`; in five spacetime dimensions the three-volume element would scale
by `s^(3/2)`.  The single unsquared factor `S_Q` is selected by a
two-dimensional horizon cut, hence by four-dimensional spacetime, provided
the horizon information metric is the metric that counts the microscopic
states entering the area law.

This dimensional statement should not be confused with the six-dimensional
space of spacetime bivectors.  Contracting a six-dimensional information
metric gives an information-volume factor `S_Q^3`.  The present construction
pulls the metric back to the two tangent directions of one physical horizon
cut before taking its volume form.

## The coframe amplitude is now a consequence

The earlier area-calibration argument began with a positive inverse-length
amplitude

\[
d_Q=\sqrt{S_Q}
\]

on each of the two horizon directions.  The information metric now explains
that amplitude.  A uniform metric response `g'=S_Qg` corresponds to an
orthonormal coframe response

\[
E'_a=\sqrt{S_Q}\,E_a.
\]

Its wedge product gives

\[
E'_1\wedge E'_2=S_Q(E_1\wedge E_2).
\]

Thus the unitary-complement amplitude, the two-dimensional coframe scaling,
and the Fisher-area contraction are three descriptions of the same local
geometry.  The square root is forced when one passes from a metric response
to a coframe response.

## Connection to Jacobson's coefficient

Suppose the entropy carried by one distinguishable microscopic cell is fixed,
and the density of such cells per unit physical horizon area is proportional
to the information-area measure.  Then the theorem gives

\[
\eta_Q=S_Q\eta_0.
\]

Together with the unscaled globally counted flux in
`JACOBSON_PLACEMENT_AUDIT.md`, Jacobson's relation yields

\[
\boxed{G_Q=\frac{G_0}{S_Q}.}
\]

This is the first route in the repository that obtains the needed horizon
area-density power directly from the already proved information contraction.
It replaces the former standalone coframe-rescaling premise with a narrower
physical identification:

> The microscopic density in the local horizon area law is the
> two-dimensional BKM information-volume density of the covariant quartic
> horizon channel.

That sentence is the remaining physics posit.  The mathematics on both sides
of it is now exact.

## Falsifiers and limitations

This bridge fails if the physical horizon cell family is not two-dimensional,
if its state-space metric is not the relative-entropy/BKM metric, if the
erasure parameter varies across the two tangent directions, or if the area
term counts a normalized conditional state rather than the unconditioned
information volume.

The finite Lean theorem uses commuting diagonal states.  The exact quantum
relative-entropy identity establishes the same uniform BKM scaling for
faithful noncommuting states by taking its Hessian, but a full operator-algebra
formalization of that statement and its sharp-horizon limit has not yet been
built.

## Kernel artifact

`GravityScreening/InformationArea.lean` proves:

- `erasureFisherPair_eq`;
- `informationMetricDet2_scale`;
- `informationArea2_scale`;
- `erasureFisherArea2_eq`;
- `quarticErasureFisherArea2_eq`.

All declarations contain no `sorry` and use only Mathlib's standard
foundational axioms.

