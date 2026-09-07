# From the screened equilibrium mode to Einstein gravity

## Result

The nonlinear part of the gravity problem is smaller than it first appeared.
PDT does not have to construct a new nonlinear theory of a spin-two field if
its settled geometric mode is already the ordinary massless Pauli--Fierz
field. Two established results then do most of the dynamical work:

1. linearized Einstein gravity in four dimensions has a local formulation in
   terms of two symmetric prepotentials that rotate into each other under
   gravitational electric--magnetic duality;
2. consistent local self-coupling of a massless spin-two field to its conserved
   stress tensor generates the nonlinear Einstein interactions.

The PDT-specific calculation supplies the normalization of that field. Let

```text
S_Q = 1-lambda4^2,
lambda4 = 1-1/Q.
```

The clock-to-Hodge calculation fixes one chiral stiffness to `1/Q`. Requiring
the Hodge split to preserve the orientation-blind baseline fixes the other to
`2-1/Q`. Their product is exactly `S_Q`, and eliminating the unresolved member
of the doubled pair leaves the geometric stiffness

```text
M_P,Q^2 = S_Q M_P,0^2.
```

If the remaining geometric mode is the Pauli--Fierz graviton and ordinary
stress-energy sources it, its linear response is

```text
G_Q = G_0/S_Q.
```

The spin-two bootstrap then carries the same normalization into the Einstein
theory. It does not determine `S_Q`; that is precisely the arithmetic input
PDT contributes.

## The bridge as one chain

The proposed route is now

```text
quartic modular displacement log Q
  -> core weight 1/Q
  -> mean-preserving Hodge pair (2-1/Q, 1/Q)
  -> orientation-even stiffness S_Q
  -> ordinary Pauli--Fierz field with Planck square S_Q M_P,0^2
  -> consistent self-coupling
  -> Einstein gravity with G_Q=G_0/S_Q.
```

Every algebraic arrow through the stiffness calculation is exact once the Q
response is placed on the gravitational pair. The last arrow is a standard
field-theory result once its hypotheses are met. The source literature fixes
what the relevant frame means: ordinary stress-energy is the electric source,
while an independent magnetic stress tensor would carry NUT charge. The
theory-specific joining arrow still to establish is that the quartic Hodge
pair is the physical gravitational prepotential pair and respects that source
split.

This is a substantial reduction of the open problem. The task is no longer to
invent or guess a nonlinear completion. It is to establish one physical
identification at the quadratic level.

## Why the doubled mode is compatible with a graviton

Henneaux and Teitelboim showed that four-dimensional linearized Einstein
gravity can be written with two symmetric prepotentials. The two fields are
canonical partners and gravitational duality rotates them into one another.
Bunster, Henneaux and Hoertner later expressed the equations as twisted
self-duality relations between the curvatures of two metrics obtained from
those prepotentials.

This established architecture answers a structural objection to the PDT
equilibrium model: retaining a geometric mode and a dual information mode
does not automatically add a second physical graviton. In the standard
duality formulation the doubled variables describe the same two helicities
of one massless spin-two field, with constraints and gauge redundancies
removing the apparent doubling.

The existing PDT audit proved the corresponding internal consistency result.
After its determinant-one normalization, the quartic constitutive block is a
symplectic squeeze of the ordinary prepotential Hamiltonian. For constant
`lambda4`, the source-free linear theory is canonically equivalent to ordinary
linearized gravity and retains its light cone and gauge structure. The common
factor `sqrt(S_Q)` cancels from the vacuum equations but survives in the
response to an independently normalized matter source. Eliminating the dual
coordinate supplies the second `sqrt(S_Q)`, giving total stiffness `S_Q`.

Thus the candidate free field is already in the correct universality class.
What makes the squeeze physical rather than a change of variables is the
matter source: matter must select one metric member before the canonical
transformation. The standard electric-source sector does exactly that.

## The electric source frame

Barnich and Troessaert give the duality-symmetric spin-two field two conserved
source tensors,

```text
T_a = (T, Theta),
S_source = (1/2) integral h^a_mu_nu T_a^mu_nu.
```

`T` is the ordinary electric stress-energy tensor. `Theta` is its magnetic
counterpart; a point source `(M,N)` produces electric mass `M` and magnetic or
NUT mass `N`. The ordinary matter sector is therefore the definite source
choice

```text
T_a = (T,0).
```

This is exactly the source vector used in the kernel-checked response model.
If the Q block can be inserted without changing the source constraints, then
for the constitutive block

```text
K = [[1,       -lambda4],
     [-lambda4, 1      ]],
```

the sourced equations are

```text
K (X,Y)^T = (T,0)^T.
```

They give

```text
X = T/(1-lambda4^2),
Y = lambda4 T/(1-lambda4^2).
```

Equivalently, the electric source is the orientation-even combination of the
two chiral eigenchannels. It sees the average inverse stiffness

```text
(1/2)[1/(1+lambda4)+1/(1-lambda4)]
  = 1/(1-lambda4^2).
```

So no new source rule needs to be invented: ordinary matter has the electric
stress tensor, and a second direct source would mean an additional NUT-charged
matter sector. But this does not yet prove source compatibility. The response
model also gives a nonzero partner coordinate `Y`. The full constraint
calculation must show that this is the dual description of the same electric
field and carries zero independent magnetic surface charge, rather than an
induced NUT source. The source literature turns the old ambiguity into that
definite test.

