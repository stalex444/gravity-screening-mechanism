# The clock-to-Hodge bridge

## Result

The gravitational crossed product places time and horizon area in one
canonical structure. Its asymptotic charge is

\[
q=-\frac{A_\infty}{4G},
\]

and the horizon-cut constraint has the form

\[
\frac{A_\lambda}{4G}=-q-K_\lambda.
\]

The core dual action translates the charge while giving the modular clock its
phase:

\[
\theta_s(q)=q-s,
\qquad
\theta_s(\lambda_t)=e^{-ist}\lambda_t.
\]

At the quartic displacement `s=log Q`, these are the area-charge translation
by `log Q` and the clock phase `Q^{-it}`. This is a precise time--area
conjugacy, not a numerical analogy.

The calculation also separates two possible gravitational readings. The
linear area charge is translated additively, so the repeated-defect polynomial
cannot multiply it by the PDT screening coefficient. The exponential area
weight is an eigenobject:

\[
e^{q}\longmapsto e^{q-\log Q}=\frac1Qe^q.
\]

Therefore

\[
\left[I-(I-\theta_{\log Q})^2\right]e^q
=\left[1-\left(1-\frac1Q\right)^2\right]e^q
=S_Qe^q.
\]

The core operation acts multiplicatively on the information weight associated
with area, while acting affinely on area itself. This explains both why the
trace-only route failed and why the information-geometric route survived.

## Unique chiral completion

The same calculation now fixes the Hodge response more tightly than the
earlier parallel identities did. One chiral stiffness is already the core
weight

\[
w_- = \frac1Q = 1-\lambda_4,
\qquad
\lambda_4=1-\frac1Q.
\]

Require the Q-dependent splitting to preserve the orientation-blind baseline
stiffness. On one Hodge pair this is

\[
\frac{w_++w_-}{2}=1.
\]

Then the partner is unique:

\[
w_+=2-\frac1Q=1+\lambda_4.
\]

Thus the complete response is forced to be

\[
R_Q=I+\lambda_4 C,
\qquad C^2=I,
\]

up to the orientation convention that labels the two chiral sectors. Its
orientation-even stiffness is

\[
w_+w_-=(1+\lambda_4)(1-\lambda_4)
=1-\lambda_4^2=S_Q,
\]

and the orientation-even inverse response is

\[
\frac12\left(\frac1{w_+}+\frac1{w_-}\right)
=\frac1{S_Q}.
\]

This is the gravity-paper correction. The second chiral eigenweight is no
longer separately chosen: it is the unique mean-preserving completion of the
quartic core eigenweight.

The entire equilibrium response can therefore be written in one line:

\[
\boxed{
\frac12\left(\frac1{1/Q}+\frac1{2-1/Q}\right)
=\frac{Q^2}{2Q-1}
=\frac1{1-\lambda_4^2}.}
\]

This is the simple core of the candidate gravity mechanism. The modular and
Perron constructions fix `1/Q`; four-dimensional Hodge orientation supplies
the paired channel; preservation of the already fixed `pQ` baseline fixes its
mean; and ordinary sourced equilibrium reads inverse stiffness.

## Equilibrium reading

The doubled quadratic model gives this formula a direct physical reading. Let
`X` be the geometric response and `Y` the unresolved information response.
Their normalized equilibrium functional is

\[
\mathcal F[X,Y]
=\frac{M_0^2}{2}
\left(\lVert X\rVert^2+\lVert Y\rVert^2
-2\lambda_4\langle X,JY\rangle\right)
-\langle T,X\rangle.
\]

The `Y` equation drives the information mode to its stationary value. After
it settles, the surviving geometric stiffness is

\[
M_0^2(1-\lambda_4^2),
\]

so the response to the conserved source is enhanced by
`1/(1-lambda4^2)`. In this interpretation, gravity is the universal
equilibration of the information substrate. A graviton is a propagating small
disturbance of the settled geometric field; it is not the entire underlying
transfer process.

Promoting this reduced functional to a covariant gravitational action remains
the dynamical task. The existing doubled-prepotential audit shows that the
quadratic response is compatible with linearized gauge symmetry and ordinary
wave speed after symplectic normalization. What is still needed is a
microscopic PDT principle that identifies `Y` with the Q information mode and
fixes the matter source to `X`.

## Why the mean condition is the right open question

On four-dimensional Lorentzian two-forms, the chiral involution has equally
sized `+1` and `-1` sectors and hence zero trace. A deformation proportional
to `C` redistributes stiffness between orientations without changing their
mean. The unscreened `pQ` ruler fixes that common baseline. The quartic core
then fixes the reduction in one orientation, and the traceless Hodge split
fixes the compensating increase in the other.

The remaining physical statement is now one sentence:

> The modular-core weight `1/Q` is the retained stiffness of one horizon Hodge
> chirality, and the Q response is a traceless redistribution about the
> already fixed `pQ` gravitational baseline.

If this statement follows from the microscopic horizon action or its Ward
identities, the Hodge route closes: the full screening coefficient and its
inverse appearance in `G` follow without another continuous parameter. If the
Q response contains an independent scalar part, gives a different eigenweight,
or does not act on the sourced gravitational Hodge pair, this route fails.

## The direct-area no-go

For any affine observable `f(q)=a q+b`, let

\[
D_s f=f-f\circ(q\mapsto q-s).
\]

Then `D_s f=as` is constant and `D_s^2 f=0`. Hence

\[
[I-D_s^2]f=f.
\]

In particular the self-defect complement does not screen either the
asymptotic area charge or the horizon-cut area charge. A common translation
also cancels from the difference between two horizon cuts. This is an exact
no-go for reading `S_Q` as a multiplicative action on linear area.

The result does not weaken the information or kinetic mechanisms. It tells us
where the coefficient can live: in the exponential density, relative
entropy/Fisher geometry, or a noncentral chiral kinetic response.

## Verification and sources

`GravityScreening/ClockHodgeBridge.lean` verifies the affine-area no-go, the
exponential eigenweight and self-defect law, the unique mean-preserving partner,
and the exact Hodge matrix completion.

Faulkner and Speranza construct the gravitational crossed product with the
asymptotic charge proportional to late-time horizon area and derive
`A_lambda/(4G)=-q-K_lambda`:

- <https://arxiv.org/abs/2405.00847>

Speranza derives the trace-scaling dual action, its observer-Hamiltonian
translation law, and the conjugate modular clock operators:

- <https://arxiv.org/abs/2504.07630>

Those papers establish the gravitational crossed-product architecture. They
do not supply the PDT value `log Q`, the Hodge assignment, or the traceless
completion premise.
