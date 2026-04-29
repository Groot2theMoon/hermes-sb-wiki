---
source_url: https://arxiv.org/abs/1511.05121
ingested: 2026-04-29
sha256: a10b6d24f761f05f5db998419ee468a72048697ef2df6767e9231852c811d769
---

## **Deep Kalman Filters** 

**Rahul G. Krishnan Uri Shalit David Sontag** Courant Institute of Mathematical Sciences New York University 

## **Abstract** 

Kalman Filters are one of the most influential models of time-varying phenomena. They admit an intuitive probabilistic interpretation, have a simple functional form, and enjoy widespread adoption in a variety of disciplines. Motivated by recent variational methods for learning deep generative models, we introduce a unified algorithm to efficiently learn a broad spectrum of Kalman filters. Of particular interest is the use of temporal generative models for counterfactual inference. We investigate the efficacy of such models for counterfactual inference, and to that end we introduce the “Healing MNIST” dataset where long-term structure, noise and actions are applied to sequences of digits. We show the efficacy of our method for modeling this dataset. We further show how our model can be used for counterfactual inference for patients, based on electronic health record data of 8,000 patients over 4.5 years. 

## **1 Introduction** 

The compilation of Electronic Health Records (EHRs) is now the norm across hospitals in the United States. A patient record may be viewed as a sequence of diagnoses, surgeries, laboratory values and drugs prescribed over time. The wide availability of these records now allows us to apply machine learning techniques to answer medical questions: What is the best course of treatment for a patient? Between two drugs, can we determine which will save a patient? Can we find patients who are “similar” to each other? Our paper introduces new techniques for learning _causal_ generative temporal models from noisy high-dimensional data, that we believe is the first step towards addressing these questions. 

We seek to model the change of the patient’s state over time. We do this by learning a representation of the patient that (1) evolves over time and (2) is sensitive to the effect of the actions taken by doctors. In particular, the approach we adopt is to learn a time-varying, generative model of patients. 

Modelling temporal data is a well studied problem in machine learning. Models such as the Hidden Markov Models (HMM), Dynamic Bayesian Networks (DBN), and Recurrent Neural Networks (RNN) have been proposed to model the probability of sequences. Here, we consider a widely used probabilistic model: Kalman filters (Kalman, 1960). Classical Kalman filters are linear dynamical systems, that have enjoyed remarkable success in the last few decades. From their use in GPS to weather systems and speech recognition models, few other generative models of sequential data have enjoyed such widespread adoption across many domains. 

In classical Kalman filters, the latent state evolution as well as the emission distribution and action effects are modelled as linear functions perturbed by Gaussian noise. However, for real world applications the use of linear transition and emission distribution limits the capacity to model complex phenomena, and modifications to the functional form of Kalman filters have been proposed. For example, the Extended Kalman Filter (Jazwinski, 2007) and the Unscented Kalman Filter (Wan _et al._ , 2000) are two different methods to learn temporal models with non-linear transition and emission distributions (see also Roweis & Ghahramani (2000) and Haykin (2004)). The addition 

1 

of non-linearities to the model makes learning more difficult. Raiko & Tornio (2009) explored ways of using linear approximations and non-linear dynamical factor analysis in order to overcome these difficulties. However, their methods do not handle long-range temporal interactions and scale quadratically with the latent dimension. 

We show that recently developed techniques in variational inference (Rezende _et al._ , 2014; Kingma & Welling, 2013) can be adopted to learn a broad class of the Kalman filters that exist in the literature using a single algorithm. Furthermore, using deep neural networks, we can enhance Kalman filters with arbitrarily complex transition dynamics and emission distributions. We show that we can tractably learn such models by optimizing a bound on the likelihood of the data. 

Kalman filters have been used extensively for optimal control, where the model attempts to capture how actions affect the observations, precipitating the task of choosing the best control signal towards a given objective. We use Kalman filters for a different yet closely related task: performing counterfactual inference. In the medical setting, counterfactual inference attempts to model the effect of an intervention such as a surgery or a drug, on an outcome, e.g. whether the patient survived. The hardness of this problem lies in the fact that typically, for a single patient, we only see one intervention-outcome pair (the patient cannot have taken and not taken the drug). The key point here is that by modelling the sequence of observations such as diagnoses and lab reports, as well as the interventions or actions (in the form of surgeries and drugs administered) across patients, we hope to learn the effect of interventions on a patient’s future state. 

We evaluate our model in two settings. First we introduce “Healing MNIST”, a dataset of perturbed, noisy and rotated MNIST digits. We show our model captures both short- and long-range effects of actions performed on these digits. Second, we use EHR data from 8 _,_ 000 diabetic and pre-diabetic patients gathered over 4.5 years. We investigate various kinds of Kalman filters learned using our framework and use our model to learn the effect anti-diabetic medication has on patients. 

The contributions of this paper are as follows: 

- Develop a method for probabilistic generative modelling of sequences of complex observations, perturbed by non-linear actions, using deep neural nets as a building block. We derive a bound on the log-likelihood of sequential data and an algorithm to learn a broad 

- We evaluate the efficacy of different recognition distributions for inference and learning. 

- We consider this model for use in counterfactual inference with emphasis on the medical setting. To the best of our knowledge, the use of continuous state space models has not been considered for this goal. On a synthetic setting we empirically validate that our model is able to capture patterns within a very noisy setting and model the effect of external actions. On real patient data we show that our model can successfully perform counterfactual inference to show the effect of anti-diabetic drugs on diabetic patients. 

## **2 Background** 

**Kalman Filters** Assume we have a sequence of unobserved variables _z_ 1 _, . . . , zT ∈_ R _[s]_ . For each unobserved variable _zt_ we have a corresponding _observation xt ∈_ R _[d]_ , and a corresponding _action ut ∈_ R _[c]_ , which is also observed. In the medical domain, the variables _zt_ might denote the true state of a patient, the observations _xt_ indicate known diagnoses and lab test results, and the actions _ut_ correspond to prescribed medications and medical procedures which aim to change the state of the patient. The classical Kalman filter models the observed sequence _x_ 1 _, . . . xT_ as follows: 

