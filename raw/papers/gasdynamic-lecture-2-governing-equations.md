---
ingested: 2026-04-30
sha256: d66c5d7b5858caf88f10af288bc2bb2d18ea9177a47c5b1cb03045ab0af72ecc
---

## Page 1

Gas Dynamics 1
Governing equations
Image: NASA


## Page 2

Governing equations
7 Unknowns (5 in 1D, since velocity vector has only 1 components in 1D):
•
Density, 𝜌
•
Pressure, 𝑝
•
Velocity vector, ഥ𝑈= (𝑢, 𝑣, 𝑤) / in 1D: ഥ𝑈= (𝑢) 
•
Internal energy, 𝜀
•
Temperature, 𝑇
Therefore 7 equations are required (5 in 1D):
•
Conservation of mass – continuity (1 equation)
•
Conservation of momentum (3 equations in 3D/ 1 equation in 1D)
•
Conservation of energy (1 equation)
•
Equations of state (2 equations)


## Page 3

Continuum approach and Knudsen number
Knudsen number:
𝐾𝑛= 𝜆
𝐿
𝜆 – mean free path
𝐿 – characteristic length scale
𝐿
Altitude
Density
Mean free pass
𝐿= 𝑐𝑜𝑛𝑠𝑡
High altitude > 𝟐𝟎𝟎𝒌𝒎
𝐾𝑛> 0.1 → rarefied flow
Mid altitude 𝟓𝟎−𝟐𝟎𝟎𝒌𝒎
𝐾𝑛~0.01 −0.1 → slip/transitional
Low altitude < 𝟓𝟎𝒌𝒎
𝐾𝑛≪0.01 → fully continuum 
In Gas Dynamics 1 we only consider cases 
where flow is treated as continuum!
𝐾𝑛≤0.01 − continuum flow
0.01 < 𝐾𝑛< 0.1 − slip flow
0.1 ≤𝐾𝑛< 10 − transitional flow
𝐾𝑛≥1 −free molecular flow


## Page 4

Conservation of mass
𝑥
𝑦
𝑧
𝜌𝑢|𝑥
𝜌𝑢|𝑥+∆𝑥
𝜌𝑣|𝑦+∆𝑦
𝜌𝑤|𝑧+∆𝑧
𝜌𝑣|𝑦
𝜌𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑎𝑠𝑠 
𝑎𝑐𝑐𝑢𝑚𝑢𝑙𝑎𝑡𝑖𝑜𝑛
𝑖𝑛𝑠𝑖𝑑𝑒 𝑜𝑓 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
=
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑎𝑠𝑠 
𝑓𝑙𝑜𝑤
𝑖𝑛𝑡𝑜 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
 −
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑎𝑠𝑠 
𝑓𝑙𝑜𝑤
𝑜𝑢𝑡 𝑜𝑓 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
Mass is neither created nor destroyed


## Page 5

Conservation of mass
𝑥
𝑦
𝑧
𝜌𝑢|𝑥
𝜌𝑢|𝑥+∆𝑥
𝜌𝑣|𝑦+∆𝑦
𝜌𝑤|𝑧+∆𝑧
𝜌𝑣|𝑦
𝜌𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
The rate of mass flow into the control volume in 𝒙-direction:
𝜌𝑢|𝑥 ∆𝑦 ∆𝑧
The rate of mass flow out of the control volume in 𝒙-direction:
𝜌𝑢|𝑥+∆𝑥 ∆𝑦 ∆𝑧
The rate of mass flow into the control volume in 𝒚-direction:
𝜌𝑢|𝑦 ∆𝑥 ∆𝑧
The rate of mass flow out of the control volume in 𝒚-direction:
𝜌𝑢|𝑦+∆𝑦 ∆𝑥 ∆𝑧
The rate of mass flow into the control volume in 𝒛-direction:
𝜌𝑢|𝑧 ∆𝑥 ∆𝑦
The rate of mass flow out of the control volume in 𝒛-direction:
𝜌𝑢|𝑧+∆𝑧 ∆𝑥 ∆𝑦


