# Immirzi comparison for the quartic canonical squeeze

## Result

The determinant-one part of the proposed quartic gravity response has a
specific structural parallel with the Barbero-Immirzi transformation: both
are canonical squeezes that can be invisible in classical vacuum dynamics yet
become physically meaningful when the quantum representation or the geometric
observable selects particular canonical variables.

This does not identify the deposited PDT scalar portal coefficient with the
Barbero-Immirzi parameter. The transformations act on different variables,
and their equality has not been derived.

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
gamma_Q candidate     = (2Q-1)^(1/4)
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

This makes the Immirzi question mathematically motivated. It is more than a
numerical resemblance, because the shared object is a symplectic squeeze.

## 3. Why there is no identification yet

The Barbero-Immirzi transformation acts on the Ashtekar-Barbero connection and
densitized triad. In conventional notation,

```text
A_gamma = Gamma + gamma K,
E_gamma = E/gamma.
```

The quartic construction currently acts on the two gravitational
prepotentials, or on a reduced Hodge-paired canonical mode. No map has yet
shown that the positive square root of `Khat` induces the affine connection
transformation above.

There is also a normalization ambiguity until that map is built. If the
canonical variable map is `sqrt(Khat)`, the natural scale is
`(2Q-1)^(1/4)`. If one incorrectly identifies the Hamiltonian metric `Khat`
itself with the variable map, one gets `sqrt(2Q-1)` instead. The full
connection-triad calculation must decide; dimensional or numerical analogy
cannot.

The previously audited portal quantities are different:

```text
Q/rho^2       = 0.6956291644...,
(Q/rho)^2     = 0.8491851875...,
(2Q-1)^(1/4)  = 1.0957280276....
```

None of these equalities is forced. The scalar portal coefficient can still
govern scalar-sector competition while the symplectic squeeze governs the
gravitational canonical pair.

## 4. The decisive calculation

Start from the linearized connection-triad variables and the two
prepotentials, then construct the explicit canonical map between them. Apply
the quartic half-squeeze `sqrt(Khat)` and ask whether it has the form

```text
(K,E) -> (gamma K, E/gamma)
```

in the extrinsic-curvature/triad directions, with

```text
gamma=(2Q-1)^(1/4).
```

If it does, the next test is whether the induced connection is
`Gamma+gamma K`, whether the Gauss and Hamiltonian constraints retain their
standard form, and whether the area operator scales by the same `gamma`.
Failure of any of those equalities rejects the Immirzi identification while
leaving the classical screening response intact.

If it succeeds, PDT would supply a fixed algebraic value for a canonical
scale that is otherwise free at the kinematical level. That would be a
substantial result, but it requires the variable-level derivation and cannot
be inferred from the present matrix alone.

## References

- Rovelli and Thiemann, *The Immirzi parameter in quantum general relativity*:
  <https://arxiv.org/abs/gr-qc/9705059>.
- Henneaux and Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>.
