---
title: "Deep Material Network: Overview, Applications, and Current Directions"
arxiv: "2504.12159"
authors: ["Ting-Ju Wei"]
year: 2025
source: paper
ingested: 2026-05-03
sha256: 1a6f271fd5b3513a06625d0f4108841184104965f26d2f31dddb0983ec2e7aa7
conversion: pymupdf4llm
---

# DEEP MATERIAL NETWORK: OVERVIEW, APPLICATIONS, AND CURRENT DIRECTIONS 

**Ting-Ju Wei Wen-Ning Wan** Department of Civil Engineering Department of Civil Engineering National Taiwan University National Taiwan University Taipei, Taiwan Taipei, Taiwan 

**Chuin-Shan Chen** _[∗]_ 

Department of Civil Engineering Department of Materials Science and Engineering National Taiwan University Taipei, Taiwan 

March 23, 2026 

## **ABSTRACT** 

The Deep Material Network (DMN) has emerged as a powerful framework for multiscale materials modeling, enabling efficient and accurate prediction of material behavior across different length scales. Unlike conventional data-driven approaches, the trainable parameters in DMN possess clear physical interpretations-they encode the geometric characteristics of representative volume elements (RVEs) rather than serving as purely statistical fitting parameters . By employing a hierarchical tree structure, DMN learns the homogenization behavior associated with microstructural geometry. Consequently, it can be trained exclusively on linear elastic datasets while effectively extrapolating to nonlinear responses during online prediction, making it a highly efficient and scalable approach for multiscale simulations. From a broader perspective, DMN can be viewed as a physics-informed reduced-order model that captures the essential micromechanical features governing macroscopic behavior. Its hierarchical formulation provides a compact yet interpretable representation of the RVE response, significantly reducing computational costs compared to direct numerical simulations. This review elaborates on the theoretical foundation, training methodology, and recent extensions of DMN, emphasizing its role as a unifying framework that connects data-driven learning with physically interpretable multiscale modeling. 

_**K**_ **eywords** Deep material network _·_ Multiscale modeling _·_ Crystal plasticity _·_ Hyperelasticity _·_ Nonlinear plasticity _·_ Composite materials 

## **1 Introduction** 

Multiscale simulation methods are indispensable in computational mechanics for bridging the gap between microstructural features and macroscopic material behavior. Many engineering materials, such as polycrystals, composites, and porous media, exhibit pronounced heterogeneities that strongly influence their overall mechanical response. Accurately capturing these effects requires numerical approaches that incorporate microscale details while maintaining manageable computational cost. 

> _∗_ Corresponding author. Email: `dchen@ntu.edu.tw` This version of the article has been accepted for publication, after peer review (when applicable) and is subject to Springer Nature’s AM terms of use, but is not the Version of Record and does not reflect post-acceptance improvements, or any corrections. The Version of Record is available online at: `https://doi.org/10.1007/s42493-026-00146-4` 

A PREPRINT - MARCH 23, 2026 

A widely adopted strategy is the representative volume element (RVE), which statistically characterizes material heterogeneity [1, 2, 3, 4, 5]. By imposing macroscopic boundary conditions on the RVE, full-field methods like the finite element method (FEM) or fast Fourier transform (FFT)- based solvers can resolve detailed internal stress and strain fields [6, 7, 8, 9, 10]. FEM provides flexibility for handling complex geometries, whereas FFT-based solvers exploit spectral formulations to achieve high computational efficiency in periodic domains. 

Despite their benchmark-level accuracy, full-field simulations incur a computational cost that scales steeply with microstructural complexity and nonlinear material behavior. Such expense retricts their applicability in large-scale or real-time analyses, motivating the development of physics- informed surrogate models that can reproduce RVE responses at substantially reduced computational expense. 

Machine-learning-based surrogate models have therefore emerged as a promising avenue for accelerating multiscale materials modeling [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]. However, purely data-driven approaches typically require large training datasets and often suffer from limited extrapolation capability, necessitating retraining when microstructural morphology or constitutive behavior changes. 

To address these limitations, the Deep Material Network (DMN) was introduced as a physics-informed surrogate model for multiscale simulation [21, 22]. In DMN, the effective response of an RVE is decomposed into multiple subdomains, each associated with a constituent (base) material. These subdomains are hierarchically organized within a binary-tree–based architecture, where each node represents a local homogenization operation between two child subdomains, governed by analytical formulations. 

Within each tree node, the homogenization problem is fully characterized by a small set of microstructure-related parameters, such as volume fractions and stress equilibrium directions. As a result, the network parameters encode the underlying microstructural geometry rather than constitutive nonlinearity, enabling the DMN to be trained solely using linear elastic stiffness data. 

The offline training procedure and numerical implementation of the DMN were systematically organized and rigorously analyzed by Srinivas et al. [23], providing a comprehensive understanding of the model’s learning mechanism and computational characteristics. Once trained, DMN demonstrates remarkable generalization beyond the linearelastic regime, accurately predicting the first-order nonlinear material responses with high fidelity [24]. 

This article provides a comprehensive overview of the DMN framework, including its fundamental principles, recent methodological developments, and practical applications. Section 2 introduces the original DMN architecture and its theoretical foundation. Section 3 explores recent extensions, such as multiphysics coupling and enhanced generalization across diverse microstructures. Section 4 highlights key applications, including component-scale multiscale analysis and inverse parameter identification. Finally, Section 5 concludes with a summary of current insights and an outlook on future directions for expanding DMN’s scope in multiscale materials modeling. 

## **2 Deep Material Network** 

This section provides a comprehensive overview of the original three-dimensional DMN architecture, emphasizing its hierarchical representation, theoretical foundation, and computational workflow. It begins with the formulation of the fundamental building block, followed by the offline training procedure for learning the homogenization behavior of RVEs, and the online prediction algorithm that enables extrapolation to nonlinear material responses. Finally, the rationale behind the DMN formulation is presented to clarify its role as a physics-informed reduced-order representation of microstructure–property relationships. 

## **2.1 Hierarchical structure of DMN** 

DMN employs a hierarchical architecture to approximate the response of an RVE. As shown in Fig. 1, DMN is structured as a binary tree with _N_ layers. The root node at Layer 1 represents the effective response of the RVE, while the bottom layer ( _N_ ) contains 2 _[N][−]_[1] nodes, each corresponding to a constituent material phase. Additionally, DMN consists of 2 _[N] −_ 1 fundamental building blocks, each denoted as _Bi[k]_[, where] _[ i]_[ represents the depth of the network and] _k_ indexes the building block. 

2 

A PREPRINT - MARCH 23, 2026 

**==> picture [460 x 183] intentionally omitted <==**

**----- Start of picture text -----**<br>
Output<br>Layer 1<br>Building block<br>Bottom layer  N<br>Input<br>(a) Homogenization process of stiffness matrices. (b) Trainable weight      calculation process.<br>**----- End of picture text -----**<br>


Figure 1: Schematic representation of the data flow in the DMN framework. (a) Homogenization process of stiffness matrices, where the hierarchical network structure recursively aggregates local stiffness components to compute the effective stiffness **C**[RVE] . (b) Calculation of trainable weights **w** , which parametrize the contributions of different building blocks within the hierarchical architecture. 

To quantify the contribution of each constituent material phase, DMN introduces a weighting factor _wi[k]_[at index] _[ k]_[ and] layer _i_ within each building block, as shown in Fig. 1(b). The trainable parameters _z[k]_ are defined at the bottom nodes, where the weighting factor _w[k]_ is activated using the ReLU function [25]: 

**==> picture [307 x 12] intentionally omitted <==**

The weighting factor _w[k]_ represents the relative contribution of each bottom node. Due to the hierarchical nature of the DMN, the weighting factors are progressively accumulated across layers and summed at the parent nodes, ensuring a consistent aggregation of contributions: 

**==> picture [279 x 14] intentionally omitted <==**

This hierarchical accumulation enables DMN to capture the interaction between material phases while preserving physical consistency. 

## **2.2 Mechanistic building block** 

This subsection outlines the theoretical foundation of the DMN building block, which serves as the fundamental computational unit for hierarchical homogenization. The homogenization function within each building block is derived from the principles of linear elasticity; therefore, the offline training data employed in DMN are generated from linear elastic simulations. 

Both the stress _σ_ and strain _ε_ tensors are expressed in terms of the Cauchy stress and infinitesimal strain, respectively, using Mandel notation to maintain consistency throughout the formulation: 

and 

**==> picture [382 x 58] intentionally omitted <==**

The macroscopic constitutive relationship is expressed as: 

**==> picture [256 x 11] intentionally omitted <==**

3 

A PREPRINT - MARCH 23, 2026 

For a building block comprising two constituent phases, denoted as phase 1 and phase 2, the local stress–strain relationships are given by: 

**==> picture [289 x 12] intentionally omitted <==**

where **C**[¯] 1 and **C** ¯ 2 represent the homogenized stiffness matrices of phases 1 and 2, respectively. 

For a building block located at layer _i_ and index _k_ , the contribution of each phase is weighted by its corresponding volume fraction _f[α]_ , computed as: 

**==> picture [304 x 29] intentionally omitted <==**

where _wi_ +1 denotes the weighting factors associated with the child nodes at the next layer. 

These volume fractions quantify the relative contribution of the two phases within the building block. 

Each building block _Bi[k]_[performs two sequential operations, as illustrated in Fig. 2:] 

