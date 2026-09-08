# Boundary measure and the pi-fourth gravity numerator

The gravity formula in this repository contains

```text
alpha_G = pi^4 / ((rho Q)^224 S_Q).
```

Its direct source is the inverse-square definition of the dimensionless
gravitational coupling. Define the screened Planck-to-electron ratio by

```text
M_P,eff/m_e = (rho Q)^112 sqrt(S_Q) / pi^2.
```

Lean proves

```text
alpha_G = 1/(M_P,eff/m_e)^2
        = pi^4 / ((rho Q)^224 S_Q).
```

Thus the fourth power and the exponent `224` are forced by squaring the
deposited mass-ratio formula. This is the primary explanation of the powers.

The same numerator also has an exact geometric and spin-two factorization.

Lean proves the polar surface measure of the unit three-sphere:

```text
Vol(S^3) = 2 pi^2.
```

The antipodal quotient `S^3 -> RP^3` halves this value, so its numerical
quotient volume is `pi^2`. The numerical equality is proved in Lean. The
measure-halving theorem for the free antipodal action and the identification
of this round quotient with the physical measurement space remain explicit
geometric and physical inputs.

Lean also checks the same value directly in polar coordinates:

```text
4 pi integral_[0,pi/2] sin^2(chi) dchi
  = 4 pi (pi/4)
  = pi^2.
```

These are two exact calculations of one quotient geometry. They should not be
counted as two independent physical identifications.

There is a necessary geometric distinction. A future null direction in
`3+1` dimensional Minkowski space is a point of the celestial `S^2`.
`RP^3` can instead describe the full spatial rotation or polarization-frame
space `SO(3)`, or a round `S^3` conformal slice after antipodal
identification. The PDT correspondence must select and justify one of those
three-dimensional spaces; it cannot identify `RP^3` with a null direction
alone.

The observer-frame part of that statement is now derived rather than assumed.
In the diagonal Minkowski frame, Lean proves that every Lorentz matrix fixing
the future unit rest observer has no remaining boost entries and is exactly
the identity-on-time lift of a unique orthogonal `3 x 3` matrix. Conversely,
every orthogonal spatial matrix has such a lift. Thus the full rest-observer
stabilizer is equivalent to `O(3)`. Its determinant is necessarily `+1` or
`-1`; imposing preservation of the apparatus orientation selects an actual
member of Mathlib's `SO(3)`.

This closes the group-classification step while keeping the physical step
visible. A fixed observer leaves rotations unresolved, but Lorentz geometry
alone does not say that a measured coupling must be integrated over those
rotations. It also does not choose the scale of the invariant metric.

Likewise, an abstract Haar measure on compact `SO(3)` may be normalized to
any total mass. The value `pi^2` here is specifically the Riemannian volume
inherited from the round unit `S^3` under its two-to-one antipodal quotient.

The Pauli measurement normalization now fixes the scale of that round cover
algebraically. Lean proves all three Pauli axes are involutions and are
orthonormal under the half-trace pairing:

```text
sigma_j^2 = I,
(1/2) Re tr(sigma_j sigma_k) = delta_jk.
```

In the corresponding four real quaternion coordinates, Lean then proves

```text
U(a,b,c,d)^* U(a,b,c,d) = I and det U(a,b,c,d) = 1
  iff a^2 + b^2 + c^2 + d^2 = 1.
```

Thus the same `+-1` observable convention used in the CHSH/Tsirelson setting
selects the unit `S^3` special-unitary cover. Lean also proves that antipodal
coefficient vectors give matrices `U` and `-U` with exactly the same
conjugation action on every qubit observable. This proves the antipodal
identification underlying the projective quotient. What remains physically is
to identify the observer-frame metric with this half-trace measurement metric;
the free antipodal quotient's measure-halving is still an explicit geometric
input.

