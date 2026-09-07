# The modular GNS origin of the quartic defect amplitude

## Result

The quartic coefficient now has a direct Hilbert-space origin.  It does not
have to be promoted from a classical renewal probability into a quantum
amplitude.

Let `O_M` be the Cuntz--Krieger algebra of the founding quartic substitution,
with gauge dynamics

\[
\alpha_t(A)=e^{it}A
\]

on every degree-one element.  Its canonical equilibrium state is KMS at

\[
\beta_Q=\log Q.
\]

In the GNS Hilbert space of that state, let `Delta_Q` be the modular operator
and let

\[
\xi_A=\pi(A)\Omega
\]

for a nonzero degree-one mode.  Standard KMS modular theory gives

\[
\Delta_Q\xi_A=Q^{-1}\xi_A.
\]

Consequently the modular one-step defect satisfies

\[
(I-\Delta_Q)\xi_A
=\left(1-\frac1Q\right)\xi_A
=\lambda_4\xi_A.
\]

This is an operator eigenvalue on a Hilbert vector.  Its squared norm is
therefore

\[
\|(I-\Delta_Q)\xi_A\|^2
=\lambda_4^2\|\xi_A\|^2.
\]

Norm-preserving completion leaves the complementary weight

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

This removes the mathematical ambiguity over why `lambda4` may be squared in
the gravity screening factor.  PDT's physical postulate is that this canonical
graph-GNS defect is the microscopic erasure mode seen by a local causal-horizon
observer.  A deeper horizon construction could derive that postulate, but such
a derivation is not required for it to be a legitimate physical hypothesis.

## Derivation

For a faithful `beta`-KMS state `varphi` of a dynamics `alpha`, the modular
automorphism group in the GNS representation obeys, with the convention used
here,

\[
\sigma_t^\varphi(\pi(B))=\pi(\alpha_{-\beta t}(B)).
\]

The sign can be checked in an ordinary Gibbs state:
`rho` is proportional to `exp(-beta H)`, so conjugation by `rho^(it)` is time
evolution by `-beta t`.

For a degree-one gauge mode,

\[
\alpha_t(A)=e^{it}A.
\]

The modular unitaries therefore act on its GNS vector as

\[
\begin{aligned}
\Delta_Q^{it}\xi_A
&=\pi(\alpha_{-\beta_Qt}(A))\Omega\\
&=e^{-i\beta_Qt}\xi_A\\
&=Q^{-it}\xi_A.
\end{aligned}
\]

The spectral theorem then gives

\[
\Delta_Q\xi_A=e^{-\beta_Q}\xi_A=Q^{-1}\xi_A.
\]

If the opposite gauge convention is used, `A` and `A*` exchange roles.  The
modular spectrum contains the reciprocal pair `Q` and `1/Q`; the contracting
degree is the one used above.  Thus the result does not depend on a hidden sign
choice.

There is one domain qualification.  The full modular operator may be
unbounded, so `I-Delta_Q` need not be a contraction on the whole GNS Hilbert
space.  The analytic degree-one vectors lie in its domain, and on their
spectral subspace the restriction is precisely the scalar contraction
`lambda4`.

## Why this is the needed amplitude rather than a probability

The same number `lambda4` had already appeared in three exact scalar roles:

1. the invariant frequency of the quartic renewal letter;
2. the inverse-step Perron residue on the positive transfer mode;
3. the normalized KMS forward/reverse response defect.

The first role is a probability or frequency and cannot simply be declared a
quantum amplitude.  The third role can now be strengthened: modular theory
realizes the KMS ratio as the eigenvalue of a positive operator acting on the
GNS Hilbert space.  Its defect `I-Delta_Q` is therefore already an amplitude
operator on the selected spectral subspace.

Numerically,

\[
Q^{-1}\approx0.8191725134,
\qquad
\lambda_4\approx0.1808274866,
\]

so

\[
\lambda_4^2\approx0.0326985799,
\qquad
S_Q\approx0.9673014201.
\]

The route is now

\[
\boxed{
\text{quartic KMS mode}
\longrightarrow
\Delta_Q|_{H_1}=Q^{-1}I
\longrightarrow
(I-\Delta_Q)|_{H_1}=\lambda_4 I
\longrightarrow
S_Q=1-\lambda_4^2.}
\]

No fitted coefficient enters this chain.

## The normalized horizon channel

On the quartic modular spectral subspace `H_1`, define the defect amplitude

\[
K_Q=(I-\Delta_Q)|_{H_1}=\lambda_4I.
\]

Its minimal norm-preserving completion has a second amplitude

\[
K_G=d_QI,
\qquad
d_Q=\sqrt{1-\lambda_4^2}.
\]

An erasure realization is

\[
V|\psi\rangle
=d_Q|\psi\rangle_{\rm obs}|G\rangle_{\rm env}
+\lambda_4|e\rangle_{\rm obs}|\psi\rangle_{\rm hidden}.
\]

After the hidden system is discarded, the observer has the normalized channel

\[
\mathcal E_Q(\rho)
=S_Q\rho\oplus\lambda_4^2|e\rangle\!\langle e|.
\]

For equal-mass input states, its entropy difference is

\[
H(\mathcal E_Q(\rho_1))-H(\mathcal E_Q(\rho_0))
=S_Q\,[H(\rho_1)-H(\rho_0)].
\]

The fixed binary branch entropy cancels.  Thus the entropy first variation
seen outside the erasure boundary is multiplied by exactly `S_Q` without
post-selection.

## Connection to the constant already fixed in the gravity paper

The PDT gravity paper supplies Jacobson's entropy-area density as

