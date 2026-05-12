---
title: "Non-linear Noise Adaptive Kalman Filtering via Variational Bayes"
journal: "2013 IEEE International Workshop on Machine Learning for Signal Processing (MLSP)"
authors: ["Simo S\u00e4rkk\u00e4", "Jouni Hartikainen"]
year: 2013
source: paper
ingested: 2026-05-12
sha256: d8bc45fea8adece2c0d3af044300124e5bd8569141c9db369c0914714a89f63a
conversion: pymupdf4llm
---

2013 IEEE INTERNATIONAL WORKSHOP ON MACHINE LEARNING FOR SIGNAL PROCESSING 

## **NON-LINEAR NOISE ADAPTIVE KALMAN FILTERING VIA VARIATIONAL BAYES** 

_Simo S¨arkk¨a_ 

## _Jouni Hartikainen_ 

Aalto University, 02150 Espoo, Finland 

## Rocsole Ltd., 70211 Kuopio, Finland 

## **ABSTRACT** 

We consider joint estimation of state and time-varying noise covariance matrices in non-linear stochastic state space models. We propose a variational Bayes and Gaussian non-linear filtering based algorithm for efficient computation of the approximate filtering posterior distributions. The formulation allows the use of efficient Gaussian integration methods such as unscented transform, cubature integration and GaussHermite integration along with the classical Taylor series approximations. The performance of the algorithm is illustrated in a simulated application. 

_**Index Terms**_ **—** variational Bayes, unknown noise covariance, adaptive filtering, non-linear Kalman filtering 

## **1. INTRODUCTION** 

In this paper, we propose a method for Bayesian inference on the state _xk_ and noise covariances Σ _k_ in heteroscedastic non-linear stochastic state space models (see, e.g., [1]) of the form 

**==> picture [170 x 41] intentionally omitted <==**

where _xk ∈_ R _[n]_ is the state at time step _k_ , and _yk ∈_ R _[d]_ is the measurement, _Qk_ is the known process noise covariance and Σ _k_ is the measurement noise covariance. The nonlinear functions _f_ ( _·_ ) and _h_ ( _·_ ) form the dynamic and measurement models, respectively, and the last equation defines the Markovian dynamic model for the dynamics of the unknown noise covariances Σ _k_ . We aim at computing the joint posterior (filtering) distribution of the states and noise covariances _p_ ( _xk,_ Σ _k | y_ 1: _k_ ). Although the formal Bayesian solution to this problem is well-known (see, e.g., [1]), it is computationally intractable and we can only approximate it. 

In a recent article, S¨arkk¨a and Nummenmaa [2] introduced the variational Bayesian (VB) adaptive Kalman filter (VB-AKF), which can be used for estimating the measurement noise variances along with the state in linear state space models. In this paper, we extend the method to allow estimation of the full noise covariance matrix and non-linear 

state space models. The idea is similar to what was recently used by Pich´e et al. [3] in the context of outlier-robust filtering, which in turn is based on the linear results of [4]. VB methods have been applied to parameter identification in state space models also in [5, 6, 7] and various other (Bayesian) approaches have can be found, for example, in references [8, 9, 10, 11, 12]. 

## **1.1. Gaussian Filtering** 

If the covariances in the model (1) were known, the filtering problem would reduce to the classical non-linear (Gaussian) optimal filtering problem [13, 8, 14, 1]. This non-linear filtering problem can be solved in various ways, but one quite general approach is the Gaussian filtering approach [8, 15, 16], where the idea is to assume that the filtering distribution is approximately Gaussian. That is, we assume that there exist means _mk_ and covariances _Pk_ such that _p_ ( _xk | y_ 1: _k_ ) _≈_ N( _xk | mk, Pk_ ). 

The Gaussian filter prediction and update steps can be written as follows [15]: 

**==> picture [229 x 79] intentionally omitted <==**

**==> picture [42 x 10] intentionally omitted <==**

**==> picture [187 x 156] intentionally omitted <==**

978-1-4673-1026-0/12/$31.00 _⃝_ c 2013 IEEE 

With different selections for the Gaussian integral approximations, we get different filtering algorithms [16] such as the unscented Kalman filter (UKF) [17], Gauss-Hermite Kalman filter (GHKF) [15], cubature Kalman filter (CKF) [18], and various others [19, 20, 21] along with the classical methods [13, 8]. 

## **1.2. Variational Approximation** 

