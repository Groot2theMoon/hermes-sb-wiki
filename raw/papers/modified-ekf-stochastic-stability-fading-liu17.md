---
title: "Stochastic stability of modified extended Kalman filter over fading channels with transmission failure and signal fluctuation"
journal: "Signal Processing, 138, 220–232"
authors: ["Xiangdong Liu", "Luyu Li", "Zhen Li", "Herbert H.C. Iu", "Tyrone Fernando"]
year: 2017
source: paper
ingested: 2026-05-01
sha256: fee8db3383eb5ce2f45018e5c74d83cfc74a7256b4b0eccd051e93988f0a5d03
conversion: pymupdf4llm
---

Signal Processing 138 (2017) 220–232 

**==> picture [60 x 66] intentionally omitted <==**

Contents lists available at ScienceDirect 

~~Signal Processing~~ journal homepage: www.elsevier.com/locate/sigpro 

**==> picture [54 x 72] intentionally omitted <==**

## Stochastic stability of modified extended Kalman filter over fading channels with transmission failure and signal fluctuation 

**==> picture [22 x 22] intentionally omitted <==**

Xiangdong Liu[a][,][b] , Luyu Li[a][,][b] , Zhen Li[a][,][b][,][∗] , Herbert H.C. Iu[c] , Tyrone Fernando[c] 

> a _School of Automation, Beijing Institute of Technology, Beijing 100081, China_ 

> b _Key Laboratory for Intelligent Control & Decision on Complex Systems, Beijing Institute of Technology, Beijing 100081, China_ 

> c _School of Electrical, Electronic and Computer Engineering, University of Western Australia, Crawley, WA 6009, Australia_ 

|a r t i c l e<br>i n f o<br>_Article_ _history:_<br>Received 12 August 2016<br>Revised 21 January 2017<br>Accepted 27 March 2017<br>Available online 29 March 2017<br>_Keywords:_<br>Extended Kalman flter<br>Stochastic stability<br>Fading channel<br>Transmission failure<br>Signal fuctuation|a b s t r a c t|
|---|---|
||The observations of nonlinear systems, exposed to a fading channel, greatly suffer from both transmission<br>failure and signal fuctuation. This paper focuses on the design-oriented analysis of nonlinear estimator<br>based on a modifed extended Kalman flter (MEKF) over fading wireless networks. Bernoulli process and<br>Rayleigh fading are taken into consideration to model transmission failure and signal fuctuation, respec-<br>tively. The ofine sufcient conditions are established for the boundedness of the expectations of the<br>prediction error covariance matrices sequence (PECMS) of the MEKF, which shows the existence of a cru-<br>cial arrival rate. Furthermore, based on the derived upper bound of PECMS, further sufcient conditions<br>are provided for mean-square bounded estimate error of the MEKF using the fxed-point theorem. Nu-<br>merical examples are also given to verify the analytical results and demonstrate the feasibility of the<br>proposed methods.<br>© 2017 Elsevier B.V. All rights reserved.|



## **1. Introduction** 

Over the past decade, wireless sensors and actuators have received a lot of attention due to their advantages of low-costs and easy of expansion [1,2]. Modern industrial systems are widely equipped with wireless sensors, bringing high requirements for the monitoring systems [3–6]. The most effective way to realize the monitoring is by means of state estimation using linear Kalman filter (KF) and nonlinear filter, i.e., Kalman variants, which catalyzes the development of nonlinear filter because the nonlinear system is the overwhelming majority in practice [7–12]. The stochastic stability of the filter is a necessary condition to guarantee the effectiveness of monitoring systems. 

However, the communication channel between wireless sets are susceptible to environmental influence. Thus, the drawback due to the wireless communication channels must be taken into consideration when conducting the analysis of the stochastic stability and performance of the filter. The major constraints of wireless channel, reducing the estimation performance, are the transmission bandwidth and fading channel [13]. On one hand, the filter under the band-limited channel is confronted with the challenges of 

> ∗ Corresponding author. zhenli@bit.edu.cn _E-mail addresses:_ xdliu@bit.edu.cn (X. Liu), liluyu@bit.edu.cn (L. Li), zhenli@bit.edu.cn (Z. Li), herbert.iu@uwa.edu.au (H.H.C. Iu), tyrone.fernando@ uwa.edu.au (T. Fernando). 

the time-delay and quantization effect, which has been profoundly studied by Shi et al. [14], Wu and Wang [15], Su et al. [16,17] and Caballero-Águila et al. [18]. On the other hand, the fading channel also causes unstable issues to the filter so that the stochastic stability and performance analysis of filter under fading channel becomes indispensable for the estimation systems design [19,20]. 

The crucial factor for an effective analysis of practical estimator is the modeling precision of the fading channel. Some research utilizes a binary treatment for the receiving information through the fading channel, which either trusts the information and utilizes it as an observation or drops it as a transmission failure. Such filtering under that channel structure was named as the filter with intermittent observations, and the stochastic stability of KF with intermittent observations for linear time invariant (LTI) was firstly studied by Sinopoli et al. [21]. That work pointed out that the prediction error covariance matrices sequence (PECMS) of the filter was random rather than deterministic, and the expectation of PECMS was exponentially bounded if the arrival rate exceeded a critical probability when the arrival of the observations conformed to a Bernoulli process. By utilizing more complicated channel model to describe the transmission failure, i.e., the Gilbert-Elliott channel model and finite state Markov process, a variety of research extended the analysis of filter with intermittent observations to more general application scenario [22–25]. Moreover, some research extended the work from LTI system to nonlinear system [26–29]. 

http://dx.doi.org/10.1016/j.sigpro.2017.03.027 0165-1684/© 2017 Elsevier B.V. All rights reserved. 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

221 

The other modeling method of fading channel is to describe the effectiveness of the observation information by the signal to noise ratio (SNR), which is also named as signal fluctuation [19,30,31]. It was pointed out that PECMS of the filter was a random variable because the signal fluctuation introduced randomness into channels, and upper bounds of means of PECMS was deduced if the channel’s SNR followed the specified distribution [30]. Besides, Quevedo further proposed that SNR was highly related to the channel gain, which was determined by the engineering parameters, i.e., the bit-rate and power level [19,31]. Furthermore, the performance analysis was extended from the filter level to the whole wireless estimation system level in [19,31,32]. Among all these works, the filter performance was analyzed in [33] and [34] under Rayleigh fading channel by verifying the upper error outage probability, which was of practical importance. 

Because both the modeling methods for fading channel are reasonable, an unified consideration about both the transmission failure and signal fluctuation is able to handle more comprehensive problems introduced by the practical problem from channels [20,35]. KF for LTI system with both transmission failure and signal fluctuation was taken into consideration in [35], where the sufficient and necessary conditions for the stochastic boundedness of PECMS were put forward by the modified Lyapunov and Riccati iteration methods, respectively. The work was further extended to the time-varying KF with more generated fading model, where the transmission failure of channel was described as a Markov chain [20]. In the case of the nonlinear system, an UKF based filter with both disturbances was studied in [36]. 

Similar to [35], the mean convergence of the PECMS was studied and an upper bound sequence for the PECMS of UKF was given. However, PECMS is a significant criterion of KF for linear systems because the estimation error is a zero mean Gaussian vector with the covariance matrix equal to the PECMS. On the contrary, it becomes unsuitable for nonlinear system only in terms of the stability and performance of PECMS so that the mean-square estimation error is the proper indicator for nonlinear system. Moreover, the unknown diagonal matrix similar to [27], which was a part of the parameters to calculate the upper bound, made the theorem in [36] difficult in application as an off-line analysis method for general nonlinear system. 

Motivated by these concerns for nonlinear systems, it is of significant necessity to study off-line sufficient conditions for the stochastic boundedness of PECMS and estimate error with both transmission failure and signal fluctuation. This effort can be utilized to design and analyze the fusion estimator over fading wireless networks. This paper focuses on the MEKF over fading channel with both disturbances and off-line sufficient conditions are established for the boundedness of both the mean of PECMS and the mean-square of the estimate error. Because the sufficient conditions for the boundedness of estimate error contain the relationship between the upper mean bound of PECMS and the system Jacobi matrix, an upper bound sequence for the mean of PECMS is also proposed in this paper. 

The rest of this paper is organized as follows. Section 2 introduces the nonlinear system and the fading channel which the observations are transmitted through. Moreover, the MEKF is established based on EKF and a proposed drop strategy. In Section 3, it˜ is proved that there exists a critical value _λc_ . If the arrivalˆ rate _λ > λc_ is guaranteed, the mean of the PECMS (i.e., E[ _Pt_ +1| _t_ ]) will be bounded for all initial conditions. In Section 4, an explicit expression sequence is proposed as the upper bound of the PECMS. Section 5 further derives the sufficient off-line conditions for the boundedness of ∥ _et_ | _t_ −1∥ based on the upper bound of the PECMS. Section 6 conducted various numerical simulations to verify the theorems in previous sections. 

