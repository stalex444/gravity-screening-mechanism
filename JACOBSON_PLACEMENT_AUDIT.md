# Where the quartic channel must enter Jacobson's equation

## Finding

The modular-covariant erasure theorem establishes an exact information
contraction, but that contraction does not automatically renormalize Newton's
constant.  The location of the factor in the horizon first law is decisive.

Jacobson's construction starts from

\[
\delta Q=T\,\delta S,
\qquad
\delta S=\eta\,\delta A,
\qquad
G=\frac{1}{4\hbar\eta}.
\]

The crossed-product horizon framework preserves the same separation.  At
leading semiclassical order its entropy contains a matter relative-entropy
term and a distinct geometric area or asymptotic-charge term.  Data processing
acts directly on the former.  It does not, merely by acting there, multiply
the coefficient of the latter.

This gives a placement test that the gravity mechanism has to pass.

## 1. The exact scaling ledger

Let `h` multiply the physical heat-flux side of the Clausius relation, and let
`e` multiply the entropy-per-area coefficient.  Relative to a baseline
coupling `G_0`, the resulting coupling is

\[
\boxed{G'=\frac{h}{e}G_0.}
\]

The possibilities are therefore:

| Placement of `S_Q` | `h` | `e` | Result |
|---|---:|---:|---:|
| entropy density only | `1` | `S_Q` | `G_0/S_Q` |
| heat flux only | `S_Q` | `1` | `S_QG_0` |
| both sides | `S_Q` | `S_Q` | `G_0` |
| neither side | `1` | `1` | `G_0` |

The deposited PDT gravity response is the first row.  Applying the same
information factor to both sides cancels exactly.  Applying it only to the
heat flux gives the opposite response.

There is also a uniqueness statement.  Once the entropy-density response is
fixed to `e=S_Q`, the target `G'=G_0/S_Q` requires `h=1`, provided `G_0` and
`S_Q` are nonzero.  This is kernel-checked in
`GravityScreening/JacobsonPlacement.lean`.

## 2. What the dilation adds

The explicit erasure dilation distinguishes exterior accessibility from a
globally counted observable.  For any real diagonal observable `K`, it gives

\[
\langle K\rangle_{\rm out}=s\langle K\rangle_{\rm in},
\qquad
\langle K\rangle_{\rm hid}=(1-s)\langle K\rangle_{\rm in},
\]

and hence

\[
\boxed{
\langle K\rangle_{\rm out}+\langle K\rangle_{\rm hid}
=\langle K\rangle_{\rm in}.}
\]

At `s=S_Q`, exterior distinguishability and the exterior contribution of `K`
are screened, while the corresponding globally extended expectation remains
unscaled.  Taking `K` to be a diagonalized finite modular Hamiltonian gives a
cell-level model in which the clock is covariant, accessible information is
contracted, and total modular energy is conserved.

This matters because it makes the required first row of the table internally
possible.  The entropy density can carry `S_Q` while a globally counted flux
has `h=1`.  The construction does not by itself prove that Jacobson's
stress-energy flux is this globally extended observable.  It identifies the
precise physical interpretation required.

## 3. The correct and incorrect gravity readings

The following inference is invalid:

```text
relative entropy contracts by S_Q
therefore the coefficient of A/(4G) contracts by S_Q.
```

The geometric coefficient is a separate term in generalized entropy.  A
channel on matter states alone does not transfer its contraction coefficient
to that term.

The viable inference is more specific:

```text
the quartic channel preserves the globally normalized horizon flux
+ its retained branch fixes the number of independent exterior cells per area
=> eta_Q = S_Q eta_0 while h = 1
=> G_Q = G_0/S_Q.
```

The first line now has a finite kernel-checked model.  The second line remains
the physical area-density identification.  `INFORMATION_AREA_BRIDGE.md` now
derives its power without separately assuming a coframe response: the erasure
channel scales the full Fisher/BKM metric by `S_Q`, so the information-area
form on a two-dimensional horizon state surface also scales by `S_Q`.  What is
still missing is the identification of that information-area measure with the
microscopic density entering the physical horizon area law.

## 4. The next theorem has become very small

The remaining bridge can be stated as an intertwining condition.  Let
`V_Q` be the quartic dilation, `K_flux` the generator defining the physical
horizon heat flux, and `E_A` the two-dimensional inverse-area frame.  The
desired construction must establish

\[
V_Q^*K_{\rm flux}^{\rm global}V_Q=K_{\rm flux},
\qquad
\det(E_A')=S_Q\det(E_A).
\]

The first equation is already modeled for every finite diagonal observable.
The second follows from the proved Fisher-metric response if the physical
horizon coframe is the coframe of that information geometry.  Establishing
this information-area identification in the curvature or observer constraint
is now the sole model-specific step.

A candidate fails if it scales both the physical heat flux and the entropy
density by `S_Q`, if it acts only on normalized matter entropy, or if its
horizon coframe determinant is not exactly `S_Q`.

## Kernel artifacts

`GravityScreening/JacobsonPlacement.lean` proves:

- common heat/entropy scaling cancels;
- entropy-only placement gives the inverse response;
- heat-only placement gives the direct response;
- the inverse response with entropy scale `s` forces unit heat normalization;
- both quartic specializations.

`GravityScreening/ConservedFlux.lean` proves:

- the exterior expectation has weight `s`;
- the hidden expectation has weight `1-s`;
- their sum equals the input expectation;
- the exact quartic specialization.

All declarations contain no `sorry` and use only Mathlib's standard
foundational axioms.

## References

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- T. Faulkner and A. J. Speranza, *Gravitational algebras and the generalized
  second law*, <https://arxiv.org/abs/2405.00847>.
