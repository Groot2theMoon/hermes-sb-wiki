---
title: "1"
arxiv: "2506.0481"
authors: ["Shenglun Yi", "Mattia Zorzi"]
year: 2025
source: paper
ingested: 2026-05-06
sha256: 88edfeb05cb5e84df110c1646c939626d37c2bd0dd620c01d75e3a9699170b4c
conversion: pymupdf4llm
---

1 

# A robust approach to sigma point Kalman filtering 

Shenglun Yi and Mattia Zorzi 

## **Abstract** 

In this paper, we address a robust nonlinear state estimation problem under model uncertainty by formulating a dynamic minimax game: one player designs the robust estimator, while the other selects the least favorable model from an ambiguity set of possible models centered around the nominal one. To characterize a closed-form expression for the conditional expectation characterizing the estimator, we approximate the center of this ambiguity set by means of a sigma point approximation. Furthermore, since the least favorable model is generally nonlinear and non-Gaussian, we derive a simulator based on a Markov chain Monte Carlo method to generate data from such model. Finally, some numerical examples show that the proposed filter outperforms the existing filters. 

## I. INTRODUCTION 

Nonlinear state estimation for discrete-time stochastic systems has been extensively studied over the past decades. A classical approach is to linearize the model, leading to the extended Kalman filter (EKF) [1]. However, this filter performs well only for mild nonlinearities due to its crude approximation based on the first-order Taylor series expansion. As systems become more complex and exhibit stronger nonlinearities, an alternative class of nonlinear filters that strikes a balance between efficiency and accuracy is the family of sigma point Kalman filters [2], including the unscented Kalman filter (UKF) [3], the cubature Kalman filter (CKF) [4], and the Gauss-Hermite Kalman filter [5], [6]. 

These standard nonlinear filters may perform poorly in the presence of model uncertainty. Existing robust sigma point Kalman filters are typically designed to handle outliers [7], [8]. In many scenarios, however, model uncertainty may also stem from imprecisely known model 

S. Yi and M. Zorzi are with the Department of Information Engineering, University of Padova, Via Gradenigo 6/B, 35131 Padova, Italy; Emails: shenglun@dei.unipd.it, zorzimat@dei.unipd.it, 

June 13, 2025 

DRAFT 

2 

parameters, non-standard noise characteristics, or sensor drifts. In the linear setting, a wellestablished paradigm to tackle such robust estimation problem is to consider a dynamic minimax game [9]–[15]: one player, i.e. the state estimator, seeks to minimize the estimation error, while the other selects the least favorable model within a prescribed ambiguity set. The latter is represented as a ball centered at the nominal model, with its radius capturing the level of uncertainty. However, these robust filters are fundamentally limited to linear state space models, as the state estimator - characterized by a conditional expectation - admits a closed-form expression, which enables an explicit solution to the minimax game. In the nonlinear setting, one possible approach is to consider the robust EKF proposed in [16]. However, similar to the standard EKF, its effectiveness is limited to scenarios with only mild nonlinearities. On the other hand, robust extensions using more accurate approximations, such as those in sigma point Kalman filtering, are far from trivial, as they retain nonlinear transformations instead of relying on local linear approximations, differing from the linear Kalman filter framework. 

The contribution of this paper is to derive a robust nonlinear estimation approach within the minimax framework that can be applied to relatively strong nonlinear systems. Drawing inspiration from the standard sigma point Kalman filter, we approximate the center of the ambiguity set by means of a sigma point approximation to transformations of Gaussian random variables. Our analysis shows that this approximation enables the characterization of a closedform expression for the conditional expectation characterizing the state estimator in the nonlinear setup, thereby breaking the deadlock between the two adversarial players in the minimax game. Moreover, thanks to this closed-form expression of the approximate minimizer, it becomes possible to identify its adversarial player, i.e. the probability density of the least favorable model. However, since the latter is generally nonlinear and non-Gaussian, finding a state space representation of it is extremely difficult. Thus, to generate data from this model, we develop a Markov chain Monte Carlo (MCMC)-based simulator that relies on a Markov chain which converges to the target density. In this paper, we propose two setups to capture the “mismatch” between the actual and nominal models by considering two types of ambiguity sets: one in which uncertainty is distributed across both the process and measurement equations, leading to a robust estimator named prediction resilient filter; and another with uncertainty confined to the measurement equations, resulting in a robust estimator called update resilient filter. The numerical results show that, for each dataset generated from a specific least favorable model, the optimal filter is the one designed for that particular model. In addition, the proposed robust 

June 13, 2025 

DRAFT 

3 

filters outperform the standard nonlinear filters even when the data are not generated from the corresponding least favorable model. Finally, we consider a state estimation problem for a massspring system with imprecisely known model parameters. The numerical experiments indicate that the proposed robust approaches significantly outperform the existing filters. 

The outline of the paper is as follows. In Section II we introduce the problem formulation. In Section III we derive the prediction resilient filter and its corresponding least favorable model. In Section IV we develop an MCMC-based simulator for the least favorable model. Section V presents the update resilient counterpart. In Section VI we provide the numerical examples. Finally, in Section VII we draw the conclusions. 

_Notation._ [0 _, N_ ]Z denotes the interval of integers between 0 and _N_ . _z ∼ f_ ( _z_ ) means that the random vector _z_ is distributed according to the probability density _f_ ( _z_ ); _f_ ( _z_ ) = _N_ ( _µ, P_ ) means that the probability density _f_ ( _z_ ) is Gaussian with mean _µ_ and covariance matrix _P_ . Given a symmetric matrix _P_ , _P >_ 0 and _P ≥_ 0 mean that _P_ is positive definite and semi-definite, respectively. Moreover, _|P |_ and tr( _P_ ) denote the determinant and the trace of _P_ ; _In_ denotes the identity matrix of dimension _n_ ; _A[⊤]_ denote the transpose of matrix _A_ . 

**==> picture [148 x 9] intentionally omitted <==**

We consider the nominal discrete-time nonlinear state space model: 

**==> picture [290 x 44] intentionally omitted <==**

where _xt ∈_ R _[n]_ is the state, _yt ∈_ R _[m]_ is the observation, _vt ∈_ R _[n]_[+] _[m]_ is white Gaussian noise (WGN) with covariance matrix equal to _In_ + _m_ , _x_ 0 is Gaussian distributed. Matrices _B ∈_ R _[n][×]_[(] _[n]_[+] _[m]_[)] and _D ∈_ R _[m][×]_[(] _[n]_[+] _[m]_[)] are full row rank and such that _BD[⊤]_ = 0. In plain words, the noise processes _Bvt_ and _Dvt_ are assumed independent. We make the mild assumption that _f_ : R _[n] →_ R _[n]_ and _h_ : R _[n] →_ R _[m]_ are bounded functions in any compact set in R _[n]_ . Moreover, we assume that _vt_ is independent from the initial state _x_ 0. 

Our aim is to develop a general approach for sigma point Kalman filtering in the case the actual model is unknown and different from the nominal one in (1). More precisely, our framework relies on a dynamic minimax game composed by two players: one player, i.e. the state estimator, minimizes the variance of the state estimation error, while the other one, i.e. the nature, selects the least favorable model belonging to a set of possible models about the nominal model (1). The latter is called ambiguity set. In what follows, we will consider two different setups: 

June 13, 2025 

DRAFT 

4 

- **Prediction resilient filtering.** The ambiguity set contains models for which the uncertainty is both in the state and the measurement equations, while the minimizer is the one-step ahead predictor of _xt_ +1 given _Yt_ := _{ys, s ≤ t}_ . 

- **Update resilient filtering.** The ambiguity set contains models for which the uncertainty is only in the measurement equations, while the minimizer is the a posteriori state estimator, i.e. the estimator of _xt_ given _Yt_ . 

Throughout the paper, to ease the exposition, we will consider the case in which the nonlinear model (1) is time-invariant and autonomous, i.e. there is no exogenous input _ut_ . However, the results we present can be straightforwardly extended to the time-varying case where _ft_ ( _xt, ut_ ) and _ht_ ( _xt, ut_ ) depend on an input _ut_ which may be a function of the strict past of the observations. 

## III. PREDICTION RESILIENT FILTERING 

We assume that the uncertainty is in both the state and measurement equations. Before to introduce our robust filtering approach, we have to characterize the approximate conditional density which defines the state predictor in the standard sigma point Kalman filter. 

## _A. Revisited sigma point Kalman filter_ 

Let _pt_ ( _zt|Yt−_ 1) denote the conditional density of _zt_ := [ _x[⊤] t_ +1 _[y] t[⊤]_[]] _[⊤]_[given] _[Y][t][−]_[1][according][to] model (1). We want to characterize the sigma point Kalman filter only in terms of its predictor, i.e. ¯ we have to find the approximation _pt_ ( _zt|Yt−_ 1) of _pt_ ( _zt|Yt−_ 1) used in the sigma point Kalman filter. Note that, the standard derivation of the sigma point Kalman filter requires approximations in both the prediction and update stages [2]. Here, instead, we want to translate all these approximations ¯ only at the prediction stage through _pt_ ( _zt|Yt−_ 1). We assume that 

**==> picture [299 x 16] intentionally omitted <==**

with 

**==> picture [355 x 44] intentionally omitted <==**

and we make the following approximation: 

**==> picture [296 x 14] intentionally omitted <==**

where _x_ ˆ _t_ and _Pt_ denotes the one-step ahead predictor of _xt_ and the covariance matrix of its prediction error, respectively. Next, we introduce the definition of sigma points, which is needed 

June 13, 2025 

DRAFT 

5 

to compute an approximation of the conditional expectation of a nonlinear transformation of a Gaussian random vector. 

**Definition 1.** _Given a random variable x ∼N_ (ˆ _x, P_ ) _, we denote its sigma points as X[i]_ = _σi_ (ˆ _x, P_ ) _, with i_ = 1 _, . . . , p, and the corresponding weights for the mean and the covariance matrix are denoted by Wm[i][and][W][ i] c[≥]_[0] _[.]_ 

