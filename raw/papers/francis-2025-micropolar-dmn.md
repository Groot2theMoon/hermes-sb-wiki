---
title: "Micropolar deep material network"
journal: "Computer Methods in Applied Mechanics and Engineering (2025), Vol. 446, Part B, 118329, DOI: 10.1016/j.cma.2025.118329"
authors:
  - "Noah M. Francis"
  - "Dongil Shin"
  - "Ricardo A. Lebensohn"
  - "Fatemeh Pourahmadian"
  - "Remi Dingreville"
year: 2025
source: paper
ingested: 2026-05-05
sha256: 35f395cb1e1f63bf67ab244b116b6d58a14adc3c49012819c1c6178345dc0c1b
conversion: pymupdf4llm
---
## **LA-UR-25-23992 Accepted Manuscript** 

## **Micropolar deep material network** 

Francis, Noah Shin, Dongil Lebensohn, Ricardo A. Purahmadian, Fatemeh Dingreville, Rémi 

Provided by the author(s) and the Los Alamos National Laboratory (1930-01-01). **To be published in:** Computer Methods in Applied Mechanics and Engineering **DOI to publisher's version:** 10.1016/j.cma.2025.118329 

## **Permalink to record:** 

https://permalink.lanl.gov/object/view?what=info:lanl-repo/lareport/LA-UR-25-23992 

**==> picture [132 x 26] intentionally omitted <==**

**==> picture [81 x 24] intentionally omitted <==**

**==> picture [52 x 52] intentionally omitted <==**

Los Alamos National Laboratory, an affirmative action/equal opportunity employer, is operated by Triad National Security, LLC for the National Nuclear Security Administration of U.S. Department of Energy under contract 89233218CNA000001.  By approving this article, the publisher recognizes that the U.S. Government retains nonexclusive, royalty-free license to publish or reproduce the published form of this contribution, or to allow others to do so, for U.S. Government purposes. Los Alamos National Laboratory requests that the publisher identify this article as work performed under the auspices of the U.S. Department of Energy.  Los Alamos National Laboratory strongly supports academic freedom and a researcher's right to publish; as an institution, however, the Laboratory does not endorse the viewpoint of a publication or guarantee its technical correctness. 

Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329 

**==> picture [60 x 66] intentionally omitted <==**

Contents lists available at ScienceDirect 

## Comput. Methods Appl. Mech. Engrg. 

journal homepage: www.elsevier.com/locate/cma 

**==> picture [53 x 73] intentionally omitted <==**

## Micropolar deep material network 

Noah M. Francis a,b, Dongil Shin b,c, Ricardo A. Lebensohn d, Fatemeh Pourahmadian[a][,][e] , Rémi Dingreville b,∗ 

a _Department of Civil, Environmental & Architectural Engineering, University of Colorado Boulder, Boulder, CO, USA_ 

b _Center for Integrated Nanotechnologies, Sandia National Laboratories, Albuquerque, NM, USA_ 

c _Mechanical Engineering, Pohang University of Science and Technology, Pohang-si, Gyeongbuk, Republic of Korea_ d _Theoretical Division, Los Alamos National Laboratory, Los Alamos, NM, USA_ 

e _Department of Applied Mathematics, University of Colorado Boulder, Boulder, CO, USA_ 

## a r t i c l e i n f o a b s t r a c t 

> _Keywords:_ This study extends the Deep Material Network (DMN), a physics-informed machine learning 

> Micropolar framework, to predict the homogenized mechanical response of composite materials with micropDeep material network olar (Cosserat-type) constitutive behavior. This extension incorporates microstructure-dependent 

> Composites size effects, enabling accurate, efficient, and size-aware predictions for composites with complex Homogenization Size effect internal architectures. While traditional, direct numerical simulation micropolar models effectively capture size effects by introducing extra local degrees of freedom, they bring significant computational challenges, particularly for multiscale analyses relevant to engineering applications. The micropolar DMN developed in this paper achieves high accuracy while significantly reducing computation time compared to micropolar direct numerical simulations. This advancement enables multiscale analyses and parameter studies that were previously impractical, such as high-cycle fatigue simulations and comprehensive investigations of internal length scale effects notably in size-dependent plastic response and the optimization of lattice structures. By uniting microstructure-sensitive modeling, physics-driven learning, and scalable surrogate modeling, the micropolar DMN paves the way for accelerated material design, large-scale parametric studies, and the reliable incorporation of size-dependent effects across a wide range of engineering applications, including optimization and next-generation composite design. 

## **1. Introduction** 

Computational modeling of heterogeneous solids is a powerful tool for material optimization, yet its full potential emerges when augmented by modern computational advancements. By integrating machine learning (ML) techniques, particularly physics-informed neural networks and data-efficient surrogate models, researchers can transcend traditional trial-and-error approaches, accelerating the discovery of novel materials with tailored properties. This synergy enables models to resolve microstructural complexities while maintaining computational tractability – a critical requirement for exploring vast design spaces. Within this paradigm, this paper introduces a microstructure-aware, physics-informed machine learning framework to explicitly account for microstructure-dependent size effects in composite materials. 

Size effect, described by Bažant[1] as “the change of response when the spatial dimensions are scaled up or down while the geometry and all other characteristics are preserved,” cannot be captured by traditional theories that express the material’s behavior 

## ∗ Corresponding author. 

_E-mail addresses:_ fatemeh.pourahmadian@colorado.edu (F. Pourahmadian), rdingre@sandia.gov (R. Dingreville). 

https://doi.org/10.1016/j.cma.2025.118329 

Received 19 March 2025; Received in revised form 15 August 2025; Accepted 15 August 2025 Available online 23 August 2025 

