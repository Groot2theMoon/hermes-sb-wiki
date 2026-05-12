---
title: "Adaptive Adjustment of Noise Covariance in Kalman Filter for Dynamic State Estimation"
arxiv: "1702.00884"
authors: ["Shahrokh Akhlaghi", "Ning Zhou", "Zhenyu Huang"]
year: 2017
source: paper
ingested: 2026-05-12
sha256: 38c1bbf8886e1cf171a5b6721cec3be15edd0a202b7ddf3a099169d64a1e02e2
conversion: pymupdf4llm
---

## Adaptive Adjustment of Noise Covariance in Kalman Filter for Dynamic State Estimation 

Shahrokh Akhlaghi, _Student Member, IEEE_ Ning Zhou _, Senior Member, IEEE_ Electrical and Computer Engineering Department, Binghamton University, State University of New York, Binghamton, NY 13902, USA 

Zhenyu Huang, _Senior Member, IEEE_ Pacific Northwest National Laboratory, Richland, WA 99352, USA zhenyu.huang@pnnl.gov 

{sakhlag1, ningzhou}@binghamton.edu 

_**Abstract**_ **—Accurate estimation of the dynamic states of a synchronous machine (e.g., rotor’s angle and speed) is essential in monitoring and controlling transient stability of a power system. It is well known that the covariance matrixes of process noise (** _**Q**_ **) and measurement noise (** _**R**_ **) have a significant impact on the Kalman filter’s performance in estimating dynamic states. The conventional** _**ad-hoc**_ **approaches for estimating the covariance matrixes are not adequate in achieving the best filtering performance. To address this problem, this paper proposes an adaptive filtering approach to adaptively estimate** _**Q**_ **and** _**R**_ **based on** _**innovation**_ **and** _**residual**_ **to improve the dynamic state estimation accuracy of the extended Kalman filter (EKF). It is shown through the simulation on the two-area model that the proposed estimation method is more robust against the initial errors in** _**Q**_ **and** _**R**_ **than the conventional method in estimating the dynamic states of a synchronous machine.** 

