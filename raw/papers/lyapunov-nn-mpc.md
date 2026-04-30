---
source_url: 
ingested: 2026-04-30
sha256: bad93711857d2e36a4919b771da601ba265515e56a399002dfabc98a7bec22a4
---

1
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  
| https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports
Lyapunov‑based neural network 
model predictive control using 
metaheuristic optimization 
approach
Chafea Stiti 1, Mohamed Benrabah 2, Abdelhadi Aouaichia 1, Adel Oubelaid 3, Mohit Bajaj 4,5,6*, 
Milkias Berhanu Tuka 7* & Kamel Kara 1
This research introduces a new technique to control constrained nonlinear systems, named Lyapunov-
based neural network model predictive control using a metaheuristic optimization approach. This 
controller utilizes a feedforward neural network model as a prediction model and employs the driving 
training based optimization algorithm to resolve the related constrained optimization problem. The 
proposed controller relies on the simplicity and accuracy of the feedforward neural network model and 
the convergence speed of the driving training based optimization algorithm. The closed-loop stability 
of the developed controller is ensured by including the Lyapunov function as a constraint in the cost 
function. The efficiency of the suggested controller is illustrated by controlling the angular speed 
of three-phase squirrel cage induction motor. The reached results are contrasted to those of other 
methods, specifically the fuzzy logic controller optimized by teaching learning-based optimization 
algorithm, the optimized PID with particle swarm optimization algorithm, the neural network model 
predictive controller based on particle swarm optimization algorithm, and the neural network model 
predictive controller using driving training based optimization algorithm. This comparative study 
showcase that the suggested controller provides good accuracy, quickness and robustness due to the 
obtained values of the mean absolute error, mean square error root mean square error, enhancement 
percentage, and computing time in the different simulation cases, and it can be efficiently utilized to 
control constrained nonlinear systems with fast dynamics.
Keywords  Model predictive control, DTBO, Neural network, Lyapunov function, Constraints, Nonlinear 
system, Metaheuristic, Squirrel cage induction motor
Model-Based Predictive Control, often known as MBPC or just MPC, does not specify a unique control approach 
but refers to a variety of control ­techniques1 that utilize a model to predict the system’s future ­outputs2. The pri-
mary strategy of this type of controller is based on a good knowledge of the model representing the system to be 
controlled and the minimization of a performance criterion defined usually by the quadratic error between the 
predicted response and the desired reference trajectory along a finite ­horizon3,4. The unifying principle across 
these varied techniques is the utilization of a predictive model to forecast future outputs of a ­system5,6. This pre-
dictive ability is not inherent to a single type of model; instead, it relies on the precise and accurate representation 
of the system through the model ­utilized7,8. The core methodology of MPC hinges on an intimate understanding 
of the system’s ­model9,10. The effectiveness of MPC is predicated on the fidelity and accuracy of this model in 
representing the dynamics of the system under ­control11,12. In practice, this means that the predictive model must 
be able to simulate future states of the system with high reliability, providing a foundation upon which control 
decisions can be ­made13,14. Furthermore, MPC operates on the principle of optimizing a predefined performance 
OPEN
1Laboratory of Electrical Systems and Remote Control, Blida1 University Blida, Ouled Yaïch, Algeria. 2Robotics 
Laboratory Parallelism and Embedded Systems, USTHB University, Algiers, Algeria. 3Université de Bejaia, Faculté 
de Technologie, Laboratoire de Technologie Industrielle et de l’Information, 06000 Bejaia, Algeria. 4Department 
of Electrical Engineering, Graphic Era (Deemed to Be University), Dehradun  248002, India. 5Hourani Center 
for Applied Scientific Research, Al-Ahliyya Amman University, Amman, Jordan. 6Graphic Era Hill University, 
Dehradun 248002, India. 7Department of Electrical and Computer Engineering, College of Engineering, Sustainable 
Energy Center of Excellency, Addis Ababa Science and Technology University, Addis Ababa, Ethiopia. *email: 
mb.czechia@gmail.com; milkias.berhanu@aastu.edu.et


2
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
criterion, which is often expressed in terms of minimizing the quadratic ­error15,16. This error quantifies the dif-
ference between the system’s predicted output and the desired output, as defined by the reference ­trajectory17,18. 
The optimization is performed over a finite horizon, meaning that the controller seeks to minimize this error not 
just for the immediate next step, but for a series of future steps within a specified ­timeframe19,20. This approach 
allows for anticipatory adjustments in control actions, which are recalculated at each step based on updated 
predictions, thereby adapting to changes and disturbances affecting the ­system21,22. Overall, MPC’s reliance on 
a robust model and its forward-looking optimization strategy make it a powerful and flexible approach in the 
realm of control engineering, suitable for managing complex dynamic systems where future predictions and 
pre-emptive control actions are crucial for performance and ­stability23,24.
MPC is a control approach that has been around since the work of J. Richalet in the late 70’s25. This technique 
has been widely adopted by the academic and industrial world in various sectors, such as the chemical and 
petroleum industries, robotics, etc.26–31. The popularity of this type of controller is due to its ability to control a 
different kinds of processes, like multivariable or monovariable, with long delay times, unstable or non-minimal 
phase, and those with simple or complex ­dynamics32,33. Due to the use of various linear models to represent the 
different industrial processes, several MPC control algorithms have been approved, namely the Model Algorith-
mic Control (MAC) proposed ­by34, the Dynamic Matrix Control (DMC) suggested ­by35, the Extended Horizon 
Adaptive Control (EHAC) introduced ­by35 and in 1987 the work of Clarke proposed the Generalized Predic-
tive Control (GPC)36–38 which has been very successful. Since then, several methods have been developed to 
improve the various MPC algorithms mentioned ­above26,39–43. Even while linear MPC controllers have proven 
their efficiency in a variety of industrial applications, they remain insufficient to ensure effective control of 
highly non-linear processes due to the difficulty of designing an accurate model representing the real system 
to be ­controlled18,44. Despite the proven efficacy of linear MPCs in numerous industrial settings, they are often 
inadequate for controlling highly nonlinear ­processes20,45. This limitation stems from the challenges associated 
with devising accurate models that can faithfully represent complex real-world ­systems22,46. This insufficiency 
has given rise to a nonlinear control strategy known as Nonlinear Model Predictive Control (NMPC)47–50. Vari-
ous nonlinear modelling techniques have been used in NMPC, such as Volterra ­series51–53, Fuzzy ­models54–56 
and Neural Network models (NN)57–61. Compared to conventional Nonlinear MPC techniques such as Volterra 
logic or fuzzy ­logic62,63, Neural Network based MPC (NNMPC) employs less processing power, memory and 
can accurately model complex dynamic effects, even with scant training data, providing it more efficient for 
applications requiring nonlinear control.
Using the NMPC approach means solving a constrained, non-convex, nonlinear optimization problem requir-
ing long and tedious numerical ­calculation64–66. In order to solve such problem, several sub-optimal approaches 
have been proposed, such as stochastic optimization ­methods67–69, which include metaheuristic ­algorithms70. 
Due to the performances provided by this type of algorithm in terms of calculation time and finding the right 
solution, several works have been carried out to solve the non-convex NMPC problem using different types of 
metaheuristics algorithms like, Particle Swarm Optimization (PSO)71–73, Artificial Bee Colony (ABC)74,75, Evo-
lutionary Algorithm (EA)76, Teaching Learning Based Optimization (TLBO)77,78 and Archimedes Optimization 
Algorithm (AOA)79.
The Driving Training Based Optimization (DTBO) algorithm, proposed by Mohammad Dehghani, is one 
of the novel metaheuristic algorithms which appeared in ­202280. This algorithm is founded on the principle of 
learning to drive, which unfolds in three phases: selecting an instructor from the learners, receiving instructions 
from the instructor on driving techniques, and practicing newly learned techniques from the learner to enhance 
one’s driving ­abilities81,82. In this work, DTBO algorithm is used, due to its effectiveness, which was confirmed 
by a comparative ­study83 with other algorithms, including particle swarm ­optimization84, Gravitational Search 
Algorithm (GSA)85, teaching learning-based optimization, Gray Wolf Optimization (GWO)86, Whale Optimiza-
tion Algorithm (WOA)87, and Reptile Search Algorithm (RSA)88. The comparative study has been done using 
various kinds of benchmark functions, such as constrained, nonlinear and non-convex functions.
Lyapunov -based Model Predictive Control (LMPC) is a control approach integrating Lyapunov function as 
constraint in the optimization problem of ­MPC89,90. This technique characterizes the region of the closed-loop 
stability, which makes it possible to define the operating conditions that maintain the system ­stability91,92. Since 
its appearance, the LMPC method has been utilized extensively for controlling a various nonlinear systems, such 
as robotic ­systems93, electrical ­systems94, chemical ­processes95, and wind power generation ­systems90. In contrast 
to the LMPC, both the regular MPC and the NMPC lack explicit stability restrictions and can’t combine stability 
guarantees with interpretability, even with their increased flexibility.
The proposed method, named Lyapunov-based neural network model predictive control using metaheuristic 
optimization approach (LNNMPC-MOA), includes Lyapunov -based constraint in the optimization problem 
of the neural network model predictive control (NNMPC), which is solved by the DTBO algorithm. The sug-
gested controller consists of two parts: the first is responsible for calculating predictions using a neural network 
model of the feedforward type, and the second is responsible to resolve the constrained nonlinear optimization 
problem using the DTBO algorithm. This technique is suggested to solve the nonlinear and non-convex optimi-
zation problem of the conventional NMPC, ensure on-line optimization in reasonable time thanks to their easy 
implementation and guaranty the stability using the Lyapunov function-based constraint. The efficiency of the 
proposed controller regarding to the accuracy, quickness and robustness is assessed by taking into account the 
speed control of a three-phase induction motor, and its stability is mathematically ensured using the Lyapunov 
function-based constraint. The acquired results are compared to those of NNMPC based on DTBO algorithm 
(NNMPC-DTBO), NNMPC using PSO algorithm (NNMPC-PSO), Fuzzy Logic controller optimized by TLBO 
(FLC-TLBO) and optimized PID controller using PSO algorithm (PID-PSO)95.
This paper is structured like this: Sect. “Driving training based optimization algorithm” presents the DTBO 
algorithm. Section “Lyapunov-based neural network model predictive control using DTBO algorithm” describes 


