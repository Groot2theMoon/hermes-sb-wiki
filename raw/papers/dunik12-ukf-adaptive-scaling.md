---
title: "Unscented Kalman Filter: Aspects and Adaptive Setting of Scaling Parameter"
journal: "IEEE Trans. Automatic Control, 57(9), 2411-2416."
authors: ['Dunik, J.', 'Simandl, M.', 'Straka, O.']
year: 2012
source: paper
ingested: 2026-05-09
sha256: af744c28f28d0f500c4984fbfb6864f93242aafc4ce55e25b65d103f7f6acb0c
conversion: pymupdf4llm
---

# Cooperative Unscented Kalman Filter with Bank of Scaling Parameter Values 

J. Dun´ık, O. Straka 

Deparment of Cybernetics University of West Bohemia Univerzitn´ı 8, 306 14 Pilsen, Czech Republic E-mails: _{_ dunikj, straka30 _}_ @kky.zcu.cz 

## U. D. Hanebeck 

Institute for Anthropomatics and Robotics Karlsruhe Institute of Technology Adenauerring 2, 76131 Karlsruhe, Germany E-mail: uwe.hanebeck@kit.edu 

_**Abstract**_ **—This paper is devoted to the Bayesian state estimation of the nonlinear stochastic dynamic systems. The stress is laid on Gaussian unscented Kalman filter (UKF) and, in particular, on a setting of its scaling parameter, which significantly affects the UKF estimation performance. Compared to the standard UKF design, where one scaling parameter per a time instant is selected, the proposed cooperative UKF combines estimates of the set of UKFs each designed with different value of the scaling parameter. The cooperative UKF reformulates the UKF scaling parameter selection task as the multiple model approach, which allows to extract more information from the measurement to provide estimates of better quality as indicated by the numerical simulations. Keywords: Nonlinear filtering; Gaussian estimators; Bayesian relations.** 

## I. INTRODUCTION 

State estimation of discrete-time stochastic dynamic systems from noisy or incomplete measurements has been a subject of considerable research interest for the last decades. The topic plays an important role in various fields such as navigation, speech and image processing, fault detection, and adaptive or optimal control. 

Following the Bayesian approach, a general solution to the state estimation problem is given by the Bayesian recursive relations (BRRs) for computing the probability density functions (PDFs) of the state conditioned on the measurements. The conditional PDFs provide a full description of the immeasurable state. The relations are, however, analytically tractable for a limited set of models only for which the linearity is usually a common factor. This class of exact Bayesian estimators is represented, e.g., by the Kalman filter (KF). In other cases, an approximate solution to the BRRs has to be employed. These approximate filtering methods can be divided with respect to the validity of the estimates into global and local filters [1], [2]. 

_Global_ filters, such as the particle or the point-mass filter, provide estimates in the form of conditional PDFs without any assumption on the conditional distribution family. These global filters are capable of estimating the state of a strongly nonlinear or non-Gaussian system but usually at the cost of higher computational demands. As opposed to global filters, _local_ , or alternatively _Gaussian_ , filters (GF) provide computationally efficient estimates predominantly 

in the form of the conditional mean and covariance matrix[1] with potentially limited performance due to inherent underlying Gaussian assumption[2] . This paper focuses on a class of GFs that rely on the specification of a _scaling parameter_ . This class includes many modern widely-used derivativefree GFs, e.g., the unscented Kalman filter (UKF) with the scaling parameter _κ_ affecting the _σ_ -points spreading or divided-difference filter with the scaling parameter _h_ affecting the interval, where the differences are computed [3]–[7]. 

The considered scaling parameter _significantly_ affects the GF performance and its selection is a challenging task [6], [8]–[12]. In literature, various recommendations and algorithms for scaling parameter selection have been proposed. Unfortunately, they often result in contradictory scaling parameter setting, require some input from the filter user (or designer), and are designed for the GF filtering step only (i.e., for the measurement update). The scaling parameter can be selected according to 

## _• fixed_ schemes and 

## _• adaptive_ schemes. 

Fixed schemes include “standard” scaling parameter settings based on the state dimension [3], [13], which is constant for all time instants, or the off-line tuned scaling parameter, which leads to a (time-varying) sequence of the scaling parameter setting found prior to the estimation experiment by a numerical analysis [8], [9], [11]. Although, such setting does not affect GF computational complexity, it cannot reflect the GF actual working conditions. On the other hand, adaptive schemes set scaling parameter online with respect to the current working conditions, but at the cost of higher computational complexity [6], [12]. Moreover, as adaptive schemes are based on a numerical solution, the user is required to chose a criterion and a scaling parameter range for which the optimization is performed. Often, the numerical optimization evaluates the criterion (and typically also a part of the GF filtering step) for multiple choices of the scaling parameter and 

