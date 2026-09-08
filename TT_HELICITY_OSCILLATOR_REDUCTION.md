# From the spin-two action to the quartic boundary oscillator

## The question

The bulk-to-boundary calculation produced a canonical unit oscillator,

\[
L_{\rm osc}=p\,q'-\frac{q^2+p^2}{2},
\]

and showed that its Hamilton principal function at the quartic phase is the
horizon boundary generator.  That left an important question: was this
oscillator only an abstract two-dimensional model, or is it the actual mode
carried by the linearized gravitational action?

The new Lean reduction answers that question at fixed nonzero momentum.  The
oscillator is already present in the transverse-traceless spin-two
prepotential action.

## Circular graviton modes

For momentum `k` along the third axis, the generalized spin-two curl has two
circular polarization eigenvectors,

\[
e_+=(1,i),\qquad e_-=(1,-i),
\]

with eigenvalues `+k` and `-k`.  Their Hermitian norms are both two.  Write
the two duality-related prepotentials on the positive-helicity line as

\[
H^1=q e_+,\qquad H^2=p e_+.
\]

Lean evaluates the Barnich--Troessaert fixed-mode terms exactly:

\[
K_k=4k^3p\dot q,
\qquad
\mathcal H_k=2k^4(q^2+p^2),
\]

and hence

\[
L_k=4k^3p\dot q-2k^4(q^2+p^2).
\]

Use the dimensionless phase `tau=k t`, so `dot q=k q'`.  For `k` nonzero,

\[
\frac{L_k}{4k^4}
=p q'-\frac{q^2+p^2}{2}.
\]

This is exactly the canonical oscillator action used in the horizon
calculation.  The factor `4k^4` is a common mode normalization and does not
alter its stationary trajectories.

## Both helicities give the same canonical system

The negative circular polarization has the opposite curl eigenvalue.  The
canonical momentum consequently has the opposite orientation:

\[
H^1=q e_-,\qquad H^2=-p e_-.
\]

With that curl-determined sign, Lean proves the same kinetic term, the same
Hamiltonian, and the same normalized oscillator action.  The construction
therefore covers both physical graviton helicities.  It does not select one
chirality or introduce an extra propagating mode.

## The quartic exterior action

The already verified horizon dilation acts on the polarization data of each
prepotential.  Its full visible-plus-hidden action preserves the original
mode, while its exterior restriction carries

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

Combining that theorem with the helicity reduction gives, for either circular
polarization,

\[
\frac{L^{\rm ext}_{k,Q}}{4k^4}
=S_Q\left(pq'-\frac{q^2+p^2}{2}\right).
\]

The same `S_Q` multiplies the canonical term and the energy.  The exterior
mode keeps the ordinary oscillator equations, while its action normalization
changes relative to a separately normalized source.

## The endpoint action

The oscillator Hamiltonian is

\[
H_{\rm osc}=\frac{q^2+p^2}{2}.
\]

For phase `theta`, its type-one endpoint function in the sign convention of
this repository is

\[
F_\theta(q_-,q_+)
=\frac{q_-q_+-\tfrac12\cos\theta(q_-^2+q_+^2)}{\sin\theta}.
\]

Lean proves its Hamilton--Jacobi equation and proves that at

\[
\sin\theta_Q=\lambda_4,
\qquad
\cos\theta_Q=\sqrt{S_Q},
\]

this endpoint function is exactly the quartic horizon boundary generator.
The fixed-mode chain is therefore

\[
\text{spin-two TT action}
\longrightarrow
\text{two helicity oscillators}
\longrightarrow
\text{Hamilton principal function}
\longrightarrow
\text{quartic splitter}.
\]

Every arrow in this displayed fixed-mode chain is now kernel checked.

The oscillator variables also agree exactly with the intrinsic spin-two
canonical pair on a null hypersurface: the conformal metric of a cut and one
half of its densitized shear.  The circular TT norm two cancels the geometric
factor one half, giving `p delta q` for both helicities.  See
[`NULL_HORIZON_SPIN_TWO_MODE.md`](NULL_HORIZON_SPIN_TWO_MODE.md).

## What this establishes

This removes the concern that the oscillator Hamiltonian was independently
chosen to reproduce the quartic splitter.  Its form and canonical
normalization follow from the published duality-symmetric linearized gravity
action after a circular-mode reduction.  The opposite curl eigenvalues
explain the canonical orientation change between the two helicities.

The remaining physics problem is localized.  The null-boundary spin-two
symplectic data have now been reduced to the fixed-mode phase space above.
The present theorem does not derive the quartic dilation from general
relativity.  A covariant completion must show that the physical observer
restriction implements this dilation while its corner convention and the
null spin-one and spin-zero pairs introduce no independent transfer
coefficient.

## Kernel artifact and primary source

`GravityScreening/TTHelicityModeReduction.lean` proves:

- the two circular curl eigenmode reductions;
- their Hermitian normalization;
- the kinetic and Hamiltonian formulas for both helicities;
- equality of both normalized actions with the unit oscillator action;
- the exact `S_Q` exterior action for both helicities; and
- the combined quartic spin-two bulk-to-boundary capstone.

The file compiles without `sorry` and uses only Mathlib's standard logical
axioms.

- Glenn Barnich and Cédric Troessaert, *Manifest spin 2 duality with electric
  and magnetic sources*: <https://arxiv.org/abs/0812.0552>
- Marc Henneaux and Claudio Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
