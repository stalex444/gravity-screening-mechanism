# Finite packing contrast and comparison with the earlier Pisot suite

## Result

The tetrahedral finite-digit construction was evaluated exactly in the rings
`Z[phi]`, `Z[rho]`, and `Z[Q]` through refinement depth 8. Floating coordinates were used
to locate nearest neighbours; every reported nearest-neighbour distance was
then recomputed at 80 decimal digits from the exact algebraic coefficient
difference.

| depth | `phi` points | `phi` min | `rho` points | `rho` min | `Q` points | `Q` min |
|---:|---:|---:|---:|---:|---:|---:|
| 0 | 5 | 1.73205080757 | 5 | 1.73205080757 | 5 | 1.73205080757 |
| 1 | 25 | 1.07046626932 | 25 | 0.562428000078 | 25 | 0.382339970007 |
| 2 | 115 | 1.07046626932 | 125 | 0.562428000078 | 125 | 0.382339970007 |
| 3 | 525 | 1.07046626932 | 575 | 0.424564336131 | 625 | 0.187429216656 |
| 4 | 2,363 | 0.661584538250 | 2,595 | 0.182630471283 | 2,875 | 0.153536862492 |
| 5 | 10,545 | 0.661584538250 | 10,885 | 0.137863663947 | 12,975 | 0.0843992866875 |
| 6 | 46,509 | 0.661584538250 | 44,433 | 0.137863663947 | 58,375 | 0.0413738908591 |
| 7 | 203,785 | 0.661584538250 | 177,313 | 0.137863663947 | 259,245 | 0.0338923541641 |
| 8 | 887,519 | 0.661584538250 | 685,171 | 0.137863663947 | 1,135,851 | 0.0277636849455 |

The finite data show the behavior forced asymptotically by Bandt--Meyer:

* the two Pisot controls both show finite plateaus: the observed `phi` minimum
  has remained fixed for five consecutive depths, and the observed `rho`
  minimum for four;
* Bandt--Meyer specifically prove that the balanced tetrahedral `rho`
  construction is a Meyer set, so some positive infinite-depth separation
  floor is guaranteed for `rho`, although the present computation does not
  prove that the displayed finite plateau is the final floor;
* the `Q` minimum continues to fall; because the approximants are nested and
  their union cannot be uniformly discrete, their sequence of minimum
  separations must have infimum zero.

The calculation is a numerical illustration of the theorem, not the oracle
for it. The source theorem supplies the infinite-depth `rho` result and the
infinite-depth `Q` obstruction. The finite `phi` control prevents a stronger
claim that separation alone uniquely selects `rho` as three-dimensional.

## The decisive morphic control

The `phi` run separates two questions that had been conflated:

1. **Pisot versus non-Pisot:** both `phi` and `rho` retain well-separated
   finite records in the observed range, while `Q` crowds progressively.
2. **Why `rho` for three dimensions:** minimum separation alone does not
   answer this. What currently singles out `rho` is Bandt--Meyer's explicit
   three-dimensional Meyer-set theorem for the balanced tetrahedral digits,
   not an exclusive inability of `phi` to inhabit three-dimensional space.

Aarts--Fokkink--Kruijtzer prove that `phi` and `rho` are the only morphic
numbers, a theorem formalized in Palomar entry `PALOMAR-2026-09-01-000008`.
Lean now proves `phi>4/3` and `rho<4/3`. Since `4/3` is the coverage threshold
in Bandt--Meyer's balanced tetrahedral argument, `rho` is the unique morphic
number which passes that three-dimensional gateway. The quartic root also
satisfies `Q<4/3`, so it passes the coverage inequality, but its non-Pisot
conjugates prevent uniform separation.

The resulting exact distinction is:

```text
phi: separated, above the tetrahedral coverage gateway
rho: covered + separated = a three-dimensional Meyer packing
Q:   covered + unresolved = relatively dense crowding
```

The gateway is a sufficient construction criterion, so the first line does
not prove that every possible three-dimensional `phi` pattern fails. Assigning
the displayed mathematical construction to physical space remains the PDT
physical identification.

