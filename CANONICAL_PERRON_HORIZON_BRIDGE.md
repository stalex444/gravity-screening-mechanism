# Canonical Perron-to-horizon bridge

## What changed

Earlier horizon capstones began with an arbitrary two-channel matrix `M` and
assumed that it carried the required quartic clock weight.  The canonical
bridge removes that freedom.  Its matrix is defined directly from the
left/right Perron compression of the directed quartic residual:

```text
R_Q = I - A_Q^(-1),
lambda_Q = <l_Q,R_Q r_Q>/<l_Q,r_Q> = 1-1/Q,
K_Q = [[1,-lambda_Q],[-lambda_Q,1]],
det(K_Q) = 1-lambda_Q^2 = S_Q.
```

No adjustable matrix coefficient remains.

## The canonical theorem

`GravityScreening.canonicalPerronHorizonBridge_capstone` proves the following
statements together from the cubic and quartic root equations and their
positive-root conditions:

1. `log(rho)/log(Q)` is irrational, so the two modular frequencies are
   incommensurate.
2. Their joint real-time multiplier has norm one.
3. The complete displayed gravity response is

   ```text
   1/alpha_G
     = det((rho Q) I_224) det(K_Q) / pi^4.
   ```

4. A concrete two-state off-diagonal tangent carries the exact joint `rho Q`
   modular phase through exterior restriction by the quartic erasure channel.
5. Acting with `K_Q` on both vectors of a tangential frame scales its positive
   area by `S_Q`.
6. Bekenstein--Hawking entropy inherits the same factor.
7. Every exterior diagonal expectation is multiplied by `S_Q`.
8. The sum of exterior and hidden expectations equals the original
   expectation.
9. With total heat unscaled and entropy density multiplied by `S_Q`, Jacobson's
   coupling response is `G_0/S_Q`.

All nine clauses are in one kernel-checked declaration.  The supporting file
is `GravityScreening/CanonicalPerronHorizonBridge.lean`.

## Why this is stronger

The quartic coefficient is no longer inserted into a horizon matrix after the
fact.  The full quartic transfer operator first selects `lambda_Q` through its
canonical biorthogonal Perron pairing.  That same scalar defines the
two-channel constitutive response used by the finite horizon model.  Its
determinant then reappears independently in four places: positive area,
entropy, exterior information, and the inverse Newton response.

The joint clock is also explicit.  The two-state phase action contains an
off-diagonal mode whose spectral multiplier is exactly the product modular
flow.  The exterior channel commutes with that action, so screening changes
the mode's accessible weight without changing its clock frequency.

This is the algebraic form wanted from gravitational time dilation: the local
observer can lose access to part of the information while the underlying
global evolution remains norm preserving and the modular rate remains fixed.

## What remains physical

The finite mechanism is complete under its definitions.  It does not prove
that the displayed two-state system is a subalgebra of the physical LQG or
quantum-field-theoretic horizon algebra.  The final physical construction must
provide a faithful map from this canonical carrier into that algebra and show
that:

```text
finite joint modular phase  -> geometric horizon boost,
finite tangential frame     -> physical triad/area frame,
finite exterior restriction -> causal exterior restriction,
finite conserved observable -> physical boost-energy flux.
```

Once those four identifications come from one state-preserving representation,
the gravity formula follows from the compiled capstone.  A failure of any one
identification would falsify this proposed carrier while leaving the finite
mathematics intact.

## Relation to the cubic arrow

The registered Padovan result supplies a separate piece: the canonical cubic
language has an exact four-symbol orientation threshold.  That result chooses
a direction for a distinguished classical history.  The canonical bridge
here supplies the quartic transfer and horizon response, while the joint
`rho Q` flow supplies the common clock scale.  The three jobs are therefore
carried by three proved structures rather than being assigned to one number.

## Primary sources for the physical interface

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*:
  <https://arxiv.org/abs/gr-qc/9504004>.
- E. Bianchi, *Entropy of Non-Extremal Black Holes from Loop Gravity*:
  <https://arxiv.org/abs/1204.5122>.
- D. Pranzetti, *Geometric Temperature and Entropy of Quantum Isolated
  Horizons*: <https://arxiv.org/abs/1305.6714>.
- A. Ashtekar, J. Baez, and K. Krasnov, *Quantum Geometry of Isolated Horizons
  and Black Hole Entropy*: <https://arxiv.org/abs/gr-qc/0005126>.
