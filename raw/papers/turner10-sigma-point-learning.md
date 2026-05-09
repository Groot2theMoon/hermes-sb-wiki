---
title: "Model Based Learning of Sigma Points in Unscented Kalman Filtering"
journal: "Neurocomputing, 80, 47-53."
authors: ['Turner, R.', 'Rasmussen, C.E.']
year: 2012
source: paper
ingested: 2026-05-09
sha256: 58610b7baf2134a89018a4fa7226acb66b25800a107b62de161463c6d975c200
conversion: pymupdf4llm
---

## **MODEL BASED LEARNING OF SIGMA POINTS IN UNSCENTED KALMAN FILTERING** 

_Ryan Turner and Carl Edward Rasmussen_ 

## University of Cambridge Department of Engineering Trumpington Street, Cambridge CB2 1PZ, UK 

## **ABSTRACT** 

The unscented Kalman filter (UKF) is a widely used method in control and time series applications. The UKF suffers from arbitrary parameters necessary for a step known as sigma point placement, causing it to perform poorly in nonlinear problems. We show how to treat sigma point placement in a UKF as a learning problem in a model based view. We demonstrate that learning to place the sigma points correctly from data can make sigma point collapse much less likely. Learning can result in a significant increase in predictive performance over default settings of the parameters in the UKF and other filters designed to avoid the problems of the UKF, such as the GP-ADF. At the same time, we maintain a lower computational complexity than the other methods. We call our method UKF-L. 

## **1. INTRODUCTION** 

Filtering in linear dynamical systems (LDS) and nonlinear dynamical systems (NLDS) is frequently used in many areas, such as signal processing, state estimation, control, and finance/econometric models. Filtering (inference) aims to estimate the state of a system from a stream of noisy measurements. Imagine tracking the location of a car based on odometer and GPS sensors, both of which are noisy. Sequential measurements from both sensors are combined to overcome the noise in the system and to obtain an accurate estimate of the system state. Even when the full state is only partially measured, it can still be inferred; in the car example the engine temperature is unobserved, but can be inferred via the nonlinear relationship from acceleration. To exploit this relationship appropriately, inference techniques in nonlinear models are required; they play an important role in many practical applications. 

LDS and NLDS belong to a class of models known as state-space models. A state-space model assumes that there exists a sequence of latent states **x** _t_ that evolve over time according to a Markovian process specified by a transition function _f_ . The latent states are observed indirectly in **y** _t_ through a measurement function _g_ . We consider state-space 

models given by 

**==> picture [186 x 28] intentionally omitted <==**

Here, the system noise _**ϵ** ∼N_ ( **0** _,_ **Σ** _ϵ_ ) and the measurement noise _**ν** ∼N_ ( **0** _,_ **Σ** _ν_ ) are both Gaussian. In the LDS case, _f_ and _g_ are linear functions, whereas the NLDS covers the general nonlinear case. 

Kalman filtering [1] corresponds to exact (and fast) inference in the LDS, however it can only model a limited set of phenomena. For the last few decades, there has been interest in NLDS for more general applicability. In the statespace formulation, the nonlinear systems do not generally yield analytically tractable algorithms. 

The most widely used approximations for filtering in NLDS are the extended Kalman filter (EKF) [2] and the unscented Kalman filter (UKF) [3]. The EKF linearizes _f_ and _g_ at the current estimate of _xt_ and treats the system as a nonstationary linear system even though it is not. The UKF propagates several estimates of _xt_ through _f_ and _g_ and reconstructs a Gaussian distribution assuming the propagated values came from a linear system. The locations of the estimates of _xt_ are known as the _sigma points_ . Many heuristics have been developed to help set the sigma point locations [4]. Unlike the EKF, the UKF has free parameters that determine where to put the sigma points. The key idea in this paper, is that the UKF and EKF are doing exact inference in a model that is somewhat perverted from the original model described in the state-space formulation. The interpretation of EKF and UKF as models, not just approximate methods, allows us to better identify their underlying assumptions. It also enables us to _learn_ the free parameters in the UKF in a model based manner from training data. If the settings of the sigma point are a poor fit to the underlying dynamical system, the UKF can make horrendously poor predictions. This paper’s contribution is a strategy for improving the UKF through a novel learning algorithm for appropriate sigma point placement: we call this method UKF-L. 

## **2. UNSCENTED KALMAN FILTERING** 

