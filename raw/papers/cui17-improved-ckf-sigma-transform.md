---
title: "Improved Cubature Kalman Filter for GNSS/INS Based on Transformation of Posterior Sigma-Point Errors"
journal: "IEEE Trans. Signal Processing, 65(11), 2975-2987."
authors: ['Cui, B.', 'Chen, X.', 'Tang, X.']
year: 2017
source: paper
ingested: 2026-05-09
sha256: 8b98f3aff438ee0cfb95eec70eaf74eab3f0dc7abf5965d4a8485e328c391c48
conversion: pymupdf4llm
---

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2975 

# Improved Cubature Kalman Filter for GNSS/INS Based on Transformation of Posterior Sigma-Points Error 

Bingbo Cui, Xiyuan Chen _, Senior Member, IEEE_ , and Xinhua Tang 

_**Abstract**_ **—Tightly coupled GNSS/INS has been widely approved as a promising substitute for standalone GNSS in urban areas navigation. However, due to the frequent GNSS signal outages, the filter used in GNSS/INS should be insensitive to the less informative observations. In this paper, a novel sigma-points update method is proposed to enhance the robustness of cubature Kalman filter (CKF) under the circumstance of unavailable observations. First, the problems of existing sampling-based filters are analyzed. Then, by transforming the posterior sigma-points error matrix from prediction phase of filtering to the posterior domain of update, the updated sigma-points are expected to capture the covariance more precisely than traditional sigma-points. Finally, an improved CKF (ICKF) is developed by embedding these points into the Bayesian estimation framework, and the upper bounds of error covariance matrices are analyzed theoretically. Signal outages with different durations are simulated and results demonstrate that ICKF outperforms state-of-the-art methods.** 

_**Index Terms**_ **—Deterministic sampling, integrated navigation, cubature Kalman filter, observations missing.** 

## I. INTRODUCTION 

LOBAL navigation satellite system (GNSS) has been **G** widely applied in vehicle and pedestrians navigation because of good long-term accuracy and all-weather navigation ability. However, GNSS suffers from signal attenuation which often occurs in urban and indoor areas, such as interference, multipath and signal shading. Tightly coupled GNSS/INS has been widely approved as a promising substitute for standalone GNSS in the navigation of urban areas, because of its better stability and reliability. Due to the nonlinearity of measurement function and INS system equation, the data fusion in tightly coupled GNSS/INS is a typical nonlinear filtering problem. Unlike 

Manuscript received July 25, 2016; revised January 22, 2017 and February 26, 2017; accepted February 27, 2017. Date of publication March 8, 2017; date of current version April 10, 2017. The associate editor coordinating the review of this manuscript and approving it for publication was Prof. Gustau Camps-Valls. This work was supported in part by the National Natural Science Foundation of China (51375087), and in part by the Scientific Research Foundation of Graduate School of Southeast University (YBJJ1574). _(Corresponding author: Xiyuan Chen.)_ 

The authors are with the Key Laboratory of Micro-Inertial Instrument and Advanced Navigation Technology Ministry of Education, School of Instrument Science and Engineering, Southeast University, Nanjing 210096, China (e-mail: cuibingbo@163.com; chxiyuan@seu.edu.cn; xinhuatanggnss@163.com). 

Color versions of one or more of the figures in this paper are available online at http://ieeexplore.ieee.org. Digital Object Identifier 10.1109/TSP.2017.2679685 

in linear Gaussian model where Kalman filter (KF) provides optimal solution in the sense of minimum variance criterion, it is intractable to compute the optimal solution in nonlinear cases. In the framework of Bayesian, many sub-optimal approaches have been proposed for the purpose of state estimation. 

Shortly after the celebrated work of Kalman [1], extended Kalman filter (EKF) was proposed to approximate the integrals involved in the update of the probability density function (pdf) of latent dynamic state [2], [3]. However, EKF may fail when significant nonlinearities or large initial estimation errors are addressed [4], [5]. Julier and Uhlmann proposed unscented Kalman filter (UKF) by using deterministic sampling of previous pdf’s to approximate the posterior pdf [6]. Due to its positive features in better accuracy and similar computational cost compared with EKF, UKF has become a preferable alternative for nonlinear filtering. From the view point of numerical integration, other sampling-based filtering methods have been proposed, e.g. Gauss-Hermite quadrature filter (GHQF) based on GaussHermite quadrature rule [7], [8], cubature Kalman filter (CKF) based on cubature rule [9], etc. It has been approved that CKF has better stability and accuracy than UKF when used in high dimension filtering problems [9], [10]. The above-mentioned filters include sigma-representation of the pdf of random variable, so they belong to a general class of sigma-point Kalman filter (SPKF). Performance comparisons between EKF and SPKF in GNSS/INS have been done in previous works, which however, show inconsistent results [11], [12]. Recently, Zhao studied the performance of CKF in tightly coupled GNSS/IMU based on observability analysis [13], and results indicate that CKF performs better than EKF in case of large initial yaw error and weak observability. Because the typical dimension of tightly coupled GNSS/INS is 17 or higher [11]–[13], we focus on improving the usage of CKF in our work. 

Differ from SPKF, where the posterior pdf is represented by using deterministically chosen weighted sample points, particle filter (PF) represents the pdf with randomly selected weighted points [14]. PF estimates the whole posterior pdf instead of its first two moments, which can approach optimal Bayesian estimate for nonlinear and non-Gaussian filtering problem [15]. However, besides the inherent problems of PF (e.g., selection of important density and solution to the particle degeneracy) [16], a high computational burden hinders PF from widely application in integration navigation system. It should be noticed that SPKF may fail when frequent signal outages occur or prior information 

1053-587X © 2017 IEEE. Personal use is permitted, but republication/redistribution requires IEEE permission. See http://www.ieee.org/publications standards/publications/rights/index.html for more information. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2976 

is of large error. Shmaliy proposed a robust Kalman-like filter for state estimation with unknown prior information by utilizing unbiased finite impulse response estimator [17]. By combining strong tracking KF with wavelet neural network, Chen derived a hybrid filter to bridge GPS outages [18]. Besides the state delay in estimation, both of the two methods need careful selection of model parameters, which limits their usages on some special cases. 

There are three aspects in a sampling-based filter: sigmarepresentation, approximation of the joint pdf, and recursive filters [19]. Most of current sampling-based filters focus on the improvement of the former two aspects, which neglects their intrinsic correlation in the recursive update. It is generally recognized that UKF (or CKF) can reach the accuracy of second order [20] and part of the higher orders in Taylor series sense [21] of the moments of pdf. However, it does not indicate that UKF can give correct mean and covariance for arbitrary nonlinear function, e.g., informative high-order terms are dropped in the covariance series when 3-degree cubature rule is used for tight GNSS/INS. Existing sampling methods, which drop the information of dynamic system except the mean and covariance, may degrade the estimation of non-direct observable states as they can only be corrected by the off-diagonal elements of prediction covariance [22]. 

When the measurement noise is small, the residual resulting from the approximation of measurement function has a great effect on the posterior pdf [23]. Garc´ıa-Fern´andez _et al._ proposed two methods to improve the performance of Bayesian update, one is based on truncating the prior pdf by using the likelihood [24] and the other performs statistical linear regression (SLR) with respect to the posterior pdf [25]. However, the former limits its usage to bijective measurement function and the later needs an iterative procedure to approximate the posterior which increases its complexity. Furthermore, regarding the generation of sample points, it has been reported there is “non-local sampling” problem in CKF when high dimension filtering problems involved [26]. To approximate the posterior pdf, the predicted pdf and the measurement noise are both assumed to be Gaussian distribution, which may introduce errors if there are uncertainties in system models. However, it is generally recognized that a Gaussian state predictive density at each recursive step is closely satisfied in practical application [27]. Because the dynamic model of GNSS/INS is rather accurate, we should expect that the residual of the SLR in approximating process function with respect to the previous posterior pdf could be used in the generation of sigma-points for approximating process function in next filtering period. In a word, in the approximation of intractable integrals consisted in Gaussian filters, the information of propagated sigma-points has not been fully utilized in the two stage Bayesian estimation framework. 

