---
source_url: 
ingested: 2026-04-29
sha256: 71adfcfa47612fe26fe7ff386544184fcdf70761d7c7bbb2629894a19f07f282
---

# **Factorized Inference in Deep Markov Models for Incomplete Multimodal Time Series** 

**Tan Zhi-Xuan,**[1, 2] **Harold Soh,**[3] **Desmond C. Ong**[1, 4] 

1A*STAR Artificial Intelligence Initiative, A*STAR, Singapore 

2Department of Electrical Engineering and Computer Science, MIT 

3Department of Computer Science, National University of Singapore 

4Department of Information Systems and Analytics, National University of Singapore xuan@mit.edu, harold@comp.nus.edu.sg, dco@comp.nus.edu.sg 

## **Abstract** 

Integrating deep learning with latent state space models has the potential to yield temporal models that are powerful, yet tractable and interpretable. Unfortunately, current models are not designed to handle missing data or multiple data modalities, which are both prevalent in real-world data. In this work, we introduce a factorized inference method for Multimodal Deep Markov Models (MDMMs), allowing us to filter and smooth in the presence of missing data, while also performing uncertainty-aware multimodal fusion. We derive this method by factorizing the posterior _p_ ( _z|x_ ) for non-linear state space models, and develop a _variational backward-forward algorithm_ for inference. Because our method handles incompleteness over both time and modalities, it is capable of interpolation, extrapolation, conditional generation, label prediction, and weakly supervised learning of multimodal time series. We demonstrate these capabilities on both synthetic and realworld multimodal data under high levels of data deletion. Our method performs well even with more than 50% missing data, and outperforms existing deep approaches to inference in latent time series. 

## **Introduction** 

Virtually all sensory data that humans and autonomous systems receive can be thought of as multimodal time series— multiple sensors each provide streams of information about the surrounding environment, and intelligent systems have to integrate these information streams to form a coherent yet dynamic model of the world. These time series are often asynchronously or irregularly sampled, with many timepoints having missing or incomplete data. Classical time series algorithms, such as the Kalman filter, are robust to such incompleteness: they are able to infer the state of the world, but only in linear regimes (Kalman 1960). On the other hand, human intelligence is robust _and_ complex: we infer complex quantities with _nonlinear dynamics_ , even from incomplete temporal observations of multiple modalities—for example, intended motion from both eye gaze and arm movements (Dragan, Lee, and Srinivasa 2013), or desires and emotions from actions, facial expressions, speech, and language (Baker et al. 2017; Ong, Zaki, and Goodman 2015). 

Copyright _⃝_ c 2020, Association for the Advancement of Artificial Intelligence (www.aaai.org). All rights reserved. 

There has been a proliferation of attempts to learn these nonlinear dynamics by integrating deep learning with traditional probabilistic approaches, such as Hidden Markov Models (HMMs) and latent dynamical systems. Most approaches do this by adding random latent variables to each time step in an RNN (Chung et al. 2015; Bayer and Osendorfer 2014; Fabius and van Amersfoort 2014; Fraccaro et al. 2016). Other authors begin with latent sequence models as a basis, then develop deep parameterizations and inference techniques for these models (Krishnan, Shalit, and Sontag 2017; Archer et al. 2015; Johnson et al. 2016; Karl et al. 2016; Doerr et al. 2018; Lin, Khan, and Hubacher 2018; Chen et al. 2018). Most relevant to our work are the Deep Markov Models (DMMs) proposed by Krishnan, Shalit, and Sontag (2017), a generalization of HMMs and Gaussian State Space Models where the transition and emission distributions are parameterized by deep networks. 

Unfortunately, none of the approaches thus far are designed to handle inference with both missing data and multiple modalities. Instead, most approaches rely upon RNN inference networks (Krishnan, Shalit, and Sontag 2017; Karl et al. 2016; Che et al. 2018), which can only handle missing data using ad-hoc approaches such as zero-masking (Lipton, Kale, and Wetzel 2016), update-skipping (Krishnan, Shalit, and Sontag 2017), temporal gating mechanisms (Neil, Pfeiffer, and Liu 2016; Che et al. 2018), or providing time stamps as inputs (Chen et al. 2018), none of which have intuitive probabilistic interpretations. Of the approaches that do not rely on RNNs, Fraccaro _et al._ handle missing data by assuming linear latent dynamics (Fraccaro et al. 2017), while Johnson _et al._ (Johnson et al. 2016) and Lin _et al._ (Lin, Khan, and Hubacher 2018) use hybrid message passing inference that is theoretically capable of marginalizing out missing data. However, these methods are unable to learn nonlinear transition dynamics, nor do they handle multiple modalities. 

We address these limitations—the inability to handle missing data, over multiple modalities, and with nonlinear dynamics—by introducing a multimodal generalization of Deep Markov Models, as well as a factorized inference method for such models that handles missing time points and modalities by design. Our method allows for both fil- 

**==> picture [391 x 94] intentionally omitted <==**

**----- Start of picture text -----**<br>
x 1 t -1 x 1 t x 1 t +1 x 1 t -1 x 1 t x 1 t +1 x 1 t -1 x 1 t x 1 t +1<br>zt -1 zt zt +1 zt -1 zt zt +1 zt -1 zt zt +1<br>x 2 t -1 x 2 t x 2 t +1 x 2 t -1 x 2 t x 2 t +1 x 2 t -1 x 2 t x 2 t +1<br>(a)  Model  p ( z 1: T  ,  x 1: T ) (b)  Filtering  p ( zt | x 1: t ) (c)  Smoothing  p ( zt | x 1: T )<br>**----- End of picture text -----**<br>


Figure 1: (a) A Multimodal Deep Markov Model (MDMM) with _M_ = 2 unobserved latent states (unfilled). (b) Filtering infers the current latent state _zt_ (bold dashed outline) given all observations up to _t_ (solid outlines), and marginalizes (dotted outline) over past latent states. (c) Smoothing infers _zt_ given past, present, and future observations, and marginalizes over both past and future latent states. 

