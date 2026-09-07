import GravityScreening.PalomarCapstone
import GravityScreening.TTHorizonCode
import GravityScreening.ConservedFlux
import GravityScreening.TTResponseUniqueness

/-!
# Gravitational-wave observable placement

This file isolates what a constant quartic screening coefficient can and
cannot do to a gravitational-wave observation.

There are three exact pieces.

1. Multiplying any homogeneous wave equation by a nonzero constant preserves
   its vacuum mode set.  A uniform coefficient alone therefore cannot move a
   dispersion relation or a linear ringdown frequency.
2. At leading quadrupole order, chirp rate and metric strain contain the same
   source scale.  The standard-siren quotient cancels every common constant
   response, including a constant rescaling of Newton's coupling.
3. If, as an additional physical hypothesis, the chirp records total emitted
   power while the detector sees only a `sqrt(s)`-retained exterior amplitude,
   the inferred distance is instead multiplied by `1 / sqrt(s)`.

The third item is deliberately conditional.  The existing same-physical-metric
theorem gives the competing branch: inverse screening of Newton's coupling
exactly compensates the canonical-amplitude attenuation at every detector
readout.  Selecting between these placements is physics, not algebra.
-/

namespace GravityScreening

/-! ## A uniform coefficient cannot move vacuum modes -/

/-- A field is a vacuum mode at parameter `omega` when every component of the
operator output vanishes.  The parameter may represent frequency, momentum,
or any other spectral label. -/
def IsVacuumMode {Omega Field Index : Type}
    (operator : Omega → Field → Index → ℝ)
    (omega : Omega) (field : Field) : Prop :=
  ∀ i, operator omega field i = 0

/-- Multiply every component of an operator by the same scalar. -/
def uniformlyWeightedOperator {Omega Field Index : Type}
    (s : ℝ) (operator : Omega → Field → Index → ℝ) :
    Omega → Field → Index → ℝ :=
  fun omega field i => s * operator omega field i

/-- A nonzero uniform weight preserves the complete vacuum mode set. -/
theorem nonzeroUniformWeight_preserves_vacuumModes
    {Omega Field Index : Type}
    (s : ℝ) (operator : Omega → Field → Index → ℝ)
    (omega : Omega) (field : Field) (hs : s ≠ 0) :
    IsVacuumMode (uniformlyWeightedOperator s operator) omega field ↔
      IsVacuumMode operator omega field := by
  constructor
  · intro h i
    exact (mul_eq_zero.mp (h i)).resolve_left hs
  · intro h i
    simp [uniformlyWeightedOperator, h i]

/-- Specialization to the Lorentzian five-term spin-two symbol.  Its uniform
quartic coefficient changes sourced normalization but not the homogeneous
equations. -/
theorem quarticLorentzCoefficient_preserves_vacuumEquations
    (q a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h : Matrix FlatIndex FlatIndex ℝ) (hq : 1 < q) :
    (∀ mu nu,
        ((2 * q - 1) / q ^ 2) *
          lorentzPauliFierzSymbol a b c d e k h mu nu = 0) ↔
      (∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k h mu nu = 0) := by
  have hq0 : q ≠ 0 := by linarith
  have hweight : (2 * q - 1) / q ^ 2 ≠ 0 := by
    exact ne_of_gt (div_pos (by linarith) (sq_pos_of_ne_zero hq0))
  constructor
  · intro hw mu nu
    exact (mul_eq_zero.mp (hw mu nu)).resolve_left hweight
  · intro hzero mu nu
    simp [hzero mu nu]

/-! ## Leading-order standard-siren algebra -/

/-- Leading chirp rate after separating the known frequency-dependent shape,
an observable-response factor, and the common binary source scale.  In the
quadrupole formula the source scale is proportional to
`(G * chirpMass)^(5/3)`. -/
def leadingChirpRate
    (chirpShape response sourceScale : ℝ) : ℝ :=
  chirpShape * response * sourceScale

/-- Leading metric-strain amplitude with its distance dependence separated. -/
noncomputable def leadingMetricStrain
    (strainShape response sourceScale luminosityDistance : ℝ) : ℝ :=
  strainShape * response * sourceScale / luminosityDistance

/-- The common Newton-coupling scale in both leading quadrupole observables. -/
noncomputable def quadrupoleCouplingScale
    (G chirpMass : ℝ) : ℝ :=
  Real.rpow (G * chirpMass) ((5 : ℝ) / 3)

/-- The leading quadrupole response forced by inverse quartic screening of
Newton's coupling. -/
noncomputable def quarticQuadrupoleCommonResponse (q : ℝ) : ℝ :=
  Real.rpow (q ^ 2 / (2 * q - 1)) ((5 : ℝ) / 3)

/-- Rescaling a nonnegative Newton coupling by a nonnegative factor `r`
rescales the standard quadrupole source scale by `r^(5/3)`. -/
theorem quadrupoleCouplingScale_mul
    (r G chirpMass : ℝ)
    (hr : 0 ≤ r) (hG : 0 ≤ G) (hM : 0 ≤ chirpMass) :
    quadrupoleCouplingScale (r * G) chirpMass =
      Real.rpow r ((5 : ℝ) / 3) *
        quadrupoleCouplingScale G chirpMass := by
  unfold quadrupoleCouplingScale
  rw [show (r * G) * chirpMass = r * (G * chirpMass) by ring]
  exact Real.mul_rpow hr (mul_nonneg hG hM)

