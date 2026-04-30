---
title: "Learning over All Stabilizing Nonlinear Controllers for a Partially-Observed Linear System"
arxiv: "2112.04219"
authors: ["Ruigang Wang", "Nicholas H. Barbara", "Max Revay", "Ian R. Manchester"]
year: 2021
source: paper
ingested: 2026-05-01
sha256: 00ea5b80bdd9863428928bf6d6b1acee2e657184458d015ee02d7aa5490d6371
conversion: pymupdf4llm
---

## Learning over All Stabilizing Nonlinear Controllers for a Partially-Observed Linear System 

Ruigang Wang, Nicholas H. Barbara, Max Revay, and Ian R. Manchester 

_**Abstract**_ **— This paper proposes a nonlinear policy architecture for control of partially-observed linear dynamical systems providing built-in closed-loop stability guarantees. The policy is based on a nonlinear version of the Youla parameterization, and augments a known stabilizing linear controller with a nonlinear operator from a recently developed class of dynamic neural network models called the recurrent equilibrium network (REN). We prove that RENs are universal approximators of contracting and Lipschitz nonlinear systems, and subsequently show that the the proposed Youla-REN architecture is a universal approximator of stabilizing nonlinear controllers. The REN architecture simplifies learning since unconstrained optimization can be applied, and we consider both a model-based case where exact gradients are available and reinforcement learning using random search with zeroth-order oracles. In simulation examples our method converges faster to better controllers and is more scalable than existing methods, while guaranteeing stability during learning transients.** 

_**Index Terms**_ **— Contraction, learning based control, Youla parameterization, nonlinear output feedback** 

## I. INTRODUCTION 

EEP neural networks and reinforcement learning (RL) **D** hold tremendous potential for continuous control applications and impressive results have already been demonstrated on robot locomotion, manipulation, and other benchmark control tasks [1]. Nevertheless, deep RL based controllers are not yet widely used in engineering practice, as they can exhibit unexpected or brittle behaviour. This has led to a rapid growth in literature studying computational verification of neural networks and reinforcement learning with stability guarantees. 

Research in stable deep RL has largely assumed full state information is available [2]–[4]. In practice, most controllers only have access to partial state observations. In this setting, the optimal controller is generally a dynamic function of previous observations. To the authors’ knowledge, the only existing methods for this setting are [5], [6]. These methods propose nonconvex sets of stabilizing recurrent neural network (RNN) controllers that require nontrivial projection methods at each training step. 

This work was supported in part by the Australian Research Council. The authors are with the Sydney Institute for Robotics and Intelligent Systems, Australian Centre for Field Robotics, and also with the School of Aerospace, Mechanical and Mechatronic Engineering, The University of Sydney, Sydney, NSW 2006, Australia (e-mail: ian.manchester@sydney.edu.au). 

## _A. Background_ 

_a) The Youla Parameterization:_ Developed in the late 70’s, the Youla parameterization (or the Youla-Kucera parameterization) provides a parameterization of all stabilizing controllers for a given LTI system via a so-called _Q parameter_ [7], not to be confused with the state-action value function in RL, which is also usually denoted by _Q_ . The key feature of the Youla parameterization is that all stabilizing controllers can be represented via a stable system _Q_ , and the closedloop response is linear in _Q_ . It plays a central role in linear robust control theory [8], controller optimization [9], and decentralized control [10]. It has been used to guarantee stability in the linear reinforcement learning setting [11], to give the tightest-known regret bounds for online learning of linear controllers [12], and has been used in many applications, see e.g. [13] for a recent review. 

To date, these applications have employed a linear _Q_ parameter despite several works extending the theory to a nonlinear setting, see e.g. [14]. The main barriers to the widespread application of nonlinear Youla parameterizations have been (i) non-constructive parameterizations expressed in terms of coprime factors or kernel representations which are difficult to compute, and (ii) the lack of flexible parameterizations of nonlinear _Q_ parameters. 

_b) Learning Stable Dynamical Models:_ The construction of a nonlinear _Q_ parameter requires a parameterization of nonlinear systems with stability guarantees. A simple approach is to bound the maximum singular value of an RNN’s weight matrix leading to simple, yet conservative stability criteria [15], [16]. There have been a number of improvements that reduce conservatism by using non-Euclidean metrics [17], incremental integral quadratic constraints (IQCs) [18], and local IQCs [19]. A more general parameterization allowing state-dependent contraction metrics was given in [20]. A fundamental problem with these approaches is that the stability constraints take the form of (possibly nonconvex) matrix inequalities which require complex projection, barrier, or penalty methods to enforce. A significant development addressing these issues was the _direct parameterization_ developed in [21], providing an _unconstrained_ model parameterization with stability and robustness guarantees. 