1. _Stiffness homogenization_ : Computes an intermediate homogenized stiffness matrix **C** _[k] i_[by][aggregating][the] stiffness tensors of its two child nodes according to micromechanical equilibrium. 

2. _Rotation_ : Transforms the intermediate homogenized stiffness **C** _[k] i_[into] **[C]**[¯] _[k] i_[through a local coordinate rotation] parameterized by the trainable angles _αi[k]_[,] _[β] i[k]_[,][and] _[γ] i[k]_[.][This][rotation][enhances][the][expressiveness][of][the] homogenization function and enables the network to capture anisotropic behavior. 

**==> picture [187 x 67] intentionally omitted <==**

**----- Start of picture text -----**<br>
Rotation:<br>Homogenization:<br>**----- End of picture text -----**<br>


Figure 2: Schematic illustration of the homogenization process within a building block _Bi[k]_[.] 

## **2.2.1 Stiffness homogenization function** 

The stiffness homogenization function _H_ in the DMN is derived from the interfacial equilibrium condition, leading to an analytical expression for the effective stiffness of a two-phase building block. The interface between the two constituent phases is assumed to be oriented normal to the 3-direction. Under this assumption, strain compatibility is enforced along the 1–2 directions, while traction equilibrium is satisfied along the 3-direction. A detailed derivation of this formulation can be found in [22]. Following this analytical framework, the intermediate homogenized stiffness matrix **C** can be expressed as: 

**==> picture [284 x 48] intentionally omitted <==**

where ∆ **C** = **C**[¯] 1 _−_ **C** ¯ 2 is the stiffness difference between the two phases, and **s** 1 is the strain concentration tensor of phase 1, which determines the strain of phase 1 within the building block. The strain concentration tensor **s**[1] satisfies: 

**==> picture [345 x 14] intentionally omitted <==**

where the subscripts denote the row and column indices of the respective submatrix. 

4 

A PREPRINT - MARCH 23, 2026 

The submatrix **s** 3 _×_ 6 is given by: 

where 

**==> picture [380 x 64] intentionally omitted <==**

and 

**==> picture [293 x 38] intentionally omitted <==**

Here, the subscripts in ∆ _C_ and _C_[ˆ] denote the corresponding row and column indices of the matrices ∆ **C** and **C**[ˆ] , respectively. 

## **2.2.2 Rotation function** 

The rotation function _R_ in DMN is parameterized using the Tait-Bryan angles ( _α, β, γ_ ). The corresponding rotation matrix **R** is expressed as the product of three elemental rotation matrices: 

**==> picture [296 x 11] intentionally omitted <==**

This rotation matrix is used to transform the intermediate homogenized stiffness matrix **C** , obtained from Eq (8), into its rotated counterpart **C**[¯] : 

**==> picture [297 x 13] intentionally omitted <==**

The individual elemental rotation matrices **X** ( _α_ ), **Y** ( _β_ ), and **Z** ( _γ_ ) define rotations about the _x_ -, _y_ -, and _z_ -axes, respectively. The subscripts in the following equations indicate the positions of the corresponding matrix components in the elemental rotation matrices, structured in Mandel notation: 

**==> picture [372 x 42] intentionally omitted <==**

Here, **r** _[p]_ and **r** _[ν]_ denote the in-plane and out-of-plane rotation matrices, respectively. Given an arbitrary input angle _θ_ , these matrices are defined as: 

**==> picture [359 x 66] intentionally omitted <==**

## **2.3 Offline training** 

The offline training process in the DMN corresponds to the homogenization procedure, during which the network learns to map the stiffness properties of constituent phases to the homogenized response of an RVE. Using the stiffness matrices of two constituent phases, **C** _[p]_[1] and **C** _[p]_[2] , as input, it computes the homogenized stiffness matrix **C**[DMN] , in accordance with Eq. (17). For brevity, the set of trainable parameters in the DMN is collectively denoted as (ˆ _z,_ ˆ _α, β,_[ˆ] ˆ _γ_ ). 

**==> picture [399 x 16] intentionally omitted <==**

The training dataset consists of stiffness matrices, where each sample is represented as a triplet ( **C** _[p]_[1] _,_ **C** _[p]_[2] _,_ **C**[DNS] ). Here, **C** _[p]_[1] and **C** _[p]_[2] denote the stiffness matrices of the individual phases, while **C**[DNS] represents the homogenized 

5 

A PREPRINT - MARCH 23, 2026 

stiffness matrix obtained from direct numerical simulations (DNS). The goal is to exploit the contrast between **C** _[p]_[1] and **C** _[p]_[2] , allowing the DMN to infer the underlying geometric characteristics of the RVE through data-driven learning. The loss function _L_ is defined as 

**==> picture [339 x 27] intentionally omitted <==**

where _λ_ is a regularization coefficient and _s_ denotes the sample index. The stiffness-based loss term _L_ stiff is expressed as 

**==> picture [335 x 37] intentionally omitted <==**

During training, the dataset is divided into mini-batches, and the parameters (ˆ _z,_ ˆ _α, β,_[ˆ] ˆ _γ_ ) are updated using stochastic gradient descent (SGD) [26]. 

The forward propagation of the DMN homogenization process proceeds as follows. Initially, the stiffness matrices are assigned to the material nodes at the bottom layer according to 

**==> picture [310 x 25] intentionally omitted <==**

where _N_ denotes the total number of layers in the binary-tree network. 

From the bottom layer upward, the homogenization proceeds hierarchically through the building blocks. At each block, Eq. (8) is applied for _stiffness homogenization_ , while Eq. (14) governs the _rotation transformation_ . This recursive process ensures that stress–strain equilibrium is satisfied at all intermediate scales. Finally, the homogenized stiffness matrix at the root node, **C**[1] 1[, represents the macroscopic stiffness of the RVE, expressed as] 

**==> picture [262 x 12] intentionally omitted <==**

## **2.4 Online prediction** 

The online prediction phase extends the trained DMN to nonlinear material regimes by introducing a residual strain field at the bottom-layer material units _BN[j]_[(] _[j]_[=][1] _[, . . . ,]_[ 2] _[N][−]_[1][).][Each][unit][acts][as][an][independent][material][point,] characterized by its strain _**ε**[j] N_[, stress] _**[ σ]** N[j]_[, internal variables] _**[ β]** N[j]_[, and residual strain] _[ δ]_ _**[ε]**[j] N_[.] At the root node _B_ 1[1][, the macroscopic stress–strain relationship is expressed as] 

**==> picture [311 x 14] intentionally omitted <==**

where **C**[DMN] represents the homogenized tangent stiffness of the network, and _δ_ _**ε**_[DMN] denotes the homogenized accumulated residual strain. 

Given an imposed macroscopic loading condition, the objective of the DMN is to achieve global equilibrium between the local material responses and the applied load. This is accomplished through a Newton–Raphson iterative procedure alternating between homogenization and de-homogenization processes, as illustrated in Fig. 3. 

6 

A PREPRINT - MARCH 23, 2026 

**==> picture [328 x 246] intentionally omitted <==**

Figure 3: Schematic representation of DMN in the online prediction phase. 

During the homogenization step, the residual strain _δ_ _**ε**_[DMN] and the homogenized stiffness matrix **C**[DMN] are obtained by upscaling information from the bottom nodes to the root node. Based on the macroscopic loading condition, the overall incremental strain ∆ _**ε**_[DMN] and stress ∆ _**σ**_[DMN] are then determined. 

In the de-homogenization step, ∆ _**ε**_[DMN] and ∆ _**σ**_[DMN] propagate back to the bottom nodes, where the local material law is evaluated. At each iteration _i_ , the bottom node strains update as ∆ _**ε**[j,] N_[iter][=] _[i]_ . Convergence is reached when the relative difference between ∆ _**ε**[j,] N_[iter][=] _[i]_ and ∆ _**ε**[j,] N_[iter][=] _[i][−]_[1] falls below a predefined threshold; otherwise, the updated strain continues in the next iteration. 

At the bottom layer _N_ , each node _BN[j]_[follows the local constitutive relation:] 

**==> picture [307 x 14] intentionally omitted <==**

and 

**==> picture [299 x 13] intentionally omitted <==**

From these relations, both ∆ _**σ** N[j]_[and] **[C]** _[j] N_[are][determined,][allowing][the][residual][strain][at][each][bottom][node][to][be] expressed as 

**==> picture [285 x 13] intentionally omitted <==**

where **D** _[j] N_[= (] **[C]** _[j] N_[)] _[−]_[1][ denotes the local compliance matrix.] 

The computed _δ_ _**ε**[j] N_[and] **[ C]** _[j] N_[are then homogenized to the root node] _[ B]_ 1[1][using the homogenization function defined in] Eq. (8) and the rotation operation in Eq. (14). 

Similarly, the residual strain undergoes an intermediate homogenization step, followed by a rotation operation, with updates applied layer by layer. The intermediate homogenized residual strain is computed as: 

7 

A PREPRINT - MARCH 23, 2026 

**==> picture [382 x 127] intentionally omitted <==**

