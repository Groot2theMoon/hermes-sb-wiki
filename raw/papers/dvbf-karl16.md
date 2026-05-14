---
title: "Deep Variational Bayes Filters: Unsupervised Learning of State Space Models from Raw Data"
arxiv: "1605.06432"
authors: [Maximilian Karl, Maximilian Soelch, Justin Bayer, Patrick van der Smagt]
year: 2016
source: paper
ingested: 2026-05-14
sha256: 82609cb13ba4ebae2b6f96a34c3c5aa4cb0453cbe161b0aa884561efbdb9103d
conversion: pymupdf4llm
---

Published as a conference paper at ICLR 2017 

# DEEP VARIATIONAL BAYES FILTERS: UNSUPERVISED LEARNING OF STATE SPACE MODELS FROM RAW DATA 

**Maximilian Karl, Maximilian Soelch, Justin Bayer, Patrick van der Smagt** Data Lab, Volkswagen Group, 80805, München, Germany 

zip([maximilian.karl, maximilian.soelch], [@volkswagen.de]) 

## ABSTRACT 

We introduce Deep Variational Bayes Filters (DVBF), a new method for unsupervised learning and identification of latent Markovian state space models. Leveraging recent advances in Stochastic Gradient Variational Bayes, DVBF can overcome intractable inference distributions via variational inference. Thus, it can handle highly nonlinear input data with temporal and spatial dependencies such as image sequences without domain knowledge. Our experiments show that enabling backpropagation through transitions enforces state space assumptions and significantly improves information content of the latent embedding. This also enables realistic long-term prediction. 

## 1 INTRODUCTION 

Estimating probabilistic models for sequential data is central to many domains, such as audio, natural language or physical plants, Graves (2013); Watter et al. (2015); Chung et al. (2015); Deisenroth & Rasmussen (2011); Ko & Fox (2011). The goal is to obtain a model _p_ ( **x** 1: _T_ ) that best reflects a data set of observed sequences **x** 1: _T_ . Recent advances in deep learning have paved the way to powerful models capable of representing high-dimensional sequences with temporal dependencies, e.g., Graves (2013); Watter et al. (2015); Chung et al. (2015); Bayer & Osendorfer (2014). 

Time series for dynamic systems have been studied extensively in systems theory, cf. McGoff et al. (2015) and sources therein. In particular, _state space models_ have shown to be a powerful tool to analyze and control the dynamics. Two tasks remain a significant challenge to this day: Can we identify the governing system from data only? And can we perform inference from observables to the latent system variables? These two tasks are competing: A more powerful representation of system requires more computationally demanding inference, and efficient inference, such as the well-known Kalman filters, Kalman & Bucy (1961), can prohibit sufficiently complex system classes. 

Leveraging a recently proposed estimator based on variational inference, stochastic gradient variational Bayes (SGVB, Kingma & Welling (2013); Rezende et al. (2014)), approximate inference of latent variables becomes tractable. Extensions to time series have been shown in Bayer & Osendorfer (2014); Chung et al. (2015). Empirically, they showed considerable improvements in marginal data likelihood, i.e., compression, but lack full-information latent states, which prohibits, e.g., long-term sampling. Yet, in a wide range of applications, full-information latent states should be valued over compression. This is crucial if the latent spaces are used in downstream applications. 

Our contribution is, to our knowledge, the first model that (i) _enforces_ the latent state-space model assumptions, allowing for reliable system identification, and plausible long-term prediction of the observable system, (ii) provides the corresponding inference mechanism with rich dependencies, (iii) inherits the merit of neural architectures to be trainable on raw data such as images or other sensory inputs, and (iv) scales to large data due to optimization of parameters based on stochastic gradient descent, Bottou (2010). Hence, our model has the potential to exploit systems theory methodology for downstream tasks, e.g., control or model-based reinforcement learning, Sutton (1996). 

1 

Published as a conference paper at ICLR 2017 

## 2 BACKGROUND AND RELATED WORK 

## 2.1 PROBABILISTIC MODELING AND FILTERING OF DYNAMICAL SYSTEMS 

We consider non-linear dynamical systems with _observations_ **x** _t ∈X ⊂_ R _[n][x]_ , depending on _control inputs_ (or _actions_ ) **u** _t ∈U ⊂_ R _[n][u]_ . Elements of _X_ can be high-dimensional sensory data, e.g., raw images. In particular they may exhibit complex non-Markovian transitions. Corresponding timediscrete sequences of length T are denoted as **x** 1: _T_ = ( **x** 1 _,_ **x** 2 _, . . . ,_ **x** _T_ ) and **u** 1: _T_ = ( **u** 1 _,_ **u** 2 _, . . . ,_ **u** _T_ ). 

We are interested in a probabilistic model[1] _p_ ( **x** 1: _T |_ **u** 1: _T_ ). Formally, we assume the graphical model 

**==> picture [324 x 23] intentionally omitted <==**

