# Physical bridge audit: from quartic residue to gravitational response

## Result

The strongest present mechanism is a three-stage chain:

1. the founding quartic substitution fixes an inverse-step residue amplitude
   `lambda4 = 1 - 1/Q` on its positive Perron mode;
2. norm-preserving completion forces the complementary squared weight
   `1 - lambda4^2`;
3. an isotropic action of the complementary amplitude on the two inverse-
   length horizon-resolution directions would force the area-density response
   `1-lambda4^2`.

The first two stages are exact mathematics. The third is a precise geometric
target, not yet a consequence of the deposited two-scalar action. This chain
explains more than the bare identity: it gives separate
reasons for the coefficient, its square, its sign, its inverse appearance in
Newton's constant, and its association with a four-dimensional boundary.

## The minimal channel

Let

\[
\lambda=1-\frac1Q,
\qquad
d=\sqrt{1-\lambda^2}.
\]

On the positive Perron line, define the isometry

\[
V_Q\psi=\lambda\psi\oplus d\psi.
\]

Then

\[
V_Q^*V_Q=(\lambda^2+d^2)I=I.
\]

The two branch weights are therefore fixed:

\[
p_Q=\lambda^2,
\qquad
p_G=d^2=1-\lambda^2.
\]

No second continuous number has been inserted. The corresponding minimal
unitary completion is

\[
U_Q=
\begin{pmatrix}
\lambda&d\\
d&-\lambda
\end{pmatrix},
\qquad
U_Q^*=U_Q,
\qquad
U_Q^2=I.
\]

If one tick has duration `tau` and `hbar=1`, a particularly simple generator
is

\[
H_Q=\frac{\pi}{2\tau}(I-U_Q),
\qquad
e^{-iH_Q\tau}=U_Q.
\]

This does not uniquely determine a microscopic Hamiltonian: logarithms of a
unitary have branch freedom. It does prove that the same coefficient defines a
closed, norm-preserving one-tick dynamics without adding a coupling.

## The candidate horizon-area map

The beta-dilation picture gives the residue a boundary meaning. Under
`x -> Qx` on a normalized interval, the set `(1/Q,1]` crosses the unit
boundary in one step, and its length is exactly `lambda4`. The companion
operator upgrades that numerical length to the eigen-amplitude of
`I-M_Q^(-1)` on the positive scaling mode.

The relevant established physics is Jacobson's local-horizon result. In the
1995 argument, demanding `delta Q = T dS` for every local Rindler horizon,
together with entropy proportional to horizon area, yields the Einstein
equation as an equation of state. In the 2015 entanglement-equilibrium version,
stationarity of vacuum entanglement in small geodesic balls yields the
semiclassical Einstein equation under the stated field-theory assumptions.
Those results do not contain PDT's coefficient or identify a channel
complement with gravity. They establish the narrower bridge needed here:
horizon entropy variation per physical area fixes the gravitational response.

The proposed PDT reading is consequently precise:

- the quartic residue is the one-step Q-channel amplitude at the boundary;
- its Julia defect fixes the positive amplitude
  `d=sqrt(1-lambda4^2)`;
- the open physical step is that `d` acts isotropically on the two inverse-
  length resolution directions tangent to a local horizon;
- the density of microscopic cells per physical area then scales by
  `d^2=1-lambda4^2`, and Jacobson's local equilibrium condition converts that
  entropy-per-area coefficient into Newton's
  coupling.

This yields

\[
M_{P,\mathrm{eff}}=dM_{P,0},
\qquad
G_{\mathrm{eff}}
=\frac{G_0}{d^2}
=\frac{G_0}{1-\lambda_4^2}.
\]

Jacobson's theorem supplies the area-law-to-gravity implication. It does not
prove that the PDT defect amplitude acts on the inverse-length horizon
resolution. That local area-density identification is the exposed physical
premise.

The bare scalar Kraus pair also requires a warning: it factorizes as
`psi tensor (lambda|Q>+d|G>)`, so its outcome weights are independent of the
input state. It is a norm decomposition, not yet an information-transfer
mechanism. A full channel must have nontrivial relative branch action while
retaining the universal weights. See `HORIZON_AREA_CALIBRATION.md`.

The standing F373 Hodge-pair response supplies the first non-scalar candidate
that passes this warning. If `A=I+lambda4 C` is a normalized chiral kinetic
operator, its stiffnesses are `1+lambda4` and `1-lambda4`. The
orientation-even mean of their inverse responses is exactly

