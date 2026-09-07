import GravityScreening.GravitationalWaveObservables

/-!
# Cosmological composition of the quartic response

This module separates a local, one-step exterior response from an accumulated
cosmological response.  The mathematical premise is explicit: a multiplicative
change of the scale factor by q counts as one response step, and successive
steps compose multiplicatively.

For redshift z, the step count is log(1+z)/log(q).  The response is the positive
quartic standard-siren factor raised to that count.  The construction is exactly
normalized at zero redshift, reproduces the finite quartic response when
1+z=q, and is a homomorphism for the physical composition law

  1 + (z combine w) = (1+z)(1+w).

The module proves the resulting Hubble-inference bias algebraically.  It does
not prove that cosmological expansion physically triggers one quartic response
per factor q; that is the new correspondence premise isolated by the result.
-/

namespace GravityScreening

/-- The positive one-step exterior standard-siren response. -/
noncomputable def quarticStepResponse (q : ℝ) : ℝ :=
  1 / Real.sqrt (screening (lambda4 q))

/-- Number of q-multiplicative scale-factor steps between redshift zero and z. -/
noncomputable def quarticScaleStepCount (q z : ℝ) : ℝ :=
  Real.log (1 + z) / Real.log q

/-- The redshift composition law induced by multiplication of scale factors. -/
def composeRedshift (z w : ℝ) : ℝ := z + w + z * w

/-- Accumulated quartic response after the logarithmic step count. -/
noncomputable def quarticCosmologicalResponse (q z : ℝ) : ℝ :=
  Real.rpow (quarticStepResponse q) (quarticScaleStepCount q z)

/-- The low-redshift Hubble value inferred after a distance response is applied. -/
noncomputable def inferredHubbleFromResponse (H0 response : ℝ) : ℝ :=
  H0 / response

/-- The effective-Newton ratio associated with a siren response in the class
of modified-gravity models where d_gw/d_em = sqrt(G_eff(z)/G_eff(0)). -/
noncomputable def effectiveNewtonRatioFromQuarticTransport (q z : ℝ) : ℝ :=
  quarticCosmologicalResponse q z ^ 2

/-- The power-law exponent selected by one quartic response per q-fold change
of cosmological scale. -/
noncomputable def quarticTransportExponent (q : ℝ) : ℝ :=
  Real.log (quarticStepResponse q) / Real.log q

/-- The constant propagation-friction correction corresponding to the
quartic power law in the standard modified-GW convention. -/
noncomputable def quarticPropagationFriction (q : ℝ) : ℝ :=
  -quarticTransportExponent q

/-- The constant Planck-mass running that produces the same power law in the
`alpha_M` convention used by standard-siren analyses. -/
noncomputable def quarticPlanckMassRun (q : ℝ) : ℝ :=
  2 * quarticTransportExponent q

theorem quarticStepResponse_pos (q : ℝ) (hq : 1 < q) :
    0 < quarticStepResponse q := by
  have hq0 : q ≠ 0 := by linarith
  have hs : 0 < screening (lambda4 q) := by
    rw [quartic_screening_identity q hq0]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  exact one_div_pos.mpr (Real.sqrt_pos.2 hs)

/-- The local response is the exact quartic factor used by the finite theorem. -/
theorem quarticStepResponse_eq (q : ℝ) (hq : 1 < q) :
    quarticStepResponse q = 1 / Real.sqrt ((2 * q - 1) / q ^ 2) := by
  have hq0 : q ≠ 0 := by linarith
  unfold quarticStepResponse
  rw [quartic_screening_identity q hq0]

/-- The quartic one-step response is strictly larger than one. -/
theorem one_lt_quarticStepResponse
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    1 < quarticStepResponse q := by
  rw [quarticStepResponse_eq q hq]
  have hbounds := quarticStandardSirenResponse_bounds q hq4 hq
  exact lt_trans (by norm_num : (1 : ℝ) < 127 / 125) hbounds.1

theorem one_add_composeRedshift (z w : ℝ) :
    1 + composeRedshift z w = (1 + z) * (1 + w) := by
  unfold composeRedshift
  ring

/-- A zero-length cosmological path contains no response step. -/
theorem quarticScaleStepCount_zero (q : ℝ) :
    quarticScaleStepCount q 0 = 0 := by
  simp [quarticScaleStepCount]

