---
source_url: 
ingested: 2026-04-29
sha256: 19de61ad3d93d423bcdfae77ed403522f1c0abd27ab76ae35243642a2e39aad8
---

# **Enhancing State Estimation in Robots: A Data-Driven Approach with Differentiable Ensemble Kalman Filters** 

Xiao Liu[1] , Geoffrey Clark[1] , Joseph Campbell[2] , Yifan Zhou[1] , and Heni Ben Amor[1] 

_**Abstract**_ **— This paper introduces a novel state estimation framework for robots using differentiable ensemble Kalman filters (DEnKF). DEnKF is a reformulation of the traditional ensemble Kalman filter that employs stochastic neural networks to model the process noise implicitly. Our work is an extension of previous research on differentiable filters, which has provided a strong foundation for our modular and end-to-end differentiable framework. This framework enables each component of the system to function independently, leading to improved flexibility and versatility in implementation. Through a series of experiments, we demonstrate the flexibility of this model across a diverse set of real-world tracking tasks, including visual odometry and robot manipulation. Moreover, we show that our model effectively handles noisy observations, is robust in the absence of observations, and outperforms state-of-theart differentiable filters in terms of error metrics. Specifically, we observe a significant improvement of at least 59% in translational error when using DEnKF with noisy observations. Our results underscore the potential of DEnKF in advancing state estimation for robotics. Code for DEnKF is available at https://github.com/ir-lab/DEnKF** 

## I. INTRODUCTION 

In robotics, Recursive Bayesian filters, especially Kalman filters, play a crucial role in accurately localizing robots in their surroundings [1], predicting the future movements of human interaction partners [2], tracking objects over time [3], and ensuring stability during robot locomotion [4]. Typically, the success of these filters depends on having an accurate model of the dynamics of the system being observed, as well as a model of the observation process itself. However, modeling complex systems and their noise profiles can be a challenging task, often requiring additional steps like statistical modeling or system identification. Despite advancements in this field, such as particle filters [5], scalability remains an issue when working with high-dimensional systems. 

The limitations of traditional Bayesian filters have inspired the development of Deep State-Space Models (DSSM) [6]– [8]. DSSM leverages deep learning techniques to learn approximate, nonlinear models of the underlying states and measurements from recorded data. This approach aims to overcome the need for explicit modeling of the processes, which can be challenging for complex dynamical systems. However, incorporating the nonlinear capabilities of neural networks into recursive filtering may come with additional linearization steps or limitations [1], which can impact the quality of the inference. In this paper, we introduce a new ap- 

> 1X. Liu, G. Clark, Y. Zhou, and H. Ben Amor are with SCAI at Arizona State University, USA {xliu330, gmclark1, yzhou298, hbenamor}@asu.edu 

> 2J. Campbell is with the RI at Carnegie Mellon University, USA jcampbell@cmu.edu 

**==> picture [244 x 188] intentionally omitted <==**

**----- Start of picture text -----**<br>
Observation<br>Sensor<br>Model<br>...<br>Observation Ensemble Ensemble Ensemble<br>Model<br>...<br>Transition<br>Model<br>State<br>**----- End of picture text -----**<br>


Fig. 1: Differentiable Ensemble Kalman Filter (DEnKF), employs an ensemble state to represent the probability density and integrates a stochastic neural network to generate state transitions. In order to project high-dimensional visual inputs to observation space, a sensor model is utilized. By combining an ensemble Kalman Filter with a learned observation model, the DEnKF is able to achieve precise posterior state estimations. 

proach to robot state estimation by extending prior research on differentiable recursive filters. Specifically, we propose the Differentiable Ensemble Kalman Filter (DEnKF), which employs high-dimensional camera images to estimate and correct the state of a robot arm, as demonstrated in Fig. 1. Our method builds upon the solid foundation established by prior works on differentiable filters, including the contributions made in [7]–[9]. Our approach addresses the challenges encountered by differentiable filtering through both theoretical and practical innovations. One such innovation involves the sampling of states from the posterior distribution of a neural network, which eliminates the need to estimate noise parameters for the recursive filter. Another innovation involves the ensemble formulation of the filtering process, which eliminates the need for linearization. Notably, unlike many other Deep State-Space Models (DSSM) in the literature, our approach avoids the use of Recurrent Neural Networks (RNNs), which have been shown to limit the accuracy of learned models and may lead to non-Markovian state-spaces [7]. 

In this paper, we present an end-to-end learning approach for recursive filtering that simultaneously learns the observation, dynamics, and noise characteristics of a robotic system. The key contributions of our work can be summarized as follows: 

- A stochastic state transition model that uses samples from the posterior of a neural network to implicitly model the process noise, avoiding the need for a parametric representation of the posterior. 

- An ensemble formulation that allows for the efficient inference of both linear and nonlinear systems, without the need for an explicit covariance matrix, making it suitable for high-dimensional inputs and noisy observations. 

- Empirical evaluations for the autonomous driving task show DEnKF effectively reduce the translational and rotational errors compared to state-of-the-art methods, reducing errors by up to 59% and 36% when dealing with noisy observations, and handling missing observation scenarios with improved error reductions by 2-fold and 3-fold. 

## II. RELATED WORK 

Kalman filters (KFs) are well-studied and widely-used state-space models with many applications in robotics [1]. KFs are designed for systems with linear process and observation models and assume normally distributed noise. To overcome some of these limitations and extend the inference capabilities to nonlinear systems, several variants have been proposed, e.g., the Extended Kalman Filter (EKF) [10] and the Unscented Kalman Filter (UKF) [11]. Still, even the EKF and UKF face theoretical and computational challenges when dealing with high-dimensional observations. Among the many reasons for this limitation is the need for explicitly calculating an error covariance during the filtering process. 