In this paper, we approximate the joint filtering distribution of the state and covariance matrix with the free-form variational Bayesian (VB) approximation (see, _e.g._ , [22, 23, 24, 5]): 

**==> picture [196 x 11] intentionally omitted <==**

where _Qx_ ( _xk_ ) and _Q_ Σ(Σ _k_ ) are the yet unknown approximating densities. The VB approximation can be formed by minimizing the Kullback-Leibler (KL) divergence between the true distribution and the approximation: 

**==> picture [233 x 40] intentionally omitted <==**

Minimizing the KL divergence with respect to the probability densities, we get the following equations: 

**==> picture [247 x 64] intentionally omitted <==**

The solutions to these equations can be found by a fixed-point iteration for the sufficient statistics of the approximating densities. 

## **2. VARIATIONAL BAYESIAN ADAPTATION OF NOISE COVARIANCE** 

## **2.1. Estimation of Full Covariance in Linear Case** 

We start by considering the linear state space model with unknown covariance as follows: 

**==> picture [200 x 26] intentionally omitted <==**

where _Ak_ and _Hk_ are some known matrices. We assume that the dynamic model for the covariance is independent of the state and of the Markovian form _p_ (Σ _k |_ Σ _k−_ 1), and set some restrictions to it shortly. In this section we follow the derivation in [2], and extend the scalar variance case to the full covariance case. 

Assume that the filtering distribution of the time step _k−_ 1 can be approximated as product of Gaussian distribution and inverse Wishart (IW) distribution as follows: 

**==> picture [233 x 26] intentionally omitted <==**

where the densities, up to non-essential normalization terms, can be written as [25]: 

**==> picture [242 x 52] intentionally omitted <==**

That is, in the VB approximation (4), _Qx_ ( _xk_ ) is the Gaussian distribution and _Q_ Σ(Σ _k_ ) is the inverse Wishart distribution. 

We now assume that the dynamic model for the covariance is of such form that it maps an inverse Wishart distribution at the previous step into inverse Wishart distribution at the current step. This gives (cf. [2]) 

**==> picture [142 x 28] intentionally omitted <==**

where _νk[−]_[and] _[V] k[−]_ are certain parameters (see Section 2.2), and _m[−] k_[and] _[ P][ −] k_[are given by the standard Kalman filter pre-] diction equations: 

**==> picture [176 x 28] intentionally omitted <==**

Because the distribution and the previous step is separable, and the dynamic models are independent we thus get the following joint predicted distribution: 

**==> picture [203 x 28] intentionally omitted <==**

We are now ready to form the actual VB approximation to the posterior. The integrals in the exponentials of (5) can now be expanded as follows (cf. [2]): 

**==> picture [237 x 146] intentionally omitted <==**

where _⟨·⟩_ Σ = � ( _·_ ) _Q_ Σ(Σ _k_ ) dΣ _k_ , _⟨·⟩x_ = � ( _·_ ) _Qx_ ( _xk_ ) d _xk_ , and _C_ 1 _, C_ 2 are some constants. If we have that _Q_ Σ(Σ _k_ ) = IW(Σ _k | νk, Vk_ ), then the expectation in the first equation of (10) is 

**==> picture [183 x 13] intentionally omitted <==**

Furthermore, if _Qx_ ( _xk_ ) = N( _xk | mk, Pk_ ), then the expectation in the second equation of (10) becomes 

**==> picture [232 x 46] intentionally omitted <==**

By substituting the expectations (11) and (12) into (10) and matching terms in left and right hand sides of (5) results in the following coupled set of equations: 

**==> picture [241 x 106] intentionally omitted <==**

**Predict** : Compute the parameters of the predicted distribution as follows: 

**==> picture [135 x 61] intentionally omitted <==**

**Update** : First set _m_[(0)] _k_ = _m[−] k_[,] _[P]_[ (0)] _k_ = _Pk[−]_[,] _[ν][k]_[=][1 +] _[ ν] k[−]_[,] and _Vk_[(0)] = _Vk[−]_ and the iterate the following, say _N_ , steps _i_ = 1 _, . . . , N_ : 

**==> picture [220 x 129] intentionally omitted <==**

**Algorithm 1:** The multidimensional Variational Bayesian Adaptive Kalman Filter (VB-AKF) algorithm 

## **2.3. Extension to Non-Linear Models** 

The first four of the equations have been written into such suggestive form that they can easily be recognized to be the Kalman filter update step equations with measurement noise covariance ( _νk − n −_ 1) _[−]_[1] _Vk_ . 