## Page 6

Conservation of mass
𝑥
𝑦
𝑧
𝜌𝑢|𝑥
𝜌𝑢|𝑥+∆𝑥
𝜌𝑣|𝑦+∆𝑦
𝜌𝑤|𝑧+∆𝑧
𝜌𝑣|𝑦
𝜌𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
The rate of mass accumulation inside the control volume:
∆𝑥∆𝑦∆𝑧𝜕𝜌
𝜕𝑡
Therefore mass balance is expressed as:
∆𝑥∆𝑦∆𝑧𝜕𝜌
𝜕𝑡
= 𝜌𝑢|𝑥∆𝑦∆𝑧−𝜌𝑢|𝑥+∆𝑥∆𝑦∆𝑧 +𝜌𝑣|𝑦∆𝑥∆𝑧
−𝜌𝑣|𝑦+∆𝑦∆𝑥∆𝑧+𝜌𝑤|𝑧∆𝑥∆𝑦−𝜌𝑤|𝑧+∆𝑧∆𝑥∆𝑦
After rearranging: 
∆𝑥∆𝑦∆𝑧𝜕𝜌
𝜕𝑡
+ ∆𝑦∆𝑧𝜌𝑢|𝑥+∆𝑥−𝜌𝑢|𝑥 +∆𝑥∆𝑧𝜌𝑣|𝑦+∆𝑦−𝜌𝑣|𝑦
+ ∆𝑥∆𝑦𝜌𝑤|𝑧+∆𝑧−𝜌𝑤|𝑧= 0


## Page 7

Conservation of mass
𝑥
𝑦
𝑧
𝜌𝑢|𝑥
𝜌𝑢|𝑥+∆𝑥
𝜌𝑣|𝑦+∆𝑦
𝜌𝑤|𝑧+∆𝑧
𝜌𝑣|𝑦
𝜌𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
Divide by the infinitesimal volume ∆𝑥∆𝑦∆𝑧:
𝜕𝜌
𝜕𝑡+ 𝜌𝑢|𝑥+∆𝑥−𝜌𝑢|𝑥
∆𝑥
+ 𝜌𝑣|𝑦+∆𝑦−𝜌𝑣|𝑦
∆𝑦
+ 𝜌𝑤|𝑧+∆𝑧−𝜌𝑤|𝑧
∆𝑧
= 0
 In the limit 
∆𝑥→0, ∆𝑦→0, ∆𝑧→0
This becomes:
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑢
𝜕𝑥+ 𝜕𝜌𝑣
𝜕𝑦+ 𝜕𝜌𝑤
𝜕𝑧= 0
Continuity equation
Recall definition of derivative:
𝑓′ 𝑥= lim
ℎ⟶0
𝑓𝑥+ ℎ−𝑓(𝑥)
ℎ


## Page 8

Conservation of mass
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑢
𝜕𝑥+ 𝜕𝜌𝑣
𝜕𝑦+ 𝜕𝜌𝑤
𝜕𝑧= 0
Using vector notation:
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0,
where 
∇≡
𝜕
𝜕𝑥, 𝜕
𝜕𝑦, 𝜕
𝜕𝑧
Using index notation with the Einstein convention:
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑈𝑖
𝜕𝑥𝑖
= 0


## Page 9

Conservation of mass
Starting from conservative form
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑢
𝜕𝑥+ 𝜕𝜌𝑣
𝜕𝑦+ 𝜕𝜌𝑤
𝜕𝑧= 0
The first four terms represent material derivative of 
density
𝐷𝜌
𝐷𝑡= 𝜕𝜌
𝜕𝑡+ 𝑢𝜕𝜌
𝜕𝑥+ 𝑣𝜕𝜌
𝜕𝑦+ 𝑤𝜕𝜌
𝜕𝑧
Hence
𝐷𝜌
𝐷𝑡+ 𝜌𝜕𝑢
𝜕𝑥+ 𝜕𝑣
𝜕𝑦+ 𝜕𝑤
𝜕𝑧
= 0
or equivalently
𝐷𝜌
𝐷𝑡+ 𝜌∇∙ഥ𝑈= 0
or
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
 