_zt_ = _Gtzt−_ 1 + _Btut−_ 1 + _ϵt (action-transition) , xt_ = _Ftzt_ + _ηt (observation),_ where _ϵt ∼N_ (0 _,_ Σ _t_ ), _ηt ∼N_ (0 _,_ Γ _t_ ) are zero-mean i.i.d. normal random variables, with covariance matrices which may vary with _t_ . This model assumes that the latent space evolves linearly, transformed at time _t_ by the state-transition matrix _Gt ∈_ R _[s][×][s]_ . The effect of the control signal _ut_ is an additive linear transformation of the latent state obtained by adding the vector _Btut−_ 1, where _Bt ∈_ R _[s][×][c]_ is known as the _control-input model_ . Finally, the observations are generated linearly from the latent state via the observation matrix _Ft ∈_ R _[d][×][s]_ . 

In the following sections, we show how to replace all the linear transformations with non-linear transformations parameterized by neural nets. The upshot is that the non-linearity makes learning 

2 

much more challenging, as the posterior distribution _p_ ( _z_ 1 _, . . . zT |x_ 1 _, . . . , xT , u_ 1 _, . . . , uT_ ) becomes intractable to compute. 

**Stochastic Backpropagation** In order to overcome the intractability of posterior inference, we make use of recently introduced variational autoencoders (Rezende _et al._ , 2014; Kingma & Welling, 2013) to optimize a variational lower bound on the model log-likelihood. The key technical innovation is the introduction of a _recognition network_ , a neural network which approximates the intractable posterior. 

Let _p_ ( _x, z_ ) = _p_ 0( _z_ ) _pθ_ ( _x|z_ ) be a generative model for the set of observations _x_ , where _p_ 0( _z_ ) is the prior on _z_ and _pθ_ ( _x|z_ ) is a generative model parameterized by _θ_ . In a model such as the one we posit, the posterior distribution _pθ_ ( _z|x_ ) is typically intractable. Using the well-known variational principle, we posit an approximate posterior distribution _qφ_ ( _z|x_ ), also called a _recognition model_ - see Figure 1a. We then obtain the following lower bound on the marginal likelihood: 

**==> picture [355 x 47] intentionally omitted <==**

where the inequality is by Jensen’s inequality. Variational autoencoders aim to maximize the lower bound using a parametric model _qφ_ conditioned on the input. Specifically, Rezende _et al._ (2014); Kingma & Welling (2013) both suggest using a neural net to parameterize _qφ_ , such that _φ_ are the parameters of the neural net. The challenge in the resulting optimization problem is that the lower bound (1) includes an expectation w.r.t. _qφ_ , which implicitly depends on the network parameters _φ_ . This difficulty is overcome by using _stochastic backpropagation_ : assuming that the latent state is normally distributed _qφ_ ( _z|x_ ) _∼N_ ( _µφ_ ( _x_ ) _,_ Σ _φ_ ( _x_ )), a simple transformation allows one to obtain Monte Carlo estimates of the gradients of E _qφ_ ( _z|x_ ) [log _pθ_ ( _x|z_ )] with respect to _φ_ . The KL term in (1) can be estimated similarly since it is also an expectation. If we assume that the prior _p_ 0( _z_ ) is also normally distributed, the KL and its gradients may be obtained analytically. 

**Counterfactual Estimation** Counterfactual estimation is the task of inferring the probability of a result given different circumstances than those empirically observed. For example, in the medical setting, one is often interested in questions such as “What would the patient’s blood sugar level be had she taken a different medication?”. Knowing the answers to such questions could lead to better and more efficient healthcare. We are interested in providing better answers to this type of questions, by leveraging the power of large-scale Electronic Health Records. 

Pearl (2009) framed the problem of counterfactual estimation in the language of graphical models and _do_ -calculus. If one knows the graphical model of the variables in question, then for some structures estimation of counterfactuals is possible by setting a variable of interest (e.g. medication prescribed) to a given value and performing inference on a derived sub-graph. In this work, we do not seek to learn the true underlying causal graph structure but rather seek to use _do_ -calculus to observe the effect of interventions under a causal interpretation of the model we posit. 

## **3 Related Work** 

The literature on sequential modeling and Kalman filters is vast and here we review some of the relevant work on the topic with particular emphasis on recent work in machine learning. We point the reader to Haykin (2004) for a summary of some approaches to learn Kalman filters. 

Mirowski & LeCun (2009) model sequences using dynamic factor graphs with an EM-like procedure for energy minimization. Srivastava _et al._ (2015) consider unsupervised learning of video representations with LSTMs. They encode a sequence in a fixed length hidden representation of an LSTM-RNN and reconstruct the subsequent sequence based on this representation. Gregor _et al._ (2015) consider a temporal extension to variational autoencoders where independent latent variables perturb the hidden state of an RNN across time. 

Langford _et al._ (2009) adopt a different approach to learn nonlinear dynamical systems using blackbox classifiers. Their method relies on learning three sets of classifiers. The first is trained to construct a compact representation _st_ to predict the _xt_ +1 from _xt_ , the second uses _st−_ 1 and _xt−_ 1 to 

3 

predict _st_ . The third trains classifiers to use _s<t_ to predict _st_ and consequently _xt_ . In essence, the latent space _st_ is constructed using these classifiers. 

Gan _et al._ (2015) similarly learn a generative model by maximizing a lower bound on the likelihood of sequential data but do so in a model with discrete random variables. 

Bayer & Osendorfer (2014) create a stochastic variant of Recurrent Neural Networks (RNNs) by making the hidden state of the RNN a function of stochastically sampled latent variables at every time step. Chung _et al._ (2015) model sequences of length _T_ using _T_ variational autoencoders. They use a single RNN that (1) shares parameters in the inference and generative network and (2) models the parameters of the prior and approximation to the posterior at time _t ∈_ [1 _, . . . T_ ] as a deterministic function of the hidden state of the RNN. There are a few key differences between their work and ours. First, they do not model the effect of external actions on the data, and second, their choice of model ties together inference and sampling from the model whereas we consider decoupled generative and recognition networks. Finally, the time varying “memory” of their resulting generative model is both deterministic and stochastic whereas ours is entirely stochastic. i.e our model retains the Markov Property and other conditional independence statements held by Kalman filters. 

