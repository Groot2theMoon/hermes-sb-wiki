---
title: "On the effectiveness of deep material networks for the multi-scale virtual characterization of short fiber-reinforced thermoplastics"
journal: "10.1007/s00419-024-02558-w"
authors: ["Argha Protim Dey"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: ca5b15e1d3ec033cad6a70fd0057af114168e4ca4135700ddc1a63704223bce9
conversion: pymupdf4llm
---

Archive of Applied Mechanics (2024) 94:1177–1202 https://doi.org/10.1007/s00419-024-02558-w 

~~**ORIGINAL**~~ 

**==> picture [29 x 29] intentionally omitted <==**

**Argha Protim Dey · Fabian Welschinger · Matti Schneider · Jonathan Köbler · Thomas Böhlke** 

## **On the effectiveness of deep material networks for the multi-scale virtual characterization of short fiber-reinforced thermoplastics under highly nonlinear load cases** 

Received: 25 September 2023 / Accepted: 23 January 2024 / Published online: 28 March 2024 © The Author(s) 2024 

**Abstract** A key challenge for the virtual characterization of components manufactured using short fiberreinforced thermoplastics (SFRTs) is the inherent anisotropy which stems from the manufacturing process. To address this, a multi-scale approach is necessary, leveraging deep material networks (DMNs) as a micromechanical surrogate, for a one-stop solution when simulating SFRTs under highly nonlinear long-term load cases like creep and fatigue. Therefore, we extend the a priori fiber orientation tensor interpolation for quasistatic loading (Liu et al. in Intelligent multi-scale simulation based on process-guided composite database. arXiv:2003.09491, 2020; Gajek et al. in Comput Methods Appl Mech Eng 384:113,952, 2021; Meyer et al. in Compos Part B Eng 110,380, 2022) using DMNs with a posteriori approach. We also use the trained DMN framework to simulate the stiffness degradation under fatigue loading with a linear fatigue-damage law for the matrix. We evaluate the effectiveness of the interpolation approach for a variety of load classes using a dedicated fully coupled plasticity and creep model for the polymer matrix. The proposed methodology is validated through comparison with composite experiments, revealing the limitations of the linear fatigue-damage law. Therefore, we introduce a new power-law fatigue-damage model for the matrix in the micro-scale, leveraging the quasi-model-free nature of the DMN, i.e., it models the microstructure independent of the material models attached to the constituents of the microstructure. The DMN framework is shown to effectively extend material models and inversely identify model parameters based on composite experiments for all possible orientation states and variety of material models. 

**Keywords** Fatigue · Multi-scale modeling · Deep material networks · Inverse parameter identification · Short-fiber composites 

A. P. Dey · F. Welschinger 

Robert Bosch GmbH, Corporate Sector Research and Advance Engineering, Renningen, Germany 

M. Schneider (B) Institute of Engineering Mathematics, University of Duisburg-Essen, Essen, Germany E-mail: matti.schneider@unidue.de 

J. Köbler 

Department of Flow and Material Simulation, Fraunhofer ITWM, Kaiserslautern, Germany 

T. Böhlke 

Institute of Engineering Mechanics, Karlsruhe Institute of Technology (KIT), Karlsruhe, Germany 

A. Dey et al. 

1178 

## **1 Introduction** 

## 1.1 State of the art 

In industrial lightweight applications, short-fiber-reinforced thermoplastic materials play a crucial role. Therefore, during the past few decades, there has been a lot of research on the experimental characterization and numerical prediction of their mechanical behavior. The geometry of the reinforcements, such as aspect ratio and orientation [4,5], has an impact on the polymer material’s complex overall response. This is also affected by external factors such as temperature [6] and humidity [7]. In general, the composite material inherits distinct anisotropic behavior at every material point of the macro-scale component because the local fiber orientations rely on the injection molding process. The experimental as well as the simulative characterization of short fiber-reinforced thermoplastics (SFRTs) is time-consuming because of their intrinsic anisotropy, especially for inelastic long-term load case like fatigue and creep. 

In order to simplify the characterization workflow, an effective multi-scale method based on the idea of homogenization is chosen by splitting the problem into micro- and macro-scales [8,9]. The constitutive models for each phase of the composite (in our case, the polymer matrix and the glass fibers) and the geometric representation of the microstructure are the two key components of the micro-scale problem. The micro-scale problem that needs to be solved changes at different locations of the composite part as the microstructure varies throughout the component, for example, due to changing volume fraction or fiber orientation. Therefore, the need for a fast and accurate method for solving the micromechanical problem over different varying spatial microstructures emerges naturally. Computational homogenization methods operate on a particular spatially resolved microstructure and determine the macroscopic properties in a direct manner, alleviating the restrictive geometric assumptions of mean field or analytical homogenization approaches [10–13] The combination of Fast Fourier Transform (FFT) approaches [14–17] and model-order reduction (MOR) frameworks [18–20] yields promising results. However, the MOR-based approach is restricted to the models in the micro-scale that it is trained on. Moreover, the selection of a proper quadrature is critical for the MOR framework since it has a significant influence on the computational performance [21]. 

Data-driven approaches offer an appealing method for solving the micromechanical problem on unit cells and directly approximating effective characteristics. Since they can operate on a multidimensional region of interest, artificial neural networks (ANNs) are particularly useful for such techniques. However, training the ANNs is a data and time-intensive endeavor. Several inelastic material laws such as plasticity [22–24], damage [25], creep [26] and fatigue [27] were modeled using ANNs. However, outside of the training domain, the predicted accuracy of such data-driven systems seems to be low. Moreover, inherent physical conditions such as monotonicity and thermodynamic consistency are often not accounted for. Nevertheless, physics-informed neural networks (PINNs) were proposed as a remedy [28]. For PINNs, an artificial neural network approximates the solution field of a PDE, typically by enforcing the PDE to be satisfied at specific collocation points via penalization. Applied to micromechanics, PINNs run into problems as the solution fields are typically (weakly) discontinuous, which, together with the sheer complexity of microstructured materials used in industry, limit the efficiency of such networks. Several alternative strategies involving varying neural network topologies like recurrent neural networks (RNNs) and convolutional neural networks (CNNs) emerged for modeling the multiscale inelastic behavior. Wu et al. [29] used an RNN-based surrogate model in an FE[2] setting for modeling the elasto-plastic response in heterogeneous materials. A similar approach was adopted by Ghavamian et al. [30], where an RNN models the history-dependent micro-level response. Tandale et al. [31] used both CNNs and RNNs for modeling history-dependent behavior to speed-up nonlinear simulations for predicting structural deformation. 

Liu et al. [32,33] proposed a framework for a surrogate model of micromechanical computations known as deep material networks. Instead of attempting to learn the solutions to the underlying PDE with heterogeneous coefficients, DMNs attempt to learn the material’s microstructure, i.e., they seek a simplified effective model of the geometrical interactions characteristic for the microstructure. Once a simplified surrogate model of the microstructure is obtained, various inelastic material laws can be inserted into the surrogate microstructure model to compute the effective material response. The decoupling of the material law from the microstructural arrangement enables the DMNs to effectively model the spatially varying microstructure for a variety of different constitutive laws. Gajek et al. [2,34], in later works, proposed direct DMNs which have lesser fitting parameters compared to the original DMNs of Liu and coworkers. The inheritance of the thermodynamic consistency of the DMNs from the constitutive laws of the constituents was demonstrated by Gajek et al. [34]. Nguyen et al. [35] proposed an interaction-based deep material network for modeling porous microstructures 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1179 

using a nonlinear training strategy. Dey et al. [36] used the DMNs to model long-term creep deformation using an early-stopping approach and further used it for the inverse characterization of a coupled plasticitycreep model [37]. DMNs were also employed to estimate the uncertainties in the sheet molding compound manufacturing process [3] and for fully coupled thermomechanical two-scale simulations [38]. Liu et al. [1] used a transfer learning approach to model microstructures having varying fiber orientation tensors (FOTs). The versatility of the DMNs was leveraged by Gajek et al. [34] in a FE-DMN framework for simulation of an injection molded component having a spatially varying microstructure under elasto-plastic loading by using a priori interpolation, i.e., the parameters of the identified DMN are a function of the fiber orientation state in the online phase. However, such approaches seem limited for the harsh conditions of long-term loading scenarios such as creep and fatigue since the proposed theory [34] suggests that engineering accuracy may be lost if the constitutive laws are highly nonlinear, as shown in Dey et al. [36]. 

We are interested in characterizing the stiffness degradation before failure under high-cycle fatigue for short fiber-reinforced thermoplastics (SFRTs). The fatigue behavior of thermoplastic materials differs from that of metallic materials, which is widely researched. In contrast to metals, thermoplastic materials exhibit a significant stiffness loss prior to failure under fatigue loading [39,40]. This stiffness drop is further influenced by fiber orientation and stress amplitude. Fatigue modeling techniques for polymer composites include phenomenological macro-scale damage models which calibrate damage growth on the basis of macroscopic observable features, requiring time and cost intensive experimental studies [41–43]. Another method, using physics-based progressive damage models, specifically takes into account microstructural fatigue effects such as matrix degradation, fiber fracture, and matrix-fiber debonding. The macroscopic composite response is a product of homogenization [44] provided localizing effects such as fracture due to damage are accounted for. A multi-scale fatigue-damage model was introduced by Köbler et al. [9] for short-fiber-reinforced thermoplastics based on a modified classical phase-field fracture ansatz [45]. The computation at the micro-scale is performed using fiber orientation interpolation and a full-field/MOR based strategy [46]. Recently, Magino et al. [47] introduced a fatigue-damage model based on the compliance tensor [48] in order to exploit the stability of the second phase in the fatigue-damage evolution. In fact, the intrinsic convexity of these classes of models aims to reduce the computational cost related with gradient extension-based damage models [49]. Although the chosen fatigue-damage model leads to an efficient model-order reduction, the MOR strategy put forward in Magino et al. [47] is limited to this particular class of material models. Further works have also used similar models for upscaling fatigue-damage models [50] and accounting for the viscous effects [51] under fatigue loading of SFRTs. 

## 1.2 Contribution 

In this work, we use an industrially relevant semi-crystalline thermoplastic polybutylene terephthalate (PBT), reinforced with 30% by weight (17.8% by volume) E-glass fibers to characterize simultaneously the stiffness degradation under high-cycle fatigue and the material response under quasi-static and creep loadings. As a starting point, we build upon the work of Magino et al. [47] wherein a convex, rate-independent damage model based on the work of Görthofer et al. [48] was formulated in the logarithmic cycle space for the PBT matrix at the micro-scale. The constitutive model is concisely described in Sect. 2. However, with a view to upscale the model to the macro-scale, we integrate the model in the direct DMN framework [34] which offers us a reliable and reasonably accurate surrogate model to solve the micromechanics. DMNs have already been used to simulate long-term load cases like creep [36]. The intrinsic convexity and the non-localized character of the fatigue-damage model enables a direct integration into the DMN framework. The DMN methodology is discussed briefly in Sect. 2. However, one of the drawbacks of the DMN is that it is restricted to a specific microstructural arrangement. To account for the spatially varying microstructure, an interpolation over the fiber orientation tensor is necessary. However, previous a priori approaches [1–3] for the FOT interpolation appear prohibitive for the harsh conditions of long-term loading. Furthermore, the representation of highly nonlinear creep using DMNs require an additional inelastic input during training [36]. Therefore, aiming at a holistic approach for the simulation of quasi-static as well as long-term loading, we formulate an a posteriori approach where multiple DMNs are trained and the fiber orientation interpolation concept proposed by Köbler et al. [46] is used, see Sect. 2. A brief outline of a coupled plasticity-creep model incorporated in the DMN framework for further validation is also given in Sect. 2. 

We outline the results of the fiber orientation interpolation using the DMN framework in Sect. 3 not only for the fatigue-damage model introduced in Magino et al. [47] but also for the coupled plasticity-creep 

A. Dey et al. 

1180 

model introduced in Dey et al. [37]. We assess the predictive capabilities of the interpolation procedure by comparing the DMN-based interpolation with full-field FFT simulations. Furthermore, the relative error and the computation time of the DMN-based upscaling is also compared with the MOR-based upscaling. 

Finally,inSect. 4,weleveragethepoweroftheDMNstoinverselycharacterize[37]thestiffnessdegradation under high-cycle fatigue using macro-scale experiments performed on the composite. Since the DMNs model thespatialgeometryofthemicrostructure,anymaterialmodelmaybeusedfortheconstituentsofthecomposite. This contrasts with the full-field FFT micro-scale and MOR macro-scale approach adopted in Magino et al. [47, 50], where the material model for the matrix is fixed in the micro-scale and cannot be further modified based on the results of the FOT-interpolated macro-scale. We exploit this _model-free_ nature of the DMN to modify the existing fatigue-damage model [47]. We extend the linear damage evolution with the help of a nonlinear power-law term. Finally, we plug this model into the DMN-based interpolation concept for the inverse characterization [37] of the matrix material using a 9-layer macroscopic sample and compare them to experimental results. 

## **2** 

## 2.1 Models for matrix 

## _2.1.1 Fatigue-damage model_ 

The fatigue-damage model proposed in Magino et al. [47] for the stiffness degradation at small strains is formulated in the generalized standard material (GSM) framework [52]. GSMs are preserved under a scale transition in the context of multi-scale modeling, e.g., in the case of DMNs [2]. The model is formulated in logarithmic cycle space denoted by a continuous variable _N_[¯] ≥ 0, as a replacement of the commonly used time scale. The rescaling using _N_[¯] = log10 _N_ , where _N_ represents the current cycle, allows us to perform efficient fatigue computations using large steps _�N_[¯] in the logarithmic cycle space. 

The free energy density of the model _ψ(_ _**ε** , d)_ [47] is defined, with the help of the macroscopic strain tensor _**ε**_ , the initial fourth-order stiffness tensor C and a scalar damage variable _d_ , which is an internal variable, as 

**==> picture [286 x 24] intentionally omitted <==**

where _d_ ≥ 0. The Cauchy stress _**σ**_ is computed as 

**==> picture [279 x 24] intentionally omitted <==**

The dissipation potential is defined in the GSM framework by 

**==> picture [262 x 22] intentionally omitted <==**

where _α_ is a positive constant determining the speed of damage evolution and _d_[′] = d _d/_ d _N_[¯] . Finally, the evolution of the internal variable _d_ , in an explicit form, is defined as 

**==> picture [277 x 21] intentionally omitted <==**

where the damage variable _d_ develops linearly in the logarithmic cycle space _N_[¯] . The evolution Eq. (2.4) is discretized with an implicit Euler method in the logarithmic cycle space. The parameters of the fatigue-damage model are sourced from Magino et al. [47, § 2.3], identified using experiments performed with PBT matrix and the reinforced composite. The parameters are given in Table 1. 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1181 

**Table 1** Material parameters under fatigue loading—matrix parameters identified from experiments 

|Matrix [47, §|2.3]|Elastic|_E_|=|2690 MPa|_ν_ =0_._4|
|---|---|---|---|---|---|---|
|||Damage|_α_|=|0_._015 1_/_MPa||
|Fibers [53]||Elastic|_E_|=|72000 MPa|_ν_ =0_._22|



**Table 2** Material parameters for coupled plasticity-creep model—matrix parameters inversely identified from composite experiments 

|Matrix [37]|Elastic|_E_ =2475_._0 MPa|_ν_ =0_._4|||
|---|---|---|---|---|---|
||Plastic|_h_ =4_._0 MPa|_ω_=399_._2|_y_0 =24_._9 MPa|_y_∞=37_._9 MPa|
||Creep|_A_1 =0_._005 MPa−1|_nc_ =10_._15|_A_2 =2_._4×10−13 MPa−1|_C_ =2583_._45|
|||_k_ =0_._018|˙_ε_0 =1_._0 s−1|||



## _2.1.2 Coupled plasticity and creep model_ 

A material model for the modeling of both plasticity and creep at different time scales at small strains is formulated within the GSM framework, see Dey et al. [37, § 2.3]. The strain tensor _**ε**_ = ∇ _s_ _**u**_ is decomposed into an elastic, plastic and a creep part, 

**==> picture [262 x 10] intentionally omitted <==**

The plastic strain and the creep strain, along with an isotropic hardening variable _α_ ¯ are considered as the internal variables. The plastic and creep deformations are assumed to be volume preserving. The stress tensor of the isotropic material model emerges as 

**==> picture [303 x 11] intentionally omitted <==**

where _κ_ and _μ_ denote the compression and shear modulus, respectively. The evolution of the internal variables are explicitly reported 

**==> picture [404 x 68] intentionally omitted <==**

in terms of the yield function which is a combination of linear and a Voce-type hardening, 

**==> picture [350 x 19] intentionally omitted <==**

and the Macauley bracket 

**==> picture [264 x 10] intentionally omitted <==**

The material model is discretized in time using an implicit Euler approach. A conventional return-mapping algorithm based on a creep-plastic predictor and a plastic corrector step solves the discretized evolution equations [54]. The derivation of the material model [55,56] is discussed in detail in Dey et al. [37, § 2.3]. 

The material parameters of the model comprise the yield stress _y_ 0, a limiting stress _y_ ∞, a plastic hardening modulus _h_ , an exponential-hardening factor _ω_ , a viscosity _η,_ the creep constants _C_ and _k_ , creep prefactors _A_ 1 as well as _A_ 2, a reference creep rate _ε_ ˙0, and the creep exponent _nc_ . These material parameters were obtained inversely from fitting the model with composite experiments using fiber-reinforced PBT [37, § 4.3] and are reported in Table 2. 

Theglassfibersaremodeledaslinearelasticforthepurposeofupscalingwhenusedinconjunctionwithboth the fatigue-damage and plasticity-creep models. The material parameters are obtained from Doghri et al. [53] 1. 

A. Dey et al. 

1182 

## 2.2 Deep material networks 

## _2.2.1 Framework_ 

Liu et al. [32,33] first proposed DMNs as a data-driven surrogate model for full-field micro-scale simulations in concurrent multi-scale approaches. We build upon the direct DMN framework introduced in Gajek et al. [34] and report on a further extension of the framework by an early-stopping strategy proposed in Dey et al. [36] for modeling of long-term creep deformation. The DMN framework is divided in two distinct phases: offline training and online evaluation. We supplement the offline training phase using an inelastically informed training strategy as outlined in Dey et al. [36]. 

## _2.2.2 Offline training_ 

In computational micromechanics, the DMNs aim to replace computationally expensive full-field simulations. Direct deep material networks [34] use a hierarchical binary tree of rotation-free laminates as shown in Fig. 1a to represent a two-phase microstructure. In the linear elastic scenario, evaluating the effective stiffness of a two phase laminate with a normal _**n**_ , representing the direction of lamination, and the volume fraction of its constituents, indicated by _c_ 1 and _c_ 2, is computationally inexpensive. 

The binary tree of laminates aims to find an effective model of a complex microstructure _Y_ and enables the fast evaluation of the homogenization function _DMN Y_ . The two-phase laminates _Bk[i]_[, shown in Fig.][ 1][b, form] the building blocks of the DMN. A DMN with _K_ layers utilizing a running index _k_ = 1 _, . . . , K_ (from top to bottom layer _K_ ) is considered. The total number of nodes in the DMN is 2 _[K]_ − 1 where _i_ = 1 _, . . . ,_ 2 _[K]_ − 1. We evaluate the homogenized effective stiffness of the DMN using the stiffness tensors C1 and C2 of the input materials, 

**==> picture [271 x 12] intentionally omitted <==**

by traversing the binary tree from the bottom to the top and by computing the effective laminate stiffness at every node 

**==> picture [348 x 15] intentionally omitted <==**

The effective stiffness of a laminate can be analytically computed [57, § 9.5], independent of the anisotropy of the input stiffnesses and the geometrical parameters of the laminate. For more details about the homogenization at every building block please refer to Gajek et al. [34, § 3.2]. 

The input materials are assigned to the bottom layer of the DMN in an alternate fashion, 

**==> picture [276 x 25] intentionally omitted <==**

Liu et al. [32] proposed to parameterize the laminates’ volume fractions using weights _w_[2] _K[i]_ +[−] 1[1][and] _[ w]_[2] _K[i]_ +1[which] are attached to each laminate at the input layer _K_ + 1. All allowable weights are non-negative and add up to one. As we progress up the layers, these weights are additively propagated 

**==> picture [269 x 15] intentionally omitted <==**

The volume fractions of each building block can be retrieved by normalizing the weights 

**==> picture [308 x 31] intentionally omitted <==**

A direct DMN is uniquely parameterized by the lamination direction of each laminate _**n**_ and the weights attached to the input layer _w[i] K_ +1[, which can be organized into a parameter vector] _**[p]**_[. The vector] _**[p]**_[ of the DMN] can then be identified based on linear elastic material sampling and optimization in terms of a cost function which will be discussed in later sections. Once the DMN is identified, it may be used to compute nonlinear and inelastic constitutive behavior, as outlined in Sect. 2.2.3. 

However, the proposed theory [34] behind DMNs suggests the results tends to be inaccurate if the constitutive laws exhibit a significant degree of nonlinearity. This has been also been shown when predicting the 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1183 

**==> picture [596 x 181] intentionally omitted <==**

**Fig. 1** A two-phase deep material network as shown in Dey et al. [37] 

material response under long-term creep loading, see Dey et al. [36, § 3.2]. To circumvent this limitation, we follow an early-stopping strategy [58, § 7.8] and evaluate the inelastic material law every 50th or 100th iterate during training. Thus, the DMN parameters _**p**_ are identified every epoch with the help of the elastic loss, but the best state of the DMN is identified using the best inelastic error. This inelastically informed training methodology was further accelerated using a simple Norton-type creep law [59] in Dey et al. [36, § 3.3] to accurately predict the quasi-static and long-term creep response using DMNs. 

## _2.2.3 Online evaluation_ 

In the online phase, the inelastic response of the DMN is determined while keeping the parameter vector _**p**_ constant. We follow the approach introduced by Gajek et al. [34] to solve the online phase of the DMN, where a flattened representation of the DMN is used. In the online phase, our DMN resembles a traditional laminate with numerous phases. A nonlinear material behavior of GSM type is assigned to each phase of the flattened DMN. Each phase of the flattened DMN contains the internal variables of the nonlinear constitutive law. 

¯ For a prescribed macroscopic strain _**ε**_ = ∇ _s_ ¯ _**u**_ , a variational problem is set up for the online phase of the DMN, 

**==> picture [305 x 37] intentionally omitted <==**

where _k_ = 1 _, . . . , K_ and _i_ = 1 _, . . . ,_ 2 _[k]_[−][1] and defined in terms of the displacement jump vectors _**a**_ , strains in the bottom layer _**ε** K[I]_[, and the free energies] 

**==> picture [292 x 26] intentionally omitted <==**

The index _I_ = 1 _, . . . ,_ 2 _[K]_ represents the phases in the bottom layer of the deep material network. The strains in each phase of the bottom layer of the DMN can be evaluated based on the approach followed in Gajek et al. [2, Eq. (3.16)]. The displacement jump vectors are attached to each node of the DMN online phase and are explicitly reported in Dey et al. [37, § 3.3]. The stresses on the macroscopic level are computed from Eq. (2.15) via 

**==> picture [297 x 38] intentionally omitted <==**

A. Dey et al. 

1184 

where _**σ**[I] K_[is the stress in each individual phase of the bottom layer given as] 

**==> picture [255 x 16] intentionally omitted <==**

and can be obtained from the respective constitutive law attached to each phase, see Eqs. (2.2) and (2.6). 

The unknown jump vectors _**a**_ associated with each node of the DMN are solved via Newton’s method, where we use a backtracking algorithm to ensure a stable convergence behavior. Please refer to Dey et al. [37, § 3.3] for more details. A DMN with _K_ layers contains 2 _[K]_ − 1 nodes, and each Newton step updates all 3 · 2 _[K]_ − 1 components of the jump vector _**a**_ concurrently. To boost computational performance, we also use the last converged displacement jumps from the previous time step to initialize the displacement jumps _**a**_ at the start of the Newton iteration. This decrease in runtime is offset by an increase in memory demand to store the vector at the conclusion of each time step. In the case inelastic models are used, the internal variables attached to every phase of the bottom layer are stored. A DMN of depth _K_ with 2 _[K]_[−][1] laminates in the bottom layer consists of 

**==> picture [272 x 12] intentionally omitted <==**

internal variables, where _Z_ 1 and _Z_ 2 represent the number of internal variables for each phase. The internal variables (2.19) are updated after the convergence of Newton iteration. The online phase is implemented as a user-defined material subroutine (UMAT) in Fortran, which makes use of the LAPACK [60] libraries for an efficient computation of the linear algebra operations and can be easily integrated into commercial software, like Abaqus [61] or the commercial FFT solver FeelMath [62]. 

2.3 Fiber orientation interpolation 

Advani and Tucker [63] introduced the second-order fiber orientation tensor (FOT) 

**==> picture [283 x 24] intentionally omitted <==**

in terms of a fiber orientation distribution function _ρ_ , which defines the probability of finding fibers in a particular direction _**p**_ . The FOT carries a limited amount of information with only five independent degrees of freedom. Despite its restricted information richness, the efficient form of the FOT makes it a popular choice for commercial injection molding simulations. The second-order FOT can be extended to higher moments using closure approximations [64,65]. 

The FOT is a symmetric positive semidefinite tensor with unit trace. The eigenvalue decomposition of **A** 2 leads to 

**==> picture [287 x 12] intentionally omitted <==**

where _**Q**_ is an orthogonal matrix and with eigenvalues _λ_ 1 ≥ _λ_ 2 ≥ _λ_ 3 sorted in descending order. Therefore, up to a rotation, the fiber orientation tensor **A** 2, can be uniquely defined by two positive real numbers _λ_ 1 and _λ_ 2 satisfying 

**==> picture [305 x 22] intentionally omitted <==**

the two inequalities. These inequalities can be represented geometrically in the form of a planar triangle, see Fig. 2. We call this triangle the FOT triangle and use the CMYK color scheme proposed by Köbler et al. [46], see Fig. 2. 

The manufacturing of SFRT components using injection molding introduces a spatially varying microstructure throughout the component. Therefore, the total anisotropic nature of the composite must be considered when modeling the material in the micro-scale. DMNs offer us an effective surrogate to model the complete anisotropic picture at the micro-scale. However, the DMNs are intrinsically limited to a particular microstructural state and there emerges a natural need to model spatially varying microstructural states using DMNs. Liu et al. [1] used a transfer learning paradigm to train a single DMN progressively over various microstructure states to create a unified database that encompasses a range of geometric descriptors. On the other hand, Gajek et al. [2] used the FOT triangle in association with a DMN to jointly identify parameters of the DMN. 

1185 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

**==> picture [533 x 107] intentionally omitted <==**

**Fig. 2** Fiber orientation triangle depicting the two highest eigenvalues of the fiber orientation tensor. The three extreme cases, i.e., the vertices of the triangle, **(a)** unidirectional, **(b)** isotropic and **(c)** planar isotropic fiber orientation are shown 

**==> picture [249 x 107] intentionally omitted <==**

**Fig. 3** A discretization of the fiber orientation triangle with 15 nodes 

This approach yields a single DMN surrogate model that covers all fiber orientations. Both the aforementioned approaches were performed for heterogeneous microstructure having elasto-plastic constituents. 

However, as part of this work we aim to introduce a multi-scale model simultaneously for the stiffness degradation under high-cycle fatigue with strong nonlinearity and deformation under creep loading for large time scales. Dey et al. [36] showed that identifying an accurate surrogate model for long-term creep loading requires additional inelastic inputs during the elastic offline training phase. Hence, identifying a single DMN surrogate model for all FOT states appears prohibitive for high cycle fatigue and long-term creep. Therefore, we use the idea proposed in Köbler et al. [46], where a fiber orientation interpolation is performed using effective stresses, with the stresses originating from individually trained DMNs. 

To this effect on the micro-scale, we first triangulate the FOT triangle using 15 fiber orientation nodes, resulting in 16 sub-triangles, see Fig. 3. Each triangulation node represents a microstructural state and is furnished with a microstructural image _Yi_ , where _i_ = 1 _, . . . ,_ 15 _,_ generated using the sequential addition and migration (SAM) algorithm [66] and the FOT computed using the _λ_ 1 and _λ_ 2 values of the particular node. Thereafter, we generate training and validation data for the DMNs at each node using elastic full-field FFTbased computational homogenization. These serve as the input for training the DMNs at every node. The trained DMN parameters _**p** i_ are stored in a database for use in the macro-scale computations. 

On the macro-scale, the inputs consist of the DMN parameters of the 15 trained DMNs at each node and the material models of the constituents of the composite. Each element is connected with the DMN parameters of the three nearest pretrained orientations based on its assigned orientation, see Köbler et al. [46]. Therefore, any fiber orientation state _�_ can be represented uniquely in terms of a convex combination 

**==> picture [280 x 9] intentionally omitted <==**

of the fiber orientation states _�_ 1 _, �_ 2 and _�_ 3 contained in the FOT triangle and a triple of positive numbers ( _s_ 1 _, s_ 2 _, s_ 3) which sum to unity. Thus, for a macroscopic strain _E_ the macroscopic stress _�_ is calculated 

**==> picture [279 x 31] intentionally omitted <==**

where _**σ**_ ¯ _i_ denotes the DMN online phase stress (2.17) calculated at each node of the containing triangle dependent on the DMN parameters _**p** i_ and the stresses _**σ** K[I]_[defined in Eq. (][2.18][), which emerge from the respective] material models. As a result, the stresses at the node are interpolated, and the nodal internal variables (2.19) 

1186 

A. Dey et al. 

**==> picture [596 x 270] intentionally omitted <==**

**Fig. 4** Multi-scale FOT interpolation framework using DMNs 

of the DMN develop independently and reside on the nodes _�_ 1 _, �_ 2 and _�_ 3. The entire FOT interpolation workflow has been summarized as an algorithm similar to Magino et al. [47, Fig. 6] in Fig. 4. An essential difference to the MOR-based workflow introduced in Magino et al. [47] is the decoupling of the macro-scale simulation from the material model of the constituents, leveraging the power of the DMN which serves as an efficient surrogate of only the geometric state. 

The FOT interpolation framework in the macro-scale is implemented as an Abaqus [61] UMAT following Köbler et al. [46] which calls upon the DMN online phase UMAT at every node of the triangle, which further integrates the UMAT for the constitutive laws of each constituent of the composite. The trained DMN parameters are stored as an XML file and integrated using the UEXTERNALDB routine of Abaqus [61]. 

## **3** 

## 3.1 Microstructural investigations 

The constitutive laws of the constituents (fiber and matrix) as well as the spatial arrangement of the fibers in the matrix material influence the micromechanical problem. As such, the overall response of the composite is dependent on the material’s representative microstructure. Several studies were conducted on the various important parameters of the microstructure (such as fiber length) and their influence on the material response in Dey et al. [37, § 4.1] for a polybutylene terephthalate (PBT) matrix, reinforced with 30% by weight E-glass fibers. The studies were conducted by comparing the experimental elastic response of the composite with the material response obtained using the FFT-based computational homogenization software FeelMath [62] with the help of virtual microstructures generated using the SAM [66] algorithm. For more details, refer to Dey et al. [37, § 4.1]. 

In this work, we use the same composite as used in Dey et al. [37] to characterize the matrix material under high-cycle fatigue. Since the geometric descriptors are not affected by the loading conditions, we use the best calibrated microstructural parameters from Dey et al. [37] for generating training and validation data for the DMNs as well as for full-field FFT simulations for validations. Therefore, we generated cubic unit cells with an edge length of 625 _μ_ m, which includes cylindrical fibers having a length of 285 _μ_ m and diameter of 10 _μ_ m separated by a minimum distance of 3 _μ_ m. Each microstructure is discretized using 512[3] voxels, further 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1187 

**Table 3** Relative error dependent on tolerance criterion using energy equivalence 

|Tolerance for residual|Unidirectional (%)|Isotropic (%)|Planar isotropic (%)|
|---|---|---|---|
|10−5|0.015|6.2e−5|9.9e−5|
|10−4|0.018|8.9e−4|1e−3|
|10−3|10.9|12|12.7|



**Table 4** Relative error dependent on tolerance criterion using strain equivalence 

|Tolerance for residual|Unidirectional (%)|Isotropic (%)|Planar isotropic (%)|
|---|---|---|---|
|10−5|0.03|1.3e−5|2e−4|
|10−4|0.02|1.7e−3|1.5e−3|
|10−3|12.1|12.8|13.5|



resampled by a factor of two to 256[3] voxels using the composite voxel approach, see [67–69]. This strategy serves to accelerate the FFT computations with high fidelity, see Dey et al. [36, § 3.1]. All the microstructures are generated using the second-order FOT along with the exact closure approximation [64,65] which serves as an input for the SAM [66] algorithm. The second-order FOT is calculated with the help of the eigenvalues _λ_ 1 and _λ_ 2 at each node of the triangle as shown in Fig. 3. It is also reported in Dey et al. [37] that a multi-layered microstructure over the thickness gives us better accuracy when compared to a single layer over the thickness. However, in this work, we circumvent the need to use a layered microstructure with the help of the FOT interpolation, where the layers are resolved in the macro-scale sample, see Sect. 4.1. 

## 3.2 

Aftertheidentificationofthegeometricdescriptors,weareinterestedinthegenerationoftrainingandvalidation data for the 15 DMNs populating the FOT triangle, see Fig. 3. This results in a large number of full-field FFT computations and thus reducing the runtime of the linear elastic full-field simulations is of paramount importance. We follow Dey et al. [36] and generate linear elastic training and validation data via the FFT-based computational homogenization software FeelMath [62] using the linear conjugate gradient method [70–72] and the staggered grid discretization [17,73]. A detailed discussion on the different gradient-based methods for FFT computations and the respective convergence criterion can be found in Schneider et al. [74]. 

The phase contrast of the constituents plays an important role in determining the runtime of the full-field simulations. However, for the DMNs, we sample over a range of phase contrasts, which is a pre-requisite for good training of the DMN [33]. In this work, we design several numerical experiments using an extremely high phase contrast of 10,000 to evaluate the fidelity and computation time for the extreme case. We primarily check the accuracy and runtime of full-field FFT simulations dependent on the strain equivalence-based and energy equivalence-based residuals and their respective tolerances. The errors are evaluated using the Frobenius norm in Mandel notation with the help of a high-fidelity FFT computation which incorporates the energy equivalence-based residual with a tolerance of 10[−][8] . In an automated process, all micromechanical computations were performed in parallel on a high performance computing cluster, where each full-field FFT computation uses 8 CPUs and 4 GB of memory per CPU. 

Weconsiderthethreeextremefiberorientationsseparately,i.e.,unidirectional,isotropicandplanarisotropic fiber orientation as depicted in Fig. 2, and vary the tolerance for both energy equivalence and strain equivalencebased residuals from 10[−][5] to 10[−][3] . The relative errors for all the three extreme fiber orientations compared to the respective high-fidelity solution are depicted in Tables 3 and 4 for the energy and strain equivalencebased residuals, respectively. The error increases as the tolerance increases for all microstructure realizations. However, the increase in error from a tolerance of 10[−][4] to 10[−][3] is rather large. The unidirectional orientation state has the highest errors. Moreover, the overall errors using the energy equivalence-based residual appears to be lower than the strain equivalence-based residual. This is consistent with the findings reported in Schneider et al. [75]. Therefore, for the linear elastic FFT computations we use the energy equivalence based residual with a tolerance of 10[−][4] which gives reasonable errors for all microstructure realizations with reduced runtime when compared to a tolerance of 10[−][5] . The computation times w.r.t. the tolerance for the extreme fiber orientation states are depicted in Fig. 5 which indicates that an increase in tolerance leads to a reduction in the 

A. Dey et al. 

1188 

**==> picture [596 x 201] intentionally omitted <==**

**Fig. 5** Computation times using different equivalence criteria and tolerances 

computation time. We observe that the energy equivalence-based residual with a tolerance of 10[−][4] reduces the computation time by a factor of two when compared to a tolerance of 10[−][5] , further justifying its use. 

## 3.3 Training the DMN database 

In this work, we follow the approach outlined in Dey et al. [37, § 4.2] for training each of the 15 DMNs attached to the 15 nodes of the FOT triangle (see Fig. 3) based on the direct DMN framework [34] outlined in Sect. 2.2. For each DMN, the tuples �C _[s]_ 1 _[,]_[ C] _[s]_ 2� were sampled using orthotropic elasticity tensors as outlined in Liu and Wu [33]. The effective elasticity tensor C[¯] _[s]_ FFT[, computed using the workflow outlined in Sect.][ 3.2][,] completes the triples �C _[s]_ 1 _[,]_[ C] _[s]_ 2 _[,]_[C][¯] _[s]_ FFT� used for training and validation. As a point of departure from previous works involving the direct DMN framework, we train each of the DMNs on 400 training data points and further use 100 validation data points. Even for this comparatively low number of data points per DMN, already, a total of 500 × 15 = 7500 linear elastic FFT computations have to be performed for generating training and validation data. 

A depth of seven was chosen for each DMN, i.e., each DMN consists of a binary tree of rotation-free laminates with seven levels. The increase in depth of the DMN increases the accuracy of the DMN in the online phase. However, the increase in accuracy is offset by the computation time in the online phase of the DMN. As the number of unknowns increases exponentially with the depth, the runtime increases exponentially with increase in depth, as well. Although the online phase computation of a shallower DMN is less time-consuming, a minimum depth of seven is required to evaluate highly nonlinear load cases with sufficient fidelity. 

The training proceeds to evaluate each of the DMN parameter sets _**p** i_ , where _i_ = 1 _, . . . ,_ 15 _,_ for the 15 microstructural realizations denoted by the 15 nodes in the FOT triangle, see Fig. 3, by minimizing the objective function, 

**==> picture [333 x 30] intentionally omitted <==**

and the batch size _n_ b = 40, where C[¯] _[s]_ DMN _[(]_ _**[ p]**[i][)]_[ is evaluated as in Gajek et al. [][34][] and] 

**==> picture [299 x 30] intentionally omitted <==**

The penalty term is defined as 

**==> picture [327 x 19] intentionally omitted <==**

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1189 

**Table 5** Identified material parameters for the Norton-type model (3.5) 

|Matrix|Elastic|_E_ =2475 MPa|_ν_ =0_._4|
|---|---|---|---|
|Creep|_An_ =0_._014 MPa−1|_nn_ =27_._0|˙_ε_0 =1_._0 s−1|



where _c_ 1 = 0 _._ 822 and _c_ 2 = 0 _._ 178 are the volume fractions of the respective phases and _**v** i_ are the vectors of unconstrained weights for each DMN as outlined in Dey et al. [36, Eq. (2.21)]. In this case, **b** 1 is a vector having ones at all odd indices and zero otherwise, and **b** 2 is a vector having ones at all even indices and zero otherwise. The penalty factor _λ_ is set to 100. The minimum of the objective function (3.1) is sought for training each DMN with a stochastic batch-gradient-descent approach based on automatic differentiation and a batch size of 40. The entire database generation was automated using Python, the DMN framework was implemented using PyTorch [76] and trained with the help of the AMSGrad method [77]. The learning rate was modulated using cosine annealing [78], 

**==> picture [334 x 22] intentionally omitted <==**

where _β_ and _m_ denote the learning rate and epoch, respectively. The maximum learning rate is slightly increased to _β_ max = 0 _._ 000725 to compensate for training on a sparse dataset, when compared to the maximum learning rate of 0.0007 in Dey et al. [37]. The minimum learning rate is set to _β_ min = 0. The parameter _M_ is set to 4000 and all the DMNs are trained up to 10000 epochs. 

Aiming for an extrapolation of the DMN online phase to long-term loading scenarios we augment the training approach with an inelastic input via an early-stopping procedure [36]. We follow the workflow laid down in Dey et al. [36] and use Hooke’s law combined with a Norton-type creep law [59] 

**==> picture [311 x 38] intentionally omitted <==**

with creep parameters _An_ and _nn_ , as a surrogate model to monitor the DMN performance every 50 epochs during training. For each microstructure realization, the full-field FFT computations using the Norton law and material parameters identified using the workflow specified in Dey et al. [36, § 3.3] and outlined in Table 5, are used as the ground truth. 

The DMN response is evaluated with the help of a single voxel microstructure by an FFT-based solver [62]. On the other hand, full-field simulations are performed using the microstructure realization attached to every node of the FOT triangle. In both cases, a uni-axial tensile stress of 60 MPa is applied, which is rampedup in 8 _._ 5 s and subsequently held constant for¯ 8 _._ 64 × 10[4] s in the three principal directions denoted by _σ_ ¯ _ii_ for _i_ = 1 _,_ 2 _,_ 3 _._ The creep strain component _εii_ in each loading direction is computed and the following error measure is introduced to evaluate the performance of the DMN w.r.t. the ground truth FFT computations 

**==> picture [339 x 41] intentionally omitted <==**

together the maximum errors 

**==> picture [311 x 15] intentionally omitted <==**

where _τ_ denotes the time steps. 

The best DMN state _**p** i_ for each microstructure realization is identified over the course of the training with the help of the best Norton error _e[n] ._ For a more detailed description of the training technique, we refer to Dey et al. [36, Alg. 1]. The best Norton error _e[n]_ for all the orientation states is shown in Fig. 6. We observe the overall maximum errors throughout the FOT triangle remains fairly consistent around 4%. The maximum value of the maximum Norton error is 6.9% at a node near the unidirectional fiber orientation state. We also report on the loss value and the generalization capacity of this specific node having the maximum value of Norton error, shown in Fig. 7. We observe a monotonic decrease of the loss for the first 100 epochs followed by oscillations, see Fig. 7a. 

A. Dey et al. 

1190 

**==> picture [288 x 117] intentionally omitted <==**

**Fig. 6** Maximum Norton error for a fiber orientation triangle with 15 nodes 

**==> picture [596 x 189] intentionally omitted <==**

**Fig. 7** Offline training results for node with highest maximum Norton error 

The generalization capabilities of the DMN in the linear elastic offline phase are assessed with the help of a mean error 

**==> picture [265 x 32] intentionally omitted <==**

where 

**==> picture [273 x 30] intentionally omitted <==**

and _Ns_ is the number of samples in the training or the validation set, respectively. We see that the trend of the loss function corresponds to the mean training and validation errors, see Fig. 7b. The simultaneous decrease in training and validation error during training is an indicator that there is no overfitting in the offline training phase. 

## 3.4 Validation of DMN database 

## _3.4.1 Fatigue-damage model_ 

Before deploying the DMN in a two-scale simulation, we focus on verifying the deep material network’s predicted stress response. Firstly, we use the fatigue-damage model and parameters described in Sect. 2.1.1 as the constitutive model for the matrix and a linear elastic model for the fibers to check the fidelity of the 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1191 

**==> picture [595 x 169] intentionally omitted <==**

**Fig. 8** Maximum and mean error for fiber orientation interpolation under high-cycle fatigue 

trained DMN database. We compare the composite response under high-cycle fatigue using the DMNs for all 15 microstructure realizations at each node over the FOT triangle, see Fig. 3. Furthermore, to assess the predictive capabilities of the database outside the training domain we generate microstructures at the centroids of all 16 sub-triangles, see Fig. 3. At these microstructure realizations, we interpolate the stress response from the nearby trained DMN states instead of directly computing it with the trained DMN as outlined in Sect. 2.3 and suggested by Köbler et al. [46]. However, this technique raises the effort by a factor of three, both in terms of computation time and memory use, because three DMN states must be examined for each macroscopic Gauss point. 

We use the microstructure realizations generated using the SAM algorithm [66] at each node and centroid to evaluate the full-field FFT response using FeelMath [62]. The DMN response is evaluated using one tetrahedron element in Abaqus [61] with the help of the DMN online phase UMAT at each node and the fiber interpolation UMAT at every centroid. We subject the composite to cyclic loading with a constant stress amplitude and a stress ratio of _R_ = 0, where 

**==> picture [247 x 21] intentionally omitted <==**

To account for the anisotropic response, we instantaneously ramp up to a constant stress of 100MPa till¯ _N_[¯] = 6, appliedevaluate the strainin 60 equidistant _ε_ ¯ _ii_ under high-cycle fatigue in each direction. Similar to the Norton error, we introduce aload steps for the three principal directions denoted by _σii_ where _i_ = 1 _,_ 2 _,_ 3 _._ We fatigue error to evaluate the performance of the trained DMN states and the FOT interpolation w.r.t. the FFT computations, 

**==> picture [315 x 41] intentionally omitted <==**

along with the maximum errors 

**==> picture [316 x 19] intentionally omitted <==**

In addition, we introduce a mean error 

**==> picture [281 x 26] intentionally omitted <==**

where _τ_ = [0 _, T_ ] denotes the time interval. The maximum (3.12) and mean (3.13) errors are evaluated at all centroids and nodes and are plotted in Fig. 8 over the FOT triangle. 

We observe that the maximum error and the mean errors over the complete FOT triangle lie below 4% and 3%, respectively. The errors observed at the nodes where the DMNs are trained are slightly lower compared to 

A. Dey et al. 

1192 

**==> picture [372 x 173] intentionally omitted <==**

**Fig. 9** Comparison of DMN and full-field results under high-cycle fatigue for node having the worst maximum error over the FOT triangle 

the interpolated centroids. This is in accordance with the MOR-based fiber orientation interpolation outlined in Magino et al. [47, § 4.3.4]. However, in our case the maximum error at the nodes are around 2% which is several magnitudes higher than the MOR-based system. This is to be expected since the DMN is a more general approach which only learns the spatial geometry in contrast to the MOR approach [47] where the nodes are trained on modes of the specific loading paths. Nevertheless, the maximum interpolated errors at the centroids of the triangle using the DMNs are slightly lower when compared to the maximum errors of 5% for the MOR-based system [47]. In this work, the maximum error of 3.14% over the entire FOT triangle is observed under extension in the 11-direction at a centroid having eigenvalues _λ_ 1 = 0 _._ 9 and _λ_ 2 = 0 _._ 07. The comparison of the DMN and full-field results for this specific load case is shown in Fig. 9. 

## _3.4.2 Coupled plasticity and creep model_ 

We additionally validate the performance of the DMN and the fiber orientation interpolation with the help of the plasticity and creep coupled law for the matrix material described in Sect. 2.1.2, along with the material parameters outlined in Table 2. The model can represent both plasticity and creep at different time scales. We start with the plasticity and introduce the maximum relative elasto-plastic error _e_ max _[p]_[[][36][, Eq. 3.9], following] Dey et al. [36]. The loading conditions and simulation workflows are the same as used in Dey et al. [36]. Furthermore, we introduce a mean error similar to the fatigue loading scenario, 

**==> picture [282 x 26] intentionally omitted <==**

where 

**==> picture [273 x 41] intentionally omitted <==**

The errors are plotted over the FOT triangle in Fig. 10. 

The maximum elasto-plastic error is observed to be 11.6% under uni-axial extension in 11-direction in the unidirectional microstructure realization, see Fig. 12a. The representation of the elasto-plastic response of the unidirectional microstructure realization, using the DMN, appears difficult and is also observed in Gajek et al. [2]. The overall maximum error remains fairly consistent over the FOT triangle. More fluctuations can be observed in the mean error with a maximum value below 5%, see Fig. 10b. 

The loading conditions for the validation of the creep response are similar to the ones introduced for the Norton error in Sect.in 8 _._ 5 s and subsequently held constant for 8 3.3. At every node, a uni-axial tensile stress of 60 MPa is applied, which is ramped up _._ 64 × 10[4] s in the three principal directions denoted by _σ_ ¯ _ii_ where _i_ = 1 _,_ 2 _,_ 3 _._ However, at nodes where _λ_ 1 has a value greater than 0.6, the uni-axial tensile stress is reduced to 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1193 

**==> picture [596 x 173] intentionally omitted <==**

**Fig. 10** Maximum and mean error for fiber orientation interpolation under elasto-plastic loading 

**==> picture [594 x 168] intentionally omitted <==**

**Fig. 11** Maximum and mean error for fiber orientation interpolation under creep loading 

**==> picture [596 x 209] intentionally omitted <==**

**Fig. 12** Comparison of DMN and full-field simulation for elasto-plasticity and creep for node having the worst maximum errors over the FOT triangle 

A. Dey et al. 

1194 

**==> picture [471 x 130] intentionally omitted <==**

**Fig. 13** Geometry and fiber orientation of the sample [51] 

30 MPa in the 22 and 33-directions. In the case of all centroids, a uni-axial tensile stress of 40 MPa is used in all directions. The maximum and mean error for computing the DMN and full-field response using the creepstrain component _ε_ ¯ _ii_ is introduced 

**==> picture [341 x 26] intentionally omitted <==**

respectively, where 

**==> picture [316 x 41] intentionally omitted <==**

The maximum and mean error for the FOT triangle under creep loading is shown in Fig. 11. The maximum errors do not show any major fluctuations with a maximum value of 8.5% in the 11-direction at a node near the isotropic fiber orientation state. The FFT and DMN responses for the maximum error are visualized in Fig. 12b. The overall maximum errors for creep appear to be higher than the errors reported in Dey et al. [36]. A probable cause is the use of fewer training data points in this work. However, the mean errors show very little fluctuations and are below 4%, see Fig. 11b. 

## 3.5 Computation time 

Finally, we discuss the computational cost of the deep material network-based fiber orientation interpolation and compare it to the MOR-based fiber orientation interpolation [47]. To this effect, we use an Abaqus [61] tetrahedron element simulation containing one Gauss point which we run on a single node having a single CPU. We apply a uni-axial load of 100 MPa for _N_[¯] = 6 in 60 equidistant load steps. The fiber orientation concept based on DMNs requires 27 ms for solving the material law at the Gauss point for a prescribed macroincrement in the logarithmic cycle space. It is to be noted that at every Gauss point, three separate DMNs need to be evaluated for finding the interpolated material response. On the other hand, the MOR-based approach using 15 proper orthogonal decomposition modes for the reduced-order model from Magino et al. [47] requires around 2.4 ms for identifying the material response at the Gauss point for a prescribed macro-increment in the logarithmic cycle space. 

Therefore, the computational cost is increased by a factor of around 10 when using individually trained DMNs for fiber orientation interpolation. Nevertheless, the versatility of the DMN makes it an attractive choice. The trained DMNs can not only model the fatigue response with high fidelity but also the plasticity-creep response as shown in Sect. 3.4. This is unlike the MOR-based approach which is configured for predicting the fatigue response only. Moreover, the decoupling of the material response of the constituents from the geometric state, in the DMN response, opens a vast array of opportunities to modify existing material models and parameterize them based on the composite response. 

1195 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

**==> picture [596 x 203] intentionally omitted <==**

**Fig. 14** Stiffness degradation under high-cycle fatigue loading 

## **4 Extension of fatigue-damage model** 

## 4.1 Experimental investigations 

The stiffness degradation under fatigue loading for fiber-reinforced polymers are investigated with the help of experiments performed using the reinforced PBT composite [51]. The experiments were performed on samples cut out from an injection molded plate. We use the samples cut out in the 0[◦] and 90[◦] direction w.r.t. the flow direction during injection molding as shown in Fig. 13a. The layered fiber orientation tensor over the thickness of the sample was extracted from _μ_ CT scans performed using a small volume of the identified samples [79]. The FOT using nine layers over the thickness of the sample is depicted in Fig. 13b [51]. 

Both the samples were subjected to cyclic loading with a stress ratio of _R_ = 0 using a range of stress amplitudes [51]. Moreover, the experiment for each load case was repeated three times to determine the variation of the measurements [51]. The decrease of dynamic stiffness of the material under fatigue loading is of interest to us. As a result, for each cycle, we recorded the maximum strain _ε_ max and the minimum strain _ε_ min. Finally, the dynamic stiffness of the sample is calculated, 

**==> picture [270 x 22] intentionally omitted <==**

The experiments corresponding to each stress level are conducted at different frequencies. This was done to study the viscoelastic effect of the composite on the stiffness degradation, see Magino et al. [51]. However, in this work, the viscoelastic effects are not taken in account during the modeling approach. Therefore, we normalize the dynamic stiffness using the initial dynamic Young’s modulus of the sample at _N_[¯] = 0, _E_ dyn(0). We plot the normalized dynamic stiffness against the logarithmic cyclic variable _N_[¯] for different stress amplitudes in the 0[◦] and 90[◦] directions in Fig. 14. We also plot the scatter of the experiment for each stress level along with the mean value in Fig. 14. Each experiment at every stress level is repeated three times to obtain the scatter. 

At first glance, it can be seen that the scattering of the experiments is significantly higher in the 0[◦] direction when compared to the 90[◦] direction, see Fig. 14a and b. Moreover, the stiffness degradation in both directions show a steady linear decrease up to around _N_[¯] = 2, i.e., in the primary stage. However, after 100 cycles, i.e., secondary stage and beyond, the stiffness degradations due to fatigue-damage shows a strongly nonlinear response. Hence, it was clear to us that the elegant fatigue-damage model for the matrix, formulated using a linear damage evolution, in Magino et al. [47] (Sect. 2.1.1) is not sufficient to fully represent the highly nonlinear stiffness degradation of the composite material. Therefore, in the following section, we introduce a novel fatigue-damage model for the matrix material, based on a nonlinear damage evolution, and seek a better fit to the composite experiments shown in Fig. 14. 

1196 

A. Dey et al. 

## 4.2 Power-law fatigue-damage model 

In this section, we extend the fatigue-damage model with a linear damage evolution, proposed in Magino et al. [47] and briefly outlined in Sect. 2.1.1. We follow the approach from Magino et al. [47] and formulate the model in the logarithmic cycle space denoted by a continuous positive variable _N_[¯] . Furthermore, the improved power-law fatigue-damage model is defined in the GSM setting [52] and can be directly integrated in the DMN framework. 

We use the free energy density of the model defined in Eq. (2.1), with the help of the macroscopic strain tensor _**ε**_ , the initial fourth-order stiffness tensor C and a positive scalar damage variable _d_ , which serves as the internal variable. The stress is thereby computed as defined in Eq. 2.2. However, we formulate a new dissipation potential, dependent not only on the damage evolution _d_[′] = d _d/_ d _N_[¯] as in Eq. (2.3), but also on the damage variable _d_ and formulated in the GSM framework as 

**==> picture [316 x 24] intentionally omitted <==**

in terms of the parameter _α_ controlling the speed at which damage evolves, a critical damage value _d_ crit, a pre-factor _A_ and an exponent _n_ . 

Finally, the evolution of the internal variable _d_ obtained using the Biot’s equation associated to this specific model, in an explicit form, is defined as 

**==> picture [309 x 24] intentionally omitted <==**

where the damage variable _d_ increases in a linear fashion over the logarithmic cycle space _N_[¯] up to _d_ ≤ _d_ crit, if the stress amplitude is prescribed. In the case when the damage variable _d > d_ crit, the damage evolution is scaled based on a power-law which is dependent on the exponent _n_ , the remaining damage _d_ − _d_ crit and the pre-factor _A_ . This condition is encoded in the model with the help of the Macauley bracket 

**==> picture [300 x 11] intentionally omitted <==**

The evolution Eq. (4.3) is discretized using an implicit setting in the logarithmic cycle space. The fatiguedamage model with the linear damage evolution, defined in Eq. (2.4), can be obtained by setting the parameter _A_ = 0 in the nonlinear damage evolution (4.3). 

We aim to understand the damage evolution of the nonlinear model in detail with the help of a uni-axial extension in a one-dimensional setting under a constant stress amplitude _σ_ max of 30 MPa. Moreover, we consider the evolution of the dynamic stiffness _E_ eff with an initial value of 3 GPa. The exact integration of the damage evolution (4.3) under a constant stress amplitude and initial condition of _d(_ 0 _)_ = 0 is plotted in Fig. 15a for different values of the exponent _n_ . We assign the pre-factor _A_ and _α_ a value of 2 and 0.11, respectively, and the nonlinear evolution starts when the damage reaches a critical value _d_ crit = 0 _._ 05. We also compare the nonlinear response with the linear response where we set the parameter _A_ to zero. We observe that the parameter _α_ determines the initial slope of the damage evolution which remains constant up to _N_[¯] = 6 in the linear case ( _A_ = 0). However, in the nonlinear case ( _A_ = 2), the damage evolution progresses exponentially when the damage variable _d_ reaches the critical damage _d_ crit. The damage evolution is stronger with increase in the value of exponent _n_ , see Fig. 15a. 

We also plot the effective dynamic stiffness _E_ eff degradation defined as 

**==> picture [259 x 23] intentionally omitted <==**

over the logarithmic cycle variable _N_[¯] normalized with the elastic modulus _E_ , which equals the effective stiffness in the undamaged initial state, in Fig. 15b. We see that the slope of the curve remains constant for the linear case ( _A_ = 0) and the effective Young’s modulus decreases due to the damage under fatigue loading. Nevertheless, in the nonlinear case ( _A_ = 2), we observe a behavior corresponding to the damage evolution, where the rate of stiffness degradation increases after the critical damage threshold is reached and is dependent on the value of exponent _n_ . Thus, for a higher number of cycles, the stiffness degradation is sped up and reproduces the stiffness degradation observed in the experiments performed on the composite rather well, see Fig. 14. Therefore, the improved matrix model, incorporating nonlinear power-law damage evolution under high-cycle fatigue, should in principle be able to better reproduce the composite experiments depicted in Fig. 14. 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1197 

**==> picture [596 x 208] intentionally omitted <==**

**Fig. 15** Effect of changing the exponent _n_ on the nonlinear polymer matrix behavior 

## 4.3 Inverse calibration of power-law fatigue-damage model 

Exploiting the additional freedom enabled by the power-law fatigue-damage model, proposed in Sect. 4.2, requires identifying three new parameters _d_ crit _, A_ and _n_ in addition to the two parameters of the linear model (Sect. 2.1.1) _E_ and _α_ . These five parameters need to be calibrated using experimental results. The inverse calibration approach introduced in Dey et al. [37, Fig. 1] enables us to efficiently calibrate all the parameters directly from composite experiments, see Fig. 14. 

However, in contrast to Dey et al. [37], instead of using a single element computation in Abaqus [61] for the inverse calibration, we use the complete sample shown in Fig. 13a by leveraging the FOT interpolation introduced in Sect. 2.3. We observe, in the fatigue testing sample, a slight stress intensity factor rendering the macroscopic response slightly inhomogeneous. Therefore, the structural simulation of the full geometry is deemed necessary. We assign a nine-layered fiber orientation structure to the macroscopic sample depicted in Fig. 13b. Each element in the sample is assigned the respective orientation state and the material response can be efficiently computed using the trained DMNs attached to the three closest orientation states via the fiber orientation interpolation, see Sect. 2.3. Therefore, the trained DMN database over the FOT triangle has a twofold advantage. In addition to enabling the evaluation of the material response at any orientation state, the model-free nature of the DMN permits us to inversely calibrate matrix properties from a single set of composite experiments. 

In our case, we calibrate the power-law fatigue-damage model for the matrix, introduced in Sect. 4.2, based on composite experiments performed in the 0[◦] direction. The inverse calibration is performed in two distinct steps. In the first step, we calibrate the model based on linear damage evolution by setting the parameter _A_ to 0 and optimizing with the experiments performed in the 0[◦] direction up to a normalized dynamic stiffness value of 0.98. This is the primary stage of the stiffness degradation under fatigue loading which can be described by a linear model. We aim to find the Young’s modulus _E_ and the damage-speed parameter _α_ and consider a fixed Poisson’s ratio _ν_ = 0 _._ 4. The macroscopic sample is evaluated in Abaqus [61] and the simulation is iteratively called in an OptiSlang [80] optimization workflow. We simulate the fatigue loading with three different stress amplitudes with a stress ratio _R_ = 0. We set up a minimization problem wherein the area under the normalized dynamic stiffness curve obtained from the composite experiment and from the simulation using the macroscopic sample is considered for each stress level. The objective function minimizes the sum of the areas for the three stress amplitudes. 

We use the One-Click-Optimization (OCO) algorithm in OptiSlang [80] and generate 100 samples of the parameters using Latin Hypercube Sampling (LHS) [81]. The best fitting parameters, stored in Table 6, are obtained when the objective function reaches a minimum value of 0.5%. The plots comparing the composite experiments and the simulations using the linear damage with the best fitting parameters is shown in Fig. 16. We observe that the linear model represents the stiffness degradation of the composite experiments in the 

A. Dey et al. 

1198 

**==> picture [374 x 147] intentionally omitted <==**

**Fig. 16** Experimental and simulation results with best fitting parameters in 0[◦] direction using linear damage evolution 

**Table 6** Matrix parameters for fatigue loading identified with inverse calibration of the composite experiments 

|Matrix|Elastic|_E_ =2871_._5 MPa|_ν_ =0_._4||
|---|---|---|---|---|
||Damage (Linear)|_α_ =0_._07 1_/_MPa|||
||Damage (Power-law)|_d_crit =0_._06|_A_=4|_n_ =1_._4|



primary stage to a reasonable accuracy. The inverse parameter approach also results in higher values of the Young’s modulus _E_ when compared to the Young’s modulus obtained using experiments from the matrix material [47], see Table 1. 

In the next step, we fix the identified linear damage parameters and aim to find the parameters for the nonlinear power-law damage evolution. We follow a similar approach like the linear damage but now we use the complete experimental stiffness degradation of the composite in the 0[◦] direction for three different stress amplitudes, see Fig. 14a. We again use the same optimization and objective function in OptiSlang [80] and find the best fitting parameters using 100 LHS parameter sets. The best fitting parameters, reported in Table 6, were found with a minimum value of the objective function of 11.6%. The composite experiments in the 0[◦] direction are plotted against the best fitting simulation using both the linear and power-law damage evolution in Fig. 17a. We find that the power-law damage evolution can better model the stiffness degradation under fatigue. This is mainly because the rate of stiffness degradation remains fixed in the case of linear damage evolution, and it can model the stiffness degradation up to 100 cycles or primary stage only, with reasonably accuracy. On the other hand, the power-law damage evolution can predict the stiffness degradation within the scattering of the experiment for the entire logarithmic cycle window for the lower stress amplitudes. In case of the maximum stress amplitude of 70 MPa, the stiffness degradation beyond 10,000 cycles is not well represented since the model does not account for localizing effects. 

Furthermore, the best fitting parameters are used to simulate the composite experiments at different stress amplitudes in the 90[◦] direction, see Fig. 17b, to validate the anisotropic response. As in the 0[◦] direction, we observe that the power-law damage evolution provides a better fit compared to the linear case for all stress amplitudes. However, in the 90[◦] direction, the fit is worse when compared to the 0[◦] direction. A possible reason might be that the localization effects are stronger in the 90[◦] direction since the composite is weaker, especially for higher stress amplitudes. Nevertheless, the power-law fatigue-damage model introduced in Sect. 4.2 fits the composite experiments in both 0[◦] and 90[◦] directions with reasonable fidelity when compared to the matrix model with linear damage evolution introduced in Magino et al. [47]. Therefore, the FOT interpolation based on the DMNs allow us not only to extend or modify material laws of the constituents but also enable us to efficiently identify the material parameters with a reduced number of experiments via inverse calibration. 

## **5 Conclusion** 

In the work at hand, we consider the problem of multi-scale modeling of short fiber-reinforced thermoplastics for all possible orientation states under long-term loading using the DMNs as a surrogate for the micro-scale. This is in contrast to FE[2] approaches where each Gauss point in the macro-scale finite element simulation is 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1199 

**==> picture [596 x 202] intentionally omitted <==**

**Fig. 17** Experimental and simulation results with best fitting parameters under high-cycle fatigue 

equipped with a finite element model of the microstructure that is used to solve the cell problem. Although the FE[2] method delivers accurate results, it is computationally expensive, especially when the microstructure definition varies in the macro-scale. In this regard, MOR-based approaches are computationally efficient. However, there exists a trade-off in the numerical performance when selecting the proper quadrature essential for accuracy [82,83]. Magino et al. [47] uses specific material models to circumvent the quadrature problem, which in turn restricts modeling freedom. Nevertheless, one of the major drawbacks of the MOR approach is that any further change in the constitutive model requires a re-calibration of the complete micro-scale approach. 

We are interested in a more general approach where the matrix model for fatigue-damage can be modified and tuned based on performance at the composite level. The DMNs offer us an efficient surrogate for micromechanics and is able to model the inelastic composite response for a variety of design tasks. Several works [1–3] have introduced upscaling techniques by training/re-training a single DMN a priori over an array of microstructural descriptors. However, with a view to long-term load cases such as fatigue or creep [36], we use the fiber orientation interpolation introduced in Köbler et al. [46] and train multiple DMNs over the complete FOT triangle for the a posteriori evaluation of the composite response. We integrate the fatigue-damage model introduced in Magino et al. [47] in the FOT interpolation framework and validate the composite response for all possible orientation states with the help of full-field FFT response. We demonstrate the generalizability of the DMN-based FOT interpolation by integrating and validating the system with a coupled plasticity-creep law [37]. We show that the trained DMN database can reproduce the composite response for fatigue, quasi-static and creep load cases simultaneously with a reasonable fidelity. 

Finally, we critically examine the stiffness degradation of the composite based on experimental results. We find that after a few hundred cycles (primary stage) the stiffness degradation becomes strongly nonlinear in nature. Therefore, we introduce an improved matrix model with a nonlinear power-law damage evolution for modeling fatigue of SFRTs. We circumvent the drawback of re-calibrating the multi-scale workflow imposed by the MOR-based approach [47] with the DMN-based approach. The DMNs decouple the constitutive model of the constituents from the geometric state. Thus, we integrate the power-law fatigue-damage model into the DMN-based multi-scale framework with minimum effort. We inversely calibrate [37] the power-law fatiguedamage model for the matrix based on composite experiments and demonstrate that this model enables us to better fit the stiffness degradation beyond the primary stage. Nevertheless, the modeling of the stiffness degradation in the tertiary stage before failure will be better served with a localizing approach. 

The DMN framework coupled with the FOT interpolation framework from Köbler et al. [46] creates an offthe-shelf all-inclusive database for calibrating the composite response for all possible orientation states under a range of load cases. This framework can also be used for component simulation with a varying spatial response, albeit with further speed-up using sparse matrices in the DMN online phase [2] creating a one-stop solution for multi-scale modeling of SFRTs. Furthermore, extending the database framework for interpolation over other 

A. Dey et al. 

1200 

geometric descriptors such as fiber length and capturing the uncertainties arising out of the microstructure [3] may also be worth the effort. 

**Acknowledgements** MS and TB gratefully acknowledge support by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) - project 255730231. We thank the anonymous reviewers for their detailed remarks which significantly improved the presentation of the manuscript. 

