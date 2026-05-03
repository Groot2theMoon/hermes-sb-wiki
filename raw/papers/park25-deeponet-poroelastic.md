---
title: "Deep operator network for surrogate modeling of poroelasticity with random permeability fields"
arxiv: "2509.11966"
authors: ["Sangjoon Park"]
year: 2025
source: paper
ingested: 2026-05-03
sha256: f1822fc369a0e4720fceb194ed9c0b51f715eb023725bdf1184f0bbe383417f5
conversion: pymupdf4llm
---

# Deep operator network for surrogate modeling of poroelasticity with random permeability fields 

Sangjoon Park[a] , Yeonjong Shin[b] , Jinhyun Choo[c,d,][∗] 

_aDepartment of Civil and Environmental Engineering, KAIST, Daejeon, South Korea bDepartment of Mathematics, North Carolina State University, Raleigh, United States_ 

_cDepartment of Civil and Environmental Engineering, Seoul National University, Seoul, South Korea dInstitute of Construction and Environmental Engineering, Seoul National University, Seoul, South Korea_ 

## **Abstract** 

Poroelasticity—coupled fluid flow and elastic deformation in porous media—often involves spatially variable permeability, especially in subsurface systems. In such cases, simulations with random permeability fields are widely used for probabilistic analysis, uncertainty quantification, and inverse problems. These simulations require repeated forward solves that are often prohibitively expensive, motivating the development of efficient surrogate models. However, efficient surrogate modeling techniques for poroelasticity with random permeability fields remain scarce. In this study, we propose a surrogate modeling framework based on the deep operator network (DeepONet), a neural architecture designed to learn mappings between infinite-dimensional function spaces. The proposed surrogate model approximates the solution operator that maps random permeability fields to transient poroelastic responses. To enhance predictive accuracy and stability, we integrate three strategies: nondimensionalization of the governing equations, input dimensionality reduction via Karhunen–Loéve expansion, and a two-step training procedure that decouples the optimization of branch and trunk networks. The methodology is evaluated on two benchmark problems in poroelasticity: soil consolidation and ground subsidence induced by groundwater extraction. In both cases, the DeepONet achieves substantial speedup in inference while maintaining high predictive accuracy across a wide range of permeability statistics. These results highlight the potential of the proposed approach as a scalable and efficient surrogate modeling technique for poroelastic systems with random permeability fields. 

_Keywords:_ Poroelasticity, Surrogate modeling, Scientific machine learning, Deep operator network, Random field, Spatial variability 

> ∗Corresponding Author _Email address:_ `jinhyun.choo@snu.ac.kr` (Jinhyun Choo) 

## **1. Introduction** 

Poroelasticity describes the interaction between fluid flow and elastic deformation in porous media. It provides the modeling basis for many subsurface applications in which groundwater flow and ground deformation are tightly coupled ( _e.g._ [1–10]). 

In subsurface systems, permeability often exhibits strong spatial heterogeneity, spanning several orders of magnitude [11–17]. This variability plays a critical role in both flow and deformation processes, and therefore often needs to be considered. A common approach for this purpose is to represent permeability as a spatially correlated random field [18] and propagate its influence through the governing poroelastic equations. This strategy has been extensively applied in uncertainty quantification for consolidation [19–21], stochastic modeling of subsidence [22–25], and Bayesian inference of settlement and aquifer properties [26–28]. 

However, random field modeling involves a significant computational challenge that arises from the need to solve the forward poroelastic equations repeatedly over large ensembles of permeability realizations. Full-order solvers such as the finite element method (FEM) offer high accuracy and flexibility, but their cost becomes prohibitive in many-query settings, including probabilistic analysis, uncertainty quantification, and inverse problems. 

To alleviate this cost, surrogate models are often employed to replace full-order solvers with computationally efficient approximations, and they have demonstrated success in a wide range of mechanics applications [29–34]. In poroelasticity and related problems, polynomial chaos expansion (PCE) surrogates have primarily been used to assess the influence of spatial variability in the coefficient of consolidation on global measures such as the average degree of consolidation [35, 36]. Projection-based reduced-order models (ROMs), particularly those based on proper orthogonal decomposition, have also been applied to accelerate reservoir simulations [37]. 

Nevertheless, when the input field, such as permeability, is high-dimensional and spatially random, and the outputs of interest are full spatiotemporal fields, even surrogate approaches can become computationally demanding [38–40]. This limitation highlights the need for surrogate models that scale efficiently with both input and output dimensionality. 

Recent advances in deep learning have introduced new surrogate modeling strategies for poroelasticity, capable of capturing nonlinear relationships between inputs and outputs in high-dimensional settings. Convolutional neural networks, particularly U-Net architectures, have been applied to predict displacement and pressure fields under spatially random permeability [41–44]. Continuous conditional generative adversarial networks (CcGANs) have also been employed to model poroelastic responses in heterogeneous porous media [45]. 

Despite this progress, current deep learning surrogates for poroelasticity still face key limitations. Grid-based inputs in U-Net architectures inflate the dimensionality of already complex permeability fields, increasing training costs and hindering generalization. GAN-based surrogates, although expressive, are often unstable and difficult to train robustly, particularly when targeting 

2 

full spatiotemporal predictions [46]. 

In this work, we develop a surrogate modeling framework for poroelasticity with spatially variable permeability, based on the deep operator network (DeepONet) [47]. DeepONet is a neural architecture designed to approximate nonlinear operators between function spaces, supported by a universal approximation theorem for operators [48]. Within this framework, we use DeepONet to learn the solution operator that maps permeability field realizations to the corresponding transient displacement and pressure fields. 

To enhance generalization and training stability, we incorporate three key strategies. First, the governing equations and physical variables are nondimensionalized to reduce scale disparities. Second, the input dimensionality is reduced through a truncated Karhunen–Loéve (K–L) expansion of the log-permeability field. Third, a two-step training procedure is adopted to decouple the optimization of the branch and trunk networks, following recent advances in DeepONet training [49]. 

The surrogate model is evaluated on two benchmark problems in poroelasticity: soil consolidation and ground subsidence induced by groundwater extraction. For each case, training datasets are generated from finite element simulations. In both problems, the surrogate achieves high predictive accuracy and delivers orders-of-magnitude speedup over conventional finite element methods. 

## **2. Poroelasticity with random permeability fields** 

In this work, we consider the _**u**_ – _p_ formulation for poroelasticity, where coupled elastic deformation and fluid flow are described by two primary variables: the solid displacement vector _**u**_ and the pore pressure _p_ . The _**u**_ – _p_ formulation is the standard approach for poroelasticity and its extensions ( _e.g._ [50–56]). In the following, we adopt the excess pore pressure form of this formulation, where _p_ denotes the excess pore pressure—the deviation from a steady-state hydrostatic distribution. 

Consider a porous medium saturated by a single incompressible fluid. The medium occupies the spatial domain Ω ⊂ R _[d]_ , where _d_ denotes the number of spatial dimensions. The boundary of the domain, ∂Ω, is partitioned into displacement (Dirichlet) boundaries ∂Ω _**u**_ and traction (Neumann) boundaries ∂Ω _**t**_ for the solid deformation field, and into pore pressure boundaries ∂Ω _p_ and flux boundaries ∂Ω _q_ for the fluid flow field. These boundary subsets are assumed to satisfy the standard non-overlapping and closure conditions. The temporal domain is defined as T � (0, _T_ ] with _T_ > 0, and the full spatiotemporal domain is given by Ω × T . 

Without loss of generality, we assume that the porous medium is quasi-static, undergoes infinitesimal deformation, contains no mass sources or sinks, and is composed of incompressible solid grains. We also postulate that the effective stress principle holds. Under these assumptions, 

3 

the governing equations of poroelasticity are expressed as 

**==> picture [360 x 32] intentionally omitted <==**

where σ[′] is the effective stress, ρ _b_ is the buoyant density of the medium, _**g**_ is the gravitational acceleration, and _**q**_ is the superficial fluid velocity. Note that the buoyant density appears in the momentum balance equation because the formulation is expressed in terms of excess pore pressure. 

To close the formulation, we introduce constitutive relations for the solid and fluid responses. Assuming the solid deformation is linear elastic, the effective stress–strain relation is expressed as 

