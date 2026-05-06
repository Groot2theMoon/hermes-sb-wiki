---
source_url: https://arxiv.org/abs/2504.17836
ingested: 2026-05-05
type: raw-paper
tags: [ensemble-kalman-filter, set-transformer, measure-neural-mapping, learned-filter]
---

## Highlights 

## **Learning Enhanced Ensemble Filters** 

Eviatar Bach, Ricardo Baptista, Edoardo Calvello, Bohan Chen[*] , Andrew Stuart 

- We present a framework for learning ensemble filtering algorithms, based on a mean-field state-space formulation of the evolution of the filtering distribution. 

- We introduce a novel generalization of neural operators to maps defined to act between metric spaces of probability measures. We call such maps _measure neural mappings_ (MNM). We identify an architecture to implement such maps, based on the attention mechanism. 

- The MNM architecture is used to define approximations of the mean-field formulation of the filtering distribution. This leads to a novel learning-based framework for ensemble methods: the _measure neural mapping enhanced ensemble filter_ (MNMEF). 

- Because of the mean-field underpinnings, the basic learned parameters are shared between filters with different ensemble sizes. As a consequence, parameterizations learned at one ensemble size can be deployed at different ensemble sizes, leading to efficient training at small ensemble sizes. To enhance this approach, we introduce a fine-tuning methodology to incorporate a small number of parameters, such as localization and inflation, which intrinsically depend on ensemble size, into the resulting filters. 

- We demonstrate that the resulting filtering algorithm outperforms an optimized local ensemble transform Kalman filter (LETKF, a leading ensemble filter) on Lorenz ’96, Kuramoto–Sivashinsky, and Lorenz ’63 models, for both small and larger ensemble sizes. 

- *Corresponding author. Email: bhchen@caltech.edu 

## Learning Enhanced Ensemble Filters 

## Eviatar Bach[a,b,c] , Ricardo Baptista[d,e] , Edoardo Calvello[f] , Bohan Chen[*f] , Andrew Stuart[f] 

_aDepartment of Meteorology, University of Reading, Brian Hoskins Building, Reading, RG6 6ET, UK bDepartment of Mathematics and Statistics, University of Reading, Pepper Lane, Reading, RG6 6AX, UK_ 

_cNational Centre for Earth Observation, Brian Hoskins Building, University of Reading, Reading, RG6 6ET, UK dDepartment of Statistical Sciences, University of Toronto, Ontario Power Building, 700 University Ave., Toronto, M5G 1Z5, ON, Canada eVector Institute for Artificial Intelligence, 661 University Ave., Toronto, M5G 1M1, ON, Canada fThe Computing_ + _Mathematical Sciences Department, California Institute of Technology, 1200 E California Blvd, Pasadena, 91125, CA, USA_ 

## **Abstract** 

The filtering distribution in hidden Markov models evolves according to the law of a mean-field model in state– observation space. The ensemble Kalman filter (EnKF) approximates this mean-field model with an ensemble of interacting particles, employing a Gaussian ansatz for the joint distribution of the state and observation at each observation time. These methods are robust, but the Gaussian ansatz limits accuracy. Here this shortcoming is addressed by using machine learning to map the joint predicted state and observation to the updated state estimate. The derivation of methods from a mean field formulation of the true filtering distribution suggests a single parametrization of the algorithm that can be deployed at different ensemble sizes. And we use a mean field formulation of the ensemble Kalman filter as an inductive bias for our architecture. 

To develop this perspective, in which the mean-field limit of the algorithm and finite interacting ensemble particle approximations share a common set of parameters, a novel form of neural operator is introduced, taking probability distributions as input: a _measure neural mapping_ (MNM). A MNM is used to design a novel approach to filtering, the _MNM-enhanced ensemble filter_ (MNMEF), which is defined in both the mean-field limit and for interacting ensemble particle approximations. The ensemble approach uses empirical measures as input to the MNM and is implemented using the set transformer, which is invariant to ensemble permutation and allows for different ensemble sizes. In practice fine-tuning of a small number of parameters, for specific ensemble sizes, further enhances the accuracy of the scheme. The promise of the approach is demonstrated by its superior root-mean-square-error performance relative to leading methods in filtering the Lorenz ‘96 and Kuramoto–Sivashinsky models. 

_Keywords:_ data assimilation, ensemble filter, neural operators 

## **1. Introduction** 

Filtering, determining the conditional distribution of the state of a partially and noisily observed dynamical system given data collected sequentially in time, constitutes a longstanding computational challenge, particularly when the state is high-dimensional. Sequential data assimilation encompasses a broad range of methods aimed at finding the filtering distribution, or simply estimating the state, in an online fashion. The focus of this work is on the use of sequential data assimilation methods for filtering and state estimation, and in particular the methodologies developed primarily in the geophysical sciences, and weather prediction especially, which are relevant in high dimensions. The overarching goal is to introduce a new framework for the _machine learning_ of data assimilation (DA) algorithms, and specifically ensemble filters, which facilitates the sharing of parameters between implementations with different ensemble sizes; we may, for example, train and deploy the same model with different ensemble sizes. To achieve this we work in the context of mean-field state-space formulations of filtering. This perspective enables us to consider the idea of learning algorithms which share a common set of parameters, regardless of ensemble size, by viewing large ensembles as approximating a common mean field limit. In practice, small ensemble sizes behave differently 

> *Corresponding author. Email: bhchen@caltech.edu 

from large ensemble sizes, an issue that has heretofore been addressed by use of inflation and localization. Here we show that an efficient fine-tuning strategy can be used to transfer parameters trained at one ensemble size to another ensemble size, at which the algorithm can be deployed. The resulting algorithms are based on stochastic dynamical systems for a state variable whose evolution depends on its own law; particle approximation leads to implementable algorithms. We show how the attention mechanism, adapted from the transformer methodology at the heart of large language models, can be used to define probability measure-dependent transport maps, i.e. mappings that move probability mass from one distribution to another, that can be approximated by empirical measures using arbitrary ensemble sizes. We refer to the resulting class of neural network architectures as _measure neural mappings_ . 

In Subsection 1.1, we set our work in the context of pre-existing literature. We introduce notation used throughout the paper in Subsection 1.2. Then, we describe the specific contributions we make to achieve our overarching goal, and we overview the contents of the paper in Subsection 1.3. 

## _1.1. Literature Review_ 

Data assimilation (DA) is a fundamental framework for integrating observational data with numerical models for the purpose of state estimation and forecasting. DA methods systematically combine observations with prior model forecasts, accounting for their respective uncertainties, to produce optimal estimates of the system state or to characterize a probability distribution over the state. Several textbooks provide comprehensive overviews of this field [1, 2, 3, 4, 5, 6]. 

The Kalman filter [7] is a foundational sequential data assimilation algorithm for linear systems with Gaussian errors. The extended Kalman filter, using linearization, adapts the Kalman methodology to nonlinear systems, but its direct application to high-dimensional geophysical problems is computationally prohibitive. The ensemble Kalman filter (EnKF) [8, 9, 10] addresses this limitation through a Monte Carlo approach, representing statistics via a limited ensemble of model states. Square-root variants, including the ensemble transform Kalman filter and the ensemble adjustment Kalman filter [10, 11], reduce both storage requirements and sampling errors through deterministic formulations. Stochastic EnKF variants update each ensemble member using the Kalman filter equation with random perturbations in the innovation; [12] provides a consistent derivation that favors perturbing the modeled observations. However, EnKF-based methods commonly encounter challenges in practical implementations and, in particular, suffer from sampling errors caused by finite ensemble sizes. To address these limitations, covariance inflation [13, 14] and localization [15] techniques have been developed. Approaches such as the iterative EnKF [16] and the maximum likelihood ensemble filter [17] further improve performance in nonlinear regimes. 

The integration of machine learning methodologies into DA has recently emerged as a powerful strategy to enhance predictive accuracy and scalability beyond traditional approaches constrained by Gaussian assumptions. Such machine learning approaches are reviewed in [18, 6]. A key direction has been the direct learning of filters from data. Learning a fixed-gain filter was considered in [19, 20, 21, 22]. McCabe et al. [23] developed an ensemble filter that uses the mean and covariance matrix as input to a recurrent neural network. Bocquet et al. [24] further demonstrated the efficacy of neural network-based filtering schemes without relying on an ensemble, achieving comparable accuracy to ensemble methods by identifying key dynamical perturbations directly from forecast states. 

Complementary to these direct learning strategies, a distinct class of approaches formulates ensemble filtering as a transport problem. These methods explicitly construct transformations that map forecast distributions onto analysis distributions. Representative techniques include Knothe–Rosenblatt rearrangements [25], normalizing flows [26], bridge matching [27], and optimal transport frameworks [28]. These methods offer rigorous probabilistic interpretations and enable accurate sampling from the filtering distribution at each assimilation step. Typically these approaches find transformations acting on each individual particle, rather than operating directly at the distributional level, and are not designed to directly transform or update the ensemble members collectively. 

Beyond per-particle transformations, a complementary line of research updates the ensemble collectively via particle flows [29], with applications to atmospheric models [30]. Early particle-flow methods cast the analysis as a continuous ordinary differential equation that drives particles toward the posterior [31], with related continuous-time ensemble formulations such as the EnKF–Bucy perspective [32]. Variational or Stein-based mappings are considered to push forward the prior through learned maps, e.g., the variational mapping particle filter [33]. 

Probabilistic formulations provide another promising direction for learning-based filters. These approaches aim to directly approximate the Bayesian inference problem of obtaining the filtering distribution [34, 35, 22, 6]. In 

2 

particular, recent works have proposed frameworks to jointly learn the forecast and analysis steps [35], or assume knowledge of the dynamics and learn parameterized analysis maps via variational inference [22]. 

Building on the use of deep learning architectures for ensemble filtering, recent efforts have incorporated permutationinvariant neural networks to respect the unordered nature of ensembles. Such architectures enable models to learn interactions among ensemble members without being sensitive to their ordering, which is essential for consistent filter behavior across runs. These designs have been applied to directly learn ensemble update rules [36] and to refine ensemble forecasts in post-processing settings [37]. 

Transformers and the underlying attention mechanism [38] are now ubiquitous in machine learning. Their success at modeling global, long-range correlations has made this architecture an attractive methodology for operator learning; see for example [39, 40, 41, 42]. In this article we are interested in the attention mechanism as a map between metric spaces of probability measures, thus going beyond the definition on Euclidean spaces from [38] and the generalization to Banach spaces in [41]. Recent developments in the mathematical analysis of transformers have led to the formulation of the continuum limit of self-attention layers [43]. In [43] the authors describe the evolution under this continuum limit architecture as the solution of a continuity equation; see [44] for an overview on this perspective. This formulation is also employed in [45] to analyze self-attention dynamics as a measure-to-measure map. However, this analysis is restricted to measures defined on the sphere and does not include cross-attention. In this article we present a general methodological framework for neural network architectures on the metric space of probability measures and a general definition of attention as a measure-to-measure map. We will leverage this formulation to build implementable methodologies effecting data assimilation. 

## _1.2. Notation_ 

Throughout the paper we use N = {1, 2, . . .}, Z[+] = {0, 1, 2, . . .}, R = (−∞, ∞), and R[+] = [0, ∞) to denote the set of positive integers, non-negative integers, real numbers, and non-negative real numbers, respectively. We define [ _N_ ] = {1, 2, . . . , _N_ }. We use F ( _A_ ) to denote the set of all nonempty finite subsets of a set _A_ . 

We denote by P(Ω) the space of probability measures defined on set Ω. Given a sigma-algebra on Ω, we define a probability measure P on Ω and we let E denote expectation under this probability measure. We denote by Law( _v_ ) the law of a random variable _v_ , and denote by _T_ #π the pushforward measure of π by the map _T_ : if _u_ ∼ π then _T_ ( _u_ ) ∼ _T_ #π. For τ ∈ R _[d]_ , we let δτ denote the Dirac mass on R _[d]_ centered at point τ. We use the notation N( _m_ , _C_ ) for the Gaussian distribution with mean _m_ and covariance _C_ . We use the font mathsf for operators acting on the space of probability measures or the space of functions; we also use this convention for operations on the space of vector-valued sequences over [ _N_ ], denoted by U([ _N_ ]; R _[d]_ ). If an operator B on probability measures is defined as the pushforward by a map, we denote the associated transport map with the font mathfrak, i.e. B(·) = B♯(·). 

In the remainder of this paper we assume that all probability measures are absolutely continuous with respect to the Lebesgue measure so that they have probability density functions, or that they comprise a convex combination of Dirac masses. We will refer to probability measures and probability density functions interchangeably, depending on the setting. 

In the context of DA, we use _v_ to denote the system states and _y_ to denote the observations. The superscript † indicates true values and the subscript _j_ ∈ Z[+] denotes the time step. For ensemble methods, we use the parenthesized superscript ( _n_ ) for the ensemble index. 

## _1.3. Contributions and Overview_ 

Our five primary contributions are as follows: 

1. We present a framework for learning ensemble filtering algorithms, based on a mean-field state-space formulation of the evolution of the filtering distribution. 

2. We introduce a novel generalization of neural operators to maps defined to act between metric spaces of probability measures. We call such maps _measure neural mappings_ (MNM). We identify an architecture to implement such maps, based on the attention mechanism. 

3. The MNM architecture is used to define approximations of the mean-field formulation of the filtering distribution. This leads to a novel learning-based framework for ensemble methods: the _measure neural mapping enhanced ensemble filter_ (MNMEF). 

3 

4. Because of the mean-field underpinnings, the basic learned parameters are shared between filters with different ensemble sizes. As a consequence, parameterizations learned at one ensemble size can be deployed at different ensemble sizes, leading to efficient training at small ensemble sizes. To enhance this approach, we introduce a fine-tuning methodology to incorporate a small number of parameters, such as localization and inflation, which intrinsically depend on ensemble size, into the resulting filters. 

5. We demonstrate that the resulting filtering algorithm outperforms an optimized local ensemble transform Kalman filter (LETKF, a leading ensemble filter) on Lorenz ’96, Kuramoto–Sivashinsky, and Lorenz ’63 models, for both small and larger ensemble sizes. 

In Section 2 we describe filtering from the perspective of mean-field dynamics and define a learning framework to approximate the true filter, addressing Contribution 1. Section 3 is devoted to the introduction of _measure neural mappings_ , a generalization of neural operators to maps taking probability measures as inputs; we show in this section that the attention mechanism can be used to build a transformer architecture defined on probability measures, thereby tackling Contribution 2. Contributions 3 and 4 are addressed in Section 4, where we detail the algorithm for finite particle sizes. The numerical experiments in Section 5 support Contribution 5. We conclude in Section 6. We also note that a reader focused on methodological contributions alone can skip the self-contained Section 3. 

## **2. Learning Mean-field Filters** 

In this section, we formulate the filtering problem (Subsection 2.1), describing sequential DA from the perspective of nonlinear evolution of probability densities (Subsection 2.2) and from the mean-field state-space evolution perspective (Subsection 2.3). We then present the general idea of learning an analysis map which has a probability measure as an input (Subsection 2.4). Finally, we introduce our learning-based mean-field filter approach, which enhances traditional ensemble Kalman filtering by incorporating trainable correction terms in the mean-field equations (Subsection 2.5). This allows us to extend and, as will show in numerical results presented in the penultimate section, improve upon the standard EnKF methodology, which relies on a Gaussian ansatz; in so-doing we maintain the interpretable structure of Kalman filtering. 

## _2.1. Filtering Set-Up_ 

Consider the stochastic dynamics model given by 

**==> picture [310 x 15] intentionally omitted <==**

**==> picture [303 x 15] intentionally omitted <==**

where Ψ : R _[d][v]_ → R _[d][v]_ is the forward dynamic model, and _v_[†] _j_[, ξ][†] _j_[∈][R] _[d][v]_[for] _[j]_[∈][Z][+][.][We][assume][that][the][sequence] {ξ[†] _j_[}] _[ j]_[∈][Z][+][is independent of initial condition] _[ v]_[†] 0[; this is often written as][ {][ξ][†] _j_[}] _[ j]_[∈][Z][+][⊥] _[v]_[†] 0[.][The data model is given by] 

**==> picture [297 x 33] intentionally omitted <==**

where _h_ : R _[d][v]_ → R _[d][y]_ is the observation operator and _y_[†] _j_[, η][†] _j_[∈][R] _[d][y]_[for] _[j]_[ ∈][Z][+][. We assume that the sequence][ {][η][†] _j_[}] _[ j]_[∈][N][⊥] _[v]_[†] 0 and that the two sequences in the dynamics and data models are independent of one another: {ξ[†] _j_[}] _[ j]_[∈][Z][+][⊥{][η][†] _j_[}] _[ j]_[∈][N][.][The] states _v_[†] _j_[lie in][ R] _[d][v]_[, while the observations] _[ y]_[†] _j_[lie in][ R] _[d][y]_[.][Note that there is a hidden parameter][ ∆] _[t]_[ specifying the time] interval between steps _j_ and _j_ + 1. It is implicitly embedded in (2.1) through Ψ, which represents the discrete-time map obtained by integrating the continuous dynamics over an interval of length ∆ _t_ . 

**Remark 1.** _We use_ † _for all variables defining the state and observation, and the noises that define them. This is to distinguish them from other similar variables, appearing without_ † _, in the algorithms that follow. In this paper, we adopt autonomous dynamics with additive Gaussian noises according to_ (2.1) _and_ (2.2) _. There are several extended settings, briefly outlined in Remark 2. These extensions are important in applications but introduce substantial technical challenges. We do not consider those settings in this paper for clarity of exposition._ 

4 

**Remark 2** (Possible extensions beyond the baseline model) **.** _Beyond the autonomous, additive-Gaussian setting in_ (2.1) _–_ (2.2) _, one may consider [46, 47, 4]:_ 

- _**Time-dependent dynamics**_ / _**observations.** Allow_ Ψ _,_ Σ _, h, and_ Γ _to vary with j. This can destroy stationarity and leads to non-homogeneous transition_ / _likelihood kernels._ 

- _**Multiplicative or non-Gaussian noises.** Replace additive Gaussian errors by state-dependent or heavy-tailed noises. This can induce heteroscedastic innovations and non-quadratic likelihoods._ 

- _**Infinite-dimensional state spaces.** Model v j in a function space (e.g., a separable Hilbert space) for PDEgoverned systems. One must address well-posedness (e.g., trace-class noise_ / _covariances), operator-valued updates, and consistency under spatial discretization_ / _mesh refinement._ 

There are two primary types of problems in data assimilation: the filtering problem and the smoothing problem. In this paper, we focus on the filtering problem. To this end we define the accumulated data up to time _j_ by _Y_[†] _j_[:][=] { _y_[†] 1[, . . . ,] _[ y]_[†] _j_[}][.][Using][this][notation][we][state][the][filtering][problem][in][Definition][1,][and][the][state][estimation][problem][that] stems from it in Definition 2. 

**Definition 1** (The Filtering Problem) **.** _The filtering problem refers to identifying and sequentially updating the probability densities_ π _j_ ( _v_[†] _j_[) :][=][ P][(] _[v]_[†] _j_[|] _[Y]_[†] _j_[)] _[ in]_[ P][(][R] _[d][v]_[)] _[ for][j]_[ ∈][[] _[J]_[]] _[.][These densities]_[ π] _[j][ are referred to as the filtering distributions] at time j._ 

**Definition 2** (State Estimation) **.** _The state estimation problem refers to estimating the state v_[†] _j[,][based][on][the][given] observations Y_[†] _j[, and to updating the estimate sequentially over a series of time indices][j]_[ ∈][[] _[J]_[]] _[.]_ 

State estimation can be viewed as a subproblem of the filtering problem. Given the filtering distribution π _j_ , a natural state estimate is the conditional expectation E[ _v_[†] _j_[|] _[Y]_[†] _j_[] as this delivers the minimum mean-squared error estimate] of _v_[†] _j_[.][In this paper we explicitly focus on] _[ state estimation]_[:][our objective is to recover the hidden state] _[ v]_[†] _j_[at each time] step rather than to approximate the full filtering distribution π _j_ . Accordingly, our loss functions are defined with respect to the true state. We note that, in high-dimensional settings, the conditional mean is generally inaccessible in practice—accurate computation would require particle filters with prohibitively large ensembles—so it is standard to evaluate and tune filters against the true state. As outlined in Section 6, our framework can be extended to the filtering problem by adopting distribution-matching losses to learn the filtering distribution (and hence its mean). 

## _2.2. Filtering: Probability Evolution_ 

We consider the filtering problem, which consists of identifying the filtering distribution given by 

**==> picture [271 x 15] intentionally omitted <==**

We define the following two measures 

**==> picture [302 x 33] intentionally omitted <==**

The update π _j_ → π _j_ +1 can be written in the following three steps: 

**==> picture [388 x 45] intentionally omitted <==**

P is a linear operator that transforms the filtering distribution at time _j_ to the forecast distribution at time _j_ + 1, and is given for the stochastic dynamics model in (2.1) by: 

**==> picture [345 x 40] intentionally omitted <==**

Q is also a linear operator, one that multiplies the forecast distribution by the observation likelihood, and is given by: 

**==> picture [335 x 28] intentionally omitted <==**

Then, the nonlinear operator B can be written in the form: 

**==> picture [311 x 33] intentionally omitted <==**

## _2.3. Filtering: State-Space Evolution_ 

Directly evolving the filtering distribution π _j_ is generally intractable since the nonlinear operator B (2.8) cannot be computed explicitly for most practical applications. Alternatively, we consider a random state evolution process governed by its own law, given by 

**==> picture [397 x 45] intentionally omitted <==**

where ρ _j_ +1 is the joint measure defined by (2.4b). From the definitions of P (2.6) and Q (2.7), and from equations � � � � (2.9a) and (2.9b), it follows that ( _v j_ +1, _y j_ +1) is distributed as ρ _j_ +1, i.e., ρ _j_ +1 = Law[�] ( _v j_ +1, _y j_ +1)[�] . Now, using the theory of transport, we choose B so that the pushforward of ρ _j_ +1 under this map delivers the desired conditioning on the observed data _y_[†] _j_ +1[:] 