/-- The action-level inverse-screening response forces the exact common
`S_Q^(-5/3)` scale in both leading quadrupole observables. -/
theorem quarticNewtonResponse_forces_quadrupoleCommonResponse
    (q G0 GQ chirpMass : ℝ)
    (hq : 1 < q) (hG0 : 0 ≤ G0) (hM : 0 ≤ chirpMass)
    (hGQ : GQ = G0 / ((2 * q - 1) / q ^ 2)) :
    quadrupoleCouplingScale GQ chirpMass =
      quarticQuadrupoleCommonResponse q *
        quadrupoleCouplingScale G0 chirpMass := by
  have hq0 : q ≠ 0 := by linarith
  have hden : 2 * q - 1 ≠ 0 := by linarith
  have hrpos : 0 < q ^ 2 / (2 * q - 1) :=
    div_pos (sq_pos_of_ne_zero hq0) (by linarith)
  have hresponse :
      G0 / ((2 * q - 1) / q ^ 2) =
        (q ^ 2 / (2 * q - 1)) * G0 := by
    field_simp [hq0, hden]
  rw [hGQ, hresponse]
  exact quadrupoleCouplingScale_mul
    (q ^ 2 / (2 * q - 1)) G0 chirpMass hrpos.le hG0 hM

/-- The algebraic standard-siren distance estimator.  The two shape factors
include the known frequency powers and numerical constants. -/
noncomputable def inferredStandardSirenDistance
    (chirpShape strainShape chirpRate strain : ℝ) : ℝ :=
  strainShape * chirpRate / (chirpShape * strain)

/-- The inferred distance measures only the ratio between the response seen
in the chirp and the response seen in the strain.  The common source scale
cancels exactly. -/
theorem standardSirenDistance_eq_responseRatio
    (chirpShape strainShape chirpResponse strainResponse
      sourceScale luminosityDistance : ℝ)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hstrainResponse : strainResponse ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape chirpResponse sourceScale)
        (leadingMetricStrain strainShape strainResponse sourceScale
          luminosityDistance) =
      luminosityDistance * chirpResponse / strainResponse := by
  unfold inferredStandardSirenDistance leadingChirpRate leadingMetricStrain
  field_simp [hchirpShape, hstrainShape, hstrainResponse,
    hsourceScale, hdistance]

/-- For nonzero leading-order data, the standard-siren distance is unbiased
exactly when chirp and strain carry the same response.  This turns the
source/detector placement question into a necessary-and-sufficient condition,
rather than merely a sufficient cancellation rule. -/
theorem standardSiren_unbiased_iff_responses_equal
    (chirpShape strainShape chirpResponse strainResponse
      sourceScale luminosityDistance : ℝ)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hstrainResponse : strainResponse ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape chirpResponse sourceScale)
        (leadingMetricStrain strainShape strainResponse sourceScale
          luminosityDistance) = luminosityDistance ↔
      chirpResponse = strainResponse := by
  rw [standardSirenDistance_eq_responseRatio chirpShape strainShape
    chirpResponse strainResponse sourceScale luminosityDistance
    hchirpShape hstrainShape hstrainResponse hsourceScale hdistance]
  field_simp [hstrainResponse, hdistance]

/-- Any nonzero response common to chirp and strain is invisible to the
leading standard-siren distance. -/
theorem commonResponse_cancels_from_standardSiren
    (chirpShape strainShape response sourceScale luminosityDistance : ℝ)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hresponse : response ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape response sourceScale)
        (leadingMetricStrain strainShape response sourceScale
          luminosityDistance) = luminosityDistance := by
  rw [standardSirenDistance_eq_responseRatio chirpShape strainShape
    response response sourceScale luminosityDistance hchirpShape
    hstrainShape hresponse hsourceScale hdistance]
  field_simp [hresponse]

/-- If the chirp is unchanged but the observed strain alone is multiplied by
`amplitudeRetention`, the inferred distance is divided by that factor. -/
theorem amplitudeOnlyRetention_biases_standardSiren
    (chirpShape strainShape amplitudeRetention sourceScale
      luminosityDistance : ℝ)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hretention : amplitudeRetention ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape 1 sourceScale)
        (leadingMetricStrain strainShape amplitudeRetention sourceScale
          luminosityDistance) =
      luminosityDistance / amplitudeRetention := by
  simpa using
    standardSirenDistance_eq_responseRatio chirpShape strainShape
      1 amplitudeRetention sourceScale luminosityDistance hchirpShape
      hstrainShape hretention hsourceScale hdistance

/-- Conditional quartic fork: an exterior-only `sqrt(S_Q)` strain readout,
with the chirp tracking an unattenuated total flux, produces the exact distance
factor `1/sqrt(S_Q)`. -/
theorem quarticExteriorOnly_standardSirenDistance
    (q chirpShape strainShape sourceScale luminosityDistance : ℝ)
    (hq : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape 1 sourceScale)
        (leadingMetricStrain strainShape
          (Real.sqrt (screening (lambda4 q))) sourceScale
          luminosityDistance) =
      luminosityDistance / Real.sqrt ((2 * q - 1) / q ^ 2) := by
  have hq0 : q ≠ 0 := by linarith
  have hscreening : 0 < screening (lambda4 q) := by
    rw [quartic_screening_identity q hq0]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hsqrt : Real.sqrt (screening (lambda4 q)) ≠ 0 :=
    ne_of_gt (Real.sqrt_pos.2 hscreening)
  rw [amplitudeOnlyRetention_biases_standardSiren chirpShape strainShape
    (Real.sqrt (screening (lambda4 q))) sourceScale luminosityDistance
    hchirpShape hstrainShape hsqrt hsourceScale hdistance]
  rw [quartic_screening_identity q hq0]

