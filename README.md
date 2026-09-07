# Gravity screening at the four-dimensional marginal point

This repository isolates one open mechanism in Pisot Dimensional Theory (PDT):
why the gravitational response should contain the factor

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\qquad
\lambda_4=1-\frac1Q,
\qquad
Q^4=Q+1.
\]

It is an exploratory repository and does not alter the PDT canon.  It develops
a parameter-free physical hypothesis for the screening mechanism and marks
which parts are postulates, published physics inputs, and exact mathematical
consequences.

The PDT gravity paper already supplies the value of Jacobson's undetermined
entropy-area density.  The purpose here is narrower: derive the microscopic
origin of the quartic factor already present in that value.

[`PQ_TRANSFORM_CHAIN.md`](PQ_TRANSFORM_CHAIN.md) now joins the gravity paper's
original `pQ`-resolution argument to the later Hodge flip-product, modular
defect, and information-erasure results.  The combined chain derives the
screening form without using the measured gravity residual.  It also preserves
the exact distinction between the root-weighted `p/Q` operator and the
`lambda4` response operator.

The strongest current formulation treats `S_Q` as a post-condensation matching
coefficient of the infrared Einstein term.  This placement survives canonical
field normalization. Two information readings are now sharply separated: an
unconditioned horizon branch scales the extensive entropy density directly,
while a partial-Fisher interpretation would require a coupled history measure
that has not yet been constructed. See
[`POST_CONDENSATION_MATCHING.md`](POST_CONDENSATION_MATCHING.md) and
[`INFORMATION_GEOMETRIC_MATCHING.md`](INFORMATION_GEOMETRIC_MATCHING.md).
The canonical-candidate calculation is in
[`FISHER_SCORE_AUDIT.md`](FISHER_SCORE_AUDIT.md).

The arithmetic substrate is sharpened in
[`PHI_RULER_FOLD.md`](PHI_RULER_FOLD.md).  The golden ratio and `rho*Q` are
distinct, but both have norm `-1`; moreover the golden-polynomial defect of
`rho*Q` is itself a norm-`-1` unit.  This makes `rho*Q` a precise
higher-dimensional lift of the golden unit while keeping the quartic response
`lambda4` as a separate operation on that ruler.

[`SUBNORMALIZED_HORIZON_BRANCH.md`](SUBNORMALIZED_HORIZON_BRANCH.md) isolates
the next physical decision.  A scalar defect branch cannot encode the input
state in its flag, but its unconditioned Born weight does scale an extensive
horizon-cell density and every entropy first-law variation by exactly `S_Q`.
Renormalizing the branch removes the factor.  The mechanism therefore turns on
whether Jacobson's local area law counts retained cells per original area or a
post-selected conditional state.

[`MODULAR_GNS_AMPLITUDE.md`](MODULAR_GNS_AMPLITUDE.md) and
[`ERASURE_INFORMATION_GEOMETRY.md`](ERASURE_INFORMATION_GEOMETRY.md) sharpen
this into a physical postulate with exact consequences.  The quartic KMS mode
has modular eigenvalue `1/Q`, so its one-step defect has Hilbert amplitude
`lambda4`.  The corresponding normalized erasure channel contracts quantum
relative entropy and its BKM/Fisher information metric by exactly `S_Q`.
Repeated steps give a monotone local arrow of time while global dilation
preserves information, linking the same quartic factor to causal time and
Jacobson's entropy density.

[`OBSERVER_HORIZON_DILATION.md`](OBSERVER_HORIZON_DILATION.md) now constructs
the channel explicitly for a finite horizon cell.  The map preserves global
norm; tracing out the hidden system gives the exterior `S_Q` erasure channel,
while tracing out the exterior system places the same input state in the
hidden branch with weight `lambda4^2`.  This proves global information
conservation and local causal loss in one model.

[`SPLIT_HORIZON_LOCALIZATION.md`](SPLIT_HORIZON_LOCALIZATION.md) gives the
relativistic placement.  The split property hosts the finite channel in a
stretched-horizon type-I collar; the observer crossed product supplies the
sharp-horizon limit.  The remaining theorem is reduced to one distinguished
quartic mode whose modular eigenvalue is `1/Q` and whose BKM information norm
contracts by exactly `S_Q` under the horizon-cut coarse-graining.

