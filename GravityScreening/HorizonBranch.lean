import GravityScreening.Basic

/-!
# Subnormalized horizon branches

The scalar defect channel does not change a normalized conditional state, but
it does change the unconditioned weight of that state in a horizon instrument.
This file checks the resulting entropy-first-law scaling in a finite diagonal
model.  Identifying the retained branch with physical horizon cells remains a
physical premise.
-/

namespace GravityScreening

/-- A branch of amplitude `d` sends a diagonal state perturbation to one with
Born weight `d^2`.  The result is deliberately left subnormalized. -/
def scalarBranchPerturbation {n : ℕ} (d : ℝ) (delta : Fin n → ℝ) :
    Fin n → ℝ :=
  fun i => d ^ 2 * delta i

/-- The entropy first-law pairing on a subnormalized scalar branch is its Born
weight times the input pairing. -/
theorem scalarBranch_firstLaw {n : ℕ} (k delta : Fin n → ℝ) (d : ℝ) :
    firstLawVariation k (scalarBranchPerturbation d delta) =
      d ^ 2 * firstLawVariation k delta := by
  unfold firstLawVariation scalarBranchPerturbation
  simp_rw [show ∀ i, d ^ 2 * delta i * k i = d ^ 2 * (delta i * k i) by
    intro i
    ring]
  exact (Finset.mul_sum Finset.univ (fun i => delta i * k i) (d ^ 2)).symm

/-- If `d` is the complementary amplitude to `l`, the visible branch scales
every first-law variation by `1-l^2`. -/
theorem defectBranch_firstLaw {n : ℕ} (k delta : Fin n → ℝ) (l d : ℝ)
    (hdefect : d ^ 2 = screening l) :
    firstLawVariation k (scalarBranchPerturbation d delta) =
      screening l * firstLawVariation k delta := by
  rw [scalarBranch_firstLaw, hdefect]

/-- At the quartic root, the subnormalized complementary branch carries the
exact factor `(2q-1)/q^2` occurring in the PDT entropy-area density. -/
theorem quarticDefectBranch_firstLaw {n : ℕ} (k delta : Fin n → ℝ)
    (q d : ℝ) (hq0 : q ≠ 0)
    (hdefect : d ^ 2 = screening (lambda4 q)) :
    firstLawVariation k (scalarBranchPerturbation d delta) =
      ((2 * q - 1) / q ^ 2) * firstLawVariation k delta := by
  rw [defectBranch_firstLaw k delta (lambda4 q) d hdefect]
  rw [quartic_screening_identity q hq0]

/-- Renormalizing a nonzero scalar branch removes its common Born weight.
This is the algebraic boundary between conditional state information and an
unconditioned horizon-cell density. -/
theorem scalarBranch_renormalizes {n : ℕ} (delta : Fin n → ℝ) (d : ℝ)
    (hd : d ≠ 0) :
    (fun i => scalarBranchPerturbation d delta i / d ^ 2) = delta := by
  funext i
  simp [scalarBranchPerturbation, hd]

#print axioms GravityScreening.scalarBranch_firstLaw
#print axioms GravityScreening.defectBranch_firstLaw
#print axioms GravityScreening.quarticDefectBranch_firstLaw
#print axioms GravityScreening.scalarBranch_renormalizes

end GravityScreening