**Differentiable filters** : Differentiable filters (DFs) aim to adapt the recursive filtering techniques to handle highdimensional inputs. For instance, BackpropKF [12] proposed a way to train Kalman Filters as recurrent neural networks using backpropagation with the integration of feed-forward networks and convolutional neural networks. Similarly, Differentiable algorithm networks [13] introduced neural network components that encode differentiable robotic algorithms. This methodology is similar to that of Differentiable Particle Filters (DPFs) [9], [14], [15], which employ algorithmic priors to increase learning efficiency. Variations of DPFs were explored in [16] and [17] using adversarial methods for posterior estimation or partial ground truth particles for semi-supervised learning. The training of DFs and modeling of uncertainty along with noise profiles were analyzed in [8]. The authors implemented the components of the DFs as multi-layer perceptrons and enveloped the sub-modules in an RNN layer. The DFs in [8], [18] were tested on realworld tasks, indicating that end-to-end learning is crucial for learning accurate noise models. Similarly, [19] developed a self-supervised visual-inertial odometry model using the differentiable Extended Kalman Filter (dEKF) based on the work in [8]. However, as noted in [7], RNNs can often be a limiting factor in learning accurate models of the system dynamics. The current lack of DFs that handle missing observations is attributed to the use of RNN frameworks to model system dynamics. 

**Ensemble Kalman Filters** : A modern variant of KFs that is particularly successful on high-dimensional, nonlinear tasks is Ensemble Kalman Filters (EnKFs) [20]. EnKFs have been shown to enable accurate estimation of state-space dynamics in data assimilation tasks [21] without linearity assumptions. They have found popularity in modeling and forecasting complex weather phenomena that may include millions of state dimensions [22]. Rather than assuming a certain parametric form of the underlying distribution, EnKFs approximate the posterior distribution through an ensemble (or collection) of state vectors. They are computationally efficient since they do not require the explicit calculation (and inversion) of error covariance matrices. In addition, EnKFs do not require explicit parametric characterizations of the process and observation noise. Instead, it only requires the ability to generate samples from the underlying distributions. 

In this paper, we leverage this **key insight** in order to create a theoretical and practical connection between EnKFs and stochastic Bayesian neural networks (SNNs) [23], [24]. As stated in [25], SNNs can model two types of uncertainty: 1) aleatoric uncertainty, which arises from inherent stochasticities of a system, i.e., process noise and observation noise; 2) epistemic uncertainty, which is caused by a lack of sufficient data to determine the underlying system uniquely. The integration between EnKFs and SNNs results in a probabilistic filtering process that leverages the advantages of modern neural network techniques. First attempts at differentiable EnKFs were proposed in [26] which searches for optimal parameters utilizing gradient information from EnKFs. This differs substantially from our approach, which is a fully differentiable end-to-end framework. Note that EnKF is theoretically related to Particle Filters (PFs) – both are Monte-Carlo filtering techniques based on similar principles. However, in contrast to PFs, EnKFs provide equal weight to each ensemble member thereby eschewing the well-known sample degeneracy problem. In addition, EnKFs have also been shown to efficiently model complex phenomena using relatively small ensemble sizes [27]. A study of the approximation error of these filters [28] also indicates that with increasing size of state dimensions, EnKFs show a much slower rate of degradation than the PFs. 

## III. DIFFERENTIABLE ENKF 

Recursive Bayesian filtering addresses the general challenge of estimating the state **x** _t_ of a discrete-time dynamical system given a sequence of noisy observations **y** 1: _t_ . The posterior distribution of the state can be represented as: 

**==> picture [238 x 11] intentionally omitted <==**

Let bel( **x** _t_ ) = _p_ ( **x** _t|_ **y** 1: _t,_ **x** 1: _t−_ 1), applying the Markov property, i.e., the assumption that the next state is dependent only upon the current state, yields: 

**==> picture [238 x 39] intentionally omitted <==**

where _p_ ( **y** _t|_ **x** _t_ ) is the observation model and _p_ ( **x** _t|_ **x** _t−_ 1) is the transition model. The transition model describes the laws that govern the evolution of the system state. By contrast, the observation model identifies the relationship between the hidden, internal state of the system and observed, noisy measurements. An alternative approach of KFs and its variants is to leverage modern deep learning techniques in order to extract complex, nonlinear transition and observation models. Starting with the state transition model in linear KFs: 

**==> picture [197 x 11] intentionally omitted <==**

the work in [8] replaces the transition matrix **A** and the process noise **Q** _t_ with trained neural networks _f_ _**θ**_ and _q_ _**ψ**_ respectively: 

**==> picture [194 x 11] intentionally omitted <==**

where _**θ**_ and _**ψ**_ denote the neural network weights. Note, that the network _q_ _**ψ**_ ( _·_ ) produces the entries of the covariance matrix **Q** _t_ representing a Gaussian distribution. As shown in Eq. 4, the state estimate **x** _t_ is calculated by generating a sample from a normal distribution with covariance **Q** _t_ which is then added to the neural network prediction _f_ _**θ**_ ( **x** _t−_ 1). Hence, the process model and the process noise are calculated using two separate neural networks which may not be producing outputs consistent with each other. 

## _A. Stochastic Neural Models of Dynamics_ 

In this paper, we avoid this separation by using recent insights in stochastic neural networks (SNNs) [23]. More specifically, the work in [29] has established a theoretical link between the Dropout training algorithm and Bayesian inference in deep Gaussian processes. Accordingly, after training a neural network with Dropout, it is possible to generate empirical samples from the predictive posterior via _stochastic forward passes_ . Hence, for the purposes of filtering, we can **implicitly model the process noise** by sampling state from a neural network trained on the transition dynamics, i.e., **x** _t_ ∼ _f_ _**θ**_ ( **x** _t−_ 1). In contrast to previous approaches, the transition network _f_ _**θ**_ ( _·_ ) models the system dynamics, as well as the inherent noise model in a consistent fashion without imposing diagonality. 

## _B. Nonlinear Filtering with Differentiable Ensembles_ 

Introducing non-linearities through neural network realizations of the transition and observation function invalidates the linearity assumptions that are the backbone of many recursive Bayesian filters. To overcome this challenge, we embed our methodology within an EnKF framework. Throughout the filtering process, each ensemble member is propagated forward in time to yield a new approximate posterior distribution. EnKF does not require an explicit representation of the process and observation noise – instead we only need to be able to sample from the noise distribution. We formulate DEnKF as an extension of the EnKF while keeping the core algorithmic steps intact. In particular, we use an initial ensemble of _E_ members to represent the initial state distribution **X** 0 = [ **x**[1] 0 _[, . . . ,]_ **[ x]** _[E]_ 0[]][,] _[E][∈]_[Z][+][.] 

