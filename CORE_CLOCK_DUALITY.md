# One crossed-product action carries both the quartic clock and its weight

## The new identification inside the observer algebra

The continuous-core calculation and the gravitational clock calculation use
the same number `log Q`, but until now they appeared as parallel observations.
Crossed-product duality shows that they are directly connected.

Let `lambda_t` be the unitary in the modular crossed product that implements
observer or modular time `t`. With the convention used here, the dual action
obeys

\[
\theta_s(\lambda_t)=e^{-ist}\lambda_t.
\]

The canonical core trace obeys

\[
\operatorname{Tr}(\theta_s(X))
=e^{-s}\operatorname{Tr}(X).
\]

Now choose the single dual displacement

\[
s_Q=\log Q.
\]

The same automorphism then has two exact faces:

\[
\boxed{
\theta_{\log Q}(\lambda_t)
=e^{-it\log Q}\lambda_t
=Q^{-it}\lambda_t,}
\]

and

\[
\boxed{
\operatorname{Tr}(\theta_{\log Q}(X))
=Q^{-1}\operatorname{Tr}(X).}
\]

The first is the quartic modular unit-circle phase. The second is the quartic
retained trace weight. They arise from one dual action, rather than from two
unrelated uses of `Q`.

## The complete scalar chain

On a positive finite-trace ray, define the relative loss of the dual step by

\[
D_Q=I-\theta_{\log Q}.
\]

Its scalar response is

\[
D_Q=1-Q^{-1}=\lambda_4.
\]

Taking the quartic self-defect and its complement gives

\[
I-D_Q^2
=I-(I-\theta_{\log Q})^2
=2\theta_{\log Q}-\theta_{2\log Q},
\]

whose trace-ray eigenvalue is

\[
\boxed{
\frac{2}{Q}-\frac{1}{Q^2}
=1-\left(1-\frac1Q\right)^2
=S_Q.}
\]

The result can therefore be written as one line:

\[
\boxed{
\text{dual displacement }\log Q
\quad\Longrightarrow\quad
\begin{cases}
\text{clock character }Q^{-it},\\
\text{trace weight }Q^{-1},\\
\text{defect }\lambda_4,\\
\text{self-defect survivor }S_Q.
\end{cases}}
\]

This is the strongest exact link yet between the proposed PDT clock and the
gravity-screening coefficient. It does not use a numerical fit.

## Why this avoids the free-wedge obstruction

The ordinary free-field wedge has no nonzero bounded operator satisfying

\[
\sigma_t(B)=Q^{-it}B.
\]

That remains a valid obstruction. The present construction does not put such
an eigenoperator in the original wedge algebra. It uses the bounded
implementing unitaries `lambda_t` of the observer crossed product, on which the
**dual** action supplies the character `Q^(-it)`.

The clock therefore lives in the observer extension that also makes a trace
and gravitational entropy available. This agrees with the modern role of
crossed products: modular flow is gauged, an observer Hamiltonian is added,
and the resulting type-II algebra admits renormalized entropy.

## The two parameters must remain distinct

There are two conjugate real variables:

- `t` labels modular or observer-time translations `lambda_t`;
- `s` labels the dual trace-scaling action `theta_s`.

They pair through the character `exp(-ist)`. The statement `s_Q=log Q` fixes a
dual spectral displacement. It does not say that a physical tick lasts
`log Q` seconds, or that modular time itself equals `log Q`.

This distinction resolves a normalization ambiguity in the earlier core
discussion. The dimensionless phase is fixed; proper duration still comes
from the observer's acceleration or gravitational lapse.

## Gravitational time dilation

For a stationary near-horizon observer,

\[
t_x(\tau)=T(x)\tau
=\frac{\kappa_H}{2\pi N(x)}\tau.
\]

The locally read crossed-product phase is therefore

\[
\theta_{\log Q}(\lambda_{t_x(\tau)})
=\exp\!\left[-i\log Q\,
\frac{\kappa_H\tau}{2\pi N(x)}\right]
\lambda_{t_x(\tau)}.
\]

This is exactly the ordinary energy-time phase with

\[
E_Q(x)=\frac{\kappa_H}{2\pi N(x)}\log Q.
\]

For the same Killing-coordinate interval `dt`, the local proper interval is
`d tau=N dt`; hence `T(x)d tau` is independent of the lapse. Gravity changes
the local rate without changing the dual displacement, its trace weight, or
the accumulated phase assigned to the same geometric interval.

## What is established and what remains open

- **Standard operator-algebra input:** the crossed-product character relation,
  the dual trace-scaling law, and the presence of an observer Hamiltonian in
  gravitational crossed-product constructions.
- **Kernel-checked scalar result:** at `s=log Q`, the character, trace weight,
  defect, self-defect survivor, and lapse-reparametrized phase identities.
- **Open physical identification:** PDT's selected `log Q` displacement is the
  displacement of the physical gravitational observer algebra, and the
  trace-ray self-defect acts on the noncentral area or kinetic response rather
  than merely changing trace normalization.

The remaining gravity theorem is consequently narrower. One must show that
the physical constraint or Hodge kinetic operator couples to

\[
2\theta_{\log Q}-\theta_{2\log Q}
\]

with the same normalization used to define horizon area. Global trace
rescaling alone is already known to cancel from normalized entropy variation.

## Kernel artifact

`GravityScreening/CoreClockDuality.lean` proves:

- `coreDualCharacter_log_eq_quarticPhase`;
- `coreDualCharacter_norm` and `coreDualCharacter_add`;
- `quartic_core_clock_trace_pair`;
- `quartic_core_clock_defect_pair`;
- `quartic_core_clock_screening_pair`;
- `localQuarticModularPhase_eq_energyPhase`;
- `localModularParameter_unitDuration`;
- `localQuarticModularPhase_unitDuration`;
- `localModularParameter_properDuration`;
- `localQuarticModularPhase_properDuration`.

The Lean file formalizes the scalar consequences conditional on the standard
crossed-product action laws. It does not formalize von Neumann algebras or the
physical horizon construction itself.

## References

- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
- A. J. Speranza, *An intrinsic cosmological observer*,
  <https://arxiv.org/abs/2504.07630>.
- C. Rovelli and M. Smerlak, *Thermal time and the Tolman--Ehrenfest effect:
  temperature as the speed of time*, <https://arxiv.org/abs/1005.2985>.