There are many ways to define the sigma points and the weights ( see [2, Sec. 5-7]). Different choices result in various nonlinear Kalman filters, among which the most popular are: 

- **Unscented Kalman filter (UKF).** The sigma points are obtained through the unscented transformation: 

**==> picture [237 x 55] intentionally omitted <==**

where ( _√P_ ) _i ∈_ R _[n]_ is the _i_ -th column of _√P_ which is a square root matrix of _P_ . The corresponding weights are 

**==> picture [349 x 36] intentionally omitted <==**

where _λ_ = _a_[2] ( _κ_ + _n_ ) _− n_ , and the parameters _a_ , _b_ and _κ_ can be chosen as suggested in [17]. 

- **Cubature Kalman filter (CKF).** The sigma points are generated using the spherical cubature transformation: 

**==> picture [245 x 44] intentionally omitted <==**

and the corresponding weights are _Wc[i]_[=] _[ W][ i] m_[= 1] _[/]_[2] _[n]_[.] 

- **Gauss-Hermite Kalman filter.** The sigma points are generated by the Gauss-Hermite moment transformation 

**==> picture [179 x 16] intentionally omitted <==**

where _λ[i] ∈_ R _[n]_ is the _i−_ th vector of the set formed by the _n−_ dimensional Cartesian products of the roots, say _νk_ with _k_ = 1 _, . . . , q_ , of the Hermite polynomial of order _q_ , say _Hq_ ( _ν_ ). The corresponding weights _Wm[i]_[=] _[ W][ i] c_[are][formed][as][the][products][of][the] _[n]_[terms] 

**==> picture [76 x 31] intentionally omitted <==**

June 13, 2025 

DRAFT 

6 

**==> picture [217 x 82] intentionally omitted <==**

**----- Start of picture text -----**<br>
20<br>15 UKF<br>UTF<br>10<br>5<br>0<br>0 5 10 15 20 25 30 35 40 45 50<br>**----- End of picture text -----**<br>


Fig. 1: State prediction using the standard UKF (red line) and UTF (blue line). 

where _λ[i]_[with] _[k]_[= 1] _[, . . . , n]_[,][denotes][the] _[k]_[-th][element][of] _[λ][i]_[.] _k_[,] 

In view of (4), we define the sigma points 

**==> picture [307 x 14] intentionally omitted <==**

Therefore, in view of (1), we obtain 

**==> picture [350 x 34] intentionally omitted <==**

and 

**==> picture [363 x 99] intentionally omitted <==**

Such approximation is the desired one if the one-step ahead predictor of _xt_ +1 based on the conditional density (2), i.e. the one obtained performing the recursion 

**==> picture [331 x 41] intentionally omitted <==**

coincides with the one obtained with the standard sigma point Kalman filter. 

## **Example 1.** _Consider the nonlinear state space model:_ 

**==> picture [308 x 59] intentionally omitted <==**

_where B_ = [0 _._ 5 0] _, D_ = [0 0 _._ 1] _and x_ 0 _∼N_ (0 _._ 1 _,_ 2) _. We consider the unscented transformation to generate the sigma points and weights with a_ = 0 _._ 5 _, b_ = 2 _and κ_ = 2 _. Thus, the corresponding_ 

June 13, 2025 

DRAFT 

7 

_sigma point Kalman filter is UKF. Moreover, we refer to the corresponding estimator based on_ ¯ _the recursion (9)-(10), with mt and K_[¯] _t defined in (7) and (8), as unscented transformation filter (UTF). The predictions of UKF and UTF obtained from one realization of (11) are depicted in Figure 1. As we can see, these estimators are different and thus this approximate conditional density is not the one we are looking for. Indeed, while the sigma point Kalman filter generates sigma points in two stages (one in the update stage and another one in the prediction stage), in the recursion (9)-(10) we generate the sigma points only once through_ (6) _._ 

To understand how to construct the approximate conditional density in (2), we recall how the sigma point Kalman filter constructs the prediction pair (ˆ _xt_ +1 _, Pt_ +1) from (ˆ _xt, Pt_ ). First, by the approximation in (4), the updated pair is obtained as 

**==> picture [243 x 15] intentionally omitted <==**

where 

**==> picture [211 x 34] intentionally omitted <==**

is the filter gain; _myt_ and _Kyt_ are defined as _m_ ¯ _yt_ in (7) and _K_[¯] _yt_ in (8), respectively, where the sigma points _Xt[i]_[are][defined][as][before.][Then,][the][updated][sigma][points][are][defined][as] 

**==> picture [182 x 17] intentionally omitted <==**

The prediction pair at time _t_ + 1 is given by: 

**==> picture [348 x 64] intentionally omitted <==**

Finally, the prediction pair (ˆ _xt_ +1 _, Pt_ +1) will be used in the next time step through the approximation _pt_ ( _xt_ +1 _|Yt_ ) _≃N_ (ˆ _xt_ +1 _, Pt_ +1). It is worth noticing that the prediction pair (ˆ _xt_ +1 _, Pt_ +1) depends on the updated pair in a nonlinear way. Therefore, it is not straightforward to connect (ˆ _xt, Pt_ ) to (ˆ _xt_ +1 _, Pt_ +1) without considering the posterior density of the current state, i.e. _pt_ ( _xt|Yt_ ) _≃_ (ˆ _xt|t, Pt|t_ ), unlike in the extended Kalman filter (EKF), where this connection is more direct due to the linear approximation. The next result characterizes the approximation on the conditional density of _zt_ given _Yt−_ 1 induced by the standard sigma point Kalman filter we are looking for. 

June 13, 2025 

DRAFT 

8 

**Proposition 1.** _Given the approximation pt_ ( _xt|Yt−_ 1) _≃N_ (ˆ _µ, P_ ) _for the a priori density and the observation yt, consider the conditional density (2) with_ 

**==> picture [364 x 190] intentionally omitted <==**

_where_ 

**==> picture [226 x 100] intentionally omitted <==**

_Let_ (ˆ _xt, Pt_ ) _be the prediction pair at stage t obtained by the sigma point Kalman filter. If we_ ˆ ˆ _take µ_ = _xt and P_ = _Pt, the one-step ahead predictor of xt_ +1 _based on the conditional density (2) coincides with the one of the sigma point Kalman filter at stage t_ + 1 _._ 

_Proof:_ By (16) and (14), the conditional mean of _xt_ +1 given _Yt_ under (2) is 

**==> picture [227 x 119] intentionally omitted <==**

ˆ The latter coincides with the sigma point Kalman predictor _xt_ +1 in (12) because _δ[i]_ = _X_[ˆ] _t[i]_ +1[and] ˆ ∆= _Lt_ due to the fact that _µ_ = _xt_ and _P_ = _Pt_ . Finally, by (17) we have that the covariance 

June 13, 2025 

DRAFT 

9 

ˆ matrix of the prediction error _xt_ +1 _− xt_ +1 = _xt_ +1 _− ξ_ is 

**==> picture [274 x 64] intentionally omitted <==**

which coincides with the covariance matrix _Pt_ +1 in (13) of the sigma point Kalman filter. 

In plain words, Proposition 1 asserts that it is always possible to characterize the sigma point Kalman filter only in terms of the prediction, i.e. through recursions (9)-(10), and the ¯ corresponding approximate density _pt_ ( _zt|Yt−_ 1) is characterized in an explicit way by the nonlinear transformation outlined in (14)-(18). 

## _B. Robust filtering approach_ 

**==> picture [469 x 80] intentionally omitted <==**

_p_ 0( _x_ 0) = _N_ (ˆ _x_ 0 _, P_[˜] 0) denotes the density of _x_ 0, _ϕt_ ( _zt|xt_ ) = _N_ ( _µt, R_ ) is the conditional density of _zt_ := [ _x[⊤] t_ +1 _[y] t[⊤]_[]] _[⊤]_[given] _[x][t]_[with] 

**==> picture [344 x 44] intentionally omitted <==**

We assume that the (unknown) actual density of _ZN_ takes the form 

**==> picture [146 x 35] intentionally omitted <==**

where _ϕ_[˜] _t_ ( _zt|xt_ ) is the actual conditional density of _zt_ given _xt_ . We measure the deviation between the actual and the nominal model at time _t_ by the conditional Kullback–Leibler (KL) divergence: 

**==> picture [262 x 31] intentionally omitted <==**

˜ where _pt_ ( _xt|Yt−_ 1) denotes the actual _a priori_ conditional density of _xt_ given _Yt−_ 1. Therefore, we assume that _ϕ_[˜] _t_ belongs to the following convex ambiguity set: 

**==> picture [311 x 23] intentionally omitted <==**

June 13, 2025 

DRAFT 

10 

where _ct ≥_ 0 is called tolerance. Notice that, _Bt_ places an upper bound on model uncertainty at each time step, ensuring that uncertainty is not concentrated on specific time steps where the estimator is more vulnerable. The robust estimation problem is then characterized by the following dynamic minimax game: 

**==> picture [317 x 23] intentionally omitted <==**

where 

**==> picture [375 x 23] intentionally omitted <==**

_Gt_ denotes the class of estimators with finite second-order moments with respect to _ϕ_[˜] _t ∈Bt_ . Finally, _ϕ_[˜] _t_ must satisfy the constraint: 

**==> picture [326 x 27] intentionally omitted <==**

Notice that, the objective function _Jt_ in (23) is linear in _ϕ_[˜] _t_ for a fixed _gt ∈Gt_ , while it is convex in _gt_ for a fixed _ϕ_[˜] _t ∈Bt_ . Hence, in view of the Von Neumann’s minimax theorem, there exists a saddle point ( _ϕ_[˜] _[⋆] t[,][g] t[⋆]_[)][such][that] 

**==> picture [186 x 15] intentionally omitted <==**

since the corresponding sets _Bt_ and _Gt_ are convex and compact. The next result characterizes the structure of the maximizer of (22), i.e. the least favorable model. 

**Proposition 2.** _For a fixed estimator gt ∈Gt, the density ϕ_[˜] _[⋆] t[that][maximizes][(23)][under][the] constraints ϕ_[˜] _t ∈Bt and (24) is as follows:_ 

