import GravityScreening.TTConstraintSourceClosure

/-!
# One fixed-mode Hamiltonian action for TT propagation and sourced constraints

The duality-symmetric Hamiltonian action has eight multipliers: an electric
and magnetic copy of the lapse and three shifts.  This file adjoins those
multiplier terms to the quartic exterior TT prepotential Lagrangian.  Varying
the multipliers gives all eight constraint equations, and substituting the
canonical pure-electric-source solution leaves exactly the exterior action
with coefficient `S_Q`.

This is a finite-mode Hamiltonian assembly.  Identifying the four abstract
constraint values with the spatial differential expressions in the complete
local Barnich--Troessaert fields remains a separate field-theory step.
-/

namespace GravityScreening

/-- Electric residuals of the four sourced constraint equations. -/
noncomputable def quarticElectricConstraintResidual
    (q : ℝ)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ) :
    PauliFierzConstraintLabel → ℝ :=
  fun i => electricConstraintResponse (lambda4 q)
    (electric i) (magnetic i) - source i

/-- Magnetic residuals.  Their external source is exactly zero. -/
noncomputable def quarticMagneticConstraintResidual
    (q : ℝ)
    (electric magnetic : PauliFierzConstraintLabel → ℝ) :
    PauliFierzConstraintLabel → ℝ :=
  fun i => magneticConstraintResponse (lambda4 q)
    (electric i) (magnetic i)

/-- The eight lapse/shift multiplier terms, written as the two dot products
of the multiplier doublet with the constraint residual doublet. -/
noncomputable def quarticConstraintMultiplierLagrangian
    (q : ℝ)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ) : ℝ :=
  dotProduct
      (quarticElectricConstraintResidual q electric magnetic source)
      electricMultiplier +
    dotProduct
      (quarticMagneticConstraintResidual q electric magnetic)
      magneticMultiplier

/-- Exact affine variation in all eight multiplier directions. -/
theorem quarticConstraintMultiplierLagrangian_vary
    (q t : ℝ)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier
      electricVariation magneticVariation :
      PauliFierzConstraintLabel → ℝ) :
    quarticConstraintMultiplierLagrangian q electric magnetic source
        (electricMultiplier + t • electricVariation)
        (magneticMultiplier + t • magneticVariation) =
      quarticConstraintMultiplierLagrangian q electric magnetic source
          electricMultiplier magneticMultiplier +
        t * quarticConstraintMultiplierLagrangian q electric magnetic source
          electricVariation magneticVariation := by
  unfold quarticConstraintMultiplierLagrangian
  rw [dotProduct_add, dotProduct_add]
  rw [dotProduct_smul, dotProduct_smul]
  ring

/-- Stationarity in all eight independent multiplier directions is equivalent
to the four electric source equations and four zero magnetic source equations. -/
theorem quarticConstraintMultipliers_stationary_iff
    (q : ℝ)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ) :
    (∀ electricVariation magneticVariation :
        PauliFierzConstraintLabel → ℝ,
      quarticConstraintMultiplierLagrangian q electric magnetic source
        electricVariation magneticVariation = 0) ↔
      (∀ i,
        electricConstraintResponse (lambda4 q)
            (electric i) (magnetic i) = source i ∧
          magneticConstraintResponse (lambda4 q)
            (electric i) (magnetic i) = 0) := by
  constructor
  · intro h
    have hezero :
        quarticElectricConstraintResidual q electric magnetic source = 0 := by
      apply dotProduct_eq_zero
      intro variation
      have hv := h variation 0
      simpa [quarticConstraintMultiplierLagrangian] using hv
    have hmzero :
        quarticMagneticConstraintResidual q electric magnetic = 0 := by
      apply dotProduct_eq_zero
      intro variation
      have hv := h 0 variation
      simpa [quarticConstraintMultiplierLagrangian] using hv
    intro i
    constructor
    · have hi := congrFun hezero i
      exact sub_eq_zero.mp (by
        simpa [quarticElectricConstraintResidual] using hi)
    · have hi := congrFun hmzero i
      simpa [quarticMagneticConstraintResidual] using hi
  · intro h electricVariation magneticVariation
    have hezero :
        quarticElectricConstraintResidual q electric magnetic source = 0 := by
      funext i
      simp [quarticElectricConstraintResidual, (h i).1]
    have hmzero :
        quarticMagneticConstraintResidual q electric magnetic = 0 := by
      funext i
      simp [quarticMagneticConstraintResidual, (h i).2]
    simp [quarticConstraintMultiplierLagrangian, hezero, hmzero]

/-- A single fixed-mode Hamiltonian Lagrangian containing the retained TT
prepotential dynamics and all eight sourced constraint multiplier terms. -/
noncomputable def quarticSourcedTTHamiltonianLagrangian
    (q k : ℝ) (H Hdot : TTPrepotentialMode)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ) : ℝ :=
  exteriorTTPrepotentialLagrangian k
      (dilateTTPrepotentialMode (screening (lambda4 q)) H)
      (dilateTTPrepotentialMode (screening (lambda4 q)) Hdot) +
    quarticConstraintMultiplierLagrangian q electric magnetic source
      electricMultiplier magneticMultiplier

/-- Exact multiplier variation of the combined Hamiltonian action.  The
propagating TT term is untouched, so its multiplier Euler equations are
precisely the complete sourced constraint family. -/
theorem quarticSourcedTTHamiltonianLagrangian_varyMultipliers
    (q k t : ℝ) (H Hdot : TTPrepotentialMode)
    (electric magnetic source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier
      electricVariation magneticVariation :
      PauliFierzConstraintLabel → ℝ) :
    quarticSourcedTTHamiltonianLagrangian q k H Hdot
        electric magnetic source
        (electricMultiplier + t • electricVariation)
        (magneticMultiplier + t • magneticVariation) =
      quarticSourcedTTHamiltonianLagrangian q k H Hdot
          electric magnetic source electricMultiplier magneticMultiplier +
        t * quarticConstraintMultiplierLagrangian q electric magnetic source
          electricVariation magneticVariation := by
  unfold quarticSourcedTTHamiltonianLagrangian
  rw [quarticConstraintMultiplierLagrangian_vary]
  ring

