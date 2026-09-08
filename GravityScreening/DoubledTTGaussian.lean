import GravityScreening.FourModeGaussianTrace
import GravityScreening.DoubledSpinTwoAction
import GravityScreening.TTConstraintSourceClosure
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform

/-!
# Gaussian determinant of the doubled transverse-traceless response

The existing real doubled Hodge action has two transverse-traceless
polarization coordinates and two Hodge-paired coordinates.  This file proves
that its response matrix is an explicit Gram matrix with determinant
`screening l ^ 2`.  Its raw unit-scale four-dimensional Gaussian integral is
therefore `pi^2 / screening l` in the positive-screening regime.

At `l = lambda4 q`, multiplication by the independently derived projective
boundary volume gives `pi^4 / screening (lambda4 q)`.  Dividing by the
224-channel response reproduces `gravitationalCoupling` exactly.

The physical use of this unnormalized Gaussian determinant in an effective
coupling remains a correspondence premise.  In particular, an exponent with
a conventional factor `1/2`, a Fourier-normalized measure, or normalization
by the partition function changes or cancels the absolute coefficient.  The
file proves the Fourier-normalized alternative explicitly.
-/

namespace GravityScreening

noncomputable section

open MeasureTheory Matrix Real

abbrev DoubledTTModeCoordinates := Fin 4 → ℝ

