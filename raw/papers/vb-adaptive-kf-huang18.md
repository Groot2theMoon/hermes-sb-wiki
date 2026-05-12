---
title: "A Novel Adaptive Kalman Filter With Inaccurate Process and Measurement Noise Covariance Matrices"
journal: "IEEE Transactions on Automatic Control, Vol. 63, No. 2"
authors: ["Yulong Huang", "Yonggang Zhang", "Zhemin Wu", "Ning Li", "Jonathon Chambers"]
year: 2018
source: paper
ingested: 2026-05-12
sha256: ddcca3e7f9e550e5226a5302c1730b52ee9a2f7f774cae696aa0db9cadeae5fd
conversion: pymupdf4llm
---

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

594 

**==> picture [44 x 33] intentionally omitted <==**

## A Novel Adaptive Kalman Filter With Inaccurate Process and Measurement Noise Covariance Matrices 

## Yulong Huang , Yonggang Zhang _, Senior Member, IEEE_ , Zhemin Wu , Ning Li , and Jonathon Chambers _, Fellow, IEEE_ 

_**Abstract**_ **—In this paper, a novel variational Bayesian (VB)-based adaptive Kalman filter (VBAKF) for linear Gaussian state-space models with inaccurate process and measurement noise covariance matrices is proposed. By choosing inverse Wishart priors, the state together with the predicted error and measurement noise covariance matrices are inferred based on the VB approach. Simulation results for a target tracking example illustrate that the proposed VBAKF has better robustness to resist the uncertainties of process and measurement noise covariance matrices than existing** 

_**Index Terms**_ **—Adaptive filtering, inverse Wishart distribution, Kalman filtering, time-varying noise covariance matrices, variational Bayesian (VB).** 

## I. INTRODUCTION 

The Kalman filter is an optimal state estimator for linear Gaussian state-space models, and it has been widely used in many applications, such as navigation, target tracking, and control. The performance of the Kalman filter depends largely on _a priori_ knowledge of the noise statistics, and the use of wrong _a priori_ statistics can result in substantial estimation errors or even filtering divergence [1]. However, in many applications, such as Global Positioning System and Inertial Navigation System-based integrated navigation systems, their noise statistics may be unknown and time-varying [2]–[4]. The adaptive Kalman filter (AKF) is the most common method to solve this problem, and it can be divided into correlation, covariance matching, maximum likelihood, and Bayesian methods [1]. 

Manuscript received December 27, 2016; revised April 4, 2017 and April 12, 2017; accepted July 7, 2017. Date of publication September 5, 2017; date of current version January 26, 2018. This work was supported in part by the National Natural Science Foundation of China under Grant 61773133 and 61633008, in part by the Natural Science Foundation of Heilongjiang Province under Grant F2016008, in part by the Fundamental Research Founds for the Central University of Harbin Engineering University under Grant HEUCFP201705 and under Grant HEUCF041702, in part by the Ph.D. Student Research and Innovation Fund of the Fundamental Research Founds for the Central Universities under Grant HEUGIP201706, in part by the China Scholarship Council Foundation, and in part by the Engineering and Physical Sciences Research Council of the U.K. under Grant EP/K014307/1. Recommended by Associate Editor Samer S. Saab. _(Corresponding author: Yonggang Zhang.)_ 

Y. Huang, Y. Zhang, and N. Li are with the Department of Automation, Harbin Engineering University, Harbin 150001, China (e-mail: heuedu@163.com; zhangyg@hrbeu.edu.cn; ningli@hrbeu.edu.cn). 

Z. Wu is with the School of Electrical Engineering and Automation, Harbin Institute of Technology, Harbin 150080, China (e-mail: myemailabc@163.com). 

J. Chambers is with the Department of Automation, Harbin Engineering University, Harbin 150001, China, and also with the School of Electrical and Electronic Engineering, Newcastle University, Newcastle upon Tyne NE1 7RU, U.K. (e-mail: Jonathon.Chambers@newcastle.ac.uk). 

Color versions of one or more of the figures in this paper are available online at http://ieeexplore.ieee.org. 

Digital Object Identifier 10.1109/TAC.2017.2730480 

The Sage–Husa AKF (SHAKF) is a covariance matching method, which estimates the noise statistics recursively based on the maximum a posterior criterion [5], [6]. However, the convergence to the right noise covariance matrices is not guaranteed with SHAKF, which may lead to filtering divergence [1]. The Innovation-based AKF (IAKF) is a maximum likelihood method, which estimates the noise covariance matrices based on the fact that the innovation sequence of the Kalman filter is a white process [2]. However, the IAKF requires rather large windows of data to obtain reliable estimations of noise covariance matrices, which makes it impractical for rapidly varying noise covariance matrices [7]. The multiple model AKF (MMAKF) is an approximation of the Bayesian method, which can deal with the model uncertainty by operating a bank of Kalman filters with different models simultaneously [8]. However, the MMAKF suffers from substantial computational complexities [9]. 

The existing variational Bayesian (VB) based AKF (VBAKF) is also an approximation of the Bayesian method, which can estimate an inaccurate and slowly varying measurement noise covariance matrix (MNCM) by choosing appropriate conjugate prior distribution [9]– [12]. However, the performance of the existing VBAKF will degrade for an inaccurate process noise covariance matrix (PNCM) since it assumes accurate PNCM. Although the VB based Rauch–Tung–Striebel smoother can estimate unknown PNCM and MNCM simultaneously [13], [14], it can only estimate unknown and constant noise covariance matrices offline. To the best of the knowledge of the authors, it is always a challenge to design a VBAKF for linear Gaussian state-space models with inaccurate PNCM and MNCM since the PNCM is difficult to be estimated directly with a rather small window of data. 

In this paper, a novel VBAKF with inaccurate PNCM and MNCM is proposed. By choosing inverse Wishart priors for the predicted error covariance matrix (PECM) and MNCM, the state together with PECM and MNCM are inferred based on the VB approach. The proposed VBAKF and existing filters are applied to the problem of target tracking with inaccurate and slowly varying PNCM and MNCM. Simulation results show the proposed filter has smaller root mean square error (RMSE) than existing state-of-the-art filters. 