We first review how filtering and the UKF works and then explain the UKF’s generative assumptions. Filtering methods consist of three steps: time update, prediction step, and measurement update. They iterate in a predictor-corrector setup. In the time update we find _p_ ( **x** _t|_ **y** 1: _t−_ 1): 

**==> picture [232 x 24] intentionally omitted <==**

using _p_ ( **x** _t−_ 1 _|_ **y** 1: _t−_ 1). In the prediction step we predict the observed space, _p_ ( **y** _t|_ **y** 1: _t−_ 1) using _p_ ( **x** _t|_ **y** 1: _t−_ 1): 

**==> picture [211 x 23] intentionally omitted <==**

Finally, in the measurement update we find _p_ ( **x** _t|_ **y** _t_ ) using information from how good (or bad) the prediction in the prediction step is: 

**==> picture [192 x 11] intentionally omitted <==**

In the linear case all of these equations can be done analytically using matrix multiplications. The EKF explicitly linearizes _f_ and _g_ at the point E [ **x** _t_ ] at each step. The UKF uses the whole distribution on **x** _t_ , not just the mean, to place sigma points and implicitly linearize the dynamics, which we call the _unscented transform_ (UT). In one dimension the sigma points roughly correspond to the mean and _α_ -standard deviation points; the UKF generalizes this idea to higher dimensions. The exact placement of sigma points depends on the unitless parameters _{α, β, κ} ∈_ R[+] through 

**==> picture [194 x 29] intentionally omitted <==**

where _[√] ·i_ refers to the _i_ th row of the Cholesky factorization.[1] The sigma points have weights assigned by: 

**==> picture [230 x 29] intentionally omitted <==**

where _wm_ is used to reconstruct the predicted mean and _wc_ used for the predicted covariance. We can loosely interpret the unscented transform as approximating the input distribution by 2 _D_ + 1 point masses at _X_ with weight _w_ . Once the sigma points _X_ , have been calculated the filter accesses _f_ and _g_ as black boxes to find _Yt_ , either _f_ ( _Xt_ ) or _g_ ( _Xt_ ) depending on the step. The UKF reconstructs the mean and variance of the propagated distribution from _Yt had_ the dynamics been linear. It does not guarantee the moments will match the moment of the true non-Gaussian distribution. 

> 1If ~~_√_~~ _P_ = _A ⇒ P_ = _A[⊤] A_ , then we use the rows in (5). If _P_ = _AA[⊤]_ , then we use the columns. 

## **Algorithm 1** Sampling data from UKF’s implicit model 

- 1: _p_ ( **x** 1 _|∅_ ) _←_ ( _µ_ 0 _,_ Σ0) 

- 2: **for** _t_ = 1 to _T_ **do** 

- 3: Prediction step: _p_ ( **y** _t|_ **y** 1: _t−_ 1) using _p_ ( **x** _t|_ **y** 1: _t−_ 1) 4: Sample **y** _t_ from prediction step distribution 5: Measurement update: _p_ ( **x** _t|_ **y** 1: _t_ ) using **y** _t_ 6: Time update: find _p_ ( **x** _t_ +1 _|_ **y** 1: _t_ ) using _p_ ( **x** _t|_ **y** 1: _t_ ) 7: **end for** 

Both the EKF and the UKF approximate the nonlinear state-space as a nonstationary linear system. The UKF defines its own _generative process_ that linearizes the nonlinear function _f_ and _g_ wherever in **x** _t_ a UKF filtering the time series would expect **x** _t_ to be. Therefore, it is possible to sample synthetic data from the UKF by sampling from its onestep-ahead predictions as seen in Algorithm 1. The sampling procedure augments the filter: predict-sample-correct. If we use the UKF with the same _{α, β, κ}_ used to generate synthetic data, then the one-step-ahead predictive distribution will be the exact same distribution the data point was sampled from. 

## **2.1. Setting the parameters** 

We summarize all the parameters as _θ_ := _{α, β, κ}_ . For any setting of _θ_ the UKF will give identical predictions to the Kalman filter if _f_ and _g_ are both linear. Many of the heuristics for setting _θ_ assume _f_ and _g_ are linear (or close to it), which is not the problem the UKF solves. For example, one of the heuristics for setting _θ_ is that _β_ = 2 is optimal if the state distribution _p_ ( **x** _t|_ **y** 1: _t_ ) is exactly Gaussian [5]. However, the state distribution will seldom be Gaussian unless the system is linear, in which case any setting of _θ_ is exact! It is often recommended to set the parameters to _α_ = 1, _β_ = 0, and _κ_ = 2. 

