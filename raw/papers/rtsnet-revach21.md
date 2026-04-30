---
source_url: https://arxiv.org/abs/2110.04717
ingested: 2026-04-30
sha256: 17199c7aa9834b4892844961bfdf6041d34dda3ab2993b1b35aadcb6283d7f58
source: paper
conversion: pymupdf4llm

---

## RTSNet: Learning to Smooth in Partially Known State-Space Models (Preprint) 

Guy Revach _Graduate Student Member, IEEE_ , Xiaoyong Ni _Student Member, IEEE_ , Nir Shlezinger _Senior Member, IEEE_ , Ruud J. G. van Sloun _Member, IEEE_ , and Yonina C. Eldar _Fellow, IEEE_ 

_**Abstract**_ **—The smoothing task is core to many signalprocessing applications. A widely popular smoother is the RauchTung-Striebel (RTS) algorithm, which achieves minimal meansquared error recovery with low complexity for linear Gaussian state-space (SS) models, yet is limited in systems that are only partially known, as well as nonlinear and non-Gaussian. In this work, we propose RTSNet, a highly efficient model-based and data-driven smoothing algorithm suitable for partially known SS models. RTSNet integrates dedicated trainable models into the flow of the classical RTS smoother, while iteratively refining its sequence estimate via deep unfolding methodology. As a result, RTSNet learns from data to reliably smooth when operating under model mismatch and nonlinearities while retaining the efficiency and interpretability of the traditional RTS smoothing algorithm. Our empirical study demonstrates that RTSNet overcomes nonlinearities and model mismatch, outperforming classic smoothers operating with both mismatched and accurate domain knowledge. Moreover, while RTSNet is based on compact neural networks, which leads to faster training and inference times, it demonstrates improved performance over previously proposed deep smoothers in nonlinear settings.** 

## I. INTRODUCTION 

A broad range of applications in signal processing and control require estimation of the hidden state of a dynamical system from noisy observations. Such tasks arise in localization, tracking, and navigation [2]. State estimation by filtering and smoothing date back to the work of Wiener from 1949 [3]. Filtering (also known as real-time tracking) is the task of estimating the current state from past and current observations, while smoothing deals with simultaneous state estimation across the entire time horizon using all available data. 

Arguably, the most common and celebrated filtering algorithm is the Kalman filter (KF) proposed in the early 1960s [4]. The KF is a low-complexity implementation of the minimum mean-squared error (MMSE) estimator for timevarying systems in discrete-time that are characterized by a linear state-space (SS) model with additive white Gaussian noise (AWGN). The Rauch-Tung-Striebel (RTS) smoother [5], also referred to here as the Kalman smoother (KS), adapts the KF for smoothing in discrete-time. The KS implements 

This manuscript is a preprint. It is partially based on work presented at the IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP) 2022 [1], and has been accepted for publication in IEEE Transactions on Signal Processing, Vol. 71, 2023. 

G. Revach and X. Ni are with the Institute for Signal and Information Processing (ISI), D-ITET, ETH Z¨urich, 8006 Z¨urich, Switzerland, (e-mail: grevach@ethz.ch). N. Shlezinger is with the School of ECE, Ben-Gurion University of the Negev, Beer Sheva, Israel. R. J. G. van Sloun is with the EE Dpt., Eindhoven University of Technology, and with Philips Research, Eindhoven, The Netherlands. Y. C. Eldar is with the Faculty of Math and CS, Weizmann Institute of Science, Rehovot, Israel. We thank Hans-Andrea Loeliger for the helpful discussions. 

MMSE estimation for linear Gaussian SS models by applying a recursive forward pass, i.e., from the past to the future by directly applying the KF, followed by a recursive update backward pass. 

The KS is given by recursive equations. These may be derived from the more general framework of message passing over factor graphs [6], [7]. Alternatively, the KS can be extended from an optimization perspective, by recasting it as a least-squares (LS) system with a specific structure dictated by the SS model, and is solved using Newton’s method [8], [9]. The latter perspective has further generalized extended KS (EKS) to nonlinear models. Drawing from this optimisation perspective, multiple extensions have been derived to address non-Gaussian densities (especially outliers) [9]–[11], statedependent covariance matrices [12], as well as state constraints and sparsity [9], [13]. 

The KS and its variants are model-based (MB) algorithms; that is, they assume that the underlying system’s dynamics is accurately characterized by a known SS model. However, many real-world systems in practical use cases are complex, and it may be challenging to comprehensively and faithfully represent these systems with a fully known, tractable SS model. Consequently, despite its low complexity and theoretical soundness, applying the KS in practical scenarios may be limited due to its critical dependence on accurate knowledge of the underlying SS model. Furthermore, the nonlinear variants of the KS do not share its MMSE optimality, and their performance degrades under strong nonlinearities. 

A common approach to deal with partially known SS models is to impose a parametric model and then estimate its parameters. This can be achieved by jointly learning the parameters and state sequence using expectation maximization [14], [15] and Bayesian probabilistic algorithms [16], [17], or by selecting from a set of _a priori_ known models [18]. When training data is available, it is commonly used to tune the missing parameters in advance [19], [20]. These strategies are restricted to an imposed parametric model on the underlying dynamics (e.g., linear models with Gaussian noises), and thus may still lead to mismatched operation. Alternatively, uncertainty can be managed through the use of Bayesian probabilistic algorithms as in [16], [17], by selecting from a set of a priori known models as in [18], or by implementing robust estimation methods as in [21], [22]. These techniques are typically designed for the worst-case deviation between the postulated model and the ground truth, rarely approaching the performance achievable with full domain knowledge. 

Data-driven (DD) approaches are an alternative to MB algorithms, relaxing the requirement for explicit and accurate knowledge of the underlying model. Many of these strategies 

1 

are now based on deep neural networks (DNNs), which have shown remarkable success in capturing the subtleties of complex processes [23]. When there is no characterization of the dynamics, one can train deep learning systems designed for processing time sequences, e.g., recurrent neural networks (RNNs) [24] and attention mechanisms [25], for state estimation in intractable environments [26]. Yet, they do not incorporate domain knowledge such as structured SS models in a principled manner, while requiring many trainable parameters and large data sets even for simple sequence models [27] and lack the interpretability of MB methods. It is also possible to combine DNNs with variational inference in the context of state space models, as in [28]–[32]. This is done by casting the Bayesian inference task as the optimization of a parameterized posterior and maximizing an objective. However, the learning procedure tends to be complex and prone to approximation errors since these methods often rely on highly parameterized models. Furthermore, their applicability to use cases with a bounded delay on hardware-limited devices is limited. 

An alternative DD approach for state estimation in SS models uses DNNs to encode the observations into some latent space that is assumed to obey a simple SS model, typically a linear Gaussian one. State estimation is then carried out based on the extracted features [33]–[37], and can be followed by another DNN decoder [32]. This form of DNNaided state estimation is intended to cope with complex and intractable observations models, e.g., when processing visual observations, while one should still know (or estimate) the state evolution. When the SS model is known, DNNs can be applied to improve upon MB inference, as done in [38], where graph neural networks are used in parallel with MB smoothing. However, while the approach suggested in [38] uses DD DNNs, it also requires full knowledge of the SS model to apply MB smoothing in parallel, as in traditional smoothers. 

In scenarios involving partially known dynamics, where one has access to an approximation of some parts of the SS model (based on, e.g., understanding of the underlying physics or established motion models), both MB smoothing and DD methods based on DNNs may be limited in their performance and suitability. In our previous work [39] we derived a hybrid MB/DD implementation of the KF following the emerging MB deep learning methodology [40]–[42]. The augmentation of the KF with a dedicated DNN was shown to result in a filter that approaches MMSE performance in partially known dynamics, while being operable at high rates on limited hardware [43] and facilitating coping with high-dimensional observations [44]. Further, the interpretable nature of the resulting architectures was leveraged to provide reliable measures of uncertainty [45] and support unsupervised training [46]. These findings, which all considered a filtering task, motivate deriving a hybrid MB/DD smoothing algorithm. 

In this work, we introduce RTSNet, an iterative hybrid MB/DD algorithm for smoothing in dynamical systems describable by partially known SS models. RTSNet preserves the KS flow, while converting it into a trainable machine learning architecture by replacing both the forward and backward Kalman gains (KGs) with compact RNNs. Additionally, 

RTSNet integrates an iterative refinement mechanism, enabling multiple iterations via deep unfolding [47]. Consequently, RTSNet is able to convert a fixed number of KS iterations into a discriminative model [48] that is trained end-to-end. 

Although RTSNet learns the smoothing task from data, it preserves to flow of the KS, thus retaining its recursive nature, low complexity, interpretability, and invariance to the length of the sequence. In particular, RTSNet is shown to achieve the MMSE for linear models just as the KS does with full information, while only having access to partial information, and notably outperforms the KS when there is model mismatch. For nonlinear SS models, RTSNet is shown to outperform MB variants of the KS, that are no longer optimal even with full domain knowledge. We also show that RTSNet outperforms leading DD smoothers while using fewer trainable parameters, and being more efficient in terms of training and inference times. 

The improved performance follows from the ability of RTSNet to follow the principled KS operation, while circumventing its dependency on knowledge of the underlying noise statistics. In particular, by training the RTSNet smoother to directly compute the posterior distribution using learned KGs, we overcome the need to approximate the propagation of the noise statistics through the nonlinearity, and leverage data to cope with modeling mismatches. Moreover, doing so also bypasses the need for numerically costly matrix inversions and linearizations required in the KS equations. 

The rest of this paper is organized as follows: Section II reviews the SS model and its associated tasks, and discusses relevant preliminaries. Section III details the discriminative architecture of RTSNet. Section IV presents the empirical study. Section V provides concluding remarks. 

Throughout the paper, we use boldface lower-case letters for vectors and boldface upper-case letters for matrices. The transpose, _ℓ_ 2 norm, and stochastic expectation are denoted by _{·}[⊤]_ , _∥·∥_ , and E [ _·_ ], respectively. The Gaussian distribution with mean _µ_ and covariance **Σ** is denoted by _N_ ( _µ,_ **Σ** ). Finally, R and Z are the sets of real and integer numbers, respectively. 

## II. SYSTEM MODEL AND PRELIMINARIES 

## _A. Problem Formulation_ 

**SS Models:** Dynamical systems in discrete-time describe the relationship between a sequence of observations **y** _t_ and a sequence of unknown latent state variables **x** _t_ , where _t ∈_ Z is the time index. SS models are a common characterization of dynamic systems [49], which in the (possibly) nonlinear and Gaussian case, take the form 

**==> picture [238 x 26] intentionally omitted <==**

In (1a), the state vector **x** _t_ evolves from the previous state **x** _t−_ 1, by a (possibly) nonlinear, state-evolution function **f** ( _·_ ) and by an AWGN **e** _t_ with covariance matrix **Q** . The observations **y** _t_ in (1b) are related to the current latent state vector by a (possibly) nonlinear observation mapping **h** ( _·_ ) corrupted by AWGN **v** _t_ with covariance **R** . A common special case of 

2 

(1) is that of linear Gaussian SS models, where there exist matrices **F** _,_ **H** such that 

**==> picture [208 x 11] intentionally omitted <==**

**Smoothing Task:** SS models as in (1) are studied in the context of several different tasks, which can be roughly classified into two main categories: observation recovery and hidden state estimation. The first category deals with recovering parts of the observed signal **y** _t_ . This corresponds, for example, to prediction and imputation. The second category lies at the core of the family of tracking problems, considering the estimation of **x** _t_ . These include online (real-time) recovery, typically referred to as _filtering_ , which is the task considered in [39], and _offline_ estimation, i.e., _smoothing_ , which is the main focus of this paper. More specifically, smoothing involves the joint computation the state estimates **x** ˆ _t|T_ in a given time horizon _T_ , i.e., jointly estimating _{_ **x** _t}_ for each _t ∈{_ 1 _,_ 2 _, . . . , T }_ ≜ _T_ , given the corresponding block of noisy observations _{_ **y** 1 _,_ **y** 2 _, . . . ,_ **y** _T }_ . 

