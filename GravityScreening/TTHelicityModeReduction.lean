import GravityScreening.HamiltonPrincipalBoundary
import GravityScreening.TTPrepotentialAction

/-!
# Circular TT modes reduce to the canonical oscillator action

The duality-symmetric transverse-traceless prepotential action already
contains the unit oscillator used in the bulk-to-boundary calculation.  On a
single positive-curl circular polarization with real prepotential amplitudes,
the fixed-momentum action reduces exactly to `p q' - (q^2+p^2)/2` after using
the dimensionless phase `tau = k t` and removing the common nonzero mode
normalization.

This is a mode-level statement.  It does not select the quartic endpoint
phase or identify the finite mode with a complete covariant null-boundary
phase space.
-/

namespace GravityScreening

/-- A real amplitude on the positive generalized-curl circular polarization
`(1,i)`. -/
noncomputable def realPositiveHelicityAmplitude
    (amplitude : ℝ) : ComplexTTCoordinates :=
  fun i => (amplitude : ℂ) * ttCurlPositiveEigenmode i

/-- The positive-helicity real-amplitude line is a curl eigenspace with
eigenvalue `k`. -/
theorem complexTTCurlCoordinates_realPositiveHelicityAmplitude
    (k amplitude : ℝ) :
    complexTTCurlCoordinates k (realPositiveHelicityAmplitude amplitude) =
      realPositiveHelicityAmplitude (k * amplitude) := by
  funext i
  fin_cases i <;>
    simp [complexTTCurlCoordinates, realPositiveHelicityAmplitude,
      ttCurlPositiveEigenmode] <;>
    ring_nf
  all_goals rw [Complex.I_sq]
  all_goals ring

/-- Hermitian pairing on the real positive-helicity line.  The factor two is
the squared norm of `(1,i)`. -/
theorem finiteHermitianPairing_realPositiveHelicityAmplitude
    (a b : ℝ) :
    finiteHermitianPairing
        (realPositiveHelicityAmplitude a)
        (realPositiveHelicityAmplitude b) =
      (2 : ℂ) * (a : ℂ) * (b : ℂ) := by
  simp [finiteHermitianPairing, realPositiveHelicityAmplitude,
    ttCurlPositiveEigenmode, Fin.sum_univ_succ,
    Complex.conj_I]
  calc
    (a : ℂ) * b + -((a : ℂ) * Complex.I * ((b : ℂ) * Complex.I)) =
        (a : ℂ) * b - ((a : ℂ) * b) * Complex.I ^ 2 := by ring
    _ = (2 : ℂ) * (a : ℂ) * (b : ℂ) := by
      rw [Complex.I_sq]
      norm_num
      ring

/-- Embed a canonical position-momentum pair as the two duality-related
positive-helicity gravitational prepotentials. -/
noncomputable def positiveHelicityPrepotentialMode
    (position momentum : ℝ) : TTPrepotentialMode :=
  ![realPositiveHelicityAmplitude position,
    realPositiveHelicityAmplitude momentum]

