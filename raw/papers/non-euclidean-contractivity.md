---
title: "Incremental Stability in Non-Euclidean Norms with Applications to Neural Networks"
arxiv: "2604.00490"
authors: ["Zhenyu Kuang", "Wei Lin"]
year: 2026
source: paper
ingested: 2026-05-02
sha256: 8d6c8c2fd8bf9023d6699c4d833bec42b064f60f01c8e19977ad91d5b2233411
conversion: pymupdf4llm
---

## **Incremental stability in** _p_ = 1 **and** _p_ = _∞_ **: classification and synthesis** 

Simon Kuang and Xinfan Lin[1] 

_**Abstract**_ **— All Lipschitz dynamics with the weak infinitesimal contraction (WIC) property can be expressed as a Lipschitz nonlinear system in proportional negative feedback—this statement, a “structure theorem,” is true in the** _p_ = 1 **and** _p_ = _∞_ **norms. Equivalently, a Lipschitz vector field is WIC if and only if it can be written as a scalar decay plus a Lipschitz-bounded residual. We put this theorem to use using neural networks to approximate Lipschitz functions. This results in a map from unconstrained parameters to the set of WIC vector fields, enabling standard gradient-based training with no projections or penalty terms. Because the induced** 1 **- and** _∞_ **-norms of a matrix reduce to row or column sums, Lipschitz certification costs only** _O_ ( _d_[2] ) **operations—the same order as a forward pass and appreciably cheaper than eigenvalue or semidefinite methods for the** 2 **-norm. Numerical experiments on a planar flow-fitting task and a fournode opinion network demonstrate that the parameterization (re-)constructs contracting dynamics from trajectory data. In a discussion of the expressiveness of non-Euclidean contraction, we prove that the set of** 2 _×_ 2 **systems that contract in a weighted** 1 **- or** _∞_ **-norm is characterized by an eigenvalue cone, a strict subset of the Hurwitz region that quantifies the cost of moving away from the Euclidean norm.** 

## I. INTRODUCTION 

˙ Neural ordinary differential equations (neural ODEs) _x_ = _f_ ( _x_ ; _θ_ ) are a way to parameterize continuous-time dynamic systems. They can be interpreted as residual networks with continuous depth [7], [2], offering memory-efficient training via adjoint methods and a principled interface with dynamicalsystems theory. However, this expressiveness brings a wellknown challenge: unconstrained vector fields can exhibit diverging trajectories, sensitivity to perturbations, and loss of well-posedness under long integration horizons [9]. Therefore, we desire to enforce nonlinear stability guarantees by construction, rather than by iterative projection or post-hoc verification. 

Many a student of nonlinear dynamic systems has grieved ˙ that the dynamic system _x_ = _f_ ( _x_ ) is not necessarily stable (in any sense) if all of the eigenvalues of the Jacobian _Df_ ( _x_ ) have negative real parts for all _x_ . However, a stronger eigenvalue condition can restore justice to this situation. If the Gershgorin discs of _Df_ ( _x_ ) or _Df_ ( _x_ )[⊺] are all contained in the left half-plane for all _x_ , then the system is stable—in a sense.[1] It is this sense of stability that the present work seeks to apply to dynamic system synthesis. The sense is 

> 1 Department of Mechanical and Aerospace Engineering, University of California, Davis; Davis, CA 95616, USA. _{_ slku, lxflin _}_ @ucdavis.edu 

> 1The Gershgorin circle theorem states that every eigenvalue of a matrix ( _aij_ )1 _≤i,j≤n_ lies within at least one of the discs centered at _aii_ with radius _Ri_ =[�] _j_ = _i[|][a][ij][|]_[,][where] _[R][i]_[is][the][sum][of][the][absolute][values][of] the off-diagonal entries in row _i_ . 

weak infinitesimal contraction in the non-Euclidean 1- and _∞_ -norms. 

**Contraction.** While the Lyapunov notion of stability is defined in terms of invariant sets around a given equilibrium, contraction theory is interested in the relative behavior of infinitesimally close states. A vector field is weakly infinitesimally contracting (WIC) if nearby states remain close to first order in some norm[11], [3], [1]. The guarantees afforded to WIC systems are anything but weak: a dichotomy theorem ensures that every bounded trajectory converges, local asymptotic stability implies global asymptotic stability, and perturbations degrade the contraction rate gracefully ([8]; [1, Thms.4.3–4.4]). Any neural ODE whose vector field is WIC by construction therefore inherits these properties for free. 

