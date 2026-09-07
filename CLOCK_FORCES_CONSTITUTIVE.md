# The clock weight forces the gravity constitutive matrix

## Question

The first-order gravitational action needs a symmetric internal metric.  Why
should that metric contain the coefficient `lambda4=1-1/Q`, rather than an
arbitrary mixing parameter?

## Three conditions

Let `M` be the real two-channel metric on the dual gravitational
prepotentials.  Impose three conditions already motivated by the PDT clock and
Hodge construction:

1. **Exchange symmetry.** Interchanging the two Hodge-related channels leaves
   `M` unchanged.
2. **Unit mean baseline.** The mean of the two diagonal self-weights is one.
3. **Clock retention.** The orientation-even channel `(1,1)` has the retained
   quartic clock weight `1/Q`.

## Unique result

Lean proves that these conditions leave no free matrix coefficient:

```text
M = [[1,        -lambda4],
     [-lambda4, 1       ]],

lambda4 = 1-1/Q.
```

Its determinant is therefore forced to be

```text
det M = 1-lambda4^2 = (2Q-1)/Q^2 = S_Q.
```

The proof does not begin by assuming the off-diagonal entry.  Exchange
symmetry makes the diagonal entries equal and the off-diagonal entries equal;
unit mean fixes both diagonals to one; the clock eigenweight then fixes the
off-diagonal entry to `1/Q-1=-lambda4`.

## What this changes

Within the first-order canonical construction, `lambda4` is no longer a free
constitutive coefficient.  It is forced by the retained Q-clock weight once
the three stated structural conditions are accepted.  Combining this theorem
with the source-action proof gives the chain

```text
Q clock retention 1/Q
  + Hodge-channel exchange symmetry
  + normalized baseline
      => unique constitutive metric M
      => det M = S_Q
      => stationary gravity response = 1/S_Q.
```

The surviving physical identification is explicit: the gravitational
prepotential doublet must be the Hodge-related clock pair, and `1/Q` must be
its retained even-channel stiffness.  That identification is not established
by the matrix theorem itself.

## Kernel artifact

- `GravityScreening/ClockForcesConstitutive.lean`
