# From the pQ factor to a physical horizon: the modular-map audit

## Question

After proving that the joint cubic--quartic KMS factor has the same hyperfinite
type `III_1` as a generic relativistic local algebra, what still prevents the
quartic Perron response from being an actual horizon response?

There are three logically distinct requirements:

1. embed the pQ observables in a wedge algebra;
2. preserve the state, so the exact quartic response survives;
3. identify pQ modular time with geometric boost time.

The first two have an existence theorem. The third reduces to an explicit
Connes-cocycle neutrality condition on the quartic mode.

## 1. An exact state-preserving horizon embedding exists

Let

\[
N=\mathcal R_\rho\,\overline\otimes\,\mathcal R_Q,
\qquad
\phi=\phi_\rho\otimes\phi_Q,
\]

where the states are the unique graph gauge-KMS states. The preceding audit
proves that `N` is a hyperfinite type-`III_1` factor with separable predual.

Let `M_W=A(W)` be a type-III wedge algebra and let `omega_W` be its faithful
vacuum state. Corollary 3.4 of Kawahigashi--Ogata--Stormer applies directly:
for a von Neumann algebra with separable predual and a faithful normal state,
there is an injective homomorphism into any type-III factor with prescribed
normal state. Therefore there exists

\[
\pi:N\longrightarrow M_W
\quad\text{such that}\quad
\omega_W\circ\pi=\phi.
\]

For a degree-one quartic analytic element `A`, embedded as `1 tensor A`, state
preservation gives

\[
\begin{aligned}
\omega_W\!\left(\pi((1\otimes A)^*(1\otimes A))\right)
 &=\phi_Q(A^*A),\\
\omega_W\!\left(\pi((1\otimes A)(1\otimes A)^*)\right)
 &=\phi_Q(AA^*).
\end{aligned}
\]

Consequently the normalized ordered-commutator ratio in the wedge vacuum is
exactly

\[
\frac{\omega_W(\pi((1\otimes A)^*(1\otimes A)))
-\omega_W(\pi((1\otimes A)(1\otimes A)^*))}
{\omega_W(\pi((1\otimes A)^*(1\otimes A)))}
=1-\frac1Q=\lambda_4.
\]

This is a genuine existence result: a wedge-vacuum realization of the Perron
response is mathematically available. It does not say that the embedding is
canonical, compatible with a spacetime net, or covariant under boosts.

## 2. The complete modular flows are automatically related by a cocycle

When the physical wedge factor `M_W` is hyperfinite type `III_1`, both `N` and
`M_W` are copies of the unique hyperfinite factor of that type. There therefore
exists an onto factor isomorphism

\[
\theta:N\longrightarrow M_W.
\]

Transport the pQ state to the wedge factor:

\[
\widehat\phi=\phi\circ\theta^{-1}.
\]

The Connes cocycle Radon--Nikodym theorem gives a unique strongly continuous
unitary cocycle

\[
u_t=(D\omega_W:D\widehat\phi)_t\in M_W
\]

such that

\[
\boxed{
\sigma_t^{\omega_W}
=\operatorname{Ad}(u_t)\circ
\theta\circ\sigma_t^\phi\circ\theta^{-1}.}
\]

Thus algebra type plus Connes' theorem already transports the pQ modular flow
to the physical vacuum flow **up to an inner cocycle**. The missing dynamics is
not an arbitrary new outer time evolution. It is entirely localized in the
unitaries `u_t` inside the horizon algebra.

The state-preserving embedding in Section 1 and the onto cocycle-equivalent
isomorphism in this section need not be the same map. Existing theorems do not
automatically supply a single map that is simultaneously state-preserving,
onto, net-compatible, and boost-covariant.

## 3. Full covariance is an expected-subfactor problem

There is a second, equivalent formulation of the full modular-intertwining
target. Suppose the state-preserving injection `pi` has a range globally
invariant under the wedge modular group. Takesaki's theorem then supplies a
normal conditional expectation

\[
E:M_W\longrightarrow\pi(N),
\qquad \omega_W\circ E=\omega_W.
\]

Conversely, the existence of such a vacuum-preserving conditional expectation
implies global modular invariance of `pi(N)`. Since the restricted state is the
pQ state, modular uniqueness then gives

\[
\sigma_t^{\omega_W}(\pi(x))
=\pi(\sigma_t^\phi(x)).
\]

