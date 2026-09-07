# The quartic splitter on the physical graviton polarizations

## The result

A gravitational wave moving in a fixed direction has two physical linear
polarizations, conventionally called plus and cross.  Write their canonically
normalized amplitudes as the vector

\[
x=(h_+,h_\times).
\]

The polarization-blind quartic exterior channel is the explicit two by two
block

\[
C_Q=\sqrt{S_Q}\,I_2,
\qquad
S_Q=1-\lambda_4^2=\frac{2Q-1}{Q^2}.
\]

`GravityScreening/TTHorizonSplitter.lean` proves that this block has all of the
required kinematic properties:

1. it multiplies plus and cross by the same amplitude and therefore produces
   no polarization mixing or birefringence;
2. it preserves the symmetric, transverse, traceless tensor subspace and
   creates no scalar or longitudinal graviton mode;
3. it contracts the complete two-polarization shear norm by exactly `S_Q`;
4. for every nonzero TT wave, equality of the physical metric perturbation
   before and after matching is equivalent to

\[
G_Q=\frac{G_0}{S_Q}.
\]

The fourth statement is an if-and-only-if theorem, not just a proportionality
argument.

The matrix form itself is now characterized in
`TT_RESPONSE_UNIQUENESS.md`.  A real TT response that is rotationally
covariant, self-adjoint, has quadratic weight `S_Q`, and lies on the positive
passive branch is proved to be uniquely `sqrt(S_Q) I_2`.  Thus the remaining
physical premise is the identification of the Q information response with a
TT graviton operator satisfying those properties, rather than an arbitrary
choice of a two by two matrix.

## Why the square root appears

`S_Q` is a quadratic information or energy weight.  A field amplitude must
therefore carry its square root.  Perturbative gravity relates a canonical
graviton amplitude to the physical metric amplitude through

\[
\sigma=\frac{\kappa}{2}h,
\qquad
\kappa^2=32\pi G.
\]

After the exterior channel, the canonical TT vector is

\[
x_Q=\sqrt{S_Q}\,x_0.
\]

If the microscopic and effective descriptions represent the same physical TT
tensor, then

\[
\frac{\kappa_Q}{2}\sqrt{S_Q}\,x_0
=\frac{\kappa_0}{2}x_0.
\]

For any nonzero polarization vector this fixes

\[
\kappa_Q\sqrt{S_Q}=\kappa_0,
\qquad
G_Q=G_0/S_Q.
\]

Thus the square-root attenuation and the full inverse Newton response are two
descriptions of the same matching condition: one is written in canonical
amplitudes and the other in the physical gravitational coupling.

## Relation to ordinary matter

The TT theorem concerns the two radiative degrees of freedom.  Static gravity
also depends on the lapse and shift constraints and their matter sources.
`GravityScreening/ElectricSourceFrame.lean` independently proves that the
quartic two-channel canonical frame preserves the ordinary electric source
ray `(T,0)`.  It generates no external magnetic or NUT source, while its
electric response is multiplied by `1/S_Q`.

`GravityScreening/PauliFierzUniqueness.lean` then proves that the standard
linear massless spin-two Ward identities admit only one overall normalization.
Once the TT wave term has coefficient `S_Q`, that coefficient cannot be
changed independently in the constraint terms of the same Pauli--Fierz
operator.

Taken together, the results show that the proposed block has the correct
radiative normalization, the correct static inverse response, and the correct
electric source frame without adding a second physical graviton.

## What has and has not been established

**Kernel-checked mathematics.**  The two-dimensional TT count, the explicit
block `sqrt(S_Q) I_2`, preservation of the TT subspace, norm contraction by
`S_Q`, the same-metric if-and-only-if theorem, source-ray preservation, and
the Pauli--Fierz normalization propagation are all Lean theorems.

**Published physics input.**  Linearized four-dimensional gravity has two TT
polarizations; its canonically normalized horizon shear carries
`kappa^2=32*pi*G`; coherent graviton relative entropy is a quadratic canonical
energy; and duality-symmetric linear gravity organizes ordinary and NUT
sources as an electric/magnetic doublet.

**Open physical identification.**  The Q residual has not yet been shown to
act on the physical graviton prepotential or horizon mode with the
rotationally covariant, self-adjoint response and quadratic weight assumed in
the uniqueness theorem.  Those properties force the operator
`sqrt(S_Q) I_2`; the Lean theorem does not identify the information channel
with the graviton channel by definition.

The next field-theory calculation is therefore sharply specified.  Insert a
Q-dependent constitutive block into the published first-order,
duality-symmetric spin-two action, retain its spatial derivative and
lapse/shift structure, and derive its one-graviton exterior map.  Success
means that the physical TT block is `sqrt(S_Q) I_2`, the ordinary source
remains `(T,0)`, and no new normalization appears.  A polarization-dependent
block, an extra scalar/longitudinal mode, a magnetic source, or any additional
coefficient would falsify this minimal mechanism.

The deposited two-scalar Lagrangian cannot perform this job at quadratic
order because its axis-vacuum fluctuation operator is block diagonal.  The
appropriate next arena is the sourced first-order spin-two action or an
explicit local horizon interaction.

## Proof artifacts and physics sources

- `GravityScreening/TTHorizonSplitter.lean`
- `GravityScreening/TransverseTracelessCount.lean`
- `GravityScreening/CoherentShearMatching.lean`
- `GravityScreening/ElectricSourceFrame.lean`
- `GravityScreening/PauliFierzUniqueness.lean`
- H. Casini, S. Grillo, and D. Pontello, *Relative entropy for coherent states
  from Araki formula*: <https://arxiv.org/abs/1903.00109>
- H. Bostelmann, D. Cadamuro, and S. Del Vecchio, *Relative entropy of coherent
  states on general CCR algebras*: <https://arxiv.org/abs/2012.14401>
- T. Faulkner and M. Speranza, *Gravitational algebras and the generalized
  second law*: <https://arxiv.org/abs/2405.00847>
- M. Henneaux and C. Teitelboim, *Duality in linearized gravity*:
  <https://arxiv.org/abs/gr-qc/0408101>
- G. Barnich and C. Troessaert, *Manifest spin 2 duality with electric and
  magnetic sources*: <https://arxiv.org/abs/0812.0552>
