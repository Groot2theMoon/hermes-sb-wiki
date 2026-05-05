---
title: "U-net Architected Deep Material Network Training with Microstructure Local Field Information"
journal: "Computational Mechanics (2026), DOI: 10.1007/s00466-025-02744-9"
authors:
  - "Dongil Shin"
  - "Ricardo A. Lebensohn"
  - "Remi Dingreville"
year: 2026
source: paper
ingested: 2026-05-05
sha256: a2022a8f295e33b1b18d1c6a4ce73c30422ee122633d03812c23e5ee066f59ab
conversion: pymupdf4llm
---
Computational Mechanics https://doi.org/10.1007/s00466-025-02744-9 

**ORIGINAL PAPER** 

**==> picture [29 x 30] intentionally omitted <==**

## **U-net architected deep material network training with microstructure local field information** 

**Dongil Shin[1,2] · Ricardo A. Lebensohn[3] · Rémi Dingreville[1]** 

Received: 12 August 2025 / Accepted: 27 December 2025 © The Author(s) 2026 

## **Abstract** 

The Deep Material Network (DMN) has recently emerged as a powerful reduced-order modeling framework for simulating the mechanical response of heterogeneous materials such as composites. Unlike most data-driven approaches that directly learn a material’s response under prescribed loading, the DMN acts as a homogenization operator, learning the kinematic constraints and mechanical interactions of the underlying microstructure. However, traditional DMN training relies exclusively on homogenized effective properties derived from Direct Numerical Simulations (DNS), discarding the rich local field data that govern microstructural interactions. In this work, we extend the DMN framework to incorporate such local field information into the offline training process. Utilizing a U-Net architecture, we augment the DMN training objective to include the first and second statistical moments of the local stress fields obtained from linear DNS. This ensures that the learned network topology not only fits the effective stiffness but also accurately reflects the internal local stress and strain partitioning of the microstructure. The results confirm that supervising the localization process during training yields a superior surrogate model, reducing local prediction errors by an order of magnitude and significantly improving generalization to unseen nonlinear constitutive behaviors compared to traditional DMNs. 

**Keywords** Homogenization · Reduced order model · U-Net · Deep material network 

## **1 Introduction** 

Multiscale analysis is central to computational materials science, offering an accurate pathway to predict macroscopic material responses from underlying microstructural behavior. This task becomes particularly challenging in heterogeneous materials, where nonlinear, history-dependent behaviors, such as plastic deformation, strain localization, and damage 

Rémi Dingreville rdingre@sandia.gov Dongil Shin dongilshin@postech.ac.kr Ricardo A. Lebensohn lebenso@lanl.gov 

> 1 Center for Integrated Nanotechnologies, Sandia National Laboratories, Albuquerque, NM 87185, USA 

> 2 Mechanical Engineering, POSTECH, Pohang 37673, Republic of Korea 

> 3 Theoretical Division, Los Alamos National Laboratory, Los Alamos, NM 87545, USA 

arise from intricate interactions at the microscale [1]. Traditional multiscale frameworks often rely on homogenization techniques that condense complex microstructural information into a limited set of effective properties. While these approaches offer computational efficiency, they inherently struggle to capture the full spectrum of spatial heterogeneity and nonlinear mechanisms governing real-world material behavior [2]. 

In recent years, data-driven and machine learning (ML) approaches have gained traction to enhance the fidelity and computational efficiency of multiscale models [3, 4]. These methods enable the construction of reduced-order models (ROMs) that directly learn microstructure–property relationships from high-fidelity simulations or experimental data. However, conventional ML models typically require large datasets covering specific loading conditions, material parameters, or microstructure morphologies. Standard architectures like multilayer perceptrons (MLPs) and convolutional neural networks (CNNs) often struggle to generalize beyond their training domain due to a lack of embedded physical principles, which also limits their interpretability and robustness [5]. Recent developments 

**==> picture [133 x 12] intentionally omitted <==**

```
1 3
```

Computational Mechanics 

in physics-informed machine learning aim to address these limitations by embedding physical constraints externally and internally the model architecture [6–8]. 

Notably, the Deep Material Network (DMN) is a physics-based, data-driven framework that learns the homogenization pathway connecting microstructural behavior to macroscopic responses [9, 10]. While the computational cost of Direct Numerical Simulation (DNS) data generation can be reduced through algorithmic optimizations, DMN fundamentally mitigates such demands through dimensionality reduction. Unlike other reduced-order models such as SelfConsistent Clustering Analysis (SCA) [11], RVE-Net [12], or operator-learning approaches including FNO [13] and DeepONet [14], which focus on learning direct structure– property relations, the DMN is mathematically equivalent to a rank- _N_ sequential laminate [15] (where _N_ stands for the number of layers in the network) and follows a hierarchical, physics-structured formulation based on analytical homogenization. The DMN architecture can be constructed as a binary-tree network, in which the homogenized stress– strain pair at the top node is progressively decomposed into local responses via localization operations. The connections between nodes represent analytical homogenization relations governing stress and strain transfer across layers. Nodes at the bottom layer are assigned the material properties of individual microstructural phases, serving as the fundamental degrees of freedom. Rather than using abstract weights and biases as in a conventional MLP, the DMN optimizes physical parameters – such as volume fraction and orientation vectors – as learnable network variables within admissible ranges. This formulation embeds micromechanical consistency directly into the architecture, creating a surrogate model, which is independent of specific constitutive laws, and significantly reducing the computational cost of conventional FE[2] multiscale analyses. 

The DMN framework decouples learning the microstructural topology from constitutive behavior through a twostage process: offline training and online prediction. During the offline phase, the network is fitted to linear-elastic DNS data. Instead of fitting a stress–strain curve directly, the training optimizes the network’s parameters (phase fractions and orientations) to approximate the homogenization operator itself. Because these parameters encode the geometric interactions of the microstructure, they remain valid for extrapolation to unseen material combinations or constitutive behaviors. In the online stage, the pre-trained parameters are fixed, and the base nodes are assigned nonlinear constitutive laws. The network then solves a reduced-order boundary value problem using a Newton–Raphson iterative scheme to determine the displacement jumps satisfying interface equilibrium. The DMN architecture preserves thermodynamic consistency (consistency between local 

and global fields and energy equivalence) by construction, enabling stable extrapolation to unseen behaviors with computational speed-ups exceeding 3 orders of magnitude compared to DNS. 

Recent studies have focused on extending the DMN framework beyond the small-strain assumption to address complex nonlinear behaviors, including creep [16], multiphysics coupling [17], and delamination and large-deformation problems [18]. To address the constraint of training on single microstructures, other developments have explored DMN extensions through graph-based representations [19] and topology-aware architectures [20]. These approaches suggest that the framework can be generalized to handle more diverse and spatially varying heterogeneous systems. These advances have facilitated the deployment of DMNs as efficient surrogates in multiscale modeling of largescale component analyses such as short-fiber-reinforced polymers [21] or impact and crash simulations [22]. By replacing full RVEs at integration points, such FE-DMN integration achieves speed-ups of several orders of magnitude in large-scale component analyses while retaining DNS-level fidelity [10]. Building on these advances, the present study focuses on enhancing the intrinsic training efficiency and predictive accuracy of the DMN to further strengthen its integration into future two-scale (of the FE[2] type) workflows. 

While most existing DMN models are primarily trained on global homogenized responses, such as effective stiffness tensors, this approach may overlook the additional local field information available from DNS, including spatial distributions of stress and strain. These local fields contain valuable information about microstructural heterogeneity and interaction mechanisms. Incorporating such information during training has the potential to improve the network’s representativeness and predictive performance. This may lead to surrogate models that, in addition to capturing macroscopic responses, provide a more refined and physically interpretable approximation of microstructural behavior, particularly under nonlinear or history-dependent conditions. 