## II. MAIN RESULTS 

## _A. Problem Formulation_ 

Consider the following discrete-time linear stochastic system as shown by the state-space model 

**==> picture [167 x 9] intentionally omitted <==**

**==> picture [167 x 9] intentionally omitted <==**

where (1) and (2) are respectively process and measurement equations, _k_ is the discrete time index, **x** _k_ ∈ R _[n]_ is the state vector, **z** _k_ ∈ R _[m]_ is the measurement vector, **F** _k_ ∈ R _[n]_[×] _[n]_ is the state transition matrix, **H** _k_ ∈ R _[m]_[×] _[n]_ is the observation matrix; **w** _k_ ∈ R _[n]_ and **v** _k_ ∈ R _[m]_ are re- 

0018-9286 © 2017 IEEE. Translations and content mining are permitted for academic research only. Personal use is also permitted, but republication/redistribution requires IEEE permission. See http://www.ieee.org/publications ~~s~~ tandards/publications/rights/index.html for more information. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

595 

spectively Gaussian process and measurement noise vectors with zero mean vectors and covariance matrices **Q** _k_ and **R** _k_ . The initial state vector **x** 0 is assumed to have a Gaussian distribution with mean vector **ˆx** 0|0 and covariance matrix **P** 0|0. Moreover, **x** 0, **w** _k_ , and **v** _j_ are assumed to be mutually uncorrelated for any _j_ and _k_ . 

The Kalman filter is frequently employed to estimate the state vector **x** _k_ given the state-space model and measurements **z** 1: _k_ , where **z** 1: _k_ = { **z** _j_ } _[k] j_ =1[denotes the measurements from time 1 to time] _[ k]_[. The Kalman] filter is optimal in terms of minimum mean square error (MMSE) for linear Gaussian state-space model (1)–(2) with accurate **Q** _k_ and **R** _k_ . However, the use of wrong/inaccurate **Q** _k_ and **R** _k_ can result in substantial estimation errors or even filtering divergence [1]. Therefore, a novel VBAKF suitable for operation with inaccurate PNCM and MNCM will be proposed. 

## _B. Choices of Prior Distributions_ 

In the framework of the Kalman filter, the one-step predicted PDF _p_ ( **x** _k_ | **z** 1: _k_ −1) and likelihood PDF _p_ ( **z** _k_ | **x** _k_ ) are Gaussian, i.e.. 

**==> picture [200 x 10] intentionally omitted <==**

**==> picture [177 x 9] intentionally omitted <==**

where N(·; _μ, �_ ) denotes the Gaussian PDF with mean vector _μ_ and covariance matrix _�_ , and **ˆx** _k_ | _k_ −1 and **P** _k_ | _k_ −1 are respectively the predicted state vector and corresponding PECM, and **ˆx** _k_ | _k_ −1 and **P** _k_ | _k_ −1 are given by 

**==> picture [187 x 10] intentionally omitted <==**

**==> picture [188 x 11] intentionally omitted <==**

where (·) _[T]_ denotes the transpose operation, and **ˆx** _k_ −1| _k_ −1 and **P** _k_ −1| _k_ −1 are respectively the state estimation vector and corresponding estimation error covariance matrix at time _k_ − 1. Note that **P** _k_ | _k_ −1 obtained from (6) is inaccurate since the true PNCM **Q** _k_ is unavailable and an inaccurate PNCM is used. 

Our aim is to infer **x** _k_ together with **P** _k_ | _k_ −1 and **R** _k_ . To this end, the conjugate prior distributions need to be first selected for inaccurate PECM **P** _k_ | _k_ −1 and MNCM **R** _k_ since the conjugacy can guarantee that the posterior distribution is of the same functional form as the prior distribution. In Bayesian statistics, the inverse Wishart distribution is usually used as the conjugate prior for the covariance matrix of a Gaussian distribution with known mean [15]. The inverse Wishart PDF of a symmetric positive definite random matrix **B** of dimension _d_ × _d_ is formulated as IW( **B** ; _λ, �_ ) = | _�_ | _[λ/]_[2] | **B** |[−][(] _[λ]_[+] 2 _[d][d]_[+] _[λ/]_[1)][2] _[/] �_[2] _d_ exp( _λ/_ {2)−0 _._ 5tr( _�_ **B**[−][1] )} , where _λ_ is the degrees of freedom (dof) parameter, and _�_ is the inverse scale matrix that is a symmetric positive definite matrix of dimension _d_ × _d_ , and | · | and tr(·) denote the determinant and trace operations, respectively, and _�d_ (·) is the _d_ -variate gamma function [15]. If **B** ∼ IW( **B** ; _λ, �_ ), then E[ **B**[−][1] ] = ( _λ_ − _d_ − 1) _�_[−][1] when _λ > d_ + 1 [15]. Since both **P** _k_ | _k_ −1 and **R** _k_ are the covariance matrices of Gaussian PDFs, their prior distributions _p_ ( **P** _k_ | _k_ −1| **z** 1: _k_ −1) and _p_ ( **R** _k_ | **z** 1: _k_ −1) are chosen as inverse Wishart PDFs, i.e., 

**==> picture [202 x 12] intentionally omitted <==**

**==> picture [191 x 11] intentionally omitted <==**

where IW(·; _μk, �k_ ) denotes the inverse Wishart PDF with dof parameter _μk_ and inverse scale matrix _�k_ , and _t_[ˆ] _k_ | _k_ −1 and **T**[ˆ] _k_ | _k_ −1 are respectively the dof parameter and inverse scale matrix of ˆ _p_ ( **P** _k_ | _k_ −1| **z** 1: _k_ −1), and _uk_ | _k_ −1 and **U**[ˆ] _k_ | _k_ −1 are respectively the dof parameter and inverse scale matrix of _p_ ( **R** _k_ | **z** 1: _k_ −1). Next, the prior parameters ˆ ˆ _tk_ | _k_ −1, **T**[ˆ] _k_ | _k_ −1, _uk_ | _k_ −1, and **U**[ˆ] _k_ | _k_ −1 will be determined. 

