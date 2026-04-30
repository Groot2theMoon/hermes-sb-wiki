1 

## Adaptive Neural Unscented Kalman Filter 

Amit Levy , Itzik Klein 

_**Abstract**_ **—The unscented Kalman filter is an algorithm capable of handling nonlinear scenarios. Uncertainty in process noise covariance may decrease the filter estimation performance or even lead to its divergence. Therefore, it is important to adjust the process noise covariance matrix in real time. In this paper, we developed an adaptive neural unscented Kalman filter to cope with time-varying uncertainties during platform operation. To this end, we devised ProcessNet, a simple yet efficient endto-end regression network to adaptively estimate the process noise covariance matrix. We focused on the nonlinear inertial sensor and Doppler velocity log fusion problem in the case of autonomous underwater vehicle navigation. Using a real-world recorded dataset from an autonomous underwater vehicle, we demonstrated our filter performance and showed its advantages over other adaptive and non-adaptive nonlinear filters.** 

## I. INTRODUCTION 

The linear Kalman filter (KF) is an optimal minimum mean squared error (MMSE) estimator for state estimation of linear dynamic systems in the presence of Gaussian distribution and Gaussian noises. For nonlinear problems, the extended Kalman filter (EKF) is used. The EKF linearizes the system and measurement models using a first-order partial derivative (Jacobian) matrix while applying the KF propagation step (or the update step) to the error-state covariance matrix [1]. The linearization procedure introduces errors in the posterior mean and covariance, leading to sub-optimal performance and at times divergence of the EKF [2]. To circumvent the problem, Julier and Uhlmann [3] introduced the unscented Kalman filter (UKF). The underlying idea was that a probability distribution is relatively easier to approximate than an arbitrary nonlinear function. To this end, UKF uses carefully chosen, sigma points that capture the state mean and covariance. When propagated through the nonlinear system, it also captures the posterior mean and covariance accurately to the third order [2]. 

Generally, the UKF is more accurate than the EKF and obviates the need to calculate the Jacobian matrix. Like the EKF, it requires the prior statistical characteristic of system noise, process noise covariance, and the measurement noise covariance to be precisely known, specifically because the covariances directly regulate the effect of prediction values and measurements on system state estimations. Describing the exact noise covariance, which may change during operation, is a challenging task but an important one because uncertainty may reduce the filter estimation performance or even lead to its divergence. Therefore, methods for adjusting the process and measurement noise covariance matrices have been suggested in the literature, introducing the concept of adaptive filters. A common approach to adaptive filtering is covariance matching [4]. This method uses the innovation (difference between 

A. Levy and I. Klein are with the Hatter Department of Marine Technologies, Charney School of Marine Sciences, University of Haifa, Israel. Corresponding author: alevy02@campus.haifa.ac.il 

the actual measurement and its predicted prior value) and residual (difference between the real measurement and its estimated posterior value) vectors to construct a noise statistics estimator to estimate and tune the process and measurement covariance matrices in real time. A robust adaptive UKF (RAUKF) was introduced [5] to adaptively adjust the noise covariance matrices according to the current estimation and the previous value only when a statistical fault is detected. In [6], the algorithm used to adjust the process and measurement noise covariance matrices is based on the residual and innovation sequences, using a moving window to improve the navigation performance of an autonomous underwater vehicle. Correlation and covariance matching play a role also in [7], where the authors adjust the error covariance, process, and measurement noise covariance matrices using a scaling factor that decreases in time to obtain better performance for ultratight global positioning system (GPS)-integrated navigation. Covariance matching was used also in [8] to improve the performance of integrated GPS in a navigation system using the residual and innovation sequences in a moving window time frame. 

Recently, machine learning (ML) and deep learning (DL) algorithms have been embedded into inertial sensing and sensor fusion problems ([9], [10]), including for adaptive process noise covariance estimation. [11] proposed variational Bayesian adaptive UKF for indoor localization where the adjustment of the process and measurement noise matrices are carried out by performing variational approximation, using Wishart prior distribution and the likelihood of current states and current measurements. Genetic algorithm (GA) support vector regression (SVR) (an SVR GA optimized approach) was proposed in [12] to better optimize the UKF, based on the moving window covariance matching method. Another approach is to update the UKF process and measurement noise covariance matrices using the intuitionistic fuzzy logic method [13]. Subsequently, a set of papers proposed different neural network architectures to regress the process noise covariance in nonlinear navigation estimation frameworks. Initially, a hybrid learning-based adaptive EKF filter was proposed in [14], where, a deep neural network model that tunes the momentary system noise covariance based only on the inertial sensor readings was suggested. VIO-DualProNet is a novel DL method to dynamically estimate the inertial noise and integrate it into the visual-inertial navigation system (VINSMono) algorithm [15], where a process noise network, ProNet, was designed separately for the accelerometer and gyroscope readings. In [16], the authors proposed an adaptive EKF, where a set-transformer network learns the varying process noise covariance in real time, adjusting an EKF, which optimized a navigation algorithm based on an inertial navigation system (INS) and Doppler velocity log (DVL). 

