# Four outcomes and one three-dimensional record

## The exact coincidence

The four vectors used as the balanced digits of the plastic-number packing are

\[
(1,1,1),\quad(1,-1,-1),\quad(-1,1,-1),\quad(-1,-1,1).
\]

After division by `sqrt(3)`, these are exactly the four Bloch vectors of the
standard tetrahedral qubit SIC measurement. The quantum-information
literature describes it as a four-outcome measurement whose directions form a
regular tetrahedron on the Bloch sphere. The coincidence is literal: the
coordinates agree sign for sign, up to overall rotation or reversal.

This must be interpreted on the correct space. The Bloch ball is a
three-dimensional **state-parameter space**, not ordinary physical space.
What transfers immediately is the information geometry: four balanced
outcomes are the minimal symmetric data needed to reconstruct three real
coordinates.

## Kernel-checked information geometry

Write the unnormalized tetrahedral vectors as `v_k`. Lean proves

\[
\lVert v_k\rVert^2=3,
\qquad
v_k\mathbin\cdot v_l=-1\quad(k\ne l),
\]

and the tight-frame identity

\[
\sum_{k=1}^{4}(v_k\mathbin\cdot x)^2=4\lVert x\rVert^2.
\]

For the unit vectors `u_k=v_k/sqrt(3)`, this becomes

\[
\sum_{k=1}^{4}(u_k\mathbin\cdot x)^2=\frac43\lVert x\rVert^2.
\]

Thus the response is isotropic: no spatial coordinate is preferred. The frame
constant is exactly `4/3`, the same ratio that appears as the coverage
threshold in the centered-tetrahedron argument. These are two consequences of
the same simplex geometry:

* convex geometry: four translated copies of `3K` cover `4K`;
* information geometry: four balanced directions encode three coordinates
  with tight-frame factor `4/3`.

Lean also proves an explicit reconstruction. Define

\[
p_k(x)=\frac{1+v_k\mathbin\cdot x}{4}.
\]

Then

\[
\sum_k p_k(x)=1,
\qquad
x=\sum_k p_k(x)v_k.
\]

On the appropriately normalized Bloch ball these are the tetrahedral SIC
probabilities. The four probabilities have one normalization constraint and
therefore carry three independent real numbers, exactly enough to recover the
state.

## What it contributes to PDT

The established mathematical chain is now

```text
four balanced alternatives
    -> isotropic, informationally complete three-coordinate record
    -> the same tetrahedron generates the rho Meyer packing
    -> rho is the unique morphic scale below its 4/3 coverage gateway
    -> Q is below the gateway but cannot keep distinct histories separated.
```

This supplies a disciplined version of the proposed time picture. A quartic
update can carry four alternatives; resolving their normalized outcome data
produces a complete three-coordinate record; the plastic/Pisot sector can
retain such records as a uniformly separated packing. The fourth item is not
an extra spatial coordinate in this reading. It is the redundant outcome
needed to specify a normalized three-dimensional state.

The physical identification remains conjectural. Neither SIC theory nor the
Meyer-set theorem says that cosmological time is a sequence of tetrahedral
qubit measurements. What is established is that the proposed `4 -> 3`
information map already exists as a canonical and experimentally implemented
piece of quantum information geometry.

## Relevance to gravity

That proposed target has now been run and it gives an exact no-go result. The
quartic Perron residual multiplies all four outcome weights by the same
`lambda4`. Renormalization cancels it, leaving both the four probabilities and
their three-coordinate tetrahedral record unchanged. A normalized Fisher
metric therefore cannot see `lambda4` on this eigenline.

The failure locates the factor rather than discarding it. `lambda4` belongs to
the total unconditioned branch weight, a radial coordinate on the positive
measure cone, while the tetrahedral probabilities describe its normalized
shape. If `lambda4` is a Hilbert-space amplitude, its Born weight is
`lambda4^2` and the visible complement is exactly `S_Q`. The independent
modular-GNS construction supplies that amplitude reading; treating the Perron
residue as a classical frequency instead gives the different complement
`1/Q`.

The horizon calculation elsewhere in this repository converts physical
two-component shear into canonical gravitational energy and proves that a
quartic contraction by `S_Q` is equivalent to the screened Newton response.
The remaining bridge is physical: identify the quartic modular defect with
the hidden branch of the local causal-horizon channel and its unconditioned
complement with horizon information density. See
[`PERRON_TETRAHEDRAL_BRIDGE.md`](PERRON_TETRAHEDRAL_BRIDGE.md).

## Artifacts and sources

* `GravityScreening/TetrahedralInformationFrame.lean`
* `GravityScreening/PerronTetrahedralBridge.lean`
* M. Tavakoli et al., *Self-testing nonprojective quantum measurements in
  prepare-and-measure experiments*, Eq. 13 and the qubit SIC discussion,
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC7164945/>.
* Z. E. D. Medendorp et al., *Experimental Realization of Quantum Tomography
  of Photonic Qudits via Symmetric Informationally Complete Positive
  Operator-Valued Measures*, Phys. Rev. X 5, 041006 (2015),
  <https://doi.org/10.1103/PhysRevX.5.041006>.
