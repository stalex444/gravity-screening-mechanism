import GravityScreening.GravitationalWaveObservables

set_option maxRecDepth 10000
set_option maxHeartbeats 1000000

open Polynomial

open scoped IntermediateField

noncomputable section

namespace Polynomial

/-- Over a finite field, an irreducible polynomial divides the Frobenius
polynomial at its own degree. -/
theorem Irreducible.dvd_X_pow_card_pow_natDegree_sub_X
    {K : Type*} [Field K] [Finite K]
    {f : K[X]} (hf : Irreducible f) :
    f ∣ X ^ (Nat.card K) ^ f.natDegree - X := by
  letI : Fact (Irreducible f) := ⟨hf⟩
  let L := AdjoinRoot f
  letI : Field L := AdjoinRoot.instField
  letI : Module.Finite K L :=
    Module.Finite.of_basis (AdjoinRoot.powerBasis hf.ne_zero).basis
  letI : Finite L := Module.finite_of_finite K
  letI : Fintype L := Fintype.ofFinite L
  rw [← AdjoinRoot.mk_eq_zero]
  simp only [map_sub, map_pow, AdjoinRoot.mk_X]
  have hfinrank : Module.finrank K L = f.natDegree :=
    (AdjoinRoot.powerBasis hf.ne_zero).finrank
  have hcard : Nat.card L = (Nat.card K) ^ f.natDegree := by
    rw [Module.natCard_eq_pow_finrank (K := K) (V := L), hfinrank]
  rw [← hcard]
  exact sub_eq_zero.mpr (by
    simpa [Nat.card_eq_fintype_card] using
      (FiniteField.pow_card (AdjoinRoot.root f)))

end Polynomial

namespace GravityScreening

local instance : Fact (Nat.Prime 5) := ⟨by norm_num⟩

abbrev F5 := ZMod 5

/-- Reduction modulo five of the quartic exterior-amplitude polynomial. -/
def quarticExteriorAmplitudePolynomialMod5 : F5[X] :=
  X ^ 8 + 3 * X ^ 6 + 3 * X ^ 4 + 2 * X ^ 2 + 2

private def rabinR1 : F5[X] := X ^ 5
private def rabinR2 : F5[X] := 4 * X ^ 3 + 4 * X
private def rabinR3 : F5[X] := X ^ 7 + 2 * X ^ 5 + 3 * X
private def rabinR4 : F5[X] := 4 * X

private def rabinQ2 : F5[X] :=
  X ^ 17 + 2 * X ^ 15 + X ^ 13 + 4 * X ^ 11 + 4 * X ^ 9 +
    3 * X ^ 5 + 3 * X
private def rabinQ3 : F5[X] :=
  4 * X ^ 7 + 3 * X ^ 5 + 4 * X ^ 3 + X
private def rabinQ4 : F5[X] :=
  X ^ 27 + 2 * X ^ 25 + X ^ 23 + 4 * X ^ 21 + 4 * X ^ 19 +
    2 * X ^ 17 + 2 * X ^ 15 + 2 * X ^ 13 + X ^ 11 +
    3 * X ^ 9 + 2 * X ^ 3 + 3 * X

private def rabinT2 : F5[X] :=
  -X ^ 23 - 2 * X ^ 21 - 3 * X ^ 19 - 5 * X ^ 17 - 6 * X ^ 15 -
    5 * X ^ 13 - 5 * X ^ 11 - 4 * X ^ 9 - 3 * X ^ 7 -
    3 * X ^ 5 - 2 * X ^ 3 - 2 * X
private def rabinT3 : F5[X] :=
  204 * X ^ 15 + 1021 * X ^ 13 + 2043 * X ^ 11 + 2042 * X ^ 9 +
    1018 * X ^ 7 + 201 * X ^ 5 - 2 * X ^ 3 - X