2 

Motivated by the above adaptive hybrid EKF methods, we propose the adaptive neural UKF (ANUKF) capable of tuning the process noise matrix dynamically and thereby coping with the nonlinear characteristics of the inertial fusion problem. ANUKF uses simple yet efficient enhanced ProcessNet networks that capture the dynamic system uncertainties, feeding them through a process noise covariance matrix. To demonstrate our ANUKF, we adopted the INS/DVL fusion for autonomous underwater vehicles (AUVs). Using a real recorded dataset from an AUV, we compared our approach with the standard UKF (fixed process noise covariance) and an adaptive neural EKF (ANEKF) that uses the same enhanced ProcessNet networks, creating a fair comparison. We show that our ANUKF outperforms both approaches in normal DVL conditions and in situations of DVL outages. 

The rest of the paper is organized as follows: Section II describes the UKF algorithm. Section III introduces our proposed approach including the neural network architecture, its training procedure, and the process noise matrix updating procedure. Section IV presents our AUV recorded dataset and results. Finally, Section V provides the conclusions of this work. 

## II. PROBLEM FORMULATION 

## _A. The UKF algorithm_ 

As noted above, the process noise Q and measurement noise R matrices may change because of dynamic or environmental conditions. Incorrect estimation of these matrices may cause inaccurate estimation of the UKF or even its divergence. Consider UKF to estimate the unobserved state vector x of the following dynamic system: 

**==> picture [165 x 11] intentionally omitted <==**

where _xk_ is the unobserved state at step _k_ , _f_ is the dynamic model mapping, and _ω_ is the process noise. 

**==> picture [175 x 11] intentionally omitted <==**

where, _h_ is the observation model mapping, _ν_ is the measurement noise, and _zk_ +1 is the observed signal at step _k_ + 1. UKF [3] is based on the scaled unscented transform (UT), a method for calculating the statistics of a random variable that undergoes a nonlinear transformation. It starts with a selected population, propagates the population through the nonlinear function, and computes the appropriate probability distribution (mean and covariance) of the new population. The population is carefully selected to induct the mean and covariance of the undergoing population by the nonlinear transformation. The UKF is an iterative algorithm. The initialization step is followed by iterative cycles, each consisting of several steps. Step 1 is the initialization, steps 2-4 are executed iteratively (step 4 upon measurement availability). These steps are described below. 

1) Initialization Given the initializing random _n_ state vector _x_ 0 with known mean and covariance, set 

**==> picture [139 x 11] intentionally omitted <==**

**==> picture [179 x 12] intentionally omitted <==**

set the weights for the mean (uppercase letters m) computation and the covariance (uppercase letters c): 

**==> picture [147 x 24] intentionally omitted <==**

**==> picture [178 x 24] intentionally omitted <==**

**==> picture [189 x 24] intentionally omitted <==**

2) Update sigma points 

Set 2 _n_ + 1 sigma points as follows: 

**==> picture [143 x 12] intentionally omitted <==**

**==> picture [190 x 72] intentionally omitted <==**

where **P** _k|k_ is positive definite, therefore it can be ~~_T_~~ factored by Cholesky decomposition as ~~[�]~~ **P** _k|k_ ~~�~~ **P** _k|k_ . ~~�~~ **P** _k|ki_ is the _i_ row of the matrix[�] **P** _k|k_ . The points are symmetrical around the expected value, so the expectation is preserved. _λ_ = _α_[2] ( _n_ + _κ_ ) _− n_ is a scaling parameter, _α_ determines the spread of the sigma points around _x_ ˆ _k|k_ , usually set to a small value (1 _e −_ 3), _κ_ is a secondary scaling parameter usually set to 0, and _β_ is used to incorporate prior knowledge of the distribution of _x_ (for Gaussian distribution it is set to 2). 

- 3) Time update 

The sigma points (vectors) propagate through the dynamic model mapping, after which we compute the reflected mean and covariance as follows: 

**==> picture [189 x 12] intentionally omitted <==**

**==> picture [222 x 68] intentionally omitted <==**

ˆ where _δ_ _**x** i,k_ +1 _|k_ = _**x** i,k_ +1 _|k −_ _**x** k_ +1 _|k_ , **Q** _k_ +1 is the covariance process noise matrix at step _k_ + 1 

