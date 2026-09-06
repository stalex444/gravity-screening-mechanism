# Trace-normalization obstruction

## Statement

The continuous-core trace law

```text
tau after theta_s = exp(-s) tau
```

realizes the exact scalar `S_Q=1-(1-1/Q)^2` on the ray of trace weights.
However, applying that scalar only as a global trace normalization cannot
renormalize Newton's constant through Jacobson's entropy first law.

## Exact calculation

Suppose a state is represented by a positive density `h` relative to a
semifinite trace `tau`, with `tau(h)=1`. Under

```text
tau_c = c tau,
```

the same normalized state has density `h_c=h/c`. Therefore

```text
S_(tau_c)(h_c)
  = -tau_c(h_c log h_c)
  = S_tau(h)+log c.
```

The shift is independent of the state. It cancels from entropy differences,
relative entropy, and normalization-preserving first variations.

Equivalently, the modular Hamiltonian changes by

```text
K_c = -log(h/c) = K+log(c) I.
```

For `tau(delta h)=0`,

```text
tau(delta h K_c)
  = tau(delta h K)+log(c) tau(delta h)
  = tau(delta h K).
```

## Consequence for the PDT candidate

The exact core identity

```text
[I-(I-T_Q)^2]tau = S_Q tau
```

is a valid statement about the trace ray. If it is interpreted only as the
replacement `tau -> S_Q tau`, it changes entropy by `log S_Q`; it does not
produce `eta -> S_Q eta` in the variational sense required to change `G`.

The earlier Jacobson bridge is therefore conditional:

```text
eta_Q=S_Q eta_0  implies  G_Q=G_0/S_Q,
```

but its premise is not supplied by global trace scaling.

## Reverse condition

For the entropy first law to scale on all relevant trace-zero perturbations,
the operative modular generator must satisfy, on that perturbation space,

```text
K_Q = S_Q K_0 + c I
```

or an equivalent projected relation. The additive term is physically
invisible. The multiplicative change in the noncentral part is what must be
derived.

This localizes the next search to mechanisms that alter at least one of:

- the physical area operator or its calibration;
- the noncentral observer/modular Hamiltonian;
- the local distribution of horizon cell weights.

It also supplies a decisive rejection test: a mechanism that produces only an
overall rescaling of `tau` cannot be the gravity-screening mechanism.

The strongest current escape uses the standing F373 Lorentzian Hodge-pair
operator. If `I+lambda4 C` is a gravitational kinetic stiffness, the
orientation-even mean of its two inverse chiral responses is
`1/(1-lambda4^2)`. This is a noncentral operator effect and is therefore not
removed by state normalization. See `HODGE_CHIRAL_SCREENING.md`.

## Formal verification

`GravityScreening/Basic.lean` contains four declarations for this point:

- `entropyContribution_trace_rescale`;
- `entropyDifference_trace_rescale`;
- `firstLaw_add_constant`;
- `firstLaw_affine_scale`.

They use only standard Mathlib axioms. `verify.py` independently checks the
normalization shift and cancellation numerically at high precision.
