import GravityScreening.ObserverRotationGauge
import GravityScreening.BoundaryMeasureNormalization

/-!
# Integrating a rotation-scalar channel over the observer gauge

Fixing a future rest observer leaves an oriented `SO(3)` frame gauge.  This
file isolates the exact mathematical content of the proposed measurement
rule: integrating a response that is constant on that gauge multiplies it by
the gauge's total volume.  With the round projective mass `pi^2`, the
15-channel vertex becomes the deposited electromagnetic coupling.

The physical assertion that a measured coupling is this inclusive integral,
and the choice of the round projective metric, remain explicit premises.
-/

namespace GravityScreening

open MeasureTheory Set

abbrev ObserverRotationGroup := Matrix.specialOrthogonalGroup (Fin 3) ℝ

/-- The response per unresolved observer orientation before integration. -/
noncomputable def conformalChannelVertex (rho q : ℝ) : ℝ :=
  1 / (rho * q) ^ electromagneticExponent

/-- Group integration of a rotation-scalar response multiplies it by the
real total mass of the chosen finite measure. -/
theorem integral_rotationScalar_eq_mass_mul
    [MeasurableSpace ObserverRotationGroup]
    (μ : Measure ObserverRotationGroup) [IsFiniteMeasure μ] [μ.IsMulLeftInvariant]
    (vertex : ℝ) :
    (∫ _ : ObserverRotationGroup, vertex ∂μ) = μ.real Set.univ * vertex := by
  rw [integral_const, smul_eq_mul]

/-- Under the round projective normalization, inclusive integration of the
15-channel scalar vertex is exactly the PDT electromagnetic expression. -/
theorem conformalChannelVertex_integral_eq_electromagneticCoupling
    [MeasurableSpace ObserverRotationGroup]
    (μ : Measure ObserverRotationGroup) [IsFiniteMeasure μ] [μ.IsMulLeftInvariant]
    (rho q : ℝ)
    (hRoundMass : μ.real Set.univ = projectiveBoundaryVolume) :
    (∫ _ : ObserverRotationGroup, conformalChannelVertex rho q ∂μ) =
      electromagneticCoupling rho q := by
  rw [integral_rotationScalar_eq_mass_mul, hRoundMass,
    projectiveBoundaryVolume_eq_pi_sq]
  simp [conformalChannelVertex, electromagneticCoupling, div_eq_mul_inv]

/-- Gravity contains one additional projective-volume factor relative to the
15-channel electromagnetic link, together with the complementary response
and quartic screening determinant. -/
theorem gravitationalCoupling_eq_integratedObserverVertex_link
    [MeasurableSpace ObserverRotationGroup]
    (μ : Measure ObserverRotationGroup) [IsFiniteMeasure μ] [μ.IsMulLeftInvariant]
    (rho q : ℝ)
    (hRoundMass : μ.real Set.univ = projectiveBoundaryVolume)
    (hScreen : screening (lambda4 q) ≠ 0) :
    gravitationalCoupling rho q =
      (∫ _ : ObserverRotationGroup, conformalChannelVertex rho q ∂μ) *
        projectiveBoundaryVolume /
          ((rho * q) ^ gravitationalComplementExponent *
            screening (lambda4 q)) := by
  rw [conformalChannelVertex_integral_eq_electromagneticCoupling
    μ rho q hRoundMass, projectiveBoundaryVolume_eq_pi_sq]
  exact gravitationalCoupling_eq_electromagnetic_link rho q hScreen

#print axioms GravityScreening.integral_rotationScalar_eq_mass_mul
#print axioms GravityScreening.conformalChannelVertex_integral_eq_electromagneticCoupling
#print axioms GravityScreening.gravitationalCoupling_eq_integratedObserverVertex_link

end GravityScreening