Inspired by the work of Garc´ıa-Fern´andez and [28], an efficient sampling framework is proposed for high dimension navigation filtering problems, which is especially useful when the observations noise is sometimes sufficient small and the sensors suffer from frequent signal outages. Based on the truth that the first moment is more accurate than the second moment with symmetric choice of the representative points, an improved CKF 

(ICKF) is developed by using the 3-degree cubature rule. Unlike the work in [28], we consider the stochastic uncertainty in the implementation of recursive cubature points update. That is, the cubature points are initialized based on Gaussian assumption, and then their re-generation is substituted by a linear transformation of the residual of the SLR of process function without constructing prior pdf. The benefits of ICKF compared with other Gaussian filters are analyzed in numerical example. 

The rest of this paper is arranged as follows. Section II analyzes the accuracy of CKF and points out the problems of existing sampling-based filters. The ICKF and its accuracy analysis are given in Section III. Section IV validates the theoretical analysis and illustrates the proposed algorithm with numerical simulation. Finally, conclusions are given. 

## II. PROBLEMS FORMULATION 

Considering a random variable **x** has mean **¯x** and covariance _Pxx_ , and a second random variable **z** is related to **x** by **z** = _h_ ( **x** ). Let _n_ be the dimension size of **x** , the problem is to calculate the estimation of **z** with mean **¯z** and covariance _Pzz_ . Expanding **z** into Taylor series around **¯x** as 

**==> picture [219 x 48] intentionally omitted <==**

where **e** is the perturbation terms. Let _ej_ be the _j_ th component of **e** , then we have 

**==> picture [194 x 39] intentionally omitted <==**

The expected value of **z** can be expressed as [20] 

**==> picture [253 x 78] intentionally omitted <==**

where _mc_ 1 _c_ 2 _···c i_ is the _i_ th-order moment of **e** . To capture the _m_ th order of the mean in Taylor series, both the moments of **e** and D _[i]_ **e**[h][must][be][known][to] _[m]_[th][order.][The][perturbation][terms] of original CKF are selected as 

**==> picture [185 x 13] intentionally omitted <==**

Because of the symmetrical distribution of **ex** _i_ all the odd moments sum up to zero. Rewriting (3) as 

**==> picture [231 x 56] intentionally omitted <==**

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

2977 

where _∇[T]_ = [ _∂/∂x_ 1 _· · · ∂/∂xn_ ], and the fourth and higherorder terms can be expressed as [26] 

of likelihood and posterior pdf are computed as follows: 

**==> picture [511 x 220] intentionally omitted <==**

where _l_ is the order of Taylor series, _Pxx_ ( _i, j_ ) is the covariance of **ex** _i ,j_ , and **ex** _i ,j_ is the _j_ th component of **ex** _i_ . Define _F_ ( **¯x** ) = _∂∂_ **x** h _[T][|]_ **[x]**[=] **[¯x]**[, the covariance is calculated as] 

Many LRKFs have been proposed based on Gaussian assumptions and different choices of representative points **x** _[i] k −_ 1 and weights ω _[i] k −_ 1[.][Despite][the][use][of][high-degree][numerical] integration rules can improve the performance marginally, such as 5-degree cubature rule [9] or sparse-grid quadrature rule [29], which however, will increase the computational cost and may bring numerical stability problem. It has been reported in recently published literatures that the selection of prior pdf in the SLR process has a great effect on the Bayesian update framework, especially when the measurement noise is sufficient small [23]–[25]. What is more, for tightly coupled GNSS/INS the nonlinearity is mild and it has no obvious benefits to capture the high-order information of system models by sacrificing the stability and computational cost. In a word, by improving the approximation accuracy for numerical integration would not necessary mean a performance improvement of filtering. 

Noting (6), the approximation error of **¯z** is enlarged with the increase of _n_ , which degrades the accuracy of covariance further. If **¯z** is known up to the third order, the covariance only known to the first term, which however, yields more accurate estimation than EKF as there is a minus positive term in (7). 

_Remark 2.1:_ When the symmetric perturbation terms in (4) are used, there would be inconsistence in covariance due to the error in _Pxx_ and the time-varying nonlinearity in D _[i] e_[h][.] 

## _A. Previous Work_ 

Consider a nonlinear discrete-time system 

**==> picture [173 x 11] intentionally omitted <==**

**==> picture [172 x 11] intentionally omitted <==**

_Remark 2.2:_ It should be noted that most of the previous LRKFs generate the sigma-points by **x** _[i] k −_ 1[=] **[ ˆx]** _[k][−]_[1] _[|][k][−]_[1][+] _Gi_ ( _n_ )[�] **P** _k −_ 1 _|k −_ 1 for prediction phase, and **x** _[i] k |k −_ 1[=] **[ ˆx]** _[k][|][k][−]_[1][+] _Gi_ ( _n_ )[�] **P** _k |k −_ 1 for update phase, where _n_ is the dimension of system state. In CKF _Gi_ ( _n_ ) is defined as 

where **x** _k ∈ℜ[n][×]_[1] , **z** _k ∈ℜ[p][×]_[1] are the state and measurement vector at time _k_ , **w** _k −_ 1 _∈ℜ[n][×]_[1] and _νk ∈ℜ[p][×]_[1] are additive Gaussian white noise with covariance **Q** _k −_ 1 and **R** _k_ , _f_ ( _·_ ) and _·_ h( ) are the system and measurement function. The initial state **x** 0 and **w** _k −_ 1, _νk_ are mutually independent. 

**==> picture [240 x 31] intentionally omitted <==**

Both UKF and CKF can be considered as linear regression Kalman filters (LRKFs) whose implementation contains two phases: prediction and update. Let _N_ = 2 _n_ , the prediction phase can be summarized as 

with **e** _i ∈ℜ[n][×]_[1] denotes the _i_ th elementary column vector. Notice that, the distances of sigma-points from central point depend on _n_ . 

**==> picture [251 x 86] intentionally omitted <==**

## III. IMPROVED CUBATURE KALMAN FILTER 

In Section III-A, we present the motivation of using posterior sigma-points error to update sigma-points, instead of the covariance. In Section III-B, the novel cubature points update algorithm is derived and its novelty is remarked. Section IIIC analyzes the upper bounds of error covariance matrices for ICKF with model uncertainties in measurement equation. Finally, some aspects on ICKF are discussed. 

where the sequence _{_ ( **x** _[i] k −_ 1 _[,]_[ ω] _[i] k −_ 1[)] _[}] i[N]_ =1[represent the posterior] pdf _N_ ( **x** _k −_ 1; **ˆx** _k −_ 1 _|k −_ 1 _,_ **P** _k −_ 1 _|k −_ 1) and the predicated state pdf is approximated by _N_ ( **x** _k_ ; **ˆx** _k |k −_ 1 _,_ **P** _k |k −_ 1). The approximation 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2978 

**==> picture [240 x 189] intentionally omitted <==**

Fig. 1. Prior and posterior pdf for z = 1.5. Red solid line indicates the posterior pdf calculated by using a dense grid of points. CKF approximates the covariance with non-negligible error. 

## _A. Motivation of the ICKF_ 

