# A unitary-defect mechanism for the gravity screening coefficient

## Candidate mechanism

There is a canonical operator-theoretic route from the Q-sector coefficient
`lambda4` to the gravity factor `1-lambda4^2`.

Let the normalized Q-sector interaction or residue act with scalar amplitude

\[
L_Q=\lambda_4 I,
\qquad
\lambda_4=1-\frac1Q.
\]

Because `0 < lambda4 < 1`, this is a contraction. Its Hilbert-space defect
operator is

\[
D_Q=(I-L_Q^*L_Q)^{1/2}
   =\sqrt{1-\lambda_4^2}\,I.
\]

Consequently,

\[
D_Q^*D_Q=(1-\lambda_4^2)I
=\frac{2Q-1}{Q^2}I.
\]

This forces the square through the Hilbert norm and forces the minus sign
through conservation of total squared norm.

## Where `lambda4` comes from geometrically

### The companion-operator derivation

The quartic substitution `1 -> 2, 2 -> 3, 3 -> 4, 4 -> 12` has the
nonnegative companion matrix

\[
M_Q=
\begin{pmatrix}
0&0&0&1\\
1&0&0&1\\
0&1&0&0\\
0&0&1&0
\end{pmatrix},
\qquad
M_Q^{-1}=
\begin{pmatrix}
-1&1&0&0\\
0&0&1&0\\
0&0&0&1\\
1&0&0&0
\end{pmatrix}.
\]

Its distinguished positive eigenvector is

\[
v_Q=(1,Q^3,Q^2,Q)^T,
\qquad M_Qv_Q=Qv_Q.
\]

Define the inverse-step residue operator

\[
R_Q=I-M_Q^{-1}.
\]

Then the quartic equation gives the exact eigenvalue identity

\[
R_Qv_Q
=\left(1-\frac1Q\right)v_Q
=\lambda_4v_Q.
\]

Thus the contraction amplitude is not chosen by looking at the gravity
residual. It is the eigen-amplitude of “current positive scaling state minus
one pulled-back recurrence step.” The Lean development verifies the companion
matrix, its integral inverse, both eigenvector equations, and the resulting
`lambda4` amplitude.

This statement is restricted to the Perron eigenline. The full residual
operator is not a contraction: on the other quartic eigenmodes the numerical
residual magnitudes are approximately `2.38028` and
`1.52424, 1.52424`. The positive Perron mode is the only contractive mode in
this spectrum. Identifying that distinguished mode as the physical Q-to-
geometry channel remains part of the physical interpretation.

### The interval form of the same residue

Consider the canonical dilation by `Q` on a normalized unit interval:

\[
x\longmapsto Qx.
\]

The points whose images remain in the unit interval satisfy `x <= 1/Q`.
Thus the one-step overflow interval is

\[
H_Q=(1/Q,1],
\]

with normalized length

\[
|H_Q|=1-\frac1Q=\lambda_4.
\]

Equivalently, this is the second branch domain of the beta transformation
`T_Q(x)=Qx mod 1`. The arithmetic quantity called the Q-sector residue in PDT
therefore has an exact one-step dynamical meaning: it is the relative part of a
normalized domain that crosses the unit boundary under Q-dilation.

This interval calculation supplies a second description of the same inverse-
step residue. By itself, interval length would not justify calling the number a
Hilbert-space amplitude; the companion-operator eigenvalue above is the
operator-level source of that amplitude.

## Minimal unitary completion

For a scalar contraction `L_Q=lambda4 I`, the Julia operator is

\[
U_Q=
\begin{pmatrix}
\lambda_4 & \sqrt{1-\lambda_4^2}\\
\sqrt{1-\lambda_4^2} & -\lambda_4
\end{pmatrix}.
\]

Direct multiplication gives

\[
U_Q^*U_Q=I.
\]

Equivalently, two scalar Kraus operators

\[
K_Q=\lambda_4 I,
\qquad
K_G=\sqrt{1-\lambda_4^2}\,I
\]

satisfy the trace-preserving completeness relation

\[
K_Q^*K_Q+K_G^*K_G=I.
\]

Given `K_Q`, the positive scalar magnitude of `K_G` is unique. No independent
continuous coefficient remains in the two-channel scalar completion.

## Exact match to the gravity formula

The gravity construction multiplies the tree-level Planck-mass amplitude by

\[
d_Q=\sqrt{1-\lambda_4^2}.
\]

