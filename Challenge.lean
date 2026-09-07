import Mathlib

/-!
# From quartic TT rigidity to a unique cosmological response

This challenge classifies the leading standard-siren response of an arbitrary
real two-by-two transverse-traceless polarization block. Rotation covariance,
self-adjointness, a prescribed quadratic weight, and the passive branch remove
all matrix freedom. Exact visible-hidden conservation then removes the source
realization, and a common nonzero source response cancels. The distance bias is
therefore forced to be `1 / sqrt(s)`.

For the positive real solution of `q^4 = q + 1`, PDT supplies
`s = 1 - (1 - 1/q)^2 = (2q-1)/q^2`. This yields a parameter-free interval
`1.016 < d_inferred/d_true < 1.017` and exact degree-eight polynomial
identities for both the exterior amplitude and the distance response.

The cosmological extension assumes a response is continuous, strictly
positive, and multiplicative under successive scale-factor changes. Its value
after one factor-q change is the finite quartic response. A functional-equation
rigidity theorem then proves that the entire redshift curve is uniquely the
corresponding power law. The capstone joins that uniqueness result to the
arbitrary-matrix classification and its effective-Newton square.

The theorem is conditional on the explicitly stated observer placement: the
chirp counts complete visible-plus-hidden flux while strain reads the exterior
TT block. A companion theorem proves that a response common to chirp and
strain instead cancels exactly.
-/

namespace StandardSirenRigidity

noncomputable section

open scoped BigOperators IntermediateField

/-- Quartic-sector self-coupling. -/
def lambda4 (q : ℝ) : ℝ := 1 - 1 / q

/-- Retained quadratic response. -/
def screening (l : ℝ) : ℝ := 1 - l ^ 2

/-- Quarter-turn on the plus/cross polarization plane. -/
def ttPolarizationQuarterTurn : Matrix (Fin 2) (Fin 2) ℝ :=
  !![0, -1;
     1,  0]

/-- Norm-preserving visible-hidden dilation at weight `s`. -/
noncomputable def erasureDilation {n : ℕ} (s : ℝ) (psi : Fin n → ℂ) :
    Option (Fin n) × Option (Fin n) → ℂ
  | (some i, none) => (Real.sqrt s : ℂ) * psi i
  | (none, some i) => (Real.sqrt (1 - s) : ℂ) * psi i
  | _ => 0

/-- Quartic specialization of the visible-hidden dilation. -/
noncomputable def quarticErasureDilation {n : ℕ}
    (q : ℝ) (psi : Fin n → ℂ) :
    Option (Fin n) × Option (Fin n) → ℂ :=
  erasureDilation (screening (lambda4 q)) psi

/-- Expectation of a real diagonal observable in a finite pure state. -/
noncomputable def finiteDiagonalExpectation {n : ℕ}
    (k : Fin n → ℝ) (psi : Fin n → ℂ) : ℝ :=
  ∑ i, k i * Complex.normSq (psi i)

/-- Exterior contribution to the diagonal expectation. -/
noncomputable def exteriorDataExpectation {n : ℕ}
    (k : Fin n → ℝ)
    (Psi : Option (Fin n) × Option (Fin n) → ℂ) : ℝ :=
  ∑ i, k i * Complex.normSq (Psi (some i, none))

/-- Hidden contribution to the diagonal expectation. -/
noncomputable def hiddenDataExpectation {n : ℕ}
    (k : Fin n → ℝ)
    (Psi : Option (Fin n) × Option (Fin n) → ℂ) : ℝ :=
  ∑ i, k i * Complex.normSq (Psi (none, some i))

/-- Leading chirp rate with shape, response, and source scale separated. -/
def leadingChirpRate
    (chirpShape response sourceScale : ℝ) : ℝ :=
  chirpShape * response * sourceScale

/-- Leading strain amplitude with inverse-distance scaling separated. -/
noncomputable def leadingMetricStrain
    (strainShape response sourceScale luminosityDistance : ℝ) : ℝ :=
  strainShape * response * sourceScale / luminosityDistance

/-- Common leading quadrupole response induced by inverse quartic screening. -/
noncomputable def quarticQuadrupoleCommonResponse (q : ℝ) : ℝ :=
  Real.rpow (q ^ 2 / (2 * q - 1)) ((5 : ℝ) / 3)

