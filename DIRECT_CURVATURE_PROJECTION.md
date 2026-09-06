# The direct PDT curvature projection

## The short mechanism

The gravity formula does not need the full modular, Hodge, or
duality-prepotential machinery in order to state its essential physical
mechanism.  Those constructions test possible deeper realizations.  The
minimal proposal is an information-geometric projection.

Let `M0` be the unscreened Planck scale supplied by the ordinary `rho*Q`
exponent rule.  Let `u` be the normalized geometric channel and let `v_Q` be
the normalized escaped quartic-residue channel.  The exact Perron calculation
fixes their overlap to

```text
<u,v_Q> = lambda4 = 1-1/Q.
```

Remove from `u` the information carried by `v_Q`:

```text
u_physical = u - <u,v_Q> v_Q.
```

Because both channels are normalized,

```text
||u_physical||^2 = 1-|<u,v_Q>|^2
                 = 1-lambda4^2
                 = (2Q-1)/Q^2
                 = S_Q.
```

If the quadratic gravitational action measures this surviving curvature
norm, then

```text
S_grav^(2) = (M0^2 S_Q / 2) <h,E h> + <h,T>,
```

where `E` is the ordinary linearized Einstein operator.  Consequently,

```text
M_Pl^2 = S_Q M0^2,
G_eff  = G0/S_Q.
```

This is exactly the direction and power in the deposited PDT gravity formula:
the Planck mass receives `sqrt(S_Q)`, while Newton's coupling receives the
reciprocal `1/S_Q`.

## What the ordinary PDT Lagrangian does

The existing two-scalar potential still has a clear role.  Its arithmetic
coefficients describe the two sectors and their portal, and its vacuum
structure is intended to select the classical three-dimensional branch.  It
does not itself generate the screening at tree level about that branch.

At `(phi,chi)=(v,0)` the mixed potential Hessian is

```text
d^2 V/(d phi d chi) = 4*kappa*phi*chi = 0,
```

and the filed nonminimal curvature coefficient `xi*phi^2` is independent of
`chi`.  Integrating out `chi` therefore cannot multiply the Einstein term by
`1-lambda4^2` at tree level.  This exact no-go is recorded in
`CURRENT_ACTION_AUDIT.md`.

The clean division of labor is therefore:

```text
rho*Q exponent grammar  -> unscreened gravitational scale M0
two-scalar portal       -> sector relation and classical-branch selection
Q Perron residue        -> normalized overlap lambda4
curvature projection    -> surviving norm S_Q=1-lambda4^2
inverse response        -> G_eff=G0/S_Q.
```

The deposited portal coefficient `kappa=(Q/rho)^2` does not enter the final
screening normalization.  Reusing it there would give the wrong exact factor.

## Why gravity is selected

The projection acts on the geometric channel itself.  Gravity is read from
the inverse of that channel's kinetic norm, whereas gauge and matter fields
propagate within the resulting geometry.  This gives a concise reason for the
selectivity asserted in the gravity paper: the common `rho*Q` ruler remains
unchanged for nongravitational quantities, while the quantity that defines
curvature must resolve how much of the quartic channel fails to remain in the
classical record.

This is a physical identification, not yet a theorem of the filed action.  Its
single additional premise is:

> The physical curvature norm is the orthogonal complement of the normalized
> quartic Perron-residue channel.

Once that premise is adopted, the coefficient, its sign, its square, and its
placement in `G` are forced.  There is no adjustable mixing angle.

## Relation to the longer audits

The longer constructions answer questions beyond the minimal calculation:

- the Hodge analysis asks whether the projection has a specifically
  Lorentzian chiral realization;
- the doubled-action analysis asks whether it can be written as a local
  gauge-consistent field theory;
- the modular analysis asks whether the quartic clock can be embedded in a
  horizon algebra;
- the Immirzi audit asks whether the same geometry appears in connection
  variables.

None of those is required to state the direct linear-response mechanism.
They become relevant if the goal is a nonlinear microscopic completion.

## What would prove or refute the bridge

The next decisive calculation is much smaller than a full theory of quantum
gravity.  Starting from a microscopic PDT geometry, compute the quadratic
norm of its metric or curvature perturbation after restricting to the
classical record.  The mechanism succeeds if the restriction is the
orthogonal projector away from the Perron residue and its normalized overlap
is `lambda4`.

It fails if the restricted curvature norm is unchanged, if the overlap is a
different invariant, or if the restriction is not orthogonal and introduces
another scale.  The standard two-scalar portal by itself gives the first of
these failure cases; the exact Q-channel Gram construction gives the required
projector geometry conditionally.

## Kernel check

`GravityScreening.projectionResidual_normSq` proves in Lean that the squared
norm of the projected channel is exactly `1-lambda4^2`, assuming only the
normalized defect identity `d^2=1-lambda4^2`.
