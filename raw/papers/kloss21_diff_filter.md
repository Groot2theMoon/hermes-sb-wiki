## **How to Train Your Differentiable Filter** 

Alina Kloss[1] , Georg Martius[1] and Jeannette Bohg[1] _[,]_[2] 

_**Abstract**_ **— In many robotic applications, it is crucial to maintain a belief about the state of a system, which serves as input for planning and decision making and provides feedback during task execution. Bayesian Filtering algorithms address this state estimation problem, but they require models of process dynamics and sensory observations and the respective noise characteristics of these models. Recently, multiple works have demonstrated that these models can be learned by end-to-end training through differentiable versions of recursive filtering algorithms. In this work, we investigate the advantages of** _**differentiable filters**_ **(DFs) over both unstructured learning approaches and manually-tuned filtering algorithms, and provide practical guidance to researchers interested in applying such differentiable filters. For this, we implement DFs with four different underlying filtering algorithms and compare them in extensive experiments. Specifically, we (i) evaluate different implementation choices and training approaches, (ii) investigate how well complex models of uncertainty can be learned in DFs, (iii) evaluate the effect of end-to-end training through DFs and (iv) compare the DFs among each other and to unstructured LSTM models.** 

## I. INTRODUCTION 

In many robotic applications, it is crucial to maintain a belief about the state of the system over time, like tracking the location of a mobile robot or the pose of a manipulated object. These state estimates serve as input for planning and decision making and provide feedback during task execution. In addition to tracking the system state, it can also be desirable to estimate the uncertainty associated with the state predictions. This information can be used to detect failures and enables risk-aware planning, where the robot takes more cautious actions when its confidence in the estimated state is low [1, 2]. 

Recursive Bayesian filters are a class of algorithms that combine perception and prediction for probabilistic state estimation in a principled way. To do so, they require an observation model that relates the estimated state to the sensory observations and a process model that predicts how the state develops over time. Both have associated noise models that reflect the stochasticity of the underlying system and determine how much trust the filter places in perception and prediction. 

Formulating good observation and process models for the filters can, however, be difficult in many scenarios, especially when the sensory observations are high-dimensional and complex, like camera images. Over the last years, deep learning has become the method of choice for processing 

> 1 Max Planck Institute for Intelligent Systems, <akloss, gmartius>@tue.mpg.de 

> 2 Stanford University, bohg@stanford.edu The authors thank the International Max Planck Research School for Intelligent Systems (IMPRS-IS) for supporting Alina Kloss. 

such data. While (recurrent) neural networks can be trained to address the full state estimation problem directly, recent work [3, 4, 5, 6] showed that it is also possible to include data-driven models into Bayesian filters and train them end-to-end through the filtering algorithm. For Histogram filters [3], Kalman filters [4] and Particle filters [5, 6], the respective authors showed that such _differentiable filters_ (DF) systematically outperform unstructured neural networks like LSTMs [7]. In addition, the end-to-end training of the models also improved the filtering performance compared to using observation and process models that had been trained separately. 

A further interesting aspect of differentiable filters is that they allow for learning sophisticated models of the observation and process noise. This is useful because finding appropriate values for the noise models is often difficult and despite much research on identification methods (e.g. [8, 9]) they are often tuned manually in practice. To reduce the tedious tuning effort, the noise is then typically assumed to be uncorrelated Gaussian noise with zero mean and _constant_ covariance. Many real systems are, however, better described by _heteroscedastic_ noise models, where the level of uncertainty depends on the state of the system and/or possible control inputs. Taking heterostochasticity of the dynamics into account has been demonstrated to improve filtering performance in many robotic tasks [10, 11]. [4] also show that learning heteroscedastic observation noise helps a Kalman filter dealing with occlusions during object tracking. 

In this paper, we perform a thorough evaluation of differentiable filters. Our main goals are to highlight the advantages of DFs over both unstructured learning approaches and manually-tuned filtering algorithms, and to provide guidance to practitioners interested in applying differentiable filtering to their problems. 

To this end, we review and implement existing work on differentiable Kalman and Particle filters and introduce two novel variants of differentiable Unscented Kalman filters. Our implementation for TensorFlow [12] is publicly available[1] . In extensive experiments on three different tasks, we compare the DFs and evaluate different design choices for implementation and training, including loss functions and training sequence length. We also investigate how well the different filters can learn complex heteroscedastic and correlated noise models, evaluate how end-to-end training through the DFs influences the learned models and compare the DFs to unstructured LSTM models. 

1https://github.com/akloss/differentiable_filters 

## II. RELATED WORK 

## _A. Combining Learning and Algorithms_ 

Integrating algorithmic structure into learning methods has been studied for many robotic problems, including state estimation [4, 3, 5, 6, 13], planning [14, 15, 16, 17, 18] and control [19, 20, 21, 22, 23]. Most notably, [24] combine multiple differentiable algorithms into an end-to-end trainable “Differentiable Algorithm Network” to address the complete task of navigating to a goal in a previously unseen environment using visual observations. Here, we focus on addressing the state estimation problem with differentiable implementations of Bayesian filters. 

## _B. Differentiable Bayesian Filters_ 

There have been few works on differentiable filters so far. [4] propose the BackpropKF, a differentiable implementation of the (extended) Kalman filter. [3] present a differentiable Histogram filter for discrete localization tasks in one or two dimensions and [5] and [6] both implement differentiable Particle filters for localization and tracking of a mobile robot. In the following, we focus our discussion on differentiable Kalman and Particle filters, since Histogram filters as used by [3] are usually not feasible in practice, due to the need of discretizing the complete state space. 

_a) Observation Model and Noise:_ All three works have in common that the raw observations are processed by a learned neural network that can be trained end-toend through the filter. In [4], the network outputs a lowdimensional representation of the observations together with input-dependent observation noise (see Sec. IV-B), while in [5, 6], a neural network learns to predict the likelihood of the observations under each particle given an image and (in [6]) a map of the environment. 

As a result, all three works use heteroscedastic observation noise, but only [4] evaluate this choice: They show that conditioning the observation noise on the raw image observations drastically improves filter performance when the tracked object can be occluded. 

_b) Process Model and Noise:_ For predicting the next state, all three works use a given analytical process model. While [4] and [6] also assume known process noise, [5] train a network to predict it conditioned on the actions. The effect of learning action dependent process noise is, however, not evaluated. 

_c) Effect of End-to-End Learning:_ [5] compare the results of an end-to-end trained filter with one where the observation model and process noise were trained separately. The end-to-end trained variant performs better, presumably because it learns to overestimate the process noise. Possible differences between the learned observation models are not discussed. The best performance for the filter could be reached by first pretraining the models individually and the finetuning end-to-end through the filter. 

_d) Comparison to Unstructured Models:_ All works compare their differentiable filters to LSTM models trained for the same task and find that including the structural priors 

of the filtering algorithm and the known process models improves performance. [5] also evaluate a Particle filter with a learned process model in one experiment, which performs worse than the filter with an analytical process model but still beats the LSTM. 

In contrast to the existing work on differentiable filtering, the main purpose of this paper is not to present a new method for solving a robotic task. Instead, we present a thorough evaluation of differentiable filtering and of implementation choices made by the aforementioned seminal works. We also implement two novel differentiable filters based on variants of the Unscented Kalman filter and compare the differentiable filters with different underlying Bayesian filtering algorithms in a controlled way. 

## _C. Variational Inference_ 

A second line of research closely related to differentiable filters is variational inference in temporal state space models [25, 26, 27, 28, 29]. For a recent review of this work, see [30]. In contrast to DFs, the focus of this research lies more on finding generative models that explain the observed data sequences and are able to generate new sequences. The representation of the underlying state of the system is often not assumed to be known. But even though the goals are different, recent results in this field show that structuring the variational models similarly to Bayesian filters improves their performance [26, 28, 31, 32, 33]. 

## III. BAYESIAN FILTERING FOR STATE ESTIMATION 

Filtering refers to the problem of estimating the latent state **x** of a stochastic dynamic system at time step _t_ given an initial belief bel( **x** 0) = _p_ ( **x** 0), a sequence of observations **z** 1 _...t_ and actions **u** 0 _...t−_ 1. Formally, we seek the posterior distribution bel( **x** _t_ ) = _p_ ( **x** _t|_ **x** 0 _...t−_ 1 _,_ **u** 0 _...t−_ 1 _,_ **z** 1 _...t_ ). 

Bayesian Filters make the Markov assumption, i.e. that the distributions of the future states and observations are conditionally independent from the history of past states and observations given the current state. This assumption makes it possible to compute the belief at time _t_ recursively as 

**==> picture [231 x 37] intentionally omitted <==**

where _η_ is a normalization factor. Computing bel( **x** _t_ ) is referred to as the _prediction step_ of Bayesian filters, while updating the belief with _p_ ( **z** _t|_ **x** _t_ ) is called _(observation) update step_ . 

For the prediction step, the dynamics of the system is modeled by the _process model f_ that describes how the state changes over time. The observation update step uses an _observation model h_ that generates observations given the current state: 

**==> picture [191 x 11] intentionally omitted <==**

The random variables **q** and **r** are the process and observation noise and capture the stochasticity of the system. 

In this paper, we investigate differentiable versions of four different nonlinear Bayesian filtering algorithms: The Extended Kalman Filter (EKF), the Unscented Kalman Filter (UKF), a sampling-based variant of the UKF that we call Monte Carlo Unscented Kalman Filter (MCUKF) and the Particle Filter (PF). We briefly review these algorithms in Appendix I. 

## IV. IMPLEMENTATION 

In this section, we describe how we embed model-learning into differentiable versions of the aforementioned nonlinear filtering algorithms. These differentiable versions will be denoted by dEKF, dUKF etc. in the following. 

## _A. Differentiable Filters_ 

We implement the filtering algorithms as recurrent neural network layers in TensorFlow. For UKF and MCUKF, this is straight-forward, since all necessary operations are differentiable and available in TensorFlow. 

In contrast, the dEKF requires the Jacobian of the process model **F** . TensorFlow implements a method for computing Jacobians, with or without vectorization. The former is fast but has a high memory demand, while the latter can become very slow for large batch sizes. Therefore, we recommend to derive the Jacobians manually where applicable. 

_1) dPF:_ The Particle filter is the only filter we investigate that is not fully differentiable: In the resampling step, a new set of particles with uniform weights is drawn (with replacement) from the old set according to the old particle weights. While the drawn particles can propagate gradients to their ancestors, gradient propagation to other old particles or to the weights of the old particle set is disrupted [5, 6, 34]. If we place the resampling step at the beginning of the per-timestep computations, this only affects the gradient propagation through time, i.e. from one timestep _t_ + 1 to its predecessor _t_ . At time _t_ , both particles and weights still receive gradient information about the corresponding loss at this timestep. We therefore hypothesize that the missing gradients through time are not problematic as long as we provide a loss at every timestep. 

As an alternative to simply ignoring the disrupted gradients, we can also apply the resampling step less frequently or use soft resampling as proposed by [6]. We evaluate these options in Sec. VI-B.5. 

In addition, we investigate two alternative implementation choices for the dPF: The likelihood used for updating the particle weights in the observation update step can be implemented either with an analytical Gaussian likelihood function or with a trained neural network as in [5] and [6]. The learned observation likelihood is potentially more expressive than the analytical solution and can be advantageous for problems where formulating the observation and sensor model is not as straight-forward as in our experiments. A potential drawback is that in contrast to the analytical solution, no explicit noise model or sensor network is learned. We compare these two options in Sec. VI-B.4. 

## _B. Observation Model_ 

In Bayesian filtering, the observation model _h_ ( _·_ ) is a _generative_ model that predicts observations from the state **z** _t_ = _h_ ( **x** _t_ ). In practice, it is often hard to find such models that directly predict the potentially high-dimensional raw sensory signals without making strong assumptions. 

We therefore use the method first proposed by [4] and train a _discriminative_ neural network _ns_ with parameters **w** _s_ to preprocess the raw sensory data **D** and create a more compact representation of the observations **z** = _ns_ ( **D** _,_ **w** _s_ ). This network can be seen as a virtual sensor, and we thus call it _sensor network_ . In addition to **z** _t_ , the sensor network can also predict the heteroscedastic observation noise covariance matrix **R** _t_ (see Sec. IV-D) for the current input **D** _t_ . 

In our experiments, **z** contains a subset of the state vector **x** . The actual observation model _h_ ( **x** ) thus reduces to a simple linear selection matrix of the observable components, which we provide to the DFs. 

## _C. Process Model_ 

Depending on the user’s knowledge about the system, the process model _f_ ( _·_ ) for the prediction step can be implemented using a known analytical model or a neural network _np_ ( _·_ ) with weights **w** _p_ . When using neural networks, we train _np_ ( _·_ ) to output the change from the last state _np_ ( **x** _t,_ **u** _t,_ **w** _p_ ) = ∆ **x** _t_ such that **x** _t_ +1 = **x** _t_ + ∆ **x** _t_ . This form ensures stable gradients between timesteps (since _∂∂_ **xx** _t_ + _t_ 1 = 1 + _∂[∂]_ **x** _[p] t_[)][and][provides][a][reasonable][initialization][of] the process model close to identity. 

## _D. Noise Models_ 

For learning the observation and process noise, we consider two different conditions: constant and heteroscedastic. In both cases, we assume that the process and observation noise at time _t_ can be described by zero-mean Gaussian distributions with covariance matrices **Q** _t_ and **R** _t_ . 

A common assumption in state-space modeling is that **Q** _t_ and **R** _t_ are diagonal matrices, but we can also use full covariance matrices to model correlated noise. In this case, we follow [4] and train the noise models to output uppertriangular matrices **L** _t_ , such that e.g. **Q** _t_ = **L** _t_ **L** _[T] t_[. This form] ensures that the resulting matrices are positive definite. 

For constant noise, the filters directly learn the diagonal or triangular elements of **Q** and **R** . In the heteroscedastic case, **Q** _t_ is predicted from the current state **x** _t_ and (if available) the control input **u** _t_ by a neural network _nq_ ( **x** _t,_ **u** _t,_ **w** _q_ ) with weights **w** _q_ . In dUKF, dMCUKF and dPF, _nq_ ( _·_ ) outputs separate **Q** _[i]_ for each sigma point/particle and **Q** _t_ is computed as their weighted mean. The heteroscedastic observation noise covariance matrix **R** _t_ is an additional output of the sensor model _ns_ ( **D** _t,_ **w** _s_ ). 

We initialize the diagonals **Q** _t_ and **R** _t_ close to given target values by adding a trainable bias variable to the output of the noise models. To prevent numerical instabilities, we also add a small fixed bias to the diagonals as a lower bound for the predicted noise. 

## _E. Loss Function_ 

For training the filters, we always assume that we have access to the ground truth trajectory of the state **x** _[l] t_ =0 _...T_[.] In our experiments, we test the two different loss functions used in related work: The first, used by [6] is simply the mean squared error (MSE) between the mean of the belief and true state at each timestep: 

**==> picture [199 x 30] intentionally omitted <==**

For the dPF, we compute _µ_ as the weighted mean of the particles. 

The second loss function, used by [4] and [5], is the negative log likelihood (NLL) of the true state under the predicted distribution of the belief. In dEKF, dUKF and dMCUKF, the belief is represented by a Gaussian distribution with mean _**µ** t_ and covariance **Σ** _t_ and the negative log likelihood is computed as 

**==> picture [241 x 30] intentionally omitted <==**

The dPF represents its belief using the particles _**χ** i ∈_ **X** and their weights _πi_ . We consider two alternative ways of calculating the NLL for training the dPF: The first is to represent the belief by fitting a single Gaussian to the particles, with _**µ**_ =[�] _[N] i_ =0 _[π][i]_ _**[χ]** i_[and] **[Σ]**[ =][ �] _[N] i_ =0 _[π][i]_[(] _**[χ]** i[−]_ _**[µ]**_[)(] _**[χ]** i[−]_ _**[µ]**_[)] _[T]_ and then apply Eq. 2. We refer to this variant as dPF-G. 

