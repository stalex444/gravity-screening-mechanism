# Localizing the quartic erasure channel at a causal horizon

## Result of the localization audit

The finite dilation in `OBSERVER_HORIZON_DILATION.md` can be placed in a
standard algebraic-QFT localization scheme without pretending that a true
type-III horizon algebra factorizes into ordinary inside and outside Hilbert
spaces.

The appropriate construction has two stages:

1. realize the finite quartic channel on a **stretched horizon**, using the
   type-I factor supplied by the split property;
2. take the causal-boundary limit in the **observer crossed product**, where
   modular flow becomes an explicit observer degree of freedom and entropy is
   defined by a semifinite trace.

This does not yet prove that the resulting channel is the physical PDT
horizon channel.  It removes a localization mismatch and reduces the remaining
claim to one spectral condition on the quartic mode.

## 1. The stretched-horizon placement

Let `O_in` be a region strictly contained in `O_out`, with the collar between
them representing a finite stretched-horizon thickness.  The split property
gives a type-I factor `N` satisfying

\[
\mathfrak A(O_{\rm in})
\subset N
\subset \mathfrak A(O_{\rm out}).
\]

A type-I factor has the ordinary tensor-product structure needed to host the
finite input, exterior flag, and hidden ancilla of the map

\[
V_Q|\psi\rangle
=\sqrt{S_Q}|\psi\rangle_{\rm out}|0\rangle_{\rm hid}
+\lambda_4|e\rangle_{\rm out}|\psi\rangle_{\rm hid}.
\]

Thus every algebraic part of the quartic channel can be localized within a
finite collar.  The outside reduced state is exactly

\[
S_Q\rho\oplus\lambda_4^2|e\rangle\!\langle e|,
\]

and the complementary state contains `lambda4^2 rho`.  No type-III trace or
literal factorization at a sharp null surface is needed for this intermediate
construction.

The split factor is not canonical, so this stage alone does not select the
quartic coefficient or make the map covariant under horizon boosts.  Those are
the duties of the modular step.

## 2. Why the sharp horizon requires an observer algebra

In interacting QFT, fields strictly confined to a codimension-one null horizon
need not form a nontrivial tensor factor.  The stretched-horizon type-I factor
should therefore not be carried unchanged to zero collar width.

The modern replacement is the crossed product of a local type-III algebra by
its modular automorphism group.  This introduces the modular translation as an
observer variable and produces a semifinite algebra in which traces and
entropy can be defined.  The PDT joint `pQ` factor already has the correct
type-III structure, and its crossed product already contains the translation
unitaries carrying the arithmetic steps `log p` and `log Q`.

The finite dilation should be read as a cell-level model inside this observer
extension.  The sharp-horizon limit must retain its action on the distinguished
quartic modular line, rather than retain a literal finite tensor factor.

## 3. The exact remaining spectral condition

Let `C` denote the coarse-graining from an earlier horizon cut or stretched
collar to the algebra accessible at a later cut.  General relative-entropy
monotonicity gives

\[
D(C\rho\|C\sigma)\le D(\rho\|\sigma).
\]

PDT makes a much sharper statement on the degree-one quartic sector:

\[
\boxed{
D(C\rho_Q\|C\sigma_Q)
=S_QD(\rho_Q\|\sigma_Q),
\qquad
S_Q=\frac{2Q-1}{Q^2}.}
\]

Infinitesimally, if `X_Q` is a tangent perturbation of the quartic mode and
`g_BKM` is the relative-entropy Hessian, the equivalent condition is

\[
g_{\rm BKM}(C_*X_Q,C_*X_Q)
=S_Qg_{\rm BKM}(X_Q,X_Q).
\]

The same mode must carry modular frequency `log Q`, or modular eigenvalue
`1/Q` for one normalized step.  The entire relativistic localization problem
is therefore reduced to finding a single mode satisfying both conditions:

\[
\Delta X_Q=Q^{-1}X_Q,
\qquad
\frac{g_{\rm BKM}(C_*X_Q,C_*X_Q)}
     {g_{\rm BKM}(X_Q,X_Q)}=S_Q.
\]

The finite model proves that these two equations are mutually compatible and
that the second follows from the quartic erasure dilation.  The remaining task
is to produce this mode and coarse-graining inside the observer crossed
product associated with a horizon cut.

## 4. Relation to the generalized second law

Faulkner and Speranza formulate the generalized second law for horizon cuts in
crossed-product gravitational algebras and recover it from monotonicity of
relative entropy.  They also identify half-sided modular inclusions and
conditional expectations as the structures controlling successive cuts.

That supplies the physical home PDT needed.  Standard theory says that
distinguishability cannot grow as the accessible horizon algebra shrinks.  PDT
proposes the exact contraction eigenvalue on its distinguished quartic mode.
The gravity coefficient is then the local spectral rate of the same
coarse-graining responsible for the generalized second law:

\[
\eta_Q=S_Q\eta_0,
\qquad
G_Q=G_0/S_Q.
\]

This is a quantitative addition to the operator-algebraic gravity framework,
not a replacement for it.

## 5. A clean success criterion

The next construction succeeds if there is a horizon-cut observer algebra,
a completely positive restriction or conditional-expectation map `C`, and a
quartic tangent mode `X_Q` such that:

1. `X_Q` lies on the `log Q` modular spectral line;
2. `C` acts on its state family as the quartic erasure channel;
3. the BKM norm ratio is exactly `S_Q`;
4. the area-density term in the crossed-product generalized entropy reads the
   unconditioned exterior channel.

It fails in this form if modular covariance mixes the quartic line with other
frequencies, if the sharp-horizon limit removes the erasure flag, or if the
area term renormalizes the contraction away.

## References

- C. J. Fewster, *The split property for quantum field theories in flat and
  curved spacetimes*, <https://arxiv.org/abs/1601.06936>.
- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
- A. J. Speranza, *An intrinsic cosmological observer*,
  <https://arxiv.org/abs/2504.07630>.
- E. Witten, *Gravity and the Crossed Product*,
  <https://arxiv.org/abs/2112.12828>.
- A. C. Wall, *A proof of the generalized second law for rapidly changing
  fields and arbitrary horizon slices*, <https://arxiv.org/abs/1105.3445>.