_c) Reinforcement Learning and Random Search:_ RL is the problem of learning an approximate optimal controller given only observations or simulations of the process, not explicit 

models. There has been an enormous number of new algorithms for RL proposed in recent years, however the vast majority assume that the full state is available to the control policy during learning and execution [22]. Many methods work by fitting approximate value functions over the state space, while standard policy gradient algorithms rely on a Markovian assumption [22]. It has recently been demonstrated that in many benchmark control problems, simple random search over policy space is highly competitive [23]. The algorithm is a modified version of the classic stochastic approximation method of [24]. Random search takes random jumps in parameter space and approximates directional derivatives from cost evaluations. It makes no assumptions on the controller structure or state information, and is therefore well-suited to training dynamic controllers on partially observed systems. 

## _B. Contributions_ 

This paper proposes a method to learn over all stabilizing nonlinear dynamic controllers for a partially-observed linear system via unconstrained optimization. We build on our recent work [21], [25], [26] proposing the recurrent equilibrium network (REN) model structure, and incorporating it into control systems via the Youla parameterization. The paper [6] considers a similar problem statement, but requires a solving a semidefinite program (SDP) at each gradient step to project onto a convex approximation of a non-convex set. This paper provides the following contributions relative to prior work: 

- 1) We give necessary and sufficient conditions for closedloop stability, improving on the sufficient conditions in [6], [25], [26]. 

- 2) Whereas [21], [26] give a construction of contracting and Lipschitz RENs, in this paper we prove that the REN architecture is a universal approximator of contracting and Lipschitz nonlinear systems. 

- 3) We learn all parameters of the REN model, not just the output layer as in [26]. 

- 4) We consider the output-feedback case, not the statefeedback case as in [25], [26]. 

- 5) Our method uses unconstrained optimization, while [6] requires solving an SDP at each gradient step. 

- 6) We show that our method is naturally suited to gradientfree optimization via random search, since it can guarantee stability during the search procedure. 

## II. PROBLEM SETUP 

We consider a discrete-time linear time-invariant system: 

**==> picture [205 x 11] intentionally omitted <==**

with internal state _x_ , controlled inputs _u_ , measured outputs _y_ , and disturbances/noise on the state and measurements _dx, dy_ , respectively. For brevity _x_ = _xt, x_ + = _xt_ +1, and similarly for other variables. 

**==> picture [101 x 25] intentionally omitted <==**

We assume that the system is stabilizable and detectable, and that the disturbance signal _d_ and initial state _x_ 0 are random variables for which a sampler is available for training. 

We consider the problem of finding a controller _u_ = _Kθ_ ( _y_ ) with _θ_ as the learnable parameter, which may be nonlinear and/or dynamic (i.e. have internal states), such that: 

- 1) The closed-loop system is contracting, i.e. initial conditions are forgotten exponentially [27]. 

- 2) The closed-loop response to disturbances is Lipschitz (i.e. has bounded incremental _ℓ_[2] gain): 

**==> picture [103 x 13] intentionally omitted <==**

for some _γ >_ 0 where _∥· ∥_ is the signal _ℓ_[2] norm ~~_∞_~~ _∥z∥_ = �� _t_ =0 _[|][z][t][|]_[2][,] _[d][a][, d][b]_[are][two][realizations][of][the] disturbance, and _z[a] , z[b]_ are the corresponding realizations of _z_ . 

- 3) A cost function of the following form is minimized (at least approximately and locally) 

**==> picture [187 x 31] intentionally omitted <==**

where _E_ [ _·_ ] is expectation over _x_ 0 and _d_ . 

Note that the first two requirements are _hard_ requirements that must be satisfied, whereas the third is _soft_ in the sense that we do not expect a global minimum to necessarily be found, since we do not make any assumptions about convexity of _g, gT_ , nor the ability to precisely compute the expectation. In this work, the expectation is approximated by averaging over a finite batch of sampled _x_ 0 and _d_ , denoted by _J_[ˆ] _θ_ . 

We will consider two scenarios that differ in terms of the information available to the learning algorithm: 

- 1) A first-order oracle is available, i.e. where _J_ ˆ _θ_ and _∇θJ_[ˆ] _θ_ can be evaluated at any _θ_ . This is implementable when controllers are optimized using a differentiable simulation model, e.g. [28], hence we refer to this as the “model-based case”. 

