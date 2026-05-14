---
title: "Ensemble Kalman Filtering Meets Gaussian Process SSM for Non-Mean-Field and Online Inference"
arxiv: "2312.05910"
authors: [Zhidi Lin, Yiyong Sun, Feng Yin, Alexandre Hoang Thiéry]
year: 2023
source: paper
ingested: 2026-05-14
sha256: 4a60b860c616fe1a74e9706d10481f995d59e3f268376204a416b62af5353f10
conversion: pymupdf4llm
---

1 

# Ensemble Kalman Filtering Meets Gaussian Process SSM for Non-Mean-Field and Online Inference 

Zhidi Lin , Yiyong Sun , Feng Yin , _Senior Member, IEEE_ , and Alexandre Hoang Thi´ery 

_**Abstract**_ **—The Gaussian process state-space models (GPSSMs) represent a versatile class of data-driven nonlinear dynamical system models. However, the presence of numerous latent variables in GPSSM incurs unresolved issues for existing variational inference approaches, particularly under the more realistic nonmean-field (NMF) assumption, including extensive training effort, compromised inference accuracy, and infeasibility for online applications, among others. In this paper, we tackle these challenges by incorporating the ensemble Kalman filter (EnKF), a well-established model-based filtering technique, into the NMF variational inference framework to approximate the posterior distribution of the latent states. This novel marriage between EnKF and GPSSM not only eliminates the need for extensive parameterization in learning variational distributions, but also enables an interpretable, closed-form approximation of the evidence lower bound (ELBO). Moreover, owing to the streamlined parameterization via the EnKF, the new GPSSM model can be easily accommodated in online learning applications. We demonstrate that the resulting EnKF-aided online algorithm embodies a principled objective function by ensuring data-fitting accuracy while incorporating model regularizations to mitigate overfitting. We also provide detailed analysis and fresh insights for the proposed algorithms. Comprehensive evaluation across diverse real and synthetic datasets corroborates the superior learning and inference performance of our EnKF-aided variational inference algorithms compared to existing methods.** 

_**Index Terms**_ **—Gaussian process, state-space model, ensemble Kalman filter, online learning, variational inference.** 

## I. INTRODUCTION 

TATE-SPACE models (SSMs) describe the underlying **S** dynamics of latent states through a transition function and an emission function [1]. As a versatile tool for modeling dynamical systems, SSM finds successful applications in diverse fields, including control engineering, signal processing, computer science, and economics [2]–[4]. In SSM, a key task is to infer unobserved latent states from a sequence of noisy measurements. Established techniques, such as the Kalman filter (KF), extended Kalman filter (EKF), ensemble Kalman filter (EnKF), and particle filter (PF), have been widely employed over the decades for latent state inference [1]. However, these classic state inference methods heavily rely on precise knowledge of the underlying system dynamics [5], posing tremendous challenges in complex and uncertain scenarios like 

Z. Lin is with the School of Science & Engineering, and the Future Network of Intelligence Institute, The Chinese University of Hong Kong, Shenzhen, and also with the Shenzhen Research Institute of Big Data, Shenzhen 518172, China (email: zhidilin@link.cuhk.edu.cn). Y. Sun and F. Yin are with the School of Science & Engineering, The Chinese University of Hong Kong, Shenzhen, Shenzhen 518172, China (email: yiyongsun@link.cuhk.edu.cn, yinfeng@cuhk.edu.cn). A. H. Thi´ery is with the Department of Statistics & Data Science, National University of Singapore, Singapore 117546 (email: a.h.thiery@nus.edu.sg). _Corresponding author: Feng Yin_ . 

model-based reinforcement learning [6] and disease epidemic propagation [7]. As a novel alternative, the underlying complex dynamics can be learned from noisy observations, leading to the emergence of data-driven SSMs. One class of prominent data-driven SSMs is the Gaussian process state-space model (GPSSM) [8], which utilizes Gaussian processes (GPs) [9] as the core learning modules to capture the complex underlying system dynamics. 

Gaussian processes, serving as the most prominent Bayesian non-parametric model [9], provide the flexibility to model general nonlinear system dynamics without enforcing an explicit parametric structure. With the inherent regularization imposed by the GP prior, GPSSMs are able to mitigate overfitting and model generalization issues [10], rendering them to be more effective in scenarios with limited data samples [11]. Moreover, owing to its Bayesian nature, GPSSMs maintain good interpretability and explicit uncertainty calibration for analyzing system dynamics. These superior properties have led to the extensive usage of GPSSMs in various live applications, such as human pose and motion learning [12], robotics and control learning [13], reinforcement learning [14], target tracking and navigation [15], and magnetic-field sensing [16]. 

Despite the popularity of GPSSMs, simultaneously learning the model and estimating the latent states in GPSSMs remains highly challenging, primarily due to the following two factors. First, the inference quality of the numerous latent states affects the model learning and vice versa, leading to heightened computational and statistical complexities. Second, the nonlinearity in GPSSMs prohibits tractable learning and inference processes [17]–[19]. Hence, the main task in GPSSM is to accurately approximate the joint posterior over the latent states and the system dynamics represented by GPs. Multiple approaches have emerged towards achieving this objective in the last decade. 

The seminal work utilizing particle Markov chain Monte Carlo (PMCMC) was proposed in [8]. Subsequently, more advanced methods [20]–[23] leveraged the reduced-rank GP approximation introduced in [24] to alleviate the substantial computational demands of GPs in [8]. However, the computational burden of the involved PMCMC remains unaffordable, particularly when dealing with long and high-dimensional latent state trajectories. Consequently, there has been a paradigm shift towards variational inference methods [25]–[33], which adopted the classic sparse GP approximations with inducing points [34]. 

Generally, the variational inference approaches can be classified into two main categories: the mean-field (MF) class [25]–[28] versus the non-mean-field (NMF) class [29]–[33], 

2 

depending on whether the statistical independence assumption is applied to the variational distribution of the latent states and GP dynamics. The first variational algorithm, incorporating the MF assumption and integrating PF for latent state inference, was introduced in [25]. Subsequent MF endeavors [26]–[28] aimed at reducing computational and model complexities in [25]. While the MF class methods may enable more manageable computations, they neglect the inherent dependencies between the latent states and the GP dynamics, potentially impairing the overall learning accuracy and yielding overconfident state estimates [35]. 

Recent methods [29]–[33], therefore, concentrate on the more complicated NMF approximation to address the inaccuracies arising from the MF assumption, yet they continue to struggle with computational challenges. Specifically, in [29], the posterior distribution of underlying states conditioned on the GP dynamics was simply approximated by the subjectively selected prior distribution, while in [30] and [31], the posterior was approximated by some parametric Markov-structured Gaussian variational distributions. However, optimizing the extensive variational parameters in the variational distributions is computationally demanding and inefficient. In contrast to the heavy parameterization as conducted in [29]–[31], the works in [32] and [33] opted for directly characterizing the posterior distribution through the model evidence. Nonetheless, the Laplace approximation, employed in [32], can yield an oversimplified unimodal posterior distribution over the latent states [17], while the stochastic gradient Hamiltonian Monte Carlo method [36], employed in [33], may exhibit very slow convergence (50 _,_ 000 iterations as reported). Furthermore, all these existing variational methods are incompatible with online applications, posing a notable limitation in their applicability. 

To tackle the computational challenges mentioned above, we propose integrating the model-based filtering technique, EnKF, into the NMF variational inference framework. The primary benefit of this approach lies in the streamlined parameterization of the associated variational distributions, improving inference tractability and accelerating algorithm convergence. Additionally, this streamlined parameterization enables seamless accommodation of our method in online learning applications. The main contributions are summarized as follows. 

- We corroborate the significance of incorporating wellestablished model-based filtering techniques to enhance the efficiency of GPSSM variational algorithms. In contrast to existing methods utilizing numerous variational parameters to parameterize the variational distribution over latent states, our proposed novel algorithm harnesses the EnKF to accurately capture the dependencies between the latent states and the GP dynamics, and eliminate the need to parameterize the variational distribution, significantly reducing the number of variational parameters and accelerating the algorithm convergence. 

- By leveraging EnKF, we also demonstrate an approximation of the evidence lower bound (ELBO) via simply summating multiple interpretable terms with readily available closed-form solutions. Leveraging the differentiable nature of the classic EnKF alongside the off-shelf automatic 

   - differentiation tools, we can optimize the ELBO and train the GPSSM efficiently. 

- Without explicitly parameterizing the variational distribution over latent states, the proposed EnKF-aided algorithm gets readily extended to accommodate online learning applications. The resulting online algorithm relies on a principled objective by ensuring observation fitting accuracy while incorporating model regularizations to mitigate model overfitting, rendering it superior to stateof-the-art online algorithms in learning and inference efficiency. 

- We offer in-depth analysis and novel insights into the proposed algorithms, and conduct extensive experiments on diverse real and synthetic datasets to assess their performance from various aspects. The results demonstrate that the proposed EnKF-aided variational learning algorithms consistently outperform the existing stateof-the-art methods, especially in terms of learning and inference. 

The remainder of this paper is organized as follows. Some preliminaries related to GPSSMs are provided in Section II. The computational challenges of the existing methods are summarized in Section III. Section IV elaborates the proposed EnKF-aided variational learning algorithm. Section V extends the proposed algorithm to accommodate online learning applications. The experimental results are presented in Section VI, and Section VII concludes this paper. More supportive results, proofs, etc., are relegated to the Appendix and supplementary materials [37]. 

**==> picture [84 x 8] intentionally omitted <==**

In Section II-A, we briefly review the Gaussian process regression. Section II-B is dedicated to introducing Gaussian process state-space models. 

## _A. Gaussian Processes (GPs)_ 

A GP defines a collection of random variables indexed by _**x** ∈X_ , such that any finite subset of these variables follows a joint Gaussian distribution [9]. Mathematically, a real scalarvalued GP _f_ ( _**x**_ ) can be represented as 

**==> picture [200 x 12] intentionally omitted <==**

where _µ_ ( _**x**_ ) is a mean function typically set to zero in practice, and _k_ ( _**x** ,_ _**x**[′]_ ) is the kernel function that provides insights about the nature of the underlying function [9]; and _**θ** gp_ is a set of hyperparameters that needs to be tuned for model selection. By placing a GP prior over the function _f_ ( _·_ ) : _X �→_ R in a general regression model, 

**==> picture [210 x 12] intentionally omitted <==**

we get the salient Gaussian process regression (GPR) model. Given an observed dataset, _D_ ≜ _{_ _**x** i, yi}[n] i_ =1[≜] _[{]_ _**[X]**[,]_ _**[ y]**[}]_ consisting of _n_ input-output pairs, the posterior distribution of the mapping function, _p_ ( _f_ ( _**x** ∗_ ) _|_ _**x** ∗, D_ ), at any test input _**x** ∗ ∈X_ , is Gaussian [9], fully characterized by the posterior mean _ξ_ and the posterior variance Ξ. Concretely, 

**==> picture [249 x 32] intentionally omitted <==**

3 

where _**KX** ,_ _**X**_ denotes the covariance matrix evaluated on the training input _**X**_ , and each entry is [ _**KX** ,_ _**X**_ ] _i,j_ = _k_ ( _**x** i,_ _**x** j_ ); _**Kx** ∗,_ _**X**_ denotes the cross covariance matrix evaluated on the test input _**x** ∗_ and the training input _**X**_ ; the zero-mean GP prior is assumed here and will be used in the rest of this paper if there is no further specification. Note that the posterior distribution _p_ ( _f_ ( _**x** ∗_ ) _|_ _**x** ∗, D_ ) gives not only a point estimate, i.e., the posterior mean, but also an uncertainty region of such estimate quantified by the posterior variance. It is also noteworthy that here we denote the variables in the GPR using mathematical mode italics, such as _**x** i_ and _yi_ ; these variables should not be confused with the latent state **x** _t_ and observation **y** _t_ in SSM (cf. Eq. (4)). 

## _B. Gaussian Process State-Space Models (GPSSMs)_ 

A generic SSM describes the probabilistic dependence between latent state **x** _t ∈_ R _[d][x]_ and observation **y** _t ∈_ R _[d][y]_ . Mathematically, it can be expressed by the following equations: 

**==> picture [245 x 27] intentionally omitted <==**