**==> picture [262 x 11] intentionally omitted <==**

where ϵ is the infinitesimal strain, defined as 

**==> picture [283 x 25] intentionally omitted <==**

and C[e] is the fourth-order elasticity (stiffness) tensor. For an isotropic elastic material, C[e] is characterized by two independent elasticity parameters, such as Young’s modulus _E_ and Poisson’s ratio ν. Assuming Darcy’s law governs fluid flow, the superficial fluid velocity is given by 

**==> picture [265 x 29] intentionally omitted <==**

where _k_ is the intrinsic permeability, µ _f_ is the dynamic viscosity of the pore fluid, and ρ _f_ is the fluid density. Note that the gravitational contribution is omitted from Eq. (5) because _p_ denotes excess pore pressure. 

To model spatial variability in permeability, we represent the log-permeability κ := ln( _k_ ) as a Gaussian random field. This choice is widely used in subsurface modeling due to the high variability and positivity of permeability ( _e.g._ [19, 20, 25, 36]). Assuming second-order stationarity, κ is fully characterized by a mean µκ and a covariance function _C_ κ( _**x**_ 1, _**x**_ 2), typically parameterized by a standard deviation σκ and a correlation length _l_ . We assume that the covariance type is prescribed, and that the statistical parameters are obtained from measurement data ( _e.g._ , in-situ soil tests [57–60]). Accordingly, the spatially varying permeability is expressed as 

**==> picture [305 x 12] intentionally omitted <==**

where ω ∈ Ω is an element of the sample space Ω, and _g_ κ is a zero-mean Gaussian field with 

4 

covariance function _C_ κ. 

The boundary conditions are specified as 

**==> picture [323 x 72] intentionally omitted <==**

where _**x**_ ∈ Ω is the position vector, _t_ ∈T is the time variable, and _**n**_ is the outward unit normal on the boundary. The quantities _**u**_ ˆ , _**t**_[ˆ] , _p_ ˆ, and _q_ ˆ denote the prescribed displacement, traction, excess pore pressure, and fluid flux, respectively. The initial conditions are given by 

**==> picture [290 x 31] intentionally omitted <==**

The resulting initial–boundary value problem can be solved using standard two-field mixed finite elements. The discretization details are omitted for brevity. 

## **3. DeepONet surrogate modeling** 

In this section, we develop a DeepONet-based surrogate modeling framework for poroelasticity with random permeability fields. The objective is to approximate the solution operator that maps a realization of the permeability field to the corresponding poroelastic response, such as displacement and excess pore pressure fields. Let _k_ ( _**x**_ ; ω) denote the realization of the input random permeability field, and let _f_ ( _**x**_ , _t_ ; ω) denote the corresponding poroelastic response. The underlying operator is expressed as 

**==> picture [292 x 12] intentionally omitted <==**

where G represents the mapping induced by the governing initial–boundary value problem described in Section 2. 

To construct an efficient surrogate for G based on DeepONet, we present a three-stage modeling strategy in the following. First, we nondimensionalize the governing equations to improve numerical stability and facilitate generalization across varying physical scales. Second, we perform dimensionality reduction of the input permeability field using the K–L expansion, which enables extracting dominant modes of variability while compressing the stochastic input space. Third, we develop a tailored DeepONet architecture and train it using a two-step training procedure. 

5 

## _3.1. Nondimensionalization of governing equations_ 

Nondimensionalization plays a critical role in constructing stable and generalizable surrogate models, particularly in neural network-based approximations [61–63]. By rescaling variables and parameters into dimensionless form, we reduce numerical stiffness, normalize data magnitudes, and facilitate consistent learning across a range of parameter values. 

We consider a two-dimensional poroelastic problem ( _d_ = 2) and introduce characteristic scaling quantities _T_[∗] , _s_[∗] , _k_[∗] , _u_[∗] , _p_[∗] , _t_[∗] , and _q_[∗] , corresponding to characteristic time, length, permeability, displacement, pressure, traction, and flux scales, respectively. The nondimensionalized variables or parameters are defined as 

**==> picture [359 x 56] intentionally omitted <==**

where ◦¯ denotes the nondimensionalized version of a given variable or parameter ◦. 

To determine the scaling parameters, we proceed as follows: 

1. We set the reference length _s_[∗] , reference permeability _k_[∗] , and one loading-related scale— either the reference traction _t_[ˆ][∗] or the reference flux _q_ ˆ[∗] —depending on the loading type in the problem. 

2. Using dimensional analysis of the poroelastic governing equations and constitutive relations, we express the displacement and pressure scales _u_[∗] and _p_[∗] in terms of the loading scale: 

**==> picture [359 x 61] intentionally omitted <==**

where _A_ and _B_ are dimensionless constants dependent on Poisson’s ratio ν. 

3. Finally, we define the characteristic time scale as 

**==> picture [253 x 28] intentionally omitted <==**

In this work, we focus exclusively on spatial variability in the permeability field, while assuming that other elasticity and fluid parameters—namely Young’s modulus _E_ , Poisson’s ratio ν, and fluid viscosity µ _f_ —are constants. For notational simplicity, we omit the bars in subsequent sections; all quantities are assumed nondimensional unless stated otherwise. 

6 

## _3.2. Dimension reduction using Karhunen–Loéve expansion_ 

The poroelasticity operator defined in Eq. (13) maps a permeability field to the corresponding poroelastic response. In a discretized form, this operator can be expressed as 

**==> picture [302 x 14] intentionally omitted <==**

where 

**==> picture [310 x 13] intentionally omitted <==**

denotes the discretized permeability field evaluated at _Ns_ spatial points { _**x** i_ } _i[N]_ = _[s]_ 1[. While such repre-] sentation allows for high-resolution modeling of spatial variability, the resulting input dimensionality can be prohibitively large for surrogate modeling. 

To reduce the dimensionality of the input, we employ the Karhunen–Loève (K–L) expansion, which represents a second-order random field in terms of orthogonal spatial basis functions and uncorrelated random variables. Specifically, we express the log-permeability field κ( _**x**_ ; ω) = ln _k_ ( _**x**_ ; ω) as 

**==> picture [320 x 34] intentionally omitted <==**

where µκ is the mean, λ _j_ and _e j_ are the eigenvalues and eigenfunctions of the covariance kernel _C_ ( _**x**_ 1, _**x**_ 2), and ξ _j_ (ω) ∼N(0, 1) are uncorrelated standard Gaussian random variables. The eigenfunctions satisfy the homogeneous Fredholm integral equation 

**==> picture [311 x 27] intentionally omitted <==**

and are computed using the integral method [64]. The eigenvalues are ordered as λ1 ≥ λ2 ≥· · · ≥ λ _Ns_ . 

To reconstruct the permeability field, we apply the exponential map: 

**==> picture [349 x 37] intentionally omitted <==**

where κ[∗] = ln( _k_[∗] ) is a scaling constant for nondimensionalization. The truncated form _k[m]_ defines an approximate permeability realization evaluated at { _**x** i_ } _i[N]_ = _[s]_ 1[:] 

**==> picture [321 x 13] intentionally omitted <==**

7 

Accordingly, the operator in Eq. (17) becomes 

**==> picture [309 x 13] intentionally omitted <==**

where _f[m]_ is the poroelastic response corresponding to the truncated permeability field. The exact response corresponds to _m_ = _Ns_ , that is, 

**==> picture [289 x 14] intentionally omitted <==**

To further reduce the input dimension, we retain only the first _M_ < _Ns_ terms in the expansion, leading to 

**==> picture [317 x 13] intentionally omitted <==**

which serve as a low-dimensional representation of the random input. The approximation is acceptable if the associated error 

**==> picture [314 x 19] intentionally omitted <==**

is sufficiently small for the application of interest. Because _**k**[M]_ (ω) is uniquely determined by ξ _[M]_ (ω) for fixed mean and covariance, we define the reduced-order operator 

**==> picture [280 x 14] intentionally omitted <==**

which maps the K–L coefficients directly to the poroelastic response. This formulation enables a compact and structured input representation suitable for neural operator learning using DeepONet. The DeepONet framework is illustrated in Fig. 1. 

## _3.3. DeepONet architecture and training_ 