- 2) A zeroth-order oracle is available, i.e. only _J_ ˆ _θ_ can be evaluated at each _θ_ . This is the setting usually assumed in reinforcement learning, since in principle it is implementable in experiments. In this case, we will approximate gradients using the method of [23]. 

## III. THE YOULA-REN CONTROLLER ARCHITECTURE 

We will construct a parameterization of all possible nonlinear controllers such that the closed-loop system is contracting and the mapping _d �→ z_ is Lipschitz in terms of a “parameter” which is itself a contracting and Lipschitz nonlinear system. We then use the REN model introduced in [21], [26] as this parameter. 

Since the system is stabilizable and detectable, one can compute gain matrices _K, L_ such that ( _A−BK_ ) and ( _A−LC_ ) are stable (e.g. LQG [8]). We assume some such gains are known and the “base” linear controller 

**==> picture [209 x 10] intentionally omitted <==**

˜ ˆ where _y_ = _y − Cx_ . The proposed control architecture is an extension of the classical Youla parameterization for linear systems, and works by augmenting the base controller: 

**==> picture [217 x 11] intentionally omitted <==**

where _Q_ is an arbitrary contracting and Lipschitz nonlinear system. Since _y_ ˜ represents the difference between expected and observed outputs, the Youla parameterization could be interpreted as prescribing a _stable response to surprises_ . 

_Remark_ 1 _._ The policy (4) can be extended to incorporate exogenous signals _r_ (e.g. reference signals, feedforward commands, disturbance previews, parameter estimates) by using ˆ a controller the form _u_ = _−Kx_ + _Q_ (˜ _y, r_ ), where _Q_ is contracting and Lipschitz in both inputs. All the following theoretical results apply unchanged in this case, but in this paper we restrict to the pure-feedback case for brevity of notation. 

## _A. Theoretical Results_ 

We will show that our proposed parameterization is in a sense universal, i.e., any stabilizing dynamic output-feedback controller can be parameterized via _Q_ . 

Consider an arbitrary feedback controller _u_ = _K_ ( _y_ ) admitting a state-space realisation 

**==> picture [184 x 11] intentionally omitted <==**

where _ζ_ is the state and _f, g_ are locally Lipschitz, leading to the closed-loop dynamics: 

**==> picture [198 x 26] intentionally omitted <==**

We give the following version of the well-known universality property of the Youla parameterization. 

**Proposition 1.** _Consider the following control architecture_ (4) _, parameterized by Q._ 

- 1) _For any contracting and Lipschitz Q, the closed-loop system with the controller_ (4) _is contracting and Lipschitz._ 

- 2) _Any controller of the form_ (5) _that achieves contracting and Lipschitz closed-loop can be written in the form_ (4) _with contracting and Lipschitz Q._ 

_Moreover, the closed-loop response with this controller structure is_ 

**==> picture [170 x 11] intentionally omitted <==**

_where T_ 0 _, T_ 1 _, T_ 2 _are stable linear systems._ 

**Proof:** We first construct _T_ 0 _, T_ 1 _, T_ 2, as per [8]. Defining _x_ ˜ = ˆ _x − x_ , the closed-loop dynamics under the base controller (3) can be written as 

**==> picture [212 x 45] intentionally omitted <==**

The first, second, and fourth equations define the stable closedloop response with the base controller, _d �→ z_ , which we denote _T_ 0. The first and third define a stable linear system _d �→ y_ ˜, which we denote _T_ 2. To construct _T_ 1, we introduce a ˜ ˆ ˜ virtual control input: _u_ := _u − uK_ = _u_ + _Kx_ = _u_ + _K_ ( _x − x_ ) Now, the plant dynamics under the Youla controller (4) can be rewritten as a linear system: 

**==> picture [208 x 11] intentionally omitted <==**

So by superposition, we have _z_ = _T_ 0 _d_ + _T_ 1 _u_ ˜ where _T_ 1 is the stable system 

**==> picture [213 x 13] intentionally omitted <==**

Hence if _Q_ maps _y_ ˜ to _u_ ˜, we have the closed loop (7). 

_Proof of Claim 1._ This follows from the stability of _T_ 0 _, T_ 1 _, T_ 2 and the contraction and Lipschitz condition on _Q_ , and the composition properties of contracting systems and Lipschitz mappings. 

_Proof of Claim 2._ Assuming a controller _u_ = _K_ ( _y_ ) exists in the form (5) we can equivalently augment it with the state estimator and rewrite it in terms of _y_ ˜ and _u_ ˜ as follows: 

**==> picture [204 x 41] intentionally omitted <==**

defining the closed-loop mapping _QK_ : _y_ ˜ _�→ u_ ˜. 

