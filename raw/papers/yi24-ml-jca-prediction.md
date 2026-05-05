---
title: "A machine learning approach for predicting the Johnson-Champoux-Allard parameters of a fibrous porous material"
authors: ["Wei Yi, Jingwen Guo, Teng Zhou, Hanbo Jiang, Yi Fang"]
year: 2024
source: paper
journal: "Applied Acoustics, 220, 109966 — DOI: 10.1016/j.apacoust.2024.109966"
ingested: 2026-05-05
sha256: 95c37e4932ae87451149afb460a0615d78c4991834a7d8f49999f1b4fd88c92a
conversion: pymupdf4llm
---

Applied Acoustics 220 (2024) 109966 

**==> picture [60 x 66] intentionally omitted <==**

Contents lists available at ScienceDirect 

## Applied Acoustics 

journal homepage: www.elsevier.com/locate/apacoust 

**==> picture [58 x 72] intentionally omitted <==**

## A machine learning approach for predicting the Johnson-Champoux-Allard parameters of a fibrous porous material 

**==> picture [29 x 30] intentionally omitted <==**

## Wei Yi[a] , Jingwen Guo[b] _[,]_[∗] , Teng Zhou[c] , Hanbo Jiang[d] , Yi Fang[a] 

> a _BYD Auto Industry Co., Ltd., Shenzhen 518118, China_ 

> b _Key Laboratory of Noise and Vibration Research, Institute of Acoustics, Chinese Academy of Sciences, Beijing 100190, China_ 

> c _Institute of Sound and Vibration Research, University of Southampton, Southampton, SO17 1BJ, United Kingdom_ 

> d _Ningbo Key Laboratory of Advanced Manufacturing Simulation, Eastern Institute of Technology, Ningbo, Zhejiang 315200, China_ 

A R T I C L E I N F O A B S T R A C T _Keywords:_ Porous fibrous materials have been widely used as acoustic treatments for noise attenuation. Their acoustic Porous materials properties are typically characterized by Johnson-Champoux-Allard (JCA) model, which includes five dominant Machine learning parameters, i.e., open porosity, flow resistivity, tortuosity, viscous characteristic length, and thermal characteristic DeepJCA parametersneural networkprediction length. The JCA parameters depend on the microstructure configuration of the material, which can be attained by experimental measurements or numerically analyzing the flow field inside the microstructure, but significant efforts to predict the parameters are typically required. This study proposes a machine learning approach based on an artificial neural network (ANN) for predicting the JCA parameters of a fibrous material. Two geometric parameters that can characterize the fibrous material, i.e., the radius of the fiber and the equivalent throat size between neighbouring fibers, are set as inputs for the prediction model, while the five JCA parameters are set as outputs. The datasets for the network are prepared from finite element simulations. Results confirm that the trained model can predict the JCA parameters accurately and reliably based on the micro-structural geometric parameters. Finally, the model is further validated by the measured acoustic characteristics of a metal-based fibrous material in an impedance tube. The machine learning model opens up possibilities to facilitate the design of advanced porous materials. 

## **1. Introduction** 

Porous fibrous materials usually consist of a solid framework containing a network of pores [1–3]. They have been widely employed in numerous automotive and aeronautic applications for noise attenuation, especially in medium- and high-frequency ranges [4–8]. The underlying mechanism of noise absorption is that the thermal loss caused by the vibration of air within the pores leads to the dissipation of sound energy when sound waves propagate inside the solid skeleton of porous materials [5], which is a complicated process. 

There exist empirical and microstructural models to describe the acoustic properties of porous fibrous materials [9–12]. Delany and Bazley [13] developed a representative empirical model to describe the acoustic characteristics of fibrous materials using the parameter of flow resistance. Miki [14] modified the Delany-Bazley model to make the impedance function satisfy the positive-real property. Then, their works were further extended by involving the common logarithm in the 

conventional models to improve the acoustic properties of glass wool and rock wool [15]. It is worth noting that the empirical models are only valid for restricted types of fibrous materials with certain intrinsic characteristics [16]. On the other hand, the microstructural models are based on the microscopic characteristics of acoustic waves propagating in the fibrous materials. Johnson et al. [17], and Champoux and Allard [18] established a rigid frame model, i.e., the JohnsonChampoux-Allard (JCA) model, to predict the complex bulk density and bulk modulus of porous fibrous materials by treating them as homogeneous fluid mediums. The model is established based on five physical parameters: the open porosity, defined by the ratio between the volume of pores and the overall volume; the static air flow resistivity, defined by the ratio between the pressure gradient and the normal flow velocity through the materials; the tortuosity, denoting the nonstraightness of the inside pores; the viscous characteristic length and the thermal characteristic length, describing the effects of viscosity and 

- Corresponding author. 

_E-mail address:_ guojingwen@mail.ioa.ac.cn (J. Guo). 

https://doi.org/10.1016/j.apacoust.2024.109966 Received 23 October 2023; Received in revised form 3 March 2024; Accepted 5 March 2024 Available online 12 March 2024 0003-682X/© 2024 Elsevier Ltd. All rights reserved. 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

thermal dissipation at high frequencies, respectively [19]. Afterwards, the JCA model is extended to improve prediction accuracy. Specially, Lafarge et al. [20] presented an extension to the thermal effects in the JCA model by introducing the parameter of static thermal permeability (JCA-Lafarge model). Pride et al. [21] investigated the low-frequency inertia characteristics of the equivalent fluid and introduced the parameters of thermal permeability, static viscous and thermal tortuosity (JCA-Pride-Lafarge model). Kino [22] revised the JCA model by introducing a correction factor of flow resistivity based on data fitting. Even so, the JCA model is a basic, reliable and widely used microstructural model for predicting the acoustic properties of porous fibrous materials. 

