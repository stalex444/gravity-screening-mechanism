# Information-geometric meaning of the quartic screening

## The exact reading

Let `g` denote a local geometric-scale coordinate and `tau` a quartic clock
coordinate on a two-parameter family of states or histories.  Normalize their
score vectors to unit Fisher length and suppose their score overlap is
`lambda4`.  Their local Fisher matrix is then

```text
I(g,tau) = [[1,       lambda4],
            [lambda4, 1      ]].
```

If the observer estimates `g` while `tau` remains an unobserved or nuisance
coordinate, the partial Fisher information for `g` is the Schur complement

```text
I(g | tau) = I_gg - I_g,tau I_tau,tau^(-1) I_tau,g
           = 1-lambda4^2.
```

The corresponding inverse-information bound is

```text
[I(g | tau)]^(-1) = 1/(1-lambda4^2).
```

This is exactly the algebraic pattern of the proposed gravity correction:

```text
Planck stiffness:  M_Pl,Q^2 / M_Pl,0^2 = 1-lambda4^2,
Newton response:   G_Q / G_0           = 1/(1-lambda4^2).
```

Information geometry therefore says that the quartic clock does not add an
arbitrary force.  Its overlap with the geometric-scale score makes part of the
raw geometric information redundant.  After the clock coordinate is accounted
for, only its orthogonal component remains available to stiffen the metric.
The inverse response consequently grows.

## Why this interpretation is useful

The limiting cases have immediate meanings:

```text
lambda4 = 0:  clock and geometry are Fisher-orthogonal; no screening.
lambda4 -> 1: their score directions coincide; partial geometric information
             collapses and the inverse response diverges.
```

The determinant `1-lambda4^2` is also the squared information area spanned by
the two normalized score directions.  Thus the coefficient measures independent
local distinguishability, while its reciprocal measures susceptibility after
the hidden direction is removed.

This also passes the field-normalization control.  Fisher information is a
metric on the statistical manifold, and the partial information is the metric
induced on the quotient by the clock direction.  A common change of coordinate
cannot create a physical relative coefficient.  What matters is the normalized
overlap between two distinct score directions.

## The decisive model to construct

The required physics is no longer merely “find a matrix with the right
determinant.”  Construct a specified family of PDT states or histories

```text
p(omega | g,tau)
```

with score functions

```text
L_g   = partial_g   log p,
L_tau = partial_tau log p,
```

and prove at the condensed equilibrium that

```text
E[L_g^2]     = 1,
E[L_tau^2]   = 1,
E[L_g L_tau] = lambda4.
```

The natural candidate is the existing quartic equilibrium/history process:
`g` perturbs geometric scale and `tau` perturbs one inverse Perron step.  If its
normalized score covariance is `lambda4`, ordinary information geometry forces
the screening coefficient.  No further choice of quadratic form is available.

For a noncommutative KMS-state construction, the same program requires choosing
and justifying a quantum Fisher metric.  The Bogoliubov-Kubo-Mori metric is the
natural candidate when the metric is obtained as the Hessian of equilibrium
relative entropy, but that choice and the cross-correlation still require a
derivation.  A classical probability model of Padovan/Schramm histories avoids
that additional metric-choice issue and is the cleaner first test.

## Present status

The Schur-complement theorem and all identities involving `lambda4` are exact.
PDT also has an existing Fisher-geometric layer.  What is not established is
the state family whose geometric and quartic-clock score overlap equals
`lambda4`, or the identification of its partial Fisher information with the
Einstein coefficient.  Those two statements are the physical bridge.

## Reference

J. Suzuki, "Nuisance parameter problem in quantum estimation theory: General
formulation and qubit examples," *Journal of Physics A* **53**, 264001 (2020),
<https://arxiv.org/abs/1905.04733>.  Equation (6) gives the partial Fisher
information as the Schur complement of the nuisance block.