3
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
the proposed LNNMPC-MOA using the DTBO algorithm (LNNMPC-DTBO); Section “Stability analysis” proves 
the stability of the suggested controller mathematically. Section “Simulation study” gives the system model’s 
under study, and several simulation results are presented and discussed. Finally, in Sect. “Conclusion and future 
research directions” the conclusion is given.
Driving training based optimization algorithm
Driving training based optimization is a recent metaheuristic algorithm, inspired by the human activities of 
driver training in driving schools. It is based on a population of learners and instructors that are considered as 
candidate solutions. They are updated throughout the optimization process until the best solution is obtained, 
which ensures the best value of the cost function.
This search process can be modelled into three phases: phase1, also known as the training by the driving 
instructor phase, is used to select the instructors who will teach the learners-drivers how to drive. Phase 2 is 
referred to as learner driver modelling, during which the student drivers replicate the instructor’s gestures and 
manoeuvres. Phase3, which is the personal practice phase, is designed to enhance each learner driver’s progress 
and improve his driving skills through individual practice.
The DTBO algorithm with its three phases is given in the following steps:
1. Initialization: Before starting the execution of the three DTBO phases, an initialization step is necessary to 
define the values of the subsequent parameters: the population size (N) , the number of problem variables for 
the optimization problem (m) , the bounds of the variables (Lb, Ub) with dimension (m), the number of itera-
tions (T) . The position of the population (Xi) is initialized randomly respecting their bounds using Eq. (1), 
the corresponding cost function (Fi) is assed and the best solution (Xibest) is selected according to the best 
value of the cost function 

Fibest
.
with i = 1,2, ..., N and r is a random number from 0 to 1.
2. Phase1: Training by the driving instructor phase: During this phase, the driving instructors NDI , represented 
by the DI matrix of dimension [NDI, m] , are calculated using Eq. (2).
where z = 1, .., T is the counter of iterations.
As shown in Eq. (2), NDI are selected among DTBO population depending on their cost function values, and 
the remaining members are classified as learner drivers. Then the new position for each candidate solution 
in phase1 (P1) is calculated using Eq. (3) and updated using Eq. (4).
where the XP1
i  is the new position with dimension (m) , for ith element of the population, FP1
i  is its correspond-
ing cost function value, I is a random number from 1 to 2, ki is a random number from 1 to NDI , DIki is the 
selected driving instructor and FDIki is its corresponding cost function value.
In this phase, the DTBO algorithm is in the exploration phase, moving its population into various regions of 
the search area to select the driving instructors and teach the learner drivers.
3. Phase2: learner driver modelling phase (exploration): During this phase, the learner driver imitates all the 
instructor’s movements and skills. This patterning is represented by the index P given by Eq. (5).
This process increases the DTBO’s capacity of exploration by moving its elements to different locations in the 
search area. To model this phase a new position XP2
i  is calculated by the linear combination of each learner 
driver and instructor using Eq. (6).
This new position takes the place of the old one if it enhances the value of the cost function using Eq. (7).
4. Phase 3: Personal practice phase: In this part, each learner driver progresses and improve his driving skills 
through individual practice. Throughout this period, each driver learner tries to get closer to his maximum 
capabilities. This enables each member to find a better position by performing a local search near their current 
position. This step illustrates how DTBO can benefit from local search exploitation. This phase is modelled 
in such a way that a random position is firstly generated near each learner driver using Eq. (8).
(1)
Xi = Lb + r(Ub −Lb),
(2)
NDI = 0.1N −

1 −z
T

,
(3)
XP1
i
=

Xi + r(DIki −IXi), FDIki < F
Xi + r(Xi −DIki), Otherwise
(4)
Xi =

XP1
i ,
FP1
i
< Fi
Xi,
Otherwise ,
(5)
P = 0.01 + 0.9

1 −z
T

.
(6)
XP2
i
= PXi + (1 −P)DIki.
(7)
Xi =

XP2
i ,
FP2
i
< Fi
Xi,
Otherwise


4
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
with R = 0.05 is a constant.
The position of ith leaner driver is updated using the Eq. (9), as follows:
5. Updated the best solution (Xibest) according to the best value of the cost function.
6. This process is repeated until the number of iterations is reached.
The flow chart of the DTBO algorithm is given in Fig. 1.
(8)
XP3
i
= Xi + (1 −2r)R

1 −z
T

Xi,
(9)
Xi =

XP3
i , FP3
i
< F
Xi, Otherwise .
Figure 1.   Flow chart of the DTBO.


5
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Lyapunov‑based neural network model predictive control using DTBO algorithm
Principle of neural network model predictive control using DTBO algorithm Consider the fol‑
lowing system:
Consider the system described by the Eq. (10), as follows:
where x , u , and y are the state vectors, input and output, respectively, v is the disturbance, andf  and g are non-
linear functions.
The NNMPC is an advanced control approach that requires two essential steps as follows:
First, a neural model representing the process to be controlled is established. This model predicts the system’s 
future behaviour along a prediction horizon defined by the interval [N1, N2].
Second, a control sequence along the control horizon (Nu) is determined and its initial element ( u(k) ) is 
employed to control the system under study. In this step, the NNMPC minimization problem given in Eq. (11) 
is solved using the DTBO algorithm.
Subject to:
where u(k) = u(k) −u(k −1) is the control increment, y(k + i/k) is the predicted output, yr is the desired 
reference trajectory, Q is a positive semidefinite matrix and R is a positive definite matrix.
Lyapunov‑based neural network model predective control using DTBO algorithm
In order to ensure stable control and maintain the system within an acceptable operating range while respecting 
its safety conditions and physical limits, several constraints have been proposed. The constraints used in the 
proposed LNNMPC-DTBO are the input, the output and the Lyapunov function-based constraints, which are 
implemented in the constrained minimization problem defined in Eq. (12), as follows:
Subject to
where u(k) is the actual input control, Ŵy

y

 is the output-dependent weight function, and V represents the 
continuous differentiable Lyapunov function.
Constraints handling
The constraints used in the minimization problem of the LNNMPC-DTBO are handled as follow:
(10)

x(k + 1) = f (x(k), u(k), v(k))
y(k) = g(x(k), u(k))
,
(11)
min
u(k)J

u(k),y(k), yr(k)

=
N2

i=N1

yr(k + i) −y(k + i/k)
TQ

yr(k + i) −y(k + i/k)

+
Nu

i=1
[uT(k + i −1)Ru(k + i −1)].
ymin < ˆy(k + i) < ymax, i = N1, . . . , N2
umin < u(k + i) < umax, i = O, . . . , Nu −1
umin < u(k + i) < umax, i = O, . . . , Nu −1
u(k + i −1) = 0 For i > Nu,
(12)
min
u(k)J

u(k),y(k), yr(k)

=
N2

i=N1

yr(k + i) −y(k + i/k)
TŴy

yr(k + i) −y(k + i/k)

+
Nu

i=1
[uT(k + i −1)Ru(k + i −1)].
(12.a)
ymin < y(k + i) < ymax, i = N1, . . . , N2
(12.b)
umin < u(k + i) < umax, i = O, . . . , Nu −1
(12.c)
umin < u(k + i) < umax, i = O, . . . , Nu −1
(12.d)
u(k + i −1) = 0Fori > Nu
(12.e)
∂V
∂x f (x(k), u(k), v(k)) ≤∂V
∂x f (x(k −1), u(k −1), v(k −1)),


6
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
–	 The input constraints are defined in Eqs. (12.b), (12.c), and they are handled by limiting the search space of 
the DTBO algorithm.
–	 The output constraints are handled using the penalty function Ŵy

y

 given by Eq. (13) below:
And:
with Ciy is employed to define the penalization degree, i = 1,2, ..., n where n is the number of system outputs and 
y(k) =

