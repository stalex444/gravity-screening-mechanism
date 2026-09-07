# The subnormalized horizon-branch test

## Result

The PDT gravity paper already fixes Jacobson's entropy-area density.  The open
question is why its quartic factor is

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

The minimal unitary completion of the quartic inverse-step residue has two
amplitudes

\[
K_Q=\lambda_4 I,
\qquad
K_G=d_Q I,
\qquad
d_Q^2=S_Q,
\]

and conserves total Born weight.  Because both operators are scalar, the
normalized state conditioned on either branch is unchanged.  This was
previously treated as an obstruction to using the channel for information
geometry.

Jacobson's entropy density raises a different question.  It counts entropy per
unit of the original causal-horizon area.  If the `G` branch counts the cells
remaining visible to the local observer and the `Q` branch counts cells sent
across the causal boundary, the visible state is intentionally
subnormalized:

\[
\delta\rho_G=K_G\delta\rho K_G^*=d_Q^2\delta\rho=S_Q\delta\rho.
\]

For the entropy first-law pairing,

\[
\delta S=\operatorname{Tr}(\delta\rho K),
\]

linearity then gives

\[
\delta S_G=S_Q\delta S_0.
\]

Consequently the entropy-area density and Jacobson coupling obey

\[
\eta_Q=S_Q\eta_0,
\qquad
G_Q=\frac{G_0}{S_Q}.
\]

`GravityScreening/HorizonBranch.lean` verifies the first-law scaling for every
finite diagonal perturbation and modular weight.  It also verifies the control:
dividing the branch by its Born weight renormalizes it back to the original
state and removes the screening factor.

## Why the earlier scalar-channel objection does not settle this test

The scalar flag contains no information about which input state entered the
channel.  That remains true.  It matters for a model in which the branch flag
is supposed to encode a state-dependent measurement record.

It does not prevent state-independent thinning of an extensive cell density.
A detector with efficiency `S_Q` can retain the same conditional distribution
while counting only the fraction `S_Q` of the original events.  Jacobson's
coefficient can respond to the count per original area even when the
conditional internal state of each retained cell is unchanged.

This is also why a global trace rescaling is different.  A global rescaling is
compensated when the same state is normalized and changes entropy only by an
additive constant.  Here the two-channel instrument remains normalized as a
whole, while the observer has access to only one subnormalized branch.  The
missing weight resides in a specified complementary channel.

## Connection to the phi-to-rho-Q fold

The exact unit relations

\[
N(\varphi)=N(\rho Q)=-1,
\qquad
N((\rho Q)^2-\rho Q-1)=-1
\]

provide the conservation side of the picture.  The tiny defect seen at the
positive embedding is compensated by the other conjugate directions.  The
quartic Perron residue then fixes the amplitude `lambda4`, and unitary
completion fixes the complementary visible weight `S_Q`.  In this reading,
no information is destroyed globally; the causal observer counts only one
branch of a norm-preserving arithmetic process.

The unit identities do not by themselves prove which branch a spacetime
observer sees.  They make the proposed horizon split compatible with exact
conservation.

## Decisive physical condition

This mechanism succeeds only under the following statement:

> Jacobson's `eta` counts the unconditioned expected entropy of retained PDT
> horizon cells per unit of the original geometric area.

It fails if the physical horizon construction instead conditions on the
visible branch and renormalizes it before defining the area density.  In that
case the scalar factor cancels exactly, as the Lean control theorem shows.

The next physical calculation is therefore no longer a search for a coupled
Fisher metric.  It is to construct the local horizon instrument and determine
whether its geometric area law uses the subnormalized branch or a normalized
conditional state.  Jacobson's local Rindler horizon is the correct arena for
that decision.

## Normalized erasure completion

There is a stronger version that does not leave the observer's total state
subnormalized.  Complete the retained branch by a distinguishable erasure
state:

\[
\mathcal E_Q(\rho)
=S_Q\rho\oplus\lambda_4^2|e\rangle\!\langle e|.
\]

Its trace is one because `S_Q+lambda4^2=1`.  Since the two blocks have
orthogonal support, its entropy is

\[
H(\mathcal E_Q(\rho))
=h_2(S_Q)+S_QH(\rho),
\]

where `h_2` is the binary entropy of the fixed branch weights.  For any two
equally normalized nearby states, the binary term cancels:

\[
H(\mathcal E_Q(\rho_1))-H(\mathcal E_Q(\rho_0))
=S_Q[H(\rho_1)-H(\rho_0)].
\]

Thus

\[
\delta H_{\rm out}=S_Q\delta H_{\rm in}
\]

without post-selection and without leaving the total observer state
unnormalized.  The diagonal finite-state form of this identity and the unit
mass of the erasure output are kernel-checked in
`GravityScreening/HorizonBranch.lean`.

A Stinespring realization makes the causal reading explicit.  Schematically,

\[
V|\psi\rangle
=d_Q|\psi\rangle_{\rm obs}|G\rangle_{\rm env}
+\lambda_4|e\rangle_{\rm obs}|\psi\rangle_{\rm hidden}.
\]

The retained branch leaves the state with the observer.  The other branch
places the state in the hidden system and leaves an erasure flag outside.  The
environment therefore carries precisely the information that the causal
observer cannot recover.

This construction narrows the physical gap again.  One no longer has to argue
that Jacobson uses a subnormalized entropy.  The required premise is that the
quartic inverse-step defect is realized as the erasure probability of the
local horizon channel.  The founding Q operator fixes the amplitude, and its
unitary defect fixes the transmitted weight; the causal-horizon identification
is the remaining physics.

## References

- T. Jacobson, *Thermodynamics of Spacetime: The Einstein Equation of State*,
  <https://arxiv.org/abs/gr-qc/9504004>.
- T. Jacobson, *Entanglement Equilibrium and the Einstein Equation*,
  <https://arxiv.org/abs/1505.04753>.
- C. Eling, R. Guedens, and T. Jacobson, *Non-equilibrium Thermodynamics of
  Spacetime*, <https://arxiv.org/abs/gr-qc/0602001>.