/-- Algebraic standard-siren distance estimator. -/
noncomputable def inferredStandardSirenDistance
    (chirpShape strainShape chirpRate strain : ℝ) : ℝ :=
  strainShape * chirpRate / (chirpShape * strain)

/-- Positive one-step quartic distance response. -/
noncomputable def quarticStepResponse (q : ℝ) : ℝ :=
  1 / Real.sqrt (screening (lambda4 q))

/-- Number of q-multiplicative scale steps to redshift z. -/
noncomputable def quarticScaleStepCount (q z : ℝ) : ℝ :=
  Real.log (1 + z) / Real.log q

/-- Accumulated response under multiplicative q-scale composition. -/
noncomputable def quarticCosmologicalResponse (q z : ℝ) : ℝ :=
  Real.rpow (quarticStepResponse q) (quarticScaleStepCount q z)

/-- Effective-Newton ratio in the modified-propagation class. -/
noncomputable def effectiveNewtonRatioFromQuarticTransport (q z : ℝ) : ℝ :=
  quarticCosmologicalResponse q z ^ 2

/-- Redshift power-law exponent fixed by the quartic step. -/
noncomputable def quarticTransportExponent (q : ℝ) : ℝ :=
  Real.log (quarticStepResponse q) / Real.log q

/-- Constant propagation-friction correction. -/
noncomputable def quarticPropagationFriction (q : ℝ) : ℝ :=
  -quarticTransportExponent q

/-- Constant Planck-mass running in the standard alpha_M convention. -/
noncomputable def quarticPlanckMassRun (q : ℝ) : ℝ :=
  2 * quarticTransportExponent q

/-- Positivity, continuity, path composition, and the quartic one-step value
uniquely force the full redshift response. -/
theorem continuousQuarticScaleResponse_unique
    (F : ℝ → ℝ) (q z : ℝ)
    (hF : Continuous F)
    (hpos : ∀ a : ℝ, 0 < a → 0 < F a)
    (hmul : ∀ a b : ℝ, 0 < a → 0 < b → F (a * b) = F a * F b)
    (hq : 1 < q) (hstep : F q = quarticStepResponse q)
    (hz : 0 < 1 + z) :
    F (1 + z) = quarticCosmologicalResponse q z := by
  sorry

/-- General rigidity theorem: the complete hypotheses force both the advertised
matrix classification and the unique leading distance response. -/
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
  sorry

/-- Structural-to-cosmological capstone: the arbitrary TT block is classified,
the finite conserved-source response equals one quartic propagation step, the
full redshift law is fixed, and its effective-Newton square meets the inverse
local screening response. -/
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
  sorry

/-- The quartic root fixes the structurally forced distance response to a
rigorous interval between `1.016` and `1.017`. -/
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
  sorry

/-- Exact algebraic fingerprint of the quartic distance response. -/
theorem quarticStandardSirenResponse_algebraicSignature
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let R := 1 / Real.sqrt ((2 * q - 1) / q ^ 2)
    23 * R ^ 8 - 22 * R ^ 6 + 2 * R ^ 4 - 3 * R ^ 2 - 1 = 0 := by
  sorry

/-- Monic algebraic fingerprint of the quartic exterior amplitude. -/
theorem quarticExteriorAmplitude_algebraicSignature
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    A ^ 8 + 3 * A ^ 6 - 2 * A ^ 4 + 22 * A ^ 2 - 23 = 0 := by
  sorry


/-- The quartic exterior amplitude has minimal-polynomial degree exactly eight,
so its displayed degree-eight equation does not collapse to lower degree. -/
theorem quarticExteriorAmplitude_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    (minpoly ℚ A).natDegree = 8 := by
  sorry

/-- The field generated by the exterior amplitude is exactly quadratic over
the quartic field generated by `q`. -/
theorem quarticExteriorAmplitude_relativeDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    (ℚ⟮q⟯ : IntermediateField ℚ ℝ).relfinrank ℚ⟮A⟯ = 2 := by
  sorry

/-- The reciprocal standard-siren distance response also has
minimal-polynomial degree exactly eight. -/
theorem quarticStandardSirenResponse_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let R := 1 / Real.sqrt ((2 * q - 1) / q ^ 2)
    (minpoly ℚ R).natDegree = 8 := by
  sorry

/-- A response common to chirp and strain cancels exactly. -/
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
  sorry

end

end StandardSirenRigidity