/-- With the action-forced common quadrupole response present in both
observables, an additional exterior `sqrt(S_Q)` attenuation in strain is the
only factor left in the leading standard-siren quotient. -/
theorem quarticQuadrupoleExterior_standardSirenDistance
    (q chirpShape strainShape sourceScale luminosityDistance : ℝ)
    (hq : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape
          (quarticQuadrupoleCommonResponse q) sourceScale)
        (leadingMetricStrain strainShape
          (quarticQuadrupoleCommonResponse q *
            Real.sqrt (screening (lambda4 q)))
          sourceScale luminosityDistance) =
      luminosityDistance / Real.sqrt ((2 * q - 1) / q ^ 2) := by
  have hq0 : q ≠ 0 := by linarith
  have hratioPos : 0 < q ^ 2 / (2 * q - 1) :=
    div_pos (sq_pos_of_ne_zero hq0) (by linarith)
  have hcommon : quarticQuadrupoleCommonResponse q ≠ 0 :=
    ne_of_gt (Real.rpow_pos_of_pos hratioPos _)
  have hscreening : 0 < screening (lambda4 q) := by
    rw [quartic_screening_identity q hq0]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hsqrt : Real.sqrt (screening (lambda4 q)) ≠ 0 :=
    ne_of_gt (Real.sqrt_pos.2 hscreening)
  rw [standardSirenDistance_eq_responseRatio chirpShape strainShape
    (quarticQuadrupoleCommonResponse q)
    (quarticQuadrupoleCommonResponse q *
      Real.sqrt (screening (lambda4 q)))
    sourceScale luminosityDistance hchirpShape hstrainShape
    (mul_ne_zero hcommon hsqrt) hsourceScale hdistance]
  rw [quartic_screening_identity q hq0]
  field_simp [hcommon, hsqrt]

/-- Channel-selection capstone. If the chirp rate is sourced by the complete
visible-plus-hidden diagonal flux, while the detector receives the exterior
TT amplitude, exact global conservation selects the exterior-only
standard-siren response. The physical identification of the diagonal
observable with radiated energy flux remains an explicit premise. -/
theorem quarticGlobalFluxExteriorReadout_standardSirenDistance {n : ℕ}
    (q : ℝ) (k : Fin n → ℝ) (psi : Fin n → ℂ)
    (chirpShape strainShape luminosityDistance : ℝ)
    (hq : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hflux : finiteDiagonalExpectation k psi ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape
          (quarticQuadrupoleCommonResponse q)
          (exteriorDataExpectation k (quarticErasureDilation q psi) +
            hiddenDataExpectation k (quarticErasureDilation q psi)))
        (leadingMetricStrain strainShape
          (quarticQuadrupoleCommonResponse q *
            Real.sqrt (screening (lambda4 q)))
          (finiteDiagonalExpectation k psi) luminosityDistance) =
      luminosityDistance / Real.sqrt ((2 * q - 1) / q ^ 2) := by
  rw [quarticErasureDilation_total_expectation q k psi hq]
  exact quarticQuadrupoleExterior_standardSirenDistance
    q chirpShape strainShape (finiteDiagonalExpectation k psi)
    luminosityDistance hq hchirpShape hstrainShape hflux hdistance

/-- The same conditional result as an observable dimensionless ratio. -/
theorem quarticExteriorOnly_standardSirenRatio
    (q chirpShape strainShape sourceScale luminosityDistance : ℝ)
    (hq : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
          (leadingChirpRate chirpShape 1 sourceScale)
          (leadingMetricStrain strainShape
            (Real.sqrt (screening (lambda4 q))) sourceScale
            luminosityDistance) /
        luminosityDistance =
      1 / Real.sqrt ((2 * q - 1) / q ^ 2) := by
  rw [quarticExteriorOnly_standardSirenDistance q chirpShape strainShape
    sourceScale luminosityDistance hq hchirpShape hstrainShape
    hsourceScale hdistance]
  field_simp [hdistance]

/-! ## Rigorous quartic-root prediction interval -/

/-- The positive real root of `q^4=q+1` lies below `1.221`. -/
theorem quarticRoot_lt_1221_perThousand
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    q < (1221 : ℝ) / 1000 := by
  let r : ℝ := 1221 / 1000
  have hr1 : 1 < r := by norm_num [r]
  have hq0 : 0 < q := lt_trans zero_lt_one hq1
  have hr0 : 0 < r := lt_trans zero_lt_one hr1
  have hfac :
      0 < q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1 := by
    have hq3 : 0 < q ^ 3 := pow_pos hq0 3
    have hq2r : 0 ≤ q ^ 2 * r := mul_nonneg (sq_nonneg q) hr0.le
    have hqr2 : 0 ≤ q * r ^ 2 := mul_nonneg hq0.le (sq_nonneg r)
    have hr3 : 1 < r ^ 3 := by norm_num [r]
    nlinarith
  have hfr : 0 < r ^ 4 - r - 1 := by norm_num [r]
  by_contra h
  have hge : r ≤ q := by
    simpa [r] using (le_of_not_gt h)
  have hmul :
      0 ≤ (q - r) * (q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1) :=
    mul_nonneg (sub_nonneg.mpr hge) hfac.le
  have hid :
      q ^ 4 - q - 1 - (r ^ 4 - r - 1) =
        (q - r) * (q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1) := by
    ring
  rw [hq4] at hid
  nlinarith

/-- The positive real root of `q^4=q+1` lies above `1.2207`. -/
theorem quarticRoot_gt_12207_perTenThousand
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    (12207 : ℝ) / 10000 < q := by
  let r : ℝ := 12207 / 10000
  have hr1 : 1 < r := by norm_num [r]
  have hq0 : 0 < q := lt_trans zero_lt_one hq1
  have hr0 : 0 < r := lt_trans zero_lt_one hr1
  have hfac :
      0 < q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1 := by
    have hq3 : 0 < q ^ 3 := pow_pos hq0 3
    have hq2r : 0 ≤ q ^ 2 * r := mul_nonneg (sq_nonneg q) hr0.le
    have hqr2 : 0 ≤ q * r ^ 2 := mul_nonneg hq0.le (sq_nonneg r)
    have hr3 : 1 < r ^ 3 := by norm_num [r]
    nlinarith
  have hfr : r ^ 4 - r - 1 < 0 := by norm_num [r]
  by_contra h
  have hle : q ≤ r := by
    simpa [r] using (le_of_not_gt h)
  have hmul :
      (q - r) * (q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1) ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hle) hfac.le
  have hid :
      q ^ 4 - q - 1 - (r ^ 4 - r - 1) =
        (q - r) * (q ^ 3 + q ^ 2 * r + q * r ^ 2 + r ^ 3 - 1) := by
    ring
  rw [hq4] at hid
  nlinarith