4) Measurement update 

Update the sigma points according to the time update phase to estimate the observation/measurement: 

**==> picture [153 x 11] intentionally omitted <==**

**==> picture [208 x 22] intentionally omitted <==**

**==> picture [46 x 9] intentionally omitted <==**

**==> picture [214 x 33] intentionally omitted <==**

3 

Compute the estimated measurement of each sigma point: 

**==> picture [189 x 12] intentionally omitted <==**

Compute the mean estimated measurement: 

**==> picture [167 x 30] intentionally omitted <==**

Compute the measurement covariance matrix: 

**==> picture [217 x 30] intentionally omitted <==**

ˆ where _δ_ _**z** i,k_ +1 _|k_ = _**z** i,k_ +1 _|k −_ _**z** k_ +1 _|k_ , **R** _k_ +1 is the measurement process noise at step _k_ + 1. Compute the cross-covariance matrix: 

**==> picture [188 x 30] intentionally omitted <==**

ˆ _**z**_ where _i,k_ +1 _|kδ −_ _**x** i,k_ _**z**_ ˆ+1 _k_ +1 _|k|k_ =. _**x** i,k_ +1 _|k −_ _**x** k_ +1 _|k_ and _δ_ _**z** i,k_ +1 _|k_ = Compute the Kalman gain: 

**==> picture [156 x 14] intentionally omitted <==**

Compute the new mean according to the observation _zk_ +1: 

**==> picture [215 x 12] intentionally omitted <==**

Compute the new covariance matrix using the Kalman gain: 

**==> picture [208 x 13] intentionally omitted <==**

Equation (13) introduces **Q** _k_ +1, the process noise covariance matrix at step _k_ + 1, affecting directly **P** _k_ +1 _|k_ , the error covariance matrix. As noted, the process noise may change. It is critical to estimate it correctly, otherwise loss of accuracy or even divergence may occur. 

## III. PROPOSED APPROACH 

To cope with real-time adaptive process noise covariance matrix estimation in nonlinear filtering, we propose ANUKF, an adaptive neural unscented Kalman filter. The motivation for our approach stems from the fact that although the UKF structure enables it to better handle nonlinear problems, it lacks the ability to cope with real-world varying uncertainty. By contrast, our ANUKF offers a simple and efficient neural network to learn the uncertainty of the process noise covariance using only inertial sensor readings. For demonstration purposes, we adopted the DVL and INS (DVL/INS) fusion problem but the proposed ANUKF can be applied to any inertial fusion problem. 

A block diagram of ANUKF for DVL/INS fusion is presented in Figure 1. The inertial sensor readings and the estimated velocity of the DVL are plugged into the UKF. Additional inputs to our regression network, ProcessNet, are the inertial readings. ANUKF outputs the adaptive process noise covariance matrix required by the UKF mechanism and gives the full estimated navigation solution. 

**==> picture [227 x 96] intentionally omitted <==**

Fig. 1: Our proposed ANUKF implemented on the DVL/INS fusion problem. 

## _A. ANUKF for DVL/INS fusion_ 

The following 12 error state vector is used in the DVL/INS settings: 

**==> picture [205 x 14] intentionally omitted <==**

where _δ_ _**v**[n] ∈_ R[3] is the velocity error state vector, expressed in the navigation frame, _**δ**_ Ψ _[n] ∈_ R[3] is the misalignment error state vector, expressed in the navigation frame, _**b** a ∈_ R[3] is the accelerometers residual bias vector expressed in the body frame, and _**b** g ∈_ R[3] is the gyroscope’s residual bias vector expressed in the body frame. The body frame is an orthogonal axis set (x,y,z), centered on the reference point of the inertial measurements: the x-axis aligns with the AUV’s longitudinal axis, pointing in the forward direction; the z- axis extends downward; and the y-axis extends outward, completing the right-hand orthogonal coordinate system. The inertial measurements are modeled with their true values, with the addition of bias and zero mean white Gaussian noise: 

**==> picture [174 x 35] intentionally omitted <==**

where _fib,t[b]_[is][the][measured][specific][force][vector,] _**[ω]**[b] ib,t_[is][the] measured angular velocity expressed in the body frame, _bi i_ = _a, g_ is the bias vector of the accelerometer and gyroscope, respectively, and _ni i_ = _a, g_ is the zero mean white Gaussian noise of the accelerometer and gyroscope, respectively. The biases are modeled as random walk processes: 

**==> picture [176 x 12] intentionally omitted <==**

**==> picture [176 x 14] intentionally omitted <==**