where **z** 1: _T ,_ **z** _t ∈Z ⊂_ R _[n][z] ,_ denotes the corresponding latent sequence. That is, we assume a generative model with an underlying _latent_ dynamical system with _emission model p_ ( **x** 1: _T |_ **z** 1: _T ,_ **u** 1: _T_ ) and _transition model p_ ( **z** 1: _T |_ **u** 1: _T_ ). We want to learn both components, i.e., we want to perform _latent system identification_ . In order to be able to apply the identified system in downstream tasks, we need to find efficient posterior inference distributions _p_ ( **z** 1: _T |_ **x** 1: _T_ ). Three common examples are prediction, filtering, and smoothing: inference of **z** _t_ from **x** 1: _t−_ 1, **x** 1: _t_ , or **x** 1: _T_ , respectively. Accurate identification and efficient inference are generally competing tasks, as a wider generative model class typically leads to more difficult or even intractable inference. 

The transition model is imperative for achieving good long-term results: a bad transition model can lead to divergence of the latent state. Accordingly, we put special emphasis on it through a Bayesian treatment. Assuming that the transitions may differ for each time step, we impose a regularizing prior distribution on a set of _transition parameters_ _**β**_ 1: _T_ : 

**==> picture [345 x 23] intentionally omitted <==**

To obtain state-space models, we impose assumptions on emission and state transition model, 

**==> picture [295 x 30] intentionally omitted <==**

**==> picture [296 x 30] intentionally omitted <==**

Equations (3) and (4) assume that the current state **z** _t_ contains all necessary information about the current observation **x** _t_ , as well as the next state **z** _t_ +1 (given the current control input **u** _t_ and transition parameters _**β** t_ ). That is, in contrast to observations, **z** _t_ exhibits Markovian behavior. 

A typical example of these assumptions are Linear Gaussian Models (LGMs), i.e., both state transition and emission model are affine transformations with Gaussian offset noise, 

**==> picture [324 x 25] intentionally omitted <==**

Typically, _state transition matrix_ **F** _t_ and _control-input matrix_ **B** _t_ are assumed to be given, so that _**β** t_ = **w** _t_ . Section 3.3 will show that our approach allows other variants such as _**β** t_ = ( **F** _t,_ **B** _t,_ **w** _t_ ). Under the strong assumptions (5) and (6) of LGMs, inference is provably solved optimally by the well-known Kalman filters. While extensions of Kalman filters to nonlinear dynamical systems exist, Julier & Uhlmann (1997), and are successfully applied in many areas, they suffer from two major drawbacks: firstly, its assumptions are restrictive and are violated in practical applications, leading to suboptimal results. Secondly, parameters such as **F** _t_ and **B** _t_ have to be known in order to perform posterior inference. There have been efforts to learn such system dynamics, cf. Ghahramani & Hinton (1996); Honkela et al. (2010) based on the expectation maximization (EM) algorithm or Valpola & Karhunen (2002), which uses neural networks. However, these algorithms are not applicable in cases 

> 1 Throughout this paper, we consider **u** 1: _T_ as given. The case without any control inputs can be recovered by setting _U_ = _∅_ , i.e., not conditioning on control inputs. 

2 

Published as a conference paper at ICLR 2017 

where the true posterior distribution is intractable. This is the case if, e.g., image sequences are used, since the posterior is then highly nonlinear—typical mean-field assumptions on the approximate posterior are too simplified. Our new approach will tackle both issues, and moreover learn both identification and inference jointly by exploiting Stochastic Gradient Variational Bayes. 

## 2.2 STOCHASTIC GRADIENT VARIATIONAL BAYES (SGVB) FOR TIME SERIES DISTRIBUTIONS 

Replacing the bottleneck layer of a deterministic auto-encoder with stochastic units **z** , the variational auto-encoder (VAE, Kingma & Welling (2013); Rezende et al. (2014)) learns complex marginal data distributions on **x** in an unsupervised fashion from simpler distributions via the graphical model 

**==> picture [176 x 23] intentionally omitted <==**

In VAEs, _p_ ( **x** _|_ **z** ) _≡ pθ_ ( **x** _|_ **z** ) is typically parametrized by a neural network with parameters _θ_ . Within this framework, models are trained by maximizing a lower bound to the marginal data log-likelihood via stochastic gradients: 

ln _p_ ( **x** ) _≥_ E _qφ_ ( **z** _|_ **x** )[ln _pθ_ ( **x** _|_ **z** )] _−_ KL( _qφ_ ( **z** _|_ **x** ) _|| p_ ( **z** )) =: _L_ SGVB( **x** _, φ, θ_ ) (7) This is provably equivalent to minimizing the KL-divergence between the _approximate posterior_ or _recognition model qφ_ ( **z** _|_ **x** ) and the true, but usually intractable posterior distribution _p_ ( **z** _|_ **x** ). _qφ_ is parametrized by a neural network with parameters _φ_ . 

The principle of VAEs has been transferred to time series, Bayer & Osendorfer (2014); Chung et al. (2015). Both employ nonlinear state transitions in latent space, but violate eq. (4): Observations are directly included in the transition process. Empirically, reconstruction and compression work well. The state space _Z_ , however, does not reflect all information available, which prohibits plausible generative long-term prediction. Such phenomena with generative models have been explained in Theis et al. (2015). 

In Krishnan et al. (2015), the state-space assumptions (3) and (4) are softly encoded in the Deep Kalman Filter (DKF) model. Despite that, experiments, cf. section 4, show that their model fails to extract information such as velocity (and in general time derivatives), which leads to similar problems with prediction. 

