# Where the quartic gravity factor lives in information geometry

## Result

The tetrahedral four-outcome model does not derive `lambda4` as a change in
the normalized three-dimensional record. It proves something more selective:
the quartic residue lies in the **total accessible weight**, while the
conditional shape of the record is unchanged.

Let

\[
Q^4=Q+1,
\qquad
M_Q=1+Q+Q^2+Q^3,
\]

and normalize the positive quartic Perron vector to

\[
p_Q=\frac{(1,Q^3,Q^2,Q)}{M_Q}.
\]

Lean proves that its four entries sum to one and that the distinguished
renewal entry is

\[
(p_Q)_0=\frac1{M_Q}=1-\frac1Q=\lambda_4.
\]

If `C_Q` is the quartic companion operator and

\[
R_Q=I-C_Q^{-1},
\]

then the entire normalized Perron distribution is an eigenvector:

\[
R_Qp_Q=\lambda_4p_Q.
\]

Its unnormalized residual mass is therefore `lambda4`. But conditioning on
that branch divides by the same number and returns the original distribution:

\[
\frac{R_Qp_Q}{\sum_i(R_Qp_Q)_i}=p_Q.
\]

The tetrahedral three-coordinate record is a linear function of these four
normalized weights, so it too is exactly unchanged after conditioning.

## The exact no-go result

A normalized Fisher metric compares changes in the shape of a probability
distribution. A common multiplier changes no normalized probability, no
tetrahedral record, and no Fisher direction. Therefore `lambda4` cannot be
recovered as a normalized Fisher overlap on the Perron eigenline.

Reading the residual as classical probability thinning gives

\[
\text{residual mass}=\lambda_4,
\qquad
\text{classical complement}=1-\lambda_4=\frac1Q.
\]

Lean proves that, for every `Q>1`, this complement is different from

\[
S_Q=1-\lambda_4^2.
\]

Thus the gravity coefficient cannot come from treating the Perron residue as
an ordinary event frequency. This rules out a tempting but incorrect route.

## The amplitude route

If the same scalar is an operator amplitude on a Hilbert vector, Born's rule
squares it. For a scalar branch of amplitude `a`, the unconditioned outcome
weights are

\[
w_i'=a^2p_i.
\]

They have total mass `a^2`, while conditioning again recovers `p_i`. Setting
`a=lambda4` therefore gives the exact split

\[
\text{hidden weight}=\lambda_4^2,
\qquad
\text{visible complement}=1-\lambda_4^2=S_Q.
\]

This distinction is the information-geometric answer. The normalized
tetrahedral simplex describes the **shape** of the four-outcome record. Total
mass is a separate radial coordinate on the cone of positive measures.
Quantum amplitudes are square-root coordinates on that cone, so a radial
amplitude contraction by `lambda4` becomes a mass contraction by
`lambda4^2`. The tetrahedral record can remain identical for every retained
cell even while fewer cells remain accessible to the observer.

| Reading of `lambda4` | Branch weight | Complement |
|---|---:|---:|
| Classical frequency or mass multiplier | `lambda4` | `1-lambda4=1/Q` |
| Hilbert-space amplitude | `lambda4^2` | `1-lambda4^2=S_Q` |

The two readings make different predictions and are kernel-proved to be
unequal for `Q>1`.

## Why the Hilbert reading is structurally available

The separate modular-GNS construction supplies exactly the required
amplitude interpretation. For a degree-one quartic KMS mode, standard modular
theory gives

\[
\Delta_Q\xi=Q^{-1}\xi.
\]

Consequently

\[
(I-\Delta_Q)\xi=\lambda_4\xi,
\qquad
\|(I-\Delta_Q)\xi\|^2=\lambda_4^2\|\xi\|^2.
\]

The Perron calculation and the GNS calculation therefore locate the same
scalar in two different mathematical settings. The Perron side supplies the
canonical four-state distribution and its inverse-step residue. The GNS side
supplies the Hilbert norm that legitimately squares the residue. No
probability is silently relabeled as an amplitude.

## Meaning for the gravity mechanism

The result supports a precise model:

```text
quartic Perron update
    -> fixed four-outcome equilibrium shape
    -> inverse-step residue lambda4
    -> modular GNS defect amplitude lambda4
    -> inaccessible Born weight lambda4^2
    -> accessible information weight S_Q
    -> horizon Fisher/canonical energy multiplied by S_Q
    -> fixed physical shear forces G_Q = G_0/S_Q.
```

The tetrahedral readout adds a useful physical picture. Gravity need not
distort the local proportions of a settled three-dimensional record. It can
change how much of that record remains accessible across the causal boundary.
The local observer sees the same conditional geometry carried by a reduced
unconditioned information weight.

The remaining physical premise is now narrow:

> The degree-one quartic modular defect is the hidden branch of a local
> causal-horizon information channel, and the horizon area density counts its
> unconditioned visible complement.

The repository already proves the consequences of that premise through the
finite erasure channel, information-area response, horizon shear
normalization, and sourced Pauli--Fierz response. What remains is a
net-compatible sharp-horizon realization of the channel, or an independent
physical consequence that tests this identification.

## Status

The Perron normalization, renewal weight, residual eigenvalue, classical
complement, conditional tetrahedral invariance, Born branch split, and
conditional Born-record invariance are kernel-checked with no `sorry`.

The modular eigenvector-to-amplitude step is kernel-checked conditional on the
standard GNS modular eigenvector equation. Identifying that microscopic mode
with the physical causal-horizon channel remains a PDT physical postulate.

## Artifacts

- `GravityScreening/PerronTetrahedralBridge.lean`
- `GravityScreening/TetrahedralInformationFrame.lean`
- `GravityScreening/ModularAmplitude.lean`
- [`MODULAR_GNS_AMPLITUDE.md`](MODULAR_GNS_AMPLITUDE.md)
- [`HORIZON_SHEAR_BRIDGE.md`](HORIZON_SHEAR_BRIDGE.md)
