# From the continuous-core trace to Jacobson's entropy density

## Result

The continuous-core mechanism reproduces not only the numerical screening
factor but also the direction and powers of every gravitational correction in
the deposited paper.

Let

```text
S_Q = 1-lambda4^2 = (2Q-1)/Q^2.
```

The paper's corrected Jacobson entropy density can be written exactly as

```text
eta_Q = S_Q eta_0,
```

where

```text
eta_0 = m_e^2 (rho Q)^224 / (4 pi^4)
```

is the unscreened density. Jacobson's relation then forces

```text
G_Q = G_0/S_Q,
M_P,Q^2 = S_Q M_P,0^2,
M_P,Q = sqrt(S_Q) M_P,0.
```

These are exactly the correction factor in Newton's constant, the inverse
factor in the dimensionless gravitational coupling, and the square-root
factor in the Planck-mass formula.

The algebra is exact. The remaining physical premise is that the
continuous-core trace weight is the microscopic horizon entropy density to
which Jacobson's Clausius argument applies.

## 1. The trace-weight operation

Let `M(W)` be the type-III wedge algebra with vacuum modular flow and let

```text
C(M) = M(W) crossed_product R
```

be its continuous core. Write `tau` for the canonical semifinite trace and
`theta_s` for the dual action. The standard trace-scaling law is

```text
tau after theta_s = exp(-s) tau.
```

It is clearest to regard this as an action on the ray of trace weights. Define

```text
T_Q(tau) = tau after theta_(log Q).
```

Then

```text
T_Q(tau) = Q^(-1) tau.
```

The defect operator on weights is

```text
D_Q = I-T_Q,
```

so

```text
D_Q(tau) = lambda4 tau.
```

Applying the same defect to itself and retaining the complement gives

```text
R_Q = I-D_Q^2 = 2T_Q-T_Q^2
```

and therefore

```text
R_Q(tau) = S_Q tau.
```

Although `2 theta-theta^2` need not be a positive map on every observable,
the induced functional `R_Q(tau)` is positive because it equals the positive
scalar `S_Q` times `tau`. The mechanism is therefore naturally a response of
the entropy weight, rather than an assertion about positivity of an operator
polynomial on the entire algebra.

## 2. Jacobson converts the trace response into G

Jacobson assumes horizon entropy is proportional to area,

```text
dS = eta dA,
```

and imposes the Clausius relation `delta Q = T dS` for every local Rindler
horizon. In natural units the resulting Einstein equation has

```text
G = 1/(4 eta).
```

If the unscreened core weight defines an area density `eta_0`, the quartic
self-defect gives

```text
eta_Q = S_Q eta_0.
```

Jacobson's relation then yields

```text
G_Q
  = 1/(4 eta_Q)
  = 1/(4 S_Q eta_0)
  = G_0/S_Q.
```

This explains the correction's direction. Losing entropy capacity makes a
fixed energy flux curve the horizon more strongly, so Newton's coupling
increases.

Since the Planck scale obeys `M_P^2=1/G` in the convention used by the paper,

```text
M_P,Q^2 = S_Q M_P,0^2
```

and the positive mass ratio is multiplied by `sqrt(S_Q)`. No additional
choice is needed once `eta_Q=S_Q eta_0` is supplied.

The Lean theorems `coreSurvivor_jacobsonCoupling` and
`coreSurvivor_planckScaleSq` verify these implications.

## 3. Exact comparison with the deposited formulas

The paper writes

```text
eta_Q
  = m_e^2 (rho Q)^224 (2Q-1)/(4 pi^4 Q^2)
  = eta_0 S_Q.
```

It also writes

```text
alpha_G
  = pi^4 Q^2 / [(rho Q)^224 (2Q-1)]
  = alpha_G,0 / S_Q,
```

and

```text
M_P/m_e
  = (rho Q)^112 sqrt[(2Q-1)/Q^2] / pi^2
  = (M_P/m_e)_0 sqrt(S_Q).
```

Thus the paper already has exactly the response pattern that follows from a
screened trace weight:

```text
entropy density:  multiply by S_Q
Newton coupling:  divide by S_Q
Planck mass:       multiply by sqrt(S_Q).
```

The continuous-core construction supplies a mathematical reason all three
must occur together. They are not three separate corrections.

## 4. Why the literature makes this bridge plausible

The modern operator-algebraic gravity literature establishes closely related
facts in specific semiclassical settings:

- crossing a type-III algebra by its modular flow produces a type-II algebra
  in which entropy is defined;
- adding or dressing by an observer clock is the physical origin of this
  extension in several constructions;
- the Type-II entropy agrees, up to the qualifications of each model, with
  generalized gravitational entropy.

This does not prove the PDT normalization or the quartic self-defect. It does
show that the object on which PDT's `S_Q` acts is of the right established
kind: a Type-II trace weight used to measure gravitational entropy.

The connection to Jacobson is particularly direct. Jacobson's missing input is
the microscopic entropy per area `eta`. The continuous core provides the trace
needed to define such a density, while the Q step provides a parameter-free
relative correction to it.

## 5. What is established and what is carried

Established mathematics:

1. `tau after theta_s = exp(-s) tau` in the continuous core.
2. At `s=log Q`, the defect of the trace weight is `lambda4`.
3. The complement of the repeated defect is `S_Q=1-lambda4^2`.
4. If `eta_Q=S_Q eta_0`, Jacobson's relation forces
   `G_Q=G_0/S_Q` and `M_P,Q^2=S_Q M_P,0^2`.
5. These are the exact factors already present in the deposited formulas.

Physical premises still required:

1. the relevant local-horizon observer algebra is the continuous core, or an
   equivalent Type-II gravitational algebra;
2. its trace per unit area is the microscopic `eta` in Jacobson's argument;
3. the physical Q-sector operation is the dual-flow step `theta_(log Q)`;
4. quartic self-screening acts as the repeated defect `D_Q^2`;
5. the unscreened normalization `eta_0` follows from the PDT ruler and the
   boundary normalization used in the gravity paper.

The new work closes the algebra after premises 1--4 are stated. It does not
derive those premises from a completed quantum-gravity model.

## 6. The next decisive construction

For a finite transverse horizon cell of area `A`, construct a finite-trace
core projection or positive element `e_A` satisfying

```text
tau(e_A) = eta_0 A.
```

Then define the Q-screened weight

```text
tau_Q = [I-(I-T_Q)^2] tau = S_Q tau.
```

It follows immediately that

```text
tau_Q(e_A) = eta_Q A.
```

The remaining proof is to show that the first variation of this clock-dressed
trace is the entropy variation entering the local Clausius relation. If that
holds, Jacobson's theorem supplies the Einstein equation with the corrected
Newton constant.

This is now a focused problem in gravitational operator algebras, rather than
a search for another numerical identity in the scalar potential.

## References

- Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*:
  <https://arxiv.org/abs/gr-qc/9504004>.
- Witten, *Gravity and the Crossed Product*:
  <https://arxiv.org/abs/2112.12828>.
- Chandrasekaran, Longo, Penington, and Witten, *An Algebra of Observables for
  de Sitter Space*: <https://arxiv.org/abs/2206.10780>.
- Chandrasekaran, Penington, and Witten, *Large N algebras and generalized
  entropy*: <https://arxiv.org/abs/2209.10454>.
- Chen and Penington, *A clock is just a way to tell the time: gravitational
  algebras in cosmological spacetimes*:
  <https://arxiv.org/abs/2406.02116>.
- De Vuyst, Eccles, Hoehn, and Kirklin, *Crossed products and quantum reference
  frames*: <https://arxiv.org/abs/2412.15502>.
