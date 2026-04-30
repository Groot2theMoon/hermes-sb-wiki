---
title: "Direct Parameterization of Lipschitz-Bounded Deep Networks"
arxiv: "2301.11526"
authors: ["Ruigang Wang", "Ian R. Manchester"]
year: 2023
source: paper
ingested: 2026-05-01
sha256: dacde7c793d259987ae299c79fb43ef5bee9e0f0189b4720389668c81736f7be
conversion: pymupdf4llm
---

**Direct Parameterization of Lipschitz-Bounded Deep Networks** 

## **Ruigang Wang**[1] **Ian R. Manchester**[1] 

## **Abstract** 

This paper introduces a new parameterization of deep neural networks (both fully-connected and convolutional) with guaranteed _ℓ_[2] Lipschitz bounds, i.e. limited sensitivity to input perturbations. The Lipschitz guarantees are equivalent to the tightest-known bounds based on certification via a semidefinite program (SDP). We provide a “direct” parameterization, i.e., a smooth mapping from R _[N]_ onto the set of weights satisfying the SDP-based bound. Moreover, our parameterization is complete, i.e. a neural network satisfies the SDP bound if and only if it can be represented via our parameterization. This enables training using standard gradient methods, without any inner approximation or computationally intensive tasks (e.g. projections or barrier terms) for the SDP constraint. The new parameterization can equivalently be thought of as either a new layer type (the _sandwich layer_ ), or a novel parameterization of standard feedforward networks with parameter sharing between neighbouring layers. A comprehensive set of experiments on image classification shows that sandwich layers outperform previous approaches on both empirical and certified robust accuracy. Code is available at https://github.com/acfr/LBDN. 

## **1. Introduction** 

Neural networks have enjoyed wide application due to their many favourable properties, including highly accurate fits to training data, surprising generalisation performance within a distribution, as well as scalability to very large models and data sets. Nevertheless, it has also been observed that they can be highly sensitive to small input perturbations (Szegedy et al., 2014). This is a critical limitation in applications in 

> 1Australian Centre for Robotics, School of Aerospace, Mechanical and Mechatronic Engineering, The University of Sydney, Sydney, NSW 2006, Australia. Correspondence to: Ruigang Wang _<_ ruigang.wang@sydney.edu.au _>_ . 

_Proceedings of the 40[th] International Conference on Machine Learning_ , Honolulu, Hawaii, USA. PMLR 202, 2023. Copyright 2023 by the author(s). 

which certifiable robustness is required, or the smoothness of a learned function is important. 

A standard way to quantify sensitivity of models is via a _Lipschitz bound_ , which generalises the notion of a sloperestricted scalar function. A function _x �→ f_ ( _x_ ) between normed spaces satisfies a Lipschitz bound _γ_ if 

**==> picture [185 x 11] intentionally omitted <==**

for all _x_ 1 _, x_ 2 in its domain. The (true) Lipschitz constant of a function, denoted by Lip( _f_ ), is the smallest such _γ_ . Moreover, we call _f_ a _γ-Lipschitz_ function if Lip( _f_ ) _≤ γ_ . 

A natural application of Lipschitz-bounds is to control a model’s sensitivity to _adversarial_ (worst-case) inputs, e.g. (Madry et al., 2018; Tsuzuku et al., 2018), but they can also be effective for regularisation (Gouk et al., 2021) and Lipschitz constants often appear in theoretical generalization bounds (Bartlett et al., 2017; Bubeck & Sellke, 2023). Lipschitz-bounded networks have found many applications, including: stabilising the learning of generative adversarial networks (Arjovsky et al., 2017; Gulrajani et al., 2017); implicit geometry mechanisms for computer graphics (Liu et al., 2022); in reinforcement learning to controlling sensitivity to measurement noise (e.g. (Russo & Proutiere, 2021)) and to ensure robust stability of feedback loops during learning (Wang & Manchester, 2022); and the training of differentially-private neural networks (Bethune et al., 2023). In robotics applications, several learning-based planning and control algorithms require known Lipschitz bounds in learned stability certificates, see e.g. the recent surveys (Brunke et al., 2022; Dawson et al., 2023). 

Unfortunately, even for two-layer perceptrons with ReLU activations, exact calculation of the true Lipschitz constant for _ℓ_[2] (Euclidean) norms is NP-hard (Virmaux & Scaman, 2018), so attention has focused on approximations that balance accuracy with computational tractability. Crude _ℓ_[2] - bounds can be found via the product of spectral norms of layer weights (Szegedy et al., 2014), however to date the most accurate polynomial-time computable bounds require solution of a semidefinite program (SDP) (Fazlyab et al., 2019), which is computationally tractable only for relatively small fully-connected networks. 

While _certification_ of a Lipschitz bound of a network is a (convex) SDP with this method, the set of weights sat- 

1 

**Lipschitz-Bounded Deep Networks** 

**2** 

isfying a prescribed Lipschitz bound is non-convex, complicating training. Both (Rosca et al., 2020) and (Dawson et al., 2023) highlight the computationally-intensive nature of SDP-based bounds as limitations for applications. 

**Contribution.** In this paper we introduce a new parameterization of standard feedforward neural networks, both fully-connected multi-layer perceptron (MLP) and deep convolutional neural networks (CNN). 

- The proposed parameterization has _built-in_ guarantees on the network’s Lipschitz bound, equivalent to the best-known bounds provided by the SDP method (Fazlyab et al., 2019). 

- Our parameterization is a smooth surjective mapping from an unconstrained parameter space R _[N]_ onto the (non-convex) set of network weights satisfying these SDP-based bounds. This enables learning of lipschitz-bounded networks via standard gradient methods, avoiding the complex projection steps or barrier function computations that have previously been required and limited scalability. 

- The new parameterization can equivalently be treated as either a composition of new 1-Lipschitz layers called _Sandwich_ layer, or a parameterization of standard feedforward networks with coupling parameters between neighbouring layers. 

**Notation.** Let R be the set of real numbers. _A ⪰_ 0 means that a square matrix _A_ is a positive semi-definite. We denote by D _[n]_ ++[for the set of] _[ n][ ×][ n]_[ positive diagonal matrices.][For] a vector _x ∈_ R _[n]_ , its 2-norm is denoted by _∥x∥_ . Given a matrix _A ∈_ R _[m][×][n]_ , _∥A∥_ is defined as its the largest singular value and _A_[+] denotes its Moore–Penrose pseudoinverse. 

## **2. Problem Setup and Preliminaries** 

Consider an _L_ -layer feedforward neural network _y_ = _f_ ( _x_ ) described by the following recursive equations: 

**==> picture [207 x 38] intentionally omitted <==**

where _x ∈_ R _[n]_[0] _, zk ∈_ R _[n][k] , y ∈_ R _[n][L]_[+1] are the network input, hidden unit of the _k_ th layer and network output, respectively. Here _Wk ∈_ R _[n][k]_[+1] _[×][n][k]_ and _bk ∈_ R _[n][k]_[+1] are the weight matrix and bias vector for the _k_ th layer, and _σ_ is a scalar activation function applied element-wise. We make the following assumption, which holds for most commonlyused activation functions (possibly after rescaling) (Goodfellow et al., 2016). 

**Assumption 2.1.** The nonlinear activation _σ_ : R _→_ R is piecewise differentiable and slope-restricted in [0 _,_ 1]. 

If different channels have different activation functions, then we simply require that they all satisfy the above assumption. 

The main goal of this work is to learn feedforward networks (2) with certified Lipschitz bound of _γ_ , i.e., 

**==> picture [184 x 16] intentionally omitted <==**

where _L_ ( _·_ ) is a loss function and _ϕ_ := _{_ ( _Wk, bk_ ) _}_ 0 _≤k≤L_ is the learnable parameter. Since it is NP-hard to compute Lip( _fϕ_ ), we seek an accurate Lipschitz bound estimation so that the constraint in (3) does not lead to a significant restriction on the model expressivity. 

In (Fazlyab et al., 2019), integral quadratic constraint (IQC) methods were applied to capture both monotonicity and 1-Lipschitzness properties of _σ_ , leading to state-of-the-art Lipschitz bound estimation based on the following linear matrix inequality (LMI), see details in Appendix A: 

**==> picture [224 x 37] intentionally omitted <==**

where Λ _∈_ D _[n]_ ++[with] _[ n]_[ =][ �] _[L] k_ =1 _[n][k]_[, and] 

**==> picture [186 x 77] intentionally omitted <==**

_Remark_ 2.2 _._ The published paper (Fazlyab et al., 2019) claimed that even tighter Lipschitz bounds could be achieved with a less restrictive class of multipliers Λ than diagonal. However, this is false: a counterexample was presented in (Pauli et al., 2021), and the error in the proof was explained in (Revay et al., 2020b), see also Remark A.2 in the appendix of this paper. 

In this paper we approach problem (3) via model parameterizations guaranteeing a given Lipschitz bound. 

**Definition 2.3.** A parameterization of the network (2) is a differentiable mapping _ϕ_ = _M_ ( _θ_ ) where _θ ∈_ Θ _⊆_ R _[N]_ . It is called a _convex parameterization_ if Θ is convex, and a _direct parameterization_ if Θ = R _[N]_ . 

Given a network with fixed _W, U, Y_ , Condition (4) is convex with respect to the Lipschitz bound _γ_ and multiplier Λ. When training a network with specified bound _γ_ , we can convert (4) into a convex parameterization by introducing 

2 

**Lipschitz-Bounded Deep Networks** 

**3** 

**==> picture [487 x 131] intentionally omitted <==**

**----- Start of picture text -----**<br>
H P P [⊤] d k ∈ R [k][+1]<br>2Λk − B k [⊤][Ψ] [k] Wk+1 e [d] [k] e [−] [d] [k] Wk<br>Ψ k A k<br>= × A [⊤] k− 1 [Ψ] [k][−] [1] f (x) σ Ψ [−] k+1 [1] 2Bk+1A [⊤] k Ψ k σ Ψ [−] k [1] 2BkA [⊤] k− 1 Ψ k− 1 σ x<br>−ΛkWk − Ψ k B k A [⊤] k [Ψ] [k]<br>·<br>Cayley( )<br>Figure 1.  Illustration of the sparsity pattern in H that must be �XYkk� ∈ R [(][n][k][+1][+][n][k][)] [×] [n][k][+1]<br>preserved by the factorization  H =  PP [[⊤]] . R [N] ∋ θ := {(Xk, Yk, bk, dk)}0≤k≤L −→M φ := {(Wk, bk)}0≤k≤L<br>· · · · · ·<br>**----- End of picture text -----**<br>