0045-7825/© 2025 The Author(s). Published by Elsevier B.V. This is an open access article under the CC BY-NC license ( http://creativecommons.org/licenses/by-nc/4.0/ ). 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

(e.g., a failure criterion) only in terms of stress and strain. This category includes the classical theories of elasticity and elastoplasticity [2,3]. However, size effects can be captured by the elastic micropolar theory of the Cosserat brothers [4] and [5,6], as well as its elastoplastic extensions [7–15]. While size effect is a non-local phenomenon [16–19], the micropolar equations are conveniently local. This is because a micropolar continuum has material points representing finite underlying microstructures through the assignment of extra degrees of freedom [20]. Therefore, micropolar formulations represent a convenient choice to capture size effects in composites. However, even after adopting this minimalist modeling approach, there exists computational challenges due to the micropolar model’s extra degrees of freedom (when compared to the classical Cauchy model). In two-dimensional (2D) problems, micropolar models have three degrees of freedom per material point (2 displacements + 1 micro-rotation) and classical models have two, while in threedimensional (3D) problems, micropolar models have six degrees of freedoms per material point (3 displacements + 3 micro-rotations) and classical models have three. It is worth noting that there exist other generalized continuum models – called micromorphic – which contain micropolar as a special case by adding even more degrees of freedom at a point [21,22]. 

Most of the existing computational homogenization methods used for composites with complex microstructures lack numerical efficiency when scaled up for use in problems of practical interest, see recent review papers [23,24]. Examples include the widely used finite element (FE) method [25], which requires the inversion of a global stiffness matrix; and the increasingly popular fast Fourier transform (FFT)-based method [26–32], an iterative scheme that requires calculation of FFTs of micromechanical tensorial fields at every iteration. Multiscale couplings of these methods such as the FE[2] [33–37] and the FE-FFT [38–42] methods are also computationally expensive since they are FE calculations in which every Gauss point requires a separate FE or FFT computation, respectively. All of these methods require the computation of local mechanical fields to find the corresponding effective material behavior, which causes the computational cost to increase rapidly for larger problems. This efficiency limitation is made even worse if micropolar models are leveraged due to the larger number of degrees of freedom. 

In the past decade, reduced-order and surrogate ML models have emerged as viable alternative methods, enabling efficient simulations of complex systems by approximating high-fidelity models at a fraction of the computational cost [43–46]. These approaches enable efficient simulations of complex materials, making large-scale and multiscale analyses more practical. However, their reliability collapses when applied to constitutive behaviors and/or boundary conditions not seen during the training phase. These models require a systematic retraining for such conditions – a critical limitation for applications involving optimization or arbitrary loading conditions. The Deep Material Network (DMN) approach, originally proposed by Liu et al.[47], stands out for its ability to accelerate computations and extrapolate to constitutive behaviors or boundary conditions beyond the training data. At its core, DMN uses a hierarchical network structure composed of simple micromechanics building blocks to model complex material behaviors at multiple scales. Unlike traditional neural networks, those DMN building blocks are formulated based on simple homogenization formulas such that the weights and biases have micromechanical interpretations. DMN can be viewed as a rank- _𝐿_ laminate microstructure with binary tree network connectivity (where _𝐿_ stands for the number of layers in the network), see the multiple-rank laminate theory of Milton and coworkers [48,49]. For a single geometry, a DMN is trained on linear elastic direct numerical simulation (DNS) homogenized data generated with either FE or FFT-based methods. As mentioned above, the real power of this approach is that the DMN can predict the effective response of the trained-on geometry under different conditions (including material nonlinearities and boundary conditions) without retraining. The practical advantage is that generating the training data in the linear context is much simpler than in the nonlinear context. The DMN has shown to be an efficient alternative to FE and FFT-based methods for numerical homogenization [50–55], including an efficient replacement for the expensive FE[2] and FE-FFT methods through alternative FE-DMN implementations [56,57]. 

In this paper, we formulate, implement, and verify an extension of the DMN framework to micropolar mechanics to address the challenges associated with continuum-level modeling of composites with size effects. For our methods, we first recall the geometrically linearized kinematics, the quasi-static balance equations for a micropolar continuum, and the elastic and elastoplastic constitutive equations in Section 2.1. In Section 2.2 we describe how the training data is generated from DNS for a given microstructure, while Section 2.3 provides a description of the building block function, network architecture, and cost function, for the case of the micropolar DMN. Section 2.4 describes the method by which one can use a trained micropolar DMN to extrapolate to different constitutive behaviors. We then verify and apply our micropolar DMN to various size-dependent problems. First, the training of the micropolar DMN across different random initializations in Section 3.1 is shown to assert its ability to predict micropolar elastic problems. We then demonstrate that the micropolar DMN may be used to extrapolate the training dataset within the same constitutive model in Section 3.2.1. In Section 3.2.2, we present two verifications of the micropolar DMN’s extrapolation to micropolar elastoplasticity by comparing to FFT-based DNS results, including high-cycle fatigue simulations. Finally, in Section 3.2.3 we show the micropolar DMN in action predicting the effective behavior of size-dependent composites, including size-dependent plastic response and the optimization of lattice structures. 

## _1.1. Notation_ 

In what follows, we adopt Einstein’s summation convention over lowered italic Latin indices ∈{1 _,_ 2}, unless otherwise stated. 

## **2. Methods** 

Fig. 1 shows an overview of the proposed DMN micropolar extension. The standard approach to build a DMN consists of several steps. First, the network has to be trained using a dataset generated from DNS of the linear elastic equilibrium equations for a given composite geometry and for different properties of the phases (this step is called _offline training_ ). Then, the trained network may be 

2 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [464 x 296] intentionally omitted <==**

**Fig. 1.** _Overview of the micropolar deep material network (DMN)._ **a** Micropolar direct numerical simulations (DNS) can be used to predict the response of heterogeneous media. **b** Micropolar DNS is used to generate a large training dataset of effective micropolar elastic properties ( **A** _[̄] ,_ **B** _[̄]_ ). **c** The training dataset is used to train the micropolar DMN in the so-called _offline training_ . In that case, the micropolar DMN is trained to predict the effective micropolar properties **A** _[̄] ,_ **B** _[̄]_ as a function of the constituents micropolar properties ( **A**[1] _,_ **B**[1] ) _,_ ( **A**[2] _,_ **B**[2] ). **d** The network can be exercised as a reduced-order model for _online prediction_ and predict constitutive behavior outside the training data. 

used to make predictions for composites of the same topology (i.e., spatial distribution of phases) with more general constitutive behavior (this step is called _online prediction_ ). This extrapolation is possible because the DMN is built using a variety of physics-based (elastic) training data, learning mechanical-interactions parameters from the topology of the composite. In our approach, we used a micropolar FFT-based DNS solver in the first step to generate the training dataset (Fig. 1 **a** and Section 2.1). To do this, we ran the DNS over many instances to get the homogenized (micropolar) stiffness tensors for different values of the stiffness tensors of the phases (Fig. 1 **b** and Section 2.2). This data was then used to train the micropolar DMN, based on two-phase linear elastic micropolar laminate homogenization formulas (Fig. 1 **c** and Section 2.3). In turn, this trained micropolar DMN can be used to predict responses beyond those of its training dataset, including those resulting from material nonlinearities (Fig. 1 **d** and Section 2.4). 

## _2.1. Micropolar mechanics and DNS_ 

Fig. 2 shows the different kinematic assumptions made and degrees of freedom for composite materials whose constitutive behaviors are described by classical Cauchy and micropolar theories, respectively. Note that in the following, we limit our analysis to the 2D plane strain case for simplicity, but all insights and equations derived can be easily generalized to 3D. Fig. 2 **a** illustrates a Cauchy composite. The two phases (colored black and grey, for interpretation of the references to color, the reader is referred to the web version of this article) are assumed to be continuous with perfect interfaces. In that case, small differential area elements (i.e., d _𝑎_ 1, d _𝑎_ 2, etc.) with no underlying microstructure only need to be assigned displacement vectors describing how their centers of mass translate. In contrast, Fig. 2 **b** shows a micropolar composite. As in the previous case, the two phases (colored orange and yellow, for interpretation of the references to color, the reader is referred to the web version of this article) are assumed to be continuous with perfect interfaces, but, in this case, the orange and yellow micropolar phases are homogenized continuum approximations of two different lower length-scale Cauchy composite microstructures. Consequently, differential area elements now represent finite microstructures (called _micro-elements_ ). The underlying Cauchy displacement field is then decomposed into displacements of the centers of mass of the micro-elements, and rotations of the micro-elements about their centers of mass (called _micro-rotations_ ). The result is that the kinematic variables of each micropolar differential area element are now given by a displacement vector and a micro-rotation (axial) vector. Under plane-strain conditions, the non-vanishing components of the latter are: _𝑢𝑖_ ( _𝑖_ = 1 _,_ 2) for displacement, and _𝜑_ 3, 

3 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [266 x 267] intentionally omitted <==**

**Fig. 2.** _Micropolar and Cauchy kinematics._ **a** Classical Cauchy continuum: only displacements are the degrees of freedom at a given material point. In 2D elasticity, only two elastic constants are necessary: _𝐸_ and _𝜈_ . **b** Micropolar continuum: underlying microstructural kinematics approximated at a point by effective displacement and micro-rotation vectors [58], resulting in displacement and micro-rotation fields at the micropolar continuumlevel. In 2D elasticity, four elastic constants are necessary: _𝐸, 𝜈, 𝜅, 𝛾_ . 

for micro-rotation. Taking derivatives of the displacement and micro-rotation fields, the micropolar strain and micro-curvature fields, under the assumption of small deformations, result in: 

**==> picture [67 x 8] intentionally omitted <==**

**==> picture [11 x 8] intentionally omitted <==**

**==> picture [41 x 8] intentionally omitted <==**

where _𝜖𝑖𝑗𝑘_ is the Levi-Civita symbol, and an index _𝑛_ after a comma is short-hand for partial derivative with respect to the _𝑛_[th] Cartesian spatial coordinate: _𝑓,𝑛_ = _𝜕𝑓_ ∕ _𝜕𝑥𝑛_ . 

The balance of linear and angular momentum for a micropolar continuum in equilibrium is given by 

**==> picture [53 x 9] intentionally omitted <==**

**==> picture [11 x 7] intentionally omitted <==**

_𝑚𝑘_ 3 _,𝑘_ + _𝜖_ 3 _𝑘𝑚𝑡𝑘𝑚_ + _𝑐_ 3 = 0 _,_ 

where _𝑡𝑘𝑙_ is the asymmetric Cauchy stress, _𝑓𝑙_ is the body force per unit volume, _𝑚𝑘_ 3 is the couple stress, and _𝑐_ 3 is the body couple per unit volume. The latter two fields are allowed to be non-zero in a micropolar continuum due to the finite size of the micro-element. These non-zero fields cause the Cauchy stress asymmetry in micropolar mechanics. 

To complete the problem’s formulation, boundary conditions and constitutive relations need to be specified. We assume periodic boundary conditions with an average micropolar strain and/or average micro-curvature imposed over a periodic unit cell, and two types of micropolar constitutive behaviors (elastic [31] and elastoplastic [32]) given in the next two subsections. 

## _2.1.1. Micropolar linear elasticity_ 

For micropolar continua with centrosymmetric micro-elements and anisotropic linear elastic behavior, the relationships between stress-type and strain-type mechanical fields previously defined are given by: 

**==> picture [56 x 22] intentionally omitted <==**

**==> picture [11 x 7] intentionally omitted <==**

where _A𝑘𝑙𝑚𝑛_ and _B_ 3 _𝑘_ 3 _𝑙_ are the generalized elastic stiffness tensors. If the (micropolar) medium is isotropic and elastic, _A𝑘𝑙𝑚𝑛_ and _B_ 3 _𝑘_ 3 _𝑙_ are given by: 

**==> picture [443 x 22] intentionally omitted <==**

where _𝜆, 𝜇_ are the classical Lamé parameters, and _𝜅, 𝛾_ are non-classical parameters necessary in the micropolar theory [31]. 

4 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

## _2.1.2. Micropolar elastoplasticity_ 

The other constitutive behavior considered here is micropolar elastoplasticity, under the assumptions of small deformations, multi-criteria yield conditions, and linear hardening (see Francis et al.[32] for details). Building upon the elastic formulation, this formulation considers plastic deformation mechanisms and allows us to account for irreversible deformations that occur once the material surpasses its yield stress. Specifically, the assumption of small deformations allows us to additively decompose the total strain and micro-curvature into elastic (reversible) and plastic (irreversible/permanent) components: 

**==> picture [443 x 26] intentionally omitted <==**

where the superscript ‘e’ and ‘p’ represent the elastic and plastic components, respectively. 

Letting _𝑝, 𝑞_ be scalar internal variables representing accumulated plastic strain related respectively to _𝑒𝑘𝑙, 𝛾_ 3 _𝑘_ , we write the multicriteria yield conditions as: 

**==> picture [45 x 22] intentionally omitted <==**

**==> picture [11 x 8] intentionally omitted <==**

where _𝑓, 𝑔_ are the yield functions and **𝐭** = ( _𝑡𝑘𝑙_ ), **𝐦** = ( _𝑚𝑘_ 3) are the asymmetric Cauchy stress tensor and the couple stress vector, respectively. If either yield function is less than zero, the corresponding behavior is elastic. Plasticity occurs when either of the yield functions are equal to zero. Having two yield criteria instead of one implies that _𝑡𝑘𝑙_ or _𝑚𝑘_ 3 may yield and undergo hardening separately (although, importantly, the two are still coupled via the momenta balance in Eq. (2)). To specify linear hardening, the yield functions are written as: 

**==> picture [84 x 10] intentionally omitted <==**

**==> picture [11 x 8] intentionally omitted <==**

**==> picture [93 x 9] intentionally omitted <==**

where _𝑡_ eq _, 𝑚_ eq are scalar equivalent stresses of the von Mises type, and _𝑅_ 1 _, 𝑅_ 2 are hardening functions, or the “radii” of the yield surfaces. The equivalent stresses are written as: _𝑡_ eq( **𝐭** ) = ~~[√]~~ _𝑎_ 1 _𝑠_ ( _𝑘𝑙_ ) _𝑠_ ( _𝑘𝑙_ ) + _𝑎_ 2 _𝑠_ [ _𝑘𝑙_ ] _𝑠_ [ _𝑘𝑙_ ] _,_ (8) _𝑚_ eq( **𝐦** ) = √ _𝑏_ 1 _𝑚_ ( _𝑘_ 3) _𝑚_ ( _𝑘_ 3) + _𝑏_ 2 _𝑚_ [ _𝑘_ 3] _𝑚_ [ _𝑘_ 3] _,_ where _𝑠𝑖𝑗_ ∶= _𝑡𝑖𝑗_ −[1] 3 _[𝑡][𝑘𝑘][𝛿][𝑖𝑗]_[is][the][deviatoric][asymmetric][Cauchy][stress,][and][the][notation] _[𝑉]_[(] _[𝑖𝑗]_[)][= (] _[𝑉][𝑖𝑗]_[+] _[ 𝑉][𝑗𝑖]_[)∕2][and] _[𝑉]_[[] _[𝑖𝑗]_[]][= (] _[𝑉][𝑖𝑗]_[−] _[𝑉][𝑗𝑖]_[)∕2] denote the symmetric and skew-symmetric parts of a tensor _𝑉𝑖𝑗_ , respectively. The hardening functions are taken to be linear functions of _𝑝_ and _𝑞_ as 

**==> picture [66 x 8] intentionally omitted <==**

**==> picture [72 x 9] intentionally omitted <==**

**==> picture [11 x 8] intentionally omitted <==**

which allows for an analytical stress update using a generalized radial return algorithm. Hence, the material parameters of the adopted micropolar elastoplastic model are: the yield stresses _𝑡_ Y _, 𝑚_ Y, the hardening slopes _𝑡_ H _, 𝑚_ H, and the plastic parameters _𝑎_ 1 _, 𝑎_ 2 _, 𝑏_ 1 _, 𝑏_ 2. 

## _2.1.3. Direct numerical simulations with a FFT-based method_ 

**==> picture [467 x 61] intentionally omitted <==**

**==> picture [467 x 86] intentionally omitted <==**

**==> picture [467 x 70] intentionally omitted <==**

5 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

where _𝑒_[(0)][and] _[𝛾]_[(0)][and][the][symbols][][and][][−1][respectively][correspond][to][the][forward][and][inverse][spatial][FFT.][In] _𝑘𝑙_[(] **[𝐱]**[) =] _[ 𝐸][𝑘𝑙]_ 3 _𝑙_[(] **[𝐱]**[) = Γ][3] _[𝑙]_[,] the case of a time-stepping algorithm (needed in elastoplasticity), these iterations would occur at every time step. 

## _2.2. Training data generation_ 

For linear micropolar elasticity, including the offline training mode, the inputs and outputs of the micropolar DMN are respectively the local stiffness tensors of the phases {( _𝐴_[1] _𝑘𝑙𝑚𝑛[, 𝐵]_ 3[1] _𝑘_ 3 _𝑙_[)] _[,]_[ (] _[𝐴] 𝑘𝑙𝑚𝑛_[2] _[, 𝐵]_ 3[2] _𝑘_ 3 _𝑙_[)}][and][the][homogenized][stiffness][(] _𝐴𝑘𝑙𝑚𝑛, 𝐵_ 3 _𝑘_ 3 _𝑙_ ) of the composite. Representing these tensors in matrix form, the local stiffness { **𝐂**[1] _,_ **𝐂**[2] } and homogenized stiffness **𝐂** , are symmetric 6 × 6 matrices (different from Cauchy stiffness matrix representation in 3D). The definition of the local stiffness matrices and their action on the generalized strain-type and stress-type vectors is: 

**==> picture [467 x 126] intentionally omitted <==**

For given local stiffness matrices { **𝐂**[1] _,_ **𝐂**[2] } and composite geometry, FFT-based DNS can be used to compute the homogenized stiffness matrix **𝐂** as follows. Let **𝐞** _̂𝑗_ be the _𝑗_[th] standard basis (column) vector in ℝ[6] , so **𝐞** _̂𝑘_ ⋅ **𝐞** _̂𝑙_ = _𝛿𝑘𝑙_ for all _𝑘, 𝑙_ = 1 _,_ … _,_ 6. Then, if we prescribe the average strain as **𝖊** = **𝐞** _̂𝑗_ , and use the FFT-based DNS to solve for local and average stresses, the resulting **Σ** is the _𝑗_[th] column of **𝐂** . Thus, for each choice of { **𝐂**[1] _,_ **𝐂**[2] } in the training dataset _𝑖_ = 1 _,_ … _, 𝑁_ , six DNS are needed be run to construct the homogenized stiffness: 

**==> picture [157 x 12] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

For the composite geometry, a periodic unit cell corresponding to a binary microstructure composed of a matrix with inclusion (phase 2 with 29 % volume fraction) shown in Fig. 1 is considered in this study. In choosing the training dataset, we assumed the isotropic case for simplicity. This means that 8 material parameters should be sampled: _𝜆_ 1 _, 𝜆_ 2 _, 𝜇_ 1 _, 𝜇_ 2 _, 𝜅_ 1 _, 𝜅_ 2 _, 𝛾_ 1 _, 𝛾_ 2, or combinations of those. For convenience, these parameters were combined to give: Young’s modulus _𝐸_ = _𝜇_ (3 _𝜆_ + 2 _𝜇_ )∕( _𝜆_ + _𝜇_ ), Poisson’s ratio 2 _𝜈_ = _𝜆_ ∕( _𝜆_ + _𝜇_ ), and the internal elastic length-scale _𝑙_ introduced in micropolar theory via _𝑙_[2] = _𝛾_ ( _𝜇_ + _𝜅_ )∕(4 _𝜇𝜅_ ). Moreover, we fixed the value of Young’s modulus of phase 1 to be _𝐸_ 1 = 1, and vary all 7 other parameters: _𝐸_ 2 _, 𝜈_ 1 _, 𝜈_ 2 _, 𝜅_ 1 _, 𝜅_ 2 _, 𝑙_ 1 _, 𝑙_ 2. To sample these parameters evenly, we utilized a Latin hypercube sampling (LHS) scheme [59] over the resulting 7-dimensional space. In terms of sampling ranges, we adopted log10( _𝐸_ 2) ∈ U(−2 _,_ 2), _𝜈𝑛_ ∈ U(0 _,_ 0 _._ 5), log10( _𝜅𝑛_ ∕ _𝜇𝑛_ ) ∈ U(−1 _,_ 0), log10( _𝑙𝑛_ ∕ _𝐿_ ext) ∈ U(0 _,_ 1) for _𝑛_ = 1 _,_ 2. In the above expressions, a uniform distribution over domain ( _𝑎, 𝑏_ ) is denoted by U( _𝑎, 𝑏_ ). Note that the chosen ranges ensure positive-definiteness of both **𝐂**[1] and **𝐂**[2] [53]. For Poisson’s ratios, auxetic materials were not considered, so the admissible range of positive values is used for each phase. For the micropolar coupling modulus _𝜅_ , we chose a range in each phase based on Neuner et al.[60]. For the internal elastic length-scale, we adopted a range for which micropolar effects are non-negligible when the length of the side of the square unit cell is set to _𝐿_ ext = 1. This choice is consistent with the assumptions made in deriving the homogenization building block formula in Appendix A (that is, to remain in the HS2 limit of Forest et al.[61]). For the parameter ranges chosen, a single data point within our dataset takes on average around 1 000 seconds to generate in serial on a 12[th] Generation Intel Core i7-1265U processor. Using this estimate, if we were to generate 1 000 data points in serial it would take approximately 11 days. We instead opted to run the training data generation in parallel jobs submitted to different nodes of a high performance computing cluster to decrease this time drastically and generate this dataset in a matter of hours. 

## _2.3. Offline training_ 

This section details the offline training part of the micropolar DMN using Fig. 3 as a schematic. We first describe the micropolar “building block” function, central to constructing the network, then the associated standard binary tree configuration of the DMN, and finally the cost function used for training. 

## _2.3.1. Micropolar building block_ 

The fundamental building blocks of the DMN consist of closed-form homogenization functions relating local properties to effective properties in an analytical model. More specifically, an elementary building block is defined as a binary laminate, wherein each child node corresponds to a distinct phase of the laminate. The information pertaining to stress, strain, and phase fraction at each of these 

6 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [458 x 191] intentionally omitted <==**

**Fig. 3.** _Micropolar DMN offline training configuration._ **a** Elementary building blocks of the network are assembled as a binary tree architecture. The network takes as inputs the micropolar elastic properties of the individual phases ( **A**[1] _,_ **B**[1] ) _,_ ( **A**[2] _,_ **B**[2] ) and predicts the homogenized micropolar properties ( **A** _,_ **B** ). **b** The elementary building block of the micropolar DMN assumes a binary laminate. The learnable network parameters in a single building block are the volume fractions _𝑓_ 1 _, 𝑓_ 2 and a single laminate normal vector **n** . Nodal information passed through the network includes micropolar stresses, strains, and the generalized micropolar stiffnesses ( **A** _,_ **B** ). 

(child) nodes is transmitted to the homogenized (parent) node, which represents the effective, homogenized medium derived from the laminate. Mathematically, for linear elastic micropolar materials, this elementary building block takes the form 

**==> picture [88 x 12] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

where **𝖍** represents the micropolar homogenization function, **𝐂**[1] _,_ **𝐂**[2] are the local micropolar stiffnesses that stand for the network nodal information, the geometric parameters _𝑓_ 1, _𝑓_ 2 = 1 − _𝑓_ 1 represent the phase fraction of each phase, and the vector **𝐧** fully describes the orientation between the phases. 

Note that here the stiffness tensors are different from the Cauchy stiffness matrix in 3D, see Eq. (13). Fig. 3 **b** depicts the building block and its parameters. See Appendix A for the explicit form of Eq. (17). 

## _2.3.2. Network architecture and parameters_ 

The full network is constructed by assembling the elementary building blocks as a binary tree network structure (see Fig. 3 **a** ), similar to the construct for a Cauchy DMN. In that sense, the full DMN can be thought out as a multiple-rank laminate defined by Milton[49], as pointed out by Gajek et al.[51]. Importantly, the DMN learns its multiple-rank laminate geometry from homogenized data, making the approach generally applicable to arbitrary microstructures. We adopted the indexing convention for layers and nodes used in Shin et al.[53,54]. The layers of the micropolar DMN are indexed by _𝑙_ ∈{0 _,_ 1 _,_ … _, 𝐿_ }, where _𝑙_ = 0 is the _output_ layer and _𝑙_ = _𝐿_ is the _base_ layer (right above the non-indexed input layer in Fig. 3 **a** ). The nodes in any layer _𝑙_ are indexed by _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ }, due to the binary tree shape of the network. Finally, we denote a quantity _𝑞_ at the _𝑛_[th] node in the _𝑙_[th] layer as _𝑞_[(] _[𝑙,𝑛]_[)] . Homogenization only occurs at nodes in layers _𝑙_ ∈{0 _,_ 1 _,_ … _, 𝐿_ −1}, since the base layer nodes inherit their stiffnesses from the input layer. Given this construct, we write Eq. (17) at node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in layer _𝑙_ ∈{0 _,_ 1 _,_ … _, 𝐿_ −1} as 