To capture the prior information of **P** _k_ | _k_ −1, the mean value of **P** _k_ | _k_ −1 is set as the nominal PECM **P[˜]** _k_ | _k_ −1, i.e., 

**==> picture [219 x 24] intentionally omitted <==**

where **Q[˜]** _k_ −1 denotes the nominal PNCM and is an algorithm parameter of the proposed VBAKF. Let 

**==> picture [159 x 10] intentionally omitted <==**

where _τ_ ≥ 0 is a tuning parameter. Using (10) in (9) yields 

**==> picture [157 x 12] intentionally omitted <==**

According to the Bayesian theorem, the prior distribution _p_ ( **R** _k_ | **z** 1: _k_ −1) is formulated as 

**==> picture [216 x 21] intentionally omitted <==**

where _p_ ( **R** _k_ −1| **z** 1: _k_ −1) is the posterior PDF of MNCM **R** _k_ −1. 

Since the prior distribution _p_ ( **R** _k_ −1| **z** 1: _k_ −2) of MNCM **R** _k_ −1 is chosen as an inverse Wishart PDF in accordance with (8), the posterior PDF _p_ ( **R** _k_ −1| **z** 1: _k_ −1) can be also updated as an inverse Wishart PDF, i.e., 

**==> picture [209 x 12] intentionally omitted <==**

To guarantee _p_ ( **R** _k_ | **z** 1: _k_ −1) is an inverse Wishart PDF formulated in (8), the forward predictive model _p_ ( **R** _k_ | **R** _k_ −1) needs to be determined. However, in practical application, the dynamical model _p_ ( **R** _k_ | **R** _k_ −1) is not known in detail. Considering that the MNCM is slowly varying in many practical applications, in this paper, we use similar heuristics as in [10], which just spreads previous approximate posteriors through a ˆ factor of _ρ_ , and the prior parameters _uk_ | _k_ −1 and **U**[ˆ] _k_ | _k_ −1 are given by 

**==> picture [195 x 10] intentionally omitted <==**

**==> picture [197 x 11] intentionally omitted <==**

where _ρ_ ∈ (0 1] is a forgetting factor which indicates the extent of the 

In this paper, the initial MNCM **R** 0 is also assumed to have an inverse Wishart PDF, i.e., _p_ ( **R** 0) = IW( **R** 0; _u_ ˆ 0|0 _,_ **U**[ˆ] 0|0). To capture the prior information of the initial MNCM, the mean value of **R** 0 is set as the initial nominal MNCM **R[˜]** 0, i.e., 

**==> picture [161 x 24] intentionally omitted <==**

where the initial nominal MNCM **R[˜]** 0 is an algorithm parameter of the proposed VBAKF. 

## _C. Variational Approximations of Posterior PDFs_ 

To estimate **x** _k_ together with **P** _k_ | _k_ −1 and **R** _k_ , the joint posterior PDF _p_ ( **x** _k,_ **P** _k_ | _k_ −1 _,_ **R** _k_ | **z** 1: _k_ ) needs to be computed. Since there is not an analytical solution for this joint posterior PDF, the VB approach is used to look for a free form factored approximate PDF for _p_ ( **x** _k,_ **P** _k_ | _k_ −1 _,_ **R** _k_ | **z** 1: _k_ ), i.e., [16], [17] 

**==> picture [205 x 10] intentionally omitted <==**

where _q_ (·) represents the approximate posterior PDF of _p_ (·), and _q_ ( **x** _k_ ), 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

596 

_q_ ( **P** _k_ | _k_ −1), and _q_ ( **R** _k_ ) are given by minimizing the Kullback–Leibler divergence (KLD) between the factored approximate posterior PDF _q_ ( **x** _k_ ) _q_ ( **P** _k_ | _k_ −1) _q_ ( **R** _k_ ) and true joint posterior PDF _p_ ( **x** _k,_ **P** _k_ | _k_ −1 _,_ **R** _k_ | **z** 1: _k_ ), i.e., [16], [17] 

**==> picture [204 x 29] intentionally omitted <==**

where KLD( _q_ ( _x_ )|| _p_ ( _x_ )) ≜ � _q_ ( _x_ ) log _[q] p_[(] ( _[x] x_[)] ) _[dx]_[denotes][the][KLD][be-] tween _q_ ( _x_ ) and _p_ ( _x_ ). The optimal solution for (18) satisfies the following equation [17]: 

**==> picture [194 x 9] intentionally omitted <==**

**==> picture [172 x 11] intentionally omitted <==**

· · where E[ ] represents the expectation operation, and log( ) represents the logarithmic function, and _θ_ is an arbitrary element of _�_ , and _�_[(][−] _[θ]_[)] is the set of all elements in _�_ except for _θ_ , and _cθ_ denotes the constant with respect to variable _θ_ . Since the variational parameters of _q_ ( **x** _k_ ), _q_ ( **P** _k_ | _k_ −1) and _q_ ( **R** _k_ ) are coupled, we need to employ fixed-point iterations to solve (19), where the approximate posterior PDF _q_ ( _θ_ ) of the arbitrary element _θ_ is updated as _q_[(] _[i]_[+][1)] ( _θ_ ) at the _i_ + 1th iteration using the approximate posterior PDF _q_[(] _[i]_[)] ( _�_[(][−] _[θ]_[)] ) [16], [17]. The iterations converge to a local optimum of (19). 

_Remark 1:_ In the standard VB approach, the KLD is chosen as a distance measure between the factored approximate posterior PDF and true joint posterior PDF, and the optimal solution is obtained by minimizing the KLD. The VB approach can provide a closed form solution for the approximate posterior PDF and guarantee the local convergence of the fixed-point iterations. The alpha and tau divergences are generalized distance measures [18], [19], and in principle they can be also used as a distance measure between the factored approximate posterior PDF and true joint posterior PDF. However, the alpha or tau divergence-based Bayesian inference approach may not provide a closed form solution for the approximate posterior PDF. 

