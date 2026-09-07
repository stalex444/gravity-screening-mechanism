# The constraint-placement test for the gravity coefficient

## Result

The spin-two bootstrap clarifies how a screened Pauli--Fierz normalization
would become Einstein gravity, but the full sourced action imposes a stronger
placement test. A static mass enters linearized gravity through the lapse and
momentum constraints. A Q deformation placed only in the transverse
duality-prepotential Hamiltonian need not change those constraints and
therefore need not change Newton's static field.

The required statement is consequently

```text
S_PF,Q[h,n,n_i]
  = S_Q S_PF,0[h,n,n_i]
```

after the Q partner has been eliminated, including the lapse `n`, shift
`n_i`, and their source constraints. A result only of the form

```text
H_TT,Q = S_Q H_TT,0
```

is insufficient to derive the claimed Newton constant.

This is the sharpest current formulation of the remaining physics bridge.

## Why the constraints are decisive

The Hamiltonian Pauli--Fierz action contains the spatial metric, its momentum,
the linearized lapse, and the linearized shift:

```text
S_PF = integral [pi*h_dot - H_PF - n H_perp - n_i H^i].
```

Varying the lapse and shift gives the Hamiltonian and momentum constraints.
In the source-extended duality formulation of Barnich and Troessaert, the two
source tensors are

```text
T_a = (T,Theta),
```

and the sourced constraints have the form

```text
H^J_a,i    = H_a,i    - 16 pi G T^0_a,i,
H^J_a,perp = H_a,perp - 16 pi G T^0_a,0.
```

For a static point gravitational dyon with masses `(M,N)`, only the
constraints are affected. `M` is the electric mass and `N` is the magnetic or
NUT mass. In the ordinary sector `(M,0)`, the Newtonian Coulomb field is fixed
by the electric constraint.

This gives an exact placement consequence. If a proposed Q term changes only
the transverse Hamiltonian while leaving the coefficient of the sourced
constraint untouched, the static point-mass constraint still contains the
same `G`. The proposal may change gravitational waves or a constitutive
relation, but it has not derived a correction to Newton's constant.

## The sufficient completion

There is a clean sufficient route. Begin with the doubled Q response before
solving the gravitational constraints. Require its reduction to multiply the
entire quadratic gauge-invariant action by the same scalar:

```text
A_0 S_doubled[Z,n_a,n_a^i; T_a]
  -> A_0 S_Q S_PF[h,n,n_i] + (1/2) integral h_mu_nu T^mu_nu
```

in the ordinary source sector `T_a=(T,0)`. Then all three consequences follow
together:

```text
wave kinetic normalization       -> S_Q A_0,
Hamiltonian constraint response  -> 1/(S_Q A_0),
Newton coupling                  -> G_0/S_Q.
```

The already checked two-channel calculation proves that the physical-mode
Schur complement is `S_Q`. It does not prove that the lapse and shift sector
receives the same factor. That extension is the missing equality.

Equivalently, a covariant derivation may directly produce

```text
S_cov,Q = (S_Q M_P,0^2/2) integral sqrt(-g) R[g].
```

Its quadratic expansion automatically gives one uniformly normalized
Pauli--Fierz action, including the constraints. Deser's self-coupling
construction then supplies the nonlinear Einstein completion. The coefficient
still has to be derived before the constraints are solved; writing it in front
of `R` is the effective completion, not its microscopic explanation.

## Relation to the Hodge result

The Hodge calculation remains useful, but its job is now precise. It must do
more than change the two transverse chiral eigenvalues. It must arise from a
gauge-consistent parent response whose reduction changes the single covariant
spin-two normalization.

The mean-preserving chiral pair gives

```text
w_+ = 1+lambda4,
w_- = 1-lambda4,
w_+ w_- = S_Q.
```

This proves the only possible two-channel determinant and even inverse
response once one chiral weight is the modular-core value `1/Q`. The
constraint test asks whether that determinant is the Jacobian or Schur factor
of the full physical reduction, including the longitudinal and trace
components needed in the presence of sources.

The test has three possible outcomes:

1. **Uniform reduction.** The whole Pauli--Fierz action receives `S_Q`; the
   Newton formula and spin-two bootstrap close.
2. **Transverse-only reduction.** Gravitational waves are reparameterized or
   modified, but the Newtonian constraint retains its baseline coefficient;
   the proposed explanation of `G` fails.
3. **Mixed electric/magnetic constraints.** Ordinary `(T,0)` matter induces a
   nonzero magnetic surface charge; the mechanism predicts a NUT-like response
   and fails unless that charge is shown to be gauge or auxiliary.

## Why the exponential-area result is not enough

The core dual action scales the exponential area weight by `S_Q`. Multiplying
a Boltzmann weight by a constant adds `log S_Q` to its logarithm. By itself,
that is an additive entropy or normalization shift; it is not the same as
multiplying the coefficient of `A/(4G)` by `S_Q`.

This explains why the clock result and the Newton result must meet in a
kinetic or constraint response, rather than through a bare probability
normalization. The clock fixes the Q weight. The full parent action must show
how that weight changes the coefficient of the gravitational constraint.

## What is solved

The current work has solved all algebra after the placement premise:

```text
core weight 1/Q
  -> unique mean-preserving Hodge pair
  -> determinant S_Q
  -> inverse response 1/S_Q
  -> if full Pauli--Fierz normalization is S_Q,
     Einstein gravity has G_Q=G_0/S_Q.
```

What remains is one operator equality, rather than a search for another
number:

> Reducing the Q-completed sourced gravitational parent action produces
> `S_Q` times the complete Pauli--Fierz action, including its lapse and shift
> constraints, in the zero-magnetic-source sector.

## Verification and sources

`GravityScreening/Basic.lean` verifies the two-channel Schur complement,
source response, and quartic identity. `GravityScreening/HorizonConstraint.lean`
separately verifies how a coupling coefficient enters the scalar horizon
constraint. The gravitational placement statement above remains a physical
field-theory target.

- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Barnich and Troessaert, *Manifest spin 2 duality with electric and magnetic
  sources*: <https://arxiv.org/abs/0812.0552>.
- Deser, *Self-Interaction and Gauge Invariance*:
  <https://arxiv.org/abs/gr-qc/0411023>.