**==> picture [443 x 11] intentionally omitted <==**

where the geometric parameters are the volume fractions _𝑓_[(] _[𝑙]_[+1] _[,]_[2] _[𝑛]_[−1)] , _𝑓_[(] _[𝑙]_[+1] _[,]_[2] _[𝑛]_[)] and laminate normal vector **𝐧**[(] _[𝑙,𝑛]_[)] . Since we restrict to 2D laminates here, the normal vector takes the form 

**==> picture [443 x 13] intentionally omitted <==**

where _𝜃_[(] _[𝑙,𝑛]_[)] is a learned parameter during training, and the set 

**==> picture [443 x 23] intentionally omitted <==**

of size[∑] _[𝐿] 𝑙_ =0[−1][2] _[𝑙]_[= 2] _[𝐿]_[−1][represents][the][network][parameters][to][be][learned][for][the][laminate][normal][vectors][throughout][the][DMN.][The] other set of learned parameters are the volume fractions defined at the base layer as follows. 

Let there be an “unconstrained weight” _𝑣𝑛_ at each base layer node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝐿]_ }, and define the base layer weights _𝑤_[(] _[𝐿,𝑛]_[)] = ReLU( _𝑣𝑛_ ) = max(0 _, 𝑣𝑛_ ). The unconstrained weights are learned such that the sum of all the base layer weights equals 1 (see next 

7 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

subsection with the definition of the cost function). The weights of any two child nodes are then passed to their parent node by summing them as 

**==> picture [104 x 8] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

From these weights, the volume fraction is defined as 

**==> picture [443 x 49] intentionally omitted <==**

such that 

**==> picture [467 x 27] intentionally omitted <==**

of size 2 _[𝐿]_ represents the network parameters to be learned for the laminate volume fractions throughout the DMN. In total, in our 2D case, there are 2 _[𝐿]_ −1 + 2 _[𝐿]_ = 2 _[𝐿]_[+1] −1 parameters to be learned during the micropolar DMN offline training. 

## _2.3.3. Cost function and implementation_ 

We implemented the DMN using PyTorch [62] to minimize the following cost function inspired by Liu and Wu[50], Gajek et al.[51], Shin et al.[53]: 

**==> picture [443 x 33] intentionally omitted <==**

The first term is an average relative error between the DNS elastic stiffness data (denoted with an overbar) and the DMN predicted micropolar stiffness tensors (denoted with a hat) with respect to the Frobenius norm ‖ **𝐀** ‖[2] _𝐹_[=][ trace][(] **[𝐀]**[T] **[𝐀]**[)][.][The][second][term][is][a] constraint forcing[∑][2] _𝑛_ =1 _[𝐿][𝑤]_[(] _[𝐿,𝑛]_[)][= 1][(the][sum][of][the][base][layer][weights][equal][to][1)][with][a][penalty][parameter][set][to] _[𝜆]_[= 10][3][.][In][PyTorch,] we used the ADAM optimizer [63] with the AMSGrad method [64], and set an adaptive learning rate to 20[−4] (1 + cos(10 _𝜋𝑚_ ∕ _𝑀_ )) to train the network, where _𝑚_ is the current epoch number, and _𝑀_ (=1 000) is the total number of epochs [65]. We used an 80/20 split of the DNS data for training/validating the DMN. 

## _2.4. Online prediction_ 

The hierarchical laminate geometry learned from the offline training can be used to make predictions for material behaviors outside of the ranges of the training dataset. The extension to nonlinear behavior is implemented by changing the relationship between stress and strain at the base layer nodes. For history-dependent material behavior, we need to additionally track all internal variables introduced by the new constitutive relation at the base layer nodes over time. This extension is possible since the network can be viewed geometrically as a multiple-rank laminate, independent of its material constitution. Practically speaking, when the relationship is no longer linear, the expressions in Eq. (A.11) cannot be found in closed-form, which, in turn implies that our homogenization building block formula in Eq. (18) is no longer in closed-form. Kinematic localization using the trained network enables the strains at the base layer _𝑙_ = _𝐿_ to be written as a function of the output layer _𝑙_ = 0 strains and the now-unknown vectors _[̃]_ **𝐛** and **𝐝** _[̃]_ as 

**==> picture [48 x 23] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

see Appendix B. Here, **𝐞** _,_ **𝐄** _,[̃]_ **𝐛** _,_ _**γ** ,_ **Γ** _,_ **𝐝** _[̃]_ are long column vectors and **𝐁** and **𝐃** are constant non-square matrices containing trained network parameters, defined in Eqs. (B.10), (B.11), (B.13), and (B.14). **𝐞** and _**γ**_ contain the strain and micro-curvature components at the base layer in vector form. **𝐄** and **Γ** contain the prescribed strain and micro-curvature components at the output layer, also in vector form consistent with **𝐞** and _**γ**_ . Additionally, the force equilibrium and couple equilibrium across all the laminate interfaces in the DMN can be written as 

**==> picture [43 x 23] intentionally omitted <==**

**==> picture [16 x 7] intentionally omitted <==**

see Appendix C for derivation. Here, **𝐭** and **𝐦** are long column vectors and **𝐖** and **𝐕** are constant block-diagonal square matrices with the trained weight information, defined in Eqs. (C.12) and (C.13). **𝐭** and **𝐦** contain the stress and couple stress components at the base layer in vector form respectively. During the offline training, this condition is satisfied analytically; however, in online prediction when _[̃]_ **𝐛** and **𝐝** _[̃]_ are unknown, this condition is not guaranteed to hold. The strategy then, following Gajek et al.[51] and Shin et al.[53], is to convert Eq. (27) into the residual equations 

**==> picture [84 x 24] intentionally omitted <==**

(28) 

8 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

and then drive them to zero via the Newton-Raphson method to find _[̃]_ **𝐛** and **𝐝** _[̃]_ , while prescribing strains **𝐄** and **Γ** in Eq. (26). Here, we assume that **𝐭** ( **𝐞** ) and **𝐦** ( _**γ**_ ) only because the multi-criteria micropolar elastoplasticity used in this paper allows it. However, in general, we might need **𝐭** ( **𝐞** _,_ _**γ**_ ) and **𝐦** ( **𝐞** _,_ _**γ**_ ). Once _[̃]_ **𝐛** and **𝐝** _[̃]_ are known, we can compute the strains and stresses at the base layer nodes through Eq. (26) and the chosen constitutive behavior. Then, as a last step, the stresses at the output layer are reconstructed by using Eq. (C.5) with _𝑙_ = 0 (and _𝑛_ = 1). 

To setup a Newton-Raphson algorithm, let _[̃]_ **𝐛**[∗] and **𝐝** _[̃]_[∗] be the solutions that make the residuals zero: 

**==> picture [443 x 25] intentionally omitted <==**

Let us take the Taylor series of **𝐅** ( **𝐛** ) and **𝐌** ( **𝐝** ) about points _[̃]_ **𝐛** and **𝐝** _[̃]_ , and evaluate at _[̃]_ **𝐛**[∗] and **𝐝** _[̃]_[∗] to get 

**==> picture [172 x 41] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

**==> picture [400 x 15] intentionally omitted <==**

**==> picture [105 x 24] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

which after linearizing, gives us approximate increments Δ _[̃]_ **𝐛** and Δ **𝐝** _[̃]_ : 

**==> picture [77 x 26] intentionally omitted <==**

**==> picture [16 x 8] intentionally omitted <==**

For Newton-Raphson, we take initial guesses _[̃]_ **𝐛** 0 and **𝐝** _[̃]_ 0 and iterate: 

**==> picture [444 x 26] intentionally omitted <==**

to approximate _[̃]_ **𝐛**[∗] and **𝐝** _[̃]_[∗] . For the Jacobians, by using Eqs. (26) and (28), we have: 

**==> picture [467 x 73] intentionally omitted <==**

Although using the consistent material tangent provides quadratic convergence of the error, occasionally the algorithm will still diverge. To combat this, we implemented an empirically tuned adaptive time-stepping algorithm to solve the micropolar elastoplastic problem with DMN. A minimum time step Δ _𝑡_ of 0.002 and a maximum of 0.02 was used. Algorithmically, we employed a progressive time-stepping strategy: when the number of iterations is less than 3, the time step is increased via Δ _𝑡_ new = 1 _._ 6 ⋅ Δ _𝑡_ old. When the number of iterations is inclusively between 3 and 5, the time step is increased via Δ _𝑡_ new = 1 _._ 25 ⋅ Δ _𝑡_ old. When the number of iterations is equal to 6, the time step is not changed. Finally, when the number of iterations is greater than 6, the time step iterations are restarted with a smaller time step determined via Δ _𝑡_ new = 0 _._ 25 ⋅ Δ _𝑡_ old. The Newton-Raphson iterations at a given time step are considered converged when both ‖ **𝐅** ‖2 _<_ 10[−8] and ‖ **𝐌** ‖2 _<_ 10[−8] . 

## **3. Results** 

## _3.1. Offline training_ 

We start with results stemming from the offline training of the micropolar DMN and prediction of micropolar elastic properties. Fig. 4 **a** shows the evolution of the cost function Eq. (25) as a function of the training epoch for the geometry in Fig. 2. Each color represents a different network depth tested: _𝐿_ = 3 _,_ 4 _,_ 5 _,_ 6 (For interpretation of the references to color in this figure, the reader is referred to the web version of this article). For each depth tested, 30 networks starting from separate random initializations were trained. The shaded regions contain the 30 training curves for the given depth/color. As anticipated, we find that increasing the depth of the network leads to improved accuracy in estimating the micropolar elastic constants. 

