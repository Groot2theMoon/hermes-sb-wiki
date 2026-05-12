---
title: "Variational Robust Kalman Filters: A Unified Framework"
arxiv: "2512.15419"
authors: ["Shilei Li", "Dawei Shi", "Hao Yu", "Ling Shi"]
year: 2026
source: paper
ingested: 2026-05-12
sha256: 2eb0f0da9426f90596e6a8966441183ce0dfbae7131b7dcf4f0820d127d75503
conversion: pymupdf4llm
---

# **Variational Robust Kalman Filters: A Unified Framework** 

Shilei Li[a] , Dawei Shi[a] , Hao Yu[a] , Ling Shi[b] 

> a _School of Automation, Beijing Institute of Technology, Beijing 100081, China_ 

> b _Department of Electronic and Computer Engineering, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong, China_ 

## **Abstract** 

Robustness and adaptivity are two competing objectives in Kalman filters (KF). Robustness involves temporarily inflating prior estimates of noise covariances, while adaptivity updates prior beliefs by exploiting measurements. In practical applications, both process and measurement noise can be influenced by outliers, be time-varying, or both. In this work, we propose a variational robust Kalman filter, built on a Student’s _t_ -distribution induced loss function and variational inference, and solved in a computationally efficient manner. We demonstrate that robustness can be understood as a prerequisite for adaptivity, making it possible to merge the above two competing goals into a single framework through a probabilistic switching rule. Additionally, our proposed filter can recover conventional KF, robust KF, and adaptive KF by tuning parameters, and can suppress both the imperfect process and measurement noise, enabling it to perform superiorly in complex noise environments. Simulations verify the effectiveness of the proposed method. 

_Key words:_ Student’s _t_ -distribution, robustness and adaptability, fixed-point iteration, variational inference 

## **1 Introduction** 

State estimation aims to infer the latent states of a system from a mathematical model and noisy measurements, serving as a critical foundation for numerous fields, including robotics, finance, medical imaging, and meteorology [1, 2]. The Kalman filter, co-developed by Kalman and Bucy, is a cornerstone in state estimation, providing optimal estimates in the mean squared error sense. Despite its theoretical elegance, the Kalman filter’s reliance on Gaussian noise assumptions limits its efficacy in complex systems subject to imprecise noise covariance or unknown noise models [3]. 

Research on filtering with non-Gaussian noise or unknown covariance is active. There are two main lines of research efforts: robustness and adaptability. The vul- 

_⋆_ Shilei Li, Dawei Shi, and Hao Yu are with School of Automation, Beijing Institute of Technology, Beijing 100081, China (e-mail: shileili@bit.edu.cn, yuhaocsc@bit.edu.cn, daweishi@bit.edu.cn). Ling Shi is with the Department of Electronic and Computer Engineering, The Hong Kong University of Science and Technology, Kowloon, Hong Kong (email: eesling@ust.hk). (Corresponding author: Dawei Shi.) 

_Email addresses:_ `shileili@bit.edu.cn` (Shilei Li), `daweishi@bit.edu.cn` (Dawei Shi), `yuhaocsc@bit.edu.cn` (Hao Yu), `eesling@ust.hk` (Ling Shi). 

nerability of the Kalman filter to outliers has been found in its early history [4]. To enhance its robustness, the _H∞_ filter, sometimes called minimax filter, was derived under the game theory framework [5]. To combat gross errors, some M-estimation-based estimators were developed, e.g., the Huber-based filter [6], _ℓ_ 1 norm-based Kalman filter [7]. An alternative approach to design robust estimators is to exploit heavy-tailed distributions, including the Laplace-based filter [8] and Student’s _t_ - based filter [9]. Recently, the correntropy and statistical similarity measure, given their roots in the informationtheoretic learning [10] and statistical learning [11], were utilized for algorithm derivation and achieving satisfactory results, including maximum correntropy Kalman filter (MCKF) [12, 13] and statistical similarity measure based Kalman filter (SSMKF) [14]. Both MCKF and SSMKF utilized a fixed-point iteration in optimization, which exhibited a higher computation efficiency than the gradient descent-based algorithms [15, 16]. Current fixed-point convergence proofs are limited to specific robust losses. In this work, we expand this scope by providing sufficient conditions (Theorem 3). 

Another prominent line is adaptive filtering, which can be broadly categorized into Bayesian, maximum likelihood [17], covariance matching [18], and variational Bayesian (VB) methods. Among these, Bayesian approaches are the most general, exemplified by techniques 

_Preprint submitted to Automatica_ 

_11 May 2026_ 

such as the interacting multiple model Kalman filter (IMMKF) and particle filters. However, these methods may suffer from high computational complexity. In contrast, VB methods provide a more computationally efficient alternative by approximating posterior inference through conjugate distributions [19, 20]. A pioneering work in this area was presented by S¨arkk¨a [20], focusing on adaptive measurement covariance. This was later extended to include adaptive process and measurement covariance [21, 22], along with nonlinear counterparts such as the unscented and cubature Kalman filters [23, 24]. Although many variants of variational Bayesian Kalman filter (VBKF) had been developed, one of its key issues, such as the covariance tracking speed and the corresponding tracking variance, have not been explored. In this work, we provide the corresponding covariance tracking speed and reveal an inherent trade-off between convergence speed and steady state variance regarding the forgetting factor. 

Many previous works concentrate on either robustness [13, 25, 26] or adaptability [20, 27]. It is worth clarifying that the terminology “robust adaptive” mentioned in [26] actually referred to adaptive robustness and hence falls into the first class. The VBKF [20, 27], although adjusting both shape and scale hyperparameters, falls into the second class. Only a limited number of studies consider the coexistence of time-varying covariance and outliers [28–31], with solutions including a combination of VB and robust loss techniques [28–30] or making joint inference on the noise types, the covariance, and the state [31]. For instance, Chang [28] proposed an innovation-based measure to switch between the standard Kalman filter, the fading memory Kalman filter, and the robust Kalman filter to balance between robustness and adaptability. Li et al. [29] addressed this problem by designing a variational Huber-based filter by combining M-estimation with VB approximation. Gao et al. [30] fuses the “robustness” and “adaptability” through the interacting multiple model. Zhu et al. [31] proposed an adaptive Kalman filter to handle inaccurate noise covariances and outliers by modeling the noise with Gaussian-Gamma mixture distributions, thereby jointly inferring the state, noise covariances, and hidden indicator variables within a variational Bayesian framework. 

In this work, we demonstrate that the robust filter can be understood as a prerequisite of adaptive filters, allowing us to solve the robust adaptive problem in an efficient way. This avoids executing the “robustness” and “adaptability” in parallel as is done in [28–30], or simultaneously inferring both the noise types and the unknown covariances. Our developed filters can recover the KF, the robust KF, and the VBKF easily, formulating a unified framework. The contributions of this paper are summarized as follows. 

_•_ We provide a sufficient condition for the convergence 

- of the fixed-point iteration under a class of robust losses in **Theorem 3** . This allows us to derive a series of robust filters, including the Student’s _t_ -based Kalman filter (STKF, **Algorithm 1** ). 

- We demonstrate that variational inference on the state vector with a point posterior distribution can be regarded as maximum a posteriori (MAP) estimation ( **Theorem 4** ), which inherently formulates a robust filter. Subsequently, we recover the state error covariance through the Joseph form update. This pipeline is much more computationally efficient than the conventional VB [20]. 

- We demonstrate that the proposed estimator can seamlessly recover the standard KF, the robust KF, the adaptive KF, or any hybrid combination through hyperparameter tuning. This provides a unified framework for versatile applications, whose effectiveness is verified through extensive simulations. 

The remainder of this paper is organized as follows. Section II introduces some preliminaries. Section III derives a family of robust filters with guaranteed convergence. Section IV develops some robust adaptive filters. Section V provides some simulations. Section VI concludes the paper. 

_Notations_ : The transpose of a matrix _A_ is denoted by _A[T]_ . _X ≻_ 0 ( _X_ ≽ 0) denotes _X_ is positive definite (semipositive definite) matrix. The Gaussian distribution with mean _µ_ and covariance Σ is denoted by _N_ ( _µ,_ Σ). The expectation of a random variable _X_ or random vector _X_ is denoted by E( _X_ ) or E( _X_ ). The prior and posterior estimate of state _x_ is denoted as _x[−]_ and _x_[+] , respectively. 

## **2 Preliminaries** 

We begin by presenting the necessary preliminaries and lemmas, followed by the problem statement. 

## _2.1 The Student’s t-distribution_ 

The probability distribution functions (PDF) of Student’s _t_ -distribution, Gaussian distribution, and inverse Gamma distribution of random variable _X_ are given as follows: 

**==> picture [228 x 63] intentionally omitted <==**

where St � _x | ν, µ, τ_[2][�] denotes the Student’s _t_ -distribution with degrees of freedom (DOF) _ν_ , mean _µ_ , and scale parameter _τ_[2] , _N_ ( _x|µ, τ_[2] ) denotes the Gaussian distribution with mean _µ_ and covariance _τ_[2] , and Inv-Gam( _x|a, b_ ) denotes the inverse-Gamma distribution with shape parameter _a_ and scale parameter _b_ [32]. 

2 

**Property 1 ([32])** _The Student’s t-distribution_ St( _x|ν, µ, τ_[2] ) _is a compounding distribution composed of a Gaussian distribution and Inverse-Gamma distribution, i.e., it is equivalent to_ 

**==> picture [148 x 11] intentionally omitted <==**

_where λ follows_ 

**==> picture [174 x 23] intentionally omitted <==**

Denoting _e_ = _x − µ_ and taking the logarithm on the right hand side of (1a) and ignoring the constant terms, we obtain the Student’s _t_ -induced loss _L[∗] st_[as][follows] 

**==> picture [182 x 25] intentionally omitted <==**

**Lemma 1 (Invariant Loss)** _Let e_ = [ _e_ 1 _, . . . , el_ ] _[T] ∈_ R _[l] be an error vector with statistically independent components. Minimizing the following two loss functions yields identical optimal estimates:_ 

**==> picture [192 x 65] intentionally omitted <==**

