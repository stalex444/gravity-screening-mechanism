import GravityScreening.BoundaryMeasureNormalization
import GravityScreening.ObserverGaugeIntegration

/-!
# Pauli-frame normalization of the round observer gauge

The three Pauli involutions have spectrum normalized by `sigma_j^2 = I` and
are orthonormal for the half-trace pairing.  In the corresponding quaternion
coordinates, a complex two-by-two matrix is special unitary exactly when its
four real coefficients lie on the unit three-sphere.  This isolates the exact
algebraic reason that the Pauli measurement normalization fixes a unit, rather
than freely rescaled, `S^3` cover of the rotation group.

The Hermitian-involution convention is the same mathematical normalization
used by the project's registered Tsirelson and entanglement formalizations
(PALOMAR-2026-08-19-000007 and PALOMAR-2026-09-01-000003).  This file
reconstructs only the consequences needed for the gravity package; the
registrations are provenance for the upstream convention, not evidence for
the gravitational correspondence proposed downstream.
-/

namespace GravityScreening

noncomputable section

open Matrix Complex

abbrev QubitIndex := Fin 2

noncomputable def pauliX : Matrix QubitIndex QubitIndex ℂ :=
  !![0, 1; 1, 0]

noncomputable def pauliY : Matrix QubitIndex QubitIndex ℂ :=
  !![0, -Complex.I; Complex.I, 0]

noncomputable def pauliZ : Matrix QubitIndex QubitIndex ℂ :=
  !![1, 0; 0, -1]

noncomputable def pauliAxis : Fin 3 → Matrix QubitIndex QubitIndex ℂ
  | 0 => pauliX
  | 1 => pauliY
  | 2 => pauliZ

/-- The operator normalization used for dichotomic quantum observables. -/
theorem pauliAxis_sq (j : Fin 3) :
    pauliAxis j * pauliAxis j = 1 := by
  fin_cases j <;>
    ext i k <;> fin_cases i <;> fin_cases k <;>
    norm_num [pauliAxis, pauliX, pauliY, pauliZ, Matrix.mul_apply,
      Fin.sum_univ_succ, Complex.I_mul_I]

/-- Half the real trace pairing on Hermitian qubit observables. -/
noncomputable def pauliHalfTracePair
    (A B : Matrix QubitIndex QubitIndex ℂ) : ℝ :=
  (1 / 2 : ℝ) * (Matrix.trace (A * B)).re

/-- The three `+-1` Pauli measurement axes form an orthonormal frame. -/
theorem pauliAxes_halfTrace_orthonormal (j k : Fin 3) :
    pauliHalfTracePair (pauliAxis j) (pauliAxis k) =
      if j = k then 1 else 0 := by
  fin_cases j <;> fin_cases k <;>
    norm_num [pauliHalfTracePair, pauliAxis, pauliX, pauliY, pauliZ,
      Matrix.trace, Matrix.mul_apply, Fin.sum_univ_succ,
      Complex.I_mul_I]

/-- The standard real quaternion coordinates inside complex two-by-two
matrices. -/
noncomputable def quaternionSU2Matrix (a b c d : ℝ) :
    Matrix QubitIndex QubitIndex ℂ :=
  !![(a : ℂ) + (b : ℂ) * Complex.I,
       (c : ℂ) + (d : ℂ) * Complex.I;
     -(c : ℂ) + (d : ℂ) * Complex.I,
       (a : ℂ) - (b : ℂ) * Complex.I]

noncomputable def quaternionCoeffNormSq (a b c d : ℝ) : ℝ :=
  a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2

/-- The determinant is precisely the Euclidean squared norm of the four real
quaternion coefficients. -/
theorem quaternionSU2Matrix_det
    (a b c d : ℝ) :
    Matrix.det (quaternionSU2Matrix a b c d) =
      (quaternionCoeffNormSq a b c d : ℂ) := by
  simp [quaternionSU2Matrix, quaternionCoeffNormSq, Matrix.det_fin_two]
  ring_nf
  simp
  ring