In this work, we construct a DeepONet-based surrogate that approximates the operator G[′] (27), mapping the principal K–L expansion coefficients of the random permeability field to the poroelastic response. Specifically, we represent the surrogate operator as 

**==> picture [323 x 13] intentionally omitted <==**

where _**c**_ : R _[M]_ → R _[K]_ is the branch network parameterized by θ, and ϕ : R _[d]_[+][1] → R _[K]_ is the trunk network parameterized by µ. Here, _K_ is the number of basis functions, and ⟨·, ·⟩ denotes the dot product in R _[K]_ . The branch network encodes the latent representation of the input ξ _[M]_ , producing a coefficient vector _**c**_ = ( _c_ 1, · · · , _cK_ ). The trunk network outputs ϕ = (ϕ1, · · · , ϕ _K_ ) are interpreted as spatiotemporal basis functions, each associated with a scalar coefficient from the branch output. Their dot product provides the prediction of the DeepONet, _f_[NN] ( _**x**_ , _t_ ). 

8 

**==> picture [444 x 239] intentionally omitted <==**

**----- Start of picture text -----**<br>
Covariance function  𝐶𝜅 ( 𝒙 1 , 𝒙 2)<br>K–L expansion Random permeability field<br>Correlation length(s)  𝑙 𝑥, 𝑙𝑧<br>𝝃 ∈ R [𝑁][𝑠] 𝒌 ∈ R [𝑁][𝑠]<br>Standard deviation  𝜎𝜅<br>Dimensionality reduction ( 𝑀< 𝑁𝑠 )<br>K–L coefficients Branch network<br>𝒄 ( 𝝃 [𝑀] ;  𝜽 )<br>𝝃 [𝑀] ∈ R [𝑀] 𝜽<br>DeepONet output<br>𝑓 [NN] ( 𝒙, 𝑡 ) = ⟨ 𝒄 ( 𝝃 [𝑀] ;  𝜽 ) , 𝝓 ( 𝒙, 𝑡 ;  𝝁 )⟩<br>Coordinates Trunk network<br>𝝓 ( 𝒙, 𝑡 ;  𝝁 )<br>( 𝒙, 𝑡 ) 𝝁<br>**----- End of picture text -----**<br>


Figure 1: DeepONet surrogate modeling framework for poroelasticity with random permeability fields. A separate DeepONet is trained for each nondimensionalized primary variable and each set of permeability statistics. The predicted output is denoted by _f_[NN] ∈{ _u_[NN] _x_[,] _[ u]_[NN] _z_[,] _[ p]_[NN][}][.] 

To handle the different response characteristics of each primary variable, we implement separate DeepONets for each component _f_ ∈{ _ux_ , _uz_ , _p_ }. This design not only improves flexibility in training but also reduces computational cost per network. Both the branch and trunk networks are constructed using fully connected feed-forward neural networks with hyperbolic tangent activation functions. The network architecture is specified by layer widths. The branch network uses the architecture _**n** b_ = ( _M_ , · · · , _K_ ), and the trunk network uses _**n** t_ = ( _d_ + 1, · · · , _K_ − 1), where each component denotes the number of neurons in that layer. Note that the trunk network has an output with dimension _K_ − 1; we manually add a constant basis function after training to ensure completeness. 

To train the DeepONet, we adopt the two-step training method introduced by Lee and Shin [49], which has been shown to improve training stability and predictive accuracy relative to standard training. Instead of simultaneously optimizing both the trunk and branch networks, the two-step training method separates the training into sequential sub-problems that decouple basis function learning from coefficient learning, reducing optimization complexity and improving generalization. The training procedure proceeds as follows: 

1. **Trunk network training.** We first optimize the trunk network parameters µ and a coefficient matrix _**A**_ by minimizing the loss 

**==> picture [298 x 20] intentionally omitted <==**

9 

where _**F**_ ∈ R _[N]_[×] _[m]_[y] is the train dataset of output snapshots ( _e.g._ displacement or pressure fields), and Φ( _**T**_ ; µ) ∈ R _[m]_[y][×] _[K]_ is the trunk network output evaluated at spatiotemporal coordinates _**T**_ , discretized with _m_ y points. This step treats the trunk network outputs as a learnable functional basis, optimized to minimize global reconstruction error across training samples. 

2. **QR decomposition and branch target projection.** After trunk network training, we orthogonalize the learned basis using QR decomposition: Φ[∗] = _**Q**_[∗] _**R**_[∗] , where _**Q**_[∗] ∈ R _[m]_[y][×] _[K]_ contains orthonormal basis functions and _**R**_[∗] ∈ R _[K]_[×] _[K]_ is upper triangular. We then compute the projected coefficients 

**==> picture [249 x 14] intentionally omitted <==**

which define the targets for the branch network. This Gram-Schmidt orthonomalization process ensures that the branch learns coefficients aligned with an orthonormal basis, simplifying the learning task and improving conditioning. 

3. **Branch network training.** Finally, we train the branch network by minimizing the loss 

**==> picture [284 x 16] intentionally omitted <==**

where Ξ ∈ R _[N]_[×] _[M]_ is the input dataset of K–L expansion coefficients, and _**C**_ (Ξ; θ) ∈ R _[N]_[×] _[K]_ denotes the branch network output. Since the targets are already projected, this step becomes a well-conditioned regression problem. 

For optimization, we employ a hybrid strategy [65] that combines AdamW [66] and L-BFGS [67]. We first train each network with AdamW for 5,000 epochs using a mini-batch size of _N_ /4. The initial learning rate is set to 10[−][3] , with exponential decay: 0.99 per 100 iterations for the trunk network, and 0.98 for the branch network. Afterward, we switch to L-BFGS for fine-tuning with a maximum of 10,000 iterations and a stopping tolerance of 10[−][10] , as implemented in `jaxopt` [68]. 

## **4. Numerical examples** 

In this section, we evaluate the proposed surrogate modeling framework using two representative poroelasticity problems: (1) soil consolidation and (2) ground subsidence induced by groundwater extraction. The first problem is driven by mechanical (traction) loading, while the second is driven by hydraulic (flux) loading. In both cases, the objective is to learn the nonlinear operator that maps random permeability fields to corresponding transient poroelastic responses. 

The numerical experiments are designed to assess the performance of surrogate models across a range of permeability statistics representative of subsurface heterogeneity encountered in geotechnical and hydrogeologic systems. This parameter space spans a broad spectrum of subsurface con- 

10 

ditions, enabling a systematic evaluation of surrogate robustness with respect to spatial variance and correlation structure. 

Each example follows the same modeling workflow. We first define the physical configuration, nondimensionalize the governing equations, and model the permeability field as a spatially correlated random process. We then generate input–output datasets using finite element simulations and train DeepONet to approximate the associated solution operator. Using evaluations on a test dataset, we select suitable network architectures and assess generalization across permeability statistics. Finally, we compare the computational cost of DeepONet and FEM to determine the crossover point at which surrogate-based inference becomes more efficient. 

All FEM simulations are performed using the `FEniCSx` library [69, 70] on a single core of an AMD Ryzen Threadripper PRO 5955WX CPU. DeepONet models are implemented using `JAX` [71] and `FLAX` [72], and trained on a single NVIDIA GeForce RTX 4090 GPU. 

## _4.1. Soil consolidation_ 

Our first example is a soil consolidation problem, in which the classical one-dimensional Terzaghi formulation is extended to incorporate spatial random permeability fields. This type of problem is of fundamental importance in geotechnical engineering and has been the subject of probabilistic analysis in the literature ( _e.g._ [19, 20]). The objective is to predict the nondimensionalized vertical displacement _uz_ ( _**x**_ , _t_ ) and excess pore pressure _p_ ( _**x**_ , _t_ ). Horizontal displacement is omitted, as the problem geometry, loading conditions, and underlying physics remain effectively onedimensional, apart from the spatial variability introduced by the permeability field. 

The problem domain is a unit square representing a saturated soil layer subjected to surface loading. At _t_ = 0, a uniform vertical stress of magnitude _t_ 0 is applied to the top surface. Hydraulic boundary conditions impose zero excess pore pressure (drained) on the top edge and no flow (undrained) on the remaining boundaries. Mechanical conditions consist of roller constraints on the lateral edges (zero horizontal displacement and vertical traction) and a fully fixed base. The Poisson’s ratio is set to ν = 0.4. To reduce parameter dependence and improve numerical conditioning, we nondimensionalize the governing equations following Terzaghi’s classical consolidation framework. With _t_[∗] = _t_ 0 as the reference stress, the scaling parameters are defined as 

