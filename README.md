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

[`PHYSICAL_IDENTIFICATION_STANDARD.md`](PHYSICAL_IDENTIFICATION_STANDARD.md)
states the exact remaining standard. A derived identification would follow
from one state-preserving, modular-covariant horizon embedding whose exterior
restriction produces the quartic erasure channel on the same independently
normalized shear mode used by canonical energy. The existing Lean theorems
then force `G_Q = G_0 / S_Q`, conserve the global flux, and propagate the
coefficient to the full linear gravitational response.

[`FIXED_CUT_COHERENT_SHEAR_BRIDGE.md`](FIXED_CUT_COHERENT_SHEAR_BRIDGE.md)
then supplies a shorter effective-theory route. The quartic dilation is the
one-particle restriction of a passive bosonic splitter. Published coherent-
state results identify its quadratic relative entropy with canonical boost
energy, while the horizon graviton normalization writes physical shear as
`(kappa/2)` times canonical shear. Lean proves that matching the attenuated
canonical amplitude to the same physical metric geometry is equivalent in
both directions to `G_Q = G_0 / S_Q`. The remaining physical premise is now
precise: the Q splitter acts on the canonically normalized transverse-
traceless horizon graviton mode.

[`TT_HORIZON_SPLITTER.md`](TT_HORIZON_SPLITTER.md) now makes that proposed
action explicit on the complete physical graviton polarization space.  The
block is `sqrt(S_Q) I_2` on plus and cross.  Lean proves that it preserves the
transverse-traceless subspace, contracts its full quadratic shear norm by
`S_Q`, and describes the same nonzero physical metric tensor if and only if
`G_Q=G_0/S_Q`.  Together with the separately proved electric-source frame and
Pauli--Fierz normalization uniqueness, this connects the radiative and static
linear responses.  The remaining physical step is to derive this block from
the local Q-modified spin-two or horizon interaction.

[`TT_RESPONSE_UNIQUENESS.md`](TT_RESPONSE_UNIQUENESS.md) removes the matrix
ansatz from that result.  On the plus/cross plane, rotational covariance makes
the response commute with the polarization quarter-turn; self-adjointness
removes the possible chiral rotation.  Lean proves that these conditions,
together with quadratic weight `S_Q` and the positive passive branch, uniquely
force `sqrt(S_Q) I_2`.  A capstone theorem then obtains
`G_Q=G_0/S_Q` from the symmetry and weight hypotheses directly.  What remains
is to show that the physical Q-to-graviton interaction satisfies those
hypotheses.

[`ERASURE_TT_BRIDGE.md`](ERASURE_TT_BRIDGE.md) now joins the information and
graviton constructions directly.  The finite Stinespring dilation was already
proved for arbitrary internal data dimension.  Specializing its data space to
the two plus/cross labels gives the exterior amplitude `sqrt(S_Q) I_2`
exactly, and Lean proves covariance under every linear change of those data
coordinates.  The composed capstone starts from the erasure dilation itself
and obtains `G_Q=G_0/S_Q` when the same nonzero physical metric is matched.
The remaining physical seam is to derive that the horizon Q channel carries
the canonically normalized TT graviton as its two-state data subspace.

[`THREE_D_INFORMATION_PACKING.md`](THREE_D_INFORMATION_PACKING.md) records a
new geometric route prompted by the interpretation of a spatial present as an
information-packing problem. Bandt--Meyer Proposition 7 constructs an actual
three-dimensional Meyer set at the plastic inflation factor `rho`, using a
balanced noncoplanar tetrahedral digit set. Their Theorem 1 excludes the
non-Pisot `Q<2` from every nontrivial uniformly discrete finite-digit
self-similar construction of the same kind. Lean verifies an explicit regular
tetrahedral witness for the three-dimensional theorem. This proves a sharp
settled/non-settling packing contrast; identifying the Q obstruction with
four-dimensional temporal updating remains a physical conjecture.
[`PACKING_CONTRAST_REPORT.md`](PACKING_CONTRAST_REPORT.md) tests the nested
finite approximants through depth 8 using exact algebraic-basis coordinates.
The two morphic/Pisot controls `phi` and `rho` show finite separation plateaus,
while the `Q` separation falls to `0.0277636849455` and is forced
asymptotically to zero by the published theorem. The `phi` control is required
by the registered only-two-morphic-numbers theorem and shows that separation
alone detects the Pisot boundary rather than uniquely selecting spatial
dimension. The report also distinguishes the exact four-step memory of
`Q^4=Q+1` from metric settling and compares the new spatial test with the
earlier public `PDT-pisot-test-suite`.

