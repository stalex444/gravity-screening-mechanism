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
| Common 15-channel vertex | `pi^2 * (rho Q)^(-15) = alpha_EM` as defined in the deposited formula | Exact conditional rewrite |
| Projective boundary | `Vol(S^3)/2 = pi^2` in the Pauli-fixed unit metric | Lean theorem; physical use is a correspondence |
| Gravity factorization | `alpha_G = alpha_EM * pi^2 / ((rho Q)^209 S_Q)` | Lean theorem from the deposited definitions |
| Combined exponent | `15 + 209 = 224` | Lean theorem |
| Combined numerator | `pi^2_bulk * pi^2_boundary = pi^4` | Exact consequence |

The mathematical result is a coherent bulk-boundary split. The `pi^2` already
present in the electromagnetic expression can be read as a four-dimensional
Gaussian mode-space volume. Gravity then acquires one additional `pi^2` when
the bulk response is paired with the projective conformal boundary. This is
more informative than naming `pi^4` as a square: it assigns the two equal
factors to different parts of the mechanism.

## The decisive normalization fork

The raw Lebesgue Gaussian trace is

```text
integral d^4k exp(-||k||^2) = pi^2.
```

The frequently used QFT Fourier convention gives

```text
integral d^4k/(2*pi)^4 exp(-||k||^2) = 1/(16*pi^2).
```

Lean proves both statements. Therefore dimensionality alone does not choose
the physical coefficient. A derivation from the action must specify the
Fourier transform, the field normalization, the Gaussian or cutoff scale, and
the boundary measure. Any compensating factor must arise from those choices;
it cannot be inserted after the calculation.

## The remaining mechanism test

Starting from the two-scalar action or an explicit spectral trace, derive the
quadratic operator for the relevant mixed mode and reduce its zero-momentum
response to a radial four-dimensional integral. Then read off:

1. the momentum measure;
2. the radial profile and its scale;
3. the multiplicity or trace factor;
4. the real-mode `k ~ -k` treatment;
5. the projective boundary normalization.

If their product gives the raw Gaussian bulk coefficient and the Pauli-fixed
projective boundary coefficient, the `pi^4` numerator is derived. If the
Fourier-normalized coefficient survives without exact compensation, this
route is ruled out. That makes the next step a finite normalization audit,
rather than another search for a formula.

## Kernel declarations

- `fourMode_radial_integral`
- `gaussian_radial_moment_three`
- `fourMode_gaussian_integral`
- `fourierNormalized_fourMode_gaussian_integral`
- `gaussianModeVertexIntegral_eq_pi_sq_mul`
- `conformalChannelVertex_gaussianMode_eq_electromagneticCoupling`
- `gravitationalCoupling_eq_gaussianMode_boundary_link`
- `projectiveBoundaryVolume_eq_pi_sq`
- `gravitationalCoupling_eq_electromagnetic_link`
