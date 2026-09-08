# From the doubled action to the passive horizon splitter

## Result

Once the ordinary source fixes the positive source-preserving channel frame,
the passive visible/hidden splitter is latent in the same two-channel
quadratic form that gives the gravity screening determinant. No independent
continuous mixing angle remains.

Write

```text
lambda = lambda4 = 1 - 1/Q,
S      = 1 - lambda^2,
d      = sqrt(S).
```

The doubled action has internal channel block

```text
K = [[1, -lambda],
     [-lambda, 1]].
```

Its positive lower-triangular factor that preserves the ordinary source ray is

```text
A = [[d,       0],
     [-lambda, 1]],

A^T A = K.
```

Indeed, the inverse transpose sends a pure ordinary source to another pure
ordinary source:

```text
A^(-T) (j,0) = (j/d,0).
```

No external partner or magnetic source is generated.

This is the same frame already obtained in the constraint analysis. If `T_e`
is the determinant-one electric source frame and `r^2=d`, Lean proves

```text
A = r T_e.
```

The action factor and the constraint frame therefore differ only by the
overall action scale; they are not separate constructions.

The first column of `A` is already the normalized two-port source direction

```text
v = (d,-lambda),

||v||^2 = d^2+lambda^2 = 1.
```

Keep `v` fixed and orthogonalize the second column `(0,1)` against it:

```text
(0,1) - <v,(0,1)>v
  = (lambda*d,1-lambda^2)
  = d(lambda,d).
```

After normalization, the unique positive-orientation completion is therefore

```text
U = [[d,       lambda],
     [-lambda,      d]].
```

Lean proves

```text
U^T U = I,
det U = 1.
```

It also proves uniqueness: once the oriented source column `(d,-lambda)` is
fixed, orthogonality and determinant one force the other column to be
`(lambda,d)`. The visible amplitude has magnitude `d`, the hidden amplitude
has magnitude `lambda`, and their weights are `S` and `lambda^2`. Reversing
the hidden basis changes the sign but not either weight.

## Complete exact chain

The existing clock theorem and the new source-frame theorem now compose:

```text
quartic core weight 1/Q
    -> exchange-symmetric normalized action block K_Q
    -> unique positive source-preserving Gram factor A_Q
    -> Gram--Schmidt completion of its source column
    -> unique orientation-preserving passive splitter U_Q
    -> visible weight S_Q and hidden weight lambda4^2.
```

The same `lambda4` that appears as the off-diagonal action overlap becomes the
oriented hidden amplitude. Its orthogonal complement becomes the exterior
amplitude. The square and minus sign arise from the positive action metric,
orthogonality, and norm conservation.

For the two TT polarizations, a polarization-blind tensor product applies the
same scalar source split to plus and cross. The existing TT rigidity theorem
then gives the exterior block

```text
sqrt(S_Q) I_2.
```

The existing same-metric theorem converts this canonical attenuation into

```text
G_Q = G_0/S_Q.
```

## Exact limitation

A quadratic Gram matrix does not choose an output frame by itself. If `O` is
any orthogonal matrix, then

```text
(O A)^T (O A) = A^T A = K.
```

Lean proves this freedom for arbitrary orthogonal `O`. The source-preserving
lower-triangular condition is therefore substantive: it is the extra physical
structure that chooses `A` from the full orthogonal family. Lean separately
proves that, once positivity and this source condition are imposed, `A` is
unique.

This localizes the remaining field-theory test. A horizon or interface
variation must show that ordinary stress-energy selects this source-preserving
frame. Reading an arbitrary factorization of `K` as an S-matrix would not be
valid.

## Remaining physical premise

The new result closes the algebraic gap between the source-preserving doubled
action and the passive splitter. It does not by itself prove the physical
identification:

> The ordinary matter-coupled gravitational channel and the normalized
> quartic Perron-residue channel are the two Gram coordinates of the physical
> doubled spin-two quadratic form, with ordinary stress-energy selecting its
> positive source-preserving frame.

If this identification holds, the splitter, its coefficient, its orientation,
and its uniform action on both TT polarizations follow without another
continuous choice.

The mechanism fails if the physical overlap differs from `lambda4`, if the
residue is not normalized in the TT energy metric, if the source transformation
mixes in a partner source, or if the observer restriction is not the
orthogonal completion selected by this frame.

## Kernel artifact

`GravityScreening/ActionSplitterBridge.lean` proves:

- `sourceAdaptedGramFactor_gram`;
- `sourceAdaptedGramFactor_mul_inverse`;
- `sourceAdaptedGramFactor_preserves_source_ray`;
- `sourceAdaptedGramFactor_eq_scaledElectricFrame`;
- `sourceAdaptedGramFactor_source_column`;
- `passiveSourceSplitter_source_column`;
- `sourceAdaptedGramFactor_gramSchmidt`;
- `passiveSourceSplitter_orthogonal`;
- `passiveSourceSplitter_det`;
- `positive_sourceAdapted_gramFactor_unique`;
- `leftOrthogonal_gram_invariant`;
- `passiveSourceSplitter_unique`;
- `sourceAdaptedActionGram_yields_passiveSplitter`;
- `clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter`;
- `clockWeight_forced_splitter_retained_sq`.

The file compiles under the repository's pinned Lean 4.31.0 and uses no
`sorry` or nonstandard axioms.
