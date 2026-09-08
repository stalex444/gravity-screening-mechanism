# From the doubled action to the passive horizon splitter

## Result

Once the ordinary source fixes the positive, source-adapted channel frame, the
passive visible/hidden splitter is latent in the same positive two-channel
quadratic form that gives the gravity screening determinant.  It then requires
no independent mixing angle.

Write

```text
lambda = lambda4 = 1 - 1/Q,
S      = 1 - lambda^2,
d      = sqrt(S).
```

The doubled action has channel block

```text
K = [[1, -lambda],
     [-lambda, 1]].
```

Its positive, source-adapted Gram factor is

```text
C = [[1, -lambda],
     [0,       d]],

C^T C = K.
```

The columns of `C` are the ordinary source direction

```text
e = (1,0)
```

and the normalized quartic residue direction

```text
u = (-lambda,d).
```

Reverse Gram--Schmidt keeps `u` fixed and removes it from `e`:

```text
e - <e,u>u
  = (1-lambda^2, lambda*d)
  = d (d,lambda).
```

The normalized surviving direction is therefore

```text
v = (d,lambda).
```

Putting `v` and `u` together gives

```text
U = [[d,      -lambda],
     [lambda,       d]].
```

Lean proves

```text
U^T U = I,
det U = 1.
```

It also proves uniqueness: once the residue column `(-lambda,d)` is fixed,
orthogonality and positive orientation force the other column to be
`(d,lambda)`.  Thus the visible amplitude is `d=sqrt(S)`, the hidden amplitude
is `lambda`, and no further beam-splitter parameter remains.

## Why this matters

Previously the doubled action and the horizon erasure map appeared as two
compatible constructions carrying the same determinant.  This calculation
shows their exact mathematical relation:

```text
quartic core weight 1/Q
    -> exchange-symmetric normalized action block K_Q
quartic action block
    -> unique positive source-adapted Gram factor
    -> reverse Gram--Schmidt against the Q residue
    -> unique orientation-preserving passive splitter
    -> visible weight S and hidden weight lambda4^2.
```

The same `lambda4` that appears as the off-diagonal action overlap becomes the
hidden branch amplitude.  Its orthogonal complement becomes the exterior
gravitational amplitude.  The square and minus sign arise from orthogonal
projection and norm conservation rather than from a separately chosen
response formula.

## Why the source-adapted condition is necessary

The action matrix alone determines a Gram form, not a unique output frame. If
`O` is any orthogonal matrix, then

```text
(O C)^T (O C) = C^T C = K.
```

Lean proves this freedom for an arbitrary two by two orthogonal `O`.  Thus the
quadratic form alone cannot be advertised as selecting a physical scattering
angle.  What selects the displayed factor `C` is the additional physical
structure already present in the sourced theory: the first channel is the
ordinary matter-coupled direction, the factor is positive and triangular,
and the residue coordinate has positive orientation.  Lean proves that these
conditions uniquely fix `C`.

This distinction is useful.  It rules out an accidental inference from a
matrix factorization while showing exactly what a physical interface or
horizon calculation must establish: source adaptation of the Gram frame.

For the two TT polarizations, rotational covariance applies this same scalar
splitter to both plus and cross.  The existing TT rigidity theorem then gives
the exterior block

```text
sqrt(S_Q) I_2.
```

The existing same-metric theorem converts this canonical attenuation into

```text
G_Q = G_0/S_Q.
```

## The remaining physical premise

The new result closes the algebraic gap between the source-adapted doubled
action and the passive splitter.  It does not by itself prove that the quartic
Perron residue is the physical dual channel of gravity or that the physical
horizon interface selects the source-adapted Gram frame.  The remaining
premise can be stated in one line:

> The ordinary matter-coupled gravitational channel and the normalized
> quartic Perron-residue channel are the two Gram channels of the physical
> doubled spin-two quadratic form, with the ordinary source fixing its positive
> triangular frame.

If that identification holds, the splitter, its coefficient, its orientation,
and its action on both TT polarizations follow without another continuous
choice.

The mechanism fails if the physical quadratic form has a different overlap,
if the residue channel is not normalized in the TT energy inner product, or
if the observer restriction is not the orthogonal complement selected by the
positive action metric.

## Kernel artifact

`GravityScreening/ActionSplitterBridge.lean` proves:

- `passiveSplitter_residue_column`;
- `passiveSplitter_source_column`;
- `channelEmbedding_reverseGramSchmidt`;
- `passiveSplitter_orthogonal`;
- `passiveSplitter_det`;
- `positive_sourceAdapted_gramFactor_unique`;
- `passiveSplitter_unique`;
- `leftOrthogonal_gram_invariant`;
- `sourceAdaptedActionGram_yields_passiveSplitter`;
- `clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter`;
- `clockWeight_forced_splitter_retained_sq`.

The standalone file compiles under the repository's pinned Lean 4.31.0 and
uses no `sorry` or nonstandard axioms.