**==> picture [377 x 29] intentionally omitted <==**

where _mv_ :=[(][1][−] _E_[2] (1[ν][)(] −[1] ν[+] )[ν][)] is the coefficient of volume compressibility, and _cv_ := µ _k f_[∗] (1− _E_ 2(ν1)(1−ν+) ν)[is][the] coefficient of consolidation. The nondimensionalized configuration is illustrated in Fig. 2. 

To model spatial variability in permeability, we generate random fields using a K–L expansion 

11 

**==> picture [231 x 257] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>drained<br>random<br>1 permeability field<br>𝑧<br>undrained<br>𝑥<br>1<br>undrained undrained<br>**----- End of picture text -----**<br>


Figure 2: Soil consolidation: Problem setup in nondimensional form. 

with a Gaussian covariance function: 

**==> picture [353 x 33] intentionally omitted <==**

This form captures anisotropic spatial correlation characteristics of sedimentary formations, where vertical layering leads to shorter correlation lengths in the vertical direction [12, 21, 73]. Unless otherwise stated, we adopt the baseline parameter set (σκ, _lx_ , _lz_ ) = (1.5, 0.25, 0.125). To construct training data, we draw 10,000 K–L coefficient samples using Latin hypercube sampling (LHS) [74], allocating 8,000 for training and 2,000 for testing. Each sample is evaluated using FEM on a unit square domain Ω= {( _x_ , _z_ ) | 0 ≤ _x_ ≤ 1, 0 ≤ _z_ ≤ 1} discretized with structured triangular elements (∆ _x_ = ∆ _z_ = 0.05). The spatial discretization uses Taylor–Hood elements, where the displacement field is interpolated using quadratic shape functions and the pressure field is interpolated using linear shape functions. We define the temporal domain as T = { _t_ | 0 < _t_ ≤ 1} and discretized with a uniform time step ∆ _t_ = 0.01. 

Based on the FEM-generated dataset, we construct a DeepONet that maps low-dimensional K–L inputs to transient poroelastic responses. The branch network receives the truncated K–L coefficient vector ξ _[M]_ , and the trunk network is evaluated on a uniform grid. The number of basis functions _K_ is chosen to be 1–2 times the numerical rank of the output matrix _**U**_ , determined using a relative singular value threshold of 0.01 × max( _N_ , _my_ ); singular values below this threshold are 

12 

considered negligible for basis selection. The output consists of the evaluated primary variables at spatial nodes {( _xi_ , _zi_ ) | _xi_ ∈{0.0, 0.1, . . . , 0.9, 1.0}, _zi_ ∈{0.0, 0.1, . . . , 0.9, 1.0}} and temporal nodes _ti_ ∈{0.1, 0.2, . . . , 1.0}. The trunk network is trained independently for each output variable. The trunk network architectures are configured as _**n** t_ = (3, 256, 256, 256) for vertical displacement _uz_ and _**n** t_ = (3, 64, 64, 32) for excess pore pressure _p_ . The branch network adopts the architecture _**n** b_ = ( _M_ , 64, 64, 64, 64, _K_ ), with truncation orders _M_ ∈{20, 40, 60, 80, 100, 400} considered. Predictive accuracy is quantified using the relative test error 

**==> picture [291 x 34] intentionally omitted <==**

where _**F**_ and _**F**_[NN] are the FEM and DeepONet outputs, respectively. As shown in Fig. 3, the optimal truncation orders are _M_ = 40 for _uz_ and _M_ = 60 for _p_ , and we adopt these values for the remainder of the problem. 

**==> picture [435 x 213] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Vertical displacement  uz (b) Excess pore pressure p<br>0 . 4<br>0 . 2<br>0 . 2<br>0 . 1<br>0 . 1<br>0 . 05<br>0 . 05<br>20 40 60 80 400 20 40 60 80 400<br>Truncation order ( 𝑀 ) Truncation order ( 𝑀 )<br>RMSE on test dataset RMSE on test dataset<br>**----- End of picture text -----**<br>


Figure 3: Soil consolidation: Test RMSE for truncation orders _M_ ∈ {20, 40, 60, 80, 400} with (σκ, _lx_ , _lz_ ) = (1.5, 0.25, 0.125). Left: vertical displacement _uz_ . Right: excess pore pressure _p_ . 

To evaluate the robustness of the surrogate across different variability levels, we test the trained DeepONet surrogate models using the following permeability statistics: (σκ, _lx_ , _lz_ ) ∈{1.5, 1.0, 0.5}× {0.25, 0.5} × {0.125, 0.25}. Table 1 reports the resulting test RMSEs for both primary variables. As expected, prediction errors increase with stronger spatial variability and shorter correlation lengths. Excess pore pressure is consistently more difficult to approximate, reflecting its heightened sensitivity to fine-scale permeability features. 

To assess predictive accuracy in the domain, we compare DeepONet outputs to FEM solutions 

**==> picture [13 x 9] intentionally omitted <==**

||**Vertical displacement**(_uz_)<br>**Excess pore pressure**(_p_)|
|---|---|
||σκ =1.5<br>σκ =1.0<br>σκ =0.5<br>σκ =1.5<br>σκ =1.0<br>σκ =0.5|
|(_lx_,_lz_)=(0.25,0.125)<br>(_lx_,_lz_)=(0.25,0.25)<br>(_lx_,_lz_)=(0.5,0.125)<br>(_lx_,_lz_)=(0.5,0.25)|3.83×10−2<br>1.13×10−2<br>2.56×10−3<br>5.36×10−2<br>2.34×10−2<br>7.42×10−3<br>2.03×10−2<br>6.69×10−3<br>1.84×10−3<br>4.72×10−2<br>1.94×10−2<br>5.76×10−3<br>2.03×10−2<br>6.20×10−3<br>1.75×10−3<br>3.28×10−2<br>1.57×10−2<br>5.17×10−3<br>9.41×10−3<br>3.49×10−3<br>1.38×10−3<br>2.64×10−2<br>1.36×10−2<br>4.10×10−3|



Table 1: Soil consolidation: Test RMSE for various permeability statistics (σκ, _lx_ , _lz_ ). 

at _t_ = 0.1, 0.55, and 1.0, where _t_ = 0.55 is an interpolation point not seen during training. Figures 4 and 5 show predicted fields and pointwise absolute errors for two representative settings: high variance with short correlation lengths (σκ, _lx_ , _lz_ ) = (1.5, 0.25, 0.125) and low variance with long correlation lengths (σκ, _lx_ , _lz_ ) = (0.5, 0.5, 0.25). The results show that the surrogate accurately simulates both spatial and temporal variations across contrasting permeability regimes. 

We compare the computational efficiency of the DeepONet surrogate against the finite element baseline under the same hardware configuration used for data generation and training. The total FEM runtime for generating 8,000 training samples is 1.27 × 10[4] seconds. DeepONet training requires 7.03 × 10[2] seconds for vertical displacement _uz_ and 1.99 × 10[3] seconds for excess pore pressure _p_ . Once trained, inference is highly efficient, requiring less than 0.05 seconds per sample. To quantify the point at which surrogate modeling becomes advantageous, we define the crossover simulation count _Nc_ as 

**==> picture [279 x 30] intentionally omitted <==**

where _N_ tr denotes the number of training samples, _TF_ is the total FEM runtime, and _TT_ is the total training time for the DeepONet. The cost of inference and post-processing including QR decomposition is omitted due to their negligible contribution. Based on measured runtimes, the crossover thresholds are _Nc_ = 8, 442 for _uz_ and _Nc_ = 9, 246 for _p_ . These thresholds can be further reduced by decreasing the training size or optimizing network training [75]. 

## _4.2. Ground subsidence induced by groundwater extraction_ 

We next consider ground subsidence induced by groundwater extraction. The objective is to train DeepONet to predict the horizontal displacement _ux_ ( _**x**_ , _t_ ), vertical displacement _uz_ ( _**x**_ , _t_ ), and excess pore pressure _p_ ( _**x**_ , _t_ ). 

