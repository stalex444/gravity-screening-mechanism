import Mathlib

/-!
# The golden-ratio fold of the rho-Q ruler

This file isolates a purely algebraic fact.  If `u` satisfies the established
degree-twelve polynomial of the PDT ruler `rho*Q`, then its golden-polynomial
defect `u^2-u-1` is itself a unit.  The theorem supplies an explicit inverse,
so it does not depend on numerical proximity to the golden ratio.
-/

namespace GravityScreening

/-- The degree-twelve relation satisfied by the ruler `rho*Q`. -/
def rulerRelation {R : Type*} [CommRing R] (u : R) : R :=
  u ^ 12 - 3 * u ^ 9 - 2 * u ^ 8 + 2 * u ^ 6 - u ^ 5
    - 3 * u ^ 4 - u ^ 3 + u - 1

/-- Evaluation of the golden polynomial `X^2-X-1`. -/
def goldenDefect {R : Type*} [CommRing R] (u : R) : R :=
  u ^ 2 - u - 1

/-- The explicit inverse of the golden defect on the ruler polynomial. -/
def goldenDefectInverse {R : Type*} [CommRing R] (u : R) : R :=
  -(u ^ 11 + u ^ 10 + 2 * u ^ 9 + 2 * u ^ 5 + u ^ 4 + 1)

/-- Bezout identity behind `Res(rulerPoly, X^2-X-1) = -1`. -/
theorem ruler_golden_bezout {R : Type*} [CommRing R] (u : R) :
    (-u) * rulerRelation u
      + (u ^ 11 + u ^ 10 + 2 * u ^ 9 + 2 * u ^ 5 + u ^ 4 + 1)
          * goldenDefect u = -1 := by
  simp [rulerRelation, goldenDefect]
  ring

/-- On any root of the ruler polynomial, the golden defect has the displayed
two-sided inverse. -/
theorem goldenDefect_mul_inverse {R : Type*} [CommRing R] (u : R)
    (hroot : rulerRelation u = 0) :
    goldenDefect u * goldenDefectInverse u = 1 := by
  have h := ruler_golden_bezout u
  rw [hroot] at h
  simp only [mul_zero, zero_add] at h
  calc
    goldenDefect u * goldenDefectInverse u =
        -((u ^ 11 + u ^ 10 + 2 * u ^ 9 + 2 * u ^ 5 + u ^ 4 + 1)
          * goldenDefect u) := by
            simp [goldenDefectInverse]
            ring
    _ = 1 := by rw [h]; ring

/-- The golden defect is a unit, exhibited without a field or a norm API. -/
theorem goldenDefect_isUnit {R : Type*} [CommRing R] (u : R)
    (hroot : rulerRelation u = 0) : IsUnit (goldenDefect u) := by
  refine isUnit_iff_exists_inv.mpr ?_
  exact ⟨goldenDefectInverse u, goldenDefect_mul_inverse u hroot⟩

#print axioms GravityScreening.ruler_golden_bezout
#print axioms GravityScreening.goldenDefect_mul_inverse
#print axioms GravityScreening.goldenDefect_isUnit

end GravityScreening