Fig. 4 **b** , shows the relative error each data point has at the last training epoch by plotting: 

**==> picture [83 x 32] intentionally omitted <==**

**==> picture [16 x 7] intentionally omitted <==**

9 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [464 x 159] intentionally omitted <==**

**Fig. 4.** _Offline training results._ **a** Training: Epochs vs. cost function (Eq. (25)) for different network depths _𝐿_ = 3 (blue), 4 (purple), 5 (red), and 6 (green). **b** Error (Eq. (35)) distributions of the best-trained network for a network depth, showing each data point’s relative error at the last epoch. (For interpretation of the references to color in this figure legend, the reader is referred to the web version of this article). 

in a histogram for _𝑖_ = 1 _,_ … _, 𝑁_ , where the color again indicates the depth of the associated DMN (For interpretation of the references to color in this figure, the reader is referred to the web version of this article). For a network of depth _𝐿_ = 6, we observe that almost all data points are predicted with a cost less than 10[−2] , whereas for _𝐿_ = 3, almost half of the data points are above 10[−2] . Taken together, these results illustrate that the micropolar DMN can effectively learn the micropolar elastic constants across a broad range of elastic combination with a limited number of degrees of freedom: for a network with _𝐿_ = 3 layer, only 15 parameters are needed achieving on average an approximate error less than 5 × 10[−2] , while a _𝐿_ = 6 layer deep network can achieve on average an approximate error less than 10[−3] , with 127 parameters. 

## _3.2. Online prediction/extrapolation_ 

Once the network is sufficiently trained in offline mode and achieves satisfactory accuracy in predicting the elastic properties of a specific microstructure, it can then be used in online mode as a reduced-order model. This model has fewer degrees of freedom than the DNS FFT micropolar solver and can effectively and rapidly predict and estimate the (linear or nonlinear) response of the same microstructure topology. In this section, we present five examples of online prediction. The first is the prediction of micropolar linear elastic high-contrast composites with properties outside the range of the trained-on data. The next two examples are verifications and predictions of the micropolar elastoplastic model from Francis et al.[32], including simulation of ratcheting during high-cycle fatigue. The final two examples demonstrate the micropolar DMN’s use in predicting size-dependent behavior of composite via the presence of microstructural length scales in the model, namely size-dependent plastic response and the optimization of the properties of lattice structures. 

## _3.2.1. Micropolar linear elastic extrapolation_ 

We first look at the ability of the micropolar DMN to extrapolate linear elastic properties for composites with high elastic contrast outside the range of the trained-on data. To this end, we partitioned the training data from Section 2.2 in half, trained a micropolar DMN on one half of that data, and then used the trained micropolar DMN to predict the other half in the extrapolation region. We looked at two types of partitions: one for composites with high elastic contrast between the phases and one for extrapolation of the internal length scale. Looking at the predictions for high-contrast predictions, we took the same data bounds as before, and changed the range for the matrix phase (phase 2) Young’s modulus to log10( _𝐸_ 2) ∈[−1 _,_ 1]. After training an _𝐿_ = 7 layer deep micropolar DMN on these 500 data points for 2 000 epochs, we used the trained micropolar DMN to predict the unseen 500 data points corresponding to | log10( _𝐸_ 2)| _>_ 1. We trained this network for more epochs here since fewer data points were used compared to the results presented in the previous section. For the predictions of the internal length scales, we partitioned only the length scale bounds for the inclusions phase (phase 1) in the original training data set by log10( _𝑙_ 1) ∈[0 _._ 5 _,_ 1]. We then trained an _𝐿_ = 7 layer DMN for 2 000 epochs, and used this trained micropolar DMN to predict the unseen data points corresponding to log10( _𝑙_ 1) ∈[0 _,_ 0 _._ 5). 

The results demonstrating the extrapolation ability of the micropolar DMN are presented in Fig. 5 **a** and **b** . These results show the error histograms using the error metric in Eq. (35). In these histograms, we plot the training data cost distribution (in blue) along with the cost distribution of the unseen data (black) for both the high-contrast (panel **a** ) and internal length scales (panel **b** ) predictions. In both cases, we observe that the well-trained micropolar DMNs extrapolate the training data to high-contrast composites and other internal length scales well, where the error distribution matches that of the training data. In other words, we did not observe cases where the trained micropolar DMNs had outliers predictions with low deteriorated performance (i.e., no higher errors). 

10 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [422 x 161] intentionally omitted <==**

**Fig. 5.** _Extrapolation performance in linear regime._ Blue is trained-on data (500 points 2 000 epochs) and black is data in the region unseen during training (linear elastic extrapolation, 500 points). **a** Histogram of error for composites with a high elastic contrast. The micropolar DMN was trained on partitioned data with the matrix phase (phase 2) Young’s modulus log10( _𝐸_ 2) ∈[−1 _,_ 1]. The micropolar DMN predicts well in the extrapolation region where | log10( _𝐸_ 2)| _>_ 1. **b** Histogram of error for composites broad range of internal length scales. The micropolar DMN was trained on partitioned data with the inclusion phase (phase 1) internal length scale log10( _𝑙_ 1) ∈[0 _._ 5 _,_ 1]. The micropolar DMN predicts well in the extrapolation region where log10( _𝑙_ 1) ∈[0 _,_ 0 _._ 5). 

**Table 1** Verification constitutive parameters. Γ _[̇]_ 31 = 1, others = 0 for 1 second. 

|Parameter|_𝜆_|_𝜇_|_𝜅_|_𝛾_|_𝑡_Y|_𝑡_H|_𝑚_Y|_𝑚_H|_𝑎_1|_𝑏_1|
|---|---|---|---|---|---|---|---|---|---|---|
|**Phase** **1**|1.0|1.0|1.0|1.0|0.5|0.0|0.5|0.0|1.5|1.5|
|**Phase** **2**|2.0|2.0|2.0|2.0|0.75|0.25|0.75|0.25|1.5|1.5|



## _3.2.2. Verification and extrapolation to a micropolar elastoplastic problem_ 

We now turn our attention to verifying the online predictions of the micropolar DMN for an elastoplastic micropolar composite. The nonlinear online prediction was implemented in our micropolar DMN using the elastoplastic micropolar model from Francis et al.[32] using the procedure detailed in Section 2.4. Here we demonstrate that the ability of the DMN to capture history dependence of a composite by tracking the states of stress, strain, and internal variables of the constitutive model over time. Online predictions from the micropolar DMN are compared against FFT-based DNS predictions [32]. 

Looking first at a monotonic loading case, Fig. 6 **a** shows the comparison of homogenized response between the DNS and the DMN for networks of different depth, using the properties in Table 1, under a macroscopic prescribed strain-rate of Γ _[̇]_ 31 = 1 with others = 0 for 1 second. The composite geometry used is displayed as an inset of the right-most plot. For each depth, 30 differently initialized DMNs were trained and used to simulate the response. We immediately observe the close agreement between the online predictions of the micropolar DMN (dashed line for average response and colored envelope for response over 30 trained networks) and the groundtruth FFT-based DNS results (solid line), even when the network is shallow (i.e., _𝐿_ = 3). (The reader is referred to the web version of this article for interpretation of the references to color in this figure). Similar to the results presented for the offline training, those predictions get better as the network becomes increasingly deeper (i.e., more degrees of freedom to describe the materials behavior). Fig. 6 **b** shows the standard deviation of the 30 DMN responses over time for each of the DMN depths tested. We note relatively large fluctuations reflected by large standard deviations for the shallow networks ( _𝐿_ = 3 _,_ 5). These fluctuations correspond to the transition from the elastic to the plastic regime when yielding starts. These fluctuations decrease as the network gets increasingly deeper. Results in panels **a** and **b** demonstrate the ability of the micropolar DMN to accurately predict the response of an elastoplastic micropolar composite. What these results do not demonstrate is the computational efficiency. Fig. 6 **c** illustrates runtime for the micropolar as a function of the number of layers. Runtime for the FFT-based DNS solver are also plotted for comparison. Hence, for a 7-layer deep micropolar DMN, predictions for the results presented in panel **a** takes about 50 seconds, while it took over 2 hours to simulate with our FFT-based solver. Micropolar DMNs with fewer layers will obviously take less inference time, with just 5 seconds needed for a 3-layer deep micropolar DMN. Choosing the right depth for a network involves balancing runtime and accuracy. Based on the results shown in panels **a** and **b** for accuracy and those for runtime in panel **c** , we have selected a 7-layer deep network for the subsequent results presented below. 

In the next example, we used the 7-layer micropolar DMN for efficiently simulating high-cycle fatigue behavior. This is an important example because high-cycle effective properties of composites are typically very expensive to simulate, primarily due to the need for repeated full-field calculations. In contrast, the DMN employs a surrogate model to bypass full-field resolution, enabling significantly faster simulations while still maintaining high accuracy in predicting the effective behavior. The constitutive parameters selected for this study are detailed in Table 2. For the boundary conditions, we employed an average strain-driven cycling approach, maintaining an average strain amplitude of | _𝐸_ 12| = 1 throughout the simulations. These simulations were performed using 

11 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [464 x 280] intentionally omitted <==**

**Fig. 6.** _Micropolar elastoplastic DMN verification._ **a** Comparison of the FFT-based DNS response vs. micropolar DMN response as a function of the network depth: _𝐿_ =3 (blue), 5 (red), 7 (yellow), 9 (grey) depth. **b** Standard deviation of the DMNs over 30 training initializations, per time step. **c** Runtimes of the _𝐿_ = 3 _,_ 5 _,_ 7 _,_ 9 depth DMNs compared with the 2 hour runtime of the FFT-based DNS. (For interpretation of the references to color in this figure legend, the reader is referred to the web version of this article). 

**Table 2** High-cycle study constitutive parameters. Cyclic loading with strain amplitude | _𝐸_ 12| = 1. 

|Parameter|_𝜆_|_𝜇_|_𝜅_|_𝛾_|_𝑡_Y|_𝑡_H|_𝑚_Y|_𝑚_H|_𝑎_1|_𝑏_1|
|---|---|---|---|---|---|---|---|---|---|---|
|**Phase** **1**|1.0|1.0|1.0|1.0|0.5|0.125|0.5|0.125|1.5|1.5|
|**Phase** **2**|2.0|2.0|2.0|2.0|0.375|0.25|0.75|0.125|1.5|1.5|



high-performance computing resources. In Fig. 7 **a** , we compare the performance of the 7-layer micropolar DMN against FFT-based DNS over three cycles. We observe that both simulation approaches yield identical results, with the gradual accumulation of plastic deformation with repeated loading. Just for three cycles, the FFT-based DNS took approximately 6.5 hours to complete, while the DMN took only 2.4 minutes. This significant difference in computation time highlights the efficiency of the DMN approach and opens up new possibilities. As such, we subsequently simulated 100 cycles (for the same average strain amplitude) – a task computationally prohibitive with FFT-based DNS. It only took 30 minutes for the micropolar DMN to complete, whereas the FFT-based DNS is estimated to take around 9 days, achieving an impressive 400× speedup. It is important to note that further acceleration of DMN simulations is possible by reducing the number of layers, although this may introduce higher uncertainty or error in the output responses. Results from this example illustrate that the rapid simulation capabilities of the DMN not only facilitate the exploration of high-cycle fatigue response but also enable the efficient determination of critical parameters such as the elastic shakedown limit (i.e., the transition from plastic deformation an elastic state without experiencing additional plastic deformation) in this case. Fig. 7 **b** shows the homogenized elastic shakedown limit of the micropolar elastoplastic composite, represented by the black line which is achieved after approximately 25 cycles for the selected parameters. Overall, these results underscore the potential of the micropolar DMN as a powerful computational tool for mechanical simulations, significantly enhancing computational efficiency while providing valuable insights into material behavior, not achievable with DNS. 

## _3.2.3. Internal length scale effects via micropolar DMN_ 

The micropolar model naturally incorporates microstructural length scales. Here we use the micropolar DMN to demonstrate the effective behavior’s sensitivity to these lengths, as well as the network’s efficiency as compared to traditional DNS solvers. 

12 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [458 x 169] intentionally omitted <==**

**Fig. 7.** _High-cycle fatigue study._ Simulations done here using a maximum strain amplitude of | _𝐸_ 12| = 1. **a** 3-cycle comparison between FFT-based DNS and DMN. Simulations done sequentially on the same node, for timing consistency. **b** 100-cycle simulation of the same composite. Elastic shakedown occurs after approximately 25 cycles. The micropolar DMN took about 30 minutes to simulate 100 cycles, while we expect FFT-based DNS to take around 9.2 days (2.2 hr/cycle × 100 cycles) for the same simulation. 

**Table 3** Length scale study constitutive parameters. _𝐸[̇]_ 12 = 1, others = 0 for 1 second. _𝑙_ is varied from 0.55 to 0.90. 

|Parameter|_𝜆_|_𝜇_|_𝜅_|_𝛾_|_𝑡_Y|_𝑡_H|_𝑚_Y|_𝑚_H|_𝑎_1|_𝑏_1|
|---|---|---|---|---|---|---|---|---|---|---|
|**Phase** **1**|1.0|1.0|(4_𝑙_2 −1)−1|1.0|0.1|0.125|0.5|0.25|1_._5⋅_𝑙_2|1.5|
|**Phase** **2**|1.0|1.0|10−6|10−6|108|0.5|0.5|0.25|1.5|1.5|