The following standard notations are adopted throughout this paper. The norm of vector ∥ _x_ ∥ stands for the Euclidian norm, and the norm of matrix ∥ _A_ ∥ stands for the spectral norm. E _(x)_ denotes the expectation value of _x_ , and the E _(x_ | _y)_ denotes the expectation value of _x_ conditional on _y. In_ stands for the identity matrix with dimension _n_ , and the _I_ stands for the identity matrix with the suitable dimension. The matrix [ _[A]_ 0[1] _A_[0] 2[]][is][shortened][as] _[A]_[1][�] _[A]_[2][.] Finally, _x_ ∼ _N (x_ ¯ _, P)_ express that _x_ follow the Gaussian distribution with _x_ ¯ mean and _P_ covariance. 

## **2. Problem statement** 

Consider the discrete time nonlinear dynamical system: 

**==> picture [72 x 10] intentionally omitted <==**

_zt_ = _h(xt )_ + _νt ,_ (1) 

where _xt_ ∈ R _[n]_ is the state and _zt_ ∈ R _[p]_ is the measured output. The system function _f_ ( _x_ ) and estimate function _h_ ( _x_ ) are continuously differentiable at every _x_ . The process noise _ωt_ ∈ R _[n]_ and measurement noise _νt_ ∈ R _[p]_ are both white Gaussian noise with the covariance matrices _Q >_ 0 and _R >_ 0, respectively. It is assumed that the initial state _x_ 0 is also Gaussian random vector with the covariance matrix _R_ 0. Moreover, _ωt,νt_ and _x_ 0 are independent with each other. The measurement _zt_ is transmitted over a wireless fading channel with both fluctuant and transmission failure. 

_2.1. Effects of channel fading with transmission failure and signal fluctuation_ 

In this part, the impact of a time-varying fading communication channel will be modeled on the observation. Let _zt_ and _zt_ represent the measurement in system (1) and the received observation of filter, respectively. The model of fading channel with both fluctuation and transmission failure is thus given by Xiao et al. [35]: 

_zt_ = _ξt zt_ + _ηt ,_ (2) 

where _ηt_ ∈ R _[p]_ is the channel additive noise, which is white Gaussian noise with covariance matrices _� >_ 0. _ξt_ ∈ R represents the fading channel, which consists of transmission failure and gain fluctuation, i.e., 

_ξt_ = _γtϑt ._ (3) 

The change gain ϑ _t_ is caused by the fluctuation, whose most common statistical model is Rayleigh fading. If _ιt_ = _ϑt_[2] _[,]_[by][the] property of Rayleigh fading with the parameter _ϵ_ , _ιt_ is white and its distribution is that, _ιt_ ∼ _ϵ_ exp _(_ − _ϵιt )_ . The arrival of the observation at time _t_ is defined as a binary random _γ t_ : 

_γt_ = 1 the filter successfully get the observation 0 the observation suffers from the transmission failure. � 

(4) 

_γ t_ is a Bernoulli process with the parameter _λ_ , which means that _γ t_ is a sequence of independent identically distributed with the arrival rate P{ _γt_ = 1} = _λ_ [21]. 

The observation function of discrete-time nonlinear dynamical system together with the time-varying fading communication channel can be written as: 

_zt_ = _γtϑt h(xt )_ + _γtϑtνt_ + _ηt ,_ (5) 

where _x_ 0, _ωt, νt, ηt, γ t_ and ϑ _t_ are uncorrelated with each other. 

**Remark 1.** By the help of time-stamped technology, the information of _γ t_ together with the observation _zt_ are available for the filter at time _t_ . It is assumed that the channel gain ϑ _t_ is valid for the filter at time t by the wireless communication technology in [37]. Also, it could be supposed that the channel gain remains constant during the transfer of the _t_ th data, which is suitable when 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

222 

the data is transferred through a low bandwidth communication channel [30]. 

## _2.2. Drop strategy for observation over fading channel_ 

As already discussed in [38], the estimation over fading channel using a suboptimal estimator needs a drop strategy to optimize the performance of the filtering. Because the EKF is a suboptimal estimator for the system mentioned in Section 2.1, a drop strategy is required to balance the information loss and communication noise. A gate _β G_ is chosen in order to drop the measurements with small gain fluctuation, i.e., |ϑ _t_ | ≤ _β G_ . The corresponding communication channel under the receiver design strategy thus can be modeled by: 

**==> picture [252 x 81] intentionally omitted <==**

where the _λ_[˜] is denoted as the filtering arrival rate. Furthermore, ˜ _γt_ = 0 indicates the occurrence of transmission failure. Then, _ϑ_[˜] _t_ ˜ makes sense only in the case that _γt_ = 1 _,_ i.e., | _ϑ_[˜] _t_ | _> βG_ . Denote ˜ _ιt_ = _ϑ_[˜] _t_[2][.][In][the][case][that] _γ_[˜] _t_ = 1 _,_ ˜ ˜ _ιt_ ∼ _ϵ_ · exp _(_ − _ϵιt )_ · exp _(ϵβG_[2] _[)][,]_ (9) 

for ˜ _ι > βG_[2][.][Obviously,] _γ_[˜] _t_ and _ϑ_[˜] _t_ are still independent with each other. 

For convenience, _yt_ = _zt /ϑ_[˜] _t_ is defined. Then, the discrete-time nonlinear dynamical system under this drop strategy can be written as: 

_xt_ +1 = _f (xt )_ + _ωt ,_ 

˜ ˜ _yt_ = _γt h(xt )_ + _γtνt_ + _ηt /ϑ_[˜] _t ._ (10) ˜ Forthat convenience, _ν_ ˜ is also a white _νt_ = _νt_ Gaussian+ _ϑ[η]_ ˜ _[t] t_[is][further] process[defined.] with the[It] time-varying[is][easy][got] covariance matrix _R_[˜] _t_ = _R_ + _ϑ[�]_ ˜ _t_[2] . 

## _2.3. Modified extended Kalman filter_ 

In this section, the MEKF for the nonlinear system together with fading channel as (10) will be constructed. The MEKF is based on the two-step extended Kalman Filter and drop strategy in Section 2.2. For convenience, denote the one step state prediction as _x_ ˆ _t_ | _t_ −1 _,_ which is the estimate of _xt_ with the knowledge of { _y_ 1 _, . . . yt_ −1; _ϑ_ 1 _, . . . , ϑt_ −1; _γ_ 1 _, . . . γt_ −1}. Similarly, define the measurement as _x_ ˆ _t_ | _t ,_ which is the estimate of _xt_ with the knowledge of { _y_ 1 _, . . . yt_ ; _ϑ_ 1 _, . . . , ϑt_ ; _γ_ 1 _, . . . γt_ }. At the same time, denote the error covariance matrix for the prediction and the measurement is defined by _P_[ˆ] _t_ | _t_ −1 and _P_[ˆ] _t_ | _t_ . 

Because the function _f_ ( _x_ ) and _h_ ( _x_ ) are continuously differentiable at every _x_ , it can be presented by the Taylor expansion as: ˆ ˆ _f (xt )_ = _f (xt_ | _t )_ + _At et_ | _t_ + _φ(xt , xt_ | _t ),_ ˆ ˆ _h(xt )_ = _h(xt_ | _t_ −1 _)_ + _Ct et_ | _t_ −1 + _χ (xt , xt_ | _t_ −1 _),_ (11) where the matrix _At_ and _Ct_ are the Jacobi matrices of nonlinear function _f_ and _h_ at _x_ ˆ _t_ | _t_ and _x_ ˆ _t_ | _t_ −1 _,_ respectively, i.e., 

**==> picture [252 x 24] intentionally omitted <==**

_φ(xt , x_ ˆ _t_ | _t )_ and _χ (xt , x_ ˆ _t_ | _t_ −1 _)_ are the second order residuals for the Taylor polynomial of _f_ ( _x_ ) and _h_ ( _x_ ), respectively. 

The MEKF based on the two-step extended Kalman Filter and drop strategy has two steps in one iteration. One of the step is 

the measurement update by using _yt_ , _γ_ ˜ _t_ and _ϑ_[˜] _t ,_ which can be easily deduced by _zt, γ t_ and ϑ _t_ . The step of measurement update is that, 

**==> picture [253 x 261] intentionally omitted <==**

## **3. Boundedness of the error covariance matrices** 

Because it is hard to directly analyze the PECMS of the MEKF, an equivalent method is proposed. Note a system satisfies that _xt_ +1 = _At xt_ + _Q_[1] _[/]_[2] _ω_ ˜ _t ,[/]_[2] _yt_ = _Ct xt_ + _R_[˜] _t_[1] _[ν]_[˜] _[t][,]_ (20) 

where _At, Ct, Q_ , _R_[˜] _t_ are defined in Section 2.3 and _ω_ ˜ _t_ and _ν_ ˜ _t_ are unit white Gaussian noise, and independent with each other. Then, if the one step predict of the Kalman filter for system (20) is denoted as _x_ ˆ _t_ | _t_ −1 _,_ the covariance of _x_ ˆ _t_ | _t_ −1 (i.e., ˆ E _ω_ ˜ _i,ν_ ˜ _i_[[] _[(][x] t_[−] _x_[ˆ] _t_ | _t_ −1 _)[T] (xt_ − _xt_ | _t_ −1 _)_ ]) is equivalent to the PECMS of the MEKF by the Eqs. (13) and (15) in Section 2.3. 