[`BIVECTOR_RATE_AUDIT.md`](BIVECTOR_RATE_AUDIT.md) records a selective but
non-exact consequence: `-log(S_Q)/log(Q)` differs from `1/6` by only
`8.50e-6`, equivalently `S_Q^6 Q - 1 = -1.01759e-5`.  Six is the dimension of
four-dimensional bivectors.  Exponent and degree-family controls strongly
select the quartic/six pair, but exact algebra proves that the equality is not
an identity, so it remains an exploratory structural correspondence.

## The useful result

The factor `1 - lambda^2` is the universal residual coefficient for a
normalized two-channel quadratic response:

\[
x^2+y^2-2\lambda xy
=(y-\lambda x)^2+(1-\lambda^2)x^2.
\]

Eliminating the second channel therefore leaves the Schur complement
`1 - lambda^2`. The same number is:

- the determinant of the normalized response matrix
  `[[1, -lambda], [-lambda, 1]]`;
- the squared norm left after orthogonally projecting one unit channel onto
  another with overlap `lambda`;
- the conditional variance of one standardized variable after conditioning on
  another with correlation `lambda`.

This supplies a real mechanism class for the square and the minus sign. If the
coefficient of a gravitational kinetic term is reduced by `S_Q`, its inverse
coupling is increased by `1/S_Q`, exactly the direction of the correction in
the PDT gravity formula.

## Why Ehrenfest matters

In `d` spatial dimensions, the Newtonian potential has radial homogeneity
`r^(2-d)`, while the centrifugal term has homogeneity `r^(-2)`. Their ratio is
`r^(4-d)`, so it is independent of radius only at `d = 4`.

Ehrenfest's marginal dimension therefore does something precise: it is the
unique dimension in which the gravitational and centrifugal responses can be
mixed by a scale-free, dimensionless constant without inserting another radial
scale. It explains where a pure-number response coefficient can live. It does
not determine that coefficient.

## The remaining physical question

The screening formula would follow from the quadratic response

\[
K_Q=\begin{pmatrix}1&-\lambda_4\\-\lambda_4&1\end{pmatrix}
\]

for a normalized geometric mode and a normalized four-dimensional response
mode. The decisive question is therefore:

> Does a curvature or kinetic expansion of the PDT action produce a positive
> two-channel response whose normalized off-diagonal coefficient is exactly
> `lambda4`?

The currently filed two-scalar potential does not do this at tree level. At
either axis vacuum its mixed Hessian entry is zero. At the nonzero mixed
stationary point in the bistable regime, the Hessian determinant is negative,
so it cannot be the positive Gram or Fisher matrix required by the projection
mechanism. The existing action therefore supplies the arithmetic coefficient
but not this response map.

The full curvature audit is stronger: the filed induced-gravity coefficient is
`f(phi,chi) = xi phi^2`, so the standard frame-covariant field metric has
exactly zero `phi`-`chi` kinetic entry. Together with the unbroken
`chi -> -chi` symmetry at `(v,0)`, this makes the tree-level normalized mixing
`c = 0`, not `lambda4`. See [`CURRENT_ACTION_AUDIT.md`](CURRENT_ACTION_AUDIT.md).

A more promising source is the minimal unitary completion of the Q-sector
residue contraction. On the positive eigenline of the founding quartic
companion matrix, `I-M_Q^(-1)` has the exact eigen-amplitude
`lambda4 = 1-1/Q`. Its minimal unitary completion has the unique defect weight
`1-lambda4^2`. This also produces exactly the square-root factor used by the
Planck-mass formula. The operator mathematics is exact; deriving its positive
defect amplitude as an inverse-length horizon-resolution response remains the
decisive physical premise. See
[`UNITARY_DEFECT_MECHANISM.md`](UNITARY_DEFECT_MECHANISM.md).