/-- The fixed-momentum TT canonical term becomes `4 k^3 p qdot`. -/
theorem ttPrepotentialKineticTerm_positiveHelicity
    (k position momentum positionVelocity momentumVelocity : ℝ) :
    ttPrepotentialKineticTerm k
        (positiveHelicityPrepotentialMode position momentum)
        (positiveHelicityPrepotentialMode
          positionVelocity momentumVelocity) =
      4 * k ^ 3 * momentum * positionVelocity := by
  unfold ttPrepotentialKineticTerm positiveHelicityPrepotentialMode
  change
    (2 * ((k ^ 2 : ℝ) : ℂ) *
      finiteHermitianPairing
        (complexTTCurlCoordinates k
          (realPositiveHelicityAmplitude momentum))
        (realPositiveHelicityAmplitude positionVelocity)).re = _
  rw [complexTTCurlCoordinates_realPositiveHelicityAmplitude]
  rw [finiteHermitianPairing_realPositiveHelicityAmplitude]
  have hcomplex :
      (2 : ℂ) * ((k ^ 2 : ℝ) : ℂ) *
          ((2 : ℂ) * ((k * momentum : ℝ) : ℂ) *
            (positionVelocity : ℂ)) =
        ((4 * k ^ 3 * momentum * positionVelocity : ℝ) : ℂ) := by
    push_cast
    ring
  calc
    _ = (((4 * k ^ 3 * momentum * positionVelocity : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = 4 * k ^ 3 * momentum * positionVelocity :=
      Complex.ofReal_re _

/-- The fixed-momentum TT Hamiltonian becomes
`2 k^4 (q^2+p^2)`. -/
theorem ttPrepotentialHamiltonian_positiveHelicity
    (k position momentum : ℝ) :
    ttPrepotentialHamiltonian k
        (positiveHelicityPrepotentialMode position momentum) =
      2 * k ^ 4 * (position ^ 2 + momentum ^ 2) := by
  unfold ttPrepotentialHamiltonian positiveHelicityPrepotentialMode
  change
    (((k ^ 4 : ℝ) : ℂ) *
      (finiteHermitianPairing
          (realPositiveHelicityAmplitude position)
          (realPositiveHelicityAmplitude position) +
        finiteHermitianPairing
          (realPositiveHelicityAmplitude momentum)
          (realPositiveHelicityAmplitude momentum))).re = _
  rw [finiteHermitianPairing_realPositiveHelicityAmplitude]
  rw [finiteHermitianPairing_realPositiveHelicityAmplitude]
  have hcomplex :
      ((k ^ 4 : ℝ) : ℂ) *
          ((2 : ℂ) * (position : ℂ) * (position : ℂ) +
            (2 : ℂ) * (momentum : ℂ) * (momentum : ℂ)) =
        ((2 * k ^ 4 * (position ^ 2 + momentum ^ 2) : ℝ) : ℂ) := by
    push_cast
    ring
  calc
    _ = (((2 * k ^ 4 * (position ^ 2 + momentum ^ 2) : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = 2 * k ^ 4 * (position ^ 2 + momentum ^ 2) :=
      Complex.ofReal_re _

/-- Exact positive-helicity fixed-mode Lagrangian. -/
theorem ttPrepotentialLagrangian_positiveHelicity
    (k position momentum positionVelocity momentumVelocity : ℝ) :
    ttPrepotentialLagrangian k
        (positiveHelicityPrepotentialMode position momentum)
        (positiveHelicityPrepotentialMode
          positionVelocity momentumVelocity) =
      4 * k ^ 3 * momentum * positionVelocity -
        2 * k ^ 4 * (position ^ 2 + momentum ^ 2) := by
  unfold ttPrepotentialLagrangian
  rw [ttPrepotentialKineticTerm_positiveHelicity]
  rw [ttPrepotentialHamiltonian_positiveHelicity]

/-- After changing from time to dimensionless phase `tau=k t`, the
positive-helicity gravitational mode is exactly the canonical unit oscillator
action, up to its common nonzero Fourier-mode normalization `4 k^4`. -/
theorem ttPrepotentialLagrangian_positiveHelicity_normalized
    (k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialLagrangian k
        (positiveHelicityPrepotentialMode position momentum)
        (positiveHelicityPrepotentialMode
          (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) /
          (4 * k ^ 4) =
      momentum * positionPhaseVelocity -
        normalizedOscillatorHamiltonian position momentum := by
  rw [ttPrepotentialLagrangian_positiveHelicity]
  unfold normalizedOscillatorHamiltonian
  field_simp [hk]
  ring

/-- A real amplitude on the negative generalized-curl circular polarization
`(1,-i)`. -/
noncomputable def realNegativeHelicityAmplitude
    (amplitude : ℝ) : ComplexTTCoordinates :=
  fun i => (amplitude : ℂ) * ttCurlNegativeEigenmode i

/-- The negative-helicity real-amplitude line has curl eigenvalue `-k`. -/
theorem complexTTCurlCoordinates_realNegativeHelicityAmplitude
    (k amplitude : ℝ) :
    complexTTCurlCoordinates k (realNegativeHelicityAmplitude amplitude) =
      realNegativeHelicityAmplitude (-(k * amplitude)) := by
  funext i
  fin_cases i <;>
    simp [complexTTCurlCoordinates, realNegativeHelicityAmplitude,
      ttCurlNegativeEigenmode] <;>
    ring_nf
  all_goals rw [Complex.I_sq]
  all_goals ring

/-- The negative-helicity circular vector has the same squared norm two. -/
theorem finiteHermitianPairing_realNegativeHelicityAmplitude
    (a b : ℝ) :
    finiteHermitianPairing
        (realNegativeHelicityAmplitude a)
        (realNegativeHelicityAmplitude b) =
      (2 : ℂ) * (a : ℂ) * (b : ℂ) := by
  simp [finiteHermitianPairing, realNegativeHelicityAmplitude,
    ttCurlNegativeEigenmode, Fin.sum_univ_succ, Complex.conj_I]
  calc
    (a : ℂ) * b + -((a : ℂ) * Complex.I * ((b : ℂ) * Complex.I)) =
        (a : ℂ) * b - ((a : ℂ) * b) * Complex.I ^ 2 := by ring
    _ = (2 : ℂ) * (a : ℂ) * (b : ℂ) := by
      rw [Complex.I_sq]
      norm_num
      ring

/-- Canonical orientation on the negative-helicity sector.  The momentum
sign compensates the opposite generalized-curl eigenvalue. -/
noncomputable def negativeHelicityCanonicalPrepotentialMode
    (position momentum : ℝ) : TTPrepotentialMode :=
  ![realNegativeHelicityAmplitude position,
    realNegativeHelicityAmplitude (-momentum)]

/-- With its canonical momentum orientation, the negative-helicity kinetic
term is the same `4 k^3 p qdot` as the positive-helicity term. -/
theorem ttPrepotentialKineticTerm_negativeHelicityCanonical
    (k position momentum positionVelocity momentumVelocity : ℝ) :
    ttPrepotentialKineticTerm k
        (negativeHelicityCanonicalPrepotentialMode position momentum)
        (negativeHelicityCanonicalPrepotentialMode
          positionVelocity momentumVelocity) =
      4 * k ^ 3 * momentum * positionVelocity := by
  unfold ttPrepotentialKineticTerm
    negativeHelicityCanonicalPrepotentialMode
  change
    (2 * ((k ^ 2 : ℝ) : ℂ) *
      finiteHermitianPairing
        (complexTTCurlCoordinates k
          (realNegativeHelicityAmplitude (-momentum)))
        (realNegativeHelicityAmplitude positionVelocity)).re = _
  rw [complexTTCurlCoordinates_realNegativeHelicityAmplitude]
  rw [finiteHermitianPairing_realNegativeHelicityAmplitude]
  have hcomplex :
      (2 : ℂ) * ((k ^ 2 : ℝ) : ℂ) *
          ((2 : ℂ) * ((-(k * -momentum) : ℝ) : ℂ) *
            (positionVelocity : ℂ)) =
        ((4 * k ^ 3 * momentum * positionVelocity : ℝ) : ℂ) := by
    push_cast
    ring
  calc
    _ = (((4 * k ^ 3 * momentum * positionVelocity : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = 4 * k ^ 3 * momentum * positionVelocity :=
      Complex.ofReal_re _

/-- The canonical negative-helicity Hamiltonian equals the positive-helicity
Hamiltonian. -/
theorem ttPrepotentialHamiltonian_negativeHelicityCanonical
    (k position momentum : ℝ) :
    ttPrepotentialHamiltonian k
        (negativeHelicityCanonicalPrepotentialMode position momentum) =
      2 * k ^ 4 * (position ^ 2 + momentum ^ 2) := by
  unfold ttPrepotentialHamiltonian
    negativeHelicityCanonicalPrepotentialMode
  change
    (((k ^ 4 : ℝ) : ℂ) *
      (finiteHermitianPairing
          (realNegativeHelicityAmplitude position)
          (realNegativeHelicityAmplitude position) +
        finiteHermitianPairing
          (realNegativeHelicityAmplitude (-momentum))
          (realNegativeHelicityAmplitude (-momentum)))).re = _
  rw [finiteHermitianPairing_realNegativeHelicityAmplitude]
  rw [finiteHermitianPairing_realNegativeHelicityAmplitude]
  have hcomplex :
      ((k ^ 4 : ℝ) : ℂ) *
          ((2 : ℂ) * (position : ℂ) * (position : ℂ) +
            (2 : ℂ) * ((-momentum : ℝ) : ℂ) *
              ((-momentum : ℝ) : ℂ)) =
        ((2 * k ^ 4 * (position ^ 2 + momentum ^ 2) : ℝ) : ℂ) := by
    push_cast
    ring
  calc
    _ = (((2 * k ^ 4 * (position ^ 2 + momentum ^ 2) : ℝ) : ℂ)).re :=
      congrArg Complex.re hcomplex
    _ = 2 * k ^ 4 * (position ^ 2 + momentum ^ 2) :=
      Complex.ofReal_re _

/-- Both circular graviton helicities reduce to the same unit oscillator
action once each is given the canonical orientation fixed by its curl
eigenvalue. -/
theorem ttPrepotentialLagrangian_negativeHelicity_normalized
    (k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hk : k ≠ 0) :
    ttPrepotentialLagrangian k
        (negativeHelicityCanonicalPrepotentialMode position momentum)
        (negativeHelicityCanonicalPrepotentialMode
          (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) /
          (4 * k ^ 4) =
      momentum * positionPhaseVelocity -
        normalizedOscillatorHamiltonian position momentum := by
  unfold ttPrepotentialLagrangian
  rw [ttPrepotentialKineticTerm_negativeHelicityCanonical]
  rw [ttPrepotentialHamiltonian_negativeHelicityCanonical]
  unfold normalizedOscillatorHamiltonian
  field_simp [hk]
  ring

/-- On the positive circular graviton mode, the exterior quartic action is
exactly `S_Q` times the canonical oscillator action. -/
theorem quarticExterior_positiveHelicity_normalized
    (q k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hq : 1 < q) (hk : k ≠ 0) :
    exteriorTTPrepotentialLagrangian k
        (dilateTTPrepotentialMode (screening (lambda4 q))
          (positiveHelicityPrepotentialMode position momentum))
        (dilateTTPrepotentialMode (screening (lambda4 q))
          (positiveHelicityPrepotentialMode
            (k * positionPhaseVelocity) (k * momentumPhaseVelocity))) /
          (4 * k ^ 4) =
      ((2 * q - 1) / q ^ 2) *
        (momentum * positionPhaseVelocity -
          normalizedOscillatorHamiltonian position momentum) := by
  rw [quarticDilatedTTPrepotential_exterior_lagrangian q k
    (positiveHelicityPrepotentialMode position momentum)
    (positiveHelicityPrepotentialMode
      (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) hq]
  rw [ttPrepotentialLagrangian_positiveHelicity]
  unfold normalizedOscillatorHamiltonian
  field_simp [hk]
  ring

/-- The same quartic exterior oscillator action holds for the opposite
physical helicity after its curl-determined canonical orientation. -/
theorem quarticExterior_negativeHelicity_normalized
    (q k position momentum positionPhaseVelocity momentumPhaseVelocity : ℝ)
    (hq : 1 < q) (hk : k ≠ 0) :
    exteriorTTPrepotentialLagrangian k
        (dilateTTPrepotentialMode (screening (lambda4 q))
          (negativeHelicityCanonicalPrepotentialMode position momentum))
        (dilateTTPrepotentialMode (screening (lambda4 q))
          (negativeHelicityCanonicalPrepotentialMode
            (k * positionPhaseVelocity) (k * momentumPhaseVelocity))) /
          (4 * k ^ 4) =
      ((2 * q - 1) / q ^ 2) *
        (momentum * positionPhaseVelocity -
          normalizedOscillatorHamiltonian position momentum) := by
  rw [quarticDilatedTTPrepotential_exterior_lagrangian q k
    (negativeHelicityCanonicalPrepotentialMode position momentum)
    (negativeHelicityCanonicalPrepotentialMode
      (k * positionPhaseVelocity) (k * momentumPhaseVelocity)) hq]
  unfold ttPrepotentialLagrangian
  rw [ttPrepotentialKineticTerm_negativeHelicityCanonical]
  rw [ttPrepotentialHamiltonian_negativeHelicityCanonical]
  unfold normalizedOscillatorHamiltonian
  field_simp [hk]
  ring

/-- Fixed-mode spin-two capstone: both circular helicities give the same
quartic exterior oscillator action, and the corresponding quartic endpoint
generator is that oscillator's Hamilton principal function. -/
theorem quarticTT_helicity_bulkBoundary_capstone
    (q k position momentum positionPhaseVelocity momentumPhaseVelocity
      qBefore qAfter : ℝ)
    (hq : 1 < q) (hk : k ≠ 0) :
    (exteriorTTPrepotentialLagrangian k
          (dilateTTPrepotentialMode (screening (lambda4 q))
            (positiveHelicityPrepotentialMode position momentum))
          (dilateTTPrepotentialMode (screening (lambda4 q))
            (positiveHelicityPrepotentialMode
              (k * positionPhaseVelocity) (k * momentumPhaseVelocity))) /
            (4 * k ^ 4) =
        ((2 * q - 1) / q ^ 2) *
          (momentum * positionPhaseVelocity -
            normalizedOscillatorHamiltonian position momentum)) ∧
    (exteriorTTPrepotentialLagrangian k
          (dilateTTPrepotentialMode (screening (lambda4 q))
            (negativeHelicityCanonicalPrepotentialMode position momentum))
          (dilateTTPrepotentialMode (screening (lambda4 q))
            (negativeHelicityCanonicalPrepotentialMode
              (k * positionPhaseVelocity) (k * momentumPhaseVelocity))) /
            (4 * k ^ 4) =
        ((2 * q - 1) / q ^ 2) *
          (momentum * positionPhaseVelocity -
            normalizedOscillatorHamiltonian position momentum)) ∧
    horizonBoundaryGeneratingFunction
        (lambda4 q) (quarticActionAmplitude q) qBefore qAfter =
      oscillatorPrincipalFunction
        (quarticInterfacePhase q) qBefore qAfter := by
  exact ⟨quarticExterior_positiveHelicity_normalized
      q k position momentum positionPhaseVelocity momentumPhaseVelocity hq hk,
    quarticExterior_negativeHelicity_normalized
      q k position momentum positionPhaseVelocity momentumPhaseVelocity hq hk,
    quartic_horizonBoundaryGeneratingFunction_eq_principalFunction
      q qBefore qAfter hq⟩

#print axioms GravityScreening.complexTTCurlCoordinates_realPositiveHelicityAmplitude
#print axioms GravityScreening.finiteHermitianPairing_realPositiveHelicityAmplitude
#print axioms GravityScreening.ttPrepotentialKineticTerm_positiveHelicity
#print axioms GravityScreening.ttPrepotentialHamiltonian_positiveHelicity
#print axioms GravityScreening.ttPrepotentialLagrangian_positiveHelicity
#print axioms GravityScreening.ttPrepotentialLagrangian_positiveHelicity_normalized
#print axioms GravityScreening.complexTTCurlCoordinates_realNegativeHelicityAmplitude
#print axioms GravityScreening.finiteHermitianPairing_realNegativeHelicityAmplitude
#print axioms GravityScreening.ttPrepotentialKineticTerm_negativeHelicityCanonical
#print axioms GravityScreening.ttPrepotentialHamiltonian_negativeHelicityCanonical
#print axioms GravityScreening.ttPrepotentialLagrangian_negativeHelicity_normalized
#print axioms GravityScreening.quarticExterior_positiveHelicity_normalized
#print axioms GravityScreening.quarticExterior_negativeHelicity_normalized
#print axioms GravityScreening.quarticTT_helicity_bulkBoundary_capstone

end GravityScreening