_t_ toThe _t_ +state _l_ is definedtransitionas _�_ matrix _t_ + _l,t_ = of[�] _[t] i_ =[+] the _t[l]_[−][1] system _Ai_ . For the(20)furtherfrom theanalysisstep of the Kalman filter of system (20), the following concepts are provided regarding the observability and detectability. 

**Definition 1.** Firstly, similarly like [39], the _observability Gramian_ of the pair ( _At, Ct_ ) in the system (20) is defined as 

**==> picture [253 x 28] intentionally omitted <==**

Secondly, the pair ( _At, Ct_ ) in the system (20) is said to be _uniformly observable_ if there exists a positive integer _l >_ 0, and the constant real numbers _obs, obs >_ 0 such that for all _t_ ≥ 0, there exists 

**==> picture [253 x 10] intentionally omitted <==**

Finally, the pair ( _At, Ct_ ) is said to be _uniformly detectable_ if there exist _l >_ 0 and the constants 0 ≤ _decα <_ 1 and _decβ >_ 0 such that whenever ∥ _�t_ + _l,t x_ ∥ ≥ _decα_ ∥ _x_ ∥ _,_ (23) there holds _x[T] Ot_ + _l,t x_ ≥ _decβ x[T] x._ (24) 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 223 

It is obvious that the uniform observable implies the uniform detectable. 

**==> picture [253 x 68] intentionally omitted <==**

It is easy to note that for the system (10) this assumption also means _R_[˜] _t_ ≤ _(r_ + ~~_η_~~ _/βG_[2] _[)][I]_[.] 

**Theorem 1.** _If Assumption 1 is satisfied and the pair_ ( _At, Ct_ ) _is uniformly observable, there will exist a critical value λc_ = 1 − _decβ_ � _obs such that t_ →lim+∞[E][[] _P_[ˆ] _t_ +1| _t_ ] _<_ +∞ _for the arrival rate λ_[˜] _> λc. obs_ , _obs, decα and decβ are same as the parameters in Definition 1._ 

**Proof.** At first, it is jointly considered that the PECMS of MEKF is equal to the covariance of Kalman filter estimation _x_ ˆ _t_ | _t_ −1 and the fact that the Kalman filter is the optimal filter for time-varying linear systems. Thus, by defining a suboptimal filter for the system (20) as _x_ ˇ _t_ | _t_ −1 _,_ it is clear that, ˆ ˆ E _(P_[ˆ] _t_ | _t_ −1 _)_ = E[ _(xt_ | _t_ −1 − _xt )[T] (xt_ | _t_ −1 − _xt )_ ] ˇ ˇ ≤ E[ _(xt_ | _t_ −1 − _xt )[T] (xt_ | _t_ −1 − _xt )_ ] (26) 

To propose a reasonable suboptimal filter, an orthogonal matrix _Tt_ is constructed to transform symmetric observability Gramian _O_ ˜ _t_ + _l,t_ into a diagonal matrix in the decreasing order such that _Ot_ + _l,t_ = _Tt Ot_ + _l,t Tt[T]_[.][The][matrix][satisfies][that,] 

**==> picture [252 x 13] intentionally omitted <==**

where _O_[˜] _t_[1] + _l,t_[and] _O_[˜] _t_[2] + _l,t_[are][the][diagonal][matrices][of][dimensions] _[n]_[1] andThen, _n_ 2, andthe _obs_ suboptimum _I_ ≤ _O_[˜] _t_[2] + _l,t[<] dec_ filter _βI,x_ ˇ _dect_ + _l_ | _tβ_ + _Il_ −≤1 _O_ can[˜] _t_[1] + _l,t_ be[≤] _obs_ designed _I_ . in the following way, 

**==> picture [252 x 42] intentionally omitted <==**

**==> picture [252 x 39] intentionally omitted <==**

**==> picture [207 x 10] intentionally omitted <==**

**==> picture [252 x 61] intentionally omitted <==**

Here, it is denoted that _Ei_ ≜ _R_[˜][1] _i[/]_[2] _ν_ ˜ _i_ + _Ci_ � _ij_ −=1 _t[�][i][,][ j]_[+][1] _[Q]_[1] _[/]_[2] _ω_[˜] _j_ and _Ft_ ≜[�] _[t] j_[+] = _[l] t_[−][1] _[�][t]_[+] _[l][,][ j]_[+][1] _[Q]_[1] _[/]_[2] _ω_[˜] _j_ . The estimation error of the filter (28) is defined as ¯¯ _xt_ + _l_ ≜ E _γ_ ˜ _t ,...,γ_ ˜ _t_ + _l[(][x]_[ˇ] _t_ + _l_ | _t_ + _l_ −1[−] _[x] t_ + _l[)]_[.][It][can][be][further][written][as,] 

**==> picture [252 x 59] intentionally omitted <==**

By using (31), it can be obtained that, 

**==> picture [252 x 125] intentionally omitted <==**

Due to the boundedness of _At, Ct_ , _R_[˜] _t_ and _Q_ , F _t_ therefore has an upper bound F _,_ which is a positive constant, i.e., 

**==> picture [252 x 11] intentionally omitted <==**

**==> picture [253 x 330] intentionally omitted <==**

**==> picture [254 x 95] intentionally omitted <==**

## **4. Upper bounds on error covariance matrices for scalar measurement and Rayleigh fading** 

Section 3 puts forward the stochastic boundedness conditions for the PECMS. However, the proof of Theorem 1 only gives a conservative bound for E _(P_[ˆ] _t_ +1| _t )_ because the exact value of _decβ_ and 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

224 

_obs_ is hard to acquire in view of the practical application. Therefore, in this section, a rational bound for E _(P_[ˆ] _t_ +| _t )_ is proposed for the system (10) with the scalar measurement, which means _yt_ ∈ R. Because the dimension of _yt_ becomes one in this case, it is therefore reasonable to represent _Ct, R_ and _�_ as _ct, r_ and _χ_ , respectively. By combining (13) and (15), the iteration of _P_[ˆ] _t_ | _t_ −1 in the case of scalar measurement becomes 

**==> picture [252 x 27] intentionally omitted <==**

For convenience, it is denoted that _Pt_ ≜ E _(P_[ˆ] _t_ | _t_ −1 _)_ . 

_P_ ˆ _t_ | _t_ −Because1 [21, Lemmathe right1(e)]hand, bysidethe ofJensen’s(43) isinequality,a concave itfunctioncould beof deduced by taking expectation on both side of (43) that, 

**==> picture [252 x 54] intentionally omitted <==**

where _βt_ = _ct Ptχct[T]_[+] _[r]_[.] ∞ It is well known that _exp(θ )E_ 1 _(θ )_ = �0 _[exp][(]_[−] _[t][)][/][(][t]_[+] _[θ][)][dt][,]_ ∞ where _E_ 1 _(θ )_ = � _θ[exp][(]_[−] _[t][)][/][t][dt]_[.][Considering][the][distribution][of][˜] _[ι][t]_ defined by (9), it can be deduced that, 

**==> picture [252 x 81] intentionally omitted <==**

Using the inequality _exp(θ )E_ 1 _(θ )_ ≤ _ln(_ 1 + 1 _/θ ),_ it can be derived that, 

**==> picture [252 x 104] intentionally omitted <==**

_k_ 1 _(Pt )_ ≤ _k_ 1 _(ρ(Pt )I)_ 

**==> picture [227 x 52] intentionally omitted <==**

It is obvious that the matrix function _k_ 1( _Pt_ ) needs the on-line results of filtering, i.e., _At, ct_ . To acquire an off-line upper bound on _Pt_ , some assumptions are further needed. 

**==> picture [253 x 50] intentionally omitted <==**

**==> picture [252 x 51] intentionally omitted <==**

**==> picture [211 x 158] intentionally omitted <==**

**Theorem 2.** _If the scalar measurement system satisfies Assumption 2, there will exist two upper bound sequences_ { _Zt_ } = _k_ 1 _(Zt_ −1 _) and_ { _ξt I_ } = _k(ξt_ −1 _)I, which satisfies Z_ 1 = E _(P_[ˆ] 1|0 _) and ξ_ 1 = _ρ(_ E _(P_[ˆ] 1|0 _)), respectively. It is held that_ E _(P_[ˆ] _t_ | _t_ −1 _)_ ≤ _Zt_ ≤ _ξt In,_ ∀ _t._ 

**Proof.** The theorem is proven by the mathematical induction. On one hand, by (45) and (49), _Z_ 1 = _P_ 1 and _ξ_ 1 = _ρ(P_ 1 _)_ result in E _(P_[ˆ] 2|1 _)_ ≤ _Z_ 2 ≤ _ξ_ 2 _I_ . On the other hand, if it is assumed that E _(P_[ˆ] _t_ | _t_ −1 _)_ ≤ _Zt_ ≤ _ξt In,_ it will be got that, 