**Data-Aided Smoothing for Partially Known SS Models:** In practice, the SS model parameters may be partially known, and one is likely to only have access to an approximated characterization of the underlying dynamics. We thus focus on such scenarios where the state-evolution function **f** ( _·_ ) and the state-observation function **h** ( _·_ ) can be reasonably approximated (possibly with mismatch) from our understating of the system dynamics and its physical design, or learned from data (as discussed in Subsection III-D). Regardless of how these functions are obtained, they can be used for smoothing. As opposed to the classical assumptions of the KS algorithms, the statistics of noises **e** _t_ and **v** _t_ are completely unknown, and may be non-Gaussian. 

To deal with the partial modeling of the dynamics, we assume access to a labeled data set containing a sequence of observations and their corresponding states. Such data can be acquired, e.g., from field experiments, or using computationally intensive physically-compliant simulations [41]. The data set is comprised of _N_ time sequence pairs, i.e., _N D_ = �( **Y**[(] _[i]_[)] _,_ **X**[(] _[i]_[)] )� _i_ =1[,][each][of][length] _[T][i]_[,][namely,] 

**==> picture [194 x 19] intentionally omitted <==**

are the noisy observations, and the corresponding states are 

**==> picture [211 x 19] intentionally omitted <==**

Given _D_ and the (approximated) **f** ( _·_ ) _,_ **h** ( _·_ ), our objective is to design a smoothing function which maps the observations _{_ **y** _t}t∈T_ into a state estimate _{_ **x** ˆ _t}t∈T_ , where the accuracy of the smoother is evaluated as the mean-squared error (MSE) with respect to the true state _{_ **x** _t}t∈T_ . 

## _B. Model-Based Kalman Smoothing_ 

We next recall the MB RTS smoother [5], which is the basis for our proposed RTSNet, detailed in Section III. We describe the original algorithm for linear SS models, as in (2), and then discuss how to extend it for nonlinear SS models. 

The RTS smoother recovers the latent state variables using two linear recursive steps, referred to as the _forward_ and _backward_ passes. The forward pass is a standard KF, while the backward pass recursively computes corrections to the forward estimate, based on future observations. 

**Forward Pass:** The KF produces a new estimate **x** ˆ _t|t_ using its previous estimate ˆ **x** _t−_ 1 _|t−_ 1 and the observation **y** _t_ . For each _t ∈T_ , the KF operates in two steps: _prediction_ and _update_ . 

The first step predicts the current _a priori_ statistical moments based on the previous _a posteriori_ moments. The moments of **x** _t_ are computed using the knowledge of the evolution matrix **F** as 

**==> picture [197 x 27] intentionally omitted <==**

and the moments of the observations **y** _t_ are computed based on the knowledge of the observation matrix **H** as 

**==> picture [193 x 27] intentionally omitted <==**

In the update step, the _a posteriori_ state moments are computed based on the _a priori_ moments as 

**==> picture [199 x 27] intentionally omitted <==**

Here, _**K** t_ is the KG, and it is given by 

**==> picture [184 x 15] intentionally omitted <==**

ˆ while ∆ **y** _t_ = **y** _t −_ **y** _t|t−_ 1 is the innovation, and is the only term that depends on the observed data. 

**Backward pass:** The backward pass is similar in its structure to the update step in the KF. For each _t ∈{T −_ 1 _, . . . ,_ 1 _}_ , the forward belief is corrected with future estimates via 

**==> picture [199 x 32] intentionally omitted <==**

Here, _**G** t_ is the backward KG, computed based on secondorder statistical moments from the forward pass as 

**==> picture [177 x 15] intentionally omitted <==**

ˆ ˆ The difference terms are given by _[←−]_ ∆ **x** _t_ +1 = **x** _t_ +1 _|T −_ **x** _t_ +1 _|t_ and ∆ **Σ** _t_ +1 = **Σ** _t_ +1 _−_ **Σ** _t_ +1 _|t_ . The KS is MMSE optimal for linear Gaussian SS models. 

**Extension to Nonlinear Dynamics:** For nonlinear SS models as in (1), the first-order statistical moments (5a) and (6a) are replaced with 

**==> picture [171 x 27] intentionally omitted <==**

respectively. Unfortunately, the second-order moments cannot be propagated directly through the nonlinearity and thus must be approximated, resulting in methods that no longer share the MSE optimality achieved in linear models. 

Among the methods proposed to approximate the secondorder moments are the unscented RTS, which is based on 

3 

unscented transformations [50], and particle smoothers (PSs) which use sequential sampling [51]. Arguably the most common nonlinear smoother is the EKS, which uses straightforward linearization. Specifically, when **f** ( _·_ ) and **h** ( _·_ ) are differentiable, the EKS linearizes them in a time-dependent manner. This is done using their partial derivative matrices (Jacobians), evaluated at **x** ˆ _t−_ 1 _|t−_ 1 and **x** ˆ _t|t−_ 1 , namely, 

**==> picture [172 x 30] intentionally omitted <==**

The Jabobians in (12) are then substituted into equations (5b), (10), (6b), and (8) of the KS. 

The forward and backward KGs are pivot terms, that are used as tuning factors for updating our current belief, and they depend on the second-order moments. For linear SS models, the covariance computation is purely MB, i.e., based solely on the noise statistics, while for nonlinear systems the covariance depends on the specific trajectory. Furthermore, these covariance computations require full knowledge of the underlying model, and performance notably degrades in the presence of a model mismatch. This motivates the derivation of a data-aided smoothing algorithm that estimates the KGs directly as a form of discriminative learning [48], and by that circumvents the need to estimate the second-order moments. 

## III. RTSNET 

Here, we present RTSNet. We begin by describing our design rationale and high-level architecture in Subsection III-A, after which we detail the microarchitecture in Subsection III-B. We then describe the training procedure in Subsection III-C, and provide a discussion in Subsection III-D. 

## _A. High Level Design_ 

**Rationale:** The basic design idea behind the proposed RTSNet is to utilize the skeleton of the MB RTS smoother, hence the name RTSNet, and to replace modules depending on unavailable domain knowledge, with trainable DNNs. By doing so, we convert the KS into a discriminative algorithm, that can be trained in a supervised end-to-end manner. 

Our design is based on two main guiding properties: 

- _P1_ The RTS operation, comprised of a single forwardbackward pass, is not necessarily MMSE optimal when the SS model is not linear Gaussian. 

- _P2_ The RTS smoother requires the missing domain knowledge (i.e., the noise statistics) and linearization operations solely for computing the KGs in (8) and (10). 

**Unfolded Architecture (by** _**P1**_ **):** Property _P1_ indicates that one can possibly improve performance by carrying out multiple forward-backward passes, iteratively refining the estimated sequence. Following the deep unfolding methodology [41], we design RTSNet to carry out _K_ forward-backward passes, for some fixed _K ≥_ 1. 

Each pass of index _k ∈{_ 1 _, . . . , K}_ involves a single forward-backward smoothing. The input and output of this pass are the sequences **Y** _k_ = [ **y** _k,_ 1 _,_ **y** _k,_ 2 _, . . . ,_ **y** _k,T_ ] and 

ˆ ˆ **X** _k_ = � **x** _k,_ 1 _|T ,_ ˆ **x** _k,_ 2 _|T , . . ._ ˆ **x** _k,T |T_ �, respectively, and its operation is based on an SS model of the form 

**==> picture [226 x 26] intentionally omitted <==**

For the first pass, the inputs are **y** 1 _,t_ = **y** _t_ , i.e., the observations, and thus **h** 1( _·_ ) _≡_ **h** ( _·_ ) and _n_ 1 = _n_ in (13b). For the following passes where _k >_ 1, the input is the estimate ˆ produced by the subsequent pass, i.e., **y** _k,t_ = **x** _k−_ 1 _,t|T_ . This input is treated as noisy state observations, and thus **h** _k_ ( _·_ ) is the identity mapping and _nk_ = _m_ . The noise signals in (13) obey an unknown distribution, following the problem formulation in Subsection II-A. 

**Deep Augmenting RTS (by** _**P2**_ **):** We choose the RTS smoother as our MB backbone based on _P2_ . Specifically, as opposed to other alternatives, e.g., MBF [52], [53] and BIFM [7], in RTS all the unknown domain knowledge is encapsulated in the forward and backward KGs, _**K** t_ , and _**G** t_ , respectively. Consequently, for each pass _k_ , we employ an RTS smoother, while replacing the KGs computation with DNNs. 

Since both KGs involve tracking time-evolving secondorder moments, they are replaced by RNNs in each pass of RTSNet, with input features encapsulating the missing statistics. The resulting operation of the _k_ th pass commences with a forward pass, that is based upon KalmanNet [39]: For each _t_ from 1 to _T_ a _prediction_ and _update_ steps are applied. In the _prediction_ step, we use the prior estimates for the current state and for the current observation, as in (11), namely, 

**==> picture [253 x 42] intentionally omitted <==**

**==> picture [218 x 13] intentionally omitted <==**

As opposed to the KS, here the filtering (forward) KG _**K** k,t_ is computed using an RNN. 

The forward pass if followed by a backward pass, which updates our state estimates using information from future estimates. As in (9a), this procedure is given by 

**==> picture [232 x 13] intentionally omitted <==**

ˆ ˆ where the resulting estimate is **x** _k,t_ = **x** _k,t|T_ for each _t_ . As in the forward pass, the smoothing (backward) KG _**G** t_ is computed using an RNN. The high-level architecture of RTSNet is depicted in Fig. 1. 

## _B. Microarchitecture_ 

RTSNet includes 2 _K_ RNNs, as each _k_ th pass utilizes one RNN to compute the forward KG and another RNN to compute the backward KG. In this subsection, we focus on a single pass of index _k_ and formulate the microarchitecture of its forward and backward RNNs, as well as which features the RNNs use to compute the KGs. 

**Forward Gain:** The forward pass is built on KalmanNet, where architecture 2 of [39] is particularly utilized to compute the forward KG, i.e., _**K** k,t_ , using separate gated recurrent unit 

4 

**==> picture [603 x 498] intentionally omitted <==**

**----- Start of picture text -----**<br>
x 0 ˆx k,t|t ˆ<br>y k,t Z [−] [1] x ˆ k,t− • 1 |t− 1 f • x k,t|t− 1 h y ˆ k,t|t− 1 − ++ ∆y • k,t× + • x ˆ k,t|t ˆxx ˆ k,Tk,t|T|t • Z [+1] ˆxx ˆ k,tk,t • | +1 T |T • x ˆ k,t|t f x ˆ k,t +1 |t + ←− ∆ x •k,t +1 + • [x] [ˆ] [k,t][|][T]<br>• ×<br>Z [−] [1] Z [+1] Z [+1]<br>− ++ ∆ˆx∆y k,tk,t− 1 Kalman K k,t Gain − ++ + − + ←− ∆ ←−←− ∆˜ xx k,tk,t +1+1 Backward Kalman Gain G k,t<br>Recurrent Neural Network ∆ˆ x k,t +1 Recurrent Neural Network<br>(a) k [th] forward pass. (b) k [th] backward pass.<br>Forward 1 Forward 2 Forward  Forward<br>Backward 1 Backward 2 Backward  Backward<br>Fig. 1: RTSNet high level architecture block diagram.<br>(GRU)moments.cells and fully connected (FC) layers and their interconnectioncellsThefordivisioneach ofof thethe trackedarchitecturesecond-orderinto separatestatisticalGRU Q ˆ 0 Z [−] [1] tt > = 00 GRU Q ˆ 1 ∆ˆ x t− 1 ∆ˆ∆∆∆ xxyy �� tttt ====  y yxx ˆˆ tttt|| − −tt −− yy ˆ tt xx ˆˆ |−ttt− 1 |−t 1 − 1 | 1 t− 1<br>is illustrated in Fig. 2. As shown in the figure, the network Q t<br>composesdedicated input and output FC layers. This architecture, whichthree GRU layers, connected in a cascade with Z [−] [1] Σ ˆ t|t<br>is composed of a non-standard interconnection between GRUsand FC layers, is directly tailored towards the formulation of Σ ˆ 0 tt > = 00 GRU Σ ˆ 2 ∆ x � t− 1<br>the SS model and the operation of the MB KF, as detailed Σ ˆ t|t− 1<br>in [39].<br>The input features are designed to capture differences in<br>the state and the observation model, as these differences are Z [−] [1]<br>mostly affected by unknown noise statistics. As in [39], the R ˆ 0 tt > = 00 GRU S ˆ 3 ∆∆ yy � tt<br>following features are used to compute K k,t (see Fig. 2):<br>F1 Observation difference ∆˜ y k,t =  y k,t − y k,t− 1. S ˆ t<br>ˆ<br>F2 Innovation difference ∆ y k,t =  y k,t − y ˆ k,t|t− 1 .ˆ<br>F3 Forward evolution difference  ∆˜ x k,t =ˆ x k,t|t − ˆ x k,t− 1 |t− 1 . K t<br>F4 Forward update difference ∆ˆ x k,t = x k,t|t − x k,t|t− 1 .<br>0 t = 0 t><br>Tt = Tt<<br>**----- End of picture text -----**<br>


