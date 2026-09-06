# Derivation and falsifier

## 1. The arithmetic coefficient

Let `Q > 1` satisfy `Q^4 - Q - 1 = 0` and define

\[
\lambda_4=1-Q^{-1}.
\]

Then

\[
1-\lambda_4^2
=1-(1-Q^{-1})^2
=\frac{2Q-1}{Q^2}.
\]

Numerically,

\[
Q=1.220744084605759\ldots,
\quad \lambda_4=0.180827486603836\ldots,
\quad S_Q=0.967301420088540\ldots.
\]

The arithmetic contains more than the decimal identity. Since
`Q^(-1)=Q^3-1`,

\[
\lambda_4=2-Q^3,
\qquad
S_Q=3Q^3-Q^2-3.
\]

The screening element satisfies

\[
S_Q^4+3S_Q^3-2S_Q^2+22S_Q-23=0.
\]

The change-of-basis determinant from
`{1,S_Q,S_Q^2,S_Q^3}` to `{1,Q,Q^2,Q^3}` is `-241`, and

\[
Q=\frac{293-63S_Q+49S_Q^2+18S_Q^3}{241}.
\]

Thus `S_Q` generates the same quartic field. Its field norm is `-23`, the
discriminant of `x^3-x-1`. These are exact arithmetic facts. They do not by
themselves say what physical observable reads `S_Q`.

## 2. The four-dimensional homogeneity gate

For a Newtonian central force in `d` spatial dimensions, use the effective
potential

\[
V_{\rm eff}(r)
=\frac{L^2}{2mr^2}-\frac{k}{d-2}r^{2-d}
\qquad(d\ne2).
\]

The centrifugal and gravitational pieces have exponents `-2` and `2-d`.
Their ratio scales as `r^(4-d)`. A constant, dimensionless mixing of these
radial responses can therefore be independent of radius only when

\[
2-d=-2 \quad\Longleftrightarrow\quad d=4.
\]

At a circular orbit, direct differentiation gives

\[
V_{\rm eff}''(r_0)
=\frac{(4-d)L^2}{m r_0^4}.
\]

The orbit is stable for `d<4`, marginal for `d=4`, and unstable for `d>4`.
This is the exact content supplied by the Ehrenfest argument. It selects the
marginal dimension and the availability of scale-free mixing. It does not
select a mixing strength.

The `d` here is a spatial dimension. Any PDT use of this result must state how
that spatial count maps to the theory's quartic or four-dimensional sector;
the equality of the two uses of “four” is a physical identification.

## 3. The projection mechanism

Consider two normalized response coordinates `x` and `y` with dimensionless
mixing `lambda`:

\[
\mathcal Q_\lambda(x,y)
=x^2+y^2-2\lambda xy.
\]

Completing the square gives

\[
\mathcal Q_\lambda(x,y)
=(y-\lambda x)^2+(1-\lambda^2)x^2.
\]

Eliminating or minimizing over `y` leaves

\[
\mathcal Q_{\rm eff}(x)=(1-\lambda^2)x^2.
\]

Equivalently, the normalized response matrix

\[
K_\lambda=
\begin{pmatrix}1&-\lambda\\-\lambda&1\end{pmatrix}
\]

has determinant `1-lambda^2`, and its Schur complement with respect to either
unit diagonal block is `1-lambda^2`. It is positive definite exactly for
`|lambda|<1`.

In projection language, if two unit response vectors have overlap `lambda`,
then the squared norm orthogonal to the second is `1-lambda^2`. In statistical
language, it is the conditional variance left after removing the part
predictable from a correlated channel. These are the same theorem.

If a gravitational kinetic coefficient changes from `Z_0` to
`Z_eff=Z_0(1-lambda^2)`, its inverse response changes as

\[
G_{\rm eff}=\frac{G_0}{1-\lambda^2}.
\]

Setting `lambda=lambda4` reproduces the direction and exact magnitude of the
PDT correction.

## 4. What follows, and what does not

The following implication is exact:

1. two scale-matched normalized channels exist;
2. their quadratic response has unit diagonal coefficients;
3. their normalized mixing coefficient is `lambda4`;
4. the unobserved or redundant channel is eliminated by the quadratic field
   equation;

therefore the surviving kinetic coefficient is `1-lambda4^2`.

The current PDT action has not established premises 2–4. Its canonical kinetic
terms are diagonal. At the axis vacua selected by its bistable potential, the
mixed scalar Hessian vanishes. At the mixed stationary point,

\[
\det H
=16\phi^2\psi^2(4\lambda_3\lambda_4-\kappa^2)<0,
\]

because `kappa^2/(4 lambda3 lambda4) > 1`. That Hessian cannot serve as a
positive correlation, Fisher, or kinetic matrix.

A curvature-sector response remains possible, but it requires a source-level
derivation. In scalar-tensor gravity, metric-scalar kinetic mixing is a real and
well-studied mechanism; merely citing that mechanism does not fix its
coefficient to `lambda4`.

## 5. The decisive next calculation

Expand a fully specified PDT curvature-plus-scalar action to quadratic order
about the selected classical vacuum. Isolate the physical scalar curvature or
radial mode and the candidate Q-sector mode. Canonically normalize both. Read
the resulting two-by-two kinetic block

\[
K=\begin{pmatrix}1&-c\\-c&1\end{pmatrix}.
\]

There are three clean outcomes:

- `c = lambda4`: the screening factor follows as a Schur complement;
- `c` is another fixed function of `rho,Q`: the gravity formula receives a
  definite correction and can be tested numerically;
- the block is not positive, is scale-dependent, or contains additional modes:
  the minimal screening mechanism fails.

The test must fix the field normalization before comparing `c` with
`lambda4`; otherwise a field rescaling can manufacture the desired number.

## References

1. P. Ehrenfest, “In what way does it become manifest in the fundamental laws
   of physics that space has three dimensions?”, *Proc. Amsterdam Acad.* 20
   (1917/1918), 200–209.
2. T. Jacobson, “Thermodynamics of Spacetime: The Einstein Equation of State”,
   *Phys. Rev. Lett.* 75 (1995), 1260–1263, arXiv:gr-qc/9504004.
3. D. Bettoni and M. Zumalacárregui, “Shaken, not stirred: kinetic mixing in
   scalar-tensor theories of gravity”, *Phys. Rev. D* 91 (2015), 104009,
   arXiv:1502.02666.

