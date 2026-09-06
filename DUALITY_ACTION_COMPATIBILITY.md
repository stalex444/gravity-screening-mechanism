# Duality-action compatibility of the quartic screening block

## Result

The real doubled response found in this audit has a precise relationship to
the standard duality-symmetric form of linearized gravity, but it is not the
standard vacuum action itself.

On one reduced doubled mode, write the proposed internal response block as

```text
K(lambda) = [[1,       -lambda],
             [-lambda, 1      ]].
```

Its determinant and Schur complement are both

```text
S(lambda) = 1-lambda^2.
```

Let

```text
d = sqrt(S),
Khat = K/d.
```

Then the raw block factors exactly as

```text
K = d Khat,
det Khat = 1.
```

The factorization resolves an apparent mismatch between duality geometry and
the proposed Newton-coupling correction. `Khat` is the determinant-one shape
needed for a normalized twisted-duality operator. Eliminating its second mode
leaves one factor `d`; the overall scale multiplying `Khat` supplies the other
factor `d`. The effective stiffness is therefore

```text
d * d = S = 1-lambda^2,
```

and its inverse source response is `1/S`.

At `lambda=lambda4=1-1/Q`, this gives

```text
M_P,eff / M_P,0 = d = sqrt(1-lambda4^2),
G_eff / G_0     = 1/d^2 = 1/(1-lambda4^2).
```

Thus the square-root Planck-scale factor and the full Newton factor are two
expressions of the same two-channel response. This is an exact decomposition
of the candidate block. It does not yet derive that block from Einstein
gravity or from the PDT scalar action.

The action-level form singled out by the comparison is schematically

```text
S_PDT^(2)[Z]
  = d A_0 { symplectic kinetic term[Z]
            - Hamiltonian_Khat[Z] }
    + source coupling[Z,matter].
```

Here `Z=(P,Phi)` denotes the doubled gravitational prepotentials and `A_0` is
the unscreened Einstein normalization. The common prefactor `d` cancels from
the source-free field equations but changes the response to an independently
normalized matter source. `Khat` changes the internal constitutive relation
without moving the vacuum light cone. A raw `K` in the Hamiltonian with an
unmodified kinetic term would fail that test.

## 1. What standard linearized gravity fixes

Henneaux and Teitelboim solve the linearized gravitational constraints using
two symmetric superpotentials, customarily denoted `P` and `Phi`. Their action
has two distinct internal tensors:

```text
kinetic term:    epsilon_ab  (antisymmetric),
Hamiltonian:     delta_ab    (symmetric).
```

The first makes the two potentials canonical partners. The second gives the
same positive spatial-derivative functional to both potentials. Because both
`epsilon_ab` and `delta_ab` are preserved, the vacuum action has an `SO(2)`
duality symmetry.

This comparison constrains the PDT proposal. A symmetric `lambda4` cross-block
cannot replace the antisymmetric symplectic term. If it exists, it must deform
the Hamiltonian or constitutive matrix while the canonical antisymmetric
structure is retained. With a fixed nonzero `lambda4`, it also changes the
standard vacuum `SO(2)` symmetry. The resulting theory would describe a
duality-selecting constitutive background unless the Q-sector variable itself
transforms so that the full action remains covariant.

The established gravity result is also more structured than the finite model:
the potentials carry spatial indices, derivative operators and gauge
redundancies. In the original metric variables, the corresponding doubled
action is spatially nonlocal. Consequently, the matrix calculation here is a
necessary internal consistency test, not a substitute for the gravitational
constraint calculation.

For a constant `lambda`, however, two linearized vacuum checks can be settled.
The Hamiltonian in the standard action is a gauge-invariant quadratic
functional of either prepotential. Polarizing that quadratic functional gives
a bilinear form that vanishes whenever either argument is a pure gauge mode.
Any constant internal matrix, including `Khat`, therefore preserves the same
independent linearized gauge symmetries.

Furthermore, a positive symmetric symplectic matrix has a symplectic square
root `B` with

```text
Khat = B^T B.
```

The canonical change of variables `Znew=B Z` leaves the antisymmetric kinetic
term unchanged and turns `Hamiltonian_Khat` back into the identity
Hamiltonian. The constant, source-free linearized proposal is consequently
canonically equivalent to ordinary linearized gravity. This supplies its
linear vacuum gauge and covariance check; it also means that `Khat` alone is
not a new vacuum interaction.

