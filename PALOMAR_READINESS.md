# Palomar readiness of the gravity-screening formalization

## Current recommendation

Prepare the formalization, but do not submit the five effective-closure
theorems as a standalone result group yet.

They are exact and kernel checked, but their central physical premise is
explicitly assumed: the normalized quadratic response is identified with the
coefficient of the complete sourced spin-two action.  A comparator can fairly
classify the remainder as elementary consequences of that chosen model.  The
number of earlier accepted entries establishes a strong formalization record,
but each new comparison still needs its own research-level mathematical
consequence.

## Strongest present theorem group

The best current result group is the combined symplectic and Hodge chain:

1. the modular clock fixes one weight to `1/Q=1-lambda4`;
2. preservation of the orientation-blind mean uniquely fixes the partner to
   `1+lambda4`;
3. their product is `1-lambda4^2`;
4. the corresponding determinant-one constitutive shape is symplectic;
5. reduction over an arbitrary symmetric bilinear field operator gives the
   same coefficient on the entire orientation-even propagating quadratic
   form;
6. the coefficient is positive and has exact quartic form `(2Q-1)/Q^2`;
7. an independently normalized source has the reciprocal response in the
   reduced two-channel equations.

This is substantially stronger than a single constructed scalar identity.
It establishes uniqueness, symplectic compatibility, basis-independent field
reduction, and the exact quartic specialization.

## The sourced-constraint advance

The abstract sourced-constraint part has now been proved.  Applying the same
two-channel block to the four Pauli--Fierz lapse-and-shift constraint labels
gives

```text
S_Q electric_constraint_i = source_i,
magnetic_source_equation_i = 0
```

for all four labels.  A determinant-one lower-triangular Gram factor is
symplectic, preserves the electric source ray `(T,0)` without generating a
magnetic source component, and produces the full inverse response `1/S_Q`.
It is unique among positive source-preserving factors in the stated class.

This connects the formalization to a standard mathematical-relativity problem
surface: duality-symmetric spin-two fields with sources and constraint
preservation.  A new operator theorem now applies the block to the output of
an arbitrary complete linear operator.  For the Pauli--Fierz operator it gives
an explicit local doubled equation, preserves the Ward identity and gauge
kernel, and reduces the full sourced equation to `S_Q E_PF(h)=T` without
inverting the gauge operator.  The accompanying symmetric-bilinear theorem
derives the doubled equations from a quadratic action and proves positivity on
a positive physical mode space.

These results construct a mathematically consistent linear completion; they
do not claim that the Barnich--Troessaert action already contains the PDT
block.  The physical step still open is to derive, rather than identify, its
partner spin-two field and `lambda4` coupling from the PDT Q clock/information
degree of freedom.

The standard five-coefficient Pauli--Fierz uniqueness calculation is also
kernel checked.  The new four-dimensional symbol module derives the three
coefficient relations from the Ward identity using explicit symmetric test
tensors and derives the fourth from operator self-adjointness.  These
relations force every term in the local two-derivative symmetric-tensor ansatz
to share one overall coefficient.  The doubled-operator construction places
the Q block on that complete gauge-invariant operator, so its `S_Q`
coefficient extends to the lapse and shift sector as well as its propagating
components.  This closes the linear normalization-placement and action-algebra
questions while leaving the PDT identification of the partner field open.

The calculation is proved in both Euclidean and direct Minkowski signature.
The Lorentzian module explicitly carries the `(-,+,+,+)` signs through raised
momenta, traces, divergences, and the tensor pairing, removing any reliance on
an informal continuation argument.

## A viable intermediate submission

An intermediate entry can now compare the abstract symplectic-reduction and
source-preserving constraint theorem group.  It should
be framed as a theorem about mean-preserving chiral completion and uniform
reduction of doubled quadratic field theories, with PDT as one exact quartic
specialization.  The comparison should not claim that Newton's constant has
been derived.

That package would need:

- a small independent `Challenge.lean` importing only Mathlib;
- roughly eight to twelve nonredundant statements led by the operator theorem;
- the Pauli--Fierz coefficient-uniqueness and source-frame closure statements;
- precise relationship notes to duality-symmetric spin-two literature;
- a scope statement separating the proved linear doubled action and constraint
  algebra from the unproved PDT identification of the partner field;
- an explicit falsifier: failure of uniform reduction, symplecticity,
  orientation cancellation, or zero-magnetic-source preservation;
- valid MSC 2020 codes checked against the official list before submission.

The likely classifications are in mathematical physics, symplectic geometry,
and relativity.  Exact official codes should be validated during packaging
rather than guessed in advance.
