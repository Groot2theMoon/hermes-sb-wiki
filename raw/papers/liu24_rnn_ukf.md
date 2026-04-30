1 

# **A Recurrent Neural Network Enhanced Unscented Kalman Filter for Human Motion Prediction** 

Wansong Liu[1] , Sibo Tian[2] , Boyi Hu[3] , Xiao Liang[4] , Minghui Zheng[2] 

_**Abstract**_ **—This paper presents a deep learning enhanced adaptive unscented Kalman filter (UKF) for predicting human arm motion in the context of manufacturing. Unlike previous network-based methods that solely rely on captured human motion data, which is represented as bone vectors in this paper, we incorporate a human arm dynamic model into the motion prediction algorithm and use the UKF to iteratively forecast human arm motions. Specifically, a Lagrangian-mechanics-based physical model is employed to correlate arm motions with associated muscle forces. Then a Recurrent Neural Network (RNN) is integrated into the framework to predict future muscle forces, which are transferred back to future arm motions based on the dynamic model. Given the absence of measurement data for future human motions that can be input into the UKF to update the state, we integrate another RNN to directly predict human future motions and treat the prediction as surrogate measurement data fed into the UKF. A noteworthy aspect of this study involves the quantification of uncertainties associated with both the data-driven and physical models in one unified framework. These quantified uncertainties are used to dynamically adapt the measurement and process noises of the UKF over time. This adaption, driven by the uncertainties of the RNN models, addresses inaccuracies stemming from the datadriven model and mitigates discrepancies between the assumed and true physical models, ultimately enhancing the accuracy and robustness of our predictions. One unique point of our method is that, it integrates a dynamic model of human arms and two RNN models, and uses Monte Carlo dropout sampling to quantify the uncertainties inherent in our RNN prediction models and transforms them into the covariances of the UKF’s measurement and process noises respectively. Compared to the traditional RNN-based prediction, our method demonstrates improved accuracy and robustness in extensive experimental validations of various types of human motions.** 

_**Index Terms**_ **—Human motion prediction, uncertainty quantification, adaptive unscented Kalman filter** 

## I. INTRODUCTION 

The emergence of collaborative robots, which are typically designed to work side-by-side with human operators, has sparked a profound and revolutionary change in the domain 

This work was supported by the USA National Science Foundation (Grants: 2026533, 2026276, and 2132923). This work involved human subjects or animals in its research. The authors confirm that all human/animal subject research procedures and protocols are exempt from review board approval. 

> 1Wansong Liu is with the Mechanical and Aerospace Engineering Department, University at Buffalo, Buffalo, NY 14260, USA. Email: wansongl@buffalo.edu. 

2Sibo Tian and Minghui Zheng are with J. Mike Walker ’66 Department of Mechanical Engineering, Texas A&M University, College Station, TX 77840, USA. Emails: _{_ sibotian, mhzheng _}_ @tamu.edu. 

> 1Boyi Hu is with the Industrial and Systems Engineering Department, University of Florida, Gainesville, FL 32611, USA Email: boyihu@ise.ufl.edu. 

2Xiao Liang is with the Department of Civil & Environmental Engineering, Texas A&M University, College Station, TX 77840, USA. Email: xliang@tamu.edu. 

Correspondence to Minghui Zheng and Xiao Liang. 

of the production and manufacturing industry [1], [2]. To foster a harmonious and safe human-robot partnership within the shared working space, robots should be equipped with the ability to understand and forecast their collaborator’s intentions and behaviors so that robots can proactively adjust their motion to support human workers or avoid a potential collision. In this case, human motion prediction plays a crucial role in the next generation intelligent manufacturing system and several prior works have delved into this field within the context of human-robot collaborative assembly and disassembly [3]–[6]. 

Human motion prediction aims to anticipate potential movements of human agents within a given context or environment. It involves various techniques, spanning from traditional probabilistic model methods [7], [8] to the latest trends rooted in deep learning. Deep learning techniques have been extensively applied to the human motion prediction problem in recent years, aiming at capturing the complex motion patterns exhibited by humans. Numerous studies employ Recurrent Neural Networks (RNNs) for sequence-to-sequence prediction due to the remarkable capacity of RNNs to capture temporal correlations in sequential data [9]–[12]. Transformer [13], [14] and Graph Convolutional Networks (GCNs) [15], [16] have also been applied in human motion prediction, offering the benefits of capturing the both spatial and temporal dependencies of human motion data. 

Despite recent neural network-based models demonstrating good predictive capabilities in handling complex motion patterns, a notable issue remains. Current works usually involve a blind reliance on these black-box models, which excel at capturing intricate data relationships, and largely neglect the fundamental biomechanical principles, such as muscle forces and joint mechanics, that govern human motion. This disregard might lead to unrealistic or less precise predictions. It becomes evident that the prediction performance could be further enhanced by integrating neural networks with the underlying physics information of human agents. Several works have demonstrated the benefits of taking the physical information of the human body into consideration. For example, Lie algebra is employed to represent separate kinematic chains of the human body in [17]–[19], and the kinematic structure of the human skeleton is enhanced during the network training. Although Lie algebra-based approaches demonstrate impressive performance, the dynamics of human motion are still not incorporated in the neural networks, especially for the muscle force, which serves as a primary factor driving human motion. 

