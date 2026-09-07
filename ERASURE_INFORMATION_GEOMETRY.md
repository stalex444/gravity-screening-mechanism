# Quartic erasure as information geometry and an arrow of time

## Result

Accept the quartic modular-erasure postulate:

> The information inaccessible across a local causal horizon is the defect of
> the canonical degree-one modular step of the quartic PDT graph system.

The previous calculation then fixes the exterior channel to

\[
\mathcal E_Q(\rho)
=S_Q\rho\oplus(1-S_Q)|e\rangle\!\langle e|,
\qquad
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

This channel has a strong and exact information-geometric property:

\[
\boxed{
D(\mathcal E_Q(\rho)\|\mathcal E_Q(\sigma))
=S_QD(\rho\|\sigma).}
\]

Every relative-entropy distinguishability seen by the exterior observer is
multiplied by the same factor that multiplies PDT's Jacobson entropy-area
density.  Taking the Hessian gives the corresponding local information metric,
the Bogoliubov--Kubo--Mori metric,

\[
\boxed{
g^{\rm BKM}_{\mathcal E_Q(\rho)}
(\mathcal E_{Q*}X,\mathcal E_{Q*}Y)
=S_Qg^{\rm BKM}_{\rho}(X,Y).}
\]

Thus the gravity factor has a clean information-geometric meaning: it is the
exact contraction of locally recoverable statistical distinguishability under
the quartic causal erasure step.

## Exact quantum derivation

Let `0 < s < 1` and define the fixed-erasure channel

\[
\mathcal E_s(\rho)=s\rho\oplus(1-s)|e\rangle\!\langle e|.
\]

For faithful states `rho` and `sigma`, block functional calculus gives

\[
\log(s\rho)=\log s\,I+\log\rho
\]

on the retained block.  Therefore

\[
\begin{aligned}
D(\mathcal E_s(\rho)\|\mathcal E_s(\sigma))
&=\operatorname{Tr}s\rho
  [\log(s\rho)-\log(s\sigma)]\\
&\quad +(1-s)[\log(1-s)-\log(1-s)]\\
&=s\operatorname{Tr}\rho(\log\rho-\log\sigma)\\
&=sD(\rho\|\sigma).
\end{aligned}
\]

The binary uncertainty of the erasure flag makes no contribution because its
weight is the same for both inputs.  This is equality, stronger than the usual
data-processing inequality.

The BKM metric is the second variation of quantum relative entropy.  Since the
entire relative-entropy function is multiplied by `s`, every one of its
second derivatives is multiplied by `s`.  In a commuting diagonal family this
reduces to ordinary Fisher information:

\[
I(p;\dot p)=\sum_i\frac{\dot p_i^2}{p_i}.
\]

Under the erasure channel the retained probabilities and tangent vector become
`sp_i` and `s dot p_i`, while the fixed erasure flag has zero tangent.  Hence

\[
I(\mathcal E_s(p);\mathcal E_{s*}\dot p)
=\sum_i\frac{(s\dot p_i)^2}{sp_i}
=sI(p;\dot p).
\]

`GravityScreening/ErasureInformation.lean` kernel-checks both the diagonal
relative-entropy identity and the Fisher-metric identity, and specializes them
to `s=S_Q=(2Q-1)/Q^2`.

## Why this strengthens the gravity identification

The earlier entropy calculation showed that the channel multiplies entropy
differences by `S_Q`.  Relative entropy is more discriminating.  It measures
how well an observer can tell two states apart, and its Hessian is the local
geometry of the state space.

The result therefore says that `S_Q` does not merely rescale an overall count.
It uniformly rescales the exterior observer's information geometry.  If
Jacobson's `eta` measures the amount of distinguishable microscopic state per
unit horizon area, then

\[
\eta_{\rm exterior}=S_Q\eta_0
\]

is exactly the information contraction of the horizon channel.  His relation
`G=(4 hbar eta)^(-1)` then gives

\[
G_{\rm exterior}=\frac{G_0}{S_Q}.
\]

This is a substantially tighter physical reading than global trace scaling.
A trace convention can disappear after normalization; relative entropy cannot
be changed by an additive normalization constant.  Here the factor survives
because a definite fraction of distinguishability is carried into an
orthogonal hidden branch.

## The induced arrow of time

Suppose the same causal erasure acts independently on the portion that remains
available after each quartic clock step.  The erasure state is absorbing.  Two
successive steps with retained weights `s` and `t` combine to one step with
retained weight `st`:

\[
\mathcal E_s\circ\mathcal E_t=\mathcal E_{st}.
\]

After `n` identical steps,

\[
D_n=S_Q^nD_0.
\]

Because `0<S_Q<1`, locally recoverable distinguishability decreases strictly
whenever the initial states differ.  Globally the Stinespring dilation is
unitary and no information is destroyed; the missing information accumulates
in the inaccessible environment.  The time asymmetry belongs to the causal
observer's nested accessible algebras.

This supplies a concrete synthesis of the PDT time and gravity ideas:

\[
\boxed{
\begin{array}{c}
\text{quartic modular step}\\
\Downarrow\\
\text{one-way exterior information contraction }S_Q\\
\swarrow\qquad\searrow\\
\text{arrow of time}\qquad\text{entropy density and gravity}
\end{array}}
\]

The Padovan chirality can select which ordering of histories is called
forward.  The quartic erasure supplies the monotone along that ordering.  These
are logically distinct jobs: chirality orients the sequence, while causal
restriction makes accessible information decrease along it.

Numerically,

\[
S_Q\approx0.9673014201,
\qquad
-\log S_Q\approx0.0332451257
\]

per dimensionless quartic erasure step.  Four repetitions retain

\[
S_Q^4\approx0.8754821614
\]

of the initial distinguishability.  This does **not** reproduce a separate
claim that a process settles in four ticks; it shows that the present erasure
mechanism and any four-tick convergence mechanism would have to be different
parts of the dynamics unless another operation is supplied.

## Physical claim and tests

The resulting physical proposal is:

> Local causal evolution in the quartic sector is a norm-preserving global
> dynamics whose restriction to an observer contracts relative entropy and
> the BKM information metric by `S_Q` per elementary horizon step.  The same
> contraction fixes the quartic factor in the gravitational entropy density.

It has clear ways to fail:

1. a microscopic PDT horizon construction gives a retained weight other than
   `S_Q`;
2. the hidden branch is recoverable within the same local observer algebra, so
   distinguishability does not contract;
3. the gravitational area density couples to normalized conditional states in
   a way that cancels the factor;
4. the physical clock step is reversible on every observer algebra, leaving no
   nested loss of access.

It also gives a sharper target for new calculations: seek observables whose
response is governed by local relative entropy or quantum Fisher information,
rather than fitting another constant.  The proposed universal prediction is
the ratio `S_Q` between the pre-horizon and exterior information metrics on the
quartic mode.

## Kernel artifact

`GravityScreening/ErasureInformation.lean` proves the finite diagonal forms:

- `erasureRelativeEntropy_eq`;
- `erasureFisher_eq`;
- `quarticErasureRelativeEntropy_eq`;
- `quarticErasureFisher_eq`.

The file also checks the multiplicative law underlying repeated retention.

## References

- D. Petz, *Monotonicity of quantum relative entropy revisited*,
  <https://arxiv.org/abs/quant-ph/0209053>.
- C. H. Bennett, D. P. DiVincenzo, and J. A. Smolin, *Capacities of Quantum
  Erasure Channels*, <https://arxiv.org/abs/quant-ph/9701015>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*,
  <https://arxiv.org/abs/1505.04753>.
