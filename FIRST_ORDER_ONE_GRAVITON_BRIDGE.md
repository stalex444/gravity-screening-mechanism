# First-order source bridge: one canonical pair

## The repair supplied by the standard gravity architecture

The unconstrained second-order action treats `h` and `h_tilde` as two
independent configuration fields.  Its exact diagonalization therefore
exposes two massless spin-two channels.

The duality-symmetric formulation of linearized gravity uses a different
architecture.  Its two symmetric prepotentials form one canonical
position-momentum pair.  The action is first order in time, with an
antisymmetric symplectic kinetic term and a symmetric Hamiltonian.  The two
prepotentials then describe the two phase-space coordinates of one graviton.

## The PDT-normalized action

Let `B` be the symmetric spatial Pauli--Fierz/prepotential bilinear form.  Put

```text
d = sqrt(1-lambda4^2),
c = 1/d,
s = lambda4/d.
```

Then `c^2-s^2=1`, so the symmetric Hamiltonian shape

```text
Khat = [[c,-s],[-s,c]]
```

has determinant one.  With overall scale `d`, the sourced first-order action
on a canonical pair `(q,p)` is

```text
S_1[q,p]
  = d { B(p,q_dot)
        - [c B(q,q)-2s B(q,p)+c B(p,p)]/2 }
    + J(q).
```

The Lean proof computes both exact finite variations.  At zero velocity they
become

```text
B(delta,q)-lambda4 B(delta,p)-J(delta) = 0,
B(delta,p)-lambda4 B(delta,q)          = 0
```

for every test variation `delta`, up to a common harmless minus sign.  These
are exactly the electric and source-free partner equations of the screened
block.  If the spatial pairing is nondegenerate, they give

```text
p = lambda4 q,
(1-lambda4^2) q = source.
```

Thus the same inverse response `1/S_Q` is compatible with one canonical
degree of freedom.  The determinant-one shape controls the internal duality
relation, while the common factor `d` controls the response to an independently
normalized source.

## What is now proved and what is not

The exact action variation and its equality with the doubled screening
equations are kernel checked for every symmetric bilinear form.  Together with
the earlier symplectic-reduction theorem, this supplies a one-canonical-pair
realization of the complete internal mechanism.

The remaining work is a field-theory instantiation.  One must write `B` as the
actual gauge-invariant spatial functional of the two gravitational
prepotentials, include the lapse and shift source potentials, and verify that
the resulting action has precisely the standard two graviton polarizations.
The existing Henneaux--Teitelboim and Barnich--Troessaert constructions show
the required architecture, but they do not supply the PDT constitutive metric
or its `lambda4` value.

The PDT-specific identification also remains: the quartic complex-place clock
and Hodge conjugation must be shown to produce this canonical prepotential
pair and its normalized Hamiltonian metric.  The canon currently treats that
step as a physical correspondence.

## Kernel artifact and primary references

- `GravityScreening/FirstOrderSourceAction.lean`
- `GravityScreening/SymplecticReduction.lean`
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Glenn Barnich and Cedric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>.
