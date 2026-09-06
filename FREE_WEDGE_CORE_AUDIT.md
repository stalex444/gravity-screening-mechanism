# The free-wedge obstruction and the continuous-core realization

## Result

Running the proposed horizon mechanism through the actual linearized
two-scalar model produces a sharp negative result and a sharper positive
replacement.

1. In the ordinary Fock vacuum of the linearized scalar theory, the wedge
   modular group is the Lorentz-boost group and has no non-vacuum normalizable
   eigenvectors. Therefore the local wedge algebra has no nonzero bounded
   modular eigenoperator with phase `Q^(-it)`. The graph clock cannot be an
   exactly covariant bounded subsystem of this free wedge.
2. In the continuous core of the same type-III wedge algebra, the missing
   logarithmic scale is present canonically. The dual action scales the
   canonical trace by `exp(-s)`. At `s=log Q`, the retained trace fraction is
   `1/Q` and the defect is exactly `lambda4`.
3. On the trace ray, applying this defect twice and taking its complement gives

   ```text
   I - (I - T_Q)^2 = 2 T_Q - T_Q^2
   ```

   with eigenvalue

   ```text
   2/Q - 1/Q^2 = 1 - (1 - 1/Q)^2 = 1 - lambda4^2.
   ```

This is the first standard operator-algebraic setting found in this audit in
which the paper's statement that “the 4D self-coupling acts on itself” becomes
a literal twice-applied defect operation and produces the complete gravity
coefficient.

The calculation establishes a candidate mechanism in the observer/core
algebra. It does not yet prove that its trace response is Newton's kinetic
response.

## 1. Linearize the deposited two-scalar action

At the selected axis vacuum write

```text
phi = v + h,     chi = x.
```

The quadratic action is the direct sum of two free scalar actions. The exact
potential expansion in `ACTION_COCYCLE_AUDIT.md` has no `h*x` term. With the
usual normalization, the two squared masses are read from

```text
4 lambda3 v^2 h^2

and

(kappa v^2 - 2 lambda4 u^2) x^2,
```

up to the conventional factor `1/2` in the definition of a mass term. The
precise masses do not affect the boost-spectrum argument below, provided the
chosen vacuum gives the standard stable free-field representation.

## 2. Why a free scalar has no normalizable boost eigenmode

For one massive scalar, parameterize the longitudinal mass shell by rapidity:

```text
p0 = m_perp cosh(theta),
p1 = m_perp sinh(theta),
m_perp^2 = m^2 + |p_perp|^2.
```

The invariant one-particle measure becomes, up to normalization,

```text
dtheta d^2 p_perp.
```

A boost of rapidity `a` translates `theta`:

```text
(U(a) psi)(theta,p_perp) = psi(theta-a,p_perp).
```

The boost generator is therefore `-i d/dtheta`. A formal eigenfunction with
real eigenvalue `nu` has the form

```text
psi(theta,p_perp) = exp(i nu theta) g(p_perp).
```

Its absolute value is constant in `theta`, so it is not square-integrable on
the real rapidity line unless `g=0`. Thus the one-particle boost generator has
continuous spectrum and no eigenvectors.

On the `n`-particle sector the boost translates all rapidities together.
Changing variables to their common center rapidity and `n-1` differences
again makes the generator a translation in a full real-line coordinate. It
has no eigenvectors there either. The same argument applies to the direct sum
of the two scalar species. In the full bosonic Fock space, the vacuum is the
only boost eigenvector.

Generalized boost-frequency modes can be written as distributions or
non-normalizable waves. They do not contradict this result and are not bounded
elements of the local wedge algebra.

## 3. From vector spectrum to an exact local-algebra obstruction

Let `M(W)` be the right-wedge algebra and `Omega` the vacuum. The
Bisognano--Wichmann property gives, with a convention-dependent sign,

```text
Delta_W^(it) = U(Lambda_W(2 pi t)).
```

Suppose a bounded wedge operator `B` carried the required graph phase:

```text
sigma_t(B) = Q^(-it) B.
```

Because `Delta_W^(it) Omega = Omega`, applying this equation to the vacuum
would give

```text
Delta_W^(it) B Omega = Q^(-it) B Omega.
```

Thus `B Omega` would be a nonzero boost eigenvector. The Fock-space result
forces `B Omega=0`. The vacuum is separating for the wedge algebra, so `B=0`.

Consequently

