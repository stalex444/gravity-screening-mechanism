# Fisher-score audit of the quartic gravity mechanism

## Verdict

The information-geometric formula is exact, but none of the four canonical
uncoupled constructions produces the required Fisher overlap.  The missing
object is specifically a coupled cubic-quartic history measure.

This is a useful negative result.  It prevents the exact KMS defect
`lambda4` from being silently relabeled as a Fisher correlation.

## Test 1: the two-outcome KMS family

Normalize a forward/reverse pair with detailed-balance ratio

```text
r = exp(-beta omega).
```

Its probability distribution depends on `beta` and `omega` only through the
single product `z=beta omega`.  Both score functions are therefore multiples
of the same centered binary statistic.  If its variance is `V`, the Fisher
matrix has the form

```text
I_KMS = V [[omega^2,  beta omega],
           [beta omega, beta^2  ]].
```

It has determinant zero.  The normalized score correlation has magnitude one,
and the partial Fisher information after eliminating either coordinate is
zero.  At `beta=log Q`, `omega=1`, the causal defect is exactly

```text
1-exp(-beta omega) = 1-1/Q = lambda4,
```

but that response value is not the Fisher correlation.  The theorem
`oneStatistic_twoParameterFisher_relativeSchur_zero` verifies the rank-one
conclusion for every nondegenerate one-statistic family.

## Test 2: a global weight and a renewal tilt

Give all quartic histories a common factor `exp(g)` and tilt the renewal count
by `exp(tau N_renewal)`.  The normalized probability is

```text
p(omega | g,tau)
  = exp(g+tau N_renewal(omega)) / Z(g,tau).
```

The common `exp(g)` cancels against the partition function.  Consequently

```text
partial_g log p = 0.
```

The nominal geometric-scale coordinate is statistically unidentifiable.  This
is the probability-theory counterpart of the field-normalization cancellation:
a common normalization cannot generate observable screening.

## Test 3: the uncoupled pQ product state

Let the cubic history depend on `g`, let the quartic history depend on `tau`,
and take their product:

```text
p(x,y | g,tau) = p_rho(x | g) p_Q(y | tau).
```

The score functions depend on separate variables.  Their cross-information is

```text
E[L_g L_tau] = E[L_g] E[L_tau] = 0,
```

because every regular score has zero mean.  The normalized Fisher overlap is
zero, so the relative partial information is one and there is no screening.
The theorem `independentFisher_relativeSchur_one` verifies the final Schur
calculation.

This applies directly to the presently constructed tensor-product pQ KMS
state.  Its quartic factor retains the exact causal defect `lambda4`, while the
product construction supplies no cubic-quartic score covariance.

## Test 4: the tetrahedral quartic Perron distribution

Normalize the positive quartic Perron vector to four probabilities,

```text
p_Q = (1,Q^3,Q^2,Q)/(1+Q+Q^2+Q^3).
```

The renewal probability is exactly `lambda4`. The inverse-step residual also
acts on the whole vector by the common scalar `lambda4`. After conditioning on
that residual branch, however, the scalar cancels:

```text
(lambda4 p_Q)/sum(lambda4 p_Q) = p_Q.
```

The tetrahedral three-coordinate record is therefore unchanged. Its
normalized Fisher geometry has no direction in which to register the common
scale. Interpreting the scale as classical mass would leave complement `1/Q`,
which Lean proves differs from `S_Q` for every `Q>1`.

This test separates two geometries. The probability simplex records shape;
the cone of unnormalized positive measures also records total accessible
mass. A Hilbert amplitude `lambda4` produces mass `lambda4^2`, so the desired
complement arises only on the amplitude cone. The independent modular-GNS
construction supplies that Hilbert-space reading.

## Reverse conclusion

For a general positive two-coordinate Fisher matrix

```text
I = [[a,b],
     [b,c]],
```

the surviving fraction of geometric information is

```text
(a-b^2/c)/a = 1 - b^2/(a c).
```

Therefore the PDT screening factor is obtained if and only if

```text
b^2/(a c) = lambda4^2.
```

Equivalently, the normalized score correlation must have magnitude `lambda4`.
This is already kernel-checked by `relativeSchur_eq_screening_iff`.  The sign
of the correlation does not affect screening; causal orientation would have to
fix it separately.

## What the Fisher route would still require

If screening is to be derived as partial Fisher information, the next
candidate cannot be the quartic distribution alone, a global
normalization, the uncoupled pQ tensor product, or the normalized tetrahedral
Perron record.  It must contain an
interaction observable fixed independently by PDT:

```text
p(x,y | g,tau)
  proportional to
  exp[g A_rho(x) + tau B_Q(y) + C_pQ(x,y)].
```

At the condensed equilibrium, the interaction must force

```text
Cov(score_g,score_tau)
-------------------------------- = plus or minus lambda4.
sqrt(Var(score_g) Var(score_tau))
```

The interaction `C_pQ` cannot be selected to obtain this number.  It must come
from a previously fixed pQ operation: a portal term, a common substitution
constraint, a modular conditional expectation, or an observer/horizon
coarse-graining.  The filed two-scalar action supplies no tree-level candidate
at `(v,0)`, because its mixed fluctuation term vanishes there.  A loop-induced
or history-level interaction remains possible and is now the exact target.

There is now a separate horizon-density route that does not require this
coupled Fisher family. A subnormalized complementary Kraus branch scales every
entropy first-law variation by its Born weight `1-lambda4^2`, even though its
normalized conditional state is unchanged. That route succeeds only if
Jacobson's entropy density counts retained cells per original horizon area.
The tetrahedral audit independently reaches the same condition. See
`SUBNORMALIZED_HORIZON_BRANCH.md` and `PERRON_TETRAHEDRAL_BRIDGE.md`.

## Reproducibility

`fisher_score_audit.py` evaluates the KMS model at `beta=log Q`, checks its
rank-one Fisher matrix, and prints the target overlap and the independent-product
control.  The algebraic conclusions are also checked in Lean.
