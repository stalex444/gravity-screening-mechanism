# One quartic dilation for the complete null canonical potential

## The full intrinsic potential

The intrinsic symplectic potential of general relativity on a null
hypersurface contains three canonical blocks:

\[
\Theta_B
=\frac12\epsilon_B\sigma^{AB}\delta\gamma_{AB}
-\epsilon_B\omega_a\delta L^a
+\epsilon_B\delta\mu.
\]

They are respectively:

- the spin-two pair of densitized shear and conformal cut metric;
- the spin-one pair of densitized twist and null generator; and
- the spin-zero pair of null volume density and boundary pressure or clock
  variable.

For a Fourier-paired mode in four spacetime dimensions, these carry two, two,
and one components.  `GravityScreening/NullBoundarySymplecticDilation.lean`
packages them as a five-component canonical momentum and configuration
variation.  The minus sign and density factors belong to the corresponding
momentum entries.

## The exact dilation theorem

Apply the same finite erasure dilation to both members of every canonical
pair.  For any `0 <= s <= 1`, Lean proves

\[
\Theta_{\rm full}(V_sP,V_s\delta Q)=\Theta(P,\delta Q),
\]

\[
\Theta_{\rm ext}(V_sP,V_s\delta Q)=s\,\Theta(P,\delta Q),
\]

and

\[
\Theta_{\rm hid}(V_sP,V_s\delta Q)=(1-s)\,\Theta(P,\delta Q).
\]

These statements hold for arbitrary data, so they apply simultaneously to
all three spin blocks and to any mixture among them.

At the quartic value,

\[
s=S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\]

the complete result is

\[
\boxed{
\Theta_{\rm full}=\Theta,
\qquad
\Theta_{\rm ext}=S_Q\Theta,
\qquad
\Theta_{\rm hid}=\lambda_4^2\Theta.}
\]

No spin sector receives an independent screening coefficient.

## Why this matters

The spin-two mode reduction had already shown that the null shear--conformal
metric pair becomes the oscillator whose endpoint action is the quartic
boundary generator.  A possible obstruction remained: the spin-one twist and
spin-zero area or clock pairs might require a different channel weight and
therefore prevent the spin-two transfer from extending to a full null
boundary.

The new theorem rules out that algebraic obstruction for the Q dilation.  The
single dilation is symplectic on the complete visible-plus-hidden system and
conformally symplectic on the exterior system with the same factor `S_Q` in
every block.  The clock, twist, and graviton data can therefore participate in
one globally conserved null canonical map.

This result also clarifies the relation between time and gravity in the
mechanism.  The spin-zero null momentum `mu` depends on the normalization of
the null generator, which Hopfmüller and Freidel describe as a choice of clock
along the boundary.  The same Q dilation that weights the spin-two graviton
pair also weights this clock pair, while their combined visible-plus-hidden
symplectic potential remains unchanged.

## Honest boundary

This is an exact compatibility and uniqueness-of-coefficient result.  It does
not prove that a physical observer horizon implements the Q dilation.  The
operation has been applied uniformly to the canonical data and then checked
against the full null symplectic structure.

The remaining field-theory target is correspondingly narrower: derive the
exterior/hidden map from the observer restriction or horizon gluing rule.  If
that derivation produces the source column

\[
(\sqrt{S_Q},-\lambda_4),
\]

the existing uniqueness theorem forces the complete oriented splitter and
its phase.  The mechanism fails if the physical gluing rule produces a
different column, mixes the three spin blocks incompatibly, or introduces a
corner coefficient not fixed by the intrinsic potential.

## Kernel artifact and primary source

`GravityScreening/NullBoundarySymplecticDilation.lean` proves:

- decomposition of the packed five-component potential into its three spin
  blocks;
- preservation of the complete null canonical potential;
- exterior scaling by `s`;
- hidden scaling by `1-s`; and
- the quartic global/exterior/hidden capstone with exact weights `1`, `S_Q`,
  and `lambda4^2`.

The file compiles without `sorry` and uses only Mathlib's standard logical
axioms.

- Florian Hopfmüller and Laurent Freidel, *Null Conservation Laws for
  Gravity*, especially equations (2)--(4):
  <https://arxiv.org/abs/1802.06135>
- Abhay Ashtekar and Simone Speziale, *Null Infinity and Horizons: A New
  Approach to Fluxes and Charges*: <https://arxiv.org/abs/2407.03254>