```text
{B in M(W) : sigma_t(B)=Q^(-it)B for every t} = {0}
```

in the standard linearized two-scalar vacuum representation.

The same proof shows that the modular centralizer is scalar: a frequency-zero
operator sends the vacuum to a boost-invariant vector, hence to a multiple of
the vacuum, and separatingness makes the operator a scalar.

This rules out a vacuum-preserving expected embedding of the graph-KMS pQ
factor into the free wedge. Such an embedding would intertwine modular flows
and would carry the graph's nonzero degree-one quartic isometry to precisely
the forbidden bounded eigenoperator. The state-preserving injection from the
general type-III embedding theorem still exists; it simply cannot also be the
required modular-covariant expected embedding in this model.

Scope: this is a theorem about the linearized Fock model. It is not a theorem
that every interacting or gravitational observer algebra has trivial modular
point spectrum.

## 4. The continuous core contains exactly the missing structure

For a type-III wedge factor `M` with faithful normal vacuum state `omega`, form
the continuous core

```text
C(M) = M crossed_product_(sigma^omega) R.
```

It is semifinite and carries a canonical faithful normal semifinite trace
`tau`. For a type-III_1 factor the core is type II_infinity. Its dual action
`theta_s` obeys

```text
tau(theta_s(X)) = exp(-s) tau(X)
```

for positive finite-trace `X`, with the sign fixed by the displayed
convention.

Choose the quartic logarithmic step

```text
s_Q = log Q.
```

Then

```text
tau(theta_(s_Q)(X)) / tau(X) = exp(-log Q) = 1/Q,
```

and the normalized trace defect is

```text
[tau(X)-tau(theta_(s_Q)(X))]/tau(X)
  = 1 - 1/Q
  = lambda4.
```

This is the same scalar obtained independently from all three earlier
constructions:

- the Perron coordinate of the quartic substitution;
- the eigenvalue of `I-M_Q^(-1)` on the quartic Perron line;
- the KMS forward/reverse defect at modular gap `log Q`.

The core supplies a fourth realization, now attached directly to the standard
operator algebra used to make gravitational entropy finite.

## 5. The square becomes literal self-action

Let `T_Q` denote the action induced by `theta_(log Q)` on the one-dimensional
trace ray. It has eigenvalue `1/Q`. Define its defect

```text
D_Q = I - T_Q.
```

On the trace ray,

```text
D_Q = lambda4.
```

The quartic self-defect is therefore `D_Q^2=lambda4^2`, and its complement is

```text
I - D_Q^2
  = I - (I-T_Q)^2
  = 2T_Q - T_Q^2.
```

Its trace-ray eigenvalue is

```text
2/Q - 1/Q^2
  = (2Q-1)/Q^2
  = 1-lambda4^2.
```

This is the exact correction multiplying the gravitational hierarchy in the
deposited paper. The theorem `coreSelfDefect_survivor` in
`GravityScreening/Basic.lean` kernel-checks the complete scalar implication
from the standard trace-scaling law.

There is one caveat. The linear map `2 theta_s-theta_(2s)` is not asserted to
be positive on the whole core. The exact construction is best stated on the
ray of trace weights: the pullback operation `T_Q(tau)=tau after theta_(log Q)`
has eigenvalue `1/Q`, and `[I-(I-T_Q)^2]tau=S_Q tau` is a positive functional.
A physical response construction must still explain why this traced
self-defect, rather than a different function of the dual flow, multiplies the
gravitational kinetic or entropy coefficient. See `JACOBSON_CORE_BRIDGE.md`.

## 6. Why p and Q together reconstruct a continuous clock

The two logarithmic root steps generate the additive subgroup

```text
Gamma_pQ = Z log(rho) + Z log(Q).
```

The roots are multiplicatively independent. Therefore

```text
log(rho)/log(Q)
```

is irrational: a rational ratio would give a nontrivial equality between an
integer power of `rho` and an integer power of `Q`. It follows that
`Gamma_pQ` is dense in the real line.

The crossed product contains strongly continuous clock unitaries `lambda_t`.
Consequently the unitaries with `t` in `Gamma_pQ` strongly generate those for
all real `t`. Read physically, the pQ clock supplies a countable arithmetic
skeleton whose closure is continuous observer time:

- `log rho` and `log Q` are the two primitive steps;
- their incommensurability prevents a finite period;
- their integer combinations approximate every modular time;
- the Q generator remains distinguished and carries the trace defect
  `lambda4`.