**----- Start of picture text -----**<br>
δ ε  =  f 1 δ ε [1] +  f 2 δ ε [2] +<br>D 11 [1] D 12 [1] D 16 [1] D 11 [2] D 12 [2] D 16 [2]<br> D 21 [1] D 22 [1] D 26 [1]   D 21 [2] D 22 [2] D 26 [2] <br>f 1 f 2( D 31 [1] D 32 [1] D 36 [1] − D 31 [2] D 32 [2] D 36 [2] )<br>DD 4151 [1][1] DD 4252 [1][1] DD 4656 [1][1] DD 5141 [2][2] DD 5242 [2][2] DD 5646 [2][2] (26)<br> D 61 [1] D 62 [1] D 66 [1]   D 61 [2] D 62 [2] D 66 [2] <br>f 1 D 11 [2] [+] [ f] [2] [D] 11 [1] f 1 D 12 [2] [+] [ f] [2] [D] 12 [1] f 1 D 16 [2] [+] [ f] [2] [D] 16 [1] − 1 [] δε [2] 1 [−] [δε] [1] 1<br> f 1 D 21 [2] [+] [ f] [2] [D] 21 [1] f 1 D 22 [2] [+] [ f] [2] [D] 22 [1] f 1 D 26 [2] [+] [ f] [2] [D] 26 [1]  δε [2] 2 [−] [δε] [1] 2<br> f 1 D 61 [2] [+] [ f] [2] [D] 61 [1] f 1 D 62 [2] [+] [ f] [2] [D] 62 [1] f 1 D 66 [2] [+] [ f] [2] [D] 66 [1]   δε [2] 6 [−] [δε] [1] 6<br>**----- End of picture text -----**<br>


where superscripts[1] ,[2] denote phase 1 and phase 2, while subscripts indicate the compliance matrix indices or vector components. 

The rotated residual strain is then computed as: 

**==> picture [273 x 11] intentionally omitted <==**

In the 3D DMN study by Liu and Wu, a near-linear relationship between the online computational time and the number of active bottom-layer nodes ( _Na_ ) was observed for a particle-reinforced composite RVE. In their study, for a DMN depth of _N_ = 8 (corresponding to _Na_ = 28), the DMN online prediction required 6 _._ 0 s on a single CPU core and achieved an approximately 8100 _×_ speedup over DNS in terms of CPU time [22]. 

Regarding nonlinear accuracy, it is generally observed that increasing the DMN depth _N_ enhances stress prediction accuracy by improving the representational capacity of the hierarchical network. Nevertheless, for a fixed network depth, the achievable accuracy is strongly influenced by the degree and nature of nonlinearity in the underlying constituent material models. Reported studies indicate that, for the same DMN depth, the maximum stress prediction error can vary substantially across different nonlinear material behaviors, ranging from below 1% for elasto-plastic responses to approximately 7% for viscoelastic responses. To mitigate this sensitivity, several works have proposed modified offline training strategies, such as tailoring the loss function to emphasize nonlinear response characteristics, which have been shown to reduce viscoelastic prediction errors to below 2% [27, 28]. 

## **2.5 Rationale beyond the DMNs** 

The effectiveness of DMNs arises from their physics-informed architecture, which intrinsically enforces thermodynamic consistency and material stability. Unlike purely data-driven neural networks that infer constitutive behavior solely from data, DMNs embed fundamental micromechanical principles directly within their hierarchical topology. This architectural bias ensures essential physical conditions—such as monotonic stress–strain behavior, positive energy dissipation, and stable material evolution—without the need for external penalty terms or artificial constraints [24]. 

Several key mechanisms enable DMNs to maintain strong physical consistency and robust performance even beyond their training domain [24]: 

- Monotonic stress-strain response: Each DMN building block is derived from interfacial equilibrium conditions. When the constituent materials at the bottom nodes exhibit monotonic stress–strain behavior, this property is preserved throughout the entire network. Consequently, the DMN response remains free from artificial softening or nonphysical instabilities, ensuring both numerical robustness and physically realistic deformation paths. 

- Convexity and stability of the energy: The Helmholtz free energy of each building block is formulated as a weighted combination of the free energies of its child phases. This construction ensures the convexity of the global energy functional, guaranteeing a unique, stable, and physically admissible constitutive response. Such convexity directly contributes to the numerical stability of nonlinear simulations involving DMN-based materials. 

- Inherited dissipation inequality: The DMN framework inherently satisfies the second law of thermodynamics. Since each constituent phase enforces non-negative energy dissipation, the hierarchical aggregation ensures that the overall network strictly preserves the dissipation inequality. As a result, all inelastic processes within the DMN lead to a net positive (or zero) dissipation, thereby precluding any artificial energy generation. 

8 

A PREPRINT - MARCH 23, 2026 

- Intrinsic enforcement of physics: Instead of relying on externally imposed constraints or penalty terms (e.g., embedding governing equations into the loss function), DMNs encode thermodynamic laws directly within their structural formulation. This inductive bias ensures that equilibrium, stability, and dissipation are satisfied throughout the network, preserving thermodynamic consistency even when operating far beyond the range of training data. 

Overall, DMNs provide a robust framework for tackling multiscale and nonlinear material problems by embedding physical principles into every building block. This intrinsic physics enforcement ensures monotonicity, stable energy evolution, and non-negative dissipation, thereby guaranteeing both thermodynamic soundness and numerical stability. Consequently, DMNs deliver reliable predictions within the training domain and demonstrate remarkable extrapolation capability beyond it. 

## **3 Current Directions** 

## **3.1 Advancements in DMN methodologies** 

Recent advancements in DMN methodologies have significantly enhanced their computational efficiency, physical interpretability, and applicability across diverse material systems. Table 1 provides an overview of key developments in DMN-based models, highlighting their primary objectives and relevant references. 

Table 1: Recent advancements in DMN-based models and their objectives. 

|**Model**|**Key Objective**|**Reference**|
|---|---|---|
|Rotation-free DMN|Extend DMN to multiphase materials and eliminate rotational DOFs1|[24]|
|IMN|Extend DMN to porous materials with enforced Hill-Mandel condition|[29, 30]|
|ODMN|Extend DMN to polycrystalline materials with texture evolution|[31]|
|MIpDMN|Extend DMN to incorporate thermal (conductivity & expansion) effects|[32]|
|Thermomechanical DMN|Extend DMN to incorporate thermal (expansion) effects|[33]|
|Thermal DMN|Extend DMN to incorporate thermal (conductivity) effects|[34]|
|DMN with Damage Effect|Extend DMN to integrate cohesive networks for damage modeling|[35, 36]|
|FDMN|Extend DMN to model non-Newtonian fuid dynamics|[37]|



9 

A PREPRINT - MARCH 23, 2026 

## **3.1.1 Rotation-free DMN** 

Gajek et al. extended the DMN framework by identifying that rotational DOFs at the bottom nodes of undirected composite materials are redundant [24]. Their analysis, based on Volterra series approximations and multiple-input multiple-output (MIMO) dynamical system frameworks, demonstrated that these DOFs have negligible influence on the overall material response. 

By eliminating these unnecessary DOFs, the rotation-free DMN significantly improves computational efficiency while maintaining predictive accuracy. Furthermore, this streamlined formulation naturally extends to multiphase materials, making it a scalable and versatile framework for modeling complex microstructures [24]. 

## **3.1.2 Interaction-based material network** 

Building upon the rotation-free DMN, Van Dung Nguyen and Ludovic Noels introduced the interaction-based material network (IMN) to extend DMN’s applicability to porous materials [29, 30]. 

IMN reformulates DMN by explicitly distinguishing material nodes from the material network, as shown in Fig. 4. In this framework, the bottom nodes of DMN are treated as independent material nodes, while the remaining hierarchical structure constitutes the material network, where each tree node represents an interaction mechanism. An IMN consists of _N_ material nodes and _M_ tree nodes, which can be interpreted as modeling an RVE with _N_ independent material units, grouped into _M_ interaction sets, each of which must satisfy the Hill-Mandel condition. Each interaction mechanism within the material network is characterized by: 

- An interaction direction **G** _[j]_ , corresponding to the force-equilibrium direction. 

- An interaction incompatibility **a** _[j]_ , representing deformation fluctuations. 

**==> picture [174 x 113] intentionally omitted <==**

**----- Start of picture text -----**<br>
Material network<br>Interaction direction<br>Material nodes<br>**----- End of picture text -----**<br>


Figure 4: Schematic illustration of the IMN framework, which consists of a material network and a set of material nodes. 

A key component of IMN in online prediction is its interaction mapping, which governs the distribution of deformation gradients across material nodes. This mapping is defined as 

**==> picture [345 x 31] intentionally omitted <==**

where _i_ indexes the material nodes, and _j_ indexes the interaction mechanisms. From Eq. (28), the fluctuation part of the deformation gradient is decomposed into _M_ interaction modes, each governed by a specific interaction mechanism represented by **a** _[j] ⊗_ **G** _[j]_ . 

Beyond its theoretical foundation, IMN introduces a significant computational advantage over traditional DMN. Unlike DMN, which requires layer-by-layer reconstruction during online prediction, IMN’s interaction mapping reformulates de-homogenization as a matrix operation, significantly improving computational efficiency. Studies have demonstrated that IMN achieves substantial speedup in both offline training and online prediction [38]. 

10 

A PREPRINT - MARCH 23, 2026 

## **3.1.3 Orientation-aware interaction-based DMN** 

Building upon the IMN framework, recent studies have introduced the orientation-aware interaction-based DMN (ODMN), which incorporates an orientation-aware mechanism at the material nodes, making it applicable to multiphase polycrystalline material systems [31], as shown in Fig. 5. This mechanism introduces three trainable parameters at each material node: the Tait–Bryan angles _α_ , _β_ , and _γ_ . These angles define a set of elementary rotation matrices, which collectively govern the rotation of each material node. 

