# Gravitational time dilation as the clock-to-geometry map

## The central distinction

The PDT clock and the arrow should be separated before either is coupled to
gravity.

The raw complex quartic mode has a radial factor and a phase factor. After the
radial factor is divided out, its projective action is an exact `U(1)`
rotation. The phase winds by the irrational quartic angle and therefore never
closes. Strictly speaking, the normalized phase rotates on the **unit circle**;
the **unit disk** is the arithmetic boundary that distinguishes settling,
marginal rotation, and escape.

There is also a second quartic unit-circle motion: the Perron/KMS modular
phase `Q^(-is)=exp(-is log Q)`. Its frequency is `log Q`, not the conjugate-root
angle `theta_Q`. The ratio of those two frequencies is transcendental, so no
algebraic portal coefficient converts one into the other. See
[`TWO_Q_CLOCKS_AUDIT.md`](TWO_Q_CLOCKS_AUDIT.md).

This gives four different operations:

1. **Projective clock carrier:** the norm-preserving conjugate-root rotation.
2. **Clock readout:** coupling the phase to the cubic record-forming sector or
   to an observer, so that a phase becomes an event.
3. **Horizon modular clock:** the phase with frequency `log Q`, whose Rindler
   energy and temperature have the invariant ratio `log Q`.
4. **Gravity:** the joint `pQ` geometry supplies the baseline scale, while the
   resolved quartic defect supplies the proposed screening response.

The existing covariance theorem proves that the finite information channel
commutes with the phase rotation. The clock can therefore keep winding at the
same spectral pitch while the observer's accessible information changes. The
rotation and the loss of accessibility belong to one compatible construction,
but they are not the same map.

## Where the portal coupling belongs

The deposited scalar portal is

\[
\kappa_{pQ}=\left(\frac{Q}{p}\right)^2.
\]

In the controlled-unitary clock model its observable interaction angle has
the form

\[
\Theta=\kappa_{pQ}g\,\tau,
\]

where `g` is the chosen local generator scale and `tau` is proper duration.
The arithmetic fixes `kappa_pQ`, but an observation of `Theta` cannot separate
`g` from `tau`. This was previously recorded as a scale obstruction. Gravity
suggests a better interpretation of it: a generally covariant theory should
not assign one observer-independent proper duration to every tick.

For a stationary observer with lapse `N`,

\[
d\tau=N\,dt.
\]

The same local generator written with respect to coordinate time is

\[
g_t=N g_\tau.
\]

Therefore

\[
\kappa_{pQ}g_t\,dt
=\kappa_{pQ}g_\tau\,d\tau.
\]

The phase is invariant while its rate in a chosen time coordinate is redshifted.
`GravityScreening/TimeDilation.lean` proves this reparametrization identity,
the inverse-lapse relation between proper-time frequencies, and the
corresponding two-observer frequency ratio.

The earlier inability of `kappa_pQ` to produce a duration in seconds may thus
be physically appropriate. The portal fixes a dimensionless interaction
strength. The observer's geometry supplies the local conversion between the
arithmetic flow parameter and proper time.

## Why this is relevant to gravity without deriving Newton's constant

Jacobson's local-horizon argument uses a boost Hamiltonian. If the boost
Killing field is rescaled by a constant, both the heat flux and the Unruh
temperature rescale by that constant. Their ratio is unchanged. The Lean
theorem `boost_normalization_cancels` records the scalar identity behind this
fact.

Time dilation can therefore perform an essential job without determining
`G`: it can identify how the arithmetic clock is read by a geometric observer.
Newton's coupling still comes from the entropy-area or canonical-energy
coefficient. This agrees with the placement audit, which showed that a common
factor on both heat and entropy sides cancels.

The roles are now:

\[
\begin{array}{rcl}
\theta_Q &\longrightarrow& \text{projective conjugate clock},\\
\log Q &\longrightarrow& \text{horizon modular clock},\\
p\text{-}Q\text{ portal} &\longrightarrow& \text{clock readout and records},\\
pQ\text{ ruler} &\longrightarrow& \text{unscreened gravitational scale},\\
Q\text{ defect }S_Q &\longrightarrow& \text{effective gravitational response},\\
g_{\mu\nu}\text{ lapse} &\longrightarrow& \text{proper time seen by an observer}.
\end{array}
\]

Gravity crosses both sectors because its baseline is the joint ruler, not a
pure quartic quantity. The quartic factor enters only after that joint scale is
resolved. In the deposited formula,

