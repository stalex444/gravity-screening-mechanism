# Cosmological quartic transport

## The calculation

The finite standard-siren theorem fixes the exterior response for one quartic
visible-hidden split.  Write

\[
\lambda_4=1-\frac1Q,
\qquad
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\]

and let

\[
A_Q=\sqrt{S_Q},
\qquad
R_Q=\frac1{A_Q}.
\]

Numerically,

\[
S_Q=0.9673014200885397\ldots,
\quad
A_Q=0.9835148296230920\ldots,
\quad
R_Q=1.0167614863349092\ldots.
\]

The finite theorem alone does not say whether this response occurs once at a
local observer interface or accumulates during cosmological propagation.  The
two interpretations have different normalization laws.

## Local response and cosmological response are different models

A local exterior readout can carry the constant ratio

\[
\frac{d_L^{\rm inferred}}{d_L^{\rm true}}=R_Q.
\]

Cosmological propagation cannot use this same constant at every distance.
When the source approaches the observer, the propagation path vanishes and a
propagation response must obey

\[
R(0)=1.
\]

The Lean theorem `quarticStepResponse_ne_zeroPathValue` proves that the
nontrivial quartic local response is incompatible with that zero-path value.
This is an exact separation, not a matter of interpretation after the fact.

## The scale-step premise

The simplest parameter-free cosmological extension is to use the quartic
Perron scale itself as the step size:

> A multiplicative scale-factor change by \(Q\) constitutes one quartic
> response step, and each step retains amplitude \(A_Q\).

For source redshift \(z\), the corresponding number of steps is

\[
N_Q(z)=\frac{\log(1+z)}{\log Q}.
\]

The accumulated luminosity-distance response is therefore

\[
\boxed{
R_Q(z)=R_Q^{N_Q(z)}
=(1+z)^{\beta_Q},
\qquad
\beta_Q=\frac{\log R_Q}{\log Q}.}
\]

This law has three exact structural properties:

1. \(R_Q(0)=1\);
2. \(R_Q(Q-1)=R_Q\), so one \(Q\)-scale step reproduces the finite response;
3. if successive redshifts compose through
   \(1+z_{12}=(1+z_1)(1+z_2)\), then
   \(R_Q(z_{12})=R_Q(z_1)R_Q(z_2)\).

All three are kernel-verified in
`GravityScreening/CosmologicalQuarticTransport.lean`.  The scale-step premise
is a proposed physical identification.  The consequences of that premise are
theorems.

## Why the power law is forced

The redshift curve above is not selected from a family of convenient fitting
functions.  Lean proves a general rigidity theorem for an arbitrary response
(F) on positive scale-factor ratios.  If

1. (F) is continuous;
2. (F(a)>0) for every (a>0);
3. successive scale changes compose, (F(ab)=F(a)F(b)); and
4. one quartic step has the fixed value (F(Q)=R_Q),

then for every (a>0),

\[
F(a)=a^{\log R_Q/\log Q}.
\]

Setting (a=1+z) gives exactly (F(1+z)=R_Q(z)).  The proof transforms the
positive multiplicative response with the logarithm, obtains a continuous
additive map on the real line, proves that map is real-linear, and uses the
single value at (Q) to fix its slope.  This is formalized by
`continuousPositiveMultiplicativeResponse_unique` and specialized by
`continuousQuarticScaleResponse_unique`.

The result sharply identifies the assumption that can fail.  Once continuity,
positivity, and path composition are accepted, there is no alternative smooth
curve with the same one-step value.  The physical question is whether the
finite quartic response is in fact the response of a (Q)-fold cosmological
scale change.

## Exact meeting with the effective Newton response

Belgacem, Dirian, Foffa, and Maggiore show that in a class of modified-gravity
theories with conserved graviton number,

\[
\frac{d_L^{\rm gw}(z)}{d_L^{\rm em}(z)}
=\sqrt{\frac{G_{\rm eff}(z)}{G_{\rm eff}(0)}}.
\]

Under that sourced physical relation, the PDT transport law implies

\[
\frac{G_{\rm eff}(z)}{G_{\rm eff}(0)}=R_Q(z)^2.
\]

After one quartic scale step this becomes

\[
\boxed{
\frac{G_{\rm eff}(Q-1)}{G_{\rm eff}(0)}
=R_Q^2
=\frac1{S_Q}
=\frac{Q^2}{2Q-1}.}
\]

This is exactly the inverse quartic screening response already obtained in the
local gravity calculation.  The meeting point is kernel-verified by
`effectiveNewtonRatioFromQuarticTransport_oneStep`.  Its physical scope is
conditional twice: cosmological expansion must realize the quartic scale-step
premise, and the effective theory must belong to the class for which the
standard-siren/effective-Newton relation holds.

## Numerical prediction of the scale-step model

The exponent is

\[
\beta_Q=0.08333758478067765\ldots.
\]

In the two common propagation conventions this is