The same matrix now supplies a sharper physical bridge. Its Cuntz--Krieger
algebra has a unique gauge-KMS equilibrium at inverse temperature `log Q`.
KMS detailed balance makes the normalized difference between a process and its
thermal reverse exactly `1-exp(-log Q) = lambda4`. Thus the residue is
simultaneously the renewal frequency, the inverse-step transfer eigenvalue, and
the canonical equilibrium causal-response defect.  In the KMS GNS Hilbert
space this statement upgrades further: a degree-one mode has modular
eigenvalue `1/Q`, so `I-Delta_Q` has the genuine Hilbert amplitude `lambda4`
on that spectral subspace.  Its squared norm and norm-preserving complement
therefore give `lambda4^2` and `1-lambda4^2` without treating a classical
frequency as an amplitude.  See
[`MODULAR_GNS_AMPLITUDE.md`](MODULAR_GNS_AMPLITUDE.md).
Type-III state-embedding
theory guarantees an abstract wedge-vacuum embedding that preserves these
response values. Full modular flows are also related up to a Connes unitary
cocycle. What has not been constructed is a net-compatible embedding that
identifies the graph modular flow with geometric wedge boosts. Equivalently,
the cocycle must preserve the quartic spectral line without shifting its
frequency. At the full-algebra level, Takesaki's theorem turns this into a
concrete expected-subfactor problem: construct a vacuum-preserving conditional
expectation from the wedge algebra onto the embedded pQ algebra. See
[`PERRON_HORIZON_AUDIT.md`](PERRON_HORIZON_AUDIT.md),
[`MODULAR_MAP_AUDIT.md`](MODULAR_MAP_AUDIT.md), and
[`REVERSE_HORIZON_AUDIT.md`](REVERSE_HORIZON_AUDIT.md).

The expected-subfactor condition is not automatic for the physical vacuum.
Tensor absorption supplies an expected pQ copy for a chosen product state, and
type-III embedding theory separately supplies a copy preserving the actual
wedge state. No checked theorem forces those to be the same copy. The fastest
model-specific test is whether the wedge modular flow has a nonzero bounded
eigenoperator at ratio `1/Q`. See
[`EXPECTED_SUBFACTOR_STATUS.md`](EXPECTED_SUBFACTOR_STATUS.md).

This point-spectrum test has a sharp conditional outcome. A wedge vacuum that
satisfies the absolute-Cesàro spectral-mixing condition admits no nonzero
bounded modular eigenoperator at any nonzero frequency, so it cannot contain
the graph clock as an exactly covariant bounded subsystem. An ordinary Cesàro
decay statement is too weak to imply this. If the stronger condition holds,
the natural next home for the pQ clock is an observer or crossed-product
extension of the local algebra. See
[`WEAK_MIXING_OBSTRUCTION.md`](WEAK_MIXING_OBSTRUCTION.md).

For the linearized two-scalar model the point-spectrum test can be completed.
Boosts act by translations of the one-particle rapidity coordinate, so the
Fock space has no boost eigenvectors beyond the vacuum. Separatingness then
rules out every nonzero bounded wedge modular eigenoperator at the required
`Q^(-it)` phase. The exact clock therefore cannot be a bounded local mode of
the free wedge. In the continuous core, however, the dual action scales the
canonical trace by `exp(-s)`. The step `s=log Q` has trace defect `lambda4`,
and the complement of its twice-applied defect is exactly
`1-lambda4^2`. This supplies a standard observer-algebra realization of the
complete coefficient while leaving its identification with the gravitational
response open. See
[`FREE_WEDGE_CORE_AUDIT.md`](FREE_WEDGE_CORE_AUDIT.md).

The trace-ray polynomial has the same scalar as the correction pattern in the
deposited Jacobson formulas, but a normalized-state audit rules out the
simplest identification. Globally rescaling a Type-II trace changes state
entropy only by an additive constant, leaving entropy differences and first
variations unchanged. Therefore trace normalization alone cannot renormalize
Newton's coupling. A successful mechanism must put `S_Q` into the physical
area calibration, the noncentral modular generator, or local horizon-cell
weights. See [`TRACE_NORMALIZATION_OBSTRUCTION.md`](TRACE_NORMALIZATION_OBSTRUCTION.md)
and [`JACOBSON_CORE_BRIDGE.md`](JACOBSON_CORE_BRIDGE.md).

