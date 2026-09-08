import GravityScreening.PauliFrameNormalization

/-!
# The Pauli adjoint action as an `SO(3)` observer rotation

The unit-quaternion matrix from `PauliFrameNormalization` acts on the real
Pauli three-space by conjugation.  This file computes that action exactly,
proves that its coefficient matrix lies in `SO(3)` on the unit sphere, and
proves that antipodal unit quaternions determine the same rotation.
-/

namespace GravityScreening

noncomputable section

open Matrix Complex

/-- A real Pauli vector in the quaternion-coordinate order `(Z,Y,X)` used by
`quaternionSU2Matrix`: the coefficients `(x,y,z)` correspond to the
quaternion imaginary axes `(b,c,d)`. -/
noncomputable def quaternionPauliVector (x y z : ℝ) :
    Matrix QubitIndex QubitIndex ℂ :=
  (x : ℂ) • pauliZ + (y : ℂ) • pauliY + (z : ℂ) • pauliX

/-- The coefficient matrix of conjugation by the quaternion matrix on the
real Pauli three-space, in the ordered basis `(Z,Y,X)`. -/
noncomputable def quaternionPauliRotation (a b c d : ℝ) :
    Matrix (Fin 3) (Fin 3) ℝ :=
  !![a^2 + b^2 - c^2 - d^2, 2*(b*c - a*d),       2*(b*d + a*c);
     2*(b*c + a*d),       a^2 - b^2 + c^2 - d^2, 2*(c*d - a*b);
     2*(b*d - a*c),       2*(c*d + a*b),       a^2 - b^2 - c^2 + d^2]

/-- Exact intertwining formula: matrix conjugation on Pauli observables is
the displayed real three-dimensional quaternion rotation. -/
theorem quaternionFrameAction_pauliVector
    (a b c d x y z : ℝ) :
    quaternionFrameAction a b c d (quaternionPauliVector x y z) =
      quaternionPauliVector
        ((a^2 + b^2 - c^2 - d^2) * x +
          2*(b*c - a*d) * y + 2*(b*d + a*c) * z)
        (2*(b*c + a*d) * x +
          (a^2 - b^2 + c^2 - d^2) * y + 2*(c*d - a*b) * z)
        (2*(b*d - a*c) * x + 2*(c*d + a*b) * y +
          (a^2 - b^2 - c^2 + d^2) * z) := by
  have hI2 : (Complex.I : ℂ) ^ 2 = -1 := by
    norm_num [pow_two, Complex.I_mul_I]
  have hI3 : (Complex.I : ℂ) ^ 3 = -Complex.I := by
    rw [show (3 : ℕ) = 2 + 1 by norm_num, pow_add, hI2]
    simp
  ext i j
  fin_cases i <;> fin_cases j
  all_goals
    norm_num [quaternionFrameAction, quaternionPauliVector,
      quaternionSU2Matrix,
      pauliX, pauliY, pauliZ, Matrix.conjTranspose,
      Matrix.mul_apply, Fin.sum_univ_succ, Complex.I_mul_I]
  all_goals ring_nf
  all_goals rw [hI2]
  all_goals try rw [hI3]
  all_goals ring

