---
source_url:
ingested: 2026-05-05
sha256: 9b09c352908abb519a9bd3302832a5b18bcc86d3c402ab282a2ffb6ced532da8
---

# Optimized Selection of Sigma Points in the Unscented Kalman Filter 

Yiping Cheng and Ze Liu 

School of Electronic and Information Engineering Beijing Jiaotong University, Beijing 100044, China ypcheng@bjtu.edu.cn 

_**Abstract**_ **—The unscented Kalman filter (UKF) is an extension of the Kalman filter for nonlinear systems where a set of weighted sigma points are used to simulate the distribution of the state random variable. The performance of the filter depends heavily on the selection of sigma points, and the computational cost is proportional to the number of sigma points used. It was previously shown that** _n_ + 2 **(but not fewer) points are able to constitute a well-behaved set of sigma points. In this paper we show that this number can be further reduced to** _n_ +1 **. Numerical comparison of this optimized sigma point selection strategy with other strategies is also provided.** 

_**Keywords**_ **-** _**Kalman filter; nonlinear estimation; unscented filtering; Bayesian filtering**_ 

## I. INTRODUCTION 

The Kalman filter is a recursive algorithm that estimates the internal state of a linear dynamic system from a series of noisy measurements. It and its various extensions have a wide range of applications from radar and computer vision to estimation of structural macroeconomic models, making it an important topic in control theory and control systems engineering. One extension, the _extended Kalman filter_ (EKF), is suitable for mildly nonlinear systems. At each timestep, EKF essentially linearizes the nonlinear system model around the current state estimate by evaluating the Jacobian on the current estimated state. The resulting matrices can then be used in the Kalman filter equations. 

For highly nonlinear systems, EKF is no longer suitable because the linearization errors can be quite high which also cause stability problems of the filter. To address this problem, the _unscented Kalman filter_ (UKF) was proposed [1], [2], [3]. UKF uses a deterministic sampling technique to pick a set of sample points (called sigma points) around the mean. These sigma points are then propagated through the nonlinear functions, from which the mean and variance of the estimate are then recovered. The result is a filter which more accurately captures the true mean and variance. In addition, this technique removes the requirement to explicitly calculate Jacobians, which for complex functions can be a difficult task in itself. 

Because the computational costs are proportional to the number of sigma points used, there is a strong incentive to minimize the number of points required. In [4] it was proved that, for an _n_ -dimensional state, _n_ + 1 points are required to represent the mean and variance fully. In the same reference were derived the minimal skew set of simplex points that minimize the magnitude of the third order moments. However, 

This work was supported by the National Natural Science Foundation of China under Grant 61050001. 

these points have the problem that the radius which bounds the sphere of the points is 2 _[n/]_[2] . Therefore, at even relatively low dimensions there are potential problems with numerical stability. In a later paper [5], a sigma point selection strategy was given which uses _n_ + 2 points but is free of the problem above-mentioned. 

In this paper, we will give a new sigma point selection strategy. It requires only _n_ + 1 (which is already the absolute minimum) points, and like the ( _n_ +2)-point strategy in [5], the radius which bounds the points is proportional to _[√] n_ . So our strategy is also numerically well-behaved. 

To be self-contained, this paper will contain a full derivation of this optimized sigma point strategy, starting from the fundamentals of the unscented transformation. We will also give numerical examples where several sigma point selection strategies are compared so that they can be a guide for strategy selection in using the unscented Kalman filter. 

## II. THE NONLINEAR FILTERING PROBLEM 

**Notation:** The bold font is used for random variables. E( **X** ) and Var( **X** ) denote the mean and variance of **X** , respectively. Consider the following nonlinear dynamic system: 

**==> picture [170 x 11] intentionally omitted <==**

**==> picture [170 x 11] intentionally omitted <==**

where for all _k ≥_ 0, **x** _k_ is the state of the system at timestep _k_ , **v** _k_ is the process noise, **w** _k_ is the measurement noise, and **y** _k_ is the measured vector, and the equations hold for all _k ≥_ 1. Throughout the paper, it is assumed that 

**==> picture [181 x 10] intentionally omitted <==**

**==> picture [201 x 11] intentionally omitted <==**

**==> picture [203 x 10] intentionally omitted <==**

**==> picture [208 x 9] intentionally omitted <==**

Now we define the _k_ -th accumulated measurement vector by 

**==> picture [173 x 15] intentionally omitted <==**

For a dynamic system, filtering is for each timestep _k_ , to estimate the state **x** _k_ based on the noisy measurement vector **Y** _k_ . Mathematically, this is to determine the conditional density function _f_ **x** _k|_ **Y** _k_ . As a classical result of Bayesian inference, this task, at least conceptually, can be done recursively, i.e., the density _f_ **x** _k|_ **Y** _k_ can be expressed as a function of the previous density _f_ **x** _k−_ 1 _|_ **Y** _k−_ 1. This provides a unified recursive approach for the nonlinear filtering problem. However, 

