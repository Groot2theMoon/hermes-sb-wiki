---
source_url: 
ingested: 2026-04-30
sha256: ee41a91b266ca84de0d2aac268d78d33030e214a0aea9d38de09c6934b3a961d
---

IEEE TRANSACTIONS ON AUTOMATIC CONTROL
1
Resolvent-Type Data-Driven Learning of
Generators for Unknown Continuous-Time
Dynamical Systems
Yiming Meng⋆, Ruikun Zhou⋆, Melkior Ornik, Senior Member, IEEE, and Jun Liu, Senior Member, IEEE
Abstract— A semigroup characterization, or equivalently,
a characterization by the generator, is a classical tech-
nique used to describe continuous-time nonlinear dynami-
cal systems. In the realm of data-driven learning for an un-
known nonlinear system, one must estimate the generator
of the semigroup of the system’s transfer operators (also
known as the semigroup of Koopman operators) based on
discrete-time observations and verify convergence to the
true generator in an appropriate sense. As the generator
encodes essential instantaneous transitional information of
the system, challenges arise for some existing methods
that rely on accurately estimating the time derivatives of
the state with constraints on the observation rate. Recent
literature develops a technique that avoids the use of
time derivatives by employing the logarithm of a Koopman
operator. However, the validity of this method has been
demonstrated only within a restrictive function space and
requires knowledge of the operator’s spectral properties. In
this paper, we propose a resolvent-type method for learning
the system generator to relax the requirements on the ob-
servation frequency and overcome the constraints of taking
operator logarithms. We also provide numerical examples
to demonstrate its effectiveness in applications of system
identification and constructing Lyapunov functions.
Index Terms— Unknown nonlinear systems, infinitesimal
generator, operator-logarithm-free, observation sampling
rate, convergence analysis.
I. INTRODUCTION
O
PERATOR semigroups are essential for characterizing
Markov processes, whether random or deterministic. In
the scope of the approximation of a Markov process, the
convergence of an approximating sequence of processes should
be studied. The technique involves studying the convergence
This research was supported in part by NASA under grant numbers
80NSSC21K1030 and 80NSSC22M0070, by the Air Force Office of
Scientific Research under grant number FA9550-23-1-0131, and in part
by the Natural Sciences and Engineering Research Council of Canada
and the Canada Research Chairs program.
⋆Equal contribution.
Yiming Meng is with the Coordinated Science Laboratory, Uni-
versity
of
Illinois
Urbana-Champaign,
Urbana,
IL
61801,
USA.
ymmeng@illinois.edu.
Ruikun
Zhou
is
with
the
Department
of
Applied
Mathemat-
ics,
University
of
Waterloo,
Waterloo
ON
N2L
3G1,
Canada
ruikun.zhou@uwaterloo.ca.
Melkior Ornik is with the Department of Aerospace Engineering
and the Coordinated Science Laboratory, University of Illinois Urbana-
Champaign, Urbana, IL 61801, USA. mornik@illinois.edu.
Jun Liu is with the Department of Applied Mathematics, University of
Waterloo, Waterloo ON N2L 3G1, Canada j.liu@uwaterloo.ca.
of the processes’ (infinitesimal) generators in an appropri-
ate sense. Such convergence implies the convergence of the
processes’ transition semigroups, which, in turn, implies the
convergence of the processes to the true Markov process [1].
For a continuous-time nonlinear dynamical system, the op-
erator semigroup, denoted by {Kt}t≥0, is known as the semi-
group of transfer operators, which are also called Koopman
operators [2], [3]. The corresponding infinitesimal generator,
L, is a differential operator (most likely unbounded [4, Chapter
VIII]) that provides essential instantaneous transitional in-
formation for the dynamical system [5]. Particularly, many
mass transport-related PDEs, such as transport equations [6],
Lyapunov equations [7], and Hamilton-Jacobi equations [8]–
[10], are defined by the generator. Their solutions serve as
valuable tools for discovering physical laws [11], [12] and
verifying dynamical system properties related to stability [13]–
[15], safety [16]–[18], and kinetic and potential energy [5], [6],
with applications across various fields including mechanical,
space, and power systems, as well as other physical sciences.
To learn unknown continuous-time dynamical systems, one
must approximate the entire semigroup, or equivalently its
generator, from discrete trajectory data and demonstrate con-
vergence to the true system in an appropriate sense. Consider-
ing possible nonlinear effects, challenges arise in retrieving
transient system transitions from unavoidable discrete-time
observations. Particularly in real-world applications, due to the
limitations of sensing apparatuses in achieving high-frequency
observations, it is difficult to accurately evaluate quantities
related to transient transitions, such as those involving time
derivatives.
To enhance learning accuracy, we propose a Koopman-
based generator learning scheme that relaxes the observa-
tion rate compared to existing methods and demonstrates its
convergence to the true generator. Below, we review some
crucial results from the literature that are pertinent to the work
presented in this paper.
A. Related Work
The equivalence between the vector field and the infinites-
imal generator of the system semigroup has been shown in
[2], [19], indicating an equivalence in terms of conventional
system (model) identification and generator (or semigroup)
characterization.
For autonomous dynamical systems, direct methods such
as Bayesian approaches [20] and the sparse identification
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


2
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
of non-linear dynamics (SINDy) algorithm [21] have been
developed to identify state dynamics with a known structure
[11], [12], relying on nonlinear parameter estimation [22],
[23] and static linear regression techniques. However, direct
methods require that time derivatives of the state can be
accurately estimated, an assumption that may not be robustly
satisfied due to potential challenges such as low sampling
rates, noisy measurements, and short observation periods.
Indirect characterization methods can leverage the learning
structure of Koopman operators [24]. By applying certain
transformations to the learned Koopman operator, the image of
the generator related to the instantaneous state dynamics can
be expressed as a linear combination of dictionary functions.
Such a framework is based solely on observed state data
snapshots, which enhances the robustness of characterization
through linear least squares optimization over an expressive
dictionary that includes nonlinear functions. An additional
benefit of using indirect methods is that they can stream-
line the procedures for generator characterization and solv-
ing transport-related PDEs using the same set of dictionary
functions, including neural network bases [25]–[28]. In this
introduction, we summarize two widely used Koopman-based
characterization methods.
Finite-difference method (FDM) is a numerical technique
used to solve differential equations by approximating deriva-
tives with finite differences. In the context of Koopman-
based learning, the generator on any observable function is
approximated by the rate of its evolution along the trajectory,
using a forward difference method with a small discretized
time scale. Similar to direct methods, this approximation
scheme also relies on the notion of evolution speed or time
derivatives. As anticipated, its precision heavily depends on
the size of the temporal discretization [29]–[34].
Recent studies [30], [35]–[37] have facilitated another indi-
rect learning of the generator using the logarithm of the learned
Koopman operator. This approach can potentially circumvent
the need for high observation rates and longer observation
periods, as it does not require the estimation of time deriva-
tives. Heuristically, researchers tend to represent the Koopman
operator Kt by an exponential form of its generator L as Kt =
etL, leading to the converse representation L =
1
t log(Kt)
for any t > 0. However, problems arise given the following
concerns: 1) representing Koopman operators in exponential
form requires the boundedness of the generator L; 2) the
operator logarithm is a single-valued mapping only within a
specific sector of the spectrum; 3) for general systems that
fall short of the aforementioned restrictions, it is unclear how
the data-driven approximation of the logarithm of Koopman
operators converges to the true generator.
As a complement to the work in [35], [36], recent studies
[38], [39] have rigorously investigated the sufficient and nec-
essary conditions under which the Koopman-logarithm based
generator learning method can guarantee learning accuracy. To
provide the sampling rate, the theorem relies on the concept of
a “generator-bounded space”, which remains invariant under
the Koopman operator, and where the generator is bounded
when restricted to it. However, the mentioned concept is less
likely to be verifiable for unknown systems.
B. Contributions
To address the aforementioned issues, we aim to propose an
operator logarithm-free generator learning scheme, named the
resolvent-type method (RTM), which is robust to the choice
of the dictionary of observable functions and does not require
knowledge of spectral properties of the Koopman operators.
A brief discussion on the resolvent of the Koopman generator
can be found in [40]. However, to the best of the authors’
knowledge, the current work is the first to utilize a resolvent-
based method to identify the generator and, consequently, the
vector fields. In summary, the main contributions are:
1) We demonstrate the converse relationship between the
Koopman operators and the generator in more general
cases where the generator may be unbounded. Specif-
ically, we draw upon the rich literature to propose
a finite-dimensional approximation based on Yosida’s
approximation for these cases.
2) We provide the analytical convergence of this approxi-
mation and demonstrate the theoretical feasibility of a
data-driven adaptation.
3) We adapt the Koopman operator learning structure for
generator learning based on 1), and demonstrate that a
modification is needed to accommodate a low observa-
tion rate constraint.
4) We provide numerical experiments and demonstrate the
effectiveness of the proposed approach by comparing it
with the FDM and logarithm-based methods.
Notice of Previous Publication. This manuscript substan-
tially improves the work of [41] in the following aspects: 1)
All key convergence proofs are completed, providing step-by-
step reasoning on the development of the proposed method; 2)
The key step of the learning algorithm is provided, explicitly
demonstrating the dependence on tuning parameters; 3) A
novel modification is derived to relax the constraint on the
observation rate; 4) Numerical simulations on representative
systems are thoroughly studied.
The rest of the paper is organized as follows. In Section II,
we present some preliminaries on dynamical systems and the
corresponding semigroup. In Section III, we provide a Yosida-
type approximation for the infinitesimal generator in the strong
operator topology and justify its robustness, particularly in
terms of the class of dictionary functions, as the foundation
for subsequent data-driven approximations. In Section IV, we
verify the feasibility of using a data-driven approximation
by providing a finite-horizon, finite-dimensional reduction. A
modification of this approximation is discussed in Section
V to improve precision under potential sampling rate and
horizon constraints. The data-driven algorithm is then detailed
in Section VI, followed by numerical simulations in Section
VII that demonstrate the performance of the proposed method.
C. Notation
We denote by Rd the Euclidean space of dimension d > 1,
and by R the set of real numbers. We use | · | to denote the
Euclidean norm. For a set A ⊆Rd, A denotes its closure,
int(A) denotes its interior and ∂A denotes its boundary. We
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
3
also use ·T and ·+ to denote the matrix/vector transpose and
pseudoinverse, respectively.
For any complete normed function spaces (V, ∥· ∥V) and
(W, ∥·∥W) of the real-valued observable functions, and for any
bounded linear operator B : V →W, we define the operator
(uniform) norm as ∥B∥:= sup∥h∥V =1 ∥Bh∥W. We denote by I
the identity operator on any properly defined spaces. Let C(Ω)
be the set of continuous functions with domain Ω, endowed
with the uniform norm ∥· ∥:= supx∈Ω| · (x)|. We denote the
set of i-times continuously differentiable functions by Ci(Ω).
For convergence analysis, we also write a ≲b if there exists a
C > 0 (independent of a and b) such that a ≤Cb, particularly
when C is lengthy or its exact value is not necessarily required.
For the reader’s convenience, we also provide a partial list
of notations related to the technical details, which will be
explained later in the article.
- M: the number of sampled initial conditions;
- N: the number of dictionary observable test functions;
- Kt, L: the Koopman operator and infinitesimal generator;
- K, L: the matrix version of a Kt (with a fixed t) and the
L after data fitting, with dimension N × N;
- T: terminal observation instance for data collection;
- Ts: running time for performance verification;
- γ: observation/sampling frequency;
- Γ: number of snapshots for each trajectory during data
collection, which is equal to γT;
- τ: the sampling period, which is equal to 1/γ.
From Section IV to VII, we will frequently use notations
that represent approximations of certain quantities. We use
Qsup
sub to denote an approximation of quantity Q that depends
specifically on parameters appearing in the subscripts and
superscripts, and use eQ to denote an approximation of quantity
Q without emphasizing its dependent parameters.
II. PRELIMINARIES
A. Dynamical Systems
Given a pre-compact state space Ω⊆Rd, we consider a
continuous-time nonlinear dynamical system of the form
˙x = f(x),
(1)
where the vector field f : Ω→Ωis assumed to be locally
Lipschitz continuous.
Given an initial condition x0, on the maximal interval of
existence I ⊆[0, ∞), the unique forward flow map (solution
map) ϕ : I × Ω→Ωshould satisfy 1) ∂t(ϕ(t, x0)) =
f(ϕ(t, x0)), 2) ϕ(0, x0) = x0, and 3) ϕ(s, ϕ(t, x0)) = ϕ(t +
s, x0) for all t, s ∈I such that t + s ∈I.
Throughout the paper, we will assume that the maximal
interval of existence of the flow map to the initial value
problem (1) is I = [0, ∞).
Remark 2.1: The above assumption is equivalent to assum-
ing that the system exhibits forward invariance w.r.t. the set
Ω. However, this is usually not the case for general nonlinear
systems. In this paper, if the system dynamics violate the above
assumption, we can adopt the approach outlined in [28, Section
III.B] to recast the dynamics within the set Ω. In other words,
we constrain the vector field f such that f(x) = 0 for any
x ∈∂Ω, while f remains unchanged within the open domain
Ω. This modification ensures that the system data is always
collectible within Ω.
⋄
B. Koopman Operators and the Infinitesimal Generator
Let us now consider a complete normed function space
(F, ∥·∥F) of the real-valued observable functions1 h : Ω→R.
Definition 2.2: A
one-parameter
family
{St}t≥0
of
bounded linear operators from F into F is a semigroup if
1) S0 = I;
2) St ◦Ss = St+s for every t, s ≥0.
In addition, a semigroup {St}t≥0 is a C0-semigroup if
limt↓0 Sth = h for all h ∈F.
The (infinitesimal) generator A of {St}t≥0 is defined by
Ah(x) := lim
t↓0
Sth(x) −h(x)
t
,
(2)
where the observables are within the natural domain of A,
defined as dom(A) =