where the latent states form a Markov chain. That is, for any time instance _t ∈_ N, the next state **x** _t_ +1 is generated by conditioning on only **x** _t_ and the transition function _f_ ( _·_ ) : R _[d][x] �→_ R _[d][x]_ . The emission is assumed to be linear with a known coefficient matrix, _**C** ∈_ R _[d][y][×][d][x]_ , hence mitigating the system non-identifiability[1] . Both the states and observations are corrupted by zero-mean Gaussian noise with covariance matrices **Q** and **R** , respectively. 

The GPSSM incorporates a GP prior to model the timeinvariant transition function _f_ ( _·_ ) in Eq. (4). Specifically, Fig. 1 presents the graphical model of GPSSM, while the following equations express its mathematical representation: 

**==> picture [187 x 26] intentionally omitted <==**

**==> picture [157 x 11] intentionally omitted <==**

**==> picture [177 x 12] intentionally omitted <==**

**==> picture [184 x 11] intentionally omitted <==**

where **f** _t_ represents the GP transition function value evaluated at the previous state **x** _t−_ 1. For multidimensional state spaces ( _dx >_ 1), the transition function _f_ ( _·_ ) : R _[d][x] �→_ R _[d][x]_ is represented using a multi-output GP. In this context, the _dx_ functions are typically modeled with _dx_ mutually independent GPs [39]. The prior distribution of the initial state, _p_ ( **x** 0), is assumed to be Gaussian and known for simplicity; however, it can also be learned from observed data in the absence of prior information [29]. Additionally, it is noteworthy that the GPSSM illustrated in Fig. 1 can be extended to accommodate control systems incorporating a deterministic control input _**c** t ∈_ R _[d][c]_ by augmenting the latent state with [ **x** _t,_ _**c** t_ ] _∈_ R _[d][x]_[+] _[d][c]_ . For the sake of brevity, however, we omit explicit reference to _**c** t_ in our notation throughout this paper. 

> 1Nonlinear emissions can be addressed by augmenting the latent state to a higher dimension. This augmentation helps mitigate/eliminate the significant non-identifiability issues commonly encountered in GPSSMs [26], [38] 

**==> picture [197 x 91] intentionally omitted <==**

**----- Start of picture text -----**<br>
· · · f 1 · · · f t− 1 f t · · ·<br>x 0 x 1 · · · x t− 1 x t · · ·<br>y 1 · · · y t− 1 y t · · ·<br>**----- End of picture text -----**<br>


Fig. 1. Graphical model of GPSSM. The white circles represent the latent variables, while the gray circles represent the observable variables. The thick horizontal bar represents a set of fully connected nodes, i.e., the GP. 

**Remark 1.** _It is important to note the distinction between GPSSMs and the state-space representation of GPs (SSGP). The SSGP is a method that converts a GP into a linear statespace form, enabling the use of efficient inference techniques such as the Kalman filter and smoother, thereby facilitating the computationally efficient handling of large-scale problems. For more details on SSGP, we direct readers to [40], [41]. In contrast, a GPSSM utilizes the non-parametric flexibility of GPs to model the state transitions in SSMs, allowing for the capture of complex, nonlinear system dynamics. This results in a more flexible but typically computationally intensive SSM._ 

Given the aforementioned model, see Eq. (5), the joint density function of the GPSSM can be expressed as: 

**==> picture [226 x 29] intentionally omitted <==**

where _p_ ( **f** 1: _T_ )= _p_ ( _f_ ( **x** 0: _T −_ 1))=[�] _[T] t_ =1 _[p]_[(] **[f]** _[t][|]_ **[f]**[1:] _[t][−]_[1] _[,]_ **[ x]**[0:] _[t][−]_[1][)][ corre-] sponds to a finite dimensional ( _T_ -dimensional) GP distribution [26], and we define the short-hand notations _⃗_ **y** ≜ **y** 1: _T_ = _{_ **y** _t}[T] t_ =1[,] _[⃗]_ **[f]**[≜] **[f]**[1:] _[T]_[=] _[{]_ **[f]** _[t][}][T] t_ =1[,][and] _[⃗]_ **[x]**[≜] **[x]**[0:] _[T]_[=] _[{]_ **[x]** _[t][}][T] t_ =0[.] The model parameters _**θ**_ includes the noise covariance and GP hyper-parameters, i.e., _**θ**_ = _{_ **Q** _,_ **R** _,_ _**θ** gp}_ . The challenging task in GPSSM is to learn _**θ**_ , and simultaneously infer the latent states of interest, which involves the marginal distribution _p_ ( _⃗_ **y** _|_ _**θ**_ ). However, due to the nonlinearity of GP, a closedform solution for _p_ ( _⃗_ **y** _|_ _**θ**_ ) is unavailable. Hence, it becomes necessary to utilize approximation methods. 

## III. PROBLEM STATEMENT 

To overcome the intractability of the marginal distribution _p_ ( _⃗_ **y** _|_ _**θ**_ ), variational GPSSMs involve constructing a model evidence lower bound (ELBO) to the logarithm of the marginal likelihood. Specifically, the ELBO, denoted by _L_ , is constructed such that the difference between log _p_ ( _⃗_ **y** _|_ _**θ**_ ) and _L_ is equal to the Kullback-Leibler (KL) divergence between the variational approximation, _q_ ( _⃗_ **x** _,[⃗]_ **f** ), and the true posterior, _p_ ( _⃗_ **x** _,[⃗]_ **f** _|⃗_ **y** ), i.e., 

**==> picture [255 x 56] intentionally omitted <==**

Detailed derivations can be found in Supplement A-A. Maximizing _L_ with respect to (w.r.t.) _**θ**_ fine-tunes the model 

4 

parameters to fit the observed data in the model learning process; while maximizing _L_ w.r.t. the variational distribution _q_ ( _⃗_ **x** _,[⃗]_ **f** ) is equivalent to minimizing the KL divergence, KL[ _q_ ( _⃗_ **x** _,[⃗]_ **f** ) _∥p_ ( _⃗_ **x** _,[⃗]_ **f** _|⃗_ **y** )]. That is, it enhances the quality of the variational distribution approximation, bringing it closer to the underlying posterior distribution, _p_ ( _⃗_ **x** _,[⃗]_ **f** _|⃗_ **y** ), which corresponds to the model inference process [42]. The capacity of _q_ ( _⃗_ **x** _,[⃗]_ **f** ) to approximate _p_ ( _⃗_ **x** _,[⃗]_ **f** _|⃗_ **y** ) is thus of crucial importance [43]. Based on the model defined in Eq. (6), a generic factorization of _q_ ( _⃗_ **x** _,[⃗]_ **f** ) is as follows: 

**==> picture [193 x 30] intentionally omitted <==**

where _q_ ( _[⃗]_ **f** ) represents the variational distribution of the GP and _q_ ( **x** 0)[�] _[T] t_ =1 _[q]_[(] **[x]** _[t][|]_ **[f]** _[t]_[)][ corresponds to the variational distribution] of the latent states [38], [44]. It is noteworthy that the factorization of the variational distribution presented in Eq. (8) is recognized as an NMF approximation within the GPSSM literature (see formal definition in Appendix C) [30], because it explicitly establishes the dependencies between the latent states and the GP transition function values, as manifested by the terms[�] _[T] t_ =1 _[q]_[(] **[x]** _[t][|]_ **[f]** _[t]_[)][.] 

The works most closely related to this paper are probably [29] and [30]. In [29], variational distribution _q_ ( **x** _t|_ **f** _t_ ) is subjectively set equal to the prior distribution _p_ ( **x** _t|_ **f** _t_ ), i.e., _q_ ( **x** _t|_ **f** _t_ ) = _p_ ( **x** _t|_ **f** _t_ ). But using the prior distribution as an approximation results in no filtering or smoothing effect on latent states, although there is a dependence between the latent states _⃗_ **x** and the transition function values _[⃗]_ **f** . Instead, the work in [30] assumes a parametric Markov-structured Gaussian variational distribution over the temporal states, i.e., 

**==> picture [193 x 11] intentionally omitted <==**

where _{_ _**A** t,_ _**b** t,_ _**S** t}[T] t_ =1[are][free][variational][parameters.][This] choice, however, introduces a significant drawback: the number of variational parameters grows linearly with the length of the time series. Although this issue can be partially addressed by incorporating an _inference network_ , such as a bidirectional recurrent neural network [28], [44], to learn the variational parameters and make the variational distribution learning with a constant model complexity, fine-tuning these variational parameters of the inference network still requires substantial effort. Consequently, despite the flexibility of the variational distribution described in Eq. (9) allowing for approximation of the true posterior distribution, its empirical performance often falls short of its theoretical expressive capacity [32]. Moreover, it is noteworthy that the inference network commonly takes the input of the observations, _⃗_ **y** , rendering the existing inference network-based methods predominantly trained in an offline manner, thus posing challenges when attempting to adapt them for online applications. 

To address these limitations, we step away from the heavy parameterization (e.g., the black-box inference networks) and propose a novel interpretable EnKF-aided algorithm for variational inference in GPSSMs. Our algorithm can exploit the dependencies between _⃗_ **x** and _[⃗]_ **f** and alleviate the model and 

computational complexities while being easily extended to an online learning algorithm. 

## IV. ENVI: ENKF-AIDED VARIATIONAL INFERENCE 

This section presents our novel variational inference algorithm for GPSSMs. We begin by introducing the model-based EnKF in Section IV-A, which serves as the foundation for our algorithm. Following that, Section IV-B details the proposed EnKF-aided variational inference algorithm. Lastly, extensive discussions about the properties of our proposed algorithm are given in Section IV-C. 

## _A. Ensemble Kalman Filter (EnKF)_ 

The EnKF is a Monte Carlo-based method that excels in handling nonlinear systems compared to the KF and EKF [45]. Given an SSM, see Eq. (4), the EnKF sequentially approximates the filtering distributions using _N ∈_ N equally weighted particles [45]. Specifically, at the prediction step, EnKF first samples particles, **x**[1:] _t−[N]_ 1[≜] _[{]_ **[x]** _[n] t−_ 1 _[}][N] n_ =1[,][from][the] filtering distribution, _p_ ( **x** _t−_ 1 _|_ **y** 1: _t−_ 1), at time _t −_ 1. Then, the sampled particles are propagated using the state transition function _f_ ( _·_ ), i.e., 

**==> picture [213 x 11] intentionally omitted <==**

The prediction distribution is then approximated by a Gaussian distribution, i.e. _p_ ( **x** _t|_ **y** 1: _t−_ 1) _≈N_ ( **x** _t|_ **m** ¯ _t,_ **P**[¯] _t_ ), where 

**==> picture [221 x 64] intentionally omitted <==**

With the linear Gaussian emission in Eq. (4), the joint distribution of **x** _t_ and **y** _t_ can be readily obtained as follows: 

**==> picture [242 x 33] intentionally omitted <==**

Thus, the filtering distribution, _p_ ( **x** _t|_ **y** 1: _t_ ) = _N_ ( **x** _t|_ **m** _t,_ **P** _t_ ) _,_ can be obtained using the conditional Gaussian identity at the update step, where 

**==> picture [186 x 28] intentionally omitted <==**

and **G**[¯] _t_ = **P**[¯] _t_ _**C**[⊤]_ ( _**C**_ **P**[¯] _t_ _**C**[⊤]_ + **R** ) _[−]_[1] is the Kalman gain [45]. Each filtered particle **x** _[n] t_[is][then][obtained][from][a][Kalman-type] update, i.e., 

**==> picture [247 x 12] intentionally omitted <==**

It is crucial to note that the EnKF inherently exhibits differentiability. Specifically, if we utilize the reparameterization trick [46] to sample the process and observation noises as shown in Eq. (10) and (14), i.e., 

**==> picture [197 x 31] intentionally omitted <==**

5 

then the sampled latent states become differentiable w.r.t. the state transition function _f_ and the noise covariances **Q** and **R** . This differentiable nature is crucial for enabling the use of gradient-based optimization methods in learning algorithms. Moreover, although we present the linear emission model in this paper, the EnKF can be extended to nonlinear emission models. The difference lies in the computation of the predicted observation covariance and the cross-covariance between the state and the observation predictions in Eq. (12), which are done using ensembles. For more details, see e.g. [45]. 

