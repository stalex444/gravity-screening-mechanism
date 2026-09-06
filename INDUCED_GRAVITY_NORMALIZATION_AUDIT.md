# Induced-gravity normalization audit

## Finding

The available original and revised induced-gravity companion drafts contain
the same numerical normalization error.

The filed action is

```text
S_grav = integral sqrt(-g) (xi/2) phi^2 R
```

and the true vacuum is stated to be `phi=v`.  Comparing with the conventional
non-reduced Planck normalization

```text
S_EH = integral sqrt(-g) M_Pl^2/(16 pi) R
```

gives

```text
M_Pl^2 = 8 pi xi v^2.
```

At the draft's `xi=1/6`, this is

```text
M_Pl^2 = (4 pi/3) v^2,
M_Pl/v = sqrt(4 pi/3) = 2.046653415892977...
```

The drafts then set

```text
v    = 1.208e19 GeV,
M_Pl = 1.221e19 GeV.
```

Their ratio is only

```text
M_Pl/v = 1.0107615894...
```

and does not satisfy the displayed action normalization.  Substituting the
stated `v` into the stated equation gives

```text
M_Pl = 2.4723573264e19 GeV
```

rather than `1.221e19 GeV`.

## Correct values

If the unscreened equation is retained and `M_Pl=1.221e19 GeV` is used as the
target, the required condensate is

```text
v = M_Pl/sqrt(4 pi/3)
  = 5.9658366703e18 GeV.
```

For the quartic trace completion,

```text
M_Pl,Q^2 = (4 pi/3) v^2 (1-lambda4^2).
```

Holding the same measured target instead would require

```text
v = M_Pl/[sqrt(4 pi/3) sqrt(1-lambda4^2)]
  = 6.0658329602e18 GeV.
```

Conversely, retaining the draft's `v=1.208e19 GeV` and applying the screening
factor gives

```text
M_Pl,Q = 2.4316000946e19 GeV.
```

## Planck-mass conventions do not remove the discrepancy

For the reduced Planck mass, the same action would be written

```text
S_EH = integral sqrt(-g) Mbar_Pl^2/2 R,
```

so

```text
Mbar_Pl^2 = xi v^2,
Mbar_Pl   = v/sqrt(6) = 4.9316393488e18 GeV
```

at the stated `v`.  This is also neither of the draft's quoted Planck values.

A different field-VEV convention could introduce additional factors, but the
draft explicitly describes two real singlet scalars, writes the action above,
and sets the vacuum to `phi=v`.  Any alternative convention would need to be
stated and propagated through the action and vacuum equations.

## Conceptual normalization issue

The companion says its overall energy scale is fixed by the observed Planck
mass.  Choosing `v` from `M_Pl` and then recovering `M_Pl` from the induced
term is a calibration, not an independent derivation of Newton's constant.

To make the trace-screening completion predictive, the baseline condensate
must instead be fixed without using `G`.  For the deposited gravity paper's
unscreened ruler formula, the required identification would be

```text
8 pi xi v^2 = M_Pl,0^2,
M_Pl,0/m_e  = (rho Q)^112/pi^2.
```

Then the quartic trace response gives the distinct prediction

```text
M_Pl,Q/m_e
  = (rho Q)^112 sqrt(1-lambda4^2)/pi^2.
```

## Scope

This error concerns the absolute induced-gravity normalization.  It does not
alter the algebraic cancellation in the companion's dimensionless hierarchy
formula, where `M_Pl` cancels from both sides.  It also does not affect the
exact quartic trace identity.

## Verification

`GravityScreening/Basic.lean` proves the symbolic identities

- `inducedPlanckSq_conformal`;
- `traceInducedPlanckSq_conformal`.

The decimal evaluations above use direct substitution into those formulas.