**==> picture [171 x 15] intentionally omitted <==**

It follows that if π _j_ = Law( _v j_ ) then π _j_ +1 = Law( _v j_ +1). 

The preceding construct is mathematically appealing but it leaves open the question of how to identify an appropriate choice of B. The mean-field ensemble Kalman filter [48] leaves (2.9a) and (2.9b) intact but replaces the mapping B in (2.9c) by the affine (in (� _v j_ +1,� _y j_ +1)) approximation 

**==> picture [304 x 15] intentionally omitted <==**

defined by 

**==> picture [299 x 36] intentionally omitted <==**

Here, _K j_ +1 is called the Kalman gain, _C_[�] _[vh]_ is the covariance between � _v j_ +1 and _h_ (� _v j_ +1), and _C_[�] _[hh] j_ +1[is the covariance for] _h_ (� _v j_ +1). Both _C_[�] _[vh]_ and _C_[�] _[hh] j_ +1[are computed under][ �][π] _[j]_[+][1][:] 

**==> picture [324 x 34] intentionally omitted <==**

Here, _v j_ +1 and _h j_ +1 are the mean of states and observations respectively, under �π _j_ +1: 

**==> picture [307 x 13] intentionally omitted <==**

We note that in computation of these covariances we have simply used expectations under �π _j_ +1, the marginal of ρ _j_ +1 on the state. It is possible to use the replacement 

**==> picture [68 x 28] intentionally omitted <==**

where _C_[�] _[yy] j_ +1[is the covariance for][�] _[y][j]_[+][1][.][ Hence we write the map][ B][EnKF][ as dependent on][ ρ] _[ j]_[+][1][, which covers both cases.] What is sometimes termed the stochastic ensemble Kalman filter is implemented in practice by employing an interacting particle system approximation of the mean-field model. The methodology uses the empirical measure defined by the set of _N_ particles { _v_[(] _j_[ℓ][)][}] ℓ _[N]_ =1[to approximate the filtering distribution][ π] _[ j]_[=][ Law(] _[v][j]_[), and hence the empirical] measure defined by �� _v_[(] _j_[ℓ] +[)] 1�ℓ _N_ =1[and] ��� _v_[(] _j_[ℓ] +[)] 1[,][�] _[y]_[(] _j_[ℓ] +[)] 1��ℓ _N_ =1[, to approximate][ �][π] _[ j]_[+][1][and][ ρ] _[ j]_[+][1][, respectively.][We write the resulting] approximations as 

**==> picture [326 x 29] intentionally omitted <==**

Making this particle approximation in (2.9), and replacing B by BEnKF leads to the interacting particle system 

**==> picture [304 x 52] intentionally omitted <==**

This is a particular instance of the ensemble Kalman filter (EnKF), where use of the empirical approximation ρ[(] _j[N]_ +1[)] means that the covariances _C_[�] _[vh] C_[�] _[hh] j_ +1[and] _j_ +1[given by (2.12) are now computed by use of empirical approximation][ �][π][(] _j[N]_ +1[)] of �π _j_ +1: 

**==> picture [425 x 63] intentionally omitted <==**

Here _v j_ +1 and _h j_ +1, originally defined in (2.13), are also computed by use of an empirical approximation of �π _j_ +1: 

**==> picture [372 x 29] intentionally omitted <==**

**Remark 3.** _The ensemble Kalman filter exhibits permutation invariance with respect to the ensemble members. This important property stems from the fact that both the sample means v j_ +1 _, h j_ +1 _in_ (2.17) _and the empirical covariance matrices C_[�] _[vh] C_[�] _[hh]_[(2.16)] _[are][calculated][as][averages][over][all][ensemble][members,][making][them][invariant][to][the] j_ +1 _[,] j_ +1 _[in] ordering of particles in the ensemble. This permutation invariance is a crucial property that motivates the design of our methodology._ 

## _2.4. Learning Probability Measure–Dependent Analysis Maps_ 

Machine learning–based approaches can be applied to approximate the analysis step (2.5c). Indeed, one may seek an operator BMNM ( _measure neural mappings, or MNMs, will be introduced in Section 3) acting on probability measures so that_ 

**==> picture [300 x 15] intentionally omitted <==**

This aim motivates a novel and significant extension of neural operators [49, 50]: designing operator architectures that act on the space of probability measures. We refer to these neural operators that act on probability measures as _measure neural mappings_ (MNM). A natural way to construct such an approximation is by neural operator BMNM, acting on the joint space of state and data and parameterized by the observation and by the law of the state, so that 

**==> picture [362 x 33] intentionally omitted <==**

**==> picture [6 x 7] intentionally omitted <==**

The map BMNM in (2.19a) acts on the joint state–observation space; in contrast the map BMNM in (2.19b), defined through pushforward, acts on the space of probability measures on the state space. The quantities after the semi-colon parameterize these maps. To use this neural operator approximation in the state-space evolution, we replace (2.9c) by the approximation 

**==> picture [303 x 15] intentionally omitted <==**

## _2.5. EnKF-Inspired Probability Measure–Dependent Analysis Maps_ 

We now propose a specific novel filtering methodology, which we coin as the _measure neural mapping enhanced ensemble filter_ (MNMEF). In this section, we will discuss the mean-field formulation of this approach. We consider a specific form of BMNM inspired by the success of the EnKF and describe it here in the mean-field limit. We generalize (2.11) to take the form 

**==> picture [309 x 34] intentionally omitted <==**

where _K_ θ �ρ _j_ +1, _y_[†] _j_ +1� is a parameterized R _[d][v]_[×] _[d][y]_ -valued function, and θ denotes the vector of trainable parameters. Our proposed choice for BMNM (2.21a) introduces inductive bias by mimicking the affine EnKF update. The following proposed form for _K_ θ(•, •) is identical at each time step; for simplicity we omit the subscript _j_ + 1 in its definition and, in particular, use �π as the distribution of the predicted state. We assume the following form for _K_ θ, generalizing the Kalman gain (2.11b): 

**==> picture [280 x 18] intentionally omitted <==**

Here _K_ θ[(1)] and _K_ θ[(2)] are modified versions of _C_[�] _[vh]_ and _C_[�] _[hh]_ from (2.12). Specifically we have 

**==> picture [326 x 34] intentionally omitted <==**

where _w_ �θ and � _z_ θ are trainable correction terms that depend on the state � _v_ , observation _h_ (� _v_ ), true observation _y_[†] , and the joint distribution ρ _h_ . We apply a neural operator F(·; θ) : R _[d][v]_ × R _[d][y]_ × R _[d][y]_ × P(R _[d][b]_ × R _[d][y]_ ) → R _[d][v]_ × R _[d][y]_ to define the correction terms as 

**==> picture [294 x 15] intentionally omitted <==**

� � � � where ρ _h_ = Law[�] ( _v_ , _h_ ( _v_ ))[�] is the joint distribution of ( _v_ , _h_ ( _v_ )). As well as being defined in the mean-field limit, this form of the model can both be learned and deployed through interacting particle system approximations, just as for the original ensemble Kalman filter. These interacting particle systems, as well as details of the architecture employed for F in the particle approximation, are defined in Section 4. 

**Remark 4** (Factoring Our Γ) **.** _We note that K_ θ (2.21b) _depends on the probability measure_ ρ _while_ F (2.24) _depends on_ ρ _h. The relationship between_ ρ _and_ ρ _h is given by_ 

**==> picture [314 x 44] intentionally omitted <==**

_By factoring out the noise covariance in the term_ ( _K_ θ[(2)][+Γ][)][−][1] _[ in]_[ (2.22)] _[, we use the explicit knowledge of]_[ Γ] _[ in derivation] of K_ θ _. Therefore,_ F _uses the input_ ρ _h which does not depend on_ Γ. 

**Remark 5** (Beyond Gaussian Assumptions) **.** _The mean-field map_ B _MNM_ (2.21a) _is constrained to be a_ ffi _ne in both inputs_ � _v and_ � _y. Indeed,_ 

**==> picture [141 x 16] intentionally omitted <==**

8 

_We note that this is the same constraint satisfied by the ensemble Kalman filter; see [48]. However, as shown in [48], the gain K in the ensemble Kalman filter is such that the resulting state estimate has law with first and secondorder moments matching a Gaussian approximation of the true filter. Our approach is more general. Indeed, since K_ θ _is trainable, unlike in the EnKF, the gain is not constrained to satisfy any moment-matching with a Gaussian approximation of the true filter. The ensemble Kalman filter possesses statistical guarantees for problems involving filtering distributions that are close to Gaussian (given, for example, by dynamics and observation operators that are close to linear) [51]. Further work will involve investigating whether this more general methodology possesses theoretical guarantees for a broader class of filtering problems than the EnKF._ 

The core of our proposed approach is to learn a neural operator F, as given in (2.24), which takes both probability measures, as well as vectors, as inputs. Section 3 is a self-contained description of a novel methodology for training neural operators that take probability measures as inputs; it leverages the attention mechanism [38]. In Section 4 we will build on this novel neural operator framework to provide a concrete methodology for enhanced data assimilation when actioned using interacting particle approximations of the mean-field limit. 

## **3. Learning Maps on the Space of Probability Measures** 

In this section we introduce a general framework to define neural network architectures acting on the space of probability measures. Let Ω1, Ω2 denote two sets, equipped with sigma algebras so that we may assign probabilities, and consider maps of the form F : P(Ω1) × Θ →P(Ω2); here Θ ⊆ R _[p]_ . Our goal is to define the parametric class of functions so that, by choice of θ[∗] ∈ Θ, we may approximate a given map F[†] : P(Ω1) →P(Ω2) by F(·; θ[∗] ) : P(Ω1) →P(Ω2). As the desired size of the approximation error shrinks we will typically require Θ, and in particular the number of parameters _p_ , to grow. Such methodology is now well-established for maps between Banach spaces; see the review [50]. Defining such maps between metric spaces in general, and probability spaces in particular, is an unexplored research question which we address here. We refer to neural networks on the space of probability measures as _measure neural mappings_ (MNM). 

In what follows, we show that the popular transformer architecture may be formulated as a mean-field mapping on the space of probability measures; this mapping is mean-field because it not only acts on but is also parametrized by probability measures. We call such a neural network architecture the _transformer measure neural mapping_ (TMNM). This architecture will serve as a parametric family of operators of the form F : P(R _[d][u]_ ) ×P(R _[d][w]_ ) × Θ →P(R _[d][v]_ ) defined via action on µ ∈P(R _[d][u]_ ) and ν ∈P(R _[d][w]_ ) as 

**==> picture [282 x 11] intentionally omitted <==**

The transport map in (3.1) is a mapping of the form F : R _[d][u]_ × P(R _[d][w]_ ) × Θ → R _[d][v]_ . For ease of exposition we will henceforth omit the θ parameterizations of the operators. In Section 4 we will show how this transformer measure neural mapping, in particular the transport map that defines it, may be used to implement (2.24) in the context of learning an ensemble-based data assimilation algorithm. For this section, however, we work quite generally, without specific reference to data assimilation. 

**Remark 6** (Training a Transformer MNM) **.** _In practice, implementing MNM architectures such as that in_ (3.1) _involves working with samples from the measures_ µ ∈P(R _[d][u]_ ) _and_ ν ∈P(R _[d][w]_ ) _rather than the measures themselves. This finite sample approximation introduces the challenge of selecting an appropriate loss function that is readily computed from samples. For the purposes of this article, we will employ a loss function based on matching the mean of the output measure under the map. Future work will optimize based on the use of metrics on probability measures and scoring rules, not just the mean; see Section 4 for more details._ 

_In what follows we assume access to samples u_ ( _i_ ) ∼ µ _for i_ = 1, . . . , _N and similarly w_ ( _j_ ) ∼ ν _for j_ = 1, . . . , _M. We note the following useful identity, which follows from_ (3.1) _(dropping explicit_ θ− _dependence):_ 

**==> picture [302 x 29] intentionally omitted <==**

_This characterization will be used to describe implementable algorithms._ 

9 

In view of Remark 6 we proceed by describing the TMNM architecture in detail as a mapping between spaces of probability measures. This mean-field perspective is more general and justifies the deployment of MNM architectures trained with a finite collection of samples to ensembles of different sizes. Nonetheless, in the development that follows, we provide examples illustrating the finite sample empirical setting such as in Remark 6, which will be the focus of later sections. 

We proceed in Subsection 3.1 by describing the TMNM architecture as a composition of specific maps on probability measures, which we call attention blocks and which involve the application of the attention map. In Subsection 3.2 we define attention as a map on measures and show how, via application of this map to empirical measures, it is possible to recover the formulation of attention on Euclidean spaces from [38]. 

## _3.1. Transformer Measure Neural Mapping_ 

The TMNM architecture as an operator of the form F : P(R _[d][u]_ ) × P(R _[d][w]_ ) →P(R _[d][u]_ ) consists of a composition of _Ne_ ∈ N number of operators S _w_ : P(R _[d][w]_ ) →P(R _[d][w]_ ), _Nd_ ∈ N number of operators S _u_ : P(R _[d][u]_ ) →P(R _[d][u]_ ), and C : P(R _[d][u]_ ) × P(R _[d][w]_ ) →P(R _[d][u]_ ), which we call the self-attention and cross-attention blocks, respectively. We define F via action on inputs µ ∈P(R _[d][u]_ ) and ν ∈P(R _[d][w]_ ) as 

**==> picture [397 x 10] intentionally omitted <==**

For ease of exposition, for operators S we will henceforth drop the notation S•, as the dimension of the input state space will be clear from context. We note that the cross-attention block is intimately related to the pooling multihead attention block from the set transformer architecture [52]. In Remark 7 and in Section 4 we make explicit the connection between the TMNM and the set transformer. Both operators S and C will be defined via a pushforward operation under a transport map C: we define 

**==> picture [273 x 27] intentionally omitted <==**

We now outline the construction of the transport map appearing in (3.4a) and (3.4b). Indeed, we may write the map C : R _[d][u]_ × P(R _[d][w]_ ) → R _[d][u]_ acting on the inputs _u_ ∈ R _[d][u]_ and π ∈P(R _[d][w]_ ) as the composition of the maps 

**==> picture [279 x 28] intentionally omitted <==**

We note that each of the maps appearing in the composition in (3.5) may be used to define a pushforward operator on measures. 

**Remark 7** (Set Transformer Architecture) **.** _We note that the composition in_ (3.3) _is a generalization of the set transformer architecture from [52] to the continuum. Indeed, the set transformer acts on a collection of vectors_ { _u_ (1), . . . , _u_ ( _N_ )} ⊂ R _[d][u] which we may assume to be drawn from an underlying reference measure_ µ _. The set transformer relies on learning a vector w_ ∈ R _[d][w] with which cross-attention is applied to the ensemble. The set transformer architecture may thus be viewed as the map_ F _in_ (3.3) _when acting on the empirical measure_ µ _[N]_ = _N_[1] � _iN_ =1[δ] _[u]_[(] _[i]_[)] _[and a] learned dirac_ δ _w._ 

We will now turn our focus to defining each of the maps in (3.5). The map F[LN] : R _[d][u]_ → R _[d][u]_ defines layer normalization and is such that 

**==> picture [312 x 27] intentionally omitted <==**

for _k_ = 1, . . . , _du_ , any _u_ ∈ R _[d][u]_ , where the subscript notation (•) _k_ is used to denote the _k_ ’th entry of the vector. In equation (3.6), ε ∈ R[+] is a fixed parameter, γ _k_ , β _k_ ∈ R are learnable parameters and _m_ , σ are defined as 

**==> picture [336 x 29] intentionally omitted <==**

10 

for any _u_ ∈ R _[d][u]_ . The operator F[NN] : R _[d][u]_ → R _[d][u]_ is defined such that 

**==> picture [326 x 12] intentionally omitted <==**

for any _u_ ∈ R _[d][u]_ , where _W_ 1, _W_ 2 ∈ R _[d][u]_[×] _[d][u]_ and _b_ 1, _b_ 2 ∈ R _[d][u]_ are learnable parameters and where _f_ is a nonlinear activation function. 

The map A : R _[d][u]_ ×P(R _[d][w]_ ) → R _[d][u]_ is the attention map: Subsection 3.2 which follows is dedicated to its formulation as a transport defining the attention map on measures A. 

## _3.2. Attention as a Map on Measures_ 

We present the definition of the attention operator as a map between a product of the spaces of probability measures P(R _[d][u]_ ) and P(R _[d][w]_ ) into another space of probability measures P(R _[d][v]_ )[1] . If considering the map as acting on measures defined on the unbounded domain R _[d][w]_ we must make assumptions on the input measures themselves, i.e., tail decay assumptions, so that the attention operator is well-defined. Hence, for ease of exposition we first present attention as an operator A : P(Ω _u_ ) × P(Ω _w_ ) →P(R _[d][v]_ ), where Ω _u_ , Ω _w_ are bounded open subsets of R _[d][u]_ , R _[d][w]_ respectively; we will then extend the definition to the general case A : P(R _[d][u]_ ) × Pδ(R _[d][w]_ ) →P(R _[d][v]_ ), where the subset of measures Pδ(R _[d][w]_ ) ⊂P(R _[d][w]_ ) consisting of all probability measures whose tails decay strictly faster than exponential, will be appropriately defined. 

**Definition 3** (Attention on Measures: Bounded State Space) **.** _We define the operator_ A : P(Ω _u_ ) × P(Ω _w_ ) →P(R _[d][v]_ ) _via its action on inputs_ (µ, ν) ∈P(Ω _u_ ) × P(Ω _w_ ) _as a pushforward of the first input measure_ µ ∈P(Ω _u_ ) _by a transport map_ A : Ω _u_ × P(Ω _w_ ) → R _[d][v] which is parametrized by the second input measure_ ν ∈P(Ω _w_ ) _, hence_ 

**==> picture [271 x 11] intentionally omitted <==**

_The transport map_ A : Ω _u_ × P(Ω _w_ ) → R _[d][v] takes as input a vector u_ ∈ Ω _u and a probability measure_ ν ∈P(Ω _w_ ) _and computes an expectation under a rescaling of the measure_ ν _, which is parametrized by u. Namely for_ ( _u_ , ν) ∈ Ω _u_ × P(Ω _w_ ) _it holds that_ 

**==> picture [280 x 10] intentionally omitted <==**

_where_ 

**==> picture [309 x 29] intentionally omitted <==**

Dimensions of the learnable matrices _Q_ , _K_ , _V_ are determined from the above, provided _Q_ , _K_ have the same output dimension, which is a free parameter to be specified. 

**Remark 8** ( _p_ (•; _u_ ) is a probability measure) **.** _Clearly, the normalization constant in_ (3.11) _is finite, as the integral is taken over_ Ω _w, a bounded domain. Furthermore p integrates to_ 1 _over_ Ω _w, hence it defines a probability measure._ 

In view of Remark 8, in order to extend the definition of the attention operator expressed in (3.9) to a map on probability measures defined on an unbounded domain, extra care is required to ensure the normalization constant in (3.11) is finite. Indeed, we must assume that the measure ν ∈P(R _[d][w]_ ) has sufficiently fast tail decay in order to compensate for the exponential growth in the integrand. To this end, we introduce the following subset of P(R _[d][w]_ ), on which the attention operator will be shown to be well-defined. Intuitively, the condition that defines the subset is satisfied by all measures whose tails decay faster than exponentially. 

**Definition 4** (Set of Measures with Exponential Tail Decay) **.** _For_ δ > 0 _we define_ Pδ(R _[d][u]_ ) ⊂P(R _[d][u]_ ) _as a set of measures satisfying the following exponential tail decay condition:_ 

**==> picture [256 x 15] intentionally omitted <==**

> 1In this self-contained subsection we use the notation _dv_ to denote the dimension associated with the output space of probability measures. This is not to be confused with the dimension of the state of the dynamical system (2.1) that is subject of the majority of the remainder of the paper. 

11 

Given Definition 4, we may now define the attention operator as a map on probability measures defined over unbounded state spaces. 

**Definition 5** (Attention on Measures: Unbounded State Space) **.** _We define the operator_ A : P(R _[d][u]_ ) × Pδ(R _[d][w]_ ) → P(R _[d][v]_ ) _via its action on inputs_ (µ, ν) ∈P(R _[d][u]_ ) × Pδ(R _[d][w]_ ) _as a pushforward of the first input measure_ µ ∈P(R _[d][u]_ ) _by a transport map_ A : R _[d][u]_ × Pδ(R _[d][w]_ ) → R _[d][v] which is parametrized by the second input measure_ ν ∈Pδ(R _[d][w]_ ) _, hence_ 

**==> picture [271 x 11] intentionally omitted <==**

_The transport map_ A : R _[d][u]_ × Pδ(R _[d][w]_ ) → R _[d][v] takes as input a vector u_ ∈ R _[d][u] and a probability measure_ ν ∈Pδ(R _[d][w]_ ) _and involves computation of an expectation under a rescaling of the measure_ ν _which is parametrized by u. Namely for_ ( _u_ , ν) ∈ R _[d][u]_ × Pδ(R _[d][w]_ ) _it holds that_ 

**==> picture [280 x 11] intentionally omitted <==**

_where_ 

**==> picture [310 x 28] intentionally omitted <==**

Definition 4 allows to state and prove the following lemma regarding the finiteness of the normalization constant appearing in (3.14). 

**Lemma 1.** _Let Q_ , _K_ , _V be fixed matrices of appropriate dimensions. The measure p_ ( _du_ ; _s_ ) _is a well-defined probability measure for_ ν ∈Pδ(R _[d][u]_ ) _. The measure p_ ( _dw_ ; _u_ , ν) _is a well-defined probability measure for_ ν ∈Pδ(R _[d][w]_ ) _._ 

_Proof._ It suffices to show �R _[dw]_[exp][�][⟨] _[Qu]_[,] _[ Kz]_[⟩][�][ν][(] _[dz]_[)][<][∞][.][Using][the][Cauchy–Schwarz][and][Young’s][inequalities][we] obtain that, 

**==> picture [379 x 27] intentionally omitted <==**

