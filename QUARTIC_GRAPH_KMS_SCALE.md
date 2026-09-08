# The quartic graph fixes the modular scale

## The question this closes

The gravity mechanism uses the quartic defect amplitude

```text
lambda4 = 1 - 1/Q
```

and the equivalent modular scale `log Q`.  Algebra alone had shown that these
quantities agree once the modular eigenvalue is `1/Q`; it had not shown why a
modular problem should select that eigenvalue.

The quartic substitution supplies the missing finite graph data.  Its
incidence matrix is

```text
    [[0,0,0,1],
     [1,0,0,1],
A =  [0,1,0,0],
     [0,0,1,0]].
```

Lean proves that every entry of `A^10` is strictly positive.  Thus `A` is a
primitive nonnegative matrix and its directed graph is strongly connected.
Lean also proves that, whenever `Q^4=Q+1` and `Q>1`,

```text
v_Q = (1,Q^3,Q^2,Q) > 0,
A v_Q = Q v_Q.
```

These are the concrete Perron--Frobenius hypotheses for the quartic graph.

## The published KMS theorem

For an irreducible non-permutation zero-one matrix `A`, the canonical gauge
dynamics on its Cuntz--Krieger algebra has a KMS state at exactly

```text
beta = log r(A),
```

and that state is unique.  Here `r(A)` is the Perron--Frobenius spectral
radius.  Since the quartic graph is primitive and has the strictly positive
eigenvector above, its Perron value is `Q`.  The standard theorem therefore
selects

```text
beta_Q = log Q,
exp(-beta_Q) = 1/Q.
```

This is an external operator-algebra theorem.  The repository proves the
quartic finite-matrix certificate needed to apply it; it does not re-formalize
the construction of the Cuntz--Krieger algebra.

## The defect is exactly the PDT amplitude

Lean then proves

```text
1 - exp(-beta_Q)
  = 1 - 1/Q
  = lambda4.
```

Independently, the inverse-step residual of the same quartic substitution
acts on its positive Perron line by exactly this amplitude:

```text
(I-A^(-1)) v_Q = lambda4 v_Q.
```

The thermodynamic response defect and the substitution residue are therefore
the same scalar for structural reasons.  The value is simultaneously fixed
by the graph's equilibrium dynamics and by its inverse-step arithmetic.

Combining this with the already verified norm-preserving completion gives the
unique positive complementary amplitude

```text
sqrt(1-lambda4^2) = sqrt(S_Q).
```

The existing orientation theorem then fixes the full two-port map and its
Hamiltonian phase.

## What remains

This result removes the freedom to choose the modular scale after the quartic
graph is chosen.  It does not by itself identify the local null-boundary
observable algebra of gravity with the quartic graph algebra.

That identification is now the single physical bridge.  It has a precise
test: a proposed horizon representation must carry the quartic graph's gauge
step into the horizon modular step while preserving the intrinsic null
canonical potential.  If it does, the defect amplitude, complementary
screening weight, splitter, phase, and Newton response follow from the proved
chain.  If the horizon algebra has a different modular spectrum, the proposed
identification fails.

## Kernel artifact and primary sources

`GravityScreening/QuarticGraphKMSData.lean` proves:

- entrywise nonnegativity of the quartic incidence matrix;
- entrywise positivity of its tenth power;
- primitivity and irreducibility;
- positivity and the exact eigenvalue equation for the Perron vector;
- the exact critical Boltzmann factor `exp(-log Q)=1/Q`; and
- equality of the graph-KMS defect and the inverse-step Perron residue.

The file compiles without `sorry` and uses only Mathlib's standard logical
axioms.

- Tsuyoshi Kajiwara and Yasuo Watatani, *KMS states on finite-graph
  C*-algebras*: <https://arxiv.org/abs/1007.4248>
- Ruy Exel, *KMS states for generalized gauge actions on Cuntz--Krieger
  algebras*: <https://arxiv.org/abs/math/0110183>
- Horacio Casini, Eduardo Teste, and Gonzalo Torroba, *Modular Hamiltonians on
  the null plane and the Markov property of the vacuum state*:
  <https://arxiv.org/abs/1703.10656>

