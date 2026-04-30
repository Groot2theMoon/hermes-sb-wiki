---
title: "Recurrent Equilibrium Networks: Flexible Dynamic Models with Guaranteed Stability and Robustness"
arxiv: "2104.05942"
authors: ["Max Revay", "Ruigang Wang", "Ian R. Manchester"]
year: 2021
source: paper
ingested: 2026-05-01
sha256: 85e9c77e3b5583c76ba2b112e4864b8645020e59e3e8d27c812e498bfa4e6b6f
conversion: pymupdf4llm
---

1 

## Recurrent Equilibrium Networks: Flexible Dynamic Models with Guaranteed Stability and Robustness 

Max Revay _[⋆]_ , Ruigang Wang _[⋆]_ , Ian R. Manchester 

_**Abstract**_ **—This paper introduces** _**recurrent equilibrium networks**_ **(RENs), a new class of nonlinear dynamical models for applications in machine learning, system identification and control. The new model class admits “built in” behavioural guarantees of stability and robustness. All models in the proposed class are contracting – a strong form of nonlinear stability – and models can satisfy prescribed incremental integral quadratic constraints (IQC), including Lipschitz bounds and incremental passivity. RENs are otherwise very flexible: they can represent all stable linear systems, all previously-known sets of contracting recurrent neural networks and echo state networks, all deep feedforward neural networks, and all stable Wiener/Hammerstein models, and can approximate all fading-memory and contracting nonlinear systems. RENs are parameterized directly by a vector in** R _[N]_ **, i.e. stability and robustness are ensured without parameter constraints, which simplifies learning since generic methods for unconstrained optimization such as stochastic gradient descent and its variants can be used. The performance and robustness of the new model set is evaluated on benchmark nonlinear system identification problems, and the paper also presents applications in data-driven nonlinear observer design and control with stability guarantees.** 

## I. INTRODUCTION 

Deep neural networks (DNNs), recurrent neural networks (RNNs), and related models have revolutionised many fields of engineering and computer science [1]. Their remarkable flexibility, accuracy, and scalability has led to renewed interest in neural networks in many domains including learningbased/data-driven methods in control, identification, and related areas (see e.g. [2]–[4] and references therein). 

However, it has been observed that neural networks can be very sensitive to small changes in inputs [5], and this sensitivity can extend to control policies [6]. Furthermore, their scale and complexity makes them difficult to certify for use in safety-critical systems, and it can be difficult to incorporate prior physical knowledge into a neural network model, e.g. that a model should be stable. The most accurate current methods for certifying stability and robustness of DNNs and RNNs are based on mixed-integer programming [7] and semidefinite programming [8], [9] both of which face challenges when scaling to large networks. 

> _⋆_ M. Revay and R. Wang made equal contribution to this paper. This work was supported by the Australian Research Council, grant DP190102963. The authors are with the Australian Centre for Robotics and School of Aerospace, Mechanical and Mechatronic Engineering, The University of Sydney, Sydney, NSW 2006, Australia (e-mail: ian.manchester@sydney.edu.au). 

In this paper, we introduce a new model structure: the _recurrent equilibrium network_ (REN). 

- 1) RENs are highly _flexible_ and include many established models as special cases, including DNNs, RNNs, echostate networks and stable linear dynamical systems. 

- 2) RENs admit _built in behavioural guarantees_ such as stability, incremental gain, passivity, or other properties that are relevant to safety critical systems, and are compatible with most existing frameworks for nonlinear/robust stability analysis. 

- 3) RENs are _easy to use_ as they permit a direct (smooth, unconstrained) parameterization enabling learning of largescale models via generic unconstrained optimization algorithms and off-the-shelf automatic-differentiation tools. 

A REN is a dynamical model incorporating an _equilibrium network_ [10]–[12] , a.k.a. _implicit network_ [13]. Equilibrium networks are “implicit depth” neural networks, in which the output is generated as the zero set of an equation relating inputs and outputs, which can be viewed as the equilibrium of a “fast” dynamical system. This implicit structure brings the remarkable flexibility alluded to above, but also raises the question of existence and uniqueness of solutions, i.e. wellposedness. A benefit of our parameterization approach is that the resulting RENs are always well-posed. 

RENs can be constructed to be contracting [14], a strong form of nonlinear stability, and/or to satisfy robustness guarantees in the form of incremental integral quadratic constraints (IQCs) [15]. This class of constraints includes user-definable bounds on the network’s Lipschitz constant (incremental gain), which can be used to trade off performance vs sensitivity to adversarial perturbations. The IQC framework also encompasses many commonly used tools for certifying stability and performance of system interconnections, including passivity methods in robotics [16], networked-system analysis via dissipation inequalities [17], _µ_ analysis [18], and standard tools for analysis of nonlinear control systems [19]. 

## _A. Learning and Identification of Stable Models_ 

The problem of learning dynamical systems with stability guarantees appears frequently in system identification. When learning models with feedback it is not uncommon for the model to be unstable even if the data-generating system is stable. For linear models, various methods have been proposed 

2 

to guarantee stability via regularization and constrained optimization [20]–[24]. For nonlinear models, there has also been a substantial volume of research on stability guarantees, e.g. for polynomial models [25]–[28], Gaussian mixture models [29], and recurrent neural networks [30]–[34]. However, the problem is substantially more complex than the linear case due to the many possible nonlinear model structures and differing definitions of nonlinear stability. Contraction is a strong form of nonlinear stability [14] which is particularly well-suited to problems in learning and system identification since it guarantees stability of _all_ solutions of the model, irrespective of inputs or initial conditions. This is important in learning since the purpose of a model is usually to simulate responses to previously unseen inputs. The works [25]–[28], [30], [33], [34] are guaranteed to find contracting models. 

## _B. Lipschitz Bounds for Neural Network Robustness_ 

Model _robustness_ can be characterized in terms of sensitivity to small perturbations in the input. It has recently been shown that recurrent neural network models can be extremely fragile [35], i.e. small changes to the input produce dramatic changes in the output. 

Formally, sensitivity and robustness can be quantified via _Lipschitz bounds_ on the input-output mapping associated with the model. In machine learning, Lipschitz constants are used in the proofs of generalization bounds [36], analysis of expressiveness [37] and guarantees of robustness to adversarial attacks [38], [39]. There is also ample empirical evidence to suggest that Lipschitz regularity (and model stability, where applicable) improves generalization in machine learning [40] and system identification [33]. In reinforcement learning [41], it has recently been found that the Lipschitz constant of policies has a strong effect on their robustness to adversarial attack [42]. In [43] it was shown that privacy preservation in dynamic feedback policies can be represented as an _ℓ_[2] Lipschitz bound. 

Unfortunately, even calculation of the Lipschitz constant of feedforward (static) neural networks is NP-hard [44]. The tightest tractable bounds known to date use incremental quadratic constraints to construct a behavioural description of the neural network activation functions [45], but using these results in training is complicated by the fact that the constraints are not jointly convex in model parameters and constraint multipliers. In [46], Lipschitz bounded feedforward models were trained using the Alternating Direction Method of Multipliers, and in [33], an a custom interior point solver were used. However, the requirements to satisfy linear matrix inequalities at each iteration make these methods difficult to scale. In [47], the authors introduced a direct parameterization of feedforward neural networks satisfying the bounds of [45], using techniques related to the present paper. 

## _C. Applications of Contracting and Robust Models in DataDriven Control and Estimation_ 

An ability to learn flexible dynamical models with contraction, robustness, and other behavioural constraints has many 

potential applications in control and related fields, some of which we explore in this paper. 

In robotics, passivity constraints are widely used to ensure stable interactions e.g. in teleoperation, vision-based control, and multi-robot control [16] and interaction with physical environments (e.g. [48], [49]). More generally, methods based on quadratic dissipativity and IQCs are a powerful tool for the design of complex interconnected cyber-physical systems [15], [17]. Within these frameworks, the proposed REN architecture can be used to learn subsystems that specify prescribed or parameterized IQCs, and which therefore cannot destabilize the system when interconnected with other components. 

A classical problem in control theory is observer design: to construct a dynamical system that estimates the internal (latent) state of another system from partial measurements. A recent approach is to search for a contracting dynamical system that can reproduce true system trajectories [50], [51]. In Section VIII, we formulate the observer design problem as a supervised learning problem over a set of contracting nonlinear systems, and demonstrate the approach on an unstable nonlinear reaction diffusion PDE. 

In optimization of linear feedback controllers, the classical Youla-Kucera (or _Q_ ) parameterization provides a convex formulation for searching over all stabilizing controllers via a “free” stable linear system parameter [18], [52], [53]. This approach can be extended to nonlinear systems [19], [54] in which the “free parameter” is a stable nonlinear model. In Sec. IX, we apply this idea to optimize nonlinear feedback policies for constrained linear control. 

## _D. Convex and Direct Parameterizations_ 

The central contributions of this paper are new model parameterizations which have behavioral constraints, and which are amenable to optimization. The first set of parameterizations we introduce includes (convex) linear matrix inequality (LMI) constraints, building upon [25], [34]. LMI constraints can be incorporated into a learning process either through introduction of barrier functions or projections. However, they are computationally challenging for large-scale models. For example, a path-following interior point method, as proposed in [34] generally requires computing gradients of barrier functions, line search procedures, and a combination of “inner” and “outer” iterations as the barrier parameter changes. 

To address this challenge, in this paper we also introduce _direct_ parameterizations of contracting and robust RENs. That is, we construct a smooth mapping from R _[N]_ to the model weights such that every model in the image of this mapping satisfies the desired behavioural constraints. This can be thought of as constructing a (redundant) intrinsic coordinate system on the constraint manifold. The construction is related to the method of [55] for semidefinite programming, in which a positivesemidefinite matrix is parameterized by square-root factors. Our parameterization differs in that it avoids introducing any nonlinear equality constraints. 

As mentioned above, direct parameterization allows generic optimization methods such as stochastic gradient descent (SGD) and ADAM [56] to be applied. Another advantage 

3 

is that it allows easy _random sampling_ of nonlinear models with the required stability and robustness constraints by simply sampling a random vector in R _[N]_ . This allows straightforward generation of _echo state networks_ with prescribed behavioral properties, i.e. large-scale recurrent networks with fixed dynamics and learnable output maps (see, e.g., [57], [58] and references therein). 

## _E. Structure of this Paper_ 

The paper structure is as follows: 

- Sections II - VI discuss the proposed model class and its properties. Section II formulates the problem of learning stable and robust dynamical models; in Section III we present the REN model class; in Section IV we present convex parameterizations of stable and robust RENs; in Section V we present direct (unconstrained) parameterisations of RENs; in Section VI we discuss the expressivity of the REN model class, showing it includes many commonly-used models as special cases. 

- Sections VII - IX present applications of learning stable/robust nonlinear models. Section VII presents applications to system identification; Section VIII presents applications to nonlinear observer design; Section IX presents applications to nonlinear feedback design for linear systems. Associated Julia code is available in the package RobustNeuralNetworks.jl [59]. 

A preliminary conference version was presented in [60]. The present paper expands the class of robustness properties to more general dissipativity conditions, removes the restriction that the model has zero direct-feedthrough, introduces the acyclic REN, adds proofs of all theoretical results, adds new material on echo state networks, and includes novel approaches to nonlinear observer design and optimization of feedback controllers enabled by the REN. 

## _F. Notation_ 

