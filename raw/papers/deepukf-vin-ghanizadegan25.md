---
title: "Personal use of this material is permitted. Permission from the author(s) and/or copyright holder(s), must be obtained for all other uses. Please contact us and provide details if you believe this document breaches copyrights."
arxiv: "2502.0057"
authors: ["Khashayar Ghanizadegan", "Hashim A. Hashim"]
year: 2025
source: paper
ingested: 2026-05-06
sha256: 711ac10907268c4fa5116ff25129479f03e8daf0c602e9f976f11080b5b560bf
conversion: pymupdf4llm
---

Personal use of this material is permitted. Permission from the author(s) and/or copyright holder(s), must be obtained for all other uses. Please contact us and provide details if you believe this document breaches copyrights. 

# DeepUKF-VIN: Adaptively-tuned Deep Unscented Kalman Filter for 3D Visual-Inertial Navigation based on IMU-Vision-Net 

Khashayar Ghanizadegan and Hashim A. Hashim 

_**Abstract**_ **—This paper addresses the challenge of estimating the orientation, position, and velocity of a vehicle operating in three-dimensional (3D) space with six degrees of freedom (6DoF). A Deep Learning-based Adaptation Mechanism (DLAM) is proposed to adaptively tune the noise covariance matrices of Kalman-type filters for the Visual-Inertial Navigation (VIN) problem, leveraging IMU-Vision-Net. Subsequently, an adaptively tuned Deep Learning Unscented Kalman Filter for 3D VIN (DeepUKF-VIN) is introduced to utilize the proposed DLAM, thereby robustly estimating key navigation components, including orientation, position, and linear velocity. The proposed DeepUKFVIN integrates data from onboard sensors, specifically an inertial measurement unit (IMU) and visual feature points extracted from a camera, and is applicable for GPS-denied navigation. Its quaternion-based design effectively captures navigation nonlinearities and avoids the singularities commonly encountered with Euler-angle-based filters. Implemented in discrete space, the DeepUKF-VIN facilitates practical filter deployment. The filter’s performance is evaluated using real-world data collected from an IMU and a stereo camera at low sampling rates. The results demonstrate filter stability and rapid attenuation of estimation errors, highlighting its high estimation accuracy. Furthermore, comparative testing against the standard Unscented Kalman Filter (UKF) in two scenarios consistently shows superior performance across all navigation components, thereby validating the efficacy and robustness of the proposed DeepUKF-VIN.** 

_**Index Terms**_ **—Deep Learning, Unscented Kalman Filter, Adaptive tuning, Estimation, Navigation, Unmanned Aerial Vehicle, Sensor-fusion.** 

For video of navigation experiment visit: link 

## I. INTRODUCTION 

## _A. Motivation_ 

AVIGATION is a fundamental component in the success- **N** ful operation of a wide array of applications, spanning fields such as robotics, aerospace, and mobile technology. At its core, navigation involves estimating an object’s position, orientation, and velocity, a task that becomes particularly critical and challenging in environments where Global Navigation Satellite Systems (GNSS), like GPS, BeiDou, and GLONASS, are unavailable (e.g., indoor environments) or unreliable (e.g., urban settings with obstructed satellite signals due to tall 

This work was supported in part by National Sciences and Engineering Research Council of Canada (NSERC), under the grants RGPIN-2022-04937 and DGECR-2022-00103. 

K. Ghanizadegan and H. A. Hashim are with the Department of Mechanical and Aerospace Engineering, Carleton University, Ottawa, Ontario, K1S-5B6, Canada (e-mail: hhashim@carleton.ca). 

buildings) [1], [2]. Similar challenges are encountered in underwater navigation, where robots must operate in deep, GNSS-denied environments [3]. Unmanned ground vehicles (UGVs) and unmanned aerial vehicles (UAVs) have shown immense potential in various sectors. For example, UGVs and UAVs are increasingly used in care facilities to assist with monitoring and delivery tasks [4], in logistical services for autonomous package delivery [5], and in surveillance of hardto-access locations [1]. These include monitoring forests for early fire detection [6], tracking icebergs in the Arctic [7], and conducting surveys in other remote areas. The effectiveness of these applications hinges on the precision and reliability of their navigation systems. In the realm of mobile technology, accurate navigation is essential for enhancing user experiences, particularly in smartphone applications that rely on real-time positional data, such as augmented reality (AR) platforms and wayfinding tools [8]. Similarly, in aerospace applications, obtaining precise positional and orientation data is vital for the accurate analysis and interpretation of observational information [9], [10]. 

## _B. Related Work_ 

One of the primary approaches to addressing the challenge of navigation in GPS-denied environments involves utilizing ego-acceleration measurements from onboard accelerometers to estimate a vehicle’s pose relative to its previous position. This technique, known as Dead Reckoning (DR), integrates acceleration data to derive positional information [1]. DR offers a straightforward, cost-effective solution, particularly with low-cost sensors, making it accessible for many applications [11]. To enhance the accuracy of Dead Reckoning, a gyroscope is often incorporated to measure the vehicle’s angular velocity. This integration provides additional orientation data, improving the overall pose estimation. However, a significant drawback of this method is its susceptibility to cumulative errors or drift over time. Without supplementary sensors or correction mechanisms, these errors can accumulate rapidly, leading to inaccurate navigation results, especially during prolonged use. In controlled environments like harbors, warehouses, or other predefined spaces, ultra-wideband (UWB) technology can significantly enhance navigation accuracy. UWB systems measure distances between the vehicle and fixed reference points, known as anchors, providing highly accurate and robust localization data [12]. This approach is widely adopted in applications where precision is paramount, such as robotic 

**K. Ghanizadegan and H. A. Hashim, ”DeepUKF-VIN: Adaptively-tuned Deep Unscented Kalman Filter for 3D Visual-Inertial Navigation based on IMU-Vision-Net,” Expert Systems With Applications, vol. 271, pp. 126656, 2025.** doi: 10.1016/j.eswa.2025.126656 

2 

operations within structured environments and object-tracking systems like Apple’s AirTag [13]. When used alongside an Inertial Measurement Unit (IMU), accelerometer, and gyroscope within a DR framework, UWB can serve as an additional sensor to correct positional errors and mitigate drift [12]. However, this solution has limitations since UWB requires the installation of anchors in the environment, which confines its applicability to pre-configured spaces. As a result, it may not be suitable for dynamic or unstructured environments, reducing the system’s flexibility and immediate usability out of the box [14]. Additionally, UWB is susceptible to high levels of noise, which can degrade estimation accuracy [12]. 

With the development of advanced point cloud registration algorithms such as Iterative Closest Point (ICP) [15] and Coherent Point Drift (CPD) [16], sensors capable of capturing two-dimensional (2D) points from three-dimensional (3D) space have emerged as promising candidates to complement IMUs without requiring prior environmental knowledge. Sound Navigation and Ranging (SONAR) is one such sensor, widely adopted in marine applications due to its effectiveness in underwater environments, where mechanical waves propagate efficiently [17]. Similarly, Light Detection and Ranging (LiDAR) employs electromagnetic waves instead of mechanical waves and has demonstrated utility in aerospace applications, where sound propagation is limited, but light transmission is effective [18]. However, both SONAR and LiDAR exhibit significant limitations in complex indoor and outdoor environments, as they rely solely on structural properties and cannot capture texture or color information. In contrast, recent advancements in low-cost, high-resolution cameras designed for navigation applications, combined with robust fusion between IMU and feature detection [2], [19]. Popular tracking feature detection-based algorithms include Scale-Invariant Feature Transform (SIFT) [20], Good Features to Track (GFTT) [21], and the Kanade-Lucas-Tomasi (KLT) algorithm have facilitated the widespread adoption of cameras as correction sensors alongside IMUs [1], [22]–[24]. 

## _C. Persistent Challenges and Potentials_ 

To integrate the aforementioned sensor data, Kalman-type filters are widely employed in navigation due to their stochastic framework and ability to handle noisy measurements [25]– [28]. The Kalman Filter (KF) provides a maximum likelihood estimate of the system’s state vector based on available measurement data; however, it operates optimally only within linear systems. To overcome this limitation, the Extended Kalman Filter (EKF) was developed. The EKF linearizes the system around the current estimated state vector and applies the KF framework to this linearized model. Its intuitive structure, ease of implementation, and computational efficiency have established the EKF as a standard choice for navigation applications [16], [23], [29]. However, the EKF’s performance degrades with increasing system nonlinearity. To address the EKF’s limitations, the Unscented Kalman Filter (UKF) was introduced. The UKF effectively captures the propagation of mean and covariance through a nonlinear transformation up to the second order, offering improved accuracy while 