The key refinement is that the three-dimensional proof splits packing into
coverage and separation. The balanced tetrahedron has the sufficient coverage
threshold `theta<4/3`. Lean proves `phi>4/3` but `rho,Q<4/3`. Together with the
registered theorem that `phi` and `rho` are the only morphic numbers, `rho` is
the unique morphic scale passing this 3D gateway. Pisot arithmetic then
separates the two scales below it: `rho` covers and settles, while `Q` covers
but necessarily crowds. This is a mathematical selector inside the stated
construction; its identification with physical space and time remains a
physical claim.

[`TETRAHEDRAL_INFORMATION_FRAME.md`](TETRAHEDRAL_INFORMATION_FRAME.md) gives
the information-geometric parallel. The same four normalized vectors are the
standard tetrahedral qubit SIC measurement. Lean proves their tight-frame
factor `4/3`, normalized four-weight sum, and exact reconstruction of all
three real coordinates. This makes the `4 -> 3` map precise: four balanced
outcomes contain three independent coordinates after normalization. Equating
those outcomes with Q-driven histories is the remaining physical
identification.

[`PERRON_TETRAHEDRAL_BRIDGE.md`](PERRON_TETRAHEDRAL_BRIDGE.md) performs the
decisive follow-up. The quartic Perron residual scales all four probabilities
by `lambda4`, so conditioning erases the factor and leaves the tetrahedral
three-coordinate record exactly unchanged. Thus normalized Fisher geometry
cannot produce the gravity factor on this line. Lean then proves the sharp
fork: a classical reading leaves complement `1/Q`, whereas a Hilbert amplitude
has hidden Born weight `lambda4^2` and visible complement `S_Q`. The existing
modular-GNS construction supplies the amplitude interpretation. This places
gravity screening in the total accessible information weight while preserving
the conditional shape of each retained 3D record. The associated Fisher-cone
theorem then proves an exact `3 + 1` split: four positive weights decompose
orthogonally into three normalized shape directions and one total-mass
direction. This is a precise information-geometric candidate for the PDT
three-dimensional/four-dimensional divide; its spacetime interpretation
remains a physical identification. A combined Lean theorem also proves that
the hidden radial Born mass is `lambda4^2`, that the positive Hermitian reading
adds it, and that both the local and global quartic trace forms subtract that
same mass to give `S_Q`. This makes the Born-to-Lorentzian sign change exact;
the physical horizon identification remains the open link.

[`COMPLEX_HORIZON_DIRECTION.md`](COMPLEX_HORIZON_DIRECTION.md) removes a
remaining directional freedom. The normalized visible and hidden branches of
the minimal dilation span a real orthogonal two-plane. Once represented in
the quartic complex place with the visible branch at `1`, Lean proves that the
hidden branch must be `+i` or `-i`; a chosen orientation fixes the sign. The
positive form counts its Born mass while the untwisted trace form makes it
timelike and subtracts the same mass. What remains is to derive why the local
horizon algebra identifies this abstract branch plane with Q's arithmetic
complex place.

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
sharp-horizon setting.  [`MODULAR_COVARIANT_ERASURE.md`](MODULAR_COVARIANT_ERASURE.md)
then proves that the finite tangent channel commutes with every diagonal
modular phase action.  A quartic input mode therefore keeps its spectral label
while its relative entropy and BKM/Fisher information contract by exactly
`S_Q`.  What remains is its net-compatible placement and sharp-horizon limit,
followed by the physical coupling of the unconditioned retained weight to
Jacobson's area density.

[`JACOBSON_PLACEMENT_AUDIT.md`](JACOBSON_PLACEMENT_AUDIT.md) now gives that
coupling a sharp pass/fail test.  If `S_Q` scales both heat flux and entropy
density it cancels out of the Clausius relation; if it scales heat alone it
changes `G` in the wrong direction.  The deposited inverse response requires
an unscaled physical flux and an `S_Q` entropy-per-area density.  The explicit
dilation proves that a globally counted diagonal observable is conserved even
while its exterior contribution is screened, so this placement is internally
consistent.  Deriving the retained branch as the physical horizon cell
density remains the open identification.

