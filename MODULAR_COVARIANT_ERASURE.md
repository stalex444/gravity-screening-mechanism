# A modular-covariant quartic erasure channel

## The result

The finite horizon-cell model can now carry a clock mode and screen its
accessible information without changing the mode's modular frequency.

Let `X` be a tangent perturbation of the input density matrix, and let a
diagonal modular phase act by

\[
\alpha_u(X)_{ij}=u_iX_{ij}\overline{u_j}.
\]

The derivative of the fixed-erasure channel is

\[
C_{s,*}(X)=sX\oplus0.
\]

The zero is the tangent of the erasure flag: its probability is fixed and
therefore carries no first-order dependence on the input state.  If the phase
is extended to act trivially on that flag, then

\[
\boxed{\widetilde\alpha_u\,C_{s,*}=C_{s,*}\alpha_u.}
\]

This identity is proved in Lean for every finite dimension, every real
retention coefficient `s`, every diagonal complex phase, and every matrix
tangent.  It does not depend on a favorable basis calculation for one
particular state.

Suppose `X` lies on a spectral line,

\[
\alpha_u(X)=zX.
\]

Covariance immediately gives

\[
\widetilde\alpha_u(C_{s,*}X)=zC_{s,*}X.
\]

The output therefore carries the same spectral label `z`.  For real modular
time this label is a phase such as `Q^{-it}`; the associated positive modular
operator has eigenvalue `1/Q` on the corresponding GNS mode.  These are two
descriptions of the same frequency, but they should not be conflated in a
formal statement.

## Information contraction at the same time

For the normalized erasure channel, relative entropy obeys

\[
D(C_s(p)\|C_s(r))=sD(p\|r).
\]

Its relative-entropy Hessian, equivalently the classical diagonal BKM/Fisher
metric used in the finite model, therefore contracts by the same factor.  At
the quartic value

\[
s=S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\qquad \lambda_4=1-\frac1Q,
\]

the two exact conclusions hold simultaneously:

\[
\boxed{
\text{modular frequency unchanged},\qquad
\text{accessible distinguishability multiplied by }S_Q.}
\]

This is the cleanest mathematical form so far of the proposed relation
between time and gravity.  The clock rate and the screening strength are not
two unrelated additions.  They are two properties of one channel: `Q` fixes
the modular step, while the defect of that step fixes how much information is
retained.

In lay terms, the tick keeps the same pitch while the exterior signal becomes
less distinguishable.  Information has not been destroyed: the explicit
Stinespring dilation places the complementary weight `lambda4^2` and the
corresponding state in the hidden output.  The arrow seen by the exterior
observer comes from repeated loss of accessible distinctions, even though the
combined evolution remains norm preserving.

## What this closes

The result removes frequency mixing as an obstruction in the finite type-I
split collar.  Once a quartic input mode is placed in that collar, the erasure
map itself cannot shift it away from the quartic spectral line.  The exact
relative-entropy contraction and spectral covariance are compatible by
construction and by theorem.

This also clarifies an earlier apparent conflict.  The free wedge algebra has
no nonzero bounded modular eigenoperator at the required frequency.  The
present result does not manufacture one there.  Its intended home is the
observer crossed product or continuous core, where modular translation is an
explicit observer degree of freedom, with the finite erasure channel realized
in a type-I stretched-horizon collar.

## What remains physical rather than algebraic

The remaining task is no longer to guess whether screening must alter the
clock frequency.  It is to construct a horizon-cut map with three linked
properties:

1. the observer crossed product supplies the `log Q` clock line;
2. a split-factor collar realizes the covariant quartic erasure channel on
   that line and has a controlled sharp-horizon limit;
3. Jacobson's local area-density term reads the unconditioned retained weight
   `S_Q`, rather than a renormalized conditional state in which the factor
   cancels.

The first property is standard crossed-product structure plus the PDT choice
of the `log Q` step.  The second is now algebraically consistent and exact in
the finite collar, but its net-compatible limiting construction is open.  The
third is the decisive physical identification.  Proving it would turn the
quartic information channel into a microscopic derivation of the screening
factor in the gravitational response.

## Kernel artifact

`GravityScreening/ErasureCovariance.lean` proves:

- `tangentErasure_phase_covariant`;
- `tangentErasure_preserves_phase_eigenmode`;
- `covariantErasure_spectral_information`;
- `quarticCovariantErasure_spectral_information`.

The declarations contain no `sorry`; Lean reports only Mathlib's standard
foundational axioms (`propext`, `Classical.choice`, and `Quot.sound`).