**Open Access** This article is licensed under a Creative Commons Attribution 4.0 International License, which permits use, sharing, adaptation, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if changes were made. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit http://creativecommons.org/licenses/by/4.0/. 

**Funding** Open Access funding enabled and organized by Projekt DEAL. 

## **References** 

1. Liu, Z., Wei, H., Huang, T., Wu, C.: Intelligent multiscale simulation based on process-guided composite database. arXiv:2003.09491 (2020) 

2. Gajek, S., Schneider, M., Böhlke, T.: An FE-DMN method for the multiscale analysis of short fiber reinforced plastic components. Comput. Methods Appl. Mech. Eng. **384** , 113952 (2021) 

3. Meyer, N., Gajek, S., Görthofer, J., Hrymak, A., Kärger, L., Henning, F., Schneider, M., Böhlke, T.: A probabilistic virtual process chain to quantify process-induced uncertainties in sheet molding compounds. Compos. Part B Eng. 110380 (2022) 

4. Thomason, J.: The influence of fibre properties of the performance of glass-fibre-reinforced polyamide 6, 6. Compos. Sci. Technol. **59** (16), 2315–2328 (1999) 

5. Meneghetti, G., Ricotta, M., Lucchetta, G., Carmignato, S.: An hysteresis energy-based synthesis of fully reversed axial fatigue behaviour of different polypropylene composites. Compos. B Eng. **65** , 17–25 (2014) 