## The earlier `PDT-pisot-test-suite`

The public repository `stalex444/PDT-pisot-test-suite` contains three useful
visual demonstrations:

1. distance of `theta^n` from the nearest integer and the cumulative squared
   distance;
2. an amplitude-damping model whose cumulative noise uses powers of a chosen
   conjugate modulus;
3. a Qiskit simulation of the corresponding chosen damping channel.

Its first test is the arithmetic shadow of the present packing test. The
Pisot power criterion says that the one-dimensional scale orbit approaches
integers. The Meyer-set criterion says that the much larger set of all finite
digit histories remains uniformly separated. The latter is closer to the
claim that a spatial present is an information-packing problem.

The two later tests are conditional physical illustrations. Their
convergence/divergence is built into the selected cumulative-noise rule, and
Qiskit verifies the behavior of that simulated channel. They do not by
themselves establish that nature uses the channel. The earlier repository's
scope paragraph partly records this limitation, but phrases such as “phase
transition verified” should be read as “phase transition in the specified
model demonstrated.”

There is also a numerical precision limitation in the notebook. It uses
binary floating-point powers and nearest-integer rounding through exponent
200. Once a power exceeds the exact-integer range of binary64, its fractional
part cannot be trusted. The new packing script instead retains every point as
exact integer coefficients in the appropriate algebraic basis and uses high
precision only at the final distance evaluation.

The existing repository remains valuable as an intuitive entry point. A
future revision can add the present experiment as a theorem-backed spatial
test and calibrate the physical wording of Tests 2 and 3.

## Four ticks: recurrence closure versus settling

The raw number of digit words at depth `m` is `5^(m+1)`. Distinct-point counts
first fall below that raw count exactly when the defining polynomial relation
can identify different words:

* `rho^3=rho+1`: the first collision is at depth 3, after the four digit
  positions `0,1,2,3` have appeared;
* `Q^4=Q+1`: the first collision is at depth 4, after the five positions
  `0,1,2,3,4` have appeared, or after four updates from the initial position.

This gives an exact sense in which the Q process has order four or “closes its
memory after four ticks.” It is different from metric settling. Algebraic
closure says that the next scale is computable from four preceding powers;
uniform discreteness asks whether different entire histories retain a fixed
minimum separation. Q has the first property and fails the second.

That distinction is physically promising:

```text
four-step Q recurrence = finite update memory
non-Pisot Q conjugates = unresolved alternatives persist
rho Meyer property     = a spatial record can remain separated
```

It prevents “four ticks” from being contradicted by the continuing Q decay.
It also supplies a precise candidate statement: four-dimensional time is a
finite-memory update rule whose successive outputs are resolved into
uniformly separated three-dimensional records.

## Reproducibility and scope

Artifacts:

* `packing_contrast.py` — exact-basis generator and high-precision distance
  check;
* `packing_contrast.csv` — full numerical output;
* `packing_contrast.png` — logarithmic minimum-separation plot;
* `GravityScreening/ThreeDPackingWitness.lean` — kernel check of the balanced,
  noncoplanar tetrahedral digit geometry.
* `GravityScreening/TetrahedralCoverage.lean` — kernel check of the
  barycentric coefficient decomposition behind `3K+F=4K`.
* `GravityScreening/MorphicPackingThreshold.lean` — kernel check that only the
  plastic member of the morphic pair lies below `4/3`, while `Q` does too.

The computation does not derive time, quantum mechanics, or gravity from the
Meyer set. It establishes a rigorous mathematical target for the physical
identification and shows that the finite approximants behave in the direction
the theorem requires.

## Source

* C. Bandt and Y. Meyer, *Self-similar Delone sets and Pisot numbers*,
  Theorem 1 and Proposition 7, <https://arxiv.org/abs/2608.11867>.
* J. Aarts, R. Fokkink, and G. Kruijtzer, *Morphic numbers*,
  Nieuw Archief voor Wiskunde 5/2 (2001), 56--58,
  <https://www.nieuwarchief.nl/serie5/pdf/naw5-2001-02-1-056.pdf>.