As we have demonstrated in previous section, the accuracy of existing sampling-based methods may be degraded when high-dimensional problem involved. Furthermore, the covariance may contain non-negligible error when the polynomial order of (8) or (9) is of degree _m_ and _m_ -degree cubature rule is employed. When there are measurement uncertainties in the update phase of CKF (e.g., multipath and disturbances in GNSS measurement), which make the assumed Gaussian distribution of measurement noise invalid, the re-generation of sigma-points based on the construction of pdf would lead to a quickly divergence. However, the process model is often rather accurate, if the re-generation of sigma-points for next filtering period is weighted more on the predicted sigma-points, the filter will keep on tracking system state for longer duration even if no innovation is provided. 

When no sufficient measurement information is provided, the prediction phase of the filter works well, which can be written as 

**==> picture [245 x 24] intentionally omitted <==**

where **Z** _k −_ 1 denote the measurement sequence ( _z_ 1 _, · · · , zk −_ 1). In the update phase, except for the prior pdf the sigma-points and the values of its diffusion in process function can give extra information to reduce the accumulated error in the calculation of (19). The information of predicted sigma-points can be utilized in two ways: 1) the sigma-points error from prediction phase can be used to generate posterior sigma-points by linear transformation, 2) the values from the diffusion of sigma-points in process function, which capture the high-order terms of moments and non-Gaussian information can be used for the diffusion in nonlinear measurement function. 

_1) Illustrative Example:_ The example used in [25] is applied to verify the conclusions of previous discussion. The prior pdf 

**==> picture [240 x 189] intentionally omitted <==**

Fig. 2. Approximations by using traditional and novel sigma-points with different Q. Result indicates ICKF performs much better than CKF when Q value is small. 

_p_ 0( _x_ ) = _N_ (3 _,_ 4), where _N_ ( **¯x** _,_ **P** ) represents a Gaussian density with mean **¯x** and covariance **P** . The measurement equation is 

**==> picture [72 x 12] intentionally omitted <==**

with measurement noise _ηk ∼ N_ (0 _,_ 0 _._ 1), _a_ = 0 _._ 01 and the posterior pdf can be calculated analytically. Suppose _zk_ = 1 _._ 5, then we approximates the posterior PDF by using CKF based on 3- degree cubature rule, and the result is shown in Fig. 1. Notice that, CKF solves the moment computation problem contained in (5), but approximates the covariance in (7) with non-negligible error. Without doubt, in case this covariance is applied to generate sigma points for next filtering period, the residual of SLR for process function will increase, which degrades the accuracy of likelihood approximation. 

Let the process function be _xk_ = _xk −_ 1 + _wk −_ 1, and _wk −_ 1 _∼ N_ (0 _, Q_ ). The result of using CKF and ICKF after two recursive steps with different Q value is shown in Fig. 2, based on which we can conclude that when posterior pdf is markedly narrower than the prior pdf, the sampling method of CKF down-weights the new observation, making the approximation of posterior pdf presents bias. By inheriting extra information from the cubature points that generated in prediction phase, the ICKF can reduce the bias and in turn slow down the divergence of filtering. 

## _B. Novel Cubature Points Update_ 

Let **x** _k −_ 1 _∼ N_ ( **ˆx** _k −_ 1 _|k −_ 1 _,_ **P** _k −_ 1 _|k −_ 1) be the estimated state at time _k −_ 1, **x** _k ∼ N_ ( **ˆx** _k |k −_ 1 _,_ **P** _k |k −_ 1) be the predicted state at time _k_ , and factorize **P** _k −_ 1 _|k −_ 1 and **P** _k |k −_ 1 as 

**==> picture [190 x 15] intentionally omitted <==**

**==> picture [181 x 14] intentionally omitted <==**

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

2979 

Algorithm 1: Cubature Kalman Filter. **Require** : **x** ˆ _k −_ 1 _|k −_ 1 _,_ **Pk** _−_ **1** _|_ **k** _−_ **1 for** _i_ = 1 _, · · · , N_ **do** Compute the cubature points **x[i] k** _−_ **1**[using (22)] Assign weights : ω _[i] k −_ 1[= 1] _[/N]_ **end for Prediction phase:** Compute the predicted mean **ˆxk** _|_ **k** _−_ **1** using (10) Compute the predicted covariance **Pk** _|_ **k** _−_ **1** using (11) **Update phase** : **for** _i_ = 1 _, · · · , N_ **do** Compute the cubature points **X[i] k** _|_ **k** _−_ **1**[using (23)] Assign weights: ω _[i] k |k −_ 1[=][ ω] _k[i] −_ 1 **end for** Compute the estimated measurement **ˆz[i] k** _|_ **k** _−_ **1**[using (12)] Estimate the Kalman gain **Kk** using (13), (14), (15) Estimate the update state **ˆxk** _|_ **k** and covariance **Pk** _|_ **k** using (16), (17) 

where **P** _k |k −_ ΔE represents the uncertainties that the sigmapoints error matrix must account for in the update phase of filtering, and ΔE is a positive definite matrix that will be discussed in III-D. Assuming the updated **X[˜]**[+] _k |k_[is][directly][generated][by] **˜X**[+] _k |k_[=] **[ B˜X]** _−k |k −_ 1[, where] **[ B]**[ is a transformation matrix. We can] easily conclude that 

**==> picture [190 x 15] intentionally omitted <==**

**==> picture [210 x 34] intentionally omitted <==**

If **P** _k |k −_ 1 _−_ **Q** _k −_ 1, **P** _k |k −_ Δ **E** are positive definite matrix, we can factorize them as 

**==> picture [187 x 15] intentionally omitted <==**

**==> picture [171 x 16] intentionally omitted <==**

It follows 

The sigma-points generated for the prediction and update phase are 

**==> picture [193 x 33] intentionally omitted <==**

where _ξi_ is defined as (18). The approximation of predicted state and posterior state densities in CKF is presented in Algorithm 1. Noting that with the increase of _n_ , the distances of cubature points are away from the central point, and the approximation error is increased for high-dimensional filtering problem. 

Define the error matrices and weights 

**==> picture [239 x 59] intentionally omitted <==**

**==> picture [222 x 11] intentionally omitted <==**

where **x** _[i] k |k −_ 1[= f(] **[x]** _k[i] −_ 1[)][is][the][predicted][cubature][points.][No-] tice that, in Algorithm 1 the prediction phase and update phase share the same weights ω, and _diag_ (ω) is a function that build diagonal matrix with the main diagonal being ω, _N_ is the number of cubature points _._ Some useful relationships are 

**==> picture [160 x 16] intentionally omitted <==**

**==> picture [208 x 15] intentionally omitted <==**

which indicates that the cubature points should at least account for the mean and covariance of the approximation error of process function. Analogously, the updated error matrix **X[˜]**[+] _k |k_ should satisfy 

**==> picture [151 x 16] intentionally omitted <==**

**==> picture [190 x 16] intentionally omitted <==**

**==> picture [189 x 15] intentionally omitted <==**

where **B** matrix satisfies **L**[+] _k_[=] **[ BL]** _k[−]_ **[Ξ]**[, with] **[ ΞΞ]** _[T]_[=] **[ I]**[ and] **[ I]**[ is] the identity matrix of appropriate dimension, we have 

**==> picture [167 x 14] intentionally omitted <==**

Then, by setting **Ξ** as the identity matrix we can get the simplest solution **B** = **L**[+] _k_[(] **[L]** _[−] k_[)] _[−]_[1][. After we get] **[˜X]**[+] _k |k_[, the posterior cuba-] ture points is generated by **x** _[i] k_[=] **[ ˆx]** _[k][|][k]_[+] **[˜X]**[+] _k |k_[(] _[i]_[)][, where] **[˜X]**[+] _k |k_[(] _[i]_[)] is the _i_ th column of **X[˜]**[+][The][CKF][using][this][novel][cubature] _k |k_[.] points update method is presented in Algorithm 2. 