The spatial domain is defined as a rectangle of width _W_ and height _H_ , with _H_ = 0.1 _W_ , representing a laterally extensive confined aquifer. The domain consists of three horizontal layers: the top and bottom layers, each of thickness 0.3 _H_ , are assigned constant low permeability, while 

14 

**==> picture [407 x 552] intentionally omitted <==**

**----- Start of picture text -----**<br>
Log permeability Ground truth Prediction Absolute error<br>𝜅 𝑢𝑧 𝑢 [NN] 𝑧 | 𝑢𝑧 − 𝑢 [NN] 𝑧 [|]<br>𝑡 = 0 . 1<br>1<br>0 𝑡 = 0 . 55<br>0 −2<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>−1 −0 . 5 0 −1 −0 . 5 0 10 [−][5] 10 [−][2]<br>𝑡 = 0 . 1<br>1 0 . 5<br>0 𝑡 = 0 . 55<br>−0 . 5<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>−1 −0 . 5 0 −1 −0 . 5 0 10 [−][6] 10 [−][3]<br>𝑧<br>𝑧<br>**----- End of picture text -----**<br>


Figure 4: Soil consolidation: Comparison between FEM and DeepONet predictions for vertical displacement. Top: high variance and short correlation lengths (σκ, _lx_ , _lz_ ) = (1.5, 0.25, 0.125). Bottom: low variance and long correlation lengths (σκ, _lx_ , _lz_ ) = (0.5, 0.5, 0.25). 

15 

**==> picture [407 x 550] intentionally omitted <==**

**----- Start of picture text -----**<br>
Log permeability Ground truth Prediction Absolute error<br>𝜅 𝑝 𝑝 [NN] | 𝑝 − 𝑝 [NN] |<br>𝑡 = 0 . 1<br>1<br>0 𝑡 = 0 . 55<br>0 −2<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>0 0 . 5 1 0 0 . 5 1 10 [−][4] 10 [−][1]<br>𝑡 = 0 . 1<br>1 0 . 5<br>0 𝑡 = 0 . 55<br>−0 . 5<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>0 0 . 5 1 0 0 . 5 1 10 [−][5] 10 [−][2]<br>𝑧<br>𝑧<br>**----- End of picture text -----**<br>


Figure 5: Soil consolidation: Comparison between FEM and DeepONet predictions for excess pore pressure. Top: high variance and short correlation lengths (σκ, _lx_ , _lz_ ) = (1.5, 0.25, 0.125). Bottom: low variance and long correlation lengths (σκ, _lx_ , _lz_ ) = (0.5, 0.5, 0.25). 

16 

the middle layer, of thickness 0.4 _H_ , contains heterogeneous high-permeability fields. The mean log-permeability in the middle layer is set to be 3 units higher than that in the outer layers, consistent with typical contrasts between clay and sand formations [76, 77]. Zero initial stress and pressure conditions are assumed. The mechanical boundary conditions are specified as follows: zero traction on the top boundary, zero horizontal displacement and vertical traction on the lateral boundaries, and zero displacement on the bottom boundary. For hydraulic conditions, a constant specific discharge of magnitude _q_ 0 is prescribed on the left boundary of the middle layer. In addition, zero excess pore pressure is imposed on the top boundary, and zero discharge is applied on the remaining boundaries. The Poisson’s ratio is set as ν = 0.25. The problem is nondimensionalized in a way similar to the confined aquifer solution under plane stress presented in Section 5.5.6 of Verruijt [78]. Using _q_[∗] = _q_ 0 as the characteristic discharge, the scaling parameters are defined as 

**==> picture [406 x 31] intentionally omitted <==**

2(1−2ν)(1+ν) where _kd_ denotes the permeability at the fluid extraction boundary, _m_[′] _v_[=] _E_ , and _c_[′] _v_[=] _k_[∗] _E_ µ _f_ 2(1−2ν)(1+ν)[. The nondimensionalized problem setup is illustrated in Fig.][ 6][.] 

**==> picture [459 x 98] intentionally omitted <==**

**----- Start of picture text -----**<br>
𝑧 traction-free & drained<br>undrained<br>1 random permeability fields undrained 0.1<br>undrained<br>𝑥 undrained<br>1<br>**----- End of picture text -----**<br>


Figure 6: Ground subsidence: Problem setup in nondimensional form. 

We model random permeability fields using the K–L expansion with a Gaussian covariance function 

**==> picture [318 x 33] intentionally omitted <==**

where spatial variability is introduced only in the horizontal direction, in a way similar to the setup in Alghamdi _et al._ [76]. In the following, we consider (σκ, _lx_ ) = (1.5, 0.125) unless stated otherwise. We generate 10,000 samples of K–L expansion coefficients using LHS, allocating 8,000 samples for training and 2,000 for testing. For each sample, the corresponding realization of the log-permeability field is constructed via the K–L expansion using the specified statistical parameters (σκ, _lx_ ). The poroelastic forward problem is solved over the spatial domain Ω= {( _x_ , _z_ ) | 0 ≤ _x_ ≤ 1, 0 ≤ _z_ ≤ 0.1}, discretized with ∆ _x_ = 0.025 and ∆ _z_ = 0.01 on a structured triangular mesh. The temporal domain is defined as T = { _t_ | 0 < _t_ ≤ 1} and discretized with a 

17 

uniform time step ∆ _t_ = 0.01. 

The DeepONet surrogate model is constructed using the principal K–L expansion coefficients as input features for the branch network, following the setup in Section 4.1. The output consists of the evaluated primary variables at spatial nodes {( _xi_ , _zi_ ) | _xi_ ∈{0.0, 0.05, . . . , 0.95, 1.0}, _zi_ ∈ {0.0, 0.02, . . . , 0.10}} and temporal nodes _ti_ ∈{0.1, 0.2, . . . , 1.0}. For displacements, the architecture is set as _**n** t_ = (3, 64, 64, 64, 64), and for excess pore pressure, _**n** t_ = (3, 64, 64, 64, 128). The branch network is defined as _**n** b_ = ( _M_ , 64, 64, 64, 64, _K_ ), where _M_ is the number of retained K–L modes and _K_ is the dimension of the shared latent representation. We examine _M_ ∈ {15, 20, 25, 40, 80} and select the value that minimizes the RMSE on the test dataset. 

Figure 7 shows RMSE on the test dataset for each primary variable and truncation order _M_ . The results indicate that _M_ = 20 yields the lowest test error for all variables. This corresponds to one-quarter of the number of horizontal discretization points used for the log-permeability field κ. We adopt this truncation level for the remainder of the problem. 

**==> picture [451 x 142] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Horizontal displacement  ux (b) Vertical displacement  uz (c) Excess pore pressure p<br>0.015 0.03<br>0.023<br>0.012 0.025<br>0.020<br>0.017 0.009 0.02<br>15 20 25 40 80 15 20 25 40 80 15 20 25 40 80<br>Truncation order ( 𝑀 ) Truncation order ( 𝑀 ) Truncation order ( 𝑀 )<br>RMSE on test dataset RMSE on test dataset RMSE on test dataset<br>**----- End of picture text -----**<br>


Figure 7: Ground subsidence: Test RMSE for truncation orders _M_ ∈{15, 20, 25, 40, 80} for (σκ, _lx_ ) = (1.5, 0.125). Left: horizontal displacement _ux_ . Middle: vertical displacement _uz_ . Right: excess pore pressure _p_ . 

To evaluate the robustness of the surrogate across varying variability levels, we test the trained DeepONet surrogate models using the following permeability statistics: (σκ, _lx_ ) ∈{1.5, 1.0, 0.5} × {0.125, 0.25, 0.5}. Table 2 reports the resulting test RMSEs for every primary variable. Prediction errors tend to increase with stronger spatial variability and shorter correlation lengths. 