To demonstrate the benefits of going beyond global homogenized responses during training, we propose an enhanced DMN framework that incorporates local field data into the offline training phase to improve predictive accuracy and generalization. The overall methodology is illustrated in Fig. 1. Training data are generated using linear Fast Fourier Transform (FFT)-based DNS under diverse boundary conditions and material properties sampled via Latin hypercube sampling (Fig. 1a and b). These simulations yield both homogenized outputs and spatially resolved local field information. To fully exploit this rich dataset, we integrate a U-Net-based architecture into the DMN training process (Fig. 1c). The U-Net encodes microstructural response 

```
1 3
```

Computational Mechanics 

**==> picture [489 x 312] intentionally omitted <==**

**Fig. 1** Overview of the U-Net-architected deep material network (DMN) framework. **a** Direct numerical simulations (DNS) are performed using a linear FFT-based solver under prescribed boundary conditions and material properties, providing local stress field distributions. **b** Training data are generated under diverse boundary conditions, with material properties sampled via Latin hypercube sampling. 

through the DMN’s hierarchical structure: the encoder maps microstructural inputs to global homogenized responses, while the decoder reconstructs local field distributions by guiding the localization operators embedded within the network. Skip connections in the U-Net architecture facilitate the transfer of intermediate-scale physical information from the encoder to the decoder. These connections help compensate for information loss during deep encoding and allow the global context (sets of boundary conditions) to guide the reconstruction of local fields, improving the physical consistency and accuracy of the predictions. The resulting network preserves the interpretable binary-tree format of the original DMN and serves as a ROM capable of extrapolating constitutive behavior across a wide range of loading conditions (Fig. 1d), as demonstrated in earlier DMN studies [23]. By leveraging local field data during training, the proposed framework enables a more faithful and physically meaningful representation of the underlying microstructure, leading to improved expressiveness and predictive performance. 

The input is the material properties, and the output corresponds to the resulting stress distribution. **c** The DMN is trained offline using a U-net architecture, which learns network parameters governing homogenization and localization operations. **d** During online prediction, the trained DMN operates as a reduced-order model capable of extrapolating constitutive behavior 

The remainder of this paper is organized as follows. Section 2 details training data generation, which yields local stress distributions from DNS. Section 3 introduces the modified DMN architecture and the integration of U-Netbased features into the training pipeline. Section 4 discusses the DMN’s online prediction capabilities, and Sect. 5 presents numerical results and model comparisons, including validation against DNS. Section 6 presents the conclusions of this work. 

## **2 Training data generation** 

The U-Net-architected DMN model is trained offline using linear-elastic simulation data generated from FFT-based DNS [24]. Figure 2 illustrates the data generation process. Each material phase is assumed to exhibit orthotropic behavior for a selected periodic unit cell microstructure targeted for reduced-order modeling. To generate _N_ d training samples, a range of material properties is defined, and base material stiffness tensors ( **C** A and **C** B) are sampled using 

```
1 3
```

Computational Mechanics 

**==> picture [489 x 286] intentionally omitted <==**

**Fig. 2** Training data generation for the U-Net-architected DMN. The proposed DMN model is trained on linear-elastic FFT-based simulation data for periodic unit cells with orthotropic material phases. The input data are sampled as an elastic stiffness tensor for each material phase using Latin hypercube sampling, and multiple macroscopic strain conditions are applied. The scatter points represent individual 

material properties of each phase used to construct the given microstructure. Output data are enriched with additional statistical details from DNS, capturing both mean and standard deviation of stress distributions per material phase and boundary condition, structured in matrices **M** A, **M** B, **SD** A, and **SD** B for expanded training data 

Latin hypercube sampling [25] to form the input dataset. DNS simulations are conducted under macroscopic straincontrolled boundary conditions, following protocols established in previous DMN studies [9, 23, 26, 27], to generate the output data. Typically, multiple boundary conditions, corresponding to the number of independent strain components dictated by the problem’s dimensionality, are applied to the periodic unit cell to compute its homogenized elastic response [24]. For example, three independent macroscopic strain states are applied to the unit cell in a two-dimensional setting, and the resulting volume-averaged stress responses yield the three columns of the homogenized **C** h matrix. Thus, each training pair consists of base material tensors for each phase (CA, CB) as input and the corresponding homogenized stiffness tensor as the output (Ch) aligns with the standard DMN training approach, where the learning objective is to map input microstructural stiffness to effective macroscopic properties. 

In the proposed U-Net-architected DMN framework, we enrich the training outputs by incorporating additional local field information extracted from FFT-based DNS. As illustrated in the red panel of Fig. 2 ( _Elastic FFT simulation_ ), the DNS provides more than just homogenized material 

properties. It also yields stress distributions for each material phase under every applied boundary condition. While the volume average of these stress fields recovers the homogenized value, we further extract statistical information to capture microstructural heterogeneity. 

Specifically, for each material phase and boundary condition, we compute the first moment (mean) and second moment (standard deviation) of the stress distribution. These statistics are organized into structured output matrices that expand the model’s predictive target space. The statistical description of the local field could be further enriched by incorporating higher-order moments; however, as discussed later, preliminary experiments indicate that the direct inclusion of higher-order statistics does not necessarily improve predictive accuracy. For each training sample, we define a set of output matrices, denoted as M _j_ and SD _j_ , where M and SD indicates the mean and standard deviation, respectively, and the subscript _j_ denotes the material phase. Each matrix stores the statistical descriptors of the stress components across all boundary conditions, forming a compact yet informative representation of the local field behavior. Matrix **M** _j_ and **SD** _j_ are formulated as follows: 

```
1 3
```

Computational Mechanics 

|SD_j_|M_j_ =<br><br><br>_µ_(_σ_11b_._c_._1)<br>_µ_(_σ_11b_._c_._2)<br>_µ_(_σ_22b_._c_._1)<br>_µ_(_σ_22b_._c_._2)<br>_µ_(_σ_12b_._c_._1)<br>_µ_(_σ_12b_._c_._2)<br> =<br><br><br>std(_σ_11b_._c_._1)<br>std(_σ_11b_._c_._2)<br>std(_σ_22b_._c_._1)<br>std(_σ_22b_._c_._2)<br>std(_σ_12b_._c_._1)<br>std(_σ_12b_._c_._2)|_µ_(_σ_11b_._c_._3)<br>_µ_(_σ_22b_._c_._3)<br>_µ_(_σ_12b_._c_._3)<br><br><br>_j_<br>std(_σ_11b_._c_._3)<br>std(_σ_22b_._c_._3)<br>std(_σ_12b_._c_._3)<br><br><br>_j_|_,_<br>_,_|(1)|
|---|---|---|---|---|



when _σkl_[b] _[.]_[c] _[.i]_ is the stress distribution of phase _j_ =(A, B) for the given _i_ -th boundary condition. 

The DNS simulations were conducted using the FFTbased method [24], which computes strain and stress fields in periodic media by discretizing the microstructure into a regular grid of material points. This micromechanical analysis imposes the linear elastic constitutive relation at each pixel/voxel ( _**σ**_ = C _**ϵ**_ ) while enforcing stress equilibrium and strain compatibility by solving the corresponding partial differential equation. The solution procedure introduces a homogeneous reference medium and a polarization field, which is a function of the reference stiffness and the unknown local fields. By reformulating the partial differential equation as a convolution integral between a properly defined Green’s operator associated with the reference stiffness and the polarization field, and by solving the convolution as a product in Fourier space, the method iteratively updates the stress and strain fields until convergence is achieved [24]. 

For microstructure modeling, periodic unit cells were discretized into 256 _×_ 256 pixels, as shown in the top-left panel of Fig. 2. The base periodic units cell, composed of a matrix with five inclusions of varying sizes, has a total volume fraction of 29%. Each constituent phase was modeled as an orthotropic elastic material, with its stiffness tensor C _i_ (where _i_ = A or B) serving as input training data. We incorporated orthotropic samples to expose the DMN to a wider range of directional stress–strain dependencies, consistent with earlier DMN studies that used such stiffness tensors to increase the representational richness of the microstructure. This added directional variability in the training data enables the network to learn internal parameters that better represent microstructural complexity, improving generalization even when the validation microstructures themselves are elastically isotropic. 

The matrix representation of the 2D orthotropic stiffness tensor is given by: 