Existing studies, such as [20]–[22], aim to establish a correlation between human motions and the corresponding muscle forces. For example, Lagrangian dynamic equations are used to characterize human body movements. These studies 

2 

**==> picture [408 x 153] intentionally omitted <==**

**Fig. 1:** Overview of the proposed method: (1) We convert the observed motion into bone vectors and employ the prediction model A along with specific kinematic constraints like bone length to generate the preliminary prediction. The preliminary prediction serves as the measurement data of UKF. (2) Observed muscle forces are calculated based on the arm dynamic model, and the prediction model B is utilized to generate future muscle forces acting on the shoulder and elbow joints. (3) We quantify uncertainties of the prediction models A and B, and dynamically adjust the measurement and process noise covariances of UKF using the quantified uncertainties. (4) UKF eventually outputs the refined prediction, and the red shadow areas indicate uncertainties of refined motions. 

employ inverse dynamics to estimate the forces or torques of person-object interactions actuated by human. Meanwhile, a range of nonlinear estimation methods, including the particle filter [23], extended Kalman filter [24], unscented Kalman filter (UKF) [25], and their modified versions, have been proposed to estimate the future state of human dynamic models. Among these, the UKF has demonstrated superior performance in balancing the accuracy and efficiency of state estimation [26], and it has gained extensive usage in the realms of human motion tracking and prediction [27]–[29]. 

Traditional UKF-based methods assume constant and predefined measurement and process noises. However, such an assumption can result in estimation divergence as the characteristics of the noises evolve. Recently, adaptive filter algorithms have emerged, aiming to improve the accuracy and robustness of the state estimation. For example, in [30], different Kalman filters are fused by the ordered weighted averaging operator. This fusion is employed to iteratively update the noise covariance matrices. Rather than correcting the noise covariance during each iteration, the work presented in [31] employs an online fault-detection mechanism. This mechanism decides the suitable times to generate new noise covariance matrices and replace the current ones. 

In this paper, we consider a human arm model with three joints, including shoulder, elbow and wrist. We employ a physical model based on Lagrangian-mechanics to establish the intrinsic connection between human motions and muscle forces. Furthermore, we leverage an adaptive UKF to predict future human motions using this established connection. Fig. 1 illustrates the overview of our proposed method. Initially, we employ the data-driven prediction model A along with specific kinematic constraints, such as bone length, to derive a preliminary prediction. Different from traditional UKF-based prediction methods that require the realtime measurement data obtained by sensors, we consider this preliminary prediction as the measurement motion data used in the UKF, allowing the model to have a long prediction horizon. Subsequently, we compute observed muscle forces based on the arm dynamic model and utilize the prediction 

model B to estimate future muscle forces. By incorporating these future muscle forces, our motion transition model is capable of computing future arm motions. Eventually, the UKF is leveraged to obtain refined future motions. 

Additionally, accurately defining the measurement and process noises of UKF poses a challenge. The measurement noise of UKF represents inaccuracies and errors of the measurement data, while the process noise of UKF implies variations of system dynamics that are not explicitly accounted by the model. Although the noise covariances can be manually tuned by users in [3], the tuning process is resource-intensive due to the diverse and stochastic nature of human motions. In this study, we employ Monte Carlo dropout sampling (MCDS) method to explicitly quantify uncertainties of the prediction models A and B of Fig. 1. Specifically, uncertainties of the data-driven prediction model A imply inaccuracies of the preliminary prediction. These uncertainties are naturally converted to the measurement noise covariance of UKF. Similarly, uncertainties of the physical model (i.e., the motion transition model of Fig. 1), arising from the incorporation of future muscle forces, are transformed to the process noise covariance of UKF. In general, rather than relying on userdriven heuristic tuning for these two noise covariances, we integrate model uncertainties into the UKF framework. This integration allows an adaptive adjustment of the covariances during the prediction process. Such human motion prediction with possibility of explicitly quantifying uncertainties can be used in task sequence planning and robotic motion planning in human-robot interactive environments [32]–[34] to enable smoother and safer collaboration between human and robots. 

## II. PREDICTION MODEL AND UNCERTAINTIES 

In this section, we briefly introduce the human motion prediction problem definition and notations. Then we show how the network-based prediction model could be used to get the preliminary prediction as the measurement data of UKF, and present details of how we quantify uncertainties of the prediction model as the measurement covariance. 

3 

**==> picture [193 x 137] intentionally omitted <==**