This argument ceases to be automatic if the quartic parameter is promoted to
a spacetime-dependent field, because derivatives of `B(lambda(x))` then enter
the action. The present result concerns the fixed algebraic value `lambda4`.

## 2. Why determinant one matters

Let the canonical symplectic matrix be

```text
Omega = [[0,-1],
         [1, 0]].
```

For the raw response block, direct multiplication gives

```text
(Omega K)^2 = -det(K) I = -S I.
```

Unless `S=1`, `Omega K` is not a complex structure: it does not square to
`-I`. After normalization,

```text
(Omega Khat)^2 = -I.
```

This is the exact algebraic condition expected of a normalized twist. The
normalization does not erase the gravitational correction, because the raw
block retains the scalar prefactor `d`:

```text
K = d Khat.
```

In rapidity language, put `lambda=tanh(theta)`. Then

```text
Khat = [[cosh(theta), -sinh(theta)],
        [-sinh(theta), cosh(theta)]],
```

whose two eigenvalues are reciprocal, `exp(theta)` and `exp(-theta)`. The
quartic residue therefore determines a hyperbolic distortion of the doubled
pair, while `d=sech(theta)` determines the common stiffness scale.

For the positive quartic root,

```text
lambda4 = 0.1808274866038355603...
theta   = artanh(lambda4) = 0.1828380153932759051...
d       = 0.9835148296230919928...
S       = 0.9673014200885396710....
```

## 3. The one-mode propagation test

The derivative operators in the full prepotential action are essential, but
their internal two-channel algebra can be tested on each Fourier and helicity
mode. Suppressing inessential powers of the wave number, the first-order
vacuum equation has the form

```text
dot Z = k Omega M Z,
```

where `M` is the symmetric internal Hamiltonian matrix. Differentiating once
more gives

```text
ddot Z = k^2 (Omega M)^2 Z.
```

For `M=K`, the kernel-checked identity gives

```text
ddot Z = -S k^2 Z.
```

The raw block would therefore change the propagation speed to `sqrt(S)=d` if
the symplectic kinetic term were left untouched. For `M=Khat`,

```text
ddot Z = -k^2 Z,
```

so the standard mode speed is preserved. This makes the scale-shape split a
physical consistency condition rather than cosmetic matrix normalization.

Multiplying both the symplectic term and `Hamiltonian_Khat` by the same
constant `d A_0` does not change this source-free equation: the common factor
cancels on variation. It does change the response to matter when the matter
source is normalized independently, just as the overall Einstein-Hilbert
coefficient determines Newton's constant.

The same conclusion survives elimination of a canonical partner rather than
only static Gaussian elimination. For one first-order mode, let

```text
L = A [p qdot - 1/2(c q^2 - 2s q p + c p^2)],
c = 1/d,
s = lambda/d,
c^2-s^2=1.
```

The momentum equation gives `p=(qdot+s q)/c`. Substitution yields

```text
L_eff = A/(2c) [qdot^2-q^2+2s q qdot].
```

For constant `s`, the last term is a boundary term in this one-mode model.
The even kinetic and restoring terms have coefficient `A/c`. Choosing the
common gravitational scale `A=d A_0` gives

```text
A/c = d^2 A_0 = S A_0.
```

This reduction is kernel checked. In the full gravitational action the mixed
term contains the prepotential derivative operator, so whether it reduces to
a boundary or Chern-Simons-type term must be calculated rather than inferred
from the oscillator. That calculation is the natural place to compare the
proposal with parity-odd gravitational terms, including the role sometimes
played by a Barbero-Immirzi parameter.

For a static source `j` coupled only to the selected metric coordinate, the
stationary equations of the scaled normalized block are

```text
d[(1/d)q-(lambda/d)p] = j,
d[(1/d)p-(lambda/d)q] = 0.
```

Their unique solution for `S` nonzero is

```text
q = j/S,
p = lambda j/S.
```

So the full inverse screening response does not depend on an informal
determinant reading; it follows directly from the sourced equations. This
identity is also kernel checked. Its physical use still depends on proving
that ordinary stress-energy couples to `q` in the proposed prepotential
frame.

## 4. Where the two factors appear

The Schur complement of the second channel in the normalized block is