/-- The quartic screening power factor lies strictly between `0.9672` and
`0.9674`. These rational bounds use only the defining quartic equation. -/
theorem quarticScreeningFactor_bounds
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    (9672 : ℝ) / 10000 < (2 * q - 1) / q ^ 2 ∧
      (2 * q - 1) / q ^ 2 < (9674 : ℝ) / 10000 := by
  have hqlo := quarticRoot_gt_12207_perTenThousand q hq4 hq1
  have hqhi := quarticRoot_lt_1221_perThousand q hq4 hq1
  have hq0 : 0 < q := lt_trans zero_lt_one hq1
  have hq2 : 0 < q ^ 2 := sq_pos_of_pos hq0
  constructor
  · rw [lt_div_iff₀ hq2]
    let a : ℝ := 9672 / 10000
    let r : ℝ := 1221 / 1000
    have hqr : q < r := by simpa [r] using hqhi
    have hfac : 0 < a * (q + r) - 2 := by
      dsimp [a, r]
      nlinarith
    have hprod : (q - r) * (a * (q + r) - 2) < 0 :=
      mul_neg_of_neg_of_pos (sub_neg.mpr hqr) hfac
    have hid :
        (a * q ^ 2 - 2 * q + 1) -
            (a * r ^ 2 - 2 * r + 1) =
          (q - r) * (a * (q + r) - 2) := by
      ring
    have hrval : a * r ^ 2 - 2 * r + 1 < 0 := by
      norm_num [a, r]
    nlinarith
  · rw [div_lt_iff₀ hq2]
    let b : ℝ := 9674 / 10000
    let r : ℝ := 12207 / 10000
    have hrq : r < q := by simpa [r] using hqlo
    have hfac : 0 < b * (q + r) - 2 := by
      dsimp [b, r]
      nlinarith
    have hprod : 0 < (q - r) * (b * (q + r) - 2) :=
      mul_pos (sub_pos.mpr hrq) hfac
    have hid :
        (b * q ^ 2 - 2 * q + 1) -
            (b * r ^ 2 - 2 * r + 1) =
          (q - r) * (b * (q + r) - 2) := by
      ring
    have hrval : 0 < b * r ^ 2 - 2 * r + 1 := by
      norm_num [b, r]
    nlinarith

/-- Exact interval for the inverse quartic screening response. -/
theorem quarticNewtonResponse_bounds
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    (1033 : ℝ) / 1000 < q ^ 2 / (2 * q - 1) ∧
      q ^ 2 / (2 * q - 1) < (517 : ℝ) / 500 := by
  let s : ℝ := (2 * q - 1) / q ^ 2
  have hsbounds := quarticScreeningFactor_bounds q hq4 hq1
  have hslower : (9672 : ℝ) / 10000 < s := by
    simpa [s] using hsbounds.1
  have hsupper : s < (9674 : ℝ) / 10000 := by
    simpa [s] using hsbounds.2
  have hq0 : q ≠ 0 := by linarith
  have hden : 2 * q - 1 ≠ 0 := by linarith
  have hspos : 0 < s := by
    dsimp [s]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have heq : 1 / s = q ^ 2 / (2 * q - 1) := by
    dsimp [s]
    field_simp [hq0, hden]
  rw [← heq]
  constructor
  · rw [lt_div_iff₀ hspos]
    nlinarith [hsupper]
  · rw [div_lt_iff₀ hspos]
    nlinarith [hslower]

/-- If the physical Newton coupling is the inverse-screened response, its
ratio to the baseline lies between `1.033` and `1.034`. -/
theorem quarticNewtonCoupling_ratio_bounds
    (q G0 GQ : ℝ)
    (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) (hG0 : 0 < G0)
    (hG : GQ = G0 / ((2 * q - 1) / q ^ 2)) :
    ((1033 : ℝ) / 1000) * G0 < GQ ∧
      GQ < ((517 : ℝ) / 500) * G0 := by
  have hresponse := quarticNewtonResponse_bounds q hq4 hq1
  have hq0 : q ≠ 0 := by linarith
  have hden : 2 * q - 1 ≠ 0 := by linarith
  have heq : G0 / ((2 * q - 1) / q ^ 2) =
      (q ^ 2 / (2 * q - 1)) * G0 := by
    field_simp [hq0, hden]
  rw [hG, heq]
  exact ⟨mul_lt_mul_of_pos_right hresponse.1 hG0,
    mul_lt_mul_of_pos_right hresponse.2 hG0⟩