**Remark 2.** _Compared to another Monte Carlo-based method, PF, EnKF demonstrates computational efficiency, particularly in exceedingly high-dimensional spaces [47], though the PF may offer more flexibility in addressing highly non-Gaussian and nonlinear aspects. Moreover, the inherent differentiable nature of EnKF (see Eqs._ (10) _–_ (14) _) enables seamless integration with off-the-shelf automatic differentiation tools (e.g., PyTorch [48]) for model parameter optimization (see more discussions in Section IV-C). This stands in contrast to PF, where the discrete distribution resampling significantly poses challenges for the utilization of the reparameterization trick [46], resulting in significantly higher computational complexity for the parameters gradient computations [49]–[51]._ 

In the following subsection, we will describe our novel EnKF-aided NMF variational inference algorithm for GPSSMs, which significantly reduces the number of variational parameters and ultimately enhances the learning and inference performance. 

## _B. EnKF-Aided Variational Inference (EnVI)_ 

_1)_ _**Sparse GPSSMs** :_ Before introducing the utilization of EnKF in the variational inference framework, let us first introduce the sparse GP [34], a widely utilized technique in various GP variational approximations. This method serves as a scalable approach to model the corresponding GP component within the approximate posterior distribution (see Eq. (8)), thereby guaranteeing inherent scalability in GPSSM. The main idea of the sparse GP is to introduce a small set of inducing points _⃗_ **z** ≜ _{_ **z** _i}[M] i_ =1[and] _[⃗]_ **[u]**[≜] _[{]_ **[u]** _[i][}][M] i_ =1[,] _[M][≪][T]_[,][to][serve] as the surrogate of the associated GP, where the inducing inputs, **z** _i ∈_ R _[d][x] , ∀i_ , are placed in the same space as the latent states **x** _t_ , while the corresponding inducing outputs **u** _i_ = _f_ ( **z** _i_ ) follow the same GP prior as _[⃗]_ **f** . With the augmentation of the inducing points, the joint distribution of the GPSSM becomes 

**==> picture [235 x 30] intentionally omitted <==**

_⃗ ⃗ ⃗_ where _p_ ( _[⃗]_ **f** _, ⃗_ **u** ) = _p_ ( **u** ) _p_ ( _[⃗]_ **f** _|_ **u** ) = _p_ ( **u** )[�] _[T] t_ =1 _[p]_[(] **[f]** _[t][|]_ **[x]** _[t][−]_[1] _[, ⃗]_ **[u]**[)][is] the augmented GP prior and _p_ ( **f** _t|_ **x** _t−_ 1 _, ⃗_ **u** ) is the noiseless GP prediction whose mean and covariance can be computed similarly to Eq. (3). The introduced inducing inputs _⃗_ **z** will be treated as variational parameters and jointly optimized with model parameters [52]. We will further describe this later. 

Suppose that the inducing outputs _⃗_ **u** serve as sufficient statistics for the GP function values _[⃗]_ **f** , such that given _⃗_ **u** , the GP function values _[⃗]_ **f** and any novel **f** _∗_ are independent [34], 

_⃗_ i.e., _p_ ( **f** _∗|[⃗]_ **f** _, ⃗_ **u** ) = _p_ ( **f** _∗|_ **u** ) for any **f** _∗_ . We can integrate out _[⃗]_ **f** in Eq. (16), and the transition function is fully characterized using only the inducing points. Consequently, we have: 

**==> picture [238 x 29] intentionally omitted <==**

where 

**==> picture [229 x 37] intentionally omitted <==**

and with a bit abuse of notation, 

**==> picture [245 x 29] intentionally omitted <==**

That is to say, with the aid of sparse GPs, the computational complexity of GPSSMs can be reduced to _O_ ( _dxTM_[2] ), comparing to the original _O_ ( _dxT_[3] ) [38]. 

_2)_ _**ELBO for sparse GPSSM** :_ In the context of the GPSSM described in Eq. (17), we first assume a generic variational distribution for the latent variables, _{⃗_ **u** _,⃗_ **x** _}_ , factorized as follows: 

**==> picture [240 x 64] intentionally omitted <==**

Here, the variational distribution over the inducing outputs, _q_ ( _⃗_ **u** ), is explicitly assumed to be a free-form Gaussian, i.e., 

**==> picture [246 x 30] intentionally omitted <==**

where **m** = [ **m** _[⊤]_ 1 _[, . . . ,]_ **[ m]** _[⊤] dx_[]] _[⊤] ∈_ R _[Md][x]_ and **S** = diag( **L** 1 **L** _[⊤]_ 1 _[, . . . ,]_ **[ L]** _[d] x_ **[L]** _[⊤] dx_[)] _[∈]_[R] _[Md][x][×][Md][x]_[are][free][variational] parameters. This explicit representation of the variational distribution enables scalability through the utilization of stochastic gradient-based optimization [53], as it allows for the independence of individual GP predictions given the explicit inducing points [52]. The corresponding inducing inputs, _⃗_ **z** , are treated as variational parameters as well, as described in [34], [52]. These parameters, _{⃗_ **z** _,_ **m** _,_ **S** _}_ , collectively define the variational distribution that approximates the true GP posterior. We also assume that the variational distribution over the initial state is _q_ ( **x** 0) = _N_ ( **x** 0 _|_ **m** 0 _,_ **L** 0 **L** _[⊤]_ 0[)][,][where] **m** 0 _∈_ R _[d][x]_ and lower-triangular matrix **L** 0 _∈_ R _[d][x][×][d][x]_ are free variational parameters of _q_ ( **x** 0). The variational distribution of _⃗_ the latent states, _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1), obtained by integrating out **f** _t_ as shown in Eq. (20), will be implicitly modeled by resorting to the EnKF technique. This modeling approach will help _⃗_ eliminate the need to parameterize _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1), a common requirement in the existing works [28]–[31], thus overcoming the challenges associated with optimizing a large number of variational parameters, as discussed in Section III. 

Before elucidating the methodology of employing EnKF to eliminate the parameterization for the variational distribution 

6 

_⃗ q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1), we first undertake the derivation of the ELBO, which is succinctly summarized as follows. 

**Theorem 1.** _Upon the augmentation of the inducing points into the GPSSM (see Eq._ (17) _) and under the NMF assumption of the variational distribution (see Eq._ (20) _), the model evidence lower bound for joint learning and inference is:_ 

**==> picture [246 x 101] intentionally omitted <==**

## _Proof._ The proof can be found in Appendix A 

An important observation lies in the interpretability of each component within the ELBO. Specifically, when maximizing the ELBO for learning and inference: 

- Term 1 corresponds to the data reconstruction error, which encourages any state trajectory _⃗_ **x** sampled from the variational distribution, _q_ ( _⃗_ **u** _,⃗_ **x** ), to accurately reconstruct the observed data. 

- Terms 2 and 3 serve as regularization terms for _q_ ( **x** 0) and _q_ ( _⃗_ **u** ), respectively. They discourage significant deviations of the variational distributions from the corresponding prior distributions. 

- _⃗_ 

- _•_ Term 4 represents a regularization for _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1), _⃗_ 

- which discourages significant deviations of _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) _⃗_ 

- from the prior _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1). 

_3)_ _**EnVI algorithm** :_ The NMF assumption applied to the variational distribution (Eq. (20)) typically results in an intractable evaluation of the first and fourth terms within the ELBO [30]. Therefore, approximations are needed to help efficiently evaluate the ELBO. One existing method is to _⃗ ⃗_ simply set _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) = _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1), resulting in the same ELBO as in [29], where no filtering or smoothing effect is feasible. To circumvent this limitation, we examine the difference between term 1 and term 4 in Eq. (22) and propose our variational lower bound approximation. The main result is summarized in the following proposition. 

## **Proposition 1.** _Under the approximations that:_ 

_⃗ ⃗_ 1) _p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t−_ 1) _≈ p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t_ ) _,_ 

_⃗ ⃗_ 2) _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) _≈ p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _t_ ) _,_ 

_the ELBO presented in Theorem 1 can be reformulated as a summation over several simple terms:_ 

**==> picture [249 x 45] intentionally omitted <==**

_⃗ where the log-likelihood,_ log _p_ ( **y** _t|_ **u** _,_ **y** 1: _t−_ 1) _in the first term can be analytically evaluated using the EnKF (discussed below). The two KL divergence terms can also be computed in closed form, due to the Gaussian nature of the prior and variational distributions [17]._ 

_Proof._ The proof can be found in Appendix A. 

Proposition 1 demonstrates that the newly derived ELBO is significantly more tractable under two mild approximations, which are justified and explained as follows. 

- Approximation 1) posits that the state estimation at time _t −_ 1 using observations from time 1 to _t −_ 1 _⃗_ 

- (i.e., _p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t−_ 1)) is approximately equal to the estimation using observations from time 1 to _t_ (i.e., _⃗_ 

- _p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t_ )). This approximation is generally reasonable, particularly when _t_ is large (i.e., with a long observation sequence), as the increased information aids in more accurately inferring the latent state, thereby reducing the discrepancy between the two posterior distributions. 

- Approximation 2) states that the variational distribution _⃗_ 

- _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) is approximately equal to the posterior dis- _⃗_ 

- tribution _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _t_ ). In the variational inference _⃗_ 

- framework [53], the variational distribution _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) is intended to approximate the true but unknown distribu- _⃗_ 

- tion _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _T_ ). That is to say, in Approximation 2), we are essentially using the filtering distribution _⃗_ 

- _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _t_ ) to approximate the smoothing dis- _⃗_ 

- tribution _p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _T_ ). While this approximation may introduce some estimation loss, it remains reasonable when the observation series is sufficiently long, such that additional future observations do not significantly alter the state estimates. On the other hand, given our priority on computational efficiency, a minor loss in accuracy is acceptable and often necessary as part of this trade-off. 

We next proceed to outline the evaluation of the log- _⃗_ likelihood, log _p_ ( **y** _t|_ **u** _,_ **y** 1: _t−_ 1) in Eq. (23) using the EnKF. which allows us to evaluate the log-likelihood recursively and analytically. 

Building upon the EnKF outlined in Section IV-A and assuming that we have acquired the posterior distribution, _p_ ( **x** _t−_ 1 _|⃗_ **u** _,_ **y** 1: _t−_ 1) = _N_ ( **x** _t−_ 1 _|_ **m** _t−_ 1 _,_ **P** _t−_ 1), at time _t −_ 1, we can employ the GP transition, presented in Eq. (18), to perform the prediction step and generate _N_ predicted samples **x** ¯[1:] _t[N]_ , i.e., 

**==> picture [206 x 11] intentionally omitted <==**

where **x**[1:] _t−[N]_ 1[are] _[N]_[particles][obtained][from] _[p]_[(] **[x]** _[t][−]_[1] _[|][⃗]_ **[u]** _[,]_ **[ y]**[1:] _[t][−]_[1][)] with equal weights. With the predicted samples **x** ¯[1:] _t[N]_ , we thus can approximate the prediction distribution as a Gaussian: 

**==> picture [247 x 37] intentionally omitted <==**

where **m** ¯ _t_ and **P**[¯] _t_ can be computed using Eq. (11). 

Similarly, during the update step, utilizing Eqs. (13) and 

(14), we can derive the filtering distribution at time step _t_ , 

**==> picture [189 x 11] intentionally omitted <==**

and obtain the set of _N_ updated samples **x**[1:] _t[N]_ . We can then recursively obtain the samples and posterior distributions in the subsequent time steps. Note that in the context of GPSSMs, 

7 

**Algorithm 1** EnKF-aided variational learning and inference 

**Input** : _**θ**_ = _{_ _**θ** gp,_ **Q** _,_ **R** _},_ _**ζ** ,_ **y** 1: _T_ , **x**[1:] 0 _[N] ∼ q_ ( _x_ 0) 

## 1: **while** _iterations not terminated_ **do** 

- _⃗ ⃗_ 

- 2: **u** _∼ q_ ( **u** ), _Lℓ_ = 0 3: **for** _t_ = 1 _,_ 2 _, . . . , T_ **do** 4: Get prediction samples using Eq. (24) 5: Get empirical moments **m** ¯ _t,_ **P**[¯] _t_ using Eq. (25) 6: Get Kalman gain: **G**[¯] _t_ = **P**[¯] _t_ _**C**[⊤]_ ( _**C**_ **P**[¯] _t_ _**C**[⊤]_ + **R** ) _[−]_[1] 7: Get updated samples using Eq. (14) 8: Evaluate the log-likelihood using Eq. (27), and 

