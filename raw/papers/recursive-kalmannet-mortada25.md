---
source_url: https://arxiv.org/abs/2506.11639
ingested: 2026-04-30
sha256: a8fa5c4cc5b1215b334f273dc1bb886da93c90cbe79e04bb3c1fe5714be061dc
source: paper
conversion: pymupdf4llm

---

# Recursive KalmanNet: Deep Learning-Augmented Kalman Filtering for State Estimation with Consistent Uncertainty Quantification 

Hassan Mortada, Cyril Falcon, Yanis Kahil, Math´eo Clavaud, Jean-Philippe Michel 

_Exail – Navigation Systems and Applications 34 rue de la Croix de Fer, 78100 Saint Germain en Laye, France_ Emails: _{_ firstname.lastname _}_ @exail.com 

_**Abstract**_ **—State estimation in stochastic dynamical systems with noisy measurements is a challenge. While the Kalman filter is optimal for linear systems with independent Gaussian white noise, real-world conditions often deviate from these assumptions, prompting the rise of data-driven filtering techniques. This paper introduces Recursive KalmanNet, a Kalman-filter-informed recurrent neural network designed for accurate state estimation with consistent error covariance quantification. Our approach propagates error covariance using the recursive Joseph’s formula and optimizes the Gaussian negative log-likelihood. Experiments with non-Gaussian measurement white noise demonstrate that our model outperforms both the conventional Kalman filter and an existing state-of-the-art deep learning based estimator.** 

_**Index Terms**_ **—Kalman filter, deep learning, state estimation, uncertainty quantification, recurrent neural networks.** 

## I. INTRODUCTION 

The Kalman Filter (KF) [1] provides an optimal estimation of a state vector that evolves according to a linear differential equation, with measurements modeled as a linear combination of the state vector. The solution consists of two components: an optimal state estimate, and an associated error covariance that quantifies the uncertainty of the state estimates. 

KF has been widely applied in areas such as inertial navigation [2] and robotics [3]. However, the KF’s optimality is guaranteed only under specific conditions. First, both the state evolution and measurement models must be linear. For nonlinear systems that are well linearizable, the Extended Kalman Filter (EKF) and Unscented Kalman Filter (UKF) offer viable alternatives. Second, the noise affecting both the state evolution and measurements must be independent. Lastly, the noise must be Gaussian, white and with known covariance. Any deviation from these assumptions can result in suboptimal performance or degradation of the KF’s accuracy. 

The assumptions underlying the KF are often challenging to satisfy in real-world scenarios. In high-end inertial navigation system applications, for example, the state evolution equations are well approximated by linear models. However, the measurements from external sensors, such as position data obtained from GNSS (Global Navigation Satellite Systems), are rarely independent or Gaussian in nature. GNSS signals often exhibit temporal and spatial correlations due to persistent atmospheric conditions. Furthermore, environmental factors, such as whether the system operates in urban or rural areas, 

can introduce significant variations in signal quality, including amplitude fluctuations and distortion. In such settings, measurement noise generally dominates over state evolution noise. In practice, one can adapt the KF sub-optimally by modeling the measurement noise using a Gaussian with a relatively high variance to be robust against such error behavior. 

In recent years, advancements in the field have introduced a new class of hybrid Kalman filters that combine the traditional KF structure with neural networks to mitigate the constraints of the classical approach. Mainly, the KalmanNet method [4] replaced the Kalman gain analytical form by a Recurrent Neural Network (RNN) block trained in a supervised manner. Multiple methods [5]–[7] derived from KalmanNet have been published to enhance it further. More details about these methods and their limitations are given in Section II-B. 

In this paper, we present the Recursive KalmanNet (RKN), which extends the KalmanNet framework to enhance the accuracy of state and error covariance estimates. The latter is learned by exploiting the generalized Joseph’s formulation [8] for the covariance estimation in a closed-loop and recursive fashion. The main contributions of this work include an accurate state estimation with error covariance estimation which is representative of the state errors and the ability to estimate challenging time-varying gains. To the best of our knowledge, we are the first to show and quantify that our method can effectively estimate the state with a consistent error covariance. Moreover, we show that RKN outperforms the KF, KalmanNet and its derived methods in handling nonGaussian measurement noise. 

The paper is organized as follows: Section II recalls the KF equations and presents KalmanNet and its derived methods. Section III details the proposed RKN. Section IV presents the numerical study. Section V concludes the paper. 