private def rabinT4 : F5[X] :=
  X ^ 33 + 6 * X ^ 31 + 16 * X ^ 29 + 35 * X ^ 27 +
    72 * X ^ 25 + 108 * X ^ 23 + 150 * X ^ 21 + 211 * X ^ 19 +
    194 * X ^ 17 + 212 * X ^ 15 + 213 * X ^ 13 + 79 * X ^ 11 +
    159 * X ^ 9 - 3 * X ^ 7 + 46 * X ^ 5 - 2 * X ^ 3 - 2 * X

private theorem five_mul_poly_eq_zero (t : F5[X]) : 5 * t = 0 := by
  have h5 : (5 : F5[X]) = 0 := by
    change C (5 : F5) = 0
    simpa using congrArg C (ZMod.natCast_self 5)
  rw [h5, zero_mul]

private theorem rabin_fifth_step2 :
    rabinR1 ^ 5 - rabinR2 =
      quarticExteriorAmplitudePolynomialMod5 * rabinQ2 := by
  rw [← sub_eq_zero]
  calc
    rabinR1 ^ 5 - rabinR2 -
          quarticExteriorAmplitudePolynomialMod5 * rabinQ2 =
        5 * rabinT2 := by
      simp only [rabinR1, rabinR2, quarticExteriorAmplitudePolynomialMod5,
        rabinQ2, rabinT2]
      ring
    _ = 0 := five_mul_poly_eq_zero rabinT2

private theorem rabin_fifth_step3 :
    rabinR2 ^ 5 - rabinR3 =
      quarticExteriorAmplitudePolynomialMod5 * rabinQ3 := by
  rw [← sub_eq_zero]
  calc
    rabinR2 ^ 5 - rabinR3 -
          quarticExteriorAmplitudePolynomialMod5 * rabinQ3 =
        5 * rabinT3 := by
      simp only [rabinR2, rabinR3, quarticExteriorAmplitudePolynomialMod5,
        rabinQ3, rabinT3]
      ring
    _ = 0 := five_mul_poly_eq_zero rabinT3

private theorem rabin_fifth_step4 :
    rabinR3 ^ 5 - rabinR4 =
      quarticExteriorAmplitudePolynomialMod5 * rabinQ4 := by
  rw [← sub_eq_zero]
  calc
    rabinR3 ^ 5 - rabinR4 -
          quarticExteriorAmplitudePolynomialMod5 * rabinQ4 =
        5 * rabinT4 := by
      simp only [rabinR3, rabinR4, quarticExteriorAmplitudePolynomialMod5,
        rabinQ4, rabinT4]
      ring
    _ = 0 := five_mul_poly_eq_zero rabinT4

private theorem dvd_fifth_step
    {p a b c : F5[X]} (hab : p ∣ a - b) (hbc : p ∣ b ^ 5 - c) :
    p ∣ a ^ 5 - c := by
  have hpows : p ∣ a ^ 5 - b ^ 5 :=
    hab.trans (sub_dvd_pow_sub_pow a b 5)
  convert hpows.add hbc using 1 <;> ring

private theorem quarticAmplitudeMod5_dvd_frobenius3 :
    quarticExteriorAmplitudePolynomialMod5 ∣ X ^ (5 ^ 3) - rabinR3 := by
  have h1 : quarticExteriorAmplitudePolynomialMod5 ∣ X ^ 5 - rabinR1 := by
    simp [rabinR1]
  have hstep2 : quarticExteriorAmplitudePolynomialMod5 ∣
      rabinR1 ^ 5 - rabinR2 := ⟨rabinQ2, rabin_fifth_step2⟩
  have h2 := dvd_fifth_step h1 hstep2
  have hstep3 : quarticExteriorAmplitudePolynomialMod5 ∣
      rabinR2 ^ 5 - rabinR3 := ⟨rabinQ3, rabin_fifth_step3⟩
  have h3 := dvd_fifth_step h2 hstep3
  convert h3 using 1
  rw [← pow_mul, ← pow_mul]
  norm_num