To apply the JCA model for acoustic properties prediction, it is a priority to accurately determine the five JCA parameters of porous fibrous materials. During the past decades, many efforts have been made to develop approaches for determining the JCA parameters of porous materials. The primary techniques include direct or indirect experimental characterization methods [23–29] and micro-scale numerical simulations [30–34]. Typically, laboratory tests require specific experimental instruments, such as different fine pressure meters or ultrasonic sensors [33], while simulations require many computational resources [35]. Hence, they are time-consuming and expensive processes, which may affect the efficiency of porous material design, especially for optimization problems, in which a huge amount of trial and error processes are typically required. Thus, developing an alternative tool that can overcome the limitations of the existing approaches and predict the acoustic characteristics of porous materials rapidly and accurately is desired. 

In recent years, the machine learning approach has attracted enormous research interests and achieved explosive development. The machine learning approach is a powerful tool to establish a mathematical model extracting the inherent characteristics from a large set of training data. Then, the trained data-driven model can be used to make a decision or predict unknown problems. A lot of applications related to acoustics have been reported, such as acoustic information recognition [36,37], elastic parameters identification [38,39], under-water sound source localization [40], bioacoustics [41], sound absorption [42–45] and environmental acoustics [46,47]. A detailed survey of the most recent applications of machine learning approaches in acoustics can be found in the review Ref. [48]. Machine learning approaches have also been applied in the acoustic parameter estimation of porous materials. Lähivaara et al. [35] proposed a convolutional neural network (CNN) to estimate the porosity and tortuosity of porous materials from synthetic ultrasound tomography data. Then, Jeon et al. [49] estimated the transport parameters of fibrous materials from raw X-ray microcomputed tomography (CT) images by using CNNs. Trinh [50] applied a multiscale-informed transfer learning approach to predict the sound absorption coefficient of randomly-packed rigid spherical beads based on limited experimental datasets. Ring and Langer [51] gained further insights into the relationship between the microscale geometry and the acoustic material parameters of a generic bar-lattice design porous material by performing a statistical analysis. In this study, we develop an artificial neural network (ANN) model to establish the relationship between microstructural features and JCA parameters of a specific type of porous fibrous material, which is more attractive compared to the analytical approach [32] when the relations between inputs and outputs are non-linear. Compared to previous machine learning-based studies [35,49,50], the inputs of the ANN model (the microcosmic structure parameters) are easily obtained, and the ANN model is a simple but powerful algorithm, having the advantages of high prediction accuracy, low overfitting risk, and high robustness. 

This paper is organized as follows. The JCA model and the numerical method to predict the JCA parameters of porous fibrous materials are presented in Section 2. Section 3 describes the machine learning model establishing the relationship between the transport parameters and the microstructural features of the porous fibrous materials. Section 4 presents the training and validation of the machine learning model. The testing includes the datasets located outside the scope of 

**==> picture [250 x 71] intentionally omitted <==**

**Fig. 1.** (a) The photograph and microstructure of a fibrous material. (b) Illustration of acoustic wave impinging on an equivalent media backed by a rigid wall. 

the training data range. Finally, concluding remarks are given in Section 5. 

## **2. JCA model and the numerical calculation method** 

A brief introduction of the JCA model for fibrous materials is initially presented. An example of air-saturated fibrous material and its microstructure obtained using the Scanning Electron Microscope (SEM) are presented in Fig. 1(a), which is composed of multiple randomlydistributed fibers. According to the JCA model, the fibrous material can be modelled as an equivalent media to characterize its acoustic properties. The effective density _𝜌𝑒_ and the effective bulk modulus _𝐾𝑒_ of the equivalent media with respect to the angular frequency _𝜔_ can be calculated by [17,18] 

**==> picture [252 x 90] intentionally omitted <==**

where _𝑃_ 0, _𝜌_ 0, _𝛾_ , _𝑁_ pr , and _𝜂_ are the ambient pressure, the air density, the ratio of specific heat, the Prandtl constant of air and the dynamic viscosity of air, respectively; _𝑗_ is the imaginary unit; _𝜙_ , _𝜎_ , _𝛼_ ∞, Λ, and Λ[′] are the porosity, the flow resistivity (Pa ⋅ s ⋅ m[−2] ), the tortuosity, the viscous characteristic length (m), and the thermal characteristic length (m), respectively, which are five dominant acoustic parameters in the JCA model to characterize the losses caused by viscous and thermal effects in the fibrous materials. The equivalent properties (Eqs. (1) and (2)), together with the JCA parameters, are necessary to predict the acoustic performance of the porous material in terms of sound absorption and transmission [19]. So, it is crucial to determine the JCA parameters accurately for characterizing fibrous material. 