> 1The first two moments usually do not represent a full description of the immeasurable state. 

> 2This assumption is not always realistic especially for strongly nonlinear systems. 

then, select the most suitable one only. All intermediate results are forgotten. Thus, this concept of scaling parameter adaptation can be seen as _competitive_ winner-takes-all scheme. 

The goal of this paper is to propose a conceptually novel _cooperative_ approach to on-line determination of the GF scaling parameter. Its basic idea lies in combination of multiple estimates provided by a set of the GFs configured for the same estimation task, but differing in the scaling parameter setting. The cooperative approach adopts the methodology of the generalized pseudo-Bayesian estimator design with the stress on a minimization of the user interaction. 

The paper is organized as follows. In Section II, system description and a brief introduction to the Bayesian state estimation is presented. Section III focuses on introduction of the UKF, standard scaling parameter selection, and motivational example. Then, in Section IV, the concept of the cooperative scaling parameter selection is proposed and the cooperative UKF is designed. Sections V and VI provide numerical simulations and concluding remarks, respectively. 

## II. SYSTEM DESCRIPTION AND STATE ESTIMATION 

A discrete-time nonlinear stochastic dynamic system, described by the state-space model 

**==> picture [182 x 26] intentionally omitted <==**

is considered for _k_ = 0 _,_ 1 _,_ 2 _, . . . , T_ , where the vectors **x** _k ∈_ R _[n][x]_ and **z** _k ∈_ R _[n][z]_ represent the state of the system and the measurement at time instant _k_ , respectively. The state and measurement functions **f** _k_ : R _[n][x] →_ R _[n][x]_ and **h** _k_ : R _[n][x] →_ R _[n][z]_ are supposed to be known. The state noise **w** _k ∈_ R _[n][x]_ , the measurement noise **v** _k ∈_ R _[n][z]_ , and the initial state **x** 0 _∈_ R _[n][x]_ are supposed to be independent of each other. 

The noises and the initial state are assumed to be normally distributed, i.e., 

**==> picture [184 x 26] intentionally omitted <==**

**==> picture [182 x 11] intentionally omitted <==**

where **0** _nx×_ 1 is the zero matrix of indicated dimension and the notation _N{_ **x** ; ¯ **x** _,_ **P** _}_ stands for the Gaussian PDF of a random variable **x** with the mean **x** ¯ and covariance matrix **P** . The first two moments of the random variables (3)–(5) are supposed to be known. 

- _A. Bayesian Approach to State Estimation_ 

The BRRs are given by [14] 

**==> picture [231 x 51] intentionally omitted <==**

where _p_ ( **x** _k|_ **z** _[k][−]_[1] ) is the one-step _predictive_ PDF computed by the Chapman-Kolmogorov equation (6) and _p_ ( **x** _k|_ **z** _[k]_ ) is the _filtering_ PDF computed by the Bayes’ rule (7). The PDFs _p_ ( **x** _k|_ **x** _k−_ 1) and _p_ ( **z** _k|_ **x** _k_ ) are the state transition PDF obtained from (1) and the measurement PDF obtained from (2), respectively. The PDF _p_ ( **z** _k|_ **z** _[k][−]_[1] ) = � _p_ ( **x** _k|_ **z** _[k][−]_[1] ) _p_ ( **z** _k|_ **x** _k_ ) _d_ **x** _k_ is the one-step predictive PDF of the measurement. The symbol **z** _[k]_ represents the set of all measurements up to the time instant _k_ , i.e., **z** _[k]_ = [ **z** 0 _,_ **z** 1 _, . . ._ **z** _k_ ]. The estimate of the state is given by the filtering and the predictive PDFs. The recursion (6), (7) can be started from the initial PDF _p_ ( **x** 0 _|_ **z**[0] ) stemming from _p_ ( **x** 0). 

## _B. Gaussian Filter Design_ 

Considering the system description (1)–(5), the BRRs are not exactly solvable. GFs assume the predictive conditional joint PDF [13], i.e., 

**==> picture [242 x 30] intentionally omitted <==**

to be Gaussian, which allows analytical (but inherently _approximate_ ) solution to the BRRs leading to the following recursive GF estimation algorithm[3] : 

**Step 1** : Set the time instant _k_ = 0 and define an initial condition _p_ ( **x** 0 _|_ **z**[0] ) = _N{_ **x** 0; ˆ **x** 0 _|_ 0 _,_ **P** _[xx]_ 0 _|_ 0 _[}]_[.] **Step 2** : The predictive mean and covariance matrix 

**==> picture [224 x 64] intentionally omitted <==**