As a first length scale example, we perform a parametric study on the effect of the internal length scale on the elastoplastic response of a composite microstructure. To that end, let us assume that one of the composite phases is Cauchy linear elastic, and the other is micropolar elastoplastic. Additionally, we assume that in the micropolar phase _𝜅_ and _𝑎_ 1 are determined by an unknown internal length scale _𝑙_ , which falls between 0.55 and 0.90. The dependence of the micropolar constitutive parameters _𝜅_ and _𝑎_ 1 on the internal length scale is assumed to follow _𝜅_ ( _𝑙_ ) = (4 _𝑙_[2] −1)[−1] taken from Francis et al.[31] and _𝑎_ 1( _𝑙_ ) = 1 _._ 5 ⋅ _𝑙_[2] from Francis et al.[32], where we have additionally assumed that the elastic and plastic internal length scales are equal. Finally, we enforce a macroscopic strain-rate of _𝐸[̇]_ 12 = 1 with others = 0 for 1 second. Table 3 shows the adopted constitutive parameters. 

Exploring the range of length scales in this situation is challenging to accomplish with brute-force using FFT-based DNS because each simulation will take more than 2 hours to complete. In contrast, because the micropolar DMN has a lot fewer degrees of freedom (255 for a 7-layer deep network), such scenario can easily be studied using the micropolar DMN. In Fig. 8, 100 (homogenized) stressstrain curves corresponding to 100 evenly spaced length scales between 0.55 and 0.90 are shown. For a 7-layer deep micropolar DMN, it took approximately 100 minutes of runtime to generate. We estimate that the time for the FFT-based DNS to simulate 100 curves at 2 hours each is around 12 000 minutes. A comparison of these numbers shows a speedup of 120× for the micropolar DMN as compared to the FFT-based DNS solver. 

For our final example, we use the micropolar DMN to study how microscopic length scale can affect the output effective behavior of a micropolar composite, where the constituent micropolar materials are identified as homogenized Euler-Bernoulli lattices. Our specific aim with this example is to analyze the effective anisotropy of a composite using two different types of lattices for the rapid identification of properties. To begin, we are able to identify a micropolar continuum as a homogenized Euler-Bernoulli lattice via the closed-form formulas of Pradel and Sab[66], Sab and Pradel[67], which relate the geometric and material properties of a lattice unit cell directly to micropolar material properties. We select the rectangular and hexagonal lattices (studied also by Molnár and Blal[68] in the context of micropolar topology optimization) depicted in Fig. 9 **a** . All lattices considered have the following micropolar stiffness matrix in the form of Eq. (13) as 

**==> picture [443 x 60] intentionally omitted <==**

13 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [194 x 151] intentionally omitted <==**

**Fig. 8.** _Internal length scale parametric study._ Elastic and plastic internal lengths set equal to each other and varied over 100 simulations. The inset shows the difference in runtime between a 7-layer deep micropolar DMN and FFT-based DNS solver. 

**==> picture [464 x 251] intentionally omitted <==**

**Fig. 9.** _Euler-Bernoulli lattices as a micropolar composite._ **a** Micropolar composite with its material phase elastic properties given by Euler-Bernoulli lattice homogenization formulas. **b** Result showing that effective micropolar anisotropy is sensitive to the beam widths of the Euler-Bernoulli lattices. Displayed are the Zener-like ratios characterizing micropolar elastic anisotropy plotted as functions of the internal beam widths. 10 000 configurations of the lattice microstructure were tested to create the heatmaps. The micropolar DMN only takes minutes to generate this result, while a simulation using the FFT-based method could take weeks or days. 

where for the rectangular lattice we have 

**==> picture [443 x 19] intentionally omitted <==**

and for the hexagonal lattice we have 

**==> picture [443 x 25] intentionally omitted <==**

In the above formulas, _𝐸_ is a beam’s axial Young’s modulus, _ℎ_ is the in-plane beam width, and _𝑙_ is the characteristic length of the beam. It is important to remark that other schemes for mapping a complicated classical composite to a micropolar continuum are available [58,69], so this process is not strictly limited to Euler-Bernoulli lattices. 

14 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

Now, changing geometries to the square inclusion geometry depicted in Fig. 9 **a** , we generate a training dataset using the same material parameter ranges used in Section 2.2 and train a 7-layer micropolar DMN. Referring to Fig. 9 **a** , we fixed both the characteristic length of all beams to _𝑙_ = 0 _._ 1 as well as the Young’s modulus of all beams to _𝐸_ = 10[6] . We assigned the rectangular lattice to phase 1 (white) and the hexagonal lattice to phase 2 (black) and varied the beam widths of each: _ℎ_ 1 and _ℎ_ 2 respectively, from a minimum of _𝑙_ ∕25 000 to a maximum of _𝑙_ ∕5 (bounds taken from Molnár and Blal[68] such that the lattices stay within the Euler-Bernoulli theory). To sample _ℎ_ 1 and _ℎ_ 2, we used Latin hypercube sampling with 10 000 total points to demonstrate DMN’s surrogate model capabilities, since it was only trained on 1 000 points. Pushing these 10 000 data points through the trained micropolar DMN results in 10 000 effective micropolar elastic matrices **𝐂** . In order to describe effective anisotropy with a scalar, we create Zener-like ratios that describe effective _torsional_ and effective _bending_ stiffness of the composite – two properties of the micropolar model that are not as easily expressed in the classical one. The Zener ratio for torsion and bending, denoted respectively as _𝑍𝜅_ and _𝑍𝛾_ are defined here as 

**==> picture [443 x 22] intentionally omitted <==**

where we note that in the case of isotropy, both _𝑍𝜅_ = _𝑍𝛾_ = 1, as can be seen by plugging in the values given in Eq. (36). We base these off of the assumption that the effective medium will be an orthotropic micropolar linear elastic material and use Eq. (5.12) of Zheng and Spencer[70]. 

In Fig. 9 **b** , we show in the top plot a heatmap displaying the bending Zener ratio _𝑍𝛾_ and an overlayed contour plot displaying the torsional Zener ratio _𝑍𝜅_ as a function of the 10 000 different values of _ℎ_ 1 and _ℎ_ 2 for the square heterogeneity composite. We see roughly when _ℎ_ 2 _< ℎ_ 1 or _ℎ_ 1 _< ℎ_ 2, the composite has torsional and bending stiffnesses that are direction-dependent. In the bottom plot of Fig. 9 **b** , we have separated the domain into two regions: a grey shaded region where both the effective anisotropies favor the same direction ( _𝑍𝜅 <_ 1 and _𝑍𝛾 <_ 1), and a white region where effective anisotropies favor different directions ( _𝑍𝜅 >_ 1 and _𝑍𝛾 <_ 1). For interpretation of the references to color, the reader is referred to the web version of this article. This result allows us to select a desired effective behavior of the multiscale composite – see for instance the black dots in Fig. 9 **b** are – and assign a microstructure at that point ( _ℎ_ 1 _, ℎ_ 2) = (0 _._ 015 _,_ 0 _._ 005) which achieves the desired behavior. Note the small white region in the grey-masked region near ( _ℎ_ 1 _, ℎ_ 2) = (0 _._ 000625 _,_ 0 _._ 0025). This region is so confined that it is highly likely a full-field method would miss this due to computational constraints, whereas we are able to resolve this small domain easily with the micropolar DMN. Importantly, this process is essentially inaccessible to conventional numerical solvers which need to compute local field distributions. In contrast to the minutes it takes for this result to generate via micropolar DMN, a single data point with the micropolar FFT takes around 1 000 seconds to generate (referring back to the last paragraph of Section 2.2), so 10 000 points would take weeks in serial or days in parallel. 

## **4. Conclusions** 

In this paper, we presented a micropolar DMN framework, extending the capabilities of traditional DMNs to address the challenges associated with modeling size effects in composite materials. For this, we have leveraged the micropolar theory to efficiently predict the homogenized mechanical response of composites with underlying microstructures. The key fundamental building blocks of the micropolar DMN consist of closed-form analytical micropolar homogenization functions relating local properties to effective properties. These building blocks are assembled in a binary tree network structure to compose the full micropolar DMN. By training this hierarchical network on linear elastic DNS data, the micropolar DMN learns the intricate relationships between microstructure and effective (micropolar) properties. We exercised this framework on a set of example to demonstrate its accuracy and efficiency. Notably, the micropolar DMN achieves high accuracy in predicting micropolar elastic constants and exhibits good agreement with FFT-based DNS for micropolar elastoplastic composites under various loading conditions, including monotonic shear and high-cycle fatigue. Critically, this micropolar DMN significantly reduces computation time compared to traditional DNS, achieving speed-ups of up to two order of magnitudes faster. The advantages of this approach are multifold. The enhanced computational efficiency enables previously impractical analyses, such as comprehensive parametric investigations of internal length scales and detailed high-cycle fatigue characterization in micropolar composites. By explicitly incorporating micropolar mechanics into the network, the framework provides a microstructure-aware tool capable of capturing size-dependent responses, which are inherently absent in classical continuum theories. While current limitations include the prediction of local fields (natural consequence of using scale separation within the DMN, see Appendix A), and the centrosymmetric restriction on the homogenized properties in Eq. (A.9) (generally, a micropolar composite should homogenize up to a non-centrosymmetric micropolar material), the development of the micropolar DMN represents a significant advancement in the efficient modeling and simulation of complex materials with size-dependent behavior, paving the way for accelerated material design and optimization. 

## **CRediT authorship contribution statement** 

**Noah M. Francis:** Writing – review & editing, Writing – original draft, Visualization, Validation, Software, Methodology, Investigation, Formal analysis, Data curation, Conceptualization; **Dongil Shin:** Writing – review & editing, Writing – original draft, Supervision, Methodology, Investigation, Conceptualization; **Ricardo A. Lebensohn:** Writing – review & editing, Writing – original draft, Supervision, Software, Conceptualization; **Fatemeh Pourahmadian:** Writing – review & editing, Writing – original draft, Supervision, Investigation, Funding acquisition, Conceptualization; **Rémi Dingreville:** Writing – review & editing, Writing – original draft, Supervision, Project administration, Investigation, Funding acquisition, Formal analysis, Conceptualization. 

15 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

## **Data availability** 

No data was used for the research described in the article. 

## **Declaration of competing interest** 

The authors declare that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper. 

## **Acknowledgments** 

The authors thank A. Lenau for providing feedback and insightful comments during the preparation of this manuscript. The authors also thank the anonymous reviewers for the constructive feedback and suggestions during the review of this work. NMF was partially supported by the SNL-CEAS research partnership. RAL acknowledges support from the Advanced Engineering Materials program at Los Alamos National Laboratory. The DMN capability and computational resources are supported in part by the Center for Integrated Nanotechnologies, an Office of Science user facility operated for the U.S. Department of Energy. This article has been authored by an employee of National Technology & Engineering Solutions of Sandia, LLC under Contract no DE-NA0003525 with the U.S. Department of Energy (DOE). The employee owns all right, title, and interest in and to the article and is solely responsible for its contents. The United States Government retains and the publisher, by accepting the article for publication, acknowledges that the United States Government retains a non-exclusive, paid-up, irrevocable, world-wide license to publish or reproduce the published form of this article or allow others to do so, for United States Government purposes. The DOE will provide public access to these results of federally sponsored research in accordance with the DOE Public Access Plan https://www.energy.gov/downloads/doe-public-access-plan. 

## **Appendix A. Linear elastic micropolar homogenization formula for a periodic laminate** 

In this appendix, we derive the critical formula at the heart of the micropolar deep material network: the homogenization building block. For modeling micropolar composites that are also non-trivially micropolar when homogenized, the heirarchical nature of the DMN leads us to the following requirement. The homogenization building block must accept as input two micropolar materials _and_ return as output a micropolar material. 

In Forest et al.[61], the two-scale asymptotic homogenization method of Sanchez-Palencia[71] (see also Bensoussan et al.[72]) is used to study the homogenization of micropolar (or Cosserat) composites. The analysis results in a few disctict limits of interacting length scales of the problem. The two limits we will discuss here are called Homogenization Scheme 1 (HS1) and Homogenization Scheme 2 (HS2). For both of these limits there are three interacting length scales present: _𝑙_ = micro-scale unit cell size, _𝐿_ = macroscale body size, and _𝑙𝑐_ = elastic constitutive length scale. In HS1, _𝑙_ ∼ _𝑙𝑐 ≪𝐿_ while _𝑙_ ∕ _𝐿_ tends to zero, resulting in formulas that accept as input two micropolar materials, but returns as output a Cauchy material. However, in HS2, _𝑙≪𝑙𝑐_ ∼ _𝐿_ while _𝑙_ ∕ _𝐿_ tends to zero, resulting in formulas that accept as input two micropolar materials, and returns as output a micropolar material. Thus, HS2 in Forest et al.[61] matches the requirement defined in the last paragraph. 