where _σ_ _**a** b_ and _σ_ _**g** b_ are the accelerometer and gyroscope Gaussian noise standard deviations, respectively. The UKF error state continuous time model is 

**==> picture [166 x 12] intentionally omitted <==**

where **F** _∈_ R[12] _[×]_[12] is the system matrix (see [17] section 12.2.4), _δ_ _**w**_ = [ _**n**[T] a_ _**[n]**[T] g_ _**[n]**[a] bT_ _**n** gbT_ ] _T ∈_ R12 _×_ 1 is the system noise vector, and _G ∈_ R[12] _[×]_[12] is the system noise distribution matrix 

**==> picture [201 x 48] intentionally omitted <==**

4 

with **C** _[n] b_ representing the rotation matrix from the body frame to the navigation frame, as calculated by the navigation algorithm, **0** 3 _×_ 3 is the zero matrix, and **I** 3 _×_ 3 is the identity matrix. 

The discrete process noise covariance is obtained based on the continuous process noise covariance and given by ([1] section 4.3.4): 

**==> picture [188 x 13] intentionally omitted <==**

where 

**==> picture [185 x 13] intentionally omitted <==**

The measurement, (22), requires the calculation of the mean estimated measurement (18). It depends on _**z** i,k_ +1 _|k_ , the estimation of the velocity error vector in the body frame axes of sigma-point _i_ , _i_ = 0 _, ...,_ 2 _n_ , as shown in (17). To this end, we computed _**z** i,k_ +1 _|k_ as follows: 

**==> picture [249 x 39] intentionally omitted <==**

where, _Cn[b]_[is the computed rotation matrix from the navigation] frame to the AUV body frame, _C_[ˆ] _n[n] i_[is][the][estimated][misalign-] ment ( _δ_ Ψ _[n] i_[)][of][sigma][point] _[i]_[,] _**[v]**[n]_[is][the][computed][velocity][in] the navigation frame, and ∆ˆ _**v** ni_ is the estimated velocity error of sigma point _i_ given in the navigation frame. 

where the operation is defined elementwise (if _x ∈_ R _[m][×][n]_ then also _ReLU_ ( _x_ ) _∈_ R _[m][×][n]_ ). Using a window size of _w_ = 100, the first layer is defined by: 

**==> picture [209 x 61] intentionally omitted <==**

where **d** _inpad ∈_ R[102] _[×]_[3] is the padded input, **d** _inpad_ ( _i_ : _i_ +2 _, j_ ) is the row vector [ **d** _inpad_ ( _i, j_ ) _,_ **d** _inpad_ ( _i_ + 1 _, j_ ) _,_ **d** _inpad_ ( _i_ + 2 _, j_ )], _∗_ is the cross-correlation operator (if _**a** ,_ _**c** ∈_ R[3] _[×]_[1] , _**a**[T] ∗_ _**c**_ =[�][3] _h_ =1 _**[a]**_[(] _[h]_[)] _[ ·]_ _**[ c]**_[(] _[h]_[)][).] _**[l]**_[1] _[∈]_[R][100] _[×]_[30][,] **[Θ]**[1] _[∈]_[R][3] _[×]_[30] _[×]_[3][,] _**[b]**_[1] _[∈]_ R[30] _[×]_[1] , and _max_ is the ReLU operation. The second layer is defined by: 

**==> picture [209 x 61] intentionally omitted <==**

with **l** 2 _∈_ R[100] _[×]_[30] , **l** 1 _pad ∈_ R[102] _[×]_[30] , **Θ** 2 _∈_ R[30] _[×]_[30] _[×]_[3] , and _**b**_ 2 _∈_ R[30] _[×]_[1] . 

The third layer, **l** 3 _∈_ R[50] _[×]_[30] , is: 

**==> picture [212 x 25] intentionally omitted <==**

and the forth layer, **l** 4 _∈_ R[50] _[×]_[30] , is: 

## _B. ProcessNet Structure_ 

The dynamic accelerometers and gyroscopes process noise covariance network architecture is described in Figure 2. Although the network structure is identical, the accelerometer ProcessNet and gyroscope ProcessNet differ in their input and output. The input to the accelerometer ProcessNet network at time step _k_ is the accelerometer readings in a predefined window size and the output is the diagonal entries in the process noise covariance matrix that corresponds to the accelerometers. The dynamic gyroscope ProcessNet network architecture is similar to the accelerometer network but it has scale components to the input and the output, forcing the network to work with sufficiently large numbers. The network inputs at time step _k_ are the gyroscope readings in a predefined window size and the output is the diagonal entries in the process noise covariance matrix that corresponds to the gyroscopes. 