**==> picture [362 x 30] intentionally omitted <==**

_where θt >_ 0 _is the unique solution to D_ ( _ϕ_[˜] _[⋆] t[, ϕ][t]_[) =] _[ c][t][,][and][the][normalizing][constant][is][given][by:]_ 

**==> picture [286 x 30] intentionally omitted <==**

_Proof:_ The proof follows the same line of reasoning as in [9, Lemma 1], although the authors there considered only the simple linear state space case and did not realize that their argument extends to more general settings. Since linearity is not used in the derivation, the same reasoning applies to the nonlinear case addressed here. 

June 13, 2025 

DRAFT 

11 

Let 

**==> picture [367 x 118] intentionally omitted <==**

be the marginal densities corresponding to _ϕt_ and _ϕ_[˜] _[⋆] t_[.][From][(25)][we][obtain] 

It is not difficult to see that 

**==> picture [143 x 16] intentionally omitted <==**

where _DKL_ (˜ _pt, pt_ ) denotes Kullback-Leibler (KL) divergence [18] between the probability density functions _p_ ˜ _t_ and _pt_ . Let 

**==> picture [198 x 15] intentionally omitted <==**

˜ be the ambiguity set for the density _pt_ ( _zt|Yt−_ 1) with tolerance _ct_ and centered about the pseudonominal density _pt_ ( _zt|Yt−_ 1). Then, the dynamic minimax game in (22) is equivalent to the game: 

**==> picture [281 x 22] intentionally omitted <==**

where the corresponding objective function is now given by: 

**==> picture [236 x 28] intentionally omitted <==**

However, due to the nonlinearity of the nominal model in (1), the pseudo-nominal density _pt_ ( _zt|Yt−_ 1) in (26) does not follow a Gaussian distribution even in the case the a priori den˜ sity _pt_ ( _xt|Yt−_ 1) is Gaussian. Thus, characterizing the solution to the minimax problem (27) is extremely challenging. To tackle this problem, we approximate the pseudo-nominal density ¯ _pt_ ( _zt|Yt−_ 1) with _pt_ ( _zt|Yt−_ 1). The latter is obtained using the same approximation induced by the sigma point Kalman filter. More precisely, _p_ ¯ _t_ ( _zt|Yt−_ 1) = _N_ ( ¯ _mt, K_[¯] _t_ ) where _m_ ¯ _t_ , _K_[¯] _t_ are partitioned as in (3) and their blocks are defined as in Proposition 1 using the approximation ˜ _pt_ ( _xt|Yt−_ 1) _≃N_ (ˆ _xt, P_[˜] _t_ ) for the a priori least favorable density. Thus, the resulting approximate minimax problem is 

**==> picture [306 x 23] intentionally omitted <==**

June 13, 2025 

DRAFT 

12 

where 

**==> picture [341 x 14] intentionally omitted <==**

In plain words, the unique difference between the original problem (27) and the approximate one (28) regards the center of (the ball describing) the ambiguity set. 

**Theorem 1.** _Let_ (ˆ _xt, P_[˜] _t_ ) _be the prediction pair at time t such that P_[˜] _t >_ 0 _. The robust estimator solving the minimax problem (28) is_ 

**==> picture [284 x 34] intentionally omitted <==**

_where_ 

**==> picture [366 x 164] intentionally omitted <==**

_The nominal covariance matrix of the corresponding prediction error is_ 

**==> picture [348 x 29] intentionally omitted <==**

_while the least favorable one is_ 

**==> picture [292 x 16] intentionally omitted <==**

_The risk sensitivity parameter θt >_ 0 _is the unique solution to γ_ ( _Pt_ +1 _, θt_ ) = _ct with_ 

**==> picture [371 x 26] intentionally omitted <==**

_Finally, the least favorable a priori density at the next stage is_ 

**==> picture [306 x 15] intentionally omitted <==**

_with P_[˜] _t_ +1 _>_ 0 _._ 

June 13, 2025 

DRAFT 

13 

¯ ˆ _Proof:_ The density _pt_ ( _zt|Yt−_ 1) = _N_ ( ¯ _mt, K_[¯] _t_ ) is defined as in Proposition 1 with _µ_ = _xt_ and _P_ = _P_[˜] _t_ , thus _γ[i]_ and _δ[i]_ are defined as in (31) and (32) with ∆= _Lt_ and _m_ ¯ _yt_ = _myt_ . In view of (30)-(34), we have 

**==> picture [371 x 90] intentionally omitted <==**

where _K_[¯] _yt_ = _Kyt_ . Moreover, 

and in view of (30) 

**==> picture [262 x 60] intentionally omitted <==**

Notice that, _K_[¯] _t >_ 0, indeed _K_[¯] _yt ≥ DD[⊤] >_ 0 and the Schur complement of the block _K_[¯] _yt_ of _K_ ¯ _t_ is 

**==> picture [286 x 34] intentionally omitted <==**

¯ Since _pt_ ( _zt|Yt−_ 1) = _N_ ( ¯ _mt, K_[¯] _t_ ), with _K_[¯] _t >_ 0, by [13, Theorem 1] if follows that: i) the minimizer of (28) is 

**==> picture [152 x 16] intentionally omitted <==**

which coincides with _x_ ˆ _t_ +1 defined in (30); ii) the maximizer of (28) is _N_ ( ¯ _mt, K_[˜] _t_ ) where 

**==> picture [316 x 44] intentionally omitted <==**

and _K_[˜] _xt_ +1 := _P_[˜] _t_ +1 + _K_[¯] _xt_ +1 _ytK_[¯] _y[−] t_[1] _[K]_[¯] _x[⊤] t_ +1 _yt_[;][the][least][favorable][covariance][matrix][of][the][prediction] error is (37). Since the minimax problem in (28) approximates (27), then we have (39). 

The resulting prediction resilient filter is outlined in Algorithm 1 where it also includes the update stage defining _Kxtyt_ , _x_ ˆ _t|t_ , _Pt|t_ and _Xt[i] |t_[. Note that, the computation of] _[ θ][t]_[in Step 12 can be] efficiently computed through a bisection method, see [19]. Finally, in the limit case _ct_ = 0, i.e. the absence of model uncertainty at time _t_ , we have that _θt_ = 0 and thus the prediction resilient 

June 13, 2025 

DRAFT 

14 

filter coincides with the standard sigma point Kalman filter. It is also worth noting that (39) in Theorem 1 represents an approximation of the least favorable a priori density. Since the latter is Gaussian, at the next step it is legitimate to consider the sigma points corresponding to to it (as it happens in the standard sigma point Kalman filter). 

In view of Proposition 2, we have that the approximate maximizer takes the following form: 

**==> picture [359 x 29] intentionally omitted <==**

ˆ where _xt_ +1 and _θt_ are the state predictor and the risk sensitivity parameter obtained by the prediction resilient filter. Moreover, 

**==> picture [280 x 30] intentionally omitted <==**

Therefore, (ˆ _xt_ +1 _, ϕ_[˜][0] _t_[)][represents][an][approximate][solution][to][Problem][(22)][in][the][sense][that:] 

**==> picture [262 x 15] intentionally omitted <==**

for any _ϕ_[˜] _t ∈Bt_ and _gt ∈Gt_ . Note that, the first of the above inequalities follows from Proposition 2. Thus, the approximate least favorable model over the finite time interval [0 _, N_ ]Z takes the form: 

**==> picture [309 x 35] intentionally omitted <==**

where the symbol _∝_ means proportional to. In what follows, we will simply refer to (43) as least favorable model without specifying that it is an approximation. 

## IV. SIMULATOR FOR THE LEAST FAVORABLE MODEL 

In order to assess the performance of the prediction resilient filter in the least favorable scenario, we need to develop a simulator for generating random samples from the least favorable density (43). In the linear setup, it was shown that the least favorable model admits a state space realization over a finite time interval, [9, Section 5], [20]. Such result, however, cannot be exploited in this nonlinear setting. Indeed, a fundamental aspect in the linear setup is that the least favorable density is Gaussian, but the least favorable density in (43) is not Gaussian in general. Thus, it is not straightforward to draw samples from (43). Markov chain Monte Carlo (MCMC) algorithms are effective techniques for approximately sampling from complex probability densities in high-dimensional spaces. Thus, we use the Metropolis-Hastings (MH) algorithm [21] in order to tackle the problem. Our target density is _p_ ˜[0] ( _ZN_ ), defined in (43). 

June 13, 2025 

DRAFT 

15 

**Algorithm 1** Prediction resilient filter at time _t_ 

**Input** _x_ ˆ _t_ , _P_[˜] _t_ , _ct_ , _yt_ **Output** _x_ ˆ _t_ +1, _P_[˜] _t_ +1, _θt_ 

1: _Xt[i]_[=] _[ σ][i]_[(ˆ] _[x][t][,][P]_[˜] _[t]_[)] _[,] i_ = 1 _. . . p_ 2: _myt_ =[�] _[p] i_ =1 _[W][ i] m[h]_[(] _[X][ i] t_[)] 3: _Kyt_ =[�] _[p] i_ =1 _[W][ i] c_[(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)] _[⊤]_[+] _[ DD][⊤]_ 4: _Kxtyt_ =[�] _[p] i_ =1 _[W][ i] c_[(] _[X][ i] t[−][x]_[ˆ] _[t]_[)(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)] _[⊤]_ 5: _Lt_ = _KxtytKy[−] t_[1] ˆ ˆ 6: _xt|t_ = _xt_ + _Lt_ ( _yt − myt_ ) 7: _Pt|t_ = _P_[˜] _t − LtKytL[⊤] t_ 8: _Xt[i] |t_[=] _[ σ][i]_[(ˆ] _[x][t][|][t][, P][t][|][t]_[)] _[,] i_ = 1 _. . . p_ ˆ 9: _Xt[i]_ +1[=] _[ f]_[(] _[X][ i] t|t_[)] _[,] i_ = 1 _. . . p_ ˆ 10: _xt_ +1 =[�] _[p] i_ =1 _[W][ i] mX_[ˆ] _t[i]_ +1 11: _Pt_ +1 =[�] _[p] i_ =1 _[W][ i] c_[(] _X_[ˆ] _t[i]_ +1 _[−][x]_[ˆ] _[t]_[+1][)(] _X_[ˆ] _t[i]_ +1 _[−][x]_[ˆ] _[t]_[+1][)] _[⊤]_[+] _[ BB][⊤]_ 12: Find _θt_ s.t. _γ_ ( _Pt_ +1 _, θt_ ) = _ct_ 13: _P_ ˜ _t_ +1 = ( _Pt[−]_ +1[1] _[−][θ][t][I]_[)] _[−]_[1] 