However, this is only a good representation of the belief if the distribution of the particles is unimodal. To better reflect the potential multimodality of the particle distribution, the belief can also be represented with a Gaussian Mixture Model (GMM) as proposed by [5]. Every particle contributes a separate Gaussian _Ni_ ( _**χ**[i] ,_ **Σ** ) in the GMM and the mixture weights are the particle weights. The drawback of this approach is that the fixed covariance **Σ** of the individual distributions is an additional tuning parameter for the filter. We call this version dPF-M and calculate the negative log likelihood with 

**==> picture [244 x 41] intentionally omitted <==**

## V. EXPERIMENTAL SETUP 

In the following, we will evaluate the DFs on three different filtering problems. We start with a simple simulation setting that gives us full control over parameters of the system such as the true process noise (Sec. VI). In Sections VII and VIII, we then study the performance of the DFs on two real-robot tasks: The first is the KITTI Visual Odometry problem, where the filters are used to track the position and heading of a moving car given only RGB images. The second is planar pushing, where the filters track the pose of an object while a robot performs a series of pushes. 

Unless stated otherwise, we will train the DFs end-to-end for 15 epochs using the Adam optimizer [35] and select the 

**==> picture [111 x 111] intentionally omitted <==**

**==> picture [111 x 111] intentionally omitted <==**

Fig. 1: Two sequential observations from our simulated tracking task. The filters need to track the red disc, which can be occluded by the other discs or leave the image temporarily. 

model state at the training step with the best validation loss for evaluation. We also evaluate different learning rates for all DFs. During training, the initial state is perturbed with noise sampled from a Normal distribution _N_ init(0 _,_ **Σ** init). For testing, we evaluate all DFs with the true initial state as well as with few fixed perturbations (sampled from _N_ init) and average the results. 

More detailed information about the experimental conditions as well as extended results can be found in Appendix IIA-IV. 

## VI. SIMULATED DISC TRACKING 

We first evaluate the DFs in a simulated environment similar to the one in [4]: the task is to track a red disc moving among varying numbers of distractor discs, as shown in Figure 1. The state consists of the position **p** and linear velocity **v** of the red disc. 

The dynamics model that we use for generating the training data is 

**==> picture [167 x 25] intentionally omitted <==**

The velocity update contains a force that pulls the discs towards the origin ( _fp_ = 0 _._ 05) and a drag force that prevents too high velocities ( _fd_ = 0 _._ 0075). **q** represents the Gaussian process noise and sgn( _x_ ) returns the sign of _x_ or 0 if _x_ = 0. 

The sensor network receives the current image at each step, from which it can estimate the position but not the velocity of the target. As we do not model collisions, the red disc can be occluded by the distractors or leave the image temporarily. 

## _A. Data_ 

We create multiple datasets with varying numbers of distractors, different levels of constant process noise for the disc position and constant or heteroscedastic process noise for the disc velocity. All datasets contain 2400 sequences for training, 300 validation sequences and 303 sequences for testing. The sequences have 50 steps and the colors and sizes of the distractors are drawn randomly for each sequence. 

## _B. Filter Implementation and Parameters_ 

We first evaluated different design choices and filterspecific parameters for the DFs to find settings that perform well and increase the stability of the filters during training. For detailed information about the experiments and results, please refer to Appendix II-B. 

_1) dUKF:_ The dUKF has three filter-specific scaling parameters, _α_ , _κ_ and _β_ . _α_ and _κ_ determine how far from the mean of the belief the sigma points are placed and how the mean is weighted in comparison to the other sigma points. _β_ only affects the weight of the central sigma point when computing the covariance of the transformed distribution. 

We evaluated different parameter settings but found no significant differences between them. In all following experiments, we use _α_ = 1, _κ_ = 0 _._ 5 and _β_ = 0. In general, we recommend values for which _λ_ = _α_[2] ( _κ_ + _n_ ) _− n_ is a small positive number, so that the sigma points are not spread out too far and the central sigma point is not weighted negatively (which happens for negative _λ_ ). See Appendix I-C for a more detailed explanation. 

_2) dMCUKF:_ In contrast to the dUKF, the dMCUKF simply samples pseudo sigma points from the current belief. Its only parameter thus is the number _N_ of sampled points during training and testing. 

We trained the dMCUKF with _N ∈{_ 5 _,_ 10 _,_ 50 _,_ 100 _,_ 500 _}_ and evaluated with 500 pseudo sigma points. The results show that as few as ten sigma points are enough for training the dMCUKF relatively successfully. The best results are obtained with 100 sigma points and using more does not reliably increase the performance. 

In the following, we use 100 points for training and 500 for testing. More complex problems with higher-dimensional states could, however, require more sigma points. 

_3) dPF: Belief Representation:_ When training the dPF on _L_ NLL, we have to choose how to represent the belief of the filter for computing the likelihood (see Sec. IV-E). We investigate using a single Gaussian (dPF-G) or a Gaussian Mixture Model (dPF-M). For the dPF-M, the covariance **Σ** of the single Gaussians in the Mixture Model is an additional parameter that has to be tuned. 

As our test scenario does not require tracking multiple hypotheses, the representation by a single Gaussian in dPFG should be accurate for this task. Nonetheless, we find that the dPF-G performs much worse than the dPF-M. This could either mean that Eq. 3 facilitates training or that approximating the belief with a single Gaussian removes useful information even when the task does not obviously require tracking multiple hypotheses. Interestingly, when using a learned observation update, this effect is not noticeable, which suggests that the first hypothesis is correct. In the following, we only report results for the dPF-M. Results for dPF-G can be found in the Appendix. 

For the dPF-M, **Σ** = 0 _._ 25 **I** 4 ( **I** 4 denotes an identity matrix with 4 rows and columns) resulted in the best tracking errors, but the best NLL was achieved with **Σ** = **I** 4. We thus use **Σ** = **I** 4 for the dPF-M in all following experiments. It is, 

however, possible that different tasks could require different settings. 

_4) dPF: Observation Update:_ As mentioned before, the likelihood for the observation update step of the dPF can be implemented with an analytical Gaussian likelihood function (dPF-(G/M)) or with a neural network (dPF-(G/M)-lrn). 

Our experiments showed that using a learned likelihood function for updating the particle weights can improve both tracking error and NLL of the dPF significantly. We attribute this mainly to the fact that the learned update relaxes some of the assumptions encoded in the particle filter: With the analytical version, we restrict the filter to use additive Gaussian noise that is either constant or depends only on the raw sensory observations. The learned update, in contrast, enforces no functional form of the noise model. In addition, the noise can depend not only on the raw sensory data, but also on the observable components of the particle states. This means that the learned observation update is potentially much more expressive than the analytical one, which pays off when the Gaussian assumption made by the other filtering algorithms does not hold. 

While learning the observation update improves the performance of the dPF, we will still use the analytical variant in most of the following evaluations. The main reason for this is that the analytical observation update has explicit models for the sensor network and observation noise. This facilitates comparing between the dPF and the other DF variants and gives us control over the form of the learned observation noise. 

_5) dPF: Resampling:_ The resampling step of the particle filter discards particles with low weights and prevents particle depletion. It may, however, be disadvantageous during training since it is not fully differentiable. [6] proposed soft resampling, where the resampling distribution is traded off with a uniform distribution to enable gradient flow between the weights of the old and new particles. This trade-off is controlled by a parameter _α_ re _∈_ [0 _,_ 1]. The higher _α_ re, the more weight is put on the uniform distribution. An alternative to soft resampling is to not resample at every timestep. 

We tested the dPF-M with different values of _α_ re and when resampling every 1, 2, 5 or 10 steps and found that resampling frequently generally improves the filter performance. Soft resampling also did not have much of a positive effect in our experiments, presumably because higher values of _α_ re decrease the effectiveness of the resampling step. In the following, we use _α_ re = 0 _._ 05 and resample at every timestep. 

_6) dPF: Number of Particles:_ Finally, the user also has to decide how many particles to use during training and testing. As for the dMCUKF, we trained the dPF-M with _N ∈{_ 5 _,_ 10 _,_ 50 _,_ 100 _,_ 500 _}_ . The results were very similar to dMCUKF and we also use 100 particles during training and 500 particles for testing. 

## _C. Loss Function_ 

In this experiment we compare the different loss functions introduced in Sec. IV-E, as well as a combination of the two 

**==> picture [485 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
tracking RMSE observation RMSE -log likelihood<br>15 15 30<br>10 10 20<br>5 5 10<br>0 0 0<br>L MSE L mix L NLL<br>dEKF dUKF dMCUKF dPF-M dEKF dUKF dMCUKF dPF-M dEKF dUKF dMCUKF dPF-M<br>**----- End of picture text -----**<br>


Fig. 2: Results on disc tracking: Performance of the DFs when trained with different loss functions _L_ MSE, _L_ NLL or _L_ mix averaged over all steps in the trajectory. The first plot shows the RSME of the estimated state while the second shows the difference between the output of the sensor network and the corresponding ground truth state components. The negative log likelihood is computed as shown in Eq. 2 or Eq. 3 for the dPF-M. 

**==> picture [489 x 110] intentionally omitted <==**

**----- Start of picture text -----**<br>
20 20<br>10 10<br>0 0<br>1 2 5 10 25 50 1 2 5 10 25 50<br>training sequence length training sequence length<br>dEKF dUKF dMCUKF dPF-M<br>RMSE likelihood<br>-log<br>**----- End of picture text -----**<br>


Fig. 3: Results on disc tracking: Performance of the DFs trained with different sequence lengths. The cut-off NLL values for sequence length 1 are 47.4 _±_ 3.9 for the dUKF and 79.0 _±_ 2.7 for the dPF-M. 

_L_ mix = 0 _._ 5( _L_ MSE + _L_ NLL). Our hypothesis is that _L_ NLL is better suited for learning noise models, since it requires predicting the uncertainty about the state, while _L_ MSE only optimizes the tracking performance. 

_a) Experiment:_ We use a dataset with 15 distractors and constant process noise ( _σqp_ = 0 _._ 1, _σqv_ = 2). The filters learn the sensor and process model as well as heteroscedastic observation noise and constant process noise models. 

_b) Results:_ As expected, training on _L_ NLL leads to much better likelihoods scores than training on _L_ MSE for all DFs, see Fig. 2. The best tracking errors on the other hand are reached with _L_ MSE, as well as more precise sensor models. 

For judging the quality of a DF, both NLL and tracking error should be taken into account: While a low RMSE is important for all tasks that use the state estimate, a good likelihood means that the uncertainty about the state is communicated correctly, which enables e.g. risk-aware planning and failure detection. 

The combined loss _L_ mix trades off these two objectives during training. It does, however, not outperform the single losses in their respective objective. A possible explanation is that they can result in opposing gradients: All DFs tend to overestimate the process noise when trained only on _L_ MSE. This lowers the tracking error by giving more weight to the observations in dEKF, dUKF and dMCUKF and allowing more exploration in the dPF. But it also results in a higher uncertainty about the state, which is undesirable 

when optimizing the likelihood. 

We generally recommend using _L_ NLL during training to ensure learning accurate noise models. If learning the process and sensor model does not work well, _L_ NLL can either be combined with _L_ MSE or the models can be pretrained. 

## _D. Training Sequence Length_ 

[6] evaluated training their dPF on sequences of length _k ∈ {_ 1 _,_ 2 _,_ 4 _}_ and found that using more steps improved results. Here, we want to test if increasing the sequence length even further is beneficial. However, longer training sequences also mean longer training times (or more memory consumption). We thus aim to find a value for _k_ with a good trade off between training speed and model performance. 

_a) Experiment:_ We evaluate the DFs on a dataset with 15 distractors and constant process noise ( _σqp_ = 0 _._ 1, _σqv_ = 2). The filters learn the sensor and process model as well as heteroscedastic observation noise and constant process noise models. We train using _L_ NLL on sequence lengths _k ∈{_ 1 _,_ 2 _,_ 5 _,_ 10 _,_ 25 _,_ 50 _}_ while keeping the total number of examples per batch (steps _×_ batch size) constant. 

_b) Results:_ Our results in Figure 3 show that all filters benefit from longer training sequences much more than the results in [6] indicated. However, while only one time step is clearly too little, returns diminish after around ten steps. 

Why are longer training sequences helpful? One issue with short sequences is that we use noisy initial states during training. This reflects real-world conditions, but the 

noisy inputs hinder learning the process model. On longer sequences, the observation updates can improve the state estimate and thus provide more accurate input values. 

We repeated the experiment without perturbing the initial state, but the results with _k ∈{_ 1 _,_ 2 _}_ got even worse: Since the DFs could now learn accurate process models, they did not need the observations to achieve a low training loss and thus did not learn a proper sensor model. On the longer test sequences, however, even small errors from the noisy dynamics accumulate over time if they are not corrected by the observations. 

To summarize, longer sequences are beneficial for training DFs, because they demonstrate error accumulation during filtering and allow for convergence of the state estimate when the initial state is noisy. However, performance eventually saturates and increasing _k_ also increased our training times. We therefore chose _k_ = 10 for all experiments, which provides a good trade-off between training speed and performance. 

TABLE I: Results for disc tracking: End-to-end learning of the noise models through the DFs on datasets with 30 distractors and different levels of process noise. While **Q** is always constant, we evaluate learning constant (const.) or heteroscedastic (hetero) observation noise **R** . We show the tracking error (RMSE), negative log likelihood (NLL), the correlation coefficient between predicted **R** and the number of visible pixels of the target disc (corr.) and the Bhattacharyya distance between true and learned process noise model ( _D_ **Q** ). The best results per DF are highlighted in bold. 

||R<br>RMSE<br>NLL<br>corr.<br>_D_**Q**|
|---|---|
|dEKF<br>dUKF<br>dMCUKF<br>dPF-M|const.<br>16.2<br>14.0<br>-<br>0.121<br>hetero.<br>**8.8**<br>**10.7**<br>-0.78<br>**0.002**|
||const.<br>16.8<br>14.1<br>-<br>0.161<br>hetero.<br>**8.8**<br>**10.7**<br>-0.78<br>**0.013**|
||const.<br>16.7<br>14.1<br>-<br>0.152<br>hetero.<br>**9.0**<br>**10.9**<br>-0.78<br>**0.006**|
||const.<br>16.1<br>34.3<br>-<br>0.435<br>hetero.<br>**9.6**<br>**20.8**<br>-0.77<br>**0.280**|



## _E. Learning Noise Models_ 

The following experiments analyze how well complex models of the process and observation noise can be learned through the filters and how much this improves the filter performance. To isolate the effect of the noise models, we use a fixed, pretrained sensor model and the true analytical process model, such that only the noise models are trained. We initialize **Q** and **R** with **Q** = **I** 4 and **R** = 100 **I** 2. All DFs are trained on _L_ NLL. 

Appendix II-C contains extended experimental results on additional datasetsas well as data for the dPF-G. 

_1) Heteroscedastic Observation Noise:_ We first test if learning more complex, heteroscedastic observation noise models improves the performance of the filters as compared to learning constant noise models. For this, we compare DFs that learn constant or heteroscedastic observation noise (the process noise is constant) on a dataset with constant process noise ( _σqp_ = 3, _σqv_ = 2) and 30 distractors. 

To measure how well the predicted observation noise reflects the visibility of the target disc, we compute the correlation coefficient between the predicted **R** and the number of visible target pixels. We also evaluate the similarity between the learned and the true process noise model using the Bhattacharyya distance. 

