---
title: "Bayesian KalmanNet: Quantifying Uncertainty in Deep Learning Augmented Kalman Filter"
arxiv: "2309.03058"
authors: [Yehonatan Dahan, Guy Revach, Jindrich Dunik, Nir Shlezinger]
year: 2023
source: paper
ingested: 2026-05-14
sha256: ccc482f263a5d4433d49a8e7d477d43ac791d1854bcde02c1c49c54d35331bb6
conversion: pymupdf4llm
---

1 

# Bayesian KalmanNet: Quantifying Uncertainty in Deep Learning Augmented Kalman Filter 

Yehonatan Dahan, Guy Revach, Jindrich Dunik, and Nir Shlezinger 

_**Abstract**_ **—Recent years have witnessed a growing interest in tracking algorithms that augment Kalman filters (KFs) with deep neural networks (DNNs). By transforming KFs into trainable deep learning models, one can learn from data to reliably track a latent state in complex and partially known dynamics. However, unlike classic KFs, conventional DNN-based systems do not naturally provide an uncertainty measure, such as error covariance, alongside their estimates, which is crucial in various applications that rely on KF-type tracking. This work bridges this gap by studying error covariance extraction in DNN-aided KFs. We begin by characterizing how uncertainty can be extracted from existing DNNaided algorithms and distinguishing between approaches by their ability to associate internal features with meaningful KF quantities, such as the Kalman gain and prior covariance. We then identify that uncertainty extraction from existing architectures necessitates additional domain knowledge not required for state estimation. Based on this insight, we propose** _**Bayesian KalmanNet**_ **, a novel DNN-aided KF that integrates Bayesian deep learning techniques with the recently proposed KalmanNet and transforms the KF into a** _**stochastic**_ **machine learning architecture. This architecture employs sampling techniques to predict error covariance reliably without requiring additional domain knowledge, while retaining KalmanNet’s ability to accurately track in partially known dynamics. Our numerical study demonstrates that Bayesian KalmanNet provides accurate and reliable tracking in various scenarios representing partially known dynamic systems.** 

## I. INTRODUCTION 

Tracking the latent state of a dynamic system is one of the most common tasks in signal processing [2]. Often, one is required not only to track the state, but also to provide a reliable assessment of the uncertainty in its estimate. For instance, navigation systems must not only provide the instantaneous position but also characterize its accuracy [3]. Moreover, uncertainty quantification in state estimation provides a measure of confidence in the predictions and enables informed, risk-aware decision-making, which is particularly critical in safety-sensitive domains. Uncertainty quantification is inherently provided by classic algorithms, such as the Kalman filter (KF) and the extended KF (EKF), that rely on the ability to faithfully describe the dynamics as a closed-form state space (SS) model. Such model-based algorithms track not only the state, but also compute the error covariance [4]. 

The emergence of deep learning gave rise to a growing interest in using deep neural networks (DNNs) to carry out tasks 

Parts of this work were presented at the IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP) 2024 as [1]. Y. Dahan and N. Shlezinger are with the School of ECE, Ben-Gurion University of the Negev, Israel (e-mail: yehonatd@post.bgu.ac.il, nirshl@bgu.ac.il). G. Revach is with the Institute for Signal and Information Processing, D-ITET, ETH Zürich, Switzerland (email: grevach@ethz.ch). J. Dunik is with the Faculty of Applied Science, University of West Bohemia, Czech Republic (email: dunikj@kky.zcu.cz). 

involving time sequences [5]. Various DNN architectures can learn from data to track dynamic systems without relying on full knowledge of an underlying SS model. These include generic recurrent neural networks (RNNs) [6, Ch. 10] and attention mechanisms [7], as well as RNN-type architectures inspired by SS models [8] and KF processing [9]. Such DNNs are trained end-to-end without using any statistical modeling. 

When one has partial knowledge of the underlying dynamics, it can be leveraged by hybrid model-based/data-driven designs [10]– [12]. Existing approaches to exploit partial domain knowledge can be roughly divided following the machine learning paradigms of _generative_ and _discriminative_ learning [13]. Generative approaches are _SS model-oriented_ , using DNNs to learn the missing aspects of the underlying SS model, i.e., for system identification, while adopting parameterizations varying from physics-based SS models [14], [15] to fully DNN-based ones [16]–[18]. The learned models are then used by classical algorithms, such as the EKF, thus typically preserving the limitations of these methods to, e.g., Gaussian temporally independent noises [19]. 

The discriminative strategy is _task-oriented_ , learning to directly output the state estimate, following the conventional usage of DNNs for classification and regression [6]. Existing designs vary in the knowledge they require on the underlying model. For settings with relatively high level of domain knowledge, e.g., when one can approximately characterize the dynamics as a linear Gaussian SS model, DNNs can enhance classic KFs by providing correction terms [20] or pre-processing [21] trained alongside the tracking algorithm. In scenarios with only partially known SS models, DNN augmented KFs were proposed, converting the KF into a machine learning algorithm [22]–[29]. Doing so bypasses the need to estimate the missing aspects of the SS model, learning to track via end-to-end training. In particular, the KalmanNet architecture [22] and its variants [23]–[26] substitute the Kalman gain (KG) computation of the EKF with a DNN. The resulting algorithm was shown to enable accurate tracking in partially known and complex dynamics, while facilitating combination with pre-processing [30] and downstream state postprocessing [31]–[33]. However, as such methods learn to estimate the state, they do not naturally provide the error covariance, for which there is rarely "ground-truth". 

Uncertainty extraction is typically quite challenging in generic deep learning [34]. Even for classification DNNs, that are designed to output a probability mass function, learned probabilities are often not faithful for uncertainty extraction [35], while in estimation tasks, generic DNNs do not quantify uncertainty. For DNN-aided KFs, several specific extensions were suggested to provide error covariance. For instance, the recurrent Kalman network (RKN) proposed in [9] was trained to output an error 

2 

estimate in addition to the state estimate, while [36] showed that when applying KalmanNet of [22] in linear SS models with full column rank observation matrix and Gaussian measurement noise, the error covariance can be extracted from internal features of the architecture. These specific studies motivate a unifying study on error covariance extraction in DNN-aided KFs. 

In this work we study discriminative DNN-aided tracking with uncertainty quantification for both linear and non-linear partially known SS models. We extensively examine the extraction of error covariance from existing architectures. We categorize DNNs that can learn to track in partially known SS model into model-based deep learning designs, where one can relate internal features to the KG or prior covariance, and black-box architectures, where only the output has an operational meaning. We show how the desired error covariance can be extracted in each setting: for black-box DNNs, error covariance estimation necessitates providing additional output neurons; for architectures whose internal features can be attributed to the prior covariance and the KG, we identify how and in which conditions can its internal features be mapped into error covariance prediction. We present two training methods which encourage such architectures to support error covariance estimation. 

Our analysis identifies that reliable extraction of the error covariance from existing DNN-aided algorithms is feasible only in some settings, e.g., when tracking fewer state variables than observed ones. Moreover, doing so requires additional knowledge of the SS model that is not required for state tracking. To overcome this, we propose a novel DNN-aided tracking algorithm that supports uncertainty quantification termed _Bayesian KalmanNet_ . Our proposed algorithm draws inspiration from Bayesian deep learning [37]–[39], deviating from conventional _frequentist_ learning to augment an EKF with a _stochastic DNN_ to compute the KG. Doing so enables tracking the state with the same level of partial SS modeling needed by conventional KalmanNet and its variants, while providing reliable uncertainty measures by sampling multiple DNN realizations. 

We compare Bayesian KalmanNet and our extension of existing DNN-aided KFs for uncertainty extraction in a qualitative and a quantitative manner. For the latter we consider both a synthetic and a physically compliant navigation setting. Our results show that Bayesian KalmanNet consistently provides reliable tracking of the state along with faithful error covariance prediction under different levels of accuracy in knowledge of the dynamics, and that incorporating domain knowledge in model-based deep learning designs systematically yields the most reliable estimate of the error covariance. 

The rest of this paper is organized as follows: Section II briefly reviews SS models and the EKF. Extensions of existing DNNaided KFs for uncertainty extraction are presented in Section III. Bayesian KalmanNet is derived in Section IV, Section V details our numerical study, and Section VI provides concluding remarks. 

Throughout this paper, we use boldface lowercase for vectors, e.g., **x** , and boldface uppercase letters, e.g., _**M**_ , for matrices. The _i_ th element of some vector **x** is denoted [ **x** ] _i_ . Similarly, [ _**M**_ ] _i,j_ is the ( _i, j_ )th element of a matrix _**M**_ . We use N and R for the sets of natural and real numbers, respectively. The operations ( _·_ ) _[⊤]_ , _∥· ∥_ , E _{·}_ , and Var _{·}_ are used for transpose, _ℓ_ 2 norm, stochastic expectation, and variance, respectively. 

## II. SYSTEM MODEL AND PRELIMINARIES 

In this section we review the system model and recall some preliminaries. We first present the SS model in Subsection II-A and discuss how it is used for model-based and DNN-based tracking in Subsections II-B-II-C, respectively. We formulate the problem of uncertainty-aware tracking in Subsection II-D, and review basics in Bayesian deep learning in Subsection II-E. 

## _A. SS Model_ 

We consider a dynamic system described as a non-linear SS model in discrete time. This model describes the relationship between a latent state vector **x** _t ∈_ R _[m]_ and observation vector **y** _t ∈_ R _[n]_ for each time instance _t ∈_ N. In a non-linear SS model, this relationship is generally represented as 

**==> picture [167 x 26] intentionally omitted <==**

In (1), **f** : R _[m] →_ R _[m]_ is the state evolution function; **h** : R _[m] →_ R _[n]_ is the observation function; and _**w** t,_ _**v** t_ are mutually and temporally independent zero-mean noises with covariances **Q** and **R** , respectively. 

While various tasks are associated with SS models, including, e.g., smoothing and imputation, we focus on _tracking_ . The tracking (filtering) task refers to estimating the state **x** _t_ from current and past observations _{_ **y** _τ }τ ≤t_ . Performance is measured via the mean squared error (MSE) between the estimated state and the true one. Namely, for a sequence of length _T_ , the time-averaged MSE of an estimate _{_ **x** ˆ _t}[T] t_ =1[is] 