/-- A scale-factor ratio q contains exactly one q-step. -/
theorem quarticScaleStepCount_oneStep (q : ℝ) (hq : 1 < q) :
    quarticScaleStepCount q (q - 1) = 1 := by
  have hlog : Real.log q ≠ 0 := ne_of_gt (Real.log_pos hq)
  unfold quarticScaleStepCount
  rw [show 1 + (q - 1) = q by ring]
  exact div_self hlog

/-- Logarithmic step counts add under successive redshift intervals. -/
theorem quarticScaleStepCount_compose
    (q z w : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) (hw : 0 < 1 + w) :
    quarticScaleStepCount q (composeRedshift z w) =
      quarticScaleStepCount q z + quarticScaleStepCount q w := by
  have hlog : Real.log q ≠ 0 := ne_of_gt (Real.log_pos hq)
  unfold quarticScaleStepCount
  rw [one_add_composeRedshift, Real.log_mul hz.ne' hw.ne', add_div]

/-- Cosmological transport is exactly normalized to GR at zero path length. -/
theorem quarticCosmologicalResponse_zero (q : ℝ) :
    quarticCosmologicalResponse q 0 = 1 := by
  simp [quarticCosmologicalResponse, quarticScaleStepCount_zero]

/-- A constant use of the nontrivial local response cannot also obey the
zero-path normalization required of accumulated cosmological propagation. -/
theorem quarticStepResponse_ne_zeroPathValue
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    quarticStepResponse q ≠ quarticCosmologicalResponse q 0 := by
  rw [quarticCosmologicalResponse_zero]
  exact ne_of_gt (one_lt_quarticStepResponse q hq4 hq)

/-- After one q-scale step, transport reproduces the finite quartic response. -/
theorem quarticCosmologicalResponse_oneStep (q : ℝ) (hq : 1 < q) :
    quarticCosmologicalResponse q (q - 1) = quarticStepResponse q := by
  rw [quarticCosmologicalResponse, quarticScaleStepCount_oneStep q hq]
  exact Real.rpow_one (quarticStepResponse q)

/-- The response is multiplicative over successive cosmological intervals. -/
theorem quarticCosmologicalResponse_compose
    (q z w : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) (hw : 0 < 1 + w) :
    quarticCosmologicalResponse q (composeRedshift z w) =
      quarticCosmologicalResponse q z * quarticCosmologicalResponse q w := by
  unfold quarticCosmologicalResponse
  rw [quarticScaleStepCount_compose q z w hq hz hw]
  exact Real.rpow_add (quarticStepResponse_pos q hq)
    (quarticScaleStepCount q z) (quarticScaleStepCount q w)

/-- The scale-step construction is exactly a redshift power law. -/
theorem quarticCosmologicalResponse_eq_powerLaw
    (q z : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) :
    quarticCosmologicalResponse q z =
      Real.rpow (1 + z) (quarticTransportExponent q) := by
  have hstep : 0 < quarticStepResponse q := quarticStepResponse_pos q hq
  have hlog : Real.log q ≠ 0 := ne_of_gt (Real.log_pos hq)
  unfold quarticCosmologicalResponse quarticScaleStepCount
  unfold quarticTransportExponent
  change
    (quarticStepResponse q) ^ (Real.log (1 + z) / Real.log q) =
      (1 + z) ^ (Real.log (quarticStepResponse q) / Real.log q)
  rw [Real.rpow_def_of_pos hstep, Real.rpow_def_of_pos hz]
  congr 1
  field_simp [hlog]

/-- Rigidity of continuous multiplicative transport.  Every continuous,
strictly positive response on positive scale factors that composes under
multiplication is fixed everywhere by its value at one scale `q > 1`.