Learning Kalman filters with Multi-Layer Perceptrons was considered by Raiko & Tornio (2009). They approximate the posterior using non-linear dynamic factor analysis (Valpola & Karhunen, 2002), which scales quadratically with the latent dimension. Recently, Watter _et al._ (2015) use temporal generative models for optimal control. While Watter _et al._ aim to learn a locally linear latent dimension within which to perform optimal control, our goal is different: we wish to model the data in order to perform counterfactual inference. Their training algorithm relies on approximating the bound on the likelihood by training on consecutive pairs of observations. 

In general, control applications deal with domains where the effect of action is instantaneous, unlike in the medical setting. In addition, most control scenarios involve a setting such as controlling a robot arm where the control signal has a major effect on the observation; we contrast this with the medical setting where medication can often have a weak impact on the patient’s state, compared with endogenous and environmental factors. 

For a general introduction to estimating expected counterfactual effects over a population - see Morgan & Winship (2014); H¨ofler (2005); Rosenbaum (2002). For insightful work on counterfactual inference, in the context of a complex machine-learning and ad-placement system, see Bottou _et al._ (2013). 

Recently, Velez (2013) use a partially observable Markov process for modeling diabetic patients over time, finding that the latent state corresponds to relevant lab test levels (specifically, A1c levels). 

## **4 Model** 

Our goal is to fit a generative model to a sequence of observations and actions, motivated by the nature of patient health record data. We assume that the observations come from a latent state which evolves over time. We assume the observations are a noisy, non-linear function of this latent state. Finally, we also assume that we can observe actions, which affect the latent state in a possibly non-linear manner. 

Denote the sequence of observations _⃗x_ = ( _x_ 1 _, . . . , xT_ ) and actions _⃗u_ = ( _u_ 1 _, . . . , uT −_ 1), with corresponding latent states _⃗z_ = ( _z_ 1 _, . . . , zT_ ). As previously, we assume that _xt ∈_ R _[d]_ , _ut ∈_ R _[c]_ , and _zt ∈_ R _[s]_ . The generative model for the deep Kalman filter is then given by: 

**==> picture [304 x 39] intentionally omitted <==**

That is, we assume that the distribution of the latent states is Normal, with a mean and covariance which are nonlinear functions of the previous latent state, the previous actions, and the time different 

4 

∆ _t_ between time _t −_ 1 and time _t_[1] . The observations _xt_ are distributed according to a distribution Π (e.g. a Bernoulli distribution if the data is binary) whose parameters are a function of the corresponding latent state _zt_ . Specifically, the functions _Gα, Sβ, Fκ_ are assumed to be parameterized by deep neural networks. We set _µ_ 0 = 0, Σ0 = _Id_ , and therefore we have that _θ_ = _{α, β, κ}_ are the parameters of the generative model. We use a diagonal covariance matrix _Sβ_ ( _·_ ), and employ a log-parameterization, thus ensuring that the covariance matrix is positive-definite. The model is presented in Figure 1b, along with the recognition model _qφ_ which we outline in Section 5. 

The key point here is that Eq. (2) subsumes a large family of linear and non-linear latent space models. By restricting the functional forms of _Gα, Sβ, Fκ_ , we can train different kinds of Kalman filters within the framework we propose. For example, by setting _Gα_ ( _zt−_ 1 _, ut−_ 1) = _Gtzt−_ 1 + _Btut−_ 1 _, Sβ_ = Σ _t, Fκ_ = _Ftzt_ where _Gt, Bt,_ Σ _t, Ft_ are matrices, we obtain classical Kalman filters. In the past, modifications to the Kalman filter typically introduced a new learning algorithm and heuristics to approximate the posterior more accurately. In contrast, within the framework we propose any parametric differentiable function can be substituted in for one of _Gα, Sβ, Fκ_ . Learning any such model can be done using backpropagation as will be detailed in the next section. 

**==> picture [311 x 132] intentionally omitted <==**

**----- Start of picture text -----**<br>
u 1 u T − 1<br>φ z θ z 1 z 2 . . . z T<br>x 1 x 2 . . . x T<br>x<br>qφ ( ~z | ~x, ~u )<br>(a) Variational Autoencoder (b) Deep Kalman Filter<br>**----- End of picture text -----**<br>


Figure 1: (a): Learning static generative models. Solid lines denote the generative model _p_ 0( _z_ ) _pθ_ ( _x|z_ ), dashed lines denote the variational approximation _qφ_ ( _z|x_ ) to the intractable posterior _p_ ( _z|x_ ). The variational parameters _φ_ are learned jointly with the generative model parameters _θ_ . (b): Learning in a Deep Kalman Filter. A parametric approximation to _pθ_ ( _⃗z|⃗x_ ), denoted _qφ_ ( _⃗z|⃗x, ⃗u_ ), is used to perform inference during learning. 

## **5 Learning using Stochastic Backpropagation** 

## **5.1 Maximizing a Lower Bound** 

We aim to fit the generative model parameters _θ_ which maximize the conditional likelihood of the data given the external actions, i.e we desire max _θ_ log _pθ_ ( _x_ 1 _. . . , xT |u_ 1 _. . . uT −_ 1). Using the variational principle, we apply the lower bound on the log-likelihood of the observations _⃗x_ derived in Eq. (1). We consider the extension of the Eq. (1) to the temporal setting where we use the following factorization of the prior: 

**==> picture [284 x 30] intentionally omitted <==**

We motivate this structured factorization of _qφ_ in Section 5.2. We condition the variational approximation not just on the inputs _⃗x_ but also on the actions _⃗u_ . 

Our goal is to derive a lower bound to the conditional log-likelihood in a form that will factorize easily and make learning more amenable. The lower bound in Eq. (1) has an analytic form of the KL term only for the simplest of transition models _Gα, Sβ_ . Resorting to sampling for estimating the gradient of the KL term results in very high variance. Below we show another way to factorize the KL term which results in more stable gradients, by using the Markov property of our model. 

> 1More precisely, this is a _semi-Markov_ model, and we assume that the time intervals are modelled separately. In our experiments we consider homogeneous time intervals. 

5 

## **Algorithm 1** Learning Deep Kalman Filters 

**while** _notConverged_ () **do** _⃗x ← sampleMiniBatch_ () Perform inference and estimate likelihood: ˆ 1. _z_ ˆ _∼ qφ_ ( _⃗z|⃗x, ⃗u_ ˆ ) 2. _x ∼ pθ_ ( _⃗x|z_ ) 3. Compute _∇θL_ and _∇φL_ (Differentiating (5)) 4. Update _θ, φ_ using ADAM **end while** 