## **2.2. Dynamic Model for Covariance** 

In analogous manner to [2], the dynamic model _p_ (Σ _k |_ Σ _k−_ 1) needs to be chosen such that when it is applied to an inverse Wishart distribution, it produces another inverse Wishart distribution. Although, the explicitly construction of the density is hard, all we need to do is to postulate a transformation rule for the sufficient statistics of the inverse Wishart distributions at the prediction step. Using similar heuristics as in [2], we arrive at the following dynamic model: 

**==> picture [190 x 28] intentionally omitted <==**

where _ρ_ is a real number 0 _< ρ ≤_ 1 and _B_ is a matrix 0 _< |B| ≤_ 1. A reasonable choice for the matrix is _B_ = _[√] ρ I_ , in which case parameter _ρ_ controls the assumed dynamics: value _ρ_ = 1 corresponds to stationary covariance and lower values allow for higher time-fluctuations. The resulting multidimensional variational Bayesian adaptive Kalman filter (VB-AKF) is shown in Algorithm 1. 

In this section we extend the results in the previous section into non-linear models of the form (1). We again start with the assumption that the filtering distribution is approximately product of a Gaussian term and inverse Wishart (IW) term as in Equation (7). The prediction step can be handled in similar manner as in the linear case, except that the computation of the mean and covariance of the state should be done with the Gaussian filter prediction equations (2) instead of the Kalman filter prediction equations (8). The inverse Wishart part of the prediction remains intact. After the prediction step, the approximation is again a product of Gaussian and inverse Wishart distributions as in Equation (9). 

The expressions corresponding to (10) now become: 

**==> picture [236 x 146] intentionally omitted <==**

The expectation in the first equation is still given by the equation (11), but the resulting distribution in terms of _xk_ is intractable in closed form due to the non-linearity _h_ ( _xk_ ). Fortunately, the approximation problem is exactly the same as encountered in the update step of Gaussian filter and thus we can directly use the equations (3) for computing Gaussian approximation to the distribution. 

The simplification (12) does not work in the non-linear case, but we can rewrite the expectation as 

**==> picture [235 x 30] intentionally omitted <==**

where the expectation can be separately computed using some of the Gaussian integration methods in [16]. Because the result of the integration is just a constant matrix, we can now substitute (11) and (16) into (15) and match the terms in equations (5) in the same manner as in linear case. This results in equations which consist of the Gaussian filter update step (3) with measurement noise Σ _k_ = ( _νk − n −_ 1) _[−]_[1] _Vk_ along with the following two additional equations: 

**==> picture [211 x 53] intentionally omitted <==**

## **2.4. The Adaptive Filtering Algorithm** 

The general filtering method for the full covariance and nonlinear state space model is shown in Algorithm 2. Various useful special cases and extensions can be deduced from the equations: 

- The _Gaussian integration method_ [15, 16, 17, 18, 26, 19, 20, 21] will result in different variants of the algorithm. For example, the Taylor series based approximation could be called VB-AEKF, unscented transform based method VB-AUKF, cubature based VB-ACKF, Gauss-Hermite based VB-AGHKF and so on. 

- The _diagonal covariance case_ , which was considered in [2], can be recovered by updating only the diagonal elements in the last equation of the algorithm and keeping all other elements in the matrices _Vk_[(] _[i]_[)] zero. The matrix _B_ in the prediction step then needs to be diagonal also. Although the inverse Wishart parametrization does not reduce to the inverse Gamma parametrization, the formulations are equivalent. 

- _Non-additive dynamic models_ can be handled by simply replacing the state prediction with the non-additive counterpart. 

**Predict** : Compute the parameters of the predicted distribution as follows: 

**==> picture [197 x 97] intentionally omitted <==**

**==> picture [244 x 28] intentionally omitted <==**

**==> picture [239 x 76] intentionally omitted <==**

**==> picture [211 x 157] intentionally omitted <==**

**Algorithm 2:** The Variational Bayesian Adaptive Gaussian Filter (VB-AGF) algorithm 

## **3. NUMERICAL RESULTS** 

## **3.1. Multi-Sensor Bearings Only Tracking** 

As an example, we consider the classical multi-sensor bearings only tracking problem with coordinated turning model ˙ ˙ [14], where the state _x_ = ( _u, u, v, v, ω_ ) contains the 2d location ( _u, v_ ) and the corresponding velocities ( ˙ _u, v_ ˙) as well as the turning rate _ω_ of the target. The dynamic model was the coordinated turn model and the measurements consisted of bearings reported by four sensors with unknown (joint) noise covariance matrix. 

