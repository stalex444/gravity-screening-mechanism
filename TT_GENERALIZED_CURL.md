# The quartic response passes the graviton kinetic-symbol test

## Why this test matters

The preceding results identify the two entries of the horizon code with the
plus and cross polarizations of a transverse-traceless graviton. They prove
the right norm, the right number of states, and the unique passive response

\[
C_Q=\sqrt{S_Q}\,I_2,
\qquad
S_Q=\frac{2Q-1}{Q^2}.
\]

That still leaves a field-theory question. Does this response respect the
actual derivative operator that evolves a spin-two prepotential, or only an
abstract rotation chosen on a two-dimensional vector space?

Barnich and Troessaert define the generalized curl of a symmetric spatial
tensor by

\[
(\mathcal O h)_{mn}
=\frac12\left(
\epsilon_{mpq}\partial^p h^q{}_n+
\epsilon_{npq}\partial^p h^q{}_m
\right).
\]

This operator appears in the kinetic structure of the local,
duality-symmetric formulation of linearized gravity. It therefore supplies a
more demanding test than commutation with an abstract polarization
quarter-turn.

## The fixed-momentum calculation

Take a Fourier mode whose momentum points along the third spatial axis and
use `partial_z -> i k`. The complete complexified TT tensor is

\[
h^{TT}=
\begin{pmatrix}
h_+&h_\times&0\\
h_\times&-h_+&0\\
0&0&0
\end{pmatrix}.
\]

`GravityScreening/TTGeneralizedCurl.lean` evaluates the generalized curl
entry by entry and proves

\[
\mathcal O_k(h_+,h_\times)
=(-ik h_\times,\,ik h_+)
=ikJ(h_+,h_\times),
\qquad
J=\begin{pmatrix}0&-1\\1&0\end{pmatrix}.
\]

Thus the quarter-turn used in the earlier uniqueness theorem is the
polarization part of the standard local spin-two differential operator.

Lean also proves

\[
\mathcal O_k^2=k^2 I_2=-\Delta
\]

on the full TT subspace. The two circular polarization vectors diagonalize
the operator:

\[
\mathcal O_k(1,i)=k(1,i),
\qquad
\mathcal O_k(1,-i)=-k(1,-i).
\]

This is the expected pair of opposite curl eigenvalues for the two helicity
modes. Their squared norm has the common spectral factor

\[
\lVert\mathcal O_k h\rVert^2=k^2\lVert h\rVert^2.
\]

## The quartic commutation theorem

Because the exterior Q response is scalar on the polarization plane, Lean
proves the exact operator identity

\[
\mathcal O_k C_Q=C_Q\mathcal O_k
\]

for every real momentum `k` and every complex TT superposition. Consequently,

\[
\lVert C_Q\mathcal O_k h\rVert^2
=\frac{2Q-1}{Q^2}\,k^2\lVert h\rVert^2.
\]

The quartic factor changes the common accessible weight. It does not change
the momentum dependence, split the two helicities, rotate one polarization
into the other, or add a longitudinal mode.

## What this closes

The proposed Q response now passes three increasingly physical checks:

1. it preserves the two-dimensional TT subspace;
2. its normalization is uniquely fixed by covariance, self-adjointness, the
   quartic weight, and the passive branch;
3. it commutes with the generalized-curl symbol in the local
   duality-symmetric graviton action.

The third point removes a real obstruction. A scalar screening coefficient
can be inserted as the common normalization of the linear spin-two sector
without altering its massless spatial dispersion or producing vacuum
birefringence.

## Honest boundary

This theorem establishes compatibility with the standard linearized graviton
kinetic operator. It does not derive the physical statement that the Q
horizon channel acts on the graviton prepotential. It also does not extend
the free duality symmetry to nonlinear general relativity.

`TT_DILATION_SYMPLECTIC.md` completes the corresponding one-particle
kinematic test: the full visible-plus-hidden map preserves the Hilbert
symplectic form and intertwines this generalized curl on both branches. The
next exact target is the time-dependent prepotential action. One must
construct a physical map that pulls the constrained gravitational symplectic
form back to the proved code form and intertwines the full generator and
source frame. This will decide whether the present compatibility is forced by
a local gravitational action.

The minimal mechanism has a clean falsifier. A derived Q interaction with a
momentum-dependent form factor, unequal `+k` and `-k` weights, or a surviving
helicity-mixing term would contradict the scalar response proved here.

## Proof artifact and primary sources

- `GravityScreening/TTGeneralizedCurl.lean`
- `GravityScreening/TTHorizonCode.lean`
- `GravityScreening/TTResponseUniqueness.lean`
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*, especially equations 2.16, 2.17, and 2.21:
  <https://arxiv.org/abs/0812.0552>
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