Running that obstruction backward yields a cleaner geometric target. If the
positive defect amplitude `sqrt(1-lambda4^2)` rescales both inverse-length
resolution directions tangent to a two-dimensional local horizon, the density
of microscopic cells per physical area is multiplied by exactly
`1-lambda4^2`; Jacobson then gives the deposited inverse correction to `G`.
This avoids the trace-normalization cancellation. The missing theorem is the
Q-to-area-density coupling, which the filed two-scalar action does not
provide. The same audit shows that the bare scalar Kraus pair is state
independent and therefore cannot by itself serve as an information-transfer
channel. See
[`HORIZON_AREA_CALIBRATION.md`](HORIZON_AREA_CALIBRATION.md).

The standing PDT Hodge-pair model (F373, with the F374 source no-go) supplies a
non-scalar candidate for that missing response. On a Lorentzian chiral pair,
`I-i*lambda4*star` has real weights `1+lambda4` and `1-lambda4`, so its paired
determinant is exactly `1-lambda4^2`. The full six-dimensional bivector
determinant would give the wrong third power; one factor arises naturally only
after localizing to the horizon binormal and its dual tangent-area form. This
sharpens the determinant reading to a per-horizon-pair response. More directly,
the orientation-even average of the two inverse chiral stiffnesses is
`1/(1-lambda4^2)`, exactly the required enhancement of `G`, without taking a
full determinant. The remaining premise is to derive this affine chiral
kinetic operator from the physical action. See
[`HODGE_CHIRAL_SCREENING.md`](HODGE_CHIRAL_SCREENING.md).

A real doubled formulation now sharpens that step. Pairing a sourced horizon
or curvature mode with an independent dual mode gives a positive real
quadratic action whose Schur complement is exactly `1-lambda4^2`; its source
response is therefore the required reciprocal factor. Established
duality-symmetric formulations of electromagnetism and linearized gravity show
that such doubling is legitimate field-theory architecture, but they do not
derive the PDT coefficient or its nonlinear coupling. See
[`CHIRAL_KINETIC_ACTION_TARGET.md`](CHIRAL_KINETIC_ACTION_TARGET.md).

The coefficient bridge can also be stated without treating the non-normal
quartic transfer operator as a symmetric kinetic matrix. Its right Perron mode
is `(1,Q^3,Q^2,Q)`, while its left mode is the reversed vector
`(1,Q,Q^2,Q^3)`. Their normalized biorthogonal residual readout is exactly
`lambda4`. Compressing the quartic dynamics to this left/right Perron pair
therefore supplies the action coefficient; an additional coupling would have
to have unit magnitude to reproduce the screening formula. The open step is
to derive that normalized compression as the actual curvature cross-block.
See [`PERRON_HODGE_ACTION_BRIDGE.md`](PERRON_HODGE_ACTION_BRIDGE.md).

The deposited scalar portal coefficient `kappa=(Q/rho)^2` cannot supply an
extra normalization: it would predict `1-kappa^2*lambda4^2`, which is exactly
different from the gravity factor. The more coherent unit normalization comes
conditionally from treating the action as the graph norm of the actual
quartic residual contraction and its minimal defect completion. See
[`PORTAL_K_NORMALIZATION_AUDIT.md`](PORTAL_K_NORMALIZATION_AUDIT.md).

Comparison with the standard two-prepotential action for linearized gravity
adds a sharper constraint and a useful factorization. The established action
uses an antisymmetric internal tensor in its canonical kinetic term and the
identity in its positive Hamiltonian. The symmetric quartic block therefore
belongs, if it can be derived at all, in a Q-dependent constitutive
Hamiltonian. Writing that block as `K=d*Khat`, where
`d=sqrt(1-lambda4^2)` and `det(Khat)=1`, makes `Omega*Khat` a normalized
twisted-duality complex structure. Eliminating the dual channel of `Khat`
produces one factor `d`; its overall scale supplies the second, leaving the
full stiffness `d^2=1-lambda4^2`. This links the square-root Planck correction
and the Newton correction. It also passes a necessary propagation test: using
the raw block only in the Hamiltonian would change the free mode speed, while
the determinant-one block preserves it and the overall factor cancels from
the vacuum equations. For constant `lambda4`, the normalized block is a
canonical squeeze of ordinary source-free linearized gravity and preserves
its linear gauge structure. The remaining task is to derive both occurrences
of `d`, fix the physical metric/source frame, and obtain a consistent ordinary
matter coupling and nonlinear completion. See
[`DUALITY_ACTION_COMPATIBILITY.md`](DUALITY_ACTION_COMPATIBILITY.md).

