## Page 1

Gas Dynamics 1
Governing equations
Image: NASA


## Page 2

Governing equations
7 equations are required (5 in 1D):
•
Conservation of mass – continuity (1 equation)
•
Conservation of momentum (3 equations in 3D/ 1 equation in 1D)
•
Conservation of energy (1 equation)
•
Equations of state (2 equations)


## Page 3

Conservation of mass
Conservative form
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑢
𝜕𝑥+ 𝜕𝜌𝑣
𝜕𝑦+ 𝜕𝜌𝑤
𝜕𝑧= 0
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Non-conservative form
𝜕𝜌
𝜕𝑡+ 𝑢𝜕𝜌
𝜕𝑥+ 𝑣𝜕𝜌
𝜕𝑦+ 𝑤𝜕𝜌
𝜕𝑧+ 𝜌𝜕𝑢
𝜕𝑥+ 𝜕𝑣
𝜕𝑦+ 𝜕𝑤
𝜕𝑧
= 0
𝐷𝜌
𝐷𝑡+ 𝜌𝜕𝑢
𝜕𝑥+ 𝜕𝑣
𝜕𝑦+ 𝜕𝑤
𝜕𝑧
= 0
Mass is neither created nor destroyed
Using vector notation:
Using index notation with the Einstein convention:
𝜕𝜌𝑈𝑖
𝜕𝑡
+ 𝜕𝜌𝑈𝑖
𝜕𝑥𝑖
= 0
𝜕𝜌
𝜕𝑡+ 𝜌𝜕𝑈𝑖
𝜕𝑥𝑖
+ 𝑈𝑖
𝜕𝜌
𝜕𝑥𝑖
= 0
or
𝐷𝜌
𝐷𝑡+ 𝜌𝜕𝑈𝑖
𝜕𝑥𝑖
= 0
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
or
𝐷𝜌
𝐷𝑡+ 𝜌∇∙ഥ𝑈= 0


## Page 4

Conservation of momentum
Conservative form
𝜕
𝜕𝑡𝜌ഥ𝑈+ ∇∙𝜌ഥ𝑈ഥ𝑈= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
Non-conservative form
𝜌
𝜕ഥ𝑈
𝜕𝑡+ (ഥ𝑈∙∇)ഥ𝑈
= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
𝜌𝐷ഥ𝑈
𝐷𝑡= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
Newton’s second law
Using vector notation:
Using index notation with the Einstein convention:
𝜕(𝜌𝑈𝑖)
𝜕𝑡
+ 𝜕(𝜌𝑈𝑖𝑈𝑗)
𝜕𝑥𝑗
= −𝑝
𝜕𝑥𝑖
+ 𝜏𝑖𝑗
𝜕𝑥𝑖
+ 𝜌𝑔
𝜌
𝜕𝑈𝑖
𝜕𝑡+ 𝑈𝑗
𝜕𝑈𝑖
𝜕𝑥𝑗
= −𝜕𝑝
𝜕𝑥𝑖
+ 𝜕𝜏𝑖𝑗
𝜕𝑥𝑖
+ 𝜌𝑔
𝜌𝐷𝑈𝑖
𝐷𝑡= −𝜕𝑝
𝜕𝑥𝑖
+ 𝜕𝜏𝑖𝑗
𝜕𝑥𝑖
+ 𝜌𝑔


## Page 5

Conservation of momentum
Conservative form
𝜕
𝜕𝑡𝜌ഥ𝑈+ ∇∙𝜌ഥ𝑈ഥ𝑈= −∇𝑝
Non-conservative form
𝜌
𝜕ഥ𝑈
𝜕𝑡+ (ഥ𝑈∙∇)ഥ𝑈
= −∇𝑝
𝜌𝐷ഥ𝑈
𝐷𝑡= −∇𝑝
In this course we consider inviscid flow (𝜏= 0) and neglect body forces:
Using vector notation:
Using index notation with the Einstein convention:
𝜕(𝜌𝑈𝑖)
𝜕𝑡
+ 𝜕(𝜌𝑈𝑖𝑈𝑗)
𝜕𝑥𝑗
= −𝑝
𝜕𝑥𝑖
𝜌
𝜕𝑈𝑖
𝜕𝑡+ 𝑈𝑗
𝜕𝑈𝑖
𝜕𝑥𝑗
= −𝜕𝑝
𝜕𝑥𝑖
𝜌𝐷𝑈𝑖
𝐷𝑡= −𝜕𝑝
𝜕𝑥𝑖