h ∈F : limt↓0 Sth−h
t
exists
	
.
⋄
It is a well-known result that dom(A) is dense in F, i.e.,
dom(A) = F.
The evolution of observables of system (1) restricted to F
is governed by the family of Koopman operators, as defined
below. Koopman operators also form a linear C0-semigroup,
allowing us to study nonlinear dynamics through the infinite-
dimensional lifted space of observable functions, which exhibit
linear dynamics.
Definition 2.3: The Koopman operator family {Kt}t≥0 of
system (1) is a collection of maps Kt : F →F defined by
Kth = h ◦ϕ(t, ·),
h ∈F
(3)
for each t ≥0, where ◦is the composition operator. The
generator L of {Kt}t≥0 is defined accordingly as in (2).
⋄
Due to the (local) Lipschitz continuity of f in (1), and
considering that observable functions are usually continuous,
we will focus on Kt : C(Ω) →C(Ω) for the rest of the paper.
For (1), there exist constants ω ≥0 and C ≥1 such that
∥Kt∥≤Ceωt for all t ≥0 [42, Theorem 1.2.2].
It can also be verified that C1(Ω) ⊆dom(L) ⊆C(Ω). In
general, dom(L) depends on the regularity and degeneracy
of f, as well as the geometry of the flow, which determine
whether f · ∇h (h ∈dom(L)) exists in a classical, weak,
or viscosity sense. For instance, h ∈dom(L) need not be
differentiable on E := {x ∈Rd : f(x) = 0} but it may be
C1 on Ω\ E with f · ∇h extending continuously to A. In the
extreme case f(x) ≡0, we have dom(L) = C(Ω).
For an unknown f, it is impossible to recover L on the
entire domain dom(L). We therefore restrict our attention to
a core of dom(L), based on the following concept.
Definition 2.4: Consider A : dom(A) ⊆F →F and B :
D ⊆F →F. We say that B admits a closure w.r.t. A, denoted
as B = A, if A|D = B and D = dom(A) w.r.t. the graph norm
of A. In this case, we also say that D is a core of A.
⋄
1We clarify that in the context of operator learning, the term “observable
functions,” or simply “observables,” commonly refers to “test functions” for
operators, rather than to the concept of “observability” in control systems.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


4
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
For F = C(Ω) endowed with the uniform norm ∥· ∥:=
supx∈Ω| · (x)|, the graph norm of L is naturally defined as
∥· ∥L := ∥· ∥+ ∥L(·)∥.
(4)
Then, by Proposition A.1, we have L|C1(Ω) = L, and C1(Ω) is
the core of L. For the remainder of the paper, we work with
C1(Ω)-class dictionary of observables, where approximation
on this core is effectively equivalent to approximation on the
full domain for the purpose of learning L with both approx-
imation guarantees and numerical tractability. Moreover, for
all h ∈C1(Ω) [5], the generator of the Koopman operators is
Lh(x) = ∇h(x) · f(x).
Definition 2.5: For operator learning, we define
ZN(x) := [z0(x), z1(x), · · · , zN−1(x)]T, N ∈N,
(5)
as the the vector of dictionary functions, where {zi} ⊆C1(Ω).
We denote by ZN := span{zi : i = 1, 2, · · · , N} the span of
dictionary functions.
For any linear operator B : C(Ω) →C(Ω), we adopt the
notational conventions B(D) := {Bh : h ∈D} for any D ⊆
C(Ω) and BZN(x) = [Bz0(x), Bz1(x), · · · , BzN−1(x)]T.
⋄
We make the standing assumption on the dictionary that
Z1 ⊆Z2 ⊆· · · and ∪n≥1ZN = C(Ω) to ensure density. De-
noting EN(h) := infv∈ZN ∥h −v∥as the best-approximation
error, then EN(h)
N→∞
−−−−→0 for any h ∈C(Ω).
Remark 2.6: In view of Koopman-based indirect approx-
imation of the generator, for each h ∈C1(Ω), we have
Kτh(x) −h(x) =
R τ
0 Lh(ϕ(s, x))ds ≈
R τ
0 Lh(ϕ(0, x))ds =
Lh(x)τ, where the approximation is achieved through a small
terminal time τ. Then, the derivative (of any h) along the
trajectory is approximated by Lh(x) ≈Kτ h(x)−h(x)
τ
. Note that
the finite-difference method (FDM) L ≈Kτ −I
τ
simply follows
(2) for sufficiently small τ > 0. Through this approximation
scheme of the time derivative, it can be anticipated that the
precision heavily depends on the size of τ [29], [31], [32]. We
will revisit the FDM in the numerical examples to compare it
with the method proposed in this paper.
⋄
C. Representation of Semigroups
In this subsection, we introduce basic operator topologies
and explore how a semigroup {St}t≥0 can be represented
through its generator A.
Definition 2.7 (Operator Topologies): Consider
Banach
spaces (V, ∥· ∥V) and (W, ∥· ∥W) Let B : V →W and
Bn : V →W, for each n ∈N, be linear operators.
1) The sequence {Bn}n∈N is said to converge to B uni-
formly, denoted by Bn →B, if limn→∞∥Bn −B∥= 0.
We also write B = limn→∞Bn.
2) The sequence {Bn}n∈N is said to converge to B strongly,
denoted by Bn ⇀B, if limn→∞∥Bnh −Bh∥W = 0 for
each h ∈V. We also write B = s- limn→∞Bn.
⋄
Remark 2.8: In analogy to the pointwise convergence of
functions, the strong topology is the coarsest topology such
that B 7→Bh is continuous in B for each fixed h ∈V.
⋄
If A is a bounded linear operator that generates {St},
then St = etA for each t in the uniform operator topology.
Otherwise, [42, Chap. I, Theorem 5.5] (also rephrased as
Theorem 2.10 in this paper) still provides an interpretation
for the sense in which St “equals” etA.
We revisit some facts to show the above concepts of
equivalence, particularly in the context where A is unbounded.
Definition 2.9 (Resolvents): Let A : dom(A) ⊆F →
F be a linear, not necessarily bounded, operator. Then the
resolvent set is defined as
ρ(A) :=
n
λ ∈C : λ I −A is bijective and (λ I −A)−1 is bounded
o
.
The resolvent operator is defined as
R(λ; A) := (λ I −A)−1, λ ∈ρ(A).
⋄
We further define the Yosida approximation of A as
Aλ := λAR(λ; A) = λ2R(λ; A) −λ I .
(6)
Note that R(λ; A)λ∈ρ(A) and {Aλ}λ∈ρ(A) are families of
bounded linear operators [42, Chap. I, Theorem 4.3], and etAλ
is well-defined for each λ ∈ρ(A).
The characterization of A as the infinitesimal generator of a
C0-semigroup is typically formulated in terms of conditions on
the resolvent of A, where A must be closed and ρ(A) ̸= ∅. We
also have the following theorem for semigroup approximation.
Theorem 2.10:
[42, Chap. I, Theorem 5.5] Suppose that
{St}t≥0 is a C0-semigroup on F and A is the generator. Then,
St = s- limλ→∞etAλ for all t ≥0.
III. THE CHARACTERIZATION OF THE INFINITESIMAL
GENERATORS
For system (1), we are able to represent Kt as etL for
bounded L, or, by Theorem 2.10, as the strong limit of etLλ,
where Lλ is the Yosida approximation of L.
For the converse representation of L based on {Kt}t≥0,
it is intuitive to take the operator logarithm such that L =
(log Kt)/t. When L is bounded, its spectrum’s sector should
be confined to make the logarithm a single-valued mapping
[38], [39]. However, for an unbounded L, there is no direct
connection L and {Kt}t≥0. In this subsection, we review how
L can be properly approximated based on {Kt}t≥0.
Recall that ∥Kt∥≤Ceωt for some ω ≥0 and C ≥1 for
all t ≥0. We first examine the classical Hille-Yosida theorem
[42, Theorem 3.1, Chapter I], where L is the strong limit of
the Yosida approximation:
s- lim
λ→∞Lλ = s- lim
λ→∞λ2R(λ; L) −λ I = L.
(7)
Although well established in the literature, to motivate
further developments and provide insight into how data-driven
approaches can be integrated into the approximation scheme,
we present the following theorem. The proof is provided in
Appendix D of the extended version [43] of this article.
Theorem 3.1: For system (1), consider {Lλ}λ>˜ω, where
˜ω ≥ω ≥0. Then, s- limλ→∞Lλ = L. Moreover, for any
h ∈C2(Ω),
∥Lλh −Lh∥≲(λ −˜ω)−1(∥h∥L + ∥Lh∥L).
Motivated by representing L by {Kt}t≥0 and the Yosida
approximation for L on {λ > ω}, we establish a connection
between R(λ; L) and {Kt}t≥0.
Proposition 3.2: Let R(λ) on C(Ω) be defined by
R(λ)h :=
Z ∞
0
e−λt(Kth)dt.
(8)
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
5
Then, for all λ > ω,
1) R(λ)(λ I −L)h = h for all h ∈dom(L);
2) (λ I −L)R(λ)h = h for all h ∈C(Ω).
The proof follows the standard procedures of calculus and
dynamic programming, and is completed in Appendix D-A of
[43].
The family of {R(λ)} serves as pseudo-resolvent operators.
It becomes a true resolvent family, i.e., satisfies the commuta-
tive property between R(λ) and λ I −L, only when the inverse
mapping of R(λ) is defined on its range dom(L) rather than
on the entire C(Ω).
Note that the pseudo-resolvent need not be a resolvent
for the restriction of L to a subdomain, not even for the
pre-generator L|C1(Ω). In particular, if L|C1(Ω) is not closed,
Proposition 3.2-2) (asserting surjectivity of λ I −L|C1(Ω)) may
fail; in that case one may at best have (λ I −L)(C1(Ω)) =
C(Ω). We illustrate this fact in Example 3.3.
Example 3.3: Consider system ˙x = −x3 on Ω= (−a, a)
for any a > 0, whose solution is given by ϕ(t, x) =
x
√
1+2tx2 .
It can be verified that C1(Ω) ⊊dom(L), with a counterexam-
ple given by the continuous function h(x) = |x|1/2, which lies
in dom(L) but not in C1(Ω). Indeed, Lh(x) = limt↓0
p
|x| ·
(1+2tx2)−1/4−1
t
= −|x|5/2
2
for all x ∈Ω.
Now, let g := (λ I −L)h ∈C(Ω). Then, by Proposition 3.2-
1), we have R(λ)g = h /∈C1(Ω). Hence (λ I −L|C1(Ω))R(λ)g
is not well defined, and Proposition 3.2-2) does not hold for
L|C1(Ω). This fact implies that L|C1(Ω) is not closed on C1(Ω),
and one cannot characterize (λI −L|C1(Ω))−1 via R(λ). Ac-
cordingly, ρ(L|C1(Ω)) = ∅; since if it is not, (λ I −L|C1(Ω))−1
is continuous for some λ, which implies that L|C1(Ω) is closed
and contradicts the discussion above.
⋄
Remark 3.4: Although R(λ) = (λ I −L)−1 from Propo-
sition 3.2, we do not attempt to learn L directly from this
inversion relationship with R(λ) in this paper. This contrasts
with [44] in the following ways. The approach in [44] consid-
ers stochastic systems and assumes the resolvent is compact,
implying a discrete spectrum. It also employs a Dirichlet-form
energy-based metric, which implicitly requires L to be self-
adjoint. Under these assumptions, L admits an exact spectral
decomposition sharing eigenfunctions {φi} with R(λ). Based
on this fact, if {βi} are the learned eigenvalues of R(λ), the
corresponding eigenvalues {αi} of L satisfy (λ −αi)−1φi ≈
βiφi.
While such assumptions are reasonable for stochastic sys-
tems (owing to the diffusion term), they are generally not met
for deterministic ODE systems (see also Section IV-B). At
best, one can approximate L strongly by a spectral decomposi-
tion restricted to a subdomain D ⊊dom(L). However, without
extra information about f, this restriction L|D (and hence its
approximation g
L|D) may fail to be closed [38], [45]. In the
same spirit as Example 3.3, it is dangerous to assume that the
resolvent of L|D exists and to represent (λ I −g
L|D)−1 by a
spurious eigen-decomposition, not to mention forcing the data
to match a supposed relation between the pseudo-resolvent
R(λ) and that spurious decomposition of (λ I −g
L|D)−1 for an
eigenvalue approximation as [44].
⋄
In light of Remark 3.4, where a strong-sense approximation
of L may not be feasible from the information in R(λ)
via direct inversion, we do not pursue this inverse strategy
and instead adopt the Yosida-type approximation, whose ex-
istence and boundedness are always guaranteed. To use the
approximation, we replace R(λ; L) with R(λ). We can then
immediately conclude the following representation.
Corollary 3.5: For each λ > ω,
Lλ = λ2
Z ∞
0
e−λtKtdt −λ I
(9)
and Lλ ⇀L on dom(L) as λ →∞.
The remainder of the paper builds on this Yosida-type
approximation (9) and the evaluation of R(λ) using Koopman-
related information in the integral to learn Lλ from data.
IV. KOOPMAN-BASED FINITE-DIMENSIONAL
APPROXIMATION OF RESOLVENT OPERATORS
The rest of the paper focuses on learning a bounded operator
R(λ) — and hence Lλ— using the dictionary of observable
functions ZN introduced in Definition 2.5. This process is
conceptually similar to the conventional Koopman learning
framework, and also resembles many recent works on learning
Koopman-related bounded operators, only if input data from
the domain and output data from the range are accessible.
To make the learning of Lλ effective, it is necessary to
preprocess the integral representation of R(λ) in (9). In this
section, we show that {R(λ)} can, in principle, be approxi-
mated by finite-rank operators, and the resulting form serves
as an “interface” for generating output data.
A. Finite Time-Horizon Approximation of the Resolvent
Observing the form of (9), we first define the following
truncation integral operator for R(λ).
Definition 4.1: For any h ∈C(Ω) and T ≥0, we define
Rλ,T : C(Ω) →C(Ω) as
Rλ,T h(x) :=
Z T
0
e−λsKsh(x)ds.
(10)
We aim to demonstrate that for any sufficiently large λ ∈
R, the aforementioned truncation of the integral will not
significantly “hurt” the accuracy of the approximation (9).
Theorem 4.2: Let T ≥0 and λ > ω be fixed. Then,
Etr(λ, T) := ∥λ2Rλ,T −λ I −Lλ∥≤Cλ2
λ−ωe−λT on dom(L).
Proof: Note that, for any λ > ω,
∥R(λ)∥≤
Z ∞
0
e−λt∥Kt∥dt ≤
Z ∞
0
Ce−λteωtdt =
C
λ −ω .
Therefore, for any h ∈C(Ω),
∥Rλ,T h −R(λ; L)h∥= sup
x∈Ω
|e−λT R(λ)h(ϕ(T, x))|
≤e−λT ∥R(λ)∥∥h∥≤e−λT
C
λ −ω ∥h∥
(11)
and sup∥h∥=1 ∥λ2Rλ,T h −λh −Lλh∥≤
Cλ2
λ−ωe−λT , which
completes the proof.
The truncation error Etr in Theorem 4.2 demonstrates an
exponential decaying rate as λ →∞for any fixed T > 0. We
also attempt to use a relatively small T to reduce the data size
for the integral evaluation, as seen in Section V.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