ˆ ˜ Now, taking (6), relabelling _x_ as _x_ , and taking _dx_ = _Ly_ and _dy_ = _y_ ˜ as particular inputs, gives (10), (11). Hence if the closed-loop with _K_ is contracting then so is _QK_ . Moreover, the fact that the mapping from _d → z_ is Lipschitz with (6) implies that the mapping _y_ ˜ _→ v_ is too, since by (12) _v_ = [ _K, I_ ] _z_ under this relabelling so _|u_ ˜ _| ≤ α|z|_ for some _α_ . Hence the closedloop system is contracting and Lipschitz if and only if _QK_ is. □ 

## _B. Q parameterization via RENs_ 

In this paper, we parameterize _Q_ via _recurrent equilibrium networks_ (RENs), a model architecture introduced in [21]. We will show that a REN is an universal approximator for the contracting and Lipschitz Youla parameter. 

We first review the REN model _Q_[˜] : _y_ ˜ _�→ u_ ˜, which is itself a feedback interconnection of a linear system and nonlinear “activation functions” _σ_ : 

**==> picture [242 x 97] intentionally omitted <==**

where _χt∈_ R _[n][χ]_ is the internal state, _vt, wt ∈_ R _[n][v]_ are the input and output of the neuron layer. We assume that _σ_ : R _→_ R is a non-polynomial function with slope restricted in [0 _,_ 1]. When _D_ 11 = 0, the mappting _v �→ w_ defines an _equilibrium network_ a.k.a. _implicit network_ , although when _D_ 11 is strictly lower-triangular this mapping is explicit. Many feed-forward networks (e.g. multilayer perceptron, residual networks) can be represented as equilibrium networks [26]. 

The learnable parameters in (13) are ( _W, b_ ), but the key feature of RENs relevant to this paper is that they admit a _direct_ parameterization, i.e. there is a smooth mapping _θ �→_ ( _W, b_ ) from an unconstrained parameter _θ ∈_ R _[q]_ , such that for all _θ_ the resulting REN is contracting and Lipschitz. A further benefit is that they are very flexible, including 

many previously-used models as special cases. The following proposition shows that RENs are universal approximators for contracting and Lipschitz systems. 

**Proposition 2.** _For any contracting and Lipschitz Q_ : _y_ ˜ _�→ u_ ˜ _, and any M, ϵ >_ 0 _there exists a sufficiently large nχ and nv such that a REN Q_[˜] _exists with these dimensions and ∥Q_[˜] (˜ _y_ ) _− Q_ (˜ _y_ ) _∥∞ ≤ ϵ for all ∥y_ ˜ _∥∞ ≤ M ._ 

_Proof._ We first show that _Q_ has fading memory in the sense of [29]. Assume that _Q_ has the state-space representation _x_ + = _f_ ( _x,_ ˜ _y_ ) _, u_ ˜ = _g_ ( _x,_ ˜ _y_ ) where _f, g_ are locally Lipschitz. Given an initial state _a_ and input sequence _y_ ˜, the corresponding state and output at time _t_ are denoted by _x[a,] t[y]_[˜] and _u_ ˜ _[a,] t[y]_[˜] , respectively. Since _Q_ is contracting, there exists an incremental Lyapunov function _c_ 1 _|x_ 1 _− x_ 2 _|_[2] _≤ V_ 1( _x_ 1 _, x_ 2) _≤ c_ 2 _|x_ 1 _− x_ 2 _|_[2] with _c_ 2 _≥ c_ 1 _>_ 0 such that for any initial state _a, b_ and input _∥y_ ˜[1] _∥∞ ≤ M_ , we have _V_ 1� _xt[a,]_ +1 _[y]_[˜][1] _[, x] t[b,]_ +1 _[y]_[˜][1] � _≤ αV_ 1� _xt[a,][y]_[˜][1] _, x[b,] t[y]_[˜][1] � for some _α ∈_ (0 _,_ 1). By applying the above inequality _N >_ log( _c_ 1 _/c_ 2) _/_ log _α_ steps from _t_ = 0, we have 

**==> picture [197 x 20] intentionally omitted <==**

where _β_ = _α[N/]_[2] ~~[�]~~ _c_ 2 _/c_ 1 _∈_ (0 _,_ 1). Due to the Lipschitzness of _Q_ , there exists an incremental Lyapunov function _c_ 3 _|x_ 1 _− x_ 2 _|_[2] _≤ V_ 2( _x_ 1 _, x_ 2) _≤ c_ 4 _|x_ 1 _− x_ 2 _|_[2] with _c_ 4 _≥ c_ 3 _>_ 0 such that for any initial state _b_ and inputs _∥y_ ˜[1] _∥∞, ∥y_ ˜[2] _∥∞ ≤ M_ , 