In what norm? Most work on nonlinear contraction, inspired by linear time-invariant stability (which views stable linear systems as gradient flows of a positive-definite quadratic potential), has developed sufficient conditions for contraction in the 2-norm. Contraction beyond the 2-norm has been studied via weak pairings and logarithmic norm conditions [4], but there are few applications that either recognize nonEuclidean contraction in a real system or target it as a synthesis principle. 

**From analysis to synthesis.** Contraction analysis of neural ˙ networks has a substantial history. Firing-rate models _x_ = ˙ _−x_ + Φ( _Ax_ + _u_ ) and Hopfield models _x_ = _−x_ + _A_ Φ( _x_ ) + _u_ , examples of Lur’e systems (feedback interconnection of a stable linear system and a nonlinearity), are known to be contractive in the 1- and/or _∞_ -norms subject to certain sufficient conditions on the nonlinearity Φ and the matrix _A_ [1, Lem. 3.21]. These results are all instances of the _analysis_ problem: given a system, is it contracting? 

The complementary _synthesis_ problem—parameterize all contracting vector fields so that a learning algorithm can search over them—is largely open. We resolve it by proving a necessary and sufficient condition: every WIC vector field in _p ∈{_ 1 _, ∞}_ is a Lur’e system. 

Our structure theorem parameterizes contractive vector fields using Lipschitz functions. It is helpful, therefore, to have an approximately universal parameterization of Lipschitz functions. 

**Lipschitz neural networks.** The Lipschitz constant of a neural network quantifies robustness and generalization [15], [12], and has become an object of study in control theory due to its relationship to (discrete-time) incremental quadratic inequalities. The **trivial bound** , equal to the product of the Lipschitz constants of the layers, is often conservative. Tighter bounds can be obtained via semidefinite relaxations [5], [16], 

[17], but these methods are computationally expensive and do not scale to large networks. 

Counterintuitively, the composite problem of A) training a neural network to minimize a loss function and B) certifying that the network is Lipschitz continuous is easier than certifying an arbitrary neural network. A recent work [10] proposes to penalize the trivial bound directly in the loss function during training. This modification, along with a careful choice of activation functions, leads to networks on which the trivial bound is tight. 

**Contributions.** In this paper we provide an _unconstrained_ parameterization of contracting neural ODEs for the 1- and 

_∞_ -norms. Our contributions are as follows. 

- 1) **Structure theorem (Theorem 2).** We prove an if-andonly-if condition for a WIC vector field in the _p_ -norm ( _p ∈{_ 1 _, ∞}_ ). The problem of parameterizing contracting vector fields reduces losslessly to parameterizing Lipschitz-bounded maps. This decomposition extends to weighted norms _∥Wx∥p_ (Corollary 1). 

- 2) **Unconstrained training.** Combining the structure theorem with a Lipschitz-bounded feedforward network, we obtain a map from an unconstrained parameter space to the set of WIC vector fields, enabling standard gradient-based optimization with no projections or penalty terms. 

   - An upshot of using _p ∈{_ 1 _, ∞}_ is that the Lipschitz estimation is of subdominant computational complexity: _O_ ( _d_[2] ) where _d_ is the dimension of the largest matrix. This is an appreciable advantage compared to _p_ = 2, whereas the trivial bound takes _O_ ( _d_[3] ) and semidefinite programming roughly _O_ ( _d_[3] _[.]_[5] ) (depending on the problem and the model of computation). 

- 3) **Eigenvalue cone condition (Theorem 3).** In the discussion we prove that a diagonalizable 2 _×_ 2 matrix is WIC in a weighted _p_ -norm ( _p ∈{_ 1 _, ∞}_ ) if and only if its eigenvalues lie in the cone _{α_ + _βi_ : _α <_ 0 _, |β| ≤−α}_ , a strict subset of the Hurwitz region. This characterization quantifies the intrinsic conservatism of non-Euclidean contraction relative to 2-norm contraction. 

_Notation:_ For _x ∈_ R _[n]_ and _p ∈_ [1 _, ∞_ ], the _ℓp_ norm is defined as 

**==> picture [207 x 31] intentionally omitted <==**

For _A ∈_ R _[m][×][n]_ , the induced matrix norm is defined as 

**==> picture [167 x 28] intentionally omitted <==**

The Jacobian of a function _f_ : R _[n] →_ R _[m]_ is denoted by _Df_ ( _x_ ) _∈_ R _[m][×][n]_ . The identity function is denoted by id : R _[n] →_ R _[n]_ . The class of Lipschitz functions R _[n] →_ R _[n]_ is denoted by Lip(R _[n]_ ). 

## II. BACKGROUND 

The following definitions and basic results on contraction theory are taken from [1, Ch. 3–4], modulo some simplifica- 

tions such as using R _[n]_ as the domain instead of an arbitrary convex subset. 

