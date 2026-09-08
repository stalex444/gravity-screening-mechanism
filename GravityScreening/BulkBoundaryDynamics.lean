import GravityScreening.HorizonBoundaryAction
import GravityScreening.TTConstraintSourceClosure

/-!
# From the bulk first-order Hamiltonian to the boundary Cayley step

The determinant-one constitutive Hamiltonian has a complex-structure vector
field.  The electric source frame conjugates that vector field to the ordinary
unit-frequency rotation generator `-J`.  In that normalized frame, one
implicit-midpoint step of algebraic duration `2t` is exactly the centered
Cayley interface law and therefore exactly the passive source splitter.

The remaining physical input is that a horizon crossing is represented by
this centered one-step update.  The generator, frame, step coefficient, and
resulting transfer matrix are then fixed.
-/

namespace GravityScreening

/-- The determinant-one quadratic Hamiltonian carried by one canonical mode
of the normalized first-order doubled action. -/
noncomputable def normalizedBulkQuadraticHamiltonian
    (l d position momentum : ℝ) : ℝ :=
  (position ^ 2 - 2 * l * position * momentum + momentum ^ 2) / (2 * d)

/-- Exact position derivative of the normalized bulk Hamiltonian. -/
theorem normalizedBulkQuadraticHamiltonian_hasDerivAt_position
    (l d position momentum : ℝ) :
    HasDerivAt
      (fun x => normalizedBulkQuadraticHamiltonian l d x momentum)
      ((position - l * momentum) / d) position := by
  unfold normalizedBulkQuadraticHamiltonian
  have hraw := ((hasDerivAt_id position).pow 2 |>.sub
    ((hasDerivAt_id position).const_mul (2 * l * momentum)) |>.add
      (hasDerivAt_const position (momentum ^ 2))) |>.div_const (2 * d)
  have hraw2 : HasDerivAt _ ((position - l * momentum) / d) position :=
    hraw.congr_deriv (by norm_num; ring)
  simpa [id_eq, Pi.sub_apply, Pi.add_apply, Pi.pow_apply,
    mul_assoc, mul_left_comm, mul_comm] using hraw2

/-- Exact momentum derivative of the normalized bulk Hamiltonian. -/
theorem normalizedBulkQuadraticHamiltonian_hasDerivAt_momentum
    (l d position momentum : ℝ) :
    HasDerivAt
      (fun x => normalizedBulkQuadraticHamiltonian l d position x)
      ((momentum - l * position) / d) momentum := by
  unfold normalizedBulkQuadraticHamiltonian
  have hraw := ((hasDerivAt_const momentum (position ^ 2)).sub
    ((hasDerivAt_id momentum).const_mul (2 * l * position)) |>.add
      ((hasDerivAt_id momentum).pow 2)) |>.div_const (2 * d)
  have hraw2 : HasDerivAt _ ((momentum - l * position) / d) momentum :=
    hraw.congr_deriv (by norm_num; ring)
  simpa only [id_eq, Pi.sub_apply, Pi.add_apply, Pi.pow_apply] using hraw2

