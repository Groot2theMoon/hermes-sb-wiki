---
title: "Interaction-based material network: A general framework for porous materials"
journal: "10.1016/j.ijplas.2022.103484"
authors: ["Van Dung Nguyen"]
year: 2023
source: paper
ingested: 2026-05-03
sha256: 9deba41bbd2d7861a7faa04cba5930bd84eb77daea6932e9f8d0d94217d29d2f
conversion: pymupdf4llm
---

International Journal of Plasticity 160 (2023) 103484 

**==> picture [60 x 66] intentionally omitted <==**

Contents lists available at ScienceDirect 

## International Journal of Plasticity 

journal homepage: www.elsevier.com/locate/ijplas 

**==> picture [57 x 72] intentionally omitted <==**

## Rapid inverse calibration of a multiscale model for the viscoplastic and creep behavior of short fiber-reinforced thermoplastics based on Deep Material Networks 

**==> picture [29 x 29] intentionally omitted <==**

## Argha Protim Dey[a] , Fabian Welschinger[a] , Matti Schneider[b][,][∗] , Sebastian Gajek[b] , Thomas Böhlke[b] 

a _Robert Bosch GmbH, Corporate Sector Research and Advance Engineering, Germany_ 

b _Karlsruhe Institute of Technology (KIT), Institute of Engineering Mechanics, Germany_ 

## A R T I C L E I N F O A B S T R A C T 

|_Keywords:_|In this work, we propose to use deep material networks (DMNs) as a surrogate model for full-|
|---|---|
|Viscoplasticity|field computational homogenization to inversely identify material parameters of constitutive|
|Creep<br>Multiscale model<br>Deep material networks<br>Inverse parameter identification<br>Short fiber reinforced thermoplastics|inelastic models for short fiber-reinforced thermoplastics (SFRTs).<br>Micromechanics offers an elegant way to obtain constitutive models of materials with<br>complex microstructure, as these emerge naturally once an accurate geometrical representation<br>of the microstructure and expressive material models of the constituents forming the material<br>are known. Unfortunately, obtaining the latter is non-trivial, essentially for two reasons. For|
||a start, experiments on pure samples may not accurately represent the conditions present in|
||the composite. Moreover, the manufacturing process may alter the material behavior, and a|
||subsequent modification is necessary. To avoid modeling the physics of the manufacturing|
||process, one may identify the material models of the individual phases of the composite|
||based on experiments on the composite. Unfortunately, this procedure requires conducting|
||time-consuming simulations.|
||In the work at hand, we use Deep Material Networks to replace full-field simulations, and to|
||carry out an inverse parameter optimization of the matrix model in a SFRT. We are specifically|
||concerned with the long-term creep response of SFRTs, which is particularly challenging to|
||both experimental and simulation-based approaches due to the strong anisotropy and the long|
||time scales involved. We propose a dedicated fully coupled plasticity and creep model for the|
||polymer matrix and provide details on the experimental procedures.|



## **1. Introduction** 

## _1.1. State of the art_ 

Due to its inherent anisotropy, the experimental characterization of short fiber-reinforced thermoplastics (SFRTs) is a timeconsuming endeavor, especially for inelastic load cases such as elasto-plasticity and creep. This group of materials combines excellent features like high stiffness and strength with the capability for mass production of components using injection molding. A traditional characterization workflow for SFRTs requires the injection molding of test plates, milling of samples with various orientations with 

- ∗ Corresponding author. 

- _E-mail address:_ matti.schneider@kit.edu (M. Schneider). 

https://doi.org/10.1016/j.ijplas.2022.103484 

Received 31 August 2022; Received in revised form 4 November 2022 

Available online 1 December 2022 0749-6419/© 2022 Elsevier Ltd. All rights reserved. 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

respect to the main flow direction, and finally physical testing. Our goal is to reduce this experimental burden and propose an accurate simulative characterization of elasto-plasticity and creep of SFRTs using a minimal number of experiments. 

To this effect, an efficient multi-scale procedure using the concept of homogenization by resolving the problem into two scales, i.e., micro and macro (Welschinger et al., 2019; Köbler et al., 2021) is opted for. The two essential ingredients of the micro-scale problem are the constitutive model for each phase of the composite (in our case, the polymer matrix and glass fibers) and the geometric representation of the microstructure. As the microstructure varies throughout the component, i.e., due to changing volume fraction or fiber orientation, the micro-scale problem to be solved changes at different points of the composite part. To alleviate restrictive geometric assumptions of mean field or analytical homogenization approaches (Mori and Tanaka, 1973; Willis, 1981; Benveniste, 1987; Hill, 1963), computational homogenization methods operate on a specific spatially resolved microstructure and determine the macroscopic properties directly. Combining approaches based on the Fast Fourier Transform (FFT) (Moulinec and Suquet, 1998; Eyre and Milton, 1999; Spahn et al., 2014; Schneider et al., 2016) and model order reduction techniques (Michel and Suquet, 2003; Fritzen and Böhlke, 2011; Wulfinghoff et al., 2018) appears particularly promising. 

For engineering applications, the multi-scale framework requires to calibrate the constitutive laws for the phases of the composite based on experiments. We assume that the inelastic behavior, particularly long-term deformation, is a feature of the polymer matrix only (Papanicolaou and Zaoutsos, 2019). Classically, the forward method considers experiments performed on the pure matrix to calibrate the inelastic material model based on dedicated optimization procedures (Harth et al., 2004; Grédiac and Pierron, 2006; Yun and Shang, 2011). The calibrated material model serves as the input for the mentioned homogenization techniques to determine the overall composite response. This approach comes with a shortcoming—the change in material properties as a result of the injection molding process is not captured. The thermomechanical history induced in the composite by the injection molding process introduces flow-induced (Pantani et al., 2005; Kim and Jeong, 2019; Dargazany et al., 2014) and quiescent crystallization (Spina et al., 2018) in the polymer matrix. Moreover, the presence of fibers also promotes the fiber-induced crystallization of the matrix material (Pan et al., 2021). We refer to a recent review (Zhang et al., 2016) of different polymer crystallization theories. Therefore, the material properties identified using this approach typically lead to inaccurate results when used in the computational homogenization framework to obtain the composite response. 

Alternatively, an inverse approach proceeds by calibrating the constitutive model of the polymer matrix based on experiments performed on the _composite material_ . The inverse approach to obtain material parameters was performed for different material classes, such as sheet molded composites (Schemmann et al., 2018, 2015), polycrystalline materials (Herrera-Solaz et al., 2014; Kuhn et al., 2022) and bimetallic sheets (Yoshida et al., 2003). However, in our case this requires an extremely fast solution of the complete micro-scale problem. 

Data-driven approaches present a viable alternative for approximating the effective characteristics directly instead of solving the micromechanical problems on unit cells. Artificial neural networks (ANNs) are particularly well-suited for such approaches since they may operate on a multi-dimensional region of interest, although the training of the ANNs requires a large data set. Several studies investigated using artificial neural networks to approximate the effective elastic energy (Le et al., 2015; Minh Nguyen-Thanh et al., 2020; Shen et al., 2004a) of a nonlinear elastic media or the relationship between stress and strain of inelastic problems (Jadid, 1997; Penumadu and Zhao, 1999; Srinivasu et al., 2012). ANNs have been used to model inelastic material laws such as plasticity (Zhang and Mohr, 2020; Abueidda et al., 2021; Jang et al., 2021), damage (Settgast et al., 2020) and creep (Al-Haik et al., 2006). However, the prediction quality of such data-driven approaches appears to be low outside of the training domain, and accounting for the intrinsic physics, such as monotonicity and thermodynamic consistency, may be problematic. 

Liu et al. (2019) and Liu and Wu (2019) introduced a data-driven framework called deep material networks (DMN) which acts as a surrogate model for micromechanical computations. They use the concepts underpinning deep learning in a more micromechanicsaware setting. Liu et al. (2019) and Liu and Wu (2019) seek to represent a _𝐾_ -phase microstructure using a _𝐾_ -ary tree structure of laminates with fixed direction of lamination and intermittent rotations. DMNs are used to estimate the effective stiffness of a fixed microstructure as a function of the input stiffness tensors of the constituents, rather than the effective energy or the stress– strain relationship. The major advantage of the DMN framework is the extrapolation capability to inelastic material behavior when trained on linear elastic training data. Furthermore, since the DMN framework only approximates the spatial arrangement of the microstructure, it effectively decouples the material response from the microstructural arrangement. Therefore, DMNs appear to be well-suited for the inverse calibration of the inelastic material models of the composite constituents. 

In further works, Gajek et al. (2020) and Gajek et al. (2021) introduced direct DMNs which have fewer fitting parameters than the original DMNs of Liu et al. Gajek et al. (2020) showed that DMNs ensure thermodynamic consistency of the effective material models provided the individual phases give rise to non-negative mechanical dissipation. DMNs were extended to model interface damage (Liu, 2020) or multiscale strain localization (Liu, 2021) using cohesive zone models. A transfer learning approach was introduced by Liu et al. (2020) to handle fiber-reinforced composites using DMNs, further used to perform uncertainty quantification (Huang et al., 2022). Gajek et al. (2021) used an FE-DMN approach to speed-up two-scale concurrent simulations and extended the FE-DMN method to fully coupled thermomechanical two-scale simulations (Gajek et al., 2022). An interaction-based deep material network for modeling porous microstructures using a non-linear training approach was developed by Nguyen and Noels (2022a). Recently, Dey et al. (2022) showed that the DMNs can efficiently represent highly non-linear creep loading using a novel early-stopping procedure. DMNs were also used to quantify the uncertainties in the manufacturing process of sheet molding compounds, see (Meyer et al., 2023). 

2 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## _1.2. Contribution and outline_ 

We aim to characterize an industrially relevant semi-crystalline thermoplastic composite, reinforced with 30% by weight (17.8% by volume) E-glass fibers using a single set of experiments performed on the composite material. The characterization of the material response of such a complex SFRT involves the calibration of constitutive laws based on experimental results. Individual experiments need to be performed for both the constituents (pure matrix and fibers in our case) and the composite. To characterize the anisotropy of the mechanical response, experiments with samples cut from test plates with various orientations to the main flow direction need to be carried out as well. The resulting large number of experiments is particularly costly for inelastic load cases like creep, where the experimental characterization may take months to be completed. 

The classical _forward calibration_ is based on identifying a suitable material model for the pure matrix and identifying the material parameters using experiments performed on the pure matrix while assuming a linear elastic constitutive law for the fibers. Subsequently, the model and the material parameters along with the spatially varying microstructure (obtained from _𝜇_ CT scans or process simulation) are used as an input for numerical homogenization techniques like efficient Fast Fourier Transform (FFT)-based approaches (Moulinec and Suquet, 1998; Eyre and Milton, 1999; Spahn et al., 2014; Schneider et al., 2016) or traditional finite element solvers for computational homogenization (Eisenlohr et al., 2013), for finding the material response of the composite. The inelastic composite response is compared to the composite experiments in different directions to account for the anisotropy. This current state of the art strategy, discussed in Section 2, often does not lead to favorable results since the process-induced changes in the matrix material such as fiber-induced (Pan et al., 2021) and flow-induced (Pantani et al., 2005) crystallization is not accounted for. 

To avoid setting up sophisticated physics-based models for the manufacturing process (Felder et al., 2020), an intuitive approach would be to identify the material parameters of the matrix from the composite experiments. This _inverse calibration_ of the material model is hampered by the resource and time-intensive solution of the micromechanical problem, which consists of the constitutive law and the geometrical representation of the microstructure. The current state of the art homogenization techniques like the FFTbased approaches (although much faster than experimental calibration) may take several hours to run for complex material laws and microstructures. Thus, an _inverse calibration_ using FFT-based approaches quickly becomes prohibitive, especially in the case of a large number of iterative runs. 

The DMN framework introduced in Section 3, offers us an inexpensive yet reliable surrogate for solving the micromechanical problem. The trained DMN, in the online phase, predicts the material response for inelastic laws like elasto-plasticity (Gajek et al., 2020) and creep (Dey et al., 2022) accurately, thus decoupling the geometric model from the constitutive response. The runtime of the DMN which is in the order of seconds enables us to perform the _inverse calibration_ of complex constitutive material laws such as a fully coupled plasticity and creep law, see Section 2.3. Please note that once a DMN is trained, any constitutive law with an internal variable structure of GSM type can be assigned to the constituents, thus giving rise to a multiscale model for the effective composite response. This property makes the DMNs a convenient, general and flexible tool for the _inverse calibration_ of a variety of materials used in composites when the microstructure is known and fixed. Since the DMN represents the spatially complex microstructure with remarkable accuracy (Gajek et al., 2020; Dey et al., 2022) a single set of composite experiments in a particular direction is sufficient for characterizing our constitutive law. Thus, the DMN framework not only makes the calibration of constitutive laws more accurate but also reduces the burden of performing a large number of experiments. 

The _inverse calibration_ workflow is depicted as a flowchart in Fig. 1. We wish to identify the material parameters for the constitutive model for the matrix. The constitutive model along with experiments performed on the composite and microstructural parameters for the spatially varying microstructure is taken as input. The first step is to identify a suitable virtual microstructure in the form of a representative volume element (RVE) from the microstructural parameters. Then we train a DMN to learn the spatial arrangement of the RVE. With the trained DMN at hand, we set up an optimization routine wherein the micromechanical problem is solved for a large number of iterations within the parameter bounds. The best fit of the DMN simulation with the composite experiments in a particular direction yields the optimal material parameters for the constitutive model of the matrix. Furthermore, the optimal parameters can be used to generate virtual testing data of the composite in different directions using the DMN since the inherent anisotropy of the microstructure is encoded within the DMN framework. The _inverse calibration_ workflow and the benefits of the proposed approach in comparison to the _forward calibration_ workflow is investigated in Section 4. 

## **2. Background for application to plasticity and creep of SFRTs** 

## _2.1. Microstructural investigations_ 

