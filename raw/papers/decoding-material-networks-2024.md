---
title: "Decoding material networks: DMN vs IMN performance comparison"
journal: "10.1093/jom/ufae053"
authors: ["Author"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: ff5b339098f6fd0e2698a293d7ca08cd879f43686d50687c93d21bb3ad6e9c09
conversion: pymupdf4llm
---

_Journal of Mechanics_ , 2024, 40, 796–807 https://doi.org/10.1093/jom/ufae053 Regular Article 

**==> picture [60 x 48] intentionally omitted <==**

## Decoding material networks: exploring performance of deep material network and interaction-based material networks Wen-Ning Wan 1, Ting-Ju Wei 1, Tung-Huan Su 2 and Chuin-Shan Chen 1,∗ 

> 1Department of Civil Engineering, National Taiwan University, Taipei, Taiwan 

> 2Computational and Multiscale Mechanics Group, ANSYS Inc., Livermore, CA, USA 

> ∗Corresponding author: dchen@ntu.edu.tw 

## **ABSTRACT** 

The deep material network (DMN) is a multiscale material modeling method well-known for its ability to extrapolate learned knowledge from elastic training data to nonlinear material behaviors. DMN is based on a two-layer building block structure. In contrast, the later proposed interaction-based material network (IMN) adopts a different approach, focusing on interactions within the material nodes rather than relying on laminate composite structures. Despite the increasing interest in both models, a comprehensive comparison of these two computational frameworks has yet to be conducted. This study provides an in-depth review and comparison of DMN and IMN, examining their underlying computational frameworks of offline training and online prediction. Additionally, we present a case study where both models are trained on short-fiber reinforced composites. We trained each model using elastic linear datasets to evaluate their performance and subjected them to multiple loading tests. Their performance is closely compared, and the possible factors that cause differences are explored. The superiority of IMN in offline training and online prediction is found. 

**KEYWORDS:** deep material network, interaction-based material network, mechanistic machine learning 

## 1 INTRODUCTION 

Advancements in computational methods have expanded the capabilities of multiscale simulation. Traditionally, representative volume element (RVE) analysis and homogenization techniques, such as direct numerical simulations (DNS) via finite element methods [1–4], or fast Fourier transform [5,6], have relied on detailed microstructural information and high-resolution data to accurately model the response of an RVE. These methods, however, are computationally intensive and often require significant resources to capture the necessary microstructural details [7,8]. 

With the advent of artificial neural networks (ANNs) [9,10], data-driven material models [11,12] have emerged as powerful alternatives, serving as surrogate models that can reduce computational complexity and dramatically decrease the time required for online predictions. These models, including recurrent neural networks [13], convolutional neural networks [14] and graph neural networks (GNNs) [15–18], have shown remarkable performance in multiscale simulations by lowering the degrees of freedom in the computational process. Despite the promising speed enhancements ANN-based surrogate models offer, they often focus on a single problem. Another limitation is that the material sampling space is confined to the original training dataset, restricting the model’s ability to predict material behavior beyond this known space. Moreover, these models cannot handle history-dependent material behaviors, such as those involving plasticity or other nonlinear responses. This limitation 

is primarily due to the absence of physical information within the machine learning framework. 

One of the models that stands out in the field is the deep material network(DMN), introduced by Liu _et al._ [19,20]. DMN employs a binary tree with two-layer linear elastic laminate building blocks to represent the homogenization behaviors of an RVE. Unlike previous approaches, DMN offers several notable advantages, including predicting nonlinear behaviors while training solely on linear data. A crucial feature of DMN is its physically informed nature, which allows for extracting microstructural information, such as volume fractions and rotation angles, directly from the building block. This capability enhances DMN’s ability to capture mechanical properties that can be validated against real-world experimental data [21,22]. Consequently, DMN is well-suited to handle complex material behaviors, including finite strain, small strain deformation and nonlinear historydependent plasticity. As a result, DMN can be extended to various material systems, including polycrystalline materials [19] and multiscale carbon-reinforced composite materials [20]. 

Several extended works have enhanced the implementation of the DMN. Some of these extensions address more complex problems, such as creep loading behavior [23] and thermomechanical responses [24]. Others focus on improving performance, including strategies like quilting [25], integration with GNNs [26] and the development of a rotation-free DMN [27]. An alternative approach, the interaction-based material network (IMN)[28] claims to accelerate training without sacrificing accuracy. This distinction sparked our interest in comparing the 

Received: 15 September 2024; Revised: 26 October 2024; Accepted: 28 October 2024 

© The Author(s) 2024. Published by Oxford University Press on behalf of Society of Theoretical and Applied Mechanics of the Republic of China, Taiwan. This is an Open Access article distributed under the terms of the Creative Commons Attribution License (https://creativecommons.org/licenses/by/4.0/), which permits unrestricted reuse, distribution, and reproduction in any medium, provided the original work is properly cited. 

Decoding material networks • 797 

**==> picture [212 x 137] intentionally omitted <==**

Figure 1 DMN structure data flow. 

two material networks, and a direct comparison using the same study case has not been performed. 

IMN was proposed by Noël _et al._ [28,29]. IMN offers a different aspect of material networks. Instead of relying on the laminate building blocks, IMN introduces the concept of interactions among discrete material nodes within the network. IMN is a tree-based structure like DMN, but the successor nodes are not limited to 2, allowing it to deal with multi-phase material. IMN is also capable of handling porous microstructure, where setting zero strain on a node does not work for DMN. 

In this study, we will compare models’ methodological topology and evaluate computational performances during offline training and online prediction based on our in-house implementations using Python. To seek the key that causes differences in the performances, we conduct a close investigation of the framework of the models. 

The paper is organized as follows: In Section 2, the hierarchical structures of DMN and IMN will be fully described in both offline training and online prediction. In Section 3, models will be trained with an example, and the performance comparison will be presented. In Section 4, we will discuss the possible factors that cause improvement from DMN to IMN, and Section 5 for conclusion. 

## 2 METHODS 

This section presents the fundamental theories behind DMN and IMN and then compares their network topologies. Additionally, it includes a discussion on both offline and online workflows. 

## 2.1 Offline training 

Offline training is performed using linear data to capture the homogenized mechanical behavior of an RVE. The goal is to train the model to accurately represent the material’s responses under linear elastic conditions. 

## _2.1.1 DMN offline training_ 

The fundamental building block of DMN represents a twophase laminate. The composition of laminates depicts a microstructure. To fit the microstructure pattern, DMN applies two key operations to the blocks: homogenization and rotation. The DMN structure data flow is demonstrated in Fig. 1. 

Under Mandel notation, Cauchy stress _**σ**_ , and infinitesimal strain _**ε**_ are presented as: 

**==> picture [212 x 77] intentionally omitted <==**

Under the assumption of small strains in a three-dimensional framework, the stress–strain relationship within the building block can be expressed as 

**==> picture [138 x 11] intentionally omitted <==**

C is a second-order stiffness tensor. For each material, phase 1 and 2, we have 

**==> picture [175 x 11] intentionally omitted <==**

The volume fractions of phase 1 is denoted by _f_ 1 and phase 2 is denoted by _f_ 2 ≡ 1 − _f_ 1, and the averaging equation for stresses is 

**==> picture [244 x 55] intentionally omitted <==**

and kinematic constraints 

**==> picture [244 x 263] intentionally omitted <==**

**==> picture [243 x 72] intentionally omitted <==**

798 • Journal of Mechanics, 2024, Vol. 40 

**==> picture [207 x 63] intentionally omitted <==**

_�_ C = C[2] − C[1] and C[ˆ] = _f_ 2C[1] + _f_ 1C[2] , with _b_[1] 11[=] _[b]_[1] 22[=] _b_[1] 66[=][1][,][with][all][other][components][being][zero.][Note][that][the][ho-] mogenized process also works for compliance matrix and should be able to get the same result of homogenized stiffness matrix once inverse the homogenized compliance matrix. 

After analytically deriving the homogenized compliance matrix, a rotation step is applied to generalize the building block. The stiffness matrix C[¯] _[r]_ undergoes rotation by angles _α, β, γ_ 

**==> picture [189 x 12] intentionally omitted <==**

The rotation matrices _**R**_ based on Tait–Bryan angles are given by: 

**==> picture [203 x 103] intentionally omitted <==**

_**r**[p]_ and _**r**[ν]_ are the in-plane and output-plane rotation matrices, respectively, and for an arbitrary input angle _θ_ , the matrices are: 

**==> picture [247 x 70] intentionally omitted <==**

The combination of rotation function, which applies on the blocks, is denoted as 

**==> picture [186 x 10] intentionally omitted <==**

The complete DMN training algorithm is presented in Algorithm 1. The material properties of two phases are assigned to the leaf nodes, and the upper nodes are assigned with the homogenized tangent by a feed-forward process, detailed in Algorithm 2. Besides, consider a _N_ layer DMN with _i_ leaf nodes, an activation parameter _z_ is used to assign weight to the bottom nodes. The relationship between activation _zi_ and weight _wi_ is 

**==> picture [154 x 11] intentionally omitted <==**

The activation function used in DMN is ReLU [30]: 

**==> picture [175 x 26] intentionally omitted <==**

Then, the compliance matrices of two phases are homogenized and rotated following Eqs. (8) and (12). The homogenized matrix will be given to the parent node’s value at the next layer. The weight of the parent nodes is the summation of its leaf node 

_wN_ = _w_[1] _N_ +1[+] _[w]_[2] _N_ +1[.][Superscript][1][means][the][left][node][of][the] parent node, and superscript 2 means the right node of the parent node. Furthermore, the weight on each node reflects the volume fraction of the constituent phases, calculated as follows: _w_[1] _f_ 1 = _[,] f_ 2 = 1 − _f_ 1 _._ (18) _w_[1] + _w_[2] 

The upscaling process repeats until the data flow reaches the root node. The matrix we get on the root node is the output matrix C _[dmn]_ , which will be used to calculate accuracy. The error of a sample _s_ , comparing to DNS result C _[dns]_ is calculated as: 

**==> picture [164 x 27] intentionally omitted <==**

Backpropagation done by PyTorch [31] will update parameters, including weight at leaf nodes _wi_ and rotation angles _α, β, γ_ . 

## **Algorithm 1** DMN Training Algorithm 

**==> picture [240 x 137] intentionally omitted <==**

## **Algorithm 2** DMN Forward Pass 

**==> picture [240 x 138] intentionally omitted <==**

## _2.1.2 IMN offline training_ 

The interaction mechanism in IMN focuses on maintaining equilibrium between material phases. The IMN structure data flow is demonstrated in Fig. 2. Under the assumption of small strain, as presented in Eq. (3), the averaging strain over the volume _V_[¯] of an RVE can be expressed as 

**==> picture [155 x 24] intentionally omitted <==**

Decoding material networks • 799 

**==> picture [190 x 136] intentionally omitted <==**

Figure 2 IMN structure data flow. 

Stress and strain are denoted in Mandel notation, refer to Eq.(1). If we discretize Eq. (20), and separate the RVE into _K_ = [ _i_ = 0 _,_ 1 _,_ 2 _..., N_ − 1] parts, we can get: 

**==> picture [149 x 16] intentionally omitted <==**

where 

**==> picture [156 x 25] intentionally omitted <==**

The strain on each material part can be viewed as an averaging strain adding a fluctuation field _ω_ . Eq. (22) can be rewritten as: 

**==> picture [173 x 22] intentionally omitted <==**

where _s_ is the fluctuate boundary, _k_ is the face number of the material part and _N_ is the direction of the boundary. Therefore, we can apply the interaction mechanism: 

**==> picture [217 x 16] intentionally omitted <==**

Interaction mapping _I_ includes _αij_ , which is the contribution of node _i_ in mechanism _j_ , and _**a j**_ , which is the strain fluctuation on mechanism _j_ . The homogenized stiffness matrix can be expressed as a homogenized function _HIMN_ 

**==> picture [195 x 32] intentionally omitted <==**

where _�_ C = C[2] − C[1] . The interaction direction _**N[j]**_ is defined as: 

**==> picture [240 x 82] intentionally omitted <==**

If we rewrite _**N[j]**_ in to a tensor, we get: 

with _i_ leaf nodes, an activation parameter _z_ is used to assign weight to the bottom nodes. The relationship between activation _zi_ and weight _wi_ is 

**==> picture [155 x 11] intentionally omitted <==**

The activation function used in IMN is the smoothed version of ReLU: 

**==> picture [244 x 136] intentionally omitted <==**

The parameters that will be updated are the weights _w_ , and the angles _φ_ and _θ_ . 

## **Algorithm 3** IMN Training Algorithm 

- 1: **for** epoch in epochs **do** 2: **for** batch in batches **do** 3: _Xphase_ 1 _, Xphase_ 2 _, Yhomogenized_ ← inputs 4: output ← forward( _Xphase_ 1) _, Xphase_ 2 _▷_ Alg. 4 5: loss ← loss_fn(output _, Yhomogenized_ ) _▷_ Eq. (31) 6: active_sum ←[�] (weights at bottom nodes) 7: backpropagate 8: **end for** 9: total_loss ←[�] loss _▷_ Accumulate batch losses 

- 10: scheduler.step(total_loss) _▷_ Alg. 5 11: **end for** 

## **Algorithm 4** IMN Forward Pass 

- 1: **function** forward( _Xphase_ 1 _, Xphase_ 2) 2: assign_stiffness(root, _Xphase_ 1 _, Xphase_ 2) 3: upscaling(root, _Xphase_ 1 _, Xphase_ 2) 4: **end function** 5: **function** upscaling(node, _Xphase_ 1 _, Xphase_ 2) 6: **if** node.left is not leaf **then** 7: upscaling(node.left, _Xphase_ 1 _, Xphase_ 2) 8: upscaling(node.right, _Xphase_ 1 _, Xphase_ 2) 9: **end if** 

- 10: Assign leaf node phase 1 or phase 2 11: _C_ ← homogenized( _le f t.C, right.C, f_ 1 _, f_ 2 _, Nm_ ) 12: _▷_ Eq. (25) 13: **end function** 

After solving the analytical solution leads to 

**==> picture [170 x 16] intentionally omitted <==**

where C[ˆ] = _f_ 2C[1] + _f_ 1C[2] . The offline training process follows Algorithm 3. Similar to DMN, material properties of phases are assigned to the leaf nodes, as well as initial weight. The upscaling process follows Algorithm 4. Besides, consider a _N_ layer IMN 

## _2.1.3 Comparison of offline training_ 

In the offline stage, the IMN adjusts the interaction direction angle in a single step to ensure stress balance, as indicated in Eq. (25). In contrast, the DMN requires two steps for this adjustment, detailed in Eqs. (8) and (12). The DMN’s training parameters include activation _z_ and the angles _α_ , _β_ and _γ_ , whereas 

800 • Journal of Mechanics, 2024, Vol. 40 

**Algorithm 5** IMN Scheduler 1: **Input:** Initial learning rate _ηmax_ 2: **Parameters:** _ηmin_ ← 1 _e_ −4 _, κ_ ← 0 _._ 8 3: **Initialize:** previous_loss ← None 4: **function** step(current_loss, learning_rate) 5: **if** current_loss _>_ previous_loss **then** 6: _η_ ← max(learning_rate × _κ, ηmin_ ) 7: **else** 8: _η_ ← learning_rate 9: **end if** 10: previous_loss ← current_loss 11: **return** _η ▷_ Updated learning rate 12: **end function** 

Table 1. Compare parameters. 

|Table 1. Comp|are para|meters.|||
|---|---|---|---|---|
|Model||DMN||IMN|
|Activations|_z_|(2_N_ ) activations|_z_ (2_N_ ) activations||
|angles|_α_<br>_β_|(2_N_+1 −1)<br>(2_N_+1 −1)|_θ_<br>_φ_|(2_N_ −1)<br>(2_N_ −1)|
||_γ_|(2_N_+1 + 1)|||



Inside () states the amount of the parameters in an N-layer network. 

IMN’s training parameters consist of activation _z_ along with the angles _φ_ and _θ_ . The number of parameters used in each model is summarized in Table 1. Consequently, IMN operates with fewer degrees of freedom than DMN, which may lead to more efficient computation. 

Furthermore, the DMN training strategy focuses on constructing the optimal laminate block, while the IMN emphasizes achieving force equilibrium. By considering the entire RVE, IMN may better capture the underlying mechanisms under load. 

## 2.2 Online prediction 

A major advantage of material networks is their ability to extrapolate trained models to nonlinear material behaviors and complex loading conditions. The material nodes at the N layer of a tree represent individual material points, and by inputting boundary conditions, each iteration is designed to approximate the material’s deformation at each loading step with increasing accuracy. 

## _2.2.1 DMN online prediction_ 

For an RVE under a loading test, DMN finds the incremental stress while applying an incremental strain. The macroscopic strain is _**ε** out_ , and the relationship between internal incremental stress and strain is 

**==> picture [159 x 11] intentionally omitted <==**

D is the inverse of stiffness matrix C. The incremental stress is updated by Newton’s Method 

**==> picture [198 x 22] intentionally omitted <==**

_�_ _**σ**_ , _�_ _**ε**_ and _δ_ _**ε**_ are initially set as zero. Assign the material to the bottom layer and follow Eqs.(8) and(12) to update the tangents for all layers. As for residual strains, they are homogenized 

**==> picture [73 x 12] intentionally omitted <==**

**==> picture [215 x 189] intentionally omitted <==**

Rotated is also applied 

**==> picture [163 x 11] intentionally omitted <==**

During the forward homogenization, the compliance matrix D and residual strain _δ_ _**ε**_ are propagated from the leaf nodes to the root. At layer 0, the difference of _�_ _**ε**_ 0 and _�_ _**ε** out_ are used to update _�_ _**σ**_ and _�_ _**ε**_ . The incremental strain is updated using Newton’s method. Once we have the new incremental strain, we downscale it to each layer. At _i_ layer, _�_ _**ε** i_ will be downscale to _�_ _**ε**_[1] _i_ +1[,] _[�]_ _**[ε]**_[2] _i_ +1[,][and][assign][them][into][its][leaf][node.][Likewise,][we] undo strain rotation and dehomogenization on _�_ _**ε**_ : 

**==> picture [202 x 171] intentionally omitted <==**

_**s**_ is the strain localization matrix, which is done as follows: 

_�_ C = C[2] − C[1] and C[ˆ] = _f_ 2C[1] + _f_ 1C[2] , with _s_[1] 11[=] _[s]_[1] 22[=] _s_[1] 66[=][1][,][with][all][other][components][being][zero.][If][the][error] converges, we move on to the next loading step, and the error is estimated by the difference between the current incremental strain _�_ _**ε** s_ and the previous iteration incremental strain _�_ _**ε** s_ −1. 

**==> picture [167 x 25] intentionally omitted <==**

One forward homogenization and one backward dehomogenization constitute a single iteration of Newton’s method, processed as Algorithms 6 and 7. Once convergence is achieved, the computation advances to the next loading step. 

Decoding material networks • 801 

**Algorithm 6** DMN Online Prediction 

- 1: model ← read( _model_ ) 

- 2: loading_step ← List() 

3: **function** predict(model, loading_step) 4: **for** _�εout_ in loading_step **do** 5: **for** each leaf node in model **do** 6: node.material_law ← phase1 **or** phase2 7: **end for** 8: **while** bottom node not converged **do** 9: _�_ _**σ** , D, δε_ ← homogenized() 10: Newton_Method( _�σ, D, δε_ ) 11: _�ε_ ← _D�σ_ + _δε ▷_ Eq. (32) 12: _�σ_ ← _D[�σ]_ [direction[−] _[�ε][out]_ ] _▷_ Eq. (33) 13: dehomogenized() _▷_ Alg. 7 14: check convergence 15: **end while** 16: **end for** 

- 17: **end function** 

## **Algorithm 7** DMN Downscale 

1: **function** dehomogenized(node) 2: **if** node is not leaf **then** 3: _C_ 1 ← node.left.C 4: _C_ 2 ← node.right.C 5: _s_ 1 ← strain_localization( _C_ 1 _, C_ 2 _, f_ 1 _, f_ 2) 6: _▷_ Eq. (34) 7: _s_ 2 ← strain_localization( _C_ 2 _, C_ 1 _, f_ 2 _, f_ 1) 8: _�ε_ ← undo_rotation( _�ε, α, β, γ_ ) 9: node.left.inc_strain ← _s_ 1 · _�ε_ 10: node.right.inc_strain ← _s_ 2 · _�ε_ 11: update bottom node material law 12: dehomogenized(node.left) _▷_ Recursive call 13: dehomogenized(node.right) 14: **end if** 

- 15: **end function** 

## _2.2.2 IMN online prediction_ 

Continuing on the structure of interaction mapping, the macroscopic strain is downscaled following: 

**==> picture [151 x 11] intentionally omitted <==**

where _**εi**_ is the local strain, _**ε**_ ¯ is the homogenized strain and _**U**_ is an unknown vector, which will be updated during the iterations. _**D**_ contains the information of weight _w_ and local interaction directions _Ni_ in each material interaction: 

**==> picture [150 x 11] intentionally omitted <==**

Function _**H**_ **(·)** can be found in Eq. (27). 

IMN involves a downscaling process, where the homogenized strain is de-homogenized into each network layer. The summation of residual stress _**r**_ at bottom layer is computed as 

**==> picture [160 x 16] intentionally omitted <==**

This residual stress summation _**r**_ is used as a convergence criterion. ∥ _**r**_ ∥∞ _< τ[abs]_ or ∥ _**r**_ ∥∞ _< τ[rel]_ ∥ _**r**_ 0∥∞ _,_ (43) 

_τ[abs]_ = 10[−][12] , _τ[rel]_ = 10[−][6] and _**r**_ 0 is the initial residual. If the conditions are not satisfied, the vector _**U**_ is updated with 

**==> picture [195 x 10] intentionally omitted <==**

where _**K**_ is the Jacobian matrix and can be estimated by 

**==> picture [173 x 15] intentionally omitted <==**

C _i_ is the stiffness matrix at each material node. Take elastic and elastoplastic materials as an example(elastic and elastoplastic return mapping process can be found in [32]). Once the residual reaches convergence, we compute homogenized stress _**σ**_ ¯ and homogenized tangent C. 

**==> picture [174 x 109] intentionally omitted <==**

The overall online prediction algorithm can be found in Algorithms 8 and 9. 

## **Algorithm 8** IMN Online Prediction 

- 1: model ← read( _model_ ) 

- 2: loading_step ← List() 

3: **function** predict( _model, loading_  step_ ) 4: **for** _�εout_ in loading_step **do** 5: **for** each leaf node in model **do** 6: node.material law_ ← phase1 or phase2 7: **end for** 8: **while** bottom node not converged **do** 9: _�σ, D, δε_ ← downscale(¯ _**ε**_ ) 10: update bottom node 11: check convergence _▷_ Eq. (43) 12: **end while** 13: update _**U** ▷_ Eq. (44) 14: **end for** 15: **end function** 

## **Algorithm 9** IMN Downscale 

1: **function** downscale(¯ _**ε**_ ) 2: **for** each leaf node in model **do** ¯ 3: node.strain ← _**ε**_ + _D_ · _U ▷_ Eq. (40) 4: **end for** 5: **end function** 

802 • Journal of Mechanics, 2024, Vol. 40 

**==> picture [149 x 77] intentionally omitted <==**

Figure 3 Short fiber-reinforced composite used in offline training and online prediction used in training examples. 

**==> picture [177 x 59] intentionally omitted <==**

Figure 4 Capture the feature of the mesh with material network, establish a testing sample with the trained RVE, load the RVE and present stress-strain curve. 

## _2.2.3 Comparison of online prediction_ 

In an iterative approach, DMN involves two distinct stages: homogenization and de-homogenization. In each iteration, DMN first computes the microscopic stress and strain through homogenization and then de-homogenizes these values to verify them against the current loading step. On the other hand, IMN directly de-homogenizes the strain through a single downscaling operation. DMN could be more computationally intensive and timeconsuming, contributing to slower convergence. 

Another noteworthy difference is that IMN’s convergence process considers the overall force equilibrium of the material node system. By incorporating the global equilibrium condition, IMN ensures that the system remains balanced at the microscopic, which may benefit performance. 

## 3 RESULTS 

To investigate the loading behavior of a material with a microstructure, as illustrated in Fig. 3, the material network is trained on various samples of orthotropic elastic material properties. The learned knowledge from elastic training procedures in material networks is then extrapolated to nonlinear material mechanical behaviors. The workflow is outlined in Fig. 4. This micro-structure is trained on 4, 5, 6 layers with DMN, and 4, 5, 6, 8 layers in IMN. The performance of each material network will be closely compared. 

## 3.1 Offline training 

The tested mesh represents a short fiber-reinforced composite (SFC) material widely used in engineering applications due to its lightweight and sustainable properties. SFC materials are commonly evaluated using machine learning-based multiscale methods [33]. The mesh is assigned 500 samples with varying orthotropic elastic material properties. This dataset, which includes matrix, fiber and homogenized stiffness tangent, is sourced from [28] and is publicly available online. 

Offline training follows the algorithm detailed in Algorithms 1 and 3, and the error of samples in each training is defined 

**==> picture [228 x 161] intentionally omitted <==**

Figure 5 Offline training curves of DMN with depth 4, 5, 6 layers and IMN models with depth 4, 5, 6, 8 layers. 

Table 2. Offline training error. 

||Table 2. Ofine tra|ining error.||
|---|---|---|---|
||Model|DMN|IMN|
||_N_ = 4|5 _._ 13%|5 _._ 71%|
||_N_ = 5<br>_N_ = 6<br>_N_ = 8|4 _._ 22%<br>2 _._ 24%<br>-|3 _._ 43%<br>2 _._ 31%<br>0 _._ 88%|



Table 3. Offline training time (s). 

||Table 3. Ofine tra|ining time ( s) .||
|---|---|---|---|
||Model|DMN|IMN|
||_N_ = 4|23592|37|
||_N_ = 5|48544|84|
||_N_ = 6|103176|203|



as Eq. (19) for DMN and Eq. (31) for IMN. Figure 5 displays the average training and validation error histories for material networks with varying depths. The best training error and time usage can be found in Tables 2 and 3, respectively. Accuracy improves with increasing network depth. Accuracy levels are similar under the same network depth, but training epochs vary notably. IMN converges within 200 epochs, whereas DMN requires 20,000 epochs to achieve convergence. IMN’s error decreases sharply after a few epochs, in contrast to the more gradual reduction observed with DMN. Additionally, DMN exhibits slight over-fitting in the middle epochs. 

In the training framework, the volume fraction represents the proportion of the material occupied by each phase, making its accuracy a target of the performance of a material network. Figure 6 illustrates the variation in volume fraction over time. The mesh contains 79.34% phase 1 material and 20.66% phase 2 material. DMN and IMN exhibit distinct learning curves. DMN begins at 50%, experiences an overshoot, and gradually converges to the target. The deepest model of DMN has the least overshoot and converges earlier than the other DMN models. In contrast, IMN starts at 100% and efficiently reaches the target volume fraction. Table 4 lists the error between the volume fraction at the last epoch and the target volume fraction. The error of DMN models fluctuates with model depth, while the error of IMN models decreases as the depth increases. 

Decoding material networks • 803 

**==> picture [228 x 185] intentionally omitted <==**

Figure 6 Volume fraction of phase 1 variation along training of all models. 

Table 4. Volume fraction error. 

|Table 4. Volume fr|action error.||
|---|---|---|
|Model|DMN|IMN|
|_N_ = 4|1 _._ 00%|1 _._ 82%|
|_N_ = 5|2 _._ 24%|1 _._ 26%|
|_N_ = 6|0 _._ 09%|0 _._ 69%|
|_N_ = 8|-|0 _._ 66%|



Table 5. Material property. 

|Table 5. Material property.|||
|---|---|---|
|Phase|Elastic|Elastoplastic|
|Volume fraction|20 _._ 66%|79 _._ 34%|
|Elastic modulus ( MPa)|500|100|
|Tangent modulus ( MPa)|-|5|
|Poisson’s ratio|0.19|0.3|
|Yield stress ( MPa)|-|0.1|
|Beta|-|0|



**==> picture [228 x 181] intentionally omitted <==**

Figure 7 Tensile loading applied along the _x_ -axis, with strain increased to 1%. Stress–strain curve of _σ_ 1 and _ε_ 1 _._ 

**==> picture [228 x 181] intentionally omitted <==**

Figure 8 Tensile loading applied along the _y_ -axis, with strain increased to 1%. Stress–strain curve of _σ_ 2 and _ε_ 2 _._ 

## 3.2 Online prediction 

A nonlinear elastoplastic RVE is considered for testing the material networks’ nonlinear prediction capability. In the RVE, phase 1 material is elastoplastic with an isotropic von Mises yield surface and piece-wise linear hardening law, and phase 2 is isotropic elastic, with a larger elastic modulus. Detailed material properties are in Table 5. 

Three loading conditions are applied to the structure: tension, compression and load-unloading, all uniaxial. Figures 7 and 8 show the results of tensile loading in the _x_ and _y_ directions, respectively. Given the low training error achieved with N = 8 IMN model layers, it is considered the best-fitting curve (Typically, a DNS loading path can be calculated using finite element software. However, given the material network’s convergence, the best-performing model is the ground truth.). The material networks demonstrate strong performance in the elastic region and capture the yielding behavior at the yield point. 

The fibers in the mesh are ellipsoidal, with their major axes aligned in the _x_ direction, and the structure’s length in the _x_ direction is twice that of the other directions. As the figures reflect, 

these characteristics result in different stiffness during the loading tests. The stress in Fig. 7 is higher than that in Fig. 8 due to the anisotropic nature of the SFC microstructure. A similar result can be seen in tensile loading, as shown in Figs 9 and 10. The alignment of the short fibers causes a difference in the loading slope between the _x_ and _y_ directions. The material networks are also able to capture elastoplastic behavior under compressive loading, so as the anisotropic mechanical feature of SFC microstructure. 

A more complex loading test is applied, where the RVE is loaded beyond the plastic region, unloaded to zero strain and reloaded. The Bauschinger effect is evident in Figs 11 and 12, further demonstrating the predictive capability of both material networks. 

Nevertheless, slight differences can still be observed between the loading curves. In general, as the number of layers increases, the error decreases. The online prediction time and total iterations for each loading test are shown in Table 6. IMN consistently has lower time consumption in all six loading cases than DMN for the same number of layers. IMN also requires fewer 

804 • Journal of Mechanics, 2024, Vol. 40 

**==> picture [228 x 179] intentionally omitted <==**

Figure 9 Compressive loading applied along the _x_ -axis, with strain increased to 1%. Stress–strain curve of _σ_ 1 and _ε_ 1 _._ 

**==> picture [228 x 179] intentionally omitted <==**

Figure 10 Compressive loading applied along the _y_ -axis, with strain increased to 1%. Stress–strain curve of _σ_ 2 and _ε_ 2. 

**==> picture [228 x 179] intentionally omitted <==**

Figure 11 Loading applied along the _x_ -axis to 0.2% strain, followed by unloading and reloading to 1% strain. Stress–strain curve of _σ_ 1 and _ε_ 1. 

**==> picture [228 x 179] intentionally omitted <==**

Figure 12 Loading applied along the _y_ -axis to 0.2% strain, followed by unloading and reloading to 1% strain. Stress–strain curve of _σ_ 2 and _ε_ 2. 

Table 6. Online prediction time and total iterations. 

||Table 6. Online prediction ti|me and total iteratio|ns.|
|---|---|---|---|
||Model|DMN|IMN|
||_N_ = 4 tensile_x|61 s ( Iter = 359)|8 s ( Iter = 295)|
||_N_ = 5 tensile_x|119 s ( Iter = 342)|23 s ( Iter = 295)|
||_N_ = 6 tensile_x|290 s ( Iter = 434)|33 s ( Iter = 297)|
||_N_ = 8 tensile_y|-|223 s ( Iter = 296)|
||_N_ = 4 tensile_y|57 s ( Iter = 334)|8 s ( Iter = 296)|
||_N_ = 5 tensile_y|128 s ( Iter = 369)|16 s ( Iter = 297)|
||_N_ = 6 tensile_y|342 s ( Iter = 506)|34 s ( Iter = 296)|
||_N_ = 8 tensile_y|-|217 s ( Iter = 295)|
||_N_ = 4 compression_x|61 s ( Iter = 359)|8 s ( Iter = 295)|
||_N_ = 5 compression_x|119 s ( Iter = 342)|23 s ( Iter = 295)|
||_N_ = 6 compression_x|290 s ( Iter = 434)|33 s ( Iter = 297)|
||_N_ = 8 compression_x|-|217 s ( Iter = 295)|
||_N_ = 4 compression_y|70 s ( Iter = 331)|8 s ( Iter = 296)|
||_N_ = 5 compression_y<br>_N_ = 6 compression_y|172 s ( Iter = 364)<br>466 s ( Iter = 504)|18 s ( Iter = 297)<br>36 s ( Iter = 296)|
||_N_ = 8 compression_y|-|253 s ( Iter = 295)|
||_N_ = 4 loading-unloading_x|85 s ( Iter = 485)|11 s ( Iter = 387)|
||_N_ = 5 loading-unloading_x|119 s ( Iter = 472)|21 s ( Iter = 386)|
||_N_ = 6 loading-unloading_x|479 s ( Iter = 591)|47 s ( Iter = 387)|
||_N_ = 8 loading-unloading_x|-|300 s ( Iter = 386)|
||_N_ = 4 loading-unloading_y|78 s ( Iter = 451)|11 s ( Iter = 387)|
||_N_ = 5 loading-unloading_y|216 s ( Iter = 530)|23 s ( Iter = 388)|
||_N_ = 6 loading-unloading_y|502 s ( Iter = 702)|45 s ( Iter = 385)|
||_N_ = 8 loading-unloading_y|-|279 s ( Iter = 386)|



total iterations. IMN’s total iteration numbers remain nearly constant across all layers for the same loading case, whereas DMN requires more iterations as the network depth increases. The mean square error for each loading test compared to the ground truth is presented in Table 7. In summary, both DMN and IMN are effective at learning the critical features of a microstructure and extrapolating to unknown loading steps. However, IMN demonstrates superior performance in both offline training and online prediction. The potential reasons for this will be discussed in the following section. 

Decoding material networks • 805 

Table 7. Online prediction accuracy (MSE) 

|Table 7. Online prediction accu|racy ( MSE)||
|---|---|---|
|Model<br>_N_ = 4 tensile_x<br>_N_ = 5 tensile_x<br>_N_ = 6 tensile_x<br>_N_ = 4 tensile_y<br>_N_ = 5 tensile_y<br>_N_ = 6 tensile_y|DMN<br>1 _._ 40 ×10−4<br>1 _._ 28 ×10−4<br>2 _._ 95 ×10−4<br>3 _._ 75 ×10−4<br>0 _._ 87 ×10−4<br>1 _._ 67 ×10−4|IMN<br>1 _._ 06 ×10−4<br>1 _._ 16 ×10−4<br>0 _._ 22 ×10−4<br>3 _._ 62 ×10−4<br>2 _._ 13 ×10−4<br>0 _._ 20 ×10−4|
|_N_ = 4 compression_x<br>_N_ = 5 compression_x<br>_N_ = 6 compression_x|1 _._ 45 ×10−4<br>1 _._ 49 ×10−4<br>3 _._ 20 ×10−4|1 _._ 05 ×10−4<br>1 _._ 16 ×10−4<br>0 _._ 22 ×10−4|
|_N_ = 4 compression_y|4 _._ 10 ×10−4|3 _._ 62 ×10−4|
|_N_ = 5 compression_y|0 _._ 74 ×10−4|2 _._ 13 ×10−4|
|_N_ = 6 compression_y|1 _._ 86 ×10−4|0 _._ 20 ×10−4|
|_N_ = 4 loading–unloading_x|1 _._ 10 ×10−4|0 _._ 76 ×10−4|
|_N_ = 5 loading–unloading_x|0 _._ 89 ×10−4|0 _._ 94 ×10−4|
|_N_ = 6 loading–unloading_x|0 _._ 11 ×10−4|0 _._ 11 ×10−4|
|_N_ = 4 loading–unloading_y<br>_N_ = 5 loading–unloading_y<br>_N_ = 6 loading–unloading_y|2 _._ 47 ×10−4<br>0 _._ 74 ×10−4<br>0 _._ 12 ×10−4|2 _._ 47 ×10−4<br>1 _._ 54 ×10−4<br>0 _._ 16 ×10−4|



## 4 DISCUSSION 

Several crucial technologies implemented by the revisited material network, IMN, make it a more efficient model than DMN. Our discussion focuses on the differences between the two models regarding offline training and online prediction. 

## 4.1 Offline training discussion 

Although the number of training epochs required for DMN is 100 times greater than that of IMN, the overall time difference between the two models exceeds this factor, proving that every epoch in IMN is faster than in DMN. As highlighted in Section 2.1.3, DMN has more training parameters than IMN. In addition, fitting the angles in DMN’s building blocks is more complicated than the angles in IMN. Specifically, in DMN, the homogenized function between the rotation equation Eq. (12) involves both addition and subtraction operations alongside rotation matrices _**R**_ , derived from trigonometric functions (cosine and sine) based on input angles. In contrast, IMN has a simpler process. The angle-fitting term in IMN involves matrix multiplication and decoupled with other terms. Values in _**H**_ **(** _**N**_ **)** (Eq. (27)) come from a smaller matrix _N_ . These differences in complexity affect the time costs of each model. The homogenization step in DMN is expected to take longer due to the additional operations and more complex calculations involved in the angle fitting. Furthermore, the backward propagation step in DMN is likely to be more time-consuming, as its parameters undergo more intricate computations compared to IMN. 

We selected 20,000 training epochs for DMN and 200 training epochs for IMN, at which point both models appeared to converge. One of the possible reasons for IMN’s rapid convergence is the use of an aggressive gradient descent algorithm outlined in Algorithm 5. According to this algorithm, if the current loss is larger than the previous loss, the learning rate is reduced by 20%. This adaptive learning rate adjustment allows IMN to 

minimize errors more efficiently. Interestingly, we experimented with other optimization methods, such as stochastic gradient descent (SGD) and resilient propagation (Rprop), but neither could train IMN as effectively. This suggests that IMN benefits from the more aggressive scheduling strategy, which quickly adjusts the learning rate in response to fluctuations in the loss. On the other hand, DMN employs SGD by adding a regularization term (Algorithm 2). This makes DMN more conservative in its approach to minimizing error, leading to a steadier but slower reduction in loss. The regularization term helps prevent overfitting by controlling the complexity of the model, but it also contributes to the more gradual slope of DMN’s learning curve. Assuming DMN uses a gradient descent algorithm with large steps, given the variation in volume fraction during the initial training stages, it is likely that DMN would struggle to reach a convergent state. 

## 4.2 Online prediction discussion 

As seen in Table 6, the time consumption and the number of iterations needed for online prediction are significantly higher in DMN than in IMN. This can be explained by the differences in their respective online prediction algorithms, Algorithms 6 and 8. In DMN, the calculation of residual strain involves both a homogenization and de-homogenization process, while IMN requires only one downscaling operation to decompose the strain. This difference means that each iteration in IMN is less computationally expensive than in DMN. 

Another factor that causes DMN to be inferior to IMN in online prediction is the impact of randomness in DMN models. Homogenization and de-homogenization are involved in increasing the number of computations and exacerbating the effects of randomness within the material network. This randomness can lead to fluctuations in stress and strain computations, requiring more iterations to reach convergence. While DMN with N= 6 layers may show lower offline training error, this does not necessarily translate to better performance during online prediction. Additionally, DMN’s performance can vary across different loading steps. In some cases, DMN might require up to 10 times more iterations to converge; in extreme cases, it may fail to converge altogether. In contrast, such issues are rarely observed in IMN models, which exhibit much more stable behavior during prediction. 

## 5 CONCLUSIONS 

This paper compares the theories and performance of the deep material network (DMN) and the IMN. We analyzed the differences in their frameworks, particularly focusing on the laminate building block used in DMN and the interaction-based building block employed by IMN during the training stage. Our findings indicate that IMN, by considering stress balance within the RVE, exhibits superior performance in capturing the mechanical features of an RVE. Regarding online prediction, IMN offers a simpler, streamlined process, enabling faster convergence and reducing the time required for online prediction. 

We also conducted an example by training both models on a short-fiber reinforced composite. IMN demonstrated impressive results in both accuracy and efficiency during training. Both 

806 • Journal of Mechanics, 2024, Vol. 40 

models effectively capture phase changes in elastoplastic behavior during loading tests. In addition, they successfully capture the anisotropic characteristics of the RVE, proving their ability to learn and represent the mechanical features embedded within the microstructure. 

When discussing the factors influencing model performance, we observe that DMN requires more training parameters and introduces greater computational complexity than IMN. Additionally, IMN is optimized for fast gradient descent algorithms, whereas DMN requires more conservative tuning processes. Furthermore, deeper IMN models exhibit better performance, a trend that is less apparent in DMN. 

In conclusion, both DMN and IMN have contributed to computational material modeling. However, IMN demonstrates better overall performance regarding computational efficiency and accuracy, making it a more practical solution for complex multiscale simulations. 

## ACKNOWLED GM ENTS 

This paper is dedicated to the memory of Prof. Chien-Ching Ma. Prof. Ma made important contributions to solid mechanics and was renowned for his unique insight and novelty in solving complex and real-world problems. Prof. Ma is a role model for us and an elder brother figure who has supported and guided us for many years. We all miss him very much! 

## FUNDING 

This work is supported by the National Science and Technology Council, Taiwan, under Grant 111-2221-E-002-054-MY3. We are grateful for the computational resources and support from the NTUCE-NCREE Joint Artificial Intelligence Research Center and the National Center of High-performance Computing (NCHC). 

## REFERENCES 

1. Smit RJM, Brekelmans WAM, Meijer HEH. Prediction of the mechanical behavior of nonlinear heterogeneous systems by multi-level finite element modeling. _Computer Methods in Applied Mechanics and Engineering_ 1998; **155** (1):181–192. https://www.sciencedirect. com/science/article/pii/S0045782597001394. 

2. Temizer I, Wriggers P. An adaptive multiscale resolution strategy for the finite deformation analysis of microheterogeneous structures. _Computer Methods in Applied Mechanics and Engineering_ 2011; **37** (37):2639–2661. Special Issue on Modeling Error Estimation and Adaptive Modeling. https://www.sciencedirect.com/ science/article/pii/S0045782510001805. 

3. Feyel F, Chaboche JL. FE2 multiscale approach for modelling the elastoviscoplastic behaviour of long fibre SiC/Ti composite materials. _Computer Methods in Applied Mechanics and Engineering_ 2000; **183** (3):309–330. https://www.sciencedirect.com/ science/article/pii/S0045782599002248. 

4. Belytschko T, Loehnert S, Song JH. Multiscale aggregating discontinuities: a method for circumventing loss of material stability. _International Journal for Numerical Methods in Engineering_ 2008; **73** (6):869– 894. 

5. Moulinec H, Suquet P. A numerical method for computing the overall response of nonlinear composites with complex microstructure. _Computer Methods in Applied Mechanics and Engineer-_ 

_ing_ 1998; **157** (1):69–94. https://www.sciencedirect.com/science/ article/pii/S0045782597002181. 

6. de Geus TWJ, Vondˇrejc J, Zeman J, Peerlings RHJ, Geers MGD. Finite strain FFT-based non-linear solvers made simple. _Computer Methods in Applied Mechanics and Engineering_ 2017; **318** :412–430. https://www.sciencedirect.com/science/ article/pii/S0045782516318709. 

7. Liu D, Yang H, Elkhodary K, Tang S, Liu WK, Guo X. Mechanistically informed data-driven modeling of cyclic plasticity via artificial neural networks. _Computer Methods in Applied Mechanics and Engineering_ 2022; **393** :114766. 

8. Liu H, Liu S, Liu Z, Mrad N, Milani AS. Data-driven approaches for characterization of delamination damage in composite materials. _IEEE Transactions on Industrial Electronics_ 2020; **68** (3):2532– 2542. 

9. Zhang A, Mohr D. Using neural networks to represent von Mises plasticity with isotropic hardening. _International Journal of Plasticity_ 2020; **132** :102732. 

10. Jang DP, Fazily P, Yoon JW. Machine learning-based constitutive model for J2-plasticity. _International Journal of Plasticity_ 2021; **138** :102919. 

11. Su TH, Huang SJ, Jean JG, Chen CS. Multiscale computational solid mechanics: data and machine learning. _Journal of Mechanics_ . 2022; **38** :568–585. https://doi.org/10.1093/jom/ufac037. 

12. Su TH, Jean JG, Chen CS. Model-free data-driven identification algorithm enhanced by local manifold learning. _Computational Mechanics_ 2023; **71** :637–655. 

13. Mozaffar M, Bostanabad R, Chen W, Ehmann K, Cao J, Bessa M. Deep learning predicts path-dependent plasticity. _Proceedings of the National Academy of Sciences_ 2019; **116** (52):26414–26420. 

14. Rao C, Liu Y. Three-dimensional convolutional neural network(3DCNN) for heterogeneous material homogenization. _Computational Materials Science_ 2020; **184** :109850. 

15. Vlassis NN, Ma R, Sun W. Geometric deep learning for computational mechanics Part I: anisotropic hyperelasticity. _Computer Methods in Applied Mechanics and Engineering_ 2020; **371** :113299. 

16. Jones R, Safta C, Frankel A. Deep learning and multi-level featurization of graph representations of microstructural data. _Computational Mechanics_ 2023; **72** (1):57–75. 

17. Chou YT, Chang WT, Jean JG, Chang KH, Huang YN, Chen CS. StructGNN: an efficient graph neural network framework for static structural analysis. _Computers & Structures_ 2024; **299** : 107385. 

18. Kuo PC, Chou YT, Li KY, Chang WT, Huang YN, Chen CS. GNNLSTM-based fusion model for structural dynamic responses prediction. _Engineering Structures_ 2024; **306** :117733. 

19. Liu Z, Wu C. Exploring the 3D architectures of deep material network in data-driven multiscale mechanics. _Journal of the Mechanics and Physics of Solids_ 2019; **127** :20–46. 

20. Liu Z, Wu C, Koishi M. A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. _Computer Methods in Applied Mechanics and Engineering_ 2019; **345** :1138–1168. 

21. Liu Z, Wu C, Koishi M. Transfer learning of deep material network for seamless structure–property predictions. _Computational Mechanics_ 2019; **64** (2):451–465. 

22. Liu Z. Deep material network with cohesive layers: multi-stage training and interfacial failure analysis. _Computer Methods in Applied Mechanics and Engineering_ 2020; **363** :112913. 

23. Dey AP, Welschinger F, Schneider M, Gajek S, Böhlke T. Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelastically-informed strategy. _Archive of Applied Mechanics_ 2022; **92** (9):2733–2755. 

24. Shin D, Alberdi R, Lebensohn RA, Dingreville R. A deep material network approach for predicting the thermomechanical response of composites. _Composites Part B: Engineering_ 2024; **272** :111177. 

25. Shin D, Alberdi R, Lebensohn RA, Dingreville R. Deep material network via a quilting strategy: visualization for explainability and 

Decoding material networks • 807 

recursive training for improved accuracy. _npj Computational Materials_ 2023; **9** (1):128. 

26. Jean JG, Su TH, Huang SJ, Wu CT, Chen CS. Graph-enhanced deep material network: multiscale materials modeling with microstructural informatics. _Computational Mechanics_ 2024;1432–0924. 

27. Gajek S, Schneider M, Böhlke T. On the micromechanics of deep material networks. _Journal of the Mechanics and Physics of Solids_ 2020; **142** :103984. https://www.sciencedirect.com/science/ article/pii/S0022509620302192. 

28. Noels L. Micromechanics-based material networks revisited from the interaction viewpoint; robust and efficient implementation for multi-phase composites. _European Journal of Mechanics-A/Solids_ 2022; **91** :104384. 

29. Noels L. Interaction-based material network: a general framework for(porous) microstructured materials. _Computer Methods in Applied Mechanics and Engineering_ 2022; **389** :114300. 

30. Glorot X, Bordes A, Bengio Y. Deep Sparse Rectifier Neural Networks. In: Gordon G, Dunson D Dudík M, (eds). 

   - _Proceedings of the Fourteenth International Conference on Artificial Intelligence and Statistics. vol. 15 of Proceedings of Machine Learning Research_ . Fort Lauderdale, FL, USA: PMLR; 2011. p. 315– 323. 

31. Paszke A, Gross S, Massa F, Lerer A, Bradbury J, Chanan G, Killeen T, Lin Z, Gimelshein N, Antiga L, Desmaison A. PyTorch: An Imperative Style, High-Performance Deep Learning Library. In: _Advances in Neural Information Processing Systems 32_ . Curran Associates, Inc.; 2019. p. 8024–8035. http://papers.neurips.cc/ paper/9015-pytorch-an-imperative-style-high-performance-deeplearning-library.pdf. 

32. Kim NH. _Introduction to nonlinear finite element analysis_ . New York, US: Springer Science & Business Media; 2014. 

33. Wei H, Wu CT, Hu W, Su TH, Oura H, Nishi M, Naito T, Chung S, Shen L. LS-DYNA machine learning–based multiscale method for nonlinear modeling of short fiber–reinforced composites. _Journal of Engineering Mechanics_ . 2023; **149** (3):04023003. http://dx.doi.org/ 10.1061/JENMDT.EMENG-6945. 

Received: 15 September 2024; Revised: 26 October 2024; Accepted: 28 October 2024 

© The Author(s) 2024. Published by Oxford University Press on behalf of Society of Theoretical and Applied Mechanics of the Republic of China, Taiwan. This is an Open Access article distributed under the terms of the Creative Commons Attribution License (https://creativecommons.org/licenses/by/4.0/), which permits unrestricted reuse, distribution, and reproduction in any medium, provided the original work is properly cited. 