6. Jia, N., Kagan, V.A.: Effects of time and temperature on the tension-tension fatigue behavior of short fiber reinforced polyamides. Polym. Compos. **19** (4), 408–414 (1998) 

7. Hassan, A., Rahman, N.A., Yahya, R.: Moisture absorption effect on thermal, dynamic mechanical and mechanical properties of injection-molded short glass-fiber/polyamide 6, 6 composites. Fibers Polym. **13** , 899–906 (2012) 

8. Welschinger, F., Köbler, J., Andrä, H., Müller, R., Schneider, M., Staub, S.: Efficient multiscale methods for viscoelasticity and fatigue of short fiber-reinforced polymers. Key Eng. Mater. **809** , 473–479 (2019) 

9. Köbler, J., Magino, N., Andrä, H., Welschinger, F., Müller, R., Schneider, M.: A computational multi-scale model for the stiffness degradation of short-fiber reinforced plastics subjected to fatigue loading. Comput. Methods Appl. Mech. Eng. **373** , 113522 (2021) 

10. Mori, T., Tanaka, K.: Average stress in matrix and average elastic energy of materials with misfitting inclusions. Acta Metall. **21** (5), 571–574 (1973) 

11. Willis, J.R.: Variational and related methods for the overall properties of composites. Adv. Appl. Mech. **21** , 1–78 (1981) 