y1(k), y2(k), ..., yn(k)
T.
The Lyapunov function-based constraint given in Eq. (12.e) is handled by adding a penalization of the Lya-
punov function derivative to the cost function defined in Eq. (12). This technique ensures that the Lyapunov 
function derivative will be less than or equal to zero as long as the Lyapunov function derivative of the current 
control (u) is less than that of the previous control.
Control algorithm
The suggested LNNMPC-DTBO stapes’s are given as follows:
Step1: Initialization
–	 Determine the MPC and DTBO parameters (N1, N2, Nu, N, T, m, Ub, Lb).
–	 Considering that Xi with dimenssion m are the control inputs at sampling time k where m is the control inputs 
number.
Step2: Select the initial solution
–	 Set a desired reference trajectory along k + N1 to k + N2.
–	 Initialize the position of the population Xi using Eq. (1).
–	 Calculate the predicted outputs of the system for the initial position of the population, by utilizing the neural 
network model.
–	 Evaluate the cost function Fi using Eq. (12).
–	 Select the best solution Xbest
i
 that corresponds to the best value of the cost function.
Step3: Optimization loop
For z = 1 : T
For i = 1 : N
–	 Determine the driving instructor using Eq. (2) and calculate the new position Xp1
i  for the  DTBO population 
using Eq. (3).
–	 Calculate the predicted outputs of the system by utilizing the neural network model and Xp1
i .
–	 Compute the new value of the cost function Fp1
i  using the new position Xp1
i .
–	 Update Xp1
i  using Eq. (4).
–	 Calculate the patterning index according to Eq. (5).
–	 Compute the new position Xp2
i  using Eq. (6).
–	 Calculate the predicted outputs of the system by utilizing the neural network model Xp2
i .
–	 Compute the new value of the objective function Fp2
i  using the new position Xp2
i .
–	 Update Xp2
i  using Eq. (7).
–	 Compute the new position of the DTBO population Xp3
i  with Eq. (8).
–	 Calculate the predicted outputs of the system by utilizing the neural network model and Xp3
i  .
–	 Update Xp3
i  using Eq. (9).
End for (i).
–	 Xbest
i
End for (z).
Step4:
–	 Apply the first element of the best solution Xbest
i
 to the system, which is the optimal control inputs.
–	 Go back to the step 2 for the next sampling time (k = k + 1).
(13)
Ŵy

y

=


Ŵy1(y1)
0
. . . 0
0
Ŵy2(y2)
. . . 0
...
0
...
0
... ...
· · · Ŵn(yn)


Ŵyi

yi

=

Ŵyi(0)
if yimin ≤yi ≤yimax
Ŵyi(0)

1 + Ciy

if yi ≥yimax or yi ≤yimin
,


7
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Stability analysis
This section uses the stability analysis performed ­by90 in continuous time to prove the proposed controller’s 
closed-loop stability.
Knowing that the optimization criterion of the proposed controller, defined in Eq. (12), can be written in 
continuous time with Eq. (14), as follows:
Subject to:
where h is the previous nonlinear feedback control, u(tk) is the actual input control, N = N2 is the prediction 
horizon, t ∈[tk, tk+1] with tk = kts and ts is the sampling time.
Assumption 1:  Assuming that at the nominal operating point, the asymptotic stability of the closed-loop system 
is assured, all state constraints are satisfied in the stability region with respect to the existing feedback control 
input u = h(x) ∈U for all x ∈Xe , where U and Xe are the space where the control u and the state is defined, 
respectively. Therefore, the inequalities bellow, given by Eqs. (15), (16), (17) are valid for the inverse Lyapunov 
theorem-based nominal closed-loop ­system96.
where αi=1,2,3,4  are the K− function.
In this study, let’s denote S as the region where the controlled system is stable under the input law u = h(x) 
and Sδ the Lyapunov-based stability zone given by
with δ is a constant.
Lemma:  The inequalities bellow, given by Eqs. (18), (19) and (20) are hold if there exist positive constants 
C, Lx, Lω, Lx and Lω , such that the constraints are satisfied for all x and u.
where x = x(tk) and v = v(tk).
Proof:  The Eqs. (18)–(20) can be easily deduced by using the Lipschitz property of the function f  and the 
continuous differentiability of the Lyapunov function V(x) , that’s why the details are omitted, and the proof is 
considered complete.
Assumption 2  Assuming that the following scalar exists and is defined by the Eq. (21), as follows:
(14)
min
u
 tk+N
tk

yr(τ) −y(τ)
TŴy

yr(τ) −y(τ)

dτ +
 tk+Nu
tk
(u(τ))TR(u(τ))dτ.
(14.a)
ymin < y(t) < ymax, t ≤tk + N
(14.b)
umin < u(t) < umax, t ≤tk + Nu
(14.c)
umin < u(t) < umax, t ≤tk + Nu
(14.d)
u(t) = 0Fort > Nu
(14.e)
∂V(x(tk))
∂x
f (x(tk), u(tk), v(tk)) ≤∂V(x(tk))
∂x
f (x(tk), h(x(tk)), v(tk)),
(15)
α1(|x|) ≤V(x) ≤α2(|x|)
(16)
∂V(x)
∂x
f (x, h(x), v) ≤−α3(|x|)
(17)

∂V(x)
∂x
 ≤α4(|x|),
Sδ = {x ∫Xe : V(x) < δ},
(18)
f (x, u, v) −f (x, u, v)
 ≤Lx|x −x| + Lv|v −v|
(19)
f (x, u, v)
 ≤C
(20)

∂V(x)
∂x
f (x, u, v) −∂V(x)
∂x
f (x, u, v)
 ≤Lx|x −x| + Lv|v −v|,
(21)
δmin = max{V(x(t + ts)) : V(x(t) ≤δs)},


8
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
where δs is a constant and δmin is the maximum value of V(x(t + ts)) at the next sampling time when V(x(t)) is 
less than the constant δ.
Theorem  For the closed-loop system given in Eq. (10) controlled by solving the criterion shown in Eq. (12), if it 
exists x(t0) ∈Sδ , ε > 0 and δ > δs > 0 where ε is a constant, the inequality given by Eq. (22) can be hold assuming 
that the Eqs. (15)–(17) are satisfied.
where for all t ≥t0 there exists (δ > δmin > 0) guaranteeing the maintaining of states x(t) in the stability region 
and ϕ is the upper limit of disturbance variation over a sampling period.
Proof:  The time-derivative of the Lyapunov function can be computed using Eq. (23), taking into account the 
closed-loop system at time t ∈[tk, tk+1]:
The following inequality can be extended from Eq. (23) based on the constraint (14.e) as follow:
Using Eqs. (20), (24) can be written with this manner:
The formula below can be written according to Eq. (19) and during a sampling period where x(t) is continuous:
It is deduced from Eq. (16) that:
Replacing Eqs. (26) and \* MERGEFORMAT Eq. (27) in Eq. (25), the Eq. (28) bellow can be deduced:
If Eq. (22) is fulfilled, then there is a ε > 0 for which the subsequent inequality given by the Eq. (29) bellow 
is applied.
The function V(x(t)) continues to decrease at t ∈[tk, tk+1] , as demonstrated by the previous inequality. By 
integrating it from tk to tk+1 , the Eq. (30) bellow is obtained:
Therefore, if xtk ∈Sδ , then at time t ≥tk , all states of x(t) remain in the stable area Sδ . Furthermore, over a 
finite number of sampling times, the states x(t) will progressively converge to Sδmin and remain in this stable 
area for all of future periods.
This proof can be applied in discrete time to ensure that the controlled system is stable.
Simulation study
Several simulations are carried out to demonstrate the efficiency of the proposed LNNMPC-DTBO controller, 
using as application a highly nonlinear system: the squirrel cage induction motor. A comparison study is con-
ducted between the suggested controller and the NNMPC-DTBO, NNMPC-PSO, FLC-TLBO and PID-PSO.
Squirrel cage induction motor model
The squirrel cage induction motor is one of the three-phase induction motors currently used in industry in vari-
ous applications, such as pumps, conveyors, turbines and so ­on97,98. This kind of motor represents an excellent 
application for scientific research thanks to the number of nonlinearities it contains. The state model of this type 
of ­motor99,100 is given by Eq. (31), as follows:
(22)
−α3

α−1
2 (δs)

+ LxCts + Lvϕ ≤−ε
ts
,
(23)
˙V(x(t)) = ∂V(x(t))
∂x
f (x(t), u(t), v(t)).
(24)
˙V(x(t)) ≤∂V(x(t))
∂x
f (x(t), u(t), v(t)) −∂V(x(tk))
∂x
f (x(tk), u(tk), v(tk)) + ∂V(x(tk))
∂x
f

x(tk), h

x(tk)

, v(tk)

.
(25)
˙V(x(t)) ≤∂V(x(tk))
∂x
f (x(tk), h(x(tk)), v(tk)) + Lx|x(t) −x(tk)| + Lv|v(t) −v(tk)|.
(26)
|x(t) −x(tk)| ≤Cts.
(27)
∂V(x(tk))
∂x
f (x(tk), h(x(tk)), v(tk)) ≤−α3