**==> picture [179 x 131] intentionally omitted <==**

**----- Start of picture text -----**<br>
Material network<br>**----- End of picture text -----**<br>


**==> picture [50 x 6] intentionally omitted <==**

**----- Start of picture text -----**<br>
Material nodes<br>**----- End of picture text -----**<br>


Figure 5: Schematic illustration of the ODMN framework. Each material node is associated with trainable rotation angles, encoding local orientation information within the RVE. 

During online prediction, the rotation matrix **R** _[i]_ for a material node index _i_ is constructed using the trainable angles as follows: 

**==> picture [392 x 37] intentionally omitted <==**

At the initial loading state ( _t_ = 0), the elastic and plastic deformation gradients are initialized as: 

**==> picture [313 x 16] intentionally omitted <==**

For _t >_ 0, the updated rotation matrix **R** _[i] t_[at material node] _[ i]_[ can be obtained via the polar decomposition of the elastic] deformation gradient: 

**==> picture [274 x 12] intentionally omitted <==**

The extracted rotation matrix **R** _[i] t_[and] _[w][i]_[are][then][used][to][reconstruct][the][orientation][distribution][function][(ODF),] enabling the characterization of crystallographic texture evolution. 

While the original DMN can be applied to polycrystalline materials, a key limitation arises from the entanglement of bottom node rotation angles with the rotation angles of hierarchical building blocks within the homogenization function. In the original DMN, each building block is assumed to rotate throughout both homogenization and dehomogenization. Consequently, any change in the bottom node rotation disrupts the force-equilibrium condition of the DMN, leading to simulation instability and non-convergence during online prediction. 

In contrast, ODMN decouples material rotation from building block rotations. Rotation does not occur in the building blocks; rather, force-equilibrium directions are established. This distinction eliminates the need for rotation-related operations during both homogenization and de-homogenization in online prediction. As a result, ODMN allows material nodes to undergo deformation-induced rigid-body rotation while preserving the Hill-Mandel condition, thereby enabling the prediction of texture evolution in polycrystalline materials. 

11 

A PREPRINT - MARCH 23, 2026 

## **3.1.4 Micromechanics-informed parametric DMN** 

The DMN framework has been further extended to incorporate anisotropic thermal conductivity and thermal expansion in the micromechanics-informed parametric DMN (MIpDMN) [32]. In the original DMN building block, the laminate homogenization function for stiffness is expressed as: 

**==> picture [281 x 13] intentionally omitted <==**

Similarly, the effective thermal conductivity _k_[¯] follows: 

**==> picture [278 x 13] intentionally omitted <==**

The laminate thermal homogenization function is governed by Fourier’s law: 

**==> picture [259 x 10] intentionally omitted <==**

To derive the effective thermal conductivity, the heat flux _⃗q_ and the temperature gradient _∇T_ are decomposed into their tangential and normal components, denoted by superscripts _[t]_ and _[n]_ , respectively. At the interface, the continuity conditions impose: 

**==> picture [271 x 25] intentionally omitted <==**

By solving for the effective thermal conductivity, we obtain: 

**==> picture [369 x 13] intentionally omitted <==**

where 

**==> picture [302 x 25] intentionally omitted <==**

Beyond thermal conductivity, MIpDMN also incorporates effective stiffness homogenization while accounting for thermal expansion. The corresponding laminate homogenization function is expressed as: 

**==> picture [309 x 13] intentionally omitted <==**

Assuming a uniform temperature difference ∆ _T_ and a traction vector _σ_ ¯ _· ⃗n_ on the RVE boundary, the thermoelastic constitutive equation yields: 

**==> picture [318 x 10] intentionally omitted <==**

where S1 and S2 represent the compliance matrices of phases 1 and 2, respectively. 

By further derivation, the effective thermal expansion coefficient is given by: 

**==> picture [322 x 12] intentionally omitted <==**

Furthermore, MIpDMN enhances the adaptability of DMN to various microstructures, as demonstrated in a later section. To validate the proposed MIpDMN framework, an analysis was conducted of its predictions for the effective thermal conductivity and effective coefficient of thermal expansion in ellipsoidal inclusion composites, considering varying fiber volume fractions and aspect ratios. The results confirm that MIpDMN accurately predicts both effective thermal conductivity and the effective coefficient of thermal expansion across different microstructures. 

## **3.1.5 Thermomechanical DMN** 

Building upon the isothermal DMN framework [29, 24, 39], Shin et al. [33] extended the methodology to thermomechanical problems by incorporating thermal expansion effects while ensuring energy conservation. This extension is achieved by enforcing interface traction continuity within each building block and modifying the Hill–Mandel condition to account for temperature gradients, as shown in Fig. 6. 

12 

A PREPRINT - MARCH 23, 2026 

**==> picture [328 x 246] intentionally omitted <==**

Figure 6: Schematic illustration of thermomechanical DMN framework. 

For each building block, the continuity of interface traction is given by 

**==> picture [279 x 14] intentionally omitted <==**

where **H** _[⊤] h_[is a][ 3] _[ ×]_[ 6][ matrix associated with the interface normal direction.][The homogenized strain and stress satisfy] the averaging theorem: 

**==> picture [329 x 10] intentionally omitted <==**

where _f_ 1 and _f_ 2 are the volume fractions of the two phases. To incorporate thermal effects, the Hill–Mandel condition is extended following Levin’s theorem: 

**==> picture [376 x 16] intentionally omitted <==**

Rearranging Eq. (43) yields 

**==> picture [390 x 19] intentionally omitted <==**

The homogenization problem can be divided into two subproblems: one under isothermal conditions (∆ _T_ ) with a homogeneous traction boundary condition, and the other accounting for traction-free thermal variations. Under isothermal conditions (∆ _T_ = 0), Eq. (44) simplifies to 

**==> picture [301 x 13] intentionally omitted <==**

Using Eq.(41), this leads to 

**==> picture [294 x 88] intentionally omitted <==**

where **b** is an arbitrary vector, and _ε_ ¯ is the homogenized strain. 

13 

A PREPRINT - MARCH 23, 2026 

In the presence of a temperature variation, Eq. (44) simplifies to 

**==> picture [326 x 15] intentionally omitted <==**

where ∆ _T_ can take an arbitrary value. Using Eqs.(46) and (47), the linear homogenization within each building block is given by 

**==> picture [356 x 34] intentionally omitted <==**

where the **X** 1 and **X** 2 are analytical functions of ( **C** 1 _,_ **C** 2 _, α_ 1 _, α_ 2 _, f_ 1 _, f_ 2). 

Finally, the thermomechanical DMN was validated through thermo-elastic-viscoplastic simulations, where mechanical boundary conditions were applied while temperature variations were progressively introduced. The results confirmed that the model accurately captures the coupled mechanical and thermal responses of heterogeneous materials, demonstrating its effectiveness in thermomechanical analysis. 

## **3.1.6 Thermal DMN** 

Shin et al. proposed the thermal DMN to model thermal conductivity in woven composite materials [34]. This framework explicitly incorporates both the heat flux **q** and the temperature gradient _ψ_ = _−∇T_ into the building block formulation, enabling an accurate representation of thermal transport in anisotropic and heterogeneous materials, as shown in Fig. 7. 

**==> picture [328 x 247] intentionally omitted <==**

Figure 7: Schematic illustration of thermal DMN framework. 

Within each building block, the heat flux vectors for phase 1, phase 2, and the homogenized response are denoted as **q** 1, **q** 2, and **q** _h_ , respectively, while the corresponding temperature gradient vectors are _ψ_ 1, _ψ_ 2, and _ψh_ . The formulation is governed by the following conditions: 

**==> picture [136 x 10] intentionally omitted <==**

**==> picture [265 x 12] intentionally omitted <==**

**==> picture [271 x 10] intentionally omitted <==**

- Homogenization of field variables: 

**==> picture [257 x 27] intentionally omitted <==**

14 

A PREPRINT - MARCH 23, 2026 

- Heat flux continuity condition: 

**==> picture [97 x 8] intentionally omitted <==**

**==> picture [252 x 70] intentionally omitted <==**

where **R** 1 and **R** 2 are the trainable rotation matrices associated with the child nodes, allowing the model to capture the anisotropic characteristics of the thermal conductivity tensor adaptively. 

Each building block consists of 19 variables, including **q** 1, **q** 2, **q** _h_ , _ψ_ 1, _ψ_ 2, _ψh_ , and _ζ_ . These variables are constrained by 19 equations, as given in Eqs. (50)–(56), which enables the derivation of an analytical homogenization function for thermal conductivity. 

Furthermore, the nodal rotation mechanism in thermal DMN enhances its ability to represent directional heat conduction, improving the accuracy of thermal behavior modeling in complex woven composites. 

## **3.1.7 DMN with damage effect** 

To model the progressive degradation of materials, the DMN framework can be extended to incorporate interfacial failure and debonding. This is achieved by enriching specific bottom nodes of the DMN and associating them with dedicated cohesive networks. Each cohesive network consists of multiple cohesive layers designed to capture interfacial behavior, as illustrated in Fig. 8 [35, 36]. 

**==> picture [376 x 252] intentionally omitted <==**

Figure 8: Schematic illustration of the cohesive network integration within DMN. 