The set of sequences _x_ : N _→_ R _[n]_ is denoted by _ℓ[n]_ 2 _e_[.] Superscript _n_ is omitted when it is clear from the context. For _x ∈ ℓ[n]_ 2 _e_[,] _[x][t][∈]_[R] _[n]_[is][the][value][of][the][sequence] _[x]_[at] time _t ∈_ N. The subset _ℓ_ 2 _⊂ ℓ_ 2 _e_ consists of all squaresummable sequences, i.e., _x ∈ ℓ_ 2 if and only if the _ℓ_ 2 ~~_∞_~~ norm _∥x∥_ := ~~�~~ � _t_ =0 _[|][x][t][|]_[2][is][finite,][where] _[|]_[(] _[·]_[)] _[|]_[denotes] Euclidean norm. Given a sequence _x ∈ ℓ_ 2 _e_ , the _ℓ_ 2 norm _T_ of its truncation over [0 _, T_ ] is _∥x∥T_ := ~~�~~ � _t_ =0 _[|][x][t][|]_[2][.][For] two sequences _x, y ∈ ℓ[n]_ 2 _e_[,][the][inner][product][over][[0] _[, T]_[]][is] _⟨x, y⟩T_ :=[�] _[T] t_ =0 _[x] t[⊤][y][t]_[.][We][use] _[A][ ≻]_[0][and] _[A][ ⪰]_[0][to][denote][a] positive definite and positive semi-definite matrix, respectively. We denote the set of positive-definite diagonal matrices by D+. Given a positive-definite matrix _P_ we use _| · |P_ to denote the weighted Euclidean norm, i.e. _|a|P_ = _√a[⊤] Pa_ . 

## II. LEARNING STABLE AND ROBUST MODELS 

This paper is concerned with _learning_ of nonlinear dynamical models, i.e. finding a particular model within a set of candidates using some _data_ relevant to the problem at hand. The central aim of this paper is to construct model classes that 

are _flexible_ enough to make full use of available data, and yet _guaranteed_ to be well-behaved in some sense. 

Given a dataset _z_ ˜, we consider the problem of learning a nonlinear state-space dynamical model of the form 

**==> picture [207 x 11] intentionally omitted <==**

that minimizes some loss or cost function depending (in part) on the data, i.e. to solve a problem of the form 

**==> picture [153 x 16] intentionally omitted <==**

In the above, _xt ∈_ R _[n] , ut ∈_ R _[m] , yt ∈_ R _[p] , θ ∈_ Θ _⊆_ R _[N]_ are the model state, input, output and parameters, respectively. Here _f_ : R _[n] ×_ R _[m] ×_ Θ _→_ R _[n]_ and _g_ : R _[n] ×_ R _[m] ×_ Θ _→_ R _[p]_ are piecewise continuously differentiable functions. 

_Example 1:_ In the context of system identification we may have _z_ ˜ = (˜ _y,_ ˜ _u_ ) consisting of finite sequences of input-output measurements, and aim to minimize _simulation error_ : 

**==> picture [168 x 12] intentionally omitted <==**

where _y_ = R _a_ (˜ _u_ ) is the output sequence generated by the nonlinear dynamical model (1) with initial condition _x_ 0 = _a_ and inputs _ut_ = _u_ ˜ _t_ . Here the initial condition _a_ may be part of the data _z_ ˜, or considered a learnable parameter in _θ_ . 

The main contributions of this paper are model parameterizations, and we make the following definitions: 

_Definition 1:_ A model parameterization (1) is called a _convex parameterization_ if Θ _⊆_ R _[N]_ is a convex set. Furthermore, it is called a _direct parameterization_ if Θ = R _[N]_ . 

Direct parameterizations are useful for learning large-scale models since many scalable unconstrained optimization methods (e.g. stochastic gradient descent) can be applied to solve (2). We will parameterize stable nonlinear models, and the particular form of stability we use is the following: 

_Definition 2:_ A model (1) is said to be _contracting with rate α ∈_ (0 _,_ 1) if for any two initial conditions _a, b ∈_ R _[n]_ , given the same input sequence _u ∈ ℓ[m]_ 2 _e_[,][the][state][sequences] _[x][a]_[and] _x[b]_ satisfy 

**==> picture [176 x 12] intentionally omitted <==**

for some _K >_ 0. 

Roughly speaking, contracting models forget their initial conditions exponentially. Beyond stability, we will also consider robustness constraints of the following form: 

_Definition 3:_ A model (1) is said to satisfy the _incremental integral quadratic constraint_ (IQC) defined by ( _Q, S, R_ ) where 0 _⪰ Q ∈_ R _[p][×][p]_ , _S ∈_ R _[m][×][p]_ , and _R_ = _R[⊤] ∈_ R _[m][×][m]_ , if for all pairs of solutions with initial conditions _a, b ∈_ R _[n]_ and input sequences _u, v ∈ ℓ[m]_ 2 _e_[,][the][output][sequences] _[y][a]_[=][ R] _[a]_[(] _[u]_[)] and _y[b]_ = R _b_ ( _v_ ) satisfy 

**==> picture [243 x 30] intentionally omitted <==**

for some function _d_ ( _a, b_ ) _≥_ 0 with _d_ ( _a, a_ ) = 0. Important special cases of incremental IQCs include: 

_• Q_ = _− γ_[1] _[I, R]_[=] _[γI, S]_[=][0][:][the][model][satisfies][an] _[ℓ]_[2] Lipschitz bound, a.k.a. incremental _ℓ_[2] -gain bound, of _γ_ : 

**==> picture [151 x 11] intentionally omitted <==**

4 

for all _u, v ∈ ℓ[m]_ 2 _e[,][T][∈]_[N] _[.]_ 

- _Q_ = 0 _, R_ = _−_ 2 _νI, S_ = _I_ where _ν ≥_ 0: the model is monotone on _ℓ_[2] (strongly if _ν >_ 0), a.k.a. incrementally passive (incrementally strictly input passive, resp.): 

_⟨_ R _a_ ( _u_ ) _−_ R _a_ ( _v_ ) _, u_ – _v⟩T ≥ ν∥u − v∥T_[2] 

for all _u, v ∈ ℓ[m]_ 2 _e_[and] _[T][∈]_[N][.] 

- _Q_ = _−_ 2 _ρI, R_ = 0 _, S_ = _I_ where _ρ >_ 0: the model is incrementally strictly output passive: 

_⟨_ R _a_ ( _u_ ) _−_ R _a_ ( _v_ ) _, u_ – _v⟩T ≥ ρ∥_ R _a_ ( _u_ ) _−_ R _a_ ( _v_ ) _∥T_[2] 

for all _u, v ∈ ℓ[m]_ 2 _e_[and] _[ T][∈]_[N][. If] _[ ρ]_[ = 1][ the model is] _[ firmly] nonexpansive_ on _ℓ_[2] . 

In other contexts, _Q, S, R_ may themselves be decision variables in a separate optimization problem to ensure stability of interconnected systems (see, e.g., [15], [17] . 

_Remark 1:_ Given a model class guaranteeing incremental IQC defined by constant matrices _Q, S, R_ , it is straightforward to construct models satisfying _frequency-weighted_ IQCs. E.g. by constructing a model R that is contracting and satisfies an _ℓ_[2] Lipschitz bound, and choosing stable linear filters _**W**_ 1 _,_ _**W**_ 2, with _**W**_ 1 having a stable inverse, the new model 

**==> picture [127 x 12] intentionally omitted <==**

**==> picture [143 x 80] intentionally omitted <==**

**----- Start of picture text -----**<br>
σ<br>v w<br>G<br>y u<br>**----- End of picture text -----**<br>


Fig. 1: REN as a feedback interconnection of a linear system _G_ and a nonlinear activation _σ_ . 

It will be convenient to represent the REN model as a feedback interconnection of a linear system _G_ and a memoryless nonlinear operator _σ_ , as depicted in Fig. 1: 

**==> picture [233 x 71] intentionally omitted <==**

where _vt, wt ∈_ R _[q]_ are the input and output of activation functions respectively. The learnable parameter is _θ_ := _{W, b}_ where _W ∈_ R[(] _[n]_[+] _[q]_[+] _[p]_[)] _[×]_[(] _[n]_[+] _[q]_[+] _[m]_[)] is the weight matrix, and _b ∈_ R _[n]_[+] _[q]_[+] _[p]_ the bias vector. Typically the activation function _σ_ is fixed, although this is not essential. 

is contracting and satisfies the frequency-weighted bound 

**==> picture [193 x 11] intentionally omitted <==**

**==> picture [187 x 9] intentionally omitted <==**

The model structure we propose – the _recurrent equilibrium network_ (REN) – is a state-space model of the form (1) with 

**==> picture [204 x 26] intentionally omitted <==**

in which _wt_ is the solution of an _equilibrium network_ , a.k.a. _implicit network_ [10]–[13]: 

**==> picture [207 x 11] intentionally omitted <==**

where _A, B·, C·, D·_ are matricies of appropriate dimension, _bx ∈_ R _[n] , by ∈_ R _[p] , bv ∈_ R _[q]_ are “bias” vectors, and _σ_ is a scalar nonlinearity applied elementwise, referred to as an “activation function”. We will show below how to ensure that a unique solution _wt[∗]_[to][(8)][exists][and][can][be][computed][efficiently.] 

_Remark 2:_ The term “equilibrium” comes from the fact that any solution of the above implicit equation is also an equilibrium point of the difference equation _wt[k]_[+1] = _σ_ ( _Dwt[k]_[+] _[ b][w]_[)] _d_ or the ordinary differential equation _ds[w][t]_[(] _[s]_[)][=] _[−][w][t]_[(] _[s]_[)][+] _σ_ ( _Dwt_ ( _s_ )+ _bw_ ), where _bw_ = _C_ 1 _xt_ + _D_ 12 _ut_ + _bv_ is considered “frozen” for each _t_ . One interpretation of the REN model is that it represents a two-timescale or singular perturbation model, in which the “fast” dynamics in _w_ are assumed to reach the equilibrium (8) well within each time-step of the “slow” dynamics in _x_ (6). 

## _A. Flexibility of Equilibrium Networks_ 

In [34] we introduced and studied a class of models similar to (6), (7), (8) with the exception that _D_ 11 was absent[1] . This apparently minor change to the model has far-reaching consequences in terms of greatly increased representational flexibility and significantly simpler learning algorithms, while also requiring assurances about existence of solutions and their efficient computation. 

With _D_ 11 = 0, the network (8) is simply a single-layer neural network. In contrast, equilibrium networks ( _D_ 11 = 0) are much more flexible, with many commonly-used feedforward network architectures included as special cases. For example, consider a standard _L_ -layer deep neural network: 

**==> picture [208 x 37] intentionally omitted <==**

where _zl_ is the output of the _l_ th hidden layer. This can be written as an equilibrium network with 

**==> picture [251 x 90] intentionally omitted <==**

> 1Note that [34] used different notation, so in that paper it was actually _D_ 22 which was absent, corresponding to _D_ 11 in the notation of the present paper. 

5 

Equilibrium networks can represent many other interesting structures including residual, convolution, and other feedforward networks. The reader is referred to [10]–[13] for further discussion of equilibrium networks and their properties. 

Allowing _D_ 11 to be non-zero is also key to our construction of direct paramaterizations of contracting and robust RENs (in Sec. V). As discussed in Section I-D this enables model learning via simple and generic first-order optimization methods, whereas [34] required a specialized interior-point method to deal with model behavioural constraints. Direct parameterization also enables easy random sampling of contracting models, so-called _echo state networks_ (see Sec. V-C) and this enables convex learning of nonlinear feedback controllers (see Sec. IX). 

## _B. Well-posedness of Equilibrium Networks and Acyclic RENs_ 

The added flexibility of equilibrium networks comes at a price: depending on the value of _D_ 11, the implicit equation (8) may or may not admit a unique solution _wt_ for a given _xt, ut_ . An equilibrium network or REN is _well-posed_ if a unique solution is guaranteed. In [12] it was shown that if there exists a Λ _∈_ D _[n]_ +[such][that] 

**==> picture [183 x 12] intentionally omitted <==**

then the equilibrium network is well-posed. We will show in Theorem 1 below that this is always satisfied for our proposed model parameterizations. 

A useful subclass of REN that is trivially well-posed is the _acyclic REN_ where the weight _D_ 11 is constrained to be strictly lower triangular. In this case, the elements of _wt_ can be explicitly computed row-by-row from (8). We can interpret _D_ 11 as the adjacency matrix of a directed graph defining interconnections between the neurons in the equilibrium network and if _D_ 11 is strictly lower triangular then this graph is guaranteed to be acyclic. Compared to the general REN, the acyclic REN is simpler to implement and in our experience often provides models of similar quality, as will be discussed in Sec. VII-B. 

## _C. Evaluating RENs and their gradients_ 

For a well-posed REN with full _D_ 11, solutions can be computed by formulating an equivalent monotone operator splitting problem [61]. In the authors’ experience, the Peaceman Rachford algorithm is reliable and efficient [12]. 

When training an equilibrium network via gradient descent, we need to compute the Jacobian _∂wt[∗][/∂]_[(] _[·]_[)][where] _[w] t[∗]_[is][the] solution of the implicit equation (8), and ( _·_ ) denotes the input to the network or model parameters. By using the implicit function theorem, _∂wt[∗][/∂]_[(] _[·]_[)][can][be][computed][via] 

**==> picture [201 x 25] intentionally omitted <==**

where _J_ is the Clarke generalized Jacobian of _σ_ at _Dwt[∗]_[+] _[b][w]_[.] From Assumption 1 in Section III-D, we have that _J_ is a singleton almost everywhere. It was shown in [12] that Condition (12) implies matrix _I − JD_ is invertible. 

## _D. Contracting and Robust RENs_ 

We call the model of (9), (10) a contracting REN (C-REN) if it is contracting and a robust REN (R-REN) if it satisfies the incremental IQC. We make the following assumption on _σ_ , which holds for commonly-used activation functions [62]: 

_Assumption 1:_ The activation function _σ_ is piecewise differentiable and slope-restricted in [0 _,_ 1], i.e., 

**==> picture [253 x 52] intentionally omitted <==**

_Theorem 1:_ Consider the REN model (9), (10) satisfying Assumption 1, and a given _α_ ¯ _∈_ (0 _,_ 1]. 

- 1) **Contracting REN:** suppose there exists _P_ = _P[⊤] ≻_ 0 and Λ _∈_ D+ such that 