_a) Results:_ Results are shown in Table I. When learning constant observation noise, all DFs perform relatively bad in terms of the tracking error. Upon inspection, we find that all filters learn a very high **R** and thus mostly rely on the process model for their prediction. For example, the dEKF predicts _σrp_ = 25 _._ 4. This is expected, since trusting the observations would result in wrong updates to the mean state estimate when the target disc is occluded. 

Like [4], we find that heteroscedastic observation noise significantly improves the tracking performance of all DFs (except for the dPF-M). The strong negative correlation between **R** and the visible disc pixels shows that the DFs 

**==> picture [232 x 150] intentionally omitted <==**

**----- Start of picture text -----**<br>
6<br>4<br>2<br>0<br>4<br>2<br>0<br>1 5 9 13 17 21 25 29 33 37 41 45 49<br>t<br>true predicted x predicted y<br>position<br>q<br>σ<br>velocity<br>q<br>σ<br>**----- End of picture text -----**<br>


Fig. 4: Predicted and true process noise from the dEKF over one test sequence of the disc tracking task. Our model predicts separate values for the x and y-coordinates of position and velocity, but the ground truth process noise has the same _σ_ for both coordinates. 

correctly predict higher uncertainty when the target is occluded. For example, the dEKF predicts values as low as _σrp_ = 0 _._ 9 when the disc is perfectly visible and as high as _σrp_ = 29 _._ 3 when it is fully occluded. 

Finally, all DFs learn values of **Q** that are close to the ground truth. For dEKF, dUKF and dMCUKF, the results improve significantly when heteroscedastic observation noise is learned. This could be because the worse tracking performance with constant observation noise impedes learning an accurate process model and thus requires higher process noise. 

_2) Heteroscedastic Process Noise:_ The effect of learning heteroscedastic process noise has not yet been evaluated in related work. We create datasets with heteroscedastic ground truth process noise, where the magnitude of **q** _v_ increases in three steps the closer to the origin the disc is. The positional process noise **q** _p_ remains constant ( _σqp_ = 3 _._ 0). 

TABLE II: Results on disc tracking: End-to-end learning of constant or heteroscedastic process noise **Q** on datasets with 30 distractors and heteroscedastic or constant ( _σqp_ = 3 _._ 0, _σqv_ = 2 _._ 0) process noise. _D_ **Q** is the Bhattacharyya distance between true and learned process noise. The best results per DF are highlighted in bold. 

|dEKF<br>dUKF<br>dMCUKF<br>dPF-M|heteroscedastic noise<br>constant noise<br>Q<br>RMSE<br>NLL<br>_D_**Q**<br>RMSE<br>NLL<br>_D_**Q**|
|---|---|
||const.<br>8.09<br>11.620<br>0.879<br>8.80<br>10.687<br>**0.002**<br>hetero.<br>**7.36**<br>**11.289**<br>**0.402**<br>**8.77**<br>**10.684**<br>0.033|
||const.<br>7.85<br>11.318<br>0.874<br>8.80<br>10.743<br>**0.013**<br>hetero.<br>**7.60**<br>**11.167**<br>**0.391**<br>**8.68**<br>**10.727**<br>0.030|
||const.<br>8.13<br>11.493<br>0.891<br>8.98<br>10.898<br>**0.006**<br>hetero.<br>**7.45**<br>**11.321**<br>**0.464**<br>**8.73**<br>**10.739**<br>0.044|
||const.<br>8.48<br>15.232<br>1.072<br>**9.61**<br>20.789<br>**0.280**<br>hetero.<br>**8.23**<br>**14.725**<br>**0.787**<br>9.76<br>**19.833**<br>0.413|



We compare the performance of DFs that learn constant and heteroscedastic process noise while he observation noise is heteroscedastic in all cases. 

_a) Results:_ As shown in Table II, learning heteroscedastic models of the process noise is a bit more difficult than for the observation noise. This is not surprising, as the input values for predicting the process noise are the noisy state estimates. 

Plotting the predicted values for **Q** (see Fig. 4 for an example from the dEKF) reveals that all DFs learn to follow the real values for the heteroscedastic velocity noise relatively well, but also predict state dependent values for **q** _p_ , which is actually constant. This could mean that the models have difficulties distinguishing between **q** _p_ and **q** _v_ as sources of uncertainty about the disc position. However, we see the same behavior also on a dataset with constant ground truth process noise. We thus assume that the models rather pick up an unintentional pattern in our data: The probability of the disc being occluded turned out to be higher in the middle of the image. The filters react to this by overestimating **q** _p_ in the center, which results in an overall higher uncertainty about the state in regions where occlusions are more likely. 

Despite not being completely accurate, learning heteroscedastic noise models still increases performance of all DFs by a small but reliable value. Even when the groundtruth process noise model is constant, most of the DFs were able to improve their RSME and likelihood scores slightly by learning “wrong” heteroscedastic noise models. 

_3) Correlated Noise:_ So far, we have only considered noise models with diagonal covariance matrices. In this experiment, we want to see if DFs can learn to identify correlations in the noise. We compare the performance of DFs that learn noise models with diagonal or full covariance matrix on datasets with and without correlated process noise. Both the learned process and the observation noise model are also heteroscedastic. 

The results (see Appendix II-C.3) show that learning correlated noise models leads to a further small improvement of the performance of all DFs when the true process noise is correlated. However, uncovering correlations in the noise seems to be even more difficult than learning accurate heteroscedastic noise models, as indicated by the still high 

Bhattacharyya distance between true and learned **Q** . 

_F. Benchmarking_ 

TABLE III: Results on disc tracking: Comparison between the DFs and LSTM models with one or two LSTM layers on two different datasets with 30 distractors and constant process noise with increasing magnitude. Each experiment is repeated two times and we report mean and standard errors. 

||_σqp_|= 3_._0|_σqp_ = 9_._0|_σqp_ = 9_._0|
|---|---|---|---|---|
||RMSE|NLL|RMSE|NLL|
|dEKF|6.31_±_0.12|9.24_±_0.10|11.83_±_0.28|11.10_±_0.20|
|dUKF|6.46_±_0.20|9.26_±_0.26|11.49_±_0.18|10.75_±_0.16|
|dMCUKF|6.53_±_0.18|**9.23**_±_**0.17**|11.59_±_0.10|**10.81**_±_**0.11**|
|dPF-M|6.75_±_0.07|12.33_±_0.09|11.52_±_0.07|20.50_±_0.36|
|dPF-M-lrn|**5.89**_±_**0.15**|11.43_±_0.15|**9.98**_±_**0.13**|19.17_±_0.18|
|LSTM-1|9.44_±_0.77|10.64_±_0.25|14.62_±_0.70|11.83_±_0.22|
|LSTM-2|7.13_±_0.86|9.76_±_0.56|13.95_±_0.51|11.93_±_0.07|



In the final experiment on this task, we compare the performance of the DFs among each other and to two LSTM models. We use an LSTM architecture similar to [5], with one or two layers of LSTM cells (512 units each). The LSTM state is decoded into mean and covariance of a Gaussian state estimate. 

_a) Experiment:_ All models are trained for 30 epochs. The DFs learn the sensor and process models with heteroscedastic, diagonal noise models. We compare their performance on datasets with 30 distractors and different levels of constant or heteroscedastic process noise. Each experiment is repeated two times to account for different initializations of the weights. 

_b) Results:_ The results in Table III show that all models (except for the dPF-G, see Appendix Table S7) learn to track the target disc well and make reasonable uncertainty predictions. In terms of tracking error, the dPF with learned observation update performs best on all evaluated datasets. This, however, often does not extend to the likelihood scores. For the NLL, the dMCUKF instead mostly achieves the best results, however, not with a significant advantage over the other DFs. 

If we exclude the dPF variant with learned observation model (which is more expressive than the other DFs), we can 

see that the choice of the underlying filtering algorithm does not make a big difference for the performance on this task. The unstructured LSTM model, in contrast, requires two layers of LSTM cells (each with 512 units per layer) to reach the performance of the DFs. Unstructured models like LSTM can thus learn to perform similar to differentiable filters, but require a much higher number of trainable parameters than the DFs which increases computational demands and the risk of overfitting. 

## VII. KITTI VISUAL ODOMETRY 

As a first real-world application we study the KITTI Visual Odometry problem [36] that was also evaluated by [4] and [5]. The task is to estimate the position and orientation of a driving car given a sequence of RGB images from a front facing camera and the true initial state. 

The state is 5-dimensional and includes the position **p** and orientation _θ_ of the car as well as the current linear and angular velocity _v_ and _θ_[˙] . The real control input **u** = � _v_ ˙ _θ_ ¨� _T_ is unknown and we thus treat changes in _v_ and _θ_[˙] as results of the process noise. The position and heading estimate can be updated analytically by Euler integration. 

While the dynamics model is simple, the challenge in this task comes from the unknown actions and the fact that the absolute position and orientation of the car cannot be observed from the RGB images. At each timestep, the filters receive the current images as well as a difference image between the current and previous timestep. From this, the filters can estimate the angular and linear velocity to update the state, but the uncertainty about the absolute position and heading will inevitably grow due to missing feedback. Please refer to Appendix III-A for details on the implementation of the sensor network, the learned process model and the learned noise models. 

## _A. Data_ 

The KITTI Visual Odometry dataset consists of eleven trajectories of varying length (from 270 to over 4500 steps) with ground truth annotations for position and heading and image sequences from two different cameras collected at 10 Hz. 

Following [4] and [5], we build eleven different datasets. Each of the original trajectories is used as the test split of one dataset, while the remaining 10 sequences are used to construct the training and validation split. 

To augment the data, we use the images from both cameras for each trajectory and also mirror the sequences. For training and validation, we extract 200 sequences of length 50 with different random starting points from each augmented trajectory. This results in 1013 training and 287 validation sequences. For testing, we extract sequences of length 100 from the augmented test-trajectory. The number of test sequences depends on the overall length of the testtrajectory. 

When looking at the statistics of the eleven trajectories in the original KITTI dataset, Trajectory 1 can be identified as an outlier: It shows driving on a highway, where the velocity 

of the car is much higher than in all the other trajectories. As a result, the sensor models trained on the other sequences will yield bad results when evaluated on Trajectory 1. We will therefore mostly report results for only a ten-fold crossvalidation that excludes the dataset for testing on Trajectory 1. We will refer to this as _KITTI-10_ while the full, eleven-fold cross validation will be denoted as _KITTI-11_ . In Sec. VII-D, results for both settings are reported, such that the influence of Trajectory 1 becomes visible. 

## _B. Learning Noise Models_ 

In this experiment, we want to test how much the DFs profit from learning the process and observation noise models end-to-end through the filters, as compared to using handtuned or individually learned noise models. 

We also again compare learning constant or heteroscedastic noise models. In contrast to the previous task, we do not expect as large a difference between constant or heteroscedastic observation noise for this task, as the visual input does not contain occlusions or other events that would drastically change the quality of the predicted observations **z** . 

_a) Experiment:_ As in the experiments on simulated data (Sec. VI-E), we use a fixed, pretrained sensor model and the analytical process model, and only train the noise models. We initialize **Q** and **R** with **Q** = **I** 5 and **R** = **I** 2. All DFs are trained with _L_ NLL and a sequence length of 25, which we found to be beneficial for learning the noise models in a preliminary experiment. 

We compare the DFs when learning different combinations of constant or heteroscedastic process and observation noise. As on baseline, we use DFs with fixed constant noise models that reflect the average validation error of the pretrained sensor model and the analytical process model. A second baseline fixes the noise models to those obtained by individual pretraining, where we evaluate both constant and heteroscedastic models. All DFs are evaluated on _KITTI-10_ . 

_b) Results:_ The results in Table IV show that learning the noise models end-to-end through the filters greatly improves the NLL but has no big effect on the tracking errors for this task. The DFs with the hand-tuned, constant noise model have the by far worst NLL because they greatly underestimate the uncertainty about the vehicle pose. The DFs that use individually trained noise models perform better, but are still overly confident. 

For most of the DFs, we achieve the best results when learning constant observation and heteroscedastic process noise. The worst results are achieved when instead the observation noise is heteroscedastic and the process noise constant. This could indicate that the true process noise can be better modeled by a state-dependent noise model while learning heteroscedastic observation noise leads to overfitting to the training data. However, the differences are overall not very pronounced. 

Finally, we also evaluated the DFs with full covariance matrices for the noise models. For the setting with constant observation and heteroscedastic process noise, using full 

TABLE IV: Results on _KITTI-10_ : Performance of the DFs with different noise models (mean and standard error). Hand-tuned and Pretrained use fixed noise models whereas for the other variants, the noise models are trained end-to-end through the DFs. **R** _c_ indicates a constant observation noise model and **R** _h_ a heteroscedastic one (same for **Q** ). The best results per DF are highlighted in bold. 

|||Hand-tuned|Pretrained|Pretrained|**R**_c_**Q**_c_|**R**_c_**Q**_h_|**R**_h_**Q**_c_|**R**_h_**Q**_h_|
|---|---|---|---|---|---|---|---|---|
|||**R**_c_**Q**_c_|**R**_c_**Q**_c_|**R**_h_**Q**_h_|||||
||dEKF|9.67_±_0.8|**9.65**_±_**0.8**|10.53_±_1.0|9.70_±_0.8|9.69_±_0.8|9.74_±_0.8|9.68_±_0.8|
|RMSE|dUKF<br>dMCUKF<br>dPF-M|9.73_±_0.7<br>9.73_±_0.7<br>11.79_±_0.5|**9.71**_±_**0.8**<br>9.71_±_0.8<br>10.18_±_0.7|10.68_±_1.0<br>10.68_±_1.0<br>10.66_±_0.9|**9.71**_±_**0.8**<br>9.71_±_0.8<br>**9.72**_±_**0.8**|**9.71**_±_**0.8**<br>9.70_±_0.8<br>9.74_±_0.8|9.81_±_0.8<br>9.80_±_0.8<br>9.74_±_0.8|9.72_±_0.8<br>**9.68**_±_**0.8**<br>9.77_±_0.8|
||dEKF|304.4_±_43.8|139.6_±_16.7|107.7_±_15.6|39.5_±_4.0|38.9_±_5.0|40.7_±_3.7|**38.0**_±_**4.6**|
|NLL|dUKF<br>dMCUKF|305.9_±_43.7<br>306.0_±_43.8|140.0_±_16.6<br>140.0_±_16.6|108.1_±_15.5<br>108.2_±_15.5|40.5_±_4.0<br>33.9_±_3.2|**39.2**_±_**5.1**<br>**29.8**_±_**3.5**|41.3_±_4.0<br>33.3_±_3.2|40.1_±_5.4<br>30.3_±_3.7|
||dPF-M|103.2_±_6.4|75.8_±_8.5|**71.1**_±_**6.5**|74.7_±_9.9|71.4_±_10.1|74.2_±_10.1|72.4_±_9.7|



TABLE V: Results on _KITTI-10_ : RMSE and negative log likelihood for the DFs with different training schemes (mean and standard error). We compare individually trained process, sensor and noise models against finetuning only the sensor and process models, finetuning only the noise models and finteuning all models through the DFs. We also report results for DFs trained _from scratch_ without individual pretraining. The best results per DF are marked in bold. 