||**Horizontal displacement**(_ux_)<br>**Vertical displacement**(_uz_)<br>**Excess pore pressure**(_p_)|
|---|---|
||σκ =1.5<br>σκ =1.0<br>σκ =0.5<br>σκ =1.5<br>σκ =1.0<br>σκ =0.5<br>σκ =1.5<br>σκ =1.0<br>σκ =0.5|
|_lx_ =0.125<br>_lx_ =0.25<br>_lx_ =0.5|1.85×10−2<br>1.33×10−2<br>8.86×10−3<br>9.78×10−3<br>7.22×10−3<br>4.69×10−3<br>2.07×10−2<br>1.58×10−2<br>9.84×10−3<br>1.35×10−2<br>1.08×10−2<br>5.87×10−2<br>6.99×10−3<br>5.05×10−3<br>3.30×10−3<br>1.42×10−2<br>1.07×10−2<br>6.08×10−3<br>8.26×10−3<br>6.52×10−3<br>4.60×10−3<br>4.81×10−3<br>3.90×10−3<br>2.50×10−3<br>1.07×10−2<br>8.00×10−3<br>4.88×10−3|



Table 2: Ground subsidence: Test RMSE for various permeability statistics (σκ, _lx_ ). 

18 

To assess predictive accuracy in the domain, we compare DeepONet predictions to full-order FEM solutions at _t_ = 0.1, 0.55, and 1.0, where _t_ = 0.55 is an interpolation point not seen during training. Figures 8, 9, and 10 show the predicted fields and pointwise absolute errors for horizontal displacement _ux_ , vertical displacement _uz_ , and excess pore pressure _p_ , respectively. Two representative settings are considered: high variance with short correlation length (σκ, _lx_ ) = (1.5, 0.125) and low variance with long correlation length (σκ, _lx_ ) = (0.5, 0.5). Vertical exaggeration is applied to the displacement and excess pore pressure plots for visual clarity. The results confirm that the surrogate accurately captures both spatial and temporal variations across contrasting permeability regimes. 

We compare computational performance under the same hardware configuration used for data generation and model training. The FEM solver requires 6.58 × 10[3] seconds to generate 8,000 training samples. DeepONet training times are 1.11 × 10[3] seconds for _ux_ and _uz_ , and 1.18 × 10[3] seconds for _p_ . Inference time is less than 0.05 seconds per sample. Based on these measurements, the crossover thresholds, defined in Eq. (35), are _Nc_ = 9, 351 for _ux_ and _uz_ , and _Nc_ = 9, 432 for _p_ . 

## **5. Closure** 

In this paper, we have presented a DeepONet-based surrogate modeling framework for poroelasticity with spatially variable permeability. The model learns the solution operator mapping realizations of the permeability field to transient displacement and pressure responses. To enhance generalization and stability, the framework incorporates nondimensionalization, input compression via truncated K–L expansion, and a two-stage training procedure that decouples the branch and trunk networks. The surrogate was evaluated on two benchmark problems: soil consolidation under mechanical loading and ground subsidence due to hydraulic extraction. In both cases, the model achieved high predictive accuracy across a range of permeability statistics and provided significant computational speedups relative to full-order finite element simulations. These results highlight the potential of operator learning to accelerate forward modeling in poroelasticity involving spatial random permeability fields. 

Despite these favorable results, several limitations remain. The use of K–L truncation, while effective for fields with rapid spectral decay, may be less suitable for input permeability fields characterized by slow-decaying spectra, such as those defined by exponential covariance kernels. Also, in its current form, the framework assumes fixed mechanical parameters and a single statistical configuration per network, necessitating retraining for each new setting. Generalization across broader parametric spaces may be achieved through multi-input operator networks [79], which enable the inclusion of both mechanical and statistical parameters as inputs. In addition, incorporating architecture-level constraints or physics-informed training objectives may further improve robustness and promote physical consistency. These directions will be pursued in future work. 

19 

**==> picture [407 x 548] intentionally omitted <==**

**----- Start of picture text -----**<br>
Log permeability Ground truth Prediction Absolute error<br>𝜅 𝑢 𝑥 𝑢 [NN] 𝑥 | 𝑢 𝑥 − 𝑢 [NN] 𝑥 [|]<br>𝑡 = 0 . 1<br>0 . 1 1<br>0<br>−1 𝑡 = 0 . 55<br>−2<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.02 0 -0.02 0 10 [−][6] 10 [−][4]<br>𝑡 = 0 . 1<br>0 . 1 0<br>−1<br>𝑡 = 0 . 55<br>−2<br>−3<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.02 0 -0.02 0 10 [−][7] 10 [−][4]<br>𝑧<br>𝑧<br>**----- End of picture text -----**<br>


Figure 8: Ground subsidence: Comparison between FEM and DeepONet predictions for horizontal displacement _ux_ . Top: high variance and short correlation length (σκ, _lx_ ) = (1.5, 0.125). Bottom: low variance and long correlation length (σκ, _lx_ ) = (0.5, 0.5). 

20 

**==> picture [407 x 550] intentionally omitted <==**

**----- Start of picture text -----**<br>
Log permeability Ground truth Prediction Absolute error<br>𝜅 𝑢𝑧 𝑢 [NN] 𝑧 | 𝑢𝑧 − 𝑢 [NN] 𝑧 [|]<br>𝑡 = 0 . 1<br>0 . 1 1<br>0<br>−1 𝑡 = 0 . 55<br>−2<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.1 0 -0.1 0 10 [−][6] 10 [−][4]<br>𝑡 = 0 . 1<br>0 . 1 0<br>−1<br>𝑡 = 0 . 55<br>−2<br>−3<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.1 0 -0.1 0 10 [−][7] 10 [−][4]<br>𝑧<br>𝑧<br>**----- End of picture text -----**<br>


Figure 9: Ground subsidence: Comparison between FEM and DeepONet predictions for vertical displacement _uz_ . Top: high variance and short correlation length (σκ, _lx_ ) = (1.5, 0.125). Bottom: low variance and long correlation length (σκ, _lx_ ) = (0.5, 0.5). 

21 

**==> picture [407 x 550] intentionally omitted <==**

**----- Start of picture text -----**<br>
Log permeability Ground truth Prediction Absolute error<br>𝜅 𝑝 𝑝 [NN] | 𝑝 − 𝑝 [NN] |<br>𝑡 = 0 . 1<br>0 . 1 1<br>0<br>−1 𝑡 = 0 . 55<br>−2<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.3 0 -0.3 0 10 [−][6] 10 [−][3]<br>𝑡 = 0 . 1<br>0 . 1 0<br>−1<br>𝑡 = 0 . 55<br>−2<br>−3<br>0<br>0 1<br>𝑥<br>𝑡 = 1 . 0<br>-0.3 0 -0.3 0 10 [−][7] 10 [−][3]<br>𝑧<br>𝑧<br>**----- End of picture text -----**<br>


Figure 10: Ground subsidence: Comparison between FEM and DeepONet predictions for excess pore pressure _p_ . Top: high variance and short correlation length (σκ, _lx_ ) = (1.5, 0.125). Bottom: low variance and long correlation length (σκ, _lx_ ) = (0.5, 0.5). 

22 

## **Acknowledgments** 

This work was supported by the National Research Foundation of Korea (NRF) grant funded by the Korean government (MSIT) (No. RS-2023-00209799). The authors wish to thank Prof. Andy Y.F. Leung and Prof. Taeyong Kim for valuable discussions and insights. 

## **Data Availability Statement** 

The data that support the findings of this study are available from the corresponding author upon reasonable request. 

## **References** 

- [1] M. Ferronato, G. Gambolati, C. Janna, P. Teatini, Numerical modelling of regional faults in land subsidence prediction above gas/oil reservoirs, International Journal for Numerical and Analytical Methods in Geomechanics 32 (6) (2008) 633–657. 

- [2] N. Castelletto, G. Gambolati, P. Teatini, A coupled MFE poromechanical model of a largescale load experiment at the coastland of Venice, Computational Geosciences 19 (2015) 17– 29. 

- [3] L. Chiaramonte, J. A. White, W. Trainor-Guitton, Probabilistic geomechanical analysis of compartmentalization at the Snøhvit CO2 sequestration project, Journal of Geophysical Research: Solid Earth 120 (2) (2015) 1195–1209. 

- [4] K. W. Chang, P. Segall, Injection-induced seismicity on basement faults including poroelastic stressing, Journal of Geophysical Research: Solid Earth 121 (4) (2016) 2708–2726. 

- [5] R. R. Settgast, P. Fu, S. D. Walsh, J. A. White, C. Annavarapu, F. J. Ryerson, A fully coupled method for massively parallel simulation of hydraulically driven fractures in 3-dimensions, International Journal for Numerical and Analytical Methods in Geomechanics 41 (5) (2017) 627–653. 