Using the conditional independence properties of the Gaussianinverse-Wishart state-space model in (1)–(4), (7), and (8), the joint PDF _p_ ( _�,_ **z** 1: _k_ ) can be factored as 

**==> picture [162 x 12] intentionally omitted <==**

**==> picture [196 x 9] intentionally omitted <==**

Employing (3), (4) and (7), (8) in (21) obtains 

**==> picture [215 x 47] intentionally omitted <==**

Exploiting (22), log _p_ ( _�,_ **z** 1: _k_ ) is formulated as 

**==> picture [169 x 10] intentionally omitted <==**

**==> picture [219 x 51] intentionally omitted <==**

Let _θ_ = **P** _k_ | _k_ −1 and using (23) in (19), we have 

**==> picture [222 x 109] intentionally omitted <==**

where _q_[(] _[i]_[+][1)] (·) is the approximation of PDF _q_ (·) at the _i_ + 1th iteration, and **A**[(] _k[i]_[)][is given by] 

**==> picture [206 x 108] intentionally omitted <==**

where E[(] _[i]_[)] [ _ρ_ ] denotes the expectation of variable _ρ_ at the _i_ th iteration. Exploiting (24), _q_[(] _[i]_[+][1)] ( **P** _k_ | _k_ −1) can be updated as an inverse Wishart PDF with dof parameter _t_[ˆ] _k_[(] _[i]_[+][1)] and inverse scale matrix **T[ˆ]**[(] _k[i]_[+][1)] , i.e., 

**==> picture [199 x 13] intentionally omitted <==**

where the dof parameter _t_[ˆ] _k_[(] _[i]_[+][1)] and inverse scale matrix **T[ˆ]**[(] _k[i]_[+][1)] are given by 

**==> picture [167 x 31] intentionally omitted <==**

Let _θ_ = **R** _k_ and using (23) in (19), we have 

**==> picture [220 x 116] intentionally omitted <==**

where **B**[(] _k[i]_[)][is given by] 

**==> picture [217 x 109] intentionally omitted <==**

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

597 

**==> picture [252 x 73] intentionally omitted <==**

**==> picture [167 x 30] intentionally omitted <==**

**==> picture [155 x 9] intentionally omitted <==**

**==> picture [220 x 118] intentionally omitted <==**

**==> picture [177 x 12] intentionally omitted <==**

**==> picture [204 x 33] intentionally omitted <==**

Define the modified one-step predicted PDF _p_[(] _[i]_[+][1)] ( **x** _k_ | **z** 1: _k_ −1) and likelihood PDF _p_[(] _[i]_[+][1)] ( **z** _k_ | **x** _k_ ) at iteration _i_ + 1 as follows: 

**==> picture [195 x 31] intentionally omitted <==**

where the modified PECM **P[ˆ]**[(] _k[i]_ |[+] _k_ −[1)] 1[and MNCM] **[ˆR]**[(] _k[i]_[+][1)] are formulated as 

**==> picture [232 x 14] intentionally omitted <==**

Employing (37)–(39) in (34) yields 

**==> picture [210 x 24] intentionally omitted <==**

where the normalizing constant _ck_[(] _[i]_[+][1)] is given by 

**==> picture [205 x 21] intentionally omitted <==**

According to (37)–(41), _q_[(] _[i]_[+][1)] ( **x** _k_ ) can be updated as a Gaussian PDF with mean vector **ˆx**[(] _k[i]_ |[+] _k_[1)] and covariance matrix **P**[(] _k[i]_ |[+] _k_[1)][, i.e.,] 

**==> picture [183 x 13] intentionally omitted <==**

where the mean vector **ˆx**[(] _k[i]_ |[+] _k_[1)] and covariance matrix **P**[(] _k[i]_ |[+] _k_[1)] at iteration _i_ + 1 are given by 

**==> picture [205 x 51] intentionally omitted <==**

**Algorithm 1:** One time step of the proposed VBAKF with inaccurate PNCM and MNCM. 

- ˆ ˆ 

- **Inputs** : **x** _k_ −1| _k_ −1, **P** _k_ −1| _k_ −1, _uk_ −1| _k_ −1, **U[ˆ]** _k_ −1| _k_ −1, **F** _k_ −1, **H** _k_ , **z** _k_ , **Q[˜]** _k_ −1, _m_ , _n_ , _τ_ , _ρ_ , _N_ 

**Time update:** 

**==> picture [242 x 293] intentionally omitted <==**

After fixed-point iteration _N_ , the variational approximations of posterior PDFs are given by 

**==> picture [233 x 87] intentionally omitted <==**

The proposed VBAKF operates recursively by combining time update (5), (9)–(11), and (14)–(16) with variational measurement update (25)–(28), (30)–(33), (35)–(36), (39), and (42)–(48), whose implementation pseudocode is shown in Algorithm 1. 

_Remark 2:_ In the standard Kalman filter, **P** _k_ | _k_ −1 is usually used to represent the covariance matrix of the predicted error based on the measurement information **z** 1: _k_ −1. However, in the proposed method, **P** _k_ | _k_ −1 is estimated using the measurement information **z** 1: _k_ −1 and **z** _k_ based on the VB approach. Thus, the estimation of PECM **P[ˆ]** _k_ | _k_ −1 depends on not only previous measurement information **z** 1: _k_ −1 but also current measurement information **z** _k_ . 

## _D. Parameter Selection of the Proposed VBAKF_ 

To implement the proposed VBAKF, the tuning parameter _τ_ , the forgetting factor _ρ_ , the nominal PNCM **Q[˜]** _k_ , and the initial nominal MNCM **R[˜]** 0 need to be selected. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

598 

First, we discuss the effect of the tuning parameter _τ_ upon the proposed VBAKF. Substituting (36) in (39), the modified PECM **P[ˆ]**[(] _k[i]_ |[+] _k_ −[1)] 1 can be reformulated as 