**==> picture [239 x 37] intentionally omitted <==**

Following the approach of Nguyen and Noel [27], we imposed bounds on the range of sampled elastic constants to ensure the positive definiteness of the elastic stiffness 

tensors. This resulted in a training dataset comprising approximately 1,000 effective sets of stress moments of each phase ( **M** A, **M** B, **SD** A, **SD** B), calculated with the FFTbased DNS for pairs of CA and CB, similar to the method applied in earlier DMN work [23]. 

**==> picture [239 x 89] intentionally omitted <==**

here, _U_ (a,b) represents a uniform distribution over the range [a,b]. This 2D microstructural scheme involved sampling seven parameters across both phases. Generating the complete training dataset for a given microstructure required approximately 800 min of wall-clock time on an Apple M1 Max chip. Note that compared to previous DMN works that solely used the global homogenized stiffness tensor for training, this approach requires almost the same computational cost to generate the extended output training data. 

## **3 U-Net-architected deep material network** 

In this section, we provide details of the DMN training using a U-net architecture, as shown in Fig. 1c. The network takes base material properties as input and applies the homogenization process from the original DMN [23]. This operation is followed by a localization process, which reconstructs the local field information in terms of first and second moments, serving as the output for training. The localization process requires additional information that cannot be directly passed from the previous layer. To address this, the U-Net architecture enables the homogenization network to effectively transfer the necessary information. The following subsections provide detailed explanations of the U-net construction, as well as the homogenization and localization inverse building blocks. 

## **3.1 U-Net DMN for training** 

The standard DMN framework performs hierarchical homogenization by combining base material properties through physics-based, micromechanical building blocks. While this approach effectively captures homogenized behavior, it often neglects the rich local field data produced by DNS during training. To bridge this gap, we propose a U-Net-augmented DMN architecture capable of learning homogenized responses and local field information within 

```
1 3
```

Computational Mechanics 

a unified framework. As shown in Fig. 3, the training process begins by assigning phase-wise material properties ( **C** A, **C** B) to the base nodes of the network. These properties propagate through the binary-tree architecture using micromechanical homogenization, following the original DMN formulation. For each macroscopic strain used to generate the training data, the localization process determines the strain field in each phase by decoding the global deformation through the network. In this framework, the intermediate-scale physical information transferred through the skip connections corresponds to the latent representations of localized stress–strain relationships (base material information, node information), and to the network parameters governing hierarchical homogenization. These latent tensors are passed directly from the encoder to the decoder layers, preserving spatial and hierarchical correlations across different scales during localization. This mechanism enables the network to maintain micromechanical consistency while reconstructing phase-wise field quantities. At the end of the localization process, the model provides access to phasewise local strain fields in a reduced representation. Based on this localized strain and the U-Net-transferred material properties, we calculate the stress moments of each phase, defined as the weighted (by the volume fraction) mean and standard deviation of stress. These statistical quantities serve as additional training targets, enhancing the model’s 

ability to capture microstructural variability and improve generalization in nonlinear regimes. 

The U-Net structure reinforces the connection between homogenization and localization by facilitating the flow of physically relevant features across the network. In conventional feed-forward DMN architectures, the intermediate representations generated during homogenization are not directly retained or reused in subsequent localization steps. However, these representations encode essential information for reconstructing phase-wise stress and strain fields. By introducing skip connections between the encoder and decoder layers, the U-Net structure enables access to these internal features during localization, thereby improving the fidelity of local field prediction. Importantly, this enhancement is achieved without increasing the total number of trainable parameters, as the skip connections reuse existing representations rather than introducing new weights, consistent with the original DMN formulation [23]. 

For a network of depth _N_ , the architecture is composed of 2 _[N]_ base layer nodes, each associated with an activation weight _ω_ , and 2 _[N]_ -1 internal nodes, each carrying a normal vector _⃗n_ that governs the orientation of the homogenization interface. Note that the subscripts and superscripts in Fig. 3 correspond to the layer and node IDs, respectively. In our two-dimensional setting, each normal vector requires one parameter (i.e., a single angle); therefore, the total number of trainable parameters is 2 _[N]_[+1] _−_ 1. These parameters govern 

**==> picture [489 x 239] intentionally omitted <==**

**Fig. 3** U-Net-architected DMN for training with local field information. The training process integrates homogenization and localization within a U-Net-augmented DMN framework. Base material properties ( **C** 1 and **C** 2) are assigned to the network input nodes and propagated through the binary tree to compute effective homogenized responses. During localization, the U-Net structure facilitates the transfer of 

intermediate physical features between encoder and decoder layers, enabling the reconstruction of phase-wise local field statistics. The model outputs stress moments for each material phase, forming a comprehensive training target that enhances the network’s ability to generalize and predict spatially resolved responses 

```
1 3
```

Computational Mechanics 

the propagation of material properties and microstructural interactions through the network during offline training. The integration of the U-Net architecture improves feature transmission between layers by reorganizing intermediate field information through lateral connections, without altering the original parameterization scheme. The detailed formulations of the homogenization and localization processes are presented in the following subsections (Fig. 4). 

Each DNS sample provides global responses (effective stiffness tensors) and statistical parameters (moments) of the local fields during training. The volume-fraction-weighted mean stress over all phases corresponds to the effective stiffness matrix **C** h. In addition to the homogenized output, the model is supervised to match the first and second statistical moments (mean and standard deviation) of the stress distributions for each material phase under multiple loading conditions. These quantities are structured into moment matrices defined in Eq. (1). To this end, the network is trained using a composite loss function combining global and local objectives. The global term minimizes the discrepancy between the predicted and DNS-based homogenized stiffness tensors, while the local term enforces consistency in the predicted stress statistics across phases and boundary conditions. In summary, the U-net-augmented DMN enables a physicsinformed learning process that captures homogenized material responses and localized field information within a single architecture. The U-Net-augmented DMN is trained offline training mode by minimizing a composite loss function that jointly enforces both global and local field fidelity. In Sections 3.2 and 3.3, we present the detailed formulations of 

the homogenization and localization modules illustrated in Fig. 3, and explain how the macroscopic response and localized field quantities are connected within the proposed U-net DMN framework. Section 3.4 summarizes the full training workflow with accompanying pseudocode. 

The total loss functions can be defined as a weighted sum of moment matrices. In this study, we tested and compared five different cost functions: 

**==> picture [239 x 97] intentionally omitted <==**

where, _j_ =(A, B) and 

**==> picture [239 x 110] intentionally omitted <==**

**==> picture [489 x 186] intentionally omitted <==**

**Fig. 4** Homogenization process within a single building block of the DMN. **a** Material properties (CA _,_ CB) are assigned to the base layer nodes along with their activation weights ( _ω_ ), representing phase volume fractions. These are combined through a chained homogenization process governed by micromechanical relations. The output of the network passes the homogenized material property. **b** Homogenization building block. Each parent node aggregates the responses of 

two child nodes ( _**ϵ**_ 1 _,_ _**σ**_ 1 _,_ C1) and ( _**ϵ**_ 2 _,_ _**σ**_ 2 _,_ C2) to compute the homogenized strain, stress, and stiffness ( _**ϵ**_ h _,_ _**σ**_ h _,_ Ch). The node information includes local fields and material properties, while network parameters ( _ω_ 1 _, ω_ 2 _,⃗n_ h) control the relative influence and interface orientation. The outputs ( _ω_ h _,_ Ch) are determined through analytical relations subject to physical constraints and subsequently propagated through the hierarchical structure of the network 

```
1 3
```

Computational Mechanics 

The weight constraint _Wc_ represents a constraint on the weights of the base layer (Layer _N_ ) summing up to 1 (total volume constraint). The volume fraction constraint _Vc_ enforces consistency with the prescribed microstructure volume fraction _vf_ . The subscript and superscript of the weights indicate the layer number _N_ and the node ID at the base layer, respectively. The term _E_ ( _·_ ) compares the predicted and reference field information. ( _·_ )[DNS] _n_ and ( _·_ )[DMN] _n_ are the quantities obtained from DNS and predicted by the network, respectively. The norm _|| · ||_ , used for the field information error, refers to the 2-norm of all matrix components. _N_ batch denotes the batch size. 