```text
1/(1-lambda4^2).
```

This is the required enhancement of `G` as an inverse kinetic response, and it
does not reinterpret global trace normalization as entropy. The current action
still does not derive `A`; that source-forcing no-go is F374. See
`HODGE_CHIRAL_SCREENING.md`.

Primary references:

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*,
  <https://arxiv.org/abs/1505.04753>.
- F. vom Ende, *From Kraus Operators to the Stinespring Form of Quantum Maps*,
  <https://arxiv.org/abs/2301.05488>.

## The four-dimensional selector

The defect construction alone is not quartic-specific. For the positive root
`r_n` of `x^n-x-1`, the same Perron calculation gives

\[
(I-M_n^{-1})v_n=\left(1-\frac1{r_n}\right)v_n.
\]

The family control is:

| n | positive root | residue amplitude | defect weight |
|---:|---:|---:|---:|
| 2 | 1.618033988750 | 0.381966011250 | 0.854101966250 |
| 3 | 1.324717957245 | 0.245122333753 | 0.939915041495 |
| 4 | 1.220744084606 | 0.180827486604 | 0.967301420089 |
| 5 | 1.167303978261 | 0.143325116145 | 0.979457911082 |
| 6 | 1.134724138402 | 0.118728538366 | 0.985903534177 |

Therefore the formula is a family law; it cannot select `Q` merely by being a
defect formula. The quartic selection comes from two independent facts used by
PDT:

1. `n=4` is the first member on the non-Pisot side of the proposed 3D/4D
   divide, so it is the first family member whose conjugate dynamics fail to
   settle in the Pisot manner;
2. `d=4` is the unique Ehrenfest marginal dimension, because the Newtonian and
   centrifugal radial homogeneities coincide only there. A scale-free mixing
   coefficient can therefore enter the gravitational response without an
   added radial scale.

Within the quartic spectrum, the positive Perron direction is also the only
mode for which the residue `I-M_Q^(-1)` is contractive. The other three
residual magnitudes are approximately `1.52424`, `1.52424`, and `2.38028`.
This selects the positive mode needed for a Hilbert-space channel. It does not,
by itself, select gravity.

## Reverse audit

Running the construction backward reveals four sharp failure modes.

1. **Retained state instead of change.** If the channel amplitude is the
   inverse-step retention `1/Q`, its defect is `1-1/Q^2`, which is not the
   gravity coefficient.
2. **Classical measure instead of amplitude.** If the interval length
   `lambda4` is treated directly as a probability, the complement is
   `1-lambda4`, also wrong. The square requires Hilbert norm.
3. **Bare scalar instrument.** The pair `lambda4 I,d I` factorizes and carries
   no information about the input state. It fixes weights but supplies no
   Q-to-geometry dynamics.
4. **Wrong horizon determinant.** A nontrivial operator-valued completion is
   allowed, but its positive isotropic horizon projection must have determinant
   `1-lambda4^2`; otherwise it does not produce the observed universal factor.

The proposed mechanism is therefore falsifiable. A derivation from the actual
joint Q-geometry dynamics must preserve the quartic residue weight while
acting nontrivially on the state, and its horizon area-density response must
have the required determinant. Producing `1/Q`, a trivial state-independent model
only, or a different area determinant rejects this mechanism.

## Honest status

This closes the algebraic and normalization questions:

- **why `lambda4`:** inverse-step residue of the founding quartic operator;
- **why a square:** the defect is a Hilbert norm and a two-dimensional horizon
  cell density is quadratic in its inverse-length amplitude;
- **why a minus sign:** norm conservation in the complementary channel;
- **why the reciprocal in `G`:** Newton's constant is inverse-square in the
  Planck mass;
- **why four dimensions:** the Pisot boundary and the Ehrenfest marginal point
  coincide at the quartic rung.

A published type-III theorem supplies an abstract state-preserving realization
of the quartic response inside a wedge algebra, while the free-wedge audit
excludes an exact bounded local clock. The continuous-core trace realizes the
coefficient but global trace normalization cannot change the entropy first
law. What remains is a local gravitational construction: derive the affine
chiral kinetic operator whose orientation-even inverse supplies the screening,
or derive an equivalent horizon area-density or noncentral modular response.
Until then this is a tightly constrained candidate mechanism with explicit
falsifiers.