**==> picture [211 x 27] intentionally omitted <==**

where _W_ = 2Λ _−_ Λ _D_ 11 _− D_ 11 _[⊤]_[Λ][.][Then][the][REN][is] well-posed and contracting with some rate _α < α_ ¯. 

- 2) **Robust REN:** consider the incremental defined in IQC (5) with given ( _Q, S, R_ ) where _Q ⪯_ 0. Suppose there exist _P_ = _P[⊤] ≻_ 0 and Λ _∈_ D+ such that 

**==> picture [217 x 88] intentionally omitted <==**

Then the REN is well-posed, satisfies (5) and is contracting with a rate _α < α_ ¯. 

The proof can be found in Appendix A. The main idea behind the LMI for the contracting REN is to use an incremental Lyapunov function _V_ (∆ _x_ ) = _|_ ∆ _x|_[2] _P_[,][where][∆] _[x]_[denotes][the] difference between a pair of solutions, and show that 

**==> picture [212 x 13] intentionally omitted <==**

and that Γ(∆ _vt,_ ∆ _wt_ ) _≥_ 0 for the activation function _σ_ , where Γ is an incremental quadratic constraint as in [9], [34] with a multiplier matrix Λ. The construction for the Robust REN is similar, but uses an incremental dissipation inequality. 

_Remark 3:_ Note that (15) and (16) immediately imply that _W ≻_ 0, which is precisely the equilibrium network wellposedness condition (12). 

_Remark 4:_ For a fixed REN model, Conditions (15) and (16) are convex in the stability/performance certificate _P_ and IQC multiplier Λ. However they are not _jointly_ convex in the model parameters _θ_ , certificate _P_ , and multiplier Λ. We will resolve this in the next section. 

_Remark 5:_ The proof is based on IQC characterization of (14) with a diagonal multiplier matrix Λ. If signal boundedness is of interest rather than contraction, then one can use a richer 

6 

class of multipliers designed for repeated nonlinearities [63]– [65]. However, these multipliers are not valid for incremental IQCs and contraction [12]. 

While _Q, S, R_ can be chosen so that a robust REN verifies a _particular_ Lipschitz bound _γ_ , the following weaker property is true of contracting RENs: 

_Theorem 2:_ Every contracting REN – i.e. a model (9), (10) satisfying Assumption 1 and (15) – satisfies the _ℓ_[2] Lipschitz condition for some bound _γ < ∞_ . The proof is in Appendix B. 

## IV. CONVEX PARAMETERIZATIONS OF RENS 

In this section we propose convex parameterizations for C-RENs/R-RENs, which are based on the following implicit representation of the linear component _G_ : 

**==> picture [219 x 52] intentionally omitted <==**

where _E_ is an invertible matrix and Λ is a positivedefinite diagonal matrix. The model parameters are _θ_ cvx := _{E,_ Λ _, W,_[�][˜] _b}_ . 

Note that _θ_ cvx can easily be mapped to _θ_ by multiplying the first and second rows of (18) by _E[−]_[1] and Λ _[−]_[1] , respectively. Therefore the parameters _E_ and Λ do not expand the model set, however the extra degrees of freedom will allow us to formulate sets of C-RENs and R-RENs that are jointly convex in the model parameters, stability certificate, and multipliers. 

_Definition 4:_ A model of the form (18), (10) is said to be ˜well-posed _b_ , and henceif ait uniqueyields aresponseunique (to _wt_ any _, xt_ +1initial) for conditionsany _xt, ut_ andand input. 

To construct a convex parameterization of C-RENs, we introduce the following LMI constraint: 

**==> picture [237 x 37] intentionally omitted <==**

where _W_ = 2Λ _−D_ 11 _−D_ 11 _[⊤]_[.][The][convex][parameterization][of] C-RENs is then given by 

**==> picture [201 x 13] intentionally omitted <==**

To construct convex parameterization of R-RENs, we propose the following convex constraint: 

**==> picture [244 x 89] intentionally omitted <==**

where _Q ⪯_ 0, _S_ , and _R_ are given. The convex parameterization of R-RENs is then defined as 

**==> picture [165 x 13] intentionally omitted <==**

The following results relates the above parameterizations to the desired model behavioural properties: 

_Theorem 3:_ All models in Θ _C_ are well-posed and contracting with rate _α < α_ ¯. All models in Θ _R_ are well-posed, contracting with rate _α < α_ ¯, and satisfy the IQC defined by ( _Q, S, R_ ). 

The proof can be found in the Appendix C. 

_Remark 6:_ With the convex parameterizations, is straightforward to enforce any desired sparsity structure on _D_ 11, e.g. corresponding to a multi-layer neural network as per Section III-A. Since Λ is diagonal, the sparsity structures of _D_ 11 and _D_ 11 = Λ _[−]_[1] _D_ 11 are identical, and so the desired structure can be added as a linear constraint on _D_ 11. 

## V. DIRECT PARAMETERIZATIONS OF RENS 

In the previous section we gave convex parameterizations of contracting and robust RENs in terms of linear matrix inequalities (LMIs), i.e. intersections of the cone of positive semidefinite matrices with affine constraints. While convexity of a model set is useful, LMIs are challenging to verify for large-scale models, and especially to enforce during training. 

In this section we provide direct parameterizations, i.e. smooth mappings from R _[N]_ to the weights and biases of a REN, enabling _unconstrained_ optimization methods to be applied. We do so by first constructing representations of RENs directly in terms of the positive semidefinite cone _without_ affine constraints, and then parameterize this cone in terms of its square-root factors. 

## _A. Direct Parameterizations of Contracting RENs_ 

The key observation leading to our construction is that the mapping from contracting REN parameters _θ_ cvx to _H_ in (21) is _surjective_ , i.e. it maps onto the entire cone of positivedefinite matrices. Furthermore, as we will show below it is straightforward to construct a (non-unique) inverse that maps from _any_ positive-definite matrix back to _θ_ cvx defining a wellposed and contracting REN. 

_a) Free parameters:_ of the parameters in _θ_ cvx, the following have no effect on stability and can be freely parameterized in terms of their elements: _B_ 2 _∈_ R _[n][×][m]_ , _C_ 2 _∈_ R _[p][×][n]_ , _D_ 12 _∈_ R _[q][×][m]_ , _D_ 21 _∈_ R _[p][×][q]_ , _D_ 22 _∈_ R _[p][×][m] ,_[˜] _b ∈_ R[(2] _[n]_[+] _[q]_[)] . 

_b) Constrained parameters, acyclic case:_ the parameters _E, F,_ Λ _, B_ 1 and _C_ 1 relate to internal dynamics and therefore affect the stability properties of a REN. Here we construct them from two free matrix variables _X ∈_ R[(2] _[n]_[+] _[q]_[)] _[×]_[(2] _[n]_[+] _[q]_[)] and _Y_ 1 _∈_ R _[n][×][n]_ . 

We first construct _H_ from _X_ as 

**==> picture [219 x 37] intentionally omitted <==**

where _ϵ_ is a small positive scalar, and we have partitioned _H_ into blocks of size _n, n_ , and _q_ . Comparing (21) to (19) we can immediately construct 

**==> picture [240 x 10] intentionally omitted <==**

7 

Further, it is straightforward to verify that the construction 

**==> picture [195 x 21] intentionally omitted <==**

results in _H_ 11 = _E_ + _E[⊤] − α_ ¯1[2] _[P]_[for][any] _[Y]_[1][.] We then construct a strictly lower-triangular _D_ 11 satisfying 

**==> picture [188 x 13] intentionally omitted <==**

by partitioning _H_ 22 into its diagonal and strictly upper/lower triangular components: 

**==> picture [168 x 11] intentionally omitted <==**

where Φ is a diagonal matrix and _L_ is a strictly lowertriangular matrix, from which we construct the remaining parameters in _θ_ cvx: 

**==> picture [171 x 21] intentionally omitted <==**

_c) Constrained parameters, full case:_ The construction of a C-REN with full (not acyclic) _D_ 11 is the same except that we introduce two additional free variables: _g ∈_ R _[q]_ and _Y_ 2 _∈_ R _[q][×][q]_ , and then construct a positive diagonal matrix Λ = _e_[diag(] _[g]_[)] and 

**==> picture [193 x 21] intentionally omitted <==**

which also results in parameters satisfying (24). 

## _B. Direct Parameterizations of Robust RENs_ 

We now provide a direct parameterization of RENs satisfying the robustness condition (20). The first step is to rearrange (20) into an equivalent form which will turn out to be useful in the construction since it makes explicit the connection between the R-REN and C-REN conditions: 

**==> picture [242 x 65] intentionally omitted <==**

where _H_ ( _θ_ cvx) is the C-REN condition defined in (19), _C_ 2 = ( _D_ 22 _[⊤][Q]_[ +] _[ S]_[)] _[C]_[2][and] _[D]_[21][= (] _[D]_ 22 _[⊤][Q]_[ +] _[ S]_[)] _[D]_[21] _[−D]_ 12 _[⊤]_[.] 

The first construction we give is for the simplest case without direct-feedthrough, i.e. _D_ 22 = 0. However, some practically useful constraints require _D_ 22 = 0, e.g., incremental passivity requires _D_ 22 + _D_ 22 _[⊤][≻]_[0][.][We][consider][this][more] general case below. 

_1) Models with D_ 22 = 0 _:_ for models with no direct feedthrough we have the following direct parameterization. 

