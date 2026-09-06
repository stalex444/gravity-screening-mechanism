# Does the expected pQ subfactor already exist abstractly?

## Answer

There are two separate abstract existence results, and they do not yet give the
same embedding.

1. Because the joint pQ factor and a standard hyperfinite wedge factor are both
   copies of `R_infinity`, an **expected algebraic copy** of the pQ factor can be
   put inside the wedge.
2. The type-III state-embedding theorem puts a **state-preserving copy** inside
   the wedge for the actual vacuum state.

The first result does not preserve the specified wedge vacuum. The second does
not guarantee a conditional expectation or modular invariance. The physical
bridge is exactly the intersection: one embedding having both properties.

## 1. An expected copy exists for a chosen product state

Let `N_pQ` be the joint hyperfinite type-`III_1` factor and let `P` be another
copy of the hyperfinite type-`III_1` factor. Self-absorption gives

\[
N_{pQ}\,\overline\otimes\,P\cong R_\infty\cong M_W.
\]

For any faithful normal state `psi` on `P`, the tensor inclusion

\[
x\longmapsto x\otimes 1
\]

has the normal faithful conditional expectation

\[
E_0=\operatorname{id}\otimes\psi.
\]

With the product state `phi_pQ tensor psi`, this expectation is state
preserving. Transporting the construction through a factor isomorphism puts an
expected pQ copy inside `M_W`.

This proves that factor structure does not obstruct an expected inclusion. It
constructs a state on `M_W` adapted to that inclusion; it does not prove that
the adapted state is the physical wedge vacuum `omega_W`.

## 2. A copy preserving the actual wedge vacuum also exists

Kawahigashi--Ogata--Størmer prove that a von Neumann algebra with separable
predual and a faithful normal state embeds into any type-III factor so that a
specified normal target state restricts to the source state. Applied here, this
gives an injection

\[
\pi:N_{pQ}\longrightarrow M_W,
\qquad
\omega_W\circ\pi=\phi_{pQ}.
\]

This is enough to preserve the static ordered expectations defining
`lambda4`. Their theorem does not state that `pi(N_pQ)` is invariant under the
wedge modular group and does not supply an `omega_W`-preserving conditional
expectation onto it.

## 3. Why the two copies cannot simply be identified

A factor isomorphism class forgets the state. Two faithful normal states on the
same type-`III_1` factor can have different modular dynamics. Consequently,

\[
M_W\cong N_{pQ}\overline\otimes P
\]

does not imply the state factorization

\[
(M_W,\omega_W)
\cong
(N_{pQ},\phi_{pQ})\overline\otimes(P,\psi).
\]

The latter factorization would solve the problem immediately: the tensor
expectation would preserve the physical vacuum and Takesaki's theorem would
intertwine the modular flows. No theorem checked here makes an arbitrary wedge
vacuum factorize in that exact way.

The same issue appears in the cocycle language. Algebra isomorphism transports
one state to the wedge, but the physical vacuum differs by a Connes cocycle.
The conditional expectation exists with the desired state exactly when the
embedded range is invariant under the physical modular flow.

## 4. A sharp state-classification shortcut

Hartglass and Nelson prove that two extremal almost periodic states on the
injective type-`III_1` factor are conjugate by an automorphism when their
modular operators have the same point spectrum. Their theorem also treats KMS
states for generalized gauge actions on Cuntz algebras.

The pQ product state has the candidate countable dense modular group

\[
\Lambda_{pQ}=\langle\rho,Q\rangle
=\{\rho^mQ^n:m,n\in\mathbb Z\}.
\]

If both the precise pQ graph state and the physical wedge vacuum satisfy the
extremal almost-periodic hypotheses with point spectrum `Lambda_pQ`, their
theorem would give a state-preserving factor isomorphism. That would close the
modular map more strongly than a proper expected inclusion.

These hypotheses must be checked. Bisognano--Wichmann identifies the physical
wedge modular flow with Lorentz boosts, but factor type by itself says nothing
about the point spectrum of that particular state. A continuous boost spectrum
cannot be replaced by a countable pure-point spectrum merely because both
algebras are type `III_1`.

## 5. The quickest decisive test

For the actual candidate wedge theory, calculate the modular eigenoperator
space at the quartic ratio:

\[
M_W(\omega_W,Q^{-1})
=\left\{B\in M_W:
\sigma_t^{\omega_W}(B)=Q^{-it}B
\text{ for every }t\right\}.
\]

- If this space is zero, no modular-covariant embedding can carry the quartic
  degree-one graph operator into the wedge as a bounded eigenoperator.
- If it is nonzero, the single-line obstruction is cleared; one must next test
  whether the cubic and quartic eigenoperators generate an invariant copy of
  the full pQ factor.
- If only generalized or distributional boost-frequency modes exist, the
  present bounded-operator embedding must be reformulated before the
  coefficient can be called exact.

Merely observing that a continuous boost spectrum passes through
`log Q/(2*pi)` would not select Q. The nontrivial requirement is the covariant
copy of the whole graded pQ algebra, together with its state and conditional
expectation.

There is also a direct conditional obstruction: if the physical wedge vacuum
satisfies the absolute-Cesàro spectral-mixing condition, every nonzero-
frequency bounded modular eigenoperator vanishes. In that case the exact
bounded-subfactor route cannot work. A weaker ordinary-Cesàro condition does
not suffice. See `WEAK_MIXING_OBSTRUCTION.md` for the proof, the terminology
caveat, and the crossed-product alternative.

## Verdict

The stronger expectation is not automatic for the physical vacuum. The bare
algebra and the static state can each be embedded by known theorems, but known
existence results do not force a single embedding to be both state preserving
and modularly invariant.

This confirms that the remaining condition is a genuine state-and-dynamics
problem. The next efficient calculation is the modular point spectrum of the
actual wedge vacuum, beginning with the `Q^{-1}` eigenoperator space.

## References

- Kawahigashi, Ogata, and Størmer, *Normal states of type III factors*:
  <https://arxiv.org/abs/1301.5737>.
- Haagerup and Musat, *Classification of hyperfinite factors up to completely
  bounded isomorphisms of their preduals*, especially Lemma 3.8 on absorption
  by `R_infinity`:
  <https://web.math.ku.dk/~haagerup/publications/UffeMagda.pdf>.
- Hartglass and Nelson, *Uniqueness of extremal almost periodic states on the
  injective type III_1 factor*:
  <https://arxiv.org/abs/2406.00874>.
- Takesaki, *Conditional expectations in von Neumann algebras*:
  <https://doi.org/10.1016/0022-1236(72)90004-3>.
- Brunetti, Guido, and Longo, *Modular Structure and Duality in Conformal
  Quantum Field Theory*:
  <https://arxiv.org/abs/funct-an/9302008>.