_where c is a constant, and νi are either all identical or partially tend to infinity._ 

The lemma can be proved by the separability of the objective function across independent components _ei_ and the scale invariance of each decoupled term. 

By analogy with the obtainment of _L[∗] st_[,][we][obtain][the] Gaussian-induced loss _Lgau_ according to (1b). We compare _Lst_ and _Lgau_ as follows 

**==> picture [209 x 25] intentionally omitted <==**

Its influence functions, measuring the derivative of the loss with respect to the error, are given as 

**==> picture [194 x 22] intentionally omitted <==**

**Property 2** _As ν →∞, one has Lst_ = _Lgau. As ν_ = 1 _, Lst becomes Cauchy loss corresponding to Cauchy distribution._ 

The proof is available in Appendix 6.1. 

**Property 3** _The loss Lst is convex within the region_ [ _−[√] ντ,[√] ντ_ ] _, and is concave in other regions._ 

The proof is available at Appendix 6.2. 

**Property 4** _As ν →∞, the PDF of latent variable λ (see_ (3) _) becomes a shifted Dirac delta function δ_ ( _λ−τ_[2] ) _._ 

The proof is available at Appendix 6.3. 

**==> picture [219 x 255] intentionally omitted <==**

**----- Start of picture text -----**<br>
14 5<br>4<br>12<br>3<br>10 2<br>8 1<br>0<br>6 -1<br>4 -2<br>-3<br>2<br>-4<br>0 -5<br>-5 0 5 -5 0 5<br>(a) loss function (b) influence function<br>0.4 1.4<br>0.35 1.2<br>0.3 1<br>0.25<br>0.8<br>0.2<br>0.6<br>0.15<br>0.4<br>0.1<br>0.05 0.2<br>0 0<br>-5 0 5 0 1 2 3 4 5<br>(c) PDF (d) Latent PDF<br>**----- End of picture text -----**<br>


Fig. 1. The visualization of _Lst_ and _Lgau_ as well as their influence functions and induced PDFs. (a) The loss function of _Lst_ and _Lgau_ . (b) The influence function of _Lst_ and _Lgau_ . (c) The mapped Student’s t distribution and Gaussian distribution. (d) The PDF of latent variable _λ_ . 

The loss and influence functions of _Lst_ and _Lgau_ , as well as their corresponding PDFs and the induced latent variable’s PDF in _Lst_ are visualized in Fig. 1. One observes that the influence function of _Lst_ has a redescending property, indicating its robustness to absolute errors that are much greater than _[√] ντ_ . According to Properties 1, 2, 3, and 4, we have the following insights: 

- The parameter _τ_[2] describes the variance of the latent Gaussian distribution. 

- The parameter _ν_ reflects how confident we are about the latent variance _τ_[2] . 

We leverage these insights in the subsequent section. 

## _2.2 Problem Statement_ 

We consider the following linear system: 

**==> picture [158 x 23] intentionally omitted <==**

where _A ∈_ R _[n][×][n]_ and _C ∈_ R _[m][×][n]_ are state transfer and observation matrices. The process noise _wk_ and measurement noise _vk_ are uncorrelated zero-mean random noises. The initial state _x_ 0 is zero-mean Gaussian with known covariance matrix _P_ 0, and is independent of _wk_ 

3 

and _vk_ for all _k >_ 0. We consider that the noise covariance may be time-varying and occasionally contaminated by outliers, i.e., 

**==> picture [195 x 24] intentionally omitted <==**

where _wn,k ∼N_ (0 _, Qk_ ) and _vn,k ∼N_ (0 _, Rk_ ). The parameters _ϵw, ϵv ∈_ (0 _,_ 1] denote the occurrence probabilities of the nominal noises, while _pw,ol_ ( _·_ ) and _pv,ol_ ( _·_ ) denote the unknown probability distributions of the outliers. The model (9) recovers the standard KF when _Qk_ = _Q_ , _Rk_ = _R_ , and _ϵw_ = _ϵv_ = 1. It simplifies to the robust filtering problem when _Qk_ ≜ _Q_ , _Rk_ ≜ _R_ with _ϵw, ϵv <_ 1, and it becomes the adaptive filtering problem when _ϵw_ = _ϵv_ = 1. 

The objective of this work is to develop a unified recursive estimator capable of jointly estimating the system state _xk_ and the time-varying nominal covariances _Qk_ and _Rk_ , while simultaneously maintaining robustness against occasional outliers. 

## **3 Main Results** 

In this section, we first present a robust filter under _Lst_ with proved convergence. Next, we establish a connection between the robust filter and the adaptive filter under the Kullback–Leibler divergence perspective. Finally, we update the hyperparameters using variational inference and design a probabilistic switching rule for scenarios where outliers and time-varying noise coexist. 

## _3.1 A Class of Robust Filters_ 

By regarding the prior estimate of the state _x[−] k_[=] _[ Ax]_[+] _k−_ 1 as a pseudo-measurement, we rewrite (8) as 

_tk_ = _Wkxk_ + _ζk,_ (10) 

**==> picture [234 x 43] intentionally omitted <==**

**==> picture [240 x 43] intentionally omitted <==**

**Remark 1** _By constructing the augmented pseudomeasurement vector tk, the prior state estimate x[−] k is embedded directly into the observation space. Statistically, solving this augmented linear regression is mathematically equivalent to maximizing the posterior distribution p_ ( _xk | y_ 1: _k_ ) _∝ p_ ( _yk | xk_ ) _p_ ( _xk | y_ 1: _k−_ 1) _. This unifies the Bayesian prediction and update phases into a single optimization framework._ 

Instead of minimizing the least squares loss _∥ek∥_ 2[2][where] _ek_ = _tk − Wkxk ∈_ R _[l]_ wiht _l_ = _n_ + _m_ as done in KF [13], 

by denoting _Rζζk_ = E( _ζkζk[T]_[)][=][diag(] _[λ]_[1] _[, . . . , λ][i][,][ · · ·][, λ][l]_[)] and formulating _λi_ as an inverse gamma distribution, we construct the following MAP problem: 

**==> picture [224 x 71] intentionally omitted <==**

According to the composition property of Student’s _t_ - distribution and equation (4), taking negative logarithm on both sides of (11) and ignoring the constant term gives 

**==> picture [203 x 30] intentionally omitted <==**

where _ei,k_ = _ti,k − wi,kxk_ . According to Lemma 1, we reformulate (12) as 

**==> picture [195 x 30] intentionally omitted <==**

By letting _∂x∂Jk_[= 0, one has] 

**==> picture [221 x 30] intentionally omitted <==**

It follows 

**==> picture [240 x 26] intentionally omitted <==**

_νi dνi_ ( _ei,k_ ) = _._ (16) _νiτi_[2][+] _[ e]_[2] _i,k_ Note that the equation (15) can be regarded as the least square solution of (10) where _E_ ( _ζk[T][ζ][k]_[)][=] _[D] k[−]_[1] = diag([ _λ_ 1 _, λ_ 2 _, . . . , λl_ ]) and 

**==> picture [183 x 41] intentionally omitted <==**

We observe that both sides of (15) contain _xk_ , as _ek_ = _tk −Wkxk_ . Then, it is natural to apply a fixed-point iteration for the solution of (15). Using a similar derivation as done in [13], we obtain the Student’s _t_ -based Kalman filter (STKF) summarized in Algorithm 1. To provide the convergence analysis of Line 10-17 in Algorithm 1, we provide the following lemma. 

**Lemma 2 ([33])** _The fixed-point algorithm_ (15) _converges if ∃ γ >_ 0 _and_ 0 _< η <_ 1 _such that the initial vector ∥x_ 0 _∥p < γ, and ∀x ∈{x ∈_ R _[n]_ : _∥x∥p ≤ γ}, the following holds (omitting time index k for simplicity)_ 

**==> picture [161 x 31] intentionally omitted <==**

_where ∥·∥p denotes an ℓp norm of a vector or an induced_ 

4 

## **Algorithm 1** STKF 

- 1: **Step 1: Initialization** 

- 2: Choose _νi_ and _τi_[2][for][channel] _[i]_[,][maximum][iteration] number _m_ iter, and a threshold _ε_ . 

- 3: **Step 2: State Prediction** 4: _x_ ˆ _[−] k_[=] _[ A][x]_[ˆ][+] _k−_ 1 5: _Pk[−]_[=] _[ AP]_[ +] _k−_ 1 _[A][T]_[+] _[ Q][k]_ 6: Obtain _Bp_ and _Br_ with _BpBp[T]_[=] _[P][ −] k_[and] _[B][r][B] r[T]_[=] _Rk[∗]_ 

- 7: Obtain _tk_ and _Wk_ through (10) 

- 8: **Step 3: State Update** 

**==> picture [240 x 160] intentionally omitted <==**

_norm of a matrix defined by ∥A∥p_ = max _∥x∥p ∥∥Axx∥∥pp with p ≥_ 1 _, and ∇xf_ ( _x_ ) _is the Jacobian matrix of f_ ( _x_ ) _._ 

Denote the DOF vector as _**ν**_ = [ _ν_ 1 _, ν_ 2 _, . . . , νl_ ] _[T] ∈_ R _[l]_ and the unified DOF as _ν_ 1 = _ν_ 2 = _· · ·_ = _νl_ = _ν ∈_ R. The following Theorem 1 ensures the validity of first inequality in (18), while Theorem 2 guarantees the second one. 

**Theorem 1** _Let f_ ( _x_ ) _be defined as in_ (15) _. If γ > ξ and νi ≥ ν[∗] for all i_ = 1 _, . . . , l, then ∥f_ ( _x_ ) _∥_ 1 _≤ γ for every x ∈_ R _[n] satisfying ∥x∥_ 1 _≤ γ. Here, ξ is defined as_ 

**==> picture [178 x 38] intentionally omitted <==**

_and ν[∗] is the solution to ϕ_ ( _ν_ ) = _γ, where_ 

**==> picture [224 x 34] intentionally omitted <==**

The proof is available at 6.4. 