α−1
2 (δs)

.
(28)
˙V(x(t)) ≤−α3

α−1
2 (δs)

+ LxCts + Lvϕ.
(29)
˙V(x(t)) ≤−ε
ts
.
(30)
V

x

tk+1

≤V(x(tk)) −ε.


9
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
where the state vector x =

FdsFqsFdrFqr
T are the stator and rotor flux linkages in the reference frame dq axis. 
The dq axis stator voltages are the control inputs vector u = [UdsUqs]T and Udr = Uqr = 0 are the rotor dq axis 
voltages. wb = 2πfb Is the motor’s angular electrical base frequency, we is the angular speed of the reference 
frame, and wr is the angular speed of the rotor. Xml , Xis , Xir , Xm and ˙wr are given by Eqs. (32), (33), (34), (35), 
(36), respectively.
where Te is the electrical output torque, Tr is the load torque, Lis is the stator phase inductance , Lir is the rotor 
phase inductance and Lm is the mutual inductance.
The electrical parameters of the considered squirrel cage induction motor are given in the table bellow:
System identification
In this work, four feed forward neural networks are used to identify the rotor and stator fluxes, which are utilized 
to compute the angular speed. The neural network models have the same following structure:
–	
where i =

ds, qs, dr, qr

.
–	 One hidden layer containing fifteen neurons and using a sigmoid activation function.
–	 An output layer corresponding to 

Fds, Fqs, Fdr

 and Fqr , with a linear activation function.
A dataset is generated with random inputs using the state model given in Eq. (31).
The test results of the obtained neural network models for each predicted output are shown in Fig. 2, and the 
prediction errors are shown in Fig. 3. The values of the Root Mean Square Error (RMSE), Mean Square Error 
(MSE), Mean Absolute Error (MAE) and determination coefficient (R2) for each model are gathered in Table 1. 
These values show that the obtained models are accurate.
Control implementation
Figure 4 illustrates the control diagram of the proposed LNNMPC-DTBO. Two simulation cases are performed 
using the neural network models defined above and the parameters mentioned in Table 2.
In the initial case, no overshoot constraint is considered, and the multistep reference trajectory is used to eval-
uate the performances of the proposed controller. The parameters of the NNMPC, PSO, and DTBO are presented 
in Tables 3, 4, 5, respectively. The results are compared to those obtained from PID-PSO, FLC-TLBO, NNMPC-
PSO, and NNMPC-DTBO, as shown in Fig. 5. The values of the MAE, MSE, and RMSE are given in Table 6. 
These values demonstrate that the proposed controller (LNNMPC-DTBO) gives the best tracking accuracy with 
(31)

















˙x1 = wb

Uds + we
wb x2 + Rs
Xis

Xml
Xir x3 +

Xml
Xis −1

x1

˙x2 = wb

Uqs −we
wb x1 + Rs
Xis

Xml
Xir x4 +

Xml
Xis −1

x2

˙x3 = wb

Udr + (we−wr)
wb
x4 + Rr
Xir

Xml
Xis x1 +

Xml
Xir −1

x3

,
˙x4 = wb

Uqr −(we−wr)
wb
x3 + Rr
Xir

Xml
Xis x2 +

Xml
Xir −1

x4

y = wr
(32)
Xml =
1
1
Xis +
1
Xir +
1
Xm
,
(33)
Xis = wbLis,
(34)
Xir = wbLir,
(35)
Xm = wbLm,
(36)
˙wr =
 P
2J

(Te −Tr),

Uds(k −1), Uds(k), Uqs(k −1), Uqs(k), Fi(k −1), Fi(k)

,
Table 1.   Metrics of the NNs prediction models.
Neural network
Fds
Fqs
Fdr
Fqr
MAE
3.1710
3.1625
3.2703
3.6247
MSE
37.7623
18.3092
3.2703
33.3081
RMSE
6.1451
4.2789
6.7616
5.7713
R2
0.9996
0.9998
0.9995
0.9995


10
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
the MAE enhancement percentage of 1.57% , 51.57% , 89.16% and 88.23% comparing to the NNMPC-DTBO, 
NNMPC_PSO, FLC-TLBO and PID-PSO, respectively.
In the second case, a 1% overshoot constraint is applied to the output of the predictive controllers (NNMPC-
DTBO, NNMPC-PSO and LNNMPC-DTBO) for the multistep and sinusoidal reference trajectories.
The obtained results for the second case, using multistep and sinusoidal reference trajectories, respectively, 
are presented in Figs. 6, 7, 8 and the control efforts signals are given in Figs. 7, 9. To evaluate the efficiency of the 
proposed controller, the values of the MAE, MSE, RMSE and computing time were calculated and are given in 
Figure 2.   Fluxes NN model test. (a) Flux ds (continuous line) and NN model output (dashed line). (b) Zoom of 
(a). (c) Flux qs (continuous line) and NN model output (dashed line). (d) Zoom of (c). (e) Flux dr (continuous 
line) and NN model output (dashed line), (f) Zoom of (e). (g) Flux ­qr (continuous line) and NN model output 
(dashed line), (h) Zoom of (g).


11
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Table 7 for the multistep and sinusoidal reference trajectories. From these values and the enhancement percent-
ages of the MAE for the multistep and sinusoidal reference trajectories, which are 15.99 and 30.48% compared to 
the NNMPC-DTBO and NNMPC-PSO, respectively, for the first reference, and 24.72 and 31.24% compared to 
the NNMPC-DTBO and NNMPC-PSO, respectively, for the second reference, it can be seen that the LNNMPC- 
DTBO gives the best tracking accuracy with minimal computing time and without overshoot (respecting the 
limit of the overshoot constraint and sampling time) to the NNMPC-PSO and NNMPC-DTBO.
Figure 3.   Error of Fluxes NN model test. (a) Error between neural and model output of flux ds. (b) Zoom of 
(a). (c) Error between neural and model output of flux qs. (d) Zoom of (c). (e) Error between neural and model 
output of flux dr, (f) Zoom of (e). (g) Error between neural and model output of flux ­qr. (h) Zoom of (g).