**==> picture [194 x 30] intentionally omitted <==**

## _B. Model-Based Tracking_ 

The characterization of dynamic systems via the SS model (1) gives rise to various algorithms for tracking the state. Specifically, given a full and accurate description of the functions **f** ( _·_ ), **h** ( _·_ ), and characterization of the distribution of the state and measurement noises as being Gaussian with known covariances, a suitable tracking algorithm is the EKF [2, Ch. 10]. 

The EKF is comprised of _prediction_ and _measurement update_ steps. On each time step _t_ , it starts by propagating the first-order statistical moments of the state and observations via 

**==> picture [217 x 12] intentionally omitted <==**

Letting **F**[ˆ] _t_ and **H**[ˆ] _t_ be the Jacobians (partial derivatives) of **f** ( _·_ ) ˆ ˆ and **h** ( _·_ ), evaluated at **x** _t−_ 1 _|t−_ 1 and **x** _t|t−_ 1, respectively, the prior covariances are set to 

**==> picture [190 x 30] intentionally omitted <==**

The observations are fused with the predictions as 

**==> picture [195 x 12] intentionally omitted <==**

where **K** _t_ is the KG given by 

**==> picture [176 x 16] intentionally omitted <==**

3 

## The error covariance is then computed as 

**==> picture [182 x 14] intentionally omitted <==**

The EKF copes with the non-linearity of the SS model by linearizing the state evolution and measurement functions when propagating the second-order moments in (4). Alternative approaches employ different approximations for propagating these moments in non-linear SS models, including the unscented transform (utilized for that purpose by the unscented KF (UKF) [40]), as well as the cubature [41] and Gauss-Hermite deterministic or stochastic quadrature rules [42], [43]. While these model-based algorithms may not necessarily be MSE optimal (as opposed to linear Gaussian SS models), they ( _i_ ) inherently provide an estimate of both the state via (5) and the estimation uncertainty via (7); and ( _ii_ ) rely on accurate description of the dynamics as a known SS model as in (1). 

known SS model. However, we focus on setting where the SS is only partially known, and one must cope with the following requirements: 

- R1 The state evolution and observation models, **f** ( _·_ ) and **h** ( _·_ ), are _approximations of the true dynamics_ , that are possibly mismatched. 

- R2 The distribution of the noises _**v** t_ and _**w** t_ , which capture the inherent stochasticity in the dynamics, is unknown, and can be complex and non-Gaussian. 

- R3 As error covariance is a statistical quantity, it is unlikely to be provided in a dataset _D_ . Accordingly, we assume access to data that is labeled as in (8), namely, it is comprised of trajectories of observations and states but does not include the error covariance. 

These requirements motivate exploring data-driven approaches for tackling tasks associated with SS models, allowing to both recover the state and the error covariance. 

## _C. DNN-Aided Tracking_ 

DNNs, and particularly architectures suitable of time sequences such as RNNs, can learn to track in dynamics where the SS model is complex and unknown [5]. DNNs used for tracking take as input the current observation **y** _t_ at each time _t ∈_ N. The output of such a DNN-aided filter with trainable parameters _**θ**_ at time _t_ , denoted **x** ˆ _t_ ( **y** _t,_ _**θ**_ ) _∈_ R _[m]_ , is an estimate of the state **x** _t_ , as illustrated in Fig. 1(A). 

We focus on supervised settings, where learning is based on data comprised of pairs of state length _T_ state trajectories and observations, denoted 

**==> picture [181 x 16] intentionally omitted <==**

where the superscript ( _i_ ) denotes _i_ th data trajectory. In training, the DNN parameters _**θ**_ are tuned such that the state estimate best matches the data. Since performance is measured via the MSE (2), a suitable loss function is the empirical _ℓ_ 2 loss 

**==> picture [221 x 31] intentionally omitted <==**

While DNNs can be trained using (9) to track **x** _t_ without requiring characterization of the SS model in (1), they do not provide an estimate of the error covariance, e.g., as the EKF computes **Σ** _t|t_ in (7). Existing approaches for explainability in DNNs, typically involve additional data and conformal prediction tools for boosting verification within confidence regions [44], rather than providing instantaneous error covariance. 

## _D. Problem Formulation_ 

We consider the problem of _uncertainty-aware tracking_ , namely, the design of an algorithm that maps the observed **y** _t_ into **Σ** ˆ _t_ . Theestimatesformerofisbothevaluatedthe statevia **x** ˆthe _t_ andMSEits _estimation_ in (2), while _uncertainty_ the latter is measured via the accuracy of the estimated variances, i.e., 

**==> picture [211 x 32] intentionally omitted <==**

Model-based tracking algorithms estimate both the state and the error covariance when the dynamics are characterized by a 

## _E. Bayesian Deep Learning_ 

While the formulation of the SS model in Subsection II-A and the model-based tracking in Subsection II-B focuses on a Bayesian setting, from a deep learning perspective, the term Bayesian deep learning refers to a framework in which a stochastic modeling is employed on the DNN itself. Accordingly, we henceforth use the term _frequentist_ within the context of DNNs to refer to the standard deep learning approach in which the weights of a DNN are deterministic weights, whereas a _Bayesian_ DNN models its weights as random variables governed by a learned posterior distribution [37]. 

Specifically, Bayesian deep learning offers a framework to quantify uncertainty in DNN predictions. It treats the DNN parameters as random variables, and learns their posterior distribution given the data. This probabilistic approach provides a measure of uncertainty by sampling multiple realizations of the (random) DNN during inference [45]. 

In Bayesian deep learning, instead of learning a single set of parameters _**θ**_ , we aim to learn the posterior distribution _p_ ( _**θ** |D_ ) over the parameters given the data _D_ . In the considered context of estimating a state **x** _t_ from observations **y** _t_ , the state estimate **x** ˆ _t_ and the associated uncertainty can then be obtained by marginalizing over this posterior distribution, i.e., 

**==> picture [207 x 23] intentionally omitted <==**

To learn a stochastic DNN, one typically seeks to approximate a posterior distribution on the weights, i.e., _p_ ( _**θ** |D_ ), that is dictated by some parameters _**ϕ**_ . This can result in either an explicit formulation of the distribution, as in variational inference [46], or via alternative induced trainable stochasticity, as in Monte Carlo dropout [47]. Once dictated, the parameters of the DNN distribution, _**ϕ**_ , are trained using the evidence lower bound (ELBO) objective, which regularizes the expected loss with a term minimizing the Kullback-Leibler (KL) divergence between the induced distribution _q_ ( _**θ** |_ _**ϕ**_ ) and some pre-determined prior _p_ ( _**θ**_ ), i.e., 

ELBO _D_ ( _**ϕ**_ ) = E _q_ ( _**θ** |_ _**ϕ**_ ) [log _p_ ( _**θ** |D_ )] _−_ KL( _q_ ( _**θ** |_ _**ϕ**_ ) _|p_ ( _**θ**_ )) _._ (12) 

4 

Once trained, the stochastic DNN is applied via ensembling method. Particularly, during inference _J_ realizations, denoted _{_ _**θ** j}[J] j_ =1[,][are][drawn][in][an][i.i.d.][manner][from] _[q]_[(] _**[θ]**[|]_ _**[ϕ]**_[)][.][Then,] inference is carried out by applying these _J_ DNNs to the input, and combining their results. For instance, in our context of state tracking, the resulting estimate becomes 

**==> picture [242 x 32] intentionally omitted <==**

## III. ERROR COVARIANCE EXTRACTION IN FREQUENTIST DNN-AIDED TRACKING 

The first part of our study focuses on how one can extract error covariance from existing DNN-based tracking algorithms, based on conventional frequentist training (i.e., learning of deterministic DNNs). We divide existing architectures by their interpretable features that can be related to error covariance in Subsection III-A. Then, we propose dedicated training objectives to encourage these architectures to allow extraction of faithful uncertainty measures in Subsection III-B, respectively, and provide a discussion in Subsection III-C. 

_3) KG Features:_ The formulations in (15)-(16) rely on the ability to extract both the prior covariance and the KG as internal features. DNN-aided systems such as KalmanNet [22] learnprior covariance.to computeThere,the KGif **H** from[˜] _t_ ≜ data� **H** ˆ _⊤t_ without **[H]**[ˆ] _[t]_ � _−_ 1 exists,recoveringthen, theby combining (4b)-(6), the prior covariance can be recovered via 

**==> picture [247 x 14] intentionally omitted <==**

Using the recovered prior covariance in (17), the desired error covariance is obtained by either (15) or (16). This approach is illustrated in Fig. 1(D). 

**Remark 1.** _Converting the KG into the prior covariance in_ (17) _requires_ **H**[˜] _t to exist, i.e.,_ **H**[ˆ] _t has full column rank. Yet, even when some of the columns of_ **H**[ˆ] _t are zero or n < m, error covariance matrix elements with respect to the same state variables can still be recovered by considering the sub-matrices of_ **Σ** ˆ _t corresponding to these variables. For instance,_ **H**[ˆ] _t,in_ **Σ**[ˆ] _navigationt|t−_ 1 _, and scenarios with noisy position measurements, one can still extract the position error covariance while also tracking velocity._ 

## _B. Training to Predict the Error Covariance_ 

## _A. Error Covariance Indicative Features_ 

Different DNN-aided algorithms provide different features that can be used to extract the error covariance. We divide DNN-aided systems accordingly, considering black-box methods, where only the outputs are observed, as well as model-based deep learning algorithms following the EKF operation, where one can possibly relate internal features to the prior covariance and KG. 

_1) Output Features:_ In conventional black-box DNNs, one can only assign an interpretable meaning to the input and output of the system. In such cases, in order to estimate the error covariance, additional outputs are required (see Fig. 1(B)); these outputs should represent the estimated covariance denoted **Σ**[ˆ] _t_ . This can be achieved by having the DNN output (in addition to **x** ˆ _t_ ( **y** _t,_ _**θ**_ )), a vector **Σ**[ˆ] _t_ ( **y** _t,_ _**θ**_ ) _∈_ R _[m]_ +[,][as][done][in][the][RKN] method [9], setting the estimated error covariance to be 