maintaining comparable computational complexity to the EKF [26], [30]. Nevertheless, Kalman-type filters rely on accurate modeling of system and measurement noise. While it is standard to assume these noise components are zero-mean, their covariance matrices serve as critical tuning parameters, and the performance of these filters is sensitive to inaccuracies in their specification [31]. In practice, determining the values of covariance matrices is challenging and typically involves an iterative process of trial and error, which can be both timeconsuming and effort-intensive. 

Deep learning techniques have shown significant promise in adaptively tuning the covariance matrices of Kalman-based filters, addressing a critical challenge in achieving accurate state estimation [32]–[35]. These methods offer an efficient alternative to traditional manual tuning, leveraging data-driven models to dynamically estimate noise parameters based on observed system behavior. For instance, Brossard et al. [32] utilized Convolutional Neural Networks (CNNs) to predict measurement noise parameters for the DR of ground vehicles using an Invariant EKF (IEKF). This approach improved noise estimation by learning from raw sensor data, enhancing overall navigation accuracy. Similarly, Or et al. [34] applied deep learning to model trajectory uncertainty by extracting features such as vehicle speed and path curvature demonstrating the potential to enhance state predictions by accurately capturing the system’s dynamic characteristics. Furthermore, Yan et al. [35] proposed a multi-level framework where the state vector estimates and covariance predictions from traditional filters serve as inputs to deep learning architectures. Therefore, deep learning can be employed to iteratively refine the covariance estimates, improving robustness in complex scenarios allowing Kalman-based filters to dynamically adjust varying noise conditions, reducing dependency on intensive manual tuning and significantly improving performance in real-world applications. 

## _D. Contributions_ 

Motivated by the above discussion, the key contributions of this work are as follows: (1) The proposed approach employs singularity-free quaternion dynamics to represent ego orientation, ensuring robust handling of orientation estimation and avoiding singularities typically encountered with Euler-angle-based representations. (2) A quaternion-based, adaptively-tuned Deep Learning Unscented Kalman Filter for 3D Visual-Inertial Navigation (DeepUKF-VIN) based on Deep Learning-based Adaptation Mechanism (DLAM) is formulated in discrete form. This approach accurately models the true navigation kinematics, simplifies the implementation process, and dynamically estimates the covariance matrices, thereby enhancing the overall performance of Kalman-type filters. (3) A novel deep learning-based adaptation mechanism is introduced to dynamically estimate the covariance matrices associated with the measurement noise vectors in the UKF. This adaptive approach enhances the filter’s estimation performance by reducing dependency on manual tuning. (4) The proposed DeepUKF-VIN demonstrates superior performance compared to the standard UKF across various scenarios. DeepUKF-VIN 

3 

TABLE I: Nomenclature 

|_{B}_ / _{W}_|:|Fixed body-frame / fxed world-frame|
|---|---|---|
|SO(3)<br>S3|:<br>:|Special Orthogonal Group of order 3<br>Three-unit-sphere|
|_qk,_ˆ_qk_|:|True and estimated quaternion at step _k_|
|_pk,_ˆ_pk_|:|True and estimated position at step _k_|
|_vk,_ˆ_vk_|:|True and estimated linear velocity at step _k_|
|_re,k_, _pe,k_, _ve,k_|:|Attitude, position, and velocity estimation error|
|_ak, am,k_<br>_ωk, ωm,k_<br>_ηω,k, ηa,k_<br>_bω,k, ba,k_|:<br>:<br>:<br>:|True and measured acceleration at step _k_<br>True and measured angular velocity at step _k_<br>Angular velocity and acceleration measurements<br>noise<br>Angular velocity and acceleration measurements|
|_C×_<br>_lb,k, lb,w_<br>_xk_, _xa_<br>_k_, _uk_|:<br>:<br>:|bias<br>Covariance matrix of _n×_.<br>landmark coordinates in _{B}_ and _{W}_.<br>The state, augmented state, and input vectors at<br>the _k_th time step|
|ˆ_zk, zk_<br>_{χi|j}ν_,<br>_{χa_<br>_i|j}ν_,<br>_{ζi|j}ν_|:<br>:|Predicted and true measurement<br>Sigma points of state, augmented state, and<br>measurements|



effectiveness is validated using real-world data collected from low-cost sensors operating at low sampling rates. To the best of the authors’ knowledge, no deep learning-enhanced Kalmantype filter based on inertial measurement and vision units has been proposed for VIN. 

## _E. Structure_ 

The structure of the paper is organized as follows: Section II introduces the preliminary concepts and mathematical foundations. Section III defines the nonlinear navigation kinematics problem. Section IV presents the quaternion-based UKF framework tailored for navigation kinematics. Section V provides a detailed description of the deep learning architecture for adaptive tuning. Section VI outlines the training process and implementation methodology of the proposed DeepUKFVIN. Section VII evaluates the performance of the DeepUKFVIN algorithm using a real-world dataset. Finally, Section VIII offers concluding remarks. 

## II. PRELIMINARIES 

_Notation:_ In this paper, the set of _d_ 1-by- _d_ 2 matrices of real numbers is denoted by R _[d]_[1] _[×][d]_[2] . A vector _v ∈_ R _[d]_ is said to lie on the _d_ -dimensional sphere S _[d][−]_[1] _⊂_ R _[d]_ when its norm, denoted as _∥m∥_ = _√m[⊤] m ∈_ R, is equal to one. The identity matrix of dimension _d_ is denoted by **I** _d ∈_ R _[d][×][d]_ . The world frame _{W}_ and the body frame _{B}_ refer to the coordinate systems attached to the Earth and the vehicle, respectively. Table I lists a summary of notations heavily used in this paper. 

## _A. Preliminary_ 

The matrix _R ∈_ R[3] _[×]_[3] represents the vehicle’s orientation, provided it belongs to the Special Orthogonal Group of order 3, denoted SO(3), which is defined by: 

**==> picture [205 x 14] intentionally omitted <==**

**==> picture [253 x 161] intentionally omitted <==**

The orientation resulting from two subsequent rotations _q_ 1 = [ _qw_ 1 _, qv_ 1] _[⊤] ∈_ S[3] and _q_ 2 = [ _qw_ 2 _, qv_ 2] _[⊤] ∈_ S[3] is defined through quaternion multiplication, denoted by the _⊗_ operator [36]: 

**==> picture [214 x 38] intentionally omitted <==**

The orientation identical in terms of unit quaternion is _qI_ = [1 _,_ 0 _,_ 0 _,_ 0] _[⊤]_ . For _q_ = [ _qw, qv[⊤]_[]] _[⊤][∈]_[S][3][,][the][inverse][of] _[q]_[is][given] by _q[−]_[1] = [ _qw, −qv[⊤]_[]] _[⊤][∈]_[S][3][.][It][is][worth][noting][that] _[q][ ⊗][q][−]_[1][=] _qI_ . For _m ∈_ R[3] , the skew-symmetric matrix [ _m_ ] _×_ is defined as: 

**==> picture [249 x 37] intentionally omitted <==**

The mapping from quaternion _q_ = [ _qw, qv[⊤]_[]] _[⊤][∈]_[S][3][to][rotation] matrix _Rq ∈_ SO(3) is defined by [36]: 

**==> picture [221 x 12] intentionally omitted <==**

The inverse of the skew-symmetric matrix functionis given by: 

**==> picture [172 x 12] intentionally omitted <==**

Let _Pa_ ( _·_ ) : R[3] _[×]_[3] _→_ so(3) be anti-symmetric projection operator where 

**==> picture [227 x 21] intentionally omitted <==**

The orientation of a rigid body can also be represented by a rotation angle _θ ∈_ R around a unit vector _u ∈_ S[2] _⊂_ R[3] with S[2] := _{ u ∈_ R[3][��] _||u||_ = 1 _}_ . Angle-axis parametrization is obtained from the rotation matrix _R ∈_ SO(3), where [36]: 

**==> picture [213 x 50] intentionally omitted <==**

4 

with Tr( _·_ ) denoting the trace function. Let the rotation vector _r_ be described via the angle-axis parametrization as follows: 

**==> picture [218 x 12] intentionally omitted <==**