**==> picture [247 x 61] intentionally omitted <==**

˙ _Definition 2 ([1, Def. 4.2]):_ A dynamical system _x_ = _f_ ( _x_ ) (respectively, a vector field _f_ ) is weakly infinitesimally contracting (WIC) with respect to _p_ -norm if 

**==> picture [168 x 18] intentionally omitted <==**

_Theorem 1 ([1, Thm. 3.7]):_ Suppose that a dynamic sys˙ tem _x_ = _f_ ( _x_ ) is WIC with respect to the _p_ -norm. Then for ˙ any trajectories _x_ 1( _t_ ) _, x_ 2( _t_ ) of the ODE _x_ = _f_ ( _x_ ), 

**==> picture [149 x 13] intentionally omitted <==**

for all _t ≥_ 0. 

The criteria for _f_ to be WIC are abstract. In the next section, we develop the theory for how to enforce this condition when _f_ is a neural network. 

## III. ENFORCING CONTRACTION 

The abstract definition of matrix measure leads to explicit formulas in certain _p_ . 

_Lemma 1 (Matrix Measure for Common Norms):_ The matrix measure for _p ∈{_ 1 _,_ 2 _, ∞}_ is given by: 

**==> picture [196 x 109] intentionally omitted <==**

Note the resemblance of the _{_ 1 _, ∞}_ -matrix measures to the _{_ 1 _, ∞}_ -matrix norms (respectively). 

_Lemma 2 (Matrix Norms for Common Norms):_ The induced matrix norm for _p ∈{_ 1 _,_ 2 _, ∞}_ is given by: 

**==> picture [197 x 91] intentionally omitted <==**

where _σ_ max( _A_ ) denotes the largest singular value of _A_ . 

Accordingly, matrix measures share many properties with matrix norms, such as subadditivity and homogeneity. 

_Proposition 1 (Properties of Matrix Measure):_ Let _A, B ∈_ R _[n][×][n]_ and _α ∈_ R. The matrix measure satisfies: 

1) _µp_ ( _αA_ ) = _αµp_ ( _A_ ) for _α ≥_ 0, 

2) _µp_ ( _A_ + _B_ ) _≤ µp_ ( _A_ ) + _µp_ ( _B_ ), 

3) _−∥A∥p ≤ µp_ ( _A_ ) _≤∥A∥p_ , 

4) _µp_ ( _A_ + _αI_ ) = _µp_ ( _A_ ) + _α_ , 

5) _|µp_ ( _A_ ) _− µp_ ( _B_ ) _| ≤∥A − B∥p_ , 

6) _µp_ ( _A_ ) _≥_ max _{_ Re( _λ_ ) : _λ ∈ σ_ ( _A_ ) _}_ . 

The only difference between the matrix measures and the matrix norms in _p ∈{_ 1 _, ∞}_ is that the matrix measures deal with the signed value of the diagonal elements, while the matrix norms take the absolute value. However, we make the simple observation that a nonnegative number is equal to its absolute value, and therefore an _f_ whose Jacobian always has a nonnegative diagonal satisfies 

**==> picture [194 x 12] intentionally omitted <==**

In such cases, the quantity _∥Df ∥p_ has a familiar name: 

_Definition 3 (Lipschitz constant):_ Let _f_ : R _[n] →_ R _[n]_ be a differentiable function. The Lipschitz constant of _f_ with respect to the _p_ -norm is defined as 

**==> picture [181 x 18] intentionally omitted <==**

Next, we state the main theorem of this paper, which connects matrix measure and Lipschitz constant. 

_Theorem 2 (Structure Theorem for WIC):_ Let _f_ : R _[n] →_ R _[n]_ be a Lipschitz vector field. Fix _p ∈{_ 1 _, ∞}_ . Then _f_ is WIC if and only if 

**==> picture [167 x 11] intentionally omitted <==**

for some Lipschitz _ϕ_ with _∥ϕ∥_ Lip _,p ≤ γ_ . 

_Proof:_ Proof of _if_ direction:[2] By direct computation, 

**==> picture [175 x 11] intentionally omitted <==**

and therefore 

**==> picture [192 x 27] intentionally omitted <==**

**==> picture [143 x 31] intentionally omitted <==**

**==> picture [143 x 10] intentionally omitted <==**

Therefore, _f_ is WIC. 

Proof of _only if_ direction: Suppose that _f_ is WIC. Define 

**==> picture [207 x 44] intentionally omitted <==**

Moreover, we know that _γ < ∞_ , because 

**==> picture [179 x 19] intentionally omitted <==**

the entry-wise norm, which is finite because _f_ is Lipschitz and all norms on finite-dimensional spaces are equivalent. 