**----- Start of picture text -----**<br>
Prediction  Monte Carlo<br>1 model  2 dropout sampling<br>Motion statistics<br>Time<br>horizon from the sample<br> bin<br>3<br>Sample size<br>Observed Predictive<br>sequence distribution<br>**----- End of picture text -----**<br>


**Fig. 2:** Uncertainty quantification: The observed arm poses are represented using blue color, the predicted arm poses are represented using purple color. Using Monte Carlo dropout sampling method, a single observed sequence can generate multiple predicted sequences. The predictive distribution is generated based on the motion statistics from the sample bin. Each step contains multiple possible arm poses. 

## _A. Prolem definition and RNN-based prediction model_ 

Human motion prediction seeks to forecast future movement sequence data based on the observed motion data, and is typically formed as a regression problem. In this study, we focus on analyzing arm’s motion within the context of manufacturing. The human arm is represented by a three-joint skeleton, including the shoulder, elbow and wrist. We assume that the position of the shoulder is fixed, so the movement of the arm is represented by the positional changes of the elbow and wrist. Instead of using the cartesian coordinates of these two joints, we use unit bone vectors of upper arm and forearm to represent the arm pose, as it has the benefit of avoiding the relative translation issue of arm joints. Thus, an arm pose is denoted as _S_ = [ _s[a]_ ; _s[b]_ ] _∈_ R[6] , where _s[a] ∈_ R[3] and _s[b] ∈_ R[3] respectively indicate unit bone vectors of the upper arm and forearm. The observed arm poses are denoted as **S** = [ _S−N_ +1 _, . . . , S_ 0] _∈_ R[6] _[×][N]_ , where _N_ is the observedˆ step horizon.ˆ The future arm poses are denoted as **S** = [ ˆ _S_ 1 _, . . . , SM_ ] _∈_ R[6] _[×][M]_ , where _M_ is the predicted step horizon. 

To obtain the prediction of human arm, we employ the long short-term memory (LSTM) as the prediction model. It excels at capturing long-term dependencies in sequential data, making them beneficial for understanding the context and relationships of the observed arm poses. The network takes the observed motion sequence **S** as inputs, and incorporates kinematic constraints, such as the fixed bone length, to reconstruct arm poses during the training process. Thus the prediction process is denoted using the following equation: 

**==> picture [166 x 13] intentionally omitted <==**

where **Θ** indicates the parameters of the LSTM model. 

the uncertainties of the prediction model and predict human motions probabilistically. 

The uncertainty exploited in this study arises from the parameters of the LSTM model, and provides insights into the confidence level associated with the model’s output. Multiple methods attempt to quantify the uncertainty of the networkbased model, such as variational autoencoders [35], ensemble methods [36], and MCDS methods [37]. In this study, we choose MCDS to quantify uncertainties of prediction models considering it can accurately measure the uncertainty with less training efforts and computational costs. Dropout is conventionally employed to prevent overfitting in networks by randomly deactivating a set of network units. To quantify this uncertainty, we consider dropout in our LSTM model as the Bayesian approximation over the LSTM model parameters [37]. The prediction distribution can be derived using the following equation: 

**==> picture [181 x 28] intentionally omitted <==**

where _p_ ( **Θ** ) is a prior probability of the model parameters, _p_ ( **S**[ˆ] _|_ **S** _,_ **Θ** ) stands for the likelihood used to capture the prediction process, and _p_ ( **Θ** _|_ **S** _,_ **S**[ˆ] ) indicates the posterior probability distribution. Although the posterior distribution is intractable, we can approximate it with a distribution _q_ ( **Θ** ) through variational inference [38]. This approximated distribution can be learned by minimizing the Kullback-Leibler divergence between _q_ ( **Θ** ) and the actual posterior. 

Additionally, based on [39], the training process of the prediction model is beneficial for learning _q_ ( **Θ** ). Consequently, the predicted variance of arm motions **u[S]**[ˆ] at test time using MCDS is denoted as [40]: 

**==> picture [244 x 30] intentionally omitted <==**

where **u[S]**[ˆ] = [ _u[S]_ 1[ˆ] _[, ..., u][S] M_[ ˆ][]][ indicates uncertainties of the predic-] tion model given the observed motion sequence **S** , _K_ is the number of samples generated through random dropout during the evaluation stage, **Θ** _k_ stands for the model parameters of _k_ th sample after dropout and is fitted to _q_ ( **Θ** ), and _E ≈ K_ 1 � _Kk_ =1 _[LSTM]_[(] **[S]** _[,]_ **Θ** _k_ ) indicates the predictive mean, which is used as the measurement data in UKF. Furthermore, the predictive variance **u[S]**[ˆ] is converted into the measurement noise covariance in UKF. Fig. 2 illustrates the uncertainty quantification of the prediction model. The observed motion sequence is first fed into the LSTM-based prediction model. Subsequently, the MCDS method is applied to generate multiple prediction samples during the evaluation phase. Finally, the predictive distribution is acquired based on the motion statistics from the sample bin. 