The two factors of `d` are now unified inside one normalized channel geometry.
The reference channel `(1,0)` and the defect-completed quartic channel
`(-lambda4,d)` have unit norm and forced overlap `-lambda4`; their Gram matrix
is exactly the raw response block `K`. Its oriented area is `d`, its
determinant is `d^2`, and dividing by that area gives the symplectic block
`Khat`. This removes an independent normalization choice from the abstract
mechanism. The remaining premise is that the gravitational prepotential pair
uses this Q-channel Gram metric. See
[`GRAM_DUALITY_BRIDGE.md`](GRAM_DUALITY_BRIDGE.md).

The same result admits a much shorter physical reading.  Keep the ordinary
`rho*Q` exponent prediction as the unscreened Planck scale, and project the
geometric channel orthogonally away from the normalized quartic Perron-residue
channel.  Their exact overlap is `lambda4`, so the surviving curvature norm is
`1-lambda4^2`; its inverse response is the deposited Newton correction.  This
does not require the longer duality machinery to state the linear mechanism.
Its one physical premise is that classical curvature is this projected
information channel.  See
[`DIRECT_CURVATURE_PROJECTION.md`](DIRECT_CURVATURE_PROJECTION.md).

There is now an even closer link to PDT's existing spacetime and quantum
foundations.  On the quartic complex place, the normalized untwisted trace
form of `1+i*lambda4` is exactly `1-lambda4^2`, while the conjugation-twisted
positive form of the same element is `1+lambda4^2`.  Thus the gravity factor
is the Lorentzian reading of the same local imaginary direction whose
Hermitian reading supplies positive quantum norm.  This is exact arithmetic;
placing that local response in the physical Einstein kinetic term remains the
identification.  See [`TRACE_FORM_SCREENING.md`](TRACE_FORM_SCREENING.md).

The local formula also has an explicit representative in the full quartic
power-basis trace geometry.  The normalized identity axis `1/2` and the
normalized negative axis `(4Q-3Q^2)/6` are trace-orthogonal with squares `+1`
and `-1`; their affine combination with coefficient `lambda4` therefore has
square `1-lambda4^2`.  These are the axes of the rational diagonalization
already used to prove the quartic signature `(3,1)`.

The negative axis is also exactly the chosen observer direction from the
time-dimensional construction: `u=4Q-3Q^2`, with trace square `-36`.  Hence
the screening element can be written directly as
`a_Q=1/2+(lambda4/6)u`.  See
[`TIME_GRAVITY_TRACE_BRIDGE.md`](TIME_GRAVITY_TRACE_BRIDGE.md).
On this background/time plane, normalization, time-orientation evenness, and
the unit null condition uniquely force the quadratic response `1-lambda4^2`.
The corresponding minimal completion of the filed induced-gravity term is
`(xi/2) phi^2 Tr(a_Q^2) R[g]`; it keeps the constant trace form internal while
the spacetime metric remains dynamical.  See
[`COVARIANT_EINSTEIN_BRIDGE.md`](COVARIANT_EINSTEIN_BRIDGE.md).

The older induced-gravity companion's absolute normalization has also been
audited.  Its stated values of `v` and `M_Pl` do not satisfy its own equation
`M_Pl^2=(4 pi/3)v^2`; corrected values and the screened convention are recorded
in [`INDUCED_GRAVITY_NORMALIZATION_AUDIT.md`](INDUCED_GRAVITY_NORMALIZATION_AUDIT.md).