6
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
B. Finite-Rank Approximation of the Resolvent
In favor of a learning-based approach based on a dictionary
of a finite number of observable test functions serving as basis
functions, we verify if Rλ,T is representable as a finite-rank
operator. The proofs are completed in Appendix B.
We first look at the following property of Rλ,T .
Proposition 4.3: For any λ > ω, the operator Rλ,T is
compact if and only if Ks is compact for any s ∈(0, T].
It is worth noting that Kt of (1) is not necessarily compact
for each t > 0. To show that Kt(Br) ⊆C(Ω) is relatively
compact, where Br = {h ∈C(Ω) : ∥h∥≤r} for some
r > 0, one needs to verify the equicontinuity within Kt(Br).
However, this is not guaranteed. As a counterexample, we
set Ω:= (−1, 1), hn(x) = sin(nx) ∈B1 (or similarly, for
the Fourier basis), and define ϕ(t, x) = e−tx for all x ∈Ω.
Then, the sequence hn ◦ϕ(t, ·) for each t does not exhibit
equicontinuity due to the rapid oscillation as n increases.
For the purpose of approximating Lλ strongly, we aim to
find a compact approximation of {Kt}t>0 that enables a finite-
rank representation of Rλ,T in the same sense.
Proposition 4.4: Consider a smooth mollifier η ∈C∞
0 (Ω)
with compact support B(0; 1). For each ε > 0, let ηε(x) :=
1
εn η
  x
ε

with
R
Ωη(y)dy = 1. For all h ∈C(Ω) and ε > 0, set
Jεh(x) =
R
Ωηε(x−y)h(y)dy. Define Kε
t := JεKt. Then, for
each t > 0, {Kε
t}ε>0 is a family of compact linear operator
and satisfies Kε
t ⇀Kt on C(Ω) as ε →0. In addition, for
each t, s > 0, there exists a family of compact linear operator
{Kε
t}ε>0, such that Kε
t ◦Kε
s ⇀Kt◦Ks on h ∈C(Ω) as ε →0.
We omit the proof as it follows similar arguments presented
in [28, Section V.A]. Heuristically, the bump functions ηε
converge weakly to Dirac measures centered at their respective
flow locations, distributing point masses that {Kt} transports
along the trajectories. Taking advantage of the compactness
approximation, the following statement demonstrates the fea-
sibility of approximating Rλ,T by a finite-rank operator.
Corollary 4.5: For any fixed T > 0, for any arbitrarily
small δ
> 0, there exists a sufficiently large N and a
finite-dimensional approximation RN
λ,T such that ∥RN
λ,T h −
Rλ,T h∥< δ, h ∈C(Ω).
The following exemplifies the construction of a finite-rank
approximation using the dictionary functions (Definition 2.5).
Definition 4.6: Consider g ∈C(Ω) ⊂L2. We define
the Gram matrix ¯X of the dictionary functions as ¯Gi,j =
⟨zi, zj⟩L2, ¯Hg := ⟨ZN, g⟩L2, and the projection of g on to
ZN as ΠNg := ZN(x)T ¯G+ ¯Hg. For a bounded linear operator
B : C(Ω) →C(Ω), we define ΠNBZN(x)T = ZN(x)T ¯G+ ¯HB
with ¯HB =
R
ΩZN(y)(BZN(y))Tdy.
⋄
Remark 4.7: The fundamental properties of ΠN are pro-
vided in Appendix D of the the extended version [43]. Note
that it is common in the literature to construct KN
t
:= ΠNKt,
which is proved to satisfy ∥KN
t (·) −Kt(·)∥L2
N→∞
−−−−→0.
However, we cannot derive convergence w.r.t. the uniform
norm ∥· ∥from L2-convergence due to the possible lack
of compactness of Kt(ZN). Indeed, for any g ∈C(Ω), we
have ∥ΠNg −g∥≤(1 + ∥ΠN∥)|EN(g) by Lemma D.5
of [43]. Although EN(g) converges as assumed, obtaining
convergence of the r.h.s. is not straightforward if ∥ΠN∥is
not uniformly bounded.
Nonetheless, the analysis in Lemma B.1 offers an alternative
perspective. One can work with the compact operator family
{JεKt} and their finite-rank approximations Πε,NKt, which
ensures convergence w.r.t. the uniform norm as N ↑∞for any
fixed ε. Furthermore, Πε,NKt converges to ΠNKt as ε ↓0 for
any fixed N. Through this two-layer convergence, where ε can
be scheduled to go to 0 faster than the growth rate of ∥ΠN∥,
we obtain the desired convergence KN
t ⇀Kt w.r.t. ∥· ∥.
⋄
In view of the proof of Corollary 4.5 and Remark 4.7, the
finite-horizon finite-rank approximation RN
λ,T of R(λ) exists
and can be constructed by the same procedure as KN
t . Note
that KN
t
is also the limit of the EDMD data-driven version
as the number of samples tends to infinity. In this view, the
theoretical existence of the finite-rank form KN
t
(and hence
RN
λ,T ) also plays the role of a hypothetical interface for data-
driven computation.
V. QUADRATURE APPROXIMATION OF THE RESOLVENT
AND REFORMULATION OF Lλ
Building on the feasibility of the finite-horizon finite-rank
approximation RN
λ,T of R(λ) in Section IV, we investigate
how to reformulate Lλ when acting on the dictionary functions
ZN(x), so that a directly accessible form of the output can be
expressed in terms of the Koopman-related flow information.
A. Initial Attempt and Conflict with Practical Constraints
We attempt to directly work on the form λ2RN
λ,T −λ I
for sufficiently large λ to generate output evaluation for Lλ
within a small time horizon corresponding to all observables
[41]. The overall error consists of the analytical error of the
Yosida approximation (Theorem 3.1) and the truncation error
Etr (Theorem 4.2); the latter is exponentially faster compared
to the former, so its contribution is comparatively negligible
for sufficiently large λ. However, the output information re-
quires numerical quadrature, using discrete-time observations
of Koopman flow to approximate the integral of RN
λ,T .
Given the Laplace transform type integral, we employ the
Gauss–Legendre quadrature rule to secure accuracy, using
Γ = γT snapshots for each trajectory during data collection
under observation frequency γ. Although it is beyond the
scope of this work to evaluate the error bound of the quadrature
rule for different choices of dictionary functions, we exemplify
in Appendix D of [43] that, for the monomial basis with
maximal degree N, an estimate of the error bound is proved
to be EP ≲T 2Γ+1 
µ+NLf
8Γ2
2Γ
. Other choices of dictionary
functions follow a similar procedure and exhibit a similar
pattern of error bounds, but involve nontrivial analysis; a
detailed analysis is left for future work.
By the spirit of the above analysis, for larger λ under
a fixed small T > 0, the numerical integration requires a
larger Γ, which corresponds to a higher sampling frequency.
Conversely, if Γ is restrictive in practice (for example, in
automatic vehicles or intelligent transportation systems, where
sensors can collect state data at no more than γ = 100 [46]),
λ cannot be large to ensure accuracy when using numerical
integration.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
7
B. Modified Evaluation Structure
To resolve this conflict, we employ the first resolvent
identity [(λ −µ)R(µ) + I]R(λ) = R(µ), which connects
the two resolvent operators corresponding to λ and µ in the
resolvent set. This identity can be reformulated as
[(λ −µ)R(µ) + I]Lλh(x)
=λ2R(µ)h(x) −λ(λ −µ)R(µ)h(x) −λh(x)
=λµR(µ)h(x) −λh(x),
(12)
allowing us to learn a resolvent operator with a small µ (thus
enabling the use of a small Γ for numerical integration) and
then infer the Lλ with a large λ. The form of (12) requires
transferring the output of Lλ through (λ −µ)R(µ) + I and
matching it with the r.h.s., which again necessitates a prior
finite-horizon quadrature evaluation Rquad
µ,T of R(µ).
Remark 5.1: To enable learning via an analytical finite-
horizon finite-rank approximation LN
λ of Lλ, we first attempt
to follow the same spirit of Section IV-B and evaluate Lλ
via [(λ −µ)Rquad
µ,T + I]LN
λ h(x) = λµRquad
µ,T h(x) −λh(x). In
this formulation, both sides incur truncation error Etr and
quadrature error EP, with an additional projection error on
l.h.s., compared to (12). Note that the latter two errors can be
made sufficiently small with a suitable dictionary and small µ,
whereas the Etr may remain large due to the conflict between
choosing small T and small µ.
⋄
In view of Remark 5.1, directly replacing R(µ) with Rquad
µ,T
in (12) may cause significant truncation error. To keep the
quadrature error small by using appropriately small T, Γ, and
µ while simultaneously reducing truncation error, we proceed
with the following fact for a further modification.
Proposition 5.2: For any h ∈C(Ω) and a fixed T > 0, we
have R(µ)h(x) = Rµ,T h(x)+e−µT KT R(µ)h(x). Moreover,
by defining operator Th as Th(·) = Rµ,T h + e−µT KT (·), it
possesses the contraction mapping property.
We then evaluate R(µ)zi by using an ansatz ZT
Nζi ∈ZN,
where ζi is determined by plugging the ansatz into the above
equation. The solvability is established as follows.
Lemma 5.3: Recall ΠN from Definition 4.6. For a fixed
T > 0, let KN
T = ΠNKT . For each zi ∈ZN, let Vi(x) =
R(µ)zi(x), let Ei
N(x) := KN
T Vi(x) −KT Vi(x), and denote
Emax
N
:= maxi ∥Ei
N∥. Then, there is ˜ω such that ˜ω ≲ω+Emax
N ;
and for all µ ∈(˜ω, ∞), there is a unique solution V N
i
=
ZT
Nζi ∈ZN to V N
i (x) = Rquad
µ,T zi(x) + e−µT KN
T V N
i (x).
Furthermore, ∥V N
i
−Vi∥≲EP + Emax
N .
The above statement provides a way to evaluate R(µ)ZN(x)
via V N(x) := [V N
i (x), i ∈{0, 1, · · · , N −1}]T, and, equiva-
lently, yields a finite-rank representation of R(µ) given by
RN
µ ZN(x) = V N(x) = ZN(x)T[ζ0, ζ1, · · · , ζN−1]T.
(13)
It is clear that the approximation error depends continuously
on maxi ∥V N
i
−Vi∥. Unlike RN
µ,T , the construction of RN
µ
eliminates Etr and does not produce large errors for well-
chosen small values of µ, Γ, and T. We next build on RN
µ to
obtain a finite-rank approximation of Lλ based on (12).
Theorem 5.4: Let b
A := (λ−µ)RN
µ +I and bB := λµRN
µ −
λ I. Let ¯G, ¯H b
A, and ¯H b
B be defined as in Definition 4.6. Let
ˆA = ¯G+ ¯H b
A, ˆB = ¯G+ ¯H b
B, and ˆA+
δ = ( ˆAT ˆA + δ I)−1 ˆAT for
any δ > 0. Define ˆLλ := ˆA
+
δ ˆB and LN
λ hθ = ZN(x)T ˆLλθ for
any hθ = ZN(x)Tθ ∈ZN. For EA := EP + Emax
N
< 1, there
exists a δ = O(E1/3
A ) and a projection residual EΠ
N
N→∞
−−−−→0
such that ∥LN
λ hθ −Lλhθ∥≲EΠ
N + E1/3
A .
Remark 5.5: In fact, the proof also implies that for any
fixed δ > 0, the 1/3-H¨older bound improves to a linear bound.
The above analysis provides only a worst-case heuristic for
tuning δ, since the rank of ˆA may fail to be preserved as
N →∞and errors vanish. In the ideal case where this issue
does not arise, one can use
LN
λ hθ = ZN(x)T ˆLλθ,
ˆLλ := ˆA+ ˆB, hθ = ZN(x)Tθ
(14)
and perform a perturbation analysis [47] directly on it, in
which case the convergence rate becomes linear as well. We
omit the proof because of repetition. To better convey the key
idea of the learning procedure, the rest of this paper uses the
formula (14) for simplicity. Readers should be aware that a δ-
regularization is required to guarantee worst-case theoretical
convergence when
ˆA is rank-deficient. However, it is not
always necessary in practice, as demonstrated by data-driven
numerical experiments that exhibit ideal convergence behavior
even without the regularization.
⋄
We have reprocessed R(µ) with improved evaluation preci-
sion in order to adapt to the reformulation (12). The resulting
formula (14) serves as a direct interface for generating training
data, ensuring that the learning of Lλ remains effective even
under sampling-frequency constraints.
VI. DATA-DRIVEN ALGORITHM
We continue to discuss the data-driven learning based on
the approximations discussed in Section IV and V. Similar
to the learning of Koopman-related operators [28], [35], [38],
[41], [48], it suffices to estimate ˆLλ (defined with respect to
the matrix-valued L2-inner product) from (14) using a Monte
Carlo–style data-driven integration Lλ based on sampled ini-
tial conditions {x(m)}M−1
m=0 ⊆Ωof (1). The convergence of
Lλ to ˆLλ is identical to [48] as M →∞, and we do not
repeat the analysis. Consequently, for sufficiently large λ and
any hθ ∈ZN (i.e. hθ(x) = ZN(x)T θ with some vector θ),
Lhθ(·) ≈Lλhθ ≈LN
λ hθ(·) ≈ZN(·)T(Lλθ).
(15)
In this section, we present the procedure for obtaining Lλ.
Remark 6.1: Denoting eLhθ(x) := ZN(x)T(Lλθ), the ap-
proximation in (15) also guarantee the convergence of {et e
L}
to the original semigroup {Kt}t≥0 for any hθ(x) = ZN(x)Tθ.
Indeed, letting O = eL −Lλ, we have
∥et e
Lhθ −Kthθ∥
≤∥etO∥∥etLλhθ −Kthθ∥+ ∥Kt∥∥etOhθ −hθ∥
≤∥etO∥∥etLλhθ −Kthθ∥+ t∥Kt∥et∥O∥∥Ohθ∥.
(16)
As λ →∞, the first part goes to 0 by Theorem 2.10. The
second part goes to 0 by the sequence of approximations (in
a strong sense) in (15).
⋄
A. Data Collection, Pre-processing, and the Algorithm
The training data is obtained in the following way.
1) Features data: By randomly sampling M initial condi-
tions {x(m)}M−1
m=0 ⊆Ω, we stack the features into X:
X = [ZN(x(0)), ZN(x(1)), · · · , ZN(x(M−1))]T.
(17)
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