The rotation matrix associated with a rotation vector is given by [36]: 

**==> picture [185 x 11] intentionally omitted <==**

The mapping from rotation vector representation to quaternion representation is found by utilizing (1), (6), and (7) such that _qr_ : R[3] _→_ S[3] : 

**==> picture [179 x 12] intentionally omitted <==**

The rotation vector corresponding to a rotation represented by a quaternion is found in light of (3), (6), and (7) by _rq_ : S[3] _→_ R[3] such that 

**==> picture [206 x 11] intentionally omitted <==**

To facilitate addition ⊞ and subtraction ⊟ between a rotation vector _r ∈_ R[3] and a quaternion _q ∈_ S[3] , using the definitions in (4), (7), and (9), the following operations are defined: 

**==> picture [182 x 27] intentionally omitted <==**

In light of (3), the subtraction of two quaternions _q_ 1 _, q_ 2 _∈_ S[3] is given by: 

**==> picture [189 x 13] intentionally omitted <==**

Consider a set of quaternions _Q_ = _{qi ∈_ S[3] _}_ and their corresponding weights _W_ = _{wi ∈_ R _}_ . To compute the weighted average of these quaternions, the matrix _E_ is first constructed as: 

**==> picture [102 x 15] intentionally omitted <==**

Next, the quaternion weighted mean QWM( _Q, W_ ) is the eigenvector corresponding to the largest magnitude eigenvalue of _E_ such that: 

**==> picture [202 x 12] intentionally omitted <==**

where _i_ = argmax( _|_ EigValue( _E_ ) _i|_ ) _∈_ R. A _d_ -dimensional random variable (RV) _h ∈_ R _[d]_ drawn from a Gaussian distribution with a mean _h ∈_ R _[d]_ and a covariance matrix _Ch ∈_ R _[d][×][d]_ is represented by the following: 

## III. PROBLEM FORMULATION 

In this section, the kinetic and measurement models are introduced. After defining the state vector, a state transition function is established to define the relation between navigation state and the input data. Moreover, the interdependence between the state and measurements vector is formulated, which is essential for the proposed DeepUKF-VIN performance. 

## _A. Navigation Model in 3D_ 

The true navigation kinematics of a vehicle travelling in 3D space are represented by [2], [19]: 

**==> picture [193 x 89] intentionally omitted <==**

with 

where _q_ describe vehicle’s orientation with respect to quaternion, _ω ∈_ R[3] and _a ∈_ R[3] denote angular velocity and acceleration, respectively, while _p ∈_ R[3] and _v ∈_ R[3] refer to vehicle’s position and linear velocity, respectively, with _q, ω, a ∈{B}_ and _p, v ∈{W}_ . In light of [2], the kinematics in (15) is equivalent to: 

**==> picture [244 x 64] intentionally omitted <==**

Since the onboard data processor operating in discrete space and the sensor data are updated at discrete instances, the continuous kinematics in (16) need to be discretized. The true discrete value at the _k_ th time-step of _q ∈_ S[3] , _ω ∈_ R[3] , _a ∈_ R[3] , _p ∈_ R[3] , and _v ∈_ R[3] is defined by _qk ∈_ S[3] , _ωk ∈_ R[3] , _ak ∈_ R[3] _pk ∈_ R[3] , and _vk ∈_ R[3] , respectively. The equivalent discretized kinematics of the expression in (16) is [2] 

**==> picture [203 x 49] intentionally omitted <==**

where _Mk[c] −_ 1[=] _[M][ c]_[(] _[q][k][−]_[1] _[, ω][k][−]_[1] _[, a][k][−]_[1][)][and] _[dT]_[denote][a] sample time. 

**==> picture [59 x 11] intentionally omitted <==**

Note that the expected value of _h_ , denoted by E( _h_ ), is equal to _h_ . The Gaussian (Normal) probability density function of _h_ is formulated below: 

**==> picture [183 x 42] intentionally omitted <==**

where P( _h_ ) is the probability density of _h_ . 

## _B. Measurement Model and Setup_ 

The IMU measurements at time step _k_ (angular velocity _ωm,k ∈_ R[3] and acceleration _am,k ∈_ R[3] ) and the related bias in readings ( _bω,k_ and _ba,k_ ) are as follows [27], [28]: 

**==> picture [203 x 60] intentionally omitted <==**

5 

where _dz,k_ = 3 _dl,k_ represents the dimension of the measurement vector _zk_ = _lb, k_ . The _i_ th measurement function hi : R _[d][x] ×_ R[3] _→_ R[3] is defined as: 

where _ηω,k_ and _ηa,k_ refer to gyroscope and accelerometer additive zero-mean white noise, respectively, while the zeromean white noise terms _ηba,k−_ 1, and _ηbω,k−_ 1 _∈_ R[3] correspond to _ba,k_ and _bω,k ∈_ R[3] . In other words 

**==> picture [209 x 14] intentionally omitted <==**

**==> picture [441 x 57] intentionally omitted <==**

**==> picture [244 x 30] intentionally omitted <==**

Note that if the noise vectors in (19) are assumed to be uncorrelated, their covariance matrices will be diagonal with positive entries, such that [27], [28]: 

The measurement function in (26) is used to find the measurement vector _zk_ at each time step _k_ such that 

**==> picture [188 x 12] intentionally omitted <==**

**==> picture [180 x 57] intentionally omitted <==**

where _ηl,k ∼N_ (0 _dz,k , Cηl,k_ ) is the measurement additive white noise. The covariance matrix _Cηl,k ∈_ R _[d][z,k][×][d][z,k]_ is defined by: 

**==> picture [163 x 14] intentionally omitted <==**

where _cηω,k_ , _cηa,k_ , _cηbω,k_ , and _cηba,k ∈_ R[3] represent the square roots of the diagonal elements of their respective covariance matrices. Let us define the state vector _xk ∈_ R _[d][x]_ and the augmented state vector _x[a] k[∈]_[R] _[d][a]_[such][that] 

where _cηl,k ∈_ R is a scalar. This definition is particularly useful since _dz,k_ may vary at each time step _k_ . 

## IV. QUATERNION-BASED UKF-VIN 

**==> picture [232 x 47] intentionally omitted <==**

This section provides a detailed description of the quaternion-based Unscented Kalman Filter for 3D VisualInertial Navigation (UKF-VIN) design which will be subsequently tightly-coupled with the proposed Deep Learningbased Adaptation Mechanism (DLAM) for adaptive tuning of UKF-VIN covariance matrices. The proposed approach builds upon the standard UKF [26], incorporating specific modifications to address challenges inherent in navigation tasks. These adaptations ensure the UKF operates effectively within the quaternion space S[3] , preserving the physical validity of orientation estimation. Furthermore, the design accommodates the intermittent nature of vision data, which is not available at every time step, while consistently integrating IMU data. 

with _dx_ = 16 and _da_ = 22 representing the dimensions of the state vector and the augmented state vector, respectively, and _ηx,k_ representing the augmented noise vector, such that 

**==> picture [188 x 16] intentionally omitted <==**

where _dηx_ = 6 is the dimension of the augmented noise. Consider formulating the additive noise vector such that: 

**==> picture [203 x 16] intentionally omitted <==**

Then, the expression in (17), using (18), (21), (22), and (23) can be written in form of state transition function f : R _[d][a] →_ R _[d][x]_ such that 

## _A. Initialization_ 

he filter is initialized with the initial state vector estimate _x_ ˆ0 _|_ 0 _∈_ R _[d][x]_ , and its associated covariance estimate _P_ 0 _|_ 0 _∈_ R[(] _[d][x][−]_[1)] _[×]_[(] _[d][x][−]_[1)] which represents the confidence in the initial state estimate. The reduced dimensionality of the covariance matrix arises from the fact that the quaternion in the state vector has three degrees of freedom, despite having four components [23]. 

**==> picture [188 x 11] intentionally omitted <==**

with the input vector being defined as _uk−_ 1 = [ _ωm,k[⊤] −_ 1 _[, a][⊤] m,k−_ 1[]] _[⊤][∈]_[R] _[d][u]_[and] _[d][u]_[=][6][being][the][dimension] of the input vector. Let the landmark coordinates in _{W}_ be represented as _{lw,k,i ∈_ R[3] _}i_ , where these coordinates are either known from prior information or obtained from a series of stereo camera measurements. Similarly, let the corresponding coordinates measured by the latest stereo camera data in _{B}_ be denoted as _{lb,k,i ∈_ R[3] _}i_ , where _i_ = _{_ 1 _, . . . , dl,k}_ represents the index of each measured landmark, and _dl,k ∈_ R denotes the number of landmarks at each measurement step. Note that _dl,k_ is not constant and may change at each step. We then construct the concatenated vectors _lw,k ∈_ R _[d][z,k]_ , and _lb,k ∈_ R _[d][z,k]_ such that: 

