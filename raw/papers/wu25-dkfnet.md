---
source_url: https://arxiv.org/abs/2509.07474
ingested: 2026-05-05
type: raw-paper
tags: [differentiable-kalman-filter, field-inversion, closure-modeling, adjoint]
---

# DKFNet: Differentiable Kalman Filter for Field Inversion and Machine Learning 

Yuan Wu[1] , Sicheng He[2] 

## **Abstract** 

The Kalman filter is a fundamental tool for state estimation in dynamical systems. While originally developed for linear Gaussian settings, it has been extended to nonlinear problems through approaches such as the extended and unscented Kalman filters. Despite its broad use, a persistent limitation is that the underlying approximate model is fixed, which can lead to significant deviations from the true system dynamics. To address this limitation, we introduce the differentiable Kalman filter (DKF), an adjoint-based two-level optimization framework designed to reduce the mismatch between approximate and true dynamics. Within this framework, a field inversion step first uncovers the discrepancy, after which a closure model is trained to capture the discovered dynamics, allowing the filter to adapt flexibly and scale efficiently. We illustrate the capabilities of the DKF using two representative examples: a rocket dynamics model and the Allen–Cahn boundary value problem. In both cases, and across a range of noise levels, the DKF consistently reduces state reconstruction error by at least 90% compared to the classical Kalman filter, while also maintaining robust uncertainty quantification. These results demonstrate that the DKF not only improves estimation accuracy by large margins but also enhances interpretability and scalability, offering a principled pathway for combining data assimilation with modern machine learning. 

> 1Graduate Student, University of Tennessee, Knoxville and Rice University 

> 2Assistant Professor, sicheng@utk.edu, University of Tennessee, Knoxville 

## **1. Introduction** 

The Kalman filter is a recursive algorithm used to estimate the hidden state of a linear dynamical system from noisy observations, assuming Gaussian noise and known system models. It operates by predicting the next state using the system dynamics and then updating that prediction using new measurements, balancing model uncertainty and measurement noise through a dynamically computed gain. Originally developed for aerospace navigation, the Kalman filter is now widely applied in fields such as autonomous vehicle localization [1, 2, 3, 4], satellite tracking [5, 6, 7, 8], financial time series forecasting [9, 10, 11], and robotic control [12, 13, 14, 15, 16], where it enables accurate real-time estimation even with incomplete or noisy sensor data. 

Multiple variants of the classic Kalman filter have been proposed in recent years to address the challenges encountered in its application. The popular ones include the extended Kalman filter (EKF), unscented Kalman filter (UKF), ensemble Kalman filter (EnKF), and particle filter (PF). The EKF linearizes nonlinear systems using a first-order Taylor expansion, but its accuracy drops when nonlinearities are strong [17, 18, 19]. The UKF overcomes this by propagating sigma points through the nonlinear system, providing more accurate estimates in highly nonlinear cases, though at increased computational cost for large state spaces [20, 21, 22]. The EnKF uses an ensemble of forecasts for efficient state estimation in high-dimensional and nonlinear systems, but may need large ensemble sizes to accurately represent uncertainty [23, 24, 25, 26, 27]. The PF, in contrast, approximates the full posterior distribution with weighted particles, making it highly flexible for nonlinear and non-Gaussian models, but often suffers from sample degeneracy and high computational demand, especially as the state dimension grows [28]. 

In recent years, there has been a surge of interest in extending the Kalman filter with differentiable programming techniques, enabling end-to-end learning of both system and measurement models directly from data [29, 30, 31]. — Such approaches which we broadly refer to here as Kalman filters using differentiable methods — include variants such as the differentiable extended Kalman filter (DEKF), the differentiable unscented Kalman filter (DUKF), differentiable ensemble Kalman filter (DEnKF). For a comparison of current works and our new results, see Table 1. The DEKF proposed by [32] allows both the system dynamics and observation models to be identified 

2 

directly from tactile sensor data, without requiring hand-crafted models. Unlike classic EKF approaches that require hand-crafted physical models, differentiable EKF allows the entire state estimation pipeline to be trained via gradient-based optimization. This framework was demonstrated on the iCub humanoid robot, an open-source research platform developed for studying embodied AI, where it successfully tracked the position and velocity of sliding objects using only tactile observations, achieving a high degree of accuracy. The DEKF thus provides a flexible, data-driven approach for state estimation in scenarios where conventional modeling is difficult or inaccurate. However, its effectiveness can be hindered by practical challenges such as sensitivity to model mismatch and limited robustness when applied to highly nonlinear or noisy systems. 

In [33], the DUKF enables end-to-end learning of both system and uncertainty models directly from data. Unlike unstructured deep learning methods, DUKF retains the model structure of the classic UKF, which improves interpretability—that is, the ability to understand and trace how state estimates are computed based on explicit filtering steps and model assumptions. By embedding learning within the established UKF framework, DUKF provides both adaptability and a transparent, physically meaningful estimation process. However, its applicability remains limited, as DUKF does not naturally scale to high-dimensional problems and cannot support gradient-based end-to-end training, which constrains its use in modern large-scale learning scenarios. 

DEnKF has further broadened the applicability of these techniques to high-dimensional problems, such as soft robots dynamics estimation [34] and hybrid Bayesian experimental design for model discrepancy calibration [35]. It leverages an ensemble of particles to efficiently represent uncertainty and propagate information through high-dimensional state spaces. By enabling end-to-end training, it can adapt both the underlying dynamics and observation models while retaining the statistical interpretability and parallelizability of classic EnKF frameworks, making it especially suitable for complex, data-rich environments. However, its reliance on linear updates can limit accuracy in strongly nonlinear systems, and the need for large ensembles increases computational cost, which constrains its scalability in practice. 

Beyond the Kalman filter family, differentiable filter has also advanced particle-based methods. Differentiable particle filter (DPF) integrates neural networks with algorithmic priors for end-to-end optimization of the entire particle-filtering process [36]. The proposal mixture neural network for differ- 

3 

entiable particle filters (PropMixNN) uses neural networks to learn proposal distributions in particle filters, reducing estimation errors in highly nonlinear systems [37]. In the context of physics-constrained filter, [38, 39] proposed a physics-constrained dynamic mode decomposition (PCDMD) framework that integrates Kalman filter with physical residuals, leading to improved dynamic mode decomposition based forecasts under noisy or imperfect models. 

Table 1: Comparison of classic differentiable filtering and our methods. 

|Method|Learning/<br>Adaptation|End-to-end<br>Gradient|Nonlinearity<br>Handling|High-Dim<br>Capable|Key<br>Publications|
|---|---|---|---|---|---|
|DEKF|_×_|_×_|_×_|_×_|[32]|
|DUKF|✓|_×_|_×_|_×_|[33]|
|DEnKF|✓|_×_|✓|_×_|[34, 35]|
|DPF|✓|_×_|✓|_△_|[36, 37]|
|**DKF**|✓|✓|✓|✓|**This work**|



**Symbol meanings:** ✓: Supported; _×_ : Not supported; _△_ : Partially supported. 

These works illustrate how differentiable filtering ideas extend beyond Kalman-type algorithms to particle-based and physics-constrained formulations. Although conceptually distinct from sequential filtering, the field inversion and machine learning (FIML) framework introduced by [40] is closely related in spirit: both aim to augment imperfect physics models with datadriven corrections within a gradient-based optimization framework. In FIML, this is achieved by directly inferring spatially distributed functional corrections for computational physics models, rather than simply tuning model parameters. This approach systematically addresses model-form errors by first performing field inversion using observational or high-fidelity data to obtain corrective terms, and then applying machine learning techniques to reconstruct these corrections as functions of relevant variables. The resulting corrected models are then used to augment predictive simulations, significantly improving model accuracy and providing quantified model-form uncertainty. However, classic FIML also has important limitations. It is typically performed as a one-time inversion on a fixed dataset, so the learned corrections remain unchanged during prediction and cannot be adapted as new observations become available. Moreover, its effectiveness depends strongly on access to high-fidelity data and accurate specification of observational covariances, and the inversion process itself can be computationally expensive in high-dimensional settings. Most importantly, FIML focuses on correcting model-form errors in a batch setting but does not integrate with sequential 