## Page 6

Conservation of energy
1st law of thermodynamics: Energy cannot either be created or destroyed, it can only change form, therefore 
need to balance
For a closed system:
𝑑𝐸
𝑑𝑡=
ሶ𝑄−
ሶ𝑊
𝐸=
𝑒+ 𝑈2
2 + 𝑔𝑧
Energy (𝐸) of a fluid element consists of:
𝑒– internal energy 
𝑈2
2 - kinetic energy
𝑔𝑧– potential energy
Energies per unit mass
Rate of change in energy of fluid as it flows = rate of heat added to the 
control volume from surrounding + rate of work done on a fluid inside 
control volume


## Page 7

Conservation of energy
The rate of total heat addition = rate of volumetric heating + viscous heat addition 
ሶ𝑄= ׬𝑉
ሶ𝑞𝜌𝑑𝑉+ ሶ𝑄𝑣𝑖𝑠𝑐𝑜𝑢𝑠
ሶ𝑞- volumetric heat addition per unit mass
The rate of work done on a moving body = velocity x component of force in the direction of velocity
The rate of work done on fluid inside CV due to pressure on CS:
−න
𝐴
(𝑝𝑑𝐴) ∙ഥ𝑈
The rate of work done on fluid inside CV due body forces:
න
𝑉
(𝜌f𝑑𝑉) ∙ഥ𝑈
ሶ𝑊= −න
𝐴
𝑝𝑑𝐴∙ഥ𝑈+ න
𝑉
𝜌f𝑑𝑉∙ഥ𝑈+
ሶ𝑊𝑣𝑖𝑠𝑐𝑜𝑢𝑠


## Page 8

Conservation of energy
The rate of change of total energy = time rate of change of total energy + net rate of flow of total energy across CV
𝑑𝐸
𝑑𝑡= 𝜕
𝜕𝑡න
𝑉
𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧𝑑𝑉+ න
𝐴
𝜌ഥ𝑈𝑑𝐴
𝑒+
ഥ𝑈2
2 + 𝑔𝑧
Putting everything together:
𝜕
𝜕𝑡න
𝑉
𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧𝑑𝑉+ න
𝐴
𝜌ഥ𝑈𝑑𝐴
𝑒+
ഥ𝑈2
2 + 𝑔𝑧
= න
𝑉
ሶ𝑞𝜌𝑑𝑉+ ሶ𝑄𝑣𝑖𝑠𝑐𝑜𝑢𝑠−න
𝐴
𝑝𝑑𝐴∙ഥ𝑈+ න
𝑉
𝜌f𝑑𝑉∙ഥ𝑈+
ሶ𝑊𝑣𝑖𝑠𝑐𝑜𝑢𝑠
Following previous approach we convert surface integrals to volume integrals. Since this is valid for any control 
volume we get:
𝜕
𝜕𝑡𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧
+ ∇∙𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧
ഥ𝑈
= ሶ𝑞𝜌−∇∙𝑝ഥ𝑈+ 𝜌f ∙ഥ𝑈+
ሶ𝑄′𝑣𝑖𝑠𝑐𝑜𝑢𝑠+
ሶ𝑊′𝑣𝑖𝑠𝑐𝑜𝑢𝑠


## Page 9

Conservation of energy
If the flow is steady (
𝜕
𝜕𝑡= 0), inviscid ( ሶ𝑄𝑣𝑖𝑠𝑐𝑜𝑢𝑠= 0,
ሶ𝑊𝑣𝑖𝑠𝑐𝑜𝑢𝑠= 0), adiabatic (no heat addition ሶ𝑞= 0), without body 
forces (f = 0), and ignoring potential energy (𝑔𝑧= 0)
∇∙𝜌𝑒+
ഥ𝑈2
2
ഥ𝑈
= −∇∙𝑝ഥ𝑈


## Page 10

Conservation of energy
Let 
𝜙= 𝑒+
ഥ𝑈2
2 + 𝑔𝑧
Then 
𝜕
𝜕𝑡𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧
= 𝜕(𝜌𝜙)
𝜕𝑡
∇∙𝜌𝑒+
ഥ𝑈2
2 + 𝑔𝑧
ഥ𝑈
= ∇∙𝜌𝜙ഥ𝑈= 𝜌ഥ𝑈∙∇𝜙+ 𝜙∇∙𝜌ഥ𝑈
Combining together
𝜕(𝜌𝜙)
𝜕𝑡
+ ∇∙𝜌𝜙ഥ𝑈= 𝜌𝜕𝜙
𝜕𝑡+ ഥ𝑈∙∇𝜙
+ 𝜙𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈
Thus
𝜕𝜌𝜙
𝜕𝑡+ ∇∙𝜌𝜙ഥ𝑈= 𝜌𝐷𝜙
𝐷𝑡
= 0 Continuity equation


