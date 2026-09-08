import GravityScreening.NullHorizonSpinTwoMode

/-!
# Quartic dilation of the complete intrinsic null canonical potential

The intrinsic gravitational symplectic potential on a null hypersurface has
spin-two, spin-one, and spin-zero canonical blocks.  For a Fourier-paired
mode, package their two, two, and one components into a five-component
complex amplitude.  The signs and geometric densities belong to the
canonical momentum entries: `(epsilon sigma / 2, -epsilon omega, epsilon)`;
the configuration variations are `(delta gamma, delta L, delta mu)`.

This file proves that the finite Q erasure dilation preserves the complete
potential globally and weights every exterior block by the single coefficient
`S_Q`, with complementary hidden weight `lambda4^2`.
-/

namespace GravityScreening

/-- The five canonical components of one intrinsic null-boundary mode: two
spin-two, two spin-one, and one spin-zero component. -/
abbrev NullBoundaryCanonicalData := Fin 5 → ℂ

/-- Pack the three spin sectors in the order spin two, spin one, spin zero.
The supplied momenta already include the geometric signs and density factors
of the intrinsic null symplectic potential. -/
noncomputable def packNullBoundaryCanonicalData
    (spinTwo spinOne : Fin 2 → ℂ) (spinZero : ℂ) :
    NullBoundaryCanonicalData :=
  ![spinTwo 0, spinTwo 1, spinOne 0, spinOne 1, spinZero]

/-- Fourier-paired intrinsic null canonical potential. -/
noncomputable def nullBoundaryCanonicalPotential
    (momentum configurationVariation : NullBoundaryCanonicalData) : ℝ :=
  (finiteHermitianPairing momentum configurationVariation).re

/-- The packed potential is the sum of its spin-two, spin-one, and spin-zero
blocks. -/
theorem nullBoundaryCanonicalPotential_pack
    (spinTwoMomentum spinTwoVariation spinOneMomentum spinOneVariation :
      Fin 2 → ℂ)
    (spinZeroMomentum spinZeroVariation : ℂ) :
    nullBoundaryCanonicalPotential
        (packNullBoundaryCanonicalData
          spinTwoMomentum spinOneMomentum spinZeroMomentum)
        (packNullBoundaryCanonicalData
          spinTwoVariation spinOneVariation spinZeroVariation) =
      (finiteHermitianPairing spinTwoMomentum spinTwoVariation +
        finiteHermitianPairing spinOneMomentum spinOneVariation +
        star spinZeroMomentum * spinZeroVariation).re := by
  simp [nullBoundaryCanonicalPotential, packNullBoundaryCanonicalData,
    finiteHermitianPairing, Fin.sum_univ_succ]
  ring

/-- Complete visible-plus-hidden null canonical potential after dilation. -/
noncomputable def dilatedNullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData) : ℝ :=
  (bipartiteHermitianPairing
    (erasureDilation s momentum)
    (erasureDilation s configurationVariation)).re

/-- Exterior contribution to the dilated null canonical potential. -/
noncomputable def exteriorNullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData) : ℝ :=
  (exteriorDataHermitianPairing
    (erasureDilation s momentum)
    (erasureDilation s configurationVariation)).re

/-- Hidden contribution to the dilated null canonical potential. -/
noncomputable def hiddenNullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData) : ℝ :=
  (hiddenDataHermitianPairing
    (erasureDilation s momentum)
    (erasureDilation s configurationVariation)).re

/-- The complete Q-channel dilation preserves the full intrinsic null
canonical potential, including all three spin blocks. -/
theorem erasureDilation_preserves_nullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData)
    (hs0 : 0 ≤ s) (hs1 : s ≤ 1) :
    dilatedNullBoundaryCanonicalPotential s momentum configurationVariation =
      nullBoundaryCanonicalPotential momentum configurationVariation := by
  unfold dilatedNullBoundaryCanonicalPotential
    nullBoundaryCanonicalPotential
  rw [erasureDilation_preserves_hermitian
    s momentum configurationVariation hs0 hs1]

