# Palomar readiness

## Recommendation

Submit this theorem package for Palomar review.

The comparison surface contains ten theorem statements. Together they prove
the exact linear result that is ready for external assessment:

1. the divergence of the standard Lorentzian five-term spin-two symbol has
   exactly three Ward coefficients;
2. the Ward identity forces those three coefficients to vanish;
3. formal self-adjointness supplies the remaining trace relation;
4. the five coefficients are therefore the Pauli--Fierz pattern up to one
   common scale;
5. fixing that scale to `1-(1-1/q)^2` gives `(2*q-1)/q^2` and fixes every
   coefficient;
6. a source-free partner channel can be eliminated componentwise, without
   inverting the gauge operator, and produces the same coefficient `1-l^2`
   on the full tensor equation;
7. gauge-kernel shifts survive the reduction; and
8. the Ward identity forces conservation of the screened source.

## Verification

- `Challenge.lean` imports only Mathlib and contains the ten intentional proof
  holes.
- `Solution.lean` provides all ten proofs through the checked source modules.
- `comparator.json` lists the same ten declarations in the same order.
- The solution declarations use only `propext`, `Classical.choice`, and
  `Quot.sound`; none uses `sorryAx`.
- `formalization.yaml` uses schema version `v0.4`, quotes all three MSC 2020
  codes, and contains one alignment row for each compared declaration.
- The Lean toolchain and complete Mathlib dependency graph are pinned.

## Exact boundary

This package proves a classification and reduction theorem for a specified
linear doubled spin-two model. It does not prove that nature selects the
quartic number `Q`, identify the physical partner field, construct nonlinear
general relativity, formalize Jacobson's thermodynamic argument, or verify a
measured value of Newton's constant. Those applications are described as
physical correspondences rather than Lean theorems.

The package also does not contain the proposed gravitational-wave observable.
That calculation requires a separate source-to-detector derivation to decide
whether the quartic screening factor survives or cancels.
