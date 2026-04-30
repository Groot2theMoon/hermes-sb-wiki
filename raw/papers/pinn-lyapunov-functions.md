---
source_url: 
ingested: 2026-04-30
sha256: c8d1a9d0e79e6960760c1b829d55b9d49fea317dc9970302f626bbdf792fcff1
---

Automatica 175 (2025) 112193
Contents lists available at ScienceDirect
Automatica
journal homepage: www.elsevier.com/locate/automatica
Physics-informed neural network Lyapunov functions: PDE
characterization, learning, and verification✩
Jun Liu ∗, Yiming Meng, Maxwell Fitzsimmons, Ruikun Zhou
Department of Applied Mathematics, University of Waterloo, Waterloo, Ontario N2L 3G1, Canada
a r t i c l e
i n f o
Article history:
Received 18 December 2023
Received in revised form 3 June 2024
Accepted 10 January 2025
Available online 13 February 2025
Keywords:
Stability analysis
Nonlinear systems
Lyapunov functions
Neural networks
Formal verification
Zubov’s equation
Region of attraction
a b s t r a c t
We provide a systematic investigation of using physics-informed neural networks to compute Lya-
punov functions. We encode Lyapunov conditions as a partial differential equation (PDE) and use this
for training neural network Lyapunov functions. We analyze the analytical properties of the solutions
to the Lyapunov and Zubov PDEs. In particular, we show that employing the Zubov equation in
training neural Lyapunov functions can lead to verifiable approximate regions of attraction close to
the true domain of attraction. We also examine approximation errors and the convergence of neural
approximations to the unique solution of Zubov’s equation. We then provide sufficient conditions for
the learned neural Lyapunov functions that can be readily verified by satisfiability modulo theories
(SMT) solvers, enabling formal verification of both local stability analysis and region-of-attraction
estimates in the large. Through a number of nonlinear examples, ranging from low to high dimensions,
we demonstrate that the proposed framework can outperform traditional sum-of-squares (SOS)
Lyapunov functions obtained using semidefinite programming (SDP).
© 2025 The Authors. Published by Elsevier Ltd. This is an open access article under the CC BY-NC-ND
license (http://creativecommons.org/licenses/by-nc-nd/4.0/).
1. Introduction
Stability analysis of nonlinear dynamical systems has been
a focal point of research in control and dynamical systems. In
many applications, characterizing the domain of attraction for an
asymptotically stable equilibrium point is crucial. For example,
in power systems, understanding the domain of attraction is
essential for assessing whether the system can recover to a stable
equilibrium after experiencing a fault.
Since Lyapunov’s landmark paper over a century ago (Lyapunov,
1992), Lyapunov functions have become an instrumental tool
for nonlinear stability analysis and control design. Consequently,
extensive research has focused on Lyapunov functions. One key
challenge is their construction, which has been addressed through
both analytical (Haddad & Chellaboina, 2008; Sepulchre, Jankovic,
& Kokotovic, 2012) and computational methods (Giesl, 2007;
Giesl & Hafstein, 2015).
✩This work was partially supported by the Natural Sciences and Engineering
Research Council (NSERC) of Canada and the Canada Research Chairs (CRC)
program. The material in this paper was partially presented at The 62nd IEEE
Conference on Decision and Control (CDC), December 13–15, 2023, Marina Bay
Sands, Singapore. This paper was recommended for publication in revised form
by Associate Editor Mohamed Ali Belabbas under the direction of Editor Luca
Zaccarian.
∗Corresponding author.
E-mail addresses:
j.liu@uwaterloo.ca (J. Liu), yiming.meng@uwaterloo.ca
(Y. Meng), mfitzsimmons@uwaterloo.ca (M. Fitzsimmons),
ruikun.zhou@uwaterloo.ca (R. Zhou).
Among computational methods for Lyapunov functions, sum-
of-squares (SOS) techniques have garnered widespread atten-
tion (Jones & Peet, 2021; Packard, Topcu, Seiler, & Balas, 2010;
Papachristodoulou & Prajna, 2002, 2005; Tan & Packard, 2008;
Topcu, Packard, & Seiler, 2008). These methods facilitate sta-
bility analysis and provide estimates of the domain of attrac-
tion (Packard et al., 2010; Tan & Packard, 2008; Topcu et al.,
2008). Leveraging semidefinite programming (SDP), one can ex-
tend the region of attraction by using a specific ‘‘shape function’’
within the estimated region. However, selecting shape functions
in a principled manner, beyond standard norm (Packard et al.,
2010) or quadratic functions (Khodadadi, Samadi, & Khaloozadeh,
2014), remains elusive.
On the other hand, Zubov’s theorem (Zubov, 1964) charac-
terizes the domain of attraction through a partial differential
equation (PDE), unlike the commonly seen Lyapunov conditions
that manifest as partial differential inequalities. Using an equa-
tion allows for precise characterization of the domain of attrac-
tion. The concept of a maximal Lyapunov function (Vannelli &
Vidyasagar, 1985) is closely related to Zubov’s method. Vannelli
and Vidyasagar (1985) also provide a computational procedure
for constructing maximal Lyapunov functions using rational func-
tions.
Thanks to the recent surge of interest in neural networks and
machine learning, many authors have recently investigated the
use of neural networks for computing Lyapunov functions (see,
e.g., Abate, Ahmed, Giacobbe, and Peruffo (2020), Chang, Roohi,
and Gao (2019), Gaby, Zhang, and Ye (2022), Grüne (2021b),
https://doi.org/10.1016/j.automatica.2025.112193
0005-1098/© 2025 The Authors. Published by Elsevier Ltd. This is an open access article under the CC BY-NC-ND license (http://creativecommons.org/licenses/by-
nc-nd/4.0/).


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Kang, Sun, and Xu (2023), Zhou, Quartz, Sterck, and Liu (2022),
and Dawson, Gao, and Fan (2023) for a recent survey). In fact,
such efforts date back to as early as the 1990s (Long & Bayoumi,
1993; Prokhorov, 1994). Unlike SDP-based synthesis of SOS Lya-
punov functions, neural network Lyapunov functions obtained by
training are not guaranteed to be Lyapunov functions. Subsequent
verification is required, e.g., using satisfiability modulo theo-
ries (SMT) solvers (Ahmed, Peruffo, & Abate, 2020; Chang et al.,
2019). The use of SMT solvers for searching and refining Lya-
punov functions has been explored previously (Kapinski, Desh-
mukh, Sankaranarayanan, & Arechiga, 2014). Counterexample-
guided search of Lyapunov functions using SMT solvers is inves-
tigated in Ahmed et al. (2020) and the associated tool (Abate,
Ahmed, Edwards, Giacobbe, & Peruffo, 2021), which supports
both Z3 (Moura & Bjørner, 2008) and dReal (Gao, Kong, & Clarke,
2013) as verifiers. Neural Lyapunov functions with SMT verifica-
tion are explored in Zhou et al. (2022) for systems with unknown
dynamics. SMT verification is often time-consuming, especially
when seeking a maximal Lyapunov function (Liu, Meng, Fitzsim-
mons, & Zhou, 2023b) or dealing with high-dimensional systems.
Recent work has also focused on learning neural Lyapunov func-
tions and verifying them through optimization-based techniques,
e.g., Chen, Fazlyab, Morari, Pappas, and Preciado (2021a, 2021b),
Dai, Landry, Yang, Pavone, and Tedrake (2021) and Dai, Landry,
Pavone, and Tedrake (2020). Such techniques usually employ
(leaky) ReLU networks and use mixed integer linear/quadratic
programming (MILP/MIQP) for verification.
While recent work has demonstrated the promise of using
neural networks for computing Lyapunov functions, to the best
knowledge of the authors, none of the work has provided a
systematic investigation of using physics-informed neural net-
works (Lagaris, Likas, & Fotiadis, 1998; Raissi, Perdikaris, & Karni-
adakis, 2019) for solving the Zubov equation and using these net-
works to provide verified regions of attractions close to the true
domain of attraction. We highlight several papers particularly
related to our work. In Kang et al. (2023), a data-driven approach
is proposed to approximate solutions to Zubov’s equation. It is
demonstrated that neural networks can effectively approximate
the solutions. However, formal verification is not conducted, and
Zubov’s PDE is not encoded in the training of Lyapunov functions.
As demonstrated by our preliminary work (Liu et al., 2023b),
encoding Zubov’s equation allows us to improve the verifiable
regions of attraction. Furthermore, as we shall also demonstrate
in numerical examples of the current paper, formal verification
is indispensable, as in many examples, we are not able to verify
levels nearly as close to 1, which is predicted by the theoretical
result of Zubov. This is inevitable due to the approximation errors
and the compromise one has to ultimately make between using
low structural complexity that enables efficient verification and
high expressiveness that requires wider/deeper neural networks.
In contrast, the work in Grüne (2021a) uses an approach closer to
physics-informed neural networks (PINNs) (Lagaris et al., 1998;
Raissi et al., 2019) for approximating a solution to Zubov’s equa-
tion. However, the approach in Grüne (2021a) is local in nature,
and the Lyapunov conditions used to train the Lyapunov functions
are essentially conditions for local exponential stability. Further-
more, the author stated that using Lyapunov inequalities can lead
to better training results. However, in our setting, capturing the
domain of attraction unavoidably requires solving PDE instead
of partial differential inequalities. The work in Jones and Peet
(2021), even though focusing on SOS approaches for approxi-
mating Lyapunov functions, is closely related to our work. The
partial differential inequality constraint that the authors used to
optimize the polynomial Lyapunov functions takes the form of
Zubov’s PDEs, although not explicitly mentioned as such in the
paper. The earlier work in Camilli, Grüne, and Wirth (2001) has
been very informative in analyzing solution properties of Zubov’s
equation, especially with perturbations. While their analysis of
existence and uniqueness of viscosity solutions heavily relies on
prior work in Soravia (1999), our analysis is more direct and
relies on standard references on viscosity solutions for first-order
PDEs (Bardi, Dolcetta, et al., 1997; Crandall & Lions, 1983). We
particularly highlight our novel analysis of more general nonlin-
ear transformations between the Lyapunov and Zubov equations.
To the best of the authors’ knowledge, this work is the first to
demonstrate that neural network Lyapunov functions can provide
verifiable region-of-attraction estimates that are provably close to
the true domain of attraction through both theoretical analysis
and thorough numerical experiments.
A preliminary version of this paper was published as a confer-
ence paper in Liu et al. (2023b). The current paper significantly
expands the theoretical analysis and numerical experiments com-
pared to the preliminary work in Liu et al. (2023b). More specifi-
cally, we theoretically characterize Lyapunov functions as solu-
tions to PDEs and conduct a more systematic investigation of
solutions to Lyapunov and Zubov equations. In this process, the
consideration of viscosity solutions becomes essential, as smooth
solutions may not exist, as demonstrated by simple examples (see
Examples 1–3 in Section 3). Employing the concept of viscosity
solutions, we establish the uniqueness of solutions to Lyapunov
and Zubov equations and investigate approximation errors and
convergence of approximate solutions to the unique solution
of Zubov’s equation. None of these analyses of Lyapunov and
Zubov’s PDEs were present in the conference version (Liu et al.,
2023b). Moreover, we have significantly expanded the set of ex-
amples solved, demonstrating that the neural Zubov approach can
indeed surpass standard sum-of-squares (SOS) Lyapunov func-
tions in approximating the domain of attraction. Notably, we have
extended the range of examples from simple low-dimensional
polynomial systems in Liu et al. (2023b) to include both non-
polynomial systems and higher-dimensional systems not present
in Liu et al. (2023b).
Notation: Rn denotes the n-dimensional Euclidean space; |·| is
the Euclidean norm; R is the set of real numbers; C(Ω) and C1(Ω)
indicate the set of real-valued continuous and continuously dif-
ferentiable functions, respectively, with domain Ω; C(Ω, I) de-
notes the set of continuous functions with domain Ωand range I;
Dg denotes the gradient or Jacobian of a function g; the derivative
of a univariate scalar function V is sometimes denoted by V ′; the
derivative with respect to time of a time-dependent function x
is denoted by ̇x; the derivative of a multivariate scalar function
V along solutions of an ordinary differential equation is also
denoted by ̇V.
2. Problem formulation
Consider a continuous-time system
̇x = f (x),
(1)
where f : Rn →Rn is a locally Lipschitz function. The unique
solution to (1) from the initial condition x(0) = x0 is denoted by
φ(t, x0) for t ∈J, where J is the maximal interval of existence for
φ.
We assume that x = 0 is a locally asymptotically equilibrium
point of (1). The domain of attraction of the origin for (1) is defined
as
D :=
{
x ∈Rn : lim
t→∞|φ(t, x)| = 0
}
.
(2)
We know that D is an open and connected set (Bhatia & Szegö,
1967). We call any forward invariant subset of D a region of
attraction (ROA).
2


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Lyapunov functions can not only certify the asymptotic sta-
bility of an equilibrium point, but can also provide regions of
attraction. This is achieved using sub-level sets defined as Vc :=
{x ∈X : V(x) ≤c} , where c > 0 is a positive constant, and X
represents a domain of interest, typically the set within which
a Lyapunov function is defined. We are interested in computing
regions of attraction, as they not only provide a set of initial
conditions with guaranteed convergence to the equilibrium point,
but also ensure state constraints and safety through forward
invariance.
The goal of this paper is to provide a systematic investiga-
tion of computing Lyapunov functions using physics-informed
neural networks. We review the PDE characterization of the do-
main of attraction through the work of Lyapunov (Lyapunov,
1992) and Zubov (Zubov, 1964), as well as using the notion of
viscosity solutions (Bardi et al., 1997; Crandall & Lions, 1983)
for Hamilton–Jacobi equations to formalize the existence and
uniqueness of solutions. We then describe algorithms for learn-
ing neural Lyapunov functions through physics-informed neu-
ral networks for solving Lyapunov and Zubov PDEs. Through a
list of examples, we demonstrate that physics-informed neu-
ral network Lyapunov functions can outperform sum-of-squares
(SOS) Lyapunov functions in terms of tighter region-of-attraction
estimates.
3. PDE characterization of Lyapunov functions
3.1. Lyapunov equation
Definition 1.
Let Ω⊂Rn be a set containing the origin. A
function V : Ω→R is said to be positive definite on Ω(with
respect to the origin) if V(0) = 0 and V(x) > 0 for all x ∈Ω\ {0}.
We say V is negative definite on Ωif −V is positive definite on
Ω.
In a nutshell, a Lyapunov function for (1) is a positive definite
function whose derivative along trajectories of (1) is negative
definite.
We refer to the following PDE as a Lyapunov equation:
DV · f = −ω ,
x ∈Ω,
(3)
where Ωis an open set containing the origin, f is the right-hand
side of (1), and ω is a positive definite function. If we can find a
positive definite solution V of (3), then V is a Lyapunov function
for (1).
The Lyapunov Eq. (3) is a linear PDE. Its solvability is in-
timately tied with the solution properties of the ODE (1). In
fact, (1) is known as the characteristic ODE for (3). Textbook
results on the method of characteristics for first-order PDEs state
that a local solution to (3) exists, provided that compatible and
non-characteristic1 boundary conditions are given (Evans, 2010,
Chapter 3).
The scenario here is somewhat different. While we assume
that the origin is an asymptotically stable equilibrium point of
(1), we do not wish to impose non-characteristic boundary condi-
tions. Rather, we prefer to impose the trivial boundary condition
V(0) =
0. Furthermore, we are interested not only in local
solutions but also in the solvability of (3) on a given domain
containing the origin. To this end, we formulate the following
technical result.
We consider two technical conditions that are sufficient for
solvability of (3).
1 Intuitively, this means the boundary is not tangent to trajectories of (1).
Assumption 1. The origin is an asymptotically stable equilibrium
point for (1) and f is locally Lipschitz. The function ω : Rn →R
is continuous and positive definite. Define
V(x) =
∫∞
0
ω(φ(t, x))dt,
x ∈Rn,
(4)
where, if the integral diverges, we let V(x) = ∞. The following
items hold true:
(i) For any δ > 0, there exists c > 0 such that ω(x) > c for all
|x| > δ.
(ii) There exists some ρ > 0 such that the integral V(x) defined
by (4) converges for all x such that |x| < ρ.
(iii) For any ε > 0, there exists δ > 0 such that |x| < δ implies
V(x) < ε.
Intuitively, since ω is assumed to be positive definite and
continuous, condition (i) is equivalent to that ω is non-vanishing
at infinity, i.e., lim inf|x|→∞ω(x) > 0. Note that V(0) = 0 and
V is nonnegative because ω is positive definite. Condition (iii)
essentially states that V is continuous at 0, while (ii) requires V
to be finite in a neighborhood of the origin. Clearly, (iii) implies
(ii).
Remark 1. If ω is Lipschitz around the origin and the origin is
an exponentially stable equilibrium point for (1), then conditions
(ii) and (iii) of Assumption 1 hold. One common choice is ω(x) =
xT Qx for some positive definite matrix Q . When f (x) = Ax and
ω(x) = xT Qx, a solution of (3) is given by V(x) = xT Px, where P
satisfies the celebrated Lyapunov equation PA + AT P = −Q .
We first examine properties of V defined by (4).
Proposition 1.
Let Assumption 1 hold. The function V : Rn →
R ∪{∞} defined by (4) satisfies the following:
(1) V(x) < ∞if and only if x ∈D;
(2) V(x) → ∞as x →y for some y ∈∂D;
(3) V is positive definite on D;
(4) V is continuous on D and its right-hand derivative along the
solution of (1) satisfies
̇V(x) := lim
t→0+
V(φ(t, x)) −V(x)
t
= −ω(x)
(5)
for all x ∈D.
A proof of Proposition 1 can be found in Appendix A. While
the Lyapunov condition (5) is sufficient for stability analysis, it
does not provide a PDE characterization of Lyapunov functions,
nor does it reveal regularity properties of Lyapunov functions as
solutions to (3).
Next, we further examine in what sense V, defined by (4),
satisfies the Lyapunov Eq. (3). For simplicity of analysis and to
ensure greater regularity in the solutions to (3), we also consider
the following assumption.
Assumption 2.
The origin is exponentially stable for (1) and f is
continuously differentiable.
Proposition 2.
Let Ω⊂D be any open set containing the origin.
Let Assumption 1 hold. The following statements are true:
(1) V defined by (4) is the unique continuous solution to (3) on
Ωin the viscosity sense satisfying V(0) = 0.
(2) If ω is locally Lipschitz and Assumption 2 holds, then V defined
by (4) is locally Lipschitz and satisfies (3) almost everywhere
on Ω.
3


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
(3) If ω ∈C1(Rn) and Assumption 2 holds, then V defined by (4)
is the unique continuously differentiable solution to (3) on Ω
with V(0) = 0.
A proof of Proposition 2 can be found in Appendix B. Clearly,
Proposition 2 holds with Ω= D. We have formulated the result
as is because it is relevant when solving (3) on a given set Ω⊂D
without knowing D. We provide a few examples to illustrate
Proposition 2.
Example 1. Consider a scalar system ̇x = −x3. Define ω(x) = x2.
Then V defined by (4) is V(x) =
∫∞
0
x2
2tx2+1dt, which does not
converge for any x ̸ = 0. This is because Assumption 1 does not
hold.
Example 2.
Consider again the scalar system ̇x = −x3. Define
ω(x) = |x|
5
2 . Then V defined by (4) is V(x) =
∫∞
0
|x|
5
2
(2tx2+1)
5
4
dt =
2√|x|, which is not locally Lipschitz at x = 0. Note that, while
Assumption 1 holds and ω is locally Lipschitz, Assumption 2 does
not hold. Hence, Proposition 2(2) is not applicable. When x ̸ = 0,
V is differentiable and (3) holds in classical sense. At x = 0, we
have D−V(0) = R (see Appendix B for definition). For any p ∈R
and x = 0, we have −ω(0) −p · f (0) = 0, which verifies (3) is
satisfied at x = 0 in viscosity sense.
Example 3. Consider the scalar system ̇x = −x. Let ω(x) = |x|.
Then V defined by (4) is V(x) =
∫∞
0
⏐⏐e−tx
⏐⏐dt = |x|. Hence, both
V and ω are only locally Lipschitz (and not differentiable) at 0.
Furthermore, if ω2(x) = |x|
3
2 , then V2(x) =
∫∞
0
⏐⏐e−tx
⏐⏐
3
2 dt =
2
3 |x|
3
2 . Similarly, both V2 and ω2 are continuously differentiable
(and not twice continuously differentiable) at 0. This is consistent
with items (2) and (3) of Proposition 2.
Remark 2.
Item (1) of Proposition 2 can be seen as a special
case of the results stated in Bardi et al. (1997) and Camilli et al.
(2001). Here, we provide a more direct proof. Local Lipschitz
continuity of V (in a more general setting with perturbation)
has been established in Camilli et al. (2001), but under more
restrictive conditions. Item (3) is perhaps not surprising, yet we
are not aware of a similar result being stated in the literature.
3.2. Zubov equation
While Proposition 2 characterizes the Lyapunov function V
within the domain of attraction using Lyapunov’s PDE (B.1), due
to Proposition 1(2), any finite sublevel set of V does not yield the
domain of attraction. Zubov’s theorem is a well-known result that
states the sublevel-1 set of a certain Lyapunov function is equal
to the domain of attraction. We state Zubov’s theorem below.
Theorem 1 (Zubov’s Theorem (Zubov, 1964)). Let Ω⊂Rn be an
open set containing the origin. Then Ω= D if and only if there
exists two continuous functions W : Ω→R and Ψ : Ω→R such
that the following conditions hold:
(1) 0 < W(x) < 1 for all x ∈Ω\ {0} and W(0) = 0;
(2) Ψ is positive definite on Ωwith respect to the origin;
(3) for any sufficiently small c3 > 0, there exist two positive real
numbers c1 and c2 such that |x| ≥c3 implies W(x) > c1 and
Ψ (x) > c2;
(4) W(x) →1 as x →y for any y ∈∂Ω;
(5) W and Ψ satisfy
̇W(x) = −Ψ (x)(1 −W(x)),
(6)
where ̇W is the right-hand derivative of W along solutions of
(1) as defined in (5).
We first highlight a connection between V defined by (4), with
properties listed in Proposition 1, and the function W in Zubov’s
theorem. Let β : R →R satisfy
̇β = (1 −β)ψ(β), β(0) = 0,
(7)
where ψ is a locally Lipschitz function satisfying ψ(s) >
0
for s ≥0. Clearly, any function satisfying (7) is continuously
differentiable, strictly increasing on [0, ∞), and satisfies β(0) = 0
and β(s) →1 as s → ∞.
With V defined by (4), let
W(x) =
{β(V(x)), if V(x) < ∞,
1,
otherwise,
(8)
where β : [0, ∞) →R satisfies (7).
We can verify the following properties for W, a proof of which
can be found in Liu et al. (2023b).
Proposition 3.
The function W :
Rn →R defined by (8) is
continuous and satisfies the conditions in Theorem 1 on D with
Ψ (x) = ψ(β(V(x)))ω(x).
Motivated by this, we consider a slightly generalized Zubov
equation as follows
DW · f = −ω ψ(W)(1 −W),
(9)
for x ∈Ω, where Ω⊂Rn is an open set on which we are
interested in solving (9).
Next, we characterize solutions of Zubov’s Eq. (9) for the case
where Ωis bounded and a boundary condition on ∂Ωis specified
as follows
W = g,
(10)
where g is taken to be consistent with (8), i.e., g(x) = 1 for
x ∈∂Ω\ D and g(x) = β(V(x)) for x ∈∂Ω∩D. We put forward
a technical assumption on ψ.
Assumption 3.
There exists a nonempty interval I such that the
function G : I →R defined by s ↦ →(1 −s)ψ(s) is monotonically
decreasing on I.
Assumption 3 on ψ stipulates a nonempty interval I, which
depends on ψ and serves as the range of the solution W to (9),
as required by the following result.
Theorem 2.
Let Assumptions 1 and 3 hold. Let Ω⊂Rn be a
bounded open set containing the origin. Suppose that ω is locally
Lipschitz. The following statements are true:
(1) W defined by (8) is the unique viscosity solution to (9) in
C( ¯Ω, I) satisfying W(0) = 0 and the boundary condition (10)
on ∂Ω.
(2) If Assumption 2 holds, then W defined by (8) is locally Lip-
schitz on Rn \ ∂D and satisfies (9) almost everywhere on
Rn \ ∂D.
(3) If ω ∈C1(Rn) and Assumption 2 holds, then W defined by (8)
is in C1(Rn \ ∂D).
A proof of Theorem 2 can be found in Appendix C. An inter-
esting byproduct of the analysis in the proof of Theorem 2 is
the following error estimate for a neural (or other) approximate
solution to the PDE (9). To derive the result, we refer to the
following technical condition on an approximate solution v :
4


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
¯Ω→I. Let G and I be from Assumption 3. For some ε > 0 and
δ > 0, we have
G(v(x)) + [−
ε
minx∈¯Ω\Bδ ω(x),
ε
minx∈¯Ω\Bδ ω(x)] ⊂G(I)
(11)
for all x ∈Ω\ ¯Bδ. We shall see that, for any fixed δ > 0,
condition (11) holds for ε > 0 sufficiently small, provided that
a mild condition holds for v (see Remark 3).
Proposition 4.
Suppose that the assumptions of Theorem 2 hold.
Fix any δ > 0 such that Bδ ⊂Ω∩D. Let W be the unique
viscosity solution to (9) with boundary condition (10). The following
statements hold:
(1) (error estimate) For any ε > 0, let v be an ε-approximate
viscosity solution (see its definition in Appendix D) to (9) on
Ω\ ¯Bδ with boundary error |W(x) −v(x)| ≤εb on ∂Ω∪∂¯Bδ.
Assume that v and ε satisfy condition (11). Then there exists
a constant C(ε , εb), satisfying C(ε , εb) →0 as ε →0 and
εb →0, such that |W(x) −v(x)| ≤C(ε , εb) for all x ∈¯Ω\Bδ.
(2) (convergence) Furthermore, suppose that {vn} is a sequence
of εn-approximate viscosity solutions to (9) on Ωwith a
uniform Lipschitz constant2 on ¯Ω, where εn ↓0, and with
boundary condition vn(0) →0 and vn(x) →W(x) uniformly
on ∂Ωas n → ∞. Assume that, for each δ > 0, there exists
some N > 0 such that (11) holds for all (vn, εn) with n > N.
Then {vn} converges to W uniformly on ¯Ω.
Remark 3.
Two special cases of ψ(s) are given by (i) ψ(s) = α or
(ii) ψ(s) = α(1 + s) for some constant α > 0, which correspond
to β(s) = 1 −exp(−αs) and β(s) = tanh(αs), respectively. Such
transforms are used in, e.g., Camilli et al. (2001), Kang et al. (2023)
and Meng, Zhou, and Liu (2023). For case (i), Assumption 3 holds
with I = R. It is clear that in this case G(I) = R and (11) trivially
holds. For case (ii), we can take I = [0, ∞). Then G(I) = (−∞, α].
Condition (11) for v and ε in Proposition 4 holds if there exists
some c > 0 such that v(x) > c, whenever |x| > δ, and ε > 0
sufficiently small such that G(c) +
ε
minx∈¯Ω\Bδ ω(x) ≤α. It further
follows that (11) holds for (vn, εn) in Proposition 4, if for each
δ > 0, there exists c > 0 and N > 0 such that vn(x) > c for all
|x| > δ and all n > N.
Example 4.
Consider the scalar system ̇x = −x + x3. It has
three equilibrium points at {0, ±1}. The origin is exponentially
stable with domain of attraction D = (−1, 1). Consider V(x) =
∫∞
0 |φ(t, x)|2 dt. By Proposition 1, we have ̇V(x) = V ′(x)(−x +
x3) = −x2. For x ∈(0, 1), assuming differentiability of V, we
have V ′(x) =
x
1−x2 . Integrating this with the condition V(0) = 0
gives V(x) = −1
2 ln(1 −x2). Taking W(x) = 1 −exp(−αV(x))
(corresponding to ψ(x) = α > 0 as indicated in Remark 3), we
obtain W(x) = 1−(1−x2)
α
2 . One can easily verify that W satisfies
conditions in Zubov’s theorem. It can also be easily verified that
W can fail to be differentiable at x ∈{±1} = ∂D, or even locally
Lipschitz for α < 2.
To conclude this section, we highlight the crucial connections
of the theoretical analysis presented here with the training and
verification of Lyapunov functions to be discussed in Sections 4
and 5. The main result (Theorem 2) shows that solving Zubov’s
PDE (9) with boundary condition (10) can lead to a Lyapunov
function W, whose sublevel-1 set gives the true domain of attrac-
tion D = {x ∈Rn : W(x) < 1}. This analysis fundamentally relies
on the analysis of solutions to Lyapunov’s PDE (3) (Proposition 2).
2 The same statement holds if they share a uniform modulus of continuity.
Building upon these theoretical results, subsequent sections will
focus on computing approximate solutions by solving Zubov’s
PDE (9) using neural networks and verifying them with SMT
solvers. To this end, Proposition 4 also plays an instrumental
role in ensuring that solving Zubov’s PDE (9) with small resid-
ual errors (ε-approximate solutions) indeed leads to accurate
approximations of the true solution.
4. Physics-informed neural Lyapunov function
A physics-informed neural network (PINN) (Lagaris et al.,
1998; Raissi et al., 2019) is essentially a neural network that
solves a PDE. In this section, we present the main algorithm for
solving Lyapunov and Zubov equations. To describe the algorithm,
consider a first-order PDE of the form
F(x, W, DW) = 0,
x ∈Ω,
(12)
subject to the boundary condition W = g on ∂Ω.
Consider a general multi-layer feedforward neural network
function WN(x; θ) defined inductively as follows. Let the output
of the first layer (input layer) be a(0) = x, where x is the input
vector. For each subsequent layer l (where 1 ≤l ≤L), the output
is defined inductively as a(l) = σ (l)(H(l)a(l−1) +b(l)), where H(l) and
b(l) are the weight matrix and bias vector for layer l, and σ (l) is the
activation function for layer l. The final output of the network is
y = a(L). The parameter vector θ consists of all weights H(l) and
biases b(l).
We train WN(x; θ) as a PINN Lyapunov function by optimiz-
ing θ with respect to a specifically designed loss function that
encodes the PDE (12), along with the correct boundary condition
and additional data loss. We describe the algorithm as follows.
(1) Choose a set of interior collocation points {xi}Nc
i=1 ⊂Ω.
These are points at which the test solution WN(x; β) and
its derivative will be evaluated to obtain the mean-square
residual error
1
Nc
∑Nc
i=1 F(xi, WN(xi; β), DWN(xi; β))2 for (12)
at these points.
(2) Choose a set of boundary points {yi}
Nb
i=1 ⊂∂Ωat which the
mean-square boundary error
1
Nb
∑Nb
i=1(WN(yi; β) −g(yi))2
can be evaluated.
(3) In some cases, we may also obtain a set of data points
{(zi, ˆW(zi))}
Nd
i=1, where {zi}
Nd
i=1 ⊂Ωand { ˆW(zi)}
Nd
i=1 are ap-
proximations to the ground truth values of W at {zi}
Nd
i=1. For
examples, this may correspond to evaluation of V defined
in (4) or W defined in (8) through numerical integra-
tion of (1). The mean-square data loss can be defined as
1
Nd
∑Nd
i=1(WN(zi; β) −ˆW(zi))2.
The loss function for optimizing θ is given by
Loss(θ) = 1
Nc
Nc
∑
i=1
F(xi, WN(xi; θ), DWN(xi; θ))2
+ λb
1
Nb
Nb
∑
i=1
(WN(yi; θ) −g(yi))2,
+ λd
1
Nd
Nd
∑
i=1
(WN(zi; θ) −ˆW(zi))2,
(13)
where λb > 0 and λd > 0 are weight parameters. Training of θ
can be achieved with standard gradient descent.
Remark 4. In formulating the PDE (12), Lyapunov equation has
a single boundary condition V(0) = 0, whereas the boundary
condition for Zubov equation consists of both W(0) = 0 and
W(y) = 1 for y ̸ ∈D, if D ⊂Ω. For examples where D is
5


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
not a subset of Ω, the boundary condition may also consist of
W(y) = β(V(y)) for y ∈D ∩∂Ω; see comment after (10). In
Section 6, the Van der Pol equation (Example 6) belongs to the
former case, and the two-machine power system (Example 7)
belongs to the latter case.
Remark 5.
A key feature of the proposed approach, compared
to state-of-the-art sum-of-squares methods for estimating re-
gions of attraction, is that Loss(θ) is a non-convex function of θ.
While solving non-convex optimization problems is more chal-
lenging—since obtaining a global minimum is not guaranteed
and convergence rates may be slower—embracing non-convex
optimization allows us to utilize the representational power of
deeper neural networks. This is especially advantageous when
computing regions closer to the true domain of attraction, as
demonstrated by the numerical examples in Section 6.
5. Formal verification
Neural network functions, as computed by solving the Lya-
punov Eq. (3) and the Zubov Eq. (9) using algorithms outlined
in Section 4, offer no formal stability guarantees. This is because
neural approximations come with numerical errors, and training
deep neural networks usually does not guarantee convergence
to a global minimum. On the other hand, Lyapunov functions
are sought precisely because they provide formal guarantees of
stability, especially in safety-critical applications. For this reason,
formal verification of neural Lyapunov functions is indispensable
if formal stability guarantees and rigorous regions of attraction
are required. We outline such verification procedures in this
section.
5.1. Verification of local stability
In this section, we assume that Assumption 2 holds, i.e., f is
continuously differentiable and x = 0 is an exponentially stable
equilibrium point of (1). Rewrite (1) as
̇x = Ax + g(x),
(14)
where g(x) = f (x) −Ax satisfies limx→0
∥g(x)∥
∥x∥
= 0. Given any
symmetric positive definite matrix Q ∈Rn×n, let P be the unique
solution to the Lyapunov equation
PA + AT P = −Q.
(15)
Let VP(x) = xT Px. Then
̇VP(x) = −xT Qx + 2xT Pg(x)
≤ −λmin(Q ) ∥x∥2 + 2xT Pg(x)
= −ε ∥x∥2 + (2xT Pg(x) −r ∥x∥2),
where we set r = λmin(Q ) −ε > 0 for some sufficiently small
ε > 0 and λmin(Q ) is the minimum eigenvalue of Q . If we can
determine a constant c > 0 such that
VP(x) ≤c H⇒2xT Pg(x) ≤r ∥x∥2 ,
(16)
then we have verified
VP(x) ≤c H⇒̇VP(x) ≤ −ε ∥x∥2 ,
(17)
which verifies exponential stability of the origin, and a region of
attraction {x ∈Rn : VP(x) ≤c}.
While all this aligns with standard quadratic Lyapunov anal-
ysis, we note a subtle issue in the verification of (16) using SMT
solvers. For example, although Z3 (Moura & Bjørner, 2008) offers
exact verification, unlike dReal’s numerical verification (Gao et al.,
2013), it currently lacks support for functions beyond polyno-
mials. For non-polynomial vector fields, we found dReal to be
the state-of-the-art verifier. However, due to the conservative
use of interval analysis in dReal to account for numerical errors,
verification of inequalities such as 2xT Pg(x) ≤r ∥x∥2 may return
a counterexample close to the origin. To overcome this issue,
we consider a higher-order approximation of Pg(x). By the mean
value theorem, we have
Pg(x) = Pg(x) −Pg(0) =
∫1
0
P · Dg(tx)dt · x,
where Dg is the Jacobian of g given by Dg = Df −A, which implies
2xT Pg(x) ≤2 sup
0≤t≤1
∥P · Dg(tx)∥ ∥x∥2 .
As a result, to verify (16), we just need to verify
VP(x) ≤c H⇒2 sup
0≤t≤1
∥P · Dg(tx)∥≤r.
(18)
By convexity of the set {x ∈Rn : VP(x) ≤c}, (18) is equivalent to
VP(x) ≤c H⇒2 ∥P · Dg(x)∥≤r.
(19)
Since Dg(0) = 0 and Dg is continuous, one can always choose c >
0 sufficiently small such that (19) can be verified. Furthermore, in
rare situations, if 2 ∥P · Dg(x)∥≤r can be verified for all x ∈Rn,
then global exponential stability of the origin is proved for (1).
Remark 6.
From (19), one can further use easily computable
norms, such as the Frobenius norm, to over-approximate the
matrix 2-norm ∥P · Dg(x)∥.
Example 5. Consider an inverted pendulum
̇x1 = x2,
̇x2 = sin(x1) −x2 −(k1x1 + k2x2),
(20)
where the linear gains are given by k1 = 4.4142, k2 = 2.3163.
In the literature, there have been numerous references to this
example as a benchmark for comparing techniques for stabiliza-
tion with provable ROA estimates. Interestingly, with Q = I and
ϵ = 10−4, which leads to r = 0.9999, it turns out that one can
verify 2∥P · Dg(x)∥ ≤r with dReal (Gao et al., 2013) within 1
millisecond, which confirms global stability of the origin for (20).
Remark 7.
While stability analysis using quadratic Lyapunov
functions is certainly standard, we highlight that our approach to
verifying (16) via the mean value theorem and (19) successfully
overcomes the limitations in current approaches that exclude
verification around a small neighborhood of the origin to avoid
the numerical conservativeness of SMT solvers (Chang et al.,
2019; Zhou et al., 2022).
5.2. Verification of regions of attraction
We outline how local stability analysis via linearization and
reachability analysis via a Lyapunov function can be combined to
provide a region-of-attraction estimate that is close to the domain
of attraction. Let VP be a quadratic Lyapunov function as defined
in Section 5.1 and WN be a neural Lyapunov function learned
using algorithms outlined in Section 4. Suppose that we have
verified a local region of attraction {x ∈Rn : VP(x) ≤c} for some
c > 0. Let X ⊂Rn denote a compact set on which verification
takes place. We can verify the following inequalities using SMT
solvers:
(c1 ≤WN(x) ≤c2) ∧(x ∈X) H⇒̇WN(x) ≤ −ε ,
(21)
(WN(x) ≤c1) ∧(x ∈X) H⇒VP(x) ≤c,
(22)
where ε > 0, c2 > c1 > 0.
6


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Proposition 5.
If (21) and (22) hold and the set Wc2
=
{x ∈X : WN(x) ≤c2} does not intersect with the boundary of X,
then Wc2 is a region of attraction for (1).
Proof.
A solution starting from Wc2 remains in Wc2 as long as
the solution do not leave X. However, to leave X it has to cross
the boundary of Wc2 first. This is impossible because of (21).
Within Wc2, solutions converge to {
x ∈Rn : xT Px ≤c}
in finite
time, which is a verified region of attraction.
■
If WN is obtained by solving the Zubov equation (9) using
algorithms proposed in Section 4, then the set Wc2 can provide
a region of attraction close to the true domain of attraction.
We shall demonstrate this in the next section using numerical
examples, where it is shown that the neural Zubov approach
outperforms sum-of-squares Lyapunov functions in this regard.
6. Numerical examples
In this section, we present numerical examples demonstrat-
ing our ability to effectively compute neural Lyapunov functions
by solving Lyapunov and Zubov equations. We show that the
obtained neural Lyapunov functions can be formally verified,
yielding certified regions of attraction. Thanks to the theoretical
guarantees of Zubov’s equation and the expressiveness of neu-
ral networks, these regions of attraction can outperform those
derived from sum-of-squares Lyapunov functions obtained using
semidefinite programming.
Implementation details: Numerical experiments were conducted
on a 2020 MacBook Pro with a 2 GHz Quad-Core Intel Core i5,
without any GPU. For training, we randomly selected 300,000 col-
location points in the domain and trained for 20 epochs using the
Adam optimizer with PyTorch. The sizes of the neural networks
are as reported in Tables 2 and 3. We used the hyperbolic tangent
as the activation function. Verification was done with the SMT
solver dReal (Gao et al., 2013). All examples are solved using the
tool LyZNet (Liu, Meng, Fitzsimmons, & Zhou, 2024b). The code
is available at https://git.uwaterloo.ca/hybrid-systems-lab/lyznet.
Since formal verification is conducted after training, we choose
neural network sizes that can be effectively verified by the SMT
solver dReal (Gao et al., 2013). Our numerical studies indicate that
a network with two hidden layers of up to 30 neurons each, or
three hidden layers of up to 10 neurons, provides a good balance
between expressiveness and effective verifiability. The numerical
examples below, unless otherwise noted, all use neural networks
with two hidden layers of 30 neurons each. Table 1 summarizes
the computational times for training and verification. Note that
computational time largely depends on computer hardware. The
computational times provided in Table 1 serve as a reference
point.
Example 6 (Van Der Pol Equation). Consider the reversed Van der
Pol equation given by
̇x1 = −x2,
̇x2 = x1 −µ(1 −x2
1)x2,
(23)
where µ > 0 is a stiffness parameter.
For µ = 1.0 and X = [−2.5, 2.5] × [−3.5, 3.5], we train
a neural network to solve Zubov’s PDE (9) on X. Fig. 1 depicts
the largest verifiable sublevel set, along with the learned neural
Lyapunov function. It can be seen that the verified ROA is quite
comparable and slightly better than that provided by an SOS
Lyapunov function with a polynomial degree of six, obtained
using a standard ‘‘interior expanding’’ algorithm (Packard et al.,
2010). As the stiffness of the equation increases, we observe fur-
ther improved advantages of neural Lyapunov approach over SOS
Lyapunov functions. With µ = 3.0 and domain X = [−3.0, 3.0] ×
[−6.0, 6.0], the comparison is shown in Fig. 2.
Fig. 1. Verified neural Lyapunov function for Van der Pol equation with µ = 1.0
(Example 6). Dashed red: quadratic Lyapunov function; dot-dashed green: SOS
Lyapunov; solid blue: neural Lyapunov.
Fig. 2. Verified neural Lyapunov function for Van der Pol equation with µ = 3.0
(Example 6). Dashed red: quadratic Lyapunov function; dot-dashed green: SOS
Lyapunov; solid blue: neural Lyapunov. The learned neural Lyapunov function
outperforms a sixth degree SOS Lyapunov function.
Table 1
Training and verification times for numerical examples.
Model
Train (s)
Verify (s)
Van der Pol (µ = 1)
494
973
Van der Pol (µ = 3)
502
442
Two-machine power
473
3375
10-d system
92
356
20-d networked Van der Pol
27,342
46,611
Table 2
Parameters and verification results for Van der Pol equation (Example 6).
µ
Layer
Width
c2
Volume
SOS volume
1.0
2
30
0.898
95.64%
94.17%
3.0
2
30
0.640
85.12%
70.88%
Example 7
(Two-Machine Power System).Consider the two-
machine power system (Vannelli & Vidyasagar, 1985) modeled
by
̇x1 = x2,
̇x2 = −0.5x2 −(sin(x1 + δ) −sin(δ)),
(24)
where δ = π
3 . Note that the system has an unstable equilibrium
point at (π /3, 0).
Fig. 3 shows that a neural network with two hidden layers and
30 neurons in each layer provides a region-of-attraction estimate
significantly better than that from a sixth-degree polynomial SOS
Lyapunov function, computed with a Taylor expansion of the sys-
tem model. The example shows that neural Lyapunov functions
perform better than SOS Lyapunov functions when the nonlin-
earity is non-polynomial. We also compared with the rational
Lyapunov function presented in Vannelli and Vidyasagar (1985),
but the ROA estimate is worse than that from the SOS Lyapunov
7


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Table 3
Parameters and verification results for a two-machine power system
(Example 7).
Layer
Width
c2
Volume
SOS volume
2
30
0.742
82.52%
18.53%
function, and we were not able to formally verify the sublevel
set of the rational Lyapunov function reported in Vannelli and
Vidyasagar (1985) with dReal (Gao et al., 2013). Improving the
degree of polynomial in the SOS approach does not seem to
improve the result either.
Example 8 (10-Dimensional System). Consider the 10-dimensional
nonlinear system from Grüne (2021a):
̇x1 = −x1 + 0.5x2 −0.1x2
9,
̇x2 = −0.5x1 −x2,
̇x3 = −x3 + 0.5x4 −0.1x2
1,
̇x4 = −0.5x3 −x4,
̇x5 = −x5 + 0.5x6 + 0.1x2
7,
̇x6 = −0.5x5 −x6,
̇x7 = −x7 + 0.5x8,
̇x8 = −0.5x7 −x8,
̇x9 = −x9 + 0.5x10,
̇x10 = −0.5x9 −x10 + 0.1x2
2.
The example was used by the authors of Grüne (2021a) and
Gaby et al. (2022) to illustrate the training of neural network
Lyapunov functions for stability analysis, where the trained Lya-
punov functions were not verified. We remark that global asymp-
totic stability of this system can be easily established using an
input-to-state stability argument. Therefore, when training neural
Lyapunov functions for this example, one is essentially computing
a local Lyapunov function within the domain of attraction.
Using the verification method from Section 5, we confirmed
that a quadratic Lyapunov function certifies an optimal ellipsoidal
region of attraction. Therefore, this example offers limited insight
for ROA comparison or showcasing the capabilities of neural
Lyapunov functions. We replicated the training of a local neural
Lyapunov function as described in Gaby et al. (2022) and Grüne
(2021a), employing a differential inequality loss and a simple
one-layer network. The training concluded within two epochs,
achieving a maximum loss below 10−6 and an average loss under
10−7, as depicted in Fig. 4. Due to the system’s high dimensional-
ity, we restricted the neural network’s complexity to enable effi-
cient verification. The verified ROA is smaller than that achieved
with the quadratic Lyapunov function, which is optimal for this
case. Training a local Lyapunov function seems straightforward,
but capturing the full domain of attraction presents challenges,
especially in high-dimensional systems. In the next example, we
will demonstrate how these techniques can be applied to such
systems.
Example 9 (Networked Van Der Pol Oscillators). Inspired by Kundu
and Anghel (2015), we consider a network of reversed Van der Pol
equations of the form
̇xi1 = −xi2,
̇xi2 = xi1 −µi(1 −x2
i1)xi2 +
∑
j̸ =i
µijxi1xj2,
where µi is a parameter ranging from (0.5, 2.5) and µij represents
the interconnection strength. We choose the number of total
subsystems l = 10. The network topology is depicted in Fig. 5.
Fig. 3. Verified neural Lyapunov function for a two-machine power system
(Example 7). Dashed red: quadratic Lyapunov function; dot-dashed green: SOS
Lyapunov; solid blue: neural Lyapunov. The learned neural Lyapunov function
significantly outperforms a sixth degree SOS Lyapunov function.
Fig. 4. Verified neural Lyapunov function for a 10-dimensional system
(Example 8). Dashed red: quadratic Lyapunov function; solid blue: neural
Lyapunov trained using differential inequality loss as in Grüne (2021a) and Gaby
et al. (2022). The red surface depicts the derivative of the learned Lyapunov
function along the vector field the system. Plots are projected to the (x1, x2)-
plane.
Fig. 5. The network topology for the Van der Pol network.
The parameters µi are randomly generated and take the following
values for i = 1, . . . , 10:
[1.25, 2.4, 1.96, 1.7, 0.81, 0.81, 0.62, 2.23, 1.7, 1.92].
We set that µij ∈(−0.1, 0.1) and the number of nonzero entries
in {
µij
}
for each i is fewer than 3.
The total dimension of the interconnected system is there-
fore 20, which is beyond the capability of current SMT or SDP-
based synthesis of Lyapunov functions if a monolithic approach
is taken. We trained neural networks of three hidden layers
with 10 neurons each for the individual subsystems using the
approach proposed in Section 4. We then compositionally verified
regions of attraction using the approach detailed in Section 5 (see
also Liu, Meng, Fitzsimmons, and Zhou (2024a)), leveraging the
compositional structure of the networked system. The verified
regions of attraction for subsystems 1 and 2 are shown in Fig. 6. It
8


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Fig. 6. Verified regions of attraction for networked Van der Pol oscillators. We
show the results for subsystems 1 and 2 of a 20-dimensional interconnected
system. The thick solid lines represent the regions of attraction for the in-
terconnected system, while the thin dashed lines indicate those for individual
subsystems.
is clear that the neural network Lyapunov functions outperform
SOS Lyapunov functions.
Remark 8. Our comparison focuses only on SOS Lyapunov func-
tions because existing approaches using neural Lyapunov func-
tions do not provide approximations of the entire domain of
attraction. This limitation exists as training, using the Lyapunov
equation (or inequality), must be conducted on a chosen subset
of the domain of attraction (Chang et al., 2019; Gaby et al., 2022;
Grüne, 2021a) and is inherently local. To the best knowledge
of the authors, our work is the first to offer verified regions of
attraction that closely approximate the true domain of attraction
using neural Lyapunov functions. This is achieved by encoding the
Zubov Eq. (9) with a PINN approach and allowing training to take
place in a region containing the domain of attraction.
7. Conclusions
We presented a framework for learning neural Lyapunov func-
tions using physics-informed neural networks and verifying them
with satisfiability modulo theories solvers. By solving Zubov’s PDE
with neural networks, we demonstrated that the verified ROA can
approach the boundary of the domain of attraction, surpassing
sum-of-squares Lyapunov functions obtained through semidef-
inite programming, as shown by numerical examples. This is
achieved by embracing non-convex optimization and leverag-
ing machine learning infrastructure, as well as formal verifica-
tion tools, to excel where convex optimization may not yield
satisfactory results.
There are numerous ways the framework can be expanded.
In the numerical example, we have already demonstrated the
potential of using compositional verification to cope with learning
and verifying Lyapunov functions for high-dimensional systems.
This is ongoing research, and some preliminary results have been
reported in Liu et al. (2024a). Future work could also include tool
development (Liu et al., 2024b) with support for different veri-
fication engines, such as dReal (Gao et al., 2013) and Z3 (Moura
& Bjørner, 2008), and leveraging the growing literature on neural
network verification tools. Another natural next step is to handle
systems with inputs, including perturbations and controls. Initial
work on using physics-informed neural network Lyapunov func-
tions for optimal control has been reported in Meng et al. (2024).
Investigating robust and control neural Lyapunov functions from
the Zubov equation can be an interesting approach (Camilli et al.,
2001). It would also be interesting to investigate Zubov equation
with state constraints to training neural Lyapunov-barrier func-
tions (Meng, Li, Fitzsimmons, & Liu, 2022) to cope with stability
with safety requirements. Simultaneous training of controllers
and Lyapunov/value functions are also promising directions, as
well as data-driven approaches (Meng et al., 2023).
While we have demonstrated that the approach can scale to
high-dimensional systems by leveraging the compositional struc-
ture, SMT verification of neural networks remains a bottleneck.
Further research on efficient tools for formally verifying neural
networks can certainly help maximize the full potential of the
proposed approach.
Acknowledgments
The authors thank the anonymous reviewers for their con-
structive feedback that helped improve the presentation of the
paper.
Appendix A. Proof of Proposition 1
Proof. (1)–(4) were proved in Liu et al. (2023b) except continuity
of V. See also Liu, Meng, Fitzsimmons, and Zhou (2023a). To show
continuity of V, fix any x0 ∈D. By Assumption 1, for any ε > 0,
there exists δ >
0 such that |x| < δ implies V(x) < ε /2.
By asymptotic stability of the origin, there exists some T > 0
such that |φ(T, x0)| < δ
2. By continuous dependence of solutions
to (1) on initial conditions, there exists some ρ > 0 such that
Bρ(x0) ⊂D and |φ(T, y)| < δ for all y ∈Bρ(x0). It follows that,
for any y ∈Bρ(x0),
|V(y) −V(x0)|
=
⏐⏐⏐⏐
∫T
0
ω(φ(t, y))dt −
∫T
0
ω(φ(t, x0))dt
+
∫∞
T
ω(φ(t, y))dt −
∫∞
T
ω(φ(t, x0))dt
⏐⏐⏐⏐
≤
∫T
0
|ω(φ(t, y)) −ω(φ(t, x0))| dt
+ |V(φ(T, y)) −V(φ(T, x0))|
≤
∫T
0
|ω(φ(t, y)) −ω(φ(t, x0))| dt + ε
2,
where the last inequality follows from our choice of δ, T, ρ,
and non-negativeness of V. By continuous dependence on initial
conditions and continuity of ω, there exists ρ′ ∈(0, ρ) such that
∫T
0 |ω(φ(t, y)) −ω(φ(t, x0))| dt < ε /2 for all y ∈Bρ′(x0), which
implies
|V(y) −V(x0)| < ε ,
∀y ∈Bρ′(x0).
We proved that V is continuous on D.
■
Appendix B. Proof of Proposition 2
We start with the formal definition of viscosity solutions for
first-order PDEs (Bardi et al., 1997; Crandall & Lions, 1983). Con-
sider a first-order PDE of the form
F(x, u(x), Du(x)) = 0,
x ∈Ω,
(B.1)
where Ω⊂Rn is an open set.
Definition 2.
A function u ∈C(Ω) is said to be a viscosity
subsolution of (B.1) if for any ψ ∈C1(Ω), we have
F(x, u(x), Dψ(x)) ≤0
whenever x is a local maximum of u−ψ. It is said to be viscosity
supersolution of (B.1) if for any ψ ∈C1(Ω), we have
9


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
F(x, u(x), Dψ(x)) ≥0
whenever x is a local minimum of u −ψ. We say u is a viscosity
solution of (B.1) if it is both a viscosity subsolution and a viscosity
supersolution.
An equivalent way to define viscosity solutions is given below.
Consider any function v : Ω→R and define the sets
D+v(x)
:=
{
p ∈Rn : lim sup
y→x
v(y) −v(x) −p · (y −x)
|y −x|
≤0
}
and
D−v(x)
:=
{
p ∈Rn : lim inf
y→x
v(y) −v(x) −p · (y −x)
|y −x|
≥0
}
.
They are called the (Frechét) superdifferential and the subdiffer-
ential of v at x.
Definition 3.
A function u ∈C(Ω) is said to be a viscosity
subsolution of (B.1) if
F(x, u(x), p) ≤0,
∀x ∈Ω, p ∈D+u(x),
and a viscosity supersolution of (B.1) if
F(x, u(x), p) ≥0,
∀x ∈Ω, p ∈D−u(x).
The equivalence of these conditions is standard and can be
found in Bardi et al. (1997, Chapter 2). Depending on the situa-
tion, one of these equivalent definitions may be more convenient
to use. At any point x where u is differentiable, we have D+u(x) =
D−u(x) = {Du(x)} and the PDE (B.1) is satisfied in the classical
sense.
It is clear from the definition of viscosity solutions that the PDE
(B.1) is not equivalent to −F(x, u, Du) = 0 in the viscosity sense.
When interpreting the Lyapunov PDE (3) in viscosity sense, we
define
FL(x, u, p) = −ω(x) −p · f (x).
(B.2)
We now provide a proof of Proposition 2.
Proof. (1) Consider V defined by (4). From Proposition 1(4), V is
continuous on Ω. Let ψ ∈C1(Ω). Suppose x is a local maximum
point of V −ψ. It follows that
V(x) −ψ(x) ≥V(z) −ψ(z)
for all z in a small neighborhood of x, which implies
V(x) −ψ(x) ≥V(φ(t, x)) −ψ(φ(t, x)),
for all t close to 0. Rearranging this gives
V(φ(t, x)) −V(x) ≤ψ(φ(t, x)) −ψ(x).
By Proposition 1 and continuous differentiability of ψ, we have
−ω(x) = lim
t→0+
V(φ(t, x)) −V(x)
t
≤Dψ(x) · f (x),
which verifies V is a viscosity subsolution of (3) in view of
(B.2). Similarly, we can show that V is a viscosity supersolution.
Uniqueness follows from a special case of the optimality principle
(see Proposition II.5.18, Theorem III.2.33, and Remark III.2.34
in Bardi et al. (1997)).
(2) To show local Lipschitz continuity of V under the stated
assumptions, consider any compact set K ⊂D. Then, for any
r > 0, there exists some T > 0 such that |φ(t, x)| < r for all
t ≥T and all x ∈K. There also exists another compact set ˆK such
that φ(t, x) ∈ˆK for all t ≥0. Indeed, ˆK can be taken as the union
of the reachable set of (1) from K on [0, T] and ¯Br. Let Lf > 0 be
a Lipschitz constant of f on ˆK and Lω be a Lipschitz constant of ω
on ˆK. For any x, y ∈K, we have
|V(x) −V(y)| ≤
∫T
0
|ω(φ(t, x)) −ω(φ(t, y))| dt
+
∫∞
T
|ω(φ(t, x)) −ω(φ(t, y))| dt
≤Lω
eLf T −1
Lf
|x −y|
+ Lω
∫∞
0
|φ(s, φ(T, x)) −φ(s, φ(T, y))| dt,
(B.3)
where, to obtain the inequality above, we used Gronwall’s in-
equality to estimate |φ(t, x) −φ(t, y)| ≤|x −y| eLf t for t ∈ [0, T]
within the first integral.
We now determine a sufficiently small r
>
0 such that
the following contraction condition holds for all solutions of (1)
starting from Br: there exists C > 0 and σ > 0 such that
|φ(t, x) −φ(t, y)| ≤Ce−σt |x −y| ,
∀x, y ∈Br.
(B.4)
We do this by local Lyapunov analysis. By stability of the origin,
for any ε > 0, there exists some r > 0 such that |x| < r implies
|φ(t, x)| > ε for all t ≥0. We focus on our analysis in Bε.
Consider A = Df (0) and g(x) = f (x) −Ax. Then g(0) =
Dg(0) = 0. By Assumption 2, Dg is continuous. Let P be the
solution to the Lyapunov equation PA + AT P = −I. Consider the
Lyapunov function W(x) = xT Px. Fix any x, y ∈Br. Then we have
φ(t, x), φ(t, y) ∈Bε for all t ≥0. Define E(t) = φ(t, x) −φ(t, y)
for t ≥0. We have
dW(E(t))
dt
= 2ET (t)P(f (t, φ(t, x))) −f (t, φ(t, y))
= 2ET (t)P(AE(t) + g(φ(t, x))) −g(φ(t, y))
= ET (t)(PA + AT P)E(t)
+ 2ET (t)
∫1
0
Dg(φ(t, y) + sE(t))dt · E(t)
≤ −∥E(t)∥2 + 2 sup
|z|≤ε
∥Dg(z)∥ ∥E(t)∥2 ,
where the first two equalities are direct computation, the third
equality is by the mean value theorem, and in the last inequality,
we used the convexity of Bε. Since Dg is continuous and Dg(0) =
0, we can choose ε sufficiently small such that 2 sup|z|≤ε ∥Dg(z)∥
< 1. It follows that
dW(E(t))
dt
≤ −cW(E(t)),
where c = (1 −2 sup|z|≤ε ∥Dg(z)∥)/λmax(P) and λmax(P) is the
maximum eigenvalue of P. From here we readily conclude that
(B.4) holds.
With (B.4), we continue from (B.3) and compute
|V(x) −V(y)|
≤Lω
eLf T −1
Lf
|x −y| + LωeLf T |x −y| C
∫∞
0
e−σtdt
= L |x −y| ,
where L = Lω(eLf T −1)/Lf + LωeLf T C/σ. We have proved that V
is locally Lipschitz on Ω. By Rademacher’s theorem, V is differ-
entiable almost everywhere in D. At points where V is differen-
tiable, a viscosity solution reduces to a classical solution. Hence,
(3) is satisfied almost everywhere in the classical sense.
(3) Define
J(x) =
∫∞
0
Dω(φ(t, x))Φ(t, x)dt,
x ∈D,
(B.5)
10


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
where Φ(t) is the fundamental matrix solution to the initial value
problem
̇Φ(t, x) = A(t, x)Φ(t, x),
Φ(0) = I,
with I being the n-dimensional identity matrix and A(t, x) =
Df (φ(t, x)). We prove the following:
(a) J(x) is well defined for all x ∈D.
(b) J is continuous with respect to x.
(c) The limit
lim
h→0
|V(x + h) −V(x) −J(x)h|
|h|
= 0
(B.6)
holds.
Combining these shows that V is continuously differentiable on
D and DV = J.
To prove (a), fix any x ∈D. By asymptotic stability of the origin
and ω being C1, it is clear that Dω(φ(t, x)) is uniformly bounded.
We prove (a) by bounding columns of Φ(t, x) with Lyapunov
analysis. Consider the ith column given by
̇Φi(t, x) = A(t, x)Φi(t, x),
Φi(0) = ei.
Clearly, A(t, x) →A = Df (0) as t → ∞, because f ∈C1. Consider
P and W as defined in the proof of part (2). We have
dW(Φi(t, x))
dt
= ΦT
i (t, x)(PA(t, x) + AT (t, x)P)Φi(t, x)
= ΦT
i (t, x)(PA + AT P)Φi(t, x)
+ ΦT
i (t, x)(PE(t) + ET (t)P)Φi(t, x),
where E(t) = A(t, x) −A. Pick ε > 0 such that 2 ∥P∥ε < 1. Since
E(t) →0 as t → ∞, there exists some T > 0 such that |E(t)| < ε
for all t ≥T. It follows that
dW(Φi(t, x))
dt
≤ −cW(Φi(t, x)),
∀t ≥T,
where c = (1 −2 ∥P∥ε)/λmax(P). It follows that Φi(t) exponen-
tially converges to zero as t → ∞. Hence J(x) is well defined for
each x ∈D.
To prove (b), we rely on continuous dependence of Φ(t, x) and
φ(t, x) on x. Fix x ∈D. Consider ρ > 0 such that ¯Bρ(x) ⊂D. By
the analysis above, we know each element of Φ(t, y) converges
exponentially to zero as t → ∞for y ∈¯Bρ(x). It follows from
a continuity and compactness argument that the convergence
is uniform for y ∈¯Bρ(x). Furthermore, Dω(φ(t, y)) is uniformly
bounded for y ∈¯Bρ(x). Similar to the proof of continuity of V in
Proposition 1, we can write
|J(y) −J(x)|
≤
∫T
0
|Dω(φ(t, y))Φ(t, y) −Dω(φ(t, x))Φ(t, x)| dt
+
∫∞
T
|Dω(φ(t, y))Φ(t, y)| dt +
∫∞
T
|Dω(φ(t, x))Φ(t, x)| dt.
Thanks to uniform convergence of Φ(t, y) to zero and uniform
boundedness of Dω(φ(t, y)) for y ∈
¯Bρ(x), for any ε > 0, we
can choose T sufficiently large, independent of y ∈¯Bρ(x), such
that the last two integrals are bounded ε /4. For this fixed T, by
continuous dependence on initial conditions again, we can then
choose ρ′ ∈(0, ρ) such that the first integral is bounded by ε /2
for all y ∈Bρ′(x). It follows that |J(y) −J(x)| < ε for all y ∈Bρ′(x).
We have proved that J is continuous.
We now prove (c). Fix any x ∈D. Pick ρ > 0 such that
¯Bρ(x) ⊂D. Let r > 0 be such that (B.4) holds. Choose ˆT > 0
such that |φ(t, y)| < r for all t ≥ˆT and all y ∈¯Bρ(x). Consider
any h with |h| < ρ and T > ˆT. We have
|V(x + h) −V(x) −J(x)h|
=
⏐⏐⏐⏐
∫∞
0
ω(φ(t, x + h))dt −
∫∞
0
ω(φ(t, x))dt
−
∫∞
0
Dω(φ(t, x))Φ(t, x)dt · h
⏐⏐⏐⏐
≤
∫T
0
|ω(φ(t, x + h)) −ω(φ(t, x))
−Dω(φ(t, x))Φ(t, x)h|dt
+
∫∞
T
|Dω(φ(t, x))Φ(t, x)| dt |h|
+
∫∞
T
|ω(φ(t, x + h)) −ω(φ(t, x))| dt.
(B.7)
We analyze each of the three integrals above. Let Lf and Lω be
Lipschitz constants of f and ω on the reachable set from ¯Bρ(x).
First, by Gronwall’s inequality on [0, ˆT] and contraction property
(B.4) on [ˆT, T], we have
|φ(T, x + h) −φ(T, x)| ≤eLf ˆT |h| e−σ(T−ˆT).
By (B.4) again, this implies
∫∞
T
|ω(φ(t, x + h)) −ω(φ(t, x))| dt
≤LωeLf ˆT |h| e−σ(T−ˆT)C
∫∞
0
e−σtdt
= LωeLf ˆT e−σ(T−ˆT)C
σ
|h| .
(B.8)
For any ε > 0, choose T sufficiently large such that
LωeLf ˆT e−σ(T−ˆT)C/σ < ε /4
(B.9)
and
∫∞
T
|Dω(φ(t, x))Φ(t, x)| dt < ε
4,
(B.10)
the latter of which is possible as analyzed in the proof of (b).
By the mean value theorem, we have
ω(φ(t, x + h)) −ω(φ(t, x)) = Dω(φ(t, ξ))Φ(t, ξ)h,
where ξ
=
(1 −c)x + c(x + h) for some c ∈
(0, 1). Note
that ξ −x = ch By uniform continuity of Dω(φ(·, ·))Φ(·, ·) on
[0, T] × ¯Bρ(x), there exists ρ′ ∈(0, ρ) such that
|Dω(φ(t, ξ))Φ(t, ξ) −Dω(φ(t, x))Φ(t, x)| < ε
2,
(B.11)
for all h with |h| < ρ′. Putting (B.8), (B.9), (B.10), (B.11), together
with (B.7) implies
|V(x + h) −V(x) −J(x)h| ≤ε |h| ,
(B.12)
for all h such that |h| < ρ′. Hence the limit (B.6) holds and (c) is
proved.
We conclude that V defined by (4) is continuously differen-
tiable on D and the unique solution to (3) in C1(Ω) for any open
set Ω⊂D by item (1) of the proposition.
■
Appendix C. Proof of Theorem 2
A viscosity solution of (9) is interpreted as a viscosity solution
to FZ(x, u, Du) = 0 with
FZ(x, u, p) = −ω(x)ψ(u)(1 −u) −p · f (x),
(C.1)
where ψ is from (7).
Proof. We first verify that W defined by (8) is a viscosity solution
to (9) on Rn. Let h ∈C1(Rn). Suppose that x0 ∈D is a local
maximum of W −h. It follows from the same argument in the
11


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
proof of Proposition 2(1) that
W(φ(t, x0)) −W(x0) ≤h(φ(t, x0)) −h(x0)
(C.2)
for all t close to 0. Note that φ(t, x0) ∈D and W(x) = β(V(x)) for
all x ∈D. By Proposition 1, Eq. (7), and continuous differentiabil-
ity of h, we have
−ω(x0)ψ(W)(1 −W) = lim
t→0+
W(φ(t, x0)) −W(x0)
t
≤Dh(x0) · f (x0).
(C.3)
When x0 ∈Rn \ D is a local maximum of W −h, we have
W(φ(t, x0)) ≡1 and (C.3) still holds. This verifies that W is a
viscosity subsolution of (3) on Rn in view of (C.1). Similarly, we
can show that W is a viscosity supersolution on Rn.
We proceed to prove uniqueness on any open set Ωcontaining
the origin. Let u1 and u2 be two viscosity solutions to (9) on
Ωsubject to the same boundary condition (10) and satisfying
u1(0) = u2(0) = 0. Pick δ > 0 sufficiently small such that
¯Bδ ⊂Ω∩D, ui(x) < 1, and ψ(ui(x)) > 0 for all x ∈Bδ.
Then β−1 is well defined and increasing on the range of ui(x) on
Bδ for i = 1, 2. This is possible by continuity of ui and ψ, and
the definition of β in (7). By Bardi et al. (1997, Proposition 2.5),
vi(x) = β−1(ui(x)) is a viscosity solution of
FZ(x, β(v), β′(v)Dv) = 0,
x ∈Bδ.
By (C.1) and positiveness of ψ(β(v))(1 −β(v)) for x ∈Bδ, vi
(i = 1, 2) is a viscosity solution of (3) on Bδ in view of (B.2).
Clearly, v1(0) = v2(0). By Proposition 2(1) and continuity, v1 and
v2 are identical on ¯Bδ, which implies u1 and u2 are identical on
¯Bδ.
Suppose u1 and u2 are nonidentical on Ω′ = Ω\ ¯Bδ. Note that
∂Ω′ = ∂Ω∪∂¯Bδ. We have u1 = u2 on ∂Ω′.
Without loss of generality, assume there exists ¯x ∈Ω′ such
that u1(¯x) > u2(¯x). For each ε > 0, define an auxiliary function
Φε(x, y) = u1(x) −u2(y) −|x −y|2
2ε
,
(x, y) ∈¯Ω′ × ¯Ω′.
Let (xε, yε) be a maximum Φε on ¯Ω′ × ¯Ω′. Following a standard
comparison argument (Bardi et al., 1997, Theorem II.3.1) (see
also Liu et al. (2023a)), we can show that (xε, yε) can only be
achieved in Ω′ × Ω′ for all ε sufficiently small. Furthermore, we
can establish |xε −yε| →0 and |xε−yε|2
2ε
→0 as ε →0, and
−ω(xε)ψ(u1(xε))(1 −u1(xε)) −xε −yε
ε
· f (xε) ≤0,
and
−ω(yε)ψ(u2(yε))(1 −u2(yε)) −xε −yε
ε
· f (yε) ≥0.
Let
aε = −(xε −yε) · f (xε)
ε ω(xε)
,
bε = −(xε −yε) · f (yε)
ε ω(yε)
.
Define G(s) = ψ(s)(1 −s). From the above two inequalities, we
have
G(u1(xε)) ≥aε,
G(u2(yε)) ≤bε.
Furthermore, we have
0 < u1(¯x) −u2(¯x) = Φε(¯x, ¯x) ≤Φε(xε, yε)
≤u1(xε) −u2(yε).
(C.4)
By monotonicity of G, we obtain
aε −bε ≤G(u1(xε)) −G(u2(yε)) ≤0.
Recall that |xε −yε| →0 and |xε−yε|2
2ε
→0 as ε →0. By Lipschitz
continuity of f and ω on ¯Ω′, we can verify aε −bε →0 as
ε →0. Now, by uniform continuity of G−1 on the compact set
G(Y), where Y ⊂I is a compact set containing the image of u1
and u2 from ¯Ω′, we conclude that u1(xε) −u2(yε) →0 as ε →0,
which contradicts (C.4).
Hence u1 and u2 are identical on Ω′ as well. We have proved
uniqueness of viscosity solution to (9) on ¯Ω. Items (2) and (3) are
direct consequences of items (2) and (3) in Proposition 2.
■
Appendix D. Proof of Proposition 4
We begin with the following definition. We say that v is an
ε-approximate viscosity solution of (9), if
FZ(x, v(x), p) ≤ε ,
∀x ∈Ω, p ∈D+v(x),
FZ(x, v(x), p) ≥ −ε ,
∀x ∈Ω, p ∈D−v(x).
where FZ is from (C.1).
Proof.
For each δ > 0 such that ¯Bδ ⊂Ω∩D, we denote
Ω′ = Ω\ ¯Bδ. Note that ∂Ω′ = ∂Ω∪∂¯Bδ. In the proof of
Theorem 2, we essentially proved the following fact: if u1 is a
viscosity subsolution to (9) and u2 is a viscosity supersolution to
(9) on Ω′ and u1 ≤u2 on ∂Ω′, then we have u1 ≤u2 on Ω′. We
define
C(ε , εb) = max
{
−v + G−1
(
G(v) −
ε
minx∈¯Ω\Bδ ω(x)
)
,
v −G−1
(
G(v) +
ε
minx∈¯Ω\Bδ ω(x)
)
, εb
}
(D.1)
Evaluations of G−1 above are valid because of the assumption on
v and ε. By continuity of G and G−1, C(ε , εb) →0 as ε →0 and
εb →0. With this choice, it follows from monotonicity of G that
−ω(x)G(v + C(ε , εb)) ≥ −ω(x)
(
G(v) −
ε
minx∈¯Ω\Bδ ω(x)
)
≥ −w(x)G(v) + ε .
Similarly, −ω(x)G(v −C(ε , εb)) ≤ −w(x)G(v) −ε. Hence, we can
readily verify that v + C(ε , εb) is a viscosity supersolution and
v −C(ε , εb) is a viscosity subsolution of (9) on Ω′ with boundary
condition (10) on ∂Ω′. By the comparison argument in the proof
of Theorem 2, we can show W(x) ≤v + C(ε , εb) and W(x) ≥
v −C(ε , εb) on Ω′.
Now consider the sequence {vn} and we show it uniformly
converges to W on ¯Ω. For any ρ > 0, choose δ > 0 and N > 0
such that |W(x)| ≤ρ
2 and |vn(x)| ≤ρ
2 for all x ∈Bδ and all n > N.
This is possible by the fact that W(0) = 0, W is continuous,
vn(0) →0 as n → ∞and vn has a uniform Lipschitz constant
on Ω. By uniform convergence of vn to W on ∂Ω, we can choose
N sufficiently large such that |W(x) −vn(x)| ≤ρ for all n > N
and x ∈∂Ω.
With fixed ρ and δ, choose N sufficiently large such that
C(εn, ρ) ≤ρ for all n > N. This is possible by εn ↓0, the
continuity of G and G−1, and the definition of C(ε , εb) in (D.1).
Since vn is an εn-approximate viscosity solution to (9) on Ω′ with
boundary error |W(x) −vn(x)| ≤ρ on ∂Ω′, where Ω′ = Ω\ ¯Bδ,
by the conclusion established earlier, we have |vn(x) −W(x)| ≤
C(εn, ρ) ≤ρ for all x ∈¯Ω′. Since we also have |W(x) −vn(x)| ≤ρ
for x ∈Bδ and n > N, we have proved |vn(x) −W(x)| ≤ρ for all
x ∈¯Ωand all n > N.
■
References
Abate, Alessandro, Ahmed, Daniele, Edwards, Alec, Giacobbe, Mirco, & Pe-
ruffo, Andrea (2021). FOSSIL: a software tool for the formal synthesis of
Lyapunov functions and barrier certificates using neural networks. In Proc.
of HSCC (pp. 1–11).
Abate, Alessandro, Ahmed, Daniele, Giacobbe, Mirco, & Peruffo, Andrea (2020).
Formal synthesis of Lyapunov neural networks. IEEE Control Systems Letters,
5(3), 773–778.
12


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Ahmed, Daniele, Peruffo, Andrea, & Abate, Alessandro (2020). Automated and
sound synthesis of Lyapunov functions with smt solvers. In Proc. of TACAS
(pp. 97–114). Springer.
Bardi, Martino, Dolcetta, Italo Capuzzo, et al. (1997). Optimal control and viscosity
solutions of Hamilton–Jacobi-Bellman equations: vol. 12, Springer.
Bhatia, Nam P., & Szegö, George P. (1967). Dynamical systems: Stability theory
and applications: vol. 35, Springer.
Camilli, Fabio, Grüne, Lars, & Wirth, Fabian (2001). A generalization of Zubov’s
method to perturbed systems. SIAM Journal on Control and Optimization,
40(2), 496–515.
Chang, Ya-Chien, Roohi, Nima, & Gao, Sicun (2019). Neural Lyapunov control.
Advances in Neural Information Processing Systems, 32.
Chen, Shaoru, Fazlyab, Mahyar, Morari, Manfred, Pappas, George J., & Preci-
ado, Victor M. (2021a). Learning lyapunov functions for hybrid systems. In
Proc. of HSCC (pp. 1–11).
Chen, Shaoru, Fazlyab, Mahyar, Morari, Manfred, Pappas, George J., & Preci-
ado, Victor M. (2021b). Learning region of attraction for nonlinear systems.
In Proc. of CDC (pp. 6477–6484). IEEE.
Crandall, Michael G., & Lions, Pierre-Louis (1983). Viscosity solutions of
Hamilton-Jacobi equations. Transactions of the American Mathematical Society,
277(1), 1–42.
Dai, Hongkai, Landry, Benoit, Pavone, Marco, & Tedrake, Russ (2020). Counter-
example guided synthesis of neural network Lyapunov functions for
piecewise linear systems. In Proc. of CDC (pp. 1274–1281).
Dai, Hongkai, Landry, Benoit, Yang, Lujie, Pavone, Marco, & Tedrake, Russ (2021).
Lyapunov-stable neural-network control. In Proc. of RSS.
Dawson, Charles, Gao, Sicun, & Fan, Chuchu (2023). Safe control with learned
certificates: A survey of neural Lyapunov, barrier, and contraction methods
for robotics and control. IEEE Transactions on Robotics.
Evans, Lawrence C. (2010). Partial differential equations: vol. 19, American
Mathematical Society.
Gaby, Nathan, Zhang, Fumin, & Ye, Xiaojing (2022). Lyapunov-Net: A deep neural
network architecture for Lyapunov function approximation. In 2022 IEEE 61st
conference on decision and control (pp. 2091–2096). IEEE.
Gao, Sicun, Kong, Soonho, & Clarke, Edmund M. (2013). Dreal: an SMT solver
for nonlinear theories over the reals. In Proc. of CADE (pp. 208–214).
Giesl, Peter (2007). Construction of global Lyapunov functions using radial basis
functions: vol. 1904, Springer.
Giesl, Peter, & Hafstein, Sigurdur (2015). Review on computational methods
for Lyapunov functions. Discrete and Continuous Dynamical Systems. Series
B, 20(8), 2291.
Grüne, Lars (2021a). Computing Lyapunov functions using deep neural networks.
Journal of Computational Dynamics, 8(2).
Grüne, Lars (2021b). Overcoming the curse of dimensionality for approximating
Lyapunov functions with deep neural networks under a small-gain condition.
IFAC-PapersOnLine, 54(9), 317–322.
Haddad, Wassim M., & Chellaboina, VijaySekhar (2008). Nonlinear dynamical
systems and control: A Lyapunov-based approach. Princeton University Press.
Jones, Morgan, & Peet, Matthew M. (2021). Converse Lyapunov functions
and converging inner approximations to maximal regions of attraction of
nonlinear systems. In Proc. of CDC (pp. 5312–5319). IEEE.
Kang, Wei, Sun, Kai, & Xu, Liang (2023). Data-driven computational methods
for the domain of attraction and Zubov’s equation. IEEE Transactions on
Automatic Control.
Kapinski, James, Deshmukh, Jyotirmoy V., Sankaranarayanan, Sriram, &
Arechiga, Nikos (2014). Simulation-guided Lyapunov analysis for hybrid
dynamical systems. In Proc. of HSCC (pp. 133–142).
Khodadadi, Larissa, Samadi, Behzad, & Khaloozadeh, Hamid (2014). Estimation of
region of attraction for polynomial nonlinear systems: A numerical method.
ISA Transactions, 53(1), 25–32.
Kundu, Soumya, & Anghel, Marian (2015). A sum-of-squares approach to the
stability and control of interconnected systems using vector Lyapunov
functions. In Proc. of ACC (pp. 5022–5028). IEEE.
Lagaris, Isaac E., Likas, Aristidis, & Fotiadis, Dimitrios I. (1998). Artificial neu-
ral networks for solving ordinary and partial differential equations. IEEE
Transactions on Neural Networks, 9(5), 987–1000.
Liu, Jun, Meng, Yiming, Fitzsimmons, Maxwell, & Zhou, Ruikun (2023a). Physics-
informed neural network Lyapunov functions: PDE characterization, learning,
and verification. arXiv preprint arXiv:2312.09131.
Liu, Jun, Meng, Yiming, Fitzsimmons, Maxwell, & Zhou, Ruikun (2023b). Towards
learning and verifying maximal neural Lyapunov functions. In Proc. of CDC.
Liu, Jun, Meng, Yiming, Fitzsimmons, Maxwell, & Zhou, Ruikun (2024a). Com-
positionally verifiable vector neural Lyapunov functions for stability analysis
of interconnected nonlinear systems. In Proc. of ACC.
Liu, Jun, Meng, Yiming, Fitzsimmons, Maxwell, & Zhou, Ruikun (2024b). LyZNet:
A lightweight python tool for learning and verifying neural Lyapunov
functions and regions of attraction. In Proc. of HSCC (pp. 1–8).
Long, Y., & Bayoumi, M. M. (1993). Feedback stabilization: control Lyapunov
functions modelled by neural networks.
vol. 3, In
Proc. of CDC
(pp.
2812–2814).
Lyapunov, Aleksandr Mikhailovich (1992). The general problem of the stability
of motion. International Journal of Control, 55(3), 531–534.
Meng, Yiming, Li, Yinan, Fitzsimmons, Maxwell, & Liu, Jun (2022). Smooth
converse Lyapunov-barrier theorems for asymptotic stability with safety
constraints and reach-avoid-stay specifications. Automatica, 144, Article
110478.
Meng, Yiming, Zhou, Ruikun, & Liu, Jun (2023). Learning regions of attraction
in unknown dynamical systems via Zubov-Koopman lifting: Regularities and
convergence. arXiv preprint arXiv:2311.15119.
Meng, Yiming, Zhou, Ruikun, Mukherjee, Amartya, Fitzsimmons, Maxwell,
Song, Christopher, & Liu, Jun (2024). Physics-informed neural network policy
iteration: Algorithms, convergence, and verification. In Proc. of ICML.
Moura, Leonardo De, & Bjørner, Nikolaj (2008). Z3: An efficient smt solver. In
Proc. of TACAS (pp. 337–340). Springer.
Packard, Andy, Topcu, Ufuk, Seiler, Peter J., Jr., & Balas, Gary (2010). Help on
SOS. IEEE Control Systems Magazine, 30(4), 18–23.
Papachristodoulou, Antonis, & Prajna, Stephen (2002). On the construction of
Lyapunov functions using the sum of squares decomposition. vol. 3, In Proc.
of CDC (pp. 3482–3487). IEEE.
Papachristodoulou, Antonis, & Prajna, Stephen (2005). A tutorial on sum of
squares techniques for systems analysis. In Proc. of ACC (pp. 2686–2700).
IEEE.
Prokhorov, Danil V. (1994). A Lyapunov machine for stability analysis of
nonlinear systems. vol. 2, In Proc. of ICNN (pp. 1028–1031). IEEE.
Raissi, Maziar, Perdikaris, Paris, & Karniadakis, George E. (2019). Physics-
informed neural networks: A deep learning framework for solving forward
and inverse problems involving nonlinear partial differential equations.
Journal of Computational Physics, 378, 686–707.
Sepulchre, Rodolphe, Jankovic, Mrdjan, & Kokotovic, Petar V. (2012). Constructive
nonlinear control. Springer Science & Business Media.
Soravia, Pierpaolo (1999). Optimality principles and representation formulas for
viscosity solutions of Hamilton-Jacobi equations i. equations of unbounded
and degenerate control problems without uniqueness. Advances in Differential
Equations, 4(2), 275–296.
Tan, Weehong, & Packard, Andrew (2008). Stability region analysis using poly-
nomial and composite polynomial Lyapunov functions and sum-of-squares
programming. IEEE Transactions on Automatic Control, 53(2), 565–571.
Topcu, Ufuk, Packard, Andrew, & Seiler, Peter (2008). Local stability analysis
using simulations and sum-of-squares programming. Automatica, 44(10),
2669–2675.
Vannelli, Anthony, & Vidyasagar, Mathukumalli (1985). Maximal Lyapunov
functions and domains of attraction for autonomous nonlinear systems.
Automatica, 21(1), 69–80.
Zhou, Ruikun, Quartz, Thanin, Sterck, Hans De, & Liu, Jun (2022). Neural
Lyapunov control of unknown nonlinear systems with stability guarantees.
In Advances in neural information processing systems.
Zubov, V. I. (1964). Methods of A. M. Lyapunov and their application. Noordhoff.
Jun Liu received the B.S. degree in Applied Mathemat-
ics from Shanghai Jiao-Tong University in 2002, the
M.S. degree in Mathematics from Peking University in
2005, and the Ph.D. degree in Applied Mathematics
from the University of Waterloo in 2011. He held an
NSERC Postdoctoral Fellowship in Control and Dynami-
cal Systems at Caltech between 2011 and 2012. He was
a Lecturer in Control and Systems Engineering at the
University of Sheffield from 2012 to 2015. In 2015, he
joined the Faculty of Mathematics at the University of
Waterloo, where he is currently a Professor of Applied
Mathematics. His main research interests are in the theory and applications
of hybrid systems and control, including rigorous computational methods for
control design with applications in cyber–physical systems and robotics.
Yiming Meng received the bachelor’s degree in Chem-
ical Engineering from Tianjin University in 2013, the
M.Sc. degree in Process Systems Engineering from the
Chemical Engineering Department at Imperial College
London in 2017, and the Ph.D. degree in Applied
Mathematics from the University of Waterloo in 2022.
He was a postdoctoral fellow at the Department of
Applied Mathematics, University of Waterloo, between
2022 and 2023. Currently, he is a Postdoctoral Re-
search Associate at the Coordinated Science Laboratory,
University of Illinois Urbana-Champaign. His research
interests are in stochastic dynamical systems and control, and multi-agent
optimal planning, including formal methods and data-based decision-making
problems with applications in finance, robotics, and other physical sciences.
13


J. Liu, Y. Meng, M. Fitzsimmons et al.
Automatica 175 (2025) 112193
Maxwell Fitzsimmons is a mathematician and post-
doctoral researcher at the University of Waterloo. His
specialties include dynamical systems and analysis.
Ruikun Zhou received the bachelor’s degree in Vehicle
Engineering from Chongqing University in 2014 and the
M.A.Sc. degree in Mechanical Engineering from the Uni-
versity of Ottawa in 2020. Currently, he is pursuing his
Ph.D. degree in Applied Mathematics at the University
of Waterloo. His research interests lie at the intersec-
tion of machine learning and control systems, including
learning-based stability analysis with formal guaran-
tees and learning-based control with applications in
robotics.
14