For each enriched node _q_ , the cohesive layers indexed by _p_ are sequentially embedded within the base material through cohesive building blocks. To maintain material consistency, the base material in the cohesive network must represent the same microscale constituent as the one originally present in the bottom layer of the DMN. Each enriched node _q_ Additionally, a reciprocal length parameteris associated with a distinct cohesive network, _ν_ ˜ is introduced to account for the size effects of the interface, defined as:parameterized by a set of trainable variables: � _z_ ˜ _q[p][,]_[ ˜] _[α] q[p][,][β]_[˜] _q[p][,]_[ ˜] _[γ] q[p]_ �. 

**==> picture [69 x 23] intentionally omitted <==**

(57) 

15 

A PREPRINT - MARCH 23, 2026 

where _L_ is the characteristic length of the RVE. 

The traction-separation law governs the response of the cohesive layers and is expressed as: 

**==> picture [270 x 10] intentionally omitted <==**

where: 

1. ∆ _d_ represents the incremental separation displacement, 

2. ∆ _t_ represents the incremental separation force, 

3. _G_ is the cohesive layer stiffness matrix, 

4. _δd_ is the residual displacement vector. 

Thus, the homogenized compliance matrix of the cohesive building block can be analytically derived as: 

**==> picture [289 x 13] intentionally omitted <==**

along with the residual strain formulation: 

**==> picture [292 x 13] intentionally omitted <==**

Here, _D_[0] and _D_ denote the compliance matrices before and after homogenization, respectively. The parameters _z,_ ˜ ˜ _α, β,_[˜] ˜ _γ_ are trainable, while _δε_[0] and _δε_ represent the residual strain variables before and after homogenization. 

The training process for the DMN with cohesive layers follows a two-stage approach. In the first stage, the DMN is trained independently without incorporating the cohesive network. In the second stage, the cohesive network is integrated while retaining the previously trained DMN parameters. The fully trained model, initially developed using elastic data, can then be extended to capture nonlinear material behavior. 

## **3.1.8 Flexible DMN** 

The Flexible DMN (FDMN) extends the standard DMN framework to model suspensions of rigid fibers in a nonNewtonian fluid [37]. A closed-form solution for two-layer linear homogenization is derived, establishing a theoretical foundation for this approach. By incorporating the rheological behavior of the surrounding medium, FDMN effectively predicts the effective stress response of shear-thinning fiber suspensions embedded in a Cross-type matrix material across a wide range of shear rates and under various loading conditions. This formulation enables accurate modeling of the complex interplay between fiber rigidity and non-Newtonian fluid behavior in heterogeneous materials. 

## **3.2 Generalizing DMNs to diverse microstructures** 

The original DMN framework has a fundamental limitation: a single DMN is typically trained for a specific microstructure. If the microstructure changes, the model must be retrained, which is impractical for industrial applications where microstructural variations are common. To address this challenge, several studies have explored methods to extend DMNs to handle diverse microstructures without requiring complete retraining. These advancements focus on integrating microstructural descriptors, adaptive training strategies, and transferable representations to enhance model generalization. Table 2 summarizes key developments in this area, highlighting different approaches to improving DMN adaptability across varying microstructures. 

Table 2: DMN-based models for handling diverse microstructures. 

|**Study**|**Method**|**Microstructure**|**Ref**|
|---|---|---|---|
|Transfer Learning DMN|Linear Interpolation|Circular Inclusions|[40]|
|MgDMN|Linear Interpolation|3D SFRP1|[41]|
|MIpDMN|Linear Interpolation|Circular Inclusions|[32]|
|GNN-DMN|GNN|Short Fibers|[42]|
|FM-IMN|FM|Short Fibers|[43]|
|CNN-IMN|CNN|Unidirectional Fibers|[44]|



16 

A PREPRINT - MARCH 23, 2026 

## **3.2.1 Simple interpolation** 

A straightforward approach to adapting a pre-trained DMN for new microstructures involves parameter interpolation [40]. Since the trainable weights in the DMN reflect the volume fraction of the material phases, the model can be adjusted for a new microstructure by rescaling its parameters. Consider a pre-trained DMN with a phase 2 volume fraction _vf_ 2[trained] , while an unseen RVE has a different but known volume fraction _vf_ 2[new] . The parameters at the bottom node indexed by _j_ are given by: 

**==> picture [332 x 34] intentionally omitted <==**

The trainable rotation angles for each building block remain unchanged: 

**==> picture [284 x 40] intentionally omitted <==**

While simple parameter rescaling enables the adaptation of pre-trained DMNs to different phase volume fractions without additional training, its accuracy is fundamentally limited. This approach assumes the microstructural interaction geometry remains invariant, an assumption that fails under strong nonlinearities such as plasticity, creep, or fatigue. In these regimes, localized nonlinear effects induce non-uniform microstructural changes that a simple a priori rescaling cannot capture. 

To address these limitations, Dey et al. developed a framework that represents microstructural variability through a discrete set of base networks [45]. By training 15 individual DMNs at representative points across the planar fiberorientation triangle, the model captures a broader range of states. During macroscopic simulations, each Gauss point evaluates the three DMNs corresponding to its specific orientation and determines the final stress response via a convex combination of their predictions. This a posteriori stress-level interpolation significantly enhances accuracy and robustness for highly anisotropic and nonlinear loading conditions. 

## **3.2.2 Transfer learning** 

To improve upon interpolation-based adaptation, transfer learning has been explored as a means of extending DMNs to new microstructures while reducing the need for full retraining [40]. 

In this approach, a dataset is first generated with multiple predefined volume fractions (e.g., _vf_ 2 = 0 _._ 1 _,_ 0 _._ 2 _, ...,_ 0 _._ 6), and corresponding DMN models are trained. If an unseen RVE has a volume fraction _vf_ 2[new] that falls within the range [ _vf_ 2[low][,] _[ vf]_ 2[ high] ], its DMN parameters are interpolated from the nearest pre-trained models as 

**==> picture [323 x 15] intentionally omitted <==**

where the interpolation coefficient _ρ_ is defined as: 

**==> picture [277 x 29] intentionally omitted <==**

Similarly, the trainable rotation angles at depth _i_ and index _k_ are interpolated as: 

**==> picture [315 x 43] intentionally omitted <==**

This transfer-learning-based interpolation strategy enables DMNs to generalize to new microstructures more effectively than simple interpolation, leveraging a broader range of pre-trained models. By integrating knowledge from multiple microstructures, this approach mitigates errors arising from simple parameter scaling and provides more accurate predictions across a diverse range of material configurations. 

17 

A PREPRINT - MARCH 23, 2026 

## **3.2.3 Microstructure-guided DMN** 

For complex RVE geometries, such as SFRP, the microstructure-guided DMN (MgDMN) extends the standard DMN framework by introducing a parameterization of the microstructure space [41]. This enhancement enables MgDMN to capture critical microstructural features and generalize across a broad range of microstructures, as shown in Fig. 9. Unlike traditional DMNs that must be retrained for every new microstructure, MgDMN employs an interpolation scheme to infer DMN parameters using only a few pre-trained DMNs. 

In MgDMN, the DMN homogenization process considers both the volume fraction (VF) and the orientation state. For a building block _Bi[k]_[at layer] _[ i]_[ and index] _[ k]_[, the VF (denoted by VF] _i[k]_[) is defined as:] 

**==> picture [295 x 13] intentionally omitted <==**

where VF _[k] i_[is][the][actual][volume][fraction][of][phase][1,][and] _[f]_[ 1][and] _[f]_[ 2][are][the][weight][proportions][of][the][child][building] blocks (computed via Eq. (7)). 

The orientation state is aggregated based on the dyadic product of a directional vector _⃗p_ . The second-order orientation tensor _A_ = [ _aij_ ] is given by [46]: 

**==> picture [285 x 23] intentionally omitted <==**

where Φ( _⃗p_ ) is the probability density function describing the orientation distribution. 

**==> picture [392 x 180] intentionally omitted <==**

**----- Start of picture text -----**<br>
RVE#4<br>base DMN#4<br>base DMN#3<br>base DMN#2<br>predicted DMN parameters<br>base DMN#1<br>Unseen interpolation<br>RVE<br>RVE#3<br>Pre-trained DMNs Inferenced DMN<br>RVE#2 RVE#1<br>Microstructural parameter space<br>**----- End of picture text -----**<br>


Figure 9: Schematic illustration of the microstructural parameter space. The DMN parameters for an unseen RVE are obtained by interpolating four base pre-trained DMNs in this space. 

Within this framework, the microstructure is characterized by the VF and orientation tensors. After considering rotational symmetries, the parameter space can be reduced further. In general, for an _Np_ -phase microstructure, 6 _Np −_ 8 distinct microstructures are required to span the microstructural parameter space fully. In the special case of a twophase SFRP, four distinct microstructures suffice to span the prism-shaped parameter space _{ν, a_ 11 _, a_ 22 _, a_ 33 _}_ . 

These four microstructures correspond to: 

1. Randomly oriented fibers at an _L_ % fiber volume fraction, 

2. Planar random fibers at an _L_ % fiber volume fraction, 

3. Aligned fibers at an _L_ % fiber volume fraction, 

4. Aligned fibers at an _H_ % fiber volume fraction. 

18 

A PREPRINT - MARCH 23, 2026 