def doubledTTCholesky (l d : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  !![1, 0, 0, l;
     0, 1, -l, 0;
     0, 0, d, 0;
     0, 0, 0, d]

theorem doubledTTCholesky_det (l d : ℝ) :
    Matrix.det (doubledTTCholesky l d) = d ^ 2 := by
  have htri : (doubledTTCholesky l d).BlockTriangular id := by
    intro i j hij
    fin_cases i <;> fin_cases j <;>
      simp [doubledTTCholesky] at hij ⊢
  rw [Matrix.det_of_upperTriangular htri]
  simp [doubledTTCholesky, Fin.prod_univ_succ]
  ring

def doubledTTModeQuadratic (l : ℝ) (z : DoubledTTModeCoordinates) : ℝ :=
  z 0 ^ 2 + z 1 ^ 2 + z 2 ^ 2 + z 3 ^ 2 +
    2 * l * (z 0 * z 3 - z 1 * z 2)

/-- The coordinate quadratic is exactly the quadratic form of the existing
real doubled response matrix. -/
theorem doubledTTModeQuadratic_eq_response
    (l : ℝ) (z : DoubledTTModeCoordinates) :
    doubledTTModeQuadratic l z =
      dotProduct z ((realDoubledResponse l).mulVec z) := by
  simp [doubledTTModeQuadratic, realDoubledResponse, Matrix.mulVec,
    dotProduct, Fin.sum_univ_succ]
  ring

/-- The same coordinate quadratic is the doubled Hodge kinetic action already
used in the spin-two reduction. -/
theorem doubledTTModeQuadratic_eq_doubledHodgeKinetic
    (l : ℝ) (z : DoubledTTModeCoordinates) :
    doubledTTModeQuadratic l z =
      doubledHodgeKinetic l (z 0) (z 1) (z 2) (z 3) := by
  simp [doubledTTModeQuadratic, doubledHodgeKinetic, hodgePairNormSq,
    hodgePairCross]
  ring

theorem doubledTTCholesky_normSq
    (l d : ℝ) (hd : d ^ 2 = screening l)
    (z : DoubledTTModeCoordinates) :
    ∑ i, ((doubledTTCholesky l d).mulVec z i) ^ 2 =
      doubledTTModeQuadratic l z := by
  simp [doubledTTCholesky, doubledTTModeQuadratic, Matrix.mulVec,
    dotProduct, Fin.sum_univ_succ]
  unfold screening at hd
  nlinarith

/-- The response matrix is exactly the Gram matrix of the triangular
change-of-variables frame. -/
theorem doubledTTCholesky_gram
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (doubledTTCholesky l d).transpose * doubledTTCholesky l d =
      realDoubledResponse l := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [doubledTTCholesky, realDoubledResponse, Matrix.mul_apply,
      Fin.sum_univ_succ]
  all_goals unfold screening at hd
  all_goals nlinarith

/-- The determinant of the doubled response is the square of its Schur
screening factor.  Its positive square root is therefore the single factor
that appears in the four-dimensional Gaussian denominator. -/
theorem realDoubledResponse_det_of_screening_nonneg
    (l : ℝ) (hs : 0 ≤ screening l) :
    Matrix.det (realDoubledResponse l) = screening l ^ 2 := by
  let d := Real.sqrt (screening l)
  have hd : d ^ 2 = screening l := Real.sq_sqrt hs
  rw [← doubledTTCholesky_gram l d hd, Matrix.det_mul,
    Matrix.det_transpose, doubledTTCholesky_det, hd]
  ring

theorem quarticRealDoubledResponse_det (q : ℝ) (hq : 1 < q) :
    Matrix.det (realDoubledResponse (lambda4 q)) =
      screening (lambda4 q) ^ 2 := by
  exact realDoubledResponse_det_of_screening_nonneg
    (lambda4 q) (quarticScreening_pos q hq).le

theorem pi_gaussian_product_four :
    (∫ z : DoubledTTModeCoordinates,
        Real.exp (-∑ i, (z i) ^ 2)) = Real.pi ^ 2 := by
  calc
    (∫ z : DoubledTTModeCoordinates,
        Real.exp (-∑ i, (z i) ^ 2)) =
        ∫ z : DoubledTTModeCoordinates,
          ∏ i, Real.exp (-(z i) ^ 2) := by
      congr 1
      funext z
      rw [← Real.exp_sum]
      congr 2
      simp only [Finset.sum_neg_distrib]
    _ = (∫ x : ℝ, Real.exp (-x ^ 2)) ^ 4 := by
      simpa using
        (integral_fintype_prod_volume_eq_pow
          (ι := Fin 4) (fun x : ℝ => Real.exp (-x ^ 2)))
    _ = Real.pi ^ 2 := by
      have h1 :
          (∫ x : ℝ, Real.exp (-x ^ 2)) = Real.sqrt Real.pi := by
        simpa using integral_gaussian (1 : ℝ)
      rw [h1]
      rw [show Real.sqrt Real.pi ^ 4 = Real.pi ^ 2 by
        rw [show (4 : ℕ) = 2 * 2 by norm_num, pow_mul,
          Real.sq_sqrt Real.pi_pos.le]]

def standardGaussianFour (z : DoubledTTModeCoordinates) : ℝ :=
  Real.exp (-∑ i, (z i) ^ 2)

theorem gaussian_comp_invertible_matrix_four
    (M : Matrix (Fin 4) (Fin 4) ℝ) (hM : Matrix.det M ≠ 0) :
    (∫ z : DoubledTTModeCoordinates,
        standardGaussianFour (M.mulVec z)) =
      |(Matrix.det M)⁻¹| * Real.pi ^ 2 := by
  have hlinear : Measurable (Matrix.toLin' M) :=
    (Matrix.toLin' M).continuous_of_finiteDimensional.measurable
  have hgaussian : StronglyMeasurable standardGaussianFour := by
    apply Continuous.stronglyMeasurable
    unfold standardGaussianFour
    fun_prop
  calc
    (∫ z : DoubledTTModeCoordinates,
        standardGaussianFour (M.mulVec z)) =
        ∫ y : DoubledTTModeCoordinates, standardGaussianFour y
          ∂Measure.map (Matrix.toLin' M) volume := by
      symm
      exact integral_map_of_stronglyMeasurable hlinear hgaussian
    _ = ∫ y : DoubledTTModeCoordinates, standardGaussianFour y
          ∂(ENNReal.ofReal (|(Matrix.det M)⁻¹|) • volume) := by
      rw [Real.map_matrix_volume_pi_eq_smul_volume_pi hM]
    _ = ENNReal.toReal (ENNReal.ofReal (|(Matrix.det M)⁻¹|)) •
          ∫ y : DoubledTTModeCoordinates, standardGaussianFour y := by
      rw [integral_smul_measure]
    _ = |(Matrix.det M)⁻¹| * Real.pi ^ 2 := by
      change ENNReal.toReal (ENNReal.ofReal (|(Matrix.det M)⁻¹|)) *
          (∫ y : DoubledTTModeCoordinates,
            Real.exp (-∑ i, (y i) ^ 2)) =
        |(Matrix.det M)⁻¹| * Real.pi ^ 2
      rw [pi_gaussian_product_four]
      simp

/-- The doubled two-polarization quadratic form has Gaussian mass
`pi^2 / (1-l^2)`.  The screening determinant and the Gaussian normalization
therefore arise from the same integral. -/
theorem doubledTTMode_gaussian_integral
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d) :
    (∫ z : DoubledTTModeCoordinates,
        Real.exp (-doubledTTModeQuadratic l z)) =
      Real.pi ^ 2 / screening l := by
  have hscreen : 0 < screening l := by
    rw [← hd]
    positivity
  have hdet : Matrix.det (doubledTTCholesky l d) ≠ 0 := by
    rw [doubledTTCholesky_det, hd]
    exact ne_of_gt hscreen
  calc
    (∫ z : DoubledTTModeCoordinates,
        Real.exp (-doubledTTModeQuadratic l z)) =
        ∫ z : DoubledTTModeCoordinates,
          standardGaussianFour ((doubledTTCholesky l d).mulVec z) := by
      apply integral_congr_ae
      filter_upwards with z
      unfold standardGaussianFour
      rw [doubledTTCholesky_normSq l d hd z]
    _ = |(Matrix.det (doubledTTCholesky l d))⁻¹| * Real.pi ^ 2 :=
      gaussian_comp_invertible_matrix_four (doubledTTCholesky l d) hdet
    _ = Real.pi ^ 2 / screening l := by
      rw [doubledTTCholesky_det, hd, abs_of_pos (inv_pos.mpr hscreen)]
      ring

/-- At the quartic coefficient, the doubled spin-two/Hodge Gaussian has mass
`pi^2 / screening (lambda4 q)` with no freely chosen Cholesky scale. -/
theorem quarticDoubledTT_gaussian_integral
    (q : ℝ) (hq : 1 < q) :
    (∫ z : DoubledTTModeCoordinates,
        Real.exp
          (-doubledHodgeKinetic (lambda4 q)
            (z 0) (z 1) (z 2) (z 3))) =
      Real.pi ^ 2 / screening (lambda4 q) := by
  calc
    (∫ z : DoubledTTModeCoordinates,
        Real.exp
          (-doubledHodgeKinetic (lambda4 q)
            (z 0) (z 1) (z 2) (z 3))) =
        ∫ z : DoubledTTModeCoordinates,
          Real.exp (-doubledTTModeQuadratic (lambda4 q) z) := by
      apply integral_congr_ae
      filter_upwards with z
      rw [doubledTTModeQuadratic_eq_doubledHodgeKinetic]
    _ = Real.pi ^ 2 / screening (lambda4 q) :=
      doubledTTMode_gaussian_integral
        (lambda4 q) (quarticActionAmplitude q)
          (quarticActionAmplitude_sq q hq)
          (quarticActionAmplitude_pos q hq)

/-- The coupled four-real-mode Gaussian supplies `pi^2 / screening`, while
the projective four-mode boundary supplies the second `pi^2`.  Their product
is the complete screened numerator of the gravitational coupling. -/
theorem quarticDoubledTT_gaussian_mul_projectiveBoundary
    (q : ℝ) (hq : 1 < q) :
    (∫ z : DoubledTTModeCoordinates,
        Real.exp
          (-doubledHodgeKinetic (lambda4 q)
            (z 0) (z 1) (z 2) (z 3))) *
        projectiveBoundaryVolume =
      Real.pi ^ 4 / screening (lambda4 q) := by
  rw [quarticDoubledTT_gaussian_integral q hq,
    projectiveBoundaryVolume_eq_pi_sq]
  ring

/-- With the common Fourier measure `d^4z/(2*pi)^4`, the same coupled
Gaussian and projective boundary instead give `1/(16*screening)`.  A physical
derivation must therefore fix the trace convention rather than silently
moving powers of `2*pi`. -/
theorem fourierNormalized_quarticDoubledTT_gaussian_mul_projectiveBoundary
    (q : ℝ) (hq : 1 < q) :
    (1 / (2 * Real.pi) ^ 4) *
        (∫ z : DoubledTTModeCoordinates,
          Real.exp
            (-doubledHodgeKinetic (lambda4 q)
              (z 0) (z 1) (z 2) (z 3))) *
        projectiveBoundaryVolume =
      1 / (16 * screening (lambda4 q)) := by
  rw [quarticDoubledTT_gaussian_integral q hq,
    projectiveBoundaryVolume_eq_pi_sq]
  have hs : screening (lambda4 q) ≠ 0 :=
    ne_of_gt (quarticScreening_pos q hq)
  field_simp [Real.pi_ne_zero, hs]
  ring

/-- The deposited gravitational expression factors exactly into the coupled
doubled-TT Gaussian, the projective boundary, and the forced 224-channel
scale. -/
theorem gravitationalCoupling_eq_quarticDoubledTT_gaussian_boundary
    (rho q : ℝ) (hq : 1 < q) :
    gravitationalCoupling rho q =
      ((∫ z : DoubledTTModeCoordinates,
          Real.exp
            (-doubledHodgeKinetic (lambda4 q)
              (z 0) (z 1) (z 2) (z 3))) *
        projectiveBoundaryVolume) /
          (rho * q) ^ gravitationalExponent := by
  rw [quarticDoubledTT_gaussian_mul_projectiveBoundary q hq]
  simp [gravitationalCoupling]
  ring

#print axioms GravityScreening.doubledTTCholesky_det
#print axioms GravityScreening.doubledTTCholesky_normSq
#print axioms GravityScreening.doubledTTCholesky_gram
#print axioms GravityScreening.realDoubledResponse_det_of_screening_nonneg
#print axioms GravityScreening.quarticRealDoubledResponse_det
#print axioms GravityScreening.doubledTTModeQuadratic_eq_response
#print axioms GravityScreening.doubledTTModeQuadratic_eq_doubledHodgeKinetic
#print axioms GravityScreening.pi_gaussian_product_four
#print axioms GravityScreening.gaussian_comp_invertible_matrix_four
#print axioms GravityScreening.doubledTTMode_gaussian_integral
#print axioms GravityScreening.quarticDoubledTT_gaussian_integral
#print axioms GravityScreening.quarticDoubledTT_gaussian_mul_projectiveBoundary
#print axioms GravityScreening.fourierNormalized_quarticDoubledTT_gaussian_mul_projectiveBoundary
#print axioms GravityScreening.gravitationalCoupling_eq_quarticDoubledTT_gaussian_boundary

end

end GravityScreening