are assumed to form the Gaussian PDF _p_ ( **x** _k_ +1 _|_ **z** _[k]_ ) ≜ _N{_ **x** _k_ ; ˆ **x** _k_ +1 _|k,_ **P** _[xx] k_ +1 _|k[}]_[.] **Step 3** : The moments of the filtering estimate _p_ ( **x** _k_ +1 _|_ **z** _[k]_[+1] ) ≜ _N{_ **x** _k_ +1; ˆ **x** _k_ +1 _|k_ +1 _,_ **P** _[xx] k_ +1 _|k_ +1 _[}]_[are] ˆ ˆ ˆ **x** _k_ +1 _|k_ +1 = **x** _k_ +1 _|k_ + **K** _k_ +1( **z** _k_ +1 _−_ **z** _k_ +1 _|k_ ) _,_ (11) **P** _[xx] k_ +1 _|k_ +1[=] **[ P]** _[xx] k_ +1 _|k[−]_ **[K]** _[k]_[+1] **[P]** _[zz] k_ +1 _|k_ **[K]** _k[T]_ +1 _[,]_ (12) 

**==> picture [215 x 14] intentionally omitted <==**

**==> picture [231 x 34] intentionally omitted <==**

**==> picture [252 x 80] intentionally omitted <==**

> 3All GFs are linear algorithms with respect to the actual measurement and have the same structure as the KF. However, contrary to the KF, the GF estimate is “only” assumed to be Gaussian. 

Let _k_ = _k_ + 1. The algorithm then continues to **Step 2** . 

## _B. Scaling Parameter Setting and Adaptation_ 

## III. SCALING PARAMETER IN UNSCENTED KALMAN FILTER AND GOAL OF THE PAPER 

Evaluation of the _Gaussian_ PDF weighted integrals (9), (10) and (13)–(15) is based on various linearization techniques or numerical integration rules [3]–[7], [15]–[17]. Except for a few special cases (e.g., linear or polynomial functions **f** _k_ and **h** _k_ in (1), (2)) their evaluation is approximate and, typically, the integration result significantly depends on a scaling parameter selection. 

The setting and impact of the scaling parameter is discussed and illustrated using the UKF, which solves the integrals using the _unscented transform_ (UT) [3], [10]. Note, however, that analogous conclusions can be drawn for any GF of the considered class. 

## _A. Unscented Transform_ 

The UT computes the predictive moments as weighted sample means of nonlinearly transformed sets of deterministically chosen points (so called _σ_ -points). In particular, the UT based _approximate_ measurement predictive moments (13)–(15) are computed[4] as 

**==> picture [246 x 130] intentionally omitted <==**

where the transformed _σ_ -points _{Zk[i]_ +1 _|k[}] i_[2] =0 _[n][x]_[are] 

**==> picture [128 x 14] intentionally omitted <==**

and the _σ_ -points _{Xk[i]_ +1 _|k[}] i_[2] =0 _[n][x]_[and][respective][weights] _{Wk[i]_ +1 _|k[}]_[2] _i_ =0 _[n][x]_[are] 

**==> picture [234 x 36] intentionally omitted <==**

In (16)–(20), **1** _a×b_ and **0** _a×b_ represent matrices of ones and zeros of indicated dimension, respectively. **S** _[xx] k_ +1 _|k_ is a factor of the covariance matrix **P** _[xx] k_ +1 _|k_[satisfying] **P** _[xx] k_ +1 _|k_[=] **[S]** _[xx] k_ +1 _|k_[(] **[S]** _[xx] k_ +1 _|k_[)] _[T]_[ ,] _[b]_[=][2] _[n][x]_[+ 1][is][the][number] of _σ_ -points, _c_ = _[√] nx_ + _κ_ , and _κ ∈_ R[+] is the _scaling parameter_ typically determined by the user. 

In literature, various recommendations can be found. The recommendations result in either fixed time-invariant or adaptive time-variant scaling parameter _κ_ . For fixed parameters, two recommendations can be found, i.e., _κ_ = 3 _− nx_ (if _nx ≤_ 3) minimizing the error of the fourth order term of the Taylor expansion of (16) [3] and _κ_ = 0 leading to the cubature integration rule and the cubature KF [13]. Time-varying scaling parameters can be found either offline [8], [9], [11] or on-line [6], [12]. The on-line identified parameter can be computed, for example, to maximize the likelihood function[5] 

**==> picture [217 x 17] intentionally omitted <==**

which results in the scaling parameter value typically different from the fixed choices. With this short review, it is possible to see that there are multiple (and contradictory) choices of the scaling parameter. Each recommendation is, moreover, related to different criteria used for parameter selection. In addition, the criteria are only _superficially_ related to the quantities, which are usually used for the filter performance evaluation (e.g., in terms of estimate accuracy and consistency). 

## _C. Motivating Example_ 