**Prediction Step** : We leverage the stochastic forward passes from a trained state transition model to update each ensemble member: 

**==> picture [208 x 14] intentionally omitted <==**

Matrix **X** _t|t−_ 1 = [ **x**[1] _t|t−_ 1 _[,][ · · ·][,]_ **[ x]** _[E] t|t−_ 1[]][holds][the][updated] ensemble members which are propagated one step forward through the state space. Note that sampling from the transition model _f_ _**θ**_ ( _·_ ) (using the SNN methodology described above) implicitly introduces a process noise. 

**Update Step** : Given the updated ensemble members **X** _t|t−_ 1, a nonlinear observation model _h_ _**ψ**_ ( _·_ ) is applied to transform the ensemble members from the state space to observation space. Following our main rationale, the observation model is realized via a neural network with weights _**ψ**_ . Accordingly, the update equations for the EnKF become: 

**==> picture [243 x 67] intentionally omitted <==**

**H** _t_ **X** _t|t−_ 1 is the predicted observation, and **H** _t_ **A** _t_ is the sample mean of the predicted observation at _t_ . EnKF treats observations as random variables. Hence, the ensemble can incorporate a measurement perturbed by a small stochastic noise thereby accurately reflecting the error covariance of the best state estimate [20]. In our differentiable version of the EnKF, we also incorporate a sensor model which can learn projections between a latent space and higher-dimensional observations spaces, i.e. images. To this end, we leverage the methodology from Sec. III-A to train a stochastic sensor model _s_ _**ξ**_ ( _·_ ): 

**==> picture [175 x 13] intentionally omitted <==**

where **y** _t_ represents the noisy observation. Sampling yields observations **Y**[˜] _t_ = [˜ **y** _t_[1] _[,][ · · ·][,]_[ ˜] **[y]** _t[E]_[]][and][sample][mean] **[y]**[˜] _[t]_[=] _E_ 1 � _ii_ =1 **[y]**[˜] _t[i]_[.][The][innovation][covariance] **[S]** _[t]_[can][then][be][cal-] culated as: 

**==> picture [210 x 21] intentionally omitted <==**

where _r_ _**ζ**_ ( _·_ ) is the measurement noise model implemented using MLP. We use the same way to model the observation ˜ noise as in [8], _r_ _**ζ**_ ( _·_ ) takes an learned observation **y** _t_ in time _t_ and provides stochastic noise in the observation space by constructing the diagonal of the noise covariance matrix. The final estimate of the ensemble **X** _t|t_ can be obtained by performing the measurement update step: 

**==> picture [197 x 30] intentionally omitted <==**

**==> picture [197 x 22] intentionally omitted <==**

**==> picture [202 x 14] intentionally omitted <==**

where **K** _t_ is the Kalman gain. In inference, the ensemble mean **¯x** _t|t_ = _E_ 1 � _Ei_ =1 **[x]** _[i] t|t_[is][used][as][the][updated][state.] 

The neural network structures for all learnable modules are described in Table I. Furthermore, we highlight couple of the theoretical properties (in Appendix) of EnKF and its relations to DEnKF. 

TABLE I: Differentiable EnKF learnable sub-modules. 

_f_ _**θ**_ : 2 _×_ SNN(32, ReLu), 2 _×_ SNN(64, ReLu), 1 _×_ SNN(S, -) _h_ _**ψ**_ : 2 _×_ fc(32, Relu), 2 _×_ fc(64, ReLu), 1 _×_ fc(O, -) _r_ _**ζ**_ : 2 _×_ fc(16, ReLu), 1 _×_ fc(O, -) conv(7 _×_ 7, 64, stride 2, ReLu), conv(3 _×_ 3, 32, stride 2, ReLu), _s_ _**ξ**_ : conv(3 _×_ 3, 16, stride 2, ReLu), flatten(), 2 _×_ SNN(64, ReLu), 2 _×_ SNN(32, ReLu), 1 _×_ SNN(O, -) 

fc: fully connected, conv: convolution, S, O: state and observation dimension. 

**==> picture [246 x 110] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.4 Test 100 m/m<br>Test 100 deg/m<br>0.3 Test 100/200/400/800 m/m<br>Test 100/200/400/800 deg/m<br>0.2<br>0.1<br>0.0<br>LSTM BKF dEKF DPF dPF-M DEnKF<br>Different differentiable filters<br>Error rate<br>**----- End of picture text -----**<br>


Fig. 2: Visual Odometry results with different differentiable filters: the error rate for LSTM and BKF are reported from [12], dEKF, DPF, and dPF-M are reproduced. 

## IV. EXPERIMENTS 

We evaluate the DEnKF framework on two common robotics tasks: a) a visual odometry task for autonomous driving and b) a robot manipulation task in both simulation and real-world. We compare our results to a number of stateof-the-art differential filtering methods [8], [9], [12]. 

**Training:** DEnKF contains four sub-modules: a state transition model, an observation model, an observation noise model, and a sensor model. The entire framework is trained in an end-to-end manner via a mean squared error (MSE) loss between the ground truth state **x** ˆ _t|t_ and the estimated state **¯x** _t|t_ at every timestep. We also supervise the intermediate modules via loss gradients _Lf_ _**θ**_ and _Ls_ _**ξ**_ . Given ground truth at time _t_ , we apply the MSE loss gradient calculated between **x** ˆ _t|t_ and the output of the state transition model to _f_ _**θ**_ as in Eq. 13. We apply the intermediate loss gradients computed based on the ground truth observation **y** ˆ _t_ and the output of the stochastic sensor model **y** ˜ _t_ : 

**==> picture [223 x 14] intentionally omitted <==**

All models in the experiments were trained for 50 epochs with batch size 64, and a learning rate of _η_ = 10 _[−]_[5] . We chose the model with the best performance on a validation set for testing. The ensemble size of the DEnKF was set to **32 ensemble members.** 

## _A. Visual Odometry Task_ 