_Remark 3.1:_ Unlike the work of [26], where an optimal rotation angle is employed to transform the sigma-points for different filtering problems, our novel sigma-points depends on the approximation error of predicted cubature points only. The updated sigma-points can be written as 

**==> picture [131 x 16] intentionally omitted <==**

which does not depend on system state dimension _n_ and solves the “non-local sampling” problem efficiently. 

_Remark 3.2:_ The positive definiteness of **P** _k |k −_ 1 _−_ **Q** _k −_ 1 can be ensured by (11), where the weights of 3-degree cubature rule are always positive. 

_Remark 3.3:_ The updated cubature points depend on the accuracy of the moments only, which means that the limitation on Gaussian distribution in the sigma-points update of LRKFs is removed. 

## _C. Boundedness of Error Covariance Matrices_ 

Let **˜x** _k |k −_ 1 = **x** _k −_ **ˆx** _k |k −_ 1 be the prediction error, **˜x** _k |k_ = **x** _k −_ **ˆx** _k |k_ be the filtering error. Subtracting (10) from (8), and 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2980 

## Algorithm 2: Improved Cubature Kalman Filter. 

**Require** : **ˆxk** _−_ **1** _|_ **k** _−_ **1** _,_ **Pk** _−_ **1** _|_ **k** _−_ **1** Run Algorithm 1 to initialize sigma-points error matrix **˜X**[+] **k** _−_ **1** _|_ **k** _−_ **1 for** _i_ = 1 _, · · · , N_ **do** Compute the cubature points: **x[i] k** _−_ **1**[=] **[ ˆx][k]** _[−]_ **[1]** _[|]_ **[k]** _[−]_ **[1]**[+] **[˜X]**[+] **k** _−_ **1** _|_ **k** _−_ **1**[(] **[i]**[)] Assign weights : ω _[i] k −_ 1[= 1] _[/N]_ **end for Prediction phase:** Compute the predicted mean **ˆxk** _|_ **k** _−_ **1** using (10) Compute the predicted covariance **Pk** _|_ **k** _−_ **1** using (11) Compute predicted sigma error matrix **X[˜]** _[−]_ **k** _|_ **k** _−_ **1**[using (24)] Compute **L** _[−]_ **k**[by factorizing] **[ P][k]** _[|]_ **[k]** _[−]_ **[1]** _[−]_ **[Q]** _[k][−]_[1] **Update phase** : **for** _i_ = 1 _, · · · , N_ **do** Compute the cubature points: **x[i] k** _|_ **k** _−_ **1**[=] **[ f]**[(] **[x] k[i]** _−_ **1**[)] Assign weights: ω _[i] k |k −_ 1[=][ ω] _k[i] −_ 1 

**end for** Compute the estimated measurement **ˆz[i] k** _|_ **k** _−_ **1**[using (12)] Estimate the Kalman gain **Kk** using (13), (14), (15) Estimate the update state **ˆxk** _|_ **k** and covariance **Pk** _|_ **k** using (16), (17) Compute **L**[+] **k**[by factorizing] **[ P][k]** _[|]_ **[k]** _[−]_[Δ] **[E]** Compute posterior sigma error matrix: _−_ **1** _−_ **˜X**[+] **k** _|_ **k**[=] **[ L] k**[+] � **L** _[−]_ **k** � **˜Xk** _|_ **k** _−_ **1** 

using the Taylor series expansion around **ˆx** _k −_ 1 _|k −_ 1, we have 

**==> picture [252 x 145] intentionally omitted <==**

with 

**==> picture [143 x 28] intentionally omitted <==**

The high order terms of Taylor series are formulated as [30] 

**==> picture [230 x 38] intentionally omitted <==**

where **A** _k_ and **D** _k_ are problem dependent scaling matrices, Θ _k_ is an extra degree of freedom to tune the filter, N1 _,k_ and N2 _,k_ are unknown time-dependent matrices accounting for the 

linearization error of system model and both of them satisfy N _j,k_ (N _j,k_ ) _[T] ≤_ **I** , with _j_ = 1, 2. Substitute (30) into (38), we have 

**˜x** _k |k −_ 1 = � **Φ** _k |k −_ 1 + **A** _k_ N1 _,k_ Θ _k_ � **˜x** _k −_ 1 _|k −_ 1 + **w** _k −_ 1 _._ (40) By considering the uncertainties presented in measurement model, we can expand h( **x** _k_ ) around **ˆx** _k |k −_ 1 as 

**==> picture [253 x 99] intentionally omitted <==**

with 

**==> picture [121 x 28] intentionally omitted <==**

**C** _k_ +1 and **M** _k_ +1 are problem dependent scaling matrices, and N _i,k_ +1,Θ _k_ +1 are similar to the matrices definition in (39). **B** _k_ Δ _B k_ **E** _B k_ **x** _k_ represents the parameter uncertainties, where **B** _k_ is known scaling matrix of appropriate dimensions, **E** _B k ∈ℜ[n][×][n]_ is known and can be set as **I** , Δ _B k ∈ℜ[n][×][n]_ is unknown matrix satisfying Δ _B k_ Δ _[T] B k[≤]_ **[I]**[ [][31][]][. Substitute (28),] (40) and (41) into (16), we obtain 

**==> picture [239 x 48] intentionally omitted <==**

_Theorem 3.1:_ The prediction error covariance **P** _k |k −_ 1 and the filtering error covariance **P** _k |k_ can be formulated as 

**==> picture [230 x 34] intentionally omitted <==**

and 

**==> picture [251 x 32] intentionally omitted <==**

with 

**==> picture [252 x 31] intentionally omitted <==**

_Proof:_ It can be shown that (43), (44) follow directly from (40) and (42), respectively, so the proof is omitted for conciseness. 

_Remark 3.4:_ Noting (43) and (44), we can conclude that due to consideration of nonlinear errors and parameter uncertainties in measurement model, there are unknown matrices **A** _k_ , **C** _k_ and Δ _B k_ in the construction of Riccati equation. These matrices are often not easy to tune in practice, so there is no close-form solution to the nonlinear filtering. However, a suitable filter gain **K** _k_ should be designed to guarantee an upper bound covariance 

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

2981 

of the filtering error and also to minimize the upper bound. The boundedness proof of filtering error covariance corresponding to Theorem 3.1 is given in Appendix A. 

## _D. Discussion on the ICKF_ 

The novel sigma-points generation method is based on the moments error in approximating the intractable integrals of nonlinear filter with bounded uncertainties. Noting (44), similar to the computation of **L** _[−] k_[we define][ ΔE][ in (31) as] 

**==> picture [171 x 12] intentionally omitted <==**

where **Λ** is a weight matrix depends on the observability of state, e.g., for GNSS/INS we set the diagonal of **Λ** as 1 except the elements corresponding to non-direct observed state, and set the off-diagonal elements of **Λ** as 0 to make the correction for attitude and sensor errors unaffected. By separating the stochastic uncertainties from **P** _k |k −_ 1 and **P** _k |k_ as in (29) and (31), the transformation of sigma-points error matrix can account for the bounded uncertainties of system models more precisely. Once the update phase with no innovation is provided, **X[˜]** _[−] k |k −_ 1[cap-] tures more prior information than existing sampling methods. The predicted cubature points **x** _[i] k |k −_ 1[can][also][provide][useful] information accounting for high-order terms of moments and non-Gaussian information of dynamic model. Based on above analysis, we can conclude that when additional noise is considered, in addition to removing the Gaussian assumptions, ICKF reaches more accurate estimation compared with CKF. 