We note that 

**==> picture [379 x 140] intentionally omitted <==**

where _C_ ( _u_ ) is a constant depending on _u_ that changes from line to line, and where in the fourth line we used that the first integral is less than or equal to 1 and applied the substitution _t_ = exp[�] τ[1][+][δ] /(1 + δ)[�] to the second integral; furthermore, we used ν ∈Pδ(R _[d][w]_ ) for the final inequality. 

For implementable algorithms it is useful to consider the finite sample case, where we assume we have access to empirical approximations of the measures µ ∈P(R _[d][u]_ ) and ν ∈Pδ(R _[d][w]_ ) via a collection of samples, or ensembles, { _u_ (1), . . . , _u_ ( _N_ )} ⊂ R _[d][u]_ and { _w_ (1), . . . , _w_ ( _M_ )} ⊂ R _[d][w]_ . The following proposition provides a description of the attention operator when applied to empirical measures. The resulting expressions will be useful more generally to formulate the trainable algorithms we will use for data assimilation. 

12 

**Proposition 1** (Attention on Empirical Measures) **.** _Assume that, for_ µ ∈P(R _[d][u]_ ), ν ∈Pδ(R _[d][w]_ ) _, samples u_ (1), · · · , _u_ ( _N_ ) _are drawn i.i.d. from_ µ _and samples w_ (1), · · · , _w_ ( _M_ ) ∼ ν _are drawn i.i.d. from_ ν. _Then for_ µ _[N]_ = _N_ 1 � _Nj_ =1[δ] _[u]_[(] _[ j]_[)] _[and]_ ν _[M]_ = _M_[1] � _Mj_ =1[δ] _[w]_[(] _[j]_[)] _[it holds that]_ 

**==> picture [121 x 30] intentionally omitted <==**

_where_ 

**==> picture [328 x 28] intentionally omitted <==**

_Proof._ This follows by application of identity (3.2) to Definition 5. 

We note that the expression (3.17) corresponds to the definition of attention on discrete sequences as highlighted in [38]. 

## **4. Particle Approximation of Learned Mean-field Filters** 