In addition to the mechanical behavior of the individual phases which constitute the composite, a micromechanical investigation hinges on the spatial arrangement of these phases within the microstructure of the material. The composite behavior is strongly dependent on the fiber orientation and the fiber length distribution. As a result, micro-computed tomography ( _𝜇_ CT) scans (Shen et al., 2004b) are used to quantify the microstructure characteristics. 

Micro-computed tomography is a non-destructive approach for acquiring 3D structural information of the microstructure in inhomogeneous materials. It is useful when the individual phases have strongly different absorption rates. We refer to Garcea et al. (2018) for an in-depth discussion on the various features that can be derived by _𝜇_ CT analysis, its applicability for different loading circumstances, and the challenges that one might experience when completing the study. 

3 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [301 x 269] intentionally omitted <==**

**Fig. 1.** Flowchart for the _inverse calibration_ of constitutive law for matrix. 

**==> picture [120 x 196] intentionally omitted <==**

**Fig. 2.** _𝜇_ CT scan of the microstructure. 

We performed a high resolution _𝜇_ CT scan using a 30% by weight glass fiber reinforced semi-crystalline thermoplastic composite specimen milled out from a 120 mm × 80 mm × 2 mm injection molded plate. The _𝜇_ CT scan was performed on a region of interest (ROI) which encompasses a volume of 1.1 mm × 1.3 mm × 1.9 mm within the sample. We performed the _𝜇_ CT for one single region of interest. However, we followed the workflow laid down in a previous work by Hessman et al. (2019), wherein multiple repeats of the _𝜇_ CT analysis were performed to characterize the microstructure of a fiber-reinforced polymer with sufficient accuracy. Therefore, we are confident that the _𝜇_ CT scan can accurately represent the spatial arrangement of the fibers in the microstructure. The results from the scan are shown in Fig. 2. In a further step we extracted the structural information from the volume images. We adopted a voxel-based approach where calculations were performed per layer, with the fibers assigned to the layers. Then microstructure information for each layer is extracted from high-resolution volume photographs of the material (Robb et al., 2007). 

4 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 1** 

Average second order fiber orientation tensor over thickness for the composite microstructure. 

|Layer|#|_𝐴_11|_𝐴_22|_𝐴_33|_𝐴_23|_𝐴_13|_𝐴_12|
|---|---|---|---|---|---|---|---|
|1||0.13|0.86|0.01|−0.01|0|−0.02|
|2||0.13|0.85|0.01|−0.01|0|0|
|3||0.53|0.44|0.02|0|0.01|0.06|
|4||0.14|0.84|0.02|0|0|0|
|5||0.12|0.87|0.01|0|0|−0.01|
|Mean||0.21|0.77|0.02|0|0|0.01|



## **Table 2** 

Average fourth order fiber orientation tensor over thickness for the composite microstructure. 

|Layer|#|_𝐴_1111|_𝐴_1122|_𝐴_1133|_𝐴_1123|_𝐴_1113|_𝐴_1112|_𝐴_2222|_𝐴_2233|_𝐴_2223|_𝐴_2213|_𝐴_2212|_𝐴_3333|_𝐴_3323|_𝐴_3313|_𝐴_3312|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|1||0.07|0.06|0|0|0|−0.01|0.79|0.01|−0.01|0|−0.01|0|0|0|0|
|2||0.07|0.06|0.01|0|0|0|0.78|0.01|−0.01|0|0|0.01|0|0|0|
|3||0.41|0.10|0.01|0|0.01|0.04|0.34|0.01|0|0|0.02|0.01|0|0|0|
|4||0.08|0.06|0.01|0|0|0|0.77|0.01|0|0|0|0.01|0|0|0|
|5||0.06|0.06|0|0|0|0.00|0.81|0.01|0|0|−0.01|0|0|0|0|
|Mean||0.14|0.07|0.01|0|0|0.01|0.69|0.01|−0.01|0|0|0.01|0|0|0|



**==> picture [174 x 61] intentionally omitted <==**

**Fig. 3.** Becker sample (Becker, 2009). 

The method of separating two or more materials from each other based on their gray values is known as segmentation. To segment 3D _𝜇_ CT image data, the commercial software ScanIP (Synopsys Simpleware ™, 2021) is used. It takes image portions from the fiber mask that are too small to be considered fibers and subtracts them. The fibers in contact are also separated by identifying and removing the interface voxels. The second and fourth order fiber orientation tensor, length-weighted mean fiber length and volume fraction were computed using microstructure segmentation from ScanIP (Synopsys Simpleware ™, 2021). The length-weighted mean fiber length for our microstructure evaluated using the segmentation algorithm is 286 _._ 4 μm with a standard deviation of 131 _._ 9 μm. Since the accuracy of the segmentation-based evaluation of the fiber diameter is limited, the fiber diameter was estimated to be 10 μm. The average second order and fourth order fiber orientation tensors (FOT) in each of the five layers, having approximately equal height, over the thickness of the sample and the mean using a single layer over the thickness are given in Table 1 and Table 2, respectively. 

## _2.2. Experimental investigations_ 

## _2.2.1. Pure matrix_ 

Several experimental investigations were performed at Robert Bosch GmbH with the help of a dog-bone shaped Becker sample (Becker, 2009) as shown in Fig. 3. The experiments were done on the unreinforced matrix with the aim of identifying the parameters of the material model of the matrix and use them for the composite response in the classical _forward calibration_ technique. In this work, we perform the _forward calibration_ of the material model to compare the results with the novel _inverse calibration_ using DMNs in Section 4.5. 

The anisotropy in the unreinforced polymer matrix is small enough that using an isotropic material model is sufficient. Hence the direction in which the loads are applied does not play any role in the mechanical response. Firstly, we performed monotonic loading of the specimen up to 5% strain for four different samples to characterize the elasto-plastic behavior, see Fig. 4(a). We observe a steady increase of stress with increasing strain up to the plasticity limit where we see a gradual saturation of the stress with a slight softening at the end. 

Furthermore, to characterize the long-term creep loading behavior, we performed experiments on the unreinforced matrix at three load levels 23.5 MPa, 32.8 MPa, and 37.5 MPa. The experiments were load-controlled and the load was ramped up to the respective stress levels in 8.5 s and then held constant for different time intervals depending on the load level. The experimental results are shown in Fig. 4(b). Three creep phases are typically observed (Andrade, 1910). In the primary creep stage, the creep-strain rate begins with a high value and decreases to a nearly constant value in the secondary creep stage. The creep strain rate increases throughout the tertiary phase, eventually resulting in specimen breakage (Naumenko and Altenbach, 2007). For all three load levels taken into consideration, the first stage concludes at about the same time. However, for the three load levels, the beginning of the third stage and the inclination of the strain at start are rather different. 

5 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [233 x 195] intentionally omitted <==**

**==> picture [187 x 195] intentionally omitted <==**

**Fig. 4.** Experimental results for unreinforced matrix. 

**==> picture [234 x 109] intentionally omitted <==**

**Fig. 5.** Prepared Becker (Becker, 2009) samples from composite plates with different directions. 

## _2.2.2. Composite_ 

The fibers dispersed in the matrix material render the plasticity and creep response of the composite strongly anisotropic. Thus, to account for the anisotropy, the experimental analysis was performed using samples cut out from an injection molded plate in specific angles with respect to the main flow direction as shown in Fig. 5. The monotonic loading of the samples at different strain levels cut out from the injection molded plate at angles of 0[◦] , 15[◦] , 30[◦] , 60[◦] and 90[◦] were performed, see Fig. 6. The elasto-plastic response of the composite is qualitatively similar to that of the pure matrix. The 0[◦] direction shows the stiffest response as a result of maximum number of fibers oriented in the direction of loading. The material response becomes progressively softer as we move from 0[◦] to 90[◦] direction as illustrated in Fig. 6. 

The load-controlled experiments for evaluating the creep response of the composite were performed using samples milled from the injection molded plate at 0[◦] , 30[◦] and 90[◦] directions only, since the creep experiments are time and resource consuming. Three different stress levels were applied in each direction for the evolution of creep in the material and for each stress level several samples were tested. The observed mean creep strain is plotted against the logarithmic time scale in Fig. 7 since, at higher load levels, the experimental time is significantly shorter. 

In the 0[◦] direction, most of the fibers are aligned in the direction of loading and hence the maximum load is carried by the fibers. So, the maximum loads are applied in this direction and consequently it has the highest resistance to creep compared to the 30[◦] and 90[◦] directions, see Fig. 7(a). In the 30[◦] direction the load is partially carried by the fibers. This leads to higher creep strains at smaller loads as evident from Fig. 7(b). Finally, in the 90[◦] direction the majority of the load is carried by the matrix material. Hence the highest creep strains were observed at the lowest loads, see Fig. 7(c). 

## _2.3. Coupled plasticity and creep law_ 

## _2.3.1. Motivation_ 

For the material modeling of plasticity and creep in SFRTs, the fibers and the matrix are assigned separate constitutive material models. The glass fibers are modeled as linear elastic and the material parameters are obtained from Doghri et al. (2011) and 

6 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [331 x 184] intentionally omitted <==**

**Fig. 6.** Experimental results under monotonic loading at different directions for the composite. 

**==> picture [414 x 94] intentionally omitted <==**

**Fig. 7.** Experimental results under creep loading at different directions for the composite. 

defined in Table 3. On the other hand, the matrix undergoes both plastic deformation on a short time scale and creep deformations on a long time scale. Consequently, a fully coupled plasticity and creep law is required for modeling the mechanical behavior. The plasticity model accounts for inelastic strains during the load ramp-up for the first 8.5 s. The creep model captures the inelastic strain during long-term loading. Since we observe maximum creep strains of slightly above 4% in Fig. 7 for the composite, we consider a constitutive law for the matrix material in the small strain, i.e., geometrically linear framework. 

The model is formulated in the generalized standard material (GSM) (Halphen and Nguyen, 1975) setting where the thermodynamic consistency is a consequence of the convexity of the potentials. The GSM framework is also convenient for concurrent multiscale modeling, e.g., in the context of DMNs (Gajek et al., 2021). 

## _2.3.2. Basic kinematics and state variables_ 

Aiming at a continuum mechanical description of creep processes in unreinforced thermoplastic materials, a combined _𝐽_ 2 plasticity with isotropic exponential linear hardening (Simo and Hughes, 1998) and a creep model with stress power and strain hardening exponential law (Kostenko and Naumenko, 2007) is envisaged. The creep part in the model accounts for both the primary and the secondary stage of creep. The primary creep stage is modeled by an exponential strain hardening term whereas the secondary creep stage is captured with a combined power law and linear term (Gorash et al., 2008). Within a small deformation setting, in addition to the macroscopic displacement field _**𝒖**_ , a variable _𝛼_ is introduced to describe the isotropic hardening process on a phenomenological level. The macroscopic strain tensor, defined as the symmetric part of the displacement gradient, _**𝜺**_ = ∇ _𝑠_ _**𝒖**_ is decomposed 

**==> picture [444 x 8] intentionally omitted <==**

into an elastic part _**𝜺**_[e] which quantifies reversible deformations and inelastic parts _**𝜺**_[p] (plastic strain) and _**𝜺**_[c] (creep strain) which describe the permanent deformation of the material that remains upon unloading. 

7 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## _2.3.3. Energy storage mechanisms, stresses, and driving forces_ 

The free energy density _𝜓_ for the plasticity and creep model 

**==> picture [439 x 17] intentionally omitted <==**

is defined in terms of the bulk modulus _𝜅_ , the shear modulus _𝜇_ , the linear hardening modulus _ℎ_ , the initial yield stress _𝑦_ 0, the saturation yield stress _𝑦_ ∞ and the hardening parameter _𝜔_ . The elastic constants are related to the Young’s modulus _𝐸_ and Poisson’s ratio _𝜈_ via 

**==> picture [467 x 89] intentionally omitted <==**

## _2.3.4. Dissipation potential_ 

Following the GSM framework, it remains to specify the dissipation potential _𝜙_ . For the coupled plasticity and creep model the dissipation potential is split into plastic and creep parts via 

**==> picture [467 x 181] intentionally omitted <==**

where we used the expressions (2.4) for the driving forces. For the inelastic strains, the flow direction is given by 

**==> picture [467 x 46] intentionally omitted <==**

**==> picture [444 x 25] intentionally omitted <==**

in terms of the creep constants _𝐶_ and _𝑘_ , the pre-factors _𝐴_ 1 and _𝐴_ 2, a reference creep rate _̇𝜀_ 0 and the creep exponent _𝑛_ . In the dissipation potential (2.11), in addition to the classical power law term, we also included a linear term to better represent the creep behavior at lower loads, see Gorash et al. (2008). The necessary condition for the variational principle (2.11) and using the driving force from (2.4) gives the evolution equation for the creep strain 

**==> picture [444 x 16] intentionally omitted <==**

On the algorithmic side the constitutive Eqs. (2.8), (2.9) and (2.12) are solved in an implicit, time-discrete setting using a classical return-mapping algorithm based on a creep-plastic predictor and a plastic corrector step. The model is implemented as a userdefined material subroutine (UMAT) in Abaqus (Simulia, 2022). It can be used without any modification in the FFT-based solver FeelMath (Kabel (Fraunhofer ITWM), 2022) and in the DMN framework. 

8 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## _2.4. Forward calibration of the constitutive law_ 

## _2.4.1. Framework_ 

With the material model described in Section 2.3 at hand, we need to identify the material parameters using the experimental results described in Section 2.2. Following the discussion in Section 1.2, due to the complexity of solving the full micromechanical problem for the composite, both in terms of runtime and resources, the forward approach identifies the material parameters of the matrix from experiments performed on the pure polymer matrix as shown in Fig. 4. 

Since the two inelastic processes under focus take place at different time scales, i.e., plasticity at a short and creep at a long time scale, an incremental two-step parameter identification workflow is applied for the polymer matrix. In a first step, with deactivated evolution of the creep strains, all elastic constants and all plasticity parameters are determined from uni-axial tensile experiments. In a second step of this incremental parameter identification workflow, with frozen elasticity and plasticity coefficients, the remaining creep parameters are identified from long-term creep tests carried out at different load levels. 

