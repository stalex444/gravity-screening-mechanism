import GravityScreening.ClockForcesConstitutive

/-!
# From the doubled action Gram block to the passive horizon splitter

The symmetric action block `[[1,-l],[-l,1]]` has a unique positive lower-
triangular Gram factor that preserves the ordinary source covector.  Its first
column is already the conserved two-port source amplitude `(d,-l)`, where
`d^2=1-l^2`.  Keeping that source column fixed, Gram--Schmidt uniquely
completes it to an orientation-preserving passive splitter.

These are finite-dimensional algebraic statements.  Their physical use still
requires identifying the two Gram coordinates with exterior and hidden
gravitational channels.
-/

namespace GravityScreening

/-- Positive lower-triangular Gram factor adapted to the ordinary source ray.
For `d^2=1-l^2`, its Gram matrix is the doubled action block. -/
def sourceAdaptedGramFactor (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![d, 0; -l, 1]

/-- The displayed inverse of the source-adapted Gram factor. -/
noncomputable def sourceAdaptedGramFactorInverse
    (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1 / d, 0; l / d, 1]

/-- The orientation-preserving passive two-port completion of the source
column `(d,-l)`. -/
def passiveSourceSplitter (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![d, l; -l, d]

/-- The source-adapted factor has exactly the doubled action Gram block. -/
theorem sourceAdaptedGramFactor_gram
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (sourceAdaptedGramFactor l d).transpose *
        sourceAdaptedGramFactor l d = constitutiveBlock l := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [sourceAdaptedGramFactor, constitutiveBlock,
      Matrix.transpose_apply, Matrix.mul_apply, Fin.sum_univ_succ,
      screening] at hd ⊢ <;>
    nlinarith [hd]

/-- The displayed inverse is a right inverse. -/
theorem sourceAdaptedGramFactor_mul_inverse
    (l d : ℝ) (hd0 : d ≠ 0) :
    sourceAdaptedGramFactor l d *
        sourceAdaptedGramFactorInverse l d = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [sourceAdaptedGramFactor, sourceAdaptedGramFactorInverse,
      Matrix.mul_apply, Fin.sum_univ_succ] <;>
    field_simp [hd0] <;> ring

/-- Pulling an ordinary source covector through the inverse transpose changes
only its magnitude; it creates no partner-source component. -/
theorem sourceAdaptedGramFactor_preserves_source_ray
    (l d source : ℝ) :
    (sourceAdaptedGramFactorInverse l d).transpose.mulVec
        ![source, 0] = ![source / d, 0] := by
  funext i
  fin_cases i <;>
    simp [sourceAdaptedGramFactorInverse, Matrix.transpose_apply,
      Matrix.mulVec, dotProduct, Fin.sum_univ_succ, div_eq_mul_inv,
      mul_comm]

/-- The physical source column of the Gram factor already carries retained
amplitude `d` and oriented hidden amplitude `-l`. -/
theorem sourceAdaptedGramFactor_source_column (l d : ℝ) :
    (sourceAdaptedGramFactor l d).mulVec ![1, 0] = ![d, -l] := by
  funext i
  fin_cases i <;>
    simp [sourceAdaptedGramFactor, Matrix.mulVec, dotProduct,
      Fin.sum_univ_succ]

/-- The passive completion has the same source column as the source-adapted
Gram factor. -/
theorem passiveSourceSplitter_source_column (l d : ℝ) :
    (passiveSourceSplitter l d).mulVec ![1, 0] = ![d, -l] := by
  funext i
  fin_cases i <;>
    simp [passiveSourceSplitter, Matrix.mulVec, dotProduct,
      Fin.sum_univ_succ]

/-- Gram--Schmidt keeps the source column fixed and removes it from the second
Gram column.  The remainder is `d` times the second passive column. -/
theorem sourceAdaptedGramFactor_gramSchmidt
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (fun i =>
      sourceAdaptedGramFactor l d i 1 -
        dotProduct (fun j => sourceAdaptedGramFactor l d j 0)
          (fun j => sourceAdaptedGramFactor l d j 1) *
            sourceAdaptedGramFactor l d i 0) =
      (fun i => d * passiveSourceSplitter l d i 1) := by
  funext i
  fin_cases i <;>
    simp [sourceAdaptedGramFactor, passiveSourceSplitter, dotProduct,
      Fin.sum_univ_succ, screening] at hd ⊢ <;>
    nlinarith [hd]

/-- The passive transform is orthogonal whenever the defect identity holds. -/
theorem passiveSourceSplitter_orthogonal
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (passiveSourceSplitter l d).transpose *
        passiveSourceSplitter l d = 1 := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [passiveSourceSplitter, Matrix.transpose_apply,
      Matrix.mul_apply, Fin.sum_univ_succ] <;>
    nlinarith [hunit]

/-- The passive transform preserves orientation. -/
theorem passiveSourceSplitter_det
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    Matrix.det (passiveSourceSplitter l d) = 1 := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  simp [passiveSourceSplitter, Matrix.det_fin_two]
  nlinarith [hunit]

/-- The positive source-preserving lower-triangular Gram factor is unique.
The hypotheses are the three entries of
`[[a,0],[b,c]]ᵀ [[a,0],[b,c]] = [[1,-l],[-l,1]]`. -/
theorem positive_sourceAdapted_gramFactor_unique
    (l d a b c : ℝ)
    (ha : 0 < a) (hc : 0 < c) (hdpos : 0 < d)
    (hd : d ^ 2 = screening l)
    (hsourceNorm : a ^ 2 + b ^ 2 = 1)
    (hoverlap : b * c = -l)
    (hpartnerNorm : c ^ 2 = 1) :
    a = d ∧ b = -l ∧ c = 1 := by
  have hc1 : c = 1 := by nlinarith [hpartnerNorm]
  have hb : b = -l := by simpa [hc1] using hoverlap
  have haSq : a ^ 2 = d ^ 2 := by
    rw [hb] at hsourceNorm
    unfold screening at hd
    nlinarith [hsourceNorm, hd]
  have had : a = d := by nlinarith [haSq]
  exact ⟨had, hb, hc1⟩

/-- A quadratic Gram block alone does not choose a left orthogonal frame:
every orthogonal change of output coordinates leaves `CᵀC` unchanged.  The
source-preserving triangular condition above is therefore substantive. -/
theorem leftOrthogonal_gram_invariant
    (O C : Matrix (Fin 2) (Fin 2) ℝ)
    (hO : O.transpose * O = 1) :
    (O * C).transpose * (O * C) = C.transpose * C := by
  rw [Matrix.transpose_mul]
  calc
    (C.transpose * O.transpose) * (O * C) =
        C.transpose * (O.transpose * O) * C := by
          simp [Matrix.mul_assoc]
    _ = C.transpose * C := by rw [hO]; simp

/-- Fixing the normalized source column `(d,-l)` and requiring an
orientation-preserving orthogonal completion uniquely fixes the second column
to `(l,d)`.  No continuous splitter angle remains. -/
theorem passiveSourceSplitter_unique
    (l d a c : ℝ)
    (hd : d ^ 2 = screening l)
    (horth : d * a + (-l) * c = 0)
    (horient : d * c - a * (-l) = 1) :
    a = l ∧ c = d := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  have haWeighted : a * (l ^ 2 + d ^ 2) = l := by
    calc
      a * (l ^ 2 + d ^ 2) =
          l * (d * c - a * (-l)) + d * (d * a + (-l) * c) := by
            ring
      _ = l := by rw [horient, horth]; ring
  have hcWeighted : c * (l ^ 2 + d ^ 2) = d := by
    calc
      c * (l ^ 2 + d ^ 2) =
          d * (d * c - a * (-l)) - l * (d * a + (-l) * c) := by
            ring
      _ = d := by rw [horient, horth]; ring
  rw [hunit] at haWeighted hcWeighted
  simpa using And.intro haWeighted hcWeighted

/-- Capstone: the doubled action block has a source-preserving Gram factor;
Gram--Schmidt completes its fixed source column to the unique passive splitter,
whose retained quadratic weight is the action determinant. -/
theorem sourceAdaptedActionGram_yields_passiveSplitter
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (sourceAdaptedGramFactor l d).transpose *
          sourceAdaptedGramFactor l d = constitutiveBlock l ∧
      (passiveSourceSplitter l d).transpose *
          passiveSourceSplitter l d = 1 ∧
      Matrix.det (passiveSourceSplitter l d) = 1 ∧
      (passiveSourceSplitter l d).mulVec ![1, 0] =
        (sourceAdaptedGramFactor l d).mulVec ![1, 0] ∧
      (fun i =>
        sourceAdaptedGramFactor l d i 1 -
          dotProduct (fun j => sourceAdaptedGramFactor l d j 0)
            (fun j => sourceAdaptedGramFactor l d j 1) *
              sourceAdaptedGramFactor l d i 0) =
        (fun i => d * passiveSourceSplitter l d i 1) := by
  exact ⟨sourceAdaptedGramFactor_gram l d hd,
    passiveSourceSplitter_orthogonal l d hd,
    passiveSourceSplitter_det l d hd,
    (passiveSourceSplitter_source_column l d).trans
      (sourceAdaptedGramFactor_source_column l d).symm,
    sourceAdaptedGramFactor_gramSchmidt l d hd⟩

/-- The clock-to-action-to-splitter capstone.  Exchange symmetry, normalized
diagonal mean, and even-channel clock weight `1/q` force the action block.
The positive source-preserving factor and passive completion then have source
output `(d,-lambda4 q)`. -/
theorem clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter
    (M : Matrix (Fin 2) (Fin 2) ℝ) (q d : ℝ)
    (hexchange : IsChannelExchangeSymmetric M)
    (hmean : HasUnitDiagonalMean M)
    (hcore : HasEvenCoreWeight M q)
    (hd : d ^ 2 = screening (lambda4 q)) :
    M = (sourceAdaptedGramFactor (lambda4 q) d).transpose *
          sourceAdaptedGramFactor (lambda4 q) d ∧
      (passiveSourceSplitter (lambda4 q) d).transpose *
          passiveSourceSplitter (lambda4 q) d = 1 ∧
      Matrix.det (passiveSourceSplitter (lambda4 q) d) = 1 ∧
      (passiveSourceSplitter (lambda4 q) d).mulVec ![1, 0] =
        ![d, -lambda4 q] := by
  have hM := clockWeight_forces_constitutiveBlock
    M q hexchange hmean hcore
  have hGram := sourceAdaptedGramFactor_gram (lambda4 q) d hd
  exact ⟨hM.trans hGram.symm,
    passiveSourceSplitter_orthogonal (lambda4 q) d hd,
    passiveSourceSplitter_det (lambda4 q) d hd,
    passiveSourceSplitter_source_column (lambda4 q) d⟩

/-- For nonzero `q`, the retained source amplitude in the passive completion
has the exact quartic squared weight `(2q-1)/q^2`. -/
theorem clockWeight_forced_splitter_retained_sq
    (q d : ℝ) (hq : q ≠ 0)
    (hd : d ^ 2 = screening (lambda4 q)) :
    ((passiveSourceSplitter (lambda4 q) d).mulVec ![1, 0] 0) ^ 2 =
      (2 * q - 1) / q ^ 2 := by
  rw [passiveSourceSplitter_source_column]
  simpa using hd.trans (quartic_screening_identity q hq)

#print axioms GravityScreening.sourceAdaptedGramFactor_gram
#print axioms GravityScreening.sourceAdaptedGramFactor_mul_inverse
#print axioms GravityScreening.sourceAdaptedGramFactor_preserves_source_ray
#print axioms GravityScreening.sourceAdaptedGramFactor_source_column
#print axioms GravityScreening.passiveSourceSplitter_source_column
#print axioms GravityScreening.sourceAdaptedGramFactor_gramSchmidt
#print axioms GravityScreening.passiveSourceSplitter_orthogonal
#print axioms GravityScreening.passiveSourceSplitter_det
#print axioms GravityScreening.positive_sourceAdapted_gramFactor_unique
#print axioms GravityScreening.leftOrthogonal_gram_invariant
#print axioms GravityScreening.passiveSourceSplitter_unique
#print axioms GravityScreening.sourceAdaptedActionGram_yields_passiveSplitter
#print axioms GravityScreening.clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter
#print axioms GravityScreening.clockWeight_forced_splitter_retained_sq

end GravityScreening