4 

state estimation and uncertainty propagation, leaving a gap that motivates our DKF framework. 

To overcome these limitations, our approach formulates the state transition operator as a learnable parameter, refined through field inversion by minimizing the mismatch between predicted and observed data using end-to-end gradient-based optimization. After optimization, a deep neural network is trained to capture the improved dynamics, allowing for flexible and accurate model correction. Compared with classic FIML, which performs one-time batch corrections detached from sequential filtering, our method integrates model correction directly into the DKF pipeline, enabling both states and dynamics to be jointly adapted as new data become available. In contrast to regular DKF approaches that rely solely on automatic differentiation, we incorporate analytically derived gradients, which improve efficiency, stability, and interpretability while preserving mathematical rigor. This systematic design bridges the gap between data assimilation and modern machine learning, providing a principled and scalable way to discover and adapt the underlying dynamics within the DKF pipeline. 

The rest of the paper is organized as follows. We first review the classic Kalman filter framework in Section 2 to motivate the DKF. Next, in Section 3, we present the main algorithm, including the DKF and closure model using machine learning. Finally, we apply the algorithm to two data-driven models in Section 4. 

## **2. Kalman filter** 

The Kalman filter, named after Rudolf E. Kálmán, is an efficient recursive algorithm used to estimate the state of a linear dynamic system from a series of noisy measurements [41]. The ground truth dynamics and measurement are defined by 

**==> picture [321 x 31] intentionally omitted <==**

where **w** _k ∈_ R _[n][x] ∼N_ ( **0** _,_ **Q** _k_ ), and _vk ∈_ R _[n][z] ∼N_ ( **0** _,_ **R** _k_ ) are the external noise. **F** _k ∈_ R _[n][x][×][n][x]_ , **H** _k ∈_ R _[n][z][×][n][x]_ , **B** _k ∈_ R _[n][x][×][n][u]_ , **u** _k ∈_ R _[n][u]_ , **f** _k ∈_ R _[n][x]_ , **Q** _k ∈_ R _[n][x][×][n][x]_ and **R** _k ∈_ R _[n][z][×][n][z]_ denote state transition matrix, observation matrix, control input matrix, control vector, deterministic forcing, covariance matrix of the process noise and the observation noise. The model above 

5 

describe a linear case. The framework can also be extended to nonlinear dynamics and observation operators. 

However, when numerical models are flawed and deviate from the true system, the state–space relations can only be represented approximately: 

**==> picture [329 x 35] intentionally omitted <==**

where the “hatted” operators denote the imperfect model counterparts of the true system matrices: **F**[ˆ] _k ∈_ R _[n][x][×][n][x]_ is the approximate state transition matrix, **B**[ˆ] _k ∈_ R _[n][x][×][n][u]_ the control input matrix, **H**[ˆ] _k ∈_ R _[n][z][×][n][x]_ the observation operator, and[ˆ] **f** _k ∈_ R _[n][x]_ the deterministic forcing. The vectors **x** ˆ _k ∈_ R _[n][x]_ and ˆ **z** _k ∈_ R _[n][z]_ represent the model-predicted state and measurement, respectively. The process and measurement noises are given by **w** ˆ _k ∈_ R _[n][x] ∼N_ ( **0** _,_ **Q**[ˆ] _k_ ) andˆ **v** ˆ _k ∈_ R _[n][z] ∼N_ ( **0** _,_ **R**[ˆ] _k_ ), with covariance matrices **Q**[ˆ] _k ∈_ R _[n][x][×][n][x]_ and _z[×][n] z_ **R** _k ∈_ R _[n]_ . 

At each step _k_ , we define the residuals of the state and covariance as 

**==> picture [372 x 37] intentionally omitted <==**

stacking over all time steps yields the global residual vector 

**==> picture [249 x 65] intentionally omitted <==**

where **x** := [ˆ **x** 1 _, . . . ,_ ˆ **x** _nt_ ] denotes the stacked state vector over the full time horizon, **d** := [ **F**[ˆ] 1 _, . . . ,_ **F**[ˆ] _nt_ ] collects the dynamics operators, and **K** _k_ is given by 

**==> picture [358 x 25] intentionally omitted <==**

details are provided in Appendix A. In the following Section 3, we introduce DKF framework. 

6 

## **3. DKF framework optimization** 

The Kalman filter is a useful tool of data assimilation, which combines the model and the observation to give the best prediction into the future. However, the Kalman filter alters the dynamics of the system indirectly, not affecting the operator, **F**[ˆ] _k_ . In practice, the physics models are usually inaccurate and many times miss critical physics happening in the real world, in other words, **F**[ˆ] _k_ is merely an approximation of the real physics and can be further improved. We propose to use the DKF to help improve the modeling of the underlying physics via gradient-based optimization in Section 3.1. Then, a closure model is trained to discover the underlying dynamics using the optimization solution in Section 3.2. 

## _3.1. Differentiable Kalman filter (DKF)_ 

The DKF formulates the entire Kalman filter process as a differentiable computation, enabling gradients to be computed with respect to model parameters. This allows for efficient field inversion of the dynamics, where the transition operator is optimized to minimize prediction errors, and for rigorous sensitivity computation using adjoint-based methods. We present the following optimization problem: 

**==> picture [241 x 33] intentionally omitted <==**

where the deviation from the true observations serves as the measure of model accuracy, captured by the stacked residual vector 

**==> picture [313 x 30] intentionally omitted <==**

with **H**[ˆ] _k_ the observation matrix, **x** ˆ _k_ the estimated state, and **z** ˆ _k_ the observation at time step _k_ , for _nt_ total time steps. The dynamics is implicitly enforced with the uncertainty treated as “frozen”. Details are in the following Section 3.1.1 and Section 3.1.2. 

## _3.1.1. Field inversion of the dynamics_ 

We treat the filter’s prediction step as a field inversion problem, holding the uncertainty fixed while we adjust the transition operator. Beginning with an initial guess **F**[ˆ][(0)] _k_[, we use gradient-based optimization to find a refined] 

7 

operator **F**[ˆ][(] _k[∗]_[)] that minimizes the mismatch between our predicted measurements and the actual observations. In practice, this means running the standard Kalman predict–update cycles, but allowing the state-transition matrix to adapt so that the filter’s forecast residuals are as small as possible. 

We begin by embedding the transition operator directly in the Kalman predict-update loop and then perform gradient-based optimization on those matrices to minimize the forecast residuals. By iterating this procedure, we discover a refined, state-dependent approximation of the true dynamics. Finally, we replace the original, hand-tuned operator with the optimized matrices, closing the loop and yielding more accurate predictions and more reliable uncertainty estimates in subsequent filtering steps. 

## _3.1.2. Sensitivity computation_ 

The field inversion procedure described in the previous Section 3.1.1 relies on optimizing the state transition matrices **F**[ˆ] _k_ so that the predicted observations from the Kalman filter best match the actual measurements. This optimization is achieved through a gradient-based approach, which in turn depends critically on the ability to efficiently compute the sensitivity of the loss function with respect to the design variables. 

Specifically, we formulate the prediction error across all time steps as the loss function Eq. (6), and our design variable vector **d** is constructed by [ **F**[ˆ] 1 _,_ **F**[ˆ] 2 _, . . . ,_ **F**[ˆ] _nt_ ]. To perform the optimization in Eq. (6), we require the gradient d _f/_ d **d** . Because the Kalman filter involves a sequence of recursive operations—each depending on previous estimates, covariances, and transition matrices—directly computing this gradient is computationally prohibitive, especially in high dimensions. Instead, we adopt the adjoint method, which is both efficient and analytically tractable for large-scale systems. 

Following the methodology introduced by [42], We consider a system governed by a set of residual equations which we have defined in Eq.(4). Our goal is to minimize a function of interest _f_ ( **x** _,_ **d** ). The adjoint method provides an efficient way to compute the sensitivity d _f/_ d **d** via 

**==> picture [261 x 59] intentionally omitted <==**

8 

