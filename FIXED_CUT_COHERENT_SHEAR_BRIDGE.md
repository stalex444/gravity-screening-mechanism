# A fixed-cut coherent-shear bridge

## Result

There is a shorter route from the quartic information channel to linear
gravity than constructing a restriction map between two sharp horizon cuts.
Work at one fixed observer wedge and compare a microscopic description with
its exterior effective description of the same physical geometry.

On the canonically normalized horizon-shear mode, the quartic Stinespring map
is a passive one-particle splitter:

\[
V_Q a
=\sqrt{S_Q}\,a_{\rm ext}\oplus\lambda_4 a_{\rm hid},
\qquad
S_Q=1-\lambda_4^2.
\]

It preserves the global norm and every diagonal mode energy. Its exterior
quadratic information is multiplied by `S_Q`, its hidden quadratic information
is multiplied by `lambda4^2`, and the two sum to the input value. Because the
two coefficients are scalars, the split commutes with the one-particle modular
evolution: the mode loses exterior amplitude without changing its modular
frequency.

For a canonically normalized graviton shear amplitude `a`, perturbative
gravity relates the physical metric shear to `a` by

\[
\sigma=\frac{\kappa}{2}a,
\qquad
\kappa^2=32\pi G.
\]

The exterior description has canonical amplitude

\[
a_Q=\sqrt{S_Q}\,a_0.
\]

Microscopic and effective descriptions of the same state must assign the same
physical metric shear:

\[
\frac{\kappa_Q}{2}a_Q=\frac{\kappa_0}{2}a_0.
\]

For a nonzero shear, substitution gives

\[
\kappa_Q\sqrt{S_Q}=\kappa_0
\quad\Longleftrightarrow\quad
G_Q=\frac{G_0}{S_Q}.
\]

`GravityScreening/CoherentShearMatching.lean` proves this equivalence in both
directions, including the factors `32*pi` and `1/2`, and then specializes it
to

\[
S_Q=\frac{2Q-1}{Q^2}.
\]

## Why the fixed-cut route is preferable

The horizon-cut route and the fixed-cut route answer different questions.

The **cut-to-cut** problem asks how the observer algebra changes as the cut
moves forward. The relevant inclusions are half-sided modular. Faulkner and
Speranza explain that an ordinary normal conditional expectation is generally
not available and conjecture an operator-valued weight between the cut
algebras. Its existence is an open operator-algebra problem.

The **fixed-cut matching** problem asks how a microscopic state and an
effective exterior state describe one physical geometry at the same cut. It
only needs:

1. a single observer algebra and reference state;
2. a canonical coherent horizon-shear mode;
3. the quartic passive splitter on that mode;
4. equality of the physical metric perturbation before and after matching.

This route does not require a conditional expectation between sharp cut
algebras or a proof of the generalized second law beyond the semiclassical
order. It is therefore the smaller problem appropriate to identifying a
fixed gravitational coupling.

## Published physics that supplies the normalization

Casini, Grillo, and Pontello rigorously compute the relative entropy between a
free-field coherent state and the vacuum in a Rindler wedge. They show that it
is the canonical boost-energy integral; positivity and monotonicity exclude
the possible stress-tensor improvement term:
<https://arxiv.org/abs/1903.00109>.

Bostelmann, Cadamuro, and Del Vecchio prove more generally that relative
entropy of coherent states on CCR algebras is a positive quadratic form on
the single-particle displacement:
<https://arxiv.org/abs/2012.14401>.

Faulkner and Speranza give the gravitational horizon normalization. Writing

\[
g_{ab}=g^0_{ab}+\kappa h_{ab},
\qquad
\kappa=\sqrt{32\pi G},
\]

they obtain, at leading perturbative order,

\[
\sigma_{ab}=\frac{\kappa}{2}\dot\rho_{ab},
\qquad
t^{(g)}_{vv}=\dot\rho^{ab}\dot\rho_{ab}.
\]