/-- The exterior-only standard-siren distance response lies strictly between
`1.016` and `1.017`. -/
theorem quarticStandardSirenResponse_bounds
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    (127 : ℝ) / 125 <
        1 / Real.sqrt ((2 * q - 1) / q ^ 2) ∧
      1 / Real.sqrt ((2 * q - 1) / q ^ 2) <
        (1017 : ℝ) / 1000 := by
  let s : ℝ := (2 * q - 1) / q ^ 2
  have hsbounds := quarticScreeningFactor_bounds q hq4 hq1
  have hslower : (9672 : ℝ) / 10000 < s := by
    simpa [s] using hsbounds.1
  have hsupper : s < (9674 : ℝ) / 10000 := by
    simpa [s] using hsbounds.2
  have hq0 : q ≠ 0 := by linarith
  have hspos : 0 < s := by
    dsimp [s]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hsqrtpos : 0 < Real.sqrt s := Real.sqrt_pos.2 hspos
  have hsqr : (Real.sqrt s) ^ 2 = s := Real.sq_sqrt hspos.le
  change
    (127 : ℝ) / 125 < 1 / Real.sqrt s ∧
      1 / Real.sqrt s < (1017 : ℝ) / 1000
  constructor
  · rw [lt_div_iff₀ hsqrtpos]
    let x : ℝ := ((127 : ℝ) / 125) * Real.sqrt s
    have hx0 : 0 ≤ x := by positivity
    have hxSq : x ^ 2 = ((127 : ℝ) / 125) ^ 2 * s := by
      dsimp [x]
      rw [mul_pow, hsqr]
    have hsqBound : ((127 : ℝ) / 125) ^ 2 * s < 1 := by
      nlinarith [hsupper]
    change x < 1
    by_contra h
    have hx1 : 1 ≤ x := le_of_not_gt h
    have hprod : 0 ≤ (x - 1) * (x + 1) :=
      mul_nonneg (sub_nonneg.mpr hx1) (by nlinarith)
    nlinarith
  · rw [div_lt_iff₀ hsqrtpos]
    let x : ℝ := ((1017 : ℝ) / 1000) * Real.sqrt s
    have hx0 : 0 ≤ x := by positivity
    have hxSq : x ^ 2 = ((1017 : ℝ) / 1000) ^ 2 * s := by
      dsimp [x]
      rw [mul_pow, hsqr]
    have hsqBound : 1 < ((1017 : ℝ) / 1000) ^ 2 * s := by
      nlinarith [hslower]
    change 1 < x
    by_contra h
    have hx1 : x ≤ 1 := le_of_not_gt h
    have hprod : 0 ≤ (1 - x) * (1 + x) :=
      mul_nonneg (sub_nonneg.mpr hx1) (by nlinarith)
    nlinarith