## _B. Uncertainty quantification of the prediction model_ 

Due to the inherent variability in human motions, blindly relying on the output of the prediction model is not advisable. Additionally, uncertainty is an intrinsic aspect of the prediction model. Therefore, rather than obtaining a deterministic prediction sequence from Eq. (1), we explicitly measure 

## III. PHYSICS-INFORMED HUMAN MOTION PREDICTION 

In this section, we present an arm dynamic model based on the principles of Lagrangian-mechanics. This model serves to establish the relationship between arm motions and the corresponding muscle forces. Furthermore, we explain how 

4 

**==> picture [159 x 101] intentionally omitted <==**

**----- Start of picture text -----**<br>
Shoulder<br>Wrist<br>Elbow<br>**----- End of picture text -----**<br>


**Fig. 3:** Human arm model: The arm motion is tracked using _ϕ_ 1, _θ_ 1, _ϕ_ 2, and _θ_ 2. Additionally, _ϕ_ 1 is the angle between _a_ 3 and the vector of upper-arm _s[a]_ , _θ_ 1 is the angle between _a_ 1 and the projection vector of _s[a]_ , _ϕ_ 2 is the angle between _b_ 3 and the vector of forearm _s[b]_ , and _θ_ 2 is the angle between _b_ 1 and the projection vector of _s[b]_ . 

**==> picture [254 x 73] intentionally omitted <==**

**----- Start of picture text -----**<br>
2 2<br>3<br>2<br>1<br>1 1<br>(a) Human motion A (b) Human motion B (c) Human motion C<br>**----- End of picture text -----**<br>


**Fig. 4:** Illustration of three human motions: The numbers 1, 2, and 3 indicates the key positions of human hand. In motion A, the human worker first moves forward to grab a screwdriver in the toolbox, then moves back to the start position on the desk. In motion B, the human worker initially grabs a screwdriver on the left side, then moves back to the start position. In motion C, the human worker’s first action is to pick up the screwdriver on the desk, followed by placing it into the toolbox, and ultimately returning to the start position. 

to adaptively update the measurement and process noises of UKF and predict accurate arm motions. 

## _A. Arm dynamic model connecting motion and muscle force_ 

Fig. 3 illustrates the human arm model and two reference frames of the shoulder and elbow joints. We employ _ϕ_ 1 and _θ_ 1 to track the motion of the upper-arm, and _ϕ_ 2 and _θ_ 2 to track the motion of the forearm. We denote _q_ = [ _ϕ_ 1; _θ_ 1; _ϕ_ 2; _θ_ 2] _∈_ R[4] as the generalized coordinate, and consider the force _F_ acting on joints as the only generalized force in this study. EulerLagrangian equations are used to describe the arm motion dynamics: 

**==> picture [189 x 11] intentionally omitted <==**

where _M_ ( _q_ ) is the inertia matrix, _C_ ( _q, q_ ˙) is a velocity coupling matrix, _G_ ( _q_ ) is a gravitational force vector. The observed muscle force sequence **F** _∈_ R[4] _[×][N]_ are calculated based on Eq. (4). Similarly, we employ the methods of motion prediction and uncertainty quantification in Section II to generate future muscle forces **F**[ˆ] = [ _F_[ˆ] 1 _, . . . , F_[ˆ] _M_ ] _∈_ R[4] _[×][M]_ and quantified uncertainties **u[F]**[ˆ] = [ _uF_ 1[ˆ] _[, ..., u] FM_[ ˆ][]][.][Note][that][the] arm dynamic model also establishes the relationship between future arm motions **S**[ˆ] and future muscle forces **F**[ˆ] . 

## _B. Adaptive unscented Kalman filter_ 

This section presents details of using an adaptive UKF to predict arm motions. The temporal state of human arm can be described based on the position and velocity of the arm joints. ˙ We use _x_ = [ _q_ ; _q_ ] _∈_ R[8] to represent the state of the arm 

dynamic model. Eq. (4) can be transformed to the discretetime motion transition model: 

**==> picture [211 x 29] intentionally omitted <==**

where _m_ indicates the index of the prediction step and the step horizon is _M_ , the sampling time is denoted as _Ts_ , and _δm_ ∼(0 _, ρuFm_[ˆ][)][is][process][noise][in][which] _[ρ]_[is][a][scaling][vector] and _uFm_[ˆ][is the quantified uncertainty of the future muscle force.] The motion measurement model is defined as: 

**==> picture [167 x 11] intentionally omitted <==**

where _H_ is a mapping function, and _ζm_ ∼(0 _, λu[S] m_[ˆ][)][is][mea-] surement noise in which _λ_ is a scaling vector and _u[S] m_[ˆ][is][the] quantified uncertainty of the future arm motion. UKF employs the unscented transformation method [41] to generate a set of sigma points _X_ . The state mean _x_ ˆ _[−] m_[and] covariance _Pm[x]_[are][calculated][using][the][following][equation:] 