The normalized block is also an exact canonical squeeze, which makes the
earlier Barbero-Immirzi intuition worth testing in a narrower form. Its
half-squeeze scale is `u_Q=(2Q-1)^(1/4)=1.0957280275...`. The simplest direct
identification fails: the quartic squeeze mixes prepotentials whose maps to
metric and momentum have unequal derivative orders and nonlocal inverses,
whereas the Barbero-Immirzi transformation is local in connection and triad
variables. A more elaborate dual-connection bridge remains open, but `u_Q`
is not presently an Immirzi value. The deposited scalar portal coefficients
have different values as well. See
[`IMMIRZI_SQUEEZE_AUDIT.md`](IMMIRZI_SQUEEZE_AUDIT.md).

Expanding the deposited two-scalar action about `(phi,chi)=(v,0)` sharpens that
condition. Its quadratic operator has no `h`-`chi` mixing, so a sectorwise
modular identification is cocycle-neutral on the one-particle quartic mode at
tree level. The first portal interaction is instead `2*kappa*v*h*chi^2`.
Because the unbroken parity permits corrections to the quartic two-point
function, it does not protect the exact modular frequency beyond the Gaussian
limit. See [`ACTION_COCYCLE_AUDIT.md`](ACTION_COCYCLE_AUDIT.md).

That negative result sharpens the next calculation. A successful derivation
must obtain the matrix from a kinetic or curvature sector, with its
normalization and reality conditions fixed independently. A different
coefficient, an indefinite response, or higher-order terms would falsify this
minimal mechanism.

## Contents

- [`DERIVATION.md`](DERIVATION.md) gives the mathematical and physical chain,
  with assumptions separated from consequences.
- [`CURRENT_ACTION_AUDIT.md`](CURRENT_ACTION_AUDIT.md) applies the decisive
  kinetic and curvature test to the deposited two-scalar action.
- [`UNITARY_DEFECT_MECHANISM.md`](UNITARY_DEFECT_MECHANISM.md) gives a
  norm-conserving channel mechanism for the square-root and screening factors.
- [`PHYSICAL_BRIDGE_AUDIT.md`](PHYSICAL_BRIDGE_AUDIT.md) tests the proposed
  horizon/gravity identification, gives the one-tick Hamiltonian, and records
  the neighboring-family and reverse controls.
- [`PERRON_HORIZON_AUDIT.md`](PERRON_HORIZON_AUDIT.md) proves the exact
  renewal-frequency theorem and reports the classical-horizon obstruction that
  localizes the remaining physical quantization rule.
- [`PQ_MODULAR_HORIZON.md`](PQ_MODULAR_HORIZON.md) proves that the joint cubic
  and quartic KMS factors have the hyperfinite type-`III_1` algebra required by
  a generic relativistic local region, while preserving the quartic response.
- [`MODULAR_MAP_AUDIT.md`](MODULAR_MAP_AUDIT.md) proves existence of a
  state-preserving horizon embedding, transports the full modular dynamics up
  to a Connes cocycle, and isolates the exact cocycle-neutrality test.
- [`ACTION_COCYCLE_AUDIT.md`](ACTION_COCYCLE_AUDIT.md) proves the exact shifted
  portal expansion and shows that the filed action is compatible with
  cocycle neutrality at tree level but does not protect it under interactions.
- [`REVERSE_HORIZON_AUDIT.md`](REVERSE_HORIZON_AUDIT.md) runs the mechanism
  from the gravity coefficient backward, fixes the required boost gap, and
  reformulates exact modular covariance as a state-preserving conditional
  expectation problem.
- [`EXPECTED_SUBFACTOR_STATUS.md`](EXPECTED_SUBFACTOR_STATUS.md) proves that a
  bare expected copy and an actual-state-preserving copy exist separately,
  explains why their intersection is not automatic, and states the first
  modular point-spectrum test.
- [`WEAK_MIXING_OBSTRUCTION.md`](WEAK_MIXING_OBSTRUCTION.md) proves that the
  explicit absolute-Cesàro mixing condition excludes exact nonzero-frequency
  bounded modular eigenoperators, records a terminology trap, and identifies
  the observer/crossed-product alternative.
- [`FREE_WEDGE_CORE_AUDIT.md`](FREE_WEDGE_CORE_AUDIT.md) completes the modular
  point-spectrum test for the linearized two-scalar Fock vacuum, proves the
  bounded local-clock obstruction, and realizes the complete screening
  polynomial on the continuous core's canonical trace ray.