## _B. Aggregate Predict_ 

At each time step _k_ where image data is available, the current state vector is predicted using the last _db_ input vectors _uk−_ 1 _−db_ : _k−_ 1 _∈_ R _[d][b][×][d][u]_ , along with the previous state vector estimate _x_ ˆ _k−_ 1 _−db|k−_ 1 _∈_ R _[d][x]_ and the covariance matrix _Pk−_ 1 _−db|k−_ 1 _∈_ R[(] _[d][x][−]_[1)] _[×]_[(] _[d][x][−]_[1)] , the current state vector is predicted. Here _db_ represents the number of measurements received from the IMU between the current and the last instance when image data was available. For each _j_ = _{k−_ 1 _− db, . . . , k −_ 1 _}_ , the following steps are executed sequentially. 

**==> picture [172 x 42] intentionally omitted <==**

6 

_1) Augmentation:_ The augmented state vector _x[a] j[∈]_[R] _[d][a]_[,] and the augmented covariance matrix _Pj[a] |j[∈]_[R][(] _[d][a][−]_[1)] _[|]_[(] _[d][a][−]_[1)] are constructed as follows: 

**==> picture [231 x 38] intentionally omitted <==**

where _Cηx,k_ = diag( _Cηw,k , Cηa,k_ ) _∈_ R _[η][x]_ is the covariance matrix of _ηx,k_ as defined in (22). 

_2) Sigma Points Construction:_ Using the augmented estimate of the state vector and its covariance, while accounting for the reduced dimensionality of the quaternions and applying the unscented transform [26], the sigma points representing the prior distribution are computed as follows: 

**==> picture [250 x 55] intentionally omitted <==**

where _δx_ ˆ _[a] j,ν_[=] ��( _da −_ 1 + _λ_ ) _Pj[a] |j_ � _ν[∈]_[R] _[m][a][−]_[1][,][with][the] subscript _ν_ representing the _ν_ th column. The operators ⊞ and ⊟ in (31) are defined in accordance with (11) and (12), such that 

**==> picture [208 x 64] intentionally omitted <==**

where _x_ ˆ _[a] j|j,q[∈]_[S][3][ and] _[x]_[ˆ] _[a] j|j,−[∈]_[R] _[d][a][−]_[4][ represent the quaternion] and non-quaternion components _x_ ˆ _[a] j|j[∈]_[R] _[d][a]_[,][respectively,] and _δx_ ˆ _[a] j,ν,r[∈]_[R][3][and] _[δ][x]_[ˆ] _[a] j,ν,−[∈]_[R] _[d][a][−]_[4][denote][the][rotation] vector and non-rotation vector components of _δx_ ˆ _[a] j,ν[∈]_[R] _[d][a][−]_[1][,] respectively. Note that _λ ∈_ R is a tuning parameter that controls the spread of the sigma points. 

_3) Sigma Points Propagation:_ In this step, the sigma points defined in (31) are propagated through the state transition function (24) to obtain the predicted sigma points _{χj_ +1 _|j,ν}ν_ such that 

**==> picture [246 x 24] intentionally omitted <==**

_4) Calculate the Predicted Mean and Covariance:_ The weighted mean _x_ ˆ _j_ +1 _|j ∈_ R _[d][x]_ and covariance _Pj_ +1 _|j ∈_ R[(] _[d][x][−]_[1)] _[×]_[(] _[d][x][−]_[1)] of the predicted sigma points _{χj_ +1 _|j,ν}ν_ are determined in this step in accordance with (14). These quantities are calculated as follows: 

**==> picture [236 x 43] intentionally omitted <==**

**==> picture [257 x 47] intentionally omitted <==**

with _χj_ +1 _|j,ν,q ∈_ S[3] and _χj_ +1 _|j,ν,− ∈_ R _[d][x][−]_[4] representing the quaternion and non-quaternion components of _χj_ +1 _|j,ν ∈_ R _[d][x]_ , respectively. Note that in (35), the quaternion weighted average (14) is used for quaternion components of the propagated sigma point vectors and the straightforward weighted average for non-orientation components of the propagated sigma point vector. The weights _{wν[m][}][ν]_[and] _[{][w] ν[c][}][ν]_[in][(][35][)][and][(][36][)][are] derived from: 

**==> picture [253 x 117] intentionally omitted <==**

**==> picture [246 x 24] intentionally omitted <==**

where _x_ ˆ _j_ +1 _|j,q ∈_ S[3] , and _x_ ˆ _j_ +1 _|j,− ∈_ R _[d][x][−]_[4] represent the quaternion and non-quaternion components of _x_ ˆ _j_ +1 _|j ∈_ R _[d][x]_ , respectively. Note that _Cηw,k_ = diag(0 _dx−_ 7 _, Cηw,k , Cηa,k_ ) _∈_ R[(] _[d][x][−]_[1)] _[×]_[(] _[d][x][−]_[1)] denotes the covariance matrix of _ηw,k_ as defined in (23). 

_5) Iterate over batch:_ If _j_ = _k−_ 1, corresponding to the end of the batch, the predicted state estimate ˆ _xk|k−_ 1, the covariance _Pk|k−_ 1, and the predicted sigma points _{χj_ +1 _|j,ν}ν_ , as defined in (35), (36), and (34), respectively, are passed to the update step (see Section IV-C). Otherwise, _x_ ˆ _j_ +1 _|j_ +1 and _Pj_ +1 _|j_ +1 are set to _x_ ˆ _j_ +1 _|j_ and _Pj_ +1 _|j_ , respectively. The aggregate prediction algorithm then increments _j ← j_ +1 and continues by returning to Section IV-B1. 

## _C. Update_ 

_1) Calculate Measurement Sigma Points And Its Statistics:_ At time step _k_ , the predicted sigma points _{χj_ +1 _|j,ν}ν_ are passed through the measurement function (26) to calculate the measurement sigma points � _ζk,ν ∈_ R _[d][z,k]_[�] _ν_[such][that] 

**==> picture [190 x 13] intentionally omitted <==**

Considering (27) and (37), the expected value and covariance of _{ζk,ν}ν_ , denoted by _z_ ˆ _k ∈_ R _[d][z,k]_ and _Pzk ∈_ R _[d][z,k][×][d][z,k]_ , respectively, are determined as follows: 

**==> picture [209 x 82] intentionally omitted <==**

Using (37), (38), and (40), the cross covariance matrix _Pxk,zk ∈_ R[(] _[d][x][−]_[1)] _[×][d][z,k]_ is calculated by 

**==> picture [241 x 32] intentionally omitted <==**

7 

Note that the operator ⊟ in (42) is defined in (38). 

_2) Calculate The Current State Estimate:_ First, the Kalman gain _Kk ∈_ R[(] _[d][x][−]_[1)] _[×][d][z,k]_ , based on (42) and (41), is computed as 

**==> picture [199 x 14] intentionally omitted <==**

The correction vector _δx_ ˆ _k ∈_ R _[d][x][−]_[1] is then derived, using (40) and (43), as 

**==> picture [187 x 13] intentionally omitted <==**

Representing the rotation and non-rotation components of ˆ ˆ ˆ _δxk ∈_ R _[d][x][−]_[1] as _δxk,r ∈_ S[3] and _δxk,− ∈_ R _[d][x][−]_[4] , respectively, the updated state estimate _x_ ˆ _k|k_ is computed as 

**==> picture [170 x 11] intentionally omitted <==**

Note that the ⊞ operator in (45) has been defined in (32). Finally, the covariance matrix associated with this state estimate is updated, based on (36), (41), and (43), as 

**==> picture [190 x 14] intentionally omitted <==**

## _D. Iterate and Collect IMU Measurements_ 

Proceed to the next index by setting _k ← k_ + 1. The IMU measurements _uk−_ 1 _−db_ : _k−_ 1 _∈_ R _[d][b][×][d][u]_ are collected until image data becomes available at _zk_ , at which point the algorithm proceeds to IV-B. If image data is not yet available, the collection of IMU data continues. 