A local convergence proof of ICKF is given in Appendix B, and result indicates when some conditions are satisfied **˜x** _k |k_ would converge to zero asymptotically. Noting (66) and (67), the convergence is affected by the accuracy of prior pdf, however when **Q** _k_ is larger this influence become less. Notice that, in Algorithm 2 the initialization of sigma-points error matrix is done by using CKF. However, we can employ other complicated but efficient algorithms, such as PF, Gaussian sum filter and the algorithm proposed in [17], to reduce the initial error of prior pdf. Clearly, when **Q** _k_ is positive and large enough the estimation error is bounded even for bad approximation to the nonlinear model. 

The difference of computational cost between ICKF and CKF lies in the generation of cubature points. For ICKF, the computational cost of float multiplication in cubature points update is[5] 3 _[n]_[3][+ 5] _[n]_[2][,][and][for][CKF][this][value][is][2] 3 _[n]_[3][+ 4] _[n]_[2][.][As][the] novel sigma-points update needs one more matrix inversion and one more matrix multiplication consisted in (37), it is slightly more computational demanding than traditional sigma-points generation method. 

It should be mentioned that similar works have been done in previous reports, which update the points directly without constructing the pdf [28], [32]. However, the motivation of our work is different from their approaches. Unlike [28], we focus on the high dimension filtering problems, and by uncoupling the dependence of approximation error on the dimension of system model, the new sigma-points update is more efficient for highdimensional filtering problem. In [32], the error matrix from predicted observations is also involved in the update of sigma- 

points, which increases the computational cost obviously and makes it not suitable for high dimension filtering problems. As there are often model uncertainties in measurement function, the extra information from the sigma-points error of likelihood approximation is more involved. We bring uncertainty reduction into the transform of sigma-points error based on the analysis of model uncertainties, and the above-mentioned methods do not try to address the model uncertainties problem. 

**==> picture [175 x 8] intentionally omitted <==**

The filtering model of tightly coupled GNSS/INS is given and its nonlinearity is analyzed in Appendix C. Simulation results based on the data set generated by Spirent SimGEN are reported. 

## _A. Filtering Model of Tight GNSS/INS_ 

The body frame ( _b_ -frame) is selected as _Right-Front-Up_ , local navigationframe( _n_ -frame) is selectedas _East-North-Up_ , andthe details of geocentric inertial frame ( _i_ -frame) and earth-centered earth-fixed frame ( _e_ -frame) can be found in [22]. The state vector of tightly coupled GNSS/INS is 

**==> picture [145 x 15] intentionally omitted <==**

where ψ is attitude vector, _δ_ **v** is the error vector of velocity resolving in _n_ -frame, _δ_ **p** is position error vector, **ba** and **bg** are the biases of the accelerometers and gyros in three axes expressed in _b_ -frame, _δtu_ and _δtru_ are the offset and drift of receiver clock expressed in meters and m/s. The nonlinear system model of INS can be formulated as 

**==> picture [241 x 51] intentionally omitted <==**

**==> picture [236 x 52] intentionally omitted <==**

where **C** _ω_ is the transformation matrix from angular velocity to Euler angles, **C** _[b] a_[represents the rotation matrix from] _[ a]_[-frame] to _b_ -frame, ω _[c] ba_[represents the rotation of] _[ a]_[-frame with respect] to _b_ -frame resolved about _c_ -frame, _δ_ ω _[c] ba_[is][the][corresponding] error vector. **f** _ib[b]_[is the measured specific force resolved about] _[ b]_[-] frame, _δ_ **f** _ib[b]_[is corresponding error vector.] _[ L]_[,] _[λ]_[,] _[ h]_[ are the latitude,] longitude and height, _vE_ , _vN_ , _vU_ are the east, north and up velocity, and _δvE_ , _δvN_ , _δvU_ , _δL_ , _δλ_ , _δh_ are corresponding error vector. _RM_ and _RN_ are the median radius and normal radius, respectively. 

## _B. Results and Discussion_ 

The duration of trajectory is 418 s, and the aircraft runs at a speed of 200 m/s with two 45° turns in opposite directions. The initial attitude error is ( _−_ 0.05, 0.04, 5) in degree, the update rates of GNSS and INS are 2 Hz and 100 Hz. The bias of accelerometer is 1 mg, and the noise of accelerometer is 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2982 

**==> picture [508 x 186] intentionally omitted <==**

Fig. 3. Attitude error of different algorithms with no signal outage. CKF performs slightly better than EKF, and ICKF outperforms the other two filters. 

Fig. 4. RMSEs of different algorithms with no signal outage. Notice that, ICKF performs much better than the other two filters. 

0.1 mg _/[√]_ Hz. The bias of gyro is 10 _[◦] /_ h, and the noise of gyro is 0.1 _[◦] /[√]_ h. The equivalent pseudo-range error of receiver clock is 10 km, and the equivalent pseudo-range rate error is 100 m/s. The root mean square error (RMSE) is taken as the metric to evaluate the performance of different filtering methods. 

The attitude result of different algorithms is shown in Fig. 3. It can be clearly seen that ICKF outperforms EKF and CKF. Although CKF reaches better approximation accuracy than EKF, CKF shows almost similar performance with EKF in terms of convergence rate and stability accuracy. As the only difference between CKF and ICKF is the prior information provided to measurement update, we can conclude that the approximation error is negligible compared with the error due to less informative prior distribution. It is notable that both EKF and CKF produce biases when the filter is stable, which can be further alleviated by reducing the system uncertainty. However, it is always the case that a large **Q** _k_ is initialized to account for the unknown prior information at first, and it is tedious to tune this value in the design of KF. Notice that, ICKF shows fast convergence rate in terms of yaw than EKF and CKF with the same filter parameters including **Q** _k_ and initial filtering error covariance. More detailed comparison is given in Fig. 4, where the RMSEs of attitude, velocity (V) and position (P) are computed. The results in Fig. 4 confirm that CKF shows slight better accuracy than EKF in tight GNSS/INS even if a large initial yaw error is given, and ICKF achieves much more accurate estimation than CKF. 