Apply the product rule to each flux term:
𝜕𝜌𝑢
𝜕𝑥=𝑢𝜕𝜌
𝜕𝑥+ 𝜌𝜕𝑢
𝜕𝑥,
𝜕𝜌𝑣
𝜕𝑦=𝑣𝜕𝜌
𝜕𝑦+ 𝜌𝜕𝑣
𝜕𝑦,
𝜕𝜌𝑤
𝜕𝑧=𝑤𝜕𝜌
𝜕𝑧+ 𝜌𝜕𝑤
𝜕𝑧 
Substitute back and rearrange:
𝜕𝜌
𝜕𝑡+ 𝑢𝜕𝜌
𝜕𝑥+ 𝑣𝜕𝜌
𝜕𝑦+ 𝑤𝜕𝜌
𝜕𝑧+ 𝜌𝜕𝑢
𝜕𝑥+ 𝜕𝑣
𝜕𝑦+ 𝜕𝑤
𝜕𝑧
= 0
Non-conservative form


## Page 10

Conservation of mass
Conservative form
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Non-conservative form
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
1D example
Approximation for temporal term using forward  difference:
𝜕𝜌
𝜕𝑡ቤ𝑛
𝑖≈𝜌𝑖
𝑛+1 −𝜌𝑖
𝑛
∆𝑡
𝜕𝜌
𝜕𝑡+ 𝜕𝜌𝑢
𝜕𝑥= 0
𝜕𝜌
𝜕𝑡+ 𝑢𝜕𝜌
𝜕𝑥+ 𝜌𝜕𝑢
𝜕𝑥= 0
Approximation for spatial terms using backward difference:
𝜕𝜌
𝜕𝑥ቤ𝑛
𝑖≈𝜌𝑖
𝑛−𝜌𝑖−1
𝑛
∆𝑥
𝜕𝑢
𝜕𝑥ቤ𝑛
𝑖≈𝑢𝑖
𝑛−𝑢𝑖−1
𝑛
∆𝑥
Approximation for spatial term using backward difference:
𝜕𝜌𝑢
𝜕𝑥ቤ𝑛
𝑖≈𝜌𝑢𝑖
𝑛−𝜌𝑢𝑖−1
𝑛
∆𝑥


## Page 11

Conservation of mass
Conservative form
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Non-conservative form
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
Solved using MATLAB
Initial conditions: 𝜌= 1 + 0.5 exp(−((𝑥−𝐿/2)/1.5)^2 );  𝑢= 1 + 0.3 sin 2𝜋𝑥/𝐿
𝐿= 10, 𝑛𝑥= 200, ∆𝑥= 0.05, ∆𝑡= 0.005, 𝑇end = 5


## Page 12

Conservation of mass
Conservative form
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Non-conservative form
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
Solved using MATLAB
Results at 𝑇end = 5 


## Page 13

Conservation of mass
Conservative form
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Non-conservative form
𝜕𝜌
𝜕𝑡+ ഥ𝑈∙∇𝜌+ 𝜌∇∙ഥ𝑈= 0
•
Analytically both forms are identical
•
Numerically they are not
•
The conservative form GUARANTEES mass conservation (telescoping sum)
•
The non-conservative form does NOT - mass is artificially created/destroyed
Only the conservative form guarantees that the total mass (or other conserved quantities) is preserved by 
the discretisation itself


## Page 14