**==> picture [253 x 12] intentionally omitted <==**

and 

**==> picture [253 x 9] intentionally omitted <==**

by the equations of (45) and (49) and the increasing property of _k_ 1( _P_ ), □ 

## **5. The stochastic boundedness of the estimation error** 

Based on the prior boundedness of error covariance matrices, this section presents the main result of this paper that E _(_ ∥ _et_ | _t_ −1∥[2] _)_ is bounded under appropriate off-line conditions. The analysis of the estimation error is of great importance because the previous stochastic boundedness of the PECMS cannot equivalently guarantee the stochastic boundedness of the estimation errors in MEKF. The results regarding the bound of E[ _P_[ˆ] _t_ +1| _t_ ] in previous Sections 3 and 4 also play the important roles in the stochastic boundedness of the estimation error. 

**Assumption 3.** There exist the real numbers _p_ and _p_ such that 

**==> picture [253 x 74] intentionally omitted <==**

where _ϵφ_ and _ϵχ_ are the bounded positive real numbers, i.e., 0 _< ϵφ_ , _ϵχ <_ ∞. 

**Remark 2.** The two parts of Assumption 3 are reasonable. On one hand, the first part regarding E _(P_[ˆ] _t_ | _t_ −1 _)_ can be provided by Theorems 1 and 2. On the other hand, the rationality of the second part is guaranteed by the Taylor series theorem which shows that, 

**==> picture [253 x 29] intentionally omitted <==**

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 225 

´ where the _H f_ | _x_ ´ _t_ | _t_ is the Hessian matrixˆ of the function _f_ at _xt_ | _t ,_ whichsian _xt_ +1 matrixandis _x_ aˆ _t_ +vectorof1| _t_ .theIf thebetweenfunctionHessian _hxt_ atmatrixand _x_ ` _t_ | _tx,t_ |which _tH, f_ andandisthe _H_ also _h_ are _Hh_ a| _x_ `bounded _t_ vector+1| _t_ is thebetweenforHes- ∀ _x_ , the second part of Assumption 3 is therefore satisfied. 

In order to further analyze the boundedness of the estimation error, the standard result about the Banach fixed-point theorem is recalled as follows [40]. 

**Lemma 1.** _(Fixed-point Theorem) [40] If g_ ( _x_ ) _is a continuous function with g_ ( _x_ ) ∈ ( _a, b_ ) _and_ | _g_[′] ( _x_ )| _<_ 1 _for all x_ ∈ ( _a, b_ ), _g_ ( _x_ ) _will have a unique fixed-point x_[∗] ∈ ( _a, b_ ) _such that x_[∗] = _g(x_[∗] _). Furthermore, x_[∗] _can be determined as follows: start with an arbitrary element x_ 0 ∈ ( _a, b_ ), _and define a sequence_ { _xt_ } _by xt_ +1 = _g(xt ), then xt_ → _x_[∗] _when t_ → +∞ _._ 

Now, the main result of this paper can be stated as follows. 

**Theorem 3.** _The MEKF in Section 2.3 is taken into consideration, which is used to estimate the state of the system (10) with both transmission failure and signal fluctuation in Section 2.1._ 

_If Assumptions 1 and 3 hold, and the constraint is met that_ 

**==> picture [252 x 12] intentionally omitted <==**

_where_ 

**==> picture [252 x 25] intentionally omitted <==**

_the estimation error et_ | _t_ −1 _will be stochastically bounded, i.e.,_ E _(_ ∥ _et_ | _t_ −1∥[2] _) <_ +∞ _, when the initial estimation error covariance R_ 0 _satisfies that,_ 

**==> picture [252 x 32] intentionally omitted <==**

_The parameters α_ 1, _α_ 2, _α_ 3 _and α_ 4 _are relative to λ_[˜] _, ϵ_ , _β G_ , _ϵχ_ , _ϵφ a, c, q, r,_ ~~_η_~~ _, a_ , _c_ , _q_ , _p and p_ , _which will be elaborated in the following proof._ 

**==> picture [253 x 49] intentionally omitted <==**

The boundedness of E _(_ ∥ _et_ | _t_ −1∥[2] _)_ is equivalent to the boundedness of E _(Vt_ +1 _(et_ +1| _t ))_ . Next, it will be shown that E _(Vt (et_ | _t_ −1 _))_ is bounded when _t_ → +∞. ˜ Firstly, when _γt_ = 0 _,_ the iteration of E _(Vt_ +1 _(et_ +1| _t ))_ is 

**==> picture [252 x 178] intentionally omitted <==**

**==> picture [253 x 356] intentionally omitted <==**

The third term of the right-hand side in (60) is 

**==> picture [252 x 57] intentionally omitted <==**

**==> picture [253 x 148] intentionally omitted <==**

**==> picture [253 x 97] intentionally omitted <==**

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

226 

where 

**==> picture [252 x 175] intentionally omitted <==**

It is obvious to derive that 0 _< α_ 1 _<_ 1 and _α_ 2, _α_ 3, _α_ 4 _>_ 0. Considering the inequality (66), a similar progression _St_ is developed as follows, where _S_ 1 = E _(V_ 1 _(e_ 1|0 _)) >_ 0 _,_ and 

**==> picture [252 x 10] intentionally omitted <==**

Next, by using Lemma 1, the existence of a positive bounded _S_[∗] will be shown such that _t_ →lim+∞ _[S][t]_[→] _[S] t_[∗] _[,]_[if][both][(55)][and][(57)][hold.] Firstly, it is needed to demonstrate that ∥ _g_[′] ( _x_ )∥ _<_ 1. For this propose, the derivative function of _g_ 1( _x_ ) can be analyzed as follows _[/]_[2][−] _[α]_[1] _g_[′] 1 _[(][x][)]_[=][2] _[α]_[3] _[x]_[+][3] _[/]_[2] _[α]_[2] _[x]_[1] _[.]_ (69) On one hand, because _α_ 2, _α_ 3 _>_ 0, _g_[′] 1 _[(][x][)]_[is][continuously][and][mono-] tonically increasing for _x >_ 0, which means _g_[′] 1 _[(]_[0] _[)][<][g]_[′] 1 _[(][x][)][<][g]_[′] 1 _[(][ϵ]_[1] _[)]_ for _x_ ∈ (0, _ϵ_ 1). On the other hand, it is obvious that _g_[′] 1 _[(]_[0] _[)]_[=][−] _[α]_[1] _[<]_ 0 and _x_ →lim+∞ _[g]_[′] 1 _[(][x][)]_[=][+][∞] _[>]_[0][.][Because] _[g]_[′] 1 _[(][x][)]_[is][continuous,][there] must exist an _ϵ_ 1 _>_ 0 so that _g_[′] 1 _[(][ϵ]_[1] _[)]_[=][0][.][In][the][case][that] _[g]_[′] 1 _[(][ϵ]_[1] _[)]_[=][0] and _g_[′] 1 _[(]_[0] _[)]_[=][−] _[α][,]_[it][can][be][thus][deduced][that][−][1] _[<]_[−] _[α][<][g]_[′] 1 _[(][x][)][<]_[0] _[,]_ i.e., 0 _< g_[′] ( _x_ ) _<_ 1 for _x_ ∈ (0, _ϵ_ 1). Secondly, it will be shown that _g_ ( _x_ ) ∈ (0, _ϵ_ 1) for _x_ ∈ (0, _ϵ_ 1) under the condition (55). By considering _g_[′] _(x)_ = _g_[′] 1 _[(][x][)]_[+][1] _[>]_[0][for] _[x]_[∈][(0,] _[ϵ]_[1][),][it][can][be][got][that] _[g]_[(0)] _[<] g_ ( _x_ ) _< g_ ( _ϵ_ 1) for _x_ ∈ (0, _ϵ_ 1). Moreover, it is noted that the left side of (55) is exactly identical to _g_ 1( _ϵ_ 1). Therefore, it can be deduced that _g_ 1( _ϵ_ 1) _<_ 0, which also means _g_ ( _ϵ_ 1) _< ϵ_ 1. Then, due to the fact that _g(_ 0 _)_ = _α_ 4 _>_ 0 _,_ it can be got that 0 _< g_ ( _x_ ) _< ϵ_ 1 for _x_ ∈ (0, _ϵ_ 1). To conclude, _g_ ( _x_ ) therefore meets the conditions of Lemma 1. Now, the initial element of the sequence {E _(Vt (et_ | _t_ −1 _))_ } is taken into consideration. By (15), there holds that 