The aforementioned five JCA parameters can be calculated using the flow fluid characteristics in the fibrous material [28,34,52]. The structure of the complicated microstructure of a fibrous material shown in Fig. 1(a) typically can be treated as periodic lattices. A two-dimensional (2D) periodic hexagonal lattice arrangement of porous fibrous materials is adopted in this study, as presented in Fig. 2. The periodic regular hexagonal arrangement has been reported and validated by Perrot et al. [53]. Afterwards, they extended the microstructure of the porous material to three-dimensional periodic geometry [31]. In this study, we only select the basic 2D hexagonal arrangement to demonstrate the applicability of the developed machine learning model. For this particular arrangement of fibers, the acoustic characteristics of the fibrous material are determined by two main geometric parameters: the equivalent throat size _𝑤_ and the fiber radius _𝑟_ in Fig. 2. Following the previous studies [31,34], the long-wavelength acoustic properties of rigid-frame porous media, such as the JCA parameters, can be captured from the flow field characteristics in the microstructure. Specially, they can be numerically determined by solving the local equations governing the asymptotic frequency-dependent visco-thermal dissipation phenomena 

2 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [236 x 205] intentionally omitted <==**

**Fig. 2.** Illustration of the cross-section of a fiber material (left) and one period of the microstructure configuration (right). 

in a periodic unit cell with adequate boundary conditions. The porosity _𝜙_ and the thermal characteristic length Λ[′] can be directly obtained from the geometry of the microstructure (2D geometry) by the following expression 

**==> picture [252 x 24] intentionally omitted <==**

**==> picture [224 x 30] intentionally omitted <==**

where _𝑆𝑎_ and _𝑆𝑡_ are the air area and the total area of the fibrous material; Ω _𝑓_ and _𝜕_ Ω _𝑓_ are the fluid domain and the fluid–solid interface. The other three parameters can be calculated by analyzing the flow field properties in the microstructure using finite element analysis. Specifically, the flow field is dominant by the viscous effects over the inertial ones at low frequencies ( _𝜔_ → 0). In this case, the governing equations are the steady Stokes equations 

**==> picture [252 x 10] intentionally omitted <==**

**==> picture [221 x 10] intentionally omitted <==**

**==> picture [209 x 10] intentionally omitted <==**

where _**𝒗**_ is the flow velocity field; _𝑝_ is the microscopic pressure in the fluid phase; _**𝒆** ̂_ is the macroscopic unit pressure gradient applied on the domain, acting as the source term. The Creeping Flow interface in the finite element method (FEM) software COMSOL Multiphysics is employed for simulating the steady Stokes equations. The flow resistance can be calculated from the averaged _𝑥_ -component of the flow field by 

**==> picture [252 x 20] intentionally omitted <==**

where ⟨∗⟩ denotes a fluid-phase average over the fluid domain. At high frequencies ( _𝜔_ → ∞), the viscous effect can be neglected while the inertial effect is dominant. The incompressible perfect fluid flow problem is analogous to the electric conduction problem by assuming that the velocity field corresponds to the electric field and acoustic pressure to the electric potential. The governing equations of electric field _𝐸_ can be expressed as 

**==> picture [240 x 10] intentionally omitted <==**

**==> picture [252 x 10] intentionally omitted <==**

**==> picture [251 x 157] intentionally omitted <==**

**Fig. 3.** The normalized simulated velocity field at (a) static flow case ( _𝜔_ → 0) and (b) inertial flow case ( _𝜔_ → ∞) for _𝑤_ = 55 μm and _𝑟_ = 10 μm. The arrow lines refer to the streamline. 

**==> picture [250 x 10] intentionally omitted <==**

where _**𝒒**_ is the microscopic electric potential; _**𝒆**_ is an externally generated unit electric field over the domain; **𝐧** is the outward normal unit vector. The Electrostatics interface under the Electric Fields and Currents branch in COMSOL is used to compute the electric field. The tortuosity _𝛼_ ∞ and the viscous characteristic length Λ can be estimated from the calculated electric field by 

**==> picture [252 x 46] intentionally omitted <==**

Based on the above governing equations, the numerical simulations are performed to calculate the JCA parameters of porous materials. Taking the 2D hexagonal arrangement of fibers shown in Fig. 2 for instance and set _𝑤_ = 55 μm and _𝑟_ = 10 μm, the simulated velocity field in the computational domain at the static flow case ( _𝜔_ → 0) and the inertial flow case ( _𝜔_ → ∞) are given in Figs. 3(a) and (b), respectively. Based on Eqs. (3), (4), (8), (12) and (13), the calculated _𝜙_ , _𝜎_ , _𝛼_ ∞, Λ, and Λ[′] are 0.957, 34641 Pa ⋅ s ⋅ m[−2] , 1 _._ 022, 1 _._ 16e −4 m, and 2 _._ 23e −4 m, respectively. Hence, one can build up a JCA parameters database of the porous materials with different geometric parameters, which can be used in the following machine learning model establishing. Note that for other different arrangements of fibers, including the 2D and 3D geometric models, the governing equations presented above to calculate the JCA parameters are still available, which has been demonstrated in Refs. [31,54,55]. The numerical method for calculating the JCA parameters can be used to prepare the datasets for the following machine learning model. 

## **3. Machine learning model** 

For the periodic microstructure configuration shown in Fig. 2, an ANN model with a deep architecture can be established for predicting the JCA parameters of fibrous porous materials directly from the microstructure geometric parameters. The architecture of the model is shown in Fig. 4, which is constructed by an input layer, multiple hidden layers and an output layer. The geometric parameters of the fibrous material: the fiber equivalent throat size _𝑤_ and the fiber radius _𝑟_ are treated as the neurons in input layer. The five JCA parameters of the fibrous porous material _𝜙_ , _𝜎_ , _𝛼_ ∞, Λ, and Λ[′] are assigned as the neurons in output layer. The performance of the network model is assessed by using three statistical parameters: the mean square error (MSE), the mean absolute percentage error (MAPE) and the coefficient of determination (R[2] ). Their definitions can be expressed as following: 