**Theorem 2** _Let f_ ( _x_ ) _be defined as in_ (15) _, ∀x ∈ {x ∈_ R _[n]_ : _∥x∥_ 1 _≤ γ}, it holds that ∥f_ ( _x_ ) _∥_ 1 _≤ γ, and ∥∇xf_ ( _x_ ) _∥≤ η if γ > ξ (see_ (19) _), where ν[∗] is the solution of ϕ_ ( _ν_ ) = _γ, and ν_[+] _is the solution of ψ_ ( _ν_ ) = _η_ (0 _< η <_ 1) _with_ 

**==> picture [232 x 28] intentionally omitted <==**

The proof is available at 6.5. 

**Remark 2** _Theorems 1 and 2 provide a sufficient condition for the convergence of the fixed-point iteration_ (15) _under dynamics_ (10) _and loss_ (13) _._ 

We further extend Theorems 1 and 2 to a general loss _J_ _**ν**_ ( _e_ ; _**ν** ,_ _**τ**_[2] ) =[�] _[l] i_ =1 _[J][ν] i_[(] _[e][i]_[;] _[ ν][i][, τ] i_[ 2][)][where] _[ν][i][>]_[0][and] _τi_[2] _>_ 0 are the hyperparameters and _ei ∈_ R is the _i_ -th element of _e_ . By denoting _∂J∂eνii_ = _dνi_ ( _ei_ ) _ei_ and _∂d∂eνi_ ( _iei_ ) = _ινi_ ( _ei_ ) _ei_ , Theorem 3 provide a necessary condition for the convergence of a general loss using a fixedpoint solution. 

**Theorem 3** _Considering dynamics_ (10) _, a general loss J_ _**ν**_ ( _e_ ; _**ν** ,_ _**τ**_[2] ) =[�] _[l] i_ =1 _[J][ν][i]_[(] _[e][i]_[;] _[ ν][i][, τ] i_[ 2][)] _[can][be][solved][by][a] fixed-point algorithm with guaranteed convergence if the following conditions are fulfilled:_ 

- _Condition 1: Jνi_ ( _ei_ ) _is a non-decreasing continuous function with respect to |ei| and gives its minimum at ei_ = 0 _._ 

- _Condition 2: ∃κ ∈_ R[+] _so that_ 0 _≤ dνi_ ( _ei_ ) _≤ κ. Moreover, dνi_ ( _ei_ ) _is an increasing function of νi with_ lim 

- _νi→_ 0+ _[d][ν][i]_[(] _[e][i]_[) = 0] _[ for any][ |][e][i][|][ >]_[ 0] _[.]_ 

- _Condition 3: ινi_ ( _ei_ ) _is bounded for any ei._ 

- _Condition 4: νi >_ max _{ν[∗] , ν_[+] _} for i_ = 1 _,_ 2 _, . . . , l, where ν[∗] and ν_[+] _are constants determined analogously to the expressions in_ (20) _and_ (21) _, respectively._ 

The proof is available at 6.6. Some exemplary losses _J_ _**ν**_ ( _e_ ; _**ν** ,_ _**τ**_[2] ) =[�] _[l] i_ =1 _[J][ν] i_[(] _[e][i]_[;] _[ ν][i][, τ] i_[ 2][)][are][listed][in][Table][1.] For simplicity, we use _l_ = 1 so the subscript _i_ is omitted. We find that the proposed STKF uses the logarithmic loss for algorithm derivation while the MKCKF [12] and AORSE-sqrt algorithm [14] utilize the exponential loss and square root loss as optimization objectives, respectively (these three estimators correspond to the first three losses in Table 1). It is worth mentioning that a different robust filter can be obtained by replacing the expression of _dνi_ ( _ei,k_ ) Lines 13 and 14 with the expressions in Table 1 (the second column) in Algorithm 1. **Proposition 1** _The STKF, MKCKF [12], and AORSEsqrt [14] are identical to the standard KF [34] as νi →∞ for i_ = 1 _,_ 2 _, . . . , l._ 

The proof can be obtained by taking the limit as _νi → ∞_ in the scaling equations of the STKF, MKCKF, and AORSE-sqrt, verifying their exact algebraic reduction to the standard KF updates. 

_3.2 Connection with Variational Adaptive Filter_ 

To build a connection between the proposed robust filter (indeed, it is a MAP estimator) and the adaptive filter, we formulate the following two problems. 

5 

Table 1 

Some Robust Losses Fulfilling Theorem 3. 

|st Losses Fulflling Theorem 3.|||
|---|---|---|
|_Jν_(_e_)|_dν_(_e_)|_ιν_(_e_)<br>special cases|
|_ν_<br>2 log<br>�<br>1 +<br>_e_2<br>_ντ_ 2<br>�<br>_, ν ∈_(0_, ∞_)<br>_ν_<br>_ντ_ 2+_e_2<br>_−_<br>2_ν_<br>(_ντ_ 2+_e_2)2<br>lim_ν→∞Jν_(_e_) =<br>_e_2<br>2_τ_ 2<br>_ν_2�<br>1_−_exp(_−_<br>_e_2<br>2_ν_2_τ_ 2 )<br>�<br>_, ν ∈_(0_, ∞_)<br>1<br>_τ_ 2 exp(_−_<br>_e_2<br>2_ν_2_τ_ 2 )<br>_−_<br>1<br>_ν_2_τ_ 4 exp(_−_<br>_e_2<br>2_ν_2_τ_ 2 )<br>lim_ν→∞Jν_(_e_) =<br>_e_2<br>2_τ_ 2<br>2_−ν_<br>_ν_<br>��_e_2_/τ_2<br>2_−ν_ + 1<br>�_ν/_2_−_1<br>�<br>_, ν ∈_(0_,_2)<br>1<br>_τ_ 2 ( _e_2_/τ_2<br>2_−ν_ + 1)_ν/_2_−_1<br>_−_1<br>_τ_ 4 ( _e_2_/τ_2<br>2_−ν_ + 1)_ν/_2_−_2<br>lim_ν→_2_Jν_(_e_) =<br>_e_2<br>2_τ_ 2<br>�<br>_ν_(_ν_+_e_2_/τ_ 2)_−ν, ν ∈_(0_, ∞_)<br>1<br>_τ_ 2~~�~~<br>1+ _e_2<br>_ντ_2<br>_−_<br>1<br>_ντ_ 4<br>�<br>1 +<br>_e_2<br>_ντ_ 2<br>�_−_3_/_2<br>lim_ν→∞Jν_(_e_) =<br>_e_2<br>2_τ_ 2|||



**Problem 1 (MAP Estimation)** _Given the augmented regression model_ (10) _and fixed noise covariance Rζζk , the STKF seeks the MAP estimate (see Remark 1 and_ (11) _) of the state xk by solving:_ 

_x[∗] k_[= arg max] (22) _xk_[ln] _[ p]_[ (] _[x][k][, R][ζζ][k][|][t][k]_[)] _[ .]_ 

_the posterior error covariance is subsequently updated by the Joseph form:_ 

**==> picture [240 x 29] intentionally omitted <==**

**Problem 2 (Variational Bayesian Inference)** _The conventional Variational Bayesian Kalman Filter (VBKF) approximates the true joint posterior by a factorized distribution Q_ ( _xk, Rζζk_ ) = _Qx_ ( _xk_ ) _QR_ ( _Rζζk_ ) _that minimizes the Kullback-Leibler (KL) divergence [20]:_ 

**==> picture [233 x 19] intentionally omitted <==**

**Theorem 4** _Given a fixed noise covariance QR_ ( _Rζζk_ ) _, such that the expected precision is_ E _QR_ [ _Rζζ[−]_[1] _k_[]][ ≜] _[R]_[˜] _ζζ[−]_[1] _k[. the] optimal variational posterior Q[∗] x_[(] _[x][k]_[)] _[solving][Problem][2] is a Gaussian whose mean is identical to the MAP state estimate derived in Problem 1, and the posterior error covariance is identical to_ (23) _._ 

**PROOF.** In the Variational Bayesian framework [35], minimizing the KL divergence is equivalent to maximizing the Evidence Lower Bound (ELBO), denoted as _L_ : 

**==> picture [240 x 30] intentionally omitted <==**

where the ELBO is defined as: 

**==> picture [217 x 24] intentionally omitted <==**

By utilizing the augmented linear regression model (10), the prior information _p_ ( _xk_ ) is intrinsically embedded into the pseudo-measurement vector _tk_ and the augmented matrix _Wk_ . Therefore, the complete data likelihood is entirely characterized by _p_ ( _tk | xk, Rζζk_ ). Isolating the terms dependent on _xk_ , we define the statedependent objective _Lx_ : 

**==> picture [244 x 30] intentionally omitted <==**

For the linear Gaussian observation model, the expected log-likelihood with respect to _QR_ has 

1 E _QR_ [ln _p_ ( _tk | xk, Rζζk_ )] = _−_ 2 ( _tk − Wkxk_ ) _[T] R_[˜] _ζζk[−]_[1][(] _[t][k][−][W][k][x][k]_[)] (28) + _c_ 2 _._ 

Substituting this expected log-likelihood into _Lx_ yields: 

**==> picture [222 x 50] intentionally omitted <==**

To deduce the optimal distribution _Q[∗] x_[(] _[x][k]_[),][we][expand] the quadratic form inside the first integral with respect to _xk_ : 

**==> picture [235 x 33] intentionally omitted <==**

By completing the square, this expression is algebraically equivalent to the logarithm of an unnormalized Gaussian density ln _N_ ( _xk | µ[∗] ,_ Σ _[∗]_ ), characterized by the information matrix and information vector: 

**==> picture [174 x 31] intentionally omitted <==**

Consequently, _Lx_ can be elegantly formulated as the negative KL divergence between _Qx_ ( _xk_ ) and this target Gaussian: 

**==> picture [240 x 42] intentionally omitted <==**

