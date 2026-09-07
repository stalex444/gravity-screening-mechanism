import Mathlib

/-!
# Lorentz spin-two rigidity and screened source reduction

This challenge isolates a classification-and-reduction theorem for linear
massless spin-two systems in four-dimensional Minkowski space.

1. The divergence of the standard parity-even, local, two-derivative
   five-term symbol has exactly three Ward coefficients.
2. The Ward identity and formal self-adjointness force the Pauli--Fierz
   coefficient pattern up to one scale.
3. Fixing that scale to `1-(1-1/q)^2` forces the full rational normalization
   `(2*q-1)/q^2`.
4. A two-channel system with a source-free partner reduces, component by
   component, to one uniformly screened sourced equation.  The reduction
   does not invert the spin-two operator, so gauge-kernel shifts survive.
5. The Ward identity forces conservation of the resulting source.

The mathematical audience is linearized gravity, constrained field theory,
and formalized mathematical physics.  The motivating application identifies
`q` with a distinguished quartic algebraic unit and uses the coefficient as a
candidate effective gravitational response.  That physical identification,
including its relation to the undetermined horizon entropy density in
Jacobson's thermodynamic derivation of the Einstein equation, is deliberately
outside the compared theorem statements.
-/

namespace LorentzSpinTwoScreening

noncomputable section

/-- Quartic-sector retention coefficient. -/
def lambda4 (q : ℝ) : ℝ := 1 - 1 / q

/-- Surviving response after eliminating a linearly coupled partner. -/
def screening (l : ℝ) : ℝ := 1 - l ^ 2

abbrev FlatIndex := Fin 4

/-- Symmetry predicate for covariant rank-two tensors. -/
def IsSymmetricFlatTensor (h : Matrix FlatIndex FlatIndex ℝ) : Prop :=
  ∀ i j, h i j = h j i

/-- Diagonal signs of the Minkowski metric. -/
def minkowskiSign : FlatIndex → ℝ := ![-1, 1, 1, 1]

/-- Raised momentum components. -/
def lorentzRaisedMomentum (k : FlatIndex → ℝ) (mu : FlatIndex) : ℝ :=
  minkowskiSign mu * k mu

/-- Lorentzian momentum square. -/
def lorentzMomentumSq (k : FlatIndex → ℝ) : ℝ :=
  ∑ mu, lorentzRaisedMomentum k mu * k mu

/-- Lorentzian tensor trace. -/
def lorentzTensorTrace (h : Matrix FlatIndex FlatIndex ℝ) : ℝ :=
  ∑ mu, minkowskiSign mu * h mu mu

/-- Divergence on the first tensor index. -/
def lorentzTensorDivergence
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ)
    (nu : FlatIndex) : ℝ :=
  ∑ rho, lorentzRaisedMomentum k rho * h rho nu

/-- Divergence on the second tensor index. -/
def lorentzTensorReverseDivergence
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ)
    (mu : FlatIndex) : ℝ :=
  ∑ rho, lorentzRaisedMomentum k rho * h mu rho

/-- Lorentzian double divergence. -/
def lorentzTensorDoubleDivergence
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ) : ℝ :=
  ∑ mu, lorentzRaisedMomentum k mu *
    lorentzTensorReverseDivergence k h mu

/-- Covariant Minkowski metric components in the diagonal frame. -/
def minkowskiMetric (mu nu : FlatIndex) : ℝ :=
  if mu = nu then minkowskiSign mu else 0

/-- Standard parity-even, local, two-derivative five-term Fourier symbol on a
covariant rank-two field. -/
def lorentzPauliFierzSymbol
    (a b c d e : ℝ)
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ)
    (mu nu : FlatIndex) : ℝ :=
  a * lorentzMomentumSq k * h mu nu +
    (b / 2) *
      (k mu * lorentzTensorDivergence k h nu +
        k nu * lorentzTensorReverseDivergence k h mu) +
    c * k mu * k nu * lorentzTensorTrace h +
    d * minkowskiMetric mu nu * lorentzTensorDoubleDivergence k h +
    e * minkowskiMetric mu nu * lorentzMomentumSq k *
      lorentzTensorTrace h

/-- Raised-index divergence of the Lorentzian symbol. -/
def lorentzPauliFierzSymbolDivergence
    (a b c d e : ℝ)
    (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ)
    (nu : FlatIndex) : ℝ :=
  ∑ mu, lorentzRaisedMomentum k mu *
    lorentzPauliFierzSymbol a b c d e k h mu nu

/-- Ward identity on all momenta and symmetric tensor polarizations. -/
def HasLorentzSpinTwoWardIdentity (a b c d e : ℝ) : Prop :=
  ∀ (k : FlatIndex → ℝ) (h : Matrix FlatIndex FlatIndex ℝ),
    IsSymmetricFlatTensor h →
      ∀ nu, lorentzPauliFierzSymbolDivergence a b c d e k h nu = 0

/-- Lorentz contraction of a tensor with an output tensor. -/
def lorentzSymbolPairing
    (g output : Matrix FlatIndex FlatIndex ℝ) : ℝ :=
  ∑ mu, ∑ nu,
    minkowskiSign mu * minkowskiSign nu * g mu nu * output mu nu

/-- Formal self-adjointness under the Lorentz tensor pairing. -/
def IsLorentzSpinTwoSymbolSelfAdjoint (a b c d e : ℝ) : Prop :=
  ∀ (k : FlatIndex → ℝ)
      (g h : Matrix FlatIndex FlatIndex ℝ),
    IsSymmetricFlatTensor g → IsSymmetricFlatTensor h →
      lorentzSymbolPairing g (fun mu nu =>
        lorentzPauliFierzSymbol a b c d e k h mu nu) =
      lorentzSymbolPairing h (fun mu nu =>
        lorentzPauliFierzSymbol a b c d e k g mu nu)

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
  sorry

theorem lorentzSpinTwoWardIdentity_forces_relations
    (a b c d e : ℝ)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e) :
    a + b / 2 = 0 ∧ b / 2 + d = 0 ∧ c + e = 0 := by
  sorry

theorem lorentzSpinTwoSelfAdjoint_forces_traceRelation
    (a b c d e : ℝ)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    c = d := by
  sorry

theorem lorentzPauliFierzSymbol_operatorProperties_unique
    (a b c d e : ℝ)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hself : IsLorentzSpinTwoSymbolSelfAdjoint a b c d e) :
    b = -2 * a ∧ c = a ∧ d = a ∧ e = -a := by
  sorry

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
  sorry

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
  sorry

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
  sorry

theorem lorentzPauliFierzSymbol_add
    (a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h g : Matrix FlatIndex FlatIndex ℝ) (mu nu : FlatIndex) :
    lorentzPauliFierzSymbol a b c d e k (h + g) mu nu =
      lorentzPauliFierzSymbol a b c d e k h mu nu +
        lorentzPauliFierzSymbol a b c d e k g mu nu := by
  sorry

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
  sorry

theorem lorentzScreenedSource_conserved
    (s a b c d e : ℝ) (k : FlatIndex → ℝ)
    (h source : Matrix FlatIndex FlatIndex ℝ)
    (hsymmetric : IsSymmetricFlatTensor h)
    (hward : HasLorentzSpinTwoWardIdentity a b c d e)
    (hsource : ∀ mu nu,
      s * lorentzPauliFierzSymbol a b c d e k h mu nu = source mu nu) :
    ∀ nu, (∑ mu, lorentzRaisedMomentum k mu * source mu nu) = 0 := by
  sorry

end

end LorentzSpinTwoScreening
