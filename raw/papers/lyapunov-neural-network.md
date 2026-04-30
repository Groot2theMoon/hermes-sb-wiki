---
source_url: 
ingested: 2026-04-30
sha256: affd3aa4b9663439afeb53ff63bbfca5832d1516464d71d05454c1502ee194c4
---

The Lyapunov Neural Network: Adaptive Stability
Certiﬁcation for Safe Learning of Dynamical Systems
Spencer M. Richards
Department of Mechanical and Process Engineering
ETH Z¨urich
spenrich@stanford.edu
Felix Berkenkamp
Department of Computer Science
ETH Z¨urich
befelix@inf.ethz.ch
Andreas Krause
Department of Computer Science
ETH Z¨urich
krausea@ethz.ch
Abstract: Learning algorithms have shown considerable prowess in simulation
by allowing robots to adapt to uncertain environments and improve their perfor-
mance. However, such algorithms are rarely used in practice on safety-critical
systems, since the learned policy typically does not yield any safety guarantees.
That is, the required exploration may cause physical harm to the robot or its en-
vironment. In this paper, we present a method to learn accurate safety certiﬁcates
for nonlinear, closed-loop dynamical systems. Speciﬁcally, we construct a neural
network Lyapunov function and a training algorithm that adapts it to the shape of
the largest safe region in the state space. The algorithm relies only on knowledge
of inputs and outputs of the dynamics, rather than on any speciﬁc model structure.
We demonstrate our method by learning the safe region of attraction for a simu-
lated inverted pendulum. Furthermore, we discuss how our method can be used in
safe learning algorithms together with statistical models of dynamical systems.
Keywords: Lyapunov stability, Safe learning, Reinforcement learning
1
Introduction
Safety is among the foremost open problems in robotics and artiﬁcial intelligence [1]. Many au-
tonomous systems, such as self-driving cars and robots for palliative care, are safety-critical due
to their interaction with human life. At the same time, learning is necessary for these systems to
perform well in a priori unknown environments. During learning, they must safely explore their
environment by avoiding dangerous states from which they cannot recover. For example, consider
an autonomous robot in an outdoor environment affected by rough terrain and adverse weather con-
ditions. These factors introduce uncertainty about the relationship between the robot’s speed and
maneuverability. While the robot should learn about its capabilities in such conditions, it must not
perform a maneuver at a high speed that would cause it to crash. Conversely, traveling at only slow
speeds to avoid accidents is not conducive to learning about the extent of the robot’s capabilities.
To ensure safe learning, we must verify a safety certiﬁcate for a state before it is explored. In control
theory, a set of states is safe if system trajectories are bounded within it and asymptotically converge
to a ﬁxed point under a ﬁxed control policy. Within such a region of attraction (ROA) [2], the system
can collect data during learning and can always recover to a known safe point. In this paper, we
leverage Lyapunov stability theory to construct provable, neural network-based safety certiﬁcates,
and adapt them to the size and shape of the largest ROA of a general nonlinear dynamical system.
Related work Lyapunov functions are convenient tools for stability (i.e., safety) certiﬁcation of dy-
namical systems [2] and for ROA estimation [3, 4, 5]. These functions encode long-term behaviour
of state trajectories in a scalar value [6], such that a ROA can be encoded as a level set of the Lya-
punov function. However, Lyapunov functions for general dynamical systems are difﬁcult to ﬁnd;
2nd Conference on Robot Learning (CoRL 2018), Z¨urich, Switzerland.


computational approaches are surveyed in [7]. A Lyapunov function can be identiﬁed efﬁciently via
a semi-deﬁnite program (SDP, [8]) when the dynamics are polynomial and the Lyapunov function
is restricted to be a sum-of-squares (SOS) polynomial [9]. Other methods to compute ROAs in-
clude maximization of a measure of ROA volume over system trajectories [10], and sampling-based
approaches that generalize information about stability at discrete points to a continuous region [11].
This paper is particularly concerned with safety certiﬁcates for dynamical systems with uncertainties
in the form of model errors. In robust control [12], the formulation of SDPs with SOS Lyapunov
functions is used to compute ROA estimates for uncertain linear dynamical systems with the as-
sumption of a worst-case linear perturbation from a known bounded set [13, 14]. Learning-based
control methods with a Gaussian process (GP, [15]) model of the system instead consider uncertainty
in a Bayesian manner, where model errors are reduced in regions where data has been collected. The
methods in [16, 17] estimate a ROA with Lyapunov stability certiﬁcates computed on a discretization
of the state space, which is used for safe reinforcement learning (RL, [18]). The Lyapunov function
is assumed to be given in [16], while [17] uses the negative value (i.e., cost) function from RL with
a quadratic reward. Ultimately, this approach is limited by a shape mismatch between level sets of
the Lyapunov function and the true largest ROA. For example, a quadratic Lyapunov function has
ellipsoidal level sets, which cannot characterize a non-ellipsoidal ROA, while the SOS approach is
restricted to ﬁxed monomial features. To improve safe exploration for general nonlinear dynamics,
we want to learn these features to determine a Lyapunov function with suitably shaped level sets.
Contributions
In this paper, we present a novel method for learning accurate safety certiﬁcates
for general nonlinear dynamical systems. We construct a neural network Lyapunov candidate and,
unlike past work in [19, 20], we structure our candidate such that it always inherently yields a
provable safety certiﬁcate. Then, we specify a training algorithm that adapts the candidate to the
shape of the dynamical system’s trajectories via classiﬁcation of states as safe or unsafe. We do not
depend on any speciﬁc structure of the dynamics for this. We show how our construction relates
to SOS Lyapunov functions, and compare our approach to others on a simulated inverted pendulum
benchmark. We also discuss how our method can be used to make safe learning more effective.
2
Problem Statement and Background
We consider a discrete-time, time-invariant, deterministic dynamical system of the form
xt+1 = f(xt, ut),
(1)
where t ∈N is the time step index, and xt ∈X ⊂Rd and ut ∈U ⊂Rp are the state and control
inputs respectively at time step t. The system is controlled by a feedback policy π: X →U and the
resulting closed-loop dynamical system is given by xt+1 = fπ(xt) with fπ(x) = f(x, π(x)). We
assume this policy is given, but it can, for example, be computed online with RL or optimal control.
This policy π is safe to use within a subset Sπ of the state space X. The set Sπ is a ROA for fπ,
i.e., every system trajectory of fπ that begins at some x ∈Sπ also remains in Sπ and asymptotically
approaches an equilibrium point xO ∈Sπ where fπ(xO) = xO [2]. We assume xO = 0 without
loss of generality. Hereafter, we use Sπ to denote the true largest ROA in X under the policy π.
A reliable estimate of Sπ is critical to online learning systems, since we need to ensure that a policy
is safe to use on the real system before it can be deployed. The goal of this paper is to estimate the
largest safe set Sπ. We must also ensure safety by never overestimating Sπ, i.e., we must not identify
unsafe states as safe. For this to be feasible, we make a regularity assumption about the closed-loop
dynamics; we assume fπ is Lipschitz continuous on X with Lipschitz constant Lfπ ∈R>0. This is
a weak assumption and is even satisﬁed when a neural network policy is used [21].
2.1
Safety Certiﬁcation with Lyapunov Functions
One way to estimate the safe region Sπ is by using a Lyapunov function. Given a suitable Lyapunov
function v, a safe region for the closed-loop dynamical system xt+1 = fπ(xt) can be determined.
Theorem 1 (Lyapunov’s stability theorem [6]): Suppose fπ is locally Lipschitz continuous and has
an equilibrium point at xO = 0. Let v : X →R be locally Lipschitz continuous on X. If there exists
a set Dv ⊆X containing 0 on which v is positive-deﬁnite and ∆v(x) := v(fπ(x)) −v(x) < 0,
∀x ∈Dv \ {0}, then xO = 0 is an asymptotically stable equilibrium. In this case, v is known as a
Lyapunov function for the closed-loop dynamics fπ, and Dv is the Lyapunov decrease region for v.
2