**==> picture [188 x 13] intentionally omitted <==**

_2) KG and Prior Covariance Features:_ Several hybrid modelbased deep learning learn to track in partially known SS models by augmenting the EKF with DNNs. Some algorithms, such as Split-KalmanNet **K** ˆ _t_ ( **y** _t,_ _**θ**_ ), by treating(SKN)an[23internal], learnfeatureto computeas antheestimateKG, denotedof the prior covariance, denoted **Σ**[ˆ] _t|t−_ 1( **y** _t,_ _**θ**_ ). Following the EKF (4)–(7), these features can be combined to estimate the error covariance as illustrated in Fig. 1(C) via 

**==> picture [221 x 14] intentionally omitted <==**

The formulation in (15) is based on the update step of the EKF in (7), which implicitly assumes that the KG is the MSE optimal linear estimator. As there is no guarantee that this indeed holds for a learned DNN-aided KG, one can still estimate the error covariance via the Joseph form 

**==> picture [244 x 30] intentionally omitted <==**

The indicative features detailed in Subsection III-A allow DNN-aided systems to provide **Σ**[ˆ] _t_ ( **y** _t,_ _**θ**_ ), viewed as an estimate of the error covariance. However, training via (9), which solely **Σ** ˆ _t_ ( **y** _t,_ observes _**θ**_ ) to accuratelythe statematchestimate,the errordoes notcovariance.explicitlyAccordingly,encourage we consider two alternative loss measures that overcome the absence of a ground truth covariance, one that is based on evaluating the empirically averaged error variance, and one that utilizes a Gaussian prior of the estimated state. 

_1) Empirical Error Variance:_ A straight-forward approach to account for the error covariance in the loss is to introduce an additional term that compares **Σ**[ˆ] _t_ ( **y** _t,_ _**θ**_ ) to the instantaneous empirical estimate. Specifically, by defining the error vector 

**==> picture [190 x 12] intentionally omitted <==**

the loss includes an additive term that compares the predicted error with its empirical value obtained from (18). By defining the second moment loss over the whole dataset as: 

**==> picture [252 x 42] intentionally omitted <==**

The resulting empirical loss used for training is 

**==> picture [216 x 14] intentionally omitted <==**

The hyperparameter _β ∈_ [0 _,_ 1] in (20) is used to balance the trade-off between minimizing the tracking error and encouraging accurate prediction of the error covariance. In our numerical implementation detailed in Section V, _β_ is initialized with a small value at the beginning of training, so that the network initially focuses on learning to accurately track the state. As training progresses, _β_ is gradually increased, thereby placing more emphasis on the accuracy of the predicted uncertainty. Specifically, when setting _β_ = 0, then training with (20) coincides with training with the standard _ℓ_ 2 loss. 

5 

**==> picture [253 x 244] intentionally omitted <==**

Fig. 1: Considered tracking approaches: ( _A_ ) standard black-box DNN; ( _B_ ) DNN with error covariance output (e.g., [9]); ( _C_ ) DNN-aided KF, estimated posterior covariance and KG (e.g., [23]); and ( _D_ ) DNN-aided KF, learned KG (e.g., [22]). 

_2) Gaussian Prior:_ An alternative loss that accounts for error covariance without explicitly comparing predicted and empirical values leverages Gaussian priors. Particularly, one can train to both track and provide error covariance by imposing a Gaussian prior on the tracked state, as done in [9]. Under this assumption, a suitable loss is the log-likelihood of a Gaussian distribution with mean **x** ˆ _t_ ( **y** _t_[(] _[i]_[)] _[,]_ _**[ θ]**_[)][and][covariance] **[Σ]**[ˆ] _[t]_[(] **[y]** _t_[(] _[i]_[)] _[,]_ _**[ θ]**_[)][,][i.e.,] 

**==> picture [237 x 70] intentionally omitted <==**

We note that when the error covariance **Σ**[ˆ] _t_ is not estimated, but is instead assumed to be a scaled identity, then training with the loss in (21) is equivalent to training with the standard _ℓ_ 2 loss. 

## _C. Discussion_ 

We identified three different approaches to extract error covariance in discriminative DNN-aided tracking in non-linear SS models. These approaches vary based on the architecture employed and the level of interpretability it provides. It is emphasized though that for all considered approaches, one must still alter the learning procedure for the extracted features to be considered as uncertainty measures. To encourage learning to accurately predict the error, we propose two training objectives. This examination of error covariance extraction in DNN-aided KFs combines new approaches, while encompassing techniques used for specific schemes (e.g., (21) used by RKN [9]), and 

extending previous findings (e.g., (17) extends [36] to non-linear models). 

The main distinction between the approaches lies in their domain knowledge, i.e., which parts of the SS model are needed to track and provide error covariance, as summarized in Table I. Specifically, black-box DNNs do not require any model knowledge. Nonetheless, as empirically demonstrated in Section V, using black-box architectures with additional outputs regarded as the error covariance often leads to inaccurate tracking and unreliable error prediction, even when trained with a covariance-oriented loss as the ones proposed in Subsection III-B. Model-based deep architectures that learn the KG require only approximate knowledge of **f** ( _·_ ) and **h** ( _·_ ) to track [22], [23]. However, to extract covariance, **h** ( _·_ ) should be accurately known (as, e.g., (15) relies on **H**[ˆ] _t_ ), where **R** is also needed when the prior covariance is not tracked, as in KalmanNet. Accordingly, requirements R1 and R2 are not fully met by these methods. Moreover, the latter also requires the linearized observation model (i.e., **H**[˜] _t_ ) to have full column rank. When these requirements are met, it is empirically shown in Section V that, when training via the losses proposed in Subsection III-B, one can both accurately track the latent state and reliably predict its covariance from the internal features of the DNN-aided algorithm. 

## IV. BAYESIAN KALMANNET 

As detailed in the previous section, and empirically demonstrated in Section V, model-based deep learning architectures based on the KalmanNet algorithm can simultaneously provide accurate state tracking alongside reliable error prediction. Nonetheless, achieving the latter requires deviating from how these DNN-aided tracking algorithms are designed (e.g., in [22] and [23]) in the following aspects: 

- A1 Additional domain knowledge that is not required merely for state tracking is needed for covariance extraction (e.g., full characterization of the observations model (1b)), and the family of dynamic systems where one can extract uncertainty is limited (e.g., **H**[˜] _t_ has to be non-singular). 

- A2 The training objective should be altered to encourage reliable uncertainty extraction. 

In this section we propose a DNN-aided learning algorithm that preserves the ability of model-based deep learning algorithms such as KalmanNet to accurately track, in partially known SS models, while providing uncertainty measures without being subject to the limitations in A1, thus fully meeting requirements R1-R3. We build upon the observation in A2, namely, that error covariance extraction already necessitates altering the learning objective. Instead of just altering the learning objective, we modify the learning _paradigm_ , deviating from conventional frequentist learning into Bayesian learning of stochastic DNNs. Our proposed algorithm, coined _Bayesian KalmanNet_ , is detailed in Subsection IV-A, with its training procedure formulated in Subsection IV-B, while Subsection IV-C provides a discussion. 

## _A. Bayesian KalmanNet Tracking Algorithm_ 

As the name suggests, Bayesian KalmanNet is based on the KalmanNet algorithm of [22], while employing Bayesian DNNs. Accordingly, the algorithm uses a stochastic DNN to compute 

6 

the KG of the EKF. The usage of a Bayesian DNNs results in Monte Carlo sampling of _J_ different KalmanNet realizations during inference, that are used to recover both the state and its predicted error via ensemble averaging. 

**Architecture:** We employ a Bayesian DNN with parameters _**θ**_ whose distribution is parameterized by _**ϕ**_ . Each DNN realization ˆ ˆ maps the indicative features ∆ **x** _t−_ 1 ≜ **x** _t−_ 1 _−_ **x** _t−_ 2, ∆ **y** _t_ ≜ **y** _t −_ **y** _t|t−_ 1 and ∆˜ **y** _t_ ≜ **y** _t −_ **y** _t−_ 1 into the KG **K**[ˆ] _t_ ( **y** _t,_ _**θ**_ ). 

In our numerical study, we employ _Architecture 1_ of [22], comprised of gated recurrent unit (GRU) cells with input and output fully connected (FC) layers. Stochasticity is achieved by integrating dropout into the FC layers [47], with _**p**_ denoting the Bernoulli distribution parameter assigned with each neuron of these layers. The trainable parameters dictating the DNN distribution, denoted _**θ**_ , thus encompass a setting of the DNN parameters, denoted _**θ**_ 0, as well as the dropout neuron-wise probability _**p**_ , i.e., _**ϕ**_ = [ _**θ**_ 0 _,_ _**p**_ ]. In each realization, the DNN is applied with weights _**θ**_ 0 with the FC layers employing a dropout mask randomized with per-element distribution _**p**_ . 

**Uncertainty-Aware Tracking:** The proposed augmentation of the EKF with Bayesian DNNs allows to track as in KalmanNet, while leveraging ensembling to predict the estimation error. When tracking is launched, we sample _J_ i.i.d. realizations of the KG computations DNN from _q_ ( _**θ** |_ _**ϕ**_ ), denoted _{_ _**θ** j}[J] j_ =1[,][with] _J_ being a hyperparameter. The type of distribution represented by _q_ ( _**θ** |_ _**ϕ**_ ) is a design hyperparameter, as different families of distributions are considered in the Bayesian deep learning literature [46]. In our numerical study reported in Section V we employ Monte Carlo dropout [47], where each DNN realization is obtained from the initial fixed weight _**θ** j_ and a realization of the dropout masks sampled with multivariate Bernoulli distribution _**p**_ . However, the formulation of Bayesian KalmanNet is not restricted to Monte Carlo dropout, and can be combined with alternative distributions, e.g., Gaussian weights whose parameters are the first- and second-order moments. 

