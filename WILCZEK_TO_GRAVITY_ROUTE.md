# From the Wilczek portal to the gravity response

## Why the origin of the scalar action matters

The two-scalar architecture preceded PDT's coefficient dictionary.  It is the
standard Higgs-portal form associated with Patt and Wilczek: two scalar sectors,
their self-potentials, and a quartic portal between them.  PDT did not invent a
special action to hold the numbers after the numerical relations were known.

The later substitution supplied the dimensionless vocabulary

\[
\lambda_3=1-\rho^{-1},\qquad
\lambda_4=1-Q^{-1},\qquad
\chi=Q/\rho,\qquad
\kappa=\chi^2.
\]

The first two identities follow exactly from the family equation
`r^n=r+1`.  The physical claim is that these algebraic quantities occupy the
corresponding self-coupling and portal roles.  The prior existence of the action
is valuable provenance for that claim, while the observable consequences are
what test it.

## The reusable rule

The cleanest common rule is a response determinant.

1. Physics supplies a field or representation space.
2. Symmetry makes the PDT response scalar on an irreducible sector.
3. Its determinant contributes one power of the scalar response per direction.
4. A source reads the inverse of the surviving quadratic response.

For electromagnetism, the proposed response space is the 15-dimensional
conformal algebra of four-dimensional Maxwell theory.  This gives

\[
\alpha=\frac{\pi^2}{(\rho Q)^{15}}.
\]

The exact exponent theorem has a general mathematical form: a scalar operator
on a 15-dimensional space has determinant `(rho Q)^15`.  The physical
identification of that determinant with the electromagnetic coupling is the
physics input.

## Gravity in the same grammar

Gravity responds to deformations of the spacetime response itself.  The
candidate baseline space is therefore the traceless endomorphism algebra of the
15-dimensional conformal-response space.  Its dimension is

\[
\dim\mathfrak{sl}(15)=15^2-1=224.
\]

This gives a compact structural reading of the deposited gravitational
exponent.  The exact orbit-stabilizer split is

\[
224=15+209.
\]

The arithmetic is proved.  The assertion that the gravitational baseline
really uses this representation is a physical correspondence and should be
tested through the action and its consequences.

The quartic sector then adds a normalized two-channel response

\[
K_Q=
\begin{pmatrix}
1&-\lambda_4\\
-\lambda_4&1
\end{pmatrix},
\qquad
\det K_Q=1-\lambda_4^2
=\frac{2Q-1}{Q^2}.
\]

The full proposed gravitational coupling can consequently be written as one
determinant formula,

\[
\alpha_G
=\frac{\pi^4}
{(\rho Q)^{224}\det K_Q}
=\frac{\pi^4 Q^2}
{(\rho Q)^{224}(2Q-1)}.
\]

It also contains the electromagnetic coupling exactly:

\[
\alpha_G
=\alpha\,
\frac{\pi^2}{(\rho Q)^{209}(1-\lambda_4^2)}.
\]

Thus the electromagnetic and gravitational formulas use one algebraic scale,
one determinant rule, and nested response spaces.  Gravity has one extra
ingredient because it must resolve the quartic channel rather than treat
`rho Q` as an undifferentiated product.

## The two-line effective field equation

Let `E_PF` denote the unit-normalized Pauli--Fierz operator.  In the doubled
duality description, take the ordinary response `h` and its dual partner
`h_tilde` to obey

\[
E_{PF}(h)-\lambda_4 E_{PF}(\widetilde h)=T,
\qquad
E_{PF}(\widetilde h)-\lambda_4 E_{PF}(h)=0.
\]

Eliminating the source-free partner gives

\[
(1-\lambda_4^2)E_{PF}(h)=T.
\]

Because the kinetic coefficient and Newton response are inverse to one another,

\[
G_Q=\frac{G_0}{1-\lambda_4^2}.
\]

The repository proves this reduction for the complete Lorentz Pauli--Fierz
operator, its Ward identity, the transverse-traceless action, and the sourced
constraint responses.  In the duality-symmetric formulation the two potentials
form one canonical graviton phase space, so the construction does not require
an additional propagating graviton.

## What the Wilczek scalar potential does and does not supply

The scalar action explains why two sectors and the three PDT coefficients have
a natural field-theory home.  Its potential does not itself generate the
gravitational Schur complement at the segregated axis vacuum.  There the mixed
scalar Hessian vanishes.  At the nonzero mixed stationary point the PDT
coefficients give a negative Hessian determinant.  The positive gravitational
block therefore belongs to the curvature, dual-prepotential, or horizon
response sector rather than to the scalar mass Hessian.

This removes an unhelpful demand from the gravity argument.  The scalar portal
need not be reinterpreted as a graviton.  Its role is to establish the common
two-sector architecture and coefficient dictionary.  The spin-two action then
uses the independently fixed quartic residue `lambda4` as its dual-channel
response.

## The remaining physics content

The shortest effective PDT gravity law is:

> The inverse-step quartic residue `lambda4=1-1/Q` is the normalized coupling
> between the ordinary gravitational response and its source-free dual
> response.

Once that law is stated, the complete linear screening equation, conservation
law, two-polarization count, Einstein low-energy completion, and numerical
Newton coefficient follow without an adjustable parameter.  A deeper horizon
or microscopic construction could explain this law, but it is not another
algebraic constant waiting to be found.

The next empirical task is separate: derive an observable beyond the already
used value of `G` from the same dual-channel law without introducing a new
response function.  A cosmological power law is not such a consequence unless
the theory independently derives how the local quartic update accumulates with
redshift.

## Kernel artifacts

- `GravityScreening/UnifiedCouplingGrammar.lean` checks the scalar determinant
  law, `224=15^2-1=15+209`, the combined quartic determinant, and the exact
  electromagnetic/gravity factorization.
- `GravityScreening/CovariantGravityCompression.lean` checks the covariant
  two-channel Pauli--Fierz reduction and Ward identity.
- `GravityScreening/TTConstraintSourceClosure.lean` and
  `GravityScreening/SourcedTTHamiltonianAction.lean` check the constraint and
  source response.
- `GravityScreening/ClockForcesConstitutive.lean` checks that exchange symmetry,
  unit diagonal mean, and the retained quartic weight force the two-channel
  block.

The exact mathematics in these files does not by itself identify a physical
field with an arithmetic object.  That correspondence is the defining physics
law of the effective model and is exposed above in a single sentence.

## Sources for the inherited field architecture

- B. Patt and F. Wilczek, [*Higgs-field Portal into Hidden
  Sectors*](https://arxiv.org/abs/hep-ph/0605188).
- M. Henneaux and C. Teitelboim, [*Duality in linearized
  gravity*](https://arxiv.org/abs/gr-qc/0408101).
- G. Barnich and C. Troessaert, [*Manifest spin 2 duality with electric and
  magnetic sources*](https://arxiv.org/abs/0812.0552).
