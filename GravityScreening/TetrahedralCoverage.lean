import GravityScreening.ThreeDPackingWitness

/-!
# Barycentric core of the tetrahedral coverage identity

For a centered tetrahedron `K`, the identity used by Bandt--Meyer's
three-dimensional relative-density argument is `3K + F = 4K`, where `F` is
the set of its four vertices.  This file verifies the finite barycentric
algebra behind the nontrivial inclusion: among four weights summing to one,
one is at least `1/4`; subtracting that vertex from the point in `4K` leaves
valid barycentric coordinates for a point in `3K`.

Convex-set notation and the later infinite-union argument are not introduced
here.  The checked coefficient reconstruction is the exact local covering
step they use.
-/

namespace GravityScreening

/-- Remove one vertex from weights for a point in `4K`, then renormalize the
remaining coefficients as barycentric weights for `3K`. -/
noncomputable def tetraResidualWeight
    (chosen : Fin 4) (weight : Fin 4 → ℝ) (j : Fin 4) : ℝ :=
  (4 * weight j - if j = chosen then 1 else 0) / 3

/-- Four real weights summing to one cannot all be below one quarter. -/
theorem tetraWeight_has_quarter
    (weight : Fin 4 → ℝ) (hsum : ∑ j, weight j = 1) :
    ∃ chosen, 1 / 4 ≤ weight chosen := by
  by_contra h
  push Not at h
  have h0 := h (0 : Fin 4)
  have h1 := h (1 : Fin 4)
  have h2 := h (2 : Fin 4)
  have h3 := h (3 : Fin 4)
  simp only [Fin.sum_univ_four] at hsum
  norm_num at h0 h1 h2 h3
  linarith

/-- Choosing a weight of at least one quarter makes every residual weight
nonnegative. -/
theorem tetraResidualWeight_nonneg
    (chosen : Fin 4) (weight : Fin 4 → ℝ)
    (hweight : ∀ j, 0 ≤ weight j) (hchosen : 1 / 4 ≤ weight chosen) :
    ∀ j, 0 ≤ tetraResidualWeight chosen weight j := by
  intro j
  by_cases hj : j = chosen
  · subst j
    simp only [tetraResidualWeight, if_pos]
    norm_num at hchosen ⊢
    linarith
  · simp only [tetraResidualWeight, if_neg hj, sub_zero]
    have hw := hweight j
    linarith

/-- Removing one chosen vertex preserves the barycentric sum after the
threefold renormalization. -/
theorem tetraResidualWeight_sum
    (chosen : Fin 4) (weight : Fin 4 → ℝ)
    (hsum : ∑ j, weight j = 1) :
    ∑ j, tetraResidualWeight chosen weight j = 1 := by
  have hscaled : ∑ j, 4 * weight j = 4 := by
    rw [← Finset.mul_sum, hsum]
    norm_num
  have hchosen : ∑ j : Fin 4, (if j = chosen then (1 : ℝ) else 0) = 1 := by
    simp
  simp only [tetraResidualWeight, ← Finset.sum_div, Finset.sum_sub_distrib]
  rw [hscaled, hchosen]
  norm_num

/-- Coefficient reconstruction: `4K` equals the selected vertex plus the
corresponding point of `3K`, coordinate by coordinate. -/
theorem tetraResidualWeight_reconstruct
    (chosen : Fin 4) (weight : Fin 4 → ℝ) (j : Fin 4) :
    4 * weight j =
      3 * tetraResidualWeight chosen weight j + if j = chosen then 1 else 0 := by
  by_cases hj : j = chosen <;>
    simp [tetraResidualWeight, hj] <;> ring

/-- Every nonnegative barycentric description in `4K` admits a vertex plus
`3K` description.  This is the finite witness for the tetrahedral cover. -/
theorem tetraBarycentric_cover
    (weight : Fin 4 → ℝ)
    (hweight : ∀ j, 0 ≤ weight j)
    (hsum : ∑ j, weight j = 1) :
    ∃ (chosen : Fin 4) (residual : Fin 4 → ℝ),
      (∀ j, 0 ≤ residual j) ∧
      (∑ j, residual j = 1) ∧
      (∀ j, 4 * weight j = 3 * residual j + if j = chosen then 1 else 0) := by
  obtain ⟨chosen, hchosen⟩ := tetraWeight_has_quarter weight hsum
  refine ⟨chosen, tetraResidualWeight chosen weight, ?_, ?_, ?_⟩
  · exact tetraResidualWeight_nonneg chosen weight hweight hchosen
  · exact tetraResidualWeight_sum chosen weight hsum
  · exact tetraResidualWeight_reconstruct chosen weight

#print axioms GravityScreening.tetraWeight_has_quarter
#print axioms GravityScreening.tetraResidualWeight_nonneg
#print axioms GravityScreening.tetraResidualWeight_sum
#print axioms GravityScreening.tetraResidualWeight_reconstruct
#print axioms GravityScreening.tetraBarycentric_cover

end GravityScreening