## V. DEEP LEARNING-BASED ADAPTATION MECHANISM (DLAM) 

This section provides a detailed discussion of the design of the proposed DLAM. This mechanism adaptively updates the covariance matrices of the noise parameters used by the quaternion-based UKF-VIN at each time step, leveraging the input data. The DLAM is designed to enhance the filter’s performance by dynamically adjusting to changes in noise characteristics, thereby ensuring more accurate and robust state estimation. The proposed DLAM is composed of two neural networks, namely, the IMU-Net (Section V-A) and the Vision-Net (Section V-B). The IMU-Net processes the last _d_ GRU _∈_ R measurement vectors (see (24)) as input, while the Vision-Net takes the current stereo image measurements as input. Each network produces scaling factors corresponding to their respective sensor covariance matrices. Given that the IMU noise model includes 12 unknown terms (see (20)), and the vision unit covariance matrix contains a single unknown element (see (28)), the IMU-Net and Vision-Net generate outputs of size 12 and 1, respectively. This can be formulated as: 

**==> picture [240 x 26] intentionally omitted <==**

where _uk−_ 11: _k−_ 1 _∈_ R _[d]_[GRU] _[×][d][u]_ represents the last _d_ GRU measurement vectors, img _l_ and img _r_ denote the left and right images, respectively, and _WIN_ and _WV N_ represent the weights and biases of the IMU-Net and Vision-Net, respectively. To explain the use of the scaling parameters _{γi,k}i_ = _{_ 1 _,...,_ 13 _}_ 

generated by IMU-Net and Vision-Net, let us define the standard deviation vector _ck ∈_ R[13] using the square root of the diagonal elements of the covariance matrices in (20) and (28), such that: 

**==> picture [240 x 16] intentionally omitted <==**

For each _i_ th element of _ck_ , denoted by _ck,i ∈_ R, let _c_ ¯ _k,i ∈_ R represent its nominal value, obtained through traditional offline tuning methods. Then, at each time step _k_ , using the scaling parameters _{γi,k}i_ = _{_ 1 _,...,_ 13 _}_ from (48) and (47), the standard deviation vector elements defined in (49) are computed as in [32], [33]: 

**==> picture [231 x 13] intentionally omitted <==**

where _υ ∈_ R specifies the degree to which the predicted _ck,i_ may deviate from the nominal value _c_ ¯ _k,i_ . Considering (50), (49), (20), and (28), the covariance matrices used by the filter are found as follows: 

**==> picture [183 x 73] intentionally omitted <==**

where _ck,i_ : _j ∈_ R _[j][−][i]_[+1] denotes the _i_ th to _j_ th components of _ck_ . 

**==> picture [253 x 215] intentionally omitted <==**

**----- Start of picture text -----**<br>
GRU Layer 1<br>GRU 1 cell 1 GRU 1 cell 2<br>GRU Layer 2<br>GRU 2 cell 1 GRU 2 cell 2<br>ReLU<br>Output Layer<br>**----- End of picture text -----**<br>


Fig. 1: IMU-Net Architecture Schematics 

## _A. IMU-Net_ 

It is assumed that the covariance matrices _Cηw,k_ and _Cηa,k_ can be optimized for each batch by considering the input vector, which comprises the last _db_ IMU measurements and practically it is a feasible and realizable condition. Recurrent deep learning frameworks, particularly Recurrent Neural Networks (RNNs) and their advanced variants, have proven effective in modeling sequential data due to their capacity to 

8 

capture dependencies across time steps [37]. While traditional RNNs are foundational, they often struggle with long-term dependencies due to challenges such as vanishing gradients [38], [39], leading to the development of more sophisticated architectures, such as Long Short-Term Memory (LSTM) networks [40] and Gated Recurrent Units (GRUs) [41]. LSTMs and GRUs were specifically designed to address the limitations of standard RNNs by incorporating gating mechanisms that regulate information flow, enabling more stable long-term memory retention. In particular, GRUs offer a streamlined architecture by combining the forget and input gates of LSTMs into a single update gate, making them computationally more efficient while retaining the ability to model complex temporal relationships. GRUs have been shown to outperform LSTMs, particularly when the dataset is small, while also being less computationally intensive [41], [42]. 

For a GRU cell at time step _l_ , let _αl ∈_ R _[d][u]_ denote the GRU cell input vector. Each GRU cell computes its hidden state _−→ h l ∈_ R _dh_ by leveraging three key components: the update gate _[−→] z l ∈_ R _[d][h]_ , reset gate _[−→] r l ∈_ R _[d][h]_ , and candidate hidden state _[−→] n l ∈_ R _[d][h]_ , where _dh_ represents the dimensionality of the hidden state. The equations governing these components are as follows: 

Equations (52), (53), (54), and (55) can be adapted to calculate the backward hidden vector _[←−] h l_ by moving in reverse across the sequence, computing each hidden state based on the subsequent hidden vector _[←−] h l_ +1 and the input vector _αl_ . For each GRU layer, consisting of _d_ GRU GRU cells, both forward and backward passes are computed. The forward and backward hidden vectors for each cell are concatenated to form: 

**==> picture [184 x 21] intentionally omitted <==**

In summary, equations (52), (53), (54), (55), and (56) collectively define the GRU function GRU : R _[d][u] ×_ R _[d][h] →_ R[2] _[d][h]_ as follows: 

**==> picture [117 x 16] intentionally omitted <==**

To design IMU-Net, two layers of GRUs have been stacked with a fully connected network at the end, with Rectified Linear Unit (ReLU) activation function as the activation function between the GRUs and the fully connected network, producing the scaling parameters (see (47)). Note that the input to the first GRU layer (that is _α_ 1 _, α_ 2 _, . . . , αd_ GRU ) is set to the last _d_ GRU IMU measurements ( _uk−_ 1 _−d_ GRU: _k−_ 1 _∈_ R _[d]_[GRU] _[×][d][u]_ ). This process is visualized in Fig. 1. 

## _B. Vision-Net_ 

## _•_ **Update Gate** : 

**==> picture [210 x 15] intentionally omitted <==**

where _[−→] W z ∈_ R _[d][h][×][d][u]_ and _[−→] U z ∈_ R _[d][h][×][d][h]_ are weight matrices, and _[−→] b z ∈_ R _[d][h]_ is the bias term. Note that the function _σ_ : R _[d][h] →_ R _[d][h]_ denotes the sigmoid function. The update gate controls the degree to which the previous hidden state _[−→] h l−_ 1 is retained. 

## _•_ **Reset Gate** : 

**==> picture [210 x 15] intentionally omitted <==**

where _[−→] W r ∈_ R _[d][h][×][d][u]_ , _[−→] U r ∈_ R _[d][h][×][d][h]_ , and _[−→] b r ∈_ R _[d][h]_ are the corresponding parameters for the reset gate, which determines the relevance of the previous hidden state in computing the candidate hidden state. 

## _•_ **Candidate Activation** : 

**==> picture [219 x 15] intentionally omitted <==**

where the _◦_ operator represents element-wise multiplication, and _[−→] W n ∈_ R _[d][h][×][d][u]_ , _[−→] U n ∈_ R _[d][h][×][d][h]_ , and _[−→] b n ∈_ R _[d][h]_ are the weight matrices and bias vector associated with the candidate hidden state. Note that tanh : R _[d][h] →_ R _[d][h]_ denotes the hyperbolic tangent function. 

## _•_ **Hidden State Update** : 

**==> picture [189 x 16] intentionally omitted <==**

This update equation combines the previous hidden state _−→ h l−_ 1 and the candidate _−→n l_ , governed by the update gate _−→ z l_ . 

The Vision-Net network is designed to adaptively estimate the measurement covariance matrix based on vision data. The uncertainty in image measurements can be effectively estimated from the current stereo-vision measurements. In VisionNet, each image is processed through a 2D convolutional layer, followed by 2D max pooling, then a second 2D convolutional layer, and another 2D max pooling layer. The resulting features are flattened, concatenated, and subsequently passed through two fully connected layers, ultimately producing the scaling parameter _γ_ 13 _∈_ R (see (48)). Each convolutional layer is followed by a ReLU activation function. A visualization of Vision-Net is provided in Fig. 2. 

## VI. DEEPUKF-VIN TRAINING AND IMPLEMENTATION 

