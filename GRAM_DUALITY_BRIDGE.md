# From the quartic defect channel to the duality response metric

## Result

The two occurrences of

```text
d = sqrt(1-lambda4^2)
```

in the candidate gravity action do not require two independent choices. They
arise from the same normalized two-channel geometry once the quartic Perron
residue is used as the channel overlap.

Let the reference channel and the defect-completed quartic channel be

```text
u = (1,0),
v = (-lambda,d).
```

Norm preservation requires

```text
|u|^2 = 1,
|v|^2 = lambda^2+d^2 = 1.
```

The positive value of `d` is then unique. Their overlap is

```text
<u,v> = -lambda.
```

Assemble them as the columns of

```text
B = [[1, -lambda],
     [0, d      ]].
```

The induced Gram matrix is exactly

```text
B^T B = [[1,       -lambda],
         [-lambda, 1      ]]
      = K(lambda).
```

Moreover,

```text
det B = d,
det K = (det B)^2 = d^2 = 1-lambda^2.
```

At `lambda=lambda4`, this is precisely the raw constitutive block used in the
first-order duality calculation. Its unit diagonal, off-diagonal coefficient,
square root and determinant are therefore one package:

- unit diagonal from normalized channels;
- `lambda4` from their signed overlap;
- `d` from the unique positive norm completion;
- `1-lambda4^2` from their squared oriented area.

This closes the normalization question inside the two-channel model. It does
not prove that the gravitational prepotentials carry this Gram metric.

## 1. Relation to the Julia completion

On the quartic Perron line, the inverse-step residual acts as the scalar
contraction `lambda4`. Its minimal real Julia completion is

```text
U = [[lambda4, d],
     [d,      -lambda4]],
```

with `U^T U=I`. Up to the sign convention that chooses the orientation of the
first channel, the vector `v=(-lambda4,d)` is the normalized defect completion
of the contracted residue. The Gram construction therefore uses the same
`d` already forced by the minimal unitary completion; it introduces no new
amplitude.

The full four-dimensional quartic residual is non-normal and is not a
contraction in every spectral direction. The construction applies only after
the already verified left/right Perron compression gives the scalar
coefficient `lambda4`. Treating the complete residual matrix as this Gram
overlap would be false.

## 2. Relation to the symplectic duality block

The raw Gram matrix is conformally symplectic:

```text
K^T Omega K = d^2 Omega.
```

Area normalization removes the conformal multiplier:

```text
Khat = K/d,
Khat^T Omega Khat = Omega.
```

Thus a single normalized channel pair produces both pieces found by the
linearized-gravity audit:

```text
K = d Khat.
```

`Khat` is the canonical, determinant-one shape. `d` is the oriented area of
the original normalized channel pair. In the first-order action, the shape
preserves the free propagation speed while the common scalar factor changes
the gravitational response to a fixed matter source.

This is the information-geometric content of the screening formula. The two
channels are individually normalized but correlated. Their Gram determinant
measures the squared area they span, or equivalently how much independent
two-channel resolution survives their overlap. The inverse response is
amplified by the reciprocal of that surviving area:

```text
surviving area squared = 1-lambda4^2,
source response        = 1/(1-lambda4^2).
```

No statistical Fisher metric is asserted here; the established object is a
Hilbert-space Gram metric.

## 3. What has actually been derived

The following chain is exact:

```text
quartic companion dynamics
  -> left/right Perron compression of I-M_Q^(-1)
  -> scalar overlap lambda4
  -> unique positive defect d
  -> normalized channel embedding B
  -> Gram response K=B^T B
  -> scale-shape split K=d Khat
  -> sourced inverse response 1/(1-lambda4^2).
```

Every arrow after the Perron compression is forced once one chooses the
minimal normalized two-channel completion. The remaining physical arrow is

```text
quartic channel Gram metric
  -> kinetic metric of the gravitational prepotential pair.
```

That is now the sole action-level premise in this route.

## 4. Reverse test and falsifiers

Running the construction backward is useful. A real symmetric two-channel
block with both channel norms fixed to one has the form

```text
[[1,b],
 [b,1]].
```

Its determinant is `1-b^2`. Requiring the PDT screening coefficient forces

```text
b^2=lambda4^2.
```

The Q-sector orientation fixes the remaining sign convention. Thus no
continuous deformation of the overlap survives.

The mechanism fails if any of the following occurs in the gravitational
derivation:

1. the two physical channels do not have the same fixed norm;
2. their normalized overlap is not the Perron residue;
3. the gravitational quadratic form is not the pullback norm `B^T B`;
4. additional propagating channels change the Schur complement;
5. the matter source does not select the metric member of the pair.

These are concrete action tests rather than requests for further numerical
coincidences.

## Kernel-checked statements

`GravityScreening/Basic.lean` verifies:

- the channel embedding has determinant `d`;
- its Gram matrix is exactly `K(lambda)` when `d^2=1-lambda^2`;
- the nonnegative defect coordinate is unique;
- `K` is conformally symplectic with multiplier `1-lambda^2`;
- `K/d` is symplectic and its twist squares to `-I`;
- the selected source response is `1/(1-lambda^2)`.
