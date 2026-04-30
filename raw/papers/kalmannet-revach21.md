---
source_url: https://arxiv.org/abs/2107.10043
ingested: 2026-04-30
sha256: afbd025d5961a8e3a9eca84df949b80fee04e235398dc207ab3b8f6ad55a036b
source: paper
conversion: pymupdf4llm

---

# KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics 

Guy Revach, Nir Shlezinger, Xiaoyong Ni, Adri`a L´opez Escoriza, Ruud J. G. van Sloun, and Yonina C. Eldar 

_**Abstract**_ **—State estimation of dynamical systems in real-time is a fundamental task in signal processing. For systems that are well-represented by a fully known linear Gaussian state space (SS) model, the celebrated Kalman filter (KF) is a low complexity optimal solution. However, both linearity of the underlying SS model and accurate knowledge of it are often not encountered in practice. Here, we present KalmanNet, a real-time state estimator that learns from data to carry out Kalman filtering under nonlinear dynamics with partial information. By incorporating the structural SS model with a dedicated recurrent neural network module in the flow of the KF, we retain data efficiency and interpretability of the classic algorithm while implicitly learning complex dynamics from data. We demonstrate numerically that KalmanNet overcomes non-linearities and model mismatch, outperforming classic filtering methods operating with both mismatched and accurate domain knowledge.** 

## I. INTRODUCTION 

Estimating the hidden state of a dynamical system from noisy observations in real-time is one of the most fundamental tasks in signal processing and control, with applications in localization, tracking, and navigation [2]. In a pioneering work from the early 1960s [3]–[5], based on work by Wiener from 1949 [6], Rudolf Kalman introduced the Kalman filter (KF), a minimum mean-squared error (MMSE) estimator that is applicable to time-varying systems in discrete-time, which are characterized by a linear state space (SS) model with additive white Gaussian noise (AWGN). The low-complexity implementation of the KF, combined with its sound theoretical basis, resulted in it quickly becoming the leading workhorse of state estimation in systems that are well described by SS models in discrete-time. The KF has been applied to problems such as radar target tracking [7], trajectory estimation of ballistic missiles [8], and estimating the position and velocity of a space vehicle in the Apollo program [9]. 

While the original KF assumes linear SS models, many problems encountered in practice are governed by non-linear dynamical equations. Therefore, shortly after the introduction of the original KF, non-linear variations of it were proposed, such as the extended Kalman filter (EKF) [7], [8] and the 

Parts of this work focusing on linear Gaussian state space models were presented at the IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP) 2021 [1]. G. Revach, X. Ni and A. L. Escoriza are with the Institute for Signal and Information Processing (ISI), D-ITET, ETH Z¨urich, Switzerland, (e-mail: grevach@ethz.ch; xiaoni@student.ethz.ch; alopez@student.ethz.ch). N. Shlezinger is with the School of ECE, Ben-Gurion University of the Negev, Beer Sheva, Israel (e-mail: nirshl@bgu.ac.il). R. J. G. van Sloun is with the EE Dpt., Eindhoven University of Technology, and with Phillips Research, Eindhoven, The Netherlands (e-mail: r.j.g.v.sloun@tue.nl). Y. C. Eldar is with the Faculty of Math and CS, Weizmann Institute of Science, Rehovot, Israel (e-mail: yonina.eldar@weizmann.ac.il). 

unscented Kalman filter (UKF) [10]. Methods based on sequential Monte-Carlo (MC) sampling, such as the family of particle filters (PFs) [11]–[13], were introduced for state estimation in non-linear, non-Gaussian SS models. To date, the KF and its non-linear variants are still widely used for online filtering in numerous real world applications involving tracking and localization [14]. 

The common thread among these aforementioned filters is that they are _model-based (MB)_ algorithms; namely, they rely on accurate knowledge and modeling of the underlying dynamics as a fully characterized SS model. As such, the performance of these MB methods critically depends on the validity of the domain knowledge and model assumptions. MB filtering algorithms designed to cope with some level of uncertainty in the SS models, e.g., [15]–[17], are rarely capable of achieving the performance of MB filtering with full domain knowledge, and rely on some knowledge of how much their postulated model deviates from the true one. In many practical use cases the underlying dynamics of the system is non-linear, complex, and difficult to accurately characterize as a tractable SS model, in which case degradation in performance of the MB state estimators is expected. 

Recent years have witnessed remarkable empirical success of deep neural networks (DNNs) in real-life applications. These data-driven (DD) parametric models were shown to be able to catch the subtleties of complex processes and replace the need to explicitly characterize the domain of interest [18], [19]. Therefore, an alternative strategy to implement state estimation—without requiring explicit and accurate knowledge of the SS model—is to learn this task from data using deep learning. DNNs such as recurrent neural networks (RNNs)—i.e., long short-term memory (LSTM) [20] and gated recurrent units (GRUs) [21]—and attention mechanisms [22] have been shown to perform very well for time series related tasks mostly in intractable environments, by training these networks in an end-to-end, model-agnostic manner from a large quantity of data. Nonetheless, DNNs do not incorporate domain knowledge such as structured SS models in a principled manner. Consequently, these DD approaches require many trainable parameters and large data sets even for simple sequences [23] and lack the interpretability of MB methods. These constraints limit the use of highly parametrized DNNs for real-time state estimation in applications embedded in hardware-limited mobile devices such as drones and vehicular systems. 

The limitations of MB Kalman filtering and DD state estimation motivate a hybrid approach that exploits the best of both worlds; i.e., the soundness and low complexity of the 

1 

classic KF, and the model-agnostic nature of DNNs. Therefore, we build upon the success of our previous work in MB deep learning for signal processing and digital communication applications [24]–[27] to propose a hybrid MB/DD online recursive filter, coined KalmanNet. In particular, we focus on real-time state estimation for continuous-value SS models for which the KF and its variants are designed. We assume that the noise statistics are unknown and the underlying SS model is partially known or approximated from a physical model of the system dynamics. To design KalmanNet, we identify the Kalman gain (KG) computation of the KF as a critical component encapsulating the dependency on noise statistics and domain knowledge, and replace it with a compact RNN of limited complexity that is integrated into the KF flow. The resulting system uses labeled data to learn to carry out Kalman filtering in a supervised manner. 

Our main contributions are summarized as follows: 

- 1) We design KalmanNet, which is an interpretable, low complexity, and data-efficient DNN-aided real-time state estimator. KalmanNet builds upon the flow and theoretical principles of the KF, incorporating partial domain knowledge of the underlying SS model in its operation. 

- 2) By learning the KG, KalmanNet circumvents the dependency of the KF on knowledge of the underlying noise statistics, thus bypassing numerically problematic matrix inversions involved in the KF equations and overcoming the need for tailored solutions for non-linear systems; e.g., approximations to handle non-linearities as in the EKF. 

- 3) We show that KalmanNet learns to carry out Kalman filtering from data in a manner that is invariant to the sequence length. Specifically, we present an efficient supervised training scheme that enables KalmanNet to operate with arbitrary long trajectories while only training using short trajectories. 

- 4) We evaluate KalmanNet in various SS models. The experimental scenarios include synthetic setups, tracking the chaotic Lorenz system, and localization using the Michigan NCLT data set [28]. KalmanNet is shown to converge much faster compared with purely DD systems, while outperforming the MB EKF, UKF, and PF, when facing model mismatch and dominant non-linearities. 

The proposed KalmanNet leverages data and partial domain knowledge to _learn the filtering operation_ , rather than using data to explicitly estimate the missing SS model parameters. Although there is a large body of work that combines SS models with DNNs, e.g., [29]–[35], these approaches are sometimes used for different SS related tasks (e.g., smoothing, imputation); with a different focus, e.g., incorporating highdimensional visual observations to a KF; or under different assumptions, as we discuss in detail below. 

The rest of this paper is organized as follows: Section II reviews the SS model and its associated tasks, and discusses related works. Section III details the proposed KalmanNet. Section IV presents the numerical study. Section V provides concluding remarks and future work. 

Throughout the paper, we use boldface lower-case letters for vectors and boldface upper-case letters for matrices. The transpose, _ℓ_ 2 norm, and stochastic expectation are denoted by 

_{·}[⊤]_ , _∥·∥_ , and E [ _·_ ], respectively. The Gaussian distribution with mean _µ_ and covariance **Σ** is denoted by _N_ ( _µ,_ **Σ** ). Finally, R and Z are the sets of real and integer numbers, respectively. 

## II. SYSTEM MODEL AND PRELIMINARIES 

## _A. State Space Model_ 

We consider dynamical systems characterized by a SS model in discrete-time [36]. We focus on (possibly) non-linear, Gaussian, and continuous SS models, which for each _t ∈_ Z are represented via 

**==> picture [240 x 26] intentionally omitted <==**

In (1a), **x** _t_ is the latent state vector of the system at time _t_ , which evolves from the previous state **x** _t−_ 1, by a (possibly) non-linear, state-evolution function **f** ( _·_ ) and by an AWGN **w** _t_ with covariance matrix **Q** . In (1b), **y** _t_ is the vector of observations at time _t_ , which is generated from the current latent state vector by a (possibly) non-linear observation (emission) mapping **h** ( _·_ ) corrupted byAWGN **v** _t_ with covariance **R** . For the special case where the evolution or the observation transformations are linear, there exist matrices **F** _,_ **H** such that 

**==> picture [208 x 11] intentionally omitted <==**

In practice, the state-evolution model (1a) is determined by the complex dynamics of the underlying system, while the observation model (1b) is dictated by the type and quality of the observations. For instance, **x** _t_ can determine the location, velocity, and acceleration of a vehicle, while **y** _t_ are measurements obtained from several sensors. The parameters of these models may be unknown and often require the introduction of dedicated mechanisms for their estimation in real-time [37], [38]. In some scenarios, one is likely to have access to an approximated or mismatched characterization of the underlying dynamics. 

SS models are studied in the context of several different tasks; these tasks are different in their nature, and can be roughly classified into two main categories: observation _approximation_ and hidden state _recovery_ . The first category deals with approximating parts of the observed signal **y** _t_ . This can correspond, for example, to the prediction of future observations given past observations; the generation of missing observations in a given block via imputation; and the denoising of the observations. The second category considers the recovery of a hidden state vector **x** _t_ . This family of state recovery tasks includes offline recovery, also referred to as smoothing, where one must recover a block of hidden state vectors, given a block of observations, e.g., [35]. The focus of this paper is _filtering_ ; i.e., _online_ recovery of **x** _t_ from past and current noisy observations _{_ **y** _τ }[t] τ_ =1[.][For][a][given] **[x]**[0][,][filtering][involves][the] design of a mapping from **y** _t_ to **x** ˆ _t_ , _∀t ∈{_ 1 _,_ 2 _, . . . , T }_ ≜ _T_ , where _T_ is the time horizon. 

## _B. Data-Aided Filtering Problem Formulation_ 

The _filtering_ problem is at the core of real-time tracking. Here, one must provide an instantaneous estimate of the state 

2 

**x** _t_ based on each incoming observation **y** _t_ in an _online_ manner. Our main focus is on scenarios where one has _partial_ knowledge of the SS model that describes the underlying dynamics. Namely, we know (or have an approximation of) the stateevolution (transition) function **f** ( _·_ ) and the state-observation (emission) function **h** ( _·_ ). For real world applications, this knowledge is derived from our understating of the system dynamics, its physical design, and the model of the sensors. As opposed to the classical assumptions in KF, the noise statistics **Q** and **R** are not known. More specifically, we assume: 

- Knowledge of the distribution of the noise signals **w** _t_ and **v** _t_ is not available. 

- The functions **f** ( _·_ ) and **h** ( _·_ ) may constitute an approximation of the true underlying dynamics. Such approximations can correspond, for instance, to the representation of continuous time dynamics in discrete time, acquisition using misaligned sensors, and other forms of mismatches. 

While we focus on filtering in partially known SS models, we assume that we have access to a labeled data set containing a sequence of observations and their corresponding ground truth states. In various scenarios of interest, one can assume access to some ground truth measurements in the design stage. For example, in field experiments it is possible to add extra sensors both internally or externally to collect the ground truth needed for training. It is also possible to compute the ground truth data using offline and more computationally intensive algorithms. Finally, the inference complexity of the learned filter should be of the same order (and preferably smaller) as that of MB filters, such as the EKF. 

## _C. Related Work_ 

A key ingredient in recursive Bayesian filtering is the _update_ operation; namely, the need to update the prior estimate using new observed information. For linear Gaussian SS using the KF, this boils down to computing the KG. While the KF assumes linear SS models, many problems encountered in practice are governed by non-linear dynamics, for which one should resort to approximations. Several extensions of the KF were proposed to deal with non-linearities. The EKF [7], [8] is a quasi-linear algorithm based on an analytical linearization of the SS model. More recent non-linear variations are based on numerical integration: UKF [10], the Gauss-Hermite Quadrature [39], and the Cubature KF [40]. For more complex SS models, and when the noise cannot be modeled as Gaussian, multiple variants of the PF were proposed that are based on sequential MC [11]–[13], [41]– [45]. These MC algorithms are considered to be asymptotically exact but relatively computationally heavy when compared to Kalman-based algorithms. These MB algorithms require accurate knowledge of the SS model, and their performance is typically degrades in the presence of model mismatch. 

The combination of machine learning and SS models, and specifically Kalman-based algorithms, is the focus of growing research attention. To frame the current work in the context of existing literature, we focus on the approaches that preserve the general structure of the SS model. The conventional 

approach to deal with partially known SS models is to impose a parametric model and then estimate its parameters. This can be achieved by jointly learning the parameters and state sequence using expectation maximization [46]–[48] and Bayesian probabilistic algorithms [37], [38], or by selecting from a set of _a priori_ known models [49]. When training data is available, it is commonly used to tune the missing parameters in advance, in a supervised or an unsupervised manner, as done in [50]–[52]. The main drawback of these strategies is that they are restricted to an imposed parametric model on the underlying dynamics (e.g., Gaussian noises). 

When one can bound the uncertainty in the SS model in advance, an alternative approach to learning is to minimize the worst-case estimation error among all expected SS models. Such robust variations were proposed for various state estimation algorithms, including Kalman variants [15]–[17], [53] and particle filters [54], [55]. The fact that these approaches aim to design the filter to be suitable for multiple different SS models typically results in degraded performance compared to operating with known dynamics. 

When the underlying system’s dynamics are complex and only partially known or the emission model is intractable and cannot be captured in a closed form—e.g., visual observations as in a computer vision task [56]—one can resort to approximations and to the use of DNNs. Variational inference [57]– [59] is commonly used in connection with SS models, as in [29]–[31], [33], [34], by casting the Bayesian inference task to optimization of a parameterized posterior and maximizing an objective. Such approaches cannot typically be applied directly to state recovery in real-time, as we consider here, and the learning procedure tends to be complex and prone to approximation errors. 

A common strategy when using DNNs is to encode the observations into some latent space that is assumed to obey a simple SS model, typically a linear Gaussian one, and track the state in the latent domain as in [56], [60], [61], or to use DNNs to estimate the parameters of the SS model as in [62], [63]. Tracking in the latent space can also be extended by applying a DNN decoder to the estimated state to return to the observations domain, while training the overall system end-toend [31], [64]. The latter allows to design trainable systems for recovering missing observations and predicting future ones by assuming that the temporal relationship can be captured as an SS model in the latent space. This form of DNNaided systems is typically designed for unknown or highly complex SS models, while we focus in this work on setups with partial domain knowledge, as detailed in Subsection II-B. Another approach is to combine RNNs [65], or variational inference [32], [66] with MC based sampling. Also related is the work [35], which used learned models in parallel with MBs algorithms operating with full knowledge of the SS model, applying a graph neural network in parallel to the Kalman smoother to improve its accuracy via neural augmentation. Estimation was performed by an iterative message passing over the entire time horizon. This approach is suitable for the smoothing task and is computationally intensive, and so may not be suitable for real-time filtering [67]. 

3 

## _D. Model-Based Kalman Filtering_ 

Our proposed KalmanNet, detailed in the following section, is based on the MB KF, which is a linear recursive estimator. In every time step _t_ , the KF produces a new estimate **x** _t_ using ˆ only the previous estimate **x** _t−_ 1 as a sufficient statistic and the new observation **y** _t_ . As a result, the computational complexity of the KF does not grow in time. We first describe the original algorithm for linear SS models, as in (2), and then discuss how it is extended into the EKF for non-linear SS models. 

The KF can be described by a two-step procedure: _prediction_ and _update_ , where in each time step _t ∈T_ , it computes the and second-order statistical moments. 

- 1) The first step _predicts_ the current _a priori_ statistical moments based on the previous _a posteriori_ estimates. Specifically, the moments of **x** are computed using the knowledge of the evolution matrix **F** as 

**==> picture [185 x 27] intentionally omitted <==**

and the moments of the observations **y** are computed based on the knowledge of the observation matrix **H** as 

**==> picture [183 x 27] intentionally omitted <==**

- 2) In the _update_ step, the _a posteriori_ state moments are computed based on the _a priori_ moments as 

**==> picture [189 x 27] intentionally omitted <==**

Here, _**K** t_ is the KG, and it is given by 

**==> picture [174 x 15] intentionally omitted <==**

The term ∆ **y** _t_ is the innovation; i.e., the difference between the predicted observation and the observed value, and it is the only term that depends on the observed data 

**==> picture [158 x 12] intentionally omitted <==**

The EKF extends the KF for non-linear **f** ( _·_ ) and/or **h** ( _·_ ), as in (1). Here, the first-order statistical moments (3a) and (4a) are replaced with 

**==> picture [171 x 27] intentionally omitted <==**

respectively. The second-order moments, though, cannot be propagated through the non-linearity, and must thus be approximated. The EKF linearizes the differentiable **f** ( _·_ ) and **h** ( _·_ ) in a time-dependent manner using their partial derivative matrices, **x** ˆ _t|t−_ 1 . Namely,also known as Jacobians, evaluated at **x** ˆ _t−_ 1 _|t−_ 1 and 

**==> picture [169 x 30] intentionally omitted <==**

where **F**[ˆ] _t_ is plugged into (3b) and **H**[ˆ] _t_ is used in (4b) and (6). When the SS model is linear, the EKF coincides with the KF, which achieves the MMSE for linear Gaussian SS models. 

**==> picture [245 x 143] intentionally omitted <==**

**----- Start of picture text -----**<br>
x 0 ˆx t<br>Z [−] [1] f x ˆ t| • t− 1 h y ˆ t|t− 1 + − ∆y t × + • x ˆ t<br>y t +<br>Σ ˆ t|t− 1 Σ ˆ Kalman t|t− 1  · H ˆ  · GainS ˆ [−] t|t [1] − 1 K t<br>S ˆ [−] t|t [1] − 1<br>S ˆ t|t− 1 {·} [−] [1] K t<br>ˆ ˆ<br>Z [−] [1] Σ t− 1 F ˆ  · {} · F ˆ [⊤] + Q ˆ ˆ • H ˆ  · {} · H ˆ [⊤] + R ˆ S ˆ t • |t− 1 K t · {} ·  K [⊤] t Σ ˆ t−|t− 1++ • Σ t<br>Σ 0 Σ ˆ t Σ t|t− 1<br>0 t = 0 t><br>0 t = 0 t><br>**----- End of picture text -----**<br>


Fig. 1: EKF block diagram. Here, _Z[−]_[1] is the unit delay. 

An illustration of the EKF is depicted in Fig. 1. The resulting filter admits an efficient linear recursive structure. However, it requires full knowledge of the underlying model and notably degrades in the presence of model mismatch. When the model is highly non-linear, the local linearity approximation may not hold, and the EKF can result in degraded performance. This motivates the augmentation of the EKF into the deep learning-aided KalmanNet, detailed next. 

## III. KALMANNET 

Here, we present _KalmanNet_ ; a hybrid, interpretable, data efficient architecture for real-time state estimation in nonlinear dynamical systems with partial domain knowledge. KalmanNet combines MB Kalman filtering with an RNN to cope with model mismatch and non-linearities. To introduce KalmanNet, we begin by explaining its high level operation in Subsection III-A. Then we present the features processed by its internal RNN and the specific architectures considered for implementing and training KalmanNet in Subsections III-BIII-D. Finally, we provide a discussion in Subsection III-E. 

## _A. High Level Architecture_ 

We formulate KalmanNet by identifying the specific computations of the EKF that are based on unavailable knowledge. As detailed in Subsection II-B, the functions **f** ( _·_ ) and **h** ( _·_ ) are known (though perhaps inaccurately); yet the covariance matrices **Q** and **R** are unavailable. These missing statistical moments are used in MB Kalman filtering only for computing the KG (see Fig. 1). Thus, we design KalmanNet to learn the KG from data, and combine the learned KG in the overall KF flow. This high level architecture is illustrated in Fig. 2. 

In each time instance _t ∈ T_ , similarly to the EKF, KalmanNet estimates **x** ˆ _t_ in two steps; _prediction_ and _update_ . 

- 1) The _prediction_ step is the same as in the MB EKF, except that only the first-order statistical moments are predicted. In particular, a prior estimate for the currentˆ state **x** ˆ _t|t−_ 1 is computed from the previous posterior **x** _t−_ 1 via (8a). Then,is computeda priorfromestimate **x** ˆ _t|t−_ for1 viathe(8bcurrent). As observationopposed to its **y** ˆ _t|_ MB _t−_ 1 counterparts, KalmanNet does not rely on the knowledge of noise distribution and does not maintain an explicit estimate of the second-order statistical moments. 

4 

**==> picture [511 x 185] intentionally omitted <==**

**----- Start of picture text -----**<br>
x 0 ˆx t|t ˆ<br>x t|t− 1 t = 0 [h] [0]<br>Z [−] [1] t > 0<br>Z [−] [1] [x] [ˆ] • [t][−] [1] f • h ˆ − Fully connected h t− 1 Fully connected<br>y t|t− 1 + ∆y • t + • [x] [ˆ] [t][|][t] linear input layer GRU linear output layer<br>+<br>y t ×<br>Z [−] [1] ∆ ˆx t− 1<br>∆y t K t<br>+ Kalman Gain ∆ y t h t K t<br>− + ∆ˆx t− 1<br>Recurrent Neural Network<br>Fig. 2: KalmanNet block diagram.<br>2) In the update step, KalmanNet uses the new observation ∆ ˆx t− 1 ∈ R [m] h t<br>ˆ ∆ y t ∈ R [n] K t ∈ R [m][×][n]<br>y t to compute the current state posterior x t from the<br>0 t = 0 t><br>t 1 h −<br>×<br>MW σ t r<br>•<br>•<br>ZW σ t z ×<br>-1<br>W tanh t ˆh × +<br>t h<br>**----- End of picture text -----**<br>


- 2) In the _update_ step, KalmanNet uses the new observation **y** _t_ to compute the current state posterior **x** ˆ _t_ from the previously computed prior **x** ˆ _t|t−_ 1 in a similar manner to the MB KF as in (5a), i.e., using the innovation term ∆ **y** _t_ computed via (7) and the KG _**K** t_ . As opposed to the MB EKF, here the computation of the KG is not given explicitly; rather, it is learned from data using an RNN, as illustrated in Fig. 2. The inherent memory of RNNs allows to implicitly track the second-order statistical moments without requiring knowledge of the underlying noise statistics. 

Fig. 3: KalmanNet RNN block diagram (architecture #1). The architecture comprises a fully connected input layer, followed by a GRU layer (whose internal division into gates is illustrated [21]) and an output fully connected layer. Here, the input features are _F2_ and _F4_ . 

uncertainty of our state estimate. The difference operation removes the predictable components, and thus the time series of differences is mostly affected by the noise statistics that we wish to learn. The RNN described in Fig. 2 can use all the features, although extensive empirical evaluation suggests that the specific choice of combination of features depends on the problem at hand. Our empirical observations indicate that good combinations are _{F1_ , _F2_ , _F4}_ and _{F1_ , _F3_ , _F4}_ . 

- Designing an RNN to learn how to compute the KG as part of an overall KF flow requires answers to three key questions: 

- 1) From which input features (signals) will the network learn the KG? 

- 2) What should be the architecture of the internal RNN? 

- 3) How will this network be trained from data? 

In the following sections we address these questions. 

## _B. Input Features_ 

The MB KF and its variants compute the KG from knowledge of the underlying statistics. To implement such computations in a learned fashion, one must provide input (features) that capture the knowledge needed to evaluate the KG to a neural network. The dependence of _**K** t_ on the statistics of the observations and the state process indicates that in order to track it, in every time step _t ∈T_ , the RNN should be provided with input containing statistical information of the ˆ observations **y** _t_ and the state-estimate **x** _t−_ 1. Therefore, the following quantities that are related to the unknown statistical relationship of the SS model can be used as input features to the RNN: 

- _F1_ The _observation difference_ ∆˜ **y** _t_ = **y** _t −_ **y** _t−_ 1. 

- ˆ 

- _F2_ The _innovation difference_ ∆ **y** _t_ = **y** _t −_ **y** _t|t−_ 1 . 

- ˆ ˆ 

- _F3_ The _forward evolution difference_ ∆˜ **x** _t_ = **x** _t|t −_ **x** _t−_ 1 _|t−_ 1 . This quantity represents the difference between two consecutive posterior state estimates, where for time instance _t_ , the available feature is ∆˜ **x** _t−_ 1. 

- ˆ ˆ 

- _F4_ The _forward update difference_ ∆ˆ **x** _t_ = **x** _t|t −_ **x** _t|t−_ 1 , i.e., the difference between the posterior state estimate and the prior state estimate, where again for time instance _t_ we use ∆ˆ **x** _t−_ 1. 

Features _F1_ and _F3_ encapsulate information about the stateevolution process, while features _F2_ and _F4_ encapsulate the 

## _C. Neural Network Architecture_ 

The internal DNN of KalmanNet uses the features discussed in the previous section to compute the KG. It follows from (6) that computing the KG _**K** t_ involves tracking the secondorder statistical moments **Σ** _t_ . The recursive nature of the KG computation indicates that its learned module should involve an internal memory element as an RNN to track it. 

We consider two architectures for the KG computing RNN. The first, illustrated in Fig. 3, aims at using the internal memory of RNNs to jointly track the underlying secondorder statistical moments required for computing the KG in an implicit manner. To that aim, we use GRU cells [21] whose hidden state is of the size of some integer product of _m_[2] + _n_[2] , which **Σ** ˆ _t|t−_ 1 isin the(3b),jointand dimensionality **S** ˆ _t_ in (4b). In ofparticular,the trackedwe firstmomentsuse a fully connected (FC) input layer whose output is the input to the GRU. The GRU state vector **h** _t_ is mapped into the estimated KG _**K** t ∈_ R _[m][×][n]_ using an output FC layer with _m · n_ neurons. While the illustration in Fig. 3 uses a single GRU layer, one can also utilize multiple layers to increase the capacity and abstractness of the network, as we do in the numerical study reported in Subsection IV-E. The proposed architecture does not directly design the hidden state of the GRU to correspond to the unknown second-order statistical moments that are tracked by the MB KF. As such, it uses a relatively large number of state variables that are expected to provide the required tracking capacity. For example, in the 

5 

**==> picture [249 x 235] intentionally omitted <==**

**----- Start of picture text -----**<br>
Q ˆ 0 Z [−] [1] tt > = 00 GRU Q ˆ 1 ∆ˆ x t− 1 ∆ˆ∆∆∆ xxyy �� tttt ====  y yxx ˆˆ tttt|| − −tt −− yy ˆ tt xx ˆˆ |−ttt− 1 |−t 1 − 1 | 1 t− 1<br>Q t<br>Z [−] [1] Σ ˆ t|t<br>Σ ˆ 0 tt > = 00 GRU Σ ˆ 2 ∆ x � t− 1<br>Σ ˆ t|t− 1<br>Z [−] [1]<br>ˆ t > 0 GRUˆ 3 ∆ y � t<br>R 0 t = 0 S ∆ y t<br>S ˆ t<br>K t<br>**----- End of picture text -----**<br>


Fig. 4: KalmanNet RNN block diagram (architecture #2). The input features are used to update three GRUs with dedicated FC layers, and the overall interconnection between the blocks is based on the flow of the KG computation in the MB KF. 

numerical study in Section IV we set the dimensionality of **h** _t_ to be 10 _·_ ( _m_[2] + _n_[2] ). This often results in substantial overparameterization, as the number of GRU parameters grows quadratically with the number of state variables [68]. 

The second architecture uses separate GRU cells for each of the tracked second-order statistical moments. The division of the architecture into separate GRU cells and FC layers and their interconnection is illustrated in Fig. 4. As shown in the figure, the network composes three GRU layers, connected in a cascade with dedicated input and output FC layers. The first GRU layer tracks the unknown state noise covariance **Q** , thus tracking _m_[2] variables. Similarly, the second and third GRUs track the predicted moments **Σ**[ˆ] _t|t−_ 1 (3b) and **S**[ˆ] _t_ (4b), thus having _m_[2] and _n_[2] hidden state variables, respectively. The GRUs are interconnected such that the learned **Q** is used to compute **Σ** ˆ _t|t−_ 1 and **Σ**[ˆ] _t|_ **S** ˆ _t−t_ 1are, which in turn is used to obtaininvolved in producing _**K** t_ (6 **S**[ˆ] ). _t_ , while bothThis architecture, which is composed of a non-standard interconnection between GRUs and FC layers, is more directly tailored towards the formulation of the SS model and the operation of the MB KF compared with the simpler first architecture. As such, it provides lesser abstraction; i.e., it is expected to be more constrained in the family of mappings it can learn compared with the first architecture, while as a result also requiring less trainable parameters. For instance, in the numerical study reported in Subsection IV-D, utilizing the first architecture requires the order of 5 _·_ 10[5] trainable parameters, while the second architecture utilizes merely 2 _._ 5 _·_ 10[4] parameters. 

## _D. Training Algorithm_ 

KalmanNet is trained using the available labeled data set in a supervised manner. While we use a neural network for computing the KG rather than for directly producing the 

computeestimate **x** theˆ _t|t_ ,losswe functiontrain KalmanNet _L_ based onend-to-end.the state Namely,estimate **x** weˆ _t_ , which is not the output of the internal RNN. Since this vector takes values in a continuous set R _[m]_ , we use the squared-error loss, 

**==> picture [163 x 15] intentionally omitted <==**

which is also used to evaluate the MB KF. By doing so, we build upon the ability to backpropagate the loss to the computation of the KG. One can obtain the loss gradient with respect to the KG from the output of KalmanNet since 

**==> picture [202 x 40] intentionally omitted <==**

where ∆ **x** _t_ ≜ **x** _t −_ **x** ˆ _t|t−_ 1. The gradient computation in (11) indicates that one can learn the computation of the KG by training KalmanNet end-to-end using the squared-error loss. In particular, this allows to train the overall filtering system without having to externally provide ground truth values of the KG for training purposes. 

The data set used for training comprises _N_ trajectories that can be of varying lengths. Namely, by letting _Ti_ be the length of the _i_ th training trajectory, the data set is given by _D_ = _{_ ( **Y** _i,_ **X** _i_ ) _}[N]_ 1[,][where] 

**==> picture [245 x 15] intentionally omitted <==**

By letting **Θ** denote the trainable parameters of the RNN, and _γ_ be a regularization coefficient, we then construct an _ℓ_ 2 regularized mean-squared error (MSE) loss measure 

**==> picture [242 x 30] intentionally omitted <==**

To optimize **Θ** , we use a variant of mini-batch stochastic gradient descent in which for every batch indexed by _k_ , we choose _M < N_ trajectories indexed by _i[k]_ 1 _[, . . . , i][k] M_[, computing] the mini-batch loss as 

**==> picture [181 x 31] intentionally omitted <==**

Since KalmanNet is a recursive architecture with both an external recurrence and an internal RNN, we use the backpropagation through time (BPTT) algorithm [69] to train it. Specifically, we unfold KalmanNet across time with shared network parameters, and then compute a forward and backward gradient estimation pass through the network. We consider three different variations of applying the BPTT algorithm for training KalmanNet: 

- _V1_ Direct application of BPTT, where for each training iteration the gradients are computed over the entire trajectory. 

- _V2_ An application of the truncated BPTT algorithm [70]. Here, given a data set of long trajectories (e.g., _T_ = 3000 time steps), each long trajectory is divided into multiple short trajectories (e.g., _T_ = 100 time steps), which are shuffled and used during training. 

- _V3_ An alternative application of truncated BPTT, where we 

6 

truncate each trajectory to a fixed (and relatively short) length, and train using these short trajectories. 

Overall, directly applying BPTT via _V1_ may be computationally expensive and unstable. Therefore, a favored approach is to first use the truncated BPTT as in _V2_ as a warm-up phase (train first on short trajectories) in order to stabilize its learning process, after which KalmanNet is tuned using _V1_ . The procedure in _V3_ is most suitable for systems that are known to be likely to quickly converge to a steady state (e.g., linear SS models). In our numerical study, reported in Section IV, we utilize all three approaches. 

## _E. Discussion_ 

KalmanNet is designed to operate in a hybrid DD/MB manner, combining deep learning with the classical EKF procedure. By identifying the specific noise-model-dependent computations of the EKF and replacing them with a dedicated RNN integrated in the EKF flow, KalmanNet benefits from the individual strengths of both DD and MB approaches. The augmentation of the EKF with dedicated deep learning modules results in several core differences between KalmanNet and its MB counterpart. Unlike the MB EKF, KalmanNet does not attempt to linearize the SS model, and does not impose a statistical model on the noise signals. In addition, KalmanNet filters in a non-linear manner, as its KG matrix depends on the input **y** _t_ . Due to these differences, compared to MB Kalman filtering, KalmanNet is more robust to model mismatch and can infer more efficiently, as demonstrated in Section IV. In particular, the MB EKF is sensitive to inaccuracies in the underlying SS model, e.g., in **f** ( _·_ ) and **h** ( _·_ ), while KalmanNet can overcome such uncertainty by learning an alternative KG that yields accurate estimation. 

Furthermore, KalmanNet is derived for SS models when noise statistics are not specified explicitly. A MB approach to tackle this without relying on data employs the robust Kalman filter [15]–[17], which designs the filter to minimize the maximal MSE within some range of assumed SS models, at the cost of performance loss, compared to knowing the true model. When one has access to data, the direct strategy to implement the EKF in such setups is to use the data to estimate **Q** and **R** , either directly from the data or by backpropagating through the operation of the EKF as in [51], and utilize these estimates to compute the KG. As covariance estimation can be a challenging task when dealing with high-dimensional signals, KalmanNet bypasses this need by directly learning the KG, and by doing so approaches the MSE of MB Kalman filtering with full knowledge of the SS model, as demonstrated in Section IV. Finally, the computation complexity for each time step _t ∈T_ is also linear in the RNN dimensions and does not involve matrix inversion. This implies that KalmanNet is a good candidate to apply for high dimensional SS models and on computationally limited devices. 

Compared to purely DD state estimation, KalmanNet benefits from its model awareness and the fact that its operation follows the flow of MB Kalman filtering rather than being utilized as a black box. As numerically observed in Section IV, KalmanNet achieves improved MSE compared to utilizing 

RNNs for end-to-end state estimation, and also approaches the MMSE performance achieved by the MB KF in linear Gaussian SS models. Furthermore, the fact that KalmanNet preserves the flow of the EKF implies that the intermediate features exchanged between its modules have a specific operation meaning, providing interpretability that is often scarce in end-to-end, deep learning systems. Finally, the fact that KalmanNet learns to compute the KG indicates the possibility of providing not only estimates of the state **x** _t_ , but also a measure of confidence in this estimate, as the KG can be related to the covariance of the estimate, as initially explored in [71]. 

These combined gains of KalmanNet over purely MB and DD approaches were recently observed in [72], which utilized an early version of KalmanNet for real-time velocity estimation in an autonomous racing car. In such a setup, a nonlinear, MB mixed KF was traditionally used, and suffered from performance degradation due to inherent mismatches in the formulation of the SS model describing the problem. Nonetheless, previously proposed DD techniques relying on RNNs for end-to-end state estimation were not operable in the desired frequencies on the hardware limited vehicle control unit. It was shown in [72] that the application of KalmanNet allowed to achieve improved real-time velocity tracking compared to MB techniques while being deployed on the control unit of the vehicle. 

Our design of KalmanNet gives rise to many interesting future extensions. Since we focus here on SS models where the mappings **f** ( _·_ ) and **h** ( _·_ ) are known up to some approximation errors, a natural extension of KalmanNet is to use the data to pre-estimate them, as demonstrated briefly in the numerical study. Another alternative to cope with these approximation errors is to utilize dedicated neural networks to learn these mappings while training the entire model in an end-to-end fashion. Doing so is expected to allow KalmanNet to be utilized in scenarios with analytically intractable SS models, as often arises when tracking based on unstructured observations, e.g., visual observations as in [56]. 

While we train KalmanNet in a supervised manner using labeled data, the fact that it preserves the operation of the MB EKF that produces a prediction of the next observation ˆ **y** _t|t−_ 1 for each time instance indicates the possibility of using this intermediate feature for _unsupervised_ training. One can thus envision KalmanNet being trained offline in a supervised manner, while tracking variations in the underlying SS model at run-time by online self supervision, following a similar rationale to that used in [24], [25] for deep symbol detection in time-varying communication channels. 

Finally, we note that while we focus here on filtering tasks, SS models are used to represent additional related problems such as smoothing and prediction, as discussed in Subsection II-A. The fact that KalmanNet does not explicitly estimate the SS model implies that it cannot simply substitute these parameters into an alternative algorithm capable of carrying out tasks other than filtering. Nonetheless, one can still design DNN-aided algorithms for these tasks operating with partially known SS models as extensions of KalmanNet, in the same manner as many MB algorithms build upon the 

7 

KF. For instance, as the MB KF constitutes the first part of the Rauch-Tung-Striebel smoother [73], one can extend KalmanNet to implement high-performance smoothing in partially known SS models, as we have recently began investigating in [67]. Nonetheless, we leave the exploration of extensions of KalmanNet to alternative tasks associated with SS models for future work. 

## IV. EXPERIMENTS AND RESULTS 

In this section we present an extensive numerical study of KalmanNet[1] , evaluating its performance in multiple setups and comparing it to various benchmark algorithms: 

- (a) In our first experimental study, we consider multiple _linear_ SS models, and compare KalmanNet to the MB KF which is known to minimize the MSE in such a setup. We also confirm our design and architectural choices by comparing KalmanNet with alternative RNN based endto-end state estimators. 

- (b) We next consider two _non-linear_ SS models, a sinusoidal model, and the chaotic Lorenz attractor. We compare KalmanNet with the common non-linear MB benchmarks; namely, the EKF, UKF, and PF. 

- (c) In our last study we consider a _localization_ use case based on the Michigan NCLT data set [28]. Here, we compare KalmanNet with MB KF that assumes a linear _Wiener kinematic_ model [36] and with a _vanilla_ RNN based end-to-end state estimator, and demonstrate the ability of KalmanNet to track real world dynamics that was not synthetically generated from an underlying SS model. 

In some of our experiments, we evaluate both the MSE and its standard deviation, where we denote these measures by _µ_ ˆ and _σ_ ˆ, respectively. 

_1) KalmanNet Setting:_ In Section III we present several architectures and training mechanisms that can be used when implementing KalmanNet. In our experimental study we consider three different configurations of KalmanNet: 

- _C1_ KalmanNet architecture #1 with input features _{F2_ , _F4}_ and with training algorithm _V3_ . 

- _C2_ KalmanNet architecture #1 with input features _{F2_ , _F4}_ and with training algorithm _V1_ . 

- _C3_ KalmanNet architecture #1 with input features _{F1_ , _F3_ , _F4}_ and with training algorithm _V2_ . 

- _C4_ KalmanNet architecture #2 with all input features and with training algorithm _V1_ . 

In all our experiments KalmanNet was trained using the Adam optimizer [74]. 

_2) Model-Based Filters:_ In the following experimental study we compare KalmanNet with several MB filters. For the UKF we used the software package [75], while the PF is implemented based on [76] using 100 particles and without parallelization. During our numerical study, when model uncertainty was introduced, we optimized the performance of the MB algorithms by carefully tuning the covariance matrices, usually via a grid search. For long trajectories (e.g., _T >_ 1500) it was sometimes necessary to tune these matrices, even in the case of full information, to compensate for inaccurate uncertainty propagation due to non-linear approximations and to avoid divergence. 

## _A. Experimental Setting_ 

Throughout the numerical study and unless stated otherwise, in the experiments involving synthetic data, the SS model is generated using diagonal noise covariance matrices; i.e., 

**==> picture [201 x 22] intentionally omitted <==**

By (15), setting _ν_ to be 0 dB implies that both the state noise and the observation noise have the same variance. For consistency, we use the term _full information_ for cases where the SS model available to KalmanNet and its MB counterparts accurately represents the underlying dynamics. More specifically, KalmanNet operates with full knowledge of **f** ( _·_ ) and **h** ( _·_ ), and without access to the noise covariance matrices, while its MB counterparts operate with an accurate knowledge of **Q** and **R** . The term _partial information_ refers to the case where KalmanNet and its MB counterparts operate with some level of model mismatch, where the SS model design parameters do not represent the underlying dynamics accurately (i.e., are not equal to the SS parameters from which the data was generated). Unless stated otherwise, the metric used to evaluate the performance is the MSE on a [dB] scale. In the figures we depict the MSE in [dB] versus the inverse observation noise level, i.e., r1[2][,][also][on][a][[][dB][]][scale.] 

> 1The source code used in our numerical study along with the complete set of hyperparameters used in each numerical evaluation can be found online at https://github.com/KalmanNet/KalmanNet TSP. 

## _B. Linear State Space Model_ 

Our first experimental study compares KalmanNet to the MB KF for different forms of synthetically generated linear system dynamics. Unless stated otherwise, here **F** takes the controllable canonical form. 

_1) Full Information:_ We start by comparing KalmanNet of setting _C1_ to the MB KF for the case of full information, where the latter is known to minimize the MSE. Here, we set **H** to take the inverse canonical form, and _ν_ = 0 [dB]. To demonstrate the applicability of KalmanNet to various linear systems, we experimented with systems of different dimensions; namely, _m × n ∈{_ 2 _×_ 2 _,_ 5 _×_ 5 _,_ 10 _×_ 1 _}_ , and with trajectories of different lengths; namely, _T ∈{_ 50 _,_ 100 _,_ 150 _,_ 200 _}_ . In Fig. 5a we can clearly observe that KalmanNet achieves the MMSE of the MB KF. Moreover, to further evaluate the gains of the hybrid architecture of KalmanNet, we check that its learning is transferable. Namely, in some of the experiments, we test KalmanNet on longer trajectories then those it was trained on, and with different initial conditions. The fact that KalmanNet achieves the MMSE lower bound also for these cases indicates that it indeed learns to implement Kalman filtering, and it is not tailored to the trajectories presented during training, with dependency only on the SS model. 

_2) Neural Model Selection:_ Next, we evaluate and confirm our design and architectural choices by considering a 2 _×_ 2 

8 

**==> picture [502 x 158] intentionally omitted <==**

**----- Start of picture text -----**<br>
40 0 -17<br>30 -2 -17.5-18<br>-4 -18.5<br>20 -6 -19<br>-19.5<br>10 -8 -20<br>-10 -20.5<br>0 -21<br>-12 -21.5<br>-10 3.84 -14 -22<br>3.6 -22.5 0 20 40 60 80 100 120<br>3.4 -16<br>-20 3.22.83 -18<br>-30 2.62.4 -20<br>2.2<br>-40 2-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 -22 0 100 200 300 400 500 600 700 800 900 1000<br>-10 -5 0 5 10 15 20 25 30 35 40<br>(a) KalmanNet converges to MMSE. (b) Learning curves for DD state estimation.<br>MSE [dB] MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 5: Linear SS model with full information. 

setup (similar to the previous one), and by comparing KalmanNet with setting _C1_ to two RNN based architectures of similar capacity applied for end-to-end state estimation: 

- _Vanilla RNN_ directly maps the observed **y** _t_ to an estimate of the state **x** ˆ _t_ . 

- _MB RNN_ imitates the Kalman filtering operation by first recovering **x** ˆ _t|t−_ 1 using domain knowledge, i.e., via (3a), and then uses the RNN to estimate an increment ∆ˆ **x** _t_ from the prior to posterior. 

All RNNs utilize the same architecture as in KalmanNet with a single GRU layer and the same learning hyperparameters. In this experiment we test the trained models on trajectories with the same length as they were trained on, namely _T_ = 20. We can clearly observe how each of the key design considerations of KalmanNet affect the learning curves depicted in Fig. 5b: 

- The incorporation of the known SS model allows the MB RNN to outperform the vanilla RNN, although both converge slowly and fail to achieve the MMSE. 

- Using the sequences of differences as input notably improves the convergence rate of the MB RNN, indicating the benefits of using the differences as features, as discussed in Subsection III-B. 

- Learning is further improved by using the RNN for recovering the KG as part of the KF flow, as done by KalmanNet, rather than for directly estimating **x** _t_ . 

To further evaluate the gains of KalmanNet over end-to-end RNNs, we compare the pre-trained models using trajectories with different initial conditions and a longer time horizon ( _T_ = 200) than the one on which they were trained ( _T_ = 20). The results, summarized in Table I, show that KalmanNet maintains achieving the MMSE, as already observed in Fig. 5a. The MB RNN and vanilla RNN are more than 50 [dB] from the MMSE, implying that their learning is not transferable and that they do not learn to implement Kalman filtering. However, when provided with the difference features as we proposed in Subsection III-B, the DD systems are shown to be applicable in longer trajectories, with KalmanNet achieving MSE within a minor gap of that achieved by the MB KF. The results of this study validate the considerations used in designing KalmanNet for the DD filtering problem discussed in Subsection II-B. 

TABLE I: Test MSE in [dB] when trained using _T_ = 20. 

|Test _T_<br>Vanilla RNN<br>MB RNN|MB RNN, diff.<br>KalmanNet<br>KF|
|---|---|
|20<br>-20.98<br>-21.53|-21.92<br>-21.92<br>**-21.97**|
|200<br>58.14<br>36.8|-21.88<br>-21.90<br>**-21.91**|



_3) Partial Information:_ To conclude our study on linear models, we next evaluate the robustness of KalmanNet to model mismatch as a result of partial model information. We simulate a 2 _×_ 2 SS model with mismatches in either the stateevolution model ( **F** ) or in the state-observation model ( **H** ). 

_State-Evolution Mismatch:_ Here, we set _T_ = 20 and _ν_ = 0 [dB] and use a rotated evolution matrix **F** _α◦ , α ∈{_ 10 _[◦] ,_ 20 _[◦] }_ for data generation. The state-evolution matrix available to the filters, denoted **F** 0, is again set to take the controllable canonical form. The mismatched design matrix **F** 0 is related to true **F** _α◦_ via 

**==> picture [232 x 25] intentionally omitted <==**

Such scenarios represent a setup in which the analytical approximation of the SS model differs from the true generative model. The resulting MSE curves depicted in Fig. 6a demonstrate that KalmanNet (with setting _C2_ ) achieves a 3 [dB] gain over the MB KF. In particular, despite the fact that KalmanNet implements the KF with an inaccurate state-evolution model, it learns to apply an alternative KG, resulting in MSE within a minor gap from the MMSE; i.e., from the KF with the true **F** _α◦_ plugged in. 

_State-Observation Mismatch:_ Next, we simulate a setup with state-observation mismatch while setting _T_ = 100 and _ν_ = _−_ 20 [dB]. The model mismatch is achieved by using a rotated observation matrix **H** _α_ =10 _[◦]_ for data generation, while using **H** = **I** as the observation design matrix. Such scenarios represent a setup in which a slight misalignment ( _≈_ 5%) of the sensors exists. The resulting achieved MSE depicted in Fig. 6b demonstrates that KalmanNet (with setting _C2_ ) converges to within a minor gap from the MMSE. Here, we performed an additional experiment, first estimating the observation matrix fromdenoteddata, **H** ˆ _α_ and. Inthenthis KalmanNetcase it is observedused the inestimateFig. 6bmatrixthat KalmanNet achieves the MMSE lower bound. These results imply that KalmanNet converges also in distribution to the 

9 

TABLE II: Non-linear toy problem parameters. 

||_α_|_β_|_φ_|_δ_|_a_|_b_|_c_|
|---|---|---|---|---|---|---|---|
|Full|0_._9|1_._1|0_._1_π_|0_._01|1|1|0|
|Partial|1|1|0|0|1|1|0|



KF. 

## _C. Synthetic Non-Linear Model_ 

Next, we consider a non-linear SS model, where the stateevolution model takes a sinusoidal form, while the stateobservation model is a second order polynomial. The resulting SS model is given by 

**==> picture [229 x 29] intentionally omitted <==**

In the following we generate trajectories of _T_ = 100 time steps from the noisy SS model in (1), with _ν_ = _−_ 20 [dB], while using **f** ( _·_ ) and **h** ( _·_ ) as in (17) computed in a component-wise manner, with parameters as in Table II. KalmanNet is used with setting _C4_ . 

The MSE values for different levels of observation noise achieved by KalmanNet compared with the MB EKF are depicted in Fig. 7 for both full and partial model information. The full evaluation with the MB EKF, UKF, and PF is given in Table III for the case of full information, and in Table IV for the case of partial information. We first observe that the EKF achieves the lowest MSE values among the MB filters, therefore serving as our main MB benchmark in our experimental studies. For full information and in the low noise regime, EKF achieves the lowest MSE values due to its ability to approach the MMSE in such setups, and KalmanNet achieves similar 1 performance. For higher noise levels; i.e., for r[2][=] _[−]_[12] _[.]_[04] [dB], the MB EKF suffers from degraded performance due to a non-linear effect. Nonetheless, by learning to compute the KG from data, KalmanNet manages to overcome this and achieves superior MSE. 

In the presence of partial model information, the stateevolution parameters used by the filters differs slightly from the true model, resulting in a notable degradation in the performance of the MB filters due to the model mismatch. In all experiments, KalmanNet overcomes such mismatches, and its performance is within a small gap of that achieved when using full information for such setups. We thus conclude that in the presence of harsh non-linearities as well as model uncertainty due to inaccurate approximation of the underlying dynamics, where MB variations of the KF fail, KalmanNet learns to approach the MMSE while maintaining the real-time operation and low complexity of the KF. 

## _D. Lorenz Attractor_ 

The Lorenz attractor is a three-dimensional chaotic solution to the Lorenz system of ordinary differential equations in continuous-time. This synthetically generated system demonstrates the task of online tracking a highly non-linear trajectory and a real world practical challenge of handling mismatches due to sampling a continuous-time signal into discrete-time [77]. 

TABLE III: MSE [dB] – Synthetic non-linear SS model; full information. 

|ormation.|ormation.||||||
|---|---|---|---|---|---|---|
|1_/_r2 [dB]||_−_12_._04|_−_6_._02|0|20|40|
|EKF|ˆ_µ_<br>ˆ_σ_|-6.23<br>_±_0_._89|**-13.41**<br>_±_0_._53|**-19.58**<br>_±_0_._47|**-39.78**<br>_±_0_._43|**-59.67**<br>_±_0_._44|
|UKF|ˆ_µ_<br>ˆ_σ_|-6.48<br>_±_0_._69|-13.14<br>_±_0_._49|-18.43<br>_±_0_._50|-27.24<br>_±_0_._55|-37.27<br>_±_0_._31|
|PF|ˆ_µ_<br>ˆ_σ_|-6.59<br>_±_0_._74|-13.33<br>_±_0_._48|-18.78<br>_±_0_._39|-26.70<br>_±_0_._07|-30.98<br>_±_0_._02|
|KalmanNet|ˆ_µ_<br>ˆ_σ_|**-7.25**<br>_±_0_._49|-13.19<br>_±_0_._52|-19.22<br>_±_0_._55|-39.13<br>_±_0_._49|-59.10<br>_±_0_._53|



TABLE IV: MSE [dB] – Synthetic non-linear SS model; partial information. 

|ormation.|ormation.||||||
|---|---|---|---|---|---|---|
|1_/_r2 [dB]||_−_12_._04|_−_6_._02|0|20|40|
|EKF|ˆ_µ_<br>ˆ_σ_|-2.99<br>_±_0_._63|-5.07<br>_±_0_._89|-7.57<br>_±_0_._45|-22.67<br>_±_0_._42|-36.55<br>_±_0_._3|
|UKF|ˆ_µ_<br>ˆ_σ_|-0.91<br>_±_0_._60|-1.54<br>_±_0_._23|-5.18<br>_±_0_._29|-24.06<br>_±_0_._43|-37.96<br>_±_2_._21|
|PF|ˆ_µ_<br>ˆ_σ_|-2.32<br>_±_0_._89|-3.29<br>_±_0_._53|-4.83<br>_±_0_._64|-23.66<br>_±_0_._48|-33.13<br>_±_0_._45|
|KalmanNet|ˆ_µ_<br>ˆ_σ_|**-6.62**<br>_±_0_._46|**-11.60**<br>_±_0_._45|**-15.83**<br>_±_0_._44|**-34.23**<br>_±_0_._58|**-45.29**<br>_±_0_._64|



In particular, the noiseless state-evolution of the continuoustime process **x** _τ_ with _τ ∈_ R[+] is given by 

**==> picture [247 x 37] intentionally omitted <==**

To get a discrete-time, state-evolution model, we repeat the steps used in [35]. First, we sample the noiseless process with sampling interval ∆ _τ_ and assume that **A** ( **x** _τ_ ) can be kept constant in a small neighborhood of **x** _τ_ ; i.e., 

**==> picture [95 x 11] intentionally omitted <==**

Then, the continuous-time solution of the differential system (18), which is valid in the neighborhood of **x** _τ_ for a short time interval ∆ _τ_ , is 

**==> picture [196 x 11] intentionally omitted <==**

Finally, we take the Taylor series expansion of (19) and a _finite_ series approximation (with _J_ coefficients), which results in 

**==> picture [248 x 32] intentionally omitted <==**

The resulting discrete-time evolution process is given by 

**==> picture [185 x 10] intentionally omitted <==**

The discrete-time state-evolution model in (21), with additional process noise, is used for generating the simulated Lorenz attractor data. Unless stated otherwise the data was generated with _J_ = 5 Taylor order and ∆ _τ_ = 0 _._ 02 sampling interval. In the following experiments, KalmanNet is consistently invariant of the distribution of the noise signals, with the models it uses for **f** ( _·_ ) and **h** ( _·_ ) varying between the different studies, as discussed in the sequel. 

_1) Full Information:_ We first compare KalmanNet to the MB filter when using the state-evolution matrix **F** computed via (20) with _J_ = 5. 

10 

**==> picture [502 x 163] intentionally omitted <==**

**----- Start of picture text -----**<br>
10<br>20<br>5<br>10 0<br>-5<br>0<br>-10<br>-10<br>-15<br>2 -9<br>-20 1.50.51 -20 -10-11<br>-30 -0.5-10 -25 -12-13-14<br>-40 -1.5-2.5-2-3-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 -30-35 -15-16-17<br>9.75 9.8 9.85 9.9 9.95 10 10.05 10.1 10.15 10.2 10.25<br>-10 -5 0 5 10 15 20 25 30 35 40 -10 -5 0 5 10 15 20 25 30<br>(a) State-evolution mismatch. (b) State-observation mismatch.<br>MSE [dB] MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 6: Linear SS model, partial information. 

**==> picture [252 x 140] intentionally omitted <==**

**----- Start of picture text -----**<br>
20<br>10<br>0<br>-10<br>-20<br>-2<br>-30 -3<br>-4<br>-40 -5<br>-6<br>-50 -7<br>-60 -8 -12 -11.9 -11.8 -11.7 -11.6 -11.5 -11.4 -11.3 -11.2 -11.1 -11<br>-10 -5 0 5 10 15 20 25 30 35 40<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 7: Non-linear SS model. KalmanNet outperforms EKF. 

TABLE V: MSE [dB] – Lorenz attractor with noisy state observations. 

|rvations.|||||
|---|---|---|---|---|
|1_/_r2 [dB]|0|10<br>20|30|40|
|EKF|**-10.**|**45**<br>**-20.37**<br>**-30.40**|**-40.39**<br>**-**|**49.89**|
|UKF|-5.|62<br>-12.04<br>-20.45|-30.05<br>-|40.00|
|PF|-9.|78<br>-18.13<br>-23.54|-30.16<br>-|33.95|
|KalmanNet|-9.|79<br>-19.75<br>-29.37|-39.68<br>-|48.99|



**Noisy state observations** : Here, we set **h** ( _·_ ) to be the identity transformation, such that the observations are noisy versions of the true state. Further, we set _ν_ = _−_ 20 [dB] and _T_ = 2000. As observed in Fig. 8a, despite being trained on short trajectories _T_ = 100, KalmanNet (with setting _C3_ ) achieves excellent MSE performance—namely, comparable to EKF—and outperforms the UKF and PF. The full details of the experiment are given in Table V. All the MB algorithms were optimized for performance; e.g., applying the EKF with full model information achieves an unstable state tracking performance, with MSE values surpassing 30 [dB]. To stabilize the EKF, we had to perform a grid search using the available data set to optimize the process noise **Q** used by the filter. 

**Noisy non-linear observations** : Next, we consider the case where the observations are given by a non-linear function of the current state, setting **h** to take the form of a transformation from a cartesian coordinate system to spherical coordinates. We further set _T_ = 20 and _ν_ = 0 [dB]. From the results depicted in Fig. 8b and reported in Table VI we observe that 

TABLE VI: MSE [dB] – Lorenz attractor with non-linear observations 

||1_/_r2 [dB]|_−_10|0|10|20|30|
|---|---|---|---|---|---|---|
||EKF|26.38|21.78|14.50|4.84|-4.02|
||UKF<br>PF<br>KalmanNet|nan<br>24.85<br>**14.55**|nan<br>20.91<br>**6.77**|nan<br>14.23<br>**-1.77**|nan<br>11.93<br>**-10.57**|nan<br>4.35<br>**-15.24**|



in such non-linear setups, the sub-optimal MB approaches operating with full information of the SS model are substantially outperformed by KalmanNet (with setting _C4_ ). 

_2) Partial Information:_ W proceed to evaluate KalmanNet and compare it to its MB counterparts under partial model information. We consider three possible sources of model mismatch arising in the Lorenz attractor setup: 

- State-evolution mismatch due to use of a Taylor series approximation of insufficient order. 

- State-observation mismatch as a result of misalignment due to rotation. 

- State-observation mismatch as a result of sampling from continuous-time to discrete-time. 

Since the EKF produced the best results in the full information case among all non-linear MB filtering algorithms, we use it as a baseline for the MSE lower bound. 

**State-evolution mismatch** : In this study, both KalmanNet and the MB algorithms operate with a crude approximation of the evolution dynamics obtained by computing (20) with _J_ = 2, while the data is generated with an order _J_ = 5 Taylor series expansion. We again set **h** to be the identity mapping, _T_ = 2000, and _ν_ = _−_ 20 [dB]. The results, depicted in Fig. 9a and reported in Table VII, demonstrate that KalmanNet (with setting _C4_ ) learns to partially overcome this model mismatch, outperforming its MB counterparts operating with the same level of partial information. 

**State-observation rotation mismatch** : Here, the presence of mismatch in the observations model is simulated by using data generated by an identity matrix rotated by merely _θ_ = 1 _[◦]_ . This rotation is equivalent to sensor misalignment of _≈_ 0 _._ 55%. The results depicted in Figure. 9b and reported in Table VIII clearly demonstrate that this seemingly minor rotation can 

11 

**==> picture [502 x 165] intentionally omitted <==**

**----- Start of picture text -----**<br>
0<br>25<br>-5<br>-10 20<br>-15 15<br>-20 10<br>-25<br>5<br>-30 -10 0 2220<br>-35 -12 18<br>-40 -14-16 -5 161412<br>-45 -18 -10 108<br>-20 6 -0.3 -0.2 -0.1 0 0.1 0.2 0.3<br>-50 9.5 9.6 9.7 9.8 9.9 10 10.1 10.2 10.3 10.4 10.5 -15<br>0 5 10 15 20 25 30 35 40 -10 -5 0 5 10 15 20 25 30<br>(a) T = 2000, ν =  − 20 [dB], h  ( · ) =  I . (b) T = 20, ν = 0 [dB], h  ( · ) non-linear.<br>MSE [dB] MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 8: Lorenz attractor, full information. 

TABLE VII: MSE [dB] - Lorenz attractor with state-evolution mismatch _J_ = 2. 

|atch _J_ = 2.|atch _J_ = 2.|||||
|---|---|---|---|---|---|
|1_/_r2 [dB]<br><br>||10<br>|20<br>|30<br>|40<br>|
|EKF<br>_J_ = 5|ˆ_µ_<br>ˆ_σ_|**-20.37**<br>_±_0_._25|**-30.40**<br>_±_0_._24|**-40.39**<br>_±_0_._24|**-49.89**<br>_±_0_._20|
|EKF<br>_J_ = 2|ˆ_µ_<br>ˆ_σ_|-19.47<br>_±_0_._25|-23.63<br>_±_0_._11|-33.51<br>_±_0_._18|-41.15<br>_±_0_._12|
|UKF<br>_J_ = 2|ˆ_µ_<br>ˆ_σ_|-11.95<br>_±_0_._87|-20.45<br>_±_0_._27|-30.05<br>_±_0_._09|-39.98<br>_±_0_._09|
|PF<br>_J_ = 2|ˆ_µ_<br>ˆ_σ_|-17.95<br>_±_0_._18|-23.47<br>_±_0_._09|-30.11<br>_±_0_._10|-33.81<br>_±_0_._13|
|KalmanNet<br>_J_ = 2|ˆ_µ_<br>ˆ_σ_|**-19.71**<br>_±_0_._29|**-27.07**<br>_±_0_._18|**-35.41**<br>_±_0_._20|**-41.74**<br>_±_0_._11|



TABLE VIII: MSE [dB] - Lorenz attractor with observation rotation. 

|on.|on.|||||
|---|---|---|---|---|---|
|1_/_r2 [dB]||0|10|20|30|
|EKF<br>_θ_ = 0_◦_|ˆ_µ_<br>ˆ_σ_|**-10.40**<br>_±_0_._35|**-20.41**<br>_±_0_._37|**-30.50**<br>_±_0_._34|**-40.45**<br>_±_0_._34|
|EKF<br>_θ_ = 1_◦_|ˆ_µ_<br>ˆ_σ_|**-9.80**<br>_±_0_._54|-16.50<br>_±_6_._51|-18.19<br>_±_0_._22|-18.57<br>_±_0_._21|
|UKF<br>_θ_ = 1_◦_|ˆ_µ_<br>ˆ_σ_|-2.08<br>_±_1_._73|-6.92<br>_±_0_._53|-7.89<br>_±_0_._59|-8.09<br>_±_0_._62|
|PF<br>_θ_ = 1_◦_|ˆ_µ_<br>ˆ_σ_|-8.48<br>_±_3|-0.18<br>_±_8_._21|15.24<br>_±_3_._50|19.87<br>_±_0_._80|
|KalmanNet<br>_θ_ = 1_◦_|ˆ_µ_<br>ˆ_σ_|-9.63<br>_±_0_._53|**-18.17**<br>_±_0_._42|**-27.32**<br>_±_0_._67|**-34.04**<br>_±_0_._77|



cause a severe performance degradation for the MB filters, while KalmanNet (with setting _C3_ ) is able to learn from data to overcome such mismatches and to notably outperform its MB counterparts, which are sensitive to model uncertainty. Here, we trained KalmanNet on short trajectories with _T_ = 100 time steps, tested it on longer trajectories with _T_ = 1000 time steps, and set _ν_ = _−_ 20 [dB]. This again demonstrates that the learning of KalmanNet is transferable. 

**State-observations sampling mismatch** : We conclude our experimental study of the Lorenz attractor setup with an evaluation of KalmanNet in the presence of sampling mismatch. Here, we generate data from the Lorenz attractor SS model with an approximate continuous-time evolution process using a dense sampling rate, set to ∆ _τ_ = 10 _[−]_[5] . We then sub-sample the noiseless observations from the evolution process by a ratio 

TABLE IX: Lorenz attractor with sampling mismatch. 

|Metric|EKF|UKF|PF|KalmanNet|MB-RNN|
|---|---|---|---|---|---|
|MSE [dB]<br>ˆ_σ_|-6.432<br>_±_0_._093|-5.683<br>_±_0_._166|-5.337<br>_±_0_._190|**-11.284**<br>_±_0_._301|17.355<br>_±_0_._527|
|Run-time [sec]|5.440|6.072|62.946|**4.699**|2.291|



of 20001[and][get][a][decimated][process][with][∆] _[τ]_[d][=][0] _[.]_[02][.][This] procedure results in an inherent mismatch in the SS model due to representing an (approximately) continuous-time process using a discrete-time sequence. In this experiment, no process noise was applied, and the observations are again obtained with **h** set to identity and _T_ = 3000. 

The resulting MSE values for r1[2][=][0 [][dB][]][of][KalmanNet] with configuration _C4_ compared with the MB filters and with the end-to-end neural network termed MB-RNN (see Subsection IV-B) are reported in Table IX. The results demonstrate that KalmanNet overcomes the mismatch induced by representing a continuous-time SS model in discrete-time, achieving a substantial processing gain over the MB alternatives due to its learning capabilities. The results also demonstrate that KalmanNet significantly outperforms a straightforward combination of domain knowledge; i.e. a state-transition function **f** ( _·_ ), with end-to-end RNNs. A fully model-agnostic RNN was shown to diverge when trained for this task. In Fig. 10 we visualize how this gain is translated into clearly improved tracking of a single trajectory. To show that these gains of KalmanNet do not come at the cost of computationally slow inference, we detail the average inference time for all filters (without parallelism). The stopwatch timings were measured on the same platform – _Google Colab_ with CPU: Intel(R) Xeon(R) CPU @ 2.20GHz, GPU: Tesla P100-PCIE-16GB. We see that KalmanNet infers faster than the classical methods, thanks to the highly efficient neural network computations and the fact that, unlike the MB filters, it does not involve linearization and matrix inversions for each time step. 

## _E. Real World Dynamics: Michigan NCLT Data Set_ 

In our final experiment we evaluate KalmanNet on the Michigan NCLT data set [28]. This data set comprises different labeled trajectories, with each one containing noisy sensor 

12 

**==> picture [502 x 165] intentionally omitted <==**

**----- Start of picture text -----**<br>
-10 0<br>-15 -5<br>-20 -10<br>-25 -15<br>-30 -20<br>-35 -20-22 -25 -18-20<br>-40 -24-26 -30 -22-24<br>-45 -28-30 -35 -26-28<br>-30<br>19.5 19.6 19.7 19.8 19.9 20 20.1 20.2 20.3 20.4 20.5 -40 19.5 19.6 19.7 19.8 19.9 20 20.1 20.2 20.3 20.4 20.5<br>-50<br>10 15 20 25 30 35 40 0 5 10 15 20 25 30<br>(a) State-evolution mismatch, identity h , T = 2000. (b) Observation mismatch - ∆ θ = 1 [◦] , T = 1000.<br>MSE [dB] MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 9: Lorenz attractor, partial information. 

readings (e.g., GPS and odometer) and the ground truth locations of a moving Segway robot. Given these noisy readings, the goal of the tracking algorithm is to localize the Segway from the raw measurements at any given time. 

TABLE X: Numerical MSE [dB] for the NCLT experiment. 

|Baseline|EKF|KalmanNet|Vanilla RNN|
|---|---|---|---|
|25.47|25.385|**22.2**|40.21|



for Kalman filtering is given by 

To tackle this problem we model the Segway kinematics (in each axis separately) using the linear _Wiener_ velocity model, where the acceleration is modeled as a white Gaussian noise process _wτ_ with variance q[2] [36]: 

**==> picture [248 x 25] intentionally omitted <==**

Here, _p_ and _v_ are the position and velocity, respectively. The discrete-time state-evolution with sampling interval ∆ _τ_ is approximated as a linear SS model in which the evolution matrix **F** and noise covariance **Q** are given by 

**==> picture [248 x 27] intentionally omitted <==**

Since KalmanNet does not rely on knowledge of the noise covariance matrices, **Q** is given here for the use of the MB KF and for completeness. 

The goal is to track the underlying state vector in both axes solely using odometry data; i.e., the observations are given by noisy velocity readings. In this case the observations obey a noisy linear model: 

**==> picture [171 x 11] intentionally omitted <==**

Such settings where one does not have access to direct measurements for positioning are very challenging yet practical and typical for many applications where positioning technologies are not available indoors, and one must rely on noisy odometer readings for self-localization. Odometry-based estimated positions typically start drifting away at some point. 

In the assumed model, the x-axis (in cartesian coordinates) are decoupled from the y-axis, and the linear SS model used 

**==> picture [243 x 52] intentionally omitted <==**

This model is equivalent to applying two independent KFs in parallel. Unlike the MB KF, KalmanNet does not rely on noise modeling, and can thus accommodate dependency in its learned KG. 

We arbitrarily use the session with date 2012-01-22 that consists of a single trajectory. Sampling at 1[Hz] results in 5 _,_ 850 time steps. We removed unstable readings and were left with 5,556 time steps. The trajectory was split into three sections: 85% for training (23 sequences of length _T_ = 200), 10% for validation (2 sequences, _T_ = 200), and 5% for testing (1 sequence, _T_ = 277). We compare KalmanNet with setting _C1_ to end-to-end vanilla RNN and the MB KF, where for the latter the matrices **Q** and **R** were optimized through a grid search. 

Fig. 11 and Table X demonstrate the superiority of KalmanNet for such scenarios. KF blindly follows the odometer trajectory and is incapable of accounting for the drift, producing a very similar or even worse estimation than the integrated velocity. The vanilla RNN, which is agnostic of the motion model, fails to localize. KalmanNet overcomes the errors induced by the noisy odometer observations, and provides the most accurate real-time locations, demonstrating the gains of combining MB KF-based inference with integrated DD modules for real world applications. 

## V. CONCLUSIONS 

In this work we presented KalmanNet, a hybrid combination of deep learning with the classic MB EKF. Our design identifies the SS-model-dependent computations of the MB EKF, replacing them with a dedicated RNN operating on specific 

13 

**==> picture [250 x 82] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth Decimated Observations<br>Noisy Observations KalmanNet<br>**----- End of picture text -----**<br>


**==> picture [250 x 82] intentionally omitted <==**

**----- Start of picture text -----**<br>
EKF PF<br>MB-RNN<br>UKF<br>**----- End of picture text -----**<br>


Fig. 10: Lorenz attractor with sampling mismatch (decimation), _T_ = 3000. 

**==> picture [253 x 89] intentionally omitted <==**

Fig. 11: NCLT data set: ground truth vs. integrated velocity, trajectory from session with date 2012-01-22 sampled at 1 Hz. 

features encapsulating the information needed for its operation. Our numerical study shows that doing so enables KalmanNet to carry out real-time state estimation in the same manner as MB Kalman filtering, while learning to overcome model mismatches and non-linearities. KalmanNet uses a relatively compact RNN that can be trained with a relatively small data set and infers a reduced complexity, making it applicable for high dimensional SS models and computationally limited devices. 

## ACKNOWLEDGEMENTS 

We would like to thank Prof. Hans-Andrea Loeliger for his helpful comments and discussions, and Jonas E. Mehr for his assistance with the numerical study. 

## REFERENCES 

- [1] G. Revach, N. Shlezinger, R. J. G. van Sloun, and Y. C. Eldar, “KalmanNet: Data-driven Kalman filtering,” in _Proc. IEEE ICASSP_ , 2021, pp. 3905–3909. 

- [2] J. Durbin and S. J. Koopman, _Time series analysis by state space methods_ . Oxford University Press, 2012. 

- [3] R. E. Kalman, “A new approach to linear filtering and prediction problems,” _Journal of Basic Engineering_ , vol. 82, no. 1, pp. 35–45, 1960. 

- [4] R. E. Kalman and R. S. Bucy, “New results in linear filtering and prediction theory,” 1961. 

- [5] R. E. Kalman, “New methods in Wiener filtering theory,” 1963. 

- [6] N. Wiener, _Extrapolation, interpolation, and smoothing of stationary time series: With engineering applications_ . MIT Press Cambridge, MA, 1949, vol. 8. 

- [7] M. Gruber, “An approach to target tracking,” MIT Lexington Lincoln Lab, Tech. Rep., 1967. 

- [8] R. E. Larson, R. M. Dressler, and R. S. Ratner, “Application of the Extended Kalman filter to ballistic trajectory estimation,” Stanford Research Institute, Tech. Rep., 1967. 

- [9] J. D. McLean, S. F. Schmidt, and L. A. McGee, _Optimal filtering and linear prediction applied to a midcourse navigation system for the circumlunar mission_ . National Aeronautics and Space Administration, 1962. 

- [10] S. J. Julier and J. K. Uhlmann, “New extension of the Kalman filter to nonlinear systems,” in _Signal Processing, Sensor Fusion, and Target Recognition VI_ , vol. 3068. International Society for Optics and Photonics, 1997, pp. 182–193. 

- [11] N. J. Gordon, D. J. Salmond, and A. F. Smith, “Novel approach to nonlinear/non-Gaussian Bayesian state estimation,” in _IEE proceedings F (radar and signal processing)_ , vol. 140, no. 2. IET, 1993, pp. 107– 113. 

- [12] P. Del Moral, “Nonlinear filtering: Interacting particle resolution,” _Comptes Rendus de l’Acad´emie des Sciences-Series I-Mathematics_ , vol. 325, no. 6, pp. 653–658, 1997. 

- [13] J. S. Liu and R. Chen, “Sequential Monte Carlo methods for dynamic systems,” _Journal of the American Statistical Association_ , vol. 93, no. 443, pp. 1032–1044, 1998. 

- [14] F. Auger, M. Hilairet, J. M. Guerrero, E. Monmasson, T. OrlowskaKowalska, and S. Katsura, “Industrial applications of the Kalman filter: A review,” _IEEE Trans. Ind. Electron._ , vol. 60, no. 12, pp. 5458–5471, 2013. 

- [15] M. Zorzi, “Robust Kalman filtering under model perturbations,” _IEEE Trans. Autom. Control_ , vol. 62, no. 6, pp. 2902–2907, 2016. 

- [16] ——, “On the robustness of the Bayes and Wiener estimators under model uncertainty,” _Automatica_ , vol. 83, pp. 133–140, 2017. 

- [17] A. Longhini, M. Perbellini, S. Gottardi, S. Yi, H. Liu, and M. Zorzi, “Learning the tuned liquid damper dynamics by means of a robust EKF,” _arXiv preprint arXiv:2103.03520_ , 2021. 

- [18] Y. LeCun, Y. Bengio, and G. Hinton, “Deep learning,” _Nature_ , vol. 521, no. 7553, p. 436, 2015. 

- [19] Y. Bengio, “Learning deep architectures for AI,” _Foundations and Trends® in Machine Learning_ , vol. 2, no. 1, pp. 1–127, 2009. 

- [20] S. Hochreiter and J. Schmidhuber, “Long short-term memory,” _Neural Computation_ , vol. 9, no. 8, pp. 1735–1780, 1997. 

- [21] J. Chung, C. Gulcehre, K. Cho, and Y. Bengio, “Empirical evaluation of gated recurrent neural networks on sequence modeling,” _arXiv preprint arXiv:1412.3555_ , 2014. 

- [22] A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. Kaiser, and I. Polosukhin, “Attention is all you need,” _arXiv preprint arXiv:1706.03762_ , 2017. 

- [23] M. Zaheer, A. Ahmed, and A. J. Smola, “Latent LSTM allocation: Joint clustering and non-linear dynamic modeling of sequence data,” in _International Conference on Machine Learning_ , 2017, pp. 3967–3976. 

- [24] N. Shlezinger, N. Farsad, Y. C. Eldar, and A. J. Goldsmith, “ViterbiNet: A deep learning based Viterbi algorithm for symbol detection,” _IEEE Trans. Wireless Commun._ , vol. 19, no. 5, pp. 3319–3331, 2020. 

- [25] N. Shlezinger, R. Fu, and Y. C. Eldar, “DeepSIC: Deep soft interference cancellation for multiuser MIMO detection,” _IEEE Trans. Wireless Commun._ , vol. 20, no. 2, pp. 1349–1362, 2021. 

- [26] N. Shlezinger, N. Farsad, Y. C. Eldar, and A. J. Goldsmith, “Learned factor graphs for inference from stationary time sequences,” _IEEE Trans. Signal Process._ , early access, 2022. 

- [27] N. Shlezinger, J. Whang, Y. C. Eldar, and A. G. Dimakis, “Model-based deep learning,” _arXiv preprint arXiv:2012.08405_ , 2020. 

- [28] N. Carlevaris-Bianco, A. K. Ushani, and R. M. Eustice, “University of Michigan North Campus long-term vision and LiDAR dataset,” _The International Journal of Robotics Research_ , vol. 35, no. 9, pp. 1023– 1035, 2016. 

- [29] R. G. Krishnan, U. Shalit, and D. Sontag, “Deep Kalman filters,” _arXiv preprint arXiv:1511.05121_ , 2015. 

- [30] M. Karl, M. Soelch, J. Bayer, and P. Van der Smagt, “Deep variational Bayes filters: Unsupervised learning of state space models from raw data,” _arXiv preprint arXiv:1605.06432_ , 2016. 

- [31] M. Fraccaro, S. D. Kamronn, U. Paquet, and O. Winther, “A disentangled recognition and nonlinear dynamics model for unsupervised learning,” in _Advances in Neural Information Processing Systems_ , 2017. 

- [32] C. Naesseth, S. Linderman, R. Ranganath, and D. Blei, “Variational sequential Monte Carlo,” in _International Conference on Artificial Intelligence and Statistics_ . PMLR, 2018, pp. 968–977. 

14 

- [33] E. Archer, I. M. Park, L. Buesing, J. Cunningham, and L. Paninski, “Black box variational inference for state space models,” _arXiv preprint arXiv:1511.07367_ , 2015. 

- [34] R. Krishnan, U. Shalit, and D. Sontag, “Structured inference networks for nonlinear state space models,” in _Proceedings of the AAAI Conference on Artificial Intelligence_ , vol. 31, no. 1, 2017. 

- [35] V. G. Satorras, Z. Akata, and M. Welling, “Combining generative and discriminative models for hybrid inference,” in _Advances in Neural Information Processing Systems_ , 2019, pp. 13 802–13 812. 

- [36] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with applications to tracking and navigation: Theory algorithms and software_ . John Wiley & Sons, 2004. 

- [37] K.-V. Yuen and S.-C. Kuok, “Online updating and uncertainty quantification using nonstationary output-only measurement,” _Mechanical Systems and Signal Processing_ , vol. 66, pp. 62–77, 2016. 

- [38] H.-Q. Mu, S.-C. Kuok, and K.-V. Yuen, “Stable robust Extended Kalman filter,” _Journal of Aerospace Engineering_ , vol. 30, no. 2, p. B4016010, 2017. 

- [39] I. Arasaratnam, S. Haykin, and R. J. Elliott, “Discrete-time nonlinear filtering algorithms using Gauss–Hermite quadrature,” _Proc. IEEE_ , vol. 95, no. 5, pp. 953–977, 2007. 

- [40] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Trans. Autom. Control_ , vol. 54, no. 6, pp. 1254–1269, 2009. 

- [41] M. S. Arulampalam, S. Maskell, N. Gordon, and T. Clapp, “A tutorial on particle filters for online nonlinear/non-Gaussian Bayesian tracking,” _IEEE Trans. Signal Process._ , vol. 50, no. 2, pp. 174–188, 2002. 

- [42] N. Chopin, P. E. Jacob, and O. Papaspiliopoulos, “SMC2: An efficient algorithm for sequential analysis of state space models,” _Journal of the Royal Statistical Society: Series B (Statistical Methodology)_ , vol. 75, no. 3, pp. 397–426, 2013. 

- [43] L. Martino, V. Elvira, and G. Camps-Valls, “Distributed particle metropolis-Hastings schemes,” in _IEEE Statistical Signal Processing Workshop (SSP)_ , 2018, pp. 553–557. 

- [44] C. Andrieu, A. Doucet, and R. Holenstein, “Particle Markov chain Monte Carlo methods,” _Journal of the Royal Statistical Society: Series B (Statistical Methodology)_ , vol. 72, no. 3, pp. 269–342, 2010. 

- [45] J. Elfring, E. Torta, and R. van de Molengraft, “Particle filters: A handson tutorial,” _Sensors_ , vol. 21, no. 2, p. 438, 2021. 

- [46] R. H. Shumway and D. S. Stoffer, “An approach to time series smoothing and forecasting using the EM algorithm,” _Journal of Time Series Analysis_ , vol. 3, no. 4, pp. 253–264, 1982. 

- [47] Z. Ghahramani and G. E. Hinton, “Parameter estimation for linear dynamical systems,” 1996. 

- [48] J. Dauwels, A. Eckford, S. Korl, and H.-A. Loeliger, “Expectation maximization as message passing-part I: Principles and Gaussian messages,” _arXiv preprint arXiv:0910.2832_ , 2009. 

- [49] L. Martino, J. Read, V. Elvira, and F. Louzada, “Cooperative parallel particle filters for online model selection and applications to urban mobility,” _Digital Signal Processing_ , vol. 60, pp. 172–185, 2017. 

- [50] P. Abbeel, A. Coates, M. Montemerlo, A. Y. Ng, and S. Thrun, “Discriminative training of Kalman filters.” in _Robotics: Science and Systems_ , vol. 2, 2005, p. 1. 

- [51] L. Xu and R. Niu, “EKFNet: Learning system noise statistics from measurement data,” in _Proc. IEEE ICASSP_ , 2021, pp. 4560–4564. 

   - [59] D. M. Blei, A. Kucukelbir, and J. D. McAuliffe, “Variational inference: A review for statisticians,” _Journal of the American Statistical Association_ , vol. 112, no. 518, pp. 859–877, 2017. 

   - [60] T. Haarnoja, A. Ajay, S. Levine, and P. Abbeel, “Backprop kf: Learning discriminative deterministic state estimators,” in _Advances in Neural Information Processing Systems_ , 2016, pp. 4376–4384. 

   - [61] B. Laufer-Goldshtein, R. Talmon, and S. Gannot, “A hybrid approach for speaker tracking based on TDOA and data-driven models,” _IEEE/ACM Trans. Audio, Speech, Language Process._ , vol. 26, no. 4, pp. 725–735, 2018. 

   - [62] H. Coskun, F. Achilles, R. DiPietro, N. Navab, and F. Tombari, “Long short-term memory Kalman filters: Recurrent neural estimators for pose regularization,” in _Proceedings of the IEEE International Conference on Computer Vision_ , 2017, pp. 5524–5532. 

   - [63] S. S. Rangapuram, M. W. Seeger, J. Gasthaus, L. Stella, Y. Wang, and T. Januschowski, “Deep state space models for time series forecasting,” in _Advances in Neural Information Processing Systems_ , 2018, pp. 7785– 7794. 

   - [64] P. Becker, H. Pandya, G. Gebhardt, C. Zhao, C. J. Taylor, and G. Neumann, “Recurrent Kalman networks: Factorized inference in high-dimensional deep feature spaces,” in _International Conference on Machine Learning_ . PMLR, 2019, pp. 544–552. 

   - [65] X. Zheng, M. Zaheer, A. Ahmed, Y. Wang, E. P. Xing, and A. J. Smola, “State space LSTM models with particle MCMC inference,” _arXiv preprint arXiv:1711.11179_ , 2017. 

   - [66] T. Salimans, D. Kingma, and M. Welling, “Markov chain Monte Carlo and variational inference: Bridging the gap,” in _International Conference on Machine Learning_ . PMLR, 2015, pp. 1218–1226. 

   - [67] X. Ni, G. Revach, N. Shlezinger, R. J. van Sloun, and Y. C. Eldar, “RTSNET: Deep learning aided Kalman smoothing,” in _Proc. IEEE ICASSP_ , 2022. 

   - [68] R. Dey and F. M. Salem, “Gate-variants of gated recurrent unit (GRU) neural networks,” in _Proc. IEEE MWSCAS_ , 2017, pp. 1597–1600. 

   - [69] P. J. Werbos, “Backpropagation through time: What it does and how to do it,” _Proc. IEEE_ , vol. 78, no. 10, pp. 1550–1560, 1990. 

   - [70] I. Sutskever, _Training recurrent neural networks_ . University of Toronto Toronto, Canada, 2013. 

   - [71] I. Klein, G. Revach, N. Shlezinger, J. E. Mehr, R. J. van Sloun, and Y. Eldar, “Uncertainty in data-driven Kalman filtering for partially known state-space models,” in _Proc. IEEE ICASSP_ , 2022. 

   - [72] A. L´opez Escoriza, G. Revach, N. Shlezinger, and R. J. G. van Sloun, “Data-driven Kalman-based velocity estimation for autonomous racing,” in _Proc. IEEE ICAS_ , 2021. 

   - [73] H. E. Rauch, F. Tung, and C. T. Striebel, “Maximum likelihood estimates of linear dynamic systems,” _AIAA Journal_ , vol. 3, no. 8, pp. 1445–1450, 1965. 

   - [74] D. P. Kingma and J. Ba, “Adam: A method for stochastic optimization,” _arXiv preprint arXiv:1412.6980_ , 2014. 

   - [75] Labbe, Roger, _FilterPy - Kalman and Bayesian Filters in Python_ , 2020. [Online]. Available: https://filterpy.readthedocs.io/en/latest/ 

   - [76] Jerker Nordh, _pyParticleEst - Particle based methods in Python_ , 2015. [Online]. Available: https://pyparticleest.readthedocs.io/en/latest/index. html 

   - [77] W. Gilpin, “Chaos as an interpretable benchmark for forecasting and data-driven modelling,” _arXiv preprint arXiv:2110.05266_ , 2021. 

- [52] S. T. Barratt and S. P. Boyd, “Fitting a Kalman smoother to data,” in _IEEE American Control Conference (ACC)_ , 2020, pp. 1526–1531. 

- [53] L. Xie, Y. C. Soh, and C. E. De Souza, “Robust Kalman filtering for uncertain discrete-time systems,” _IEEE Trans. Autom. Control_ , vol. 39, no. 6, pp. 1310–1314, 1994. 

- [54] C. M. Carvalho, M. S. Johannes, H. F. Lopes, and N. G. Polson, “Particle learning and smoothing,” _Statistical Science_ , vol. 25, no. 1, pp. 88–106, 2010. 

- [55] I. Urteaga, M. F. Bugallo, and P. M. Djuri´c, “Sequential Monte Carlo methods under model uncertainty,” in _IEEE Statistical Signal Processing Workshop (SSP)_ , 2016, pp. 1–5. 

- [56] L. Zhou, Z. Luo, T. Shen, J. Zhang, M. Zhen, Y. Yao, T. Fang, and L. Quan, “KFNet: Learning temporal camera relocalization using Kalman filtering,” in _Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition_ , 2020, pp. 4919–4928. 

- [57] D. P. Kingma and M. Welling, “Auto-encoding variational Bayes,” _arXiv preprint arXiv:1312.6114_ , 2013. 

- [58] D. J. Rezende, S. Mohamed, and D. Wierstra, “Stochastic backpropagation and approximate inference in deep generative models,” in _International conference on machine learning_ . PMLR, 2014, pp. 1278– 1286. 

15 