Johnson et al. (2016) give an algorithm for general graphical model variational inference, not tailored to dynamical systems. In contrast to previously discussed methods, it does not violate eq. (4). The approaches differ in that the recognition model outputs node potentials in combination with message passing to infer the latent state. Our approach focuses on learning dynamical systems for controlrelated tasks and therefore uses a neural network for inferring the latent state directly instead of an inference subroutine. 

Others have been specifically interested in applying variational inference for controlled dynamical systems. In Watter et al. (2015) (Embed to Control—E2C), a VAE is used to learn the mappings to and from latent space. The regularization is clearly motivated by eq. (7). Still, it fails to be a mathematically correct lower bound to the marginal data likelihood. More significantly, their recognition model requires all observations that contain information w.r.t. the current state. This is nothing short of an additional _temporal_ i.i.d. assumption on data: Multiple raw samples need to be stacked into one training sample such that all latent factors (in particular all time derivatives) are present within one sample. The task is thus greatly simplified, because instead of time-series, we learn a static auto-encoder on the processed data. 

A pattern emerges: good prediction should boost compression. Still, previous methods empirically excel at compression, while prediction will not work. We conjecture that this is caused by previous methods trying to fit the latent dynamics to a latent state that is beneficial for _reconstruction_ . This encourages learning of a stationary auto-encoder with focus of extracting as much from a single observation as possible. Importantly, it is not necessary to know the entire sequence for excellent reconstruction of single time steps. Once the latent states are set, it is hard to adjust the transition to them. This would require changing the latent states slightly, and that comes at a cost of decreasing the reconstruction (temporarily). The learning algorithm is stuck in a local optimum with good reconstruction and hence good compression only. Intriguingly, E2C bypasses this problem with its data augmentation. 

3 

Published as a conference paper at ICLR 2017 

**==> picture [220 x 97] intentionally omitted <==**

**----- Start of picture text -----**<br>
u t u t<br>z t z t +1 z t z t +1<br>β t v t w t x t +1 β t v t w t x t +1<br>(a) Forward graphical (b) Inference.<br>model.<br>**----- End of picture text -----**<br>


Figure 1: Left: Graphical model for one transition under state-space model assumptions. The updated latent state **z** _t_ +1 depends on the previous state **z** _t_ , control input **u** _t_ , and transition parameters _**β** t_ . **z** _t_ +1 contains all information for generating observation **x** _t_ +1. Diamond nodes indicate a deterministic dependency on parent nodes. Right: Inference performed during training (or while filtering). Past observations are indirectly used for inference as **z** _t_ contains all information about them. 

This leads to a key contribution of this paper: We _force the latent space to fit the transition_ —reversing the direction, and thus achieving the state-space model assumptions and full information in the latent states. 

## 3 DEEP VARIATIONAL BAYES FILTERS 

## 3.1 REPARAMETRIZING THE TRANSITION 

The central problem for learning latent states system dynamics is efficient inference of a latent space _that obeys state-space model assumptions_ . If the latter are fulfilled, the latent space _must_ contain all information. Previous approaches emphasized good reconstruction, so that the space only contains information necessary for reconstruction of one time step. To overcome this, we establish gradient paths through transitions over time so that the transition becomes the driving factor for shaping the latent space, rather than adjusting the transition to the recognition model’s latent space. The key is to prevent the recognition model _qφ_ ( **z** 1: _T |_ **x** 1: _T_ ) from directly drawing the latent state **z** _t_ . 

Similar to the reparametrization trick from Kingma & Welling (2013); Rezende et al. (2014) for making the Monte Carlo estimate differentiable w.r.t. the parameters, we make the transition differentiable w.r.t. the last state and its parameters: 

**z** _t_ +1 = _f_ ( **z** _t,_ **u** _t,_ _**β** t_ ) (8) 

Given the stochastic parameters _**β** t_ , the state transition is deterministic (which in turn means that by marginalizing _**β** t_ , we still have a stochastic transition). The immediate and crucial consequence is that errors in reconstruction of **x** _t_ from **z** _t_ are backpropagated directly through time. 

This reparametrization has a couple of other important implications: the recognition model no longer infers latent states **z** _t_ , but transition parameters _**β** t_ . In particular, the gradient _∂_ **z** _t_ +1 _/∂_ **z** _t_ is well-defined from (8)—gradient information can be backpropagated through the transition. 

This is different from the method used in Krishnan et al. (2015), where the transition only occurs in the KL-divergence term of their loss function (a variant of eq. (7)). No gradient from the generative model is backpropagated through the transitions. 

Much like in eq. (5), the stochastic parameters includes a corrective offset term **w** _t_ , which emphasizes the notion of the recognition model as a filter. In theory, the learning algorithm could still learn the transition as **z** _t_ +1 = **w** _t_ . However, the introduction of _**β** t_ also enables us to regularize the transition with meaningful priors, which not only prevents overfitting the recognition model, but also enforces meaningful manifolds in the latent space via _transition priors_ . Ignoring the potential of the transition over time yields large penalties from these priors. Thus, the problems outlined in Section 2 are overcome by construction. 

To install such transition priors, we split _**β** t_ = ( **w** _t,_ **v** _t_ ). The interpretation of **w** _t_ is a sample-specific process noise which can be inferred from incoming data, like in eq. (5). On the other hand, **v** _t_ 

4 

Published as a conference paper at ICLR 2017 

**==> picture [377 x 174] intentionally omitted <==**