12. Benveniste, Y.: A new approach to the application of Mori-Tanaka’s theory in composite materials. Mech. Mater. **6** (2), 147–157 (1987) 

13. Hill, R.: Elastic properties of reinforced solids: some theoretical principles. J. Mech. Phys. Solids **11** (5), 357–372 (1963) 

14. Moulinec, H., Suquet, P.: A numerical method for computing the overall response of nonlinear composites with complex microstructure. Comput. Methods Appl. Mech. Eng. **157** (1–2), 69–94 (1998) 

15. Eyre, D.J., Milton, G.W.: A fast numerical scheme for computing the response of composites using grid refinement. Eur. Phys. J. Appl. Phys. **6** (1), 41–47 (1999) 

16. Spahn, J., Andrä, H., Kabel, M., Müller, R.: A multiscale approach for modeling progressive damage of composite materials using fast Fourier transforms. Comput. Methods Appl. Mech. Eng. **268** , 871–883 (2014) 

17. Schneider, M., Ospald, F., Kabel, M.: Computational homogenization of elasticity on a staggered grid. Int. J. Numer. Methods Eng. **105** (9), 693–720 (2016) 

18. Michel, J.-C., Suquet, P.: Nonuniform transformation field analysis. Int. J. Solids Struct. **40** (25), 6937–6955 (2003) 