_e_ 1|0 ≤ _ae_ 0 + _ω_ 0 + _ϵ_ ∥ _x_ ˜0∥[2] _._ (70) Then, it can be equivalent to, E[ _V_ 1 _(e_ 1|0 _)_ ] ≤ _a_ ~~[2]~~ ∥ _R_ 0∥ + _q_ + _ϵφ_ ∥ _R_ 0∥[2] _._ (71) If the initial condition (57) is guaranteed, it can be obtained that _S_ 1 = E _(V (e_ 1|0 _))_ ∈ _(_ 0 _, ϵ_ 1 _)_ . Finally, it can be got that _t_ →lim+∞ _[S][t]_[→] _[S] t_[∗] _[,]_ where _S_[∗] ∈ (0, _ϵ_ 1) by Lemma 1. Next, let us turn to consider E _(Vt (et_ | _t_ −1 _))_ . Because E _(V_ 1 _(e_ 1|0 _))_ = _S_ 1 _,_ it is easy to get that, E _(V_ 2 _(e_ 2|1 _))_ ≤ _g(_ E _(V_ 1 _(e_ 1|0 _)))_ = _g(S_ 1 _)_ = _S_ 2 _._ (72) 

Moreover, because _g_ ( _x_ ) is monotonically increasing, E _(Vt (et_ | _t_ −1 _))_ ≤ _St_ implies that, E _(Vt_ +1 _(et_ +1| _t ))_ ≤ _g(_ E _(Vt (et_ | _t_ −1 _)))_ ≤ _g(St )_ = _St_ +1 (73) 

By the inductive method, it can be proven that E _(Vt (et_ | _t_ −1 _))_ ≤ _St_ for ∀ _t_ . Therefore, it can be inevitably concluded that E _(Vt (et_ | _t_ −1 _))_ is bounded as _t_ → +∞. Therefore, it also equivalently holds that E _(_ ∥ _et_ | _t_ −1∥[2] _)_ is bounded as _t_ → +∞ by (58). □ 

**Remark 3.** The corresponding theorem of Reif et al. [41] and Kluge et al. [26] could only be considered as a method to verify the stability of the filter during the state estimation process because it needs the on-line result of _et_ | _t_ −1 _,_ which is hard to acquire in practice. Although Theorem 3 needs the stricter constraint compared with Reif et al. [41] and Kluge et al. [26], it can effectively ensure the estimation error of MEKF bounded in the mean-square sense by off-line conditions, which is meaningful as the performance of MEKF can be guaranteed by only checking the system and channel parameters. 

**Remark 4.** The proof of Theorem 3 shows that it is important to introduce the drop strategy. The absence of the drop strategy equals that _βG_ = 0 _,_ which will make _α_ 4 = +∞ in (67) because _E_ 1 _(_ 0 _)_ = +∞. _β G_ must be carefully chosen because it should be large enough to make _α_ 4 as small as possible to satisfy the condition (55) in Theorem 3. Meanwhile, it should be as small as possible to ensure _λ_[˜] defined by (8) bigger than the critical rate _λc_ in Theorem 1. 

## **6. Numerical example and verification** 

In this section, the proposed theorems will be verified to highlight various parameters’ influence on the stability, such as the arrival rate _λ_ and the initial estimation error _R_ 0, the existent of the critical value _λ_[˜] _c,_ the effectiveness of the upper bound for the PECMS, the strategy of the choice of _β G_ and the impact of the channel additive noise _�_ . For this purposes, a nonlinear discrete-time system, which is widely used in nonlinear filtering problems [36,41,42], is adopted. The system is a model for the initial alignment of SINS with large misalignment angles, and is presented as follows: 

**==> picture [253 x 84] intentionally omitted <==**

and _τ_ = 0 _._ 003 _._ [ _ω_ 1 _,t , ω_ 2 _,t_ ] _[T]_ and _νt_ are zero mean Gaussian noises with covariance _Q_ = diag[0.003[2] , 0.003[2] ] and _R_ = 0.01[2] , respectively. Except in Section 6.3, the initial noise covariance is chosen as _R_ 0 = diag[0.5[2] , 0.5[2] ] in all other simulation of Section 6. The initial states of the systemˆ areˆ chosen as [ _x_ 1, 0, _x_ 2, 0] = [0 _._ 8 _,_ 0 _._ 2] _,_ and the initial estimation [ _x_ 1 _,_ 0 _, x_ 2 _,_ 0] is generated from _N (_ [ _x_ 1 _,_ 0 _, x_ 2 _,_ 0] _, R_ 0 _)_ . The observation _yt_ is transferred through the fading channel described in Section 2.1 with both transmission failure and signal fluctuation, which will be described in Section 6.1. 

## _6.1. Demonstration of channel fading and drop strategy_ 

The fading channel model is described as the Eq. (5), where _γ t_ reflects the transmission failure, ϑ _t_ is the signal fluctuation, and _ηt_ is the channel additive noise. In this simulation, _γ t_ is chosen as a Bernoulli process with the arrival rate _p(γt_ = 1 _)_ = _λ,_ which will be chosen separately in each simulation. ϑ _t_ follows the Rayleigh fading, which means _ϑt_[2][∼] _[ϵ]_[ exp] _[(]_[−] _[ϵϑ] t_[2] _[)]_[.][Also,][the][Rayleigh][pa-] rameter _ϵ_ will be chosen elaborately in each simulation. At last, _ηt_ is a zero mean Gaussian noise with covariance _�_ £ which will also be altered in every simulation. As discussed in Section 2.2, the drop strategy also plays an important role in the estimation process as a part of the MEKF. To illustrate this, a simulation for the fading channel including the fluctuation ϑ _t_ and intermittent _γ t_ of one sample path is conducted with the channel additive 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

227 

**==> picture [218 x 138] intentionally omitted <==**

**Fig. 1.** Demonstration of the influence of channel fading and drop strategy when _λ_ = 0 _._ 8 _, ϵ_ = 5 _._ 5 and _βG_[2][=][0] _[.]_[1][.] 

noise _�_ = 0 _._ 1[2] _,_ the drop rate _λ_ = 0 _._ 8 _,_ the Rayleigh fading parameter _ϵ_ = 5 _._ 5 and the drop strategy gate _βG_[2][=][0] _[.]_[1][.][The][simulation][re-] sults are shown in Fig. 1. Three cases can be categorized during the process when the observations are transformed through the fading channel. The first case, marked in red, is that the filter does not get the observation because the transmission failure happens, which means _γt_ = 0. In another case, marked in green, the filter gets the observation and drops it by the drop strategy when ϑ _t < β G_ . In the remaining case, marked in blue, the observation is got by the filter and is utilized for the estimation process. Algorithm 1 is estab- 

**Algorithm 1** Simulation process of MEKF under fading channel. 

|**Initialization:** Generate ˆ<br>_x_0 | 0 ∼_N_ _(x_ 0 _,_ _R_ 0 _)_ .<br>**Loop** **Process:**<br>**while** _t_ ≥1 **do**<br>ˆ<br>_xt_ | _t_ −1 = _f(_ ˆ<br>_xt_ −1 | _t_ −1 _)_<br>_A_ _t_−1 = _∂f(x_ _)_ _/_ _∂x_ | _x_ = ˆ<br>_xt_ −1 | _t_ −1|**Initialization:** Generate ˆ<br>_x_0 | 0 ∼_N_ _(x_ 0 _,_ _R_ 0 _)_ .<br>**Loop** **Process:**<br>**while** _t_ ≥1 **do**<br>ˆ<br>_xt_ | _t_ −1 = _f(_ ˆ<br>_xt_ −1 | _t_ −1 _)_<br>_A_ _t_−1 = _∂f(x_ _)_ _/_ _∂x_ | _x_ = ˆ<br>_xt_ −1 | _t_ −1|**Initialization:** Generate ˆ<br>_x_0 | 0 ∼_N_ _(x_ 0 _,_ _R_ 0 _)_ .<br>**Loop** **Process:**<br>**while** _t_ ≥1 **do**<br>ˆ<br>_xt_ | _t_ −1 = _f(_ ˆ<br>_xt_ −1 | _t_ −1 _)_<br>_A_ _t_−1 = _∂f(x_ _)_ _/_ _∂x_ | _x_ = ˆ<br>_xt_ −1 | _t_ −1|**Initialization:** Generate ˆ<br>_x_0 | 0 ∼_N_ _(x_ 0 _,_ _R_ 0 _)_ .<br>**Loop** **Process:**<br>**while** _t_ ≥1 **do**<br>ˆ<br>_xt_ | _t_ −1 = _f(_ ˆ<br>_xt_ −1 | _t_ −1 _)_<br>_A_ _t_−1 = _∂f(x_ _)_ _/_ _∂x_ | _x_ = ˆ<br>_xt_ −1 | _t_ −1|
|---|---|---|---|
|ˆ<br>_P_ _t_ | _t_ −1 = _A_ _t_−1 ˆ<br>_P_ _t_ −1 | _t_ −1 _A_ _t_−1||+ _Q_||
|Generate _ι_∼_ϵ_exp _(_−_ϵι)_||||
|_ϑ_ = ~~√~~<br>_ι_||||
|Generate _η_ ∼_N_ _(_0 _,_ _�)_||||
|_z_ _t_ = _y_ _t_ + _η/ϑ_||||
|**if** _ι_≥_β_2<br>_G_ **then**||||
|Generate _ς_ from uniformly distributed on _(_0 _,_ 1_)_||||
|**if** _ς_ _<_ _λ_ **then**||||
|˜<br>_γ_ = 1||||
|**else**||||
|˜<br>_γ_ = 0||||
|**end** **if**||||
|**else**||||
|˜<br>_γ_ = 0||||
|**end** **if**||||
|**if** ˜<br>_γ_ == 1 **then**||||
|_C_ _t_ = _∂h_ _(x_ _)_ _/_ _∂x_ | _x_ = ˆ<br>_xt_ | _t_ −1<br>_K_ _t_ = ˆ<br>_P_ _t_ | _t_ −1 _C_ _T_<br>_t_ _(C_ _t_ ˆ<br>_P_ _t_ | _t_ −1 _C_ _T_<br>_t_ + _R_ + _�/_ _ϑ_ 2 _)_ −1<br>ˆ<br>_xt_| _t_ = ˆ<br>_xt_ | _t_ −1 + _K_ _t_ _(z_ _t_ −_h_ _(_ ˆ<br>_xt_ | _t_ −1 _))_<br>ˆ<br>_P_ _t_| _t_ = ˆ<br>_P_ _t_ | _t_ −1 _C_ _T_<br>_t_ _(C_ _t_ ˆ<br>_P_ _t_ | _t_ −1 _C_ _T_<br>_t_ + _R_ + _�/_ _ϑ_ 2 _)_ −1 _C_ _t_ ˆ<br>_P_ _t_ | _t_ −1<br>**else**<br>ˆ<br>_xt_| _t_ = ˆ<br>_xt_ | _t_ −1<br>ˆ<br>_P_ _t_| _t_ = ˆ<br>_P_ _t_ | _t_ −1||||
|**end** **if**||||
|**end** **while**||||



