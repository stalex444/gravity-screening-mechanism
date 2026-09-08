# The quartic oscillator on an intrinsic null horizon

## The published null canonical pair

Hopfmüller and Freidel decompose the intrinsic symplectic potential of general
relativity on a null hypersurface into spin-two, spin-one, and spin-zero
canonical pairs.  The spin-two contribution is

\[
\Theta^{(2)}_B
=\frac12\,\epsilon_B\,\sigma^{AB}\,\delta\gamma_{AB},
\]

where `gamma_AB` is the unit-determinant conformal metric on the spacelike
cuts, `sigma_AB` is the shear, and `epsilon_B` is the null-boundary density.
This identifies the conformal metric as the spin-two configuration variable
and one half of the densitized shear as its canonical momentum.

The choice is intrinsic to the null hypersurface.  Hopfmüller and Freidel
explain that it differs from the standard covariant symplectic potential by a
corner term fixed so that the potential depends only on the intrinsic and
extrinsic geometry of the null boundary.

## Fixed-mode reduction

At unit cut density, restrict the two tensors to either circular
transverse-traceless Fourier mode.  The circular basis vectors

\[
e_+=(1,i),\qquad e_-=(1,-i)
\]

both have Hermitian norm squared two.  Write the densitized shear amplitude
as `p` and the conformal-metric variation as `delta q`.  Lean proves

\[
\frac12\langle p e_\pm,(\delta q)e_\pm\rangle
=p\,\delta q.
\]

The factor one half in the geometric null symplectic potential cancels the
norm two of the TT circular basis.  No adjustable normalization remains in
the fixed-mode canonical pairing.

## Agreement with the spin-two prepotential action

The independent fixed-mode calculation from the Barnich--Troessaert
duality-symmetric spin-two action gives

\[
K_k=4k^3p\dot q
\]

on either helicity, once the negative-helicity prepotential momentum is given
the orientation fixed by its negative curl eigenvalue.  Lean now proves

\[
\frac{K_k}{4k^3}
=\Theta^{(2)}_B(p,\dot q)
=p\dot q.
\]

After changing to the dimensionless mode phase `tau=k t`, the full action is

\[
\frac{L_k}{4k^4}
=p q'-\frac{q^2+p^2}{2}.
\]

Thus the unit oscillator used by the quartic bulk-to-boundary calculation is
simultaneously:

1. the circular-mode reduction of the duality-symmetric TT graviton action;
2. the circular-mode reduction of the intrinsic null-horizon spin-two
   symplectic pair; and
3. the Hamiltonian system whose endpoint action is the quartic boundary
   generator.

## Quartic endpoint

For the oscillator Hamiltonian

\[
H=\frac{q^2+p^2}{2},
\]

the kernel-checked endpoint function is

\[
F_\theta(q_-,q_+)
=\frac{q_-q_+-\tfrac12\cos\theta(q_-^2+q_+^2)}{\sin\theta}.
\]

At the quartic phase,

\[
\sin\theta_Q=\lambda_4,
\qquad
\cos\theta_Q=\sqrt{S_Q},
\]

Lean proves that this is exactly the previously derived horizon boundary
generator.  It also proves the Hamilton--Jacobi equation: differentiating the
endpoint function with respect to phase returns the conserved outgoing
oscillator Hamiltonian, with the sign convention `F=-S` used in the
repository.

## What changed

The bulk oscillator is no longer only a finite-dimensional system chosen for
its transfer matrix.  Its canonical pair is the standard spin-two pair on an
intrinsic null surface, and its action is the fixed-mode reduction of the
published linearized graviton action.  The quartic boundary functional is its
on-shell endpoint action.

The quartic phase also is not an additional continuous physical parameter.
Once the Q dilation is identified with the horizon channel, its conserved
amplitude column is `(sqrt(S_Q),-lambda4)`.  Orthogonality and orientation
uniquely fix the complete rotation and therefore `theta_Q`.

## Remaining physical identification

The remaining question is whether the physical observer restriction on a
null horizon is the quartic dilation already constructed in the repository.
The present theorem identifies the correct gravitational phase space and
shows that the proposed transfer acts on it without a normalization mismatch.
It does not derive `lambda4` from the Einstein equations alone.

A full fixed-mode symplectic check now tracks the null spin-one and spin-zero
pairs together with this spin-two block.  Lean proves that applying the same Q
dilation to all five canonical components preserves the complete potential
and weights every exterior block by `S_Q`, with hidden complement
`lambda4^2`; see
[`NULL_BOUNDARY_SYMPLECTIC_DILATION.md`](NULL_BOUNDARY_SYMPLECTIC_DILATION.md).
Existing repository theorems separately treat lapse/shift source closure in
the fixed-mode doubled action.  The decisive remaining calculation is to
derive this dilation from the physical observer restriction while preserving
the ordinary electric source ray and the intrinsic corner convention.

The mechanism fails if the intrinsic boundary polarization produces a
different two-port column, if a corner term supplies an independent quadratic
coefficient, or if the spin-one or spin-zero sectors obstruct the same source
frame.

## Kernel artifact and primary sources

`GravityScreening/NullHorizonSpinTwoMode.lean` proves:

- the intrinsic null spin-two pairing on each circular helicity;
- equality with the normalized TT prepotential kinetic term for each
  helicity;
- equality of each full TT mode action with the null oscillator action; and
- the quartic null spin-two Hamilton--Jacobi capstone.

The file compiles without `sorry` and uses only Mathlib's standard logical
axioms.

- Florian Hopfmüller and Laurent Freidel, *Null Conservation Laws for
  Gravity*, especially equations (2) and (4):
  <https://arxiv.org/abs/1802.06135>
- Glenn Barnich and Cédric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>
- Luis Lehner, Robert C. Myers, Eric Poisson, and Rafael D. Sorkin,
  *Gravitational action with null boundaries*:
  <https://arxiv.org/abs/1609.00207>