Each cost function represents a distinct training objective related to homogenized responses, local field statistics, or regularization criteria. Cost function A is the classical cost function used in standard DMN implementation and focuses on predictions of the homogenized stiffness tensor while enforcing the total volume constraint. Cost function B replaces direct supervision of the homogenized response with independent supervision of the phase-wise mean stresses and their corresponding volume fractions. Cost function C augments the homogenized-response supervision by adding a penalty on the phase-wise mean stressmoment errors. Cost function D extends cost function C by also penalizing errors in the phase-wise stress standard deviations, thereby incorporating second-moment information. Finally, cost function E balances homogenized stiffness errors with first- and second-moment stress statistics, scaled by network depth, to jointly supervise global and local field behavior. These losses are computed over batches of DNSgenerated data, guiding the network to capture both the effective macroscopic behavior and the underlying spatial distribution of field quantities. The training uses the Adam optimizer [28] with AMSGrad [29], an adaptive learning rate of 5 _·_ 10 _[−]_[5] (1 + cos(10 _πm/M_ )), and a mini-batch size of 20. Here, _m_ denotes the current epoch, and _M_ is the total number of epochs, fixed at 4,000. The ReLU activation is employed for base layer weights to enforce physical nonnegativity, and weight normalization is imposed to ensure convex combinations during homogenization. This setup enables stable convergence of the network parameters while preserving the physical interpretability of the network structure. We trained our network using 80% of the DNS data, while the remaining 20% was used as a validation set to evaluate the DMN performance. 

## **3.2 Homogenization formulation within a DMN building block** 

The homogenization process in the DMN is based on classical micromechanical principles and is applied recursively across a binary-tree architecture. Each building block 

combines two child nodes, which each is identified by stiffness tensors (C1 _,_ C2), strain ( _**ϵ**_ 1 _,_ _**ϵ**_ 2), and stress responses ( _**σ**_ 1 _,_ _**σ**_ 2) as node information and pass it into a parent node that produces an effective homogenized response ( _**ϵ**_ h _,_ _**σ**_ h _,_ Ch) as the node information. The child node contributions are weighted by network parameters _ω_ 1 and _ω_ 2, satisfying _ω_ h = _ω_ 1 + _ω_ 2. The normalized volume fractions are defined as _f_ 1 = _ω_ 1 _/ω_ h and _fB_ = _ω_ 2 _/ω_ h. The physical constraint is also satisfied using the normal vector _⃗n_ h as a network parameter. 

The fundamental physical constraints are enforced for the volume averaged strain and stress: 

_**ϵ**_ h = _f_ 1 _**ϵ**_ 1 + _f_ 2 _**ϵ**_ 2 _,_ _**σ**_ h = _f_ 1 _**σ**_ 1 + _f_ 2 _**σ**_ 2 _,_ (6) and the energy consistency: _**σ**_[T] h _**[ϵ]**_[h][=] _[ f]_[1] _**[σ]**_[T] 1 _**[ϵ]**_[1][+] _[ f]_[2] _**[σ]**_[T] 2 _**[ϵ]**_[2] _[,]_ (7) along with the local constitutive laws: 

_**σ**_ h = Ch _**ϵ**_ h _,_ _**σ**_ 1 = C1 _**ϵ**_ 1 _,_ _**σ**_ 2 = C2 _**ϵ**_ 2 _._ (8) Also, the interface traction continuity (kinetic relation) should be considered, 

H[T] ( _**σ**_ 1 _−_ _**σ**_ 2) = 0 _,_ (9) 

where H = H( _⃗n_ h) is the projection matrix constructed from the unit normal vector, _⃗n_ h = [cos 2 _πθ_ , sin 2 _πθ_ ], defining the material interface. In 2D, H takes the form: 

**==> picture [239 x 32] intentionally omitted <==**

Using Eqs. (6, 7 and 9), a kinematic relation for the strain jump is derived: 

**==> picture [239 x 23] intentionally omitted <==**

where b is a vector enforcing traction continuity. Solving for b with the elastic constitutive law, which is Eq. (8) used for generating the training data, we obtain b = B _**ϵ**_ h when: 

**==> picture [241 x 63] intentionally omitted <==**

```
1 3
```

Computational Mechanics 

**==> picture [239 x 25] intentionally omitted <==**

This expression constitutes the homogenization function applied at every building block in the DMN and is recursively assembled throughout the network hierarchy. The loss function employed in this study is defined in accordance with thermodynamic principles. As discussed by Gajek et al. [26], each hierarchical laminate within the DMN preserves thermodynamic consistency through the convexity of the underlying material potentials, and the entire network inherits this property during homogenization. Line by line derivations of the related equations can be found in Shin et al. [23]. 

## **3.3 Localization formulation within a DMN inverse building block** 

The DMN not only homogenizes the global behavior of heterogeneous materials but also reconstructs the local strain and stress fields through recursive localization. In previous DMN studies, this localization procedure was typically performed during the online prediction stage [9, 17]. In contrast, the present work integrates the localization step directly into the offline training process, allowing the network to learn both global and local responses simultaneously. As illustrated in Fig. 5, localization operates inversely to homogenization, propagating macroscopic strain information downward through the network hierarchy. The kinematic relationships and internal equilibrium conditions 

are enforced at each inverse building block to partition the strain between child nodes. 

At each inverse building block, the macroscopic strain input _**ϵ**_ h at the parent node is partitioned into two child strains, _**ϵ**_ 1 and _**ϵ**_ 2, according to kinematic constraints and the displacement jump introduced across the material interface. The child strains are computed by enforcing the following relation: 

**==> picture [239 x 12] intentionally omitted <==**

This formulation is derived by combining the volume averaged strain condition Eq. (6) with the strain jump relation Eq. (11) that arises from traction continuity. 

The displacement jumping vector b characterizes the deviation between the child strain fields and is computed from the physical constraint considered during the homogenization. Its closed-form expression is given by: 

**==> picture [239 x 12] intentionally omitted <==**

where the function _g_ ( _·_ ) is consistent with the derivation following Eq. (12). Note that since the localized strain corresponds to the phase average, the node’s strain represents the first moment of the local field distribution within each phase. 

After homogenization is completed (Fig. 3), a macroscopic strain input, represented as a 3 _×_ 3 identity matrix in the 2D setting, is applied to initiate the localization process. This corresponds to the three independent macroscopic 

**==> picture [489 x 185] intentionally omitted <==**

**Fig. 5** Localization process within a single inverse building block of the DMN. **a** A macroscopic strain is input to the network as node information, and the strain of each child node are derived by satisfying physically constrained localization. The displacement jump is introduced as an internal variable in the inverse building block, related to the strain deviation between phases. These localizations are continued through a chained localization process until they reach the decoded 

base layer. The network’s output derives the moment of weighted stress. **b** Localization inverse building block. The strain localization process recursively propagates the macroscopic strain information through the DMN architecture to reconstruct the local field statistics within the microstructure. Network parameters not assigned from the previous layer are received from the U-Net architecture 

```
1 3
```

Computational Mechanics 

strain states used for generating the training dataset; in three dimensions, this would extend to a 6 _×_ 6 representation. By recursively applying the localization procedure across all inverse building blocks, the DMN reconstructs the phasewise strain field distribution from the prescribed macroscopic input. These localized strain fields are then used to evaluate the corresponding stress responses at the base layer nodes using the shared constitutive models, as illustrated at the top of Fig. 3. Based on these localized stress predictions, we further compute the statistical stress moments of each phase. Specifically, the phase-wise mean and standard deviation values are evaluated by aggregating stress values across all base layer nodes, weighted by their respective volume fractions. These stress moments serve as reference quantities in training and are incorporated into the loss functions defined in Eqs. (4)-(5), thereby guiding the network to match both the macroscopic response and the internal statistical structure of local fields. 

## **3.4 Summary of the training workflow** 