**==> picture [124 x 11] intentionally omitted <==**

9: **end for** 10: _L_ = _Lℓ −_ KL( _q_ ( **x** 0) _∥p_ ( **x** 0)) _−_ KL( _q_ ( _⃗_ **u** ) _∥p_ ( _⃗_ **u** )) 11: Maximize _L_ and update _**θ**_ , _**ζ**_ using Adam [54] 12: **end while Output** : EnKF particles **x**[1:] 0: _[N] T_[,][model][parameters] _**[θ]**_[,][and] variational parameters _**ζ**_ . 

each step (indicated by the first term); simultaneously, the KL regularization terms impose constraints to prevent model overfitting (indicated by the second and third terms). 

**Remark 3.** _The computational complexity of the EnVI algorithm predominantly lies in the evaluation of N independent particles on the GP transition during the prediction step (see Eq._ (24) _). Recall that the number of inducing points is significantly smaller than the length of the data sequence, i.e., M ≪ T , and assume that M ≥ dx. In this context, the computational complexity of Algorithm 1 scales as O_ ( _NTdxM_[2] ) _. In practice, N is often a small number, and the computation of the N particles on the GP transition can be run in parallel [48], resulting in the computational complexity in real-world deployments scaling as O_ ( _TdxM_[2] ) _. This cost matches that of existing works. Yet, the streamlined model complexity in EnVI enhances its computational robustness and accelerates convergence compared to the existing works._ 

## _C. More Discussions and Insights_ 

both the prediction and update steps are conditioned on the inducing points, _{⃗_ **u** _,⃗_ **z** _}_ , which act as a surrogate for the transition function. 

Leveraging the EnKF outlined above, the log-likelihood, _⃗_ log _p_ ( **y** _t|_ **u** _,_ **y** 1: _t−_ 1) in Eq. (23), can be evaluated recursively and analytically. Specifically, at each time step _t_ , we have 

**==> picture [247 x 38] intentionally omitted <==**

due to the Gaussian prediction distribution, see Eq. (25), and the linear emission model. 

Now we can evaluate our approximate variational lower bound, _L_ in Eq. (23). We first utilize the reparameterization trick (see also e.g. Eq. (15)) [46] to sample _⃗_ **u** , i.e., 

**==> picture [188 x 13] intentionally omitted <==**

and numerically get an unbiased evaluation of the expected _T_ log-likelihood, E _q_ ( _⃗_ **u** )�� _t_ =1[log] _[ p]_[(] **[y]** _[t][|][⃗]_ **[u]** _[,]_ **[ y]**[1:] _[t][−]_[1][)] �. Due to the reparameterization trick [46], _L_ is differentiable w.r.t. the model parameters _**θ**_ = _{_ _**θ** gp,_ **Q** _,_ **R** _}_ and the variational parameters _**ζ**_ = _{_ **m** 0 _,_ **L** 0 _,_ **m** _,_ **S** _,⃗_ **z** _}_ . Therefore, we can use modern differentiation tools, such as PyTorch, to automatically compute the gradient through backpropagation through time (BPTT) and apply gradient-based methods (e.g., Adam) to maximize _L_ [48], [54]. Detailed routine for implementing the EnKF-aided variational learning and inference algorithm, termed as EnVI, is summarized in Algorithm 1. 

It is noteworthy that the newly derived ELBO, _L_ circumvents the explicit evaluation of the first and fourth terms in Eq. (22), and sidesteps the computational challenges posed _⃗_ by the heavy parameterization of _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1). Consequently, EnVI can substantially improve the efficiency of model learning and inference. In addition, maximizing the ELBO in Eq. (23) can be interpreted as follows: The objective is to optimize the model parameters and variational parameters such that the GPSSM can fit the observed data well at 

This subsection presents more detailed insights into the proposed EnVI and discusses its connections to existing works. 

First of all, the importance of the differentiable nature within EnKF, as mentioned in Remark 2, to the EnVI becomes more apparent. The inherent differentiability in EnVI, spanning from parameters ( _{_ _**θ** ,_ _**ζ** }_ ) to latent states and extending to the objective function (the ELBO), enables principled joint learning and inference using modern off-the-shelf automatic differentiation tools (e.g., PyTorch [48]). This contrasts with most existing EnKF-based dynamical systems learning methods (see, e.g., [55], [56] and the references therein), which employ the expectation-maximization (EM) algorithm [17] to iteratively update the model parameters _**θ**_ and latent state trajectory _⃗_ **x** . It has been reported that such EM-based methods disregard the gradient information from the parameters _**θ**_ to the state trajectory _⃗_ **x** , which can potentially degrade the learning performance [51], [57]. In contrast, by regarding the latent state trajectory as a function of both the model parameters _**θ**_ and variational parameters _**ζ**_ , our method can jointly optimize these parameters in a principled way, resulting in enhanced performance. 

Second, it is worth noting that the proposed EnVI algorithm falls under the NMF category (see definition in Appendix C), given the exploitation of the dependencies between latent states and the transition function, as evident in the filtering distribution, _p_ ( **x** _t|⃗_ **u** _,_ **y** 1: _t_ ) in Eq. (26). This indicates that EnVI inherits the favorable characteristics of NMF algorithms [29], which have the potential to enhance learning accuracy and address the issue of underestimating state inference uncertainty, commonly encountered in MF algorithms [35]. 

Last but not least, our method offers an effective means of mitigating the risk of overfitting. This is mainly due to the fact that our method leverages the Bayesian nonparametric model and the variational inference framework to derive the ELBO, as presented in Eq. (23), from which the additional regularization terms for the initial state and state transition function can effectively mitigate the overfitting issue. As a comparison, in the state-of-the-art EnKF-based 

8 

## **Algorithm 2** OEnVI: Online EnVI (Step _t_ ) 

**Input** : _**θ**_ = _{_ _**θ** gp,_ **Q** _,_ **R** _},_ _**ζ** ,_ **y** _t_ , **x**[1:] _t−[N]_ 1 

## 1: **while** _iterations not terminated_ **do** 

- _⃗ ⃗_ 

- 2: **u** _∼ q_ ( **u** ), _Lℓt_ = 0 

- 3: Get prediction samples using Eq. (24) 4: Get empirical moments **m** ¯ _t,_ **P**[¯] _t_ using Eq. (25) 5: Get Kalman gain: **G**[¯] _t_ = **P**[¯] _t_ _**C**[⊤]_ ( _**C**_ **P**[¯] _t_ _**C**[⊤]_ + **R** ) _[−]_[1] 6: Get updated samples using Eq. (14) 

- 7: Evaluate the objective function 

**==> picture [182 x 11] intentionally omitted <==**

- 8: Maximize _Lℓt_ and update _**θ**_ , _**ζ**_ using Adam [54] 9: **end while** 

**Output** : EnKF particles **x**[1:] _t[N]_ , model parameters _**θ**_ , and variational parameters _**ζ**_ . 

_⃗_ **Proposition 2.** _The log-likelihood,_ log _p_ ( **y** _t|_ **u** _,_ **y** 1: _t−_ 1) _, essentially is the difference between the data reconstruction error, represented by_ E _p_ ( **x** _t|⃗_ **u** _,_ **y** 1: _t_ ) [log _p_ ( **y** _t|_ **x** _t_ )] _, and the KL divergence between the filtering distribution p_ ( **x** _t|⃗_ **u** _,_ **y** 1: _t_ ) _and ⃗ the prediction distribution p_ ( **x** _t|_ **u** _,_ **y** 1: _t−_ 1) _. That is,_ 

**==> picture [246 x 35] intentionally omitted <==**

_Thus, an alternative objective function for OEnVI can be expressed as_ 

**==> picture [238 x 42] intentionally omitted <==**

## _Proof._ The proof can be found in Appendix B 

dynamical system learning method, autodifferentiable EnKF (AD-EnKF) [51], [55], the transition function in the SSM is modeled using a deterministic parametric model, specifically a neural network, and the optimization objective function is the logarithm of marginal likelihood of the model, i.e. 

**==> picture [232 x 30] intentionally omitted <==**

Maximizing this objective function solely w.r.t. the model parameters can easily lead to overfitting. We defer further discussions of this issue to Section VI. 

## V. OENVI: ONLINE IMPLEMENTATION OF ENVI 

In this section, we further explore online setting where data is processed sequentially, one sample at a time. It is within this context that the simultaneous inference of states and nonlinear dynamics in GPSSMs presents significant challenges [58]– [60]. The good news is that our EnVI algorithm readily lends itself to online learning scenarios. Specifically, at each time step _t_ , we can naturally maximize the corresponding objective function, denoted as _Lℓt_ , given by 

**==> picture [242 x 12] intentionally omitted <==**

in terms of both the model parameters and variational parameters. Detailed steps for implementing the online EnVI, termed OEnVI, are summarized in Algorithm 2. It is worth noting that this algorithm is designed for learning a time-invariant dynamical system, as defined in Section II-B. 

**Remark 4.** _Analogous to EnVI, the computational complexity of OEnVI scales as O_ ( _dxM_[2] ) _under practical parallel computing environments._ 

An interesting insight for maximizing the objective function of OEnVI in Eq. (30) (as well as the objective function of EnVI in Eq. (23)) is that it essentially encourages successful data reconstruction while simultaneously ensuring that the filtering distribution _p_ ( **x** _t|⃗_ **u** _,_ **y** 1: _t_ ) and the prediction distribution _⃗ p_ ( **x** _t|_ **u** _,_ **y** 1: _t−_ 1) do not deviate too far from each other, apart from the regularization of _q_ ( _⃗_ **u** ). This result is supported by the following proposition. 

This insight sheds light on the interplay between data reconstruction and the alignment of filtering and prediction distributions in the EnVI and OEnVI algorithms. 

Up to this point, it is worth noting that in contrast to the existing inference network-based variational algorithms [28]– [31], [38], [44], [59], [60], OEnVI is a simple and straightforward extension of EnVI, which benefits from eliminating the dependence on the additional parametric variational distributions. Previous works have typically employed inference networks that take the entire sequence of observations **y** 1: _T_ as input, necessitating a significant amount of data for offline training. While it is conceivable to constrain the input length of the inference network to a shorter sequence _l_ , such as **y** _t−l_ : _t_ , this approach still leads to prolonged training times and higher computational requirements for optimizing the inference network parameters [60]. Moreover, storing historical inputs **y** _t−l_ : _t_ adds to the storage overhead, making it problematic in situations where historical data duplication and storage are not permissible. In sharp contrast, OEnVI successfully overcomes the aforementioned challenges related to the optimization of inference networks. As a result, it facilitates more efficient learning and inference processes, contributing to potential improved overall performance. Furthermore, OEnVI offers a principled objective, see Eq. (32), by simultaneously minimizing the KL divergence, accounting for data reconstruction error balance, and applying regularization to the transition function to mitigate model overfitting. 

## VI. EXPERIMENTS AND RESULTS 

This section presents a comprehensive numerical study of the proposed EnVI and OEnVI. Section VI-A showcases the filtering performance. In Section VI-B, we present the system dynamics learning performance. The series forecasting performance of EnVI on various real datasets is illustrated in Section VI-C. Finally, Section VI-D provides a comprehensive demonstration of the performance of the OEnVI online algorithm. More details regarding the experimental setup can be found in supplementary material [37], and the accompanying source code is publicly available online[2] . 

2https://github.com/zhidilin/gpssmProj 

9 

**==> picture [494 x 240] intentionally omitted <==**

**----- Start of picture text -----**<br>
Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>0 6 2<br>20 5 4 0<br>10 10 2 2<br>15 0 4<br>0 20<br>0 50 100 0 50 100 0 50 100 0 50 100<br>t t t t<br>obsers. states KF ±2  (KF) EnVI ±2  (EnVI)<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>0 6 2<br>20 5 4 0<br>10 10 2 2<br>15 0 4<br>0 20 2 6<br>0 50 100 0 50 100 0 50 100 0 50 100<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>**----- End of picture text -----**<br>


Fig. 2. EnVI ( **top** ) & OEnVI ( **bottom** ) on state inference in linear Gaussian SSM. The RMSE of the latent state estimates for KF, EnVI, and OEnVI are 0.5252, 0.6841, and 0.7784, respectively; the RMSE between the observations and the latent states is 0.9872. 

## _A. Learning and Inference in Linear Gaussian SSMs_ 

