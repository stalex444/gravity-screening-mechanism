# Does the scalar portal coefficient normalize the Hodge screen?

## Verdict

No. The deposited portal coefficient

```text
kappa=(Q/rho)^2
```

cannot be the additional coupling multiplying the quartic Perron residue in
the doubled Hodge action. Doing so changes the predicted gravity factor from

```text
1-lambda4^2
```

to

```text
1-kappa^2 lambda4^2.
```

Since `1<Q<rho`, one has `0<kappa<1`, so these are exactly unequal. Lean proves
the general statement as `pdtPortalCoupling_screening_ne`.

Numerically,

```text
kappa                              = 0.849185187527747...
1-kappa^2 lambda4^2               = 0.976420547763002...
1/(1-kappa^2 lambda4^2)           = 1.024148869348375...

1-lambda4^2                       = 0.967301420088540...
1/(1-lambda4^2)                   = 1.033803920093974...
```

Using the unsquared ratio `chi=Q/rho` also misses:

```text
1-chi^2 lambda4^2                 = 0.972232850285996...
1/(1-chi^2 lambda4^2)             = 1.028560184636671...
```

Thus the portal coefficient and the gravitational screening coefficient do
different jobs.

## Why the distinction is structural

In the deposited two-scalar potential, `kappa` controls competition between
the cubic and quartic order parameters:

```text
kappa Phi^2 Psi^2.
```

The proposed Hodge term instead couples a geometric mode to a dual geometric
mode, with the Q-sector residual supplying the normalized cross response:

```text
-2 lambda4 <X,JY>.
```

Multiplying this term by `kappa` would count the cubic/quartic interface ratio
again. The target formula contains no such extra factor, and the reverse
theorem shows that any additional positive coupling must equal one.

The standing portal-angle result F371 reaches the same boundary from time
evolution: observables depend on the product `kappa*g*t`, so `kappa` alone
cannot fix the generator normalization `g` or a dimensional tick. Its exact
Barbero-Immirzi/rate identity

```text
gamma_candidate=kappa log(rho)
```

is an angle identity; it does not make `kappa` the Hodge-screen coefficient.
The standing Hamiltonian power count F378 likewise distinguishes a direct
`kappa` vertex from a `chi` amplitude: their Born squares carry different
powers. Neither result supplies the unit cross-normalization required here.

## What can fix the unit coefficient

The cleaner possibility is the graph norm of the actual quartic residual
contraction. On its Perron line,

```text
T_Q=lambda4 J.
```

The canonical defect completion is

```text
|Y+T_Q X|^2 + <X,(I-T_Q^T T_Q)X>.
```

Expanding it gives

```text
|X|^2+|Y|^2-2 lambda4 <X,JY>,
```

up to the orientation convention. Here the unit cross-normalization is part
of using `T_Q` itself and its minimal norm-preserving completion. Replacing it
by `g T_Q` defines a different contraction and a different defect.

This does not derive the gravitational action form. It gives a precise
conditional reason for the normalization once that form is selected: the
action is the graph norm of the quartic residual, rather than a generic portal
interaction decorated with an adjustable coefficient.

The remaining source-level question is therefore even sharper:

> Why does the horizon or curvature quadratic form use the canonical graph
> norm of the biorthogonally compressed Q residual?

`kappa` can still govern how the cubic and quartic scalar sectors exchange
energy or select a vacuum. It does not normalize the local Hodge screening
response.