The overall training workflow of the U-Net–architected DMN follows the hierarchical formulation introduced in Sections 3.2 and 3.3. For each DNS sample, phase-wise stiffness tensors are assigned to the base nodes, and homogenization (Section 3.2) propagates material information 

upward through the binary-tree architecture. The resulting multiscale latent features from each encoder layer are stored for localization. Given a prescribed macroscopic strain, localization proceeds downward through the inverse building blocks (Section 3.3), partitioning the global strain into phase-wise contributions. At each hierarchical level, the U-Net skip connections inject the corresponding encoder features. This allows the decoder to combine homogenized responses with intermediate-scale structural information and produce refined strain fields at the base nodes, which are subsequently converted into stresses via the constitutive law. Localization is formulated as a deterministic mapping conditioned on the homogenized quantities obtained from the preceding layers. The U-net-based architecture reinforces this property by transmitting intermediate features from the encoder to the decoder, providing additional constraints that regularize the inverse mapping. As a result, the localization remains single-valued and physically consistent with the hierarchical information flow of the original DMN. Phase-wise stress moments are then computed by aggregating the base-node stresses using their activation weights; the composite loss function (Sect. 3.1) is evaluated using both homogenized responses and local field statistics. The entire pipeline is fully differentiable, allowing end-to-end optimization of the homogenization, localization, and skipconnection modules. A concise pseudocode outlining this workflow is presented in Algorithm 1 alongside Fig. 3. 

**==> picture [489 x 152] intentionally omitted <==**

**Fig. 6** DMN framework for online prediction. Starting from a macroscopic strain input, the DMN predicts the localized strain by recursively applying kinematic conditions across building blocks. The base layer nodes solve the local constitutive laws, which may differ from the training data, enabling extrapolation to untrained material behav- 

iors. Satisfied kinetic conditions propagate the stress fields upward, and the overall macroscopic stress response is evaluated at the network root. The internal jumping vectors are updated iteratively to ensure equilibrium consistency at each building block 

```
1 3
```

Computational Mechanics 

**Algorithm 1** Pseudocode for the training procedure of the U-net–augmented DMN. 

**==> picture [340 x 445] intentionally omitted <==**

## **4 Deep material network for online prediction** 

Once trained offline, the DMN is an efficient and physically interpretable ROM for multiscale material analysis during online prediction. The online prediction involves applying a macroscopic input strain to the root node and propagating information through the network to predict macroscopic and localized responses. A key advantage of the online localization process is that the constitutive law at the base nodes can be extrapolated beyond the training regime, enabling prediction of previously unseen loading conditions. The approach here is the same as the traditional DMN approaches in early 

DMN works [23, 26, 27]. This work reviews the procedure with the summarized schematically in Fig. 6. 

The online prediction process starts by prescribing a macroscopic strain tensor at the root node. This strain is propagated downward through the DMN hierarchy using the kinematic localization conditions defined at each building block. The macroscopic strain is partitioned into child node strains by introducing internal displacement jumps, following the relations derived in Eq. (14). At the base layer, the localized strain fields are used as input to the constitutive laws of the respective material phases. Notably, the DMN architecture allows for generalization beyond the training regime, meaning that the local constitutive behavior 

```
1 3
```

Computational Mechanics 

**==> picture [489 x 186] intentionally omitted <==**

**Fig. 7** Offline training history of the U-Net DMN. The plot shows the mean training costs of 30 random trained DMNs using five different cost functions are plotted over 4000 epochs for network depths _N_ = 3 _,_ 5 _,_ 7. Each curve shows the evolution of the total loss aggre- 

gated from homogenization and localization objectives. All cases exhibit stable convergence, with deeper networks achieving lower final loss values due to enhanced representation capacity 

at the base nodes can differ from that used during offline training. For example, nonlinear elasto-viscoplastic material responses or temperature-dependent behaviors can be introduced without retraining the DMN structure. Based on the extrapolated constitutive model, each base material independently evaluates its local stress. Once the stress fields are computed at the base nodes, they are recursively homogenized upward through the network by satisfying kinetic conditions. Specifically, the stress jumps across the interface at each building block must satisfy equilibrium according to the traction continuity condition in Eq. (9). The internal jumping vectors b are updated iteratively at each block during the online phase to enforce this condition. This iterative update corrects the strain partitioning to satisfy equilibrium under the new constitutive behavior at the base nodes. 

Finally, the macroscopic stress is computed at the root node based on the volume-averaged contributions of all branches. The network thus completes the mapping from an applied macroscopic strain to both the global macroscopic stress response and the full-field local strain and stress distributions. Although the present work focuses on strain-imposed boundary conditions, the framework can be extended to mixed or stress-imposed loadings [30]. Overall, the DMN online prediction framework enables efficient extrapolation across material behaviors, offering a generalizable surrogate model that remains deeply rooted in micromechanical consistency principles. This combination of computational efficiency, physics enforcement, and flexibility makes the DMN architecture suitable for nonlinear multiscale simulations beyond the training regime. 

## **5 Results** 

This section presents a detailed evaluation of the proposed U-Net-architected DMN framework. Offline training and online prediction performances are assessed under various scenarios, including extrapolation to unseen loading conditions and generalization across different microstructures. In addition, we examine the effect of training data volume on prediction accuracy to quantify the comparison of the framework’s data efficiency. 

## **5.1 Offline training performance** 

The offline training history is presented in Fig. 7. For each of the five cost functions defined in Eqs. (4, 5), the total training loss is plotted across 4,000 epochs for networks of depth _N_ = 3, 5, and 7. For each case, 30 networks were independently trained, each initialized with different random parameters. All configurations exhibited smooth convergence without divergence during optimization. The main hyperparameter in the proposed model is the network depth, which specifies the number of hierarchical layers in the binary-tree DMN structure. From the viewpoint of reduced-order modeling, network depth governs the tradeoff between model accuracy and computational cost: deeper network achieve higher accuracy but lower computational efficiency. As depth increases, the number of learnable network parameters and the corresponding degrees of freedom also grow. The training history further shows that the loss monotonically decreases and eventually stabilizes as the depth increases, indicating that deeper networks possess greater expressive capacity for capturing both homogenized 

```
1 3
```

Computational Mechanics 

responses and phase-wise stress statistics. The convergence behavior across all depths confirms the robustness of the U-net integration into the DMN architecture. In terms of computational cost, the training of the U-Net-architected DMN required approximately 20, 40, and 60 min for network depths of _N_ = 3, 5, and 7, respectively, which is about twice that of the original DMN [23]. The increase mainly stems from the added architectural complexity, while the total number of trainable parameters remains comparable to the baseline model. Among the five loss components, Cost Functions D and E exhibit comparatively higher final values. This is expected, as they correspond to the second statistical moments of the local stress fields. Accurately approximating such fine-scale statistical features is intrinsically more 

difficult, given the limited degrees of freedom available in the reduced-order DMN compared to full-field DNS. These relatively higher loss values do not indicate degraded model performance but instead reflect differences in the weighting structure of the cost functions and the inherent complexity of the targeted statistical quantities. Note that validation losses are not plotted in this figure, but were observed to closely follow the training losses. 

## **5.2 Online prediction under nonlinear elastoviscoplastic behavior** 

The online prediction performance of the U-Net DMN was evaluated under a nonlinear elasto-viscoplastic constitutive 

**==> picture [489 x 414] intentionally omitted <==**

**Fig. 8** Online prediction accuracy of the U-Net DMN. Predicted macroscopic stress–strain responses under nonlinear loading paths are compared against DNS reference solutions (black dashed lines). The red shaded regions indicate the 95% confidence intervals of the predictions based on models trained using Cost function A. Results 

are shown for network depths: **a** _N_ =3, **b** _N_ =5, and **c** _N_ =7. Stress-strain curves visualize the direct prediction accuracy, while violin plots summarize the distribution of prediction errors across both macroscopic strain inputs 

```
1 3
```

Computational Mechanics 

law. An elasto-viscoplastic constitutive model incorporating Norton’s law [31] for viscoplastic flow was adopted, defined as: 

**==> picture [239 x 27] intentionally omitted <==**