This is the functional-equation step that rules out alternative continuous
redshift curves once positivity, path composition, and the one-step response
are imposed. -/
theorem continuousPositiveMultiplicativeResponse_unique
    (F : ℝ → ℝ) (q R x : ℝ)
    (hF : Continuous F)
    (hpos : ∀ a : ℝ, 0 < a → 0 < F a)
    (hmul : ∀ a b : ℝ, 0 < a → 0 < b → F (a * b) = F a * F b)
    (hq : 1 < q) (hstep : F q = R) (hx : 0 < x) :
    F x = Real.rpow x (Real.log R / Real.log q) := by
  have hF1pos : 0 < F 1 := hpos 1 zero_lt_one
  have hF1mul := hmul 1 1 zero_lt_one zero_lt_one
  norm_num at hF1mul
  have hF1 : F 1 = 1 := by
    nlinarith
  let g : ℝ →+ ℝ :=
    { toFun := fun t => Real.log (F (Real.exp t))
      map_zero' := by simp [hF1]
      map_add' := by
        intro a b
        rw [Real.exp_add,
          hmul (Real.exp a) (Real.exp b) (Real.exp_pos a) (Real.exp_pos b),
          Real.log_mul
            (ne_of_gt (hpos (Real.exp a) (Real.exp_pos a)))
            (ne_of_gt (hpos (Real.exp b) (Real.exp_pos b)))] }
  have hg : Continuous g := by
    change Continuous (fun t : ℝ => Real.log (F (Real.exp t)))
    exact (hF.comp Real.continuous_exp).log
      (fun t => ne_of_gt (hpos (Real.exp t) (Real.exp_pos t)))
  have hg_formula (t : ℝ) : g t = t * g 1 := by
    simpa [smul_eq_mul] using map_real_smul g hg t (1 : ℝ)
  have hqpos : 0 < q := by linarith
  have hgq : g (Real.log q) = Real.log R := by
    simp [g, Real.exp_log hqpos, hstep]
  have hlogq : Real.log q ≠ 0 := ne_of_gt (Real.log_pos hq)
  have hg1 : g 1 = Real.log R / Real.log q := by
    have h := hg_formula (Real.log q)
    rw [hgq] at h
    apply (eq_div_iff hlogq).2
    nlinarith
  calc
    F x = Real.exp (Real.log (F x)) :=
      (Real.exp_log (hpos x hx)).symm
    _ = Real.exp (g (Real.log x)) := by
      congr 1
      simp [g, Real.exp_log hx]
    _ = Real.exp
        (Real.log x * (Real.log R / Real.log q)) := by
      rw [hg_formula, hg1]
    _ = Real.rpow x (Real.log R / Real.log q) := by
      exact (Real.rpow_def_of_pos hx (Real.log R / Real.log q)).symm

/-- Applying multiplicative-response rigidity to the quartic one-step value:
the scale-step power law is the unique continuous positive response compatible
with path composition and `F(q) = quarticStepResponse q`. -/
theorem continuousQuarticScaleResponse_unique
    (F : ℝ → ℝ) (q z : ℝ)
    (hF : Continuous F)
    (hpos : ∀ a : ℝ, 0 < a → 0 < F a)
    (hmul : ∀ a b : ℝ, 0 < a → 0 < b → F (a * b) = F a * F b)
    (hq : 1 < q) (hstep : F q = quarticStepResponse q)
    (hz : 0 < 1 + z) :
    F (1 + z) = quarticCosmologicalResponse q z := by
  rw [continuousPositiveMultiplicativeResponse_unique F q
    (quarticStepResponse q) (1 + z) hF hpos hmul hq hstep hz]
  rw [quarticCosmologicalResponse_eq_powerLaw q z hq hz]
  rfl

/-- At a quartic root, the transport exponent is strictly positive. -/
theorem quarticTransportExponent_pos
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    0 < quarticTransportExponent q := by
  unfold quarticTransportExponent
  exact div_pos
    (Real.log_pos (one_lt_quarticStepResponse q hq4 hq))
    (Real.log_pos hq)

/-- The corresponding propagation-friction correction has a fixed negative
sign in the standard convention. -/
theorem quarticPropagationFriction_neg
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    quarticPropagationFriction q < 0 := by
  unfold quarticPropagationFriction
  exact neg_lt_zero.mpr (quarticTransportExponent_pos q hq4 hq)

/-- The same response written in the conventional constant-friction form. -/
theorem quarticCosmologicalResponse_eq_frictionLaw
    (q z : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) :
    quarticCosmologicalResponse q z =
      Real.rpow (1 + z) (-quarticPropagationFriction q) := by
  rw [quarticCosmologicalResponse_eq_powerLaw q z hq hz]
  simp [quarticPropagationFriction]

/-- The two common modified-propagation conventions agree exactly:
`delta = -alpha_M / 2`. -/
theorem quarticPropagationFriction_eq_planckMassRun
    (q : ℝ) :
    quarticPropagationFriction q = -quarticPlanckMassRun q / 2 := by
  unfold quarticPropagationFriction quarticPlanckMassRun
  ring