The performance of the UKF with three choices of the scaling parameter, namely two fixed values _κ_ = 2, _κ_ = 0, and one adaptive setting of _κk_ according to (21), is illustrated using the univariate non-stationary model [18] 

**==> picture [228 x 32] intentionally omitted <==**

where _k_ = 0 _,_ 1 _, . . . , T, T_ = 40, _Q_ = 2, _R_ = 0 _._ 1, and _p_ ( _x_ 0) = _N{x_ 0; _−_ 200 _,_ 1 _}_ . State estimation of the considered model state is a challenging task for any GF, including the UKF, especially if the true state is close to zero. In that region of the state space, the UKF may provide “inaccurate” estimates for a shorter or longer period of time, depending on the selected parameter _κ_ . 

In Figure 1, the filtering estimate error 

**==> picture [155 x 12] intentionally omitted <==**

and the filtering standard deviation (STD) 

**==> picture [150 x 19] intentionally omitted <==**

are plotted for _one_ realization for three UKFs with two fixed scaling parameters and one adaptively set parameter. The figure illustrates enormous influence of the scaling parameter of the UKF performance and also a tendency of the UKF to provide _inconsistent_ estimates in this case independently of the scaling parameter selection. 

One of the possible _explanations_ of the inconsistent behavior of the UKFs is that the considered state-of-the-art 

> 5Other criteria can be found in [6]. 

> 4State predictive moments (9), (10) are computed analogously. 

**==> picture [240 x 254] intentionally omitted <==**

**----- Start of picture text -----**<br>
2<br>UKF( =0)<br>0 Err<br>+/-STD<br>-2<br>-4<br>-6<br>0 5 10 15 20 25 30 35 40<br>10<br>UKF( =2)<br>Err<br>+/-STD<br>0<br>-10<br>0 5 10 15 20 25 30 35 40<br>10<br>UKF( MLk )<br>5<br>Err<br>0 +/-STD<br>-5<br>-10<br>0 5 10 15 20 25 30 35 40<br>**----- End of picture text -----**<br>


Figure 1. UKF performance depending on the scaling parameter setting. 

scaling parameter selection techniques utilize _just_ one (in some sense best) value of the scaling parameter at one time instant (either selected prior or adaptively during the the filter run). Thus, the filters are able to exploit a portion of the available information from the measurement. Moreover, as the adaptive strategies, such as in (21), are based on numerical optimization, there are many evaluations of the optimization criterion and the measurement prediction moments available, but only the one selected is used (and the remaining ones are simply disregarded). 

## _D. Goal of the Paper_ 

The goal of this paper is to propose a _cooperative_ scaling parameter determination technique for the UKF that combines multiple UKF estimates differing by the scaling parameter choice. Such combination allows to exploit more information from the available measurement at each time instant. The cooperative determination is inspired by the recent techniques for UKF consistency monitoring [18], [19] and a theory of the generalized pseudo-Bayesian estimation [20], and, thus, benefits from a well-developed theoretical background. 

## IV. COOPERATIVE SCALING PARAMETER DETERMINATION 

The UKF with cooperative scaling parameter determination is based on the idea of combination of a set of UKF estimates, where each UKF is configured to perform the _same_ estimation task, but uses a different scaling parameter. As a consequence, each filter provide an _unique_ , but inherently _sub-optimal_ , estimate that extracts just a portion of information from the conditioning data. Analysis and combination of such estimates result in such a scaling 

parameter selection, which may result in a higher quality state estimate in terms of accuracy and consistency. 

## _A. Concept Illustration_ 

The concept of the cooperative scaling parameter determination is introduced using the UKF (9)–(15), (16)–(20) with the initial condition 

**==> picture [182 x 13] intentionally omitted <==**

and a set of allowed scaling parameters _K_ = _{κ_[(] _[i]_[)] _}[n] i_ =1 _[κ]_[.] The _prediction_ (time-update) step of the UKF with cooperative scaling parameter determination (CUKF) is based on evaluation of _nκ_ UKF prediction steps, each with different scaling parameter _κ_[(] _k[i]_ +1[)] _|k[∈][K]_[used in evaluation] of (9), (10). This leads to a set of predictive state estimates, in the form of the filtering mean and covariance matrix as 

**==> picture [173 x 21] intentionally omitted <==**

where the notation _Nk_[(] +1 _[i]_[)] _|k_[=] _[ N{]_ **[x]** _[k]_[+1][; ˆ] **[x]**[(] _k[i]_ +1[)] _|k[,]_ **[ P]** _[xx,] k_ +1[(] _|[i] k_[)] _[}]_[is] used for convenience and the predictive moments are 

**==> picture [178 x 35] intentionally omitted <==**

