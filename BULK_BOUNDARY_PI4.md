# The bulk-boundary origin of the `pi^4` numerator

This note separates the two exact `pi^2` factors in the proposed PDT gravity
formula. It records what Lean proves, what is a physical correspondence, and
the single normalization test that remains.

## The exact chain

| Stage | Exact statement | Status |
|---|---|---|
| Four-dimensional polar coordinates | `integral_R4 f(||k||) d^4k = 2*pi^2 * integral_0^infinity r^3 f(r) dr` | Lean theorem |
| Gaussian radial moment | `integral_0^infinity r^3 exp(-r^2) dr = 1/2` | Lean theorem |
| Raw Gaussian mode trace | `integral_R4 exp(-||k||^2) d^4k = pi^2` | Lean theorem |
| Doubled TT/Hodge Gaussian | `integral_R4 exp(-z^T R_lambda z) d^4z = pi^2/S_lambda` | Lean theorem for `S_lambda>0` |
| Conventional doubled action | `integral_R4 exp(-(1/2)z^T R_lambda z) d^4z = 4*pi^2/S_lambda` | Lean theorem; factor-four mismatch with the proposed numerator |
| Common 15-channel vertex | `pi^2 * (rho Q)^(-15) = alpha_EM` as defined in the deposited formula | Exact conditional rewrite |
| Projective boundary | `Vol(S^3)/2 = pi^2` in the Pauli-fixed unit metric | Lean theorem; physical use is a correspondence |
| Screened bulk-boundary factor | `(pi^2/S_Q) * pi^2 = pi^4/S_Q` | Lean theorem |
| Gravity factorization | `alpha_G = alpha_EM * pi^2 / ((rho Q)^209 S_Q)` | Lean theorem from the deposited definitions |
| Combined exponent | `15 + 209 = 224` | Lean theorem |
| Combined numerator | `pi^2_bulk * pi^2_boundary = pi^4` | Exact consequence |

The mathematical result is a coherent bulk-boundary split. The gravity
screening factor and a bulk Gaussian normalization come from one integral.
The real doubled response matrix already used in the spin-two/Hodge action is
the Gram matrix of a triangular change of variables. Its determinant is
`S_Q^2`, so the unit-exponent four-real-mode Gaussian has mass `pi^2/S_Q`.
Multiplication by the projective boundary volume gives `pi^4/S_Q` in one exact
chain. This is more informative than naming `pi^4` as a square or inserting
screening afterward: the response determinant and screening denominator now
meet the bulk and boundary calculations in a single theorem.

The four variables have an existing interpretation in the repository: two
real transverse-traceless polarizations and their independent Hodge-paired
partners. Lean proves that the integrand is exactly both
`z^T realDoubledResponse(lambda) z` and the existing
`doubledHodgeKinetic`. The Gaussian is therefore attached to the action's
actual response block rather than to an unrelated four-dimensional toy
integral. Lean also identifies its relation to the repository's conventional
source-free quadratic action exactly: that action is one half of this
quadratic form.

That factor changes the absolute Gaussian mass. The action-normalized integral
is `4*pi^2/S_Q`, and after multiplication by the projective boundary it is
`4*pi^4/S_Q`. Lean proves this differs from the proposed `pi^4/S_Q` target for
every `Q>1`. Thus the raw unit-exponent identity is a conditional normalization
branch, not yet the normalization selected by the written action.

## The decisive normalization fork

For the coupled response, the raw Lebesgue Gaussian trace is

```text
integral d^4z exp(-z^T R_lambda z) = pi^2/S_lambda.
```

After multiplication by the projective boundary volume, it gives

```text
(pi^2/S_Q) * pi^2 = pi^4/S_Q.
```

The frequently used QFT Fourier convention instead gives

```text
[integral d^4z/(2*pi)^4 exp(-z^T R_Q z)] * pi^2
  = 1/(16 S_Q).
```

Lean proves both statements. Therefore dimensionality alone does not choose
the physical coefficient. A derivation from the action must specify the
Fourier transform, the field normalization, the Gaussian or cutoff scale, and
the boundary measure. Any compensating factor must arise from those choices;
it cannot be inserted after the calculation.

One part is invariant under all constant normalizations. Dividing either the
unit-exponent Gaussian or the half-action Gaussian by its uncoupled value
cancels the factors `pi^2` and `4*pi^2` respectively, and Lean obtains

```text
Z(lambda)/Z(0) = 1/S_lambda.
```

The screening denominator is therefore a robust determinant ratio. The
absolute `pi^2` is measure-dependent.

## The remaining mechanism test

The quadratic operator is no longer missing: it is the existing doubled
spin-two/Hodge response. The remaining test is to derive the functional
measure attached to that operator from the covariant action or an explicit
spectral trace. That derivation must read off:

1. the momentum measure;
2. the radial profile and its scale;
3. the multiplicity or trace factor;
4. the real-mode `k ~ -k` treatment;
5. the projective boundary normalization.

The written half-action currently supplies four times the target. To derive
the proposed coefficient through this route, an independent feature of the
functional measure must supply an exact factor `1/4`; Fourier reality,
gauge fixing, and the treatment of the two Hodge-paired modes must be audited
without counting the same quotient twice. If no such factor follows, the
Gaussian route derives the relative screening only. The unresolved seam is
the absolute physical functional measure, not the quadratic response or its
determinant.

## Kernel declarations

- `fourMode_radial_integral`
- `gaussian_radial_moment_three`
- `fourMode_gaussian_integral`
- `fourierNormalized_fourMode_gaussian_integral`
- `gaussianModeVertexIntegral_eq_pi_sq_mul`
- `conformalChannelVertex_gaussianMode_eq_electromagneticCoupling`
- `gravitationalCoupling_eq_gaussianMode_boundary_link`
- `doubledTTCholesky_gram`
- `realDoubledResponse_det_of_screening_nonneg`
- `quarticRealDoubledResponse_det`
- `doubledTTModeQuadratic_eq_response`
- `doubledTTModeQuadratic_eq_doubledHodgeKinetic`
- `doubledTTMode_gaussian_integral`
- `quarticDoubledTT_gaussian_integral`
- `quarticDoubledTT_gaussian_mul_projectiveBoundary`
- `fourierNormalized_quarticDoubledTT_gaussian_mul_projectiveBoundary`
- `gravitationalCoupling_eq_quarticDoubledTT_gaussian_boundary`
- `doubledQuadraticEnergy_ttPairs`
- `doubledTTMode_actionGaussian_integral`
- `quarticDoubledTT_actionGaussian_integral`
- `quarticDoubledTT_actionGaussian_mul_projectiveBoundary`
- `quarticDoubledTT_actionGaussian_boundary_ne_target`
- `doubledTTMode_gaussian_relative_response`
- `doubledTTMode_actionGaussian_relative_response`
- `projectiveBoundaryVolume_eq_pi_sq`
- `gravitationalCoupling_eq_electromagnetic_link`