- [`JACOBSON_CORE_BRIDGE.md`](JACOBSON_CORE_BRIDGE.md) shows that the deposited
  correction factors follow conditionally from a screened physical entropy
  density, and corrects the claim that global core-trace scaling derives it.
- [`TRACE_NORMALIZATION_OBSTRUCTION.md`](TRACE_NORMALIZATION_OBSTRUCTION.md)
  proves that global trace normalization contributes only an additive entropy
  constant and derives the noncentral modular or area-calibration target that
  must replace it.
- [`HORIZON_AREA_CALIBRATION.md`](HORIZON_AREA_CALIBRATION.md) derives the exact
  two-dimensional area-density response from the defect amplitude, proves its
  reverse uniqueness under isotropy, and records why the scalar Kraus model
  carries no state information.
- [`HODGE_CHIRAL_SCREENING.md`](HODGE_CHIRAL_SCREENING.md) integrates the
  standing F373/F374 Hodge results with the trace no-go, proves the full-space
  third-power control, and isolates the single local-horizon Hodge pair that
  could carry the observed first power.
- [`CHIRAL_KINETIC_ACTION_TARGET.md`](CHIRAL_KINETIC_ACTION_TARGET.md) gives a
  real doubled-mode action whose exact Schur complement produces the screened
  stiffness and reciprocal gravitational response, while exposing the
  remaining coefficient and nonlinear-reality derivation.
- [`PERRON_HODGE_ACTION_BRIDGE.md`](PERRON_HODGE_ACTION_BRIDGE.md) proves the
  non-normality guard and the exact left/right Perron compression that supplies
  `lambda4`, then isolates the remaining unit-normalization premise.
- [`PORTAL_K_NORMALIZATION_AUDIT.md`](PORTAL_K_NORMALIZATION_AUDIT.md) proves
  that the deposited scalar portal coefficient gives the wrong screening if
  reused as the Hodge coupling and identifies the residual graph norm as the
  cleaner conditional normalization.
- [`DIRECT_CURVATURE_PROJECTION.md`](DIRECT_CURVATURE_PROJECTION.md) states the
  minimal information-geometric mechanism: the ordinary `rho*Q` exponent sets
  the base scale and the orthogonal Q-residue projection supplies the sole
  curvature correction.
- [`TRACE_FORM_SCREENING.md`](TRACE_FORM_SCREENING.md) proves that the same
  coefficient is the normalized intrinsic trace-form norm of
  `1+i*lambda4`, contrasted with the positive Hermitian norm used in the
  Q-as-QM account.
- [`TIME_GRAVITY_TRACE_BRIDGE.md`](TIME_GRAVITY_TRACE_BRIDGE.md) identifies the
  normalized negative trace axis with the explicit quartic time observer.
- [`COVARIANT_EINSTEIN_BRIDGE.md`](COVARIANT_EINSTEIN_BRIDGE.md) places the
  fixed trace scalar in the existing induced Einstein term while keeping the
  internal trace form distinct from the dynamical spacetime metric.
- [`INDUCED_GRAVITY_NORMALIZATION_AUDIT.md`](INDUCED_GRAVITY_NORMALIZATION_AUDIT.md)
  corrects a factor-of-two numerical inconsistency in the companion drafts.
- [`BASELINE_CONDENSATE_CHAIN.md`](BASELINE_CONDENSATE_CHAIN.md) combines the
  deposited unscreened scale, the corrected conformal condensate, and the
  quartic response into a reproducible Planck-mass comparison.
- [`DECISIVE_ACTION_TARGET.md`](DECISIVE_ACTION_TARGET.md) reduces the open
  physics to the trace-weighted induced Einstein term and states the quadratic
  conditions that force its coefficient.
- [`PERRON_COMPENSATOR_ACTION.md`](PERRON_COMPENSATOR_ACTION.md) derives the
  same coefficient from the normalized quartic inverse-step residue, and proves
  the canonical-normalization control that a viable gravity mechanism must pass.
- [`GravityScreening/Basic.lean`](GravityScreening/Basic.lean) kernel-checks
  the algebraic core.