We investigate the learning and inference capacity of EnVI and OEnVI, by using a linear Gaussian state-space model (LGSSM) where exact inference of latent state is applicable (i.e. KF). Specifically, we use the following LGSSM, a car tracking example given in the textbook [1], to generate observation data, **y** 1: _T_ , for training EnVI and OEnVI, 

**==> picture [229 x 26] intentionally omitted <==**

where the state and the observation are both four dimensional, and _**C**_ = _**I**_ 4 _×_ 4 _,_ **R** = _σ_ R[2] _**[I]**_[4] _[×]_[4][with] _[σ]_[R][= 0] _[.]_[5][;] 

**==> picture [213 x 123] intentionally omitted <==**

and 

with ∆ _t_ = 0 _._ 1 _, q_ 1[c][=] _[ q]_ 2[c][= 1][.] We begin by generating _T_ = 120 training observations. For EnVI, we employ 1000 epochs/iterations for training, but convergence is typically achieved approximately 300 iterations. In OEnVI, the parameters _**θ**_ and _**ζ**_ are updated once per time step _t_ . Both EnVI and OEnVI employ 15 inducing points, a setting that will be used for subsequent experiments unless otherwise specified. We report the state inference results, which are depicted in Fig. 2. It can be observed that the state inference performance of EnVI and OEnVI is comparable to that of the KF in terms of state-fitting root mean square error (RMSE), 

despite being trained solely on noisy observations without any physical model knowledge. 

Another finding is that though OEnVI incurs a lower training cost compared to EnVI, this advantage comes at the expense of inadequate learning of the latent dynamics, leading to a less accurate estimation of the latent states when compared to EnVI. The discrepancy is evident in Fig. 2, where OEnVI exhibits larger estimation RMSE and greater estimation uncertainty for the latent states in comparison to EnVI and KF. Notably, EnVI relies on offline training, resulting in an uncertainty quantification that closely approaches the optimal estimate, the KF estimate. Nevertheless, it is essential to mention that, with continuous online data arrival, OEnVI can eventually achieve a comparable state estimation performance as EnVI. We observed that after observing 360 data points, OEnVI achieves a latent state RMSE estimation of 0 _._ 6512. Further details on this aspect of the results are provided in Supplement B-A, where we also show and discuss the inference performance under different emission coefficient matrices _**C**_ . 

## _B. System Dynamics Learning_ 

This subsection demonstrates the superior capability of EnVI in learning latent dynamics for GPSSMs. To evaluate its performance, we utilize a 1-D synthetic dataset called the _kink_ function dataset, which is generated from a dynamical system described by Eq. (36), where the nonlinear, smooth and time-invariant function _f_ ( **x** _t_ ) is called the “kink” function, 

**==> picture [245 x 58] intentionally omitted <==**

10 

TABLE I 

COMPARISON OF OUR METHOD WITH OTHER COMPETITORS ON THE KINK FUNCTION DATASET. SHOWN ARE MEAN AND STANDARD ERRORS OVER FIVE REPETITIONS OF THE **FITTING MSE (LOWER IS BETTER)** AND THE **LOG-DENSITY (HIGHER IS BETTER)** OF THE KINK FUNCTION VARYING THE EMISSION NOISE VARIANCE _σ_ R[2][.] 

**==> picture [512 x 257] intentionally omitted <==**

**----- Start of picture text -----**<br>
Method σ R [2] [= 0] [.] [008] [(MSE] [|] [Log-Likelihood)] σ R [2] [= 0] [.] [08] [(MSE] [|] [Log-Likelihood)] σ R [2] [= 0] [.] [8] [(MSE] [|] [Log-Likelihood)]<br>vGPSSM [28] 1 . 0410 ± 0 . 7426  |− 27 . 5981 ± 19 . 7817 1 . 6390 ± 0 . 6783  |− 30 . 9557 ± 16 . 9218 1 . 9584 ± 0 . 9655  |− 56 . 5997 ± 37 . 8221<br>VCDT [30] 0 . 2057 ± 0 . 2219  |− 1 . 058 ± 1 . 5005 0 . 1934 ± 0 . 0140  |− 0 . 5867 ± 0 . 2610 1 . 4035 ± 0 . 6470  |− 3 . 8092 ± 0 . 6588<br>AD-EnKF [51] 0 . 0285 ± 0 . 0318  |− 3 . 6282 ± 6 . 3514 1 . 5246 ± 0 . 9734  |− 242 . 2795 ± 194 . 6741 1 . 3489 ± 0 . 3102  |− 267 . 7068 ± 62 . 0488<br>EnVI (ours) 0 . 0046 ± 0 . 0025  |  1 . 1060 ± 0 . 0381 0 . 0536 ± 0 . 0232  |  0 . 1025 ± 0 . 1075 0 . 5315 ± 0 . 1542  | − 1 . 0439 ± 0 . 1714<br>1 1 1 1 1 1<br>0 0 0 0 0 0<br>1 1 1 1 1 1<br>2 2 2 2 2 2<br>3 inducing points"kink" function 3 3 3 inducing points"kink" function 3 3<br>GP mean GP mean<br>4 ±2 4 4 4 ±2 4 4<br>3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1<br>(a) vGPSSM (b) VCDT<br>1 1 1 1 1 1<br>0 0 0 0 0 0<br>1 1 1 1 1 1<br>2 2 2 2 2 2<br>3 "kink" function 3 3 3 3 3 inducing points"kink" function<br>neural dynamic GP mean<br>4 ±2 4 4 4 4 4 ±2<br>3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1 3 2 1 0 1<br>(c) AD-EnKF (d) EnVI<br>**----- End of picture text -----**<br>


Fig. 3. Kink transition function learning performance (mean _±_ 2 _σ_ ) using various methods across different levels of emission noise ( _σ_ R[2] _[∈{]_[0] _[.]_[008] _[,]_[ 0] _[.]_[08] _[,]_[ 0] _[.]_[8] _[}]_[,] from left to right). 

It is worth mentioning that this specific dynamical system has been extensively employed in GPSSM literature to evaluate the accuracy of the learned GP transition posterior [32]. 

In showcasing the superior performance of EnVI, we compare it against several prominent competing methods, namely vGPSSM [28], VCDT [30], and AD-EnKF [51]. Our implementation of VCDT incorporates an inference network to address the linear growth in the number of variational parameters. The vGPSSM method adheres to the original paper’s implementation [28], while the AD-EnKF is utilized as per the default software package available online[3] . The training data sequences are generated by fixing _σ_ Q[2][at 0.05 and] systematically vary _σ_ R[2][within][the][range][of] _[{]_[0] _[.]_[008] _[,]_[ 0] _[.]_[08] _[,]_[ 0] _[.]_[8] _[}]_[.] As a result, we generate three sets of _T_ = 600 observations each for training. To ensure a fair comparison in the latent space, we adhere to Ialongo _et al_ . [30] and keep the emission model fixed to the true generative ones for all methods, while allowing the transition to be learned. Further details, including the description of the setup for the aforementioned algorithms, are provided in Supplement B-B and the accompanying source code. The result is depicted in Table I and visualized in Fig. 3. We observe that EnVI consistently excels in system dynamic learning and exhibits superior learning robustness compared to existing methods. We next conduct two ablation studies. 

_**EnVI**_ **vs.** _**Inference Network-Based Methods**_ . Based on the numerical results presented in Table I, we can find that the EnVI exhibits superior dynamic learning performance 

compared to vGPSSM and VCDT, both of which rely on an inference network. Specifically, as illustrated in Fig. 3, vGPSSM faces more challenges in dynamic learning, while VCDT, categorized under the NMF paradigm, only performs well under more minor noise conditions ( _σ_ R[2][=][0] _[.]_[008][and] _σ_ R[2][=][0] _[.]_[08][).][In][contrast,][EnVI][effectively][learns][the][GP] transition well, even in the high noise setting with _σ_ R[2][= 0] _[.]_[8][.] 

The primary reason for this discrepancy is the increased model and computational complexity arising from additional inference network parameters, which hinder effective training. Furthermore, the inference network-based methods are prone to convergence into various unfavorable local optima, demonstrating reduced robustness. As a consequence, the learning performance of such methods often fluctuates significantly, see Table I. In contrast, EnVI inherits the benefits of EnKF and avoids the need to optimize additional variational parameters from the inference network, making it more amenable to optimization and demonstrating enhanced robustness. 

Our experimental findings consistently demonstrate that EnVI exhibits rapid convergence compared to vGPSSM and VCDT, owing to its streamlined parameterization. For instance, as shown in Fig. 4, when considering _σ_ R[2][=][0] _[.]_[008][,] EnVI achieves convergence after 300 iterations, whereas both vGPSSM and VCDT require many more iterations. Moreover, EnVI also exhibits a noticeable reduction in piratical runtime per iteration compared to the two competitors, which need to optimize additional inference network parameters. This underscores the efficiency improvement brought by streamlining the inference process using EnKF. 

3https://github.com/ymchen0/torchEnKF 

11 

**==> picture [516 x 151] intentionally omitted <==**

**----- Start of picture text -----**<br>
3.0 vGPSSM vGPSSM<br>VCDT VCDT<br>2.5 EnVI 2000 EnVI<br>2.0 1500<br>1.5<br>1000<br>1.0<br>500<br>0.5<br>0.0 0<br>0 1000 2000 3000 4000 5000 0 1000 2000 3000 4000 5000<br>iteration iteration<br>MSE<br>Time (second)<br>**----- End of picture text -----**<br>


Fig. 4. Kink function learning performance against the training iterations. EnVI exhibits rapid convergence compared to vGPSSM and VCDT. 

_**EnVI**_ **vs.** _**AD-EnKF**_ . The primary difference between EnVI and AD-EnKF lies in their data-driven modules. AD-EnKF employs a parametric model, specifically a neural network (so it is also known as a deep SSM (DSSM)), while EnVI utilizes a non-parametric GP. Consequently, the dynamics learned by AD-EnKF exhibit a tendency to be over-confident, as depicted in Fig. 3, as it does not account for uncertainties from the learned transition function. Moreover, the absence of regularization during the training of the neural network in ADEnKF (as indicated in Eq. (29)) renders the method susceptible to overfitting and being trapped in suboptimal solutions during the training process. As a result, the performance of different repetitions can vary significantly, as shown in Table I. 

## _C. Time Series Data Forecasting_ 

This subsection further demonstrates the series prediction performance of the proposed EnVI algorithm on five public real-world system identification datasets[4] , which consist of one-dimensional time series of varying lengths between 296 to 1024 data points. In addition to the comparison methods discussed in Section VI-B, EnVI is also compared with several other competitors, including two NMF class methods, PRSSM [29], ODGPSSM [39], and two inference networkbased methods, DKF [44] and CO-GPSSM [38], as depicted in Table II. For each method, the first half of the sequence in every dataset is utilized as training data, with the remaining portion designated for testing. Standardization of all datasets is conducted based on the training sequence, and the latent state dimension, _dx_ , is consistently set to 4 for all datasets. Table II reports the series prediction results, wherein the RMSE is averaged over 50-step ahead forecasting. 

Table II reveals that EnVI outperforms almost all methods across the five datasets. Specifically, EnVI demonstrates superior performance among the MF and NMF methods. Compared to PRSSM and ODGPSSM [29], [39], which assume equality between variational and prior distributions of latent states, EnVI employs EnKF to filter latent states, leading to an enhanced system dynamics learning performance, and consequently, improving the series predictions. Compared to the inference network-based methods, like VCDT [30] and the 

MF class methods vGPSSM [28] and CO-GPSSM [38], EnVI eliminates the need to optimize inference network parameters. From an optimization solution perspective, optimizing the inference network leads to a vast solution space for the variational distribution. Consequently, despite their adequate approximation capabilities for the true posterior distribution, these inference network-based methods often fall short of realizing their theoretical potential in empirical performance due to numerous bad local optimums [32]. In contrast, EnVI imposes model-based constraints on the variational distribution by the EnKF, narrowing the solution space and yielding significantly improved and robust empirical performance. 

Compared to the DSSM methods, EnVI offers performance advantages due to its non-parametric GP model. In contrast to DKF [44], which utilizes neural networks to model variational distributions and nonlinear SSMs, EnVI employs GPs with much less model parameters, making it particularly suitable for small datasets. While AD-EnKF [51] outperforms DKF, its deterministic neural network modeling approach and the absence of regularization in its objective function cause it to lag behind EnVI in forecasting performance. 