The geometry chosen is the simplest possible composite: the periodic laminate. This is a convienient choice in the classical Cauchy framework, as the differential restrictions on the stress ( _𝜎𝑘𝑙,𝑘_ = 0 and _𝜎𝑘𝑙_ = _𝜎𝑙𝑘_ ) and strain ( _𝜀𝑘𝑙_ = ( _𝑢𝑘,𝑙_ + _𝑢𝑙,𝑘_ )∕2) result in stress and strain fields that are uniform in the laminate phases (see Ch. 9.5 in Milton[49]). In the micropolar case, the differential restrictions on the stresses ( _𝑡𝑘𝑙,𝑘_ = 0 and _𝑚𝑘𝑙,𝑘_ + _𝜖𝑙𝑘𝑚𝑡𝑘𝑚_ = 0) and strains ( _𝑒𝑘𝑙_ = _𝑢𝑙,𝑘_ + _𝜖𝑙𝑘𝑚𝜑𝑚_ and _𝛾𝑘𝑙_ = _𝜑𝑘,𝑙_ ) do not demand uniformity in the laminate phases. Still, it can be shown that in the case of a laminate with an arbitrary direction of lamination under HS2 ([73] with an arbitrary direction), the resulting homogenization formulas for the stiffnesses depend only on the uniform part of the micropolar stresses and strains. Additionally in this case where _𝑄_[1] _𝑘𝑙𝑚𝑛_[=] _[ 𝑄]_[2] _𝑘𝑙𝑚𝑛_[= 0][,][the][homogenized][stiffness] _𝑄𝑘𝑙𝑚𝑛_ (which encodes non-centrosymmetry) will always become the zero tensor as _𝑙_ ∕ _𝐿_ tends to zero. 

The following then, is a derivation of the micropolar homogenization building block for an arbitrarily directed laminate using apriori the assumption of uniform micropolar stress and strain in the laminate phases, as well as some of the useful ideas for the Cauchy DMN in Nguyen and Noels[52]. This approach by-passes the lengthy calulations needed in the asymptotic approach to get the same result. 

We first establish the relations between micro- and macro-scale strains. By averaging, and due to the uniformity of stresses and strains in the laminate phases, we get 

**==> picture [443 x 26] intentionally omitted <==**

where the average over the laminate body Ω is denoted ⟨⋅⟩ = |Ω1 |[∫][Ω][ ⋅][d] _[𝑣]_[,][the][volume][fractions][of][phase][1,][2][are][respectively][denoted] _𝑓_ 1, _𝑓_ 2 such that _𝑓_ 1 + _𝑓_ 2 = 1, and superscripts on the stresses and strains serve only to denote material phase. The force equilibrium and couple equilibrium across the laminate interface are given by 

**==> picture [194 x 24] intentionally omitted <==**

16 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

where _𝑛𝑘_ are the components of the interfacial normal vector **𝐧** . By again using the assumption of uniform stresses in each phase, these conditions become 

**==> picture [467 x 246] intentionally omitted <==**

which serves as the relationship between micro- and macro-scale strains once the arbitrary vectors are determined. 

To determine the unknown vectors, we specify that the micro-scale laminate is comprised of two centrosymmetric micropolar elastic materials with the following constitutive equations 

**==> picture [443 x 26] intentionally omitted <==**

and assume that the macro-scale homogenized constitutive equations are 

**==> picture [443 x 9] intentionally omitted <==**

Let us plug Eq. (A.8) into Eq. (A.2), resulting in 

**==> picture [108 x 25] intentionally omitted <==**

Substituting Eq. (A.7) into this and rearranging, we get 

 _𝑙𝑛𝑏𝑛_ = − _𝑓_ 1 _𝑓_ 2 _𝑛𝑘_ (Δ _𝐴_ ) _𝑘𝑙𝑚𝑛𝐸𝑚𝑛,_ 

33 _𝑑_ 3 = − _𝑓_ 1 _𝑓_ 2 _𝑛𝑘_ (Δ _𝐵_ )3 _𝑘_ 3 _𝑛_ Γ3 _𝑛,_ 

**==> picture [24 x 8] intentionally omitted <==**

where 

**==> picture [118 x 41] intentionally omitted <==**

We are then able to determine the unknown vectors by solving Eq. (A.10) for _𝑏𝑖_ and _𝑑_ 3 to get 

**==> picture [110 x 11] intentionally omitted <==**

**==> picture [109 x 12] intentionally omitted <==**

**==> picture [24 x 8] intentionally omitted <==**

With Eq. (A.11) in hand, we can now find the homogenization building block formula in closed-form. Do this by calculating the average stresses from Eq. (A.1), and expand them in terms of Eqs. (A.7), (A.8), and (A.11) as 

**==> picture [209 x 25] intentionally omitted <==**

**==> picture [429 x 34] intentionally omitted <==**

17 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

**==> picture [443 x 58] intentionally omitted <==**

**==> picture [467 x 45] intentionally omitted <==**

Using the same notation as Section 2.2, we can write Eq. (A.14) more abstractly as 

**==> picture [444 x 12] intentionally omitted <==**

## **Appendix B. Derivation of full-network strain equations** 

In this appendix, we derive collected, full-network versions of Eq. (A.7) using a network ordering/flattening inspired by Gajek et al.[51] and Shin et al.[53]. 

To begin, one can write Eq. (A.7) as 

**==> picture [443 x 22] intentionally omitted <==**

for _𝜂_ ∈{1 _,_ 2}. Note that this form is predicated on the assumption that the phase stresses remain constant to the leading order after the variation (or evolution) of the constitutive equations. Also, the introduced nonlinearity is not symmetry-breaking. At a node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in a layer _𝑙_ ∈{1 _,_ … _, 𝐿_ }, we can write Eq. (B.1) as 

**==> picture [174 x 45] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

where ⌈ _𝑥_ ⌉ ∶= min{ _𝑛_ ∈ ℤ | _𝑛_ ≥ _𝑥_ } is the _ceiling_ function (ex: ⌈ _𝜋_ ⌉ = 4). Iterating Eq. (B.2) once yields 

**==> picture [328 x 45] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

where we have nested ceiling functions appearing. These can be simplified by using (3.10) from Graham et al.[75], which says that for any continuous, monotonically increasing function _𝑓_ with the property that _𝑓_ ( _𝑥_ ) ∈ ℤ ⟹ _𝑥_ ∈ ℤ, we have ⌈ _𝑓_ (⌈ _𝑥_ ⌉)⌉ = ⌈ _𝑓_ ( _𝑥_ )⌉. Let _𝑥_ = _𝑛_ ∕2 and _𝑓_ ( _𝑥_ ) = _𝑥_ ∕2, so ⌈⌈ _𝑛_ ∕2⌉∕2⌉ = ⌈ _𝑛_ ∕2[2] ⌉. More generally, _𝑙_ nested divisions ⌈⌈⋯ ⌈⌈ _𝑛_ ∕2⌉∕2⌉ ⋯ ∕2⌉∕2⌉ = ⌈ _𝑛_ ∕2 _[𝑙]_ ⌉. With this, we can iterate Eq. (B.2) _𝑙_ −1 times to get 

**==> picture [443 x 59] intentionally omitted <==**

Note first that ⌈ _𝑛_ ∕2 _[𝑙]_ ⌉ = 1, since 1 ≤ _𝑛_ ≤ 2 _[𝑙]_ ⟹ 1∕2 _[𝑙]_ ≤ _𝑛_ ∕2 _[𝑙]_ ≤ 1 ⟹ 1 ≤ ⌈ _𝑛_ ∕2 _[𝑙]_ ⌉ ≤ 1 (because 1∕2 _[𝑙] <_ 1 for any _𝑙_ ∈{1 _,_ … _, 𝐿_ }). Also note that Eq. (22) may also be written as 

**==> picture [443 x 19] intentionally omitted <==**

so that we can write Eq. (B.4) as 

**==> picture [443 x 61] intentionally omitted <==**

18 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

after defining _𝑏[̃]_[(] _𝑙[𝑙,𝑛]_[)] ∶= _𝑤_[(] _[𝑙,𝑛]_[)] _𝑏_[(] _𝑙[𝑙,𝑛]_[)] and _𝑑[̃]_ 3[(] _[𝑙,𝑛]_[)] ∶= _𝑤_[(] _[𝑙,𝑛]_[)] _𝑑_ 3[(] _[𝑙,𝑛]_[)] . Let us use the following matrix-vector notation: 

**==> picture [443 x 253] intentionally omitted <==**

such that Eq. (B.6) can be written 

Setting _𝑙_ = _𝐿_ in Eq. (B.8) yields a relationship between the strains at a base layer node and the strains at the output node as 

Eq. (B.9) may be written in a collected, full-network matrix-vector form by first defining the long vectors 

**==> picture [134 x 88] intentionally omitted <==**

**==> picture [23 x 8] intentionally omitted <==**

where **𝐞** and **𝐄** are (2 _[𝐿]_ ⋅ 4) × 1 column vectors, and _**γ**_ and **Γ** are (2 _[𝐿]_ ⋅ 2) × 1 column vectors. Then, we define long vectors for the _[̃]_ **𝐛** ’s and _𝑑[̃]_ ’s as 

**==> picture [444 x 171] intentionally omitted <==**

where each sub-vector corresponds to a different layer of the network _𝑙_ ∈( _𝐿_ −1 _, 𝐿_ −2 _,_ … _,_ 2 _,_ 1 _,_ 0). _[̃]_ **𝐛** is a ((2 _[𝐿]_ −1) ⋅ 2) × 1 column vector and **𝐝** _[̃]_ is a ((2 _[𝐿]_ −1) ⋅ 1) × 1 column vector. This ordering is inspired by Gajek et al.[51] and Shin et al.[53]. Eqs. (B.10) and (B.11) allow us to collect Eq. (B.9) for all _𝑛_ ∈{1 _,_ … _,_ 2 _[𝐿]_ } and write 

**==> picture [48 x 23] intentionally omitted <==**

(B.12) 

19 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

where **𝐁** is a (2 _[𝐿]_ ) × (2 _[𝐿]_ −1) block matrix with 4 × 2 sub-matrices, and **𝐃** is a (2 _[𝐿]_ ) × (2 _[𝐿]_ −1) block matrix with 2 × 1 sub-matrices. To fill these matrices, choose a base layer node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝐿]_ }, a layer _𝑙_ ∈{1 _,_ … _, 𝐿_ }, and a node _𝑚_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } inside that layer. The base layer node _𝑛_ and the pair ( _𝑙_ −1 _,_ ⌈ _𝑚_ ∕2⌉) indexes a 4 × 2 block of **𝐁** and a 2 × 1 block of **𝐃** . If _𝑚_ ≠ ⌈ _𝑛_ ∕2 _[𝑙]_[′] ⌉ = ⌈ _𝑛_ ∕2 _[𝐿]_[−] _[𝑙]_ ⌉, the block will be **𝟎** 4×2 in **𝐁** and **𝟎** 2×1 in **𝐃** . If _𝑚_ = ⌈ _𝑛_ ∕2 _[𝑙]_[′] ⌉ = ⌈ _𝑛_ ∕2 _[𝐿]_[−] _[𝑙]_ ⌉, the block will be 

**==> picture [443 x 60] intentionally omitted <==**

in **𝐁** and 

in **𝐃** . 

## **Appendix C. Derivation of full-network interface residual equations** 

In this appendix, we derive a collected, full-network version of Eq. (A.2) using the same network ordering/flattening as Gajek et al.[51] and Shin et al.[53]. 

At a node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in a layer _𝑙_ ∈{0 _,_ … _, 𝐿_ −1}, we can write the stress parts of Eq. (A.1) as 

**==> picture [167 x 28] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

Iterating Eq. (C.1) once yields 

**==> picture [443 x 35] intentionally omitted <==**

Using Eq. (22), we may write Eq. (C.2) as 

**==> picture [443 x 55] intentionally omitted <==**

Eq. (C.3) describes the stress at a node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in layer _𝑙_ ∈{0 _,_ … _, 𝐿_ −2} in terms of the connected stresses 2 layers down (layer _𝑙_ + 2). To describe the stress at a node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in layer _𝑙_ ∈{0 _,_ … _, 𝐿_ } in terms of the connected stresses Δ _𝐿_ layers down, we write 

**==> picture [443 x 59] intentionally omitted <==**

Letting _𝑙_ + Δ _𝐿_ = _𝐿_ , we get the relationship between the stress at a general node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in layer _𝑙_ ∈{0 _,_ … _, 𝐿_ }, and the stresses to which it is connected to, in the base layer: 

**==> picture [443 x 58] intentionally omitted <==**

Let us write the laminate interface equilibrium conditions Eq. (A.2) at a node _𝑚_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in layer _𝑙_ ∈{0 _,_ … _, 𝐿_ −1} as 

**==> picture [122 x 34] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

which combined with Eq. (C.5), becomes 

**==> picture [443 x 59] intentionally omitted <==**

20 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

Let us re-index Eq. (C.7) using _𝑛_ 1 ∶= 2 _[𝐿]_[−] _[𝑙] 𝑚_ −2 _[𝐿]_[−] _[𝑙]_[−1] − _𝜂_ , and _𝑛_ 2 ∶= 2 _[𝐿]_[−] _[𝑙] 𝑚_ − _𝜂_ , resulting in 

**==> picture [443 x 61] intentionally omitted <==**

Using Eq. (B.7) along with 

**==> picture [443 x 38] intentionally omitted <==**

we can write Eq. (C.8) in matrix-vector form as 

**==> picture [309 x 61] intentionally omitted <==**

**==> picture [23 x 8] intentionally omitted <==**

Eq. (C.10) may be written in a collected, full-network matrix-vector form, similar to Eq. (B.12), by first calling the left hand sides of Eq. (C.10) force and moment residuals 

**==> picture [326 x 61] intentionally omitted <==**

