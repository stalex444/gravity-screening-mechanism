import GravityScreening.TetrahedralCoverage

/-!
# The morphic scales at the tetrahedral coverage threshold

Bandt--Meyer's three-dimensional simplex argument uses the strict scale
bound `theta < 4/3`.  This file verifies the algebraic placement of the
quadratic, cubic, and quartic golden-family roots around that bound.

The geometric theorem turning this inequality into relative density, and the
morphic-number classification leaving only the golden and plastic numbers,
are published inputs rather than claims reproved here.
-/

namespace GravityScreening

/-- The dilation bound in the balanced three-simplex coverage argument. -/
noncomputable def tetraCoverageThreshold : ℝ := 4 / 3

/-- The positive golden root lies above the tetrahedral coverage threshold. -/
theorem goldenRoot_above_tetraCoverageThreshold
    (phi : ℝ) (hphi : phi ^ 2 = phi + 1) (hphi_one : 1 < phi) :
    tetraCoverageThreshold < phi := by
  unfold tetraCoverageThreshold
  by_contra h
  have hle : phi ≤ 4 / 3 := le_of_not_gt h
  nlinarith [sq_nonneg (phi - 1)]

/-- The positive plastic root lies below the tetrahedral coverage threshold. -/
theorem plasticRoot_below_tetraCoverageThreshold
    (rho : ℝ) (hrho : rho ^ 3 = rho + 1) (hrho_one : 1 < rho) :
    rho < tetraCoverageThreshold := by
  unfold tetraCoverageThreshold
  by_contra h
  have hge : 4 / 3 ≤ rho := le_of_not_gt h
  have hrho_pos : 0 < rho := lt_trans zero_lt_one hrho_one
  have hsecond :
      0 < rho ^ 2 + (4 / 3) * rho + (4 / 3 : ℝ) ^ 2 - 1 := by
    nlinarith [sq_nonneg (rho - 1)]
  have hfactor :
      0 ≤ (rho - 4 / 3) *
        (rho ^ 2 + (4 / 3) * rho + (4 / 3 : ℝ) ^ 2 - 1) := by
    exact mul_nonneg (sub_nonneg.mpr hge) hsecond.le
  nlinarith

/-- The positive quartic root is also geometrically below `4/3`. -/
theorem quarticRoot_below_tetraCoverageThreshold
    (q : ℝ) (hq : q ^ 4 = q + 1) (hq_one : 1 < q) :
    q < tetraCoverageThreshold := by
  unfold tetraCoverageThreshold
  by_contra h
  have hge : 4 / 3 ≤ q := le_of_not_gt h
  have hq_pos : 0 < q := lt_trans zero_lt_one hq_one
  have hcube : 1 < q ^ 3 := by
    have hproduct : 0 < (q - 1) * (q ^ 2 + q + 1) := by positivity
    nlinarith
  have hsecond :
      0 < q ^ 3 + (4 / 3) * q ^ 2 + (4 / 3 : ℝ) ^ 2 * q
        + (4 / 3 : ℝ) ^ 3 - 1 := by
    have hterm1 : 0 ≤ (4 / 3 : ℝ) * q ^ 2 := by positivity
    have hterm2 : 0 ≤ (4 / 3 : ℝ) ^ 2 * q := by positivity
    have hterm3 : 0 ≤ (4 / 3 : ℝ) ^ 3 := by positivity
    nlinarith
  have hfactor :
      0 ≤ (q - 4 / 3) *
        (q ^ 3 + (4 / 3) * q ^ 2 + (4 / 3 : ℝ) ^ 2 * q
          + (4 / 3 : ℝ) ^ 3 - 1) := by
    exact mul_nonneg (sub_nonneg.mpr hge) hsecond.le
  nlinarith

/-- Among the two displayed morphic candidates, the threshold test selects
the plastic root.  Exhaustiveness of the two candidates is the external
Aarts--Fokkink--Kruijtzer theorem (Palomar-registered in PDT). -/
theorem morphicPair_tetraCoverageThreshold_iff
    (phi rho theta : ℝ)
    (hphi : phi ^ 2 = phi + 1) (hphi_one : 1 < phi)
    (hrho : rho ^ 3 = rho + 1) (hrho_one : 1 < rho)
    (htheta : theta = phi ∨ theta = rho) :
    theta < tetraCoverageThreshold ↔ theta = rho := by
  have hphi_threshold :=
    goldenRoot_above_tetraCoverageThreshold phi hphi hphi_one
  have hrho_threshold :=
    plasticRoot_below_tetraCoverageThreshold rho hrho hrho_one
  constructor
  · intro htheta_threshold
    rcases htheta with rfl | rfl
    · exact False.elim (lt_asymm htheta_threshold hphi_threshold)
    · rfl
  · intro htheta_rho
    rw [htheta_rho]
    exact hrho_threshold

#print axioms GravityScreening.goldenRoot_above_tetraCoverageThreshold
#print axioms GravityScreening.plasticRoot_below_tetraCoverageThreshold
#print axioms GravityScreening.quarticRoot_below_tetraCoverageThreshold
#print axioms GravityScreening.morphicPair_tetraCoverageThreshold_iff

end GravityScreening