On each time instance _t_ , the first-order moments of the state and the observation are predicted based on the (possibly approximated) knowledge of **f** ( _·_ ) and **h** ( _·_ ) via (3). These estimated moments are used to form the input features to each of the _J_ DNN realizations, obtaining _J_ KGs, which are in turn used to produce _J_ separate state estimates, denoted _{_ **x** ˆ _[j] t[}][J] j_ =1[.] The mean and variance of these estimates provide the state estimate and its associated uncertainty, respectively, via 

**==> picture [200 x 32] intentionally omitted <==**

**==> picture [203 x 31] intentionally omitted <==**

From a Bayesian deep learning perspective, the matrix **Σ**[ˆ] _t_ in (22b) represents an empirical estimate of the _predictive uncertainty_ , namely, the second-order moment of the posterior predictive distribution over the state **x** _t_ given the observations and training data [48]. Specifically, each estimate **x** ˆ[(] _t[j]_[)] in (22a) corresponds to a sample from a different model instantiation, i.e., from the distribution _q_ ( _**θ** |_ _**ϕ**_ ) over the neural network weights. This ensemble of predictions approximates the posterior 

**==> picture [253 x 91] intentionally omitted <==**

Fig. 2: Bayesian KalmanNet - Architecture 

predictive distribution, and the sample covariance **Σ**[ˆ] _t_ estimates the total predictive uncertainty. While there is no general guarantee that individual estimators **x** ˆ[(] _t[j]_[)] are realizations of an unbiased estimator, the usage of its sample covariance for quantifying uncertainty is a standard and widely accepted approach in Bayesian deep learning. Accordingly, our proposed Bayesian KalmanNet uses **Σ**[ˆ] _t_ in (22b) as an estimate of the error covariance. The resulting operation is summarized as Algorithm 1 (in which, for brevity, we write the output of the _j_ th KG DNN realization at time _t_ as **K**[ˆ] _[j] t_[),][and][illustrated][in][Fig.][2][.] 

## **Algorithm 1:** Bayesian KalmanNet 

**Init :** DNN distribution _**ϕ**_ ; ensemble size _J_ **Input :** Initial state **x** 0 **1** Set **x** ˆ _[j]_ 0 _[≡]_ **[x]**[0][;] **2 for** _t_ = 1 _,_ 2 _, . . ._ **do 3** Receive new observation **y** _t_ ; i _._ i _._ d _._ **4** Sample _{_ _**θ** j} ∼ q_ ( _**θ** |_ _**ϕ**_ ); **5 for** _j_ = 1 _,_ 2 _, . . . , J_ **do 6** Predict **x** ˆ _[j] t|t−_ 1[and] **[y]**[ˆ] _t[j] |t−_ 1[from] **[x]**[ˆ] _[t][−]_[1][via][(][3][);] **7** Compute KG **K**[ˆ] _[j] t_[via][DNN] _**[θ]**[j]_[;] **8** Update **x** ˆ _[j] t_[=] **[x]**[ˆ] _[j] t|t−_ 1[+] **[K]**[ˆ] _[j] t_[(] **[y]** _[t][−]_ **[y]**[ˆ] _t[j] |t−_ 1[)] **9** Compute state estimate **x** ˆ _t_ via (22a); **10** Predict estimation error **Σ**[ˆ] _t_ via (22b); 

## _B. Training Bayesian KalmanNet_ 

The trainable parameters of Bayesian KalmanNet are the distribution parameters _**ϕ**_ . In principle, one can train Bayesian KalmanNet as a standard Bayesian regression DNN, evaluating it based on the augmented EKF output using the ELBO objective in (12). Nonetheless, as we are particularly interested in accurate error covariance recovery (which is not explicitly accounted for in the ELBO formulation), we next propose a dedicated training loss, which is also geared towards our usage of Monte Carlo dropout for inducing stochasticity. 

We follow the specialization of the ELBO objective to concrete Monte Carlo based DNNs proposed in [47], while altering the data matching term to incorporate explicit encouraging of reliable error variance recovery, as proposed in Subsection III-B for frequentist learning. To formulate this, let _L_ denote the number of layers in the DNN in which dropout is incorporated, and let _{λl}[L] l_ =1[denote][their][indices.][In][the][implementation][detailed][in] Subsection IV-A, these indices correspond to the FC layer of 

7 

TABLE I: Domain knowledge requirements comparison. 

|Method|Feature|**F**(_·_)|**H**(_·_)|**R**|**Q**|
|---|---|---|---|---|---|
|Output features|State|None|None|None|None|
|e.g., RKN|Error cov|None|None|None|None|
|**BaesianKalmanNet**|State|Partial|Partial|None|None|
|**y **|Error cov|Partial|Partial|None|None|
|Learn KG and Prior|State|Partial|Partial|None|None|
|e.g., SKN|Error cov|Partial|Full|None|None|
|Learn KG|State|Partial|Partial|None|None|
|e.g., KalmanNet|Error cov|Partial|Full|Full|None|
|Model-based|State|Full|Full|Full|Full|
|e.g., EKF|Error cov|Full|Full|Full|Full|



KalmanNet’s Architecture 1. We write the parameters of layer _λ_ of _**θ**_ as _**θ**[λ]_ and its dropout coefficient as _p_[(] _[λ]_[)] . Accordingly, the trainable parameters of Bayesian KalmanNet in such settings, denoted _**ϕ**_ , include the weights of each of the layers _**θ**_ 0, as well as the distribution parameters for the layers in which dropout is incorporated, denoted by _**p**_ = [ _p[λ]_[1] _, . . . , p[λ][L]_ ]. The proposed loss function, based on the labeled data in (8), is formulated as 

**==> picture [218 x 46] intentionally omitted <==**

where _L_[KL] _λl_[(] _**[ϕ]**_[)][computes][the][KL-based][regularization][term] of the layer _λl_ based on the learned multivariate Bernoulli distribution, with pre-determined prior in (12) being a maximal entropy Bernoulli distribution. The empirical loss term and the KL loss term in (23) are balanced through the non-negative hyperparameters _c_ 1 _, c_ 2, that appear in the layer-wise loss term, which is given by [47] 

**==> picture [213 x 24] intentionally omitted <==**

In (24), _n_[(] _[λ]_[)] is the number of input features to the _λ_ th layer; and _H_ ( _p_ ) is the entropy of a Bernoulli random variable with probability _p_ , defined as 

**==> picture [209 x 11] intentionally omitted <==**

This loss in (23) guides the tuning of _**ϕ**_ when training Bayesian KalmanNet to both extract an accurate state estimation and error covariance (by taking the expectation of our proposed empirical error variance as the data matching term), while encouraging randomness in the prior on the dropout probability _**p**_ . Having formulated the loss in (23), the training of Bayesian KalmanNet follows the conventional stochastic gradient based optimization of DNNs, only with a Bayesian loss term. Accordingly, the overall training complexity is comparable to that of frequentist KalmanNet [22]. 

## _C. Discussion_ 

Bayesian KalmanNet is designed to allow DNN-aided tracking in partially known SS models with error prediction. The extensions to existing frequentist KalmanNet-type methods proposed in Section III, which map the interpretable internal features into the error covariance, follow the mathematical steps used by the EKF in such computations, and thus necessitate 

additional domain knowledge not required by KalmanNet for state tracking. Bayesian KalmanNet bypasses the need for such excessive knowledge by adopting SS model-agnostic Bayesian deep learning techniques for error covariance extraction, combined with the SS model-aware KalmanNet for state tracking. This results in Bayesian KalmanNet requiring the same level of partial SS model knowledge as needed by KalmanNet and SKN for state estimation, while also providing error prediction, thus meeting R1-R3. As numerically reported in Section V, Bayesian KalmanNet achieves reliable state tracking and error prediction in various settings with different levels of domain knowledge. 

The uncertainty measure extracted by Bayesian KalmanNet encapsulates the overall estimation error covariance. This uncertainty measure inherently comprises two components [48]: _aleatoric uncertainty_ , resulting from the stochasticity of the system (e.g., process and measurement noises); and _epistemic uncertainty_ , arising due to limited or mismatched knowledge within the estimator, particularly when the underlying dynamics are only partially known or when trained with a limited dataset. Classical model-based methods, such as the EKF, can reliably quantify aleatoric uncertainty when operating with an accurate SS model and well-characterized noise statistics, they underperform when the model is misspecified. Conversely, existing frequentist DNN-aided KFs struggle to provide any form of uncertainty quantification, even with abundant training data. The approaches proposed for extending frequentist DNN-aided KFs introduced in Section III are geared towards quantifying aleatoric uncertainty, aiming to recreate the covariance computations of the modelbased EKF without explicitly propagating second-order moments. Accordingly, the resulting characterization, which does not encompass epistemic uncertainty, is expected to be sensitive to the amount of training data. Bayesian KalmanNet overcomes these limitations by providing uncertainty estimates that reflect both sources of uncertainty, thereby yielding more reliable and calibrated error covariances under data scarcity and model mismatch. This dual capability makes Bayesian KalmanNet particularly suitable for practical scenarios where both the dynamics and noise statistics are only partially known. 

The incorporation of Bayesian deep learning techniques can be viewed as trading computational complexity for uncertainty measures. This induced complexity also translates into additional inference latency, as reported in Section V. The hyperparameter _J_ plays a key role in affecting both the performance, as increasing _J_ enhances the approximation of the posterior predictive distribution, while also increasing complexity. Specifically the application of Bayesian KalmanNet can be viewed as _J_ realizations of KalmanNet with different parameterizations, thus increasing the computational burden by a factor of _J_ at each time instance. The induced latency of Bayesian KalmanNet can be notably reduced using parallel computing, as each of the _J_ realizations can be applied simultaneously. We also note that this operation of Bayesian KalmanNet bears similarity to alternative tracking algorithm that implement multiple Kalman-type filters in parallel, e.g., [49], though the conventional approach uses a different SS model with deterministic parameters for each filter, while Bayesian KalmanNet uses multiple stochastic realizations of the filter obtained for the same (partially known) SS model, following the task-oriented discriminative learning paradigm [13]. 

8 