Suppose it is easy to generate a random sample from a proposal probability density _q_ ¯( _ZN |YN[k]_[)] where _YN[k]_[is][the][subvector][of] _[Z] N[k]_[containing only][the observations. We][consider the MH][scheme] outlined in Algorithm 2 which provides samples of _ZN_ , following the target _p_ ˜[0] generated by the ¯ proposal _q_ . 

**Remark 1.** _It is worth noting that both the target and proposal densities are formed as products of multiple probability density functions, each of which includes the density of x_ 0 _. Since we know how to draw samples from x_ 0 _(recall that x_ 0 _is Gaussian distributed), we can consider_ 

**==> picture [295 x 35] intentionally omitted <==**

_in place of the target density. Indeed, the latter is only used to compute the acceptance ratio:_ 

**==> picture [186 x 31] intentionally omitted <==**

_where q_ ( _ZN[k][|][Y][N]_[)][:=] _[q]_[¯][(] _[Z] N[k][|][Y][N]_[)] _[/p]_[0][(] _[x]_[0][)] _[.][Henceforth,][with][some][abuse][of][terminology,][we][will] refer to (44) as the target density._ 

June 13, 2025 

DRAFT 

16 

## **Algorithm 2** MH scheme for the simulator 

- 1: Generate _ZN_[0][from][the][nominal][model][(1)] 

- 2: **for** _k ≥_ 0 **do** 

3: Draw _ZN_ from _q_ ¯( _ZN | YN[k]_[)][with] _[Y] N[k]_[observations] extracted from _ZN[k]_ 

- 4: Compute the acceptance ratio 

**==> picture [166 x 30] intentionally omitted <==**

with _YN_ observations extracted from _ZN_ 

5: Draw _uk_ from _U_ [0 _,_ 1] 

- 6: **if** _uk ≤ αk_ **then** 

**==> picture [105 x 34] intentionally omitted <==**

9: **end if** 

- 10: **end for** 

Next, we introduce the proposal density _q_ ¯( _ZN |YN[k]_[)][,][as][well][as][how][to][evaluate] _[π]_[(] _[Z][N]_[)][and] _q_ ( _ZN |YN[k]_[)][.] 

## _A. Proposal density_ 

We construct the proposal density relying on the least favorable state space model in [9, Section 5] derived for the linear case. More precisely, given the observations _YN[k]_[,][we][can][compute] _[x]_[ˆ] _[t][|][t]_[,] _x_ ˆ _t_ +1, _Lt_ and _θt_ , with _t ∈_ [0 _, N_ ]Z, using the prediction resilient filter. Then, we linearize the nominal nonlinear model (1) along the state trajectories estimated by the prediction resilient filter: 

**==> picture [329 x 34] intentionally omitted <==**

where _At_ and _Ct_ are the Jacobian matrices: 

**==> picture [336 x 34] intentionally omitted <==**

It is worth noting that, the Jacobian matrices may not exist, since _f_ and _h_ are not necessarily differentiable functions. In such cases, the Jacobian can be defined numerically using a simple 

June 13, 2025 

DRAFT 

17 

finite difference method. Such approximation is tolerable since the proposal density is merely an approximation of the target one. The least favorable model over the time interval [0 _, N_ ]Z corresponding to the ambiguity set about the linearized model (45) and with tolerance sequence _{ct, t ∈_ [0 _, N_ ]Z _}_ is given by using the result in [9, Section 5]: 

**==> picture [297 x 34] intentionally omitted <==**

where _εt_ is WGN with covariance matrix _In_ + _m_ , 

**==> picture [266 x 249] intentionally omitted <==**

_Gt_ is the Kalman prediction gain and _Ft_ is the Cholesky factor of _Ot_ , i.e. _Ot_ = _FtFt[⊤][.]_[ Moreover,] Ω _t_ is computed by the backward propagation: 

**==> picture [256 x 51] intentionally omitted <==**

with Ω _[−]_[1][Notice][that][we][can][rewrite][(47)][as] _N_ +1[= 0] _[.]_ 

**==> picture [325 x 34] intentionally omitted <==**

June 13, 2025 

DRAFT 

18 

where _et_ is independent from _εt_ and it is Gaussian distributed with zero mean and covariance matrix Π _et_ . The latter is the _n × n_ matrix obtained by the last _n_ columns and rows of Π _t_ which is the solution to the Lyapunov equation: 

**==> picture [276 x 97] intentionally omitted <==**

Therefore, model (48) is characterized by the transition density of _zt_ given _xt_ and _YN[k]_[which][is] Gaussian with mean and covariance matrix 

**==> picture [220 x 92] intentionally omitted <==**

However, our aim is to develop a proposal density that effectively captures the essential characteristics of the target density. Notice that, the prediction resilient filter computes the Kalman filtering gain trajectory from _YN[k]_[.][Thus,][a][refined][version][of][model][(48)][is][the][one][in][which][we] use the Kalman prediction gain 

**==> picture [56 x 12] intentionally omitted <==**

where _Lt_ is the Kalman filtering gain obtained by Algorithm 1. Moreover, the two subvectors of _µ[L] t_[represent][the][first][order][Taylor][expansion][of] _[f]_[(] _[x][t]_[)][and] _[h]_[(] _[x][t]_[)][around] _[x]_[ˆ] _[t][|][t]_[and] _[x]_[ˆ] _[t]_[,][respectively.] Then, a refined version of (48) is the one in which _µ[L] t_[is][replaced][by] 

**==> picture [74 x 44] intentionally omitted <==**

The corresponding “proposal” state space model is 

**==> picture [315 x 34] intentionally omitted <==**

and the corresponding proposal density takes the form 

**==> picture [184 x 35] intentionally omitted <==**

June 13, 2025 

DRAFT 

19 

with _x_ 0 _∼N_ (ˆ _x_ 0 _, P_[˜] 0) and 

**==> picture [301 x 15] intentionally omitted <==**

To sum up, the state space model (49) is constructed as follows: first, given the observations _YN[k]_[,][we][perform][a][forward][sweep][to][compute] _[x]_[ˆ] _[t][|][t]_[,] _[x]_[ˆ] _[t]_[+1][,] _[L][t]_[and] _[θ][t]_[by][means][of][the][prediction] resilient filter, then we perform a backward sweep to compute Ω _[−] t_[1] and finally we perform a forward sweep to compute the matrices characterizing the state space model. In this respect, it is easy to draw a proposal sample _ZN[k]_[from][the][state][space][model][(49).][Finally,][in][view][of][Remark] 1, we only need to evaluate 

**==> picture [315 x 35] intentionally omitted <==**

Accordingly, in view of (50) and (51), we obtain 

**==> picture [232 x 35] intentionally omitted <==**

where _M_[¯] _t_ = ~~�~~ (2 _π_ ) _[n]_[+] _[m] |Rt[L][|][.]_ 

## _B. Target density_ 

In view of (42) and (44), we obtain 

**==> picture [268 x 77] intentionally omitted <==**

where we ignore the normalizing constant; _µt_ and _R_ have been defined in (20); _θt_ , _x_ ˆ _t_ +1 are computed through the prediction resilient filter using _YN_ . Then, we have 

**==> picture [353 x 52] intentionally omitted <==**

where we explicitly highlight the dependence on _yt_ for the robust predictor, whose expression is given in the proof of Theorem 1, i.e. 

**==> picture [339 x 15] intentionally omitted <==**

¯ and _mxt_ +1, _K_[¯] _xt_ +1 _yt_ , _K_[¯] _y[−] t_[1][,] _[m]_[¯] _[y] t_[are][obtained][by] _[Y][N]_[.][Moreover,][we][have] _[p]_[˜] _[t]_[(] _[x][t][|][Y][t][−]_[1][)] _[ ≃N]_[(ˆ] _[x][t][,][P]_[˜] _[t]_[)] where _x_ ˆ _t_ and _P_[˜] _t_ are computed through the prediction resilient filter using _YN_ . It is worth noting 

June 13, 2025 

DRAFT 

20 

that it is not possible to find a closed form expression for (52) because of the presence of _ϕt_ ( _zt|xt_ ), i.e. its mean _µt_ is a nonlinear function of _xt_ . Then, an approximation of _Mt_ can be obtained through Monte Carlo integration: 

where 

**==> picture [362 x 82] intentionally omitted <==**

_x_[1] _t[. . . x][r] t_[are][sampled][from] _[p]_[˜] _[t]_[(] _[x][t][|][Y][t][−]_[1][)][and] _[r][∈]_[N][is][taken][large][enough.][Substituting][(53)][into] expression (54), we obtain 

**==> picture [262 x 65] intentionally omitted <==**

where we have highlighted the fact that _µt_ is a function of _xt_ . Moreover, let 

_Ht_ := [ _I − K_[¯] _xt_ +1 _ytK_[¯] _y[−] t_[1][]] _[,][l][t]_[:=] _[m]_[¯] _[x] t_ +1 _[−][K]_[¯] _[x] t_ +1 _[y] t[K]_[¯] _y[−] t_[1] _[m]_[¯] _[y] t St_ := _R[−]_[1] _− θtHt[⊤][H][t][,] st_ ( _xt_ ) := _R[−]_[1] _µt_ ( _xt_ ) _− θtHt[⊤][l][t][.]_ 

Then, we obtain: 

**==> picture [287 x 255] intentionally omitted <==**

Accordingly, we have 

where 

**==> picture [298 x 41] intentionally omitted <==**

June 13, 2025 

DRAFT 

21 