Factor type or density alone does not select this pair; many irrational pairs
are dense. The selection of `rho,Q` remains the independent PDT boundary
claim. Once that pair is supplied, the density and the Q trace defect are
forced mathematics.

## 7. The time interpretation

The construction separates three quantities that should not be conflated:

1. `log Q` is a dimensionless modular spectral gap and a log-weight step.
2. `log Q/(2 pi)` is its frequency with respect to conventionally normalized
   geometric boost rapidity.
3. A physical duration requires an observer Hamiltonian and an energy scale.

In the bare local wedge, the exact Q line is non-normalizable. In the observer
extension it is a legitimate clock translation and a trace-scaling step. This
suggests that PDT time is not a particle oscillation located at one spacetime
point. It is the arithmetic skeleton of the relational clock used to turn a
type-III local algebra into a type-II gravitational algebra.

That reading also explains why the same construction is relevant to
Jacobson's entropy density. A type-III local algebra has no ordinary trace;
the observer/core algebra does. The quartic defect acts directly on the object
that measures finite gravitational entropy.

## 8. What remains to prove

The candidate chain is now

```text
quartic inverse step
   -> Perron/KMS defect lambda4
   -> dual-flow trace defect lambda4
   -> repeated self-defect lambda4^2
   -> surviving trace response 1-lambda4^2.
```

Every displayed scalar equality is exact. Selecting `s_Q=log Q`, reading
quartic self-action as the repeated defect `D_Q^2`, and identifying the
surviving trace weight with gravity are physical premises. The final bridge is
therefore:

```text
surviving Type-II trace response
       = gravitational kinetic/entropy response.
```

A completion needs one of the following:

1. derive the Newton/Jacobson coefficient from a variation of the core trace
   under the Q dual-flow step;
2. construct a clock-dressed version of the two-scalar action and show that
   integrating out or constraining the clock yields `2T_Q-T_Q^2`;
3. prove that the horizon entropy functional responds to the quartic
   self-defect by exactly the same polynomial.

The second route is the most concrete because recent gravitational-algebra
constructions already formulate observables by adding an observer clock and
passing from type III to type II.

## Prior-art control

The continuous core, its dual action, and trace scaling are classical
Connes--Takesaki theory. Recent gravity papers use related crossed products and
observer algebras to define generalized entropy. Public work also already
formalizes algebraic versions of the dual-action and trace-scaling laws. The
new content of this audit is the PDT-specific substitution

```text
s=log Q,
D_Q=I-T_Q,
I-D_Q^2=2T_Q-T_Q^2,
```

and its exact match to the deposited gravity coefficient. Novelty relative to
the research literature has not been established.

## References

- Bisognano and Wichmann, *On the Duality Condition for a Hermitian Scalar
  Field*, Journal of Mathematical Physics 16 (1975), and the companion 1976
  paper, for wedge modular flow as boosts in the scalar Wightman theory.
- Brunetti, Guido, and Longo, *Modular Structure and Duality in Conformal
  Quantum Field Theory*: <https://arxiv.org/abs/funct-an/9302008>.
- Takesaki, *Duality for crossed products and the structure of von Neumann
  algebras of type III*, Acta Mathematica 131 (1973), 249--310,
  <https://doi.org/10.1007/BF02392041>.
- Connes and Takesaki, *The flow of weights on factors of type III*, Tohoku
  Mathematical Journal 29 (1977), 473--575.
- Witten, *Gravity and the Crossed Product*:
  <https://arxiv.org/abs/2112.12828>.
- Chandrasekaran, Longo, Penington, and Witten, *An Algebra of Observables for
  de Sitter Space*: <https://arxiv.org/abs/2206.10780>.
- Chen and Penington, *A clock is just a way to tell the time: gravitational
  algebras in cosmological spacetimes*:
  <https://arxiv.org/abs/2406.02116>.
- De Vuyst, Eccles, Hoehn, and Kirklin, *Crossed products and quantum reference
  frames*: <https://arxiv.org/abs/2412.15502>.
- Bliokh, *Lorentz-boost eigenmodes*, for generalized boost eigenmodes and
  their singular wave structure: <https://arxiv.org/abs/1802.03940>.
- QIQT-H public formalization, for an independent algebraic-core
  formalization of the dual action and trace-scaling mechanism:
  <https://qiqt.org/formalization/>.
