# Structural rigidity of a conservative two-polarization response

## The mathematical question

A standard siren infers distance by comparing two parts of the same waveform:
the phase evolution, which determines the chirp scale, and the strain
amplitude, which carries the inverse-distance factor.  Any response common to
both measurements cancels.  The observable can change only if the chirp and
the strain see different channels.

This raises a classification question independent of PDT:

> How much freedom remains in a real response on the two transverse-traceless
> polarizations if it is rotationally covariant, self-adjoint, passive, has a
> prescribed quadratic weight, and is the visible part of a globally
> conservative two-channel dilation?

The answer proved in Lean is: none.

## General rigidity theorem

Let `J` be the quarter-turn on the plus/cross polarization plane and let `M`
be an arbitrary real two-by-two matrix.  Fix a retained quadratic weight
`0 < s <= 1`.  Assume

1. `M J = J M` (polarization covariance);
2. `M^T = M` (self-adjoint response);
3. `M^T M = s I` (the prescribed quadratic weight);
4. `M_00 >= 0` (the passive branch).

Then

```text
M = sqrt(s) I.
```

Now place this exterior block in the norm-preserving two-channel dilation

```text
psi |-> sqrt(s) psi_visible + sqrt(1-s) psi_hidden.
```

For every finite state and every real diagonal observable, the visible and
hidden expectations add exactly to the original expectation.  If the chirp
source is this complete conserved expectation while the detector reads the
exterior TT amplitude, every nonzero common source response cancels and the
inferred standard-siren distance is forced to be

```text
d_inferred = d_true / sqrt(s).
```

The theorem quantifies over the response matrix, the state, the diagonal
observable, and the common source response.  The conclusion is therefore a
rigidity and identifiability result, rather than a calculation made after
choosing a particular attenuation matrix.

The kernel-checked declaration is
`GravityScreening.structuralTT_globalFlux_standardSirenDistance` in
`GravityScreening/GravitationalWaveObservables.lean`.  Its matrix-rigidity
input is `GravityScreening.ttResponse_unique_of_symmetry_weight`, and its
global-conservation input is
`GravityScreening.erasureDilation_total_expectation`.

## The quartic PDT corollary

PDT supplies the retained weight rather than leaving it free.  For the
positive real root `Q` of

```text
Q^4 = Q + 1,
```

the proposed quartic channel has

```text
s_Q = (2Q - 1) / Q^2.
```

The general theorem therefore specializes to

```text
R_Q = d_inferred / d_true
    = 1 / sqrt(s_Q)
    = 1 / sqrt((2Q - 1) / Q^2).
```

The Lean proof gives the rigorous rational interval

```text
1.016 < R_Q < 1.017.
```

It also proves two exact algebraic fingerprints obtained by eliminating `Q`.
For the exterior amplitude `A_Q = sqrt(s_Q)`,

```text
A_Q^8 + 3 A_Q^6 - 2 A_Q^4 + 22 A_Q^2 - 23 = 0.
```

For the distance response `R_Q = 1/A_Q`,

```text
23 R_Q^8 - 22 R_Q^6 + 2 R_Q^4 - 3 R_Q^2 - 1 = 0.
```

Thus `Q` remains essential: the general theorem derives the form of the
response, while the quartic equation fixes its exact value and algebraic
signature. Lean proves more than the two displayed identities. An explicit
Rabin/Frobenius certificate proves the amplitude polynomial irreducible after
reduction modulo five; monicity and Gauss's lemma lift the result through the
integers to the rationals. It follows in the kernel that both `A_Q` and `R_Q`
have minimal-polynomial degree exactly eight.

The observable also retains the complete quartic generator. Lean proves

```text
Q = (4 - A_Q^2 + A_Q^6) / (8 - 4 A_Q^2 - A_Q^6),
```

and therefore

```text
[ℚ(A_Q) : ℚ(Q)] = 2.
```