## Why the nonlinear completion is inherited

A free massless spin-two field has a gauge symmetry required to remove
unphysical polarizations. Coupling the field to matter makes the field's own
stress-energy part of the source. Gauge consistency then requires adding the
field's self-coupling, whose new stress-energy must also be included. In a
first-order formulation this closes into the Einstein interaction rather than
an endless sequence of unrelated choices.

Deser's bootstrap result therefore has a direct consequence here. Once the
PDT-reduced field satisfies all of the following,

```text
one massless spin-two field,
ordinary linearized gauge symmetry,
local coupling to a conserved stress tensor,
universal self-coupling with no extra propagating mode,
```

the nonlinear completion is general relativity, with the strength of the
interaction set by the normalization of the quadratic action. Replacing the
baseline Planck square by `S_Q M_P,0^2` therefore replaces the baseline Newton
coupling by `G_0/S_Q` throughout the completed Einstein theory.

The bootstrap does not prove that the Q sector produces the required free
field or matter coupling. It says that, if the quadratic identification is
right, nonlinear Einstein gravity is no longer an independent conjectural
step.

There is a necessary ordering here. Deser and Seminara showed that the
electric--magnetic duality symmetry of the free spin-two theory does not
extend to the cubic Einstein interaction. The proposal therefore does not
keep the doubled duality symmetry as an exact nonlinear symmetry. The Q
response is used to fix the quadratic normalization, the magnetic coordinate
is eliminated in the electric source frame, and the resulting Pauli--Fierz
field is then bootstrapped. Nonlinear general relativity begins after the
duality-based matching has done its work.

## The meaning of equilibrium

The equilibrium language can now be stated without treating gravity as a
literal material gas. Before reduction, the doubled description carries a
geometric response and its Q-sector partner. The partner settles to the value
fixed by the sourced stationary equation. After that unresolved coordinate is
eliminated, the remaining metric disturbance has stiffness `S_Q` times the
baseline stiffness.

At long distances an observer therefore sees the ordinary massless graviton
and the ordinary Einstein field equations, but with a Newton coefficient that
contains the memory of how the Q channel was resolved. The graviton is the
propagating ripple of the settled geometry. The information-transfer process
is the proposed microscopic origin of its normalization, not an additional
long-range particle.

This also makes the relation to time precise. The same modular operation that
gives the phase `Q^(-it)` gives the core weight `1/Q`; gravitational Hodge
duality completes that one-sided weight into the pair whose equilibrium
response is `1/S_Q`. Time supplies the displacement, the four-dimensional
Hodge structure supplies the complementary channel, and the spin-two field
supplies the universal macroscopic dynamics.

## What has and has not been solved

The following pieces are exact or imported from established field theory:

- the quartic core weight is `1/Q`;
- its unique mean-preserving Hodge partner is `2-1/Q`;
- their product is `S_Q=(2Q-1)/Q^2`;
- the even inverse response is `1/S_Q`;
- the real doubled quadratic model has effective stiffness `S_Q`;
- its determinant-one shape is compatible with ordinary source-free
  linearized gravity;
- the consistent local self-coupling of the resulting massless spin-two field
  gives the Einstein nonlinearities.

The unresolved physical statement is now:

> The quartic modular-core mode furnishes one member of the physical
> gravitational duality pair, its mean-preserving completion furnishes the
> other, and the completed block preserves the ordinary `(T,0)` source
> constraints without generating an independent magnetic charge.

If this is derived from the horizon constraint, a Ward identity, or a
microscopic PDT action, the ordinary electric-source response and the
spin-two bootstrap close the gravity mechanism. If the Q mode acts on a
different pair, creates magnetic charge from ordinary matter, or leaves an
extra scalar or spin-two degree of freedom, the mechanism fails.

## The next decisive calculation

Work in the actual two-prepotential action for linearized gravity. Insert the
already fixed determinant-one Q constitutive matrix, retain the standard
symplectic form, and couple a conserved stress tensor to the electric metric
reconstructed from the first prepotential. Then verify together that

1. the standard source term is retained as `(T,0)` rather than transformed
   with the Q squeeze;
2. the second prepotential remains a dual description rather than an extra
   propagating graviton;
3. eliminating it yields the local Pauli--Fierz operator multiplied by
   `S_Q`;
4. the resulting source is the same conserved total stress tensor used in the
   spin-two bootstrap.

That calculation is the shortest remaining proof target. It tests the one
physical joining premise directly and hands any successful result to the
known Einstein bootstrap.

## Verification and sources

The exact coefficient and finite-mode source response are kernel checked in
`GravityScreening/ClockHodgeBridge.lean` and
`GravityScreening/Basic.lean`. The cited spin-two results supply field-theory
implications, not new arithmetic axioms in the Lean development.

- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Bunster, Henneaux and Hoertner, *Gravitational Electric-Magnetic Duality,
  Gauge Invariance and Twisted Self-Duality*:
  <https://arxiv.org/abs/1207.1840>.
- Deser, *Self-Interaction and Gauge Invariance*:
  <https://arxiv.org/abs/gr-qc/0411023>.
- Barnich and Troessaert, *Manifest spin 2 duality with electric and magnetic
  sources*: <https://arxiv.org/abs/0812.0552>.
- Deser and Seminara, *Free Spin 2 Duality Invariance Cannot be Extended to
  GR*: <https://arxiv.org/abs/hep-th/0503030>.
