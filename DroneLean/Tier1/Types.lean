import Mathlib.Analysis.InnerProductSpace.PiL2

-- ℝ³ with full Euclidean structure (addition, scalar mult, norm, inner product)
abbrev Vec3 := EuclideanSpace ℝ (Fin 3)

-- State space X = TQ ≅ ℝ³ × ℝ³
-- q = position (q 2 is altitude), v = velocity (q̇)
structure State where
  q : Vec3
  v : Vec3

-- Control input u = (u₁, u₂, u₃) ∈ ℝ³
abbrev Control := Vec3

-- All scalar parameters governing the system
structure Params where
  q1Min : ℝ
  q1Max : ℝ
  q2Min : ℝ
  q2Max : ℝ
  q3Min : ℝ
  q3Max : ℝ
  δh : ℝ
  δ3Low : ℝ
  δ3High : ℝ
  uh : ℝ
  u3Min : ℝ
  u3Max : ℝ
  dt : ℝ

-- Validity constraints on parameters
def Params.Valid (p : Params) : Prop :=
  0 < p.δh ∧
  0 < p.δ3Low ∧
  0 < p.δ3High ∧
  2 * p.δh < p.q1Max - p.q1Min ∧
  2 * p.δh < p.q2Max - p.q2Min ∧
  p.δ3Low + p.δ3High < p.q3Max - p.q3Min ∧
  0 < p.uh ∧
  0 ≤ p.u3Min ∧ p.u3Min < 1 ∧ 1 < p.u3Max ∧
  0 < p.dt

-- u is admissible iff it lies in U = [-uh, uh] × [-uh, uh] × [u3Min, u3Max]
def admissible (p : Params) (u : Control) : Prop :=
  -p.uh ≤ u 0 ∧ u 0 ≤ p.uh ∧
  -p.uh ≤ u 1 ∧ u 1 ≤ p.uh ∧
  p.u3Min ≤ u 2 ∧ u 2 ≤ p.u3Max