978-1-4244-8165-1/11/$26.00 ©2011 IEEE Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:28:03 UTC from IEEE Xplore.  Restrictions apply. 3073 

this approach requires multi-dimensional integral of nonlinear functions, which is highly intractable except for some very simple cases. Therefore, for general nonlinear system we must content ourselves with an approximate solution of this filtering problem. The unscented Kalman filter (UKF) is one such approximate solution. A full description of the filtering algorithm is omitted here, as it can be found in many references, e.g. [3]. 

The key concept of UKF is the _Unscented Transformation_ (UT). In a general setting, suppose we have two random variables: input variable **x** and output variable **y** , with **y** = _F_ ( **x** ), then UT is to transform the statistical moments (mean, variance, etc.) of **x** to the statistics of **y** . In UKF, the input variable is the so-called “augmented state vector” and the output variable is the “state-measurement vector”. 

The _augmented state vector_ consists of the state vector, process noise, and measurement noise, as defined by 

**==> picture [151 x 35] intentionally omitted <==**

The _state-measurement vector_ is defined by 

**==> picture [150 x 23] intentionally omitted <==**

Then the state and measurement equations (1–2) can be grouped into a single equation 

**==> picture [228 x 24] intentionally omitted <==**

III. UNSCENTED TRANSFORMATION AND SIGMA POINTS 

Although it is theoretically possible to determine the distribution of the output variable given the input distribution and the mapping, it is practically hard to do it exactly. So as an approximate solution, a key technique used by UT is to deterministically select a set of weighted _sigma points_ in the range space of the input variable, so that the resulting discrete distribution approximates the distribution of the input variable. In UKF, at each timestep _k_ , the sigma points are so selected that their mean and variance match those of the input variable **x** _[a] k−_ 1 _[|]_ **[Y]** _[k][−]_[1][.][The][sigma][points][are][then][Ω] _[k]_[-mapped][into][the] output range space, and the discrete distribution of the mapped points are taken as an approximation of the distribution of **x** _[m] k[|]_ **[Y]** _[k][−]_[1][.][Specifically,][the][mean][and][variance][of][the][mapped] points are used as an approximation of the mean and variance of **x** _[m] k[|]_ **[Y]** _[k][−]_[1][.] 

So the problem becomes how to select a _good_ set of sigma points. That is, sigma points that satisfy the mean and variance requirements above-mentioned, and have a small number of points, because the time complexity heavily depends on the number of nonlinear function evaluations, which is proportional to the number of sigma points. 

_X_ 1 _, · · · , Xm_ with weights _w_ 1 _≥_ 0 _, · · · , wm ≥_ 0, such that 

**==> picture [188 x 87] intentionally omitted <==**

The above requirements leave a great degree of freedom to us. Note that if we put 

**==> picture [138 x 20] intentionally omitted <==**

then (11,12) reduce to 

**==> picture [187 x 57] intentionally omitted <==**

Let _X_ be the _n × m_ matrix whose _i_ -th column is _Xi_ , i.e. 

**==> picture [169 x 12] intentionally omitted <==**

Let _M_ be the _n × m_ matrix whose _m_ columns are all _μ_ , i.e. 

**==> picture [163 x 13] intentionally omitted <==**

Let 1 _m_ be the _m_ -dimensional column vector composed all of 1’s, i.e. 

**==> picture [164 x 11] intentionally omitted <==**

Then (14) is equivalent to 

**==> picture [155 x 10] intentionally omitted <==**

And (15) is equivalent to 

**==> picture [175 x 12] intentionally omitted <==**

Now if we put 

**==> picture [158 x 12] intentionally omitted <==**

where _[√] ·_ denotes an arbitrary square root of a positive semidefinite matrix, and the matrix _U_ satisfies the following: 

**==> picture [148 x 24] intentionally omitted <==**

## IV. SELECTION OF SIGMA POINTS 

Let us now return to the general setting: **x** is an (general) _n_ -dimensional real random variable, E( **x** ) = _μ ∈_ R _[n]_ and Var( **x** ) = Σ _∈_ R _[n][×][n]_ . We are to select _m_ sigma points 

then (19–20) are obviously fulfilled. And as a result, our original requirements (10–12) are also satisfied. 

Now, the problem of selecting _m_ sigma points is converted into one of constructing an _n × m_ matrix _U_ verifying (22–23). 

> Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:28:03 UTC from IEEE Xplore.  Restrictions apply. 3074 

## V. CONSTRUCTION OF MATRIX _U_ 

It is observed from (23) that rank( _U_ ) = _n_ , and from (22) that rank( _U_ ) _< m_ . Thus we have _m > n_ , i.e. _m ≥ n_ + 1. This section will give a method for the construction of _U_ with _m_ = _n_ +1. To emphasize its size, we shall in the sequel denote the _n ×_ ( _n_ + 1) _U_ matrix by _Un_ . 

Let us first note that there is an equivalence relationship between the _Un_ ’s. Put mathematically, if _Un[′]_[=] _[OU][n][P]_[where] _O_ is orthogonal and _P_ is a permutation matrix, then _Un_ and _Un[′]_[are][essentially][equivalent.][In][light][of][this][equivalence,][for] _n >_ 1, we can directly stipulate, without loss of generality, that 