## _2.4.2. Identification of elasticity and plasticity coefficients_ 

First, the identification of the elasticity and plasticity parameters is done based on experimental results, see Fig. 4(a). For the optimization workflow, a single element unit cube simulation model is set up in Abaqus (Simulia, 2022) which is iteratively called in an OptiSlang (Will (Dynardo GmbH), 2022) procedure. To identify the material parameters, a minimization problem is set up which minimizes the sum over the load steps of the root mean square deviation between each of the experimental curves and the simulation results. During the optimization, we fix the Poisson’s ratio to _𝜈_ = 0 _._ 4 and the viscosity to _𝜂_ = 0 _._ 001 MPa s, emulating strain-rate independence. 

The algorithm used is the Adaptive Metamodel of Optimal Prognosis (AMOP) (Will and Most, 2009). 300 samples of parameters were generated using the Latin Hypercube Sampling (LHS) method (McKay et al., 2000) and the best fitting parameters with respect to the experimental results, obtained after the optimization using AMOP algorithm, are recorded in Table 3. The total sum of the root mean square deviation between each of the experimental curves and the simulation results with the best fitting parameters is 1.98. The plot comparing the experimental results and the unit cube simulation with the best fitting parameters is shown in Fig. 8(a). The plasticity and creep coupled law accurately represents the plastic deformation at smaller time scales before the onset of creep. 

## _2.4.3. Identification of creep coefficients_ 

A similar approach is adopted for the identification of the remaining creep parameters. The optimization for the creep parameters was also performed in OptiSLang (Will (Dynardo GmbH), 2022) while keeping the already identified elasticity and plasticity parameters fixed. The creep experiments on the unreinforced matrix were performed at three different load levels, see Section 2.2.2. We aim to find a set of creep parameters which describes the deformation behavior at all three stress levels. Therefore, we consider an objective function that accounts for all load levels. The global objective function _𝑓𝑔𝑙𝑜𝑏𝑎𝑙_ is defined as 

**==> picture [444 x 26] intentionally omitted <==**

where _𝑖_ represents one of the load levels, _𝑠_ denotes the 300 samples of parameters generated using LHS (McKay et al., 2000), _𝑛_ Stresses = 3 denotes the number of load levels and 

**==> picture [444 x 31] intentionally omitted <==**

To remove the scaling effects, the local objective function _𝑓𝑙𝑜𝑐𝑎𝑙,𝑖_ is normalized by the maximum strain and maximum time within the entire experimental procedure containing _𝑛𝑝_ recorded data points at every load level. The parameter reference creep rate _̇𝜀_ 0 is added to the model to preserve the consistency of units and is fixed to 1.0 s[−1] during the optimization. 

Similar to the plasticity case, we utilize AMOP (Will and Most, 2009) with a previously set up Abaqus-based (Simulia, 2022) unit-cube simulation. 300 samples of parameters were generated, and the parameter set with the minimum value of the global objective function is given in Table 3. The experimental creep curves at the different load levels are plotted against the simulation using the best parameters, shown in Fig. 8(b) in the log time scale. A high fitting quality is observed for the considered range of stresses. More precisely the relative deviation between the experimental values and the simulation using best fitting parameters of all the stress levels is below 3%. 

With the material parameters identified using the _forward calibration_ workflow at hand, we can directly use it as an input for finding the composite response using homogenization techniques such as FFT simulations. However, we still require a representative virtual microstructure of the composite material which outlines the spatial arrangement of the fibers in the matrix. In the following sections, we discuss the DMN framework and identify a representative microstructure for training the DMN. The DMN framework is then integrated in the _inverse calibration_ workflow to identify the material parameters of the matrix. Finally, in Section 4.5, we use the representative microstructure to compare the performance of the _forward calibration_ using FFT simulations with respect to the DMN-based _inverse calibration_ . 

9 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [441 x 216] intentionally omitted <==**

**Fig. 8.** Experimental results compared to simulation results using best parameter set. 

**Table 3** 

Material parameters for composite material—Matrix parameters obtained from _forward calibration_ of constitutive law. 

|Matrix|Elastic|_𝐸_= 2399_._3 MPa|_𝜈_= 0_._4|||
|---|---|---|---|---|---|
||Plastic|_ℎ_= 346_._9 MPa|_𝜔_= 384_._9|_𝑦_0 = 20_._9 MPa|_𝑦_∞= 51_._9 MPa|
||Creep|_𝐴_1 = 0_._014 MPa−1|_𝑛_= 32_._4|_𝐴_2 = 1_._5 × 10−13 MPa−1|_𝐶_= 1870_._1|
|||_𝑘_= 0_._016|_̇𝜀_0 = 1_._0 s−1|||
|Fibers|Elastic|_𝐸_= 72000 MPa|_𝜈_= 0_._22|||



## **3. Deep material networks** 

## _3.1. Framework_ 

DMNs are a data driven surrogate model for full-field microscale simulations in concurrent multiscale methods, first introduced by Liu and coworkers (Liu et al., 2019; Liu and Wu, 2019). They are based on a data-based approach and rely on hierarchical laminates, where analytical formulas are available for the effective stiffnesses. DMNs act as a high-level surrogate for a finite element discretization of an _𝑁_ -phase microstructure as outlined in Dey et al. (2022). 

The DMN framework is divided in two different phases: offline training and online evaluation. In the following sections we will take a detailed look at each of the phases and an extension of the classical DMN training strategy. 

## _3.2. Offline training_ 

The DMNs seek to replace computationally expensive full-field simulations in computational micromechanics. To achieve this goal, DMNs use a two-phase laminate as a building block for the two-phase microstructure. Evaluating the effective stiffness of a two phase laminate with a normal _**𝒏**_ , which stands for the direction of lamination, and the volume fraction of its constituents, denoted by _𝑐_ 1 and _𝑐_ 2, is computationally inexpensive in the linear elastic case. 

Direct deep material networks (Gajek et al., 2020) comprise a hierarchical binary tree of rotation-free laminates as shown in Fig. 9(a). The binary tree of laminates represents a simplified model for the complex microstructure and enables the fast evaluation of the homogenization function  _𝑌_ . The homogenization function finds an effective material response on the microstructure scale while reflecting the mechanical behavior of the heterogeneous phases of the microstructure _𝑌_ on the smaller scale. 

Each building block of the DMN is a two-phase laminate  _[𝑖] 𝑘_[which][is][assigned][to][each][node][of][the][binary-tree][structure][of][the] DMN. A single building block is shown schematically in Fig. 9(b). We consider a DMN with _𝐾_ layers and utilize a running index _𝑘_ = 1 _,_ … _, 𝐾_ (from top to bottom layer _𝐾_ ). The total number of nodes in the DMN is 2 _[𝐾]_ −1 where _𝑖_ = 1 _,_ … _,_ 2 _[𝐾]_ −1. For prescribed stiffness tensors C1 and C2 of the input materials, we evaluate the homogenized effective stiffness of the DMN 

**==> picture [74 x 10] intentionally omitted <==**

(3.1) 

10 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [42 x 57] intentionally omitted <==**

**==> picture [210 x 112] intentionally omitted <==**

**==> picture [73 x 85] intentionally omitted <==**

**Fig. 9.** A two-phase deep material network. 

by traversing the binary tree from the bottom to the top and by computing the effective laminate stiffness at every node 

**==> picture [444 x 12] intentionally omitted <==**

The effective stiffness of a laminate may be elegantly expressed (Milton, 2002, § 9.5), independent of the anisotropy of the input stiffnesses and the geometrical parameters of the laminate. We follow the same approach for the homogenization at every building block of the DMN as detailed in Gajek et al. (2020, § 3.2). 

The input materials are assigned to the bottom layer of the DMN in an alternated way, 

**==> picture [444 x 26] intentionally omitted <==**

Liu et al. (2019) pointed out the drawbacks of parameterizing each of the laminates by the volume fractions _𝑐_ 1 and _𝑐_ 2. In fact, if one of the volume fractions vanishes, the entire related sub-tree will be effectively deleted. As a remedy, Liu et al. (2019) proposed to parameterize the laminates’ volume fractions using weights _𝑤_[2] _𝐾[𝑖]_[−1] +1[and] _[𝑤]_[2] _𝐾[𝑖]_ +1[which][are][attached][to][each][laminate][at][the][input] layer _𝐾_ + 1. Admissible weights are all non-negative and sum to unity. These weights are additively propagated as we move up the layers 

**==> picture [444 x 12] intentionally omitted <==**

The volume fractions of each building block are then calculated by normalizing the weights 

**==> picture [444 x 26] intentionally omitted <==**

A direct DMN is uniquely specified by prescribing the lamination direction of each laminate and the weights attached to the input layer.parameterThus,vectorthe variables _**𝒑** ⃗_ . The vector _**𝒏**_ and _**𝒑** ⃗ 𝑤_ of _[𝑖] 𝐾_ +1the[may] DMN[be] is[used] then[to] identified[parameterize] based[direct] on linear[DMNs] elastic[of][a] material[specific] sampling[depth][and] and[can] optimization[be][organized] in[into] terms[a] of a cost function which will be discussed in Section 4.2. Once the DMN is identified, it may be applied to nonlinear and inelastic constitutive behavior, as specified in Section 3.3. 

## _3.3. Online evaluation_ 

After identifying the parameter vector _**𝒑** ⃗_ using the elastic training procedure in the offline phase, the inelastic response of the DMN is sought while keeping the parameter vector _**𝒑** ⃗_ fixed. We solve the online phase of the DMN by the approach introduced by Gajek et al. (2020), where a flattened representation of the DMN is used. Our DMN, in the online phase, is similar to a classical laminate with multiple phases. To each phase of the flattened DMN a nonlinear material behavior of GSM type is assigned. The internal variables of the nonlinear constitutive law reside in each phase of the flattened DMN. 

After identifying a DMN in the offline training phase, the weights in the input layer _𝑤[𝑖] 𝐾_ +1[, which are additively propagated, and] the normals _**𝒏**_ remain fixed. We calculate the volume fractions in every building block  _[𝑖] 𝑘_[from][the][weights][using][Eq.][(3.5)][.] 

For the sake of exposition and aiming at two-phase SFRTs, we restrict to a two-phase laminate, i.e., _𝐾_ = 1, with volume fractions _𝑐_[1] _[𝑐]_[2][the][normal][vector] _**[𝒏]**_[1][For][an][extension][to][more][than][two][phases,][see][Nguyen][and][Noels][(][2022b][).][For][a][prescribed] 1[and] 1[and] 1[.] 

11 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

macroscopic strain _**𝜺** ̄_ = ∇ _𝑠_ _**𝒖** ̄_ , a variational problem is set up 

**==> picture [157 x 18] intentionally omitted <==**

(3.6) 

to determine the laminate kinematics in terms of the displacement jump vector _**𝒂**_[1] 1[which][describes][the][strains][in][the][individual] phases 

_**𝜺**_[1] 1[(] _**[𝜺]**[̄][,]_ _**[ 𝒂]**_[1] 1[) =] _**[𝜺]**[̄]_[+] _[ 𝑐]_ 1[2][N][1] 1[⋅] _**[𝒂]**_[1] 1 and _**𝜺**_[2] 1[(] _**[𝜺]**[̄][,]_ _**[ 𝒂]**_[1] 1[) =] _**[𝜺]**[̄]_[−] _[𝑐]_ 1[1][N][1] 1[⋅] _**[𝒂]**_[1] 1 _[.]_ (3.7) Here, the third order tensor N[1] 1[is][defined][by][the][formula] (N[1] 1[)] _[𝑖𝑗𝑘]_[=][1] 2 [( _𝑛_ 11[)] _[𝑖][𝛿][𝑗𝑘]_[+ (] _[𝑛]_[1] 1[)] _[𝑗][𝛿][𝑖𝑘]_ ] for _𝑖, 𝑗, 𝑘_ = 1 _,_ 2 _,_ 3 _,_ (3.8) i.e., as a function of the laminate normal _**𝒏**_[1] 1[.][Moreover,][the][identity] N[1] 1[⋅] _**[𝒂]**_[1] 1[=][ I] _[𝑠𝑦𝑚]_[∶(] _**[𝒏]**_[1] 1 _[⊗]_ _**[𝒂]**_[1] 1[)] (3.9) 

is satisfied in terms of the symmetric fourth order identity tensor I _[𝑠𝑦𝑚]_ . The necessary condition of the variational principle (3.6) reads 

**==> picture [444 x 25] intentionally omitted <==**

We define the traction vectors _**𝒕**_[1] _**[𝒕]**_[2][the][interface][in][terms][of][the][stresses] _**[𝝈]**_[1] _**[𝝈]**_[2][Thus,][the][necessary] 1[=] _**[ 𝝈]**_[1] 1[∶][N][1] 1[and] 1[=] _**[ 𝝈]**_[1] 1[∶][N][2] 1[at] 1[and] 1[.] condition (3.10) reduces to the continuity of the tractions across the internal surface with _**𝒕**_[1] 1[=] _**[ 𝒕]**_[2] 1[.][To][generalize][the][approach][to][a] laminate of depth _𝐾_ , we introduce the array of all displacement jump vectors _**𝒂**[𝑖] 𝑘_[for][all][nodes][in][the][DMN,][where,] _[𝑘]_[= 1] _[,]_[ …] _[ , 𝐾]_[and] _𝑖_ = 1 _,_ … _,_ 2 _[𝑘]_[−1] and denote it by _**𝒂**_ . 

With this array at hand, we consider the following generalization of the problem (3.6), 

**==> picture [444 x 31] intentionally omitted <==**

in terms of the strains in the bottom layer _**𝜺**[𝐼] 𝐾_[,][and][the][free][energies] 

**==> picture [444 x 25] intentionally omitted <==**