## _D. Online Learning and Inference Using OEnVI_ 

We next evaluate the performance of OEnVI. We compare OEnVI with two very recent competitive online learning algorithms, specifically SVMC [59], which models the variational distribution of latent states using sample particles, and VJF [60], where the variational distribution of latent states is modeled by an inference network. More numerical results of OEnVI about learning kink dynamical function can be found in Supplement B-D. 

We evaluate the three online learning methods using NASCAR[®] data, a dataset previously utilized in [59], showcasing dynamics akin to recurrent switching linear dynamical systems [61]. The latent state trajectory faithfully reproduces the layout of a NASCAR[®] track, as depicted in Fig. 5a. We train these three methods with 2000 observations and test them with 500 observations, both generated from **y** _t_ = _**C**_ **x** _t_ + **e** _t_ , where _**C**_ is a 10-by-2 matrix generated randomly (strictly following the settings of SVMC [59]), and **e** _t ∼N_ ( **0** _,_ 0 _._ 1[2] _**I**_ 2 _×_ 2). 

4https://homes.esat.kuleuven.be/ _∼_ smc/daisy/daisydata.html 

12 

TABLE II 

PREDICTION PERFORMANCE (RMSE) OF THE DIFFERENT MODELS ON THE SYSTEM IDENTIFICATION DATASETS. MEAN AND STANDARD DEVIATION OF THE PREDICTION RESULTS ARE SHOWN ACROSS FIVE SEEDS. THE LOWEST RMSE IS HIGHLIGHTED IN BOLD. 

|Category|Method|Actuator|Ball Beam|Drive|Dryer|Gas Furnace|
|---|---|---|---|---|---|---|
|DSSMs|**DKF** [44]<br>**AD-EnKF** [51]|1_._204_±_0_._250<br>0_._705_±_0_._117|0_._144_±_0_._005<br>0_._057_±_0_._006|0_._735_±_0_._001<br>0_._756_±_0_._114|1_._465_±_0_._087<br>0_._182_±_0_._053|5_._589_±_0_._066<br>1_._408_±_0_._090|
|MF-based|**vGPSSM** [28]|1_._640_±_0_._011|0_._268_±_0_._414|0_._740_±_0_._010|0_._822_±_0_._002|3_._676_±_0_._145|
|Methods|**CO-GPSSM** [38]|0_._803_±_0_._011|0_._079_±_0_._018|0_._736_±_0_._007|0_._366_±_0_._146|1_._898_±_0_._157|
||**PRSSM** [29]|0_._691_±_0_._148|0_._074_±_0_._010|**0****_._647**_±_**0****_._057**|0_._174_±_0_._013|1_._503_±_0_._196|
|NMF-based|**ODGPSSM** [39]|0_._666_±_0_._074|0_._068_±_0_._006|0_._708_±_0_._052|0_._171_±_0_._011|1_._704_±_0_._560|
|Methods|**VCDT** [30]|0_._815_±_0_._012|0_._065_±_0_._005|0_._735_±_0_._005|0_._667_±_0_._266|2_._052_±_0_._163|
||**EnVI** (ours)|**0****_._657**_±_**0****_._095**|**0****_._055**_±_**0****_._002**|0_._703_±_0_._050|**0****_._125**_±_**0****_._017**|**1****_._388**_±_**0****_._123**|



**==> picture [517 x 140] intentionally omitted <==**

**----- Start of picture text -----**<br>
8 8 8<br>True<br>Inferred<br>6 6 6<br>4 4 4<br>2 2 2<br>0 0 0<br>2 2 2<br>4 4 4<br>6 6 6<br>8 8 8<br>10.0 7.5 5.0 2.5 0.0 2.5 5.0 7.5 10.0 10.0 7.5 5.0 2.5 0.0 2.5 5.0 7.5 10.0 10.0 7.5 5.0 2.5 0.0 2.5 5.0 7.5 10.0<br>(a) True and inferred latent trajectory using OEnVI (b) True and inferred latent trajectory using SVMC (c) True and inferred latent trajectory using VJF<br>**----- End of picture text -----**<br>


**==> picture [517 x 139] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 10 10<br>5 5 5<br>0 0 0<br>5 5 5<br>10 10 10<br>1600 1800 2000 2200 2400 1600 1800 2000 2200 2400 1600 1800 2000 2200 2400<br>true true true<br>5 filteredpredicted 5 filteredpredicted 5 filteredpredicted<br>0 0 0<br>5 5 5<br>1600 1800 2000 2200 2400 1600 1800 2000 2200 2400 1600 1800 2000 2200 2400<br>t t t<br>(d) Filtering and prediction using OEnVI (ours) (e) Filtering and prediction using SVMC [59] (f) Filtering and prediction using VJF [60]<br>x1 x1 x1<br>x2 x2 x2<br>**----- End of picture text -----**<br>


Fig. 5. Online NASCAR[®] dynamics learning results of the three online algorithms. The prediction RMSE values for OEnVI, SVMC, and VJF are 1.8780, 4.6682, and 10.8499, respectively. 

The SVMC and VJF algorithms are implemented using the code publicly provided online[56] . 

Figs. 5a–5c depict the true states (in blue) and the latent states (in red) inferred by the three methods. The results clearly indicate that EnVI and SVMC swiftly captured the real state and maintained accuracy, while VJF faced challenges, primarily due to its difficulty in optimizing the parameters in the inference network. The detailed comparison with SVMC and VJF, illustrated in Figs. 5d–5f, highlights the superior accuracy of OEnVI in both inference and prediction of latent states. These empirical findings emphasize the efficacy of OEnVI, particularly in its use of EnKF to approximate the variational distribution, demonstrating its advancement over VJF using inference networks, and SVMC using PF methods. 

> 6https://github.com/catniplab/vjf 

## VII. CONCLUSION 

In this paper, we have introduced EnVI, a novel NMF algorithm tailored for GPSSMs, which integrates EnKF into a variational inference framework. Additionally, we have presented an extended online version, OEnVI. Both algorithms eliminate the necessity for heavy parameterization like inference networks and shape the variational distribution over latent states through the model-based EnKF. Leveraging the inherent differentiable nature along with the modern automatic differentiation tools, the proposed EnVI and OEnVI can enhance efficiency and algorithmic robustness while improving learning and inference performance compared to existing methods. Detailed analysis and fresh insights for the proposed algorithms are provided to enhance their interpretability. Empirical experiments conducted on diverse real and synthetic datasets, evaluating filtering, prediction, and dynamics learning performance, unequivocally support the effectiveness of 

5https://github.com/catniplab/svmc 

13 

the proposed methods. Future research will explore efficient learning and inference techniques for complex time-varying dynamical systems. 

## APPENDIX A 

**==> picture [213 x 8] intentionally omitted <==**

With the model joint distribution, Eq. (17), and the variational distribution, Eq. (20), we can write down the ELBO according to the general definition given in Eq. (7), i.e., 

**==> picture [242 x 162] intentionally omitted <==**

where the KL divergence terms can be analytically computed in closed form [17] due to the Gaussian nature of the prior and variational distributions. The evaluation of the first and fourth terms is typically intractable. We examine the difference between term 1 and term 4 in Eq. (37) and can have the following lemma. 

**Lemma 1.** _Under the approximations that: ⃗ ⃗_ 1) _p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t−_ 1) _≈ p_ ( **x** _t−_ 1 _|_ **u** _,_ **y** 1: _t_ ) _, ⃗ ⃗_ 2) _q_ ( **x** _t|_ **u** _,_ **x** _t−_ 1) _≈ p_ ( **x** _t|_ **u** _,_ **x** _t−_ 1 _,_ **y** 1: _t_ ) _,_ 

_computing the difference between term 1 and term 4 in the ELBO (Eq._ (37) _) yields the expected log-likelihood, i.e.,_ 

**==> picture [210 x 12] intentionally omitted <==**

_Proof._ According to the ELBO given in Eq. (37), we have: term 1 _−_ term 4 

**==> picture [250 x 185] intentionally omitted <==**

where the last line of Eq. (39) is derived straightforwardly by applying Bayes’ theorem. 

According to Lemma 1, and the ELBO given in Eq. (37), we immediately get the following approximated ELBO: 

**==> picture [249 x 45] intentionally omitted <==**

_⃗_ where the log-likelihood, log _p_ ( **y** _t|_ **u** _,_ **y** 1: _t−_ 1) in Eq. (40) can be analytically evaluated using EnKF, see Eq. (27), due to the Gaussian prediction distribution, see Eq. (25), and the linear emission model. 

## APPENDIX B 

**==> picture [111 x 8] intentionally omitted <==**

_Proof._ With the filtering distribution _p_ ( **x** _t|⃗_ **u** _,_ **y** 1: _t_ ), we have the log-likelihood term 

**==> picture [230 x 11] intentionally omitted <==**

**==> picture [233 x 66] intentionally omitted <==**

**==> picture [161 x 11] intentionally omitted <==**

**==> picture [220 x 12] intentionally omitted <==**

which completes the proof. Here Eq. (42c) is obtained straightforwardly by applying Bayes’ theorem. This result sheds light on the interplay between data reconstruction and the alignment of filtering and prediction distributions in the EnVI and OEnVI algorithms. 

## APPENDIX C 

**==> picture [243 x 8] intentionally omitted <==**

**Definition 1.** _If the variational distribution, q_ ( _[⃗]_ **f** _, ⃗_ **u** _,⃗_ **x** ) _, is factorized such that the transition function values and the latent states are independent, i.e.,_ 

**==> picture [208 x 30] intentionally omitted <==**

_the factorization is known as a mean-field approximation in the GPSSM literature. Conversely, if the variational distribution, q_ ( _⃗_ **x** _,[⃗]_ **f** _, ⃗_ **u** ) _, explicitly builds the dependence between the latent states and the transition function values, as shown in Eq. (8), it is a non-mean-field approximation._ 

## REFERENCES 

- [1] S. S¨arkk¨a, _Bayesian filtering and smoothing_ . Cambridge University Press, 2013, no. 3. 

- [2] A. Kullberg, I. Skog, and G. Hendeby, “Online joint state inference and learning of partially unknown state-space models,” _IEEE Trans. Signal Process._ , vol. 69, pp. 4149–4161, 2021. 

- [3] U. A. Khan and J. M. Moura, “Distributing the Kalman filter for largescale systems,” _IEEE Trans. Signal Process._ , vol. 56, no. 10, pp. 4919– 4935, 2008. 

- [4] F. Tobar, P. M. Djuri´c, and D. P. Mandic, “Unsupervised state-space modeling using reproducing kernels,” _IEEE Trans. Signal Process._ , vol. 63, no. 19, pp. 5210–5221, 2015. 

14 

- [5] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, “KalmanNet: Neural network aided Kalman filtering for partially known dynamics,” _IEEE Trans. Signal Process._ , vol. 70, pp. 1532–1547, 2022. 

- [6] Z. Yan, P. Cheng, Z. Chen, Y. Li, and B. Vucetic, “Gaussian process reinforcement learning for fast opportunistic spectrum access,” _IEEE Trans. Signal Process._ , vol. 68, pp. 2613–2628, 2020. 

- [7] A. M. Alaa and M. van der Schaar, “Attentive state-space modeling of disease progression,” in _Proc. Adv. Neural Inf. Process. Syst. (NeurIPS)_ , 2019, pp. 11 338–11 348. 

- [8] R. Frigola, F. Lindsten, T. B. Sch¨on, and C. E. Rasmussen, “Bayesian inference and learning in Gaussian process state-space models with particle MCMC,” in _Proc. Adv. Neural Inf. Process. Syst. (NeurIPS)_ , 2013, pp. 3156–3164. 

- [9] C. E. Rasmussen and C. K. I. Williams, _Gaussian Processes for Machine Learning_ . MIT Press, 2006. 

- [10] Y. Zhao, C. Fritsche, G. Hendeby, F. Yin, T. Chen, and F. Gunnarsson, “Cram´er–Rao bounds for filtering based on Gaussian process state-space models,” _IEEE Trans. Signal Process._ , vol. 67, no. 23, pp. 5936–5951, 2019. 