private theorem quarticAmplitudeMod5_dvd_frobenius4 :
    quarticExteriorAmplitudePolynomialMod5 ∣ X ^ (5 ^ 4) - rabinR4 := by
  have h3 := quarticAmplitudeMod5_dvd_frobenius3
  have hstep4 : quarticExteriorAmplitudePolynomialMod5 ∣
      rabinR3 ^ 5 - rabinR4 := ⟨rabinQ4, rabin_fifth_step4⟩
  have h4 := dvd_fifth_step h3 hstep4
  convert h4 using 1
  rw [← pow_mul]
  norm_num

private def frobenius3Remainder : F5[X] :=
  X ^ 7 + 2 * X ^ 5 + 2 * X
private def frobenius4Remainder : F5[X] := 3 * X

private def bezout3U : F5[X] :=
  4 * X ^ 6 + 3 * X ^ 4 + 4 * X ^ 2 + 1
private def bezout3V : F5[X] :=
  X ^ 7 + 3 * X ^ 5 + 4 * X ^ 3
private def bezout3T : F5[X] :=
  X ^ 14 + 4 * X ^ 12 + 7 * X ^ 10 + 8 * X ^ 8 + 7 * X ^ 6 +
    5 * X ^ 4 + 2 * X ^ 2

private def bezout4V : F5[X] :=
  3 * X ^ 7 + 4 * X ^ 5 + 4 * X ^ 3 + X
private def bezout4T : F5[X] :=
  2 * X ^ 8 + 3 * X ^ 6 + 3 * X ^ 4 + X ^ 2

private theorem bezout_frobenius3 :
    bezout3U * quarticExteriorAmplitudePolynomialMod5 +
        bezout3V * frobenius3Remainder = 2 := by
  rw [← sub_eq_zero]
  calc
    bezout3U * quarticExteriorAmplitudePolynomialMod5 +
          bezout3V * frobenius3Remainder - 2 =
        5 * bezout3T := by
      simp only [bezout3U, quarticExteriorAmplitudePolynomialMod5,
        bezout3V, frobenius3Remainder, bezout3T]
      ring
    _ = 0 := five_mul_poly_eq_zero bezout3T

private theorem bezout_frobenius4 :
    quarticExteriorAmplitudePolynomialMod5 +
        bezout4V * frobenius4Remainder = 2 := by
  rw [← sub_eq_zero]
  calc
    quarticExteriorAmplitudePolynomialMod5 +
          bezout4V * frobenius4Remainder - 2 =
        5 * bezout4T := by
      simp only [quarticExteriorAmplitudePolynomialMod5, bezout4V,
        frobenius4Remainder, bezout4T]
      ring
    _ = 0 := five_mul_poly_eq_zero bezout4T

private theorem two_poly_isUnit : IsUnit (2 : F5[X]) := by
  change IsUnit (C (2 : F5))
  rw [isUnit_C]
  exact isUnit_iff_ne_zero.mpr (by decide)

private theorem no_common_divisor_frobenius3
    {r : F5[X]}
    (hp : r ∣ quarticExteriorAmplitudePolynomialMod5)
    (hg : r ∣ frobenius3Remainder) : IsUnit r := by
  have htwo : r ∣ (2 : F5[X]) := by
    rw [← bezout_frobenius3]
    exact dvd_add (hp.mul_left bezout3U) (hg.mul_left bezout3V)
  apply isUnit_of_dvd_one
  exact (two_poly_isUnit.dvd_mul_left).mp (by simpa using htwo)

private theorem no_common_divisor_frobenius4
    {r : F5[X]}
    (hp : r ∣ quarticExteriorAmplitudePolynomialMod5)
    (hg : r ∣ frobenius4Remainder) : IsUnit r := by
  have htwo : r ∣ (2 : F5[X]) := by
    rw [← bezout_frobenius4]
    exact dvd_add hp (hg.mul_left bezout4V)
  apply isUnit_of_dvd_one
  exact (two_poly_isUnit.dvd_mul_left).mp (by simpa using htwo)