_Q[∗] x_[(] _[x][k]_[) =] _[ N]_[(] _[x][k][|][ µ][∗][,]_[ Σ] _[∗]_[)] _[.]_ (34) Finally, we map the augmented matrices back to the standard Kalman state space to establish equivalence with Algorithm 1. Let the expected augmented˜ precision be defined by the weight matrix _Rζζ[−]_[1] _k_ = blkdiag( _Mp, Mr_ ). Recalling the definitions _tk_ = _Bk[−]_[1] � _xy−kk_ � and _Wk_ = _Bk[−]_[1] � _CI_ �, we substitute these into (31): 

**==> picture [240 x 75] intentionally omitted <==**

6 

( _BrMr[−]_[1] _Br[T]_[)] _[−]_[1][=] _[R]_[˜] _k[−]_[1][.][Expanding][the][blocks][yields:] (Σ _[∗]_ ) _[−]_[1] = ( _P_[˜] _k[−]_[)] _[−]_[1][ +] _[ C][T][R]_[˜] _k[−]_[1] _[C.]_ (36) Applying the Woodbury matrix identity, we obtain the variational covariance update: 

**==> picture [225 x 44] intentionally omitted <==**

Defining the modified Kalman gain as 

**==> picture [146 x 21] intentionally omitted <==**

the covariance simplifies to: 

**==> picture [165 x 13] intentionally omitted <==**

The equivalent Joseph form is 

**==> picture [240 x 27] intentionally omitted <==**

_µ[∗]_ = Σ _[∗]_ ( _P_[˜] _k[−]_[)] _[−]_[1] _[x][−] k_[+ Σ] _[∗][C][T][R]_[˜] _k[−]_[1] _[y][k][.]_ (40) Utilizing the identities Σ _[∗]_ ( _P_[˜] _k[−]_[)] _[−]_[1][=] _[I][−][K]_[˜] _[k][C]_[and] Σ _[∗] C[T] R_[˜] _k[−]_[1] = _K_[˜] _k_ , (40) reduces to: 

**==> picture [179 x 29] intentionally omitted <==**

The derived mean _µ[∗]_ perfectly matches the MAP state update equation formulated in Algorithm 1. Thus, the STKF state update and Variational Bayesian inference are mathematically identical. 

**Remark 3** _A byproduct of Theorem 4 is that, instead of solving Problem 2 using a set of coupled equations as shown in [20], we solve the problem subsequently: (1) estimate the state xk using a fixed point iteration; (2) update the loss hyper-parameters and posterior error covariance (see Algorithm 2). The two paths demonstrates highly consistent estimation accuracy (see the simulations), but our method possesses some advantages: On the one hand, it decouples the “robustness process” and “adaptive process”, allowing us to design switching rules for complex noise scenarios. On the other hand, the decoupled method reduces algorithm complexity by calculating the posterior error covariance and update the hyper-parameter only once, rather than N iterations as shown in [20]._ 

## _3.3 Robust Adaptive Filtering_ 

According to Property 1 and Theorem 4, we have insights that optimizing (13) actually jointly optimizes the state and covariance, where the diagonal element of the variance follows an inverse-Gamma distribution, which can be obtained by a fixed-point iteration as shown in Line 8-17 in Algorithm 1. We then focus on the update of hyper-parameters _νi_ and _τi_[2][. Based on the variational] inference [20, 32], when applying (3) as a conjugate prior distribution, the posterior hyper-parameters should be 

**Algorithm 2** STKF-A 

- 1: **Initialization** 

- 2: Choose _νi_ and _τi_[2][for][channel] _[i]_[,][maximum][iteration] number _m_ iter, and a threshold _ε_ . 

- 3: **State Prediction** 

- 4: Run Line 4 to 7 in Algorithm 1. 

- 5: **Hyper-parameter Prediction** 

- 6: **for** _i_ = 1 to _l_ **do** 7: **if** 0 _< ρi <_ 1 **then** 8: Execute (43) to obtain _νi,k_[+] 9: **else if** _ρi_ = 1 **then** 

- 10: Execute (44) to obtain _νi,k_[+] 11: **end if** 12: **end for** 

- 13: **State Update** 

- 14: Run Line 8-17 in Algorithm 1 to obtain _x_ ˆ _k_ and _Pk_ 15: **Hyper-parameter Update** 

**==> picture [180 x 77] intentionally omitted <==**

updated as 

**==> picture [221 x 45] intentionally omitted <==**

where _Pk_ is the posterior error covariance and [ _∗_ ] _ii_ denotes the _i_ -th diagonal element of matrix _∗_ . The proof of (42) is available in Appendix 6.7. One observes that the update of _νi_ is not related with the error _ei,k_ . In the iterative filtering, it is natural to assume that the hyper-parameter at the next time step is identical to the previous ones. However, this would induce unbounded _νi,k_[+][and] _[τ]_[ 2] _i,k_[.][To][alleviate][this][problem,][we][employ][a] forgetting factor _ρi ∈_ (0 _,_ 1) for channel _i_ in the hyperparameter prediction step, which is motivated by [20] and given as follows: 

**==> picture [153 x 30] intentionally omitted <==**

In the extreme case _ρ_ = 1, the hyper-parameter update should be halted, which gives the following update: 

**==> picture [227 x 25] intentionally omitted <==**

We name the new algorithm STKF-A and provide a summary of it in Algorithm 2. 

**Proposition 2** _The STKF-A is equivalent to the STKF when ρi_ = 1 _for all i_ = 1 _,_ 2 _, . . . , l. Additionally, it recovers the KF by setting ρi_ = 1 _for all i_ = 1 _,_ 2 _, . . . , l and νi →∞ for all i._ 

7 

## **Algorithm 3** STKF-AR 

1: Run Line 1 to 14 in Algorithm 2 

2: **Hyper-parameter Update** 3: **for** _i_ = 1 to _l_ **do** 4: **if** 0 _< ρi <_ 1 **then** 5: Execute (45) to obtain ( _τi,k_[2][)][+] 6: **else if** _ρi_ = 1 **then** 7: Execute (44) to update ( _τi,k_[2][)][+] 8: **end if** 9: **end for** 

This can be proved by comparing different estimators by substituting the values of _ρi_ and _νi_ . We then consider the case that the noise variance is time-varying and is occasionally polluted by outliers. To avoid the harmful effects of outliers on the adaptive mechanism, we introduce a probabilistic switching rule based on a Bernoulli distribution to infer the probability of a measurement being an outlier. 

To mitigate the impact of outliers on the adaptive mechanism, we introduce a Bernoulli indicator _Zi,k ∈{_ 0 _,_ 1 _}_ for the _i_ -th channel, with prior outlier probability _P_ ( _Zi,k_ = 1) = _π_ . The likelihoods of the innovation _ei,k_ under normal and outlier states are modeled as _L_ 0 = _N_ ( _ei,k |_ 0 _, Si,k_[(0)][)][and] _[L]_[1][=] _[N]_[(] _[e][i,k][|]_[0] _[, S] i,k_[(1)][)][where] _Si,k_[(0)][=][(] _[τ]_[ 2] _i,k_[)] _[−]_[and] _[S] i,k_[(1)][=][9(] _[τ]_[ 2] _i,k_[)] _[−]_[.][By][Bayes’][theorem,] the posterior probability of an outlier is: 

**==> picture [106 x 24] intentionally omitted <==**

The covariance update is given as 

**==> picture [243 x 46] intentionally omitted <==**

**==> picture [18 x 11] intentionally omitted <==**

This continuous transition strategy, designated as STKF-AR, is summarized in Algorithm 3. 

## _3.4 Convergence Rate Analysis of the Unknown Covariance_ 

We focus on the steady-state behavior of ( _τi,k_[2][)][+][. Based] on (43), in steady state, one has 

**==> picture [189 x 51] intentionally omitted <==**

**==> picture [62 x 8] intentionally omitted <==**

Denoting _λ_[+] _i,k_[≜][(] _[τ]_[ 2] _i,k_[)][+][and][substituting][(46)][into][(42)] yields 

_λ_[+] _i,k_[=] _[ ρ][i][λ]_[+] _i,k−_ 1[+(1] _[ −][ρ][i]_[)] _[e]_[2] _i,k_[+(1] _[−][ρ][i]_[)] _[w][i,k][P][k][w] i,k[T][,]_[(47)] ˆ where _ei,k_ = _ti,k − wi,kxk_ is the measurement residual, and _wi,k_ is the _i_ -th row of _Wk_ . Defining the realized 

variational error as _Ei,k_ ≜ _e_[2] _i,k_[+] _[w][i,k][P][k][w] i,k[T]_[, we establish] the following theorem. 

**Theorem 5** _Suppose the forgetting factor ρi ∈_ (0 _,_ 1) _and the realized variational error sequence Ei,k is weakly stationary and uncorrelated, with mean_ E[ _Ei,k_ ] = _σi_[2] _[and] variance_ Var( _Ei,k_ ) = _ηi_[4] _[.][Then,][the][scale][parameter][se-] quence λ_[+] _i,k[defined by the recursive update]_[ (47)] _[ converges] in mean and variance as k →∞. Specifically, the steadystate mean and variance are given by:_ 

**==> picture [167 x 16] intentionally omitted <==**

**==> picture [178 x 23] intentionally omitted <==**

The proof is available at 6.9. We then analyze the transient behavior of E( _λ_[+] _i,k_[).] 

Taking the expectation of (47) and substituting the stationary mean E[ _Ei,k_ ] = _σi_[2][yields the recursive relation:] 

E[ _λ_[+] _i,k_[] =] _[ ρ][i]_[E][[] _[λ]_[+] _i,k−_ 1[] + (1] _[ −][ρ][i]_[)] _[σ] i_[2] _[.]_ (50) Subtracting _σi_[2][from both sides and recursively unrolling] the sequence to the initial step _k_ = 0 provides the explicit expression for the transient mean: 

E[ _λ_[+] _i,k_[] =] _[ σ] i_[2][+] _[ ρ][k] i_ �E[ _λ_[+] _i,_ 0[]] _[ −][σ] i_[2] � _._ (51) Equation (51) characterizes the estimator’s transient behavior. The term _ρ[k] i_ �E[ _λ_[+] _i,_ 0[]] _[ −][σ] i_[2] � represents the transient bias, which decays exponentially to zero. The convergence rate is governed by the forgetting factor _ρi_ , defining a tracking time constant 