**==> picture [23 x 8] intentionally omitted <==**

Introducing the long vectors for base layer stresses using the same order as Eq. (B.10) as 

**==> picture [137 x 48] intentionally omitted <==**

**==> picture [23 x 7] intentionally omitted <==**

where **𝐭** is a (2 _[𝐿]_ ⋅ 4) × 1 column vector, and **𝐦** is a (2 _[𝐿]_ ⋅ 2) × 1 column vector, and defining the following diagonal base layer weight matrices 

**==> picture [135 x 34] intentionally omitted <==**

**==> picture [23 x 8] intentionally omitted <==**

and the long vectors of the force residuals **𝐅**[(] _[𝑙,𝑚]_[)] and moment residuals _𝑀_[(] _[𝑙,𝑚]_[)] using the same ordering as Eq. (B.11), we can combine Eq. (C.11) for all nodes _𝑚_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } in all non-base layers _𝑙_ ∈{0 _,_ … _, 𝐿_ −1} and write 

**==> picture [39 x 8] intentionally omitted <==**

**==> picture [23 x 7] intentionally omitted <==**

**==> picture [43 x 7] intentionally omitted <==**

where 𝔹 is a (2 _[𝐿]_ −1) × (2 _[𝐿]_ ) block matrix with 2 × 4 sub-matrices, and 𝔻 is a (2 _[𝐿]_ −1) × (2 _[𝐿]_ ) block matrix with 1 × 2 sub-matrices. To fill these matrices, let us choose a base layer node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝐿]_ }, a non-base layer _𝑙_ ∈{0 _,_ 1 _,_ … _, 𝐿_ −1}, and a node _𝑚_ ∈{1 _,_ … _,_ 2 _[𝑙]_ } inside that layer. The pair ( _𝑙, 𝑚_ ) and the base layer node _𝑛_ indexes a 2 × 4 block of 𝔹 and a 1 × 2 block of 𝔻. If 2 _[𝐿]_[−] _[𝑙]_ ( _𝑚_ −1) + 1 ≤ _𝑛_ ≤ 2 _[𝐿]_[−] _[𝑙] 𝑚_ −2 _[𝐿]_[−] _[𝑙]_[−1] , the block will be 

**==> picture [467 x 53] intentionally omitted <==**

**==> picture [36 x 7] intentionally omitted <==**

**==> picture [467 x 29] intentionally omitted <==**

**==> picture [29 x 8] intentionally omitted <==**

21 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

in 𝔹 and 

**==> picture [442 x 23] intentionally omitted <==**

in 𝔻. If _𝑛<_ 2 _[𝐿]_[−] _[𝑙]_ ( _𝑚_ −1) + 1 or _𝑛>_ 2 _[𝐿]_[−] _[𝑙] 𝑚_ , the block will be **𝟎** 2×4 in 𝔹 and **𝟎** 1×2 in 𝔻. 

It turns out that 𝔹[T] = **𝐁** and 𝔻[T] = **𝐃** from Eq. (B.12) as follows. First, we show that the location of the block-zero entries of 𝔹[T] and **𝐁** , as well as 𝔻[T] and **𝐃** , are the same. This is equivalent to asking if 

**==> picture [443 x 20] intentionally omitted <==**

for _𝑚_ 1 ∈{1 _,_ … _,_ 2 _[𝑙]_[1] } for _𝑙_ 1 ∈{1 _,_ … _, 𝐿_ } and _𝑚_ 2 ∈{1 _,_ … _,_ 2 _[𝑙]_[2] } for _𝑙_ 2 ∈{0 _,_ … _, 𝐿_ −1}, where _𝑙_ 2 = _𝑙_ 1 −1 and _𝑚_ 2 = ⌈ _𝑚_ 1∕2⌉. To show this, we rewrite Eq. (C.19) as 

**==> picture [443 x 21] intentionally omitted <==**

and we get 

and 

**==> picture [443 x 59] intentionally omitted <==**

so the block-zero entries of 𝔹[T] and **𝐁** , as well as 𝔻[T] and **𝐃** , are the same. Second, we need to show that the non-zero block entries of 𝔹[T] and **𝐁** , as well as 𝔻[T] and **𝐃** , are the same. To do this, we just need to compare Eq. (B.13) with Eqs. (C.15) and (C.17) and Eq. (B.14) with Eqs. (C.16) and (C.18) using the appropriate indices _𝑚_ 1, _𝑙_ 1, _𝑚_ 2, and _𝑙_ 2. We then have the following 

**==> picture [443 x 39] intentionally omitted <==**

and 

**==> picture [443 x 39] intentionally omitted <==**

given that _𝑙_ 1 = _𝑙_ 2 + 1. This implies that non-zero block entries of 𝔹[T] and **𝐁** , as well as 𝔻[T] and **𝐃** , are the same. We therefore can write Eq. (C.14) as the following 

**==> picture [443 x 22] intentionally omitted <==**

## **Appendix D. Derivation of consistent (algorithmic) tangents in micropolar elastoplasticity** 

Using the same notation as Francis et al.[32], in this appendix we derive the consistent tangent tensors for the micropolar elastoplastic problem. The indices ∈{1 _,_ 2 _,_ 3}, unless stated otherwise. 

We start with Eq. (B2) in Francis et al.[32]. This is obtained by (i) taking the time derivative of the three-dimensional version of Eq. (3) (with _𝑒𝑚𝑛_ replaced by _𝑒_[e] _𝑚𝑛_[and] _[𝛾][𝑚𝑛]_[replaced][by] _[𝛾] 𝑚𝑛_[e][),][(ii)][plugging][in][the][three-dimensional][version][of][Eq.][(5)][as][well][as][the] flow rules defined in Eqs. (11), (19), (20), and (23) of Francis et al.[32], and (iii) applying Euler-Backward and defining the known elastic “trial” stresses as done in Eq. (30) of Francis et al.[32]. This results in the following form of the stresses at time _𝑡𝑛_ +1 

**==> picture [443 x 47] intentionally omitted <==**

Assuming that _𝑎_ 2 = _𝑎_ 1( _𝜇_ ∕ _𝜅_ ), _𝛼_ = 0, _𝑏_ 2 = _𝑏_ 1( _𝛾_ + _𝛽_ )∕( _𝛾_ − _𝛽_ ), we get 

**==> picture [443 x 42] intentionally omitted <==**

22 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

Then, under the same assumptions, it can be proven that 

**==> picture [442 x 54] intentionally omitted <==**

so that Eq. (D.2) can be written as 

**==> picture [154 x 53] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

For the consistent tangent, we take derivatives of Eq. (D.4) with respect to the strains at time _𝑡𝑛_ +1 to get 

**==> picture [442 x 54] intentionally omitted <==**

First, 

**==> picture [60 x 49] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

Second, given the following equations for the plastic strains at time _𝑡𝑛_ +1, 

**==> picture [443 x 49] intentionally omitted <==**

we can get their derivatives as 

**==> picture [285 x 125] intentionally omitted <==**

Third, we have 

**==> picture [19 x 8] intentionally omitted <==**

**==> picture [19 x 8] intentionally omitted <==**

Using Eq. (D.6) and the chain rule, we can write 

**==> picture [442 x 55] intentionally omitted <==**

and after using the derivatives in Eq. (D.8), we can write 

**==> picture [442 x 55] intentionally omitted <==**

23 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

Plugging Eqs. (D.6), (D.8) and (D.11) into Eq. (D.5), we can write the micropolar elastoplastic consistent tangents as 

and 

**==> picture [442 x 110] intentionally omitted <==**

For 2-D plane-strain, in Eq. (D.12) the indices range only from 1 to 2, and Eq. (D.13) is written as 

**==> picture [442 x 36] intentionally omitted <==**

with indices again ranging from 1 to 2. Taking the ordering defined in Eqs. (B.7) and (C.9), we can write the components of Eq. (D.12) at a node _𝑛_ ∈{1 _,_ … _,_ 2 _[𝐿]_ } in the base layer _𝑙_ = _𝐿_ as the following 4 × 4 matrix 

**==> picture [443 x 53] intentionally omitted <==**

and the components of Eq. (D.14) can be written as the following 2 × 2 matrix 

**==> picture [443 x 46] intentionally omitted <==**

We then collect all consistent material tangents at the nodes in the base layer in block diagonal matrices as 

**==> picture [443 x 34] intentionally omitted <==**

where **𝐊** 1 is a (2 _[𝐿]_ ⋅ 4) × (2 _[𝐿]_ ⋅ 4) matrix, and **𝐊** 2 is a (2 _[𝐿]_ ⋅ 2) × (2 _[𝐿]_ ⋅ 2) matrix. 

## **References** 

- [1] Z.P. Bažant, Size effect, Int. J. Solid. Struct. 37 (1–2) (2000) 69–80. https://doi.org/10.1016/S0020-7683(99)00077-3 

- [2] A.C. Eringen, Nonlinear Theory of Continuous Media, McGraw-Hill, 1962. 

- [3] J.C. Simo, T.J.R. Hughes, Computational Inelasticity, 7, Springer Science & Business Media, 2006. https://doi.org/10.1007/b98904 

- [4] E.M.P. Cosserat, F. Cosserat, Théorie des Corps Déformables, A. Hermann et fils, 1909. 

- [5] A.C. Eringen, Linear theory of micropolar elasticity, J. Math. Mech. 15 (6) (1966) 909–923. https://www.jstor.org/stable/24901442. 

- [6] A.C. Eringen, Theory of micropolar elasticity, in: Fracture: An Advanced Treatise, 2, Academic Press, 1968, pp. 621–729. 

- [7] A. Sawczuk, On yielding of Cosserat continua, Arch. Mech. 19 (3) (1967) 471–480. 

- [8] H. Lippmann, A Cosserat theory of plastic flow, Acta Mech. 8 (3–4) (1969) 255–284. https://doi.org/10.1007/BF01182264 

- [9] D. Besdo, A contribution to the nonlinear theory of the Cosserat-continuum, Acta Mech. 20 (1974) 105–131. https://doi.org/10.1007/BF01374965 

- [10] R. de Borst, A generalisation of _𝐽_ 2-flow theory for polar continua, Comput. Method. Appl. Mech. Eng. 103 (3) (1993) 347–362. https://doi.org/10.1016/ 0045-7825(93)90127-J 

- [11] P. Steinmann, C. Miehe, E. Stein, Comparison of different finite deformation inelastic damage models within multiplicative elastoplasticity for ductile materials, Comput. Mech. 13 (1994) 458–474. https://doi.org/10.1007/BF00374241 

- [12] P. Grammenoudis, C. Tsakmakis, Hardening rules for finite deformation micropolar plasticity: restrictions imposed by the second law of thermodynamics and the postulate of Il’iushin, Contin. Mech. Thermodyn. 13 (5) (2001) 325–363. https://doi.org/10.1007/s001610100055 

- [13] S. Forest, R. Sievert, Elastoviscoplastic constitutive frameworks for generalized continua, Acta Mech. 160 (1) (2003) 71–111. https://doi.org/10.1007/ s00707-002-0975-0 

- [14] P. Neff, A finite-strain elastic–plastic Cosserat theory for polycrystals with grain rotations, Int. J. Eng. Sci. 44 (8–9) (2006) 574–594. https://doi.org/10.1016/j. ijengsci.2006.04.002 

- [15] R. Russo, S. Forest, F.A. Girot Mata, Thermomechanics of Cosserat medium: modeling adiabatic shear bands in metals, Contin. Mech. Thermodyn. (2020) 1–20. https://doi.org/10.1007/s00161-020-00930-z 

- [16] E. Kröner, Elasticity theory of materials with long range cohesive forces, Int. J. Solid. Struct. 3 (5) (1967) 731–742. https://doi.org/10.1016/0020-7683(67) 90049-2 

- [17] A.C. Eringen, D.G.B. Edelen, On nonlocal elasticity, Int. J. Eng. Sci. 10 (3) (1972) 233–248. https://doi.org/10.1016/0020-7225(72)90039-0 

- [18] N. Triantafyllidis, S. Bardenhagen, The influence of scale size on the stability of periodic solids and the role of associated higher order gradient continuum models, J. Mech. Phys. Solid. 44 (11) (1996) 1891–1928. https://doi.org/10.1016/0022-5096(96)00047-6 

24 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

- [19] Z.P. Bažant, M. Jirásek, Nonlocal integral formulations of plasticity and damage: survey of progress, J. Eng. Mech. 128 (11) (2002) 1119–1149. https://doi.org/ 10.1061/(ASCE)0733-9399(2002)128:11(1119) 

- [20] S. Forest, Homogenization methods and mechanics of generalized continua - part 2, Theor. Appl. Mech. (28–29) (2002) 113–144. https://doi.org/10.2298/ TAM0229113F 

- [21] A.C. Eringen, E.S. Suhubi, Nonlinear theory of simple micro-elastic solids–I, Int. J. Eng. Sci. 2 (2) (1964) 189–203. https://doi.org/10.1016/0020-7225(64) 90004-7 

- [22] R.D. Mindlin, Micro-structure in linear elasticity, Arch. Ration. Mech. An. 16 (1964) 51–78. https://doi.org/10.1007/BF00248490 

