# The quartic modular line as a gravitationally redshifted Rindler clock

## Exact conditional result

The standard Rindler normalization turns the quartic modular eigenvalue into a
local energy-temperature relation. Let `Delta` be the modular operator and
suppose the distinguished quartic vector satisfies

\[
\Delta\xi_Q=Q^{-1}\xi_Q.
\]

Writing the modular Hamiltonian as `K_mod=-log Delta` gives

\[
K_{\rm mod}\xi_Q=(\log Q)\xi_Q.
\]

For the vacuum Rindler wedge, the Bisognano--Wichmann relation identifies the
modular Hamiltonian with `2*pi` times the boost generator. The dimensionless
boost energy of this line is therefore

\[
E_{\rm boost,Q}=\frac{\log Q}{2\pi}.
\]

A uniformly accelerated observer with proper acceleration `a` has boost
rapidity `eta=a tau`, so the energy measured per unit proper time is

\[
\boxed{
E_Q(a)=\frac{a}{2\pi}\log Q.}
\]

The same observer sees the Unruh temperature

\[
T_U(a)=\frac{a}{2\pi}
\]

in natural units. Consequently

\[
\boxed{
\frac{E_Q(a)}{T_U(a)}=\log Q,
\qquad
e^{-E_Q(a)/T_U(a)}=\frac1Q.}
\]

Acceleration and gravitational redshift change the local energy and local
temperature together. Their dimensionless ratio remains the arithmetic
constant `log Q`.

## The screening chain in thermal language

The inverse-step factor in the gravity mechanism is now exactly the Rindler
Boltzmann weight of the modular line:

\[
w_Q=e^{-E_Q/T_U}=\frac1Q.
\]

Its response defect is

\[
1-w_Q=1-\frac1Q=\lambda_4.
\]

The canonical norm-preserving two-channel completion then gives

\[
1-(1-w_Q)^2
=1-\lambda_4^2
=S_Q
=\frac{2Q-1}{Q^2}.
\]

Thus the complete scalar sequence is

\[
\boxed{
\Delta_Q=Q^{-1}
\longleftrightarrow
E_Q/T_U=\log Q
\longrightarrow
\lambda_4=1-e^{-E_Q/T_U}
\longrightarrow
S_Q=1-\lambda_4^2.}
\]

This does not obtain `S_Q` from a new numerical match. It gives a standard
gravitational interpretation to the modular eigenvalue already derived from
the quartic graph KMS state.

## What one modular unit means to an accelerated observer

With modular-flow convention

\[
\Delta^{is}=e^{-2\pi i s B},
\]

one unit of the dimensionless modular parameter corresponds to boost rapidity
`2*pi`. The proper duration along an orbit of acceleration `a` is therefore

\[
\Delta\tau_{s=1}=\frac{2\pi}{a}=\frac1{T_U}.
\]

The accumulated clock phase is invariant:

\[
E_Q(a)\,\Delta\tau_{s=1}=\log Q.
\]

This supplies a precise form of gravitational time dilation for the modular
clock. Observers at different accelerations assign different proper durations
and energies to one modular unit, while agreeing on its dimensionless phase
and KMS weight.

Numerically,

\[
\log Q=0.1994605782430053\ldots,
\qquad
\frac{\log Q}{2\pi}=0.0317451369793421\ldots.
\]

## The necessary two-clock caveat

This result concerns the modular phase

\[
Q^{-is}=e^{-is\log Q}.
\]

It does not concern the different projective phase obtained from a nonreal
quartic conjugate,

\[
e^{in\theta_Q},
\qquad
\theta_Q=\arg\sigma_Q.
\]

Both are unit-circle motions supplied by the quartic polynomial, but their
frequencies are not equal and cannot be related by an algebraic constant. The
proof and its consequences are given in
[`TWO_Q_CLOCKS_AUDIT.md`](TWO_Q_CLOCKS_AUDIT.md).

This distinction matters physically. The Rindler calculation gives the
proper-time reading of the Perron/KMS modular clock. A separate intertwiner is
needed if the complex-conjugate projective clock is also to become geometric
proper time.

## Status and falsifier

- **Exact mathematics:** the scalar chain from `E/T=log Q` to `1/Q`,
  `lambda4`, and `S_Q` is kernel-checked.
- **Standard physics input:** wedge-vacuum modular flow is boost flow with the
  Rindler `2*pi` normalization, and the accelerated observer has Unruh
  temperature `a/(2*pi)`.
- **Open physical identification:** the embedded PDT degree-one modular vector
  is the physical Rindler mode whose boost energy is being measured.

The interpretation fails if no net-compatible, boost-covariant embedding of
the quartic modular line exists, or if the required Connes cocycle shifts or
mixes that line. The exact scalar theorem would remain true as mathematics but
would not describe a gravitational clock.

## Kernel artifact

`GravityScreening/RindlerClock.lean` proves:

- `rindlerClockEnergy_div_temperature`;
- `rindlerClock_thermalWeight_eq_inv`;
- `rindlerClock_thermalDefect_eq_lambda4`;
- `rindlerClock_screening_chain`;
- `rindlerClockEnergy_mul_modularUnitDuration`.

The declarations contain no `sorry`; their axiom audit reports only Mathlib's
standard classical foundations.

## References

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- J. Koeller, S. Leichenauer, A. Levine, and A. Shahbazi Moghaddam, *Local
  Modular Hamiltonians from the Quantum Null Energy Condition*,
  <https://arxiv.org/abs/1702.00412>.
- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