**==> picture [170 x 25] intentionally omitted <==**

Using (10)–(11) and (27)–(28) in (49) yields 

**==> picture [201 x 25] intentionally omitted <==**

It is seen from (50) that the tuning parameter _τ_ can be deemed as a harmonic weight to balance the efficacy of **P[˜]** _k_ | _k_ −1 and **A**[(] _k[i]_[)][.][On][the] one hand, if _τ_ is too large, the substantial prior uncertainties induced by the inaccurate nominal PNCM are introduced into the measurement update, which degrades the performance of the proposed VBAKF. On the other hand, if _τ_ is too small, a large quantity of information about the process model is lost, which also degrades the performance of the proposed VBAKF. In this paper, the tuning parameter is selected to lie within the range _τ_ ∈ [2 _,_ 6], and the proposed VBAKF with _τ_ ∈ [2 _,_ 6] has essentially consistent estimation performance and higher estimation accuracy than existing filters, as shown in the later simulation. 

Second, we study the effect of the forgetting factor _ρ_ upon the proposed VBAKF. Substituting (35) in (39), the modified MNCM **R[ˆ]**[(] _k[i]_[+][1)] is rewritten as 

**==> picture [172 x 26] intentionally omitted <==**

Using (14)–(15) and (32)–(33) in (51) results in 

**==> picture [220 x 24] intentionally omitted <==**

According to (48), the estimation of MNCM at time _k_ − 1 can be formulated 

**==> picture [175 x 24] intentionally omitted <==**

Substituting (53) in (52), we obtain 

**==> picture [203 x 25] intentionally omitted <==**

Using (14), (32), and (48) yields 

**==> picture [194 x 10] intentionally omitted <==**

Solving (55) gives 

ˆ _uk_ −1| _k_ −1 − _m_ − 1 = _ρ[k]_[−][1] (ˆ _u_ 0|0 − _m_ − 1) + (1 − _ρ[k]_[−][1] ) _/_ (1 − _ρ_ ) _._ (56) Utilizing (56) in (54) results in 

**==> picture [179 x 24] intentionally omitted <==**

where _w_ ( _ρ, k_ ) is given by 

**==> picture [215 x 11] intentionally omitted <==**

Using (58) gives 

**==> picture [177 x 13] intentionally omitted <==**

It is seen from (57)–(58) that _w_ ( _ρ, k_ ) can be deemed as a harmonic weight to balance the efficacy of **R[ˆ]** _k_ −1 and **B**[(] _k[i]_[)][. Moreover, we can see] from (59) that _w_ ( _ρ, k_ ) is a monotone increasing function of the forgetting factor _ρ_ when _k_ →+∞. Thus, the forgetting factor _ρ_ ∈ (0 1] 

can be used to adjust the efficacy of the previous estimation of MNCM **ˆR** _k_ −1 upon the modified MNCM **ˆR**[(] _k[i]_[+][1)] . On the one hand, the smaller the forgetting factor _ρ_ , the more the information from the previous estimation **R[ˆ]** _k_ −1 of MNCM is forgotten. On the other hand, the larger the forgetting factor _ρ_ , the more the information from the previous estimation **R[ˆ]** _k_ −1 of MNCM is used. Considering that the MNCM is slowly varying in many practical applications, the forgetting factor is selected to lie within the range _ρ_ ∈ [0 _._ 9 _,_ 1], and the proposed VBAKF with _ρ_ ∈ [0 _._ 9 _,_ 1] has essentially consistent estimation performance and higher estimation accuracy than existing filters, as shown in the later simulation. Note that the forgetting factor _ρ_ = 1 corresponds to stationary MNCM. 

Third, we discuss the effect of the nominal PNCM **Q[˜]** _k_ and the initial nominal MNCM **R[˜]** 0 upon the proposed VBAKF. In the fixed-point iterations, the initial values **P[ˆ]**[(0)] _k_ | _k_ −1[and] **[ˆR]**[(0)] _k_[are set as] 

**==> picture [211 x 28] intentionally omitted <==**

Let 

**==> picture [202 x 24] intentionally omitted <==**

where 0 _< ak <_ 1 and **C** _k_ ≥ **0** . Substituting (61) in (57) results in 

**==> picture [162 x 10] intentionally omitted <==**

With **R[ˆ]** 0 = **R[˜]** 0 and solving (62) obtains 

**==> picture [204 x 34] intentionally omitted <==**

It is seen from (60) and (63) that **Q[˜]** _k_ and **R[˜]** 0 respectively have effects on the initial values **P[ˆ]**[(0)] _k_ | _k_ −1[and] **[ˆR]**[(0)] _k_[. Moreover, we can see from] (63) that the effect of **R[˜]** 0 on **R[ˆ]**[(0)] _k_ is gradually reduced as _k_ increases. To guarantee that **P[ˆ]**[(] _k[i]_ |[)] _k_ −1[and] **[ˆR]**[(] _k[i]_[)][converge][to][true][PECM] **[P]** _[k]_[|] _[k]_[−][1][and] MNCM **R** _k_ , appropriate initial values **P[ˆ]**[(0)] _k_ | _k_ −1[and] **[ˆR]**[(0)] _k_[are required since] the VB approach can only guarantee local convergence. To this end, the nominal PNCM **Q[˜]** _k_ needs to be near the true PNCM **Q** _k_ at each time, and the initial nominal MNCM **R[˜]** 0 needs to be near the initial true MNCM **R** 0. In this paper, the nominal PNCM and the initial nominal MNCM are respectively set as **Q[˜]** _k_ = diag[ _α_ 1 _,k, . . . , αi,k, . . . , αn,k_ ] and **R[˜]** 0 = diag[ _β_ 1 _, . . . , β j , . . . , βm_ ], where _αi,k >_ 0 and _β j >_ 0. The parameters _αi,k_ and _β j_ are selected based on engineering experience since the diagonal entries of the PNCM and MNCM can be approximately known in many practical applications. 

