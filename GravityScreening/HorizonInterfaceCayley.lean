import GravityScreening.ActionSplitterBridge

/-!
# A minimal lossless interface law for the passive horizon splitter

The bulk doubled action fixes a source-adapted Gram factor, but a Gram matrix
alone cannot select a physical matching map.  This file isolates the missing
interface datum.

For the standard two-dimensional symplectic block `J`, impose the centered
jump law

`(I + t J) z_after = (I - t J) z_before`.

Its unique transfer map is the Cayley transform.  If `d^2 = 1-l^2`, `d>0`,
and `t=l/(1+d)`, that Cayley transform is exactly the passive source splitter
`[[d,l],[-l,d]]`.  Thus the entire dynamical seam is reduced to one precise,
algebraic boundary coefficient.  The file does not claim that the bulk action
already derives this interface law.
-/

namespace GravityScreening

/-- The left matrix in the centered symplectic jump law.  It is `I+tJ` for
the convention `J=[[0,-1],[1,0]]`. -/
def interfaceJumpLeft (t : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1, -t; t, 1]

/-- The right matrix in the centered symplectic jump law.  It is `I-tJ`. -/
def interfaceJumpRight (t : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1, t; -t, 1]

/-- The inverse of `I+tJ`, displayed without matrix inversion. -/
noncomputable def interfaceJumpLeftInverse
    (t : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  (1 / (1 + t ^ 2)) • !![1, t; -t, 1]

/-- The transfer matrix selected by the centered jump law. -/
noncomputable def interfaceCayleyMap
    (t : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  (1 / (1 + t ^ 2)) • !![1 - t ^ 2, 2 * t; -2 * t, 1 - t ^ 2]

/-- The algebraic boundary coefficient associated with the source column
`(d,-l)`.  It is the rational half-angle coordinate of the splitter. -/
noncomputable def interfaceCoupling (l d : ℝ) : ℝ :=
  l / (1 + d)

/-- The scalar degree-eight equation obtained when the quartic relation is
transported through the Cayley half-angle coordinate. -/
def interfaceCouplingPolynomialValue (t : ℝ) : ℝ :=
  t ^ 8 - 14 * t ^ 7 + 40 * t ^ 6 - 82 * t ^ 5 + 94 * t ^ 4 -
    82 * t ^ 3 + 40 * t ^ 2 - 14 * t + 1

/-- The isotropic quadratic Hamiltonian localized at the interface. -/
def isotropicInterfaceHamiltonian (t : ℝ) (z : Fin 2 → ℝ) : ℝ :=
  t * dotProduct z z

private theorem one_add_sq_ne_zero (t : ℝ) : 1 + t ^ 2 ≠ 0 := by
  nlinarith [sq_nonneg t]

/-- The displayed inverse is a left inverse. -/
theorem interfaceJumpLeftInverse_mul_left (t : ℝ) :
    interfaceJumpLeftInverse t * interfaceJumpLeft t = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [interfaceJumpLeftInverse, interfaceJumpLeft,
      Matrix.mul_apply, Fin.sum_univ_succ] <;>
    field_simp [one_add_sq_ne_zero t]
  all_goals ring

/-- The displayed inverse is also a right inverse. -/
theorem interfaceJumpLeft_mul_inverse (t : ℝ) :
    interfaceJumpLeft t * interfaceJumpLeftInverse t = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [interfaceJumpLeftInverse, interfaceJumpLeft,
      Matrix.mul_apply, Fin.sum_univ_succ] <;>
    field_simp [one_add_sq_ne_zero t] <;> ring

/-- Multiplying the two sides of the centered jump law gives the explicit
Cayley transfer map. -/
theorem interfaceJumpLeftInverse_mul_right (t : ℝ) :
    interfaceJumpLeftInverse t * interfaceJumpRight t =
      interfaceCayleyMap t := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [interfaceJumpLeftInverse, interfaceJumpRight,
      interfaceCayleyMap, Matrix.mul_apply, Fin.sum_univ_succ] <;>
    ring

/-- The centered interface equation has one and only one transfer matrix. -/
theorem centeredInterface_unique_transfer
    (t : ℝ) (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hjump : interfaceJumpLeft t * M = interfaceJumpRight t) :
    M = interfaceCayleyMap t := by
  calc
    M = 1 * M := by simp
    _ = (interfaceJumpLeftInverse t * interfaceJumpLeft t) * M := by
      rw [interfaceJumpLeftInverse_mul_left]
    _ = interfaceJumpLeftInverse t * (interfaceJumpLeft t * M) := by
      rw [Matrix.mul_assoc]
    _ = interfaceJumpLeftInverse t * interfaceJumpRight t := by rw [hjump]
    _ = interfaceCayleyMap t := interfaceJumpLeftInverse_mul_right t

/-- The Cayley transfer is lossless: it is orthogonal for every real
interface coefficient. -/
theorem interfaceCayleyMap_orthogonal (t : ℝ) :
    (interfaceCayleyMap t).transpose * interfaceCayleyMap t = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [interfaceCayleyMap, Matrix.transpose_apply, Matrix.mul_apply,
      Fin.sum_univ_succ] <;>
    field_simp [one_add_sq_ne_zero t] <;> ring

/-- The Cayley transfer preserves orientation. -/
theorem interfaceCayleyMap_det (t : ℝ) :
    Matrix.det (interfaceCayleyMap t) = 1 := by
  simp [interfaceCayleyMap, Matrix.det_fin_two]
  field_simp [one_add_sq_ne_zero t]
  ring

/-- Exact centered-variation formula for the interface Hamiltonian.  After
division by `2ε`, its symmetric directional derivative is
`2t ⟨midpoint,variation⟩`. -/
theorem isotropicInterfaceHamiltonian_centeredVariation
    (t ε : ℝ) (midpoint variation : Fin 2 → ℝ) :
    isotropicInterfaceHamiltonian t (midpoint + ε • variation) -
        isotropicInterfaceHamiltonian t (midpoint - ε • variation) =
      4 * t * ε * dotProduct midpoint variation := by
  simp [isotropicInterfaceHamiltonian, dotProduct, Fin.sum_univ_succ]
  ring

/-- The matrix jump equation is exactly a centered Hamiltonian impulse law.
Writing `m=(after+before)/2`, the right side is `2t m`; it is therefore the
gradient of the isotropic quadratic `t‖m‖²`. -/
theorem centeredInterface_iff_symplecticImpulse
    (t : ℝ) (before after : Fin 2 → ℝ) :
    (interfaceJumpLeft t).mulVec after =
        (interfaceJumpRight t).mulVec before ↔
      symplecticBlock.mulVec (after - before) =
        t • (after + before) := by
  constructor <;> intro h
  · funext i
    have h0 := congrFun h (0 : Fin 2)
    have h1 := congrFun h (1 : Fin 2)
    fin_cases i <;>
      simp [interfaceJumpLeft, interfaceJumpRight, symplecticBlock,
        Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 ⊢ <;>
      linarith
  · funext i
    have h0 := congrFun h (0 : Fin 2)
    have h1 := congrFun h (1 : Fin 2)
    fin_cases i <;>
      simp [interfaceJumpLeft, interfaceJumpRight, symplecticBlock,
        Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 ⊢ <;>
      linarith

/-- The half-angle coefficient reconstructs the original mixing amplitude:
`l = 2t/(1+t²)`. -/
theorem interfaceCoupling_reconstructs_amplitude
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d) :
    2 * interfaceCoupling l d /
        (1 + (interfaceCoupling l d) ^ 2) = l := by
  have hden : 1 + d ≠ 0 := by nlinarith
  have hhalf : (1 + d) ^ 2 + l ^ 2 = 2 * (1 + d) := by
    unfold screening at hd
    nlinarith [hd]
  unfold interfaceCoupling
  field_simp [hden, one_add_sq_ne_zero]
  rw [hhalf]
  ring

/-- The same half-angle coefficient reconstructs the retained amplitude:
`d=(1-t²)/(1+t²)`. -/
theorem interfaceCoupling_reconstructs_retainedAmplitude
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d) :
    (1 - (interfaceCoupling l d) ^ 2) /
        (1 + (interfaceCoupling l d) ^ 2) = d := by
  have hden : 1 + d ≠ 0 := by nlinarith
  have hhalf : (1 + d) ^ 2 + l ^ 2 = 2 * (1 + d) := by
    unfold screening at hd
    nlinarith [hd]
  unfold interfaceCoupling
  field_simp [hden, one_add_sq_ne_zero]
  rw [hhalf]
  unfold screening at hd
  nlinarith [hd]

/-- For the quartic mixing amplitude, the reconstructed-amplitude identity is
equivalent to the polynomial elimination relation used below. -/
theorem lambda4_interfaceCoupling_relation
    (q d : ℝ) (hq : 1 < q)
    (hd : d ^ 2 = screening (lambda4 q)) (hdpos : 0 < d) :
    (q - 1) * (1 + (interfaceCoupling (lambda4 q) d) ^ 2) =
      2 * interfaceCoupling (lambda4 q) d * q := by
  let t := interfaceCoupling (lambda4 q) d
  have hq0 : q ≠ 0 := by linarith
  have htden : 1 + t ^ 2 ≠ 0 := one_add_sq_ne_zero t
  have hrec : 2 * t / (1 + t ^ 2) = lambda4 q := by
    simpa [t] using interfaceCoupling_reconstructs_amplitude
      (lambda4 q) d hd hdpos
  have hcross : 2 * t = lambda4 q * (1 + t ^ 2) :=
    (div_eq_iff htden).mp hrec
  have hlam : q * lambda4 q = q - 1 := by
    unfold lambda4
    field_simp [hq0]
  change (q - 1) * (1 + t ^ 2) = 2 * t * q
  calc
    (q - 1) * (1 + t ^ 2) =
        (q * lambda4 q) * (1 + t ^ 2) := by rw [hlam]
    _ = q * (lambda4 q * (1 + t ^ 2)) := by ring
    _ = q * (2 * t) := by rw [← hcross]
    _ = 2 * t * q := by ring

/-- On the positive quartic branch, the interface coefficient is the weak
member of its reciprocal pair. -/
theorem quartic_interfaceCoupling_mem_unitInterval
    (q d : ℝ) (hq : 1 < q) (hdpos : 0 < d) :
    0 < interfaceCoupling (lambda4 q) d ∧
      interfaceCoupling (lambda4 q) d < 1 := by
  have hqpos : 0 < q := lt_trans zero_lt_one hq
  have hinvpos : 0 < 1 / q := one_div_pos.mpr hqpos
  have hinvlt : 1 / q < 1 := (div_lt_one hqpos).mpr hq
  have hlampos : 0 < lambda4 q := by
    unfold lambda4
    linarith
  have hlamlt : lambda4 q < 1 := by
    unfold lambda4
    linarith
  have hdenpos : 0 < 1 + d := by linarith
  constructor
  · exact div_pos hlampos hdenpos
  · unfold interfaceCoupling
    exact (div_lt_one hdenpos).mpr (by linarith)

/-- The polynomial is reciprocal: the strong and weak Cayley couplings occur
in inverse pairs. -/
theorem interfaceCouplingPolynomialValue_reciprocal
    (t : ℝ) (ht0 : t ≠ 0) :
    t ^ 8 * interfaceCouplingPolynomialValue (1 / t) =
      interfaceCouplingPolynomialValue t := by
  unfold interfaceCouplingPolynomialValue
  field_simp [ht0]
  ring

/-- Eliminating a quartic root from
`q⁴=q+1` and `(q-1)(1+t²)=2tq` produces the exact reciprocal degree-eight
interface equation. -/
theorem quartic_halfAngle_algebraicSignature
    (q t : ℝ) (hq4 : q ^ 4 = q + 1)
    (hqt : (q - 1) * (1 + t ^ 2) = 2 * t * q) :
    interfaceCouplingPolynomialValue t = 0 := by
  let A : ℝ := 1 + t ^ 2
  let B : ℝ := (t - 1) ^ 2
  have hqB : q * B = A := by
    dsimp [A, B]
    calc
      q * (t - 1) ^ 2 = q * (1 + t ^ 2) - 2 * t * q := by ring
      _ = 1 + t ^ 2 := by nlinarith [hqt]
  have htransport : A ^ 4 = (A + B) * B ^ 3 := by
    calc
      A ^ 4 = (q * B) ^ 4 := by rw [hqB]
      _ = q ^ 4 * B ^ 4 := by ring
      _ = (q + 1) * B ^ 4 := by rw [hq4]
      _ = (A + B) * B ^ 3 := by
        rw [← hqB]
        ring
  have hid : interfaceCouplingPolynomialValue t =
      (A + B) * B ^ 3 - A ^ 4 := by
    dsimp [A, B, interfaceCouplingPolynomialValue]
    ring
  rw [hid, htransport]
  ring

/-- The quartic clock, positive screening branch, and centered Hamiltonian
interface together force a degree-eight algebraic coupling. -/
theorem quartic_interfaceCoupling_algebraicSignature
    (q d : ℝ) (hq4 : q ^ 4 = q + 1) (hq : 1 < q)
    (hd : d ^ 2 = screening (lambda4 q)) (hdpos : 0 < d) :
    interfaceCouplingPolynomialValue
        (interfaceCoupling (lambda4 q) d) = 0 := by
  apply quartic_halfAngle_algebraicSignature q
    (interfaceCoupling (lambda4 q) d) hq4
  exact lambda4_interfaceCoupling_relation q d hq hd hdpos

/-- With the coefficient `t=l/(1+d)`, the Cayley map is exactly the passive
source splitter.  Positivity selects the physical square root and ensures
the half-angle denominator is nonzero. -/
theorem interfaceCayleyMap_eq_passiveSourceSplitter
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d) :
    interfaceCayleyMap (interfaceCoupling l d) =
      passiveSourceSplitter l d := by
  have hden : 1 + d ≠ 0 := by nlinarith
  have hhalf : (1 + d) ^ 2 + l ^ 2 = 2 * (1 + d) := by
    unfold screening at hd
    nlinarith [hd]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [interfaceCayleyMap, interfaceCoupling, passiveSourceSplitter,
      screening] at hd ⊢ <;>
    field_simp [hden] <;>
    rw [hhalf] <;>
    nlinarith [hd]

/-- The passive splitter satisfies the centered interface equation at the
algebraic coefficient `l/(1+d)`. -/
theorem passiveSourceSplitter_satisfies_centeredInterface
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d) :
    interfaceJumpLeft (interfaceCoupling l d) *
        passiveSourceSplitter l d =
      interfaceJumpRight (interfaceCoupling l d) := by
  rw [← interfaceCayleyMap_eq_passiveSourceSplitter l d hd hdpos]
  calc
    interfaceJumpLeft (interfaceCoupling l d) *
        interfaceCayleyMap (interfaceCoupling l d) =
        interfaceJumpLeft (interfaceCoupling l d) *
          (interfaceJumpLeftInverse (interfaceCoupling l d) *
            interfaceJumpRight (interfaceCoupling l d)) := by
              rw [interfaceJumpLeftInverse_mul_right]
    _ = (interfaceJumpLeft (interfaceCoupling l d) *
          interfaceJumpLeftInverse (interfaceCoupling l d)) *
            interfaceJumpRight (interfaceCoupling l d) := by
              rw [Matrix.mul_assoc]
    _ = interfaceJumpRight (interfaceCoupling l d) := by
      rw [interfaceJumpLeft_mul_inverse]
      simp