/-- The quartic Planck-mass running has a fixed positive sign. -/
theorem quarticPlanckMassRun_pos
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    0 < quarticPlanckMassRun q := by
  exact mul_pos (by norm_num) (quarticTransportExponent_pos q hq4 hq)

/-- Every positive redshift produces a distance response strictly above one. -/
theorem one_lt_quarticCosmologicalResponse
    (q z : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) (hz : 0 < z) :
    1 < quarticCosmologicalResponse q z := by
  rw [quarticCosmologicalResponse_eq_powerLaw q z hq (by linarith)]
  exact Real.one_lt_rpow (by linarith)
    (quarticTransportExponent_pos q hq4 hq)

/-- At zero path length, the inferred Hubble value is unchanged. -/
theorem inferredHubbleFromQuarticResponse_zero (q H0 : ℝ) :
    inferredHubbleFromResponse H0 (quarticCosmologicalResponse q 0) = H0 := by
  rw [quarticCosmologicalResponse_zero]
  simp [inferredHubbleFromResponse]

/-- The effective Newton ratio is exactly one at zero path length. -/
theorem effectiveNewtonRatioFromQuarticTransport_zero (q : ℝ) :
    effectiveNewtonRatioFromQuarticTransport q 0 = 1 := by
  rw [effectiveNewtonRatioFromQuarticTransport,
    quarticCosmologicalResponse_zero]
  norm_num

/-- At one q-scale step, the cosmological effective-Newton ratio is exactly
the inverse quartic screening factor already obtained from the local gravity
response. -/
theorem effectiveNewtonRatioFromQuarticTransport_oneStep
    (q : ℝ) (hq : 1 < q) :
    effectiveNewtonRatioFromQuarticTransport q (q - 1) =
      q ^ 2 / (2 * q - 1) := by
  rw [effectiveNewtonRatioFromQuarticTransport,
    quarticCosmologicalResponse_oneStep q hq,
    quarticStepResponse_eq q hq]
  exact quarticStandardSirenResponse_sq_eq_newtonResponse q hq

/-- Effective-Newton ratios multiply over successive cosmological intervals. -/
theorem effectiveNewtonRatioFromQuarticTransport_compose
    (q z w : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) (hw : 0 < 1 + w) :
    effectiveNewtonRatioFromQuarticTransport q (composeRedshift z w) =
      effectiveNewtonRatioFromQuarticTransport q z *
        effectiveNewtonRatioFromQuarticTransport q w := by
  rw [effectiveNewtonRatioFromQuarticTransport,
    quarticCosmologicalResponse_compose q z w hq hz hw]
  unfold effectiveNewtonRatioFromQuarticTransport
  ring

/-- In the effective-Newton class, the quartic transport law fixes the full
coupling evolution to twice the distance-response exponent. -/
theorem effectiveNewtonRatioFromQuarticTransport_eq_powerLaw
    (q z : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) :
    effectiveNewtonRatioFromQuarticTransport q z =
      Real.rpow (1 + z) (2 * quarticTransportExponent q) := by
  rw [effectiveNewtonRatioFromQuarticTransport,
    quarticCosmologicalResponse_eq_powerLaw q z hq hz]
  calc
    (Real.rpow (1 + z) (quarticTransportExponent q)) ^ 2 =
        Real.rpow (1 + z) (quarticTransportExponent q * 2) := by
          change
            ((1 + z) ^ (quarticTransportExponent q)) ^ (2 : ℕ) =
              (1 + z) ^ (quarticTransportExponent q * (2 : ℝ))
          exact (Real.rpow_mul_natCast hz.le
            (quarticTransportExponent q) 2).symm
    _ = Real.rpow (1 + z) (2 * quarticTransportExponent q) := by
          ring_nf