Here, _L_ and _H_ are set to 10% and 15%, respectively. Separate DMNs, referred to as the base DMNs, are trained on each of these four RVEs. For an unseen microstructure, interpolation is used to determine DMN parameters. Specifically, the unseen microstructure is projected into the parameter space to obtain _{ν,_ ˜ ˜ _a_ 11 _,_ ˜ _a_ 22 _,_ ˜ _a_ 33 _}_ . The volume percentages _{w_ 1 _, w_ 2 _, w_ 3 _, w_ 4 _}_ associated with each base DMN are then computed by solving: 

**==> picture [328 x 54] intentionally omitted <==**

Here, the superscript[(] _[i]_[)] represents the index of the base DMN microstructure parameters. Once these weights are determined, the DMN parameters _P_[˜] for the unseen microstructure are obtained as a weighted linear combination of the base DMNs: 

**==> picture [469 x 50] intentionally omitted <==**

## **3.2.4 Micromechanics-informed parametric DMN** 

The micromechanics-informed parametric DMN (MIpDMN) incorporates micromechanical parameters to accommodate microstructural variations across different representative volume elements (RVEs) [32]. In MIpDMN, each microstructure is projected onto a parametric space _⃗p_ , as shown in Fig. 10: 

**==> picture [280 x 12] intentionally omitted <==**

where _vf_ is the volume fraction, and _⃗q_ represents morphological parameters orthogonal to _vf_ . 

**==> picture [328 x 247] intentionally omitted <==**

Figure 10: Schematic illustration of the MIpDMN framework. 

Since DMN parameters inherently encode microstructural characteristics, they can be expressed as functions of _⃗p_ . Consequently, the overall homogenization process becomes: 

**==> picture [272 x 13] intentionally omitted <==**

19 

A PREPRINT - MARCH 23, 2026 

where **C** _[p]_[1] and **C** _[p]_[2] denote the phase stiffness matrices, and **C**[¯] is the homogenized stiffness matrix. 

The trainable DMN parameters can be classified into volume fraction-dependent parameters and rotation angles. In MIpDMN, the weight _w_ is redefined as a linear function of volume fraction with the activation function _σ_ : 

**==> picture [306 x 11] intentionally omitted <==**

Similarly, the DMN rotation angles _θ_ are modeled as a linear transformation of _⃗q_ : 

**==> picture [305 x 11] intentionally omitted <==**

where _θ_ represents the set of rotation angles _{α, β, γ}_ in the DMN. 

In summary, the trainable parameters in MIpDMN related to the volume fraction consist of 2 _[N]_[+1] parameters, including _w[j]_ , _W_ 1, and _W_ 0. Meanwhile, the trainable parameters orthogonal to the volume fraction amount to 4 _×_ ( _q_ + 1) _×_ (2 _[N] −_ 1). For an unseen RVE, its microstructural representation is first mapped onto the parametric space _⃗p_ , after which Eq.(72) and Eq.(73) are used to determine the corresponding MIpDMN parameters. 

## **3.2.5 GNN-DMN framework** 

Recent advancements in DMNs have been achieved by integrating graph neural networks (GNNs) into the DMN framework, leading to the development of the GNN-DMN approach [42]. In GNN-DMN, the microstructure is discretized into a mesh, which is then used to construct a graph G. Each mesh element is treated as a node, with mesh connectivity defining the graph edges. The node attributes include: 

1. Area of mesh element 

2. xy-coordinates of the element centroid 

3. Phase of the mesh element 

4. Boundary status of the element (whether it lies on the boundary) 

These attributes are processed by a GNN to extract a latent vector _X_ feat, which is subsequently transformed into the DMN parameters _⃗p_ via a fully connected network. The homogenization process in GNN-DMN is formulated as: 

**==> picture [280 x 13] intentionally omitted <==**

where _⃗p_ consists of the following DMN parameters: 

**==> picture [354 x 17] intentionally omitted <==**

For an unseen RVE, the microstructure is first discretized into a mesh and represented as a graph G. The trained GNNDMN framework then extracts the corresponding DMN parameters _⃗p_ , enabling homogenization without requiring additional parameter fitting, as shown in Fig. 11. 

**==> picture [81 x 82] intentionally omitted <==**

**----- Start of picture text -----**<br>
RVE<br>mesh graph<br>**----- End of picture text -----**<br>


**==> picture [248 x 92] intentionally omitted <==**

**----- Start of picture text -----**<br>
Graph-based encoder<br>graph pooling<br>predicted DMN parameters<br>**----- End of picture text -----**<br>


**==> picture [113 x 108] intentionally omitted <==**

Figure 11: Schematic illustration of the GNN-DMN framework. 

20 

A PREPRINT - MARCH 23, 2026 

## **3.2.6 Foundation model-IMN framework** 

Foundation models (FMs) have achieved remarkable success across various domains, including natural language processing, computer vision, and, more recently, composite materials modeling [43]. In the context of material modeling, a recent study introduced an FM-based approach that leverages a masked autoencoder (MAE) to learn microstructural representations from a large dataset of 100,000 composite microstructures. 

The MAE employs an encoder-decoder architecture for self-supervised learning. During pretraining, a portion of the input microstructure image is masked, and the encoder extracts latent features from the unmasked regions. The decoder then reconstructs the missing parts, compelling the encoder to capture essential structural patterns and dependencies. Through this process, the encoder learns a low-dimensional representation that effectively encodes microstructural information while remaining robust to missing data. 

**==> picture [420 x 171] intentionally omitted <==**

**----- Start of picture text -----**<br>
Inferenced IMN<br>C<br>RVE<br>patchify FM–IMN<br>framework<br>predicted IMN parameters C p1 C p2<br>**----- End of picture text -----**<br>


Figure 12: Schematic illustration of the FM-IMN framework. 

Once pre-trained, the MAE encoder is extracted and repurposed for downstream tasks. In the FM-IMN framework, a linear projection layer is appended to the pre-trained encoder, directly mapping microstructural images to IMN parameters, as shown in Fig. 12. This transfer learning approach enables the foundation model to be fine-tuned for homogenization tasks. The homogenization process is formulated as: 

**==> picture [278 x 13] intentionally omitted <==**

where I is the grayscale image of the microstructure, and _⃗p_ (I) represents the predicted IMN parameters. 

For an unseen microstructure, its grayscale image is processed by the fine-tuned FM-IMN framework. Since this framework eliminates the need for explicit parameter fitting for each new microstructure, it enables efficient nonlinear extrapolation across diverse material systems. 

## **3.2.7 Comparative Summary of Generalization Strategies** 

The evolution of DMN generalization strategies reflects a clear trade-off between computational simplicity and **representational capacity** . As summarized in Table 2, these methodologies can be categorized into three distinct levels of complexity based on their treatment of the microstructural design space: 

- Interpolation-based methods (Simple Interpolation, Transfer Learning, and MgDMN) leverage the inherent multilinearity of the DMN architecture. These are highly efficient and physically intuitive, as they utilize the volume fraction or orientation tensors to rescale the weights and angles of base networks. However, their utility is largely confined to microstructural families with well-defined, low-dimensional parameter spaces, such as circular inclusions or short-fiber reinforced polymers. 

21 

A PREPRINT - MARCH 23, 2026 

- Parametric models (MIpDMN) enhance flexibility by treating rotation angles and weights as functional mappings of morphological parameters. While this approach extends the model’s reach to microstructures orthogonal to volume fraction, it remains dependent on the manual identification of relevant descriptors, which can be challenging for disordered or irregular RVEs. 

- Representation learning frameworks (GNN-DMN and FM-IMN) represent the current state-of-the-art in microstructural generalizability. By integrating Graph Neural Networks or Masked Autoencoders, these models bypass the need for manual feature engineering. They extract high-dimensional latent vectors directly from raw mesh or image data to predict DMN parameters. Although they require substantial offline datasets and computational resources for pre-training, they offer a robust pathway toward ”foundation models” for mechanics that can handle arbitrary microstructural topologies without retraining. 

In summary, selecting a DMN generalization strategy involves balancing the available training data with the required geometric diversity. For standardized industrial composites, MgDMN provides a high-efficiency solution with minimal data overhead. Conversely, for advanced materials discovery involving complex, non-periodic, or evolving geometries, the FM-IMN and GNN-DMN frameworks provide the necessary representational power to ensure predictive accuracy across diverse material systems. 

## **4 Applications** 

DMN has emerged as a powerful surrogate model for two-scale analyses, offering substantial computational efficiency while maintaining accuracy. Initially applied to SFRP, their applicability has since expanded across diverse material systems and industrial applications. 

A key application of DMNs is in SFRP component analysis [47, 48]. By replacing the conventional RVE with a DMN at each Gaussian integration point, the FE–DMN framework enables efficient multiscale simulations within ABAQUS via an implicit user-material (UMAT) subroutine. In a study of a quadcopter drone with over 9 million DOFs, fiber orientation data from injection-molding simulations were incorporated to perform high-fidelity structural analysis. Despite the model’s complexity, the simulation completed in 267 minutes using 252 GB of DRAM, demonstrating the feasibility of DMNs for large-scale industrial applications. 

DMNs have also been extended to thermomechanically coupled composite materials [49, 50]. For instance, a nonsymmetric notched plate under cyclic loading was analyzed using a two-scale simulation to capture the fully coupled thermomechanical response. Compared to conventional approaches, the DMN-based method achieved a computational speedup of five to six orders of magnitude while preserving accuracy. This capability is particularly relevant for applications involving temperature-dependent material behavior. 