**Backward Gain:** To compute _**G** k,t_ in a learned manner, we again design an architecture based on how the KS computes the backward gain. To that aim, we again use separate GRU cells for each of the tracked second-order statistical moments, as illustrated in Fig. 3. The first GRU layer tracks the unknown state noise covariance **Q** , thus tracking _m_[2] variables. Similarly, the second GRUs tracks the predicted moment **Σ**[ˆ] _t|T_ (9b) and **S**[ˆ] _t_ (6b), thus having _m_[2] hidden state variables. The GRUs are **Σ** ˆ _t|T_ interconnected , while FC layers are utilized for input and output shaping.such that the learned **Q** is used to compute 

Fig. 2: Forward gain RNN block diagram. The input features are used to update three GRUs with dedicated FC layers, and the overall interconnection between the blocks is based on the flow of the Forward KG _**K** t_ computation in the MB KF. 

The first two features capture the uncertainty in the state estimate, where the differences remove predictable components such that they are mostly affected by the unknown noise statistics. The third feature is related to the evolution of the predicted state and thus reflects on its statistics that are tracked by the KS. The features are utilized by the proposed architecture, as illustrated in Fig. 3. 

We utilize the following features, which are related to the unknown underlying statistics: 

ˆ ˆ _B1 Update difference[←−]_ ∆ **x** _k,t_ +1 = **x** _k,t_ +1 _|T −_ **x** _k,t_ +1 _|t_ . _B2 Backward forward difference[←−]_ ∆ˆ **x** _k,t_ +1 = 

## _C. Training Algorithm_ 

ˆ ˆ **x** _k,t_ +1 _|T −_ **x** _k,t_ +1 _|t_ +1 . ˆ ˆ _B3 Evolution difference[←−]_ ∆˜ **x** _k,t_ +1 = **x** _k,t_ +2 _|T −_ **x** _k,t_ +1 _|T_ . 

**Loss Function:** We train RTSNet in a supervised manner. To formulate the loss function used for training, let **Θ** _k_ denote 

5 

**==> picture [236 x 161] intentionally omitted <==**

**----- Start of picture text -----**<br>
Q ˆ T Z [+1] tt < = TT GRU Q ˆ ←− ∆ x t +1 ←−←−←− ∆∆ˆ∆˜ xxx ttt +1+1+1 = ˆ = ˆ = ˆ xxx ttt +1+1+2 |||TTT −−− xxx ˆˆˆ ttt +1+1+1 |||ttT +1<br>Z [+1] Σ ˆ t|T<br>←−<br>Σ ˆ T tt < = TT GRU Σ ˆ ←− ∆˜∆ˆ xx tt +1+1<br>G t<br>**----- End of picture text -----**<br>


respect to **Θ** _k_ via the chain rule. The gradient computation indicates that one can learn the computation of the KGs by training RTSNet end-to-end. 

**End-to-End Training:** The differentiable loss function in (17) allows end-to-end training of a single forward-backward pass of index _k_ . To train the overall unfolded RTSNet, we consider the following loss measures: 

_Joint learning_ , where the RNNs of all the passes are simultaneously using the labeled dataset _D_ . Here, we stack the trainable parameters as **Θ** = _{_ **Θ** _k}_ , and set the loss function for the _i_ th trajectory to 

**==> picture [250 x 46] intentionally omitted <==**

Fig. 3: Backward gain RNN block diagram. The input features are used to update two GRUs with dedicated FC layers, and the overall interconnection between the blocks is based on the flow of the Backward KG _**G** t_ computation in the KS. 

where **x** ˆ _k,t|T_ ( **Y** 1 _,_ **Θ** ) is the _t_ th output of the _k_ th forwardbackward pass when the input to RTSNet is **Y** 1 and its parameters are **Θ** . The coefficients _{αk}[K] k_ =1[in][(][21][)][balance] the contribution of each pass to the loss – setting _αk_ = 0 for _k < K_ evaluates RTSNet based solely on its output, while setting _αk_ = 0 for _k < K_ encourages also the intermediate passes to provide accurate estimates. The ability to evaluate RTSNet during training, not just based on its output but also on its intermediate pass (i.e., with _αk_ = 0 for _k < K_ ), is a direct outcome of its interpretable deep unfolded design. In conventional black-box DNNs, one typically cannot associate its internal features with an operational meaning and thus trains it solely based on its output. In contrast, our unfolded architecture ensures that internal modules produce a gradually refined estimate. A candidate setting is _αk_ = log(1 + _k_ ), see, e.g., [54], [55]. 

the trainable parameters of the RNNs of the _k_ th pass. The loss measure used to tune these parameters is the regularized _ℓ_ 2 loss; for a labeled pair ( **Y** _k_ ( _i_ ) _,_ **X**[(] _[i]_[)] ) of length _Ti_ , this loss is given by 

**==> picture [229 x 46] intentionally omitted <==**

In (17), **x** ˆ _k,t|T_ ( **Y** _k,_ **Θ** _k_ ) denotes the _t_ th output of the _k_ th pass with input **Y** _k_ and RNN parameters **Θ** _k_ . While the loss in (17) refers to a single trajectory _i_ , we use it to optimize RTSNet using variants of mini-batch stochastic gradient descent. Here for every batch indexed by _j_ , we choose _B < N_ trajectories indexed by _i[j]_ 1 _[[, . . . , i][j]][[j]] B_[[,]][[and]][[compute]][[the]][[mini-batch]][[loss]][[of]][[the]] _k_ th pass as 

> _[[, . . . , i][j]][[j]] B_[[,]][[and]][[compute]][[the]][[mini-batch]][[loss]][[of]][[the]] training _Sequential learning_ each pass of repeats the training procedureindex _k_ after its preceding passes _K_ times,have been trained using the same dataset. Here, the dataset _D_ is first _B L_ ¯ _k,j_ ( **Θ** _k_ ) = _B_[1] � _b_ =1 _L_ ( _ki[j] b_[)] ( **Θ** _k_ ) _._ (18) used to train onlyand **Θ** 2 is trained **Θ** using1 using ((1717) ) withwith _k k_ == 12; then,and **Y Θ** 2[(] _[i]_ 1[)] is frozen= _X_[ˆ] 1[(] _[i]_[)][,] and the procedure repeats until **Θ** _K_ is trained. This form of training, proposed in [56], exploits the modular structure of the **Computation:** RTSNet uses the RNNs for comunfolded architecture and tends to be data efficient and simpler than for directly producing the estimate to train compared with joint learning, and is also the form of function (17)17)) enables the evaluation of the training used in our empirical study presented in Section IV. 

**Gradient Computation:** RTSNet uses the RNNs for computing the KGs rather than for directly producing the estimate **x** ˆ _k,t|T_ . The loss function (17)17)) enables the evaluation of the overall system without having to externally provide ground truth values of the KGs for training purposes. Training RTSNet in an end-to-end manner thus builds upon the ability to backpropagate the loss to the computation of the KGs. One can obtain the loss gradient with respect to the KGs from the output of RTSNet since by combing (7a) and (9a) we get that 

## _D. Discussion_ 

RTSNet is designed to operate in a hybrid DD/MB manner, combining deep learning with the classical KS. It is designed by converting the EKS into a trainable architecture as a form of discriminative machine learning [48], that directly learns the smoothing task from data while bypassing the need to carry out system identification [57]. By identifying the specific noise-model-dependent computations of the KS and replacing them with a dedicated RNNs integrated in the MB flow, RTSNet benefits from the individual strengths of both DD and MB approaches. We particularly note several core differences between RTSNet and its MB counterpart. First, RTSNet is suitable for settings where full knowledge on an underlying SS model describing the dynamics is not available. Furthermore 

**==> picture [241 x 16] intentionally omitted <==**

Consequently, the gradients of the _ℓ_ 2 loss terms with respect to the KGs obey 

**==> picture [241 x 51] intentionally omitted <==**

which in turn allows to compute the gradient of the _ℓ_ 2 loss with 

6 

Unlike the EKS, RTSNet does not attempt to linearize the SS model, and does not impose a statistical model on the noise signals, while avoiding the need to compute a Jacobian and invert a matrix at each iteration. This notably facilitates operation in high-dimensional nonlinear settings [44]. In addition, RTSNet filters in a nonlinear manner, as, e.g., its forward KG matrix depends on the input **y** _t_ . Moreover, RTSNet supports multiple learned forward-backward passes. While the number of passes is a hyperparameter that should be set based on system considerations and empirical evaluations, our numerical studies reported in Section IV show that using _K_ = 2 passes improves accuracy in nonlinear settings where the single pass EKS is not optimal. Due to these differences, RTSNet is more robust to model mismatch and can infer more efficiently compared with the KS, as shown in Section IV. 

Compared to purely DD state estimation, RTSNet benefits from its model awareness, as it supports systematic inclusion of the available state evolution and observation functions, and does not have to learn its complete operation from data. As empirically observed in Section IV, RTSNet achieves improved MSE compared to utilizing RNNs for end-to-end state estimation, and also approaches the MMSE performance achieved by the KS in linear Gaussian SS models. 

Furthermore, the operation of RTSNet follows the flow of KS rather than being utilized as a black-box. This implies that the intermediate features exchanged between its modules have a specific operation meaning, providing interpretability that is often scarce in end-to-end, deep learning systems. For instance, the fact that RTSNet learns to compute the KGs indicates the possibility of providing not only estimates of the state **x** _t_ , but also a measure of confidence in this estimate, as the KGs can be related to the covariance of the estimate, as initially explored for KalmanNet in [45]. 

While RTSNet is inspired by KalmanNet, and shares its architecture for the forward pass, the algorithms are fundamentally different. KalmanNet is a filtering method, designed to operate in an adaptive sample-by-sample manner. RTSNet is a smoothing algorithm, which jointly processes a complete observed measurement sequence. The most notable difference is in the addition of a backward pass for RTSNet (which is the main extension of the KS over the KF). However, RTSNet also introduces joint learning along with the forward KG; the ability to unfold the operation into multiple iterative forwardbackward passes to facilitate coping with complex nonlinear dynamics; and a dedicated learning procedure, as detailed in Subsection III-C. 

The fact that RTSNet preserves the KS flow also indicates potential avenues for future research arising from its combination with established model-based extensions to the modelbased KS. One such avenue of future research involves the incorporation of adaptive priors [58], [59] or optimization-based extensions of the EKS [9]–[13] for tackling non-Gaussian distributions and outliers, while possibly leveraging emerging techniques for combining iterative methods with deep learning techniques [41], [60]. An alternative research avenue involves extending RTSNet to constrained smoothing [61]. This can potentially be achieved by leveraging the fact that it preserves the operation of the EKS and thus supports complying with 

some forms of state constraints by principled incorporation of differentiable projection operators [62]. These extensions of RTSNet are left for future investigation. 

While we train RTSNet in a supervised manner using labeled data, the fact that it preserves the operation of the KS indicates the possibility of training it in an _unsupervised_ manner using a loss function measuring consistency between ˆ 2 its estimates and observations, e.g., �� **h** � **x** _t|T_ � _−_ **y** _t_ �� . One can thus envision RTSNet being trained offline in a supervised manner, while tracking variations in the underlying SS model at run-time using online self-supervision. This approach was initially explored for KalmanNet in [46], and we leave its extension to future work. The ability to train in an unsupervised manner opens the door to use the backbone of RTSNet in more SS related tasks other than smoothing, e.g., signal denoising [63], imputation, and prediction. Nonetheless, we leave the exploration of these extensions of RTSNet for future work. 

## IV. EXPERIMENTS AND RESULTS 