19. Fritzen, F., Böhlke, T.: Nonuniform transformation field analysis of materials with morphological anisotropy. Compos. Sci. Technol. **71** (4), 433–442 (2011) 

20. Wulfinghoff, S., Cavaliere, F., Reese, S.: Model order reduction of nonlinear homogenization problems using a HashinShtrikman type finite element method. Comput. Methods Appl. Mech. Eng. **330** , 149–179 (2018) 

21. Guo, T., Rokoš, O., Veroy, K.: A reduced order model for geometrically parameterized two-scale simulations of elasto-plastic microstructures under large deformations. arXiv:2307.16894 (2023) 

22. Zhang, A., Mohr, D.: Using neural networks to represent von Mises plasticity with isotropic hardening. Int. J. Plast. **132** , 102732 (2020) 

23. Abueidda, D.W., Koric, S., Sobh, N.A., Sehitoglu, H.: Deep learning for plasticity and thermo-viscoplasticity. Int. J. Plast. **136** , 102852 (2021) 

24. Jang, D.P., Fazily, P., Yoon, J.W.: Machine learning-based constitutive model for J2-plasticity. Int. J. Plast. **138** , 102919 (2021) 

25. Settgast, C., Hütter, G., Kuna, M., Abendroth, M.: A hybrid approach to simulate the homogenized irreversible elastic-plastic deformations and damage of foams by neural networks. Int. J. Plast. **126** , 102624 (2020) 

