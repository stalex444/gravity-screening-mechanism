# Immirzi comparison for the quartic canonical squeeze

## Result

The determinant-one part of the proposed quartic gravity response has a
specific structural parallel with the Barbero-Immirzi transformation: both
involve canonical changes of variables that can be invisible in classical
vacuum dynamics yet become physically meaningful when the quantum
representation or a geometric observable selects particular canonical
variables.

The direct identification fails at the current level. The quartic squeeze
mixes the two linearized gravitational prepotentials, while the
Barbero-Immirzi map is a local affine transformation of connection and triad
variables. The prepotential-to-metric map has unequal derivative orders and a
nonlocal inverse, so the two transformations cannot simply be equated. The
deposited PDT scalar portal coefficient is not identified with the
Barbero-Immirzi parameter either.

## 1. The exact quartic squeeze

The normalized internal response is

```text
Khat = 1/d [[1,        -lambda4],
            [-lambda4, 1       ]],
d = sqrt(1-lambda4^2).
```

Writing `lambda4=tanh(theta)` gives

```text
Khat = [[cosh(theta), -sinh(theta)],
        [-sinh(theta), cosh(theta)]].
```

Its eigenvalues are `exp(theta)` and `exp(-theta)`. The canonical
transformation that maps the identity Hamiltonian to `Khat` is its positive
square root, with reciprocal eigenvalues `exp(theta/2)` and
`exp(-theta/2)`.

The quartic definition `lambda4=1-1/Q` makes the ratio exact:

```text
(1+lambda4)/(1-lambda4) = 2Q-1.
```

Therefore

```text
exp(theta)   = sqrt(2Q-1),
exp(theta/2) = (2Q-1)^(1/4).
```

Numerically,

```text
theta                 = 0.1828380153932759051...,
sqrt(2Q-1)            = 1.2006199103844309273...,
quartic half-squeeze  = u_Q = (2Q-1)^(1/4)
                      = 1.0957280275617809199....
```

The equation for the ratio is kernel checked. The exponential and fourth-root
expressions are standard consequences for real `theta` and positive `Q`.

## 2. The genuine parallel

Rovelli and Thiemann describe the Immirzi transformation as a one-parameter
canonical transformation of connection and triad variables. Classically it
preserves the kinematical structure. In the loop representation it need not be
unitarily implementable, and the scale of discrete geometric spectra depends
on the parameter.

The quartic `Khat` has the first part of that pattern:

1. it preserves the symplectic form exactly;
2. it is a canonical change of variables in the constant, source-free
   linearized theory;
3. it rescales reciprocal canonical directions;
4. it can become observable only after a source, geometric observable, or
   quantum representation selects a preferred canonical frame.

This makes the Immirzi comparison mathematically motivated. It is more than a
numerical resemblance, because both discussions concern canonical scaling.
It is still only a structural parallel.

## 3. Why there is no identification yet

The Barbero-Immirzi transformation acts on the Ashtekar-Barbero connection and
densitized triad. In conventional notation,

```text
A_gamma = Gamma + gamma K,
E_gamma = E/gamma.
```

The quartic construction acts on the two gravitational prepotentials, or on a
reduced Hodge-paired canonical mode. The standard maps are schematically

```text
pi = two spatial derivatives of P,
h  = one spatial derivative of Phi plus gauge,
P  = inverse Laplacian applied to pi plus trace terms,
Phi = inverse Laplacian applied to a derivative of h.
```

Consequently a constant half-squeeze

```text
(P,Phi) -> B(P,Phi)
```

mixes `pi` with second derivatives of `Phi` and mixes `h` with first
derivatives of `P`. Expressed only in `(h,pi)`, inverse Laplacians appear. This
is the familiar nonlocal character of gravitational electric-magnetic
duality; it is not the local affine connection transformation
`A_gamma=Gamma+gamma K`.

The naive variable-level identification is therefore rejected. A more
elaborate connection formulation could still relate the two structures, but
it would need additional derivative operators and cannot be inferred from
`Khat` alone.

The two numerical scales also refer to different objects. The canonical
half-squeeze `sqrt(Khat)` carries `u_Q=(2Q-1)^(1/4)`, while the Hamiltonian
metric `Khat` carries squared eigenvalue `sqrt(2Q-1)`. Neither is an Immirzi
parameter without a connection-triad map.

The previously audited portal quantities are different:

```text
Q/rho^2       = 0.6956291644...,
(Q/rho)^2     = 0.8491851875...,
(2Q-1)^(1/4)  = 1.0957280276....
```

None of these equalities is forced. The scalar portal coefficient can still
govern scalar-sector competition while the symplectic squeeze governs the
gravitational canonical pair.

## 4. The surviving research question

The direct prepotential map has failed. The remaining route would start from a
connection formulation that contains both the ordinary and dual gravitational
connections. One could then ask whether the quartic half-squeeze, together
with the required spatial derivative map, induces

```text
(K,E) -> (gamma K, E/gamma)
```

in the extrinsic-curvature/triad directions, with

```text
gamma=u_Q=(2Q-1)^(1/4).
```

If such a construction exists, the next test is whether the induced
connection is
`Gamma+gamma K`, whether the Gauss and Hamiltonian constraints retain their
standard form, and whether the area operator scales by the same `gamma`.
Failure of any of those equalities rejects the Immirzi identification while
leaving the classical screening response intact.

Until that construction is produced, the honest conclusion is:

```text
u_Q is the exact scale of the quartic half-squeeze;
u_Q is not established as the Barbero-Immirzi parameter.
```

If the stronger construction succeeds, PDT would supply a fixed algebraic
value for a canonical scale that is otherwise free at the kinematical level.
That would be a substantial result, but the present prepotential calculation
does not establish it.

## References

- Rovelli and Thiemann, *The Immirzi parameter in quantum general relativity*:
  <https://arxiv.org/abs/gr-qc/9705059>.
- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
