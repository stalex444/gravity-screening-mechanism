# Why the oscillatory and static gravitational sectors share one coefficient

## The apparent mismatch

The Q/Hodge construction first appears in a two-channel oscillatory block.
Newtonian gravity, however, is read from the stationary constraints of the
spin-two field.  If those were independently normalizable pieces of the
theory, a factor derived for gravitational waves would say nothing about the
force surrounding a stationary source.

For a massless spin-two field they are not independent.  Linearized
diffeomorphism invariance ties the wave equation, the lapse constraint, and
the shift constraints into one operator.

## The five coefficients

On flat spacetime, the standard local, two-derivative, symmetric rank-two
Euler operator can be written, up to conventions, as

```text
E_mn = a Box h_mn
     + b d_(m d^r h_n)r
     + c d_m d_n h
     + d eta_mn d^r d^s h_rs
     + e eta_mn Box h.
```

Parentheses include the factor `1/2`.  The identically vanishing divergence
required by linearized gauge invariance gives

```text
a + b/2 = 0,
b/2 + d = 0,
c + e   = 0.
```

Formal self-adjointness, which is required for this equation to arise from a
quadratic action, gives

```text
c = d.
```

The Lean theorem solves these four relations exactly:

```text
(a,b,c,d,e) = a (1,-2,1,1,-1).
```

There is only one independent coefficient.  It multiplies the entire
Pauli--Fierz operator.

## Consequence for the Q factor

Within the proved abstract doubled-mode reduction, the Q/Hodge construction
fixes the coefficient of every mode of the chosen symmetric spatial bilinear
form to

```text
S_Q = 1-lambda4^2 = (2Q-1)/Q^2.
```

If that abstract form is the propagating part of a local Q-completed spin-two
field, and the completion obeys the same linearized diffeomorphism identity
and comes from a quadratic action, the uniqueness theorem forces

```text
E_Q = S_Q E_PF.
```

The lapse and shift equations therefore inherit the same `S_Q`; they cannot
choose a different normalization while retaining those hypotheses.  Coupling
to a fixed ordinary source gives

```text
S_Q E_PF(h) = T,
```

so the field response is enhanced by

```text
1/S_Q = 1/(1-lambda4^2).
```

This closes the normalization-placement problem between an already identified
Q wave block and settled gravity at the linear level.  The source-preserving
symplectic frame proves that the transformation does not generate a
magnetic/NUT source.

## Scope

The kernel proves the coefficient uniqueness and its exact quartic
specialization.  It derives the three Ward relations from the actual
four-dimensional Fourier symbol of the five-term operator and derives the
self-adjointness relation from explicit symmetric test tensors.  The direct
Lorentzian version carries `diag(-1,1,1,1)` through momentum raising, traces,
divergences, and tensor pairings; it reaches the same unique coefficient
pattern without an analytic-continuation premise.

The doubled-operator construction now applies the same constant Q block to the
complete Pauli--Fierz operator.  Because the original operator obeys the Ward
identity, both completed channels do as well; the construction also preserves
the gauge kernel and source conservation.  A symmetric-bilinear action gives
these two equations as its first variations and has a nonnegative completed
square on any positive physical mode space.

The remaining field-theory task is the PDT identification: derive why the
second spin-two field and its `lambda4=1-1/Q` mixing arise from the Q
clock/information degree of freedom.  The present mathematics supplies a
consistent local linear realization and fixes its consequences once that
identification is made.

At nonlinear order, the Deser bootstrap explains how consistent
self-coupling of the linear massless spin-two field generates the Einstein
nonlinearity.  Applying that result to this construction requires the Q
reduction to occur before the bootstrap; it does not assert a nonlinear
electric-magnetic duality of full general relativity.

## Kernel artifact and primary references

- `GravityScreening/PauliFierzUniqueness.lean`
- `GravityScreening/PauliFierzSymbol.lean`
- `GravityScreening/LorentzPauliFierzSymbol.lean`
- `GravityScreening/DoubledSpinTwoOperator.lean`
- `GravityScreening/DoubledSpinTwoAction.lean`
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- S. Deser, *Self-Interaction and Gauge Invariance*:
  <https://arxiv.org/abs/gr-qc/0411023>.
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>.