- [11] F. Yin, L. Pan, T. Chen, S. Theodoridis, Z.-Q. T. Luo, and A. M. Zoubir, “Linear multiple low-rank kernel based stationary Gaussian processes regression for time series,” _IEEE Trans. Signal Process._ , vol. 68, pp. 5260–5275, 2020. 

- [12] J. M. Wang, D. J. Fleet, and A. Hertzmann, “Gaussian process dynamical models for human motion,” _IEEE Trans. Pattern Anal. Mach. Intell._ , vol. 30, no. 2, pp. 283–298, 2007. 

- [13] M. P. Deisenroth, D. Fox, and C. E. Rasmussen, “Gaussian processes for data-efficient learning in robotics and control,” _IEEE Trans. Pattern Anal. Mach. Intell._ , vol. 37, no. 2, pp. 408–423, 2013. 

- [14] K. Arulkumaran, M. P. Deisenroth, M. Brundage, and A. A. Bharath, “Deep reinforcement learning: A brief survey,” _IEEE Signal Process. Mag._ , vol. 34, no. 6, pp. 26–38, 2017. 

- [15] A. Xie, F. Yin, B. Ai, S. Zhang, and S. Cui, “Learning while tracking: A practical system based on variational Gaussian process state-space model and smartphone sensory data,” in _Proc. Int. Conf. Inf. Fusion (FUSION)_ , 2020, pp. 1–7. 

- [16] K. Berntorp and M. Menner, “Constrained Gaussian-process state-space models for online magnetic-field estimation,” in _Proc. Int. Conf. Inf. Fusion (FUSION)_ , 2023, pp. 1–7. 

- [17] S. Theodoridis, _Machine Learning: A Bayesian and Optimization Perspective_ , 2nd ed. Academic Press, 2020. 

- [18] B. Tuncer, U. Orguner, and E. Ozkan, “Multi-ellipsoidal extended target[¨] tracking with variational Bayes inference,” _IEEE Trans. Signal Process._ , vol. 70, pp. 3921–3934, 2022. 

- [19] N. Wahlstr¨om and E. Ozkan,[¨] “Extended target tracking using Gaussian processes,” _IEEE Trans. Signal Process._ , vol. 63, no. 16, pp. 4165–4178, 2015. 

- [20] A. Svensson, A. Solin, S. S¨arkk¨a, and T. Sch¨on, “Computationally efficient Bayesian learning of Gaussian process state space models,” in _Proc. Int. Conf. Artif. Intell. Stat. (AISTATS)_ , 2016, pp. 213–221. 

- [21] A. Svensson and T. B. Sch¨on, “A flexible state–space model for learning nonlinear dynamical systems,” _Automatica_ , vol. 80, pp. 189–199, 2017. 

- [22] K. Berntorp, “Online Bayesian inference and learning of Gaussianprocess state–space models,” _Automatica_ , vol. 129, p. 109613, 2021. 

- [23] Y. Liu, M. Ajirak, and P. M. Djuri´c, “Sequential estimation of Gaussian process-based deep state-space models,” _IEEE Trans. Signal Process._ , vol. 71, pp. 2968–2980, 2023. 

- [24] A. Solin and S. S¨arkk¨a, “Hilbert space methods for reduced-rank Gaussian process regression,” _Stat. Comput._ , vol. 30, no. 2, pp. 419– 446, 2020. 

- [25] R. Frigola, Y. Chen, and C. E. Rasmussen, “Variational Gaussian process state-space models,” in _Proc. Adv. Neural Inf. Process. Syst. (NeurIPS)_ , 2014, pp. 3680–3688. 

- [26] R. Frigola, “Bayesian time series learning with Gaussian processes,” Ph.D. dissertation, University of Cambridge, 2015. 

- [27] A. J. McHutchon, “Nonlinear modelling and control using Gaussian processes,” Ph.D. dissertation, University of Cambridge, 2014. 

- [28] S. Eleftheriadis, T. Nicholson, M. P. Deisenroth, and J. Hensman, “Identification of Gaussian process state space models,” in _Proc. Adv. Neural Inf. Process. Syst. (NeurIPS)_ , 2017, pp. 5309–5319. 

- [29] A. Doerr, C. Daniel, M. Schiegg, N.-T. Duy, S. Schaal, M. Toussaint, and T. Sebastian, “Probabilistic recurrent state-space models,” in _Proc. Int. Conf. Mach. Learn. (ICML)_ , 2018, pp. 1280–1289. 

- [30] A. D. Ialongo, M. van der Wilk, J. Hensman, and C. E. Rasmussen, “Overcoming mean-field approximations in recurrent Gaussian process models,” in _Proc. Int. Conf. Mach. Learn. (ICML)_ , 2019, pp. 2931–2940. 

- [31] S. Curi, S. Melchior, F. Berkenkamp, and A. Krause, “Structured variational inference in partially observable unstable Gaussian process state space models,” in _Proc. Learning for Dynamics and Control (L4DC)_ , 2020, pp. 147–157. 

- [32] J. Lindinger, B. Rakitsch, and C. Lippert, “Laplace approximated Gaussian process state-space models,” in _Proc. Conf. Uncertain. Artif. Intell. (UAI)_ , vol. 180, 2022, pp. 1199–1209. 

- [33] X. Fan, E. V. Bonilla, T. O’Kane, and S. A. Sisson, “Free-form variational inference for Gaussian process state-space models,” in _Proc. Int. Conf. Mach. Learn. (ICML)_ , 2023, pp. 9603–9622. 

- [34] M. Titsias, “Variational learning of inducing variables in sparse Gaussian processes,” in _Proc. Int. Conf. Artif. Intell. Stat. (AISTATS)_ , 2009, pp. 567–574. 

- [35] R. E. Turner and M. Sahani, “Two problems with variational expectation maximisation for time-series models,” in _Bayesian Time series models_ . Cambridge University Press, 2011, ch. 5, pp. 109–130. 

- [36] T. Chen, E. Fox, and C. Guestrin, “Stochastic gradient Hamiltonian Monte Carlo,” in _Proc. Int. Conf. Mach. Learn. (ICML)_ , 2014, pp. 1683– 1691. 

- [37] Z. Lin, Y. Sun, F. Yin, and A. Thi´ery, “Ensemble Kalman filteringaided variational inference for Gaussian process state-space models,” _arXiv preprint arXiv:2312.05910_ , 2023. 

- [38] Z. Lin, F. Yin, and J. Maro˜nas, “Towards flexibility and interpretability of Gaussian process state-space model,” _arXiv preprint arXiv:2301.08843_ , 2023. 

- [39] Z. Lin, L. Cheng, F. Yin, L. Xu, and S. Cui, “Output-dependent Gaussian process state-space model,” in _Proc. IEEE Int. Conf. Acoust. Speech Signal Process. (ICASSP)_ , 2023, pp. 1–5. 

- [40] L. Martino and J. Read, “A joint introduction to Gaussian processes and relevance vector machines with connections to Kalman filtering and other kernel smoothers,” _Inf. Fusion_ , vol. 74, pp. 17–38, 2021. 

- [41] J. Hartikainen and S. S¨arkk¨a, “Kalman filtering and smoothing solutions to temporal Gaussian process regression models,” in _Proc. IEEE Int. Workshop Mach. Learn. Signal Process. (MLSP)_ . IEEE, 2010, pp. 379–384. 

- [42] L. Cheng, F. Yin, S. Theodoridis, S. Chatzis, and T.-H. Chang, “Rethinking Bayesian learning for data analysis: The art of prior and inference in sparsity-aware modeling,” _IEEE Signal Process. Mag._ , vol. 39, no. 6, pp. 18–52, 2022. 

- [43] J. Courts, A. G. Wills, and T. B. Sch¨on, “Gaussian variational state estimation for nonlinear state-space models,” _IEEE Trans. Signal Process._ , vol. 69, pp. 5979–5993, 2021. 

- [44] R. Krishnan, U. Shalit, and D. Sontag, “Structured inference networks for nonlinear state space models,” in _Proc. AAAI Conf. Artif. Intell. (AAAI)_ , 2017, pp. 2101–2109. 

- [45] M. Roth, G. Hendeby, C. Fritsche, and F. Gustafsson, “The ensemble Kalman filter: A signal processing perspective,” _EURASIP J. Adv. Signal Process._ , vol. 2017, pp. 1–16, 2017. 

- [46] D. P. Kingma and M. Welling, “An introduction to variational autoencoders,” _Found. Trends Mach. Learn._ , vol. 12, no. 4, pp. 307–392, 2019. 

- [47] M. Katzfuss, J. R. Stroud, and C. K. Wikle, “Understanding the ensemble Kalman filter,” _Amer. Stat._ , vol. 70, no. 4, pp. 350–357, 2016. 

- [48] A. Paszke, S. Gross, F. Massa, A. Lerer, J. Bradbury, G. Chanan, T. Killeen, Z. Lin, N. Gimelshein, L. Antiga _et al._ , “Pytorch: an imperative style, high-performance deep learning library,” in _Proc. Adv. Neural Inf. Process. Syst. (NeurIPS)_ , 2019, pp. 8026–8037. 

- [49] C. A. Naesseth, F. Lindsten, and T. B. Sch¨on, “High-dimensional filtering using nested sequential Monte Carlo,” _IEEE Trans. Signal Process._ , vol. 67, no. 16, pp. 4177–4188, 2019. 

- [50] C. Rosato, L. Devlin, V. Beraud, P. Horridge, T. B. Sch¨on, and S. Maskell, “Efficient learning of the parameters of non-linear models using differentiable resampling in particle filters,” _IEEE Trans. Signal Process._ , vol. 70, pp. 3676–3692, 2022. 

- [51] Y. Chen, D. Sanz-Alonso, and R. Willett, “Autodifferentiable ensemble Kalman filters,” _SIAM J. Math. Data Sci._ , vol. 4, no. 2, pp. 801–833, 2022. 

- [52] J. Hensman, N. Fusi, and N. D. Lawrence, “Gaussian processes for big data,” in _Proc. Conf. Uncertain. Artif. Intell. (UAI)_ , 2013, pp. 282–290. 

- [53] M. D. Hoffman, D. M. Blei, C. Wang, and J. Paisley, “Stochastic variational inference,” _J. Mach. Learn. Res_ , vol. 14, no. 40, pp. 1303– 1347, 2013. 

- [54] D. P. Kingma and J. Ba, “Adam: A method for stochastic optimization,” in _Proc. Int. Conf. Learn. Represent. (ICLR)_ , 2015. 

- [55] Y. Chen, D. Sanz-Alonso, and R. Willett, “Reduced-order autodifferentiable ensemble Kalman filters,” _Inverse Probl._ , vol. 39, no. 12, p. 124001, 2023. 

15 

- [56] T. Ishizone, T. Higuchi, and K. Nakamura, “Ensemble Kalman variational objective: A variational inference framework for sequential variational auto-encoders,” _Nonlinear Theory and Its Applications, IEICE_ , vol. 14, no. 4, pp. 691–717, 2023. 

- [57] J. Courts, A. G. Wills, T. B. Sch¨on, and B. Ninness, “Variational system identification for nonlinear state-space models,” _Automatica_ , vol. 147, p. 110687, 2023. 

- [58] K. D. Polyzos, Q. Lu, and G. B. Giannakis, “Ensemble Gaussian processes for online learning over graphs with adaptivity and scalability,” _IEEE Trans. Signal Process._ , vol. 70, pp. 17–30, 2021. 

- [59] Y. Zhao, J. Nassar, I. Jordan, M. Bugallo, and I. M. Park, “Streaming variational Monte Carlo,” _IEEE Trans. Pattern Anal. Mach. Intell._ , vol. 45, no. 1, pp. 1150–1161, 2022. 

- [60] Y. Zhao and I. M. Park, “Variational online learning of neural dynamics,” _Front. Comput. Neurosci._ , vol. 14, p. 71, 2020. 

- [61] S. Linderman, M. Johnson, A. Miller, R. Adams, D. Blei, and L. Paninski, “Bayesian learning and inference in recurrent switching linear dynamical systems,” in _Proc. Int. Conf. Artif. Intell. Stat. (AISTATS)_ , 2017, pp. 914–922. 

16 

## SUPPLEMENT A VARIATIONAL BAYES 

## _A. Evidence Lower Bound (ELBO)_ 

