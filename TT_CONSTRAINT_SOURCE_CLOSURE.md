# Quartic TT constraint and source closure

## The question

The propagating transverse-traceless graviton action already carries the
quartic exterior coefficient

\[
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2},
\qquad
\lambda_4=1-\frac1Q,
\qquad Q^4=Q+1.
\]

That result is not yet a sourced gravitational theory by itself.  Linearized
gravity also has four nondynamical equations: the Hamiltonian constraint
enforced by the lapse and the three momentum constraints enforced by the
shift.  The source must remain the ordinary stress-energy source, the
constraint equations must not create an independent magnetic/NUT source, and
the construction must retain the two physical graviton polarizations.

`GravityScreening/TTConstraintSourceClosure.lean` performs that combined test.

## No frame parameter remains

The lower-triangular electric frame previously contained two positive scales
`d` and `r`, constrained only by

\[
d^2=S_Q,\qquad r^2=d.
\]

The new file fixes them canonically:

\[
d=\sqrt{S_Q},\qquad r=S_Q^{1/4}.
\]

For the positive quartic root,

\[
Q=1.220744084605759\ldots,
\quad \lambda_4=0.180827486603836\ldots,
\]

\[
S_Q=0.967301420088540\ldots,
\quad d=0.983514829623092\ldots,
\quad r=0.991723161786137\ldots.
\]

Lean proves that this parameter-free frame is symplectic and that its Gram
matrix is exactly the determinant-one quartic constitutive block.  It also
proves that the inverse-transpose frame sends an electric source covector to
another electric source covector.  Its magnetic component stays exactly zero.

## The response of one constraint

Let `J` be an ordinary electric source.  Solving in the canonical frame and
mapping back gives

\[
E=\frac{J}{S_Q},
\qquad
B=\lambda_4\frac{J}{S_Q}.
\]

These fields obey

\[
E-\lambda_4 B=J,
\qquad
B-\lambda_4 E=0.
\]

The second equation is a zero magnetic **source equation**.  The value
`B=lambda4*E` is an induced constitutive partner.  This distinction removes an
apparent contradiction: mixing creates an internal partner response without
requiring matter to carry a new magnetic stress-energy or NUT charge.

The inverse enhancement is

\[
\frac1{S_Q}=1.033803920093974\ldots.
\]

## All four lapse/shift constraints

The file applies the same calculation pointwise to a four-element constraint
family.  Lean proves both existence and uniqueness:

\[
E_i=\frac{J_i}{S_Q},
\qquad
B_i=\lambda_4\frac{J_i}{S_Q},
\qquad i=0,1,2,3.
\]

Thus the lapse/shift sector has no additional homogeneous response within this
two-channel model.  Every constraint receives the same quartic coefficient,
and every magnetic source equation remains zero.

## Joining propagation, constraints, and Newton response

The capstone theorem
`quarticConstrainedSourcedTT_capstone` combines five checked statements.

1. The complete visible-plus-hidden fixed-mode TT prepotential action is
   unchanged.
2. The visible action is exactly `S_Q` times the original action.
3. The actual Lorentz-signature Ward identity and formal self-adjointness
   propagate that wave coefficient uniquely through the full five-term linear
   operator.  This is universal: every candidate operator with those
   properties receives the Pauli--Fierz coefficient pattern at scale `S_Q`.
4. All four sourced constraint responses are uniquely `J_i/S_Q`, with zero
   magnetic source equations, and the reduced phase space still has two
   graviton configuration degrees of freedom.
5. The attenuated canonical TT field represents the same nonzero physical
   metric exactly when

\[
G_Q=\frac{G_0}{S_Q}.
\]

This is the desired consistency closure at linear order: the radiative action,
the nondynamical constraints, the physical polarization count, and the static
source response all use the same coefficient.

## What has and has not been established

The new result closes a genuine algebraic loophole.  The inverse Newton factor
is no longer inferred only from a TT norm or inserted only into a static
response equation.  A single coefficient now survives every component of the
linearized construction that has been encoded.

One physical seam remains.  The four constraint labels are a faithful model
of the lapse and shift family, but the doubled constitutive block has not yet
been obtained by varying one local, sourced, covariant gravitational action.
The coefficient theorem now derives its relations from the Lorentz Ward and
self-adjointness properties themselves; it does not assume the component
relations separately.  The next decisive calculation is therefore to build
that single local quadratic action, perform its 3+1 split, and recover both the
TT prepotential action and the four sourced constraint equations from the same
variation.  Nonlinear closure on curved backgrounds comes after that linear
action-level test.

The prepotential action used upstream is the duality-symmetric linearized
gravity action of Barnich and Troessaert, [*Manifest spin 2 duality with electric
and magnetic sources*](https://arxiv.org/abs/0812.0552).  The earlier source-free
prepotential formulation is due to Henneaux and Teitelboim,
[*Duality in linearized gravity*](https://arxiv.org/abs/gr-qc/0408101).

## Kernel receipts

The principal declarations are:

- `quarticScreening_pos`
- `quarticActionAmplitude_sq`
- `quarticSourceFrameAmplitude_sq`
- `quarticElectricSourceFrame_symplectic`
- `quarticElectricSourceFrame_gram`
- `quarticElectricSourceFrame_preserves_source_ray`
- `quarticConstraintResponse_eq`
- `quarticConstraintResponse_closure`
- `quarticFullConstraintResponse_closure`
- `quarticFullConstraint_solution_unique`
- `quarticLorentzPauliFierzNormalization_unique`
- `quarticConstrainedSourcedTT_capstone`

The printed axiom audit contains only the standard Mathlib foundations
`propext`, `Classical.choice`, and `Quot.sound`.
