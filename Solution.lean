import GravityScreening.PalomarCapstone

/-!
# Solution: Lorentz spin-two rigidity and screened source reduction

The independent Challenge surface repeats the displayed definitions using only
Mathlib. These transparent aliases expose the proved source declarations under
the comparison namespace.
-/

namespace LorentzSpinTwoScreening

noncomputable section

abbrev lambda4 := GravityScreening.lambda4
abbrev screening := GravityScreening.screening
abbrev FlatIndex := GravityScreening.FlatIndex
abbrev IsSymmetricFlatTensor := GravityScreening.IsSymmetricFlatTensor
abbrev minkowskiSign := GravityScreening.minkowskiSign
abbrev lorentzRaisedMomentum := GravityScreening.lorentzRaisedMomentum
abbrev lorentzMomentumSq := GravityScreening.lorentzMomentumSq
abbrev lorentzTensorTrace := GravityScreening.lorentzTensorTrace
abbrev lorentzTensorDivergence := GravityScreening.lorentzTensorDivergence
abbrev lorentzTensorReverseDivergence :=
  GravityScreening.lorentzTensorReverseDivergence
abbrev lorentzTensorDoubleDivergence :=
  GravityScreening.lorentzTensorDoubleDivergence
abbrev minkowskiMetric := GravityScreening.minkowskiMetric
abbrev lorentzPauliFierzSymbol := GravityScreening.lorentzPauliFierzSymbol
abbrev lorentzPauliFierzSymbolDivergence :=
  GravityScreening.lorentzPauliFierzSymbolDivergence
abbrev HasLorentzSpinTwoWardIdentity :=
  GravityScreening.HasLorentzSpinTwoWardIdentity
abbrev lorentzSymbolPairing := GravityScreening.lorentzSymbolPairing
abbrev IsLorentzSpinTwoSymbolSelfAdjoint :=
  GravityScreening.IsLorentzSpinTwoSymbolSelfAdjoint

theorem lorentzPauliFierzSymbolDivergence_decomposition
    (a b c d e : ℝ)
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ)
    (nu : FlatIndex) :
    lorentzPauliFierzSymbolDivergence a b c d e k h nu =
      (a + b / 2) * lorentzMomentumSq k *
        lorentzTensorDivergence k h nu +
      (b / 2 + d) * k nu * lorentzTensorDoubleDivergence k h +
      (c + e) * k nu * lorentzMomentumSq k *
        lorentzTensorTrace h := by
  exact GravityScreening.lorentzPauliFierzSymbolDivergence_decomposition
    a b c d e k h nu

theorem lorentzSpinTwoWardIdentity_forces_relations
    (a b c d e : ℝ)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e) :
    a + b / 2 = 0 ∧ b / 2 + d = 0 ∧ c + e = 0 := by
  exact GravityScreening.lorentzSpinTwoWardIdentity_forces_relations
    a b c d e hward

theorem lorentzSpinTwoSelfAdjoint_forces_traceRelation
    (a b c d e : ℝ)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    c = d := by
  exact GravityScreening.lorentzSpinTwoSelfAdjoint_forces_traceRelation
    a b c d e hself

theorem lorentzPauliFierzSymbol_operatorProperties_unique
    (a b c d e : ℝ)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    b = -2 * a ∧ c = a ∧ d = a ∧ e = -a := by
  exact GravityScreening.lorentzPauliFierzSymbol_operatorProperties_unique
    a b c d e hward hself

theorem quartic_lorentzSymbolProperties_force_fullNormalization
    (q a b c d e : ℝ) (hq : q ≠ 0)
    (hwave : a = screening (lambda4 q))
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    a = (2 * q - 1) / q ^ 2 ∧
      b = -2 * ((2 * q - 1) / q ^ 2) ∧
      c = (2 * q - 1) / q ^ 2 ∧
      d = (2 * q - 1) / q ^ 2 ∧
      e = -((2 * q - 1) / q ^ 2) := by
  exact GravityScreening.quartic_lorentzSymbolProperties_force_fullNormalization
    q a b c d e hq hwave hward hself

theorem lorentzDoubledSpinTwo_sourceReduction
    (l a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h partner source : Matrix FlatIndex FlatIndex ℝ) :
    ((∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k h mu nu -
            l * lorentzPauliFierzSymbol a b c d e k partner mu nu =
          source mu nu) ∧
      (∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k partner mu nu -
            l * lorentzPauliFierzSymbol a b c d e k h mu nu = 0)) ↔
    ((∀ mu nu,
        screening l * lorentzPauliFierzSymbol a b c d e k h mu nu =
          source mu nu) ∧
      (∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k partner mu nu =
          l * lorentzPauliFierzSymbol a b c d e k h mu nu)) := by
  exact GravityScreening.lorentzDoubledSpinTwo_sourceReduction
    l a b c d e k h partner source

