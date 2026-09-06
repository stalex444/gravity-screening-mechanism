# Real doubled action target for quartic gravity screening

## Result

The exact Hodge response can be written as a real, positive quadratic action
without treating a genuinely real curvature two-form as though it had two
independent complex chiral components. The price is explicit: one must retain
a second real dual mode.

Let `J` be Hodge rotation on one real horizon pair, with

```text
J^2=-I,
J^T J=I.
```

For a sourced geometric mode `X` and a dual or auxiliary mode `Y`, consider

```text
L_lambda(X,Y;j)
  = (K0/2) [|X|^2+|Y|^2-2 lambda <X,JY>] - <j,X>.
```

Completing the square gives

```text
|X|^2+|Y|^2-2 lambda <X,JY>
  = |Y+lambda JX|^2+(1-lambda^2)|X|^2.
```

Eliminating `Y` therefore leaves

```text
L_eff(X;j)
  = (K0/2)(1-lambda^2)|X|^2-<j,X>,
```

and the response is

```text
X = j/[K0(1-lambda^2)].
```

At `lambda=lambda4`, this is exactly

```text
G_Q/G_0 = 1/(1-lambda4^2) = Q^2/(2Q-1).
```

This is the first candidate in the audit that supplies the complete gravity
factor through ordinary source response in a real quadratic model. It joins
the earlier Schur-complement and Hodge descriptions: the Hodge operator fixes
the oriented cross-coupling, while Gaussian elimination fixes the square and
minus sign.

Here “positive” refers to the reduced static or Euclidean mode Hessian. A full
Lorentzian gravitational action is constrained and need not be positive as a
spacetime functional. This calculation does not establish covariance,
ghost-freedom, or equivalence to Einstein gravity.

## 1. Why doubling resolves the immediate reality problem

On complexified Lorentzian two-forms, `C=-i star` is a Hermitian involution and
`I+lambda C` has weights `1+lambda` and `1-lambda`. But `C` does not preserve
the real two-forms: it contains the imaginary unit. If one simply restricts
the second or imaginary component to zero before varying, the chiral term
vanishes and the kinetic coefficient returns to one.

Realification retains both components. On pairs `(X,Y)`, define

```text
R(X,Y)=(-JY,JX).
```

Then `R` is a real symmetric involution:

```text
R^T=R,
R^2=I.
```

The doubled kinetic operator is `I+lambda R`; its two eigenweights are
`1+lambda` and `1-lambda`. Thus it is the real form of the complex chiral
operator, rather than a second numerical analogy. For `|lambda|<1` it is
positive, and integrating out `Y` produces its Schur complement
`1-lambda^2` on `X`.

The calculation also gives a falsifier. Enforcing `Y=0` as the Lorentzian
reality condition before variation makes the coupling identically zero. The
mechanism therefore requires either a genuine dual potential, a complex
connection whose reality conditions are imposed only on physical observables,
or another independently justified auxiliary curvature mode.

## 2. Why this is physically recognizable

Doubled-potential actions are established tools in duality-symmetric field
theory. Schwarz and Sen construct actions containing a potential and its dual
simultaneously, with their dual relation emerging from the equations of
motion. Henneaux and Teitelboim do the analogous thing for linearized gravity
in four dimensions using two prepotentials, and later work gives both a
duality-invariant bimetric formulation and a general twisted-self-duality
action.

Those results show that retaining a gravitational mode and a dual partner is
legitimate field-theory architecture. They do not supply the PDT coefficient,
the precise local cross-term above, or its nonlinear completion. Those remain
the theory-specific work. Their full gravitational actions also contain
constraints and derivative operators absent from this finite mode model, so
the analogy does not validate the proposed Hessian by itself.

## 3. Relation to the PDT two-scalar action

The deposited scalar action cannot be reinterpreted as this result without a
new coupling. Its fields `Phi` and `Psi` are scalars; `X` and `Y` here are
curvature, connection, or horizon-resolution modes. The smallest explicit
extension to test is therefore schematically

```text
S_grav,Q = (K0/2) integral [|X|^2+|Y|^2
                            -2 lambda4 <X,star Y>]
           + S_source[X],
```

with the duality constraint, gauge symmetry, normalization, and Lorentzian
reality conditions all stated. The coefficient must be derived from the
quartic sector—for example through the already exact Perron residue
`I-M_Q^(-1)`—rather than inserted merely because it gives the target.

`PERRON_HODGE_ACTION_BRIDGE.md` carries this coefficient step farther. Because
the residual is non-normal, its valid real readout uses its left/right Perron
pair; the normalized bilinear coefficient is then exactly `lambda4`. This
leaves the source-level problem of deriving that compression with unit
coupling, rather than the looser problem of finding the number.

This also separates the proposal from the standard real Holst map. The
screening comes from eliminating a doubled mode in a positive real kinetic
form. It does not require setting a real Barbero-Immirzi parameter equal to
an imaginary number.

## 4. What is proved and what remains open

The following statements are exact and kernel-checked in
`GravityScreening/Basic.lean`:

- the real doubled quadratic form completes to a positive square plus
  `(1-lambda^2)|X|^2`;
- eliminating the dual mode yields the screened stiffness;
- a source coupled to `X` receives the reciprocal response;
- at the quartic residue the response is exactly `Q^2/(2Q-1)`;
- removing the second mode before variation removes the effect.

The physical result is conditional on three still-open premises:

1. the gravitational or horizon theory contains the required independent
   dual mode;
2. its normalized cross-coupling is forced to be `lambda4` by the Q-sector
   dynamics;
3. eliminating or constraining that mode is compatible with gauge symmetry,
   Lorentzian reality, and the nonlinear gravitational constraints.

The next decisive calculation is no longer a search over entropy language.
It is to derive the quadratic fluctuation operator of a doubled curvature or
prepotential action coupled to the quartic field and inspect its Schur
complement. If the cross coefficient is not `lambda4`, if an independent
normalization survives, or if the reality constraints set the partner to
zero, this mechanism fails.

## References

- Schwarz and Sen, *Duality Symmetric Actions*:
  <https://arxiv.org/abs/hep-th/9304154>.
- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Bunster, Henneaux, and Hoertner, *Duality-invariant bimetric formulation of
  linearized gravity*: <https://arxiv.org/abs/1301.5496>.
- Bunster, Henneaux, and Hoertner, *Twisted Self-Duality for Linearized Gravity
  in D dimensions*: <https://arxiv.org/abs/1306.1092>.