**----- Start of picture text -----**<br>
u t<br>z t u t β t<br>the input/conditional is task-dependent<br>v t w t<br>qφ ( w t | · ) qφ ( v t )<br>α t =  fψ ( z t,  u t )<br>(e.g., neural network)<br>β t ∼ qφ ( β t ) =  qφ ( w t | · ) qφ ( v t )<br>z t transition in latent state space z t +1 =  f ( z t,  u t,  β t ) z t +1 ( A ,  B ,  C ) t = [�] [M] i =1 [α] t [(] [i] [)][(] [A] [,] [ B] [,] [ C] [)][(] [i] [)]<br>z t +1 =  A t z t  +  B t u t  +  C t w t<br>pθ ( x t +1 |  z t +1)<br>z t +1<br>(a) General scheme for arbitrary transitions. (b) One particular example of a latent transition: local<br>linearity.<br>**----- End of picture text -----**<br>


Figure 2: Left: General architecture for DVBF. Stochastic transition parameters _**β** t_ are inferred via the recognition model, e.g., a neural network. Based on a sampled _**β** t_ , the state transition is computed deterministically. The updated latent state **z** _t_ +1 is used for predicting **x** _t_ +1. For details, see section 3.1. Right: Zoom into latent space transition (red box in left figure). One exemplary transition is shown, the locally linear transition from section 3.3. 

are universal transition parameters, which are sample-independent (and are only inferred from data during training). This corresponds to the idea of weight uncertainty in Hinton & Van Camp (1993). This interpretation leads to a natural factorization assumption on the recognition model: 

**==> picture [289 x 11] intentionally omitted <==**

When using the fully trained model for generative sampling, i.e., sampling without input, the universal state transition parameters can still be drawn from _qφ_ ( **v** 1: _T_ ), whereas **w** 1: _T_ is drawn from the prior in the absence of input data. 

Figure 1 shows the underlying graphical model and the inference procedure. Figure 2a shows a generic view on our new computational architecture. An example of a locally linear transition parametrization will be given in section 3.3. 

## 3.2 THE LOWER BOUND OBJECTIVE FUNCTION 

In analogy to eq. (7), we now derive a lower bound to the marginal likelihood _p_ ( **x** 1: _T |_ **u** 1: _T_ ). After reflecting the Markov assumptions (3) and (4) in the factorized likelihood (2), we have: 

**==> picture [330 x 30] intentionally omitted <==**

Due to the deterministic transition given _**β** t_ +1, the last term is a product of Dirac distributions and the overall distribution simplifies greatly: 

**==> picture [287 x 58] intentionally omitted <==**

5 

Published as a conference paper at ICLR 2017 

The last formulation is for notational brevity: the term _pθ_ ( **x** 1: _T |_ **z** 1: _T_ ) is _not_ independent of _**β**_ 1: _T_ and **u** 1: _T_ . We now derive the objective function, a lower bound to the data likelihood: 

**==> picture [390 x 84] intentionally omitted <==**

=: _L_ DVBF( **x** 1: _T , θ, φ |_ **u** 1: _T_ ) 

Our experiments show that an annealed version of (10) is beneficial to the overall performance: 

(10 _[′]_ ) = E _qφ_ [ _ci_ ln _pθ_ ( **x** 1: _T |_ **z** 1: _T_ ) _−_ ln _qφ_ ( _**β**_ 1: _T |_ **x** 1: _T ,_ **u** 1: _T_ ) + _ci_ ln _p_ ( **w** 1: _T_ ) + ln _p_ ( **v** 1: _T_ )] 

Here, _ci_ = max(1 _,_ 0 _._ 01 + _i/TA_ ) is an inverse temperature that increases linearly in the number of gradient updates _i_ until reaching 1 after _TA_ annealing iterations. Similar annealing schedules have been applied in, e.g., Ghahramani & Hinton (2000); Mandt et al. (2016); Rezende & Mohamed (2015), where it is shown that they smooth the typically highly non-convex error landscape. Additionally, the transition prior _p_ ( **v** 1: _T_ ) was estimated during optimization, i.e., through an empirical Bayes approach. In all experiments, we used isotropic Gaussian priors. 

## 3.3 EXAMPLE: LOCALLY LINEAR TRANSITIONS 

We have derived a learning algorithm for time series with particular focus on general transitions in latent space. Inspired by Watter et al. (2015), this section will show how to learn a particular instance: locally linear state transitions. That is, we set eq. (8) to 

**==> picture [324 x 10] intentionally omitted <==**

where **w** _t_ is a stochastic sample from the recognition model and **A** _t,_ **B** _t,_ and **C** _t_ are matrices of matching dimensions. They are stochastic functions of **z** _t_ and **u** _t_ (thus _local_ linearity). We draw 

**==> picture [166 x 19] intentionally omitted <==**

from _qφ_ ( **v** _t_ ), i.e., _M_ triplets of matrices, each corresponding to data- _independent_ , but learned globally linear system. These can be learned as point estimates. We employed a Bayesian treatment as in Blundell et al. (2015). We yield **A** _t,_ **B** _t,_ and **C** _t_ as state- and control- _dependent_ linear combinations: 

**==> picture [348 x 47] intentionally omitted <==**