_a) Free variables:_ the following matrix variables can be freely parameterized in terms of their elements: _B_ 2 _∈_ R _[n][×][m]_ , _C_ 2 _∈_ R _[p][×][n]_ , _D_ 12 _∈_ R _[q][×][m]_ , _D_ 21 _∈_ R _[p][×][q]_ ,[˜] _b ∈_ R[(2] _[n]_[+] _[q]_[)] 

_b) Constrained parameters:_ the construction is similar to the contracting case in Section V-A. 

Since _D_ 22 = 0, Condition (28a) reduces to _R ≻_ 0, which is independent of model parameters. Now Condition (28b) can be satisfied if we construct _H_ as 

**==> picture [245 x 55] intentionally omitted <==**

with _X_ a free matrix variable, and then recover the remaining model parameters from _H_ as per Section V-A. Note that _H ≻_ 0, since _R ≻_ 0 and _Q ⪯_ 0. 

_2) Models with D_ 22 = 0 _:_ in this case we need to construct a _D_ 22 satisfying (28a). In what follows it will be useful to have _Q_ invertible but we have only assumed that _Q ⪯_ 0. If _Q_ is not negative-definite, we introduce _Q_ = _Q − εI ≺_ 0 and note that (28a) is equivalent to 

**==> picture [206 x 13] intentionally omitted <==**

for sufficiently small _ε >_ 0. If _Q ≺_ 0 we simply set _ε_ = 0, i.e. _Q_ = _Q_ . 

We factor _Q_ = _−L[⊤] Q[L][Q]_[, and we will show (see Proposition] 1) that _R − SQ[−]_[1] _S[⊤] ≻_ 0 hence there is an invertible _LR ∈_ R _[m][×][m]_ such that _L[⊤] R[L][R]_[=] _[ R][ −][S][Q][−]_[1] _[S][⊤]_[.] 

The direct parameterization of _D_ 22 is 

**==> picture [189 x 14] intentionally omitted <==**

where construction of _N_ depends on the input and output dimensions. If _p ≥ m_ we take 

**==> picture [209 x 41] intentionally omitted <==**

with _X_ 3 _, Y_ 3 _∈_ R _[m][×][m]_ and _Z_ 3 _∈_ R[(] _[p][−][m]_[)] _[×][m]_ as free variables. Note that _M_ + _M[⊤] ≻_ 0 so _I_ + _M_ is invertible. 

If _p < m_ , _M_ is the same but we take 

**==> picture [234 x 13] intentionally omitted <==**

with _X_ 3 _, Y_ 3 _∈_ R _[p][×][p]_ and _Z_ 3 _∈_ R[(] _[m][−][p]_[)] _[×][p]_ as free variables. 

_Proposition 1:_ The construction of _D_ 22 in (31), (32) or (33) is well-defined and satisfies Condition (30). The proof is in Appendix D. 

_a) Special Cases:_ the following are direct parameterizations of _D_ 22 for some commonly-used robustness conditions: 

- Incrementally _ℓ_ 2 stable RENs with Lipschitz bound of _γ_ (i.e., _Q_ = _− γ_[1] _[I, R]_[=] _[ γI, S]_[= 0][):][We][have] _[D]_[22][given][in] (31) with _LQ_ = _I_ and _LR_ = _γI_ . 

- Incrementally strictly output passive RENs (i.e., _Q_ = _−_ 2 _ρI, R_ = 0 _, S_ = _I_ ): We have _D_ 22 = _ρ_[1][(] _[I]_[+] _[ M]_[)] _[−]_[1][.] 

- Incrementally input passive RENs (i.e., _Q_ = 0 _, R_ = _−_ 2 _νI, S_ = _I_ ): In this case, Condition (28a) becomes an LMI of the form _D_ 22 + _D_ 22 _[⊤][−]_[2] _[νI][≻]_[0][,][which][yields] a simple parameterization with _D_ 22 = _νI_ + _M_ . 

8 

_C. Random Sampling of Nonlinear Systems and Echo State Networks_ 

One benefit of the direct parameterizations of RENs is that it is straightforward to randomly sample systems with the desired behavioural properties. Since contracting and robust RENs are constructed as the image of R _[N]_ under a smooth mapping (Sections V-A and V-B), one can sample random vectors in R _[N]_ and map them to random stable/robust nonlinear dynamical systems. 

An “echo state network” is a model in which the state-space dynamics are randomly sampled but thereafter fixed, and with a learnable output map (see ,e.g., [57], [58]): 

**==> picture [166 x 11] intentionally omitted <==**

**==> picture [165 x 11] intentionally omitted <==**

where _f_ is fixed and _g_ is affinely parameterized by _θ_ , i.e. 

**==> picture [177 x 22] intentionally omitted <==**

Then, system identification with a simulation-error criteria can be solved as a basic least squares problem. This approach is reminiscent of system identification via a basis of stable linear responses (see, e.g., [66]). 

For this approach to work over long horizons, it is essential that the random dynamics are stable. In [57], [58] and references therein, contraction of (34) is referred to as the “echo state property”, and simple parameterizations are given for which contraction is guaranteed. The direct parameterizations of REN can be used to randomly sample from a rich class of contracting models, by sampling _X, Y_ 1 _, Y_ 2 _, B_ 2 _, D_ 12 to construct the state-space dynamics and equilibrium network. Such a model can be used e.g. for system identification by simulating its response to inputs to generate data _u_ ˜ _t,_ ˜ _xt, w_ ˜ _t_ , and then the output mapping 

**==> picture [142 x 11] intentionally omitted <==**

can be fit to _y_ ˜ _t_ , minimizing (3) via least-squares to obtain the parameters _C_ 2 _, D_ 21 _, D_ 22 _, by_ . We will also see in Section IX how this approach can be applied in data-driven feedback control design. 

## VI. EXPRESSIVITY OF REN MODEL CLASS 

The set of RENs contain many widely-used model structures as special cases, some of which we briefly describe here. 

_a) Deep, Residual, and Equilibrium Networks:_ as a special case with _A, C_ 1 _, C_ 2 _, B_ 1 _, B_ 2 all zero, RENs include (static) equilibrium networks, which as discussed in Section III-A and [11]–[13] include standard deep neural networks (multi-layer perceptrons), residual networks, and others. 

_b) Previously proposed stable RNNs:_ if we set _D_ 11 = 0, then the nonlinearity is not an equilibrium network but a single-hidden-layer neural network, and our model set Θ _C_ reduces to the model set proposed in [34]. Therefore, the REN model class also includes all other models that were proven to be in that model set in [34, Theorem 5], including prior sets of contracting RNNs including the ciRNN [33] and s-RNN [30]. 

_c) Stable linear systems:_ setting _B_ 1 _, C_ 1 _, D_ 11 _, D_ 12 _, D_ 21 and _b_ to zero, RENs include all stable finite-dimensional linear time-invariant (LTI) systems (see [34, Theorem 4]). 

_d) Previously proposed stable echo state networks:_ the stability condition for the ciRNN is the same as that proposed for echo state networks in [57], [58], hence by randomly sampling RENs as in Section V-C we sample from a strictly larger set of echo state networks than previously known. 

_e) Nonlinear finite impulse response (NFIR) Models:_ an NFIR model a nonlinear mapping of a fixed history of inputs: 

**==> picture [105 x 11] intentionally omitted <==**

for some fixed _h_ . Setting 

**==> picture [231 x 61] intentionally omitted <==**

The output _y_ is then a nonlinear function (an equilibrium network) of such truncated history of inputs. 

_f) Block structured models:_ these are constructed from series interconnections of LTI systems and static nonlinearities [67], [68], and are included within the REN model set. For example: 

- 1) _Wiener systems_ consist of an LTI block followed by a static non-linearity. This structure is replicated in (9), (10) when _B_ 1 = 0 and _C_ 2 = 0. In this case the linear dynamical system evolves independently of the non-linearities and feeds into a equilibrium network. 

- 2) _Hammerstein systems_ consist of a static non-linearity connected to an LTI system. This is represented in the REN when _B_ 2 = 0 and _C_ 1 = 0. In this case the input passes through a static equilibrium network and into an LTI system. 

More generally, arbitrary series and parallel interconnections of LTI systems and static nonlinearities can also be constructed. 

_g) Universal approximation properties:_ it is well known even single-hidden-layer neural networks have universal approximation properties, i.e. as the number of neurons goes to infinity they can approximate any continuous function over a bounded domain with arbitrary accuracy. RENs immediately inherit this property for universal approximation of static maps, NFIR models, and other block-structured models. 

Furthermore, it was shown in [69] that as the number of states and activation functions grows, the REN structure is a universal approximator of fading-memory nonlinear systems as defined in [70], as well as all nonlinear dynamical systems that are contracting and have finite Lipschitz bounds. 

## VII. USE CASE: STABLE AND ROBUST NONLINEAR SYSTEM IDENTIFICATION 

In this section we demonstrate the proposed models on the F16 ground vibration [71] and Wiener Hammerstein with process noise [72] system identification benchmarks. We will compare the acyclic C-REN and Lipschitz-bounded R-REN 

9 

with prescribed Lipschitz bound of _γ_ with the widely-used long short-term memory (LSTM) [73] and standard RNN models with a similar number of parameters. We will also compare to the Robust RNN proposed in [34] using the code from github.com/imanchester/RobustRNN. 

We fit models by minimizing simulation error: 

**==> picture [183 x 12] intentionally omitted <==**

using minibatch gradient descent with the Adam optimizer [56]. Model performance is measured by normalized root mean square error on the test sets, calculated as: 

**==> picture [184 x 25] intentionally omitted <==**

Model robustness is measured in terms of the maximum observed sensitivity: 

**==> picture [190 x 25] intentionally omitted <==**

We find a local solution to (39) using gradient ascent with the Adam optimizer. Consequently _γ_ is a lower bound on the true Lipschitz constant of the sequence-to-sequence map. 

## _A. Benchmark Datasets and Training Details_ 

_1) F16 System Identification Benchmark:_ The F16 ground vibration benchmark dataset [71] consists of accelerations measured by three accelerometers, induced in the structure of an F16 fighter jet by a wing mounted shaker. We use the multisine excitation dataset with full frequency grid. This dataset consists of 7 multi-sine experiments with 73,728 samples and varying amplitude. We use datasets 1, 3, 5 and 7 for training and datasets 2, 4 and 6 for testing. 

All models in our comparison have approximately 118,000 parameters: the RNN has 340 neurons, the LSTM has 170 neurons and the RENs have width _n_ = 75 and _q_ = 150. Models were trained for 70 epochs with a sequence length of 1024. The learning rate was initalized at 10 _[−]_[3] and was reduced by a factor of 10 every 20 Epochs. 

_2) Wiener-Hammerstein With Process Noise Benchmark:_ The Wiener Hammerstein with process noise benchmark dataset [72] involves the estimation of the output voltage from two input voltage measurements from a Wiener-Hammerstein system with large process noise. We have used the multi-sine fade-out dataset consisting of two realisations of a multi-sine input signal with 8192 samples each. The test set consists of two experiments, a random phase multi-sine and a sine sweep, conducted without the added process noise. 

All models in our comparison have approximately 42,000 parameters: the RNN has 200 neurons, the LSTM has 100 neurons and the RENs have _n_ = 40 and _q_ = 100. Models were trained for 60 epochs with a sequence length of 512. The initial learning rate was 10 _[−]_[3] and was reduced to 10 _[−]_[4] after 40 epochs. 