Reynolds transport theorem
For any extensive property 𝐵 with corresponding intensive property 𝑏= 𝐵/𝑚, Reynolds transport theorem states:
𝑑𝐵
𝜕𝑡= 𝜕
𝜕𝑡න
𝑉
𝜌𝑏𝑑𝑉+ න
𝐴
𝜌𝑏(ഥ𝑈∙𝑛)𝑑𝐴,
where
𝜌 – density
ഥ𝑈 – velocity vector
𝑛 – outward normal
𝑉 – control volume 
𝐴 – control surface
Extensive properties depend on the amount of matter 
in the system
•
If the system size doubles, the property doubles 
•
They are additive (can sum them over subsystems)
Examples:
Mass, volume, total energy, momentum
Intensive properties do not depend on the system size
•
They stay the same even if you divide or combine 
systems (assuming uniform conditions)
Examples: density, temperature, pressure, velocity


## Page 15

Conservation of mass (using RTT)
Applying RTT to mass conservation
For the continuity equation, the conserved quantity is mass:
•
Extensive property: 𝐵= 𝑚
•
Intensive property: 𝑏= 1
𝑑𝑚
𝜕𝑡= 𝜕
𝜕𝑡න
𝑉
𝜌𝑑𝑉+ න
𝐴
𝜌(ഥ𝑈∙𝑛)𝑑𝐴
Since mass is conserved 
𝑑𝑚
𝜕𝑡= 0
Hence, 
0 = 𝜕
𝜕𝑡න
𝑉
𝜌𝑑𝑉+ න
𝐴
𝜌(ഥ𝑈∙𝑛)𝑑𝐴
Applying Gauss divergence theorem to convert surface integral to volume integral:
න
𝐴
𝜌(ഥ𝑈∙𝑛)𝑑𝐴= න
𝑉
 ∇∙(𝜌ഥ𝑈)𝑑𝐴
Gauss divergence theorem 
න
𝑉
∇∙𝐹𝑑𝑉= න
𝐴
𝐹∙ො𝑛𝑑𝐴


## Page 16

Conservation of mass (using RTT)
We get:
0 = න
𝑉
𝜕𝜌
𝜕𝑡+ ∇∙(𝜌ഥ𝑈) 𝑑𝑉 
Since this holds for any control volume:
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Continuity equation


## Page 17

Conservation of momentum
𝑥
𝑦
𝑧
𝜌𝑢𝑢|𝑥
𝜌𝑢𝑢|𝑥+∆𝑥
𝜌𝑢𝑣|𝑦+∆𝑦
𝜌𝑢𝑤|𝑧+∆𝑧
𝜌𝑢𝑣|𝑦
𝜌𝑢𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑜𝑚𝑒𝑛𝑡𝑢𝑚 
𝑎𝑐𝑐𝑢𝑚𝑢𝑙𝑎𝑡𝑖𝑜𝑛
𝑖𝑛𝑠𝑖𝑑𝑒 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
=
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑜𝑚𝑒𝑛𝑡𝑢𝑚 
𝑓𝑙𝑜𝑤
𝑖𝑛𝑡𝑜 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
 −
𝑟𝑎𝑡𝑒 𝑜𝑓 𝑚𝑜𝑚𝑒𝑛𝑡𝑢𝑚 
𝑓𝑙𝑜𝑤
𝑜𝑢𝑡 𝑜𝑓 𝑡ℎ𝑒 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒
+
𝑠𝑢𝑚 𝑜𝑓 𝑓𝑜𝑟𝑐𝑒𝑠 
𝑎𝑐𝑡𝑖𝑛𝑔 𝑜𝑛 𝑡ℎ𝑒
 𝑐𝑜𝑛𝑡𝑟𝑜𝑙
𝑣𝑜𝑙𝑢𝑚𝑒


## Page 18