To verify the performance of ICKF with observations missing, outages are simulated by setting **K** _k_ = **0** . The results of different filters with outages started at the 30th epoch and with duration 60 s (Outage#2) are shown in Fig. 5, Fig. 6 and Fig. 7. Notice that, CKF shows slight better result than EKF when outage occurs, and converges faster than EKF when the signal appears again. This coincides with the fact that CKF performs SLR with respect to sigma-points located at the prior distribution region, and EKF only performs SLR with respect to a single point in this region. Once the signal appears again, 

**==> picture [245 x 183] intentionally omitted <==**

Fig. 5. Attitude error of different algorithms with 60 s signal outage. There are biases for EKF and CKF when they are stable. On the contrary, ICKF reduces the biases and performs the best among the filters. 

in case the undergoing filter model does not far away from the actual system model, the convergence of filter would be accelerated. 

Notice that, ICKF performs better than CKF which coincides with our previous analysis. Both CKF and ICKF perform SLR with respect to the sigma-points, the difference lies in that CKF inherits information from prior pdf by mean and covariance only, whereas ICKF introduces the posterior sigma-points error matrix without constructing prior pdf, which removes the dependence of cubature points update on Gaussian assumption. 

By comparing Fig. 7 with Fig. 4, we can conclude that the states with strong observability (e.g., position and velocity) are largely degraded when there is no innovation input to (16). However, the estimation of states that with weak observability, which depends on the error covariance of predicted state is less sensitive to the observation missing. Furthermore, if we can slow down the varying of error covariance, these states 

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

2983 

**==> picture [215 x 179] intentionally omitted <==**

Fig. 6. Velocity error of different algorithms with 60 s signal outage. CKF performs slightly better result than EKF, and ICKF performs the best among the 

**==> picture [216 x 165] intentionally omitted <==**

Fig. 7. RMSEs of different algorithms with 60 s signal outage. Notice that, the position results of EKF and CKF are degraded seriously. 

can be tracked for long duration until the change of system uncertainty (i.e., **Q** _k_ ) cannot be neglected any more. However, as there are no effective tools to evaluate the uncertainty of filtering model online, it is advisable to separate it from the generation of cubature points. When the value of **Q** _k_ is large enough, the bounded uncertainty contained in system models can be neglected and ICKF may reduce to CKF (see Fig. 2). 

The main concern of vehicle navigation system in urban or indoor areas is the position error. Define following equation to evaluate the accuracy of position result 

**==> picture [187 x 29] intentionally omitted <==**

where _M_ is the number of Monte Carlo (MC) run, _RMSEe[r]_ and _RMSEn[r]_[are][the][RMSE][of][east][and][north][position][of][the] _r_ th run, which are expressed in meters. As we have stated, the performance of ICKF depends on the uncertainty of system model defined by (8). However, as the filter does not know what 

**==> picture [216 x 182] intentionally omitted <==**

Fig. 8. Trajectory of simulated sensor outages. All the outages start at the 30th epoch represented in pentagram symbol, and the ends of the outages are indicated by circular symbols marked in corresponding colors. 

TABLE I 

POSITION RESULT OF DIFFERENT ALGORITHMS 

**==> picture [244 x 35] intentionally omitted <==**

the dynamic of vehicle will be, it is useful to study its sensitivity to different dynamic conditions. In Fig. 8, another three outages are simulated, all of which start at the 30th epoch with durations of 30 s (Outage #1), 90 s (Outage #3) and 120 s (Outage #4), respectively. 

By setting _M_ = 20, the _RMSE_ pos of different filtering methods are listed in Table I. Notice that, during outage #1 and outage #2 the vehicle turns in the same direction, so the system uncertainty does not change very much, both EKF and CKF can produce degraded position result. Although the position error of ICKF in outage #3 increases when the vehicle turns in opposite direction, it keeps on tracking the state with acceptable precision. However, the results of EKF and CKF are largely degraded in outage #3, and both of the two algorithms diverge in most of the runs when the duration of outage is increased to 120 s. In a word, with the present of short outages, ICKF has much smaller error than EKF and CKF, which demonstrates that SLR with respect to the novel cubature points is insensitive to observations missing. 

To verify the superiority of ICKF in statistical sense, Fig. 9 shows the boxplot of 50 MC runs for 60 s outage case. The index represents the state of navigation system, e.g., 1-7 implies yaw, pitch, roll, velocity and position in east and north directions, respectively. It is notable that, the result of ICKF shows much better robustness than CKF when different noises with the same statistical property are used. Furthermore, the attitude result of ICKF shows less dispersion and outliers than CKF, which indicates that ICKF has more consistent covariance than CKF. As the correction for attitude come from the off-diagonal elements 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2984 

**==> picture [217 x 179] intentionally omitted <==**

Fig. 9. Boxplot of the RMSEs for 50 runs with 60 s signal outage. ICKF shows better robustness than EKF and CKF in terms of all the navigation parameters, and the superiorities in position and velocity are significant. 

of prediction error covariance, we can conclude that the novel cubature points update method is more efficient than EKF and CKF in computing the covariance of prior pdf. 

## V. CONCLUSION 

In this paper, a novel cubature points update method is proposed, based on which an improved cubature Kalman filter (ICKF) is developed. Theoretical analysis and simulation results reveal that ICKF shows better accuracy and faster convergence rate than CKF and EKF when observation missing occurs in high-dimensional filtering problem. Although CKF is slightly better than EKF when there are large initial yaw error and uncertainties in filtering model, it has no benefits to replace EKF with CKF as the later increases the computational cost but without improving the filtering accuracy obviously. The advantages of ICKF can be summarized as follows: 

- r the generation of cubature points does not depend on the dimension of system state, making it suitable for highdimensional filtering problem. 

- r posterior cubature points, which includes the diffused points and sigma-points error matrix are useful for the approximation of likelihood when large prior error is provided. 

- r estimation of non-direct observed state can be improved by designing ΔE which is intuitively understood based on the model uncertainties analysis. 

We provide a general class of sigma-points update framework that works in an implicit way. Future work would focus on designing the prior pdf in an explicit form [33]. The usage of ICKF on real land vehicle navigation is also under consideration. 

## APPENDIX A 

The proof of the bounded error covariance is provided in this appendix. This proof is a resemblance to the proof in [30] with some simplifications. 

First, rewrite (43) and (44) as follows: 

**==> picture [252 x 101] intentionally omitted <==**

where 

**==> picture [243 x 19] intentionally omitted <==**

We have the following elementary inequality 

**==> picture [247 x 27] intentionally omitted <==**

yields 

**==> picture [213 x 35] intentionally omitted <==**

where _ε_ is a positive scalar, then we get 

**==> picture [243 x 99] intentionally omitted <==**

By considering (51) and (52) we have 

**==> picture [251 x 49] intentionally omitted <==**

where 

**==> picture [213 x 14] intentionally omitted <==**

We introduce two discrete-time Riccati-like difference equations: 

**==> picture [216 x 58] intentionally omitted <==**

2985 

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

**==> picture [239 x 111] intentionally omitted <==**

where **Σ** 0 _|_ 0 = **P** 0 _|_ 0 _>_ 0, _γ_ 1 _,k_ , _γ_ 2 _,k_ +1 are positive scalars, and the following constraints 

**==> picture [139 x 34] intentionally omitted <==**

are satisfied. Based on the Lemma 2 and 3 in [30], we can conclude that **P** _k |k ≤_ **Σ** _k |k_ . Then, we would like to design **K** _k_ that minimizes the upper bound of **Σ** _k |k_ . By letting the partial derivative of **Σ** _k |k_ with respect to **K** _k_ be zero, we obtain 

**==> picture [235 x 128] intentionally omitted <==**

Base on the above equation, the optimal **K** _k_ is computed as 

**==> picture [252 x 91] intentionally omitted <==**

when Θ _k_ +1, **B** _k_ and **C** _k_ +1 are equal to zero, (56) reduce to (15). 

**==> picture [51 x 8] intentionally omitted <==**

In this section, we provide a local convergence analysis for the ICKF by following [34] and [35]. First, we define 

**==> picture [158 x 29] intentionally omitted <==**

where _αk_ = _diag_ ([ _α_ 1 _k , · · · , αnk_ ]), _βk_ = _diag_ ([ _β_ 1 _k , · · · , βpk_ ]). Follow from (40)-(44) we have 

**==> picture [240 x 12] intentionally omitted <==**

**==> picture [242 x 14] intentionally omitted <==**

where **Q** _[∗] k_[=] _[ α][k]_ **[F]** _[k]_ **[K]** _[k]_[(Δ] **[P]** _[k]_[+] **[ R]** _[k]_[)(] _[α][k]_ **[F]** _[k]_ **[K]** _[k]_[)] _[T]_[+] **[ Q]** _[k]_[.][Let] the following assumptions hold: 1) There are real positive numbers _f_ min , _h_ min , _β_ min , _α_ min , _α_ max , _q_ min , _q_ max , _q_ min _[∗]_[,] _[r]_[max][,] _p_ max , _p_ min such that the following bounds on various matrices are satisfied for every _k ≥_ 0: 

**==> picture [237 x 48] intentionally omitted <==**

2) There exist real constants _f_ max , _h_ max , _β_ max such that the following bounds are satisfied: 

**==> picture [237 x 11] intentionally omitted <==**