Therefore, in the case that _p_ = 1, 

**==> picture [223 x 143] intentionally omitted <==**

and in the case that _p_ = _∞_ , 

**==> picture [229 x 143] intentionally omitted <==**

This theorem establishes that for _p ∈{_ 1 _, ∞}_ , the map 

**==> picture [226 x 26] intentionally omitted <==**

defined by 

**==> picture [129 x 11] intentionally omitted <==**

is a surjection. In other words, the problem of parameterizing Lipschitz WIC functions reduces to parameterizing Lipschitz functions. 

_Remark 1:_ It is not an onerous restriction to require WIC functions to be furthermore Lipschitz, as Lipschitz continuity is already a natural assumption in theoretical analyses which require existence and uniqueness of classical solutions to ODEs, as well as accurate numerical schemes for integrating them. 

## _A. Extension to weighted norms_ 

˙ An LTI system _x_ = _Ax_ with Hurwitz _A_ may not necessarily contract in the 2-norm _√x_[⊺] _x_ , but _A_ necessarily satisfies a Lyapunov equation: 

**==> picture [67 x 9] intentionally omitted <==**

for some positive definite _P >_ 0. This motivates the consideration of weighted norms _∥Wx∥p_ for invertible _W_ . 

_Definition 4 (Weighted WIC):_ A vector field _f_ : R _[n] →_ R _[n]_ is said to be weighted WIC (wWIC) if there exists an 

> 2This is Exercise E3.8 in [1]. 

invertible weight matrix _W ∈_ R _[n][×][n]_ such that _f_ is WIC with respect to the weighted norm _∥Wx∥p_ . 

Applying Theorem 2 to _W[−]_[1] _f_ , we obtain: 

_Corollary 1 (Structure theorem for weighted norms):_ Let _f_ : R _[n] →_ R _[n]_ be Lipschitz and fix _p ∈{_ 1 _, ∞}_ . Then _f_ is wWIC with weight matrix _W_ if and only if 

**==> picture [183 x 12] intentionally omitted <==**

for some _γ ≥_ 0 and some Lipschitz _ϕ_ with _∥ϕ∥_ Lip _, p ≤ γ_ . 

IV. LIPSCHITZ BY CONSTRUCTION: NEURAL NETWORKS 

Whereas it is not straightforward to parameterize WIC functions directly, we can instead parameterize Lipschitz functions. The Lipschitz-to-WIC mapping is lossless (Theorem 2). In order to get a lossless parameterization of WIC functions, we need to parameterize Lipschitz functions. 

Every neural network (with a Lipschitz activation function) is Lipschitz, and Lipschitz regularity is more than sufficient for universal approximation by neural networks. The challenge consists, however, in determining what the Lipschitz constant is. It is NP-hard to approximate the Lipschitz constant of a general neural network _ϕ_ to arbitrary accuracy; Theorem 2 demands a minimally conservative upper bound. 

To obtain a minimally conservative Lipschitz upper bound, we employ activation functions whose Jacobians always land in extreme points of the operator norm ball. Following [10], we use _saturated polyactivations_ : vector-valued activation functions _⃗σ_ : R _[d] →_ R _[dK]_ whose layerwise Jacobian satisfies 

**==> picture [183 x 27] intentionally omitted <==**

This ensures that the activation nonlinearity contributes unit Lipschitz constant, making the network’s Lipschitz bound tight with respect to the weight matrices. For example, the absolute value _x �→|x|_ saturates all _p_ -norms, while the CReLU _x �→_ (max(0 _, x_ ) _,_ max(0 _, −x_ )) saturates _p ∈_ [1 _, ∞_ ) [14], [10]. 

## V. NUMERICAL EXAMPLES 

## _A. Toy example (_ 1 _-norm contraction)_ 

We generate _N_ = 20 random pairs _{_ ( _xi_ (0) _, xi_ ( _T_ )) _}[N] i_ =1 with _T_ = 1; these are interpreted as origin-destination pairs of an unknown flow. We hope to find the “best-fit” 1-norm w-WIC vector field that explains all of these pairs. 

To do so, we train a contractive neural ODE of the form 

**==> picture [163 x 13] intentionally omitted <==**

by minimizing (in the norm weight _W_ and the network parameters _θ_ ) the profile log-likelihood loss 

**==> picture [240 x 37] intentionally omitted <==**

where _x_ ˆ _i_ ( _T_ ; _θ_ ) is the neural ODE prediction from _xi_ (0). The map _ϕ_ is a one-hidden-layer MLP with 40 hidden units, vector-valued activation _x �→ x_ +sin2 _x ,[x][−]_[sin] 2 _[ x]_ . Training � � uses 400 steps of Cocob [13]. 