Our design of Bayesian KalmanNet gives rise to numerous possible avenues for extension. Our design, as well as that considered for frequentist KalmanNet [22], assumes that the SS model in (1) does not change. Thus, our approach is not naturally transferable to time-varying dynamics, for which adaptive KFs, often based on variational inference [50]–[52], are required. Previous works that considered the KalmanNet methodology in time-varying dynamics, which proposed adaptation based on hypernetworks [53] and unsupervised learning [54], focused on block-wise variations in the SS model. The extension of the KalmanNet methodology to time-varying dynamics is the area of ongoing research, which, inspired by recent advances in continual Bayesian learning [55], [56], can potentially benefit from the incorporation of Bayesian deep learning. Moreover, while our formulation accommodates a generic Bayesian DNN, our implementation detailed in Section V is based on an architecture proposed in [22], and training objective focus on the usage of Monte Carlo dropout. Our formulation differs than standard Bayesian DNNs as all realizations are based on the same prior. One can possibly consider alternative Bayesian parameterizations, based on, e.g., variational inference with explicit priors [46], as well as its incorporation with different KalmanNet-type architectures, e.g., [23]–[26]. Moreover, the combination of Bayesian deep learning and KalmanNet indicates that such methodologies can also be employed in alternative forms of model-based deep learning [12]. We leave these extensions for future work. 

## V. NUMERICAL EVALUATION 

In this section we numerically compare the above techniques to extract error covariance in DNN-aided KFs. We first detail the considered algorithms implemented and our utilized performance measures in Subsection V-A. Then, we detail a set of experiments dedicated to evaluating state and covariance estimation in different SS models in Subsections V-B-V-D. We conclude by comparing inference time in Subsection V-E. 

## _A. Experimental Setup_ 

- _1) Tracking Algorithms:_ We henceforth compare the following 

- tracking algorithms[1] : 

   - **RKN** , using the code provided in [9], representing DNNs with dedicated output features. 

   - **SKN** , using the code provided in [23], representing modelbased deep learning with learned KG and prior covariance. 

   - KalmanNet, using both Architecture 1 ( **KNetV1** ) and Architecture 2 ( **KNetV2** ) of [22]. 

   - Bayesian KalmanNet (termed **BKN** for brevity), based on KNetV1 with dropout incorporated into its FC layers, taking _J_ = 20 realizations. 

with the same data comprising of _|D|_ = 300 trajectories. Training commences with the DNN weights initialized via standard Xavier initialization, and the Monte Carlo dropout parameters of BKN randomized uniformly in [0 _._ 5 _,_ 0 _._ 8], following the common practice in Bayesian DNNs [47]. The remaining learning hyperparameters were selected based on standard cross validation. 

_2) Data generation:_ Unless stated otherwise, throughout the following experimental study, we set the observation noise covariance **R** to take the form _r_[2] **I** , with 1 _/r_[2] = _n/_ Tr( **R** ) denoting the signal-to-noise ratio (SNR). The ratio between the state evolution and the observation noise variances is fixed to 0 _._ 01, such that changes in the SNR affect both the state evolution and the observation noises. All DNN-aided algorithms were trained on a range of SNRs rather than for each SNR separately, to emphasize their robustness and ability to operate across different noise levels. To perform statistical tests and evaluation, Monte-Carlo simulation was performed, with _N_ = 100 trajectories per scenario. 

_3) Performance Measures:_ The tracking algorithms are evaluated in terms of the following performance measures: ( _i_ ) The empirical estimation error, i.e., state estimate MSE (2); and ( _ii_ ) The predicted error covariance, namely, Tr( **Σ**[ˆ] _t_ ). Performance is thus measured not only in state estimation error, but also on the ability to predict this error from the recovered covariance. 

To assess the credibility of the estimators, we also evaluate the average normalized estimation error squared (ANEES) measure [3], [57]–[59]. This measure combines state estimation and error covariance prediction in a single measure. For an estimator outputting state estimates and covariances _{_ **x** ˆ _t,_ **Σ**[ˆ] _t}[T] t_ =1[,] the ANEES is given by 

**==> picture [237 x 30] intentionally omitted <==**

where the stochastic expectation is computed by empirical averaging over the test data. The closer to the ANEES is to being 1, the more credible the estimator, with values surpassing 1 representing overconfidence, and lower values corresponding to conservative predictions. 

Additional metrics used to evaluate the different methods at a given time instance _t_ over a test set _D_ are the average predicted error covariance (APEC) and the empirical error covariance (EEC). The APEC is given by 

**==> picture [183 x 31] intentionally omitted <==**

while the EEC is given by 

- The fully model-based **EKF** . 

Unless stated otherwise, we use (15) to convert the KG and prior covariance into error covariance. We train RKN and SKN with (21); KalmanNet is trained with (9); while Bayesian KalmanNet is trained using (23). All data-driven algorithms are trained 

> 1The source code and all hyperparameters used can be found online at https://github.com/yonatandn/Uncertainty-extraction-in-Model-Based-DL 

**==> picture [218 x 31] intentionally omitted <==**

We say that the algorithm is a better uncertainty estimator as its uncertainty prediction (APEC along time) is closer to the true error covariance (EEC along time). 

9 

_4) Mismatch Setup:_ We consider the following forms of mismatches in the model knowledge: 

- _Process noise mismatch_ : a dataset generated with a process noise covariance matrix **Q** data = 100 _·_ **Q** model where **Q** model is the process noise covariance matrix known to the algorithm. 

- _Measurement noise mismatch_ : a dataset generated with a measurement noise covariance matrix **R** data = 100 _·_ **R** model where **R** model is the measurement noise covariance matrix known to the algorithm. 

- _Model mismatch_ : in the constant velocity (CV) SS, data was generated using a constant acceleration (CA) model, while testing the different methods with a CV SS. 

Our motivation for employing the considered mismatches, imposed on all algorithms that require knowledge of the SS model, is to evaluate sensitivity to incorrect modeling assumptions. Specifically, the noise mismatches (which affect just the EKF) serve to highlight the behavior of uncertainty quantification under severe mismatches, while the last model mismatch represents a realistic setup in which a target follows a more complicated state evolution model compared to the one used by the tracking algorithm. 

## _B. Linear Canonical SS Model_ 

We first simulate a synthetic two-dimensional linear SS model with Gaussian process and measurement noises governed by a controllable canonical state transition matrix, defined in [22, Sec. IV.B]. Here, the state transition matrix **F** and measurement matrix **H** are 

**==> picture [147 x 25] intentionally omitted <==**

where _σ_ max is the largest singular value of **F**[ˆ] _t_ ensuring stability. The considered performance measures versus the observations noise variance _r_[2] are reported in Fig. 3b. When examining the MSE in Fig. 3a, we can see that all the model aware methods achieved a smaller estimation error compared to the RKN which is model agnostic. In Fig. 3b we observe that (frequentist) KalmanNet provides the most accurate error covariance estimates compared to the other methods when introducing a mismatch in the process noise covariance **Q** . This is evidenced by the lowest absolute value of log(ANEES), suggesting that KalmanNet closely matches the true uncertainty in the system. This stems from the fact that in this relatively simple setup, one can translate the KG into an error covariance estimate as detailed in Section III. The SKN produces either too conservative or too confident predictions, meaning it brutally overestimates or underestimates the uncertainty, leading to larger error covariances. Bayesian KalmanNet demonstrates minor overconfidence in its predictions, underestimating the uncertainty. Both RKN and EKF exhibit significant overconfidence, with their predictions being excessively optimistic. This means their error covariances are underestimated and are not aligned with the true uncertainties. 

When introducing a mismatch in the measurement noise covariance **R** and evaluating the filter performance using the ANEES metric, as shown in Fig. 3d, it is evident that Bayesian KalmanNet achieves the most favorable results. Bayesian 

KalmanNet provides a credible error covariance estimation, meaning it maintained reliability. The EKF and KalmanNet produce comparable results, indicating that both methods offer similar levels of credibility in their error covariance predictions. In contrast, the RKN struggles to provide credible estimates, leading to unreliable uncertainty predictions. Comparing Figs. 3b and 3d shows that frequentist methods can also achieve strong performance, particularly in scenarios where uncertainty can be reliably estimated. However, in cases where uncertainty estimation is inherently more challenging, e.g., where inaccuracies directly impact the observed data—frequentist methods relying on internal features may struggle. In such settings, Bayesian KalmanNet provides more robust and calibrated uncertainty estimates by explicitly modeling parameter uncertainty through ensemble predictions. Overall, both variants exhibit stable and credible uncertainty estimates across different SNR levels, and the observed differences are relatively minor. 

Turning to the MSE results, illustrated in Fig. 3c, it is clear that the SKN, which is particularly designed for settings with imbalances between state evolution and measurement noises [23], outperforms other methods by achieving the lowest estimation error across various measurement noise covariance levels. This indicates that SKN consistently provided the most accurate state estimates, regardless of the noise magnitude. The RKN, however, only performed well at higher _r_[2] values, suggesting that it struggles in high SNRs with limited data sets, where accurate uncertainty modeling is more critical. All KalmanNet based methods, including Bayesian KalmanNet, outperform the EKF. Comparing the MSE results in Fig. 3c and the uncertainty results in Fig. 3d indicates on the trade-off emerging by the need to balance both objectives during training. In such multiobjective settings, improving one aspect-—e.g., achieving lower MSE-—may slightly compromise the precision of uncertainty estimates, sometimes somewhat compromise the precision of uncertainty estimates, and in some cases hardly affect the latter. 

The results in this SS model emphasize that for a variety of SNRs, even for a linear state transition and measurement functions, both the frequentist and the Bayesian methods combining model knowledge and deep learning achieve better results than both model agnostic deep learning and model based without deep learning. 

## _C. Pendulum SS Model_ 

Next, we consider a pendulum with mass _m_ = 1 and length _ℓ_ = 1. The pendulum exhibits nonlinear behavior due to the gravitational force _g_ acting on it. We describe the system using the angle _θ_ and angular velocity _θ_[˙] as the state variables, sampled at interval of ∆ _t_ = 0 _._ 01. Let the state vector **x** _t_ be defined as: 

**==> picture [47 x 25] intentionally omitted <==**

The dynamics of the pendulum can be modeled using Newton’s second law. For a pendulum subject to gravity, we can express this second-order equation as a system of first-order differential equations such that the discrete nonlinear state transition function **F** ( **x** _t_ ) can be written as: 