Next, we defined the network layers, as shown in Figure 2. The network receives an input _din ∈_ R _[w][×]_[3] , where 3 is the number of input channels and _w_ is the window size length (number of samples in each input). Each layer is denoted by _li_ , where _i_ is the number of the layer, _**b** i_ is the bias vector, and **Θ** _i_ represents the weights of layer _i_ . We also used the rectified linear unit (ReLU) activation function between each layer defined by (34), followed by max/average pooling. 

**==> picture [209 x 61] intentionally omitted <==**

where _**l**_ 3 _pad ∈_ R[52] _[×]_[30] , **Θ** 3 _∈_ R[30] _[×]_[30] _[×]_[3] , and _**b**_ 3 _∈_ R[30] _[×]_[1] . The fifth layer, **l** 5 _∈_ R[50] _[×]_[30] , is defined by: 

**==> picture [209 x 61] intentionally omitted <==**

where **l** 4 _pad ∈_ R[52] _[×]_[30] , **Θ** 4 _∈_ R[30] _[×]_[30] _[×]_[3] , and _**b**_ 4 _∈_ R[30] _[×]_[1] .. The sixth and last convolution layer, **l** 6 _∈_ R[25] _[×]_[30] , is: 

**==> picture [212 x 25] intentionally omitted <==**

The next operation is to flatten **l** 6 to form _**l**_ 7 _∈_ R[750] _[×]_[1] . The last hidden layer is a fully connected one with a linear operation: 

**==> picture [181 x 13] intentionally omitted <==**

where **Θ** 5 _∈_ R[750] _[×]_[3] and _**b**_ 5 _∈_ R[3] _[×]_[1] , so that _**netres** ∈_ R[3] _[×]_[1] . 

_ReLU_ ( _x_ ) = _max_ (0 _, x_ ) 

(34) 

5 

**==> picture [516 x 141] intentionally omitted <==**

Fig. 2: ProcessNet: the accelerometer and gyroscope process noise covariance regression network structure. 

## _C. Training Process_ 

The mean square error (MSE) loss function is used in both the accelerometer and gyroscope ProcessNets. The loss is defined by: 

**==> picture [209 x 28] intentionally omitted <==**

where _n_ is the batch size, _N_[ˆ] _k, Nk ∈_ R _[n][×]_[3] are the ProcessNet batched estimations and the ground truth (GT), with _k_ = _a, g_ for the accelerometer and gyroscope networks, respectively. 

## _D. Updating the ANUKF process noise_ 

The general structure of the regressed adaptive process noise matrix is: 

**==> picture [219 x 49] intentionally omitted <==**

Next, we define each 3 _×_ 1 vector that assembles the diagonal elements of the non-zero 3 _×_ 3 submatrices in (43). The accelerometer network output [ _qax, qay , qaz_ ] is multiplied by the integration interval _τ_ , so that 

**==> picture [173 x 12] intentionally omitted <==**

Using (44), the velocity uncertainty is: 

**==> picture [152 x 10] intentionally omitted <==**

where _τa_ is a factor that depends on the inertial measurement rate. In the same manner, the gyroscope network outputs [ _qgx, qgy , qgz_ ] are multiplied by the integration interval _τ_ , so that 

**==> picture [172 x 13] intentionally omitted <==**

Using (46), the orientation uncertainty is: 

**==> picture [153 x 11] intentionally omitted <==**

where _τg_ is an appropriate factor that depends on the inertial measurement rate. 

For system stability, we ensure that the network outputs are within a valid range of values before updating the filter, that is, we incorporate a conditioned inertial perspective to validate 

the network output. For example, the output should be positive (covariance matrix), not too small (perfect inertial sensors), and not too large (unrealistic behavior of the inertial sensors). Next, the regressed process noise matrix (43) is plugged into (31) instead of (32) to create the ANUKF adaptive process noise covariance: 

**==> picture [188 x 16] intentionally omitted <==**

Finally, the error state covariance matrix is updated by: 

**==> picture [228 x 30] intentionally omitted <==**

**==> picture [163 x 11] intentionally omitted <==**

## IV. EXPERIMENTAL RESULTS 

## _A. Dataset_ 

We used the Snapir AUV dataset ([18]) for training and testing our proposed approach. Snapir is an ECA Robotics modified Group A18D mid-size AUV. The Snapir AUV is outfitted with the iXblue, Phins Subsea INS, which uses fiber optic gyroscope (FOG) technology for precise inertial navigation [19]. Snapir also uses a Teledyne RDI Work Horse Navigator DVL [20], known for its capability to provide accurate velocity measurements. The INS operates at a frequency of 100 [Hz], whereas the DVL operates at 1[Hz]. The dataset contains 24 minutes of recording divided into 6 trajectories. Each trajectory contains the DVL/INS fusion solution (addressed as GT), inertial readings, and DVL measurements. In addition: 