- [`GravityScreening/PhiRulerFold.lean`](GravityScreening/PhiRulerFold.lean)
  kernel-checks the exact golden-defect unit identity.
- [`GravityScreening/HorizonBranch.lean`](GravityScreening/HorizonBranch.lean)
  kernel-checks the subnormalized first-law scaling and the renormalization
  control.
- [`GravityScreening/ModularAmplitude.lean`](GravityScreening/ModularAmplitude.lean)
  kernel-checks the modular-eigenvector defect amplitude, its squared Hilbert
  norm, and the resulting conditional first-law factor.
- [`GravityScreening/ErasureInformation.lean`](GravityScreening/ErasureInformation.lean)
  kernel-checks the exact contraction of diagonal relative entropy and Fisher
  information by the quartic erasure factor, packages the exact modular/Hodge/
  information transform chain, and checks the exact algebraic residual of the
  six-bivector rate candidate.
- [`GravityScreening/ErasureDilation.lean`](GravityScreening/ErasureDilation.lean)
  constructs the finite Stinespring map, proves global norm preservation, and
  computes both the exterior and hidden reduced-state blocks at the exact
  quartic weights.
- [`verify.py`](verify.py) reproduces the exact quartic arithmetic using only
  the Python standard library.
- [`phi_ruler_fold.py`](phi_ruler_fold.py) reproduces the positive-embedding
  scale comparison and conjugate compensation.
- [`condensate_chain.py`](condensate_chain.py) reproduces the conditional
  baseline-to-condensate numerical chain and its experimental score.

## Reproduce

```bash
python3 verify.py
python3 condensate_chain.py
python3 phi_ruler_fold.py
python3 bivector_rate_audit.py
lake exe cache get
lake build
```

## Status

The arithmetic, Schur-complement identity, four-dimensional homogeneity
criterion, renewal-frequency identity, and KMS causal-response identity are
exact mathematics. A state-preserving embedding into a local wedge algebra
exists abstractly, but the linearized Fock wedge cannot make it modularly
covariant because its nonzero bounded modular eigenspaces vanish. The
continuous core supplies an exact trace-ray realization of the quartic defect
and its self-complement. It does not convert that scalar into a physical
entropy variation: global trace rescaling cancels after state normalization.
Jacobson's correction pattern remains exact conditional algebra if an
independent mechanism scales the physical entropy-per-area coefficient. The
standing F373 affine Hodge operator now supplies the strongest candidate: its
orientation-even inverse has exactly the required `1/(1-lambda4^2)` response,
and its geometric-mean amplitude gives the matching area-density and Planck-
mass powers. The filed two-scalar and Holst sources do not derive that operator
(F374), so the Q-dependent chiral kinetic term and its Lorentzian reality
conditions remain the open physical step.

The real doubled action now removes the immediate complex-reality obstruction
at quadratic order: integrating out its dual mode gives the exact screened
stiffness and Newton response. What remains is to derive that mode and its
`lambda4` cross-coupling from a gauge-consistent PDT curvature action. The
quartic residual supplies `lambda4` exactly after canonical left/right Perron
compression; the surviving question is whether the physical action forces
that compression with unit normalization.

The local trace-form calculation gives the leanest current formulation of the
same question.  The quartic complex place already supplies the negative
direction, and `1+i*lambda4` already has normalized intrinsic square
`1-lambda4^2`.  The remaining step is therefore the placement of this affine
local response in the gravitational kinetic term, rather than the derivation
of another determinant or normalization factor.

The corrected induced-gravity normalization also closes a conditional
numerical chain.  Starting from the deposited unscreened relation
`M_Pl,0/m_e=(rho Q)^112/pi^2`, conformal coupling predicts
`v=6.0653766424e18 GeV`; applying the quartic trace response then predicts
`M_Pl,Q=1.2209081472e19 GeV`, which is `+0.00148639%` or `+1.30` current
experimental standard uncertainties above the 2022 CODATA central value.
This comparison does not derive the deposited exponent or the physical
placement of the trace factor, but it removes measured gravity from the
condensate normalization and makes the remaining action-level premise
directly testable.