Finally, we study the numerical stability of the proposed VBAKF with the selections of **Q[˜]** _k_ and **R[˜]** 0. Using **Q[˜]** _k >_ **0** , **R[˜]** 0 _>_ **0** , 0 _< ai <_ 1 and **C** _k_ ≥ **0** in (60) and (63) gives 

**==> picture [173 x 12] intentionally omitted <==**

Exploiting (25) and (30) yields 

**==> picture [166 x 12] intentionally omitted <==**

Employing (64), (65) in (50) and (57) obtains 

**==> picture [175 x 12] intentionally omitted <==**

It is seen from (66) that the modified PECM **P[ˆ]**[(] _k[i]_ |[+] _k_ −[1)] 1[and][MNCM] **ˆR**[(] _k[i]_[+][1)] are positive definite. Thus, the proposed VBAKF is numerically stable based on the selections of **Q[˜]** _k_ and **R[˜]** 0. 

_Remark 3:_ The number of iterations _N_ is an important parameter for the proposed filter since it determines the estimation accuracy and 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

599 

implementation time. As the number of iterations increases, the better estimation accuracy is achieved but the more implementation time is required. Generally, the higher dimensions of the state and measurement vectors, an increasing number of iterations is required since with the higher dimensions of the state and measurement vectors, the more inaccurate information involved in the PECM and MNCM needs to be estimated. In practical application, we suggest selecting sufficiently large value for the number of iterations to guarantee that the fixed-point iterations converges to a local optimum. 

_Remark 4:_ In this paper, the tuning parameter and the forgetting factor are selected to lie within the ranges _τ_ ∈ [2 _,_ 6] and _ρ_ ∈ [0 _._ 9 _,_ 1] respectively based on the above discussions. The recommendations regarding parameter ranges are specific to the simulation study presented in this paper, and perhaps other parameter ranges are more appropriate in other situations. Fortunately, our experience has indicated that the proposed filter with the suggested parameter ranges exhibit good estimation performance in many contexts. 

## III. SIMULATIONS 

The performance of the proposed VBAKF is illustrated in the problem of target tracking with slowly varying PNCM and MNCM. In this simulation scenario, the target moves according to the continuous white noise acceleration motion model in two-dimensional (2-D) Cartesian coordinates, and the target’s positions are collected by a sensor. The state is defined as **x** _k_ ≜ [ _xk yk x_ ˙ _k y_ ˙ _k_ ], where _xk_ , _yk_ , _x_ ˙ _k_ , and _y_ ˙ _k_ denote the cartesian coordinates and corresponding velocities [13], [20]. The state transition matrix **F** _k_ −1 and observation matrix **H** _k_ are respectively given by 

**==> picture [197 x 28] intentionally omitted <==**

where the parameter _�t_ = 1s is the sampling interval and **I** 2 is the 2-D identity matrix. Similar to [13], the true PNCM and MNCM are given by 

**==> picture [215 x 65] intentionally omitted <==**

where _T_ = 1000 s denotes the simulation time, and _q_ = 1 m[2] _/_ s[3] and _r_ = 100 m[2] . 

In this simulation, the nominal PNCM and MNCM are respectively selected as **Q[˜]** _k_ = _α_ **I** 4 and **R[˜]** 0 = _β_ **I** 2, where **I** 4 is the 4-D identity matrix. The Kalman filter with nominal covariance matrices **Q[˜]** _k_ and **R[˜]** 0 (KFNCM), the Kalman filter with true covariance matrices **Q** _k_ and **R** _k_ (KFTCM), the existing IAKF [2], the existing SHAKF [6], the existing VBAKF for estimating only **R** _k_ (VBAKF-R) [10], [11], and the proposed VBAKF for estimating PECM and MNCM are tested. Note that the IAKF [2] and SHAKF [6] were often found filtering divergence; thus, their simulation results are not shown in the following simulation. In the proposed VBAKF and existing KFNCM and VBAKF-R, the algorithm parameters are set as: parameter _α_ = 1, parameter _β_ = 100, tuning parameter _τ_ = 3, forgetting factor _ρ_ = 1 − exp(−4), and the number of iterations _N_ = 10. All algorithms are coded with MATLAB and the simulations are run on a computer with Intel Core i7-3770 CPU at 3.40 GHz. 

To evaluate the estimate accuracy of state, the RMSEs and the averaged RMSEs (ARMSEs) of position and velocity are chosen as 

**==> picture [245 x 143] intentionally omitted <==**

Fig. 1. RMSEs of the position and velocity. 

**==> picture [245 x 150] intentionally omitted <==**

Fig. 2. SRNFNs of the PECM and MNCM. 

performance metrics, which are defined as follows: 

**==> picture [244 x 39] intentionally omitted <==**

where ( _xk[s][,][ y] k[s]_[) and (ˆ] _[x] k[s][,][y]_[ˆ] _k[s]_[) are the true and estimated positions at][the] _s_ th Monte Carlo run, and _M_ = 1000 represents the total number of Monte Carlo runs. Similar to the RMSE and ARMSE in position, we can also write formula for the RMSE and ARMSE in velocity. To evaluate the estimate accuracy of PECM and MNCM, the square root of normalized Frobenius norm (SRNFN) and averaged SRNFN (ASRNFN) are selected as error measures, which are defined as follows [13]: 

**==> picture [241 x 44] intentionally omitted <==**

where ∥ **D** ∥[2] = tr( **DD** _[T]_ ) and **P[ˆ]** _[s] k_ | _k_ −1[denotes the estimated PECM at the] _s_ th Monte Carlo run, and **P** _[s]_ o _,k_ | _k_ −1[represents the accurate PECM at the] _s_ th Monte Carlo run provided by the KFTCM. Similar to the SRNFN and ASRNFN in PECM, we can also write formula for the SRNFN and ASRNFN in MNCM. 