## II. PRELIMINARIES ON STATE ESTIMATION 

This paper addresses the problem of state estimation in stochastic dynamical systems with noisy observations. Let **x** _t ∈_ R _[m]_ be the state vector and **z** _t ∈_ R _[n]_ the measurement vector, which are related through a linear state-space model: 

**==> picture [166 x 24] intentionally omitted <==**

where **F** _t ∈_ R _[m][×][m]_ and **H** _t ∈_ R _[n][×][m]_ are the state transition and observation matrices, respectively. The process noise **v** _t_ and measurement noise **w** _t_ are assumed to be mutually independent, zero-mean white Gaussian noise with covariance matrices **Q** _t_ and **R** _t_ , respectively. These terms, known as process noise and measurement noise, account for uncertainties and model imperfections in the system dynamics and observations. Note that in this paper we evaluate the proposed method under a challenging scenario where **Q** _t_ and **R** _t_ are unknown and the measurement noise **w** _t_ follows a heavy tailed distribution. 

## _A. Kalman filter_ 

The KF is a recursive linear estimator that provides an analytical solution to the problem of estimating the state vector of a system defined by equations (1a)–(1b). It is based on a predictor-corrector scheme that estimates both the state vector and the covariance of the estimation error. KF is optimal in the minimum mean square error sense when the process and measurement noise are Gaussian, and remains the best linear estimator in the presence of non-Gaussian noise. Given an � initial state **x** 0 _|_ 0 and error covariance **P** 0 _|_ 0, the equations for the prediction and correction steps are given below. 

_Prediction step:_ The previous corrected state estimate � **x** _t−_ 1 _|t−_ 1 and error covariance **P** _t−_ 1 _|t−_ 1 are propagated forward using the state transition equation (1a) to obtain the predicted state estimate and error covariance: 

**==> picture [193 x 27] intentionally omitted <==**

_Correction step:_ The measurement **z** _t_ is used in the observation equation (1b) to correct the predicted state estimate. First, the innovation (or measurement pre-fit residual), which quantifies the discrepancy between the predicted state estimate and the measurement, along with its covariance, are computed as: 

**==> picture [181 x 28] intentionally omitted <==**

Then, the Kalman gain is derived to minimize the mean square � corrected state error, given by E � **e** _t_[T] **e** _t_ �, where **e** _t_ = **x** _t −_ **x** _t|t_ . The Kalman gain is computed as: 

**==> picture [172 x 13] intentionally omitted <==**

Finally, the corrected state estimate and its error covariance are updated as: 

**==> picture [181 x 27] intentionally omitted <==**

where **I** is the _m × m_ identity matrix. The concise form of the error covariance update in (5b) arises from algebraic simplifications based on the Kalman gain expression in (4). 

We conclude with observations that prepare for the analysis of the numerical assessment results discussed in Section IV. The derivations presented here apply to general white noise, without assuming Gaussianity. The Kalman gain ensures that 

the corrected state error is uncorrelated with the innovation. However, full independence is only achieved for Gaussian noise, where the innovation becomes white noise. For this reason, the KF is the optimal mean squared error estimator for linear state-space models with independent Gaussian white noise and remains the best linear estimator, even when the Gaussian assumption is relaxed. 

## _B. Deep-learning informed Kalman filters_ 

In recent years, hybrid approaches combining Kalman filtering with machine learning have been developed to address the limitations of the traditional KF. These methods mainly aim to learn the Kalman gain using supervised data-driven techniques. KalmanNet introduced in [4] replaces the closed-form gain computation with a recurrent neural network (RNN), while preserving the KF’s predictor-corrector scheme. The RNN, comprising a Gated Recurrent Unit (GRU) and fully connected layers, is trained using a feature set and the mean squared error (MSE) as the loss function. KalmanNet is designed to operate without prior knowledge of the noise covariances **Q** _t_ and **R** _t_ , and has shown improved performance over the KF and its nonlinear extensions in cases of model mismatch or system nonlinearities. However, it does not estimate the crucial error covariance. To address this, [6] proposes estimating the error covariance and introduces a log-likelihood-based loss. Yet, this method requires the measurement matrix **H** _t_ to be full-column rank, limiting its generality. In [5], two RNNs estimateinnovationthecovariancepredicted **S** error _t−_ 1,covarianceusing additional **P** _t|t−_ 1featuresand the suchinverseas the Jacobian of **H** _t_ . However, the resulting error covariance is not guaranteed to be positive definite. To overcome this, [7] suggests estimating the Cholesky factor of the covariance, ensuring positive definiteness. They also propose a loss function combining the MSE and the deviation between estimated and empirical covariances. However, this requires tuning a hyperparameter to balance the trade-off between estimation accuracy and covariance consistency. Additionally, the state transition matrix **F** _t_ , capturing the system dynamic, is not incorporated into the learning process. 