[`INFORMATION_AREA_BRIDGE.md`](INFORMATION_AREA_BRIDGE.md) substantially
narrows that identification.  The erasure channel scales the full Fisher/BKM
metric by `S_Q`; on the two-dimensional state surface of a four-dimensional
causal-horizon cut, its information-area form therefore scales by exactly
`S_Q`.  The complementary coframe amplitude `sqrt(S_Q)` follows as the square
root of this metric response.  Identifying that information-area measure with
the microscopic density in Jacobson's area law would complete the screening
mechanism; that physical identification and its sharp-horizon construction
remain open.

[`CANONICAL_ENERGY_BRIDGE.md`](CANONICAL_ENERGY_BRIDGE.md) gives an independent
gravity route.  In the established AdS-Rindler dictionary, quantum Fisher
information equals gravitational canonical energy.  Applying that dictionary
to the same normalized quartic horizon mode makes the `S_Q` Fisher contraction
scale `1/G` and therefore forces `G_Q=G_0/S_Q`.  The audit also proves the
essential ambiguity: at fixed `G`, the same contraction can be absorbed into
the perturbation amplitude.  Flux or area normalization must therefore fix
the geometric mode before the coupling conclusion follows.

[`HORIZON_SHEAR_BRIDGE.md`](HORIZON_SHEAR_BRIDGE.md) places that ambiguity on
the two physical graviton polarizations. Their transverse-traceless tensor
norm is exactly `2*(plus^2+cross^2)`, so scaling both amplitudes by
`sqrt(S_Q)` gives the same local shear energy as scaling `1/G` by `S_Q`.
This is an exact degeneracy: shear-squared alone cannot choose between a
smaller disturbance and a screened coupling. Once an external source, area
displacement, or global isometry fixes the same nonzero shear at both
endpoints, the Lean theorem forces `G_Q=G_0/S_Q`. The remaining physical
target is therefore a same-mode normalization theorem in the sharp observer
horizon construction. The same file then carries that wave-sector
normalization through the Pauli--Fierz Ward identities to every lapse and
shift constraint term and composes it with the complete sourced operator
reduction. This proves that one successful information/shear identification
would fix both radiative and static linear gravity without a second placement
assumption.

[`GravityScreening/HorizonShearNormalization.lean`](GravityScreening/HorizonShearNormalization.lean)
then inserts the perturbative gravity normalization used by Faulkner and
Speranza: `kappa^2=32*pi*G` and
`sigma=(kappa/2)*dot(rho)`. It follows exactly that the canonically normalized
graviton shear energy is `sigma^2/(8*pi*G)`. This supplies the missing physical
meaning of “same mode”: at fixed physical horizon shear, an `S_Q` contraction
of canonical energy is equivalent to `G_Q=G_0/S_Q`.

[`CUT_VS_COUPLING_AUDIT.md`](CUT_VS_COUPLING_AUDIT.md) now proves a crucial
separation. Between successive horizon cuts in one theory, the crossed-product
constraint holds `G` fixed and converts an `S_Q` reduction of modular energy
into the complementary area change `lambda4^2`. At a single cut, uniformly
scaling modular energy and `1/G` while holding the asymptotic charge fixed
violates the constraint unless that charge vanishes. The observer-horizon
part is therefore a cut-to-cut evolution, while gravity screening requires a
distinct microscopic-to-effective comparison of the same normalized
geometric mode.
The same quartic coefficient may govern both axes, but one axis cannot be used
as a proof of the other.

[`GRAVITATIONAL_TIME_DILATION_BRIDGE.md`](GRAVITATIONAL_TIME_DILATION_BRIDGE.md)
adds the clock-to-geometry map. The normalized quartic phase is the unitary
clock carrier; the `p`-`Q` portal couples it to records; the spacetime lapse
converts its modular parameter into observer-dependent proper time. The phase
is invariant under this redshift reparametrization. Jacobson's boost
normalization cancels between heat and temperature, so time dilation connects
the clock to geometry without independently fixing `G`. Gravity remains
`pQ`-anchored through its unscreened scale and `Q`-resolved through `S_Q`.