In Bayesian statistics, the model marginal likelihood _p_ ( _⃗_ **y** _|_ _**θ**_ ) is a fundamental quantity for model selection and comparison [43]. By maximizing the logarithm of _p_ ( _⃗_ **y** _|_ _**θ**_ ) w.r.t. the model parameters _**θ**_ , the goodness of data fitting and the model complexity are automatically balanced, in accordance with Occam’s razor principle [42]. However, _p_ ( _⃗_ **y** _|_ _**θ**_ ) is obtained by integrating out all the latent variables _{⃗_ **x** _,[⃗]_ **f** _}_ in the joint distribution, see Eq. (16), which is analytically intractable. Thus, the _⃗ ⃗_ posterior distribution of the latent variables, _p_ ( **x** _,[⃗]_ **f** _|_ **y** ) = _[p] p_[(] _[⃗]_ ( **[y]** _⃗_ **y** _[,][⃗]_ **[x]** _|_ _**θ**[,][⃗]_ **[f]** )[)] _[,]_[cannot][be][expressed][in][a][closed-form][expression,][either.][This] intractability issue has been addressed in variational Bayesian methods by adopting a variational distribution [17], _q_ ( _⃗_ **x** _,[⃗]_ **f** ), to approximate the intractable _p_ ( _⃗_ **x** _,[⃗]_ **f** _|⃗_ **y** ). With the newly introduced variational distribution _q_ ( _⃗_ **x** _,[⃗]_ **f** ), we have 

**==> picture [420 x 76] intentionally omitted <==**

## SUPPLEMENT B MORE EXPERIMENT RESULTS 

## _A. OEnVI: Online Learning Results on Linear Gaussian SSMs_ 

- The definition of RMSE: 

**==> picture [324 x 37] intentionally omitted <==**

where **x** ˆ _t_ represents the estimation of **x** _t_ . 

- The baseline in Table III and Table IV is the RMSE between the noisy observations **y** 1: _T_ and the latent states **x** 1: _T_ . 

- Table III, and Figs. 7 and 8 present the results obtained using our proposed methods, EnVI and OEnVI, applied to learning the linear Gaussian SSM with the identity coefficient matrix _**C**_ = _**I**_ 4 _×_ 4. 

- The results in Table IV and Fig. 6 show that our proposed methods, EnVI and OEnVI, can still accurately filter the true latent states. However, it is noteworthy that the matrix _**C** ∈_ R _[d][y][×][d][x]_ should be “full-column rank” if the main task is to perform filtering; otherwise, there is a high probability that some latent dimensions cannot be inferred accurately. Intuitively speaking, if we aim to recover latent state **x** _t_ , it is only possible when the corresponding observation **y** _t_ contains “sufficient information” about **x** _t_ . For the task of predicting the sequence **y** _t_ for _t_ = _T_ + 1 _, T_ + 2 _, . . ._ , it is typically not necessary to focus as much on the physical meaning and accuracy of the latent states. 

## TABLE III 

STATE INFERENCE PERFORMANCE (RMSE) OF ENVI AND OENVI (WITH EMISSION COEFFICIENT MATRIX _**C**_ = _**I**_ 4 _×_ 4) 

|Time Slot|**0 – 120**|**120 – 240**|**240 – 360**|**360–480**|**480–600**|**600–720**|**720–840**|**840–960**|**900-1000**|**0–1000**|
|---|---|---|---|---|---|---|---|---|---|---|
|**KF**|0.5252|0.5149|0.5228|0.5658|0.5246|0.4907|0.4983|0.5202|0.4846|0.5199|
|**EnVI**|0.6841|/|/|/|/|/|/|/|/|0.7182|
|**OEnVI**|0.7784|0.7130|0.6512|0.6487|0.6786|0.6515|0.5958|0.6713|0.6418|0.6739|
|**Baseline**|0.9872|0.9811|0.9510|1.0077|1.0215|0.9967|1.0077|1.0314|1.0222|0.9974|



## TABLE IV 

STATE INFERENCE PERFORMANCE (RMSE) OF ENVI AND OENVI (WITH EMISSION COEFFICIENT MATRIX _**C** ∈_ R[4] _[×]_[4] GENERATED RANDOMLY ) 

|Time Slot|**0 – 120**|**120 – 240**|**240 – 360**|**360–480**|**480–600**|**600–720**|**720–840**|**840–960**|**900-1000**|**0–1000**|
|---|---|---|---|---|---|---|---|---|---|---|
|**KF**|0.7799|1.0302|1.1086|1.3682|1.4355|1.1277|0.7517|1.1239|1.0911|1.1062|
|**EnVI**|1.8413|/|/|/|/|/|/|/|/|2.3356|
|**OEnVI**|1.4508|1.5902|1.3763|3.0673|1.2875|2.1743|1.2470|3.6032|2.8966|2.1546|
|**Baseline**|24.10|100.49|211.82|272.88|303.85|422.38|547.60|741.17|847.08|428.24|



17 

**==> picture [494 x 240] intentionally omitted <==**

**----- Start of picture text -----**<br>
Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>15<br>2<br>4<br>10 0 0<br>2<br>2<br>5 20<br>0 4<br>0<br>40 2 6<br>0 50 100 0 50 100 0 50 100 0 50 100<br>t t t t<br>obsers. states KF ±2  (KF) EnVI ±2  (EnVI)<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>15<br>4 0<br>0<br>10<br>2 2<br>5 20 0 4<br>0 2<br>6<br>40<br>0 50 100 0 50 100 0 50 100 0 50 100<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>**----- End of picture text -----**<br>


Fig. 6. EnVI ( **top** ) & OEnVI ( **bottom** ) on state inference in linear Gaussian SSM, with the emission coefficient matrix _**C** ∈_ R[4] _[×]_[4] generated randomly. The RMSE of the latent state estimates for KF, EnVI, and OEnVI are 0.7799, 1.8413, and 1.4508, respectively; the RMSE between the observations and the latent states is 24.10. 

18 

**==> picture [464 x 654] intentionally omitted <==**

**----- Start of picture text -----**<br>
Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>0 6 2<br>20 5 4 0<br>10 10 2 2<br>15 0 4<br>0 20 2 6<br>0 50 100 0 50 100 0 50 100 0 50 100<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(a) Online learning result from t  = 0 to t  = 120<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>20<br>80 8<br>2<br>6<br>60 40<br>4 4<br>40<br>60 2 6<br>150 200 150 200 150 200 150 200<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(b) Online learning result from t  = 120 to t  = 240<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>100 4<br>80 2<br>95 2<br>4<br>0<br>90 100<br>2 6<br>250 300 350 250 300 350 250 300 350 250 300 350<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(c) Online learning result from t  = 240 to t  = 360<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>120 6<br>120<br>4 4<br>140<br>110<br>2<br>100 160 0 6<br>2<br>400 450 400 450 400 450 400 450<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(d) Online learning result from t  = 360 to t  = 480<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>180 6<br>6<br>150 200<br>4<br>220<br>140<br>2 8<br>240<br>130<br>260 0<br>500 550 600 500 550 600 500 550 600 500 550 600<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(e) Online learning result from t  = 480 to t  = 600<br>**----- End of picture text -----**<br>


Fig. 7. OEnVI on learning and inference in linear Gaussian SSMs with _**C**_ = _**I**_ 4 _×_ 4 

19 

**==> picture [464 x 654] intentionally omitted <==**

**----- Start of picture text -----**<br>
Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>240<br>275 5.0<br>220 8<br>300 7.5<br>200<br>325<br>6 10.0<br>180<br>350<br>12.5<br>160 375 4<br>600 650 700 600 650 700 600 650 700 600 650 700<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(a) Online learning result from t  = 600 to t  = 720<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>10<br>325 400 12<br>300<br>450 8 14<br>275<br>500 16<br>6<br>250<br>550<br>750 800 750 800 750 800 750 800<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(b) Online learning result from t  = 720 to t  = 840<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>550<br>12<br>400<br>600 8<br>380 14<br>650 6<br>360 16<br>700<br>340 4<br>18<br>850 900 950 850 900 950 850 900 950 850 900 950<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(c) Online learning result from t  = 840 to t  = 960<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>440 650 10 12<br>420 700 8 13<br>400 6 14<br>750<br>15<br>4<br>380<br>900 950 1000 900 950 1000 900 950 1000 900 950 1000<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(d) Online learning result from t  = 900 to t  = 1000<br>Dimension 1 Dimension 2 Dimension 3 Dimension 4<br>0 10<br>400 0<br>200<br>300 5<br>5<br>200 400<br>10<br>100 600 0<br>15<br>0 800<br>0 500 1000 0 500 1000 0 500 1000 0 500 1000<br>t t t t<br>obsers. states KF ±2  (KF) OEnVI ±2  (OEnVI)<br>(e) Online learning result from t  = 0 to t  = 1000<br>**----- End of picture text -----**<br>


Fig. 8. OEnVI on learning and inference in linear Gaussian SSMs with _**C**_ = _**I**_ 4 _×_ 4 

20 

## _B. Learning System Dynamics on Kink Function_ 

- The kink function is depicted in Fig. 9 

- The MSE and Log-likelihood in Table I are evaluated as follows: 

**==> picture [334 x 64] intentionally omitted <==**

**==> picture [360 x 155] intentionally omitted <==**

**----- Start of picture text -----**<br>
1 1.0<br>25 0.5<br>0<br>0.0<br>20<br>0.5<br>1<br>15 1.0<br>2<br>1.5<br>10<br>2.0<br>3<br>"Kink" function 5 Latent states<br>2.5<br>Initial state Noisy observations<br>3 2 1 0 1 0 5 10 15 20 25 30<br>xt time-step<br>x + 1t<br>transition index<br>**----- End of picture text -----**<br>


Fig. 9. The ”kink” dynamical function is used to generate 50 latent states and corresponding observations, with _σ_ Q[2][= 0] _[.]_[01][and] _[σ]_ R[2][= 0] _[.]_[1][.] 

21 

## _C. Time Series Data Forecasting using EnVI_ 

In addition to the overall prediction performance outlined in Table II, we provide a specific prediction of EnVI below. 

**==> picture [516 x 460] intentionally omitted <==**

**----- Start of picture text -----**<br>
RMSE: 0.584, log-ll: 5.007 RMSE: 0.053, log-ll: 26.093<br>4 true observationspredicted observations95% CI true observationspredicted observations95% CI<br>3 0.15<br>2 0.10<br>1 0.05<br>0 0.00<br>1<br>0.05<br>2<br>0.10<br>3<br>0.15<br>4<br>0.20<br>0 200 400 600 800 1000 0 200 400 600 800 1000<br>(a) Actuator (b) Ball Beam<br>RMSE: 0.715, log-ll: 12.631 RMSE: 0.126, log-ll: -0.375<br>3.0 true observationspredicted observations95% CI true observationspredicted observations95% CI<br>6.0<br>2.5<br>5.5<br>2.0<br>5.0<br>1.5<br>4.5<br>1.0<br>4.0<br>0.5<br>3.5<br>0.0<br>3.0<br>0 100 200 300 400 500 0 200 400 600 800 1000<br>(c) Drive (d) Dryer<br>RMSE: 1.316, log-ll: 2.902<br>true observations<br>predicted observations95% CI<br>60<br>58<br>56<br>54<br>52<br>50<br>48<br>46<br>0 50 100 150 200 250 300<br>(e) Gas Furnace<br>**----- End of picture text -----**<br>


Fig. 10. Learning and prediction results of EnVI. The initial half of the sequence is generated by passing the filtered **x** _t_ through the emission model, while the subsequent half of the sequence represents the prediction outcome. This prediction is derived from the filtered **x** _t_ obtained from the final step of the training sequence, serving as the initial state. 

22 

## _D. Online Learning and Inference with OEnVI_ 

We report the learning results of OEnVI on the kink function dataset. As illustrated in Fig. 11, after sequentially training with 600 data points, OEnVI demonstrates comparable performance to EnVI, which undergoes offline training consisting of over 400 iterations with a full batch of data with length _T_ =600. 

**==> picture [258 x 193] intentionally omitted <==**

**----- Start of picture text -----**<br>
3.0 R2 [= 0.008]<br>2<br>R [= 0.08]<br>2.5 2<br>R [= 0.8]<br>2.0<br>1.5<br>1.0<br>0.5<br>0.0<br>0 200 400 600 800 1000 1200 1400<br>time step t<br>MSE<br>**----- End of picture text -----**<br>


Fig. 11. Kink transition function learning using OEnVI 

