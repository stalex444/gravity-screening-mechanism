# Uniform symplectic reduction of the quartic defect

## Result

The first-order reduction is no longer restricted to one numerical oscillator.
It holds on an arbitrary real field space `V` equipped with any symmetric
bilinear spatial form `B`.

For field `q`, velocity `v`, canonical partner `p`, common action scale `a`,
and determinant-one internal coefficients `c,s`, define

```text
L(q,v,p)
  = a { B(p,v)
        - 1/2 [c B(q,q) - 2s B(q,p) + c B(p,p)] },

c^2-s^2=1.
```

The momentum equation is solved by

```text
p=(v+s q)/c.
```

Substitution gives, for every symmetric `B`,

```text
L_reduced
  = a/(2c) [B(v,v)-B(q,q)+2s B(q,v)].
```

The last term is the polarization derivative of the quadratic form.  Indeed,
symmetry gives

```text
B(v,q)+B(q,v)=2B(q,v).
```

It is therefore a boundary term when `v=qdot` and `B` is time independent.
There is also an entirely algebraic version that does not discard a boundary:
pairing the `+s` and `-s` orientations cancels the mixed term exactly,

```text
(L_reduced(+s)+L_reduced(-s))/2
  = a/(2c) [B(v,v)-B(q,q)].
```

Now put

```text
d^2=1-lambda^2,
a=d,
c=1/d,
s=lambda/d.
```

Then `c^2-s^2=1` and `a/c=d^2=1-lambda^2`.  The complete
orientation-even propagating quadratic form therefore carries the coefficient

```text
S(lambda)=1-lambda^2.
```

At `lambda=lambda4=1-1/Q`, this is

```text
S_Q=(2Q-1)/Q^2.
```

## What this advances

The earlier proof checked the internal algebra on one Fourier/helicity mode.
The new theorem requires no basis, diagonalization, dimension, positivity, or
nondegeneracy assumption.  It therefore applies uniformly to every component
governed by the same symmetric bilinear operator.  The result establishes that
the determinant defect is a full propagating-sector normalization rather than
an accidental single-mode coefficient.

The theorem is also reversible.  If the internal shape is symplectic and the
common scale is the same determinant defect `d`, then the orientation-even
second-order coefficient is necessarily `d^2`.  No further scalar choice is
available in this class of doubled actions.

## Exact remaining boundary

The theorem does not yet identify `B` with the entire sourced Pauli--Fierz
constraint complex.  The standard prepotential action contains spatial
derivative operators and solves the vacuum constraints before the two
prepotentials appear.  The new result covers those propagating variables once
their kinetic and Hamiltonian forms have been put into the displayed common
bilinear normalization.

Newton's static field also depends on the lapse and shift constraints.  To
derive the physical Newton coefficient microscopically, the Q construction
must still be placed before those constraints are solved, or one must prove
that its uniform normalization descends from a covariant curvature action.
This is a narrower issue than mode dependence: all propagating modes are now
settled, while the nondynamical source constraints remain to be connected.

## Kernel artifact

`GravityScreening/SymplecticReduction.lean` proves:

- the displayed partner annihilates the formal momentum variation;
- reduction for an arbitrary symmetric bilinear operator;
- exact cancellation of the opposite-orientation mixed terms;
- the quartic defect specialization with coefficient `1-lambda^2`;
- the polarization identity identifying the mixed term as a boundary density.

All declarations compile without `sorry` and use only Mathlib's standard
logical axioms.

## Relation to linearized gravity

Henneaux and Teitelboim formulate free spin-two duality using two symmetric
prepotentials, an antisymmetric internal kinetic tensor, and a symmetric
Hamiltonian.  The theorem here isolates the general symplectic-reduction
mechanism that can act on that doubled pair.  The next calculation must retain
the lapse, shift, and ordinary electric stress-energy source rather than
starting only after the gravitational constraints have been solved.

- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Barnich and Troessaert, *Manifest spin 2 duality with electric and magnetic
  sources*: <https://arxiv.org/abs/0812.0552>.

