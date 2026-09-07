# Lorentz spin-two rigidity and quartic source reduction

This repository gives a Lean 4 certificate for a classification-and-reduction
result in linearized gravity.  It begins with the standard parity-even,
local, two-derivative, five-coefficient Fourier symbol acting on a symmetric
rank-two field in four-dimensional Minkowski space.

The formalization proves that:

1. the Lorentz Ward identity forces the three divergence relations;
2. formal self-adjointness supplies the remaining relation;
3. together they force the Pauli--Fierz coefficient pattern up to one overall
   scale;
4. a doubled spin-two system with a source-free partner reduces to one sourced
   equation with coefficient `1-l^2`, without assuming that the gauge operator
   is invertible;
5. gauge-kernel shifts leave both channel equations unchanged, and the Ward
   identity forces source conservation; and
6. for `l = 1-1/q`, the complete coefficient is

   ```text
   1 - l^2 = (2*q - 1)/q^2.
   ```

The Palomar capstone theorem is
`LorentzSpinTwoScreening.quarticLorentzSpinTwo_rigidity_and_sourceReduction`;
its proved source declaration is in the `GravityScreening` namespace.
Its statement combines coefficient rigidity with componentwise elimination of
the partner channel.

## Why the result is useful

The ordinary shortcut for eliminating a coupled field is to invert its kinetic
operator.  A massless spin-two operator has a gauge kernel, so that shortcut is
not available before gauge fixing.  The theorem works directly with the two
channel equations and eliminates only their outputs.  It therefore retains the
gauge freedom and proves that the same scalar multiplies every covariant tensor
component, including the constraint components.

This gives researchers in linearized gravity and constrained field theory a
small exact lemma: constant two-channel mixing commutes with the Ward structure
of the Pauli--Fierz operator, and source-free partner elimination produces one
uniform Schur-complement coefficient.

## Quartic specialization and physical application

The motivating specialization takes `q = Q`, the positive real root of

```text
Q^4 = Q + 1,
```

and sets

```text
lambda4 = 1 - 1/Q,
S_Q     = 1 - lambda4^2 = (2*Q - 1)/Q^2
        ≈ 0.96730142.
```

PDT identifies `lambda4` with the constant coupling between an ordinary
spin-two output and a dual or hidden partner output.  Under that correspondence,
the theorem proves that the full linear response is screened by `S_Q`; the
reciprocal gravitational response is enhanced by `1/S_Q`.

This connects to Ted Jacobson's thermodynamic derivation of the Einstein
equation.  Jacobson assumes an entropy-area density `eta`; its normalization
sets Newton's constant through

```text
eta = 1/(4*hbar*G).
```

The PDT gravity formula supplies a value of `G` and therefore fills Jacobson's
coefficient.  The present Lean development establishes the intervening
spin-two consistency: the quartic coefficient appears in a Ward-compatible,
conserved, gauge-invariant linear gravitational equation.

The `G` and `eta` values are one physical result written in reciprocal form,
so they are not counted as independent numerical confirmations.  The physical
identification of the quartic partner with gravity is a correspondence rule of
the model and is not asserted as a theorem in `Challenge.lean`.

## Exact formal scope

The compared statements cover the flat-Minkowski Fourier symbol, its Ward and
self-adjointness classification, pointwise doubled-channel reduction,
gauge-kernel invariance, and source conservation.  They do not formalize a
nonlinear Einstein manifold, the microscopic origin of the quartic partner,
Jacobson's thermodynamic argument, or an experimental measurement of `G`.

The nonlinear self-coupling bootstrap and duality-symmetric formulations of
linearized gravity are cited as published background in `formalization.yaml`.
The longer sequence of exploratory mechanisms and obstruction tests that led
to the final theorem is preserved in
[`DEVELOPMENT_RECORD.md`](DEVELOPMENT_RECORD.md).

## Palomar comparison surface

- [`Challenge.lean`](Challenge.lean) imports only Mathlib and contains the ten
  compared theorem statements with intentional proof holes.
- [`Solution.lean`](Solution.lean) imports the proved development.
- [`comparator.json`](comparator.json) fixes the declaration order and the
  permitted foundational axioms.
- [`formalization.yaml`](formalization.yaml) records sources, scope, related
  registrations, and statement alignment.

## Reproduce

The project pins Lean 4.31.0 and Mathlib commit
`fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.

```bash
lake exe cache get
lake build
lake env lean Challenge.lean
lake env lean Solution.lean
```

All solution declarations depend only on `propext`, `Classical.choice`, and
`Quot.sound`.  None depends on `sorryAx`.

## License

MIT