On the effectiveness of deep material networks for the multi-scale virtual characterization 

1201 

26. Al-Haik, M., Hussaini, M., Garmestani, H.: Prediction of nonlinear viscoelastic behavior of polymeric composites using an artificial neural network. Int. J. Plast. **22** (7), 1367–1392 (2006) 

27. Chen, J., Liu, Y.: Fatigue modeling using neural networks: a comprehensive review. Fatigue Fract. Eng. Mater. Struct. **45** (4), 945–979 (2022) 

28. Raissi, M., Perdikaris, P., Karniadakis, G.E.: Physics-informed neural networks: a deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations. J. Comput. Phys. **378** , 686–707 (2019) 

29. Wu, L., Kilingar, N.G., Noels, L., et al.: A recurrent neural network-accelerated multi-scale model for elasto-plastic heterogeneous materials subjected to random cyclic and non-proportional loading paths. Comput. Methods Appl. Mech. Eng. **369** , 113234 (2020) 

30. Ghavamian, F., Simone, A.: Accelerating multiscale finite element simulations of history-dependent materials using a recurrent neural network. Comput. Methods Appl. Mech. Eng. **357** , 112594 (2019) 

31. Tandale, S.B., Stoffel, M.: Recurrent and convolutional neural networks in structural dynamics: a modified attention steered encoder–decoder architecture versus LSTM versus GRU versus TCN topologies to predict the response of shock wave-loaded plates. Comput. Mech. 1–22 (2023) 