3 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [332 x 135] intentionally omitted <==**

**Fig. 4.** Schematic of the artificial neural network model for the prediction of JCA parameters. The circles denote the neurons, and the arrows represent the interconnections between the neurons. 

**==> picture [252 x 93] intentionally omitted <==**

where _𝑁_ is the total number of data samples, _𝑋𝑎,𝑗_ is the _𝑗[𝑡ℎ]_ reference value and _𝑋𝑝,𝑗_ is the _𝑗[𝑡ℎ]_ predicted output value by the neural network model. 

The selection of the number of hidden layers and the number of neurons in each hidden layer is important as the configuration of the ANN model affects its prediction performance significantly. However, there are no clear guiding rules for determining the hidden layer number and the optimum neuron number in each hidden layer for a particular application. The selection is typically based on tests or experiences and is determined by trial and error. In this study, the ReLU function is selected as the activation function due to its high computational efficiency [56], and the optimizer adaptive moment estimation (Adam) [57] is used to optimize the weights and biases in the training process due to its faster convergence and better performance. After the ANN model is well-trained, the trained model can characterize the JCA parameter from the knowledge of certain microstructural features of porous material. 

## **4. Results and discussion** 

In this section, a comprehensive study on the application of the ANN model to predict the transport parameters of the fibrous material shown in Fig. 2 is performed. In the stage of data preparation, the ranges of the geometric parameters of the microstructure configuration are constrained in _𝑤_ ∈[20 _,_ 200] μm and _𝑟_ ∈[5 _,_ 350] μm [28], located within a black rectangular box in Fig. 5. In the simulations, _𝑤_ and _𝑟_ are linearly swept with the steps of 180∕39 μm and 345∕39 μm, respectively. Totally, there are 1600 groups of datasets are generated for the training and testing of the machine learning model. The training datasets are constricted in the black rectangular ( _𝑤_ ∈[20 _,_ 170] μm and _𝑟_ ∈[5 _,_ 300] μm) shown in Fig. 5, in which 80% of the data are used as the training datasets and 20% of the data are used as the validation datasets. To increase the generality of the machine learning model, some datasets located outside the training date ranges of _𝑤_ and _𝑟_ are also employed as the validation datasets. Thus, there are 898 training datasets and 369 validation datasets. Note that the datasets used in the network are normalized and shuffled to accelerate convergence and avoid over-fitting. 

Before training and testing the ANN model for prediction, the number of hidden layers, the neuron number in each layer of the network 

**==> picture [183 x 172] intentionally omitted <==**

**==> picture [8 x 12] intentionally omitted <==**

**==> picture [26 x 12] intentionally omitted <==**

**Fig. 5.** Distribution of training datasets (red triangles), validation datasets (blue circles) and additional testing datasets (green circles). The black rectangular denotes the range of the training datasets. 

structure and the initial learning rate of the Adam optimizer should be suitably determined. These parameters are also called as hyperparameters of the ANN model. Since a series of comparisons is needed, it is expensive to search for optimized hyperparameters. Herein, for simplicity, the numbers of hidden layers are set as 3, 5, and 8; the node numbers in each layer are 50, 200, 300 and 500; and the learning rates are selected from 1e-2, 1e-3, 1e-4, 1e-5, and 1e-6. Totally, there are 72 networks to be compared and analyzed. Different networks are labelled as L _𝑚_ N _𝑛_ , where _𝑚_ and _𝑛_ denote the numbers of hidden layers and nodes in each layer, respectively. One can evaluate the hyperparameters based on the converge speed of the model, which is calculated by 

**==> picture [252 x 22] intentionally omitted <==**

where _𝐿_ min is the minimum mean square error for the validation datasets during the training process. In the hyperparameters evaluation process, the training epochs is set as 200. The convergence speed of the models with different hyperparameters for the JCA parameters are presented in Fig. 6, in which the horizontal and vertical coordinates denote the learning rate and the testing ANN model, respectively. It can be observed that different combinations of hyperparameters have similar convergence performance for the parameters of _𝜙_ , _𝛼_ ∞ and _𝜎_ , and similar performance for the parameters of Λ, and Λ[′] . To illustrate the effects of the hidden layer number, the neuron number in each hidden layer and the dropout possibility on the model performance clearly, 

4 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [374 x 143] intentionally omitted <==**

**Fig. 6.** The convergence speed of the models with different hyperparameters for the JCA parameters. 

**==> picture [374 x 139] intentionally omitted <==**

**Fig. 7.** (a) The effect of neuron number on the MSE loss of the ANN model (learning rate 1e-4, layer number 3). (b) The effect of layer number on the MSE loss of the ANN model (learning rate 1e-4, neuron number is 200 at each layer). 

Fig. 7 presents the parametric study results. From Figs. 7(a) and 7(b), the training and validation errors decrease with the increase of neuron and layer numbers and then become flat. Considering that a large number of layers or nodes would slow down the training process, the layer and node numbers should be as few as possible when the prediction accuracy is guaranteed. From Figs. 6 and 7, the network L3N200 with the learning rate of 1e-4 and the dropout possibility of 0.1 exhibits a fast convergence speed for all these five JCA parameters. Hence, this combination of hyperparameters is selected for the following training and validation. 

The training process of the L3N200 network for the training and validation datasets is presented in Fig. 8. It can be observed that both errors have similar varying trends, i.e., descending fast at the first hundred steps and then gradually decreasing to sufficiently small values with little fluctuations. The hardware platform used in this study comprises an Intel Core i7-4790 processor and 16 GB memory. The average training time of the model is 33 _._ 65 seconds. 