We have for the conditional log-likelihood (see Supplemental Section A for a more detailed derivation): 

**==> picture [400 x 81] intentionally omitted <==**

The KL divergence can be factorized as: 

**==> picture [375 x 114] intentionally omitted <==**

This yields: 

**==> picture [322 x 80] intentionally omitted <==**

Equation (5) is differentiable in the parameters of the model ( _θ, φ_ ), and we can apply backpropagation for updating _θ_ , and stochastic backpropagation for estimating the gradient w.r.t. _φ_ of the expectation terms w.r.t. _qφ_ ( _zt_ ). Algorithm 1 depicts the learning algorithm. It can be viewed as a four stage process. The first stage is inference of _⃗z_ from an input _⃗x_ , _⃗u_ by the recognition network _qφ_ . The second stage is having the generative model _pθ_ reconstruct the input using the current estimates of the posterior. The third stage involves estimating gradients of the likelihood with respect to _θ_ and _φ_ , and the fourth stage involves updating parameters of the model. Gradients are typically averaged across stochastically sampled mini-batches of the training set. 

## **5.2 On the choice of the Optimal Variational Model** 

For time varying data, there exist many choices for the recognition network. We consider four variational models of increasing complexity. Each model conditions on a different subset of the observations through the use of Multi-Layer Perceptrons (MLP) and Recurrent Neural Nets (RNN) (As implemented in Zaremba & Sutskever (2014)): 

6 

- **q-INDEP** : _q_ ( _zt|xt, ut_ ) parameterized by an MLP 

- **q-LR** : _q_ ( _zt|xt−_ 1 _, xt, xt_ +1 _, ut−_ 1 _, ut, ut_ +1) parameterized by an MLP 

- **q-RNN** : _q_ ( _zt|x_ 1 _, . . . , xt, u_ 1 _, . . . ut_ ) parameterized by a RNN 

- **q-BRNN** : _q_ ( _zt|x_ 1 _, . . . , xT , u_ 1 _, . . . , uT_ ) parameterized by a bi-directional RNN 

In the experimental section we compare the performance of these four models on a challenging sequence reconstruction task. 

An interesting question is whether the Markov properties of the model can enable better design of approximations to the posterior. 

**Theorem 5.1.** _For the graphical model depicted in Figure 1b, the posterior factorizes as:_ 

**==> picture [266 x 30] intentionally omitted <==**

_Proof._ We use the independence statements implied by the generative model in Figure 1b to note that _p_ ( _⃗z|⃗x, ⃗u_ ), the true posterior, factorizes as: 

**==> picture [170 x 30] intentionally omitted <==**

Now, we notice that _zt ⊥⊥ x_ 1 _, . . . , xt−_ 1 _|zt−_ 1 and _zt ⊥⊥ u_ 1 _. . . , ut−_ 2 _|zt−_ 1, yielding: 

**==> picture [266 x 30] intentionally omitted <==**

The significance of Theorem 5.1 is twofold. First, it tells us how we can use the Markov structure of our graphical model to simplify the posterior that any _qφ_ ( _⃗z_ ) must approximate. Second, it yields insight on how to design approximations to the true posterior. Indeed this motivated the factorization of _qφ_ in Eq. 3. Furthermore, instead of using a bi-directional RNN to approximate _p_ ( _zt|⃗x, ⃗u_ ) by summarizing both the past and the future ( _x_ 1 _, . . . , xT_ ), one can approximate the same posterior distribution using a single RNN that summarizes the future ( _xt, . . . , xT_ ) as long as one also conditions on the previous latent state ( _zt−_ 1). Here, _zt−_ 1 serves as a summary of _x_ 1 _, . . . , xt−_ 1. 

For the stochastic backpropagation model, the variational lower bound is tight if and only if KL( _qφ_ ( _z|x_ ) _||pθ_ ( _z|x_ )) = 0. In that case, we have that _L_ ( _x_ ; ( _θ, φ_ )) = log _pθ_ ( _x_ ), and the optimization objective (5) reduces to a maximum likelihood objective. In the stochastic backpropagation literature, the variational distribution _qφ_ ( _z|x_ ) is usually Gaussian and therefore cannot be expected to be equal to _pθ_ ( _z|x_ ). An interesting question is whether using the idea of the universality of normalizing flows (Tabak _et al._ , 2010; Rezende & Mohamed, 2015) one can transform _qφ_ ( _z|x_ ) to be equal (or arbitrarily close) to _pθ_ ( _z|x_ ) and thus attain equality in the lower bound. Such a result leads to a consistency result for the learned model, stemming from the consistency of maximum likelihood. 

## **5.3 Counterfactual Inference** 