## **3. THE ACHILLES’ HEEL OF THE UKF** 

The UKF can have very poor performance because its predictive variances can be far too small if the sigma points are placed in inconvenient locations. A too small predictive variance will cause observations to have too much weight in the measurement update, which causes the UKF to fit to noise. Meaning, the UKF will perform poorly even when evaluated on root-mean-square-error (RMSE), which only uses the predictive mean. 

In the most extreme case, the UKF can give a delta spike predictive distribution. We call this _sigma point collapse_ . As seen in Fig. 1, when the sigma points are arranged together horizontally the UKF has no way to know the function varies anywhere. We aim to learn the parameters _θ_ in such a way that collapse becomes unlikely. Anytime col- 

lapse happens in training the marginal likelihood will be very low. Hence, the learned parameters will avoid anywhere this delta spike occurred in training. Maximizing the marginal likelihood is tricky since it is not well behaved for settings of _θ_ that cause sigma point collapse. 

**==> picture [209 x 146] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0.5<br>0<br>−0.5<br>−1<br>−10 −5 0 5 10<br>−10 −5 0 5 10<br>**----- End of picture text -----**<br>


**Fig. 1** . An illustration of a good and bad assignment of sigma points. The lower panel shows the true input distribution. The center panel shows the sinusoidal system function _f_ (blue) and the sigma points for _α_ = 1 (red crosses) and _α_ = 0 _._ 68 (green rings). The left panel shows the true output distribution (shaded), the output distribution under _α_ = 1 (red spike) and _α_ = 0 _._ 68 (green). Using a different set of sigma points we can get either a completely degenerate solution (a delta spike) or a near optimal approximation within the class of Gaussian approximations. 

## **4. MODEL BASED LEARNING** 

A common approach to estimating model parameters _θ_ in general is to maximize the log marginal likelihood 

**==> picture [223 x 30] intentionally omitted <==**

Hence we can equivalently maximize the sum from the onestep-ahead predictions. One might be tempted to apply a gradient based optimizer on (8), but as seen in Fig. 2 the marginal likelihood can be very noisy. The noise, or instability in the likelihood, is likely the result of the phenomenon explained in Section 3, where a slight change in parameterization can avoid problematic sigma point placement. This makes the application of a gradient-based optimizer hopeless. 

It is also possible to apply Markov chain Monte Carlo (MCMC) and integrate out the parameters. However, this is usually overkill as the posterior on _θ_ is usually highly peaked unless _T_ is very small. Tempering must be used as mixing will be difficult if the chain is not initialized inside 

the posterior peak. Even in the case when _T_ is small enough to spread the posterior out, we would still like a single point estimate for computational speed on the test set.[2] 

We will focus on learning using a Gaussian process (GP) based optimizer [6]. Since the marginal likelihood surface has an underlying smooth function but contains what amounts to additive noise, a probabilistic regression method seems a natural fit for finding the maximum. 

## **5. GAUSSIAN PROCESS OPTIMIZERS** 

Gaussian processes form a prior over functions. Estimating the parameters amounts to finding the maximum of a structured function: the log marginal likelihood. Therefore, it seems natural to use a prior over functions to guide our search. The same principle has been applied to integration in [7]. 

GP optimization (GPO) allows for effective _derivative free_ optimization. We consider the maximization of a likelihood function _ℓ_ ( _θ_ ). GPs allow for derivative information _∂θℓ_ to be included as well, but in our case that will not be very useful due to the function’s instability. 

GPO treats optimization as a sequential decision problem in a probabilistic setting, receiving reward _r_ when using the right input _θ_ to get a large function value output _ℓ_ ( _θ_ ). At each step GPO uses its posterior over the objective function _p_ ( _ℓ_ ( _θ_ )) to look for _θ_ it believes have large function value _ℓ_ ( _θ_ ). A maximization strategy that is _greedy_ will always evaluate the function _p_ ( _ℓ_ ( _θ_ )) where the mean function E [ _ℓ_ ( _θ_ )] is the largest. A strategy that trades-off _exploration_ with _exploitation_ will take into account the posterior variance Var [ _ℓ_ ( _θ_ )]. Areas of _θ_ with high variance carry a possibility of having a large function value or high reward _r_ . The optimizer is programmed to evaluate at the maxima of 