_Figure 1._ Illustration of the sparsity pattern in _H_ that must be preserved by the factorization _H_ = _PP[[⊤]]_ . 

new decision variables _U_[˜] = Λ _U, W_[˜] = Λ _W_ , (4) becomes 

_Figure 2._ Direct parameterization for Lipschitz-bounded deep networks, i.e. Lip( _fϕ_ ) _≤ γ_ with _ϕ_ = _M_ ( _θ_ ) for all _θ ∈_ R _[N]_ . Note that free parameters are shared across neighbouring layers. 

**==> picture [233 x 81] intentionally omitted <==**

_VkVk[⊤]_[+] _[ D][k][D] k[⊤]_[are][diagonal][matrices.][We][do][so][by][the] Cayley transform for orthogonal matrix parameterization (Trockman & Kolter, 2021), i.e., for any _X ∈_ R _[m][×][m] , Y ∈_ R _[n][×][m]_ we have _Q[⊤] Q_ = _I_ if 

where _W_[ˆ] _k_ = Λ _kWk_ for 0 _≤ k < L_ and _W_[ˆ] _L_ = _WL_ . In (Pauli et al., 2021; Revay et al., 2020a), constrained optimization methods such as convex projection and barrier functions are applied for training. However, even for relatively small-scale networks (e.g. _∼_ 1000 neurons), the associated barrier terms or projections become a major computational bottleneck. 

**==> picture [214 x 24] intentionally omitted <==**

with _Z_ = _X − X[⊤]_ + _Y[⊤] Y_ . To be more specific, we take _Dk_ = Ψ _kAk_ and _Vk_ = Ψ _kBk_ where 

**==> picture [214 x 25] intentionally omitted <==**

## **3. Direct Parameterization** 

for some free vector _dk_ and matrices _Xk, Yk_ with proper dimension. Now we can verify that _H_ = _PP[⊤]_ has the same structure as (5), i.e., 

In this section we will present our main contribution – a direct parameterization _ϕ_ = _M_ ( _θ_ ) such that _ϕ_ automatically satisfies (4) and hence (1) for any _θ ∈_ R _[N]_ . Then, the learning problem (3) can be transformed into an unconstrained optimization problem 

**==> picture [159 x 29] intentionally omitted <==**

**==> picture [75 x 16] intentionally omitted <==**

Moreover, we can construct the multiplier Λ _k_ =[1] 2[Ψ] _k_[2][and] the weight matrix 

First, it is clear that (5) is satisfied if we parameterize _H_ as _H_ = _PP[⊤]_ . The main challenge then is to parameterize _P_ such that the particular sparsity pattern of _H_ is recovered: a block-tridiagonal structure where the main diagonal blocks must be positive diagonal matrices, see Equation (5) and Figure 1. First, the block-tridiagonal structure can be achieved by taking 

_Wk_ = _−_ Λ _[−] k_[1] _[H][k][−]_[1] _[,k]_[= 2Ψ] _[−] k_[1] _[B][k][A] k[⊤] −_ 1[Ψ] _[k][−]_[1] (8) with _k_ = 0 _, . . . , L_ , where _A−_ 1 = _I,_ Ψ _−_ 1 = ~~�~~ _γ/_ 2 _I_ and Ψ _L_ = ~~�~~ 2 _/γI_ with _γ_ as the prescribed Lipschitz bound. We summarize our model parameterization as follows. The free parameter _θ_ consists of bias terms _bk ∈_ R _[n][k]_[+1] and 

**==> picture [135 x 55] intentionally omitted <==**

**==> picture [191 x 11] intentionally omitted <==**

with 0 _≤ j < L_ and 0 _≤ k ≤ L_ . The weight _Wk_ is constructed via (7) and (8). Notice that _Wk_ depends on parameters of index _k_ and _k −_ 1, i.e. there is an “interlacing” coupling between parameters and weights, see Figure 2. 

i.e., block Cholesky factorization of _H_ . The next step is to construct _Vk_ and _Dk_ such that the diagonal blocks _Hkk_ = 

3 

**Lipschitz-Bounded Deep Networks** 

**4** 

## **3.1. Theoretical results** 

The main theoretical results is that our parameterization is _complete_ (necessary and sufficient) for the set of DNNs satisfying the LMI constraint (5) of (Fazlyab et al., 2019). 

**Theorem 3.1.** _The feedforward network_ (2) _satisfies the LMI condition_ (5) _if and only if its weight matrices Wk can be parameterized via_ (8) _._ 

The proof to this and all other theorems can be found in Appendix D. 

**1-Lipschitz sandwich layer.** Here we show that the new parameterization can also be interpreted as a new layer type. We first introduce new hidden units _hk_ = _√_ 2 _A[⊤] k_[Ψ] _[k][z][k]_[for] _k_ = 0 _, . . . L_ and then rewrite the proposed LBDN model as 

**==> picture [200 x 43] intentionally omitted <==**

The core component of the above model is a sandwichstructured layer of the form: 

**==> picture [193 x 13] intentionally omitted <==**

where _h_ in _∈_ R _[p] , h_ out _∈_ R _[q]_ are the layer input and output, respectively. Unlike the parameterization in (8), consecutive layers in (9) do not have coupled free parameters, which allows for modular implementation. Another advantage is that such representation can reveal some fundamental insights on the roles of Ψ _, A_ and _B_ . 

**Theorem 3.2.** _The layer_ (10) _with_ Ψ _, A, B constructed by_ (7) _is 1-Lipschitz._ 

To understand the role of Ψ, we look at a new activation layer which is obtained by placing Ψ _[−]_[1] _∈_ D _[q]_ ++[and][ Ψ][ be-] fore and after _σ_ , i.e., _u_ = Ψ _σ_ (Ψ _[−]_[1] _v_ + _b_ ). Here Ψ can change the shape and shift the position of individual activation channels while keeping their slopes within [0 _,_ 1], allowing the optimizer to search over a rich set of activations. 

For the roles of _A_ and _B_ , we need to look at another special case of (10) where _σ_ is the identity operator. Then, (10) becomes a linear layer 

**==> picture [163 x 12] intentionally omitted <==**

As a direct corollary of Theorem 3.2, the above linear layer is 1-Lipschitz, i.e., _∥_ 2 _A[⊤] B∥≤_ 1. We show that such a parameterization is _complete_ for 1-Lipschitz linear layers. 

**Proposition 3.3.** _A linear layer is 1-Lipschitz if and only if its weight W satisfies W_ = 2 _A[⊤] B with A, B given by_ (7) _._ 

## **Algorithm 1** 1-Lipschitz convolutional layer 

|**Require:** _h_in _∈_R_p×s×s_,_P _<br>1: ˜_h_in _←_FFT(_h_in)|_∈_R(_p_+_q_)_×q×s×s_,_d ∈_R_q_|
|---|---|
|2: Ψ_←_diag(_ed_)_,_<br>�˜_A_<br>˜_B_|�_∗←_Cayley(FFT(_P_))|
|3: ˜_h_[:_, i, j_]_←_<br>_√_<br>2Ψ_−_1˜_B_[:_,_:_, i, j_]˜_h_in[:_, i, j_]<br>4: ˜_h ←_FFT<br>�<br>_σ_(FFT_−_1(˜_h_) +_b_)<br>�<br>5: ˜_h_out[:_, i, j_]_←_<br>_√_<br>2_A_[:_,_:_, i, j_]_∗_Ψ˜_h_[:_, i, j_]||
|6: _h_out _←_FFT_−_1(˜_h_out)||



**Convolution layer.** Our proposed 1-Lipschitz layer can also incorporate more structured linear operators such as _circular convolution_ . Thanks to the doubly-circular structure, we can perform efficient model parameterization in the Fourier domain. Roughly speaking, transposing or inverting a convolution is equivalent to apply the complex version of the same operation to its Fourier domain representation – a batch of small complex matrices (Trockman & Kolter, 2021). Algorithm 1 shows the forward computation of 1-Lipschitz convolutional layers, see Appendix B for more detailed explanations. In line 1 and 6, we use the (inverse) FFT on the input/output tensor. In line 2, we perform the Cayley transformation of convolutions in the Fourier domain, which involves _s ×_ ( _⌊s/_ 2 _⌋_ + 1) parallel complex matrix inverse of size _q × q_ where _q, s_ are the number of hidden channels and input image size, respectively. In line 3-5, all operations related to the ( _i, j_ )[th] term can be done in parallel. 

## **4. Comparisons to Related Prior Work** 

In this section we give an overview of related prior work and provide some theoretical comparison to the proposed approach. 

## **4.1. SDP-based Lipschitz training** 

Since the SDP-based bounds of (Fazlyab et al., 2019) appeared, several papers have proposed methods to allow training of Lipschitz models. In (Pauli et al., 2021; Revay et al., 2020a), training was done by constrained optimization techniques (projections and barrier function, respectively). However, those approaches have the computational bottleneck for relatively-small ( _∼_ 1000 neurons) networks. (Xue et al., 2022) decomposed the large SDP for Lipschitz bound estimation into many small SDPs via chordal decomposition. 

Direct parameterization of the SDP-based Lipschitz condition was introduced in (Revay et al., 2020b) for equilibrium networks – a more general architecture than the feedforward networks. The basic idea was related to the method of (Burer & Monteiro, 2003) for semi-definite programming, in which a positive semi-definite matrix is parameterized by square-root factors. In (Revay et al., 2023), it was further ex- 

4 

**Lipschitz-Bounded Deep Networks** 

**5** 