The _filtering_ (measurement update) step of the CUKF based on evaluation of _n_[2] _κ_[UKF][filtering][steps,][each] with different predictive PDF (27) and scaling parameter _κ_[(] _[j]_[)][used][in][(11)–(15),][leads][to][the][set][of][the] _k_ +1 _|k_ +1 _[∈][K]_ filtering estimates 

**==> picture [191 x 21] intentionally omitted <==**

where the filtering moments 

**==> picture [216 x 35] intentionally omitted <==**

depends on _both_ scaling parameters _κ_[(] _k[i]_ +1[)] _|k_[,] _[κ]_[(] _k[j]_ +1[)] _|k_ +1[.] Standard approaches to scaling parameter selection evaluate all the predictive and filtering state estimates (27), (30), and select just one estimate _Nk_[(] +1 _[i,j]_[)] _|k_ +1[according][to] some criterion, e.g., according to (21) [6]. It means, that all remaining estimates and the contained information is not exploited and a significant part of the calculations is wasted. 

## _B. Formulation in Generalized Pseudo-Bayesian Estimator Design Framework_ 

The proposed CUKF aims at utilization of _all_ information the various UKFs estimates can capture due to different scaling parameter selection. The main question is how to fuse the estimates together to _exploit_ maximum of available information being captured in (30)–(32). The chosen approach is based on a reformulation of the considered problem in the multiple model (MM) approach, namely using 

the approximate _first order generalized pseudo-Bayesian_ (GPB1) estimator design framework [20]. 

Because of the Bayesian approach to the GF design, the set of the UKFs can be, broadly speaking, thought of as a set of _KF_ each designed for differently _linearized_[6] model _M_ given by (1), (2), further denoted as 

_L_ ≜ _{L_[(] _[i,j]_[)] ( _κ_[(] _k[i]_ +1[)] _|k[, κ]_[(] _k[j]_ +1[)] _|k_ +1[)] _[}] i[n]_ =1 _[κ][,n] ,j[κ]_ =1 _[,]_ (33) where the linearized model _L_[(] _[i,j]_[)] = _L_[(] _[i,j]_[)] ( _κ_[(] _k[i]_ +1[)] _|k[, κ] k_[(] _[j]_ +1[)] _|k_ +1[)] depends on the nonlinear model _M_ and scaling parameters _κ_[(] _k[i]_ +1[)] _|k_[,] _[κ]_[(] _k[j]_ +1[)] _|k_ +1[used] by the UT in prediction and filtering step, respectively. Such interpretation of the set of the UKFs allows to create a set of _n_[2] _κ_[hypotheses] _[H]_[(] _[i,j]_[)] _[,][ ∀][i, j,]_[that][the][considered] linearized model _L_[(] _[i,j]_[)] results in the approximate Gaussian posterior PDF _Nk_[(] +1 _[i,j]_[)] _|k_ +1[,][which][is][(in][some][sense)][closest] to the true (but unknown) posterior _p_ ( **x** _k|_ **z** _[k]_ ). The PDF _Nk_[(] +1 _[i,j]_[)] _|k_ +1[is,][therefore,][conditioned][by][the][model] _[L]_[(] _[i,j]_[)][,] thus, by _κ_[(] _k[i]_ +1[)] _|k_[,] _[κ]_[(] _k[j]_ +1[)] _|k_ +1[.] 

Having the set of models, it is necessary to determine their weights. Following the GPB1, the predictive weights can be equal as we do not have any prior knowledge, i.e., 

**==> picture [156 x 17] intentionally omitted <==**

Then, the weight of the model _L_[(] _[i,j]_[)] and of the filtering estimate _Nk_[(] +1 _[i,j]_[)] _|k_ +1[, w.r.t. the last measurement] **[ z]** _[k]_[+1][, reads] 

**==> picture [232 x 17] intentionally omitted <==**

where _ck_ =[�] _[n] i_ =1 _[κ]_ � _nj_ =1 _κ[α] k_[(] _[i] |_[)] _k−_ 1 _[N{]_ **[z]** _[k]_[; ˆ] **[z]**[(] _k[i,j] |k−_[)] 1 _[,]_ **[ P]** _[zz,] k|k_[(] _−[i,j]_ 1[)] _[}]_[ is] the normalization and the measurement predictive moments are computed within the filtering step. Having the filtering PDFs (30) and the weights (35), the combined state estimate, which take into account UKFs with all admissible combinations of _κ_[(] _[i]_[)] _[κ]_[(] _[j]_[)][is] _k_ +1 _|k_[,] _k_ +1 _|k_ +1[,] [20] 

**==> picture [226 x 30] intentionally omitted <==**

with mean 

**==> picture [200 x 30] intentionally omitted <==**

and covariance matrix 

**==> picture [237 x 52] intentionally omitted <==**

To keep the computational complexity constant _∀k_ , it is necessary to approximate the combined PDF (36) with the Gaussian PDF, such as 

