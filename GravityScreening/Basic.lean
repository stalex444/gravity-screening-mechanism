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

/-- The surviving coefficient after eliminating the second coordinate of a
general symmetric two-channel quadratic block, expressed relative to the first
diagonal coefficient. -/
noncomputable def relativeSchur (a b c : ℝ) : ℝ :=
  (a - b ^ 2 / c) / a

/-- Running the screening formula backward: for nonzero diagonal entries, a
general two-channel block has relative Schur coefficient `1-l^2` exactly when
its normalization-invariant squared overlap is `l^2`. -/
theorem relativeSchur_eq_screening_iff
    (a b c l : ℝ) (ha : a ≠ 0) (hc : c ≠ 0) :
    relativeSchur a b c = screening l ↔ b ^ 2 = l ^ 2 * a * c := by
  unfold relativeSchur screening
  constructor <;> intro h
  · field_simp [ha, hc] at h
    nlinarith
  · field_simp [ha, hc]
    nlinarith

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

/-- The total mass of the Perron frequency vector. -/
def quarticPerronMass (q : ℝ) : ℝ := 1 + q + q ^ 2 + q ^ 3

/-- After normalizing the positive Perron vector by total letter count, the
frequency of the renewal letter `1` is exactly `lambda4`. Standard primitive-
substitution theory identifies this normalized Perron coordinate with the
unique invariant letter frequency. -/
theorem quarticRenewalFrequency (q : ℝ) (hq : q ^ 4 = q + 1) (hq1 : 1 < q) :
    1 / quarticPerronMass q = lambda4 q := by
  have hq0 : q ≠ 0 := by linarith
  have hs : quarticPerronMass q ≠ 0 := by
    unfold quarticPerronMass
    positivity
  unfold quarticPerronMass lambda4 at *
  field_simp [hq0, hs]
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

/-- The scalar Julia block is an involution. This is the algebraic reason it
can be read both as a Hermitian two-channel observable and as a one-tick
unitary evolution. -/
def juliaBlock (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![l,d; d,-l]

theorem juliaBlock_sq (l d : ℝ) (hdefect : d ^ 2 = screening l) :
    juliaBlock l d * juliaBlock l d = 1 := by
  have hsum : l * l + d * d = 1 := by
    simp [screening] at hdefect
    nlinarith [hdefect]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [juliaBlock, Matrix.mul_apply, Fin.sum_univ_succ] <;>
    nlinarith [hsum]

/-- A scalar real coefficient acting on a one-dimensional complex amplitude
space. -/
noncomputable def scalarKraus (a : ℝ) (z : ℂ) : ℂ := (a : ℂ) * z

/-- The minimal two-channel completion conserves the Born norm exactly. -/
theorem scalarKraus_completeness (l d : ℝ)
    (hdefect : d ^ 2 = screening l) (z : ℂ) :
    Complex.normSq (scalarKraus l z) +
      Complex.normSq (scalarKraus d z) = Complex.normSq z := by
  have hsum := julia_row_norm l d hdefect
  rw [show Complex.normSq (scalarKraus l z) =
      l ^ 2 * Complex.normSq z by
    simp [scalarKraus, Complex.normSq_mul, Complex.normSq_ofReal, pow_two]]
  rw [show Complex.normSq (scalarKraus d z) =
      d ^ 2 * Complex.normSq z by
    simp [scalarKraus, Complex.normSq_mul, Complex.normSq_ofReal, pow_two]]
  calc
    l ^ 2 * Complex.normSq z + d ^ 2 * Complex.normSq z =
        (l ^ 2 + d ^ 2) * Complex.normSq z := by ring
    _ = Complex.normSq z := by rw [hsum]; ring

/-- The exact conditional Perron-horizon theorem: the quartic inverse-step
residue has amplitude `lambda4` on its positive scaling line, and any supplied
minimal complementary amplitude conserves Born norm with it. The mathematical
statement does not identify this completion with a physical causal horizon. -/
theorem quarticPerron_horizon_instrument
    (q d : ℝ) (z : ℂ) (hq : q ^ 4 = q + 1) (hq0 : q ≠ 0)
    (hdefect : d ^ 2 = screening (lambda4 q)) :
    quarticResidual.mulVec (quarticPerronVector q) =
        (fun i => lambda4 q * quarticPerronVector q i) ∧
      Complex.normSq (scalarKraus (lambda4 q) z) +
        Complex.normSq (scalarKraus d z) = Complex.normSq z := by
  exact ⟨quarticResidual_perron q hq hq0,
    scalarKraus_completeness (lambda4 q) d hdefect z⟩

/-! ## The same residue from KMS detailed balance -/

/-- The normalized causal asymmetry between a process and its thermal reverse. -/
noncomputable def detailedBalanceDefect (β ω : ℝ) : ℝ :=
  1 - Real.exp (-β * ω)

/-- If the reverse spectral weight is fixed by KMS detailed balance, subtracting
it from the forward weight and normalizing by the forward weight gives the
thermal causal-response defect. -/
theorem kms_causal_response (β ω forward reverse : ℝ) (hforward : forward ≠ 0)
    (hkms : reverse = Real.exp (-β * ω) * forward) :
    (forward - reverse) / forward = detailedBalanceDefect β ω := by
  rw [hkms]
  unfold detailedBalanceDefect
  field_simp [hforward]

/-- At the Perron inverse temperature of the quartic graph and unit gauge
frequency, the KMS causal-response defect is exactly the quartic residue. -/
theorem quartic_kms_defect (q : ℝ) (hq : 0 < q) :
    detailedBalanceDefect (Real.log q) 1 = lambda4 q := by
  unfold detailedBalanceDefect lambda4
  rw [mul_one, Real.exp_neg, Real.exp_log hq]
  simp [one_div]

/-- The residue eigen-amplitude and the unit-frequency KMS response coincide
at the quartic Perron inverse temperature. -/
theorem quarticPerron_kms_response
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 0 < q) :
    quarticResidual.mulVec (quarticPerronVector q) =
        (fun i => detailedBalanceDefect (Real.log q) 1 *
          quarticPerronVector q i) := by
  rw [quartic_kms_defect q hq]
  exact quarticResidual_perron q hq4 (ne_of_gt hq)