/-- Every exterior null canonical block carries the same weight `s`. -/
theorem erasureDilation_exterior_nullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData)
    (hs0 : 0 ≤ s) :
    exteriorNullBoundaryCanonicalPotential s momentum configurationVariation =
      s * nullBoundaryCanonicalPotential momentum configurationVariation := by
  unfold exteriorNullBoundaryCanonicalPotential
    nullBoundaryCanonicalPotential
  rw [erasureDilation_exterior_hermitian
    s momentum configurationVariation hs0]
  simp [Complex.mul_re]

/-- Every hidden null canonical block carries the complementary weight
`1-s`. -/
theorem erasureDilation_hidden_nullBoundaryCanonicalPotential
    (s : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData)
    (hs1 : s ≤ 1) :
    hiddenNullBoundaryCanonicalPotential s momentum configurationVariation =
      (1 - s) *
        nullBoundaryCanonicalPotential momentum configurationVariation := by
  unfold hiddenNullBoundaryCanonicalPotential
    nullBoundaryCanonicalPotential
  rw [erasureDilation_hidden_hermitian
    s momentum configurationVariation hs1]
  simp [Complex.mul_re]

/-- Quartic null-boundary capstone: the complete intrinsic potential is
preserved globally, while all exterior and hidden spin sectors carry the
single complementary pair `S_Q` and `lambda4^2`. -/
theorem quarticNullBoundaryCanonicalPotential_global_exterior_hidden
    (q : ℝ)
    (momentum configurationVariation : NullBoundaryCanonicalData)
    (hq : 1 < q) :
    (dilatedNullBoundaryCanonicalPotential
          (screening (lambda4 q)) momentum configurationVariation =
        nullBoundaryCanonicalPotential momentum configurationVariation) ∧
    (exteriorNullBoundaryCanonicalPotential
          (screening (lambda4 q)) momentum configurationVariation =
        ((2 * q - 1) / q ^ 2) *
          nullBoundaryCanonicalPotential momentum configurationVariation) ∧
    (hiddenNullBoundaryCanonicalPotential
          (screening (lambda4 q)) momentum configurationVariation =
        lambda4 q ^ 2 *
          nullBoundaryCanonicalPotential momentum configurationVariation) := by
  have hq0 : q ≠ 0 := by linarith
  have hglobal := erasureDilation_preserves_nullBoundaryCanonicalPotential
    (screening (lambda4 q)) momentum configurationVariation
    (quarticScreening_bounds q hq).1 (quarticScreening_bounds q hq).2
  have hexterior := erasureDilation_exterior_nullBoundaryCanonicalPotential
    (screening (lambda4 q)) momentum configurationVariation
    (quarticScreening_bounds q hq).1
  have hhidden := erasureDilation_hidden_nullBoundaryCanonicalPotential
    (screening (lambda4 q)) momentum configurationVariation
    (quarticScreening_bounds q hq).2
  refine ⟨hglobal, ?_, ?_⟩
  · calc
      exteriorNullBoundaryCanonicalPotential
          (screening (lambda4 q)) momentum configurationVariation =
          screening (lambda4 q) *
            nullBoundaryCanonicalPotential momentum configurationVariation :=
        hexterior
      _ = ((2 * q - 1) / q ^ 2) *
            nullBoundaryCanonicalPotential momentum configurationVariation := by
        rw [quartic_screening_identity q hq0]
  · calc
      hiddenNullBoundaryCanonicalPotential
          (screening (lambda4 q)) momentum configurationVariation =
          (1 - screening (lambda4 q)) *
            nullBoundaryCanonicalPotential momentum configurationVariation :=
        hhidden
      _ = lambda4 q ^ 2 *
            nullBoundaryCanonicalPotential momentum configurationVariation := by
        unfold screening
        ring

#print axioms GravityScreening.nullBoundaryCanonicalPotential_pack
#print axioms GravityScreening.erasureDilation_preserves_nullBoundaryCanonicalPotential
#print axioms GravityScreening.erasureDilation_exterior_nullBoundaryCanonicalPotential
#print axioms GravityScreening.erasureDilation_hidden_nullBoundaryCanonicalPotential
#print axioms GravityScreening.quarticNullBoundaryCanonicalPotential_global_exterior_hidden

end GravityScreening
