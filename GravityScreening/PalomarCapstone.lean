import GravityScreening.LorentzPauliFierzSymbol

/-!
# Lorentz spin-two rigidity and quartic source reduction

This file packages the two structural results used by the Palomar comparison
surface.  The Ward identity and formal self-adjointness leave only one overall
coefficient in the standard parity-even, local, two-derivative Lorentz symbol.
When that coefficient is the quartic retention weight, a source-free partner
channel can be eliminated componentwise without inverting the gauge operator.

The final theorem is a statement about a specified doubled linear spin-two
model.  Its application to physical gravity requires the additional physical
identification of the partner channel and its quartic coupling.
-/

namespace GravityScreening

private theorem palomar_lorentzTensorTrace_add
    (h g : Matrix FlatIndex FlatIndex ℝ) :
    lorentzTensorTrace (h + g) =
      lorentzTensorTrace h + lorentzTensorTrace g := by
  unfold lorentzTensorTrace
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  change minkowskiSign i * (h i i + g i i) =
    minkowskiSign i * h i i + minkowskiSign i * g i i
  ring

private theorem palomar_lorentzTensorDivergence_add
    (k : FlatIndex → ℝ) (h g : Matrix FlatIndex FlatIndex ℝ)
    (nu : FlatIndex) :
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

private theorem palomar_lorentzTensorReverseDivergence_add
    (k : FlatIndex → ℝ) (h g : Matrix FlatIndex FlatIndex ℝ)
    (mu : FlatIndex) :
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

private theorem palomar_lorentzTensorDoubleDivergence_add
    (k : FlatIndex → ℝ) (h g : Matrix FlatIndex FlatIndex ℝ) :
    lorentzTensorDoubleDivergence k (h + g) =
      lorentzTensorDoubleDivergence k h +
        lorentzTensorDoubleDivergence k g := by
  unfold lorentzTensorDoubleDivergence
  simp_rw [palomar_lorentzTensorReverseDivergence_add]
  simp [Finset.sum_add_distrib, mul_add]

/-- The two Lorentz spin-two channel equations reduce componentwise to one
screened sourced equation and a constitutive partner equation.  The statement
is written for the same five-coefficient symbol whose Ward and self-adjointness
properties force the Pauli--Fierz pattern. -/
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
  constructor
  · rintro ⟨helectric, hpartner⟩
    constructor
    · intro mu nu
      have hp := hpartner mu nu
      have he := helectric mu nu
      unfold screening
      linear_combination he + l * hp
    · intro mu nu
      have hp := hpartner mu nu
      linarith
  · rintro ⟨hreduced, hpartner⟩
    constructor
    · intro mu nu
      have hr := hreduced mu nu
      have hp := hpartner mu nu
      unfold screening at hr
      linear_combination hr - l * hp
    · intro mu nu
      have hp := hpartner mu nu
      linarith

/-- Capstone theorem.  On the standard Lorentz five-term ansatz, the Ward
identity, formal self-adjointness and a quartic wave coefficient force the
entire Pauli--Fierz pattern.  The corresponding doubled component equations
are then equivalent to a single uniformly screened source equation plus the
partner relation. -/
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
  constructor
  · exact quartic_lorentzSymbolProperties_force_fullNormalization
      q a b c d e hq hwave hward hself
  · rw [← quartic_screening_identity q hq]
    exact lorentzDoubledSpinTwo_sourceReduction
      (lambda4 q) a b c d e k h partner source

/-- The Lorentz five-term symbol is additive in its tensor argument. -/
theorem lorentzPauliFierzSymbol_add
    (a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h g : Matrix FlatIndex FlatIndex ℝ) (mu nu : FlatIndex) :
    lorentzPauliFierzSymbol a b c d e k (h + g) mu nu =
      lorentzPauliFierzSymbol a b c d e k h mu nu +
        lorentzPauliFierzSymbol a b c d e k g mu nu := by
  simp [lorentzPauliFierzSymbol, Matrix.add_apply,
    palomar_lorentzTensorTrace_add,
    palomar_lorentzTensorDivergence_add,
    palomar_lorentzTensorReverseDivergence_add,
    palomar_lorentzTensorDoubleDivergence_add]
  ring

/-- Gauge-kernel shifts of both tensor fields leave both doubled channel
equations unchanged.  No inverse or gauge fixing is used. -/
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
  constructor
  · intro mu nu
    rw [lorentzPauliFierzSymbol_add, lorentzPauliFierzSymbol_add,
      hgaugeH mu nu, hgaugePartner mu nu]
    ring
  · intro mu nu
    rw [lorentzPauliFierzSymbol_add, lorentzPauliFierzSymbol_add,
      hgaugeH mu nu, hgaugePartner mu nu]
    ring

/-- A source proportional to a Ward-compatible Lorentz spin-two output is
conserved.  This records the source-side consequence of the same identity
used in the coefficient classification. -/
theorem lorentzScreenedSource_conserved
    (s a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h source : Matrix FlatIndex FlatIndex ℝ)
    (hsymmetric : IsSymmetricFlatTensor h)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hsource : ∀ mu nu,
      s * lorentzPauliFierzSymbol a b c d e k h mu nu = source mu nu) :
    ∀ nu, (∑ mu, lorentzRaisedMomentum k mu * source mu nu) = 0 := by
  intro nu
  have hw := hward k h hsymmetric nu
  unfold lorentzPauliFierzSymbolDivergence at hw
  calc
    (∑ mu, lorentzRaisedMomentum k mu * source mu nu) =
        ∑ mu, lorentzRaisedMomentum k mu *
          (s * lorentzPauliFierzSymbol a b c d e k h mu nu) := by
            apply Finset.sum_congr rfl
            intro mu _
            rw [hsource]
    _ = s * (∑ mu, lorentzRaisedMomentum k mu *
          lorentzPauliFierzSymbol a b c d e k h mu nu) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro mu _
            ring
    _ = 0 := by rw [hw]; ring

#print axioms GravityScreening.lorentzDoubledSpinTwo_sourceReduction
#print axioms GravityScreening.quarticLorentzSpinTwo_rigidity_and_sourceReduction
#print axioms GravityScreening.lorentzPauliFierzSymbol_add
#print axioms GravityScreening.lorentzDoubledSpinTwo_gaugeInvariant
#print axioms GravityScreening.lorentzScreenedSource_conserved

end GravityScreening
