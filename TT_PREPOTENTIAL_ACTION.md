# The quartic factor in the time-dependent graviton action

## The action being tested

Barnich and Troessaert give a local, duality-symmetric action for linearized
gravity in terms of two symmetric prepotentials `H^1` and `H^2`, together with
the fields that impose the gravitational constraints. On the physical
transverse-traceless sector, their integrated canonical term can be written

\[
-2\Delta\,\langle\mathcal O H^2,\dot H^1\rangle,
\]

and their Hamiltonian reduces on the constraint surface to

\[
\sum_{a=1}^2\langle H^a,\Delta^2H^a\rangle.
\]

Here `O` is the generalized spin-two curl. For a Fourier mode of spatial
momentum `k`,

\[
\Delta=-k^2,
\qquad
\mathcal O^2=k^2.
\]

The two-valued prepotential index `a` is the gravitational electric/magnetic
duality index. It is separate from the plus/cross polarization index and from
the exterior/hidden branch index of the horizon dilation.

## The exact Lean model

`GravityScreening/TTPrepotentialAction.lean` represents each of the two
prepotentials by its canonically normalized complex plus/cross vector. It then
defines the fixed-mode terms

\[
K_k(H,\dot H)
=\operatorname{Re}\left[
2k^2\langle\mathcal O_kH^2,\dot H^1\rangle
\right],
\]

\[
\mathcal H_k(H)
=\operatorname{Re}\left[
k^4\sum_{a=1}^2\langle H^a,H^a\rangle
\right],
\qquad
L_k=K_k-\mathcal H_k.
\]

The inner product uses the `sqrt(2)`-normalized TT code proved earlier, so it
equals the full tensor Frobenius pairing rather than an arbitrarily normalized
two-vector pairing.

Apply the finite erasure dilation independently to the polarization data of
each prepotential:

\[
V_sH^a
=\sqrt{s}\,H^a_{\rm ext}
\oplus\sqrt{1-s}\,H^a_{\rm hid}.
\]

Lean proves that the generalized curl intertwines this map and that the full
Hermitian pairing is preserved. Those two facts are exactly what is needed to
lift the dilation through both parts of the TT action.

## The three action identities

The kernel-checked result is

\[
L_k^{\rm full}(V_sH,V_s\dot H)=L_k(H,\dot H).
\]

The complete visible-plus-hidden evolution retains the original
time-dependent graviton action mode by mode.

The exterior restriction is

\[
L_k^{\rm ext}(V_sH,V_s\dot H)=sL_k(H,\dot H),
\]

and the hidden restriction is

\[
L_k^{\rm hid}(V_sH,V_s\dot H)=(1-s)L_k(H,\dot H).
\]

At the quartic value,

\[
L_k^{\rm ext}=S_Q L_k,
\qquad
L_k^{\rm hid}=\lambda_4^2L_k,
\qquad
S_Q=\frac{2Q-1}{Q^2},
\qquad
S_Q+\lambda_4^2=1.
\]

Both the canonical term and Hamiltonian receive the same coefficient in each
branch. The result is therefore a uniform action normalization, rather than a
change in propagation speed or an imbalance between kinetic and restoring
terms.

## Why this matters for Newton's constant

A positive common multiplier of a source-free action cancels from its Euler
equations. The exterior graviton therefore keeps the ordinary massless wave
equation, its two polarizations, and its light cone. This agrees with the
generalized-curl and no-birefringence theorems.

The same multiplier does not cancel against a matter source whose physical
normalization is held fixed. In a schematic exterior action

\[
S_{\rm ext}=S_Q S_{\rm grav}+S_{\rm matter},
\]

variation gives an inverse gravitational response. The earlier source-frame
and same-physical-metric theorems then yield

\[
G_Q=\frac{G_0}{S_Q}.
\]

The new result supplies the missing action-side fact: on every physical TT
Fourier mode, the quartic dilation multiplies the complete exterior graviton
Lagrangian by exactly the same `S_Q` that appears in the proposed Newton
response.

This also clarifies the relation between time and gravity in the model. The
time-dependent canonical term and the gravitational energy are partitioned
by one and the same Q update. Globally the action is unchanged; locally the
observer sees only the `S_Q` portion. Gravity is affected through the
normalization of the accessible action, while the clock interpretation comes
from following that accessible branch through successive updates.

## Honest status

This is an exact instantiation of the published **TT prepotential action** and
the strongest action-level compatibility result in the repository. It is not
yet a derivation of the full physical identification.

Three boundaries remain:

1. The finite Q dilation has been constructed and shown to act correctly on
   the normalized TT data, but a local horizon field theory has not forced
   this particular dilation on the physical prepotential.
2. The lapse, shift, longitudinal, trace, and ordinary stress-energy source
   terms of the complete constrained action have not been carried through
   this new dilation in one theorem. Separate repository results cover their
   algebraic source frame and Pauli--Fierz closure.
3. The calculation is linearized. It makes no claim that free gravitational
   duality extends unchanged to nonlinear general relativity.

The next decisive object is a single constrained-action commuting diagram:

\[
\text{physical prepotential phase space}
\xrightarrow{\quad E_Q\quad}
\text{visible}\oplus\text{hidden horizon space},
\]

with the kinetic term, Hamiltonian, constraints, and ordinary electric source
all intertwining at once. The TT propagating block of that diagram is now
proved. The remaining work is the nondynamical constraint and source block,
plus the physical derivation of `E_Q` from the Q horizon algebra.

## Proof artifacts and primary source

- `GravityScreening/TTPrepotentialAction.lean`
- `GravityScreening/ErasureSymplectic.lean`
- `GravityScreening/TTGeneralizedCurl.lean`
- `GravityScreening/TTHorizonCode.lean`
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*, especially equations 2.16--2.21, 3.7--3.8, and
  3.21--3.22: <https://arxiv.org/abs/0812.0552>
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
