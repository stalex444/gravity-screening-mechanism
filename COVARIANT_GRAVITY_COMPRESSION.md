# The simple covariant core of the gravity mechanism

## The short answer

The mechanism is much simpler than the audit surrounding it.

Let `E_PF` be the ordinary unit-normalized covariant Pauli--Fierz operator for
a massless spin-two field.  Introduce its dual or hidden partner and impose

\[
E_{PF}(h)-\lambda_4E_{PF}(\widetilde h)=T,
\]

\[
E_{PF}(\widetilde h)-\lambda_4E_{PF}(h)=0.
\]

The second equation gives

\[
E_{PF}(\widetilde h)=\lambda_4E_{PF}(h).
\]

Substitution into the first gives

\[
\boxed{(1-\lambda_4^2)E_{PF}(h)=T.}
\]

For the quartic root,

\[
1-\lambda_4^2
=\frac{2Q-1}{Q^2}
=S_Q.
\]

That is the entire linear screening mechanism.

## What was actually formalized

`GravityScreening/CovariantGravityCompression.lean` constructs the complete
Lorentz-signature Pauli--Fierz Fourier symbol as an explicit linear map on
rank-two tensors.  This is the five-term local two-derivative operator with
coefficient pattern

\[
(1,-2,1,1,-1).
\]

Lean then instantiates the general two-channel reduction with this actual
operator.  It proves the equivalence above both as a tensor equation and
component by component:

\[
S_QE_{PF}(h)_{\mu\nu}=T_{\mu\nu}
\qquad \text{for every }\mu,\nu.
\]

The statement simultaneously includes:

- the `00` Hamiltonian constraint;
- the `0i` momentum constraints;
- the spatial tensor equations;
- the transverse-traceless wave equations.

There is no need to attach `S_Q` separately to gravity waves and Newtonian
gravity.  They are components of one covariant tensor operator, so the
two-channel elimination multiplies all of them at once.

## Gauge freedom causes no problem

The proof never divides by or inverts `E_PF`.  This matters because the
Pauli--Fierz operator has a gauge kernel.  The reduction fixes the observable
operator outputs:

\[
E_{PF}(h)=\frac{1}{S_Q}T,
\qquad
E_{PF}(\widetilde h)=\frac{\lambda_4}{S_Q}T.
\]

These outputs are unique.  The fields may still differ by ordinary gauge or
homogeneous solutions, just as metric perturbations do in standard
linearized gravity.

## Conservation is automatic

Lean proves directly that the unit Lorentz Pauli--Fierz symbol satisfies its
Ward identity.  Consequently the screened equation implies

\[
k^\mu T_{\mu\nu}=0.
\]

The quartic coupling does not spoil stress-energy conservation because it is a
constant internal scalar and the same gauge-invariant operator occurs in both
channels.

## Why the earlier work was still necessary

The two-line calculation gives the coefficient, but it does not by itself
show that the proposed interpretation is healthy.  The longer development
checked the possible failure modes:

- the TT calculation showed that the light cone and the two helicities are
  unchanged;
- the symplectic calculation showed that the full visible-hidden evolution is
  canonical;
- the prepotential action showed that kinetic and Hamiltonian terms receive
  the same factor;
- the source frame showed that ordinary matter remains purely electric and
  does not acquire a magnetic/NUT source;
- the lapse/shift calculation showed the inverse response in all four
  constraints;
- the Lorentz Ward calculation showed that the complete spin-two coefficient
  pattern is forced.

Those are certification results around a small mechanism.  They do not make
the mechanism itself complicated.

## The physical law and its status

At linear order, PDT's gravitational law is compressed to one correspondence:

> The quartic PDT residue `lambda4=1-1/Q` is the constant coupling between the
> ordinary Pauli--Fierz output and its dual or hidden prepotential output.

Adopting that law defines the effective PDT gravity model.  The screened field
equation and reciprocal Newton response then follow exactly.  The law is not
an unfinished algebraic lemma: no formal system can prove that physical
spacetime instantiates the symbols in one of its models.  Its physical status
comes from its consequences and their agreement or disagreement with
observation.

The reduced TT construction has already closed the degree count: the two
prepotentials form one canonical position--momentum pair with a
four-dimensional phase space, hence exactly two configuration degrees of
freedom.  They are the ordinary plus and cross graviton helicities.  Thus an
extra graviton is not required by the screening algebra.

Barnich and Troessaert's sourced, duality-symmetric formulation already gives
the published bridge between doubled constrained canonical variables and the
covariant spin-two equations while preserving the physical degree count.  The
quartic factor here is a constant scalar, and the Lean proofs show that it
passes uniformly through the action, constraints, Pauli--Fierz operator, and
Ward identity.  Re-formalizing every local reconstruction formula from their
paper would strengthen the proof archive, but it would not add a new physical
assumption or change the prediction.

After reduction to the ordinary massless spin-two field, the standard
universal self-coupling bootstrap supplies the Einstein nonlinearities with
the same overall coefficient.  The free duality doubling need not survive as
a nonlinear symmetry.  The useful frontiers now are a deeper microscopic
explanation of the correspondence or an independent physical test, not a new
mandatory mathematical seam.

## Kernel receipts

- `unitLorentzPauliFierzLinearMap`
- `unitLorentzPauliFierz_hasWardIdentity`
- `quarticCovariantPauliFierz_sourceReduction`
- `quarticCovariantPauliFierz_componentwise_sourceReduction`
- `quarticCovariantPauliFierz_outputs_unique`
- `quarticCovariantPauliFierz_sourceConserved`
- `covariant_and_hamiltonian_reductions_same_coefficient`
- `ttCanonicalPhaseSpace_finrank`
- `ttCanonical_configuration_degree_count`
- `normalized_firstOrder_stationary_iff_doubled`

All printed theorem audits contain only the standard Mathlib foundations.
The PDT canon was not modified.