The index _𝐼_ = 1 _,_ … _,_ 2 _[𝐾]_ parameterizes the phases in the bottom layer of the deep material network. The strains in each phase of the bottom layer of the DMN may be calculated in a similar way as the approach followed for one node in Eq. (3.7), see Gajek et al. (2021, eq. (3.16)). The stresses on the macroscopic level are computed from Eq. (3.11) via 

**==> picture [444 x 31] intentionally omitted <==**

where _**𝝈**[𝐼]_[the][stress][in][each][individual][phase][of][the][bottom][layer][given][as] _𝐾_[is] 

**==> picture [444 x 13] intentionally omitted <==**

and can be obtained by integrating the time-discretized Biot’s equation of the respective constitutive law attached to each phase. The necessary condition to solve the unknown displacement jump vectors _**𝒂**_ follow from the necessary condition to (3.11) and reads 

**==> picture [444 x 31] intentionally omitted <==**

for an arbitrary variation _𝛿_ _**𝒂**_ . It can be recast into the form of a residual 

**==> picture [444 x 26] intentionally omitted <==**

We seek a root of the residual (3.16) via Newton’s method where we use a backtracking algorithm to ensure a stable convergence behavior (Gajek et al., 2020). The update of Newton’s method using the backtracking factor _𝜆_ ∈(0 _,_ 1] reads 

**==> picture [444 x 10] intentionally omitted <==**

until convergence is obtained depending on the condition ‖ _**𝒓**_ ‖ ⩽ tol. The linear system (3.17) is sometimes ill-posed as a result of very small, nearly vanishing weights, which can occur during training. To alleviate the issue, we regularize the linear system by inserting one at the diagonal elements of the tangent _𝜕_ _**𝒂𝒓**_ at locations where the weights are vanishing. In order to implement the 

12 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

DMN online phase as a user defined material subroutine in Abaqus (Simulia, 2022), we also need the global algorithmic tangent _̄ 𝐷_ _**𝜺** ̄_ _**𝝈**_ which reads 

**==> picture [444 x 10] intentionally omitted <==**

in terms of the local Newton tangent in Eq. (3.17) _𝜕_ _**𝒂𝒓**_ and the partial derivatives, 

**==> picture [444 x 26] intentionally omitted <==**

where _𝐷_ _**𝜺** 𝐼𝐾_ _**[𝝈]** 𝐾[𝐼]_[is][the][tangent][of][the][constitutive][material][law][solved][in][each][phase][of][the][bottom][layer.] The outlined procedure can be effectively used to solve the laminate kinematics and find the unknown jump vectors _**𝒂**_ . The jump vectors are associated with each node of the DMN. A DMN with _𝐾_ layers has 2 _[𝐾]_ −1 nodes, and all 3 ⋅ 2 _[𝐾]_ −1 components of the jump vector _**𝒂**_ are updated simultaneously in each Newton step (3.17). To improve the computational performance, we also initialize the displacement jumps _**𝒂**_ at the beginning of the Newton iteration using the last converged displacement jumps from the previous time step. This reduction in runtime comes at the expense of increased memory demand to store the vector at the end of each time step. If inelastic models are used, we store the internal variables attached to every phase of the bottom layer. A DMN of depth _𝐾_ having 2 _[𝐾]_[−1] laminates in the bottom layer consists of 

**==> picture [444 x 10] intentionally omitted <==**

internal variables, where _𝑍_ 1 and _𝑍_ 2 are the number of internal variables for each phase. The internal variables (3.20) are updated after the Newton iteration (3.17) converges. The online phase is implemented as a user-defined material subroutine in Fortran, relying upon the LAPACK (Anderson et al., 1999) libraries for an efficient evaluation of all linear algebra operations and can be easily integrated into commercial software, like Abaqus (Simulia, 2022) or the commercial FFT solver FeelMath (Kabel (Fraunhofer ITWM), 2022). 

## _3.4. Inelastically-informed training strategy_ 

Traditionally, the DMNs, trained on linear elastic data, can predict the effective material response for a wide variety of nonlinear and inelastic constitutive laws of the constituent phases for the microstructures it has been trained on. The proposed theory (Gajek et al., 2020) suggests that such a close agreement may be lost if the constitutive laws exhibit a significant degree of nonlinearity. This has been corroborated in the prediction of the material response under long-term or creep loading, see Dey et al. (2022, § 3.2). 

Accounting for nonlinear responses in the training procedure could be a potential remedy. Unfortunately, this method is limited by the complexity of the constitutive laws (Nguyen and Noels, 2022a). Indeed, computing the derivatives required for the gradient descent for a wide range of different loading conditions and time steps comes with significant effort and may limit the applicability of such a procedure. An alternative strategy would be to use an early-stopping approach (Goodfellow et al., 2016, § 7.8), where the inelastic material law is evaluated every 50th or 100th iterate during training and the best state of the DMN is identified using the best inelastic error instead of the elastic loss function (which will be explicitly defined in Section 4.2). This inelastically informed training methodology can be further accelerated by using a less expensive inelastic surrogate model such as using a simple Norton-type creep law (Naumenko and Altenbach, 2007) instead of a more complex creep model. Using an efficient surrogate model in training permits to identify a DMN that provides rather accurate results for the prediction of not only the quasi-static response but also the highly non-linear creep response (Dey et al., 2022, § 3.3). 

## **4. Towards reducing the experimental effort** 

## _4.1. On the influence of the microstructure_ 

## _4.1.1. Framework_ 

As stated in Section 1.2, the micromechanical problem involves the constitutive laws of the constituents (fiber and matrix) as well as the spatial arrangement of the fibers in the matrix material. To this effect, the material response of the composite hinges on the representative microstructure of the material involved. There are several factors such as the fiber orientation and fiber length which heavily influence the material response. In this section, we take a look at the influence of some of these factors on the linear elastic response of the composite. Although the microstructural arrangement influences the inelastic composite response, we investigate the involved factors using the elastic response since the inelastic response for a wide variety of microstructures would be extremely time-consuming to compute using state of the art homogenization techniques like FFT simulations. Furthermore, we would also require fixed inelastic material parameters that can emulate the experimental results with a high fidelity, which is not yet available. We used the microstructural parameters reported in Section 2.1 to reconstruct digital microstructures using the SAM algorithm (Schneider, 2017). We generated several cubic unit cells with an edge length of 625 μm containing cylindrical fibers having a length of 286.4 μm and a diameter of 10 μm with a minimum distance of 3 μm between the fibers. 

We investigate the elastic response of the virtual microstructures with the help of the FFT-based computational homogenization software FeelMath (Kabel (Fraunhofer ITWM), 2022). We use the staggered grid discretization (Schneider et al., 2016; Schneider, 2021) and the linear conjugate gradient method (Zeman et al., 2010; Brisard and Dormieux, 2010; Schneider, 2020a) to compute 

13 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 4** 

|**Table 4**|**Table 4**||||
|---|---|---|---|---|
|Experimentally determined mean Young’s||moduli at different|loading angles for the composite.||
|Loading angle|0◦|30◦|60◦|90◦|
|Young’s modulus _𝐸_|8664.77 MPa|6181.28 MPa|4713.02 MPa|4603.03 MPa|



**==> picture [307 x 46] intentionally omitted <==**

**Fig. 10.** Effective Young’s modulus for the microstructures with fourth-order and second-order FOT compared to experimental results. 

the anisotropic linear elastic stiffness matrix of the composite. We take as our input the Young’s modulus _𝐸_ = 2292 MPa and a Poisson’s ratio _𝜈_ = 0 _._ 4 for the pure matrix material obtained from experimental analysis performed at Robert Bosch GmbH. Standard parameters (Doghri et al., 2011) defined in Table 3 are used for the E-glass fibers. The microstructures are discretized with 512[3] voxels, each voxel having an edge length of 1 _._ 22 μm. Each microstructure is further resampled with a factor of two to 256[3] voxels using the composite voxel technique (Kabel et al., 2015, 2017; Charière et al., 2020) to accelerate the FFT computation with high fidelity, see Dey et al. (2022, § 3.1). 

Furthermore, the experimental analysis of the Young’s modulus _𝐸_ in different directions were available at Robert Bosch GmbH, performed using a Becker sample (Becker, 2009) shown in Fig. 3, cut out from an injection molded plate at angles 0[◦] , 30[◦] , 60[◦] and 90[◦] with respect to the flow direction, see Fig. 5. The Becker samples were subjected to monotonic loading up to strains of 0.05% and 0.25%. The stress response at these strains is then used to calculate the Young’s modulus. Five samples are tested for each direction and the mean Young’s modulus for each direction is listed in Table 4. 

The elastic moduli at the different loading angles are also extracted from the anisotropic stiffness matrix obtained from the FFT-simulation and compared with the experimental analysis. For each loading angle we define the relative error 

**==> picture [444 x 31] intentionally omitted <==**

to compare the deviation of the elastic response of the virtual microstructure with respect to the experimental analysis. For visualization, we rely upon the method introduced by Böhlke and Brüggemann (2001). 

## _4.1.2. On the influence of the closure approximation_ 

The reconstruction of the digital microstructure using the SAM algorithm (Schneider, 2017) requires the fourth-order fiber orientation tensor to be prescribed. It is possible to use the fourth-order tensor for generating the virtual microstructure, given in Table 2, directly. Nevertheless, we aim for a complete virtual characterization of the composite starting from the simulation of the injection molding process to find the microstructural parameters and to use them for further evaluation of the material response. The current existing macroscopic models for predicting the fiber orientation tensor generate only the second-order fiber orientation tensor as an output. For a review of existing macroscopic fiber orientation models, we refer to Kugler et al. (2020). 

Therefore, as an alternative we use closure approximations to estimate the fourth-order tensor from the second order-tensor. We generated three virtual microstructures, the first one prescribed with the average fourth-order tensor obtained from the segmentation algorithm using a single layer over the thickness, see Table 2. The second and third microstructures were prescribed with the second-order mean fiber orientation tensor given in Table 1, combined with the maximum entropy closure (Müller and Böhlke, 2016) and the exact closure approximation (Montgomery-Smith et al., 2011a,b) respectively. The numerical results obtained for the three microstructures from the FFT-based computational homogenization are visualized in Fig. 10 using the method described in Böhlke and Brüggemann (2001). The experimental results in the 0[◦] , 30[◦] , 60[◦] and 90[◦] directions with respect to the flow direction are also plotted in Fig. 10. The relative errors at these directions and the number of fibers required to represent the respective FOTs are given in Table 5. We observe that the fourth order fiber orientation tensor conveys a stiffer response and shows a better relative error when compared to the experimental stiffnesses, especially in the 0[◦] and 90[◦] directions. The exact closure approximation 

14 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 5** 

Relative error of Young’s modulus of microstructures with varying FOT compared to experimental Young’s modulus. 

|Closure approximation|Fiber count|_𝑒𝐸_<br>0◦|_𝑒𝐸_<br>30◦|_𝑒𝐸_<br>60◦|_𝑒𝐸_<br>90◦|
|---|---|---|---|---|---|
|No closure|1932|2.78%|2.06%|0.73%|2.63%|
|Max entropy|1932|10.27%|4.42%|0.75%|9.31%|
|Exact closure|1932|5.87%|1.68%|0.96%|5.77%|



**==> picture [290 x 61] intentionally omitted <==**

**Fig. 11.** Effective Young’s modulus for the microstructures with varying fiber lengths compared to experimental results. 

**Table 6** 

Relative error of Young’s modulus of microstructures with varying fiber lengths compared to experimental Young’s modulus. 

|Fiber|length|Fiber count|_𝑒𝐸_<br>0◦|_𝑒𝐸_<br>30◦|_𝑒𝐸_<br>60◦|_𝑒𝐸_<br>90◦|
|---|---|---|---|---|---|---|
|286.4|μm −SD|3581|12.56%|8.77%|5.29%|6.53%|
|286.4|μm −0.5 × SD|2510|5.92%|4.45%|2.44%|4.14%|
|286.4|μm|1932|2.78%|2.06%|0.73%|2.63%|
|286.4|μm + 0.5 × SD|1570|0.23%|0.14%|0.21%|2.18%|
|286.4|μm + SD|1323|3.99%|0.76%|0.85%|1.56%|



shows a slightly softer response when compared to experimental results, whereas the maximum entropy closure shows the highest deviation from experimental results in the 0[◦] , 30[◦] and 90[◦] directions. Therefore, it is apparent that the use of closure approximations results in the loss of information about the spatial arrangement of the fibers in the matrix material. Note that the microstructure generation algorithm uses the same number of fibers to represent the different FOTs in the unit cells, as the fiber count is fixed by the fiber-volume content, the fiber aspect ratio and the volume of the considered cell. 

## _4.1.3. On the influence of the fiber length_ 

In addition to investigating the effect of the spatial distribution of the fibers, we also investigate the effect of the fiber length on the elastic stiffness of the composite. The segmentation algorithm yields the length-weighted mean fiber length of 286.4 μm with a standard deviation (SD) of 131.9 μm. We prescribed the fourth-order fiber orientation tensor to generate virtual microstructures with similar parameters as in Section 4.1.1 but with varying fiber lengths. 

We generated five microstructures starting with the fiber lengths outlined in Table 6. After the linear elastic FFT computations and post-processing the data as in Section 4.1.2, the results are visualized in Fig. 11. The number of fibers in each unit cell and the relative error compared to experimental results is given in Table 6. 

The composite exhibits a gradually stiffer response with increasing fiber length. This stiffer response is more pronounced in the 0[◦] direction since most fibers are oriented in this direction, see Fig. 11. The relative error of the elastic stiffness decreases as we increase the fiber length from 286.4 μm - SD and gives us the best relative error in all directions at a fiber length of 286.4 μm + 0.5 × SD, see Table 6. Thereafter, the errors start to increase with increasing fiber length. The relative error in the 0[◦] direction varies roughly by a factor of three. The fiber length also influences the number of fibers included in the unit cell. More precisely, we observe a decreasing fiber count with increase in fiber length, see Table 6. 