The computation is depicted in fig. 2b. The function _fψ_ can be, e.g., a (deterministic) neural network with weights _ψ_ . As a subset of the generative parameters _θ_ , _ψ_ is part of the trainable parameters of our model. The weight vector _**α** t_ is shared between the three matrices. There is a correspondence to eq. (5): **A** _t_ and **F** _t_ , **B** _t_ and **B** _t_ , as well as **C** _t_ **C** _[⊤] t_[and] **[ Q]** _[t]_[are related.] 

We used this parametrization of the state transition model for our experiments. It is important that the parametrization is up to the user and the respective application. 

## 4 EXPERIMENTS AND RESULTS 

In this section we validate that DVBF with locally linear transitions (DVBF-LL) (section 3.3) outperforms Deep Kalman Filters (DKF, Krishnan et al. (2015)) in recovering latent spaces with full information.[2] We focus on environments that can be simulated with full knowledge of the 

> 2We do not include E2C, Watter et al. (2015), due to the need for data modification and its inability to provide a correct lower bound as mentioned in section 2.2. 

6 

Published as a conference paper at ICLR 2017 

**==> picture [311 x 197] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) DVBF-LL (b) DKF<br>**----- End of picture text -----**<br>


Figure 3: (a) Our DVBF-LL model trained on pendulum image sequences. The upper plots show the latent space with coloring according to the ground truth with angles on the left and angular velocities on the right. The lower plots show regression results for predicting ground truth from the latent representation. The latent space plots show clearly that all information for representing the full state of a pendulum is encoded in each latent state. (b) DKF from Krishnan et al. (2015) trained on the same pendulum dataset. The latent space plot shows that DKF fails to learn velocities of the pendulum. It is therefore not able to capture all information for representing the full pendulum state. 

ground truth latent dynamical system. The experimental setup is described in the Supplementary Material. We published the code for DVBF and a link will be made available at https://brml. org/projects/dvbf. 

## 4.1 DYNAMIC PENDULUM 

In order to test our algorithm on truly non-Markovian observations of a dynamical system, we simulated a dynamic torque-controlled pendulum governed by the differential equation 

**==> picture [174 x 12] intentionally omitted <==**

_m_ = _l_ = 1 _, µ_ = 0 _._ 5 _, g_ = 9 _._ 81, via numerical integration, and then converted the ground-truth angle _ϕ_ into an image observation in _X_ . The one-dimensional control corresponds to angle acceleration (which is proportional to joint torque). Angle and angular velocity fully describe the system. 

Figure 3 shows the latent spaces for identical input data learned by DVBF-LL and DKF, respectively, colored with the ground truth in the top row. It should be noted that latent _samples_ are shown, _not_ means of posterior distributions. The state-space model was allowed to use three latent dimensions. As we can see in fig. 3a, DVBF-LL learned a two-dimensional manifold embedding, i.e., it encoded the angle in polar coordinates (thus circumventing the discontinuity of angles modulo 2 _π_ ). The bottom row shows ordinary least-squares regressions (OLS) underlining the performance: there exists a high correlation between latent states and ground-truth angle and angular velocity for DVBF-LL. On the contrary, fig. 3b verifies our prediction that DKF is equally capable of learning the angle, but extracts little to no information on angular velocity. 

The OLS regression results shown in table 1 validate this observation.[3] Predicting sin( _ϕ_ ) and cos( _ϕ_ ), i.e., polar coordinates of the ground-truth angle _ϕ_ , works almost equally well for DVBF-LL and DKF, with DVBF-LL slightly outperforming DKF. For predicting the ground truth velocity _ϕ_ ˙ , DVBF-LL 

> 3Linear regression is a natural choice: after transforming the ground truth to polar coordinates, an affine transformation should be a good fit for predicting ground truth from latent states. We also tried nonlinear regression with vanilla neural networks. While not being shown here, the results underlined the same conclusion. 

7 

Published as a conference paper at ICLR 2017 

Table 1: Results for pendulum OLS regressions of all latent states on respective dependent variable. 

|Dependent<br>ground truth<br>variable|DVBF-LL<br>DKF<br>Log-Likelihood<br>_R_2<br>Log-Likelihood<br>_R_2|
|---|---|
||sin(_ϕ_)<br>3990.8<br>0.961<br>1737.6<br>0.929<br>cos(_ϕ_)<br>7231.1<br>0.982<br>6614.2<br>0.979<br>˙_ϕ_<br>_−_11139<br>0.916<br>_−_20289<br>0.035|



**==> picture [160 x 159] intentionally omitted <==**

**==> picture [160 x 159] intentionally omitted <==**

**==> picture [396 x 61] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Generative latent walk. (b) Reconstructive latent walk.<br>1 5 10 15 20 40 45<br>...<br>...<br>...<br>**----- End of picture text -----**<br>


(c) Ground truth (top), reconstructions (middle), generative samples (bottom) from identical initial latent state. 

Figure 4: (a) Latent space walk in generative mode. (b) Latent space walk in filtering mode. (c) Ground truth and samples from recognition and generative model. The reconstruction sampling has access to observation sequence and performs filtering. The generative samples only get access to the observations once for creating the initial state while all subsequent samples are predicted from this single initial state. The red bar indicates the length of training sequences. Samples beyond show the generalization capabilities for sequences longer than during training. The complete sequence can be found in the Appendix in fig. 7. 

shows remarkable performance. DKF, instead, contains hardly any information, resulting in a very low goodness-of-fit score of _R_[2] = 0 _._ 035. 

