# The two quartic clocks and the impossibility of an algebraic conversion

## The distinction

Two different unit-circle motions have appeared in the PDT time program.

The **projective conjugate clock** comes from a nonreal root `sigma_Q` of
`x^4-x-1`. Writing

\[
\sigma_Q=|\sigma_Q|e^{i\theta_Q}
\]

and dividing out the radial factor leaves the exact rotation

\[
z\longmapsto e^{i\theta_Q}z.
\]

Its frequency is the algebraic-root angle

\[
\theta_Q=\arg\sigma_Q
=1.806314210162\ldots.
\]

The **Perron/KMS modular clock** comes from the positive root `Q` and the
degree-one modular eigenvalue

\[
\Delta_Q\xi_Q=Q^{-1}\xi_Q.
\]

Its unitary modular phase is

\[
\Delta_Q^{it}\xi_Q=Q^{-it}\xi_Q
=e^{-it\log Q}\xi_Q,
\]

so its frequency is

\[
\log Q=0.199460578243\ldots.
\]

Both motions are genuinely quartic and genuinely unitary after the appropriate
normalization. They are not the same frequency.

## Transcendence theorem

The mismatch cannot be removed by multiplying by an algebraic constant.

Let

\[
c=\frac{\theta_Q}{\log Q}.
\]

The phase squared is

\[
e^{2i\theta_Q}=\frac{\sigma_Q}{\overline{\sigma_Q}},
\]

which is algebraic because both numerator and denominator are algebraic and
nonzero.

Assume for contradiction that `c` is algebraic. It is nonzero and real, so
`2ic` is algebraic and irrational. Since `Q` is algebraic and is neither zero
nor one, the Gelfond--Schneider theorem says that every value of

\[
Q^{2ic}
\]

is transcendental. But on the real logarithm branch,

\[
Q^{2ic}
=e^{2ic\log Q}
=e^{2i\theta_Q}
=\frac{\sigma_Q}{\overline{\sigma_Q}},
\]

which is algebraic. This is a contradiction. Therefore

\[
\boxed{
\frac{\theta_Q}{\log Q}\text{ is transcendental}.}
\]

This is stronger than proving that the ratio is irrational.

## Consequence for the portal

The portal coefficient

\[
\kappa_{pQ}=\left(\frac{Q}{p}\right)^2
\]

is algebraic. It therefore cannot satisfy

\[
\theta_Q=\kappa_{pQ}\log Q,
\qquad
\log Q=\kappa_{pQ}\theta_Q,
\]

or any exact linear conversion whose coefficient is algebraic. The same
conclusion holds for every algebraic expression in `p` and `Q`.

The portal may still couple the two clock processes dynamically. What it
cannot do is identify their rates by a fixed algebraic rescaling.

## Physical interpretations that remain open

There are two coherent possibilities.

### 1. The modular clock is the gravitational clock

The phase `Q^(-it)` is itself a unit-circle rotation. Its Rindler
interpretation is exact conditional on a boost-covariant embedding:

\[
E_Q/T_U=\log Q.
\]

On this reading, the complex-conjugate angle `theta_Q` governs the discrete
projective dynamics of the quartic companion system, while `log Q` governs
thermal and gravitational time.

### 2. PDT contains two physical clock layers

The projective angle carries coherent internal phase, while the modular clock
carries horizon time and thermal response. A geometric lapse or relative
modular cocycle relates their observed rates. The conversion must be
state-dependent or contain transcendental geometric data; it cannot be a
constant constructed algebraically from `p,Q` alone.

The second possibility fits the existing division of labor particularly well:

- `theta_Q` supplies aperiodic phase winding;
- the cubic sector supplies record formation and settling;
- `log Q` supplies the horizon KMS response;
- gravity supplies the proper-time conversion through the metric.

## What this corrects

The statement “the quartic clock keeps the same pitch through the erasure
channel” is true for whichever phase action is supplied to the covariant
channel. It does not prove that the conjugate-root pitch `theta_Q` equals the
modular pitch `log Q`.

Similarly, gravitational time dilation can reparametrize either clock while
preserving accumulated phase. It does not select the conversion between them
without a geometric embedding or Hamiltonian normalization.

## Next decisive test

Construct the physical horizon embedding and compute the action of the
relative modular cocycle on both candidate spectral lines. There are three
possible outcomes:

1. only the `log Q` line is geometric, selecting the modular clock for
   gravitational time;
2. both lines survive and the cocycle supplies a geometric, observer-dependent
   conversion;
3. one or both lines mix, falsifying the present one-frequency clock reading.

The test is stricter than finding that the continuous boost spectrum contains
the numerical value `log Q/(2*pi)`. It must transport the graded `pQ` algebra,
its state, and the distinguished mode together.

## Status

- **Established inputs:** algebraicity of the roots and their phase ratio,
  nonzero `theta_Q`, positivity and algebraicity of `Q`, and the classical
  Gelfond--Schneider theorem.
- **Exact conclusion:** `theta_Q/log Q` is transcendental, so no algebraic
  portal coefficient identifies the two rates.
- **Open physics:** which clock is geometric proper time, or how a
  state-dependent gravitational lapse relates them.

## References

- A. O. Gelfond and T. Schneider's theorem is summarized in the
  [Encyclopedia of Mathematics](https://encyclopediaofmath.org/wiki/Gel%27fond%E2%80%93Schneider_method).
- A recent formalization project is described in *A formalization of the
  Gelfond--Schneider theorem*, <https://arxiv.org/abs/2603.24823>.