|||Individual|Finetune|Finetune|Finetune All|From Scratch|
|---|---|---|---|---|---|---|
||||Models|Noise|||
||dEKF|9.58_±_0.7|10.38_±_1.0|**9.54**_±_**0.7**|9.83_±_0.8|10.05_±_0.8|
|RMSE|dUKF<br>dMCUKF<br>dPF-M|9.64_±_0.7<br>9.64_±_0.7<br>10.29_±_0.6|9.663_±_0.8<br>9.53_±_0.8<br>10.86_±_0.8|9.57_±_0.7<br>9.58_±_0.7<br>**9.59**_±_**0.6**|9.33_±_0.8<br>**9.35**_±_**0.7**<br>10.09_±_0.9|**9.29**_±_**0.6**<br>9.72_±_0.6<br>10.20_±_0.9|
||dEKF|130.0_±_16.3|160.0_±_28.8|**51.3**_±_**5.1**|57.7_±_5.2|61.8_±_7.7|
|NLL|dUKF<br>dMCUKF|126.7_±_15.6<br>127.9_±_15.9|118.4_±_14.5<br>117.8_±_14.8|**57.3**_±_**5.5**<br>**50.0**_±_**4.6**|87.1_±_9.9<br>74.4_±_8.1|59.3_±_7.2<br>50.3_±_8.1|
||dPF-M|76.9_±_7.6|86.3_±_11.3|**72.6**_±_**9.4**|80.9_±_12.2|82.4_±_12.2|



instead of diagonal covariance matrices barely had any effect on the tracking error and only slightly improved the NLL (e.g. from 27.1 _±_ 5.0 to 26.5 _±_ 4.6 for the dEKF). 

## _C. End-to-End versus Individual Training_ 

Previous work [5] has shown that end-to-end training through differentiable filters leads to better results than running the DFs with models that were trained individually. Specifically, pretraining the models individually and finetuning end-to-end resulted in the best tracking performance. As a possible explanation, the authors found that the individually trained process noise model predicted noise close to the ground truth whereas the end-to-end trained model overestimated to noise, which is believed to be beneficial for filter performance. 

Does this mean that end-to-end training through DFs mostly affects the noise models? To test this, we pretrain all models individually and compare the performance of the DFs without finetuning, when finetuning only the noise models or only the sensor and process model and when finetuning everything. We also report results for training the DFs from scratch. 

_a) Experiment:_ We pretrain sensor and process model and their associated (constant) noise models individually for 30 epochs. For finetuning, we load the pretrained models and finetune the desired parts for 10 epochs, while the end-toend trained versions are trained for 30 epochs. All variants are evaluated using _KITTI-10_ and trained using _L_ NLL. 

_b) Results:_ The results shown in Table V support our hypothesis that end-to-end training through the DFs is most important for learning the noise models: Finetuning only the noise models improved both RMSE and NLL of all DFs in comparison to the variants without finetuning or with finetuning only the sensor and process model (except for the dMCUKF). For dEKF and dPF, finetuning the sensor and process model even decreased the performance on both measures. 

In terms of tracking error, individual pretraining plus finetuning the noise models lead to the best results on dEKF and dPF, while dUKF and dMCUKF performed slightly better when finetuning both sensor and process model and their noise models (dMCUKF) or even learning both from scratch (dUKF). For the NLL, finetuning only the noise models lead to the best results for all DFs, followed in most cases by training from scratch. 

To summarize, the results indicate that individual pretraining is helpful for learning the sensor and process models, but not for the noise models. End-to-end training through the DFs, on the other hand, again proved to be important for optimizing the noise models for the respective filtering algorithm but did not offer advantages for learning the sensor and process model. 

## _D. Benchmarking_ 

In the final experiment on this task, we compare the performance of the DFs to an LSTM model. We again use 

TABLE VI: Results on KITTI: Comparison between the DFs and LSTM (mean and standard error). Numbers for prior work BKF*, LSTM* taken from [4] and DPF* taken from [5]. BKF* and DPF* use a fixed analytical process model while our DFs learn both, sensor and process model.[m] m[and][de] m[g][denote][the][translation][and][rotation][error][at][the][final][step][of][the] sequence divided by the overall distance traveled. 

||RMSE<br>NLL<br>m<br>m<br>deg<br>m|
|---|---|
|_KITTI-11_|dEKF<br>15.8_±_5.8<br>338.8_±_277.1<br>0.24_±_0.04<br>0.080_±_0.005<br>dUKF<br>14.9_±_5.7<br>326.7_±_267.5<br>**0**_._**21**_±_**0**_._**04**<br>0.079_±_0.008<br>dMCUKF<br>15.2_±_5.5<br>266.3_±_216.1<br>0.23_±_0.04<br>0.083_±_0.012<br>dPF-M<br>16.3_±_6.1<br>115.2_±_34.6<br>0.24_±_0.04<br>**0**_._**078**_±_**0**_._**006**<br>dPF-M-lrn<br>**14**_._**3**_±_**5**_._**2**<br>**94**_._**2**_±_**33**_._**3**<br>0.22_±_0.04<br>0.088_±_0.013<br>LSTM<br>25.7_±_5.7<br>3970.6_±_2227.4<br>0.55_±_0.05<br>0.081_±_0.008|
||LSTM*<br>-<br>-<br>0.26<br>0.29<br>BKF*<br>-<br>-<br>0.21<br>0.08<br>DPF*<br>-<br>-<br>0.15_±_0.015<br>0.06_±_0.009|
|_KITTI-10_|dEKF<br>10.1_±_0.8<br>61.8_±_7.7<br>0.21_±_0.03<br>0.079_±_0.006<br>dUKF<br>9.3_±_0.6<br>59.3_±_7.2<br>**0**_._**18**_±_**0**_._**02**<br>0.080_±_0.008<br>dMCUKF<br>9.7_±_0.6<br>**50**_._**3**_±_**8**_._**1**<br>0.2 _±_0.03<br>0.082_±_0.013<br>dPF-M<br>10.2_±_0.9<br>82.4_±_12.2<br>0.21_±_0.02<br>**0**_._**077**_±_**0**_._**007**<br>dPF-M-lrn<br>**9**_._**2**_±_**0**_._**7**<br>61.3_±_6.1<br>0.19_±_0.03<br>0.090_±_0.014<br>LSTM<br>20.2_±_2.0<br>1764.6_±_340.4<br>0.54_±_0.06<br>0.079_±_0.008|



an LSTM architecture similar to [5], but with only one layer of LSTM cells with 256 units. The LSTM state is decoded into an update for the mean and the covariance of a Gaussian state estimate. Like the process model of the DFs, the LSTM does not get the full initial state as input, but only those components that are necessary for computing a state update (velocities and sine and cosine of the heading). We chose this architecture in an attempt to make the learning task easier for the LSTM. 

_a) Experiment:_ All models are trained for 30 epochs using _L_ NLL, except for the LSTM, for which _L_ mix lead to better results. The DFs learn the sensor and process models with constant noise models. We report their performance on _KITTI-10_ and _KITTI-11_ , for comparison with prior work. 

_b) Results:_ The results in Table VI show that by training all the models in the DFs from scratch, we can reach a performance that is competitive with prior work by [4], despite not relying on an analytical process model. We were, however, not able to reach the very good performance of the dPF reported by [5]. A possible cause for this could be that the normalization of the particles in the learned observation update used by [5] helps the method to better deal with the higher overall velocity in Trajectory 1 of the KITTI dataset. 

In contrast to the DF, we were not able to train LSTM models that reached a good evaluation performance on this task, despite trying multiple different architectures and loss functions. Different from the experiments on the simulation task, increasing the number of units per LSTM-layer or using multiple LSTM layers even decreased the performance here. To complement our results, we also report an LSTM result from [4] that does better on the position error but worse on the orientation error. While these findings do not mean that a better performance could not be reached with unstructured models given different architectures or training routines, it still shows that the added structure of the filtering algorithms greatly facilitates learning in more complex problems. 

For this task, the dPF-M-lrn again achieves the overall 

best tracking result, closely followed by the dUKF which reaches the lowest normalized endpoint position error ( m[m][).] One reason for the comparably bad performance of the dEKF could be that the dynamics of the Visual Odometry task are more strongly non-linear than in the previous experiments. Both UKF and PF can convey the uncertainty more faithfully in this case, which could lead to better overall results when training on _L_ NLL. Given the relatively large standard errors, the differences between the DFs are, however, not significant. 

## VIII. PLANAR PUSHING 

In the KITTI Visual Odometry problem, the main challenges were the unknown actions and dealing with the inevitably increasing uncertainty about the vehicle pose. With planar pushing, our second real-robot experiment in contrast addresses a task with much more complex dynamics. Apart from having non-linear and discontinuous dynamics (when the pusher makes or breaks contact with the object), [10] also showed that the noise in the system can be best captured by a heteroscedastic noise model. 

With 10 dimensions, the state representation we use is also much larger than in our previous experiments. **x** contains the 2D position **p** _o_ and orientation _θ_ of the object, as well as the two friction-related parameters _l_ and _αm_ . In addition, we include the 2D contact point between pusher and object **r** , the normal to the object’s surface at the contact point **n** and a contact indicator _s_ . The control input **u** contains the start position **p** _u_ and movement **v** _u_ of the pusher. 

An additional challenge of this task is that **r** and **n** are only properly defined and observable when the pusher is in contact with the object. We thus set the labels for **n** to zeros and **r** = **p** _u_ for non-contact cases. 

_a) Dynamics:_ We use an analytical model by [37] to predict the linear and angular velocity of the object ( **v** _o_ , _ω_ ) given the previous state and the pusher motion **v** _u_ . However, predicting the next **r** , **n** and _s_ is not possible with this model 

**==> picture [79 x 59] intentionally omitted <==**

**==> picture [79 x 59] intentionally omitted <==**

**==> picture [79 x 59] intentionally omitted <==**

Fig. 5: Examples of the rendered RGB images that we use as observations for the pushing task. The last example shows that the robot arm can partially occlude the object in some positions. 

since this would require access to a representation of the object shape. 

For **r** , we thus use a simple heuristic that predicts the next contact point as **r** _t_ +1 = **r** _t_ + **v** _u,t_ . **n** and _s_ are only updated when the angle between pusher movement and (inwards facing) normal is greater than 90 _[◦]_ . In this case, we assume that the pusher moves away from the object and set _st_ +1 and **n** _t_ +1 to zeros. 

_b) Observations:_ Our sensor network receives simulated RGBXYZ images as input and outputs the pose of the object, the contact point and normal as well as whether the push will be in contact with the object during the push or not. 

Apart from from the latent parameters _l_ and _αm_ , the orientation of the object, _θ_ , is the only state component that cannot be observed directly. Estimating the orientation of an object from a single image would require a predefined “zeroorientation” for each object, which is impractical. Instead, we train the sensor network to predict the orientation relative to the object pose in the initial image of each pushing sequence. 

## _A. Data_ 

We use the data from the MIT Push dataset [38] as a basis for constructing our datasets. Further annotations for contact points and normals as well as rendered images are obtained using the tools described by [39]. However, in contrast to [39], the images we use here also show the robot arm and are taken from a more realistic view-point. As a result, the robot frequently occludes parts of the object, but complete occlusions are rare. Figure 5 shows example views. 

We use pushes with a velocity of 50[mm] s[and render images] with a frequency of 5 Hz. This results in short sequences of about five images for each push in the original dataset. We extend them to 20 steps for training and validation and 50 steps for testing by chaining multiple pushes and adding in-between pusher movement when necessary. The resulting dataset contains 5515 sequences for training, 624 validation sequences and 751 sequences for testing. 

## _B. Learning Noise Models_ 

In this experiment, we again evaluate how much the DFs profit from learning the process and observation noise models end-to-end through the filters. In contrast to the KITTI task, for pushing, we expect both heteroscedastic observation and process noise to be advantageous, since the visual observations feature at least partial occlusions and the 

TABLE VII: Results for planar pushing: Translation (tr) and rotation (rot) error and negative log likelihood for the DFs with different noise models. The hand-tuned DFs use fixed noise models whereas for the other variants, the noise models are trained end-to-end through the DFs. **R** _c_ indicates a constant observation noise model and **R** _h_ a heteroscedastic one (same for **Q** ). The best result per DF are highlighted in bold. 

||||Hand-tuned|**R**_c_**Q**_c_|**R**_h_**Q**_c_|**R**_c_**Q**_h_|**R**_h_**Q**_h_|
|---|---|---|---|---|---|---|---|
||||**R**_c_**Q**_c_|||||
|tr [mm]||dEKF<br>dUKF<br>dMCUKF<br>dPF-M|6.22<br>4.87<br>4.73<br>18.13|4.45<br>4.44<br>4.42<br>5.07|4.61<br>5.25<br>4.8<br>4.92|4.44<br>**4**_._**43**<br>4.39<br>5.32|**4**_._**38**<br>4.45<br>**4**_._**35**<br>**4**_._**64**|
|||dEKF|10.49|10.00|**9**_._**71**|10.15|9.97|
|rot [_◦_]||dUKF<br>dMCUKF<br>dPF-M|9.87<br>**9**_._**78**<br>16.18|9.91<br>9.95<br>10.18|**9**_._**73**<br>9.93<br>**9**_._**92**|10.05<br>10.04<br>10.39|10.00<br>9.85<br>10.06|
|||dEKF|265.17|126.69|33.09|79.24|**26**_._**48**|
|NLL||dUKF<br>dMCUKF|378.08<br>130.22|84.12<br>78.53|33.06<br>30.43|81.55<br>64.12|**27**_._**61**<br>**30**_._**1**|
|||dPF-M|353.25|128.15|104.40|103.21|**82**_._**46**|



dynamics of pushing have been previously shown to exhibit heterostochasticity [10]. 

To test this hypothesis, we compare DFs that learn constant or heteroscedastic noise models to DFs with hand-tuned, constant noise models that reflect the average test error of the pretrained sensor model and the analytical process model. 

_a) Experiment:_ As in the corresponding experiments on the previous tasks (Sec. VI-E and Sec. VII-B), we use a fixed, pretrained sensor model and the analytical process model, and only train the noise models. All DFs are trained for 15 epochs on _L_ NLL. 

_b) Results:_ The results shown in Table VII again demonstrate that learning the noise models end-to-end through the structure of the filtering algorithms is beneficial. With learned models, all DFs reach much better likelihood scores than with the hand-tuned variants. For the dEKF and especially the dPF, the tracking performance also improves significantly. 

Comparing the results between constant and heteroscedastic noise models also confirms our hypothesis that for the pushing task, heteroscedastic noise models are beneficial for both observation and process noise. While all DFs reach the best NLL when both noise models are state-dependent, the effect on the tracking error is, however, less clear. 

For dEKF, dUKF and dMCUKF, learning a heteroscedastic observation noise model leads to a much bigger improvement of the NLL than learning heteroscedastic process noise. Similar to the simulated disc tracking task, the input dependent noise model allows the DFs to better deal with occlusions in the observations, which again reflects in a negative correlation between the number of visible object pixels and the predicted positional observation noise. 

## _C. Benchmarking_ 

In the final experiment, we compare the performance of the DFs to an LSTM model on the pushing task. As before, 

TABLE VIII: Results on pushing: Comparison between the DFs and LSTM. Process and sensor model are pretrained and get finetuned end-to-end. The DFs learn heteroscedastic noise models. Each experiment is repeated three times and we report mean and standard errors. 

||RMSE|NLL|tr [mm]|rot [_◦_]|
|---|---|---|---|---|
|dEKF|14.9_±_0.46|33.9_±_3.86|**3**_._**5**_±_**0**_._**02**|8.8_±_0.22|
|dUKF|**13**_._**7**_±_**0**_._**15**|**31**_._**1**_±_**1**_._**90**|3.7_±_0.06|8.8_±_0.14|
|dMCUKF|13.8_±_0.10|34.1_±_3.57|3.7_±_0.06|**8**_._**8**_±_**0**_._**06**|
|dPF-M|18.3_±_0.38|120.4_±_5.70|5.7_±_0.16|10.5_±_0.36|
|dPF-M-lrn|29.0_±_0.73|486.0_±_3.27|12.0_±_0.78|18.9_±_0.04|
|LSTM|27.36_±_0.2|35.4_±_0.24|8.8_±_0.17|19.0_±_0.001|



