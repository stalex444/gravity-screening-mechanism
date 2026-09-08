# LQG relevance to the remaining PDT gravity interface

## Result

Loop quantum gravity supplies a natural geometric carrier for the determinant
already forced by the PDT clock-response theorems: the flux of the densitized
triad through a two-surface.

For two local tangential frame vectors `u` and `v`, define their oriented
surface flux by the wedge determinant

```text
Flux(u,v) = u0 v1 - u1 v0.
```

For every real two-dimensional linear response `M`, Lean proves

```text
Flux(Mu,Mv) = det(M) Flux(u,v).
```

Positive local area is the absolute value of that flux. When `det(M)` is
nonnegative, it obeys the same scaling law.

The earlier unoriented-clock classification fixes

```text
det(M) = S_Q = 1-lambda4^2 = (2Q-1)/Q^2.
```

Consequently, if the classified response is carried by the two tangential
frame directions on a horizon patch, its triad-flux area is multiplied by
exactly `S_Q`. The capstone theorem proves that the same determinant:

1. scales the positive surface-flux area;
2. scales every exterior diagonal observable in the finite horizon dilation;
3. leaves the combined exterior-plus-hidden observable exactly conserved.

This is an exact common interface among the quartic clock, information
retention, and surface geometry.

## Why LQG is the relevant comparison

Ashtekar and Lewandowski construct self-adjoint area operators for
two-surfaces from quantum geometry and obtain discrete spectra. In the
isolated-horizon construction of Ashtekar, Baez, and Krasnov, the pullback of
the triad two-form and the curvature of the horizon connection fluctuate in
tandem under the horizon boundary condition. Bulk quantum-geometry degrees of
freedom pierce the horizon and endow it with area, while surface degrees of
freedom encode the corresponding horizon geometry.

That framework provides two ingredients needed by the PDT calculation:

- a surface-flux observable whose local classical transformation law is
  controlled by a determinant;
- a boundary condition coupling the flux/triad side to the curvature side.

PDT's present Hodge calculation lives on the curvature-response side. The new
Lean theorem makes the flux side exact once the carrier map is supplied.

There is also a stronger transport theorem modeled on the isolated-horizon
boundary condition. Suppose a fixed nonzero scalar `c` relates the selected
triad-flux and curvature components before and after the response,

```text
curvatureBefore = c triadBefore,
curvatureAfter  = c triadAfter,
curvatureAfter  = M curvatureBefore.
```

Lean proves that `triadAfter = M triadBefore`. Applied to two independent
surface directions, this derives the tangential carrier statement and hence
the `S_Q` area law. The boundary coefficient cancels, so this transport result
does not depend on choosing a numerical Barbero-Immirzi value. The comparison
is at one fixed horizon cut or macroscopic area sector, where the same boundary
coefficient applies on both sides.

## Exact remaining hypothesis

The direct theorem does not assume silently that the PDT channel coordinates
are already the tangential components of an Ashtekar densitized triad. It names
that statement as `IsTangentialFrameResponse`:

```text
after0 = M before0,
after1 = M before1.
```

The isolated-horizon tandem theorem replaces that direct carrier premise by
the standard form of a fixed scalar curvature/triad boundary relation. The
remaining physical derivation is therefore narrower:

> Derive the PDT matrix `M` as the curvature response of the selected horizon
> Hodge pair from the microscopic action, and verify that the same fixed-cut
> boundary relation applies to that pair.

The determinant-to-area step, the quartic coefficient, and global information
conservation are closed within the formal model. The carrier identification in
canonical connection/triad variables remains open.

## Why no Barbero--Immirzi value is selected

This bridge does not require selecting a numerical Barbero--Immirzi parameter.
The PDT materials currently contain two nearby candidates from different
constructions:

```text
kappa log(rho)       = 0.238790513254...
rho (1-1/Q)          = 0.239545418668...
```

Their proximity is not equality, and neither value is used here.  More
fundamentally, published horizon constructions do not present a single stable
real number on which this bridge should depend.  The robust result is instead
the cancellation proved in `LQGHorizonThermodynamics.lean`: the same Immirzi
factor occurs in local boost energy and physical facet area, so the Clausius
entropy at fixed physical area is independent of it.

## Lean surface

The formalization is in `GravityScreening/LQGFluxAreaBridge.lean`. Its main
declarations are:

- `triadSurfaceFlux2_mulVec`;
- `scalarHorizonBoundary_transports_response`;
- `tangentialFrameResponse_area_scale`;
- `unorientedClock_forces_triadFluxResponse`;
- `unorientedClock_forces_triadAreaResponse`;
- `unorientedClock_surfaceFlux_information_capstone`.
- `isolatedHorizon_tandem_flux_information_capstone`.

## Primary references

- A. Ashtekar and J. Lewandowski, *Quantum Theory of Gravity I: Area
  Operators*, <https://arxiv.org/abs/gr-qc/9602046>.
- A. Ashtekar, J. Baez, and K. Krasnov, *Quantum Geometry of Isolated Horizons
  and Black Hole Entropy*, <https://arxiv.org/abs/gr-qc/0005126>.
- A. Ashtekar, S. Fairhurst, and B. Krishnan, *Isolated Horizons: Hamiltonian
  Evolution and the First Law*, <https://arxiv.org/abs/gr-qc/0005083>.
