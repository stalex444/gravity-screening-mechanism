# Physical bridge audit: from quartic residue to gravitational response

## Result

The strongest present mechanism is a three-stage chain:

1. the founding quartic substitution fixes an inverse-step residue amplitude
   `lambda4 = 1 - 1/Q` on its positive Perron mode;
2. norm-preserving completion forces the complementary squared weight
   `1 - lambda4^2`;
3. local-horizon thermodynamics supplies a known physical setting in which an
   information complement is read as gravitational response.

The first two stages are exact mathematics. The third is a physically
motivated correspondence, not yet a consequence of the deposited two-scalar
action. This chain explains more than the bare identity: it gives separate
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

## Why the complement can be gravitational

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
Those results do not contain PDT's coefficient, but they establish the kind of
bridge needed here: information crossing or hidden by a local causal boundary
has a complementary geometric response governed by gravity.

The proposed PDT reading is consequently precise:

- the quartic residue is the one-step Q-channel amplitude at the boundary;
- its Stinespring/Julia complement is the accessible geometric response;
- Jacobson's local equilibrium condition promotes that response to Einstein
  dynamics;
- the defect weight rescales the gravitational kinetic coefficient or squared
  Planck amplitude by `1-lambda4^2`.

This yields

\[
M_{P,\mathrm{eff}}=dM_{P,0},
\qquad
G_{\mathrm{eff}}
=\frac{G_0}{d^2}
=\frac{G_0}{1-\lambda_4^2}.
\]

Jacobson's theorem supports the identification of an information complement
with a gravitational response. It does not prove that the PDT Perron residue
is the horizon channel. That identification is now the single exposed
physical premise.

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
3. **More than two physical channels.** Completeness then fixes only the sum
   of the complementary weights; it no longer forces all of
   `1-lambda4^2` into gravity.
4. **A nonscalar residue.** A momentum-dependent or mode-dependent reduction
   would generally produce an operator-valued screening rather than the
   observed scalar factor.

The proposed mechanism is therefore falsifiable. A derivation from the actual
joint Q-geometry dynamics must produce a two-channel scalar reduction with
Kraus amplitude `lambda4` on the physical mode. Producing `1/Q`, extra active
channels, or a nonconstant operator would reject this mechanism.

## Honest status

This closes the algebraic and normalization questions:

- **why `lambda4`:** inverse-step residue of the founding quartic operator;
- **why a square:** probabilities and kinetic strengths are Hilbert norms;
- **why a minus sign:** norm conservation in the complementary channel;
- **why the reciprocal in `G`:** Newton's constant is inverse-square in the
  Planck mass;
- **why four dimensions:** the Pisot boundary and the Ehrenfest marginal point
  coincide at the quartic rung.

A published type-III theorem now supplies an abstract state-preserving
realization of the quartic response inside a wedge algebra. What remains is
dynamical and gravitational: make the embedded pQ algebra invariant under the
wedge modular flow, and then identify its defect complement with the
gravitational kinetic response. `MODULAR_MAP_AUDIT.md` states the cocycle test;
`REVERSE_HORIZON_AUDIT.md` gives the stronger equivalent target of a vacuum-
preserving conditional expectation. Until those conditions are met, this is a
tightly constrained candidate mechanism with explicit falsifiers.