It remains to design the number of samples _r_ in such a way that _M_[ˆ] _t,r_ approximates _Mt_ with a certain accuracy. First, it is not difficult to see that 

**==> picture [204 x 30] intentionally omitted <==**

where _κ_ 1 _, κ_ 2 and _T ≥_ 0 are constants not depending on _xt_ . Thus, the random variable _Nt_ ( _xt_ ), with _xt_ Gaussian random vector with mean _x_ ˆ _t_ and covariance matrix _P_[˜] _t_ , has finite variance, say _σt_[2][.][Thus,][by][the][central][limit][theorem][we][have][that] 

**==> picture [112 x 17] intentionally omitted <==**

for _r_ large and 

**==> picture [167 x 35] intentionally omitted <==**

is the sample variance estimator of _σt_[2][.][Thus,][with][a][95%][confidence][level,][it][holds][that] 

**==> picture [115 x 32] intentionally omitted <==**

and thus the following inequality approximately holds 

**==> picture [149 x 34] intentionally omitted <==**

Therefore, given the desired relative accuracy _τ[⋆]_ on the computation of _Mt_ and an initial value for _r_ , we check whether _τr ≤ τ[⋆] ._ If not, we increase _r_ until _τr ≤ τ[⋆] ._ Notice that, if we need to ˆ increase _r_ , then _σt,r_ and _M_[ˆ] _t,r_ can be updated recursively using well known formulas. 

Finally, we analyze the Markov chain corresponding to our MH algorithm. First, since _f_ and _h_ are bounded in any compact set in R _[n]_ , then the prediction resilient filter, which is needed for evaluating _p_ ˜[0] ( _ZN_ ), is well defined (in particular it does not diverge) in the finite time horizon [0 _, N_ ]Z. Thus, _p_ ˜[0] ( _ZN_ ) in (43) is well defined and is strictly positive and bounded in any compact ¯ set. Moreover, there exist _ε_ 1 _, ε_ 2 _>_ 0 such that if _∥ZN − Z_[¯] _N ∥ < ε_ 1 then _q_ ( _ZN |Z_[¯] _N_ ) _> ε_ 2. Accordingly, by [21, Conditions C1 and C2], the Markov chain converges in total variation distance to the target density _p_ ˜[0] , i.e. for every _ZN_[0][and] _[ε >]_[ 0][there][exists][an][integer] _[k][⋆]_[such][that] for every set _A_ 

**==> picture [249 x 30] intentionally omitted <==**

where **P** [ _ZN[k][∈A|][Z] N_[0][]][is][the][probability][that] _[Z] N[k][∈A]_[if][the][initial][condition][is][equal][to] _[Z] N_[0][.] 

June 13, 2025 

DRAFT 

22 

## V. UPDATE RESILIENT FILTERING 

We assume that the uncertainty is only in the measurement equations. The nominal density of _ZN_ in (19) can be written as _ϕt_ ( _zt|xt_ ) = _pt_ ( _xt_ +1 _|xt_ ) _ψt_ ( _yt|xt_ ) where 

**==> picture [313 x 41] intentionally omitted <==**

Next, we assume that the actual density takes the form 

**==> picture [210 x 35] intentionally omitted <==**

i.e. the uncertainty is only in the measurement equations described by the conditional density _ψ_[˜] _t_ . We measure the mismatch between the actual and the nominal model at time _t_ by the conditional KL divergence 

**==> picture [262 x 37] intentionally omitted <==**

˜ where _pt_ ( _xt|Yt−_ 1) is the actual a priori density of _xt_ given _Yt−_ 1. Therefore, we assume that _ψ_[˜] _t_ belongs to the ambiguity set 

**==> picture [158 x 23] intentionally omitted <==**

The robust estimation problem characterizing the estimator of _xt_ given _Yt_ is defined as 

**==> picture [318 x 23] intentionally omitted <==**

where 

**==> picture [370 x 23] intentionally omitted <==**

_Gt_ is the set of estimators with finite second order moments with respect to _ψ_[˜] _t ∈Bt_ and _ψ_[˜] _t_ satisfies the condition 

**==> picture [325 x 28] intentionally omitted <==**

Also in this case, the existence of a saddle point optimal solution ( _ψ[⋆] , g[⋆]_ ) is guaranteed since the Von Neumann minimax theorem holds. 

**Proposition 3.** _For a fixed estimator gt ∈Gt, the density ψ_[˜] _t[⋆][maximizing (57) under the constraints] ψ_ ˜ _t ∈Bt and (58) is:_ 

**==> picture [252 x 30] intentionally omitted <==**

June 13, 2025 

DRAFT 

23 

_where θt|t >_ 0 _is the unique solution to D_ ( _ψ_[˜] _t[⋆][, ψ][t]_[)][=] _[c][t][,][and][the][normalizing][constant][is][given] by_ 

**==> picture [282 x 30] intentionally omitted <==**

_Proof:_ The argument follows the same line of reasoning as in [10, Lemma 2]. While the result in [10] was established in the context of a linear state space model, the derivation does not rely on the linearity assumption. Consequently, the statement holds also in the more general setting considered here. 

It is not difficult to see that Problem (56) is equivalent to 

**==> picture [281 x 22] intentionally omitted <==**

˜ where the maximizer _pt_ ( _wt|Yt−_ 1) := _ψ_[˜] _t_ ( _yt|xt_ )˜ _pt_ ( _xt|Yt−_ 1), with _wt_ := [ _x[⊤] t[y] t[⊤]_[]] _[⊤]_[,][belongs][to][the] ambiguity set 

**==> picture [337 x 15] intentionally omitted <==**

where _pt_ ( _wt|Yt−_ 1) := _ψt_ ( _yt|xt_ )˜ _pt_ ( _xt|Yt−_ 1) and _J_[¯] _t_ (˜ _pt, gt_ ) = _Jt_ ( _ψ_[˜] _t, gt_ ). Also in this case it is not possible to characterize the solution to (59) because the pseudo-nominal density _pt_ ( _wt|Yt−_ 1) is not Gaussian. Thus, we construct an approximation of _pt_ ( _wt|Yt−_ 1) using the same mechanism exploited in the sigma point Kalman filter. More precisely, since the conditional density in (55) is not affected by uncertainty, the prediction stage can be constructed as in the standard sigma point Kalman filter. More precisely, the predictor of _xt_ and the covariance matrix of the corresponding prediction error are obtained by the sigma points corresponding ˜ to _pt−_ 1( _xt−_ 1 _|Yt−_ 1) _≃N_ (ˆ _xt−_ 1 _|t−_ 1 _, P_[˜] _t−_ 1 _|t−_ 1): 

**==> picture [341 x 98] intentionally omitted <==**

June 13, 2025 

DRAFT 

24 

¯ Then, the approximation _pt_ ( _wt|Yt−_ 1) = _N_ ( _mt, Kt_ ) is obtained by the sigma points corresponding ˜ to the approximation _pt_ ( _xt|Yt−_ 1) _≃N_ (ˆ _xt, Pt_ ): 

**==> picture [353 x 150] intentionally omitted <==**

The approximate problem is 

**==> picture [304 x 23] intentionally omitted <==**

¯ where _B_[¯] _t_ is obtained from (60) replacing _pt_ ( _wt|Yt−_ 1) with _pt_ ( _wt|Yt−_ 1). 

**Theorem 2.** _Let_ (ˆ _xt, Pt_ ) _be the prediction pair at time t such that Pt >_ 0 _. The robust estimator solution to (64) is_ 

**==> picture [317 x 16] intentionally omitted <==**

ˆ _The nominal and the least favorable covariance matrix of the estimation error xt − xt|t are_ 

**==> picture [142 x 43] intentionally omitted <==**

_where the risk sensitivity parameter θt|t >_ 0 _is the unique solution to γ_ ( _Pt|t, θt|t_ ) = _ct where γ has been defined in (38). Moreover, the least favorable a priori density at the next stage is_ 

**==> picture [306 x 14] intentionally omitted <==**

_where_ 

**==> picture [262 x 98] intentionally omitted <==**

June 13, 2025 

DRAFT 

25 

_Proof:_ First, we show that _Kt_ defined in (62) is positive definite. Let 

**==> picture [194 x 41] intentionally omitted <==**

By (63), we have that **X** _t_ = _[√] Pt_ Λ where Λ _∈_ R _[n][×][p]_ and its definition depends on the type of transformation. More precisely: Λ = _√λ_ + _n_ [ _In − In_ 0 ] _∈_ R _[n][×]_[2] _[n]_[+1] for the unscented transformation; Λ = _[√] n_ [ _In − In_ ] _∈_ R _[n][×]_[2] _[n]_ for the spherical cubature transformation; Λ = [ _λ_[1] _. . . λ[q][n]_ ] _∈_ R _[n][×][q][n]_ for the Gauss-Hermite moment transformation. It is not difficult to see that Λ _W_ Λ _[⊤]_ = _In_ where _W_ is the diagonal matrix with entries in the main diagonal _Wc_[1] _[. . . W][ p] c_[which] denote the corresponding weights. Accordingly, we have _Pt_ = **X** _tW_ **X** _[⊤] t_[,] _[ K][y] t_[=] **[ Y]** _[t][W]_ **[Y]** _[t]_[+] _[DD][⊤]_ and _Kxtyt_ = **X** _tW_ **Y** _t[⊤]_[.][Hence,] 

**==> picture [216 x 44] intentionally omitted <==**

because, by (61), **X** _tW_ **X** _[⊤] t[≥][BB][⊤][>]_[ 0][and][the][Schur][complement][of][block] **[X]** _[t][W]_ **[X]** _[⊤] t_[of] _[K][t]_[is] 

**==> picture [252 x 39] intentionally omitted <==**

¯ Since _pt_ ( _wt|Yt−_ 1) = _N_ ( _mt, Kt_ ), with _Kt >_ 0, by [13, Theorem 1] it follows that the minimizer ˜ of (59) is (65) and the least favorable density is _pt_ ( _wt|Yt−_ 1) = _N_ ( _mt, K_[˜] _t_ ) where 

**==> picture [144 x 45] intentionally omitted <==**

