import GravityScreening.ClockForcesConstitutive

/-!
# From the doubled action Gram block to the passive horizon splitter

The symmetric action block `[[1,-l],[-l,1]]` already has the source-adapted
Gram factor whose columns are the reference channel `(1,0)` and the normalized
residue channel `(-l,d)`.  Reverse Gram--Schmidt, keeping that residue channel
fixed, produces the rotation with first column `(d,l)`.  Thus its visible and
hidden amplitudes are `d` and `l`, where `d^2=1-l^2`.

These are finite-dimensional algebraic statements.  Their physical use still
requires identifying the two Gram channels with the exterior and hidden
gravitational channels.
-/

namespace GravityScreening

/-- The orientation-preserving passive two-port transform.  Its first column
is the retained/hidden split `(d,l)` and its second column is the normalized
residue channel `(-l,d)` already present in `channelEmbedding`. -/
def passiveSplitter (l d : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![d, -l; l, d]

/-- The residue column in the passive splitter is exactly the residue column
in the source-adapted Gram factor of the doubled action. -/
theorem passiveSplitter_residue_column (l d : ℝ) :
    (fun i => passiveSplitter l d i 1) =
      (fun i => channelEmbedding l d i 1) := by
  funext i
  fin_cases i <;> simp [passiveSplitter, channelEmbedding]

/-- Acting on the ordinary source direction displays the retained and hidden
amplitudes directly. -/
theorem passiveSplitter_source_column (l d : ℝ) :
    (passiveSplitter l d).mulVec ![1, 0] = ![d, l] := by
  funext i
  fin_cases i <;>
    simp [passiveSplitter, Matrix.mulVec, dotProduct, Fin.sum_univ_succ]

/-- Reverse Gram--Schmidt of the reference column against the normalized
residue column gives `d` times the first column of the passive splitter. -/
theorem channelEmbedding_reverseGramSchmidt
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (fun i =>
      channelEmbedding l d i 0 -
        dotProduct (fun j => channelEmbedding l d j 0)
          (fun j => channelEmbedding l d j 1) *
            channelEmbedding l d i 1) =
      (fun i => d * passiveSplitter l d i 0) := by
  funext i
  fin_cases i <;>
    simp [channelEmbedding, passiveSplitter, dotProduct, Fin.sum_univ_succ,
      screening] at hd ⊢ <;>
    nlinarith [hd]

/-- The passive transform is orthogonal whenever the defect identity holds. -/
theorem passiveSplitter_orthogonal
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (passiveSplitter l d).transpose * passiveSplitter l d = 1 := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [passiveSplitter, Matrix.transpose_apply, Matrix.mul_apply,
      Fin.sum_univ_succ] <;>
    nlinarith [hunit]

/-- The passive transform preserves orientation. -/
theorem passiveSplitter_det
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    Matrix.det (passiveSplitter l d) = 1 := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  simp [passiveSplitter, Matrix.det_fin_two]
  nlinarith [hunit]

/-- The positive upper-triangular Gram factor is fixed by the action block.
In coordinates, `[[a,b],[0,c]]ᵀ [[a,b],[0,c]] = [[1,-l],[-l,1]]`
is encoded by the three scalar Gram equations below. -/
theorem positive_sourceAdapted_gramFactor_unique
    (l d a b c : ℝ)
    (ha : 0 < a) (hc : 0 < c) (hdpos : 0 < d)
    (hd : d ^ 2 = screening l)
    (hreference : a ^ 2 = 1)
    (hoverlap : a * b = -l)
    (hresidue : b ^ 2 + c ^ 2 = 1) :
    a = 1 ∧ b = -l ∧ c = d := by
  have ha1 : a = 1 := by nlinarith [hreference]
  have hb : b = -l := by simpa [ha1] using hoverlap
  have hcSq : c ^ 2 = d ^ 2 := by
    rw [hb] at hresidue
    unfold screening at hd
    nlinarith [hresidue, hd]
  have hcd : c = d := by nlinarith [hcSq]
  exact ⟨ha1, hb, hcd⟩

/-- A quadratic Gram block by itself does not choose a left orthogonal frame:
every orthogonal change of output coordinates leaves `CᵀC` unchanged.  The
source-adapted triangular condition above is therefore substantive. -/
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

/-- Fixing the normalized residue as the second column and requiring an
orientation-preserving orthogonal completion uniquely fixes the first column
to `(d,l)`.  This removes any independent beam-splitter angle. -/
theorem passiveSplitter_unique
    (l d a c : ℝ)
    (hd : d ^ 2 = screening l)
    (horth : a * (-l) + c * d = 0)
    (horient : a * d - (-l) * c = 1) :
    a = d ∧ c = l := by
  have hunit : l ^ 2 + d ^ 2 = 1 := julia_row_norm l d hd
  have haWeighted : a * (l ^ 2 + d ^ 2) = d := by
    calc
      a * (l ^ 2 + d ^ 2) =
          d * (a * d - (-l) * c) - l * (a * (-l) + c * d) := by
            ring
      _ = d := by rw [horient, horth]; ring
  have hcWeighted : c * (l ^ 2 + d ^ 2) = l := by
    calc
      c * (l ^ 2 + d ^ 2) =
          l * (a * d - (-l) * c) + d * (a * (-l) + c * d) := by
            ring
      _ = l := by rw [horient, horth]; ring
  rw [hunit] at haWeighted hcWeighted
  simpa using And.intro haWeighted hcWeighted

/-- Capstone: the doubled action block has its exact source-adapted Gram
factor; reverse Gram--Schmidt turns that same factor into the unique passive
splitter, whose retained quadratic weight is the action determinant. -/
theorem sourceAdaptedActionGram_yields_passiveSplitter
    (l d : ℝ) (hd : d ^ 2 = screening l) :
    (channelEmbedding l d).transpose * channelEmbedding l d =
        constitutiveBlock l ∧
      (passiveSplitter l d).transpose * passiveSplitter l d = 1 ∧
      Matrix.det (passiveSplitter l d) = 1 ∧
      (fun i => passiveSplitter l d i 1) =
        (fun i => channelEmbedding l d i 1) ∧
      (fun i =>
        channelEmbedding l d i 0 -
          dotProduct (fun j => channelEmbedding l d j 0)
            (fun j => channelEmbedding l d j 1) *
              channelEmbedding l d i 1) =
        (fun i => d * passiveSplitter l d i 0) := by
  exact ⟨channelEmbedding_gram l d hd,
    passiveSplitter_orthogonal l d hd,
    passiveSplitter_det l d hd,
    passiveSplitter_residue_column l d,
    channelEmbedding_reverseGramSchmidt l d hd⟩

/-- The clock-to-action-to-splitter capstone.  Exchange symmetry, normalized
diagonal mean, and even-channel clock weight `1/q` first force the action
block.  Its positive defect identity then supplies the exact Gram factor and
the unique conservative splitter with source output `(d,lambda4 q)`. -/
theorem clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter
    (M : Matrix (Fin 2) (Fin 2) ℝ) (q d : ℝ)
    (hexchange : IsChannelExchangeSymmetric M)
    (hmean : HasUnitDiagonalMean M)
    (hcore : HasEvenCoreWeight M q)
    (hd : d ^ 2 = screening (lambda4 q)) :
    M = (channelEmbedding (lambda4 q) d).transpose *
          channelEmbedding (lambda4 q) d ∧
      (passiveSplitter (lambda4 q) d).transpose *
          passiveSplitter (lambda4 q) d = 1 ∧
      Matrix.det (passiveSplitter (lambda4 q) d) = 1 ∧
      (passiveSplitter (lambda4 q) d).mulVec ![1, 0] =
        ![d, lambda4 q] := by
  have hM := clockWeight_forces_constitutiveBlock
    M q hexchange hmean hcore
  have hGram := channelEmbedding_gram (lambda4 q) d hd
  exact ⟨hM.trans hGram.symm,
    passiveSplitter_orthogonal (lambda4 q) d hd,
    passiveSplitter_det (lambda4 q) d hd,
    passiveSplitter_source_column (lambda4 q) d⟩

/-- For nonzero `q`, the retained source amplitude in the forced splitter has
the exact quartic squared weight `(2q-1)/q^2`. -/
theorem clockWeight_forced_splitter_retained_sq
    (q d : ℝ) (hq : q ≠ 0)
    (hd : d ^ 2 = screening (lambda4 q)) :
    ((passiveSplitter (lambda4 q) d).mulVec ![1, 0] 0) ^ 2 =
      (2 * q - 1) / q ^ 2 := by
  rw [passiveSplitter_source_column]
  simpa using hd.trans (quartic_screening_identity q hq)

#print axioms GravityScreening.passiveSplitter_residue_column
#print axioms GravityScreening.passiveSplitter_source_column
#print axioms GravityScreening.channelEmbedding_reverseGramSchmidt
#print axioms GravityScreening.passiveSplitter_orthogonal
#print axioms GravityScreening.passiveSplitter_det
#print axioms GravityScreening.positive_sourceAdapted_gramFactor_unique
#print axioms GravityScreening.passiveSplitter_unique
#print axioms GravityScreening.leftOrthogonal_gram_invariant
#print axioms GravityScreening.sourceAdaptedActionGram_yields_passiveSplitter
#print axioms GravityScreening.clockWeight_yields_sourceAdaptedActionGram_and_passiveSplitter
#print axioms GravityScreening.clockWeight_forced_splitter_retained_sq

end GravityScreening