lished to detail the MEKF filtering theory and simulation process. 

**Table 1** 

Initial value and arrival rate for the simulation of the MEKF for the system (74). 

||Normal|Low arrival rate|Large initial noise|
|---|---|---|---|
|_R_ 0|0.5 2|0.5 2|2.5 2|
|_λ_|0.8|0.2|0.8|



## _6.2. Performance comparison of filter considering channel condition_ 

As the observation function of the system (74) is linear, the filter proposed in [38] can be utilized to estimate the states of the system (74) under both transmission failure and signal fluctuation. For convenience, the one step prediction of filter in [38] is defined as _x_ ˜ _t_ | _t_ −1 and the one step prediction estimation error as _e_ ˜ _t_ | _t_ −1. In this part for comparison, the other parameters are chosen as _�_ = 0.02[2] , _ϵ_ = 5.5 and _βG_[2][=][0.05.] 

In order to clearly demonstrate the estimation accuracy comparison, a high arrival rate is chosen as _λ_ = 0.95. The filtering results are shown in Fig. 2. Fig. 2(a) shows that the estimation error of MEKF is much smaller than the filter in [38], which is also confirmed in Fig. 2(b) that MEKF can track the state _x_ 2 quickly while it takes much more time for the filter in [38] to track the state. Besides, the other criteria to evaluate the filter under fading channel is the crucial arrival rate. For this purpose, we reduce _λ_ progressively to produce a poor communication condition. The filtering results are shown in Fig. 3 when _λ_ = 0 _._ 82. Under that channel condition, the filter in [38] becomes divergent as shown in Fig. 3(a). At the same time, the MEKF still tightly tracks the system states, and provides the proper estimation accuracy. 

## _6.3. Effect on stability of λ and_ R _0_ 

Because the system has the uniformly observable property [41, Section 5], the boundedness of the PECMS can be guaranteed if the filtering arrival rate _λ_[˜] is large enough by Theorem 1. Then, by using Theorem 3 and combining the boundedness of other parameters (i.e., _At, Ct, Q, R_ and _�_ ) by the simulation methods in [41, Section5], the estimate error will be bounded if the initial error covariance _R_ 0 is small enough, the drop strategy gate _β G_ is appropriate and the channel additive noise _�_ is small enough. In this part, _R_ 0 and _λ_ (which is directly proportional to _λ_[˜] ) are taken into consideration to verify the stability of the MEKF. The existence of the critical value _λ_[˜] and the influence of _β G_ and _�_ will be further shown in the next part. 

In order to verify _λ_ and _R_ 0, three cases are specifically demonstrated, including the normal case with the small initial error and high arrival rate, the low arrival rate case with the small initial error and the large initial error case with high arrival rate. The channel parameters, except _λ_ , are chosen the same as the previous simulation of the fading channel. The parameters _λ_ and _R_ 0 are detailed in Table 1. The other parameters in this simulation are chosen as _�_ = 0.1[2] , _ϵ_ = 5.5 and _βG_[2][=][0.1.] 

The simulation results are shown in from Figs. 4 to 6, where both the estimation error ∥ _et_ | _t_ −1∥ and the one step prediction _x_ ˆ2 _,t_ are illustrated for each case. It can be verified from the simulation that a low arrival rate inevitably makes the estimation errors unbounded because the corresponding low arrival rate will cause the PECMS unbounded by Theorem 1, which therefore results in the unbounded estimation error. At the same time, the large initial error also results in the divergence of the estimation error by Theorem 3. 

## _6.4. Verification on the existence of λ_ c 

Fig. 4 shows the stable filtering results. On the contrary, Figs. 5 and 6 show the divergent filtering results. Theorem 1 discusses 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

228 

**==> picture [182 x 137] intentionally omitted <==**

**==> picture [186 x 137] intentionally omitted <==**

**Fig. 2.** Comparison of MEKF with filter in [38] when _λ_ = 0 _._ 95. 

**==> picture [182 x 136] intentionally omitted <==**

**==> picture [186 x 136] intentionally omitted <==**

**Fig. 3.** Comparison of MEKF with filter in [38] when _λ_ = 0 _._ 82. 

**==> picture [182 x 159] intentionally omitted <==**

**==> picture [186 x 159] intentionally omitted <==**

**Fig. 4.** Simulation results of the MEKF for the system (74) when _λ_ = 0 _._ 8 and _R_ 0 = 0 _._ 1[2] . 

that there exists a critical value of the arrival rate _λc_ such that the filter is stable if the filtering arrival rate exceeds the critical value (i.e., _λ_[˜] _> λc_ ). As discussed in Section 2.1, _λ_[˜] satisfies the Eq. (8), where _λ_[˜] is related to _λ_ , _ϵ_ and _β G_ . Therefore, two simulations are accordingly designed to verify the existence of _λc_ . 

In the first simulation, the parameters _R_ 0, _β G, �_ are set as _R_ 0 = 0 _._ 5[2] _, βG_[2][=][0] _[.]_[1][and] _[�]_[=][0] _[.]_[1][2][and][five][values][of][the][fluctuation] parameter _ϵ_ are selectively chosen as in Table 2. For each _ϵ_ , the arrival rate _λ_ is accordingly set one by one from 0 to 1 with the interval of 0.02 to perform the filtering. By 500 Monte Carlo simulations, the result is shown in Fig. 7. Average estimation error 1 1000 of ∥ _et_ | _t_ −1∥ over 1000 points (i.e., 1000 � _t_ =1[∥] _[e] t_ | _t_ −1[∥][)][is][plotted] for each _λ_ only when the filter is stable under the corresponding settings of _λ_ and _ϵ_ . Note that the average estimation error is different on each _ϵ_ curve for the same _λ_ because the mean of 

**Table 2** 

The choices of _ϵ_ and simulation results of _λsimu_ for _λc_ . 

|||_ϵ_1|_ϵ_2|_ϵ_3|_ϵ_4|_ϵ_5|
|---|---|---|---|---|---|---|
||_ϵ_|0.0100|1.1541|2.1072|2.9773|3.7778|
||exp _(_−_ϵβ_2<br>_G_ _)_|0.9900|0.8910|0.8100|0.7425|0.6854|
||_λsimu_|0.18|0.20|0.22|0.24|0.26|
||_λsimu_ ·exp _(_−_ϵβ_2<br>_G_ _)_|0.1782|0.1782|0.1782|0.1782|0.1782|



_ιt_ = _ϑt_[2][is][1/] _[ϵ]_[,][which][makes][the][covariance][matrix][of][equivalent] observation noise _R_[˜] _t_ different. Therefore, the smallest _λ_ of the stable filtering under certain _ϵ_ can be found and is denoted as _λsimu_ , which is recorded in the third rows of Table 2. Then, _λsimu_ · exp _(_ − _ϵβG_[2] _[)]_[could][be][regarded][as][the][simulation][results][of] the _λc_ , which is also shown in the last rows of Table 2. 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 229 

**==> picture [181 x 159] intentionally omitted <==**

**==> picture [182 x 159] intentionally omitted <==**

**Fig. 5.** Simulation results of the MEKF for the system (74) when _λ_ = 0 _._ 2 and _R_ 0 = 0 _._ 1[2] . 

