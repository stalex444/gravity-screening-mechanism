# Why the quartic graviton block is unique

## The freedom that had remained

The preceding TT theorem used the exterior response

\[
C_Q=\sqrt{S_Q}\,I_2
\]

on the plus/cross polarization vector.  That proved the correct consequence,
but it left a fair question: why should the physical response be a scalar
matrix rather than some other two by two matrix with the same total weight?

`GravityScreening/TTResponseUniqueness.lean` answers that question
conditionally from four explicit kinematic requirements.  Let `M` be a real
linear response on the two physical graviton polarizations and let

\[
J=\begin{pmatrix}0&-1\\1&0\end{pmatrix}
\]

be the quarter-turn of the polarization plane.  Require:

1. **rotational covariance:** `MJ=JM`;
2. **orientation-even response:** `M` is self-adjoint, so the channel contains
   no antisymmetric polarization rotation;
3. **the quartic quadratic weight:** `M^T M=S_Q I_2`;
4. **the passive branch:** the retained diagonal amplitude is nonnegative.

Lean proves that these conditions have exactly one solution:

\[
M=\sqrt{S_Q}\,I_2.
\]

## The proof in one line of thought

A real matrix commuting with `J` must have the form

\[
M=\begin{pmatrix}a&b\\-b&a\end{pmatrix}.
\]

This is the real representation of multiplication by one complex number.  A
self-adjoint matrix has equal off-diagonal entries.  Combining that condition
with the opposite off-diagonal entries above forces `b=0`.  The response is
therefore `a I_2`.

The weight equation then becomes

\[
a^2 I_2=S_Q I_2.
\]

There are algebraically two signs.  The nonnegative passive branch selects
`a=sqrt(S_Q)`.

The theorem also proves the converse: `sqrt(S_Q) I_2` satisfies all four
conditions.

## Direct gravitational capstone

The same Lean file composes this uniqueness result with the perturbative
normalization

\[
\sigma=\frac{\kappa}{2}h,
\qquad
\kappa^2=32\pi G.
\]

For every nonzero plus/cross superposition, the four response requirements
therefore imply

\[
\text{same physical TT metric before and after matching}
\quad\Longleftrightarrow\quad
G_Q=\frac{G_0}{S_Q}
=\frac{G_0}{(2Q-1)/Q^2}.
\]

The matrix formula is absent from the assumptions of this capstone.  It is a
conclusion of the symmetries and the quadratic weight.

## Why this matters physically

The theorem removes three possible freedoms from the minimal linear model:

- there is no adjustable mixing angle between plus and cross;
- there is no helicity-dependent attenuation or linear birefringence;
- there is no independent screening coefficient once the Q information
  weight is `S_Q`.

This agrees with the structure of the standard massless spin-two theory.  In
the Henneaux--Teitelboim fixed-momentum Hamiltonian, plus and cross enter with
the same coefficient.  In the Barnich--Troessaert local doubled action, the
spatial Hamiltonian is diagonal in the internal duality index and the
ordinary sourced theory has exactly two physical TT components.  Their
internal electric/magnetic plane is distinct from the physical plus/cross
plane used in this theorem; the full proposed field response acts on both.

## Honest status and the next test

**Kernel-checked mathematics:** the commutant classification, the scalar
reduction, the positive square-root uniqueness theorem, its converse, and the
same-metric if-and-only-if Newton response.

**Physical assumptions made explicit:** the Q channel acts linearly on the
same canonically normalized TT graviton mode; its quadratic weight is the
already derived `S_Q`; and its local response is rotationally covariant,
self-adjoint, and on the positive passive branch.

The remaining identification is now smaller than “guess the graviton
matrix.”  One must show that the local Q-to-gravity interaction has those
four properties.  The standard isotropic parity-even vacuum supplies a clear
route to the first two, while the normalized quartic erasure theorem supplies
the third on the information side.  The unresolved step is proving that this
information response and the gravitational TT response are the same physical
operator.

The theorem also gives a sharp falsifier.  A surviving antisymmetric `bJ`
term would rotate plus into cross and represent a chiral propagation effect.
A nonscalar Gram matrix would attenuate the two linear polarizations
differently.  Either outcome would invalidate the minimal scalar screening
mechanism rather than merely alter its presentation.

## Proof artifacts and primary references

- `GravityScreening/TTResponseUniqueness.lean`
- `GravityScreening/TTHorizonSplitter.lean`
- `GravityScreening/TransverseTracelessCount.lean`
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>