we use a model with one LSTM layer with 256 units. The LSTM state is decoded into an update for the mean and the covariance of a Gaussian state estimate. 

_a) Experiment:_ All models are trained for 30 epochs using _L_ mix. As initial experiments showed that learning sensor and process model jointly from scratch is very difficult for this task due to the more complex architectures, we pretrain both models. The sensor and process models are finetuned through the DFs and they learn heteroscedastic noise models. The LSTM, too, uses the pretrained sensor model, but not the process model. 

_b) Results:_ As shown in Table VIII, even with a learned process model, all DFs (except for the dPF-M-lrn) perform at least similar to their pendants in the previous experiment where we used the analytical process model. dEKF, dUKF and dMCUKF even reach a higher tracking performance than before. As noted by [39], this can be explained by the quasistatic assumption of the analytical model being violated for push velocities above 20[mm][[.]] 

s[[.]] 

The LSTM model, again, does not reach the performance of the DFs. One disadvantage of the LSTM here is that in contrast to the DFs, we cannot isolate and pretrain the process model. In contrast to the previous tasks, the dPF variant with the learned likelihood function, however, performs even worse than the LSTM for planar pushing. This is likely due to the complex sensor model and the high-dimensional state that make learning the observation likelihood much more challenging. 

## IX. CONCLUSIONS 

Our experiments show that all evaluated DFs are well suited for learning both sensor and process model, and the associated noise models. For simpler tasks like the simulated tracking task and the KITTI Visual Odometry problem, all of these models can be learned end-to-end. Only the pushing problem with its large state and complex dynamics and sensor model requires pretraining to achieve good results. 

In comparison to unstructured LSTM models, the DFs generally use fewer weights and achieve better results, especially on complex tasks. While training better LSTM models might be possible for more experienced LSTM users, using the algorithmic structure of the filtering algorithms definitely facilitated the learning problem and thus made it much easier to reach good performance with the DFs. In addition, the structure of DFs allows us to pretrain components such as the process model that are not explicitly accessible in LSTMs. 

The direct comparison between DFs with different underlying filtering algorithms showed no clear winner. Only the dPF with learned observation update performed notably better than the other variants on the simulated example task and was least affected by the outlier-trajectory of the KITTItask. This variant relaxes some of the assumptions that the filtering algorithms encode by not relying on an explicit sensor or observation noise model. Its good performance thus shows that the priors enforced by the algorithm choice can also be harmful if they do not hold in practice, such as the Gaussian noise assumption. 

Our experiments suggest that for learning the sensor and process model, end-to-end training through the filters is convenient, but provides no advantages over training the models individually. End-to-end training, however, proved to be essential for optimizing the noise models for their respective filtering algorithm. In contrast to end-to-end trained models, both hand-tuned and individually trained noise models did not result in optimal performance of the DFs. Training noise models through DFs also enables learning more complex noise models than the ones used in learning-free, hand-tuned filters. We demonstrate that noise models with full (instead of diagonal) covariance matrices and especially heteroscedastic noise model, can significantly improve the tracking accuracy and uncertainty estimates of DFs. 

The main challenge in working with differentiable filters is keeping the training stable and finding good choices for the numerous hyper-parameters and implementation options of the filters. While we hope that this work provides some orientation about which parameters matter and how to set them, we still recommend using the dEKF for getting started with differentiable filters. It is not only the most simple of the DFs we evaluated, but it also proved to be relatively insensitive to sub-optimal initialization of the noise models and was the most numerically stable during training. On the other hand, for tasks with strongly non-linear dynamics, the dUKF, dMCUKF or dPF can, however, ultimately achieve a better tracking performance. 

One interesting direction for future research that we have not attempted here is to optimize parameters of the filtering algorithms, such as the scaling parameters of the dUKF or the fixed covariance of the mixture model components in the dPF-M, by end-to-end training. It could also be interesting to implement DFs with other underlying filtering algorithms. For example, the pushing task could potentially be better han- 

dled by a Switching Kalman filter [40] that explicitly treats the contact state as a binary decision variable. In addition, all of our DFs perform badly on the outlier trajectory of the KITTI dataset which features a much higher driving velocity than the other trajectories we used for training the model. This shows that the ability to detect input values outside of the training distribution would be a valuable addition to current DFs. Finally, it would be interesting to compare learning in DFs to similar variational methods such as the ones introduced by [26, 28, 33] or the model-free PF-RNNs introduced by [13]. 

## REFERENCES 

- [1] E. Todorov, “Stochastic optimal control and estimation methods adapted to the noise characteristics of the sensorimotor system,” _Neural computation_ , vol. 17, no. 5, pp. 1084–1108, 2005. 

- [2] B. Pont´on, S. Schaal, and L. Righetti, “On the effects of measurement uncertainty in optimal control of contact interactions,” in _Algorithmic Foundations of Robotics XII_ . Springer, 2020, pp. 784–799. 

- [3] R. Jonschkowski and O. Brock, “End-to-end learnable histogram filters,” in _Workshop on Deep Learning for Action and Interaction at NIPS_ , December 2016. 

- [4] T. Haarnoja _et al._ , “Backprop KF: Learning discriminative deterministic state estimators,” in _Advances in Neural Information Processing Systems_ , 2016, pp. 4376– 4384. 

- [5] R. Jonschkowski, D. Rastogi, and O. Brock, “Differentiable particle filters: End-to-end learning with algorithmic priors,” in _Robotics: Science and Systems_ , Pittsburgh, USA, 2018. 

- [6] P. Karkus, D. Hsu, and W. S. Lee, “Particle filter networks with application to visual localization,” in _Conference on Robot Learning_ , 2018, pp. 169–178. 

- [7] S. Hochreiter and J. Schmidhuber, “Long short-term memory,” _Neural computation_ , vol. 9, no. 8, pp. 1735– 1780, 1997. 

- [8] V. A. Bavdekar, A. P. Deshpande, and S. C. Patwardhan, “Identification of process and measurement noise covariance for state and parameter estimation using extended kalman filter,” _Journal of Process Control_ , vol. 21, no. 4, pp. 585 – 601, 2011. 

- [9] J. Valappil and C. Georgakis, “Systematic estimation of state noise statistics for extended kalman filters,” _AIChE Journal_ , vol. 46, no. 2, pp. 292–308, 2000. 

- [10] M. Bauza and A. Rodriguez, “A probabilistic datadriven model for planar pushing,” in _IEEE Int. Conference on Robotics and Automation_ , May 2017, pp. 3008–3015. 

- [11] K. Kersting _et al._ , “Most likely heteroscedastic gaussian process regression,” in _Int. Conference on Machine learning_ . ACM, 2007, pp. 393–400. 

- [12] M. Abadi _et al._ , “TensorFlow: Large-scale machine learning on heterogeneous systems,” 2015, software available from tensorflow.org. 

- [13] X. Ma _et al._ , “Particle filter recurrent neural networks,” 

   - in _Proceedings of the AAAI Conference on Artificial Intelligence_ , vol. 34, no. 04, 2020, pp. 5101–5108. 

- [14] A. Tamar _et al._ , “Value iteration networks,” in _Advances in Neural Information Processing Systems_ , 2016, pp. 2154–2162. 

- [15] P. Karkus, D. Hsu, and W. S. Lee, “QMDP-Net: Deep learning for planning under partial observability,” in _Advances in Neural Information Processing Systems_ , 2017, pp. 4694–4704. 

- [16] J. Oh, S. Singh, and H. Lee, “Value prediction network,” in _Advances in Neural Information Processing Systems_ . Curran Associates, Inc., 2017, pp. 6118–6128. 

- [17] G. Farquhar _et al._ , “TreeQN and ATreec: Differentiable tree planning for deep reinforcement learning,” in _Int. Conference on Learning Representations_ , 2018. 

- [18] A. Guez _et al._ , “Learning to search with mctsnets,” in _Int. Conference on Machine Learning_ , vol. 80. PMLR, 2018, pp. 1817–1826. 

- [19] P. Donti, B. Amos, and J. Z. Kolter, “Task-based endto-end model learning in stochastic optimization,” in _Advances in Neural Information Processing Systems_ . Curran Associates, Inc., 2017, pp. 5484–5494. 

- [20] M. Okada, L. Rigazio, and T. Aoshima, “Path integral networks: End-to-end differentiable optimal control,” _arXiv preprint arXiv:1706.09597_ , 2017. 

- [21] B. Amos _et al._ , “Differentiable mpc for end-to-end planning and control,” in _Advances in Neural Information Processing Systems_ . Curran Associates, Inc., 2018, pp. 8289–8300. 

- [22] M. Pereira _et al._ , “Mpc-inspired neural network policies for sequential decision making,” _arXiv preprint arXiv:1802.05803_ , 2018. 

- [23] P. Holl, N. Thuerey, and V. Koltun, “Learning to control pdes with differentiable physics,” in _Int. Conference on Learning Representations_ , 2020. 

- [24] P. Karkus _et al._ , “Differentiable algorithm networks for composable robot learning,” in _Robotics: Science and Systems_ , 2019. 

- [25] R. G. Krishnan, U. Shalit, and D. Sontag, “Structured inference networks for nonlinear state space models,” _arXiv preprint arXiv:1609.09869_ , 2016. 

- [26] M. Karl _et al._ , “Deep variational bayes filters: Unsupervised learning of state space models from raw data,” in _Int. Conference on Learning Representations_ , 2017. 

- [27] M. Watter _et al._ , “Embed to control: A locally linear latent dynamics model for control from raw images,” in _Advances in Neural Information Processing Systems_ , 2015, pp. 2746–2754. 

- [28] M. Fraccaro _et al._ , “A disentangled recognition and nonlinear dynamics model for unsupervised learning,” in _Advances in Neural Information Processing Systems_ , 2017, pp. 3601–3610. 

- [29] E. Archer _et al._ , “Black box variational inference for state space models,” _arXiv preprint arXiv:1511.07367_ , 2015. 

- [30] L. Girin _et al._ , “Dynamical variational autoencoders: A comprehensive review,” _arXiv preprint_ 

_arXiv:2008.12595_ , 2020. 

- [31] C. Naesseth _et al._ , “Variational sequential monte carlo,” in _International Conference on Artificial Intelligence and Statistics_ . PMLR, 2018, pp. 968–977. 

- [32] C. J. Maddison _et al._ , “Filtering variational objectives,” in _Proceedings of the 31st International Conference on Neural Information Processing Systems_ , 2017, pp. 6576–6586. 

- [33] T. A. Le _et al._ , “Auto-encoding sequential monte carlo,” in _International Conference on Learning Representations_ , 2018. [Online]. Available: https: //openreview.net/forum?id=BJ8c3f-0b 

      2000. 

   - [48] M. W¨uthrich _et al._ , “Robust gaussian filtering using a pseudo measurement,” in _Proceedings of the American Control Conference_ , Boston, MA, USA, Jul. 2016. 

   - [49] N. J. Gordon, D. J. Salmond, and A. F. Smith, “Novel approach to nonlinear/non-gaussian bayesian state estimation,” in _IEE Proceedings F (Radar and Signal Processing)_ , vol. 140, no. 2. IET, 1993, pp. 107–113. 

   - [50] S. J. Julier, “The scaled unscented transformation,” in _American Control Conference_ , vol. 6, 2002, pp. 4555– 4559 vol.6. 

- [34] M. Zhu, K. Murphy, and R. Jonschkowski, “Towards differentiable resampling,” _arXiv preprint arXiv:2004.11938_ , 2020. 

- [35] D. P. Kingma and J. Ba, “Adam: A method for stochastic optimization,” in _Int. Conference on Learning Representations_ , Y. Bengio and Y. LeCun, Eds., 2015. 

- [36] A. Geiger, P. Lenz, and R. Urtasun, “Are we ready for autonomous driving? the kitti vision benchmark suite,” in _Conference on Computer Vision and Pattern Recognition_ , 2012. 

- [37] K. M. Lynch, H. Maekawa, and K. Tanie, “Manipulation and active sensing by pushing using tactile feedback,” in _IEEE Int. Conference Intelligent Robots and Systems_ , vol. 1, Jul 1992, pp. 416–421. 

- [38] K. T. Yu _et al._ , “More than a million ways to be pushed. a high-fidelity experimental dataset of planar pushing,” in _IEEE Int. Conference on Intelligent Robots and Systems_ , Oct 2016, pp. 30–37, data available from http://web.mit.edu/mcube//push-dataset. 

- [39] A. Kloss, S. Schaal, and J. Bohg, “Combining learned and analytical models for predicting action effects from sensory data,” _The International Journal of Robotics Research_ , Sep. 2020. 

- [40] K. P. Murphy, “Switching kalman filters,” 1998. 

- [41] R. E. Kalman, “A new approach to linear filtering and prediction problems,” _Journal of Basic Engineering_ , vol. 82, no. 1, pp. 35–45, 1960. 

- [42] H. Sorenson, _Kalman Filtering: Theory and Application_ , ser. IEEE Press selected reprint series. IEEE Press, 1985. 

- [43] R. Van Der Merwe, “Sigma-point kalman filters for probabilistic inference in dynamic state-space models,” 2004. 

- [44] S. J. Julier and J. K. Uhlmann, “New extension of the kalman filter to nonlinear systems,” _Proc. SPIE_ , vol. 3068, pp. 3068 – 3068 – 12, 1997. 

- [45] S. Thrun, W. Burgard, and D. Fox, _Probabilistic robotics_ . MIT press, 2005. 

- [46] Y. Wu _et al._ , “A numerical-integration perspective on gaussian filters,” _IEEE Transactions on Signal Processing_ , vol. 54, pp. 2910–2921, 08 2006. 

- [47] S. Julier, J. Uhlmann, and H. F. Durrant-Whyte, “A new method for the nonlinear transformation of means and covariances in filters and estimators,” _IEEE Transactions on Automatic Control_ , vol. 45, no. 3, pp. 477–482, 

APPENDIX I TECHNICAL BACKGROUND 

**==> picture [232 x 12] intentionally omitted <==**

In the following section, we briefly review the Bayesian filtering algorithms that we use as basis for our differentiable 

## _A. Kalman Filter_ 

The Kalman filter [41] is a closed-form solution to the filtering problem for systems with a linear process and observation model and Gaussian additive noise: 

**==> picture [230 x 26] intentionally omitted <==**

The belief about the state **x** is represented by the mean _**µ**_ and covariance matrix **Σ** of a normal distribution. At each timestep, the filter predicts _**µ**_ ˆ _t_ and **Σ**[ˆ] _t_ using the process model. The innovation **i** _t_ is the difference between the predicted and actual observation and is used to correct the prediction. The Kalman Gain **K** trades-off the process noise **Q** and the observation noise **R** to determine the magnitude of the update. 

Prediction Step: 

**==> picture [176 x 26] intentionally omitted <==**

Update Step: 

**==> picture [226 x 56] intentionally omitted <==**

## _B. Extended Kalman Filter (EKF)_ 

The EKF [42] extends the Kalman filter to systems with non-linear process and observation models. It replaces the linear models for predicting _**µ**_ ˆ in Equation S3 and the corresponding observations ˆ **z** in Equation S7 with non-linear models _f_ ( _·_ ) and _h_ ( _·_ ). For predicting the state covariance **Σ** and computing the Kalman Gain **K** , these non-linear models are linearized around the current mean of the belief. The Jacobians **F** _|µt_ and **H** _|µt_ replace **A** and **H** in Equations S4 - S6 and S9. This first-order approximation can be problematic for systems with strong non-linearity, as it does not take the uncertainty about the mean into account [43]. 

## _C. Unscented Kalman Filter (UKF)_ 