tering and smoothing given incomplete time series, while also performing uncertainty-aware multimodal fusion _`a la_ the Multimodal Variational Autoencoder (MVAE) (Wu and Goodman 2018). Because our method handles incompleteness over both time and modalities, it is capable of (i) interpolation, (ii) forward / backward extrapolation, and (iii) conditional generation of one modality from another, including label prediction. It also enables (iv) weakly supervised learning from incomplete multimodal data. We demonstrate these capabilities on both a synthetic dataset of noisy bidirectional spirals, as well as a real world dataset of labelled human actions. Our experiments show that our method learns and performs excellently on each of these tasks, while outperforming state-of-the-art inference methods that rely upon RNNs. 

## **Methods** 

We introduce Multimodal Deep Markov Models (MDMMs) as a generalization of Krishnan _et al._ ’s Deep Markov Models (DMMs) (Krishnan, Shalit, and Sontag 2017). In a MDMM (Figure 1a), we model multiple sequences of observations, each of which is conditionally independent of the other sequences given the latent state variables. Each observation sequence corresponds to a particular data or sensor modality (e.g. video, audio, labels), and may be missing when other modalities are present. An MDMM can thus be seen as a sequential version of the MVAE (Wu and Goodman 2018). 

Formally, let _zt_ and _x[m] t_[respectively denote the latent state] and observation for modality _m_ at time _t_ . An MDMM with _M_ modalities is then defined by the transition and emission distributions: 

**==> picture [211 x 25] intentionally omitted <==**

Here, _N_ is the Gaussian distribution, and Π is some arbitrary emission distribution. The distribution parameters _µθ_ , Σ _θ_ and _κ[m] θ_[are functions of either] _[ z][t][−]_[1][ or] _[ z][t]_[. We learn these] functions as neural networks with weights _θ_ . We also use _zt_ 1: _t_ 2 to denote the time-series of _z_ from _t_ 1 to _t_ 2, and _x[m] t_ 1:[1] _t_[:] 2 _[m]_[2] to denote the corresponding observations from modalities _m_ 1 to _m_ 2. We omit the modality superscripts when all modalities are present (i.e., _xt ≡ x_[1:] _t[M]_ ). 

We want to jointly learn the parameters _θ_ of the generative model _pθ_ ( _z_ 1: _T , x_ 1: _T_ ) = _pθ_ ( _x_ 1: _T |z_ 1: _T_ ) _pθ_ ( _z_ 1: _T_ ) and the parameters _φ_ of a variational posterior _qφ_ ( _z_ 1: _T |x_ 1: _T_ ) which approximates the true (intractable) posterior _pθ_ ( _z_ 1: _T |x_ 1: _T_ ). To do so, we maximize a lower bound on the log marginal likelihood _L_ ( _x_ ; _θ, φ_ ) _≤ pθ_ ( _x_ 1: _T_ ), also known as the evidence lower bound (ELBO): 

**==> picture [235 x 28] intentionally omitted <==**

In practice, we can maximize the ELBO with respect to _θ_ and _φ_ via gradient ascent with stochastic backpropagation (Kingma and Welling 2014; Rezende, Mohamed, and Wierstra 2014). Doing so requires sampling from the variational posterior _qφ_ ( _z_ 1: _T |x_ 1: _T_ ). In the following sections, we derive a variational posterior that factorizes over time-steps and modalities, allowing us to tractably infer the latent states _z_ 1: _T_ even when data is missing. 

## **Factorized Posterior Distributions** 

In latent sequence models such as MDMMs, we often want to perform several kinds of inferences over the latent states. The most common of such latent state inferences are: 

**Filtering** Inferring _zt_ given past observations _x_ 1: _t_ . **Smoothing** Inferring some _zt_ given all observations _x_ 1: _T_ . **Sequencing** Inferring the sequence _z_ 1: _T_ from _x_ 1: _T_ 

Most architectures that combine deep learning with state space models focus upon filtering (Fabius and van Amersfoort 2014; Chung et al. 2015; Hafner et al. 2018; Buesing et al. 2018), while Krishnan _et al._ optimize their DMM for sequencing (Krishnan, Shalit, and Sontag 2017). One of our contributions is to demonstrate that we can learn the filtering, smoothing, and sequencing distributions within the same framework, because they all share similar factorizations (see Figures 1b and 1c for the shared inference structure of filtering and smoothing). A further consequence of these factorizations is that we can naturally handle inferences given missing modalities or time-steps. 

To demonstrate this similarity, we first factorize the sequencing distribution _p_ ( _z_ 1: _T |x_ 1: _T_ ) over time: 

**==> picture [225 x 14] intentionally omitted <==**

This factorization means that each latent state _zt_ depends only on the previous latent state _zt−_ 1, as well as all current and future observations _xt_ : _T_ , and is implied by the graphical structure of the MDMM (Figure 1a). We term _p_ ( _zt|zt−_ 1 _, xt_ : _T_ ) the _conditional smoothing posterior_ , because it is the posterior that corresponds to the _conditional prior p_ ( _zt|zt−_ 1) on the latent space, and because it combines information from both past and future (hence ‘smoothing’). 

Given one or more modalities, we can show that the conditional smoothing posterior _p_ ( _zt|zt−_ 1 _, xt_ : _T_ ), the _backward_ filtering distribution _p_ ( _zt|xt_ : _T_ ), and the smoothing distribution _p_ ( _zt|x_ 1: _T_ ) all factorize almost identically: 

**==> picture [236 x 47] intentionally omitted <==**

**==> picture [236 x 56] intentionally omitted <==**

Equations 5–7 show that each distribution can be decomposed into (i) its dependence on future observations, _p_ ( _zt|xt_ +1: _T_ ), (ii) its dependence on each modality _m_ in the present, _p_ ( _zt|x[m] t_[)][,][and,][excluding][filtering,][(iii)][its][depen-] dence on the past _p_ ( _zt|zt−_ 1) or _p_ ( _zt|x_ 1: _t−_ 1). Their shared structure is due to the conditional independence of _xt_ : _T_ given _zt_ from all prior observations or latent states. Here we show only the derivation for Equation 7, because the others follow by either dropping _zt−_ 1 (Equation 5), or replacing _zt−_ 1 with _x_ 1: _t−_ 1 (Equation 6): 

**==> picture [232 x 100] intentionally omitted <==**

The factorizations in Equations 5–7 lead to several useful insights. First, they show that any missing modalities ~~_m_~~ _∈_ [1 _, M_ ] at time _t_ can simply be left out of the product over modalities, leaving us with distributions that correctly condition on only the modalities [1 _, M_ ] _\ {_ ~~_m_~~ _}_ that are present. Second, they suggest that we can compute all three distributions if we can approximate the dependence on the future, _q_ ( _zt|xt_ +1: _T_ ) _≃ p_ ( _zt|xt_ +1: _T_ ), learn approximate posteriors _q_ ( _zt|x[m] t_[)] _[≃][p]_[(] _[z][t][|][x][m] t_[)][for][each][modality] _[m]_[,][and] know the model dynamics _p_ ( _zt_ ), _p_ ( _zt|zt−_ 1). 

## **Multimodal Fusion via Product of Gaussians** 

However, there are a few obstacles to performing tractable computation of Equations 5–7. One obstacle is that it is not tractable to compute the product of generic probability distributions. To address this, we adopt the approach used for 

the MVAE (Wu and Goodman 2018), making the assumption that each term in Equations 5–7 is Gaussian. If each distribution is Gaussian, then their products or quotients are also Gaussian and can be computed in closed form. Since this result is well-known, we state it in the supplement (see Wu and Goodman (2018) for a proof). 

This Product-of-Gaussians approach has the added benefit that the output distribution is dominated by the input Gaussian terms with lower variance (higher precision), thereby fusing information in a way that gives more weight to higher-certainty inputs (Cao and Fleet 2014; Ong, Zaki, and Goodman 2015). This automatically balances the information provided by each modality _m_ , depending on whether _p_ ( _zt|x[m] t_[)][ is high or low certainty, as well as the information] provided from the past and future through _p_ ( _zt|zt−_ 1) and _p_ ( _zt|xt_ +1: _T_ ), thereby performing multimodal temporal fusion in a manner that is uncertainty-aware. 

## **Approximate Filtering with Missing Data** 

Another obstacle to computing Equations 5–7 is the dependence on future observations, _p_ ( _zt|xt_ +1: _T_ ), which does not admit further factorization, and hence does not readily handle missing data among those future observations. Other approaches to approximating this dependence on the future rely on RNNs as recognition models (Krishnan, Shalit, and Sontag 2017; Che et al. 2018), but these are not designed to work with missing data. 

To address this obstacle in a more principled manner, our insight was that _p_ ( _zt|xt_ +1: _T_ ) is the expectation of _p_ ( _zt|zt_ +1) under the backwards filtering distribution, _p_ ( _zt_ +1 _|xt_ +1: _T_ ): 

**==> picture [207 x 12] intentionally omitted <==**

For tractable approximation of this expectation, we use an approach similar to assumed density filtering (Huber, Beutler, and Hanebeck 2011). We assume both _p_ ( _zt|xt_ +1: _T_ ) and _p_ ( _zt|zt_ +1) to be multivariate Gaussian with diagonal covariance, and sample the parameters _µ_ , Σ of _p_ ( _zt|zt_ +1) under _p_ ( _zt_ +1 _|xt_ +1: _T_ ). After drawing _K_ samples, we approximate the parameters of _p_ ( _zt|xt_ +1: _T_ ) via empirical momentmatching: 

**==> picture [222 x 33] intentionally omitted <==**

Approximating _p_ ( _zt|xt_ +1: _T_ ) by _p_ ( _zt|zt_ +1) led us to three important insights. First, by substituting the expectation from Equation 8 into Equation 5, the backward filtering distribution becomes: 

**==> picture [221 x 24] intentionally omitted <==**

In other words, by sampling under the filtering distribution for time _t_ + 1, _p_ ( _zt_ +1 _|xt_ +1: _T_ ), we can compute the filtering distribution for time _t_ , _p_ ( _zt|xt_ : _T_ ). We can thus recursively compute _p_ ( _zt|xt_ : _T_ ) backwards in time, starting from _t_ = _T_ . 

Second, once we can perform filtering backwards in time, we can use this to approximate _p_ ( _zt|xt_ +1: _T_ ) in the smoothing distribution (Equation 6) and the conditional smoothing 

posterior (Equation 7). Backward hence allows us to approximate both smoothing and sequencing. 

Third, this approach removes the explicit dependence on all future observations _xt_ +1: _T_ , allowing us to handle missing data. Suppose the data points _X_ ∄ = _{x[m] ti[i][}]_[are][miss-] ing, where _ti_ and _mi_ are the time-step and modality of the _i_ th missing point respectively. Rather than directly compute the dependence on an incomplete set of future observations, _p_ ( _zt|xt_ +1: _T \ X_ ∄), we can instead sample _zt_ +1 under the filtering distribution conditioned on incomplete observations, _p_ ( _zt_ +1 _|xt_ +1: _T \ X_ ∄), and then compute _p_ ( _zt|zt_ +1) given the sampled _zt_ +1, thereby approximating _p_ ( _zt|xt_ +1: _T \ X_ ∄). 

**Algorithm 1** A variational backward algorithm for approximate backward filtering. 

|**gorithm 1**A variational backward algorithm for appr<br>ate backward fltering.|**gorithm 1**A variational backward algorithm for appr<br>ate backward fltering.|
|---|---|
|**function**BACKWARDFILTER(_x_1:_T_,_K_)||
|Initialize_q_(_zt|xT_+1:_T_)|_←p_(_zT_)|
|**for**_t_=_T_ to1**do**||
|Let_M ⊆_[1_, M_]be|the observed modalities at_t_|
|_q_(_zt|xt_:_T_)_←q_(_zt|xt_+1:_T_) �<br>_M_ ˜_q_(_zt|xm_<br>_t_ )||
|Sample_K_ particles|_zk_<br>_t ∼q_(_zt|xt_:_T_ )for_k ∈_[1_, K_]|
|Compute_p_(_zt−_1_|zk_<br>_t_|)for each particle_zk_<br>_t_|
|_q_(_zt−_1_|xt_:_T_)_←_<br>1<br>_K_|�_K_<br>_k_=1 _p_(_zt−_1_|zk_<br>_t_ )|
|**end for**||
|**return**_{q_(_zt|xt_:_T_),_q_(_zt|xt_+1:_T_)for_t ∈_[1_, T_]_}_||
|**end function**||



## **Backward-Forward Variational Inference** 

We now introduce factorized variational approximations of Equations 5–7. We replace the true posteriors _p_ ( _zt|x[m] t_[)] wherewith variational _q_ ˜( _zt|x[m] t_[)][ is parameterized by a (time-invariant) neu-] approximations _q_ ( _zt|x[m] t_[):=˜] _[q]_[(] _[z][t][|][x][m] t_[)] _[p]_[(] _[z][t]_[)][,] ral network for each modality _m_ . As in the MVAE, we learn the Gaussian quotients _q_ ˜( _zt|x[m] t_[):=] _[q]_[(] _[z][t][|][x][m] t_[)] _[/p]_[(] _[z][t]_[)][ directly,] so as to avoid the constraint required for ensuring a quotient of Gaussians is well-defined. We also parameterize the transition dynamics _p_ ( _zt|zt−_ 1) and _p_ ( _zt|zt_ +1) using neural networks for the quotient distributions. This gives the following approximations: 

**==> picture [240 x 10] intentionally omitted <==**

**==> picture [240 x 25] intentionally omitted <==**

**==> picture [240 x 30] intentionally omitted <==**

**==> picture [239 x 16] intentionally omitted <==**

Here, E _←_ is shorthand for the expectation under the approximate backward filtering distribution _q_ ( _zt_ +1 _|xt_ +1: _T_ ), while E _→_ is the expectation under the forward smoothing distribution _q_ ( _zt−_ 1 _|x_ 1: _T_ ). 

To calculate the backward filtering distribution _q_ ( _zt|xt_ : _T_ ), we introduce a _variational backward algorithm_ (Algorithm 1) to recursively compute Equation 12 for all time-steps _t_ in a single pass. Note that simply by reversing time in Algorithm 1, this gives us a _variational forward algorithm_ that computes the forward filtering distribution _q_ ( _zt|x_ 1: _t_ ). 

Unlike filtering, smoothing and sequencing require information from both past ( _p_ ( _zt|zt−_ 1)) and future ( _p_ ( _zt|zt_ +1)). This motivates a _variational backward-forward algorithm_ (Algorithm 2) for smoothing and sequencing. Algorithm 2 first uses Algorithm 1 as a backward pass, then performs a forward pass to propagate information from past to future. Algorithm 2 also requires knowing _p_ ( _zt_ ) for each _t_ . While this can be computed by sampling in the forward pass, we avoid the instability (of sampling _T_ successive latents with no observations) by instead assuming _p_ ( _zt_ ) is constant with time, i.e., the MDMM is stationary when nothing is observed. During training, we add KL( _p_ ( _zt_ ) _||_ E _zt−_ 1 _p_ ( _zt|zt−_ 1)) and KL( _p_ ( _zt_ ) _||_ E _zt_ +1 _p_ ( _zt|zt_ +1)) to the loss to ensure that the transition dynamics obey this assumption. 

**Algorithm 2** A variational backward-forward algorithm for approximate forward smoothing. 

|**gorithm 2**A variational backward-forward alg<br>proximate forward smoothing.|orithm for|
|---|---|
|**function**FORWARDSMOOTH(_x_1:_T_,_Kb_,_Kf_)||
|Initialize ˜_p_(_zt|x_1:0)_←_1||
|Collect_q_(_zt|xt_+1:_T_)from BACKWARDFILTER(_x_1:_T_,_Kb_)||
|**for**_t_= 1to_T_ **do**||
|Let_M ⊆_[1_, M_]be the observed modalities|at_t_|
|_q_(_zt|x_1:_T_)_←q_(_zt|xt_+1:_T_) �<br>_M_[˜_q_(_zt|xm_<br>_t_ )]|_q_(_zt|x_1:_t−_1)<br>_p_(_zt_)|
|Sample_Kf_ particles_zt ∼q_(_zt|x_1:_T_)for_k ∈_[1_, Kf_]||
|Compute_p_(_zt_+1_|zk_<br>_t_ )for each particle_zk_<br>_t_||
|_q_(_zt_+1_|x_1:_t_)_←_<br>1<br>_Kf_<br>�_Kf_<br>_k_=1 _p_(_zt_+1_|zk_<br>_t_ )||
|**end for**||
|**return**_{q_(_zt|x_1:_T_),_q_(_zt|x_1:_t−_1)for_t ∈_[1_, T_]_}_||
|**end function**||



While Algorithm 1 approximates the distribution _q_ ( _zt|xt_ : _T_ ), by setting the number of particles _K_ = 1, it effectively computes the (backward) conditional filtering posterior _q_ ( _zt|zt_ +1 _, xt_ ) and (backward) conditional prior _p_ ( _zt|zt_ +1) for a randomly sampled latent sequence _z_ 1: _T_ . Similarly, while Algorithm 2 approximates smoothing by default, when _Kf_ = 1, it effectively computes the (forward) conditional smoothing posterior _q_ ( _zt|zt−_ 1 _, xt_ : _T_ ) and (forward) conditional prior _p_ ( _zt|zt−_ 1) for a random latent sequence _z_ 1: _T_ . These quantities are useful not only because they allow us to perform sequencing, but also because we can use them to compute the ELBO for both backward filtering and forward smoothing: 

**==> picture [223 x 64] intentionally omitted <==**

_L_ filter is the filtering ELBO because it corresponds to a ‘backward filtering’ variational posterior _q_ ( _z_ 1: _T |x_ 1: _T_ ) = � _t[q]_[(] _[z][t][|][z][t]_[+1] _[, x][t]_[)][,][where][each] _[z][t]_[is][only][inferred][using] the current observation _xt_ and the future latent state _zt_ +1. _L_ smooth is the smoothing ELBO because it corresponds to the correct factorization of the posterior in Equation 4, where each term combines information from both past and future. Since _L_ smooth corresponds to the correct factorization, it should theoretically be enough to minimize _L_ smooth to learn 

|**Method**|_Recon._<br>_Drop Half_<br>_Fwd. Extra._<br>_Bwd. Extra._<br>_Cond. Gen._<br>_Label Pred._|
|---|---|
|BFVI (ours)<br>F-Mask<br>F-Skip<br>B-Mask<br>B-Skip|**Spirals Dataset: MSE (SD)**|
||**0.02 (0.01)**<br>**0.04 (0.01)**<br>0.12 (0.10)<br>0.07 (0.03)<br>**0.26 (0.26)**<br>–<br>**0.02 (0.01)**<br>0.06 (0.02)<br>**0.10 (0.08)**<br>0.18 (0.07)<br>1.37 (1.39)<br>–<br>0.04 (0.01)<br>0.10 (0.05)<br>0.13 (0.11)<br>0.19 (0.06)<br>1.51 (1.54)<br>–<br>**0.02 (0.01)**<br>**0.04 (0.01)**<br>0.18 (0.14)<br>**0.04 (0.01)**<br>1.25 (1.23)<br>–<br>0.05 (0.01)<br>0.19 (0.05)<br>0.32 (0.22)<br>0.37 (0.15)<br>1.64 (1.51)<br>–|
|BFVI (ours)<br>F-Mask<br>F-Skip<br>B-Mask<br>B-Skip|**Weizmann Video Dataset: SSIM or Accuracy* (SD)**|
||**.85 (.03)**<br>**.84 (.04)**<br>**.84 (.04)**<br>**.83 (.05)**<br>**.85 (.03)**<br>**.69 (.33)***<br>.68 (.18)<br>.66 (.18)<br>.68 (.18)<br>.66 (.17)<br>.60 (.15)<br>.33 (.33)*<br>.70 (.12)<br>.68 (.14)<br>.70 (.12)<br>.67 (.16)<br>.63 (.12)<br>.21 (.26)*<br>.79 (.04)<br>.79 (.04)<br>.79 (.04)<br>.79 (.04)<br>.76 (.06)<br>.46 (.34)*<br>.80 (.04)<br>.79 (.04)<br>.80 (.04)<br>.79 (.04)<br>.74 (.08)<br>.29 (.37)*|



Table 1: Evaluation metrics on both datasets across inference methods and tasks. Best performance per task (column) in bold. (Top) _Spirals Dataset:_ MSE (lower is better) per time-step between reconstructions and ground truth spirals. For scale, the average squared spiral radius is about 5 sq. units. (Bottom) _Weizmann Video Dataset:_ SSIM or label accuracy (higher is better) per time-step with respect to original videos. Means and Standard Deviations (SD) are across the test set. 

good MDMM parameters _θ, φ_ . However, in order to compute _L_ smooth, we must perform a backward pass which requires sampling under the backward filtering distribution. Hence, to accurately approximate _L_ smooth, the backward filtering distribution has to be reasonably accurate as well. This motivates learning the parameters _θ, φ_ by jointly maximizing the filtering and smoothing ELBOs as a weighted sum. We call this paradigm **backward-forward variational inference (BFVI)** , due to its use of variational posteriors for both backward filtering and forward smoothing. 

## **Experiments** 

We compare **BFVI** against state-of-the-art RNN-based inference methods on two multimodal time series datasets over a range of inference tasks. **F-Mask** and **F-Skip** use forward RNNs (one per modality), using zero-masking and update skipping respectively to handle missing data. They are thus multimodal variants of the ST-L network in (Krishnan, Shalit, and Sontag 2017), and similar to the variational RNN (Chung et al. 2015) and recurrent SSM (Hafner et al. 2018). **B-Mask** and **B-Skip** use backward RNNs, with masking and skipping respectively, and correspond to the Deep Kalman Smoother in (Krishnan, Shalit, and Sontag 2017). The underlying MDMM architecture is constant across inference methods. Architectural and training details can be found in the supplement. Code is available at https://git.io/Jeoze. 

## **Datasets** 

**Noisy Spirals.** We synthesized a dataset of 1000 noisy 2D spirals (600 train / 400 test) similar to Chen _et al._ (Chen et al. 2018), treating the _x_ and _y_ coordinates as two separate modalities. Spiral trajectories vary in direction (clockwise or counter-clockwise), size, and aspect ratio, and Gaussian noise is added to the observations. We used 5 latent dimensions, and two-layer perceptrons for encoding _q_ ( _zt|x[m] t_[)][ and] decoding _p_ ( _x[m] t[|][z][t]_[)][.][For][evaluation,][we][compute][the][mean] 

squared error (MSE) per time step between the predicted trajectories and ground truth spirals. 

**Weizmann Human Actions.** This is a video dataset of 9 people each performing 10 actions (Gorelick et al. 2007). We converted it to a trimodal time series dataset by treating silhouette masks as an additional modality, and treating actions as per-frame labels, similar to He et al. (2018). Each RGB frame was cropped to the central 128 _×_ 128 window and resized to 64 _×_ 64. We selected one person’s videos as the test set, and the other 80 videos as the training set, allowing us to test action label prediction on an unseen person. We used 256 latent dimensions, and convolutional / deconvolutional neural networks for encoding and decoding. For evaluation, we compute the Structural Similarity (SSIM) between the input video frames and the reconstructed outputs. 

## **Inference Tasks** 

We evaluated all methods on the following suite of temporal inference tasks for both datasets: **reconstruction** : reconstruction given complete observations; **drop half** : reconstruction after half of the inputs are randomly deleted; **forward extrapolation** : predicting the last 25% of a sequence when the rest is given; and **backward extrapolation** : inferring the first 25% of a sequence when the rest is given. 

When evaluating these tasks on the Weizmann dataset, we provided only video frames as input (i.e. with neither the silhouette masks nor the action labels), to test whether the methods were capable of unimodal inference after multimodal training. 

We also tested cross-modal inference using the following _conditional generation / label prediction_ tasks: **conditional generation (Spirals)** : given _x_ - and initial 25% of _y_ - coordinates, generate rest of spiral; **conditional generation (Weizmann)** : given the video frames, generate the silhouette masks; and **label prediction (Weizmann)** : infer action labels given only video frames. 

**==> picture [238 x 91] intentionally omitted <==**

**----- Start of picture text -----**<br>
Recon. Drop Half Fwd. Extra. Bwd. Extra. Cond. Gen<br>MSE: 0.014 MSE: 0.023 MSE: 0.085 MSE: 0.040 MSE: 0.058<br>MSE: 0.018 MSE: 0.029 MSE: 0.178 MSE: 0.023 MSE: 2.157<br>predicted ground truth observations x  observed y  observed<br>BFVI<br>B-Mask<br>**----- End of picture text -----**<br>


Figure 2: Reconstructions for all 5 spiral inference tasks for BFVI and the next best method, B-Mask. BFVI outperforms B-Mask significantly on both forward extrapolation and conditional generation. 

Table 1 shows the results for the inference tasks, while Figure 2 and 3 show sample reconstructions from the Spirals and Weizmann datasets respectively. On the Spirals dataset, BFVI achieves high performance on all tasks, whereas the RNN-based methods only perform well on a few. In particular, all methods besides BFVI do poorly on the conditional generation task, which can be understood from the right-most column of Figure 2. BFVI generates a spiral that matches the provided _x_ -coordinates, while the next-best method, B-Mask, completes the trajectory with a plausible spiral, but ignores the _x_ observations entirely in the process. 

On the more complex Weizmann video dataset, BFVI outperforms all other methods on every task, demonstrating both the power and flexibility of our approach. The RNNbased methods performed especially poorly on label prediction, and this was the case even on the training set (not shown in Table 1). We suspect that this is because the RNNbased methods lack a principled approach to multimodal fusion, and hence fail to learn a latent space which captures the mutual information between action labels and images. In contrast, BFVI learns to both predict one modality from another, and to propagate information across time, as can be seen from the reconstruction and predictions in Figure 3. 

## **Weakly Supervised Learning** 

In addition to performing inference with missing data test time, we compared the various methods ability to learn with missing data at training time, amounting to a form of weakly supervised learning. We tested two forms of weakly supervised learning on the Spirals dataset, corresponding to different conditions of data incompleteness. The first was learning with data missing uniformly at random. This condition can arise when sensors are noisy or asynchronous. The second was learning with missing modalities, or semisupervised learning, where a fraction of the sequences in the dataset only has a single modality present. This condition can arise when a sensor breaks down, or when the dataset is partially unlabelled by annotators. We also tested learning with missing modalities on the Weizmann dataset. 

Results for these experiments are shown in Figure 4, which compare BFVI’s performance on increasing levels of missing data against the next best method, averaged across 10 trials. Our method (BFVI) performs well, maintaining 

**==> picture [226 x 29] intentionally omitted <==**

**==> picture [226 x 28] intentionally omitted <==**

**==> picture [226 x 29] intentionally omitted <==**

**==> picture [226 x 29] intentionally omitted <==**

**==> picture [226 x 29] intentionally omitted <==**

**==> picture [226 x 29] intentionally omitted <==**

**==> picture [226 x 29] intentionally omitted <==**

Figure 3: Snapshots of a ‘running’ video and silhouette mask from the Weizmann dataset (rows 1–2), with half of the frames deleted at random (14 out of 28 frames), and neither action labels nor silhouettes provided as observations (row 3). BFVI reconstructs the video and a running silhouette, and also correctly predicts the action (rows 4–5). By contrast, B-Skip (the next best method) creates blurred and wispy reconstructions, wrongly predicts the action label, and vacillates between different possible action silhouettes over time (rows 6–7). 

good performance on the Spirals dataset even with 70% uniform random deletion (Figure 4a) and 60% uni-modal examples (Figure 4b), while degrading gracefully with increasing missingness. This is in contrast to B-Mask, which is barely able to learn when even 10% of the spiral examples are unimodal, and performs worse than BFVI on the Weizmann dataset at all levels of missing data (Figure 4c). 

## **Conclusion** 

In this paper, we introduced backward-forward variational inference (BFVI) as a novel inference method for Multimodal Deep Markov Models. This method handles incomplete data via a factorized variational posterior, allowing us to easily marginalize over missing observations. Our method is thus capable of a large range of multimodal temporal inference tasks, which we demonstrate on both a synthetic dataset and a video dataset of human motions. The ability to handle missing data also enables applications in weakly supervised learning of labelled time series. Given the abundance of multimodal time series data where missing data is the norm rather than the exception, our work holds great promise for many future applications. 

**==> picture [506 x 192] intentionally omitted <==**

Figure 4: Learning curves under various forms of weak supervision. (a) Learning with randomly missing data on the Spirals dataset. (b) Semi-supervised learning on the Spirals dataset, where some sequences are entirely missing the y-coordinate. (c) Semi-supervised learning on the Weizmann dataset, where some sequences have no action labels. 

## **Acknowledgements** 

This work was supported by the A*STAR Human-Centric Artificial Intelligence Programme (SERC SSF Project No. A1718g0048). 

## **References** 

- [Archer et al. 2015] Archer, E.; Park, I. M.; Buesing, L.; Cunningham, J.; and Paninski, L. 2015. Black box variational inference for state space models. _arXiv preprint arXiv:1511.07367_ . 

- [Baker et al. 2017] Baker, C. L.; Jara-Ettinger, J.; Saxe, R.; and Tenenbaum, J. B. 2017. Rational quantitative attribution of beliefs, desires and percepts in human mentalizing. _Nature Human Behaviour_ 1(4):0064. 

- [Bayer and Osendorfer 2014] Bayer, J., and Osendorfer, C. 2014. Learning stochastic recurrent networks. In _NIPS 2014 Workshop on Advances in Variational Inference_ . 

- [Buesing et al. 2018] Buesing, L.; Weber, T.; Racaniere, S.; Eslami, S.; Rezende, D.; Reichert, D. P.; Viola, F.; Besse, F.; Gregor, K.; Hassabis, D.; et al. 2018. Learning and querying fast generative models for reinforcement learning. _arXiv preprint arXiv:1802.03006_ . 

- [Cao and Fleet 2014] Cao, Y., and Fleet, D. J. 2014. Generalized product of experts for automatic and principled fusion of gaussian process predictions. In _Modern Nonparametrics 3: Automating the Learning Pipeline Workshop, NeurIPS 2014._ 

- [Che et al. 2018] Che, Z.; Purushotham, S.; Li, G.; Jiang, B.; and Liu, Y. 2018. Hierarchical deep generative models for multi-rate multivariate time series. In Dy, J., and Krause, A., eds., _Proceedings of the 35th International Conference on Machine Learning_ , volume 80 of _Proceedings of Machine Learning Research_ , 784–793. Stockholmsmssan, Stockholm Sweden: PMLR. 

- [Chen et al. 2018] Chen, T. Q.; Rubanova, Y.; Bettencourt, J.; and Duvenaud, D. K. 2018. Neural ordinary differential equations. In _Advances in Neural Information Processing Systems_ , 6571–6583. 

- [Chung et al. 2015] Chung, J.; Kastner, K.; Dinh, L.; Goel, K.; Courville, A. C.; and Bengio, Y. 2015. A recurrent latent variable model for sequential data. In _Advances in neural information processing systems_ , 2980–2988. 

- [Doerr et al. 2018] Doerr, A.; Daniel, C.; Schiegg, M.; Duy, N.-T.; Schaal, S.; Toussaint, M.; and Sebastian, T. 2018. Probabilistic recurrent state-space models. In Dy, J., and Krause, A., eds., _Proceedings of the 35th International Conference on Machine Learning_ , volume 80 of _Proceedings of Machine Learning Research_ , 1280–1289. Stockholmsmssan, Stockholm Sweden: PMLR. 

- [Dragan, Lee, and Srinivasa 2013] Dragan, A. D.; Lee, K. C.; and Srinivasa, S. S. 2013. Legibility and predictability of robot motion. In _Proceedings of the 8th ACM/IEEE international conference on Human-robot interaction_ , 301–308. IEEE Press. 

- [Fabius and van Amersfoort 2014] Fabius, O., and van Amersfoort, J. R. 2014. Variational recurrent autoencoders. _arXiv preprint arXiv:1412.6581_ . 

- [Fraccaro et al. 2016] Fraccaro, M.; Sønderby, S. K.; Paquet, U.; and Winther, O. 2016. Sequential neural models with stochastic layers. In _Advances in Neural Information Processing Systems_ , 2199–2207. 

- [Fraccaro et al. 2017] Fraccaro, M.; Kamronn, S.; Paquet, U.; and Winther, O. 2017. A disentangled recognition and nonlinear dynamics model for unsupervised learning. In _Advances in Neural Information Processing Systems_ , 3601– 3610. 

- [Gorelick et al. 2007] Gorelick, L.; Blank, M.; Shechtman, E.; Irani, M.; and Basri, R. 2007. Actions as space-time 

shapes. _IEEE transactions on pattern analysis and machine intelligence_ 29(12):2247–2253. 

supervised learning. In _Advances in Neural Information Processing Systems_ , 5575–5585. 

- [Hafner et al. 2018] Hafner, D.; Lillicrap, T.; Fischer, I.; Villegas, R.; Ha, D.; Lee, H.; and Davidson, J. 2018. Learning latent dynamics for planning from pixels. _arXiv preprint arXiv:1811.04551_ . 

- [He et al. 2018] He, J.; Lehrmann, A.; Marino, J.; Mori, G.; and Sigal, L. 2018. Probabilistic video generation using holistic attribute control. In _Proceedings of the European Conference on Computer Vision (ECCV)_ , 452–467. 

- [Huber, Beutler, and Hanebeck 2011] Huber, M. F.; Beutler, F.; and Hanebeck, U. D. 2011. Semi-analytic gaussian assumed density filter. In _Proceedings of the 2011 American Control Conference_ , 3006–3011. IEEE. 

- [Johnson et al. 2016] Johnson, M.; Duvenaud, D. K.; Wiltschko, A.; Adams, R. P.; and Datta, S. R. 2016. Composing graphical models with neural networks for structured representations and fast inference. In _Advances in Neural Information Processing Systems_ , 2946–2954. 

- [Kalman 1960] Kalman, R. E. 1960. A new approach to linear filtering and prediction problems. _Journal of basic Engineering_ 82(1):35–45. 

- [Karl et al. 2016] Karl, M.; Soelch, M.; Bayer, J.; and van der Smagt, P. 2016. Deep variational bayes filters: Unsupervised learning of state space models from raw data. _arXiv preprint arXiv:1605.06432_ . 

- [Kingma and Welling 2014] Kingma, D. P., and Welling, M. 2014. Auto-encoding variational bayes. In _International Conference on Learning Representations_ . 

- [Krishnan, Shalit, and Sontag 2017] Krishnan, R. G.; Shalit, U.; and Sontag, D. 2017. Structured inference networks for nonlinear state space models. In _Thirty-First AAAI Conference on Artificial Intelligence_ . 

- [Lin, Khan, and Hubacher 2018] Lin, W.; Khan, M. E.; and Hubacher, N. 2018. Variational message passing with structured inference networks. In _International Conference on Learning Representations_ . 

- [Lipton, Kale, and Wetzel 2016] Lipton, Z. C.; Kale, D.; and Wetzel, R. 2016. Directly modeling missing data in sequences with rnns: Improved classification of clinical time series. In _Machine Learning for Healthcare Conference_ , 253–270. 

- [Neil, Pfeiffer, and Liu 2016] Neil, D.; Pfeiffer, M.; and Liu, S.-C. 2016. Phased lstm: Accelerating recurrent network training for long or event-based sequences. In _Advances in neural information processing systems_ , 3882–3890. 

- [Ong, Zaki, and Goodman 2015] Ong, D. C.; Zaki, J.; and Goodman, N. D. 2015. Affective cognition: Exploring lay theories of emotion. _Cognition_ 143:141–162. 

- [Rezende, Mohamed, and Wierstra 2014] Rezende, D. J.; Mohamed, S.; and Wierstra, D. 2014. Stochastic backpropagation and approximate inference in deep generative models. In _International Conference on Machine Learning_ , 1278–1286. 

- [Wu and Goodman 2018] Wu, M., and Goodman, N. 2018. Multimodal generative models for scalable weakly- 

## **Supplemental Material** 

## **Factorized Inference in Deep Markov Models for Incomplete Multimodal Time Series** 

**Tan Zhi-Xuan,**[1, 2] **Harold Soh,**[3] **Desmond C. Ong**[1, 4] 

1A*STAR Artificial Intelligence Initiative, A*STAR, Singapore 

2Department of Electrical Engineering and Computer Science, MIT 

3Department of Computer Science, National University of Singapore 

4Department of Information Systems and Analytics, National University of Singapore xuan@mit.edu, harold@comp.nus.edu.sg, dco@comp.nus.edu.sg 

## **A Products and Quotients of Gaussian Distributions** 

distributions. 

**==> picture [182 x 32] intentionally omitted <==**

where each _f_ ( _x|µi,_ Σ _i_ ) is a multivariate Gaussian with mean _µi_ , covariance Σ _i_ and precision _Ti_ = Σ _[−] i_[1][.][Under the constraint that][ �] _[k] i_ =1 _[T][i][>]_[ �] _[l] j_ = _k_ +1 _[T][j]_[element-wise,] _[ g]_[(] _[x]_[)][ is also multivariate] Gaussian with mean and covariance: 

**==> picture [287 x 39] intentionally omitted <==**

If the constraint is not satisfied, then _g_ ( _x_ ) cannot be normalized into a well-defined probability distribution. The reader may refer to [1] for a modern proof. 

## **B Multimodal Bidirectional Training Loss** 

Bidirectional factorized variational inference (BFVI) requires training the Multimodal Deep Markov Model (MDMM) to perform both backward filtering and forward smoothing. In addition, the model has to learn how to perform inference given multiple modalities, both jointly and in isolation. As such, we extend the multimodal training paradigm proposed for the MVAE [1]. For each batch of training data, we compute and minimize the following multimodal bidirectional training loss: 

**==> picture [382 x 124] intentionally omitted <==**

Here, _λ_ filter, _λ_ smooth and _λ_ match are loss multipliers. _L_[1:] filter _[M]_[and] _[L]_[1:] smooth _[M]_[are][the][multimodal][ELBO] losses for filtering and smoothing respectively: 

_λm_ is the reconstruction loss multiplier for modality _m_ , and _β_ is the loss multiplier for the KL divergence. _L[m]_[and] _[ L][m]_ smooth[are the corresponding unimodal ELBO losses:] 

**==> picture [356 x 59] intentionally omitted <==**

_L_ match is the prior matching loss, to ensure that the forward and backward dynamics conform the assumption that _p_ ( _zt_ ) is invariant with _t_ : 

**==> picture [270 x 23] intentionally omitted <==**

To compute _L_ match, we need to sample particles from _p_ ( _zt_ ), introducing _Kp_ , the number of prior matching particles, as a hyper-parameter. Similarly, we need to perform backward filtering with sampling to compute the smoothing ELBOs, for which we use _Kb_ backward filtering particles. 

_L_ filter := _L_[1:] filter _[M]_[+][ �] _[M] m_ =1 _[L][m]_ filter[and] _[ L]_ smooth[1:] _[M]_[:=] _[ L]_[1:] smooth _[M]_[+][ �] _[M] m_ =1 _[L]_ smooth _[m]_[are minimized together so as] to ensure that the model learns accurate backward dynamics. This is done because computation of _L_ smooth involves a backward pass which requires sampling under the backward filtering distribution. As such, to accurately approximate _L_ smooth, the backward filtering distribution has to be reasonably accurate as well, which motivates optimizing _L_ filter jointly. 

Empirically, we found that optimizing _L_ smooth alone led to poor performance for backward extrapolation, and to small gradients for the backward transition parameters, suggesting that the backward pass was too far upstream in the computation graph. Optimizing _L_ filter in addition to _L_ smooth rectified this issue with vanishing gradients. While we chose to weight _L_ filter and _L_ smooth equally, many other training schemes are possible, e.g., placing a high weight on _L_ filter initially and then annealing it to zero, such that only _L_ smooth (i.e. the correct ELBO if one’s goal is to perform only smoothing) is optimized eventually. Such training schemes should be investigated in future work. 

## **C Model and Inference Architectures** 

## **C.1 Transition Functions** 

We use a variant of the Gated Transition Function (GTF) from [2] to parameterize both the forward transition _p_ ( _zt|zt−_ 1) and backward transition _p_ ( _zt|zt−_ 1): 

**==> picture [230 x 12] intentionally omitted <==**

**==> picture [189 x 12] intentionally omitted <==**

**==> picture [92 x 12] intentionally omitted <==**

**==> picture [121 x 11] intentionally omitted <==**

**==> picture [135 x 12] intentionally omitted <==**

where Linear _b←a_ is a linear mapping from _a_ to _b_ dimensions, _◦_ is function composition, and _⊙_ is element-wise multiplication, _|z|_ is the dimension of the latent space (5 for spirals, 256 for videos), and _|h|_ is the dimension of the hidden layer (20 for spirals, 256 for videos). To stabilize training when using BFVI, we found it necessary to add a small constant (0 _._ 001) to the standard deviation, _σt_ . To be clear, we learn separate networks each for the forward and backward transitions. 

## **C.2 Encoders and Decoders** 

For the Spirals dataset, we used multi-layer perceptrons as encoders and decoders for the _x_ and _y_ data, withlearn a network that parameterizes the quotient _|h|_ = 20 hidden units. Let _v_ stand for either _q_ ˜( _zt|vt_ ) = _x q_ or( _z yt|_ , and recall that for the encoder, we _vt_ ) _/p_ ( _zt_ ). The architectures are: 

**==> picture [343 x 57] intentionally omitted <==**

2 

For the Weizmann video dataset, we used a variant of the above to work with categorical distributions over the action labels. Again we use _v_ as a placeholder. The architectures are: 

**==> picture [349 x 72] intentionally omitted <==**

The number of categories is denoted by _k_ (10 for actions), and we used _|h|_ = 256. For the encoders and decoders from and to images (video frames or silhouette masks), see Figure S1 below. 

**==> picture [380 x 83] intentionally omitted <==**

**----- Start of picture text -----**<br>
3@64x64 64@8x8 Dense 64@8x8 3@64x64<br>16@32x32 32@16x16 1x256 32@16x16 16@32x32<br>� 1x256<br>z<br>� 1x256<br>Dense +<br>Conv +BatchNorm + Conv +BatchNorm + Conv +BatchNorm + Dense +Softplus ReLU Deconv +BatchNorm + Deconv +BatchNorm + Deconv +BatchNorm +<br>ReLU ReLU ReLU ReLU ReLU ReLU<br>(a) Image Encoder (b) Image Decoder<br>**----- End of picture text -----**<br>


Figure S1: Image encoder and decoder architectures. Convolutional layers use 3 _×_ 3 kernels, deconvolutional layers use 4 _×_ 4 kernels, both use a stride of 2 and padding of 1. Silhouette masks were had 1 input channel instead of 3 input channels. 

## **C.3 Inference Networks** 

The encoder architectures described in the previous section are designed to work with BFVI, and so they directly output distribution parameters _µz_ , _σz_ for the latent state _zt_ . To adapt them to work with the RNN-based structured inference networks (F-Mask, F-Skip, B-Mask, B-Skip), we simply remove the Gaussian output layers from each encoder, using the features _ft[m]_ of the penultimate layer as inputs to the RNN at each time step. 

We follow the original DMM implementation [2] in using Gated Recurrent Units (GRUs) for the structured inference networks. To generalize this to the multimodal case, we have one GRU per modality, which we label GRU _m_ for modality _m_ . The difference between the Mask and Skip methods is that the former uses zero-masking of missing inputs: 

**==> picture [201 x 25] intentionally omitted <==**

whereas the latter skips the update for the hidden state _h[m] t_[of GRU] _[m]_[whenever] _[ x][m] t_[is missing:] 

**==> picture [201 x 25] intentionally omitted <==**

Update skipping is the method used in [2]’s implementation to handle missing data. For the forward RNNs (F-Mask and F-Skip), we take the positive sign in the plus-minus signs above, while for the backward RNNs (B-Mask and B-Skip), we take the negative sign. 

In order to combine the information from the RNNs with the previous latent state _zt−_ 1 to infer the current latent state _zt_ , we use a variant of the combiner function from [2] that takes in _zt−_ 1 and the hidden states _h[t] m_[of all modalities as inputs:] 

**==> picture [121 x 11] intentionally omitted <==**

**==> picture [175 x 44] intentionally omitted <==**

We use _|h|_ = 5 for the spirals dataset and _|h|_ = 256 for the videos (same dimensions for the both the hidden layer and the GRU hidden states). Because the above formulation has no direct connection 

3 

from the current input _xt_ to the current latent state _zt_ , it seemed like it would hurt performance when we needed _zt_ to be a good low-dimensional representation of _xt_ . As such, for the video dataset, we used a variant that also takes in the encoded features _ft[m]_ as inputs (if _x[m] t_[is missing, then the] corresponding feature _ft[m]_ is zero-masked): 

**==> picture [276 x 58] intentionally omitted <==**

Table S1 compares the number of neural network parameters (model networks + inference networks) required for BFVI vs. the RNN-based inference methods. Despite matching hidden layer dimensions, BFVI still uses 2 to 3 times less parameters, because it does not require inference RNNs for each modality, and uses Product-of-Gaussians for fusion instead of a combiner network. 

|**Method**|**Number**|**of parameters**|
|---|---|---|
||_Spirals_|_Weizmann_|
|BFVI|1854|4542503|
|RNN-based|7124|7494183|



Table S1: Number of network parameters for each method. 

## **D Training Parameters** 

|**Parameter**||**Spirals**|**Weizmann**|
|---|---|---|---|
|Filtering ELBO mult.|_λ_flter|0.5|”|
|Smoothing ELBO mult.|_λ_smooth|0.5|”|
|Prior matching mult.|_λ_match|0.01_β_|”|
|Reconstruction mult.|_λm_|_x, y_: 1|Vid.: 1, Sil.: 1, Act.:10|
|KL divergence mult.<br>Bwd. fltering particles|_β_<br>_Kb_|Anneal(0,1) over_Eβ_<br>25|”<br>”|
|Prior matching particles|_Kp_|50|”|
|Training epochs|_E_|500|400|
|_β_-annealing epochs|_Eβ_|100|250|
|Early stopping||Yes|No|
|Batch size||100|25|
|Sequence splitting||No|Into 25 time-step segments|
|Optimizer||ADAM|”|
|Learning rate||0.02 (BFVI), 0.01 (Rest)|5_×_10_−_4|
|Weight decay||1_×_10_−_4||
|Burst deletion rate||0.1|0.2|



Table S2: Training parameters for spirals and Weizmann datasets. 

Table S2 provides the training parameters we used. Unless specified, parameters were kept constant across inference methods. As in most VAE-like models, we anneal _β_ , the multiplier for the KL divergence loss from 0 to 1 over time. This incentivizes the model to first find encoders and decoders that reconstruct well, before regularizing the latent space [3]. Since the prior matching multiplier _λ_ match also serves to regularize the latent space, we tie its value to _β_ , so that it increases as _β_ increases. 

To speed up training on the video dataset, we split each input sequence into segments that were 25 time steps long, and trained on those segments. To improve the robustness to missing data when training each methods, we also introduced burst deletion errors — random contiguous deletions of inputs. For the spirals dataset, we deleted input segments at training time that were 0 _._ 1 long as the original video lengths. For the video dataset, we deleted input segments at training time that were 0 _._ 2 long as the original video lengths. Deletion start points were selected uniformly at random. 

4 

For the RNN-based methods, no bidirectional training is involved, so we only minimized the (forward) filtering ELBO (for F-Mask, F-Skip) or the smoothing ELBO (for B-Mask, B-Skip). While we also tried to use the multimodal training paradigm (i.e. minimizing the sum of _L_[1:] _[M]_ and _L[m]_ ) for the RNN-based methods, the effects of this were mixed: On the spirals dataset, performance dropped very sharply with the multimodal paradigm, whereas performance increased on the Weizmann video dataset. As such, the results we report in the main manuscript use the multimodal training paradigm only for the video dataset. For the spirals dataset, we only minimize _L_[1:] _[M]_ , with all inputs provided, but not _L[m]_ , which is computed with only modality _m_ provided as input. Finally, we used a higher learning rate (0.02) for BFVI on the spirals dataset because we noticed slow convergence with the lower rate of 0.01. Increasing the learning rate to 0.02 for the other methods hurt their performance. 

## **E Evaluation Details** 

> When evaluating the models, we estimate the MAP latent sequenceˆ ˆ _z_ 1: _[∗] T_[= arg max] _[z]_ 1: _T[p]_[(] _[z]_[1:] _[T][ |][x]_[1:] _[T]_[ )] by estimating _zt_ = arg max _z_ 1: _T q_ ( _zt|zt−_ 1 _, xt_ : _T_ ) for each _t_ (i.e., we recursively take the mean of the ˆ approximate conditional smoothing posterior, _q_ ( _zt|zt−_ 1 _, x_ 1: _T_ ).) For reconstruction, we then decode this inferred latent sequence and take the MLE of the observations, ˆ _x_ 1: _T_ = arg max _x_ 1: _T p_ ( _x_ 1: _T |z_ ˆ1: _T_ ). While this does not infer the exact MAP sequence, it has been standard practice for recurrent latent variable models [2], and we find it empirically adequate in lieu of approximate Viterbi sequencing. 

_Kb_ for the backward pass at evaluation time. We used _Kb_ = 200 for additional stability, though we found that lower values also produced similar results. 

To evaluate the performance of BFVI and the next-best method under weakly supervised learning, we performed 10 training runs for each method and each level of data deletion, then reported the average of best 3 runs. This was done in order to exclude outlying runs where training instability emerged, leading to divergence of the loss function. At test time, the inference task for the Spirals dataset was to reconstruct each spiral given that the first and last 25% of data points were removed, and an additional 50% of data points were deleted at random. The inference task for the Weizmann dataset was to predict the action labels when only the video modality was provided, and 50% of the video frames were missing. 

## **F Additional Results** 

## **F.1 Spiral reconstructions** 

best method, here we show a more complete comparison of all 5 methods on the Spirals dataset (Figure S2). 

## **References** 

- [1] Mike Wu and Noah Goodman. Multimodal generative models for scalable weakly-supervised learning. In _Advances in Neural Information Processing Systems_ , pages 5575–5585, 2018. 

- [2] Rahul G Krishnan, Uri Shalit, and David Sontag. Structured inference networks for nonlinear state space models. In _Thirty-First AAAI Conference on Artificial Intelligence_ , 2017. 

- [3] Samuel R Bowman, Luke Vilnis, Oriol Vinyals, Andrew M Dai, Rafal Jozefowicz, and Samy Bengio. Generating sentences from a continuous space. _arXiv preprint arXiv:1511.06349_ , 2015. 

5 

**==> picture [343 x 380] intentionally omitted <==**

**----- Start of picture text -----**<br>
Recon. Drop Half Fwd. Extra. Bwd. Extra. Cond. Gen<br>MSE: 0.014 MSE: 0.023 MSE: 0.085 MSE: 0.040 MSE: 0.058<br>MSE: 0.018 MSE: 0.030 MSE: 0.061 MSE: 0.036 MSE: 1.415<br>MSE: 0.041 MSE: 0.101 MSE: 0.159 MSE: 0.088 MSE: 1.625<br>MSE: 0.018 MSE: 0.029 MSE: 0.178 MSE: 0.023 MSE: 2.157<br>MSE: 0.032 MSE: 0.165 MSE: 0.162 MSE: 0.206 MSE: 0.517<br>predicted ground truth observations x  observed y  observed<br>BFVI<br>F-Mask<br>F-Skip<br>B-Mask<br>B-Skip<br>**----- End of picture text -----**<br>


Figure S2: Reconstructions for all 5 spiral inference tasks (columns) for all methods (rows). Our BFVI method does well on all tasks, but especially better than the other methods on the Conditioned Generation task (right-most column), where only the _x_ - and first 25% of the _y_ -coordinates are given. 

6 

