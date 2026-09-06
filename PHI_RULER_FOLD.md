# The golden-ratio fold of the rho-Q ruler

## Exact statement

Let

\[
\varphi=\frac{1+\sqrt5}{2},\qquad
\rho^3=\rho+1,\qquad Q^4=Q+1,
\qquad u=\rho Q,
\]

using the positive real roots.  The golden ratio and the ruler are different
numbers:

\[
\varphi=1.6180339887498948\ldots,
\qquad
u=1.6171416100775491\ldots.
\]

Their relative separation at the positive embedding is

\[
1-\frac{u}{\varphi}=0.000551520350345\ldots,
\]

or about `0.055152%`.

The relationship is nevertheless exact at the arithmetic level.  Both are
algebraic units of norm `-1`.  For `phi`, this follows from the constant term
of `x^2-x-1`.  For `u`, its degree-twelve minimal polynomial is

\[
P_u(x)=x^{12}-3x^9-2x^8+2x^6-x^5-3x^4-x^3+x-1,
\]

whose constant term is also `-1`.

There is a second exact link:

\[
\operatorname{Res}(P_u,x^2-x-1)=-1.
\]

Therefore the failure of `u` to satisfy the golden equation,

\[
\delta_\varphi=u^2-u-1=-0.0019946230333412\ldots,
\]

is itself a unit of norm `-1` in `Q(u)`.  An explicit Bezout identity gives
its inverse.  Writing

\[
V(x)=x^{11}+x^{10}+2x^9+2x^5+x^4+1,
\]

one has

\[
-xP_u(x)+V(x)(x^2-x-1)=-1,
\]

and hence

\[
\delta_\varphi\,[-V(u)]=1.
\]

This identity is checked over every commutative ring in
`GravityScreening/PhiRulerFold.lean`.

## What “the 3D version of phi” can mean precisely

The statement has three layers.

1. **Exact family relation.** `phi`, `rho`, and `Q` are the positive roots of
   `x^n-x-1` at degrees 2, 3, and 4.  The degree is the dimensional label in
   PDT.
2. **Exact orientation relation.** `phi` and `rho*Q` have the same field norm,
   `-1`.  The joint ruler inherits that sign from the quartic factor because
   the cubic factor has norm `+1`.
3. **Near equality at the physical embedding.** `rho*Q` lies only `0.055152%`
   below `phi`, while its other eleven embeddings make it a genuinely
   degree-twelve object rather than the quadratic golden ratio.

Thus `rho*Q` can be described as a higher-dimensional lift of the golden unit:
it preserves the golden orientation and nearly preserves its positive scale,
but resolves that scale into the full cubic-quartic conjugate geometry.

The phrase remains a PDT interpretation rather than a standard theorem of
number theory.  The theorem-grade content is the family relation, both norm
identities, the degree-twelve minimal polynomial, the near-equality, and the
resultant identity.

## Information-geometric reading

The field norm is multiplicative volume over all embeddings.  In logarithmic
coordinates, norm magnitude one means that the embedding coordinates sum to
zero.  The very small golden defect at the positive embedding is therefore
balanced by the other conjugate directions.  Since

\[
\prod_\sigma \left|\sigma(\delta_\varphi)\right|=1,
\]

the product over the other eleven embeddings is

\[
\frac1{|\delta_\varphi|}=501.347865378291\ldots.
\]

This makes the fold a conservation statement: the positive real observer sees
a ruler very close to `phi`, while the rest of the algebraic information is
redistributed through hidden conjugate directions without changing total
arithmetic volume.

That is different from the quartic screening coefficient

\[
\lambda_4=1-\frac1Q=0.1808274866\ldots.
\]

The `phi`--`rho*Q` mismatch is only `0.055152%`, so it does not numerically
generate `lambda4` or `1-lambda4^2`.  The clean division of labor is:

- the `phi`--`rho*Q` fold supplies the conserved unit orientation and the
  higher-dimensional ruler;
- the inverse-step residue of the `Q` factor supplies the response amplitude
  `lambda4`;
- Hilbert-space completion of that response supplies the complementary weight
  `1-lambda4^2`.

This corrects the Fisher-score model in which `rho*Q` had been treated as a
product of independent cubic and quartic probability coordinates.  Here it is
the single lifted golden ruler on which the quartic response acts.  A physical
gravity derivation still has to show that this response enters the Einstein
kinetic coefficient.

Jacobson's horizon thermodynamics makes the last sentence precise.  The PDT
gravity paper already supplies his undetermined entropy-area density

\[
\eta_{\rm PDT}
=\frac{m_e^2(\rho Q)^{224}}{4\pi^4}
  \frac{2Q-1}{Q^2}.
\]

The open mechanism is therefore the direct microscopic derivation of its
existing quartic factor: show that local horizon coarse-graining of the
norm-preserving `phi`--`rho*Q` fold retains the fraction
`(2Q-1)/Q^2=1-lambda4^2` of entropy per area.  This would explain the constant
already calculated by the gravity paper rather than introduce or fit another
constant.

## Reproduce

```bash
python3 phi_ruler_fold.py
lake build
```