**==> picture [231 x 26] intentionally omitted <==**

which is then used as an initial PDF for the CUKF prediction (27). Note that the Gaussian approximation (39) is optimal according to the Kullback-Leibler distance. 

## _C. CUKF Algorithm Illustration_ 

The CUKF algorithm is illustrated by the diagram in Figure 2. 

## _D. Notes and Extensions_ 

_1) User Defined Parameter and Computational Complexity:_ The only input required from the user, is related to the specification of the allowed scaling parameter set _K_ . The cardinality of the set is driven by the available computational power. In particular, the CUKF evaluates _nκ_ prediction and _n_[2] _κ_[filtering][steps][of][the][UKF][plus] _[n]_[2] _κ_ likelihood functions. 

Regarding the particular values of the set and assuming an ordered set _K_ , i.e., _κ_[(1)] _< κ_[(2)] _< . . . < κ_[(] _[n][κ]_[)] , the lower bound can be _κ_ 0 = 0, as for this value the covariance matrix of the transformed random variable is guaranteed to be positive definite. The upper bound _κ_[(] _[n][κ]_[)] can be determined so that the random variable **x** _k_ lies with a required probability _P[∗]_ within a hyper-ellipsoid determined by the _σ_ -points. The upper bound, them, satisfies the condition [6], [21] 

**==> picture [220 x 29] intentionally omitted <==**

where Γ( _·_ ) is the Gamma function. The closed-form solution to (40) for _κ_[(] _[n][κ]_[)] exists for some state dimensions _nx_ only, for other cases a numerical solution can be used instead. 

_2) Comparison with Standard Competitive Adaptations and Criteria:_ The standard on-line “competitive” scaling parameter adaptation techniques for the UKF (or derivativefree filters in general) [6], [8], [11] select the scaling parameter to minimize/maximize some criterion, e.g., (21), which is only _loosely_ (or indirectly) related to the state estimate accuracy or consistency. This means, that the selected scaling parameter need not necessarily result in the most accurate estimate. On the other hand, the multi-model based interpretation used in the CUKF design allows to interpret the resulting estimates in the Bayesian context [20]. The resulting estimate is, thus, a weighted mixture of all partial estimates based on all allowed scaling parameters. 

_3) Information Extraction:_ Each UKF can be viewed as a KF designed for a linearized model, i.e., as a sub-optimal filter with some (unique) gain parametrized by the scaling parameter. As such, each filter is able to extract a portion of information about the desired state from the measurement. By the combination of the sub-optimal estimates, thus, it could be possible to extract much more information about the true state. An analysis and comparison of in literature available combinations of the two GF estimates based on different linearization can be found in [22]. 

> 6The UT can be interpreted as a statistical (linear) regression [2], [16]. 

**==> picture [440 x 157] intentionally omitted <==**

**----- Start of picture text -----**<br>
p ( xk|z [k] )<br>p ( xk +1 |z [k] ;  κ [(1)] k +1 |k [)] · · · p ( xk +1 |z [k] ;  κ [(] k [n] +1 [)] |k [)]<br>p ( xk +1 |z [k] [+1] ; p ( xk +1 |z [k] [+1] ; p ( xk +1 |z [k] [+1] ; p ( xk +1 |z [k] [+1] ;<br>· · · · · ·<br>κ [(1)] κ [(1)] κ [(] [n] [)] κ [(] [n] [)]<br>k +1 |k [, κ] [(1)] k +1 |k +1 [)] k +1 |k [, κ] [(] k [n] +1 [)] |k +1 [)] k +1 |k [, κ] [(1)] k +1 |k +1 [)] k +1 |k [, κ] [(] k [n] +1 [)] |k +1 [)]<br>αk [(1] +1 [,n] [)] |k +1 αk [(] [n,] +1 [1)] |k +1<br>α [(1] [,] [1)] α [(] [n,n] [)]<br>k +1 |k +1 k +1 |k +1<br>p [C] [,][N] ( xk +1 |z [k] [+1] )<br>**----- End of picture text -----**<br>


Figure 2. CUKF information flow. 

_4) Adaptation in Smoothing:_ As the CUKF is based on the GPB1 framework, the cooperative scaling parameter adaptation concept can be straightforwardly extended to smoothing. 

_5) Cooperative Approach in GF Performance Monitoring:_ In [18], [19], consistency (or integrity) of the filter output was monitored by statistical testing of estimate properties of the set of filters configured for the same estimation task, but differing in the scaling parameter. In these tests, the particular local filters were interpreted also as the set of KFs designed for a set of differently linearized models and, roughly saying, the filter output was considered to be consistent if all KFs provided “similar” results. If not, the user was notified and such estimates were treated with care. 