## _4.1.4. On the influence of the layer-wise FOT_ 

The segmentation algorithm applied on the _𝜇_ CT scan image generates not only the layer-wise second-order FOT (outlined in Table 1) but also the layer-wise fourth-order FOT (outlined in Table 2). The FOT varies across the thickness due to varying flow 

15 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [416 x 46] intentionally omitted <==**

**Fig. 12.** Effective Young’s modulus for the microstructures with varying FOT over layers compared to experimental results. 

**Table 7** 

Relative error of Young’s modulus of microstructures with varying FOT over layers compared to experimental Young’s modulus. 

|FOT|Fiber count|_𝑒𝐸_<br>0◦|_𝑒𝐸_<br>30◦|_𝑒𝐸_<br>60◦|_𝑒𝐸_<br>90◦|
|---|---|---|---|---|---|
|1 Layer - Fourth order FOT|1932|2.78%|2.06%|0.73%|2.63%|
|5 Layers - Exact closure|1930|0.92%|1.19%|1.39%|3.14%|
|5 Layers - Fourth order FOT|1930|1.62%|1.76%|1.11%|3.06%|



fields in the shell and core region during the injection molding process. Therefore, the mean FOT over the thickness might not be sufficient to represent the complete information of the spatial arrangement of the fibers. We evaluate the efficiency of the layer-wise FOT by generating two additional microstructures with the same parameters outlined in Section 4.1.1 but prescribing the layer-wise FOT on five layers having equal height over the thickness of the virtual microstructure. One of the microstructures is prescribed with the full fourth-order FOT in each of the five layers from Table 2 and the other with the second order FOT described in Table 1 using exact closure approximations (Montgomery-Smith et al., 2011a,b) in each of the five layers. Furthermore, we compare it with the microstructure generated using the mean fourth-order FOT applied on a single layer, see Section 4.1.2. The results are visualized in Fig. 12 and the relative error with respect to the experimental results along with the number of fibers included in each unit cell is given in Table 7. 

We observe that the five layer microstructures convey a similar elastic response compared to the microstructure prescribed with the fourth-order single layer FOT, see Fig. 12. The results outlined in Table 7 indicate that the relative errors of the five layer microstructures are lower than the mean fourth-order FOT microstructure, roughly by an order of two in the flow direction, i.e, the 0[◦] direction. However, for the five layer microstructure, the error in the 90[◦] direction increases slightly but the overall error values are very small and below 1.4%. Nevertheless, the elastic responses of the five-layer microstructures using the fourth-order FOT and the second-order FOT with the exact closure approximations (Montgomery-Smith et al., 2011a,b) are very close. We also observe that the number of layers does not cause a significant difference in the number of fibers present in the unit cell. 

Thus, we conclude that a five layer microstructure generated using the microstructure descriptors given in Section 4.1.1 and prescribed with the second-order FOT outlined in Table 1 along with the exact closure approximations (Montgomery-Smith et al., 2011a,b) characterizes the elastic response in different directions with sufficient fidelity. However, we focus solely on the inplane deformation since all the experimental investigations were performed in the in-plane direction. It may be possible that the microstructure needs to be characterized with more than five layers for the out-of-plane deformation. In the further steps we use this RVE for generating the training data for the DMN which is then used for the _inverse calibration_ of the material model. 

## _4.2. Training of the DMN model_ 

In our use case, the pure matrix and the E-glass fibers make up the phases of the microstructure identified in Section 4.1. Utilizing the direct DMN outlined in Section 3, we initialized the parameters _**𝒑** ⃗_ in accordance with Gajek et al. (2020). We produced training and validation data using full-field FFT-based computational homogenization. The two linear elasticity tensors C _[𝑠]_ 1[,][C] _[𝑠]_ 2[and] the effective elasticity tensor C _[̄][𝑠]_ FFT[form][the][triples] (C _[𝑠]_ 1 _[,]_[ C] _[𝑠]_ 2 _[,]_[C] _[̄][𝑠]_ FFT) for training and validation. The tuples[(] C _[𝑠]_ 1 _[,]_[ C] _[𝑠]_ 2) were sampled using the method outlined in Liu and Wu (2019) that makes use of orthotropic elasticity tensors. The FFT-based computational homogenization software FeelMath (Kabel (Fraunhofer ITWM), 2022) was used to compute the effective properties C _[̄][𝑠]_ FFT[.][We] generated 1000 samples, divided into 800 training samples and 200 validation samples. The effective stiffness computed by the DMN is denoted as C _[̄][𝑠]_[with][phase][stiffnesses][C] _[𝑠]_[C] _[𝑠]_[an][input][and][for][a][fixed][parameter][set] _**[𝒑]**[⃗]_[.][The][evaluation][of][the] DMN[(] _**[𝒑]**[⃗]_[)] 1[and] 2[as] effective stiffness C _[̄][𝑠]_[proceeds][in][the][same][manner][as][in][Gajek][et][al.][(][2020][).] DMN[(] _**[𝒑]**[⃗]_[)] 

16 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

We choose a layer depth of seven and the training proceeds in a similar manner as outlined in Dey et al. (2022) by minimizing the objective function, 

**==> picture [444 x 24] intentionally omitted <==**

and the batch size _𝑛_ b = 40, the contributions 

**==> picture [444 x 31] intentionally omitted <==**

and the penalty term 

**==> picture [444 x 11] intentionally omitted <==**

_⃗_ where _𝑐_ 1 = 0 _._ 822 and _𝑐_ 2 = 0 _._ 178 represent the volume fractions of the corresponding phases and _**𝒗**_ represents the vector of unconstrained weights as defined in Dey et al. (2022, eq. (2.21)). Here, _**𝒂**_ 1 is a vector with ones at all odd indices and zero otherwise, and _**𝒂**_ 2 is a vector with ones at all even indices and zero otherwise. We set the penalty factor _𝜆_ to be 100. For the training, a minimum of the objective function (4.2) is sought with a stochastic batch-gradient-descent approach that is based on automatic differentiation and batches of size 40. We implemented the process in PyTorch (Paszke et al., 2017), trained the network using the AMSGrad method (Reddi et al., 2019) and modulated the learning rate using cosine annealing (Loshchilov and Hutter, 2017), 

**==> picture [168 x 16] intentionally omitted <==**

**==> picture [18 x 8] intentionally omitted <==**

where _𝛽_ and _𝑚_ denote the learning rate and epoch, respectively. The maximum learning rate is set to _𝛽_ max = 0 _._ 0007, whereas the minimum learning rate is set to _𝛽_ min = 0. The parameter _𝑀_ has a value of 4000 and the DMN is trained up to 10 000 epochs. Fig. 13(a) describes the training progression. The objective function decreases monotonically throughout the first 100 epochs. The loss function then exhibits some oscillations. These are effects of the learning-rate modulation, which allows the loss function to escape local minima. The smallest loss of 0.00637 was recorded at epoch 9 942. 

We introduce the sample-wise error 

**==> picture [444 x 32] intentionally omitted <==**

to assess the generalization capacities of the DMN. Additionally, we define the maximum and mean errors across all samples, 

**==> picture [444 x 24] intentionally omitted <==**

where _𝑁𝑠_ gives the number of samples in the training or the validation set, respectively. Fig. 13(b) displays the mean training and validation errors for the DMN during the course of epochs. We note that the trend of the loss function matches that of the mean training and validation errors. A further indication that there is no overfitting in the offline training phase is the simultaneous decrease in the training and validation error during training. The mean and maximum validation errors at the end of training are 1.25% and 9.6%, respectively. 

Moreover, we found that the purely elastic training can be insensitive to long-term effects of creep loading. We refer to Dey et al. (2022, § 3.3) for a detailed discussion. An alternative would be inelastic training. However, this method is only applicable to relatively simple inelastic material models (Nguyen and Noels, 2022a) because it quickly becomes unaffordable to evaluate complex constitutive laws computationally. Therefore, we adopt an alternative early-stopping procedure using a surrogate model which shares the characteristics of long-term loading but is computationally cheap. This markedly improves the extrapolation to other complex models for creep loading. We use Hooke’s law in combination with a Norton-type creep law (Naumenko and Altenbach, 2007) 

**==> picture [102 x 9] intentionally omitted <==**

**==> picture [132 x 19] intentionally omitted <==**

**==> picture [18 x 8] intentionally omitted <==**

with creep parameters _𝐴_ and _𝑛_ , as a surrogate model and we monitor the performance of the DMN every 50 epochs during training using this model. We evaluate the Norton law using the material parameters outlined in Table 8 for the pure matrix and identified in Dey et al. (2022, § 3.3). These material parameters are identified using the forward calibration workflow based on experiments on the pure matrix and are kept fixed for the inelastically-informed offline training. Although these parameters do not describe the creep behavior of the matrix with sufficient accuracy, they provide a cheap and easy-to-evaluate inelastic input to the linear training process. Furthermore, we introduce an error measure to evaluate the performance of the creep response of the DMN compared to FFT full-field simulations using the Norton model for the pure matrix in three different loading directions 0[◦] , 30[◦] and 90[◦] with respect to the flow direction, 

**==> picture [444 x 31] intentionally omitted <==**

17 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 8** 

Identified material parameters for the Norton-type model (4.8). Matrix Elastic _𝐸_ = 2399 _._ 3 MPa _𝜈_ = 0 _._ 4 Creep _𝐴_ = 0 _._ 014 MPa[−1] _𝑛_ = 27 _._ 0 _̇𝜀_ 0 = 1 _._ 0 s[−1] 

**==> picture [109 x 91] intentionally omitted <==**

**==> picture [247 x 91] intentionally omitted <==**

**Fig. 13.** Offline training results and evaluated inelastic error during training. 

**Table 9** 

|**Table 9**|||||||
|---|---|---|---|---|---|---|
|Results|of|online<br>evaluation|of|DMN|with|the|
|inelastically-informed offline training||||method.|||
|_𝑒𝑛_||Stored at epoch|_𝑒𝑝_||_𝑒𝑐_||
|2.35%||4150|4.34%||2.44%||



and the maximum errors 

**==> picture [444 x 12] intentionally omitted <==**

The creep response of the DMN using the Norton model was evaluated on a single voxel microstructure by an FFT-based solver (Schneider, 2020a). We prescribed 32 time steps, equally spaced on the logarithmic time scale. The full-field simulations were performed with the FFT-based solver (Schneider, 2020a) using the full microstructure defined in Section 4.1. 

In the 0[◦] direction, we apply a uni-axial tensile stress _̄𝜎_ 11 in the flow direction which is ramped up to 95 MPa in 8.5 s and subsequently held constant for 5 _._ 52 × 10[3] s. We evaluated the creep strain component _̄𝜀_ 11 in the flow direction over the entire simulation window. In the 0[◦] direction, we denote the evaluated strain by the symbol _̄𝜀_ 0◦ . We apply a lower uni-axial stress _̄𝜎_ 22 of 58 _._ 4 MPa until 4 _._ 48 × 10[2] s for the creep response in the 90[◦] direction. We evaluate the strain component _̄𝜀_ 22 during loading and refer to the results as _̄𝜀_ 90◦ . 

For the 30[◦] direction, we use a similar strategy incorporating mixed boundary conditions (Kabel et al., 2016) for a uni-axial tensile stress of 69 MPa, held constant up to 4 _._ 45 × 10[5] s. During the entire simulation time, we evaluated the creep strain component _̄𝜀_ 11, and refer to it as _̄𝜀_ 30◦ . 

The best DMN state is identified with the help of the best Norton error _𝑒[𝑛]_ in the entire training window, see Table 9. We refer to Dey et al. (2022, Alg. 1) for a more comprehensive overview of the training procedure. The evolution of the Norton error over the epochs during the training is shown in Fig. 13(c). We observe a rather high Norton error at the start of the training, especially in the 90[◦] direction, which oscillates and reaches a minimum at around epoch 4 000 before rising again. 

We validate the performance of the DMN in the online phase by using the best trained DMN state to evaluate both the elastoplastic and creep response using the fully coupled plasticity-creep law introduced in Section 2.3 for the matrix material. We follow Dey et al. (2022) and introduce the maximum relative elasto-plastic error _𝑒[𝑝]_ (Dey et al., 2022, eq.(3.9)) and the maximum relative creep error _𝑒[𝑐]_ (Dey et al., 2022, eq.(3.11)) to evaluate the elasto-plastic and full creep response, respectively. The best elasto-plastic and creep error evaluated using the best identified DMN state are given in Table 9. The comparison of the DMN and full-field results for the elasto-plastic and creep case is shown in Fig. 14 (for the directions having the maximum errors). The trained DMN yields relatively low errors for elasto-plasticity and creep below 5%. Therefore, we conclude that the trained DMN represents the inelastic response of the identified microstructure with a high fidelity when compared to full-field FFT simulations. It is to be noted that the runtime of the DMN online phase is below 30 s for both elasto-plasticity and creep when run on a single CPU on a computing node, whereas the FFT simulation run on a computing node with 24 CPUs and 4 GB of memory per CPU in a HPC cluster lasts on an average more than four hours for the identified microstructure. The comparison of the runtimes leads to an average speed-up factor of 600 (Dey et al., 2022), which enables us to use the trained DMN for the _inverse calibration_ workflow. 

18 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [421 x 206] intentionally omitted <==**

**Fig. 14.** Comparison of DMN and full-field simulation for elasto-plasticity and creep. 

## _4.3. Inverse calibration of the constitutive law_ 

## _4.3.1. Framework_ 

In the previous sections we identified the best microstructure realization based on elastic computations and used it to train a DMN which represents the inelastic behavior of the composite with a high fidelity. Thus, the first two essential ingredients for the _inverse calibration_ of the constitutive model of the matrix are available, see Fig. 1. In this section we use the trained DMN for a cheap evaluation of the complete micromechanical problem and attempt to isolate the material parameters of our constitutive law outlined in Section 2.3 based on a single set of experiments performed on the composite, see Section 2.2.2, thereby circumventing the resource and time-intensive _forward calibration_ workflow. Since we use the composite experiments, the process history during the manufacturing of the composite material is considered. 