private theorem quarticExteriorAmplitudePolynomialMod5_monic :
    quarticExteriorAmplitudePolynomialMod5.Monic := by
  rw [show quarticExteriorAmplitudePolynomialMod5 =
      X ^ 8 + (3 * X ^ 6 + 3 * X ^ 4 + 2 * X ^ 2 + 2) by
    unfold quarticExteriorAmplitudePolynomialMod5
    ring]
  apply monic_X_pow_add
  compute_degree!

private theorem quarticExteriorAmplitudePolynomialMod5_natDegree :
    quarticExteriorAmplitudePolynomialMod5.natDegree = 8 := by
  rw [show quarticExteriorAmplitudePolynomialMod5 =
      X ^ 8 + (3 * X ^ 6 + 3 * X ^ 4 + 2 * X ^ 2 + 2) by
    unfold quarticExteriorAmplitudePolynomialMod5
    ring]
  rw [natDegree_add_eq_left_of_degree_lt (by compute_degree!)]
  simp

/-- The exterior-amplitude polynomial is irreducible after reduction modulo
five. The proof is a Rabin/Frobenius certificate: every possible factor degree
one through four would divide a certified Frobenius polynomial, but explicit
Bezout identities rule out the degree-three and degree-dividing-four cases. -/
theorem quarticExteriorAmplitudePolynomialMod5_irreducible :
    Irreducible quarticExteriorAmplitudePolynomialMod5 := by
  rw [quarticExteriorAmplitudePolynomialMod5_monic.irreducible_iff_lt_natDegree_lt
    (by
      intro h
      have hd := congrArg natDegree h
      simpa [quarticExteriorAmplitudePolynomialMod5_natDegree] using hd)]
  intro q hqmonic hqdeg hqdiv
  have hqdeg' : 0 < q.natDegree ∧
      q.natDegree ≤ quarticExteriorAmplitudePolynomialMod5.natDegree / 2 := by
    simpa [Finset.mem_Ioc] using hqdeg
  have hqpos : 0 < q.natDegree := hqdeg'.1
  obtain ⟨r, hrirr, hrdvdq⟩ := exists_irreducible_of_natDegree_pos hqpos
  have hrdvdp : r ∣ quarticExteriorAmplitudePolynomialMod5 := hrdvdq.trans hqdiv
  have hrleq : r.natDegree ≤ q.natDegree :=
    natDegree_le_of_dvd hrdvdq hqmonic.ne_zero
  have hqle4 : q.natDegree ≤ 4 := by
    simpa [quarticExteriorAmplitudePolynomialMod5_natDegree] using hqdeg'.2
  have hrpos : 0 < r.natDegree := hrirr.natDegree_pos
  have hrle4 : r.natDegree ≤ 4 := hrleq.trans hqle4
  have hrF : r ∣ X ^ (5 ^ r.natDegree) - X := by
    simpa using hrirr.dvd_X_pow_card_pow_natDegree_sub_X
  have contradiction3 : r.natDegree = 3 → False := by
    intro hdeg
    have hF3 : r ∣ X ^ (5 ^ 3) - X := by simpa [hdeg] using hrF
    have hdiff : r ∣ X ^ (5 ^ 3) - rabinR3 :=
      hrdvdp.trans quarticAmplitudeMod5_dvd_frobenius3
    have hrem : r ∣ frobenius3Remainder := by
      have h := dvd_sub hF3 hdiff
      convert h using 1 <;>
        simp only [rabinR3, frobenius3Remainder] <;> ring
    exact hrirr.not_isUnit (no_common_divisor_frobenius3 hrdvdp hrem)
  have contradiction124 : r.natDegree ∣ 4 → False := by
    intro hdeg
    have hF4 : r ∣ X ^ (5 ^ 4) - X :=
      hrF.trans (dvd_pow_pow_sub_self_of_dvd hdeg)
    have hdiff : r ∣ X ^ (5 ^ 4) - rabinR4 :=
      hrdvdp.trans quarticAmplitudeMod5_dvd_frobenius4
    have hrem : r ∣ frobenius4Remainder := by
      have h := dvd_sub hF4 hdiff
      convert h using 1 <;>
        simp only [rabinR4, frobenius4Remainder] <;> ring
    exact hrirr.not_isUnit (no_common_divisor_frobenius4 hrdvdp hrem)
  interval_cases hdeg : r.natDegree
  · exact contradiction124 (by norm_num [hdeg])
  · exact contradiction124 (by norm_num [hdeg])
  · exact contradiction3 rfl
  · exact contradiction124 (by norm_num [hdeg])