_6) Extensions:_ The CUKF should be still understood as an initial concept with some open questions remaining. For example, utilization of other estimate fusion techniques such as the second-order generalized pseudo-Bayesian estimator design should be treated. Also, the focus should be laid on the selection of the initial (possibly non-equal) weights (34). 

## V. NUMERICAL ILLUSTRATION 

Let the system definition from the motivational example (22), (23) be recalled and the following evaluation criteria for the _M_ = 10[3] Monte-Carlo simulations be 

- Root mean square error (RMSE) of the filtering estimate 

**==> picture [177 x 37] intentionally omitted <==**

- Averaged standard deviation (ASTD) of the filtering estimate 

**==> picture [172 x 37] intentionally omitted <==**

˜ ˆ where _xk|k,m_ = _xk,m −xk|k,m_ is the estimate error at _m_ -th MC simulation with _xk,m_ being the true state, _x_ ˆ _k|k,m_ its 

Table I 

RMSE OF UKFS ESTIMATE. 

||UKFfx(0)|UKFfx(2)|UKFML|**CUKF**|
|---|---|---|---|---|
|RMSE(_K_0:4)|12.4|6.2|5.2|2.8|
|RMSE(_K_0:20)|||3.4|1.9|



estimate, and _Pk|k,m_ the respective variance at _m_ -th MC simulation. 

Four implementations of the UKF are considered, namely 

- UKF with fixed _κ_ = 0, denoted as _UKFfix(0)_ , (algorithm also known as the cubature KF [13]), 

- UKF with fixed _κ_ = 2, denoted as _UKFfix(2)_ , (according to [3]), 

- UKF with adaptive _κk_ computed according to (21), denoted as _UKFML_ , [6], 

- _proposed_ UKF with the cooperative scaling parameter adaptation, denoted as _CUKF_ . 

The UKFs with adaptation are designed for two sets _K_ 0:4 = _{_ 0 _,_ 1 _,_ 2 _,_ 3 _,_ 4 _}_ and _K_ 0:20 = _{_ 0 _,_ 1 _, . . . ,_ 20 _}_ . 

The results in the form of the averaged RMSE over all time instants 

**==> picture [180 x 30] intentionally omitted <==**

are given in Table I, where the UKFs with adaptive selection of _κ_ are evaluated for both sets _K_ 0:4 and _K_ 0:20. It can be seen, that the impact of the scaling parameter selection is significant and the proposed cooperative CUKF _outperforms_ not only the UKFs with fixed parameters but also the standard competitive UKFML. Also, the UKFs with scaling parameter adaptation improve their accuracy with increasing cardinality of _K_ . 

The RMSE assesses the quality of the estimated mean. The GF, however, provides also the conditional variance (or the standard deviation), which should be consistent with the state estimate error. To compare consistency of the state estimates, the criteria (41), (42) are plotted in Figure 3 (the UKFs with adaptive settings are plotted for _K_ 0:20). It can 

**==> picture [489 x 245] intentionally omitted <==**

**----- Start of picture text -----**<br>
6 3<br>UKFfix(0) - RMSE UKFML - RMSE<br>UKFfix(0) - ASTD UKFML - ASTD<br>5 UKFfix(2) - RMSE 2.5 CUKF - RMSE<br>UKFfix(2) - ASTD CUKF - ASTD<br>4 2<br>3 1.5<br>2 1<br>1 0.5<br>0 0<br>0 10 20 30 40 0 10 20 30 40<br>k k<br>, ASTD , ASTD<br>k k<br>RMSE RMSE<br>**----- End of picture text -----**<br>


Figure 3. RMSE and ASTD time behavior of UKFs estimates. 

be seen that the proposed CUKF provides not only the most accurate but also almost consistent estimates. On the other hand, the UKFs with fixed scaling parameters provide very optimistic estimates. This may be a problem especially in safety-critical scenarios [18]. 

## VI. CONCLUDING REMARKS 

The paper dealt with the state estimation of the nonlinear stochastic dynamic systems by the Gaussian unscented Kalman filter. The stress was laid on the setting of the scaling parameter, which is typically left on the user although it significantly affects the estimation performance. Contrary to the standard scaling parameter selection strategies choosing one particular parameter value according to a criterion, the proposed _cooperative unscented Kalman filter_ fuses a set of estimates provided by the set of the unscented Kalman filters, which are all configured for the same estimation task, but with _different_ scaling parameter value. The estimate fusion is based in the well-developed multiple-model approach, which requires minimal user interaction and offers interpretation of the results in the Bayesian context. The improved performance of the cooperative unscented Kalman filter in terms of accuracy and consistency was illustrated in a numerical example. 

## ACKNOWLEDGMENT 