An incremental two-step procedure similar to the forward calibration (Section 2.4.1) is applied for identifying the material parameters of the matrix material. All elasticity and plasticity parameters are initially identified based on a uni-axial tensile experiment performed on the composite with deactivated progression of the creep strains. The remaining creep parameters are determined using long-term creep experiments conducted at various load levels in a particular direction using the composite, in the second step of this incremental parameter identification method, with frozen elasticity and plasticity coefficients. 

## _4.3.2. Identification of elasticity and plasticity coefficients_ 

The elasticity and plasticity parameters are identified using the experiment performed on the composite in the 0[◦] loading direction, see Fig. 6. The optimization workflow is set up using the online phase of the DMN, implemented as a UMAT and evaluated on a single four-node unit tetrahedron element in Abaqus (Simulia, 2022). The Abaqus (Simulia, 2022) simulation is iteratively called in an OptiSlang procedure (Will (Dynardo GmbH), 2022) similar to the _forward calibration_ procedure, see Section 2.4.2. The difference in the _inverse calibration_ procedure is that instead of just evaluating the constitutive law of the matrix at the Gauss point, we evaluate the complete micromechanical problem using the DMN and find the effective response of the composite with the help of the trained DMN. The minimization problem consists of an objective function which minimizes the area under the curve between the composite experiment and the one obtained from the DMN simulation. The optimization is run with the two fixed matrix parameters, Poisson’s ratio _𝜈_ = 0 _._ 4 and the viscosity _𝜂_ = 0 _._ 001 MPa s, emulating strain-rate independence. The fiber parameters outlined in Table 3 are also kept fixed. The optimization procedure used is the same as in Section 2.4.2 using 300 samples and the best fitting parameters with respect to the composite experiment in the 0[◦] direction is recorded in Table 11 and the deviation in area between the experiment and simulation is 1.56%. These parameters are subsequently used to simulate the composite experiments in the 15[◦] , 30[◦] , 60[◦] and 90[◦] directions using the unit tetrahedron element, incorporating mixed boundary conditions (Kabel et al., 2016) and solving the DMN online phase at the Gauss point. The plots comparing the composite experiments and the simulations with the best fitting parameters is shown in Fig. 15. 

There is a remarkable agreement between the experiment and the simulations in the optimized 0[◦] -direction up to 2% strain. This comes as no surprise. The saturation of the experimental results above 2% strain is not well represented. This is expected, as the used material model does not account for softening effects. The predicted directions also show a good fit at lower strain ranges. The fit is worse after the saturation yield stress point. The overall fit of the predicted directions up to around 1.3% strain is rather good considering that the parameters were optimized using only the 0[◦] -direction composite experiments. The response is slightly underestimated above 1.3% strain level. 

19 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [331 x 198] intentionally omitted <==**

**Fig. 15.** Experimental and simulation results with best fitting parameters using _inverse calibration_ . 

**==> picture [421 x 112] intentionally omitted <==**

**Fig. 16.** Experimental and simulation results with best fitting parameters using 0[◦] direction experiments for _inverse calibration_ . 

## _4.3.3. Identification of creep coefficients_ 

The identification of the creep parameters is also performed in OptiSlang (Will (Dynardo GmbH), 2022), wrapping a unittetrahedron Abaqus (Simulia, 2022) simulation following the same workflow as in Section 4.3.2. The Abaqus (Simulia, 2022) simulation is furnished with the DMN at the Gauss point level, thus cheaply solving the micromechanical problem. The simulation is compared to the creep experiments performed on the composite in the 0[◦] -direction at various stress levels, see Fig. 7(a). The objective function used is defined in Eq. (2.13) with _𝑛_ Stresses = 3 and the approach used is similar to Section 2.4.3. During the optimization run, the previously identified elasticity and plasticity parameters, the fiber parameters outlined in Table 3 and the reference creep rate _̇𝜀_ 0 = 1 _._ 0 _𝑠_[−1] are kept fixed. 

The minimization problem using 300 samples is set up following Section 2.4.3. The best fitting parameters obtained using the least value of the global objective function (2.13) are given in Table 11. The local objective function (2.14) at each stress level is shown in Table 10 for the best fitting parameters not only for the optimized 0[◦] direction but also for the predicted 30[◦] and 90[◦] directions. The experimental creep curves at different stress levels are plotted against the best fitting simulation in the log time scale in Fig. 16(a). Furthermore, the best fitting parameters are used to simulate the composite experiments at different load levels in the 30[◦] and 90[◦] directions, see Figs. 16(b),16(c). 

In the 0[◦] direction the parameters identified using _inverse calibration_ capture the three creep phases rather well, and represent the three experimental results to a sufficient fidelity which is also evident from the values of the local objective function recorded in Table 10. The load application phase and the creep strains in the primary and secondary creep stages are slightly over-estimated in the 30[◦] direction leading to higher values of _𝑓𝑙𝑜𝑐𝑎𝑙_ , see Table 10. However, the final creep strain is remarkably well represented in all three stress levels. This may be due to the experimental procedure wherein the load level in the samples is first ramped up and then held constant. During the ramp-up, since most of the fibers are loaded at an angle of 30[◦] , the sample tends to move sideways 

20 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 10** 

_𝑓𝑙𝑜𝑐𝑎𝑙_ for different stress levels in all three directions for best fit creep parameters of matrix using composite experiments in 0[◦] direction for _inverse calibration_ . 

|direction f|or _inverse cal_|_ibration_.||||||||||
|---|---|---|---|---|---|---|---|---|---|---|---|
|Direction|0◦|||30◦|||||90◦|||
|Stress|77_._3 MPa|83_._0 MPa<br>95_._0 MPa||69_._0|MPa|72_._6 MPa||77_._0 MPa|35_._7 MPa|48_._7 MPa|58_._4 MPa|
|_𝑓𝑙𝑜𝑐𝑎𝑙_|3.4%|2.5%|1.3%|4.0%||7.3%||12.9%|14.7%|9.7%|6.6%|
||**Table 11**|||||||||||
||Material parameters for||pure matrix obtained||using _inverse calibration_ of constitutive law.|||||||
||Matrix|Elastic|_𝐸_= 2475_._0 MPa||_𝜈_= 0_._4|||||||
|||Plastic|_ℎ_= 4_._0 MPa||_𝜔_= 399_._2||_𝑦_0 = 24_._9 MPa|||_𝑦_∞= 37_._9 MPa||
|||Creep|_𝐴_1 = 0_._005 MPa−1||_𝑛_= 10_._15||_𝐴_2 = 2_._4 × 10−13||MPa−1|_𝐶_= 2583_._45||
||||_𝑘_= 0_._018||_̇𝜀_0 = 1_._0|s−1||||||



**==> picture [421 x 111] intentionally omitted <==**

**Fig. 17.** Experimental and simulation results with best fitting parameters using 30[◦] direction experiments for _inverse calibration_ . 

and slightly erroneous strains are recorded. Finally, in the 90[◦] direction, the load application and primary creep stages are captured with high fidelity. However, the creep strains are overestimated after the secondary creep stage for lower stress levels, especially for the stress level of 35 _._ 7 MPa, see Table 10. Nonetheless, the prediction in the 30[◦] and 90[◦] directions is quite good considering the anisotropy and time-scales involved. The improvement in the prediction of the composite response using the _inverse calibration_ workflow compared to the _forward calibration_ is outlined in Section 4.5. 

## _4.4. On the influence of loading directions_ 

In the previous section, we used the 0[◦] loading direction for the _inverse calibration_ of the constitutive model both for plasticity and for creep. Since the creep loading in every direction is performed over different stress levels within a wide range of time scales, we also investigate the influence of the loading directions on the inverse calibration framework. Another possibility would be to perform the _inverse calibration_ using experiments from every direction. However, that would require the manufacturing of test plates in each direction and performing experiments on it, thereby increasing the experimental burden. Overall, the goal would be to reduce the number of direction-dependent experiments performed on the composite. To this effect, we seek to isolate the best set of experiments in a particular direction that we can use for inversely identifying the material parameters of the matrix. We use a similar approach as outlined in Section 4.3.3. However, we set up two separate minimization problems where we optimize the simulation using the global objection function (2.13) with the experiments performed in the 30[◦] and 90[◦] directions, respectively. The best fitting parameters obtained from each optimization is used to simulate the experiments in the remaining loading directions. The results of the simulation with the best fitting parameters obtained from the respective minimization problems for 30[◦] and 90[◦] directions are visualized in Figs. 17 and 18, respectively. The results are also quantitatively illustrated in Tables 12 and 13, where the _𝑓𝑙𝑜𝑐𝑎𝑙_ is recorded for the optimized and predicted directions using the best fitting parameters obtained from the optimization using the 30[◦] and 90[◦] directions, respectively. 

We observe that the strain during the load application and primary stage of creep is overestimated for the _inverse calibration_ using the 30[◦] experiments, see Fig. 17(b), similar to the simulations using the 0[◦] experiments, see Fig. 16(b). However, the value of _𝑓𝑙𝑜𝑐𝑎𝑙_ in the 30[◦] direction is below 5%, see Table 12. As indicated in Section 4.3.3 this effect may be caused by the experimental procedure, wherein we cannot find a good fit for our constitutive law with the 30[◦] experiments. Furthermore, the same parameters when used to simulate the 0[◦] experiments, underestimates the creep strain at the end of creep, see Fig. 17(a). The creep strain in the primary and secondary creep stages at lower stress levels in the 90[◦] directions are well represented, see Fig. 17(c). However, 

21 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 12** 

_𝑓𝑙𝑜𝑐𝑎𝑙_ for different stress levels in all three directions for best fit creep parameters of matrix using composite experiments in 30[◦] direction for _inverse calibration_ . 

|direction for|_inverse calib_|_ration_.||||||||
|---|---|---|---|---|---|---|---|---|---|
|Direction|0◦|||30◦|||90◦|||
|Stress|77_._3 MPa|83_._0 MPa|95_._0 MPa|69_._0 MPa|72_._6 MPa|77_._0 MPa|35_._7 MPa|48_._7 MPa|58_._4 MPa|
|_𝑓𝑙𝑜𝑐𝑎𝑙_|4.8%|10.6%|7.1%|4.4%|4.1%|3.9%|8.4%|1.8%|11.6%|



**==> picture [421 x 112] intentionally omitted <==**

**Fig. 18.** Experimental and simulation results with best fitting parameters using 90[◦] direction experiments for _inverse calibration_ . 

## **Table 13** 

_𝑓𝑙𝑜𝑐𝑎𝑙_ for different stress levels in all three directions for best fit creep parameters of matrix using composite experiments in 90[◦] direction for _inverse calibration_ . 

|direction for|_inverse calib_|_ration_.||||||||
|---|---|---|---|---|---|---|---|---|---|
|Direction|0◦|||30◦|||90◦|||
|Stress|77_._3 MPa|83_._0 MPa|95_._0 MPa|69_._0 MPa|72_._6 MPa|77_._0 MPa|35_._7 MPa|48_._7 MPa|58_._4 MPa|
|_𝑓𝑙𝑜𝑐𝑎𝑙_|6.0%|9.5%|2.4%|5.1%|6.8%|8.2%|3.7%|1.0%|5.2%|



the highest stress level could not be well extrapolated which is reflected in the value of _𝑓𝑙𝑜𝑐𝑎𝑙_ for the stress level of 58 _._ 4 MPa, see Table 12. 

The best fitting parameters obtained using the 90[◦] experiments can represent all stress levels to a sufficient fidelity both in the 90[◦] as well as in the 0[◦] directions, see Figs. 18(a) and 18(c), respectively. The creep strains at end of the secondary creep stage for the lower stress levels are underestimated in the 0[◦] direction, see Fig. 18(a). Nevertheless, we have a better fidelity compared to the simulations using best fitting parameters obtained from the optimization using the 30[◦] experiments especially in the 0[◦] and 90[◦] directions, see Tables 12 and 13. Therefore, we conclude that the _inverse calibration_ of the constitutive model may be performed with the experimental results having the highest confidence when we have multiple experiments available. In our case, we choose the experiments performed in the 0[◦] direction for identifying the matrix parameters which are listed in Table 11 since it gives an overall good fit for other directions too. Moreover, the calibration using the experiments in a particular direction gives us the best results in different load levels in the same direction. This comes as no surprise. Nevertheless, the best fitting parameters can predict the simulative results at a range of stress levels in different directions with good accuracy. 

## _4.5. Comparison between forward and inverse calibration of constitutive model_ 

Last but not least, we compare the performance of the _inverse calibration_ of our fully coupled plasticity-creep model (Section 2.3) with the current state of the art _forward calibration_ technique for an industrial-scale microstructure realization identified in Section 4.1. We perform full-field FFT simulations for plasticity and creep using the software FeelMath (Kabel (Fraunhofer ITWM), 2022) and assign the elasticity, plasticity and creep parameters identified using the pure matrix experiments outlined in Table 3 to the matrix material for the _forward calibration_ . Instead of performing FFT simulations, the DMN online phase is used for the _inverse calibration_ where we use the material parameters outlined in Table 11 for the matrix material. The fibers are assigned a linear elastic material law in both cases, using the parameters from Table 3. We also perform DMN simulations using the reduced geometrical representation of the microstructure for the _forward calibration_ and compare all simulated results with the experiments performed on the complex composite (Section 2.2.2). The elasto-plastic response using both sets of material parameters is shown in Fig. 19. There is a strong difference in the composite response using the parameters from the _forward calibration_ workflow and the experimental results. The DMN simulation in Fig. 19(a) closely matches the FFT results. In the elastic phase we observe that there is a good agreement. Thereafter, the stresses in the plastic region are severely overestimated. It is to be noted that the model fitted the monotonic testing results of the pure matrix material quite well, see Fig. 8(a). If we take a look at the identified parameters in Tables 3 and 11 we see that the hardening parameter _ℎ_ shows a large difference. Moreover, the saturation yield stress _𝑦_ ∞ identified 