/-- The monic integer polynomial satisfied by the quartic exterior amplitude. -/
def quarticExteriorAmplitudePolynomialInt : ℤ[X] :=
  X ^ 8 + 3 * X ^ 6 - 2 * X ^ 4 + 22 * X ^ 2 - 23

private theorem quarticExteriorAmplitudePolynomialInt_monic :
    quarticExteriorAmplitudePolynomialInt.Monic := by
  rw [show quarticExteriorAmplitudePolynomialInt =
      X ^ 8 + (3 * X ^ 6 - 2 * X ^ 4 + 22 * X ^ 2 - 23) by
    unfold quarticExteriorAmplitudePolynomialInt
    ring]
  apply monic_X_pow_add
  compute_degree!

private theorem quarticExteriorAmplitudePolynomialInt_natDegree :
    quarticExteriorAmplitudePolynomialInt.natDegree = 8 := by
  rw [show quarticExteriorAmplitudePolynomialInt =
      X ^ 8 + (3 * X ^ 6 - 2 * X ^ 4 + 22 * X ^ 2 - 23) by
    unfold quarticExteriorAmplitudePolynomialInt
    ring]
  rw [natDegree_add_eq_left_of_degree_lt (by compute_degree!)]
  simp

private theorem quarticExteriorAmplitudePolynomialInt_map_mod5 :
    quarticExteriorAmplitudePolynomialInt.map (Int.castRingHom F5) =
      quarticExteriorAmplitudePolynomialMod5 := by
  rw [← sub_eq_zero]
  calc
    quarticExteriorAmplitudePolynomialInt.map (Int.castRingHom F5) -
          quarticExteriorAmplitudePolynomialMod5 =
        5 * (-X ^ 4 + 4 * X ^ 2 - 5) := by
      simp [quarticExteriorAmplitudePolynomialInt,
        quarticExteriorAmplitudePolynomialMod5]
      ring
    _ = 0 := five_mul_poly_eq_zero (-X ^ 4 + 4 * X ^ 2 - 5)

/-- Reduction modulo five certifies that the integer exterior-amplitude
polynomial is irreducible. -/
theorem quarticExteriorAmplitudePolynomialInt_irreducible :
    Irreducible quarticExteriorAmplitudePolynomialInt := by
  apply quarticExteriorAmplitudePolynomialInt_monic.irreducible_of_irreducible_map
      (Int.castRingHom F5) quarticExteriorAmplitudePolynomialInt
  rw [quarticExteriorAmplitudePolynomialInt_map_mod5]
  exact quarticExteriorAmplitudePolynomialMod5_irreducible

/-- The exterior-amplitude polynomial over the rationals. -/
def quarticExteriorAmplitudePolynomialRat : ℚ[X] :=
  quarticExteriorAmplitudePolynomialInt.map (algebraMap ℤ ℚ)

private theorem quarticExteriorAmplitudePolynomialRat_monic :
    quarticExteriorAmplitudePolynomialRat.Monic := by
  exact quarticExteriorAmplitudePolynomialInt_monic.map (algebraMap ℤ ℚ)

private theorem quarticExteriorAmplitudePolynomialRat_natDegree :
    quarticExteriorAmplitudePolynomialRat.natDegree = 8 := by
  rw [quarticExteriorAmplitudePolynomialRat,
    natDegree_map_eq_of_injective Int.cast_injective]
  exact quarticExteriorAmplitudePolynomialInt_natDegree

