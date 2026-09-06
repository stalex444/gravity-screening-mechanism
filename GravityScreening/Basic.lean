import Mathlib

/-!
# A minimal algebraic model of the PDT gravity-screening coefficient

This file proves only the exact algebra used by the exploratory mechanism.
The identification of `lambda4` with a physical kinetic or curvature mixing
coefficient is not a theorem in this file.
-/

namespace GravityScreening

/-- The quartic-sector self-coupling as a function of a nonzero real `q`. -/
noncomputable def lambda4 (q : ℝ) : ℝ := 1 - 1 / q

/-- The proposed surviving response fraction. -/
def screening (l : ℝ) : ℝ := 1 - l ^ 2

/-- A normalized two-channel quadratic response. -/
def response (l x y : ℝ) : ℝ := x ^ 2 + y ^ 2 - 2 * l * x * y

/-- Completing the square exposes the Schur-complement coefficient. -/
theorem response_completed_square (l x y : ℝ) :
    response l x y = (y - l * x) ^ 2 + screening l * x ^ 2 := by
  simp [response, screening]
  ring

/-- Eliminating the second channel at its stationary value leaves the
screening coefficient. -/
theorem response_at_stationary (l x : ℝ) :
    response l x (l * x) = screening l * x ^ 2 := by
  rw [response_completed_square]
  ring

/-- The determinant of the normalized two-channel block. -/
def det2 (a b c d : ℝ) : ℝ := a * d - b * c

theorem normalized_block_det (l : ℝ) :
    det2 1 (-l) (-l) 1 = screening l := by
  simp [det2, screening]
  ring

/-- Opposite affine responses have the same difference-of-squares factor. -/
theorem paired_response (l : ℝ) :
    (1 - l) * (1 + l) = screening l := by
  simp [screening]
  ring

/-- The response is positive in the correlation range `-1 < l < 1`. -/
theorem screening_pos {l : ℝ} (h : -1 < l ∧ l < 1) :
    0 < screening l := by
  have hleft : 0 < 1 - l := sub_pos.mpr h.2
  have hright : 0 < 1 + l := by linarith [h.1]
  rw [← paired_response l]
  exact mul_pos hleft hright

/-- The exact quartic identity used in the gravity formula. -/
theorem quartic_screening_identity (q : ℝ) (hq : q ≠ 0) :
    screening (lambda4 q) = (2 * q - 1) / q ^ 2 := by
  unfold screening lambda4
  field_simp [hq]
  ring

/-- The gravitational and centrifugal radial exponents agree only in four
spatial dimensions. -/
theorem radial_homogeneity_iff (d : ℤ) :
    2 - d = -2 ↔ d = 4 := by
  omega

/-- The standard circular-orbit stiffness coefficient is marginal at `d=4`. -/
theorem ehrenfest_stiffness_identity (d : ℝ) :
    3 - (d - 1) = 4 - d := by
  ring

theorem ehrenfest_marginal_iff (d : ℝ) :
    4 - d = 0 ↔ d = 4 := by
  constructor <;> intro h <;> linarith

end GravityScreening