32. Liu, Z., Wu, C., Koishi, M.: A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. Comput. Methods Appl. Mech. Eng. **345** , 1138–1168 (2019) 

33. Liu, Z., Wu, C.: Exploring the 3D architectures of deep material network in data-driven multiscale mechanics. J. Mech. Phys. Solids **127** , 20–46 (2019) 

34. Gajek, S., Schneider, M., Böhlke, T.: On the micromechanics of deep material networks. J. Mech. Phys. Solids **142** , 103984 (2020) 

35. Nguyen, V.D., Noels, L.: Interaction-based material network: a general framework for (porous) microstructured materials. Comput. Methods Appl. Mech. Eng. **389** , 114300 (2022) 

36. Dey, A.P., Welschinger, F., Schneider, M., Gajek, S., Böhlke, T.: Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelastically-informed strategy. Arch. Appl. Mech. **92** , 2733–2755 (2022) 

37. Dey, A.P., Welschinger, F., Schneider, M., Gajek, S., Böhlke, T.: Rapid inverse calibration of a multiscale model for the viscoplastic and creep behavior of short fiber-reinforced thermoplastics based on deep material networks. Int. J. Plast. **160** , 103484 (2023) 

38. Gajek, S., Schneider, M., Böhlke, T.: An FE-DMN method for the multiscale analysis of thermodynamical composites. Comput. Mech. **69** , 1087–1113 (2022) 