The defect mechanism produces exactly this amplitude. Since Newton's coupling
is inverse-square in the Planck mass,

\[
M_{P,\mathrm{eff}}=d_QM_{P,0}
\quad\Longrightarrow\quad
G_{\mathrm{eff}}
=\frac{G_0}{d_Q^2}
=\frac{G_0}{1-\lambda_4^2}.
\]

Thus one operator identity accounts simultaneously for the square root in the
Planck-mass formula and the full screening factor in Newton's constant.

Numerically,

\[
\lambda_4=0.180827486603835\ldots,
\qquad
d_Q=0.983514829623\ldots,
\qquad
d_Q^2=0.967301420088540\ldots.
\]

## Relation to the Hodge model

This mechanism should remain distinct from the rho/Q-weighted Hodge operator.
The earlier source audit proved that normalizing the rho/Q chiral split does
not yield `lambda4`. The two operators can instead perform different jobs:

- the rho/Q Hodge operator labels the two orientation-exchanged geometric
  sectors;
- the Q-residue contraction and its unitary defect distribute conserved norm
  between the Q interaction channel and its complementary channel.

This separation meets the earlier audit's requirement that the dimensional
divide and the screening response be derived as two different operators.

The Julia operator is itself an involutive orthogonal reflection. That makes it
compatible with a two-channel Hilbert-space description, but does not by itself
identify its complementary channel with curvature or gravity.

## What is proved and what remains physical

Exact mathematics:

1. `I-M_Q^(-1)` acts by `lambda4` on the quartic Perron eigenline;
2. the Q-dilation overflow interval has length `lambda4`;
3. the defect operator of `lambda4 I` has square
   `(1-lambda4^2) I`;
4. the Julia block is orthogonal/unitary;
5. a mass amplitude multiplied by the defect acquires the squared factor
   `1-lambda4^2`;
6. inverse-square coupling then acquires the reciprocal screening correction.

Physical premises still requiring derivation:

1. the positive Perron residual mode is the physical Q-sector information
   channel relevant to gravity;
2. the complementary defect channel is the geometric/gravitational response;
3. the physical reduction is the minimal two-channel scalar dilation, without
   additional Kraus channels, phases, or momentum dependence;
4. the channel acts at the normalization scale used by the gravity formula.

The current two-scalar action does not establish these premises. Its tree-level
quadratic operator is diagonal at the selected vacuum, as shown in
`CURRENT_ACTION_AUDIT.md`.

## Reverse audit: why the channel choice matters

The Q-dilation also contains the internal retention operator `M_Q^(-1)`, whose
Perron eigenvalue is `1/Q`. If that coefficient rather than the inverse-step
residue were completed as the contraction, its defect weight would be

\[
1-\frac1{Q^2},
\]

which is not the gravity coefficient. The proposed mechanism therefore uses
the operator `I-M_Q^(-1)`, rather than `M_Q^(-1)`. The founding substitution
fixes both operators; the physical question is whether gravity reads the
change between steps or the retained state. Dilation theory forces the
complement after that observable has been selected.

## Decisive next derivation

The next calculation should formulate the Q-to-geometry transition as a
reduced quantum channel or horizon response. Starting from a specified joint
evolution, trace out the inaccessible Q degrees of freedom and compute its
Kraus operators. The mechanism succeeds if the physical Q Kraus amplitude is
`lambda4 I` and the geometric complementary amplitude is its defect operator.

It fails if the reduction produces `1/Q`, a non-scalar operator, additional
independent channels, a scale-dependent coefficient, or a different
normalization. These outcomes are calculable before comparing with Newton's
constant.

## References

1. B. Sz.-Nagy and C. Foias, *Harmonic Analysis of Operators on Hilbert Space*,
   North-Holland, 1970.
2. W. F. Stinespring, “Positive Functions on C*-Algebras,” *Proceedings of the
   American Mathematical Society* 6 (1955), 211-216.
3. D. Kretschmann, D. Schlingemann, and R. F. Werner, “The
   Information-Disturbance Tradeoff and the Continuity of Stinespring's
   Representation,” IEEE Transactions on Information Theory 54 (2008),
   1708-1717, arXiv:quant-ph/0605009.
4. A. Renyi, “Representations for Real Numbers and Their Ergodic Properties,”
   Acta Mathematica Academiae Scientiarum Hungaricae 8 (1957), 477-493.