tended to recurrent (dynamic) equilibrium networks. (Pauli et al., 2022; 2023) applied this method to Lipschitz-bound 1D convolutional networks. However, those approaches do not scale to large DNNs. In this work, we explore the sparse structure of SDP condition for DNNs, leading to a scalable direct parameterization. A recent work (Araujo et al., 2023) also developed a scalable parameterization for training residual networks. But its Lipschitz condition only considers individual layer, which is often a relatively small SDP with dense structure. 

## **4.2. 1-Lipschitz neural networks** 

Many existing works have focused on the construction of provable 1-Lipschitz neural networks. Most are bottom-up approaches, i.e., devise 1-Lipschitz layers first and then connect them in a feedforward way. One approach is to build 1-Lipschitz linear layer _z_ = _Wx_ with _∥W ∥≤_ 1 since most existing activation layers are 1-Lipschitz (possibly after rescaling). The Lipschitz bound is quite loose due to the decoupling between linear layer and nonlinear activation. Another direction is to construct 1-Lipschitz layer which directly involves activation function. 

1 **-Lipschitz linear layers.** Early works (Miyato et al., 2018; Farnia et al., 2019) involve layer normalization via spectral norm: 

**==> picture [55 x 11] intentionally omitted <==**

with _V_ as free parameter. Some recent works construct gradient preserved linear layer by constraining _W_ to be orthogonal during training, e.g., block convolution orthogonal parameterization (Li et al., 2019), orthogonal matrix parameterization via Cayley transformation (Trockman & Kolter, 2021; Yu et al., 2022), matrix exponential (Singla & Feizi, 2021) 

**==> picture [83 x 13] intentionally omitted <==**

and inverse square root (Xu et al., 2022) 

**==> picture [75 x 13] intentionally omitted <==**

Almost Orthogonal Layer (AOL) (Prach & Lampert, 2022) can reduce the computational cost by using the inverse of a diagonal matrix, i.e., 

**==> picture [139 x 20] intentionally omitted <==**

Empirical study reveals that _W_ is almost orthogonal after training. For these approaches, the overall network Lipschitz bound is then obtained via a spectral norm bound: 

**==> picture [114 x 30] intentionally omitted <==**

Compared to 1-Lipschitz linear layers, our approach has two advantages. First, a special case of our sandwich layer (11) 

contains all 1-Lipschitz linear layers (see Proposition 3.3). Second, our model parameterization allows for the spectral norm bounds of individual layers to be greater than one, and their product to also be greater than one, while the network still satisfies a Lipschitz bound of 1, see the example in Figure 4 as well as the explanation in Appendix C. 

**1-Lipschitz nonlinear layers.** Since spectral-norm bounds can be quite loose, a number of recent papers have constructed Lipschitz-bounded nonlinear layers. In (Meunier et al., 2022), a new 1-Lipschitz residual-type layer _z_ = _x_ + _F_ ( _x_ ) with _F_ ( _x_ ) = _−_ 2 _/∥W ∥_[2] _Wσ_ ( _W[⊤] x_ + _b_ ), is derived from dynamical systems called convex potential flows. Recently, (Araujo et al., 2023) considered a more general layer: 

**==> picture [183 x 13] intentionally omitted <==**

and provides an extension to the SDP condition in (Fazlyab et al., 2019) as follows 

**==> picture [204 x 27] intentionally omitted <==**

For the special case with _γ_ = 1 and _H_ = _I_ , a direct parameterization of (13) is _G_ = _−_ 2 _WT[−]_[1] , where _W_ is a free variable and _T ∈_ D++ satisfies _T ⪰ W[⊤] W_ . The corresponding _hs_ ( _x_ ) is called SDP-based Lipschitz Layer (SLL). Similar to the SLL approach, our proposed sandwich layer (10) can also be understood as an analytical solution to (13) but with a different case with _H_ = 0 and arbitrary _γ_ . 

Moreover, Theorem 3.1 shows that by composing many 1- Lipschitz sandwich layers and then adding a scaling factor _√γ_ into the first and last layers, we can construct all the DNNs satisfying the (structured, network-scale) SDP in (Fazlyab et al., 2019) for any Lipschitz bound _γ_ . When an SLL layer with _γ >_ 1 is desired, similarly one can compose an 1-Lipschitz SLL layer with _γ_ , i.e. 

**==> picture [157 x 11] intentionally omitted <==**

with _p_ + _q_ = 1 and _p, q ≥_ 0. However, such a parameterization is incomplete as the example below gives a residual layer which satisfies (13), but cannot be constructed via (14). 

_Example_ 4.1 _._ Consider the following following residual layer, which has a Lipschitz bound of 1 _._ 001: 

**==> picture [183 x 25] intentionally omitted <==**

It can be verified that (13) is satisfied with _γ_ = 1 _._ 001 and Λ = diag( _λ_ 1 _, λ_ 2) chosen such that _λ_ 1 _>_ ( _γ−_ 1 _/_ 2) _/_ ( _γ_[2] _−γ_ ) and _λ_ 2 = _γ_[2] _− γ_ . However, it cannot be written as (14) because there does not exist a positive diagonal matrix _T_ such that _G_ = _−_ 2 _WT[−]_[1] , since the upper-left element is zero in _W_ and one in _G_ . 

5 

**Lipschitz-Bounded Deep Networks** 

**6** 

_Table 1._ The table presents the tightness of Lipschitz bound of several concurrent parameterization and our approach on a toy example. The bound tightness is measured by _γ/γ_ (%), where _γ_ and _γ_ are the empirical lower bound and certified upper bound. 

**==> picture [230 x 235] intentionally omitted <==**

