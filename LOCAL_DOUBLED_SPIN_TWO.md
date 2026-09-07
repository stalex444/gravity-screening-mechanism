# A local doubled spin-two equation with the quartic response

## Construction

Let `E_PF` denote the complete linear Pauli--Fierz differential operator,
including the components whose Hamiltonian decomposition gives the lapse and
shift constraints.  Introduce an ordinary metric perturbation `h` and one
partner perturbation `h_tilde`.  Let the constant quartic internal block act
on the output of `E_PF`:

```text
E_PF(h)       - lambda4 E_PF(h_tilde) = T,
E_PF(h_tilde) - lambda4 E_PF(h)       = 0.
```

The external source doublet is `(T,0)`.  The second equation has no magnetic
or NUT source.

Because `lambda4` is constant, this construction does not change the local
derivative order of `E_PF`.  It also preserves the linear gravitational Ward
identity: applying the divergence to either left-hand side gives zero whenever
the divergence annihilates `E_PF`.

## Exact reduction

The second equation gives an equality of operator outputs,

```text
E_PF(h_tilde) = lambda4 E_PF(h).
```

Substitution into the first equation gives

```text
(1-lambda4^2) E_PF(h) = T.
```

At the quartic root,

```text
1-lambda4^2 = (2Q-1)/Q^2.
```

Thus the complete linear field equation, rather than only its transverse wave
modes, carries the coefficient used in the deposited gravity formula.

## Why the gauge kernel is harmless

The Pauli--Fierz operator is not invertible before gauge fixing: pure-gauge
metric perturbations lie in its kernel.  The reduction above never cancels or
inverts `E_PF`.  It concludes only that the partner and ordinary fields have
the stated relation after applying `E_PF`.  They may still differ by an
arbitrary homogeneous or pure-gauge solution.

Lean also proves directly that adding independent kernel elements to `h` and
`h_tilde` leaves both doubled equations unchanged.  This is the appropriate
strength for a gravitational field equation.

## Action form

When `E_PF` is formally self-adjoint, the two equations are the Euler
equations of the quadratic action, up to conventional overall factors,

```text
S_Q[h,h_tilde]
  = (M0^2/4) [<h,E_PF h> + <h_tilde,E_PF h_tilde>
              - 2 lambda4 <h,E_PF h_tilde>]
    - (1/2)<h,T>.
```

The action statement is also kernel checked at the level of an arbitrary
symmetric bilinear form.  Exact finite-increment formulas show that the
coefficients linear in every field variation are precisely the displayed
electric and partner equations.

On the positive physical polarization space, its source-free quadratic form
has the completed-square identity

```text
2 Energy_Q
  = B(h-lambda4 h_tilde, h-lambda4 h_tilde)
    + (1-lambda4^2) B(h_tilde,h_tilde).
```

Since `Q>1` forces `0<lambda4<1`, both terms are nonnegative whenever the
underlying physical spin-two form is nonnegative.  Thus the minimal quartic
doubling adds no negative direction to the quadratic form on that physical
mode space.  This conditional positivity result is not by itself a complete
covariant ghost analysis.

The Pauli--Fierz symbol proof establishes the unique coefficient pattern
required for the operator.  The source-frame proof gives the equivalent
canonical variables in which `(T,0)` remains purely electric.

## What this advances

This construction supplies an explicit local linear spin-two completion with
all of the required algebraic properties:

- one quartic parameter `lambda4=1-1/Q`;
- the complete coefficient `S_Q=1-lambda4^2`;
- the standard gravitational Ward identity;
- gauge-kernel compatibility;
- source conservation;
- no external magnetic/NUT source;
- an action-level variational derivation;
- nonnegative doubled energy on the positive physical mode space;
- the inverse static response `1/S_Q`.

The open physical identification is narrower: why the partner field in this
minimal doubled action is the Q information/clock degree of freedom of PDT.
The arithmetic, source, and spin-two consequences of that identification are
now fixed.

## Kernel artifact

- `GravityScreening/DoubledSpinTwoOperator.lean`
- `GravityScreening/DoubledSpinTwoAction.lean`