In summary, the DLAM-equipped UKF-VIN algorithm referred to quaternion-based DeepUKF-VIN, is illustrated in Fig. 3. For IMU-Net, we selected the last _d_ GRU = 10 IMU measurements as input (see (47)). This choice is based on the IMU’s 200 Hz sample rate, compared to the image data’s 20 Hz sample rate, meaning there are at least 10 IMU measurements between each pair of vision measurements. Although the structure of IMU-Net allows for variable-length time series input data, using a fixed length of 10 measurements enhances consistency and predictability. To train the models, a loss function must be defined. Let the estimated orientation, position, and velocity at time step _k_ be denoted by _q_ ˆ _k_ , _p_ ˆ _k_ , and ˆ _vk_ , respectively, with their corresponding estimation errors denoted by _re,k_ , _pe,k_ , and _ve,k_ . These errors are defined as follows: 

**==> picture [178 x 43] intentionally omitted <==**

9 

**==> picture [450 x 282] intentionally omitted <==**

**----- Start of picture text -----**<br>
MaxPool<br>MaxPool Conv2+ReLU ( 4  ×  4 )<br>Conv1+ReLU ( 4  ×  4 ) ( 32  ×  5  ×  5 )<br>Left Image ( 16  ×  5  ×  5 )<br>Output<br>Hidden γ 13<br>(32) (1)<br>Flatten<br>MaxPool<br>MaxPool Conv2+ReLU ( 4  ×  4 )<br>Conv1+ReLU ( 4  ×  4 ) ( 32  ×  5  ×  5 )<br>Right Image ( 16  ×  5  ×  5 )<br>**----- End of picture text -----**<br>


Fig. 2: Vision-Net Architecture Schematics 

**==> picture [424 x 255] intentionally omitted <==**

**----- Start of picture text -----**<br>
 Adaption Mechanism<br>IMU Net Vision Net<br> Sensor Data  Filter<br>Vision Data Aggregate IMU Data Aggregate Predict Update Current State VectorEstimate<br>Aggregate IMU IMU Noise Covariance Matrix Vision Data Vision Noise Covariance Matrix<br>     Filter<br> Update<br>  Aggregate Predict<br>Sigma PointsPropagation Calculate the PredictedMean and Covariance of Aggregate  If at end yes Calculate MeasurementSigma Points And ItsStatistics Calculate The CurrentState Estimate<br>Sigma PointsConstruction Augmentation No<br>**----- End of picture text -----**<br>


Fig. 3: Summary schematic architecture of quaternion-based DeepUKF-VIN. First, the Aggregate Predict step of the filter is executed, incorporating the last known state information, aggregated IMU data, and the IMU noise covariance computed by IMU-Net. Next, the Update step is performed using the predicted state information and the vision covariance matrix estimated by Vision-Net. Raw IMU and vision data are used as inputs to IMU-Net and Vision-Net, respectively. 

For a set of _d_[mini-batch] _∈_ R estimations in the _i_ -th mini-batch, square errors (MSE) of the individual errors defined in (57). the total loss is computed as the weighted sum of the mean 

10 

**==> picture [253 x 174] intentionally omitted <==**

Fig. 4: Training loss convergence over 30 epochs. 

The loss function for the mini-batch is given by: 

**==> picture [228 x 48] intentionally omitted <==**

where _wq_ , _wp_ , and _wv ∈_ R are the weights that determine the relative importance of each term and are tuned offline. As the steady-state performance of the filter is of greater importance than its transient performance, the loss function in (58) is evaluated starting from the 51st data point onward. This ensures that the loss function disregards the first 50 data points, which represent the transient response of the filter. 

The V1 02 medium part of the EuRoC dataset [43] has been utilized for training. This dataset includes IMU measurements, recorded at 200 Hz using the ADIS16448 sensor, mounted on an MAV. Stereo images are captured as well by the Aptina MT9V034 global shutter camera at a rate of 20 Hz. Ground truth data is provided at 200 Hz, measured via the Vicon motion capture system. At each epoch, the whole dataset will be utilized as a single batch. In other words, given the initial state estimate and covariance matrix, at each time step, the filter will estimate the state vector based on the IMU and landmark measurements, as well as the covariance matrices found by IMU and Vision-Nets. To manage computational resources effectively, the data is divided into mini-batches of size 32. After each mini-batche is processed, the loss value is found per (58). the gradient of this loss with respect to the networks weights are found and clipped to one to avoid gradient explosion. These gradients are accumulated through mini-batches to find the gradient of the batch. After all the mini-batches in a batch are processed, the weights are updated using the Adam optimizer [44]. _L_ 2 regularization [45] has been performed during the weight training to avoid overfitting. 

The IMU and Vision-Networks have 27,276 and 2,901,089 parameters, respectively, with the weights in (58) set to _wq_ = 1000, _wp_ = 600, and _wv_ = 100. The quaternion-based UKF involves eigenvalue decomposition in (14) and the use of singular value decomposition (SVD) for computing the matrix square root in (31). These operations introduce significant 

**==> picture [253 x 146] intentionally omitted <==**

Fig. 5: Matched feature points between the left and right images of a set of stereo image measurements using EuRoC dataset [43]. 

## **Algorithm 1** Training Procedure **Initialization** : 

- 1: Set initial values for _x_ ˆ0 and _P_ 0. 

- 2: Create mini-batches of size 32 _uk−_ 11: _k−_ 1, _zk_ , and _xk_ . 

- **For** each _i_ -th epoch: 

- 3: Initialize Gradient _←_ 0. 

- **For** each _j_ -th mini-batch: 

- 4: Initialize Loss[mini-batch] _←_ 0. _j_ 

- 5: Compute parameter estimates (see (47) and (48)): _γ_ 1:12[mini-batch] _←_ IMUNet(mini-batch _, WIN_ ) 

- � _γ_ 13[mini-batch] _←_ VisionNet(mini-batch _, WV N_ ) 6: Calculate covariance scaling (see (50) and (51)): _Cov_[mini-batch] _← Cov ·_ 10 _[υ]_[ tanh(] _[γ]_[mini-batch][)] 

- **For** each data point in mini-batch (Sections IV-B and IV-C): 7: _x_ ˆ _k|k−_ 1 _, Pk|k−_ 1 _←_ Predict(DataPoint _, Cov_ 1:12[DataPoint] ) _x_ ˆ _k|k, Pk|k ←_ Update(ˆ _xk|k−_ 1 _, zk, Cov_ 13[DataPoint] ) 

- 8: Store current state and covariance estimates. 

## **End For** 

- 9: Compute loss for the mini-batch see (58) Loss[mini-batch] _←_ Loss(ˆ _x_[mini-batch] _, x_[mini-batch] ) 

**==> picture [198 x 59] intentionally omitted <==**

## **End For** 

- 12: Update model weights using ADAM optimizer: _W_ models _←_ ADAM(Gradient _, W_ models) 

- 13: Reset gradient: Gradient _←_ 0 

## **End For** 

challenges in computing the loss gradient, particularly in step 10 of Algorithm 1. To address these challenges, we employed an EKF as the filter during the model training phase. This substitution simplifies gradient computation considerably, thereby enhancing the training efficiency. Despite this modification, we hypothesize that the model can learn the optimal covariance matrices corresponding to sensor uncertainties independently of the filter type used. This hypothesis will be further examined 

11 

**==> picture [412 x 257] intentionally omitted <==**

Fig. 6: Validation results of quaternion-based DeepUKF-VIN: The algorithm is evaluated using the V1 02 medium EuRoC dataset. On the left, the MAV trajectory along with three sample orientations in 3D space is displayed. On the right, the magnitudes of the orientation (top), position (middle), and velocity (bottom) vectors over time are illustrated. 

in Section VII. Given these considerations, the implementation was carried out using PyTorch for handling the neural network components and for orientation calculations [46]. The models were trained over 30 epochs, during which the loss function converged to its minimum. The convergence behaviour is illustrated in Fig. 4. 

The measurement function is implemented by detecting 2D feature points in each available vision dataset using the KLT algorithm. An example of the results of this step is visualized in Fig. 5. Considering the matched 2D points in the stereo images and the camera calibration data, the feature points in the world coordinate frame _{W}_ are computed using triangulation [47]. These computed points serve as the measurement values in this problem. In summary, the DLAM-equipped UKF-VIN algorithm, named quaternion-based DeepUKF-VIN, is illustrated in Fig. 3. The proposed algorithm leverages IMU-Net and Vision-Net, as described in Sections V-A and V-B, respectively, to compute the covariance matrices of the UKF-VIN, as discussed in Section IV. These components are integrated to enhance the accuracy and performance of the algorithm. The training algorithm is summarized in Algorithm 1. 