## III. RECURSIVE KALMANNET 

We introduce Recursive KalmanNet (RKN), a deep learning model informed by Kalman filtering for gain estimation and consistent corrected error covariance. It operates without prior knowledge of the noise covariance matrices **Q** _t_ and **R** _t_ and does not require estimating the predicted error covariance. Instead, it updates the predicted error covariance in a single step using Joseph’s formula for the general error covariance update [8]. 

RKN consists of two separate RNNs: one dedicated to gain estimation and the other to estimating the Cholesky factor of the noise-dependent term in the one-step covariance update. The overall architecture is illustrated in Fig. 1. 

Training is performed in a supervised manner using the Gaussian negative log-likelihood of the error, ensuring uniform 

**==> picture [366 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
GRU<br>GRU<br>**----- End of picture text -----**<br>


Fig. 1: RKN learning architecture. The gain and the corrected error covariance are estimated with two separate RNNs with set of parameters (weights and biases) Θ1 and Θ2, respectively. The second RNN estimates the Cholesky factor matrix of the corrected noise covariance term **B**[�] _t_ derived from Joseph’s formulation defined in (8). 

optimization of both the state estimates and the error covariance. Further details on the model features, learning process, and loss functions are provided below.[1] 

## _A. Features_ 

Gain estimation in the KF relies on the innovation covariance, which in turn depends on the noise covariances **Q** _t_ and **R** _t_ . Unlike the KF, RKN does not have access to these matrices and must instead infer noise statistics from datadriven features. RKN consists of two RNNs, both using GRUs between fully connected layers. At each time step _t_ , they process the same set of input features: 

- 

- _• F_ 1: Innovation **y** _t_ at _t_ ; 

- 

- _• F_ 2: State correction **K**[�] _t−_ 1 **y** _t−_ 1 from _t −_ 1; 

- _F_ 3: Jacobian **H** _t_ of the observation equation at _t_ ; 

- _F_ 4: Measurement temporal difference **z** _t −_ **z** _t−_ 1 at _t_ . 

Features _F_ 1 and _F_ 2 reflect state estimation errors, while _F_ 3 and _F_ 4 provide information about measurement characteristics. Features _F_ 1, _F_ 2, and _F_ 4 are used in [4], and _F_ 4 appeared in [5]. Feature batch normalization was removed during training, as it suppresses transient dynamics in features induced by timevarying state-space models, hindering the network’s ability to capture time-dependent behaviors. 

Empirically, the use of squared features improves performance. This is consistent with the quadratic nature of error covariances, which the estimated parameters depend on. For instance, the innovation covariance **S** _t_ in the gain equation (4) is a second-order statistic of _F_ 1. 

## _B. Error covariance with Joseph’s formula_ 

The gain produced by the first RNN does not necessarily align with the analytical form in equation (4), potentially invalidating equation (5b) for the corrected error covariance. In particular, this inconsistency may result in a non-symmetric covariance matrix. To address this, we adopt the more general 

> 1RKN code available on GitHub: github.com/ixblue/RecursiveKalmanNet. 

Joseph’s formula [8], applicable to any linear state-space estimator with white noise, regardless of Gaussianity: 

**==> picture [239 x 13] intentionally omitted <==**

Substituting the predicted error covariance from equation (2b) into equation (6), we express **P** _t|t_ as the sum of two terms **P** _t|t_ = **A** _t_ + **B** _t_ , where **A** _t_ is the _corrected propagated error covariance_ : 

**==> picture [225 x 13] intentionally omitted <==**

**==> picture [173 x 9] intentionally omitted <==**

**==> picture [226 x 12] intentionally omitted <==**

The term **A** _t_ is computed in closed form, as it depends only on the gain estimated by the first RNN at time _t_ and the covariance estimated by the second RNN at _t −_ 1. This recursive dependence on the previously estimated covariance gives rise to the method’s name: Recursive KalmanNet (RKN). In contrast, **B** _t_ is estimated by the second RNN, where we directly learn its Cholesky factor to ensure positive semidefiniteness, _i.e._ , **B** _t_ = **C** _t_ **C** _t_[T] , where **C** _t_ is a lower triangular matrix with real entries. 

## _C. Training and loss function_ 

The RKN model is trained in a supervised manner using time series datasets consisting of state and measurement pairs, denoted as ( **x**[(] _t[i]_[)] _[,]_ **[ z]**[(] _t[i]_[)][)][,][where] _[i][∈{]_[1] _[, . . . , N][}]_[is][the][batch] index, and _t ∈{_ 1 _, . . . , T }_ is the time index. Training is performed with the ADAM optimizer, minimizing a loss function based on the negative Gaussian log-likelihood of the estimation error as in [6]. 

Let Θ1 and Θ2 denote the parameters of the two RNNs illustrated in Fig. 1. At each index _i_ and time step _t_ , the estimation error depends on Θ1, while its covariance is influenced by both Θ1 and Θ2. The loss function is defined as: 

**==> picture [233 x 37] intentionally omitted <==**

The overall loss function is computed as the batch and time average of the individual losses _L_[(] _t[i]_[)][,][with] _[ℓ]_[2][regularization] applied to both parameters Θ1 and Θ2. These parameters are optimized jointly, rather than in an alternating fashion as in [7]. For each _i_ and _t_ , the gradient of the loss function with respect to the gain **K**[�][(] _t[i]_[)] and the error covariance **P**[�][(] _t|[i] t_[)][is] derived using standard matrix calculus: 

**==> picture [243 x 94] intentionally omitted <==**

Therefore, the critical points of _L_[(] _t[i]_[)] satisfy **P**[�] _t_[(] _|[i] t_[)][=] **[e]**[(] _t[i]_[)] **[e]**[(] _t[i]_[)] T and **e**[(] _t[i]_[)] **[y]**[�] _t_[(] _[i]_[)] T = 0, yielding orthogonality between the state error **e**[(] _t[i]_[)] and innovation **y** � _t_[(] _[i]_[)][.][The][batch][averaging][in][the] global loss function guarantees that the learned covariance accurately reflects the true estimation error statistics, while the learned gain decorrelates the estimation error from the innovation. This is a critical condition for optimal filtering, ensuring that all available measurement information is fully utilized to correct the predicted state estimate. 

## IV. NUMERICAL ASSESSMENTS 

We evaluate RKN performance on a 1D constant-speed linear model, with a position measurement. The state vector, consisting of position and velocity, and the measurement are described by the equations below, where d _t_ is the time step: 

**==> picture [202 x 40] intentionally omitted <==**

The process noise **v** _t_ is zero-mean Gaussian white noise 0 0 with covariance **Q** _t_ = , modeling white noise on �0 _σv_[2] � acceleration. This formulation leads to a velocity random walk characterized by zero-mean Gaussian increments with variance _σv_[2] . The measurement noise _wt_ follows a heavytailed bimodal-Gaussian distribution: 

**==> picture [107 x 11] intentionally omitted <==**

where _Xt_ , _Yt_ , and _Zt_ are independent white noise processes, with _Xt_ and _Yt_ being Gaussian with variances _σ_ 1[2] and _σ_ 2[2] , respectively, and _Zt_ is Bernoulli with parameter _p_ . Then, _wt_ is distributed as _pN_ (0 _, σ_ 1[2] ) + (1 _− p_ ) _N_ (0 _, σ_ 2[2] ). It thus has variance **R** _t_ = _Ztσ_ 1[2] +(1 _− Zt_ ) _σ_ 2[2] , and an expected variance of _σw_[2] = _pσ_ 1[2] + (1 _− p_ ) _σ_ 2[2] . 

Finally, we set d _t_ = 1 without units and define the noise heterogeneity level as _ν_ = _[σ][w]_[2][[.]] 

_σv_[2][[.]] 

We compare RKN with two versions of the KF: the optimal KF (o-KF) and the sub-optimal KF (so-KF). The o-KF provides the optimal gain and state estimate since it has access to 

|_ν_|20|20|30|30|40|40|50|50|60|60|
|---|---|---|---|---|---|---|---|---|---|---|
|**o-KF**|_−_28|2_._0|_−_21|2_._0|_−_14|2_._0|_−_6_._9|2_._0|0_._1|2_._0|
|**so-KF**|_−_26|2_._0|_−_18|2_._0|_−_11|2_._0|_−_3_._9|2_._0|3_._4|2_._0|
|**CKN**|_−_20|4_._0|_−_17|27|_−_11|3_._2|_−_4_._8|6_._2|2_._4|21|
|**RKN**|_−_26|2_._0|_−_19|2_._0|_−_12|2_._0|_−_5_._1|1_._9|2_._3|2_._2|



TABLE I: MSE (in dB, left) and MSMD (right) for varying noise heterogeneity levels, _ν_ [dB]. 

the true noise covariance, **R** _t_ , at each time step, making it the reference method. In real-world scenarios, the noise covariance is usually unknown, so an approximate Gaussian model is often used. The so-KF approximates the noise covariance with a single Gaussian of variance _σw_[2] . Furthermore, we compare RKN with Cholesky KalmanNet (CKN) [7], a recent KalmanNet-derived method that outperforms [4], [5]. 

We train the RKN model using the squared features from Section III-A on synthetically generated time series based on equations (11a) and (11b). Each series has _T_ = 150 samples, with 1000 time series for training, 100 for validation, and 1000 for testing. Initial conditions follow a normal distribution � with mean **x** 0 _|_ 0 and covariance **P**[�] 0 _|_ 0. The Bernoulli sampling process varies across series. 

For our experiments, we set the initial error covariance as � 1 0 � 0 **P** 0 _|_ 0 = 0 0 _._ 01 and the initial mean state as **x** 0 _|_ 0 = 1 . � � � � We further set _σv_[2] = 10 _[−]_[4] , _p_ = 0 _._ 6, and _σ_ 1[2] = 1 _._ 5625 _σw_[2] . Note that the observations discussed below also hold under different parameter settings. 

## _A. Performance at varying noise heterogeneity level_ 

In the following experiment, the noise heterogeneity level is varied between 20 dB and 60 dB and the estimators are assessed using two metrics: Mean Squared Error (MSE) for state estimation accuracy and Mean Squared Mahalanobis Distance (MSMD) for the consistency of error covariance estimation with state error. These metrics are defined as follows: 

**==> picture [167 x 64] intentionally omitted <==**

If **e**[(] _t[i]_[)] is Gaussian, then **e**[(] _t[i]_[)] T **P**[(] _t|[i] t_[)] _[−]_[1] **e**[(] _t[i]_[)] follows a chi-squared distribution with _m_ degrees of freedom, where _m_ is the state dimension. According to the Central Limit Theorem, the batch average of this quantity converges to a Gaussian distribution with mean _m_ and variance 2 _m/N_ . The Gaussian nature of state errors is an inherent property of the optimal KF, but this characteristic is also highly desirable for other estimators, as it ensures that all available information is incorporated into the estimate. However, due to temporal dependencies in the state error, deriving the distribution of the MSMD becomes considerably more complex, although its mean remains _m_ . 

Table I presents the MSE and MSMD obtained for the compared methods. The results indicate that RKN outperforms both so-KF and CKN in terms of MSE, achieving performance 

**==> picture [452 x 181] intentionally omitted <==**

**----- Start of picture text -----**<br>
0 . 7 0 . 50<br>o-KF CKN o-KF: Emp. std CKN: Emp. std<br>0 . 6 so-KF RKN o-KF: 푃 [�] 푡 | 푡 CKN: 푃 [�] 푡 | 푡<br>0 . 45 so-KF: Emp. std RKN: Emp. std<br>0 . 5 so-KF: 푃 [�] 푡 | 푡 RKN: 푃 [�] 푡 | 푡<br>0 . 40<br>0 . 4<br>0 . 3 0 . 35<br>0 . 2<br>0 . 30<br>0 . 1<br>0 . 25<br>0 . 0<br>0 10 20 30 40 50 60 0 25 50 75 100 125 150<br>Time Time<br>(a) (b)<br>Position gain Position Std<br>**----- End of picture text -----**<br>


Fig. 2: Comparison of position estimates. (a) Gain from a single time series (zoom on the first 60 samples). (b) Root mean square values over 1000 test time series of the estimated (solid lines) and empirical (dash-dot lines) standard deviations. 

closest to the reference values produced by o-KF. The MSMD values for both KF and RKN closely match the theoretical mean of _m_ = 2. In contrast, CKN yields significantly higher MSMD values, reflecting inconsistency in its covariance representation. This can be traced to CKN’s loss function, which uses a hyperparameter to balance the MSE and covariance terms [7, Equation (7)]. In the authors’ implementation, the covariance term is weighted at just 0.05, with 0.95 assigned to the MSE, favoring low MSE at the expense of covariance accuracy. RKN, by contrast, uses a tuning-free loss, inherently balancing both aspects without manual adjustment. 

## _B. Temporal analysis of gain and error covariance estimations_ 

To further analyze into RKN’s performance, we analyze the temporal evolution of the gain and covariance estimates under a fixed _ν_ = 40 dB, yielding _σw_[2] = 1. Fig. 2a shows that the optimal position gain from o-KF exhibits a noisy, timevarying behavior driven by the Bernoulli process switching Gaussian modes. Both RKN and CKN partially track this dynamic, while so-KF—as expected—produces a smoother, less responsive gain profile. In Fig. 2b we assess position estimate accuracy via the standard deviations shown by the dash-dot lines, and evaluate consistency between the estimated and empirical standard deviations of the position errors by comparing the dash-dot and solid lines. RKN and CKN yield covariances between the optimal o-KF and the suboptimal soKF. However, only RKN’s covariance estimates consistently reflect the actual error spread, while CKN underestimates it. Similar trends are observed for velocity estimates. 

These findings demonstrate that RKN reliably estimates the states, gain, and error covariance, even under challenging nonGaussian measurement noise. This paper does not address the model’s generalization capabilities, which are explored separately in [9], where performance is evaluated under a mismatch between training and test noise variance ranges. To enhance the generalization capabilities of the learned covariance, future 

work will focus on analyzing the learned Cholesky factor **C** _t_ to ensure its consistency with the learned gain **K** _t_ . 

## V. CONCLUSION 

This paper introduces RKN, a deep-learning augmented Kalman filter that leverages two recurrent neural networks to estimate gain and error covariance. The latter is recursively computed using a formulation derived from Joseph’s equation. In scenarios with bimodal Gaussian noise, RKN outperformes conventional Kalman filters and a state-of-the-art deep learning approach, delivering accurate state and covariance estimates that closely reflect actual errors. RKN shows strong potential in cases where classical Kalman filtering falls short, such as in non-linear systems or with incomplete state-space models. 

REFERENCES 

- [1] R. E. Kalman, “A New Approach to Linear Filtering and Prediction Problems,” _J. Basic Eng._ , vol. 82, no. 1, pp. 35–45, 1960. 

- [2] S. F. Schmidt, “Application of state-space methods to navigation problems,” in _Advances in Control Systems_ , C. T. Leondes, Ed. Elsevier, 1966, vol. 3, pp. 293–340. 

- [3] S.-Y. Chen, “Kalman filter for robot vision: a survey,” _IEEE Trans. Ind. Electron._ , vol. 59, no. 11, pp. 4409–4420, 2011. 

- [4] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, “KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics,” _IEEE Trans. Signal Process._ , vol. 70, pp. 1532–1547, 2022. 

- [5] G. Choi, J. Park, N. Shlezinger, Y. C. Eldar, and N. Lee, “SplitKalmanNet: A Robust Model-Based Deep Learning Approach for State Estimation,” _IEEE Trans. Veh. Technol._ , vol. 72, pp. 12 326–12 331, 2023. 

- [6] Y. Dahan, G. Revach, J. Dunik, and N. Shlezinger, “Uncertainty Quantification in Deep Learning Based Kalman Filters,” in _ICASSP IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , 2024, pp. 13 121–13 125. 

- [7] M. Ko and A. Shafieezadeh, “Cholesky-KalmanNet: Model-Based Deep Learning With Positive Definite Error Covariance Structure,” _IEEE Signal Process. Lett._ , vol. 32, pp. 326–330, 2025. 

- [8] R. S. Bucy and P. D. Joseph, _Filtering for stochastic processes with applications to guidance_ . American Mathematical Soc., 2005, vol. 326. 

- [9] C. Falcon, H. Mortada, M. Clavaud, and J.-P. Michel, “Recursive KalmanNet : Analyse des capacit´es de g´en´eralisation d’un r´eseau de neurones r´ecurrent guid´e par un filtre de Kalman,” in _30e Colloque sur le traitement du signal et des images_ . GRETSI, 2025. 

