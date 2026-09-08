import GravityScreening.TTHelicityModeReduction

/-!
# The TT oscillator as the intrinsic null-horizon spin-two pair

The intrinsic symplectic potential on a null hypersurface contains the
spin-two canonical pair `(epsilon_B sigma / 2, gamma)`: densitized shear and
the conformal metric on a cut.  This file evaluates that standard pairing on
the two circular TT Fourier modes.  At unit cut density the factor `1/2`
cancels the circular TT norm two, giving exactly `p delta q` for either
helicity.

The Lean statements verify the fixed-mode coordinate reduction.  The
geometric identification of the abstract amplitudes with a chosen null cut's
densitized shear and conformal metric is published physics input.
-/

namespace GravityScreening

/-- Fixed-mode form of the intrinsic null spin-two symplectic potential
`(1/2) epsilon_B sigma^{AB} delta gamma_AB`, at unit cut density. -/
noncomputable def nullSpinTwoCanonicalPairing
    (densitizedShear conformalMetricVariation : ComplexTTCoordinates) : ℝ :=
  ((1 / 2 : ℂ) *
    finiteHermitianPairing densitizedShear conformalMetricVariation).re

/-- On the positive circular polarization, the intrinsic null spin-two pair
is exactly `p delta q`. -/
theorem nullSpinTwoCanonicalPairing_positiveHelicity
    (momentum positionVariation : ℝ) :
    nullSpinTwoCanonicalPairing
        (realPositiveHelicityAmplitude momentum)
        (realPositiveHelicityAmplitude positionVariation) =
      momentum * positionVariation := by
  unfold nullSpinTwoCanonicalPairing
  rw [finiteHermitianPairing_realPositiveHelicityAmplitude]
  have hcomplex :
      (1 / 2 : ℂ) *
          ((2 : ℂ) * (momentum : ℂ) * (positionVariation : ℂ)) =
        ((momentum * positionVariation : ℝ) : ℂ) := by
    push_cast
    norm_num
    ring
  calc
    _ = (((momentum * positionVariation : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = momentum * positionVariation := Complex.ofReal_re _

/-- The same intrinsic canonical pairing holds on the negative circular
polarization. -/
theorem nullSpinTwoCanonicalPairing_negativeHelicity
    (momentum positionVariation : ℝ) :
    nullSpinTwoCanonicalPairing
        (realNegativeHelicityAmplitude momentum)
        (realNegativeHelicityAmplitude positionVariation) =
      momentum * positionVariation := by
  unfold nullSpinTwoCanonicalPairing
  rw [finiteHermitianPairing_realNegativeHelicityAmplitude]
  have hcomplex :
      (1 / 2 : ℂ) *
          ((2 : ℂ) * (momentum : ℂ) * (positionVariation : ℂ)) =
        ((momentum * positionVariation : ℝ) : ℂ) := by
    push_cast
    norm_num
    ring
  calc
    _ = (((momentum * positionVariation : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = momentum * positionVariation := Complex.ofReal_re _

/-- The positive-helicity canonical term of the duality-symmetric spin-two
action is the intrinsic null spin-two symplectic pairing, up to the common
nonzero Fourier normalization `4 k^3`. -/
theorem ttKinetic_positiveHelicity_eq_nullSpinTwoPairing
    (k position momentum positionVelocity momentumVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialKineticTerm k
        (positiveHelicityPrepotentialMode position momentum)
        (positiveHelicityPrepotentialMode
          positionVelocity momentumVelocity) /
          (4 * k ^ 3) =
      nullSpinTwoCanonicalPairing
        (realPositiveHelicityAmplitude momentum)
        (realPositiveHelicityAmplitude positionVelocity) := by
  rw [ttPrepotentialKineticTerm_positiveHelicity]
  rw [nullSpinTwoCanonicalPairing_positiveHelicity]
  field_simp [hk]

/-- After the curl-determined momentum orientation, the negative-helicity
prepotential term gives the same intrinsic null spin-two pairing. -/
theorem ttKinetic_negativeHelicity_eq_nullSpinTwoPairing
    (k position momentum positionVelocity momentumVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialKineticTerm k
        (negativeHelicityCanonicalPrepotentialMode position momentum)
        (negativeHelicityCanonicalPrepotentialMode
          positionVelocity momentumVelocity) /
          (4 * k ^ 3) =
      nullSpinTwoCanonicalPairing
        (realNegativeHelicityAmplitude momentum)
        (realNegativeHelicityAmplitude positionVelocity) := by
  rw [ttPrepotentialKineticTerm_negativeHelicityCanonical]
  rw [nullSpinTwoCanonicalPairing_negativeHelicity]
  field_simp [hk]

/-- Intrinsic null-horizon Lagrangian of one circular spin-two mode in the
dimensionless phase coordinate. -/
noncomputable def nullSpinTwoOscillatorLagrangian
    (momentum positionPhaseVelocity position : ℝ) : ℝ :=
  momentum * positionPhaseVelocity -
    normalizedOscillatorHamiltonian position momentum

/-- Positive-helicity fixed-mode spin-two action equals the intrinsic
null-horizon oscillator action. -/
theorem ttLagrangian_positiveHelicity_eq_nullSpinTwoOscillator
    (k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialLagrangian k
        (positiveHelicityPrepotentialMode position momentum)
        (positiveHelicityPrepotentialMode
          (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) /
          (4 * k ^ 4) =
      nullSpinTwoOscillatorLagrangian
        momentum positionPhaseVelocity position := by
  rw [ttPrepotentialLagrangian_positiveHelicity_normalized
    k position momentum positionPhaseVelocity momentumPhaseVelocity hk]
  rfl

/-- Negative-helicity fixed-mode spin-two action gives the same intrinsic
null-horizon oscillator action. -/
theorem ttLagrangian_negativeHelicity_eq_nullSpinTwoOscillator
    (k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialLagrangian k
        (negativeHelicityCanonicalPrepotentialMode position momentum)
        (negativeHelicityCanonicalPrepotentialMode
          (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) /
          (4 * k ^ 4) =
      nullSpinTwoOscillatorLagrangian
        momentum positionPhaseVelocity position := by
  rw [ttPrepotentialLagrangian_negativeHelicity_normalized
    k position momentum positionPhaseVelocity momentumPhaseVelocity hk]
  rfl

/-- Null-boundary Hamilton--Jacobi capstone: the quartic boundary generator
is the principal function of the oscillator whose canonical term is the
intrinsic null spin-two shear--conformal-metric pairing. -/
theorem quarticNullSpinTwo_hamiltonJacobi_capstone
    (q qBefore qAfter : ℝ) (hq : 1 < q) :
    (horizonBoundaryGeneratingFunction
          (lambda4 q) (quarticActionAmplitude q) qBefore qAfter =
        oscillatorPrincipalFunction
          (quarticInterfacePhase q) qBefore qAfter) ∧
    HasDerivAt
      (fun θ => oscillatorPrincipalFunction θ qBefore qAfter)
      (normalizedOscillatorHamiltonian qAfter
        (oscillatorPrincipalOutgoingMomentum
          (quarticInterfacePhase q) qBefore qAfter))
      (quarticInterfacePhase q) := by
  exact ⟨quartic_horizonBoundaryGeneratingFunction_eq_principalFunction
      q qBefore qAfter hq,
    quartic_oscillatorPrincipalFunction_hasDerivAt_phase
      q qBefore qAfter hq⟩

#print axioms GravityScreening.nullSpinTwoCanonicalPairing_positiveHelicity
#print axioms GravityScreening.nullSpinTwoCanonicalPairing_negativeHelicity
#print axioms GravityScreening.ttKinetic_positiveHelicity_eq_nullSpinTwoPairing
#print axioms GravityScreening.ttKinetic_negativeHelicity_eq_nullSpinTwoPairing
#print axioms GravityScreening.ttLagrangian_positiveHelicity_eq_nullSpinTwoOscillator
#print axioms GravityScreening.ttLagrangian_negativeHelicity_eq_nullSpinTwoOscillator
#print axioms GravityScreening.quarticNullSpinTwo_hamiltonJacobi_capstone

end GravityScreening
