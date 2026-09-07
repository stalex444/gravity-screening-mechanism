# Degree-of-freedom audit of the doubled spin-two action

## The exact diagonalization

Write the two symmetric tensor fields as `h` and `h_tilde`, and introduce

```text
h_even = h + h_tilde,
h_odd  = h - h_tilde.
```

For the symmetric Pauli--Fierz bilinear form `B`, the doubled quadratic energy
diagonalizes exactly:

```text
4 Energy_Q
  = (1-lambda4) B(h_even,h_even)
    + (1+lambda4) B(h_odd,h_odd).
```

At the quartic root the two weights are

```text
1-lambda4 = 1/Q,
1+lambda4 = 2-1/Q.
```

Both are positive.  This explains the completed-square positivity theorem,
but it also exposes the central physical issue.

## What the unconstrained action describes

If `h` and `h_tilde` are independent Pauli--Fierz fields, the diagonal action
contains two independently propagating massless spin-two channels.  Moreover,
the source coupling splits as

```text
J(h) = [J(h_even)+J(h_odd)]/2,
```

so ordinary matter sources both channels.  The algebraic factor `1/S_Q` then
has a clear two-field origin, but the theory also carries an additional
long-range spin-two mode.  Positivity rules out a negative quadratic
direction under the stated physical-mode assumption; it does not remove this
extra mode.

## Why gravitational duality is different

In the duality-symmetric formulation of linearized gravity, the two symmetric
prepotentials are conjugate descriptions of the same graviton.  The action is
Hamiltonian and first order in time; the doubled potentials are tied by the
twisted self-duality equations.  Merely writing two second-order
Pauli--Fierz actions with a symmetric cross term does not impose that relation.

Therefore the present doubled action has two possible readings:

1. **Two-field reading.** It is a healthy linear two-graviton model for
   `0<lambda4<1`, subject to the separate nonlinear and phenomenological
   problems of an extra massless spin-two field.
2. **Dual-potential reading.** It is intended to use two potentials for one
   graviton, in which case an explicit first-order duality constraint and a
   degree count are still required.  The current quadratic action alone does
   not supply them.

## Consequence for PDT

The Hodge/Q-clock route remains the promising one because it can, in
principle, identify `h_tilde` as the magnetic or dual description of `h`
rather than a new particle.  The decisive next theorem is now sharper:

> Construct a source-preserving, first-order duality action for one linearized
> graviton whose reduced constitutive response is the PDT block with
> `lambda4=1-1/Q`.

If this succeeds, the partner supplies the screening without doubling the
physical graviton.  If every action realizing the symmetric `lambda4` block
retains two independent Pauli--Fierz modes, this route is excluded as a model
of ordinary gravity.

## Kernel artifact and primary references

- `GravityScreening/SpinTwoDegreeAudit.lean`
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>.