/-- The distance and effective-Newton curves in the constant `alpha_M`
convention used by modified-GW propagation analyses.  The distance exponent
is `alpha_M / 2`, and squaring the response gives exponent `alpha_M`. -/
theorem quarticTransport_eq_planckMassRunLaws
    (q z : ℝ) (hq : 1 < q) (hz : 0 < 1 + z) :
    quarticCosmologicalResponse q z =
        Real.rpow (1 + z) (quarticPlanckMassRun q / 2) ∧
      effectiveNewtonRatioFromQuarticTransport q z =
        Real.rpow (1 + z) (quarticPlanckMassRun q) := by
  constructor
  · rw [quarticCosmologicalResponse_eq_powerLaw q z hq hz]
    unfold quarticPlanckMassRun
    congr 1
    ring
  · rw [effectiveNewtonRatioFromQuarticTransport_eq_powerLaw q z hq hz]
    rfl

/-- In the effective-Newton class, the coupling inferred at any positive
source redshift is strictly larger than its observer value. -/
theorem one_lt_effectiveNewtonRatioFromQuarticTransport
    (q z : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) (hz : 0 < z) :
    1 < effectiveNewtonRatioFromQuarticTransport q z := by
  rw [effectiveNewtonRatioFromQuarticTransport_eq_powerLaw q z hq (by linarith)]
  exact Real.one_lt_rpow (by linarith)
    (quarticPlanckMassRun_pos q hq4 hq)

/-- After one q-step, the distance excess lowers the naive Hubble inference by
the reciprocal response, namely the retained exterior amplitude. -/
theorem inferredHubbleFromQuarticResponse_oneStep
    (q H0 : ℝ) (hq : 1 < q) :
    inferredHubbleFromResponse H0
        (quarticCosmologicalResponse q (q - 1)) =
      H0 * Real.sqrt (screening (lambda4 q)) := by
  have hq0 : q ≠ 0 := by linarith
  have hs : 0 < screening (lambda4 q) := by
    rw [quartic_screening_identity q hq0]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hsqrt : Real.sqrt (screening (lambda4 q)) ≠ 0 :=
    ne_of_gt (Real.sqrt_pos.2 hs)
  rw [quarticCosmologicalResponse_oneStep q hq]
  unfold inferredHubbleFromResponse quarticStepResponse
  field_simp [hsqrt]

/-- Structural-to-cosmological capstone.  An arbitrary passive real TT block
with the quartic quadratic weight is first classified as the scalar exterior
block.  Exact visible-hidden source conservation then fixes the one-step
standard-siren distance, and the multiplicative scale-step premise extends
that same response to a parameter-free redshift power law.  In the
effective-Newton class, its square reproduces the local inverse-screening
factor after exactly one q-step.

The matrix classification, conservation reduction, composition law, signs,
and one-step meeting are mathematical consequences of the displayed
hypotheses.  Identifying a q-fold scale-factor change with one physical
propagation step remains the explicit correspondence premise encoded by
`quarticCosmologicalResponse`. -/
theorem quarticStructuralTT_cosmologicalTransport_capstone {n : ℕ}
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
    M = (Real.sqrt (screening (lambda4 q))) •
          (1 : Matrix (Fin 2) (Fin 2) ℝ) ∧
      inferredStandardSirenDistance chirpShape strainShape
          (leadingChirpRate chirpShape
            (quarticQuadrupoleCommonResponse q)
            (exteriorDataExpectation k (quarticErasureDilation q psi) +
              hiddenDataExpectation k (quarticErasureDilation q psi)))
          (leadingMetricStrain strainShape
            (quarticQuadrupoleCommonResponse q * M 0 0)
            (finiteDiagonalExpectation k psi) luminosityDistance) =
        luminosityDistance * quarticCosmologicalResponse q (q - 1) ∧
      (∀ z : ℝ, 0 < 1 + z →
        quarticCosmologicalResponse q z =
            Real.rpow (1 + z) (quarticPlanckMassRun q / 2) ∧
          effectiveNewtonRatioFromQuarticTransport q z =
            Real.rpow (1 + z) (quarticPlanckMassRun q)) ∧
      quarticPropagationFriction q < 0 ∧
      0 < quarticPlanckMassRun q ∧
      effectiveNewtonRatioFromQuarticTransport q (q - 1) =
        q ^ 2 / (2 * q - 1) := by
  have hq0 : q ≠ 0 := by linarith
  have hs0 : 0 < screening (lambda4 q) := by
    rw [quartic_screening_identity q hq0]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hratioPos : 0 < q ^ 2 / (2 * q - 1) :=
    div_pos (sq_pos_of_ne_zero hq0) (by linarith)
  have hcommon : quarticQuadrupoleCommonResponse q ≠ 0 :=
    ne_of_gt (Real.rpow_pos_of_pos hratioPos _)
  have hlocal := structuralTT_globalFlux_standardSirenDistance
    M (screening (lambda4 q)) (quarticQuadrupoleCommonResponse q)
    k psi chirpShape strainShape luminosityDistance hs0
    (quarticScreening_bounds q hq1).2 hcomm hself hweight hpassive
    hchirpShape hstrainShape hcommon hflux hdistance
  constructor
  · exact hlocal.1
  constructor
  · rw [quarticCosmologicalResponse_oneStep q hq1]
    unfold quarticStepResponse
    change
      inferredStandardSirenDistance chirpShape strainShape
          (leadingChirpRate chirpShape
            (quarticQuadrupoleCommonResponse q)
            (exteriorDataExpectation k
                (erasureDilation (screening (lambda4 q)) psi) +
              hiddenDataExpectation k
                (erasureDilation (screening (lambda4 q)) psi)))
          (leadingMetricStrain strainShape
            (quarticQuadrupoleCommonResponse q * M 0 0)
            (finiteDiagonalExpectation k psi) luminosityDistance) =
        luminosityDistance *
          (1 / Real.sqrt (screening (lambda4 q)))
    rw [hlocal.2]
    ring
  constructor
  · intro z hz
    exact quarticTransport_eq_planckMassRunLaws q z hq1 hz
  constructor
  · exact quarticPropagationFriction_neg q hq4 hq1
  constructor
  · exact quarticPlanckMassRun_pos q hq4 hq1
  · exact effectiveNewtonRatioFromQuarticTransport_oneStep q hq1

