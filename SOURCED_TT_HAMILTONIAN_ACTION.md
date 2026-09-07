# One sourced Hamiltonian action for propagation and constraints

## Why this step matters

The previous result showed separately that the quartic channel scales the
transverse-traceless prepotential action and that the doubled constraint block
produces the inverse electric response.  A static Newton field is fixed by the
lapse constraint, so agreement between two separate formulas is not enough.
The propagation term and the sourced lapse/shift terms must occur in one
variational principle with the same coefficient.

Barnich and Troessaert write the duality-symmetric linearized gravity action in
Hamiltonian form as

\[
S_G=\int d^4x\,[a_A(z)\dot z^A-u^\alpha\gamma_\alpha(z)]
-\int dt\,H[z],
\]

with eight Lagrange multipliers: electric and magnetic copies of the lapse and
three shifts.  Their source term is

\[
S^J=\frac12\int d^4x\,h^a_{\mu\nu}T_a^{\mu\nu},
\qquad T_a=(T,\Theta).
\]

Ordinary matter is the electric-source sector `T_a=(T,0)`.

`GravityScreening/SourcedTTHamiltonianAction.lean` builds and checks the
corresponding fixed-mode quartic Hamiltonian structure.

## The single action

For each of the four constraint labels, define

\[
R^E_i=E_i-\lambda_4 B_i-J_i,
\qquad
R^B_i=B_i-\lambda_4 E_i.
\]

The magnetic source in the second residual is exactly zero.  With multiplier
families `uE_i` and `uB_i`, the constraint part is

\[
L_{\rm constraints}=\sum_{i=0}^{3}
\left(u^E_iR^E_i+u^B_iR^B_i\right).
\]

The complete fixed-mode action is

\[
L_Q=L^{TT}_{\rm exterior,Q}+L_{\rm constraints}.
\]

Lean proves the exact finite variation under arbitrary simultaneous changes
of all eight multipliers.  Stationarity in every multiplier direction is
equivalent to all eight constraint equations.  No informal differentiation is
used in this step.

## The decisive off-shell reduction

Now eliminate only the source-free partner equation,

\[
B_i=\lambda_4E_i.
\]

Do **not** yet impose the electric constraint.  Lean reduces the complete
action to

\[
\boxed{
L_Q=
S_Q L^{TT}_0+
\sum_{i=0}^{3}u^E_i(S_QE_i-J_i)
}
\]

where

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

This is the placement result that the static calculation needed.  The same
coefficient appears in the propagating TT term and inside every unsolved
electric lapse/shift constraint.  The magnetic multipliers disappear after
their source-free equations are eliminated.  The result is off shell in
`E_i`: it is stronger than evaluating the action after all constraints have
already vanished.

Varying the remaining electric multipliers gives

\[
S_QE_i=J_i,
\qquad
E_i=\frac{J_i}{S_Q}.
\]

Substituting the unique solution makes every multiplier term vanish and leaves
exactly

\[
L_Q=S_QL^{TT}_0.
\]

## What this means physically

At linear order, the proposed quartic completion now treats radiation and the
Newtonian source in one consistent Hamiltonian bookkeeping system.  A single
number controls both:

- gravitational-wave propagation keeps the same vacuum equation because its
  kinetic and Hamiltonian terms receive the same positive factor;
- an independently normalized matter source receives the reciprocal response
  `1/S_Q`;
- all four lapse/shift equations use that response;
- the source remains purely electric;
- the induced internal partner is fixed and supplies no independent source.

This removes the former transverse-only loophole inside the encoded
fixed-mode model.  The coefficient is present before the electric constraint
is solved, exactly where a Newton coupling must appear.

## The remaining field-theory seam

This is still a fixed-mode Hamiltonian assembly.  Its four electric and four
magnetic constraint values are abstract coordinates.  The next step is to
replace them with Barnich and Troessaert's explicit local differential
expressions

\[
\mathcal H_{am}=2\epsilon_{ab}\Delta\partial^nH^b_{mn},
\qquad
\mathcal H_{a\perp}=\Delta^2 C_a,
\]

and prove that the same constant quartic frame acts on the complete fields
`(H^a_{mn},A^a_m,C^a,n^a_m,n^a)` while preserving the kinetic symplectic form
and the ordinary source ray.  That would lift the present mode-level placement
identity to their local sourced action.  A nonlinear generally covariant
completion would remain after the local linear theorem.

## Kernel receipts

- `quarticConstraintMultiplierLagrangian_vary`
- `quarticConstraintMultipliers_stationary_iff`
- `quarticSourcedTTHamiltonianLagrangian_varyMultipliers`
- `quarticConstraintMultiplier_afterPartnerReduction`
- `quarticSourcedTTHamiltonian_afterPartnerReduction`
- `quarticCanonicalResponse_constraintMultiplier_vanishes`
- `quarticSourcedTTHamiltonian_onCanonicalResponse`

The full project build passes with no `sorry`; the axiom audit lists only the
standard Mathlib foundations.

## Source

Glenn Barnich and Cédric Troessaert,
[*Manifest spin 2 duality with electric and magnetic sources*](https://arxiv.org/abs/0812.0552),
especially equations (17), (24), (24a), (35), and (61).