In this experiment, we investigate performance on the popular KITTI Visual Odometry dataset [30]. Following the same evaluation procedure as our baselines [8], [9], [12], we define the state of the moving vehicle as a 5-dimensional vector **x** = [ _x, y, θ, v, θ_[˙] ] _[T]_ , including the position and orientation of the vehicle, and the linear and angular velocity w.r.t. the current heading direction _θ_ . The raw observation **y** corresponds to the RGB camera image of the current frame and a difference image between the current frame and the previous frame, where **y** _∈_ R[150] _[×]_[50] _[×]_[6] . The learned ˜ ˜ observation **y** is defined as **y** = [ _v, θ_[˙] ] _[T]_ , since only the relative changes of position and orientation can be captured between two frames. 

**Data:** The KITTI Visual Odometry dataset consists of 11 trajectories with ground truth pose (translation and rotation matrices) of a vehicle driving in urban areas with a data 

collection rate around 10Hz. To facilitate learning, we standardize the data on every dimension to have a 0 mean and a standard deviation of 1 during training. 

**Results:** We assess the performance of state estimation using an 11-fold cross-validation withholding 1 trajectory at each time. We report the root mean squared error (RMSE), mean absolute error (MAE), and the standard KITTI benchmark metrics, the translational error (m/m), and the rotational error (deg/m) in Table II. The error metrics are computed from the test trajectory over all subsequences of 100 timesteps, and all subsequences of 100, 200, 400, and 800 timesteps. Figure 2 shows the performance of DEnKF and other differentiable filtering techniques. Note that lower error metrics can be obtained by imposing domainand data-specific information, i.e., using stereo images [31], incorporating LiDAR [32], [33], or applying SLAM and loop-closure related assumptions [31], [34]. However, we opt for the most commonly used setup when comparing filtering technique in a task-agnostic fashion (as performed in [8], [9], [12]) to ensure fair and comparable evaluations. 

**Comparison:** Table II presents the outcomes of our proposed method in comparison with the existing stateof-the-art differentiable filters, including differentiable Extended Kalman filter (dEKF) [8], differentiable particle filter (DPF) [9], and modified differentiable particle filter with learned process and process noise models (dPF-M-lrn) [8]. To provide a fair comparison, we do not include unstructured LSTM models as baselines since prior works [8], [12] have shown that LSTM models do not achieve comparable results. In our comparison, we use the same pre-trained sensor model _s_ _**ξ**_ with the same visual inputs and integrate it into all the DF frameworks evaluated here. In this experiment, the motion model of the vehicle is known. The only unknown part of the state is the velocities. Therefore, we use the learnable process model to update those state variables and use the known motion model to update the ( _x, y, θ_ ). For dEKF, we supply the computed Jacobian matrix in training and testing since the motion model is known. For DPF, we use 100 particles to train and test. DPF contains a different learnable module called observation likelihood estimation model _l_ , which takes an image embedding and outputs a likelihood for updating each particle’s weight. 

Table II shows that DEnKF achieves a RMSE of 1.33, 

TABLE II: Result evaluations on KITTI Visual Odometry task measured in RMSE and MAE. m/m and def/m denote the translational error and the rotational error. Results for dEKF, dPF, and dPF-M-lrn are reproduced for detailed comparisons. 

|Method|RMSE|MAE|Test <br>m/m|100<br>deg/m|Test 100/200/400/800<br>m/m<br>deg/m|Test 100/200/400/800<br>m/m<br>deg/m|Wall clock<br>time (s)|
|---|---|---|---|---|---|---|---|
|dEKF [8]|2.9366_±_0.006|1.9738_±_0.027|0.2646_±_0.004|0.1386_±_0.002|0.3159_±_0.002|0.0923_±_0.005|**0.0463**_±_**0.004**|
|DPF [9]|2.2575_±_0.027|1.4671_±_0.014|0.1344_±_0.002|0.1203_±_0.007|0.2255_±_0.001|0.0716_±_0.004|0.0486_±_0.005|
|dPF-M-lrn [8]|2.1001_±_0.012|1.4016_±_0.004|0.1720_±_0.010|0.0974_±_0.009|0.1848_±_0.004|0.0611_±_0.003|0.0693_±_0.011|
|DEnKF|**1.3329**_±_**0.043**|**1.1349**_±_**0.024**|**0.0249**_±_**0.001**|**0.0506**_±_**0.001**|**0.0460**_±_**0.002**|**0.0353**_±_**0.001**|0.0603_±_0.001|



Means _±_ standard errors. 

which is ∼54%, ∼41%, and ∼37% lower than that of dEKF, DPF, and dPF-M-lrn, respectively. Specifically, DEnKF reduces the translational error by ∼85%, ∼79%, and ∼75% for Test 100/200/400/800 compared to dEKF, DPF, and dPF-Mlrn. It also reduces the rotational error by ∼ ~~62%,~~ ∼ ~~51%,~~ and ∼42% for each baseline. Notably, dPF-M-lrn manifests the best performance among all the baselines, it implements learnable process noise model as described i ~~n~~ Eq. 4, and it uses a Gaussian Mixture Model for computing the likelihood for all particles. While dPF-M-lrn performs t ~~h~~ e best among all baselines, DEnKF shows higher tracking ~~acc~~ uracy than dPF-M-lrn and runs 0.009s faster. It is worth ~~not~~ ing that the inference time for dPF-M-lrn is higher than any other DF in Table II. 

**==> picture [245 x 65] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Without noise (b) With varied noise (c) Difference map<br>**----- End of picture text -----**<br>


Fig. 3: Different visual inputs during testing. (a) the raw observation; (b) the visual inputs with 2 types of noise: salt-and-pepper and blurring; (c) the difference map. 

**Noisy and missing observation:** According to [35], failures of vehicle cameras may compromise autonomous driving performance – potentially even leading to injuries and death. Common failures are listed by [35], i.e., brightness, blurred vision, and brackish. We conducted an evaluation of the performance of DEnKF and other DFs in the presence of noisy observations during inference. In Fig.3, we added salt-and-pepper and blurring effects to the test images, and reported the performance of DFs under these conditions in ~~T~~ ableIII (top and mid). Our findings show that DEnKF with ~~noise performs worse compared to DEnKF without~~ noise, ~~with a 17% and 29% increase in translational and~~ rotational error, respectively, compared to the metrics from Table II. However, DEnKF remains more robust against noise perturbations than dEKF, DPF, and dPF-M-lrn, achieving ∼80%, ∼66%, and ∼59% improvement on translational error with salt-and-pepper noise for Test 100/200/400/800. We also performed an experiment on missing observations by pro ~~vidin~~ g no visual input with a chance of 30% at every times ~~t~~ e ~~p. In~~ this case, DEnKF’s modularity allows the state transition model _f_ _**θ**_ to propagate the state forward through the st ~~ate space, whereas other RNN-based flters remain in~~ the same hidden state until an observation is processed. Error 

