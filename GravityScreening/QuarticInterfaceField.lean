import GravityScreening.HorizonInterfaceCayley
import GravityScreening.QuarticResponseIrreducibility

/-!
# The algebraic field carried by the quartic interface coupling

The Cayley interface coefficient and the exterior amplitude rationally
reconstruct one another.  Consequently they generate the same degree-eight
number field over the rationals.  This distinguishes the interface coupling
from a fitted decimal: it carries the full algebraic information of the
quartic observable extension.
-/

namespace GravityScreening

open Polynomial
open scoped IntermediateField

noncomputable section

/-- Rational polynomial for the quartic Cayley interface coefficient. -/
def quarticInterfaceCouplingPolynomialRat : ℚ[X] :=
  X ^ 8 - 14 * X ^ 7 + 40 * X ^ 6 - 82 * X ^ 5 + 94 * X ^ 4 -
    82 * X ^ 3 + 40 * X ^ 2 - 14 * X + 1

private theorem quarticExteriorAmplitude_sq_screening
    (q : ℝ) (hq : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    A ^ 2 = screening (lambda4 q) := by
  dsimp only
  have hq0 : q ≠ 0 := by linarith
  have hspos : 0 < (2 * q - 1) / q ^ 2 :=
    div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  rw [quartic_screening_identity q hq0]
  exact Real.sq_sqrt hspos.le

private theorem quarticExteriorAmplitude_pos
    (q : ℝ) (hq : 1 < q) :
    0 < Real.sqrt ((2 * q - 1) / q ^ 2) := by
  have hq0 : q ≠ 0 := by linarith
  exact Real.sqrt_pos.2
    (div_pos (by linarith) (sq_pos_of_ne_zero hq0))

/-- The interface coefficient is a root of its displayed rational
degree-eight polynomial. -/
theorem quarticInterfaceCouplingPolynomialRat_aeval
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    let t := interfaceCoupling (lambda4 q) A
    aeval t quarticInterfaceCouplingPolynomialRat = 0 := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  let t : ℝ := interfaceCoupling (lambda4 q) A
  have hA2 : A ^ 2 = screening (lambda4 q) := by
    simpa [A] using quarticExteriorAmplitude_sq_screening q hq
  have hApos : 0 < A := by
    simpa [A] using quarticExteriorAmplitude_pos q hq
  have hsig : interfaceCouplingPolynomialValue t = 0 := by
    simpa [t] using quartic_interfaceCoupling_algebraicSignature
      q A hq4 hq hA2 hApos
  simpa [quarticInterfaceCouplingPolynomialRat,
    interfaceCouplingPolynomialValue, aeval_def, t] using hsig

/-- The quartic interface coefficient and exterior amplitude generate the
same intermediate field over `ℚ`. -/
theorem quarticInterfaceCoupling_adjoin_eq_exteriorAmplitude
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    let t := interfaceCoupling (lambda4 q) A
    (ℚ⟮t⟯ : IntermediateField ℚ ℝ) = ℚ⟮A⟯ := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  let t : ℝ := interfaceCoupling (lambda4 q) A
  let KA : IntermediateField ℚ ℝ := ℚ⟮A⟯
  let KT : IntermediateField ℚ ℝ := ℚ⟮t⟯
  have hA2 : A ^ 2 = screening (lambda4 q) := by
    simpa [A] using quarticExteriorAmplitude_sq_screening q hq
  have hApos : 0 < A := by
    simpa [A] using quarticExteriorAmplitude_pos q hq
  have hqmem : q ∈ KA := by
    simpa [KA, A] using
      quarticGenerator_mem_adjoinExteriorAmplitude q hq4 hq
  have hAself : A ∈ KA := by
    exact IntermediateField.mem_adjoin_simple_self ℚ A
  have htmem : t ∈ KA := by
    change interfaceCoupling (lambda4 q) A ∈ KA
    unfold interfaceCoupling lambda4
    apply KA.div_mem
    · exact KA.sub_mem (by norm_num)
        (by simpa [one_div] using KA.inv_mem hqmem)
    · exact KA.add_mem (by norm_num) hAself
  have htself : t ∈ KT :=
    IntermediateField.mem_adjoin_simple_self ℚ t
  have hretained :
      (1 - t ^ 2) / (1 + t ^ 2) = A := by
    simpa [t] using interfaceCoupling_reconstructs_retainedAmplitude
      (lambda4 q) A hA2 hApos
  have hAmem : A ∈ KT := by
    rw [← hretained]
    exact KT.div_mem
      (KT.sub_mem (by norm_num) (KT.toSubfield.pow_mem htself 2))
      (KT.add_mem (by norm_num) (KT.toSubfield.pow_mem htself 2))
  change KT = KA
  apply le_antisymm
  · exact IntermediateField.adjoin_simple_le_iff.mpr htmem
  · exact IntermediateField.adjoin_simple_le_iff.mpr hAmem

/-- The quartic interface coefficient has algebraic degree exactly eight.
It generates the same observable field as the retained exterior amplitude. -/
theorem quarticInterfaceCoupling_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    let t := interfaceCoupling (lambda4 q) A
    (minpoly ℚ t).natDegree = 8 := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  let t : ℝ := interfaceCoupling (lambda4 q) A
  have htroot : aeval t quarticInterfaceCouplingPolynomialRat = 0 := by
    simpa [A, t] using
      quarticInterfaceCouplingPolynomialRat_aeval q hq4 hq
  have hpne : quarticInterfaceCouplingPolynomialRat ≠ 0 := by
    have hpdeg : quarticInterfaceCouplingPolynomialRat.natDegree = 8 := by
      unfold quarticInterfaceCouplingPolynomialRat
      compute_degree!
    intro hp
    rw [hp] at hpdeg
    norm_num at hpdeg
  have htint : IsIntegral ℚ t :=
    (IsAlgebraic.isIntegral
      ⟨quarticInterfaceCouplingPolynomialRat, hpne, htroot⟩)
  have hAroot : aeval A quarticExteriorAmplitudePolynomialRat = 0 := by
    have hsig := quarticExteriorAmplitude_algebraicSignature q hq4 hq
    dsimp only at hsig
    simpa [A, quarticExteriorAmplitudePolynomialRat,
      quarticExteriorAmplitudePolynomialInt, aeval_def] using hsig
  have hAint : IsIntegral ℚ A :=
    (IsAlgebraic.isIntegral
      ⟨quarticExteriorAmplitudePolynomialRat,
        quarticExteriorAmplitudePolynomialRat_irreducible.ne_zero, hAroot⟩)
  have hfields : (ℚ⟮t⟯ : IntermediateField ℚ ℝ) = ℚ⟮A⟯ := by
    simpa [A, t] using
      quarticInterfaceCoupling_adjoin_eq_exteriorAmplitude q hq4 hq
  have hAdeg : (minpoly ℚ A).natDegree = 8 := by
    simpa [A] using quarticExteriorAmplitude_minpoly_natDegree q hq4 hq
  calc
    (minpoly ℚ t).natDegree = Module.finrank ℚ ℚ⟮t⟯ :=
      (IntermediateField.adjoin.finrank htint).symm
    _ = Module.finrank ℚ ℚ⟮A⟯ := by rw [hfields]
    _ = (minpoly ℚ A).natDegree := IntermediateField.adjoin.finrank hAint
    _ = 8 := hAdeg

#print axioms GravityScreening.quarticInterfaceCouplingPolynomialRat_aeval
#print axioms GravityScreening.quarticInterfaceCoupling_adjoin_eq_exteriorAmplitude
#print axioms GravityScreening.quarticInterfaceCoupling_minpoly_natDegree

end

end GravityScreening