8
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
2) Numerical integration: Now, fix a T. For any fixed µ > 0
and each x(m), we use discrete-time observations (snapshots)
of Koopman flow zi(ϕ(t, x(m))) to approximate Rµ,Tzi using
numerical quadrature techniques. Recall the observation rate
of γ over the interval [0, T] for each flow map ϕ(·, x(m)), and
the number of snapshots as Γ := γT. We stack the snapshot
data of the integrand in the following intermediate matrix:
U(m) = [ZN(ϕ(0, x(m))), · · · , e−µkT
Γ ZN(ϕ(kT
Γ , x(m))),
· · · e−µT ZN(ϕ(T, x(m)))]T, m ∈{0, 1, · · · , M −1}.
(18)
Denote by Gλ
[0,T ](v), or G(v) for brevity, the Gauss–Legendre
quadrature2 based on the vector of snapshot points v within
[0, T], and denote by U (m)[:, j] the jth column of U (m). The
stack of Rquad
µ,T ZN(x(m)) is given by
Iquad
µ,T =


G(U(0)[:, 0])
· · ·
G(U(0)[:, N −1])
...
...
...
G(U(m)[:, 0])
· · ·
G(U(m)[:, N −1])
...
...
...
G(U(M−1)[:, 0])
· · ·
G(U(M−1)[:, N −1])


. (19)
3) Estimation of RNµ: We then infer RN
µ ZN from Rquad
µ,T ZN
by Lemma 5.3, which relies on using ansatz RN
µ zi := ZT
Nζi to
solve RN
µ zi−e−µT KT RN
µ zi = Rquad
µ,T zi for all zi. Equivalently,
the stacked form of these equations evaluated at {x(m)} is
given by XΞ −e−µT ΦT Ξ = Iquad
µ,T , where
ΦT := [ZN(ϕ(T, x(0))), · · · , ZN(ϕ(T, x(M−1)))]T
(20)
and Ξ ∈RN×N is the stack of weights ζi with the solution
given by Ξ = (X −e−µT ΦT )+Iquad
µ,T . The stack of RN
µ ZN
evaluated at {x(m)} is then given by XΞ.
4) Final inference of Lλ: We follow Theorem 5.4 and (14)
to construct the stacks for ˆA and ˆB. As in Theorem 5.4, the
valuation of b
A and bB at {x(m)} is such that
YA = (λ −µ)XΞ + X and YB = λµXΞ −λX,
(21)
respectively.
Let
A
=
 XTX
+ XTYA
and
B
=
 XTX
+ XTYB, then ˆA and ˆB are the limits of A and B
as M →∞, following the same argument as in [48]. Then,
Lλ = A+B as required.
5) Summary of algorithm: A summary of the algorithm for
computing Lλ is provided in Algorithm 1.
B. Discussion of Other Existing Methods
Recall Remark 2.6 on the FDM with an expression Kτ −I
τ
⇀
L, where the convergence is well studied in [29]. We also
revisit the benchmark Koopman Logarithm Method (KLM)
based on the expression L = 1
τ log(Kτ), as described in [35].
In this subsection, we discuss the data-driven algorithms for
FDM and KLM, in preparation for the comparison in the case
studies in Section VII.
Observing that the expressions for L in FDM and KLM rely
on just one moment of the Koopman operator Kτ, the data-
driven versions of these methods are divided into two steps: 1)
2We omit the details of implementing the Gauss–Legendre quadrature
numerically, as the algorithms are well-established in this field.
Algorithm 1 Resolvent-Type Koopman Generator Learning
Require: Dictionary ZN, user-defined µ and λ, initial condi-
tions {x(m)}M−1
m=0 ⊆Ω, T, Γ, and snapshots ϕ( kT
Γ , x(m))
for k = 0, 1, . . . , Γ.
1: Compute and stack X using (17);
2: Compute and stack U (m) using (18);
3: Compute and stack Rquad
µ,T ZN(x(m)) using Iquad
µ,T by (19);
4: Stack ΦT using (20);
5: Compute Ξ = (X −e−µT ΦT )+Iquad
µ,T
6: Compute matrices YA and YB using (21);
7: Compute A =
 XTX
+ XTYA, B =
 XTX
+ XTYB.
8: return Lλ = A+B
learning Kτ; 2) transforming the learned Kτ to L, respectively.
To make the sampling rate consistent with the RTM, we set
τ := T/Γ. The corresponding data-driven approximations also
rely on the selection of a discrete dictionary ZN, and similarly,
the approximation is to achieve Lhθ(·) ≈ZN(·)(Liθ) for
hθ(x) = ZN(x)θ and for any i ∈{FDM, KLM}. To do this,
we fix a τ, stack the features into X the same way as (17),
and and stack the labels Φτ same as (20). After obtaining the
training data (X, Φτ), we can find K (the fully discretized
version of Kτ) by K = argminA∈CN×N ∥Φτ −XA∥F =
 XTX
+ XTΦτ [48]. The data-driven approximation for L
based on FDM and KLM are immediately obtained using K.
1) FDM: LFDM = (K −I)/τ, where I = IN×N is the
identity matrix in this expression.
2) KLM: LKLM = log(K)/τ.
It is worth noting that, even when L can be repre-
sented by (log Kτ)/τ, we cannot guarantee that log Kτ
τ
h(·) ≈
ZN(·)( log(K)
τ
θ) as in KLM, not to mention the case where
the above logarithm representation does not hold. As pointed
out in [41, Remark 4.1], even though the (possibly complex-
valued) matrix connecting Koopman eigenfunctions and dic-
tionary functions ensures that any Koopman representation
using ZN can be equivalently expressed in terms of eigenfunc-
tions with cancellation of the imaginary parts, this cancellation
effect generally does not hold when applying the matrix
logarithm. An exception occurs only when the chosen dictio-
nary is inherently rotation-free w.r.t. the true eigenfunctions
[38], or when there is direct access to data for log(Kτ) that
allows direct training of the matrix. Such conditions, however,
contradict our objective of leveraging Koopman data to infer
the generator.
In comparison, the FDM and the resolvent-type approach
approximate L regardless of its boundedness. These two
methods enable learning of L without computing the loga-
rithm, thus avoiding the potential occurrence of imaginary
parts caused by basis rotation. However, as we will see in
Section VII, the performance of the FDM degrades as the
sampling frequency decreases.
VII. CASE STUDIES
In this section, we test the effectiveness of the RTM method
and compare its performance to the two benchmark methods,
FDM and KLM. Particularly, we present numerical examples
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
9
that apply the learned generator for system identification3 and
effectively solve transport-related PDEs. The research code
can be found at https://github.com/RuikunZhou/Resolvent-
Type-Operator-Learning.
We provide two measurements to demonstrate the error in
system identification.
(1) The root mean squared error (RMSE) of flow
EF
RMSE = 1
M
M−1
X
m=0
v
u
u
t 1
Γs
Γs
X
k=1
|ϕ(tk, x(m)) −ˆϕ(tk, x(m))|2 (22)
measures the root mean square difference between the actual
time-series data {ϕ(tk, x(m))}Γs
k=0 and the estimated data
{ˆϕ(tk, x(m))}Γs
k=0 using the learned generator up to time Ts.
Here, Γs represents the number of snapshots used to verify
the performance (which is independent of Γ, used for the data
collection procedure), and the time tk = kTs/Γs corresponds
to the sampling instances.
(2) For polynomial models, and if we use monomial dictio-
nary functions, we can use the RMSE of the weights assigned
to each monomial
EW
RMSE :=
v
u
u
t 1
dN
d
X
j=1
N−1
X
k=0
|θj
k −ˆθj
k|2.
(23)
Here, N is the size the dictionary; d is the dimension of the
system; θj
k is the weight for fj at the kth dictionary function;
ˆθj
k is similarly defined but for the estimated vector field.
For the reader’s attention: The authors conducted more
experiments than could reasonably be included in this paper,
all of which demonstrated strong performance compared to
other methods. Only the most representative results are shown
in the main text, with the remaining results provided in
Appendix E of the extended version [43] of this article.
A. Scaled Lorenz-63 System
We first consider the system identification of Lorenz-63
system [49] by scaling it with a factor of ϵ, which yields
˙x1 = σ(x2 −ϵx1),
˙x2 = x1(γ −x3) −ϵx2,
˙x3 = x1x2 −ϵβx3,
where σ = 10, γ = 0.28, β = 8
3, and ϵ = 0.1. With this so-
called ϵ−Lorenz system, the system possesses an attractor on
Ω= (−1, 1)3. We choose the dictionary of monomials with
total number of N = P × Q × J and set zi(x) = xp
1xq
2xj
3,
where p = i −PQj −Pq, q = ⌊i−P Qj
P
⌋, and j = ⌊
i
P Q⌋.
The actual vector field is f(x) := [f1(x), f2(x), f3(x)]T =
[σ(x2 −ϵx1), x1(γ −x3) −ϵx2, x1x2 −ϵβx3]T, and one can
analytically establish that f1 = Lz1, f2 = LzP, and f3 =
LzP +Q. After learning the generator, we use the approximation
[ eLz1, eLzP, eLzP +Q]T to conversely obtain f.
3The primary purpose of the proposed method is Koopman generator learn-
ing, and the fairest comparison is against other Koopman-related methods.
Regarding system identification using the learned generator, we acknowledge
that Koopman-generator-based approaches for this purpose are still in the
early stages of development. Nevertheless, we include comparisons with the
more mature methods SINDy/WSINDy to demonstrate the potential of our
proposed approach in this setting.
Remark 7.1: The original system (as studied in [35]) has
the vector field ˆf(x) = [σ(x2 −x1), x1(γ −x3) −x2, x1x2 −
βx3]T. Denoting the solution to the original Lorenz model
as ˆx, it can be verified that ˆx1(t) = (1/ϵ)x1(ϵt), ˆx2(t) =
(1/ϵ2)x2(ϵt), and ˆx3(t) = (1/ϵ2)x3(ϵt). Let bL be the gener-
ator of the original system, one can also verify that bL = ϵL.
It is worth noting that the scaling with ϵ > 0 does not affect
the topological stability.
⋄
We choose to use the scaled system to facilitate the pre-
diction of long-term errors in the original unscaled chaotic
system within a smaller region of interest and over a short
dimensionless observation horizon. Specifically, due to the
nature of chaotic systems, two trajectories starting very close
together will rapidly diverge from each other, resulting in
completely different long-term behaviors. The practical im-
plication is that long-term prediction becomes impossible in
such a system, where small errors are amplified extremely
quickly. Such a two-point motion divergence phenomenon can
be roughly characterized by the maximal Lyapunov exponent
ϱ > 0 [50] and quantitatively expressed by E(t) ≈E(0)eϱt,
where the process {E(t)}t≥0 represents the evolution of error
w.r.t. any initial condition. Suppose we now consider the
original unscaled system (as studied in [35]), and denote
bE(t) as the unscaled error. Then, in view of Remark 7.1
on the relation between the solutions of the original and
scaled systems, one can obtain |bE(t/ϵ)| ≥|E(t)|/ϵ. Learning
the scaled system with the same sampling frequency γ and
simulating trajectories up to time Ts allows us to infer the
unscaled system’s error at Ts/ϵ (at least 1/ϵ times larger)
without actually running the unscaled system for that long.
This technique also avoids misleading demonstrations where
the original system is simulated only up to a seemingly large
time horizon, before significant error growth occurs, giving a
falsely optimistic impression of performance.
In this case study, we set P = Q = J = 2 (or N = 23).
We also set µ = 2.5, λ = 1e8, and T = 1 for RTM. The
comparisons for RMSE of weights and flow are summarized
in Table I. Fig. 1 depicts the comparison of the trajectory
for Ts = 100 using the approximated dynamics with RTM
(γ = 100) and ground truth for an initial condition sampled in
Ω, while the comparisons for the ones with KLM and FDM
are included in Fig. 2. Given that the error grows exponentially
w.r.t. the top Lyapunov exponent, it is evident that the flow
prediction using the dynamics approximated by RTM is highly
accurate, successfully exhibiting the attractor (a long-term
behavior) for this chaotic system, while the other two methods
struggle to predict the trajectory effectively.
B. Polynomial Systems
This subsection presents case studies on the system iden-
tification of polynomial systems, with a comprehensive com-
parison among Koopman-based methods and the well-matured
SINDy approach. We revisit the scaled Lorenz–63 system and
include two additional representative systems, the reversed Van
der Pol oscillator
˙x1 = −x2,
˙x2 = x1 −(1 −x2
1)x2
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