**==> picture [201 x 134] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 . 6<br>R-aREN γ = 10<br>R-aREN γ = 20<br>0 . 5 R-aREN γ = 40<br>C-aREN<br>Robust RNN γ = 10<br>0 . 4 Robust RNN γ = 20<br>Robust RNN γ = 40<br>Robust RNN γ =  ∞<br>LSTM<br>0 . 3<br>RNN<br>0 . 2<br>0 . 1<br>10 100 1000<br>γ<br>NRMSE<br>**----- End of picture text -----**<br>


Fig. 2: Nominal performance versus robustness for models trained on F16 ground vibration benchmark dataset. The dashed vertical lines are the guaranteed upper bounds on _γ_ corresponding to the models with matching color. 

## _B. Results and Discussion_ 

In Figs. 2 and 3 we have plotted the test-set NRMSE (38) versus the observed sensitivity (39) for each of the models trained on the F16 and Wiener-Hammerstein Benchmarks, respectively. The dashed vertical lines show the guaranteed Lipschitz bounds for the REN and Robust RNN models. 

We observe that the REN offers the best trade-off between nominal performance and robustness, with the REN slightly outperforming the LSTM in terms of nominal test error for large _γ_ . By tuning _γ_ , nominal test performance can be tradedoff for robustness, signified by the consistent trend moving diagonally up and left with decreasing _γ_ . In all cases, we found that the REN was significantly more robust than the RNN, typically having about 10% of the sensitivity for the F16 benchmark and 1% on the Wiener-Hammerstein benchmark. Also note that for small _γ_ , the observed lower bound on the Lipschitz constant is very close to the guaranteed upper bound, showing that the real Lipschitz constant of the models is close to the upper bound. 

Compared to the robust RNN proposed in [34], the REN has similar bounds on the incremental _ℓ_ 2 gain, however the added flexibility from the term _D_ 11 significantly improves the nominal model performance for a given gain bound. Additionally, while both the C-REN and Robust RNN _γ_ = _∞_ are contracting models, we note that the C-REN is significantly more expressive with a NRMSE of 0.16 versus 0.24. 

It is well known that many neural networks are very sensitive to adversarial perturbations. This is shown, for instance, in Fig. 4 and 5, where we have plotted the change in output for a small adversarial perturbation _||_ ∆ _u|| <_ 0 _._ 05, for a selection of models trained on the F16 benchmark dataset. Here, we can see that both the RNN and LSTM are very sensitive to the input perturbation. The R-REN and R-RNN on the hand, have guaranteed bounds on the effect of the perturbation and are significantly more robust. 

We have also trained cyclic RENs (i.e. _D_ 11 is a full matrix) for the F16 Benchmark dataset. The resulting nominal performance and sensitivities for the acyclic and cyclic RENs are shown in Table I. We do not observe a significant difference in performance between the cyclic and acyclic model classes. 

10 

**==> picture [201 x 128] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 . 50<br>0 . 45<br>0 . 40<br>0 . 35 R-aREN γ = 1 . 5<br>R-aREN γ = 2 . 5<br>R-aREN γ = 3 . 5<br>0 . 30 C-aREN<br>LSTM<br>RNN<br>0 . 25<br>10 100 1000<br>γ<br>NRMSE<br>**----- End of picture text -----**<br>


Fig. 3: Nominal performance versus robustness for models trained on Wiener-Hammerstein with process noise benchmark dataset. The dashed vertical lines are the guaranteed upper bounds on _γ_ corresponding to the models with matching color. 

**==> picture [201 x 127] intentionally omitted <==**

**----- Start of picture text -----**<br>
RNN<br>0 . 6 LSTM<br>R-aREN γ = 40<br>0 . 4 R-aREN γ = 10<br>Robust RNN γ = 40<br>0 . 2 Robust RNN γ = 10<br>0 . 0<br>− 0 . 2<br>− 0 . 4<br>− 0 . 6<br>0 1000 2000 3000<br>Time Steps<br>1<br>y<br>∆<br>**----- End of picture text -----**<br>


Fig. 4: Change in output of models subject to an adversarial perturbation with _||_ ∆ _u|| <_ 0 _._ 05 _._ The incremental gains from ∆ _u_ to ∆ _y_ are 980, 290, 37, 8.6, 38.9 and 9.1, respectively. 

**==> picture [201 x 130] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 . 3<br>RNN<br>LSTM<br>0 . 2 R-aREN γ = 40<br>R-aREN γ = 10<br>0 . 1 Robust RNN γ = 40<br>Robust RNN γ = 10<br>0 . 0<br>− 0 . 1<br>− 0 . 2<br>− 0 . 3<br>1000 1100 1200 1300 1400 1500<br>Time Steps<br>1<br>y<br>∆<br>**----- End of picture text -----**<br>


Fig. 5: Zoomed in version of Fig. 4. 

TABLE I: Nominal performance (NRMSE) and upper and lower bounds on Lipschitz constant for acyclic and cyclic RENs on F16 benchmark dataset. 

||_γ_<br>10<br>20|40<br>60<br>100|_∞_|
|---|---|---|---|
|acyclic|_γ_<br>8.8<br>17.5<br>3|6.7<br>44.9<br>60.56|91.0|
||NRMSE (%)<br>30.0<br>25.7<br>2|0.1<br>18.5<br>17.2|16.2|
|cyclic|_γ_<br>9.1<br>17.1<br>3|6.0<br>44.6<br>57.9|85.26|
||NRMSE (%)<br>30.3<br>26.8<br>2|1.8<br>19.9<br>19.3|16.8|



**==> picture [201 x 135] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 R-aREN γ = 10<br>R-aREN γ = 20<br>R-aREN γ = 40<br>C-aREN<br>LSTM<br>RNN<br>1<br>0 20 40 60<br>Epochs<br>Loss<br>**----- End of picture text -----**<br>


Fig. 6: Traing loss versus epochs for models trained on F16 ground vibration benchmark dataset. 

Finally, we have plotted the training loss (37) versus the number of epochs in Fig. 6 for some of the models on the F16 dataset. Compared to the LSTM, the REN takes a similar number of steps and achieves a slightly lower training loss. 

## VIII. USE CASE: LEARNING NONLINEAR OBSERVERS 

Estimation of system states from incomplete and/or noisy measurements is an important problem in many practical applications. For linear systems with Gaussian noise, a simple and optimal solution exists in the form of the Kalman filter, but for nonlinear systems even finding a stable estimator (a.k.a. observer) is non-trivial and many approaches have been investigated, e.g. [74]–[76]. Observer design was one of the original motivations for contraction analysis [14], and in this section, we show how a flexible set of contracting models can be used to learn stable state observers via _snapshots_ of a nonlinear system model. 

The aim is to estimate the state of a nonlinear system of the form 

**==> picture [228 x 11] intentionally omitted <==**

where _xt ∈_ X is an internal state to be estimated, _yt_ is an available measurement, _ut ∈_ U is a known (e.g. control) input, and _wt ∈_ W comprises unknown disturbances and sensor noise. 

A standard structure, pioneered by Luenberger, is an observer of the form 

**==> picture [199 x 11] intentionally omitted <==**

i.e. a combination of a model prediction _fm_ and a measurement correction function _l_ . A common special case is _l_ (ˆ _xt, ut, yt_ ) = _L_ (ˆ _x_ )( _yt − gm_ (ˆ _xt, ut,_ 0)) for some gain _L_ (ˆ _x_ ). 

In many practical cases the best available model _fm, gm_ is highly complex, e.g. based on finite element methods or algorithmic mechanics [77]. This poses two major challenges to the standard paradigm: 

- 1) How to design the function _l_ such that the observer (41) is stable (preferably globally) and exhibits good noise/disturbance rejection. 

- 2) The model itself may be so complex that evaluating _fm_ (ˆ _xt, ut,_ 0) in real-time is infeasible, e.g. for stiff systems where short sample times are required. 

11 

Our parameterization of contracting models enables an alternative paradigm, first suggested for the restricted case of polynomial models in [50], [51]. 

_Proposition 2:_ If we construct an observer of the form 

**==> picture [170 x 11] intentionally omitted <==**

such that the following two conditions hold: 

- 1) The system (42) is contracting with rate _α ∈_ (0 _,_ 1) for some constant metric _P ≻_ 0. 

- 2) The following “correctness” condition holds: 

**==> picture [224 x 22] intentionally omitted <==**

ˆ Then when _w_ = 0 we have _xt → xt_ as _t →∞_ . Suppose instead Condition 2) does not hold but that the observer (42) satisfies Conditions 1) and 

- 3) The following error bound holds _∀_ ( _x, u, w_ ) _∈_ X _×_ U _×_ W: 

**==> picture [209 x 11] intentionally omitted <==**

Then the estimation error satisfies, with exponential convergence: 

**==> picture [193 x 25] intentionally omitted <==**

where _σ_ and _σ_ denote the maximum and minimum singular values of the contraction metric _P_ , respectively. 

_Remark 7:_ Note that the error term (44) may result from bounded disturbances _wt_ , modelling errors, or interpolation errors arising from fitting the correctness condition to finite data (see Sec VIII-A), or some combination of such factors. 

The reasoning for nominal convergence of the observer is ˆ ˆ simple: (43) implies that if _x_ 0 = _x_ 0 then _xt_ = _xt_ for all _t ≥_ 0, i.e. the true state is a particular solution of the observer. But contraction implies that all solutions of the observer converge to each other. Hence all solutions of the observer converge to the true state. The proof of the estimation error bound can be found in Appendix E. 

Motivated by Proposition (2) we pose the observer design problem as a supervised learning problem over our class of contracting models. 

- 1) Construct the dataset: sample a set of points _z_ ˜ = _{_ ( _x[i] , u[i]_ ) _, i_ = 1 _,_ 2 _, ..., N }_ where ( _x[i] , u[i]_ ) _∈_ X _×_ U, and for each compute _gm[i]_[=] _[g][m]_[(] _[x][i][, u][i][,]_[ 0)][and] _[f] m[ i]_[=] _fm_ ( _x[i] , u[i] ,_ 0). 

- 2) Learn a contracting system _fo_ minimizing the loss 

**==> picture [195 x 30] intentionally omitted <==**

_Remark 8:_ An observer of the traditional form (41) with _l_ (ˆ _xt, ut, yt_ ) = _L_ (ˆ _x_ )( _yt − gm_ (ˆ _xt, ut,_ 0)) will always satisfy the correctness condition, but designing _L_ (ˆ _x_ ) to achieve global convergence may be difficult. In contrast, an observer design using the proposed procedure will always achieve global convergence, but may not achieve correctness exactly. 

## _A. Example: Reaction-Diffusion PDE_ 

We illustrate this approach by designing an observer for the following semi-linear reaction-diffusion partial differential equation: 

**==> picture [204 x 52] intentionally omitted <==**

where the state _ξ_ ( _z, t_ ) is a function of both the spatial coordinate _z ∈_ [0 _,_ 1] and time _t ∈_ R+. Models of the form (47) model processes such as combustion [78], bioreactors [79] or neural spiking dynamics [78]. The observer design problem for such systems has been considered using complex backstepping methods that guarantee only local stability [79]. 

We consider the case where the local reaction dynamics have the following form, which appears in models of combustion processes [78]: 

**==> picture [127 x 21] intentionally omitted <==**

We consider the boundary condition _b_ ( _t_ ) as a known input and assume that there is a single measurement taken from the center of the spatial domain so _y_ ( _t_ ) = _ξ_ (0 _._ 5 _, t_ ). 

We discretize _z_ into _N_ intervals with points _z_[0] _, ..., z[N]_ where _z[i]_ = _i_ ∆ _z_ . The state at spatial coordinate _z[i]_ and time _t_ is then described by _ξ_[¯] _t_ = ( _ξt_[0] _[, ξ] t_[1] _[, ..., ξ] t[N]_[)][where] _[ξ] t[i]_[=] _[ ξ]_[(] _[z][i][, t]_[)][.] The dynamics over a time period ∆ _t_ can then be approximated using the following finite differences: 