xO = 0
Sπ
V(c)
Dv
(a) Shape mismatch with a ﬁxed
Lyapunov function.
xO = 0
y = −1
y = −1
y = −1
Sπ = Vθ(cS)
y = +1
(b) Shape match with a parameterized
Lyapunov function.
Figure 1.
Fig. 1a illustrates a shape mismatch between the largest level set V(c) (blue ellipsoid) of a quadratic
Lyapunov function v contained within the decrease region Dv (green dashes), and the safe region Sπ (black).
We cannot certify all of Sπ with v, which limits exploration in safe learning. Instead, we train a Lyapunov
candidate vθ with parameters θ to match Sπ with a level set Vθ(cS), as in Fig. 1b, via classiﬁcation of sampled
states as “safe” with ground-truth label y = +1 (i.e., x ∈Sπ) or “unsafe” with y = −1 (i.e., x /∈Sπ).
Theorem 1 states that a Lyapunov function v characterizes a “basin” of safe states where trajectories
of fπ “fall” towards the origin xO = 0. If we can ﬁnd a positive-deﬁnite v such that the dynamics
always map downwards in the value of v(x), then trajectories eventually reach v(x) = 0, thus
x = 0. To ﬁnd a ROA, rather than checking if v decreases along entire trajectories, it is sufﬁcient to
verify the one-step decrease condition ∆v(x) < 0 for every state x in a level set of v.
Corollary 1 (Safe level sets [6]): Every level set V(c) :=

x | v(x) ≤c
	
, c ∈R>0 contained
within the decrease region Dv is invariant under fπ. That is, fπ(x) ∈V(c), ∀x ∈V(c). Further-
more, limt→∞xt = 0 for every xt in these level sets, so each one is a ROA for fπ and xO = 0.
Intuitively, if v(x) decreases everywhere in the level set V(c1), except at xO = 0 where it is zero,
then V(c1) is invariant, since the image of V(c1) under fπ is the smaller level set V(c2) with c2 < c1.
If v is also positive-deﬁnite, then this ensures trajectories that start in a level set V(c) contained in
the decrease region Dv remain in V(c) and converge to xO = 0. To identify safe level sets, we
must check if a given Lyapunov candidate v satisﬁes the conditions of Theorem 1. However, the
decrease condition ∆v(x) < 0 is difﬁcult to verify throughout a continuous subset Dv ⊆X. It
is sufﬁcient to verify the tightened safety certiﬁcate ∆v(x) < −L∆vτ at a ﬁnite set of points that
cover Dv, where L∆v ∈R>0 is the Lipschitz constant of ∆v and τ ∈R>0 is a measure of how
densely the points cover Dv [17]. We can even couple this with bounds on fπ from a statistical
model to certify high-probability safe sets with the certiﬁcate ∆ˆv(x) < −L∆vτ, where ∆ˆv(x) is an
upper conﬁdence bound on ∆v(x). A GP model of fπ is used for this purpose in [17].
2.2
Computing SOS Lyapunov Functions
In general, a suitable Lyapunov candidate v is difﬁcult to ﬁnd. Computational methods often restrict
v to a particular function class for tractability. The SOS approach restricts v(x) to be polynomial,
but is limited to polynomial dynamical systems, i.e., when fπ(x) is a vector of polynomials in
the elements of x [9, 22, 23]. In particular, the SOS approach enforces v(x) = m(x)⊤Qm(x),
where m(x) is a vector of a priori ﬁxed monomial features in the elements of x, and Q is an
unknown positive-semideﬁnite matrix. This makes v(x) a quadratic function on a monomial feature
space. A SDP can be efﬁciently solved to yield a Q that simultaneously guarantees that v satisﬁes
the assumptions of Theorem 1 and has the largest possible level set in its decrease region Dv. That is,
the positive-deﬁniteness of v and the negative-deﬁniteness of ∆v in Dv are enforced as constraints
in the SDP. This contrasts the more general approach described in Sec. 2.1, where a Lyapunov
candidate v is given and then the assumptions of Theorem 1 are veriﬁed by checking discrete points.
With the SOS approach and a suitable choice of m(x), Sπ can be estimated well with a level set V(c)
of v, since the monomial features allow Lyapunov functions with shapes beyond simple ellipsoids to
be found. However, the SOS approach requires polynomial dynamics, and the best choice of m(x)
can be difﬁcult to determine. Without a suitable Lyapunov function, we face the problem of a shape
mismatch between V(c) and Sπ. This is exempliﬁed in Fig. 1a, where level sets of quadratic v are
ellipsoidal while Sπ is not, which limits the region of the state space that is certiﬁable as safe by v.
3