/-- The exact algebraic reduction behind the near-one-twelfth transport
exponent.  Equality with a one-twelfth exponent would force the right-hand
cubic expression to vanish; this module does not claim that it does. -/
theorem quarticOneTwelfth_defect_reduction
    (q : ℝ) (hq : q ^ 4 = q + 1) :
    (2 * q - 1) ^ 6 - q ^ 11 =
      -97 * q ^ 3 - 69 * q ^ 2 + 33 * q + 239 := by
  linear_combination
    (-q ^ 7 - q ^ 4 - q ^ 3 + 64 * q ^ 2 - 193 * q + 238) * hq

#print axioms GravityScreening.quarticStepResponse_eq
#print axioms GravityScreening.one_lt_quarticStepResponse
#print axioms GravityScreening.quarticStepResponse_ne_zeroPathValue
#print axioms GravityScreening.quarticScaleStepCount_compose
#print axioms GravityScreening.quarticCosmologicalResponse_zero
#print axioms GravityScreening.quarticCosmologicalResponse_oneStep
#print axioms GravityScreening.quarticCosmologicalResponse_compose
#print axioms GravityScreening.quarticCosmologicalResponse_eq_powerLaw
#print axioms GravityScreening.continuousPositiveMultiplicativeResponse_unique
#print axioms GravityScreening.continuousQuarticScaleResponse_unique
#print axioms GravityScreening.quarticTransportExponent_pos
#print axioms GravityScreening.quarticPropagationFriction_neg
#print axioms GravityScreening.quarticCosmologicalResponse_eq_frictionLaw
#print axioms GravityScreening.quarticPropagationFriction_eq_planckMassRun
#print axioms GravityScreening.quarticPlanckMassRun_pos
#print axioms GravityScreening.one_lt_quarticCosmologicalResponse
#print axioms GravityScreening.inferredHubbleFromQuarticResponse_zero
#print axioms GravityScreening.inferredHubbleFromQuarticResponse_oneStep
#print axioms GravityScreening.effectiveNewtonRatioFromQuarticTransport_zero
#print axioms GravityScreening.effectiveNewtonRatioFromQuarticTransport_oneStep
#print axioms GravityScreening.effectiveNewtonRatioFromQuarticTransport_compose
#print axioms GravityScreening.effectiveNewtonRatioFromQuarticTransport_eq_powerLaw
#print axioms GravityScreening.quarticTransport_eq_planckMassRunLaws
#print axioms GravityScreening.one_lt_effectiveNewtonRatioFromQuarticTransport
#print axioms GravityScreening.quarticStructuralTT_cosmologicalTransport_capstone
#print axioms GravityScreening.quarticOneTwelfth_defect_reduction

end GravityScreening