**==> picture [195 x 22] intentionally omitted <==**

for some _γ >_ 0, where _V_ 2 _,t_ = _V_ 2 _x[b,] t[y]_[˜][1] _, xt[b,][y]_[˜][2] . Summation � � of the above inequality from _t_ = 0 to _t_ = _N_ yields 

**==> picture [232 x 30] intentionally omitted <==**

From (14) and (15) we have _|x[a,] N[y]_[˜][1] _−x[b,] N[y]_[˜][2] _| ≤ β|x_ 0 _[a,][y]_[˜][1] _−x[b,]_ 0 _[y]_[˜][1] _|_ + ~~_√_~~ _γc_ 3 � _tN_ =0 _−_ 1 _[|][y]_[˜] _t_[1] _[−][y]_[˜] _t_[2] _[|][.]_[Shifting][the][initial][time][point][to] _[t]_[0][=] _−kN_ with _k →∞_ yields 

**==> picture [247 x 97] intentionally omitted <==**

where _β_ 1 _, β_ 2 _∈_ (0 _,_ 1) and _β_ 1 _β_ 2 = _β_ . Furthermore, we have 

**==> picture [209 x 24] intentionally omitted <==**

whereconstants _κ_ =of _Lg_ 2 +with(1 _−L_ respect _β_ 11 _N_ ) ~~_[√]_~~ _γ c_ 3[with] to _x_ and _[L]_[1] _[, L] y_ ˜[2] , respectively.[as][the][local][Lipschitz] 

Eq. (16) implies that _G_ has the fading memory property, and thus it can be universally approximated by nonlinear moving averaged operators (NLMAs) [29, Thm. 3]. Since REN includes the NLMA structure with˜ equilibrium network as output mapping [26, Sec. VI], _Q_ can approximate _Q_ arbitrarily close as _nχ_ and _nv_ increase. 

## IV. SIMULATION EXPERIMENTS ON CART-POLE 

In this section, we compare empirical performance of three control structures for an open-loop unstable system (the linearized cart-pole system): 

- Youla parameterisation (4) with a learnable _Q_ -parameter; 

- “Feedback policy” wraps a learnable dynamic controller as an outer loop around the base controller (3), i.e. _u_ = ˆ 

- _−Kx_ + _Kθ_ ( _y_ ). 

- Projection policy (5) parameterized by an RNN [6]. 

For the learnable parameter in the first two structures we considered both dynamical models (REN and LSTM) and static mappings (LBEN and DNN). A Lipschitz-bounded equilibrium network (LBEN) is a memoryless version of the REN [26], i.e., _nχ_ = 0 in (13). Each controller is denoted by _structure-model_ , e.g., the proposed approach is called YoulaREN. Note that neither the Youla-LSTM nor any of the “Feedback” policies provide closed-loop stability guarantees. All models were coded in Julia except the Project-RNN, for which we used Python sub-routines from [6] to perform model projection. 

## _A. Problem Setup_ 

We consider a linearized cartpole system [6] with 

**==> picture [193 x 84] intentionally omitted <==**

where _mp_ = 0 _._ 2, _mc_ = 1 _._ 0, _l_ = 0 _._ 5, _g_ = 9 _._ 81 and _δ_ = 0 _._ 08. We used an infinite-horizon LQG controller with random weight and covariance matrices as the base controller (3). We examined the following two control tasks. 

_a) Task 1:_ Consider the classic LQG control problem: 

**==> picture [216 x 30] intentionally omitted <==**

where _xt, ut_ are the state and input at time _t_ , respectively. The weight matrices are given by _Qf_ = _Q_ = diag(1 _,_ 1 _,_ 5 _,_ 1) and _R_ = 1. The covariance matrices of _dx_ and _dy_ are chosen as Σ _x_ = 0 _._ 005 _I_ and Σ _y_ = 0 _._ 001 _I_ , respectively. We used a trajectory length of _T_ = 50. 

_b) Task 2:_ We also considered the disturbance rejection problem with a convex but non-quadratic cost function 

**==> picture [206 x 31] intentionally omitted <==**

where _u_ is the soft input bound and _ρ_ is the penalty coefficient. The optimal policy for this problem is nonlinear due to the input constraint. We chose a large _ρ_ = 400 such that _ut_ could only exceed the bound _u_ = 2 for short periods of time. This is relevant e.g. for electric motors which allow larger currents for short periods before reverting to their continuous current capacity. The input disturbances contain Gaussian noise and piecewise-constant perturbation with random duration and magnitude. The trajectory length chosen was _T_ = 100. 