TABLE III: Result evaluations on different types of noisy visual input and with 30% missing observation. 

|||Test|100|Test 100/200/400/800|Test 100/200/400/800|
|---|---|---|---|---|---|
|||m/m|deg/m|m/m|deg/m|
|S&P Noise|dEKF<br>DPF<br>dPF-M-lrn<br>DEnKF|0.267<br>0.249<br>0.207<br>**0.029**|0.094<br>0.159<br>0.090<br>**0.089**|0.364<br>0.296<br>0.246<br>**0.102**|0.061<br>0.052<br>0.048<br>**0.039**|
|Blurring|dEKF<br>DPF<br>dPF-M-lrn<br>DEnKF|0.235<br>0.144<br>0.141<br>**0.028**|0.137<br>0.122<br>0.073<br>**0.064**|0.390<br>0.236<br>0.172<br>**0.054**|0.104<br>0.101<br>0.085<br>**0.050**|
|Missing|dEKF<br>DPF<br>dPF-M-lrn<br>DEnKF|0.254<br>0.245<br>0.204<br>**0.112**|0.173<br>0.165<br>0.116<br>**0.089**|0.298<br>0.273<br>0.230<br>**0.188**|0.134<br>0.131<br>0.093<br>**0.057**|



metrics for this scenario are reported in Table III (bottom), where we re-built the process model for each DFs to account for such problems. DEnKF’s incorporation of a stochastic neural network in the forward model handling missing observation scenarios outperforms other DFs, resulting in a reduction of ∼54% and ∼36% for translational and rotational error, respectively, compared to dPF-M-lrn. 

**==> picture [221 x 183] intentionally omitted <==**

**----- Start of picture text -----**<br>
0<br>1<br>0 50 100 150 200 250 300 350 400<br>0<br>2<br>0 50 100 150 200 250 300 350 400<br>1 Uncertainty<br>Prediction<br>0 GT<br>1<br>0 50 100 150 200 250 300 350 400<br>Timestep<br>Joint-1<br>Joint-2<br>Joint-3<br>**----- End of picture text -----**<br>


Fig. 4: Results on UR5 manipulation in simulation. Top: the robot joint configuration at varied timestep; Bottom: 3 key joint angle trajectory; The vertical lines mapping from the top to the bottom align the tracking results of the exact joint angle in time for each key joint. 

TABLE IV: Result evaluations on UR5 manipulation task measured in MAE from 3 different domains – real-world, simulation, and sim-to-real. Results for dEKF, dPF, and dPF-M-lrn are reproduced for detailed comparisons. 

|Method|Real-world<br>Joint (deg)<br>EE (cm)|Real-world<br>Joint (deg)<br>EE (cm)|Simulation<br>Joint (deg)<br>EE (cm)|Simulation<br>Joint (deg)<br>EE (cm)|Sim-to-real<br>Joint (deg)<br>EE (cm)|Sim-to-real<br>Joint (deg)<br>EE (cm)|Wall clock<br>time (s)|
|---|---|---|---|---|---|---|---|
|dEKF [8]|16.0862_±_0.063|5.6680_±_0.060|4.9357_±_0.224|1.9112_±_0.148|8.3041_±_0.525|4.3645_±_0.072|**0.0469**_±_**0.003**|
|DPF [9]|15.9302_±_0.080|5.0834_±_0.301|4.4623_±_0.220|1.5135_±_0.191|5.9531_±_0.031|3.9695_±_0.006|0.0515_±_0.002|
|dPF-M-lrn [8]|12.8366_±_0.086|3.9521_±_0.436|3.8233_±_0.230|1.2639_±_0.081|5.4389_±_0.011|3.9405_±_0.014|0.0854_±_0.001|
|DEnKF|**11.4222**_±_**0.005**|**3.4260**_±_**0.002**|**2.5587**_±_**0.093**|**0.8241**_±_**0.019**|**3.9531**_±_**0.034**|**2.6368**_±_**0.002**|0.0712_±_0.002|



Means _±_ standard errors. 

## _B. Robot Manipulation Task_ 

In the second experiment, we assess the efficacy of DEnKF in a challenging robot manipulation setting. Specifically, we train and employ DEnKF to monitor the state of a UR5 robot while performing tabletop arrangement tasks. Similar to behavioral cloning from observation tasks [36], actions are not provided in this experiment, and the DEnKF is trained to learn to propagate state over time. The robot state is defined as **x** = [ _J_ 1 _, · · · , J_ 7 _, x, y, z_ ] _[T]_ , where _J_ 1- _J_ 7 denote the 7 joint angle of the UR5 robot, and ( _x, y, z_ ) represents the 3D robot end-effector (EE) position w.r.t. (0 _,_ 0 _,_ 0) which is the center of the manipulation platform. As shown in Fig. 4(top), raw observations **y** _∈_ R[224] _[×]_[224] _[×]_[3] are images captured from a camera placed in front of the table. The learned observation **y** ˜ is defined to have the same dimension as the robot state, ˜ where **y** = [ _J_ 1 _, · · · , J_ 7 _, x, y, z_ ] _[T]_ . 

**Data:** The data collection process is conducted both in the MuJoCo [37] simulator and in the real-world. We record the UR5 robot operating on a random object by perf ~~o~~ rming one of “pick”, “push”, and “put down” actions. We ~~collect~~ 2,000 demonstrations in simulation and 100 on the real robot, changing the location of each object for each demonstration. We use ABR control and robosuite [38] in addition to MuJoCo to ensure rigorous dynamics in the simulator. Each sequence length is around 350 steps with 0.08 sec as the timestep. We use an 80/20 data split for training and testing. 

