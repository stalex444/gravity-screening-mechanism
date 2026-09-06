# Lorentzian Hodge-pair mechanism for quartic gravity screening

## Standing relation and new localization

The paired Hodge operator algebra is already established in the PDT standing
record as F373, with the direct source-forcing obstructions recorded in F374.
This repository independently rechecks that algebra. The additions in the
present gravity-screening audit are:

1. the normalized-entropy no-go, which forces the coefficient away from global
   trace normalization;
2. the explicit full-bivector determinant control, which gives the wrong third
   power;
3. the local horizon binormal/area pair as the natural place where exactly one
   factor can occur;
4. the area-density interpretation that matches the square-root Planck-mass
   factor;
5. the orientation-even inverse-response identity that produces the required
   enhancement of `G` without a full determinant;
6. the proof that the earlier scalar Kraus split carries no state information.

## Result

The Hodge structure of four-dimensional spacetime supplies a nontrivial
operator whose paired determinant is the PDT gravity-screening coefficient and
whose orientation-even inverse response is its reciprocal.

On complexified Lorentzian two-forms,

```text
star^2 = -I.
```

Therefore, in notation aligned with F373,

```text
C = -i star
```

is an involution: `C^2=I`. Its two eigenspaces are the complex chiral halves
of the bivector space. Define the quartic response

```text
A_Q = I+lambda4 C = I-i lambda4 star.
```

On one Hodge-paired two-plane its two chiral eigenweights are

```text
1-lambda4,
1+lambda4.
```

Hence

```text
det(A_Q)
  = (1-lambda4)(1+lambda4)
  = 1-lambda4^2
  = (2Q-1)/Q^2.
```

This is a genuine operator action on chirality. It avoids the defect of the
bare scalar Kraus construction, whose branch flag is independent of the input
state.

## 1. Why four dimensions is selected

In `d` dimensions the Hodge star sends a two-form to a `(d-2)`-form:

```text
star : Lambda^2 -> Lambda^(d-2).
```

It acts on curvature two-forms without changing degree only when

```text
d-2=2,
```

which forces `d=4`. The same fact has a horizon interpretation. A local
codimension-two horizon has a normal binormal `B`; only in four dimensions is
`star B` again a two-form, namely the tangent area form. Thus

```text
span{B,star B}
```

is a canonical single Hodge pair attached to a local horizon section.

This gives a second independent four-dimensional selector alongside the
Ehrenfest marginality calculation. The quartic rung supplies `lambda4`, while
four-dimensional Hodge geometry supplies the only same-degree chiral pair on
which `I-i lambda4 star` can act.

## 2. Why the imaginary unit is load-bearing

Lorentzian Hodge duality on two-forms is a complex structure, not a real
involution:

```text
star^2=-I.
```

The factor `-i` changes this to

```text
(-i star)^2=I,
```

so that the two chiral eigenvalues become real signs `+1` and `-1`. The
response `I+lambda4 C=I-i lambda4 star` is then positive for
`0<lambda4<1`, with opposite real weights on the two chiral sectors. Without
the `i`, the determinant of
`I-lambda4 star` would be `1+lambda4^2`, the wrong sign.

This supplies a precise role for the imaginary unit in the candidate
mechanism: it converts Lorentzian duality into the real two-sided response
whose paired product gives the screening factor. Connecting that `i` to the
specific construction in the PDT quantum-mechanics paper remains a physical
and representational identification, not part of the determinant theorem.

## 3. The determinant power test

The full complexified bivector space in four dimensions has dimension six.
Each chiral eigenspace has dimension three. The determinant of `A_Q` over all
six bivectors is therefore

```text
(1-lambda4)^3(1+lambda4)^3
  = (1-lambda4^2)^3.
```

The deposited gravity formula contains one power, not three. A determinant
mechanism therefore cannot use the unnormalized determinant over the complete
curvature-bivector space.

The local horizon supplies the required localization: its normal binormal and
tangent area form make one Hodge pair. The determinant on that pair gives one
power of `1-lambda4^2`. A successful derivation must show that Jacobson's local
horizon variation reads this per-horizon-pair determinant, or an equivalently
normalized determinant, rather than the determinant over all three pairs.

This is a sharp falsifier for the determinant reading. A calculation that
necessarily takes the full six-dimensional determinant predicts the cube of
the observed factor and rejects that reading.

## 4. The stronger inverse-response route

There is a more direct way for a kinetic operator to produce Newton's
coupling. Treat the two chiral eigenweights

```text
k_+ = 1+lambda4,
k_- = 1-lambda4
```

as normalized kinetic stiffnesses. Their inverse responses are `1/k_+` and
`1/k_-`. An orientation-even source reads their normalized mean:

```text
(1/2)[1/(1+lambda4)+1/(1-lambda4)]
  = 1/(1-lambda4^2).
```

Equivalently, for `A=I+lambda4 C`,