/-- The Gram matrix is the same squared coefficient norm times identity. -/
theorem quaternionSU2Matrix_conjTranspose_mul
    (a b c d : ℝ) :
    (quaternionSU2Matrix a b c d).conjTranspose *
        quaternionSU2Matrix a b c d =
      (quaternionCoeffNormSq a b c d : ℂ) •
        (1 : Matrix QubitIndex QubitIndex ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [quaternionSU2Matrix, quaternionCoeffNormSq,
      Matrix.conjTranspose, Matrix.mul_apply, Fin.sum_univ_succ,
      Complex.I_mul_I] <;>
    ring_nf <;>
    simp <;>
    ring

/-- The quaternion matrix is unitary exactly on the unit three-sphere. -/
theorem quaternionSU2Matrix_unitary_iff_unitSphere
    (a b c d : ℝ) :
    (quaternionSU2Matrix a b c d).conjTranspose *
        quaternionSU2Matrix a b c d = 1 ↔
      quaternionCoeffNormSq a b c d = 1 := by
  rw [quaternionSU2Matrix_conjTranspose_mul]
  constructor
  · intro h
    have h00 := congrArg (fun M => M 0 0) h
    simpa using h00
  · intro h
    rw [h]
    simp

/-- Determinant one is the same unit-sphere equation in these coordinates. -/
theorem quaternionSU2Matrix_det_one_iff_unitSphere
    (a b c d : ℝ) :
    Matrix.det (quaternionSU2Matrix a b c d) = 1 ↔
      quaternionCoeffNormSq a b c d = 1 := by
  rw [quaternionSU2Matrix_det]
  exact_mod_cast Iff.rfl

/-- Hence the standard `SU(2)` conditions select exactly the unit `S^3` in
coefficient space, fixing the radius that controls its round volume. -/
theorem quaternionSU2Matrix_specialUnitary_iff_unitSphere
    (a b c d : ℝ) :
    ((quaternionSU2Matrix a b c d).conjTranspose *
          quaternionSU2Matrix a b c d = 1 ∧
        Matrix.det (quaternionSU2Matrix a b c d) = 1) ↔
      quaternionCoeffNormSq a b c d = 1 := by
  rw [quaternionSU2Matrix_unitary_iff_unitSphere,
    quaternionSU2Matrix_det_one_iff_unitSphere]
  tauto

/-- The three Pauli directions are coordinate-unit points of this same
unit-three-sphere after multiplication by `i`. -/
theorem quaternionAxes_are_iPauli :
    quaternionSU2Matrix 0 1 0 0 = Complex.I • pauliZ ∧
    quaternionSU2Matrix 0 0 1 0 = Complex.I • pauliY ∧
    quaternionSU2Matrix 0 0 0 1 = Complex.I • pauliX := by
  constructor
  · ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [quaternionSU2Matrix, pauliZ]
  constructor
  · ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [quaternionSU2Matrix, pauliY, Complex.I_mul_I]
  · ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [quaternionSU2Matrix, pauliX]

/-- Antipodal coefficient vectors give opposite spin-frame matrices. -/
theorem quaternionSU2Matrix_antipode
    (a b c d : ℝ) :
    quaternionSU2Matrix (-a) (-b) (-c) (-d) =
      -quaternionSU2Matrix a b c d := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [quaternionSU2Matrix] <;>
    ring

/-- The frame acts on qubit observables by conjugation. -/
noncomputable def quaternionFrameAction
    (a b c d : ℝ) (A : Matrix QubitIndex QubitIndex ℂ) :
    Matrix QubitIndex QubitIndex ℂ :=
  quaternionSU2Matrix a b c d * A *
    (quaternionSU2Matrix a b c d).conjTranspose

/-- The antipodal pair acts identically on observables.  This is the exact
algebraic `+-1` quotient behind the projective rotation frame. -/
theorem quaternionFrameAction_antipode
    (a b c d : ℝ) (A : Matrix QubitIndex QubitIndex ℂ) :
    quaternionFrameAction (-a) (-b) (-c) (-d) A =
      quaternionFrameAction a b c d A := by
  rw [quaternionFrameAction, quaternionFrameAction,
    quaternionSU2Matrix_antipode]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.conjTranspose, Matrix.mul_apply, Fin.sum_univ_succ] <;>
    ring

/-- Capstone: `+-1` observable normalization fixes an orthonormal three-axis
frame, the associated special-unitary cover is the unit `S^3`, and its round
surface and numerical projective half-volume are `2*pi^2` and `pi^2`. -/
theorem pauliFrame_unitSphere_projectiveVolume_capstone :
    (∀ j : Fin 3, pauliAxis j * pauliAxis j = 1) ∧
    (∀ j k : Fin 3,
      pauliHalfTracePair (pauliAxis j) (pauliAxis k) =
        if j = k then 1 else 0) ∧
    (∀ a b c d : ℝ,
      ((quaternionSU2Matrix a b c d).conjTranspose *
            quaternionSU2Matrix a b c d = 1 ∧
          Matrix.det (quaternionSU2Matrix a b c d) = 1) ↔
        quaternionCoeffNormSq a b c d = 1) ∧
    (MeasureTheory.volume :
      MeasureTheory.Measure (EuclideanSpace ℝ (Fin 4))).toSphere
        Set.univ = ENNReal.ofReal (2 * Real.pi ^ 2) ∧
    projectiveBoundaryVolume = Real.pi ^ 2 := by
  exact ⟨pauliAxis_sq, pauliAxes_halfTrace_orthonormal,
    quaternionSU2Matrix_specialUnitary_iff_unitSphere,
    unitS3_surfaceMeasure, projectiveBoundaryVolume_eq_pi_sq⟩

#print axioms GravityScreening.pauliAxis_sq
#print axioms GravityScreening.pauliAxes_halfTrace_orthonormal
#print axioms GravityScreening.quaternionSU2Matrix_specialUnitary_iff_unitSphere
#print axioms GravityScreening.quaternionAxes_are_iPauli
#print axioms GravityScreening.quaternionFrameAction_antipode
#print axioms GravityScreening.pauliFrame_unitSphere_projectiveVolume_capstone

end

end GravityScreening
