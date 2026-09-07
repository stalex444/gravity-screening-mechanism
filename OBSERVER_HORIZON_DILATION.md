# An explicit observer-horizon dilation of the quartic erasure channel

## Result

The quartic modular-erasure proposal now has an explicit finite horizon-cell
realization.  Let `H` be any finite-dimensional input state space.  Enlarge
the exterior system by one erasure state `|e>` and the hidden system by one
vacuum state `|0>`.  For

\[
S_Q=1-\lambda_4^2,
\qquad
\lambda_4=1-\frac1Q,
\]

define

\[
V_Q|\psi\rangle
=\sqrt{S_Q}\,|\psi\rangle_{\rm out}|0\rangle_{\rm hid}
+\lambda_4|e\rangle_{\rm out}|\psi\rangle_{\rm hid}.
\]

The two branches are orthogonal.  Therefore

\[
\|V_Q\psi\|^2
=S_Q\|\psi\|^2+\lambda_4^2\|\psi\|^2
=\|\psi\|^2.
\]

Thus `V_Q` is norm-preserving.  It can be extended to a unitary on a larger
space by the standard completion of an isometry.

## What each observer sees

Tracing over the hidden system gives

\[
\rho_{\rm out}
=S_Q|\psi\rangle\!\langle\psi|
+\lambda_4^2|e\rangle\!\langle e|.
\]

This is exactly the normalized erasure channel used in the information-
geometry calculation.  Its retained data block has the gravity coefficient

\[
S_Q=\frac{2Q-1}{Q^2},
\]

and its erasure flag has weight `lambda4^2`.

Tracing over the exterior system gives the complementary state

\[
\rho_{\rm hid}
=S_Q|0\rangle\!\langle0|
+\lambda_4^2|\psi\rangle\!\langle\psi|.
\]

The state removed from the exterior data block appears intact in the hidden
data block.  The construction therefore proves a precise form of global
information conservation:

\[
\boxed{
\text{exterior information loss}
=\text{information transferred across the horizon}.}
\]

The exterior arrow of time arises when the hidden system is causally
inaccessible and successive accessible algebras omit everything transferred
in earlier steps.  The global state remains pure under `V_Q`; irreversibility
belongs to the observer's restriction.

## Why this advances the gravity argument

The gravity paper uses `S_Q` as the fraction of microscopic entropy density
available to the local horizon observer.  The dilation supplies an exact
mechanism for that sentence.  The observer receives the complete state with
weight `S_Q` and a state-independent erasure flag with weight `lambda4^2`.
Consequently relative entropy between any two possible inputs is contracted
by `S_Q`, while the complementary channel contains the missing state.

The construction also explains why the square is unavoidable.  The quartic
inverse-step residue `lambda4` is a Hilbert-space amplitude.  Partial tracing
uses the squared branch amplitude, so the hidden probability is
`lambda4^2`; normalization leaves `1-lambda4^2` outside.  Neither coefficient
is inserted after the channel is chosen.

## Exact boundary of the result

This proves the microscopic channel at the level of one finite horizon cell.
It does not yet identify that cell with a local algebra in a relativistic
spacetime net.  The remaining construction must supply:

1. an observer or continuous-core algebra containing the quartic modular
   mode;
2. a net-compatible inclusion assigning the two output systems to opposite
   sides of a causal horizon;
3. modular covariance, so the `1/Q` step is the physical observer's horizon
   evolution;
4. the area-density rule that counts one such channel per microscopic horizon
   cell.

The finite channel can no longer be the obstruction.  Any failure must occur
in the spacetime localization, modular covariance, or area-density
identification.

## Kernel artifact

`GravityScreening/ErasureDilation.lean` constructs the map for an arbitrary
finite input dimension and proves:

- `erasureDilation_normSq`: total squared norm is preserved;
- `erasureDilation_exterior_data`: the exterior data block has weight `s`;
- `erasureDilation_exterior_flag`: the erasure flag has weight `1-s`;
- `erasureDilation_hidden_data`: the hidden data block contains the input with
  weight `1-s`;
- the vacuum weight and both off-diagonal blocks of each reduced state are
  computed explicitly;
- `quarticErasureDilation_normSq`: the quartic specialization is an isometry;
- `quarticErasureDilation_exterior_data`: the exterior weight is exactly
  `(2Q-1)/Q^2`;
- `quarticErasureDilation_exterior_flag`: the exterior erasure flag has weight
  `lambda4^2`;
- `quarticErasureDilation_hidden_data`: the hidden weight is exactly
  `lambda4^2`;
- `quarticErasureDilation_hidden_vacuum`: the hidden vacuum has weight
  `(2Q-1)/Q^2`.

The theorem receipts use only the standard Mathlib axioms `propext`,
`Classical.choice`, and `Quot.sound`.