/-- The exterior-amplitude polynomial remains irreducible over `ℚ`. -/
theorem quarticExteriorAmplitudePolynomialRat_irreducible :
    Irreducible quarticExteriorAmplitudePolynomialRat := by
  change Irreducible
    (quarticExteriorAmplitudePolynomialInt.map (algebraMap ℤ ℚ))
  exact (Polynomial.Monic.irreducible_iff_irreducible_map_fraction_map
    quarticExteriorAmplitudePolynomialInt_monic).mp
      quarticExteriorAmplitudePolynomialInt_irreducible

private theorem quarticExteriorAmplitudePolynomialRat_aeval
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    aeval A quarticExteriorAmplitudePolynomialRat = 0 := by
  dsimp only
  have hsig := quarticExteriorAmplitude_algebraicSignature q hq4 hq1
  dsimp only at hsig
  simpa [quarticExteriorAmplitudePolynomialRat,
    quarticExteriorAmplitudePolynomialInt, aeval_def] using hsig



private theorem quarticGenerator_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) :
    (minpoly ℚ q).natDegree = 4 := by
  let pz : ℤ[X] := X ^ 4 - X - 1
  let p : ℚ[X] := pz.map (algebraMap ℤ ℚ)
  have hpzirr : Irreducible pz := by
    simpa [pz] using
      X_pow_sub_X_sub_one_irreducible (n := 4) (by norm_num)
  have hpzmonic : pz.Monic := by
    rw [show pz = X ^ 4 - (X + 1) by
      dsimp [pz]
      ring]
    apply monic_X_pow_sub
    compute_degree!
  have hpirr : Irreducible p := by
    change Irreducible (pz.map (algebraMap ℤ ℚ))
    exact (Polynomial.Monic.irreducible_iff_irreducible_map_fraction_map
      hpzmonic).mp hpzirr
  have hroot : aeval q p = 0 := by
    dsimp [p, pz]
    simp [aeval_def]
    nlinarith [hq4]
  have heq := minpoly.eq_of_irreducible hpirr hroot
  have hpmonic : p.Monic := hpzmonic.map (algebraMap ℤ ℚ)
  have hlc : p.leadingCoeff = 1 := hpmonic
  rw [hlc, inv_one, C_1, mul_one] at heq
  rw [← heq]
  dsimp [p]
  rw [natDegree_map_eq_of_injective Int.cast_injective]
  dsimp [pz]
  compute_degree!

/-- The quartic generator is rationally recoverable from the exterior
amplitude.  Thus the observable retains the full quartic field rather than
merely sharing a polynomial consequence with it. -/
theorem quarticRoot_eq_rationalFunction_exteriorAmplitude
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    q = (4 - A ^ 2 + A ^ 6) / (8 - 4 * A ^ 2 - A ^ 6) := by
  dsimp only
  let s : ℝ := (2 * q - 1) / q ^ 2
  let A : ℝ := Real.sqrt s
  have hq0 : q ≠ 0 := by linarith
  have hspos : 0 < s := by
    dsimp [s]
    exact div_pos (by linarith) (sq_pos_of_ne_zero hq0)
  have hslt : s < 1 := by
    dsimp [s]
    rw [div_lt_one (sq_pos_of_ne_zero hq0)]
    nlinarith [sq_nonneg (q - 1)]
  have hA2 : A ^ 2 = s := by
    dsimp [A]
    exact Real.sq_sqrt hspos.le
  have hroot : q ^ 4 - q - 1 = 0 := by nlinarith [hq4]
  have hs : s * q ^ 2 - (2 * q - 1) = 0 := by
    dsimp [s]
    field_simp [hq0]
    ring
  have hrecovery :
      q * (8 - 4 * s - s ^ 3) - (4 - s + s ^ 3) = 0 := by
    linear_combination
      s ^ 3 * hroot + (-s * (s * q ^ 2 + 2 * q - 1) - 4) * hs
  have hs3lt : s ^ 3 < 1 := by
    exact pow_lt_one₀ hspos.le hslt (by norm_num)
  have hdenpos : 0 < 8 - 4 * s - s ^ 3 := by nlinarith
  have hformula : q = (4 - s + s ^ 3) / (8 - 4 * s - s ^ 3) := by
    apply (eq_div_iff (ne_of_gt hdenpos)).2
    nlinarith [hrecovery]
  change q = (4 - A ^ 2 + A ^ 6) / (8 - 4 * A ^ 2 - A ^ 6)
  calc
    q = (4 - s + s ^ 3) / (8 - 4 * s - s ^ 3) := hformula
    _ = (4 - A ^ 2 + A ^ 6) / (8 - 4 * A ^ 2 - A ^ 6) := by
      rw [show A ^ 6 = (A ^ 2) ^ 3 by ring, hA2]