Thus the canonical graviton energy is the squared canonical shear amplitude,
whereas the physical metric shear carries the factor `kappa/2`. Their
crossed-product construction also uses a common asymptotic area charge and
the same vacuum to normalize different horizon cuts:
<https://arxiv.org/abs/2405.00847>.

These results do not prove that PDT's quartic splitter acts on the graviton
mode. They do remove the normalization ambiguity once that action is supplied.

## Relation to a bosonic loss channel

The finite PDT dilation is exactly the one-excitation restriction of a passive
bosonic two-port splitter. A one-particle state carrying internal data `a`
emerges either in the exterior port with amplitude `sqrt(S_Q)` or in the
hidden port with amplitude `lambda4`. Tracing over the hidden port gives the
erasure channel on the one-particle code, with the Fock vacuum serving as the
orthogonal erasure flag.

Second quantization sends a coherent displacement `a` to two coherent
displacements with those same amplitudes. Since coherent-state relative
entropy is quadratic in the displacement, the exterior relative entropy is
multiplied by `S_Q`. This is the field-theoretic version of the finite Fisher
and relative-entropy theorems already in the repository.

This interpretation also makes the conservation statement physical. The
exterior mode alone carries only `S_Q` of the quadratic boost energy, but the
exterior and hidden modes together carry the original energy. Gravity
screening is therefore an accessibility effect for the observer rather than
destruction of the global excitation.

## Exact closure chain at linear order

The proposed linear mechanism can now be written as one chain:

\[
\begin{aligned}
R_Qv_Q&=\lambda_4v_Q,\\
V_Qa&=\sqrt{1-\lambda_4^2}\,a_{\rm ext}
      \oplus\lambda_4a_{\rm hid},\\
S_{\rm rel}^{\rm ext}(a)&=S_QS_{\rm rel}^{\rm global}(a),\\
\sigma_Q=\sigma_0
&\Longleftrightarrow
\kappa_Q\sqrt{S_Q}=\kappa_0,\\
&\Longleftrightarrow
G_Q=G_0/S_Q.
\end{aligned}
\]

The Pauli--Fierz uniqueness theorem already propagates this coefficient from
the two radiative polarizations to the complete conserved linear spin-two
source response.

## Honest status

**Exact mathematics:** the quartic residue amplitude, unitary dilation,
exterior information contraction, modular phase covariance, global norm and
energy conservation, physical/canonical shear conversion, and matching
equivalence are proved in Lean.

**Published physics input:** coherent-state relative entropy is a canonical
quadratic boost-energy form for free CCR fields, and perturbative graviton
energy at a Killing horizon is the squared canonical shear.

**Physical identification:** the quartic splitter acts on the canonically
normalized transverse-traceless horizon graviton mode.

If that final line is adopted as an effective physical postulate, its screened
linear spin-two response follows mathematically and has no free screening
coefficient. A deeper derivation would obtain the splitter from the local
Q-to-graviton interaction or from a state-preserving embedding of the Q mode
in the horizon algebra.

## What would falsify this route

The route fails if the physical Q interaction:

- changes the shear profile or modular frequency rather than acting as the
  scalar passive splitter;
- puts `S_Q` into the globally conserved flux as well as the exterior
  information, because the Jacobson factors would then cancel;
- introduces an independent mixing angle or field normalization;
- couples only to a scalar or gauge mode and not to the physical spin-two
  polarizations;
- acquires edge or boundary terms that change the coherent-state quadratic
  form.

The next physical calculation is therefore concrete: derive the one-particle
scattering or matching map for the two horizon graviton polarizations from the
Q-modified duality-symmetric spin-two action, or from an enlarged local
horizon interaction, and test whether its exterior block is `sqrt(S_Q) I_2`.
The deposited two-scalar action cannot supply this at quadratic order: its
selected axis vacuum makes the scalar fluctuation operator block diagonal.
