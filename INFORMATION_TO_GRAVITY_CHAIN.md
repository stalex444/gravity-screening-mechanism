# A direct information-geometric route to Newton's response

There are now two exact routes from the Q clock to the gravity coefficient.
The constitutive route passes through the gravitational Hodge pair.  This
second route passes through a known information/gravity dictionary.

For the finite quartic erasure channel, the full Fisher bilinear contracts by

\[
  g_Q=S_Qg_0,
  \qquad
  S_Q=\frac{2Q-1}{Q^2}.
\]

In holographic AdS-Rindler gravity, quantum Fisher information for a boundary
state perturbation equals the gravitational canonical energy of the
corresponding bulk perturbation.  For a fixed normalized geometric mode `h`,
canonical energy has the form

\[
  \mathcal E_{\rm can}(h,h)=\frac1G\,W(h,h).
\]

The new Lean capstone composes these statements.  If the microscopic and
effective Fisher metrics describe the same nonzero gravitational mode, with
the same independently fixed amplitude and shape pairing, then

\[
  \frac1{G_Q}=S_Q\frac1{G_0},
  \qquad
  \boxed{G_Q=\frac{G_0}{S_Q}}.
\]

This route does not assume `lambda4` as a gravitational mixing coefficient or
assume the two-channel matrix.  It uses the quartic channel's proved Fisher
contraction and turns that coefficient into Newton's response through the
same-mode canonical-energy dictionary.

## Why this advances the carrier question

The literature already establishes that Fisher information can be the metric
on gravitational perturbations: Lashkari and Van Raamsdonk proved the equality
for perturbations of a holographic CFT ball and the corresponding AdS-Rindler
wedge.  Henneaux and Teitelboim independently show that the linearized
gravitational phase space admits the two-prepotential canonical form used by
the constitutive route.

The two routes therefore meet at the gravitational symplectic geometry:

```text
Q clock/channel -> Fisher metric -> gravitational canonical energy -> 1/G
Q clock/channel -> Hodge pair    -> canonical spin-two action       -> 1/G
```

They agree on the exact coefficient and its inverse placement.

## Honest boundary

The kernel proves the composition once the two endpoint dictionaries are
supplied.  The published Fisher/canonical-energy equality is established in
AdS-Rindler holography, not yet for every local causal horizon or for the PDT
observer crossed product.  Extending the same-mode dictionary to that setting
is the remaining physical task on this route.  The amplitude must be fixed by
the same flux or area normalization on both sides; otherwise the Fisher
contraction can be absorbed into a smaller perturbation rather than into `G`.

The formal theorem is
`GravityScreening.quarticInformationMetric_forces_newtonResponse` in
`GravityScreening/InformationToGravityChain.lean`.

## Primary references

- N. Lashkari and M. Van Raamsdonk, *Canonical Energy is Quantum Fisher
  Information*: <https://arxiv.org/abs/1508.00897>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*:
  <https://arxiv.org/abs/1505.04753>.
- M. Henneaux and C. Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