3
Learning Lyapunov Candidates
In this section, we establish a more ﬂexible class of parameterized Lyapunov candidates that can
satisfy the assumptions on v in Theorem 1 by virtue of their structure and gradient-based parameter
training. In particular, we show how a binary classiﬁcation problem based on whether each state x
lies within the safe region Sπ can be formulated to train the parameterized Lyapunov candidate.
3.1
Construction of a Neural Network Lyapunov Function
We take the SOS approach in Sec. 2.2 as a starting point to construct a neural network Lyapunov
candidate. The SOS Lyapunov candidate v(x) = m(x)⊤Qm(x) is a Euclidean inner product on
the transformed space Y :=

φ(x), ∀x ∈X
	
with φ(x) := Q1/2m(x). The ability of the SOS
Lyapunov candidate v to certify safe states for fπ depends on the choice of monomials in m(x).
We interpret these choices as engineered features that deﬁne the expressiveness of v in delineating
the decision boundary between safe and unsafe states. Rather than choose such features manually
and parameterize φ(x) with Q only, we propose the Lyapunov candidate vθ(x) = φθ(x)⊤φθ(x) to
learn the requisite features, where φθ : Rd →RD is a feed-forward neural network with parameter
vector θ. Feed-forward neural networks are expressive in that they can approximate any continuous
function on compact subsets of Rd with a ﬁnite number of parameters [24, 25]. In Sec. 3.2, we ex-
ploit this property together with gradient-based parameter training to closely match the true ROA Sπ
with a level set of the candidate vθ without the need to engineer individual features of φ.
We cannot use an arbitrary feed-forward neural network φθ in our Lyapunov candidate, since the
conditions of Theorem 1 must be satisﬁed. Otherwise, the resulting candidate vθ cannot provide
any safety information. In general, φθ is a sequence of function compositions or layers. Each layer
has the form yℓ(x) = ϕℓ(Wℓyℓ−1(x)), where yℓ(x) is the output of layer ℓfor state x ∈X, ϕℓis
a ﬁxed element-wise activation function, and Wℓyℓ−1(x) is a linear transformation parameterized
by Wℓ∈Rdℓ×dℓ−1. To satisfy the assumptions of Theorem 1, vθ must be Lipschitz continuous
on X and positive-deﬁnite on some subset of X around xO = 0. To this end, we restrict vθ to be
positive-deﬁnite and Lipschitz continuous on X for all values of θ := {Wℓ}ℓwith a suitable choice
of structure for φθ.
Theorem 2 (Lyapunov neural network): Consider vθ(x) = φθ(x)⊤φθ(x) as a Lyapunov candi-
date function, where φθ is a feed-forward neural network. Suppose, for each layer ℓin φθ, the
activation function ϕℓand weight matrix Wℓ∈Rdℓ×dℓ−1 each have a trivial nullspace. Then φθ
has a trivial nullspace, and vθ is positive-deﬁnite with vθ(0) = 0 and vθ(x) > 0, ∀x ∈X \ {0}.
Furthermore, if ϕℓis Lipschitz continuous for each layer ℓ, then vθ is locally Lipschitz continuous.
We provide a formal proof of Theorem 2 in Appendix A and brieﬂy outline it here. As an inner
product, vθ(x) = φθ(x)⊤φθ(x) is already positive-deﬁnite for any neural network output φθ(x),
and thus is at least nonnegative for any state x ∈X. The step from nonnegativity to positive-
deﬁniteness of vθ on X now only depends on how the origin 0 ∈X is mapped through φθ. If φθ
maps 0 ∈X uniquely to the zero output φθ(0) = 0, i.e., if φθ has a trivial nullspace, then vθ is
positive-deﬁnite. For this, it is sufﬁcient that each layer of φθ has a trivial nullspace, i.e., that each
layer “passes along” 0 ∈X to its zero output yℓ(0) = 0 until the ﬁnal output φθ(0) = 0.
In Theorem 2, each layer ℓhas a trivial nullspace as long as its weight matrix Wℓand activation
function ϕℓhave trivial nullspaces. Consequently, this requires that dℓ≥dℓ−1 for each layer ℓ,
where dℓis the output dimension of layer ℓ. That is, Wℓmust not decrease the dimension of its
input. To ensure that Wℓhas a trivial nullspace, we structure it as
Wℓ=

G⊤
ℓ1Gℓ1 + εIdℓ−1
Gℓ2

,
(2)
where Gℓ1 ∈Rqℓ×dℓ−1 for some qℓ∈N≥1, Gℓ2 ∈R(dℓ−dℓ−1)×dℓ−1, Idℓ−1 ∈Rdℓ−1×dℓ−1 is the
identity matrix, and ε ∈R>0 is a constant. The top partition G⊤
ℓ1Gℓ1 + εIdℓ−1 is positive-deﬁnite
for ε > 0, thus Wℓalways has full rank and a trivial nullspace. Otherwise, Wℓwould have a
non-empty nullspace of dimension dℓ−1 −min(dℓ, dℓ−1) = dℓ−1 −dℓ> 0 by the rank-nullity
theorem. With this choice of structure for Wℓ, the parameters of the neural network φθ are given
by θ := {Gℓ1, Gℓ2}ℓ. Finally, we choose activation functions that have trivial nullspaces and
that are Lipschitz continuous in X, such as tanh(·) and the leaky ReLU. We can then compute a
Lipschitz constant for φθ [21].
4