The UKF [44, 43] was proposed to address the aforementioned problem of the EKF. Its core idea, the _Unscented Transform_ [44], is to represent a Gaussian random variable that undergoes a non-linear transformation by a set of specifically chosen points in state space, the so called _sigma points_ _**χ** ∈_ **X** . 

**==> picture [241 x 78] intentionally omitted <==**

Here, _n_ is the number of dimensions of the state **x** . Each sigma point _**χ**[i]_ has two weights _wm[i]_[and] _[ w] c[i]_[. The parameters] _α_ and _κ_ control the spread of the sigma points and how strongly the original mean _**χ**_[0] is weighted in comparison to the other sigma points. _β_ = 2 is recommended if the true distribution of the system is Gaussian. 

The statistics of the transformed random variable can then be calculated from the transformed sigma points. For example, in the prediction step of the UKF, the non-linear transform is the process model (Eq. S13) and the new mean and covariance of the belief are computed in Equations S14 and S15. 

**==> picture [217 x 66] intentionally omitted <==**

In the observation update step, **S** , **K** and **i** from Equations S5, S6 and S7 are likewise replaced by the following: 

**==> picture [228 x 75] intentionally omitted <==**

**==> picture [223 x 10] intentionally omitted <==**

In theory, the UKF conveys the nonlinear transformation of the covariance more faithfully than the EKF and is thus better suited for strongly non-linear problems [45]. In contrast to the EKF, it also does not require computing the Jacobian of the process and observation models, which can be advantageous when those models are learned. 

In practice, tuning the parameters of the UKF can, however, sometimes be challenging. If _α_[2] ( _κ_ + _n_ ) is too big, the sigma points are spread too far from the mean and the prediction uncertainty increases. However, for 0 _< α_[2] ( _κ_ + _n_ ) _< n_ , the sigma point _**χ**_[0] , which represents the original mean, is weighted negatively. This not only seems counterintuitive, but strongly negative _w_[0] can also negatively affect the numerical stability of the UKF[46], which sometimes causes divergence of the estimated mean. In addition, if _n_ + _κ κ[<]_[ 0][,][the][estimated][covariance][matrix][is][not][guaranteed] 

to be positive semi definite any more. This problem can be solved by changing the way in which **Σ** is computed (see Appendix III in [47]). 

## _D. Monte Carlo Unscented Kalman Filter (MCUKF)_ 

The UKF represents the belief over the state with as few sigma points as possible. However, finding the correct scaling parameters _α_ , _κ_ and _β_ can sometimes be difficult, especially if the state is high dimensional. Instead of relying on the Unscented Transform to calculate the mean and covariance of the next belief, we can also resort to Monte Carlo methods, as proposed by [48]. 

In practice, this means replacing the carefully constructed sigma points and their weights in Equations S11 and S12 with uniformly weighted samples from the current belief. The rest of the UKF algorithm remains the same, but more sampled pseudo sigma points are necessary to represent the distribution of the belief accurately. 

## _E. Particle Filter (PF)_ 

In contrast to the different variants of the Kalman filter explained before, the Particle filter Gordon et al. [49] does not assume a parametric representation of the belief distribution. Instead, it represents the belief with a set of weighted _particles_ . This allows the filter to track multiple hypotheses about the state at the same time and makes it a popular choice for tasks like localization or visual object tracking [45]. 

An initial set of particles _**χ**[i]_ 0 _[∈]_ **[X]**[0][is][drawn][from][the] initial belief and initialized with uniform weights _π_ . In the prediction step, new particles are generated by applying the process model to the old particle set and sampling additive process noise: 

**==> picture [168 x 11] intentionally omitted <==**

In the observation update step, the weight _πt[i]_[of][each] particle _**χ**[i] t_[is][updated][using][current][observation] **[z]** _[t]_[by] 

**==> picture [210 x 12] intentionally omitted <==**

A potential problem of the PF is particle deprivation: Over time, many particles will receive a very low likelihood _p_ ( **z** _t|_ _**χ**[i] t_[)][,][and][eventually][the][state][would][be][represented][by] too few particles with high weights. To prevent this, a new set of particles with uniform weights can be drawn (with replacement) from the old set according to the weights. This resampling step focuses the particle set on regions of high likelihood and is usually applied after each timestep. 

## APPENDIX II 

## EXTENDED EXPERIMENTS: SIMULATED DISC TRACKING 

In the following, we present additional information about the experiments we performed for evaluating the DFs. This includes detailed information about the network architectures for each task, extended results and additional experiments. 

TABLE S1: Sensor model and heteroscedastic observation noise architecture. Both fully connected output layers (for **z** and _diag_ ( **R** )) get fc 2’s output as input. 

|Layer|Output Size|Kernel|Stride|Activation|
|---|---|---|---|---|
|Input **D**|100_×_100_×_3|-|-|-|
|conv 1|50_×_50_×_4|9_×_9|2|ReLU|
|conv 2|25_×_25_×_8|9_×_9|2|ReLU|
|fc 1|16|-|-|ReLU|
|fc 2|32|-|-|ReLU|
|**z**|2|-|-|-|
|diag(**R**)|2|-|-|-|



TABLE S2: Learned process model architecture 

|Layer|Output Size|Activation|
|---|---|---|
|Input **x**|4|-|
|fc 1|32|ReLU|
|fc 2|64|ReLU|
|fc 3|64|ReLU|
|∆**x** (fc)|4|-|



## _A. Network Architectures and Initialization_ 

The network architectures for the sensor model and heteroscedastic observation noise model are shown in Table S1. Tables S2 and S3 show the architecture for the learned process model and the heteroscedastic process noise. We denote fully connected layers by _fc_ and convolutional layers by _conv_ . 

For the initial belief, we use **Σ** init = 25 _∗_ **I** 4. When training from scratch, we initialize **Q** and **R** with **Q** = 100 _∗_ **I** 4 and **R** = 900 _∗_ **I** 2, reflecting the high uncertainty of the untrained models. 

## _B. Implementation and Parameters_ 

All experiments for evaluating different design choices and filter-specific parameters are performed on a dataset with 15 distractors and constant process noise ( _σp_ = 0 _._ 1 _, σv_ = 2). The filters are trained end-to-end on _L_ NLL and learn the sensor and process model as well as heteroscedastic observation and constant process noise models. We repeat each experiment two times to account for different initializations of the weights and report mean and standard errors. 

_1) dUKF:_ 

_a) Experiment:_ The original version of the UKF by [44] uses a simple parameterization where _α_ = 1 and _β_ = 0 are fixed and only _κ_ varies. The authors recommend setting _κ_ = 3 _− n_ . _α_ and _β_ are used in the later proposed _scaled unscented transform_ [50], for which [43] suggest setting _κ_ = 0, _β_ = 2 and _α_ to a small positive value. 

We evaluate the original, simple parameterization as well as the one for the scaled transform. For the first, we test 

TABLE S3: Heteroscedastic process noise model architecture 

|Layer|Output Size|Activation|
|---|---|---|
|Input **x**|4|-|
|fc 1|32|ReLU|
|fc 2|32|ReLU|
|diag(**Q**) (fc)|4|-|



**==> picture [204 x 188] intentionally omitted <==**

**----- Start of picture text -----**<br>
20<br>15<br>10<br>5<br>0<br>30<br>20<br>10<br>0<br>5 10 50 100 500<br># particles or sigma points<br>dMCUKF dPF-M<br>RMSE<br>tracking<br>likelihood<br>-log<br>**----- End of picture text -----**<br>


Fig. S1: Results on disc tracking: Tracking error and negative log likelihood of the dMCUKF and dPF-M for different numbers of sampled sigma points or particles during training and 500 sigma points / particles for testing. 

**==> picture [206 x 188] intentionally omitted <==**

**----- Start of picture text -----**<br>
20<br>15<br>10<br>5<br>0<br>20<br>10<br>0<br>0.5 1 5 10 100<br>σ<br>dPF-M dPF-M-lrn dPF-G dPF-G-lrn<br>RMSE<br>tracking<br>likelihood<br>-log<br>**----- End of picture text -----**<br>


Fig. S2: Results on disc tracking: Tracking error and negative log likelihood of the dPF-M and dPF-G, each with using the analytical or learned (-lrn) observation update. The dPF-M and dPF-M-lrn are also evaluated for different values of the fixed per-particle covariance matrix **Σ** = _σ_[2] **I** in the GMM. 

training the dUKF with _κ_ values in [ _−_ 10 _,_ 10]. In the second case, we evaluate _α ∈{_ 0 _._ 001 _,_ 0 _._ 1 _,_ 0 _._ 5 _}_ but do not vary _β_ , for which the value 2 is optimal when working with Gaussians. 

_b) Results:_ As discussed in Section VI-B.1 of the main document, the results show no significant differences between the different parameter settings or between using the original parameterization from [44] and the scaled transform. Only for _κ < −n_ , the training failed due to a non-invertible matrix in the calculation of the Kalman Gain. 

_2) dMCUKF:_ The results discussed in Section VI-B.2 of the main document are visualized in Figure S1. 

_3) dPF: Belief Representation:_ The results discussed in Section VI-B.3 are visualized in Figure S2. 

_4) dPF: Observation Update:_ The likelihood for the observation update step of the dPF can be implemented with an analytical Gaussian likelihood function (dPF-(G/M)) or with a neural network (dPF-(G/M)-lrn) as in [5] and [6]. 

[5] predict the likelihood based on an encoding of the sensory data and the observable components of the (normalized) particle states. Our implementation, too, takes the 64-dimensional encoding of the raw observations (fc 3 in Table S1) and the observable particle state components as input. However, we decide not to normalize the particles, since having prior knowledge about the mean and standard deviation of each state component in the dataset might give an unfair advantage to the method over other variants. 

_a) Results:_ Results for comparing the learned and analytical observation update can be found in Figure S2. Using a learned instead of an analytical likelihood function for updating the particle weights improves the tracking error of the dPF-M from 10.3 _±_ 0.1 to 8.3 _±_ 0.1 and the NLL from 29.6 _±_ 0.2 to 28.7 _±_ 0.1. For the dPF-G, the difference is even more dramatic, with an RMSE of 23.3 _±_ 1.1 vs. 8.0 _±_ 0.3 and an NLL of 31.0 _±_ 0.05 vs. 27.5 _±_ 0.1. _5) dPF: Resampling:_ The results for Section VI-B.5 of the main document are visualized in Figure S3. _6) dPF: Number of Particles:_ The results discussed in Section VI-B.6 of the main document are visualized in Figure S1. 

_5) dPF: Resampling:_ The results for Section VI-B.5 of the main document are visualized in Figure S3. 

## _C. Noise Models_ 

_1) Heteroscedastic Observation Noise:_ Table S4 extends Table I in the main document. It contains results for the dPF-G and on additional datasets with different numbers of distractors and different magnitudes of the positional process noise. 

_2) Heteroscedastic Process Noise:_ Table S5 extends Table II in the main document. It contains results for the dPF-G and on additional datasets with different magnitudes of the positional process noise. 

_3) Correlated Noise:_ So far, we have only considered noise models with diagonal covariance matrices. In this experiment, we want to see if DFs can learn to identify correlations in the noise. 

_a) Experiment:_ We create a new dataset with 30 distractors and constant, correlated process noise. The ground truth process noise covariance matrix is 

**==> picture [152 x 49] intentionally omitted <==**

We compare the performance of DFs that learn noise models with diagonal or full covariance matrix on datasets with and without correlated process noise. Both the learned process and the observation noise model are also heteroscedastic. 

**==> picture [415 x 195] intentionally omitted <==**

**----- Start of picture text -----**<br>
dPF-M dPF-M-lrn<br>20 20<br>15 15<br>10 10<br>5 5<br>0 0<br>30 30<br>20 20<br>10 10<br>0 0<br>0 0.05 0.1 0.25 0 0.05 0.1 0.25<br>α re α re<br>every step every 2nd step every 5th step every 10th step<br>RMSE<br>tracking<br>likelihood<br>-log<br>**----- End of picture text -----**<br>


Fig. S3: Results on disc tracking: Tracking error and negative log likelihood of the two dPF-M variants for different resampling rates and values of the soft resampling parameter _α_ re. 

TABLE S4: Results for disc tracking: End-to-end learning of the noise models through the DFs on datasets with 5 or 30 distractors and different levels of process noise. While **Q** is always constant, we evaluate learning constant (const.) or heteroscedastic (hetero) observation noise **R** . We show the tracking error (RMSE), negative log likelihood (NLL), the correlation coefficient between predicted **R** and the number of visible pixels of the target disc (corr.) and the Bhattacharyya distance between true and learned process noise model ( _D_ **Q** ). The best results per DF are highlighted in bold. 

||_σqp_ = 0_._1<br>_σqp_ = 3_._0<br>_σqp_ = 9_._0<br>R<br>RMSE<br>NLL<br>corr.<br>_D_**Q**<br>RMSE<br>NLL<br>corr.<br>_D_**Q**<br>RMSE<br>NLL<br>corr.<br>_D_**Q**|
|---|---|
|5 distractors|dEKF<br>const.<br>14.1<br>13.6<br>-<br>2.722<br>16.3<br>14.1<br>-<br>0.081<br>28.8<br>15.7<br>-<br>0.019<br>hetero.<br>**9.8**<br>**11.9**<br>-0.71<br>**1.204**<br>**9.8**<br>**11.5**<br>-0.74<br>**0.007**<br>**18.7**<br>**13.2**<br>-0.66<br>**0.007**|
||dUKF<br>const.<br>14.3<br>13.7<br>-<br>2.828<br>17.1<br>14.2<br>-<br>0.071<br>30.2<br>15.8<br>-<br>0.026<br>hetero.<br>**9.9**<br>**11.8**<br>-0.70<br>**0.557**<br>**9.6**<br>**11.3**<br>-0.74<br>**0.011**<br>**21.7**<br>**14.2**<br>-0.66<br>**0.013**|
||dMCUKF<br>const.<br>14.5<br>13.7<br>-<br>2.389<br>16.5<br>14.2<br>-<br>0.258<br>30.7<br>15.8<br>-<br>0.02<br>hetero.<br>**9.9**<br>**11.8**<br>-0.71<br>**0.272**<br>**9.9**<br>**11.6**<br>-0.73<br>**0.016**<br>**21.0**<br>**14.4**<br>-0.65<br>**0.004**|
||dPF-G<br>const.<br>14.6<br>13.7<br>-<br>**3.318**<br>17.3<br>14.1<br>-<br>**0.257**<br>29.2<br>15.7<br>-<br>**0.04**<br>hetero.<br>**12.0**<br>**12.8**<br>-0.47<br>3.348<br>**13.8**<br>**13.4**<br>-0.47<br>0.297<br>**23.2**<br>**14.6**<br>-0.63<br>0.064|
||dPF-M<br>const.<br>13.1<br>34.7<br>-<br>3.408<br>15.2<br>40.8<br>-<br>**0.279**<br>27.7<br>52.9<br>-<br>0.745<br>hetero.<br>**10.3**<br>**19.8**<br>-0.7<br>**3.361**<br>**11.3**<br>**23.1**<br>-0.67<br>0.424<br>**18.0**<br>**36.1**<br>-0.74<br>**0.147**|
|30 distractors|dEKF<br>const.<br>14.5<br>13.9<br>-<br>2.543<br>16.2<br>14.0<br>-<br>0.121<br>28.6<br>15.6<br>-<br>0.010<br>hetero.<br>**7.8**<br>**10.4**<br>-0.72<br>**1.429**<br>**8.8**<br>**10.7**<br>-0.78<br>**0.002**<br>**22.4**<br>**14.7**<br>-0.75<br>**0.008**|
||dUKF<br>const.<br>15.3<br>13.9<br>-<br>2.047<br>16.8<br>14.1<br>-<br>0.161<br>30.2<br>15.7<br>-<br>0.024<br>hetero.<br>**7.8**<br>**10.4**<br>-0.71<br>**1.565**<br>**8.8**<br>**10.7**<br>-0.78<br>**0.013**<br>**20.6**<br>**14.8**<br>-0.85<br>**0.010**|
||dMCUKF<br>const.<br>14.8<br>13.9<br>-<br>2.955<br>16.7<br>14.1<br>-<br>0.152<br>29.8<br>15.7<br>-<br>0.022<br>hetero.<br>**7.8**<br>**10.4**<br>-0.71<br>**1.533**<br>**9.0**<br>**10.9**<br>-0.78<br>**0.006**<br>**22.1**<br>**15.1**<br>-0.78<br>**0.016**|
||dPF-G<br>const.<br>15.2<br>13.8<br>-<br>3.433<br>17.3<br>14.1<br>-<br>**0.224**<br>29.1<br>15.6<br>-<br>**0.047**<br>hetero.<br>1**0.4**<br>**11.9**<br>-0.71<br>**3.103**<br>**12.1**<br>**12.6**<br>-0.53<br>0.277<br>**20.8**<br>**14.4**<br>-0.86<br>0.090|
||dPF-M<br>const.<br>14.1<br>33.6<br>-<br>3.396<br>16.1<br>34.3<br>-<br>0.435<br>27.7<br>49.9<br>-<br>1.240<br>hetero.<br>**8.7**<br>**14.4**<br>-0.70<br>**3.223**<br>**9.6**<br>**20.8**<br>-0.77<br>**0.280**<br>**13.9**<br>**21.8**<br>-0.81<br>**0.084**|