_**Index Terms**_ **— Kalman filter, dynamic state estimation (DSE),** _**innovation**_ **/** _**residual**_ **-based adaptive estimation, process noise scaling, measurement noise matching.** 

## I.  INTRODUCTION 

Timely and accurately estimating the dynamic states of a synchronous machine (e.g., rotor angle and rotor speed) is important for monitoring and controlling the transient stability of a power system over wide areas [1]. With the worldwide deployment of phasor measurement units (PMUs), many research efforts have been made to estimate the dynamic states and improve the estimation accuracy using PMU data [2]– [11], among which the Kalman filtering (KF) techniques play an essential role. For instance, Huang et al. [2] proposed an extended Kalman filtering (EKF) approach to estimate the dynamic states using PMU data. Ghahremani and Innocent [3] proposed the EKF with unknown inputs to simultaneously estimate dynamic states of a synchronous machine and unknown inputs. [4]-[7] proposed the unscented Kalman filtering to estimate power system dynamic states. Zhou et al. [8] proposed an ensemble Kalman filter approach to simultaneously estimate the dynamic states and parameters. Akhlaghi, Zhou and Huang [9]-[10] proposed an adaptive interpolation approach to mitigate the impact of non-linearity 

in dynamic state estimation (DSE). These studies have laid a solid ground for estimating the dynamic states of a power system and also revealed some needs for further studies. 

One important problem that needs to be addressed in using the KF is how to properly set up the covariance matrixes of process noise (i.e., _Q_ ) and measurement noise (i.e., _R_ ). Note that the performance of the KF is highly affected by _Q_ and _R_ [12]. Improper choice of _Q_ and _R_ may significantly degrade the KF’s performance and even make the filter diverge [13]. To determine _Q_ and _R_ , almost all the previous DSE studies used an ad-hoc procedure, in which _Q_ and _R_ are assumed to be constant during the estimation and are manually adjusted by trial-and-error approaches. Note that because the noise levels may change for different applications and users of DSE can have different backgrounds, it can be very challenging to use such an ad-hoc approach to properly set up _Q_ and _R_ . 

To address this challenge, this paper proposes an estimation approach to adaptively adjust _Q_ and _R_ at each step of the EKF to improve DSE accuracy. An _innovation_ -based method is used to adaptively adjust _Q_ . A _residual_ -based method is used to adaptively adjust the _R_ . A simple example is used to evaluate the impact of _Q_ and _R_ on the performance of EKF. Then, performance of the proposed approach is evaluated using a two-area model [1]. 

The rest of paper is organized as follows: Section II reviews the dynamic model of a synchronous machine used for DSE. In Section III, the adaptive EKF approach is proposed. Sections IV and V present a case study and simulation results. Conclusions are drawn in Section VI. 

## II.  DYNAMIC STATE ESTIMATION MODEL 

This section gives a brief review on the dynamic model of a synchronous machine to be used by the EKF for DSE. The 4[th] order differential equations of a synchronous machine in a local _d-q_ reference frame is given by (1). (Readers may refer to [9]-[11] for more details): 

This paper is based on work sponsored by the U.S. Department of Energy (DOE) through its Advanced Grid Modeling program. Pacific Northwest National Laboratory is operated by Battelle for DOE under Contract DEAC05-76RL01830. 

2 

**==> picture [243 x 100] intentionally omitted <==**

In (1), the 4 states, δ, ω _r_ , _[e] d_ ′[ and ] _[e] q_[′][ , are the rotor angles in ] radians, rotor speeds in per-unit ( _pu_ ) and transient voltages in _pu_ along _d_ and _q_ axes, respectively. ω0 = 2π _f_ 0 is the synchronous speed; _Tm_ and _Te_ are the mechanical and the electric air-gap torque in _pu_ ; and parameters _H_ and _KD_ are the inertia and damping factor, respectively; _Efd_ is the internal field voltage. Variables _xd_ and _xq_ are the synchronous reactance; _[x] d_[′][ and ] _[x] q_[′][  are the transient reactance along ] _[d]_[ and ] _[q]_ axes, respectively. _id_ and _iq_ are the stator currents along _d_ and _q_ axes, respectively. _Td_ ′0 and _[T] q_[′] 0[ are the open circuit time ] constants in the _dq0_ frame. 

To facilitate the notation for applying the EKF to DSE of a synchronous machine, (1) is transformed into a general discrete state space model as shown in (2) and (3) with sampling interval of Δ _t_ using the modified Euler method [11]. 

**==> picture [243 x 124] intentionally omitted <==**

Here, subscript _k_ is the time index, which indicates the time instance at _k_ Δ _t_ . Symbols _xk_ , _uk_ , and _zk_ are the state, input and measurement output, respectively. Functions Φ(∗) and _h_ (∗) are the state transition and measurement function, respectively. Φ[1] _k_ −1 is the Jacobian matrix of the state transition matrix at step _k_ -1, and _H k_ [1] is the Jacobian matrix of the measurement function at step _k_ . In (2), vectors _wk_ and _vk_ are the state process noise and measurement noise, respectively. Their mean and variance are denoted by (4) [11]. Here, symbol E(∗) represents the expected value. Symbols _Qk_ and _Rk_ are the covariance matrixes of process noise and measurement noise respectively at step _k._ 

**==> picture [248 x 36] intentionally omitted <==**

III.  ADAPTIVE EXTENDED KALMAN FILTER APPROACH 

This section describes the conventional extended Kalman 

filter (CEKF) and proposes an adaptive extended Kalman filter (AEKF) approach which adaptively estimates _Qk-_ 1 and _Rk_ . 

## _A. Conventional Extended Kalman Filter_ 

The CEKF consists of the following 3 steps. Readers may refer to [11] for more details about the CEKF. 

## **Step (0) – Initialization:** 

To initialize the CEKF, the mean values and covariance matrix of the states are set up at _k =_ 0 as in (5) _._ 

**==> picture [237 x 30] intentionally omitted <==**

where the superscript “+” indicates that the estimate is _a posteriori_ , and _P_ is the state covariance matrix. 

## **Step (I) – Prediction:** 

The state and its covariance matrix at _k-_ 1 are projected one step forward to obtain the _a priori_ estimates at _k_ as in (6). 

**==> picture [238 x 52] intentionally omitted <==**

## **Step (II) - Correction:** 

The actual measurement is compared with predicted measurement based on the _a priori_ estimate. The difference is used to obtain an improved _a posteriori_ estimate as in (7). 

**==> picture [242 x 143] intentionally omitted <==**

Note that to run the CEKF, users need to provide _Qk-1_ in (6.b) and _Rk_ in (7.b). Performance of a CEKF depends on how well users can select the right _Qk-_ 1 and _Rk_ for different applications. Conventionally, _Rk_ is often assigned as a constant matrix based on the instrument accuracy of the measurements. _Qk-_ 1 is assigned as a constant matrix using a trial-and-error approach, which relies on users’ experiences and background. As such, selection of _Qk-_ 1 and _Rk_ is a challenge for the users of the CEKF. 

## _B. Adaptive Extended Kalman Filter (AEKF)_ 

To address this challenge, this paper proposes an adaptive estimation approach to estimate _Qk-_ 1 and _Rk_ in the EKF. Mehra [14] classified the adaptive estimation approaches into four categories: Bayesian, correlation, covariance matching and maximum likelihood approaches. The covariance matching is 

3 

one of the well-known adaptive estimation approaches, which tunes the covariance matrix of the _innovation_ or _residual_ based on their theoretical values [15]. At the EKF’s predication step, the _innovation_ is the difference between the actual measurement and its predicted value, and it can be calculated by (7.a). On the other hand, the _residual_ is the difference between actual measurement and its estimated value using the information available at step _k_ , and it can be calculated by (8). 

**==> picture [243 x 27] intentionally omitted <==**

Based on the above definitions, the _Qk-1_ and _Rk_ can be estimated as the follows. 

_1) Residual Based Adaptive Estimation of R_ 

The _innovation_ based approach estimates the covariance matrix _Rk_ using (9) [12]. 

**==> picture [242 x 13] intentionally omitted <==**

Here _Sk_ is the covariance matrix of the _innovation_ . Note that theoretically speaking, _Rk_ should be positive definite because it is a covariance matrix. Yet, its estimation equation (9) could not guarantee that the estimated _Rk_ be a positive definite matrix because the _Rk_ is estimated by subtracting the two positive definite matrixes. Therefore, to ensure a positive definite matrix, the _residual_ based adaptive approach proposed by [16] is used by this paper to estimate _Rk_ using (10). 

**==> picture [242 x 35] intentionally omitted <==**

To implement (10), the expectation operation on _εkεkT_ is _T_ approximated by averaging _εkεk_ over time. Instead of the using the moving window, this paper introduces a forgetting factor 0 < α ≤ 1 in (11) to adaptively estimate _Rk_ . Note that a larger α puts more weights on previous estimates and therefore incurs less fluctuation of _Rk_ , and longer time delays to catch up with changes. This paper set α = 0.3 for all the studies. 

**==> picture [242 x 14] intentionally omitted <==**

## _2) Innovation Based Adaptive estimation of Q_ 

To adaptively estimate the _Qk-_ 1, based on (2), the process noise can be calculated using (12). 

**==> picture [242 x 11] intentionally omitted <==**

From (6) and (7), it can be concluded that: 

**==> picture [242 x 62] intentionally omitted <==**

**==> picture [244 x 33] intentionally omitted <==**

Similar to the previous subsection, the paper uses a 

forgetting factor α to average estimates of _Q_ over time as in (15). 

**==> picture [243 x 12] intentionally omitted <==**

An implementation flowchart of the proposed AEKF algorithm is summarized in Fig. 1. Note that similar to the CEKF, users need to select the initial _Q0_ and _R0_ for AEKF in the initialization step. Different from the CEKF which keeps _Qk-_ 1 and _Rk_ constant, the _Qk-_ 1 and _Rk_ of the AEKF are adaptively estimated and updated during each correction step. 

**==> picture [252 x 203] intentionally omitted <==**

**----- Start of picture text -----**<br>
[x] [ˆ] 0 [+] P0+ , Q 0 , R 0<br>x ˆ k − = Φ( x ˆ k +−1, uk −1) Pk − = Φ[ k 1−] 1 Pk +−1Φ[ k 1−] T 1 + Qk −1<br>dk = ⎡⎣ zk − hk ( x ˆ k [−] ) ⎤⎦ Rk = α Rk −1 + (1−α)(ε k ε kT + H k [1] Pk − H k [1] T )<br>x ˆ k + = x ˆ k − + K k dk Kk = Pk − H k [1] T ⎡⎣ H k [1] Pk − H k [1] T + Rk ⎤⎦ −1<br>ε k = ⎡⎣ zk − hk ( x ˆ k + ) ⎤⎦ Pk + = { I − Kk H k [1]} Pk −  ,    Qk = α Qk −1 + (1−α)( K k dk dkT K kT )<br>k = k + 1<br>**----- End of picture text -----**<br>


Fig. 1. Implementation flowchart of the proposed AEKF 

IV.  CASE STUDY BASED ON A SIMPLE MODEL 

In this section, a simple linear model described by (16) is used to compare the impact of the choice of _Rk_ and _Qk-_ 1 on the performance of the CEKF and the AEKF. The simple and linear model with known noise features is used in this study to eliminate the potential impacts from non-linearity. 

The model in (16) is a model of a vehicle tracking problem, which the vehicle is constrained to move in a straight line with a constant velocity. Let _pk_ and _[p]_[&] _k_[ represent the vehicle ] position and velocity. The system state can be described by _xk_ = [ _pk_ , _p_ & _k_ ] . It is assumed that sampled observations are acquired at discrete time interval Δ _t_ . The _wk-_ 1 and _vk_ are Gaussian white noise, whose variances are defined by (16.b). 

**==> picture [243 x 90] intentionally omitted <==**

The scalars _q_ 0, _r_ 0 and Δ _t_ are set to be 0.01, 0.1 and 1, respectively. It is assumed that the vehicle starts from rest so that _x_ 0 = [0, 0][T] . For testing the performance of the CEKF and AEKF, 100 time steps of simulation are generated using (16). To evaluate the impact of _Qk_ and _Rk_ on the estimation accuracy, _x_ 0 is set to its true values and _P_ 0 is set to zeros to 

4 

eliminate their impacts on the estimation. For the CEKF, _Qk_ and _Rk_ are set by scaling _Qtrue_ and _Rtrue_ . As shown in Table I, the scaling factors are the multiples of 10. Using the same setup, the resulting mean squared errors (MSEs) of estimated position, i.e., _x_ (1), are summarized in Table I for the CEKF and in Table II for the AEKF. 

It can be observed in Table I that the MSEs on the diagonal are same. Note that the ratio between _Qk_ and _Rk_ are same for the diagonal elements. This observation indicates that it is the ratio between _Qk_ and _Rk_ (instead of their individual values) that determines the performance of the CEKF. Also observe that the major diagonal, where _Qk_ : _Rk = Qtrue_ : _Rtrue,_ have the smallest MSE (i.e. 0.051). The observation suggests that the optimal _Q/R_ ratio is around their true ratios. Also observe that the MSEs increase monotonously when the _Q/R_ ratio increases or decreases from its true value. 

|TABLE I.<br>MSES O|TABLE I.<br>MSES O|F THEESTIMATEDPOSITION FROM TH|F THEESTIMATEDPOSITION FROM TH|F THEESTIMATEDPOSITION FROM TH|E**CEKF**|E**CEKF**|
|---|---|---|---|---|---|---|
|**_MSE_**|**0.01** **_Qtrue_**|**0.1** **_Qtrue_**|**_Qtrue_**|**10** **_Qtrue_**|**100****_Qtrue_**||
|**0.01****_Rtrue_**|0.051|0.083|0.0984|0.0987|0.0988||
|**0.1****_Rtrue_**|0.219|0.051|0.083|0.0984|0.0988||
|**_Rtrue_**|3.54|0.219|0.051|0.083|0.098||
|**10****_Rtrue_**|27.28|3.54|0.219|0.051|0.083||
|**100****_Rtrue_**|41.40|27.28|3.54|0.219|0|.051|
|TABLE II. MSEOF||THEESTIMATEDPOSITION  FROM TH|||E**AEKF **||
|**_MSE_**|**0.01** **_Qtrue_**|**0.1** **_Qtrue_**|**_Qtrue_**|**10** **_Qtrue_**|**100****_Qtrue_**||
|**0.01****_Rtrue_**|0.0714|0.0787|0.0788|0.0788|0.0789||
|**0.1****_Rtrue_**|0.09|0.076|0.0783|0.0786|0.0787||
|**_Rtrue_**|0.12|0.089|0.072|0.073|0.0736||
|**10****_Rtrue_**|0.13|0.089|0.087|0.076|0.076||
|**100****_Rtrue_**|0.17|0.089|0.081|0.078|0.074||



Comparing Table I and Table II, one can observe that in general, the proposed AEKF produces smaller MSEs than the CEKF. The performance improvement of the AEKF is more significant when the MSEs of the CEKF are larger (at the bottom left of the table). The only exception to this improvement is at the major diagonal where the _Qk_ : _Rk= Qtrue_ : _Rtrue_ , which is already an optimal _Q/R_ ratio setup for the CEKF. The MSEs for the AEKF is slightly larger than the CEKF. This may be because averaging operations in (10) and (11) are used to approximate the expectation operation, which will incur some estimation errors in _Qk_ and _Rk_ . Notice that in a real world application, the true value of _Q/R_ ratio and states are often not available and have to be estimated. The proposed AEKF provides a systematic way of estimating the Q/R ratios and can often achieve stable and smaller MSEs than most guessed values. Similar observations are made with the other state (i.e., x(2) speed) and are not presented here to be concise. 

## V.  CASE STUDY BASED ON THE TWO-AREA MODEL 

To evaluate the performance of the proposed AEKF approach on the DSE of synchronous machines, the two-area four-machine system [1] shown in Fig. 2 is used to generate the simulation data. The simulation is performed using the Power System Toolbox (PST) [17]. A three-phase fault is applied to sending end of the line between buses 100 and 200 at 10.1 s. To reduce integration errors and capture the dynamics, the simulation time step is set to be 0.001 s. 

**==> picture [190 x 78] intentionally omitted <==**

**----- Start of picture text -----**<br>
1 10 20 100 200 101 21 11 3<br>G1 G3<br>400MW<br>2 4<br>Two-Area Four<br>Area 1   G2 Machine System G4 Area 2<br>**----- End of picture text -----**<br>


Fig. 2. The two-area four-machine system [1]. 

**==> picture [216 x 144] intentionally omitted <==**

Fig. 3. Comparison of AEKF and CEKF when the initial _Q_ is set to be relatively less than the proper value. 

It is assumed that all the generation buses are equipped with PMUs to measure the voltage phasors and current phasors in (3). To mimic the field measurements from the PMUs, the simulation data is decimated to 25 samples/s. And 4.0% noise in total vector errors [10] is added to the current and voltage phasors to consider the noise introduced by potential transformers and current transformers. Also, 4.0% noise is added to _Efd_ and _Tm_ . 

Similar to section IV, in the initialization step, _x_ 0 is set to its true values and _P_ 0 is set to zeros to eliminate their impacts on the estimation. Assume that the _R_ 0 is known based on the accuracy of measurement device and is set to be diag([0.04, 0.04])[2] to match the added measurement noise. The initial _Q_ 0 is adjusted to set up the following four scenarios for comparing the estimation accuracy of the AEKF and CEKF. 

**Scenario #1:** _Q_ 0 is set to very small values (i.e. 1*e-08). The states estimated by the AEKF and CEKF are shown in Fig. 3 and their MSEs are summarized in Table III. Fig. 3 shows that with the same setup, the CEKF diverges while the AEKF converges. Table III shows that the MSEs of the AEKF is much smaller than those of the CEKF for all the estimated states. The observation indicates that when _Q0_ is set up to be too small, the AEKF is robust against the improper setup and can estimate states accurately while the CEKF diverges. 

**Scenario #2:** _Q_ 0 is set to very large values (i.e. 1000). The states estimated by the AEKF and CEKF are shown in Fig. 4 and their MSEs are summarized in Table III. Fig. 4 shows that both the CEKF and AEKF converges and the states estimated by the AEKF stay closer to the true states than those estimated by the CEKF. Table III shows that the MSEs of the AEKF is smaller than those of the CEKF for all the estimated states. The observation indicates that when _Q_ 0 is set up to be too large, both the AEKF and CEKF converge and the AEKF is more accurate than the CEKF, measured by MSEs. 

5 

**Scenario #3:** _Q_ 0 is set to be close to the true values. As the true value of _Q_ 0 is not accurately known, the final _Q_ resulting from the AEKF in Scenarios #2 is used. The MSEs of the estimated states are summarized in Table III. Table III shows that the MSEs of the AEKF is similar to those of the CEKF for all the estimated states. The observation indicates that when _Q_ 0 is set up to be close to the true values, both the AEKF and CEKF converge and the AEKF has similar accuracy as the CEKF in the sense of MSEs. 

**Scenario #4:** The setups of this scenarios are same as those for scenario #1 except that the Monte-Carlo simulation is used to generate _N_ = 200 instances of simulation data with random noise. The estimated states are summarized in Fig. 5, which shows that observations made under scenarios #1 also apply to different noise instances. 

**==> picture [231 x 17] intentionally omitted <==**

**----- Start of picture text -----**<br>
TABLE III. COMPARISON OF THE MSES OF THE ESTIMATED DYNAMIC<br>STATES FROM THE CEKF AND AEKF<br>**----- End of picture text -----**<br>


||||**MSE**|**MSE**||
|---|---|---|---|---|---|
|**Scenario #**||δ|ω<br>Δ|_de_′|_qe_′|
|1|**CEKF**|3.77|1.21e-05|0.021|3.39|
||**AEKF**|7.10e-05|1.25e-07|1.05e-04|3.03e-06|
|2|**CEKF**|1.74e-04|8.33e-07|4.43e-04|6.36e-05|
||**AEKF**|2.53e-05|1.05e-07|9.74e-05|3.01e-06|
|3|**CEKF**|8.38e-05|3.98e-07|8.82e-05|3.38e-05|
||**AEKF**|1.57e-05|1.09e-07|9.21e-05|2.78e-06|



**==> picture [196 x 142] intentionally omitted <==**

Fig. 4. Comparison of AEKF and CEKF when the initial _Q_ is set to be relatively greater than the proper value. 

From the results of this section, it can be concluded that the proposed AEKF approch is robust agaist the initial errors in setting up the corvariance matrixes of process noise (i.e., _Q_ ) and measurement noise (i.e., _R_ ). The reason for scenarios #2 and #3 to have good performance is that we assume true _R_ and the measurements are ideal (meaning they match the model with no outliers, no losses). In this case, a large _Q_ would bias the EKF to believe the measurements, which would generate good estimate. If _R_ is unknown and/or measurements are not ideal, a blind selection of large _Q_ would fail to generate good estimates. We are testing _Q_ only as the first step to make it easier to show the effect of the AEKF. Scenario #1 is the most important case to examine. Future work will continue the research to test unknown _R_ and imperfect measurements. 

## VI.  CONCLUSIONS 

This paper proposes an AEKF approach to adaptively estimate and adjust covariance matrixes _Qk-_ 1 and _Rk_ for 

estimating the dynamic states of a synchronous machine. Also, it is shown through simulations using a simple model and the two-area system that the AEKF is more robust against the improper choice of initial _Q_ and _R_ than the CEKF. These simulation results suggest that the proposed AEKF can adaptively estimate _Q_ as well as _R_ and therefore relieve users’ burden of choosing proper _Q_ and _R_ in the EKF. 

**==> picture [200 x 145] intentionally omitted <==**

Fig. 5. Comparison of DSE results from the AEKF and CEKF approaches. 

REFERENCES 

- [1] P. Kundur, _Power System Stability and Control_ . New York, NY, USA: McGraw-Hill, 1994. 

- [2] Z. Huang, K. Schneider, and J. Neplocha, “Feasibility studies of applying Kalman filter techniques to power system dynamic state estimation,” Proc. 2007 Int. Power Eng. Conf. (IPEC), Singapore, pp. 376–382, 2007. 

- [3] E. Ghahremani, and K. Innocent. “Dynamic state estimation in power system by applying the extended Kalman filter with unknown inputs to phasor measurements,” _IEEE Trans. Power Syst._ , vol. 26, no. 4, pp. 2556–2566, Dec. 2011. 

- [4] H. G. Aghamolki, Z. Miao, L. Fan, W. Jiang, D. Manjure, “Identification of synchronous generator model with frequency control using unscented Kalman filter,” _Electric Power Systems Research_ , vol. 126, pp. 45-55, Sep. 2015. 

- [5] A. K. Singh, and B. C. Pal, “Decentralized dynamic state estimation in power systems using unscented transformation,” _IEEE Trans. Power Syst._ , vol. 29, no. 2, pp.794-804, Mar. 2014. 

- [6] A. Rouhani, A. Abur “Linear Phasor Estimator Assisted Dynamic State Estimation.” _IEEE Trans. Smart Grid_ , May. 2016. 

- [7] S. Wang, W. Gao, A. S. Meliopoulos, “An alternative method for power system dynamic state estimation based on unscented transform,” _IEEE Trans. Power Syst._ , vol. 27, no. 2, pp. 942-950, May 2012. 

- [8] N. Zhou, Z. Huang, Y. Li, and G. Welch, “Local sequential ensemble Kalman filter for simultaneously tracking states and parameters,” _North Amer. Power Symp._ , 2012, pp. 1-6. Sept. 2012. 

- [9] S. Akhlaghi, N. Zhou, Z. Huang, “Exploring adaptive interpolation to mitigate nonlinear impact on estimating dynamic states,” _IEEE PES General Meeting_ , Denver, CO, USA, July 2015. 

- [10] S. Akhlaghi, N. Zhou, Z. Huang, “A Multi-Step Adaptive Interpolation Approach to Mitigating the Impact of Nonlinearity on Dynamic State Estimation,” in Proc. _IEEE Transaction on Smart Grid_ . 

- [11] N. Zhou, D. Meng, Z. Huang, G. Welch, “Dynamic state estimation using PMU Data: a comparative study,” _IEEE Trans. Smart Grid_ , vol. 6, no. 1, pp. 450-460, Jan. 2015. 

- [12] A. H. Mohamed and K. P. Schwarz, “Adaptive Kalman filtering f or INS/GPS,” _J. Geodesy_ , vol. 73, no. 4, pp. 193-203, 1999. 

- [13] A. Almagbile, J. Wang, W. Ding, “Evaluating the performances of adaptive Kalman filter methods in GPS/INS integration,” _J. Global Position. Syst._ , vol. 9, no. 1, pp. 33-40, 2010. 

- [14] R. K. Mehra, “Approaches to adaptive filtering,” IEEE Trans. Autom. Control, vol. AC-17, no. 5, pp. 693–698, Oct. 1972. 

- [15] P. S. Maybeck, Stochastic Models Estimation and Control, vol. I and II 1979, Academic. 

- [16] J. Wang, "Stochastic modeling for real-time kinematic GPS/GLONASS position", _Navigation_ , vol. 46, no. 4, pp. 297-305, 2000. 

- [17] J. H. Chow; and K. W. Cheung, “A toolbox for power system dynamics and control engineering education and research,” _IEEE Trans. Power Syst._ , vol. 7, no. 4, pp. 1559–1564, Nov. 1992. 