and _K_[˜] _xt_ = _P_[˜] _t|t − KxtytKytKx[⊤] tyt_[.][Thus,] _[p]_[˜] _[t]_[(] _[x][t][|][Y][t]_[)][is][Gaussian][and][the][approximation][in][(66)][is] obtained by considering the sigma points of _p_ ˜ _t_ ( _xt|Yt_ ). 

The corresponding update resilient filter is outlined in Algorithm 3. The difference between the prediction and update resilient filters concerns how the covariance matrix of the estimation error is propagated: in the prediction resilient filter a modified version of the prediction error covariance matrix is propagated (Step 13 in Algorithm 1), while in the update resilient filter a modified version of the update error covariance matrix is propagated (Step 9 in Algorithm 3). 

June 13, 2025 

DRAFT 

26 

**Algorithm 3** Update resilient filter at time _t_ 

**Input** _x_ ˆ _t_ , _Pt_ , _ct_ , _yt_ 

**Output** _x_ ˆ _t_ +1, _Pt_ +1 _, θt|t_ 

1: _Xt[i]_[=] _[ σ][i]_[(ˆ] _[x][t][, P][t]_[)] _[,] i_ = 1 _. . . p_ 2: _myt_ =[�] _[p] i_ =1 _[W][ i] m[h]_[(] _[X][ i] t_[)] 3: _Kyt_ =[�] _[p] i_ =1 _[W][ i] c_[(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)] _[⊤]_[+] _[ DD][⊤]_ 4: _Kxtyt_ =[�] _[p] i_ =1 _[W][ i] c_[(] _[X][ i] t[−][x]_[ˆ] _[t]_[)(] _[h]_[(] _[X][ i] t_[)] _[ −][m][y] t_[)] _[⊤]_ 5: _Lt_ = _KxtytKy[−] t_[1] 

ˆ ˆ 6: _xt|t_ = _xt_ + _Lt_ ( _yt − myt_ ) 

7: _Pt|t_ = _Pt − LtKytL[⊤] t_ 

8: Find _θt|t_ s.t. _γ_ ( _Pt|t, θt|t_ ) = _ct_ 9: _P_[˜] _t|t_ = ( _Pt[−] |t_[1] _[−][θ][t][|][t][I]_[)] _[−]_[1] 10: _Xt[i] |t_[=] _[ σ][i]_[(ˆ] _[x][t][|][t][,][P]_[˜] _[t][|][t]_[)] _[,] i_ = 1 _. . . p_ ˆ 11: _Xt[i]_ +1[=] _[ f]_[(] _[X][ i] t|t_[)] _[,] i_ = 1 _. . . p_ ˆ 12: _xt_ +1 =[�] _[p] i_ =1 _[W][ i] mX_[ˆ] _t[i]_ +1 13: _Pt_ +1 =[�] _[p] i_ =1 _[W][ i] c_[(] _X_[ˆ] _t[i]_ +1 _[−][x]_[ˆ] _[t]_[+1][)(] _X_[ˆ] _t[i]_ +1 _[−][x]_[ˆ] _[t]_[+1][)] _[⊤]_[+] _[ BB][⊤]_ 

Also in Algorithm 3 the perturbation on _Pt|t_ disappears in the limit case _ct_ = 0, i.e. we obtain the sigma point Kalman filter. In view of Proposition 3, the corresponding least favorable density is 

**==> picture [240 x 30] intentionally omitted <==**

with 

**==> picture [372 x 30] intentionally omitted <==**

Also in this case, we exploit the MH procedure outlined in Algorithm 2 to generate samples from the least favorable model. The target density is 

**==> picture [204 x 35] intentionally omitted <==**

In regard to the proposal density _q_ ¯( _ZN |YN[k]_[)][,][given][the][observations] _[Y] N[k]_[,][we][compute] _[x]_[ˆ] _[t][|][t]_[,] _[x]_[ˆ] _[t]_[+1][,] _Lt_ and _θt|t_ , through the update resilient filter, and the corresponding linearized model as in (45)-(46). In view of [10, Theorem 4], the least favorable model over the time interval [0 _, N_ ]Z, 

June 13, 2025 

DRAFT 

27 

corresponding to the linearized model (45) and the tolerance sequence _{ct, t ∈_ [0 _, N_ ]Z _}_ , can be expressed through a state space model. The corresponding least favorable density of _yt_ given _xt_ and _Yt[k] −_ 1[is][Gaussian][with][mean][corresponding][to][the][first-order][Taylor][expansion][of] _[h]_[(] _[x][t]_[)] around _x_ ˆ _t_ . Thus, the model can be further refined replacing such expansion with _h_ ( _xt_ ): 

**==> picture [351 x 33] intentionally omitted <==**

where 

**==> picture [242 x 13] intentionally omitted <==**

_υt ∈_ R _[m]_ is normalized WGN; 

**==> picture [243 x 65] intentionally omitted <==**

Υ _t_ is the Cholesky factor of _Ot_ , i.e. Υ _t_ Υ _[⊤] t_[=] _[ O][t]_[.][Moreover,][Ω] _[−] t_[1] is computed by the following backward recursion: 

**==> picture [238 x 15] intentionally omitted <==**

with Ω _[−]_[1][Accordingly,][by][(68)][the][proposal][density][is] _N_ +1[= 0][.] 

**==> picture [246 x 35] intentionally omitted <==**

where 

**==> picture [160 x 14] intentionally omitted <==**

**==> picture [250 x 15] intentionally omitted <==**

Π _e,t_ is the _n × n_ submatrix of Π _t_ from row _n_ + 1 to 2 _n_ and from column _n_ + 1 to 2 _n_ . Matrix Π _t_ is defined through the Lyapunov equation (see [10, Section 3]) 

**==> picture [130 x 14] intentionally omitted <==**

where 

**==> picture [264 x 55] intentionally omitted <==**

June 13, 2025 

DRAFT 

28 

and Ξ is the block diagonal matrix with main blocks _{BB[⊤] , Im}_ . Notice that, both the target and proposal include the densities _p_ 0( _x_ 0) and _pt_ ( _xt_ +1 _|xt_ ) which are Gaussian distributed, i.e. we are able to draw samples from them. Thus, following reasonings similar to that in Remark 1, we define 

**==> picture [290 x 35] intentionally omitted <==**

and the acceptance ratio takes the form 

**==> picture [166 x 31] intentionally omitted <==**

Therefore, we only have to evaluate _ψ_[˜] _t_[0][(] _[y][t][|][x][t]_[)][and] _[ψ] t[L]_[(] _[y][t][|][x][t][, Y] t[k] −_ 1[)][over][the][time][horizon][[0] _[, N]_[]][Z][.] In regard to the evaluation of _ψ_[˜] _t_[0][(] _[y][t][|][x][t]_[)][,][the][unique][challenging][aspect][regards][the][computation] of _Mt_ defined in (67). The latter can be approximated using Monte Carlo integration: 

**==> picture [276 x 35] intentionally omitted <==**

where we made explicit the dependence of the robust estimator (65) on _yt_ ; _x_[1] _t[. . . x][r] t_[are][sampled] ˜ ˆ ˆ from _pt_ ( _xt|Yt−_ 1) _≃N_ (ˆ _xt, Pt_ ); _θt|t_ , _xt|t_ , _xt_ +1, _Lt_ are computed through the update resilient filter using _YN_ . Then, it is not difficult to see that 

where 

**==> picture [266 x 123] intentionally omitted <==**

The value of _r_ can be determined in such a way to obtain a certain accuracy similarly as outlined in Section IV.B. Finally, the convergence of the MH algorithm can be proved using a similar reasoning as the one outlined in Section IV. 

## VI. SIMULATION EXPERIMENTS 

We present some numerical results to evaluate the performance of the proposed filters. First, we analyze their behavior in the worst-case scenario. Then, we assess their effectiveness using a mass-spring system where model parameters are not known precisely. 

June 13, 2025 

DRAFT 

29 

- _A. Worst-case performance_ 

Consider the nominal nonlinear state space model (1) with 

**==> picture [178 x 39] intentionally omitted <==**

**==> picture [345 x 65] intentionally omitted <==**

In what follows, we consider the following nonlinear filters: 

- **UKF** denotes the unscented Kalman filter where the parameters in (5) are set as _a_ = 0 _._ 5, _b_ = 2, and _κ_ = 1, as recommended in [17]; 

- **P-UKF** denotes the prediction resilient filter of Section III with tolerance _c_ = 10 _[−]_[3] ; the sigma points are obtained using the unscented transformation whose parameter setting is the same as the one of UKF; 

- **U-UKF** denotes the update resilient filter of Section V with tolerance _c_ = 10 _[−]_[3] ; the sigma points are obtained using the unscented transformation whose parameter setting is the same as the one of UKF; 

- **CKF** denotes the cubature Kalman filter; 

- **P-CKF** denotes the prediction resilient filter of Section III with tolerance _c_ = 10 _[−]_[3] ; the sigma points are obtained using the spherical cubature rule; 

- **U-CKF** denotes the update resilient filter of Section V with tolerance _c_ = 10 _[−]_[3] ; the sigma points are obtained using the spherical cubature rule. 

We evaluate their performance under the least favorable models corresponding to the four robust filters introduced above. More precisely, we have generated _M_ = 500 samples _ZN[k]_[of][length] _N_ = 50 from each least favorable model by means of the MH algorithm (i.e. the simulator which generates data from the least favorable model). We set the initial value of _r_ equal to 100 and the desired relative accuracy _τ[⋆]_ = 2 _·_ 10 _[−]_[3] for the computation of _M_[ˆ] _r,t_ . In this way, the cumulative relative error over the time interval [0 _,_ 50]Z is approximately equal to 10%. An upper bound equal to 4000 is imposed on _r_ to control the computational time in edge cases. Fig. 2 shows the boxplot of the value of _r_ required to compute _M_[ˆ] _r,t_ for the generated samples (both the rejected and accepted ones) by the four different simulators. We can see that the typical range of 

June 13, 2025 

DRAFT 

30 

**==> picture [234 x 83] intentionally omitted <==**