This separates three arithmetic layers that should not be conflated: the
quartic generator has degree four, the amplitude and reciprocal response have
degree eight, and the already registered joint PDT substrate
`ℚ(ρ,Q)=ℚ(ρQ)` has degree twelve.

## Relation to established gravitational-wave theory

The possibility that gravitational-wave and electromagnetic luminosity
distances differ is established background, not an originality claim of this
project.  Belgacem, Dirian, Foffa, and Maggiore derive modified propagation
laws and identify the luminosity-distance ratio as a standard-siren
observable:

- [The gravitational-wave luminosity distance in modified gravity theories](https://arxiv.org/abs/1712.08108)
- [Modified gravitational-wave propagation and standard sirens](https://arxiv.org/abs/1805.08731)

In the latter paper, their equation (29) relates the squared distance ratio to
an effective-Newton-coupling ratio for a class of theories with conserved
graviton number.  They also explain that apparent leakage from a
four-dimensional observer into extra dimensions changes that conservation
accounting.  The present finite theorem isolates an analogous mathematical
distinction: the complete dilation is conservative, while the exterior
observer sees only a fixed part of the quadratic weight.

Future interferometers are expected to test modified gravitational-wave
propagation at percent-scale accuracy, so a fixed response in the interval
above is in a physically meaningful range rather than being a formally exact
but observationally inaccessible quantity:

- [Testing modified gravity at cosmological distances with LISA standard sirens](https://arxiv.org/abs/1906.01593)

These citations should be recorded as background or as the source of the
standard-siren observable.  The repository should not use `original-proof`
for the general luminosity-distance relation.

## Exact scope of the physical premise

The Lean theorem proves an implication.  Its physical premise is that chirp
evolution counts the complete visible-plus-hidden conserved flux while the
detector reads only the exterior TT amplitude.  The theorem does not prove
that Nature selects this placement.

The repository also proves the competing placement: when the same physical
metric response enters source evolution and detector readout, the common
factor cancels and the standard-siren distance is unchanged.  This produces a
clean experimental fork:

```text
same physical response in chirp and strain  -> R = 1
global conserved chirp, exterior TT strain -> R = 1/sqrt(s_Q)
```

There is no adjustable response between these conclusions under the stated
hypotheses.  Data can therefore reject the proposed observer placement rather
than merely retune it.

## Recommended Palomar result group

The next submission should be a new result group centered on the following
declarations:

1. `structuralTT_globalFlux_standardSirenDistance` — the general rigidity
   theorem;
2. `quarticStructuralTT_standardSirenRatio_bounds` — the parameter-free PDT
   specialization and interval;
3. `quarticStandardSirenResponse_algebraicSignature` — the exact polynomial
   fingerprint of the observable;
4. `quarticStandardSirenResponse_minpoly_natDegree` — exact response degree;
5. `quarticExteriorAmplitude_algebraicSignature` — the monic algebraic
   fingerprint of the exterior amplitude;
6. `quarticExteriorAmplitude_minpoly_natDegree` — irreducibility and exact
   amplitude degree;
7. `quarticExteriorAmplitude_relativeDegree` — the quadratic extension of
   the recovered quartic field; and
8. `quarticUniversalResponse_cancels_from_standardSiren` — the competing
   common-response branch.

This group answers one research question: structural assumptions determine
whether a conservative hidden channel is invisible to a standard siren or
produces one fixed bias, and the quartic PDT specialization converts that
classification into an exact algebraic prediction whose field degree and
quartic ancestry are both certified.

The older Lorentz coefficient extraction and two-channel elimination remain
dependencies and background.  Making them the headline again would not
answer Palomar's objection that the selected results were routine identities.

## Strongest next extension

The remaining step most likely to move the result from a finite structural
note to a gravitational-wave research result is to formalize the cosmological
transport law.  One should derive the redshift-dependent amplitude equation,
prove the corresponding luminosity-distance ratio, and show exactly where the
quartic exterior weight enters.  That would connect the finite channel
rigidity theorem to the established modified-propagation framework while
preserving the two explicit experimental branches above.