```text
Schur(Khat) = d.
```

Multiplying the entire Hamiltonian block by the scale `d` therefore gives

```text
Schur(d Khat) = d Schur(Khat) = d^2 = S.
```

This explains the hierarchy without adding another coefficient:

```text
determinant-one shape       -> one factor sqrt(S),
overall gravitational scale -> one factor sqrt(S),
effective sourced stiffness -> S,
inverse response            -> 1/S.
```

These are not two independently demonstrated physical effects. They are the
unique scale-shape factorization of the same `K(lambda)` block. Its value is
that it shows the proposed screening coefficient can coexist algebraically
with a normalized twisted-duality map; using the unnormalized block as the
twist would be inconsistent.

There is a second qualification. A positive determinant-one `Khat` is a
symplectic squeeze of the identity, so the source-free linear theory can view
it as a canonical change of doubled variables. It becomes observable only
when the Q sector or the matter coupling selects which member of the doubled
pair is the physical metric sourced by stress-energy. If the source is
transformed together with the canonical variables, the apparent compliance
change is only a change of coordinates.

The exact open equality can now be stated cleanly:

```text
overall Einstein scale / A_0 = d
                              = Schur(Khat).
```

Assuming the raw unit-diagonal graph block `K` forces this equality because
`K=d Khat`. Twisted-duality normalization by itself does not force it. A PDT
derivation must show why the quartic residual supplies the complete raw graph
block, or independently show why both occurrences of `d` are governed by the
same Q-sector defect.

## 5. What is now ruled out

The comparison rules out three tempting shortcuts:

1. The `lambda4` mixing cannot simply be inserted into the antisymmetric
   kinetic term of the standard duality-symmetric action.
2. The raw matrix `Omega K` cannot be called a normalized twisted-self-duality
   complex structure, because its square is `-S I`.
3. Standard linearized vacuum gravity does not already contain the required
   symmetric cross-Hamiltonian: its internal Hamiltonian metric is
   `delta_ab`.

It also sharpens the surviving proposal. The target is a Q-dependent
determinant-one deformation `Khat(lambda4)` of the doubled Hamiltonian, with
the usual antisymmetric canonical structure left intact and a common overall
action scale `d`.

## 6. Decisive next test

The next calculation should begin with the actual two-prepotential action,
replace its internal `delta_ab` by `Khat(lambda4)` in the Hamiltonian, multiply
the complete gravitational action by `d`, fix the matter source to the metric
direction, and then check all of the following together:

1. the full prepotential derivative operator reproduces the finite-mode
   reduction without a hidden normalization;
2. the Q sector fixes the metric/source frame, so `Khat` is not merely a
   removable canonical squeeze;
3. the Q-sector equations force both `Khat(lambda4)` and the overall factor
   `d`, rather than leaving a free rescaling;
4. ordinary stress-energy can couple consistently to the selected metric
   direction without requiring an unobserved independent magnetic source;
5. eliminating the dual potential gives the local low-energy stiffness `S`;
6. the nonlinear completion does not introduce a ghost or an extra
   propagating graviton.

Failure of any one of these tests would localize the obstruction. Passing
them would turn the present exact response identity into a genuine
linearized-gravity screening mechanism.

## Kernel-checked statements

`GravityScreening/Basic.lean` verifies:

- `det K(lambda)=1-lambda^2`;
- `(Omega K)^2=-(1-lambda^2)I`;
- if `d^2=1-lambda^2`, then `det(K/d)=1`;
- `(Omega K/d)^2=-I`;
- `K=d(K/d)`;
- `Schur(K/d)=d` and `d*d=1-lambda^2`.
- the determinant-one block is symplectic, while the raw block is conformally
  symplectic with multiplier `1-lambda^2`;
- eliminating the canonical partner in the first-order mode gives the even
  second-order coefficient `1-lambda^2` when the common action scale is `d`.
- a source fixed to the first doubled coordinate has response
  `q=j/(1-lambda^2)` and induces partner amplitude `p=lambda*q`.

## References

- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
- Bunster, Henneaux, and Hoertner, *Twisted Self-Duality for Linearized
  Gravity in D dimensions*: <https://arxiv.org/abs/1306.1092>.
- Bunster and Henneaux, *The Action for Twisted Self-Duality*:
  <https://arxiv.org/abs/1103.3621>.