/-- Off the unit sphere, the quaternion action is conformally orthogonal;
its Gram factor is the fourth power of the coefficient radius. -/
theorem quaternionPauliRotation_transpose_mul
    (a b c d : ℝ) :
    (quaternionPauliRotation a b c d).transpose *
        quaternionPauliRotation a b c d =
      (quaternionCoeffNormSq a b c d)^2 •
        (1 : Matrix (Fin 3) (Fin 3) ℝ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [quaternionPauliRotation, quaternionCoeffNormSq,
      Matrix.mul_apply, Matrix.one_apply, Fin.sum_univ_succ] <;>
    ring

/-- The determinant of the three-dimensional action is the cube of the
quaternion coefficient norm squared. -/
theorem quaternionPauliRotation_det
    (a b c d : ℝ) :
    Matrix.det (quaternionPauliRotation a b c d) =
      (quaternionCoeffNormSq a b c d)^3 := by
  simp [quaternionPauliRotation, quaternionCoeffNormSq,
    Matrix.det_fin_three]
  ring

/-- A unit quaternion therefore determines an actual member of `SO(3)`. -/
theorem quaternionPauliRotation_mem_SO3
    (a b c d : ℝ)
    (hSphere : quaternionCoeffNormSq a b c d = 1) :
    quaternionPauliRotation a b c d ∈
      Matrix.specialOrthogonalGroup (Fin 3) ℝ := by
  rw [Matrix.mem_specialOrthogonalGroup_iff,
    Matrix.mem_orthogonalGroup_iff']
  constructor
  · rw [quaternionPauliRotation_transpose_mul, hSphere]
    norm_num
  · rw [quaternionPauliRotation_det, hSphere]
    norm_num

/-- Package the unit-quaternion action as an observer rotation. -/
noncomputable def unitQuaternionObserverRotation
    (a b c d : ℝ)
    (hSphere : quaternionCoeffNormSq a b c d = 1) :
    ObserverRotationGroup :=
  ⟨quaternionPauliRotation a b c d,
    quaternionPauliRotation_mem_SO3 a b c d hSphere⟩

/-- Antipodal unit quaternions determine the same `SO(3)` matrix. -/
theorem quaternionPauliRotation_antipode
    (a b c d : ℝ) :
    quaternionPauliRotation (-a) (-b) (-c) (-d) =
      quaternionPauliRotation a b c d := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [quaternionPauliRotation]

/-- The packaged observer rotation is likewise unchanged by the antipode. -/
theorem unitQuaternionObserverRotation_antipode
    (a b c d : ℝ)
    (hSphere : quaternionCoeffNormSq a b c d = 1) :
    unitQuaternionObserverRotation (-a) (-b) (-c) (-d)
        (by simpa [quaternionCoeffNormSq] using hSphere) =
      unitQuaternionObserverRotation a b c d hSphere := by
  apply Subtype.ext
  exact quaternionPauliRotation_antipode a b c d

/-- On the unit sphere, the identity observer rotation has exactly the two
spin-frame representatives `+I` and `-I`.  This proves the kernel of the
explicit adjoint map, without assuming the abstract double-cover theorem. -/
theorem quaternionPauliRotation_eq_one_iff
    (a b c d : ℝ)
    (hSphere : quaternionCoeffNormSq a b c d = 1) :
    quaternionPauliRotation a b c d = 1 ↔
      (a = 1 ∧ b = 0 ∧ c = 0 ∧ d = 0) ∨
      (a = -1 ∧ b = 0 ∧ c = 0 ∧ d = 0) := by
  constructor
  · intro hRotation
    unfold quaternionCoeffNormSq at hSphere
    have h00 := congrArg (fun M => M 0 0) hRotation
    have h11 := congrArg (fun M => M 1 1) hRotation
    norm_num [quaternionPauliRotation, Matrix.one_apply] at h00 h11
    have hcd : c ^ 2 + d ^ 2 = 0 := by
      nlinarith
    have hc : c = 0 := by
      nlinarith [sq_nonneg c, sq_nonneg d]
    have hd : d = 0 := by
      nlinarith [sq_nonneg c, sq_nonneg d]
    have hb : b = 0 := by
      nlinarith [sq_nonneg b]
    have haSq : a ^ 2 = 1 := by
      nlinarith
    rcases sq_eq_one_iff.mp haSq with ha | ha
    · exact Or.inl ⟨ha, hb, hc, hd⟩
    · exact Or.inr ⟨ha, hb, hc, hd⟩
  · rintro (⟨rfl, rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl, rfl⟩)
    all_goals
      ext i j
      fin_cases i <;> fin_cases j <;>
        norm_num [quaternionPauliRotation, Matrix.one_apply]

/-- Capstone: the same unit-sphere equation that characterizes the special
unitary Pauli frame gives an `SO(3)` observer rotation, and its antipodal
representative gives exactly the same action. -/
theorem pauliAdjoint_observerRotation_capstone
    (a b c d : ℝ)
    (hSU2 :
      (quaternionSU2Matrix a b c d).conjTranspose *
          quaternionSU2Matrix a b c d = 1 ∧
        Matrix.det (quaternionSU2Matrix a b c d) = 1) :
    quaternionPauliRotation a b c d ∈
        Matrix.specialOrthogonalGroup (Fin 3) ℝ ∧
      quaternionPauliRotation (-a) (-b) (-c) (-d) =
        quaternionPauliRotation a b c d := by
  have hSphere :=
    (quaternionSU2Matrix_specialUnitary_iff_unitSphere a b c d).1 hSU2
  exact ⟨quaternionPauliRotation_mem_SO3 a b c d hSphere,
    quaternionPauliRotation_antipode a b c d⟩

#print axioms GravityScreening.quaternionFrameAction_pauliVector
#print axioms GravityScreening.quaternionPauliRotation_transpose_mul
#print axioms GravityScreening.quaternionPauliRotation_det
#print axioms GravityScreening.quaternionPauliRotation_mem_SO3
#print axioms GravityScreening.unitQuaternionObserverRotation_antipode
#print axioms GravityScreening.quaternionPauliRotation_eq_one_iff
#print axioms GravityScreening.pauliAdjoint_observerRotation_capstone

end

end GravityScreening