[`RINDLER_QUARTIC_CLOCK.md`](RINDLER_QUARTIC_CLOCK.md) derives the exact local
Rindler reading of the Perron/KMS clock. Conditional on the physical horizon
embedding, its energy satisfies `E_Q/T_U=log Q`, its Boltzmann weight is
`1/Q`, its response defect is `lambda4`, and normalized completion gives
`S_Q`. [`TWO_Q_CLOCKS_AUDIT.md`](TWO_Q_CLOCKS_AUDIT.md) then prevents a new
conflation: the conjugate-root projective frequency `theta_Q` and the modular
frequency `log Q` have a transcendental ratio. No algebraic portal coefficient
can identify them by a constant linear rescaling. Their separate physical
roles, or their geometric state-dependent conversion, remain to be fixed.

[`KILLING_REDSHIFTED_QUARTIC_CLOCK.md`](KILLING_REDSHIFTED_QUARTIC_CLOCK.md)
makes the gravitational time-dilation statement explicit. For a stationary
near-horizon lapse `N`, both the local quartic energy and temperature scale as
`1/N`, while one modular unit takes proper duration `2*pi*N/kappa_H`.
Consequently `E_Q/T=log Q`, the weight `1/Q`, and the screening factor `S_Q`
are observer independent. This is an exact scalar realization of thermal time
as a gravitationally redshifted clock, conditional on the modular embedding.

[`CORE_CLOCK_DUALITY.md`](CORE_CLOCK_DUALITY.md) then joins the clock and
screening sides inside one observer crossed-product action. The dual
displacement `s=log Q` acts on the clock unitary `lambda_t` with character
`Q^(-it)` and scales the canonical trace by `1/Q`. Its defect is `lambda4` and
the complement of its repeated self-defect is `S_Q`. This evades the free-wedge
point-spectrum obstruction because the clock unitary belongs to the observer
extension, while keeping the remaining area/kinetic coupling explicit.
The same result separates harmless lapse redshift from an intrinsic modular
shift: replacing `log Q` by `log Q+delta` multiplies the phase by
`exp(-i*delta*t)` and the trace weight by `exp(-delta)`; exact preservation of
the quartic defect forces `delta=0`.

[`CLOCK_HODGE_BRIDGE.md`](CLOCK_HODGE_BRIDGE.md) carries this into the
gravitational charge sector. The dual action translates the linear horizon
area charge, so its repeated defect cannot multiplicatively screen linear
area; it does scale the exponential area information weight by `S_Q`. The
same core eigenweight `1/Q` has a unique mean-preserving completion on one
Hodge pair, with weights `1-lambda4` and `1+lambda4` and determinant `S_Q`.
This reduces the physical open step to deriving that traceless chiral
completion in the sourced horizon kinetic operator.

[`SPIN2_BOOTSTRAP_BRIDGE.md`](SPIN2_BOOTSTRAP_BRIDGE.md) shows why a successful
quadratic identification would largely finish the dynamical construction.
Four-dimensional linearized Einstein gravity already has a two-prepotential
duality formulation, and consistent local self-coupling of a massless
spin-two field supplies the Einstein nonlinearities. PDT would contribute the
fixed normalization `M_P,Q^2=S_Q M_P,0^2`; the remaining theory-specific seam
is to prove that the Q Hodge pair is the physical prepotential pair and is
compatible with its constraints. Standard duality-symmetric source theory
identifies ordinary stress-energy as the electric source and the second source
as NUT charge. This fixes the decisive test: the Q block must give its inverse
response in the ordinary `(T,0)` sector without generating an independent
magnetic charge.

[`SPIN2_CONSTRAINT_PLACEMENT.md`](SPIN2_CONSTRAINT_PLACEMENT.md) isolates the
last placement requirement. A static mass enters linearized gravity through
the lapse and momentum constraints, so changing only the transverse
prepotential Hamiltonian is insufficient to change Newton's law. The reduced
Q parent action must yield `S_Q` times the complete sourced Pauli--Fierz
action, including lapse and shift. If it does, the spin-two bootstrap carries
the same coefficient into nonlinear Einstein gravity.

[`EFFECTIVE_GRAVITY_CLOSURE.md`](EFFECTIVE_GRAVITY_CLOSURE.md) states the
strongest result at its honest level. If the complete spin-two normalization
is identified with the normalized orientation-even quadratic response of the
Q direction, its value is uniquely forced to `S_Q`; the source response is
`1/S_Q`, positivity is automatic for `Q>1`, and the standard massless
spin-two bootstrap supplies Einstein gravity. This is a closed zero-parameter
effective theory. Deriving its one constitutive identification from a
microscopic sourced Q action remains the explanatory frontier.