**==> picture [190 x 64] intentionally omitted <==**

where _L_ is the dimension of the arm state _x_ , _W_ is assigned weights, and _α_ = _G_ ( _Xm[i] −_ 1 _[,][F]_[ˆ] _[m][−]_[1][)] _[ −][x]_[ˆ] _[−] m_[.][In][a][similar][vein,] the measurement mean _y_ ˆ _m[−]_[and][covariance] _[P][ y] m_[are][calculated] using the following equation: 

**==> picture [199 x 64] intentionally omitted <==**

where _β_ = _H_ ( _G_ ( _Xm[i] −_ 1 _[,][F]_[ˆ] _[m][−]_[1][))] _[−][y]_[ˆ] _m[−]_[. The Kalman gain] _[ K][m]_ is calculated using the following equation: 

**==> picture [166 x 12] intentionally omitted <==**

where _Pm[xy]_ =[�][2] _i_ =0 _[L][W][i][αβ][T]_[indicates][the][cross][co-relation] matrix between the estimation and measurement. We convert the mean of the predicted motion sequence _Em_ to _ym[∗]_[,][which] is treated as the sensor-based measurement data in UKF. Eventually, the state of arm dynamic model is predicted using the following equation: 

**==> picture [184 x 27] intentionally omitted <==**

where _x_ ˆ _m_ indicates the refined arm motion and _P_[ˆ] _m[x]_[stands for] the updated prediction covariance used for generating sigma ˆ points of the next iteration. The arm motion sequence **x** = [ˆ _x_ 1 _, . . . ,_ ˆ _xm, . . . ,_ ˆ _xM_ ] is recursively predicted. 

## IV. EXPERIMENTAL VALIDATIONS 

## _A. Different motion datasets and network training_ 

To validate the effectiveness of our method, we develop human motions A, B, and C, as illustrated in Fig. 4. In human 

5 

motions A and B, the human worker grabs a screwdriver from the toolbox, located in the front of human worker and on the left side of human worker respectively. In human motion C, the human picks up a previously used screwdriver and returns it to the toolbox on the right side. We use the Vicon motion capture system to record 132 trajectories for motion A, 144 trajectories for motion B, and 152 trajectories for motion C in the frequency of 25 Hz. Note that one trajectory can generate multiple sets of observation and prediction sequences. 

By integrating the anthropometric data, such as bone length and inertial moments of upper arm and forearm, we compute joint muscle forces based on Eq. (4). All trajectories are converted to unit bone vectors and muscle forces. 70% of the converted data is allocated for training the prediction models, 15% of them is used for validation, and the remaining portion is reserved for testing. The observation horizon _N_ and prediction horizon _M_ are both designed to be 50, which implies we use the preceding 2 seconds of data to forecast the subsequent 2 seconds of data. Addtionally, we use MCDS method with _K_ = 10 to quantify the uncertainties of the prediction models, and adjust the measurement and process noise covariances of UKF. 

**==> picture [181 x 157] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 [-2]<br>4<br>Motion A BV-A BV-AUKF-A<br>Motion B BV-B BV-AUKF-B<br>Motion C BV-C BV-AUKF-C<br>3<br>2<br>1<br>0<br>Motion A Motion B Motion C<br>Elbow error(m)<br>**----- End of picture text -----**<br>


**Fig. 5:** Prediction error of elbow using BV and BV-AUKF for each motion category. Each motion sample has 50 steps of prediction. 

**==> picture [215 x 171] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 [-2]<br>6<br>Motion A BV-A BV-AUKF-A<br>Motion B BV-B BV-AUKF-B<br>Motion C BV-C BV-AUKF-C<br>4<br>2<br>0<br>Motion A Motion B Motion C<br>Wrist error(m)<br>**----- End of picture text -----**<br>


**Fig. 6:** Prediction error of wrist using BV and BV-AUKF for each motion category. Each motion sample has 50 steps of prediction. 

**==> picture [218 x 4] intentionally omitted <==**

**==> picture [10 x 4] intentionally omitted <==**

**==> picture [218 x 88] intentionally omitted <==**

**==> picture [10 x 88] intentionally omitted <==**