/-- Capstone: at the exact coefficient `l/(1+d)`, the centered lossless
interface law has the passive splitter as its unique transfer matrix. -/
theorem centeredInterface_uniquely_yields_passiveSourceSplitter
    (l d : ℝ) (hd : d ^ 2 = screening l) (hdpos : 0 < d)
    (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hjump : interfaceJumpLeft (interfaceCoupling l d) * M =
      interfaceJumpRight (interfaceCoupling l d)) :
    M = passiveSourceSplitter l d := by
  rw [centeredInterface_unique_transfer _ M hjump]
  exact interfaceCayleyMap_eq_passiveSourceSplitter l d hd hdpos

#print axioms GravityScreening.centeredInterface_unique_transfer
#print axioms GravityScreening.interfaceCayleyMap_orthogonal
#print axioms GravityScreening.interfaceCayleyMap_det
#print axioms GravityScreening.isotropicInterfaceHamiltonian_centeredVariation
#print axioms GravityScreening.centeredInterface_iff_symplecticImpulse
#print axioms GravityScreening.interfaceCoupling_reconstructs_amplitude
#print axioms GravityScreening.interfaceCoupling_reconstructs_retainedAmplitude
#print axioms GravityScreening.quartic_halfAngle_algebraicSignature
#print axioms GravityScreening.quartic_interfaceCoupling_algebraicSignature
#print axioms GravityScreening.interfaceCayleyMap_eq_passiveSourceSplitter
#print axioms GravityScreening.centeredInterface_uniquely_yields_passiveSourceSplitter

end GravityScreening