xO = 0
Vθ(ck)
Sπ
(a) Current safe level set.
Sπ
xO = 0
Vθ(ck)
Vθ(αck)
G ∩Sπ
(b) Simulate gap states forward.
xO = 0
Sπ
Vθ(ck+1)
(c) Re-shape safe level set.
Figure 2.
Illustration of training the parameterized Lyapunov candidate vθ to expand the safe level set Vθ(ck)
(blue ellipsoid) towards the true largest ROA Sπ (black). States in the gap G between Vθ(ck) and Vθ(αck)
(orange ellipsoid) are simulated forward to determine regions (green) towards which we can expand the safe
level set. This information is used in Algorithm 1 to iteratively adapt safe level sets of vθ to the shape of Sπ.
3.2
Learning a Safe Set via Classiﬁcation
Previously, we constructed a neural network Lyapunov candidate vθ in Theorem 2 that satisﬁes
the positive-deﬁniteness and Lipschitz continuity requirements in Theorem 1. As a result, we can
always use the one-step decrease condition ∆vθ(x) := vθ(fπ(x)) −vθ(x) < 0 as a provable
safety certiﬁcate to identify safe level sets that are subsets of the largest safe region Sπ. Now, we
design a training algorithm to adapt the parameters θ such that the resulting Lyapunov candidate vθ
satisﬁes ∆vθ(x) < 0 throughout as large of a decrease region Dvθ ⊆X as possible. This also
makes vθ a valid Lyapunov function for the closed-loop dynamics fπ.
For now, we assume the entire safe region Sπ is known. We want to use a level set Vθ(c) of vθ
to certify the entire set Sπ as safe. According to Theorem 1, this requires the Lyapunov decrease
condition ∆vθ(x) < 0 to be satisﬁed for each state x ∈Sπ. We formally state this problem as
max
θ,c Vol
 Vθ(c) ∩Sπ

, s.t. ∆vθ(x) < 0, ∀x ∈Vθ(c),
(3)
where Vol(·) is some measure of set volume. Thus, we want to ﬁnd the largest level set of vθ that is
contained in the true largest ROA Sπ; see Fig. 2a. We ﬁx c = cS with some cS ∈R>0, as it is always
possible to rescale vθ by a constant, and focus on optimizing over θ. We can then interpret (3) as a
classiﬁcation problem. Consider Fig. 1b, where we assign the ground-truth label y = +1 whenever
a state x is contained in Sπ, and y = −1 otherwise. We use vθ together with Theorem 1 to classify
states by their membership in the level set V(cS). This is described by the decision rule
ˆyθ(x) = sign
 cS −vθ(x)

.
(4)
That is, each state within the level set V(cS) obtains the label y = +1. However, we must also satisfy
the Lyapunov decrease condition imposed by Theorem 1. This can be written as the constraint
y = +1 =⇒∆vθ(x) < 0,
(5)
which means that we can assign the label y = +1 only if the decrease condition is also satisﬁed. The
decision rule (4) together with the constraint (5) ensures that the resulting estimated safe set V(cS)
satisﬁes all of the conditions in Theorem 1. We want to select the neural network parameters θ so
that this rule can perfectly classify x ∈Sπ as “safe” with ˆyθ(x) = +1 (i.e., cS −vθ(x) > 0) or
x /∈Sπ as “unsafe” with ˆyθ(x) = −1 (i.e., cS −vθ(x) ≤0). To this end, the decision boundary
vθ(x) = cS must exactly delineate the boundary of Sπ. Furthermore, the value of θ must ensure (5)
holds, such that vθ satisﬁes the decrease condition of Theorem 1 on Sπ.
Since we have rewritten the optimization problem in (3) as a classiﬁcation problem, we can use
ideas from the corresponding literature [26]. In particular, we deﬁne a loss function ℓ(y, x; θ) that
penalizes misclassiﬁcation of the true label y at a state x under the decision rule (4) associated
with θ. Many common choices for the loss function are possible; for simplicity, we use the percep-
tron loss, which penalizes misclassiﬁcations more when they occur far from the decision boundary.
5


Algorithm 1 ROA Classiﬁer Training
1: Input: closed-loop dynamics fπ; initialized parametric Lyapunov candidate vθ : X →R≥0;
Lagrange multiplier λ ∈R>0; level set “expansion” multiplier α ∈R>1; forward-simulation
horizon T ∈N≥1.
2: c0 ←maxx∈X vθ(x), s.t. Vθ(c0) ⊆Dvθ.
▷compute the initial safe level set (e.g., use a dis-
cretization, as described in Sec. 2.1)
3: repeat
4:
Sample a ﬁnite batch Xb ⊂Vθ(αck).
5:
Sb ←

x ∈Xb | f (T )
π
(x) ∈Vθ(ck)
	
.
▷forward-simulate the batch with fπ over T steps
6:
Update θ with (7) via batch SGD on Xb and labels {yi}i for points in Sb.
7:
ck+1 ←maxx∈X vθ(x), s.t. Vθ(ck+1) ⊆Dvθ.
8: until convergence
We choose not to use the “maximum margin” objective of the hinge loss, since it may be unsuitable
for us to accurately delineate Sπ, where states can lie arbitrarily close to the decision boundary in
the continuous state space X. Since we use the level set Vθ(cS) in our classiﬁcation setting, this
corresponds to ℓ(y, x; θ) = max
 0, −y ·
 cS −vθ(x)

. Here, cS −vθ(x) is the signed distance
from the decision boundary vθ(x) = cS, which separates the safe set Sπ from the rest of the state
space X \ Sπ. This classiﬁer loss has a magnitude of
cS −vθ(x)
 in the case of a misclassiﬁcation,