## Page 11

Conservation of energy
𝜌𝐷𝜙
𝐷𝑡= ሶ𝑞𝜌−∇∙𝑝ഥ𝑈+ 𝜌f ∙ഥ𝑈+
ሶ𝑄′𝑣𝑖𝑠𝑐𝑜𝑢𝑠+
ሶ𝑊′𝑣𝑖𝑠𝑐𝑜𝑢𝑠
Mechanical energy was previously derived in momentum equation therefore can be subtracted from energy 
equation. This will give us:
𝜌𝐷𝑒
𝐷𝑡= ሶ𝑞𝜌−∇∙𝑝ഥ𝑈+ ሶ𝑄′𝑣𝑖𝑠𝑐𝑜𝑢𝑠
For adiabatic inviscid flow:
𝜌𝐷𝑒
𝐷𝑡= −∇∙𝑝ഥ𝑈


## Page 12

Perfect (ideal) gas
Perfect (ideal) gas – a gas in which which intermolecular forces are neglected
Equation of state for perfect gas:
𝑝𝑉= 𝑛𝑅𝑇,
where 
𝑝– pressure
𝑉– volume of the system
𝑛– amount of substance of gas (number of moles) 
𝑅– ideal (universal) gas constant (𝑅= 8.314
𝐽
mol∙𝐾) – same for all gasses
𝑇– temperature 
𝑛= 𝑚
𝑀,
𝑚– mass of the gas
𝑀– molar mass
Hence
𝑝𝑉= 𝑚𝑅𝑠𝑇,
𝑅𝑠– specific gas constant (for air 𝑅𝑠= 287
𝐽
𝑘𝑔∙𝐾)
𝑅𝑠=
𝑅
𝑀


## Page 13

Perfect gas
Other forms of the equation of state for perfect gas:
Diving by the mass of the gas we get:
𝑝𝜗= 𝑅𝑠𝑇,
where 
𝜗– specific volume
Since 𝜌= 1/𝜗
𝑝= 𝜌𝑅𝑠𝑇


## Page 14

Practical example 1
Virginia Tech 23 x 23 cm supersonic/transonic (https://www.aoe.vt.edu/research/facilities/superson.html)
•
The compressor can pump the storage system up to 51 𝑎𝑡𝑚
•
Air storage system consists of two tanks with a total volume of 23 𝑚3
What maximum mass of air can be stored in the tanks at room temperature (293.15 𝐾)?
𝑝= 𝜌𝑅𝑠𝑇
𝜌=
𝑝
𝑅𝑠𝑇
1 𝑎𝑡𝑚= 1.01 × 105 𝑁/𝑚2
𝑅𝑠= 287
𝐽
𝑘𝑔∙𝐾
𝜌= 51 × 1.01 × 105
287 × 293.15
≈61.22 𝑘𝑔/𝑚3
𝑚= 61.22 × 23 ≈1408.06 𝑘𝑔


## Page 15

Internal energy and enthalpy
For an equilibrium system of a real gas as well as for a chemically reacting mixture of perfect gases internal 
energy is a function of both temperature and volume.
𝑒– specific internal energy (per unit mass)
ℎ= 𝑒+ 𝑝𝜗– enthalpy per unit mass
𝑒= 𝑒𝑇, 𝜗
ℎ= ℎ𝑇, 𝑝
For thermally perfect gas (no chemical reactions and no intermolecular forces):
𝑒= 𝑒𝑇
ℎ= ℎ𝑇
𝑑𝑒= 𝑐𝑣𝑑𝑇
𝑑ℎ= 𝑐𝑝𝑑𝑇
𝑐𝑣– specific heat at constant volume
𝑐𝑝–specific heat at constant pressure


## Page 16

Internal energy and enthalpy
For calorically perfect gas (gas where specific heats are constant)
𝑒= 𝑐𝑣𝑇
ℎ= 𝑐𝑝𝑇
It can be assumed that 𝑒= ℎ= 0 at 𝑇= 0
Using specific internal energy and enthalpy we can get the following relation: 
ℎ−𝑒= 𝑐𝑝𝑇−𝑐𝑣𝑇
𝑒+ 𝑝𝜗−𝑒= 𝑇(𝑐𝑝−𝑐𝑣)
𝑝𝜗= 𝑇(𝑐𝑝−𝑐𝑣)
Recall 𝑝= 𝜌𝑅𝑠𝑇
𝑅𝑠= 𝑐𝑝−𝑐𝑣
Holds for calorically perfect and thermally perfect gasses 
Does not hold for chemically reacting and real gasses 


## Page 17

Internal energy and enthalpy
We can get two useful forms of 𝑅𝑠= 𝑐𝑝−𝑐𝑣
1) Dividing by 𝑐𝑝
1 −𝑐𝑣
𝑐𝑝
= 𝑅𝑠
𝑐𝑝
γ ≡
𝑐𝑣
𝑐𝑝– specific heat ratio
γ = 1.4 for air
1 −γ = 𝑅𝑠
𝑐𝑝
Hence, 
𝑐𝑝= γ𝑅𝑠
γ −1


