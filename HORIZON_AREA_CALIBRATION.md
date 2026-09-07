# Horizon area-density calibration after the trace no-go

## Result

The normalized-entropy calculation rules out putting the quartic survivor
solely in the normalization of the continuous-core trace. Running Jacobson's
relation backward identifies a different, geometrically natural location for
the same factor: the microscopic cell density per unit horizon area.

Let

```text
lambda4 = 1-1/Q,
d_Q = sqrt(1-lambda4^2),
S_Q = d_Q^2.
```

If the quartic defect complement rescales each inverse-length resolution
direction tangent to a local two-dimensional horizon section by `d_Q`, then
the number of microscopic cells counted per unit physical area is rescaled by

```text
dN_Q/dA = d_Q^2 (dN_0/dA) = S_Q (dN_0/dA).
```

For a fixed entropy per microscopic cell, the entropy density therefore obeys

```text
eta_Q
  = s_cell (dN_Q/dA)
  = S_Q eta_0.
```

Therefore the effective coefficient in Jacobson's area law is

```text
eta_Q = S_Q eta_0,
```

and the deposited correction `G_Q=G_0/S_Q` follows. This route survives state
normalization because `S_Q` acts on the physical density of horizon degrees of
freedom, rather than on the arbitrary normalization of the trace used to
represent a state.

## 1. Why the exponent is exactly two

A local horizon cross-section in four-dimensional spacetime is a
two-dimensional surface. Write two inverse-length tangent-resolution vectors
as `E_1,E_2`. An isotropic amplitude map

```text
E_a -> d_Q E_a
```

acts on their inverse-area bivector by

```text
E_1 wedge E_2 -> d_Q^2 E_1 wedge E_2.
```

Thus the same defect amplitude that appears linearly in the deposited Planck
mass appears quadratically in the density of horizon cells and in the inverse
Newton coupling. Equivalently, the fundamental area quantum grows by the
reciprocal factor. The powers are geometric consequences of a two-dimensional
area calibration:

```text
inverse length / mass:      d_Q,
cells per physical area:    d_Q^2=S_Q,
fundamental area per cell:  1/d_Q^2=1/S_Q,
Newton coupling:            1/d_Q^2=1/S_Q.
```

## 2. Reverse uniqueness

Suppose an isotropic scalar `d` acts on both inverse-length horizon directions
and is required to produce the same area-density response `s` for every local
area variation. Evaluating that requirement on one unit area gives

```text
d^2=s.
```

For the target `s=S_Q`, positivity therefore fixes

```text
d=sqrt(S_Q)=sqrt(1-lambda4^2).
```

This is exactly the complementary amplitude forced by the minimal unitary
completion of the quartic residue `lambda4`. The match is stronger than the
bare numerical identity: the unitary construction fixes an amplitude, and a
two-dimensional cell density requires the square of an inverse-length
amplitude.

The Lean theorems `defect_horizonAreaDensity_scale`,
`horizonAreaDensityScale_all_iff`, and
`defect_areaDensityMap_eq_densityScale` check these implications.

## 3. What this does and does not derive

The exact chain is

```text
quartic inverse-step residue lambda4
  -> positive unitary-defect amplitude d_Q
  -> isotropic two-dimensional inverse-resolution response d_Q
  -> horizon cell-density response d_Q^2=S_Q
  -> conditional Jacobson response G_Q=G_0/S_Q.
```

The first, third, and fourth arrows are exact once their stated inputs are
supplied. The second arrow remains the physical identification: the present
two-scalar action does not couple the quartic defect operator to the horizon
resolution or area-density operator.

This is still progress. The missing interaction is no longer “some entropy
effect.” It is a specific local map:

> Derive an isotropic Q-dependent response of the inverse-length horizon
> resolution whose positive amplitude is the defect of the quartic Perron
> residue.

## 4. The scalar-channel warning

The bare Kraus pair

```text
K_Q=lambda4 I,
K_G=d_Q I
```

has state-independent outcome weights. For every nonzero input vector `psi`,

```text
||K_Q psi||^2/||psi||^2=lambda4^2,
||K_G psi||^2/||psi||^2=d_Q^2.
```

Indeed its Stinespring vector factorizes:

```text
V psi
  = lambda4 psi tensor |Q> + d_Q psi tensor |G>
  = psi tensor (lambda4|Q>+d_Q|G>).
```

The flag therefore carries no information about `psi`. The scalar pair is a
correct norm decomposition and fixes the coefficient, but it is not by itself
an information-transfer mechanism. Calling it an information complement would
overstate the construction.

For a genuine information-geometric model, the Q and geometric branches must
act differently on the state, for example through distinct operators

```text
K_Q=lambda4 U_Q,
K_G=d_Q U_G,
```

with nontrivial relative action, or through an operator-valued defect. The
universal scalar weights can remain fixed while the relative branch action
carries the state dependence. Such a model must still reduce to the isotropic
area-density response above on the horizon tangent sector.

The standing F373 Hodge response supplies a better non-scalar candidate:
`I-i lambda4 star` acts with opposite weights on the two Lorentzian chiral
sectors, and its determinant on one paired mode is `1-lambda4^2`. The new
horizon localization explains why one paired determinant, rather than the
third power from the full six-dimensional bivector space, is the relevant
target. See `HODGE_CHIRAL_SCREENING.md`.

## 5. Decisive next test in the action

The filed scalar-curvature coefficient depends only on the cubic field:

```text
f(phi,chi)=xi phi^2.
```

Consequently its tree-level frame metric has no `phi-chi` cross term at the
selected axis vacuum, and the portal potential has no bilinear mixing there.
The current action cannot produce the required Q-dependent coframe map at
quadratic order.

A successful extension must derive, rather than insert, an inverse-area
calibration operator `E_Q` satisfying on the physical horizon sector

```text
det(E_Q)=S_Q
```

and, under isotropy and positivity,

```text
E_Q=d_Q I_2.
```

This is now the smallest concrete dynamical target. Any calculation yielding
`det(E_Q)=1`, `1-1/Q^2`, a scale-dependent function, anisotropic eigenvalues
without a horizon-symmetry reason, or additional unfixed parameters rejects
this minimal area-calibration route.

`JACOBSON_PLACEMENT_AUDIT.md` adds a complementary constraint: the physical
heat flux must retain its ordinary normalization.  Scaling both flux and cell
density by `S_Q` cancels the proposed correction; scaling the flux alone gives
the wrong direction.  The finite Stinespring model now proves that an
unscaled globally counted observable is compatible with an `S_Q`-screened
exterior branch.  Identifying that global observable with Jacobson's heat flux
and the retained branch with horizon cell density is the remaining physical
step.
