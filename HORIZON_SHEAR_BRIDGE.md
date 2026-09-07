# Horizon shear as the meeting point of information and gravity

This note tests the most local version of the proposed information-to-gravity
mechanism. It uses the physical two-polarization sector already isolated in
`GravityScreening/TransverseTracelessCount.lean` and asks whether the quartic
factor can be read directly in the gravitational energy carried by a horizon
shear.

The result is both constructive and limiting. The calculation lands on the
right coefficient exactly, but it also proves that the shear-squared law alone
cannot distinguish a change of gravitational coupling from a change of wave
amplitude.

## Published physics input

For a four-dimensional Killing horizon, Faulkner and Speranza derive a
gravitational contribution to the horizon average null energy which reduces,
in the perturbative limit, to the square of the horizon shear. Their
crossed-product construction also identifies the algebraic entropy with
generalized entropy at semiclassical order. This supplies a concrete local
object where the observer algebra, gravitational radiation, and a quadratic
information-sensitive quantity meet.

Separately, Lashkari and Van Raamsdonk prove in the AdS-Rindler setting that
quantum Fisher information is the gravitational canonical-energy metric.
That theorem is restricted to perturbations of a holographic CFT ball and its
dual AdS-Rindler wedge. Extending the equality to the local observer horizon
used here remains a physical hypothesis.

## Two physical shear coordinates

For momentum along the third spatial direction, a real symmetric transverse
traceless tensor is

\[
h_{ij}(a,b)=
\begin{pmatrix}
a&b&0\\
b&-a&0\\
0&0&0
\end{pmatrix}.
\]

The existing Lean theorem proves that every tensor satisfying the symmetry,
transversality, and tracelessness conditions has this form. The new direct
calculation gives

\[
\langle h(a,b),h(a',b')\rangle_F
=2(aa'+bb'),
\qquad
\|h(a,b)\|_F^2=2(a^2+b^2).
\]

Thus the physical polarization space is positive and two-dimensional. A
four-dimensional horizon shear is also a symmetric traceless tensor on a
two-dimensional horizon cut, so it has the same two-coordinate quadratic
form. Identifying these coordinates with the local horizon shear is the
standard geometric placement, rather than an arithmetic theorem.

## Physical versus canonical normalization

Faulkner and Speranza make the relevant normalization explicit. They expand
the physical metric as

\[
g_{ab}=g^0_{ab}+\varkappa h_{ab},
\qquad
\varkappa^2=32\pi G,
\]

so that `h` has a canonical quadratic kinetic term. On the horizon their
physical shear and canonically normalized traceless perturbation obey

\[
\sigma_{ab}=\frac{\varkappa}{2}\dot\rho_{ab},
\qquad
t^{(g)}_{vv}=\dot\rho^{ab}\dot\rho_{ab}.
\]

Eliminating the canonical coordinate gives

\[
t^{(g)}_{vv}=\frac{\sigma^{ab}\sigma_{ab}}{8\pi G}.
\]

This fixes the proportionality hidden in the scalar model below. For the same
physical nonzero shear, the canonical graviton energy really does scale as
`1/G`. `GravityScreening/HorizonShearNormalization.lean` checks the complete
algebra including the factor `8*pi`, proves that the conversion is invertible,
and proves that an `S_Q` contraction at fixed physical shear is equivalent to
`G_Q=G_0/S_Q`.

## Exact quartic contraction

Let

