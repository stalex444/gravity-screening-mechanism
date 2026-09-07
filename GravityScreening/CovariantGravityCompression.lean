import GravityScreening.DoubledSpinTwoOperator
import GravityScreening.SourcedTTHamiltonianAction

/-!
# Covariant compression of the linear gravity mechanism

The complete linearized Einstein/Pauli--Fierz operator is one covariant
rank-two tensor equation.  Its temporal components contain the constraints
and its spatial transverse-traceless components contain the propagating
graviton.  Applying the constant quartic two-channel block to this one
operator therefore treats both sectors at once.

This file instantiates the general doubled-operator reduction with the actual
Lorentz-signature Pauli--Fierz Fourier symbol.  The long component audit then
compresses to the two-line elimination of a source-free partner.
-/

namespace GravityScreening

/-- Covariant rank-two tensors at one four-momentum. -/
abbrev LorentzRankTwoTensor := Matrix FlatIndex FlatIndex ℝ

/-- The unit-normalized Lorentz-signature Pauli--Fierz symbol. -/
noncomputable def unitLorentzPauliFierzSymbol
    (k : FlatIndex → ℝ) (h : LorentzRankTwoTensor) :
    LorentzRankTwoTensor :=
  fun mu nu => lorentzPauliFierzSymbol 1 (-2) 1 1 (-1) k h mu nu

theorem lorentzTensorTrace_add
    (h g : LorentzRankTwoTensor) :
    lorentzTensorTrace (h + g) =
      lorentzTensorTrace h + lorentzTensorTrace g := by
  unfold lorentzTensorTrace
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  change minkowskiSign i * (h i i + g i i) =
    minkowskiSign i * h i i + minkowskiSign i * g i i
  ring

theorem lorentzTensorTrace_smul
    (a : ℝ) (h : LorentzRankTwoTensor) :
    lorentzTensorTrace (a • h) = a * lorentzTensorTrace h := by
  unfold lorentzTensorTrace
  change (∑ i, minkowskiSign i * (a * h i i)) =
    a * ∑ i, minkowskiSign i * h i i
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem lorentzTensorDivergence_add
    (k : FlatIndex → ℝ) (h g : LorentzRankTwoTensor) (nu : FlatIndex) :
    lorentzTensorDivergence k (h + g) nu =
      lorentzTensorDivergence k h nu +
        lorentzTensorDivergence k g nu := by
  unfold lorentzTensorDivergence
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  change lorentzRaisedMomentum k i * (h i nu + g i nu) =
    lorentzRaisedMomentum k i * h i nu +
      lorentzRaisedMomentum k i * g i nu
  ring

theorem lorentzTensorDivergence_smul
    (a : ℝ) (k : FlatIndex → ℝ)
    (h : LorentzRankTwoTensor) (nu : FlatIndex) :
    lorentzTensorDivergence k (a • h) nu =
      a * lorentzTensorDivergence k h nu := by
  unfold lorentzTensorDivergence
  change (∑ i, lorentzRaisedMomentum k i * (a * h i nu)) =
    a * ∑ i, lorentzRaisedMomentum k i * h i nu
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem lorentzTensorReverseDivergence_add
    (k : FlatIndex → ℝ) (h g : LorentzRankTwoTensor) (mu : FlatIndex) :
    lorentzTensorReverseDivergence k (h + g) mu =
      lorentzTensorReverseDivergence k h mu +
        lorentzTensorReverseDivergence k g mu := by
  unfold lorentzTensorReverseDivergence
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  change lorentzRaisedMomentum k i * (h mu i + g mu i) =
    lorentzRaisedMomentum k i * h mu i +
      lorentzRaisedMomentum k i * g mu i
  ring

theorem lorentzTensorReverseDivergence_smul
    (a : ℝ) (k : FlatIndex → ℝ)
    (h : LorentzRankTwoTensor) (mu : FlatIndex) :
    lorentzTensorReverseDivergence k (a • h) mu =
      a * lorentzTensorReverseDivergence k h mu := by
  unfold lorentzTensorReverseDivergence
  change (∑ i, lorentzRaisedMomentum k i * (a * h mu i)) =
    a * ∑ i, lorentzRaisedMomentum k i * h mu i
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem lorentzTensorDoubleDivergence_add
    (k : FlatIndex → ℝ) (h g : LorentzRankTwoTensor) :
    lorentzTensorDoubleDivergence k (h + g) =
      lorentzTensorDoubleDivergence k h +
        lorentzTensorDoubleDivergence k g := by
  unfold lorentzTensorDoubleDivergence
  simp_rw [lorentzTensorReverseDivergence_add]
  simp [Finset.sum_add_distrib, mul_add]