**==> picture [238 x 24] intentionally omitted <==**

Substituting them into (47) and rearranging for _ξ_[¯] _t_ +∆ _t_ leads to an _N_ + 1 dimensional state-space model of the form: 

**==> picture [200 x 12] intentionally omitted <==**

We generate training data by simulating the system (50) with _N_ = 50 for 10[5] time steps with the stochastic input _bt_ +1 = _bt_ + 0 _._ 05 _ωt_ where _ωt ∼N_ [0 _,_ 1]. We denote this training data by _z_ ˜ = ( _ξ_[˜] _t,_ ˜ _yt,_[˜] _bt_ ) for _t_ = 0 _, . . . ,_ 10[5] ∆ _t_ . 

To train an observer for this system, we construct a C-REN with _n_ = 51 and _q_ = 200. We optimize the one step ahead prediction error: 

**==> picture [189 x 30] intentionally omitted <==**

using SGD with the Adam optimizer [56]. Here, _fo_ ( _ξ, b, y_ ) is a C-REN described by (9), (10) using direct parametrization discussed in Section V-A. Note that we have taken the output mapping in (9) to be [ _C_ 2 _, D_ 21 _, D_ 22] = [ _I,_ 0 _,_ 0]. 

We have plotted results of the PDE simulation and the observer state estimates in Fig. 7. The simulation starts with an initial state of _ξ_ ( _z,_ 0) = 1 and the observer has an initial state estimate of _ξ_[¯] 0 = 0. The error between the state estimate and the PDE simulation’s state quickly decays to zero and the observer state continues to track the PDE’s state. 

12 

**==> picture [201 x 144] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0.8<br>0.6<br>0.4<br>0.2<br>0 500 1000 1500 2000<br>0<br>Time Steps<br>True<br>Observer<br>Error<br>**----- End of picture text -----**<br>


Fig. 7: Simulation of a semi-linear reaction diffusion equation and the observer’s state estimate, with a measurement in the centre of the spatial domain. The _y_ -axis corresponds to the spatial dimension and the _x_ -axis corresponds to the time dimension. 

## IX. USE CASE: DATA-DRIVEN FEEDBACK CONTROL DESIGN 

In this section we show how a rich class of contracting nonlinear models can be useful for nonlinear feedback design for _linear_ dynamical systems with stability guarantees. Even if the dynamics are linear, the presence of constraints, uncertain parameters, non-quadratic costs, and non-Gaussian disturbances can mean that non-linear policies are superior to linear policies. Indeed, in the presence of constraints, model predictive control (a nonlinear policy) is a common approach. 

The basic idea we illustrate in this section is to build on a standard method for linear feedback optimization: the Youla-Kucera parameterization, a.k.a Q-augmentation [18], [52], [53], [80]. For a discrete-time linear system model 

**==> picture [193 x 25] intentionally omitted <==**

**==> picture [182 x 10] intentionally omitted <==**

**==> picture [201 x 135] intentionally omitted <==**

**==> picture [233 x 154] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) True and estimated states for ξt [1][,] [located] [at] [PDE] [boundary.]<br>1 . 00<br>0 . 75<br>0 . 50<br>0 . 25<br>0 . 00<br>0 500 1000 1500 2000<br>Time Steps<br>(b) True and estimated states for ξt [10][.]<br>10 ξt<br>**----- End of picture text -----**<br>


Fig. 8: True state and state estimates from the designed observer and a free run simulation of the PDE. 

We have also provided a comparison to a free run simulation of the PDE with initial condition _ξ_ ( _z,_ 0) = 0 in Fig. 8. Here we can see that simulated trajectories with different initial conditions do not converge. This suggests that the system is not contracting and the state cannot be estimated by simply running a parallel simulation. The state estimates of the observer, however, quickly converge on the true state. 

with _x_ the state, _u_ the controlled input, _w_ external inputs (reference, disturbance, measurement noise), _y_ a measured output, and _ζ_ comprises the “performance” outputs to kept small (e.g. tracking error, control signal). We assume the system is detectable and stabilizable, i.e. there exist L and K such that A _−_ LC and A _−_ BK are Schur stable. Note that if A is stable we can take L = 0 _,_ K = 0. Consider a feedback controller of the form: 

**==> picture [180 x 11] intentionally omitted <==**

**==> picture [169 x 10] intentionally omitted <==**

**==> picture [170 x 10] intentionally omitted <==**

i.e. a standard output-feedback structure with _vt_ an additional control augmentation. The closed-loop input-output dynamics can be written as the transfer matrix 

**==> picture [171 x 24] intentionally omitted <==**

where we have used the fact that _u_ ˜ maps to _x_ and _x_ ˆ equally, hence the mapping from _u_ ˜ to _y_ ˜ is zero. 

It is well-known that the set of all stabilizing linear feedback controllers can be parameterised by stable linear systems _Q_ : _y_ ˜ _�→ u_ ˜, and moreover this convexifies the closed-loop dynamics. A standard approach (e.g. [53], [80]) is to construct an affine parameterization for _Q_ via a finite-dimensional truncation of a complete basis of stable linear systems, and optimize to meet various criteria on frequency response, impulse response, and response to application-dependent test inputs. However, if the control augmentation _u_ ˜ is instead generated by a contracting nonlinear system _u_ ˜ = _Q_ (˜ _y_ ), then the closedloop dynamics _w �→ ζ_ are nonlinear but contracting and have the representation 

**==> picture [172 x 11] intentionally omitted <==**

This presents opportunities for learning stabilizing controllers via parameterizations of stable nonlinear models. 

13 

## _A. Echo State Network and Convex Optimization_ 

Here we describe a particular setting in which the datadriven optimization of nonlinear policies can be posed as a _convex_ problem. Suppose we wish to design a controller solving (at least approximately) a problem of the form: 

**==> picture [179 x 15] intentionally omitted <==**

where _ζ_ is the response of the performance outputs to a _particular class_ of disturbances _w_ , _J_ is a convex objective function, and _c_ is a set of convex constraints, e.g. state and control signal bounds. 

If we take _Q_ as an echo state network, c.f. Section V-C: 

**==> picture [155 x 12] intentionally omitted <==**

where _fq_ is fixed and _gq_ is linearly parameterized by _θ_ , i.e. 

**==> picture [125 x 23] intentionally omitted <==**

Then _Q_ has the representation 

**==> picture [83 x 23] intentionally omitted <==**

where _Q[i]_ is a state-space model with dynamics _fq_ and output _gq[i]_[.][Then,][we][can][perform][data-driven][controller][optimization] in the following way: 

- 1) Construct (e.g. via random sampling, experiment) a finite set of test signals _w[j]_ . 

- 2) Compute _y_ ˜ _t[j]_[=] _[ T]_[2] _[w][j]_[for][each] _[j]_[.] 

- 3) For each _j_ , compute the response to _y_ ˜ _[j]_ : 

**==> picture [153 x 15] intentionally omitted <==**

4) Construct the affine representation 

**==> picture [107 x 22] intentionally omitted <==**

## _B. Example_ 

We illustrate the approach on a simple discrete-time linear system with transfer function 

**==> picture [166 x 23] intentionally omitted <==**

with _q_ the shift operator, _ρ_ = 0 _._ 8, and _ϕ_ = 0 _._ 2 _π_ . We consider the task of minimizing the _ℓ_[1] norm of the output in response to step disturbances, while keeping the control signal _u_ bounded: _|ut| ≤_ 5 for all _t_ . This can be considered a data-driven approach to an explicit model predictive control [82] with stability guarantees. 

Training data is generated by a 25,000 sample piece-wise constant disturbance that has a hold time of 50 samples and a magnitude uniformly distributed in the interval [-10, 10]. 

We construct a contracting model _Q_ with _n_ = 50 states and _q_ = 500 neurons by randomly sampling a matrix _X ∈_ R[(2] _[n]_[+] _[q]_[)] _[×]_[(2] _[n]_[+] _[q]_[)] with _Xij ∼N_ �0 _,_ 2 _n_ 4+ _q_ � and constructing a C-REN via the method outline in Section V-A. The remaining parameters are sampled from the Glorot normal distribution [83]. For comparison, we construct a linear _Q_ parameter of the form 

**==> picture [187 x 11] intentionally omitted <==**

where _Aq_ = _λ ρ_ ( _AA_ ¯[¯] )[with] _[λ][∈]_[(0] _[,]_[ 1)][and] _[A]_[¯] _[ij][∼N]_ �0 _,_ 2 _n_ 1+ _q_ �. Note that _Aq_ is a stable matrix with a contraction rate of _λ_ . We sample _Bq_ from the Glorot normal distribution [83]. 

The response to test inputs are shown in Fig. 9. The benefits of learning a nonlinear _Q_ parameter are that the control can respond aggressively to small disturbances, driving the output quickly to zero, but respond less aggressively to large disturbances to stay within the control bounds. In contrast, the linear control policy must respond proportionally to disturbances of all sizes. Since the control constraints require less aggressive response to large disturbances, the linear controller must also less aggressively to small disturbances, does not drive the output to zero. 

## X. CONCLUSIONS 

- 5) Solve the convex optimization problem: 

**==> picture [183 x 16] intentionally omitted <==**

where _R_ ( _θ_ ) is an optional regularization term. 

The result will of course only be approximately optimal, since _w[j]_ are but a representative sample and the echo state network provides only a finite-dimensional span of policies. However it will be _guaranteed_ to be stabilizing. 

_Remark 9:_ This framework can be extended to include learning over all REN parameters, however the optimization problem is no longer convex. We have recently shown that this amounts to learning over all stabilizing nonlinear controllers for a linear system [69] and extended the framework to learn robustly stabilizing controllers for uncertain systems [81]. 

In this paper we have introduced recurrent equilibrium networks (RENs) as a new model class for learning nonlinear dynamical systems with built-in stability and robustness constraints. The model set is flexible and admits a direct parameterization, allowing learning of large-scale models via generic unconstrained optimization methods such as stochastic gradient descent. 

We have illustrated the benefits of the new model class on problems in system identification, observer design, and control. On system identification benchmarks, the REN structure outperformed the widely-used RNN and LSTM models in terms of model fit while achieving far lower sensitivity to input perturbations. We further showed that the REN model architecture enables new approaches to nonlinear observer design and optimization of nonlinear feedback controllers. 

14 

**==> picture [201 x 276] intentionally omitted <==**

**----- Start of picture text -----**<br>
Disturbance<br>7 . 5 Open Loop<br>Linear<br>aREN<br>5 . 0<br>2 . 5<br>0 . 0<br>− 2 . 5<br>0 100 200 300 400 500 600<br>Time Steps<br>Linear<br>2<br>aREN<br>Contraints<br>0<br>− 2<br>− 4<br>0 100 200 300 400 500 600<br>Time Steps<br>**----- End of picture text -----**<br>


Fig. 9: Output (top) and control signal (bottom) responses to step disturbances for nonlinear (C-REN) and linear data-driven optimization of feedback controllers. 

## APPENDIX 

## _A. Proof of Theorem 1_ 

Firstly, well-posedness follows directly from (15), since it implies _W ≻_ 0 which is precisely (12). 

To prove contraction and incremental IQCs we consider the incremental dynamics, i.e. differences between two sequences ( _x[a] , w[a] , v[a] , u[a]_ ) and ( _x[b] , w[b] , v[b] , u[b]_ ), which we denote ∆ _xt_ = _x[a] t[−][x][b] t_[and][similarly][for][other][variables.][The][incremental] dynamics generated by (1) are 

**==> picture [212 x 52] intentionally omitted <==**