Having learned a generative temporal model, we can use the model to perform counterfactual inference. Formally, consider a scenario where we are interested in evaluating the effect of an intervention at time _t_ . We can perform inference on the set of observations: _{x_ 1 _, . . . , xt, u_ 1 _, . . . , ut−_ 1 _}_ using the learnedpatient) as well as _qφ_ . This gives us an estimate _u_ ˜ _t_ (the action to be contrasted against). _zt_ . At this point, we can applyWe can forward sample from this latent _ut_ (the action intended for the state in order to contrast the expected effect of different actions. 

7 

## **6 Experimental Section** 

We implement and train models in Torch (Collobert _et al._ , 2011) using ADAM (Kingma & Ba, 2014) with a learning rate of 0 _._ 001 to perform gradient ascent. Our code is implemented to parameterize log _Sβ_ during learning. We use a two-layer Long-Short Term Memory Recurrent Neural Net (LSTMRNN, Zaremba & Sutskever (2014)) for sequential variational models. We regularize models during training (1) using dropout (Srivastava _et al._ , 2014) with a noise of 0 _._ 1 to the input of the recognition model (2) through the addition of small random uniform noise (on the order of a tenth of the maximal value) to the actions. 

**Comparing recognition models** We experiment with four choices of variational models of increasing complexity: **q-INDEP** where _q_ ( _zt|xt_ ) is parameterized by an MLP, **q-LR** where _q_ ( _zt|xt−_ 1 _, xt, xt_ +1) is parameterized by an MLP, **q-RNN** where _q_ ( _zt|x_ 1 _, . . . , xt_ ) is parameterized by an RNN, and **q-BRNN** where _q_ ( _zt|x_ 1 _, . . . , xT_ ) is parameterized by a bi-directional RNN. 

## **6.1 Healing MNIST** 

Healthcare data exhibits diverse structural properties. Surgeries and drugs vary in their effect as a function of patient age, gender, ethnicity and comorbidities. Laboratory measurements are often noisy, and diagnoses may be tentative, redundant or delayed. In insurance health claims data, the situation is further complicated by arcane, institutional specific practices that determine how decisions made by healthcare professions are repurposed into codes used for reimbursements. 

To mimic learning under such harsh conditions, we consider a synthetic dataset derived from the MNIST Handwritten Digits (LeCun & Cortes, 2010). We select several digits and create a synthetic dataset where rotations are performed to the digits. The rotations are encoded as the actions ( _⃗u_ ) and the rotated images as the observations ( _⃗x_ ). This realizes a sequence of rotated images. To each such generated training sequence, exactly one sequence of three consecutive squares is superimposed with the top-left corner of the images in a random starting location, and add up to 20% bit-flip noise. We consider two experiments: **Small Healing MNIST** , using a single example of the digit 1 and digit 5, and **Large Healing MNIST** where 100 different digits (one hundred 5’s and one hundred 1’s) are used. The training set comprises approximately 40000 sequences of length five for **Small Healing MNIST** , and 140000 sequences of length five for **Large Healing MNIST** . The large dataset represents the temporal evolution of two distinct subpopulations of patients (of size 100 each). The squares within the sequences are intended to be analogous to seasonal flu or other ailments that a patient could exhibit that are independent of the actions and which last several timesteps. 

The challenges present within this dataset are numerous. (1) Image data is intrinsically high dimensional and much recent work has focused on learning patterns from it. It represents a setting where the posterior is complex and often requires highly non-linear models in order to approximate it. The additions of rotated images to the training data adds more complexity to the task. (2) In order to learn through random noise that is this high, one needs to have a model of sequences capable of performing “filtering”. Models that rely on predicting the next image based on the previous one (Goroshin _et al._ , 2015; Memisevic, 2013) may not suffice to learn the structure of digits in the presence of large noise and rotation. Furthermore, long-range patterns - e.g. the three consecutive blocks in the upper-left corner - that exist in the data are beyond the scope of such models. 

We learn models using the four recognition models described in Section 5. Figure 2a shows examples of training sequences (marked **TS** ) from **Large Healing MNIST** provided to the model, and their corresponding reconstructions (marked **R** ). The reconstructions are performed by feeding the input sequence into the learned recognition network, and then sampling from the resulting posterior distribution. Recall that the model posits _⃗x_ drawn from an independent Bernoulli distribution whose mean parameters (denoted mean probabilities) we visualize. We discuss results in more detail below. 

## **Small Healing MNIST: Comparing Recognition Models** 

We evaluated the impact of different variational models on learning by examining test log-likelihood and by visualizing the samples generated by the models. Since **q-RNN** and **q-BRNN** have more parameters by virtue of their internal structure, we added layers to the **q-INDEP** network (6 layers) and **q-LR** network (4 layers) until training on the dataset was infeasible - i.e. did not make any 

8 

**==> picture [241 x 260] intentionally omitted <==**

**----- Start of picture text -----**<br>
Small Rotation Right<br>R Small Rotation Left<br>TS<br>R<br>Large Rotation Right<br>TS<br>R<br>TS Large Rotation Left<br>R<br>TS<br>No Rotation<br>R<br>TS<br>**----- End of picture text -----**<br>


**==> picture [113 x 242] intentionally omitted <==**

(a) Reconstruction during training (b) Samples: Different rotations (c) Inference on unseen digits 

Figure 2: **Large Healing MNIST** . (a) Pairs of Training Sequences (TS) and Mean Probabilities of Reconstructions (R) shown above. (b) Mean probabilities sampled from the model under different, constant rotations. (c) Counterfactual Reasoning. We reconstruct variants of the digits 5 _,_ 1 _not_ present in the training set, with (bottom) and without (top) bit-flip noise. We infer a sequence of 1 timestep and display the reconstructions from the posterior. We then keep the latent state and perform forward sampling and reconstruction from the generative model under a constant right rotation. 

**==> picture [396 x 191] intentionally omitted <==**

**----- Start of picture text -----**<br>
− 2040<br>− 2050<br>− 2060<br>− 2070<br>q-BRNN<br>− 2080<br>q-RNN<br>− 2090 q-LR<br>− 2100 q-INDEP<br>− 2110<br>0 100 200 300 400 500<br>Epochs<br>(b) Test Log-Likelihood for models trained with<br>(a) Samples from models trained with different  qφ different  qφ<br>-BRNN<br>q<br>q-RNN<br>q-LR<br>Test Log Likelihood<br>-INDEP<br>q<br>**----- End of picture text -----**<br>


Figure 3: **Small Healing MNIST** : (a) Mean probabilities sampled under different variational models with a constant, large rotation applied to the right. (b) Test log-likelihood under different recognition models. 

9 

gains after more than 100 epochs of training[2] . Figure 3b depicts the log-likelihood under the test set (we estimate test log-likelihood using importance sampling based on the recognition network - see Supplemental Section A). Figure 3a depicts pairs of sequence samples obtained under each of the variational models. 

It is unsurprising that **q-BRNN** outperforms the other variants. In a manner similar to the ForwardBackward algorithm, the Bi-Directional RNN summarizes the past and the future at every timestep to form the most effective approximation to the posterior distribution of _zt_ . 

It is also not surprising that **q-INDEP** performs poorly, both in the quality of the samples and in held out log-likelihood. Given the sequential nature of the data, the posterior for _zt_ is poorly approximated when only given access to _xt_ . The samples capture the effect of rotation but not the squares. 

Although the test log-likelihood was better for **q-LR** than for **q-RNN** , the samples obtained were worse off - in particular, they did not capture the three consecutive block structure. The key difference between **q-LR** and **q-RNN** is the fact that the former has no memory that it carries across time. This facet will likely be more relevant in sequences where there are multiple patterns and the recognition network needs to remember the order in which the patters are generated. 

Finally, we note that both **q-RNN** and **q-BRNN** learn generative models with plausible samples. 

## **Large Healing MNIST** 

Figure 2a depicts pairs of training sequences, and the mean probabilities obtained after reconstruction as learning progresses. There are instances (first and third from the top) where the noise level is too high for the structure of the digit to be recognized from the training data alone. The reconstructions also shows that the model learns different styles of the digits (corresponding to variances within individual patients). 

Figure 2b depicts samples from the model under varying degrees of rotation (corresponding to the intensity of a treatment for example). Here again, the model shows that it is capable of learning variations within the digit as well as realizing the effect of an action and its intensity. This is a simple form of counterfactual reasoning that can be performed by the model, since none of the samples on display are within the training set. 

Figure 2c answers two questions. The first is what happens when we ask the model to reconstruct on data that looks similar to the training distribution but not the same. The input image is on the left (with a clean and noisy version of the digit displayed) and the following sample represent the reconstruction by the variational model of a sequence created from the input images. Following this, we forward sample from the model using the inferred latent representation under a constant action. 

To this end, we consider digits of the same class (i.e. 1 _,_ 5) but of a different style than the model was trained on. This idea has parallels within the medical setting where one asks about the course of action for a new patient. On this unseen patient, the model would infer a latent state similar to a patient that exists in the training set. This facet of the model motivates further investigation into the model’s capabilities as a metric for patient similarity. To simulate the medical question: What would happen if the doctor prescribed the drug “rotate right mildly”? We forward sample from the model under this action. 

In most cases, noisy or not, the patient’s reconstruction matches a close estimate of a digit found in the training set (close in log-likelihood since this is the criterion the emission distribution was trained on). The final four rows depict scenarios in which the noise level is too high and we don’t show the model enough sequences to make accurate inferences about the digit. 

## **6.2 Generative Models of Medical Data** 

We learn a generative model on healthcare claims data from a major health insurance provider. We look into the effect of anti-diabetic drugs on a population of 8000 diabetic and pre-diabetic patients. 

> 2In particular, we found that adding layers to the variational model helped but only up to a certain point. Beyond that, learning the model was infeasible. 

10 

**==> picture [395 x 294] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.0 With diabetic drugs 1.0 Without diabetic drugs<br>0.8 0.8<br>0.6 0.6<br>− 80<br>0.4 0.4<br>− 90<br>0.2 0.2<br>− 100<br>− 110 0.00 2 4 6 8 10 12 0.00 2 4 6 8 10 12<br>Time Steps Time Steps<br>− 120<br>Em: L, Tr: NL (b)<br>− 130 Em: NL, Tr: NL 1.0 With diabetic drugs 1.0 Without diabetic drugs<br>− 140 Em: L, Tr: L<br>Em: NL, Tr: L 0.8 0.8<br>− 150<br>0 500 1000 1500 2000<br>Epochs 0.6 0.6<br>0.4 0.4<br>(a) Test Log-Likelihood<br>0.2 0.2<br>0.0 0.0<br>0 2 4 6 8 10 12 0 2 4 6 8 10 12<br>Time Steps Time Steps<br>(c)<br>Glucose Glucose<br>high high<br>with with<br>patients patients<br>of of<br>Proportion Proportion<br>LL<br>Test<br>A1c A1c<br>high high<br>with with<br>patients patients<br>of of<br>Proportion Proportion<br>**----- End of picture text -----**<br>


Figure 4: Results of disease progression modeling for 8000 diabetic and pre-diabetic patients. (a) Test loglikelihood under different model variants. Em(ission) denotes _Fκ_ , Tr(ansition) denotes _Gα_ under Linear (L) and Non-Linear (NL) functions. We learn a fixed diagonal _Sβ_ . (b) Proportion of patients inferred to have high (top quantile) glucose level with and without anti-diabetic drugs, starting from the time of first Metformin prescription. (c) Proportion of patients inferred to have high (above 8%) A1c level with and without antidiabetic drugs, starting from the time of first Metformin prescription. Both (b) and (c) are created using the model trained with non-linear emission and transition functions. 

The (binary) observations of interest here are: A1c level (hemoglobin A1c, a type of protein commonly used in the medical literature to indicate level of diabetes where high A1c level are an indicator for diabetes) and glucose (the amount of a patient’s blood sugar). We bin glucose into quantiles and A1c into medically meaningful bins. The observations also include age, gender and ICD-9 diagnosis codes depicting various comorbidities of diabetes such as congestive heart failure, chronic kidney disease and obesity. 

For actions, we consider prescriptions of nine diabetic drugs including Metformin and Insulin, where Metformin is the most commonly prescribed first-line anti-diabetic drug. For each patient, we group their data over four and half years into three months intervals. 

We aim to assess the effect of anti-diabetic drugs on a patient’s A1c and glucose levels. To that end, we ask a counterfactual question: how would the patient’s A1c and glucose levels be had they not received the prescribed medications as observed in the dataset. 

A complication in trying to perform counterfactual inference for the A1c and glucose levels is that these quantities are not always measured for each patient at each time step. Moreover, patients who are suspected of being diabetic are tested much more often for their A1c and glucose levels, compared with healthy patients, creating a confounding factor, since diabetic patients tend to have higher A1c and glucose levels. To overcome this we add an observation variable called “lab indicator”, denoted _x_[ind] , which indicates whether the respective lab test, either A1c or glucose, was taken regardless of its outcome. We condition the time _t_ lab indicator observation, _xt_[ind] , on the latent state _zt_ , and we condition the A1c and glucose value observations on both the latent state and the lab indicator observation. That way, once the model is trained we can perform counterfactual inference by using the _do_ -operator on the lab indicator: setting it to 1 and ignoring its dependence on the latent state. See Figure 5 for an illustration of the model. 

11 

**==> picture [330 x 107] intentionally omitted <==**

**----- Start of picture text -----**<br>
zt − 1 zt zt + 1 zt − 1 zt zt + 1<br>1<br>xt [ind]<br>xt xt<br>(a) Graphical model during training (b) Graphical model during counterfactual<br>inference<br>**----- End of picture text -----**<br>


Figure 5: (a) Generative model with lab indicator variable, focusing on time step _t_ . (b) For counterfactual ind inference we set _xt_ to 1, implementing Pearl’s _do_ -operator 

We train the model on a dataset of 8000 patients. We use **q-BRNN** as the recognition model. 

**Variants of Kalman Filters:** Figure 4(a) depicts the test log likelihood under variants of the graphical model depicted in Figure 1b. **Em** (ission) denotes _Fκ_ , the emission function, and **Tr** (ansition) denotes _Gα_ , the transition function of the mean. We learn a fixed diagonal covariance matrix ( _Sβ_ ). See Eq. (2) for the role these quantities play in the generative model. Linear (L) denotes a linear relationship between entities, and Non-Linear (NL) denotes a non-linear one parameterized by a two-layer neural network. Early in training, a non-linear emission function suffices to achieve a high test log likelihood though as training progresses the models with non-linear transition functions dominate. 

**Counterfactual Inference:** We use a model with non-linear transition and non-linear emission functions. We look at patients whose first prescribed anti-diabetic drug was Metformin, the most common first-line anti-diabetic drug, and who have at least six months of data before the first Metformin prescription. This leaves us with 800 patients for whom we ask the counterfactual question. For these patients, we infer the latent state up to the time _t_ 0 of first Metformin prescription. After _t_ 0 we perform forward sampling under two conditions: the “ **with** ” condition is using the patient’s true medication prescriptions; the “ **without** ” condition is removing the medication prescriptions, simulating a patient who receives no anti-diabetic medication. In both cases we set the lab indicator variable _xt_[ind] to be 1, so we can observe the A1c and glucose lab values. We then compare the inferred A1c and glucose lab values between the “ **with** ” and “ **without** ” conditions after the time of first Metformin prescription. Figure 4 presents the results, where we track the proportion of patients with high glucose level (glucose in the top quantile) and high A1c levels (A1c above 8%), starting from the time of first Metformin prescription. It is evident that patients who do not receive the anti-diabetic drugs are much more prone to having high glucose and A1c levels. 

## **7 Discussion** 

We show promising results that nonlinear-state space models can be effective models for counterfactual analysis. The parametric posterior can be used to approximate the latent state of unseen data. We can forward sample from the model under different actions and observe their consequent effect. Beyond counterfactual inference, the model represents a natural way to embed patients into latent space making it possible to ask questions about patient similarity. Another avenue of work is understanding whether the latent variable space encodes identifiable characteristics of a patient and whether the evolution of the latent space corresponds to known disease trajectories. 

There exists interesting avenues of future work for our model in a multitude of areas. A natural question that arises, particularly with models trained on the Healing MNIST is the quality of temporal and spatial invariance in the learned filters. Unsupervised learning of videos is another domain where our model holds promise. Approaches such as (Srivastava _et al._ , 2015) model video sequences using LSTMs with deterministic transition operators. The effect of stochasticity in the latent space is an interesting one to explore. 

12 

## **Acknowledgements** 

The Tesla K40s used for this research were donated by the NVIDIA Corporation. The authors gratefully acknowledge support by the DARPA Probabilistic Programming for Advancing Machine Learning (PPAML) Program under AFRL prime contract no. FA8750-14-C-0005, ONR #N0001413-1-0646, and NSF CAREER award #1350965. 

## **References** 

Bayer, Justin, & Osendorfer, Christian. 2014. Learning Stochastic Recurrent Networks. _arXiv preprint arXiv:1411.7610_ . 

Bottou, L´eon, Peters, Jonas, Quinonero-Candela, Joaquin, Charles, Denis X, Chickering, D Max, Portugaly, Elon, Ray, Dipankar, Simard, Patrice, & Snelson, Ed. 2013. Counterfactual reasoning and learning systems: The example of computational advertising. _The Journal of Machine Learning Research_ , **14** (1), 3207–3260. 

Chung, Junyoung, Kastner, Kyle, Dinh, Laurent, Goel, Kratarth, Courville, Aaron, & Bengio, Yoshua. 2015. A Recurrent Latent Variable Model for Sequential Data. _arXiv preprint arXiv:1506.02216_ . 

Collobert, Ronan, Kavukcuoglu, Koray, & Farabet, Cl´ement. 2011. Torch7: A matlab-like environment for machine learning. _In: BigLearn, NIPS Workshop_ . 

Gan, Zhe, Li, Chunyuan, Henao, Ricardo, Carlson, David, & Carin, Lawrence. 2015. Deep Temporal Sigmoid Belief Networks for Sequence Modeling. 

Goroshin, Ross, Mathieu, Michael, & LeCun, Yann. 2015. Learning to Linearize under Uncertainty. _arXiv preprint arXiv:1506.03011_ . 

Gregor, Karol, Danihelka, Ivo, Graves, Alex, Rezende, Danilo Jimenez, & Wierstra, Daan. 2015. DRAW: A Recurrent Neural Network For Image Generation. _In: Proceedings of the 32nd International Conference on Machine Learning, ICML 2015, Lille, France, 6-11 July 2015_ . 

Haykin, Simon. 2004. _Kalman filtering and neural networks_ . Vol. 47. John Wiley & Sons. 

H¨ofler, M. 2005. Causal inference based on counterfactuals. _BMC medical research methodology_ , **5** (1), 28. 

Jazwinski, Andrew H. 2007. _Stochastic processes and filtering theory_ . Courier Corporation. 

Kalman, Rudolph Emil. 1960. A new approach to linear filtering and prediction problems. _Journal of Fluids Engineering_ , **82** (1), 35–45. 

Kingma, Diederik, & Ba, Jimmy. 2014. Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ . 

Kingma, Diederik P, & Welling, Max. 2013. Auto-encoding variational bayes. _arXiv preprint arXiv:1312.6114_ . 

Langford, John, Salakhutdinov, Ruslan, & Zhang, Tong. 2009. Learning Nonlinear Dynamic Models. _Pages 593–600 of: Proceedings of the 26th Annual International Conference on Machine Learning_ . ACM. 

LeCun, Yann, & Cortes, Corinna. 2010. MNIST handwritten digit database. _AT&T Labs [Online]. Available: http://yann. lecun. com/exdb/mnist_ . 

Memisevic, Roland. 2013. Learning to Relate Images. _Pattern Analysis and Machine Intelligence, IEEE Transactions on_ , **35** (8), 1829–1846. 

Mirowski, Piotr, & LeCun, Yann. 2009. Dynamic factor graphs for time series modeling. _Pages 128–143 of: Machine Learning and Knowledge Discovery in Databases_ . Springer. 

Morgan, Stephen L, & Winship, Christopher. 2014. _Counterfactuals and causal inference_ . Cambridge University Press. 

Pearl, Judea. 2009. _Causality_ . Cambridge university press. 

Raiko, Tapani, & Tornio, Matti. 2009. Variational Bayesian learning of nonlinear hidden state-space models for model predictive control. _Neurocomputing_ , **72** (16), 3704–3712. 

Rezende, Danilo Jimenez, & Mohamed, Shakir. 2015. Variational Inference with Normalizing Flows. _arXiv preprint arXiv:1505.05770_ . 

Rezende, Danilo Jimenez, Mohamed, Shakir, & Wierstra, Daan. 2014. Stochastic backpropagation and approximate inference in deep generative models. _arXiv preprint arXiv:1401.4082_ . 

Rosenbaum, Paul R. 2002. _Observational studies_ . Springer. 

Roweis, Sam, & Ghahramani, Zoubin. 2000. An EM algorithm for identification of nonlinear dynamical systems. 

13 

Srivastava, Nitish, Hinton, Geoffrey, Krizhevsky, Alex, Sutskever, Ilya, & Salakhutdinov, Ruslan. 2014. Dropout: A simple way to prevent neural networks from overfitting. _The Journal of Machine Learning Research_ , **15** (1), 1929–1958. 

Srivastava, Nitish, Mansimov, Elman, & Salakhutdinov, Ruslan. 2015. Unsupervised learning of video representations using LSTMs. _arXiv preprint arXiv:1502.04681_ . 

Tabak, Esteban G, Vanden-Eijnden, Eric, _et al._ . 2010. Density estimation by dual ascent of the log-likelihood. _Communications in Mathematical Sciences_ , **8** (1), 217–233. Valpola, Harri, & Karhunen, Juha. 2002. An unsupervised ensemble learning method for nonlinear dynamic state-space models. _Neural computation_ , **14** (11), 2647–2692. 

Velez, Finale Doshi. 2013. Partially-Observable Markov Decision Processes as Dynamical Causal Models. 

Wan, Eric, Van Der Merwe, Ronell, _et al._ . 2000. The unscented Kalman filter for nonlinear estimation. _Pages 153–158 of: Adaptive Systems for Signal Processing, Communications, and Control Symposium 2000. ASSPCC. The IEEE 2000_ . IEEE. 

Watter, Manuel, Springenberg, Jost Tobias, Boedecker, Joschka, & Riedmiller, Martin. 2015. Embed to Control: A Locally Linear Latent Dynamics Model for Control from Raw Images. _arXiv preprint arXiv:1506.07365_ . Zaremba, Wojciech, & Sutskever, Ilya. 2014. Learning to Execute. _arXiv preprint arXiv:1410.4615_ . 

14 

## **A Lower Bound on Likelihood** 

In the following we omit the dependence of _q_ on _⃗x_ and _⃗u_ , and omit the subscript _φ_ . We can show that the KL divergence between the approximation to the posterior and the prior simplifies as: 

**==> picture [392 x 174] intentionally omitted <==**

For evaluating the marginal likelihood on the test set, we can use the following Monte-Carlo estimate: 

**==> picture [288 x 27] intentionally omitted <==**

This may be derived in a manner akin to the one depicted in Appendix E (Rezende _et al._ , 2014) or Appendix D (Kingma & Welling, 2013). 

The log likelihood on the test set is computed using: 

**==> picture [290 x 27] intentionally omitted <==**

(8) may be computed in a numerically stable manner using the log-sum-exp trick. 

## **B KL divergence between Prior and Posterior** 

Maximum likelihood learning requires us to compute: 

**==> picture [396 x 27] intentionally omitted <==**

The KL divergence between two multivariate Gaussians _q_ , _p_ with respective means and covariances _µq,_ Σ _q, µp,_ Σ _p_ can be written as: 

**==> picture [342 x 50] intentionally omitted <==**

The choice of _q_ and _p_ is suggestive. using (9) & (10), we can derive a closed form for the KL divergence between _q_ ( _z_ 1 _. . . zT_ ) and _p_ ( _z_ 1 _. . . zT_ ). 

_µq,_ Σ _q_ are the outputs of the variational model. Our functional form for _µp,_ Σ _p_ is based on our generative and can be summarized as: 

**==> picture [268 x 10] intentionally omitted <==**

15 

Here, Σ _pt_ is assumed to be a learned diagonal matrix and ∆ a scalar parameter. **Term (a)** For _t_ = 1, we have: 

**==> picture [284 x 22] intentionally omitted <==**

For _t >_ 1, we have: 

**==> picture [318 x 22] intentionally omitted <==**

**Term (b)** For _t_ = 1, we have: 

**==> picture [245 x 13] intentionally omitted <==**

For _t >_ 1, we have: 

**==> picture [270 x 19] intentionally omitted <==**

**Term (c)** For _t_ = 1, we have: 

**==> picture [276 x 12] intentionally omitted <==**

**==> picture [397 x 27] intentionally omitted <==**

Rewriting (9) using (11), (12), (13), (14), (15), (16), we get: 

**==> picture [350 x 89] intentionally omitted <==**

We can now take gradients with respect to _µqt,_ Σ _qt, G_ ( _zt−_ 1 _, ut−_ 1) in (17). 

## **C Additional Experimental Results** 

We consider a variant of **Large Healing MNIST** trained on 100 different kinds of 0 _,_ 2s each. Figure 6a and 6b depict the reconstructions and samples from a model trained on the digits 0 and 2. 

16 

**==> picture [288 x 239] intentionally omitted <==**

**----- Start of picture text -----**<br>
Small Rotation Right<br>R<br>TS Small Rotation Left<br>R<br>TS<br>Large Rotation Right<br>R<br>TS<br>Large Rotation Left<br>R<br>TS<br>R No Rotation<br>TS<br>**----- End of picture text -----**<br>


(a) **Large Healing MNIST** (0,2):Pairs of Training Sequences (TS) and mean probabilities of Reconstructions (R) shown above. 

(b) **Large Healing MNIST** (0,2): Mean probabilities sampled under different, constant rotations. 

17 