/-- Eliminate only the zero-source partner equation.  Off shell in the
ordinary electric constraint, the magnetic multiplier disappears and each
electric multiplier couples to `S_Q * electric - source`. -/
theorem quarticConstraintMultiplier_afterPartnerReduction
    (q : ℝ)
    (electric source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ)
    (hq : q ≠ 0) :
    quarticConstraintMultiplierLagrangian q electric
        (fun i => lambda4 q * electric i) source
        electricMultiplier magneticMultiplier =
      dotProduct
        (fun i => ((2 * q - 1) / q ^ 2) * electric i - source i)
        electricMultiplier := by
  have helectric :
      quarticElectricConstraintResidual q electric
          (fun i => lambda4 q * electric i) source =
        fun i => screening (lambda4 q) * electric i - source i := by
    funext i
    simp [quarticElectricConstraintResidual, electricConstraintResponse,
      screening]
    ring
  have hmagnetic :
      quarticMagneticConstraintResidual q electric
          (fun i => lambda4 q * electric i) = 0 := by
    funext i
    simp [quarticMagneticConstraintResidual, magneticConstraintResponse]
  unfold quarticConstraintMultiplierLagrangian
  rw [helectric, hmagnetic, zero_dotProduct, add_zero]
  rw [quartic_screening_identity q hq]

/-- Off-shell placement theorem for the fixed-mode Hamiltonian action.  After
eliminating only the source-free partner equation, the same exact quartic
coefficient multiplies the TT prepotential action and every electric
lapse/shift constraint, while the independent magnetic multipliers drop out. -/
theorem quarticSourcedTTHamiltonian_afterPartnerReduction
    (q k : ℝ) (H Hdot : TTPrepotentialMode)
    (electric source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ)
    (hq : 1 < q) :
    quarticSourcedTTHamiltonianLagrangian q k H Hdot electric
        (fun i => lambda4 q * electric i) source
        electricMultiplier magneticMultiplier =
      ((2 * q - 1) / q ^ 2) *
          ttPrepotentialLagrangian k H Hdot +
        dotProduct
          (fun i => ((2 * q - 1) / q ^ 2) * electric i - source i)
          electricMultiplier := by
  have hq0 : q ≠ 0 := by linarith
  unfold quarticSourcedTTHamiltonianLagrangian
  rw [quarticConstraintMultiplier_afterPartnerReduction
    q electric source electricMultiplier magneticMultiplier hq0]
  rw [quarticDilatedTTPrepotential_exterior_lagrangian q k H Hdot hq]

/-- On the parameter-free canonical response, every multiplier residual
vanishes.  No lapse or shift multiplier can change the on-shell value. -/
theorem quarticCanonicalResponse_constraintMultiplier_vanishes
    (q : ℝ) (source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ)
    (hq : 1 < q) :
    quarticConstraintMultiplierLagrangian q
        (fun i => quarticFullConstraintResponse q source i 0)
        (fun i => quarticFullConstraintResponse q source i 1)
        source electricMultiplier magneticMultiplier = 0 := by
  apply (quarticConstraintMultipliers_stationary_iff q
    (fun i => quarticFullConstraintResponse q source i 0)
    (fun i => quarticFullConstraintResponse q source i 1) source).2
  intro i
  exact ⟨(quarticFullConstraintResponse_closure q source hq i).1,
    (quarticFullConstraintResponse_closure q source hq i).2.1⟩

/-- Fixed-mode sourced-action closure: solving all lapse/shift constraints
inside the same Hamiltonian action leaves exactly `S_Q` times the original TT
prepotential Lagrangian, for arbitrary values of the eight multipliers. -/
theorem quarticSourcedTTHamiltonian_onCanonicalResponse
    (q k : ℝ) (H Hdot : TTPrepotentialMode)
    (source : PauliFierzConstraintLabel → ℝ)
    (electricMultiplier magneticMultiplier :
      PauliFierzConstraintLabel → ℝ)
    (hq : 1 < q) :
    quarticSourcedTTHamiltonianLagrangian q k H Hdot
        (fun i => quarticFullConstraintResponse q source i 0)
        (fun i => quarticFullConstraintResponse q source i 1)
        source electricMultiplier magneticMultiplier =
      ((2 * q - 1) / q ^ 2) *
        ttPrepotentialLagrangian k H Hdot := by
  unfold quarticSourcedTTHamiltonianLagrangian
  rw [quarticCanonicalResponse_constraintMultiplier_vanishes
    q source electricMultiplier magneticMultiplier hq]
  rw [add_zero]
  exact quarticDilatedTTPrepotential_exterior_lagrangian q k H Hdot hq

#print axioms GravityScreening.quarticConstraintMultiplierLagrangian_vary
#print axioms GravityScreening.quarticConstraintMultipliers_stationary_iff
#print axioms GravityScreening.quarticSourcedTTHamiltonianLagrangian_varyMultipliers
#print axioms GravityScreening.quarticConstraintMultiplier_afterPartnerReduction
#print axioms GravityScreening.quarticSourcedTTHamiltonian_afterPartnerReduction
#print axioms GravityScreening.quarticCanonicalResponse_constraintMultiplier_vanishes
#print axioms GravityScreening.quarticSourcedTTHamiltonian_onCanonicalResponse

end GravityScreening