Incorporating the equation, we have 

**==> picture [324 x 94] intentionally omitted <==**

where we can further decompose the equation with respect to **x** _k_ and **P** _k_ : 

**==> picture [274 x 36] intentionally omitted <==**

**==> picture [285 x 37] intentionally omitted <==**

**==> picture [272 x 95] intentionally omitted <==**

where we can further decompose the equation with respect to the state **x** _k_ and the covariance **P** _k_ . For convenience, we define the augmented variable 

**==> picture [265 x 37] intentionally omitted <==**

where vec( _·_ ) denotes the column-wise vectorization of a matrix, **x** _k ∈_ R _[n][x]_ is the state vector, **P** _k ∈_ R _[n][x][×][n][x]_ is the covariance matrix, and _np_ = _n_[2] _x_[if][the] full matrix is vectorized. Accordingly, the adjoint vector and the gradient of 

9 

the objective with respect to **y** _k_ can be written in block form as 

**==> picture [252 x 109] intentionally omitted <==**

here, _**ψ** k,_ **x** _∈_ R _[n][x]_ and _∂f/∂_ **x** _k ∈_ R _[n][x]_ correspond to the state block, while _**ψ** k,_ **P** _∈_ R _[n][p]_ and vec( _∂f/∂_ **P** _k_ ) _∈_ R _[n][p]_ correspond to the covariance block. 

The Eqs. (12) and (13) are usually problem specific and can be easily computed. For the block matrices in Eqs. (10) and (11), we have derived the analytic forms of them. We present them here 

**==> picture [368 x 153] intentionally omitted <==**

We have verified these formulas numerically and the detailed derivation can be found in Appendix B. 

In summary, sensitivity computation using the adjoint method provides an efficient and robust means to evaluate the gradients needed in the optimization of the transition matrices **F**[ˆ] _k_ . Compared with automatic differentiation frameworks such as JAX [43], the analytic adjoint formulation avoids the overhead of unrolling the entire filtering process, thereby reducing memory cost and improving numerical stability, especially for long horizons. By combining these analytic sensitivities with the DKF structure, we enable scalable field inversion of dynamics. Next we will describe the closure model 

10 

using machine learning in the following Section 3.2. 

## _3.2. Closure model using machine learning_ 

Once the system dynamics have been identified through field inversion in the first stage, we introduce a machine learning model to generalize these dynamics. Specifically, the transition operator is parameterized by a deep neural network 

**==> picture [242 x 16] intentionally omitted <==**

where _**θ**_ denotes the trainable weights and biases. The transition operator defines the model obtained through field inversion of the imperfect model in Eq. (2). The network is trained to reproduce the optimized operators obtained in the first stage by minimizing 

**==> picture [239 x 32] intentionally omitted <==**

where the loss function is defined as the Frobenius norm of the difference, 

**==> picture [214 x 33] intentionally omitted <==**

with _nt_ the number of time steps. 

Once this step is done, the discovered dynamics can be used to replace the original dynamics **F**[ˆ] in the Kalman filter. Here, the discovered dynamics are parameterized by a multilayer perceptron (MLP). 

This two-stage workflow enables the integration of data-driven models into the classic Kalman filter framework. In the first phase, the underlying system dynamics are revealed through field inversion or direct optimization, providing an interpretable sequence of transition operators that best match the observed data. In the second phase, we leverage the expressive power of neural networks to learn a parameterized mapping from the latent state and design variables to the optimal transition matrices, effectively encoding complex, possibly nonlinear dependencies that are difficult to capture analytically. 

The neural network `DNN` ( **x** _,_ **d** ; _**θ**_ ) acts as a flexible surrogate for the transition operator, allowing for rapid, state-dependent updates during filtering. 

11 

The training objective `loss` ( **F**[ˆ] _**θ** ,_ **F**[ˆ] ) ensures that the learned model closely approximates the optimal operators identified in the first stage, while also enabling generalization to new states or operating regimes. 

By embedding the discovered dynamics into the Kalman filter, we obtain a hybrid framework that combines the statistical rigor of state estimation with the adaptability of machine learning. This approach improves predictive accuracy, enables real-time adaptation to changing system conditions, and offers a scalable path for assimilating large, heterogeneous datasets. The effectiveness of this strategy will be further demonstrated in the following numerical experiments. 

## **4. Numerical experiments** 

To demonstrate the interpretability of the proposed DKF methodology, we conduct two numerical experiments, which include a classic rocket dynamics system in Section 4.1 and a nonlinear reaction-diffusion equation (the Allen–Cahn boundary value problem) in Section 4.2. These examples are chosen to cover both low and high dimensional dynamical systems with different types of parameters and noise structures. The results highlight the robustness, accuracy, and flexibility of our approach for field inversion and dynamics discovery in complex, noisy environments. Detailed descriptions of the models, experimental setups, and comparative analyses are provided in the following subsections. 

## _4.1. Rocket model_ 

A simple test case for the DKF is a rocket launching problem. The rocket has a thrust till time exceeds the burn time, then it behaves like a free-falling object under gravity. The governing equation is defined by 

**==> picture [276 x 15] intentionally omitted <==**

where 

**==> picture [314 x 76] intentionally omitted <==**

12 

_FT_ is the thrust and _m_ is the mass, and **w** ˆ _k ∈_ R _[n][x] ∼N_ ( **0** _,_ **Q**[ˆ] _k_ ) denotes the external noise, **Q**[ˆ] _k_ is the covariance matrix of the observation noise. We measure the altitude of the rocket, so the observation operator becomes: 

**==> picture [231 x 23] intentionally omitted <==**

Here, the transition matrix **F**[ˆ] _k_ is known. In a general case, this matrix may not be known with certainty, that is, cases with unknown or partially known dynamics. In such a case, we can treat the matrices **F**[ˆ] _k_ as unknown design variables. And the optimization problem as described in Eq. (6) becomes: find the matrices **F** _k_ , across all time steps, such that the estimated value of ˆ **x** _k_ becomes close to the measured value. 

We consider a dynamical system governed by physical processes such as thrust and gravity, where the goal is to estimate the system state from noisy observations. In this setting, the state transition matrix **F**[ˆ] _k_ at each time step is assumed unknown and is treated as a design variable to be identified. The observation operator and noise covariance matrices are specified according to the system’s physical characteristics. 

Given a sequence of noisy observation _{_ **z** ˆ _k}[n] k_ =1 _[t]_[,][the][objective][is][to][de-] termine the transition matrices **F**[ˆ] _k_ that minimizes the discrepancy between the predicted (filtered) states and the observations over the trajectory. The estimation problem is formulated as the following optimization: 

**==> picture [257 x 53] intentionally omitted <==**

ˆ ˆ where **x** _k_ denotes the posterior state estimate at each filtering step, **z** _k_ is the observed data, and **H**[ˆ] _k_ is the observation matrix. The full parameter vector is constructed by concatenating the sequence of **F**[ˆ] _k_ matrices across all time steps. We will solve this optimization problem in the next subsection. 

## _4.1.1. Solution of optimization problem_ 

To efficiently solve this optimization problem, we leverage the DKF framework and compute gradients of the loss function with respect to **d** using the adjoint method. Analytic Jacobian block matrices are derived and assembled based on theoretical results to ensure numerical stability and accurate gradi- 

13 

ent evaluation. The sequence **F**[ˆ] _k_ is initialized as small perturbations around a physically reasonable baseline, and iterative optimization is performed using the L-BFGS algorithm. 

Table 2 presents a comparison of the state transition matrices at selected time steps, showing the true values, initial values, and the optimized results. The optimized **F** _k_ matrices consistently approach the true dynamics, demonstrating the effectiveness of the inversion process. 

Finally, the impact of the optimized parameters on filtering performance is systematically evaluated under various observation noise levels. The black solid line (“True Position”) shows the ground truth trajectory of the system generated by the dynamics. The red dots (“Observations”) indicate the observed values at each time step, which are influenced by Gaussian noise with the standard deviation _σ_ specified in each subplot. The blue line (“DKF”) corresponds to the filtered state estimates obtained by the DKF using the optimized transition matrix sequence **F** _k_ . The purple solid line (“KF”) represents the filter output when using the initial **F**[ˆ] _k_ sequence without optimization. The results in Fig. 1 illustrate the filtering performance of the optimized system under various observation noise levels. 