- [6] J. Choo, Large deformation poromechanics with local mass conservation: An enriched Galerkin finite element framework, International Journal for Numerical Methods in Engineering 116 (1) (2018) 66–90. 

- [7] Z. Fan, P. Eichhubl, P. Newell, Basement fault reactivation by fluid injection into sedimentary reservoirs: Poroelastic effects, Journal of Geophysical Research: Solid Earth 124 (7) (2019) 7354–7369. 

23 

- [8] Y. Zhao, J. Choo, Stabilized material point methods for coupled large deformation and fluid flow in porous materials, Computer Methods in Applied Mechanics and Engineering 362 (2020) 112742. 

- [9] F. Fei, A. Costa, J. E. Dolbow, R. R. Settgast, M. Cusini, A phase-field model for hydraulic fracture nucleation and propagation in porous media, International Journal for Numerical and Analytical Methods in Geomechanics 47 (16) (2023) 3065–3089. 

- [10] F. Fei, J. Choo, Crack opening calculation in phase-field modeling of fluid-filled fracture: A robust and efficient strain-based method, Computers and Geotechnics 177 (2025) 106890. 

- [11] L. Smith, R. A. Freeze, Stochastic analysis of steady state groundwater flow in a bounded domain: 2. Two-dimensional simulations, Water Resources Research 15 (6) (1979) 1543– 1559. 

- [12] K. R. Rehfeldt, J. M. Boggs, L. W. Gelhar, Field study of dispersion in a heterogeneous aquifer: 3. Geostatistical analysis of hydraulic conductivity, Water Resources Research 28 (12) (1992) 3309–3324. 

- [13] D. Griffiths, G. A. Fenton, Seepage beneath water retaining structures founded on spatially random soil, Géotechnique 43 (4) (1993) 577–587. 

- [14] T. Elkateb, R. Chalaturnyk, P. K. Robertson, An overview of soil heterogeneity: quantification and implications on geotechnical field problems, Canadian Geotechnical Journal 40 (1) (2003) 1–15. 

- [15] G. B. Baecher, J. T. Christian, Reliability and Statistics in Geotechnical Engineering, John Wiley & Sons, 2005. 

- [16] G. A. Fenton, D. V. Griffiths, Risk Assessment in Geotechnical Engineering, John Wiley & Sons New York, 2008. 

- [17] P. K. Kang, J. Lee, X. Fu, S. Lee, P. K. Kitanidis, R. Juanes, Improved characterization of heterogeneous permeability in saline aquifers from transient pressure data during freshwater injection, Water Resources Research 53 (5) (2017) 4444–4458. 

- [18] E. Vanmarcke, Random Fields: Analysis and Synthesis, MIT Press, 1983. 

- [19] J. Huang, D. Griffiths, G. A. Fenton, Probabilistic analysis of coupled soil consolidation, Journal of Geotechnical and Geoenvironmental Engineering 136 (3) (2010) 417–430. 

24 

- [20] Y. Cheng, L. Zhang, J. Li, L. M. Zhang, J. Wang, D. Wang, Consolidation in spatially random unsaturated soils based on coupled flow-deformation simulation, International Journal for Numerical and Analytical Methods in Geomechanics 41 (5) (2017) 682–706. 

- [21] F. Wang, H. Huang, Z. Yin, Q. Huang, Probabilistic characteristics analysis for the timedependent deformation of clay soils due to spatial variability, European Journal of Environmental and Civil Engineering 26 (12) (2022) 6096–6114. 

- [22] D. G. Frias, M. A. Murad, F. Pereira, Stochastic computational modelling of highly heterogeneous poroelastic media with long-range correlations, International Journal for Numerical and Analytical Methods in Geomechanics 28 (1) (2004) 1–32. 

- [23] M. Ferronato, G. Gambolati, P. Teatini, D. Baù, Stochastic poromechanical modeling of anthropogenic land subsidence, International Journal of Solids and Structures 43 (11-12) (2006) 3324–3336. 

- [24] S. J. Wang, C. H. Lee, K. C. Hsu, A technique for quantifying groundwater pumping and land subsidence using a nonlinear stochastic poroelastic model, Environmental Earth Sciences 73 (2015) 8111–8124. 

- [25] S. Deng, H. Yang, X. Chen, X. Wei, Probabilistic analysis of land subsidence due to pumping by Biot poroelasticity and random field theory, Journal of Engineering and Applied Science 69 (1) (2022) 18. 

- [26] A. Alghamdi, M. A. Hesse, J. Chen, U. Villa, O. Ghattas, Bayesian poroelastic aquifer characterization from InSAR surface deformation data. 2. Quantifying the uncertainty, Water Resources Research 57 (11) (2021) e2021WR029775. 

- [27] H. M. Tian, Z. J. Cao, D. Q. Li, W. Du, F. P. Zhang, Efficient and flexible Bayesian updating of embankment settlement on soft soils based on different monitoring datasets, Acta Geotechnica (2022) 1–22. 

- [28] H. Tian, Y. Wang, Data-driven and physics-informed Bayesian learning of spatiotemporally varying consolidation settlement from sparse site investigation and settlement monitoring data, Computers and Geotechnics 157 (2023) 105328. 

- [29] D. Xiu, G. E. Karniadakis, Modeling uncertainty in steady state diffusion problems via generalized polynomial chaos, Computer Methods in Applied Mechanics and Engineering 191 (43) (2002) 4927–4948. 

25 

- [30] T. Bui-Thanh, K. Willcox, O. Ghattas, Model reduction for large-scale systems with highdimensional parametric input space, SIAM Journal on Scientific Computing 30 (6) (2008) 3270–3288. 

- [31] B. Sudret, Polynomial chaos expansions and stochastic finite element methods, Risk and Reliability in Geotechnical Engineering (2014) 265–300. 

- [32] B. Peherstorfer, K. Willcox, Dynamic data-driven reduced-order models, Computer Methods in Applied Mechanics and Engineering 291 (2015) 21–41. 

- [33] R. Swischuk, L. Mainini, B. Peherstorfer, K. Willcox, Projection-based model reduction: Formulations for physics-based machine learning, Computers & Fluids 179 (2019) 704–717. 

- [34] H. Sharma, L. Novák, M. Shields, Physics-constrained polynomial chaos expansion for scientific machine learning and uncertainty quantification, Computer Methods in Applied Mechanics and Engineering 431 (2024) 117314. 

- [35] T. Bong, Y. Son, S. Noh, J. Park, Probabilistic analysis of consolidation that considers spatial variability using the stochastic response surface method, Soils and Foundations 54 (5) (2014) 917–926. 

- [36] T. Bong, A. W. Stuedlein, Efficient methodology for probabilistic analysis of consolidation considering spatial variability, Engineering Geology 237 (2018) 53–63. 

- [37] Z. L. Jin, T. Garipov, O. Volkov, L. J. Durlofsky, Reduced-order modeling of coupled flow and quasistatic geomechanics, SPE Journal 25 (01) (2020) 326–346. 

- [38] S. Mo, Y. Zhu, N. Zabaras, X. Shi, J. Wu, Deep convolutional encoder-decoder networks for uncertainty quantification of dynamic multiphase flow in heterogeneous media, Water Resources Research 55 (1) (2019) 703–728. 

- [39] T. Kadeethum, D. O’Malley, J. N. Fuhg, Y. Choi, J. Lee, H. S. Viswanathan, N. Bouklas, A framework for data-driven solution and parameter estimation of PDEs using conditional generative adversarial networks, Nature Computational Science 1 (12) (2021) 819–829. 

- [40] B. Bahmani, I. G. Kevrekidis, M. D. Shields, Neural chaos: A spectral stochastic neural operator, arXiv preprint arXiv:2502.11835 (2025). 

- [41] M. Tang, X. Ju, L. J. Durlofsky, Deep-learning-based coupled flow-geomechanics surrogate model for CO2 sequestration, International Journal of Greenhouse Gas Control 118 (2022) 103692. 

26 

- [42] H. Tang, P. Fu, H. Jo, S. Jiang, C. S. Sherman, F. Hamon, N. A. Azzolina, J. P. Morris, Deep learning-accelerated 3D carbon storage reservoir pressure forecasting based on data assimilation using surface displacement from InSAR, International Journal of Greenhouse Gas Control 120 (2022) 103765. 