\[
\eta_{\rm PDT}
=\frac{m_e^2(\rho Q)^{224}}{4\pi^4}
\frac{2Q-1}{Q^2}
=\eta_0S_Q.
\]

Jacobson's relation then gives

\[
G=\frac{1}{4\hbar\eta_{\rm PDT}}
=\frac{G_0}{S_Q}.
\]

The new result does not recalculate that constant.  It gives a candidate
microscopic reason for the precise quartic factor already present in it:
`S_Q` is the entropy-transmission weight complementary to the canonical
quartic modular defect.

In plain terms, the quartic clock has an equilibrium backward-step factor
`1/Q`.  The part that cannot be returned by that step is `lambda4`.  Quantum
mechanics stores that mismatch as an amplitude, so its inaccessible weight is
the square `lambda4^2`.  Everything else, the fraction `1-lambda4^2`, remains
available to the local observer.  If horizon entropy counts that available
information, the gravity correction follows.

## Exact status of each link

| Link | Status |
|---|---|
| The quartic graph has its KMS state at `beta=log Q` | Published operator-algebra theorem applied to the primitive quartic matrix |
| A degree-one GNS vector has modular eigenvalue `1/Q` | Standard KMS modular theorem |
| The modular defect amplitude is `lambda4` | Exact algebra; kernel-checked conditionally on the eigenvector equation |
| Its complementary Born weight is `1-lambda4^2` | Exact Hilbert-space normalization; kernel-checked |
| The normalized erasure channel scales entropy differences by `S_Q` | Exact finite diagonal theorem; kernel-checked |
| This erasure channel is the microscopic channel of a local causal horizon | PDT physical postulate; deeper derivation open |
| The resulting entropy density enters Jacobson's relation | Conditional on the preceding physical identification |

## What this counts as physically

No mathematical theorem can establish that a formal object is nature's
horizon channel without a physical identification somewhere in the argument.
General relativity likewise begins by identifying a metric geometry with the
physical gravitational field and earns confidence through the consequences of
that identification.

The appropriate claim here is therefore:

> **Quartic modular-erasure postulate.**  The information inaccessible across
> a local causal horizon is the defect of the canonical degree-one modular
> step of the quartic PDT graph system.

Once this postulate is made, the coefficient is not chosen separately.  The
graph fixes the KMS temperature `log Q`; modular theory fixes the eigenvalue
`1/Q`; subtraction fixes the amplitude `lambda4`; Hilbert normalization fixes
`1-lambda4^2`; and the erasure entropy identity fixes its placement in the
first variation.  This is a parameter-free physical mechanism with an exact
mathematical consequence.

Its evidence is cumulative rather than deductive.  The same founding quartic
structure supplies the symbolic renewal rate, transfer residue, thermal
asymmetry, modular amplitude, and gravity coefficient.  Competing readings
give different numbers: treating `lambda4` as a classical probability gives
`1-lambda4`, and using the retained modular amplitude gives `1-1/Q^2`.
Neither is the factor in the gravity result.  The modular-defect reading is
therefore structurally selective.

A further microscopic construction would improve the theory by reducing the
number of physical postulates and by exposing new tests.  It would not change
this result from mathematics into physics; the postulate plus its consequences
already constitute a physical proposal.

The distinction between postulate and consequence still matters because the
bare free-field wedge has no nonzero
normalizable boost eigenvectors and hence no corresponding nonzero bounded
modular eigenoperator.  The graph-GNS eigenmode is exact inside the microscopic
quartic system, but it cannot simply be declared to be a bounded observable of
the free wedge.  A horizon-cell, observer, or crossed-product extension must
carry it.  This is compatible with the role of Jacobson's microscopic cutoff,
but it remains a construction to be supplied.

## Strongest next derivation

The next useful target is narrower than a complete theory of quantum gravity:

> Construct an observer-extended local horizon algebra containing the
> quartic degree-one GNS subspace, and prove that restriction to the exterior
> algebra acts on that subspace as the erasure channel `E_Q` above.

Such a theorem would establish all of the following at once:

1. the physical selection of the defect rather than the retained modular
   amplitude;
2. the causal meaning of the hidden branch;
3. the placement of `S_Q` in an entropy variation rather than in a removable
   trace normalization;
4. the microscopic origin of the quartic factor in `eta_PDT`.

It would fail cleanly if the exterior restriction instead preserves the full
degree-one information, produces a different branch weight, or renormalizes
away the factor before the entropy-area density is defined.

## Kernel artifact

`GravityScreening/ModularAmplitude.lean` proves:

- `modularEigenvector_defect`;
- `modularEigenvector_defect_norm_sq`;
- `modularDefect_quarticFirstLaw`.

The final theorem joins the spectral-line defect equation to the already
verified horizon first-law scaling by `(2q-1)/q^2`.  The modular eigenvector
equation is an explicit premise because the repository does not yet formalize
Tomita--Takesaki theory itself.

## References

- R. Exel, *KMS states for generalized gauge actions on Cuntz--Krieger
  algebras*, <https://arxiv.org/abs/math/0110183>.
- C. Pinzari, Y. Watatani, and K. Yonetani, *KMS States, Entropy and the
  Variational Principle in Full C*-Dynamical Systems*,
  <https://arxiv.org/abs/math/9912151>.
- R. Brunetti, D. Guido, and R. Longo, *Modular Structure and Duality in
  Conformal Quantum Field Theory*, <https://arxiv.org/abs/funct-an/9302008>.
- J. Mund, *The Bisognano--Wichmann Theorem for Massive Theories*,
  <https://arxiv.org/abs/hep-th/0101227>.