**==> picture [189 x 13] intentionally omitted <==**

where _K_ is a constant to control the exploration exploitation trade-off. The optimizer must also find the maximum of _J_ , but since it is a combination of the GP mean and variance functions it is easy to optimize with gradient methods. 

## **6. EXPERIMENTS AND RESULTS** 

We test our method on filtering in three dynamical systems: the sinusoidal dynamics used in [8], the Kitagawa dynamics used in [9, 10], and pendulum dynamics used in [9]. The sinusoidal dynamics are described by 

**==> picture [201 x 28] intentionally omitted <==**

2If we want to integrate the parameters out we must run the UKF with each sample of _θ|_ **y** 1: _T_ during test and average. To get the optimal point estimate of the posterior we would like to compute the _Bayes’ point_ . 

**==> picture [456 x 108] intentionally omitted <==**

**----- Start of picture text -----**<br>
8 −0.5 1 −0.5 2 0<br>6 −1<br>4 −1.5 0.5 −1 1 −1<br>2 −2<br>0 −2.5 0 −1.5 0 −2<br>0 1 2 3 4 0 1 2 3 4 1 2 3 4 5<br>(a) α ∈ (0 . 1 ,  4) (b) β ∈ (0 ,  4) (c) κ ∈ (0 . 1 ,  5)<br>D D D<br>log likelihood (nats/obs) log likelihood (nats/obs) log likelihood (nats/obs)<br>**----- End of picture text -----**<br>


**Fig. 2** . Illustration of the UKF when applied to a pendulum system. Cross section of the marginal likelihood (blue line) varying the parameters one at a time from the defaults (red vertical line). We shift the marginal likelihood, in nats/observation, to make the lowest value zero. The dashed green line is the total variance diagnostic _D_ := E [log( _|_ Σ _|/|_ Σ0 _|_ )], where Σ is the predictive variance in one-step-ahead prediction. We divide out the variance Σ0 of the time series when treating it as iid to make _D_ unitless. Values of _θ_ with small predictive variances closely track the _θ_ with low marginal likelihood. 

where _σ_ ( _·_ ) represents a sigmoid. The Kitagawa model is described by 

**==> picture [223 x 24] intentionally omitted <==**

**==> picture [212 x 13] intentionally omitted <==**

The Kitagawa model was presented as filtering problem in [10]. The pendulum dynamics is described by a discretized ordinary differential equation (ODE) at ∆ _t_ = 400 ms. The pendulum possesses a mass _m_ = 1 kg and a length _l_ = 1 m. The pendulum angle _ϕ_ is measured anti-clockwise ˙ from hanging down. The state **x** = [ _ϕ, ϕ_ ] _[⊤]_ of the pendulum is given by the angle _ϕ_ and the angular velocity _ϕ_ ˙ . The ODE is 

**==> picture [168 x 26] intentionally omitted <==**

where _g_ the acceleration of gravity. This model is commonly used in stochastic control for the inverted pendulum problem [11]. The measurement function is 

**==> picture [225 x 36] intentionally omitted <==**

which corresponds to _bearings only measurement_ since we do not directly observe the velocity. We use system noise Σ _w_ = diag([0 _._ 1[2] 0 _._ 3[2] ]) and Σ _v_ = diag([0 _._ 2[2] 0 _._ 2[2] ]) as observation noise. 

For all the problems we compare to UKF-D, EKF, the GP-UKF, and GP-ADF, and the time independent model (TIM); we use UKF-D to denote a UKF with default parameter settings, and UKF-L for learned parameters. The TIM treats the data as iid normal and is inserted as a reference point. The GP-UKF and GP-ADF use GPs to approximate _f_ and _g_ and exploit the properties of GPs to make 

tractable predictions. The Kitagawa and pendulum dynamics were used by [9] to illustrate the performance of the GPADF and the very poor performance of the UKF. [9] used the default settings of _α_ = 1, _β_ = 0, _κ_ = 2 for all of the experiments. We used exploration trade off _K_ = 2 for the GPO in all the experiments. Additionally, GPO used the squared-exponential with automatic relevance determination (SE-ARD) covariance function plus a noise term of 0.01 nats/observation. We set the GPO to have a maximum number of function evaluations of 100, even better results can be obtained by letting the optimizer run longer to hone the parameter estimate. We show that by _learning_ appropriate values for _θ_ we can match, if not exceed, the performance of the GP-ADF and other methods. 

