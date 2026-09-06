# The decisive action target

## The shortest statement

The current gravity problem no longer requires choosing among many possible
screening mechanisms.  It reduces to one source-level question:

> Does the coefficient of the induced Einstein term use the quadratic trace
> norm of the normalized quartic time response?

In formulas, the target action is

```text
S_EH,Q = integral sqrt(-g)
         [(xi/2) phi^2 B(e0+lambda4 et, e0+lambda4 et) R[g]],
```

where the internal quartic trace form satisfies

```text
B(e0,e0)=+1,
B(et,et)=-1,
B(e0,et)=0.
```

It then follows without another parameter that

```text
B(e0+lambda4 et,e0+lambda4 et)=1-lambda4^2.
```

The constant internal trace form supplies the coefficient; the spacetime
metric remains the dynamical field supplying `R[g]`.

## Why the coefficient is forced within this action class

Let the most general quadratic response on the normalized background/time
plane be

```text
F(x,t)=A x^2+2B x t+C t^2.
```

Three geometric conditions determine it:

1. `F(1,0)=1`: the residue-free background has unit stiffness;
2. `F(1,t)=F(1,-t)`: reversing the time orientation cannot change the scalar
   Einstein coefficient;
3. `F(1,1)=0`: the normalized unit time displacement reaches the null boundary
   of the Lorentzian trace plane.

They force `A=1`, `B=0`, and `C=-1`, hence

```text
F(1,lambda4)=1-lambda4^2.
```

The Lean theorem `quadraticInducedPlanckSq_forced` now proves this directly at
the level of the induced Planck coefficient.  This is stronger than noticing
that the desired expression can be written as a determinant: among quadratic,
orientation-even responses with the stated normalization and null boundary,
there is no alternative coefficient.

## Conditional end-to-end theorem

The Lean theorem `conditional_pdt_quartic_planck_chain` combines:

```text
M_Pl,0/m_e = (rho Q)^112/pi^2,
M_Pl,0^2   = (4pi/3)v^2,
S_Q        = 1-lambda4^2 = (2Q-1)/Q^2
```

and concludes

```text
M_Pl,Q^2 = [(2Q-1)/Q^2] M_Pl,0^2.
```

The first two relations remain explicit hypotheses.  The theorem makes clear
that no numerical fitting occurs after those hypotheses are supplied.

## The remaining physical derivation

The trace form, the normalized time observer, the unique quadratic law, and
the conditional Planck chain are mathematical facts.  What is still missing
is a derivation of the displayed trace-weighted Einstein term from deeper PDT
dynamics.

The most direct route is to start from the two-scalar induced-gravity action
and show that integrating or tracing over the fixed quartic internal response
replaces

```text
(xi/2) phi^2 R[g]
```

by

```text
(xi/2) phi^2 Tr(a_Q^2) R[g].
```

A successful derivation must explain why the gravitational coefficient uses
the untwisted trace square.  A positive Hermitian norm would instead give
`1+lambda4^2`, and the filed scalar portal gives zero kinetic mixing at the
selected vacuum.  Those alternatives are already distinguished mathematically.

## What would make this a major result

The numerical chain shows that the exact quartic coefficient changes a
`+1463 sigma` unscreened discrepancy into a `+1.30 sigma` screened residual.
That makes the source-level trace coupling a high-value target.  Deriving that
coupling from the action would connect four pieces in one calculation:

- the `rho Q` baseline hierarchy;
- the conformal scalar condensate;
- the quartic timelike trace direction;
- the observed Newton scale.

Failure is equally crisp.  The mechanism fails if the derived Einstein
coefficient uses the Hermitian trace, a higher power of the trace invariant,
the scalar portal coefficient, or any value other than the normalized
untwisted quadratic response.