TABLE I 

LEARNING RATES USED FOR MODEL TRAINING 

||LQG|Input constrained|
|---|---|---|
|Exact grad.|DNN<br>LBEN LSTM REN|DNN<br>LBEN LSTM REN|
|Youla<br>Feedback|0.01<br>0.01<br>0.1<br>0.01<br>0.01<br>0.001<br>0.1<br>0.001|0.01<br>0.01<br>0.1<br>0.01<br>0.01<br>0.001<br>0.1<br>0.001|
|Appr. grad.|DNN<br>LBEN LSTM REN|DNN<br>LBEN LSTM REN|
|Youla<br>Feedback|0.01<br>0.01<br>0.04<br>0.01<br>0.01<br>0.008 0.04<br>0.008|0.01<br>0.02<br>0.04<br>0.02<br>0.01<br>0.01<br>0.02<br>0.01|



## _B. Training details_ 

We chose models with similar numbers of parameters, corresponding to 10 states and 20 neurons for both REN and RNN, 10 cell units for LSTM, and 40 hidden neurons for LBEN and DNN, respectively. We used ReLU activation functions for all models except LSTM. Each model was trained with the ADAM optimizer [30] over a range of learning rates from 0 _._ 001 to 0 _._ 1. Each experiment was repeated for 10 times with different random seeds, which affect model initialisation, noise, and disturbances. The learning rate was reduced by a factor of 10 after 85% of the total training epochs. Gradients were clipped to an _ℓ_[2] norm of 10.0 over all parameters. Depending on the learning scenarios, the policy gradients were computed in the following two ways. 

_a) Exact Gradients:_ In the model-based case, we used the exact gradients, i.e., first-order oracle _∇θJ_[ˆ] _θ_ with batch size of 40. Our chosen learning rates are provided in Table I. We chose a learning rate of 0.1 for the Projection-RNN controller after finding its performance was insensitive to hyperparameter choices. 

_b) Approximate Gradients:_ In the reinforcement learning case, only the zero-order oracle _J_[ˆ] _θ_ is available. We approximated the policy gradients using a finite-difference approach called Augmented Random Search (ARS) [23]. We made three minor changes to the original ARS algorithm to improve convergence. Firstly, we used the ADAM optimiser and gradient clipping instead of free stochastic gradient descent. Secondly, we used the average cost over _b_ batches of initial conditions to approximate the expected cost. Thirdly, we used the same batch of initial conditions when evaluating the cost for perturbations of the model parameters for a fair comparison between policy rollouts. The estimated policy gradient with respect to the model parameters _θ_ is then 

**==> picture [217 x 29] intentionally omitted <==**

with _J_[ˆ] _θ_ ( **x0** ) = 1 _b_ � _bj_ =1 _[J][θ]_[(] _[x]_ 0 _[j]_[)][,][where] _[x][j]_ 0[are][initial][state] vectors, _ν_ is a small perturbation, _δi_ is a normally-distributed random vector with zero mean, and _σR_ is the standard deviation of the 2 _m_ average costs collected for each gradient approximation [23]. We chose ( _m, b, ν_ ) = (40 _,_ 10 _,_ 0 _._ 01). The chosen learning rates are provided in Table I. It is not obvious how to effectively combine ARS with the iterative SDP projection step required by the Projection-RNN model in [6]. We therefore excluded it from our experiments. 

TABLE II 

COMPUTATION TIME PER EPOCH IN SECONDS 

|COMPUTATION|TABLE II<br> TIME PER EPOCH IN SECONDS|
|---|---|
|Number of neurons|20<br>50<br>80<br>110<br>140|
|Projection method [6]<br>Proposed method|0.64<br>2.98<br>8.43<br>18.77<br>36.76<br>0.03<br>0.05<br>0.07<br>0.11<br>0.18|



## _C. Results_ 

_a) Exact Gradients:_ Fig. 1 shows the training results of different controllers. Our Youla-REN performed the best overall, reaching the lowest final cost in the fewest training epochs. The Project-RNN controller seemed to fall into local minima after the first projection, making its cost more sensitive to model initialisation. The Youla-REN and Youla-LSTM controllers achieved similar final costs, but the Youla-REN converged faster and also guarantees stability during learning. Both Youla-LBEN and Youla-REN showed a rapid initial cost decrease, while the latter reached a lower final cost due to its memory units. All Youla policies outperformed their corresponding Feedback policies with the same model. 