**==> picture [177 x 158] intentionally omitted <==**

**==> picture [187 x 158] intentionally omitted <==**

**Fig. 6.** Simulation results of the MEKF for the system (74) when _λ_ = 0 _._ 8 and _R_ 0 = 2 _._ 5[2] . 

**==> picture [224 x 157] intentionally omitted <==**

**Fig. 7.** Simulation results of _λsimu_ for different _ϵ_ when _βG_[2][=][0] _[.]_[1][and] _[�]_[=][0] _[.]_[1][2][.] 

Similarly, the same parameters _R_ 0 = 0 _._ 5[2] _, ϵ_ = 1 and _�_ = 0 _._ 1[2] are used in the second simulation, and five different values of _β G_ are chosen, which is declared in Table 3. For each _β G, λ_ is selectively chosen in the same way as the first simulation, and the corresponding average estimation errors are plotted in Fig. 8 as well. Because _λsimu_ · exp _(_ − _ϵβG_[2] _[)]_[stands][for][the][simulation][result] of _λc_ , the existence of _λc_ can be thus verified by the last row of Tables 2 and 3. Note that the average estimation error is almost 

|**Table** **3**||||||
|---|---|---|---|---|---|
|The choices of _βG_ and|simulation|results of _λsimu_ for _λc_ .||||
||_βG_ 1|_βG_ 2|_βG_ 3|_βG_ 4|_βG_ 5|
|_βG_|0.10 0 0|0.3397|0.4590|0.5456|0.6147|
|exp _(_−_ϵβ_2<br>_G_ _)_|0.9900|0.8910|0.8100|0.7425|0.6854|
|_λsimu_|0.18|0.2|0.22|0.24|0.26|
|_λsimu_ ·exp _(_−_ϵβ_2<br>_G_ _)_|0.1782|0.1782|0.1782|0.1782|0.1782|



**==> picture [224 x 157] intentionally omitted <==**

**Fig. 8.** Simulation results of _λsimu_ for different _β G_ when _ϵ_ = 1 and _�_ = 0 _._ 1[2] . 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

230 

**==> picture [179 x 139] intentionally omitted <==**

**==> picture [180 x 139] intentionally omitted <==**

**Fig. 9.** PECMS and its bounds of the MEKF for the system (74). 

identical for the same _λ_ even when _β G_ is different because _R_[˜] _t_ is same although _β G_ is different. 

To conclude, _λc_ definitely exists and has no relationship with the energy level of the channel noise. It is only dependent on the model of signal fluctuation, drop strategy gate and the drop rate, which verifies the Eq. (8). 

## _6.5. Verification on the upper bound of PECMS_ 

By Theorem 1, the PECMS is stochastic bounded under the uniform observability condition. The system (74), whose dimension of the observation is one, satisfies the scalar observation condition of Theorem 2. The simulation in this part is to demonstrate the performance of the upper bound of the PECMS proposed in Theorem 2. Note that it is meaningless to analyze the bounds of PECMS of a divergent filter so that only the normal stable case is under consideration. The effect of _�_ is compared to demonstrate the explicit bounds of the system, which is plotted in Fig. 9. It is shown that the upper bounds _ξ t_ is positively correlated with _�_ , as shown in the Eq. (49). 

## _6.6. Effect of β_ G _on performance of filtering_ 

Under the condition that the PECMS is stochastically bounded, the appropriate _β G, �_ and _R_ 0 are of critical importance for the sufficient conditions for the stochastic boundedness of the estimate error by the equations of (55), (67) and (57) in Theorem 3. The influence of _R_ 0 has been shown in the previous part. Therefore, the relationship between the _β G_ and the average estimate error is shown in this part. The parameters are chosen as _λ_ = 0 _._ 8 and _ϵ_ = 1. Also, two different additive noise _�_ = 0 _._ 05[2] and _�_ = 0 _._ 075[2] is selected for comparison. The simulation results are shown in Fig. 10. It is obvious that there exists an optimal _β G_ minimizing the average estimate error. Therefore, _β G_ should be appropriately designed, which can be neither too large nor too small. It is similar with the result in [38]. 

**Remark** and _χ (xt_ **5.** _, x_ ˆ _t_ To| _t )_ demonstratein the Eqs. (16)the andselection(17) arestrategyapproximatedof _β G_ , _φ(_ by _xt , x_ twoˆ _t_ | _t )_ zero mean noises with covariance _Qx_ and _Rx_ , respectively. For convenience, the assumption is made that the two noises are independent with _ωt, νt_ , ϑ _t_ and each other. Then, the covariance of estimation by dropping the observation is that, 

**==> picture [252 x 37] intentionally omitted <==**

**==> picture [197 x 13] intentionally omitted <==**

**==> picture [230 x 155] intentionally omitted <==**

