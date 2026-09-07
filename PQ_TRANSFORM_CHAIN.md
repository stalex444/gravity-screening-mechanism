# From the `pQ` transform to gravitational information screening

## What the gravity paper already established

The gravity paper begins with a sharp structural distinction.  Matter and the
non-gravitational interactions read the dimensional ruler `pQ` as an
undifferentiated product.  Gravity is the geometry of spacetime itself, so it
must resolve that ruler into its convergent `p` sector and its divergent `Q`
sector.  The quartic sector has the fixed residue

\[
\lambda_4=1-\frac1Q,
\]

and the paper assigns its self-action the screened weight

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

The last equality is an exact identity.  In the deposited formula, `S_Q`
multiplies the entropy-area density and therefore its reciprocal multiplies
Newton's response:

\[
\eta_Q=S_Q\eta_0,
\qquad
G_Q=\frac{G_0}{S_Q}.
\]

The paper also states its open seam correctly: the algebra is forced once the
screening is chosen to be `1-lambda4^2`, but the numerical agreement with
gravity alone cannot explain why this is the physical operation.

## The exact inverse-step transform now visible

The quartic companion operator `M_Q` has Perron eigenvalue `Q`.  Its inverse
therefore has eigenvalue `1/Q` on the distinguished positive line.  The
inverse-step residue

\[
T_Q=I-M_Q^{-1}
\]

acts on that line with eigen-amplitude

\[
T_Qv_Q
=\left(1-\frac1Q\right)v_Q
=\lambda_4v_Q.
\]

This makes the gravity paper's instruction to resolve `pQ` precise.  On the
joint cubic-quartic Perron mode the founding transformation has scale `pQ`.
When the operation is resolved onto the quartic factor, the cubic factor
contributes the identity and the quartic inverse-step defect is exactly
`lambda4`.  The same separation persists in the joint KMS factor: a quartic
degree-one element `1 tensor A` has the quartic causal-response coefficient
`lambda4`, while the cubic state contributes the scalar one.

Norm-preserving completion of `T_Q` then forces its complementary squared
amplitude to be

\[
1-\lambda_4^2=S_Q.
\]

This is the most direct transform identity behind the screening factor.  It
derives both the square and the minus sign from the resolved quartic operation,
rather than choosing a percentage correction.

## The Hodge flip-product realization

The subsequent Hodge calculation makes the `pQ` transformation into a
concrete operator statement.  On a Lorentzian Hodge pair let `C` be the
orientation involution, with `C^2=I`, and let `P+` and `P-` be its two chiral
projectors.  The root-weighted dimensional operator is

\[
D_{p,Q}=pP_+ + QP_-.
\]

Orientation reversal exchanges the two weights:

\[
D_{\mathrm{flip}}=QP_+ + pP_-.
\]

Their product forgets the orientation and recovers the common ruler:

\[
D_{p,Q}D_{\mathrm{flip}}=pQ\,I.
\]

The quartic residue defines a second response on the same two-sided algebra,

\[
R_Q=I+\lambda_4 C,
\qquad
R_{Q,\mathrm{flip}}=I-\lambda_4 C.
\]

Its orientation-even product is

\[
R_QR_{Q,\mathrm{flip}}
=(1-\lambda_4^2)I
=S_QI.
\]

This is the exact sense in which the gravity-screening identity has the form
of a `pQ` transform: the dimensional ruler and the screening response are both
obtained by pairing an oriented operator with its exchanged partner.  The
first paired product returns `pQ`; the second returns the surviving quartic
fraction `S_Q`.

They are not literally the same operator.  The normalized bias of the root
pair is

\[
\frac{p-Q}{p+Q},
\]

which is not `lambda4`.  The two transformations share the involution and the
flip-product law, while their coefficients encode different information:
`p,Q` encode the dimensional sectors and `lambda4` encodes the defect of the
quartic step.

## The independent route that supplies the missing mechanism

The quartic graph system fixes its KMS inverse temperature at
`beta=log Q`.  On a canonical degree-one GNS mode, the modular operator has
eigenvalue `1/Q`.  Therefore

\[
(I-\Delta_Q)\xi
=\left(1-\frac1Q\right)\xi
=\lambda_4\xi.
\]

This derives `lambda4` as an amplitude without using Newton's constant or its
residual.  Completing that amplitude to a normalized visible/hidden pair
fixes the visible weight:

\[
\lambda_4^2+S_Q=1.
\]

For the corresponding fixed-erasure channel

\[
\mathcal E_Q(\rho)
=S_Q\rho\oplus\lambda_4^2|e\rangle\!\langle e|,
\]

quantum relative entropy obeys the exact identity

\[
D(\mathcal E_Q(\rho)\|\mathcal E_Q(\sigma))
=S_QD(\rho\|\sigma).
\]

The Hessian of relative entropy, the BKM information metric, contracts by the
same `S_Q`.  Thus the number already used in the gravity paper is also the
fraction of statistical distinguishability retained by an observer after the
quartic causal step.

## What the combined result means

The new work does not invent or refit the gravity factor.  It explains the
operation that the gravity paper had identified:

\[
\boxed{
\begin{array}{c}
\text{resolve the }pQ\text{ ruler onto its quartic inverse step}\\[2pt]
\Downarrow\\[-1pt]
\text{the }Q\text{ modular step leaves defect amplitude }\lambda_4\\[2pt]
\Downarrow\\[-1pt]
\text{the exterior observer retains information weight }S_Q\\[2pt]
\Downarrow\\[-1pt]
\eta_Q=S_Q\eta_0,\quad G_Q=G_0/S_Q.
\end{array}}
\]

This closes the paper's algebraic-selection problem at the level of a clear
physical postulate: local horizon restriction acts on the quartic degree-one
mode as the normalized erasure channel above.  Once that identification is
made, the coefficient, its square, its sign, its placement in information
geometry, and the direction of the gravitational correction are all fixed.

The remaining construction problem is concrete.  An observer-extended local
horizon algebra must contain the quartic GNS mode, and restriction to the
exterior algebra must be shown to induce this erasure channel.  That theorem
would derive the physical postulate from a microscopic horizon model.  It is
an upgrade path for the theory, rather than a missing choice of coefficient.

## Verification status

The finite algebraic links are kernel-checked in this repository:

- `quarticBiResidualCoefficient_eq_lambda4` checks the Perron inverse-step
  transform;
- `quartic_chiralAreaResponse_det` and
  `chiralAreaResponse_mul_flip` check the Hodge response product;
- `modularEigenvector_defect` checks the modular defect amplitude conditional
  on the standard modular eigenvector relation;
- `quarticErasureRelativeEntropy_eq` and `quarticErasureFisher_eq` check the
  information contraction;
- `quarticTransformChain` packages all four consequences without identifying
  the distinct operators with one another.

The standing PDT record independently contains the root-weighted Hodge
flip-product and screening identities as F373.  F374 supplies the exact
no-go preventing the `p/Q` operator and the `lambda4` operator from being
silently conflated.