The models were evaluated on one-step-ahead prediction. The evaluation metrics were the negative log-predictive likelihood (NLL), the mean squared error (MSE), and the mean absolute error (MAE) between the mean of the prediction and the true value. Note that unlike the NLL, the MSE and MAE do not account for uncertainty. The MAE will be more difficult for approximate methods than MSE. For MSE, the optimal action is to predict the mean of the predictive distribution, while for the MAE it is the median. Most approximate methods attempt to moment match to a Gaussian and preserve the mean; the median of the true predictive distribution is implicitly assumed to be the same as mean. Quantitative results are shown in Table 1. 

## **6.1. Sinusoidal dynamics** 

The models were trained on _T_ = 1000 observations from the sinusoidal dynamics, and tested on _R_ = 10 restarts with _T_ = 500 points each. The initial state was sampled from a standard normal _x_ 1 _∼N_ (0 _,_ 1). The UKF optimizer found the optimal values _α_ = 2 _._ 0216, _β_ = 0 _._ 2434, and _κ_ = 0 _._ 4871. 

**Table 1** . Comparison of the methods on the sinusoidal, Kitagawa, and pendulum dynamics. The measures are supplied with 95% confidence intervals and a p-value from a one-sided t-test under the null hypothesis UKF-L is the same or worse as the other methods. NLL is reported in nats/observation, while MSE and MAE are in the units of **y**[2] and **y** , respectively. Since the observations in the pendulum data are angles we projected the means and the data to the complex plane before computing MSE and MAE. 

|Method|NLL<br>p-value|MSE<br>p-value|MAE<br>p-value|
|---|---|---|---|
|Sinusoid(_T_ = 500and_R_= 10)||||
|UKF-D<br>UKF-L_⋆_<br>EKF<br>GP-ADF<br>GP-UKF<br>TIM|10_−_1_×_ -4.58_±_0.168<br>_<_0.0001<br>_−_**5**_._**53**_±_**0**_._**243**<br>N/A<br>-1.94_±_0.355<br>_<_0.0001<br>-4.13_±_0.154<br>_<_0.0001<br>-3.84_±_0.175<br>_<_0.0001<br>-0.779_±_0.238<br>_<_0.0001|10_−_2_×_ 2.32_±_0.0901<br>_<_0.0001<br>**1**_._**92**_±_**0**_._**0799**<br>N/A<br>3.03_±_0.127<br>_<_0.0001<br>2.57_±_0.0940<br>_<_0.0001<br>2.65_±_0.0985<br>_<_0.0001<br>4.52_±_0.141<br>_<_0.0001|10_−_1_×_ 1.22_±_0.0253<br>_<_0.0001<br>**1**_._**09**_±_**0**_._**0236**<br>N/A<br>1.37_±_0.0299<br>_<_0.0001<br>1.30_±_0.0261<br>_<_0.0001<br>1.32_±_0.0266<br>_<_0.0001<br>1.78_±_0.0323<br>_<_0.0001|
|Kitagawa(_T_ = 10and_R_= 200)||||
|UKF-D<br>UKF-L_⋆_<br>EKF<br>GP-ADF<br>GP-UKF<br>TIM|100_×_ 3.78_±_0.662<br>_<_0.0001<br>**2**_._**24**_±_**0**_._**369**<br>N/A<br>617_±_554<br>0.0149<br>2.93_±_0.0143<br>0.0001<br>2.93_±_0.0142<br>0.0001<br>48.8_±_2.25<br>_<_0.0001|100_×_ 5.42_±_0.607<br>_<_0.0001<br>**3**_._**60**_±_**0**_._**477**<br>N/A<br>9.69_±_0.977<br>_<_0.0001<br>18.2_±_0.332<br>_<_0.0001<br>18.1_±_0.330<br>_<_0.0001<br>37.2_±_1.73<br>_<_0.0001|100_×_ 1.32_±_0.0841<br>_<_0.0001<br>**1**_._**05**_±_**0**_._**0692**<br>N/A<br>1.75_±_0.113<br>_<_0.0001<br>4.10_±_0.0522<br>_<_0.0001<br>4.09_±_0.0521<br>_<_0.0001<br>4.54_±_0.179<br>_<_0.0001|
|Pendulum(_T_ = 200 = 80 sand_R_= 100)||||
|UKF-D<br>UKF-L_⋆_<br>EKF<br>GP-ADF<br>GP-UKF<br>TIM|100_×_ 3.17_±_0.0808<br>_<_0.0001<br>**0**_._**392**_±_**0**_._**0277**<br>N/A<br>0.660_±_0.0429<br>_<_0.0001<br>1.18_±_0.00681<br>_<_0.0001<br>1.77_±_0.0313<br>_<_0.0001<br>0.896_±_0.0115<br>_<_0.0001|10_−_1_×_ 5.74_±_0.0815<br>_<_0.0001<br>**1**_._**93**_±_**0**_._**0378**<br>N/A<br>1.98_±_0.0429<br>0.0401<br>4.34_±_0.0449<br>_<_0.0001<br>5.67_±_0.0714<br>_<_0.0001<br>4.13_±_0.0426<br>_<_0.0001|10_−_1_×_ 11.5_±_0.0988<br>_<_0.0001<br>6.14_±_0.0577<br>N/A<br>**6**_._**11**_±_**0**_._**0611**<br>0.779<br>10.3_±_0.0589<br>_<_0.0001<br>11.6_±_0.0857<br>_<_0.0001<br>10.2_±_0.0589<br>_<_0.0001|