/-- The quartic generator belongs to the field generated by the exterior
amplitude. -/
theorem quarticGenerator_mem_adjoinExteriorAmplitude
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    q ∈ (ℚ⟮A⟯ : IntermediateField ℚ ℝ) := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  let K : IntermediateField ℚ ℝ := ℚ⟮A⟯
  have hA : A ∈ K := IntermediateField.mem_adjoin_simple_self ℚ A
  have h4 : (4 : ℝ) ∈ K := by norm_num [K]
  have h8 : (8 : ℝ) ∈ K := by norm_num [K]
  have hformula :=
    quarticRoot_eq_rationalFunction_exteriorAmplitude q hq4 hq1
  change q ∈ K
  rw [hformula]
  exact K.div_mem
    (K.add_mem (K.sub_mem h4 (K.toSubfield.pow_mem hA 2))
      (K.toSubfield.pow_mem hA 6))
    (K.sub_mem
      (K.sub_mem h8 (K.mul_mem h4 (K.toSubfield.pow_mem hA 2)))
      (K.toSubfield.pow_mem hA 6))

/-- The conditional quartic exterior amplitude has algebraic degree exactly
`8` over `ℚ`.  This is distinct from the degree-`12` compositum generated by
the joint `ρQ` ruler. -/
theorem quarticExteriorAmplitude_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    (minpoly ℚ A).natDegree = 8 := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  have hroot : aeval A quarticExteriorAmplitudePolynomialRat = 0 := by
    simpa [A] using quarticExteriorAmplitudePolynomialRat_aeval q hq4 hq1
  have heq := minpoly.eq_of_irreducible
    quarticExteriorAmplitudePolynomialRat_irreducible hroot
  have hlc : quarticExteriorAmplitudePolynomialRat.leadingCoeff = 1 :=
    quarticExteriorAmplitudePolynomialRat_monic
  rw [hlc, inv_one, C_1, mul_one] at heq
  rw [← heq]
  exact quarticExteriorAmplitudePolynomialRat_natDegree