```text
A^(-1) = (I-lambda4 C)/(1-lambda4^2).
```

Averaging this response with its orientation flip cancels the chiral term and
leaves

```text
response_even = I/(1-lambda4^2).
```

That is exactly the deposited enhancement `G_Q/G_0`. This route uses the
ordinary fact that a propagator or linear response is the inverse of its
kinetic stiffness. It also avoids the third-power problem: the same relative
response holds on every Hodge pair, so no determinant over all six bivectors
is taken.

The kernel theorem `orientationEven_chiralCompliance` checks the scalar
spectral identity. The remaining physical premise is focused: the
gravitational kinetic operator must actually contain the normalized affine
term `I+lambda4 C`, and the physical source must read its orientation-even
inverse. F374 establishes that the currently filed action does not derive this
term.

## 5. Relation to the horizon area-density route

The positive geometric mean of the two chiral weights is

```text
sqrt[(1-lambda4)(1+lambda4)]
  = sqrt(1-lambda4^2)
  = d_Q.
```

This is exactly the amplitude multiplying the Planck mass in the deposited
formula and the defect amplitude found by the unitary-completion calculation.
If `d_Q` is the inverse-length resolution of each tangent direction, the
microscopic cell density per horizon area scales by `d_Q^2`, while the area
quantum scales by `1/d_Q^2`. Jacobson's entropy density then scales by
`1-lambda4^2`, and `G` scales by its reciprocal.

The Hodge operator improves that route by supplying a non-scalar origin for
the two weights. The area-density amplitude is their geometric mean, not a
state-independent branch chosen by hand.

## 6. Relation to Barbero-Immirzi variables

There is a real structural parallel. The Holst/Ashtekar-Barbero formulation
uses the spacetime Hodge star and weights the self-dual and anti-self-dual
connections differently as a function of the Barbero-Immirzi parameter.

The present response should not yet be called the standard Holst operator. In
one common normalization a Lorentzian Holst map has the form

```text
H_gamma = I + (1/gamma) star.
```

For real `gamma`, its paired determinant is

```text
1+1/gamma^2,
```

whereas PDT requires `1-lambda4^2`. Matching the operators directly would
require

```text
1/gamma = -i lambda4,
gamma = i/lambda4,
```

which is imaginary and is not a derivation of a real Barbero-Immirzi value.
Different action conventions can move overall factors, but they cannot erase
the reality-condition issue.

The honest result is therefore narrower and more useful: PDT's screening
operator belongs to the same Hodge/chiral algebra as the Holst map, while its
coefficient and reality structure are not yet identified with the usual real
Barbero-Immirzi parameter. The appearance of `i` is essential and must be
tracked through Lorentzian reality conditions.

## 7. Formal verification and next theorem

`GravityScreening/Basic.lean` kernel-checks:

- `lorentzHodge_sq`: the model Hodge operator squares to `-I`;
- `chiralAreaResponse_eq`: `I-i l star` has weights `1+l,1-l`;
- `chiralAreaResponse_det`: its paired determinant is `1-l^2`;
- `quartic_chiralAreaResponse_det`: at `l=lambda4`, this is
  `(2Q-1)/Q^2` exactly;
- `fullBivector_chiralDet`: the full six-dimensional determinant would be the
  cube of the screening factor;
- `orientationEven_chiralCompliance`: the orientation-even mean inverse
  response is `1/(1-l^2)`;
- `quartic_orientationEven_chiralCompliance`: at the quartic residue this is
  `Q^2/(2Q-1)`, exactly the correction multiplying Newton's coupling.

The next physical theorem is now concrete:

> Derive `A_Q=I-i lambda4 star`, or a unitarily equivalent kinetic response,
> from the PDT action or observer algebra, impose its Lorentzian reality
> conditions, and prove that the physical horizon source reads its
> orientation-even inverse.

Success would supply a nontrivial Q-to-geometry operator, the correct inverse
factor in `G`, the Planck-mass square root, and a specifically
four-dimensional selector in one construction. Failure of the action to
generate this operator would close the Hodge route cleanly.

`CHIRAL_KINETIC_ACTION_TARGET.md` takes the first step through this remaining
reality problem. It realifies the complex chiral operator by retaining a
second dual mode, proves that eliminating that mode gives the exact screened
stiffness and reciprocal source response, and isolates the new source-level
question: whether the quartic dynamics forces this doubled coupling.

## References

- Mercuri, *Fermions in Ashtekar-Barbero Connections Formalism for Arbitrary
  Values of the Immirzi Parameter*: <https://arxiv.org/abs/gr-qc/0601013>.
- Rezende and Perez, *4d Lorentzian Holst action with topological terms*:
  <https://arxiv.org/abs/0902.3416>.
- de Cesare, Sakellariadou, and Vitale, *Noncommutative gravity with self-dual
  variables*: <https://arxiv.org/abs/1806.04666>.