and zero otherwise. This ensures that decisions far from the decision boundary, such as those near
the origin, are considered more important than the more difﬁcult decisions close to the boundary.
Ideally, we would like to minimize this loss throughout the state space with min
R
X l(y, x; θ) dx
subject to the constraint (5). Since this problem is intractable, we use gradient-based optimization
together with mini-batches instead, as is typically done in machine learning. To this end, we sample
states Xb = {xi}i from the state space X at random and assign the ground-truth labels {yi}i to
them. Based on this ﬁnite set, the optimization objective can be written as
min
θ
X
x∈Xb
ℓ(y, x; θ), s.t. y = +1 =⇒∆vθ(x) < 0,
(6)
where the batch Xb is re-sampled after every gradient step. We can apply a Lagrangian relaxation
min
θ
X
x∈Xb
ℓ(y, x; θ) + λ
y + 1
2

max
 0, ∆vθ(x)

(7)
in order to make the problem tractable. Here, λ ∈R>0 is a Lagrangian multiplier and the term
λ((y + 1)/2) max
 0, ∆vθ(x)

is the Lyapunov decrease loss, which penalizes violations of (5).
The decrease condition ∆vθ(x) < 0 only needs to be enforced within the safe region Sπ, so we
do not want to incur a loss if it is violated at a state where y = −1. Thus, we use the multiplier
(y +1)/2 to map {+1, −1} to {1, 0}, such that the Lyapunov decrease loss is zeroed-out if y = −1.
However, there are two issues when this formulation is compared to the exact problem in (3). Firstly,
the objective (7) only penalizes violations of the decrease condition ∆vθ(x) < 0, rather than con-
straining θ to enforce it. Thus, while ∆vθ(x) < 0 is always a provable safety certiﬁcate, we must
verify that it holds over some level set whenever we update θ. Secondly, ground-truth labels of Sπ
are not known in practice. To address these issues, we can use any method to check Lyapunov safety
certiﬁcates over continuous state spaces to certify a level set Vθ(c) as safe, and then use Vθ(c) to
estimate labels y from Sπ. For this work, we check the tightened certiﬁcate ∆vθ(x) < −L∆vθτ on
a discretization of X, as described in Sec. 2.1. This method exposes the Lipschitz constant L∆vθ
of ∆vθ, which can conveniently be used for regularization in practice [21]. Possible alternatives
to this safety veriﬁcation method include the use of an adaptive discretization for better scaling to
higher-dimensional state spaces [11], and formal veriﬁcation methods for neural networks [27, 28].
Since such an estimate of Sπ is limited by the largest safe level set of vθ, we propose Algorithm 1
to iteratively “grow” an estimate of Sπ. We initialize vθ, then use it to identify the largest safe level
set Vθ(c0) by verifying the condition ∆vθ(x) < 0. At ﬁrst, we use Vθ(c0) to estimate Sπ. At
iteration k ∈N≥0, we consider the safe level set Vθ(ck) and the expanded level set Vθ(αck) for
some α ∈R>1; see Fig. 2b. Then, states in the “gap” G := Vθ(αck)\Vθ(ck) are forward-simulated
6


−100
0
100
−200
0
200
angle [deg]
angular velocity [deg/s]
Sπ
NN
LQR
SOS
(a) Safe Lyapunov candidate level sets.
0
0.5
1
1.5
safe level ck
0
5
10
15
0
0.2
0.4
0.6
0.8
1
safe level set update iteration k
fraction of Sπ
(b) Training behaviour of neural network candidate.
Figure 3.
Results for training the neural network (NN) Lyapunov candidate vθ for an inverted pendulum. In
Fig. 3a, system trajectories (black) converge to the origin only within the largest safe region Sπ (green). The NN
candidate (orange) characterizes Sπ with a level set better than both the LQR (blue ellipsoid) and SOS (yellow)
candidates, as it adapts to the shape of Sπ. In Fig. 3b, the safe level ck of vθ converges non-monotonically
towards the ﬁxed boundary cS = 1, and the safe level set Vθ(ck) grows to cover most of Sπ. However, as
discussed at the end of Sec. 3, convergence of Vθ(ck) to Sπ is not guaranteed in general by Algorithm 1.
with the dynamics fπ for T ∈N≥1 time steps. States that fall in Vθ(ck) before or after forward-
simulation form a new estimate of Sπ, since trajectories become “trapped” in Vθ(ck) and converge
to the origin. We use this estimate of Sπ to identify labels y for classiﬁcation, then apply SGD with
the objective (7) to update θ and encourage Vθ(ck) to grow. Finally, we certify the new largest safe
level set Vθ(ck+1). These steps are repeated until a choice of stopping criterion is satisﬁed.
In general, Algorithm 1 does not guarantee convergence of the safe level set Vθ(ck) to Sπ, nor
that Vθ(ck) monotonically grows in volume. Furthermore, it is not guaranteed that the iterated safe
level ck ∈R>0 approaches the safe level cS that is prescribed to delineate Sπ. This is typical
of gradient-based parameter training, since the parameters θ can become “stuck” in local optima.
However, since the Lyapunov candidate vθ is guaranteed to satisfy the positive-deﬁniteness and
Lipschitz continuity conditions of Theorem 1 by its construction in Theorem 2, ∆vθ(x) < 0 is
always a provable safety certiﬁcate for identifying safe level sets. Thus, we can always use vθ to
identify at least a subset of Sπ, without ever identifying unsafe states as safe.
4
Experiments and Discussion
In the previous section, we developed Algorithm 1 to train the parameters θ of a neural network
Lyapunov candidate vθ constructed according to Theorem 2. This construction ensures the positive-
deﬁniteness and Lipschitz continuity assumptions on vθ in Theorem 1 are satisﬁed. Algorithm 1
encourages vθ to satisfy the decrease condition and match the true largest ROA Sπ for the closed-
loop dynamics fπ with a level set Vθ(cS). In this section, we present details for the implementation
of Algorithm 1 to learn the largest safe region of a simulated inverted pendulum system, and exper-
imental results in a comparison to other methods of computing Lyapunov functions.
Inverted Pendulum Benchmark
The inverted pendulum is governed by the differential equation
mℓ2¨θ = mgℓsin θ −β ˙θ + u with state x := (θ, ˙θ), where θ is the angle from the upright equilib-
rium xO = 0, u is the input torque, m is the pendulum mass, g is the gravitational acceleration,
ℓis the pole length, and β is the friction coefﬁcient. We discretize the dynamics with a time step
of ∆t = 0.01 s and enforce a saturation constraint u ∈[−¯u, ¯u], such that the pendulum falls over
past a certain angle and cannot recover. For a linear policy u = π(x) = Kx, this yields the safe
region Sπ in Fig. 3 around the upright equilibrium for the closed-loop dynamics fπ. In particular, we
ﬁx K to the linear quadratic regulator (LQR) solution for the discretized, linearized, unconstrained
form of the dynamics [29]. Outside of Sπ, the pendulum falls down without the ability to recover
and the system trajectories diverge away from xO = 0.
7