39. Klimkeit, B., Castagnet, S., Nadot, Y., El Habib, A., Benoit, G., Bergamo, S., Dumas, C., Achard, S.: Fatigue damage mechanisms in short fiber reinforced PBT+ PET GF30. Mater. Sci. Eng. A **528** (3), 1577–1588 (2011) 

40. Chebbi, E., Mars, J., Wali, M., Dammak, F.: Fatigue behavior of short glass fiber reinforced polyamide 66: experimental study and fatigue damage modelling. Period. Polytech. Mech. Eng. **60** (4), 247–255 (2016) 

41. Lise, L. G. M.: Investigation of damage evolution due to cyclic mechanical loads and load/frequency spectra-effects in short-fibre-reinforced thermoplastics. Doctoral thesis, Universidade Federal de Santa Catarina (2020) 

42. Nouri, H., Meraghni, F., Lory, P.: Fatigue damage model for injection-molded short glass fibre reinforced thermoplastics. Int. J. Fatigue **31** (5), 934–942 (2009) 

43. Van Paepegem, W., Degrieck, J.: A new coupled approach of residual stiffness and strength for fatigue of fibre-reinforced composites. Int. J. Fatigue **24** (7), 747–762 (2002) 

44. Matouš, K., Geers, M.G., Kouznetsova, V.G., Gillman, A.: A review of predictive nonlinear theories for multiscale modeling of heterogeneous materials. J. Comput. Phys. **330** , 192–220 (2017) 

45. Miehe, C., Hofacker, M., Welschinger, F.: A phase field model for rate-independent crack propagation: Robust algorithmic implementation based on operator splits. Comput. Methods Appl. Mech. Eng. **199** (45–48), 2765–2778 (2010) 

46. Köbler, J., Schneider, M., Ospald, F., Andrä, H., Müller, R.: Fiber orientation interpolation for the multiscale analysis of short fiber reinforced composite parts. Comput. Mech. **61** , 729–750 (2018) 

47. Magino, N., Köbler, J., Andrä, H., Welschinger, F., Müller, R., Schneider, M.: A multiscale high-cycle fatigue-damage model for the stiffness degradation of fiber-reinforced materials based on a mixed variational framework. Comput. Methods Appl. Mech. Eng. **388** , 114198 (2022) 

48. Görthofer, J., Schneider, M., Hrymak, A., Böhlke, T.: A convex anisotropic damage model based on the compliance tensor. Int. J. Damage Mech. **31** (1), 43–86 (2022) 

49. Peerlings, R.H., Brekelmans, W.M., de Borst, R., Geers, M.G.: Gradient-enhanced damage modelling of high-cycle fatigue. Int. J. Numer. Methods Eng. **49** (12), 1547–1569 (2000) 

50. Magino, N., Köbler, J., Andrä, H., Welschinger, F., Müller, R., Schneider, M.: A space-time upscaling technique for modeling high-cycle fatigue-damage of short-fiber reinforced composites. Compos. Sci. Technol. **233** , 109340 (2022) 

51. Magino, N., Köbler, J., Andrä, H., Welschinger, F., Müller, R., Schneider, M.: Accounting for viscoelastic effects in a multiscale fatigue model for the degradation of the dynamic stiffness of short-fiber reinforced thermoplastics. Comput. Mech. **71** (3), 493–515 (2023) 

52. Halphen, N., Nguyen, Q.: Sur les Matériaux standards generalisés. J. Mécanique **14** , 508–520 (1975) 

53. Doghri, I., Brassart, L., Adam, L., Gérard, J.-S.: A second-moment incremental formulation for the mean-field homogenization of elasto-plastic composites. Int. J. Plast. **27** (3), 352–371 (2011) 

54. Simo, J.C., Hughes, T.J.R.: Computational Inelasticity. Springer, New York (1998) 

55. Kostenko, Y., Naumenko, K.: Power plant component design using creep and fatigue damage analysis. In: Proceedings of the 5th Australasian Congress on Applied Mechanics, pp. 89–94 (2007) 

56. Gorash, Y., Altenbach, H., Naumenko, K.: Modeling of primary and secondary creep for a wide stress range: creep for a wide stress range. Proc. Appl. Math. Mech. **8** (1), 10207–10208 (2008) 

57. Milton, G.W.: The Theory of Composites. Cambridge University Press, Cambridge (2002) 

58. Goodfellow, I., Bengio, Y., Courville, A.: Deep Learning. MIT Press, Cambridge (2016) 

59. Naumenko, K., Altenbach, H.: Modeling of creep for structural analysis. In: Foundations of Engineering Mechanics. Springer, Berlin (2007) 

A. Dey et al. 

1202 

60. Anderson, E., Bai, Z., Bischof, C., Blackford, S., Demmel, J., Dongarra, J., Du Croz, J., Greenbaum, A., Hammarling, S., McKenney, A., Sorensen, D.: LAPACK Users’ Guide, 3rd edn. Society for Industrial and Applied Mathematics, Philadelphia, PA (1999) 

61. Simulia: Abaqus CAE. Accessed 09 July 2023 

62. Kabel, M.: Fraunhofer ITWM. In: FeelMath—Mechanical and Thermal Properties of Microstructures. Accessed 08 July 2023 

63. Advani, S.G., Tucker, C.L., III.: The use of tensors to describe and predict fiber orientation in short fiber composites. J. Rheol. **31** (8), 751–784 (1987) 

64. Montgomery-Smith, S., He, W., Jack, D., Smith, D.: Exact tensor closures for the three-dimensional Jeffery’s equation. J. Fluid Mech. **680** , 321–335 (2011) 

65. Montgomery-Smith, S., Jack, D., Smith, D.E.: The fast exact closure for Jeffery’s equation with diffusion. J. Nonnewton. Fluid Mech. **166** , 343–353 (2011) 

66. Schneider, M.: The sequential addition and migration method to generate representative volume elements for the homogenization of short fiber reinforced plastics. Comput. Mech. **59** , 247–263 (2017) 

67. Kabel, M., Merkert, D., Schneider, M.: Use of composite voxels in FFT-based homogenization. Comput. Methods Appl. Mech. Eng. **294** , 168–188 (2015) 

68. Kabel, M., Fink, A., Schneider, M.: The composite voxel technique for inelastic problems. Comput. Methods Appl. Mech. Eng. **322** , 396–418 (2017) 

69. Charière, R., Marano, A., Gélébart, L.: Use of composite voxels in FFT based elastic simulations of hollow glass microspheres/polypropylene composites. Int. J. Solids Struct. **182–183** , 1–14 (2020) 

70. Zeman, J., Vondˇrejc, J., Novák, J., Marek, I.: Accelerating a FFT-based solver for numerical homogenization of periodic media by conjugate gradients. J. Comput. Phys. **229** (21), 8065–8071 (2010) 

71. Brisard, S., Dormieux, L.: FFT-based methods for the mechanics of composites: a general variational framework. Comput. Mater. Sci. **49** (3), 663–671 (2010) 

72. Schneider, M.: A dynamical view of nonlinear conjugate gradient methods with applications to FFT-based computational micromechanics. Comput. Mech. **66** (1), 239–257 (2020) 

73. Schneider, M.: On non-stationary polarization methods in FFT-based computational micromechanics. Int. J. Numer. Methods Eng. **122** (22), 6800–6821 (2021) 

74. Schneider, M.: An FFT-based fast gradient method for elastic and inelastic unit cell homogenization problems. Comput. Methods Appl. Mech. Eng. **315** , 846–866 (2017) 

75. Schneider, M.: Superaccurate effective elastic moduli via postprocessing in computational homogenization. Int. J. Numer. Methods Eng. **123** (17), 4119–4135 (2022) 

76. Paszke, A., Gross, S., Chintala, S., Chanan, G., Yang, E., DeVito, Z., Lin, Z., Desmaison, A., Antiga, L., Lerer, A.: Automatic differentiation in PyTorch. In: NIPS Autodiff Workshop, p. 4 (2017) 

77. Reddi, S.J., Kale, S., Kumar, S.: On the Convergence of Adam and Beyond. arXiv:1904.09237 [cs, math, stat] (2019) 

78. Loshchilov, I., Hutter, F.: SGDR: Stochastic Gradient Descent with Warm Restarts. arXiv:1608.03983 [cs, math] (2017) 

79. Hessman, P.A., Riedel, T., Welschinger, F., Hornberger, K., Böhlke, T.: Microstructural analysis of short glass fiber reinforced thermoplastics based on x-ray micro-computed tomography. Compos. Sci. Technol. **183** , 107752 (2019) 

80. Will,J.:(DynardoGmbH).In:optiSLang—Robustdesignoptimization(RDO)—keytechnologyforresource-efficientproduct development and performance enhancement. Accessed 25 July 2023 

81. McKay, M.D., Beckman, R.J., Conover, W.J.: A comparison of three methods for selecting values of input variables in the analysis of output from a computer code. Technometrics **42** (1), 55–61 (2000) 

82. Hernández, J., Oliver, J., Huespe, A.E., Caicedo, M., Cante, J.: High-performance model reduction techniques in computational multiscale homogenization. Comput. Methods Appl. Mech. Eng. **276** , 149–189 (2014) 

83. van Tuijl, R.A., Remmers, J.J., Geers, M.G.: Integration efficiency for model reduction in micro-mechanical analyses. Comput. Mech. **62** , 151–169 (2018) 

**Publisher’s Note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional 

