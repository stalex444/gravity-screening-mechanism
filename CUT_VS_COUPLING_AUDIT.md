# Horizon evolution and gravity screening are two different comparisons

## The correction forced by the horizon constraint

The quartic erasure channel can appear in both the time mechanism and the
gravity mechanism, but it cannot be inserted into both in the same way.
Successive horizon cuts within one semiclassical theory obey the local scalar
constraint

\[
q+K_\lambda+\frac{A_\lambda}{4G}=0,
\]

where `q` is the asymptotic area charge, `K_lambda` is the one-sided modular
Hamiltonian, and `A_lambda/(4G)` is the area charge at the cut. Faulkner and
Speranza derive the operator version of this relation in the observer
crossed-product construction.

Take two cuts with the same `q` and the same `G`. Subtracting their constraints
gives the exact balance law

\[
\frac{1}{G}\frac{A_1-A_0}{4}=-(K_1-K_0).
\]

If the distinguished quartic mode is retained with weight
`K_1=S_Q K_0`, this becomes

\[
\boxed{
\frac{1}{G}\frac{A_1-A_0}{4}=(1-S_Q)K_0
=\lambda_4^2K_0.}
\]

Thus, along the horizon-evolution direction, the `S_Q` contraction produces a
compensating horizon-area change at fixed Newton coupling. It does not by
itself produce a new Newton constant. This is the correct role of the channel
in the generalized-second-law picture: accessible distinguishability decreases
while the area term keeps the gravitational constraint balanced. The clock
inside this evolution is the separate projective phase rotation; gravitational
time dilation converts its modular parameter to observer proper time.

## Why the asymptotic charge does not remove the coupling ambiguity

It was tempting to use the common charge `q` to fix the normalization of the
geometric mode and thereby force the `S_Q` factor into `1/G`. The equations
rule out that shortcut. The charge is itself an area charge,

\[
q=-\frac{A_\infty^{(2)}}{4G},
\]

so it already contains the Newton coupling whose scaling is in question. It
anchors comparisons among cuts within one theory; it is not an independent
rod for comparing a microscopic coupling with an effective one.

There is an even sharper obstruction. Start with

\[
q+K+\frac{A}{4G}=0.
\]

At the same cut and with `q` held fixed, scale both `K` and `1/G` by a common
factor `s`. The new constraint residual is exactly

\[
(1-s)q.
\]

Unless `s=1` or `q=0`, the new description violates the constraint. If the
three charge terms are all scaled together, the homogeneous constraint is
preserved. This is consistent with `q` containing `1/G`, but it means that one
may not treat `q` as fixed while using it to infer the change in `G`.

These statements are proved in
`GravityScreening/HorizonConstraint.lean`.

## The resulting two-axis picture

The same arithmetic coefficient can govern two related operations:

| Comparison | Held fixed | Effect of the quartic channel |
|---|---|---|
| Earlier cut to later cut | one theory and one `G` | the clock phase evolves, accessible information contracts, and horizon area changes |
| Microscopic to effective description at one cut | the same `pQ`-normalized geometric mode | the Fisher/canonical-energy coefficient, hence `1/G`, can scale |

The first row is evolution. The norm-preserving phase supplies the clock, while
observer restriction and record formation supply the experienced arrow. The
second row is renormalization or matching. It is the possible home of gravity
screening. Its baseline is set by the joint `pQ` ruler; `S_Q` is the resolved
quartic response applied to that baseline.

The canonical-energy bridge remains exact under its stated premise:

\[
g_{\rm BKM}^{\rm eff}=S_Qg_{\rm BKM}^{\rm micro},
\qquad
g_{\rm BKM}=\mathcal E_{\rm can},
\]

for the same independently normalized geometric perturbation implies

\[
\frac1{G_{\rm eff}}=\frac{S_Q}{G_{\rm micro}},
\qquad
G_{\rm eff}=\frac{G_{\rm micro}}{S_Q}.
\]

The horizon-cut constraint neither proves nor contradicts this fixed-cut
matching. It tells us that the matching cannot be inferred merely by watching
a state evolve from one cut to the next.

## The next construction

The required object is now a commuting-square test with two independent
directions:

\[
\begin{array}{ccc}
\text{microscopic data at cut }0 & \longrightarrow &
\text{effective data at cut }0\\
\downarrow\text{ horizon evolution} &&
\downarrow\text{ horizon evolution}\\
\text{microscopic data at cut }1 & \longrightarrow &
\text{effective data at cut }1.
\end{array}
\]

The vertical maps must preserve the respective Newton couplings and satisfy
the horizon area-energy balance. The horizontal maps must compare the same
`pQ`-anchored, flux- or area-normalized geometric mode and intertwine its BKM
metric with canonical energy. PDT succeeds at this stage if the resolved
quartic channel supplies `S_Q` horizontally while its compatible observer
restriction supplies the causal contraction vertically, with the square
commuting. The unitary phase rotation itself remains norm preserving on both
sides.

This formulation gives a direct falsifier. If the only physical realization
of the quartic channel is restriction between successive cuts at fixed `G`,
then it explains horizon information loss and area growth but does not derive
gravity screening. A distinct fixed-cut microscopic-to-effective intertwiner
is necessary.

## Status

- **Kernel-checked mathematics:** the cut-balance identity, the retained-mode
  area response, the fixed-charge obstruction, homogeneous scaling, and the
  abstract microscopic/effective commuting square.
- **Published physics input:** the crossed-product horizon constraint and the
  restricted AdS-Rindler equality between quantum Fisher information and
  gravitational canonical energy.
- **Physical posit still open:** the fixed-cut quartic BKM contraction is the
  canonical-energy matching map for the same independently normalized
  geometric perturbation.

The correction strengthens the program because it separates a genuine
dynamical prediction from a coupling identification and makes each testable
on its own terms.

The observer-dependent conversion between the unit-circle clock and proper
time is treated in
[`GRAVITATIONAL_TIME_DILATION_BRIDGE.md`](GRAVITATIONAL_TIME_DILATION_BRIDGE.md).

## References

- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
- N. Lashkari and M. Van Raamsdonk, *Canonical Energy is Quantum Fisher
  Information*, <https://arxiv.org/abs/1508.00897>.
- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