**==> picture [182 x 11] intentionally omitted <==**

**Remark 4** _A smaller ρi accelerates the decay of the transient bias, leading to faster convergence to the steadystate mean σi_[2] _[.][However,][recalling][the][steady-state][vari-] ance in_ (49) _, a fundamental trade-off emerges: decreasing ρi improves transient tracking speed but amplifies the steady-state variance_[1] 1+ _[−] ρ[ρ] i[i][η] i_[4] _[.][Conversely,][a][ρ][i][closer][to]_ 1 _yields a smoother steady-state estimate with lower variance, at the cost of a prolonged transient phase. Therefore, the selection of ρi need balance the convergence rate against steady-state estimation precision._ 

## _3.5 Parameter Selection and Discussion_ 

Our proposed framework relies on three channel-specific hyperparameters: the scale parameter _τi_[2][,][the][DOF] _[ν][i]_[,] and the decay coefficient _ρi_ . Because the normalized nominal covariance is _E_ ( _ζkζk[T]_[)][=] _[I]_[,][we][set] _[τ]_[ 2] _i_ = 1. The parameter _νi_ reflects confidence in the nominal covariance; smaller values increase the temporary variance (17) to reject outliers, at the cost of degraded performance under pure Gaussian noise. Consequently, we recommend _νi →∞_ for Gaussian channels and _νi ∈_ [0 _._ 5 _,_ 5] for outlier-prone channels. 

8 

In the adaptive filters, the decay coefficient _ρi_ is crucial to prevent _νi,k_ from growing unbounded, which would otherwise erroneously recover the standard KF. As established in Theorems 5, _ρi_ balances tracking speed against variance smoothness. We advise setting _ρi ∈_ [0 _._ 95 _,_ 1). Setting _ρi_ = 1 recovers the STKF, which further simplifies to the standard KF if _νi →∞_ . 

Robustness and adaptability are competing objectives: robustness temporarily inflates the latent variance while keeping the prior fixed, whereas adaptability continuously updates the prior (42). To unify them, a probabilistic switching rule with Bernoulli indicator is utilized. An advantage of this framework is its channel-level flexibility. It allows practitioners to encode prior knowledge directly into the algorithm—for example, assigning static robust parameters (small _νi_ , _ρi_ = 1) to channels with frequent outliers, while enabling dynamic adaptation ( _ρi <_ 1) for channels experiencing time-varying noise. 

## **4 Simulations** 

This section evaluates the proposed algorithms through four numerical examples. 

## _4.1 Example 1_ 

We consider the following tracking problem: 

**==> picture [240 x 60] intentionally omitted <==**

1 0 , and _T_ = 0 _._ 01 is the sampling time. We consider � � the following two types of measurement noise: 

**==> picture [197 x 25] intentionally omitted <==**

where _Rt_ = [2(sin(0 _._ 04 _πkT_ ))[2] + 1] _R_ and _R_ = 0 _._ 1 in Case 2. 

In Case 1, we conduct simulations investigating the effects of _ν_ 3 in STKF and the result is shown in Fig. 2. One can see that the error performance of the STKF first decays with the increment of _ν_ 3 and then increases slowly, and finally coincides with the KF. In robust filtering scenarios, a too small _νi_ may induce instability and a too large _νi_ would damage the robustify effect. 

In Case 2 with adaptive measurement noise, we set the initial process and measurement covariance as _Q_ = _BB[T]_ , _R_ = 0 _._ 1, and use _ρ_ = 0 _._ 99 in VBKF. As in STKF-A, we apply the same initial process and measurement covariance as is used in VBKF. Moreover, we set _ρ_ 1 = _ρ_ 2 = 1, _ρ_ 3 = 0 _._ 99, _τi_[2][=][1][for] _[i]_[=][1] _[,]_[ 2] _[,]_[ 3,] 