## VII. EXPERIMENTAL VALIDATION 

To validate the effectiveness of quaternion-based DeepUKF-VIN, the algorithm is tested using the realworld V1 02 medium EuRoC dataset [43]. For video of the experiment, visit the following link. The dataset trajectory, as well as the magnitudes of orientation, position, and velocity errors defined in (57) over time, are visualized in Fig. 6. The errors converge rapidly to near-zero values despite 

initially high magnitudes, demonstrating quaternion-based DeepUKF-VIN’s efficacy. To further examine the results, the individual components of each estimation error are visualized in Fig. 7. It can be observed that all error components converge to near-zero values promptly, further underscoring the effectiveness of the proposed filter. 

**==> picture [253 x 169] intentionally omitted <==**

Fig. 7: Components of the orientation (left), position (middle), and velocity (right) estimation error vectors in the V1 02 medium EuRoC dataset experiment using quaternionbased DeepUKF-VIN. 

To investigate the effectiveness of the proposed IMU and Vision-Nets, the quaternion-based DeepUKF-VIN was compared to its non-deep counterpart, UKF-VIN, and another Kalman-type filter with a learning component, the DeepEKF. The DLAM algroithm were evaluated in two environments, 

12 

V1 02 medium and V2 02 medium, which are subsets of the EuRoC dataset [43]. Note that V2 02 medium dataset was not utilized during training or validation phases. The dataset was recorded using an Aptina MT9V034 global shutter camera, which captured stereo images at a rate of 20 Hz. Additionally, an ADIS16448 sensor was employed to capture IMU data at 200 Hz, while ground truth data was recorded at 200 Hz using the Vicon motion capture system. To ensure a fair comparison, all filters were configured with the same nominal covariances as DeepUKF-VIN. Furthermore, in each environment, all filters were initialized with the same state vector and covariance matrix. The loss values, as defined in (58), for the aforementioned filters in both experiments are presented in Table II. The proposed DeepUKF-VIN outperformed both its non-deep counterpart (UKF-VIN) and the DeepEKF in terms of loss values across both experiments. The DeepEKF was exposed to data from the first experiment, while the DeepUKF-VIN was never trained on either experiment. Thus, both experiments were entirely novel to the DeepUKFVIN. To further examine these experiments, the MSE values of the orientation, position, and velocity estimation errors are tabulated in Table III. It can be observed from Table III that across both experiments and all components, quaternion-based DeepUKF-VIN consistently outperformed the non-deep UKFVIN and DeepEKF. Specifically, the DeepUKF-VIN yielded lower MSE values across all tested experiments and components, demonstrating its superior performance in orientation, position, and velocity estimation. 

data from a 6-axis Inertial Measurement Unit (IMU) and stereo cameras, achieving robust navigation even in GPS-denied environments. The Deep Learning-based Adaptation Mechanism (DLAM) dynamically adjusts noise covariance matrices based on sensor data, improving estimation accuracy by responding adaptively to varying conditions. Evaluated with real-world data from low-cost sensors operating at low sampling rates, DeepUKF-VIN demonstrated stability and rapid error attenuation. Comparative testing across two experimental setups consistently showed that DeepUKF-VIN outperformed the standard Unscented Kalman Filter (UKF) in all key navigation components. These results underscore the algorithm’s superior adaptability, efficacy, and robustness in practical scenarios, validating its potential for accurate and reliable 3D navigation. 

Future work could explore the application of the proposed DLAM to other Kalman-type and non-Kalman-type filters developed for the VIN problem. Given that the proposed DLAM was trained using the Extended Kalman Filter (EKF) and validated with the UKF, it is reasonable to hypothesize that integrating DLAM with other algorithms may yield similar benefits. Furthermore, the vision-based component of the proposed DLAM could be adapted for alternative sensor inputs, such as Light Detection and Ranging (LiDAR) and Sound Navigation and Ranging (SONAR), with minimal modifications. Such adaptations have the potential to enhance the performance of algorithms relying on these sensor technologies. 

## REFERENCES 

TABLE II: Loss Value Comparison of DeepUKF-VIN against UKF-VIN and DeepEKF. 

|**Filter**|**V1**<br>**02**|**medium**|**V2**|**02**|**medium**|
|---|---|---|---|---|---|
|DeepEKF<br>UKF-VIN<br>DeepUKF-VIN|1918<br>132<br>88||834<br>251<br>250|||



TABLE III: Components MSEs for the two filters in each experiment 

|experiment||||||
|---|---|---|---|---|---|
|**Filter**|**MSE Element**|**V1**|**02**<br>**medium**|**V2**|**02**<br>**medium**|
||Orientation||1.572||0.0544|
|DeepEKF|Position||9.3188||1.1228|
||Velocity||7.5663||0.9558|
||Orientation||0.0015||0.0026|
|UKF-VIN|Position||0.0929||0.3070|
||Velocity||0.0509||0.1319|
||Orientation||0.0008||0.0080|
|DeepUKF-VIN|Position||0.0806||0.3011|
||Velocity||0.0282||0.0914|



## VIII. CONCLUSION 

In this paper, we proposed an adaptively-tuned Deep Learning Unscented Kalman Filter for 3D Visual-Inertial Navigation (DeepUKF-VIN) to estimate the orientation, position, and velocity of a vehicle with six degrees of freedom (6-DoF) in three-dimensional space. By effectively addressing kinematic nonlinearities through a quaternion-based framework, the algorithm mitigates numerical instabilities commonly associated with Euler-angle representations. DeepUKF-VIN integrates 

- [1] H. A. Hashim, “Advances in UAV Avionics Systems Architecture, Classification and Integration: A Comprehensive Review and Future Perspectives,” _Results in Engineering_ , vol. 25, p. 103786, 2025. 

- [2] H. A. Hashim, M. Abouheaf, and M. A. Abido, “Geometric Stochastic Filter with Guaranteed Performance for Autonomous Navigation based on IMU and Feature Sensor Fusion,” _Control Engineering Practice_ , vol. 116, p. 104926, 2021. 

- [3] Y.-J. Gong, T. Huang, Y.-N. Ma, S.-W. Jeon, and J. Zhang, “Mtrajplanner: A multiple-trajectory planning algorithm for autonomous underwater vehicles,” _IEEE Transactions on Intelligent Transportation Systems_ , vol. 24, no. 4, pp. 3714–3727, 2023. 

- [4] G. Yang and et al., “Homecare robotic systems for healthcare 4.0: Visions and enabling technologies,” _IEEE journal of biomedical and health informatics_ , vol. 24, no. 9, pp. 2535–2549, 2020. 

- [5] X. Bai, Y. Ye, B. Zhang, and S. S. Ge, “Efficient package delivery task assignment for truck and high capacity drone,” _IEEE Transactions on Intelligent Transportation Systems_ , vol. 24, no. 11, pp. 13 422–13 435, 2024. 

- [6] J. Hu, H. Niu, J. Carrasco, B. Lennox, and F. Arvin, “Fault-tolerant cooperative navigation of networked uav swarms for forest fire monitoring,” _Aerospace Science and Technology_ , vol. 123, p. 107494, 2022. 

- [7] K. N. Braun and C. G. Andresen, “Heterogeneity in ice-wedge permafrost degradation revealed across spatial scales,” _Remote Sensing of Environment_ , vol. 311, p. 114299, 2024. 

- [8] F. Chen and wt al., “Augmented reality navigation for minimally invasive knee surgery using enhanced arthroscopy,” _Computer Methods and Programs in Biomedicine_ , vol. 201, p. 105952, 2021. 

- [9] R. Korkin, I. Oseledets, and A. Katrutsa, “Multiparticle kalman filter for object localization in symmetric environments,” _Expert Systems with Applications_ , vol. 237, p. 121408, 2024. 

- [10] S. Wattanarungsan, T. Kuwahara, and S. Fujita, “Magnetometer-based attitude determination extended kalman filter and optimization techniques,” _IEEE Transactions on Aerospace and Electronic Systems_ , vol. 59, no. 6, pp. 7993–8004, 2023. 

- [11] X. Hou and J. Bergmann, “Pedestrian dead reckoning with wearable sensors: A systematic review,” _IEEE Sensors Journal_ , vol. 21, no. 1, pp. 143–152, 2021. 

13 