Table 2: Comparison of the global state transition matrix **F** _k_ (true, initial, and optimized) for different observation noise levels. 

|_σ_||True|**F**_k_||Initial|ˆ**F**_k_||Optimized **F**_k_|Optimized **F**_k_|
|---|---|---|---|---|---|---|---|---|---|
|0_._005|�|1_._000000<br>0_._000000|0_._100000<br>1_._000000<br>�|�|0_._957691<br>_−_0_._072960|0_._088596<br>0_._967528<br>�|�|1_._002941<br>_−_0_._000087|0_._100005<br>0_._997059<br>�|
|0_._025|�|1_._000000<br>0_._000000|0_._100000<br>1_._000000<br>�|�|0_._957691<br>_−_0_._072960|0_._088596<br>0_._967528<br>�|�|1_._003099<br>_−_0_._000109|0_._097841<br>0_._997220<br>�|
|0_._125|�|1_._000000<br>0_._000000|0_._100000<br>1_._000000<br>�|�|0_._957691<br>_−_0_._072960|0_._088596<br>0_._967528<br>�|�|1_._003100<br>_−_0_._000109|0_._097842<br>0_._997221<br>�|



As the noise standard deviation increases, the tracking accuracy of the filter generally decreases. However, for all noise levels, the optimized **F** _k_ sequence consistently provides a closer fit to the true state than the unoptimized **F** _k_ sequence, demonstrating the effectiveness of the optimization procedure. In particular, at low noise levels ( _σ_ = 0 _._ 005 and _σ_ = 0 _._ 025), the optimized filter nearly overlaps with the true state trajectory, whereas 

14 

**==> picture [390 x 326] intentionally omitted <==**

Figure 1: Optimization results for three levels of observation noise: _σ_ = 0 _._ 005 _,_ 0 _._ 025 _,_ 0 _._ 125. 

15 

the initial estimate shows noticeable bias. Even as the noise increases to _σ_ = 0 _._ 125, the optimized filter maintains a robust performance and clearly outperforms the unoptimized case. 

While the current study focuses on a low-dimensional rocket model, in practice, many dynamical systems of interest are high-dimensional, resulting in a large covariance matrix **P** _k_ . For high-dimensional systems, direct update of the full covariance matrix **P** _k_ is computationally expensive and often infeasible. To overcome this, one effective approach is to use a blockdiagonal or localized structure for **P** _k_ , which only tracks correlations between closely related variables and ignores weak or distant dependencies, thereby significantly reducing computational load. Another approach is to employ low-rank or subspace approximations—such as principal component analysis (PCA) or singular value decomposition (SVD)—to represent **P** _k_ in terms of its most important modes. 

These results confirm that the proposed method can effectively learn the underlying system parameters and improve filtering accuracy, even in the presence of significant observation noise. 

## _4.2. Allen–Cahn boundary value problem_ 

The Allen–Cahn equation is a prototypical nonlinear reaction–diffusion model that captures phase separation and interface dynamics in multi-component systems [44, 45, 46, 47]. In this section, we consider a boundary value problem governed by a generalized Allen–Cahn equation with nonlinear, statedependent diffusion. Our aim is to recover the underlying dynamics and explore robust state estimation under various observation noise levels. 

This section is organized as follows. We first present the mathematical formulation of the governing Allen–Cahn equation in Section 4.2.1. We then describe the solution scheme of the boundary value problem in Section 4.2.2. A central focus is placed on the DKF, which enables direct learning of the system’s underlying dynamics from noisy observations Section 4.2.3. Finally, we compare the prediction accuracy by examining both the mean and variance of their estimated states in Section 4.2.4 and Section 4.2.5. 

16 

## _4.2.1. Governing equation_ 

The system is governed by a nonlinear reaction–diffusion equation with state-dependent diffusivity: 

**==> picture [316 x 30] intentionally omitted <==**

where _d_ ( _v_ ) = 0 _._ 1 tanh( _v_ ). We impose periodic boundary conditions to ensure both the solution and its derivative are continuous at the domain endpoints: 

**==> picture [307 x 26] intentionally omitted <==**

The initial condition is a stripe pattern with a small sinusoidal perturbation, projected onto [0 _,_ 1]: 

**==> picture [297 x 56] intentionally omitted <==**

**==> picture [297 x 14] intentionally omitted <==**

where _A_ = 0 _._ 18, _k_ = 3, _ϕ ∼U_ (0 _,_ 2 _π_ ), _m_ stripes _∈_ N (we use _m_ stripes = 8), and Π[0 _,_ 1]( _w_ ) := min _{_ 1 _,_ max _{_ 0 _, w}}_ denotes projection onto [0 _,_ 1] (here _w_ is only a dummy variable used to define the projection operator; in practice it is replaced by the specific argument, e.g. _v_ ˜0( _x_ )). Here, _b_ ( _x_ ) is a 0 _/_ 1 stripe template marking the two phases; _v_ ˜0( _x_ ) adds a small within-stripe sinusoidal variation; and _v_ 0( _x_ ) is the clipped initial condition enforcing bounds [0 _,_ 1]. 

## _4.2.2. Solution method_ 

This experiment focuses on Section 4.2.1. The system is discretized over _N_ = 16 spatial grid points and _T_ = 30 time steps. The spatial mesh size is _dx_ = _l/N_ , and the time step is _dt_ = 0 _._ 01. 

To investigate this inverse problem, we generate synthetic data by time marching the conservative form of the reaction–diffusion dynamics with periodic boundaries. At each time step we first evaluate the nonlinear diffusivity _d[n] i_[:=] _[ d]_[(] _[v] i[n]_[) = 0] _[.]_[1][tanh(] _[v] i[n]_[)][at][cell][centers][and][then][form][face][coefficients][by] arithmetic averaging _d[n] i_ +[1] 2[:=][1] _[/]_[2 (] _[d][n] i_[+] _[ d][n] i_ +1[)][(periodic][indexing).][The][state] 

17 

is advanced by an explicit Euler scheme using fluxes 

**==> picture [376 x 113] intentionally omitted <==**

gaussian noise with varying standard deviation is added independently to all ˆ spatial points at each time step to generate the observation sequence **z** _t_ . 

A key feature of our approach is that, instead of assuming the system dynamics are fully known, we leverage the DKF to simultaneously perform filtering and operator learning. The diffusivity _d_ ( _v_ ) is represented as independent values on a uniform grid of state amplitudes, allowing local adaptation to different regions of the state space. Specifically, we introduce tabulated parameters _d_[˜] ( _vj_ ), where each _d_[˜] ( _vj_ ) denotes the learned diffusivity value associated with grid point _vj_ in the state domain. These table values _{d_[˜] ( _vj_ ) _}_ are optimized to minimize the mean squared innovation between predicted and observed data. Formally, the loss is defined as 

**==> picture [274 x 53] intentionally omitted <==**

where **S** _t_ is the innovation covariance from the Kalman filter. Whitening by **S** _[−] t_[1] _[/]_[2] ensures statistical consistency by accounting for the varying uncertainty at each time step. The optimized diffusivity table then defines the operator sequence **F** _k_ , which provides a data-driven approximation of the true dynamics and is used to reconstruct the state trajectory. 

In addition, we train a neural network surrogate to predict _d_ ( _v_ ) directly from the state _v_ . The network is trained on the field-inversion results by minimizing the mean squared error between its predicted diffusivity and the reference table values (with preprocessing to improve robustness). Once trained, the neural network–based _d_ ( _v_ ) is used to reconstruct the state evolution over the entire time window. 

18 

## _4.2.3. Learning the underlying dynamics via DKF_ 

A central aim of this work is to learn the underlying dynamics of the system directly from noisy observations. Here, “dynamics” refer to the latent operator **F**[ˆ] _k_ that governs the system’s evolution at each time step. While the classic Kalman filter typically assumes these dynamics are known and fixed, our DKF framework enables adaptive, data-driven discovery of the governing operator **F**[ˆ] _k_ . 