/-- The amplitude field is exactly quadratic over the embedded quartic field:
its absolute degrees are `8` and `4`, and the quartic generator is rationally
recoverable from the amplitude. -/
theorem quarticExteriorAmplitude_relativeDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let A := Real.sqrt ((2 * q - 1) / q ^ 2)
    (ℚ⟮q⟯ : IntermediateField ℚ ℝ).relfinrank ℚ⟮A⟯ = 2 := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  have hqmem : q ∈ (ℚ⟮A⟯ : IntermediateField ℚ ℝ) := by
    simpa [A] using quarticGenerator_mem_adjoinExteriorAmplitude q hq4 hq1
  have hle : (ℚ⟮q⟯ : IntermediateField ℚ ℝ) ≤ ℚ⟮A⟯ :=
    IntermediateField.adjoin_simple_le_iff.mpr hqmem
  have hqdeg : Module.finrank ℚ (ℚ⟮q⟯ : IntermediateField ℚ ℝ) = 4 := by
    rw [IntermediateField.adjoin.finrank
      ((IsAlgebraic.isIntegral
        ⟨(X ^ 4 - X - 1 : ℚ[X]), by
          intro hzero
          have hdegree : (X ^ 4 - X - 1 : ℚ[X]).degree = 4 := by
            compute_degree!
          rw [hzero] at hdegree
          norm_num at hdegree, by
          simp [aeval_def]
          nlinarith [hq4]⟩) : IsIntegral ℚ q)]
    exact quarticGenerator_minpoly_natDegree q hq4
  have hAroot : aeval A quarticExteriorAmplitudePolynomialRat = 0 := by
    simpa [A] using quarticExteriorAmplitudePolynomialRat_aeval q hq4 hq1
  have hAint : IsIntegral ℚ A :=
    (IsAlgebraic.isIntegral
      ⟨quarticExteriorAmplitudePolynomialRat,
        quarticExteriorAmplitudePolynomialRat_irreducible.ne_zero, hAroot⟩)
  have hAdeg : Module.finrank ℚ (ℚ⟮A⟯ : IntermediateField ℚ ℝ) = 8 := by
    rw [IntermediateField.adjoin.finrank hAint]
    simpa [A] using quarticExteriorAmplitude_minpoly_natDegree q hq4 hq1
  have htower := IntermediateField.finrank_bot_mul_relfinrank hle
  rw [hqdeg, hAdeg] at htower
  change (ℚ⟮q⟯ : IntermediateField ℚ ℝ).relfinrank ℚ⟮A⟯ = 2
  omega

/-- The reciprocal standard-siren distance response has the same exact
algebraic degree `8` as the exterior amplitude. -/
theorem quarticStandardSirenResponse_minpoly_natDegree
    (q : ℝ) (hq4 : q ^ 4 = q + 1) (hq1 : 1 < q) :
    let R := 1 / Real.sqrt ((2 * q - 1) / q ^ 2)
    (minpoly ℚ R).natDegree = 8 := by
  dsimp only
  let A : ℝ := Real.sqrt ((2 * q - 1) / q ^ 2)
  let R : ℝ := 1 / A
  have hroot : aeval A quarticExteriorAmplitudePolynomialRat = 0 := by
    simpa [A] using quarticExteriorAmplitudePolynomialRat_aeval q hq4 hq1
  have hAlgA : IsAlgebraic ℚ A :=
    ⟨quarticExteriorAmplitudePolynomialRat,
      quarticExteriorAmplitudePolynomialRat_irreducible.ne_zero, hroot⟩
  have hIntA : IsIntegral ℚ A := hAlgA.isIntegral
  have hIntR : IsIntegral ℚ R := by
    simpa [R, one_div] using (hAlgA.inv.isIntegral : IsIntegral ℚ (A⁻¹))
  have hadjoin : ℚ⟮R⟯ = ℚ⟮A⟯ := by
    dsimp [R]
    rw [one_div]
    apply le_antisymm
    · rw [IntermediateField.adjoin_simple_le_iff]
      exact (ℚ⟮A⟯).inv_mem
        (IntermediateField.mem_adjoin_simple_self ℚ A)
    · rw [IntermediateField.adjoin_simple_le_iff]
      have hmem := (ℚ⟮(A⁻¹)⟯).inv_mem
        (IntermediateField.mem_adjoin_simple_self ℚ (A⁻¹))
      simpa using hmem
  have hdegA : (minpoly ℚ A).natDegree = 8 := by
    simpa [A] using quarticExteriorAmplitude_minpoly_natDegree q hq4 hq1
  calc
    (minpoly ℚ R).natDegree = Module.finrank ℚ ℚ⟮R⟯ :=
      (IntermediateField.adjoin.finrank hIntR).symm
    _ = Module.finrank ℚ ℚ⟮A⟯ := by rw [hadjoin]
    _ = (minpoly ℚ A).natDegree := IntermediateField.adjoin.finrank hIntA
    _ = 8 := hdegA

end GravityScreening