## **6.2. Kitagawa** 

The Kitagawa model has a tendency to stabilize around _x_ = _±_ 7 where it is linear. The challenging portion for filtering is away from the stable portions where the dynamics are highly nonlinear. [9] evaluated the model using _R_ = 200 independent starts of the time series allowed to run only _T_ = 1 time steps, which we find somewhat unrealistic. Therefore, we allow for _T_ = 10 time steps with _R_ = 200 independent starts. In this example, _x_ 1 _∼N_ (0 _,_ 0 _._ 5[2] ). 

The learned value of the parameters where, _α_ = 0 _._ 3846, _β_ = 1 _._ 2766, _κ_ = 2 _._ 5830. 

## **6.3. Pendulum** 

ized in one state the model will not have a chance to learn the needed parameter settings to avoid rare, but still present, sigma point collapse in other parts of the state-space. A short period single sigma point collapse in a long time series can give the models a worse NLL than even TIM due to incredibly small likelihoods. The MSE and MAE losses are more bounded so a short period of poor performance will be hidden by good performance periods. Even when _R_ = 1 during training, sigma point collapse is much rarer than in UKF-L than UKF-D. The UKF found optimal values of the parameters to be _α_ = 0 _._ 5933, _β_ = 0 _._ 1630, _κ_ = 0 _._ 6391. It is further evidence that the correct _θ_ are hard proscribe a priori and must be learned empirically. We compare the predictions of the default and learned settings in Fig. 3. 

The models were tested on _R_ = 100 runs of length _T_ = 200 each, with **x** 1 _∼N_ ([ _−π_ 0] _,_ [0 _._ 1[2] 0 _._ 2[2] ]). The initial state mean of [ _−π_ 0] corresponds to the pendulum being in the downward position. The models were trained on _R_ = 5 runs of length _T_ = 200. We found that in order to perform well on NLL, but not on MSE and MAE, multiple runs of the time series were needed during training; otherwise, TIM had the best NLL. This is because if the time series is initial- 

## **6.4. Analysis of sigma point collapse** 

We find that the marginal likelihood is extremely unstable in regions of _θ_ that experience sigma point collapse. When sigma point collapse occurs, the predictive variances become far too small making the marginal likelihood much more susceptible to noise. Hence, the marginal likelihood is smooth near the optima, as seen in Fig. 2. As a diagnostic 

**==> picture [222 x 97] intentionally omitted <==**

**----- Start of picture text -----**<br>
2 2<br>1.5 1.5<br>1 1<br>0.5 0.5<br>0 0<br>−0.5 −0.5<br>196 198 200 202 Time step204 206 208 210 212 214 196 198 200 202 Time step204 206 208 210 212<br>(a) Default  θ (b) Learned  θ<br>x1 x1<br>**----- End of picture text -----**<br>


**Fig. 3** . Comparison of default and learned for one-stepahead prediction for first element of **y** _t_ in the Pendulum model. The red line is the truth, while the black line and shaded area represent the mean and 95% confidence interval of the predictive distribution. 

_D_ for sigma point collapse we look at the mean _|_ Σ _|_ of the predictive distribution. 