where _**ϵ**_ ˙ is the total strain rate, _**ϵ**_ ˙[e] and _**ϵ**_ ˙[p] are the elastic and plastic strain rate components, respectively; _q_ is the stress exponent; _**σ**[′]_ is the deviatoric stress; _σ_ eq = ~~√~~ 3 _/_ 2 _∥_ _**σ**[′] ∥_ is the equivalent von Mises stress; and _σ_ 0 is the flow stress. The two-phase composite was modeled with an elasto-viscoplastic matrix and linear elastic inclusions. Both phases were assumed to be elastically isotropic, with Young’s moduli of 100 GPa (matrix) and 500 GPa (inclusion), and Poisson’s ratios of 0.3 and 0.19, respectively. The matrix flow stress was set to _σ_ 0 = 100 MPa with a stress exponent _q_ = 10. Uniaxial tension ( _ϵ_ 11) and simple shear ( _ϵ_ 12) loading conditions were considered, each applied at a constant strain rate of 1 s _[−]_[1] . Periodic boundary conditions were imposed to ensure mechanical compatibility across the unit cell. Although the U-Net structure increases the cost of offline training, it does not introduce any noticeable computational overhead during online prediction, where extrapolation of nonlinear homogenized responses remains as efficient as in the original DMN. As studied in early work [23], the computational cost of the online prediction for _N_ = 3, 5, and 7 take about 1.4, 5.2, 7.2 s for a calculation, respectively, as 

compared to approximately 1 600 s by FFT for 100 time steps on an Apple M1 Max chip. 

It is important to remember that the U-Net DMN was trained exclusively on linear-elastic DNS data generated under various stiffness contrasts and boundary conditions. Thus, the elasto-viscoplastic online prediction represents an extrapolation performance in constitutive behavior and loading paths. Figure 8a–c compares the predicted macroscopic stress–strain responses produced by DMNs of depths _N_ =3, _N_ =5, and _N_ =7, respectively, against FFT-based DNS reference solutions [32]. The black dashed lines correspond to the DNS ground truth, while the red shaded regions represent the 95% confidence intervals of the predictions based on models trained using Cost function A. Across all network depths, the U-Net DMN demonstrates the ability to accurately predict the nonlinear macroscopic stress responses despite being trained only under linear elasticity. Deeper networks, particularly the _N_ =7 cases, exhibit lower prediction errors and better capture the viscoplastic transition. 

The violin plots summarize the distributions of prediction errors across both strain boundary conditions for each cost function. These results highlight the robustness and generalization capability of the U-Net DMN during the online prediction stage. In particular, the models trained with local field information exhibit superior performance, especially as network depth increases. This trend is expected, as deeper networks possess additional degrees of freedom and 

**==> picture [489 x 256] intentionally omitted <==**

**Fig. 9** Correlation between offline training loss and online prediction error. Each scatter plot shows the relationship between the final offline total loss and the relative macroscopic stress prediction error 

under nonlinear loading. Results are shown for networks trained with Cost functions A and E. Separate panels correspond to network depths _N_ = 3, 5, and 7 under both strain loading conditions 

```
1 3
```

Computational Mechanics 

can better represent and match detailed local field information captured during offline training. 

However, these results also highlight an important cautionary point. While the U-Net DMN provides access to local field information and demonstrates strong generalization in nonlinear settings, its prediction accuracy remains sensitive to the design of the cost function used during training. In particular, the choice of weighting and decomposition of statistical field quantities can significantly affect model performance. For example, models trained with Cost function B, which assigns equal weighting to the mean errors of each phase, consistently underperform compared to those trained with Cost function A. This suggests that learning phase information is better preserved when considered jointly rather than independently. Therefore, decomposing statistical terms or assigning uniform weights without physical consideration may not necessarily improve prediction accuracy. Incorporating higher-order statistics was tested, but these additions did not consistently improve prediction accuracy and sometimes introduced trade-offs with the homogenized response. These results indicate that a more systematic strategy would be required for such extensions, which may be especially relevant for materials exhibiting strongly localized fields. We therefore limit the present formulation to first- and second-order moments. In other words, careful design of the cost function is essential to leverage the capabilities of the U-Net DMN. 

In the following results, we primarily compare Cost functions A and E to highlight the effect of incorporating local field information. While Cost function A supervises only the macroscopic responses, Cost function E extends the loss formulation to include phase-wise statistical descriptors, placing greater emphasis on the first moment (mean) than the second (standard deviation). This formulation also aligns with the increasing model flexibility at greater network depths, where more expressive architectures can better capture local field variations. 

## **5.3 Correlation between offline training loss and online prediction error** 

Establishing a consistent link between offline training performance and online prediction accuracy is beneficial for validating the practical utility of the U-Net DMN. Such a correlation suggests that models optimized during training can generalize effectively to unseen constitutive behaviors and loading paths. Figure 9 presents scatter plots showing the relationship between the final offline total loss and the online macroscopic stress prediction error for networks trained using Cost functions A and E. Each point represents an independently trained model, and separate panels correspond to network depths _N_ = 3, 5, and 7 under both 

strain-loading conditions. The horizontal axis indicates the final total loss after training, and the vertical axis denotes the relative prediction error observed during nonlinear extrapolation. To enable comparison, the training losses from Cost functions A and E are scaled due to their differing magnitudes. 

The figure compares the performance of networks trained using Cost functions A and E. Cost function A supervises only the macroscopic homogenized response, while Cost function E augments the loss with phase-wise stress statistics, including both the first and second moments. In principle, well-trained networks should exhibit lower offline loss and correspondingly lower online prediction error. While this ideal trend does not hold uniformly, networks trained with Cost function E exhibit more consistent and favorable correlations across settings than those trained with Cost function A. The inclusion of statistical field information in the training objective appears to guide the network toward solutions that generalize better under nonlinear conditions. In the case of _σ_ 11 prediction at _N_ = 7, for example, the correlation is slightly negative; however, the absolute errors are already minimal, indicating well-converged performance across all training instances. In summary, Cost function E promotes better generalization by leveraging local statistical supervision, whereas Cost function A shows weaker and less reliable correlations, underscoring the importance of including local field information in training. These findings reinforce the value of embedding local field statistics within the DMN training, as it aligns offline training objectives with reliable online extrapolation performance. 

## **5.4 Effect of training data volume** 

The data efficiency of the U-Net DMN is evaluated in Fig. 10, which illustrates how prediction performance varies with both network depth and the number of DNS training samples. The total number of training samples was varied across three levels (250, 500, and 1 000), and for each case, networks were trained using Cost functions A and E. To assess prediction accuracy, all trained networks were evaluated on an entire data test set of 1 000 DNS samples. Figure 10a presents the probability density distributions of the relative errors in three hierarchical quantities within the linear regime: the homogenized stiffness tensor ( _E_ C), the first moment ( _E_ MA + _E_ MB ), and the second moment ( _E_ SDA + _E_ SDB ) of the phase-wise local stress fields, consistent with the batch-level error definitions in Eq. (5) for a batch size of 1. As expected, accuracy improves systematically with increasing network depth, and the error follows a lognormal distribution. 

In Fig. 10b, violin plots summarize the mean of error distributions from 30 independently trained networks for 

```
1 3
```

Computational Mechanics 

**==> picture [489 x 371] intentionally omitted <==**

**Fig. 10** Effect of training data volume on DMN performance. Relative prediction errors for homogenized stiffness, first-order moment, and second-order moment of the stress field are shown in **a** as probability 

density functions based on 1,000 evaluation samples for different network depths, and in **b** as violin plots summarizing the error distributions for varying training dataset sizes 

each training data size. Figure 10a shows the probability density of one of those and each scatter point corresponds to the mean of the histogram. Under Cost function A (standard cost function), which excludes local field information, the local statistics ( **M** and **SD** ) exhibit greater sensitivity to training data volume. This behavior arises because higherorder quantities, such as the standard deviation of the local stress field, require more training diversity to capture spatial heterogeneity and phase interactions that cannot be directly inferred from macroscopic responses. In contrast, the U-Net DMN trained with Cost function E (balancing homogenized stiffness errors with first- and second-moment stress statistics) demonstrates comparably stable errors in **M** and significantly lower errors in **SD** across dataset sizes, underscoring the effectiveness of embedding local supervision directly into the architecture of the DMN. This structural design enables the network to capture statistical field variations accurately, even when trained on a limited number of DNS 