We simulated a trajectory and measurements from the model and applied different filters to it. We tested various 

**==> picture [227 x 424] intentionally omitted <==**

**----- Start of picture text -----**<br>
4<br>x 10<br>1<br>Sensors<br>0.8 True trajectory<br>0.6 Filtered estimate<br>0.4<br>0.2<br>0<br>−0.2<br>−0.4<br>−0.6<br>−0.8<br>−1<br>−1 −0.5 0 0.5 1<br>4<br>x 10<br>1 . The simulated trajectory and the estimate<br>with VB-ACKF.<br>3<br>2<br>1<br>0<br>−1<br>−2<br>−3<br>0 200 400 600 800 1000<br>**----- End of picture text -----**<br>


**Fig. 1** . The simulated trajectory and the estimate obtained with VB-ACKF. 

**Fig. 2** . The simulated measurements. 

Gaussian integration based methods (VB-AEKF, VB-AUKF, VB-ACKF, VB-AGHKF) and because the results were quite much the same with different Gaussian integration methods, we only present the results obtained with VB-ACKF. Figure 1 shows the simulated trajectory and the VB-ACKF results with the full covariance estimation. In the simulation, the variances of the measurement noises as well as the cross-correlations varied smoothly over time. The simulated measurements are shown in Figure 2. 

Figure 3 shows the root mean squared errors (RMSEs) for CKF with the true covariance matrix (CKF-t), CKF with a diagonal covariance matrix with diagonal elements given by the value on the _x_ -axis (CKF-o), CKF with full covariance estimation (VBCKF-f), and CKF with diagonal covariance estimation (VBCKF-d). As can be seen in the figure, the 

**==> picture [228 x 183] intentionally omitted <==**

**----- Start of picture text -----**<br>
5<br>10<br>4<br>10<br>3<br>10<br>2<br>10<br>101 CKF−t<br>CKF−o<br>VBACKF−f<br>VBACKF−d<br>0<br>10<br>0.002 0.004 0.006 0.008 0.01 0.012 0.014 0.016 0.018 0.02<br>**----- End of picture text -----**<br>


**Fig. 3** . Root mean squared errors (RMSEs) for different methods. 

results of filters with covariance estimation are indeed better than the results of any filter with fixed diagonal covariance matrix. The filter with the known covariance matrix gives the lowest error, as would be expected, and the filter with full covariance estimation gives a lower error than the filter with diagonal covariance estimation. 

## **4. CONCLUSION AND DISCUSSION** 

In this paper, we have presented a variational Bayes and nonlinear Gaussian (Kalman) filtering based algorithm for joint estimation of state and time-varying noise covariances in nonlinear state space models. The performance of the method has been illustrated in a simulated application. 

There are several extensions that could be considered as well. For instance, we could try to estimate the process noise covariance in the model. However, it is not as easy as it sounds, because the process noise covariance does not appear in the equations in such simple conjugate form as the measurement noise covariance. Another natural extension would be the case of smoothing (cf. [3]). Unfortunately the current dynamic model makes things challenging, because we do not know the actual transition density at all. This makes the implementation of a Rauch–Tung–Striebel type of smoother impossible—although a simple smoothing estimate for the state can be obtained by simply running the RTS smoother over the state estimates while ignoring the noise covariance estimates completely. However, it would be possible to construct an approximate two-filter smoother for the full state space model, but even in that case we need to put some more constraints to the model, for example, assume that the covariance dynamics are time-reversible. 

## **5. REFERENCES** 

- [1] S. S¨arkk¨a, _Bayesian Filtering and Smoothing_ , Cambridge University Press, 2013. 

- [2] S. S¨arkk¨a and A. Nummenmaa, “Recursive noise adaptive Kalman filtering by variational Bayesian approximations,” _IEEE Transactions on Automatic Control_ , vol. 54(3), pp. 596–600, 2009. 

- [3] R. Pich´e, S. S¨arkk¨a, and J. Hartikainen, “Recursive outlier-robust filtering and smoothing for nonlinear systems using the multivariate Student-t distribution,” in _Proceedings of MLSP_ , 2012. 

- [4] G. Agamennoni, J.I. Nieto, and E.M. Nebot, “An outlier-robust Kalman filter,” in _IEEE Int. Conf. on Robotics and Automation (ICRA)_ , May 2011, pp. 1551– 1558. 