theorem lorentzTensorDoubleDivergence_smul
    (a : ℝ) (k : FlatIndex → ℝ) (h : LorentzRankTwoTensor) :
    lorentzTensorDoubleDivergence k (a • h) =
      a * lorentzTensorDoubleDivergence k h := by
  unfold lorentzTensorDoubleDivergence
  simp_rw [lorentzTensorReverseDivergence_smul]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  ring

/-- The unit Pauli--Fierz symbol is linear in the metric perturbation. -/
noncomputable def unitLorentzPauliFierzLinearMap
    (k : FlatIndex → ℝ) :
    LorentzRankTwoTensor →ₗ[ℝ] LorentzRankTwoTensor where
  toFun := unitLorentzPauliFierzSymbol k
  map_add' := by
    intro h g
    ext mu nu
    simp [unitLorentzPauliFierzSymbol, lorentzPauliFierzSymbol,
      lorentzTensorTrace_add, lorentzTensorDivergence_add,
      lorentzTensorReverseDivergence_add,
      lorentzTensorDoubleDivergence_add]
    ring
  map_smul' := by
    intro a h
    ext mu nu
    simp [unitLorentzPauliFierzSymbol, lorentzPauliFierzSymbol,
      lorentzTensorTrace_smul, lorentzTensorDivergence_smul,
      lorentzTensorReverseDivergence_smul,
      lorentzTensorDoubleDivergence_smul]
    ring

/-- The unit-normalized symbol satisfies the full Lorentz Ward identity. -/
theorem unitLorentzPauliFierz_hasWardIdentity :
    HasLorentzSpinTwoWardIdentity 1 (-2) 1 1 (-1) := by
  intro k h _hsymmetric nu
  rw [lorentzPauliFierzSymbolDivergence_decomposition]
  ring

