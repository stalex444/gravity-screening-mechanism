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
preservation.  The remaining step is an explicit instantiation of the abstract
block in the full local derivative variables of the Barnich--Troessaert
action.  The current theorem proves the internal algebra that such an
instantiation would use; it does not claim that the published action already
contains the PDT block.

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
- precise relationship notes to duality-symmetric spin-two literature;
- a scope statement separating the proved internal constraint algebra from
  its unproved instantiation in the full derivative action;
- an explicit falsifier: failure of uniform reduction, symplecticity,
  orientation cancellation, or zero-magnetic-source preservation;
- valid MSC 2020 codes checked against the official list before submission.

The likely classifications are in mathematical physics, symplectic geometry,
and relativity.  Exact official codes should be validated during packaging
rather than guessed in advance.