Figs. 9 and 10 show the comparison between the reference and the predicted JCA parameters of _𝜙_ , _𝜎_ , _𝛼_ ∞, Λ, and Λ[′] by the trained ANN model applied to the training and validation datasets. It can be seen that the R[2] values of the model for all JCA parameters closely approach 1 (being greater than 0.990 for both the training datasets and the validation datasets), indicating the excellent fits between targets and predictions for all outputs. The MAPE of the ANN model applied to the training and validation datasets are listed in Table 1. The relatively small values of the MAPE indicate that the JCA parameters of the fibrous porous material as a function of the microstructural geometric parameters can be accurately predicted by the trained model, and the model has satisfied generalization capability. 

To further evaluate the prediction ability of the trained model, 334 additional testing datasets outside the training date ranges of _𝑤_ and _𝑟_ are prepared, as denoted by green dots in Fig. 5. The comparison be- 

**==> picture [167 x 150] intentionally omitted <==**

**Fig. 8.** The training process of the ANN model for the training and validation datasets as a function of epoch. 

**Table 1** 

The MAPE of the ANN model applied to the training and validation datasets. 

||Parameter<br>Training MAPE(%)<br>Validation MAPE(%)|_𝜙_<br>0.23<br>0.34|_𝜎_<br>4.04<br>19.63|_𝛼_∞<br>0.26<br>0.50|Λ<br>2.98<br>4.21|Λ′<br>2.73<br>3.83|
|---|---|---|---|---|---|---|



tween the reference and the predicted JCA parameters of the additional testing datasets are given in Fig. 11. The corresponding R[2] and MAPE results are given in Fig. 11 and Table 2. It can be seen that the developed neural network model can generally well predict (R[2] _>_ 0 _._ 90) the porosity, the flow resistivity, the tortuosity, the viscous characteristic length, and the thermal characteristic length for the additional datasets, which 

5 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [375 x 245] intentionally omitted <==**

**Fig. 9.** Comparison between the reference (black lines) and predicting JCA parameters (red dots) by the trained ANN model for the training datasets. 

**==> picture [375 x 245] intentionally omitted <==**

**Fig. 10.** Comparison between the reference (black lines) and predicting JCA parameters (blue dots) by the trained ANN model for the validation datasets. 

further demonstrates the good generalization capability of the developed model. Some discrete datasets of the parameters of Λ and Λ[′] with large values are underestimated, while some discrete Λ and Λ[′] datasets in the middle ranges are overestimated. This trend is similar to those in Figs. 9 and 10. The deviations can be ascribed to the Λ and Λ[′] values are non-uniformly distributed, mainly located in the small ranges. In addition, when the neural network model is applied to the validation and testing datasets, the MAPE of flow resistivity is pretty large. It mainly originates from the difference in the flow resistivity range. As can be seen from Figs. 9, 10 and 11, the flow resistivity ranges of the validation and testing datasets are lower than that of the training datasets. What’s more, most flow resistivity data in the validation and testing datasets is located below the flow resistivity range of the training datasets, which 

results in a large overall deviation in the flow resistivity predicted by the neural network model. Considering the importance of accurate JCA parameters for acoustic properties prediction, a higher-accuracy JCA parameters prediction is continually required. In the future, we plan to upgrade the machine learning model, for example, using other neural networks like CNN and so on, to improve the generalization ability of the model. 

Finally, the performance of the network model is assessed by experiments. Considering that it is difficult to directly measure the JCA parameters, the prediction accuracy of the network is verified by using two indirect acoustic characteristic parameters: the complex wave number _𝑘𝑐_ = 2 _𝜋𝑓_ ∕√ _𝐾𝑒_ ∕ _𝜌𝑒_ ( _𝑓_ is the frequency) and the characteristic impedance _𝑍𝑐_ = √ _𝐾𝑒𝜌𝑒_ . A metal-based fibrous material with a 

6 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [375 x 244] intentionally omitted <==**

**Fig. 11.** Comparison between the reference (black lines) and predicting JCA parameters (blue dots) by the trained ANN model for the 334 additional testing datasets located outside the scope of the training data range. 

**Table 2** 

The MAPE of the ANN model applied to the additional 334 testing datasets. 

|tional 334 te|sting da|tasets.||||
|---|---|---|---|---|---|
|Parameter|_𝜙_|_𝜎_|_𝛼_∞|Λ|Λ′|
|MAPE(%)|0.48|40.68|0.99|5.19|5.17|



**Table 3** 

The predicted JCA parameters of the fibrous material with a fiber radius of 14 μm and porosity of 0.85 by the trained model and the measured porosity and flow resistivity. 

|Parameter|_𝜙_(−)|_𝜎_(Pa⋅s⋅m−2)|_𝛼_∞(−)|Λ(m)|Λ′(m)|
|---|---|---|---|---|---|
|Predicted value|0.856|75199|1.069|3.39e-05|6.11e-05|
|Measured value|0.859|72558||||



