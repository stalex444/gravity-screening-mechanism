# The quartic thermal clock under gravitational time dilation

## The result

The Rindler calculation can be promoted from one accelerated observer to a
stationary family of observers at different gravitational lapses.

Let `N(x)` be the norm of the stationary Killing field and let `kappa_H` be
its surface-gravity scale. In the local near-horizon model, the observer at
`x` has acceleration and temperature

\[
a(x)=\frac{\kappa_H}{N(x)},
\qquad
T(x)=\frac{\kappa_H}{2\pi N(x)}.
\]

For the quartic modular line, the corresponding local energy is

\[
E_Q(x)=\frac{\kappa_H}{2\pi N(x)}\log Q.
\]

Temperature and energy therefore undergo the same gravitational redshift:

\[
\boxed{
N(x)T(x)=\frac{\kappa_H}{2\pi},
\qquad
N(x)E_Q(x)=\frac{\kappa_H}{2\pi}\log Q.}
\]

Their ratio is independent of the observer:

\[
\boxed{
\frac{E_Q(x)}{T(x)}=\log Q,
\qquad
e^{-E_Q(x)/T(x)}=\frac1Q.}
\]

It follows that the complete quartic response survives gravitational time
dilation unchanged:

\[
1-e^{-E_Q/T}=1-\frac1Q=\lambda_4,
\qquad
1-\lambda_4^2=S_Q.
\]

## What happens to one tick

One modular unit takes the local proper duration

\[
\boxed{
\Delta\tau_Q(x)=\frac{2\pi N(x)}{\kappa_H}.}
\]

An observer deeper in the gravitational potential has a smaller lapse and
assigns a shorter proper duration to the thermal modular unit. The local
energy rises by the reciprocal factor. Their product stays fixed:

\[
E_Q(x)\,\Delta\tau_Q(x)=\log Q.
\]

Writing the same interval in stationary Killing time removes the lapse:

\[
\Delta t_Q
=\frac{\Delta\tau_Q(x)}{N(x)}
=\frac{2\pi}{\kappa_H}.
\]

This is the precise sense in which gravitational time dilation can act on the
quartic clock. Gravity changes the local rate at which proper time traverses
the modular orbit. It does not alter the arithmetic phase, the KMS weight, or
the screening coefficient.

This is a statement about the thermal/modular clock of the horizon state. It
does not yet assert that an atomic clock, decay clock, or other material clock
is the same PDT degree of freedom. Establishing that wider clock equivalence
would require the physical embedding and coupling to matter.

## Why this is more than a generic redshift identity

Rovelli and Smerlak describe the Tolman--Ehrenfest effect as temperature being
the local rate of thermal time relative to proper time. PDT supplies a
distinguished candidate spectral gap for that thermal flow: `log Q`. Combining
the two statements gives the observer-independent chain

\[
\text{quartic modular gap }\log Q
\longleftrightarrow
\frac{E_Q(x)}{T(x)}
\longleftrightarrow
Q^{-1}
\longrightarrow
\lambda_4
\longrightarrow
S_Q.
\]

The first equality is conditional on the physical horizon embedding. Every
subsequent scalar implication is exact.

## Relation to the two quartic clocks

This gravitational law applies directly to the Perron/KMS modular phase
`Q^(-is)`. It does not by itself turn the separate conjugate-root phase
`exp(i n theta_Q)` into geometric time. Their frequency ratio is
transcendental, as shown in [`TWO_Q_CLOCKS_AUDIT.md`](TWO_Q_CLOCKS_AUDIT.md).

There is, however, a clean compatible picture. The projective phase may carry
coherent internal ordering, while the modular phase supplies the thermal clock
that gravity redshifts. The portal can couple their records without serving as
an impossible fixed algebraic conversion between their rates.

## Status and falsifier

- **Kernel-checked here:** every displayed redshift, duration, thermal-weight,
  defect, and screening identity in the scalar model.
- **Standard physics input:** the Tolman law for equilibrium in a stationary
  spacetime and the local Rindler/Unruh normalization.
- **Open physical identification:** the embedded quartic KMS line is the
  geometric thermal-time mode of the physical horizon state.

The identification fails if the physical Connes cocycle shifts or mixes the
quartic line, or if no net-compatible geometric modular embedding exists. It
would also fail outside the equilibrium/stationary setting without a suitable
local generalization of the lapse relation.

## Kernel artifact

`GravityScreening/KillingRedshift.lean` proves:

- `localHorizonTemperature_mul_lapse`;
- `localQuarticClockEnergy_mul_lapse`;
- `localQuarticClockEnergy_div_temperature`;
- `localQuarticClock_thermalWeight_eq_inv`;
- `localQuarticClock_thermalDefect_eq_lambda4`;
- `localQuarticClock_screening_chain`;
- `localModularUnitDuration_eq_lapse_mul`;
- `localModularUnit_coordinateDuration`;
- `localQuarticClockEnergy_mul_duration`.

The declarations contain no `sorry`; their axiom audit reports only Mathlib's
standard classical foundations.

## References

- C. Rovelli and M. Smerlak, *Thermal time and the Tolman--Ehrenfest effect:
  temperature as the speed of time*, <https://arxiv.org/abs/1005.2985>.
- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- A. Connes and C. Rovelli, *Von Neumann Algebra Automorphisms and
  Time-Thermodynamics Relation in General Covariant Quantum Theories*,
  <https://arxiv.org/abs/gr-qc/9406019>.