10
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
Fig. 1.
Comparison of the trajectory using RTM with the ground truth
for the scaled Lorenz-63 system, where the blue star denotes the initial
condition.
Fig. 2.
Comparison of the trajectories using KLM and FDM with
the ground truth for the scaled Lorenz-63 system, where the blue star
denotes the initial condition.
and the (unscaled) Lorenz–96 system
˙xj = −xj−2xj−1 + xj−1xj+1 −xj + 0.1, j ∈{0, 1, · · · , 6}.
To ensure a fair comparison, we also present a sparse variant
of RTM, referred to as Sparse RTM (SRTM), by enforcing
sparsity in the same manner as in SINDy, namely, using
sequential thresholded least squares on a given validation
dataset to promote sparsity in the learned weights.
We investigate the performance of the methods under γ =
10, 50, 100, set Ω= (−1, 1)d, and use monomial dictionary
functions. For RTM and SRTM, we set T = 1, λ = 1e8 and set
µ = 2.5 for all three sampling rates γ. Detailed comparisons
with the other two methods are provided in Table I.
For all polynomial systems considered, the results show
that RTM and SRTM achieve higher accuracy than KLM and
FDM in both weight estimation and flow prediction. Moreover,
all three Koopman-based methods improve as the sampling
rate increases, with FDM exhibiting the slowest improve-
ment. Regarding SINDy, the results indicate that although
it performs well for low-dimensional polynomial systems,
Koopman-based methods, especially RTM/SRTM, consistently
outperform it in high-dimensional nonlinear systems such
as Lorenz–96, providing superior accuracy in both weight
estimation and flow prediction.
C. 7-D Biochemical System
In this subsection, we investigate a 7-dimensional biochem-
ical system modeling yeast glycolytic oscillations [51], which
has become a standard benchmark for system identification
tasks. It was examined in [21, Appendix B, Supporting Infor-
mation] as a failure case for SINDy. Here, we slightly modify
the ˙S1 term to ensure that the state space remains invariant and
satisfies the assumptions required by the Koopman framework:
˙S1 = kex (Gex −S1) −k1 S1 S6/(1 + (S6/K1
q),
˙S2 = 2 v1 −k2S2(N −S5) −k6S2S5,
˙S3 = k2S2(N −S5) −k3S3(A −S6),
˙S4 = k3S3(A −S6) −k4S4S5 −κ (S4 −S7),
˙S5 = k2S2(N −S5) −k4S4S5 −k6S2S5,
˙S6 = −2 v1 + 2 k2S3(A −S6) −k5S6,
˙S7 = ψ κ (S4 −S7) −k S7.
The values of the parameters are reported in Table II. In this
case, we use monomials up to order 2, resulting in N = 36
dictionary functions. The list of the monomials can be found
in [21, Appendix B]. We salso ample M = 77 initial points
randomly across Ω= (0, 0.5)7. The parameter µ is set to 2,
and λ = 1e8 for RTM. Table III presents the results alongside
comparisons with the two Koopman-based methods, SINDy,
and its variant in a weak formulation, Weak SINDy (WSINDy)
[52].
RTM overall outperforms the other four methods in terms
of the RMSE of flow. KLM produces imaginary parts, a phe-
nomenon discussed in Section VI-B, even though the error ap-
pears small if only the real part is considered. SINDy/WSINDy
fail to produce meaningful regression results for this high-
dimensional system. The weights learned by SINDy lead to
numerical instability and computational blow-up, consistent
with the limitations reported in the original literature.
D. Rational Vector Fields
Consider a system with nonpolynomial vector fields:
˙x1 = −x1 +
4x2
1 + x2
2
,
˙x2 = −x2 −
4x1
1 + x2
2
.
1) Monomial dictionary functions: We first choose monomi-
als Qd
i=1 xαi
i
as the dictionary functions and evaluate their
performance, highlighting that even when a sparse represen-
tation with monomial dictionary functions fails, the proposed
RTM still yields lower errors. The parameter values for RTM
are the same as those used in the previous cases. Unlike
polynomial systems, where a relatively low order of mono-
mials is sufficient, non-polynomial systems often require a
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
11
TABLE I
COMPARISONS OF RMSE OF WEIGHTS AND FLOW OVER 100 TRAJECTORIES FOR THE THREE POLYNOMIAL SYSTEMS
System
M
N
γ
RMSE of weights (EW
RMSE)
RMSE of flow (EF
RMSE)
SINDy
FDM
KLM
RTM
SRTM
SINDy
FDM
KLM
RTM
SRTM
Reversed Van der Pol
102
9
10
1.26e-4
3.52e-2
5.53e-4
3.43e-5
3.20e-5
2.47e-5
1.96e-2
9.51e-5
2.04e-5
1.85e-5
50
1.15e-7
7.08e-3
2.22e-5
1.88e-8
1.22e-8
2.56e-8
4.01e-3
3.65e-6
7.27e-9
5.51e-9
100
6.53e-9
3.54e-3
6.41e-6
6.23e-9
5.54e-9
1.54e-9
1.83e-3
1.07e-6
3.37e-9
2.34e-9
Scaled Lorenz-63
(3-dimensional)
103
8
10
2.45e-4
1.82e-1
6.99e-3
1.74e-3
1.43e-3
1.05e-3
2.32e-1
1.12e-2
1.47e-3
1.18e-3
50
3.92e-7
3.81e-2
2.85e-4
3.67e-7
1.76e-7
1.43e-6
4.32e-2
4.78e-4
3.12e-7
2.32e-7
100
2.49e-8
1.92e-2
7.11e-5
2.49e-8
1.52e-8
8.62e-8
2.31e-2
1.18e-4
4.42e-8
2.48e-8
Lorenz-96
(6-dimensional)
56
64
10
3.03e-1
2.18e-2
3.03e-4
7.51e-5
4.01e-5
3.31e-1
2.96e-2
3.29e-4
6.40e-5
5.63e-5
50
2.74e-1
4.63e-3
1.17e-5
1.84e-8
6.63e-9
3.60e-1
6.08e-3
1.42e-5
1.71e-8
1.58e-8
100
2.89e-1
2.33e-3
2.92e-6
3.64e-9
3.41e-9
3.74e-1
3.05e-3
3.60e-6
4.69e-9
4.68e-9
TABLE II
YEAST GLYCOLYSIS MODEL PARAMETERS FOR THE MODIFIED SYSTEM
Parameter
Value
Parameter
Value
Parameter
Value
kex
0.5
Gex
0.5
k1
100
k2
6
k3
16
k4
100
k5
1.28
k6
12
k
1.8
κ
13
q
4
K1
0.52
ψ
0.1
N
1.0
A
4.0
TABLE III
COMPARISONS OF RMSE OF FLOW OVER 100 TRAJECTORIES FOR THE
7-DIMENSIONAL BIOCHEMICAL SYSTEM USING MONOMIALS
γ
RMSE of flow (EF
RMSE)
SINDy
WSINDy
FDM
KLM
(Re)
KLM
(Im)
RTM
10
-
-
8.69e-2
2.63e-2
9.39e2
3.35e-2
50
-
-
3.78e-2
3.31e-2
7.58e-1
2.13e-2
100
1.16e4
2.02e2
3.35e-2
4.18e-2
7.58e-1
2.33e-2
larger N for better approximation accuracy. However, high-
order polynomial regression can lead to numerical instability
or even computational blow-up due to regression error. To
address this dilemma, we employ two monomial sets for
the case studies: the first set contains N = 10 monomials
with
Pd
i=1 αi ≤3, while the second set includes N = 15
monomials with Pd
i=1 αi ≤4 . We randomly sample M = 102
initial points within Ω= (−1, 1)2. We also set T = 1,
µ = 3.5, and λ = 1e8 for RTM. The results are summarized
in Table IV. It is evident that RTM overall outperforms the
other four methods in terms of RMSE of flow.
TABLE IV
COMPARISONS OF RMSE OF FLOW OVER 100 TRAJECTORIES FOR THE
RATIONAL DYNAMICAL SYSTEM USING MONOMIALS
N
γ
RMSE of flow (EF
RMSE)
SINDy
WSINDy
FDM
KLM
(Re)
KLM
(Im)
RTM
10
10
1.22e-1
3.14e-2
1.12e-1
1.41e-2
7.86e-1
1.39e-2
50
2.76e-1
1.85e-2
3.00e-2
1.41e-2
7.77e-1
1.39e-2
100
3.28e-1
2.05e-2
2.01e-2
1.43e-2
7.77e-1
1.57e-2
15
10
1.05e-1
4.73e-2
1.08e-1
1.37e-2
7.43e-1
1.36e-2
50
4.45e-1
6.78e-2
3.10e-2
1.49e-2
7.93e-1
1.46e-2
100
4.90e-1
1.35e-1
2.02e-2
1.44e-2
7.43e-1
1.36e-2
2) Random tanh-feature dictionary: For this nonpolynomial
system, as shown in [38], the previously mentioned dilemma of
inefficient dictionary functions and potential regression error
blow-up caused by high-order monomials can be mitigated
by including terms of the form {
xi
1+xp
j } in the dictionary,
which enables exact model identification. However, this prior
knowledge is typically not accessible for most nonlinear
systems in practice. To reduce the bias in selecting dictionary
functions, we utilize the less biased hidden layers of random
feature neural networks (NNs) as the dictionary functions.
Remark 7.2 (Related Work): In the context of Koopman
operator learning, a Koopman autoencoder neural network
has been proposed to improve approximation performance,
seeking K
= argminA∈CN×N ∥Z −XA∥. However, for
deep neural network dictionaries, a closed-form solution is
not available, and training can be computationally expensive.
In contrast, it has been shown that shallow tanh-activated
neural networks can approximate functions as well as, or
better than, deeper ReLU networks, with error decreasing
as the number of hidden neurons increases. Their expressive
power has also been demonstrated in solving first-order linear
PDEs. Motivated by these results, we leverage this expressive
feature by using shallow tanh-activated neural networks as the
dictionary functions, achieving the linear combination effect of
the test and image functions of the learned operator.
⋄
By choosing tanh as the activation function, the dictionary
of observable functions mainly consists of tanh(xW T + bT),
where W ∈Rσ×d and b ∈Rσ are the randomly generated
weight and bias of the first layer, respectively, and tanh is
applied elementwise. To obtain the expressions of the vector
fields, we also need to add {xj}d
j=1 to the dictionary (recall
that Lxj = fj). All together, the dictionary ZN(x) consists
of σ random feature neural networks appended by {xj}d
j=1,
with a total of N = σ + d elements.
We use the same parameter settings for RTM as in the
cases studied with the monomial dictionary functions. As we
cannot compare the RMSE of weights in this case, the compar-
isons of RMSE of flow with three difference frequencies are
summarized in Table V. It is worth noting that for N = 52
and γ = 10, KLM fails to produce meaningful results, as
the trajectory of the approximated dynamics diverges. This is
again attributed to the fact that taking the logarithm of the
matrix K (as discussed in Section VI-B) leads to undesirable
results. On the other hand, RTM consistently outperforms the
other methods overall.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


