# The distinct uniqueness questions in the PDT gravity chain

PDT now has several results that use the word *unique*.  They do not duplicate
one another.  They act at successive levels of the proposed explanation.

## 1. Selection of the generators

The founding minimality criteria distinguish the cubic plastic/Pisot root
`rho` and the quartic root `Q` in their respective dimensional classes.  This
answers why the construction begins with these two algebraic generators.

## 2. Distinctiveness of the pair in the Lagrangian

The public expanded exclusion computation tests 88 candidates, hence 3,828
directed pairs, against five simultaneous Lagrangian observables.  Exactly one
pair passes all five: `(rho,Q)`, with 0.41 percent combined error.  This result
is banked in the private canon at F:261 and is publicly reproducible in the
companion repository to the deposited gravity paper.

This answers whether many comparably simple algebraic pairs perform the same
simultaneous numerical job.  It does not determine how gravity must read the
selected pair.

## 3. Uniqueness of the quartic two-channel response

The Q core supplies one retained weight

```text
w_minus = 1/Q = 1-lambda4.
```

Preserving the orientation-blind mean fixes the other weight uniquely:

```text
(w_plus+w_minus)/2 = 1
    implies
w_plus = 1+lambda4.
```

Their product is therefore

```text
S_Q = (1-lambda4)(1+lambda4) = 1-lambda4^2.
```

This answers why the proposed Q screening expression has this form rather
than an independently chosen quadratic correction.

## 4. Uniqueness of the source-preserving canonical frame

There are many square roots of a positive constitutive matrix.  Requiring a
positive determinant-one Gram factor whose inverse transpose preserves the
ordinary electric source ray fixes a unique lower-triangular frame.  It keeps
the external source `(T,0)` purely electric and produces the physical response

```text
(T/S_Q, lambda4 T/S_Q).
```

The second entry is an internal constitutive response.  The external magnetic
or NUT source remains exactly zero.

Before that frame is chosen, the constitutive metric itself is also forced
within the clock/Hodge hypotheses.  Exchange symmetry, unit mean diagonal
normalization, and even-channel weight `1/Q` uniquely give
`[[1,-lambda4],[-lambda4,1]]`.  Thus `lambda4` is not a free matrix entry once
the retained clock weight is identified with the even Hodge channel.

## 5. Uniqueness of the massless spin-two operator

The standard parity-even, local, two-derivative operator on a symmetric
rank-two field has five tensor coefficients.  The four-dimensional symbol
proof derives three relations from the Ward identity and one from formal
self-adjointness.  Lean then proves that the coefficient pattern must be

```text
a (1,-2,1,1,-1).
```

Thus only the overall normalization `a` remains.  Applying the Q block to the
complete gauge-invariant operator and setting `a=S_Q` forces the same
normalization into the propagating, lapse, and shift components.

This answers why gravitational waves and Newtonian gravity cannot choose
different Q normalizations while remaining one standard massless spin-two
field.

## The remaining identification

The local linear doubled spin-two equations and their symmetric quadratic
action have now been constructed.  They preserve the Ward identity, gauge
kernel, source conservation, and positive quadratic form on the physical mode
space.  The remaining question is an identification between structures:

> Why is the partner field in that minimal doubled action the Q
> information/clock degree of freedom of PDT, with
> `lambda4=1-1/Q`?

The existing results determine the consequences of that identification.  A
derivation of the partner field and coupling from the Q dynamics would turn
the present mathematical completion into a PDT gravitational derivation.

## Artifacts

- `GravityScreening/ClockHodgeBridge.lean`
- `GravityScreening/ElectricSourceFrame.lean`
- `GravityScreening/PauliFierzUniqueness.lean`
- `GravityScreening/PauliFierzSymbol.lean`
- `GravityScreening/LorentzPauliFierzSymbol.lean`
- `GravityScreening/DoubledSpinTwoOperator.lean`
- `GravityScreening/DoubledSpinTwoAction.lean`
- `GravityScreening/ClockForcesConstitutive.lean`
- public exclusion computation:
  <https://github.com/stalex444/dimensional-origin-Newton/blob/main/expanded_exclusion_test.py>