fiber radius of 14 μm and porosity of 0.85, as shown in Fig. 12(a), is selected for the experimental verification. The SEM structure of the fibrous materials is presented on the right side of Fig. 12(a). Based on the assumption of the hexagon configuration shown in Fig. 2, one can obtain _𝑤_ = 28 _._ 2 μm from the porosity. The geometric dimension of this fibrous material ( _𝑤_ = 28 _._ 2 μm and _𝑟_ = 14 μm) is located within the scope of the training and testing data range of the model. The predicted JCA parameters of the fibrous material by the trained model are listed in Table 3. For comparison, the measured porosity and flow resistivity of the fibrous material are listed in Table 3 according to the measurements in Refs [29,58]. The relative errors of _𝜙_ and _𝜎_ are 0 _._ 349% and 3 _._ 63%, respectively, indicating the differences between predictions and measurements are small. Based on the predicted JCA parameters, one can calculate the _𝜌𝑒_ and _𝐾𝑒_ of the material based on Eqs. (1) and (2), and then the _𝑘𝑐_ and _𝑍𝑐_ can be attained subsequently. 

The measurements of _𝑍𝑐_ and _𝑘𝑐_ are performed in a Brüel & Kjær impedance tube (type 4206) based on the four-microphone method [59]. The impedance tube is a rigid, straight, smooth cylindrical pipe tube with an inner diameter of 29 mm. Considering the plane wave cutoff frequency of the tube, the working frequency of this tube ranges from 500 Hz to 6400 Hz. Fig. 12(b) gives an illustration of the impedance tube measuring system, including a random signal generator, a power amplifier, an impedance tube, and a data acquisition 

**==> picture [240 x 222] intentionally omitted <==**

**Fig. 12.** (a) Photographs of the test sample. (b) Illustration of the impedance tube setup. 

system. The sound source, a broadband random signal, is mounted on one end of the impedance tube, and a testing sample is placed in the middle of the tube. Four microphones are installed on the front and back of the test sample to measure the sound pressure in the tube. More details about the measurement techniques can be found in Ref. [59]. A comparison of the ANN model-based predicted and measured (symbols) results of the real and imaginary components of _𝑘𝑐_ and _𝑍𝑐_ are given in Fig. 13. The ANN-based predictions are generally consistent with the measured results. Hence, the prediction capability of the developed machine learning model is experientially demonstrated. The obtained _𝑘𝑐_ and _𝑍𝑐_ can be used to obtain the acoustic absorption and transmission performance of porous materials [5]. Note that for other arrangements of fiber materials, the main geometric parameters may be different from the 2D periodic hexagonal lattice arrangement shown in 

7 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

**==> picture [374 x 183] intentionally omitted <==**

**Fig. 13.** The effective fluid properties of a fibrous material with fiber radius of 14 μm and porosity of 0.85. The real and imaginary components of (a) the wave number _𝑘𝑐_ and (b) the normalized characteristic impedance _𝑍𝑐_ ∕ _𝑍_ 0, where _𝑍_ 0 = _𝜌_ 0 _𝑐_ 0 is the impedance of air. The solid and dashed lines refer to the calculated results using the predicted JCA parameters obtained by the trained model and the numerical simulation; the symbols are the measured results. 

Fig. 2. However, the model presented in this study can also be trained analogically and predict the acoustic properties once their main geometric parameters are determined. Note that the main contribution of this study is not to replace the existing direct or indirect numerical/analytical characterization methods on porous materials, but to provide an alternative to the developments of analytical relationships to predict transport parameters of a specific type of porous material based on its microstructural characteristics. 

## **5. Conclusion** 

Porous fibrous materials are widely used for noise attenuation in numerous realistic engineering applications. Based on the equivalent fluid medium theory, the JCA model can describe the overall acoustic characteristics of the porous or fibrous materials, with five JCA parameters to be determined. A fast and accurate prediction of the JCA parameters is desirable for porous material design in practice. This study develops a data-driven methodology based on the ANN model to predict the JCA parameters of a fibrous material. The inputs of the network are the geometric parameters of the material in the microstructure. The training and testing datasets for the network are obtained from FEM simulations. Results show that the trained network achieves a satisfactory performance in predicting the JCA parameters when applied to the validation datasets. 

To further assess the prediction performance of the trained network, a set of datasets outside the training geometric parameter ranges are prepared and additionally tested. It is demonstrated that the trained model can also present generally satisfactory prediction capability. Finally, the model is validated by comparison with the measured acoustic experimental characterizations of a metal-based fibrous material with fiber radius of 14 μm and porosity of 0.85 in an impedance tube. The developed machine learning model yields a rapid and accurate estimation of the JCA parameters of generic porous materials only based on the geometric parameters, which paves a promising potential for various applications of porous materials, such as in identifying the acoustic characteristics of porous materials and designing high-efficiency soundabsorbing porous materials. 

## **CRediT authorship contribution statement** 

**Wei Yi:** Writing – original draft, Methodology, Investigation, Formal analysis. **Jingwen Guo:** Writing – original draft, Validation, Supervision, Software, Project administration, Methodology, Funding acquisition, Formal analysis, Conceptualization. **Teng Zhou:** Writing – review 

& editing, Formal analysis. **Hanbo Jiang:** Writing – review & editing, Formal analysis. **Yi Fang:** Writing – review & editing, Investigation. 

## **Declaration of competing interest** 

The authors declare that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper. 

## **Data availability** 

Data will be made available on request. 

## **Acknowledgement** 

Jingwen Guo would like to thank the financial support of Chinese Academy of Sciences BR Project E3551703. 

## **References** 

- [1] Arenas JP, Crocker MJ. Recent trends in porous sound-absorbing materials. J Sound Vib 2010;44(7):12–8. 

- [2] Kidner MR, Hansen CH. A comparison and review of theories of the acoustics of porous materials. Int J Acoust Vib 2008;13(3):112–9. 

