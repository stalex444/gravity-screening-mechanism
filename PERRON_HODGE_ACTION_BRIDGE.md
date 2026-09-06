# Perron-to-Hodge coefficient bridge

## Result

The quartic Perron residue can supply the cross coefficient in the real
doubled Hodge action, but only through its left/right Perron pairing. A naive
one-field insertion is invalid because the residual operator is non-normal.

Let

```text
Delta_Q = I-M_Q^(-1),
r_Q = (1,Q^3,Q^2,Q)^T,
l_Q = (1,Q,Q^2,Q^3)^T.
```

The Lean kernel now proves

```text
Delta_Q r_Q     = lambda4 r_Q,
Delta_Q^T l_Q   = lambda4 l_Q,
l_Q^T r_Q       = 3Q+4,
Delta_Q^T Delta_Q != Delta_Q Delta_Q^T.
```

The left vector is the coordinate reversal of the right vector. Consequently
the scale-independent biorthogonal readout is

```text
c_Q
  = (l_Q^T Delta_Q r_Q)/(l_Q^T r_Q)
  = lambda4.
```

This makes the proposed action coefficient an eigenresponse of the founding
quartic transfer operator. It is no longer introduced as a decimal or as an
unexplained square root.

## 1. Why the naive operator insertion fails

`Delta_Q` is not symmetric and is not normal in the standard Euclidean metric.
Putting it into a conventional real quadratic form of one field silently
replaces it by its symmetric part, because the antisymmetric part contributes
nothing to `x^T Delta_Q x`. Equivalently, the Schur complement of a symmetric
block built from `Delta_Q` and `Delta_Q^T` is controlled by singular values,
not by the Perron eigenvalue alone.

Therefore the statement

```text
Delta_Q has eigenvalue lambda4,
so a quadratic action automatically contains lambda4
```

is false. The non-normality theorem is a permanent guard against that shortcut.

There is a stronger information-geometric obstruction. No nondegenerate
positive diagonal weight can make `Delta_Q` self-adjoint: the one-way
off-diagonal entry from the first coordinate to the second would force the
first metric weight to be zero. The kernel theorem
`quarticResidual_no_diagonal_symmetrizer` proves this from a single matrix
entry.

Thus a diagonal state-space metric can describe distances or fluctuations,
but it cannot turn the full directed quartic evolution into a reversible
equilibrium response. The left/right description is mathematically necessary
for this operator, not decorative. Only after projection to the one-dimensional
Perron line does the evolution become the scalar `lambda4`.

## 2. The biorthogonal repair

A non-normal transfer operator naturally carries right modes and dual left
modes. Compressing it to its simple Perron spectral line uses the rank-one
spectral projector

```text
P_Q = r_Q l_Q^T/(l_Q^T r_Q).
```

The normalization is invariant under rescaling either eigenvector, and

```text
P_Q Delta_Q P_Q = lambda4 P_Q.
```

Thus a forward quartic mode paired with its transpose-dynamics partner has
the exact scalar response `lambda4`. The fact that `l_Q` is the coordinate
reversal of `r_Q` is an exact algebraic symmetry. Calling it physical time
reversal would require an additional identification and is not asserted here.

Insert this compressed response into the real doubled horizon action:

```text
L_g(X,Y;j)
  = (K0/2)[|X|^2+|Y|^2-2 g c_Q <X,JY>] - <j,X>.
```

Eliminating `Y` gives

```text
L_eff(X;j)
  = (K0/2)[1-g^2 lambda4^2]|X|^2-<j,X>.
```

At normalized coupling `g=1`, its inverse response is the deposited factor

```text
G_Q/G_0 = 1/(1-lambda4^2).
```

This is a reduced response Hessian. Promoting it to a covariant Lorentzian
gravity action requires the correct derivative operators and constraints; the
finite-dimensional calculation alone does not address propagating ghosts or
nonlinear consistency.

## 3. What running the result backward fixes

Suppose the cross operator is the quartic Perron residue but an additional
dimensionless coupling `g` is allowed. Requiring its screened stiffness to
equal the deposited one gives

```text
1-g^2 lambda4^2 = 1-lambda4^2.
```

Because `lambda4` is nonzero, this forces

```text
g^2=1.
```

The gravity response cannot determine the orientation sign, since exchanging
the two chiralities sends `g` to `-g` and leaves the square unchanged. Once an
orientation convention chooses `g>=0`, the coefficient is uniquely `g=1`.
Both statements are kernel-checked as
`normalizedCoupling_magnitude_forced` and `normalizedCoupling_eq_one`.

This is useful but must be read in the right direction. The observed target
forces unit coupling inside this mechanism; it does not independently derive
why the action chooses this mechanism. A zero-parameter source derivation still
needs a symmetry, normalization, or representation theorem that puts
`P_Q Delta_Q P_Q` into the Hodge cross-block with unit coefficient.

## 4. The resulting division of labor

The candidate now has three sharply separated parts:

1. **Quartic information dynamics:** `Delta_Q` and its left/right Perron pair
   force the normalized coefficient `lambda4`.
2. **Four-dimensional geometry:** the local horizon Hodge pair supplies `J`
   and the real doubled chiral operator.
3. **Gravitational response:** eliminating the dual mode turns the coefficient
   into the Schur complement `1-lambda4^2`, whose inverse multiplies `G`.

The first and the algebra of the second and third parts are exact. The joining
map remains conditional. In the language of the gravity paper, the cubic
sector may supply the baseline geometric stiffness `K0`, while the quartic
sector supplies its biorthogonal screening response. The current two-scalar
Lagrangian contains no term that performs this join.

In information-geometric language, the proposed screen is therefore a
coarse-grained response of an irreversible transfer system. The forward mode
and its dual covector retain the exact Perron eigenresponse; eliminating the
dual geometric mode converts that directed amplitude into the positive
Schur-complement residue. This is a precise mathematical parallel. Identifying
that residue with horizon information density remains the physical premise.

The next decisive theorem is therefore:

> Derive a gauge-consistent doubled curvature or prepotential action whose
> cross-block is the biorthogonally normalized Perron residual
> `P_Q Delta_Q P_Q`, with no additional continuous coefficient.

This is narrower than the original question. Failure can occur in only a few
places: the physical modes may not project to the Perron line; the adjoint mode
may not be the relevant dual partner; gauge or reality constraints may remove
the cross-term; or an unfixed normalization `g` may survive.