**Result:** We conduct a performance evaluation of DEnKF in three different domains, namely real-world, simulation, and sim-to-real. We train two separate DEnKFs on simulation and real-world datasets, respectively, and then perform simto-real transfer by fine-tuning the simulation-trained DEnKF on real-world data. State estimation with uncertainty measurement using distributed ensemble members in simulation is illustrated in Fig. 4. Following the same comparison protocol as in Sec. IV-A, we supply all DFs the same pre-trained sensor model _s_ _**ξ**_ in each domain, but no known motion model is enabled at this time. We train all learnable modules except _s_ _**ξ**_ and reported the mean absolute error (MAE) in the joint angle space (deg) and end-effector positions (cm) for DEnKFs and other DF baselines. The experimental results indicate that DEnKF and the other baseline DFs are capable of achieving domain adaptation by fine-tuning the simulation framework for real-world scenarios. Notably, the DEnKF with sim-to-real transfer achieves accurate state estimation, resulting in a reduction of 29% in MAE for joint angle space and 33% for end-effector (EE) positions when compared to 

**==> picture [241 x 119] intentionally omitted <==**

**----- Start of picture text -----**<br>
150<br>100<br>50<br>0<br>50<br>start end 50 25 0 25 50 75 100 100 50 0 50<br>Ensemble<br>GT<br>Prediction 200<br>150<br>100<br>50<br>0<br>50<br>100<br>40<br>start end 30 20 10 0 50 0 50 100 150 200<br>z cm<br>z cm<br>x cm<br>x cm<br>**----- End of picture text -----**<br>


Fig. 5: EE positions visualization. Top: UR5 executes “pick up” action; Bottom: UR5 executes “put down” action. 

**==> picture [246 x 84] intentionally omitted <==**

**----- Start of picture text -----**<br>
2.7 0.14<br>2.6 0.12<br>2.5 0.10<br>2.4 0.08<br>2.3 0.06<br>0 250 500 750 1000 1250 1500 1750 2000<br>Number of ensemble members<br>MAE (cm) C. time (s)<br>**----- End of picture text -----**<br>


Fig. 6: Computational time vs. MAE (EE position) with increasing number of ensemble members. 

the dPF-M-lrn. In Table IV, the DEnKF with sim-to-real transfer exhibits an average of 2.6cm offset (MAE) from the ground truth for EE positions across testing sequences. We further analyze the state tracking in EE space by visualizing the EE trajectories in 3D, as depicted in Fig. 5, where the fine-tuned DEnKF is utilized to estimate the state with two real-robot test examples of action sequence “pick up" and “put down". 

Moreover, an additional experiment is conducted to test the trade-off between the accuracy and computational performance of proposed DEnKF framework as shown in Fig. 6. Tellingly, increasing the number of ensemble members can have a substantial positive effect on performance (+9 _._ 6%) while the computational overhead is only marginally affected (increase from 0.075 sec to 0.134 sec). 

## V. CONCLUSIONS 

In this paper, we present the Differentiable Ensemble Kalman Filters (DEnKF) as an extended version of Ensemble Kalman Filters, and demonstrate their applications to state estimation tasks. We show that our framework is applicable in both simulation and real-world, and that it is capable of performing state estimation with complex tasks, e.g., KITTI visual odometry, and robot manipulation. We also 

discuss state tracking in high-dimensional observation spaces with varied noise conditions and missing observations. In particular, DEnKF manages to decrease the error metrics on translation and rotation by at least 59% and 36% with noisy observations versus the state-of-the-art approaches. These experiments manifest the DEnKF significantly improves the tracking accuracy and uncertainty estimates, thus, has great potential in many robotic applications. 

The proposed framework is modular, which allows for flexibility in using individual components separately. However, it should be noted that various learning tasks may require distinct curricula. For example, challenging visual tasks may necessitate an extended training period for the sensor model before it can be incorporated into end-to-end learning. Therefore, a universal curriculum that guarantees optimal performance of all sub-modules in every situation does not currently exist. In future research, we plan to explore the potential of the DEnKF framework in detecting perturbations as a downstream application. Specifically, leveraging the learned system dynamics from the state transition model and the mapping from observation to state space learned by the sensor model and the Kalman update step, we aim to use the distance between the outputs of the two steps to detect perturbations in the system. Overall, the results of this study suggest that DEnKF has great potential in many robotic applications. 

## ACKNOWLEDGMENT 

The authors gratefully acknowledge support of this work through a grant by “The Global KAITEKI Center” (TGKC) of the Global Futures Laboratory at Arizona State University. TGKC is a research alliance between Arizona State University and The KAITEKI Institute, an affiliate of the Mitsubishi Chemical Group. 

## REFERENCES 

- [1] S. Thrun, W. Burgard, and D. Fox, _Probabilistic robotics_ . Cambridge, Mass.: MIT Press, 2005. 

- [2] L. Wang, G. Wang, S. Jia, A. Turner, and S. Ratchev, “Imitation learning for coordinated human–robot collaboration based on hidden state-space models,” _Robotics and Computer-Integrated Manufacturing_ , vol. 76, p. 102310, 2022. 

- [3] S. Chen, “Kalman filter for robot vision: a survey,” _IEEE Transactions on industrial electronics_ , vol. 59, no. 11, pp. 4409–4420, 2011. 

- [4] J. Reher, W.-L. Ma, and A. D. Ames, “Dynamic walking with compliance on a cassie bipedal robot,” in _2019 18th European Control Conference (ECC)_ . IEEE, 2019, pp. 2589–2595. 

- [5] S. Thrun, “Probabilistic robotics,” _Communications of the ACM_ , vol. 45, no. 3, pp. 52–57, 2002. 

- [6] S. S. Rangapuram, M. W. Seeger, J. Gasthaus, L. Stella, Y. Wang, and T. Januschowski, “Deep state space models for time series forecasting,” in _Advances in Neural Information Processing Systems_ , S. Bengio, H. Wallach, H. Larochelle, K. Grauman, N. Cesa-Bianchi, and R. Garnett, Eds., vol. 31. Curran Associates, Inc., 2018. 

- [7] A. Klushyn, R. Kurle, M. Soelch, B. Cseke, and P. van der Smagt, “Latent matters: Learning deep state-space models,” _Advances in Neural Information Processing Systems_ , vol. 34, 2021. 