22 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [435 x 224] intentionally omitted <==**

**Fig. 19.** Experimental and simulation results with best fitting parameters for elasto-plastic loading. 

using the _inverse calibration_ is almost 1.5 times smaller than the forward calibrated model. On the other hand, the elasto-plastic response matches the experimental results to a sufficient fidelity for the inversely calibrated model, see Fig. 19(b). If the _inverse calibration_ framework were not available the next probable course of action would be to perform more time and resource consuming loading and unloading experiments for the pure matrix (instead of monotonic testing) for better characterizing the elasto-plastic response, especially the saturation yield stress _𝑦_ ∞. 

A similar comparison is performed for the creep loading in a range of load levels in three different directions depicted in Fig. 20. In addition to the experimental mean values of creep strains plotted in Section 2.2.2, we plot the range of strains obtained from all the samples at every stress level in each direction (highlighted in addition to the mean values in Fig. 20). This indicates the deviation in the experimental procedure for the different samples loaded under the same conditions and allows us to better compare the simulative results with the experimental results. We observe that the forward calibrated matrix model represents the load application and the primary creep stage with sufficient fidelity, especially for the lower load levels. We have a worse agreement for the onset of the secondary creep stage and beyond. It is worthwhile to note that the constitutive model can represent the entire creep range for the pure matrix with a good accuracy, see Fig. 8(b). The DMN and FFT results also match closely for smaller strains and show slight deviation at higher strains. The inversely calibrated model models the entire creep behavior with better accuracy. The primary stage in the 30[◦] direction and the final creep strains in the 90[◦] direction is slightly overestimated when considering the entire band of creep strain measurements, see Figs. 20(d) and 20(f). Nevertheless, the overall creep response is well represented considering the range of stresses and time scales involved. 

In the absence of the _inverse calibration_ workflow, a possible remedy to better model the creep response in the secondary stage would be to introduce an additional damage parameter during modeling the matrix material to speed-up the creep strain evolution. We would need additional experiments on the pure matrix to characterize the damage and then compare the composite response. This extra effort is elegantly side-stepped with the help of the inverse calibration workflow using DMNs. Thus, it is clear that the multi-scale simulations using material parameters from the pure matrix experiments does not fully capture the final composite behavior due to the change in the matrix properties during the manufacturing process. The DMN simulation unlocks the potential for identification of material parameters directly from the composite experiments. 

The different steps involved in both the _forward_ and _inverse_ calibration along with the computations performed, hardware used and the computation times were summarized in Table 14. All the simulations were performed on a HPC cluster. Please note that although the data generation and training time for the DMN constitutes a large fraction of the total computation time in the _inverse_ calibration workflow, they represent a one-time procedure. Once the DMN is trained, we can, in principle, use the trained DMN for the _inverse calibration_ of any constitutive law of GSM-type attached to its constituents. The parameter optimization process can also be repeated any number of times for further refinement. This is certainly not the case in the _forward calibration_ workflow where all the steps need to be repeated for further refinement or for a different constitutive law. 

## **5. Conclusion** 

The deep material network framework introduced by Liu and coworkers (Liu et al., 2019; Liu and Wu, 2019) opened up a vast array of opportunities to model the inelastic response of the composite for different design tasks by providing a fast yet remarkably 

23 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

**==> picture [379 x 326] intentionally omitted <==**

**==> picture [379 x 185] intentionally omitted <==**

**Fig. 20.** Experimental and simulation results with best fitting parameters for creep loading. 

accurate surrogate model of the microstructure, thereby effectively decoupling the material response of the constituents from the microstructural arrangement. The DMN framework has evolved into different variants tailored to solve the forward problem, i.e., find the overall composite response while having, at hand, the constitutive model for the individual phases of the composite, for different industrially-relevant material classes. Thereafter, the overall material response is validated with the help of experiments performed on the composite. 

24 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **Table 14** 

Summary of the steps involved in the _forward_ and _inverse_ calibration including the hardware used and the computation times. 

|Calibration|Steps|Computations|Hardware|Runtime|
|---|---|---|---|---|
||**Optimization**: Elasticity and|300 Abaqus unit cube simulations|Single node with 2 CPUs, 1 GB|1.8 h|
|_Forward_|plasticity parameters<br>**Optimization**: Creep parameters|3 × 300 Abaqus unit cube|memory per CPU<br>3 nodes in parallel with 2 CPUs|5.3 h|
||for 3 load levels|simulations|each, 4 GB memory per CPU||
||**Validation**: Elasto-plastic loading,|5 FFT simulations|Single node with 24 CPUs, 4 GB|22.8 h|
||5 directions||memory per CPU||
||**Validation**: Creep loading, 3|3 × 3 FFT simulations|Single node with 24 CPUs, 4 GB|60.8 h|
||directions, 3 load levels each||memory per CPU||
||**Data generation** for DMN|1000 elastic FFT simulations|14 nodes in parallel with 24 CPUs|62.1 h|
|_Inverse_|**Training** the DMN|PyTorch (Paszke et al., 2017)|each, 4 GB memory per CPU<br>Single node with single CPU, 60|11.3 h|
||||GB memory per CPU||
||**Optimization**: Elasticity and|300 Abaqus unit tetrahedron|Single node with 2 CPUs, 1 GB|6.1 h|
||plasticity parameters|simulations|memory per CPU||
||**Optimization**: Creep parameters|3 × 300 Abaqus unit tetrahedron|3 nodes in parallel with 2 CPUs|7.6 h|
||for 3 load levels|simulations|each, 1 GB memory per CPU||



In this work, we used the DMN framework for solving the inverse problem, wherein we identified the parameters for the constitutive model (in our case, a fully coupled plasticity-creep law) of the polymer matrix by experiments performed on the composite. We showed that such an approach is able to accurately identify the material parameters from the composite experiments and to represent the anisotropic response of the composite with sufficient fidelity. Such an approach using traditional FFT computations would be a formidable task due to the high runtime of full-field simulations when compared to DMN simulations. We also critically discuss the essential ingredients necessary for the _inverse calibration_ of any two-phase composite, which includes an accurate virtual representation of the microstructure involved and a set of reliable experiments performed using the composite. In the absence of these essential ingredients the _inverse calibration_ may lead to less accurate results. Therefore, as a further step the DMN framework may be extended to capture the uncertainties in the microstructure (Huang et al., 2022; Fernandez-Zelaia et al., 2022), as well. Moreover, considering failure (Schneider, 2020b; Ernesti and Schneider, 2021, 2022) or fatigue (Köbler et al., 2021; Magino et al., 2022a,b) prediction and inversely calibrating these constitutive laws may be worth the effort. 

Nevertheless, the _inverse calibration_ workflow using DMNs provides an accurate and low-cost alternative to experimental characterization of the constitutive model of the constituents of an industrially relevant SFRT. Apart from reducing the experimental effort, this workflow enables the rapid development of a variety of inelastic constitutive laws for materials used for running concurrent multiscale simulations on an industrial scale. 

## **CRediT authorship contribution statement** 

**Argha Protim Dey:** Methodology, Software, Formal analysis, Investigation, Validation, Visualization, Writing – original draft. **Fabian Welschinger:** Conceptualization, Methodology, Software, Evaluation of experiments, Project administration, Supervision, Writing – review & editing. **Matti Schneider:** Conceptualization, Methodology, Project administration, Supervision, Writing – review & editing. **Sebastian Gajek:** Conceptualization, Methodology, Writing – review & editing. **Thomas Böhlke:** Conceptualization, Formal analysis, Supervision, Writing – review & editing. 

## **Declaration of competing interest** 

The authors declare that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper. 

## **Data availability** 

The data that has been used is confidential. 

## **Acknowledgments** 

MS, SG and TB gratefully acknowledge support by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) - project 255730231. We thank Thomas Riedel for performing the _𝜇_ CT scans of the composite. We would also like to thank Benjamin Schneider for carrying out and post-processing the experiments as well as for stimulating discussions on the experimental procedure. We thank the anonymous reviewers for their detailed remarks which significantly improved the presentation of the manuscript. 

25 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

## **References** 

Abueidda, D.W., Koric, S., Sobh, N.A., Sehitoglu, H., 2021. Deep learning for plasticity and thermo-viscoplasticity. Int. J. Plast. 136, 102852. Al-Haik, M., Hussaini, M., Garmestani, H., 2006. Prediction of nonlinear viscoelastic behavior of polymeric composites using an artificial neural network. Int. J. Plast. 22 (7), 1367–1392. 

Anderson, E., Bai, Z., Bischof, C., Blackford, S., Demmel, J., Dongarra, J., Du Croz, J., Greenbaum, A., Hammarling, S., McKenney, A., Sorensen, D., 1999. LAPACK Users’ Guide, third ed. Society for Industrial and Applied Mathematics, Philadelphia, PA. Andrade, E.N.D.C., 1910. On the Viscous Flow in Metals, and Allied Phenomena. Proc. R. Soc. London. Ser. A, Containing Pap. A Math. Phys. Character 84 (567), 1–12. Becker, F., 2009. Entwicklung einer Beschreibungsmethodik für das mechanische Verhalten unverstärkter Thermoplaste bei hohen Deformationsgeschwindigkeiten (Ph.D. thesis). Martin-Luther University Halle-Wittenberg. Benveniste, Y., 1987. A new approach to the application of Mori-Tanaka’s theory in composite materials. Mech. Mater. 6 (2), 147–157. Böhlke, T., Brüggemann, C., 2001. Graphical representation of the generalized Hooke’s law. Techn. Mech. 21 (2), 145–158. Brisard, S., Dormieux, L., 2010. FFT-based methods for the mechanics of composites: A general variational framework. Comput. Mater. Sci. 49 (3), 663–671. Charière, R., Marano, A., Gxélébart, L., 2020. Use of composite voxels in FFT based elastic simulations of hollow glass microspheres/polypropylene composites. Int. J. Solids Struct. 182–183, 1–14. Dargazany, R., Khiêm, V.N., Poshtan, E.A., Itskov, M., 2014. Constitutive modeling of strain-induced crystallization in filled rubbers. Phys. Rev. E 89 (2), 022604. Dey, A.P., Welschinger, F., Schneider, M., Gajek, S., Böhlke, T., 2022. Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelastically-informed strategy. Arch. Appl. Mech. 92, 2733–2755. Doghri, I., Brassart, L., Adam, L., Gérard, J.-S., 2011. A second-moment incremental formulation for the mean-field homogenization of elasto-plastic composites. Int. J. Plast. 27 (3), 352–371. Eisenlohr, P., Diehl, M., Lebensohn, R.A., Roters, F., 2013. A spectral method solution to crystal elasto-viscoplasticity at finite strains. Int. J. Plast. 46, 37–53. Ernesti, F., Schneider, M., 2021. A fast Fourier transform based method for computing the effective crack energy of a heterogeneous material on a combinatorially consistent grid. Internat. J. Numer. Methods Engrg. 122, 6283–6307. Ernesti, F., Schneider, M., 2022. Computing the effective crack energy of heterogeneous and anisotropic microstructures via anisotropic minimal surfaces. Comput. Mech. 69, 45–57. Eyre, D.J., Milton, G.W., 1999. A fast numerical scheme for computing the response of composites using grid refinement. Eur. Phys. J.-Appl. Phys. 6 (1), 41–47. Felder, S., Holthusen, H., Hesseler, S., Pohlkemper, F., Gries, T., Simon, J.-W., Reese, S., 2020. Incorporating crystallinity distributions into a thermo-mechanically coupled constitutive model for semi-crystalline polymers. Int. J. Plast. 135, 102751. Fernandez-Zelaia, P., Lee, Y., Dryepondt, S., Kirka, M.M., 2022. Creep anisotropy modeling and uncertainty quantification of an additively manufactured Ni-based superalloy. Int. J. Plast. 151, 103177. Fritzen, F., Böhlke, T., 2011. Nonuniform transformation field analysis of materials with morphological anisotropy. Compos. Sci. Technol. 71 (4), 433–442. Gajek, S., Schneider, M., Böhlke, T., 2020. On the micromechanics of deep material networks. J. Mech. Phys. Solids 142, 103984. Gajek, S., Schneider, M., Böhlke, T., 2021. An FE-DMN method for the multiscale analysis of short fiber reinforced plastic components. Comput. Methods Appl. Mech. Engrg. 384, 113952. Gajek, S., Schneider, M., Böhlke, T., 2022. An FE-DMN method for the multiscale analysis of thermodynamical composites. Comput. Mech. 69, 1087–1113. Garcea, S., Wang, Y., Withers, P., 2018. X-ray computed tomography of polymer composites. Compos. Sci. Technol. 156, 305–319. Goodfellow, I., Bengio, Y., Courville, A., 2016. Deep Learning. MIT Press, Cambridge. Gorash, Y., Altenbach, H., Naumenko, K., 2008. Modeling of primary and secondary creep for a wide stress range: Creep for a wide stress range. Proc. Appl. Math. Mech. 8 (1), 10207–10208. Grédiac, M., Pierron, F., 2006. Applying the virtual fields method to the identification of elasto-plastic constitutive parameters. Int. J. Plast. 22 (4), 602–627. Halphen, N., Nguyen, Q., 1975. Sur les Matériaux standards generalisés. J. Méc. 14, 508–520. Harth, T., Schwan, S., Lehn, J., Kollmann, F., 2004. Identification of material parameters for inelastic constitutive models: Statistical analysis and design of experiments. Int. J. Plast. 20 (8–9), 1403–1440. Herrera-Solaz, V., LLorca, J., Dogan, E., Karaman, I., Segurado, J., 2014. An inverse optimization strategy to determine single crystal mechanical behavior from polycrystal tests: Application to AZ31 Mg alloy. Int. J. Plast. 57, 1–15. Hessman, P.A., Riedel, T., Welschinger, F., Hornberger, K., Böhlke, T., 2019. Microstructural analysis of short glass fiber reinforced thermoplastics based on X-ray micro-computed tomography. Compos. Sci. Technol. 183, 107752. Hill, R., 1963. Elastic properties of reinforced solids: Some theoretical principles. J. Mech. Phys. Solids 11 (5), 357–372. Huang, T., Liu, Z., Wu, C., Chen, W., 2022. Microstructure-guided deep material network for rapid nonlinear material modeling and uncertainty quantification. Comput. Methods Appl. Mech. Engrg. 398, 115197. Jadid, M.N., 1997. Prediction of stress-strain relationships for reinforced concrete sections by implementing neural network techniques. J. King Saud Univ., Eng. Sci. 9 (2), 169–188. Jang, D.P., Fazily, P., Yoon, J.W., 2021. Machine learning-based constitutive model for J2-plasticity. Int. J. Plast. 138, 102919. Kabel, M., Fink, A., Schneider, M., 2017. The composite voxel technique for inelastic problems. Comput. Methods Appl. Mech. Engrg. 322, 396–418. Kabel, M., Fliegener, S., Schneider, M., 2016. Mixed boundary conditions for FFT-based homogenization at finite strains. Comput. Mech. 57 (2), 193–210. Kabel, M., Merkert, D., Schneider, M., 2015. Use of composite voxels in FFT-based homogenization. Comput. Methods Appl. Mech. Engrg. 294, 168–188. Kabel (Fraunhofer ITWM), M., 2022. FeelMath – Mechanical and Thermal Properties of Microstructures. URL https://www.itwm.fraunhofer.de/en/departments/ sms/products-services/feelmath.html. (Accessed 08 July 2022). Kim, S.K., Jeong, A., 2019. Numerical simulation of crystal growth in injection molded thermoplastics based on Monte Carlo method with shear rate tracking. Int. J. Precis. Eng. Manuf. 20 (4), 641–650. Köbler, J., Magino, N., Andrä, H., Welschinger, F., Müller, R., Schneider, M., 2021. A computational multi-scale model for the stiffness degradation of short-fiber reinforced plastics subjected to fatigue loading. Comput. Methods Appl. Mech. Engrg. 373, 113522. Kostenko, Y., Naumenko, K., 2007. Power plant component design using creep and fatigue damage analysis. In: Proceedings of the 5th Australasian Congress on Applied Mechanics. pp. 89–94. Kugler, S.K., Kech, A., Cruz, C., Osswald, T., 2020. Fiber orientation predictions - A review of existing models. J. Compos. Sci. 4 (2), 69. 

