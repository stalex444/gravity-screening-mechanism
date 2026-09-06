# Gravity and quantum norm as two readings of the same complex place

## Exact result

The quartic field's completed complex place carries two canonical real
quadratic forms.  For a complex coordinate `z`, they are

```text
intrinsic trace form:          g(z,z) = Tr_C/R(z^2),
conjugation-twisted form:      h(z,z) = Tr_C/R(z*conj(z)).
```

The second is positive and is the scalar form used in the Hilbert-space
reading of the Q-as-QM paper.  The first is indefinite: `g(1,1)=2` and
`g(i,i)=-2`.  This local hyperbolic plane is the complex-place contribution to
the quartic trace form's kernel-verified signature `(3,1)`.

Now insert the quartic Perron-residue coefficient into the affine local
response

```text
z_Q = 1 + i*lambda4,
lambda4 = 1-1/Q.
```

The two normalized forms give opposite signs:

```text
g(z_Q,z_Q)/g(1,1) = 1-lambda4^2,
h(z_Q,z_Q)/h(1,1) = 1+lambda4^2.
```

Therefore the PDT gravity coefficient has an exact home in the arithmetic
metric already associated with the quartic field:

```text
S_Q = 1-lambda4^2
    = normalized intrinsic trace of (1+i*lambda4).
```

No auxiliary determinant is required to obtain the minus sign.  It is the
timelike sign of the complex-place trace form.

## Global quartic realization

The same calculation can be made inside the full quartic power-basis trace
geometry.  Its genuine trace matrix is

```text
M = [[4,0,0,3],
     [0,0,3,4],
     [0,3,4,0],
     [3,4,0,3]].
```

The rational diagonalization already used to prove signature `(3,1)` contains
the two normalized, trace-orthogonal axes

```text
e0 = 1/2,
et = (4Q-3Q^2)/6.
```

Their exact pairings are

```text
Tr(e0^2)    = +1,
Tr(et^2)    = -1,
Tr(e0*et)   = 0.
```

Consequently the global quartic element

```text
a_Q = e0 + lambda4*et
```

has

```text
Tr(a_Q^2) = 1-lambda4^2.
```

This removes a possible objection to the local `1+i*lambda4` notation: the
screening response has an explicit representative in the quartic field's
power-basis geometry.  The timelike axis is the negative column in the
existing rational congruence that diagonalizes the genuine trace form.
It is also exactly one sixth of the observer vector already used in the
quartic time construction; see `TIME_GRAVITY_TRACE_BRIDGE.md`.

## Why this matters

This calculation joins two parts of PDT without identifying their quadratic
forms.

The Q-as-QM proposal uses conjugation because probabilities require a positive
norm.  Multiplying by the conjugate turns the imaginary contribution positive:

```text
(1+i*lambda4)(1-i*lambda4) = 1+lambda4^2.
```

The spacetime trace form is untwisted.  It multiplies the local element by
itself, so the same imaginary direction contributes negatively:

```text
(1+i*lambda4)^2
  = 1-lambda4^2 + 2i*lambda4,
Tr_C/R((1+i*lambda4)^2)/2 = 1-lambda4^2.
```

The imaginary unit is thus doing two different jobs through two standard
forms on the same place:

- with conjugation, it supplies the positive geometry of amplitudes;
- without conjugation, it supplies the negative direction of Lorentzian
  geometry.

The gravity screening factor is the exact difference between those readings
at the quartic residue amplitude.

## Direct gravitational chain

Let `M0` be the unscreened Planck scale supplied by the ordinary `rho*Q`
exponent rule.  If the gravitational kinetic coefficient reads the intrinsic
local trace response, then

```text
M_Pl^2 = M0^2 * g(z_Q,z_Q)/g(1,1)
       = M0^2 * (1-lambda4^2),

G_eff  = G0/(1-lambda4^2).
```

This is the exact correction and power used in the gravity paper.  The
exponent grammar supplies the large hierarchy; the local Lorentzian response
supplies the small Q correction.

## What is forced and what remains identified

The following are exact mathematics:

1. the quartic trace form has signature `(3,1)`;
2. its complex-place block has normalized form `x^2-y^2`;
3. the quartic inverse-step Perron residue is `lambda4=1-1/Q`;
4. the normalized intrinsic trace of `1+i*lambda4` is
   `1-lambda4^2=(2Q-1)/Q^2`;
5. the conjugation-twisted form of the same element is `1+lambda4^2`;
6. inside the affine family `1+i*c`, obtaining the gravity coefficient forces
   `|c|=lambda4`.
7. the full quartic trace matrix evaluates
   `1/2 + lambda4*(4Q-3Q^2)/6` to the same coefficient.

Two physical identifications remain:

1. the intrinsic quartic trace form is the kinetic metric read by physical
   spacetime curvature;
2. the curvature response occupies the local affine direction
   `1+i*lambda4`.

The first is PDT's existing metric identification, rather than a new
screening-specific assumption.  The second is the remaining bridge.  The
Perron calculation fixes the coefficient and the complex place fixes its
timelike direction, but a microscopic action has not yet been shown to place
that exact local element in the Einstein kinetic term.

The global realization narrows the second statement further: the candidate
direction is the normalized negative axis already present in the quartic
trace-form diagonalization.  What remains is to show that the curvature
response combines the normalized identity and that negative axis with the
Perron-residue coefficient.

## Relation to the projection account

The Euclidean projection account and the Lorentzian trace account produce the
same scalar for different reasons:

```text
Euclidean information geometry:  surviving orthogonal norm = 1-lambda4^2,
Lorentzian arithmetic geometry:   unit-plus-timelike norm   = 1-lambda4^2.
```

The trace-form route is closer to PDT's existing foundations because the
negative direction and the complex place are already kernel-verified.  The
projection route remains useful as the information-loss interpretation of the
same difference of squares.

## Falsifier

This route fails as a gravity mechanism if the physical curvature kinetic
form uses the positive conjugation twist, if it samples the full global trace
form without localizing to the complex block in the stated way, or if its
quartic response vector is not `1+i*lambda4`.  Those alternatives give a
different coefficient or require additional terms.

## Kernel artifact

`GravityScreening/Basic.lean` proves:

- `normalizedIntrinsicTrace_affine`;
- `normalizedHermitianTrace_affine`;
- `intrinsicTrace_eq_screening_iff`.
- `quarticSpaceUnit_sq`;
- `quarticTimeUnit_sq`;
- `quarticSpaceTime_orthogonal`;
- `quarticTraceResponse_sq`.

These theorems use Mathlib's genuine algebra trace from `C` to `R`, rather
than defining the desired signs by hand.