\[
\delta_Q=-\beta_Q=-0.08333758478067765\ldots,
\qquad
\alpha_{M,Q}=-2\delta_Q=2\beta_Q
=0.1666751695613553\ldots.
\]

Thus the same parameter-free curve can be written as

\[
R_Q(z)=(1+z)^{-\delta_Q}
      =(1+z)^{\alpha_{M,Q}/2},
\]

and the effective coupling in the applicable modified-gravity class is

\[
\frac{G_{\rm eff}(z)}{G_{\rm eff}(0)}
=(1+z)^{\alpha_{M,Q}}.
\]

Lean proves the power-law equivalence, the relation
\(\delta_Q=-\alpha_{M,Q}/2\), and the signs
\(\delta_Q<0<\alpha_{M,Q}\).  It also proves that both the distance ratio and
the effective coupling ratio are strictly greater than one for every positive
redshift.

The resulting response is:

| Redshift \(z\) | \(R_Q(z)=d_L^{\rm gw}/d_L^{\rm em}\) | Distance excess | Naive \(H_0\) ratio \(H_0^{\rm gw}/H_0\) |
|---:|---:|---:|---:|
| 0.01 | 1.00082958 | 0.083% | 0.99917111 |
| 0.10 | 1.00797455 | 0.797% | 0.99208854 |
| 0.25 | 1.01877023 | 1.877% | 0.98157560 |
| 0.50 | 1.03436787 | 3.437% | 0.96677404 |
| 1.00 | 1.05946622 | 5.947% | 0.94387153 |
| 2.00 | 1.09587781 | 9.588% | 0.91251049 |
| 5.00 | 1.16104552 | 16.105% | 0.86129268 |

The last column follows from the low-redshift algebra

\[
H_0^{\rm gw}=\frac{H_0}{R_Q(z)}
\]

when the analysis assumes the electromagnetic distance law.  At a truly local
source the effect tends to zero, unlike the constant observer-interface model.

## Check against GWTC-5.0

The 2026 LIGO--Virgo--KAGRA GWTC-5.0 cosmology analysis now constrains exactly
this observational channel.  Its equation (12) uses