Thus a state-preserving **expected** embedding solves the full modular part of
the horizon map. The embedding theorem in Section 1 supplies state preservation
but does not supply this conditional expectation. The remaining strengthening
is exact and falsifiable.

## 4. The exact coefficient-preservation test

Let

\[
B=\theta(1\otimes A)
\]

be the transported quartic mode. Under the pQ modular flow it has modular
frequency of magnitude `log Q`. Under the wedge vacuum flow,

\[
\sigma_t^{\omega_W}(B)
=u_t\,\sigma_t^{\widehat\phi}(B)\,u_t^*.
\]

There are three cases.

### Neutral cocycle

If

\[
u_tBu_t^*=B
\qquad\text{for every }t,
\]

then the quartic modular frequency and its KMS response are unchanged. The
horizon coefficient remains exactly `lambda4`.

### Scalar frequency shift

If the cocycle preserves the quartic line but supplies a phase

\[
u_tBu_t^*=e^{it\delta}B,
\]

then the modular frequency shifts from `log Q` to `log Q+delta`, and the
response becomes

\[
1-e^{-(\log Q+\delta)}.
\]

The theorem `quartic_response_shift_eq_iff` proves in Lean that, for `Q>0`,

\[
1-e^{-(\log Q+\delta)}=\lambda_4
\quad\Longleftrightarrow\quad
\delta=0.
\]

Thus there is no freedom to hide a modular-frequency renormalization while
retaining the proposed coefficient.

### Mode mixing

If `Ad(u_t)` does not preserve the one-dimensional quartic spectral subspace,
the transported mode no longer has a single detailed-balance factor. The
one-number screening mechanism then fails in its present form and must be
replaced by a matrix-valued response.

## 5. The remaining physical theorem is now one condition

At the level of one quartic mode, the required bridge is

\[
\boxed{\operatorname{Ad}(u_t)(B)=B.}
\]

Infinitesimally, whenever the cocycle has a differentiable generator
`K_rel`, this becomes

\[
[K_{\rm rel},B]=0.
\]

Here `K_rel` is the relative modular Hamiltonian comparing the transported pQ
state with the physical wedge vacuum. This is the calculation the underlying
field theory must now perform. A nonzero eigen-commutator shifts the coefficient;
general mixing destroys the scalar mechanism; a zero commutator preserves the
exact Perron residue.

The deposited two-scalar action does not define either state on the local
operator algebra and therefore does not yet determine `K_rel`. Its diagonal
tree-level quadratic sector is insufficient to calculate this test.

## 6. Why this is a gravity calculation

In algebraic quantum field theory, modular flow is the intrinsic dynamics of a
region-state pair. In current semiclassical gravity constructions, gauging or
marginalizing modular flow produces a crossed-product gravitational algebra and
an observer degree of freedom. Connes cocycles describe how that construction
changes when the reference state changes.

This makes the relative modular cocycle the natural location for PDT's missing
information-to-geometry map. It does not prove that the cocycle is trivial on
the Q mode. It turns that claim into a definite operator equation rather than a
verbal identification.

## Verdict

The earlier statement that a state-preserving horizon embedding was wholly
missing was too pessimistic. Such an embedding exists by a published theorem,
and it preserves the exact `lambda4` ordered-commutator ratio. Full modular
dynamics can also be transported, uniquely up to a Connes cocycle.

The surviving gap is the intersection of those results: show that the physical
cocycle is neutral on the quartic Perron mode, or calculate its nonzero shift.
That is a single falsifiable dynamical condition.

## References

- Kawahigashi, Ogata, and Stormer, *Normal states of type III factors* (2014),
  especially Corollaries 3.4 and 3.5:
  <https://arxiv.org/abs/1301.5737>.
- Connes' cocycle derivative theorem; see Takesaki, *Theory of Operator
  Algebras II*, Chapter VIII, Section 3.
- Takesaki, *Conditional expectations in von Neumann algebras* (1972), for the
  expected-subfactor criterion:
  <https://doi.org/10.1016/0022-1236(72)90004-3>.
- Brunetti, Guido, and Longo, *Modular Structure and Duality in Conformal
  Quantum Field Theory* (1993): <https://arxiv.org/abs/funct-an/9302008>.
- Speranza, *An intrinsic cosmological observer* (2025), for modular flow,
  crossed products, and observer degrees of freedom in semiclassical gravity:
  <https://arxiv.org/abs/2504.07630>.