Figure 4 shows that the strong relation between ground truth and latent state is beneficial for generative sampling. All plots show 100 time steps of a pendulum starting from the exact same latent state and not being actuated. The top row plots show a purely generative walk in the latent space on the left, and a walk in latent space that is corrected by filtering observations on the right. We can see that both follow a similar trajectory to an attractor. The generative model is more prone to noise when approaching the attractor. 

The bottom plot shows the first 45 steps of the corresponding observations (top row), reconstructions (middle row), and generative samples (without correcting from observations). Interestingly, DVBF works very well even though the sequence is much longer than all training sequences (indicated by the red line). 

Table (2) shows values of the lower bound to the marginal data likelihood (for DVBF-LL, this corresponds to eq. (11)). We see that DVBF-LL outperforms DKF in terms of compression, but only 

8 

Published as a conference paper at ICLR 2017 

Table 2: Average test set objective function values for pendulum experiment. 

**==> picture [386 x 167] intentionally omitted <==**

**----- Start of picture text -----**<br>
Lower Bound = Reconstruction Error − KL divergence<br>DVBF-LL 798.56 802.06 3.50<br>DKF 784.70 788.58 3.88<br>(a) Latent walk of bouncing ball. (b) Latent space velocities.<br>**----- End of picture text -----**<br>


Figure 5: (a) Two dimensions of 4D bouncing ball latent space. Ground truth x and y coordinates are combined into a regular 3 _×_ 3 checkerboard coloring. This checkerboard is correctly extracted by the embedding. (b) Remaining two latent dimensions. Same latent samples, colored with ball velocities in x and y direction (left and right image, respectively). The smooth, perpendicular coloring indicates that the ground truth value is stored in the latent dimension. 

with a slight margin, which does not reflect the better generative sampling as Theis et al. (2015) argue. 

## 4.2 BOUNCING BALL 

The bouncing ball experiment features a ball rolling within a bounding box in a plane. The system has a two-dimensional control input, added to the directed velocity of the ball. If the ball hits the wall, it bounces off, so that the true dynamics are highly dependent on the current position and velocity of the ball. The system’s state is four-dimensional, two dimensions each for position and velocity. 

Consequently, we use a DVBF-LL with four latent dimensions. Figure 5 shows that DVBF again captures the entire system dynamics in the latent space. The checkerboard is quite a remarkable result: the ground truth position of the ball lies within the 2D unit square, the bounding box. In order to visualize how ground truth reappears in the learned latent states, we show the warping of the ground truth bounding box into the latent space. To this end, we partitioned (discretized) the ground truth unit square into a regular 3x3 checkerboard with respective coloring. We observed that DVBF learned to extract the 2D position from the 256 pixels, and aligned them in two dimensions of the latent space in strong correspondence to the physical system. The algorithm does the exact same pixel-to-2D inference that a human observer automatically does when looking at the image. 

|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|...<br>**5**<br>**1**<br>**10**<br>**15**<br>**20**<br>**40**<br>**45**|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
||||||||||||||||||||||||||||||||
|||||||||||||||||||||||...|||||||||
|||||||||||||||||||||||...|||||||||



Figure 6: Ground truth (top), reconstructions (middle), generative samples (bottom) from identical initial latent state for the two bouncing balls experiment. Red bar indicates length of training sequences. 

9 

Published as a conference paper at ICLR 2017 

## 4.3 TWO BOUNCING BALLS 

Another more complex environment[4] features two balls in a bounding box. We used a 10-dimensional latent space to fully capture the position and velocity information of the balls. Reconstruction and generative samples are shown in fig. 6. Same as in the pendulum example we get a generative model with stable predictions beyond training data sequence length. 

## 5 CONCLUSION 

We have proposed Deep Variational Bayes Filters (DVBF), a new method to learn state space models from raw non-Markovian sequence data. DVBFs perform latent dynamic system identification, and subsequently overcome intractable inference. As DVBFs make use of stochastic gradient variational Bayes they naturally scale to large data sets. In a series of vision-based experiments we demonstrated that latent states can be recovered which identify the underlying physical quantities. The generative model showed stable long-term predictions far beyond the sequence length used during training. 

## ACKNOWLEDGEMENTS 

Part of this work was conducted at Chair of Robotics and Embedded Systems, Department of Informatics, Technische Universität München, Germany, and supported by the TACMAN project, EC Grant agreement no. 610967, within the FP7 framework programme. 

We would like to thank Jost Tobias Springenberg, Adam Kosiorek, Moritz Münst, and anonymous reviewers for valuable input. 

## REFERENCES 

Justin Bayer and Christian Osendorfer. Learning stochastic recurrent networks. _arXiv preprint arXiv:1411.7610_ , 2014. 

- Charles Blundell, Julien Cornebise, Koray Kavukcuoglu, and Daan Wierstra. Weight uncertainty in neural networks. _arXiv preprint arXiv:1505.05424_ , 2015. 

- Léon Bottou. Large-scale machine learning with stochastic gradient descent. In _Proceedings of COMPSTAT’2010_ , pp. 177–186. Springer, 2010. 

Junyoung Chung, Kyle Kastner, Laurent Dinh, Kratarth Goel, Aaron C. Courville, and Yoshua Bengio. A recurrent latent variable model for sequential data. _CoRR_ , abs/1506.02216, 2015. URL http://arxiv.org/abs/1506.02216. 