**==> picture [119 x 26] intentionally omitted <==**

10 

**==> picture [516 x 186] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 4 Overconfident<br>EKF Optimal<br>-5 KNetV1 EKF<br>BKN 3 KNetV1<br>-10 KNetV2 BKN<br>SKN 2 KNetV2<br>-15 RKN SKN<br>RKN<br>-20<br>1<br>-25<br>0<br>-30<br>-35 -1<br>-40<br>-2 Conservative<br>-45<br>-50 -3<br>-10 -5 0 5 10 15 20 25 30 -10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB] r [-2]  [dB]<br>MSE [dB]<br>log (ANEES)<br>**----- End of picture text -----**<br>


- (a) MSE for mismatched **Q** , all the model aware methods managed to track the state with a very similar MSE. The model agnostic RKN has failed to maintain the same performance. 

(b) ANEES for mismatched **Q** , Both the frequentist and Bayesian KNet have managed to mainatain a stable error covariance (uncertainty) estimation throughout the different SNRs. 

**==> picture [507 x 187] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 5 Overconfident<br>EKF Optimal<br>0 KNetV1BKN 4 EKFKNetV1<br>KNetV2 BKN<br>SKN 3 KNetV2<br>RKN SKN<br>-10 RKN<br>2<br>-20<br>1<br>-30<br>0<br>-40<br>-1<br>Conservative<br>-50 -2<br>-10 -5 0 5 10 15 20 25 30 -10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB] r [-2]  [dB]<br>MSE [dB]<br>log (ANEES)<br>**----- End of picture text -----**<br>


(c) MSE for mismatched **R** , the SKN performance was superior while (d) ANEES for mismatched **R** , the Bayesian KalmanNet consistently both the frequentist and Bayesian model-based deep learning methods provided the most accurate and stable uncertainty estimates, whereas managed to track the state with a very similar MSE. the model agnostic RKN’s prediction was the mostly inaccurate. 

Fig. 3: Canonical linear SS model - mismatched process noise **Q** and measurement noise **R** covariances 

Assuming that **x** _t_ at each time step is small enough to allow a local linearization, the Jacobian matrix of **F** ( **x** _t_ ) is 

**==> picture [119 x 25] intentionally omitted <==**

We assume the pendulum’s position in Cartesian coordinates, such that the observation matrix **h** ( **x** _t_ ) for converting state to measurement is given by: 

**==> picture [87 x 24] intentionally omitted <==**

Here, **H**[ˆ] ( **x** _t_ ) is non-full columns rank. This means that the frequentist model-based methods are unable to extract an error covariance matrix as explained in Remark 1, and thus are not tested throughout this scenario. 

The achieved performance measures are reported in Fig. 4. When examining the MSE in Fig. 4a, it can be seen that the 

EKF fails to produce an accurate state estimation compared to all other methods, especially at higher SNRs. The ANEES results in Fig. 4b highlight that beside the SKN, all algorithms have a stable credibility with a minor overconfidence throughout different SNRs, whereas the SKN shows some instability in its credibility. The RKN provides the most accurate error covariance estimates compared to the other methods when introducing a mismatch in the process noise covariance **Q** . 

Under mismatched **R** , the MSE results in Fig. 4c show that in terms of estimation error the EKF performs the worst, as its MSE remains significantly higher than the other methods across the entire range of 1 _/r_[2] . This indicates that the EKF struggles to maintain accurate state estimates, particularly in the presence of higher measurement noise. Its performance gap widens considerably as the noise mismatch increases, showing that the EKF is less robust under such conditions. The DNNaided Bayesian KalmanNet, SKN, and RKN all perform much 

11 

TABLE II: Performance metrics at SNR 1 _/r_[2] = 10 [dB] with mismatched **R** , Pendulum non-linear SS model. 

|**Metric**|**EKF**|**SKN**|**RKN**|**BKN**|
|---|---|---|---|---|
|MSE [dB]|23.8933|-7.5536|-7.7836|-9.2741|
|log(ANEES)|4.1182|1.2452|0.2234|-0.0834|



better, achieving comparable results for most of the range. 

Fig. 4d shows that the SKN is the most overconfident filter only at higher noise levels, though it improves compared to the other methods as the noise level is lower. The EKF, demonstrates a large overconfidence, throughout all noise levels. In contrast, Bayesian KalmanNet and the RKN consistently yield a very accurate (credible) error covariance estimates as it stays closest to the optimal log(ANEES) = 0 for much of the range. To highlight the dual gains of Bayesian KalmanNet in accuracy and uncertainty, we also include a tabular comparison of the MSE and ANEES of the considered algorithms for the setting with mismatched **R** for fixed SNR of 1 _/r_[2] = 10 [dB]. The results, reported in Table II, clearly indicate on the ability of Bayesian KalmanNet to simultaneously provide accurate tracking alongside faithful uncertainty estimation, notably outperforming both frequentist DNN-based methods as well as the model-based EKF. 

## _D. Navigation SS Model_ 

Our third scenario focuses on a more realistic SS as we track the location and velocity of a vehicle moving in a 2D plane. We assume its movement is in a CV manner. The system is modeled using the vehicle’s position and velocity in the _x_ - and _y_ -directions as state variables. 

Let the state vector **x** _t_ and state transition matrix **F** be defined as: 

**==> picture [159 x 49] intentionally omitted <==**

where: 

- _xt_ and _yt_ represent the position of the vehicle in the _x_ - and _y_ -directions. 

- ˙ ˙ 

- _• xt_ and _yt_ represent the velocity of the vehicle in the _x_ - and _y_ -directions. 

Assume we can observe the position of the vehicle in the _x_ - and _y_ -directions, but not its velocity. The observation matrix **H** maps the state vector to the measurements: 

**==> picture [83 x 24] intentionally omitted <==**

We generate a set of 100 trajectories, with 5 used for validation and 10 reserved for testing. The sampling interval parameter ∆ _t_ is normalized to unity. 

The results for this setting are reported in Fig. 5. When examining the MSE in Fig. 5a, it can be seen that both the EKF and the RKN not only fail to estimate the uncertainty, but also fail to produce an accurate state estimation compared to all other methods, especially at higher SNRs. The results in Fig. 5b shows that all methods resulted in an overconfident covariance prediction, although the both the frequentist and Bayesian model 

based deep learning methods manage to have a much better credibility with a more accurate uncertainty predictions. 

In this section, we describe a single run of our constant velocity model under specific conditions. The true process noise covariance **Q** data was set such that the given process noise covariance **Q** model is underestimated by a factor of 100, i.e., **Q** data = 100 _·_ **Q** model. The noise covariance **R** was set to 10, which is 100 _×_ greater than **Q** model. This setup aims to analyze the system’s behavior under significant model-process mismatch. Fig. 6 shows the predicted position x track of each method compared to the ground truth trajectory. This figure is a qualitative measure that shows the ability to track the trajectory. As can be seen, the model agnostic RKN failed to track the state along time, whereas all the model aware methods provide a reasonable state estimation. 

To compare the different methods’ performance in prediction the uncertainty, Figs. 7 and 8 show x-axis position APEC compared to its EEC. These metrics are achieved by performing a simulation with _N_ = 100 trajectories, and using (27) and (28) to calculate APEC and EEC respectively. As can be seen, the model-based deep learning methods achieve better results than the model-based EKF and the model-agnostic RKN. 

The results under model mismatch due to sampling mismatch are reported in Fig. 9. Fig. 9b shows clearly that Bayesian KalmanNet has supplied the most reliable error covariance estimation when given a mismatched model. The model based deep learning frequentist methods also results in a reliable error covariance prediction, whereas the EKF fails to extract the uncertainty, outperforming only the model agnostic RKN. The results for the state estimation when given a mismatched model are very similar to the results in the error covariance estimation. Fig. 9a shows that the Bayesian KalmanNet has supplied the most reliable state estimation, the frequentist methods resulted in a reasonable state prediction, whereas the EKF and RKN failed to estimate an accurate state estimation. 

## _E. Inference Time Comparison_ 

The results presented so far evaluate the considered methods in terms of their accuracy and uncertainty estimation performance. As Bayesian deep learning induces excessive latency in inference compared with frequentist models due to its inherent ensembling, we next evaluate inference time. The results in Table III report the inference latency of the different filtering methods across both a linear (canonical) and non-linear (pendulum) scenario. The platform on which all algorithms were tested and runtimes were computed is an Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz 2.30 GHz. For Bayesian KalmanNet (BKN), The latency values reflect the total execution time required to process all _J_ realizations sequentially, i.e., the actual inference latency experienced in a serial execution setting. In the canonical SS model, the EKF demonstrates the fastest performance of all model aware methods, with the lowest average inference time of 5 _._ 279 milliseconds. The SKN, KNet V1, and V2 methods exhibit comparable speeds, with marginal differences around 5 _._ 3 milliseconds. These results suggest that these methods maintain efficient performance close to the traditional EKF, making them suitable for real-time applications where speed is critical. 

12 

**==> picture [253 x 185] intentionally omitted <==**

**----- Start of picture text -----**<br>
15<br>EKF<br>10 BKN<br>SKN<br>5 RKN<br>0<br>-5<br>-10<br>-15<br>-20<br>-25<br>-30<br>-35<br>-10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB]<br>MSE [dB]<br>**----- End of picture text -----**<br>


(a) MSE for mismatched **Q** , All the deep learning methods showed stable results but struggled slightly at moderate SNRs. The EKF, however, failed to maintain competitive performance. 

**==> picture [253 x 187] intentionally omitted <==**

**----- Start of picture text -----**<br>
9<br>Overconfident<br>Optimal<br>8 EKF<br>BKN<br>7 SKN<br>RKN<br>6<br>5<br>4<br>3<br>2<br>1<br>0<br>Conservative<br>-1<br>-10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB]<br>log (ANEES)<br>**----- End of picture text -----**<br>


(b) ANEES for mismatched **Q** , the different methods provided very similar results, beside the instability of the SKN’s credibility for some SNRs. 

**==> picture [507 x 187] intentionally omitted <==**