In this section, we present an extensive empirical study of RTSNet[1] , evaluating its performance in multiple setups and comparing it with both MB and DD benchmark algorithms. We consider both linear Gaussian SS models, where we identify the ability of RTSNet to coincide with the KS (which is MSE optimal in such settings), as well as challenging nonlinear models. 

## _A. Experimental Setup_ 

**Smoothers:** Our empirical study compares RTSNet with MB and DD counterparts. We use the KS (RTS smoother) as the MB benchmark for linear models. For nonlinear models, we use the EKS and the PS [64], where the latter is based on the forward-filter backward simulator of [65] with 100 particles and 10 backward trajectories. The benchmark algorithms were optimized for performance by manually tuning the covariance matrices. This tuning is often essential to avoid divergence under model uncertainty as well as under dominant nonlinearities. 

Our main DD benchmark is the hybrid graph neural network-aided belief propagation smoother of [38] (referred to as GNN-BP), which incorporates knowledge of the SS model. We also compare with a black-box architecture using a Bi-directional RNN (BRNN), which is comprised of bidirectional GRU with input and output FC layers designed to have a similar number of trainable parameters as RTSNet. Both DNN-aided benchmarks are empirically optimized and cross-validated to achieve their best training performance. 

We use the term _full information_ to describe cases where **f** ( _·_ ) and **h** ( _·_ ) are accurately known. The term _partial information_ refers to the case where RTSNet and benchmark algorithms operate with some level of model mismatch in their available knowledge of the SS model parameters. RTSNet and the DD BRNN operate without access to the noise covariance matrices (i.e., **Q** and **R** ), while their MB counterparts operate 

1The source code used in our empirical study along with the complete set of hyperparameters can be found at https://github.com/KalmanNet/RTSNet TSP. 

7 

TABLE I: Linear SS model - Full Information - MSE [dB] 

(a) _ν_ = 0 [dB] 

|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|---|---|---|---|---|---|
|Noise|10.023<br>_±_ 0.424|0.054<br>_±_ 0.448|-10.003<br>_±_ 0.427|-19.947<br>_±_ 0.411|-29.962<br>_±_ 0.430|
|KF|8.085<br>_±_ 0.502|-1.827<br>_±_ 0.525|-11.880<br>_±_ 0.464|-21.903<br>_±_ 0.419|-31.886<br>_±_ 0.514|
|KS|6.215|-3.710|-13.776|-23.751|-33.749|
||_±_ 0.487|_±_ 0.535|_±_ 0.466|_±_ 0.519|_±_ 0.508|
|RTSNet|6.225|-3.695|-13.738|-23.732|-33.698|
||_±_ 0.487|_±_ 0.537|_±_ 0.463|_±_ 0.512|_±_ 0.506|
|(b) _ν_ =_−_10 [dB]||||||
|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|Noise|10.004<br>_±_ 0.419|0.000<br>_±_ 0.392|-10.029<br>_±_ 0.431|-19.982<br>_±_ 0.404|-29.969<br>_±_ 0.435|
|KF|5.299<br>_±_ 0.710|-4.703<br>_±_ 0.663|-14.756<br>_±_ 0.675|-24.680<br>_±_ 0.596|-34.731<br>_±_ 0.696|
|KS|1.834|-8.220|-18.179|-28.098|-38.236|
||_±_ 0.794|_±_ 0.721|_±_ 0.778|_±_ 0.726|_±_ 0.837|
|RTSNet|1.881|-8.169|-18.092|-27.875|-38.183|
||_±_ 0.796|_±_ 0.720|_±_ 0.797|_±_ 0.746|_±_ 0.836|
|(c) _ν_ =_−_20 [dB]||||||
|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|Noise|10.012<br>_±_ 0.398|-0.008<br>_±_ 0.434|-10.004<br>_±_ 0.448|-19.977<br>_±_ 0.416|-30.003<br>_±_ 0.429|
|KF|2.756<br>_±_ 1.086|-7.254<br>_±_ 1.012|-17.339<br>_±_ 0.967|-27.194<br>_±_ 1.011|-37.324<br>_±_ 0.963|
|KS|-1.790|-11.847|-21.738|-31.620|-41.831|
||_±_ 1.242|_±_ 1.190|_±_ 1.281|_±_ 1.107|_±_ 1.289|
|RTSNet|-1.640|-11.712|-21.543|-31.817|-41.505|
||_±_ 1.199|_±_ 1.173|_±_ 1.279|_±_ 1.152|_±_ 1.229|



