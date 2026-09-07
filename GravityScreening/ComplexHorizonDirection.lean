import GravityScreening.TetrahedralFisherCone
import GravityScreening.ErasureDilation

/-!
# The unique hidden direction in one complex place

In the real two-plane underlying `ℂ`, fix the visible unit branch to the real
axis.  A hidden branch that is Hilbert-normalized and real-orthogonal to it is
necessarily `I` or `-I`.  The conjugation-twisted form reads this direction as
positive, while the untwisted trace form reads it as negative.  This file
kernel-checks the uniqueness and the resulting quartic screening identity.

Identifying the one complex place with a physical horizon branch remains a
physical premise.
-/

namespace GravityScreening

/-- Response from the visible real unit into a normalized hidden direction. -/
noncomputable def complexHorizonResponse (l : ℝ) (u : ℂ) : ℂ :=
  1 + (l : ℂ) * u

/-- In one complex place, the Hilbert-unit directions real-orthogonal to the
visible real unit are exactly the two orientations of the imaginary axis. -/
theorem complex_orthogonal_unit_eq_I_or_neg_I
    (u : ℂ) (horth : u.re = 0) (hunit : Complex.normSq u = 1) :
    u = Complex.I ∨ u = -Complex.I := by
  have himsq : u.im ^ 2 = (1 : ℝ) ^ 2 := by
    rw [Complex.normSq_apply] at hunit
    nlinarith
  have him : u.im = 1 ∨ u.im = -1 :=
    sq_eq_sq_iff_eq_or_eq_neg.mp himsq
  rcases him with him | him
  · left
    apply Complex.ext
    · simp [horth]
    · simp [him]
  · right
    apply Complex.ext
    · simp [horth]
    · simp [him]

/-- A positive imaginary orientation selects `I` from the two algebraically
allowed hidden directions. -/
theorem complex_oriented_orthogonal_unit_eq_I
    (u : ℂ) (horth : u.re = 0) (hunit : Complex.normSq u = 1)
    (horient : 0 < u.im) :
    u = Complex.I := by
  rcases complex_orthogonal_unit_eq_I_or_neg_I u horth hunit with hu | hu
  · exact hu
  · rw [hu] at horient
    norm_num at horient

/-- The Hilbert and intrinsic trace forms assign opposite signs to the same
normalized hidden direction. -/
theorem complex_orthogonal_unit_two_forms
    (u : ℂ) (horth : u.re = 0) (hunit : Complex.normSq u = 1) :
    normalizedHermitianTrace u = 1 ∧
      normalizedIntrinsicTrace u = -1 := by
  rcases complex_orthogonal_unit_eq_I_or_neg_I u horth hunit with hu | hu
  · subst u
    norm_num [normalizedHermitianTrace, normalizedIntrinsicTrace,
      Algebra.traceForm_apply, Algebra.trace_complex_apply]
  · subst u
    norm_num [normalizedHermitianTrace, normalizedIntrinsicTrace,
      Algebra.traceForm_apply, Algebra.trace_complex_apply]

/-- Every normalized hidden orientation gives the same sum/difference pair
for a response of amplitude `l`. -/
theorem complexHorizonResponse_two_forms
    (l : ℝ) (u : ℂ) (horth : u.re = 0)
    (hunit : Complex.normSq u = 1) :
    normalizedHermitianTrace (complexHorizonResponse l u) = 1 + l ^ 2 ∧
      normalizedIntrinsicTrace (complexHorizonResponse l u) = screening l := by
  rcases complex_orthogonal_unit_eq_I_or_neg_I u horth hunit with hu | hu
  · subst u
    constructor
    · simpa [complexHorizonResponse, affineComplexResponse] using
        normalizedHermitianTrace_affine l
    · simpa [complexHorizonResponse, affineComplexResponse] using
        normalizedIntrinsicTrace_affine l
  · subst u
    constructor
    · have h := normalizedHermitianTrace_affine (-l)
      simpa [complexHorizonResponse, affineComplexResponse] using h
    · have h := normalizedIntrinsicTrace_affine (-l)
      simpa [complexHorizonResponse, affineComplexResponse, screening] using h

/-- At the quartic Perron amplitude, the unique hidden complex direction and
the global quartic timelike response subtract the same Born mass. -/
theorem quartic_complex_hidden_direction_bridge
    (q : ℝ) (hq : q ^ 4 = q + 1) (hq1 : 1 < q)
    (u : ℂ) (horth : u.re = 0) (hunit : Complex.normSq u = 1) :
    let hiddenMass := ∑ i, scalarOutcomeBranch (lambda4 q)
      (normalizedQuarticPerron q) i
    (u = Complex.I ∨ u = -Complex.I) ∧
      hiddenMass = lambda4 q ^ 2 ∧
      normalizedHermitianTrace
          (complexHorizonResponse (lambda4 q) u) = 1 + hiddenMass ∧
      normalizedIntrinsicTrace
          (complexHorizonResponse (lambda4 q) u) = 1 - hiddenMass ∧
      quarticTracePair (quarticTraceResponse (lambda4 q))
          (quarticTraceResponse (lambda4 q)) = 1 - hiddenMass := by
  dsimp
  have hdir := complex_orthogonal_unit_eq_I_or_neg_I u horth hunit
  have hforms := complexHorizonResponse_two_forms
    (lambda4 q) u horth hunit
  have hsplit := quarticPerron_BornBranch_split q hq hq1
  refine ⟨hdir, hsplit.1, ?_, ?_, ?_⟩
  · rw [hforms.1, hsplit.1]
  · rw [hforms.2, hsplit.1]
    rfl
  · rw [quarticTraceResponse_sq, hsplit.1]
    rfl

#print axioms GravityScreening.complex_orthogonal_unit_eq_I_or_neg_I
#print axioms GravityScreening.complex_oriented_orthogonal_unit_eq_I
#print axioms GravityScreening.complex_orthogonal_unit_two_forms
#print axioms GravityScreening.complexHorizonResponse_two_forms
#print axioms GravityScreening.quartic_complex_hidden_direction_bridge

end GravityScreening