**----- Start of picture text -----**<br>
4000<br>3000<br>2000<br>1000<br>0<br>P-UKF P-CKF U-UKF U-CKF<br>**----- End of picture text -----**<br>


Fig. 2: Boxplot of the value of _r_ needed in the MH algorithm and corresponding to the data simulator for P-UKF, P-CKF, U-UKF and U-CKF. 

**==> picture [234 x 238] intentionally omitted <==**

**----- Start of picture text -----**<br>
P-UKF<br>0.6<br>0.4<br>0.2<br>0<br>0 200 400 600 800 1000 1200 1400 1600<br>P-CKF<br>0.6<br>0.4<br>0.2<br>0<br>0 200 400 600 800 1000 1200 1400 1600<br>U-UKF<br>0.6<br>0.4<br>0.2<br>0<br>0 200 400 600 800 1000 1200 1400 1600<br>U-CKF<br>0.6<br>0.4<br>0.2<br>0<br>0 200 400 600 800 1000 1200 1400 1600<br>**----- End of picture text -----**<br>


Fig. 3: Acceptance rate in the MH algorithm corresponding to the data simulator for P-UKF, P-CKF, U-UKF and U-CKF. Variable _k_ denotes the number of proposals (including both accepted and rejected proposals). For the P-UKF case, we have depicted the trajectories corresponding to two different samples of _ZN_[0][.] 

_r_ is 1000 _÷_ 1500 and values greater than 2500 are considered as outliers; thus, the chosen upper bound for _r_ is adequate. Fig. 3 shows the corresponding acceptance rate for the four different simulators. For the P-UKF simulator, i.e. the first subfigure in Fig. 3, we have considered the different trajectories generated by two different samples of _ZN_[0][. Notably, the simulator exhibits a] similar burn-in period and acceptance rate for the two trajectories. For the remaining simulators, from the second to the fourth subfigure in Fig. 3, we have depicted only one trajectory, as we observed a similar behavior. Overall, the acceptance rate for the prediction resilient filters is approximately equal to 30%, while the one for the update resilient filters is around 20%. 

Next, we analyze the filters using the aforementioned dataset. More precisely, for each sample 

June 13, 2025 

DRAFT 

31 

**==> picture [464 x 185] intentionally omitted <==**

**----- Start of picture text -----**<br>
300 (a) 250 (b) 160 (c) 180 (d)<br>UKF 140 160<br>250 CKFP-UKFU-UKF 200 140<br>P-CKF 120<br>U-CKF<br>200 120<br>100<br>150<br>100<br>150 80<br>80<br>100<br>60<br>100 60<br>40<br>40<br>50<br>50<br>20 20<br>0 0 0 0<br>0 10 20 30 40 50 0 10 20 30 40 50 0 10 20 30 40 50 0 10 20 30 40 50<br>**----- End of picture text -----**<br>


Fig. 4: Mean squared error of the filters when the least favorable data are generated by: (a) P-UKF simulator; (b) P-CKF simulator; (c) U-UKF simulator; (d) U-CKF simulator. 

_Z[k]_[extract][the][state][trajectory] _[X][k]_[the][corresponding][measurement][trajectory] _[Y][k]_[Then,] _N_[we] _N_[and] _N_[.] we evaluate the performance of the filters computing the mean squared error at time _t_ : 

**==> picture [303 x 36] intentionally omitted <==**

where _x[k] t_[is][the][state][at][time] _[t]_[extracted][from] _[X] N[k]_[,][while] _[x]_[ˆ] _[k] t_[is][the][state][prediction][obtained][by] the observations _YN[k]_[.][Fig.][4(a)-(b)][show][the][mean][squared][error][for][the][six][filters][using][the][least] favorable data generated by P-UKF simulator and P-CKF simulator, respectively. The results highlight that in each case, the best filter is the one constructed with the corresponding least favorable model. Finally, UKF and CKF exhibit the worst performance. 

Regarding the least favorable data generated by U-UKF simulator and U-CKF simulator we consider the mean squared error at time _t_ : 

**==> picture [139 x 35] intentionally omitted <==**

where _x_ ˆ _[k] t|t_[is the filtered state estimate obtained by the observations] _[ Y] N[k]_[. Indeed, in such scenario] the optimality is guaranteed in terms of the filtered estimate and not the prediction estimate. Fig. 4(c)-(d) show the mean squared error for the six filters using the least favorable data generated by U-UKF simulator and U-CKF simulator, respectively. It is possible to see that the conclusion regarding the previous cases holds also in these cases. It is interesting to point out all the robust 

June 13, 2025 

DRAFT 

32 

filters always perform better than the standard UKF and CKF, even in the case a robust filter has not been designed for a particular least favorable model. 

**==> picture [115 x 56] intentionally omitted <==**

**----- Start of picture text -----**<br>
F<br>f<br>Fs<br>m Fe<br>p<br>**----- End of picture text -----**<br>


Fig. 5: Spring-mass system. 

## _B. State estimation for mass-spring system_ 

We consider a mass-spring system, as shown in Fig. 5, where _p_ [m] is the displacement; _Ff_ [N] denotes the resistive force due to friction; _Fs_ [N] represents the restoring force of the spring; _Fe_ [N] is the external force, which is modeled as WGN with zero mean and variance _q_ = 0 _._ 25. The reference position of the mass is chosen such that the restoring force is equal to zero. Let _x_ = [ _p s_ ] _[⊤]_ be the state vector, where _s_ [m/s] is the velocity of the mass. The initial state is modeled as _x_ 0 _∼N_ ([3 0] _[⊤] ,_ 0 _._ 1 _I_ ). Let _y_ denote the measured displacement using a sensor with sampling time _Ts_ = 0 _._ 1 [s]. Such observation is corrupted by WGN with zero mean and variance _r_ . Thus, the corresponding discretized nonlinear state space model can be written as (1) with 

**==> picture [359 x 92] intentionally omitted <==**

where _m_ = 1 [kg] is the wight of the mass; _vt ∈_ R[3] is normalized WGN; _ϵ ≥_ 0, and the term _TsFe/m_ is the second competent of _Bvt_ . Then, the resistive force includes components due to static, Coulomb, and viscous friction [22], i.e. 

**==> picture [276 x 13] intentionally omitted <==**

where _α_ = 0 _._ 5 [Ns/m] is the friction constant; _η_ ( _x_ ) is a piecewise function: 

**==> picture [215 x 55] intentionally omitted <==**

June 13, 2025 

DRAFT 

33 

TABLE I: MSE for filters with different parameters in the measurement-dominant uncertainty case (left table) and in the balanced uncertainty case (right table). Light grey cells indicate the best performance for each estimator. Note that when _c_ = 0, P-UKF and U-UKF coincide with UKF, while P-CKF and U-CKF coincide with CKF. 

|_c_<br>**P**|**-UKF**<br>**U-UKF**<br>**P**|**-CKF**<br>**U-CKF**|_σ_<br>**MC-UKF**|_Np_<br>**PF**||_c_<br>**P**|**-UKF**<br>**U-UKF**<br>**P**|**-CKF**<br>**U-CKF**|_σ_<br>**MC-UKF**|_Np_<br>**PF**||
|---|---|---|---|---|---|---|---|---|---|---|---|
|0<br>0.0001<br>5<br>0.001<br>4<br>0.01<br>3<br>0.03<br>2<br>0.05<br>3<br>0.1<br>3|6.1683 (UKF)<br>.6055<br>5.5850<br>4<br>.6481<br>4.6057<br>3<br>.2629<br>3.1706<br>2|5.9761 (CKF)<br>.9956<br>4.9929<br>.5758<br>3.5696<br>.2633<br>2.2465|1<br>19.2406<br>2<br>9.9216<br>4<br>6.9212|100<br>14.6787<br>500<br>12.1646<br>1000<br>11.3051||0<br>0.0001<br>2<br>0.01<br>2|2.8501 (UKF)<br>.7614<br>2.7926<br>2<br>.0070<br>2.0348<br>1<br>.7820<br>1.8398<br>1<br>.9464<br>2.0350<br>0<br>.1036<br>2.2787<br>0<br>.3806<br>2.6707<br>0|3.0132 (CKF)<br>.8567<br>2.8608<br>.5639<br>1.6083<br>.0313<br>1.0071<br>.9301<br>0.9443|1<br>4.1461<br>2<br>3.5660<br>4<br>3.3101<br>5<br>3.2385<br>6<br>3.2291<br>8<br>3.2096|100<br>8.1403<br>500<br>7.3950<br>1000<br>7.4929<br>2000<br>7.3597<br>5000<br>6.9343<br>10000<br>6.8398||
||||5<br>6.6238|2000<br>10.6721||0.1<br>1||||||
||.9719<br>2.8700<br>2<br>.0459<br>2.9168<br>2<br>.4483<br>3.2765<br>2|.3007<br>2.2207<br>.4871<br>2.3469<br>.9558<br>2.6821|6<br>6.4777<br>8<br>6.3327|5000<br>9.9698<br>10000<br>9.5718||0.2<br>1<br>0.3<br>2<br>0.5<br>2||||||
|||||||||.8940<br>1.1077<br>.9785<br>1.1623||||
||||10<br>6.2712|20000<br>8.9899|||||10<br>3.2063|20000<br>6.6377||



and _g_ = 9 _._ 81 [m/s[2] ] is the gravity acceleration. The restoring force is modeled by the hardening spring [22], where a small displacement increment beyond a certain threshold leads to a large increase in force, i.e. 

**==> picture [278 x 14] intentionally omitted <==**

where _k_ = 10 [N/m] is the spring constant. In what follows, we analyze two different scenarios. _Measurement-dominant uncertainty:_ We consider a Monte Carlo experiment with _M_ = 1000 trials. In each trial, the actual model is obtained using the actual parameters _a_ , _µk_ , _µs_ , and _r_ , which are sampled from the following uniform distributions: 

**==> picture [202 x 39] intentionally omitted <==**