## _B. Opinion network (∞-norm contraction)_ 

The ground truth system is a nonlinear opinion dynamics model on a strongly connected weighted digraph with _n_ = 4 nodes: ˙ _x_ = _−D x_ + _ν_ tanh( _A x_ ) _,_ (24) 

where _A ∈_ R[4] _≥[×]_ 0[4][is][the][adjacency][matrix,] _[D]_[= diag(] _[A]_ **[1]**[4][)][is] the out-degree matrix, and _ν ∈_ [0 _,_ 1] is an activation parameter. Exercise 4.5 [1] shows that this system, derived from [6], is WIC in the _∞_ -norm for all _ν ≤_ 1. We set _ν_ = 1 (weak contraction, _µ∞_ = 0). 

We generate _N_ = 100 training and 50 test trajectory pairs ( _xi_ (0) _, xi_ ( _T_ )) with _T_ = 2 from initial conditions _xi_ (0) _∼N_ (0 _,_ 4 _I_ 4). A contractive neural ODE with _p_ = _∞_ , a one-hidden-layer MLP with 40 hidden units, and _x �→_ ( _|x|_ ) activation is trained for 2000 steps. 

Figure 2 shows the training and test loss curves, groundtruth and learned time series for six initial conditions, and pairwise projections of the vector fields. The learned model captures the consensus-seeking dynamics of equation 24: trajectories converge toward the origin, reproducing the qualitative behavior of the ground-truth system while maintaining _∞_ -norm contractivity by construction. 

**==> picture [169 x 22] intentionally omitted <==**

We begin by praising the advantages of incremental contraction in _p ∈{_ 1 _, ∞}_ before reflecting on their limitations. 

- 1) The structure theorem 2 and its corollary for weighted norms comprise an if-and-only-if description of 1- and _∞_ -norm WIC systems in terms of a simpler concept (Lipschitz functions). 

- 2) Verifying the Lipschitz constant in _p ∈{_ 1 _, ∞}_ only requires _O_ ( _d_[2] ) operations, where _d_ is the state or hidden layer dimension, whichever is higher. This is thus of the same order as feedforward evaluation. Eigenvalue and semidefinite programming techniques for the _p_ = 2 norm are _O_ ( _d_[3] ) and _O_ ( _d_[3] _[.]_[5] ), respectively. 

˙ Why, then is the literature on systems _x_ = _f_ ( _x_ ) that contract in the the _p_ -norm for _p ∈{_ 1 _, ∞}_ rich in theory and poor in concrete examples? The ratio of **definitions** : **theorems** : **examples** in a theory paper on continuous-time contraction in the 2-norm is 2 : 2 : 9.[3] A recent work on non-Euclidean contraction theory has a ratio of 14 : 34 : 1. We posit that this literature (the current work included) is topheavy because _p ∈{_ 1 _, ∞}_ -contractions are intrinsically less diverse and less physical—unphysical should not, however be taken to mean uninteresting or unimportant, and it does not diminish the mathematical and substantive contributions that have arised in the analysis of physically motivated Lur’e systems (such as continuous-time neuron models), synthetic applications such as opinion dynamics, and others. 

Our structure theorem explains why most contractive systems ( _p ∈{_ 1 _, ∞}_ ) in the analysis literature are Lur’e systems. It is because in fact, all of them are. 

> 3Here, “theorems” includes lemmas and “examples” includes counterexamples. 

**==> picture [505 x 253] intentionally omitted <==**

**----- Start of picture text -----**<br>
Dataset Phase portrait with integral curves<br>source source<br>destination destination<br>1.5<br>1.0<br>1.0<br>0.5<br>0.5<br>0.0 0.0<br>0.5<br>0.5<br>1.0<br>1.0<br>1.5<br>2 1 0 1 2 2 1 0 1 2<br>x1 x1<br>x2 x2<br>**----- End of picture text -----**<br>


Fig. 1. Phase portrait comparison for the toy example. Left: origin-destination pairs. Right: learned contractive neural ODE. 

**==> picture [504 x 316] intentionally omitted <==**

