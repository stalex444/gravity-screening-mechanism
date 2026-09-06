# Can the two-scalar action protect the quartic modular response?

## Result

The deposited two-scalar action gives a limited but exact result:

- at quadratic order about the selected axis vacuum, the geometric fluctuation
  and the Q-sector fluctuation decouple;
- consequently, a **sector-respecting** modular embedding has zero quartic
  frequency shift at tree level;
- the action does not protect that frequency against interaction corrections.

Thus the action is compatible with cocycle neutrality at tree level, but it
does not derive or protect the condition needed to preserve `lambda4` in the
physical horizon theory.

## 1. Exact expansion at the selected vacuum

Write the deposited potential as

\[
V(\phi,\chi)=
\lambda_3(\phi^2-v^2)^2+
\lambda_4(\chi^2-u^2)^2+
\kappa\phi^2\chi^2
\]

and expand about the selected axis background

\[
\phi=v+h,\qquad \chi=x.
\]

Direct expansion gives

\[
\begin{aligned}
V(v+h,x)={}&\lambda_4u^4
+4\lambda_3v^2h^2
+4\lambda_3vh^3
+\lambda_3h^4\\
&+(\kappa v^2-2\lambda_4u^2)x^2
+2\kappa vhx^2
+\kappa h^2x^2
+\lambda_4x^4.
\end{aligned}
\]

There is no bilinear term proportional to `h*x`. The exact `x -> -x`
symmetry forbids it. The quadratic fluctuation operator is therefore block
diagonal between `h` and `x`, while the first cross-sector interaction is

\[
2\kappa v h x^2.
\]

Both statements are kernel-checked by
`shiftedPortalPotential_expand` and
`shiftedPortalPotential_chi_even` in `GravityScreening/Basic.lean`.

## 2. What follows for the modular cocycle

Let `B` denote a one-particle quartic mode carried entirely by the `x` sector.
Suppose, as an additional physical premise, that the horizon embedding maps
the quadratic vacuum sector by sector and that its modular generator is the
sum of the two uncoupled quadratic generators. Then the geometric generator
acts trivially on `B`. In the notation of `MODULAR_MAP_AUDIT.md`,

\[
[K_{\rm rel}^{(0)},B]=0,
\qquad \delta_{\rm tree}=0.
\]

Under those assumptions the tree-level wedge response retains

\[
1-e^{-\log Q}=1-\frac1Q=\lambda_4.
\]

This is a conditional consequence of the diagonal quadratic operator. The
deposited action itself does not define the graph-KMS-to-wedge embedding, the
wedge state, or the relative modular Hamiltonian, so it cannot establish the
premise.

## 3. Why the symmetry is not an all-orders protection theorem

The same `x -> -x` symmetry that removes `h*x` permits all of

\[
x^2,\qquad h x^2,\qquad h^2x^2,\qquad x^4.
\]

It therefore permits corrections to the quartic two-point function and its
spectral frequency. The cubic portal `2 kappa v h x^2` already couples the
two sectors beyond the Gaussian approximation. The symmetry protects parity,
but it does not fix the pole or modular frequency of the `x` mode to `log Q`.

Accordingly, `delta = 0` is exact at the decoupled quadratic level only after
the sectorwise embedding premise is supplied. It is not secured against
renormalization by the displayed symmetry. The Lean theorem
`quartic_response_shift_eq_iff` shows why this matters:

\[
1-e^{-(\log Q+\delta)}=\lambda_4
\quad\Longleftrightarrow\quad
\delta=0.
\]

Any nonzero scalar shift changes the proposed coefficient. General cocycle
mixing would destroy the one-number response altogether.

## 4. What would close the mechanism

One of the following would be sufficient:

1. a Ward identity or conserved charge proving that the relative modular
   cocycle commutes with the quartic Perron mode;
2. an index or superselection argument fixing that mode's modular eigenvalue;
3. an explicit interacting wedge calculation showing zero renormalized
   modular-frequency shift;
4. a more fundamental horizon algebra in which the quartic eigenvalue is
   part of the algebraic data preserved by every admissible embedding.

The present potential supplies none of these protections. Adding another
potential identity will not settle the issue because the missing object is the
relative modular action on a local operator.

## 5. Clean falsifier

Construct the interacting relative modular generator on the proposed quartic
spectral subspace and evaluate

\[
[K_{\rm rel},B].
\]

- If it vanishes, the physical horizon flow preserves the exact Perron/KMS
  response `lambda4`.
- If it is `delta B` with nonzero `delta`, the coefficient becomes
  `1-exp(-(log Q+delta))` and the proposed exact screening fails.
- If it contains other modes, the scalar screening coefficient must be
  replaced by a matrix response.

## Verdict

The current action passes a necessary tree-level compatibility test: it does
not shift or mix a one-particle Q mode through a bilinear coupling. It fails to
supply the stronger result PDT needs: exact cocycle neutrality in the
interacting horizon theory.

This localizes the next mathematical target. The search should move from the
potential and Hessian to a Ward, index, or modular-covariance theorem for the
quartic Perron line.