The RMSEs of position and velocity and the SRNFNs of PECM and MNCM from existing filters and the proposed filter are respectively shown in Figs. 1 and 2. It is seen from Fig. 1 that the proposed filter has smaller RMSEs than existing KFNCM and VBAKF-R, and the RMSEs 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

600 

**==> picture [85 x 32] intentionally omitted <==**

**==> picture [241 x 84] intentionally omitted <==**

Fig. 3. ARMSEs of the position and velocity when _N_ = 1 _,_ 2 _, . . . ,_ 20. 

**==> picture [245 x 155] intentionally omitted <==**

Fig. 4. ASRNFNs of the PECM and MNCM when _N_ = 1 _,_ 2 _, . . . ,_ 20. 

from the proposed filter are close to the RMSEs from KFTCM when _k >_ 600 s. The ARMSEs of position and velocity from the proposed filter are respectively reduced by 54 _._ 5% and 22 _._ 4% as compared with the existing VBAKF-R. We can see from Fig. 2 that the proposed filter has smaller SRNFNs than existing KFNCM and VBAKF-R. The ASRNFNs of PECM and MNCM from the proposed filter are respectively reduced by 18 _._ 7% and 60% as compared with existing VBAKF-R. Moreover, the implementation times of existing KFNCM, VBAKF-R, and the proposed filter in a single step run are respectively 2 _._ 5 × 10[−][5] s, 3 _._ 8 × 10[−][4] s, and 5 _._ 6 × 10[−][4] s. Thus, the proposed filter has better estimation accuracy but higher computational complexity than existing 

Figs. 3 and 4 show respectively the ARMSEs of position and velocity and the ASRNFNs of PECM and MNCM from the existing filters and the proposed filters when _N_ = 1 _,_ 2 _, . . . ,_ 20. It can be seen from Figs. 3 and 4 that the proposed filter has smaller ARMSEs and ASRNFNs than existing filters when _N_ ≥ 2, and the proposed filter converges when _N_ ≥ 6. Thus, the proposed filter exhibits satisfactory convergence speed with respect to the number of iterations. 

Fig. 5 shows the RMSEs of position and velocity from the existing filters and the proposed filters when _τ_ = 2 _,_ 3 _,_ 4 _,_ 5 _,_ 6. We can see from Fig. 5 that the proposed filter with the tuning parameter _τ_ = 2 _,_ 3 _,_ 4 _,_ 5 _,_ 6 has essentially consistent estimation performance and higher estimation accuracy than existing filters. 

Fig. 6 shows the RMSEs of position and velocity from the existing filters and the proposed filters when _ρ_ = 0 _._ 9 _,_ 0 _._ 92 _,_ 0 _._ 94 _,_ 0 _._ 96 _,_ 0 _._ 98 _,_ 1 _._ 0. It can be seen from Fig. 6 that the proposed filter with 

**==> picture [196 x 128] intentionally omitted <==**

Fig. 5. RMSEs of the position and velocity when _τ_ = 2 _,_ 3 _,_ 4 _,_ 5 _,_ 6. 

**==> picture [196 x 129] intentionally omitted <==**

Fig. 6. RMSEs of the position and velocity when _ρ_ = 0 _._ 9 _,_ 0 _._ 92 _,_ 0 _._ 94 _,_ 0 _._ 96 _,_ 0 _._ 98 _,_ 1 _._ 0. 

**==> picture [192 x 124] intentionally omitted <==**

Fig. 7. ARMSEs of the position and velocity when parameters ( _α, β_ ) ∈ [0 _._ 1 _,_ 1000] × [0 _._ 1 _,_ 1000]. 

_ρ_ = 0 _._ 9 _,_ 0 _._ 92 _,_ 0 _._ 94 _,_ 0 _._ 96 _,_ 0 _._ 98 _,_ 1 _._ 0 has better estimation accuracy than existing filters, and the proposed filter with _ρ_ = 0 _._ 9 _,_ 0 _._ 92 _,_ 0 _._ 94 _,_ 0 _._ 96 _,_ 0 _._ 98 has essentially consistent estimation performance. Moreover, the proposed filter with _ρ_ = 1 _._ 0 has worse estimation accuracy than the proposed filter with _ρ_ = 0 _._ 9 _,_ 0 _._ 92 _,_ 0 _._ 94 _,_ 0 _._ 96 _,_ 0 _._ 98, which is because _ρ_ = 1 _._ 0 corresponds to stationary MNCM so that the estimation performance degrades when the MNCM is slowly varying. 

Figs. 7 and 8 show the ARMSEs of position and velocity from the proposed filter when parameters ( _α, β_ ) ∈ [0 _._ 1 _,_ 1000] × [0 _._ 1 _,_ 1000] and ( _α, β_ ) ∈ [1 _,_ 1000] × [1 _,_ 1000], respectively. It is seen from Figs. 7 and 8 that the proposed filter exhibits good estimation performance only when parameters ( _α, β_ ) ∈ [1 _,_ 1000] × [1 _,_ 1000]. Thus, the proposed filter may fail when the nominal PNCM and MNCM are too far away 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 63, NO. 2, FEBRUARY 2018 

601 

**==> picture [193 x 124] intentionally omitted <==**

Fig. 8. ARMSEs of the position and velocity when parameters ( _α, β_ ) ∈ [1 _,_ 1000] × [1 _,_ 1000]. 

**==> picture [210 x 124] intentionally omitted <==**

Fig. 9. RMSEs of the position and velocity when the nominal PNCM **˜Q** _k_ and the true PNCM **Q** _k_ are identical. 

TABLE I 

STEADY-STATE ARMSES OVER THE LAST 100S FROM THE EXISTING FILTERS AND THE PROPOSED FILTER 

|Filters|ARMSEpos (m)|ARMSEvel (m/s)|
|---|---|---|
|KFNCM<br>KFTCM<br>VBAKF-R<br>The proposed flter|4.63<br>2.77<br>2.92<br>2.81|4.58<br>3.38<br>3.59<br>3.45|



from the true PNCM and MNCM, which is induced by the fact that the VB approach can only guarantee local convergence so that the use of improper nominal PNCM and MNCM may result in error estimations even divergence. 