data points, which is particularly advantageous in data-constrained settings. The improvement in local prediction accuracy is substantial, with errors often reduced by an order of magnitude compared to models trained without local field supervision. Although this benefit may slightly reduce the accuracy of homogenized quantities such as **C** and **M** , it reflects an intentional focus on capturing fine-scale field behavior, which is justified by the much larger improvement in local prediction accuracy. These results confirm that, despite larger training loss values (Section 5.1), models trained with Cost function E reconstruct phase-wise stress fields more accurately than those trained with the standard DMN Cost function A, while preserving comparable macroscopic responses. 

For applications concerned with stress concentration, damage initiation, or other local failure mechanisms, this modeling focus may be not only appropriate but also essential for reliable predictive performance. Because localized 

```
1 3
```

Computational Mechanics 

**==> picture [458 x 439] intentionally omitted <==**

**Fig. 11** Phase-wise evaluation of local stress statistics under nonlinear loading. Histograms of stress components _σ_ 11 ( **a** ) and _σ_ 12 ( **c** ) obtained from FFT-based DNS, shown separately for matrix and inclusion phases, serve as the reference distributions. Relative errors in phasewise mean ( **b** ) and in standard deviation ( **d** ) predicted by DMNs of 

increasing depth ( _N_ = 3 _,_ 5 _,_ 7) are presented for two training strategies: the baseline model trained only on the homogenized response (Cost function A, red) and the statistically supervised model trained with additional phase-wise stress moments (Cost function E, purple) 

mechanical processes such as damage nucleation or failure are driven by microscale field fluctuations, the improved accuracy of the U-Net DMN in reconstructing local fields provides a natural foundation for extending the DMN to applications that focus on damage evolution and failure, which are currently not well captured by existing DMN architectures. This enhanced local fidelity highlights the potential of the proposed approach as a reduced-order surrogate for practical structural applications. 

## **5.5 Evaluation of phase-wise statistical prediction in the nonlinear regime** 

To assess the capability of DMNs in predicting local stress statistics under nonlinear deformation, we compare their performance with respect to reference data obtained from DNS (FFT-based simulations). Figure 11a and c present the per-phase histograms of stress components _σ_ 11 and _σ_ 12, respectively, illustrating the distinct statistical profiles 

```
1 3
```

Computational Mechanics 

**==> picture [488 x 353] intentionally omitted <==**

**Fig. 12** Evaluation of the U-Net DMN on microstructural variability. Scatter plots show the relationship between the final offline cost function value and the corresponding online macroscopic stress prediction error for 30 independently trained DMNs with random initializations. Three periodic unit cell types with varying morphological features 

and phase distributions are considered in **a** , **b** , and **c** . Results demonstrate that deeper networks, particularly those trained with local field supervision (Cost function E), exhibit improved generalization across diverse microstructures 

of matrix and inclusion phases. The corresponding DMN predictions are evaluated under two training strategies: one using only the homogenized stiffness tensor C (Cost function A), and another that includes supervision on phase-wise mean and standard deviation of stress fields (Cost function E). This analysis follows the simulation setup described in Sect. 5.2. 

Figure 11b and d show the sum of relative errors in the phase-wise mean and standard deviation of the stress components _σ_ 11 and _σ_ 12, respectively, predicted by DMNs of varying depth. The vertical axis represents the sum of absolute relative errors for each stress moment. Notably, the error in mean stress prediction under _σ_ 12 loading is considerably larger than that observed in _σ_ 11, deviating from the relatively minor discrepancy seen in the macroscopic response. This highlights that, while the global stress may be well predicted, the phase-wise decomposition reveals 

substantial local errors, a phenomenon also observed in [23] due to microstructural heterogeneity. 

Despite the observed challenges, the proposed DMN with statistical supervision consistently reduces prediction errors, particularly as the network depth increases. These improvements demonstrate the model’s ability to capture local field variations that are not accessible through homogenized data alone. Such trends are consistent with those observed in the linear regime (Sect. 5.4), where deeper networks achieved better alignment with phase-wise statistical targets. In the nonlinear regime, the benefits are more pronounced, with little to no trade-off observed in the mean stress predictions. This suggests that incorporating statistical supervision not only improves the accuracy of higher-order local features but also maintains the reliability of macroscopic responses under complex loading conditions. 

```
1 3
```

Computational Mechanics 

## **5.6 Evaluation on microstructural variability** 

The generalization capability of the U-Net DMN to different microstructures is evaluated in Fig. 12. The proposed approach was tested on periodic unit cells exhibiting more complex topologies and phase distributions, following the setup described in [23]. Three distinct periodic unit cell configurations were considered. The first microstructure, shown in Fig. 12a, consists of 10 identical inclusions embedded within a matrix, collectively occupying 50% of the total volume. The second and third microstructures, illustrated in Fig. 12b and c, correspond to spinodal decomposition microstructures generated via the phase-field method [33, 34], with each phase occupying approximately 50% of the volume fraction. All periodic unit cells were discretized into a regular pixel grid and subjected to periodic boundary conditions to ensure mechanical compatibility. Independent DMNs were trained for each microstructure, ensuring consistent predictive performance across different structural configurations. 

Figure 12 presents the prediction errors for the homogenized mean stress obtained from elasto-viscoplastic analyses. The other setup conditions, including boundary conditions and material parameters, follow those in Sect. 5.2. The scatter plots depict the relationship between the final offline loss and the corresponding online prediction error for each of the 30 independently trained DMNs, similar to those in Sect. 5.3. Consistent with previous findings, deeper networks tend to exhibit improved predictive performance regardless of the cost function used. For shallower networks such as _N_ =3, it was less evident that training with local field information provided a clear benefit, as also observed in earlier results. However, as the network depth increases, particularly for _N_ =7, models trained with Cost function E, which incorporates local field statistics, show a more pronounced improvement. In the case of uniaxial strain loading in the _ϵ_ 11 direction, the benefit of local field supervision was less significant than under shear loading ( _ϵ_ 12), yet the absolute prediction errors remained smaller order across the board. These findings suggest that incorporating local statistical descriptors into the training process enhances extrapolative performance, especially for deeper architectures. Such robustness underscores the potential of the U-Net DMN as a practical surrogate model for multiscale simulations across diverse microstructures. 

## **6 Conclusions** 

This study introduced a U-Net-augmented Deep Material Network (DMN) that enhances the conventional DMN framework by incorporating local field supervision into its 

hierarchical structure. Through an encoder-decoder architecture with skip connections, the proposed model learns phase-wise stress distributions alongside homogenized responses, thereby improving field-level prediction fidelity and extrapolation capability under nonlinear loading conditions. 

The combination of the U-Net structure and the inclusion of first- and second-moment stress statistics during offline training enhance the model’s ability to capture microstructural heterogeneity. This results in a stronger correlation between offline training performance and online predictive accuracy, more accurate local field reconstruction, and robust generalization across varying microstructures. Moreover, the model demonstrates stable performance even when trained on relatively small datasets, highlighting its data efficiency. The present model uses first- and secondorder moments, which provide a stable and efficient balance for training. Extending the framework to include higherorder statistics remains an open challenge and a promising direction for future work, especially for materials exhibiting strongly localized fields. Such developments may further enhance local field fidelity. 