In this section, we detail our proposed machine-learning-based DA method, the _measure neural mapping enhanced ensemble filter (MNMEF)_ , for the state estimation problem. In particular we build on the mean-field formulation introduced in Section 2, and in Subsection 2.5 in particular, by introducing an interacting particle system approximation. The resulting machine-learned ensemble approach is based on updating { _v_[(] _j[n]_[)][}] _n[N]_ =1[to][{] _[v]_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[through][the][following] steps: 

**==> picture [396 x 52] intentionally omitted <==**

After the prediction steps (4.1a) and (4.1b), we obtain a set of particles {(� _v_[(] _j[n]_ +[)] 1[,] _[ h]_[(][�] _[v]_[(] _j[n]_ +[)] 1[))][}] _n[N]_ =1[.][The computation of] _[ K]_[θ][is] elaborated through equations (2.22), (2.23), and (2.24) in a mean-field perspective, now extended to also include this � � particle setting. As in Section 2, we drop time index _j_ in what follows and recall that ρ _h_ = Law[�] ( _v_ , _h_ ( _v_ ))[�] is the joint distribution of (� _v_ , _h_ (� _v_ )) in the mean-field limit. In the particle case, under their implied empirical distribution, we have 

**==> picture [284 x 29] intentionally omitted <==**

and use this as an input measure to _K_ θ. The core idea is to train a parameterized neural operator F �� _v_ , _h_ (� _v_ ), _y_[†] , ρ _h_ ; θ� that outputs the correction terms used to compute _K_ θ. This can be done using the transformer measure neural mapping (TMNM) architecture F (3.3) introduced in Section 3. When applied to empirical measures such as (4.2), this TMNM scheme is equivalent to the set transformer architecture [52] acting on sequences, as outlined in Remark 7. In this section, which is concerned with implementation, we will work with the formulation of the scheme on sequences; we will also show that the resulting scheme is invariant to permutation of the elements of the sequence. To distinguish the resulting operator on sequences to the one acting on measures from Section 3, we will employ the notation F[ST] opposed to F; see (4.18) for the definition of F[ST] . Due to the permutation invariance property of the set transformer, we can treat the input as an unordered set: we define the corresponding operator acting on finite sets using the notation _F_[ST] ; see (4.25). 

The parameters θ learned in _K_ θ implicitly depend on _N_ , the number of ensemble members used in training. However, the relation between the set transformer and its mean-field limit from Section 3 allows us to deploy the model parameters θ, trained using an ensemble size _N_ , to an ensemble of a different sizes _N_[′] . This is because the _N_ and _N_[′] systems may both be thought of as approximating the same mean-field limit. Similarly to the standard use of the EnKF, our learning framework also incorporates techniques such as inflation and localization to enhance the performance of the filter [6] as ensemble sizes vary. We view this as a fine-tuning: fixing the majority of the 

13 

parameters in θ as ensemble sizes vary, but allowing a small subset of parameters—including those related to inflation and localization—to vary with ensemble size. 

We present the complete implementation details of our method in the following subsections. In Subsection 4.1, we review the set transformer architecture. In Subsection 4.2, we present our architecture that learns a parameterized gain matrix, generalizing the EnKF formulation, and enhanced by use of adaptively learned inflation and localization parameters. Subsection 4.3 explains the loss function and training process. In Subsection 4.4, we describe how to efficiently fine-tune our method to allow for ensemble size dependent inflation and localization. In Appendix A we provide a comprehensive summary of our learning framework with detailed pseudo-code algorithms. 

Note that all aspects are based on a discrete setting, where our approach evolves an ensemble of particles, as in the EnKF. Consequently, all measure-related operations are transformed into computations based on the empirical measure, or equivalently, the ensemble, viewed as a set of points in state space. When the time-step subscript is omitted, this indicates that the analysis applies to any time step _j_ . 

## _4.1. The Set Transformer_ 

� In this section, we review the set transformer architecture [52] used to process ensembles {( _v_[(] _[n]_[)] )} _n[N]_ =1[or][ {][(] _[h]_[(][�] _[v]_[(] _[n]_[)][))][}] _n[N]_ =1 into fixed-dimensional feature vectors. While Section 3 introduced the set transformer from a measure-theoretic perspective, we now consider our input as a sequence that, due to the architecture’s design, can be treated either as a set or an empirical measure. 

For two sequences _u_ ∈U([ _N_ ]; R _[d][u]_ ) and _w_ ∈U([ _M_ ]; R _[d][w]_ ), we provide the definition for the sequence-based attention mechanism, which is given by 

**==> picture [326 x 28] intentionally omitted <==**

We recall that this is equivalent to the formulation (3.17) in Proposition 1 obtained by applying the measure theoretic definition of attention to empirical measures. Defining the set of sequences of finite length in R _[d]_ by, 

**==> picture [290 x 12] intentionally omitted <==**

we can define an attention operator A[ST] (where the superscript ST indicates it is used in the set transformer architecture) as a sequence-to-sequence operator, analogous to the attention A acting on measures (3.9):[2] 

**==> picture [313 x 12] intentionally omitted <==**

In view of (4.3), the output sequence length is the same as the length of the first input. Specifically, for _u_ ∈U([ _N_ ]; R _[d][u]_ ) and _w_ ∈U([ _M_ ]; R _[d][w]_ ), 

**==> picture [310 x 12] intentionally omitted <==**

The learnable parameters in A[ST] are denoted by 

**==> picture [271 x 11] intentionally omitted <==**

In the context of practical implementations, A[ST] is commonly instantiated as a multihead attention mechanism, which allows the model to jointly attend to information from different representation subspaces [38]. The detailed formulation of multihead attention is presented in Appendix B. 

The set transformer architecture is composed of several key building blocks [52]. The fundamental computation unit is the Cross-Attention Block (CAB) given in the following definition. 

**Definition 6** (CAB for Sequences) **.** _The Cross-Attention Block (CAB)_ C _[ST] is an operator that maps two sequences into one sequence:_ 

**==> picture [318 x 12] intentionally omitted <==**

> 2As in Section 3, here _dv_ does not necessarily refer to the state space dimension in the dynamical system; the exposition in this subsection is quite general, defining the set transformer and linking it to the MNM in Section 3. 

14 

_For u_ ∈U([ _N_ ]; R _[d][u]_ ) _and w_ ∈U([ _M_ ]; R _[d][w]_ ) _,_ C _[ST] is defined as_ 

**==> picture [326 x 29] intentionally omitted <==**

_Here_ A _[ST] is the sequence-to-sequence attention_ (4.5) _;_ F _[LN] denotes application of the layer normalization operator_ F _[LN]_ (3.6) _, elementwise in the sequence;_ F _[NN] denotes application of the feedforward operator_ F _[NN]_ (3.8) _, also elementwise in the sequence. The_ + _operator acting on sequences is interpreted as adding elements with the same index, i.e.,_ 

**==> picture [281 x 10] intentionally omitted <==**

_The trainable parameters in_ C _[ST] include the parameters from_ F _[LN]_ 1 _[,]_[ F] _[LN]_ 2 _[,]_[ F] _[NN][, and]_[ A] _[ST][, i.e.,]_ 

**==> picture [322 x 13] intentionally omitted <==**

_where the layer normalization layers_ F _[LN]_ 1[,][ F] _[LN]_ 2 _have trainable parameters according to_ (3.6)(3.7) _, the feedforward layer_ F _[NN] has trainable parameters according to_ (3.8) _, and the attention layer_ A _[ST] has trainable parameters according to_ (4.7) _. We note that practically the cross-attention block on sequences is the multi-head attention block from [38, 52] and may be viewed as the sequence-to-sequence analog of the cross-attention block_ C _on measures from_ (3.4b) _._ 

The set transformer architecture is composed of several self-attention blocks (SAB) (Definition 7) and a pooling by multi-head attention block (PMA) (Definition 8), which are defined in the following using CAB. 

**Definition 7** (SAB) **.** _The self-attention block (SAB)_ S _[ST] , also called the set attention block [52], maps a sequence to another sequence with the same length and dimension, so that_ 

**==> picture [294 x 12] intentionally omitted <==**

_The application of_ S _[ST] is calculated by setting both inputs of_ C _[ST] to be the same, i.e.,_ 

_Here, the trainable parameters satisfy_ 

**==> picture [272 x 46] intentionally omitted <==**

_See_ (3.4a) _for the measure theoretic analog_ S _._ 

**Definition 8** (PMA) **.** _The pooling by multi-head attention block (PMA)_ C _[ST]_ ( _s_ , •) _is defined by replacing the first input in the CAB_ C _[ST]_ (•, •) _by a trainable parameter s, called the seed. The seed s_ ∈U([ _Ns_ ], R _[d][s]_ ) _is a sequence, where Ns and ds are fixed hyperparameters. Therefore_ C _[ST]_ ( _s_ , •) _maps a sequence of any finite length to a sequence with fixed length,_ 

**==> picture [312 x 11] intentionally omitted <==**

_The trainable parameters in PMA are the parameters in the CAB and the seed s,_ 

**==> picture [288 x 12] intentionally omitted <==**

_See Remark 7 for the measure theoretic analog_ C( _s_ , •) _._ 

The set transformer maps a sequence of any finite length to a fixed-dimensional feature vector: 

**==> picture [280 x 12] intentionally omitted <==**

To fully specify the detailed architecture of F[ST] , we will utilize two multilayer perceptrons (3.8) F[NN] in : R _[d][u]_ → R _[d]_[latent] , and F[NN] out[:][R] _[N][s]_[×] _[d][s]_[→][R] _[d]_[ST][(that][act][elementwise][on][sequences),][and][a][parameter-free][concatenation][layer][F][Cat][:] U([ _Ns_ ], R _[d][s]_ ) → R _[N][s]_[×] _[d][s]_ that concatenates all elements in a sequence into a vector. 

15 

For a sequence _u_ ∈U([ _N_ ]; R _[d][u]_ ), the set transformer is hence given by: 

**==> picture [350 x 12] intentionally omitted <==**

**==> picture [353 x 30] intentionally omitted <==**

The subscripts ℓ ∈ [ _N_ e + _N_ d] emphasize that the trainable parameters of these SABs are different. Integer _N_ e is the number of SABs, S[ST] ℓ[, ℓ][=][1][,][ 2][, . . . ,] _[ N]_[e][,][in][the][encoder][F][Enc][,][while] _[N]_[d][is][the][number][of][SABs,][S][ST] ℓ[, ℓ][=][1][ +] _[ N]_[e][,][ 2][ +] _N_ e, . . . , _N_ d + _N_ e, in the decoder F[Dec] . Specifically, we have 

**==> picture [400 x 29] intentionally omitted <==**

Further practical details about our set transformer architecture, including the dimensions of latent features and the choices of layers, are provided in Appendix C.1. 

The trainable parameters in F[ST] are given by: 

**==> picture [351 x 30] intentionally omitted <==**

The set transformer architecture exhibits two key properties when processing an input sequence, namely, the permutation invariance (Proposition 2) and adaptation to variable input lengths (Proposition 3). These two propositions are proved in [52] under a slightly different setting: in the original work a length- _N_ sequence in R _[d]_ is represented as an _N_ × _d_ matrix, whereas here it is a mapping _u_ ∈U([ _N_ ], R _[d]_ ). 

**Proposition 2** (Permutation Invariance) **.** _A permutation_ σ _is a bijective function from_ [ _N_ ] _to_ [ _N_ ] _. We extend the definition of_ σ _to sequences in u_ ∈U([ _N_ ], R _[d][u]_ ) _so that_ 

**==> picture [293 x 10] intentionally omitted <==**

_Then for any permutation_ σ : [ _N_ ] �→ [ _N_ ] _and any input sequence u_ ∈U([ _N_ ], R _[d][u]_ ) _, we have_ 

**==> picture [273 x 11] intentionally omitted <==**

**Proposition 3** (Adaptation to Variable Input Length) **.** _A set transformer architecture with fixed parameters takes input sequences with di_ ff _erent lengths while the output dimension is fixed:_ 

**==> picture [327 x 11] intentionally omitted <==**

Based on these two properties, we can bridge the sequence input and the probability measure input for the set transformer architecture. The permutation invariance property (Proposition 2) enables us to abstract away from the sequential nature of the input and treat it as an unordered set. More fundamentally, this allows us to interpret the input as an empirical distribution, where each element in the sequence represents a sample from some underlying distribution. Furthermore, Proposition 3 demonstrates that we can accommodate varying input lengths without architectural modifications, effectively allowing us to adjust the number of samples in the empirical distribution. Together, these properties (Propositions 2 and 3) provide theoretical foundation for analysis of the main components of the set transformer in the context of probability measures (Section 3). 

**Remark 9** (Common Notation for Operations on Measures and on Sequences) **.** _In this section, much of the notation coincides with that in Section 3. This is because the underlying definitions are almost identical, with the key distinction being that in Section 3 the operators act on probability measures, whereas in this section they act on sequences. The preceding developments in this subsection explain the connection. For example, in Section 3,_ S _and_ C _denote the measure-based self-attention_ (3.4a) _and cross-attention_ (3.4b) _blocks, while in this section,_ S _[ST] and_ C _[ST] represent the sequence-based self-attention_ (4.13) _(Definition 7) and cross-attention_ (4.9) _(Definition 6) blocks, respectively. In addition,_ F _refers to the transformer measure neural mapping_ (3.3) _in Section 3 while_ F _[ST] refers to the set transformer_ (4.18) _acting on sequences._ 

16 

## _4.2. Our Architecture_ 

In this section we provide a detailed description the architecture in our proposed learnable DA method, MNMEF. The core of our approach is to learn a parameterized gain matrix (Subsection 4.2.1), generalizing how the classical EnKF utilizes a Gaussian-inspired gain. Additionally, to enhance performance, we incorporate inflation and localization techniques (Subsections 4.2.2 and 4.2.3), akin to their role in EnKF. 

In our architecture, we use a set transformer (Subsection 4.1) to process the ensemble {(� _v_[(] _[n]_[)] , _h_ (� _v_[(] _[n]_[)] ))} _n[N]_ =1[into][a] fixed-dimensional feature vector. We define the set of finite subsets in R _[d]_ by, 

**==> picture [343 x 12] intentionally omitted <==**

Because of the permutation invariance property (Proposition 2), we may reinterpret the set transformer F[ST] as a map _F_[ST] that acts on sets rather than sequences: _F_[ST] : F (R _[d][v]_ × R _[d][y]_ ) → R _[d]_[ST] , given by 

**==> picture [312 x 16] intentionally omitted <==**

The feature vector _fv_ can be viewed as a representation of the empirical distribution ρ[(] _h[N]_[)] given in (4.2) and similarly as an approximate summary of ρ _h_ . This representation is subsequently utilized to learn the gain matrix, inflation, and the localization. 

**Remark 10** (Choice of _d_ ST) **.** _By Proposition 3, F_[ST] _outputs a fixed dimension dST regardless of ensemble size N. Therefore, we do not need to adjust dST based on N. Larger dST values o_ ff _er more expressiveness, but increase computational cost. Our tests with the Lorenz ’96 model (Subsection 5.2) using dST_ = 32, 64, 128 _showed only marginal improvements with increasing dST, thus we selected dST_ = 64 _for all experiments._ 

## _4.2.1. Learning the Gain Matrix_ 

From the analysis step (4.1c) and the proposed form (2.22), we have the following form for the learnable analysis step: 

**==> picture [286 x 36] intentionally omitted <==**

Recall that, in the mean-field limit, we impose an inductive bias on our architecture by defining _K_ θ[(1)] and _K_ θ[(2)] in the{ _h_ (� _v_ form[(] _[n]_[)] )} _n[N]_ =(2.23),1[, respectively.] allowing[The empirical version of (2.23), used in the practical implementation, takes the form] for a learned correction through (2.24). Recall that _m_ � and[�] _h_ are the mean of {� _v_[(] _[n]_[)] } _n[N]_ =1[and] 

**==> picture [339 x 64] intentionally omitted <==**

wherevation � _yw_[†][(] θ, and the ensemble _[n]_[)] and � _z_[(] θ _[n]_[)] are trainable correction terms that depend on the state {(� _v_[(] _[n]_[)] , _h_ (� _v_[(] _[n]_[)] ))} _n[N]_ =1[.] � _v_[(] _[n]_[)] , the observation _h_ (� _v_[(] _[n]_[)] ), the true obserThe correction terms are defined by a neural operator F as in (2.24) for the mean-field perspective presented in Section 2. In our practical implementation, we replace the dependence on ρ _h_ in F by the ensemble {(� _v_[(][ℓ][)] , _h_ (� _v_[(][ℓ][)] ))}ℓ _[N]_ =1 and use the set transformer _F_[ST] (4.25) to process the ensemble into a feature vector _fv_ . Recall that this can be viewed as using the empirical approximation ρ[(] _h[N]_[)] ≈ ρ _h_ given by (4.2). 

To learn the correction terms for each particle, we then train a neural network _F_[gain] : R _[d][v]_ × R _[d][y]_ × R _[d][y]_ × R _[d]_[ST] → R _[d][v]_ × R _[d][y]_ with the standard multilayer perceptron (MLP) architecture that takes the feature vector for the ensemble as an input: 

**==> picture [319 x 29] intentionally omitted <==**

where θgain denotes trainable parameters. 

From (4.27a) and (4.27b), it is evident that if the correction terms satisfy � _w_[(] θ _[n]_[)] = � _z_[(] θ _[n]_[)] = 0, the formulation reduces to the EnKF (2.16). When the dynamics and observation models are linear, or in other words, when the filtering distribution of the states _v_ is Gaussian, the Kalman filter achieves optimality [7, 8, 48]. Therefore, the motivation for our proposed scheme (2.22) lies in its optimality in the linear (or Gaussian) setting, while further aiming to improve the performance of the Kalman filter in nonlinear problems by learning the correction terms. 

**Remark 11** (On the Invertibility in the Gain Computation) **.** _The matrix K_ θ[(2)] _[, defined in]_[ (4.27b)] _[ as an average of outer] products, is positive semi-definite. Since_ Γ _is a fixed positive definite matrix, the sum K_ θ[(2)] + Γ _is also positive definite and thus invertible. Crucially, the minimum eigenvalue of K_ θ[(2)] + Γ _is bounded from below by the minimum eigenvalue of_ Γ _, which is a positive constant independent of any trainable parameters. This property ensures the numerical stability of computing_ ( _K_ θ[(2)] + Γ)[−][1] _during backpropagation._ 

**Remark 12** (Correction Approach Versus End-to-end Gain Learning) **.** _In addition to the proposed approach with correction terms, we have implemented the end-to-end learning of the operator_ B _presented in Subsection 2.4 and learning the Kalman gain K_ θ _directly without any constraint on its form. We find that the end-to-end approach or directly learning K_ θ _results in unstable and slower learning. A poorly initialized or an unconstrained K_ θ _leads to substantial divergence of the resulting filtered trajectory away from the ground truth trajectory. The EnKF-like structure in_ (4.26b) _with learnable correction terms provides better stability while maintaining adaptability to nonlinear dynamics._ 

## _4.2.2. Learning the Inflation_ 

Inflation is a technique used to increase the ensemble spread, mitigating the underestimation of analysis covariance caused by sampling errors in ensemble-based methods. Finite ensemble sizes often lead to sampling errors in the forecast covariance, causing the filter to overly trust forecasts and risk filter divergence. Inflation helps maintain the response of the filter to observations by counteracting these effects. 

The most common form of inflation is multiplicative inflation, where the analysis ensemble { _v_[(] _[n]_[)] } _n[N]_ =1[that is calcu-] lated after the analysis step (4.1c) is modified as follows 

**==> picture [312 x 29] intentionally omitted <==**

where α ≥ 1 is the inflation parameter. In our learning framework, we replace the term proportional to (α − 1) by a learned correction term � _u_[(] _[n]_[)] 

θ[,] 

that is output by an MLP-based neural network _F_[infl] : R _[d][v]_ × R _[d]_[ST] → R _[d][v]_ given by 

**==> picture [281 x 14] intentionally omitted <==**

where _v_[(] _[n]_[)] is the estimated state given by (4.1c), and θinfl denotes trainable parameters. The learned inflation step is processed after the analysis step (4.1c), resulting in the particle update: 

**==> picture [268 x 14] intentionally omitted <==**

**Remark 13** (Dependence and Implications of the Learned Inflation Term) **.** _The common form of inflation is a function of the ensemble states, i.e., not the observations, inon the ensemble states_ � _v_[(] _[n]_[)] _and the feature vector fv_ (4.29) _, without information of the true observation y. Similarly, the learned inflation term_ � _u_[(] θ[†] _[n]_[)] _or the observationin_ (4.30) _depends noise covariance_ Γ _. We avoid the risk that the inflation term would evolve into an end-to-end correction term, ensuring the learning performed by other components in our framework remains meaningful and e_ ff _ective._ 

## _4.2.3. Learning the Localization_ 

In spatially extended systems, sampling errors can lead to inaccurate covariance estimation, particularly when the sample size is small. True correlations typically decay with distance, but spurious long-range correlations may 

18 

arise, distorting the covariance structure. Localization addresses this issue by suppressing artificial correlations while preserving meaningful local correlations. 

Localization is implemented by damping covariances in an empirical covariance matrix based on distance. This is typically achieved by applying a Hadamard product (elementwise product, denoted by ◦) between the empirical covariance matrix and a predefined localization weight matrix _L_ . For the dynamic model (2.1) with the state in _dv_ -dimensional space (i.e., _v_ ∈ R _[d][v]_ ), _L_ ∈ R _[d][v]_[×] _[d][v]_ is calculated by 

**==> picture [293 x 10] intentionally omitted <==**

where _g_ : R → R is a function that maps distance values to localization weights (e.g., the Gaspari–Cohn function [53]), and _Dk_ ℓ is the distance between index _k_ and ℓ. To incorporate the localization technique in the EnKF, the Kalman gain formula (2.11b) is modified as 

**==> picture [302 x 17] intentionally omitted <==**

where _L[vh]_ ∈ R _[d][v]_[×] _[d][y]_ and _L[hh]_ ∈ R _[d][v]_[×] _[d][y]_ are localization weight matrices corresponding to _C_[�] _[vh]_ and _C_[�] _[hh]_ , respectively. 

In our learning-based formulation of localization we proceed as follows: we incorporate localization into our parameterized Kalman gain by modifying (4.26b) to take the form 

**==> picture [307 x 18] intentionally omitted <==**

The localization weight matrices _L_ θ[(1)] and _L_ θ[(2)] follow the structure in (4.32), where _g_ is replaced by a parameterized distance-to-weight function _g_ θ : R → R. 

In practice, it is not necessary to learn the entire function _g_ θ since we only have a finite number of different distances, defined by the spatial grid for discretized PDEs, and time indices in the setting of ODEs. We denote the unique distance values in { _Dk_ ℓ} _[d] k_ ,ℓ _[v]_ =1[as][ {] _[D]_[1][,] _[ D]_[2][, . . . ,] _[ D][N][D]_[}][, where] _[ N][D]_[ is the number of distinct distances. Given a vector] � � � � _g_ = [ _g_ 1, _g_ 2, . . . , _gND_ ] ∈ R _[N][D]_ , we can define the function _g_ θ by 

**==> picture [284 x 10] intentionally omitted <==**

We employ a MLP-based neural network _F_[loc] : R _[d]_[ST] → R _[N][D]_ given by: 

**==> picture [268 x 12] intentionally omitted <==**

The parameterized localization weight matrices _L_ θ[(1)][and] _[ L]_ θ[(2)][are calculated based on the output of this learned function] _g_ θ. In Appendix C.2, we provide a step-by-step example illustrating the computation of the parameterized localization weight matrices. 

**Remark 14** (Implementation Insights for Learning Localization Weights) **.** _Here we provide more details for the learning process of the localization weight matrices and make some comments on our proposed approach._ 

- _The final layer of F_[loc] _is a_ softmax _function scaled by 2, ensuring all outputs lie within the interval_ [0, 2] _. Although amplifying underestimated covariances is typically the responsibility of inflation alone, our architecture jointly performs localization and inflation. Thus, we allow the weights to range in_ [0, 2] _rather than_ [0, 1] _to grant additional flexibility in the localization component._ 

- _Instead of learning a continuous parametric form for g_ θ _, we learn its values only at discrete distances_ { _Di_ } _i[N]_ = _[D]_ 1 _[.] This reduces model complexity while preserving localization expressivity._ 

- _While EnKF-based localization methods typically use fixed weight matrices across time steps (e.g., using the Gaspari–Cohn function [53]), there is much interest in adaptive approaches [54]. Our learning-based approach adapts these matrices for each time step j using neural networks via its dependence on the ensemble. As shown in_ (4.36) _(time index j omitted for simplicity), the network processes time-step-specific inputs, allowing the localization scheme to dynamically adjust based on the current system state._ 

19 

**Remark 15** (On sharing the distance-to-weight function across _L_ θ[(1)] and _L_ θ[(2)][)] **[.]** _[In][forthcoming][experiments][in][this] paper, the observation operator h subsamples state components, so the distances between observation indices are induced by the same state-space metric used for state indices. Accordingly, we learn a single distance-to-weight function g_ θ _and use it consistently to build L_ θ[(1)] _and L_ θ[(2)] _[.][For][more][general][h][(e.g.,][nonlinear][or][indirect][observa-] tions), one may instead learn two distinct functions, g_[(1)] θ _and g_[(2)] θ _[,][tailored][to][state–observation][pairs][for][L]_ θ[(1)] _and observation–observation pairs for L_ θ[(2)] _[, respectively.]_ 

## _4.3. Loss Function_ 

This section outlines the procedure for training the neural network parameters, including the gain, inflation and localization (Subsection 4.2). Based on the stochastic dynamic model (2.1) and the data observation model (2.2), we make the follow assumption for the training: 

**Data Assumption 1.** _Our training is conducted for fixed dynamics_ Ψ _, observation operator h, and noise covariance matrices_ Σ _and_ Γ _. The time step_ ∆ _t is also fixed (and incorporated in_ Ψ _). The initial condition is a Gaussian with a fixed covariance C_ 0 _, i.e. v_ 0 ∼ N(•, _C_ 0) _. For some M_ , _J_ ∈ N _, the training data consists of M trajectories of length J_ + 1 _, extracted from a single long trajectory generated by propagating the dynamic model_ (2.1) _for M_ ( _J_ + 1) _steps. Each sub-trajectory_ { _v_[†] _j_[}] _[J] j_ =0 _[has corresponding observations]_[ {] _[y]_[†] _j_[}] _[J] j_ =1 _[generated according to]_[ (2.2)] _[.]_ 

For each trajectory, we generate estimated states from our ensemble-based data assimilation model to compare with the true states from the dynamic model, enabling us to train the parameters θST, θgain, θinfl, and θloc, for the set transformer _F_[ST] (4.25), and MLPs _F_[gain] (4.28), _F_[infl] (4.30) and _F_[loc] (4.36) respectively. 

We initialize an ensemble { _v_[(] 0 _[n]_[)][}] _n[N]_ =1[at][the][initial][time][step] _[j]_[=][0][for][each][sub-trajectory,][with][members][sampled] i.i.d. from a Gaussian distribution with the mean _v_[(] 0 _[n]_[)][and the covariance] _[ C]_[0][:] 

**==> picture [298 x 14] intentionally omitted <==**

For _j_ = 0, 1, . . . , _J_ − 1 and trainable parameters θ = {θST, θgain, θinfl, θloc}, we update the ensemble { _v_[(] _j[n]_[)][(][θ][)][}] _n[N]_ =1[to] { _v_[(] _j[n]_ +[)] 1[(][θ][)][}] _n[N]_ =1[according to] 

**==> picture [336 x 52] intentionally omitted <==**

where ( _K_ θ) _j_ +1 is our learned parameterized gain matrix, including localization, and � _u_[(] θ _[n]_[)][is the inflation term according] to Subsection 4.2. For all parameters θ we choose _v_[(] 0 _[n]_[)][(][θ][)][=] _[v]_[(] 0 _[n]_[)][.][The ensembles][ {] _[v]_[(] _j[n]_[)][(][θ][)][}] _n[N]_ =1[depend on the trainable] parameters θ for _j_ = 1, 2, . . . , _J_ . 

In this paper we focus on state estimation, given by the mean of the estimated ensemble { _v_[(] _j[n]_[)][(][θ][)][}] _n[N]_ =1[, i.e.,] 

**==> picture [276 x 29] intentionally omitted <==**

To train our neural network parameters effectively, we introduce a loss function that quantifies the discrepancy between the estimated states and the true states across the _m_ -th sub-trajectory _Vm_ = { _v_[†] _j_[}] _[J] j_ =1[, given by:] 

**==> picture [292 x 33] intentionally omitted <==**

which measures the relative accuracy of our ensemble mean predictions compared to the true trajectory. Our loss (4.40) is a relative squared _L_ 2 loss, which is preferred over the standard _L_ 2 loss for two main reasons. First, using the squared _L_ 2 norm avoids computing square roots, which can lead to numerical instabilities when calculating gradients, 

20 

especially when the error approaches zero. Second, normalizing by the true state magnitude (∥ _v_[†] _j_[∥] 2[2][)][makes][the][loss] scale-invariant across different state variables and trajectory segments, ensuring balanced parameter updates regardless of the absolute magnitudes of the state components. This relative formulation is particularly important in dynamical systems where state variables may span different orders of magnitude. 

In the training process, the loss is averaged across _M_ training trajectories indexed by _m_ ∈ [ _M_ ], 

**==> picture [286 x 27] intentionally omitted <==**

The trainable parameter θ is optimized based on the above-defined loss L[ _M_ ]. In practice, the loss L[ _M_ ] is approximated by a mini-batch as a subset of [ _M_ ]. 

**Remark 16** (Gradient Truncation in Sequential Learning) **.** _Computing the loss_ (4.40) _requires evaluating ensemble estimates_ {{ _v_[(] _j[n]_[)][(][θ][)][}] _n[N]_ =1[}] _[J] j_ =1 _[across][the][entire][trajectory.][For][the][ensemble][at][step][j,][this][involves][nested][evaluations] of K_ θ _up to j times. These nested evaluation arise from the sequential nature of the trajectory, where each step depends on the computing of the Kalman gain from the previous steps, requiring backpropagation through the entire computational history. With large trajectory lengths J, this causes slow training and numerical instability since it is nearly equivalent to training a very deep neural network._ 

_To address this issue, we introduce a gradient-detach hyperparameter J_ 0 ∈ N _. This hyperparameter limits the gradient computation for the loss related to time step j to only the steps j_ , _j_ − 1, . . . , _j_ − _J_ 0 + 1 _. This approach assumes that the trajectory at time step j is not significantly a_ ff _ected by parameter changes in the Kalman gain for earlier time steps, which is reasonable given the diminishing influence of distant past states in many dynamical systems. This technique significantly improves training speed and stability._ 

**Remark 17** (Training Targets and Probabilistic Losses) **.** _In the loss_ (4.40) _, the ground-truth states used for supervised training are obtained by simulating the known dynamical model (forward integration of_ Ψ _with prescribed noise model). Thus, the availability of training data hinges on access to an explicit and tractable dynamic model. In highdimensional settings where such a model is unavailable or impractical, a surrogate simulator (e.g., a reduced-order or data-driven one) can be used to synthesize training trajectories and observations. Furthermore, while the proposed loss_ (4.40) _focuses on state estimation, a promising direction for future work is to adopt probabilistic loss functions that target the full filtering distribution_ P( _v j_ | _Y j_ ) _rather than only the mean-based point estimator; see Subsection 1.1._ 

## _4.4. Fine-Tuning Inflation_ & _Localization_ 

Following the developments in Subsection 4.2, we may apply a set transformer (4.25) to process ensembles of any size into fixed-dimensional feature vectors. This allows for pretraining our MNMEF with ensemble size _N_ and perform inference with _N_[′] � _N_ . However in classical EnKF formulations, hyperparameters such as inflation and localization depend on the ensemble size, and allowing for this dependence significantly enhances performance. Thus, we consider fine-tuning a subset of the parameters for inference at ensemble size _N_[′] � _N_ . We now detail this methodology. 

The architecture defined in Subsection 4.2 is based on trainable parameters θST, for the set transformer _F_[ST] (4.25), and θgain, θinfl, and θloc for the MLPs _F_[gain] (4.28), _F_[infl] (4.30) and _F_[loc] (4.36) respectively. For efficient fine-tuning when transitioning from ensemble size _N_ to _N_[′] , we freeze θST and only fine-tune θgain, θinfl, and θloc. This specific choice of fine-tuning is effective because: (1) freezing θST significantly reduces computational costs, as the set transformer contains the majority of network parameters; (2) the remaining parameters, though small in number, measurably improve performance when they are adapted to the ensemble size. 

The training loss for the _m_ -th sub-trajectory _Vm_ = { _v_[†] _j_[}] _[J] j_ =1[is defined by (4.39), (4.40):] 

**==> picture [327 x 33] intentionally omitted <==**

where we add the superscript _N_ to emphasize dependence on the ensemble size. In pretraining with size _N_ we solve 

**==> picture [351 x 21] intentionally omitted <==**

21 

During fine-tuning for size _N_[′] � _N_ , using the same training trajectories we solve 

**==> picture [339 x 21] intentionally omitted <==**

with fixed θST[(] _[N]_[)][.][In practice, we use small mini-batches of [] _[M]_[] to estimate the losses in (4.43) and (4.44).] With the updated parameters, we proceed with ensemble size _N_[′] using: 

**==> picture [381 x 72] intentionally omitted <==**

Although θST[(] _[N]_[)][remains unchanged after the fine-tuning, the feature vector] _[f]_[ (] _v[N]_[′][)] differs from the pretraining features _fv_ since the input ensemble size changes from _N_ to _N_[′] . 

**Remark 18** (Efficient Training Strategy) **.** _While the per-particle update in the analysis step has linear complexity with respect to the ensemble size N for fixed gain matrix, the overall cost of one forward pass is dominated by the attention operations used to compute correction terms. These attention blocks scale quadratically in N. In practice, we adopt an e_ ffi _cient training strategy by pretraining on smaller ensemble sizes N and applying fine-tuning for larger ensembles N_[′] > _N, which maintains comparable performance while substantially reducing computational cost. Further improvements are possible by employing localized or linear-attention variants that can reduce the scaling in N._ 

In Subsection 5.8, we demonstrate this fine-tuning method’s effectiveness, achieving comparable performance to full parameter fine-tuning with significantly improved efficiency. 

## **5. Numerical Experiments** 

In this section we present numerical experiments to demonstrate the improved numerical benefit of our proposed method, MNMEF, in comparison with leading existing ensemble methods; the experiments also serve to validate the effectiveness of several specific details within our approach. First, in Subsections 5.2, 5.3, and 5.4, we compare our method with several classical approaches across several nonlinear dynamical systems – Lorenz ’96, Kuramoto– Sivashinsky, and Lorenz ’63. In Subsection 5.5, we compare the computational time between our MNMEF and other benchmarks. In Subsection 5.6, we show the robustness of our method to the inherent randomness in test trajectories. In Subsection 5.7, we conduct experiments to study the learning-based inflation and localization methods proposed in Subsections 4.2.2 and 4.2.3. Subsequently, in Subsection 5.8, we perform experiments to illustrate the efficiency and effectiveness of our proposed fine-tuning method, introduced in Subsection 4.4. The code for our method is publicly available[3] and can be used to reproduce all of our experiments. 

We reiterate that all reported experiments are for nonlinear problems. Our methodology is based on learning corrections to the Kalman filter structure inherent in the EnKF. For nonlinear problems there is bias in the EnKF which can be effectively learned and corrected for, and this is the essence of our approach. For linear problems there is no bias in the mean-field limit (although there will still be a bias with a finite ensemble [55]), so our methodology would attempt to fit neural networks to what is largely noise. Without any regularization or early stopping, this can lead to filter divergence for large enough training epochs. Appendix C.6 reports a linear–Gaussian experiment to illustrate this. 

> 3 `https://github.com/wispcarey/DALearning` 

22 

## _5.1. Experimental Set-Up_ 

In the following three Subsections 5.2, 5.3, and 5.4, we compare our method against several benchmark approaches: 

1. **Localized EnKF Perturbed Observation (EnKF)** [9, 10]: This is the classic implementation of EnKF that employs a stochastic update approach, where the observations are perturbed by adding random noise samples drawn from the observation noise distribution. 

2. **Ensemble Square Root Filter (ESRF)** [11, 56]: This method is a deterministic variant of the EnKF. It directly transforms the ensemble using matrix square root operations to match the second order statistics of the EnKF, but without requiring stochastic perturbations. 

3. **Local Ensemble Transform Kalman Filter (LETKF)** [15]: This method builds upon the Ensemble Transform Kalman Filter (ETKF) [57] by incorporating spatial localization. ETKF is also a deterministic version of EnKF. Under linear–Gaussian assumptions and in the mean-field limit, ESRF and ETKF are theoretically equivalent, but they differ in practical implementation. 

4. **Iterative Ensemble Kalman Filter (IEnKF)** [16]: This method enhances the EnKF (perturbed observation) by incorporating a variational scheme to better handle strongly nonlinear systems. It iteratively solves a minimization problem between adjacent time steps, progressively refining the solution for the analysis step through multiple iterations. In our experiments, we set the maximum number of iterations to 10 and use a convergence tolerance of 10[−][5] . 

**Remark 19.** _Inflation and localization are important for DA in high-dimensional systems. In our experiments, all benchmark filters (EnKF, ESRF, LETKF, and IEnKF) employ post–analysis inflation as in_ (4.29) _. For the higherdimensional Lorenz–96 (Subsection 5.2) and Kuramoto–Sivashinsky (Subsection 5.3) systems, we apply localization to the_ _**EnKF** and_ _**LETKF** . We employ the Gaspari–Cohn (GC) function [53] as the distance-to-weight function for the localization according to the DAPPER package [58]. We do_ not _localize ESRF or IEnKF for the following reasons:_ 

_1. LETKF can be viewed as ETKF with localization, and ETKF is theoretically equivalent to ESRF in the meanfield_ / _linear–Gaussian regime; adding localization to ESRF would thus be essentially redundant with LETKF._ 

_2. For IEnKF, a localized implementation is omitted because it requires multiple iterations with the dynamic model integrations at each step, making a joint grid search over inflation and localization computationally prohibitive for Lorenz ’96 and KS, and because without careful radius tuning the method exhibited numerical instability (frequent NaNs due to filter divergence)._ 

_The hyperparameters for inflation and localization are optimized separately for each ensemble size via grid search; detailed settings and results are reported in Appendix C.5._ 

In addition to the methods described above, we evaluate our MNMEF approach at various ensemble sizes. Unless otherwise specified, our MNMEF is pretrained with ensemble size _N_ = 10 as described in Subsection 4.3. We then examine our model’s performance across different ensemble sizes _N_ ∈{5, 10, 15, 20, 40, 60, 100} to demonstrate the generalizability of our approach. 

Our evaluation includes two variants of our method: 

1. **Pretrained MNMEF** : Trained once at _N_ = 10 for 1000 epochs and applied directly to all ensemble sizes, demonstrating transfer capability across different ensemble configurations. This appears as **‘Pretrain’** in our figures. 

2. **Fine-tuned MNMEF** : Fine tune the pretrained model specific to each target ensemble size for 20 epochs, as detailed in Subsection 4.4. This appears as **‘Tuned’** in our figures. 

The intermediate feature dimensions in the set transformer for different dynamic models are provided in Appendix C.1. The detailed intiail conditions for different dynamic models are provided in Appendix C.3. The training hyperparameters including trajectory lengths, learning rates and batch sizes, are provided in Appendix C.4. 

23 

For a fair comparison, all benchmark methods (EnKF, LETKF, and IEnKF) are tuned by RMSE with respect to the true state _v_[†][Specifically, hyperparameters for inflation and localization are selected via comprehensive grid searches] _j_[.] at multiple ensemble sizes to minimize true-state RMSE. The explored parameter spaces and heatmaps of the grid searches are reported in Appendix C.5. This approach ensures that all benchmark methods achieve close to their optimal performance; the benchmarks thus present a robust test of our proposed methodology. Notably, we performed hyperparameter selection for the benchmarks directly on their test set performance, without using a validation set, which only strengthens the benchmark methods’ advantage in our comparisons. 

The performance of the methods is evaluated using the difference between the estimated state (i.e., the mean of particles) and the ground truth state over the entire trajectory. In the continuous-time setting, let **v**[†] ( _t_ ) : [0, _T_ ] → R _[d][v]_ denote the ground truth trajectory between time 0 and _T_ , and let **v** ( _t_ ) : [0, _T_ ] → R _[d][v]_ denote the estimated state trajectory. Let ∥· ∥2 denote the Euclidean norm in R _[d][v]_ . Then, the performance can be evaluated using the relative _L_[1] := _L_[1] ([0, _T_ ]; R _[d][v]_ ) error: 

**==> picture [324 x 34] intentionally omitted <==**

In the discrete-time setting, we interpret the discrete time index _j_ as time _t j_ = _j_ ∆ _t_ , where ∆ _t_ = _T_ / _J_ is the time step size. The estimated trajectory is given by the sequence _V_[(] _[N]_[)] = { _v_[(] _j[N]_[)][}] _[J] j_ =1[where] _v_ ~~[(]~~ _j[N]_[)] = _N_[1] � _nN_ =1 _[v]_[(] _j[n]_[)][, and the ground] truth trajectory is given by _V_[†] = { _v_[†] _j_[}] _[J] j_ =1[.][The relative discrete] _[ L]_[1][ error can then be defined as] 

**==> picture [357 x 33] intentionally omitted <==**

This error metric can be interpreted as a form of relative root-mean-square error (RMSE). At each time step _j_ , the quantity ∥ _v j_ − _v_[†] _j_[∥][2][ corresponds to the root-mean-square error over the] _[ d][v]_[-dimensional state vector.][The overall metric] thus represents a time-averaged spatial RMSE, normalized by the magnitude of the ground truth trajectory. In what follows, we refer to this error E( _V_[(] _[N]_[)] , _V_[†] ) as the relative RMSE (R-RMSE). For _M_ test trajectories { _Vm_[†][}] _m[M]_ =[test] 1[and their corresponding estimated trajectories][ {] _[V] m_[(] _[N]_[)][}] _m[M]_ =[test] 1[,][the averaged R-RMSE] E is given by: 

**==> picture [286 x 30] intentionally omitted <==**

In the experiments presented in the remainder of this section, we adopt the averaged R-RMSE E as the primary evaluation metric, allowing us to ameliorate the effect of randomness inherent in each individual run and providing a more reliable assessment of the overall performance of different methods. Unless otherwise specified, the number of test trajectories is fixed at _M_ test = 64. 

To further highlight the advantages of our method, we consider the relative improvement in terms of R-RMSE ERI defined as: 

**==> picture [283 x 25] intentionally omitted <==**

This metric quantifies the percentage reduction in R-RMSE achieved by our method compared to the benchmark method. When E _RI_ < 0, our method performs worse than the benchmark. 

We apply the following general hyperparameter setting in all of our experiments unless otherwise specified. The dynamic operator Ψ in Equation (2.1) is obtained by solving a differential equation using the fourth-order Runge– Kutta (RK4) [59] method. The time step ∆ _t_ denotes the interval between consecutive observations. For accurate numerical integration of the dynamics, we perform multiple RK4 steps within each interval ∆ _t_ , utilizing an integration step size smaller than ∆ _t_ . The dynamic noise ξ ∼N(0, Σ) is typically set at Σ = σ[2] _v[I]_[ where] _[ I]_[ is the identity matrix and] σ _v_ = 10[−][3] or 0. For the observation noise, η ∼N(0, Γ), we define its covariance matrix as Γ = σ[2] _y[I]_[, where we set][ σ] _[y]_ to either 0.7 or 1.0. 

24 

## _5.2. Lorenz ’96_ 

The Lorenz ’96 model is a widely-used set of ordinary differential equations that possess features of large-scale atmospheric dynamics [60]. The model takes the form of a damped-driven linear system, with additional energy conserving quadratic nonlinearity that induces cyclic interactions (waves) among the components of the system; this makes it particularly valuable for studying atmospheric predictability. The system dynamics are governed by the following equations: 

**==> picture [330 x 22] intentionally omitted <==**

The parameter settings for the Lorenz ’96 system are shown in Table 1. The forcing parameter _F_ = 8 places the Lorenz ’96 system in a chaotic regime when _d_ = 40. 

Table 1: Lorenz ’96 System Settings 

|**Category**|**Values**||
|---|---|---|
|Parameters|_F_ =8||
|States|_v_=(_u_1,_u_2, . . . ,_u_40)∈R_d_,<br>_d_ =40||
|Observations|_h_(_v_)=(_u_1,_u_5,· · · ,_u_33,_u_37)∈R_d_obs,|_d_obs =10|
|Time Step|Observation time step: ∆_t_=0.15; 5|RK4 integration steps: ∆_t_/5=0.03|



**==> picture [451 x 228] intentionally omitted <==**

**----- Start of picture text -----**<br>
NaN NaN<br>1.2 1.2<br>Relative 0.9 0.9<br>RMSE<br>0.6<br>0.6<br>0.3<br>0.3<br>5 101520 40 60 100 5 101520 40 60 100<br>80% 70%<br>70% 60%<br>60%<br>50%<br>Relative 50% 40%<br>Improvement 40% 30%<br>30%<br>20% 20%<br>10% 10%<br>0% 0%<br>5 101520 40 60 100 5 101520 40 60 100<br>Ensemble Size Ensemble Size<br>Lorenz ’96<br>σ y = 0.7 σ y = 1.0<br>Pretrain [*] Tuned [*] EnKF ESRF LETKF IEnKF<br>**----- End of picture text -----**<br>


Figure 1: Comparison results on the Lorenz ’96 system. The upper row of plots shows direct R-RMSE comparisons between different methods, while the lower row illustrates the relative improvement of our fine-tuning method compared to benchmarks. These comparisons are presented for observation noise levels σ _y_ = 0.7 (left column) and σ _y_ = 1.0 (right column). Our proposed MNMEF method is highlighted in the legends with bold font and an asterisk (e.g. **Pretrain**[∗] ). In summary, our fine-tuned MNMEF model consistently outperforms benchmarks, showing substantial improvements for small ensembles and a 15-20% advantage over LETKF at larger ensemble sizes (eg. 60, 100). 

In Figure 1, we compare the performance of our pretrained MNMEF and fine-tuned MNMEF against four benchmark methods: EnKF, ESRF, LETKF, and IEnKF, on the Lorenz ’96 system. The upper row of plots in Figure 1 displays the R-RMSE (5.3) for observation noise levels σ _y_ = 0.7 (left plot) and σ _y_ = 1.0 (right plot). The lower row of plots in Figure 1 shows the relative improvement ERI (5.4) of our fine-tuned method as compared to EnKF, IEnKF, and LETKF for these respective noise levels. 

25 

**==> picture [450 x 201] intentionally omitted <==**

**----- Start of picture text -----**<br>
Observe every 4th<br>Ground dimension; σ y = 1.0<br>Truth −−−−−−−−−−−−−−−−−−−−→<br>(a) States (b) Observations<br>MNMEF<br>(ours)<br>N = 10<br>LETKF<br>[15]<br>N = 10<br>(c) States (mean) (d) Abs Error (e) Spread (std)<br>10 5 0 5 10 15<br>**----- End of picture text -----**<br>


Figure 2: Visualization of one test trajectory (time steps 1401-1500, ∆ _t_ = 0.15) for Lorenz ’96 states (vertical axis) over time (horizontal axis)with the observation noise σ _y_ = 1.0. Panel (a): Ground-truth states (unknown). Panel (b): Observations (known, every 4th dimension observed). Rows 2-3 show our method MNMEF pretrained on _N_ = 10, and the benchmark LETKF with the ensemble size _N_ = 10. Panel (c): state estimation (ensemble mean), Panel (d): absolute error of mean with respect to the ground truth, and Panel (e): ensemble spread (standard deviation). 

**==> picture [448 x 146] intentionally omitted <==**

**----- Start of picture text -----**<br>
MNMEF<br>(ours)<br>N = 10<br>LETKF<br>[15]<br>N = 10<br>(a) Dimension 1 (Observed) (b) Dimension 2 (Not Observed)<br>True Trajectory Ensemble Mean 95% Confidence Interval<br>**----- End of picture text -----**<br>


Figure 3: Visualization of two dimensions (index 1 and 2) in one test trajectory (time steps 1401-1500, ∆ _t_ = 0.15) for Lorenz ’96 state values (vertical axis) over time (horizontal axis) with the ensemble size _N_ = 10 and the observation noise σ _y_ = 1.0. Panel (a): Dimension 1, observed. Panel (b): Dimension 2, not observed. The first row is our method MNMEF, pretrained on _N_ = 10, and the second row is the benchmark LETKF. The 95% confidence intervals shown in figures are calculated as the ensemble mean ± 1.96 × the ensemble standard deviation. In summary, MNMEF performs significantly better on the unobserved dimension and comparably to LETKF on the observed dimension; meanwhile, MNMEF maintains an appropriate spread without suffering from filter degeneracy. 

We observe that our fine-tuned model consistently outperforms all benchmarks. Indeed, our fine-tuned method achieves substantial improvement for small ensemble sizes and maintains a notable advantage at larger ensemble sizes, outperforming LETKF by approximately 15–20%. Our pretrained model, trained with _N_ = 10 ensembles also behaves competitively, but performs slightly worse than LETKF for large ensemble size 40, 60, 100. 

To further illustrate the performance differences between our MNMEF and the best-performance benchmark LETKF, we provide visualizations in Figure 2 and Figure 3 for _N_ = 10 and σ _y_ = 1.0. The visualization is on the last 100 time steps (from 1401 to 1500) from a test trajectory of length 1500 and ∆ _t_ = 0.15. In both figures, our MNMEF approach is the one pretrained with the ensemble size _N_ = 10. 

Figure 2 presents a comparison of the estimated state trajectory. Panel (a) shows the ground truth, and panel (b) shows the sparse observations. The subsequent rows compare MNMEF and LETKF. Visually, MNMEF displays smaller magnitudes for the absolute error (panel (d)). In addition, the ensemble spread (panel (e)) for MNMEF is more consistent than LETKF. Figure 3 focuses on the estimation of two specific dimensions: one observed (Dimension 1, 

26 

panel (a)) and one unobserved (Dimension 2, panel (b)). For the observed dimension, both MNMEF and LETKF perform comparably well, with their ensemble means closely following the ground truth. However, for the unobserved dimension, MNMEF demonstrates a clear advantage in state estimation. Furthermore, MNMEF maintains an appropriate ensemble spread while avoiding filter degeneracy. 

## _5.3. Kuramoto–Sivashinsky_ 

The Kuramoto—Sivashinsky (KS) equation [61, 62] is a widely studied nonlinear partial differential equation that describes the evolution of instabilities in spatially extended systems, capturing complex spatiotemporal chaotic dynamics arising in flame fronts, thin fluid films, and reaction-diffusion systems. Due to its chaotic behavior and sensitivity to initial conditions, the KS equation serves as a valuable testbed for developing and evaluating data assimilation algorithms. With the periodicity in space imposed to identity _x_ = _L_ and _x_ = 0, the one-dimensional KS equation for _u_ : [0, _L_ ] × R[+] → R takes the form 

**==> picture [334 x 23] intentionally omitted <==**

**==> picture [266 x 9] intentionally omitted <==**

Table 2: Kuramoto-–Sivashinsky (KS) System Settings 

|**Category**|**Values**|
|---|---|
|Parameters|_L_=32π|
|States|_xj_ = _jL_/128,<br>_j_=0,1, . . . ,127<br>_v_=�_u_(_x_0),_u_(_x_1), . . . ,_u_(_x_127<br>�)∈R_d_,<br>_d_ =128|
|Observations|_h_(_v_)= �_u_(_x_0),_u_(_x_8),· · · ,_u_(_x_120)�∈R_d_obs,<br>_d_obs =16|
|Time Step|Observation time step: ∆_t_=1; 4 ETDRK4 integration steps: ∆_t_/4=0.25|



The detailed experimental settings and parameters for the KS system are summarized in Table 2. Numerically, the KS equation (5.6) is discretized spatially using a Fourier pseudo-spectral method to handle periodic boundary conditions effectively. Time integration is performed with the exponential time-differencing fourth-order Runge–Kutta (ETDRK4) scheme [63], which advances the stiff linear operator analytically and is therefore not subject to the explicit linear Courant–Friedrichs–Lewy (CFL) restriction (∆ _t_ ≤ _C_ ∆ _x_[4] ) that would apply to fully explicit RK methods; the time step is chosen based on accuracy and nonlinear resolution rather than linear stability. 

In Figure 4, we compare the performance of our pretrained model and fine-tuned model against four benchmark methods: EnKF, ESRF, LETKF, and IEnKF, for the KS system with σ _y_ = 0.7 and 1.0, and provide the relative improvement of our fine-tuned method as compared to EnKF, IEnKF, and LETKF. 

The comparison between our pretrained MNMEF and fine-tuned MNMEF methods and the benchmark methods, for the KS dynamical system, slightly differs from what we observed under the Lorenz ’96 dynamics. In the KS setting, fine-tuning provides minimal additional benefit, with both our pretrained and fine-tuned MNMEF models performing nearly identically. Both variants significantly outperform benchmark methods across all ensemble sizes. The advantage is particularly pronounced at smaller ensemble sizes. Even at the largest ensemble size ( _N_ = 100), both our pretrained and fine-tuned methods still maintain approximately 20% improvement over LETKF, the benchmark method with the best performance. 

Similarly to the Lorenz ’96 discussion in Subsection 5.2, we provide visualizations in Figure 2 and Figure 3 for _N_ = 10 and σ _y_ = 1.0 to further illustrate the performance differences between our MNMEF and the best-performance benchmark LETKF on the KS system. The visualization is on the last 100 time steps (from 1901 to 2000) of a test trajectory with length 2000 and ∆ _t_ = 1. In both figures, our MNMEF is the one pretrained with the ensemble size _N_ = 10. 

Figure 5 presents a comparison of the estimated state trajectory. Figure 6 visualizes the estimation of two specific dimensions: one observed (Dimension 1, panel (a)) and one unobserved (Dimension 2, panel (b)). In summary, our 

27 

**==> picture [452 x 230] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.6 NaN<br>NaN<br>1.2<br>1.2<br>Relative<br>RMSE<br>0.8 0.8<br>0.4<br>5 101520 40 60 100 5 101520 40 60 100<br>60%<br>50%<br>50%<br>40%<br>40%<br>Relative 30%<br>Improvement 30%<br>20%<br>20%<br>10% 10%<br>0% 0%<br>5 101520 40 60 100 5 101520 40 60 100<br>Kuramoto– Ensemble Size Ensemble Size<br>Sivashinsky σ y = 0.7 σ y = 1.0<br>Pretrain [*] Tuned [*] EnKF ESRF LETKF IEnKF<br>**----- End of picture text -----**<br>


Figure 4: Comparison results on the Kuramoto—Sivashinsky (KS) system. The upper row of plots shows direct R-RMSE comparisons between different methods, while the lower row illustrates the relative improvement of our fine-tuning method compared to benchmarks. These comparisons are presented for observation noise levels σ _y_ = 0.7 (left column) and σ _y_ = 1.0 (right column). Our proposed MNMEF method is highlighted in the legends with bold font and an asterisk (e.g. **Pretrain**[∗] ). In summary, our fine-tuned MNMEF model consistently outperforms benchmarks, showing substantial improvements for small ensembles and around 20% advantage over LETKF at larger sizes (eg. 60, 100). 

**==> picture [450 x 202] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Observe every 8th<br>Truth dimension; σ y = 1.0<br>−−−−−−−−−−−−−−−−−−−−→<br>(a) States (b) Observations<br>MNMEF<br>(ours)<br>N = 10<br>LETKF<br>[15]<br>N = 10<br>(c) States (mean) (d) Abs Error (e) Spread (std)<br>6 4 2 0 2 4 6<br>**----- End of picture text -----**<br>


Figure 5: Visualization of one test trajectory (time steps 1901-2000, ∆ _t_ = 1) for Kuramoto–Sivashinshy (KS) states (vertical axis) over time (horizontal axis) with the observation noise σ _y_ = 1.0. Panel (a): Ground-truth states (unknown). Panel (b): Observations (known, every 8th dimension observed). Rows 2-3 show our method MNMEF pretrained on _N_ = 10, and the benchmark LETKF with the ensemble size _N_ = 10. Panel (c): state estimation (ensemble mean), Panel (d): absolute error with ground truth, and Panel (e): ensemble spread (standard deviation). 

MNMEF performs slightly better than LETKF on both the observed and the unobserved dimensions, which is verified by the R-RMSE quantitative comparison in Figure 4. MNMEF maintains an appropriate ensemble spread, similarly to the LETKF. 

**Remark 20** (Implementation of Localization) **.** _It is worth noting that methods other than LETKF could potentially accommodate localization techniques. For example, LETKF is essentially the ESRF combined with localization._ 

28 

**==> picture [448 x 145] intentionally omitted <==**

**----- Start of picture text -----**<br>
MNMEF<br>(ours)<br>N = 10<br>LETKF<br>[15]<br>N = 10<br>(a) Dimension 1 (Observed) (b) Dimension 2 (Not Observed)<br>True Trajectory Ensemble Mean 95% Confidence Interval<br>**----- End of picture text -----**<br>


Figure 6: Visualization of two dimensions (index 1 and 2) in one test trajectory (time steps 1901-2000, ∆ _t_ = 1) for Kuramoto–Sivashinshy (KS) state values (vertical axis) over time (horizontal axis) with the ensemble size _N_ = 10 and the observation noise σ _y_ = 1.0. Panel (a): Dimension 1, observed. Panel (b): Dimension 2, not observed. The first row is our method MNMEF, pretrained on _N_ = 10, and the second row is the benchmark LETKF. The 95% confidence intervals shown in figures are calculated as the ensemble mean ± 1.96 × the ensemble standard deviation. In summary, MNMEF performs slightly better on both the observed and the unobserved dimensions; meanwhile, MNMEF maintains an appropriate spread without suffering from filter degeneracy. 

_However, since our implementation is based on the DAPPER package, which only implements localization for LETKF, we do not consider localization for the other four methods. Our results on Lorenz ’96 and KS problems su_ ffi _ciently demonstrate the advantages of our approach over other methods, even without localization. For larger ensemble sizes (e.g., N_ = 60, 100 _), where the benefits of localization diminish, our method still significantly outperforms the alternatives, like IEnKF._ 

## _5.4. Lorenz ’63_ 

The Lorenz ’63 system is a simplified mathematical model for atmospheric convection [64], proposed prior to the Lorenz ’96 model discussed in Subsection 5.2. It represents a highly simplified version of atmospheric dynamics with only three dimensions, described by the following set of ordinary differential equations: 

**==> picture [270 x 71] intentionally omitted <==**

Table 3: Lorenz ’63 System Settings 

|**Category**|**Values**||
|---|---|---|
|Parameters|σ=10,<br>ρ=28,|β= 8<br>3|
|States|_v_=(_x_,_y_,_z_)∈R_d_,|_d_ =3|
|Observations|_h_(_v_)= _x_∈R_d_obs,|_d_obs =1|
|Time Step|Observation time step: ∆_t_=0.15; 5 RK4 integration steps: ∆_t_/5=0.03||



The parameter settings for the Lorenz ’63 system are shown in Table 3. The three parameters σ, ρ, and β represent the Prandtl number, Rayleigh number, and geometric factor, respectively, chosen by Lorenz based on simplified thermal convection experiments to produce chaotic dynamics characterized by sensitivity to initial conditions. 

In Figure 7, we compare the R-RMSE (5.3) performance of our pretrained MNMEF and fine-tuned MNMEF models against benchmark methods EnKF, ESRF, and IEnKF for the Lorenz ’63 system. The upper row of plots in 

29 

**==> picture [451 x 230] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.08<br>0.04<br>Relative<br>RMSE<br>0.04<br>5 101520 40 60 100 5 101520 40 60 100<br>30%<br>30%<br>20%<br>20%<br>10%<br>Relative 10%<br>Improvement 0%<br>0%<br>10%<br>10%<br>20%<br>20%<br>5 101520 40 60 100 5 101520 40 60 100<br>Ensemble Size Ensemble Size<br>Lorenz ’63<br>σ y = 0.7 σ y = 1.0<br>Pretrain [*] Tuned [*] EnKF ESRF IEnKF<br>**----- End of picture text -----**<br>


Figure 7: Comparison results on the Lorenz ’63 system. The upper row of plots shows direct R-RMSE comparisons between different methods, while the lower row illustrates the relative improvement of our fine-tuning method compared to benchmarks. These comparisons are presented for observation noise levels σ _y_ = 0.7 (left column) and σ _y_ = 1.0 (right column). Our proposed MNMEF method is highlighted in the legends with bold font and an asterisk (e.g. **Pretrain**[∗] ). 

Figure 7 displays these R-RMSE comparisons for observation noise levels σ _y_ = 0.7 (left plot) and σ _y_ = 1.0 (right plot). The LETKF method is not included in this comparison since the system has only three dimensions, making localization unnecessary. For a fair comparison, we turn off the localization part in our architecture by setting all entries in the localization weight matrices to be 1. We only fine-tune the parameters θgain for _F_[gain] (4.28) and θinfl for _F_[infl] (4.30) for ensemble sizes _N_ � 10. The lower row of plots in Figure 7 shows the relative improvement ERI (5.4) of our fine-tuned MNMEF method as compared to EnKF and IEnKF, for the respective noise levels shown. 

We observe that the performance of different methods does not significantly change with increasing ensemble size. Our method consistently outperforms the EnKF and ESRF, but in the low-dimensional Lorenz ’63 problem, it is outperformed by the IEnKF. As noted in Remark 21, IEnKF demonstrates strong performance in low-dimensional, highly nonlinear problems while struggling in high-dimensional systems without localization. This is consistent with our findings in the higher-dimensional experiments in Subsections 5.2 and 5.3, where our method substantially outperforms IEnKF. Furthermore, the stability analysis in Subsection 5.6 demonstrates that our method exhibits higher stability (lower standard deviation across test trajectories) than IEnKF. 

**Remark 21** (IEnKF Dimensionality Challenges) **.** _The IEnKF [16] uses the same observational information as the standard EnKF, but reformulates the filtering problem as a lag-1 smoothing problem, and solves it iteratively to better handle nonlinearities. While the IEnKF demonstrates excellent performance in low-dimensional systems (e.g., the Lorenz ’63 model, d_ = 3 _), its e_ ff _ectiveness diminishes as dimensionality increases (e.g., the Lorenz ’96 model, d_ = 40 _). This deterioration occurs due to lack of localization in the implementation of the IEnKF we use; however, even with large ensembles with less need for localization, our method outperforms the IEnKF in the higher-dimensional systems. Moreover, IEnKF generally provides a substantial improvement over non-iterative methods only when the observations are su_ ffi _ciently dense, as shown in [16] using experiments with the Lorenz ’96 model._ 

## _5.5. Computational Cost_ 

In this subsection, we compare the run time per assimilation step (s/step) of MNMEF against benchmark methods (EnKF, ESRF, LETKF, and IEnKF) under matched CPU-only settings to ensure a fair comparison. 

For an ensemble of size _N_ , the per-step cost of MNMEF scales as O( _N_[2] ). The dominant terms are (i) the attention blocks in the set transformer, which entail pairwise interactions among _N_ members, and (ii) the computation of the 

30 

**==> picture [467 x 156] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 [0]<br>10 [0]<br>10 1<br>10 1<br>10 2<br>10 2<br>5 101520 40 60 100 5 101520 40 60 100<br>(a) Lorenz ’96, σ y = 0.7 (b) KS, σ y = 0.7<br>ESRF EnKF IEnKF LETKF MNMEF [*]  (CPU) MNMEF [*]  (GPU)<br>**----- End of picture text -----**<br>


Figure 8: Run time (s/analysis step), σ _y_ =0.7 only. All methods are timed on CPU (Intel(R) Core(TM) i9-14900KF). MNMEF is comparable in speed to EnKF and ESRF, and is slightly slower than EnKF because MNMEF additionally computes the correction terms. MNMEF remains much faster than LETKF and IEnKF. For MNMEF, we additionally report GPU timing on a single GPU (RTX 4080 Super), shown as the blue curve. The GPU version shows very stable runtime across these ensemble sizes due to efficient parallelization. 

learned Kalman gain _K_ θ and its gradients, implemented via batched linear solves with _N_ × _N_ systems. We do not form matrix inverses explicitly. While classical baselines admit textbook complexities, their practical scaling depends on solver details, localization, and parallelization, so a full theoretical comparison is beyond the scope of this paper. 

To reflect practical efficiency, we conduct a CPU-only head-to-head timing in a single Python environment. All CPU timings are run on Intel(R) Core(TM) i9-14900KF. We follow implementations in DAPPER [58] and provide our own CPU-based implementations of EnKF, ESRF, LETKF, and IEnKF. We deliberately avoid GPU ports for these baselines because methods such as LETKF and IEnKF do not map cleanly to efficient, large-batch vectorization on current accelerators. 

We evaluate on Lorenz ’96 and KS with the same configurations as in Subsections 5.2 and 5.3. For each ensemble size _N_ and observation noise level σ _y_ = 0.7, we report the mean of the per-step run time (s/analysis step), averaged over trajectories and time steps. We do not distinguish the pretrained and fine-tuned variants of our MNMEF since they share the same architecture. The set-transformer parameter counts follow Table 5. Results are visualized in Figure 8. MNMEF is comparable in speed to EnKF and ESRF, and is slightly slower than EnKF because MNMEF additionally computes the correction terms. MNMEF remains much faster than LETKF and IEnKF. 

For MNMEF, we provide an additional GPU-based run time in Figure 8, since its original implementation is designed for GPU. MNMEF’s additional GPU timings are obtained on a single NVIDIA RTX 4080 Super. The GPU version of MNMEF shows very stable runtime across these ensemble sizes due to efficient parallelization. 

## _5.6. Robustness To Inherent Randomness_ 

Due to the inherent randomness in both the filtering problem and the algorithm, the same method may exhibit varying performance across different test trajectories. To mitigate this randomness and obtain a more reliable assessment of each method’s effectiveness, we evaluate their performance on _M_ test trajectories and report the mean R-RMSE E (5.3). While the mean R-RMSE provides a measure of overall accuracy, we are interested in the stability of each method across different trajectories. To quantify this stability, we compute the standard deviation (std) of the R-RMSE values across all test trajectories { _Vm_[†][}] _m[M]_ =[test] 1[and their corresponding estimated trajectories][ {] _[V][m]_[}] _m[M]_ =[test] 1[, defined as:] 

**==> picture [304 x 36] intentionally omitted <==**

A smaller σE indicates better stability of the method. Therefore, in this section, we consider methods with lower std values to be more stable and thus preferable. 

**Remark 22.** _In ensemble-based data assimilation, variance- or standard-deviation–type quantities are commonly used to characterize ensemble spread [6]. In our work, the spread is visualized in Figs. 3 and 6 via the shaded bands:_ 

31 

_the 95% confidence interval is provided as the ensemble mean_ ±1.96× _ensemble standard deviation. Our focus here is state estimation rather than full uncertainty calibration, so we do not present a quantitative comparison of spread metrics. Note that the stability measure_ σE _in_ (5.8) _serves a di_ ff _erent purpose: it assesses the consistency of estimation errors across test trajectories, not the dispersion of ensemble members._ 

In Table 4, we show the std of different methods on the dataset Lorenz ’96, KS and Lorenz ’63 with the observation noise σ _y_ = 1.0, 0.7. The std values in the table is the averaged std over the ensemble sizes _N_ = 5, 10, 15, 20, 40, 60, 100. Based on Table 4, we observe that our pretrained MNMEF and fine-tuned MNMEF demonstrate comparable standard deviation values, both of which are significantly lower than all benchmark methods. This indicates that our approaches maintain more consistent performance across different test trajectories. The enhanced stability suggests that our methods are more reliable in practical applications. 

Table 4: Standard deviation (std) of the relative root mean square error (R-RMSE) as defined in (5.8). We consider both **Pretrain*** and **Tuned*** variants of our MNMEF method. The std shown in the table is an averaged std over ensemble sizes _N_ = 5, 10, 15, 20, 40, 60, 100. A smaller std indicates better stability of the method. The lowest std in each column is highlighted in bold. The stds for both the pretrained and fine-tuned variants of our MNMEF method are similar and consistently lower than those of the benchmark methods, indicating greater robustness of our approach to the inherent randomness across different test trajectories. 

|Method|Lorenz ’96 (5.5)|KS (5.6)|Lorenz ’63 (5.7)|
|---|---|---|---|
||σ_y_ =1.0<br>σ_y_ =0.7|σ_y_ =1.0<br>σ_y_ =0.7|σ_y_ =1.0<br>σ_y_ =0.7|
|**Pretrain***<br>**Tuned***<br>EnKF [8]<br>ESRF [11]<br>LETKF [15]<br>IEnKF [16]|**1.03e-2**<br>1.26e-2<br>1.08e-2<br>**1.12e-2**<br>2.16e-2<br>3.10e-2<br>3.09e-2<br>1.95e-2<br>2.63e-2<br>6.13e-2<br>1.83e-2<br>2.61e-2|**8.60e-3**<br>1.07e-2<br>8.91e-3<br>**1.07e-2**<br>2.66e-2<br>3.15e-2<br>2.59e-2<br>3.27e-2<br>2.66e-2<br>3.58e-2<br>2.23e-2<br>3.03e-2|**1.78e-3**<br>1.40e-3<br>1.79e-3<br>**1.29e-3**<br>3.41e-3<br>2.32e-3<br>2.78e-3<br>2.01e-3<br>-<br>-<br>2.15e-3<br>1.44e-3|



## _5.7. Inflation and Localization_ 

In this section, we will conduct further experiments on learning the inflation (Subsection 4.2.2) and localization (Subsection 4.2.3) components in the architecture of our MNMEF method. These experiments demonstrate that what our method learns has many similarities with what is used in the application of inflation and localization techniques to the benchmark methods. 

## _5.7.1. Inflation Experiments_ 

In Subsection 4.2.2, we introduce our learning-based inflation scheme (4.31) which depends on the learned output � _u_[(] θ _[n]_[)] from the neural network _F_[infl] (4.30). 

We are particularly interested in quantifying the effect of our proposed inflation scheme on the overall performance of our method. Additionally, despite not providing the inflation term � _u_[(] θ _[n]_[)] with information about the true observation _y_[†] or observation noise Γ in _F_[infl] , � _u_[(] θ _[n]_[)] has significantly more degrees of freedom than classical inflation approaches. This raises concerns that � _u_[(] θ _[n]_[)] might exceed the scope of inflation: that it might not act merely as a correction term but might completely overwhelm the updates, thus rendering other parts of our architecture ineffective. We show that this is not the case, but at the same time we showcase the benefits of including this learned inflation-like correction. 

For our experimental approach, we first pretrain the models and then fine-tune them separately for various ensemble sizes. During inference, we deliberately disable the learned inflation by setting � _u_[(] θ _[n]_[)] = 0 and analyze the resulting change in the average R-RMSE E (5.3). We stress that this manipulation does not represent an optimal or even well-trained MNMEF filter without inflation; instead, it intentionally removes the correction term to create a more challenging robustness test—probing whether the filter remains stable and avoids divergence in the absence of inflation. These experiments are conducted on the KS dynamical system (5.6) only. 

Our results are presented in Figure 9. We compare the mean R-RMSE E between our standard architecture with the trained inflation (blue curve) and the no inflation version by setting � _u_[(] θ _[n]_[)] = 0 (red curve) for observation noise 

32 

**==> picture [452 x 122] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>1<br>Relative 0.8<br>0.8<br>RMSE<br>0.6 0.6<br>0.4 0.4<br>5 10 15 20 40 60 100 5 10 15 20 40 60 100<br>Kuramoto– Ensemble Size Ensemble Size<br>Sivashinsky σ y = 0.7 σ y = 1.0<br>Trained Infl (mean ± std) No Infl (mean ± std)<br>**----- End of picture text -----**<br>


Figure 9: Comparison of the trained inflation versus the no inflation scenario when applied to the KS system (5.6), using our MNMEF method, fine-tuned for different ensemble sizes. The plots compare R-RMSE with and without inflation at observation noise levels σ _y_ = 0.7 (left plot) and σ _y_ = 1.0 (right plot). In summary, our trained inflation effectively improves the performance, but even without inflation, our MNMEF does not completely fail. 

σ _y_ = 0.7 and 1.0. The results in Figure 9 clearly demonstrate the beneficial impact of our trained inflation approach. In addition, our method remains functional, with increased R-RMSE values, when we remove inflation by setting � _u_[(] θ _[n]_[)] = 0 (equivalent to α = 1 in the EnKF). This confirms that our experiment, while intentionally suboptimal, demonstrates that the proposed MNMEF remains numerically stable and does not diverge even in this deliberately more difficult configuration. This addresses our concern, because, if inflation were dominating the architecture by masking the contribution of the state _v_[(] _[n]_[)] , removing it would cause model collapse. 

## _5.7.2. Localization Experiments_ 

According to Subsection 4.2.3, our learning-based localization approach essentially learns a parameterized function _g_ θ, which maps distance to weight values. During training, we only enforce the constraint that the output of this function must lie within the interval [0,2], i.e., _g_ θ : R → [0, 2]. Unlike traditional localization functions used in EnKF such as the Gaspari–Cohn function, our approach does not impose any explicit constraints on the shape or monotonicity of _g_ θ. 

In this subsection, we present experimental comparisons between our learned function _g_ θ and the Gaspari–Cohn (GC) function with the optimal localization radius, found by grid-search, for LETKF; see Figure 10 . For ensemble sizes _N_ = 5, 10, 15, 20, 40, 60, 100, the optimal GC radius values chosen are 1, 1, 2, 3, 4, 4, 6 (multiplied by[√] 10/3 when implemented [58]), respectively. The learned function _g_ θ (shown as red curves with the mean and standard deviation of the learned _g_ θ across assimilation time steps) demonstrates a similar shape to the GC function with optimally chosen radius (blue curves). Notably, our approach dynamically adjusts the localization weights at each assimilation step based on ensemble size and distribution, while the GC function remains static throughout the assimilation process. 

**==> picture [463 x 115] intentionally omitted <==**

**----- Start of picture text -----**<br>
σ y = 0.7<br>σ y = 1.0<br>N 5 10 15 20 40 60 100<br>Learned g  (mean ± std) Gaspari-Cohn Function<br>**----- End of picture text -----**<br>


Figure 10: Comparison of our learned distance-to-weight function _g_ θ (red, mean ± 1 std across different time steps due to its adaptivity) with the LETKF Gaspari–Cohn (GC) function (blue) on the Lorenz ’96 model for σ _y_ = 1.0, 0.7 and ensemble sizes _N_ = 5, 10, 15, 20, 40, 60, 100. The learned distance-to-weight function is from our MNMEF pretrained on _N_ = 10 and fine-tuned for different ensemble sizes. The LETKF GC radius parameters are optimally selected via grid search. Remarkably, even without any explicit constraints on the shape of _g_ θ, the learned weights naturally decrease as the distance increases, similar to the empirical GC function in LETKF. 

33 

The results in Figure 10 demostrates the effectiveness of our learned localization. Despite imposing no explicit constraints on shape or monotonicity, the learned function _g_ θ naturally exhibits similar behavior to the GC function: it decreases monotonically with distance and shares a similar shape. A key difference is that our function occasionally exceeds values of 1 at short distances, reflecting a combined localization and inflation effect where covariance between closely spaced dimensions is amplified, since we are learning the inflation and localization simultaneously. This adaptivity allows _g_ θ to dynamically adjust to the ensemble distribution, leading to improved performance over the fixed GC function, as supported by RMSE results in Subsections 5.2 and 5.3. 

**Remark 23** (Using GC localization directly) **.** _Experimental results suggest that one can use the GC function to avoid training the localization. However, this approach still requires selecting the radius hyperparameter and typically yields inferior performance compared to our learned localization._ 

## _5.8. Fine-Tuning for Di_ ff _erent Ensemble Size_ 

According to Subsection 4.4, our proposed fine-tuning strategy freezes parameters θST of the set transformer _F_[ST] (4.25), while updating parameters θgain, θinfl and θloc of the MLPs that control the gain (4.28), inflation (4.30), and localization (4.36). Here we conduct experiments to illustrate the efficiency and effectiveness of our proposed finetuning approach. 

Firstly, we consider the time complexity between the pretraining stage and fine-tuning stage. Let _P_ pretrain and _P_ ft denote the total number of pretraining and fine-tuning parameters respectively, i.e. 

**==> picture [308 x 26] intentionally omitted <==**

For fixed dynamic and training trajectories, the time complexity for pretraining with the ensemble size _N_ is O[�] _ENPt_ � while the fine-tuning with the ensemble size _N_[′] has the time complexity O[�] _E_[′] _N_[′] _P ft_ �, where _E_ and _E_ ′ are the epochs for pretraining and fine-tuning, respectively. 

We provide a detailed comparison in Table 5, presenting the total number of pretraining parameters _P_ pretrain, fine-tuning parameters _P_ ft, and the number of epochs _E_ used during the pretraining and fine-tuning phases. When the ensemble size during pretraining ( _N_ ) is close to the ensemble size used in fine-tuning ( _N_[′] ), Table 5 shows that the finetuning stage requires less than 1% of the pretraining computational time. To quantitatively support this observation, we present detailed computational time comparisons in Table 6. All training times reported here are obtained using a single RTX 4080 Super GPU. The training batch sizes are adaptively chosen to fully use the 16 GB memory. 

Table 5: Comparison of total parameters, fine-tuning parameters, and epochs for various datasets. 

|Dataset|Total Params|FT Params|Pretrain Epochs|FT Epochs|
|---|---|---|---|---|
|Lorenz ’96|341551|63343|1000|20|
|KS|374289|90065|1000|20|
|Lorenz ’63|309383|34119|1000|20|



Table 6: Comparison of pretraining and fine-tuning computational time for observation noise σ _y_ = 1.0 with different ensemble sizes on a single RTX 4080 Super GPU. The ratio is between the computation time of the fine-tuning stage and the time of the pretraining stage. The fine-tuning time increases with the ensemble size, but it remains significantly faster compared to the pretraining stage. 

|Ens Size|_N_ =10|_N_′ =20|_N_′ =40|_N_′ =100|
|---|---|---|---|---|
||||||
|Dataset|Pretrain (hrs)|FT (hrs)<br>Ratio|FT (hrs)<br>Ratio|FT (hrs)<br>Ratio|
||||||
|Lorenz ’96<br>KS<br>Lorenz ’63|4.03<br>8.22<br>1.82|0.051<br>1.27%<br>0.106<br>1.29%<br>0.022<br>1.21%|0.065<br>1.61%<br>0.132<br>1.61%<br>0.038<br>2.09%|0.133<br>3.30%<br>0.260<br>3.16%<br>0.086<br>4.73%|



34 

**==> picture [423 x 165] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.326 Our FT Our FT<br>0.315<br>Full FT Full FT<br>0.324<br>0.310<br>0.322<br>0.305<br>0.320<br>0.300<br>0.318<br>0.295<br>0.316<br>0.290<br>0.314<br>0.285<br>0 10 20 30 40 50 0 10 20 30 40 50<br>FT Epoch FT Epoch<br>(a) Ensemble Size 20 (b) Ensemble Size 40<br>R-RMSE R-RMSE<br>**----- End of picture text -----**<br>


Figure 11: Comparison of R-RMSE across training epochs on the Lorenz ’96 model for two fine-tuning strategies under two ensemble sizes, (a) 20 and (b) 40. The vertical dashed red line indicates the stopping epoch of our proposed fine-tuning approach. Results demonstrate that our fine-tuning on a small subset of parameters achieves comparable RMSE performance to fine-tuning all parameters. 

Combining the information from Tables 5 and 6, we observe that our fine-tuning strategy demonstrates remarkable efficiency compared to the pretraining stage. As detailed in Subsections 5.4–5.3, this highly efficient fine-tuning significantly improves the model’s performance, particularly when the ensemble sizes for inference and pretraining differ substantially. 

To further validate the effectiveness of our proposed fine-tuning approach, we perform additional experiments comparing our method (Subsection 4.4) against alternative fine-tuning strategies. Specifically, we investigate and quantitatively compare the RMSE performance of the following fine-tuning scenarios: (1) fine-tuning all model parameters and (2) fine-tuning for a longer period (i.e., more epochs). 

Figure 11 shows RMSE results from fine-tuning experiments on the Lorenz ’96 model with ensemble sizes _N_[′] = 20, 40, using a model pretrained with ensemble size _N_ = 10. We compare our proposed method from Subsection 4.4 against fine-tuning all parameters, both running up to 50 epochs. The results demonstrate that both approaches achieve nearly identical RMSE performance, with minimal improvement observed after 20 epochs. Combined with our efficiency analysis in Tables 5 and 6, these findings confirm that fine-tuning all parameters is unnecessary, and that 20 epochs is sufficient for the near optimal performance. 

## **6. Conclusions** 

In this paper, we propose a novel machine learning-based approach, MNMEF, for state estimation in data assimilation. Our method features a scheme which subsumes the ensemble Kalman filter (EnKF), as a special case, ensuring optimality for linear, Gaussian problems, while extending beyond Gaussian applications through our learnable correction terms. A key advantage of our method is its ability to be trained at one ensemble size and then directly applied, possibly with a cheap fine-tuning of a small subset of parameters, for different ensemble sizes. This property is a consequence of the mean-field interpretation of the set transformer, the machine learning architecture underlying the methodology. Indeed, in this paper we introduce neural operators acting on the metric space of probability measures, which we call _measure neural mappings_ (MNM). We generalize transformers to this setting and show how the set transformer itself may be viewed as a particle approximation of such a mean-field model. 

Our method adopts a form similar to the Kalman filter in the mean-field perspective, with the core innovation being a parameterized gain matrix analogous to the Kalman gain (Section 2). Since this parameterized gain matrix depends on the current filtering distribution, we employ the set transformer neural network architecture to process such measure inputs (Section 3). In practical applications, our method operates on an ensemble of particles (viewed as an empirical measure) and incorporates learnable mechanisms analogous to inflation and localization techniques in EnKF-based methods, enhancing performance with smaller ensemble sizes (Section 4). Our experiments across multiple challenging systems (Lorenz ’63, Lorenz ’96, and Kuramoto-Sivashinsky) demonstrate that our proposed 

35 

method consistently outperforms classical approaches including the local ensemble transform Kalman filter (LETKF), with relative improvements of 15–30% for most scenarios (Section 5). 

Despite the promising results, our method has limitations and several directions for future improvement. Our current approach is limited by the loss function design, which primarily addresses state estimation rather than general filtering problems. Future work will consider probabilistic loss functions that can be used to estimate the filtering distribution. 

Additionally, we plan to extend our approach beyond EnKF to include other filtering schemes, such as the ensemble square root filter (ESRF), which is a deterministic version of the EnKF, or variational methods such as iterative EnKF (iEnKF). The flexibility of our approach stems from the proposed MNM-based learning architecture, which can optimize variables related to the empirical distributions represented by ensembles. 

We currently formulate the transformer as a neural operator accepting probability measures as inputs. In future work, we aim to enhance both the architecture and training methodology to simultaneously handle measure and function valued inputs, enabling amortized neural operators that generalize across different dynamics and observation models. Establishing universal approximation results and statistical guarantees for this formulation will also be of interest to further strengthen the theoretical foundations of our approach. 

In conclusion, our work advances the field of data assimilation by introducing a novel machine learning approach, which is efficient for deployment, requiring only one pretraining stage and lightweight fine-tuning. Beyond immediate applications in state estimation, our theoretical contribution of extending attention mechanisms to operate as measureto-measure transformations opens new research directions across multiple disciplines. 

## **7. Acknowledgements** 

The authors are grateful to Arnaud Doucet for pointing them to work on the set transformer. The authors acknowledge support from a Department of Defense (DoD) Vannevar Bush Faculty Fellowship (award N00014-22-1-2790), NSF award AGS1835860 and from the Resnick Sustainability Institute; all support is held by AMS. 

## **References** 

- [1] A. H. Jazwinski, Stochastic Processes and Filtering Theory, Vol. 64 of Mathematics in Science and Engineering, Academic Press, New York, 1970. 

- [2] K. Law, A. Stuart, K. Zygalakis, Data Assimilation: A Mathematical Introduction, Vol. 62 of Texts in Applied Mathematics, Springer, Cham, 2015. `doi:10.1007/978-3-319-20325-6` . 

- [3] M. Asch, M. Bocquet, M. Nodet, Data Assimilation: Methods, Algorithms, and Applications, Vol. 11 of Fundamentals of Algorithms, SIAM, Philadelphia, 2016. `doi:10.1137/1.9781611974546` . 

- [4] S. Reich, C. Cotter, Probabilistic Forecasting and Bayesian Data Assimilation, Cambridge University Press, Cambridge, 2015. `doi:10.1017/CBO9781107706804` . 

- [5] G. Evensen, F. C. Vossepoel, P. J. van Leeuwen, Data Assimilation Fundamentals: A Unified Formulation of the State and Parameter Estimation Problem, Springer Textbooks in Earth Sciences, Geography and Environment, Springer, Cham, 2022. `doi:10.1007/978-3-030-96709-3` . 

- [6] E. Bach, R. Baptista, D. Sanz-Alonso, A. Stuart, Machine Learning for Inverse Problems and Data Assimilation, 2025. `arXiv:2410.10523` . 

- [7] R. E. Kalman, A new approach to linear filtering and prediction problems, Journal of Basic Engineering 82 (1) (1960) 35–45. `arXiv:https://asmedigitalcollection.asme.org/fluidsengineering/ article-pdf/82/1/35/5518977/35\_1.pdf` , `doi:10.1115/1.3662552` . 

- [8] G. Evensen, The ensemble kalman filter: Theoretical formulation and practical implementation, Ocean dynamics 53 (2003) 343–367. 

36 

- [9] G. Burgers, P. J. Van Leeuwen, G. Evensen, Analysis scheme in the ensemble Kalman filter, Monthly weather review 126 (6) (1998) 1719–1724. 

- [10] J. L. Anderson, An ensemble adjustment Kalman filter for data assimilation, Monthly Weather Review 129 (12) (2001) 2884 – 2903. `doi:10.1175/1520-0493(2001)129<2884:AEAKFF>2.0.CO;2` . 

- [11] M. K. Tippett, J. L. Anderson, C. H. Bishop, T. M. Hamill, J. S. Whitaker, Ensemble Square Root Filters, Monthly Weather Review 131 (7) (2003) 1485–1490, publisher: American Meteorological Society Section: Monthly Weather Review. `doi:10.1175/1520-0493(2003)131<1485:ESRF>2.0.CO;2` . 

- [12] P. J. Van Leeuwen, A consistent interpretation of the stochastic version of the ensemble kalman filter, Quarterly Journal of the Royal Meteorological Society 146 (731) (2020) 2815–2825. 

- [13] J. L. Anderson, S. L. Anderson, A Monte Carlo implementation of the nonlinear filtering problem to produce ensemble assimilations and forecasts, Monthly Weather Review 127 (12) (1999) 2741 – 2758. `doi:10.1175/ 1520-0493(1999)127<2741:AMCIOT>2.0.CO;2` . 

- [14] J. L. Anderson, An adaptive covariance inflation error correction algorithm for ensemble filters, Tellus A: Dynamic Meteorology and Oceanography 59 (2) (2007) 210–224. `arXiv:https://doi.org/10.1111/j. 1600-0870.2006.00216.x` , `doi:10.1111/j.1600-0870.2006.00216.x` . 

- [15] B. R. Hunt, E. J. Kostelich, I. Szunyogh, Efficient data assimilation for spatiotemporal chaos: A local ensemble transform Kalman filter, Physica D: Nonlinear Phenomena 230 (1) (2007) 112–126. 

- [16] P. Sakov, D. S. Oliver, L. Bertino, An iterative EnKF for strongly nonlinear systems., Monthly Weather Review 140 (6) (2012) 1988–2004. 

- [17] M. Zupanski, Maximum likelihood ensemble filter: Theoretical aspects, Monthly Weather Review 133 (6) (2005) 1710–1726. 

- [18] S. Cheng, C. Quilodrán-Casas, S. Ouala, A. Farchi, C. Liu, P. Tandeo, R. Fablet, D. Lucor, B. Iooss, J. Brajard, D. Xiao, T. Janjic, W. Ding, Y. Guo, A. Carrassi, M. Bocquet, R. Arcucci, Machine Learning With Data Assimilation and Uncertainty Quantification for Dynamical Systems: A Review, IEEE/CAA Journal of Automatica Sinica 10 (6) (2023) 1361–1387. `doi:10.1109/JAS.2023.123537` . 

- [19] H. Hoang, P. De Mey, O. Talagrand, A simple adaptive algorithm of stochastic approximation type for system parameter and state estimation, in: Proceedings of 1994 33rd IEEE Conference on Decision and Control, Vol. 1, 1994, pp. 747–752 vol.1. `doi:10.1109/CDC.1994.410863` . 

- [20] N. Mallia-Parfitt, J. Bröcker, Assessing the performance of data assimilation algorithms which employ linear error feedback, Chaos: An Interdisciplinary Journal of Nonlinear Science 26 (10) (2016) 103109. `doi:10. 1063/1.4965029` . 

- [21] M. Levine, A. Stuart, A framework for machine learning of model error in dynamical systems, Communications of the American Mathematical Society 2 (07) (2022) 283–344. `doi:10.1090/cams/10` . 

- [22] E. Bach, R. Baptista, E. Luk, A. Stuart, Learning Optimal Filters Using Variational Inference (Mar. 2025). `arXiv:2406.18066` , `doi:10.48550/arXiv.2406.18066` . 

- [23] M. McCabe, J. Brown, Learning to Assimilate in Chaotic Dynamical Systems, in: Advances in Neural Information Processing Systems, Vol. 34, Curran Associates, Inc., 2021, pp. 12237–12250. 

- [24] M. Bocquet, A. Farchi, T. S. Finn, C. Durand, S. Cheng, Y. Chen, I. Pasmans, A. Carrassi, Accurate deep learning-based filtering for chaotic dynamics by identifying instabilities without an ensemble, Chaos: An Interdisciplinary Journal of Nonlinear Science 34 (9) (2024) 091104. `doi:10.1063/5.0230837` . 

- [25] A. Spantini, R. Baptista, Y. Marzouk, Coupling techniques for nonlinear ensemble filtering, SIAM Review 64 (4) (2022) 921–953. 

37 

- [26] H. G. Chipilski, Exact nonlinear state estimation, Journal of the Atmospheric Sciences 82 (4) (2025) 809–827. `doi:10.1175/JAS-D-24-0171.1` . 

   - URL `https://journals.ametsoc.org/view/journals/atsc/82/4/JAS-D-24-0171.1.xml` 

- [27] Y. Shi, V. De Bortoli, G. Deligiannidis, A. Doucet, Conditional simulation using diffusion schrödinger bridges, in: Uncertainty in Artificial Intelligence, PMLR, 2022, pp. 1792–1802. 

- [28] M. Al-Jarrah, N. Jin, B. Hosseini, A. Taghvaei, Nonlinear filtering with brenier optimal transport maps, arXiv preprint arXiv:2310.13886 (2023). 

- [29] P. J. Van Leeuwen, H. R. Künsch, L. Nerger, R. Potthast, S. Reich, Particle filters for high-dimensional geoscience applications: A review, Quarterly Journal of the Royal Meteorological Society 145 (723) (2019) 2335– 2365. 

- [30] C.-C. Hu, P. J. Van Leeuwen, J. L. Anderson, An implementation of the particle flow filter in an atmospheric model, Monthly Weather Review 152 (10) (2024) 2247–2264. 

- [31] F. Daum, J. Huang, Particle flow for nonlinear filters, in: 2011 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP), IEEE, 2011, pp. 5920–5923. 

