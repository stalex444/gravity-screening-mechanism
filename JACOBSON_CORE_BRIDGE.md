# The Jacobson bridge: exact conditional algebra and a normalization obstruction

## Corrected result

Let

```text
lambda4 = 1-1/Q,
S_Q = 1-lambda4^2 = (2Q-1)/Q^2.
```

The deposited gravity formulas have the exact common pattern

```text
eta_Q       = S_Q eta_0,
G_Q         = G_0/S_Q,
M_P,Q^2     = S_Q M_P,0^2,
M_P,Q       = sqrt(S_Q) M_P,0.
```

Once the first line is assumed, Jacobson's relation `G=1/(4 eta)` forces the
other three. That scalar implication is exact and is kernel-checked in
`GravityScreening/Basic.lean`.

The continuous-core calculation does **not** derive the first line merely by
rescaling its trace. A normalized-state audit reveals an exact obstruction:
an overall trace rescaling changes entropy only by an additive constant. It
does not multiply entropy differences or their first variations. The former
claim that the core trace response itself supplies Jacobson's density scaling
was therefore too strong.

## 1. What the continuous core really supplies

For the continuous core `C(M)=M crossed_product R`, let `tau` be the canonical
semifinite trace and `theta_s` the dual action. The standard scaling law is

```text
tau after theta_s = exp(-s) tau.
```

At `s=log Q`, the operation on the trace ray has eigenvalue `1/Q`. Its defect
has eigenvalue `lambda4`, and the complement of its repeated defect has
eigenvalue

```text
I-(I-T_Q)^2 = 2T_Q-T_Q^2,
2/Q-1/Q^2 = 1-lambda4^2 = S_Q.
```

This is an exact realization of the PDT polynomial on a standard
operator-algebraic object. It establishes arithmetic compatibility. It does
not by itself establish a change in physical entropy density.

## 2. Why global trace normalization cancels

Let a normalized state have density `h` relative to `tau`, so

```text
tau(h)=1.
```

Rescale the trace by a positive constant `c`:

```text
tau_c = c tau.
```

The same state is then represented by

```text
h_c = h/c,
```

because `tau_c(h_c)=1`. Its entropy is

```text
S_(tau_c)(h_c)
  = -tau_c(h_c log h_c)
  = -c tau[(h/c)(log h-log c)]
  = S_tau(h)+log c.
```

Thus the trace normalization supplies only an additive constant. For two
states,

```text
[S_tau(h_1)+log c]-[S_tau(h_2)+log c]
  = S_tau(h_1)-S_tau(h_2).
```

The same cancellation holds in the first variation. If `delta h` preserves
normalization, `tau(delta h)=0`, adding a scalar to the modular Hamiltonian
does not change

```text
delta S = tau(delta h K).
```

The Lean theorems `entropyContribution_trace_rescale`,
`entropyDifference_trace_rescale`, and `firstLaw_add_constant` check the
finite algebraic core of this statement.

## 3. What a genuine screening operation must do

To obtain

```text
delta S_Q = S_Q delta S_0
```

for every relevant normalization-preserving perturbation, the nonconstant
part of the modular generator must scale. In a finite diagonal model the
sufficient form is

```text
K_Q = S_Q K_0 + c I.
```

Then

```text
Tr(delta h K_Q) = S_Q Tr(delta h K_0)
```

because `Tr(delta h)=0`. The theorem `firstLaw_affine_scale` kernel-checks
this implication.

By contrast, global trace rescaling gives only

```text
K -> K + log(c) I,
```

which is invisible to the first law. This gives a clean falsifier:

> Any proposed mechanism in which all Q-dependence is an overall
> normalization of the Type-II trace cannot change Jacobson's Newton
> coupling.

## 4. Where the Q operation can still enter

The corrected calculation leaves three mathematically distinct routes:

1. **Area calibration.** The Q self-defect acts on the gravitational area
   operator or on the conversion between core dimension and physical area.
   Then the area term, rather than the state-entropy normalization, carries
   `S_Q`.
2. **Modular generator.** The observer clock changes the noncentral part of
   the modular Hamiltonian so that its first-law pairing is multiplied by
   `S_Q` on the physical perturbation space.
3. **Local cell structure.** The Q operation changes the number or weights of
   physical horizon cells. A global trace normalization is insufficient; the
   change must survive normalization within each physical area element.
4. **Chiral kinetic response.** On the standing F373 Hodge pair, the affine
   stiffness `I+lambda4 C` has an orientation-even inverse response
   `I/(1-lambda4^2)`. This places the reciprocal factor directly in the
   gravitational compliance rather than in entropy normalization.

The fourth route is presently the cleanest operator mechanism, with the first
route its area-density reading. Geometric wedge modular flow has a fixed boost
normalization, so multiplying the matter modular Hamiltonian by `S_Q` would
require an additional physical explanation. A chiral gravitational stiffness
or area-density calibration preserves the ordinary matter first law while
changing the coefficient that Jacobson identifies with `1/(4G)`. The filed
action does not yet derive the required affine Hodge term.

## 5. Exact conditional consequences retained

If an independent derivation establishes

```text
eta_Q = S_Q eta_0,
```

then the deposited formulas follow together:

```text
G_Q
  = 1/(4 eta_Q)
  = G_0/S_Q,

M_P,Q^2
  = 1/G_Q
  = S_Q M_P,0^2.
```

The paper's explicit expressions obey exactly this pattern:

```text
eta_Q
  = m_e^2 (rho Q)^224 (2Q-1)/(4 pi^4 Q^2)
  = eta_0 S_Q,

alpha_G
  = pi^4 Q^2/[(rho Q)^224(2Q-1)]
  = alpha_G,0/S_Q,

M_P/m_e
  = (rho Q)^112 sqrt[(2Q-1)/Q^2]/pi^2
  = (M_P/m_e)_0 sqrt(S_Q).
```

This common pattern remains important. The missing theorem is now sharply
located: derive the `S_Q` change in physical area calibration or in the
noncentral modular response, rather than in the arbitrary normalization of a
semifinite trace.

## References

- Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*:
  <https://arxiv.org/abs/gr-qc/9504004>.
- Witten, *Gravity and the Crossed Product*:
  <https://arxiv.org/abs/2112.12828>.
- Chandrasekaran, Longo, Penington, and Witten, *An Algebra of Observables for
  de Sitter Space*: <https://arxiv.org/abs/2206.10780>.
- Chandrasekaran, Penington, and Witten, *Large N algebras and generalized
  entropy*: <https://arxiv.org/abs/2209.10454>.