TABLE S5: Results on disc tracking: End-to-end learning of constant or heteroscedastic process noise **Q** on datasets with 30 distractors and different heteroscedastic or constant ( _σqp_ = 3 _._ 0, _σqv_ = 2 _._ 0) process noise. _D_ **Q** is the Bhattacharyya distance between true and learned process noise. 

|||hetero.|_σqv_, _σqp_|= 0_._1|hetero.|_σqv_, _σqp_|= 3_._0|_σqp_ =|3_._0, _σqv_|= 2_._0|hetero.|_σqv_, _σqp_|= 9_._0|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
||Q|RMSE|NLL|_D_**Q**|RMSE|NLL|_D_**Q**|RMSE|NLL|_D_**Q**|RMSE|NLL|_D_**Q**|
|dEKF|const.<br>hetero.|4.3<br>**3.8**|8.2<br>**7.2**|1.335<br>**0.479**|8.1<br>**7.4**|11.6<br>**11.3**|0.879<br>**0.402**|8.8<br>8.8|10.7<br>10.7|**0.002**<br>0.033|19.6<br>**18.5**|14.1<br>**13.7**|1.108<br>**0.805**|
|dUKF|const.<br>hetero.|4.23<br>**3.8**|8.3<br>**7.2**|1.288<br>**1.008**|7.8<br>**7.6**|11.3<br>**11.2**|0.874<br>**0.391**|8.8<br>**8.7**|10.7<br>10.7|**0.013**<br>0.030|20.3<br>**20.1**|14.2<br>**14.0**|1.061<br>**0.900**|
|dMCUKF|const.<br>hetero.|4.2<br>**3.8**|8.3<br>**7.2**|1.184<br>**0.932**|8.1<br>**7.5**|11.5<br>**11.3**|0.891<br>**0.464**|9.0<br>**8.7**|10.9<br>**10.7**|**0.006**<br>0.044|20.7<br>**20.3**|14.2<br>**13.9**|1.057<br>**0.904**|
|dPF-G|const.<br>hetero.|7.2<br>**6.8**|10.9<br>**10.8**|**3.888**<br>3.990|9.0<br>9.0|11.9<br>**11.5**|1.104<br>**0.808**|12.1<br>**11.8**|12.6<br>**12.4**|**0.277**<br>0.347|**20.9**<br>21.3|14.3<br>14.3|1.229<br>**1.096**|
|dPF-M|const.<br>hetero.|**5.0**<br>5.2|**10.7**<br>11.1|3.902<br>**3.853**|8.5<br>**8.2**|15.2<br>**14.7**|1.072<br>**0.787**|**9.6**<br>9.8|20.8<br>**19.8**|**0.280**<br>0.413|19.7<br>**17.8**|29.1<br>**27.8**|**0.799**<br>1.074|



_b) Results:_ Results are shown in Table S6. Overall, we note that learning correlated noise models has a small but consistent positive effect on the tracking performance of all DFs, even when the ground truth noise is not correlated. On the dataset with correlated ground truth process noise, we also observe an improvement of the likelihood scores. 

In terms of the Bhattacharyya distance between true and learned **Q** , learning correlated models leads to a slight improvement for correlated ground truth noise and to slightly worse scores otherwise. This indicates that the models are able to uncover some, but not all correlations in the underlying data. 

In summary, while learning correlated noise models does not influence the results negatively, it also does not lead to a very pronounced improvement over models with diagonal covariance matrices. Uncovering correlations in the process noise thus seems to be even more difficult than learning accurate heteroscedastic noise models. 

## _D. Benchmarking_ 

Table S7 extends Table III from the main document. It contains results for the dPF-G and dPF-G-lrn and on additional datasets with lower positional process noise and heteroscedastic process noise. 

## APPENDIX III 

## EXTENDED EXPERIMENTS: KITTI VISUAL ODOMETRY 

## _A. Network Architectures and Initialization_ 

_a) Sensor Network:_ The network architectures for the sensor model and the heteroscedastic observation noise model are shown in Table S8. At each timestep, the input consists of the current RGB image and the difference image between the current and previous image. The network architecture for the sensor model is the same as was used in [4] and [5]. 

_b) Process Model:_ Tables S9 and S10 show the architecture for the learned process model and the heteroscedastic process noise. For both models, we found it to be important not to include the absolute position of the vehicle in the input values: The value range for the positions is not bounded, and 

especially for the dUKF variants, novel values encountered at test time often lead to a divergence of the filter. 

Excluding these values from the network inputs for predicting the state update also makes sense intuitively, since they are not required for computing the update analytically, either. For the state-dependent process noise, we not only exclude the position, but also the orientation of the car, as any relationships between vehicle pose and noise that could be learned would be specific to the training trajectories. 

In addition, we provide the process model with the sine and cosine of _θ_ as input instead of using the raw orientation, to facilitate the learning. In general, dealing with angles in the state vector requires special attention: First, we correct angles to the range between [ _−π, π_ ] after every operation on the state vector. Second, it is important to correctly calculate the difference between angles (e.g. in the loss function) to avoid differences over 180deg. And third, computing the mean of several angles, e.g. for the particle mean in the dPF, requires converting the angles to a vector representation. 

_c) Initialization:_ When creating the noisy initial states, we do not add noise to the absolute position and orientation of the vehicle, since the DFs have no way of correcting them. We use diag( **Σ** init) = �0 _._ 01 0 _._ 01 0 _._ 01 25 25[�] for the initial covariance matrix. When training the DFs from scratch, we initialize the covariance matrices **Q** and **R** with diag( **Q** ) = �0 _._ 01 0 _._ 01 0 _._ 01 100 100� and **R** = 100 **I** 2. This reflects the high uncertainty of the untrained models, but also the fact that the process noise should be higher for the velocities (to account for the unknown driver actions) than for the absolute pose. 

## _B. Training Sequence Length and Filter Parameters_ 

One special feature of the Visual Odometry task is that the the error on the estimated absolute vehicle pose will inevitably grow during filtering. As this could have an effect on the ideal training sequence length, we repeat the experiment from Section VI-D in the main document. 

For the dPF-M, we also evaluate different values of the fixed per-particle covariance **Σ** for calculating the GMMlikelihood. We anticipate that this parameter, too, could be 

TABLE S6: Results on disc tracking: End-to-end learning of independent ( _diagonal_ covariance matrix) or correlated ( _full_ covariance matrix) process and observation noise models. We evaluate on one dataset with independent, constant process noise ( _σqp_ = 3 _._ 0, _σqv_ = 2 _._ 0), one with independent heteroscedastic process noise ( _σqp_ = 3 _._ 0), and one with correlated constant process noise. _D_ **Q** is the Bhattacharyya distance between true and learned **Q** . 

||covariance<br>independent const. noise<br>independent hetero. noise<br>correlated const. noise<br>matrix<br>RMSE<br>NLL<br>_D_**Q**<br>RMSE<br>NLL<br>_D_**Q**<br>RMSE<br>NLL<br>_D_**Q**|
|---|---|
|dEKF<br>dUKF<br>dMCUKF<br>dPF-G<br>dPF-M|diagonal<br>8.8<br>10.7<br>**0.033**<br>**7.4**<br>**11.3**<br>**0.402**<br>8.9<br>10.6<br>1.249<br>full<br>**8.6**<br>**10.7**<br>0.089<br>7.6<br>12.2<br>0.591<br>**8.4**<br>**10.1**<br>**1.003**|
||diagonal<br>8.7<br>10.7<br>**0.030**<br>**7.6**<br>11.2<br>**0.391**<br>8.7<br>10.6<br>1.345<br>full<br>**8.6**<br>**10.7**<br>0.126<br>7.6<br>**10.8**<br>0.523<br>**8.7**<br>**10.4**<br>**0.994**|
||diagonal<br>8.7<br>10.7<br>**0.044**<br>**7.5**<br>11.3<br>**0.464**<br>8.8<br>10.6<br>1.248<br>full<br>**8.6**<br>**10.7**<br>0.143<br>7.6<br>**10.8**<br>0.507<br>**8.7**<br>**10.3**<br>**1.026**|
||diagonal<br>11.8<br>12.4<br>**0.347**<br>9.0<br>11.5<br>**0.808**<br>11.7<br>**12.4**<br>1.646<br>full<br>**11.5**<br>**12.3**<br>0.421<br>**8.8**<br>11.5<br>0.942<br>**11.4**<br>12.5<br>**1.565**|
||diagonal<br>9.8<br>19.8<br>**0.413**<br>8.2<br>**14.7**<br>**0.787**<br>9.3<br>22.1<br>**1.649**<br>full<br>**8.9**<br>**18.5**<br>0.693<br>**7.3**<br>15.7<br>1.463<br>**8.4**<br>**18.2**<br>2.005|



TABLE S7: Results on disc tracking: Comparison between the DFs and LSTM models with one or two LSTM layers on two different datasets with 30 distractors and constant process noise with increasing magnitude. Each experiment is repeated two times and we report mean and standard error. 

||_σqp_|=|0_._1|_σqp_ = 0_._1 hetero.|_σqp_ = 0_._1 hetero.|_σqp_ = 3_._0|_σqp_ = 3_._0|_σqp_ = 9_._0|_σqp_ = 9_._0|
|---|---|---|---|---|---|---|---|---|---|
||RMSE||NLL|RMSE|NLL|RMSE|NLL|RMSE|NLL|
|dEKF|6.1_±_0.54||9.1_±_0.42|4.9_±_1.04|**8.3**_±_**0.91**|6.3_±_0.12|9.2_±_0.10|11.8_±_0.28|11.1_±_0.20|
|dUKF|5.8_±_0.21||8.9_±_0.25|4.1_±_0.09|7.6_±_0.06|6.5_±_0.20|9.3_±_0.26|11.5_±_0.18|10.8_±_0.16|
|dMCUKF|5.5_±_0.30||**8.6**_±_**0.23**|5.0_±_0.86|8.4_±_0.77|6.5_±_0.18|**9.2**_±_**0.17**|11.6_±_0.10|**10.8**_±_**0.11**|
|dPF-G|12.9_±_0.29||12.3_±_0.05|10.4_±_0.06|11.4_±_0.02|13.3_±_0.45|12.4_±_0.10|18.7_±_0.35|13.5_±_0.07|
|dPF-M|6.2_±_0.34||11.7_±_0.16|5.0_±_0.40|10.7_±_0.45|6.7_±_0.07|12.3_±_0.09|11.5_±_0.07|20.5_±_0.36|
|dPF-G-lrn|**4.9**_±_**0.11**||9.2_±_0.12|**3.6**_±_**0.13**|8.4_±_0.04|**5.7**_±_**0.06**|9.8_±_0.01|10.6_±_0.17|11.9_±_0.03|
|dPF-M-lrn|5.3_±_0.17||10.8_±_0.22|4.4_±_0.09|9.9_±_0.10|5.9_±_0.15|11.4_±_0.15|**10.0**_±_**0.13**|19.2_±_0.18|
|LSTM-1|5.9_±_0.20||9.0_±_0.21|14.2_±_9.33|10.5_±_2.52|9.4_±_0.77|10.6_±_0.25|14.6_±_0.70|11.8_±_0.22|
|LSTM-2|5.7_±_0.40||9.2_±_0.62|6.3_±_2.73|8.9_±_1.51|7.1_±_0.86|9.8_±_0.56|13.9_±_0.51|11.9_±_0.07|



TABLE S8: Sensor model and heteroscedastic observation noise architecture. Both output layers (for **z** and diag( **R** )) get fc 2’s output as input. 

|Layer|Output Size|Kernel|Stride|Activation|Normalization|
|---|---|---|---|---|---|
|Input **D**|50_×_150_×_6|-|-|-|-|
|conv 1|50_×_150_×_16|7_×_7|1_×_1|ReLU|Layer|
|conv 2|50_×_75_×_16|5_×_5|1_×_2|ReLU|Layer|
|conv 3|50_×_37_×_16|5_×_5|1_×_2|ReLU|Layer|
|conv 4|25_×_18_×_16|5_×_5|2_×_2|ReLU|Layer|
|dropout (0.3)|25_×_18_×_16|-|-|-|-|
|fc 1|128|-|-|ReLU|-|
|fc 2|128|-|-|ReLU|-|
|**z** (fc)|2|-|-|-|-|
|diag(**R**) (fc)|2|-|-|-|-|



sensitive to the accumulating uncertainty in the problem. 

In addition, we also reevaluate different values for parameterizing the sigma point selection and weighting in the dUKF. 

## _1) Training Sequence Length and dPF-M:_ 

_a) Experiment:_ We only test with the dEKF, dUKF, dPF-M and dPF-M-lrn on _KITTI-10_ . The filters learn the sensor and process model as well as constant noise models. We train them using _LNLL_ on sequence lengths _k ∈ {_ 2 _,_ 5 _,_ 10 _,_ 25 _}_ while keeping the total number of examples per batch (steps _×_ batch size) constant. 

For the dPF-M, we also evaluate two different values of 

the per-particle covariance, **Σ** = **I** and **Σ** = 5[2] **I** . 

_b) Results:_ The results shown in Figure S4 largely confirm the results obtained for the simulation dataset in Section VI-D of the main document. We again see that longer training sequences increase the tracking performance of all DFs up to a sequence length of around _k_ = 10. 

The dUKF seems to be most sensitive to the sequence length, with the highest tracking error and an extremely bad NLL score for sequences of length 2. Different from the simulation experiment, for both dEKF and dUKF, the NLL keeps decreasing strongly over the full evaluated sequence length range, despite the best RMSE already being reached 

**==> picture [486 x 148] intentionally omitted <==**

**----- Start of picture text -----**<br>
20<br>100<br>15<br>10<br>31 . 6<br>5<br>0<br>2 5 10 25 2 5 10 25<br>training sequence length training sequence length<br>dEKF dUKF dPF-M1 dPF-M5 dPF-M1-lrn<br>RMSE likelihood<br>-log<br>**----- End of picture text -----**<br>


Fig. S4: Results on _KITTI-10_ : Tracking error and negative log likelihood (NLL with logarithmic y axis) of dEKF, dUKF, dPFM and dPF-M-lrn trained with different sequence lengths. For the dPF-M, we show two different values for the covariance **Σ** of the single Gaussians in the mixture model, **Σ** = **I** and **Σ** = 5[2] **I** . The cut-off NLL value for the dUKF on sequences of length 2 is 2004.4 _±_ 518.3. 