The upstream convention has public, registered provenance. It is the
Hermitian-involution normalization used in
[PALOMAR-2026-08-19-000007](https://palomar-registry.org/entry.html?id=PALOMAR-2026-08-19-000007)
for the Tsirelson result and in
[PALOMAR-2026-09-01-000003](https://palomar-registry.org/entry.html?id=PALOMAR-2026-09-01-000003)
for the entanglement/Werner package. The present theorem does not re-compare
those results and does not treat registration as support for a physical
claim. It derives the gravity package's unit spin-frame scale from the same
already formalized observable convention.

The next bridge is also kernel-checked. Conjugation by the quaternion matrix
on the real Pauli span has an explicit three-by-three coefficient matrix `R`.
Lean proves, whenever `a^2+b^2+c^2+d^2=1`,

```text
R^T R = I,   det R = 1,   R(-a,-b,-c,-d) = R(a,b,c,d).
```

Thus the unit spin frame produces an element of the exact Mathlib `SO(3)`
type already identified as the oriented rest-observer gauge. The preimage of
the identity rotation is proved to be exactly the two points `(+1,0,0,0)` and
`(-1,0,0,0)`. This proves the kernel and antipodal parts of the double-cover
statement. The global surjectivity of this explicit map onto every `SO(3)`
matrix is not yet formalized.

The integration step is also explicit. For any finite left-invariant measure
on the `SO(3)` observer-rotation group, Lean proves that integrating a scalar
vertex over the group multiplies the vertex by the measure's total mass. If
that mass is the round projective value, the 15-channel vertex becomes

```text
integral_SO(3) (rho Q)^(-15) dmu
  = pi^2 (rho Q)^(-15)
  = alpha.
```

Substitution into the exact electromagnetic-to-gravity factorization gives

```text
alpha_G
  = integral_SO(3) (rho Q)^(-15) dmu
      * pi^2 / ((rho Q)^209 S_Q).
```

Together with `224 = 15 + 209`, this reproduces the full formula. The theorem
proves the mathematical content of the inclusive-integration rule. Its use as
the operational definition of the physical zero-momentum coupling, and the
identification of the physical frame metric with the Pauli half-trace metric,
remain the correspondence premises.

There is a sharp normalization fork. For the same round measure and any
nonzero scalar vertex, Lean proves

```text
inclusive integral = pi^2 * vertex,
normalized average = vertex,
inclusive integral != normalized average.
```

Thus a normalized gauge average cannot be the source of the `pi^2` factor.
The required physical statement is narrower: the measurement must sum over
distinct frame outcomes with the round density of states, or an independently
derived operational measure must produce the same unnormalized mass. This is
the principal unresolved physics step in the boundary-measure route.

There is now a second, more concrete conditional route. A real field's
Fourier coefficients obey `h(-k)=conj(h(k))`, which Lean proves makes the mode
power antipode-even. Lean also proves that the unit shell in four real mode
coordinates has no antipodal fixed points. Hence counting each real-mode pair
once gives the exact half-shell integral

```text
(1/2) * integral_S3 vertex = pi^2 * vertex.
```

The 15-channel vertex then reproduces the electromagnetic expression and the
existing `15+209=224` factorization reproduces gravity. This avoids claiming
that a normalized gauge average generates a volume. Its remaining physical
premise is specific: after separating the radial scale, the renormalized
zero-momentum response must be a density over Euclideanized four-mode
directions with the stated Fourier normalization and Jacobian. That step has
not yet been derived from the action or spectral trace.

The next theorem removes the radial-coordinate assumption. For every radial
profile `f`, ordinary four-dimensional Lebesgue measure satisfies

```text
integral_R4 f(||k||) d^4k
  = 2*pi^2 * integral_(0,infinity) r^3 f(r) dr.
```

The kernel also evaluates the relevant Gaussian moment and obtains

```text
integral_R4 exp(-||k||^2) d^4k = pi^2.
```

This yields a sharper bulk-boundary candidate for the gravity numerator. The
first `pi^2` is the raw four-dimensional Gaussian mode trace that already
turns `(rho Q)^(-15)` into the electromagnetic expression. The second
`pi^2` is the projective boundary volume specific to the gravitational link.
Their product is the required `pi^4`.

The theorem deliberately exposes the remaining convention. If the momentum
measure is instead `d^4k/(2*pi)^4`, Lean obtains `1/(16*pi^2)`. Therefore the
bulk assignment is not yet a physical derivation: the two-scalar action or
spectral trace must fix the measure and Gaussian scale, and must either yield
the raw Lebesgue convention or supply the exact compensating normalization.
This is a yes-or-no mechanism test.

Independently, Lean proves that the transverse-traceless graviton space at
fixed nonzero momentum has exactly two real polarizations. On this
polarization plane, rotational covariance and self-adjointness force a common
response to be scalar. If one diagonal entry is the projective boundary
normalization `pi^2`, symmetry fixes the entire response:

```text
M = pi^2 I_2.
```

Its determinant is therefore

```text
det(M) = (pi^2)^2 = pi^4.
```

Lean then rewrites the complete gravitational coupling exactly as

```text
alpha_G
  = det(pi^2 I_2)
      / (det((rho Q) I_224) det(B_lambda4)).
```

The denominator is the previously proved common 224-direction response times
the quartic constitutive determinant `S_Q=1-lambda4^2`.

The related `4*pi^4` in the area-quantum formula is the unquotiented version:

```text
Vol(S^3)^2 = (2 pi^2)^2 = 4 pi^4.
```

This distinguishes two constants that should not be conflated:

| constant | exact mathematical role |
|---|---|
| `2 pi` | conversion from modular time to boost rapidity |
| `2 pi^2` | polar surface measure of the unit `S^3` |
| `pi^2` | numerical half-volume for the antipodal quotient |
| `pi^4` | two-polarization determinant of the projective boundary normalization |
| `4 pi^4` | square of the unquotiented `S^3` surface measure |

This determinant is a compatibility result, not yet a second derivation of the
physical coupling. Photons also have two transverse polarizations, so the
two-polarization count alone cannot explain why gravity receives the squared
factor. The inverse-square Planck relation explains the square. Turning the
determinant representation into a mechanism requires an additional result:
the gravitational response must integrate the round projective frame-space
measure in a way the photon coupling does not. That final identification is
represented by one visible normalization premise: a polarization response
has diagonal value `pi^2`. All consequences of that premise are forced.

## Kernel-checked declarations

- `euclideanVolume_toSphere_univ`
- `unitS3_surfaceMeasure`
- `projectiveBoundaryVolume_eq_pi_sq`
- `projectivePolarFactor`
- `projectivePolarVolume_eq_pi_sq`
- `lorentzFixingRestObserver_timeRow`
- `lorentzFixingRestObserver_spatialBlock_orthogonal`
- `restFrameLift_preservesMinkowski_iff`
- `lorentzFixingRestObserver_eq_restFrameLift`
- `restObserverStabilizerEquivO3`
- `lorentzFixingRestObserver_spatialDet_dichotomy`
- `orientedLorentzRestFrame_spatialBlock_mem_SO3`
- `integral_rotationScalar_eq_mass_mul`
- `normalizedRotationAverage_eq_vertex`
- `roundIntegral_normalization_fork`
- `roundIntegral_ne_normalizedAverage`
- `conformalChannelVertex_integral_eq_electromagneticCoupling`
- `gravitationalCoupling_eq_integratedObserverVertex_link`
- `realityConstrained_modePower_antipode`
- `unitModeShell_antipode_ne_self`
- `fourModeShellMeasure_real_univ`
- `projectiveModeShellScalarIntegral_eq_pi_sq_mul`
- `conformalChannelVertex_projectiveModeShell_eq_electromagneticCoupling`
- `gravitationalCoupling_eq_projectiveModeShell_link`
- `fourMode_radial_integral`
- `gaussian_radial_moment_three`
- `fourMode_gaussian_integral`
- `fourierNormalized_fourMode_gaussian_integral`
- `gaussianModeVertexIntegral_eq_pi_sq_mul`
- `conformalChannelVertex_gaussianMode_eq_electromagneticCoupling`
- `gravitationalCoupling_eq_gaussianMode_boundary_link`
- `pauliAxis_sq`
- `pauliAxes_halfTrace_orthonormal`
- `quaternionSU2Matrix_det`
- `quaternionSU2Matrix_conjTranspose_mul`
- `quaternionSU2Matrix_specialUnitary_iff_unitSphere`
- `quaternionFrameAction_antipode`
- `pauliFrame_unitSphere_projectiveVolume_capstone`
- `quaternionFrameAction_pauliVector`
- `quaternionPauliRotation_transpose_mul`
- `quaternionPauliRotation_det`
- `quaternionPauliRotation_mem_SO3`
- `unitQuaternionObserverRotation_antipode`
- `quaternionPauliRotation_eq_one_iff`
- `pauliAdjoint_observerRotation_capstone`
- `screenedPlanckElectronRatio`
- `gravitationalCoupling_eq_inverse_screenedPlanckRatio_sq`
- `ttBoundaryVolumeResponse_unique_of_symmetry`
- `ttBoundaryVolumeResponse_det`
- `sThreeBoundaryVolume_sq`
- `gravitationalCoupling_eq_boundaryDet_div_combinedResponse`
- `boundaryMeasure_twoPolarization_gravity_capstone`

These declarations contain no `sorry` and use only Mathlib's standard
logical axioms.
