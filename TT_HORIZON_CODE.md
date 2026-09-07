# A canonically normalized two-state code for the graviton

## The normalization problem

The two TT coordinates are not quite an ordinary unit-normalized two-vector.
For

\[
h_{ij}^{TT}=
\begin{pmatrix}
h_+&h_\times&0\\
h_\times&-h_+&0\\
0&0&0
\end{pmatrix},
\]

the tensor Frobenius norm is

\[
h_{ij}^{TT}h_{TT}^{ij}=2(h_+^2+h_\times^2).
\]

The norm-preserving two-state code is therefore

\[
E(h)=\sqrt2\,(h_+,h_\times)\in\mathbb C^2.
\]

The factor `sqrt(2)` is fixed by the tensor normalization.  It is not a new
physical parameter.

## What Lean proves

`GravityScreening/TTHorizonCode.lean` proves:

1. **Exact norm preservation**

\[
\lVert E(h)\rVert_{\mathbb C^2}^2
=h_{ij}^{TT}h_{TT}^{ij}.
\]

The statement is proved both in explicit plus/cross coordinates and directly
on the full TT tensor subspace.

2. **Injectivity**

No graviton polarization information is lost by the encoding.

3. **Rotation intertwining**

Encoding after a plus/cross quarter-turn is exactly the code-space
quarter-turn after encoding.

4. **Erasure intertwining**

If `V_s` is the already constructed Stinespring dilation, then its exterior
data port obeys

\[
V_{s,{\rm ext}}E(h)=E(\sqrt{s}\,h).
\]

5. **Exact exterior norm response**

\[
\lVert V_{s,{\rm ext}}E(h)\rVert^2
=s\,h_{ij}^{TT}h_{TT}^{ij}.
\]

At the quartic value this coefficient is exactly

\[
S_Q=\frac{2Q-1}{Q^2}.
\]

6. **Encode, evolve, decode capstone**

Decoding the exterior state gives `sqrt(S_Q) h`.  For every nonzero TT tensor,
matching it to the same physical metric geometry is equivalent to

\[
G_Q=G_0/S_Q.
\]

## What changed

The proposed map from a physical TT vector to a two-state information code is
now explicit and correctly normalized.  Two mathematical conditions that had
been listed as future requirements are closed:

- the encoding preserves the canonical graviton norm;
- it intertwines transverse rotations, and the erasure channel respects that
  action.

The remaining issue is physical rather than linear-algebraic: show that the
Q sector of the local observer-horizon theory actually acts on this encoded
TT subspace by the quartic dilation.  The theorem proves the consequences of
that identification without leaving a normalization, basis, or mixing-angle
freedom.

## How the field theory can close it

The clean target is an intertwining statement between the one-graviton
subspace of the horizon algebra and this finite code:

\[
E\,U_{\rm grav}^{\rm ext}
=V_{Q,{\rm ext}}\,E.
\]

Here `U_grav^ext` is the exterior one-particle map derived from the local
first-order spin-two or horizon interaction.  Both sides already have fixed
norms and rotation actions.  The calculation must show that the physical map
has no state-dependent coefficient, frequency shift, extra polarization, or
magnetic source component.

## Proof artifacts

- `GravityScreening/TTHorizonCode.lean`
- `GravityScreening/ErasureTTBridge.lean`
- `GravityScreening/ErasureDilation.lean`
- `GravityScreening/TransverseTracelessCount.lean`
- `GravityScreening/HorizonShearNormalization.lean`
