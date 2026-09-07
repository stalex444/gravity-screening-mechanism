# A closed zero-parameter PDT effective theory of gravity

## The closure statement

The present work is sufficient to state a complete low-energy gravity model
with one explicit physical identification and no adjustable coefficient.

Let `M_P,0^2` be the unscreened spin-two normalization fixed independently by
the PDT `rho*Q` scale. Let the quartic time/information direction have residue

```text
lambda4 = 1-1/Q.
```

Adopt the physical identification

> The complete low-energy spin-two normalization is the normalized,
> orientation-blind quadratic response of the quartic direction relative to
> the fixed `rho*Q` background.

At leading quadratic order, write that response as

```text
f(x,t)=a x^2+2b x t+c t^2.
```

Three structural conditions determine it:

```text
f(1,0)=1                 baseline normalization,
f(1,t)=f(1,-t)           orientation/time-reversal blindness of scalar G,
f(1,1)=0                 no independent geometric information at unit overlap.
```

They force

```text
a=1,
b=0,
c=-1,
f(1,t)=1-t^2.
```

Consequently

```text
M_P,Q^2 = (1-lambda4^2) M_P,0^2
        = ((2Q-1)/Q^2) M_P,0^2,

G_Q     = G_0/(1-lambda4^2)
        = (Q^2/(2Q-1)) G_0.
```

No continuous parameter remains. The same coefficient was independently
reached as the clock self-defect survivor, the product of the uniquely
completed Hodge weights, the Gram determinant of the Q channel, the Schur
complement of its equilibrium response, and the contraction of its
two-dimensional information-area form.

## Why this closes the effective theory

The physical identification fixes the only dimensionless number that PDT adds
to the baseline gravitational scale. Standard low-energy requirements then
determine the form of the dynamics:

1. a single massless spin-two field has the Pauli--Fierz quadratic action;
2. the scalar `f(1,lambda4)` multiplies the complete action, including its
   constraints, because it is defined as the spin-two normalization rather
   than as a transverse-only deformation;
3. consistent local universal self-coupling of that field gives the Einstein
   nonlinearities;
4. the resulting Einstein--Hilbert coefficient is `M_P,Q^2/2`, and ordinary
   matter therefore responds with Newton coupling `G_Q`.

At this level, the theory is closed in the ordinary sense of an effective
physical theory: its field content, action, source, and coupling are stated,
and its new coefficient follows from a fixed arithmetic invariant rather than
from a fit parameter.

The effective action is

```text
S_eff[g,matter]
  = (M_P,0^2/2)(1-lambda4^2)
      integral d^4x sqrt(-g) R[g]
    + S_matter[g,matter]
    + higher-order PDT operators.
```

At the two-derivative infrared order, the first term is general relativity
with the PDT value of Newton's coupling. The unspecified higher-order terms
do not enter the asserted leading result and would require separate
derivations.

## What the single identification means

The identification is not an arbitrary insertion of the desired number. Its
content is that gravity measures the amount of geometric distinguishability
remaining after the Q direction is resolved. In normalized information
geometry, the conditional squared length of one unit direction after removing
another unit direction of overlap `lambda4` is necessarily

```text
1-lambda4^2.
```

The Hodge calculation gives the same statement in four-dimensional geometric
language. The modular core fixes one chiral weight to

```text
1/Q = 1-lambda4.
```

Preserving the orientation-blind mean fixes the other to

```text
2-1/Q = 1+lambda4,
```

and their product is again `1-lambda4^2`. Thus the information projection and
the four-dimensional chiral response are the same quadratic invariant.

In the equilibrium interpretation, the Q degree of freedom is resolved before
the macroscopic geometry is read. The resulting metric is less stiff by the
surviving independent-information fraction. A graviton is a propagating
disturbance of that settled metric; the Einstein nonlinearity is its required
universal self-interaction.

## The status of the proof

The following statement is kernel checked:

> Any quadratic response normalized at zero overlap, even under reversal, and
> null at unit overlap is exactly `1-lambda4^2`; a fixed external source then
> has the reciprocal response, and the quartic specialization is
> `Q^2/(2Q-1)`.

The mathematical implication is a theorem. The sentence identifying that
quadratic response with the complete physical spin-two normalization is a
physics postulate. That division is normal for a physical theory: mathematics
determines the consequences of the identification, while observation and
further microscopic construction test whether nature realizes it.

The present result therefore supports two honest claims:

- **Effective closure:** given the stated PDT gravity identification, the
  coefficient and Einstein dynamics follow without another parameter.
- **Microscopic frontier:** derive the same identification from a sourced
  horizon, prepotential, connection, or information-state construction rather
  than taking it as the low-energy constitutive law.

The second task would explain the effective postulate; it is not needed to
make the effective theory mathematically complete.

## The decisive next prediction

The effective action reproduces the already deposited Newton coefficient. To
increase physical evidence, its next use should be a quantity that was not
used to choose the identification. The clean candidates are:

1. a source-sensitive horizon or weak-field observable that depends on the
   same full normalization and has no new coefficient;
2. a higher-curvature or finite-frequency correction forced by the Q channel;
3. a relation between gravitational response and the independently derived
   quartic clock scale `log Q`;
4. a proof that the zero-magnetic-source constraint is preserved by the
   microscopic Q reduction.

The fourth target is the shortest structural test. The first three would add
new empirical exposure.

## Kernel artifact and references

`GravityScreening/EffectiveGravityClosure.lean` proves the uniqueness of the
complete quadratic coefficient, its reciprocal source response, positivity at
the quartic root, its exact rational form, and equality with the
mean-preserving clock/Hodge product.

- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Deser, *Self-Interaction and Gauge Invariance*:
  <https://arxiv.org/abs/gr-qc/0411023>.
- Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*:
  <https://arxiv.org/abs/gr-qc/9504004>.

