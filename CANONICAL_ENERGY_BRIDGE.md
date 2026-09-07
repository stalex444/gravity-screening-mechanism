# From Fisher contraction to gravitational canonical energy

## The established physics dictionary

Relative entropy has a second gravitational meaning besides microscopic cell
counting.  For perturbations of a ball-shaped vacuum region in a holographic
CFT, Lashkari and Van Raamsdonk showed that its quantum Fisher metric equals
the canonical-energy metric of the corresponding AdS-Rindler wedge:

\[
g_{\rm Fisher}(\delta\rho,\delta\rho)
=\mathcal E_{\rm can}(h,h).
\]

Canonical energy is constructed from the gravitational symplectic form.  For
an Einstein-Hilbert sector with a fixed normalized metric perturbation `h`, its
gravitational normalization is proportional to the inverse Newton coupling:

\[
\mathcal E_{\rm can}(h,h)
=\frac{1}{G}\,W(h,h),
\]

up to conventional constants and any separately controlled matter
contribution.  This supplies a direct route from an information metric to the
coefficient of the gravitational kinetic term.

The result is established in a holographic AdS-Rindler setting.  Applying it
to a general local causal horizon or observer crossed product requires an
extension; the existing theorem is strong evidence for the form of the target,
not a general theorem about every horizon algebra.

## The PDT consequence under a same-mode identification

The quartic erasure channel gives

\[
g^{Q}_{\rm Fisher}=S_Qg^{0}_{\rm Fisher}.
\]

If both sides describe the same normalized geometric perturbation `h`, then

\[
\frac{1}{G_Q}W(h,h)
=S_Q\frac{1}{G_0}W(h,h).
\]

For a nonzero mode this forces

\[
\boxed{
\frac{1}{G_Q}=\frac{S_Q}{G_0},
\qquad
G_Q=\frac{G_0}{S_Q}.}
\]

This is exactly the screening direction in the deposited gravity formula.  It
does not require interpreting the Fisher volume as a literal count of cells:
the Fisher bilinear itself becomes the gravitational kinetic bilinear.

## The normalization ambiguity

The coupling conclusion is not automatic.  Write a scalar canonical-energy
model as

\[
\mathcal E(\kappa,a,W)=\kappa a^2W,
\qquad \kappa=1/G,
\]

where `a` is the perturbation amplitude and `W` is its unit-shape pairing.  An
observed contraction

\[
\mathcal E_1=S_Q\mathcal E_0
\]

has two simple readings:

1. with the same nonzero mode amplitude, `kappa_Q=S_Q kappa_0`, giving
   `G_Q=G_0/S_Q`;
2. at fixed coupling, `a_Q^2=S_Q a_0^2`, giving a smaller perturbation and no
   change in `G`.

More generally, amplitude and coupling can trade against each other.  The
Fisher contraction determines Newton's constant only after the geometric mode
normalization is fixed independently.

`GravityScreening/CanonicalEnergy.lean` kernel-checks both readings and the
exact equivalence between inverse-coupling scaling and the PDT inverse
response.

## How the preceding results constrain the ambiguity

The repository now contains two possible normalization anchors:

- the Stinespring dilation preserves the global expectation of every finite
  diagonal observable when exterior and hidden branches are both counted;
- the two-dimensional Fisher-area theorem fixes the induced horizon area form
  and its coframe amplitude.

If the globally conserved observable is Jacobson's physical heat flux, or if
the compared perturbations are fixed by the same physical area deformation,
then the mode amplitude cannot simply absorb the Fisher contraction.  The
remaining factor must sit in the gravitational response coefficient.

This produces a concise combined hypothesis:

> The quartic erasure channel relates microscopic and effective descriptions
> of the same flux-normalized horizon perturbation, and its BKM metric is the
> canonical-energy metric of that perturbation.

Under this hypothesis, the inverse Newton response follows exactly.  The
hypothesis is narrower than declaring information to be area: it specifies the
mode, its normalization, and the bilinear form that must intertwine.

## Constraint from horizon-cut evolution

The crossed-product horizon identity adds an important qualification. At
successive cuts within one theory, the common asymptotic charge and fixed `G`
give

\[
\frac{1}{G}\frac{A_1-A_0}{4}=-(K_1-K_0).
\]

Consequently a cut-to-cut contraction `K_1=S_Q K_0` is balanced by a change in
area at fixed coupling. It cannot be counted as an independent derivation of
`G_Q=G_0/S_Q`. The canonical-energy argument must instead be a fixed-cut
comparison between microscopic and effective descriptions of the same
normalized perturbation. The asymptotic charge cannot fix this comparison by
itself because it already contains `1/G`.

The exact algebra and the resulting two-axis construction are in
[`CUT_VS_COUPLING_AUDIT.md`](CUT_VS_COUPLING_AUDIT.md).

## Relation to the two-dimensional area route

The two bridges are complementary:

- the canonical-energy bridge explains why a Fisher-metric coefficient can
  become `1/G`;
- the information-area bridge explains why a four-dimensional horizon cut
  carries exactly one power of `S_Q` and why its coframe carries
  `sqrt(S_Q)`.

If the same observer-horizon construction realizes both, the result is
overdetermined: the kinetic normalization and the horizon area density acquire
the same coefficient by independent aspects of one information geometry.
That agreement would be much stronger than a numerical match.

## Decisive construction

The next operator-algebraic target is a fixed-cut microscopic-to-effective
channel `C_Q` and a map from its tangent space to normalized geometric
perturbations such that

\[
g_{\rm BKM}(C_{Q*}X,C_{Q*}Y)
=S_Qg_{\rm BKM}(X,Y)
\]

and

\[
g_{\rm BKM}(X,Y)
=\mathcal E_{\rm can}(h_X,h_Y)
\]

hold with the same physical flux or area normalization on both sides.  The
first equation is already proved for the finite channel.  The second is the
known holographic dictionary in a restricted setting and the required local
horizon extension here. This horizontal matching must also commute with the
vertical, fixed-`G` evolution between horizon cuts.

This route fails if the channel changes the normalized geometric mode, if the
matter part of canonical energy absorbs the contraction, or if the
crossed-product sharp-horizon limit does not preserve the BKM bilinear.

## References

- N. Lashkari and M. Van Raamsdonk, *Canonical Energy is Quantum Fisher
  Information*, <https://arxiv.org/abs/1508.00897>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*,
  <https://arxiv.org/abs/1505.04753>.
- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