In Table II we compare the per-epoch computational cost of each method as a function of the number of neurons in the control policy. The proposed Youla-REN method required around two orders of magnitude less computation than the method of [6] which solves a semidefinite program at each gradient iteration. Computation time comparison with other models is omitted as their differences were negligable. 

_b) Approximate Gradients:_ Fig. 1 also shows the results of learning controllers with ARS, where we can draw similar conclusions to the exact gradient experiments. The models achieved similar final costs to those trained with exact gradients in both tasks, even when limited to approximate gradients derived from policy evaluations at each iteration. Most notably, our Youla-REN controller still outperformed all other models. 

The ease of implementing approximate gradients with Youla-REN while still maintaining stability guarantees during learning is a direct consequence of our unconstrained parameterization. Each perturbation of the Youla-REN policy in ARS is intrinsically guaranteed to be stabilising, allowing ARS to take arbitrary perturbations in the policy parameters and remain within the set of stabilising controllers. This is a key feature of our approach, and provides a significant advantage over models like LSTM, which are not contracting for all parameters, or the projection method of [6], which cannot be easily adapted to random search. It is worth noting that having stability guarantees during random search makes the YoulaREN architecture potentially suitable to learning on hardware in safety-critical systems, where trialling destabilizing policies during the training process must be avoided. 

## REFERENCES 

- [1] T. P. Lillicrap, J. J. Hunt, A. Pritzel, N. Heess, T. Erez, Y. Tassa, D. Silver, and D. Wierstra, “Continuous control with deep reinforcement learning,” in _International Conference on Learning Representations_ , 2016. 

- [2] F. Berkenkamp, M. Turchetta, A. P. Schoellig, and A. Krause, “Safe model-based reinforcement learning with stability guarantees,” in _NeurIPS_ , 2017, pp. 908–919. 

- [3] Y.-C. Chang, N. Roohi, and S. Gao, “Neural Lyapunov control,” _NeurIPS_ , vol. 32, pp. 3245–3254, 2019. 

**==> picture [494 x 292] intentionally omitted <==**

**----- Start of picture text -----**<br>
LQG (exact grads) Input constraints (exact grads)<br>1.0<br>1.0<br>0.5<br>0.5 Base-Control<br>Projection-RNN<br>Feedback-DNN<br>Feedback-LBEN<br>0.0 0.0<br>0 30 60 90 120 150 180 210 240 0 30 60 90 120 150 180 210 240 Feedback-LSTM<br>Epochs Epochs Feedback-REN<br>Youla-DNN<br>LQG (ARS) Input constraints (ARS) Youla-LBEN<br>Youla-LSTM<br>1.0 1.0<br>Youla-REN<br>Optimal<br>0.8<br>0.8 Exact Grads<br>0.6<br>0.6<br>0.4<br>0.4<br>0.2<br>0 250 500 750 1000 1250 0 500 1000 1500 2000<br>Epochs Epochs<br>tcos tcos<br>zed zed<br>rmali rmali<br>o o<br>N N<br>st st<br>o o<br>c c<br>d  d<br>e e<br>ialz ialz<br>Norm Norm<br>**----- End of picture text -----**<br>


Fig. 1. Normalized test cost vs epochs while learning the controllers with exact gradients and ARS. The mean cost computed over 10 random seeds is plotted, with colored bands showing the range. The base linear policy is an infinite-horizon LQG controller with random weight and covariance matrices. The optimal policy is the finite-horizon LQG controller with respect to the desired weight and covariance matrices. The final Youla-REN cost computed with exact gradients is also shown in the ARS plots for comparison (black dotted line). 

- [4] S. A. Khader, H. Yin, P. Falco, and D. Kragic, “Learning deep energy shaping policies for stability-guaranteed manipulation,” _IEEE Robot. Autom. Lett._ , vol. 6, no. 4, pp. 8583–8590, 2021. 

- [5] J. N. Knight and C. Anderson, “Stable reinforcement learning with recurrent neural networks,” _Int. J. Control. Theory Appl._ , vol. 9, no. 3, pp. 410–420, 2011. 

- [6] F. Gu, H. Yin, L. E. Ghaoui, M. Arcak, P. J. Seiler, and M. Jin, “Recurrent neural network controllers synthesis with stability guarantees for partially observed systems,” in _Conf. AAAI Artif. Intell._ , 2022. 

- [7] D. Youla, J. d. Bongiorno, and H. Jabr, “Modern Wiener–Hopf design of optimal controllers–Part I: The single-input-output case,” _IEEE Trans. Automat. Control_ , vol. 21, no. 1, pp. 3–13, 1976. 

