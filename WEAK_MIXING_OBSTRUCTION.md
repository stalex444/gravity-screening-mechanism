# Weak mixing versus an exact bounded Q-clock

## Result

There is a clean conditional no-go for the strongest version of the horizon
embedding. Use the explicit **absolute-Cesàro weak-mixing condition**

\[
\lim_{T\to\infty}\frac1T\int_0^T
\left|\phi(A\alpha_t(B))-\phi(A)\phi(B)\right|dt=0
\]

for all bounded `A,B`. Then:

> A faithful weakly mixing state cannot have a nonzero bounded modular
> eigenoperator at a nonzero frequency.

Therefore, if the physical wedge vacuum satisfies this spectral mixing
condition under its boost flow, the quartic degree-one graph operator cannot be
embedded covariantly as a bounded wedge observable with exact frequency
`log Q`.

This does not disprove the Perron/KMS coefficient. It distinguishes three
possible homes for it:

1. a non-mixing invariant sector of the wedge algebra;
2. a generalized or distributional boost-frequency mode rather than a bounded
   eigenoperator;
3. an enlarged observer or crossed-product algebra in which the clock degree
   of freedom is added explicitly.

## 1. The elementary proof

Let `(M,phi,alpha_t)` be a von Neumann dynamical system. Assume `phi` is
faithful, invariant, and satisfies the absolute-Cesàro condition above.
Suppose a bounded operator `B` obeys

\[
\alpha_t(B)=e^{it\nu}B
\]

for a nonzero real frequency `nu`.

State invariance gives

\[
\phi(B)=\phi(\alpha_t(B))=e^{it\nu}\phi(B),
\]

so `phi(B)=0`. Now take the two-point function with `B*`:

\[
\phi(B^*\alpha_t(B))
=e^{it\nu}\phi(B^*B).
\]

Its absolute value is the positive constant `phi(B*B)`. The assumed condition
requires its long-time Cesàro mean to vanish. Because `phi(B)=0`, that mean is
exactly `phi(B*B)`. Hence

\[
\phi(B^*B)=0.
\]

Faithfulness implies `B=0`, contradicting the assumption of a nonzero
eigenoperator.

The obstruction uses no perturbation theory and no special property of Q. It
applies to every exact nonzero-frequency bounded eigenoperator.

## 2. Consequence for the proposed pQ inclusion

The quartic graph KMS algebra contains nonzero degree-one operators with exact
modular phase of magnitude `log Q`. A modular-covariant embedding into a wedge
would carry such an operator to a nonzero element `B` satisfying, up to the
fixed sign convention,

\[
\sigma_t^{\omega_W}(B)=Q^{-it}B.
\]

If `omega_W` satisfies the absolute-Cesàro condition for this modular/boost
action, the theorem above forces `B=0`. An injective covariant map is then
impossible.

Equivalently, a spectrally mixing wedge in this explicit sense cannot contain
the pQ graph state as an exact modularly invariant bounded-observable
subsystem. This is stronger than the statement that a convenient embedding has
not yet been found.

## 3. The mixing terminology must not be blurred

Bisognano--Wichmann identifies wedge modular evolution with Lorentz boosts in
the covered relativistic QFTs. That theorem alone does not assert the absolute-
Cesàro mixing condition. It must be proved or assumed for the state and flow in
question.

Borchers and Buchholz use the phrase “weakly mixing” for the condition

\[
\frac1T\int_0^T
\bigl(\phi(A\alpha_t(B))-\phi(A)\phi(B)\bigr)dt\longrightarrow0,
\]

without an absolute value in the displayed formula. That condition is too weak
for the no-go above: a pure phase `exp(i*t*nu)` with nonzero `nu` has zero
ordinary Cesàro mean. Their de Sitter result therefore does **not** establish
the needed absence of nonzero modular eigenoperators.

No theorem establishing the absolute-Cesàro condition for the precise
Minkowski-wedge model needed here was verified in this audit. The correct next
step is model specific: calculate its modular point spectrum directly or prove
the stronger mixing condition.

## 4. Why a continuous boost frequency is insufficient

Rindler mode expansions use a continuum of boost frequencies. Merely choosing
the value

\[
\nu_Q=\log Q
\quad\text{or}\quad
\omega_Q^{\rm boost}=\frac{\log Q}{2\pi}
\]

from a continuum does not derive or select Q. Such modes are typically
generalized spectral modes and need not be bounded elements of the local von
Neumann algebra.

The nontrivial PDT claim requires the graph grading, KMS state, and pQ
composition law to survive the physical map. A numerical point lying in a
continuous spectrum is too weak.

## 5. The crossed-product escape is structurally motivated

Current semiclassical-gravity constructions enlarge a type-III local algebra
by gauging or marginalizing modular flow and adding an observer degree of
freedom. Speranza describes such gravitational algebras as crossed products
and emphasizes the role of the observer clock.

This supplies a mathematically natural alternative target:

- keep the physical wedge algebra and its boost flow;
- place the discrete pQ clock in the observer or crossed-product extension;
- require the combined algebra to reproduce the quartic KMS ratio and the
  defect complement;
- derive the gravitational response after the modular constraint or
  coarse-graining is imposed.

This route avoids demanding an exact bounded boost eigenoperator in a mixing
local algebra. It remains a proposal until a specific crossed product and its
state are constructed.

## 6. Decision tree

For a specified candidate wedge theory:

1. **A nonzero `Q^{-1}` modular eigenspace exists.** Continue the expected-
   subfactor construction inside the wedge.
2. **The absolute-Cesàro condition holds.** Stop the bounded-subfactor route;
   test a crossed-product observer clock or generalized spectral formulation.
3. **Neither is known.** Compute the modular point spectrum before doing more
   potential algebra.

## Verdict

The reverse audit has uncovered a real structural fork. Exact pQ modular
covariance inside the bare local wedge requires a discrete modular spectral
sector. If the physical vacuum satisfies the explicit spectral-mixing
condition above, the correct home of the quartic clock is likely an enlarged
observer algebra rather than the bounded local observables themselves.

The word “likely” here marks the physical choice. The obstruction under the
stated absolute-Cesàro hypothesis is an exact mathematical implication.

## References

- Brunetti, Guido, and Longo, *Modular Structure and Duality in Conformal
  Quantum Field Theory*:
  <https://arxiv.org/abs/funct-an/9302008>.
- Borchers and Buchholz, *Global Properties of Vacuum States in de Sitter
  Space*:
  <https://arxiv.org/abs/gr-qc/9803036>.
- Speranza, *An intrinsic cosmological observer*:
  <https://arxiv.org/abs/2504.07630>.
