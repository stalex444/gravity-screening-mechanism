# Unoriented clock weight and conserved information flux

## Result

Two apparent gravity seams collapse to one.

First, the sign of the Hodge coupling is not an additional premise for the
parity-even screened response.  Let

```text
R(lambda) = I + lambda C
```

on the four-real-mode TT/Hodge space.  The orthogonal involution which fixes
the physical TT coordinates and reverses the two Hodge-partner coordinates
exchanges the two chiral planes and proves

```text
R(-lambda) = P^T R(lambda) P.
```

It also converts the quadratic kinetic form at `lambda` into the form at
`-lambda`.  Consequently

```text
screening(-lambda) = screening(lambda),
Z(-lambda)         = Z(lambda),
F(-lambda)         = F(lambda).
```

The two signs are basis-gauge representatives of the same parity-even
response.  An orientation choice remains relevant for an orientation-odd
observable, including the signed mixed Fisher-cone term, but it is not needed
to compute gravity's determinant response.

Second, the quartic clock weight need not be assigned to a pre-labeled even
channel.  For an exchange-symmetric real two-channel response `M`, impose:

1. the mean diagonal normalization is one; and
2. one of the two exchange eigenspaces carries the graph-KMS weight `1/q`.

Lean proves the sign-free classification

```text
M = constitutiveBlock(lambda4(q))
or
M = constitutiveBlock(-lambda4(q)),
```

and both branches force

```text
det M = 1-lambda4(q)^2 = (2q-1)/q^2.
```

Thus the physical placement question does not include an independent chiral
label.  It asks only whether the quartic modular line occurs in one of the
gravitational exchange channels.

## The information-conservation capstone

The finite erasure dilation already separates exterior accessibility from
global conservation.  At retention

```text
s = 1-lambda4(q)^2,
```

it sends every diagonal observable `k` and state amplitude `psi` to exterior
and hidden branches satisfying

```text
exterior expectation = s * original expectation,
exterior expectation + hidden expectation = original expectation.
```

The new capstone joins this theorem to the sign-free clock classification:

```text
det M = s,
exterior expectation = det(M) * original expectation,
exterior + hidden = original.
```

This is an exact finite mathematical model in which the coefficient forced in
the gravitational response is the fraction of information-energy accessible
on the exterior branch, while the global observable is conserved.  If `k` is
read as an energy observable, it is the present rigorous core of the proposal
that gravity tracks quantum information as it settles.

It does not yet derive matter creation.  In particular, the theorem does not
show that a stabilized record has inertia or that its conserved diagonal
expectation is the physical stress-energy tensor.

## What remains

The modular-map and free-wedge audits already reduce the physics to one
interface.

The quartic graph fixes a KMS step with weight `1/Q`.  A state-preserving
embedding into a type-III wedge algebra exists, but the ordinary linearized
Fock wedge has no nonzero bounded modular eigenoperator with exact phase
`Q^(-it)`.  The continuous core of the wedge does contain the needed dual
action: its canonical trace scales by `1/Q`, and the complement of the
twice-applied defect has eigenvalue `1-lambda4^2` on the trace ray.

A global trace normalization alone cannot change Jacobson's normalized
entropy variation.  The remaining construction must make the quartic core
operation act noncentrally on either:

```text
the Hodge kinetic response,
or
the local horizon area-resolution density.
```

Those are two representations of the same required interface.  Producing
either one from a clock-dressed two-scalar or observer-core action would
complete the coefficient mechanism.  The broader claim that settled
information becomes matter additionally requires a conserved stress-energy
construction and an inertia theorem.

## Lean surface

The sign-gauge results are in
`GravityScreening/HodgeOrientationGauge.lean`:

```text
hodgePartnerFlip_sq
hodgePartnerFlip_conj_chirality
hodgePartnerFlip_plus
hodgePartnerFlip_minus
realDoubledResponse_neg_conjugate
doubledHodgeKinetic_partnerFlip
orientationEven_response_sign_quotient
quartic_orientation_sign_is_gauge
```

The unoriented clock and information-conservation results are in
`GravityScreening/UnorientedClockGravity.lean`:

```text
oddClockWeight_forces_constitutiveBlock
unorientedClockWeight_forces_response_or_flip
unorientedClockWeight_forces_screening
unorientedClockWeight_forces_quarticResponse
unorientedClockWeight_classification
unorientedClock_informationGravity_conservation
```

All declarations are pure mathematics.  Interpreting the exterior diagonal
observable as physical energy and the response matrix as gravitational
kinetics remains a physical correspondence.

## Primary references for the physical interface

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*,
  <https://arxiv.org/abs/1505.04753>.
- Y. Kawahigashi, Y. Ogata, and E. Stormer, *Normal states of type III
  factors*, <https://arxiv.org/abs/1301.5737>.
- J. J. Bisognano and E. H. Wichmann, *On the Duality Condition for a
  Hermitian Scalar Field* (1975), for wedge modular flow as boosts.

