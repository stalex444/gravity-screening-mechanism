# The near-sixth-root law for the quartic information contraction

## Finding

The quartic erasure factor

\[
S_Q=1-\left(1-\frac1Q\right)^2
\]

has an unexpectedly close relation to the dimension of the four-dimensional
bivector space:

\[
\dim\Lambda^2(\mathbb R^4)=\binom42=6.
\]

The dimensionless contraction rate relative to the quartic modular interval is

\[
\Gamma_Q=-\frac{\log S_Q}{\log Q}
=0.16667516956135529979\ldots,
\]

whereas

\[
\frac16=0.16666666666666666667\ldots.
\]

Equivalently,

\[
S_Q\approx Q^{-1/6}
\]

and

\[
\boxed{S_Q^6Q-1
=-0.00001017590197316313\ldots.}
\]

The relative rate discrepancy is

\[
6\Gamma_Q-1
=0.00005101736813179875\ldots,
\]

or about `0.00510%`.  The product discrepancy is about `0.00102%`.

This is not an exact identity.  It is an exploratory structural
correspondence whose significance depends on the controls below.

## Information-volume reading

The six components of a spacetime two-form are the natural carrier space for
curvature and for the Hodge split into three self-dual and three anti-self-dual
directions.  The erasure theorem says that the BKM information metric is
multiplied by `S_Q`.  If the relevant local tangent space is the six-dimensional
bivector space, its metric determinant is therefore multiplied by `S_Q^6` and
its information-volume element by `S_Q^3`.

The modular operator has full-step eigenvalue `Q^(-1)` and half-step amplitude
`Q^(-1/2)`.  The observed near relation can consequently be written as

\[
S_Q^3\approx Q^{-1/2}.
\]

This compares like with like: a six-dimensional information-volume factor to
a modular half-step amplitude.  Squaring gives the equivalent determinant
relation `S_Q^6 Q approximately 1`.

It suggests a specific synthesis:

\[
\text{one quartic modular half-step}
\quad\approx\quad
\text{the contracted six-bivector information volume}.
\]

The exponent six makes the four-dimensional selector explicit, while the
volume exponent three matches the three self-dual/anti-self-dual pairs.  The
identification of the BKM tangent directions with physical curvature
bivectors remains a physical premise; the determinant and volume scaling then
follow exactly.

## Exact algebraic residual

Using `Q^4=Q+1`, the near identity reduces exactly to

\[
S_Q^6Q-1
=\frac{-97+142Q+33Q^2-69Q^3}{Q^{12}}.
\]

`GravityScreening/ErasureInformation.lean` kernel-checks this reduction as
`quarticSixBivector_residual`.

The numerator is not the zero polynomial.  Since `Q` has irreducible quartic
minimal polynomial `x^4-x-1`, it cannot also satisfy that nonzero cubic.
Therefore the near equality is provably not exact; its smallness is a genuine
algebraic cancellation at the positive embedding.

## Integer-exponent control

For the fixed quartic pair `(S_Q,Q)`, scan the structurally simplest integer
exponents `1 <= m <= 12` in

\[
S_Q^mQ-1.
\]

The values neighboring six are

| `m` | `S_Q^m Q - 1` |
|---:|---:|
| 4 | `+0.068739669700886` |
| 5 | `+0.033793400206623` |
| **6** | **`-0.000010175901973`** |
| 7 | `-0.032708423075890` |
| 8 | `-0.064337484001625` |

The closest alternative in the full range is `m=7`.  Its absolute residual is
about `3214` times larger than the `m=6` residual.  Because `S_Q^mQ` decreases
strictly with `m`, there is only one crossing and no second integer solution is
being hidden.

## Degree-family control

The residue construction exists for every positive root `r_d` of

\[
x^d-x-1=0.
\]

Define

\[
S_d=1-\left(1-\frac1{r_d}\right)^2
\]

and test the bivector count `C(d,2)` at every degree.  The first values are

| `d` | `C(d,2)` | `S_d^{C(d,2)}r_d-1` |
|---:|---:|---:|
| 2 | 1 | `+0.3819660112501` |
| 3 | 3 | `+0.0999912296762` |
| **4** | **6** | **`-0.0000101759020`** |
| 5 | 10 | `-0.0514903592374` |
| 6 | 15 | `-0.0829212190105` |
| 7 | 21 | `-0.1041213395124` |
| 8 | 28 | `-0.1193921634640` |

Among degrees `2` through `12`, the quartic member is the only one within
`10^(-4)` of the unit product.  The next closest is the degree-five value,
more than five thousand times farther from zero.  This control is especially
relevant because neither the defect formula nor the bivector-count formula was
invented only for `d=4`; their intersection selects the quartic rung.

## Evidential status

This is stronger than an isolated decimal resemblance because:

1. `S_Q` was fixed upstream by the modular defect and Hilbert completion;
2. six is fixed by the dimension of two-forms in four dimensions;
3. the neighboring exponent gap exceeds three orders of magnitude;
4. the degree-family control uniquely selects `d=4` over the tested range.

It remains weaker than the exact modular-erasure theorem.  There is no
measurement uncertainty against which to score the residual, and exact
algebra proves that the equality fails.  The honest claim is therefore a
highly selective near factorization that may indicate a missing interaction or
normalization between the six bivector modes.

The most useful next question is whether the known Hodge response operator
predicts a small correction to equal sharing whose exact determinant is
`Q^(-1)`.  If it does, the residual above may measure a calculable anisotropy
between the self-dual and anti-self-dual sectors.  If no such correction is
forced, the near equality should remain an interesting control rather than a
physical input.

## Reproduce

Run:

```bash
python3 bivector_rate_audit.py
```

The script uses Python's standard-library decimal arithmetic, prints 80-digit
quartic values, scans integer exponents, checks the degree family, and derives
the exact reduced numerator.
