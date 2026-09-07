# The source-preserving frame of the quartic gravitational oscillation

## The problem it resolves

The Q/Hodge response uses two coupled channels.  In a duality-symmetric
description of linearized gravity, the two source slots are electric
stress-energy and magnetic stress-energy.  A magnetic point mass is a NUT
source.  Ordinary matter occupies the source doublet

```text
J=(T,0).
```

A generic change of the two-channel frame would turn this into `(T,Tmag)` and
would predict a magnetic source where none was supplied.  The gravitational
screening mechanism therefore needs more than the correct determinant.  It
needs a symplectic frame that both realizes the Q response and preserves the
electric source ray.

## The source-preserving factor

Let

```text
lambda = lambda4,
d^2    = 1-lambda^2,
r^2    = d.
```

The normalized Hodge/constitutive block is

```text
Khat = (1/d) [[1,       -lambda],
              [-lambda, 1      ]].
```

Define the lower-triangular frame

```text
T = [[r,           0],
     [-lambda/r, 1/r]].
```

The kernel-checked identities are

```text
det(T)=1,
T^T Omega T=Omega,
T^T T=Khat.
```

Thus `T` is a genuine canonical transformation and an exact Gram factor of
the normalized Q response.  Its inverse is

```text
T^(-1) = [[1/r,        0],
           [lambda/r, r]].
```

External sources transform as covectors.  Consequently

```text
T^(-T) (J,0) = (J/r,0).
```

The electric source changes normalization but acquires no magnetic component.
This is the key property absent from a generic symplectic square root.

The factor is also unique in its natural class.  Among positive,
determinant-one Gram factors of `Khat`, the requirement that the inverse
transpose preserve the electric source ray forces the upper-right entry to
vanish and determines every remaining entry to be exactly the displayed
lower-triangular frame.

## Where the full inverse factor comes from

In the canonical frame the common gravitational action scale is `d`.  The
source has magnitude `J/r`, so the canonical electric response is

```text
q_canonical = J/(r d).
```

Mapping the response back to the physical electric coordinate supplies the
second factor `1/r`:

```text
q_physical = (1/r) q_canonical
           = J/(r^2 d)
           = J/d^2
           = J/(1-lambda^2).
```

This gives the claimed Newton response without placing it into the answer by
hand.  One factor comes from the common stiffness; two half-frame factors come
from coupling and reading the fixed electric source.  Since `r^2=d`, the
three factors combine to `1/d^2`.

The back-transformed internal partner is

```text
q_partner = lambda J/(1-lambda^2).
```

It is a constitutive response of the coupled canonical pair.  It is not an
external magnetic source: the transformed source vector still has second
component zero, and the magnetic source equation remains zero exactly.

## Lapse and shift constraints

The same block acts pointwise on an arbitrary family of constraint labels.
The Lean development specializes the family to four labels: one Hamiltonian
constraint enforced by the lapse and three momentum constraints enforced by
the shift.  For every label `i`,

```text
electric_i - lambda magnetic_i = source_i,
magnetic_i - lambda electric_i = 0
```

is equivalent to

```text
(1-lambda^2) electric_i = source_i,
magnetic_i = lambda electric_i.
```

At the quartic value this is

```text
((2Q-1)/Q^2) electric_i = source_i.
```

Thus a uniform placement of the Q block across the doubled lapse-and-shift
constraint family has the correct coefficient and preserves a zero magnetic
source in all four channels.

## What is proved and what remains

The source-frame theorem is exact finite-dimensional symplectic and constraint
algebra.  It proves:

- the existence and uniqueness of the positive source-preserving canonical
  frame;
- exact preservation of the source doublet `(T,0)`;
- the full inverse response `1/(1-lambda4^2)`;
- uniform reduction for all lapse and shift constraint labels;
- the distinction between an internal partner response and an independent
  magnetic/NUT source.

The remaining field-theory task is to identify the abstract internal block
with the corresponding terms in the local Barnich--Troessaert doubled action,
including its spatial derivative maps.  Their formulation is directly suited
to this test because it retains two copies of the lapse and shift and couples
them to an electric/magnetic source doublet.  Once the same constant frame is
shown to act on their full variables, the constraint placement closes.

## Kernel artifacts and source

- `GravityScreening/SourcedConstraint.lean`
- `GravityScreening/ElectricSourceFrame.lean`
- Glenn Barnich and Cédric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>.