Fig. 9 and Table I show respectively the RMSEs and steady-state ARMSEs over the last 100 s of position and velocity from the existing filters and the proposed filter when the nominal PNCM **Q[˜]** _k_ and the true PNCM **Q** _k_ are identical. It is seen from Fig. 9 and Table I that the proposed filter has significantly smaller RMSEs and steady-state ARMSEs than the existing KFNCM and slightly smaller RMSEs and steady-state ARMSEs than the existing VBAKF-R, and the steady-state ARMSEs from the proposed filter are nearly identical to the steady-state ARMSEs from the KFTCM, which also indicates good performance of the proposed filter. 

## IV. CONCLUSION 

In this paper, the authors focused on solving the filtering problem of linear Gaussian state-space models with inaccurate PNCM and MNCM. A novel VBAKF with inaccurate PNCM and MNCM was 

proposed, where the state together with PECM and MNCM were inferred by choosing inverse Wishart priors. Simulation results illustrated that the proposed VBAKF has better robustness to resist the uncertainties of PNCM and MNCM as compared with existing filters, which is induced by the fact that the proposed filter can iteratively find better estimates of PECM and MNCM. 

## ACKNOWLEDGMENT 

The authors would like to thank X. Wang, at the Electrical Engineering Department, Columbia University for providing comments and suggestions on the revised version of the manuscript. 

## REFERENCES 

- [1] R. Mehra, “Approaches to adaptive filtering,” _IEEE Trans. Automat. Control_ , vol. 17, no. 5, pp. 693–698, Oct. 1972. 

- [2] A. H. Mohamed and K. P. Schwarz, “Adaptive Kalman filtering for INS/GPS,” _J. Geod._ , vol. 73, no. 4, pp. 193–203, May 1999. 

- [3] C. Hide, T. Moore, and M. Smith, “Adaptive Kalman filtering algorithms for integrating GPS and low cost INS,” in _Proc. Position Locat. Navig. Symp._ , Apr. 2004, pp. 227–233. 

- [4] M-J. Yu, “INS/GPS integration system using adaptive filter for estimating measurement noise variance,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 48, no. 2, pp. 1786–1792, Apr. 2012. 

- [5] A. P. Sage and G. W. Husa, “Adaptive filtering with unknown prior statistics,” in _Proc. Joint Autom. Control Conf._ , Boulder, CO, USA, 1969, pp. 760–769. 

- [6] X. Gao, D. You, and S. Katayama, “Seam tracking monitoring based on adaptive Kalman filter embedded Elman neural network during highpower fiber laser welding,” _IEEE Trans. Ind. Electron_ , vol. 59, no. 11, pp. 4315–4325, Nov. 2012. 

- [7] M. Karasalo and X. M. Hu, “An optimization approach to adaptive Kalman filtering,” _Automatica_ , vol. 47, no. 8, pp. 1785–1793, Aug. 2011. 

- [8] X. R. Li and Y. Bar-Shalom, “A recursive multiple model approach to noise identification,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 30, no. 3, pp. 671–684, Jul. 1994. 

- [9] S. S¨arkk¨a and A. Nummenmaa, “Recursive noise adaptive Kalman filtering by variational Bayesian approximations,” _IEEE Trans. Automat. Control_ , vol. 54, no. 3, pp. 596–600, Mar. 2009. 

- [10] S. S¨arkk¨a and J. Hartikainen, “Variational Bayesian adaptation of noise covariance in nonlinear Kalman filtering,” arXiv: 1302.0681v1, Feb. 2013. 

- [11] G. Agamennoni, J. I. Nieto, and E. M. Nebot, “Approximate inference in state-space models with heavy-tailed noise,” _IEEE Trans. Signal Process._ , vol. 60, no. 10, pp. 5024–5037, Oct. 2012. 

- [12] Y. L. Huang, Y. G. Zhang, N. Li, and J. Chambers, “A robust Gaussian approximate filter for nonlinear systems with heavy-tailed measurement noises,” in _Proc. IEEE Int. Conf. Acoust., Speech, Signal Process._ , Mar. 2016, pp. 4209–4213. 

- [13] T. Ardeshiri, E. Ozkan, U. Orguner, and F. Gustafsson, “Approximate Bayesian smoothing with unknown process and measurement noise covariances,” _IEEE Signal Process. Lett._ , vol. 22, no. 12, pp. 2450–2454, Dec. 2015. 

- [14] Y. L. Huang, Y. G. Zhang, N. Li, and J. Chambers, “A robust Gaussian approximate fixed-interval smoother for nonlinear systems with heavy-tailed process and measurement noises,” _IEEE Signal Process. Lett._ , vol. 23, no. 4, pp. 468–472, Apr. 2016. 

- [15] A. O’Hagan and J. J. Forster, _Kendall’s Advanced Theory of Statistics: Bayesian Inference_ . London, U.K.: Arnold, 2004. 

- [16] C. M. Bishop, _Pattern Recognition and Machine Learning._ Berlin, Germany: Springer, 2007. 

- [17] D. Tzikas, A. Likas, and N. Galatsanos, “The variational approximation for Bayesian inference,” _IEEE Signal Process. Mag._ , vol. 25, no. 6, pp. 131– 146, Nov. 2008. 

- [18] M. Zorzi, “Rational approximations of spectral densities based on the Alpha divergence,” _Math. Control Signals Syst._ , vol. 26, no. 2, pp. 259– 278, Jun. 2014. 

- [19] M. Zorzi, “Multivariate spectral estimation based on the concept of optimal prediction,” _IEEE Trans. Automat. Control_ , vol. 60, no. 6, pp. 1647–1652, Jun. 2015. 

- [20] M. Roth, E. Ozkan, and F. Gustafsson, “A Student’s filter for heavy-tailed[¨] process and measurement noise,” in _Proc. IEEE Int. Conf. Acoust., Speech, Signal Process._ , May 2013, pp. 5770–5774. 