/-- Observable form of the quartic-root distance bound. Under the conditional
exterior-only placement, the inferred luminosity distance is between `1.6%`
and `1.7%` above the true distance. -/
theorem quarticExteriorOnly_standardSirenRatio_bounds
    (q chirpShape strainShape sourceScale luminosityDistance : ℝ)
    (hq4 : q ^ 4 = q + 1)
    (hq1 : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    (127 : ℝ) / 125 <
        inferredStandardSirenDistance chirpShape strainShape
            (leadingChirpRate chirpShape 1 sourceScale)
            (leadingMetricStrain strainShape
              (Real.sqrt (screening (lambda4 q))) sourceScale
              luminosityDistance) /
          luminosityDistance ∧
      inferredStandardSirenDistance chirpShape strainShape
            (leadingChirpRate chirpShape 1 sourceScale)
            (leadingMetricStrain strainShape
              (Real.sqrt (screening (lambda4 q))) sourceScale
              luminosityDistance) /
          luminosityDistance < (1017 : ℝ) / 1000 := by
  rw [quarticExteriorOnly_standardSirenRatio q chirpShape strainShape
    sourceScale luminosityDistance hq1 hchirpShape hstrainShape
    hsourceScale hdistance]
  exact quarticStandardSirenResponse_bounds q hq4 hq1


/-! ## Exact visible-hidden channel accounting -/

/-- The norm-preserving quartic dilation has two simultaneous and exact
bookkeeping statements: the complete visible-hidden TT code retains the full
input norm, while the exterior data port retains precisely the quartic
screening fraction. -/
theorem quarticTTHorizonCode_global_and_exterior_normSq
    (q : ℝ) (x : TTCoordinates) (hq : 1 < q) :
    bipartiteNormSq
          (quarticErasureDilation q (ttHorizonCodeEncoding x)) =
        ttShearNormSq (x 0) (x 1) ∧
      (∑ i, Complex.normSq
          (quarticErasureDilation q (ttHorizonCodeEncoding x)
            (some i, none))) =
        ((2 * q - 1) / q ^ 2) * ttShearNormSq (x 0) (x 1) := by
  constructor
  · calc
      bipartiteNormSq
            (quarticErasureDilation q (ttHorizonCodeEncoding x)) =
          finiteNormSq (ttHorizonCodeEncoding x) :=
        quarticErasureDilation_normSq q (ttHorizonCodeEncoding x) hq
      _ = ttShearNormSq (x 0) (x 1) :=
        ttHorizonCodeEncoding_normSq x
  · exact quarticErasureDilation_ttHorizonCode_exterior_normSq q x hq

/-- In the exterior-only branch, the square of the standard-siren distance
response is exactly the inverse screening response that multiplies Newton's
coupling. -/
theorem quarticStandardSirenResponse_sq_eq_newtonResponse
    (q : ℝ) (hq : 1 < q) :
    (1 / Real.sqrt ((2 * q - 1) / q ^ 2)) ^ 2 =
      q ^ 2 / (2 * q - 1) := by
  have hq0 : q ≠ 0 := by linarith
  have hden : 2 * q - 1 ≠ 0 := by linarith
  have hspos : 0 < (2 * q - 1) / q ^ 2 :=
    div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hsqrtSq :
      (Real.sqrt ((2 * q - 1) / q ^ 2)) ^ 2 =
        (2 * q - 1) / q ^ 2 :=
    Real.sq_sqrt hspos.le
  calc
    (1 / Real.sqrt ((2 * q - 1) / q ^ 2)) ^ 2 =
        1 / (Real.sqrt ((2 * q - 1) / q ^ 2)) ^ 2 := by ring
    _ = 1 / ((2 * q - 1) / q ^ 2) := by rw [hsqrtSq]
    _ = q ^ 2 / (2 * q - 1) := by field_simp [hq0, hden]


/-- Exact algebraic fingerprint of the conditional quartic standard-siren
response.  Eliminating the quartic root from
`R^2 = q^2/(2q-1)` and `q^4=q+1` forces a parameter-free degree-eight
equation for the observable ratio itself. -/
theorem quarticStandardSirenResponse_algebraicSignature
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let R := 1 / Real.sqrt ((2 * q - 1) / q ^ 2)
    23 * R ^ 8 - 22 * R ^ 6 + 2 * R ^ 4 - 3 * R ^ 2 - 1 = 0 := by
  dsimp only
  have hR2 := quarticStandardSirenResponse_sq_eq_newtonResponse q hq1
  let R : ℝ := 1 / Real.sqrt ((2 * q - 1) / q ^ 2)
  let r : ℝ := q ^ 2 / (2 * q - 1)
  have hR2' : R ^ 2 = r := by simpa [R, r] using hR2
  have hden : 2 * q - 1 ≠ 0 := by linarith
  have hden' : q * 2 - 1 ≠ 0 := by nlinarith
  have hroot : q ^ 4 - q - 1 = 0 := by nlinarith [hq4]
  have hr : r * (2 * q - 1) - q ^ 2 = 0 := by
    dsimp [r]
    field_simp [hden, hden']
    ring
  have hrpoly :
      23 * r ^ 4 - 22 * r ^ 3 + 2 * r ^ 2 - 3 * r - 1 = 0 := by
    linear_combination
      -((-8 * r ^ 3 + 4 * r ^ 2 + 1) * q +
          (16 * r ^ 4 - 12 * r ^ 3 + r ^ 2 - 2 * r - 1)) * hroot -
      ((-8 * r ^ 3 + 4 * r ^ 2 + 1) * q ^ 3 +
          (-4 * r ^ 3 + r ^ 2 - 1) * q ^ 2 +
          (-2 * r ^ 3 - 3 * r) * q +
          (7 * r ^ 3 - 10 * r ^ 2 + r - 1)) * hr
  change 23 * R ^ 8 - 22 * R ^ 6 + 2 * R ^ 4 - 3 * R ^ 2 - 1 = 0
  calc
    23 * R ^ 8 - 22 * R ^ 6 + 2 * R ^ 4 - 3 * R ^ 2 - 1 =
        23 * (R ^ 2) ^ 4 - 22 * (R ^ 2) ^ 3 +
          2 * (R ^ 2) ^ 2 - 3 * (R ^ 2) - 1 := by ring
    _ = 23 * r ^ 4 - 22 * r ^ 3 + 2 * r ^ 2 - 3 * r - 1 := by rw [hR2']
    _ = 0 := hrpoly


/-- Equivalent monic fingerprint for the exterior amplitude itself.  The
positive retained amplitude is an algebraic number satisfying a monic
degree-eight polynomial with integer coefficients. -/
theorem quarticExteriorAmplitude_algebraicSignature
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    A ^ 8 + 3 * A ^ 6 - 2 * A ^ 4 + 22 * A ^ 2 - 23 = 0 := by
  dsimp only
  let s : ℝ := (2 * q - 1) / q ^ 2
  let A : ℝ := Real.sqrt s
  have hq0 : q ≠ 0 := by linarith
  have hspos : 0 < s := by
    dsimp [s]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hA2 : A ^ 2 = s := by
    dsimp [A]
    exact Real.sq_sqrt hspos.le
  have hroot : q ^ 4 - q - 1 = 0 := by nlinarith [hq4]
  have hs : s * q ^ 2 - (2 * q - 1) = 0 := by
    dsimp [s]
    field_simp [hq0]
    ring
  have hspoly : s ^ 4 + 3 * s ^ 3 - 2 * s ^ 2 + 22 * s - 23 = 0 := by
    linear_combination
      ((s ^ 4 + 4 * s ^ 2 - 8 * s) * q +
          (-s ^ 4 - 2 * s ^ 3 + s ^ 2 - 12 * s + 16)) * hroot +
      ((-s ^ 3 - 4 * s + 8) * q ^ 3 +
          (s ^ 3 - s + 4) * q ^ 2 +
          (3 * s ^ 2 + 2) * q +
          (s ^ 3 - s ^ 2 + 10 * s - 7)) * hs
  change A ^ 8 + 3 * A ^ 6 - 2 * A ^ 4 + 22 * A ^ 2 - 23 = 0
  calc
    A ^ 8 + 3 * A ^ 6 - 2 * A ^ 4 + 22 * A ^ 2 - 23 =
        (A ^ 2) ^ 4 + 3 * (A ^ 2) ^ 3 - 2 * (A ^ 2) ^ 2 +
          22 * (A ^ 2) - 23 := by ring
    _ = s ^ 4 + 3 * s ^ 3 - 2 * s ^ 2 + 22 * s - 23 := by rw [hA2]
    _ = 0 := hspoly


/-- General two-polarization rigidity theorem for a conserved global source
and an exterior detector.  Start with an arbitrary retained weight `s` and an
arbitrary real two-by-two response `M`.  Polarization covariance,
self-adjointness, the quadratic weight equation, and the passive branch force
`M = sqrt(s) I`.  Exact visible-hidden conservation then removes the source
realization, while any nonzero response common to chirp and strain cancels.
The only possible leading standard-siren bias is therefore `1/sqrt(s)`.

The interpretation of the diagonal expectation as the radiated source flux is
a physical premise; the implication from the listed hypotheses is purely
mathematical. -/
theorem structuralTT_globalFlux_standardSirenDistance {n : ℕ}
    (M : Matrix (Fin 2) (Fin 2) ℝ)
    (s response : ℝ) (k : Fin n → ℝ) (psi : Fin n → ℂ)
    (chirpShape strainShape luminosityDistance : ℝ)
    (hs0 : 0 < s) (hs1 : s ≤ 1)
    (hcomm :
      M * ttPolarizationQuarterTurn = ttPolarizationQuarterTurn * M)
    (hself : M.transpose = M)
    (hweight :
      M.transpose * M = s • (1 : Matrix (Fin 2) (Fin 2) ℝ))
    (hpassive : 0 ≤ M 0 0)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hresponse : response ≠ 0)
    (hflux : finiteDiagonalExpectation k psi ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    M = (Real.sqrt s) • (1 : Matrix (Fin 2) (Fin 2) ℝ) ∧
      inferredStandardSirenDistance chirpShape strainShape
          (leadingChirpRate chirpShape response
            (exteriorDataExpectation k (erasureDilation s psi) +
              hiddenDataExpectation k (erasureDilation s psi)))
          (leadingMetricStrain strainShape (response * M 0 0)
            (finiteDiagonalExpectation k psi) luminosityDistance) =
        luminosityDistance / Real.sqrt s := by
  have hM := ttResponse_unique_of_symmetry_weight
    M s hs0.le hcomm hself hweight hpassive
  change M = (Real.sqrt s) • (1 : Matrix (Fin 2) (Fin 2) ℝ) at hM
  have hM00 : M 0 0 = Real.sqrt s := by
    rw [hM]
    simp
  have hsqrt : Real.sqrt s ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hs0)
  constructor
  · exact hM
  · rw [erasureDilation_total_expectation s k psi hs0.le hs1, hM00]
    rw [standardSirenDistance_eq_responseRatio chirpShape strainShape
      response (response * Real.sqrt s) (finiteDiagonalExpectation k psi)
      luminosityDistance hchirpShape hstrainShape
      (mul_ne_zero hresponse hsqrt) hflux hdistance]
    field_simp [hresponse, hsqrt]


/-- Structural standard-siren rigidity. An arbitrary passive self-adjoint TT
response that respects polarization rotations and has the quartic quadratic
weight is forced to the exterior square-root block. If chirp evolution counts
the complete visible-hidden flux, the inferred distance is consequently
forced into the quartic interval, independently of the particular response
matrix. -/
theorem quarticStructuralTT_standardSirenRatio_bounds {n : ℕ}
    (M : Matrix (Fin 2) (Fin 2) ℝ)
    (q : ℝ) (k : Fin n → ℝ) (psi : Fin n → ℂ)
    (chirpShape strainShape luminosityDistance : ℝ)
    (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q)
    (hcomm :
      M * ttPolarizationQuarterTurn = ttPolarizationQuarterTurn * M)
    (hself : M.transpose = M)
    (hweight :
      M.transpose * M =
        screening (lambda4 q) • (1 : Matrix (Fin 2) (Fin 2) ℝ))
    (hpassive : 0 ≤ M 0 0)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hflux : finiteDiagonalExpectation k psi ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    (127 : ℝ) / 125 <
        inferredStandardSirenDistance chirpShape strainShape
            (leadingChirpRate chirpShape
              (quarticQuadrupoleCommonResponse q)
              (exteriorDataExpectation k (quarticErasureDilation q psi) +
                hiddenDataExpectation k (quarticErasureDilation q psi)))
            (leadingMetricStrain strainShape
              (quarticQuadrupoleCommonResponse q * M 0 0)
              (finiteDiagonalExpectation k psi) luminosityDistance) /
          luminosityDistance ∧
      inferredStandardSirenDistance chirpShape strainShape
            (leadingChirpRate chirpShape
              (quarticQuadrupoleCommonResponse q)
              (exteriorDataExpectation k (quarticErasureDilation q psi) +
                hiddenDataExpectation k (quarticErasureDilation q psi)))
            (leadingMetricStrain strainShape
              (quarticQuadrupoleCommonResponse q * M 0 0)
              (finiteDiagonalExpectation k psi) luminosityDistance) /
          luminosityDistance < (1017 : ℝ) / 1000 := by
  have hM := quarticTTResponse_unique_of_symmetry_weight
    M q hq1 hcomm hself hweight hpassive
  have hM00 : M 0 0 = Real.sqrt (screening (lambda4 q)) := by
    rw [hM]
    simp [ttExteriorBlock]
  rw [quarticErasureDilation_total_expectation q k psi hq1, hM00]
  have heq := quarticQuadrupoleExterior_standardSirenDistance
    q chirpShape strainShape (finiteDiagonalExpectation k psi)
    luminosityDistance hq1 hchirpShape hstrainShape hflux hdistance
  rw [heq]
  have hratio :
      (luminosityDistance / Real.sqrt ((2 * q - 1) / q ^ 2)) /
          luminosityDistance =
        1 / Real.sqrt ((2 * q - 1) / q ^ 2) := by
    field_simp [hdistance]
  rw [hratio]
  exact quarticStandardSirenResponse_bounds q hq4 hq1


/-- A universal inverse-screening response changes both leading observables
by the same constant and therefore leaves the inferred distance unchanged. -/
theorem quarticUniversalResponse_cancels_from_standardSiren
    (q chirpShape strainShape sourceScale luminosityDistance : ℝ)
    (hq : 1 < q)
    (hchirpShape : chirpShape ≠ 0)
    (hstrainShape : strainShape ≠ 0)
    (hsourceScale : sourceScale ≠ 0)
    (hdistance : luminosityDistance ≠ 0) :
    inferredStandardSirenDistance chirpShape strainShape
        (leadingChirpRate chirpShape
          (1 / ((2 * q - 1) / q ^ 2)) sourceScale)
        (leadingMetricStrain strainShape
          (1 / ((2 * q - 1) / q ^ 2)) sourceScale
          luminosityDistance) = luminosityDistance := by
  have hq0 : q ≠ 0 := by linarith
  have hweight : (2 * q - 1) / q ^ 2 ≠ 0 := by
    exact ne_of_gt (div_pos (by linarith) (sq_pos_of_ne_zero hq0))
  have hresponse : 1 / ((2 * q - 1) / q ^ 2) ≠ 0 :=
    one_div_ne_zero hweight
  exact commonResponse_cancels_from_standardSiren
    chirpShape strainShape (1 / ((2 * q - 1) / q ^ 2))
    sourceScale luminosityDistance hchirpShape hstrainShape hresponse
    hsourceScale hdistance

/-! ## The same-physical-metric branch -/

/-- If inverse Newton screening compensates the quartic exterior attenuation,
then every detector readout depending only on the physical TT metric is
identical to its unscreened value. -/
theorem quarticInverseNewtonCompensation_sameDetectorReadout
    {Reading : Type}
    (detector : Matrix SpatialIndex SpatialIndex ℝ → Reading)
    (q kappa0 kappaQ G0 GQ : ℝ) (x : TTCoordinates)
    (hq : 1 < q) (hkappa0 : 0 ≤ kappa0) (hkappaQ : 0 ≤ kappaQ)
    (hkappa0_sq : kappa0 ^ 2 = 32 * Real.pi * G0)
    (hkappaQ_sq : kappaQ ^ 2 = 32 * Real.pi * GQ)
    (hmode : x 0 ≠ 0 ∨ x 1 ≠ 0)
    (hG : GQ = G0 / ((2 * q - 1) / q ^ 2)) :
    detector
        (physicalTTTensor kappaQ
          (ttHorizonCodeExteriorDecode (screening (lambda4 q)) x)) =
      detector (physicalTTTensor kappa0 x) := by
  apply congrArg detector
  exact
    (quarticTTHorizonCode_samePhysicalMetric_iff_newtonResponse
      q kappa0 kappaQ G0 GQ x hq hkappa0 hkappaQ
      hkappa0_sq hkappaQ_sq hmode).2 hG

#print axioms GravityScreening.nonzeroUniformWeight_preserves_vacuumModes
#print axioms GravityScreening.quarticLorentzCoefficient_preserves_vacuumEquations
#print axioms GravityScreening.quadrupoleCouplingScale_mul
#print axioms GravityScreening.quarticNewtonResponse_forces_quadrupoleCommonResponse
#print axioms GravityScreening.standardSirenDistance_eq_responseRatio
#print axioms GravityScreening.standardSiren_unbiased_iff_responses_equal
#print axioms GravityScreening.commonResponse_cancels_from_standardSiren
#print axioms GravityScreening.amplitudeOnlyRetention_biases_standardSiren
#print axioms GravityScreening.quarticExteriorOnly_standardSirenDistance
#print axioms GravityScreening.quarticExteriorOnly_standardSirenRatio
#print axioms GravityScreening.quarticQuadrupoleExterior_standardSirenDistance
#print axioms GravityScreening.quarticGlobalFluxExteriorReadout_standardSirenDistance
#print axioms GravityScreening.quarticRoot_lt_1221_perThousand
#print axioms GravityScreening.quarticRoot_gt_12207_perTenThousand
#print axioms GravityScreening.quarticScreeningFactor_bounds
#print axioms GravityScreening.quarticNewtonResponse_bounds
#print axioms GravityScreening.quarticNewtonCoupling_ratio_bounds
#print axioms GravityScreening.quarticStandardSirenResponse_bounds
#print axioms GravityScreening.quarticExteriorOnly_standardSirenRatio_bounds
#print axioms GravityScreening.quarticTTHorizonCode_global_and_exterior_normSq
#print axioms GravityScreening.quarticStandardSirenResponse_sq_eq_newtonResponse
#print axioms GravityScreening.quarticStandardSirenResponse_algebraicSignature
#print axioms GravityScreening.quarticExteriorAmplitude_algebraicSignature
#print axioms GravityScreening.structuralTT_globalFlux_standardSirenDistance
#print axioms GravityScreening.quarticStructuralTT_standardSirenRatio_bounds
#print axioms GravityScreening.quarticUniversalResponse_cancels_from_standardSiren
#print axioms GravityScreening.quarticInverseNewtonCompensation_sameDetectorReadout

end GravityScreening