Practical Considerations
To train the parameters of the Lyapunov candidate vθ to adapt to the
shape of Sπ, we use Algorithm 1 with SGD. To certify the safety of continuous level sets of vθ
whenever θ is updated, we check the stricter decrease condition ∆vθ(x) < −L∆vθτ at a discrete
set of points that cover X in increasing order of the value of vθ(x), as in [17]. Algorithm 1 does
not guarantee that the safe level set estimate Vθ(ck) grows monotonically in volume towards Sπ
with each iteration k. In fact, the estimate Vθ(ck) may shrink if vθ initially succeeds and then fails
to satisfy the decrease condition ∆vθ(x) < 0 in some regions of the state space. This tends to
occur near the origin, where vθ(0) = ∆vθ(0) = 0 and the “basin of attraction” characterized by vθ
“ﬂattens”. To alleviate this, we use a large Lagrange multiplier λ = 1000 in the SGD objective (7)
to strongly “push” θ towards values that ensure vθ continues to satisfy the decrease condition. In
addition, we normalize the Lyapunov decrease loss λ((y + 1)/2) max
 0, ∆vθ(x)

in (7) by vθ(x).
This more heavily weighs sampled states near the origin, i.e., where vθ(x) is small.
Results
We implement Algorithm 1 on the inverted pendulum benchmark with the Python
code available at https://github.com/befelix/safe_learning, which is based on Tensor-
Flow [30]. For the neural network Lyapunov candidate vθ, we use three layers of 64 tanh(·) activa-
tion units each. We prescribe Vθ(cS) with cS = 1 as the level set that delineates the safe region Sπ.
Fig. 3 shows the results of training vθ with Algorithm 1, and the largest safe level set Vθ(c18) with
10 SGD iterations per update. Fig. 3a visualizes how this level set has “moulded” to the shape
of Sπ. Fig. 3b shows how the safe level ck converges towards the prescribed level cS = 1 that de-
lineates Sπ, and how the fraction of Sπ covered by Vθ(ck) approaches 1. The true largest ROA Sπ
is estimated by forward-simulating all of the states in a state space discretization, and set volume is
estimated by counting discrete states. Fig. 3a also shows the largest safe sets for a LQR Lyapunov
candidate and a SOS Lyapunov candidate. The LQR candidate vLQR(x) = x⊤Px is computed in
closed-form for the same discretized, linearized, unconstrained form of the dynamics used to deter-
mine the LQR policy π(x) = Kx [29]. The SOS Lyapunov candidate vSOS(x) = m(x)⊤Qm(x)
uses up to third-order monomials in x, thus it is a sixth-order polynomial. It is computed with the
toolbox SOSTOOLS [31] and the SDP solver SeDuMi [32] in MATLAB for the unconstrained non-
linear dynamics with a Taylor polynomial expansion of sin θ. While the SOS approach is a powerful
specialized method for polynomial dynamical systems, it cannot account for the non-differentiable
nonlinearity introduced by the input saturation, which drastically alters the closed-loop dynamics.
As a result, while vSOS is optimized for the system without saturation, it is ill-suited to the true
closed-loop dynamics and yields a small safe level set. Overall, our neural network Lyapunov can-
didate vθ performs the best at certiﬁcation of as much of Sπ as possible, since it only relies on inputs
and outputs of fπ, and adapts to the shape of Sπ.
Comments on Safe Learning Fig. 3a demonstrates that a neural network Lyapunov candidate vθ
can certify more of the true largest safe region Sπ than other common Lyapunov candidates. This has
important implications for safe exploration during learning for dynamical systems; with more safe
states available to visit, an agent can better learn about itself and its environment under a wider range
of operating conditions. For example, our method is applicable in the safe reinforcement learning
framework of [17]. This past work provides safe exploration guarantees for a GP model of the
dynamics fπ with conﬁdence bounds on the Lyapunov stability certiﬁcate, but these guarantees are
limited by the choice of Lyapunov function. As our results have shown, certain Lyapunov candidates
may poorly characterize the shape of the true largest safe region Sπ. Since our neural network
Lyapunov candidate can adapt to the shape of Sπ during learning by using, for example, the mean
estimate of fπ from the GP model, we could enlarge the estimated safe region more quickly as data
is collected. Our method is also applicable to exploration algorithms within safe motion planning
that depends on knowledge of a safe region, such as in [33]. Overall, our method strongly warrants
consideration for use in safe learning methods that leverage statistical models of dynamical systems.
5
Conclusion
We have demonstrated a novel method for learning safety certiﬁcates for general nonlinear dynami-
cal systems. Speciﬁcally, we developed a ﬂexible class of parameterized Lyapunov candidate func-
tions and a training algorithm to adapt them to the shape of the largest safe region for a closed-loop
dynamical system. We believe that our method is appealing due to its applicability to a wide range of
dynamical systems in theory and practice. Furthermore, it can play an important role in improving
safe exploration during learning for real autonomous systems in uncertain environments.
8