- The initial navigation solution includes Euler angles (yaw, pitch, roll) given in [ _rad_ ] from the body frame to the navigation frame, the velocity vector expressed in the navigation frame (north, east, down) in [ _m/s_ ], and the position (latitude, longitude, altitude) [ _rad, rad, m_ ]. 

- The IMU outputs are accelerometer and gyroscope readings expressed in the body frame (the rotation from the IMU frame to the body frame is known). The inertial sensors are sampled at 100Hz. 

- The DVL output velocity vector ( _x, y, z_ )[ _m/s_ ] is expressed in the body frame (the rotation from the DVL frame to the body frame is known). The DVL measurements are sampled at 1Hz. 

6 

To create the trajectories being tested, we added the following to the given raw data: initial velocity errors with a standard deviation (STD) of 0 _._ 25[ _m/s_ ] and 0 _._ 05[ _m/s_ ], horizontal and vertical, respectively, and misalignment errors with a STD of 0 _._ 01[ _deg_ ] per axis. We also added noises with a STD of 0 _._ 03[ _m/s_[2] ] to the accelerometers and 7 _._ 3 _×_ 10 _[−]_[6] [ _rad/s_ ] to the gyroscopes. Finally, we added biases with a STD of 0 _._ 3[ _m/s_[2] ] to the accelerometers and 7 _._ 3 _×_ 10 _[−]_[5] [ _rad/s_ ] to the gyroscopes, which have been changed dynamically (multiplied by factors of 1 _−_ 6), bringing the measurements closer to tactical grade IMU outputs. 

For the training process, we used tracks 1-4, each track consisting of 4 minutes, resulting in a total of 16 minutes of the training dataset. The trajectories, presented in Figure 3 include a wide range of dynamics and maneuvers. Track 1 (Figure 3a) and track 2 (Figure 3b) have relatively more maneuvers and dynamic changes than track 3 (Figure 3c) and track 4 (Figure 3d), which have longer straight sections. The testing datasets 

**==> picture [122 x 86] intentionally omitted <==**

**==> picture [122 x 84] intentionally omitted <==**

**==> picture [253 x 109] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Track 1 (b) Track 2<br>(c) Track 3 (d) Track 4<br>**----- End of picture text -----**<br>


Fig. 3: Horizontal position of tracks 1-4 used in the training dataset. 

includes tracks 5-6, presented in Figure 4, with a total time of 8 minutes. These trajectories include a wide range of dynamics and maneuvers. 

**==> picture [122 x 85] intentionally omitted <==**

**==> picture [122 x 85] intentionally omitted <==**