- [43] Y. Han, F. P. Hamon, S. Jiang, L. J. Durlofsky, Surrogate model for geological CO2 storage and its use in hierarchical MCMC history matching, Advances in Water Resources 187 (2024) 104678. 

- [44] Y. Han, F. P. Hamon, L. J. Durlofsky, Accelerated training of deep learning surrogate models for surface displacement and flow, with application to MCMC-based history matching of CO2 storage operations, Geoenergy Science and Engineering 246 (2025) 213589. 

- [45] T. Kadeethum, D. O’Malley, Y. Choi, H. S. Viswanathan, N. Bouklas, H. Yoon, Continuous conditional generative adversarial networks for data-driven solutions of poroelasticity with heterogeneous material properties, Computers & Geosciences 167 (2022) 105212. 

- [46] D. Saxena, J. Cao, Generative adversarial networks (GANs) challenges, solutions, and future directions, ACM Computing Surveys (CSUR) 54 (3) (2021) 1–42. 

- [47] L. Lu, P. Jin, G. Pang, Z. Zhang, G. E. Karniadakis, Learning nonlinear operators via DeepONet based on the universal approximation theorem of operators, Nature Machine Intelligence 3 (3) (2021) 218–229. 

- [48] T. Chen, H. Chen, Universal approximation to nonlinear operators by neural networks with arbitrary activation functions and its application to dynamical systems, IEEE Transactions on Neural Networks 6 (4) (1995) 911–917. 

- [49] S. Lee, Y. Shin, On the training and generalization of deep operator networks, SIAM Journal on Scientific Computing 46 (4) (2024) C273–C296. 

- [50] R. I. Borja, E. Alarcón, A mathematical framework for finite strain elastoplastic consolidation Part 1: Balance laws, variational formulation, and linearization, Computer Methods in Applied Mechanics and Engineering 122 (1-2) (1995) 145–171. 

- [51] J. A. White, R. I. Borja, Stabilized low-order finite elements for coupled soliddeformation/fluid-diffusion and their application to fault zone transients, Computer Methods in Applied Mechanics and Engineering 197 (49-50) (2008) 4353–4366. 

- [52] W. Sun, J. T. Ostien, A. G. Salinger, A stabilized assumed deformation gradient finite element formulation for strongly coupled poromechanical simulations at finite strain, International Journal for Numerical and Analytical Methods in Geomechanics 37 (16) (2013) 2755–2788. 

27 

- [53] R. I. Borja, J. Choo, Cam-Clay plasticity, Part VIII: A constitutive framework for porous materials with evolving internal structure, Computer Methods in Applied Mechanics and Engineering 309 (2016) 653–679. 

- [54] J. Choo, J. A. White, R. I. Borja, Hydromechanical modeling of unsaturated flow in double porosity media, International Journal of Geomechanics 16 (6) (2016) D4016002. 

- [55] W. Sun, Z. Cai, J. Choo, Mixed arlequin method for multiscale poromechanics problems, International Journal for Numerical Methods in Engineering 111 (7) (2017) 624–659. 

- [56] J. Choo, Stabilized mixed continuous/enriched Galerkin formulations for locally mass conservative poromechanics, Computer Methods in Applied Mechanics and Engineering 357 (2019) 112568. 

- [57] D. J. DeGroot, G. B. Baecher, Estimating autocovariance of in-situ soil properties, Journal of Geotechnical Engineering 119 (1) (1993) 147–166. 

- [58] S. Firouzianbandpey, D. Griffiths, L. B. Ibsen, L. V. Andersen, Spatial correlation length of normalized cone data in sand: case study in the north of Denmark, Canadian Geotechnical Journal 51 (8) (2014) 844–857. 

- [59] W. F. Liu, Y. F. Leung, M. K. Lo, Integrated framework for characterization of spatial variability of geological profiles, Canadian Geotechnical Journal 54 (1) (2017) 47–58. 

- [60] W. F. Liu, Y. F. Leung, Characterising three-dimensional anisotropic spatial correlation of soil properties through in situ test results, Géotechnique 68 (9) (2018) 805–819. 

- [61] D. Amini, E. Haghighat, R. Juanes, Physics-informed neural network solution of thermo– hydro–mechanical processes in porous media, Journal of Engineering Mechanics 148 (11) (2022) 04022070. 

- [62] E. Haghighat, D. Amini, R. Juanes, Physics-informed neural network simulation of multiphase poroelasticity using stress-split sequential training, Computer Methods in Applied Mechanics and Engineering 397 (2022) 115141. 

- [63] X. Xie, A. Samaei, J. Guo, W. K. Liu, Z. Gan, Data-driven discovery of dimensionless numbers and governing laws from scarce measurements, Nature Communications 13 (1) (2022) 7562. 

- [64] L. Wang, Karhunen–Loeve Expansions and Their Applications, London School of Economics and Political Science (United Kingdom), 2008. 

28 

- [65] P. Rathore, W. Lei, Z. Frangella, L. Lu, M. Udell, Challenges in training PINNs: A loss landscape perspective, arXiv preprint arXiv:2402.01868 (2024). 

- [66] I. Loshchilov, Decoupled weight decay regularization, arXiv preprint arXiv:1711.05101 (2017). 

- [67] D. C. Liu, J. Nocedal, On the limited memory BFGS method for large scale optimization, Mathematical Programming 45 (1) (1989) 503–528. 

- [68] M. Blondel, Q. Berthet, M. Cuturi, R. Frostig, S. Hoyer, F. Llinares-López, F. Pedregosa, J. P. Vert, Efficient and Modular Implicit Differentiation, arXiv preprint arXiv:2105.15183 (2021). 

- [69] M. S. Alnæs, A. Logg, K. B. Ølgaard, M. E. Rognes, G. N. Wells, Unified form language: A domain-specific language for weak formulations of partial differential equations, ACM Transactions on Mathematical Software (TOMS) 40 (2) (2014) 1–37. 

- [70] I. A. Barrata, J. P. Dean, J. S. Dokken, M. Habera, J. HALE, C. Richardson, M. E. Rognes, M. W. Scroggs, N. Sime, G. N. Wells, DOLFINx: The next generation FEniCS problem solving environment (2023). 

- [71] J. Bradbury, R. Frostig, P. Hawkins, M. J. Johnson, C. Leary, D. Maclaurin, G. Necula, A. Paszke, J. VanderPlas, S. Wanderman-Milne, Q. Zhang, JAX: composable transformations of Python+NumPy programs (2018). URL `http://github.com/jax-ml/jax` 

- [72] J. Heek, A. Levskaya, A. Oliver, M. Ritter, B. Rondepierre, A. Steiner, M. van Zee, Flax: A neural network library and ecosystem for JAX (2024). URL `http://github.com/google/flax` 

- [73] K. K. Phoon, F. H. Kulhawy, Characterization of geotechnical variability, Canadian Geotechnical Journal 36 (4) (1999) 612–624. 

- [74] M. D. McKay, R. J. Beckman, W. J. Conover, A comparison of three methods for selecting values of input variables in the analysis of output from a computer code, Technometrics 42 (1) (2000) 55–61. 

- [75] M. Ainsworth, Y. Shin, Active Neuron Least Squares: A training method for multivariate rectified neural networks, SIAM Journal on Scientific Computing 44 (4) (2022) A2253– A2275. 

29 

- [76] A. Alghamdi, M. A. Hesse, J. Chen, O. Ghattas, Bayesian poroelastic aquifer characterization from InSAR surface deformation data. Part I: Maximum a posteriori estimate, Water Resources Research 56 (10) (2020) e2020WR027391. 

- [77] R. Haagenson, H. Rajaram, J. Allen, A generalized poroelastic model using FEniCS with insights into the Noordbergum effect, Computers & Geosciences 135 (2020) 104399. 

- [78] A. Verruijt, Theory and Problems of Poroelasticity, 2016. URL `https://geo.verruijt.net/` 

- [79] P. Jin, S. Meng, L. Lu, MIONet: Learning multiple-input operators via tensor product, SIAM Journal on Scientific Computing 44 (6) (2022) A3490–A3514. 

30 