## Page 18

Internal energy and enthalpy
We can get two useful forms of 𝑅𝑠= 𝑐𝑝−𝑐𝑣
2)   Dividing by 𝑐𝑣
𝑐𝑝
𝑐𝑣
−1 = 𝑅𝑠
𝑐𝑣
γ ≡
𝑐𝑣
𝑐𝑝– specific heat ratio
γ = 1.4 for air at standard conditions
γ −1 = 𝑅𝑠
𝑐𝑣
Hence, 
𝑐𝑣=
𝑅𝑠
γ −1
1) and 2) hold for thermally and calorically perfect gasses


## Page 19

Practical example 2
For practical example 1 calculate the total internal energy of air stored in tanks at maximum pressure
𝑒= 𝑐𝑣𝑇= 717.5 × 293.15 = 210,335.125 𝐽/𝑘𝑔
From practical example 1 we found 𝑚= 1408.06 𝑘𝑔
𝐸= 𝑚𝑒= 1408.06 × 210,335.125 ≈296,164,476.108 𝐽
𝑐𝑣=
𝑅𝑠
γ −1 =
287
1.4 −1 = 717.5 𝐽/(𝑘𝑔∙𝐾)


## Page 20

First law of thermodynamics
𝑊𝑖𝑛
𝑊𝑜𝑢𝑡
𝑞𝑖𝑛
𝑞𝑜𝑢𝑡
𝑞– heat
𝑊– work
The change in internal energy of a system is 
equal to the heat added to the system 
minus the work done by
the system.
Conservation of Energy: The total energy of an isolated system 
remains constant; it just transforms.
𝑒
𝑒– energy stored inside the system
𝑑𝑞= 𝑑𝑒+ 𝑑𝑊


## Page 21

First law of thermodynamics
Adiabatic process – a process in which no heat is added to the system 
Reversible process – a process in which no dissipative phenomena occur (no effects of viscosity, thermal 
conductivity, and no mass diffusion)
Isentropic process – a process which is both adiabatic and reversible
For a reversible process
𝑑𝑊= −𝑝𝑑𝜗
𝑑𝜗– incremental change in specific volume due to a displacement of the boundary of the system
Hence
𝑑𝑞−𝑝𝑑𝜗= 𝑑𝑒


## Page 22

First law of thermodynamics
𝑇2
𝑇1
•
two plates (hot at 𝑇1 and cold at 𝑇2, 𝑇1 > 𝑇2) are in thermal contact
•
isolated system
•
no work is done: 𝛿𝑊= 0
𝑇1 > 𝑇2
hot
cold
The first law alone does not determine the direction of heat flow
First law of thermodynamics
𝛿𝑄= 𝑑𝑒+ 𝛿𝑊
Since 𝛿𝑊= 0
𝑑𝑒= 𝛿𝑄
For the system of two plates:
𝑑𝑒= 𝑑𝑒1 + 𝑑𝑒2 = 0
So
𝛿𝑄1 + 𝛿𝑄2 = 0
This allows two scenarios:
Case 1:
𝛿𝑄1 < 0, 𝛿𝑄2> 0
Case 2:
𝛿𝑄1 > 0, 𝛿𝑄2< 0
Heat flows from hot plate to 
cold plate
Heat flows from cold plate to 
hot plate
Both cases satisfy energy conservation