- [32] K. Bergemann, S. Reich, An ensemble kalman-bucy filter for continuous data assimilation, Meteorologische Zeitschrift 21 (3) (2012) 213. 

- [33] M. Pulido, P. J. van Leeuwen, Kernel embedding of maps for bayesian inference: The variational mapping particle filter, in: EGU general assembly conference abstracts, 2018, p. 3750. 

- [34] J. Bröcker, D. Engster, U. Parlitz, Probabilistic evaluation of time series models: A comparison of several approaches, Chaos: An Interdisciplinary Journal of Nonlinear Science 19 (4) (2009) 043130. `doi:10.1063/1. 3271343` . 

- [35] P. Boudier, A. Fillion, S. Gratton, S. Gürol, S. Zhang, Data Assimilation Networks, Journal of Advances in Modeling Earth Systems 15 (4) (2023) e2022MS003353, _eprint: https://onlinelibrary.wiley.com/doi/pdf/10.1029/2022MS003353. `doi:10.1029/2022MS003353` . 

- [36] X.-H. Zhou, Z.-R. Liu, H. Xiao, BI-EqNO: Generalized Approximate Bayesian Inference with an Equivariant Neural Operator Framework, arXiv:2410.16420 (Oct. 2024). `doi:10.48550/arXiv.2410.16420` . 

