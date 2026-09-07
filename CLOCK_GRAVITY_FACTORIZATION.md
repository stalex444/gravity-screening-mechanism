# Time and gravity use the same Q step in different ways

## The reverse-audit result

The quartic clock contraction and the gravitational canonical squeeze cannot
be the same transformation.

The clock step is `s=log Q`, so the retained exponential weight is

\[
  e^{-s}=\frac1Q.
\]

The clock-forced gravitational block has even and odd eigenweights

\[
  r_+=\frac1Q,
  \qquad
  r_-=2-\frac1Q.
\]

Their product is the screening coefficient

\[
  r_+r_-=\frac{2Q-1}{Q^2}=S_Q.
\]

Put `d=sqrt(S_Q)` and divide the raw block by `d`.  The two remaining
eigenweights are

\[
  u_+=\frac{1}{Qd},
  \qquad
  u_-=\frac{2-1/Q}{d},
  \qquad
  u_+u_-=1.
\]

They are therefore a determinant-one canonical squeeze.  The original clock
weight factorizes exactly as

\[
  \frac1Q=d\,u_+.
\]

This is the clean relationship:

```text
one Q-clock contraction
        = common gravitational action scale
          x determinant-one canonical squeeze.
```

The common scale `d` changes the response to an independently normalized
matter source.  The reciprocal squeeze changes the internal relation between
the two prepotentials while retaining one canonical graviton pair and the
standard vacuum propagation speed.

## Why the distinction matters

If the clock dilation itself were the canonical squeeze, the eigenvalue ratio
would be `Q^2`.  The actual forced ratio is

\[
  \frac{u_-}{u_+}=2Q-1.
\]

Lean proves that `2Q-1` cannot equal `Q^2` for `Q>1`, because equality would
force `(Q-1)^2=0`.  Thus time and gravity share the same quartic event, but
gravity resolves that event into a volume-changing scale and an
area-preserving canonical distortion.  This is compatible with the standard
two-prepotential architecture: its physical phase space demands the
determinant-one part, while Newton's coupling can live in the common action
scale.

## Remaining premise

The factorization is exact once the raw even gravitational response is the
Q-clock weight and the Hodge-paired response preserves the normalized mean.
The remaining physics is still the carrier identification: why the horizon
Q-clock acts on this gravitational prepotential channel.  The reverse audit
shows precisely what that identification must mean and prevents the stronger,
incorrect claim that modular time translation is literally the canonical
gravity squeeze.

The kernel-checked statements are in
`GravityScreening/ClockGravityFactorization.lean`.