- [3] Yang M, Sheng P. Sound absorption structures: from porous media to acoustic metamaterials. Annu Rev Mater Sci 2017;47:83–114. 

- [4] Lagarrigue C, Groby JP, Dazel O, Tournat V. Design of metaporous supercells by genetic algorithm for absorption optimization on a wide frequency band. Appl Acoust 2016;102:49–54. 

- [5] Cao L, Fu Q, Si Y, Ding B, Yu J. Porous materials for sound absorption. Compos Commun 2018;10:25–35. 

- [6] Guo J, Qu R, Fang Y, Yi W, Zhang X. A phase-gradient acoustic metasurface for broadband duct noise attenuation in the presence of flow. Int J Mech Sci 2022:107822. 

- [7] Qu R, Guo J, Fang Y, Zhong S, Zhang X. Broadband acoustic meta-porous layer for reflected wave manipulation and absorption. Int J Mech Sci 2022;227:107426. 

- [8] Guo J, Fang Y, Qu R, Zhang X. Development and progress in acoustic phase-gradient metamaterials for wavefront modulation. Mater Today 2023. 

- [9] Tang X, Yan X. Acoustic energy absorption properties of fibrous materials: a review. Composites, Part A, Appl Sci Manuf 2017;101:360–80. 

- [10] Wu Q. Empirical relations between acoustical properties and flow resistivity of porous plastic open-cell foam. Appl Acoust 1988;25(3):141–8. 

- [11] Jones PW, Kessissoglou NJ. Simplification of the delany–bazley approach for modelling the acoustic properties of a poroelastic foam. Appl Acoust 2015;88:146–52. 

- [12] Trinh VH, Guilleminot J, Perrot C. On the construction of multiscale surrogates for design optimization of acoustical materials. Acta Acust Acust 2018;104(1):1–4. 

- [13] Delany M, Bazley E. Acoustical properties of fibrous absorbent materials. Appl Acoust 1970;3(2):105–16. 

8 

_W. Yi, J. Guo, T. Zhou et al._ 

_Applied Acoustics 220 (2024) 109966_ 

- [14] Miki Y. Acoustical properties of porous materials-modifications of delany-bazley models. J Accoust Soc Jpn 1990;11(1):19–24. 

- [15] Komatsu T. Improvement of the delany-bazley and miki models for fibrous soundabsorbing materials. Acoust Sci Technol 2008;29(2):121–9. 

- [16] Oliva D, Hongisto V. Sound absorption of porous materials–accuracy of prediction methods. Appl Acoust 2013;74(12):1473–9. 

- [17] Johnson DL, Koplik J, Dashen R. Theory of dynamic permeability and tortuosity in fluid-saturated porous media. J Fluid Mech 1987;176:379–402. 

- [18] Champoux Y, Allard JF. Dynamic tortuosity and bulk modulus in air-saturated porous media. J Appl Phys 1991;70(4):1975–9. 

- [19] Allard J, Atalla N. Propagation of sound in porous media: modelling sound absorbing materials. John Wiley & Sons; 2009. 

- [20] Lafarge D, Lemarinier P, Allard JF, Tarnow V. Dynamic compressibility of air in porous structures at audible frequencies. J Acoust Soc Am 1997;102(4):1995–2006. 

- [21] Pride SR, Morgan FD, Gangi AF. Drag forces of porous-medium acoustics. Phys Rev B 1993;47(9):4964. 

- [22] Kino N. Further investigations of empirical improvements to the Johnsonchampoux-allard model. Appl Acoust 2015;96:153–70. 

- [23] Bies D, Hansen CH. Flow resistance information for acoustical design. Appl Acoust 1980;13(5):357–91. 

- [24] Motsinger R, Syed A, Manley M. The measurement of the steady flow resistance of porous materials. In: 8th aeroacoustics conference; 1983. p. 779. 

- [25] Lambert RF. Propagation of sound in highly porous open-cell elastic foams. J Acoust Soc Am 1983;73(4):1131–8. 

- [26] Beranek LL. Acoustical properties of homogeneous, isotropic rigid tiles and flexible blankets. J Acoust Soc Am 1947;19(4):556–68. 

- [27] Champoux Y, Stinson MR, Daigle GA. Air-based system for the measurement of porosity. J Acoust Soc Am 1991;89(2):910–6. 

- [28] Perrot C, Chevillotte F, Panneton R. Bottom-up approach for microstructure optimization of sound absorbing materials. J Acoust Soc Am 2008;124(2):940–8. 

- [29] Chevillotte F, Ronzio F, Bertolini C, Hoang M, Dejaeger L, Duval A, et al. Interlaboratory characterization of Biot parameters of poro-elastic materials for automotive applications. SAE Technical Paper. 2020. 

- [30] Perrot C, Panneton R, Olny X. Periodic unit cell reconstruction of porous media: application to open-cell aluminum foams. J Appl Phys 2007;101(11):113538. 

- [31] Perrot C, Chevillotte F, Tan Hoang M, Bonnet G, Bécot F-X, Gautron L, et al. Microstructure, transport, and acoustic properties of open-cell foam samples: experiments and three-dimensional numerical simulations. J Appl Phys 2012;111(1):014911. 

- [32] Luu HT, Perrot C, Panneton R. Influence of porosity, fiber radius and fiber orientation on the transport and acoustic properties of random fiber structures. Acta Acust Acust 2017;103(6):1050–63. 