[`SYMPLECTIC_OPERATOR_REDUCTION.md`](SYMPLECTIC_OPERATOR_REDUCTION.md) removes
the one-mode restriction from the first-order calculation.  For an arbitrary
real field space and symmetric bilinear spatial operator, eliminating the
canonical dual partner and pairing the two orientations gives exactly
`S_Q=1-lambda4^2` times the complete orientation-even propagating quadratic
form.  The only unclosed spin-two placement question is now the lapse/shift
source-constraint sector.

[`PALOMAR_READINESS.md`](PALOMAR_READINESS.md) records why the effective
closure alone is not yet the strongest registry submission, identifies the
current operator-level theorem group, and states the sourced-constraint
theorem that would make the package compelling.

[`ELECTRIC_SOURCE_FRAME.md`](ELECTRIC_SOURCE_FRAME.md) gives the new
source-level closure.  A unique positive lower-triangular symplectic Gram
factor preserves the ordinary electric source ray, generates no magnetic
source component, and yields the complete inverse response `1/S_Q`.  The same
block reduces all four lapse-and-shift constraint labels uniformly.  The
remaining task is to instantiate this internal frame in the full local
derivative variables of the published doubled spin-two action.

[`SPIN_TWO_NORMALIZATION.md`](SPIN_TWO_NORMALIZATION.md) closes the abstract
normalization-placement question for the standard flat massless spin-two
operator.  Its three divergence relations plus formal self-adjointness leave
only one coefficient, so a quartic normalization fixed in the propagating
wave term necessarily multiplies the lapse and shift constraint terms as
well.  The corresponding coefficient theorem and quartic specialization are
kernel checked in `GravityScreening/PauliFierzUniqueness.lean`.

[`UNIQUENESS_LADDER.md`](UNIQUENESS_LADDER.md) separates the distinct
selection and uniqueness results: generator selection, pair distinctiveness,
the quartic two-channel completion, the source-preserving frame, and the
massless spin-two operator.  `GravityScreening/PauliFierzSymbol.lean`
strengthens the last step by deriving its coefficient relations directly from
the four-dimensional Fourier-symbol Ward identity and self-adjointness.
`GravityScreening/LorentzPauliFierzSymbol.lean` repeats the result directly in
Minkowski signature with every index-raising sign explicit.

[`LOCAL_DOUBLED_SPIN_TWO.md`](LOCAL_DOUBLED_SPIN_TWO.md) lifts the quartic
block from individual modes to an arbitrary complete linear operator.  For
the Pauli--Fierz operator, eliminating the source-free partner gives
`S_Q E_PF(h)=T` without inverting `E_PF`, preserves its gauge kernel and Ward
identity, and forces source conservation.  The generic operator theorem is
kernel checked in `GravityScreening/DoubledSpinTwoOperator.lean`.
`GravityScreening/DoubledSpinTwoAction.lean` proves the corresponding
variation formulas and a completed-square positivity theorem for the quartic
mixing on the positive physical polarization space.

[`SPIN_TWO_DEGREE_AUDIT.md`](SPIN_TWO_DEGREE_AUDIT.md) diagonalizes that
action into its even and odd channels.  It records the resulting physical
fork: as an unconstrained second-order action it contains two massless
spin-two channels, while a one-graviton Hodge-dual reading still needs the
first-order twisted-self-duality constraint.  The exact channel and source
decompositions are kernel checked in
`GravityScreening/SpinTwoDegreeAudit.lean`.

[`FIRST_ORDER_ONE_GRAVITON_BRIDGE.md`](FIRST_ORDER_ONE_GRAVITON_BRIDGE.md)
then implements the viable branch of that fork.  It adds the ordinary source
to the first-order symplectic action and proves that its stationary position
and momentum equations are exactly the two screened equations.  The two
variables are one canonical pair in this formulation, so the internal
screening mechanism does not itself require a second graviton.  The remaining
step is its explicit gravitational-prepotential instantiation and PDT
identification.  The action identities are kernel checked in
`GravityScreening/FirstOrderSourceAction.lean`.
`GravityScreening/TransverseTracelessCount.lean` additionally proves, by an
explicit linear equivalence, that the reduced symmetric transverse-traceless
tensor has two polarization coordinates and that its canonical phase space
has dimension four.  Thus the first-order Q deformation retains the standard
two configuration-space graviton degrees of freedom.