- [37] K. Höhlein, B. Schulz, R. Westermann, S. Lerch, Postprocessing of Ensemble Weather Forecasts Using Permutation-invariant Neural Networks, Artificial Intelligence for the Earth Systems 3 (1) (2024) e230070, arXiv:2309.04452 [physics, stat]. `doi:10.1175/AIES-D-23-0070.1` . 

- [38] A. Vaswani, N. Shazeer, N. Parmar, J. Uszkoreit, L. Jones, A. N. Gomez, L. Kaiser, I. Polosukhin, Attention is all you need, Advances in neural information processing systems 30 (2017). 

- [39] S. Cao, Choose a transformer: Fourier or galerkin, in: M. Ranzato, A. Beygelzimer, Y. Dauphin, P. Liang, J. W. Vaughan (Eds.), Advances in Neural Information Processing Systems, Vol. 34, Curran Associates, Inc., 2021, pp. 24924–24940. 

- [40] Z. Li, K. Meidani, A. B. Farimani, Transformer for partial differential equations’ operator learning, Transactions on Machine Learning Research (2023). 

- [41] E. Calvello, N. B. Kovachki, M. E. Levine, A. M. Stuart, Continuum attention for neural operators, arXiv preprint arXiv:2406.06486 (2024). 

- [42] S. Wang, J. H. Seidman, S. Sankaran, H. Wang, G. J. Pappas, P. Perdikaris, CViT: Continuous vision transformer for operator learning, in: The Thirteenth International Conference on Learning Representations, 2025. 