and we want to prove lim _k →∞_ **˜x** _k |k_ = 0. Define V _k_ +1( **˜x** _k_ +1 _|k_ ) = **˜x** _[T] k_ +1 _|k_ **[P]** _[−] k_ +1[1] _|k_ **[˜x]** _[k]_[+1] _[|][k]_[,][by][noting] (58) it is clear that 

**==> picture [250 x 37] intentionally omitted <==**

Take the conditional expectation yields 

**==> picture [170 x 35] intentionally omitted <==**

**==> picture [250 x 73] intentionally omitted <==**

From (58), we have 

**==> picture [249 x 78] intentionally omitted <==**

On the basis of (60), we get [35] 

**==> picture [240 x 39] intentionally omitted <==**

where **K** _[∗]_ is the upper bound of **K** _k_ . Substituting (64) into (63), the function becomes 

**==> picture [147 x 15] intentionally omitted <==**

**==> picture [220 x 47] intentionally omitted <==**

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 65, NO. 11, JUNE 1, 2017 

2986 

then the first term in (62) can be written as 

[ _αk_ **Φ** _k_ ( **I** _−_ **K** _k βk_ **H** _k_ )] _[T]_ **P** _[−] k_ +1[1] _|k_[[] _[α][k]_ **[Φ]** _[k]_[ (] **[I]** _[ −]_ **[K]** _[k][β][k]_ **[H]** _[k]_[)]] 

**==> picture [249 x 51] intentionally omitted <==**

Define **v** _k[∗]_[=] _[ B][k]_[Δ] _[B k][E][B k]_ **[x]** _[k]_[+] **[ v]** _[k]_[, then under the assumptions] (59) and (60) we obtain 

**==> picture [248 x 87] intentionally omitted <==**

_p_ m in _q_ m in _[∗]_ **[I]** Define _λ_ = ( _α_ m a x _f_ m a x + _α_ m a x _f_ m a x **K** _[∗] β_ m a x _h_ m a x )[2] + _p_ m a x _q_ m in _[∗]_ **[I]**[, and it] is clear that _μ >_ 0 and 0 _< λ <_ 1. By inserting (67) into (62), we have 

_E_ �V _k_ +1 � **˜x** _k_ +1 _|k_ ��� **˜x** _k |k −_ 1 � _≤_ **˜x** _[T] k |k −_ 1[(1] _[ −][λ]_[)] **[ ˜x]** _[k][|][k][−]_[1][+] _[ μ.]_ Apply Lemma 1 of [34] we can conclude that **˜x** _k_ +1 _|k_ is bounded in mean square. Then, on the basis of (57) we obtain 

**==> picture [218 x 61] intentionally omitted <==**

Take the expectation of (68) yields 

2[�] _E_ � _∥_ **˜x** _k ∥_[2][�] _≤_ 2 _α_ min _[−]_[2] _[f]_ min _[ −]_[2] � _E_ ��� **˜x** _k_ +1 _|k_ �� + _E_ � _∥_ **w** _k ∥_[2][��] _._ As both **˜x** _k_ +1 _|k_ and **w** _k_ are bounded in mean square, we can conclude lim _k →∞_ **˜x** _k |k_ = 0. 

**==> picture [51 x 8] intentionally omitted <==**

The nonlinearity of system model for GNSS/INS is analyzed in this section. Because of the misalignment error and random drift of gyro and accelerometer, the actual navigation frame ( _p_ -frame) does not coincide with ideal navigation coordinate _n_ -frame. Let **C** _[p] n_[be][the][rotation][matrix][from] _[n]_[-frame][to] _[p]_[-] frame, which is also the attitude error matrix, ω _[p] nb_[and][ω] _[n] nb_ are the rotation velocity of _b_ -frame with respect to _n_ -frame resolved about computation frame and ideal navigation frame, respectively. Then we have 

**==> picture [193 x 12] intentionally omitted <==**

By taking derivation of (69) with respect to the rotation velocity, we get 

**==> picture [190 x 15] intentionally omitted <==**

and 

**==> picture [192 x 14] intentionally omitted <==**

Equal (70) with (71) we get 

**==> picture [207 x 33] intentionally omitted <==**

**==> picture [242 x 33] intentionally omitted <==**

By substituting 

**==> picture [106 x 34] intentionally omitted <==**

into (73), and using the mapping of vector and its skewsymmetric matrix we get 

**==> picture [249 x 77] intentionally omitted <==**

Define trigonometric function cos = _C_ , sin = _S_ , and a series of rotation is performed to align the navigation axis, which is expressed in vector as ψ = [ _ϕ θ_ ψ ] _[T]_ , then we get 

**==> picture [106 x 11] intentionally omitted <==**

**==> picture [246 x 57] intentionally omitted <==**

where _Rα_ ( _β_ ) stand for the rotation axis is _α_ and the angular is _β_ . Assume all the Euler platform error angles are of small values, i.e., **C** _ω ≈_ 1, and the biases are the only gyro errors modeled as filter states, i.e., _δ_ ω _[b] ib[≈]_ **[b][g]**[then] 

**==> picture [207 x 12] intentionally omitted <==**

When there is large error in attitude, e.g.,ψ is large, which is often the case in land vehicle navigation with low cost inertial sensors, then 

**==> picture [245 x 44] intentionally omitted <==**

Under the assumption that there are no observations errors or model uncertainties, an ideal velocity can be computed. However, there are always sensor errors and model uncertainties that generate attitude error. When the biases of accelerometer are the only errors modeled as filter states, i.e., _δ_ **f** _ib[b][≈]_ **[b][a]**[, and large] ψ is assumed, the difference between ideal velocity and actual velocity satisfies 

**==> picture [239 x 31] intentionally omitted <==**

CUI _et al._ : IMPROVED CUBATURE KALMAN FILTER FOR GNSS/INS BASED ON TRANSFORMATION OF POSTERIOR SIGMA-POINTS ERROR 

2987 

Noticed that, the attitude and velocity error function have items that contain the multiplication of states and their trigonometric function, so the filter must at least approximates the process function at the accuracy of _2_ nd-order in mean Taylor series and _4_ th-order in covariance Taylor series. 

## REFERENCES 

- [1] R. E. Kalman, “A new approach to linear filtering and prediction problems,” _J. Basic Eng._ , vol. 82, pp. 35–45, Mar. 1960. 

- [2] H. Cox, “On the estimation of state variables and parameters for noisy dynamic systems,” _IEEE Trans. Autom. Control_ , vol. 9, no. 1, pp. 5–12, Jan. 1964. 

- [3] M. Athans, R. Wisher, and A. Bertolini, “Suboptimal state estimation for continuous-time nonlinear systems from discrete noisy measurements,” _IEEE Trans. Autom. Control_ , vol. 13, no. 5, pp. 504–514, Oct. 1968. 

- [4] J. L., Crassidis and F. L. Markley, “Unscented filtering for spacecraft attitude estimation,” _J. Guid., Control, Dyn._ , vol. 26, no. 4, pp. 536–542, Jul. 2003. 

- [5] Y. X. Wu, D. W. Hu, and X. P. Hu, “A numerical-integration perspective on Gaussian filters,” _IEEE Trans. Signal Process._ , vol. 54, no. 8, pp. 2910–2921, Aug. 2006. 

- [6] S. J. Julier, J. K. Uhlman, and H. F. Durrant-Whyte, “A new approach for filtering nonlinear systems,” in _Proc. IEEE Amer. Control Conf._ , Jun. 1995, pp. 1628–1632. 

- [7] W. I. Tam and D. Hatzinakos, “An efficient radar tracking algorithm using multidimensional Gauss-Hermite quadratures,” in _Proc. IEEE Int. Conf. Acoust., Speech Signal Process._ , Apr. 1997, vol. 5, pp. 3777–3780. 

