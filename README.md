# Structural rigidity of a quartic standard-siren response

This repository contains a Lean 4 proof of a conditional standard-siren
classification theorem. It asks what an observer can infer when a conserved
two-output system has one visible transverse-traceless polarization channel
and one hidden channel.

The principal theorem begins with an arbitrary real two-by-two response matrix
`M` on the plus/cross polarization plane and an arbitrary retained quadratic
weight `0 < s <= 1`. It assumes:

1. `M` commutes with the polarization quarter-turn;
2. `M` is self-adjoint;
3. `Mᵀ M = s I`; and
4. the passive sign branch is selected.

These hypotheses force

```text
M = sqrt(s) I.
```

The result then places this unique exterior block inside the exact dilation

```text
psi -> sqrt(s) psi_visible + sqrt(1-s) psi_hidden.
```

For every finite state and every real diagonal observable, visible and hidden
expectations add to the original expectation. If chirp evolution counts this
complete conserved quantity while strain reads the exterior TT amplitude,
all common source responses cancel and the inferred standard-siren distance is
forced to be

```text
d_inferred = d_true / sqrt(s).
```

This is a classification result: the matrix, source state, observable, and
common response are quantified rather than selected after the calculation.

## The quartic Q specialization

Let `Q` denote the positive real root satisfying

```text
Q^4 = Q + 1,    Q > 1.
```

The PDT proposal supplies the retained quadratic weight

```text
s_Q = 1 - (1 - 1/Q)^2 = (2Q - 1)/Q^2.
```

The general theorem then fixes the dimensionless response

```text
R_Q = d_inferred / d_true
    = 1 / sqrt((2Q - 1)/Q^2),

1.016 < R_Q < 1.017.
```

There is no fitted coefficient in this specialization. Lean also proves exact
algebraic fingerprints for the two observable factors. For the exterior
amplitude `A_Q = sqrt(s_Q)`,

```text
A_Q^8 + 3 A_Q^6 - 2 A_Q^4 + 22 A_Q^2 - 23 = 0.
```

For the distance response `R_Q = 1/A_Q`,

```text
23 R_Q^8 - 22 R_Q^6 + 2 R_Q^4 - 3 R_Q^2 - 1 = 0.
```

Lean now proves that the amplitude polynomial is irreducible over the
rationals, using an explicit Rabin/Frobenius certificate after reduction
modulo five and a monic Gauss-lemma lift. Consequently both `A_Q` and `R_Q`
have minimal-polynomial degree exactly eight; the equations above cannot
collapse to lower degree.

The proof also recovers the quartic generator from the amplitude:

```text
Q = (4 - A_Q^2 + A_Q^6) / (8 - 4 A_Q^2 - A_Q^6).
```

Therefore `ℚ(Q)` is contained in `ℚ(A_Q)`, and Lean proves the relative degree

```text
[ℚ(A_Q) : ℚ(Q)] = 2.
```

This degree-eight observable field is distinct from PDT's registered
degree-twelve joint field `ℚ(ρ,Q)=ℚ(ρQ)`. The numbers describe different
layers: degree four for the quartic generator, degree eight after adjoining
the independent amplitude square root, and degree twelve for the combined
cubic-quartic substrate.

## A falsifiable two-branch result

The physical premise is stated rather than hidden. The biased result applies
when chirp evolution counts complete visible-plus-hidden flux while the
detector reads only the exterior TT amplitude. The repository also proves the
competing placement:

```text
complete flux in chirp, exterior strain -> R_Q = 1/sqrt(s_Q)
same response in chirp and strain      -> R_Q = 1
```

Thus the model cannot continuously retune the response under the submitted
hypotheses. Observations can reject the proposed placement.

## Relation to the literature

Gravitational-wave luminosity distance and its possible difference from
electromagnetic luminosity distance are established in:

- Enis Belgacem, Yves Dirian, Stefano Foffa, and Michele Maggiore,
  [The gravitational-wave luminosity distance in modified gravity theories](https://arxiv.org/abs/1712.08108).
- The same authors,
  [Modified gravitational-wave propagation and standard sirens](https://arxiv.org/abs/1805.08731).

This submission adapts the response-ratio observable to a finite conservative
two-polarization theorem. It does not formalize cosmological propagation or
claim that the cited papers contain the Q specialization.

## Palomar comparison surface

The eight selected results are:

1. `StandardSirenRigidity.structuralTT_globalFlux_standardSirenDistance`;
2. `StandardSirenRigidity.quarticStructuralTT_standardSirenRatio_bounds`;
3. `StandardSirenRigidity.quarticStandardSirenResponse_algebraicSignature`;
4. `StandardSirenRigidity.quarticStandardSirenResponse_minpoly_natDegree`;
5. `StandardSirenRigidity.quarticExteriorAmplitude_algebraicSignature`;
6. `StandardSirenRigidity.quarticExteriorAmplitude_minpoly_natDegree`;
7. `StandardSirenRigidity.quarticExteriorAmplitude_relativeDegree`; and
8. `StandardSirenRigidity.quarticUniversalResponse_cancels_from_standardSiren`.

`Challenge.lean` imports only Mathlib and contains their full statements with
intentional proof holes. `Solution.lean` imports the proved development and
transports the source declarations across definitionally identical comparison
definitions. `GravityScreening/QuarticResponseIrreducibility.lean` contains the
mod-five certificate, rational lift, generator-recovery identity, and field
extension proofs. `comparator.json` fixes the declaration order and permitted
axioms. `formalization.yaml` records scope, provenance, literature relations,
and exact statement alignment.

The earlier Lorentz spin-two classification and source-reduction declarations
remain in the repository as proof infrastructure. They are not selected again
as the principal Palomar result group.

## Exact scope

The Lean proof establishes the mathematical implication from its displayed
hypotheses. It does not prove that Nature selects the proposed observer
placement, derive a redshift-dependent propagation law, identify Q with a
measured gravitational coupling, derive Newton's constant, or formalize
Jacobson's thermodynamic argument.

## Reproduce

The project pins Lean 4.31.0 and Mathlib commit
`fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.

```bash
lake exe cache get
lake build
lake env lean Challenge.lean
lake env lean Solution.lean
```

The solution declarations depend only on `propext`, `Classical.choice`, and
`Quot.sound`. None depends on `sorryAx`.

## License

MIT