This work was supported by the Czech Science Foundation (GACR) under grant GA 20-06054J (J. Dun´ık, O. Straka) and by the German Research Foundation (DFG) under grant HA 3789/20-1 (U. D. Hanebeck). 

## REFERENCES 

- [1] H. W. Sorenson, “On the development of practical nonlinear filters,” _Information Sciences_ , vol. 7, pp. 230–270, 1974. 

- [2] M. Simandl and J. Dun´ık, “Derivative-free estimation methods: New[ˇ] results and performance analysis,” _Automatica_ , vol. 45, no. 7, pp. 1749–1757, 2009. 

- [3] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _IEEE Proceedings_ , vol. 92, no. 3, pp. 401–421, 2004. 

- [4] M. Nørgaard, N. K. Poulsen, and O. Ravn, “New developments in state estimation for nonlinear systems,” _Automatica_ , vol. 36, no. 11, pp. 1627–1638, 2000. 

- [5] J. Steinbring and U. Hanebeck, “S2KF: The smart sampling Kalman filter,” in _Proceedings of the 16th International Conference on Inference Fusion_ , Istanbul, Turkey, July 2013. 

- [6] O. Straka, J. Dun´ık, and M. Simandl,[ˇ] “Unscented Kalman filter with advanced adaptation of scaling parameter,” _Automatica_ , vol. 50, no. 10, pp. 2657–2664, 2014. 

- [7] J. Steinbring and U. D. Hanebeck, “LRKF revisited: The smart sampling Kalman filter (S[2] KF),” _Journal of Advances in Information Fusion_ , vol. 9, no. 2, pp. 106–123, 2014. 

- [8] A. Sakai and Y. Kuroda, “Discriminatively trained unscented Kalman filter for mobile robot localization,” _Journal of Advanced Research in Mechanical Engineering_ , vol. 1, no. 3, pp. 153–161, 2010. 

- [9] R. Turner and C. E. Rasmussen, “Model based learning of sigma points in unscented Kalman filter,” _Neurocomputing_ , vol. 80, pp. 47–53, 2012. 

- [10] J. Dun´ık, M. Simandl, and O. Straka, “Unscented Kalman filter: As-[ˇ] pects and adaptive setting of scaling parameter,” _IEEE Transactions on Automatic Control_ , vol. 57, no. 9, pp. 2411–2416, 2012. 

- [11] S. L.A. and da Cruz J.J., “Adaptively tuning the scaling parameter of the unscented Kalman filter,” in _Proceedings of the 11th Portuguese Conference on Automatic Control_ , Porto, Portugal, Jul. 2014. 

- [12] Y. Nie and T. Zhang, “Scaling parameters selection principle for the scaled unscented Kalman filter,” _Journal of Systems Engineering and Electronics_ , vol. 29, no. 3, pp. 601–610, 2018. 

- [13] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Trans. on Automatic Control_ , vol. 54, no. 6, pp. 1254–1269, 2009. 

- [14] B. Ristic, S. Arulampalam, and N. Gordon, _Beyond the Kalman Filter: Particle Filters for Tracking Applications_ . Artech House, 2004. 

- [15] B. D. O. Anderson and J. B. Moore, _Optimal Filtering_ . Prentice Hall, New Jersey, 1979. 

- [16] T. Lefebvre, H. Bruyninckx, and J. De Schutter, “Comment on ”A new method for the nonlinear transformation of means and covariances in filters and estimators”,” _IEEE Transactions on Automatic Control_ , vol. 47, no. 8, pp. 1406–1409, 2002. 

- [17] J. Dun´ık, O. Straka, and M. Simandl,[ˇ] “Stochastic integration filter,” _IEEE Transactions on Automatic Control_ , vol. 58, no. 6, pp. 1561– 1566, 2013. 

- [18] J. Dun´ık and O. Straka, “State estimate consistency monitoring in Gaussian filtering framework,” _Signal Processing_ , no. 148, pp. 145– 156, 2018. 

- [19] J. Dun´ık, O. Straka, and E. Blasch, “Solution separation unscented kalman filter,” in _Proceedings of the 22nd International Conference on Information Fusion_ , Ottawa, Canada, Jul. 2019. 

- [20] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with Applications to Tracking and Navigation: Theory Algorithms and Software_ . John Wiley & Sons, 2001. 

- [21] O. Straka, J. Dunik, and M. Simandl, “Unscented Kalman filter with controlled adaptation,” in _Proceedings of 16th IFAC Symposium on System Identification (SYSID)_ , vol. 16, no. 1, 2012, pp. 906–911. 

- [22] J. Dun´ık, O. Straka, J. Ajgl, and E. Blasch, “From competitive to cooperative filter design,” in _Proceedings of the 20th International Conference on Information Fusion_ , Xi’an, China, Jul. 2017. 