**==> picture [160 x 24] intentionally omitted <==**

where _Un−_ 1, 0, _α_ , and _β_ are ( _n −_ 1) _× n_ , ( _n −_ 1) _×_ 1, 1 _× n_ , and 1 _×_ 1 matrices, respectively. This is because that, if _Un_ is not of this form, we can always find a suitable orthogonal matrix _O_ and permutation matrix _P_ such that _OUnP_ is of this form. 

where _α_ = 0 _._ 5, _β_ = 25, _γ_ = 8, _x_ 0 = 0 _._ 1, _vk ∼ N_ (0 _,_ 1), and _wk ∼ N_ (0 _,_ 1). The filtering results of the three methods are show in Fig. 1 and the mean square errors are shown in Table I. 

**==> picture [180 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
Real signal<br>EKF filtering result filtered estimate<br>20<br>10<br>0<br>−10<br>−20<br>0 10 20 30 40 50 60 70 80 90 100<br>UKF(2N+1 samples) filtering result<br>20<br>10<br>0<br>−10<br>−20<br>0 10 20 30 40 50 60 70 80 90 100<br>UKF(N+1 samples) filtering result<br>20<br>10<br>0<br>−10<br>−20<br>0 10 20 30 40 50 60 70 80 90 100<br>**----- End of picture text -----**<br>


Fig. 1. Filtering results: EKF, UKF(2 _n_ +1 samples) and UKF( _n_ +1 samples) 

Applying (22) to (24), we have 

**==> picture [162 x 23] intentionally omitted <==**

Applying (23) to (24), we have 

**==> picture [159 x 26] intentionally omitted <==**

**==> picture [156 x 11] intentionally omitted <==**

From (25,27,28) one can derive that 

**==> picture [157 x 11] intentionally omitted <==**

where _a_ is a scalar to be determined. Thus it follows from (26) that 

**==> picture [140 x 10] intentionally omitted <==**

Thus by (29) we arrive at 

**==> picture [157 x 24] intentionally omitted <==**

The equations (24,32,30,31) now constitute a recursive procedure for computing _Un_ . Of course, this procedure needs a start equation, which is given by 

**==> picture [174 x 32] intentionally omitted <==**

We have given a new sigma point selection strategy where _n_ +1, which is the minimum, points are used. Now we compare the performance of our new strategy with that of EKF and the standard UKF (which uses 2 _n_ + 1 samples). For the purpose of simulation, the highly nonlinear “univariate nonstationary growth” model from [6], [7] is used to generate the observed data. The model is described by 

**==> picture [212 x 48] intentionally omitted <==**

|EKF|UKF(2n+1 samples)|UKF(n+1 samples)|
|---|---|---|
|87.6184|68.9418|49.0367|
||TABLE I||
||MEAN SQUARE ERRORS||



The above results indicate that the two UKF methods perform better than EKF, and UKF with our new sigma point selection scheme performs slightly better than the standard UKF. Generally, the performance of the new scheme is comparable to that of the standard UKF. Note that this is achieved with a reduced computational cost. 

## VII. CONCLUSION 

UKF is now the preferred method for the estimation of state in nonlinear processes. Its computational cost is proportional to the number of sigma points used, which is 2 _n_ + 1 in the standard UKF, and is _n_ + 2 in the spherical simplex UKF proposed in [5]. We have here proposed a new scheme for the selection of sigma points, which uses _n_ + 1 points, attaining the minimum. Simulation results show the numerical behavior of this new scheme to be satisfactory. These make our scheme very attractive in the implementation of UKF. 

## REFERENCES 

- [1] Simon J. Julier and Jeffrey K. Uhlmann. A general method for approximating nonlinear transformations of probability distributions. Technical report, 1996. 

- [2] Simon J. Julier and Jeffrey K. Uhlmann. A new extension of the Kalman filter to nonlinear systems. pages 182–193, 1997. 

- [3] Simon J. Julier and Jeffrey K. Uhlmann. Unscented filtering and nonlinear estimation. _Proceedings of the IEEE_ , pages 401–422, 2004. 

- [4] Simon J. Julier and Jeffrey K. Uhlmann. Reduced sigma point filters for the propagation of means and covariances through nonlinear transformations. In _Proceedings of the 2002 American Control Conference_ , pages 887–892, May 2002. 

- [5] Simon J. Julier. The spherical simplex unscented transformation. In _Proceedings of the 2003 American Control Conference_ , volume 3, pages 2430–2434, June 2003. 

- [6] G. Kittagawa. Non-Gaussian state-space modeling of nonstationary time series. _Journal of the American Statistical Association_ , 82(400):1032– 1063, 1987. 

- [7] J. H. Kotecha and P. M. Djuric. Gaussian particle filtering. _IEEE Transactions on Signal Processing_ , 51(10):2592–2601, 2003. 

> Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:28:03 UTC from IEEE Xplore.  Restrictions apply. 3075