- [12] H. A. Hashim, A. E. Eltoukhy, and K. G. Vamvoudakis, “UWB Ranging and IMU Data Fusion: Overview and Nonlinear Stochastic Filter for Inertial Navigation,” _IEEE Transactions on Intelligent Transportation Systems_ , vol. 25, no. 1, pp. 359–369, 2024. 

- [13] T. M. Roth, F. Freyer, M. Hollick, and J. Classen, “Airtag of the clones: Shenanigans with liberated item finders,” _2022 IEEE Security and Privacy Workshops (SPW)_ , pp. 301–311, 2022. 

- [14] H. A. Hashim, “Exponentially Stable Observer-based Controller for VTOL-UAVs without Velocity Measurements,” _International Journal of Control_ , vol. 96, no. 8, pp. 1946–1960, 2023. 

- [15] P. J. Besl and N. D. McKay, “Method for registration of 3-d shapes,” in _Sensor fusion IV: control paradigms and data structures_ , vol. 1611. Spie, 1992, pp. 586–606. 

- [16] A. Myronenko and X. Song, “Point set registration: Coherent point drift,” _IEEE transactions on pattern analysis and machine intelligence_ , vol. 32, no. 12, pp. 2262–2275, 2010. 

- [17] Y. Xu, R. Zheng, S. Zhang, and M. Liu, “Robust inertial-aided underwater localization based on imaging sonar keyframes,” _IEEE Transactions on Instrumentation and Measurement_ , vol. 71, pp. 1–12, 2022. 

- [18] J. A. Christian and S. Cryan, “A survey of lidar technology and its use in spacecraft relative navigation,” in _AIAA Guidance, Navigation, and Control (GNC) Conference_ , 2013, p. 4641. 

- [19] H. A. Hashim, “GPS-denied Navigation: Attitude, Position, linear Velocity, and Gravity Estimation with Nonlinear Stochastic Observer,” in _2021 American Control Conference (ACC)_ . IEEE, 2021, pp. 1146– 1151. 

- [20] D. G. Lowe, “Distinctive image features from scale-invariant keypoints,” _International journal of computer vision_ , vol. 60, pp. 91–110, 2004. 

- [21] J. Shi _et al._ , “Good features to track,” in _1994 Proceedings of IEEE conference on computer vision and pattern recognition_ . IEEE, 1994, pp. 593–600. 

- [22] F. Santoso, M. A. Garratt, and S. G. Anavatti, “Visual–inertial navigation systems for aerial robotics: Sensor fusion and technology,” _IEEE Transactions on Automation Science and Engineering_ , vol. 14, no. 1, pp. 260–275, 2016. 

- [23] A. I. Mourikis and S. I. Roumeliotis, “A multi-state constraint kalman filter for vision-aided inertial navigation,” in _Proceedings 2007 IEEE international conference on robotics and automation_ . IEEE, 2007, pp. 3565–3572. 

- [24] K. Sun and et al., “Robust stereo visual inertial odometry for fast autonomous flight,” _IEEE Robotics and Automation Letters_ , vol. 3, no. 2, pp. 965–972, 2018. 

- [25] A. Odry, R. Fuller, I. J. Rudas, and P. Odry, “Kalman filter for mobilerobot attitude estimation: Novel optimized and adaptive solutions,” _Mechanical systems and signal processing_ , vol. 110, pp. 569–589, 2018. 

- [26] K. Ghanizadegan and H. A. Hashim, “Quaternion-based Unscented Kalman Filter for 6-DoF Vision-based Inertial Navigation in GPS-denied Regions,” _IEEE Transactions on Instrumentation and Measurement_ , vol. 74, no. 1, pp. 1–13, 2025. 

- [27] H. A. Hashim, L. J. Brown, and K. McIsaac, “Nonlinear Stochastic Attitude Filters on the Special Orthogonal Group 3: Ito and Stratonovich,” _IEEE Transactions on Systems, Man, and Cybernetics: Systems_ , vol. 49, no. 9, pp. 1853–1865, 2019. 

- [28] H. A. Hashim, “Systematic Convergence of Nonlinear Stochastic Estimators on the Special Orthogonal Group SO(3),” _International Journal of Robust and Nonlinear Control_ , vol. 30, no. 10, pp. 3848–3870, 2020. 

- [29] A. T. Erdem and A. O. Ercan, “Fusing inertial sensor data in an extended kalman filter for 3d camera tracking,” _IEEE Transactions on Image Processing_ , vol. 24, no. 2, pp. 538–548, 2014. 

- [30] E. A. Wan and R. Van Der Merwe, “The unscented kalman filter,” _Kalman filtering and neural networks_ , pp. 221–280, 2001. 

- [31] S. Wernitz, E. Chatzi, B. Hofmeister, M. Wolniak, W. Shen, and R. Rolfes, “On noise covariance estimation for kalman filter-based damage localization,” _Mechanical Systems and Signal Processing_ , vol. 170, p. 108808, 2022. 

- [32] M. Brossard, A. Barrau, and S. Bonnabel, “Ai-imu dead-reckoning,” _IEEE Transactions on Intelligent Vehicles_ , vol. 5, no. 4, pp. 585–595, 2020. 

- [33] H. Zhou and et al., “Imu dead-reckoning localization with rnn-iekf algorithm,” in _2022 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)_ . IEEE, 2022, pp. 11 382–11 387. 

- [34] B. Or and I. Klein, “Learning vehicle trajectory uncertainty,” _Engineering Applications of Artificial Intelligence_ , vol. 122, p. 106101, 2023. 

- [35] S. Yan, Y. Liang, and B. Wang, “Multi-level deep learning kalman filter,” in _2023 International Conference on Advanced Robotics and Mechatronics (ICARM)_ . IEEE, 2023, pp. 1113–1118. 

- [36] H. A. Hashim, “Special Orthogonal Group SO(3), Euler Angles, Angleaxis, Rodriguez Vector and Unit-quaternion: Overview, Mapping and Challenges,” _arXiv preprint arXiv:1909.06669_ , 2019. 

- [37] P. B. Weerakody, K. W. Wong, G. Wang, and W. Ela, “A review of irregular time series data handling with gated recurrent neural networks,” _Neurocomputing_ , vol. 441, pp. 161–178, 2021. 

- [38] T. K. Rusch and S. Mishra, “Unicornn: A recurrent model for learning very long time dependencies,” in _International Conference on Machine Learning_ . PMLR, 2021, pp. 9168–9178. 

- [39] M. Lechner and R. M. Hasani, “Learning long-term dependencies in irregularly-sampled time series,” _ArXiv_ , vol. abs/2006.04418, 2020. [Online]. Available: https://api.semanticscholar.org/CorpusID: 219530825 

- [40] Y. Cheng, J. Wu, H. Zhu, S. W. Or, and X. Shao, “Remaining useful life prognosis based on ensemble long short-term memory neural network,” _IEEE Transactions on Instrumentation and Measurement_ , vol. 70, pp. 1–12, 2020. 

- [41] R. Dey and F. M. Salem, “Gate-variants of gated recurrent unit (gru) neural networks,” _2017 IEEE 60th International Midwest Symposium on Circuits and Systems (MWSCAS)_ , pp. 1597–1600, 2017. [Online]. Available: https://api.semanticscholar.org/CorpusID:8492900 

- [42] A. N. Shewalkar, D. Nyavanandi, and S. A. Ludwig, “Performance evaluation of deep neural networks applied to speech recognition: Rnn, lstm and gru,” _Journal of Artificial Intelligence and Soft Computing Research_ , vol. 9, pp. 235 – 245, 2019. 

- [43] M. Burri and et al., “The EuRoC micro aerial vehicle datasets,” _The International Journal of Robotics Research_ , vol. 35, no. 10, pp. 1157– 1163, 2016. 

- [44] D. P. Kingma, “Adam: A method for stochastic optimization,” _arXiv preprint arXiv:1412.6980_ , 2014. 

- [45] P. Zhou, X. Xie, Z. Lin, and S. Yan, “Towards understanding convergence and generalization of adamw,” _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 2024. 

- [46] N. Ravi, J. Reizenstein, D. Novotny, T. Gordon, W.-Y. Lo, J. Johnson, and G. Gkioxari, “Accelerating 3d deep learning with pytorch3d,” _arXiv:2007.08501_ , 2020. 

- [47] R. Hartley and A. Zisserman, _Multiple view geometry in computer vision_ . Cambridge university press, 2003. 