**----- Start of picture text -----**<br>
Example 2: Opinion network ( -norm contraction, 4 nodes, = 1.0)<br>Opinion network (4-node digraph) Training / test loss Test trajectories (GT solid, learned dashed)<br>1 traintest 2 node 0node 1 node 2node 3 ground truthlearned<br>2<br>1<br>0<br>10 2<br>1<br>2<br>0<br>3 3<br>0 250 500 750 1000 1250 1500 1750 2000 0.00 0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00<br>Step t<br>Vector field proj. (x0, x1) Vector field proj. (x0, x2) Vector field proj. (x1, x3)<br>GT GT GT<br>3 learned 4 learned 4 learned<br>2<br>2 2<br>1<br>0<br>0 0<br>1<br>2<br>2 2<br>3<br>4 4 4<br>3 2 1 0 1 2 3 3 2 1 0 1 2 3 4 3 2 1 0 1 2 3<br>x0 x0 x1<br>0.7 0.5<br>0.4 0.8<br>0.3<br>0.6<br>0.5<br>0.2<br>)(txi<br>Profile likelihood loss<br>x1 x2 x3<br>**----- End of picture text -----**<br>


Fig. 2. Opinion network example. Top left: the 4-node weighted digraph defining _A_ . Top middle: training and test loss. Top right: ground truth (solid) and learned predictions (dashed) for one initial condition in the test dataset. Bottom row: pairwise projections of the ground-truth (blue) and learned (orange) vector fields onto the ( _x_ 0 _, x_ 1), ( _x_ 0 _, x_ 2), and ( _x_ 1 _, x_ 3) planes. 

## _A. Diversity_ 

Recall that infinitesimal contraction means that along a ˙ trajectory _x_ = _f_ ( _x_ ), the variational linear time-varying equation 

**==> picture [156 x 34] intentionally omitted <==**

satisfies the contraction condition. Over short times ∆ _t_ , 

**==> picture [125 x 11] intentionally omitted <==**

and the _p_ -norm contraction condition is satisfied if ��exp( _A_ ∆ _t_ )�� _p[<]_[1][.][How][many][such][matrices][are][there][for] each _p_ ? 

As a proxy for the diversity of contracting flows, we may assess the size of the isometry group of the _p_ -norm, namely those matrices _O ∈_ R _[n][×][n]_ satisfying _∥Ox∥p_ = _∥x∥p_ for all _x ∈_ R _[n]_ . In _p_ = 2, the isometry group is the orthogonal group _O_ ( _n_ ), which is a smooth manifold of dimension _n_ ( _n−_ 1) 2 . In _p ∈_ [1 _, ∞_ ] _−{_ 2 _}_ , the isometry group is discrete and consists only of signed permutation matrices. This is essentially because the unit sphere is a (rounded) polyhedron, and any isometry must map vertices to vertices.[4] 

## _B. Physicality_ 

The laws of mechanics, as well as those of electricity and magnetism, are symmetric with respect to solid-body rotation. This means that the potential and kinetic energy scalars from which laws of motion are derived in the Lagrangian or Hamiltonian formalisms can feature no _p_ -norm other than _p_ = 2. In contrast, _p ∈{_ 1 _, ∞}_ norms do not arise naturally in mechanics. Many mechanical systems which are stable (in the energy sense) are not contractive in the _p ∈{_ 1 _, ∞}_ sense. 

To make this sense of strictness precise, let us identify the ˙ generic contracting linear systems _x_ = _Ax_ in dimension 2. ˙ According to modal decomposition, for _x_ = _Ax_ to be WIC in a weighted 2-norm, it is necessary and sufficient for _A_ to marginally stable. In the _p_ = 1 and _p_ = _∞_ cases, the eigenvalues must lie in a strict subset of the left half-plane. 

_Theorem 3:_ Let _A ∈_ R[2] _[×]_[2] be diagonalizable and _p ∈ {_ 1 _, ∞}_ . Then _A_ is WIC in a weighted _p_ -norm if and only if its eigenvalues lie in the cone _{α_ + _βi_ : _α ≤_ 0 _, |β| ≤−α}_ . 

_Proof: If direction._ Suppose the eigenvalues of _A_ lie in the cone. If _A_ has real eigenvalues _λ_ 1 _, λ_ 2 _≤_ 0, then _A_ is similar to diag( _λ_ 1 _, λ_ 2), which has _µp_ = max( _λ_ 1 _, λ_ 2) _≤_ 0. If _A_ has complex eigenvalues _α ± βi_ with _|β| ≤−α_ , then _A_ is similar to _B_ = � _−αβ αβ_ �, and Lemma 1 gives _µ_ 1( _B_ ) = _α_ + _|β| ≤_ 0. 

˙ _Only if direction._ WIC of _x_ = _Ax_ in _∥Wx∥p_ is equivalent to _µp_ ( _C_ ) _≤_ 0 where _C_ = _WAW[−]_[1] . By Proposition 1(6), every eigenvalue has Re( _λ_ ) _≤_ 0. It remains to show that complex eigenvalues _α ± βi_ satisfy _|β| ≤−α_ . Let _C ∈_ R[2] _[×]_[2] 

> 4This fact was communicated to the first author by Ken Brown and Gavin Pandya. 

satisfy _µp_ ( _C_ ) _≤_ 0 with eigenvalues _α ± βi_ , _β_ = 0. The trace and determinant of _C_ are determined by the eigenvalues: 

**==> picture [114 x 24] intentionally omitted <==**

For _p_ = 1, the matrix measure is 

**==> picture [163 x 10] intentionally omitted <==**

Thus _µ_ 1( _C_ ) _≤_ 0 requires _c_ 11 _≤−|c_ 21 _|_ and _c_ 22 _≤−|c_ 12 _|_ , hence both diagonal entries are nonpositive and 

**==> picture [133 x 11] intentionally omitted <==**

## Then 

_α_[2] + _β_[2] = _c_ 11 _c_ 22 _− c_ 12 _c_ 21 _≤ c_ 11 _c_ 22 + _|c_ 12 _c_ 21 _| ≤_ 2 _c_ 11 _c_ 22 _._ By AM–GM on the nonpositive diagonal entries, 

**==> picture [126 x 27] intentionally omitted <==**

so _α_[2] + _β_[2] _≤_ 2 _α_[2] , i.e. _|β| ≤|α|_ = _−α_ . The _p_ = _∞_ case can be obtained by transposing _C_ , which swaps the roles of rows and columns while preserving the trace and determinant. 

_Remark 2:_ Theorem 3 can be restated in terms of the similarity invariants _τ_ = tr _A_ and _δ_ = det _A_ . For _p_ = 2, WIC in a weighted 2-norm requires only that _A_ be marginally stable, i.e. _τ <_ 0 and _δ >_ 0. For _p ∈{_ 1 _, ∞}_ , the eigenvalue cone imposes the additional constraint _δ ≤ τ_[2] _/_ 2. 

To see this, note that if _A_ has real eigenvalues _λ_ 1 _, λ_ 2 _≤_ 0, then _τ_ = _λ_ 1 + _λ_ 2 _≤_ 0, _δ_ = _λ_ 1 _λ_ 2 _≥_ 0, and the discriminant condition gives _δ ≤ τ_[2] _/_ 4 _≤ τ_[2] _/_ 2. If _A_ has complex eigenvalues _α ± βi_ , then _τ_ = 2 _α_ and _δ_ = _α_[2] + _β_[2] . The cone condition _|β| ≤−α_ becomes _δ_ = _α_[2] + _β_[2] _≤_ 2 _α_[2] = _τ_[2] _/_ 2. Thus, for _p ∈{_ 1 _, ∞}_ , the WIC region in the ( _τ, δ_ )-plane is 

**==> picture [135 x 12] intentionally omitted <==**

a strict subset of the stable region _{τ ≤_ 0 _, δ ≥_ 0 _}_ ; see Figure 3. The boundary parabola _δ_ = _τ_[2] _/_ 2 corresponds to eigenvalues on the rays _α ± αi_ ( _α <_ 0), i.e. the boundary of the cone at 45 _[◦]_ from the negative real axis. 

## VII. CONCLUSION 

We presented an unconstrained parameterization of neural ODEs that are weakly infinitesimally contracting in the 1- and _∞_ -norms. The key ingredient is a structure theorem (Theorem 2) that reduces the design of contracting vector fields to the design of Lipschitz-bounded maps, a problem for which scalable neural-network architectures already exist. The resulting training procedure requires no projections, barrier functions, or penalty terms, and the per-layer Lipschitz certification costs only _O_ ( _d_[2] ) operations. Preliminary numerical experiments on a toy flow-fitting task and a four-node opinion network demonstrate that the parameterization can recover contracting dynamics from trajectory data. 

An eigenvalue-cone characterization (Theorem 3) clarifies the price of non-Euclidean contraction: in dimension two, 

**==> picture [245 x 164] intentionally omitted <==**

**----- Start of picture text -----**<br>
Stability regions of 2 × 2 matrix invariants<br>Hurwitz (p = 2 WIC)<br>p {1, } WIC<br>= 2/2<br>= 2/4 (discriminant)<br>p = 2<br>WIC<br>complex<br>eigenvalues<br>real<br>eigenvalues<br>p {1, } unstable<br>WIC<br>0<br>unstable unstable<br>0<br>= tr A<br> A<br>= det<br>**----- End of picture text -----**<br>


Fig. 3. The ( _τ, δ_ )-plane for diagonalizable 2 _×_ 2 matrices with _τ_ = tr _A_ and _δ_ = det _A_ . The shaded marginally stable region ( _τ <_ 0, _δ >_ 0) characterizes _p_ = 2 WIC. The hatched subregion below the parabola _δ_ = _τ_[2] _/_ 2 characterizes _p ∈{_ 1 _, ∞}_ WIC. The dashed curve _δ_ = _τ_[2] _/_ 4 is the zero set of the discriminant _τ_[2] _−_ 4 _δ_ : eigenvalues are real below it and complex above it. 

- [13] Francesco Orabona and Tatiana Tommasi. Training Deep Networks without Learning Rates Through Coin Betting. In _Advances in Neural Information Processing Systems_ , volume 30. Curran Associates, Inc., 2017. 

- [14] Wenling Shang, Kihyuk Sohn, Diogo Almeida, and Honglak Lee. Understanding and improving convolutional neural networks via concatenated rectified linear units. In _international conference on machine learning_ , pages 2217–2225. PMLR, 2016. 

- [15] Aladin Virmaux and Kevin Scaman. Lipschitz Regularity of Deep Neural Networks: Analysis and Efficient Estimation. In S. Bengio, H. Wallach, H. Larochelle, K. Grauman, N. Cesa-Bianchi, and R. Garnett, editors, _Advances in Neural Information Processing Systems_ , volume 31. Curran Associates, Inc., 2018. 

- [16] Yuezhu Xu and S. Sivaranjani. ECLipsE: Efficient Compositional Lipschitz Constant Estimation for Deep Neural Networks. In A. Globerson, L. Mackey, D. Belgrave, A. Fan, U. Paquet, J. Tomczak, and C. Zhang, editors, _Advances in Neural Information Processing Systems_ , volume 37, pages 10414–10441. Curran Associates, Inc., 2024. 

- [17] Yuezhu Xu and S. Sivaranjani. ECLipsE-Gen-Local: Efficient Compositional Local Lipschitz Estimates for Deep Neural Networks, October 2025. arXiv:2510.05261 [cs]. 

the set of _p ∈{_ 1 _, ∞}_ -contracting linear systems is a strict subset of the marginally stable systems, reflecting a fundamental trade-off between computational tractability and expressiveness. Extending this characterization to higher dimensions and to other values of _p_ remains an open problem. 

## REFERENCES 

- [1] F. Bullo. _Contraction Theory for Dynamical Systems_ . Kindle Direct Publishing, 1.3 edition, 2026. 

- [2] Ricky T. Q. Chen, Yulia Rubanova, Jesse Bettencourt, and David K Duvenaud. Neural Ordinary Differential Equations. In _Advances in Neural Information Processing Systems_ , volume 31. Curran Associates, Inc., 2018. 

- [3] Alexander Davydov and Francesco Bullo. Perspectives on Contractivity in Control, Optimization, and Learning. _IEEE Control Systems Letters_ , 8:2087–2098, 2024. 

- [4] Alexander Davydov, Saber Jafarpour, and Francesco Bullo. NonEuclidean Contraction Theory for Robust Nonlinear Stability. _IEEE Transactions on Automatic Control_ , 67(12):6667–6681, December 2022. 

- [5] Mahyar Fazlyab, Alexander Robey, Hamed Hassani, Manfred Morari, and George Pappas. Efficient and Accurate Estimation of Lipschitz Constants for Deep Neural Networks. In _Advances in Neural Information Processing Systems_ , volume 32. Curran Associates, Inc., 2019. 

- [6] Rebecca Gray, Alessio Franci, Vaibhav Srivastava, and Naomi Ehrich Leonard. Multiagent Decision-Making Dynamics Inspired by Honeybees. _IEEE Transactions on Control of Network Systems_ , 5(2):793–806, June 2018. 

- [7] Eldad Haber and Lars Ruthotto. Stable Architectures for Deep Neural Networks. _Inverse Problems_ , 34(1):014004, 2017. 

- [8] Saber Jafarpour, Pedro Cisneros-Velarde, and Francesco Bullo. Weak and Semi-Contraction for Network Systems and Diffusively Coupled Oscillators. _IEEE Transactions on Automatic Control_ , 67(3):1285–1300, March 2022. 

- [9] Patrick Kidger. _On Neural Differential Equations_ . PhD thesis, arXiv, February 2022. arXiv:2202.02435 [cs, math, stat]. 

- [10] Simon Kuang, Yuezhu Xu, S. Sivaranjani, and Xinfan Lin. Lipschitz verification of neural networks through training, 2026. arxiv:2603.28113. 

- [11] Winfried Lohmiller and Jean-Jacques E. Slotine. On Contraction Analysis for Non-linear Systems. _Automatica_ , 34(6):683–696, June 1998. 

- [12] Takeru Miyato, Toshiki Kataoka, Masanori Koyama, and Yuichi Yoshida. Spectral Normalization for Generative Adversarial Networks. In _International Conference on Learning Representations_ , 2018. 

