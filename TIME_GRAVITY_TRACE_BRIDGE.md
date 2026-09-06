# The time-gravity trace bridge

## The exact coincidence

The quartic time construction and the gravity-screening calculation use the
same direction in the genuine trace geometry.

The chosen time observer is

```text
u = 4Q-3Q^2,
Tr(u^2) = -36.
```

The negative unit axis in the screening calculation is therefore simply

```text
et = u/6,
Tr(et^2) = -1.
```

The normalized identity background is

```text
e0 = 1/2,
Tr(e0^2) = +1,
Tr(e0*et) = 0.
```

Let the independently derived quartic Perron residue be

```text
lambda4 = 1-1/Q.
```

Then the arithmetic response

```text
a_Q = e0 + lambda4*et
    = 1/2 + (lambda4/6)(4Q-3Q^2)
```

has the exact trace square

```text
Tr(a_Q^2)
  = Tr(e0^2) + 2 lambda4 Tr(e0*et) + lambda4^2 Tr(et^2)
  = 1-lambda4^2.
```

Thus the gravity screening factor is exactly the Lorentzian trace norm of a
unit background displaced by the quartic residue along the same timelike axis
used to construct the clock and chronological cone.

The difference-of-squares step is a general feature of a normalized
Lorentzian pair.  The quartic content is that the genuine field trace supplies
the `(3,1)` geometry and the existing time construction supplies this explicit
axis, while the independently derived Perron calculation supplies the fixed
coefficient `lambda4`.  This is a compatibility result and a candidate
mechanism, not a second independent numerical prediction.

## What becomes simpler

This formula needs no auxiliary Hamiltonian, determinant, or fitted mixing
matrix.  The three ingredients already existed separately:

1. the quartic trace form has signature `(3,1)`;
2. the time construction uses `u=4Q-3Q^2` with square `-36`;
3. the quartic inverse-step residue is `lambda4=1-1/Q`.

Normalizing the first two ingredients and combining them with the third gives
the screening coefficient in one line.  The minus sign is the timelike sign.
The square appears because the Einstein kinetic coefficient is quadratic.

This also clarifies the gravity paper's statement that the Q sector screens
against itself.  In this realization, its contribution is literally the
negative term `-lambda4^2` in the spacetime trace norm.

## Why the quadratic form is selected

Consider the most general quadratic scalar on the plane spanned by a
background coordinate `x` and a time coordinate `t`:

```text
F(x,t) = A x^2 + 2B x t + C t^2.
```

Impose three geometric conditions on the normalized-background slice:

1. `F(1,0)=1`: the unscreened background fixes the normalization;
2. `F(1,t)=F(1,-t)`: reversing time orientation does not change the
   gravitational strength;
3. `F(1,1)=0`: equal unit background and time components form a null
   direction.

The first condition forces `A=1`, the second forces `B=0`, and the third
forces `C=-1`.  Therefore

```text
F(1,t)=1-t^2
```

is the unique quadratic response under these conditions.  Substituting the
independently fixed `t=lambda4` gives the PDT screening factor.  This does not
prove that the physical Einstein coefficient obeys the three conditions, but
it shows that once gravity reads this Lorentzian background/time plane, the
functional form is no longer adjustable.

## Minimal action-level statement

Let `M0` be the unscreened Planck scale supplied by the ordinary PDT ruler.  A
minimal generally covariant effective term using this arithmetic background is

```text
L_EH,Q = (M0^2/2) Tr(a_Q^2) R
       = (M0^2/2) (1-lambda4^2) R.
```

It follows algebraically that

```text
M_Pl,Q^2 = (1-lambda4^2) M0^2,
G_Q      = G0/(1-lambda4^2).
```

Because `a_Q` is a fixed dimensionless arithmetic background in this effective
description, this insertion adds no propagating scalar and no fifth force.

## Honest boundary

The trace identity is exact mathematics.  The prior quartic time work proves
the observer geometry for the chosen `u`, but explicitly does not prove that
this observer is uniquely selected by arithmetic or that the trace form is the
physical spacetime metric.

One physical premise therefore remains:

> The coefficient of the Einstein curvature term is the quartic trace norm of
> the response `a_Q=1/2+(lambda4/6)u`.

The displayed effective action implements that premise consistently; it does
not derive it from the filed two-scalar action.  The filed scalar portal is
diagonal in the relevant curvature channel at the selected vacuum and cannot
produce the factor at tree level.

## Falsifiers

This bridge fails as a physical mechanism if a microscopic PDT gravity action
does any of the following:

- couples curvature to a different quartic direction;
- uses the positive conjugation-twisted norm `1+lambda4^2`;
- makes the response coefficient different from `lambda4`;
- introduces additional terms that do not reduce to the single trace square.

## Verification

`GravityScreening/Basic.lean` proves:

- `normalized_even_null_quadratic_forced`;
- `quarticTimeObserver_sq`;
- `quarticTimeUnit_eq_normalized_observer`;
- `quarticTimeObserverResponse_eq`;
- `quarticTimeObserverResponse_sq`.

`verify.py` independently checks the same identities by exact arithmetic in
`Q[Q]/(Q^4-Q-1)`.