\[
\frac{D_L^{\rm GW}}{D_L^{\rm EM}}
=\exp\!\left[\frac12\int_0^z
\frac{\alpha_M(z')}{1+z'}\,dz'\right],
\]

and its equation (14) identifies the square of that ratio with the effective
GW gravitational-coupling ratio in the stated Horndeski class.  A constant
\(\alpha_M=\alpha_{M,Q}\) gives the PDT power law exactly.

GWTC-5.0 fits a different late-dark-energy ansatz,
\(\alpha_M(z)=c_M/E(z)^2\), rather than a constant.  Matching the local slope
therefore gives the comparison value

\[
\boxed{c_M^{\rm local}=\alpha_{M,Q}=0.1666751695613553\ldots.}
\]

The collaboration reports \(c_M=-0.1^{+1.0}_{-0.8}\) for its narrow
\(H_0\) prior and \(c_M=-0.4^{+1.6}_{-1.3}\) for its wide prior.  The PDT local
slope lies inside both reported 68% intervals.

A direct check of the collaboration's released narrow-prior posterior gives:

| Quantity | Value |
|---|---:|
| Released equal-weighted samples | 7,414 |
| Posterior median \(c_M\) | -0.115781 |
| 16th--84th percentiles | [-0.886898, 0.867157] |
| PDT local-slope value | 0.166675 |
| Empirical posterior percentile of PDT value | 62.10% |

The released posterior therefore does not exclude the PDT value.  Nor does it
favor PDT over GR: GWTC-5.0 reports no departure from GR, and its uncertainty
is still broad.

The posterior samples permit a sharper comparison than a percentile. Because
the published `c_M` prior is uniform, the ratio of marginal posterior densities
at the fixed PDT local slope and at the GR value is also the
nuisance-marginalized likelihood ratio between those two sharp values *within
the collaboration's `c_M/E(z)^2` model*. A checksum-locked Gaussian KDE gives:

| GWTC-5 posterior | PDT/GR density ratio | Interpretation |
|---|---:|---|
| Narrow `H0` prior | 0.932 | statistical tie |
| Wide `H0` prior | 0.975 | statistical tie |

Across one-half to twice Scott's bandwidth the narrow result ranges from
0.925 to 0.948 and the wide result from 0.960 to 0.976. The ratios are close
enough to one that their slight preference for GR carries no substantive
weight.

There is also a fixed two-coordinate PDT benchmark if the separately recorded
Hubble correspondence is included:

\[
\chi=\frac{Q}{\rho}=0.921512445671651\ldots,
\qquad
H_{0,\mathrm{present}}=\frac{67.4}{\chi}
=73.1406291001\ldots,
\]

paired with \(c_M^{\rm local}=0.16667516956\ldots\). Two-dimensional KDE
comparisons of this point with the same-\(H_0\) GR point, and with the
\((67.4,0)\) benchmark, remain approximately one under both released priors.
The existing GW data therefore neither create nor remove evidence for the
Hubble correspondence. They show that the Hubble and propagation assignments
can occupy the released joint posterior simultaneously. The identification of
\(Q/\rho\) with the Hubble discrepancy remains a physical proposal rather than
a consequence of the arithmetic alone.

Because the fitted GWTC ansatz decays as dark energy becomes negligible while
the PDT proposal keeps \(\alpha_M\) constant, this is a local-slope
compatibility check rather than a likelihood evaluation of the exact PDT
curve.  The matched curves differ by only 0.036% at \(z=0.1\), 0.70% at
\(z=0.5\), and 2.06% at \(z=1\).  A decisive test should insert the fixed PDT
curve directly into the released hierarchical likelihood.

Crucially, the required exact curve is already present in the same ICAROGW
2.0.3 source version recorded in the released result. The class
`eps0_astropycosmology` implements

\[
D_L^{\rm GW}=(1+z)^{\epsilon_0}D_L^{\rm EM}.
\]

Thus \(\epsilon_0=\beta_Q\) is exactly the PDT model, including its luminosity
distance derivative used in event and selection weights. No new cosmology
implementation is required. The public GWTC-5 cosmology deposit contains the
posterior outputs but not the configured ICAROGW event and injection objects,
so the exact likelihood still requires reconstructing the collaboration run
from the public parameter-estimation and search-sensitivity releases. The
first validation must reproduce the published `c_M` result before fixing
`eps0` to \(\beta_Q\).

The reproducible calculation is in `gwtc5_pdt_curve_check.py`.  It consumes
the official file `icarogw_fullpop_spectral_cm_narrow.json` from the GWTC-5.0
Zenodo record and verifies its MD5 checksum before reporting the posterior
location and curve comparison. `gwtc5_fixed_slope_evidence.py` consumes both
official narrow- and wide-`H0` files, verifies both checksums, reports KDE
bandwidth sensitivity, performs a deterministic nonparametric bootstrap, and
evaluates the Hubble-gravity joint benchmark.

## The near-degree-twelve exponent

The computed exponent is close to the reciprocal degree of the joint field:

\[
\beta_Q-\frac1{12}
=4.2514473443\ldots\times10^{-6}.
\]

The relative difference from \(1/12\) is about \(0.0051\%\).  It is not an
exact identity.  Exact equality would require

\[
S_Q^6Q=1,
\]

or, after clearing the denominator,

\[
(2Q-1)^6-Q^{11}=0.
\]

Using \(Q^4=Q+1\), Lean reduces the left side exactly to

\[
-97Q^3-69Q^2+33Q+239.
\]

A PARI resultant check gives

\[
\operatorname{Res}
\left(x^4-x-1,,(2x-1)^6-x^{11}\right)=-1487\ne0,
\]

so no root of the defining quartic can satisfy the proposed equality.  The
near-\(1/12\) value is therefore a precise numerical proximity between two
independently defined PDT layers, not a theorem identifying them.  Its
significance requires a density comparison against nearby simple rational
exponents before it can carry evidential weight.

## What has and has not been established

**Kernel-held mathematics**

- the quartic one-step response and its strict inequality above one;
- the incompatibility of a constant nontrivial response with zero-path
  cosmological normalization;
- logarithmic step counting;
- exact zero, one-step, and composition laws;
- uniqueness of the power law among all continuous positive multiplicative
  responses with the same quartic one-step value;
- the Hubble-inference relation;
- the one-step equality with the inverse quartic Newton response;
- the equivalent constant-friction and Planck-mass-running forms;
- the fixed signs and positive-redshift inequalities;
- the algebraic reduction of the near-\(1/12\) condition.

**Sourced physical input**

- modified friction changes gravitational-wave luminosity distance;
- for a specified class of modified-gravity actions, the squared distance
  ratio equals the effective-Newton ratio.

**Open PDT identification**

- a factor-\(Q\) change of cosmological scale realizes one quartic response
  step.

This identification is now the single seam in the calculation.  If it holds,
the full redshift curve is fixed.  If it fails, the finite local response
theorem remains intact but does not supply a cosmological propagation law.

## Primary sources

- Enis Belgacem, Yves Dirian, Stefano Foffa, and Michele Maggiore,
  [Modified gravitational-wave propagation and standard sirens](https://arxiv.org/abs/1805.08731),
  especially equations (20), (22), and (29).
- Enis Belgacem, Yves Dirian, Stefano Foffa, and Michele Maggiore,
  [The gravitational-wave luminosity distance in modified gravity theories](https://arxiv.org/abs/1712.08108).
- LIGO Scientific Collaboration, Virgo Collaboration, and KAGRA Collaboration,
  [GWTC-5.0: Constraints on the Cosmic Expansion Rate and Modified Gravitational-wave Propagation](https://arxiv.org/abs/2605.27227),
  especially equations (12)--(14) and the released modified-gravity posterior.
- [Official GWTC-5.0 cosmology data release](https://zenodo.org/records/20378418).