- [5] V. Smidl and A. Quinn, _The Variational Bayes Method in Signal Processing_ , Springer, 2006. 

- [6] M. J. Beal and Z. Ghahramani, “The variational Kalman smoother,” Tech. Rep. TR01-003, Gatsby Unit, 2001. 

- [7] H. Valpola, M. Harva, and J. Karhunen, “Hierarchical models of variance sources,” _Signal Processing_ , vol. 84(2), pp. 267–282, 2004. 

- [8] P. Maybeck, _Stochastic Models, Estimation and Control, Volume 2_ , Academic Press, 1982. 

- [9] X.-R. Li and Y. Bar-Shalom, “A recursive multiple model approach to noise identification,” _IEEE Transactions on Aerospace and Electronic Systems_ , vol. 30(3), July 1994. 

- [10] G. Storvik, “Particle filters in state space models with the presence of unknown static parameters,” _IEEE Transactions on Signal Processing_ , vol. 50(2), pp. 281– 289, 2002. 

- [11] P. M. Djuric and J. Miguez, “Sequential particle filtering in the presence of additive Gaussian noise with unknown parameters,” in _Proceedings of the IEEE International Conference on Acoustics, Speech, and Signal Processing, Orlando, FL_ , 2002. 

- [12] S. S¨arkk¨a, “On sequential Monte Carlo sampling of discretely observed stochastic differential equations,” in _Proceedings of the Nonlinear Statistical Signal Processing Workshop_ , September 2006, [CDROM]. 

- [13] A. H. Jazwinski, _Stochastic Processes and Filtering Theory_ , Academic Press, 1970. 

   - [15] K. Ito and K. Xiong, “Gaussian filters for nonlinear filtering problems,” _IEEE Transactions on Automatic Control_ , vol. 45, no. 5, pp. 910–927, May 2000. 

   - [16] Y. Wu, D. Hu, M. Wu, and X. Hu, “A numericalintegration perspective on Gaussian filters,” _IEEE Transactions on Signal Processing_ , vol. 54, no. 8, pp. 2910–2921, August 2006. 

   - [17] S. J. Julier, J. K. Uhlmann, and H. F. Durrant-Whyte, “A new method for the nonlinear transformation of means and covariances in filters and estimators,” _IEEE Transactions on Automatic Control_ , vol. 45, no. 3, pp. 477– 482, March 2000. 

   - [18] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Transactions on Automatic Control_ , vol. 54, no. 6, pp. 1254–1269, June 2009. 

   - [19] M. Nørgaard, N. K. Poulsen, and O. Ravn, “New developments in state estimation for nonlinear systems,” _Automatica_ , vol. 36, no. 11, pp. 1627 – 1638, 2000. 

   - [20] T. Lefebvre, H. Bruyninckx, and J. De Schutter, “Comment on ”a new method for the nonlinear transformation of means and covariances in filters and estimators” [and authors’ reply],” _IEEE Transactions on Automatic Control_ , vol. 47, no. 8, pp. 1406–1409, August 2002. 

   - [21] M. P. Deisenroth, M. F. Huber, and U. D. Hanebeck, “Analytic moment-based Gaussian process filtering,” in _Proceedings of the 26th International Conference on Machine Learning_ , 2009. 

   - [22] T. S. Jaakkola, “Tutorial on variational approximation methods,” in _Advanced Mean Field Methods – Theory and Practice_ , M. Opper and D. Saad, Eds. 2001, pp. 129–159, MIT Press. 

   - [23] M. J. Beal, _Variational Algorithms for Approximate Bayesian Inference_ , Ph.D. thesis, Gatsby Computational Neuroscience Unit, University College London, 2003. 

   - [24] H. Lappalainen and J. W. Miskin, “Ensemble learning,” in _Advances in Independent Component Analysis_ , M. Girolami, Ed. 2000, pp. 75–92, Springer-Verlag. 

   - [25] A. Gelman, J. B. Carlin, H. S. Stern, and D. R. Rubin, _Bayesian Data Analysis_ , Chapman & Hall, 2004. 

   - [26] J. H. Kotecha and P. M. Djuric, “Gaussian particle filtering,” _IEEE Transactions on Signal Processing_ , vol. 51, no. 10, pp. 2592–2601, October 2003. 

- [14] Y. Bar-Shalom, X.-R. Li, and T. Kirubarajan, _Estimation with Applications to Tracking and Navigation_ , Wiley Interscience, 2001. 