- [33] Hirosawa K, Nakagawa H. Formulae for predicting non-acoustical parameters of deformed fibrous porous materials. J Acoust Soc Am 2017;141(6):4301–13. 

- [34] Liu S, Chen W, Zhang Y. Design optimization of porous fibrous material for maximizing absorption of sounds under set frequency bands. Appl Acoust 2014;76:319–28. 

- [35] Lähivaara T, Kärkkäinen L, Huttunen JM, Hesthaven JS. Deep convolutional neural networks for estimating porous material parameters with ultrasound tomography. J Acoust Soc Am 2018;143(2):1148–58. 

[36] Hinton G, Deng L, Yu D, Dahl GE, Mohamed A-r, Jaitly N, et al. Deep neural networks for acoustic modeling in speech recognition: the shared views of four research groups. IEEE Signal Process Mag 2012;29(6):82–97. 

[37] Guo J, Li X, Ren C, Zhang X. Recognizing the aeroacoustic information of noise radiated by an unflanged duct based on convolutional neural networks. J Acoust Soc Am 2022;152(5):2531–42. 

[38] Wang S, Luo Z, Jing J, Su Z, Wu X, Ni Z, et al. Real-time determination of elastic constants of composites via ultrasonic guided waves and deep learning. Measurement 2022;200:111680. 

- [39] Orta AH, De Boer J, Kersemans M, Vens C, Van Den Abeele K. Machine learningbased orthotropic stiffness identification using guided wavefield data. Measurement 2023;214:112854. 

- [40] Niu H, Reeves E, Gerstoft P. Source localization in an ocean waveguide using supervised machine learning. J Acoust Soc Am 2017;142(3):1176–88. 

- [41] Stowell D, Plumbley MD. Automatic large-scale classification of bird sounds is strongly improved by unsupervised feature learning. PeerJ 2014;2:e488. 

- [42] Yang H, Zhang H, Wang Y, Zhao H, Yu D, Wen J. Prediction of sound absorption coefficient for metaporous materials with convolutional neural networks. Appl Acoust 2022;200:109052. 

[43] Donda K, Zhu Y, Merkel A, Fan S, Cao L, Wan S, et al. Ultrathin acoustic absorbing metasurface based on deep learning approach. Smart Mater Struct 2021;30(8):085003. 

- [44] Gao N, Wang M, Cheng B. Deep auto-encoder network in predictive design of Helmholtz resonator: on-demand prediction of sound absorption peak. Appl Acoust 2022;191:108680. 

- [45] Kumar S, Jin H, Lim KM, Lee HP. Comparative analysis of machine learning algorithms on prediction of the sound absorption coefficient for reconfigurable acoustic meta-absorbers. Appl Acoust 2023;212:109603. 

- [46] Barchiesi D, Giannoulis D, Stowell D, Plumbley MD. Acoustic scene classification: classifying environments from the sounds they produce. IEEE Signal Process Mag 2015;32(3):16–34. 

- [47] Li J, Dai W, Metze F, Qu S, Das S. A comparison of deep learning methods for environmental sound detection. In: 2017 IEEE international conference on acoustics, speech and signal processing (ICASSP). IEEE; 2017. p. 126–30. 

- [48] Bianco MJ, Gerstoft P, Traer J, Ozanich E, Roch MA, Gannot S, et al. Machine learning in acoustics: theory and applications. J Acoust Soc Am 2019;146(5):3590–628. 

- [49] Jeon JH, Chemali E, Yang SS, Kang YJ. Convolutional neural networks for estimating transport parameters of fibrous materials based on micro-computerized tomography images. J Acoust Soc Am 2021;149(4):2813–28. 

- [50] Trinh VH, Guilleminot J, Perrot C, Vu VD. Learning acoustic responses from experiments: a multiscale-informed transfer learning approach. J Acoust Soc Am 2022;151(4):2587–601. 

- [51] Ring TP, Langer SC. On the relationship of the acoustic properties and the microscale geometry of generic porous absorbers. Appl Sci 2022;12(21):11066. 

- [52] Deshmukh S, Ramamoorthy S. Dependence of macro-scale response of fibrous materials on polygonal arrangement of fibers. In: Recent developments in acoustics. Springer; 2021. p. 161–71. 

- [53] Perrot C, Chevillotte F, Panneton R. Dynamic viscous permeability of an open-cell aluminum foam: computations versus experiments. J Appl Phys 2008;103(2):024909. 

- [54] Deshmukh S, Ronge H, Ramamoorthy S. Design of periodic foam structures for acoustic applications: concept, parametric study and experimental validation. Mater Des 2019;175:107830. 

- [55] Park JH, Yang SH, Lee HR, Yu CB, Pak SY, Oh CS, et al. Optimization of low frequency sound absorption by cell size control and multiscale poroacoustics modeling. J Sound Vib 2017;397:17–30. 

- [56] Sharma S, Sharma S, Athaiya A. Activation functions in neural networks. Towards Data Sci 2017;6(12):310–6. 

- [57] Kingma DP, Ba Adam J. A method for stochastic optimization. preprint. arXiv:1412. 6980, 2014. 

- [58] Tao J, Wang P, Qiu X, Pan J. Static flow resistivity measurements based on the ISO 10534.2 standard impedance tube. Build Environ 2015;94:853–8. 

- [59] Bolton JS, Yoo T, Olivieri O. Measurement of normal incidence transmission loss and other acoustical properties of materials placed in a standing wave tube. Brüel Kjær Tech Rev 2007;1:1–44. 

9