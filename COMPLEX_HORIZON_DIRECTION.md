# The hidden horizon branch and the quartic imaginary direction

## Result

The remaining information-to-trace map has a unique normal form.

The finite horizon dilation has two orthogonal branches: one remains visible
to the exterior observer and one carries the state into the hidden system.
After removing their fixed amplitudes, the two branch vectors span an
orthonormal real two-plane inside the full Hilbert space.

Represent that oriented real plane by the real plane underlying `C`, and send
the normalized visible branch to `1`. Lean proves that every normalized
real-orthogonal hidden direction is then

\[
u=+i\quad\text{or}\quad u=-i.
\]

A chosen positive orientation selects `+i`. Reversing the orientation changes
the sign but none of the quadratic weights.

This removes a continuous freedom from the proposed bridge. Once the visible
axis, normalization, and orientation are fixed, there is no adjustable angle
between the horizon defect and the imaginary direction.

## Why the same direction becomes timelike

The complex place carries two real quadratic readings. With conjugation, the
hidden unit has positive norm:

\[
h(i,i)=+1.
\]

Without conjugation, the intrinsic trace form gives

\[
g(i,i)=-1.
\]

Lean proves this for every normalized direction real-orthogonal to `1`, so it
does not depend on choosing `+i` rather than `-i`.

For a response amplitude `a`, define

\[
z(a,u)=1+a u.
\]

The two forms are then

\[
h(z,z)=1+a^2,
\qquad
g(z,z)=1-a^2.
\]

At the quartic amplitude

\[
a=\lambda_4=1-\frac1Q,
\]

the second expression is exactly

\[
g(z,z)=1-\lambda_4^2=S_Q.
\]

The same Lean theorem also equates `lambda4^2` with the hidden Born mass of
the tetrahedral Perron branch and equates `1-lambda4^2` with the global
quartic trace response. The local complex-place calculation, the finite
horizon dilation, and the global `(3,1)` trace geometry now meet at one exact
scalar identity.

## What has become forced

Conditional on representing the real branch plane in the quartic complex
place, the following pieces are fixed:

1. the hidden unit is `+i` or `-i`;
2. orientation chooses between the two;
3. the intrinsic trace assigns it the unique negative sign;
4. the modular/Perron construction fixes its amplitude to `lambda4`;
5. the Born mass is `lambda4^2`;
6. the visible Lorentzian response is `1-lambda4^2=S_Q`.

No mixing angle, normalization coefficient, or additional continuous
coupling remains in this two-plane calculation.

## Exact boundary

The theorem is a normal-form and uniqueness result. It does not prove that the
abstract real plane spanned by the two Stinespring branches is physically the
same plane as the unique complex place of the quartic number field.

That identification is meaningful but substantive. The Stinespring branches
live in a tensor-product Hilbert space, while the arithmetic complex place is
a real two-plane carrying both the positive conjugation-twisted form and the
indefinite trace form. A real isometry between the branch plane and `C` always
exists. PDT must still show why the horizon algebra selects the arithmetic
one, and why its untwisted trace form supplies the Einstein kinetic response.

This also respects the existing environment-frame result. Gram data determine
the overlap but do not select a physical pointer basis. Fixing the visible
branch and orientation gives the unique complex normal form after that choice;
it does not choose which microscopic environment vector is visible.

The remaining physical statement can now be written in one sentence:

> The oriented real plane of the minimal quartic horizon dilation is the
> complex-place plane of the quartic arithmetic system, with its positive form
> governing Born weights and its untwisted trace form governing gravitational
> response.

If this statement is supplied by the observer algebra or the microscopic
action, the factor `S_Q` follows without another coefficient.

## Kernel artifact

`GravityScreening/ComplexHorizonDirection.lean` proves:

- `complex_orthogonal_unit_eq_I_or_neg_I`;
- `complex_oriented_orthogonal_unit_eq_I`;
- `complex_orthogonal_unit_two_forms`;
- `complexHorizonResponse_two_forms`;
- `quartic_complex_hidden_direction_bridge`.

The declarations contain no `sorry` and use only Mathlib's standard
foundational axioms.