Acknowledgments
This research was supported in part by SNSF grant 200020 159557, the Vector Institute, and a
fellowship by the Open Philantropy Project.
References
[1] D. Amodei, C. Olah, J. Steinhardt, P. Christiano, J. Schulman, and D. Man´e. Concrete prob-
lems in AI safety. Technical report, 2016. arXiv:1606.06565v2 [cs.AI].
[2] H. K. Khalil. Nonlinear Systems. Prentice Hall, Upper Saddle River, NJ, 3 edition, 2002.
[3] A. Vannelli and M. Vidyasagar. Maximal Lyapunov functions and domains of attraction for
autonomous nonlinear systems. Automatica, 21(1):69–80, 1985.
[4] D. J. Hill and I. M. Y. Mareels. Stability theory for differential/algebraic systems with ap-
plication to power systems. IEEE Transactions on Circuits and Systems, 37(11):1416–1423,
1990.
[5] J. M. G. da Silva Jr. and S. Tarbouriech. Antiwindup design with guaranteed regions of sta-
bility: An LMI-based approach. IEEE Transactions on Automatic Control, 50(1):106–111,
2005.
[6] R. Kalman and J. Bertram. Control system analysis and design via the “second method” of
Lyapunov II: Discrete-time systems.
Transactions of the American Society of Mechanical
Engineers (ASME): Journal of Basic Engineering, 82(2):394–400, 1960.
[7] P. Giesl and S. Hafstein. Review on computational methods for Lyapunov functions. Discrete
and Continuous Dynamical Systems, Series B, 20(8):2291–2331, 2016.
[8] S. Boyd and L. Vandenberghe. Convex Optimization. Cambridge University Press, Cambridge,
UK, 2009.
[9] P. A. Parrilo. Structured semideﬁnite programs and semialgebraic geometry methods in ro-
bustness and optimization. PhD thesis, California Institute of Technology, 2000.
[10] D. Henrion and M. Korda. Convex computation of the region of attraction of polynomial
control systems. IEEE Transactions on Automatic Control, 59(2):297–312, 2014.
[11] R. Bobiti and M. Lazar. A sampling approach to ﬁnding Lyapunov functions for nonlinear
discrete-time systems. In Proc. of the European Control Conference (ECC), pages 561–566,
2016.
[12] K. Zhou and J. C. Doyle. Essentials of Robust Control. Prentice Hall, Upper Saddle River, NJ,
1998.
[13] A. Troﬁno. Robust stability and domain of attraction of uncertain nonlinear systems. In Proc.
of the American Control Conference (ACC), pages 3707–3711, 2000.
[14] U. Topcu, A. K. Packard, P. Seiler, and G. J. Balas. Robust region-of-attraction estimation.
IEEE Transactions on Automatic Control, 55(1):137–142, 2010.
[15] C. E. Rasmussen and C. K. I. Williams. Gaussian Processes for Machine Learning. MIT Press,
Cambridge, MA, 2006.
[16] F. Berkenkamp, R. Moriconi, A. P. Schoellig, and A. Krause. Safe learning of regions of
attraction for uncertain, nonlinear systems with Gaussian processes. In Proc. of the IEEE
Conference on Decision and Control (CDC), pages 4661–4666, 2016.
[17] F. Berkenkamp, M. Turchetta, A. P. Schoellig, and A. Krause. Safe model-based reinforce-
ment learning with stability guarantees. In Proc. of the Conference on Neural Information
Processing Systems (NIPS), pages 908–918, 2017.
[18] R. S. Sutton and A. G. Barto. Reinforcement Learning. MIT Press, Cambridge, MA, 2 edition,
2018. (draft).
9


[19] V. Petridis and S. Petridis. Construction of neural network based Lyapunov functions. In Proc.
of the IEEE International Joint Conference on Neural Network Proceedings, pages 5059–5065,
2006.
[20] N. Noroozi, P. Karimaghaee, F. Safaei, and H. Javadi. Generation of Lyapunov functions by
neural networks. In Proc. of the World Congress on Engineering (WCE), volume 1, pages
61–65, 2008.
[21] C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus.
Intriguing properties of neural networks. In Proc. of the International Conference on Learning
Representations (ICLR), 2014.
[22] A. Papachristodoulou and S. Prajna. On the construction of Lyapunov functions using the sum
of squares decomposition. In Proc. of the IEEE Conference on Decision and Control (CDC),
pages 3482–3487, 2002.
[23] A. Papachristodoulou. Scalable analysis of nonlinear systems using convex optimization. PhD
thesis, California Institute of Technology, 2005.
[24] G. Cybenko. Approximation by superpositions of a sigmoidal function. Mathematics of Con-
trol, Signals, and Systems, 2(4):303–314, 1989.
[25] K. Hornik. Some new results on neural network approximation. Neural Networks, 6(8):1069–
1072, 2001.
[26] C. M. Bishop. Pattern Recognition and Machine Learning. Springer-Verlag, New York, NY,
2006.
[27] X. Huang, M. Kwiatkowska, S. Wang, and M. Wu. Safety veriﬁcation of deep neural networks.
Technical report, 2017. arXiv:1610.06940v3 [cs.AI].
[28] G. Katz, C. Barrett, D. Dill, K. Julian, and M. Kochenderfer. Reluplex: An efﬁcient SMT solver
for verifying deep neural networks. In Proc. of the International Conference on Computer
Aided Veriﬁcation (CAV), 2017.
[29] F. L. Lewis, D. L. Vrabie, and V. L. Syrmos. Optimal Control. John Wiley & Sons, Inc.,
Hoboken, NJ, 3 edition, 2012.
[30] M. Abadi, P. Barham, J. Chen, Z. Chen, A. Davis, J. Dean, M. Devin, S. Ghemawat, G. Irving,
M. Isard, M. Kudlur, J. Levenberg, R. Monga, S. Moore, D. G. Murray, B. Steiner, P. Tucker,
V. Vasudevan, P. Warden, M. Wicke, Y. Yu, and X. Zheng. TensorFlow: A system for large-
scale machine learning. In Proc. of the USENIX Symposium on Operating Systems Design and
Implementation (OSDI), pages 265–283, 2016.
[31] S. Prajna, A. Papachristodoulou, and P. A. Parrilo. Introducing SOSTOOLS: A general purpose
sum of squares programming solver. In Proc. of the IEEE Conference on Decision and Control
(CDC), pages 741–746, 2002.
[32] J. F. Sturm. Using SeDuMi 1.02, a MATLAB toolbox for optimization over symmetric cones.
Optimization Methods and Software, 11(1–4):625–653, 1999.
[33] T. Koller, F. Berkenkamp, M. Turchetta, and A. Krause. Learning-based model predictive
control for safe exploration. In Proc. of the IEEE Conference on Decision and Control (CDC),
2018. (to appear).
10