**==> picture [217 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Prediction error difference of BV and BV-AUKF in motion A<br>**----- End of picture text -----**<br>


**==> picture [218 x 5] intentionally omitted <==**

**==> picture [10 x 5] intentionally omitted <==**

**==> picture [218 x 88] intentionally omitted <==**

**==> picture [10 x 88] intentionally omitted <==**

**==> picture [217 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
(b) Prediction error difference of BV and BV-AUKF in motion B<br>**----- End of picture text -----**<br>


**==> picture [218 x 5] intentionally omitted <==**

**==> picture [10 x 5] intentionally omitted <==**

**==> picture [218 x 87] intentionally omitted <==**

**==> picture [10 x 87] intentionally omitted <==**

**==> picture [217 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
(c) Prediction error difference of BV and BV-AUKF in motion C<br>**----- End of picture text -----**<br>


**Fig. 7:** Prediction error difference using BV and BV-AUKF: We use the prediction errors based on BV to minus the prediction errors based on BV-AUKF. The gray dash line indicates zeros of the difference, which means equivalent prediction performance between two methods. The samples positioned above the gray dash line imply BV-AUKF outperforms BV in terms of prediction accuracy. The intensity of sample color indicates the number of overlapped samples. It shows the BV-AUKF performs better than BV in complex motions such as motion C and similar for simple motions such as motion A. 

## _B. Prediction results and discussion_ 

UKF iteratively provides the refined state of the arm dynamic model based on the whole state distribution. To better distinguish the prediction results using the traditional RNN and our method, we denote the traditional RNN-based prediction method using bone vectors as BV, and our physics-informed prediction method based on the adaptive UKF as BV-AUKF. Fig. 5 and Fig. 6 present the prediction errors of elbow and wrist at each time point, calculating from a single example motion in each motion category. Different blocks in the plots correspond to different human motions, with each motion sequence comprising 50 steps, equating to a 2-second duration of future arm motion. We use gray and orange colors to respectively present the prediction errors derived from BV and BV-AUKF. Based on the observation from the comparison, the orange lines are below the gray lines in the most of time, which implies that our method yields more accurate predictions in terms of the elbow and wrist positions. 

To have a more comprehensive comparison, we randomly select 40 motion sequences for each type of motion from the test dataset. Each of these sequences has 50 steps. We then 

6 

**TABLE I:** Quantitative results of error reduction percentage. 

||Elbow|Wrist|
|---|---|---|
||||
|Motion|AERP<br>AMERP|AERP<br>AMERP|
||||
|A<br>B<br>C|5.28%<br>43.90%<br>0.13%<br>36.48%<br>3.82%<br>34.95%|1.24%<br>22.00%<br>3.89%<br>34.65&<br>2.36%<br>24.98%|



> * AERP represents average error reduction percentage, AMERP represents average maximum error reduction percentage. The percentage is determined by dividing the difference in errors (error using BV minus error using BV-AUKF) by the prediction error using BV. 

compute the prediction error differences by subtracting the prediction errors generated by BV-AUKF from those produced by BV, and present the error differences of three motions in Fig. 7. Note that the sample positioned above the gray dash line means that BV-AUKF has a smaller prediction error compared to BV. From Fig. 7, it is evident that the majority of samples are positioned above the red lines, indicating that the utilization of the adaptive UKF enhances the accuracy of the prediction for most arm poses. Another noteworthy observation is that within the motion C plot, a considerable number of samples reside above the he gray dash line, and many of them are significantly distant from it. Table. I shows the advantage of our method in a more straightforward way. It presents quantitative results including the average error reduction percentage and the average maximum error reduction percentage of the prediction error from BV to BVAUKF. Our method has a significant improvement with respect to the average of maximum error reduction of each sample. It is worth noting that, we have very carefully tuned the hyper-parameters of the RNNs in the BV human motion prediction method such that we can achieve the best possible results, while the covariance-related parameters in our BVAUKF method are obtained in real-time with minimum tuning efforts. Therefore, even if the improvement is not significant, it is reasonable to state that the proposed RNN-enhanced adaptive UKF can improve the prediction of more dynamic or complex motions while having similar prediction performance for relatively simple motions compared to carefully tuned RNN models, and the tuning efforts of our method are minimal. 

## V. CONCLUSIONS 

This paper presents a recurrent neural network (RNN) enhanced unscented Kalman filter (UKF) to predict the motions of human arms. This method integrates a dynamic model of human arms and two RNN models. One RNN model provides a preliminary prediction that is treated as surrogate measurement data and fed into the UKF as the future measurement; the other RNN model predicts the muscle force of the human arms and is fed into the UKF as the future input. One unique point of our method is that, it uses Monte Carlo dropout sampling to quantify the uncertainties inherent in our RNN prediction models and transform them into the 

covariances of the UKF’s measurement and process noises respectively. UKF adjusts measurement and process noises and their covariances in real-time. Experimental studies show that the proposed RNN-enhanced adaptive UKF, compared to very carefully tuned RNN models, can improve the prediction of more dynamic motions while having similar performance for relatively simple motions. Moreover, the real-time adaption of the covariances in UKF alleviates the tuning efforts of users. 

## REFERENCES 

- [1] A. Weiss, A.-K. Wortmeier, and B. Kubicek, “Cobots in industry 4.0: A roadmap for future practice studies on human–robot collaboration,” _IEEE Transactions on Human-Machine Systems_ , vol. 51, no. 4, pp. 335– 345, 2021. 

- [2] M.-L. Lee, X. Liang, B. Hu, G. Onel, S. Behdad, and M. Zheng, “A review of prospects and opportunities in disassembly with human–robot collaboration,” _Journal of Manufacturing Science and Engineering_ , vol. 146, no. 2, 2024. 

- [3] W. Liu, X. Liang, and M. Zheng, “Dynamic model informed human motion prediction based on unscented kalman filter,” _IEEE/ASME Transactions on Mechatronics_ , vol. 27, no. 6, pp. 5287–5295, 2022. 

- [4] K. A. Eltouny, W. Liu, S. Tian, M. Zheng, and X. Liang, “De-tgn: Uncertainty-aware human motion forecasting using deep ensembles,” _arXiv preprint arXiv:2307.03610_ , 2023. 

- [5] S. Tian, X. Liang, and M. Zheng, “An optimization-based human behavior modeling and prediction for human-robot collaborative disassembly,” in _2023 American Control Conference (ACC)_ . IEEE, 2023, pp. 3356–3361. 

- [6] S. Tian, M. Zheng, and X. Liang, “Transfusion: A practical and effective transformer-based diffusion model for 3d human motion prediction,” _arXiv preprint arXiv:2307.16106_ , 2023. 

- [7] J. Wang, A. Hertzmann, and D. J. Fleet, “Gaussian process dynamical models,” _Advances in neural information processing systems_ , vol. 18, 2005. 

- [8] H. Ding, G. Reißig, K. Wijaya, D. Bortot, K. Bengler, and O. Stursberg, “Human arm motion modeling and long-term prediction for safe and efficient human-robot-interaction,” in _2011 IEEE International Conference on Robotics and Automation_ . IEEE, 2011, pp. 5875–5880. 

- [9] K. Fragkiadaki, S. Levine, P. Felsen, and J. Malik, “Recurrent network models for human dynamics,” in _Proceedings of the IEEE international conference on computer vision_ , 2015, pp. 4346–4354. 

- [10] J. Martinez, M. J. Black, and J. Romero, “On human motion prediction using recurrent neural networks,” in _Proceedings of the IEEE conference on computer vision and pattern recognition_ , 2017, pp. 2891–2900. 

- [11] D. Pavllo, D. Grangier, and M. Auli, “Quaternet: A quaternion-based recurrent model for human motion,” _arXiv preprint arXiv:1805.06485_ , 2018. 

- [12] A. Jain, A. R. Zamir, S. Savarese, and A. Saxena, “Structural-rnn: Deep learning on spatio-temporal graphs,” in _Proceedings of the ieee conference on computer vision and pattern recognition_ , 2016, pp. 5308– 5317. 

- [13] E. Aksan, M. Kaufmann, P. Cao, and O. Hilliges, “A spatio-temporal transformer for 3d human motion prediction,” in _2021 International Conference on 3D Vision (3DV)_ . IEEE, 2021, pp. 565–574. 

- [14] Y. Cai, L. Huang, Y. Wang, T.-J. Cham, J. Cai, J. Yuan, J. Liu, X. Yang, Y. Zhu, X. Shen _et al._ , “Learning progressive joint propagation for human motion prediction,” in _Computer Vision–ECCV 2020: 16th European Conference, Glasgow, UK, August 23–28, 2020, Proceedings, Part VII 16_ . Springer, 2020, pp. 226–242. 

- [15] L. Dang, Y. Nie, C. Long, Q. Zhang, and G. Li, “Msr-gcn: Multi-scale residual graph convolution networks for human motion prediction,” in _Proceedings of the IEEE/CVF International Conference on Computer Vision_ , 2021, pp. 11 467–11 476. 

- [16] M. Li, S. Chen, Y. Zhao, Y. Zhang, Y. Wang, and Q. Tian, “Dynamic multiscale graph neural networks for 3d skeleton based human motion prediction,” in _Proceedings of the IEEE/CVF conference on computer vision and pattern recognition_ , 2020, pp. 214–223. 

- [17] Z. Liu, S. Wu, S. Jin, Q. Liu, S. Lu, R. Zimmermann, and L. Cheng, “Towards natural and accurate future motion prediction of humans and animals,” in _Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition_ , 2019, pp. 10 004–10 012. 

- [18] J. Hu, Z. Fan, J. Liao, and L. Liu, “Predicting long-term skeletal motions by a spatio-temporal hierarchical recurrent network,” _arXiv preprint arXiv:1911.02404_ , 2019. 

7 

- [19] L.-Y. Gui, Y.-X. Wang, X. Liang, and J. M. Moura, “Adversarial geometry-aware human motion prediction,” in _Proceedings of the european conference on computer vision (ECCV)_ , 2018, pp. 786–803. 

- [20] Z. Li, J. Sedlar, J. Carpentier, I. Laptev, N. Mansard, and J. Sivic, “Estimating 3d motion and forces of person-object interactions from monocular video,” in _Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition_ , 2019, pp. 8640–8649. 

- [21] X. Lv, J. Chai, and S. Xia, “Data-driven inverse dynamics for human motion,” _ACM Transactions on Graphics (TOG)_ , vol. 35, no. 6, pp. 1–12, 2016. 

- [22] S. Cao and R. Nevatia, “Forecasting human pose and motion with multibody dynamic model,” in _2015 IEEE Winter Conference on Applications of Computer Vision_ . IEEE, 2015, pp. 191–198. 

- [23] I.-C. Chang and S.-Y. Lin, “3d human motion tracking based on a progressive particle filter,” _Pattern Recognition_ , vol. 43, no. 10, pp. 3621–3635, 2010. 

- [24] K. Reif and R. Unbehauen, “The extended kalman filter as an exponential observer for nonlinear systems,” _IEEE Transactions on Signal processing_ , vol. 47, no. 8, pp. 2324–2328, 1999. 

- [25] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _Proceedings of the IEEE_ , vol. 92, no. 3, pp. 401–422, 2004. 

- [26] F. Gustafsson and G. Hendeby, “Some relations between extended and unscented kalman filters,” _IEEE Transactions on Signal Processing_ , vol. 60, no. 2, pp. 545–555, 2011. 

- [27] D. Lee, C. Liu, Y.-W. Liao, and J. K. Hedrick, “Parallel interacting multiple model-based human motion prediction for motion planning of companion robots,” _IEEE Transactions on Automation Science and Engineering_ , vol. 14, no. 1, pp. 52–61, 2016. 

- [28] Z. Wang, S. Liu, and Y. Xu, “Human motion prediction based on hybrid motion model,” in _2017 IEEE International Conference on Information and Automation (ICIA)_ . IEEE, 2017, pp. 942–946. 

- [29] A. Atrsaei, H. Salarieh, and A. Alasty, “Human arm motion tracking by orientation-based fusion of inertial sensors and kinect using unscented kalman filter,” _Journal of biomechanical engineering_ , vol. 138, no. 9, p. 091005, 2016. 

- [30] S. Soltani, M. Kordestani, P. K. Aghaee, and M. Saif, “Improved estimation for well-logging problems based on fusion of four types of kalman filters,” _IEEE Transactions on Geoscience and Remote Sensing_ , vol. 56, no. 2, pp. 647–654, 2017. 

- [31] B. Zheng, P. Fu, B. Li, and X. Yuan, “A robust adaptive unscented kalman filter for nonlinear estimation with uncertain noise covariance,” _Sensors_ , vol. 18, no. 3, p. 808, 2018. 

- [32] M.-L. Lee, S. Behdad, X. Liang, and M. Zheng, “Task allocation and planning for product disassembly with human–robot collaboration,” _Robotics and Computer-Integrated Manufacturing_ , vol. 76, p. 102306, 2022. 

- [33] M.-L. Lee, W. Liu, S. Behdad, X. Liang, and M. Zheng, “Robotassisted disassembly sequence planning with real-time human motion prediction,” _IEEE Transactions on Systems, Man, and Cybernetics: Systems_ , vol. 53, no. 1, pp. 438–450, 2022. 

- [34] W. Liu, X. Liang, and M. Zheng, “Task-constrained motion planning considering uncertainty-informed human motion prediction for human– robot collaborative disassembly,” _IEEE/ASME Transactions on Mechatronics_ , 2023. 

- [35] G. Franchi, A. Bursuc, E. Aldea, S. Dubuisson, and I. Bloch, “Encoding the latent posterior of bayesian neural networks for uncertainty quantification,” _arXiv preprint arXiv:2012.02818_ , 2020. 

- [36] B. Lakshminarayanan, A. Pritzel, and C. Blundell, “Simple and scalable predictive uncertainty estimation using deep ensembles,” _Advances in neural information processing systems_ , vol. 30, 2017. 

- [37] Y. Gal and Z. Ghahramani, “Dropout as a bayesian approximation: Representing model uncertainty in deep learning,” in _international conference on machine learning_ . PMLR, 2016, pp. 1050–1059. 

- [38] A. Graves, “Practical variational inference for neural networks,” _Advances in neural information processing systems_ , vol. 24, 2011. 

- [39] Y. Gal and Z. Ghahramani, “Bayesian convolutional neural networks with bernoulli approximate variational inference,” _arXiv preprint arXiv:1506.02158_ , 2015. 

- [40] A. Kendall and Y. Gal, “What uncertainties do we need in bayesian deep learning for computer vision?” _Advances in neural information processing systems_ , vol. 30, 2017. 

- [41] S. J. Julier and J. K. Uhlmann, “New extension of the kalman filter to nonlinear systems,” in _Signal processing, sensor fusion, and target recognition VI_ , vol. 3068. Spie, 1997, pp. 182–193. 