- [8] K. Zhou, J. C. Doyle, K. Glover _et al._ , _Robust and Optimal Control_ . Prentice Hall, 1996. 

- [9] S. P. Boyd and C. H. Barratt, _Linear Controller Design: Limits of Performance_ . Prentice Hall, 1991. 

- [10] M. Rotkowitz and S. Lall, “A characterization of convex problems in decentralized control,” _IEEE trans. Automat. Control_ , vol. 50, no. 12, pp. 1984–1996, 2005. 

- [11] J. W. Roberts, I. R. Manchester, and R. Tedrake, “Feedback controller parameterizations for reinforcement learning,” in _2011 IEEE Symp. ADPRL_ , 2011, pp. 310–317. 

- [12] M. Simchowitz, K. Singh, and E. Hazan, “Improper learning for nonstochastic control,” in _COLT_ , 2020, pp. 3320–3436. 

- [13] I. Mahtout, F. Navas, V. Milan´es, and F. Nashashibi, “Advances in YoulaKucera parametrization: A review,” _Annu. Rev. Control_ , vol. 49, pp. 81– 94, 2020. 

- [14] K. Fujimoto and T. Sugie, “Characterization of all nonlinear stabilizing controllers via observer-based kernel representations,” _Automatica_ , vol. 36, no. 8, pp. 1123–1135, 2000. 

- [15] H. Jaeger, “Adaptive nonlinear system identification with echo state networks,” _NeurIPS_ , vol. 15, pp. 609–616, 2002. 

- [16] J. Miller and M. Hardt, “Stable recurrent models,” in _International Conference on Learning Representations_ , 2019. 

- [17] M. Revay and I. Manchester, “Contracting implicit recurrent neural networks: Stable models with improved trainability,” in _Learning for Dynamics and Control_ . PMLR, 2020, pp. 393–403. 

- [18] M. Revay, R. Wang, and I. R. Manchester, “A convex parameterization of robust recurrent neural networks,” _IEEE Control Syst. Lett._ , vol. 5, no. 4, pp. 1363–1368, 2020. 

- [19] H. Yin, P. Seiler, and M. Arcak, “Stability analysis using quadratic constraints for systems with neural network controllers,” _IEEE Trans. Automat. Control_ , 2021. 

- [20] M. M. Tobenkin, I. R. Manchester, and A. Megretski, “Convex parameterizations and fidelity bounds for nonlinear identification and reducedorder modelling,” _IEEE Trans. Automat. Control_ , vol. 62, no. 7, pp. 3679–3686, 2017. 

- [21] M. Revay, R. Wang, and I. R. Manchester, “Recurrent equilibrium networks: Unconstrained learning of stable and robust dynamical models,” in _IEEE Conf. Decision and Control_ , 2021, pp. 2282–2287. 

- [22] R. S. Sutton and A. G. Barto, _Reinforcement Learning: An Introduction_ , 2nd ed. Cambridge: The MIT Press, 2018. 

- [23] H. Mania, A. Guy, and B. Recht, “Simple random search of static linear policies is competitive for reinforcement learning,” _NeurIPS_ , 2018. 

- [24] H. Robbins and S. Monro, “A stochastic approximation method,” _The annals of mathematical statistics_ , pp. 400–407, 1951. 

- [25] R. Wang and I. R. Manchester, “Youla-REN: Learning nonlinear feedback policies with robust stability guarantees,” _American Control Conference_ , 2022. 

- [26] M. Revay, R. Wang, and I. R. Manchester, “Recurrent equilibrium networks: Flexible dynamic models with guaranteed stability and robustness,” _arXiv preprint arXiv:2104.05942_ , 2021. 

- [27] W. Lohmiller and J.-J. E. Slotine, “On contraction analysis for non-linear systems,” _Automatica_ , vol. 34, no. 6, pp. 683–696, 1998. 

- [28] T. A. Howell, S. L. Cleac’h, J. Z. Kolter, M. Schwager, and Z. Manchester, “Dojo: A differentiable simulator for robotics,” _arXiv preprint arXiv:2203.00806_ , 2022. 

- [29] S. Boyd and L. Chua, “Fading memory and the problem of approximating nonlinear operators with Volterra series,” _IEEE Trans. Circuits Syst._ , vol. 32, no. 11, pp. 1150–1161, 1985. 

- [30] D. P. Kingma and J. L. Ba, “Adam: A method for stochastic optimization,” in _International Conference on Learning Representations_ , 2015. 