More specifically, instead of directly optimizing the full discrete evolution operator **F**[ˆ] _k_ , we adopt a physics-informed approach by optimizing the nonlinear diffusivity _d_ ( _v_ )—using either an explicit parametric form, a nonparametric point-wise representation on a uniform _u_ -grid, or, in post-processing, a neural network fitted to the inferred _d_ ( _v_ ). This ensures that the learned dynamics remain physically consistent ( _e.g._ , _d_ ( _v_ ) _>_ 0) and interpretable. The system operator **F**[ˆ] _k_ is then constructed as a function of _d_ ( _v_ ), thus ensuring that the learned dynamics remain physically consistent and interpretable. This strategy allows DKF to actively learn and refine the true physical law driving the process, even in the presence of substantial observational noise. At each time step _k_ , the operator **F**[ˆ] _k_ is constructed as 

**==> picture [319 x 30] intentionally omitted <==**

optionally with an additive bias term _bk_ = 2∆ _t vk_[3][arising][from][the][nonlinear] reaction term. Here, **I** is the identity matrix, and _d_ 2 is the central-difference Laplacian with periodic boundary conditions: 

**==> picture [286 x 73] intentionally omitted <==**

where _N_ is the number of spatial grid points. This structure ensures that the estimated dynamics remain consistent with the underlying physical process, while reducing the dimensionality and improving the interpretability of the inverse problem. 

The results in Fig. 2 highlight the effectiveness of our framework in recovering the underlying diffusion law. First, the pointwise inversion performed 

19 

**==> picture [390 x 216] intentionally omitted <==**

Figure 2: Comparison of _d_ ( _v_ ) estimated by different methods under different noise levels _σ_ = 0 _._ 0025, 0 _._ 005, and 0 _._ 01. Dots indicate field inversion results, solid lines indicate DNN fits, the black line shows the ground truth _d_ ( _v_ ) = 0 _._ 1 tanh( _v_ ), and the red line denotes the constant initial guess _d_ ( _v_ ) _≡_ 1 _._ 0. 

via DKF optimization successfully reconstructs the nonlinear diffusivity _d_ ( _v_ ) across all noise levels. Even under relatively large observational noise, the inverted values preserve the correct functional form and monotonic trend of _d_ ( _v_ ), closely following the ground truth. This confirms that the DKF can directly infer reliable operator values from noisy and partial measurements without relying on a restrictive parametric assumption. 

On top of the inversion, we further train deep neural networks to approximate _d_ ( _v_ ) using the DKF-inferred trajectories. The trained DNN models not only reproduce the inversion results with high fidelity but also yield smooth, continuous reconstructions that enhance generalization beyond the sampled states. Importantly, the DNN outputs remain consistent with the physical constraints (e.g., _d_ ( _v_ ) _>_ 0) while providing a compact and interpretable representation of the learned dynamics. 

Together, these results demonstrate that our two-stage strategy—pointwise DKF inversion followed by DNN training—achieves both accuracy and robustness: the inversion ensures faithful recovery of the true operator from noisy data, while the DNN serves as a stable surrogate that captures the 

20 

same physics in a smooth and generalizable manner. 

To quantitatively evaluate the quality of this learned operator, we compare the inferred **F**[ˆ] _k_ at each time step against the true operator **F**[true] _k_ used to generate the synthetic data. Specifically, we report the relative Frobenius norm error: 

**==> picture [72 x 32] intentionally omitted <==**

as a function of time, for both the initial guess and the optimized result after field inversion and DNN training. 

**==> picture [390 x 208] intentionally omitted <==**

Figure 3: Time evolution of the relative Frobenius norm error _∥_ **F**[ˆ] _k −_ **F**[true] _k ∥F /∥_ **F**[true] _k ∥F_ between the learned dynamical operator and the ground truth, for three levels of observation noise: _σ_ = 0 _._ 0025, 0 _._ 005, and 0 _._ 01. 

As shown in Fig. 3, the initial transition matrix (black line) exhibits a large and persistent error with respect to the true dynamics, remaining around 0 _._ 25 over the entire time horizon. By contrast, both the inversion results (solid colored lines) and the DNN predictions (lighter lines) achieve much smaller errors, consistently staying within the range 0 _._ 00–0 _._ 05. This demonstrates that the proposed framework consistently learns transition matrix that accurately approximates the true dynamics across all tested noise levels. Nevertheless, the DKF framework achieves a substantial error reduction compared to the initial guess, even at the highest noise level. 

21 

These results demonstrate that the DKF approach not only enables effective filtering and smoothing, but also robust, data-driven identification of underlying dynamics from noisy measurements. The learned time-varying transition matrix **F** _k_ provide interpretable, physically meaningful surrogates for the unknown evolution law, even when direct physical modeling is unavailable or inaccurate. 

## _4.2.4. Prediction of mean_ 

To evaluate the benefits of field inversion and machine learning in mean state estimation, we compare spatiotemporal reconstructions under varying observation noise, as shown in Fig. 4. Each row in Fig. 4 presents the results for a different noise level ( _σ_ = 0 _._ 0025, 0 _._ 005, 0 _._ 01), with columns displaying, from left to right, the sparse observations ˆ **z** _k_ , the ground truth _v_ true _[k]_[,][the] classic Kalman filter predictions without inversion _v_ no_inv _[k]_[,][the][DKF][field][in-] version _v_ inv _[k]_[, the DNN predictions] _[ v]_ DNN _[k]_[, and the corresponding absolute error] fields _|v_ inv _[k][−][v]_ true _[k][|]_[and] _[|][v]_ DNN _[k][−][v]_ true _[k][|]_[.][In][the][first][column,][the][sparse][observa-] tions are illustrated by overlaying vertical white lines on the spatiotemporal field, clearly indicating the specific grid points where measurements are available, while the rest of the domain remains unobserved. 

As the noise increases, the classic Kalman filter, which relies on a fixed and potentially mismatched dynamical operator, gradually accumulates bias and exhibits amplified errors—particularly in regions of sharp gradients and in later time steps. This is visually apparent in both the reconstructed profiles and the error fields, where the classic Kalman filter struggles to track the true state and produces distorted mean profiles when the signal-to-noise ratio is low. 

In contrast, the DKF is able to directly correct the underlying dynamics by learning from data, significantly reducing both bias and variance in the estimated states. The error fields confirm that the DKF approach not only suppresses noise amplification but also effectively eliminates large-scale model mismatch. The advantage of this inversion step is particularly prominent at moderate and relatively high noise levels, where operator correction plays a crucial role in maintaining robust estimation accuracy. 

Building upon the improved trajectories from field inversion, the subsequent machine learning step further enhances predictive performance. The neural network surrogate, trained on DKF-optimized samples, accurately recovers the underlying diffusion operator and achieves near-perfect agreement with the true mean state—even in the presence of sparse and noisy observa- 

22 

**==> picture [390 x 354] intentionally omitted <==**

Figure 4: Spatiotemporal reconstruction under different observation noise levels ( _σ_ = ˆ 0 _._ 0025, 0 _._ 005, 0 _._ 01; rows). Columns show sparse observations **z** _k_ , ground truth _v_ true _[k]_[,] Kalman filter without inversion _v_ no_inv _[k]_[,][DKF][inversion] _[v]_ inv _[k]_[,][DNN][predictions] _[v]_ DNN _[k]_[,][and] the corresponding error fields. White vertical lines in the first column mark observed locations. 

23 

tions. This data-driven approach not only matches the field inversion result but also demonstrates strong generalization. As a result, the closure model closely follows the ground truth and outperforms all other methods under increasing noise. 

## _4.2.5. Prediction of variance_ 

**==> picture [390 x 357] intentionally omitted <==**

Figure 5: Evolution of the diagonal elements of the covariance matrix **P** _k_ and the corresponding absolute estimation errors under different observation noise levels ( _σ_ = 0 _._ 0025, 0 _._ 005, 0 _._ 01). Panels show the ground truth, Kalman filter without inversion, DKF inversion, DNN prediction, and their respective errors. 