**----- Start of picture text -----**<br>
30 7<br>Overconfident<br>EKF Optimal<br>BKN 6 EKF<br>20 SKN BKN<br>RKN SKN<br>5 RKN<br>10<br>4<br>0 3<br>2<br>-10<br>1<br>-20<br>0<br>Conservative<br>-30 -1<br>-10 -5 0 5 10 15 20 25 30 -10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB] r [-2]  [dB]<br>MSE [dB]<br>log (ANEES)<br>**----- End of picture text -----**<br>


(c) MSE for mismatched **R** , All the deep learning methods showed (d) ANEES for mismatched **R** , the model based deep learning methods stable results with a significantly better performance than the EKF in consistently provide the most accurate and stable uncertainty estimates the sense of the estimated state accuracy. compared to the model-free and model dependent methods. 

Fig. 4: Pendulum non-linear SS model - mismatched process noise **Q** and measurement noise **R** covariances 

The RKN achieves an average inference time of just 0 _._ 194 milliseconds. This presumably stems from the efficiency of RNN software implementations in PyTorch. Bayesian KalmanNet requires substantially more time, with an inference time of 104 _._ 88 milliseconds for the canonical model. This reflects the computational cost associated with more advanced uncertainty quantification and Bayesian learning techniques. While these methods enhance credibility and robustness, they introduce a significant computational burden, making them less suited for time-sensitive tasks. 

In the pendulum scenario, the inference times increase across all methods due to the model’s non-linearity. The EKF inference time rises to 13 _._ 842 milliseconds, which is still faster than Bayesian KalmanNet at 112 _._ 461 milliseconds. Notably, the KalmanNet versions do not have available inference times for the pendulum case, as the measurement matrix **H** in that SS is not full column rank, preventing the calculation of the error 

covariance. The SKN retains its relatively low inference time of 13 _._ 906 milliseconds, maintaining its appeal for applications requiring both computational efficiency and accuracy. 

Overall, while the Bayesian KalmanNet offers substantial benefits in terms of credibility and robustness, these come at the cost of longer inference times. For real-time applications, a parallelization could be used to solve this issue, as the different inferences in the Bayesian KalmanNet are independent and thus could be computed in parallel. While there is no consistent algorithm that achieves the best performance in both accuracy and uncertainty throughout the various settings considered in our numerical study, it is clearly demonstrated that incorporating domain knowledge notably facilitates uncertainty extraction. Moreover, it is systematically shown that Bayesian KalmanNet enables DNN-aided KFs to both extract the state and predict the error accurately in nonlinear, possibly mismatched SS models, and that its reliability is maintained across all the considered 

13 

**==> picture [507 x 188] intentionally omitted <==**

**----- Start of picture text -----**<br>
8<br>50<br>EKF Overconfident Optimal<br>40 KNetV1 7 EKFKNetV1<br>BKN<br>BKN<br>KNetV2<br>30 SKN 6 KNetV2<br>RKN SKN<br>20 5 RKN<br>10 4<br>0 3<br>-10 2<br>-20 1<br>-30 0<br>-10 -5 0 5 10 15 20 25 30 -10 -5 0 5 10 15 20 25 30<br>r [-2]  [dB] r [-2]  [dB]<br>MSE [dB]<br>log (ANEES)<br>**----- End of picture text -----**<br>


- (a) MSE for mismatched **Q** , the model based deep learning methods (b) ANEES for mismatched **Q** , Both the frequentist and Bayesian consistently provide the most accurate state estimates compared to the KalmanNet manage to maintain an accurate error covariance estimation model-free and model dependent methods. throughout the different SNRs. 

Fig. 5: CV SS model - mismatched process noise **Q** 

**==> picture [253 x 110] intentionally omitted <==**

Fig. 6: x-axis estimate in a single run, CV SS model. 

TABLE III: Average Inference Time [msec]. 

|**Type**|**Model**|**EKF**|**KNet V1**|**KNet V2**|**SKN**|**RKN**|**BKN**|
|---|---|---|---|---|---|---|---|
|Linear|Canonical|5.279|5.303|5.279|5.315|0.194|104.88|
|Non-Linear|Pendulum|13.842|N/A|N/A|13.906|0.198|112.461|



settings. 

## VI. CONCLUSIONS 

In this work, we studied uncertainty extraction in DNN-aided KFs. We identified three techniques based on different indicative features, and proposed two learning schemes that encourage learning to predict the error. Moreover, we have suggested a new method termed Bayesian KalmanNet incorporating Bayesian deep learning to a DNN augmented KF. Our numerical results show that incorporating domain knowledge notably facilitates uncertainty extraction, and that Bayesian KalmanNet allows DNN-aided KFs to both extract the state and predict the error accurately in non-linear possibly mismatched SS models. 

## REFERENCES 

- [1] Y. Dahan, G. Revach, J. Dunik, and N. Shlezinger, “Uncertainty quantification in deep learning based Kalman filters,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2024, pp. 13 121–13 125. 

- [2] J. Durbin and S. J. Koopman, _Time series analysis by state space methods_ . Oxford University Press, 2012. 

- [3] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with applications to tracking and navigation: theory algorithms and software_ . John Wiley & Sons, 2004. 

- [4] S. Gannot and A. Yeredor, “The Kalman filter,” _Springer Handbook of Speech Processing_ , pp. 135–160, 2008. 

- [5] B. Lim and S. Zohren, “Time-series forecasting with deep learning: a survey,” _Philosophical Transactions of the Royal Society A_ , vol. 379, no. 2194, 2021. 

- [6] I. Goodfellow, Y. Bengio, and A. Courville, _Deep learning_ . MIT press, 2016. 

- [7] A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, Ł. Kaiser, and I. Polosukhin, “Attention is all you need,” in _Advances in Neural Information Processing Systems_ , 2017, pp. 5998–6008. 

- [8] A. Gu, I. Johnson, K. Goel, K. Saab, T. Dao, A. Rudra, and C. Ré, “Combining recurrent, convolutional, and continuous-time models with linear state space layers,” _Advances in Neural Information Processing Systems_ , vol. 34, pp. 572–585, 2021. 

- [9] P. Becker, H. Pandya, G. Gebhardt, C. Zhao, C. J. Taylor, and G. Neumann, “Recurrent Kalman networks: Factorized inference in high-dimensional deep feature spaces,” in _International Conference on Machine Learning_ , 2019, pp. 544–552. 

- [10] N. Shlezinger, J. Whang, Y. C. Eldar, and A. G. Dimakis, “Model-based deep learning,” _Proc. IEEE_ , vol. 111, no. 5, pp. 465–499, 2023. 

- [11] N. Shlezinger, Y. C. Eldar, and S. P. Boyd, “Model-based deep learning: On the intersection of deep learning and optimization,” _IEEE Access_ , vol. 10, pp. 115 384–115 398, 2022. 

- [12] N. Shlezinger and Y. C. Eldar, “Model-based deep learning,” _Foundations and Trends® in Signal Processing_ , vol. 17, no. 4, pp. 291–416, 2023. 

- [13] N. Shlezinger and T. Routtenberg, “Discriminative and generative learning for linear estimation of random signals [lecture notes],” _IEEE Signal Process. Mag._ , vol. 40, no. 6, pp. 75–82, 2023. 

- [14] T. Imbiriba, A. Demirkaya, J. Duník, O. Straka, D. Erdo˘gmu¸s, and P. Closas, “Hybrid neural network augmented physics-based models for nonlinear filtering,” in _IEEE International Conference on Information Fusion (FUSION)_ , 2022. 

- [15] T. Imbiriba, O. Straka, J. Duník, and P. Closas, “Augmented physicsbased machine learning for navigation and tracking,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 60, no. 3, pp. 2692–2704, 2024. 

- [16] A. Chiuso and G. Pillonetto, “System identification: A machine learning perspective,” _Annual Review of Control, Robotics, and Autonomous Systems_ , vol. 2, pp. 281–304, 2019. 

- [17] D. Gedon, N. Wahlström, T. B. Schön, and L. Ljung, “Deep state space models for nonlinear system identification,” _IFAC-PapersOnLine_ , vol. 54, no. 7, pp. 481–486, 2021. 

14 

**==> picture [505 x 115] intentionally omitted <==**

**----- Start of picture text -----**<br>
KNetV1 BKN KNetV2 SKN<br>5 5 5 5<br>4.5 EmpiricalPredicted 4.5 EmpiricalPredicted 4.5 EmpiricalPredicted 4.5 EmpiricalPredicted<br>4 4 4 4<br>3.5 3.5 3.5 3.5<br>3 3 3 3<br>2.5 2.5 2.5 2.5<br>2 2 2 2<br>1.5 1.5 1.5 1.5<br>1 1 1 1<br>0.5 0.5 0.5 0.5<br>0 0 0 0<br>0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100<br>(a) KalmanNet V1 (b) Bayesian KalmanNet (c) KalmanNet V2 (d) Split-KalmanNet<br>**----- End of picture text -----**<br>


Fig. 7: The EEC and APEC (as described in (27) and (28)) Vs. time for the model-based deep learning methods. 