## **6.5. Computational Complexity** 

The UKF-L, UKF, and EKF have test set computational time _O_ ( _DT_ ( _D_[2] + _M_ )). The GP-UKF and GP-ADF have complexity _O_ (( _D_[3] + _D_[2] _MN_[2] ) _T_ ), where _N_ is the number of points used in training to learn _f_ and _g_ . If a large number of training points _N_ is needed to approximate _f_ and _g_ well the GP-ADF and GP-UKF can become much slower than the UKF. 

## **6.6. Discussion** 

The learned parameters of the UKF performed significantly better than the default UKF for all error measures and data sets. Likewise, it performed significantly better than all other methods except against the EKF on the pendulum data on MAE, where the two methods are essentially tied. We found that results could be improved further by averaging the predictions of the UKF-L and the EKF. 

## **7. CONCLUSIONS** 

We have presented an automatic and model based mechanism to learn the parameters of a UKF, _{α.β, κ}_ , in a principled way. The UKF can be reinterpreted as a generative process that performs inference on a slightly different NLDS than desired through specification of _f_ and _g_ . We demonstrate how the UKF can fail arbitrarily badly in very nonlinear problems through sigma point collapse. Learning the parameters can make sigma point collapse less likely to occur. When the UKF learns the correct parameters from data it can outperform other filters designed to avoid sigma point collapse, such as the GP-ADF, on common benchmark dynamical systems problems. 

## **Acknowledgements** 

We thank Steven Bottone, Zoubin Ghahramani, and Andrew Wilson for advice and feedback on this work. 

## **8. REFERENCES** 

- [1] Rudolf E. Kalman, “A new approach to linear filtering and prediction problems,” _Transactions of the ASME — Journal of Basic Engineering_ , vol. 82, no. Series D, pp. 35–45, 1960. 

- [2] Peter S. Maybeck, _Stochastic Models, Estimation, and Control_ , vol. 141 of _Mathematics in Science and Engineering_ , Academic Press, Inc., 1979. 

- [3] Simon J. Julier and Jeffrey K. Uhlmann, “A new extension of the Kalman filter to nonlinear systems,” in _Proceedings of AeroSense: 11th Symposium on Aerospace/Defense Sensing, Simulation and Controls_ , Orlando, FL, 1997, pp. 182–193. 

- [4] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _Proceedings of the IEEE_ , vol. 92, no. 3, pp. 401–422, 2004. 

- [5] Eric A. Wan and Rudolph van der Merwe, “The unscented Kalman filter for nonlinear estimation,” in _Symposium 2000 on Adaptive Systems for Signal Processing, Communication and Control, IEEE_ , Lake Louise, AB, 2000, pp. 153–158. 

- [6] Michael A. Osborne, Roman Garnett, and Stephen J. Roberts, “Gaussian processes for global optimization,” in _3rd International Conference on Learning and Intelligent Optimization (LION3)_ , Trento, Italy, January 2009. 

- [7] Carl E. Rasmussen and Zoubin Ghahramani, “Bayesian Monte Carlo,” in _Advances in Neural Information Processing Systems 15_ , S. Becker, S. Thrun, and K. Obermayer, Eds., pp. 489–496. The MIT Press, Cambridge, MA, USA, 2003. 

- [8] Ryan Turner, Marc Peter Deisenroth, and Carl Edward Rasmussen, “State-space inference and learning with Gaussian processes,” in _the 13th International Conference on Artificial Intelligence and Statistics_ , Sardinia, Italy, 2010, vol. 9. 

- [9] Marc P. Deisenroth, Marco F. Huber, and Uwe D. Hanebeck, “Analytic moment-based Gaussian process filtering,” in _Proceedings of the 26th International Conference on Machine Learning_ , Montreal, QC, 2009, pp. 225–232, Omnipress. 

- [10] Genshiro Kitagawa, “Monte Carlo filter and smoother for non-Gaussian nonlinear state space models,” _Journal of Computational and Graphical Statistics_ , vol. 5, no. 1, pp. 1–25, 1996. 

- [11] Marc P. Deisenroth, Carl E. Rasmussen, and Jan Peters, “Model-based reinforcement learning with continuous states and actions,” in _Proceedings of the 16th European Symposium on Artificial Neural Networks (ESANN 2008)_ , Bruges, Belgium, April 2008, pp. 19–24. 

