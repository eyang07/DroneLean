import DroneLean.Tier1.Types

namespace DroneLean
namespace Tier1

-- e₃ = (0,0,1), the standard altitude unit vector
noncomputable def e3 : Vec3 := EuclideanSpace.single (2 : Fin 3) 1

-- Net acceleration: thrust u minus gravity e₃
noncomputable def accel (u : Control) : Vec3 := u - e3

-- Euler integration:
--   q_{k+1} = q_k + dt·v_k + ½dt²·(u_k − e₃)
--   v_{k+1} = v_k + dt·(u_k − e₃)
noncomputable def updateOpenLoop (p : Params) (x : State) (u : Control) : State :=
  { q := x.q + p.dt • x.v + (p.dt ^ 2 / 2) • accel u
    v := x.v + p.dt • accel u }

end Tier1
end DroneLean