- [8] A. Kloss, G. Martius, and J. Bohg, “How to train your differentiable filter,” _Autonomous Robots_ , pp. 1–18, 2021. 

- [9] R. Jonschkowski, D. Rastogi, and O. Brock, “Differentiable particle filters: End-to-end learning with algorithmic priors,” _arXiv preprint arXiv:1805.11122_ , 2018. 

- [10] H. Sorenson, _Kalman Filtering: Theory and Application_ . IEEE Press, Los Alamitos, 1985. 

- [11] R. Van Der Merwe, _Sigma-point Kalman filters for probabilistic inference in dynamic state-space models_ . Oregon Health & Science University, 2004. 

- [12] T. Haarnoja, A. Ajay, S. Levine, and P. Abbeel, “Backprop kf: Learning discriminative deterministic state estimators,” in _Advances in neural information processing systems_ , 2016, pp. 4376–4384. 

- [13] P. Karkus, X. Ma, D. Hsu, L. P. Kaelbling, W. S. Lee, and T. LozanoPérez, “Differentiable algorithm networks for composable robot learning,” _arXiv preprint arXiv:1905.11602_ , 2019. 

- [14] A. Corenflos, J. Thornton, G. Deligiannidis, and A. Doucet, “Differentiable particle filtering via entropy-regularized optimal transport,” in _International Conference on Machine Learning_ . PMLR, 2021, pp. 2100–2111. 

- [15] X. Chen, H. Wen, and Y. Li, “Differentiable particle filters through conditional normalizing flow,” in _2021 IEEE 24th International Conference on Information Fusion (FUSION)_ . IEEE, 2021, pp. 1–6. 

- [16] Y. Wang, B. Liu, J. Wu, Y. Zhu, S. S. Du, L. Fei-Fei, and J. B. Tenenbaum, “Dualsmc: Tunneling differentiable filtering and planning under continuous pomdps,” _arXiv preprint arXiv:1909.13003_ , 2019. 

- [17] H. Wen, X. Chen, G. Papagiannis, C. Hu, and Y. Li, “End-to-end semi-supervised learning for differentiable particle filters,” in _2021 IEEE International Conference on Robotics and Automation (ICRA)_ . IEEE, 2021, pp. 5825–5831. 

- [18] M. A. Lee, B. Yi, R. Martín-Martín, S. Savarese, and J. Bohg, “Multimodal sensor fusion with differentiable filters,” in _2020 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)_ . IEEE, 2020, pp. 10 444–10 451. 

- [19] B. Wagstaff, E. Wise, and J. Kelly, “A self-supervised, differentiable kalman filter for uncertainty-aware visual-inertial odometry,” in _2022 IEEE/ASME International Conference on Advanced Intelligent Mechatronics (AIM)_ . IEEE, 2022, pp. 1388–1395. 

- [20] G. Evensen, “The ensemble kalman filter: Theoretical formulation and practical implementation,” _Ocean dynamics_ , vol. 53, no. 4, pp. 343– 367, 2003. 

- [21] M. Roth, G. Hendeby, C. Fritsche, and F. Gustafsson, “The ensemble kalman filter: a signal processing perspective,” _EURASIP Journal on Advances in Signal Processing_ , vol. 2017, no. 1, pp. 1–16, 2017. 

- [22] P. L. Houtekamer and F. Zhang, “Review of the ensemble kalman filter for atmospheric data assimilation,” _Monthly Weather Review_ , vol. 144, no. 12, pp. 4489–4532, 2016. 

- [23] L. V. Jospin, H. Laga, F. Boussaid, W. Buntine, and M. Bennamoun, “Hands-on bayesian neural networks—a tutorial for deep learning users,” _IEEE Computational Intelligence Magazine_ , vol. 17, no. 2, pp. 29–48, 2022. 

- [24] B. Lakshminarayanan, A. Pritzel, and C. Blundell, “Simple and scalable predictive uncertainty estimation using deep ensembles,” _Advances in neural information processing systems_ , vol. 30, 2017. 

- [25] K. Chua, R. Calandra, R. McAllister, and S. Levine, “Deep reinforcement learning in a handful of trials using probabilistic dynamics models,” _Advances in neural information processing systems_ , vol. 31, 2018. 

- [26] Y. Chen, D. Sanz-Alonso, and R. Willett, “Auto-differentiable ensemble kalman filters,” _arXiv preprint arXiv:2107.07687_ , 2021. 

- [27] S. Zhang, M. Harrison, A. Rosati, and A. Wittenberg, “System design and evaluation of coupled ensemble data assimilation for global oceanic climate studies,” _Monthly Weather Review_ , vol. 135, no. 10, pp. 3541–3564, 2007. 

- [28] P. B. Quang and V. Tran, “High-dimensional simulation experiments with particle filter and ensemble kalman filter,” _Applied Mathematics in Engineering and Reliability_ , p. 1, 2016. 

- [29] Y. Gal and Z. Ghahramani, “Dropout as a bayesian approximation: Representing model uncertainty in deep learning,” in _international conference on machine learning_ . PMLR, 2016, pp. 1050–1059. 

- [30] A. Geiger, P. Lenz, and R. Urtasun, “Are we ready for autonomous driving? the kitti vision benchmark suite,” in _2012 IEEE conference on computer vision and pattern recognition_ . IEEE, 2012, pp. 3354– 3361. 

- [31] K. Lenac, J. Cesi´c,[´] I. Markovi´c, and I. Petrovi´c, “Exactly sparse delayed state filter on lie groups for long-term pose graph slam,” _The International Journal of Robotics Research_ , vol. 37, no. 6, pp. 585– 610, 2018. 

- [32] J. Zhang and S. Singh, “Visual-lidar odometry and mapping: Lowdrift, robust, and fast,” in _2015 IEEE International Conference on Robotics and Automation (ICRA)_ . IEEE, 2015, pp. 2174–2181. 

- [33] C.-C. Chou and C.-F. Chou, “Efficient and accurate tightly-coupled visual-lidar slam,” _IEEE Transactions on Intelligent Transportation Systems_ , 2021. 