**==> picture [173 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Track 5 (b) Track 6<br>**----- End of picture text -----**<br>


Fig. 4: Horizontal position of tracks 5-6 used in the testing dataset. 

## _B. Evaluation matrices and approaches_ 

In [16], the authors showed that adaptive neural EKF (ANEKF) with dynamic process noise performs better than non-adaptive EKF and adaptive EKF that uses covariance matching as the adaptation method. Therefore, we used ANEKF as the baseline and compared it with the non-adaptive UKF, and our ANUKF. 

For a fair comparison, all three filters used the same navigation algorithm. The navigation algorithm initialized by the reference solution integrates the updated IMU outputs and reduces navigation errors by fusing the DVL measurements. Moreover, the two adaptive filters (ANEKF and ANUKF) had the same training process as our proposed network architecture: ProcessNet. 

We carried out 100 Monte Carlo runs on the two tracks in the testing dataset. For each track we calculated the total velocity root mean square error (VRMSE) and the total misalignment root mean square error (MRMSE) and averaged the results. For a given track, the VRMSE is calculated as follows: 

**==> picture [209 x 37] intentionally omitted <==**

where, _n_ is the number of samples in the trajectory, _m_ is the number of MC runs, _∥δ_ _**v** i_ ( _j_ ) _∥_ is the norm of the velocity error between the estimated velocity and the GT of run _i_ in time step _j_ . The track average is: 

**==> picture [237 x 25] intentionally omitted <==**

where _V RMSE_ 5 and _V RMSE_ 6 are the _V RMSE_ of tracks 5 and 6, respectively. In the same manner, the MRMSE is: 

**==> picture [212 x 36] intentionally omitted <==**

where _δ_ **Ψ** _i_ ( _j_ ) is the misalignment vector that represents by the Euler angles corresponding to the following transformation matrix **C** _[n] nr_[:] 

**==> picture [162 x 13] intentionally omitted <==**

and **C** _[b] nr_[is][the][GT][rotation][matrix][from][the][navigation][frame] to the body frame. 

## _C. Results_ 

We applied the three filters, UKF, ANEKF, and ANUKF, to the test dataset. Table I summarizes the VRMSE and MRMSE results of the three filters, showing that the velocity solution of the ANUKF performs better than the non-adaptive UKF and the ANEKF, and that the velocity solution of the ANEKF is better than that of the non-adaptive UKF. In other words, ANUKF showed an improvement of 21 _._ 3% over UKF and 8 _._ 2% over ANEKF. The ANUKF estimation of misalignment showed an improvement of 5 _._ 4% over UKF and 32 _._ 1% over ANEKF. To further examine the robustness of our approach, we evaluated the two adaptive filters in situations of DVL outages, as is often the case in real-world scenarios [18]. 

7 

|Method|VRMSE<br>[m/sec]|ANUKF<br>Imprv.|MRMSE<br>[rad]|ANUKF<br>Imprv.|
|---|---|---|---|---|
|**UKF**<br>**ANEKF**<br>**ANUKF**|0.1172<br>0.1004<br>0.0922|21.3%<br>8.2%<br>N/A|0.0112<br>0.0156<br>0.0106|5.4%<br>32.1%<br>N/A|



TABLE I: VRMSE and MRMSE of the UKF, ANEKF, and ANUKF applied to the testing dataset. 

To this end, no DVL updates were provided to the filter for 20 seconds starting after 180 seconds from starting time. We waited 180 seconds to ensure filter convergence to steady-state. Table II summarizes the VRMSE and MRMSE results of the averaging of the ANUKF and the ANEKF filters on tracks 5 and 6. The ANUKF velocity solution and misalignment estimation were significantly better than those of the ANEKF, providing a 46 _._ 7% improvement in the VRMSE and 31 _._ 1% in the MRMSE metric. Figure (5) shows the standard deviation 

|Method|VRMSE<br>[m/sec]|ANUKF<br>Imprv.|MRMSE<br>[rad]|ANUKF<br>Imprv.|
|---|---|---|---|---|
|**ANEKF**<br>**ANUKF**|0.222<br>0.1183|46.7%<br>N/A|0.0156<br>0.0106|32.1%<br>N/A|



TABLE II: VRMSE and MRMSE of the UKF, ANEKF, and ANUKF applied to the testing dataset. DVL outage was enforced for 20 seconds during the trajectories. 

of the MC 100 runs in total velocity errors averaged on tracks 5 and 6 while the DLV was not available between 180-200 seconds. ANEKF developed significantly more severe errors than ANUKF. 

**==> picture [122 x 63] intentionally omitted <==**

**==> picture [122 x 63] intentionally omitted <==**

**==> picture [222 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Velocity error track 5 (b) Velocity error track6<br>**----- End of picture text -----**<br>


Fig. 5: MC velocity errors on tracks 5 and 6. 

## V. CONCLUSION 

Varying dynamics and environmental changes require adjustment of the nonlinear modeling of the process noise covariance matrix. To cope with this task, we proposed the adaptive neural UKF. Our end-to-end regression network, ProcessNet, can adaptively estimate the uncertainty reflected in the process noise covariance based only on inertial sensor readings. Two ProcessNet networks with the same structure that differ in their input/output are run in parallel: one for the accelerometer, the other for the gyroscope readings. 

To demonstrate the performance of our approach, we focused on the INS/DVL fusion problem for a maneuvering AUV. We evaluated our approach compared to the model-based UKF and neural adaptive EKF using a real-world recorded AUV dataset. On the test dataset, we examined the improvement in estimating the AUV velocity vector concerning the VRMSE and the AUV misalignment concerning the MRMSE. In the 

VRMSE metric, ANUKF improved by 21 _._ 3% over UKF and 8 _._ 2% over ANEKF. In the MRMSE metric, ANUKF improved by 5 _._ 4% over UKF and 32 _._ 1% over ANEKF. We further examined the robustness of ANUKF in situations of DVL outages that often occur in real-world scenarios. We showed that ANUKF VRMSE and MRMSE are considerably better than ANEKF, providing a 46 _._ 7% improvement in the VRMSE metric and 31 _._ 1% in the MRMSE metric. In conclusion, ANUKF offers an accurate navigation solution in normal operating conditions of INS/DVL fusion and demonstrates robustness in scenarios of DVL outages. Thus, it allows planning and operating in challenging AUV tasks, including varying dynamics and environmental changes. Considering the high cost of navigation-grade inertial sensors, our novel approach may enable the use of tactical-grade IMU on AUV with the possibility of INS/DVL fusion for other marine robotic systems. 

## REFERENCES 

- [1] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with applications to tracking and navigation: Theory algorithms and software._ John Wiley & Sons, 2004. 

- [2] E. A. Wan and R. V. D. Merwe, “The unscented Kalman filter for nonlinear estimation,” _Proceedings of the IEEE 2000 Adaptive Systems for Signal Processing, Communications, and Control Symposium_ , pp. 153–158, 2000. 

- [3] S. J. Julier and J. K. Uhlmann, “A New Extension of the Kalman Filter to Nonlinear Systems,” _Signal Processing, Sensor Fusion, and Target Recognition VI_ , vol. Proc. SPIE 3068, 1997. 

- [4] A. Almagbile, J. Wang, and W. Ding, “Evaluating the Performances of Adaptive Kalman Filter Methods in GPS/INS Integration,” _Journal of Global Positioning Systems_ , vol. 9, pp. 33–40, 2010. 

- [5] B. Zheng, P. Fu, B. Li, and X. Yuan, “A robust adaptive unscented Kalman filter for nonlinear estimation with uncertain noise covariance,” _IEEE Sensors Journal_ , vol. 18, no. 3, p. 808, 2018. 

- [6] X.Chen, S.Wu, X.Zhang, X.Mu, T.Yan, and B.He, “Neural Network Assisted Adaptive Unscented Kalman Filter for AUV,” _Global Oceans_ , pp. 1–4, 2020. 

- [7] D. Jwo and F. Chung, “Fuzzy adaptive unscented Kalman filter for ultra-tight gps/ins integration,” vol. 2, p. 229–235, 2010. 

- [8] Y. Meng, S. Gao, Y. Zhong, G. Hu, and A. Subic, “Covariance matching based adaptive unscented Kalman filter for direct filtering in INS/GNSS integration,” _Acta Astronautica_ , vol. 120, p. 171–181, 2016. 

- [9] N. Cohen and I. Klein, “Inertial Navigation Meets Deep Learning: A Survey of Current Trends and Future Directions,” _Results in Engineering_ , p. 103565, 2024. 

- [10] C. Chen and X. Pan, “Deep Learning for Inertial Positioning: A Survey,” _IEEE Transactions on Intelligent Transportation Systems_ , vol. 25, no. 9, pp. 10 506– 10 523, 2024. 

- [11] B. Yang, X. Jia, and F. Yang, “Variational Bayesian adaptive unscented Kalman filter for RSSI-based indoor 

8 

   - localization,” _Int. J. Control, Autom. Syst._ , vol. 19, no. 3, p. 1183–1193, 2021. 

- [12] Z. Xue, Y. Zhang, C. Cheng, and G. Ma, “Remaining useful life prediction of lithium-ion batteries with adaptive unscented Kalman filter and optimized support vector regression,” _Neurocomputing_ , vol. 376, pp. 95–102, 2020. 

- [13] Y. Fang, A. Panah, J. Masoudi, B. Barzegar, and S. Fathehi, “Adaptive Unscented Kalman Filter for Robot Navigation Problem (Adaptive Unscented Kalman Filter Using Incorporating Intuitionistic Fuzzy Logic for Concurrent Localization and Mapping),” _IEEE Access_ , vol. 10, pp. 101 869–101 879, 2022. 

- [14] B. Or and I. Klein, “A Hybrid Model and LearningBased Adaptive Navigation Filter,” _IEEE Transactions on Instrumentation and Measurement_ , vol. 71, pp. 1–11, 2022. 

- [15] D. Solodar and I. Klein, “Visual-Inertial Odometry with Learning Based Process Noise Covariance,” _Engineering Applications of Artificial Intelligence_ , vol. 133, p. 108466, 2024. 

- [16] N. Cohen and I. Klein, “Adaptive Kalman-Informed Transformer,” _Engineering Applications of Artificial Intelligence_ , vol. 146, p. 110221, 2025. 

- [17] P. D. Groves, _Principles of GNSS, inertial, and multisensor integrated navigation systems_ . Cambridge University Press, 2015, vol. 10. 

- [18] N. Cohen and I. Klein, “Seamless Underwater Navigation with Limited Doppler Velocity Log measurements,” _IEEE Transactions on Intelligent Vehicles_ , pp. 1–12, 2024. 

- [19] iXblue, “Phins subsea,” https://www.ixblue.com/store/ phins-subsea/, accessed: October 2024. 

- [20] T. Marine, “Doppler velocity logs,” https: //www.teledynemarine.com/products/product-line/ navigation-positioning/doppler-velocity-logs, accessed: October 2024. 