**==> picture [252 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
25 EKF 700 RKN<br>EmpiricalPredicted 600 EmpiricalPredicted<br>20<br>500<br>15<br>400<br>10 300<br>200<br>5<br>100<br>0 0<br>0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100<br>(a) Extended Kalman Filter (b) Recurrent Kalman Network<br>**----- End of picture text -----**<br>


Fig. 8: The EEC and APEC (as described in 27 and 28) for the model-based EKF and model-agnostic RKN. 

N. Shlezinger, “Latent-KalmanNet: Learned Kalman filtering for tracking from high-dimensional signals,” _IEEE Trans. Signal Process._ , vol. 72, pp. 352–367, 2023. 

   - [31] S. G. Casspi, O. Hüsser, G. Revach, and N. Shlezinger, “LQGNet: Hybrid model-based and data-driven linear quadratic stochastic control,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2023. 

   - [32] A. N. Putri, C. Machbub, D. Mahayana, and E. Hidayat, “Data driven linear quadratic Gaussian control design,” _IEEE Access_ , vol. 11, pp. 24 227– 24 237, 2023. 

   - [33] A. Milstein, G. Revach, H. Deng, H. Morgenstern, and N. Shlezinger, “Neural augmented Kalman filtering with Bollinger bands for pairs trading,” _IEEE Trans. Signal Process._ , vol. 72, pp. 1974–1988, 2024. 

   - [34] R. L. Russell and C. Reale, “Multivariate uncertainty in deep learning,” _IEEE Trans. Neural Netw. Learn. Syst._ , vol. 33, no. 12, pp. 7937–7943, 2022. 

   - [35] H. Wei, R. Xie, H. Cheng, L. Feng, B. An, and Y. Li, “Mitigating neural network overconfidence with logit normalization,” in _International conference on machine learning_ . PMLR, 2022, pp. 23 631–23 644. 

- [18] L. Ljung, C. Andersson, K. Tiels, and T. B. Schön, “Deep learning and system identification,” _IFAC-PapersOnLine_ , vol. 53, no. 2, pp. 1175–1181, 2020, 21st IFAC World Congress. 

- [19] N. Shlezinger, G. Revach, A. Ghosh, S. Chatterjee, S. Tang, T. Imbiriba, J. Dunik, O. Straka, P. Closas, and Y. C. Eldar, “AI-aided Kalman filters,” _arXiv preprint arXiv:2410.12289_ , 2024. 

- [20] V. G. Satorras, Z. Akata, and M. Welling, “Combining generative and discriminative models for hybrid inference,” in _Advances in Neural Information Processing Systems_ , 2019, pp. 13 802–13 812. 

- [21] W. He, N. Williard, C. Chen, and M. Pecht, “State of charge estimation for Li-ion batteries using neural network modeling and unscented Kalman filter-based error cancellation,” _International Journal of Electrical Power & Energy Systems_ , vol. 62, pp. 783–791, 2014. 

- [22] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, “KalmanNet: Neural network aided Kalman filtering for partially known dynamics,” _IEEE Trans. Signal Process._ , vol. 70, pp. 1532–1547, 2022. 

- [23] G. Choi, J. Park, N. Shlezinger, Y. C. Eldar, and N. Lee, “Split-KalmanNet: A robust model-based deep learning approach for state estimation,” _IEEE Trans. Veh. Technol._ , vol. 72, no. 9, pp. 12 326–12 331, 2023. 

- [24] G. Revach, X. Ni, N. Shlezinger, R. J. van Sloun, and Y. C. Eldar, “RTSNet: Learning to smooth in partially known state-space models,” _IEEE Trans. Signal Process._ , vol. 71, pp. 4441–4456, 2023. 

- [25] J. Song, W. Mei, Y. Xu, Q. Fu, and L. Bu, “Practical implementation of KalmanNet for accurate data fusion in integrated navigation,” _IEEE Signal Process. Lett._ , vol. 31, pp. 1890–1894, 2024. 

- [26] J. Wang, X. Geng, and J. Xu, “Nonlinear Kalman filtering based on selfattention mechanism and lattice trajectory piecewise linear approximation,” _arXiv preprint arXiv:2404.03915_ , 2024. 

- [27] A. Ghosh, A. Honoré, and S. Chatterjee, “DANSE: Data-driven non-linear state estimation of model-free process in unsupervised learning setup,” _IEEE Trans. Signal Process._ , vol. 72, pp. 1824–1838, 2024. 

- [28] D. Yang, F. Jiang, W. Wu, X. Fang, and M. Cao, “Low-complexity acoustic echo cancellation with neural Kalman filtering,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2023. 

- [29] A. Juárez-Lora, L. M. García-Sebastián, V. H. Ponce-Ponce, E. RubioEspino, H. Molina-Lozano, and H. Sossa, “Implementation of Kalman filtering with spiking neural networks,” _Sensors_ , vol. 22, no. 22, p. 8845, 2022. 

- [30] I. Buchnik, G. Revach, D. Steger, R. J. Van Sloun, T. Routtenberg, and 

- [36] I. Klein, G. Revach, N. Shlezinger, J. E. Mehr, R. J. G. van Sloun, and Y. C. Eldar, “Uncertainty in data-driven Kalman filtering for partially known state-space models,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2022, pp. 3194–3198. 

- [37] A. Kendall and Y. Gal, “What uncertainties do we need in Bayesian deep learning for computer vision?” _Advances in neural information processing systems_ , vol. 30, 2017. 

- [38] L. V. Jospin, W. Buntine, F. Boussaid, H. Laga, and M. Bennamoun, “Hands-on Bayesian neural networks–a tutorial for deep learning users,” _IEEE Comput. Intell. Mag._ , vol. 17, no. 2, pp. 29–48, 2022. 

- [39] T. Raviv, S. Park, O. Simeone, and N. Shlezinger, “Modular model-based Bayesian learning for uncertainty-aware and reliable deep MIMO receivers,” _arXiv preprint arXiv:2302.02436_ , 2023. 

- [40] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _Proc. IEEE_ , vol. 92, no. 3, pp. 401–422, 2004. 

- [41] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Trans. Autom. Control_ , vol. 54, no. 6, pp. 1254–1269, 2009. 

- [42] I. Arasaratnam, S. Haykin, and R. J. Elliott, “Discrete-time nonlinear filtering algorithms using Gauss–Hermite quadrature,” _Proc. IEEE_ , vol. 95, no. 5, pp. 953–977, 2007. 

- [43] J. Dunik, O. Straka, M. Simandl, and E. Blasch, “Random-point-based filters: analysis and comparison in target tracking,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 51, no. 2, pp. 1403–1421, 2015. 

- [44] L. Lindemann, Y. Zhao, X. Yu, G. J. Pappas, and J. V. Deshmukh, “Formal verification and control with conformal prediction,” _arXiv preprint arXiv:2409.00536_ , 2024. 

- [45] A. G. Wilson and P. Izmailov, “Bayesian deep learning and a probabilistic perspective of generalization,” _Advances in neural information processing systems_ , vol. 33, pp. 4697–4708, 2020. 

- [46] V. Fortuin, “Priors in Bayesian deep learning: A review,” _International Statistical Review_ , vol. 90, no. 3, pp. 563–591, 2022. 

- [47] Y. Gal, J. Hron, and A. Kendall, “Concrete dropout,” _Advances in neural information processing systems_ , vol. 30, 2017. 

- [48] J. Gawlikowski, C. R. N. Tassi, M. Ali, J. Lee, M. Humt, J. Feng, A. Kruspe, R. Triebel, P. Jung, R. Roscher _et al._ , “A survey of uncertainty in deep neural networks,” _Artificial Intelligence Review_ , vol. 56, pp. 1513–1589, 2023. 

- [49] V. Lefkopoulos, M. Menner, A. Domahidi, and M. N. Zeilinger, “Interactionaware motion prediction for autonomous driving: A multiple model kalman filtering scheme,” _IEEE Robot. Autom. Lett._ , vol. 6, no. 1, pp. 80–87, 2020. 

15 

**==> picture [507 x 196] intentionally omitted <==**

**----- Start of picture text -----**<br>
12<br>80 Overconfident Optimal<br>EKF<br>EKF<br>70 KNetV1 10 KNetV1<br>BKN<br>BKN<br>KNetV2<br>60 KNetV2 SKN<br>SKN 8<br>RKN<br>RKN<br>50<br>40 6<br>30<br>4<br>20<br>10 2<br>0<br>0<br>-10 -5 0 5 10 15 20 25 30<br>-10<br>-10 -5 0 5 10 15 20 25 30 r [-2]  [dB]<br>r [-2]  [dB]<br>log (ANEES)<br>MSE [dB]<br>**----- End of picture text -----**<br>


(b) ANEES for mismatched model, The frequentist KNets have managed to maintain an accurate error covariance estimations, although the Bayesian KalmanNet achieved the most credible error covariance estimation. 

(a) MSE for mismatched model, the model based deep learning methods consistently provide the most accurate state estimates compared to the model-free and model dependent methods. 

Fig. 9: CV SS model - mismatched model 

- [50] Y. Huang, Y. Zhang, Z. Wu, N. Li, and J. Chambers, “A novel adaptive Kalman filter with inaccurate process and measurement noise covariance matrices,” _IEEE Trans. Autom. Control_ , vol. 63, no. 2, pp. 594–601, 2017. 

- [51] H. Lan, J. Hu, Z. Wang, and Q. Cheng, “Variational nonlinear Kalman filtering with unknown process noise covariance,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 59, no. 6, pp. 9177–9190, 2023. 

- [52] H. Lan, S. Zhao, J. Hu, Z. Wang, and J. Fu, “Joint state estimation and noise identification based on variational optimization,” _IEEE Trans. Autom. Control_ , 2025, early access. 

- [53] X. Ni, G. Revach, and N. Shlezinger, “Adaptive KalmanNet: Data-driven Kalman filter with fast adaptation,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2024, pp. 5970–5974. 

- [54] G. Revach, N. Shlezinger, T. Locher, X. Ni, R. J. van Sloun, and Y. C. Eldar, “Unsupervised learned Kalman filtering,” in _European Signal Processing Conference (EUSIPCO)_ . IEEE, 2022, pp. 1571–1575. 

- [55] M. Jones, P. Chang, and K. P. Murphy, “Bayesian online natural gradient (BONG),” _Advances in Neural Information Processing Systems_ , vol. 37, pp. 131 104–131 153, 2024. 

- [56] Y. Gusakov, O. Simeone, T. Routtenberg, and N. Shlezinger, “Rapid online Bayesian learning for deep receivers,” in _IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2025. 

- [57] Y. Bar-Shalom and K. Birmiwal, “Consistency and robustness of PDAF for target tracking in cluttered environments,” _Automatica_ , vol. 19, no. 4, pp. 431–437, 1983. 

- [58] O. E. Drummond, X. R. Li, and C. He, “Comparison of various static multiple-model estimation algorithms,” in _Defense, Security, and Sensing_ , 1998. 

- [59] X. R. Li, Z. Zhao, and V. P. Jilkov, “Estimator’s credibility and its measures,” in _Proc. IFAC 15th World Congress_ , 2002. 