Moreover, _ϵ_ = 0, i.e. the relation between the displacement and the velocity is deterministic. Then, for each model, we generate the state and measurement trajectories with _N_ = 50 time steps, corresponding to a total duration of 5 seconds. Our aim is to estimate the state vector _x_ using the observations previously generated. The nominal state space model for the filters is given by (70) with the nominal parameters _a_ = 0 _._ 03, _µk_ = 0 _._ 6, _µs_ = 0 _._ 5, _r_ = 1, and _ϵ_ = 10 _[−]_[8] , where we chosen _ϵ >_ 0 to ensure the invertibility of the matrix _BB[⊤]_ . Next, we evaluate the performance of UKF, CKF, the bootstrap particle filter (PF) with different number of particles _Np_ , the maximum correntropy UKF (MC-UKF) [8] with different values of kernel width _σ_ , as well as the proposed robust filters P-UKF, U-UKF, P-CKF, and U-CKF with different values of _c_ . Their performance is assessed using the average of the mean squared error over the entire time horizon: 

**==> picture [107 x 35] intentionally omitted <==**

June 13, 2025 

DRAFT 

34 

where MSE _t_ is defined in (69). Table I (left) summarizes the performance of various filters under different parameter settings. All the proposed robust filters outperform the standard ones (UKF, CKF, PF), regardless of the specific value of _c_ . When _c_ is very small (e.g. _c_ = 0 _._ 0001), their performance is similar to that of the standard filters. As _c_ increases, performance improves; however, for a large value of _c_ (e.g., _c_ = 0 _._ 1), performance slightly degrades as the robust filters become overly conservatives. Moreover, PF fails to match the performance of the other filters due to its high sensitivity to model uncertainties even with a large number of particles. Finally, the proposed robust filters also outperform MC-UKF. This is because MC-UKF is designed for scenarios characterized by heavy-tailed noise distributions. 

It is important to note that in Table I (left), the update resilient filters outperform their prediction resilient counterparts, although the improvement is relatively modest. As an example, Fig. 6 shows the mean squared error over the entire time horizon for the standard sigma point Kalman filters and the robust ones with _c_ = 0 _._ 1. Interestingly, the update-resilient filters clearly outperform their prediction-resilient counterparts after 2.5 seconds. To further investigate the underlying reasons, a representative realization of the displacement and its measured version are depicted in Fig. 7. Since the state vector fluctuates toward zero after approximately 2 _._ 5 [s], the actual forces _Ff_ and _Fs_ , see in (71) and (72), do not depend too much on the actual parameters _a_ , _µk_ , and _µs_ . Hence, the dynamics described by the actual process closely resemble those of the nominal one. In this respect, the uncertainty in the process model tends to vanish over time as the state fluctuates toward [0 0] _[⊤]_ , whereas the uncertainty in the measurements model remains persistent and thus becomes the dominant source of error. This reasoning explains why the update-resilient filter yields the best performance. 

_Balanced uncertainty:_ We conduct the same Monte Carlo experiments as before, with the only difference being that the actual parameter _r_ is sampled from the uniform distribution _r ∼ U_ (0 _._ 1 _,_ 0 _._ 12), while the nominal value is fixed at _r_ = 0 _._ 1. Then, the influence of noise in the measurement equations is reduced, and thus the uncertainty in the measurements model is no longer dominant. More precisely, the uncertainty is more evenly distributed between the process and measurement processes, a condition we refer to as balanced uncertainty. As shown in Table I (right), the situation is similar to the previous case, but the prediction resilient filters outperform their update resilient counterparts. This is expected, as the ambiguity set in (21) accounts for uncertainty in both the process and measurement equations, making the prediction resilient filter more suitable for scenarios characterized by balanced uncertainty. 

June 13, 2025 

DRAFT 

35 

**==> picture [202 x 152] intentionally omitted <==**

**----- Start of picture text -----**<br>
25<br>6 Zoom-in View UKFCKF U-UKFP-CKF<br>P-UKF U-CKF<br>20 5<br>4<br>15 3<br>2<br>2 3 4 5<br>10<br>5<br>0<br>0 1 2 3 4 5<br>**----- End of picture text -----**<br>


Fig. 6: Mean squared error of the state for the sigma point Kalman filters with _c_ = 0 _._ 1; zoom-in view highlights the time interval from 2.5 to 5 [s]. 

**==> picture [216 x 59] intentionally omitted <==**

**----- Start of picture text -----**<br>
4 Displacement<br>2 Measurements<br>0<br>-2<br>-4<br>0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5<br>Time [s]<br>**----- End of picture text -----**<br>


Fig. 7: One realization of the displacement and the measurement trajectory. 

## VII. CONCLUSION 

In this paper, we have proposed a robust sigma point approach under modeling uncertainty. More precisely, we have formulated a dynamic minimax game involving two players: the first player, say the estimator, aims to minimize the variance of the state estimation error, while the maximizer selects the least favorable model from an ambiguity set of possible models centered around the nominal one. We have approximated the center of the ambiguity set using a sigma point approximation to transformations of Gaussian random variables, and characterized the corresponding robust estimator. In addition, since the approximate least favorable model is generally nonlinear and non-Gaussian, we have derived a MCMC-based simulator to generate the data from this model. Our results showed that the proposed robust filters outperform the standard filters, even when they are not matched to the corresponding least favorable model. Finally, a numerical example based on a mass-spring system with imprecisely known model parameters showed that the proposed robust filters significantly outperform the standard ones. 

June 13, 2025 

DRAFT 

36 

## REFERENCES 

- [1] K. Reif, S. Gunther, E. Yaz, and R. Unbehauen, “Stochastic stability of the discrete-time extended Kalman filter,” _IEEE Transactions on Automatic Control_ , vol. 44, no. 4, pp. 714–728, 1999. 

- [2] S. S¨arkk¨a and L. Svensson, _Bayesian filtering and smoothing_ , vol. 17. Cambridge university press, 2023. 

- [3] S. Julier, J. Uhlmann, and H. F. Durrant-Whyte, “A new method for the nonlinear transformation of means and covariances in filters and estimators,” _IEEE Transactions on Automatic Control_ , vol. 45, no. 3, pp. 477–482, 2000. 

- [4] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Transactions on Automatic Control_ , vol. 54, no. 6, pp. 1254– 1269, 2009. 

- [5] J. Pr¨uher, T. Karvonen, C. J. Oates, O. Straka, and S. S¨arkk¨a, “Improved calibration of numerical integration error in sigma-point filters,” _IEEE Transactions on Automatic Control_ , vol. 66, no. 3, pp. 1286–1292, 2020. 

- [6] I. Arasaratnam, S. Haykin, and R. J. Elliott, “Discrete-time nonlinear filtering algorithms using Gauss–Hermite quadrature,” _Proceedings of the IEEE_ , vol. 95, no. 5, pp. 953–977, 2007. 

- [7] A. Nakabayashi and G. Ueno, “Nonlinear filtering method using a switching error model for outlier-contaminated observations,” _IEEE Transactions on Automatic Control_ , vol. 65, no. 7, pp. 3150–3156, 2019. 

- [8] H. Zhao, B. Tian, and B. Chen, “Robust stable iterated unscented Kalman filter based on maximum correntropy criterion,” _Automatica_ , vol. 142, p. 110410, 2022. 

- [9] B. Levy and R. Nikoukhah, “Robust state-space filtering under incremental model perturbations subject to a relative entropy tolerance,” _IEEE Transactions on Automatic Control_ , vol. 58, pp. 682–695, Mar. 2013. 

- [10] S. Yi and M. Zorzi, “An update-resilient Kalman filtering approach,” _Submitted_ , 2024. 

- [11] M. Zorzi, “Robust Kalman filtering under model perturbations,” _IEEE Transactions on Automatic Control_ , vol. 62, no. 6, pp. 2902–2907, 2016. 

- [12] S. Kim, V. Deshpande, and R. Bhattacharya, “Robust Kalman filtering with probabilistic uncertainty in system parameters,” _IEEE Control Systems Letters_ , vol. 5, no. 1, pp. 295–300, 2020. 

- [13] B. Levy and R. Nikoukhah, “Robust least-squares estimation with a relative entropy constraint,” _IEEE Transactions on Information Theory_ , vol. 50, no. 1, pp. 89–104, 2004. 

- [14] S. Yi and M. Zorzi, “Robust Kalman filtering under model uncertainty: The case of degenerate densities,” _IEEE Transactions on Automatic Control_ , vol. 67, no. 7, pp. 3458–3471, 2021. 

- [15] Y. Xu, W. Xue, C. Shang, and H. Fang, “On globalized robust Kalman filter under model uncertainty,” _IEEE Transactions on Automatic Control_ , vol. 70, no. 2, pp. 1147–1160, 2025. 

- [16] A. Longhini, M. Perbellini, S. Gottardi, S. Yi, H. Liu, and M. Zorzi, “Learning the tuned liquid damper dynamics by means of a robust EKF,” in _2021 American Control Conference (ACC)_ , pp. 60–65, IEEE, 2021. 

- [17] E. A. Wan and R. Van Der Merwe, “The unscented kalman filter,” _Chapter 7 of: Kalman filtering and neural networks_ , pp. 221–280, 2001. 

- [18] T. Cover and J. Thomas, _Information Theory_ . New York: Wiley, 1991. 

- [19] A. Zenere and M. Zorzi, “On the coupling of model predictive control and robust Kalman filtering,” _IET Control Theory & Applications_ , vol. 12, no. 13, pp. 1873–1881, 2018. 

- [20] M. Zorzi and B. C. Levy, “Robust Kalman filtering: Asymptotic analysis of the least favorable model,” in _IEEE Conference on Decision and Control (CDC)_ , pp. 7124–7129, 2018. 

- [21] S. D. Hill and J. C. Spall, “Stationarity and convergence of the Metropolis-Hastings algorithm: Insights into theoretical aspects,” _IEEE Control Systems Magazine_ , vol. 39, no. 1, pp. 56–67, 2019. 

- [22] H. K. Khalil and J. W. Grizzle, _Nonlinear systems_ , vol. 3. Prentice hall Upper Saddle River, NJ, 2002. 

June 13, 2025 

DRAFT 