To deal with the nonlinear element (61), we note that the constraint (14) can be rewritten as ( _σ_ ( _x_ ) _− σ_ ( _y_ ))( _x − y_ ) _≥_ ( _σ_ ( _x_ ) _− σ_ ( _y_ ))[2] , and by taking a conic combinations of this inequality for each channel with multipliers _λi >_ 0, we obtain the following incremental quadratic constraint: 

**==> picture [231 x 27] intentionally omitted <==**

which is valid for any Λ = diag( _λ_ 1 _, . . . , λq_ ) _∈_ D+. To prove contraction, we first note that if (15) holds then 

**==> picture [214 x 27] intentionally omitted <==**

for some _α < α_ ¯. Left-multiplying by �∆ _x[⊤] t_ ∆ _wt[⊤]_ � and _⊤_ right-multiplying by �∆ _x[⊤] t_[∆] _[w] t[⊤]_ � , we obtain the following incremental Lyapunov inequality: _|_ ∆ _xt_ +1 _|P_[2] _[≤][α]_[2] _[|]_[∆] _[x][t][|]_[2] _P[−]_[Γ(∆] _[v][t][,]_[ ∆] _[w][t]_[)] _[ ≤][α]_[2] _[|]_[∆] _[x][t][|]_[2] _P[.]_ (64) 

where the second inequality follows by the incremental quadratic constraint (62). Iterating over _t_ gives (4) with _K_ = ~~�~~ _σ/_ ¯ _σ_ where _σ_ ¯ is the maximum singular value of _P_ , and _σ_ the minimum singular value. The proof for the incremental IQC is similar: from (16) we obtain a non-strict version with _α < α_ ¯. Left multiplying by �∆ _x[⊤] t_[∆] _[w] t[⊤]_[∆] _[u][⊤] t_ � and right-multiplying by its transpose results in: 

**==> picture [214 x 43] intentionally omitted <==**

Since Γ(∆ _vt,_ ∆ _wt_ ) _≥_ 0 from (62), and _α <_ 1 we have 

**==> picture [209 x 27] intentionally omitted <==**

Telescoping sum of the above inequality yields the IQC (5) with _d_ ( _a, b_ ) = ( _b − a_ ) _[⊤] P_ ( _b − a_ ). Moreover, since _Q ⪯_ 0, taking ∆ _ut_ = 0 in (65) reduces to (64) proving contraction. 

## _B. Proof of Theorem 2_ 

We note that a REN has Lipschitz bound of _γ_ if (28) holds with _Q_ = _− γ_[1] _[I, R]_[=] _[γI, S]_[=][0][.][By][taking][Schur] complements and permuting the third and fourth columns and rows, the condition to be verified can be rewritten as: 

**==> picture [239 x 67] intentionally omitted <==**

Now, the upper-left quadrant is positive-definite via Schur complement of (15). Hence, by taking _γ_ sufficiently large, the condition (66) will be verified. 

## _C. Proof of Theorem 3_ 

To show well-posedness, from (19) we have _E_ + _E[⊤] ≻ P ≻_ 0 and _W_ = 2Λ _−_ Λ _D_ 11 _− D_ 11 _[⊤]_[Λ] _[ ≻]_[0][where] _[D]_[11][= Λ] _[−]_[1] _[D]_[11][.] The first inequality implies that _E_ is invertible and thus (9) is well-posed. The second one ensures that the equilibrium network (8) is well-posed by the main result of [12]. 

**==> picture [253 x 66] intentionally omitted <==**

By substituting _F_ = _EA_ , _B_ 1 = _EB_ 1, _B_ 2 = _EB_ 2, _C_ 1 = Λ _C_ 1 and _D_ 11 = Λ _D_ 11 into the above inequality, we obtain (15) with _P_ = _E[⊤] P[−]_[1] _E_ . Thus, Θ _C_ is a set of C-RENs. Similarly, we can show that (20) implies (16) for R-RENs. 

15 

_D. Proof of Proposition 1_ 

With the factorization _Q_ = _−L[⊤] Q[L][Q]_[,][(30)][is][equivalent][to] _R − SQ[−]_[1] _S[⊤] ≻_ ( _LQD_ 22 _− L[−⊤] Q[S][⊤]_[)] _[⊤]_[(] _[L][Q][D]_[22] _[ −][L][−⊤] Q[S][⊤]_[)] _[,]_ which implies that _R − SQ[−]_[1] _S[⊤] ≻_ 0, hence _LR_ is welldefined. If _p ≥ m_ , from (32) we have _N[⊤] N ≺ I_ since 

**==> picture [223 x 28] intentionally omitted <==**

Similarly, for the case _p < m_ we can obtain _NN[⊤] ≺ I_ from (33), which also implies _N[⊤] N ≺ I_ . Finally, by substituting (31) into (30) we have 

**==> picture [249 x 13] intentionally omitted <==**

## _E. Proof of Proposition 2_ 

When the correctness condition (43) holds, we have that ˆ ˆ _xt_ = _xt_ for all _t ≥_ 0 if _x_ 0 = _x_ 0, i.e. the true state trajectory is a particular solution of the observer. But contraction implies that all solutions of the observer converge to each other. Hence when _w_ = 0 we have _x_ ˆ _t → xt_ as _t →∞_ . 

Now we consider the case where the correctness condition does not hold but its error is bounded by (44). The dynamics of ∆ _x_ := _x_ ˆ _− x_ can be written as 

**==> picture [209 x 26] intentionally omitted <==**

where _et_ = _fo_ ( _xt, ut, yt_ ) _− fm_ ( _xt, ut_ ). By the mean-value theorem, ∆ _xt_ +1 = _F_ ( _z, ut_ )∆ _xt_ + _et_ where _Ft_ = _[∂] ∂x_[[] _[f][o]_[]][(] _[z, u][t]_[)] for some _z_ . By the triangle inequality _|_ ∆ _xt_ +1 _|P ≤|Ft_ ∆ _xt|P_ + _|et|P_ and by contraction _|Ft_ ∆ _xt|P ≤ α|_ ∆ _xt|P_ . So we have 

**==> picture [193 x 27] intentionally omitted <==**

From which it follows that the set _|_ ∆ _xt|P ≤_ ~~_√_~~ 1 _−σ_ ¯ _αρ_[is][forward-] invariant and exponentially attractive, since _α −_ 1 _<_ 1. The claimed result then follows from _[√] σ|_ ∆ _xt| ≤|_ ∆ _x|P_ . 

## REFERENCES 

- [1] Y. LeCun, Y. Bengio, and G. Hinton, “Deep learning,” _Nature_ , vol. 521, no. 7553, pp. 436–444, 2015. 

- [2] S. Levine, C. Finn, T. Darrell, and P. Abbeel, “End-to-end training of deep visuomotor policies,” _The Journal of Machine Learning Research_ , vol. 17, no. 1, pp. 1334–1373, 2016. 

- [3] H. Yin, P. Seiler, M. Jin, and M. Arcak, “Imitation learning with stability and safety guarantees,” _IEEE Control Systems Letters_ , vol. 6, pp. 409– 414, 2021. 

- [4] L. Brunke, M. Greeff, A. W. Hall, Z. Yuan, S. Zhou, J. Panerati, and A. P. Schoellig, “Safe learning in robotics: From learning-based control to safe reinforcement learning,” _Annual Review of Control, Robotics, and Autonomous Systems_ , vol. 5, pp. 411–444, 2022. 

- [5] C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus, “Intriguing properties of neural networks,” in _International Conference on Learning Representations (ICLR)_ , 2014. 

- [6] A. Russo and A. Proutiere, “Towards optimal attacks on reinforcement learning policies,” in _2021 American Control Conference (ACC)_ . IEEE, 2021, pp. 4561–4567. 

- [7] V. Tjeng, K. Y. Xiao, and R. Tedrake, “Evaluating robustness of neural networks with mixed integer programming,” in _International Conference on Learning Representations (ICLR)_ , 2018. 

- [8] A. Raghunathan, J. Steinhardt, and P. Liang, “Certified defenses against adversarial examples,” in _International Conference on Learning Representations (ICLR)_ , 2018. 

- [9] M. Fazlyab, A. Robey, H. Hassani, M. Morari, and G. J. Pappas, “Efficient and accurate estimation of Lipschitz constants for deep neural networks.” in _Advances in Neural Information Processing Systems_ , 2019. 

- [10] S. Bai, J. Z. Kolter, and V. Koltun, “Deep equilibrium models,” in _Advances in Neural Information Processing Systems_ , 2019. 

- [11] E. Winston and J. Z. Kolter, “Monotone operator equilibrium networks,” in _Advances in Neural Information Processing Systems_ , 2020. 

- [12] M. Revay, R. Wang, and I. R. Manchester, “Lipschitz bounded equilibrium networks,” _arXiv:2010.01732_ , 2020. 

- [13] L. El Ghaoui, F. Gu, B. Travacca, A. Askari, and A. Tsai, “Implicit deep learning,” _SIAM Journal on Mathematics of Data Science_ , vol. 3, no. 3, pp. 930–958, 2021. 

- [14] W. Lohmiller and J.-J. E. Slotine, “On contraction analysis for non-linear systems,” _Automatica_ , vol. 34, pp. 683–696, 1998. 

- [15] A. Megretski and A. Rantzer, “System analysis via integral quadratic constraints,” _IEEE Transactions on Automatic Control_ , vol. 42, no. 6, pp. 819–830, 1997. 

- [16] T. Hatanaka, N. Chopra, M. Fujita, and M. W. Spong, _Passivity-based control and estimation in networked robotics_ . Springer, 2015. 

- [17] M. Arcak, C. Meissen, and A. Packard, _Networks of dissipative systems: compositional certification of stability, performance, and safety_ . Springer, 2016. 

- [18] K. Zhou, J. C. Doyle, K. Glover _et al._ , _Robust and Optimal Control_ . Prentice hall New Jersey, 1996, vol. 40. 

- [19] A. van der Schaft, _L2-Gain and Passivity in Nonlinear Control_ , 3rd ed. Springer-Verlag, 2017. 

- [20] J. M. Maciejowski, “Guaranteed stability with subspace methods,” _Systems & Control Letters_ , vol. 26, no. 2, pp. 153–156, Sep. 1995. 

- [21] T. Van Gestel, J. A. Suykens, P. Van Dooren, and B. De Moor, “Identification of stable models in subspace identification by using regularization,” _IEEE Transactions on Automatic Control_ , vol. 46, no. 9, pp. 1416–1420, 2001. 

- [22] S. L. Lacy and D. S. Bernstein, “Subspace identification with guaranteed stability using constrained optimization,” _IEEE Transactions on automatic control_ , vol. 48, no. 7, pp. 1259–1263, 2003. 

- [23] U. Nallasivam, B. Srinivasan, V.Kuppuraj, M. N. Karim, and R. Rengaswamy, “Computationally efficient identification of global ARX parameters with guaranteed stability,” _IEEE Transactions on Automatic Control_ , vol. 56, no. 6, pp. 1406–1411, Jun. 2011. 

- [24] D. N. Miller and R. A. De Callafon, “Subspace identification with eigenvalue constraints,” _Automatica_ , vol. 49, no. 8, pp. 2468–2473, 2013. 

- [25] M. M. Tobenkin, I. R. Manchester, J. Wang, A. Megretski, and R. Tedrake, “Convex optimization in identification of stable non-linear state space models,” in _49th IEEE Conference on Decision and Control (CDC)_ , 2010. 

- [26] M. M. Tobenkin, I. R. Manchester, and A. Megretski, “Convex parameterizations and fidelity bounds for nonlinear identification and reducedorder modelling,” _IEEE Transactions on Automatic Control_ , vol. 62, no. 7, pp. 3679–3686, Jul. 2017. 

- [27] J. Umenberger, J. Wagberg, I. R. Manchester, and T. B. Sch¨on, “Maximum likelihood identification of stable linear dynamical systems,” _Automatica_ , vol. 96, pp. 280–292, 2018. 