**----- Start of picture text -----**<br>
LIP. TIGHTNESS ( γ )<br>MODELS 1 5 10<br>AOL 77.2 45.2 47.9<br>ORTHOGONAL 74.1 72.8 64.5<br>SLL 99.9 90.5 67.9<br>SANDWICH 99.9 99.3 94.0<br>1<br>0 . 5 true<br>AOL: slope 4.8<br>Orthogon: slope = 6.5<br>SLL: slope = 6.8<br>Ours: slope = 9.4<br>0 Best possible: slope = 10<br>− 0 . 3 − 0 . 2 − 0 . 1 0 0 . 1 0 . 2 0 . 3<br>x<br>)<br>x<br>(<br>f<br>**----- End of picture text -----**<br>


_Figure 3._ Fitting a square wave using models with Lipschitz bound of 10. Compared to AOL, orthogonal and SLL layers, our model is the closest to the best possible solution – a piecewise linear function with slope of 10 at _x_ = 0. 

## **5. Experiments** 

Our experiments have two goals: First, to illustrate that our model parameterization can provide a tight Lipschitz bounds via a simple curve-fitting tasks. Second, to examine the performance and scalability of the proposed method on robust image classification tasks. Model architectures and training details can be found in Appendix E. Pytorch code is available at https://github.com/acfr/LBDN, and a partial implementation of the method is included in the Julia toolbox RobustNeuralNetworks.jl, https:// acfr.github.io/RobustNeuralNetworks.jl 

## **5.1. Toy example** 

We illustrate the quality of Lipschitz bounds of by fitting the following square wave: 

**==> picture [148 x 31] intentionally omitted <==**

Note that the true function has no global Lipschitz bound due to the points of discontinuity. Thus a function approxi- 

mator will naturally try to find models with large local Lipschitz constant near the discontinuity. If a Lipschitz bound is imposed this is a useful test of its accuracy, which wee evaluate using _γ/γ_ where _γ_ is an empirical lower Lipschitz bound and _γ_ is the imposed upper bound, being 1, 5, and 10 in the cases we tested. In Table 1 we see that our approach achieves a much tighter Lipschitz bounds than AOL and orthogonal layers. The SLL model has similar tightness when _γ_ = 1 but its bound becomes more loose as _γ_ increases compared to our model, e.g. 67.9% v.s. 94.0% for _γ_ = 10. We also plot the fitting results for _γ_ = 10 in Figure 3. Our model is close to the best possible solution: a piecewise linear function with slope 10 at the discontinuities. 

In Figure 4 we break down the Lipschitz bounds and spectral norms over layers. Note that the SLL model is not included here as its Lipschitz bound is not related to the spectral norms. It can be seen that all individual layers have quite tight Lipschitz bounds on a per-layer basis of around 99%. However, for the complete network the sandwich layer achieves a much tighter bound of 99.9% vs 74.1% (orthogonal) and 77.2% (AOL). This illustrates the benefits of taking into account coupling between neighborhood layers, thus allowing individual layers to have spectral norm greater than 1. We note that, for the sandwich model, the layer-wise product of spectral norms reaches 65.9, illustrating how poor this commonly-used bound is compared to our bound. 

**==> picture [232 x 125] intentionally omitted <==**

**----- Start of picture text -----**<br>
Full network<br>Output layer<br>Hidden layer 8<br>Hidden layer 7<br>Hidden layer 6<br>Hidden layer 5<br>Hidden layer 4 Sandwich<br>Hidden layer 3<br>Orthogonal<br>Hidden layer 2<br>Hidden layer 1 AOL<br>Input layer<br>75 80 90 100 1 2 2 . 5<br>γ/γ (%) ∥W ∥<br>**----- End of picture text -----**<br>


_Figure 4._ **Left:** empirical Lipschitz bound for curve fitting of a square wave. The lower bound _γ_ is obtained using PGD-like method. We observed tight layer Lipschitz bound for AOL, orthogonal and sandwich layers ( _≥_ 99 _._ 1%). However, the propose sandwich layer has a much tighter Lipschitz bound for the entire network. **Right:** the spectral norm of weight matrices. Our approach admits weight matrices with spectral norm larger than 1. The layerwise product[�] _[L] k_ =0 _[∥][W][k][∥]_[is about 65.9, which is much] larger than that of AOL and orthogonal layers. 

## **5.2. Robust Image classification** 

We conducted a set of empirical robustness experiments on CIFAR-10/100 and Tiny-Imagenet datasets, comparing our Sandwich layer to the previous parameterizations AOL, 

6 

**Lipschitz-Bounded Deep Networks** 

**7** 

**==> picture [484 x 267] intentionally omitted <==**

**----- Start of picture text -----**<br>
ϵ  = 0 / 255 ϵ  = 36 / 255 ϵ  = 72 / 255 ϵ  = 108 / 255<br>80 80 80 80<br>60 CNN 60 60 60<br>AOL<br>40 40 40 40<br>Orthogonal<br>SLL<br>20 20 20 20<br>Sandwich<br>0 0 0 0<br>10 [0] 10 [1] 10 [2] 10 [0] 10 [1] 10 [2] 10 [0] 10 [1] 10 [2] 10 [0] 10 [1] 10 [2]<br>60 60 60 60<br>40 40 40 40<br>20 20 20 20<br>0 0 0 0<br>2 [0] 2 [1] 2 [2] 2 [16] 2 [0] 2 [1] 2 [2] 2 [16] 2 [0] 2 [1] 2 [2] 2 [16] 2 [0] 2 [1] 2 [2] 2 [16]<br>Lipschitz Lipschitz Lipschitz Lipschitz<br>Test accuracy (CIFAR-10)<br>Test accuracy (CIFAR-100)<br>**----- End of picture text -----**<br>


_Figure 5._ Robust test accuracy under different _ℓ_[2] -adversarial attack sizes _versus_ empirical Lipschitz bound on CIFAR-10. Colours: blue ( _γ_ = 1), teal ( _γ_ = 10), magenta ( _γ_ = 100), red (vanilla CNN). Vertical lines are the certified Lipschitz bounds. The empirical robustness is measured with _AutoAttack_ (Croce & Hein, 2020). For CIFAR-10, the SLL layer slightly outperforms the proposed sandwich layer but its model is much larger (41M versus 3M). But CIFAR-100, our model has about 4% improvement dispite its relatively small model size compared to the SLL model (i.e. 48M versus 118M). 

orthogonal and SLL layers. We use the same architecture in (Trockman & Kolter, 2021) for AOL, orthogonal and sandwich models with _small, medium_ and _large_ sizes. Since SLL is a residual layer, we use the architectures proposed by (Araujo et al., 2023), with model sizes much larger than those of the non-residual networks. Input data is normalized before feeding into Lipschitz bounded model. The Lipschitz bound for the composited model is fixed during the training. We use _AutoAttack_ (Croce & Hein, 2020) to measure the empirical robustness. 

We also compare the certified robustness results of the proposed parameterization with the recently proposed SLL model (Araujo et al., 2023). We removed the data normalization layer and add a Last Layer Normalization (LLN), proposed by (Singla et al., 2022). While the Lipschitz constant of the composite model may exceed the bound, it has been observed in (Singla et al., 2022; Araujo et al., 2023) that LLN can improved the certified accuracy when the number of classes becomes large. 

**Effect of Lipschitz bounds.** We trained Lipschitzbounded models on CIFAR-10/100 datasets with three different certified bounds ( _γ_ = 1 _,_ 10 _,_ 100 for CIFAR-10 and 

_γ_ = 1 _,_ 2 _,_ 4 for CIFAR-100). We also trained a vanilla CNN model without any Lipschitz regularization as a baseline. In Figure 5 we plot both the clean accuracy ( _ϵ_ = 0) and robust test accuracy under different _ℓ_[2] -adversarial attack sizes ( _ϵ_ = 36 _/_ 255 _,_ 72 _/_ 255 _,_ 108 _/_ 255). The sandwich layer had higher test accuracy than the AOL and orthogonal layer in all cases, illustrating the improved flexibility. On CIFAR-10 our model is slightly outperformed by the the SLL model, although the model size of the latter is much larger (3M vs 41M parameters). On CIFAR-100, our model outperforms SLL by about 4% despite a much smaller model size (48M vs 118M). 

It can be seen that with an appropriate Lipschitz bound, all models except AOL had improved nominal test accuracy (i.e. _ϵ_ = 0) compared to a vanilla CNN. This performance deteriorates if the Lipschitz bound is chosen to be too small. On the other hand, when the perturbation size is large (e.g. _ϵ_ = 72 _/_ 255 or 108 _/_ 255), the smallest Lipschitz bounds yielded the best performance (except for the AOL). Furthermore, with these larger attack sizes, the performance improvement compared to vanilla CNN is very significant, e.g. close to 60% on CIFAR10 with _ϵ_ = 72 _/_ 255. 

7 

**Lipschitz-Bounded Deep Networks** 

**8** 

_Table 2._ This table presents the clean, empirical robust accuracy as well as the number of parameters and training time of several concurrent work and our sandwich model on CIFAR-100 and Tiny-ImageNet datasets. Input data is normalized and no last layer normalization is implemented. The Lipschitz bounds for CIFAR-100 and Tiny-ImageNet are 2 and 1, respectively. The empirical robustness is measured with _AutoAttack_ (Croce & Hein, 2020). All results are averaged of 3 experiments. 

|**DATASETS**|**MODELS**<br>**CLEAN**<br>**ACC.**|**AUTOATTACK (****_ε_)**<br>**NUMBER OF**<br>**PARAMETERS**<br>**TIME BY**<br>**EPOCH**<br>36<br>255<br>72<br>255<br>108<br>255|
|---|---|---|
|CIFAR100|**AOL SMALL**<br>30.4<br>**AOL MEDIUM**<br>31.1<br>**AOL LARGE**<br>31.6<br>**ORTHOGONAL SMALL**<br>48.7<br>**ORTHOGONAL MEDIUM**<br>51.1<br>**ORTHOGONAL LARGE**<br>52.2<br>**SLL SMALL**<br>52.9<br>**SLL MEDIUM**<br>53.8<br>**SLL LARGE**<br>54.8|25.1<br>21.1<br>17.6<br>3M<br>18S<br>25.9<br>21.7<br>18.2<br>12M<br>21S<br>26.5<br>22.2<br>18.7<br>48M<br>73S<br>38.6<br>30.6<br>24.0<br>3M<br>20S<br>41.4<br>33.0<br>26.4<br>12M<br>22S<br>42.5<br>34.3<br>27.4<br>48M<br>55S<br>41.9<br>32.9<br>25.5<br>41M<br>29S<br>43.1<br>33.9<br>26.6<br>78M<br>52S<br>44.0<br>34.9<br>27.6<br>118M<br>121S|
||**SANDWICH SMALL**<br>54.2<br>**SANDWICH MEDIUM**<br>56.5<br>**SANDWICH LARGE**<br>**57.5**|44.3<br>35.5<br>28.4<br>3M<br>19S<br>47.1<br>38.6<br>31.5<br>12M<br>23S<br>**48.5**<br>**40.2**<br>**32.9**<br>48M<br>78S|
|TINYIMAGENET|**AOL SMALL**<br>17.4<br>**AOL MEDIUM**<br>16.8<br>**ORTHOGONAL SMALL**<br>29.7<br>**ORTHOGONAL MEDIUM**<br>30.9<br>**SLL SMALL**<br>29.3<br>**SLL MEDIUM**<br>30.3|15.1<br>13.1<br>11.3<br>11M<br>62S<br>14.6<br>12.7<br>11.0<br>43M<br>270S<br>24.4<br>20.1<br>16.4<br>11M<br>57S<br>26.0<br>21.5<br>17.7<br>43M<br>89S<br>23.5<br>18.6<br>14.7<br>165M<br>203S<br>24.6<br>19.8<br>15.7<br>314M<br>363S|
||**SANDWICH SMALL**<br>34.7<br>**SANDWICH MEDIUM**<br>**35.0**|29.3<br>24.6<br>20.5<br>10M<br>60S<br>**29.9**<br>**25.3**<br>**21.4**<br>37M<br>139S|



In Figure 6 we plot the training curves (test-error vs epoch) for the Lipschitz-bounded and vanilla CNN models. We observe that the sandwich model surpasses the final error of CNN in less than half as many epochs. An interesting observation from Figure 6 is that the CNN model seems to exhibit the epoch-wide double descent phenomenon (see, e.g., (Nakkiran et al., 2021a)), whereas none of the Lipschitz bounded models do, they simply improve test error monotonically with epochs. Weight regularization has been suggested as a mitigating factor for other forms of double descent (Nakkiran et al., 2021b), however we are not aware of this specific phenomenon having been observed before. 

superior results with much smaller models and faster training than SLL. On CIFAR-100, comparing our Sandwichmedium vs SLL-large we see that ours gives superior clean and robust accuracy despite having only 12M parameters vs 118M, and taking only 23s vs 121s TpE. Similarly on TinyImagenet: comparing our Sandwich-small vs SLL-medium, ours has much better clean and robust accuracy, despite having 10M parameters vs 314M, and taking 60s vs 363s TpE. 

## **Certified robustness on CIFAR-100 and Tiny-Imagenet.** 

**Empirical robustness on CIFAR-100 and Tiny-Imagenet.** 

We ran empirical robustness tests on larger datasets (CIFAR100 and Tiny-Imagenet). We trained models with Lipschitz bounds of _{_ 0 _._ 5 _,_ 1 _, . . . ,_ 16 _}_ and presented the one with best robust accuracy for _ϵ_ = 36 _/_ 255. The results along with total number of parameters (NP) and training time per epoch (TpE) are collected in Table 2. We also plot the test accuracy versus model size in Figure 7. 

We observe that our proposed Sandwich layer achieves uniformly the best results (around 5% improvement) on both CIFAR-100 and Tiny-Imagenet for all model sizes, in terms of both clean accuracy and robust accuracy with all perturbation sizes. Furthermore, our Sandwich model can achieve 

We also compare the certified robustness to the SLL approach which outperforms most existing 1-Lipschitz networks (Araujo et al., 2023). From Table 3 we can see that on CIFAR-100, our Sandwich model performs similarly to somewhat larger SLL models (41M parameters vs 26M, i.e. 60% larger). However it is outperformed by much larger SLL models (236M parameters, 9 times larger than ours). 

On Tiny-Imagenet, however, we see that our model uniformly outperforms SLL models, even the extra large SLL model with 1.1B parameters (28 times larger than ours). Furthermore, our advantage over the four-times larger “Small” SLL model is substantial, e.g. 24.7% vs 19.5% certified accuracy for _ϵ_ = 36 _/_ 255. 

8 

**Lipschitz-Bounded Deep Networks** 

**9** 

_Table 3._ Certified robustness of SLL and sandwich model on CIFAR-100 and Tiny-ImageNet datasets. Different from the previous experiment setup on empirical robustness, here we remove the input data normalization and add the last layer normalization. Results of the SLL models are from (Araujo et al., 2023). Results of the sandwich model are averaged of 3 experiments. 

|**DATASETS**<br>**MODELS**<br>**CLEAN**<br>**ACC.**<br>CIFAR100<br>**SLL SMALL**<br>44.9<br>**SLL XLARGE**<br>**46.5**<br>**SANDWICH**<br>46.3<br>TINYIMAGENET<br>**SLL SMALL**<br>26.6<br>**SLL X-LARGE**<br>32.1<br>**SANDWICH**<br>**33.4**<br>0<br>20<br>40<br>60<br>80<br>100<br>20<br>40<br>60<br>Test error (CIFAR-10)<br>CNN<br>AOL<br>Orthogonal<br>SLL<br>Sandwich<br>0<br>20<br>40<br>60<br>80<br>100<br>40<br>60<br>80<br>Epochs<br>Test error (CIFAR-100)|**DATASETS**<br>**MODELS**<br>**CLEAN**<br>**ACC.**<br>CIFAR100<br>**SLL SMALL**<br>44.9<br>**SLL XLARGE**<br>**46.5**<br>**SANDWICH**<br>46.3<br>TINYIMAGENET<br>**SLL SMALL**<br>26.6<br>**SLL X-LARGE**<br>32.1<br>**SANDWICH**<br>**33.4**<br>0<br>20<br>40<br>60<br>80<br>100<br>20<br>40<br>60<br>Test error (CIFAR-10)<br>CNN<br>AOL<br>Orthogonal<br>SLL<br>Sandwich<br>0<br>20<br>40<br>60<br>80<br>100<br>40<br>60<br>80<br>Epochs<br>Test error (CIFAR-100)|**DATASETS**<br>**MODELS**<br>**CLEAN**<br>**ACC.**<br>CIFAR100<br>**SLL SMALL**<br>44.9<br>**SLL XLARGE**<br>**46.5**<br>**SANDWICH**<br>46.3<br>TINYIMAGENET<br>**SLL SMALL**<br>26.6<br>**SLL X-LARGE**<br>32.1<br>**SANDWICH**<br>**33.4**<br>0<br>20<br>40<br>60<br>80<br>100<br>20<br>40<br>60<br>Test error (CIFAR-10)<br>CNN<br>AOL<br>Orthogonal<br>SLL<br>Sandwich<br>0<br>20<br>40<br>60<br>80<br>100<br>40<br>60<br>80<br>Epochs<br>Test error (CIFAR-100)|
|---|---|---|
|||36<br>255|
|||34.7<br>**36.5**<br>35.3|
|||19.5<br>23.0<br>**24.7**|
||80<br>100<br>CNN<br>AOL<br>Orthogonal<br>SLL<br>Sandwich<br>80<br>100||



**==> picture [225 x 245] intentionally omitted <==**

**----- Start of picture text -----**<br>
60<br>50<br>40 AOL<br>Orthogonal<br>30 SLL<br>Sandwich<br>20<br>0 20 40 60 80 100 120<br>40<br>30<br>20<br>10<br>0 50 100 150 200 250 300 350<br>Number of parameters (M)<br>Accuracy (CIFAR-100)<br>Accuracy (Tiny-imagenet)<br>**----- End of picture text -----**<br>


_Figure 6._ Learning curves (obtained from 5 experiments). We use _γ_ = 100 and 10 for CIFAR-10/100, respectively. The “doubledescent” phenomenon is avoided with the _γ_ -Lipschitz models. 

_Figure 7._ Test accuracy _versus_ model size on CIFAR-100 and TinyImagenet. Colours: blue (small), teal (medium), magenta (large). For CIFAR-100, our small sandwich model (3M) has the similar performance as the large SLL model (118M). For Tiny-Imagenet, our small sandwich model (10M) has about 4.5% improvement in test accuracy compared to the medium SLL model (314M). 

## **6. Conclusions** 

In this paper we have introduced a direct parameterization of neural networks that automatically satisfy the SDPbased Lipschitz bounds of (Fazlyab et al., 2019). It is a _complete_ parameterization, i.e. it can represent all such neural networks. Direct parameterization enables learning of Lipschitz-bounded networks with standard first-order gradient methods, avoiding the need for complex projections or barrier evaluations. The new parameterization can also be interpreted as a new layer type, the _sandwich layer_ . Experiments in robust image classification with both fully-connected and convolutional networks showed that our method outperforms existing models in terms of both empirical and certified accuracy. 

## **Acknowledgements** 

This work was partially supported by the Australian Research Council and the NSW Defence Innovation Network. 

## **References** 

- Araujo, A., Havens, A., Delattre, B., Allauzen, A., and Hu, B. A unified algebraic perspective on lipschitz neural networks. In _International Conference on Learning Representations_ , 2023. 

9 

**Lipschitz-Bounded Deep Networks** 

**10** 

- Arjovsky, M., Chintala, S., and Bottou, L. Wasserstein generative adversarial networks. In _International conference on machine learning_ , pp. 214–223. PMLR, 2017. 

- Bartlett, P. L., Foster, D. J., and Telgarsky, M. J. Spectrallynormalized margin bounds for neural networks. In _Advances in Neural Information Processing Systems_ , pp. 6240–6249, 2017. 

- Bethune, L., Massena, T., Boissin, T., Prudent, Y., Friedrich, C., Mamalet, F., Bellet, A., Serrurier, M., and Vigouroux, D. Dp-sgd without clipping: The lipschitz neural network way. _arXiv preprint arXiv:2305.16202_ , 2023. 

- Brunke, L., Greeff, M., Hall, A. W., Yuan, Z., Zhou, S., Panerati, J., and Schoellig, A. P. Safe learning in robotics: From learning-based control to safe reinforcement learning. _Annual Review of Control, Robotics, and Autonomous Systems_ , 5:411–444, 2022. 

- Bubeck, S. and Sellke, M. A universal law of robustness via isoperimetry. _Journal of the ACM_ , 70(2):1–18, 2023. 

- Burer, S. and Monteiro, R. D. A nonlinear programming algorithm for solving semidefinite programs via low-rank factorization. _Mathematical Programming_ , 95(2):329– 357, 2003. 

- Chu, Y.-C. and Glover, K. Bounds of the induced norm and model reduction errors for systems with repeated scalar nonlinearities. _IEEE Transactions on Automatic Control_ , 44(3):471–483, 1999. 

- Coleman, C., Narayanan, D., Kang, D., Zhao, T., Zhang, J., Nardi, L., Bailis, P., Olukotun, K., Re, C., and Zaharia,´ M. Dawnbench: An end-to-end deep learning benchmark and competition. _Training_ , 100(101):102, 2017. 

- Croce, F. and Hein, M. Reliable evaluation of adversarial robustness with an ensemble of diverse parameter-free attacks. In _International conference on machine learning_ , pp. 2206–2216. PMLR, 2020. 

- D’Amato, F. J., Rotea, M. A., Megretski, A., and Jonsson,¨ U. New results for analysis of systems with repeated nonlinearities. _Automatica_ , 37(5):739–747, 2001. 

- Dawson, C., Gao, S., and Fan, C. Safe control with learned certificates: A survey of neural lyapunov, barrier, and contraction methods for robotics and control. _IEEE Transactions on Robotics_ , 2023. 

- Farnia, F., Zhang, J., and Tse, D. Generalizable adversarial training via spectral normalization. In _International Conference on Learning Representations_ , 2019. 

- Fazlyab, M., Robey, A., Hassani, H., Morari, M., and Pappas, G. Efficient and accurate estimation of lipschitz 

- constants for deep neural networks. In _Advances in Neural Information Processing Systems_ , pp. 11427–11438, 2019. 

- Goodfellow, I., Bengio, Y., and Courville, A. _Deep learning_ . MIT press, 2016. 

- Gouk, H., Frank, E., Pfahringer, B., and Cree, M. J. Regularisation of neural networks by enforcing lipschitz continuity. _Machine Learning_ , 110:393–416, 2021. 

- Gulrajani, I., Ahmed, F., Arjovsky, M., Dumoulin, V., and Courville, A. C. Improved training of wasserstein gans. _Advances in neural information processing systems_ , 30, 2017. 

- Jain, A. K. _Fundamentals of digital image processing_ . Prentice-Hall, Inc., 1989. 

- Kingma, D. P. and Ba, J. Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ , 2014. 

- Kulkarni, V. V. and Safonov, M. G. All multipliers for repeated monotone nonlinearities. _IEEE Transactions on Automatic Control_ , 47(7):1209–1212, 2002. 

- Li, Q., Haque, S., Anil, C., Lucas, J., Grosse, R. B., and Jacobsen, J.-H. Preventing gradient attenuation in lipschitz constrained convolutional networks. _Advances in neural information processing systems_ , 32, 2019. 

- Liu, H.-T. D., Williams, F., Jacobson, A., Fidler, S., and Litany, O. Learning smooth neural functions via lipschitz regularization. In _ACM SIGGRAPH 2022 Conference Proceedings_ , pp. 1–13, 2022. 

- Madry, A., Makelov, A., Schmidt, L., Tsipras, D., and Vladu, A. Towards deep learning models resistant to adversarial attacks. In _International Conference on Learning Representations_ , 2018. 

- Megretski, A. and Rantzer, A. System analysis via integral quadratic constraints. _IEEE Transactions on Automatic Control_ , 42(6):819–830, 1997. 

- Meunier, L., Delattre, B. J., Araujo, A., and Allauzen, A. A dynamical system perspective for lipschitz neural networks. In _International Conference on Machine Learning_ , pp. 15484–15500. PMLR, 2022. 

- Miyato, T., Kataoka, T., Koyama, M., and Yoshida, Y. Spectral normalization for generative adversarial networks. In _International Conference on Learning Representations_ , 2018. 

- Nakkiran, P., Kaplun, G., Bansal, Y., Yang, T., Barak, B., and Sutskever, I. Deep double descent: Where bigger models and more data hurt. _Journal of Statistical Mechanics: Theory and Experiment_ , 2021(12):124003, 2021a. 

10 

**Lipschitz-Bounded Deep Networks** 

**11** 

- Nakkiran, P., Venkat, P., Kakade, S. M., and Ma, T. Optimal regularization can mitigate double descent. In _International Conference on Learning Representations_ , 2021b. 

- Pauli, P., Koch, A., Berberich, J., Kohler, P., and Allgower,¨ F. Training robust neural networks using lipschitz bounds. _IEEE Control Systems Letters_ , 6:121–126, 2021. 

- Pauli, P., Gramlich, D., and Allgower, F.¨ Lipschitz constant estimation for 1d convolutional neural networks. _arXiv preprint arXiv:2211.15253_ , 2022. 

- Pauli, P., Wang, R., Manchester, I. R., and Allgower,¨ F. Lipschitz-bounded 1d convolutional neural networks using the cayley transform and the controllability gramian. _arXiv preprint arXiv:2303.11835_ , 2023. 

- Prach, B. and Lampert, C. H. Almost-orthogonal layers for efficient general-purpose lipschitz networks. In _Computer Vision–ECCV 2022: 17th European Conference, Tel Aviv, Israel, October 23–27, 2022, Proceedings, Part XXI_ , pp. 350–365. Springer, 2022. 

- Revay, M., Wang, R., and Manchester, I. R. A convex parameterization of robust recurrent neural networks. _IEEE Control Systems Letters_ , 5(4):1363–1368, 2020a. 

- Revay, M., Wang, R., and Manchester, I. R. Lipschitz bounded equilibrium networks. _arXiv:2010.01732_ , 2020b. 

- Revay, M., Wang, R., and Manchester, I. R. Recurrent equilibrium networks: Flexible dynamic models with guaranteed stability and robustness. _IEEE Transactions on Automatic Control (accepted). preprint: arXiv:2104.05942_ , 2023. 

- Rosca, M., Weber, T., Gretton, A., and Mohamed, S. A case for new neural network smoothness constraints. In _NeurIPS Workshops on ”I Can’t Believe It’s Not Better!”_ , pp. 21–32. PMLR, 2020. 

   - Trockman, A. and Kolter, J. Z. Orthogonalizing convolutional layers with the cayley transform. In _International Conference on Learning Representations_ , 2021. 

   - Tsuzuku, Y., Sato, I., and Sugiyama, M. Lipschitz-margin training: Scalable certification of perturbation invariance for deep neural networks. In _Advances in neural information processing systems_ , pp. 6541–6550, 2018. 

   - Virmaux, A. and Scaman, K. Lipschitz regularity of deep neural networks: analysis and efficient estimation. _Advances in Neural Information Processing Systems_ , 31, 2018. 

   - Wang, R. and Manchester, I. R. Youla-ren: Learning nonlinear feedback policies with robust stability guarantees. In _2022 American Control Conference (ACC)_ , pp. 2116– 2123, 2022. 

   - Winston, E. and Kolter, J. Z. Monotone operator equilibrium networks. _Advances in neural information processing systems_ , 33:10718–10728, 2020. 

   - Xu, X., Li, L., and Li, B. Lot: Layer-wise orthogonal training on improving l2 certified robustness. In _Advances in Neural Information Processing Systems_ , 2022. 

   - Xue, A., Lindemann, L., Robey, A., Hassani, H., Pappas, G. J., and Alur, R. Chordal sparsity for lipschitz constant estimation of deep neural networks. In _2022 IEEE 61st Conference on Decision and Control (CDC)_ , pp. 3389– 3396. IEEE, 2022. 

   - Yu, T., Li, J., Cai, Y., and Li, P. Constructing orthogonal convolutions in an explicit manner. In _International Conference on Learning Representations_ , 2022. 

   - Zheng, Y., Fantuzzi, G., and Papachristodoulou, A. Chordal and factor-width decompositions for scalable semidefinite and polynomial optimization. _Annual Reviews in Control_ , 52:243–279, 2021. 

- Russo, A. and Proutiere, A. Towards optimal attacks on reinforcement learning policies. In _2021 American Control Conference (ACC)_ , pp. 4561–4567. IEEE, 2021. 

- Singla, S. and Feizi, S. Skew orthogonal convolutions. In _International Conference on Machine Learning_ , pp. 9756– 9766. PMLR, 2021. 

- Singla, S., Singla, S., and Feizi, S. Improved deterministic l2 robustness on cifar-10 and cifar-100. In _International Conference on Learning Representations_ , 2022. 

- Szegedy, C., Zaremba, W., Sutskever, I., Bruna, J., Erhan, D., Goodfellow, I., and Fergus, R. Intriguing properties of neural networks. In _International Conference on Learning Representations_ , 2014. 

11 

**Lipschitz-Bounded Deep Networks** 

**12** 

## **A. Preliminaries on SDP-based Lipschitz bound** 

We review the theoretical work of SDP-based Lipschitz bound estimation for neural networks from (Fazlyab et al., 2019; Revay et al., 2020b). Consider an _L_ -layer feed-forward network _y_ = _f_ ( _x_ ) described by the following recursive equation: 

**==> picture [335 x 37] intentionally omitted <==**

where _x ∈_ R _[n]_[0] _, zk ∈_ R _[n][k] , y ∈_ R _[n][L]_[+1] are the network input, hidden unit of the _k_ th layer and network output, respectively. We stack all hidden unit _z_ 1 _, . . . , zL_ together and obtain a compact form of (15) as follows: 

**==> picture [386 x 149] intentionally omitted <==**

By letting _z_ := col( _z_ 1 _, . . . , zL_ ) and _v_ := _Wz_ + _Ux_ + _bz_ , we can rewrite the above equation by 

**==> picture [346 x 12] intentionally omitted <==**

Now we introduce the incremental quadratic constraint (iQC) (Megretski & Rantzer, 1997) for analyzing the activation layer. **Lemma A.1.** _If Assumption 2.1 holds, then for any_ Λ _∈_ D _[n]_ ++ _[the following iQC holds for any pair of]_[ (] _[v][a][, z][a]_[)] _[ and]_[ (] _[v][b][, z][b]_[)] _satisfying z_ = _σ_ ( _v_ ) _:_ 

**==> picture [310 x 27] intentionally omitted <==**

_where_ ∆ _v_ = _v[b] − v[a] and_ ∆ _z_ = _z[b] − z[a] ._ 

_Remark_ A.2 _._ Assumption 2.1 implies that each channel satisfies 2∆ _zi_ (∆ _vi −_ ∆ _zi_ ) _≥_ 0, which can be leads to (18) by a linear conic combination of each channel with multiplier Λ _∈_ D _[n]_ ++[.][In (][Fazlyab et al.][,][ 2019][) it was claimed that] iQC (18) holds with a richer (more powerful) class of multipliers (i.e. Λ is a symmetric matrix), which were previously introduced for robust stability analysis of systems with repeated nonlinearities (Chu & Glover, 1999; D’Amato et al., 2001; Kulkarni & Safonov, 2002). However this is not true: a counterexample was given in (Pauli et al., 2021). Here we give a brief explanation: even if the nonlinearities _σ_ ( _vi_ ) are repeated when considered as functions of _vi_ , their increments ∆ _zi_ = _σ_ ( _vi[a]_[+ ∆] _[v][i]_[)] _[ −][σ]_[(] _[v] i[a]_[)][ are not repeated when considered as functions of][ ∆] _[v][i]_[, since] _[ δz][i]_[depend on the particular] _[ v] i[a]_ which generally differs between units. 

**Theorem A.3.** _The feed-forward neural network_ (15) _is γ-Lipschitz if Assumption 2.1 holds, and there exist an_ Λ _∈_ D _[n]_ ++ _satisfying the following LMI:_ 

**==> picture [346 x 37] intentionally omitted <==**

_Remark_ A.4 _._ In (Revay et al., 2020b), the above LMI condition also applies to more general network structures with full weight matrix _W_ . An equivalent form of (19) was applied in (Fazlyab et al., 2019) for a tight Lipschitz bound estimation: 

**==> picture [283 x 15] intentionally omitted <==**

which can be solved by convex programming for moderate models, e.g., _n <_ 10K in (Fazlyab et al., 2019). 

12 

**Lipschitz-Bounded Deep Networks** 

**13** 

## **B. 1-Lipschitz convolutional layer** 

Our proposed layer parameterization can also incorporate more structured linear operators such as convolution. Let _h_ in _∈_ R _[p][×][s][×][s]_ be a _p_ -channel image tensor with _s × s_ spatial domain and _h_ out _∈_ R _[q][×][s][×][s]_ be _q_ -channel output tensor. We also let _A ∈_ R _[q][×][q][×][s][×][s]_ denote a multi-channel convolution operator and similarly for _B ∈_ R _[q][×][p][×][s][×][s]_ . For the sake of simplicity, we assume that the convolutional operators _A, B_ are circular and unstrided. Such assumption can be easily related to plain and/or 2-strided convolutions, see (Trockman & Kolter, 2021). Similar to (10), the proposed convolutional layer can be rewritten as 

**==> picture [347 x 13] intentionally omitted <==**

where _CA ∈_ R _[qs]_[2] _[×][qs]_[2] _, CB ∈_ R _[qs]_[2] _[×][ps]_[2] are the doubly-circular matrix representations of _A_ and _B_ , respectively. For instance, Vec( _B ∗ h_ in) = _CB_ Vec( _h_ in) where _∗_ is the convolution operator. We choose Ψ _s_ = Ψ _⊗ Is_ with Ψ = diag( _e[d]_ ) so that individual channel has a constant scaling factor. To ensure that (21) is 1-Lipschitz, we need to construct _CA, CB_ using the Cayley transformation (6), which involves inverting a highly-structured large matrix _I_ + _CZ ∈_ R _[qs]_[2] _[×][qs]_[2] . 

Thanks to the doubly-circular structure, we can perform efficient computation on the Fourier domain. Taking a 2D case for example, circular convolution of two matrices is simply the elementwise product of their representations in the Fourier domain (Jain, 1989). In (Trockman & Kolter, 2021), the 2D convolution theorem was extended to multi-channel circular convolutions of tensors, which are reduced to a batch of complex matrix-vector products in the Fourier domain rather than elementwise products. For example, the Fourier-domain output related to the ( _i, j_ )[th] pixel is a matrix-vector product: 

**==> picture [175 x 12] intentionally omitted <==**

where _B_[˜] [: _,_ : _, i, j_ ] _∈_ C _[q][×][p]_ and _h_[˜] in[: _, i, j_ ] _∈_ C _[p]_ . Here C denotes the set of complex numbers and _x_ ˜ = FFT( _x_ ) is the fast Fourier transformation (FFT) of a multi-channel tensor _x ∈_ R _[c]_[1] _[×···×][c][r][×][s][×][s]_ : 

**==> picture [191 x 11] intentionally omitted <==**

where _Fs_ [ _i, j_ ] =[1] _s[e][−]_[2] _[π]_[(] _[i][−]_[1)(] _[j][−]_[1)] _[ι/s]_[with] _[ ι]_[=] _[√] −_ 1. Moreover, transposing or inverting a convolution is equivalent to applying the complex version of the same operation to its Fourier domain representation – a batch of small complex matrices: 

**==> picture [339 x 12] intentionally omitted <==**

Since the FFT of a real tensor is Hermitian-symmetric, the batch size can be reduced to _s ×_ ( _⌊s/_ 2 _⌋_ + 1). 

## **C. Weighted Spectral Norm Bounds** 

The generalized Clake Jacobian operator of feedforward network _fϕ_ in (2) has the following form 

**==> picture [168 x 30] intentionally omitted <==**

**==> picture [488 x 32] intentionally omitted <==**

To learn an 1-Lipschitz DNN, one can impose the constraints _∥Wk∥≤_ 1 for _k_ = 0 _, . . . , L_ , i.e., _fϕ_ satisfies the following spectral norm bound 

**==> picture [297 x 30] intentionally omitted <==**

However, such bound is often quite loose, see an example in Figure 4. 

For our proposed model parameterization, we can also estimate the Lipschitz bound via the production of layerwise Lipschitz bounds, i.e., 

**==> picture [344 x 30] intentionally omitted <==**

where _s_ is the 1-Lipschitz sandwich layer function defined in (10) and _∥BL∥≤_ 1 by construction. In the following proposition, we show that the layerwise bound in (24) is equivalent to weight spectral norm bounds on the weights _Wk_ . 

13 

**Lipschitz-Bounded Deep Networks** 

**14** 

**Proposition C.1.** _The feedforward network_ (2) _with weights_ (8) _satisfies the weighted spectral norm bounds as follows:_ 

**==> picture [355 x 55] intentionally omitted <==**

_Moreover, the network is γ-Lipschitz since_ 

**==> picture [445 x 30] intentionally omitted <==**

_Remark_ C.2 _._ For 1-Lipschitz DNNs, our model parameterization allows for the spectral norm bounds of both individual layer and the whole network to be larger than 1, while the network Lipschitz constant is still bounded by a weighted layerwise spectral bound of 1, see the example in Figure 4. 

## **D. Proofs** 

## **D.1. Proof of Lemma A.1** 

Given any pair of ( _v[a] , z[a]_ ) and ( _v[b] , z[b]_ ) satisfying _z_ = _σ_ ( _v_ ), we have ∆ _z_ = _σ_ ( _v[b]_ ) _− σ_ ( _v[a]_ ) := _J[ab]_ ∆ _v_ with ∆ _z_ = _z[b] − z[a]_ and ∆ _v_ = _v[b] − v[a]_ , where _J[ab] ∈_ J _[q]_ +[with][ J] _[q]_ +[defined in (][22][).][Therefore, we can have] 

**==> picture [339 x 28] intentionally omitted <==**

## **D.2. Proof of Theorem A.3** 

We first apply Schur complement to (19), which yields 

**==> picture [185 x 27] intentionally omitted <==**

Then, by left-multiplying the above equation by �∆ _x[⊤]_ ∆ _z[⊤]_[�] and right-multiplying �∆ _x[⊤]_ ∆ _z[⊤]_[�] _[⊤]_ we can obtain _γ∥_ ∆ _x∥_[2] _− γ_[1] _[∥]_[∆] _[y][∥]_[2] _[ −]_[2∆] _[z][⊤]_[Λ∆] _[z][ −]_[2∆] _[z][⊤]_[Λ(] _[W]_[∆] _[z]_[ +] _[ U]_[∆] _[x]_[) =] _[ γ][∥]_[∆] _[x][∥]_[2] _[ −] γ_[1] _[∥]_[∆] _[y][∥]_[2] _[ −]_[2∆] _[z][⊤]_[Λ(∆] _[z][ −]_[∆] _[v]_[)] _[ ≥]_[0] _[,]_[(27)] 

which further implies that (15) is _γ_ -Lipschitz since 

**==> picture [193 x 24] intentionally omitted <==**

where the last inequality follows by Lemma A.1. 

## **D.3. Proof of Theorem 3.1** 

**Sufficient.** We show that (19) holds with Λ = diag(Λ0 _, . . . ,_ Λ _L−_ 1) where Λ _k_ = Ψ[2] _k_[.][Since the block structure of] _[ H]_[is a] chordal graph, _H ⪰_ 0 is equivalent to the existence of a chordal decomposition (Zheng et al., 2021): 

**==> picture [284 x 30] intentionally omitted <==**

where 0 _⪯ Hk ∈_ R[(] _[n][k]_[+] _[n][k]_[+1][)] _[×]_[(] _[n][k]_[+] _[n][k]_[+1][)] and _Ek_ = � **0** _a,k_ **I** _b,k_ **0** _c,k_ � with **I** _b,k_ being the identity matrix the same size as _Hk_ , and **0** _a,k,_ **0** _c,k_ being zero matrices of appropriate dimension. We then construct _Hk_ as follows. 

14 

**Lipschitz-Bounded Deep Networks** 

**15** 

For _k_ = 0, we take 

**==> picture [336 x 25] intentionally omitted <==**

Note that _H_ 0 _⪰_ 0 since [ _H_ 0]11 = _γI ≻_ 0, and the Schur complement to [ _H_ 0]11 yields 

**==> picture [353 x 24] intentionally omitted <==**

For _k_ = 1 _, . . . , L −_ 1 we take 

**==> picture [361 x 26] intentionally omitted <==**

If _Ak−_ 1 is zero, then it is trival to have _Hk ⪰_ 0. For nonzero _Ak−_ 1, we can verify that _Hk ⪰_ 0 since the Schur complement to [ _Hk_ ]11 shows 

**==> picture [430 x 110] intentionally omitted <==**

where _X_[+] denotes the Moore–Penrose inverse of the matrix _X_ , and it satisfies _I − X_[+] _X ⪰_ 0. 

For _k_ = _L_ we take 

Similarly, we can conclude _HL ⪰_ 0 using Schur complement 

+ _γI−_ ~~�~~ 2 _γ_ Ψ _L−_ 1 _BLA[⊤] L−_ 1 �2Ψ _L−_ 1 _AL−_ 1 _A[⊤] L−_ 1[Ψ] _[L][−]_[1] � ~~�~~ 2 _γAL−_ 1 _BL[⊤]_[Ψ] _[L][−]_[1][=] _[ γ]_[Ψ] _[L][−]_[1] _[B][L]_[(] _[I][−][A]_[+] _L−_ 1 _[A][L][−]_[1][)] _[B] L[⊤]_[Ψ] _[L][−]_[1] _[⪰]_[0] _[.]_ We now show that _Hk_ with _k_ = 0 _, . . . L_ satisfy the chordal decomposition (28) holds since 

**==> picture [305 x 29] intentionally omitted <==**

Finally, we conclude that _H ⪰_ 0 from (Zheng et al., 2021)[Theorem 2.1]. 

**Necessary.** For any _Wk_ and Λ _k_ satisfying (19), we will find set of free variables _dk, Xk, Yk_ such that (8) holds. We take 1 Ψ _k_ = Λ 2 which further leads to _dk_ = diag(log Ψ _k_ ). By letting _A−_ 1 = _I,_ Ψ _−_ 1 = � _γ/_ 2 _I_ and Ψ _L_ = ~~�~~ 2 _/γI_ we then construct _Ak, Bk_ recursively via 

**==> picture [359 x 21] intentionally omitted <==**

where chol( _·_ ) denotes the Cholesky factorization, _Qk_ is an arbitrary orthogonal matrix such that _Ak_ does not have eigenvalue _⊤_ of _−_ 1. If _Ak−_ 1 is non-invertible but non-zero, we replace _A[−⊤] k−_ 1[with] � _A_[+] _k−_ 1� . If _Ak−_ 1 = 0 (i.e. _Wk_ = 0), we simply reset _Ak−_ 1 = _I_ . It is easy to verify that Ψ _k, Ak_ and _Bk_ satisfy the model parameterization (8). Finally, we can construct _Xk, Yk_ using (37), which is well-defined as _Ak_ does not have eigenvalue of _−_ 1. 

## **D.4. Proof of Theorem 3.2** 

The proposed layer (10) can be rewritten as a compact network (17) with _W_ = 0, _Y_ = _√_ 2 _A[⊤]_ Ψ and _U_ = _√_ 2Ψ _[−]_[1] _B_ , i.e., _v_ = _Uh_ in + _b, z_ = _σ_ ( _v_ ) _, h_ out = _Y z._ 

From the model parameterization (6) we have _AA[⊤]_ + _BB[⊤]_ = _I_ , which further implies 

**==> picture [387 x 12] intentionally omitted <==**

15 

**Lipschitz-Bounded Deep Networks** 

**16** 

By applying Schur complement twice to the above equation we have 

**==> picture [141 x 37] intentionally omitted <==**

Then, the 1-Lipschitzness of (10) is obtained by Theorem A.3. 

## **D.5. Proof of Proposition 3.3** 

**Sufficient.** It is a direct corollary of Theorem 3.2 by taking the identity operator as the nonlinear activation. 

**Necessary.** Here we give a constructive proof. That is, given a weight matrix _W_ with _∥W ∥≤_ 1, we will find a (generally non-unique) pair of ( _X, Y_ ) such that 2 _A[⊤] B_ = _W_ with _A, B_ given by (6). 

We first construct _A, B_ from _W_ . Since it is obvious for _W_ = 0, we consider the case with nonzero _W_ . First, we take a singular value decomposition (SVD) of _W_ , i.e. _W_ = _Uw_ Σ _wVw[⊤]_[where] _[U][w]_[is][a] _[q][×][ q]_[orthogonal][matrix,][Σ] _[w]_[is][an] _q × p_ rectangular diagonal matrix with Σ _w,ii ≥_ 0 non-increasing, _Vw_ is a _p × p_ orthogonal matrix. Then, we consider the candidates for _A_ and _B_ as follows: 

**==> picture [307 x 13] intentionally omitted <==**

where Σ _a_ is a diagonal matrix, Σ _b_ a rectangular diagonal matrix _U ∈_ R _[q][×][q]_ an orthogonal matrix. By substituting (33) into the equalities _AA[⊤]_ + _BB[⊤]_ = _Iq_ and _W_ = 2 _A[⊤] B_ we have 

**==> picture [313 x 13] intentionally omitted <==**

where Σ _b′,_ Σ _w′ ∈_ R _[q][×][q]_ are obtained by either removing the extra columns of zeros on the right or adding extra rows of zeros at the bottom to Σ _b_ and Σ _w_ , respectively. The solution to (34) is 

**==> picture [423 x 21] intentionally omitted <==**

where are well-defined as _∥W ∥≤_ 1. Now we can obtain Σ _b_ from Σ _b′_ by removing extra rows of zeros at the bottom or adding extra columns of zeros on the right. At last, we pick up any orthogonal matrix _U_ such that _A_ = _U_ Σ _aUw[⊤]_[does not] have eigenvalue of _−_ 1. 

The next step is to find a pair of ( _X, Y_ ) such that 

**==> picture [404 x 13] intentionally omitted <==**

One solution to the above equation is 

**==> picture [399 x 21] intentionally omitted <==**

where tril( _W_ ) denotes the strictly lower triangle part of _W_ . Note that the above solution is well-defined since _A_ does not has eigenvalue of _−_ 1. 

## **D.6. Proof of Proposition C.1** 

From (29) we have 

**==> picture [159 x 46] intentionally omitted <==**

**Lipschitz-Bounded Deep Networks** 

**17** 

_Table 4._ Model architectures for MNIST. 

|MLP|Orthogonal|Sandwich|
|---|---|---|
|Fc(784,256)|OgFc(784,256)|SwFc(784,190)|
|Fc(256,256)|OgFc(256,256)|SwFc(190,190)|
|Fc(256,128)|OgFc(256,128)|SwFc(190,128)|
|Lin(128,10)|OgLin(128,10)|SwLin(128,10)|



Applying the Schur complement yields _γI −_ 1 _/_ 2 _W_ 0 _[⊤]_[Ψ][0][(] _[B]_[0] _[B]_ 0 _[⊤]_[)][+][Ψ][0] _[W]_[0] _[⪰]_[0][, which implies] _[ ∥][B]_ 0[+][Ψ][0] _[W]_[0] _[∥≤√]_ 2 _γ_ . From (30) we obtain 

**==> picture [259 x 102] intentionally omitted <==**

Similarly, from (31) we have 

**==> picture [335 x 25] intentionally omitted <==**

The bound of Jacobian operator **J** _[c] f_ is then obtained by 

**==> picture [479 x 82] intentionally omitted <==**

where the first inequality follows as 2 _A[⊤] k[J][k][B][k]_[is the Clake Jacobian of a 1-Lipschitz layer (][10][), i.e.] _[∥]_[2] _[A][⊤] k[J][k][B][k][∥≤]_[1][.] 

## **E. Training details** 

For all experiments, we used a piecewise triangular learning rate (Coleman et al., 2017) with maximum rate of 0 _._ 01. We use Adam (Kingma & Ba, 2014) and ReLU as our default optimizaer and activation, respectively. Because the Cayley transform in (6) involves both linear and quadratic terms, we implemented the weight normalization method from (Winston & Kolter, 2020). That is, we reparameterize _X, Y_ in _Z_ = _X − X[⊤]_ + _Y[⊤] Y_ by _g ∥XX∥F_[and] _[ h] ∥YY ∥F_[with learable scalars] _g, h_ . We search for the empirical lower Lipschitz bound _γ_ of a network _fθ_ by a PGD-like method, i.e., updating the input _x_ and its deviation _δx_ based on the gradient of _∥fθ_ ( _x_ + ∆ _x_ ) _− fθ_ ( _x_ ) _∥/∥_ ∆ _x∥_ . As we are interested in the global lower Lipschitz bound, we do not project _x_ and _x_ + ∆ _x_ into any compact region. For image classification tasks, we applied data augmentation used by (Araujo et al., 2023). All experiments were performed on an Nvidia A5000. 

**Toy example.** For the curve fitting experiment, we take 300 and 200 samples ( _xi, yi_ ) with _xi ∼U_ ([ _−_ 2 _,_ 2]) for training and testing, respectively. We use batch size of 50 and Lipschitz bounds of 1, 5 and 10. All models for the toy example have 8 hidden layers. We choose width of 128, 128, 128 and 86 for AOL, orthogonal, SLL and sandwich layers, respectively, so that each model size is about 130K. We use MSE loss and train models for 200 epochs. 

**Image classification.** We trained small fully-connected model on MNIST and the KWLarge network from (Li et al., 2019) on CIFAR-10. To make the different models have similar number of parameters in the same experiment, we slightly reduce 

17 

**Lipschitz-Bounded Deep Networks** 

**18** 

_Table 5._ Model architectures for CIFAR-10/100 and Tiny-ImageNet. We use _w_ = 1 _,_ 2 _,_ 4 to denote the _small_ , _medium_ and _large_ models. The default kernel size for all convolution is 3. For orthogonal and sandwich convolution, we use the emulated 2-stride from (Trockman & Kolter, 2021) when s=2 is indicated. For CNN, s=2 refers to the standard 2-stride operation. Since the AOL layer does not support stride operation, we add average pooling at the end to convolution layers. Here ncls denotes the number of classes in the dataset, e.g. 100 for CIFAR-100 and 200 for Tiny-ImageNet. 

|CNN|AOL|Orthogonal|Sandwich|
|---|---|---|---|
|Conv(3,32*w)|AolConv(3,32*w)|OgConv(3,32*w)|SwConv(3,32*w)|
|Conv(32*w,32*w,s=2)|AolConv(32*w,32*w)|OgConv(32*w,32*w,s=2)|SwConv(32*w,32*w,s=2)|
|Conv(32*w,64*w)|AolConv(32*w,64*w)|OgConv(32*w,64*w)|SwConv(32*w,64*w)|
|Conv(64*w,64*w,s=2)|AolConv(64*w,64*w)|OgConv(64*w,64*w,s=2)|SwConv(64*w,64*w,s=2)|
|Flatten|AvgPool(4),Flatten|Flatten|Flatten|
|Fc(4096*w,640*w|AolFc(4096*w,640*w)|OgFc(4096*w,640*w)|SwFc(4096*w,512*w)|
|Fc(640*w,512*w)|AolFc(640*w,512*w)|OgFc(640*w,512*w)|SwFc(512*w,512*w)|
|Lin(512*w,ncls)|AolLin(512*w,ncls)|OgLin(512*w,ncls)|SwLin(512*w,ncls)|



_Table 6._ Sandwich models in the experiment of certified robustness. Here LLN stands for the Last Layer Normalization (Singla et al., 2022) which can improve the certified robustness when the number of classes become large. 

|CIFAR-100|TinyImageNet|
|---|---|
|SwConv(3,64)|SwConv(3,64)|
|SwConv(64,64,s=2)|SwConv(64,64,s=2)|
|SwConv(64,128)|SwConv(64,128)|
|SwConv(128,128,s=2)|SwConv(128,128,s=2)|
|SwConv(128,256)|SwConv(128,256)|
|SwConv(256,256,s=2)|SwConv(256,256,s=2)|
|-|SwConv(256,512)|
|-|SwConv(512,512,s=2)|
|SwFc(1024,2048)|SwFc(2048,2048)|
|SwFc(2048,2048)|SwFc(2048,2048)|
|SwFc(2048,1024)|SwFc(2048,1024)|
|LLN(1024,100)|LLN(1024,200)|



the hidden layer width of sandwich model in the MNIST experiment and increases width of the first fully-connected layer of CNN and orthogonal models. The model architectures are reported in Table 4 - 5. We used the same loss function as (Trockman & Kolter, 2021) for MNIST and CIFAR-10 datasets. The Lipschitz bounds _γ_ are chosen to be 0.1, 0.5, 1.0 for MNIST and 1,10,100 for CIFAR-10. All models are trained with normalized input data for 100 epochs. The data normalization layer increases the Lipschitz bound of the network to _≈_ 4 _._ 1 _γ_ . 

For the experiment of empirical robustness, model architectures with different sizes are reported in Table 5. The SLL model with small, medium and large size can be found in (Araujo et al., 2023). We train models with different Lipschitz bounds of _{_ 0 _._ 5 _,_ 1 _,_ 2 _, . . . ,_ 16 _}_ . We found that _γ_ = 2 for CIFAR-100 and _γ_ = 1 for Tiny-ImageNet achieve the best robust accuracy for the perturbation size of _ϵ_ = 36 _/_ 255. All models are trained with normalized input data for 100 epochs. 

We also compare the certified robustness to the SLL model. Slightly different from the experimental setup for empirical robustness comparison, we remove the data normalization and use the Last Layer Normalization (LLN) proposed by (Singla et al., 2022) which can improve the certified accuracy when the number of classes becomes large. We set the Lipschitz bound of sandwich and SLL models to 1. But the Lipschitz constant of the composited model could be larger than 1 due to LLN Due to LLN. The certified accuracy is then normalized by the last layer (Singla et al., 2022). Also, we remove the data normalization for better certified robustness. For all experiments on CIFAR-100 and Tiny-ImageNet, we use the CrossEntropy loss as in (Prach & Lampert, 2022) with temperature of 0.25 and an offset value 3 _√_ 2 _/_ 2 . 

18 