38 

- [43] B. Geshkovski, C. Letrouit, Y. Polyanskiy, P. Rigollet, A mathematical perspective on transformers, arXiv preprint arXiv:22312.10794 (2024). 

- [44] V. Castin, P. Ablin, J. A. Carrillo, G. Peyré, A unified perspective on the dynamics of deep transformers, arXiv preprint arXiv:2501.18322 (2025). 

- [45] B. Geshkovski, P. Rigollet, D. Ruiz-Balet, Measure-to-measure interpolation using transformers, arXiv preprint arXiv:2411.04551 (2024). `arXiv:2411.04551` . 

- [46] A. Bain, D. Crisan, Fundamentals of stochastic filtering, Vol. 3, Springer, 2009. 

- [47] A. M. Stuart, Inverse problems: a bayesian perspective, Acta numerica 19 (2010) 451–559. 

- [48] E. Calvello, S. Reich, A. M. Stuart, Ensemble Kalman methods: a mean field perspective, Acta Numerica, arXiv preprint arXiv:2209.11371 (2025). 

- [49] N. Kovachki, Z. Li, B. Liu, K. Azizzadenesheli, K. Bhattacharya, A. Stuart, A. Anandkumar, Neural Operator: Learning Maps Between Function Spaces With Applications to PDEs, Journal of Machine Learning Research 24 (89) (2023) 1–97. 

- [50] N. B. Kovachki, S. Lanthaler, A. M. Stuart, Operator learning: Algorithms and analysis, arXiv preprint arXiv:2402.15715 (2024). 

- [51] E. Calvello, P. Monmarché, A. Stuart, U. Vaes, Accuracy of the ensemble Kalman filter in the near-linear setting, arXiv preprint 2409.09800 (2024). 

- [52] J. Lee, Y. Lee, J. Kim, A. R. Kosiorek, S. Choi, Y. W. Teh, Set transformer: A framework for attention-based permutation-invariant neural networks (2019). `arXiv:1810.00825` . 

- [53] G. Gaspari, S. E. Cohn, Construction of correlation functions in two and three dimensions, Quarterly Journal of the Royal Meteorological Society 125 (554) (1999) 723–757. `arXiv:https://rmets.onlinelibrary. wiley.com/doi/pdf/10.1002/qj.49712555417` , `doi:https://doi.org/10.1002/qj.49712555417` . 

- [54] D. Vishny, M. Morzfeld, K. Gwirtz, E. Bach, O. R. A. Dunbar, D. Hodyss, High-Dimensional Covariance Estimation From a Small Number of Samples, Journal of Advances in Modeling Earth Systems 16 (9) (2024) e2024MS004417, _eprint: https://onlinelibrary.wiley.com/doi/pdf/10.1029/2024MS004417. `doi:10.1029/ 2024MS004417` . 

- [55] W. Sacher, P. Bartello, Sampling Errors in Ensemble Kalman Filtering. Part I: Theory, Monthly Weather Review 136 (8) (2008) 3035–3049. `doi:10.1175/2007MWR2323.1` . URL `https://journals.ametsoc.org/doi/10.1175/2007MWR2323.1` 

- [56] P. Sakov, P. R. Oke, A deterministic formulation of the ensemble Kalman filter: an alternative to ensemble square root filters, Tellus A: Dynamic Meteorology and Oceanography 60 (2) (2008) 361–371. 

- [57] C. H. Bishop, B. J. Etherton, S. J. Majumdar, Adaptive sampling with the ensemble transform kalman filter. part i: Theoretical aspects, Monthly weather review 129 (3) (2001) 420–436. 

- [58] P. N. Raanes, Y. Chen, C. Grudzien, DAPPER: Data Assimilation with Python: a Package for Experimental Research, Journal of Open Source Software 9 (94) (2024) 5150. `doi:10.21105/joss.05150` . 

- [59] J. Stoer, R. Bulirsch, R. Bartels, W. Gautschi, C. Witzgall, Introduction to numerical analysis, Vol. 1993, Springer, 1980. 

- [60] E. N. Lorenz, Predictability: A problem partly solved, in: Proc. Seminar on predictability, Vol. 1, Reading, 1996, pp. 1–18. 

39 

- [61] Y. Kuramoto, Diffusion-induced chaos in reaction systems, Progress of Theoretical Physics Supplement 64 (1978) 346–367. 

- [62] D. M. Michelson, G. I. Sivashinsky, Nonlinear analysis of hydrodynamic instability in laminar flames—ii. numerical experiments, Acta astronautica 4 (11-12) (1977) 1207–1221. 

- [63] A.-K. Kassam, L. N. Trefethen, Fourth-order time-stepping for stiff pdes, SIAM Journal on Scientific Computing 26 (4) (2005) 1214–1233. 

- [64] E. N. Lorenz, Deterministic Nonperiodic Flow, Journal of the Atmospheric Sciences 20 (2) (1963) 130–148. `doi:10.1175/1520-0469(1963)020<0130:DNF>2.0.CO;2` . 

- [65] I. Loshchilov, F. Hutter, Decoupled weight decay regularization, arXiv preprint arXiv:1711.05101 (2017). 

40 

## **Appendix A. Overview of the Architecture and our Complete Learning Framework** 

In this appendix, we provide an overview of our complete learning framework. Our architecture (Subsection 4.2) is designed to handle varying ensemble sizes efficiently while maintaining high performance through a combination of neural network-based corrections and fine-tuning strategies. The training process follows the methodology described in Subsection 4.3, where the model parameters are initially trained on a fixed ensemble size _N_ . When our approach is applied to a different ensemble size _N_[′] � _N_ , we perform fine-tuning using the procedure detailed in Subsection 4.4. 

Recall that in both the initial training and the fine-tuning process, we always work under Data Assumption 1: we fix dynamic operator Ψ (time step ∆ _t_ implicitly embedded), observation operator _h_ , and noise covariance matrices Σ and Γ. We generate multiple trajectories of the state-observation system through independent realizations of the driving noise sequences. 