## Page 23

Second law of thermodynamics
The second law of thermodynamics tells in which direction the process takes place
The process will proceed in a direction such that the entropy (𝑠) of the system + surroundings always 
increases (or stays the same) 
𝑑𝑠≥𝜕𝑞
𝑑𝑡
For adiabatic process 𝜕𝑞= 0
𝑑𝑠≥0
Entropy represents a degree of disorder


## Page 24

Second law of thermodynamics
𝑇2
𝑇1
Case 1: 
heat flows from hot plate to cold plate
𝑇1 > 𝑇2
Case 2: 
heat flows from cold plate to hot plate
Entropy change:
∆𝑠1 = −𝑄
𝑇1
∆𝑠2 = 𝑄
𝑇2
Total entropy change:
∆𝑠𝑡𝑜𝑡𝑎𝑙= 𝑄
1
𝑇2 −
1
𝑇1 ,
Since 𝑇1 > 𝑇2 ⟹
1
𝑇2 >
1
𝑇1
Therefore, ∆𝑠𝑡𝑜𝑡𝑎𝑙> 0
Entropy change:
∆𝑠1 = 𝑄
𝑇1
∆𝑠2 = −𝑄
𝑇2
Total entropy change:
∆𝑠𝑡𝑜𝑡𝑎𝑙= 𝑄
1
𝑇1 −
1
𝑇2 ,
Since 𝑇1 > 𝑇2 ⟹
1
𝑇2 >
1
𝑇1
Therefore, ∆𝑠𝑡𝑜𝑡𝑎𝑙< 0
hot
cold
Violates the second law of thermodynamics


## Page 25

Calculation of entropy
𝛿𝑞= 𝑑𝑒+ 𝛿𝑊– first law of thermodynamics
𝛿𝑞= 𝑇𝑑𝑠– second law of thermodynamics
𝑝𝜗= 𝑅𝑠𝑇- Ideal gas law
Differentiate:
𝑝𝑑𝜗+ 𝜗𝑑𝑝= 𝑅𝑠𝑑𝑇
𝑝𝑑𝜗= 𝑅𝑠𝑑𝑇−𝜗𝑑𝑝
𝑇𝑑𝑠= 𝑑𝑒+ 𝑑𝑊= 𝑐𝑣𝑑𝑇+ 𝑝𝑑𝜗
𝑇𝑑𝑠= 𝑐𝑣𝑑𝑇+ 𝑅𝑠𝑑𝑇−𝜗𝑑𝑝= 𝑐𝑝𝑑𝑇−𝜗𝑑𝑝
𝑅𝑠= 𝑐𝑝−𝑐𝑣
𝑑𝑠= 𝑐𝑝
𝑑𝑇
𝑇−𝑅𝑠
𝑝𝑑𝑝
Change is specific entropy (for a flow from position 1 to position 2)
𝑠1 −𝑠2 = 𝑐𝑝ln 𝑇2
𝑇1
−𝑅ln 𝑝2
𝑝1


## Page 26

Isentropic relations
For a isentropic process 𝑠1 −𝑠2 = 0 (since it is reversible) 
0 = 𝑐𝑝ln 𝑇2
𝑇1
−𝑅𝑠ln 𝑝2
𝑝1
ln 𝑝2
𝑝1
= 𝑐𝑝
𝑅𝑠
ln 𝑇2
𝑇1
𝑝2
𝑝1
=
𝑇2
𝑇1
𝑐𝑝/𝑅𝑠
Recall 
𝑐𝑝
𝑅𝑠=
𝛾
𝛾−1
𝑝2
𝑝1
=
𝑇2
𝑇1
𝛾/(𝛾−1)
=
𝜌2
𝜌1
𝛾
Relates pressure, temperature and density for an isentropic 
process
𝑝= 𝜌𝑅𝑠𝑇
𝑝2
𝑝1 =
𝑅𝑠𝜌1𝑝2
𝑅𝑠𝜌2𝑝1
𝛾/(𝛾−1)
=
𝜌1
𝜌2
𝛾/(𝛾−1)
𝑝2
𝑝1
𝛾/(𝛾−1)
𝑝2
𝑝1
1−(𝛾/(𝛾−1))
=
𝜌1
𝜌2
𝛾/(𝛾−1)
𝑝2
𝑝1
=
𝜌2
𝜌1
𝛾