Conservation of momentum
𝑥
𝑦
𝑧
𝜌𝑢𝑢|𝑥
𝜌𝑢𝑢|𝑥+∆𝑥
𝜌𝑢𝑣|𝑦+∆𝑦
𝜌𝑢𝑤|𝑧+∆𝑧
𝜌𝑢𝑣|𝑦
𝜌𝑢𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧
The rate at which 𝒙-component of momentum enters at 𝒙:
𝜌𝑢𝑢|𝑥 ∆𝑦 ∆𝑧
The rate at which it leaves at 𝒙+ ∆𝒙:
𝜌𝑢|𝑥+∆𝑥 ∆𝑦 ∆𝑧
The rate at which 𝒙-component of momentum enters at 𝒚:
𝜌𝑢𝑣|𝑦 ∆𝑥 ∆𝑧
The rate at which it leaves at 𝒚+ ∆𝒚:
𝜌𝑢𝑣|𝑦+∆𝑦 ∆𝑥 ∆𝑧
The rate at which 𝒙-component of momentum enters at 𝒛:
𝜌𝑢𝑤|𝑧 ∆𝑥 ∆𝑦
The rate at which it leaves at 𝒛+ ∆𝒛:
𝜌𝑢𝑤|𝑧+∆𝑧 ∆𝑥 ∆𝑦


## Page 19

Conservation of momentum
The rate of 𝒙-component of momentum accumulation inside
 the control volume:
∆𝑥∆𝑦∆𝑧𝜕𝜌𝑢
𝜕𝑡
Therefore for 𝒙-component of momentum balance is 
expressed as:
∆𝑥∆𝑦∆𝑧𝜕𝜌𝑢
𝜕𝑡
= 𝜌𝑢𝑢|𝑥∆𝑦∆𝑧−𝜌𝑢𝑢|𝑥+∆𝑥∆𝑦∆𝑧 +𝜌𝑢𝑣|𝑦∆𝑥∆𝑧
−𝜌𝑢𝑣|𝑦+∆𝑦∆𝑥∆𝑧+𝜌𝑢𝑤|𝑧∆𝑥∆𝑦−𝜌𝑢𝑤|𝑧+∆𝑧∆𝑥∆𝑦
+ 𝑡ℎ𝑒 𝑠𝑢𝑚 𝑜𝑓 𝑥−𝑐𝑜𝑚𝑝𝑜𝑛𝑒𝑛𝑡 𝑓𝑜𝑟𝑐𝑒𝑠 𝑎𝑐𝑡𝑖𝑛𝑔 𝑜𝑛 𝑡ℎ𝑒 𝑠𝑦𝑠𝑡𝑒𝑚
After rearranging: 
∆𝑥∆𝑦∆𝑧𝜕𝜌𝑢
𝜕𝑡
+ ∆𝑦∆𝑧𝜌𝑢𝑢|𝑥+∆𝑥−𝜌𝑢𝑢|𝑥 +∆𝑥∆𝑧𝜌𝑢𝑣|𝑦+∆𝑦−𝜌𝑢𝑣|𝑦
+ ∆𝑥∆𝑦𝜌𝑢𝑤|𝑧+∆𝑧−𝜌𝑢𝑤|𝑧
= 𝑡ℎ𝑒 𝑠𝑢𝑚 𝑜𝑓 𝑥−𝑐𝑜𝑚𝑝𝑜𝑛𝑒𝑛𝑡 𝑓𝑜𝑟𝑐𝑒𝑠 𝑎𝑐𝑡𝑖𝑛𝑔 𝑜𝑛 𝑡ℎ𝑒 𝑠𝑦𝑠𝑡𝑒𝑚
𝑥
𝑦
𝑧
𝜌𝑢𝑢|𝑥
𝜌𝑢𝑢|𝑥+∆𝑥
𝜌𝑢𝑣|𝑦+∆𝑦
𝜌𝑢𝑤|𝑧+∆𝑧
𝜌𝑢𝑣|𝑦
𝜌𝑢𝑤|𝑧
∆𝑥
∆𝑦
∆𝑧


## Page 20

