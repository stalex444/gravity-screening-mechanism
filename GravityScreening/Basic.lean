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

/-- `lambda4` is the relative increment of a dilation by `q`: the part of a
unit interval lying above the inverse-image cutoff `1/q`. -/
theorem lambda4_eq_relative_increment (q : ℝ) (hq : q ≠ 0) :
    lambda4 q = (q - 1) / q := by
  unfold lambda4
  field_simp [hq]

/-! ## The residue amplitude from the quartic companion operator -/

/-- The nonnegative incidence/companion matrix of the substitution
`1 -> 2, 2 -> 3, 3 -> 4, 4 -> 12`. -/
def quarticCompanion : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0,0,0,1; 1,0,0,1; 0,1,0,0; 0,0,1,0]

/-- The integral inverse of `quarticCompanion`. -/
def quarticCompanionInv : Matrix (Fin 4) (Fin 4) ℝ :=
  !![-1,1,0,0; 0,0,1,0; 0,0,0,1; 1,0,0,0]

theorem quarticCompanion_mul_inv :
    quarticCompanion * quarticCompanionInv = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [quarticCompanion, quarticCompanionInv, Matrix.mul_apply,
      Fin.sum_univ_succ]

theorem quarticCompanion_inv_mul :
    quarticCompanionInv * quarticCompanion = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [quarticCompanion, quarticCompanionInv, Matrix.mul_apply,
      Fin.sum_univ_succ]

/-- The positive-root eigenvector in the substitution's natural basis. -/
noncomputable def quarticPerronVector (q : ℝ) : Fin 4 → ℝ :=
  ![1, q ^ 3, q ^ 2, q]

theorem quarticCompanion_perron (q : ℝ) (hq : q ^ 4 = q + 1) :
    quarticCompanion.mulVec (quarticPerronVector q) =
      fun i => q * quarticPerronVector q i := by
  funext i
  fin_cases i <;>
    simp [quarticCompanion, quarticPerronVector, Matrix.mulVec, dotProduct,
      Fin.sum_univ_succ] <;>
    nlinarith [hq]

/-- Current state minus one inverse companion step. -/
def quarticResidual : Matrix (Fin 4) (Fin 4) ℝ :=
  !![2,-1,0,0; 0,1,-1,0; 0,0,1,-1; -1,0,0,1]

theorem quarticResidual_eq_one_sub_inv :
    quarticResidual = 1 - quarticCompanionInv := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [quarticResidual, quarticCompanionInv]

/-- On the distinguished positive eigenline, the inverse-step residue has
exact eigen-amplitude `lambda4`. -/
theorem quarticResidual_perron (q : ℝ) (hq : q ^ 4 = q + 1) (hq0 : q ≠ 0) :
    quarticResidual.mulVec (quarticPerronVector q) =
      fun i => lambda4 q * quarticPerronVector q i := by
  have hl := lambda4_eq_relative_increment q hq0
  funext i
  fin_cases i <;>
    simp [quarticResidual, quarticPerronVector,
      Matrix.mulVec, dotProduct, Fin.sum_univ_succ] <;>
    rw [hl] <;>
    field_simp [hq0] <;>
    nlinarith [hq]

/-! ## Minimal unitary completion of the residue contraction -/

/-- Once a real contraction coefficient `l` is fixed, conservation of squared
norm forces the squared complementary coefficient to be `1-l^2`. -/
theorem defect_sq_forced (l d : ℝ) (hcomplete : l ^ 2 + d ^ 2 = 1) :
    d ^ 2 = screening l := by
  unfold screening
  linarith

/-- The positive defect amplitude has the required square whenever the
screening coefficient is nonnegative. -/
theorem defect_sqrt_sq (l : ℝ) (h : 0 ≤ screening l) :
    (Real.sqrt (screening l)) ^ 2 = screening l := by
  exact Real.sq_sqrt h

/-- Either row of the scalar Julia dilation has unit norm when the defect
coefficient has the forced square. -/
theorem julia_row_norm (l d : ℝ) (hdefect : d ^ 2 = screening l) :
    l ^ 2 + d ^ 2 = 1 := by
  rw [hdefect]
  simp [screening]

/-- The two rows of the scalar Julia dilation `[[l,d],[d,-l]]` are orthogonal. -/
theorem julia_rows_orthogonal (l d : ℝ) :
    l * d + d * (-l) = 0 := by
  ring

/-- If a mass amplitude is multiplied by the defect coefficient, its square is
multiplied by the screening coefficient. -/
theorem defect_mass_square (l d m : ℝ)
    (hdefect : d ^ 2 = screening l) :
    (m * d) ^ 2 = m ^ 2 * screening l := by
  rw [mul_pow, hdefect]

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

/-! ## Audit of the deposited two-scalar action

For a scalar-curvature theory with curvature coefficient `f`, scalar kinetic
matrix `k`, and fields indexed by `A,B`, the standard frame-covariant field
metric is

`G_AB = k_AB / f + (3/2) * f_A * f_B / f^2`.

The theorem below checks the algebraic consequence used in the accompanying
audit. The transformation formula itself is a physics input, not proved here.
-/

/-- The off-diagonal entry of the standard two-field frame-covariant metric. -/
noncomputable def frameMetricCross
    (kCross f fPhi fChi : ℝ) : ℝ :=
  kCross / f + (3 / 2 : ℝ) * fPhi * fChi / f ^ 2

/-- A diagonal Jordan-frame kinetic term and a curvature coefficient independent
of the second field cannot produce an off-diagonal Einstein-frame kinetic term. -/
theorem frameMetricCross_eq_zero (f fPhi : ℝ) :
    frameMetricCross 0 f fPhi 0 = 0 := by
  simp [frameMetricCross]

/-- The mixed scalar Hessian of the portal potential is proportional to the
product of the two background fields. -/
def portalMixedHessian (kappa phi chi : ℝ) : ℝ :=
  4 * kappa * phi * chi

/-- At the selected `chi = 0` axis vacuum, the portal potential supplies no
bilinear mixing between the two fluctuations. -/
theorem portalMixedHessian_at_chi_axis (kappa phi : ℝ) :
    portalMixedHessian kappa phi 0 = 0 := by
  simp [portalMixedHessian]

end GravityScreening

#print axioms GravityScreening.response_completed_square
#print axioms GravityScreening.response_at_stationary
#print axioms GravityScreening.normalized_block_det
#print axioms GravityScreening.screening_pos
#print axioms GravityScreening.quartic_screening_identity
#print axioms GravityScreening.lambda4_eq_relative_increment
#print axioms GravityScreening.quarticCompanion_mul_inv
#print axioms GravityScreening.quarticCompanion_inv_mul
#print axioms GravityScreening.quarticCompanion_perron
#print axioms GravityScreening.quarticResidual_eq_one_sub_inv
#print axioms GravityScreening.quarticResidual_perron
#print axioms GravityScreening.defect_sq_forced
#print axioms GravityScreening.defect_sqrt_sq
#print axioms GravityScreening.julia_row_norm
#print axioms GravityScreening.julia_rows_orthogonal
#print axioms GravityScreening.defect_mass_square
#print axioms GravityScreening.radial_homogeneity_iff
#print axioms GravityScreening.ehrenfest_marginal_iff
#print axioms GravityScreening.frameMetricCross_eq_zero
#print axioms GravityScreening.portalMixedHessian_at_chi_axis
