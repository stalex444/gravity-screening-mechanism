# Gaussian information geometry of the doubled TT response

## Result

Let

```text
C^T = C,        C^2 = I,
R(lambda) = I + lambda C,        |lambda| < 1.
```

Here `C` is the realified Hodge-chirality involution on the two physical
transverse-traceless coordinates and their two independent Hodge partners.
The four eigenvalues of `R(lambda)` are

```text
1 + lambda, 1 + lambda, 1 - lambda, 1 - lambda.
```

The centered Gaussian with quadratic exponent `-z^T R(lambda) z` has
unnormalized mass

```text
Z(lambda) = pi^2/(1-lambda^2).
```

Its response relative to the uncoupled Gaussian is therefore

```text
r(lambda) = Z(lambda)/Z(0) = 1/(1-lambda^2).
```

The Fisher--Rao metric of the zero-mean Gaussian family in the `lambda`
direction is

```text
F(lambda)
  = (1/2) Tr[(R(lambda)^(-1) C)^2]
  = 1/(1+lambda)^2 + 1/(1-lambda)^2
  = 2(1+lambda^2)/(1-lambda^2)^2.
```

Consequently the volume response and the local information curvature obey the
exact relation

```text
F = 4 r^2 - 2 r.
```

This is an invariant relation along the whole Hodge-symmetric Gaussian family,
not only an equality at the quartic value.

The trace formula is the standard Fisher metric on the positive-definite cone
of centered multivariate Gaussians. See Wells, Cook, Pine, and Robinson,
[Fisher--Rao distance on the covariance cone](https://arxiv.org/abs/2010.15861).
For the broader uniqueness of the Fisher--Rao metric on spaces of positive
probability densities, see Bauer, Bruveris, and Michor,
[Uniqueness of the Fisher--Rao metric on the space of smooth densities](https://arxiv.org/abs/1411.5577).

## Reverse classification

The response matrix is also recovered without assuming its displayed form.
Start with an arbitrary real four-by-four matrix `M` and impose:

1. `M` is self-adjoint;
2. `M` commutes with the simultaneous quarter-turn of the two TT pairs;
3. `M` commutes with realified chirality;
4. its mean eigenvalue is one; and
5. the selected minus-chiral plane has core weight `1/q`.

Lean proves that the first three conditions force

```text
M = a I + b C.
```

The fourth forces `a=1`. The fifth then forces

```text
b = 1 - 1/q = lambda4(q),
M = R(lambda4(q)).
```

Thus, inside the stated symmetry class, the quartic response matrix is unique.
The symmetry conditions determine the two-parameter Hodge family; baseline
normalization and the graph-selected core weight determine its point.

## What running the argument backwards reveals

The normalized Fisher curvature and Gaussian mass are both unchanged by
`lambda -> -lambda`. Lean proves:

```text
F(-lambda) = F(lambda).
```

On the full interval `|lambda|<1`, equality of Fisher curvature forces

```text
|lambda_1| = |lambda_2|.
```

After a branch orientation is chosen, for example `0 <= lambda < 1`, Fisher
curvature determines `lambda` uniquely. The scalar curvature therefore fixes
the magnitude of the Hodge coupling but cannot choose its sign.

The full cone of positive measures contains more information than that scalar.
The mass changes along the coupling path with signed velocity

```text
Z'(lambda) = 2 pi^2 lambda/(1-lambda^2)^2.
```

Lean proves that the mixed Fisher pairing of the coupling tangent with the
outward log-mass direction is exactly `Z'(lambda)`. It is odd under
`lambda -> -lambda`, and inside `|lambda|<1` its sign is exactly the sign of
`lambda`. At the quartic value `lambda4(Q)>0`, the pairing is strictly
positive.

Thus conditioning to probability one erases two related pieces of data: the
radial mass and the signed radial component of the chiral coupling path. The
full positive-measure geometry retains both. This does not select an arrow by
itself: the outward mass direction and the chirality labeling must have a
physical meaning. It does identify the precise geometric datum in which such
an orientation can live. Connecting that datum to the gravitational Hodge
branch and to a time-oriented reading remains open.

This is a useful separation. The normalized curvature is orientation-blind;
the unnormalized cone records orientation relative to its outward radial
direction, while the physical choice of that direction remains a
correspondence question.

For the parity-even gravity response, even that sign choice is unnecessary.
An orthogonal involution that reverses the Hodge-partner coordinates exchanges
the two chiral planes and conjugates `R(lambda)` to `R(-lambda)`.  Screening,
Gaussian mass, and Fisher curvature therefore factor through the quotient
`lambda ~ -lambda`.  The mixed radial--chiral term remains useful precisely as
an orientation-odd diagnostic.  See
`UNORIENTED_CLOCK_INFORMATION_GRAVITY.md`.

## Quartic values

For the positive root `Q` of `Q^4 = Q + 1`,

```text
Q        = 1.22074408460575947536...
lambda4  = 0.18082748660383556030...
S_Q      = 1-lambda4^2
         = 0.96730142008853967098...
r_Q      = 1/S_Q
         = 1.03380392009397374921...
F_Q      = 2.20739434061872154411...
Z'_Q     = 3.81478912795767227750...
```

The exact quartic Fisher value is

```text
F_Q = 2 Q^2 (2 Q^2 - 2 Q + 1)/(2 Q - 1)^2.
```

The normalized Gaussian response is about 3.38 percent above the uncoupled
value, while its local Fisher curvature is about 10.37 percent above the
uncoupled value `F(0)=2`.

## Positive measures and normalization

The unnormalized Gaussian mass `Z(lambda)` is a radial coordinate on the cone
of positive measures. The existing Fisher-cone decomposition proves that a
pure mass change contributes

```text
(dm)^2/m
```

orthogonally to normalized shape changes. Conditioning a positive measure to
total mass one discards this radial coordinate. This explains, in exact
information-geometric terms, why a probability-only model cannot retain the
absolute `pi^2/S_Q` mass, while the unnormalized Gaussian trace does.

This statement does not settle the remaining physical measure question. A
covariant field-theory derivation must still show that the gravitational
effective action uses this fixed-mode unnormalized determinant together with
the projective boundary density. The common Fourier-normalized continuum
measure gives a different absolute coefficient unless another factor
compensates it.

## Lean surface

The principal declarations are in
`GravityScreening/GaussianInformationGeometry.lean` and
`GravityScreening/HodgeGaussianUniqueness.lean`:

```text
realDoubledResponse_mul_inverse
doubledTTGaussianFisher_eq
doubledTTGaussianFisher_eq_responsePolynomial
doubledTTGaussianFisher_recovers_abs
quartic_fisher_fingerprint_unique
doubledTTGaussianMass_hasDerivAt
doubledTTGaussianMassVelocity_neg
doubledTTGaussianMassVelocity_pos_iff
doubledTTGaussian_fisherCone_mixed_eq_massVelocity
quarticDoubledTTGaussianMassVelocity_pos
doubledTTGaussian_fisherCone_radial_term
doubledResponse_eq_affineChirality_of_symmetries
realDoubledResponse_unique_of_symmetry_mean_core
symmetry_mean_core_forces_quarticFisher
realDoubledResponse_neg_conjugate
orientationEven_response_sign_quotient
quartic_orientation_sign_is_gauge
```

All statements are pure mathematics. Their use as a model of physical gravity
remains a correspondence claim until the covariant action and measure select
this response family.