Marc Deisenroth and Carl E Rasmussen. Pilco: A model-based and data-efficient approach to policy search. In _Proceedings of the 28th International Conference on machine learning (ICML-11)_ , pp. 465–472, 2011. 

Zoubin Ghahramani and Geoffrey E Hinton. Parameter estimation for linear dynamical systems. Technical report, Technical Report CRG-TR-96-2, University of Toronto, Dept. of Computer Science, 1996. 

Zoubin Ghahramani and Geoffrey E Hinton. Variational learning for switching state-space models. _Neural computation_ , 12(4):831–864, 2000. 

Alex Graves. Generating sequences with recurrent neural networks. _arXiv preprint arXiv:1308.0850_ , 2013. 

- Geoffrey E Hinton and Drew Van Camp. Keeping the neural networks simple by minimizing the description length of the weights. In _Proceedings of the sixth annual conference on Computational learning theory_ , pp. 5–13. ACM, 1993. 

> 4We used the script attached to Sutskever & Hinton (2007) for generating our datasets. 

10 

Published as a conference paper at ICLR 2017 

- Antti Honkela, Tapani Raiko, Mikael Kuusela, Matti Tornio, and Juha Karhunen. Approximate riemannian conjugate gradient learning for fixed-form variational bayes. _Journal of Machine Learning Research_ , 11(Nov):3235–3268, 2010. 

- Matthew J Johnson, David Duvenaud, Alexander B Wiltschko, Sandeep R Datta, and Ryan P Adams. Structured VAEs: Composing probabilistic graphical models and variational autoencoders. _arXiv preprint arXiv:1603.06277_ , 2016. 

- Simon J Julier and Jeffrey K Uhlmann. New extension of the kalman filter to nonlinear systems. In _AeroSense’97_ , pp. 182–193. International Society for Optics and Photonics, 1997. 

- Rudolph E Kalman and Richard S Bucy. New results in linear filtering and prediction theory. _Journal of basic engineering_ , 83(1):95–108, 1961. 

- Diederik P Kingma and Max Welling. Auto-encoding variational bayes. _arXiv preprint arXiv:1312.6114_ , 2013. 

- Jonathan Ko and Dieter Fox. Learning gp-bayesfilters via gaussian process latent variable models. _Autonomous Robots_ , 30(1):3–23, 2011. 

Rahul G Krishnan, Uri Shalit, and David Sontag. Deep Kalman filters. _arXiv preprint arXiv:1511.05121_ , 2015. 

- Stephan Mandt, James McInerney, Farhan Abrol, Rajesh Ranganath, and David Blei. Variational tempering. In _Proceedings of the 19th International Conference on Artificial Intelligence and Statistics_ , pp. 704–712, 2016. 

- Kevin McGoff, Sayan Mukherjee, Natesh Pillai, et al. Statistical inference for dynamical systems: A review. _Statistics Surveys_ , 9:209–252, 2015. 

- Danilo J. Rezende, Shakir Mohamed, and Daan Wierstra. Stochastic backpropagation and approximate inference in deep generative models. In Tony Jebara and Eric P. Xing (eds.), _Proceedings of the 31st International Conference on Machine Learning (ICML-14)_ , pp. 1278–1286. JMLR Workshop and Conference Proceedings, 2014. URL http://jmlr.org/proceedings/ papers/v32/rezende14.pdf. 

- Danilo Jimenez Rezende and Shakir Mohamed. Variational inference with normalizing flows. _arXiv preprint arXiv:1505.05770_ , 2015. 

- Ilya Sutskever and Geoffrey E. Hinton. Learning multilevel distributed representations for high-dimensional sequences. In Marina Meila and Xiaotong Shen (eds.), _Proceedings of the Eleventh International Conference on Artificial Intelligence and Statistics (AISTATS-07)_ , volume 2, pp. 548–555. Journal of Machine Learning Research - Proceedings Track, 2007. URL http://jmlr.csail.mit.edu/proceedings/papers/v2/sutskever07a/ sutskever07a.pdf. 

- Leonid Kuvayev Rich Sutton. Model-based reinforcement learning with an approximate, learned model. In _Proceedings of the ninth Yale workshop on adaptive and learning systems_ , pp. 101–105, 1996. 

- Lucas Theis, Aäron van den Oord, and Matthias Bethge. A note on the evaluation of generative models. _arXiv preprint arXiv:1511.01844_ , 2015. 

- Harri Valpola and Juha Karhunen. An unsupervised ensemble learning method for nonlinear dynamic state-space models. _Neural computation_ , 14(11):2647–2692, 2002. 

- Manuel Watter, Jost Springenberg, Joschka Boedecker, and Martin Riedmiller. Embed to control: A locally linear latent dynamics model for control from raw images. In _Advances in Neural Information Processing Systems_ , pp. 2728–2736, 2015. 

11 

Published as a conference paper at ICLR 2017 

## A SUPPLEMENTARY TO LOWER BOUND 

## A.1 ANNEALED KL-DIVERGENCE 

We used the analytical solution of the annealed KL-divergence in eq. (10) for optimization: 

**==> picture [224 x 43] intentionally omitted <==**

## B SUPPLEMENTARY TO IMPLEMENTATION 

## B.1 EXPERIMENTAL SETUP 