/-- Simple covariant gravity theorem.  The two quartic equations for the
actual Lorentz Pauli--Fierz symbol are equivalent to one screened sourced
Pauli--Fierz equation plus the constitutive partner relation.  Every tensor
component is covered by this single equivalence. -/
theorem quarticCovariantPauliFierz_sourceReduction
    (q : ℝ) (k : FlatIndex → ℝ)
    (h partner source : LorentzRankTwoTensor) (hq : q ≠ 0) :
    (doubledOperatorElectric (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = source ∧
        doubledOperatorMagnetic (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = 0) ↔
      (((2 * q - 1) / q ^ 2) •
          unitLorentzPauliFierzSymbol k h = source ∧
        unitLorentzPauliFierzSymbol k partner =
          lambda4 q • unitLorentzPauliFierzSymbol k h) := by
  exact quartic_doubledLinearOperator_sourceReduction q
    (unitLorentzPauliFierzLinearMap k) h partner source hq

/-- Pointwise form of the same theorem.  In particular the `00`, `0i`, and
`ij` equations all carry the identical coefficient. -/
theorem quarticCovariantPauliFierz_componentwise_sourceReduction
    (q : ℝ) (k : FlatIndex → ℝ)
    (h partner source : LorentzRankTwoTensor) (hq : q ≠ 0) :
    (doubledOperatorElectric (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = source ∧
        doubledOperatorMagnetic (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = 0) ↔
      ((∀ mu nu,
          ((2 * q - 1) / q ^ 2) *
              unitLorentzPauliFierzSymbol k h mu nu = source mu nu) ∧
        (∀ mu nu,
          unitLorentzPauliFierzSymbol k partner mu nu =
            lambda4 q * unitLorentzPauliFierzSymbol k h mu nu)) := by
  rw [quarticCovariantPauliFierz_sourceReduction q k h partner source hq]
  constructor
  · rintro ⟨helectric, hpartner⟩
    constructor
    · intro mu nu
      exact congrFun (congrFun helectric mu) nu
    · intro mu nu
      exact congrFun (congrFun hpartner mu) nu
  · rintro ⟨helectric, hpartner⟩
    constructor
    · funext mu nu
      exact helectric mu nu
    · funext mu nu
      exact hpartner mu nu

/-- In the positive quartic regime, the sourced Pauli--Fierz outputs are
unique.  The fields themselves remain defined only modulo homogeneous and
gauge-kernel solutions, exactly as in ordinary linearized gravity. -/
theorem quarticCovariantPauliFierz_outputs_unique
    (q : ℝ) (k : FlatIndex → ℝ)
    (h partner source : LorentzRankTwoTensor) (hq : 1 < q) :
    (doubledOperatorElectric (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = source ∧
        doubledOperatorMagnetic (lambda4 q)
          (unitLorentzPauliFierzLinearMap k) h partner = 0) ↔
      (unitLorentzPauliFierzSymbol k h =
          (1 / ((2 * q - 1) / q ^ 2)) • source ∧
        unitLorentzPauliFierzSymbol k partner =
          lambda4 q •
            ((1 / ((2 * q - 1) / q ^ 2)) • source)) := by
  have hq0 : q ≠ 0 := by linarith
  have hs0 : (2 * q - 1) / q ^ 2 ≠ 0 := by
    rw [← quartic_screening_identity q hq0]
    exact ne_of_gt (quarticScreening_pos q hq)
  rw [quarticCovariantPauliFierz_sourceReduction q k h partner source hq0]
  constructor
  · rintro ⟨helectric, hpartner⟩
    have helectric' :
        unitLorentzPauliFierzSymbol k h =
          (1 / ((2 * q - 1) / q ^ 2)) • source := by
      rw [← helectric]
      rw [smul_smul, one_div_mul_cancel hs0, one_smul]
    constructor
    · exact helectric'
    · rw [hpartner, helectric']
  · rintro ⟨helectric, hpartner⟩
    constructor
    · rw [helectric, smul_smul]
      rw [mul_one_div_cancel hs0, one_smul]
    · rw [helectric, hpartner]

/-- Any source produced by the reduced unit Pauli--Fierz equation is
automatically conserved.  This is the source-side content of the gravitational
Ward identity. -/
theorem quarticCovariantPauliFierz_sourceConserved
    (q : ℝ) (k : FlatIndex → ℝ)
    (h source : LorentzRankTwoTensor) (hsymmetric : IsSymmetricFlatTensor h)
    (hsource :
      ((2 * q - 1) / q ^ 2) •
        unitLorentzPauliFierzSymbol k h = source) :
    ∀ nu,
      (∑ mu, lorentzRaisedMomentum k mu * source mu nu) = 0 := by
  intro nu
  have hward := unitLorentzPauliFierz_hasWardIdentity
    k h hsymmetric nu
  unfold lorentzPauliFierzSymbolDivergence at hward
  calc
    (∑ mu, lorentzRaisedMomentum k mu * source mu nu) =
        ∑ mu, lorentzRaisedMomentum k mu *
          ((((2 * q - 1) / q ^ 2) •
            unitLorentzPauliFierzSymbol k h) mu nu) := by
              congr 1
              funext mu
              rw [hsource]
    _ = ((2 * q - 1) / q ^ 2) *
        (∑ mu, lorentzRaisedMomentum k mu *
          unitLorentzPauliFierzSymbol k h mu nu) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro mu _
            simp
            ring
    _ = 0 := by
      rw [show (∑ mu, lorentzRaisedMomentum k mu *
          unitLorentzPauliFierzSymbol k h mu nu) = 0 by
        simpa [unitLorentzPauliFierzSymbol] using hward]
      ring

/-- The compressed covariant equation has exactly the same quartic coefficient
as the fixed-mode TT-plus-constraint Hamiltonian reduction. -/
theorem covariant_and_hamiltonian_reductions_same_coefficient
    (q : ℝ) (hq : q ≠ 0) :
    screening (lambda4 q) = (2 * q - 1) / q ^ 2 :=
  quartic_screening_identity q hq

#print axioms GravityScreening.unitLorentzPauliFierz_hasWardIdentity
#print axioms GravityScreening.quarticCovariantPauliFierz_sourceReduction
#print axioms GravityScreening.quarticCovariantPauliFierz_componentwise_sourceReduction
#print axioms GravityScreening.quarticCovariantPauliFierz_outputs_unique
#print axioms GravityScreening.quarticCovariantPauliFierz_sourceConserved
#print axioms GravityScreening.covariant_and_hamiltonian_reductions_same_coefficient

end GravityScreening