**==> picture [156 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.2<br>0.15<br>0.1<br>0.05<br>0<br>10 20 30 40 50 60 70 80 90 100<br>**----- End of picture text -----**<br>


Fig. 2. Average RMSE (ARMSE) with different _ν_ 3 in STKF. 

Table 2 

Performance comparison of different estimators in different cases. 

|e 2<br>ormance <br>s.|comparison of diferent estimators in dif|
|---|---|
|Scenario|Estimators<br>RMSE of<br>_x_1<br>RMSE of<br>_x_2<br>avg. iteration<br>number|
|Case 1|VBKF-fxed<br>0.053<br>0.081<br>4<br>STKF<br>0.053<br>0.081<br>1.096<br>KF<br>0.111<br>0.129<br>1.0|
|Case 2|VBKF<br>0.092<br>0.086<br>4<br>STKF-A<br>0.092<br>0.086<br>2.190<br>KF<br>0.130<br>0.143<br>1.0|



_ν_ 1 = _ν_ 2 = 10[8] , and _ν_ 3 = 100. The estimated covariance obtained by STKF-A and by VBKF, as well as the ground measurement covariance, are visualized in Fig. 3. The corresponding error performances are summarized in Table 2. We find that the performance of STKF-A is identical to VBKF, but with a smaller average iteration number, benefiting from the break condition as shown in Line 10 of Algorithm 1. Both STKF-A and VBKF are significantly better than KF. 

**==> picture [144 x 129] intentionally omitted <==**

**----- Start of picture text -----**<br>
3<br>2.5<br>2<br>1.5<br>1<br>0.5<br>0<br>0 10 20 30 40 50<br>**----- End of picture text -----**<br>


Fig. 3. The measurement noise covariance (or variance) tracking performance of VBKF and STKF-A. 

## _4.2 Example 2_ 

Following system dynamics (53), we keep _ρ_ 1 = _ρ_ 2 = 1 and investigate the effect of _ρ_ 3 = _ρ_ by considering the 

9 

following step-like measurement covariance: 

**==> picture [200 x 37] intentionally omitted <==**

In the simulation, we compare the convergence speed of _ρ_ = 0 _._ 995, _ρ_ = 0 _._ 99, _ρ_ = 0 _._ 98, _ρ_ = 0 _._ 97 in Fig. 4, where the blue line denotes the ground truth variance, and the dashed black line is obtained by Theorems 5 and (52). We observe that practical convergence speed fits with the theoretical analysis very well, which verified the theorem. We further visualize the convergence speed and the steady state variance with respect to _ρ_ and give the corresponding RMSEs in Fig. 5. The results highlight a trade-off between the convergence speed and the steady state variance. 

**==> picture [240 x 121] intentionally omitted <==**

Fig. 4. Theoretical (based on Theorem 5) and practical variance convergence rate and the corresponding estimation variance with different _ρ_ . The time constant is obtained by (52), expressed in seconds. 

**==> picture [229 x 119] intentionally omitted <==**

**----- Start of picture text -----**<br>
2 0.12 0.2<br>1.8<br>1.6 0.1 0.18<br>1.4 0.08 0.16<br>1.2 0.14<br>1 0.06<br>0.8 0.12<br>0.6 0.04 0.1<br>0.4 0.02 0.08<br>0.2<br>0 0 0.06<br>0.9 0.92 0.94 0.96 0.98 1 0.9 0.92 0.94 0.96 0.98 1<br>(a) (b)<br>**----- End of picture text -----**<br>


Fig. 5. The trade-off effects of _ρ_ in STKF-A. (a) The trade-off between convergence time constant and convergence variance regarding _ρ_ . (b) The error performance with different _ρ_ . 

## _4.3 Example 3_ 

We consider a 1-DOF torsion load system with unknown disturbances as given in [36, 37]. The discrete system dynamics, with sampling time of _dt_ = 0 _._ 01 and maximum time step _Nt_ = 2000, are given by 

**==> picture [221 x 23] intentionally omitted <==**

with 

**==> picture [149 x 95] intentionally omitted <==**

where _xk_ = [ _θm, θt, vm, vt_ ] _[T] ∈_ R[4] represents the state vector, consisting of the angles at both the motor and load sides, as well as the velocities at the motor and load sides, _uk ∈_ R is the motor torque, _dk ∈_ R is the unknown disturbance, _yk_ is the noisy angle measurements at both motor and load sides. We augment the disturbance and the state as a new state and use a random walk model for the unknown disturbance dynamics by analogy to [13] to simultaneously estimate the disturbance and state, which gives 

**==> picture [183 x 23] intentionally omitted <==**

where 

**==> picture [221 x 67] intentionally omitted <==**

In the simulation, we consider the following three complex noise scenarios: (1) the process noise covariance is step-like where as the measurement covariance keeps constant; (2) the process noise is contaminated by outliers, where as the measurement noise covariance changes continually; (3) the process noise covariance keep constant, whereas the measurement noise covariance changes continually and is occasionally polluted by outliers, i.e., 

**==> picture [198 x 127] intentionally omitted <==**

with 

We compare the performance of VBKF, STKF-A (or STKF-AR), KF-DOB, as well as RBKF1, RBKF2, and RBKF3 (by analogously applying Rows 2, 3, and 4 of Table 1 in Algorithm 1). Specifically, in all estimators, we apply the same nominal process covariance using _Q[∗]_ = _Q_ and _R[∗]_ = _R_ , where _Q_ and _R_ are shown in (58). The 

10 

hyper-parameters of different estimators are tuned based on the properties of their losses and the characteristics of the noise, and are summarized in Table 3. Results demonstrate that the proposed methods are the best among the all filters. 

We further visualize the measurement covariance tracking of VBKF and STKF-AR in Case 2 and Case 3 in Figs. 6 and 7, respectively. We find that in both cases, the conventional VBKF fails to track the ground truth noise covariance, where the tracking process is destroyed by the process outliers in Case 2 and the measurement outliers in Case 3. Our proposed STKF-AR mitigates these problems, since the proposed methods address both the outliers and adaptive noise in a unified framework. 

**==> picture [238 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
7 1<br>6<br>0.8<br>5<br>4 0.6<br>3 0.4<br>2<br>0.2<br>1<br>0 0<br>0 5 10 15 20 0 5 10 15 20<br>(a) VBKF (b) STKF-AR<br>**----- End of picture text -----**<br>


Fig. 6. The measurement covariance (or variance) tracking performance of VBKF and STKF-AR in Case 2. The blue and red lines denote the estimated variance, and the green line denote the ground truth variance. (a) The performance of VBKF. (b) The performance of STKF-AR. 

**==> picture [238 x 114] intentionally omitted <==**

**----- Start of picture text -----**<br>
12 1<br>10<br>0.8<br>8<br>0.6<br>6<br>0.4<br>4<br>2 0.2<br>0 0<br>0 5 10 15 20 0 5 10 15 20<br>(a) VBKF (b) STKF-AR<br>**----- End of picture text -----**<br>


Fig. 7. The measurement covariance (or variance) tracking performance of VBKF and STKF-AR in Case 3. (a) The performance of VBKF. (b) The performance of STKF-AR. 

## _4.4 Example 4_ 

We consider the proprioceptive quadruped localization problem by fusing robot kinematics and IMU measurements on slippery terrain [38]. The system state at discrete time step _k_ is defined as: 

_xk_ = _{Rk, pk, vk, b[g] k[, b] k[a][, d]_[0] _[,k][, d]_[1] _[,k][, d]_[2] _[,k][, d]_[3] _[,k][}]_ where _Rk ∈ SO_ (3) denotes the base orientation; _pk, vk ∈_ R[3] represent the base position and velocity, respectively; _b[g] k[, b] k[a][∈]_[R][3][are][the][gyroscope][and][accelerometer][biases;] 

**==> picture [240 x 108] intentionally omitted <==**

where _ωk_ and _ak_ are the measured angular velocity and linear acceleration, respectively; _g_ is the gravity vector; _vdi,k_ is the foot velocity; ( _·_ ) _×_ denotes the skew-symmetric matrix operator; and _ηk[g][, η] k[a][, η][bg,k][, η][ba,k][, η][v,k][, η][p,k][, η][di,k]_[represent][mutually][in-] dependent, zero-mean Gaussian white noise processes driving the respective states; _δ_ = 0 _._ 001 s is the sampling time and the whole interval is 10 s. The foot position measurements derived from the joint encoders are modeled as: 

**==> picture [166 x 11] intentionally omitted <==**

where _f_ kin _,i_ ( _·_ ) denotes the forward kinematics function for the _i_ -th leg, _qk_ represents the joint configurations, and _ϵi,k_ is the associated zero-mean Gaussian measurement noise. 

The propagation of the foot positions exhibits a contactdependent switched behavior. During the swing phase, the foot velocity _vdi,k_ is unobservable. Consequently, we model it as _vdi,k_ ≜ 0 and assign an infinite process noise covariance ( _Qdi →∞_ ) to reflect this uncertainty. During the stance phase, assuming a rolling contact model, the foot velocity is determined by _vdi,k_ = ( _ωi,k_ ) _×rk_ . Here, _ωi,k_ is the angular velocity of the foot derived from the kinematics, and _rk_ = [0 _,_ 0 _, rc_ ] _[T]_ is the vector from the ground contact point to the joint center, with _rc_ being the effective rolling radius. Note that the Gaussian assumption for the process noise _ηdi,k_ is violated in two primary scenarios: during the initial touchdown phase, where ground impact induces impulsive disturbances, and when the rolling contact assumption fails due to foot slippage. 

We simulate a Unitree A1 quadruped traversing flat terrain interspersed with slippery belts in Gazebo, adopting the environment design from [39]. To address the impulsive process noise and potential slippage, we set _νp_ = [10[8] **1** _[T]_ 15 _×_ 1 _[,]_ **[ 1]** _[T]_ 12 _×_ 1[]] _[T]_[and] _[ν][r]_[=][10][8] **[1]**[12] _[×]_[1][.][Mean-] while, we apply _ρp_ = [ **1** _[T]_ 15 _×_ 1 _[, ρ][T] d[, ρ][T] d[, ρ][T] d[, ρ][T] d_[]] _[T]_[ ,][where] _ρd_ = [0 _._ 9 _,_ 0 _._ 9 _,_ 1] _[T]_ , and _ρr_ = **1** 12 _×_ 1. For the STKF baseline, we retain the same _νp_ and _νr_ , but assign _ρp_ = **1** 27 _×_ 1 and _ρr_ = **1** 12 _×_ 1. We benchmark the proposed method against a conventional Error-State Kalman Filter (ESKF) [38], and an Invariant Extended Kalman Filter (IEKF) [40]. The localization errors are detailed in Table 4, where the RMSEs of a vector _ep_ is computed via _ep_ = _∥_ [ _epx, epy, epz_ ] _∥_ 2 with _epx_ , _epy_ , and _epz_ are the 

11 

Table 3 

Performance comparison of different estimators in complex noise scenarios. 

|Scenario|Estimators<br>Hyper-parameters<br>RMSE of_x_1<br>RMSE of_x_2<br>RMSE of_x_3<br>RMSE of_x_4<br>RMSE of_x_5|
|---|---|
|Case 1|VBKF<br>_ρ_= 0_._98<br>0.710<br>2.609<br>2.717<br>71.101<br>111.818<br>STKF-A<br>_ν_**p** = 100_·_**1**5,_ν_**r** = 108**1**2<br>_ρ_**p** = 0_._98_·_**1**5,_ρ_**r** =**1**2<br>0.507<br>0.237<br>0.249<br>58.162<br>64.819<br>KF<br>_∅_<br>0.604<br>0.589<br>0.477<br>55.350<br>71.400<br>RBKF1<br>_ν_**p** = 2_·_**1**5, _ν_**r** = 108 _·_**1**2<br>0.557<br>0.258<br>0.265<br>55.888<br>62.650<br>RBKF2<br>_ν_**p** = 0_._5_·_**1**5, _ν_**r** = 1_._999_·_**1**2<br>0.535<br>0.254<br>0.259<br>55.664<br>60.958<br>RBKF3<br>_ν_**p** = 1_·_**1**5, _ν_**r** = 108 _·_**1**2<br>0.555<br>0.273<br>0.271<br>55.093<br>60.377|
|Case 2|_ρ_= 0_._98<br>VBKF<br>0.408<br>0.625<br>0.863<br>32.089<br>58.726<br>STKF-AR<br>_ν_**p** = 3_·_**1**5,_ν_**r** = 100**1**2<br>_ρ_**p** = 1_·_**1**5,_ρ_**r** = 0_._98_·_**1**2<br>0.375<br>0.423<br>0.503<br>28.231<br>47.228<br>KF<br>_∅_<br>0.468<br>0.416<br>0.515<br>28.315<br>49.509<br>RBKF1<br>_ν_**p** = 2_·_**1**5, _ν_**r** = 2_·_**1**2<br>0.392<br>2.151<br>2.263<br>35.268<br>62.601<br>RBKF2<br>_ν_**p** = 0_._5_·_**1**5, _ν_**r** = 0_._5_·_**1**2<br>0.380<br>0.743<br>0.978<br>32.881<br>59.835<br>RBKF3<br>_ν_**p** =**1**5, _ν_**r** =**1**2<br>0.386<br>0.502<br>0.754<br>30.510<br>56.959|
|Case 3|VBKF<br>_ρ_= 0_._98<br>0.200<br>0.359<br>0.406<br>15.085<br>23.448<br>STKF-AR<br>_ν_**p** = 108 _·_**1**5,_ν_**r** = 100**1**2<br>_ρ_**p** =**1**5,_ρ_**r** = 0_._98_·_**1**2<br>0.203<br>0.322<br>0.389<br>15.165<br>22.948<br>KF<br>_∅_<br>0.359<br>0.600<br>0.524<br>21.320<br>34.781<br>RBKF1<br>_ν_**p** = 108 _·_**1**5, _ν_**r** = 2_·_**1**2<br>0.229<br>0.428<br>0.508<br>16.257<br>24.640<br>RBKF2<br>_ν_**p** = 1_._999_·_**1**5, _ν_**r** = 0_._5_·_**1**2<br>0.210<br>0.363<br>0.425<br>15.576<br>23.530<br>RBKF3<br>_ν_**p** = 108 _·_**1**5, _ν_**r** =**1**2<br>0.215<br>0.341<br>0.411<br>15.554<br>23.630|



RMSE of each axis. The corresponding trajectory visualizations are in Fig. 8. These results demonstrate the effectiveness of the proposed methods. 

Table 4 

RMSEs of the base position, velocity, and Euler angle of different estimators. 

|mators.||||
|---|---|---|---|
|**Alg**|_ep_ **(m)**|_ev_ **(m/s)**|_eθ_ **(deg)**|
|IEKF|0.0467|0.0383|0.4450|
|ESKF|0.1117|0.0382|0.5097|
|STKF|0.0348|0.0230|0.2477|
|STKF-AR|0.0247|0.0245|0.2362|



**==> picture [204 x 168] intentionally omitted <==**

Fig. 8. 3D trajectory visualization of different estimators. The GR denotes the ground truth position. 

## **5 Conclusion** 

This work bridges the gap between the robust Kalman filter and the adaptive filter. Specifically, we prove that the STKF, derived by the Student’s _t_ -distribution induced loss and solved by fixed-point iteration, can be understood as a prerequisite of the VBKF. On this basis, we provide necessary conditions for a class of losses that can be solved by a fixed-point solution, which is much more computation-efficient than gradient-based solutions. Leveraging the variational technique, we derive two robust-adaptive filters, STKF-A and STKFAR. We demonstrate that there is a trade-off between tracking speed and tracking variance in terms of covariance tracking in adaptive filters, highlighting the importance of selecting proper forgetting factors. Our proposed approaches can recover KF, STKF (robust filters), VBKF (adaptive filters), and can address complex noise scenarios with mixing outliers and adaptive noises. Simulations verify the effectiveness of the proposed method. 

## **6 Appendix** 

_6.1 Appendix A_ 

**PROOF.** According to _x_ lim _→_ 0[log(1 +] _[ x]_[)][=] _[x]_[,][it][follows] that 

**==> picture [185 x 25] intentionally omitted <==**

12 

and hence _Lst_ = _Lgau_ as _ν →∞_ . As _ν_ = 1, one observes that _Lst_ =[1] 2[log] �1 + _τ[e]_[2][2] � which becomes Cauchy loss and corresponds to Cauchy distribution. This completes the proof. 

## _6.2 Appendix B_ 

**PROOF.** It is easy to obtain the Hessian matrix of _Lst_ as follows 

**==> picture [190 x 25] intentionally omitted <==**

It is obvious that _H_ ( _Lst_ ) _≥_ 0 as _e ∈_ [ _−[√] ντ,[√] ντ_ ] and _H_ ( _Lst_ ) _<_ 0 otherwise. This completes the proof. 

## _6.3 Appendix C_ 

**PROOF.** According to (3), one has 

**==> picture [191 x 26] intentionally omitted <==**

By applying Stirling’s approximation, we have Γ( _ν/_ 2) _∼ √_ 2 _π_ ( _[ν]_ 2[)] _[ν/]_[2] _[−]_[0] _[.]_[5][ exp(] _[−][ν/]_[2).][It][follows][that] 

**==> picture [247 x 63] intentionally omitted <==**

Let _f_ ( _λ_ ) = _[τ] λ_[ 2][exp(1] _[ −][τ] λ_[ 2][). It is easy to verify that] _[ f]_[(] _[λ]_[)] reaches its unique global maximum at _λ_ = _τ_[2] , where _f_ ( _τ_[2] ) = 1. For any _λ_ = _τ_[2] , we have 0 _< f_ ( _λ_ ) _<_ 1. Consequently, as _ν →∞_ , the term _f_ ( _λ_ ) _[ν/]_[2] approaches 0 everywhere except at _λ_ = _τ_[2] . Meanwhile, the prefactor _ν_ 1[to] _[∞]_[at] _[λ]_[=] _[τ]_[ 2][,][ensuring][the][integral][over] ~~�~~ 4 _π λ_[goes] the probability density space remains 1. This indicates that _p_ ( _λ_ ) converges to a shifted Dirac delta function _δ_ ( _λ − τ_[2] ). This completes the proof. 

According to matrix theory, we have 

**==> picture [240 x 83] intentionally omitted <==**

**==> picture [233 x 42] intentionally omitted <==**

1 where (II) comes form the fact _dνi_ ( _ei_ ) _≤ τi_[2][. Substituting] the expression of _Rww_ and _Rwt_ into (63), one arrives _∥f_ ( _x_ ) _∥_ 1 _≤_ _**ϕ**_ ( _**ν**_ ) = _√n_[�] _[l] i τ_ 1 _i_[2] _[∥][w] i[T][∥]_[1] _[|][t][i][|] . λ_ min[[�] _[l] i_ =1 _[w] i[T][d][ν] i_[(] _[|][t][i][|]_[ +] _[ γ][|][w] i[T][|]_[1][)] _[w][i]_[]] (66) 

In the case _ν_ 1 = _ν_ 2 = _. . ._ = _νl_ = _ν_ , _**ϕ**_ ( _**ν**_ ) degenerates to _ϕ_ ( _ν_ ) as follows: 

**==> picture [224 x 35] intentionally omitted <==**

which is a _decreasing function_ of _ν_ . Moreover, we have 

**==> picture [235 x 36] intentionally omitted <==**

This indicates that if _γ > ξ_ , _ϕ_ ( _ν_ ) = _γ_ always has a unique solution _ν[∗]_ over [0 _, ∞_ ]. Subsequently, we consider a much more general case _νi ≥ ν[∗]_ for _i_ = 1 _,_ 2 _, . . . , l_ . One observes that _wi[T][d][ν] i_[(] _[|][t][i][|]_[ +] _[ γ][|][w] i[T][|]_[1][)] _[w][i]_[is][a][positive] diagonal matrix and _dνi_ ( _·_ ) _≥ dν∗_ ( _·_ ) if _νi ≥ ν[∗]_ . It follows that 

**==> picture [127 x 11] intentionally omitted <==**

This completes the proof. 

## _6.5 Appendix E_ 

## _6.4 Appendix D_ 

**PROOF.** Denoting _Rww_ = _Wk[T][D][k][W][k]_[and] _[R][wt]_[=] _Wk[T][D][k][t][k]_[,][it][follows][that] _[f]_[(] _[x]_[)][=] _[R] ww[−]_[1] _[R][wt]_[according][to] (15). Since the induced norm is compatible with vector _ℓp_ norm, we have _∥f_ ( _x_ ) _∥_ 1 = _∥Rww[−]_[1] _[R][wt][∥]_[1] _[≤∥][R] ww[−]_[1] _[∥]_[1] _[∥][R][wt][∥]_[1] _[.]_ (63) 

**==> picture [240 x 52] intentionally omitted <==**

13 

completes the proof. 

where **U** and **V** are matrices and x is a scalar, we have the following equation: 

**==> picture [323 x 92] intentionally omitted <==**

**PROOF.** One observes that _Condition 1_ ensures that _J_ _**ν**_ ( _e_ ) is a well-defined loss function. _Condition 2_ guarantees the validity of (66). _Condition 3_ guarantees the validity of (71). _Condition 4_ (combined with the above three conditions) guarantees the hold of the inequality in (18) by analogy with the proof of Theorems 1 and 2. This completes the proof. 

(68) 

where _wi,j_ is the _j_ -th element of _wi_ and _xj_ is _j_ -th element of vector _x_ . Take one norm in both sides of (68), we have 

**==> picture [248 x 64] intentionally omitted <==**

## _6.7 Appendix G_ 

**==> picture [240 x 25] intentionally omitted <==**

**==> picture [18 x 11] intentionally omitted <==**

We follow the standard VB-approach and approximate the joint distribution using a factored form as follows: 

For the first term on the right side of (69), we have 

**==> picture [205 x 90] intentionally omitted <==**

_p_ ( _xk, Rζζk |tk_ ) _≈ Qx_ ( _xk_ ) _QR_ ( _Rζζk_ ) _._ (75) Then, one can minimize the Kullback-Leibler (KL) divergence between the approximated distribution and the true posterior: 

**==> picture [226 x 39] intentionally omitted <==**

where (I) comes from the convexity of vector _ℓ_ 1 norm and _f_ ( _x_ ) _≤ γ_ , and (II) comes from _|wi,jei| ≤_ ( _|ti|_ + _γ∥wi∥_ 1) _∥wi[T][∥]_[1][and] ( _νiτi_[2][+] _νi[e][T] i[e][i]_[)][2] _[≤] νi_ 1 _τi_[4][.][Similarly,][we] have 

Minimizing the KL divergence with respect to _QR_ ( _Rζζk_ ) gives 

_QR_ ( _Rζζk_ ) _∝_ exp(E _Qx_ [log _p_ ( _xk, Rζζk , tk_ )]) _._ (77) Letting _λi,k_ denote the _i_ -th diagonal element of _Rζζk_ , and dropping terms independent of _Rζζk_ , one has: 

**==> picture [199 x 43] intentionally omitted <==**

**==> picture [233 x 57] intentionally omitted <==**

Substituting (64), (70), and (71) into (69), we obtain 

**==> picture [242 x 72] intentionally omitted <==**

where _⟨·⟩x_ = � ( _·_ ) _Qx_ ( _xk_ )d _xk_ . By evaluating the expectations in (78), and matching the parameters of the distributions on the left and right hand sides to the inverse gamma distribution, we obtain 

**==> picture [234 x 42] intentionally omitted <==**

By setting _νi_ = _ν_ for all _i_ , the function _**ψ**_ ( _**ν**_ ) degenerates to (21). In such cases, one has 

**==> picture [169 x 24] intentionally omitted <==**

where _x_ ˆ _k_ and _Pk_ are obtained by the fixed-point iteration by solving (15), and the updated Inverse-Gamma parameters _νi,k_[+][and][(] _[τ]_[ 2] _i,k_[)][+][are][given][by][the][following] equations: 

One can see that (73) is a continuous and strictly decreasing function satisfying lim[=] _[∞]_[and] _ν→_ 0[+] _[ ψ]_[(] _[ν]_[)] lim[has a unique] _ν→∞[ψ]_[(] _[ν]_[) = 0. This implies that] _[ ψ]_[(] _[ν]_[) =] _[ η]_ solution _ν_[+] and _ψ_ ( _ν_ ) _≤ η_ if _ν ≥ ν_[+] . Observing (72) and (73), we have _**ψ**_ ( _**ν**_ ) _≤ ψ_ ( _ν_[+] ) if _νi ≥ ν_[+] for all _i_ . This indicates that 0 _<_ _**ψ**_ ( _**ν**_ ) _≤ η_ if _∀i, νi ≥ ν_[+] . This 

**==> picture [223 x 46] intentionally omitted <==**

14 

This completes the proof. 

## _6.8 Appendix H_ 

According to the inverse-Gamma distribution in (3), we have 

**==> picture [199 x 23] intentionally omitted <==**

where _C_ is a constant independent of _λ_ . The mode _λ_ 0 is obtained by setting the first derivative to zero: 

**==> picture [233 x 38] intentionally omitted <==**

Because _λ_ 0 is a local maximum, the first-order term in the Taylor expansion vanishes exactly. The second derivative evaluated at the mode is: 

**==> picture [223 x 27] intentionally omitted <==**

Consequently, the Taylor expansion of ln _p_ ( _λ_ ) simplifies to: 

**==> picture [204 x 23] intentionally omitted <==**

By matching this quadratic form to the logarithm of a Gaussian probability density function ln _q_ ( _λ_ ; _µ, σ_[2] ) = _−_[(] _[λ]_ 2 _[−] σ[µ]_[2][)][2] + _C[′]_ , we obtain the approximated normal distribution: 

**==> picture [185 x 25] intentionally omitted <==**

## _6.9 Appendix I_ 

**PROOF.** In steady state ( _k →∞_ ), the sequence converges to a weakly stationary random variable _λ_[+] _i,∞_[sat-] isfying: 

**==> picture [126 x 14] intentionally omitted <==**

**Mean:** Taking the expectation of both sides and substituting E[ _Ei,∞_ ] = _σi_[2][yields:] E[ _λ_[+] _i,∞_[] =] _[ ρ][i]_[E][[] _[λ]_[+] _i,∞_[] + (1] _[ −][ρ][i]_[)] _[σ] i_[2][=] _[⇒]_[E][[] _[λ]_[+] _i,∞_[] =] _[ σ] i_[2] _[.]_ 

**Variance:** Because _λ_[+] _i,k−_ 1[strictly][depends][on][past][er-] rors, it is uncorrelated with the current error _Ei,k_ . Taking the variance of both sides gives: 

Var( _λ_[+] _i,∞_[) =] _[ ρ] i_[2][Var(] _[λ]_[+] _i,∞_[) + (1] _[ −][ρ][i]_[)][2][Var(] _[E][i,][∞]_[)] _[.]_ Substituting Var( _Ei,∞_ ) = _ηi_[4][and isolating Var(] _[λ]_[+] _i,∞_[), we] obtain: 

**==> picture [161 x 26] intentionally omitted <==**

## **References** 

- [1] A. Harvey, E. Ruiz, and N. Shephard, “Multivariate stochastic variance models,” _The Review of Economic Studies_ , vol. 61, no. 2, pp. 247–264, 1994. 

- [2] P. L. Houtekamer and F. Zhang, “Review of the ensemble Kalman filter for atmospheric data assimilation,” _Monthly Weather Review_ , vol. 144, no. 12, pp. 4489–4532, 2016. 

- [3] K. Course and P. B. Nair, “State estimation of a physical system with unknown governing equations,” _Nature_ , vol. 622, no. 7982, pp. 261–267, 2023. 

- [4] T. Nishimura, “On the a priori information in sequential estimation problems,” _IEEE Transactions on Automatic Control_ , vol. 11, no. 2, pp. 197–204, 1966. 

- [5] M. Grimble, “ _H∞_ design of optimal linear filters,” _Linear Circuit Systems and Signal Processing: Theory and Application (Proc. MTNS’87)_ , pp. 533–540, 1988. 

- [6] L. Chang, B. Hu, G. Chang, and A. Li, “Huberbased novel robust unscented Kalman filter,” _IET Science, Measurement & Technology_ , vol. 6, no. 6, pp. 502–509, 2012. 

- [7] A. K. Roonizi, “ _ℓ_ 2 and _ℓ_ 1 trend filtering: A Kalman filter approach,” _IEEE Signal Processing Magazine_ , vol. 38, no. 6, pp. 137–145, 2021. 

- [8] G. Wang, C. Yang, and X. Ma, “A novel robust nonlinear Kalman filter based on multivariate Laplace distribution,” _IEEE Transactions on Circuits and Systems II: Express Briefs_ , vol. 68, no. 7, pp. 2705– 2709, 2021. 

- [9] Y. Huang, Y. Zhang, N. Li, Z. Wu, and J. A. Chambers, “A novel robust student’s t-based Kalman filter,” _IEEE Transactions on Aerospace and Electronic Systems_ , vol. 53, no. 3, pp. 1545–1554, 2017. 

- [10] J. C. Principe, _Information theoretic learning: Renyi’s entropy and kernel perspectives_ . Springer Science & Business Media, 2010. 

- [11] V. Vapnik, _The nature of statistical learning theory_ . Springer science & business media, 2013. 

- [12] S. Li, D. Shi, W. Zou, and L. Shi, “Multi-kernel maximum correntropy Kalman filter,” _IEEE Control Systems Letters_ , vol. 6, pp. 1490–1495, 2021. 

- [13] S. Li, D. Shi, Y. Lou, W. Zou, and L. Shi, “Generalized multi-kernel maximum correntropy Kalman filter for disturbance estimation,” _IEEE Transactions on Automatic Control_ , 2023. 

- [14] M. Bai, Y. Huang, Y. Zhang, and J. Chambers, “Statistical similarity measure-based adaptive outlier-robust state estimator with applications,” _IEEE Transactions on Automatic Control_ , vol. 67, no. 8, pp. 4354–4361, 2022. 

- [15] M. V. Kulikova, “Chandrasekhar-based maximum correntropy Kalman filtering with the adaptive kernel size selection,” _IEEE Transactions on Automatic Control_ , vol. 65, no. 2, pp. 741–748, 2019. 

- [16] A. Singh and J. C. Principe, “Using correntropy as 

15 

   - a cost function in linear adaptive filters,” in _2009 International Joint Conference on Neural Networks_ . IEEE, 2009, pp. 2950–2955. 

- [17] R. Kashyap, “Maximum likelihood identification of stochastic linear systems,” _IEEE Transactions on Automatic Control_ , vol. 15, no. 1, pp. 25–34, 1970. 

- [18] Y. Meng, S. Gao, Y. Zhong, G. Hu, and A. Subic, “Covariance matching based adaptive unscented Kalman filter for direct filtering in ins/gnss integration,” _Acta Astronautica_ , vol. 120, pp. 171–181, 2016. 

- [19] D. M. Blei, A. Kucukelbir, and J. D. McAuliffe, “Variational inference: A review for statisticians,” _Journal of the American Statistical Association_ , vol. 112, no. 518, pp. 859–877, 2017. 

- [20] S. Sarkka and A. Nummenmaa, “Recursive noise adaptive Kalman filtering by variational bayesian approximations,” _IEEE Transactions on Automatic control_ , vol. 54, no. 3, pp. 596–600, 2009. 

- [21] Y. Huang, Y. Zhang, Z. Wu, N. Li, and J. Chambers, “A novel adaptive Kalman filter with inaccurate process and measurement noise covariance matrices,” _IEEE transactions on Automatic Control_ , vol. 63, no. 2, pp. 594–601, 2017. 

- [22] Y. Huang, Y. Zhang, P. Shi, and J. A. Chambers, “Variational adaptive kalman filter with gaussianinverse-wishart mixture distribution,” _IEEE Transactions on Automatic Control_ , vol. 66, pp. 1786– 1793, 2021. 

- [23] D. Cetenovi´c, J. Zhao, V. Levi, Y. Liu, and V. Terz-[´] ija, “Variational bayesian unscented Kalman filter for active distribution system state estimation,” _IEEE Transactions on Power Systems_ , 2024. 

- [24] P. Dong, Z. Jing, H. Leung, and K. Shen, “Variational bayesian adaptive cubature information filter based on wishart distribution,” _IEEE Transactions on Automatic Control_ , vol. 62, no. 11, pp. 6051– 6057, 2017. 

- [25] A. Aravkin, J. V. Burke, L. Ljung, A. Lozano, and G. Pillonetto, “Generalized Kalman smoothing: Modeling and algorithms,” _Automatica_ , vol. 86, pp. 63–86, 2017. 

- [26] B. Chen, L. Xing, H. Zhao, N. Zheng, J. C. Prı _et al._ , “Generalized correntropy for robust adaptive filtering,” _IEEE Transactions on Signal Processing_ , vol. 64, no. 13, pp. 3376–3387, 2016. 

   - [30] B. Gao, G. Hu, Y. Zhong, and X. Zhu, “Cubature kalman filter with both adaptability and robustness for tightly-coupled gnss/ins integration,” _IEEE Sensors Journal_ , vol. 21, pp. 14 997–15 011, 2021. 

   - [31] H. Zhu, G. Zhang, Y. Li, and H. Leung, “An adaptive kalman filter with inaccurate noise covariances in the presence of outliers,” _IEEE Transactions on Automatic Control_ , vol. 67, pp. 374–381, 2021. 

   - [32] A. Gelman, J. B. Carlin, H. S. Stern, and D. B. Rubin, _Bayesian data analysis_ . Chapman and Hall/CRC, 1995. 

   - [33] B. Chen, J. Wang, H. Zhao, N. Zheng, and J. C. Principe, “Convergence of a fixed-point algorithm under maximum correntropy criterion,” _IEEE Signal Processing Letters_ , vol. 22, no. 10, pp. 1723– 1727, 2015. 

   - [34] T. D. Barfoot, _State estimation for robotics_ . Cambridge University Press, 2024. 

   - [35] R. Weinstock, “Calculus of variations: with applications to physics and engineering,” 1952. 

   - [36] S. Zhao, Y. S. Shmaliy, P. Shi, and C. K. Ahn, “Fusion Kalman/UFIR filter for state estimation with uncertain parameters and noise statistics,” _IEEE Transactions on Industrial Electronics_ , vol. 64, no. 4, pp. 3075–3083, 2016. 

   - [37] X. Luan, W. Xue, S. Zhao, and F. Liu, “A Kalman & fading memory co-filter for uncertain systems based on self-perception mechanism,” _IEEE Transactions on Automatic Control_ , 2025. 

   - [38] W. Li, Z. Chen, S. Li, X. Xiong, and Y. Lou, “Interacting multiple model proprioceptive odometry for legged robots,” _arXiv preprint arXiv:2603.29383_ , 2026. 

   - [39] Q. Liao, Z. Li, A. Thirugnanam, J. Zeng, and K. Sreenath, “Walking in narrow spaces: Safety-critical locomotion control for quadrupedal robots with duality-based optimization,” in _2023 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)_ . IEEE, 2023, pp. 2723–2730. 

   - [40] R. Hartley, M. Ghaffari, R. M. Eustice, and J. W. Grizzle, “Contact-aided invariant extended kalman filtering for robot state estimation,” _The International Journal of Robotics Research_ , vol. 39, no. 4, pp. 402–430, 2020. 

- [27] G. Chang, C. Chen, Q. Zhang, and S. Zhang, “Variational bayesian adaptation of process noise covariance matrix in Kalman filtering,” _Journal of the Franklin Institute_ , vol. 358, no. 7, pp. 3980–3993, 2021. 

- [28] G. Chang, “Kalman filter with both adaptivity and robustness,” _Journal of Process Control_ , vol. 24, no. 3, pp. 81–87, 2014. 

- [29] K. Li, L. Chang, and B. Hu, “A variational bayesian-based unscented Kalman filter with both adaptivity and robustness,” _IEEE Sensors Journal_ , vol. 16, no. 18, pp. 6966–6976, 2016. 

16 