In all our experiments, we use sequences of 15 raw images of the respective system with 16 _×_ 16 pixels each, i.e., observation space _X ⊂_ R[256] , as well as control inputs of varying dimension and interpretation depending on the experiment. We used training, validation and test sets with 500 sequences each. Control input sequences were drawn randomly (“motor babbling”). Additional details about the implementation can be found in the published code at https://brml.org/ projects/dvbf. 

## B.2 ADDITIONAL EXPERIMENT PLOTS 

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [9 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

**==> picture [8 x 8] intentionally omitted <==**

Figure 7: Ground truth and samples from recognition and generative model. Complete version of fig. 4 with all missing samples present. 

## B.3 IMPLEMENTATION DETAILS FOR DVBF IN PENDULUM EXPERIMENT 

- Input: 15 timesteps of 16[2] observation dimensions and 1 action dimension 

- Latent Space: 3 dimensions 

- Observation Network _p_ ( **x** _t|_ **z** _t_ ) = _N_ ( **x** _t_ ; _µ_ ( **z** _t_ ) _, σ_ ): 128 ReLU + 16[2] identity output 

- Recognition Model: 128 ReLU + 6 identity output 

**==> picture [142 x 25] intentionally omitted <==**

- Transition Network _**α** t_ ( **z** _t_ ): 16 softmax output 

- Initial Network **w** 1 _∼ p_ ( **x** 1: _T_ ): Fast Dropout BiRNN with: 128 ReLU + 3 identity output 

- Initial Transition **z** 1( **w** 1): 128 ReLU + 3 identity output 

- Optimizer: adadelta, 0.1 step rate 

- Inverse temperature: _c_ 0 = 0 _._ 01, updated every 250th gradient update, _TA_ = 10[5] iterations 

- Batch-size: 500 

12 

Published as a conference paper at ICLR 2017 

- B.4 IMPLEMENTATION DETAILS FOR DVBF IN BOUNCING BALL EXPERIMENT 

   - Input: 15 timesteps of 16[2] observation dimensions and 2 action dimension 

   - Latent Space: 4 dimensions 

   - Observation Network _p_ ( **x** _t|_ **z** _t_ ) = _N_ ( **x** _t_ ; _µ_ ( **z** _t_ ) _, σ_ ): 128 ReLU + 16[2] identity output 

   - Recognition Model: 128 ReLU + 8 identity output 

_q_ ( **w** _t|_ **z** _t,_ **x** _t_ +1 _,_ **u** _t_ ) = _N_ ( **w** _t_ ; _µ, σ_ ) _,_ ( _µ, σ_ ) = _f_ ( **z** _t,_ **x** _t_ +1 _,_ **u** _t_ ) 

   - Transition Network _**α** t_ ( **z** _t_ ): 16 softmax output 

   - Initial Network **w** 1 _∼ p_ ( **x** 1: _T_ ): Fast Dropout BiRNN with: 128 ReLU + 4 identity output 

   - Initial Transition **z** 1( **w** 1): 128 ReLU + 4 identity output 

   - Optimizer: adadelta, 0.1 step rate 

   - Inverse temperature: _c_ 0 = 0 _._ 01, updated every 250th gradient update, _TA_ = 10[5] iterations 

   - Batch-size: 500 

- B.5 IMPLEMENTATION DETAILS FOR DVBF IN TWO BOUNCING BALLS EXPERIMENT 

   - Input: 15 timesteps of 20[2] observation dimensions and 2000 samples 

   - Latent Space: 10 dimensions 

   - Observation Network _p_ ( **x** _t|_ **z** _t_ ) = _N_ ( **x** _t_ ; _µ_ ( **z** _t_ ) _, σ_ ): 128 ReLU + 20[2] sigmoid output 

   - Recognition Model: 128 ReLU + 20 identity output 

**==> picture [142 x 25] intentionally omitted <==**

   - Transition Network _**α** t_ ( **z** _t_ ): 64 softmax output 

   - Initial Network **w** 1 _∼ p_ ( **x** 1: _T_ ): MLP with: 128 ReLU + 10 identity output 

   - Initial Transition **z** 1( **w** 1): 128 ReLU + 10 identity output 

   - Optimizer: adam, 0.001 step rate 

   - Inverse temperature: _c_ 0 = 0 _._ 01, updated every gradient update, _TA_ = 2 10[5] iterations 

   - Batch-size: 80 

- B.6 IMPLEMENTATION DETAILS FOR DKF IN PENDULUM EXPERIMENT 

   - Input: 15 timesteps of 16[2] observation dimensions and 1 action dimension 

   - Latent Space: 3 dimensions 

   - Observation Network _p_ ( **x** _t|_ **z** _t_ ) = _N_ ( **x** _t_ ; _µ_ ( **z** _t_ ) _, σ_ ( **z** _t_ )): 128 Sigmoid + 128 Sigmoid + 2 16[2] identity output 

   - Recognition Model: Fast Dropout BiRNN 128 Sigmoid + 128 Sigmoid + 3 identity output 

   - Transition Network _p_ ( **z** _t|_ **z** _t−_ 1 _,_ **u** _t−_ 1): 128 Sigmoid + 128 Sigmoid + 6 output 

   - Optimizer: adam, 0.001 step rate 

   - Inverse temperature: _c_ 0 = 0 _._ 01, updated every 25th gradient update, _TA_ = 2000 iterations 

   - Batch-size: 500 

13 