Accurate estimation of the posterior covariance matrix is essential for quantifying uncertainty in nonlinear state estimation tasks. The sequence of 

24 

covariance matrices **P** _k_ provides not only a measure of confidence in the predicted states, but also enables principled uncertainty propagation for downstream inference or control. 

In Fig. 5, we present a comprehensive comparison of posterior variance estimation and error quantification under different observation noise levels ( _σ_ = 0 _._ 0025 _,_ 0 _._ 005 _,_ 0 _._ 01). The first panel serves as the reference, revealing the true spatial and temporal structure of the variance field [ **P** _[k]_ true[]] _[ii]_[.][The] second panel shows the posterior variance obtained from the classic Kalman filter without field inversion [ **P** _[k]_ no_inv[]] _[ii]_[,][while][the][third][panel][displays][the] posterior variance recovered via differentiable field inversion [ **P** _[k]_ inv[]] _[ii]_[.] The fourth panel reports the posterior variance predicted directly by the deep neural network [ **P** _[k]_ DNN[]] _[ii]_[.][To][facilitate][direct][comparison][against][the][ground] truth, the fifth panel visualizes the absolute error of the no-inversion estimate _|_ [ **P** _[k]_ no_inv[]] _[ii][−]_[[] **[P]** _[k]_ true[]] _[ii][|]_[,][the][sixth][panel][shows][the][error][of][the][DKF][estimate] _|_ [ **P** _[k]_ inv[]] _[ii][−]_[[] **[P]** _[k]_ true[]] _[ii][|]_[, and the seventh panel displays the corresponding error for] the neural network prediction _|_ [ **P** _[k]_ DNN[]] _[ii][ −]_[[] **[P]** true _[k]_[]] _[ii][|]_[.][At][the][lowest][noise][level] ( _σ_ = 0 _._ 0025), all three estimation strategies produce variance maps that are nearly indistinguishable from the ground truth, as confirmed by the very low and spatially uniform absolute errors in the rightmost panels. As the noise level increases, the limitations of the classic Kalman filter (no inversion) become apparent: its posterior variance exhibits systematic deviations from the true uncertainty, leading to persistent and sometimes spatially structured errors, especially in regions of high variability or low information. 

In contrast, both the DKF and DNN approaches maintain high-fidelity variance estimation even under substantial noise. The DKF leverages datadriven operator correction to dynamically adapt its uncertainty quantification, closely matching the true variance in both magnitude and spatial pattern. The DNN surrogate, trained on DKF-optimized operator, inherits and even strengthens this capability, achieving uniformly low absolute errors across the entire domain. This robust performance highlights the critical advantage of field inversion and machine learning in capturing not only the mean but also the variance associated with each state estimate. 

Overall, these results demonstrate that, while classic Kalman filtering may significantly misestimate uncertainty when the model is mismatched or noise is high, field inversion and machine learning can provide trustworthy, spatially resolved quantification of prediction confidence—a capability essential for reliable scientific inference and downstream decision-making in 

25 

partially observed dynamical systems. 

## **5. Conclusion** 

In this paper, we presented a differentiable Kalman filtering (DKF) framework that integrates physics-based state estimation with machine learning–driven model discovery. Classic Kalman filters are constrained by the assumption of fixed, often imperfect dynamics. By introducing a two-level adjoint-based optimization procedure, our approach—-DKF-based field inversion coupled with machine learning—adaptively corrected the dynamics model using observed data, while leveraging neural operators for enhanced predictive capability. 

We demonstrated the effectiveness of this framework on two representative benchmarks: a rocket model with algebraic dynamics and a nonlinear reaction–diffusion PDE (the Allen–Cahn equation). In both cases, our method consistently outperformed the classic Kalman filter in terms of state reconstruction accuracy and robustness to observation noise. For example, in the Allen–Cahn system, we achieved a root mean square error (RMSE) of _d_ ( _v_ ) below 10 _[−]_[2] across moderate noise levels ( _σ_ = 0 _._ 0025 to 0 _._ 01), representing an improvement of at least two orders of magnitude compared to the classic Kalman filter. Furthermore, our deep neural network, trained on field-inverted trajectories, reduced estimation errors even further and exhibited strong generalization under substantial observational noise. 

Beyond accuracy, the framework provided interpretable uncertainty quantification through principled covariance propagation. The field inversion step yielded physical insight into the governing dynamics, while the machine learning component enhanced flexibility and generalization. 

Future work will extend this framework to more complex PDEs and multi-physics systems, incorporating Bayesian priors and ensemble-based approaches to further improve uncertainty quantification and enable real-time inference. 

## **References** 

- [1] S. Rezaei, R. Sengupta, Kalman filter based integration of DGPS and vehicle sensors for localization, in: IEEE International Conference Mechatronics and Automation, 2005, ICMA-05, IEEE, 2005, p. 455–460. `doi:10.1109/icma.2005.1626590` . 

26 

- [2] J. Liu, G. Guo, Vehicle localization during GPS outages with extended Kalman filter and deep learning, IEEE Transactions on Instrumentation and Measurement 70 (2021) 1–10. `doi:10.1109/tim.2021.3097401` . 

- [3] Y. Lu, H. Ma, E. Smart, H. Yu, Real-time performance-focused localization techniques for autonomous vehicle: A review, IEEE Transactions on Intelligent Transportation Systems 23 (7) (2022) 6082–6100. `doi:10.1109/tits.2021.3077800` . 

- [4] A. Chalvatzaras, I. Pratikakis, A. A. Amanatiadis, A survey on mapbased localization techniques for autonomous vehicles, IEEE Transactions on Intelligent Vehicles 8 (2) (2023) 1574–1596. `doi:10.1109/tiv. 2022.3192102` . 

- [5] B. O. Teixeira, M. A. Santillo, R. S. Erwin, D. S. Bernstein, Spacecraft tracking using sampled-data Kalman filters, IEEE Control Systems Magazine 28 (4) (2008) 78–94. `doi:10.1109/mcs.2008.923231` . 

- [6] M. Zahaby, P. Gaonjur, S. Farajian, Location tracking in GPS using Kalman filter through SMS, in: IEEE EUROCON 2009, IEEE, 2009, p. 1707–1711. `doi:10.1109/eurcon.2009.5167873` . 

- [7] Y. Yang, X. Yue, A. G. Dempster, GPS-based onboard real-time orbit determination for leo satellites using consider Kalman filter, IEEE Transactions on Aerospace and Electronic Systems 52 (2) (2016) 769–777. `doi:10.1109/taes.2015.140758` . 

- [8] W. Pei, X. Lu, Moving object tracking in satellite videos by kernelized correlation filter based on color-name features and Kalman prediction, Wireless Communications and Mobile Computing 2022 (2022) 1–16. `doi:10.1155/2022/9735887` . 

- [9] S.-C. Huang, N.-Y. Wang, T.-Y. Li, Y.-C. Lee, L.-F. Chang, T.-H. Pan, Financial forecasting by modified Kalman filters and kernel machines, Journal of Statistics and Management Systems 16 (2–03) (2013) 163–176. `doi:10.1080/09720510.2013.777575` . 

- [10] X. Bao, Q. Tao, H. Fu, Dynamic financial distress prediction based on Kalman filtering, Journal of Applied Statistics 42 (2) (2014) 292–308. `doi:10.1080/02664763.2014.947359` . 

27 

- [11] M. Khashei, B. Mahdavi Sharif, A Kalman filter-based hybridization model of statistical and intelligent approaches for exchange rate forecasting, Journal of Modelling in Management 16 (2) (2020) 579–601. `doi:10.1108/jm2-12-2019-0277` . 

- [12] G. Rodriguez, Kalman filtering, smoothing, and recursive robot arm forward and inverse dynamics, IEEE Journal on Robotics and Automation 3 (6) (1987) 624–639. `doi:10.1109/jra.1987.1087147` . 

- [13] M. Gautier, P. Poignet, Extended Kalman filtering and weighted least squares dynamic identification of robot, Control Engineering Practice 9 (12) (2001) 1361–1372. `doi:10.1016/s0967-0661(01)00105-8` . 

