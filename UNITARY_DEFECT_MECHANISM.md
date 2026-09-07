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

This scalar completion has an important limitation. Its Stinespring vector
factorizes:

\[
V_Q\psi
=\psi\otimes(\lambda_4|Q\rangle+d_Q|G\rangle).
\]

Both branch probabilities are independent of the input state. The construction
therefore fixes a norm split but does not, by itself, transfer information to
the branch flag. That excludes reading the flag as a state-dependent
measurement record. It does not exclude a state-independent thinning of an
extensive horizon-cell density: the unconditioned complementary branch carries
weight `1-lambda4^2`, while renormalizing that branch removes the factor. See
`SUBNORMALIZED_HORIZON_BRANCH.md`.

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
- the Q-residue contraction and its unitary defect fix the two conserved norm
  weights; an additional nontrivial action must connect the positive defect
  amplitude to the inverse-length horizon resolution.

This separation meets the earlier audit's requirement that the dimensional
divide and the screening response be derived as two different operators.

The Julia operator is itself an involutive orthogonal reflection. That makes it
compatible with a two-channel Hilbert-space description, but does not by
itself identify its positive defect amplitude with curvature or the horizon
area-density calibration.

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
2. the positive defect amplitude acts on the inverse-length horizon
   resolution;
3. the physical area law counts the unconditioned complementary branch per
   original area; if it instead counts a normalized conditional state, a
   nontrivial relative branch action is required;
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

The next calculation should decide how the local horizon area law treats the
Q-to-geometry instrument. If it counts the unconditioned expected number of
retained cells per original area, the scalar defect branch already gives
`1-lambda4^2` and no state-dependent flag is needed. If it conditions on the
retained branch and renormalizes, the factor cancels and a nontrivial
operator-valued channel is required. See `SUBNORMALIZED_HORIZON_BRANCH.md`
and `HORIZON_AREA_CALIBRATION.md`.

It fails if the geometric response produces `1/Q`, a scale-dependent
coefficient, anisotropy without a horizon-symmetry reason, or additional
unfixed parameters. These outcomes are calculable before comparing with
Newton's constant.

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