[`CLOCK_FORCES_CONSTITUTIVE.md`](CLOCK_FORCES_CONSTITUTIVE.md) removes the
mixing coefficient from the remaining internal matrix freedom.  Channel
exchange symmetry, unit mean diagonal normalization, and the retained clock
weight `1/Q` on the even channel uniquely force
`[[1,-lambda4],[-lambda4,1]]`, hence determinant `S_Q`.  The matrix uniqueness
and exact quartic determinant are kernel checked in
`GravityScreening/ClockForcesConstitutive.lean`.

[`CLOCK_TO_GRAVITY_CHAIN.md`](CLOCK_TO_GRAVITY_CHAIN.md) expresses `1/Q` as
the action of the already derived Q-clock translation on the gravitational
even channel.  Lean proves that this action statement is equivalent to the
even-weight premise, preventing it from being counted as an additional
derivation.  From that single carrier premise it forces
the whole constitutive matrix, identifies the same `lambda4` with the quartic
renewal frequency and normalized Perron residue, and reduces an arbitrary
complete sourced linear operator to `S_Q E(h)=T`.  The sole remaining
identification is therefore the carrier: the gravitational prepotential even
channel must be the physical realization of the Q-clock action.

[`CLOCK_GRAVITY_FACTORIZATION.md`](CLOCK_GRAVITY_FACTORIZATION.md) records the
reverse audit of that identification.  A modular clock step by `log Q` is not
itself the gravitational canonical squeeze: their eigenvalue ratios are
respectively `Q^2` and `2Q-1`, and Lean proves these differ for `Q>1`.  Instead,
the clock retention factors exactly into the common gravity action scale
`sqrt(S_Q)` times one eigenvalue of a reciprocal determinant-one squeeze.  In
this precise sense time and gravity use the same Q event differently: the
first supplies the contraction, while the second splits it into coupling
scale and canonical shape.

[`INFORMATION_TO_GRAVITY_CHAIN.md`](INFORMATION_TO_GRAVITY_CHAIN.md) supplies
an independent route that bypasses the constitutive matrix.  The proved
quartic erasure channel contracts the Fisher bilinear by `S_Q`; if the
microscopic and effective metrics are identified with canonical energies of
the same independently normalized gravitational mode, Lean forces
`G_Q=G_0/S_Q`.  The physical frontier on this route is the extension of the
published AdS-Rindler Fisher/canonical-energy dictionary to the local PDT
observer horizon with its mode normalization fixed.

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
- [`GravityScreening/ErasureCovariance.lean`](GravityScreening/ErasureCovariance.lean)
  proves that the erasure tangent commutes with every diagonal phase action,
  preserves phase eigenmodes, and combines that covariance with the exact
  quartic relative-entropy contraction.
- [`GravityScreening/JacobsonPlacement.lean`](GravityScreening/JacobsonPlacement.lean)
  proves the heat-versus-entropy placement ledger, the common-scaling
  cancellation, and the uniqueness of unit heat normalization for the target
  inverse response.
- [`GravityScreening/ConservedFlux.lean`](GravityScreening/ConservedFlux.lean)
  proves that the exterior and hidden expectations of any finite diagonal
  observable have weights `s` and `1-s`, while their global sum is conserved.
- [`GravityScreening/InformationArea.lean`](GravityScreening/InformationArea.lean)
  proves that the full two-dimensional Fisher metric, its determinant, and its
  positive area element scale by `s`, `s^2`, and `s`, respectively, with the
  exact quartic specialization.
- [`GravityScreening/CanonicalEnergy.lean`](GravityScreening/CanonicalEnergy.lean)
  proves the coupling-versus-amplitude alternatives for a canonical-energy
  bilinear and the exact conditional quartic inverse-coupling response.
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
In a finite type-I split collar, the explicit erasure dilation now proves
global information conservation, exact exterior contraction, and covariance
of every diagonal spectral line. Thus the channel itself need not change the
clock frequency when it screens distinguishability. Its net-compatible
placement in the observer crossed product and its coupling to physical area
density remain open.
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
