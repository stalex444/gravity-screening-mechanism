# The current two-scalar action does not generate the screening block

## Result

The two-scalar induced-gravity action presently associated with the PDT gravity
paper cannot produce the normalized mixing coefficient
`c = lambda4` at tree level about its selected vacuum. It produces `c = 0`.

This is a useful no-go. It rules out one source of the screening factor without
ruling out the screening formula itself.

## The action actually on file

The deposited model has two scalar fields `phi` and `chi`, canonical diagonal
kinetic terms, and only the `phi` field coupled to scalar curvature:

\[
S_J=\int d^4x\sqrt{-g}\left[
\frac12 (\partial\phi)^2+\frac12(\partial\chi)^2
-V(\phi,\chi)+\frac12\xi\phi^2R
\right],
\]

with

\[
V=\lambda_3(\phi^2-v^2)^2
 +\lambda_4(\chi^2-u^2)^2
 +\kappa\phi^2\chi^2.
\]

The selected axis vacuum is `(phi,chi) = (v,0)`.

## Frame-covariant kinetic test

For a multifield scalar-curvature action with curvature coefficient `f` and
Jordan-frame kinetic matrix `k_AB`, the standard frame-covariant field metric
is

\[
G_{AB}=\frac{k_{AB}}{f}
 +\frac32\frac{f_{,A}f_{,B}}{f^2}.
\]

This is equation (2.23) of Karamitsos and Pilaftsis, *Frame Covariant
Nonminimal Multifield Inflation*, arXiv:1706.07011.

For the PDT action,

\[
f(\phi,\chi)=\xi\phi^2,
\qquad k_{AB}=\begin{pmatrix}1&0\\0&1\end{pmatrix}.
\]

Hence

\[
f_{,\phi}=2\xi\phi,
\qquad f_{,\chi}=0,
\]

and therefore

\[
G_{\phi\chi}
=\frac{k_{\phi\chi}}{f}
 +\frac32\frac{f_{,\phi}f_{,\chi}}{f^2}
=0.
\]

At `xi = 1/6`, the diagonal entries are

\[
G_{\phi\phi}=\frac{12}{\phi^2},
\qquad
G_{\chi\chi}=\frac{6}{\phi^2},
\qquad
G_{\phi\chi}=0.
\]

Canonical normalization cannot turn a zero off-diagonal entry into a nonzero
normalized overlap. The kinetic correlation is exactly `c = 0`.

## Potential test

The mixed entry of the potential Hessian is

\[
\frac{\partial^2V}{\partial\phi\,\partial\chi}
=4\kappa\phi\chi.
\]

At `(v,0)` it vanishes. The Einstein-frame potential differs by a factor that
depends only on `phi`; because the potential is even in `chi`, the mixed
derivative still vanishes on the `chi = 0` axis.

The quadratic fluctuation operator is consequently diagonal between the
`phi` and `chi` modes at the selected static vacuum. Its Schur complement is
`1`, rather than `1-lambda4^2`.

## A stronger symmetry statement

The action is invariant under `chi -> -chi`, and the selected vacuum preserves
that symmetry. A bilinear fluctuation term between the `chi` mode and a
`chi`-even geometric mode is odd under this symmetry. It is therefore
forbidden while the symmetry and vacuum are retained. This is why merely
renormalizing the coefficients of the displayed action cannot create the
required tree-level mixing.

## What this redirects

The factor `1-lambda4^2` still has an exact Schur-complement realization, but
the displayed scalar action is not its source. A successful mechanism must
come from at least one ingredient absent from that action:

1. an orientation-odd or chiral curvature response whose two exchanged
   channels carry the affine weights `1-lambda4` and `1+lambda4`;
2. a coarse-grained or loop response in which the `chi` sector contributes
   quadratically without linear scalar mixing;
3. an enlarged kinetic or curvature function with independently forced
   off-diagonal structure; or
4. a background with nonzero `chi`, provided that its full quadratic response
   is stable. The mixed stationary point of the current portal potential is a
   saddle, so it does not meet this condition.

Any enlargement must derive its normalization before comparing the normalized
overlap with `lambda4`. Inserting `lambda4` into a new term would reproduce the
number by construction and would not explain it.

## Clean falsifier

For any proposed source action:

1. expand about the physically selected background;
2. remove constraints and gauge modes;
3. canonically normalize the two surviving response modes;
4. read their normalized quadratic block.

The minimal mechanism succeeds only if that block is positive and its
off-diagonal magnitude is exactly `lambda4`. If it is zero, another fixed
number, scale-dependent, or indefinite, the mechanism fails for that action.

## Sources

1. S. Alexander, *Deriving Gravity from First Principles*, Zenodo,
   DOI: 10.5281/zenodo.20417378.
2. S. Karamitsos and A. Pilaftsis, *Frame Covariant Nonminimal Multifield
   Inflation*, Nuclear Physics B 927 (2018), 219-254,
   arXiv:1706.07011.