The core of our framework (Algorithm 1) is to update the ensemble from { _v_[(] _j[n]_[)][}] _n[N]_ =1[to][{] _[v]_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[.][This][is][a][basic] component for both the training and inference. Based on this, we can calculate the loss and do the initial training with the ensemble size _N_ according to Algorithm 2. When we need to proceed with a different ensemble size _N_[′] � _N_ , we follow Algorithm 3 to efficiently fine-tune part of the parameters. 

After completing the pretraining (Algorithm 2) on ensemble size _N_ , the inference procedure depends on the desired inference ensemble size _N_[′] . If _N_[′] = _N_ , then no additional fine-tuning is required. However, if _N_[′] � _N_ , for optimal performance, we recommend employing Algorithm 3 to efficiently fine-tune the model before inference. Below, we describe the inference steps for the general case where _N_[′] � _N_ after fine-tuning has been completed. 

We first load the pre-trained parameter θST[(] _[N]_[)][that][remain][unchanged][regardless][of][ensemble][size,][along][with][the] fine-tuned parameters θgain[(] _[N]_[′][)][,][θ] infl[(] _[N]_[′][)][,][and][ θ] loc[(] _[N]_[′][)][that were specifically optimized for ensemble size] _[N]_[′][.][We then initialize] the ensemble { _v_[(] 0 _[n]_[)][}] _n[N]_ =[′] 1[according][to][equation][(4.37).][For][each][time][step] _[j]_[,][we][evolve][the][ensemble][from][{] _[v]_[(] _j[n]_[)][}] _n[N]_ =[′] 1[to] { _v_[(] _j[n]_ +[)] 1[}] _n[N]_ =[′] 1[using Algorithm 1.][This process can be extended to observation trajectories of arbitrary length.][At each time] step, we can approximate the true state _v_[†] _j_[using the ensemble mean] _v j_ = _N_ 1[′] � _nN_ =′ 1 _[v]_[(] _j[n]_[)][.] 

**Algorithm 1** One Step Evolution of the Ensemble 

**Require:** Parameters θ = {θST, θgain, θinfl, θloc}; current ensemble { _v_[(] _j[n]_[)][}] _n[N]_ =1[.] **Ensure:** Ensemble for the next time step { _v_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[.] 1: Get predicted states {� _v_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[from][ {] _[v]_[(] _j[n]_[)][}] _n[N]_ =1[(4.38a).] 2: Get predicted observations {� _y_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[from][ {][�] _[v]_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[(4.38b).] 

- 3: Process the ensemble into a feature vector according to (4.25): 

**==> picture [327 x 55] intentionally omitted <==**

- 6: Process with the neural network for localization: 

� _g j_ +1 = _F_[loc] ( _fv_ ; θloc) according to (4.36). 7: Calculate localization matrices ( _L_ θ[(1)][)] _[ j]_[+][1][ and (] _[L]_ θ[(2)][)] _[ j]_[+][1][(Subsection 4.2.3).] 

- 8: Calculate the Gain matrix ( _K_ θ) _j_ +1 with localization (4.34). 

- 9: Get { _v_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[according to the analysis step:] 

**==> picture [135 x 16] intentionally omitted <==**

- 10: Process with the neural network for inflation: 

� _u_[(] θ _[n]_[)] = _F_[infl] ( _v_[(] _j[n]_ +[)] 1[,] _[f][v]_[;][ θ][infl][) according to (4.30)][.] 

11: Update the estimation with the learned inflation term � _u_[(] θ _[n]_[)] by _v_[(] _[n]_[)] _j_ +1[←] _[v]_[(] _j[n]_ +[)] 1[+][�] _[u]_ θ[(] _[n]_[)][.] 

- 12: **return** Ensemble { _v_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[.] 

41 

## **Algorithm 2** Pretraining 

**Require:** _J_ , _M_ ∈ N; ensemble size _N_ . **Ensure:** Trained parameters θ[(] _[N]_[)] = {θST[(] _[N]_[)][, θ] gain[(] _[N]_[)][, θ] infl[(] _[N]_[)][, θ] loc[(] _[N]_[)][}][.] 1: **Training Data Generation:** Generate _M_ according to Subsection 4.3. 2: **for** each epoch, each minibatch indexed by _MB_ ⊂ [ _M_ ] **do** 3: **for** _m_ ∈ _MB_ and the corresponding trajectory { _v_[†] _j_[}] _[J] j_ =1 **[do]** 4: Initialize the ensemble { _v_[(] 0 _[n]_[)][}] _n[N]_ =1[(4.37).] 5: **for** _j_ = 0, 1, . . . , _J_ − 1 **do** 6: Update from { _v_[(] _j[n]_[)][}] _n[N]_ =1[to][ {] _[v]_[(] _j[n]_ +[)] 1[}] _n[N]_ =1[according to Algorithm 1.] 7: **end for** 8: Calculate the loss L _m_ (4.40). 9: **end for** 10: Calculate the batch loss L _MB_ (4.41). 11: Update θ via gradient descent on L _MB_ . 12: **end for** 

- 1: **Training Data Generation:** Generate _M_ training trajectories with length _J_ + 1 and corresponding observations according to Subsection 4.3. 

13: **return** Optimized parameters θ[(] _[N]_[)] = {θST[(] _[N]_[)][, θ] gain[(] _[N]_[)][, θ] infl[(] _[N]_[)][, θ] loc[(] _[N]_[)][}] 

**Algorithm 3** Fine-tuning 

**Require:** Ensemble size _N_[′] � _N_ ; pretrained parameter θST[(] _[N]_[)] **Ensure:** Updated parameters θgain[(] _[N]_[′][)][, θ] infl[(] _[N]_[′][)][, θ] loc[(] _[N]_[′][)][for new ensemble size] _[ N]_[′] 1: Use the same synthetic training data as Algorithm 2. 2: **for** each epoch, each minibatch indexed by _MB_ ⊂ [ _M_ ] **do** 3: **for** _m_ ∈ _MB_ and the corresponding trajectory { _v_[†] _j_[}] _[J] j_ =1 **[do]** 4: Initialize the ensemble { _v_[(] 0 _[n]_[)][}] _n[N]_ =[′] 1[with size] _[ N]_[′][(4.37).] 5: **for** _j_ = 0, 1, . . . , _J_ − 1 **do** 6: Update from { _v_[(] _j[n]_[)][}] _n[N]_ =[′] 1[to][ {] _[v]_[(] _j[n]_ +[)] 1[}] _n[N]_ =[′] 1[according to Algorithm 1.] 7: **end for** 8: Calculate the loss L[(] _m[N]_[′][)] with ensemble size _N_[′] (4.40). 9: **end for** 10: Calculate the batch loss L[(] _M[N] B_[′][)][(4.41) with ensemble size] _[ N]_[′] 11: Update θgain[(] _[N]_[′][)][, θ] infl[(] _[N]_[′][)][, θ] loc[(] _[N]_[′][)][according to (4.44).] 

- 12: **end for** 

13: **return** Optimized parameters θgain[(] _[N]_[′][)][, θ] infl[(] _[N]_[′][)][, θ] loc[(] _[N]_[′][)] 

## **Appendix B. Description of Multihead Attention** 

In Subsection 4.1, we introduce the definition of attention. However, in practical applications, multihead attention is commonly employed instead of the single-head variant. This appendix provides supplementary information on multihead attention, which is used in the set transformer architecture (Subsection 4.1) rather than standard singlehead attention. 

Recall the definition of the set of sequence of a finite length, U _F_ (R _[d]_ ) = ∪[∞] _N_ =1[U][([] _[N]_[];][ R] _[d]_[).][In][Subsection][4.1,] we defined attention as a sequence-to-sequence operator A : U _F_ (R _[d][u]_ ) × U _F_ (R _[d][w]_ ) →U _F_ (R _[d][v]_ ) (4.3) with learnable parameters θ(A) = { _Q_ , _K_ , _V_ }. For two sequences _u_ ∈U([ _N_ ]; R _[d][u]_ ) and _w_ ∈U([ _M_ ]; R _[d][w]_ ), we have 

**==> picture [350 x 30] intentionally omitted <==**

In multihead attention, we employ several parallel attention heads, each with its own set of learnable parameters. 

42 

This approach allows the model to jointly attend to information from different representation subspaces at different positions. Let us denote the multihead attention operator as A _[R]_ (•, •), where the superscript _R_ indicates the number of attention heads. For each head _r_ ∈ [ _R_ ], we have a separate set of learnable parameters θ(A _r_ ) = { _Qr_ , _Kr_ , _Vr_ }, where _Qr_ ∈ R _[d][k]_[×] _[d][u]_ , _Kr_ ∈ R _[d][k]_[×] _[d][w]_ , and _Vr_ ∈ R _[d]_[�] _[V]_[×] _[d][w]_ . 

For each head _r_ , we compute the attention output A _r_ ( _u_ , _w_ ) according to (B.1). The multihead attention mechanism A _[R]_ ( _u_ , _w_ ) combines the outputs from _R_ heads through concatenation followed by linear projection. For _j_ ∈ [ _N_ ], we compute the output as 

**==> picture [353 x 12] intentionally omitted <==**

where[�] A1( _u_ , _w_ )( _j_ ); A2( _u_ , _w_ )( _j_ ); . . . ; A _R_ ( _u_ , _w_ )( _j_ )[�] ∈ R _[R][d]_[�] _[V]_ is a vector vertically concatenated from the outputs from all attention heads, and _W[O]_ ∈ R _[d][V]_[×][(] _[R][d]_[�] _[V]_[)] is an additional learnable parameter matrix that projects the concatenated outputs to the desired dimension. 

The complete set of learnable parameters for the multihead attention mechanism is therefore: 

**==> picture [297 x 12] intentionally omitted <==**

In Section 3, we view attention as an operator on probability measures. This formulation naturally extends to multihead attention. The multihead attention operator acts on probability measures similarly to standard attention, but utilizes _R_ parallel attention heads. In addition, we introduce two major properties of the set transformer architecture in Subsection 4.1, i.e. the permutation invariance and the adaptation to variable input lengths. These two properties are preserved for the version using multihead attention, since multihead attention with _R_ heads effectively performs _R_ standard attention operations in parallel and concatenates their results. 

## **Appendix C. Implementation Details** 

In this appendix, we provide additional implementation details to complement the methods presented in Section 4 and their application in the numerical experiments of Section 5. 

The complete source code for reproducing our method is publicly available[4] . Additionally, for the benchmark methods, we performed extensive hyperparameter optimization using grid search[5] , implemented with the DAPPER package [58]. 

## _Appendix C.1. Feature Dimensions_ 

We provide detailed information about the latent dimensions used in our learning-based approach. While this information can be directly obtained from our code, we include this analysis to highlight two important properties of the set transformer architecture employed in our method: (1) the output is invariant to permutations of the input sequence, and (2) the output dimension remains consistent regardless of the length of the input sequence. 

We introduce the general set transformer architecture in Subsection 4.1, where the encoder and decoder can include several self-attention blocks (SAB) S[ST] (•) (4.18). In our experiments (Section 5), our actual architecture contains two SABs in both the encoder and decoder. This simplified structure provides sufficient representational capacity while maintaining computational efficiency. Our actual set tranformer architecture can be written as 

**==> picture [399 x 12] intentionally omitted <==**

where F[NN] 1 and F[NN] 2 are multilayer perceptrons consisting of multiple feedforward layers and activation layers (3.8); S[ST][F][Cat][is a layer that concatenate all elements] 1,2[and][ S][ST] 3,4[are SABs serving as the encoder and decoder respectively;] in a sequence into a long feature vector. Note that layers S[ST] 1[,][S][ST] 2[,][C][ST][,][S][ST] 3[and][ S][ST] 4[contain attention mechanisms,] which are implemented as multihead attention with 8 heads (Appendix B). 

Table C.7 provides the specific layer-wise dimension design in our architecture. We adopt similar network structures for all three experimental datasets: Lorenz ’63 (L’63) (5.7), Lorenz ’96 (L’96) (5.5), and Kuramoto-Sivashinsky 

> 4 `https://github.com/wispcarey/DALearning` 

> 5 `https://github.com/wispcarey/DapperGridSearch` 

43 

Table C.7: Feature dimensions at each layer of the set transformer architecture to process the ensemble states for different dynamical systems, Lorenz ’63 (L’63) (5.7), Lorenz ’96 (L’96) (5.5), and Kuramoto-Sivashinsky (KS) (5.6). We use ( _N_ , _d_ ) to denote a sequence in R _[d]_ with length _N_ (i.e. in U([ _N_ ], R _[d]_ )). The trainable seed is a sequence in R[64] with length 16. The input sequence dimension is the sum of state dimension and the observation dimension. 

|Dataset|Feature Dimensions after Each Layer|
|---|---|
||Input<br>FNN<br>1<br>SST<br>1<br>SST<br>2<br>CST(_s_,•)<br>SST<br>3<br>SST<br>4<br>FCat<br>FNN<br>2|
|L’63<br>L’96<br>KS|(N,4)<br>(N,64)<br>(N,64)<br>(N,64)<br>(16,64)<br>(16,64)<br>(16,64)<br>1024<br>64<br>(N,50)<br>(N,144)|



(KS) (5.6). For all experiments, we use a trainable seed _s_ ∈U([16], R[64] ), which is a sequence of length 16 in R[64] . The first linear layer F[NN] 1 maps input sequences of varying dimensions to R[64] , after which all subsequent layers maintain consistent dimensions across different dataset dynamics. 

Table C.7 clearly illustrates the fact that the set transformer can process input sequences of arbitrary length and output fixed-dimension feature vectors. Specifically, regardless of the input sequence length _N_ , after processing through the PMA block C[ST] ( _s_ , •) (4.15), the sequence length always aligns with the seed length. This critical dimensional reduction occurs because the cross-attention mechanism in C[ST] ( _s_ , •) uses the fixed-length seed _s_ as queries to attend to the input sequence. The output dimension is then determined by the concluding F[NN] 2 layer. For detailed computational mechanisms, please refer to Section 3 and Subsection 4.1. 

The table also helps illustrate where the permutation invariance is established in the architecture. Before the PMA C[ST] ( _s_ , •), the latent features are permutation equivariant with respect to the input, meaning that if the input sequence elements are reordered, the corresponding features will be reordered in the same way. However, after the PMA block, the feature ordering becomes entirely dependent on the seed sequence and completely independent of the input sequence ordering. This transformation from permutation equivariance to permutation invariance is a crucial property (Proposition 2) of the set transformer, enabling them to process sets rather than sequences. 

## _Appendix C.2. An Example of Learning the Localization Weight Matrix_ 

Here we provide a concrete example of how to compute the parameterized localization weight matrices _L_ θ[(1)] and _L_ θ[(2)] in the Lorenz ’96 system (Subsection 5.2) with state dimension _dv_ = 40 and observation dimension _dy_ = 10. Specifically, the 40 state variables are indexed by 1, 2, . . . , 40 in a cyclic manner, and the observations are available at indices 4, 8, 12, . . . , 40 (i.e., every 4th state variable). We employ a periodic distance metric for all index pairs _k_ , ℓ ∈ [ _dv_ ], 

**==> picture [306 x 12] intentionally omitted <==**

Then we can consider all the unique distance values given by: 

**==> picture [322 x 11] intentionally omitted <==**

Recall that ◦ denotes the Hadamard pointwise matrix product. In the classic localization setting (4.33) for the EnKF approach, 

**==> picture [299 x 18] intentionally omitted <==**

we have 

**==> picture [359 x 30] intentionally omitted <==**

In our learning framework introduced in Subsection 4.2.3, we learn a vector � _g_ ∈ R[21] according to (4.36) for the function values _g_ θ( _D_ ) for _D_ = 0, 1, 2, . . . , 20. Then in our proposed scheme (4.34), 

**==> picture [304 x 31] intentionally omitted <==**

we can calculate the parameterized localization weight matrices by 

**==> picture [362 x 31] intentionally omitted <==**

## _Appendix C.3. Initial Conditions_ 

Here we provide details of the initial conditions for the experiments in Section 5. To ensure our initial states lie on the attractor, we first select a base value and then evolve the system’s dynamics forward for a substantial number of time steps. This serves as a “burn-in" period. The initial conditions detailed below for each system are subsequently used to generate all trajectories for pretraining, fine-tuning, and testing. 

1. **Lorenz ’96 (Subsection 5.2)** : Sample _x_ 0 ∼ N(5, _I_ 40) and run the forward dynamic (5.5) for random 10[3] to 5 × 10[5] time steps with step size ∆ _t_ = 0.15 to get _v_[†] 0[.][Within each][ ∆] _[t]_[ time interval, there are 5 RK4 numerical] integration steps with the step size ∆ _t_ /5 = 0.03. The initial distribution is set to be N( _v_[†] 0[,] _[ I]_[40][).] 

2. **Kuramoto—Sivashinsky (Subsection 5.3)** : Set the interval [0, _L_ ] as _L_ = 32π. For _u_ 0( _x_ ) = cos(2 _x_ / _L_ )(1 + sin(2 _x_ / _L_ )), run the forward dynamic (5.6) for random 10[3] to 5 × 10[5] time steps with step size ∆ _t_ = 1.00 to get � _u_ . Within each ∆ _t_ time interval, there are 4 RK4 numerical integration steps with the step size ∆ _t_ /4 = 0.25. The initial state _v_[†][(][�] _[u]_[(] _[x]_[0][)][, . . . ,][�] _[u]_[(] _[x]_[127][)) with] _[x]_[ℓ][=][ℓ] _[L]_[/][128,][ ℓ][=][0][,][ 1][, . . . ,][ 127.][The initial distribution is set to] 0[=] 

be N( _v_[†] 0[,] _[ I]_[128][).] 

3. **Lorenz ’63 (Subsection 5.4)** : Sample _x_ 0 ∼ N(0, _I_ 3) and run the forward dynamic (5.7) for random 10[3] to 5×10[5] time steps with step size ∆ _t_ = 0.15 to get _v_[†] 0[. Within each][ ∆] _[t]_[ time interval, there are 5 RK4 numerical integration] steps with the step size ∆ _t_ /5 = 0.03. The initial distribution is set to be N( _v_[†] 0[,] _[ I]_[3][).] 

## _Appendix C.4. Hyperparameter Setting for Our Training_ 

We provide details of the training hyperparameters in experiments. The parameters listed in Table C.8 are utilized for pretraining with an ensemble size of _N_ = 10 in the experiments detailed in Section 5. When fine-tuning with a different ensemble size _N_[′] � _N_ (Subsection 4.4), the number of training trajectories is halved compared to the quantity used for pretraining. Furthermore, the learning rate for fine-tuning is set to 1/10 of the learning rate used during pretraining. We use the AdamW optimizer [65] for both the pretraining and fine-tuning. 

During the training process, we implement a clamping mechanism to ensure numerical stability and prevent issues such as exploding estimated trajectories. If the absolute value of any dimension of an estimated particle exceeds the specified clamp value (provided in the “Clamp” column of Table C.8), its sign is preserved, but its absolute value is replaced by the clamp threshold. 

Table C.8: Training hyperparameters for pretraining with an ensemble size N=10. For fine-tuning with N’ � N, the number of training trajectories is halved, and the learning rate is reduced to 1/10 of the values listed. Obs ∆ _t_ refers to the observation time step. 

|Dataset|Train Traj<br>Test Traj<br>Obs<br>Learning<br>Batch<br>Clamp<br>Num<br>Length<br>Num<br>Length<br>∆_t_<br>Rate<br>Size|
|---|---|
|Lorenz ’96<br>KS<br>Lorenz ’63|8192<br>60<br>64<br>1500<br>0.15<br>1e-3<br>512<br>20<br>8192<br>60<br>64<br>2000<br>1.00<br>5e-4<br>256<br>10<br>8192<br>60<br>64<br>1500<br>0.15<br>1e-3<br>1024<br>60|



## _Appendix C.5. Hyperparameter Optimization via Grid Search_ 

In our experiments (Section 5), we compare our pretrained and fine-tuned methods introduced in Section 4 with benchmarks, EnKF [9], ESRF [11], LETKF [15], and iEnKF[16], detailed in Subsection 5.1. The benchmark methods we compared require hyperparameter tuning for different ensemble sizes so that they are optimized at each ensemble size and hence indeed present a challenging benchmark for our proposed methodology. We use the DAPPER package [58], which implements these benchmark methods, allowing us to focus solely on conducting grid searches for the 

45 

**==> picture [211 x 172] intentionally omitted <==**

**==> picture [211 x 172] intentionally omitted <==**

**==> picture [467 x 381] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a)  N = 5 (b)  N = 10<br>(c)  N = 20 (d)  N = 40<br>(e)  N = 60 (f)  N = 100<br>**----- End of picture text -----**<br>


Figure C.12: Grid search results for the Local Ensemble Transform Kalman Filter (LETKF) [15] on the Kuramoto–Sivashinsky (KS) dynamical system (5.6) varying ensemble sizes. Each subplot shows the RMSE performance across different combinations of inflation parameter α and localization radius parameter _r_ . Darker colors indicate lower relative RMSE (R-RMSE) values (5.3) (better performance). 

46 

required hyperparameters across various ensemble sizes. This appendix presents examples of our grid search results to provide insight into the comprehensive range of our hyperparameter optimization. Complete results can be found in our GitHub repository[6] . 

For each of the four benchmark methods mentioned above, we perform grid search on the inflation parameter α > 1. After the analysis step, the state _v_[(] _[n]_[)] is updated according to: 

**==> picture [349 x 29] intentionally omitted <==**

In addition to inflation, for LETKF specifically, we consider the localization radius parameter _r_ , which is used in the Gaspari–Cohn (GC) function [53] to map distances to localization weights. 

For different methods, datasets, and ensemble sizes, we employ an adaptive approach to determine the grid search step sizes and ranges. Our evaluation metric is the average relative RMSE (R-RMSE) (5.3) computed over 64 test trajectories. Lower values of this metric indicate superior performance. Initially, we establish a consistent range and step size across all scenarios, then refine these parameters based on preliminary performance results in each specific case. This adaptive refinement allows us to concentrate computational resources on the most promising hyperparameter regions. 

Figure C.12 illustrates our grid search results for the Local Ensemble Transform Kalman Filter (LETKF) [15] method applied to the Kuramoto–Sivashinsky (KS) dynamical system (5.6) across different ensemble sizes ( _N_ = 5, 10, 20, 40, 60, 100). Each heat map displays the R-RMSE performance for various combinations of inflation parameter α and localization radius _r_ . 

## _Appendix C.6. Additional Experiments: Linear Setting_ 

Our MNMEF aims to learn correction terms based on the EnKF scheme; see the mean-field version (2.21)–(2.24) and their particle counterparts (4.1), (4.27). The motivation behind MNMEF is that EnKF is not an exact scheme for nonlinear or non-Gaussian settings from a mean-field perspective, so learnable corrections may close the modeling gap. When the forward dynamics and observation models are linear, 

**==> picture [288 x 10] intentionally omitted <==**

with additive Gaussian noises as in (2.1)–(2.2), the Kalman filter is exact, and the EnKF recovers it in the meanfield/infinite-ensemble limit. In this setting, the theoretically correct choice for the correction terms is 

**==> picture [273 x 10] intentionally omitted <==**

so that _K_ θ reduces to the classical Kalman gain (2.11b). Any nonzero learned corrections cannot improve optimality and therefore risk modeling observation/forecast noise rather than signal. Because the linear–Gaussian case is already optimal, training MNMEF with freely learnable ( _w_ �θ,� _z_ θ) can overfit stochastic fluctuations: with sufficiently many epochs (and without explicit regularization/early stopping), the network may drive the corrections to fit noise realizations. Although _K_ θ[(2)] + Γ remains invertible (by positive definiteness of Γ), such noise-fitting can manifest as unstable updates and lead to filter divergence. We provide a minimal working example in our repository.[7] 

To make the discussion concrete, we run a controlled linear–Gaussian experiment. The state dimension is _dv_ = 10 with a matrix _A_ ∈ R[10][×][10] whose eigenvalues satisfy |λ _i_ ( _A_ )| = 1 for all _i_ ; this yields marginally stable linear dynamics. The observation dimension is _dy_ = 5 with _H_ ∈ R[5][×][10] that observes every other coordinate. The process noise covariance is Σ = σ[2] _v[I]_[with][σ] _[v]_[=][0][.][01,][the][observation][noise][covariance][is][Γ][=][σ][2] _y[I]_[with][σ] _[y]_[=][1,][and][the][initial] condition is _v_ 0 ∼N(0, _I_ ). 

For training, the default loss of our MNMEF is the normalized loss used in the main text (4.40) and repeated here for completeness, 

**==> picture [292 x 32] intentionally omitted <==**

> 6 `https://github.com/wispcarey/DapperGridSearch` 

> 7 `https://github.com/wispcarey/DALearning` 

47 

**==> picture [467 x 292] intentionally omitted <==**

**----- Start of picture text -----**<br>
3.0 L2 (WD): Explode @ 185<br>L2: Explode @ 175<br>2.5<br>2.0<br>1.5<br>1.0 NL2: Explode @ 90<br>0.5<br>0.0<br>0 200 400 600 800 1000<br>Epoch<br>L2 L2 (WD) NL2 NL2 (WD) GT Baseline Explode<br>W2Diff<br>**----- End of picture text -----**<br>


Figure C.13: Linear–Gaussian experiment. Test _W_ 2 (ensemble Gaussian vs. Kalman Gaussian) versus training epoch under the four settings in (C.13), evaluated on 64 held-out trajectories (length 500 each). _Legend (from the lower panel):_ L2 = unnormalized loss (C.12); NL2 = normalized loss (C.11); WD = weight decay 10[−][2] ; GT Baseline = finite-ensemble sampling baseline obtained by drawing ensembles directly from the Kalman Gaussian and computing _W_ 2 via (C.14). Explode marks the divergence for each curve (happening within 5 epochs of the mark). Consistent with the text, the NL2 (WD) configuration remains stable for 1000 epochs and approaches the baseline, whereas other variants are unstable. 

which enforces scale invariance across trajectories. We also consider the unnormalized alternative 

**==> picture [290 x 30] intentionally omitted <==**

and, orthogonally, we optionally add weight decay with coefficient 10[−][2] , which is exactly equivalent to adding an ℓ2 penalty to the training objective. Combining these choices yields four settings: 

**==> picture [393 x 58] intentionally omitted <==**

We train with learning rate 10[−][3] for 1000 epochs on 8192 trajectories, each of length 60. Because the model is linear– Gaussian, the exact filtering distribution at every time step is Gaussian and can be computed by the Kalman filter, providing ground-truth means and covariances against which to evaluate. 

As the metric, we compare at each step the ensemble-based Gaussian approximation (empirical mean and covariance of the ensemble) with the Kalman ground-truth Gaussian via the 2-Wasserstein distance. For N( _m_ 1, _C_ 1) and N( _m_ 2, _C_ 2), the closed-form expression is 

**==> picture [390 x 16] intentionally omitted <==**

**==> picture [11 x 8] intentionally omitted <==**

We report the test _W_ 2 on 64 held-out trajectories (each of length 500 and disjoint from the training set), averaged over time and across trajectories, as a function of training epoch. 

A finite-ensemble effect sets an irreducible baseline: even if an ensemble is drawn exactly from the true Kalman Gaussian at each step, the empirical mean and covariance estimated from a finite ensemble will not match the truth perfectly, hence the _W_ 2 discrepancy cannot be zero. We therefore include a finite-ensemble sampling baseline by i.i.d. sampling from the Kalman Gaussian with the same ensemble size and computing (C.14); this quantifies the best attainable error due purely to sampling. 

The results are summarized in Figure C.13. Training with the normalized loss (C.11) without weight decay eventually exhibits exploding _W_ 2, consistent with the correction pathway overfitting observation/process noise when no true signal remains to learn. Adding weight decay (normalized + WD) stabilizes training throughout 1000 epochs and closely tracks the finite-ensemble baseline. In contrast, the unnormalized loss (C.12) leads to instability regardless of weight decay: both unnormalized variants eventually diverge. This confirms that, in the strictly linear–Gaussian regime where the Kalman filter is optimal and the correct corrections are ( _w_ �θ,� _z_ θ) ≡ (0, 0), normalization and explicit ℓ2 regularization are critical to avoid learning spurious noise-driven updates. 

By contrast, on nonlinear systems (Lorenz ’96, Kuramoto–Sivashinsky, and Lorenz ’63), where the Gaussian ansatz underlying EnKF is only approximate, the correction terms provide genuine modeling capacity. In those settings, even with very long training we did not observe noise overfitting or filter divergence; the learned corrections consistently improved or matched EnKF performance across our runs. In summary, in linear–Gaussian settings practitioners should disable the correction pathway or regularize it to recover the Kalman solution, whereas in nonlinear settings allowing trainable corrections is beneficial and did not cause instability in our experiments. 

49 