Kuhn, J., Spitz, J., Sonnweber-Ribic, P., Schneider, M., Böhlke, T., 2022. Identifying material parameters in crystal plasticity by Bayesian optimization. Opt. Eng. 23 (3), 1489–1523. 

Le, B., Yvonnet, J., He, Q.-C., 2015. Computational homogenization of nonlinear elastic materials using neural networks. Internat. J. Numer. Methods Engrg. 104 (12), 1061–1084. 

Liu, Z., 2020. Deep material network with cohesive layers: Multi-stage training and interfacial failure analysis. Comput. Methods Appl. Mech. Engrg. 363, 112913. Liu, Z., 2021. Cell division in deep material networks applied to multiscale strain localization modeling. Comput. Methods Appl. Mech. Engrg. 384, 113914. Liu, Z., Wei, H., Huang, T., Wu, C., 2020. Intelligent multiscale simulation based on process-guided composite database. arXiv preprint arXiv:2003.09491. Liu, Z., Wu, C., 2019. Exploring the 3D architectures of deep material network in data-driven multiscale mechanics. J. Mech. Phys. Solids 127, 20–46. 

26 

_International Journal of Plasticity 160 (2023) 103484_ 

_A.P. Dey et al._ 

Liu, Z., Wu, C., Koishi, M., 2019. A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. Comput. Methods Appl. Mech. Engrg. 345, 1138–1168. 

Loshchilov, I., Hutter, F., 2017. SGDR: Stochastic gradient descent with warm restarts. arXiv:1608.03983 [cs, math]. 

Magino, N., Köbler, J., Andrä, H., Welschinger, F., Müller, R., Schneider, M., 2022a. A multiscale high-cycle fatigue-damage model for the stiffness degradation of fiber-reinforced materials based on a mixed variational framework. Comput. Methods Appl. Mech. Engrg. 388, 114198. 

Magino, N., Köbler, J., Andrä, H., Welschinger, F., Müller, R., Schneider, M., 2022b. A space-time upscaling technique for modeling high-cycle fatigue-damage of short-fiber reinforced composites. Compos. Sci. Technol. 233, 109340. 

McKay, M.D., Beckman, R.J., Conover, W.J., 2000. A comparison of three methods for selecting values of input variables in the analysis of output from a computer code. Technometrics 42 (1), 55–61. 

Meyer, N., Gajek, S., Görthofer, J., Hrymak, A., Kärger, L., Henning, F., Schneider, M., Böhlke, T., 2023. A probabilistic virtual process chain to quantify process-induced uncertainties in sheet molding compounds. Composites B 249, 110380. 

Michel, J.-C., Suquet, P., 2003. Nonuniform transformation field analysis. Int. J. Solids Struct. 40 (25), 6937–6955. Milton, G.W., 2002. The Theory of Composites. Cambridge University Press, Cambridge. 

Minh Nguyen-Thanh, V., Trong Khiem Nguyen, L., Rabczuk, T., Zhuang, X., 2020. A surrogate model for computational homogenization of elastostatics at finite strain using high-dimensional model representation-based neural network. Internat. J. Numer. Methods Engrg. 121 (21), 4811–4842. Montgomery-Smith, S., He, W., Jack, D., Smith, D., 2011a. Exact tensor closures for the three-dimensional Jeffery’s equation. J. Fluid Mech. 680, 321–335. Montgomery-Smith, S., Jack, D., Smith, D.E., 2011b. The Fast Exact Closure for Jeffery’s equation with diffusion. J. Non-Newton. Fluid Mech. 166, 343–353. Mori, T., Tanaka, K., 1973. Average stress in matrix and average elastic energy of materials with misfitting inclusions. Acta Metall. 21 (5), 571–574. Moulinec, H., Suquet, P., 1998. A numerical method for computing the overall response of nonlinear composites with complex microstructure. Comput. Methods Appl. Mech. Engrg. 157 (1–2), 69–94. 

Müller, V., Böhlke, T., 2016. Prediction of effective elastic properties of fiber reinforced composites using fiber orientation tensors. Compos. Sci. Technol. 130, 36–45. 

Naumenko, K., Altenbach, H., 2007. In: Babitsky, V.I., Wittenburg, J. (Eds.), Modeling of Creep for Structural Analysis. In: Foundations of Engineering Mechanics, Springer Berlin Heidelberg, Berlin, Heidelberg. Nguyen, V.D., Noels, L., 2022a. Interaction-based material network: A general framework for (porous) microstructured materials. Comput. Methods Appl. Mech. Engrg. 389, 114300. 

Nguyen, V.D., Noels, L., 2022b. Micromechanics-based material networks revisited from the interaction viewpoint; Robust and efficient implementation for multi-phase composites. Eur. J. Mech. A Solids 91, 104384. 

Pan, H., Wang, X., Jia, S., Lu, Z., Bian, J., Yang, H., Han, L., Zhang, H., 2021. Fiber-induced crystallization in polymer composites: A comparative study on poly (lactic acid) composites filled with basalt fiber and fiber powder. Int. J. Biol. Macromol. 183, 45–54. Pantani, R., Coccorullo, I., Speranza, V., Titomanlio, G., 2005. Modeling of morphology evolution in the injection molding process of thermoplastic polymers. Prog. Polym. Sci. 30 (12), 1185–1222. 

Papanicolaou, G., Zaoutsos, S., 2019. Viscoelastic constitutive modeling of creep and stress relaxation in polymers and polymer matrix composites. In: Creep and Fatigue in Polymer Matrix Composites. pp. 3–59. Paszke, A., Gross, S., Chintala, S., Chanan, G., Yang, E., DeVito, Z., Lin, Z., Desmaison, A., Antiga, L., Lerer, A., 2017. Automatic differentiation in PyTorch. In: NIPS Autodiff Workshop. p. 4. Penumadu, D., Zhao, R., 1999. Triaxial compression behavior of sand and gravel using artificial neural networks (ANN). Comput. Geotech. 24 (3), 207–230. Reddi, S.J., Kale, S., Kumar, S., 2019. On the convergence of Adam and beyond. arXiv:1904.09237 [cs, math, stat]. 

Robb, K., Wirjadi, O., Schladitz, K., 2007. Fiber orientation estimation from 3D image data: Practical algorithms, visualization, and interpretation. In: 7th International Conference on Hybrid Intelligent Systems. HIS 2007, IEEE, pp. 320–325. Schemmann, M., Brylka, B., Gajek, S., Böhlke, T., 2015. Parameter identification by inverse modelling of biaxial tensile tests for discontinous fiber reinforced polymers. Proc. Appl. Math. Mech. 15 (1), 355–356. Schemmann, M., Gajek, S., Böhlke, T., 2018. Biaxial tensile tests and microstructure-based inverse parameter identification of inhomogeneous SMC composites. In: Advances in Mechanics of Materials and Structural Analysis. Springer, pp. 329–342. Schneider, M., 2017. The sequential addition and migration method to generate representative volume elements for the homogenization of short fiber reinforced plastics. Comput. Mech. 59, 247–263. Schneider, M., 2020a. A dynamical view of nonlinear conjugate gradient methods with applications to FFT-based computational micromechanics. Comput. Mech. 66 (1), 239–257. Schneider, M., 2020b. An FFT-based method for computing weighted minimal surfaces in microstructures with applications to the computational homogenization of brittle fracture. Internat. J. Numer. Methods Engrg. 121, 1367–1387. Schneider, M., 2021. On non-stationary polarization methods in FFT-based computational micromechanics. Internat. J. Numer. Methods Engrg. 122 (22), 6800–6821. Schneider, M., Ospald, F., Kabel, M., 2016. Computational homogenization of elasticity on a staggered grid. Internat. J. Numer. Methods Engrg. 105 (9), 693–720. Settgast, C., Hütter, G., Kuna, M., Abendroth, M., 2020. A hybrid approach to simulate the homogenized irreversible elastic–plastic deformations and damage of foams by neural networks. Int. J. Plast. 126, 102624. Shen, Y., Chandrashekhara, K., Breig, W., Oliver, L., 2004a. Neural network based constitutive model for rubber material. Rubber Chem. Technol. 77 (2), 257–277. Shen, H., Nutt, S., Hull, D., 2004b. Direct observation and measurement of fiber architecture in short fiber-polymer composite foam through micro-CT imaging. Compos. Sci. Technol. 64 (13–14), 2113–2120. 

Simo, J.C., Hughes, T.J.R., 1998. Computational Inelasticity. Springer, New York. 

Simulia, 2022. Abaqus CAE. URL https://www.3ds.com/products-services/simulia/products/abaqus/abaquscae/. (Accessed 08 August 2022). 

Spahn, J., Andrä, H., Kabel, M., Müller, R., 2014. A multiscale approach for modeling progressive damage of composite materials using fast Fourier transforms. Comput. Methods Appl. Mech. Engrg. 268, 871–883. Spina, R., Spekowius, M., Hopmann, C., 2018. Simulation of crystallization of isotactic polypropylene with different shear regimes. Thermochim. Acta 659, 44–54. Srinivasu, G., Rao, R., Nandy, T., Bhattacharjee, A., 2012. Artificial neural network approach for prediction of titanium alloy stress-strain curve. Procedia Eng. 38, 3709–3714. 

Synopsys Simpleware ™, 2021. ScanIP. URL https://www.synopsys.com/simpleware/software/scanip.html. (Accessed 24 June 2021). 

Welschinger, F., Köbler, J., Andrä, H., Müller, R., Schneider, M., Staub, S., 2019. Efficient multiscale methods for viscoelasticity and fatigue of short fiber-reinforced polymers. In: Key Engineering Materials. 809, Trans Tech Publ, pp. 473–479. 

Will, J., Most, T., 2009. Metamodel of optimized prognosis (MoP)-an automatic approach for user friendly parameter optimization. Weimarer Optimierungs-Und Stoch. 6. 

Will (Dynardo GmbH), J., 2022. optiSLang - Robust design optimization(RDO) – key technology for resource-efficient product development and performance enhancement. URL https://www.ansys.com/de-de/products/platform/ansys-optislang. (Accessed 10 August 2022). 

Willis, J.R., 1981. Variational and related methods for the overall properties of composites. In: Advances in Applied Mechanics, vol. 21, pp. 1–78. Wulfinghoff, S., Cavaliere, F., Reese, S., 2018. Model order reduction of nonlinear homogenization problems using a Hashin-Shtrikman type finite element method. Comput. Methods Appl. Mech. Engrg. 330, 149–179. 

27 

_International Journal of Plasticity 160 (2023) 103484_ 

## _A.P. Dey et al._ 

Yoshida, F., Urabe, M., Hino, R., Toropov, V., 2003. Inverse approach to identification of material parameters of cyclic elasto-plasticity for component layers of a bimetallic sheet. Int. J. Plast. 19 (12), 2149–2170. 

Yun, G.J., Shang, S., 2011. A self-optimizing inverse analysis method for estimation of cyclic elasto-plasticity model parameters. Int. J. Plast. 27 (4), 576–595. 

Zeman, J., Vondřejc, J., Novák, J., Marek, I., 2010. Accelerating a FFT-based solver for numerical homogenization of periodic media by conjugate gradients. J. Comput. Phys. 229 (21), 8065–8071. 

Zhang, M.C., Guo, B.-H., Xu, J., 2016. A review on polymer crystallization theories. Crystals 7 (1), 4. 

Zhang, A., Mohr, D., 2020. Using neural networks to represent von Mises plasticity with isotropic hardening. Int. J. Plast. 132, 102732. 

28 

