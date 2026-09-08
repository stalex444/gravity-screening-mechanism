import GravityScreening.LQGHorizonThermodynamics

/-!
# The quartic Perron carrier is dynamical, not a static area observable

The full quartic inverse-step residual is directed and non-self-adjoint.  A
faithful representation preserving the real adjoint therefore cannot identify
it with a self-adjoint horizon observable.  Its left/right Perron compression,
however, is the scalar `lambda4`, which enters the symmetric two-channel
constitutive block with determinant `screening lambda4`.

This file proves that division of roles.  Calling a particular representation
an LQG horizon representation remains a physical identification.
-/

namespace GravityScreening

/-- The quartic residual is not self-adjoint in the standard real matrix
adjoint. -/
theorem quarticResidual_not_selfAdjoint :
    quarticResidual.transpose ≠ quarticResidual := by
  intro h
  have hij := congrArg (fun M => M 0 1) h
  norm_num [quarticResidual, Matrix.transpose_apply] at hij

/-- The full directed residual cannot equal any self-adjoint four-state
observable. -/
theorem quarticResidual_ne_selfAdjointMatrix
    (A : Matrix (Fin 4) (Fin 4) ℝ)
    (hA : A.transpose = A) :
    quarticResidual ≠ A := by
  intro h
  apply quarticResidual_not_selfAdjoint
  rw [h, hA]

/-- Representation-level obstruction.  Any injective map that preserves the
real adjoint carries the quartic residual to a non-self-adjoint operator.  This
models the minimum algebraic properties of a faithful star representation. -/
theorem quarticResidual_image_not_selfAdjoint
    {n : ℕ}
    (f : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hinjective : Function.Injective f)
    (hadjoint : ∀ A, f A.transpose = (f A).transpose) :
    (f quarticResidual).transpose ≠ f quarticResidual := by
  intro hself
  apply quarticResidual_not_selfAdjoint
  apply hinjective
  rw [hadjoint]
  exact hself

/-- The symmetric observable response obtained after left/right Perron
compression. -/
noncomputable def perronCompressedConstitutiveBlock
    (q : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  constitutiveBlock (quarticBiResidualCoefficient q)

/-- Unlike the full directed residual, the compressed response block is
self-adjoint. -/
theorem perronCompressedConstitutiveBlock_selfAdjoint
    (q : ℝ) :
    (perronCompressedConstitutiveBlock q).transpose =
      perronCompressedConstitutiveBlock q := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [perronCompressedConstitutiveBlock, constitutiveBlock,
      Matrix.transpose_apply]

/-- On the quartic root, the compressed observable determinant is exactly the
PDT screening coefficient. -/
theorem perronCompressedConstitutiveBlock_det
    (q : ℝ) (hq : q ^ 4 = q + 1) (hq1 : 1 < q) :
    Matrix.det (perronCompressedConstitutiveBlock q) =
      screening (lambda4 q) := by
  unfold perronCompressedConstitutiveBlock
  rw [constitutiveBlock_det,
    quarticBiResidualCoefficient_eq_lambda4 q hq hq1]

/-- Complete carrier classification.  The directed four-state operator is
neither self-adjoint nor normal, and no nondegenerate diagonal change of
information metric makes it self-adjoint.  Nevertheless its canonical
left/right Perron compression is the scalar `lambda4`, and that scalar defines
the symmetric two-channel response whose determinant is `S_Q`. -/
theorem quarticPerron_carrier_classification
    (q : ℝ) (hq : q ^ 4 = q + 1) (hq1 : 1 < q) :
    quarticResidual.transpose ≠ quarticResidual ∧
      quarticResidual.transpose * quarticResidual ≠
        quarticResidual * quarticResidual.transpose ∧
      (∀ w₀ w₁ w₂ w₃ : ℝ, w₀ ≠ 0 →
        diagonalWeight4 w₀ w₁ w₂ w₃ * quarticResidual ≠
          quarticResidual.transpose * diagonalWeight4 w₀ w₁ w₂ w₃) ∧
      quarticBiResidualCoefficient q = lambda4 q ∧
      (perronCompressedConstitutiveBlock q).transpose =
        perronCompressedConstitutiveBlock q ∧
      Matrix.det (perronCompressedConstitutiveBlock q) =
        (2 * q - 1) / q ^ 2 := by
  have hq0 : q ≠ 0 := by linarith
  refine ⟨quarticResidual_not_selfAdjoint,
    quarticResidual_not_normal, ?_,
    quarticBiResidualCoefficient_eq_lambda4 q hq hq1,
    perronCompressedConstitutiveBlock_selfAdjoint q, ?_⟩
  · intro w₀ w₁ w₂ w₃ hw₀
    exact quarticResidual_no_diagonal_symmetrizer w₀ w₁ w₂ w₃ hw₀
  · rw [perronCompressedConstitutiveBlock_det q hq hq1,
      quartic_screening_identity q hq0]

/-- Dynamics-to-observable capstone.  The full quartic operator cannot become
a static self-adjoint observable under a faithful adjoint-preserving map, while
its canonical biorthogonal compression gives the self-adjoint response with
determinant `S_Q`. -/
theorem quarticPerron_dynamics_observable_capstone
    (q : ℝ) (hq : q ^ 4 = q + 1) (hq1 : 1 < q) :
    quarticResidual.transpose ≠ quarticResidual ∧
      quarticBiResidualCoefficient q = lambda4 q ∧
      (perronCompressedConstitutiveBlock q).transpose =
        perronCompressedConstitutiveBlock q ∧
      Matrix.det (perronCompressedConstitutiveBlock q) =
        (2 * q - 1) / q ^ 2 := by
  have hq0 : q ≠ 0 := by linarith
  refine ⟨quarticResidual_not_selfAdjoint,
    quarticBiResidualCoefficient_eq_lambda4 q hq hq1,
    perronCompressedConstitutiveBlock_selfAdjoint q, ?_⟩
  rw [perronCompressedConstitutiveBlock_det q hq hq1,
    quartic_screening_identity q hq0]

#print axioms GravityScreening.quarticResidual_not_selfAdjoint
#print axioms GravityScreening.quarticResidual_ne_selfAdjointMatrix
#print axioms GravityScreening.quarticResidual_image_not_selfAdjoint
#print axioms GravityScreening.perronCompressedConstitutiveBlock_selfAdjoint
#print axioms GravityScreening.perronCompressedConstitutiveBlock_det
#print axioms GravityScreening.quarticPerron_carrier_classification
#print axioms GravityScreening.quarticPerron_dynamics_observable_capstone

end GravityScreening