- [8] K. Ito and K. Xiong, “Gaussian filtering for nonlinear filtering problems,” _IEEE Trans. Autom. Control_ , vol. 45, no. 5, pp. 910–927, May 2000. 

- [9] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Trans. Autom. Control_ , vol. 54, no. 6, pp. 1254–1269, Jun. 2009. 

- [10] B. Xu, P. Zhang, H. Z. Wen, and X. Wu, “Stochastic stability and performance analysis of cubature Kalman filter,” _Neurocomput._ , vol. 186, pp. 218–227, 2016. 

- [11] J. L. Crassidis, “Sigma-point Kalman filtering for integrated GPS and inertial navigation,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 42, no. 2, pp. 750–756, Apr. 2006. 

- [12] J. Wendel, J. Metzger, R. Moenikes, A. Maier, and G. F. Trommer, “A performance comparison of tightly coupled GPS/INS navigation systems based on extended and sigma point Kalman filters,” _Navigation_ , vol. 53, no. 1, pp. 21–31, 2006. 

- [13] Y. W. Zhao, “Performance evaluation of cubature Kalman filter in a GPS/IMU tightly-coupled navigation system,” _Signal Process._ , vol. 119, pp. 67–79, 2016. 

- [14] M. S. Arulampalam, S. Maskell, N. Gordon, and T. Clapp, “A tutorial on particle filters for online nonlinear/non-Gaussian Bayesian tracking,” _IEEE Trans. Signal Process._ , vol. 50, no. 2, pp. 174–188, Feb. 2002. 

- [15] M. F. Bugallo, S. Xu, and P. M. Djuric, “Performance comparison of EKF and particle filtering methods for maneuvering targets,” _Digit. Signal Process._ , vol. 17, pp. 774–786, 2007. 

- [16] P. M. Djuric _et al._ , “Particle filtering,” _IEEE Signal Process. Mag._ , vol. 20, no. 5, pp. 19–38, Sep. 2003. 

- [17] Y. S. Shmaliy, “An iterative Kalman-like algorithm ignoring noise and initial conditions,” _IEEE Trans. Signal Process._ , vol. 59, no. 6, pp. 2465–2473, Jun. 2011. 

- [18] X. Y. Chen, C. Shen, W. B. Zhang, M. Tomizuka, Y. Xu, and K. L. Chiu, “Novel hybrid of strong Kalman filter and wavelet neural network for GPS/INS during GPS outages,” _Measurement_ , vol. 46, no. 10, pp. 3847–3854, 2013. 

- [19] M. T. Menegaz, J. Y. Ishihara, G. A. Borges, and A. N. Vargas, “A systematization of the unscented Kalman filter theory,” _IEEE Trans. Autom. Control_ , vol. 60, no. 10, pp. 2583–2598, Oct. 2015. 

- [20] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _Proc. IEEE_ , vol. 92, no. 3, pp. 401–422, Mar. 2004. 

- [21] S. J. Julier and J. K. Uhlmann, “The scaled unscented transformation,” in _Proc. IEEE Amer. Control Conf._ , May 2002, pp. 4555–4559. 

- [22] P. D. Groves, _Principles of GNSS, Intertial, and Multisensory Integrated Navigation Systems_ , 3rd ed. Boston, MA, USA: Artech House, 2013, pp. 584–606. 

- [23] M. R. Morelande and A. Garc´ıa-Fern´andez, “Analysis of Kalman filter ap-[´] proximations for nonlinear measurements,” _IEEE Trans. Signal Process._ , vol. 61, no. 22, pp. 5477–5483, Nov. 2013. 

- [24] ´A. Garc´ıa-Fern´andez, M. R. Morelande and J. Grajal, “Truncated unscented Kalman filtering,” _IEEE Trans. Signal Process._ , vol. 60, no. 7, pp. 3372–3386, Jul. 2012. 

- [25] ´A. Garc´ıa-Fern´andez, L. Svensson, M. R. Morelande and S. Sarkka, “Posterior linearization filter: Principles and implementation using sigma points,” _IEEE Trans. Signal Process._ , vol. 63, no. 20, pp. 5561–5573, Oct. 2015. 

- [26] L. B. Chang, B. Q. Hu, A. Li, and F. J. Qin, “Transformed unscented Kalman filter,” _IEEE Trans. Autom. Control_ , vol. 58, no. 1, pp. 252–257, Jan. 2013. 

- [27] C. J. Masrelied, “Approximate non-Gaussian filtering with linear state and observation relations,” _IEEE Trans. Autom. Control_ , vol. 20, no. 1, pp. 107–110, Feb. 1975. 

- [28] Y. Tian and Y. Cheng, “Novel measurement update method for quadraturebased Gaussian filters,” in _Proc. AIAA Guid., Navig., Control Conf._ , Aug. 2013. 

- [29] B. Jia, M. Xin, and Y. Cheng, “Sparse-grid quadrature nonlinear filtering,” _Automatica_ , vol. 48, no. 2, pp. 327–341, 2012. 

- [30] J. Hu, Z. D. Wang, H. J. Gao, and L. K. Stergioulas, “Extended Kalman filtering with stochastic nonlinearities and multiple missing measurements,” _Automatica_ , vol. 48, no. 9, pp. 2007–2015, 2012. 

- [31] K. Xiong, C. L. Wei, and L. D. Liu, “Robust Kalman filtering for discretetime nonlinear systems with parameter uncertainties,” _Aerosp. Sci. Technol._ , vol. 18, no. 1 pp. 15–24, 2012. 

- [32] Y. L. Huang, Y. G. Zhang, N. Li, and L. Zhao, “An improved Gaussian approximate filtering method,” _Acta Autom. Sinica_ , vol. 42, no. 3, pp. 385– 401, Mar. 2016. 

- [33] F. Sandblom and L. Svensson, “Moment estimation using a marginalized transform,” _IEEE Trans. Signal Process._ , vol. 60, no. 12, pp. 6138–6150, Dec. 2012. 

- [34] K. Xiong, H. Y. Zhang, and C. W. Chan, “Performance evaluation of UKF-based nonlinear filter,” _Automatica_ , vol. 42, no. 2, pp. 261–270, 2006. 

- [35] L. Li and Y. Q. Xia, “Stochastic stability of the unscented Kalman filter with intermittent observations,” _Automatica_ , vol. 48, no. 5, pp. 978–981, 2012. 

**Bingbo Cui** received the B.S. degree in electrical engineering and the M.S. degree from Chongqing University of Technology, Chongqing, China, in 2005 and 2012, respectively. He is currently working toward the Ph.D. degree at the Faculty of Precision Instrument and Machinery, Southeast University, Nanjing, China. 

**==> picture [73 x 90] intentionally omitted <==**

His research interests include inertial navigation, nonlinear filtering, and integrated navigation in particular. 

**Xiyuan Chen** (M’10–SM’13) received the Ph.D. degree in precision instrument and machinery from Southeast University, Nanjing, China, in 1998. 

**==> picture [73 x 91] intentionally omitted <==**

He is currently a Professor in the School of Instrument Science and Engineering, Southeast University. His research interests include fiber optic sensors, inertial navigation, GNSS software receiver and wireless location technologies, integrated navigation, and related application. 

**Xinhua Tang** received the Ph.D. degree from Politecnico di Torino, Torino, Italy. 

**==> picture [73 x 90] intentionally omitted <==**

He worked in the Istituto Superiore Mario Boella, Turin, Italy, in 2014. He is currently an Assistant Professor in Southeast University, Nanjing, China. His interest focuses on the development of advanced GNSS techniques including new discriminator design, vector tracking architecture, and ultratight integration. 