\[
d_Q^2=S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

Then scaling both shear coordinates by `d_Q` gives

\[
\|h(d_Qa,d_Qb)\|^2
=S_Q\|h(a,b)\|^2.
\]

If the shear contribution to canonical energy is written, with fixed
geometric conventions absorbed into the coefficient, as

\[
\mathcal E_G(a,b)=\frac1G\,2(a^2+b^2),
\]

then Lean proves the exact equality

\[
\mathcal E_{G_0}(d_Qa,d_Qb)
=\mathcal E_{G_0/S_Q}(a,b).
\]

This is the desired numerical and algebraic coincidence: if the quartic
coframe amplitude from the information construction acts on the physical
shear coordinates, it produces precisely the screening factor in their local
quadratic energy.

## The reverse audit: an exact degeneracy

The preceding equality is not yet a derivation of Newton's coupling. It
exhibits an exact ambiguity:

* fixed `G`, smaller shear amplitude `d_Q h`;
* fixed nonzero shear `h`, smaller inverse coupling `S_Q/G_0`.

Both give the same quadratic energy. No measurement or formula involving
only shear-squared can distinguish them.

For a fixed nonzero physical shear, however, the ambiguity disappears. The
new theorem proves

\[
\mathcal E_{G_Q}(a,b)=S_Q\mathcal E_{G_0}(a,b)
\quad\Longleftrightarrow\quad
\frac1{G_Q}=\frac{S_Q}{G_0},
\]

and therefore

\[
\boxed{G_Q=\frac{G_0}{S_Q}
=\frac{G_0}{(2Q-1)/Q^2}.}
\]

This final implication is exact and kernel checked. Its physical premise is
that the microscopic and effective descriptions compare the same nonzero
horizon shear, with its normalization fixed independently of the information
channel.

## From radiative shear to static gravity

Horizon shear belongs to the propagating two-polarization sector, while the
Newtonian field of a stationary source is carried by the spin-two constraint
sector. They cannot be identified component by component. Gauge consistency
provides the bridge.

For the complete local two-derivative massless spin-two operator, the Ward
identity and formal self-adjointness leave one overall coefficient. Once the
coefficient of the transverse-traceless wave term is `S_Q`, every term in the
Pauli--Fierz operator, including the lapse and shift constraint terms, must
carry the same `S_Q`.

The new capstone theorem composes this uniqueness result with the sourced
two-channel reduction:

\[
\text{same-mode shear contraction }S_Q
\Longrightarrow
E_{\rm PF,Q}=S_QE_{\rm PF,0}
\Longrightarrow
S_QE_{\rm PF,0}(h)=T.
\]

Thus ordinary matter sees the inverse response `1/S_Q`. No second arithmetic
choice is made in the static sector. This is a complete theorem about the
linear effective system once the same-mode shear premise and the published
spin-two structure are supplied.

## What would close the physical step

The most economical target is now a normalization theorem or sourced
construction that fixes the local shear before the quartic channel acts. A
successful construction could use one of three anchors:

1. the same controlled horizon deformation fixes the geometric shear on both
   sides;
2. the same horizon area displacement and boundary data fix the normalization of the shear
   mode;
3. an isometric microscopic-to-effective map fixes the global mode norm while
   the exterior Fisher metric contracts.

Any one of these, if derived in the same observer-horizon model, prevents the
amplitude from absorbing `S_Q`. The factor must then reside in `1/G`, and the
screened Newton response follows.

The construction fails if the quartic channel merely prepares a smaller
classical perturbation, if matter canonical energy absorbs the contraction,
or if the sharp-horizon limit changes the mode normalization.

## Formal status

* **Mathematics:** the TT pairing, positivity, amplitude contraction,
  amplitude/coupling degeneracy, and fixed-mode Newton response are proved in
  Lean.
* **Published physics input:** perturbative horizon gravitational null energy
  is shear-squared; AdS-Rindler Fisher information equals canonical energy in
  its stated holographic domain.
* **Conditional physical identification:** the PDT quartic channel acts on the
  same independently normalized local horizon shear mode.
* **Open:** derive that identification and normalization inside one sourced,
  sharp-horizon observer construction.

## Lean artifact

`GravityScreening/HorizonShearBridge.lean` proves:

* `ttTensor_pairing`;
* `ttShearNormSq_smul`;
* `quarticShear_amplitude_contraction`;
* `quarticShear_amplitude_coupling_degeneracy`;
* `horizonShear_same_mode_iff`;
* `quarticHorizonShear_forces_newtonResponse`;
* `quarticHorizonShear_forces_fullPauliFierzNormalization`;
* `quarticHorizonShear_closes_completeLinearResponse`.

`GravityScreening/HorizonShearNormalization.lean` proves:

* `physicalShearNormSq_eq_eight_pi_G`;
* `canonicalEnergyFromPhysicalShear_recovers`;
* `quarticCanonicalEnergy_samePhysicalShear_iff_newtonResponse`.

All declarations compile without `sorry`.

## References

* T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
* N. Lashkari and M. Van Raamsdonk, *Canonical Energy is Quantum Fisher
  Information*, <https://arxiv.org/abs/1508.00897>.
* M. Henneaux and C. Teitelboim, *Duality in linearized gravity*,
  <https://arxiv.org/abs/gr-qc/0408101>.