**==> picture [133 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
Fig. 10. Simulation results for the network.<br>**----- End of picture text -----**<br>


**==> picture [210 x 12] intentionally omitted <==**

By comparing the Eqs. (76) with (77), it is clear that there exists˜ a value ϑ _c_ that _P_[ˆ] _t_ +1 _,_ keep _> P_[ˆ] _t_ +1 _,_ drop when _ϑ_[˜] _t <_ ϑ _c_ . Thus,˜when _ϑt <_ ϑ _c_ , we would rather drop the observation by setting _γk_ = 0 than utilize _yk_ to perform the measurement update step of filtering. In this case, we should set _β G_ = ϑ _c_ . By the Eq. (77), the _β G_ has the positive correlation with _Qx_ and _Rx_ , which means that _β G_ should be chosen according to the nonlinearity of system and observation functions. Especially, when the nonlinearity of observation functions becomes notable, a suitable drop strategy _β G_ should be chosen selectively, where _Kt RxKt[T][/] ϑ_[˜] _t_[2][will][become][a][nonnegli-] gible large value with small _ϑ_[˜] _t_ . However, the selection of _β G_ by precisely calculating the Eqs. (76) and (77) always needs a mass of computation since it is hard to calculate _Qx_ and _Rx_ . A feasible replacement to select _β G_ is the practical method through simulation or experiment. 

**Remark 6.** For the system (74), it should be noticed that the observation function is linear. By the Eq. (77), the influence of _ϑ_[˜] _t_ on _P_[ˆ] _t_ +1 _,_ keep is slight. In Fig. 10, the simulation result confirms the analysis, where the estimation error are almost the same even _β G_ is small. 

## _6.7. Effect of additive noise with bounded PECMS_ 

From the Eqs. (55) and (67) in Theorem 3, it can be concluded that an improper _�_ will make the estimate error divergent even when the E[ _P_[ˆ] _t_ +1| _t_ ] is bounded. In order to demonstrate that, a system with strong non-linearity is introduced here as: _xt_ +1 = 10 sin _(xt )_ + _xt_ + _ωt ,_ 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 231 

**==> picture [185 x 153] intentionally omitted <==**

**==> picture [181 x 153] intentionally omitted <==**

**Fig. 11.** Estimate error of the MEKF for the system (78). 

**==> picture [181 x 153] intentionally omitted <==**

**==> picture [185 x 153] intentionally omitted <==**

**Fig. 12.** PECMS of the MEKF for the system (78). 

**==> picture [187 x 153] intentionally omitted <==**

**==> picture [184 x 153] intentionally omitted <==**

**Fig. 13.** State and estimate of the MEKF for the system (78). 

(78) 

## _yt_ = 10 cos _(xt )_ + 11 _xt_ + _νt ,_ 

where _ωt_ and _νt_ are the white Gaussian noise with the covariance matrix _Qk_ = 0 _._ 003[2] and _Rk_ = 0 _._ 01[2] _,_ respectively. The initial state is _x_ 0 = 10 and the noise of the initial estimator is _R_ 0 = 0 _._ 01[2] . The observed data is transformed through the channel modeled as in Section 2.1 with _λ_ = 0 _._ 95 _, ϵ_ = 0 _._ 5 and _βG_ = 0 _._ 01. The channel additive noise covariance matrix _�_ is chosen to verify the theorem. Two cases are included into consideration. The first case stands for the small channel noise with _�_ = 0 _._ 001[2] _,_ and the other case represents the large channel noise with _�_ = 0 _._ 1[2] . The simulation 

results are shown in Figs. 11–13, illustrating that the estimate error can be extraordinarily large even when _P_[ˆ] _t_ +1| _t_ is still small, i.e. bounded. Therefore, the channel additive noise is another critical factor for the stochastic stability. 

## **7. Conclusion** 

This paper provides the off-line sufficient conditions on the mean-square boundedness of estimate error of the MEKF over the fading channel with both transmission failure and signal fluctua- 

_X. Liu et al. / Signal Processing 138 (2017) 220–232_ 

232 

tion. The critical filtering arrival rate is first proved to guarantee the stochastic boundedness of the PECMS, which only depends on off-line conditions. Based on the proposed upper bound of PECMS, the boundedness of estimation error is further addressed even when the PECMS is bounded and its corresponding sufficient conditions are also analytically provided. The influence of various parameters in proposed theorems, such as the initial error, channel additive noise and drop strategy gate and so on, is discussed in depth on the estimation performance and stability, which is also verified by different simulations. The main contribution of this work is that one can analyze the stochastic stability of a wireless estimation system using the filtering structure proposed in this paper. Our research interest will focus on analyzing the effect of transfer delay, quantization error on nonlinear filter with transmission failure and signal fluctuation in future work, which includes practical designs. Other triggering strategies of nonlinear filter will also be taken into consideration to reduce the communication relief. 

## **Acknowledgment** 

This work was supported by National Natural Science Foundation of China under Grant Nos. 51407011, 11372034 and 11572035. 

## **References** 

- [1] I.F. Akyildiz, W. Su, Y. Sankarasubramaniam, E. Cayirci, Wireless sensor networks: a survey, Comput. Netw. 38 (4) (2002) 393–422. 

- [2] A. Ribeiro, G.B. Giannakis, Bandwidth-constrained distributed estimation for wireless sensor networks-part i: gaussian case, IEEE Trans. Signal Process. 54 (3) (2006) 1131–1143. 

- [3] J. Liu, S. Laghrouche, M. Harmouche, M. Wack, Adaptive-gain second-order sliding mode observer design for switching power converters, Control Eng. Pract. 30 (2014) 124–131. 

- [4] S. Laghrouche, J. Liu, F.S. Ahmed, M. Harmouche, M. Wack, Adaptive second-order sliding mode observer-based fault reconstruction for pem fuel cell air-feed system, IEEE Trans. Contr. Syst. Technol. 23 (3) (2015) 1098–1109. 

- [5] N. Liu, X. Lyu, Y. Zhu, J. Fei, Active disturbance rejection control for current compensation of active power filter, Int. J. Innov. Comput. Inf. Control 12 (2016a) 407–418. 

- [6] J. Liu, W. Luo, X. Yang, L. Wu, Robust model-based fault diagnosis for pem fuel cell air-feed system, IEEE Trans. Ind. Electron. 63 (5) (2016b) 3261–3270. 

- [7] L. Wu, P. Shi, H. Gao, State estimation and sliding-mode control of markovian jump singular systems, IEEE Trans. Autom. Control 55 (5) (2010) 1213–1219. 

- [8] L. Wu, W.X. Zheng, Reduced-order _H_ 2 filtering for discrete linear repetitive processes, Signal Process. 91 (7) (2011) 1636–1644. 

- [9] N. Azman, S. Saat, S. Nguang, Nonlinear filter design for a class of polynomial discrete-time systems, Int. J. Innov. Comput. Inf. Control 11 (2015) 1011–1019. 

- [10] P. Shi, X. Su, F. Li, Dissipativity-based filtering for fuzzy switched systems with stochastic perturbation, IEEE Trans. Autom. Control 61 (6) (2016) 1694–1699. 

- [11] X. Liu, Y. Yu, Z. Li, H.H. Iu, Polytopic _H_ ∞ filter design and relaxation for nonlinear systems via tensor product technique, Signal Process. 127 (2016) 191–205. 

- [12] X. Su, P. Shi, L. Wu, Y.-D. Song, Fault detection filtering for nonlinear switched stochastic systems, IEEE Trans. Autom. Control 61 (5) (2016) 1310–1315. 

- [13] J.P. Hespanha, P. Naghshtabrizi, Y. Xu, A survey of recent results in networked control systems, Proc. IEEE 95 (1) (2007) 138. 

- [14] P. Shi, M. Mahmoud, S.K. Nguang, A. Ismail, Robust filtering for jumping systems with mode-dependent delays, Signal Process. 86 (1) (2006) 140–152. 

- [15] L. Wu, Z. Wang, Fuzzy filtering of nonlinear fuzzy stochastic systems with time-varying delay, Signal Process. 89 (9) (2009) 1739–1753. 

- [16] X. Su, P. Shi, L. Wu, S.K. Nguang, Induced _l_ 2 filtering of fuzzy stochastic systems with time-varying delays, IEEE Trans. Cybern. 43 (4) (2013) 1251–1264. 

- [17] X. Su, P. Shi, L. Wu, M.V. Basin, Reliable filtering with strict dissipativity for ts fuzzy time-delay systems, IEEE Trans. Cybern. 44 (12) (2014) 2470–2483. 

- [18] R. Caballero-Águila, A. Hermoso-Carazo, J. Linares-Pérez, Fusion estimation using measured outputs with random parameter matrices subject to random delays and packet dropouts, Signal Process. 127 (2016) 12–23. 

- [19] D.E. Quevedo, A. Ahlén, A.S. Leong, S. Dey, On kalman filtering over fading wireless channels with controlled transmission powers, Automatica 48 (7) (2012) 1306–1316. 

- [20] D.E. Quevedo, A. Ahlen, K.H. Johansson, State estimation over sensor networks with correlated wireless fading channels, IEEE Trans. Autom. Control 58 (3) (2013) 581–593. 

- [21] B. Sinopoli, L. Schenato, M. Franceschetti, K. Poolla, M. Jordan, S.S. Sastry, et al., Kalman filtering with intermittent observations, IEEE Trans. Autom. Control 49 (9) (2004) 1453–1464. 

- [22] M. Huang, S. Dey, Stability of kalman filtering with markovian packet losses, Automatica 43 (4) (2007) 598–607. 

- [23] L. Xie, L. Xie, Stability of a random riccati equation with markovian binary switching, IEEE Trans. Autom. Control 53 (7) (2008) 1759–1764. 

- [24] S. Kar, B. Sinopoli, J.M. Moura, Kalman filtering with intermittent observations: weak convergence to a stationary distribution, IEEE Trans. Autom. Control 57 (2) (2012) 405–420. 

- [25] E.R. Rohr, D. Marelli, M. Fu, Kalman filtering with intermittent observations: on the boundedness of the expected error covariance, IEEE Trans. Autom. Control 59 (10) (2014) 2724–2738. 

- [26] S. Kluge, K. Reif, M. Brokate, Stochastic stability of the extended kalman filter with intermittent observations, IEEE Trans. Autom. Control 55 (2) (2010) 514–518. 

- [27] L. Li, Y. Xia, Stochastic stability of the unscented kalman filter with intermittent observations, Automatica 48 (5) (2012) 978–981. 

[28] L. Li, Y. Xia, Unscented kalman filter over unreliable communication networks with markovian packet dropouts, IEEE Trans. Autom. Control 58 (12) (2013) 3224–3230. 

- [29] X. Su, L. Wu, P. Shi, Sensor networks with random link failures: distributed filtering for t–s fuzzy systems, IEEE Trans. Ind. Inform. 9 (3) (2013) 1739–1750. 

- [30] S. Dey, A.S. Leong, J.S. Evans, Kalman filtering with faded measurements, Automatica 45 (10) (2009) 2223–2233. 

- [31] D.E. Quevedo, A. Ahlén, et al., Energy efficient state estimation with wireless sensors through the use of predictive power control and coding, IEEE Trans. Signal Process. 58 (9) (2010) 4811–4823. 

- [32] S. Ghandour-Haidar, L. Ros, J.-M. Brossier, On the use of first-order autoregressive modeling for rayleigh flat fading channel estimation with kalman filter, Signal Process. 92 (2) (2012) 601–606. 

- [33] R. Parseh, K. Kansanen, On estimation error outage for scalar gauss–markov signals sent over fading channels, IEEE Trans. Signal Process. 62 (23) (2014) 6225–6234. 

- [34] R. Parseh, K. Kansanen, Diversity effects in kalman filtering over rayleigh fading channels, IEEE Trans. Signal Process. 63 (23) (2015) 6329–6342. 

- [35] N. Xiao, L. Xie, L. Qiu, Feedback stabilization of discrete-time networked systems over fading channels, IEEE Trans. Autom. Control 57 (9) (2012) 2176–2189. 

- [36] L. Li, Y. Xia, Ukf-based nonlinear filtering over sensor networks with wireless fading channel, Inf. Sci. 316 (2015) 132–147. 

- [37] A. Goldsmith, Wireless Ccommunications, Cambridge university press, 2005. [38] Y. Mostofi, R.M. Murray, To drop or not to drop: design principles for kalman filtering over wireless fading channels, IEEE Trans. Autom. Control 54 (2) (2009) 376–381. 

- [39] B. Anderson, J.B. Moore, Detectability and stabilizability of time-varying discrete-time linear systems, SIAM J. Control Optim. 19 (1) (1981) 20–32. 

- [40] V. Istrc, et al., Fixed Point Theory: An Introduction, 1, Springer, 1981. 

- [41] K. Reif, S. Günther, E. Yaz, R. Unbehauen, Stochastic stability of the discrete– time extended kalman filter, IEEE Trans. Autom. Control 44 (4) (1999) 714–728. 

- [42] G. Wang, J. Chen, J. Sun, Stochastic stability of extended filtering for non-linear systems with measurement packet losses, IET Control Theory Appl. 7 (17) (2013) 2048–2055. 