Conservation of momentum
𝑥
𝑦
𝑧
𝜏𝑥𝑦 |𝑦+∆𝑦
𝜏𝑥𝑧|𝑧+∆𝑧
𝜏𝑥𝑦 |𝑦
𝜏𝑥𝑧 |𝑧
∆𝑥
∆𝑦
∆𝑧
−𝑃+ 𝜏𝑥𝑥 |𝑥
Sum of forces acting on the control volume
Pressure and viscous stresses acting in the 𝑥-direction
𝐹𝑥
=
−𝑃+ 𝜏𝑥𝑥|𝑥+∆𝑥−−𝑃+ 𝜏𝑥𝑥|𝑥∆𝑦∆𝑧+(𝜏𝑥𝑦|𝑦+∆𝑦
−𝜏𝑥𝑦|𝑦) ∆𝑥∆𝑧+(𝜏𝑥𝑧|𝑧+∆𝑧−𝜏𝑥𝑧|𝑧) ∆𝑥∆𝑦
Similarly for other two directions:
𝐹𝑦
= (𝜏𝑥𝑦|𝑥+∆𝑥−𝜏𝑥𝑦|𝑥) ∆𝑦∆𝑧
+
−𝑃+ 𝜏𝑦𝑦|𝑦+∆𝑦−−𝑃+ 𝜏𝑦𝑦|𝑦∆𝑥∆𝑧++(𝜏𝑦𝑧|𝑧+∆𝑧
−𝜏𝑦𝑧|𝑧) ∆𝑥∆𝑦
𝐹𝑧
= (𝜏𝑥𝑧|𝑥+∆𝑥−𝜏𝑥𝑧|𝑥) ∆𝑦∆𝑧+(𝜏𝑦𝑧|𝑦+∆𝑦−𝜏𝑦𝑧|𝑦) ∆𝑥∆𝑧
+
−𝑃+ 𝜏𝑧𝑧|𝑧+∆𝑧−−𝑃+ 𝜏𝑧𝑧|𝑧∆𝑥∆𝑦
−𝑃+ 𝜏𝑥𝑥 |𝑥+∆𝑥


## Page 21

Conservation of momentum
For 𝑥-direction, with convection pressure and viscous terms :
 ∆𝑥∆𝑦∆𝑧
𝜕𝜌𝑢
𝜕𝑡
= 𝜌𝑢𝑢|𝑥∆𝑦∆𝑧−𝜌𝑢𝑢|𝑥+∆𝑥∆𝑦∆𝑧 +𝜌𝑢𝑣|𝑦∆𝑥∆𝑧−𝜌𝑢𝑣|𝑦+∆𝑦∆𝑥∆𝑧+𝜌𝑢𝑤|𝑧∆𝑥∆𝑦
−𝜌𝑢𝑤|𝑧+∆𝑧∆𝑥∆𝑦+
−𝑝+ 𝜏𝑥𝑥|𝑥+∆𝑥−−𝑝+ 𝜏𝑥𝑥|𝑥∆𝑦∆𝑧+(𝜏𝑥𝑦|𝑦+∆𝑦−𝜏𝑥𝑦|𝑦) ∆𝑥∆𝑧+(𝜏𝑥𝑧|𝑧+∆𝑧
−𝜏𝑥𝑧|𝑧) ∆𝑥∆𝑦
Divide through by ∆𝑥∆𝑦∆𝑧 and move all the terms to the left hand side:
𝜕𝜌𝑢
𝜕𝑡+ 𝜌𝑢𝑢|𝑥+∆𝑥−𝜌𝑢𝑢|𝑥+ 𝑝−𝜏𝑥𝑥|𝑥+∆𝑥−−𝑝−𝜏𝑥𝑥|𝑥
∆𝑥
+ 𝜌𝑢𝑣|𝑦+∆𝑦−𝜌𝑢𝑣|𝑦+ (𝜏𝑥𝑦|𝑦+∆𝑦−𝜏𝑥𝑦|𝑥)
∆𝑦
+ 𝜌𝑢𝑤|𝑧+∆𝑧−𝜌𝑢𝑤|𝑧+ (𝜏𝑥𝑧|𝑧+∆𝑧−𝜏𝑥𝑧|𝑧)
∆𝑧
= 0
In the limit ∆𝑥→0, ∆𝑦→0, ∆𝑧→0
𝜕𝜌𝑢
𝜕𝑡+ 𝜕(𝜌𝑢𝑢+ 𝑝−𝜏𝑥𝑥) 
𝜕𝑥
+ 𝜕(𝜌𝑢𝑣−𝜏𝑥𝑦) 
𝜕𝑦
+ 𝜕(𝜌𝑢𝑤−𝜏𝑥𝑧) 
𝜕𝑧
= 0