- [34] I. Cviši´c, J. Cesi´c,[´] I. Markovi´c, and I. Petrovi´c, “Soft-slam: Computationally efficient stereo visual simultaneous localization and mapping for autonomous unmanned aerial vehicles,” _Journal of field robotics_ , vol. 35, no. 4, pp. 578–595, 2018. 

- [35] A. Ceccarelli and F. Secci, “Rgb cameras failures and their effects in autonomous driving applications,” _IEEE Transactions on Dependable and Secure Computing_ , 2022. 

- [36] F. Torabi, G. Warnell, and P. Stone, “Behavioral cloning from observation,” _arXiv preprint arXiv:1805.01954_ , 2018. 

- [37] E. Todorov, T. Erez, and Y. Tassa, “Mujoco: A physics engine for model-based control,” in _2012 IEEE/RSJ International Conference on Intelligent Robots and Systems_ . IEEE, 2012, pp. 5026–5033. 

- [38] Y. Zhu, J. Wong, A. Mandlekar, and R. Martín-Martín, “robosuite: A modular simulation framework and benchmark for robot learning,” in _arXiv preprint arXiv:2009.12293_ , 2020. 

- [39] M. D. Butala, J. Yun, Y. Chen, R. A. Frazin, and F. Kamalabadi, “Asymptotic convergence of the ensemble kalman filter,” in _2008 15th IEEE International Conference on Image Processing_ . IEEE, 2008, pp. 825–828. 

- [40] I. Kasanick`y, “Ensemble kalman filter on high and infinite dimensional spaces,” _Univerzita Karlova, Matematicko-fyzikální fakulta_ , 2017. 

- [41] J. Mandel, _Efficient implementation of the ensemble Kalman filter_ . University of Colorado at Denver and Health Sciences Center, 2006. 

- [42] A. Hommels, A. Murakami, and S.-I. Nishimura, “A comparison of the ensemble kalman filter with the unscented kalman filter: application to the construction of a road embankment,” _Geotechniek_ , vol. 13, no. 1, p. 52, 2009. 

- [43] J. Mandel, L. Cobb, and J. D. Beezley, “On the convergence of the ensemble kalman filter,” _Applications of Mathematics_ , vol. 56, no. 6, pp. 533–541, 2011. 

- [44] G. Cybenko, “Approximation by superpositions of a sigmoidal function,” _Mathematics of control, signals and systems_ , vol. 2, no. 4, pp. 303–314, 1989. 

- [45] Z. Pu and J. Hacker, “Ensemble-based kalman filters in strongly nonlinear dynamics,” _Advances in atmospheric sciences_ , vol. 26, pp. 373–380, 2009. 

- [46] E. H. Bergou, S. Gratton, and J. Mandel, “On the convergence of a non-linear ensemble kalman smoother,” _Applied Numerical Mathematics_ , vol. 137, pp. 151–168, 2019. 

## APPENDIX 

## THEORETICAL PROPERTIES OF ENKF 

This section provides an overview of the theoretical underpinnings of Ensemble Kalman Filters (EnKF), outlines key differences between EnKF and Kalman Filters (KF), and highlights the significance of EnKF in practical applications. 

## _A. Asymptotic Convergence to KF_ 

Research in [39] has demonstrated that EnKF asymptotically converges to the optimal estimates provided by KF in a finite space. It is important to note that EnKF is a Monte Carlo algorithm that offers computationally tractable solutions to high-dimensional state estimation problems, which converge to KF [39]. 

## _B. Convergence in Hilbert Space_ 

The convergence of EnKF has been proven in [40] for infinite-dimensional state space models. Specifically, the proof shows that when a sequence of states **X** _t_ represents a system with stochastic dynamics defined on a Hilbert space and EnKF is applied, the empirical ensemble converges to the reference ensemble in _L[p]_ for all _p ∈_ [1 _, ∞_ ). The convergence in the infinite dimensional Hilbert space is an important insight in machine learning research, as it offers a theoretical 

foundation for the use of EnKF in high-dimensional state estimation problems. 

## _C. Computational Performance_ 

EnKF has a computational complexity of around _O_ ( _E_[2] _n_ ), where _E_ is the number of ensemble members and _n_ is the dimension of the state space, according to Mandel et al. [41]. In contrast, the computational complexity of the Extended Kalman Filter (EKF), an alternative filtering approach for non-linear systems, is _O_ ( _n_[3] ) [1]. One of the advantages of EnKF over EKF is that it does not require explicit construction of the covariance matrix since this information is implicitly captured by the ensemble. This reduces the computational and memory burden for large-scale estimation problems. 

## _D. Comparison with UKF_ 

The Unscented Kalman Filter (UKF) employs a set of sigma points that are propagated through the actual nonlinear function. These points are selected to match the mean, covariance, and higher-order moments of a Gaussian random variable. In some cases, UKF has the tendency to overestimate the state compared to EnKF, as illustrated in a an example in [42]. Still, both EnKF and UKF are effective state estimation methods for non-linear systems, and the choice of method should depend on the specific task at hand, in other words, the suitability of either method is determined by factors such as the complexity of the model, the availability of prior information, and the desired computational efficiency. 

## _E. Convergence of DEnKF_ 

Ensemble Kalman Filter (EnKF) are proven to converge in linear systems [43]. In the context of our _differentiable_ Ensemble Kalman Filters (DEnKF), the prediction step is substituted with a stochastic neural network for the state transition function, as introduced in Sec. III-A. **H** in Eq. 6 is learned through multi-layer perceptrons as part of the observation model. In theory, a neural network can act as a function approximator capable of modeling exact linear functions, which has been demonstrated by the universal approximation theorem [44]. Hence, the proposed state transition function can be approximated to any degree of accuracy when the dynamics model is linear, and this holds true for the observation model in DEnKF as it approximates a linear process. Accordingly, the DEnKF satisfies the criteria necessary for the linear EnKF convergence proof. With regards to nonlinear systems, there is no global convergence proof for the EnKF. However, in practice it is often the preferred filtering approach in this setting since it empirically demonstrates strong performance in a variety of applications with strong non-linearities [45]. In addition, recent work has shown that specific variants of the filter [46], i.e., the ensemble Kalman smoother, are proven to converge even in the nonlinear settings under certain assumptions. 

