# Where the missing gravitational phase space goes

## Result

The quartic horizon map is now proved to preserve more than probability. It
preserves the complete complex inner product and therefore the real
symplectic form of the one-particle TT mode when the visible and hidden
outputs are kept together.

For a finite complex amplitude vector, define

\[
\langle\psi,\phi\rangle
=\sum_i\overline{\psi_i}\phi_i,
\qquad
\Omega(\psi,\phi)=\operatorname{Im}\langle\psi,\phi\rangle.
\]

The second expression is the ordinary real symplectic form underlying a
complex one-particle space. It records phase-space orientation, not only the
length of a state.

The erasure dilation is

\[
V_s\psi
=\sqrt{s}\,\psi_{\rm ext}
\oplus\sqrt{1-s}\,\psi_{\rm hid}.
\]

`GravityScreening/ErasureSymplectic.lean` proves for every pair of states

\[
\langle V_s\psi,V_s\phi\rangle
=\langle\psi,\phi\rangle,
\qquad
\Omega(V_s\psi,V_s\phi)=\Omega(\psi,\phi).
\]

This is stronger than the earlier norm theorem, which is only the special
case `psi=phi`.

## The visible and hidden split

The exterior restriction is not symplectic by itself. Lean proves that it is
conformally symplectic:

\[
\Omega_{\rm ext}=s\,\Omega_{\rm in}.
\]

The hidden branch carries exactly the missing amount:

\[
\Omega_{\rm hid}=(1-s)\,\Omega_{\rm in},
\qquad
\Omega_{\rm ext}+\Omega_{\rm hid}=\Omega_{\rm in}.
\]

At the quartic point,

\[
s=S_Q=\frac{2Q-1}{Q^2},
\qquad
1-s=\lambda_4^2.
\]

Thus the same exact split already found for Born weight, relative entropy,
Fisher geometry, and TT shear now holds for one-particle phase-space area:

\[
\Omega_{\rm ext}=S_Q\Omega_{\rm in},
\qquad
\Omega_{\rm hid}=\lambda_4^2\Omega_{\rm in}.
\]

In plain terms, the exterior observer sees a smaller gravitational phase
space because part of the mode is inaccessible. The missing part is not
destroyed. It is carried by the complementary branch, and the full evolution
retains the original phase relations exactly.

## Compatibility with the graviton kinetic operator

The same Lean file lifts the generalized TT curl to both output branches and
proves the intertwining identity

\[
\mathcal O_k^{\rm out}V_s=V_s\mathcal O_k^{\rm in}.
\]

This holds on the exterior data and the hidden data separately. The
generalized curl is also proved Hermitian in the finite TT pairing:

\[
\langle x,\mathcal O_k y\rangle
=\langle\mathcal O_k x,y\rangle.
\]

At the Q value, the full dilation therefore has both properties required of a
one-particle kinematic embedding:

1. it preserves the symplectic form globally;
2. it intertwines the self-adjoint spatial operator that distinguishes the
   two graviton helicities.

The exterior contraction can consequently coexist with globally canonical
evolution. Screening appears when the observer discards the hidden port, not
as a failure of the complete dynamics.

## Why this is useful for the gravity mechanism

This resolves a potential conflict between the information picture and
Hamiltonian gravity. If the exterior amplitude were simply multiplied by
`sqrt(S_Q)` with no complementary system, the symplectic form would shrink by
`S_Q`; that map could not be the complete canonical evolution. The explicit
hidden branch repairs the problem with the already fixed coefficient
`lambda4^2`. No new parameter or compensating normalization is introduced.

The result also explains why gravity and time can use the same process in the
current model. The Q update divides one global, reversible evolution into an
accessible history and an inaccessible complement. Local time is registered
along the accessible history; the gravitational response measures the same
loss in accessible phase-space weight. This statement is a physical
interpretation of the exact split, not a theorem identifying a real horizon
with the finite code.

## Honest boundary

The proved symplectic form is the one naturally carried by the complex
one-particle TT code. It has not been identified with the complete constrained
ADM symplectic form or the Henneaux--Teitelboim two-prepotential form. The
visible/hidden branch index is also distinct from the electric/magnetic
prepotential index.

The remaining field-theory task is now very specific. Construct a local
horizon map from the physical prepotential phase space into this enlarged
one-particle space and prove that it:

1. pulls the code symplectic form back to the normalized gravitational form;
2. intertwines the full time-dependent prepotential generator, including its
   constraints and source frame;
3. makes ordinary stress-energy select the exterior metric coordinate;
4. reduces to the quartic dilation on the TT one-graviton subspace.

Passing that test would promote the present kinematic isometry into a
linearized physical mechanism. A failure of the symplectic pullback or source
intertwining would precisely locate the remaining obstruction.

## Proof artifacts and primary references

- `GravityScreening/ErasureSymplectic.lean`
- `GravityScreening/TTGeneralizedCurl.lean`
- `GravityScreening/ErasureDilation.lean`
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