- [14] G. Du, P. Zhang, A markerless human–robot interface using particle filter and Kalman filter for dual robots, IEEE Transactions on Industrial Electronics 62 (4) (2015) 2257–2264. `doi:10.1109/tie.2014.2362095` . 

- [15] Martin, D. I. H. Putri, Riyanto, C. Machbub, Gait controllers on humanoid robot using Kalman filter and PD controller, in: 2018 15th International Conference on Control, Automation, Robotics and Vision (ICARCV), IEEE, 2018, p. 36–41. `doi:10.1109/icarcv.2018. 8581061` . 

- [16] K. Lee, K. T. Carlberg, Model reduction of dynamical systems on nonlinear manifolds using deep convolutional autoencoders, Journal of Computational Physics 404 (2020) 108973. `doi:10.1016/j.jcp.2019.108973` . 

- [17] J. Humpherys, P. Redd, J. West, A fresh look at the Kalman filter, SIAM Review 54 (4) (2012) 801–823. `doi:10.1137/100799666` . 

- [18] J. Kao, D. Flicker, R. Henninger, S. Frey, M. Ghil, K. Ide, Data assimilation with an extended Kalman filter for impact-produced shock-wave dynamics, Journal of Computational Physics 196 (2) (2004) 705–723. `doi:10.1016/j.jcp.2003.11.028` . 

- [19] M. Branicki, B. Gershgorin, A. Majda, Filtering skill for turbulent signals for a suite of nonlinear and linear extended Kalman filters, Journal of Computational Physics 231 (4) (2012) 1462–1498. `doi: 10.1016/j.jcp.2011.10.029` . 

28 

- [20] K. György, A. Kelemen, L. Dávid, Unscented Kalman filters and particle filter methods for nonlinear state estimation, Procedia Technology 12 (2014) 65–74. `doi:10.1016/j.protcy.2013.12.457` . 

- [21] W. Kang, S. King, L. Xu, A Sparse-grid UKF For The State Estimation of PDEs, Society for Industrial and Applied Mathematics, 2017, p. 101–106. `doi:10.1137/1.9781611975024.14` . 

- [22] U. Z. Ijaz, A. K. Khambampati, J. S. Lee, S. Kim, K. Y. Kim, Nonstationary phase boundary estimation in electrical impedance tomography using unscented Kalman filter, Journal of Computational Physics 227 (15) (2008) 7089–7112. `doi:10.1016/j.jcp.2007.12.025` . 

- [23] G. Evensen, The ensemble Kalman filter: theoretical formulation and practical implementation, Ocean Dynamics 53 (4) (2003) 343–367. `doi: 10.1007/s10236-003-0036-9` . 

- [24] I. Grooms, Y. Lee, A. J. Majda, Ensemble Kalman filters for dynamical systems with unresolved turbulence, Journal of Computational Physics 273 (2014) 435–452. `doi:10.1016/j.jcp.2014.05.037` . 

- [25] J. Harlim, A. Mahdi, A. J. Majda, An ensemble Kalman filter for statistical estimation of physics constrained nonlinear regression models, Journal of Computational Physics 257 (2014) 782–812. `doi:10.1016/ j.jcp.2013.10.025` . 

- [26] W. Xie, Z. Wang, J. Kim, X. Sun, Y. Li, A novel ensemble Kalman filter based data assimilation method with an adaptive strategy for dendritic crystal growth, Journal of Computational Physics 524 (2025) 113711. `doi:10.1016/j.jcp.2024.113711` . 

- [27] B. Sebacher, R. Hanea, A. Heemink, A probabilistic parametrization for geological uncertainty estimation using the ensemble Kalman filter (EnKF), Computational Geosciences 17 (5) (2013) 813–832. `doi:10. 1007/s10596-013-9357-z` . 

- [28] P. Del Moral, A. Doucet, S. S. Singh, Uniform stability of a particle approximation of the optimal filter derivative, SIAM Journal on Control and Optimization 53 (3) (2015) 1278–1304. `doi:10.1137/140993703` . 

29 

- [29] A. Kloss, G. Martius, J. Bohg, How to train your differentiable filter, Autonomous Robots 45 (4) (2021) 561–578. `doi:10.1007/ s10514-021-09990-9` . 

- [30] X. Liu, G. Clark, J. Campbell, Y. Zhou, H. B. Amor, Enhancing state estimation in robots: A data-driven approach with differentiable ensemble Kalman filters, in: 2023 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS), IEEE, 2023, p. 1947–1954. `doi:10.1109/iros55552.2023.10341617` . 

- [31] S. Shen, J. Chen, G. Yu, Z. Zhai, P. Han, KalmanFormer: using transformer to model the Kalman gain in Kalman filters, Frontiers in Neurorobotics 18 (Jan. 2025). `doi:10.3389/fnbot.2024.1460255` . 

- [32] N. A. Piga, U. Pattacini, L. Natale, A differentiable extended Kalman filter for object tracking under sliding regime, Frontiers in Robotics and AI 8 (Aug. 2021). `doi:10.3389/frobt.2021.686447` . 

- [33] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. G. van Sloun, Y. C. Eldar, Kalmannet: Neural network aided Kalman filtering for partially known dynamics, IEEE Transactions on Signal Processing 70 (2022) 1532–1547. `doi:10.1109/tsp.2022.3158588` . 

- [34] X. Liu, S. Ikemoto, Y. Yoshimitsu, H. B. Amor, Learning soft robot dynamics using differentiable Kalman filters and spatio-temporal embeddings, in: 2023 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS), IEEE, 2023, p. 2550–2557. `doi:10.1109/ iros55552.2023.10341856` . 

- [35] Y. Chen, D. Sanz-Alonso, R. Willett, Autodifferentiable ensemble Kalman filters, SIAM Journal on Mathematics of Data Science 4 (2) (2022) 801–833. `doi:10.1137/21m1434477` . 

- [36] A. Corenflos, J. Thornton, G. Deligiannidis, A. Doucet, Differentiable particle filtering via entropy-regularized optimal transport (2021). `doi: 10.48550/ARXIV.2102.07850` . 

- [37] B. Cox, S. Pérez-Vieites, N. Zilberstein, M. Sevilla, S. Segarra, V. Elvira, End-to-end learning of Gaussian mixture proposals using differentiable particle filters and neural networks, in: ICASSP 2024 - 2024 IEEE 

30 

International Conference on Acoustics, Speech and Signal Processing (ICASSP), IEEE, 2024, p. 9701–9705. `doi:10.1109/icassp48485. 2024.10447783` . 

- [38] Y. Yin, C. Kou, S. Jia, L. Lu, X. Yuan, Y. Luo, PCDMD: Physicsconstrained dynamic mode decomposition for accurate and robust forecasting of dynamical systems with imperfect data and physics, Computer Physics Communications 304 (2024) 109303. `doi:10.1016/j. cpc.2024.109303` . 

- [39] L. Jiang, N. Liu, Correcting noisy dynamic mode decomposition with Kalman filters, Journal of Computational Physics 461 (2022) 111175. `doi:10.1016/j.jcp.2022.111175` . 

- [40] E. J. Parish, K. Duraisamy, A paradigm for data-driven predictive modeling using field inversion and machine learning, Journal of Computational Physics 305 (2016) 758–774. `doi:10.1016/j.jcp.2015.11.012` . 

- [41] R. E. Kalman, A new approach to linear filtering and prediction problems, Journal of Basic Engineering 82 (1) (1960) 35–45. `doi:10.1115/ 1.3662552` . 

- [42] A. Jameson, Aerodynamic design via control theory, Journal of Scientific Computing 3 (3) (1988) 233–260. `doi:10.1007/bf01061285` . 

- [43] J. Bradbury, R. Frostig, P. Hawkins, M. J. Johnson, C. Leary, D. Maclaurin, G. Necula, A. Paszke, J. VanderPlas, S. WandermanMilne, Q. Zhang, JAX: composable transformations of Python+NumPy programs (2018). 