12
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Effect of external disturbances and measurement noise
In order to show the LNNMPC-DTBO controller’s proficiency to reject external disturbances and compensate 
for measurement noise, several simulation cases were proposed.
In the first case, a measurement noise of 10 (tr/min) amplitude, mean value of 0.4955 and variance of 0.0854 
is applied to the system output throughout the simulation.
Figure 4.   Induction motor speed control block diagram.
Table 2.   Induction motor parameters.
Parameters
Value
Parameters
Value
Stator phase inductance (Lis)
0.21e −3H
Stator phase resistance (Rr)
0.39
Rotor phase inductance (Lir)
0.6e −3H
Poles number (P)
2
Mutual inductance (Lml
4e −3H
Inertia moment (J)
0.0226kgm2
Rotor phase resistance (Rs)
0.19
Base frequency (fb)
100Hz
Table 3.   NNMPC parameters.
Parameters
Values
Parameters
Values
N1
1
Nu
1
N2
4
R
4e −4
Sampling time (s)
0.01
Umin(V)
−326
Umax(V)
326
Table 4.   PSO parameters.
Parameters
Values
Parameters
Values
c1
2
w
1
c2
2
wd
0.99
Table 5.   DTBO parameters.
Parameters
Values
Parameters
Values
N
10
m
2
T
10


13
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
For the second case, two different disturbance types were used with the multistep and sinusoidal reference 
trajectories, respectively. A pulse of −25% of the input is added to the control input during the interval [1.5s, 2.5s] . 
An output disturbance with an amplitude of +30% of the output is added during the interval [1.5s, 2.5s].
Table 6.   MAE, MSE, RMSE values without constraint. The values that are bolded represent the best values.
MAE
MSE
RMSE
LNNLMPC-DTBO
6.2805
4.3214e + 03
65.7375
NNMPC-DTBO
8.0086
4.4242e + 03
66.5149
NNMPC-PSO
12.9689
4.4818e + 03
66.9462
FLC-TLBO
57.7139
2.3954e + 04
154.7719
PID-PSO
53.3979
2.4424e + 04
156.2831
Figure 5.   Performances of induction motor speed control with multistep trajectory, without constraint. (a) 
Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular speed.
Table 7.   MAE, MSE, RMSE values with overshoot constraint. The values that are bolded represent the best 
values.
Controller
LNNLMPC-DTBO
NNMPC-DTBO
NNMPC-PSO
Multistep trajectory
MAE
8.1908
9.7505
11.7835
MSE
4.6128e + 03
4.6858e + 03
4.9124e + 03
RMSE
67.9176
68.4532
70.0886
Computing time (ms)
1.334174
1.985236
2.1657730
Sinusoidal trajectory
MAE
4.3815
5.8203
6.3724
MSE
35.1412
74.8054
115.6211
RMSE
5.9280
8.6490
10.7527
Computing time (ms)
1.148899
1.333881
2.809656


14
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 6.   Performances of induction motor speed control with multistep trajectory, with overshoot constraint. 
(a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular 
speed.
Figure 7.   Control effort in the case of multistep trajectory, with overshoot constraint. (a) Control effort ­Uds. (b) 
Control effort ­Uqs.


15
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 8.   Performances of induction motor speed control with sinusoidal trajectory and overshoot constraint. 
(a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular 
speed.
Figure 9.   Control efforts in the case of sinusoidal trajectory and overshoot constraint. (a) Control effort ­Uds. (b) 
Control effort ­Uqs.


16
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
In the third case, different perturbations are applied by changing the values of the load torque Tr as fol-
lows:Tr = 0Nm , Tr = 5Nm , Tr = 10Nm and Tr = 25Nm illustrated in Table 8.The system’s response is illustrated 
in Figs. 16, 17 with multistep and sinusoidal reference trajectories, respectively, considering the last value of the 
load torque where the perturbation is significant.
After applying various disturbances to the induction motor with multistep and sinusoidal desired reference 
trajectories, as illustrated in the (Figs. 10, 11) for white noise measurement, in the (Figs. 12, 13) for the input 
disturbance, in the (Figs. 14, 15) for the output disturbance, in the (Figs. 16, 17) for the load torque variation, 
and based on the results gathered in Tables 9, 8, the proposed controller demonstrates its robustness with respect 
to disturbance rejection and less sensitivity to noise measurement.
Conclusion and future research directions
In this work, a new control method called Lyapunov-based neural network model predictive control using 
metaheuristic optimization approach was suggested. The efficiency of this approach is due to the use of neural 
network models on the one hand, known for their simplicity and ability to model complex and highly nonlinear 
systems, and the use of the DTBO optimization algorithm, known for its fast convergence, to optimize the cost 
Table 8.   RMSE, MSE, and MAE values for different load torques.
References
Load torques (Nm)
RMSE
MSE
MAE
Multistep trajectory
Tr = 0
67.3731
4.5391e + 03
7.6975
Tr = 5
68.2399
4.6567e + 03
7.6946
Tr = 10
66.4552
4.4163e + 03
7.2174
Tr = 25
69.6708
4.8540e + 03
8.0448
Sinusoidal trajectory
Tr = 0
6.4061
41.0384
4.6520
Tr = 5
5.4623
29.8365
3.9243
Tr = 10
5.8357
34.0556
4.1151
Tr = 25
6.1909
38.3274
4.3836
Table 9.   RMAE, MSE, and MAE values for different disturbances and noise.
References
Disturbances
RMSE
MSE
MAE
Multistep trajectory
 − 25% input disturbance
68.3632
4.6735e + 03
9.0594
 + 30%output disturbance
69.5875
4.8424e + 03
8.3371
Measurement noise (1rand)
65.4385
4.2822e + 03
16.4817
Sinusoidal trajectory
 − 25% input disturbance
6.8910
47.4861
4.8273
 + 30%output disturbance
13.1040
171.7138
6.8056
Measurement noise (1rand)
18.4433
340.1548
15.7536


17
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
function of predictive controller, on the other hand. The stability of the proposed technique was mathematically 
proved, and the carried out simulations demonstrated that the proposed controller can successfully manage the 
imposed constraints during the optimization process and offers better results in terms of robustness, accuracy 
and computation time than the others controller such as optimized PID by PSO algorithm, fuzzy logic using 
TLBO algorithm, NNMPC based on PSO and DTBO. Considering the obtained results, it can be concluded 
that the LNNMPC-DTBO can be used to control highly nonlinear, multivariable, and constrained systems with 
fast dynamics.
The promising results obtained from the Lyapunov-based neural network model predictive control employ-
ing metaheuristic optimization suggest several avenues for future research. First, further investigation into 
alternative metaheuristic algorithms could provide insights into optimization efficiency and control accuracy, 
particularly under varying system dynamics and noise conditions. Additionally, expanding the application scope 
of LNNMPC to other complex and nonlinear systems such as aerospace or biological systems could demon-
strate the versatility and robustness of this control strategy. Another critical area involves enhancing the model’s 
predictive capabilities through the integration of deep learning techniques, which could improve the handling 
of large-scale data and complex variable interactions. Moreover, the development of real-time implementation 
strategies for LNNMPC that address computational constraints is crucial for its adoption in industry-critical 
applications. Lastly, exploring the theoretical aspects of stability and robustness within the framework of Lyapu-
nov’s direct method could solidify the theoretical underpinnings of the control strategy and enhance its appeal 
in safety–critical applications. These efforts would not only extend the current capabilities of predictive control 
but also broaden the impact of LNNMPC in practical and industrial settings.
Figure 10.   Performance of the induction motor speed control with measurement noise and multistep 
trajectory. (a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual 
angular speed.


18
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 11.   Performance of the induction motor speed control with measurement noise and sinusoidal 
trajectory. (a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual 
angular speed.


19
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 12.   Performance of the induction motor speed control with input disturbance and multistep trajectory. (a) 
Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular speed.
Figure 13.   Performance of the induction motor speed control with input disturbance and sinusoidal trajectory. 
(a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular 
speed.


20
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 14.   Performance of the induction motor speed control with output disturbance and multistep trajectory. 
(a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual angular 
speed.


21
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 15.   Performance of the induction motor speed control with output disturbance and sinusoidal 
trajectory. (a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual 
angular speed.


22
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Figure 16.   Performance of the induction motor speed control with load torque Tr = 25Nm and multistep 
trajectory. (a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual 
angular speed.


23
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
Data availability
The datasets used and/or analyzed during the current study available from the corresponding author on reason-
able request.
Received: 5 June 2024; Accepted: 5 August 2024
References
	
1.	 Schwenzer, M., Ay, M., Bergs, T. & Abel, D. Review on model predictive control: An engineering perspective. Int. J. Adv. Manuf. 
Technol. 117, 1327–1349. https://​doi.​org/​10.​1007/​s00170-​021-​07682-3 (2021).
	
2.	 Ahmed, A. A., Koh, B. K. & Il Lee, Y. A comparison of finite control set and continuous control set model predictive control 
schemes for speed control of induction motors. IEEE Trans. Ind. Inform. 14, 1334–1346. https://​doi.​org/​10.​1109/​TII.​2017.​27583​
93 (2018).
	
3.	 Wang, Y., Sun, R., Cheng, Q. & Ochieng, W. Y. Measurement quality control aided multisensor system for improved vehicle 
navigation in urban areas. IEEE Trans. Ind. Electron. 71, 6407–6417. https://​doi.​org/​10.​1109/​TIE.​2023.​32881​88 (2024).
	
4.	 Djouadi, H. et al. Non-linear multivariable permanent magnet synchronous machine control: A robust non-linear generalized 
predictive controller approach. IET Control Theory Appl. 17, 1688–1702. https://​doi.​org/​10.​1049/​cth2.​12509 (2023).
	
5.	 Xu, B. & Guo, Y. A novel DVL calibration method based on Robust invariant extended Kalman filter. IEEE Trans. Veh. Technol. 
71, 9422–9434. https://​doi.​org/​10.​1109/​TVT.​2022.​31820​17 (2022).
	
6.	 Belkhier, Y. et al. Experimental analysis of passivity-based control theory for permanent magnet synchronous motor drive fed 
by grid power. IET Control Theory Appl. 18, 495–510. https://​doi.​org/​10.​1049/​cth2.​12574 (2024).
	
7.	 Zhang, J., Chen, Y., Gao, Y., Wang, Z. & Peng, G. Cascade ADRC speed control base on FCS-MPC for permanent magnet syn-
chronous motor. J. Circuits Syst. Comput. https://​doi.​org/​10.​1142/​S0218​12662​15020​29 (2021).
	
8.	 Kasri, A. et al. Real-time and hardware in the loop validation of electric vehicle performance: Robust nonlinear predictive speed 
and currents control based on space vector modulation for PMSM. Results Eng. 22, 102223. https://​doi.​org/​10.​1016/j.​rineng.​
2024.​102223 (2024).
	
9.	 Zhang, J. et al. Fractional order complementary non-singular terminal sliding mode control of PMSM based on neural network. 
Int. J. Automot. Technol. 25, 213–224. https://​doi.​org/​10.​1007/​s12239-​024-​00015-9 (2024).
	 10.	 Kasri, A., Ouari, K., Belkhier, Y., Bajaj, M. & Zaitsev, I. Optimizing electric vehicle powertrains peak performance with robust 
predictive direct torque control of induction motors: A practical approach and experimental validation. Sci. Rep. 14, 14977. 
https://​doi.​org/​10.​1038/​s41598-​024-​65988-0 (2024).
	 11.	 Deng, Z. W., Zhao, Y. Q., Wang, B. H., Gao, W. & Kong, X. A preview driver model based on sliding-mode and fuzzy control for 
articulated heavy vehicle. Meccanica 57, 1853–1878. https://​doi.​org/​10.​1007/​s11012-​022-​01532-6 (2022).
	 12.	 Ouari, K. et al. Improved nonlinear generalized model predictive control for robustness and power enhancement of a DFIG-
based wind energy converter. Front. Energy Res. https://​doi.​org/​10.​3389/​fenrg.​2022.​996206 (2022).
Figure 17.   Performance of the induction motor speed control with load torque Tr = 25Nm and sinusoidal 
trajectory. (a) Reference trajectory and actual angular speed. (b) Error between reference trajectory and actual 
angular speed.


24
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
	 13.	 Mohammadzadeh, A. et al. A non-linear fractional-order type-3 fuzzy control for enhanced path-tracking performance of 
autonomous cars. IET Control Theory Appl. 18, 40–54. https://​doi.​org/​10.​1049/​cth2.​12538 (2024).
	 14.	 Kakouche, K. et al. Model predictive direct torque control and fuzzy logic energy management for multi power source electric 
vehicles. Sensors 22, 5669. https://​doi.​org/​10.​3390/​s2215​5669 (2022).
	 15.	 Luo, R., Peng, Z., Hu, J. & Ghosh, B. K. Adaptive optimal control of affine nonlinear systems via identifier–critic neural network 
approximation with relaxed PE conditions. Neural Netw. 167, 588–600. https://​doi.​org/​10.​1016/j.​neunet.​2023.​08.​044 (2023).
	 16.	 Belkhier, Y. et al. Robust interconnection and damping assignment energy-based control for a permanent magnet synchronous 
motor using high order sliding mode approach and nonlinear observer. Energy Rep. 8, 1731–1740. https://​doi.​org/​10.​1016/j.​
egyr.​2021.​12.​075 (2022).
	 17.	 Guo, C., Hu, J., Wu, Y. & Čelikovský, S. Non-singular fixed-time tracking control of uncertain nonlinear pure-feedback systems 
with practical state constraints. IEEE Trans. Circuits Syst. I Regul. Pap. 70, 3746–3758. https://​doi.​org/​10.​1109/​TCSI.​2023.​32917​
00 (2023).
	 18.	 Liu, X., Suo, Y., Zhang, Z., Song, X. & Zhou, J. A new model predictive current control strategy for hybrid energy storage system 
considering the SOC of the supercapacitor. IEEE J. Emerg. Sel. Top. Power Electron. 11, 325–338. https://​doi.​org/​10.​1109/​JESTPE.​
2022.​31596​65 (2023).
	 19.	 Fang, L., Li, D. & Qu, R. Torque improvement of vernier permanent magnet machine with larger rotor pole pairs than stator 
teeth number. IEEE Trans. Ind. Electron. 70, 12648–12659. https://​doi.​org/​10.​1109/​TIE.​2022.​32326​51 (2023).
	 20.	 Dos Santos, T. B. et al. Robust finite control set model predictive current control for induction motor using deadbeat approach 
in stationary frame. IEEE Access 11, 13067–13078. https://​doi.​org/​10.​1109/​ACCESS.​2022.​32233​85 (2023).
	 21.	 Wang, Z., Wang, S., Wang, X. & Luo, X. Underwater moving object detection using superficial electromagnetic flow velometer 
array-based artificial lateral line system. IEEE Sens. J. 24, 12104–12121. https://​doi.​org/​10.​1109/​JSEN.​2024.​33702​59 (2024).
	 22.	 Wu, W. et al. Data-driven finite control-set model predictive control for modular multilevel converter. IEEE J. Emerg. Sel. Top. 
Power Electron. 11, 523–531. https://​doi.​org/​10.​1109/​JESTPE.​2022.​32074​54 (2023).
	 23.	 Wang, Z., Wang, S., Wang, X. & Luo, X. Permanent magnet-based superficial flow velometer with ultralow output drift. IEEE 
Trans. Instrum. Meas. 72, 1–12. https://​doi.​org/​10.​1109/​TIM.​2023.​33046​92 (2023).
	 24.	 Zhang, H., Wu, H., Jin, H. & Li, H. High-dynamic and low-cost sensorless control method of high-speed brushless DC motor. 
IEEE Trans. Ind. Inform. 19, 5576–5584. https://​doi.​org/​10.​1109/​TII.​2022.​31963​58 (2023).
	 25.	 Richalet, J., Rault, A., Testud, J. L. & Papon, J. Model predictive heuristic control. Automatica 14, 413–428. https://​doi.​org/​10.​
1016/​0005-​1098(78)​90001-8 (1978).
	 26.	 Allgöwer, F., Badgwell, T. A., Qin, J. S., Rawlings, J. B. & Wright, S. J. Nonlinear predictive control and moving horizon estima-
tion—an introductory overview. In Advances in Control (ed. Frank, Paul M.) 391–449 (Springer, London, 1999). https://​doi.​org/​
10.​1007/​978-1-​4471-​0853-5_​19.
	 27.	 Kvasnica, M., Herceg, M., Čirka, Ľ & Fikar, M. Model predictive control of a CSTR: A hybrid modeling approach. Chem. Pap. 
https://​doi.​org/​10.​2478/​s11696-​010-​0008-8 (2010).
	 28.	 Richalet, J. Industrial applications of model based predictive control. Automatica 29, 1251–1274. https://​doi.​org/​10.​1016/​0005-​
1098(93)​90049-Y (1993).
	 29.	 K. Nejadkazemi, A. Fakharian, Pressure control in gas oil pipeline: A supervisory model predictive control approach, In: 2016 
4th International Conference on Control, Instrumentation, and Automation, IEEE, 2016: pp. 396–400. https://​doi.​org/​10.​1109/​
ICCIA​utom.​2016.​74831​95.
	 30.	 Wang, Y., Geng, Y., Yan, Y., Wang, J. & Fang, Z. Robust model predictive control of a micro machine tool for tracking a periodic 
force signal. Optim. Control Appl. Methods 41, 2037–2047. https://​doi.​org/​10.​1002/​oca.​2642 (2020).
	 31.	 Durmuş, B., Temurtaş, H., Yumuşak, N. & Temurtaş, F. A study on industrial robotic manipulator model using model based 
predictive controls. J. Intell. Manuf. 20, 233–241. https://​doi.​org/​10.​1007/​s10845-​008-​0221-2 (2009).
	 32.	 Holkar, K. S. & Waghmare, L. M. An overview of model predictive control. Int. J. Control Autom. 3, 47–63 (2010).
	 33.	 Morari, M., Garcia, C. E. & Prett, D. M. Model predictive control: Theory and practice. IFAC Proc. 21, 1–12. https://​doi.​org/​10.​
1016/​B978-0-​08-​035735-​5.​50006-1 (1988).
	 34.	 C.R. cutler, dynamic matrix control: an optimal multivariable control algorithm with constraints, University of Houston ProQuest 
Dissertations & Theses, (1983).
	 35.	 Ydstie, B. E., Kemna, A. H. & Liu, L. K. Multivariable extended-horizon adaptive control. Comput. Chem. Eng. 12, 733–743. 
https://​doi.​org/​10.​1016/​0098-​1354(88)​80011-5 (1988).
	 36.	 Clarke, D. W., Mohtadi, C. & Tuffs, P. S. Generalized predictive control—part II extensions and interpretations. Automatica 23, 
149–160. https://​doi.​org/​10.​1016/​0005-​1098(87)​90088-4 (1987).
	 37.	 Li, Z. & Wang, G. Generalized predictive control of linear time-varying systems. J. Frankl. Inst. 354, 1819–1832. https://​doi.​org/​
10.​1016/j.​jfran​klin.​2016.​10.​021 (2017).
	 38.	 Clarke, D. W., Mohtadi, C. & Tuffs, P. S. Generalized predictive control—Part I The basic algorithm. Automatica 23, 137–148. 
https://​doi.​org/​10.​1016/​0005-​1098(87)​90087-2 (1987).
	 39.	 Anis, K. & Tarek, G. An improved robust predictive control approach based on generalized 3rd order S-PARAFAC volterra model 
applied to a 2-DoF helicopter system. Int. J. Control Autom. Syst. 19, 1618–1632. https://​doi.​org/​10.​1007/​s12555-​019-​0936-1 
(2021).
	 40.	 Kansha, Y. & Chiu, M.-S. Adaptive generalized predictive control based on JITL technique. J. Process Control 19, 1067–1072. 
https://​doi.​org/​10.​1016/j.​jproc​ont.​2009.​04.​002 (2009).
	 41.	 Zhou, X., Lu, F., Zhou, W. & Huang, J. An improved multivariable generalized predictive control algorithm for direct performance 
control of gas turbine engine. Aerosp. Sci. Technol. 99, 105576. https://​doi.​org/​10.​1016/j.​ast.​2019.​105576 (2020).
	 42.	 Lee, J. B. et al. Enhanced model predictive control (eMPC) strategy for automated glucose control. Ind. Eng. Chem. Res. 55, 
11857–11868. https://​doi.​org/​10.​1021/​acs.​iecr.​6b027​18 (2016).
	 43.	 Aufderheide, B. & Bequette, B. W. Extension of dynamic matrix control to multiple models. Comput. Chem. Eng. 27, 1079–1096. 
https://​doi.​org/​10.​1016/​S0098-​1354(03)​00038-3 (2003).
	 44.	 Qin, C. et al. RCLSTMNet: A residual-convolutional-LSTM neural network for forecasting cutterhead torque in shield machine. 
Int. J. Control Autom. Syst. 22, 705–721. https://​doi.​org/​10.​1007/​s12555-​022-​0104-x (2024).
	 45.	 Bai, X., Xu, M., Li, Q. & Yu, L. Trajectory-battery integrated design and its application to orbital maneuvers with electric pump-
fed engines. Adv. Space Res. 70, 825–841. https://​doi.​org/​10.​1016/j.​asr.​2022.​05.​014 (2022).
	 46.	 Yin, L. et al. AFBNet: A lightweight adaptive feature fusion module for super-resolution algorithms. Comput. Model Eng. Sci. 
https://​doi.​org/​10.​32604/​cmes.​2024.​050853 (2024).
	 47.	 Conceição, A. S., Moreira, A. P. & Costa, P. J. A nonlinear model predictive control strategy for trajectory tracking of a four-
wheeled omnidirectional mobile robot. Optim. Control Appl. Methods 29, 335–352. https://​doi.​org/​10.​1002/​oca.​827 (2008).
	 48.	 Käpernick, B. & Graichen, K. Nonlinear model predictive control based on constraint transformation. Optim. Control Appl. 
Methods 37, 807–828. https://​doi.​org/​10.​1002/​oca.​2215 (2016).
	 49.	 Grüne, L. & Pannek, J. Nonlinear Model Predictive Control (Springer London, 2011). https://​doi.​org/​10.​1007/​978-0-​85729-​501-9.
	 50.	 Karak, T., Basak, S., Joseph, P. A. & Sengupta, S. Non-linear model predictive control based trajectory tracking of hand and 
wrist motion using functional electrical stimulation. Control Eng. Pract. 146, 105895. https://​doi.​org/​10.​1016/j.​conen​gprac.​2024.​
105895 (2024).


25
Vol.:(0123456789)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
	 51.	 Doyle, F. J., Ogunnaike, B. A. & Pearson, R. K. Nonlinear model-based control using second-order Volterra models. Automatica 
31, 697–714. https://​doi.​org/​10.​1016/​0005-​1098(94)​00150-H (1995).
	 52.	 J.K. Gruber, D.R. Ramirez, T. Alamo, C. Bordons, Nonlinear Min-Max Model Predictive Control based on Volterra models. 
Application to a pilot plant, In: 2009 European Control Conference, IEEE, 2009: pp. 1112–1117. https://​doi.​org/​10.​23919/​ECC.​
2009.​70745​54.
	 53.	 B.R. Maner, F.J. Doyle, B.A. Ogunnaike, R.K. Pearson, A nonlinear model predictive control scheme using second order Volterra 
models, In: Proceedings of 1994 American Control Conference - ACC ’94, IEEE, n.d.: pp. 3253–3257. https://​doi.​org/​10.​1109/​
ACC.​1994.​735176.
	 54.	 Hu, J., Liu, K. & Xia, Y. Output feedback fuzzy model predictive control with multiple objectives. J. Frankl. Inst. 361, 32–45. 
https://​doi.​org/​10.​1016/j.​jfran​klin.​2023.​11.​026 (2024).
	 55.	 Lu, Q., Shi, P., Lam, H.-K. & Zhao, Y. Interval type-2 fuzzy model predictive control of nonlinear networked control systems. 
IEEE Trans. Fuzzy Syst. 23, 2317–2328. https://​doi.​org/​10.​1109/​TFUZZ.​2015.​24179​75 (2015).
	 56.	 Howlett, P. J. P. P. G. Advances in Industrial Control (Springer International Publishing, 2006). https://​doi.​org/​10.​1007/​
978-3-​319-​21021-6.
	 57.	 Botto, M. A., Van Den Boom, T. J. J., Krijgsman, A. & Da Costa, J. S. Predictive control based on neural network models with 
I/O feedback linearization. Int. J. Control 72, 1538–1554. https://​doi.​org/​10.​1080/​00207​17992​20038 (1999).
	 58.	 Draeger, H. R. A. & Engell, S. Model predictive control using neural networks [25 years ago]. IEEE Control Syst. 40, 11–12. 
https://​doi.​org/​10.​1109/​MCS.​2020.​30050​08 (2020).
	 59.	 Lupu, D. & Necoara, I. Exact representation and efficient approximations of linear model predictive control laws via HardTanh 
type deep neural networks. Syst. Control Lett. 186, 105742. https://​doi.​org/​10.​1016/j.​sysco​nle.​2024.​105742 (2024).
	 60.	 Mazinan, A. H. & Sheikhan, M. On the practice of artificial intelligence based predictive control scheme: A case study. Appl. 
Intell. 36, 178–189. https://​doi.​org/​10.​1007/​s10489-​010-​0253-0 (2012).
	 61.	 Patan, K. Two stage neural network modelling for robust model predictive control. ISA Trans. 72, 56–65. https://​doi.​org/​10.​
1016/j.​isatra.​2017.​10.​011 (2018).
	 62.	 Zhao, D., Cui, L. & Liu, D. Bearing weak fault feature extraction under time-varying speed conditions based on frequency 
matching demodulation transform. IEEE/ASME Trans. Mechatron. 28, 1627–1637. https://​doi.​org/​10.​1109/​TMECH.​2022.​32155​
45 (2023).
	 63.	 Wang, R. et al. FI-NPI: Exploring optimal control in parallel platform systems. Electronics 13, 1168. https://​doi.​org/​10.​3390/​
elect​ronic​s1307​1168 (2024).
	 64.	 Allgöwer, Z. K. N. F. & Findeisen, R. Nonlinear model predictive control: From theory to application. J. Chin. Inst. Chem. Eng. 
35, 299–315 (2004).
	 65.	 Silva, N. F., Dórea, C. E. T. & Maitelli, A. L. An iterative model predictive control algorithm for constrained nonlinear systems. 
Asian J. Control 21, 2193–2207. https://​doi.​org/​10.​1002/​asjc.​1815 (2019).
	 66.	 Mayne, D. Nonlinear model predictive control: challenges and opportunities. In Nonlinear Model Predictive Control (ed. Mayne, 
D.) 23–44 (Birkhäuser Basel, 2000).
	 67.	 Farina, M., Giulioni, L. & Scattolini, R. Stochastic linear model predictive control with chance constraints—a review. J. Process 
Control 44, 53–67. https://​doi.​org/​10.​1016/j.​jproc​ont.​2016.​03.​005 (2016).
	 68.	 Kouvaritakis, B. & Cannon, M. Stochastic model predictive control. In Encyclopedia of Systems and Control (eds Kouvaritakis, 
B. & Cannon, M.) 1–9 (Springer London, 2014). https://​doi.​org/​10.​1007/​978-1-​4471-​5102-9_​7-1.
	 69.	 Ma, Y., Matusko, J. & Borrelli, F. Stochastic model predictive control for building HVAC systems: Complexity and conservatism. 
IEEE Trans. Control Syst. Technol. 23, 101–116. https://​doi.​org/​10.​1109/​TCST.​2014.​23137​36 (2015).
	 70.	 De Mendonca Mesquita, E., Sampaio, R. C., Ayala, H. V. H. & Llanos, C. H. Recent meta-heuristics improved by self-adaptation 
applied to nonlinear model-based predictive control. IEEE Access 8, 118841–118852. https://​doi.​org/​10.​1109/​ACCESS.​2020.​
30053​18 (2020).
	 71.	 M.S. and Y.L. Q. Zou, J. Ji, S. Zhang, Model predictive control based on particle swarm optimization of greenhouse climate for 
saving energy consumption, in: 2010 World Automation Congress Kobe, Japan, 2010: pp. 123–128.
	 72.	 C. Stiti, K. Kara, M. Benrabah, A. Aouaichia, Neural Network Model Predictive Control Based on PSO Approach: Applied to 
DC Motor, In: 2023 2nd International Conference on Electronics, Energy and Measurement, IEEE, 2023: pp. 1–6. https://​doi.​
org/​10.​1109/​IC2EM​59347.​2023.​10419​476.
	 73.	 Zhang, Y., Zhao, D., He, L., Zhang, Y. & Huang, J. Research on prediction model of electric vehicle thermal management system 
based on particle swarm optimization- back propagation neural network. Therm. Sci. Eng. Prog. 47, 102281. https://​doi.​org/​10.​
1016/j.​tsep.​2023.​102281 (2024).
	 74.	 Ait Sahed, O., Kara, K., Benyoucef, A. & Hadjili, M. L. An efficient artificial bee colony algorithm with application to nonlinear 
predictive control. Int. J. Gen. Syst. 45, 393–417. https://​doi.​org/​10.​1080/​03081​079.​2015.​10863​44 (2016).
	 75.	 Sahed, O. A., Kara, K. & Benyoucef, A. Artificial bee colony-based predictive control for non-linear systems. Trans. Inst. Meas. 
Control 37, 780–792. https://​doi.​org/​10.​1177/​01423​31214​546796 (2015).
	 76.	 Zimmer, A., Schmidt, A., Ostfeld, A. & Minsker, B. Evolutionary algorithm enhancement for model predictive control and 
real-time decision support. Environ. Model. Softw. 69, 330–341. https://​doi.​org/​10.​1016/j.​envso​ft.​2015.​03.​005 (2015).
	 77.	 Rao, R. V., Savsani, V. J. & Vakharia, D. P. Teaching–learning-based optimization: A novel method for constrained mechanical 
design optimization problems. Comput. Des. 43, 303–315. https://​doi.​org/​10.​1016/j.​cad.​2010.​12.​015 (2011).
	 78.	 Benrabah, M., Kara, K., AitSahed, O. & Hadjili, M. L. Constrained nonlinear predictive control using neural networks and teach-
ing–learning-based optimization. J. Control Autom. Electr. Syst. 32, 1228–1243. https://​doi.​org/​10.​1007/​s40313-​021-​00755-4 
(2021).
	 79.	 Aouaichia, A., Kara, K., Benrabah, M. & Hadjili, M. L. Constrained neural network model predictive controller based on Archi-
medes optimization algorithm with application to robot manipulators. J. Control Autom. Electr. Syst. 34, 1159–1178. https://​doi.​
org/​10.​1007/​s40313-​023-​01033-1 (2023).
	 80.	 and P.T. M. Dehghani, E. Trojovská, Driving Training-Based Optimization: A New Human-Based Metaheuristic Algorithm for 
Solving Optimization Problems, 2022.
	 81.	 Sun, Q., Lyu, G., Liu, X., Niu, F. & Gan, C. Virtual current compensation-based quasi-sinusoidal-wave excitation scheme for 
switched reluctance motor drives. IEEE Trans. Ind. Electron. 71, 10162–10172. https://​doi.​org/​10.​1109/​TIE.​2023.​33330​56 (2024).
	 82.	 Bai, X., He, Y. & Xu, M. Low-thrust reconfiguration strategy and optimization for formation flying using Jordan normal form. 
IEEE Trans. Aerosp. Electron. Syst. 57, 3279–3295. https://​doi.​org/​10.​1109/​TAES.​2021.​30742​04 (2021).
	 83.	 Dehghani, M., Trojovská, E. & Trojovský, P. A new human-based metaheuristic algorithm for solving optimization problems 
on the base of simulation of driving training process. Sci. Rep. 12, 9924. https://​doi.​org/​10.​1038/​s41598-​022-​14225-7 (2022).
	 84.	 Freitas, D., Lopes, L. G. & Morgado-Dias, F. Particle swarm optimisation: A historical review up to the current developments. 
Entropy 22, 362. https://​doi.​org/​10.​3390/​e2203​0362 (2020).
	 85.	 N.M. Sabri, M. Puteh, M.R. Mahmood, An overview of Gravitational Search Algorithm utilization in optimization problems, 
In: 2013 IEEE 3rd International Conference System Engineering Technology, IEEE, 2013: pp. 61–66. https://​doi.​org/​10.​1109/​
ICSEn​gT.​2013.​66501​44.
	 86.	 Faris, H., Aljarah, I., Al-Betar, M. A. & Mirjalili, S. Grey wolf optimizer: A review of recent variants and applications. Neural 
Comput. Appl. 30, 413–435. https://​doi.​org/​10.​1007/​s00521-​017-​3272-5 (2018).


26
Vol:.(1234567890)
Scientific Reports |        (2024) 14:18760  | 
https://doi.org/10.1038/s41598-024-69365-9
www.nature.com/scientificreports/
	 87.	 Mirjalili, S. & Lewis, A. The whale optimization algorithm. Adv. Eng. Softw. 95, 51–67. https://​doi.​org/​10.​1016/j.​adven​gsoft.​
2016.​01.​008 (2016).
	 88.	 Abualigah, L., Elaziz, M. A., Sumari, P., Geem, Z. W. & Gandomi, A. H. Reptile search algorithm (RSA): A nature-inspired 
meta-heuristic optimizer. Expert Syst. Appl. 191, 116158. https://​doi.​org/​10.​1016/j.​eswa.​2021.​116158 (2022).
	 89.	 Mhaskar, P., El-Farra, N. H. & Christofides, P. D. Stabilization of nonlinear systems with state and control constraints using 
Lyapunov-based predictive control. Syst. Control Lett. 55, 650–659. https://​doi.​org/​10.​1016/j.​sysco​nle.​2005.​09.​014 (2006).
	 90.	 Luo, J. et al. Lyapunov based nonlinear model predictive control of wind power generation system with external disturbances. 
IEEE Access 12, 5103–5116. https://​doi.​org/​10.​1109/​ACCESS.​2024.​33502​04 (2024).
	 91.	 Gao, S. et al. Extremely compact and lightweight triboelectric nanogenerator for spacecraft flywheel system health monitoring. 
Nano Energy 122, 109330. https://​doi.​org/​10.​1016/j.​nanoen.​2024.​109330 (2024).
	 92.	 Wang, S. et al. Tooth backlash inspired comb-shaped single-electrode triboelectric nanogenerator for self-powered condition 
monitoring of gear transmission. Nano Energy 123, 109429. https://​doi.​org/​10.​1016/j.​nanoen.​2024.​109429 (2024).
	 93.	 Ouabi, O.-L. et al. Learning the propagation properties of rectangular metal plates for Lamb wave-based mapping. Ultrasonics 
123, 106705. https://​doi.​org/​10.​1016/j.​ultras.​2022.​106705 (2022).
	 94.	 Babaghorbani, B., Beheshti, M. T. & Talebi, H. A. A Lyapunov-based model predictive control strategy in a permanent magnet 
synchronous generator wind turbine. Int. J. Electr. Power Energy Syst. 130, 106972. https://​doi.​org/​10.​1016/j.​ijepes.​2021.​106972 
(2021).
	 95.	 Wang, R. & Bao, J. A differential Lyapunov-based tube MPC approach for continuous-time nonlinear processes. J. Process Control 
83, 155–163. https://​doi.​org/​10.​1016/j.​jproc​ont.​2018.​11.​006 (2019).
	 96.	 B. Mohamed, K. Kamel, Optimal Fuzzy Logic Controller Using Teaching Learning Based Optimization for asynchronous motor, 
In: 2022 19th International Multi-Conference Systems, Signals and Devices, IEEE, 2022: pp. 1478–1483. https://​doi.​org/​10.​1109/​
SSD54​932.​2022.​99557​52.
	 97.	 Wang, H., Sun, W., Jiang, D. & Qu, R. A MTPA and flux-weakening curve identification method based on physics-informed 
network without calibration. IEEE Trans. Power Electron. 38, 12370–12375. https://​doi.​org/​10.​1109/​TPEL.​2023.​32959​13 (2023).
	 98.	 Li, J., Wu, X. & Wu, L. A computationally-efficient analytical model for SPM machines considering PM shaping and property 
distribution. IEEE Trans. Energy Convers. 39, 1034–1046. https://​doi.​org/​10.​1109/​TEC.​2024.​33525​77 (2024).
	 99.	 Dorji, P. & Subba, B. D-Q mathematical modelling and simulation of three-phase induction motor for electrical fault analysis. 
IARJSET 7, 38–46. https://​doi.​org/​10.​17148/​IARJS​ET.​2020.​7909 (2020).
	100.	 Bhagyashree, M. S. & Adappa, M. R. Modelling and simulation of an induction machine. IJIREEICE 4, 119–123. https://​doi.​
org/​10.​17148/​IJIRE​EICE/​NCAEE.​2016.​24 (2016).
Author contributions
Chafea Stiti, Mohamed Benrabah: Conceptualization, Methodology, Software, Visualization, Investigation, Writ-
ing—Original draft preparation. Abdelhadi Aouaichia, Adel Oubelaid: Data curation, Validation, Supervision, 
Resources, Writing—Review & Editing.  Mohit Bajaj, Milkias Berhanu Tuka, Kamel Kara: Project administration, 
Supervision, Resources, Writing—Review & Editing.
Competing interests 
The authors declare no competing interests.
Additional information
Correspondence and requests for materials should be addressed to M.B. or M.B.T.
Reprints and permissions information is available at www.nature.com/reprints.
Publisher’s note  Springer Nature remains neutral with regard to jurisdictional claims in published maps and 
institutional affiliations.
Open Access   This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 
4.0 International License, which permits any non-commercial use, sharing, distribution and reproduction in 
any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide 
a link to the Creative Commons licence, and indicate if you modified the licensed material. You do not have 
permission under this licence to share adapted material derived from this article or parts of it. The images or 
other third party material in this article are included in the article’s Creative Commons licence, unless indicated 
otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and 
your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain 
permission directly from the copyright holder. To view a copy of this licence, visit http://​creat​iveco​mmons.​org/​
licen​ses/​by-​nc-​nd/4.​0/.
© The Author(s) 2024