Another notable application involves impact and contact simulations of composite structures under dynamic loading. One study integrated fiber orientation and volume fraction data from Moldex3D injection molding simulations into a DMN surrogate model, which was then coupled with LS-DYNA for large-scale impact analysis [51]. This approach enables efficient and accurate simulations of dynamic impact events, offering a computationally viable alternative to conventional multiscale modeling methods. The ability of DMNs to handle large-scale impact scenarios makes them particularly valuable for designing lightweight, crashworthy materials in automotive applications. 

Furthermore, DMNs have been employed for inverse identification of material parameters in short fiber-reinforced thermoplastics, a process that remains computationally demanding even with FFT-based methods. By replacing fullfield simulations with DMN surrogates, this methodology has significantly reduced computational costs while maintaining high accuracy [52]. 

More recently, DMNs have been increasingly integrated into industrial manufacturing workflows through virtual product development (VPD). For example, Meyer et al. employed DMNs in combination with molding process simulations to predict the stochastic effective mechanical performance of sheet molding compound (SMC) composites, enabling probabilistic assessment of process-induced variability [53]. Furthermore, Wu et al. reformulated the IMN by decoupling the phase volume fraction from the microstructural parameters, thereby introducing randomness in the phase volume fraction for Stochastic Volume Elements (SVEs) and enabling stochastic nonlinear response prediction [54]. In a complementary direction, Robertson et al. developed the Variational Deep Material Network (VDMN), in which variational distributions are embedded into the mechanistic building blocks of the network to explicitly capture microstructure-induced aleatoric uncertainties. This framework enables probabilistic forward and inverse modeling and establishes a foundation for uncertainty-robust materials digital twins [55]. 

In summary, DMNs have proven effective in a wide range of multiscale and multiphysics applications, including structural and thermomechanical analysis, impact modeling, and inverse parameter identification. Their flexibility and 

22 

A PREPRINT - MARCH 23, 2026 

computational efficiency make them a promising tool for advanced material modeling and industrial applications, with ongoing research continuously expanding their scope. 

## **5 Conclusions** 

This study provides a comprehensive synthesis of the theoretical foundations of DMNs, tracing their evolution from fundamental building blocks to advanced frameworks for multiphysics modeling. By reviewing diverse strategies for microstructural adaptation and their integration into FE– DMN frameworks, we have demonstrated the versatility of DMNs in addressing large-scale structural structural simulations as well as complex inverse material identification problems. 

The distinctive strength of the DMN framework resides in its hierarchical architecture, enabling the explicit derivation of two-phase linear homogenization operators. This structure enables a highly efficient ”offline” training phase using linear datasets while preserving robust ”online” extrapolation capability into nonlinear regimes. Consequently, DMNs effectively bridge the gap between rigorous physics- based homogenization and the high-speed execution of datadriven surrogates, offering a unique blend of interpretability, computational efficiency, and physical consistency. 

However, the transition from research to widespread industrial adoption necessitates addressing several critical bottlenecks identified in this review: 

1. Multiphysics Integration: While mechanical homogenization within DMNs has reached a relatively mature stage, extending DMNs to fully coupled nonlinear multiphysics phenomena, such as piezoelectricity, electroconductivity, and saturated porous media, remains in its early stages. Leveraging the inherent extensibility of the DMN architecture to address these domains constitutes a key priority for future research. 

2. Scale Separation Limits: Most current formulations are restricted to first-order homogenization and rely on the assumption of strict scale separation. This assumption limits predictive fidelity in scenarios involving pronounced size effects or strain localization. 

3. Microstructural Generalizability: A primary limitation of current DMNs is their topological rigidity, whereby substantial retraining is typically required for changes in microstructural geometry. Although a growing body of literature has begun to address this issue, most existing research remains confined to narrow and highly specific classes of microstructures. 

In conclusion, while DMNs have already demonstrated strong potential for high-fidelity multiscale modeling at a substantially reduced computational cost, their long-term impact will depend critically on continued advances in multiphysics coupling and geometric flexibility. Progress along these directions is essential for establishing DMNs as a cornerstone of next-generation digital twins and accelerated materials design. 

23 

A PREPRINT - MARCH 23, 2026 

## **Acknowledgements** 

This work is supported by the National Science and Technology Council, Taiwan, under Grant 111-2221-E-002-054MY3, 112-2221-E-007-028, and 114-2221-E-002-010-MY3. We are grateful for the computational resources and support from the NTUCE-NCREE Joint Artificial Intelligence Research Center and the National Center of Highperformance Computing (NCHC). 

## **Declarations** 

The authors declare no conflict of interest. 

## **Author Contributions** 

TJW led the writing of the manuscript and developed the core content. WNW contributed to writing and assisted with figure editing. CSC supervised the research and revised the manuscript to its final form. 

## **Data Availability** 

No datasets were generated or analysed during the current study. 

## **References** 

- [1] Rodney Hill. A self-consistent mechanics of composite materials. _Journal of the Mechanics and Physics of Solids_ , 13(4):213–222, 1965. 

- [2] Fr´ed´eric Feyel and J Chaboche. Fe2 multiscale approach for modelling the elastoviscoplastic behaviour of long fibre sic/ti composite materials. _Computer Methods in Applied Mechanics and Engineering_ , 183(3-4):309–330, 2000. 

- [3] M. Geers, V. Kouznetsova, and W. Brekelmans. Multi-scale computational homogenization: Trends and challenges. _Journal of Computational and Applied Mathematics_ , 234(7):2175–2182, 2010. 

- [4] A Mohammadpour, Marc GD Geers, and Varvara G Kouznetsova. Multi-scale modeling of the thermomechanical behavior of cast iron. _Multiscale Science and Engineering_ , 4(3):119–136, 2022. 

- [5] Dohun Lee and Jaewook Lee. Comparison and validation of numerical homogenization based on asymptotic method and representative volume element method in thermal composites. _Multiscale Science and Engineering_ , 3(2):165–175, 2021. 

- [6] I. Temizer and P. Wriggers. An adaptive multiscale resolution strategy for the finite deformation analysis of microheterogeneous structures. _Computer Methods in Applied Mechanics and Engineering_ , 200(37-40, SI):2639– 2661, SEP 1 2011. 

- [7] P. Eisenlohr, M. Diehl, R. A. Lebensohn, and F. Roters. A spectral method solution to crystal elastoviscoplasticity at finite strains. _International Journal of Plasticity_ , 46(SI):37–53, JUL 2013. 

- [8] P. Shanthraj, P. Eisenlohr, M. Diehl, and F. Roters. Numerically robust spectral methods for crystal plasticity simulations of heterogeneous materials. _International Journal of Plasticity_ , 66(SI):31–45, MAR 2015. 

- [9] A. Vidyasagar, Abbas D. Tutcuoglu, and Dennis M. Kochmann. Deformation patterning in finite-strain crystal plasticity by spectral homogenization with application to magnesium. _Computer Methods in Applied Mechanics and Engineering_ , 335:584–609, JUN 15 2018. 

- [10] Ricardo A. Lebensohn and Anthony D. Rollett. Spectral methods for full-field micromechanical modelling of polycrystalline materials. _Computational materials science_ , 173, FEB 15 2020. 

- [11] Annan Zhang and Dirk Mohr. Using neural networks to represent von mises plasticity with isotropic hardening. _International Journal of Plasticity_ , 132, SEP 2020. 

- [12] M. Mozaffar, R. Bostanabad, W. Chen, K. Ehmann, J. Cao, and M. A. Bessa. Deep learning predicts pathdependent plasticity. _Proceedings of the National Academy of Sciences, USA_ , 116(52):26414–26420, DEC 26 2019. 

24 

A PREPRINT - MARCH 23, 2026 

- [13] Dana Bishara, Yuxi Xie, Wing Kam Liu, and Shaofan Li. A state-of-the-art review on machine learning-based multiscale modeling, simulation, homogenization and design of materials. _Archives of Computational Methods in Engineering_ , 30(1):191–222, JAN 2023. 

- [14] A. L. Frankel, R. E. Jones, C. Alleman, and J. A. Templeton. Predicting the mechanical response of oligocrystals with deep learning. _Computational Materials Science_ , 169, NOV 2019. 

- [15] Qiang Chen, Ruijian Jia, and Shanmin Pang. Deep long short-term memory neural network for accelerated elastoplastic analysis of heterogeneous materials: An integrated data-driven surrogate approach. _Composite Structures_ , 264, MAY 15 2021. 

- [16] Dongjin Kim and Jaewook Lee. A review of physics informed neural networks for multiscale analysis and inverse problems. _Multiscale Science and Engineering_ , pages 1–11, 2024. 

- [17] Hugon Lee, Sangryun Lee, and Seunghwa Ryu. Advancements and challenges of micromechanics-based homogenization for the short fiber reinforced composites. _Multiscale Science and Engineering_ , 5(3):133–146, 2023. 

- [18] Hao-Syuan Chang and Jia-Lin Tsai. Predict elastic properties of fiber composites by an artificial neural network. _Multiscale Science and Engineering_ , 5(1):53–61, 2023. 

- [19] Tung-Huan Su, Jimmy Gaspard Jean, and Chuin-Shan Chen. Model-free data-driven identification algorithm enhanced by local manifold learning. _Computational Mechanics_ , 71(4):637–655, 2023. 