Although prioritizing local field accuracy may slightly degrade macroscopic predictions, it offers significant improvements in the resolution of microscale stress and strain fields, an essential aspect for reduced-order modeling and failure prediction. Previous studies mainly focused on assessing the extrapolation capability of the DMN, and have not directly examined whether changes to the training strategy can improve reconstruction of local fields. In this work, the conventional DMN trained solely on homogenized stiffness data is directly compared with the proposed formulation that includes local-field-aware supervision. Our results show that incorporating local field information during training markedly improves the reconstruction of microscale stress and strain distributions in the online stage, highlighting the benefit of the U-net augmentation. Overall, the proposed U-Net DMN extends the interpretability and modularity of classical DMNs into a more expressive and data-efficient framework for multiscale material modeling with field-level resolution. Ultimately, the U-Net DMN enables more effective use of available simulation data, turning previously underutilized local field information into a key driver of predictive accuracy and generalization. 

**Acknowledgements** The authors would like to thank the anonymous reviewers during the review of this paper for their constructive feedback and suggestions. RD and DS acknowledges support from the Advanced Scientific Computing program at Sandia National Laboratories. RAL acknowledges support from the Advanced Engineering Materials program at Los Alamos National Laboratory. DS acknowledges support from the National Research Foundation of Korea (NRF) grant funded by the Korea government (MSIT) (RS-2025-24534529). The DMN capability and computational resources are supported in part 

```
1 3
```

Computational Mechanics 

by the Center for Integrated Nanotechnologies, an Office of Science user facility operated for the U.S. Department of Energy. This article has been authored by an employee of National Technology & Engineering Solutions of Sandia, LLC under Contract No. DE-NA0003525 with the U.S. Department of Energy (DOE). The employee owns all right, title, and interest in and to the article and is solely responsible for its contents. The United States Government retains and the publisher, by accepting the article for publication, acknowledges that the United States Government retains a non-exclusive, paid-up, irrevocable, world-wide license to publish or reproduce the published form of this article or allow others to do so, for United States Government purposes. The DOE will provide public access to these results of federally sponsored research in accordance with the DOE Public Access Plan  h t t p s : / / w w w . e n e r g y . g o v / d o w n l o a d s / d o e - p u b l i c - a c c e s s - p l a n . 

## **Declarations** 

## **Conflict of interest** The authors declare no Conflict of interest. 

**Open Access** This article is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License, which permits any non-commercial use, sharing, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if you modified the licensed material. You do not have permission under this licence to share adapted material derived from this article or parts of it. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit h t t p : / / c r e a t i v e c o m m o n s . o r g / l i c e n s e s / b y - n c - n d / 4 . 0 /. 

## **References** 

1. Temizer I, Zohdi T (2007) A numerical method for homogenization in non-linear elasticity. Comput Mech 40:281–298 

2. Geers MG, Kouznetsova VG, Brekelmans W (2010) Multi-scale computational homogenization: trends and challenges. J Comput Appl Math 234:2175–2182 

3. Liu X, Tian S, Tao F, Yu W (2021) A review of artificial neural networks in the constitutive modeling of composite materials. Compos B Eng 224:109152 

4. Mirkhalaf M, Rocha I (2024) Micromechanics-based deep-learning for composites: challenges and future perspectives. Eur J Mech-A/Solids 105:105242 

5. Raissi M, Perdikaris P, Karniadakis GE (2019) Physics-informed neural networks: a deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations. J Comput Phys 378:686–707 

6. Karniadakis GE et al (2021) Physics-informed machine learning. Nat Rev Phys 3:422–440 

7. Henkes A, Wessels H, Mahnken R (2022) Physics informed neural networks for continuum micromechanics. Comput Methods Appl Mech Eng 393:114790 

8. Oommen V, et al (2025) Equilibrium conserving neural operators for super-resolution learning. arXiv preprint arXiv:2504.13422 

9. Liu Z, Wu C, Koishi M (2019) A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. Comput Methods Appl Mech Eng 345:1138–1168 

10. Wei T-J, Wan W-N, Chen C-S (2025) Deep material network: overview, applications and current directions. arXiv preprint arXiv:2504.12159 

11. Liu Z, Bessa MA, Liu WK (2016) Self-consistent clustering analysis: an efficient multi-scale scheme for inelastic heterogeneous materials. Comput Methods Appl Mech Eng 306:319–341 

12. Cheng L, Wagner GJ (2022) A representative volume element network (rve-net) for accelerating rve analysis, microscale material identification, and defect characterization. Comput Methods Appl Mech Eng 390:114507 

13. Nguyen BH, Schneider M (2025) Universal fourier neural operators for micromechanics. arXiv preprint arXiv:2507.12233 

14. Oommen V, Shukla K, Goswami S, Dingreville R, Karniadakis GE (2022) Learning two-phase microstructure evolution using neural operators and autoencoder architectures. Npj Comput Mater 8:190 

15. Clark KE, Milton GW (1994) Modelling the effective conductivity function of an arbitrary two-dimensional polycrystal using sequential laminates. Proc R Soc Edinb Sect A Math 124:757–783 

16. Dey AP, Welschinger F, Schneider M, Gajek S, Böhlke T (2022) Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelasticallyinformed strategy. Arch Appl Mech 92:2733–2755 

17. Shin D, Creveling PJ, Roberts SA, Dingreville R (2024) Deep material network for thermal conductivity problems: application to woven composites. Comput Methods Appl Mech Eng 431:117279 

18. Liu Z (2020) Deep material network with cohesive layers: multistage training and interfacial failure analysis. Comput Methods Appl Mech Eng 363:112913 

19. Jean JG, Su T-H, Huang S-J, Wu C-T, Chen C-S (2025) Graphenhanced deep material network: multiscale materials modeling with microstructural informatics. Comput Mech 75:113–136 

20. Wu L, Noels L (2025) Stochastic deep material networks as efficient surrogates for stochastic homogenisation of non-linear heterogeneous materials. Comput Methods Appl Mech Eng 441:117994 

21. Gajek S, Schneider M, Böhlke T (2021) An fe-dmn method for the multiscale analysis of short fiber reinforced plastic components. Comput Methods Appl Mech Eng 384:113952 

22. Wei H et al (2023) Ls-dyna machine learning-based multiscale method for nonlinear modeling of short fiber-reinforced composites. J Eng Mech 149:04023003 

23. Shin D, Alberdi R, Lebensohn RA, Dingreville R (2023) Deep material network via a quilting strategy: visualization for explainability and recursive training for improved accuracy. Npj Comput Mater 9:128 

24. Lebensohn RA, Kanjarla AK, Eisenlohr P (2012) An elastoviscoplastic formulation based on fast Fourier transforms for the prediction of micromechanical fields in polycrystalline materials. Int J Plast 32:59–69 

25. McKay MD, Beckman RJ, Conover WJ (2000) A comparison of three methods for selecting values of input variables in the analysis of output from a computer code. Technometrics 42:55–61 

26. Gajek S, Schneider M, Böhlke T (2020) On the micromechanics of deep material networks. J Mech Phys Solids 142:103984 

27. Nguyen V-D, Noels L (2022) Micromechanics-based material networks revisited from the interaction viewpoint; robust and efficient implementation for multi-phase composites. Eur J Mech-A/ Solids 91:104384 

28. Kingma D, Ba J (2014) Adam: A method for stochastic optimization. arXiv preprint arXiv:1412.6980 

29. Reddi S, Kale S, Kumar S (2019) On the convergence of Adam and beyond. arXiv preprint arXiv:1904.09237 

```
1 3
```

Computational Mechanics 

30. Shin D, Alberdi R, Lebensohn RA, Dingreville R (2024) A deep material network approach for predicting the thermomechanical response of composites. Compos B Eng 272:111177 

31. Irgens F (2008) Continuum mechanics, Springer Science & Business Media 

32. Lebensohn RA et al (2013) Modeling void growth in polycrystalline materials. Acta Mater 61:6918–6932 

33. Stewart JA, Dingreville R (2020) Microstructure morphology and concentration modulation of nanocomposite thin-films during simulated physical vapor deposition. Acta Mater 188:181–191 

34. Dingreville R, Stewart JA, Chen EY, Monti JM (2020) Benchmark problems for the mesoscale multiphysics phase field simulator (MEMPHIS). Tech. Rep. SAND2020-12852, Sandia National Laboratories (SNL-NM), Albuquerque, NM (United States) 

**Publisher's Note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations. 

```
1 3
```