- [28] J. Umenberger and I. R. Manchester, “Specialized interior-point algorithm for stable nonlinear system identification,” _IEEE Transactions on Automatic Control_ , vol. 64, no. 6, pp. 2442–2456, 2018. 

- [29] S. M. Khansari-Zadeh and A. Billard, “Learning stable nonlinear dynamical systems with Gaussian mixture models,” _IEEE Transactions on Robotics_ , vol. 27, no. 5, pp. 943–957, Oct. 2011. 

- [30] J. Miller and M. Hardt, “Stable recurrent models,” in _International Conference on Learning Representations_ , 2019. 

- [31] J. Umenberger and I. R. Manchester, “Convex bounds for equation error in stable nonlinear identification,” _IEEE Control Systems Letters_ , vol. 3, no. 1, pp. 73–78, Jan. 2019. 

- [32] G. Manek and J. Z. Kolter, “Learning stable deep dynamics models,” in _Advances in Neural Information Processing Systems_ , 2019. 

- [33] M. Revay and I. Manchester, “Contracting implicit recurrent neural networks: Stable models with improved trainability,” in _Learning for Dynamics and Control_ . PMLR, 2020, pp. 393–403. 

- [34] M. Revay, R. Wang, and I. R. Manchester, “A convex parameterization of robust recurrent neural networks,” _IEEE Control Systems Letters_ , vol. 5, no. 4, pp. 1363–1368, 2021. 

- [35] M. Cheng, J. Yi, P.-Y. Chen, H. Zhang, and C.-J. Hsieh, “Seq2sick: Evaluating the robustness of sequence-to-sequence models with adversarial 

16 

examples.” in _Association for the Advancement of Artificial Intelligence_ , 2020, pp. 3601–3608. 

- [36] P. L. Bartlett, D. J. Foster, and M. J. Telgarsky, “Spectrally-normalized margin bounds for neural networks,” in _Advances in Neural Information Processing Systems_ , 2017, pp. 6240–6249. 

- [37] S. Zhou and A. P. Schoellig, “An analysis of the expressiveness of deep neural network architectures based on their Lipschitz constants,” _arXiv preprint arXiv:1912.11511_ , 2019. 

- [38] T. Huster, C.-Y. J. Chiang, and R. Chadha, “Limitations of the Lipschitz constant as a defense against adversarial examples,” in _Joint European Conference on Machine Learning and Knowledge Discovery in Databases_ . Springer, 2018, pp. 16–29. 

- [39] H. Qian and M. N. Wegman, “L2-nonexpansive neural networks,” in _International Conference on Learning Representations (ICLR)_ , 2019. 

- [40] H. Gouk, E. Frank, B. Pfahringer, and M. J. Cree, “Regularisation of neural networks by enforcing Lipschitz continuity,” _Machine Learning_ , vol. 110, no. 2, pp. 393–416, 2021. 

- [41] R. S. Sutton and A. G. Barto, _Reinforcement Learning: An Introduction_ . MIT press, 2018, vol. 2. 

- [42] A. Russo and A. Proutiere, “Optimal attacks on reinforcement learning policies,” _arXiv:1907.13548_ , 2019. 

- [43] Y. Kawano and M. Cao, “Design of privacy-preserving dynamic controllers,” _IEEE Transactions on Automatic Control_ , vol. 65, no. 9, pp. 3863–3878, Sep. 2020. 

- [44] A. Virmaux and K. Scaman, “Lipschitz regularity of deep neural networks: analysis and efficient estimation,” in _Advances in Neural Information Processing Systems_ , vol. 31, 2018. 

- [45] M. Fazlyab, M. Morari, and G. J. Pappas, “Safety verification and robustness analysis of neural networks via quadratic constraints and semidefinite programming,” _IEEE Transactions on Automatic Control_ , vol. 67, no. 1, pp. 1–15, 2020. 

- [46] P. Pauli, A. Koch, J. Berberich, P. Kohler, and F. Allg¨ower, “Training robust neural networks using Lipschitz bounds,” _IEEE Control Systems Letters_ , vol. 6, pp. 121–126, 2021. 

- [47] R. Wang and I. R. Manchester, “Direct parameterization of Lipschitzbounded deep networks,” _International Conference on Machine Learning (ICML)_ , 2023. 

- [48] F. Ferraguti, N. Preda, A. Manurung, M. Bonf`e, O. Lambercy, R. Gassert, R. Muradore, P. Fiorini, and C. Secchi, “An energy tankbased interactive control architecture for autonomous and teleoperated robotic surgery,” _IEEE Transactions on Robotics_ , vol. 31, no. 5, pp. 1073–1088, Oct. 2015. 

- [49] E. Shahriari, A. Kramberger, A. Gams, A. Ude, and S. Haddadin, “Adapting to contacts: Energy tanks and task energy for passivity-based dynamic movement primitives,” in _2017 IEEE-RAS 17th International Conference on Humanoid Robotics (Humanoids)_ , 2017, pp. 136–142. 

- [50] I. R. Manchester, “Contracting nonlinear observers: Convex optimization and learning from data,” in _2018 American Control Conference (ACC)_ . IEEE, 2018, pp. 1873–1880. 

- [51] B. Yi, R. Wang, and I. R. Manchester, “Reduced-order nonlinear observers via contraction analysis and convex optimization,” _IEEE Transactions on Automatic Control_ , vol. 67, no. 8, pp. 4045–4060, 2021. 

- [52] D. Youla, H. Jabr, and J. Bongiorno, “Modern Wiener-Hopf design of optimal controllers–Part II: The multivariable case,” _IEEE Transactions on Automatic Control_ , vol. 21, no. 3, pp. 319–338, Jun. 1976. 

- [53] J. P. Hespanha, _Linear Systems Theory_ . Princeton university press, 2018. 

- [54] K. Fujimoto and T. Sugie, “Characterization of all nonlinear stabilizing controllers via observer-based kernel representations,” _Automatica_ , vol. 36, no. 8, pp. 1123–1135, Aug. 2000. 

   - [61] E. K. Ryu and S. Boyd, “Primer on monotone operator methods,” _Applied and Computational Mathematics_ , vol. 15, no. 1, pp. 3–43, 2016. 

   - [62] I. Goodfellow, Y. Bengio, and A. Courville, _Deep learning_ . MIT press, 2016. 

   - [63] Y.-C. Chu and K. Glover, “Bounds of the induced norm and model reduction errors for systems with repeated scalar nonlinearities,” _IEEE Transactions on Automatic Control_ , vol. 44, no. 3, pp. 471–483, 1999. 

   - [64] F. J. D’Amato, M. A. Rotea, A. Megretski, and U. J¨onsson, “New results for analysis of systems with repeated nonlinearities,” _Automatica_ , vol. 37, no. 5, pp. 739–747, 2001. 

   - [65] V. V. Kulkarni and M. G. Safonov, “All multipliers for repeated monotone nonlinearities,” _IEEE Transactions on Automatic Control_ , vol. 47, no. 7, pp. 1209–1212, 2002. 

   - [66] B. Wahlberg and P. M. M¨akil¨a, “On approximation of stable linear dynamical systems using Laguerre and Kautz functions,” _Automatica_ , vol. 32, no. 5, pp. 693–708, May 1996. 

   - [67] M. Schoukens and K. Tiels, “Identification of block-oriented nonlinear systems starting from linear approximations: A survey,” _Automatica_ , vol. 85, pp. 272–292, 2017. 

   - [68] F. Giri and E.-W. Bai, _Block-oriented nonlinear system identification_ . Springer, 2010, vol. 1. 

   - [69] R. Wang, N. H. Barbara, M. Revay, and I. R. Manchester, “Learning over all stabilizing nonlinear controllers for a partially-observed linear system,” _IEEE Control Systems Letters_ , vol. 7, pp. 91–96, 2023. 

   - [70] S. Boyd and L. Chua, “Fading memory and the problem of approximating nonlinear operators with Volterra series,” _IEEE Transactions on circuits and systems_ , vol. 32, no. 11, pp. 1150–1161, 1985. 

   - [71] J. No¨el and M. Schoukens, “F-16 aircraft benchmark based on ground vibration test data,” _Workshop on Nonlinear System Identification Benchmarks_ , pp. 15–19, 2017. 

   - [72] M. Schoukens and J. No¨el, “Wiener-hammerstein benchmark with process noise,” _Workshop on Nonlinear System Identification Benchmarks_ , pp. 19–23, 2017. 

   - [73] S. Hochreiter and J. Schmidhuber, “Long short-term memory,” _Neural computation_ , vol. 9, pp. 1735–1780, 1997. 

   - [74] A. Astolfi, D. Karagiannis, and R. Ortega, _Nonlinear and Adaptive Control with Applications_ . Springer Science & Business Media, 2007. 

   - [75] H. K. Khalil, _High-Gain Observers in Nonlinear Feedback Control_ . SIAM, 2017. 

   - [76] P. Bernard, _Observer Design for Nonlinear Systems_ . Springer, 2019. [77] R. Featherstone, _Rigid Body Dynamics Algorithms_ . Springer, 2014. 

   - [78] B. H. Gilding and R. Kersner, _Travelling Waves in Nonlinear DiffusionConvection Reaction_ . Birkhauser, 2012, vol. 60. 

   - [79] T. Meurer, “On the extended Luenberger-type observer for semilinear distributed-parameter systems,” _IEEE Transactions on Automatic Control_ , vol. 58, no. 7, pp. 1732–1743, 2013. 

   - [80] S. P. Boyd and C. H. Barratt, _Linear controller design: limits of performance_ . Prentice Hall, 1991. 

   - [81] R. Wang and I. R. Manchester, “Youla-REN: Learning nonlinear feedback policies with robust stability guarantees,” in _2022 American Control Conference (ACC)_ , 2022, pp. 2116–2123. 

   - [82] A. Alessio and A. Bemporad, “A survey on explicit model predictive control,” in _Nonlinear Model Predictive Control: Towards New Challenging Applications_ , ser. Lecture Notes in Control and Information Sciences, L. Magni, D. M. Raimondo, and F. Allg¨ower, Eds. Berlin, Heidelberg: Springer, 2009, pp. 345–369. 

   - [83] X. Glorot and Y. Bengio, “Understanding the difficulty of training deep feedforward neural networks,” in _13th international conference on artificial intelligence and statistics_ . JMLR Workshop and Conference Proceedings, 2010, pp. 249–256. 

- [55] S. Burer and R. D. Monteiro, “A nonlinear programming algorithm for solving semidefinite programs via low-rank factorization,” _Mathematical Programming_ , vol. 95, no. 2, pp. 329–357, 2003. 

- [56] D. P. Kingma and J. Ba, “Adam: A Method for Stochastic Optimization,” _International Conference for Learning Representations (ICLR)_ , 2017. 

- [57] M. Buehner and P. Young, “A tighter bound for the echo state property,” _IEEE Transactions on Neural Networks_ , vol. 17, no. 3, pp. 820–824, May 2006. 

- [58] I. B. Yildiz, H. Jaeger, and S. J. Kiebel, “Re-visiting the echo state property,” _Neural Networks_ , vol. 35, pp. 1–9, Nov. 2012. 

- [59] N. H. Barbara, M. Revay, R. Wang, J. Cheng, and I. R. Manchester, “Robustneuralnetworks.jl: A package for machine learning and datadriven control with certified robustness,” _arXiv:2306.12612_ , 2023. 

- [60] M. Revay, R. Wang, and I. R. Manchester, “Recurrent equilibrium networks: Unconstrained learning of stable and robust dynamical models,” in _60th IEEE Conference on Decision and Control (CDC)_ , 2021, pp. 2282–2287. 

