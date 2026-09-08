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

Likewise, an abstract Haar measure on compact `SO(3)` may be normalized to
any total mass. The value `pi^2` here is specifically the Riemannian volume
inherited from the round unit `S^3` under its two-to-one antipodal quotient.
This metric normalization is part of the correspondence that remains to be
derived physically.

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
- `screenedPlanckElectronRatio`
- `gravitationalCoupling_eq_inverse_screenedPlanckRatio_sq`
- `ttBoundaryVolumeResponse_unique_of_symmetry`
- `ttBoundaryVolumeResponse_det`
- `sThreeBoundaryVolume_sq`
- `gravitationalCoupling_eq_boundaryDet_div_combinedResponse`
- `boundaryMeasure_twoPolarization_gravity_capstone`

These declarations contain no `sorry` and use only Mathlib's standard
logical axioms.