- [44] J. Zhang, Q. Du, Numerical studies of discrete approximations to the Allen–Cahn equation in the sharp interface limit, SIAM Journal on Scientific Computing 31 (4) (2009) 3042–3063. `doi:10.1137/080738398` . 

- [45] X. Qi, Y. Zhang, C. Xu, An efficient approximation to the stochastic Allen-Cahn equation with random diffusion coefficient field and multiplicative noise, Advances in Computational Mathematics 49 (5) (Sep. 2023). `doi:10.1007/s10444-023-10072-w` . 

- [46] V. Mohammadi, D. Mirzaei, M. Dehghan, Numerical simulation and error estimation of the time-dependent Allen–Cahn equation on surfaces 

31 

with radial basis functions, Journal of Scientific Computing 79 (1) (2018) 493–516. `doi:10.1007/s10915-018-0859-7` . 

- [47] P. Benner, M. Stoll, Optimal control for Allen-Cahn equations enhanced by model predictive control, IFAC Proceedings Volumes 46 (26) (2013) 139–143. `doi:10.3182/20130925-3-fr-4043.00062` . 

## **Appendix A. Kalman filter derivation** 

In this section, we present the detailed derivation of the Kalman filter related formulas. We follow the equations and definitions as mentioned in Eq. (2). 

Kalman filter operates with a given model of the underlying dynamics. The Kalman filter operates in two steps: _predict_ and _update_ . In the predict ˆ step, the filter estimates the current state **x** _k|k−_ 1 and the error covariance ˆ **P** _k|k−_ 1 based on the previous **x** _k−_ 1 and the previous error covariance **P** _k−_ 1: 

**==> picture [272 x 36] intentionally omitted <==**

ˆ where **x** _k|k−_ 1 is the predicted state estimate at time step _k_ , and **P** _k|k−_ 1 is the predicted error covariance. 

In the update step, the filter incorporates the new observation ˆ **z** _k_ to refine ˆ the state estimate **x** _k_ and the error covariance **P** _k_ : 

**==> picture [298 x 70] intentionally omitted <==**

where **K** _k_ is the Kalman gain, **I** is the identity matrix, **z** ˆ _k_ is the observation ˆ at time step _k_ , **x** _k_ is the updated state estimate, and **P** _k_ is the updated error covariance. 

The predict step Eq. (A.2) can be written in their residual form by simply transferring all the RHS terms to LHS and equating it to zero that gives the residual Eq. (4). To solve this problem, an initial guess for the solution ˆ **x** _k_ and **P** _k_ can be taken and a newton method-based root finding algorithm can be used to converge to the actual solution. Therefore, at each step, 

32 

ˆ **x** _k_ and **P** _k_ becomes the state variables. In other words, the flattened matrices [ˆ **x** 1 _,_ **P** 1 _,_ ˆ **x** 2 _,_ **P** 2 _, . . ._ ] become the total state vector of this problem. 

ˆ We can take Kalman filter as a paramitrized mapping of **x** 0 _,_ **P** 0 _,_ **Z**[ˆ] _→_ � � ˆ (ˆ **x** _k,_ **P** _k_ ) where **Z**[ˆ] = **z** 1 _, . . . ,_ ˆ **z** _k_ is the observation matrix comes by observ� � ing the underlying physics. To differentiate this equation using algorithmic differentiation tools, it is helpful to look at in intermediate steps and visualize how the intermediate variables depend on each other. Computing partial derivatives using reverse algorithmic differentiation for adjoint method involves seeding (or perturbing) the output (the residuals) and seeing how that effect propagates back to the inputs. 

## **Appendix B. Sensitivity computation** 

According to Eq. (4), **rx** _,k_ is related to **x** _k−_ 1, so 

**==> picture [280 x 77] intentionally omitted <==**

according to Eq. (4), **rx** _,k_ is related to **K** _k_ , and **K** _k_ is related to **P** _k−_ 1, so 

**==> picture [241 x 28] intentionally omitted <==**

Assume that **S** _k_ ≜ **H** _k_ **P** _k−_ 1 **H**[⊺] _k_[+] **[ R]** _[k]_[.][We][can][further][deduce][the][following] results: 

**==> picture [136 x 30] intentionally omitted <==**

33 

first we compute the first term _∂_ **K** _k/∂_ **P** _k|k−_ 1, 

**==> picture [376 x 151] intentionally omitted <==**

then we compute the second term _∂_ **P** _k|k−_ 1 _/∂_ **P** _k−_ 1 according to Eq. (A.1): 

**==> picture [102 x 28] intentionally omitted <==**

thus, the result for **A** _k,k−_ 1 _,_ **x** _,_ **P** is 

**==> picture [382 x 30] intentionally omitted <==**

according to Eq. (4), **RP** _,k_ is not related to **x** _k−_ 1, so 

**==> picture [258 x 27] intentionally omitted <==**

according to Eq. (4), **RP** _,k_ is related to **P** _k−_ 1, so 

**==> picture [368 x 100] intentionally omitted <==**

34 

**==> picture [467 x 158] intentionally omitted <==**

thus, the result for **A** _k,k−_ 1 _,_ **P** _,_ **P** is 

**==> picture [362 x 30] intentionally omitted <==**

according to Eq. (4), **rx** _,k_ is related to **x** _k_ , so 

**==> picture [248 x 28] intentionally omitted <==**

according to Eq. (4), **rx** _,k_ does not depend on **P** _k_ . When differentiating with respect to a matrix variable, we first vectorize the matrix and define 

**==> picture [65 x 29] intentionally omitted <==**

since **rx** _,k_ contains no **P** _k_ , any perturbation ∆ **P** _k_ produces zero change, so 

**==> picture [249 x 27] intentionally omitted <==**

according to Eq. (4), **RP** _,k_ is not related to **x** _k_ , so 

**==> picture [252 x 28] intentionally omitted <==**

similarly, **RP** _,k_ depends linearly on **P** _k_ (essentially an identity mapping). Thus, for any perturbation ∆ **P** _k_ we have d **RP** _,k_ = ∆ **P** _k_ , which under vector- 

35 

ization gives the identity operator. Hence 

**==> picture [252 x 28] intentionally omitted <==**

this confirms that the covariance residual with respect to **P** _k_ simply yields the identity operator. 

To summarize, the block components of **A** _k,k−_ 1 and **A** _k,k_ are given by 

**==> picture [374 x 102] intentionally omitted <==**

**==> picture [362 x 13] intentionally omitted <==**

**==> picture [363 x 31] intentionally omitted <==**

these expressions complete the characterization of the Jacobian blocks used in our formulation. 

## **Appendix C. Verification of sensitivity** 

In order to verify the correctness of the above block Jacobian matrix, we first calculate the results of central finite difference and automatic differentiation, and then compare them with the derived theoretical solution. In terms of the dynamics and initial parameter setting, we use the same as Eq. (20). 

We set the number of time steps to 100 and plot the Frobenius error norms of finite difference and automatic differentiation, as well as the Frobenius error norms of the theoretical solution and finite difference for the above non-zero Jacobian matrix. In the plots, “TH” represents the formula results that we have derived, and “AD” and “FD” represent automatic differentiation results and finite difference results. From the numerical results, we observe that the error between the theoretical and finite difference (‖TH–FD‖) remains consistently small (typically below 10 _[−]_[5] ), and the error between the automatic differentiation and finite difference (‖AD–FD‖) is also at a similar 

36 

level. This demonstrates that the analytical Jacobian, the automatic differentiation, and the finite difference approximations are all mutually consistent and accurate. 

37 

**==> picture [390 x 70] intentionally omitted <==**

**==> picture [390 x 70] intentionally omitted <==**

**==> picture [390 x 70] intentionally omitted <==**

**==> picture [390 x 70] intentionally omitted <==**

**==> picture [390 x 70] intentionally omitted <==**

Figure C.6: F-norm error between automatic differentiation (AD), finite difference (FD), and theoretical Jacobian (TH) for various partial derivatives across time steps. From top to bottom: Eqs. (B.13), (B.9), (B.16), (B.10), (B.12). 

38 