A
Proofs
Theorem 2 (Lyapunov neural network): Consider vθ(x) = φθ(x)⊤φθ(x) as a Lyapunov candi-
date function, where φθ is a feed-forward neural network. Suppose, for each layer ℓin φθ, the
activation function ϕℓand weight matrix Wℓ∈Rdℓ×dℓ−1 each have a trivial nullspace. Then φθ
has a trivial nullspace, and vθ is positive-deﬁnite with vθ(0) = 0 and vθ(x) > 0, ∀x ∈X \ {0}.
Furthermore, if ϕℓis Lipschitz continuous for each layer ℓ, then vθ is locally Lipschitz continuous.
Proof. We begin by showing that φθ has a trivial nullspace in X by induction, and then use this to
prove that vθ is positive-deﬁnite on X. Recall that a feed-forward neural network is a successive
composition of its layer transformations, such that the output yℓ(x) of layer ℓfor the state x ∈X
is the input to layer ℓ+ 1. Consider ℓ= 0 with the input y0(x) := x, and the ﬁrst layer output
y1(x) = ϕ1(W1y0(x)). Clearly y0 has a trivial nullspace in X, since it is just the identity function.
Since W1, ϕ1, and y0 each have a trivial nullspace in their respective input spaces, the sequence of
logical statements
x = 0 ⇐⇒y0(x) = 0 ⇐⇒W1y0(x) = 0 ⇐⇒ϕ1(W1y0(x)) = 0
(8)
holds. Thus, x = 0 ⇐⇒ϕ1(W1y0(x)) = 0 holds, and y1 has a trivial nullspace in X. If we now
assume yℓhas a trivial nullspace in X, it is clear that yℓ+1 has a trivial nullspace in X, since
x = 0 ⇐⇒yℓ(x) = 0 ⇐⇒Wℓ+1yℓ(x) = 0 ⇐⇒ϕℓ+1(Wℓ+1yℓ(x)) = 0
(9)
holds in a similar fashion. As a result, yℓhas a trivial nullspace for each layer ℓby induction. Since
φθ is a composition of a ﬁnite number of layers, φθ = yL for some L ∈N≥0, thus φθ has a trivial
nullspace in X.
We now use this property of φθ to prove that the Lyapunov candidate vθ(x) = φθ(x)⊤φθ(x) is
positive-deﬁnite on X. As an inner product, φθ(x)⊤φθ(x) is positive-deﬁnite on the transformed
space Y :=

φθ(x), ∀x ∈X
	
. Thus, vθ(x) = 0
⇐⇒
φθ(x) = 0 and vθ(x) > 0 otherwise.
Since we have already proven φθ(x) = 0
⇐⇒
x = 0, combining these statements shows that
vθ(x) = 0 ⇐⇒x = 0 and vθ(x) > 0 otherwise. As a result, vθ(x) is positive-deﬁnite on X.
Finally, we need to show that if every activation function ϕℓis Lipschitz continuous, then vθ is
locally Lipschitz continuous. If the neural network φθ is Lipschitz continuous, then clearly vθ is
locally Lipschitz continuous, since it is quadratic and thus differentiable with respect to φθ. To show
that φθ is Lipschitz continuous, it is sufﬁcient to show that each layer is Lipschitz continuous. This is
due to the fact that any function composition f(g(x)) is Lipschitz continuous with Lipschitz constant
LfLg if f has Lipschitz constant Lf and g has Lipschitz constant Lg. This fact can be seen from
f(g(x)) −f(g(x′))
 ≤Lf
g(x) −g(x′)
 ≤LfLg
x −x′, for each pair x, x′ ∈X. By the
Lipschitz continuity of function composition and the linearity of Wℓyℓ−1, each layer transformation
yℓ= ϕℓ(Wℓyℓ−1) is Lipschitz continuous if ϕℓis Lipschitz continuous. As a result, the neural
network φθ is Lipschitz continuous, and the Lyapunov candidate vθ is locally Lipschitz continuous.
■
Remark 1: In (2), we ensured each weight matrix Wℓhas a trivial nullspace with the structure
Wℓ=

G⊤
ℓ1Gℓ1 + εIdℓ−1
Gℓ2

,
where Gℓ1 ∈Rqℓ×dℓ−1 for some qℓ∈N≥1, Gℓ2 ∈R(dℓ−dℓ−1)×dℓ−1, Idℓ−1 ∈Rdℓ−1×dℓ−1 is the
identity matrix, and ε ∈R>0 is a constant. To minimize the number of free parameters required
by our neural network Lyapunov candidate, we choose qℓto be the minimum integer such that each
entry in G⊤
ℓ1Gℓ1 ∈Rdℓ−1×dℓ−1 is independent from the others. Since G⊤
ℓ1Gℓ1 is symmetric, it has
Pdℓ−1
j=1 j = dℓ−1(dℓ−1 + 1)/2 free parameters, thereby requiring qℓdℓ−1 ≥dℓ−1(dℓ−1 + 1)/2 or
qℓ≥(dℓ−1 + 1)/2. For this, we choose qℓ=

(dℓ−1 + 1)/2

.
11