## Page 22

Conservation of momentum
For 𝑥-direction:
𝜕𝜌𝑢
𝜕𝑡+ 𝜕(𝜌𝑢𝑢+ 𝑝−𝜏𝑥𝑥) 
𝜕𝑥
+ 𝜕(𝜌𝑢𝑣−𝜏𝑥𝑦) 
𝜕𝑦
+ 𝜕(𝜌𝑢𝑤−𝜏𝑥𝑧) 
𝜕𝑧
= 0
Similarly for other two direction:
For 𝑦-direction:
𝜕𝜌𝑣
𝜕𝑡+ 𝜕(𝜌𝑢𝑣−𝜏𝑥𝑦) 
𝜕𝑥
+ 𝜕(𝜌𝑣𝑣+ 𝑝−𝜏𝑦𝑦) 
𝜕𝑦
+ 𝜕(𝜌𝑢𝑤−𝜏𝑥𝑧) 
𝜕𝑧
= 0
For 𝑧-direction:
𝜕𝜌𝑤
𝜕𝑡+ 𝜕(𝜌𝑢𝑤−𝜏𝑥𝑧) 
𝜕𝑥
+ 𝜕(𝜌𝑣𝑤−𝜏𝑦𝑧) 
𝜕𝑦
+ 𝜕(𝜌𝑤𝑤+ 𝑝−𝜏𝑧𝑧) 
𝜕𝑧
= 0
In index form, using Einstein convention:
𝜕𝜌𝑈𝑖
𝜕𝑡+ 𝜕(𝜌𝑈𝑖𝑈𝑗+ 𝑝𝛿𝑖𝑗−𝜏𝑖𝑗) 
𝜕𝑥𝑗
= 0
Where 𝛿𝑖𝑗 is Kronecker delta
𝛿𝑖𝑗= ቊ0,
if 𝑖≠𝑗
1,
 if 𝑖= 𝑗


## Page 23

Conservation of momentum (using RTT)
Newton’s second law:
෍ത𝐹= 𝜕
𝜕𝑡(𝑚𝑜𝑚𝑒𝑛𝑡𝑢𝑚 𝑜𝑓 𝑠𝑦𝑠𝑡𝑒𝑚)
Extensive property: 
𝐵= න
𝑠𝑦𝑠𝑡𝑒𝑚
ഥ𝑈𝑑𝑚= න
𝑠𝑦𝑠𝑡𝑒𝑚
𝜌ഥ𝑈𝑑𝑉
Intensive property: 
𝑏= ഥ𝑈
Apply RTT to momentum:
𝑑
𝜕𝑡𝑚𝑜𝑚𝑒𝑛𝑡𝑢𝑚= 𝜕
𝜕𝑡න
𝑉
𝜌ഥ𝑈𝑑𝑉+ න
𝐴
𝜌ഥ𝑈(ഥ𝑈∙𝑛)𝑑𝐴


## Page 24

Conservation of momentum (using RTT)
Put into Newton’s second law:
෍ത𝐹= 𝜕
𝜕𝑡න
𝑉
𝜌ഥ𝑈𝑑𝑉+ න
𝐴
𝜌ഥ𝑈(ഥ𝑈∙𝑛)𝑑𝐴
Forces ത𝐹 typically include:
•
Surface forces (pressure + viscous)
ത𝐹𝑠𝑢𝑟𝑓𝑎𝑐𝑒= ׬𝐴 (−𝑝𝑛+ 𝜏)𝑑𝐴, where 𝑝 – pressure, 𝜏 – shear stress
•
Body force
ത𝐹𝑏𝑜𝑑𝑦= ׬𝐴 (𝜌𝑔)𝑑𝑉