[23] K. Matouš, M.G.D. Geers, V.G. Kouznetsova, A. Gillman, A review of predictive nonlinear theories for multiscale modeling of heterogeneous materials, J. Comput. Phys. 330 (2017) 192–220. https://doi.org/10.1016/j.jcp.2016.10.070 [24] J. Fish, G.J. Wagner, S. Keten, Mesoscopic and multiscale modelling in materials, Nat. Mater. 20 (6) (2021) 774–786. https://doi.org/10.1038/ s41563-020-00913-0 [25] T.J.R. Hughes, The Finite Element Method: Linear Static and Dynamic Finite Element Analysis, Dover Civil and Mechanical Engineering, Dover Publications Incorporated, 2003. https://books.google.com/books?id=E9IoAwAAQBAJ. [26] H. Moulinec, P. Suquet, A numerical method for computing the overall response of nonlinear composites with complex microstructure, Comput. Method. Appl. Mech. Eng. 157 (1–2) (1998) 69–94. https://doi.org/10.1016/S0045-7825(97)00218-1 [27] J.C. Michel, H. Moulinec, P. Suquet, A computational method based on augmented Lagrangians and fast Fourier transforms for composites with high contrast, CMES–Comp. Model. Eng. 1 (2) (2000) 79–88. https://doi.org/10.3970/cmes.2000.001.239 [28] J.C. Michel, H. Moulinec, P. Suquet, A computational scheme for linear and non-linear composites with arbitrary phase contrast, Int. J. Numer. Meth. Eng. 52 (1–2) (2001) 139–160. https://doi.org/10.1002/nme.275 [29] R.A. Lebensohn, N-Site modeling of a 3D viscoplastic polycrystal using fast Fourier transform, Acta Mater. 49 (14) (2001) 2723–2737. https://doi.org/10.1016/ S1359-6454(01)00172-0 [30] R.A. Lebensohn, A.K. Kanjarla, P. Eisenlohr, An elasto-viscoplastic formulation based on fast Fourier transforms for the prediction of micromechanical fields in polycrystalline materials, Int. J. Plast. 32 (2012) 59–69. https://doi.org/10.1016/j.ijplas.2011.12.005 [31] N.M. Francis, F. Pourahmadian, R.A. Lebensohn, R. Dingreville, A fast Fourier transform-based solver for elastic micropolar composites, Comput. Method. Appl. Mech. Eng. 418 (2024) 116510. https://doi.org/10.1016/j.cma.2023.116510 [32] N.M. Francis, R.A. Lebensohn, F. Pourahmadian, R. Dingreville, Micropolar elastoplasticity using a fast Fourier transform-based solver, Int. J. Numer. Method. Eng. 126 (1) (2025) e7651. https://doi.org/10.1002/nme.7651 [33] F. Feyel, Multiscale FE[2] elastoviscoplastic analysis of composite structures, Comput. Mater. Sci. 16 (1–4) (1999) 344–354. https://doi.org/10.1016/ S0927-0256(99)00077-4 [34] F. Feyel, J.L. Chaboche, FE[2] multiscale approach for modelling the elastoviscoplastic behaviour of long fibre SiC/Ti composite materials, Comput. Method. Appl. Mech. Eng. 183 (3–4) (2000) 309–330. https://doi.org/10.1016/S0045-7825(99)00224-8 [35] F. Feyel, A multilevel finite element method (FE[2] ) to describe the response of highly non-linear structures using generalized continua, Comput. Method. Appl. Mech. Eng. 192 (28–30) (2003) 3233–3244. https://doi.org/10.1016/S0045-7825(03)00348-7 [36] J. Schröder, A numerical two-scale homogenization scheme: the FE[2] -method, in: Plasticity and Beyond: Microstructures, Crystal-Plasticity and Phase Transitions, Springer, 2014, pp. 1–64. https://doi.org/10.1007/978-3-7091-1625-8_1 [37] V.B.C. Tan, K. Raju, H.P. Lee, Direct FE[2] for concurrent multilevel modelling of heterogeneous structures, Comput. Method. Appl. Mech. Eng. 360 (2020) 112694. https://doi.org/10.1016/j.cma.2019.112694 [38] J. Spahn, H. Andrä, M. Kabel, R. Müller, A multiscale approach for modeling progressive damage of composite materials using fast Fourier transforms, Comput. Method. Appl. Mech. Eng. 268 (2014) 871–883. https://doi.org/10.1016/j.cma.2013.10.017 [39] J. Kochmann, S. Wulfinghoff, S. Reese, J.R. Mianroodi, B. Svendsen, Two-scale FE–FFT- and phase-field-based computational modeling of bulk microstructural evolution and macroscopic material behavior, Comput. Method. Appl. Mech. Eng. 305 (2016) 89–110. https://doi.org/10.1016/j.cma.2016.03.001 [40] J. Kochmann, S. Wulfinghoff, L. Ehle, J. Mayer, B. Svendsen, S. Reese, Efficient and accurate two-scale FE-FFT-based prediction of the effective material behavior of elasto-viscoplastic polycrystals, Comput. Mech. 61 (2018) 751–764. https://doi.org/10.1007/s00466-017-1476-2 [41] M. Rambausek, F.S. Göküzüm, L.T.K. Nguyen, M.A. Keip, A two-scale FE-FFT approach to nonlinear magneto-elasticity, Int. J. Numer. Method. Eng. 117 (11) (2019) 1117–1142. https://doi.org/10.1002/nme.5993 [42] C. Gierden, J. Kochmann, J. Waimann, B. Svendsen, S. Reese, A review of FE-FFT-based two-scale methods for computational modeling of microstructure evolution and macroscopic material behavior, Arch. Comput. Method. Eng. 29 (6) (2022) 4115–4135. https://doi.org/10.1007/s11831-022-09735-6 [43] X. Liu, S. Tian, F. Tao, W. Yu, A review of artificial neural networks in the constitutive modeling of composite materials, Compos. B: Eng. 224 (2021) 109152. https://doi.org/10.1016/j.compositesb.2021.109152 [44] B.A. Le, J. Yvonnet, Q.C. He, Computational homogenization of nonlinear elastic materials using neural networks, Int. J. Numer. Method. Eng. 104 (12) (2015) 1061–1084. https://doi.org/10.1002/nme.4953 [45] M.B. Gorji, M. Mozaffar, J.N. Heidenreich, J. Cao, D. Mohr, On the potential of recurrent neural networks for modeling path dependent plasticity, J. Mech. Phys. Solid. 143 (2020) 103972. https://doi.org/10.1016/j.jmps.2020.103972 [46] F. As’ad, C. Farhat, A mechanics-informed deep learning framework for data-driven nonlinear viscoelasticity, Comput. Method. Appl. Mech. Eng. 417 (2023) 116463. https://doi.org/10.1016/j.cma.2023.116463 [47] Z. Liu, C.T. Wu, M. Koishi, A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials, Comput. Method. Appl. Mech. Eng. 345 (2019) 1138–1168. https://doi.org/10.1016/j.cma.2018.09.020 [48] K.E. Clark, G.W. Milton, Modelling the effective conductivity function of an arbitrary two–dimensional polycrystal using sequential laminates, Proc. R Soc. Edinb. A: Math. 124 (4) (1994) 757–783. [49] G.W. Milton, The theory of composites, SIAM, 2022. [50] Z. Liu, C.T. Wu, Exploring the 3D architectures of deep material network in data-driven multiscale mechanics, J. Mech. Phys. Solid. 127 (2019) 20–46. https: //doi.org/10.1016/j.jmps.2019.03.004 [51] S. Gajek, M. Schneider, T. Böhlke, On the micromechanics of deep material networks, J. Mech. Phys. Solid. 142 (2020) 103984. https://doi.org/10.1016/j.jmps. 2020.103984 [52] V. Nguyen, L. Noels, Micromechanics-based material networks revisited from the interaction viewpoint; robust and efficient implementation for multi-phase composites, Eur. J. Mech. A/Solid. 91 (2022) 104384. https://doi.org/10.1016/j.euromechsol.2021.104384 [53] D. Shin, R. Alberdi, R.A. Lebensohn, R. Dingreville, Deep material network via a quilting strategy: visualization for explainability and recursive training for improved accuracy, npj Comput. Mater. 9 (1) (2023) 128. https://doi.org/10.1038/s41524-023-01085-6 

- [54] D. Shin, R. Alberdi, R.A. Lebensohn, R. Dingreville, A deep material network approach for predicting the thermomechanical response of composites, Compos. B: Eng. 272 (2024a) 111177. https://doi.org/10.1016/j.compositesb.2023.111177 

- [55] D. Shin, P.J. Creveling, S.A. Roberts, R. Dingreville, Deep material network for thermal conductivity problems: application to woven composites, Comput. Method. Appl. Mech. Eng. 431 (2024b) 117279. https://doi.org/10.1016/j.cma.2024.117279 

- [56] S. Gajek, M. Schneider, T. Böhlke, An FE–DMN method for the multiscale analysis of short fiber reinforced plastic components, Comput. Method. Appl. Mech. Eng. 384 (2021) 113952. https://doi.org/10.1016/j.cma.2021.113952 

- [57] S. Gajek, M. Schneider, T. Böhlke, An FE-DMN method for the multiscale analysis of thermomechanical composites, Comput. Mech. 69 (5) (2022) 1087–1113. https://doi.org/10.1007/s00466-021-02131-0 

- [58] S. Forest, K. Sab, Cosserat overall modeling of heterogeneous materials, Mech. Res. Commun. 25 (4) (1998) 449–454. https://doi.org/10.1016/S0093-6413(98) 00059-7 

25 

_Computer Methods in Applied Mechanics and Engineering 446 (2025) 118329_ 

_N.M. Francis et al._ 

- [59] M.D. McKay, R.J. Beckman, W.J. Conover, A comparison of three methods for selecting values of input variables in the analysis of output from a computer code, Technometrics 42 (1) (2000) 55–61. https://doi.org/10.2307/1268522 

- [60] M. Neuner, P. Gamnitzer, G. Hofstetter, A 3D gradient-enhanced micropolar damage-plasticity approach for modeling quasi-brittle failure of cohesive-frictional materials, Comput. Struct. 239 (2020) 106332. https://doi.org/10.1016/j.compstruc.2020.106332 

- [61] S. Forest, F. Pradel, K. Sab, Asymptotic analysis of heterogeneous Cosserat media, Int. J. Solid. Struct. 38 (26–27) (2001) 4585–4608. https://doi.org/10.1016/ S0020-7683(00)00295-X 

- [62] A. Paszke, S. Gross, F. Massa, A. Lerer, J. Bradbury, G. Chanan, T. Killeen, Z. Lin, N. Gimelshein, L. Antiga, et al., Pytorch: an imperative style, high-performance deep learning library, Adv. Neural Inf. Process. Syst. 32 (2019). https://doi.org/10.48550/arXiv.1912.01703 

- [63] D.P. Kingma, J. Ba, Adam: A method for stochastic optimization, arXiv:1412.6980 (2014). 

- [64] S.J. Reddi, S. Kale, S. Kumar, On the convergence of Adam and beyond, arXiv:1904.09237 (2019). 

- [65] I. Loshchilov, F. Hutter, SGDR: stochastic gradient descent with warm restarts, arXiv:1608.03983 (2016). 

- [66] F. Pradel, K. Sab, Cosserat modelling of elastic periodic lattice structures, C R Acad. Sci, Ser. IIB: Mech., Phys., Astron. 326 (11) (1998) 699–704. https: //doi.org/10.1016/S1251-8069(98)80002-X 

- [67] K. Sab, F. Pradel, Homogenisation of periodic Cosserat media, Int. J. Comput. Appl. Technol. 34 (1) (2009) 60–71. https://doi.org/10.1504/IJCAT.2009.022703 

- [68] G. Molnár, N. Blal, Topology optimization of periodic beam lattices using Cosserat elasticity, Comput. Struct. 281 (2023) 107037. https://doi.org/10.1016/j. compstruc.2023.107037 

- [69] A. Bacigalupo, M.L. De Bellis, G. Zavarise, Asymptotic homogenization approach for anisotropic micropolar modeling of periodic Cauchy materials, Comput. Method. Appl. Mech. Eng. 388 (2022) 114201. https://doi.org/10.1016/j.cma.2021.114201 

- [70] Q.S. Zheng, A.J.M. Spencer, On the canonical representations for Kronecker powers of orthogonal tensors with application to material symmetry problems, Int. J. Eng. Sci. 31 (4) (1993) 617–635. https://doi.org/10.1016/0020-7225(93)90054-X 

- [71] E. Sanchez-Palencia, Comportements local et macroscopique d’un type de milieux physiques heterogenes, Int. J. Eng. Sci. 12 (4) (1974) 331–351. https://doi. org/10.1016/0020-7225(74)90062-7 

- [72] A. Bensoussan, J.-L. Lions, G. Papanicolaou, Asymptotic Analysis for Periodic Structures, 374, American Mathematical Soc., 2011. 

- [73] R. Rodríguez-Ramos, V. Yanes, Y. Espinosa-Almeyda, J.A. Otero, F.J. Sabina, C.F. Sánchez-Valdés, F. Lebon, Micro–macro asymptotic approach applied to heterogeneous elastic micropolar media. Analysis of some examples, Int. J. Solid. Struct. 239 (2022) 111444. https://doi.org/10.1016/j.ijsolstr.2022.111444 

- [74] X. Li, Q. Liu, A version of Hill’s lemma for Cosserat continuum, Acta Mech. Sinica 25 (4) (2009) 499–506. https://doi.org/10.1007/s10409-009-0231-0 

- [75] R.L. Graham, D.E. Knuth, O. Patashnik, Concrete Mathematics: A Foundation for Computer Science, Addison-Wesley, 1989. 

26 