- [20] Chi-Hua Yu, Bor-Yann Tseng, Zhenze Yang, Cheng-Che Tung, Elena Zhao, Zhi-Fan Ren, Sheng-Sheng Yu, PoYu Chen, Chuin-Shan Chen, and Markus J Buehler. Hierarchical multiresolution design of bioinspired structural composites using progressive reinforcement learning. _Advanced Theory and Simulations_ , 5(11):2200459, 2022. 

- [21] Zeliang Liu, C. T. Wu, and M. Koishi. A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. _Computer Methods in Applied Mechanics and Engineering_ , 345:1138–1168, MAR 1 2019. 

- [22] Zeliang Liu and C. T. Wu. Exploring the 3d architectures of deep material network in data-driven multiscale mechanics. _Journal of the Mechanics and Physics of Solids_ , 127:20–46, JUN 2019. 

- [23] Pavan Bhat Keelanje Srinivas, Matthias Kabel, and Matti Schneider. Rapid offline training for deep material networks via a displacement-based laminate formulation and a novel sampling technique for a compliance-based fatigue model. _Computer Methods in Applied Mechanics and Engineering_ , 449:118517, 2026. 

- [24] Sebastian Gajek, Matti Schneider, and Thomas B¨ohlke. On the micromechanics of deep material networks. _Journal of the Mechanics and Physics of Solids_ , 142:103984, 2020. 

- [25] Xavier Glorot, Antoine Bordes, and Yoshua Bengio. Deep sparse rectifier neural networks. In _Proceedings of the fourteenth international conference on artificial intelligence and statistics_ , pages 315–323. JMLR Workshop and Conference Proceedings, 2011. 

- [26] L´eon Bottou. Large-scale machine learning with stochastic gradient descent. In _Proceedings of COMPSTAT’2010: 19th International Conference on Computational StatisticsParis France, August 22-27, 2010 Keynote, Invited and Contributed Papers_ , pages 177–186. Springer, 2010. 

- [27] Sebastian Gajek, Matti Schneider, and Thomas B¨ohlke. Material-informed training of viscoelastic deep material networks. _PAMM_ , 22(1):e202200143, 2023. 

- [28] Argha Protim Dey, Fabian Welschinger, Matti Schneider, Sebastian Gajek, and Thomas B¨ohlke. Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelasticallyinformed strategy. _Archive of Applied Mechanics_ , 92(9):2733–2755, 2022. 

- [29] Van Dung Nguyen and Ludovic Noels. Micromechanics-based material networks revisited from the interaction viewpoint; robust and efficient implementation for multi-phase composites. _European Journal of Mechanics - A/Solids_ , 91:104384, 2022. 

- [30] Van Dung Nguyen and Ludovic Noels. Interaction-based material network: A general framework for (porous) microstructured materials. _Computer Methods in Applied Mechanics and Engineering_ , 389:114300, 2022. 

- [31] Ting-Ju Wei, Tung-Huan Su, and Chuin-Shan Chen. Orientation-aware interaction-based deep material network in polycrystalline materials modeling. _Computer Methods in Applied Mechanics and Engineering_ , 441:117977, 2025. 

- [32] Tianyi Li. Micromechanics-informed parametric deep material network for physics behavior prediction of heterogeneous materials with a varying morphology. _Computer Methods in Applied Mechanics and Engineering_ , 419:116687, 2024. 

25 

A PREPRINT - MARCH 23, 2026 

- [33] Dongil Shin, Ryan Alberdi, Ricardo A Lebensohn, and R´emi Dingreville. A deep material network approach for predicting the thermomechanical response of composites. _Composites Part B: Engineering_ , 272:111177, 2024. 

- [34] Dongil Shin, Peter Jefferson Creveling, Scott Alan Roberts, and R´emi Dingreville. Deep material network for thermal conductivity problems: Application to woven composites. _Computer Methods in Applied Mechanics and Engineering_ , 431:117279, 2024. 

- [35] Zeliang Liu. Deep material network with cohesive layers: Multi-stage training and interfacial failure analysis. _Computer Methods in Applied Mechanics and Engineering_ , 363:112913, 2020. 

- [36] Zeliang Liu. Cell division in deep material networks applied to multiscale strain localization modeling. _Computer Methods in Applied Mechanics and Engineering_ , 384:113914, 2021. 

- [37] Benedikt Sterr, Sebastian Gajek, Andrew Hrymak, Matti Schneider, and Thomas B¨ohlke. Deep material networks for fiber suspensions with infinite material contrast. _International Journal for Numerical Methods in Engineering_ , 126(7):e70014, 2025. 

- [38] Wen Ning Wan, Ting Ju Wei, Tung Huan Su, and Chuin Shan Chen. Decoding material networks: exploring performance of deep material network and interaction-based material networks. _Journal of Mechanics_ , 40:796– 807, 2024. 

- [39] Dongil Shin, Ryan Alberdi, Ricardo A Lebensohn, and R´emi Dingreville. Deep material network via a quilting strategy: visualization for explainability and recursive training for improved accuracy. _npj Computational Materials_ , 9(1):128, 2023. 

- [40] Zeliang Liu, C. T. Wu, and M. Koishi. Transfer learning of deep material network for seamless structure-property predictions. _Computational Mechanics_ , 64(2, SI):451–465, AUG 2019. 

- [41] Tianyu Huang, Zeliang Liu, C.T. Wu, and Wei Chen. Microstructure-guided deep material network for rapid nonlinear material modeling and uncertainty quantification. _Computer Methods in Applied Mechanics and Engineering_ , 398:115197, 2022. 

- [42] Jimmy Gaspard Jean, Tung Huan Su, Szu Jui Huang, Cheng-Tang Wu, and Chuin Shan Chen. Graph-enhanced deep material network: multiscale materials modeling with microstructural informatics. _Computational Mechanics_ , 75:113–136, 2025. 

- [43] Ting-Ju Wei and Chuin-Shan Chen. Foundation model for composite microstructures: Reconstruction, stiffness, and nonlinear behavior prediction. _Materials & Design_ , 257:114397, 2025. 

- [44] Ling Wu and Ludovic Noels. Convolutional neural network-based mapping of material micro-structures to deep material networks for non-linear mechanical response prediction. _Computer Methods in Applied Mechanics and Engineering_ , 449:118554, 2026. 

- [45] Argha Protim Dey, Fabian Welschinger, Matti Schneider, Jonathan K¨obler, and Thomas B¨ohlke. On the effectiveness of deep material networks for the multi-scale virtual characterization of short fiber-reinforced thermoplastics under highly nonlinear load cases. _Archive of Applied Mechanics_ , 94(5):1177–1202, 2024. 

- [46] Suresh G Advani and Charles L Tucker III. The use of tensors to describe and predict fiber orientation in short fiber composites. _Journal of rheology_ , 31(8):751–784, 1987. 

- [47] Sebastian Gajek, Matti Schneider, and Thomas B¨ohlke. An fe–dmn method for the multiscale analysis of short fiber reinforced plastic components. _Computer Methods in Applied Mechanics and Engineering_ , 384:113952, 2021. 

- [48] Sebastian Gajek, Matti Schneider, and Thomas B¨ohlke. Efficient two-scale simulations of microstructured materials using deep material networks. _PAMM_ , 21(1):e202100069, 2021. 

- [49] Sebastian Gajek, Matti Schneider, and Thomas B¨ohlke. An fe-dmn method for the multiscale analysis of thermomechanical composites. _Computational Mechanics_ , 69(5):1087–1113, 2022. 

- [50] Sebastian Gajek. _Deep material networks for efficient scale-bridging in thermomechanical simulations of solids_ . KIT Scientific Publishing, 2023. 

- [51] Haoyan Wei, C. T. Wu, Wei Hu, Tung-Huan Su, Hitoshi Oura, Masato Nishi, Tadashi Naito, Stan Chung, and Leo Shen. Ls-dyna machine learning-based multiscale method for nonlinear modeling of short fiber-reinforced composites. _Journal of Engineering Mechanics_ , 149(3), MAR 1 2023. 

- [52] Argha Protim Dey, Fabian Welschinger, Matti Schneider, Sebastian Gajek, and Thomas B¨ohlke. Rapid inverse calibration of a multiscale model for the viscoplastic and creep behavior of short fiber-reinforced thermoplastics based on deep material networks. _International Journal of Plasticity_ , 160:103484, 2023. 

26 

A PREPRINT - MARCH 23, 2026 

- [53] Nils Meyer, Sebastian Gajek, Johannes G¨orthofer, Andrew Hrymak, Luise K¨arger, Frank Henning, Matti Schneider, and Thomas B¨ohlke. A probabilistic virtual process chain to quantify process-induced uncertainties in sheet molding compounds. _Composites Part B: Engineering_ , 249:110380, 2023. 

- [54] Ling Wu and Ludovic Noels. Stochastic deep material networks as efficient surrogates for stochastic homogenisation of non-linear heterogeneous materials. _Computer Methods in Applied Mechanics and Engineering_ , 441:117994, 2025. 

- [55] Andreas E Robertson, Samuel B Inman, Ashley T Lenau, Ricardo A Lebensohn, Dongil Shin, Brad L Boyce, and Remi M Dingreville. Microstructure-based variational neural networks for robust uncertainty quantification in materials digital twins. _arXiv preprint arXiv:2512.18104_ , 2025. 

27 