## Page 25

Conservation of momentum (using RTT)
Integral momentum equation:
න
𝑉
 (𝜌𝑔)𝑑𝑉+ න
𝐴
 (−𝑝𝑛+ 𝜏)𝑑𝐴= 𝜕
𝜕𝑡න
𝑉
𝜌ഥ𝑈𝑑𝑉+ න
𝐴
𝜌ഥ𝑈(ഥ𝑈∙𝑛)𝑑𝐴
Using Gauss divergence theorem convert surface integrals to volume integrals:
•
Pressure term:
−න
𝐴
 𝑝𝑛𝑑𝐴= −න
𝑉
∇𝑝𝑑𝑉
•
Shear term:
න
𝐴
 𝜏𝑑𝐴= න
𝑉
∇∙𝜏𝑑𝑉
•
Convective term:
න
𝐴
𝜌ഥ𝑈(ഥ𝑈∙𝑛)𝑑𝐴= න
𝑉
∇∙ (𝜌ഥ𝑈ഥ𝑈)𝑑𝑉,
Where ഥ𝑈ഥ𝑈 is the outer product:
ഥ𝑈ഥ𝑈=
𝑢𝑢
𝑢𝑣
𝑢𝑤
𝑢𝑣
𝑣𝑣
𝑣𝑤
𝑢𝑤
𝑣𝑤
𝑤𝑤


## Page 26

Conservation of momentum (using RTT)
Integral momentum equation:
න
𝑉
𝜌𝑔−∇𝑝+ ∇∙𝜏−𝜕
𝜕𝑡𝜌ഥ𝑈−∇∙(𝜌ഥ𝑈ഥ𝑈) 𝑑𝑉= 0
Since this is valid for any arbitrary volume:
𝜌𝑔−∇𝑝+ ∇∙𝜏−𝜕
𝜕𝑡𝜌ഥ𝑈−∇∙(𝜌ഥ𝑈ഥ𝑈) = 0
Expand terms using product rule:
𝜕
𝜕𝑡𝜌ഥ𝑈= 𝜌𝜕ഥ𝑈
𝜕𝑡+ ഥ𝑈𝜕𝜌
𝜕𝑡
∇∙𝜌ഥ𝑈ഥ𝑈= 𝜌ഥ𝑈∙∇ഥ𝑈+ ഥ𝑈(∇∙(𝜌ഥ𝑈))
Recall continuity equation:
𝜕𝜌
𝜕𝑡+ ∇∙𝜌ഥ𝑈= 0
Hence:
𝜌𝜕ഥ𝑈
𝜕𝑡+ ഥ𝑈∙∇ഥ𝑈
= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
Conservative form


## Page 27

Conservation of momentum
Hence:
𝜌𝜕ഥ𝑈
𝜕𝑡+ ഥ𝑈∙∇ഥ𝑈
= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
Or using material derivative:
𝜌𝐷ഥ𝑈
𝐷𝑡= −∇𝑝+ ∇∙𝜏+ 𝜌𝑔
In this course we consider inviscid flow (𝜏= 0) and neglect body forces:
𝜌𝐷ഥ𝑈
𝐷𝑡= −∇𝑝+ 𝜌𝑔
We can also neglect body forces (gravity):
𝜌𝐷ഥ𝑈
𝐷𝑡= −∇𝑝
In 1D and ignoring gravity:
𝜌𝑑𝑢
𝑑𝑡= −𝑑𝑝
𝑑𝑥
Euler momentum equation


## Page 28

Next lecture
Wednesday April 22, 4:15-5:45pm, room H0111
• Energy equation
• Revision of thermodynamics