12
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
E. Two-Machine Power System
Consider the two-machine power system [7] modeled by
˙x1 = x2, ˙x2 = −0.5x2 −(sin(x1 + π/3) −sin(π/3)).
Since the vector field consists of polynomial and periodic
terms, using monomial approximations appears to be local and
may not be satisfactory. We continue to use random feature
NNs as the dictionary functions.
We sampled M
= 102 initial points randomly across
Ω= (−1, 1)2 with T = 1. For RTM, we set λ = 1e8 and
µ = 2.5 for all sampling frequencies. As shown in Table V,
RTM consistently outperforms FDM and KLM across nearly
all configurations of the two-machine power system. Similar
to the previous case study, when using tanh neural networks,
taking the matrix logarithm of the learned Koopman matrix
K introduces non-negligible imaginary parts. The trajectories
generated by all three methods remain close to the ground truth
for N = 22 with γ = 100. However, when N is increased
to 102, the performance of both FDM and KLM deteriorates
(particularly KLM) as shown in Fig. 3. These results indicate
that when prior knowledge of the underlying system is lacking
and monomial dictionary functions may not be suitable, which
motivates the use of tanh-activated random bases as dictionary
functions, both FDM and KLM may struggle to produce
accurate results in system identification, whereas RTM is more
robust in this regard.
TABLE V
COMPARISON OF RMSE OF FLOW OVER 100 TRAJECTORIES FOR TWO
BENCHMARK SYSTEMS USING tanh-ACTIVATED NEURAL NETWORKS.
System
N
γ
RMSE of flow (EF
RMSE)
FDM
KLM
(Re)
KLM
(Im)
RTM
Rational
22
10
7.27e-2
3.08e-3
7.78e-1
2.64e-3
50
1.81e-2
2.47e-3
7.78e-1
2.22e-3
100
8.90e-3
2.85e-3
7.80e-1
2.52e-3
52
10
1.08e-1
-
1.78e36
6.72e-2
50
2.42e-2
3.96e-2
7.90e-1
9.37e-4
100
1.74e-2
1.10e-1
8.32e-1
9.19e-4
102
10
1.01e-1
1.43
2.60e39
5.48e-3
50
2.64e-2
9.05e-2
7.40e-1
9.33e-5
100
1.68e-2
2.12e-1
7.75e-1
6.18e-4
Two-machine
22
10
1.13e-2
1.00e-3
7.80e-1
1.06e-3
50
2.56e-3
1.01e-3
7.84e-1
1.09e-3
100
1.70e-3
1.03e-3
7.82e-1
1.05e-3
52
10
1.10e-2
3.77e-3
7.76e-1
1.47e-4
50
4.60e-3
2.32e-2
7.63e-1
1.07e-5
100
7.75e-3
1.11e-2
7.63e-1
1.07e-5
102
10
1.18e-2
1.16e-2
7.73e-1
1.56e-4
50
5.13e-3
8.36e-2
8.11e-1
8.08e-6
100
2.12e-2
1.83e-1
8.04e-1
6.64e-6
Fig. 3. Comparisons of the trajectories with the approximated dynamics
using three different methods and ground truth for the two-machine
power system.
F. Prediction of Region of Attraction
In this subsection, we demonstrate that both the dataset
and dictionary functions can be reused to predict the region
of attraction (RoA) D of an equilibrium point xeq for the
system4. For simplicity, we can assume that the system has an
equilibrium point at the origin.
The methodology involves using the learned generator to
solve a Zubov’s equation of the form
Lu(x) = −α|x −xeq|2(1 −u(x)), α > 0.
(24)
The solution should have the following properties: 1) 0 <
u(x) < 1 for all x ∈D \ {xeq}, and 2) u(x) →1 as x →y
for any y ∈∂D. Therefore, the set {x ∈Rn : u(x) < 1} can
readily represent the RoA. Moreover, for any approximator
eu of u such that |eu −u|∞≤ε, one can show that the set
{x : eu(x) ≤1−ε} is a tight inner approximation of the RoA.
Enlarging the RoA estimate is important for engineering
applications as it yields a less conservative safe operational
range. Traditional Lyapunov function methods select an ansatz
from a finite-dimensional subspace of C1 satisfying Lv(x) < 0
for all x ∈D \ xeq, but such an ansatz often gives a conser-
vative result. Zubov-related methods have shown advantages
over other inequality-oriented approaches (e.g., [53], [54]), and
further details on these PDEs can be found in [55], [56].
To illustrate the accuracy of the learned generator, as well
as the effectiveness of using it to solve Eq. (24), we revisit the
reversed Van der Pol oscillator system. The difference is that
we choose the dictionary ZN(x) the same as in Sections VII-
D, which consists of the σ-dimensional random feature NNs
tanh(xW T + bT) appended with {x1, x2}. In the experiment,
we set σ = 100, µ = 10, and M = 1002.
Remark 7.3: Due to page limitations, we include only the
standard benchmark, the reversed Van der Pol oscillator, which
is used as an example in virtually all Lyapunov function con-
struction tools. Additional system comparisons and detailed
discussions are provided in the extended version [43].
⋄
With the above settings, we can achieve a good approx-
imation of the dynamics with the RMSE of flow EF
RMSE
= 1.08e−5. We find an approximate equilibrium point at
[6.81e−8, −1.25e−8], which is sufficiently close to the origin
with negligible error. In addition, we observe that the average
approximation error of L tanh(xW T + bT) is 1.66e−4, indi-
cating an overall good performance.
We aim to find a single-hidden-layer feedforward neural
network of the form u(x; θ) = ZN(x)θ that approximates the
unique bounded viscosity solution of Lu(x) = −α|x|2(1 −
u(x) with α = 0.1 and the boundary condition u(0) = 0
using the learned generator. The problem is then reduced to
finding θ such that ZN(x)Lλθ = −α|x|2(1 −u(x; θ)).
Inspired by recent research on physics-informed neural
networks, it is necessary to introduce and minimize additional
loss terms beyond the residual loss that encompass the PDE
and supplementary problem information [56]–[58]. Here, we
specifically include loss terms to match u(0; θ) = 0 and values
on ∂Ω. Clearly, finding θ that minimizes the weighted sum of
4Supposing that xeq is asymptotically stable, the RoA of xeq is a set
defined as D := {x ∈Ω: limt→∞|ϕ(t, x) −xeq| = 0} .
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
13
−2
−1
0
1
2
x1
−2
0
2
x2
0.2
0.4
0.6
0.8
1.0
Learned Lyapunov Function
−2
−1
0
1
2
x1
−3
−2
−1
0
1
2
3
x2
Level sets
0.88
True RoA
Fig. 4.
Learned Lyapunov function and the corresponding region of
attraction estimate using the random feature neural network dictionary
functions for the reversed Van der Pol oscillator.
these loss terms does not have a closed-form solution. That
said, an extreme learning machine (ELM) [59], which seeks
solutions of the form ZN(x)θ for PDEs that are linear in both
u and ∇u, transforms the optimization into a linear least-
squares problem that can be efficiently solved, exhibiting fast
learning speed and strong generalization performance [58].
We also encourage readers to refer to [60] for a more
systematic study on using learned generators to obtain stability
certificates for unknown systems, with additional details on
encoding valid physics-informed information for approximat-
ing u(x) efficiently. The learned Lyapunov function and the
corresponding region of attraction estimate can be found in
Fig. 4, where the blue curve represents the region of attraction
estimate, which is sufficiently close to the true region of attrac-
tion. This result in turn reflects the overall good approximation
of the generator.
VIII. CONCLUSION
In this paper, we propose a novel resolvent-type Koop-
man operator-based learning framework for the generator of
unknown systems. The proposed method demonstrates both
theoretical and numerical improvements over the Koopman
logarithm method [35] and the finite difference method [29],
offering greater adaptability in handling low observation rate
scenarios and utilizing less biased random feature neural net-
works as dictionary functions. Specifically, in cases where the
logarithm of the Koopman operator is invalid for representing
the generator, we draw upon the rich literature to propose
data-driven approximations based on Yosida’s approximation
and the properties of the resolvent operator. The analytical
convergence and a modified data-driven learning algorithm
are provided to assist users in tuning the parameters. The
extended work on control systems [61] based on this method
also demonstrates better performance than benchmark tools.
The current drawbacks lie in tuning the parameter µ under
the constraints of the observation rate, as well as in the lack of
understanding regarding the sampling efficiency of the initial
conditions. We will pursue these analyses in future work and
provide a more systematic and automated parameter tuning
strategy, with the ultimate goal of developing a software tool-
box for data-driven system verification of unknown systems.
We also expect that the current research and the analysis
of data efficiency will lay the foundations for studying con-
trol systems, shed light on dimension reduction in generator
learning, and be beneficial for developing an online learning
adaptation of this method with a provable error bound. Another
possible extension direction based on the current research is
robustness analysis under noisy and partial observations.
Additionally, the domain can be extended to L∞(Ω), which
allows us to study the L2-adjoint operator of L with domain
L1(Ω), leading to more interesting applications such as the
Liouville equation and ergodic measure [5]. We will pursue
generator learning on this extended domain in future work.
APPENDIX A
FUNDAMENTAL PROPERTIES OF KOOPMAN GENERATORS
Note that the flow ϕ(t, x0) is absolutely continuous. For
learning the generator, we usually work with a (hypothetical)
smoother surrogate of the flow. In particular, there exists a
C1(Ω) surrogate that approximates the true flow uniformly
on any finite time window. For discrete snapshot data, the
approximation can be chosen to match the observations to
arbitrary accuracy, and, if desired, exactly at finitely many
sampled states via an additional small C1 perturbation. By
abuse of notation, we continue to write ϕ(t, x0) for this C1
surrogate5. Additionally, in this setting, for any h ∈C1(Ω),
∇(Kth)(x) exists and Kt : C1(Ω) →C1(Ω) for all t > 0.
Proposition A.1: Working with a sufficiently smooth sur-
rogate ϕ(t, x), for any h ∈dom(L) ⊆C(Ω), there exists a
sequence of {hn} ⊆C1(Ω) such that ∥hn −h∥L →0.
Proof: For any h ∈dom(L), let {gn} ⊆C1(Ω) be a sequence
such that ∥gn −h∥→0. Let hn,t(x) = 1
t
R t
0 Ktgn(x)ds for
any t > 0. Then, hn,t ∈C1(Ω) for any n and any fixed t > 0.
Consider {tn} such that tn →0 and ∥gn −h∥/tn →0 as
n →∞, and set hn := hn,tn. Then,
∥hn −h∥
≤

1
tn
Z tn
0
Ks(gn −h)ds
 +

1
tn
Z tn
0
Ksh ds −h

≤C(eωtn −1)
ωtn
∥gn −h∥+

1
tn
Z tn
0
Ksh ds −h
 ,
(25)
and ∥hn −h∥→0 as n →∞.
Furthermore, by [42, Theorem 2.4, Chap 1], we have
L
R t
0 Ksgnds = Ksgn −gn. Therefore,
∥Lhn −Lh∥
=

Ktngn −gn
tn
−Lh

≤

(Ktn −I)(gn −h)
tn
 +

Ktnh −h
tn
−Lh

≤Ceωtn + 1
tn
∥gn −h∥+

Ktnh −h
tn
−Lh
 ,
(26)
and ∥Lhn −Lh∥→0 as n →∞. The conclusion follows
immediately.
5We do not need to construct this surrogate explicitly. It is used solely to
simplify exposition, and since the learned system is approximate in any case,
this convention does not affect our conclusions.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


14
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
APPENDIX B
PROOFS AND SUPPLEMENTARIES FOR SECTION IV
Proof of Proposition 4.3: We assume that Rλ,T is compact
for λ > ω. By [42, Theorem 3.2], Ks is continuous w.r.t. the
uniform operator norm ∥· ∥. We can also easily verify the
compactness of λRλ,T Ks, for any s ∈(0, T], by Definition
4.1. In addition, for any arbitrarily small t > 0,
∥λRλ,T Ks −Ks∥
≤
Z t
0
λe−λσ∥Ks+σ −Ks∥dσ +
Z T
t
λe−λσ∥Ks+σ −Ks∥dσ
≤sup
σ∈(0,t]
∥Ks+σ −Ks∥(1 −e−λt) + 2
Z T
t
λe−λσ∥KT ∥dσ
≤sup
σ∈(0,t]
∥Ks+σ −Ks∥+ 2Cλ
λ −ω eω(t+T )−λt.
By the continuity of Ks, letting λ →∞and t →0, we
have Ks →λRλ,T Ks in the uniform sense, which shows the
compactness.
To show the converse side, we notice that the operator
Rt
λ,T :=
R τ
t e−λsKsds is always compact for any t ∈(0, T]
given the compactness of Ks with s ∈(0, T]. However,
∥Rλ,T −Rt
λ,T ∥≤
Z t
0
e−λs∥Ks∥ds ≤
Z t
0
∥Ks∥ds
≤
Z t
0
Ceωsds ≤tCeωt.
Letting t →0, we see the uniform convergence of Rt
λ,T to
Rλ,T , which shows compactness of Rλ,T .
Proof of Corollary 4.5: We show the sketch of the proof.
Working on the compact family of {Kε
s}s∈(0,T ] for some small
ε > 0, one can find a sufficiently large N such that
∥KN
s h −Ksh∥< δ, h ∈C(Ω), s ∈(0, T],
where KN
s is the finite-dimensional representation of Kε
s. Let
RN
λ,T :=
R T
0 e−λsKN
s ds. Then, for any t ∈(0, T),
∥RN
λ,T h −Rλ,T h∥
≤
Z t
0
e−λs∥KN
s h −Ksh∥ds +
Z T
t
e−λs∥KN
s h −Ksh∥ds
≤C∥h∥t +
sup
s∈(0,T ]
∥KN
s h −Ksh∥· e−λt −e−λT
λ
<C∥h∥t + δ,
where C := sups∈(0,t] ∥KN
s ∥+Ceωt. The conclusion follows
by sending t →0.
Lemma B.1: Let B : C(Ω) →C(Ω) be any bounded
linear operator. Recall
¯G,
¯Hg of some g
∈C(Ω), and
¯HB from Definition 4.6. Recall Jε from Proposition 4.4.
Define Zε
N(x) = JεZN(x), Πε,Ng = Zε
N(x)T ¯G+ ¯Hg, and
Πε,NBZN(x)T = Zε
N(x)T ¯G+ ¯HB. Let Bε,N = Πε,NB. Then,
∥Bε,Nh −JεBh∥→0 as N →∞for each ε > 0. Now, let
BNh = ΠNBh, then ∥Bε,Nh −BNh∥→0 as ε →0.
Proof: For each ε > 0, let kε
x(y) = ηε(x −y). By definition,
Bε,Nh(x) = ( ¯G
+Zε
N(x))T
Z
Ω
ZN(y)(Bh)(y)dy
= ⟨ZN(·) ¯G
+Zε
N(x), Bh(·)⟩
= ⟨ΠNkε
x(·), Bh(·)⟩,
(27)
Therefore, |Bε,Nh(x) −JεBh(x)| = |⟨(I −ΠN)kε
x(·), Bh(·)⟩|
≤∥(I −ΠN)kε
x(·)∥L2∥B∥∥h∥L2, and ∥Bε,Nh −JεBh∥≤
supx∈Ω∥(I −ΠN)kε
x(·)∥L2∥B∥∥h∥L2. It is well known that
the family D := {kε
x(·) : x ∈Ω} is equicontinuous and
therefore forms a compact subset of L2(Ω). Additionally, since
for each kε
x ∈D we have ∥(I −ΠN)kε
x(·)∥L2 →0 as N →∞
by the construction of ΠN [48], the uniform boundedness
principle implies supx∈Ω∥(I −ΠN)kε
x(·)∥L2 →0.
For the second part, by the standard mollifier property,
supx∈Ω|⟨kε
x(·), zi(·)⟩−zi(x)| ≲ε · ∥∇zi(x)∥∞, where the
omitted constant is the mean distance under the mollifier
and ∥∇zi(x)∥∞
:=
supx∈Ω|∇zi(x)|. This implies that
supx∈Ω|Zε
N(x) −ZN(x)| ≲ε
√
N max1≤i≤N ∥∇zi(x)∥∞.
Then, by direct comparison, we have ∥Bε,Nh −BNh∥≤
supx∈Ω|Zε
N(x) −ZN(x)|∥¯G+∥| ¯Hh| →0 as ε →0.
APPENDIX C
PROOFS AND SUPPLEMENTARIES FOR SECTION V
Proof of Lemma 5.3: For simplicity, we denote Ri(x) =
bRN
µ,T zi(x) ∈ZN as a fixed function for each i. Let {ψk}
denote the orthornormal eigenfunctions of KN
T , which sat-
isfies KN
T ψk = eαkT ψk. It follows that eRe(αk)T ∥ψk∥≲
∥KT ψk∥+ Emax
N
≤(1 + Emax
N e−ωT )eωT , which implies that
Re(αk) ≤ω + 1
t log(1 + Emax
N e−ωt) ≤ω + e−ωT Emax
N
T
for all
k. Therefore, ∥KN
T ∥≤Me˜ωT where |˜ω −ω| ≲Emax
N . Then,
for all µ ∈(˜ω, ∞), one can prove in the same manner as in
Proposition 5.2 (with a standard proof provided in the extended
version [43]) that T V N
i (x) = Ri(x) + eµT KN
T V N
i (x) is a
contraction mapping, indicating the uniqueness of the equation
in the statement. Furthermore,
∥V N
i
−Vi∥
≤∥Ri −R(µ)zi∥+ e−µT ∥KT Vi −KN
T Vi∥
+ e−µT ∥KN
T Vi −KN
T V N
i ∥
≲EP + ∥Ei
N∥+ e(˜ω−µ)T ∥V N
i
−V N∥,
(28)
implying that ∥V N
i
−V N∥≲EP + Emax
N .
Proof of Theorem 5.4: We give a sketch of the proof,
since all error bounds follow from triangle inequalities and
the convergence analysis in Section IV-B. For simplicity,
we define A := (λ −µ)R(µ) + I, B := λµR(µ) −λ I,
¯A = ¯G+ ¯HA, and ¯A+
δ = ( ¯AT ¯A + δ I)−1 ¯AT for any δ > 0.
Since A is invertible, for any V (x) = ZN(x)Tv ∈ZN,
we set g
= A−1V , ξ
=
ˆA
+
δ v, and ˆgN
= ZN(x)Tξ.
Additionally, we notice that Ag
=
ΠNAg
=
V . We
also denote gN
= ΠNg, and ¯gN
= ZN(x)T ¯A+
δ θ. Then
¯gN
= arg minW ∈ZN (∥ΠNAW −V ∥L2 + δ∥W∥2
L2), and
∥ΠNA¯gN−V ∥L2+δ∥¯gN∥2
L2 ≤∥ΠNAgN−V ∥L2+δ∥gN∥2
L2 =
∥ΠNA(gN −g)∥L2 + δ∥gN∥2
L2 ≲EN(g) + δ∥gN∥2
L2, where
EN(g) of the last inequality is due to the strong convergence
of ΠNA to A. Therefore, ∥ΠNA¯gN −ΠNAg∥L2 ≲EN(g) +
δ(∥gN −¯gN∥). One can then follow the same procedure as in
the proof of Lemma D.4 in the extended version [43] to show
that ∥ΠNA¯gN −ΠNAg∥≲EN(g) + δ(∥gN −¯gN∥)6. Then,
6One can let u
=
¯gN −g. Similar to (27), ∥Πε,NAu∥
≤
supx∈Ω∥kε
x(·)∥L2∥ΠNu∥L2 ≲∥u∥L2 and ∥Πε,NAu −ΠNAu∥≲ε for
any ε > 0. The convergence follows by the same argument as in Remark 4.7,
and we omit the details due to repetition.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


Y. MENG et al.: RESOLVENT-TYPE DATA-DRIVEN LEARNING OF GENERATORS FOR UNKNOWN CONTINUOUS-TIME DYNAMICAL SYSTEMS
15
∥¯gN −g∥≤∥A−1∥∥Ag −A¯gN∥≤∥A−1∥(∥V −ΠNA¯gN∥+
∥ΠNA¯gN −A¯gN∥) ≲EN(g)+δ∥¯gN −g∥+EN(A¯gN), which
implies ∥¯gN −g∥≲EN(g) + δ + EN(A¯gN) for sufficiently
small δ. One can let EΠ
N := EN(g) + EN(A¯gN), whence
∥¯gN −g∥≲EΠ
N + δ.
On the other hand, since bA and A differ only through the
evaluation of R(µ), with error depending continuously on
EP + Emax
N
(as in Lemma 5.3), we obtain EA := ∥¯A −ˆA∥≲
EP + Emax
N
as well. We then have ∥ˆA+
δ −¯A+
δ ∥≤( 1
δ +
(∥¯
A∥+∥ˆ
A∥) max{∥¯
A∥,∥ˆ
A∥}
δ2
)EA [62]. It can be verified that with
δ = O(E1/3
A ), we have a H¨older bound ∥ˆA+
δ −¯A+
δ ∥≲E1/3
A ,
and thereby ∥ˆgN −¯gN∥≲E1/3
A
for sufficiently small EA.
Now, let V
= bBhθ, v =
ˆBθ, and g = A−1V . Then,
LN
λ hθ(x) = ZN(x)T ˆA
+
δ ˆBθˆgN, Lλhθ(x) = A−1Bhθ, and
∥LN
λ hθ −Lλhθ∥≤∥ˆgN −g∥+ ∥g −A−1Bhθ∥≲∥ˆgN −g∥+
∥bBhθ −Bhθ∥≲EΠ
N + (EP + Emax
N )1/3 + (EP + Emax
N ) ≲
EΠ
N + (EP + Emax
N )1/3, where the third term in the third
inequality again follows from the fact that bB and B differ
only through the evaluation of R(µ), with error continuous to
EP + Emax
N
(as in Lemma 5.3). The conclusion follows.
REFERENCES
[1] S. N. Ethier and T. G. Kurtz, Markov Processes: Characterization and
Convergence. John Wiley & Sons, 2009.
[2] B. O. Koopman, “Hamiltonian systems and transformation in Hilbert
space,” Proceedings of the National Academy of Sciences, vol. 17, no. 5,
pp. 315–318, 1931.
[3] M. Haseli and J. Cort´es, “Recursive forward-backward EDMD: Guaran-
teed algebraic search for Koopman invariant subspaces,” IEEE Access,
2025.
[4] M. Reed and B. Simon, Methods of Modern Mathematical Physics:
Functional Analysis, vol. 1. Gulf Professional Publishing, 1980.
[5] G. A. Pavliotis and A. Stuart, Multiscale Methods: Averaging and
Homogenization, vol. 53. Springer Science & Business Media, 2008.
[6] L. C. Evans, Partial Differential Equations, vol. 19. American Mathe-
matical Society, 2022.
[7] A. Vannelli and M. Vidyasagar, “Maximal Lyapunov functions and
domains of attraction for autonomous nonlinear systems,” Automatica,
vol. 21, no. 1, pp. 69–80, 1985.
[8] I. M. Mitchell, A. M. Bayen, and C. J. Tomlin, “A time-dependent
Hamilton-Jacobi formulation of reachable sets for continuous dynamic
games,” IEEE Transactions on Automatic Control, vol. 50, no. 7,
pp. 947–957, 2005.
[9] M. Bardi and I. C. Dolcetta, Optimal Control and Viscosity Solutions of
Hamilton-Jacobi-Bellman Equations, vol. 12. Springer, 1997.
[10] M. G. Crandall and P.-L. Lions, “Viscosity solutions of Hamilton-Jacobi
equations,” Transactions of the American mathematical society, vol. 277,
no. 1, pp. 1–42, 1983.
[11] J. Sj¨oberg, Q. Zhang, L. Ljung, A. Benveniste, B. Delyon, P.-Y. Gloren-
nec, H. Hjalmarsson, and A. Juditsky, “Nonlinear black-box modeling in
system identification: a unified overview,” Automatica, vol. 31, no. 12,
pp. 1691–1724, 1995.
[12] R. Haber and H. Unbehauen, “Structure identification of nonlinear
dynamic systems—a survey on input/output approaches,” Automatica,
vol. 26, no. 4, pp. 651–677, 1990.
[13] Y. Lin, E. D. Sontag, and Y. Wang, “A smooth converse Lyapunov
theorem for robust stability,” SIAM Journal on Control and Optimization,
vol. 34, no. 1, pp. 124–160, 1996.
[14] A. R. Teel and L. Praly, “A smooth Lyapunov function from a class-
estimate involving two positive semidefinite functions,” ESAIM: Control,
Optimisation and Calculus of Variations, vol. 5, pp. 313–367, 2000.
[15] Y. Meng, Y. Li, M. Fitzsimmons, and J. Liu, “Smooth converse
Lyapunov-barrier theorems for asymptotic stability with safety con-
straints and reach-avoid-stay specifications,” Automatica, vol. 144,
p. 110478, 2022.
[16] A. D. Ames, X. Xu, J. W. Grizzle, and P. Tabuada, “Control barrier
function based quadratic programs for safety critical systems,” IEEE
Transactions on Automatic Control, vol. 62, no. 8, pp. 3861–3876, 2016.
[17] A. D. Ames, S. Coogan, M. Egerstedt, G. Notomista, K. Sreenath, and
P. Tabuada, “Control barrier functions: Theory and applications,” in 2019
18th European Control Conference (ECC), pp. 3420–3431, IEEE, 2019.
[18] Y. Meng and J. Liu, “Lyapunov-barrier characterization of robust
reach–avoid–stay specifications for hybrid systems,” Nonlinear Analysis:
Hybrid Systems, vol. 49, p. 101340, 2023.
[19] I. Mezi´c, “Spectral properties of dynamical systems, model reduction
and decompositions,” Nonlinear Dynamics, vol. 41, pp. 309–325, 2005.
[20] W. Pan, Y. Yuan, J. Gonc¸alves, and G.-B. Stan, “A sparse Bayesian
approach to the identification of nonlinear state-space systems,” IEEE
Transactions on Automatic Control, vol. 61, no. 1, pp. 182–187, 2015.
[21] S. L. Brunton, J. L. Proctor, and J. N. Kutz, “Discovering governing
equations from data by sparse identification of nonlinear dynamical
systems,” Proceedings of the National Academy of Sciences, vol. 113,
no. 15, pp. 3932–3937, 2016.
[22] J. C. Nash and M. Walker-Smith, “Nonlinear parameter estimation,” An
integrated system on BASIC. NY, Basel, vol. 493, 1987.
[23] J. M. Varah, “A spline least squares method for numerical parameter
estimation in differential equations,” SIAM Journal on Scientific and
Statistical Computing, vol. 3, no. 1, pp. 28–46, 1982.
[24] S. E. Otto and C. W. Rowley, “Koopman operators for estimation and
control of dynamical systems,” Annual Review of Control, Robotics, and
Autonomous Systems, vol. 4, no. 1, pp. 59–87, 2021.
[25] A. Mauroy and I. Mezi´c, “A spectral operator-theoretic framework for
global stability,” in 52nd IEEE Conference on Decision and Control,
pp. 5234–5239, IEEE, 2013.
[26] A. Mauroy and I. Mezi´c, “Global stability analysis using the eigen-
functions of the Koopman operator,” IEEE Transactions on Automatic
Control, vol. 61, no. 11, pp. 3356–3369, 2016.
[27] S. A. Deka, A. M. Valle, and C. J. Tomlin, “Koopman-based neural
Lyapunov functions for general attractors,” in Conference on Decision
and Control (CDC), pp. 5123–5128, IEEE, 2022.
[28] Y. Meng, R. Zhou, and J. Liu, “Learning regions of attraction in
unknown dynamical systems via Zubov-Koopman lifting: Regularities
and convergence,” IEEE Transactions on Automatic Control, vol. 70,
no. 10, pp. 6672–6687, 2025.
[29] J. J. Bramburger and G. Fantuzzi, “Auxiliary functions as Koopman
observables: Data-driven analysis of dynamical systems via polynomial
optimization,” Journal of Nonlinear Science, vol. 34, no. 1, p. 8, 2024.
[30] S. Klus, F. N¨uske, S. Peitz, J.-H. Niemann, C. Clementi, and C. Sch¨utte,
“Data-driven approximation of the Koopman generator: Model reduc-
tion, system identification, and control,” Physica D: Nonlinear Phenom-
ena, vol. 406, p. 132416, 2020.
[31] A. Nejati, A. Lavaei, S. Soudjani, and M. Zamani, “Data-driven
estimation of infinitesimal generators of stochastic systems,” IFAC-
PapersOnLine, vol. 54, no. 5, pp. 277–282, 2021.
[32] C. Wang, Y. Meng, S. L. Smith, and J. Liu, “Data-driven learning of
safety-critical control with stochastic control barrier functions,” in IEEE
Conference on Decision and Control (CDC), pp. 5309–5315, 2022.
[33] S. Otto, S. Peitz, and C. Rowley, “Learning bilinear models of actuated
Koopman generators from partially observed trajectories,” SIAM Journal
on Applied Dynamical Systems, vol. 23, no. 1, pp. 885–923, 2024.
[34] J. A. Rosenfeld and R. Kamalapurkar, “Dynamic mode decomposition
with control liouville operators,” IEEE Transactions on Automatic Con-
trol, vol. 69, no. 12, pp. 8571–8586, 2024.
[35] A. Mauroy and J. Goncalves, “Koopman-based lifting techniques for
nonlinear systems identification,” IEEE Transactions on Automatic Con-
trol, vol. 65, no. 6, pp. 2550–2565, 2019.
[36] Z. Drmaˇc, I. Mezi´c, and R. Mohr, “Identification of nonlinear systems
using the infinitesimal generator of the Koopman semigroup—a numer-
ical implementation of the Mauroy–Goncalves method,” Mathematics,
vol. 9, no. 17, p. 2075, 2021.
[37] M. Black and D. Panagou, “Safe control design for unknown non-
linear systems with Koopman-based fixed-time identification,” IFAC-
PapersOnLine, vol. 56, no. 2, pp. 11369–11376, 2023.
[38] Z. Zeng, Z. Yue, A. Mauroy, J. Gonc¸alves, and Y. Yuan, “A sampling
theorem for exact identification of continuous-time nonlinear dynamical
systems,” IEEE Transactions on Automatic Control, vol. 69, no. 12,
pp. 8402–8417, 2024.
[39] Z. Zeng, J. Liu, and Y. Yuan, “A generalized Nyquist-Shannon sampling
theorem using the Koopman operator,” IEEE Transactions on Signal
Processing, vol. 72, pp. 3595–3610, 2024.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 


16
IEEE TRANSACTIONS ON AUTOMATIC CONTROL
[40] Y. Susuki, A. Mauroy, and I. Mezic, “Koopman resolvent: A Laplace-
domain analysis of nonlinear autonomous dynamical systems,” SIAM
Journal on Applied Dynamical Systems, vol. 20, no. 4, pp. 2013–2036,
2021.
[41] Y. Meng, R. Zhou, M. Ornik, and J. Liu, “Koopman-based learning of
infinitesimal generators without operator logarithm,” in IEEE Conference
on Decision and Control (CDC), pp. 8302–8307, IEEE, 2024.
[42] A. Pazy, Semigroups of Linear Operators and Applications to Partial
Differential Equations, vol. 44. Springer Science & Business Media,
2012.
[43] Y. Meng, R. Zhou, M. Ornik, and J. Liu, “Resolvent-type data-driven
learning of generators for unknown continuous-time dynamical systems,”
arXiv preprint arXiv:2411.00923, 2024.
[44] V. Kostic, H. Halconruy, T. Devergne, K. Lounici, and M. Pontil, “Learn-
ing the infinitesimal generator of stochastic diffusion processes,” Ad-
vances in Neural Information Processing Systems, vol. 37, pp. 137806–
137846, 2024.
[45] Z. Liu, N. Ozay, and E. D. Sontag, “Properties of immersions for
systems with multiple limit sets with implications to learning koopman
embeddings,” Automatica, vol. 176, p. 112226, 2025.
[46] Y. Meng, H. Li, M. Ornik, and X. Li, “Koopman-based data-driven
techniques for adaptive cruise control system identification,” in IEEE
International Conference on Intelligent Transportation Systems (ITSC),
pp. 849–855, IEEE, 2024.
[47] P.- ˚A. Wedin, “Perturbation theory for pseudo-inverses,” BIT Numerical
Mathematics, vol. 13, no. 2, pp. 217–232, 1973.
[48] M. O. Williams, I. G. Kevrekidis, and C. W. Rowley, “A data–driven
approximation of the Koopman operator: Extending dynamic mode
decomposition,” Journal of Nonlinear Science, vol. 25, pp. 1307–1346,
2015.
[49] M. Axenides and E. Floratos, “Scaling properties of the Lorenz system
and dissipative Nambu mechanics,” in Chaos, Information Processing
And Paradoxical Games: The Legacy Of John S Nicolis, pp. 27–41,
World Scientific, 2015.
[50] S. Sato, M. Sano, and Y. Sawada, “Practical methods of measuring
the generalized dimension and the largest lyapunov exponent in high
dimensional chaotic systems,” Progress of theoretical physics, vol. 77,
no. 1, pp. 1–5, 1987.
[51] P. Ruoff, M. K. Christensen, J. Wolf, and R. Heinrich, “Temperature de-
pendency and temperature compensation in a model of yeast glycolytic
oscillations,” Biophysical chemistry, vol. 106, no. 2, pp. 179–192, 2003.
[52] D. A. Messenger and D. M. Bortz, “Weak SINDy: Galerkin-based data-
driven model selection,” Multiscale Modeling & Simulation, vol. 19,
no. 3, pp. 1474–1497, 2021.
[53] U. Topcu, A. Packard, and P. Seiler, “Local stability analysis using
simulations and sum-of-squares programming,” Automatica, vol. 44,
no. 10, pp. 2669–2675, 2008.
[54] R. Zhou, T. Quartz, H. De Sterck, and J. Liu, “Neural Lyapunov control
of unknown nonlinear systems with stability guarantees,” Advances in
Neural Information Processing Systems, vol. 35, pp. 29113–29125, 2022.
[55] F. Camilli, L. Gr¨une, and F. Wirth, “A generalization of Zubov’s method
to perturbed systems,” SIAM Journal on Control and Optimization,
vol. 40, no. 2, pp. 496–515, 2001.
[56] J. Liu, Y. Meng, M. Fitzsimmons, and R. Zhou, “Physics-informed
neural network lyapunov functions: Pde characterization, learning, and
verification,” Automatica, vol. 175, p. 112193, 2025.
[57] J. Liu, Y. Meng, M. Fitzsimmons, and R. Zhou, “Tool LyZNet: A
lightweight Python tool for learning and verifying neural Lyapunov func-
tions and regions of attraction,” in 27th ACM International Conference
on Hybrid Systems: Computation and Control, pp. 1–8, 2024.
[58] R. Zhou, M. Fitzsimmons, Y. Meng, and J. Liu, “Physics-informed
extreme learning machine Lyapunov functions,” IEEE Control Systems
Letters, vol. 8, pp. 1763–1768, 2024.
[59] G.-B. Huang, Q.-Y. Zhu, and C.-K. Siew, “Extreme learning machine:
theory and applications,” Neurocomputing, vol. 70, no. 1-3, pp. 489–501,
2006.
[60] R. Zhou, Y. Meng, Z. Zeng, and J. Liu, “Learning Koopman-based sta-
bility certificates for unknown nonlinear systems,” in IEEE Conference
on Decision and Control (CDC), IEEE, 2025.
[61] Z. Zeng, R. Zhou, Y. Meng, and J. Liu, “Data-driven optimal control of
unknown nonlinear dynamical systems using the Koopman operator,” in
7th Annual Learning for Dynamics & Control Conference, pp. 1127–
1139, PMLR, 2025.
[62] A. N. Tikhonov, “Solutions of ill posed problems,” 1977.
YIMING MENG
received the Ph.D. degree
in Applied Mathematics from the University of
Waterloo, ON, Canada, in 2022. He was a Post-
doctoral fellow at the Department of Applied
Mathematics, University of Waterloo between
2022 and 2023. This work was conducted while
he was a Postdoctoral Research Associate at
the Coordinated Science Laboratory, University
of Illinois Urbana–Champaign, Urbana, IL, USA,
from 2023 to 2025. His research interests lie
in the analysis and development of rigorous
computational methods for uncertain dynamical systems and control,
including formal methods, machine learning, and data-driven decision-
making computations, with applications in finance, robotics, and other
physical sciences.
RUIKUN ZHOU
received the bachelor’s de-
gree in Vehicle Engineering from Chongqing
University in 2014, and the M.ASc degree in
Mechanical Engineering from the University of
Ottawa in 2020, and the Ph.D. degree in Applied
Mathematics from the University of Waterloo in
2025. He is an incoming Postdoctoral Associate
with the Department of Aeronautics and Astro-
nautics at MIT. His research interests lie at the
intersection of machine learning and control sys-
tems, including learning-based stability analysis
with formal guarantees, and learning-based control with applications in
robotics.
MELKIOR ORNIK
(Senior Member, IEEE) re-
ceived the Ph.D. degree in electrical and com-
puter engineering from the University of Toronto,
Toronto, ON, Canada, in 2017. He is currently
an Assistant Professor with the Department of
Aerospace Engineering and the Coordinated
Science Laboratory, University of Illinois Urbana-
Champaign, Urbana, IL, USA. His research
interests include developing theory and algo-
rithms for learning and planning of autonomous
systems operating in uncertain, complex, and
changing environments, as well as in scenarios where only limited
knowledge of the system is available.
JUN LIU
(Senior Member, IEEE) received
the B.S. degree in Applied Mathematics from
Shanghai Jiao-Tong University in 2002, the M.S.
degree in Mathematics from Peking University in
2005, and the Ph.D. degree in Applied Mathe-
matics from the University of Waterloo in 2011.
He held an NSERC Postdoctoral Fellowship in
Control and Dynamical Systems at Caltech be-
tween 2011 and 2012. He was a Lecturer in Con-
trol and Systems Engineering at the University of
Sheffield between 2012 and 2015. In 2015, he
joined the Faculty of Mathematics at the University of Waterloo, where
he currently is a Canada Research Chair and Professor of Applied
Mathematics. His main research interests are in the theory and appli-
cations of hybrid systems and control, including rigorous computational
methods for control design with applications in cyber-physical systems
and robotics.
This article has been accepted for publication in IEEE Transactions on Automatic Control. This is the author's version which has not been fully edited and 
content may change prior to final publication. Citation information: DOI 10.1109/TAC.2026.3654481
© 2026 IEEE. All rights reserved, including rights for text and data mining and training of artificial intelligence and similar technologies. Personal use is permitted,
but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information.
Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 00:48:32 UTC from IEEE Xplore.  Restrictions apply. 