\[
\frac{M_{\mathrm{Pl},0}}{m_e}
=\frac{(pQ)^{112}}{\pi^2},
\qquad
M_{\mathrm{Pl},\mathrm{eff}}^2
=S_Q M_{\mathrm{Pl},0}^2.
\]

That is a `pQ`-anchored gravity theory with a `Q`-resolved response. Calling
the entire gravity mechanism purely quartic would omit its scale-setting half.

For the modular clock, the standard Rindler conversion is especially sharp:

\[
E_Q(a)=T_U(a)\log Q,
\qquad
e^{-E_Q/T_U}=Q^{-1}.
\]

This exact conditional chain is developed in
[`RINDLER_QUARTIC_CLOCK.md`](RINDLER_QUARTIC_CLOCK.md).

## The proposed clock-to-geometry equation

Let `s` denote the dimensionless arithmetic or modular parameter and let
`tau_x` be proper time along an observer worldline. The next physical target is
an intertwining relation of the form

\[
\pi\!\left(\sigma_s^{pQ}(A)\right)
=\alpha^{g}_{\tau_x(s)}\!\left(\pi(A)\right),
\qquad
\frac{d\tau_x}{ds}=L_g(x),
\]

where:

- `sigma_s^{pQ}` is the arithmetic modular flow;
- `pi` embeds the relevant `pQ` observer algebra into the horizon algebra;
- `alpha^g` is geometric time evolution;
- `L_g(x)` is the lapse-like conversion determined by the spacetime metric.

This equation directly concerns the `log Q` modular clock. It should preserve
that distinguished quartic spectral line. A
Connes cocycle may reparametrize its local rate, but it must not mix the line
with other frequencies. This is the precise mathematical place for
gravitational time dilation in PDT.

If the `theta_Q` projective clock is also to represent geometric proper time,
a second intertwining statement is required. The transcendence result proves
that its conversion cannot be supplied by a fixed algebraic expression in
`p,Q`.

If this intertwiner exists, four pieces fit without conflation:

1. the quartic arithmetic fixes both ordered phase orbits without identifying
   their rates;
2. the portal and cubic record sector individuate observations;
3. the lapse determines observer-dependent proper durations;
4. the fixed-cut information/canonical-energy matching determines the
   gravitational stiffness.

## A sharper reading of the commuting square

The horizon commuting square now has a physical interpretation. Its vertical
arrows are geometric evolution between cuts at fixed `G`; each contains the
unitary clock reparametrized by the local lapse and the observer's loss of
access to crossed-horizon information. Its horizontal arrows compare the
`pQ`-anchored microscopic and effective descriptions at one cut.

Lean proves that if the horizontal matching scales the full charge constraint
and the modular-energy increment by the same nonzero factor, vertical evolution
reaches the same geometric area by either route. This is a consistency result,
not a derivation of the physical intertwiner.

## What would count as success or failure

The bridge succeeds if one can construct the algebra embedding and show that
its modular parameter becomes geometric boost time with the standard lapse or
redshift law, while the quartic spectral line and its `S_Q` information metric
survive. The fixed-cut metric must then match the same normalized gravitational
mode used in canonical energy.

It fails in this form if the cocycle mixes the quartic line, if no geometric
modular state exists for the required horizon algebra, or if the resulting
proper-time conversion disagrees with ordinary gravitational redshift. It also
fails as a derivation of screening if time dilation is the only new ingredient:
boost normalization cancels and cannot select Newton's constant.

## Status

- **Established PDT mathematics:** projective `U(1)` rotation of the quartic
  phase, irrational angular winding, and exact covariance of the finite
  erasure tangent under phase action.
- **Kernel-checked here:** lapse reparametrization of phase, inverse-lapse
  frequency conversion, boost-normalization cancellation, and the abstract
  microscopic/effective horizon commuting square.
- **Standard physics input:** proper time is metric-dependent; local horizon
  thermodynamics uses boost energy and Unruh temperature; modular flow can act
  as a state-dependent time flow.
- **Open PDT identification:** the `pQ` modular parameter is geometric boost
  time with a metric-determined lapse, its fixed-cut BKM metric is the
  canonical-energy metric of the same normalized perturbation, and the
  physical role of the distinct `theta_Q` projective clock is fixed.

## References

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- A. Connes and C. Rovelli, *Von Neumann Algebra Automorphisms and
  Time-Thermodynamics Relation in General Covariant Quantum Theories*,
  <https://arxiv.org/abs/gr-qc/9406019>.
- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
- N. Lashkari and M. Van Raamsdonk, *Canonical Energy is Quantum Fisher
  Information*, <https://arxiv.org/abs/1508.00897>.