TABLE S9: Learned process model architecture. We use a modified version of the previous state **x** as input: **x** ¯ = ( _v, θ,_[˙] cos _θ,_ sin _θ_ ) 

|Layer|Output Size|Activation|
|---|---|---|
|Input ¯**x**|4|-|
|fc 1|32|ReLU|
|fc 2|64|ReLU|
|fc 3|64|ReLU|
|∆**x** (fc)|5|-|



TABLE S10: Heteroscedastic process noise model architecture. We use a modified version of the previous state **x** as input: **x** ¯ = ( _v, θ,_[˙] cos _θ,_ sin _θ_ ) 

|Layer||||Output Size|Activation|
|---|---|---|---|---|---|
|Input|�|_v,_ ˙_θ_|�|2|-|
|fc 1||||32|ReLU|
|fc 2||||32|ReLU|
|diag(**Q**) (fc)||||5|-|



at _k_ = 5. We attribute this to the accumulating uncertainty about the vehicle pose. For the dPFs, in contrast, the likelihood behaves similarly to the RMSE. 

In light of the longer training times with higher sequence lengths, we again decide to keep a training-sequence length of 10 when training the DFs from scratch. However, when only the noise models are trained, longer sequences can be used to improved results on the NLL. 

For the dPF-M, the experiment also shows that the covariance of the single distributions in the GMM is an important tuning parameter. With **Σ** = **I** , we achieve the best tracking error, however, the likelihood does not reach the performance of dEKF and dUKF. The NLL values can be drastically improved by using larger **Σ** , at the cost of a decreased tracking performance. Visual inspection of the position estimates shows that the particles remain relatively tightly clustered over the complete sequence, such that the likelihood of the GMM is not so different from the likelihood 

of the individual Gaussian components. 

This clustered particle distribution can be explained by the characteristics of the task: The uncertainty in the system mainly stems from the velocity components that are affected by the unknown actions. However, by applying the observation update and resampling the particles at every step, we keep the variance in the velocity components small and thus prevent a stronger diffusion of the unobserved position components. This also explains why the dPF cannot profit as much as the dUKF and dEKF from seeing longer sequences during training. 

The large influence of the tuning parameter **Σ** on the value of the likelihood, independent of the tracking performance, also shows that comparing likelihood scores between different probabilistic models can be difficult. In light of this, we decide to keep using **Σ** = **I** for the better tracking error. 

_2) dUKF:_ We also repeat the evaluation of different values of the parameters _α_ , _κ_ and _β_ for the dUKF described in Experiment II-B.1. The experiment confirms our finding from the simulation experiment that the exact choice of the values does not have a significant effect on the filter performance. We thus keep the values at _α_ = 1, _κ_ = 0 _._ 5 and _β_ = 0. 

## _C. Learning Noise Models_ 

_a) Experiment:_ The baseline model with constant, hand-tuned noise uses _T_ diag( **Q** ) = �10 _[−]_[4] 10 _[−]_[4] 10 _[−]_[6] 0 _._ 01 0 _._ 16� and diag( **R** ) = �0 _._ 36 0 _._ 36[�] _[T]_ . 

## _D. Benchmarking_ 

Table S11 extends the results from Table VI with data for the dPF-G and dPF-G-lrn. Interestingly, we find that the difference in performance between the dPF variants with learned or analytical observation update is not as pronounced as in the results we obtained for the simulation experiment (Section II-B.4). In particular, the dPF-G-lrn performs similarly bad as the dPF-G on this task. 

TABLE S11: Results on KITTI: Comparison between the DFs and LSTM (mean and standard error). Numbers for prior work BKF*, LSTM* taken from [4] and DPF* taken from [5]. BKF* and DPF* use a fixed analytical process model while our DFs learn both, sensor and process model.[m] m[and][de] m[g][denote][the][translation][and][rotation][error][at][the][final][step][of][the] sequence divided by the overall distance traveled. 

||RMSE<br>NLL<br>m<br>m<br>deg<br>m|
|---|---|
|_KITTI-11_|dEKF<br>15.8_±_5.8<br>338.8_±_277.1<br>0.24_±_0.04<br>0.080_±_0.005<br>dUKF<br>14.9_±_5.7<br>326.7_±_267.5<br>**0**_._**21**_±_**0**_._**04**<br>0.079_±_0.008<br>dMCUKF<br>15.2_±_5.5<br>266.3_±_216.1<br>0.23_±_0.04<br>0.083_±_0.012<br>dPF-M<br>16.3_±_6.1<br>115.2_±_34.6<br>0.24_±_0.04<br>**0**_._**078**_±_**0**_._**006**<br>dPF-G<br>21.1_±_5.7<br>121.9_±_80.5<br>0.33_±_0.04<br>0.175_±_0.036<br>dPF-M-lrn<br>**14**_._**3**_±_**5**_._**2**<br>**94**_._**2**_±_**33**_._**3**<br>0.22_±_0.04<br>0.088_±_0.013<br>dPF-G-lrn<br>19.1_±_5.3<br>197.8_±_125.3<br>0.31_±_0.06<br>0.168_±_0.049<br>LSTM<br>25.7_±_5.7<br>3970.6_±_2227.4<br>0.55_±_0.05<br>0.081_±_0.008|
||LSTM*<br>-<br>-<br>0.26<br>0.29<br>BKF*<br>-<br>-<br>0.21<br>0.08<br>DPF*<br>-<br>-<br>0.15_±_0.015<br>0.06_±_0.009|
|_KITTI-10_|dEKF<br>10.1_±_0.8<br>61.8_±_7.7<br>0.21_±_0.03<br>0.079_±_0.006<br>dUKF<br>9.3_±_0.6<br>59.3_±_7.2<br>**0**_._**18**_±_**0**_._**02**<br>0.080_±_0.008<br>dMCUKF<br>9.7_±_0.6<br>**50**_._**3**_±_**8**_._**1**<br>0.2 _±_0.03<br>0.082_±_0.013<br>dPF-M<br>10.2_±_0.9<br>82.4_±_12.2<br>0.21_±_0.02<br>**0**_._**077**_±_**0**_._**007**<br>dPF-G<br>15.5_±_1.4<br>41.7_±_6.6<br>0.3 _±_0.04<br>0.182_±_0.038<br>dPF-M-lrn<br>**9**_._**2**_±_**0**_._**7**<br>61.3_±_6.1<br>0.19_±_0.03<br>0.090_±_0.014<br>dPF-G-lrn<br>14.4_±_2.4<br>73.6_±_17.9<br>0.29_±_0.06<br>0.179_±_0.053<br>LSTM<br>20.2_±_2.0<br>1764.6_±_340.4<br>0.54_±_0.06<br>0.079_±_0.008|



TABLE S12: Learned process model architecture. 

|Layer|Output Size|Activation|
|---|---|---|
|Input (**x**_,_**v**_u_)|12|-|
|fc 1|256|ReLU|
|fc 2|128|ReLU|
|fc 3|128|ReLU|
|∆**x** (fc)|10|-|



APPENDIX IV EXTENDED EXPERIMENTS: PLANAR PUSHING 

## _A. Network Architectures and Initialization_ 

_a) Sensor Network:_ Our architectures for the sensor network is very similar to the one used by [39], where only the object position **p** _o_ is estimated from the full image while the contact-related state components ( **r** , **n** , _s_ ) are computed from a smaller glimpse around the pusher location. 

For predicting the orientation of the object, we extract a second glimpse from the full image, this time centered on the estimated object position. A small CNN then predicts the change in orientation between the glimpse extracted from the initial image in the sequence and the glimpse at the current time step. 

The sensor network predicts object position, contact point and normal in pixel space because predictions in this space can be most directly related to the input image and the predicted feature maps. To this end, we also transform the action into pixel space before using it (together with the glimpse encoding) as input for predicting the contact point and normal. The pixel predictions are then transformed back to to world-coordinates using the depth measurements and camera information. The resulting sensor network including the layers for computing the heteroscedastic observation noise is illustrated in Figure S5. 

TABLE S13: Heteroscedastic process noise model architecture. We use a modified version of the previous state **x** as input: **x** ¯ does not include the latent parameter _l_ . 

|Layer|Output Size|Activation|
|---|---|---|
|Input (¯**x**_,_**v**_u_)|11|-|
|fc 1|128|ReLU|
|fc 2|64|ReLU|
|diag(**Q**) (fc)|10|-|



_b) Process Model:_ Tables S12 and S13 show the architecture for the learned process model and the heteroscedastic process noise. One problem we noticed is that the estimates for _l_ sometimes diverge during filtering if the DFs estimate that the pusher is in contact with the object while it is not. Just as for the absolute position of the vehicle in the KITTI task, we thus found it important for the stability of the dUKF and dMCUKF to not make the heteroscedastic process noise model dependent on _l_ . 

Note that in the filter state, we measure **p** _o_ and **r** in millimeter and _θ_ and _αm_ in degree. To avoid having too large differences between the magnitudes of the state components, we downscale _l_ by a factor of 100. **n** is a dimensionless unit vector and _s_ should take values between 0 and 1. 

To keep the filters stable during training, we found it necessary to enforce maximum and minimum values for _αm_ and _l_ . Both _αm_ and _l_ cannot become negative. The opening angle of the friction cone, _αm_ , should also not be larger than 90 _[◦]_ , while we limit _l_ to be in the range of [0 _._ 1 _,_ 5000] to ensure that the computations in the analytical model remain numerically stable. 

**==> picture [404 x 362] intentionally omitted <==**

**----- Start of picture text -----**<br>
Initial Glimpse  Glimpse  Image Action Tip position Glimpse<br>72x72x3 72x72x3 192x256x6 2 2 64x64x6<br>extract extract<br>glimpse glimpse<br>concatenate conv-7-8 conv-3-8<br>conv-5-16 conv-3-16<br>conv-3-32<br>conv-3-32 conv-3-32<br>conv-3-64<br>deconv-13-16 concatenate<br>fc-128<br>deconv-3-8 fc-128<br>fc-64<br>deconv-3-1<br>fc-64 fc-64 fc-64<br>spatial softmax conv-5-16<br>fc-32<br>conv-3-32<br>to 3d to 3d<br>to 3d fc-64<br>**----- End of picture text -----**<br>


Fig. S5: Architecture of the sensor network and heteroscedastic observation noise model for planar pushing. We use 6-channel RGBXYZ images as input for computing the object position and contact related state components. The object orientation is estimated relative to the initial orientation by comparing the RGB glimpse centered on the current estimated object position to the initial one. 

White boxes represent tensors, green arrows and boxes indicate network layers, whereas black arrows represent dataflow without processing. For convolution (conv) and deconvolution (deconv) layers, the numbers in each tensor are the kernel size and number of output channels of the layer that produced it. For fully connected layers (fc), the number corresponds to the number of output channels. 

With the exception of the output layers, all convolution, deconvolution and fully connected layers are followed by ReLU non-linearities. The (de)convolution layers also use layer normalization. 

_c) Initialization:_ For the initial covariance matrix, we and 

use 

**==> picture [235 x 32] intentionally omitted <==**

**==> picture [208 x 32] intentionally omitted <==**

When training the noise models, we initialize **Q** and **R** with diag( **Q** ) = **I** 10 and **R** = **I** 8. 

_B. Learning Noise Models_ 

_a) Experiment:_ The diagonals of the hand-tuned models are 

�diag( **Q** ) = (0 _._ 23 0 _._ 23 0 _._ 37 0 _._ 01 0 _._ 01 0 _._ 7 0 _._ 7 0 _._ 1 0 _._ 1 0 _._ 13) _[T]_ 

_b) Results:_ Table S14 extends the results from Table VII with data for the dPF-G. In contrast to the other DF variants, learning complex noise models for the pushing task is not successful for the dPF-G. While the NLL can be further decreased when the noise models are heteroscedastic instead of constant, this comes at the cost of a significantly decreased tracking performance. 

TABLE S14: Results for planar pushing: Translation (tr) and rotation (rot) error and negative log likelihood for the DFs with different noise models (mean and standard error). The hand-tuned DFs use fixed noise models whereas for the other variants, the noise models are trained end-to-end through the DFs. **R** _c_ indicates a constant observation noise model and **R** _h_ a heteroscedastic one (same for **Q** ). The best result per DF and metric is highlighted in bold. 

|||Hand-tuned|**R**_c_**Q**_c_|**R**_h_**Q**_c_|**R**_c_**Q**_h_|**R**_h_**Q**_h_|
|---|---|---|---|---|---|---|
|||**R**_c_**Q**_c_|||||
||dEKF|6.22|4.45|4.61|4.44|**4**_._**38**|
|tr [mm]|dUKF<br>dMCUKF<br>dPF-M|4.87<br>4.73<br>18.13|4.44<br>4.42<br>5.07|5.25<br>4.8<br>4.92|**4**_._**43**<br>4.39<br>5.32|4.45<br>**4**_._**35**<br>**4**_._**64**|
||dPF-G|17.95|**5**_._**48**|35.57|210.45|10.92|
||dEKF|10.49|10.00|**9**_._**71**|10.15|9.97|
|rot [_◦_]|dUKF<br>dMCUKF<br>dPF-M|9.87<br>**9**_._**78**<br>16.18|9.91<br>9.95<br>10.18|**9**_._**73**<br>9.93<br>**9**_._**92**|10.05<br>10.04<br>10.39|10.00<br>9.85<br>10.06|
||dPF-G|16.56|10.27|11.27|43.41|**10**_._**25**|
||dEKF|265.17|126.69|33.09|79.24|**26**_._**48**|
|NLL|dUKF<br>dMCUKF<br>dPF-M|378.08<br>130.22<br>353.25|84.12<br>78.53<br>128.15|33.06<br>30.43<br>104.40|81.55<br>64.12<br>103.21|**27**_._**61**<br>**30**_._**1**<br>**82**_._**46**|
||dPF-G|_>_ 16m|12,089.71|34.18|5,789.83|**31**_._**60**|



TABLE S15: Results on pushing: Comparison between the DFs and LSTM. Process and sensor model are pretrained and get finetuned end-to-end. The DFs learn heteroscedastic noise models. Each experiment is repeated three times and we report mean and standard errors. 

||RMSE|NLL|tr [mm]|rot [_◦_]|
|---|---|---|---|---|
|dEKF|14.9_±_0.46|33.9_±_3.86|**3**_._**5**_±_**0**_._**02**|8.8_±_0.22|
|dUKF|**13**_._**7**_±_**0**_._**15**|**31**_._**1**_±_**1**_._**90**|3.7_±_0.06|8.8_±_0.14|
|dMCUKF|13.8_±_0.10|34.1_±_3.57|3.7_±_0.06|**8**_._**8**_±_**0**_._**06**|
|dPF-M|18.3_±_0.38|120.4_±_5.70|5.7_±_0.16|10.5_±_0.36|
|dPF-G|23.2_±_3.60|35.8_±_1.86|6.9_±_1.43|11.9_±_0.67|
|dPF-M-lrn|29.0_±_0.73|486.0_±_3.27|12.0_±_0.78|18.9_±_0.04|
|dPF-G-lrn|29.2_±_0.67|40.8_±_0.82|10.9_±_0.27|19.9_±_0.52|
|LSTM|27.36_±_0.2|35.4_±_0.24|8.8_±_0.17|19.0_±_0.001|



## _C. Benchmarking_ 

Table S15 extends the results from Table VIII with data for the dPF-G and dPF-G-lrn. Note that their difference in performance to the dPF-M variants is smaller here than for the previous tasks because training on _L_ mix instead of _L_ NLL reduces the effect of how the belief is represented on the loss. 