**==> picture [253 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
10<br>5<br>0<br>-5<br>-10<br>-15<br>-20<br>-25 -10<br>-12<br>-30 -14<br>-16<br>-35 -18<br>-20<br>-40 -229.5 9.6 9.7 9.8 9.9 10 10.1 10.2 10.3 10.4 10.5<br>-10 -5 0 5 10 15 20 25 30<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 4: Linear SS model - full information. 

with an accurate knowledge of the noise covariance matrices from which the data was generated. 

**Evaluation:** The metric used to evaluate the performance is the empirical mean and standard deviation of squared error, denoted, _µ_ ˆ and _σ_ ˆ, respectively. Unless stated otherwise, we evaluate using a _N_ test = 200 test trajectories. 

Throughout the empirical study and unless stated otherwise, in the experiments involving synthetic data, the SS model is generated using diagonal noise covariance matrices; i.e., 

**==> picture [201 x 22] intentionally omitted <==**

By (22), setting _ν_ to be 0 dB implies that both the state noise and the observation noise have the same variance. 

## _B. Linear State Space Models with Full Information_ 

We first focus on comparing RTSNet with the KS for synthetically generated linear Gaussian dynamics with full 

information. Since the KS is MSE optimal here, we show that the performance of both algorithms coincides, demonstrating that RTSNet with _K_ = 1 can learn to be optimal. Then, we show that the learning capabilities of RTSNet are scalable, namely, that they hold for different SS dimensions, and transferable, i.e., that they can be trained and evaluated with different trajectory lengths and initial conditions. We conclude this study by demonstrating the ability of RTSNet to learn to smooth in the presence of non-Gaussian SS models. 

**Approaching Optimality:** We consider a 2 _×_ 2 SS model (1)-(2), where **F** takes a _canonical_ form and **H** is set to be the identity matrix, namely, 

**==> picture [177 x 25] intentionally omitted <==**

We use multiple noise levels, in [dB] scale, of r[2] _∈ {_ 10 _,_ 0 _, −_ 10 _, −_ 20 _, −_ 30 _}_ , and _ν ∈{−_ 20 _, −_ 10 _,_ 0 _}_ . The results provided in Table I, and in Fig. 4, show that RTSNet converges to the MMSE estimate produced by the KS in the first two moments. This indicates that RTSNet successfully learns to implement the KS when it is MMSE optimal. 

**Scaling up Model Size:** Next, we provide empirical evidence that RTSNet is a scalable smoothing architecture, capable of handling SS models beyond just those with small dimensions. In this experiment **F** and **H** in their canonical form were considered, q[2] = _−_ 20 [dB], r[2] = 0 [dB], and _T_ = 20. It is clearly observed in Table IIa that RTSNet retains its optimality also for high dimensional models, outperforming its DD benchmarks: BRNN is far from optimal, and the performance of GNN-BP degrades when the model dimensions increase. 

**Trajectory Length:** To show generalization in _T_ , the SS model in (23) is again considered, where q[2] = _−_ 20 [dB], and r[2] = 0 [dB]. Here, we first train RTSNet and its DD benchmarks on one trajectory length and then test it on a longer one. The results reported in Table IIb show that while RTSNet retains optimally for various trajectory lengths, BRNN completely diverges. We can also see the superiority of RTSNet over GNN-BP demonstrating slightly degraded performance. 

**Initial Conditions:** The operation of all smoothing algorithms depends on their initial state. We next train the DD benchmarks on trajectories with a different initial state compared to that used in the test for the SS model in (23) with q[2] = _−_ 20 [dB], r[2] = 0 [dB], and _T_ = 100. The results provided in Table IIc demonstrates that while BRNN completely diverges, and GNN-BP is with slightly degraded performance when trained and then tested on different initial conditions, RTSNet still retains its optimally, which again demonstrates that it learns the smoothing task, rather than to overfit to trajectories presented during training. 

**Non-Gaussian Noise:** The fact that RTSNet augments the computation of the forward and backward gains with dedicated RNNs enables it to track in non-Gaussian dynamics, where the MB KS is no longer optimal. To demonstrate this, we consider a linear SS model as in (23) where the noise signals are drawn from an i.i.d. exponential distributions with covariance 

8 

**==> picture [253 x 186] intentionally omitted <==**

**----- Start of picture text -----**<br>
10<br>0<br>-10<br>-20<br>-30<br>-30 -35<br>-40<br>-40 -45<br>26 28 30<br>-50<br>-10 -5 0 5 10 15 20 25 30<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 5: Linear non-Gaussian SS model - full information. 

TABLE II: Linear SS model - Learning Capabilities 

(a) Scaling SS Model Dimensions 

|Dimensions|2_×_2|5_×_5|10_×_10|20_×_20|
|---|---|---|---|---|
|KF|-7.791<br>_±_ 2.204|-10.931<br>_±_ 1.411|-11.062<br>_±_ 0.951|-11.540<br>_±_ 0.771|
|KS|-11.732|-12.350|-12.436|-12.762|
||_±_ 2.489|_±_ 1.561|_±_ 1.058|_±_ 0.808|
|BRNN|3.289<br>_±_ 4.495|4.261<br>_±_ 4.724|5.581<br>_±_ 4.553|3.742<br>_±_ 4.416|
|GNN-BP|-10.016<br>_±_ 2.331|-9.028<br>_±_ 1.312|-8.674<br>_±_ 0.803|-8.557<br>_±_ 0.603|
|RTSNet|-11.208|-11.9725|-12.0231|-12.2755|
||_±_ 2.438|_±_ 1.597|_±_ 1.055|_±_ 0.828|



(b) Scalability for Trajectory Length 

|_T_training_, T_testing|20_,_20|100_,_100|100_,_1000|100_, U_ [100_,_1000]|
|---|---|---|---|---|
|Noise|0.025<br>_±_0.919|-0.008<br>_±_ 0.434|0.011<br>_±_ 0.132|0.015<br>_±_ 0.227|
|KF|-7.791<br>_±_ 2.204|-7.254<br>_±_ 1.012|-7.162<br>_±_ 0.335|-7.241<br>_±_ 0.543|
|KS|-11.732|-11.847|-11.810|-11.853|
||_±_ 2.489|_±_ 1.190|_±_ 0.450|_±_ 0.687|
|BRNN|3.289<br>_±_ 4.495|22.277<br>_±_ 5.190|54.955<br>4.419|48.390<br>5.436|
|GNN-BP|-10.016<br>_±_ 2.331|-11.433<br>_±_ 1.166|-11.662<br>_±_ 0.448|-11.687<br>_±_ 1.740|
|RTSNet|-11.208|-11.753|-11.753|-11.773|
||_±_ 2.438|_±_ 1.182|_±_ 0.449|_±_ 0.685|



(c) Initial Conditions 

|Training, Testing|Fixed, Fixed|Fixed, Random|Random, Random|
|---|---|---|---|
|Noise|-0.008<br>_±_ 0.434|NA<br>NA|-0.019<br>_±_ 0.360|
|KF|-7.254<br>_±_ 1.012|NA<br>NA|-7.426<br>_±_ 0.963|
|KS|-11.847|NA|-12.025|
||_±_ 1.190|NA|_±_ 1.238|
|BRNN|22.277<br>_±_ 5.190|37.281<br>_±_ 2.003|26.606<br>_±_ 3.547|
|GNN-BP|-11.433<br>_±_ 1.166|-10.655<br>_±_ 1.219|-11.382<br>_±_ 1.164|
|RTSNet|-11.753|-11.757|-11.701|
||_±_ 1.182|_±_ 1.187|_±_ 1.214|



matrices given in (22). For this setting, we compare RTSNet with the MB KS and KF, as well as with the DD GNN-BP, for _ν_ = _−_ 20 [dB]. The resulting MSE versus 1 _/_ r[2] are reported in Fig. 5. There, it is clearly observed that RTSNet outperforms not only the MB KS with a notable gap, but also the DD GNNBP. These results indicate the ability of the hybrid architecture of RTSNet to successfully cope with non-Gaussian dynamics. 

**==> picture [252 x 146] intentionally omitted <==**

**----- Start of picture text -----**<br>
10<br>5<br>0<br>-5<br>-10<br>-15<br>-20<br>-25<br>-30<br>-35<br>-40<br>-10 -5 0 5 10 15 20 25 30<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 6: Linear SS model - Observation mismatch. 

_C. Linear SS Models with Partial Information_ 

Next, we demonstrate the merits of using RTSNet in linear settings with _partial information_ where the KS is degraded due to the missing information. We consider mismatches in both the observation model as well as in the state evolution model. In particular, a mismatch in a model, e.g., the observation model, refers to a case in which a wrong setting of **h** ( _·_ ) is used, while the MB smoothers have access to the noise distribution. We also consider the case in which the corresponding model is unknown, e.g., both **h** ( _·_ ) and the noise distribution are unknown for the observation model; In such cases, since unlike GNN-BP and the MB benchmarks, RTSNet does not require prior knowledge of the noise distribution, we also evaluate it when it uses its data also to estimate the missing design parameter, e.g., **h** ( _·_ ), using LS. 

**Observation Model Mismatch:** We first consider the case where the _design_ observation model is mismatched. We again use the canonical model in (23) with the observation matrix being either _unknown_ , or assumed to be **H** 0 = **I** , while the observation model is 

**==> picture [251 x 37] intentionally omitted <==**

with **H** 0 = **I** . The data is generated with _α[◦]_ = 10. Such scenarios represent a setup where the true observed values are rotated by _α[◦]_ , e.g., a slight misalignment of the sensors exists. 

We compare the performance of RTSNet and the KS when their design observation model is either **H** _α_ =10 (full information) or **H** _α_ =0 (mismatch). We also consider the case where the matrix is estimated from the data set via LS, denoting **H**[ˆ] _α_ =10. The empirical results reported in Table III and in Fig. 6 demonstrate that while KS experienced a severe performance degradation, RTSNet is able to compensate for mismatches using the learned KG. When assuming a mismatched model **H** 0, RTSNet converges to within a minor gap from the MMSE, which is further reduced when the data is also used to estimate the observation model. The latter indicates that even when the SS model is completely unknown, yet can be postulated as being linear, RTSNet can reliably smooth by using its data to both estimate the state evolution matrix as well as learn to smooth, while bypassing the need to impose a model on the noise. 

9 

TABLE III: Linear SS - Observation mismatch: _ν_ = _−_ 20 [dB] 

|r2 [dB]|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|---|---|---|---|---|---|---|
|KF|Full|2.702|-7.394|-17.367|-27.293|-37.273|
|||_±_ 0.885|_±_ 0.901|_±_ 0.957|_±_ 0.966|_±_ 1.029|
|KS|Full|-1.875|-11.880|-21.812|-31.961|-41.810|
|||_±_ 1.285|_±_ 1.272|_±_ 1.149|_±_ 1.265|_±_ 1.156|
|BRNN|Opt|33.490|22.120|13.523|4.058|-5.876|
|||_±_ 4.490|_±_ 4.808|_±_ 5.334|_±_ 4.543|_±_ 4.421|
|GNN-BP|Full|-1.417<br>_±_ 1.244|-11.397<br>_±_ 1.248|-21.383<br>_±_ 1.148|-31.545<br>_±_ 1.252|-41.395<br>_±_ 1.200|
|RTSNet|Full|-1.790|-11.847|-21.738|-31.620|-41.831|
|||_±_ 1.242|_±_ 1.190|_±_ 1.281|_±_ 1.107|_±_ 1.289|
|KF|Partial|11.154<br>_±_ 3.023|0.926<br>_±_ 3.064|-9.160<br>_±_ 3.651|-18.428<br>_±_ 3.253|-28.786<br>_±_ 3.301|
|KS|Partial|5.502<br>_±_ 2.942|-4.825<br>_±_ 3.205|-15.062<br>_±_ 3.440|-24.198<br>_±_ 3.119|-34.592<br>_±_ 3.133|
|GNN-BP|Partial|-0.989<br>_±_ 1.223|-11.123<br>_±_ 1.243|-20.865<br>_±_ 1.587|-30.080<br>_±_ 1.354|-38.174<br>_±_ 2.624|
|RTSNet|Partial|-0.774<br>_±_ 1.243|-10.852<br>_±_ 1.158|-21.104<br>_±_ 1.216|-29.667<br>_±_ 1.215|-38.066<br>_±_ 1.136|
|RTSNet|ˆ**H**|-1.743|-11.697|-21.721|-31.186|-40.301|
|||_±_ 1.269|_±_ 1.241|_±_ 1.153|_±_ 1.220|_±_ 1.169|



TABLE IV: Linear SS - Evolution mismatch: _ν_ = _−_ 20 [dB] 

|r2 [dB]|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|---|---|---|---|---|---|---|
|KF|Full|3.450<br>_±_ 1.846|-6.594<br>_±_ 1.883|-16.562<br>_±_ 1.876|-26.601<br>_±_ 1.907|-36.565<br>_±_ 1.831|
|KS|Full|-3.843|-13.913|-23.592|-33.861|-43.593|
|||_±_ 2.655|_±_ 2.709|_±_ 2.751|_±_ 2.753|_±_ 2.746|
|BRNN|Opt|40.915<br>_±_ 5.033|30.714<br>_±_ 5.317|20.796<br>_±_ 4.955|12.593<br>_±_ 4.281|2.411<br>_±_ 4.069|
|GNN-BP|Full|-1.975<br>_±_ 2.549|-11.850<br>_±_ 3.369|-21.403<br>_±_ 2.564|-30.579<br>_±_ 2.548|-41.016<br>_±_ 2.682|
|RTSNet|Full|-3.351|-13.585|-23.333|-33.126|-43.160|
|||_±_ 2.699|_±_ 2.673|_±_ 2.671|_±_ 2.628|_±_ 2.649|
|KF|Partial|33.961<br>_±_ 3.933|23.833<br>_±_ 3.857|13.848<br>_±_ 3.683|4.199<br>_±_ 3.850|-6.434<br>_±_ 3.812|
|KS|Partial|32.963<br>_±_ 3.933|22.838<br>_±_ 3.859|12.853<br>_±_ 3.685|3.201<br>_±_ 3.851|-7.431<br>_±_ 3.809|
|GNN-BP|Partial|12.150<br>_±_ 4.215|-1.152<br>_±_ 6.240|-5.042<br>_±_ 4.272|-10.950<br>_±_ 2.790|-26.154<br>_±_ 3.968|
|RTSNet|Partial|10.553<br>_±_ 3.151|-2.011<br>_±_ 1.945|-10.689<br>_±_ 1.934|-21.683<br>_±_ 1.643|-31.887<br>_±_ 1.244|
|RTSNet|ˆ**F**|-3.433|-12.945|-23.013|-32.932|-41.864|
|||_±_ 2.633|_±_ 2.682|_±_ 2.798|_±_ 2.471|_±_ 2.657|



**State Evolution Mismatch:** We next consider a similar, but more challenging use case. Here, the _design_ evolution model is either _unknown_ , or assumed to be **F** 0 = **I** , while the _true_ evolution model is 

**==> picture [195 x 12] intentionally omitted <==**

The empirical results reported in Table IV demonstrate that while KS experienced a severe performance degradation, RTSNet is able to compensate for unknown model information, by pre-estimating the evolution model via LS, and achieve the lower-bound. We can again clearly notice the performance superiority of our RTSNet over its DD counterparts, both for full and unknown information. 

## _D. Kinematic Linear Differential Equations_ 

As a concluding experiment in a setting of linear SS models, we consider smoothing in dynamics obtained from a stochastic differential equation (SDE) with a model mismatch. The state here represents a moving object obeying the constant acceleration (CA) model [49] for one-dimensional kinematics. Here, **x** _t_ = ( _pt, vt, at_ ) _[⊤] ∈_ R[3] , where _pt_ , _vt_ , and _at_ are the position, velocity, and acceleration, respectively, at time 

TABLE V: Linear kinematic SS model 

|Model|Error|KF|KS|GNN-BP|RTSNet-2|
|---|---|---|---|---|---|
|CA|Full State|-7.631|-8.791|14.351|-8.432|
|||_±_ 2.891|_±_ 3.054|_±_ 2.011|_±_ 2.974|
|CA|Position|-22.074|-23.221|-11.456|-22.241|
|||_±_ 3.694|_±_ 4.081|_±_ 2.037|_±_ 3.676|
|CV|Position|-7.657|-14.752|-10.732|-15.900|
|||_±_ 3.145|_±_ 3.308|_±_ 1.661|_±_ 2.542|



_t_ . We observe noisy position measurements sampled at time intervals ∆ _t_ = 10 _[−]_[2] , yielding a linear Gaussian SS model with **H** = (1 _,_ 0 _,_ 0) and 

**==> picture [256 x 37] intentionally omitted <==**

While for the synthetic linear models considered in the previous subsections we used RTSNet with a single forwardbackward pass, here we evaluate it with _K_ = 2 unfolded pass, comparing it to both the KS and to GNN-BP when recovering the entire state vector, as well as when recovering only the position (which is often the case in positioning applications). For the latter, we also consider the case where the smoothers assume a more simplified constant velocity (CV) model [49] state evolution for state evolution. The CV model captures in its state vector the position and velocity (without the acceleration), and is a popular model for kinematics due to its simplicity. Yet, for the current setting, it induces an inherent model mismatch. The results are reported in Table V. 

For the GNN-BP smoother of [38], which is DD yet also requires knowledge of the SS model, we optimized **Q** via grid search to achieve the best performance, as it was shown to be unstable when substituting the true **Q** . In Table V, we observe that RTSNet comes within a minor gap of the KS in estimating both the full state as well as only the positions when it is known that the state obeys the CA model; When it is postulated that the state obeys the CV model, RTSNet outperforms all benchmarks. 

In the study reported in Table V, the state trajectory was simulated from a kinematic CA model, which is a linear Gaussian state evolution model. We next show that the improved performance of RTSNet is preserved also when tracking states corresponding to real-world vehicular trajectories, that are only approximated by linear Gaussian models. To that aim, we use the city recordings from the KITTI data set [66], where each sample represents the position of a vehicle in threedimensional space, with 16 training trajectories, 2 validation trajectories, and 6 testing trajectories, all sampled at intervals of ∆ _t_ = 10 _[−]_[2] . The measurements are noisy observations of the position corrupted by Gaussian noise with covariance **R** = **I** 3 

In Table VI we compare the MSE achieved by RTSNet with _K_ = 1 to that of the MB KF and KS, where all smoothers assume a CV model on the underlying state trajectory. We observe in Table VI that RTSNet outperforms the MB benchmarks, as it learns from data to compensate for the inherent mismatch in modeling the underlying real-world vehicular trajectory as obeying a CV model. 

10 

TABLE VI: KITTI kinematic SS model 

|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|Model<br>KF<br>KS<br>RTSNet-1<br>CV<br>-21.395<br>-25.158<br>-26.566<br>_±_ 0.486<br>_±_ 0.633<br>_±_ 0.422<br>TABLE VII: Lorenz attractor - Observation Mismatch:|
|---|---|---|---|---|---|---|
|r2 [dB]||10|0|_−_10|_−_20|_−_30|
|Noise<br>EKF<br>Full||10.017<br>_±_ 0.334<br>-0299|0.005<br>_±_ 0.376<br>-10533|-10.011<br>_±_ 0.368<br>-20493|-19.942<br>_±_ 0.347<br>-30348|-29.986<br>_±_ 0.354<br>-40483|
|EKS|Full|.<br>_±_ 1.084<br>-3892|.<br>_±_ 1.016<br>-13752|.<br>_±_ 0.969<br>-23868|.<br>_±_ 1.016<br>-33743|.<br>_±_ 0.992<br>-43755|
|||.<br>_±_ 0.996|.<br>_±_ 1.161|.<br>_±_ 1.025|.<br>_±_ 1.013|.<br>_±_ 1.145|
|GNN-BP|Full|-2.263<br>_±_ 1.113|-12.398<br>_±_ 1.182|-22.413<br>_±_ 1.076|-31.040<br>_±_ 1.046|-42.368<br>_±_ 1.256|
|RTSNet-2|Full|-3.138|-13.330|-23.304|-33.311|-43.235|
|||_±_ 0.983|_±_ 1.195|_±_ 1.036|_±_ 0.999|_±_ 1.112|
|EKF|Partial|-0.258<br>_±_ 1.073|-9.747<br>_±_ 0.988|-15.945<br>_±_ 0.769|-17.549<br>_±_ 0.325|-17.752<br>_±_ 0.109|
|EKS|Partial|-3.824<br>_±_ 0.976|-12.932<br>_±_ 1.122|-18.957<br>_±_ 0.853|-20.363<br>_±_ 0.366|-20.563<br>_±_ 0.126|
|GNN-BP|Partial|-1.921<br>_±_ 0.962|-11.959<br>_±_ 1.308|-18.724<br>_±_ 0.871|-23.076<br>_±_ 0.743|-23.351<br>_±_ 0.472|
|RTSNet-2|Partial|-3.010<br>_±_ 1.067|-13.290<br>_±_ 1.175|-22.620<br>_±_ 1.077|-31.789<br>_±_ 1.207|-41.874<br>_±_ 1.216|
|RTSNet-2|ˆ**H**|-3.127|-13.315|-23.158|-32.581|-42.928|
|||_±_ 1.057|_±_ 1.194|_±_ 1.043|_±_ 1.119|_±_ 1.145|



## _E. Nonlinear Lorenz Attractor_ 

We proceed to evaluate RTSNet in a nonlinear SS model following the Lorenz attractor, which is a three-dimensional chaotic solution to the Lorenz system of ordinary differential equations. This synthetically generated chaotic system exemplifies dynamics formulated with SDEs, that demonstrates the task of smoothing a highly nonlinear trajectory and a real-world practical challenge of handling mismatches due to sampling a continuous-time signal into discrete-time [67]. As the dynamics are nonlinear, here we use RTSNet with both _K_ = 1 and _K_ = 2 forward-backward passes, denoted RTSNet-1 and RTSNet-2, respectively. 

The Lorenz attractor models the movement of a particle in 3D space, i.e., _m_ = 3, which, when sampled at interval ∆ _τ_ , obeys a state evolution model with **f** ( **x** _t_ ) = **F** ( **x** _t_ ) _·_ **x** _t_ , where 

**==> picture [197 x 31] intentionally omitted <==**

with _J_ denoting the order of the Taylor series approximation used to obtain the model (where we use _J_ = 5 when generating the data), and 

**==> picture [143 x 37] intentionally omitted <==**

We first evaluate RTSNet under noisy rotated state observations, with and without observation model mismatch as well as with sampling mismatches, after which we evaluate it with nonlinear observations. 

**Rotated State Observations:** Here, we consider the discrete-time state evolution with ∆ _τ_ = 0 _._ 02. The observations model **h** ( _·_ ) is set to a rotation matrix with _α_ = 1 _[◦]_ , whereas _T_ = 100 and _ν_ = _−_ 20 [dB]. As in Subsection IV-C, we consider the cases where the smoothers are aware of the rotation (Full information); when the assumed state evolution is the identity matrix instead of the slightly rotated one (Partial 

**==> picture [253 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
10<br>5<br>0<br>-5<br>-10<br>-15<br>-20 -10<br>-25 -12-14<br>-30 -16<br>-18<br>-35 -20<br>-22<br>-40 -24<br>9.5 9.6 9.7 9.8 9.9 10 10.1 10.2 10.3 10.4 10.5<br>-10 -5 0 5 10 15 20 25 30<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 7: _T_ = 2000, _ν_ = _−_ 20 [dB], **h** ( _·_ ) = **I** . information), as well as when it is estimated from the data set via LS ( **H**[ˆ] ). 

The results reported in Table VII and in Fig. 7 demonstrate that although RTSNet does not have access to the true statistics of the noise, for the case of _full_ observation model information, it still achieves the MSE lower-bound. It is also observed that a mismatched state observation model obtained from a seemingly minor rotation causes severe performance degradation for the KS, which is sensitive to model uncertainty, while RTSNet is able to learn from data to overcome such mismatches. Finally, empirical observations reveal that RTSNet consistently surpasses the DD benchmark presented in [38]. Furthermore, the utilization of its unfolding mechanism with _K_ = 2 forward-backward passes leads to a notable enhancement in performance compared to just a single pass. 

**Sampling Mismatch:** Here, we demonstrate a practical case where a physical process evolves in continuous-time, but the smoother only has access to noisy observations in discretetime, which then results in an inherent mismatch in the SS model. We generate data from an approximate continuoustime noise-less state evolution **F** ( **x** _τ_ ), with high resolution time interval ∆ _τ_ = 10 _[−]_[5] . We then sub-sampled the process by a ratio of 20001[and][get][a][decimated][process][with][∆] _[t]_[=] 0 _._ 02. Finally, we generated noisy observations of the true state, by using an identity observation matrix **h** ( _·_ ) = **I** and noncorrelated observation noise with r[2] = 0 [dB]. See an example in Fig. 8: ground truth, and noisy observations, respectively. 

The MSE values for smoothing sequences with length _T_ = 3000, reported in Table VIII, demonstrate that RTSNet overcomes the mismatch induced by representing a continuous-time SS model in discrete-time, achieving a substantial processing gain over its MB and DD counterparts due to its learning capabilities. In Fig. 8, we visualize how this gain is translated into clearly improved smoothing of a single trajectory. 

**Noisy Nonlinear Observations:** Finally, we consider the case of the discrete-time Lorenz attractor, with nonlinear observations, which take the form of a transformation from a cartesian coordinate system to spherical coordinates. In such settings, the observations function is given by 

**==> picture [185 x 49] intentionally omitted <==**

11 

TABLE VIII: MSE [dB] - Lorenz attractor with sampling mismatch. 

**==> picture [502 x 115] intentionally omitted <==**

**----- Start of picture text -----**<br>
Noise extended KF (EKF) PF KalmanNet EKS PS BRNN GNN-BP RTSNet-1 RTSNet-2<br>-0.024 -6.316 -5.333 -11.106 -10.075 -7.222 -2.342 -16.479 -15.436 -16.803<br>± 0.049 ± 0.135 ± 0.136 ± 0.224 ± 0.191 ± 0.202 ± 0.092 ± 0.352 ± 0.329 ± 0.301<br>Extended Kalman Smoother<br>Ground Truth BRNN RTSNet-1<br>Noisy Observations Particle Smoother GNN-BP RTSNet-2<br>**----- End of picture text -----**<br>


Fig. 8: Lorenz attractor with sampling mismatch (decimation), _T_ = 3000. 

TABLE IX: Lorenz attractor with nonlinear observations 

|r2 [dB]|r2 [dB]|10|0|_−_10|_−_20|_−_30|
|---|---|---|---|---|---|---|
|EKF|Full|24.693<br>_±_ 4.147|12.197<br>_±_ 8.061|-6.343<br>_±_ 1.961|-15.574<br>_±_ 3.451|-26.418<br>_±_ 1.743|
|EKS|Full|24.739|12.045|-7.613|-16.134|-28.211|
|||_±_ 4.313|_±_ 8.260|_±_ 2.474|_±_ 5.157|_±_ 1.548|
|PS|Full|20.490<br>_±_ 6.187|7.612<br>_±_ 10.071|-7.093<br>_±_ 1.822|-17.293<br>_±_ 1.704|-27.138<br>_±_ 1.743|
|RTSNet-1|Full|21.094<br>_±_ 2.901|10.804<br>_±_ 8.999|-8.074<br>_±_ 1.500|-17.941<br>_±_ 1.712|-27.476<br>_±_ 1.553|
|RTSNet-2|Full|19.849|6.100|-8.122|-17.960|-27.630|
|||_±_ 4.183|_±_ 6.614|_±_ 1.521|_±_ 1.676|_±_ 1.558|
||||||||
|-10<br>-25<br>-20<br>-15<br>-10<br>-5<br>0<br>5<br>10<br>15<br>20<br>25<br>MSE [dB]|-5<br>0<br>5<br>10<br>15<br>20<br>25<br>30<br>**-0.5**<br>**-0.4**<br>**-0.3**<br>**-0.2**<br>**-0.1**<br>**0**<br>**0.1**<br>**0.2**<br>**0.3**<br>**0.4**<br>**0.5**<br>**5**<br>**6**<br>**7**<br>**8**<br>**9**<br>**10**<br>**11**<br>**12**<br>**13**||||||



Fig. 9: _T_ = 20, _ν_ = 0 [dB], **h** ( _·_ ) nonlinear. We further set _T_ = 20 and _ν_ = 0 [dB]. 

The MSE achieved by RTSNet with _K_ = 2 forwardbackward passes is compared with that of the KS, PS and RTSNet with _K_ = 1, reported in Table IX and depicted in Fig. 9. It is clearly observed here that in such nonlinear setups, RTSNet outperforms its MB counterparts which operate with full knowledge of the underlying SS model, indicating the ability of its DNN augmentation and unfolded architecture to improve performance in the presence of nonlinearities. 

## _F. Nonlinear Van Der Pol Oscillator_ 

The study reported in Subsection IV-E shows the ability of RTSNet to successfully cope with harsh nonlinearities in the SS model. To further demonstrate this property of RTSNet, we next evaluate it in tracking the Van Der Pol Oscillator [68, Sec. 4.1], where the state is a two-dimensional vector governed by the following nonlinear state-evolution model 

**==> picture [247 x 25] intentionally omitted <==**

TABLE X: Van der Pol oscillator 

|EKF|EKS|Gauss-Newton|RTSNet-1|
|---|---|---|---|
|12.711<br>|3.164<br>|-4.94<br>|-7.689<br>|
|_±_ 5.951|_±_ 4.135|_±_ 2.45|_±_ 3.102|



with ∆ _τ_ = 0 _._ 1 Tracking is done based on noisy observations of the first state element, i.e., **H** = (1 _,_ 0), with **Q** = 0 _._ 01 _·_ **I** 2 and **R** = 1. The initial state is fixed to **x** 0 = (0 _, −_ 5) _[⊤]_ , and the trajectory length is _T_ = 40. 

In addition to comparing RTSNet to the MB EKF and EKS, here we also compare it to optimization-based smoothers that are derived from the MAP formulation, and particularly the MB Gauss-Newton method of [9, Sec. 3]. This optimizationbased smoother is typically capable of tracking in nonlinear SS models, while coinciding with the MSE optimal EKS for linear Gaussian cases. The resulting MSE values are reported in Table X. There, it is observed that the nonlinear state evolution model in (26) limits the performance of the EKF and the EKS, which are outperformed by the Gauss-Newton method of [9]. Still, RTSNet is shown in Table X to outperform all these MB smoothers, which operate with full knowledge of the underlying SS model and the noise distribution. 

## _G. Complexity Analysis_ 

So far, we have demonstrated that RTSNet delivers superior MSE performance, surpassing both its DD and MB counterparts, especially when they operate with partial information or under nonlinear dynamics. We conclude our empirical study by highlighting that the advantages of RTSNet don’t come with added computational complexity during inference, dependency on large datasets, or an increase in DNN size 

In Table XI, we detail the average inference time for all filters (without parallelism) using the Lorenz attractor state estimation task as a benchmark. The stopwatch timings, captured on _Google Colab_ equipped with a CPU: Intel(R) Xeon(R) CPU @ 2.20GHz and GPU: Tesla P100-PCIE-16GB, reveal that RTSNet is highly competitive when compared with classical methods and even outperforms GNN-BP. This superiority is primarily attributed to its efficient neural network computations. Furthermore, unlike the MB filters, RTSNet bypasses the need for linearization and matrix inversions at each time step. 

Subsequently, we delve into the volume of training trajectories required to effectively train RTSNet. Focusing again on the 

12 

**==> picture [234 x 176] intentionally omitted <==**

**----- Start of picture text -----**<br>
-10<br>-11<br>-15<br>-12<br>-16<br>-13<br>-17<br>-14<br>6 6.5 7 7.5<br>-15<br>-16<br>-17<br>-18<br>-19<br>-20<br>0 2 4 6 8 10 12 14 16 18 20<br>MSE [dB]<br>**----- End of picture text -----**<br>


Fig. 10: MSE versus 10 log10( _N_ ), nonlinear. 

Lorenz attractor setup, we measure the average MSE against varying data sizes. Specifically, each DD smoothing algorithm is trained with a varying number of trajectories (denoted as _N_ ) spanning a length of _T_ = 3000 pairs with an observation noise of r[2] = 0 [dB]. As depicted in Fig. 10, which showcases test MSE versus 10 log10 ( _N_ ), RTSNet is successfully trained even with a single trajectory. Notably, its performance is approached by DD GNN-BP only when the number of trajectories exceeds 50. 

In conclusion, a side-by-side comparison of DNN size, represented by the number of trainable parameters, between RTSNet and GNN-BP for select use cases reveals some insightful findings. Table Table XII lists the number of parameters, illustrating the compactness of RTSNet, thereby implying that it is easier to train. Significantly, RTSNet consistently outperforms the DD GNN-BP benchmark of [38] across tested scenarios. This is achieved with a simpler architecture that has fewer trainable parameters. This stands out especially considering that the design of [38] also emphasizes compactness and efficiency. Ultimately, The reduced parameterization of RTSNet leads to faster training and inference. 

## V. CONCLUSION 

In this work, we introduced RTSNet, a hybrid fusion of deep learning with the classic KS. Our design identifies the SS-model-dependent computations of the KS and replaces them with dedicated RNNs. These RNNs operate on specific features that encapsulate the information necessary for their operation. Additionally, we unfold the algorithm to enable multiple trainable forward-backward passes. Our empirical studies reveal that RTSNet can perform offline state estimation similarly to the KS, but with the added ability to learn to overcome model mismatches and nonlinearities. Notably, RTSNet employs a relatively compact RNN, which can be trained with a modest-sized data set, leading to reduced complexity. 

## REFERENCES 

- [1] X. Ni, G. Revach, N. Shlezinger, R. J. G. van Sloun, and Y. C. Eldar, “RTSNet: Deep Learning Aided Kalman Smoothing,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2022, pp. 5902–5906. 

- [2] J. Durbin and S. J. Koopman, _Time series analysis by state space methods_ . Oxford University Press, 2012. 

- [3] N. Wiener, _Extrapolation, interpolation, and smoothing of stationary time series: With engineering applications_ . MIT press Cambridge, MA, 1949, vol. 113, no. 21. 

- [4] R. E. Kalman, “A new approach to linear filtering and prediction problems,” _Journal of Basic Engineering_ , vol. 82, no. 1, pp. 35–45, 1960. 

- [5] H. E. Rauch, F. Tung, and C. T. Striebel, “Maximum likelihood estimates of linear dynamic systems,” _AIAA Journal_ , vol. 3, no. 8, pp. 1445–1450, 1965. 

- [6] H.-A. Loeliger, J. Dauwels, J. Hu, S. Korl, L. Ping, and F. R. Kschischang, “The Factor Graph Approach to Model-Based Signal Processing,” _Proceedings of the IEEE_ , vol. 95, no. 6, pp. 1295–1322, 2007. 

- [7] F. Wadehn, _State space methods with applications in biomedical signal processing_ . ETH Zurich, 2019, vol. 31. 

- [8] J. Humpherys, P. Redd, and J. West, “A fresh look at the Kalman filter,” _SIAM review_ , vol. 54, no. 4, pp. 801–823, 2012. 

- [9] A. Y. Aravkin, J. V. Burke, and G. Pillonetto, “Optimization viewpoint on Kalman smoothing with applications to robust and sparse estimation,” _Compressed sensing & sparse filtering_ , pp. 237–280, 2014. 

- [10] A. Y. Aravkin, B. M. Bell, J. V. Burke, and G. Pillonetto, “An _ℓ_ 1-Laplace Robust Kalman Smoother,” _IEEE Trans. Autom. Control_ , vol. 56, no. 12, pp. 2898–2911, 2011. 

- [11] A. Y. Aravkin, J. V. Burke, and G. Pillonetto, “Sparse/Robust Estimation and Kalman Smoothing with Nonsmooth Log-Concave Densities: Modeling, Computation, and Theory.” _Journal of Machine Learning Research_ , vol. 14, 2013. 

- [12] A. Y. Aravkin and J. V. Burke, “Smoothing dynamic systems with statedependent covariance matrices,” in _IEEE Conference on Decision and Control_ , 2014, pp. 3382–3387. 

- [13] A. Aravkin, J. V. Burke, L. Ljung, A. Lozano, and G. Pillonetto, “Generalized Kalman smoothing: Modeling and algorithms,” _Automatica_ , vol. 86, pp. 63–86, 2017. 

- [14] Z. Ghahramani and G. E. Hinton, “Parameter Estimation for Linear Dynamical Systems,” University of Totronto, Dept. of Computer Science, Tech. Rep. CRG-TR-96-2, 02 1996. 

- [15] J. Dauwels, A. W. Eckford, S. Korl, and H. Loeliger, “Expectation Maximization as Message Passing - Part I: Principles and Gaussian Messages,” _CoRR_ , vol. abs/0910.2832, 2009. [Online]. Available: http://arxiv.org/abs/0910.2832 

- [16] K.-V. Yuen and S.-C. Kuok, “Online updating and uncertainty quantification using nonstationary output-only measurement,” _Mechanical Systems and Signal Processing_ , vol. 66, pp. 62–77, 2016. 

- [17] H.-Q. Mu, S.-C. Kuok, and K.-V. Yuen, “Stable robust Extended Kalman filter,” _Journal of Aerospace Engineering_ , vol. 30, no. 2, p. B4016010, 2017. 

- [18] L. Martino, J. Read, V. Elvira, and F. Louzada, “Cooperative parallel particle filters for online model selection and applications to urban mobility,” _Digital Signal Processing_ , vol. 60, pp. 172–185, 2017. 

- [19] L. Xu and R. Niu, “EKFNet: Learning system noise statistics from measurement data,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2021, pp. 4560–4564. 

- [20] S. T. Barratt and S. P. Boyd, “Fitting a Kalman smoother to data,” in _IEEE American Control Conference (ACC)_ , 2020, pp. 1526–1531. 

- [21] M. Zorzi, “On the robustness of the Bayes and Wiener estimators under model uncertainty,” _Automatica_ , vol. 83, pp. 133–140, 2017. 

- [22] A. Longhini, M. Perbellini, S. Gottardi, S. Yi, H. Liu, and M. Zorzi, “Learning the tuned liquid damper dynamics by means of a robust ekf,” in _2021 American Control Conference (ACC)_ , 2021, pp. 60–65. 

- [23] I. Goodfellow, Y. Bengio, and A. Courville, _Deep Learning_ . MIT Press Cambridge, MA, 2016, http://www.deeplearningbook.org. 

- [24] J. Chung, C. Gulcehre, K. Cho, and Y. Bengio, “Empirical evaluation of gated recurrent neural networks on sequence modeling,” in _NIPS 2014 Workshop on Deep Learning, December 2014_ , 2014. 

- [25] A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. u. Kaiser, and I. Polosukhin, “Attention is All you Need,” in _Advances in Neural Information Processing Systems_ , I. Guyon, U. V. Luxburg, S. Bengio, H. Wallach, R. Fergus, S. Vishwanathan, and R. Garnett, Eds., vol. 30. Curran Associates, Inc., 2017. [Online]. Available: https://proceedings.neurips.cc/paper files/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf 

- [26] P. Becker, H. Pandya, G. Gebhardt, C. Zhao, C. J. Taylor, and G. Neumann, “Recurrent Kalman networks: Factorized inference in high-dimensional deep feature spaces,” in _International Conference on Machine Learning_ . PMLR, 2019, pp. 544–552. 

13 

TABLE XI: Inference Time [sec] - Lorenz attractor. 

|_Use Case_|Trajectory Length|KF|PF|KalmanNet|KS|PS|GNN-BP|RTSNet-1|RTSNet-2|
|---|---|---|---|---|---|---|---|---|---|
|Nonlinear Observations|_T_ = 20|0.0501|NA|NA|0.0946|5.0175|NA|0.0605|0.1178|
|Linear Observations|_T_ = 100|0.2194|NA|NA|0.4344|24.4158|1.2513|0.2950|NA|
|Decimation (_K_ = 2)|_T_ = 3000|4.3583|45.4791|4.9226|6.5164|452.8513|25.4527|7.3587|14.6174|
|Decimation (_K_ = 5)|_T_ = 3000|6.2641|71.6549|NA|10.3243|723.9320|NA|NA|NA|



TABLE XII: Network Size - Number of Trainable Parameters 

|_Use Case_|Linear - 2_×_2|Linear - 5_×_5|Lorentz - Decimation|
|---|---|---|---|
|RTSNet|7_,_370|28_,_285|33_,_270 (#1) _,_ 66_,_540 (#2)|
|GNN-BP|40_,_947|41_,_814|41_,_236|



- [27] M. Zaheer, A. Ahmed, and A. J. Smola, “Latent LSTM allocation: Joint clustering and non-linear dynamic modeling of sequence data,” in _International Conference on Machine Learning_ , 2017, pp. 3967–3976. 

- [28] R. G. Krishnan, U. Shalit, and D. A. Sontag, “Deep Kalman filters,” _CoRR_ , vol. abs/1511.05121, 2015. 

- [29] E. Archer, I. M. Park, L. Buesing, J. Cunningham, and L. Paninski, “Black box variational inference for state space models,” _arXiv preprint arXiv:1511.07367_ , 11 2015. 

- [30] M. Karl, M. Soelch, J. Bayer, and P. van der Smagt, “Deep Variational Bayes Filters: Unsupervised Learning of State Space Models from Raw Data,” in _International Conference on Learning Representations_ , 2017. 

- [31] R. Krishnan, U. Shalit, and D. Sontag, “Structured inference networks for nonlinear state space models,” in _Proceedings of the AAAI Conference on Artificial Intelligence_ , vol. 31, no. 1, 2017. 

- [32] M. Fraccaro, S. D. Kamronn, U. Paquet, and O. Winther, “A Disentangled Recognition and Nonlinear Dynamics Model for Unsupervised Learning,” in _Advances in Neural Information Processing Systems_ , 2017. 

- [33] T. Haarnoja, A. Ajay, S. Levine, and P. Abbeel, “Backprop KF: Learning discriminative deterministic state estimators,” in _Advances in Neural Information Processing Systems_ , 2016, pp. 4376–4384. 

- [34] B. Laufer-Goldshtein, R. Talmon, and S. Gannot, “A hybrid approach for speaker tracking based on TDOA and data-driven models,” _IEEE/ACM Trans. Audio, Speech, Language Process._ , vol. 26, no. 4, pp. 725–735, 2018. 

- [35] L. Zhou, Z. Luo, T. Shen, J. Zhang, M. Zhen, Y. Yao, T. Fang, and L. Quan, “KFNet: Learning temporal camera relocalization using Kalman Filtering,” in _Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition_ , 2020, pp. 4919–4928. 

- [36] H. Coskun, F. Achilles, R. DiPietro, N. Navab, and F. Tombari, “Long short-term memory Kalman filters: Recurrent neural estimators for pose regularization,” in _Proceedings of the IEEE International Conference on Computer Vision_ , 2017, pp. 5524–5532. 

- [37] S. S. Rangapuram, M. W. Seeger, J. Gasthaus, L. Stella, Y. Wang, and T. Januschowski, “Deep state space models for time series forecasting,” in _Advances in Neural Information Processing Systems_ , 2018, pp. 7785– 7794. 

- [38] V. G. Satorras, Z. Akata, and M. Welling, “Combining generative and discriminative models for hybrid inference,” in _Advances in Neural Information Processing Systems_ , 2019, pp. 13 802–13 812. 

- [39] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. G. van Sloun, and Y. C. Eldar, “KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics,” _IEEE Transactions on Signal Processing_ , vol. 70, pp. 1532–1547, 2022. 

- [40] N. Shlezinger, J. Whang, Y. C. Eldar, and A. G. Dimakis, “Model-Based Deep Learning,” _Proceedings of the IEEE_ , vol. 111, no. 5, pp. 465–499, 2023. 

- [41] N. Shlezinger, Y. C. Eldar, and S. P. Boyd, “Model-Based Deep Learning: On the Intersection of Deep Learning and Optimization,” _IEEE Access_ , vol. 10, pp. 115 384–115 398, 2022. 

- [42] N. Shlezinger and Y. C. Eldar, “Model-Based Deep Learning,” _Foundations and Trends® in Signal Processing_ , vol. 17, no. 4, pp. 291– 416, 2023. [Online]. Available: http://dx.doi.org/10.1561/2000000113 

- [43] A. L. Escoriza, G. Revach, N. Shlezinger, and R. J. G. van Sloun, “DataDriven Kalman-Based Velocity Estimation for Autonomous Racing,” in _IEEE International Conference on Autonomous Systems (ICAS)_ , 2021. 

- [44] I. Buchnik, D. Steger, G. Revach, R. J. van Sloun, T. Routtenberg, and N. Shlezinger, “Latent-KalmanNet: Learned Kalman Filtering for Tracking from High-Dimensional Signals,” _arXiv preprint arXiv:2304.07827_ , 2023. 

- [45] I. Klein, G. Revach, N. Shlezinger, J. E. Mehr, R. J. G. van Sloun, and Y. C. Eldar, “Uncertainty in Data-Driven Kalman Filtering for 

Partially Known State-Space Models,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2022, pp. 3194– 3198. 

- [46] G. Revach, N. Shlezinger, T. Locher, X. Ni, R. J. G. van Sloun, and Y. C. Eldar, “Unsupervised Learned Kalman Filtering,” in _European Signal Processing Conference (EUSIPCO)_ , 2022, pp. 1571–1575. 

- [47] V. Monga, Y. Li, and Y. C. Eldar, “Algorithm unrolling: Interpretable, efficient deep learning for signal and image processing,” _IEEE Signal Process. Mag._ , vol. 38, no. 2, pp. 18–44, 2021. 

- [48] N. Shlezinger and T. Routtenberg, “Discriminative and Generative Learning for the Linear Estimation of Random Signals [Lecture Notes],” _IEEE Signal Processing Magazine_ , vol. 40, no. 6, pp. 75–82, 2023. 

- [49] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with applications to tracking and navigation: Theory algorithms and software_ . John Wiley & Sons, 01 2004. 

- [50] S. S Arkk[¨] A,[¨] “Unscented Rauch–Tung–Striebel Smoother,” _IEEE Trans. Autom. Control_ , vol. 53, no. 3, pp. 845–849, 2008. 

- [51] N. J. Gordon, D. J. Salmond, and A. F. Smith, “Novel approach to nonlinear/non-Gaussian Bayesian state estimation,” in _IEE proceedings F (radar and signal processing)_ , vol. 140, no. 2. IET, 1993, pp. 107– 113. 

- [52] G. J. Bierman, _Factorization methods for discrete sequential estimation_ . Courier Corporation, 1977. 

- [53] ——, “Fixed interval smoothing with discrete measurements,” _International Journal of Control_ , vol. 18, no. 1, pp. 65–75, 1973. 

- [54] N. Samuel, T. Diskin, and A. Wiesel, “Learning to detect,” _IEEE Trans. Signal Process._ , vol. 67, no. 10, pp. 2554–2564, 2019. 

- [55] O. Lavi and N. Shlezinger, “Learn to rapidly and robustly optimize hybrid precoding,” _IEEE Trans. Commun._ , 2023, early access. 

- [56] N. Shlezinger, R. Fu, and Y. C. Eldar, “DeepSIC: Deep Soft Interference Cancellation for Multiuser MIMO Detection,” _IEEE Transactions on Wireless Communications_ , vol. 20, no. 2, pp. 1349–1362, 2021. 

- [57] G. Pillonetto, A. Aravkin, D. Gedon, L. Ljung, A. H. Ribeiro, and T. B. Sch¨on, “Deep networks for system identification: a Survey,” _arXiv preprint arXiv:2301.12832_ , 2023. 

- [58] H.-A. Loeliger, L. Bruderer, H. Malmberg, F. Wadehn, and N. Zalmai, “On sparsity by NUV-EM, Gaussian message passing, and Kalman smoothing,” in _Information Theory and Applications Workshop (ITA)_ . IEEE, 2016. 

- [59] F. Wadehn, L. Bruderer, J. Dauwels, V. Sahdeva, H. Yu, and H.-A. Loeliger, “Outlier-insensitive Kalman smoothing and marginal message passing,” in _European Signal Processing Conference (EUSIPCO)_ . IEEE, 2016, pp. 1242–1246. 

- [60] A. Agrawal, S. Barratt, and S. Boyd, “Learning convex optimization models,” _IEEE/CAA J. Autom. Sinica_ , vol. 8, no. 8, pp. 1355–1364, 2021. 

- [61] N. Amor, G. Rasool, and N. C. Bouaynaya, “Constrained state estimation-a review,” _arXiv preprint arXiv:1807.03463_ , 2018. 

- [62] B. Liang, T. Mitchell, and J. Sun, “NCVX: A General-Purpose Optimization Solver for Constrained Machine and Deep Learning,” in _OPT 2022: Optimization for Machine Learning (NeurIPS 2022 Workshop)_ , 2022. [Online]. Available: https://openreview.net/forum?id= rg7l9Vrt4-8 

- [63] T. Locher, G. Revach, N. Shlezinger, R. J. G. van Sloun, and R. Vullings, “Hierarchical Filtering With Online Learned Priors for ECG Denoising,” in _ICASSP 2023 - 2023 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2023, pp. 1–5. 

- [64] S. J. Godsill, A. Doucet, and M. West, “Monte Carlo smoothing for nonlinear time series,” _Journal of the american statistical association_ , vol. 99, no. 465, pp. 156–168, 2004. 

14 

- [65] Jerker Nordh, “pyParticleEst - Particle based methods in Python,” 2015. [Online]. Available: https://pyparticleest.readthedocs.io/en/latest/ index.html 

- [66] A. Geiger, P. Lenz, C. Stiller, and R. Urtasun, “Vision meets robotics: The KITTI dataset,” _The International Journal of Robotics Research_ , vol. 32, no. 11, pp. 1231–1237, 2013. 

- [67] W. Gilpin, “Chaos as an interpretable benchmark for forecasting and data-driven modelling,” in _Thirty-fifth Conference on Neural Information Processing Systems Datasets and Benchmarks Track (Round 2)_ , 2021. 

- [68] R. Kandepu, B. Foss, and L. Imsland, “Applying the unscented Kalman filter for nonlinear state estimation,” _Journal of Process Control_ , vol. 18, no. 7-8, pp. 753–768, 2008. 

**Guy Revach** is a researcher with a proven industry track record as an innovator and system engineer. He received his B.Sc. (cum laude) and M.Sc. degrees in 2008 and 2017, respectively, from the Andrew and Erna Viterbi Department of Electrical & Computer Engineering at the Technion – Israel Institute of Technology in Haifa. He completed his master’s thesis under the supervision of Prof. Nahum Shimkin on planning for cooperative multi-agents. Since 2019, he has been a Ph.D. candidate at the Institute for Signal and Information Processing (ISI) at ETH Z¨urich, Switzerland, supervised by Prof. Dr. Hans-Andrea Loeliger. His main research focus is on the intersection of machine learning with signal processing, specifically combining sound theoretical principles from classical signal processing with state-of-the-art machine learning algorithms for tracking and detection problems. Before joining ETH Z¨urich, he worked in the Israeli wireless communication industry for over 10 years, initially as a real-time embedded software engineer and later as a software manager. He was the main innovator behind state-of-the-art, software-defined radio (SDR) for wireless communication, which was game-changing and groundbreaking in terms of size, weight, and power. As a system engineer, he defined major aspects of SDR requirements and architecture, including hardware, software, network, cyber defense, signal processing, data analysis, and control algorithms. 

**Xiaoyong Ni** received a B.S. degree in Communication Engineering in 2020 from the University of Electronic Science and Technology of China (UESTC) in Chengdu, China. He received an M.S. degree from the Department of Electrical Engineering and Information Technology at ETH Z¨urich. His current research interests include signal processing, machine learning, and wireless communication. 

**==> picture [73 x 86] intentionally omitted <==**

**Nir Shlezinger** (M’17-SM’23) is an assistant professor in the School of Electrical and Computer Engineering at Ben-Gurion University, Israel. He received his B.Sc., M.Sc., and Ph.D. degrees in 2011, 2013, and 2017, respectively, from Ben-Gurion University, Israel, all in electrical and computer engineering. From 2017 to 2019, he was a postdoctoral researcher at the Technion, and from 2019 to 2020, he was a postdoctoral researcher at the Weizmann Institute of Science, where he was awarded the FGS Prize for outstanding research achievements. His research interests include communications, information theory, signal processing, and machine learning. 

**Ruud van Sloun** is an Associate Professor at the Department of Electrical Engineering at Eindhoven University of Technology in the Netherlands. He received both his M.Sc. and Ph.D. degrees (cum laude) in Electrical Engineering from Eindhoven University of Technology in 2014 and 2018, respectively. From 2019 to 2020, he served as a Visiting Professor with the Department of Mathematics and Computer Science at the Weizmann Institute of Science in Rehovot, Israel. From 2020 to 2023, he was a Kickstart AI Fellow at Philips Research. He has been honored with an ERC Starting Grant, an NWO VIDI Grant, an NWO Rubicon Grant, and a Google Faculty Research Award. His current research interests include closed-loop image formation, deep learning for signal processing and imaging, active signal acquisition, model-based deep learning, compressed sensing, ultrasound imaging, and probabilistic signal and image reconstruction. 

**Yonina C. Eldar** (S’98-M’02-SM’07-F’12) received the B.Sc. degree in Physics in 1995 and the B.Sc. degree in Electrical Engineering in 1996 both from Tel-Aviv University (TAU), Tel-Aviv, Israel, and the Ph.D. degree in Electrical Engineering and Computer Science in 2002 from the Massachusetts Institute of Technology (MIT), Cambridge. 

She is currently a Professor in the Department of Mathematics and Computer Science, Weizmann Institute of Science, Rehovot, Israel. She was previously a Professor in the Department of Electrical Engineering at the Technion, where she held the Edwards Chair in Engineering. She is also a Visiting Professor at MIT, a Visiting Scientist at the Broad Institute, and an Adjunct Professor at Duke University and was a Visiting Professor at Stanford. She is a member of the Israel Academy of Sciences and Humanities (elected 2017), an IEEE Fellow and a EURASIP Fellow. Her research interests are in the broad areas of statistical signal processing, sampling theory and compressed sensing, learning and optimization methods, and their applications to biology, medical imaging and optics. 

Dr. Eldar has received many awards for excellence in research and teaching, including the IEEE Signal Processing Society Technical Achievement Award (2013), the IEEE/AESS Fred Nathanson Memorial Radar Award (2014), and the IEEE Kiyo Tomiyasu Award (2016). She was a Horev Fellow of the Leaders in Science and Technology program at the Technion and an Alon Fellow. She received the Michael Bruno Memorial Award from the Rothschild Foundation, the Weizmann Prize for Exact Sciences, the Wolf Foundation Krill Prize for Excellence in Scientific Research, the Henry Taub Prize for Excellence in Research (twice), the Hershel Rich Innovation Award (three times), the Award for Women with Distinguished Contributions, the Andre and Bella Meyer Lectureship, the Career Development Chair at the Technion, the Muriel & David Jacknow Award for Excellence in Teaching, and the Technion’s Award for Excellence in Teaching (two times). She received several best paper awards and best demo awards together with her research students and colleagues including the SIAM outstanding Paper Prize, the UFFC Outstanding Paper Award, the Signal Processing Society Best Paper Award and the IET Circuits, Devices and Systems Premium Award, was selected as one of the 50 most influential women in Israel and in Asia, and is a highly cited researcher. 

She was a member of the Young Israel Academy of Science and Humanities and the Israel Committee for Higher Education. She is the Editor in Chief of Foundations and Trends in Signal Processing, a member of the IEEE Sensor Array and Multichannel Technical Committee and serves on several other IEEE committees. In the past, she was a Signal Processing Society Distinguished Lecturer, member of the IEEE Signal Processing Theory and Methods and Bio Imaging Signal Processing technical committees, and served as an associate editor for the IEEE Transactions On Signal Processing, the EURASIP Journal of Signal Processing, the SIAM Journal on Matrix Analysis and Applications, and the SIAM Journal on Imaging Sciences. She was Co-Chair and Technical Co-Chair of several international conferences and workshops. She is author of the book ”Sampling Theory: Beyond Bandlimited Systems” and co-author of five other books published by Cambridge University Press. 

15 