/-- A scalar modular-frequency shift preserves the quartic KMS response if and
only if the shift vanishes. This is the exact cocycle-neutrality test for a
one-dimensional quartic spectral subspace. -/
theorem quartic_response_shift_eq_iff (q δ : ℝ) (hq : 0 < q) :
    detailedBalanceDefect 1 (Real.log q + δ) = lambda4 q ↔ δ = 0 := by
  have hbase : Real.exp (-Real.log q) = 1 / q := by
    rw [Real.exp_neg, Real.exp_log hq]
    simp [one_div]
  constructor
  · intro h
    have h' : 1 - Real.exp (-(Real.log q + δ)) = 1 - 1 / q := by
      simpa [detailedBalanceDefect, lambda4] using h
    have hexp : Real.exp (-(Real.log q + δ)) =
        Real.exp (-Real.log q) := by
      rw [hbase]
      linarith [h']
    have harg := Real.exp_injective hexp
    linarith
  · intro hδ
    subst δ
    simpa [detailedBalanceDefect] using quartic_kms_defect q hq

/-- The full reverse KMS test: the quartic response fixes the product of
inverse temperature and spectral frequency to `log q`. -/
theorem kms_response_eq_quartic_iff (q beta omega : ℝ) (hq : 0 < q) :
    detailedBalanceDefect beta omega = lambda4 q ↔
      beta * omega = Real.log q := by
  have hbase : Real.exp (-Real.log q) = 1 / q := by
    rw [Real.exp_neg, Real.exp_log hq]
    simp [one_div]
  constructor
  · intro h
    have h' : 1 - Real.exp (-beta * omega) = 1 - 1 / q := by
      simpa [detailedBalanceDefect, lambda4] using h
    have hexp : Real.exp (-beta * omega) =
        Real.exp (-Real.log q) := by
      rw [hbase]
      linarith [h']
    have harg := Real.exp_injective hexp
    linarith
  · intro hproduct
    unfold detailedBalanceDefect lambda4
    have hneg : -beta * omega = -Real.log q := by
      nlinarith
    rw [hneg, Real.exp_neg, Real.exp_log hq]
    simp [one_div]

/-- With the conventional wedge inverse temperature `2*pi`, matching the
quartic response fixes the boost frequency to `log(q)/(2*pi)`. The physical
choice of this normalization is an input; the equivalence is exact algebra. -/
theorem wedge_response_eq_quartic_iff (q omega : ℝ) (hq : 0 < q) :
    detailedBalanceDefect (2 * Real.pi) omega = lambda4 q ↔
      omega = Real.log q / (2 * Real.pi) := by
  rw [kms_response_eq_quartic_iff q (2 * Real.pi) omega hq]
  constructor <;> intro h
  · apply (eq_div_iff (mul_ne_zero (by norm_num) Real.pi_ne_zero)).2
    nlinarith
  · apply (eq_div_iff (mul_ne_zero (by norm_num) Real.pi_ne_zero)).1 at h
    nlinarith

/-! ## The continuous-core trace ray

For the continuous core of a type-III factor, the canonical trace satisfies
`tau ∘ theta_s = exp (-s) tau` under the dual action. The operator-algebraic
existence of the core, trace, and dual action is a carried theorem of
Connes--Takesaki theory. The declarations below kernel-check the exact scalar
consequences on its one-dimensional trace ray.
-/

/-- Scalar action induced on a finite trace value by the dual flow. -/
noncomputable def coreTraceScale (s mass : ℝ) : ℝ :=
  Real.exp (-s) * mass

/-- A quartic logarithmic step retains exactly the inverse Perron fraction. -/
theorem coreTraceScale_log (q mass : ℝ) (hq : 0 < q) :
    coreTraceScale (Real.log q) mass = mass / q := by
  unfold coreTraceScale
  rw [Real.exp_neg, Real.exp_log hq]
  field_simp [ne_of_gt hq]

/-- The relative trace loss of one quartic logarithmic step is `lambda4`. -/
theorem coreTraceDefect_log (q mass : ℝ) (hq : 0 < q) (hmass : mass ≠ 0) :
    (mass - coreTraceScale (Real.log q) mass) / mass = lambda4 q := by
  rw [coreTraceScale_log q mass hq]
  unfold lambda4
  field_simp [ne_of_gt hq, hmass]

/-- Two successive dual-flow steps multiply their trace-scale factors. -/
theorem coreTraceScale_add (s t mass : ℝ) :
    coreTraceScale (s + t) mass =
      coreTraceScale s (coreTraceScale t mass) := by
  unfold coreTraceScale
  rw [neg_add, Real.exp_add]
  ring

/-- On the trace ray, subtracting the quartic scale step twice and taking the
complement gives exactly the proposed gravitational survivor. Equivalently,
`I - (I-T_Q)^2 = 2*T_Q - T_Q^2` has eigenvalue `1-lambda4^2` when
`T_Q` has trace eigenvalue `1/q`. -/
theorem coreSelfDefect_survivor (q mass : ℝ)
    (hq : 0 < q) (hmass : mass ≠ 0) :
    (2 * coreTraceScale (Real.log q) mass -
        coreTraceScale (2 * Real.log q) mass) / mass =
      screening (lambda4 q) := by
  rw [coreTraceScale_log q mass hq]
  have htwo : coreTraceScale (2 * Real.log q) mass = mass / q ^ 2 := by
    unfold coreTraceScale
    have hrewrite : -(2 * Real.log q) = -Real.log q + -Real.log q := by ring
    rw [hrewrite, Real.exp_add, Real.exp_neg, Real.exp_log hq]
    field_simp [ne_of_gt hq]
  rw [htwo, quartic_screening_identity q (ne_of_gt hq)]
  field_simp [ne_of_gt hq, hmass]

/-! ## Jacobson scaling consequences -/

/-- In natural units, Jacobson's area-entropy density fixes the gravitational
coupling by `G = 1/(4*eta)`. This declaration records that scalar relation. -/
noncomputable def jacobsonCoupling (eta : ℝ) : ℝ :=
  1 / (4 * eta)

/-- Reducing the horizon entropy density by a nonzero factor `s` increases
Jacobson's gravitational coupling by the inverse factor. -/
theorem jacobsonCoupling_density_scale (eta s : ℝ)
    (heta : eta ≠ 0) (hs : s ≠ 0) :
    jacobsonCoupling (s * eta) = jacobsonCoupling eta / s := by
  unfold jacobsonCoupling
  field_simp [heta, hs]

/-- If the continuous-core self-defect multiplies the microscopic entropy
density, Jacobson's relation gives precisely the inverse screening correction
to Newton's coupling. -/
theorem coreSurvivor_jacobsonCoupling (q eta : ℝ)
    (hq : 0 < q) (heta : eta ≠ 0)
    (hs : screening (lambda4 q) ≠ 0) :
    jacobsonCoupling (screening (lambda4 q) * eta) =
      jacobsonCoupling eta / ((2 * q - 1) / q ^ 2) := by
  rw [jacobsonCoupling_density_scale eta (screening (lambda4 q)) heta hs]
  rw [quartic_screening_identity q (ne_of_gt hq)]

/-- The squared Planck scale is the reciprocal gravitational coupling. -/
noncomputable def planckScaleSq (G : ℝ) : ℝ :=
  1 / G

/-- The same entropy-density correction multiplies the squared Planck scale,
so a positive Planck mass is multiplied by its positive square root. -/
theorem coreSurvivor_planckScaleSq (q eta : ℝ)
    (heta : eta ≠ 0)
    (hs : screening (lambda4 q) ≠ 0) :
    planckScaleSq
        (jacobsonCoupling (screening (lambda4 q) * eta)) =
      screening (lambda4 q) *
        planckScaleSq (jacobsonCoupling eta) := by
  rw [jacobsonCoupling_density_scale eta (screening (lambda4 q)) heta hs]
  unfold planckScaleSq jacobsonCoupling
  field_simp [heta, hs]

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

/-- The deposited portal potential written in fluctuations `phi = v + h` and
`chi = x` about the selected axis background `(v,0)`. -/
def shiftedPortalPotential
    (lambda3 lambda4c kappa v u h x : ℝ) : ℝ :=
  lambda3 * (((v + h) ^ 2 - v ^ 2) ^ 2) +
    lambda4c * ((x ^ 2 - u ^ 2) ^ 2) +
    kappa * (v + h) ^ 2 * x ^ 2

/-- The exact fluctuation expansion. There is no bilinear `h*x` term; the
first cross-sector interaction is the cubic term `2*kappa*v*h*x^2`. -/
theorem shiftedPortalPotential_expand
    (lambda3 lambda4c kappa v u h x : ℝ) :
    shiftedPortalPotential lambda3 lambda4c kappa v u h x =
      lambda4c * u ^ 4 +
      4 * lambda3 * v ^ 2 * h ^ 2 +
      4 * lambda3 * v * h ^ 3 +
      lambda3 * h ^ 4 +
      (kappa * v ^ 2 - 2 * lambda4c * u ^ 2) * x ^ 2 +
      2 * kappa * v * h * x ^ 2 +
      kappa * h ^ 2 * x ^ 2 +
      lambda4c * x ^ 4 := by
  unfold shiftedPortalPotential
  ring

/-- The unbroken `chi -> -chi` symmetry is exact about the axis background. -/
theorem shiftedPortalPotential_chi_even
    (lambda3 lambda4c kappa v u h x : ℝ) :
    shiftedPortalPotential lambda3 lambda4c kappa v u h (-x) =
      shiftedPortalPotential lambda3 lambda4c kappa v u h x := by
  simp [shiftedPortalPotential]

end GravityScreening

#print axioms GravityScreening.response_completed_square
#print axioms GravityScreening.response_at_stationary
#print axioms GravityScreening.normalized_block_det
#print axioms GravityScreening.relativeSchur_eq_screening_iff
#print axioms GravityScreening.screening_pos
#print axioms GravityScreening.quartic_screening_identity
#print axioms GravityScreening.lambda4_eq_relative_increment
#print axioms GravityScreening.quarticCompanion_mul_inv
#print axioms GravityScreening.quarticCompanion_inv_mul
#print axioms GravityScreening.quarticCompanion_perron
#print axioms GravityScreening.quarticRenewalFrequency
#print axioms GravityScreening.quarticResidual_eq_one_sub_inv
#print axioms GravityScreening.quarticResidual_perron
#print axioms GravityScreening.defect_sq_forced
#print axioms GravityScreening.defect_sqrt_sq
#print axioms GravityScreening.julia_row_norm
#print axioms GravityScreening.julia_rows_orthogonal
#print axioms GravityScreening.juliaBlock_sq
#print axioms GravityScreening.scalarKraus_completeness
#print axioms GravityScreening.quarticPerron_horizon_instrument
#print axioms GravityScreening.kms_causal_response
#print axioms GravityScreening.quartic_kms_defect
#print axioms GravityScreening.quarticPerron_kms_response
#print axioms GravityScreening.quartic_response_shift_eq_iff
#print axioms GravityScreening.kms_response_eq_quartic_iff
#print axioms GravityScreening.wedge_response_eq_quartic_iff
#print axioms GravityScreening.coreTraceScale_log
#print axioms GravityScreening.coreTraceDefect_log
#print axioms GravityScreening.coreTraceScale_add
#print axioms GravityScreening.coreSelfDefect_survivor
#print axioms GravityScreening.jacobsonCoupling_density_scale
#print axioms GravityScreening.coreSurvivor_jacobsonCoupling
#print axioms GravityScreening.coreSurvivor_planckScaleSq
#print axioms GravityScreening.defect_mass_square
#print axioms GravityScreening.radial_homogeneity_iff
#print axioms GravityScreening.ehrenfest_marginal_iff
#print axioms GravityScreening.frameMetricCross_eq_zero
#print axioms GravityScreening.portalMixedHessian_at_chi_axis
#print axioms GravityScreening.shiftedPortalPotential_expand
#print axioms GravityScreening.shiftedPortalPotential_chi_even