theorem quarticLorentzSpinTwo_rigidity_and_sourceReduction
    (q a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h partner source : Matrix FlatIndex FlatIndex ℝ)
    (hq : q ≠ 0)
    (hwave : a = screening (lambda4 q))
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    (a = (2 * q - 1) / q ^ 2 ∧
      b = -2 * ((2 * q - 1) / q ^ 2) ∧
      c = (2 * q - 1) / q ^ 2 ∧
      d = (2 * q - 1) / q ^ 2 ∧
      e = -((2 * q - 1) / q ^ 2)) ∧
    (((∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k h mu nu -
            lambda4 q *
              lorentzPauliFierzSymbol a b c d e k partner mu nu =
          source mu nu) ∧
      (∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k partner mu nu -
            lambda4 q *
              lorentzPauliFierzSymbol a b c d e k h mu nu = 0)) ↔
    ((∀ mu nu,
        ((2 * q - 1) / q ^ 2) *
            lorentzPauliFierzSymbol a b c d e k h mu nu =
          source mu nu) ∧
      (∀ mu nu,
        lorentzPauliFierzSymbol a b c d e k partner mu nu =
          lambda4 q *
            lorentzPauliFierzSymbol a b c d e k h mu nu))) := by
  exact GravityScreening.quarticLorentzSpinTwo_rigidity_and_sourceReduction
    q a b c d e k h partner source hq hwave hward hself

theorem lorentzPauliFierzSymbol_add
    (a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h g : Matrix FlatIndex FlatIndex ℝ) (mu nu : FlatIndex) :
    lorentzPauliFierzSymbol a b c d e k (h + g) mu nu =
      lorentzPauliFierzSymbol a b c d e k h mu nu +
        lorentzPauliFierzSymbol a b c d e k g mu nu := by
  exact GravityScreening.lorentzPauliFierzSymbol_add
    a b c d e k h g mu nu

theorem lorentzDoubledSpinTwo_gaugeInvariant
    (l a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h partner gaugeH gaugePartner : Matrix FlatIndex FlatIndex ℝ)
    (hgaugeH : ∀ mu nu,
      lorentzPauliFierzSymbol a b c d e k gaugeH mu nu = 0)
    (hgaugePartner : ∀ mu nu,
      lorentzPauliFierzSymbol a b c d e k gaugePartner mu nu = 0) :
    (∀ mu nu,
      lorentzPauliFierzSymbol a b c d e k (h + gaugeH) mu nu -
          l * lorentzPauliFierzSymbol a b c d e k
            (partner + gaugePartner) mu nu =
        lorentzPauliFierzSymbol a b c d e k h mu nu -
          l * lorentzPauliFierzSymbol a b c d e k partner mu nu) ∧
    (∀ mu nu,
      lorentzPauliFierzSymbol a b c d e k
          (partner + gaugePartner) mu nu -
          l * lorentzPauliFierzSymbol a b c d e k (h + gaugeH) mu nu =
        lorentzPauliFierzSymbol a b c d e k partner mu nu -
          l * lorentzPauliFierzSymbol a b c d e k h mu nu) := by
  exact GravityScreening.lorentzDoubledSpinTwo_gaugeInvariant
    l a b c d e k h partner gaugeH gaugePartner hgaugeH hgaugePartner

theorem lorentzScreenedSource_conserved
    (s a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h source : Matrix FlatIndex FlatIndex ℝ)
    (hsymmetric : IsSymmetricFlatTensor h)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hsource : ∀ mu nu,
      s * lorentzPauliFierzSymbol a b c d e k h mu nu = source mu nu) :
    ∀ nu, (∑ mu, lorentzRaisedMomentum k mu * source mu nu) = 0 := by
  exact GravityScreening.lorentzScreenedSource_conserved
    s a b c d e k h source hsymmetric hward hsource

end

end LorentzSpinTwoScreening

#print axioms LorentzSpinTwoScreening.lorentzPauliFierzSymbolDivergence_decomposition
#print axioms LorentzSpinTwoScreening.lorentzSpinTwoWardIdentity_forces_relations
#print axioms LorentzSpinTwoScreening.lorentzSpinTwoSelfAdjoint_forces_traceRelation
#print axioms LorentzSpinTwoScreening.lorentzPauliFierzSymbol_operatorProperties_unique
#print axioms LorentzSpinTwoScreening.quartic_lorentzSymbolProperties_force_fullNormalization
#print axioms LorentzSpinTwoScreening.lorentzDoubledSpinTwo_sourceReduction
#print axioms LorentzSpinTwoScreening.quarticLorentzSpinTwo_rigidity_and_sourceReduction
#print axioms LorentzSpinTwoScreening.lorentzPauliFierzSymbol_add
#print axioms LorentzSpinTwoScreening.lorentzDoubledSpinTwo_gaugeInvariant
#print axioms LorentzSpinTwoScreening.lorentzScreenedSource_conserved