/-- Hamiltonian vector field of the normalized constitutive shape, with the
sign convention of the first-order action. -/
noncomputable def normalizedBulkHamiltonianGenerator
    (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  -(symplecticBlock * unimodularConstitutive l d)

/-- The matrix generator is exactly Hamilton's equations: position evolves by
the momentum derivative and momentum by minus the position derivative. -/
theorem normalizedBulkHamiltonianGenerator_mulVec
    (l d position momentum : ℝ) :
    (normalizedBulkHamiltonianGenerator l d).mulVec ![position, momentum] =
      ![(momentum - l * position) / d,
        -((position - l * momentum) / d)] := by
  funext i
  fin_cases i <;>
    simp [normalizedBulkHamiltonianGenerator, symplecticBlock,
      unimodularConstitutive, constitutiveBlock, Matrix.mulVec,
      dotProduct, Fin.sum_univ_succ] <;>
    ring

/-- The bulk Hamiltonian vector field is a complex structure. -/
theorem normalizedBulkHamiltonianGenerator_sq
    (l d : ℝ) (hd : d ^ 2 = screening l) (hd0 : d ≠ 0) :
    normalizedBulkHamiltonianGenerator l d *
        normalizedBulkHamiltonianGenerator l d =
      -(1 : Matrix (Fin 2) (Fin 2) ℝ) := by
  have h := unimodular_constitutive_twist_sq l d hd hd0
  simpa [normalizedBulkHamiltonianGenerator] using h

/-- The positive electric source frame turns the squeezed bulk Hamiltonian
vector field into the ordinary unit-frequency rotation generator. -/
theorem electricFrame_conjugates_bulkHamiltonianGenerator
    (l d r : ℝ) (hr : r ≠ 0) (hrd : r ^ 2 = d)
    (hd : d ^ 2 = screening l) :
    electricFrameTransform l r * normalizedBulkHamiltonianGenerator l d *
        electricFrameInverse l r = -symplecticBlock := by
  have hr2pos : 0 < r ^ 2 := sq_pos_of_ne_zero hr
  have hd0 : d ≠ 0 := by
    nlinarith [hrd]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [electricFrameTransform, electricFrameInverse,
      normalizedBulkHamiltonianGenerator, symplecticBlock,
      unimodularConstitutive, constitutiveBlock, Matrix.mul_apply,
      Fin.sum_univ_succ]
  · field_simp [hr, hd0]
    ring
  · field_simp [hr, hd0]
    nlinarith [hrd]
  · unfold screening at hd
    field_simp [hr, hd0]
    nlinarith [hrd, hd]
  · left
    field_simp [hr, hd0]
    ring

/-- Implicit midpoint update for a linear Hamiltonian vector field. -/
def IsImplicitMidpointStep
    (generator : Matrix (Fin 2) (Fin 2) ℝ) (duration : ℝ)
    (before after : Fin 2 → ℝ) : Prop :=
  after - before =
    (duration / 2) • generator.mulVec (before + after)

/-- Implicit midpoint updates are covariant under an invertible linear change
of frame.  The conjugacy equation supplies the transformed generator. -/
theorem implicitMidpointStep_map
    (transform inverse generator transformedGenerator :
      Matrix (Fin 2) (Fin 2) ℝ)
    (duration : ℝ) (before after : Fin 2 → ℝ)
    (hconj : transform * generator * inverse = transformedGenerator)
    (hinv : inverse * transform = 1)
    (hstep : IsImplicitMidpointStep generator duration before after) :
    IsImplicitMidpointStep transformedGenerator duration
      (transform.mulVec before) (transform.mulVec after) := by
  have hintertwine : transform * generator = transformedGenerator * transform := by
    calc
      transform * generator = (transform * generator) * (inverse * transform) := by
        rw [hinv, Matrix.mul_one]
      _ = (transform * generator * inverse) * transform := by
        simp only [Matrix.mul_assoc]
      _ = transformedGenerator * transform := by rw [hconj]
  unfold IsImplicitMidpointStep at hstep ⊢
  have hmapped := congrArg (fun v => transform.mulVec v) hstep
  rw [Matrix.mulVec_sub, Matrix.mulVec_smul] at hmapped
  rw [Matrix.mulVec_mulVec, hintertwine, ← Matrix.mulVec_mulVec,
    Matrix.mulVec_add] at hmapped
  exact hmapped

/-- The electric source frame carries every bulk constitutive midpoint step to
the corresponding ordinary rotational midpoint step. -/
theorem electricFrame_maps_bulkMidpointStep
    (l d r duration : ℝ) (hr : r ≠ 0) (hrd : r ^ 2 = d)
    (hd : d ^ 2 = screening l) (before after : Fin 2 → ℝ)
    (hstep : IsImplicitMidpointStep
      (normalizedBulkHamiltonianGenerator l d) duration before after) :
    IsImplicitMidpointStep (-symplecticBlock) duration
      ((electricFrameTransform l r).mulVec before)
      ((electricFrameTransform l r).mulVec after) := by
  exact implicitMidpointStep_map
    (electricFrameTransform l r) (electricFrameInverse l r)
    (normalizedBulkHamiltonianGenerator l d) (-symplecticBlock)
    duration before after
    (electricFrame_conjugates_bulkHamiltonianGenerator l d r hr hrd hd)
    (electricFrameInverse_mul_transform l r hr) hstep

/-- An implicit midpoint step of duration `2t` for the normalized rotation
generator is exactly the centered interface equation. -/
theorem standardizedMidpointStep_iff_centeredInterface
    (t : ℝ) (before after : Fin 2 → ℝ) :
    IsImplicitMidpointStep (-symplecticBlock) (2 * t) before after ↔
      (interfaceJumpLeft t).mulVec after =
        (interfaceJumpRight t).mulVec before := by
  unfold IsImplicitMidpointStep
  constructor <;> intro h
  · funext i
    have h0 := congrFun h (0 : Fin 2)
    have h1 := congrFun h (1 : Fin 2)
    fin_cases i <;>
      simp [interfaceJumpLeft, interfaceJumpRight, symplecticBlock,
        Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 ⊢ <;>
      linarith
  · funext i
    have h0 := congrFun h (0 : Fin 2)
    have h1 := congrFun h (1 : Fin 2)
    fin_cases i <;>
      simp [interfaceJumpLeft, interfaceJumpRight, symplecticBlock,
        Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 ⊢ <;>
      linarith

/-- In the electric source frame, the midpoint update, boundary variation,
and passive splitter are the same exact map. -/
theorem standardizedBulkMidpointStep_iff_passiveSplitter
    (l d : ℝ) (hl0 : l ≠ 0)
    (hd : d ^ 2 = screening l) (hdpos : 0 < d)
    (before after : Fin 2 → ℝ) :
    IsImplicitMidpointStep (-symplecticBlock)
        (2 * interfaceCoupling l d) before after ↔
      after = (passiveSourceSplitter l d).mulVec before := by
  let qBefore := before 0
  let pBefore := before 1
  let qAfter := after 0
  let pAfter := after 1
  have hbefore : before = ![qBefore, pBefore] := by
    funext i
    fin_cases i <;> rfl
  have hafter : after = ![qAfter, pAfter] := by
    funext i
    fin_cases i <;> rfl
  rw [hbefore, hafter]
  exact (standardizedMidpointStep_iff_centeredInterface
    (interfaceCoupling l d) ![qBefore, pBefore] ![qAfter, pAfter]).trans
      ((horizonBoundaryStationary_iff_centeredInterface
        l d qBefore pBefore qAfter pAfter hl0 hd hdpos).symm.trans
          (horizonBoundaryStationary_iff_passiveSplitter
            l d qBefore pBefore qAfter pAfter hl0 hd))

/-- Quartic capstone: after source-frame normalization, the bulk Hamiltonian
requires one algebraic midpoint duration and yields the passive splitter. -/
theorem quartic_standardizedBulkMidpointStep_iff_passiveSplitter
    (q d : ℝ) (hq : 1 < q)
    (hd : d ^ 2 = screening (lambda4 q)) (hdpos : 0 < d)
    (before after : Fin 2 → ℝ) :
    IsImplicitMidpointStep (-symplecticBlock)
        (2 * interfaceCoupling (lambda4 q) d) before after ↔
      after = (passiveSourceSplitter (lambda4 q) d).mulVec before := by
  have hlpos : 0 < lambda4 q := by
    unfold lambda4
    have hinvlt : 1 / q < 1 := (div_lt_one (by linarith)).mpr hq
    linarith
  exact standardizedBulkMidpointStep_iff_passiveSplitter
    (lambda4 q) d (ne_of_gt hlpos) hd hdpos before after

/-- Quartic bulk-to-boundary capstone.  A midpoint trajectory generated by the
first-order constitutive Hamiltonian, expressed in its uniquely selected
electric source frame, lands exactly on the passive horizon splitter. -/
theorem quartic_bulkMidpointStep_yields_passiveSplitter
    (q d r : ℝ) (hq : 1 < q) (hr : r ≠ 0) (hrd : r ^ 2 = d)
    (hd : d ^ 2 = screening (lambda4 q)) (hdpos : 0 < d)
    (before after : Fin 2 → ℝ)
    (hstep : IsImplicitMidpointStep
      (normalizedBulkHamiltonianGenerator (lambda4 q) d)
      (2 * interfaceCoupling (lambda4 q) d) before after) :
    (electricFrameTransform (lambda4 q) r).mulVec after =
      (passiveSourceSplitter (lambda4 q) d).mulVec
        ((electricFrameTransform (lambda4 q) r).mulVec before) := by
  apply (quartic_standardizedBulkMidpointStep_iff_passiveSplitter
    q d hq hd hdpos
    ((electricFrameTransform (lambda4 q) r).mulVec before)
    ((electricFrameTransform (lambda4 q) r).mulVec after)).mp
  exact electricFrame_maps_bulkMidpointStep
    (lambda4 q) d r (2 * interfaceCoupling (lambda4 q) d)
    hr hrd hd before after hstep

/-- Fully specialized quartic form: the action amplitude, source-frame
amplitude, frame, generator, duration, and splitter are all functions of the
single quartic input `q`. -/
theorem quartic_bulkMidpointStep_yields_canonicalPassiveSplitter
    (q : ℝ) (hq : 1 < q) (before after : Fin 2 → ℝ)
    (hstep : IsImplicitMidpointStep
      (normalizedBulkHamiltonianGenerator
        (lambda4 q) (quarticActionAmplitude q))
      (2 * interfaceCoupling (lambda4 q) (quarticActionAmplitude q))
      before after) :
    (quarticElectricSourceFrame q).mulVec after =
      (passiveSourceSplitter
        (lambda4 q) (quarticActionAmplitude q)).mulVec
        ((quarticElectricSourceFrame q).mulVec before) := by
  exact quartic_bulkMidpointStep_yields_passiveSplitter
    q (quarticActionAmplitude q) (quarticSourceFrameAmplitude q)
    hq (ne_of_gt (quarticSourceFrameAmplitude_pos q hq))
    (quarticSourceFrameAmplitude_sq q)
    (quarticActionAmplitude_sq q hq)
    (quarticActionAmplitude_pos q hq)
    before after hstep

#print axioms GravityScreening.normalizedBulkHamiltonianGenerator_sq
#print axioms GravityScreening.normalizedBulkQuadraticHamiltonian_hasDerivAt_position
#print axioms GravityScreening.normalizedBulkQuadraticHamiltonian_hasDerivAt_momentum
#print axioms GravityScreening.normalizedBulkHamiltonianGenerator_mulVec
#print axioms GravityScreening.electricFrame_conjugates_bulkHamiltonianGenerator
#print axioms GravityScreening.implicitMidpointStep_map
#print axioms GravityScreening.electricFrame_maps_bulkMidpointStep
#print axioms GravityScreening.standardizedMidpointStep_iff_centeredInterface
#print axioms GravityScreening.standardizedBulkMidpointStep_iff_passiveSplitter
#print axioms GravityScreening.quartic_standardizedBulkMidpointStep_iff_passiveSplitter
#print axioms GravityScreening.quartic_bulkMidpointStep_yields_passiveSplitter
#print axioms GravityScreening.quartic_bulkMidpointStep_yields_canonicalPassiveSplitter

end GravityScreening
