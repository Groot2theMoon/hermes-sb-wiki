---
source_url: https://arxiv.org/abs/2411.05870
ingested: 2026-04-30
sha256: a26f248b5de6dbf95d11ce1c176df3695e125b645063abb0f715240711e1b118
source: paper
conversion: pymupdf4llm

---

# An Adaptive Online Smoother with Closed-Form Solutions and Information-Theoretic Lag Selection for Conditional Gaussian Nonlinear Systems 

Marios Andreou[1, *] , Nan Chen[1, †] & Yingda Li[1, ‡] 

1Department of Mathematics, University of Wisconsin–Madison, 480 Lincoln Drive, Madison, WI 53706, USA 

*mandreou@math.wisc.edu (Corresponding Author) 

†chennan@math.wisc.edu 

‡zjkliyingda@gmail.com 

January 21, 2026 

## **Abstract** 

Data assimilation (DA) combines partial observations with dynamical models to improve state estimation. Filter-based DA uses only past and present data and is the prerequisite for real-time forecasts. Smoother-based DA exploits both past and future observations. It aims to fill in missing data, provide more accurate estimations, and develop high-quality datasets. However, the standard smoothing procedure requires using all historical state estimations, which is storagedemanding, especially for high-dimensional systems. This paper develops an adaptive-lag online smoother for a large class of complex dynamical systems with strong nonlinear and non-Gaussian features, which has important applications to many real-world problems. The adaptive lag allows the utilization of observations only within a nearby window, thus reducing computational complexity and storage needs. Online lag adjustment is essential for tackling turbulent systems, where temporal autocorrelation varies significantly over time due to intermittency, extreme events, and nonlinearity. Based on the uncertainty reduction in the estimated state, an information criterion is developed to systematically determine the adaptive lag. Notably, the mathematical structure of these systems facilitates the use of closed analytic formulae to calculate the online smoother and adaptive lag, avoiding empirical tunings as in ensemble-based DA methods. The adaptive online smoother is applied to studying three important scientific problems. First, it helps detect online causal relationships between state variables. Second, the advantage of reduced computational storage expenditure is illustrated via Lagrangian DA, a high-dimensional nonlinear problem. Finally, the adaptive smoother advances online parameter estimation with partial observations, emphasizing the role of the observed extreme events in accelerating convergence. 

## **1 Introduction** 

Complex turbulent nonlinear dynamical systems (CTNDSs) have broad applications across various fields [ **1, 2, 3** ]. These systems are characterized by their high dimensionality and multiscale structures, with strong nonlinear interactions occurring between state variables at different spatiotemporal scales. Extreme events, intermittency, and non-Gaussian probability density functions (PDFs) are also commonly observed [ **4, 5, 6** ]. 

State estimation in CTNDSs is essential for parameter estimation, prediction, optimal control, and generating complete datasets [ **7, 8, 9** ]. However, the turbulent nature of the dynamics can amplify small errors in the model structure, spatiotemporal solutions, or initial conditions when relying solely on forecasts. Data assimilation (DA), which integrates observations with system dynamics, is widely used to improve state estimation [ **10, 11, 12, 13, 14** ]. Given the inevitable uncertainty in state estimation, especially for the unobserved variables of CTNDSs, probabilistic approaches via Bayesian inference are natural choices. The model provides a prior distribution, while observations inform the likelihood. These are then combined to form the posterior distribution for state estimation. 

DA can be classified into two categories, based on when the observational data are incorporated. Filtering uses observations only up to the current time [ **12, 13, 14** ]. Serving as the initialization, filter-based state estimation is a prerequisite for real-time forecasts. In contrast, smoothing leverages data from the entire observation period [ **14, 15, 16, 17** ], including future data, which makes it highly effective for optimal state estimation in offline data postprocessing. This helps to 

1 

fill in missing values, minimize bias, and create complete datasets [ **18** ]. With the extra information from future observations, smoothing often produces more accurate and less uncertain state estimates than filtering. When the system dynamics and observational mappings are linear, with additive Gaussian noise, the corresponding filtering and smoothing methods are the Kalman(–Bucy) filter and the Rauch–Tung–Striebel (RTS) smoother, respectively [ **15, 19, 20** ], where the posterior distribution is Gaussian and can be computed using closed-form analytical solutions. 

Due to the intrinsic nonlinear dynamics and non-Gaussian statistics of CTNDSs, analytic solutions for DA are rarely available. As a result, various numerical and approximate methods have been developed, including the ensemble Kalman filter/smoother and the particle (or sequential Monte Carlo) filter/smoother [ **13, 14, 21, 22, 23, 24** ]. These methods are widely used but often face tremendous computational costs, especially in high-dimensional systems [ **25** ], which limits the number of particles or ensemble members, potentially causing biases and numerical instabilities [ **26, 27, 28** ]. Empirical tuning techniques, such as noise inflation, localization, and resampling, are widely used in practice to mitigate these issues [ **21, 29, 30, 31** ]. However, these ad hoc tuning methods are usually quite challenging to implement systematically. Closedform analytic solutions for DA are thus highly desirable, as they improve computational efficiency, stability, and accuracy, especially in capturing non-Gaussian features, including intermittency and extreme events. They also facilitate the theoretical analysis of the error and uncertainty during state estimation. 

Instead of refining DA schemes directly, computational challenges in state estimation can be addressed by developing approximate models that yield analytic solutions for the posterior distribution. While linear approximations allow for standard methods like the Kalman filter or RTS smoother, linearizing a strongly nonlinear system often leads to biases and instabilities. An alternative is a recently developed class of nonlinear systems that includes many turbulent models in geophysics, fluids, engineering, and neuroscience [ **32, 33, 34** ]. Despite their nonlinear dynamics and non-Gaussian statistics, the conditional distributions of the unobserved state variables given the observations, which are precisely the posterior distributions in the DA context, are Gaussian, leading to the term conditional Gaussian nonlinear systems (CGNSs). The CGNS framework allows the use of closed analytic formulae for solving these conditional distributions, helping develop efficient algorithms for filtering, smoothing, and sampling without the ad hoc tuning often needed in ensemble-based DA methods. CGNSs have been utilized as surrogate models in various applications, including DA, prediction, preconditioning, and machine learning [ **35, 36, 37** ]. 

The standard smoother-based state estimation procedure involves executing a forward pass for filtering across the entire observational period, followed by a backward pass for smoothing [ **15, 16** ]. However, the standard offline smoother requires storing the filter solution for the entire duration before initiating the backward pass, which requires substantial computational storage, particularly in high-dimensional systems. Due to the wide application of smoother-based state estimation, it is of practical importance to develop a computationally efficient and accurate algorithm that has the potential to significantly reduce storage requirements. 

This paper develops a forward-in-time online smoother algorithm with adaptive lags for the CGNS framework, eliminating the need for a full backward pass. The online smoother sequentially updates the current state as new observations become available. By doing so, it effectively addresses the computational storage issue. While online schemes exist for the RTS smoother and ensemble-based methods, the CGNS online smoother has several unique advantages. First, despite the intrinsic nonlinearity of the underlying dynamics, closed analytic formulae are available to compute the nonlinear online smoother, providing precise and accurate solutions which avoid numerical and sampling errors as in ensemble-based methods. Second, due to the turbulent nature of the system, observations influence the estimated state only within a short time window, which enhances computational efficiency and reduces storage needs. Third, different from fixed-lag smoothers [ **24, 38, 39** ], the lag in the CGNS smoother is adaptively determined. Online lag adjustment is essential for studying turbulent systems, where temporal autocorrelation varies significantly over time due to intermittency, extreme events, and nonlinearity. A fixed lag usually either overuses storage (when overestimated) or introduces a large bias (if underestimated). In contrast, an adaptive lag implicitly optimizes the use of data and computational storage. Finally, the adaptive lag is systematically determined using an information criterion based on the uncertainty reduction in the posterior distribution. It emphasizes the importance of the posterior uncertainty and differs from some of the existing adaptive lag selection criteria that rely solely on the posterior mean [ **40** ]. As closed analytic formulae are available for posterior distributions, the information gain can be computed efficiently and accurately. 

The adaptive online smoother for CGNSs is employed to study three important scientific problems. First, the online update of the smoother estimate allows for quantification of the improvement in state estimation by incorporating future information. This facilitates the inference of causal relationships between the state variables. A nonlinear dyad model 

2 

with strong non-Gaussian features is utilized for such a study. Second, the CGNS framework is applied to Lagrangian data assimilation, which is a high-dimensional nonlinear problem that has a significant storage requirement [ **41, 42, 43** ]. The online smoother allows for the estimation of the unobserved flow states based on Lagrangian tracers. This study highlights the role of the adaptive-lag online smoother in reducing computational storage needs, when compared to its fixed-lag variant. Finally, the online smoother facilitates developing an online parameter estimation algorithm with partial observations. It helps reveal the role of the observed intermittent extreme events in advancing parameter estimation. 

The remainder of this paper is organized as follows. Section 2 introduces the CGNS modeling framework, including the equations for the optimal nonlinear filter and offline smoother state estimation. Section 3 presents the adaptive online smoother. In Section 4, the application of the adaptive online smoother to the three key problems is demonstrated. Section 5 includes the conclusion. The appendices contain the analysis and proofs, as well as additional details. 

## **2 The Conditional Gaussian Nonlinear System Modeling Framework** 

Throughout this paper, **boldface** letters are exclusively used to denote vectors for the sake of mathematical clarity. In this regard, we use **l** owercase boldface letters to denote column vectors, while **U** ppercase boldface letters denote matrices. The only exception to this rule is **W** (with some subscript or superscript), which denotes a Wiener process. Although in this work this always corresponds to a column vector, we instead use an uppercase letter due to literary tradition. 

Let _t_ denote the time variable, with _t ∈_ [0 _, T_ ], where _T >_ 0 is allowed to be infinite. Let (Ω _, F ,_ P) be a complete probability space and _{Ft}t∈_ [0 _,T_ ] to be a filtration of sub- _σ_ -algebras of (Ω _, F_ ), which we assume is augmented (i.e., complete and right-continuous). For every filtration there exists a smallest such augmented filtration refining _{Ft}t∈_ [0 _,T_ ] (known as its completion), so this is without loss of generality. We let � **x** ( _t, ω_ ) _,_ **y** ( _t, ω_ )�, for _t ∈_ [0 _, T_ ] and _ω ∈_ Ω (for the rest of this work we drop the event or sample space dependence for notational simplicity, but it is always implied), be a partially observable ( _S, A_ )-valued stochastic process, where **x** is the observable component, while **y** is the unobservable component. The theory that follows can be applied mutatis mutandis to any partially observable stochastic process that takes values over a measurable space ( _S, A_ ) where _S_ is a separable Hilbert space (finite-dimensional or not) over a complete scalar ground field and _A_ is a _σ_ -algebra of _S_ , but for this work it suffices to consider complex-valued finite-dimensional processes with respect to the usual Euclidean inner product. As such, we let _S_ = C _[k]_[+] _[l]_ and _A_ = _B_ C _k_ + _l ≡B_ R2( _k_ + _l_ ), with **x** being a _k_ -dimensional vector and **y** an _l_ -dimensional one, where _B_ R2( _k_ + _l_ ) is the Borel _σ_ -algebra of R[2(] _[k]_[+] _[l]_[)] , since dimR(C _[k]_[+] _[l]_ ) = 2( _k_ + _l_ ). We assume that 

**==> picture [274 x 14] intentionally omitted <==**

meaning the partially observable random process is (jointly) adapted to the filtration _{Ft}t∈_ [0 _,T_ ], i.e., for all times _t ∈_ [0 _, T_ ] the random vector defined by � **x** ( _t, ·_ ) `[T]` _,_ **y** ( _t, ·_ ) `[T]`[�] `[T]` : Ω _→ S_ is an ( _Ft_ ; _A_ )-measurable function. Specifically, this implies that the natural filtration of _F_ with respect to _{_ **x** ( _s_ ) _}s≤t_ , which is the sub- _σ_ -algebra generated by the observable processes for times _s ≤ t_ and is defined by 

**==> picture [310 x 14] intentionally omitted <==**

satisfies _Ft_ **[x]** _[⊆F][t]_[, since] **[ x]**[ is adapted to the filtration] _[ {F][t][}] t∈_ [0 _,T_ ][by construction and by definition] _[ F] t_ **[x]**[is the smallest such] filtration. We call this natural filtration the observable _σ_ -algebra (at time _t_ ) for the remainder of this work. 

It is known that, at each time instant _t ∈_ [0 _, T_ ], the optimal estimate in the mean-square sense of some measurable function **h** ( _t,_ **x** _,_ **y** ) on the basis of the observations up to time _T[′] ∈_ [ _t, T_ ], _{_ **x** ( _s_ ) _}s≤T ′_ , is exactly its conditional expectation conditioned on the observable _σ_ -algebra at time _T[′]_ , E� **h** ( _t,_ **x** _,_ **y** ) _|FT_ **[x]** _[′]_ �. This is known as the a-posteriori mean and this assertion of optimality rests on the tacit assumption that E� _∥_ **h** ( **x** _,_ **y** ) _∥_[2] 2 � is finite, where _∥·∥_ 2 denotes the usual Euclidean norm over C[dim(] **[h]**[)] [ **32, 33** ]. Usually **h** is a function of the unobserved process **y** and in this work we exclusively use **h** = **y** as to recover the optimal filter and smoother conditional statistics of the hidden process when conditioning on the observations. The goal of optimal state estimation is to characterize the posterior states using a system of stochastic differential equations (SDEs), known as the optimal nonlinear filter or smoother equations depending on whether we condition on current observations or the entire observational period, respectively. In general, without making specific assumptions about the structure of the processes **h** and **x** , determining E � **h** _|FT_ **[x]** _[′]_ � is challenging. CGNSs resolve this by having the key advantage of conditional Gaussian posterior distributions, which can be written down using closed analytic formulae. The linear state-observation system filtered by the classical Kalman–Bucy filter [ **19, 20** ] is the simplest example of a CGNS [ **33, 44** ]. 

3 

Despite the conditional Gaussianity, these coupled systems remain highly nonlinear, with the associated marginal and joint distributions being highly non-Gaussian, which allows the systems to capture many realistic turbulent features. 

## **2.1 Conditionally Gaussian Processes** 

In its most general form, a conditional Gaussian system of processes consists of two diffusion-type processes defined by the following nonlinear system of stochastic differentials given in Itˆo form [ **33, 34** ]: 

**==> picture [444 x 30] intentionally omitted <==**

where 

**==> picture [350 x 14] intentionally omitted <==**

are two mutually independent complex-valued Wiener processes (i.e., both their real and imaginary parts are mutually independent real-valued Wiener processes with standardized covariances) and almost every path of **x** and **y** is in _C_[0][�] [0 _, T_ ]; C _[k]_[�] and _C_[0][�] [0 _, T_ ]; C _[l]_[�] , respectively. The elements of the vector- and matrix-valued functions of multiplicative factors ( **Λ[x]** _,_ **Λ[y]** ), forcings ( **f[x]** _,_ **f[y]** ), and noise feedbacks ( **Σ[x]** 1 _[,]_ **[ Σ]** 2 **[x]** _[,]_ **[ Σ][y]** 1 _[,]_ **[ Σ][y]** 2[)][are][assumed][to][be][nonanticipative][(adapted)][functionals over][the] measurable time-function cylinder 

**==> picture [334 x 21] intentionally omitted <==**

where _⊗_ denotes the tensor-product _σ_ -algebra on the underlying product space, i.e., 

**==> picture [436 x 21] intentionally omitted <==**

with _B_ � _C_[0][�] [0 _, T_ ]; C _[k]_[��] being the _σ_ -algebra generated by the topology of compact convergence on the space of continuous functions from [0 _, T_ ] to C _[k]_ , _C_[0][�] [0 _, T_ ]; C _[k]_[�] . It is important to emphasize here the fact that in a CGNS, the unobservable component **y** enters the dynamics in a conditionally linear manner, whereas the observable process **x** can enter into the coefficients of both equations in any measurably nonlinear way. 

Many CTNDSs fit into the CGNS modeling framework. Some well-known classes of these systems are physicsconstrained nonlinear stochastic models (for example the noisy versions of the Lorenz models, low-order models of Charney– DeVore flows, and a paradigm model for topographic mean flow interaction) [ **45, 46** ], stochastically coupled reactiondiffusion models used in neuroscience and ecology (for example the stochastically coupled FitzHugh–Nagumo models and the stochastically coupled SIR epidemic models), and spatiotemporally multiscale models for turbulence, fluids, and geophysical flows (for example the Boussinesq equations with noise and the stochastically forced rotating shallow-water equation) [ **34** ]. This modeling framework has also been exploited to develop realistic low-order stochastic models for the Madden–Julian oscillation (MJO) and Arctic sea ice [ **37, 47** ]. 

In addition to modeling many natural phenomena, the CGNS framework and its closed analytic DA formulae have been applied to study many theoretical and practical problems. It has been utilized to develop a nonlinear Lagrangian data assimilation algorithm, allowing rigorous analysis to study model error and uncertainty, as well as recovery of turbulent ocean flows with noisy observations from Lagrangian tracers [ **41, 42, 43** ]. The analytically solvable DA scheme has also been applied to the prediction and state estimation of the non-Gaussian intermittent time series of the MJO and the monsoon intraseasonal variabilities, in addition to the filtering of the stochastic skeleton model for the MJO [ **37, 48, 44** ]. Notably, the efficient DA procedure also helps develop a rapid algorithm to solve the high-dimensional Fokker–Planck equation [ **49, 50** ]. Worth highlighting is that the ideas of the CGNS modeling framework and the associated DA procedures have also been applied to develop cheap exactly-solvable forecast models in dynamic stochastic superresolution of sparsely observed turbulent systems [ **51, 52** ], build stochastic superparameterization for geophysical turbulence [ **53** ], and design efficient multiscale DA schemes via blended particle filters for high-dimensional chaotic systems [ **54** ]. 

A set of sufficient regularity conditions needs to be assumed a-priori so that the main results of the CGNS framework can be established. We enforce the same set of assumptions as in the work of Andreou & Chen [ **55** ], which we outline in Appendix A, with the rationale behind the adoption of each one being provided there (and in the references therein). These conditions are sufficient to show that the posterior distributions of the unobserved variables, when conditioning on the 

4 

observational data, are Gaussian, as stated in the following theorem; this is exactly why (2.1)–(2.2) is called a CGNS. For the following, we abuse notation for clarity and instead write � _·_ �� **x** ( _s_ ) _, s ≤ t_ � to indicate the fact that we are conditioning on the observable _σ_ -algebra at time _t_ , � _·_ �� _Ft_ **x** �. 

**Theorem 2.1** ( **Conditional Gaussianity** ) **.** Let � **x** ( _t_ ) _,_ **y** ( _t_ )� satisfy (2.1)–(2.2) and assume that the regularity conditions **(1)** – **(8)** in Appendix A hold. Additionally, assume that the initial conditional distribution P� **y** (0) _≤_ _**α**_ 0�� **x** (0)�1 is (P-almost surely) Gaussian, _Nl_ � _**µ**_ f(0) _,_ **R** f(0)�2, and mutually independent from the Wiener processes **W** 1 and **W** 2, where 

**==> picture [368 x 16] intentionally omitted <==**

with _·[†]_ denoting the Hermitian transpose operator. Furthermore, assume P�tr( **R** f(0)) _<_ + _∞_ � = 1, where tr( _·_ ) denotes the trace operator, meaning that the initial estimation mean-square error between **y** (0) and _**µ**_ f(0) is almost surely finite. Then, for any _tj_ such that 0 _≤ t_ 1 _< t_ 2 _< · · · < tn ≤ t_ , with _t ∈_ [0 _, T_ ], and _**α**_ 1 _, . . . ,_ _**α** n ∈_ C _[l]_ , the conditional distribution P� **y** ( _t_ 1) _≤_ _**α**_ 1 _, . . . ,_ **y** ( _tn_ ) _≤_ _**α** n_ �� **x** ( _s_ ) _, s ≤ t_ � _,_ 

is (P-almost surely) Gaussian. 

_**Proof** ._ This is Theorem 12.6 in Liptser & Shiryaev [ **33** ], which is the multi-dimensional analog of Theorem 11.1. Thorough details are also provided in Kolodziej [ **57** ]. For the analogous result in the case of discrete time (i.e., where the CGNS consists of stochastic difference equations and **x** is observed at discrete times instants), see Theorem 13.3 of Liptser & Shiryaev [ **33** ], with the respective sufficient assumptions given in Subchapter 13.2.1. 

The proof, regardless of continuous- or discrete-time, uses the conditional characteristic function method and a conditional version of the law-uniqueness theorem [ **57, 58** ]. ■ 

## **2.2 Analytically Solvable Filter and Smoother Posterior Distributions** 

With Theorem 2.1 established, it is then possible to yield the optimal nonlinear filter state estimation equations as showed in the following theorem, where the subscript “ f ” is used to denote the filter conditional Gaussian statistics, which appropriately stands for filter. The filter conditional Gaussian statistics are also known as the filter posterior mean and filter posterior covariance under the Bayesian inference dynamics framework. 

**Theorem 2.2** ( **Optimal Nonlinear Filter State Estimation Equations** ) **.** Let the assumptions of Theorem 2.1 and the additional regularity conditions **(9)** , **(11)** , and **(12)** , which are outlined in Appendix A, to hold. Then, for any _t ∈_ [0 _, T_ ], the _Ft_ **[x]**[-measurable Gaussian statistics of the Gaussian conditional distribution] 

**==> picture [204 x 17] intentionally omitted <==**

## defined as 

**==> picture [414 x 15] intentionally omitted <==**

are the unique continuous solutions of the system of optimal nonlinear filter equations: 

**==> picture [515 x 33] intentionally omitted <==**

with initial conditions _**µ**_ f(0) = E � **y** (0)�� **x** (0)� and **R** f(0) = E �( **y** (0) _−_ _**µ**_ f(0))( **y** (0) _−_ _**µ**_ f(0)) _[†]_[��] **x** (0)�, where the noise interactions through the Gramians (with respect to rows) are defined as 

**==> picture [452 x 50] intentionally omitted <==**

Furthermore, if the initial covariance matrix **R** f(0) is positive-definite (P-almost surely), then all the matrices **R** f( _t_ ), for _t ∈_ [0 _, T_ ], remain positive-definite (P-almost surely). 

> 1The event � **y** ( _s_ ) _≤_ _**α**_ = ( _α_ 1 _, . . . , αl_ ) `[T]`[�] is to be understood coordinate-wise: � _j_ = 1 _, . . . , l_ : �Re( _yj_ ( _s_ )) _≤_ Re( _αj_ ) _,_ Im( _yj_ ( _s_ )) _≤_ Im( _αj_ )��. 

> 2Whenever we refer to a complex-valued multivariate Gaussian or normal distribution in this work, we mean a circularly-symmetric one (i.e., with a zero pseudo-covariance or relation matrix) [ **56** ]. 

5 

_**Proof** ._ This is Theorem 12.7 in Liptser & Shiryaev [ **33** ], which is the multi-dimensional analog of Theorems 12.1 and 12.3. Thorough details are also provided in Kolodziej [ **57** ]. For the analogous result in the case of discrete time, see Theorem 13.4 of Liptser & Shiryaev [ **33** ], which outlines the corresponding optimal recursive nonlinear filter difference equations, with the respective sufficient assumptions given in Subchapter 13.2.1. For a martingale-free proof see Theorem 2 in Andreou & Chen [ **55** ] (although it additionally requires assumption **(10)** found in Appendix A, as to pass from the discrete-time filter to the continuous one via a formal limit). ■ 

The form of the filter mean equation can be intuitively explained within the Bayesian inference framework for DA. The first two terms on the right-hand side of (2.3), namely **Λ[y]** _**µ**_ f + **f[y]** , represent the forecast mean, derived from the process of the unobserved variables in (2.2). The remaining terms account for correcting the prior mean state, incorporating information from partial observations. The matrix factor in front of the innovation, or pre-fit measurement residual d **x** ( _t_ ) _−_ ( **Λ[x]** _**µ**_ f + **f[x]** ) d _t_ , is analogous to the Kalman gain in classical Kalman filter theory: ( **Σ[y]** _◦_ **Σ[x]** + **R** f( **Λ[x]** ) _[†]_ )( **Σ[x]** _◦_ **Σ[x]** ) _[−]_[1] . This factor determines the weight of the observations when updating the model-predicted state. Even in cases where the variables **y** of the unobserved process do not explicitly depend on **x** , such as in the Lagrangian DA, the observational process (2.1) still couples the observed and unobserved components. This coupling allows the observations to impact state estimation and correct the forecast. Finally, observe that the equation driving the evolution of the covariance tensor **R** f is a random Riccati equation [ **59, 60** ], since the coefficients depend on the observable random variables **x** . 

As already stated, the CGNS framework also enjoys closed analytic formulae for the recovery of the optimal smoother state estimation. The smoother posterior distribution at time _t ∈_ [0 _, T_ ] exploits the observational information in the entire period [0 _, T_ ] and therefore it allows for a more accurate and less uncertain estimated state compared to the filter solution. Solving the optimal nonlinear smoother equations requires applying a forward pass (filtering) from _t_ = 0 to _t_ = _T_ , which is then followed by a backward pass (smoothing) from _t_ = _T_ to _t_ = 0 [ **14, 15, 16, 17** ]. In the theorem that follows, the optimal nonlinear smoother equations, which run backwards in time, are showed, with the subscript “ s ” denoting the smoother conditional Gaussian statistics, which appropriately stands for smoother. The smoother conditional Gaussian statistics are also known as the smoother posterior mean and smoother posterior covariance under the Bayesian inference dynamics framework. 

**Theorem 2.3** ( **Optimal Nonlinear Smoother State Estimation Backward Equations** ) **.** Let the assumptions of Theorem 2.1 and the additional regularity conditions **(9)** , **(11)** , and **(12)** , which are outlined in Appendix A, to hold. In addition, assume 

**==> picture [348 x 28] intentionally omitted <==**

and define the following auxiliary matrices: 

**==> picture [472 x 32] intentionally omitted <==**

Then, for any _T ≥ t ≥_ 0 ( _t_ running backward), the _FT_ **[x]**[-measurable Gaussian statistics of the smoother posterior distribution] 

**==> picture [186 x 17] intentionally omitted <==**

defined as 

**==> picture [424 x 15] intentionally omitted <==**

are the unique continuous solutions to the system of optimal nonlinear smoother backward differential equations: 

**==> picture [491 x 38] intentionally omitted <==**

The backward-arrow notation in (2.8)–(2.9) is to be understood as: 

**==> picture [502 x 22] intentionally omitted <==**

6 

_←−_ In other words, the notation dd _t·_[corresponds to the negative of the usual derivative, which means the system in (2.8)–(2.9) is] to be solved backward over [0 _, T_ ]. The “starting” values for the smoother posterior statistics, � _**µ**_ s( _T_ ) _,_ **R** s( _T_ )�, are the same as those of the corresponding filter estimates at the endpoint _t_ = _T_ , � _**µ**_ f( _T_ ) _,_ **R** f( _T_ )�. 

_**Proof** ._ This is Theorem 12.10 in Liptser & Shiryaev [ **33** ]. For the analogous result in the case of discrete time, see Theorem 13.12, which outlines the corresponding optimal recursive nonlinear smoother backward difference equations, with the respective sufficient assumptions given in Subchapters 13.2.1 and 13.3.8. For a martingale-free proof see Theorem 3 in Andreou & Chen [ **55** ] (although it additionally requires assumptions **(10)** and **(13)** found in Appendix A, as to pass from the discrete-time smoother to the continuous one via a formal limit). ■ 

## **3 Optimal Online Smoother** 

As aforementioned, the standard smoothing procedure involves a forward pass using a filtering method followed by a backward pass to obtain the optimal smoother state estimation [ **14, 15, 16, 17** ]. Recalculating the smoother statistics from scratch whenever new observations become available is computationally and storage-intensive. Therefore, an online version of the optimal nonlinear smoother, requiring only forward-in-time updates, is highly desirable, as it can update estimated states sequentially with new data. Fortunately, the CGNS framework provides exact, closed-form solutions for deriving an online smoother. These facilitate efficiency and the understanding of the mathematical and numerical properties of the CGNS. 

## **3.1 Optimal Online Forward-In-Time Discrete Smoother** 

We begin by adopting a time discretization scheme, determined by the rate at which observational data arrive, similar to numerical integration. Although our framework allows for irregular observation intervals, for simplicity, we assume the data arrive at a regular, uniform rate, which is common in practice. Thus, observations are available sequentially at times _t_ 0 = 0 _< t_ 1 _< t_ 2 _< · · · < tn < · · · <_ + _∞_ , where ∆ _tj ≡_ ∆ _t_ = _tj_ +1 _− tj,_ for all _j_ . We also assume that ∆ _t_ is sufficiently small to ensure stability and consistency of the discrete-time schemes for numerical integration of the CGNS equations, as well as of the optimal nonlinear filter and smoother equations, thus ensuring their convergence [ **55** ]. 

In what follows, the superscript notation _·[j]_ is used to denote the discrete approximation to the continuous form of the respective vector or matrix functional when evaluated on _tj_ , for example **Λ[x]** _[,j]_ := **Λ[x]** ( _tj,_ **x** ( _tj_ )). We write the CGNS of equations (2.1)–(2.2) in a discrete fashion using the Euler–Maruyama scheme [ **61, 62** ]. Then the time discretization of (2.1)–(2.2) is simply given by 

**==> picture [414 x 34] intentionally omitted <==**

where _**ϵ**[j]_ 1[and] _**[ ϵ]**[j]_ 2[are mutually independent complex standard Gaussian random noises.][The explicit nature and order of the] temporal discretization used here is sufficient for the CGNS framework we are working with, meaning implicit or higherorder discretization schemes are not needed [ **55** ]. 

Given a series of realizations for the observable **x** , � **x**[0] _,_ **x**[1] _, . . . ,_ **x** _[n]_[�] , where **x** _[j]_ was obtained ∆ _t_ time units after **x** _[j][−]_[1] for _j_ = 1 _, . . . , n_ , we let _**µ**_ s _[j,n]_ and **R** _[j,n]_ s denote the discrete smoother posterior mean and the discrete smoother posterior covariance, respectively, when evaluated at time _t_ = _tj_ and conditioned on this realization of **x** up to time _t_ = _tn_ , where 0 _≤ j ≤ n_ (see Theorem 2.3). In other words, we define 

**==> picture [456 x 15] intentionally omitted <==**

Notice how we explicitly note the dependence of the smoother state estimates on the length of the observational period. As is known by the discrete-time counterpart of Theorem 2.1 (see Theorem 13.3 in Liptser & Shiryaev [ **33** ]), the smoother posterior distribution P� **y** _[j]_[��] **x** _[s] , s_ = 0 _, . . . , n_ � is (P-almost surely) conditionally Gaussian, _Nl_ � _**µ**_ s _[j,n][,]_ **[ R]** _[j,n]_ s �, and it is possible to show that the conditional mean _**µ**_ s _[j,n]_ and conditional covariance **R** _[j,n]_ s of the discrete smoother at time step _tj_ when conditioning up to the _n_ -th observation satisfy the following recursive backward difference equations for _n ∈_ N and _j_ = 0 _,_ 1 _, . . . , n −_ 1 (under the regularity conditions **(1)** – **(13)** in Appendix A and all other assumptions thus far) [ **55** ]: 

**==> picture [488 x 16] intentionally omitted <==**

7 

**==> picture [541 x 48] intentionally omitted <==**

**==> picture [471 x 64] intentionally omitted <==**

where 

**==> picture [496 x 34] intentionally omitted <==**

We also note here that in the absence of noise cross-interaction, i.e., **Σ[x]** _◦_ **Σ[y]** _≡_ **0** _k×l_ , (3.5) and (3.6) simplify significantly, where up to leading-order _O_ (∆ _t_ ) their expressions reduce down to [ **55** ]: 

**==> picture [470 x 16] intentionally omitted <==**

Using (3.3)–(3.4), the following theorem outlines the procedure for obtaining an optimal online forward-in-time discrete smoother state estimate for the posterior Gaussian statistics. The proof of this result is provided in Appendix B. 

**Theorem 3.1** ( **Optimal Online Forward-In-Time Discrete Smoother** ) **.** Let � **x** ( _t_ ) _,_ **y** ( _t_ )� satisfy (2.1)–(2.2) and assume the validity of the assumptions in Theorem 2.3 and all regularity conditions outlined in Appendix A, **(1)** – **(13)** . Suppose now the observational data for the observed process, **x**[0] _,_ **x**[1] _,_ **x**[2] _, . . ._ , are given sequentially. When a new observation, denoted by **x** _[n]_ for _n ∈_ N, becomes available, it is utilized to update all the existing optimal state estimates at time instants _tj_ for 0 _≤ j ≤ n −_ 1 and it then provides a new state estimate at _j_ = _n_ . The discrete smoother posterior distribution P� **y** _[j]_[��] **x** _[s] ,_ 0 _≤ s ≤ n_ � is conditionally Gaussian, 

**==> picture [361 x 17] intentionally omitted <==**

and the conditional mean _**µ**_ s _[j,n]_ and conditional covariance **R** _[j,n]_ s for _n ∈_ N and 0 _≤ j ≤ n −_ 1 satisfy the following recursive backward difference equations: 

**==> picture [393 x 33] intentionally omitted <==**

where the update matrix **D** _[j,n][−]_[1] , or **D** _[j,n][−]_[2] after the trivial reindexing _n −_ 1 ⇝ _n −_ 2 in the following (without loss of generality), is defined in a forward-in-time fashion as 

**==> picture [432 x 49] intentionally omitted <==**

where **E** _[j]_ is given up to leading-order in (3.5). For _n ∈_ N we have 

**==> picture [355 x 32] intentionally omitted <==**

with the **b** _[n][−]_[1] and **P** _[n] n[−]_[1] auxiliary residual terms being defined by 

**==> picture [436 x 50] intentionally omitted <==**

for **E** _[n]_ and **F** _[n]_ given up to leading-order in (3.5) and (3.6), respectively. For _j_ = _n_ , we have by definition that _**µ**_ s _[n,n]_ = _**µ**[n]_ f and **R** _[n,n]_ s = **R** _[n]_ f[, since the smoother and filter posterior Gaussian statistics coincide at the end point per Theorem 2.3.] 

8 

Based on this theorem, the algorithm associated with the online forward-in-time discrete smoother update equations (3.10)–(3.11) is outlined in Algorithm 1. There, we use a compact expression for the update matrix **D** _[j,n][−]_[2] , 

**==> picture [356 x 43] intentionally omitted <==**

which is equivalent to (3.12), with the details of this equivalence being shown in Appendix B. (The curved arrow pointing to the right above the product symbol in (3.17) indicates the order or direction with which we expand said product.) 

## **Algorithm 1: Optimal Online Forward-In-Time Discrete Smoother** 

**Data: x**[0] , _**µ**_[0] f[=] _**[ µ]**_ f[(0)][,] **[ R]**[0] f[=] **[ R]**[f][(0)][,][ ∆] _[t]_ **Result:** Discrete Smoother Gaussian Statistics � _**µ**_ s _[j,n]_ �0 _≤j≤n_[and] � **R** _[j,n]_ s �0 _≤j≤n_[for] _[ n][ ∈]_[N] **for** _n ∈_ N **do** Receive new observation **x** _[n]_ after time ∆ _t_ ; Compute _**µ**_ s _[n,n]_ = _**µ**[n]_ f[through (2.3):] _**µ**[n]_ f _[←]_ _**[µ]**[n]_ f _[−]_[1] + ( **Λ[y]** _[,n][−]_[1] _**µ**[n]_ f _[−]_[1] + **f[y]** _[,n][−]_[1] )∆ _t_ + ( **R** _[n]_ f _[−]_[1] ( **Λ[x]** _[,n][−]_[1] ) _[†]_ + ( **Σ[y]** _◦_ **Σ[x]** ) _[n][−]_[1] ) _×_ �( **Σ[x]** _◦_ **Σ[x]** ) _[n][−]_[1][�] _[−]_[1][�] **x** _[n] −_ **x** _[n][−]_[1] _−_ ( **Λ[x]** _[,n][−]_[1] _**µ**[n]_ f _[−]_[1] + **f[x]** _[,n][−]_[1] )∆ _t_ �; Compute **R** _[n,n]_ s = **R** _[n]_ f[through (2.4):] **R** _[n]_ f _[←]_ **[R]** _[n]_ f _[−]_[1] + � **Λ[y]** _[,n][−]_[1] **R** _[n]_ f _[−]_[1] + **R** _[n]_ f _[−]_[1] ( **Λ[y]** _[,n][−]_[1] ) _[†]_ + ( **Σ[y]** _◦_ **Σ[y]** ) _[n][−]_[1] _−_ ( **R** _[n]_ f _[−]_[1] ( **Λ[x]** _[,n][−]_[1] ) _[†]_ + ( **Σ[y]** _◦_ **Σ[x]** ) _[n][−]_[1] )�( **Σ[x]** _◦_ **Σ[x]** ) _[n][−]_[1][�] _[−]_[1] ( **Λ[x]** _[,n][−]_[1] **R** _[n]_ f _[−]_[1] + ( **Σ[x]** _◦_ **Σ[y]** ) _[n][−]_[1] )�∆ _t_ ; Compute **E** _[n][−]_[1] , **b** _[n][−]_[1] , and **P** _[n] n[−]_[1] through (3.5), (3.15), and (3.16), respectively: **E** _[n][−]_[1] _←_ **I** _l×l_ + �( **Σ[y]** _◦_ **Σ[x]** ) _[n][−]_[1][�] ( **Σ[x]** _◦_ **Σ[x]** ) _[n][−]_[1][�] _[−]_[1] **G[x]** _[,n][−]_[1] _−_ **G[y]** _[,n][−]_[1][�] ∆ _t_ ; **b** _[n][−]_[1] _←_ _**µ**[n]_ f _[−]_[1] _−_ **E** _[n][−]_[1][�] ( **I** _l×l_ + **Λ[y]** _[,n][−]_[1] ∆ _t_ ) _**µ**[n]_ f _[−]_[1] + **f[y]** _[,n][−]_[1] ∆ _t_ � + **F** _[n][−]_[1][�] **x** _[n] −_ **x** _[n][−]_[1] _−_ ( **Λ[x]** _[,n][−]_[1] _**µ**[n]_ f _[−]_[1] + **f[x]** _[,n][−]_[1] )∆ _t_ �; **P** _[n] n[−]_[1] _←_ **R** _[n]_ f _[−]_[1] _−_ **E** _[n][−]_[1] ( **I** _l×l_ + **Λ[y]** _[,n][−]_[1] ∆ _t_ ) **R** _[n]_ f _[−]_[1] _−_ **F** _[n][−]_[1] **Λ[x]** _[,n][−]_[1] **R** _[n]_ f _[−]_[1] ∆ _t_ ; Compute _**µ**_ s _[n][−]_[1] _[,n]_ and **R** _[n]_ s _[−]_[1] _[,n]_ through (3.13) and (3.14), respectively: _**µ**_ s _[n][−]_[1] _[,n]_ = **E** _[n][−]_[1] _**µ**[n]_ f[+] **[ b]** _[n][−]_[1][;] **R** _[n]_ s _[−]_[1] _[,n]_ = **E** _[n][−]_[1] **R** _[n]_ f[(] **[E]** _[n][−]_[1][)] _[†]_[ +] **[ P]** _n[n][−]_[1] ; **for** _j_ = 0 : _n −_ 1 **do** ↷ _n−_ 2 **D** _[j,n][−]_[2] _←_ **E** _[i]_ ; � _i_ = _j_ _**µ**_ s _[j,n] ←_ _**µ**_ s _[j,n][−]_[1] + **D** _[j,n][−]_[2][�] _**µ**_ s _[n][−]_[1] _[,n] −_ _**µ**[n]_ f _[−]_[1] �; **R** _[j,n]_ s = **R** _[j,n]_ s _[−]_[1] + **D** _[j,n][−]_[2][�] **R** _[n]_ s _[−]_[1] _[,n] −_ **R** _[n]_ f _[−]_[1] �( **D** _[j,n][−]_[2] ) _[†]_ ; **end end** 

## **3.2 Understanding How the Online Forward-In-Time Discrete Smoother Works** 

Figure 3.1 presents a schematic diagram that intuitively explains how the online smoother operates using forward filtering and backward smoothing estimates. Although the figure focuses on the online discrete smoother mean for brevity, the same logic (as well as subsequent analysis) applies to the smoother covariance. In the diagram, the first superscript index corresponds to rows, while the second corresponds to columns. The discussion centers on the last red dashed box (last column), representing the discrete smoother estimates at the current observation (the _n_ -th observation) over all time instants _j_ = 0 _, . . . , n_ . Each column (fixed second index) illustrates the backward smoothing process for a given batch realization _{_ **x**[0] _, . . . ,_ **x** _[n] }_ , involving a forward pass to compute the filter estimate (Theorem 2.2) and a backward pass to calculate the smoother estimate (Theorem 2.3), indicated by the red arrows. Each row (fixed first index) shows how the discrete online 

9 

smoother estimates at a fixed time _tj_ are updated as new observations arrive sequentially, using the online forward-in-time smoother algorithm. Information flows into _**µ**_ s _[j,n]_ from the filter estimates _**µ**[j]_ f[and] _**[ µ]**_ f _[n]_[.][The former,] _**[ µ]**[j]_ f[, influences it through] forward online-smoothing in its row, transitioning towards _**µ**_ s _[j,n][−]_[1] and to the next columns using the online forward-in-time smoother (3.10). (Through _**µ**_ s _[j,n][−]_[1] , the information in _**µ**[n]_ f _[−]_[1] is also captured via the classical backward smoother in its column.) The latter, _**µ**[n]_ f[, affects it via the backward smoother (3.3) in its column, implicitly through] _**[ µ]**_ s _[n][−]_[1] _[,n]_ in (3.10). These deductions, stemming from Figure 3.1, are explicitly and mathematically expressed by the fact that the amount of updated information incurred at time step _tj_ , due to the new observation **x** _[n]_ , is proportional to the update at _tn−_ 1 via the matrix **D** _[j,n][−]_[2] , since 

**==> picture [310 x 15] intentionally omitted <==**

Essentially, _**µ**_ s _[n][−]_[1] _[,n] −_ _**µ**[n]_ f _[−]_[1] = _**µ**_ s _[n][−]_[1] _[,n] −_ _**µ**_ s _[n][−]_[1] _[,n][−]_[1] amounts to the innovation in the mean stemming from the new observational data, which is then being weighted by the optimal gain tensor **D** _[j,n][−]_[2] . 

**==> picture [375 x 333] intentionally omitted <==**

**----- Start of picture text -----**<br>
f s s s s s<br>f s s s s<br>f s s s<br>: Forward<br>: Backward<br>f s s<br>f s<br>f<br>**----- End of picture text -----**<br>


Figure 3.1: Schematic diagram of how the online discrete smoother update works. Only the smoother mean _**µ**_ s _[·][,][·]_[is depicted;] the same diagram applies to the smoother covariance **R** _[·]_ s _[,][·]_[as well, without loss of generality.] 

## **3.2.1 How the Online Forward-In-Time Discrete Smoother’s Mechanisms Guide the Development of an AdaptiveLag Algorithm** 

It becomes apparent from (3.10)–(3.11) that to understand how the online smoother update works, as well as to figure out how information dissipates through it, we need to study the mathematical properties of the update tensor given in (3.12), or compactly in (3.17), which in turn implies the thorough study of the auxiliary operator 

**==> picture [316 x 16] intentionally omitted <==**

10 

for _j_ = 0 _,_ 1 _, . . . , n −_ 2. Such an analysis will also assist in the formulation of an adaptive lag variant for the online discrete smoother, that implicitly optimizes the use of data for the reduction of the computational overhead. Based on the definitions of (2.6)–(2.7), it is easy to see that 

**==> picture [412 x 16] intentionally omitted <==**

As such, it is immediate by this form of **E** _[j]_ , that if ∆ _t_ is sufficiently small and 

**==> picture [425 x 16] intentionally omitted <==**

where “ _≺_ ” is to be understood in the Loewner partial ordering sense over the convex cone of nonnegative-definite matrices, then by definition the spectral radius of **E** _[j]_ is less than 1 uniformly over _j_ : 

**==> picture [346 x 13] intentionally omitted <==**

Notably, (3.18) is a necessary condition to establish mean-square stability of the smoother Gaussian statistics [ **63, 64, 65, 66** ], as can be clearly seen by the damping in the backward random differential equation that the smoother covariance satisfies in (2.9) of Theorem 2.3, with its discrete counterpart given in (3.4), and where the same damping coefficient also appears in the smoother mean’s linear evolution equation, since after a few algebraic manipulations we have 

**==> picture [404 x 18] intentionally omitted <==**

with its discrete counterpart given in (3.3). Probing into (3.19), note that the filter covariance matrix, **R** _[j]_ f[, reflects uncertainties] in both the unobserved and observed dynamics, as it is conditioned on the current observable _σ_ -algebra. If the observed variables have much less uncertainty than the unobserved process, the eigenvalues of ( **Σ[y]** _◦_ **Σ[y]** ) _[j]_ will be much larger than those of **R** _[j]_[as][suggested][by][discretizing][the][random][Riccati][equation][in][(2.4),][since][the][quadratic][term][is][weighted][by] f[,] **Γ** := ( **Λ[x]** ) _[†]_ ( **Σ[x]** _◦_ **Σ[x]** ) _[−]_[1] **Λ[x]** and then subtracted from the nonnegative-definite stochastic forcing **Σ[y]** _◦_ **Σ[y]** (in the update of the forecast uncertainty). Consequently, by this reasoning and (3.5), the spectrum of **E** _[j]_ should concentrate near the origin and within the unit disk in the complex plane, thus satisfying (3.19). Recalling that the control on the spectrum of **E** _[j]_ is determined by the exponential mean-square stability of the smoother posterior statistics, in this scenario observations become highly informative; they provide sufficient information to update the estimated state over a short time interval, with an exponentially-fast decaying impact at distant past time instants. 

This is further reflected in the spectral radius of the update matrix, **D** _[j,n][−]_[2] , which explicitly determines the influence of the observations on the discrete smoother updates during the recursive backward difference equations in (3.10)–(3.11). Numerical examples, such as the nonlinear dyad-interaction model in Section 4.1, show that even with intermittent instabilities and noise cross-interactions it exhibits an overall exponential decay backwards in time (i.e., in _j_ for each _n_ ), with an accelerating rate under the observance of extreme events in the observed time series. Therefore, any potent adaptive-lag strategy accompanying the forward-in-time online smoother in (3.10)–(3.11) should: 

- (a) Yield larger lag values during the generation of extreme events, where observations significantly inform and contribute to the smoother update, thus quickly resolving the intermittent instabilities. During this observational period (i.e., for these _n_ ), the spectral radius of **D** _[j,n][−]_[2] remains significant (close to 1) for time instants (i.e., for _j_ ) which cover the initiation period of the extreme event. 

- (b) Produce smaller lags at periods of large signal-to-noise ratios in the observed variables, where the prior state estimates from the preceding observations are sufficiently skillful (e.g., during the demise of extreme events). During this observational period (i.e., for these _n_ ), the spectral radius of **D** _[j,n][−]_[2] showcases remarkable rapid exponential decay at time instants (i.e., for _j_ ) prior to and during the extreme event. 

See Panels (g)–(i) of Figure 4.2 and Panels (a)–(c) of Figure 4.5 for numerical examples. 

In general, except in trivial cases where the unobserved state space is one-dimensional (e.g., see Section 3.2.2), condition (3.19) on the constituents of the product defining the update matrix **D** _[j,n][−]_[2] in (3.17) does not guarantee that the update tensor **D** _[j,n][−]_[2] itself will also have a subunit spectral radius for _j_ sufficiently far back from _n −_ 1. (Such a condition is necessary for establishing rigorous mathematical results of convergence for (3.10)–(3.11), and reflects the decaying impact region of **x** _[n]_ 

11 

on **y** _[j]_ ’s online smoother state estimation.) This is because, generally, the spectral radius of a product is not dominated by the product of the associated spectral radii unless rather restrictive conditions are assumed, with sufficient conditions including simultaneous triangularization of the factors over C [ **67** ] (e.g., the factors commute, as a consequence of Gelfand’s theorem) or the factors being radial matrices [ **68** ]. Consequently, predicting how each observation affects state estimation through the online smoother updates can be complex and highly dependent on the specific structure of the CGNS. This variability underscores the need for a simple numerical procedure to assess the impact region of each new observation, as described by the recursive backward difference equations for the discrete smoother posterior Gaussian statistics in (3.10)–(3.11), which in turn aids in constructing an effective adaptive lag strategy for the online smoother. Nevertheless, even in the ideal setting where control on the spectrum of **D** _[j,n][−]_[2] can be established, an online smoother which defines its adaptive lag based on the eigenvalues of the update matrix incurs computational costs in the order of _O_ ( _l_[3] ), which for high-dimensional systems is inexcusable. This is why, in Section 3.4, we develop an information theory-based adaptive-lag approach to the online discrete smoother which efficiently approximates the observational impact region, while implicitly and effectively capturing the essence of the exact method defined by the spectral properties of the update matrix **D** _[j,n][−]_[2] . 

As the system dimension and _n_ increase, the computational overhead for updating the online smoother becomes significant, particularly due to storing the auxiliary matrices needed for calculating the update matrix **D** _[j,n][−]_[2] , specifically the **E** _[j]_ matrices, as well as the filter and online smoother covariance matrices. Additionally, constant recalculation of the covariance tensor can lead to _O_ ( _l_[3] ) computations per update, especially when _k ≈ l_ . Given that the impact of new observations on past states decays exponentially (linked to the aforementioned spectral properties of **D** _[j,n][−]_[2] and **E** _[j]_ ), it is advantageous to develop an adaptive-lag (or fixed-lag) online smoother [ **24, 38, 39** ], where the impact region of or lag at each observation is adaptively computed (or finite and predetermined) based on the dynamical and statistical properties of the CGNS. 

## **3.2.2 Behavior of the Online Forward-In-Time Discrete Smoother for a Two-Dimensional Linear System with Additive Noise** 

To make things more concrete, we show that in the case of a simple two-dimensional linear Gaussian model, the value of **E** _[j] ≡ E[j]_ (which in this case is just a scalar), is necessarily in ( _−_ 1 _,_ 1), thus concretely establishing (3.19) and by extension, due to the one-dimensional observable and unobserved state spaces, leads to **D** _[j,n][−]_[2] _≡ D[j,n][−]_[2] _∈_ ( _−_ 1 _,_ 1) for this specific example. Consider the following two-dimensional linear Gaussian model with additive noise: 

**==> picture [154 x 31] intentionally omitted <==**

where _λx ∈_ R, _λy <_ 0, _σx >_ 0, and _σy >_ 0 are constants and _fx_ ( _t, x_ ) is such that the _x_ -dynamics are stable. As before, _x_ and _y_ are the observed and unobserved variables, respectively. Note that we assume the absence of noise cross-interaction, without loss of generality. Here, due to the linearity of the system, _λy_ needs to be negative in order to guarantee the existence of the statistical equilibrium state of the coupled system when _y_ is assumed to be the unobservable (this also becomes apparent from (3.20) later on) [ **62, 63, 69** ]. Since _λx_ , _λy_ and the noise feedbacks are constant, the equilibrium solution for the filter covariance, _R_ f[eq][, can thus be solved via the following steady state Riccati equation (see (2.4)) [] **[41][,][ 42][,][ 62]**[]:] 

**==> picture [331 x 28] intentionally omitted <==**

which after solving for _R_ f[eq][gives,] 

**==> picture [321 x 28] intentionally omitted <==**

where Ψ = _λ_[2] _y[σ] x_[2][+] _[ λ]_[2] _x[σ] y_[2][.][Observe now that by plugging-in (3.21) into the expression found in (3.18),] 

**==> picture [184 x 14] intentionally omitted <==**

which is stationary in time and simplifies down to _G[y]_ because there is no noise cross-interaction, then we retrieve 

**==> picture [229 x 33] intentionally omitted <==**

12 

**==> picture [297 x 34] intentionally omitted <==**

where we have used the definition of Ψ, the fact that _√_ Ψ + _λyσx_ = ~~�~~ _λ_[2] _yσx_[2] + _λ_[2] _xσy_[2] + _λyσx >_ 0, and that _R_ f[eq] _>_ 0. This validates condition (3.18), for sufficiently small step size ∆ _t_ , and so the auxiliary constant _E[j]_ is always within the interval ( _−_ 1 _,_ 1), meaning (3.19) is satisfied. By extension, since everything is just a scalar, this implies **D** _[j,n][−]_[2] _≡ D[j,n][−]_[2] _∈_ ( _−_ 1 _,_ 1) because of (3.17) (see Appendix B). 

## **3.3 Fixed-Lag Strategy for the Online Smoother** 

The fixed-lag smoother is the simplest method for conserving computational and storage resources, as it assumes a uniformly predetermined impact region for each new observation. Setting an a-priori impact region incurs no additional computational cost. However, this approach has significant drawbacks for most turbulent and complex dynamical systems: it may assign an unnecessarily long fixed lag, wasting storage with diminishing returns in state estimation, or a short fixed lag that introduces substantial biases in the estimated state. Nevertheless, it serves as a building block for the adaptive-lag online smoother. 

The fixed-lag methodology is defined as follows: we assume a predetermined impact region size for each new observation, denoted as lag _L ∈{_ 1 _, . . . , n −_ 1 _}_ in time steps (the edge cases _L_ = 0 and _L_ = _n_ are discussed later). All subsequent measurements can be expressed in simulation time units by multiplying by ∆ _t_ . We also assume that _L_ is uniform across _n_ , the number of observations. The fixed-lag online smoother Gaussian statistics are then given by the following formulae: 

**==> picture [484 x 71] intentionally omitted <==**

with the details of the online discrete smoother being outlined in Algorithm 1 of Section 3.1. For _j_ = _n_ , as already discussed, we always have _**µ**_ s _[n,n]_ = _**µ**[n]_ f[and] **[ R]** s _[n,n]_ = **R** _[n]_ f[.][As such, we have for] _[ ∀][n][∈]_[N][ and] _[ j]_[=][0] _[, . . . , n][ −]_[1][, that] _**[ µ]**[j,n]_ s = _**µ**_ s _[j,n]_[(] _[L]_[)][ and] **R** _[j,n]_ s = **R** _[j,n]_ s[(] _[L]_[)][, where this explicitly denotes the dependence on the predetermined fixed lag value of] _[ L]_[.] We mention here that the edge cases of _L_ = 0 and _L_ = _n_ actually recover the optimal filter and (offline) smoother state estimations, respectively, under the consideration that the current _n_ observations define a complete time series for the observable variables. It is not hard to see why this is the case. Observe that when _L_ = 0, then we only work with the first branch of the definitions for the fixed-lag smoother Gaussian statistics in (3.22) and (3.23), and as such with each new observation we just carry over the estimated state from the corresponding time instant _tj_ at the previous iteration, i.e., from the last observation. As such, since _**µ**_ s _[n,n]_ = _**µ**[n]_ f[and] **[R]** _[n,n]_ s = **R** _[n]_ f[,][for][every] _[n][∈]_[N][0][,][then][it][is][immediate][that][when] _L_ = 0, with each new observation we just carry-on with the forward-pass and calculate the optimal filter Gaussian statistics at the new observation and then carry over all the previous state estimates. But since at each point we are calculating just the filter state, then we are essentially doing a forward-pass as the observations come in, and as such we only recover the filter Gaussian statistics. On the other hand, when _L_ = _n_ , then we only work with the second branch of the definitions for the fixed-lag smoother Gaussian statistics in (3.22) and (3.23), which means that with each new observation we continue the forward-pass and obtain the new filter estimate at the end-point ( _j_ = _n_ ), but using this new state estimation we do a full backward-pass update and obtain the smoother estimates at each and every time instant. As such, we are essentially doing a full forward- and backward-pass with the arrival of each observation, which means we are recovering with each new observational data the offline smoother posterior Gaussian statistics, fully, for this complete observational period. 

## **3.4 Online Smoother with an Adaptive Lag Determined Using Information Theory** 

The adaptive-lag method for defining optimal online smoother state estimates seeks to dynamically determine the impact region of each new observation while minimizing storage costs. To achieve a consistent strategy for calculating the required lag for each observation, we leverage fundamental tools from information theory and the conditional Gaussian structure of the CGNS framework. This approach enables the optimally estimated state from the online forward-in-time discrete smoother to more effectively capture intermittency, extreme events, and nonlinear dynamics that influence the transient behavior of 

13 

complex and turbulent systems. In the following subsections, we first introduce key concepts from information theory, which contribute to the development of the adaptive-lag strategy for the online smoother. 

## **3.4.1 Information Theory Fundamentals: Relative Entropy and the Signal–Dispersion Decomposition** 

Due to the turbulent dynamics, new observational data influence the estimated states through the online smoother update only within a finite time interval, with this impact exhibiting exponential decay over time. Therefore, it is natural to quantify the information gain from applying the optimal online forward-in-time discrete smoother (posterior), with varying lengths of lags, compared to simply carrying forward the previous state estimate (prior). By doing so, the optimal lag can be discovered. We utilize empirical information theory to develop a measure that quantifies this information gain [ **70** ], reflecting the additional information in the posterior distribution beyond the prior [ **71, 72, 73** ]. In the information-theoretic framework, this is naturally achieved through their respective PDFs, by using a certain type of distance function that measures the statistical discrepancy between them. A general class of such functions is known as _f_ -divergences [ **74, 75** ]. 

While the general framework of _f_ -divergences is rather versatile, there is a certain choice of _f_ which takes great advantage of the form of the CGNS framework, and especially of the conditional Gaussianity of the posterior distributions. Specifically, by choosing _f_ ( _z_ ) = _z_ log _z_ , then we recover the so called Kullback–Leibler divergence or relative entropy [ **76, 77** ]. In this case, we denote the divergence with _P_ , and is simply given as [ **78, 79** ] 

**==> picture [354 x 27] intentionally omitted <==**

where the integration with respect to the state vector is to be understood in the Lebesgue sense[3] . For our framework, we read _P_ ( _p, q_ ) as the information gain of _p_ from _q_ , as in the information that has been gained by using the true density _p_ in lieu of the approximation _q_ . The relative entropy enjoys the lucrative properties of non-negativity and of invariance under general nonlinear changes of state variables [ **80** ]. These properties, among others, allow the relative entropy to be widely utilized in assessing the information gain and quantifying model error, model sensitivity, predictability, and statistical response for stochastic CTNDSs [ **81, 82, 83, 84, 85, 86, 87** ]. 

The relative entropy ensures that the extreme events related to tail probabilities are not underestimated. The ratio of the two PDFs within the logarithm quantifies the gap in the tail probability, allowing for an unbiased characterization of statistical differences. Many CTNDSs modeled through the CGNS framework generate intermittent, rare, and extreme events. Thus, using a logarithmic generator function effectively resolves tail probability events, aiding in quantifying information gain for the adaptive lag criterion, uncertainty reduction of posterior solutions, and causal inference. In addition, relative entropy benefits from this logarithmic structure, providing a simple, closed-form formula when both distributions are Gaussian. This is ideal for the online smoother update, where both the prior and posterior distributions are Gaussian, and differ only in their statistics. Consequently, this facilitates the efficient calculation of the adaptive lag, thus further reducing computational costs d d and storage requirements. Specifically, when both P _∼NN_ � _**µ**_ p _,_ **R** p� and Q _∼NN_ � _**µ**_ q _,_ **R** q�, where _N_ = dim( **u** ) is the dimension of the phase space, then the relative entropy adopts an explicit and simple formula [ **2, 82** ]: 

**==> picture [461 x 23] intentionally omitted <==**

where tr( _·_ ) and det( _·_ ) are the trace and determinant of a matrix, respectively. The first quadratic form term in (3.25) is called the signal and measures the information gain in the mean weighted by the model or approximation covariance, whereas the second term is called the dispersion and involves only the covariance ratio **R** p **R** _[−]_ q[1][.][This is why the expression in (3.25) is] known as the signal–dispersion decomposition of the relative entropy for Gaussian variables. 

## **3.4.2 Development of the Adaptive-Lag Strategy for the Online Smoother** 

Here we outline the information-theoretic approach for defining the adaptive lag at the acquirement of a new observation. Let us assume that we have currently observed the _n_ -th measurement, **x** _[n]_ , which is used to update all the existing online smoother Gaussian statistics at time instants 0 _≤ j ≤ n −_ 1, and then provide a new state estimate at _j_ = _n_ . As shown in Theorem 3.1, 

> 3We implicitly assume in (3.24) that _p_ and _q_ are the PDFs of two probability distributions, P and Q, respectively, with P _≪_ Q (i.e., P is dominated by Q), so the integration is taken over the support of _q_ , where both P and Q are dominated by the Lebesgue measure. 

14 

that update happens via (3.10)–(3.11). We would like to define an adaptive lag at the _n_ -observation, _Ln ∈{_ 1 _, . . . , n −_ 1 _}_ , such that only “the most informative or impactful” of these updates are actually carried out, in other words, 

**==> picture [503 x 71] intentionally omitted <==**

with the details of the online discrete smoother being outlined in Algorithm 1 of Section 3.1. For _j_ = _n_ , as already discussed, we always have _**µ**_ s _[n,n]_ = _**µ**[n]_ f[and] **[ R]** s _[n,n]_ = **R** _[n]_ f[.] 

To define the adaptive lag _Ln_ using the information theory principles from Section 3.4.1, we quantify the information gain from updating the state estimate at the _j_ -th time step with the _n_ -th observation, compared to using the estimate from the previous ( _n −_ 1)-st observation. In the CGNS framework, two possible Gaussian distributions arise for the online smoother state estimation. The first, _p[j,n]_ updated[, is the optimal posterior distribution obtained through the online forward-in-time smoother,] discussed in Section 3.1. The second, _p[j,n]_ lagged[, is the prior distribution, where no update is made and the previous state estimate] at time _tj_ is carried over instead. The posterior or the “updated” distribution has Gaussian statistics given by 

**==> picture [400 x 14] intentionally omitted <==**

for its posterior mean and covariance tensor, respectively, as indicated in (3.10)–(3.11). On the other hand, the prior or “lagged” distribution has the corresponding Gaussian statistics of 

**==> picture [104 x 14] intentionally omitted <==**

i.e., no update (or innovation, under the Kalman gain terminology) is being made or procured due to the newly acquired observation. This is precisely described by the first branch in (3.26) and (3.27). 

With the posterior or “updated” conditional Gaussian distribution denoting the true distribution, while the prior or “lagged” conditional Gaussian distribution denotes the approximation due to the adaptive lag (by not carrying out the online smoother update), we can then naturally take advantage of the signal–dispersion decomposition formula for the relative entropy given in (3.25). As such, we have that the information gain or uncertainty reduction incurred by carrying out the update through the online smoother at time _tj_ by using the newly obtained _n_ -th observation, is equal to 

**==> picture [471 x 49] intentionally omitted <==**

where **Q** _[j,n]_ is defined as a covariance ratio matrix 

**==> picture [425 x 33] intentionally omitted <==**

The first term in (3.28) corresponds to the signal, while the latter to the dispersion, terms already introduced in Section 3.4.1. With (3.28)–(3.29) in-hand, we can now outline the procedure for determining _Ln_ . Having a predefined upper lag bound, hereby denoted by _b ∈_ N, we calculate 

**==> picture [184 x 21] intentionally omitted <==**

where _Rn_ := max _{n −_ 1 _− b,_ 1 _}_ , thus totaling 

**==> picture [176 x 33] intentionally omitted <==**

15 

values. Two possible approaches to define the adaptive lag, both yielding similar results after adjusting hyperparameters, are: we can either use the sequence of relative entropies � _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[, or apply the local standard deviation] (LSDev) _{σ[j,n] }Rn≤j≤n−_ 1 to the original entropy sequence and use that instead. The LSDev of the entropy sequence serves as a proxy for the first derivative of the information gain (when estimated via a finite difference scheme), efficiently identifying regions of stagnation or rapid change in it. Specifically _σ[j,n]_ , for a moving window span size of _w ≡_ 1(mod 2), is the standard deviation of the neighborhood centered at the corresponding input value (or pixel in image filtering) over _j_ , extending ( _w −_ 1) _/_ 2 positions to the left and to the right, for each _n_ . This can potentially allow for more effective adaptive lag selection. Both methods behave similarly in most numerical experiments, including all case studies in Section 4, especially when the information gain sequence behaves exponentially with respect to _j_ for each _n_ . In such cases, both the relative entropy and its LSDev exhibit the same growth, making the approaches roughly equivalent. For simplicity, in what follows, we present the adaptive lag procedure using the LSDev. However, the original relative entropy sequence of information gains could also be used directly. Naturally, when using _{σ[j,n] }Rn≤j≤n−_ 1, we additionally have to consider the dependence of the procedure on the window size being used to define the moving LSDev. Taking this into consideration, for a moving window span size of _w ∈_ N _≥_ 3, with _w ≡_ 1(mod 2), which gives _{σ[j,n] }Rn≤j≤n−_ 1 = _{σ[j,n]_ ( _w_ ) _}Rn≤j≤n−_ 1, and a tolerance parameter _δ ∈_ (0 _,_ 1), the definition of the adaptive lag at the _n_ -th observation in this framework is given as 

**==> picture [466 x 21] intentionally omitted <==**

where if no such maximizer exists, then we simply set 

**==> picture [320 x 11] intentionally omitted <==**

(Throughout all numerical case studies in this work, we set _w_ = 7 which is MATLAB’s default value for stdfilt().) Notice that for larger values of _δ_ we allow for more relaxed or smaller lags, while for smaller tolerance values we push the adaptive lag values towards their predefined upper bound, _b_ . Per our methodology, and as noted in (3.30), we have that _∀n ∈_ N, _Ln ∈{_ 0 _,_ 1 _, . . . , b}_ . 

As aforementioned, it is possible to instead use the sequence of information gains directly to define the adaptive lag, 

**==> picture [445 x 20] intentionally omitted <==**

where again if no such maximiser exists we simply use (3.31). For most cases this approach leads to the same results after a slight modification to the tolerance parameter being used (and for appropriate values of _w_ in (3.30); see the numerical results in Figure 4.5 of Section 4.2, where both _σ[j,n]_ and _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged� behave as _C_ 1 _[n][e][C]_ 2 _[n][j]_ for _Rn ≤ j ≤ n −_ 1 and _C_ 1 _[n][, C]_ 2 _[n][>]_[ 0][). In such settings, if we use] _[ δ]_[=] _[ O]_[(10] _[−][d]_[)][ with the sequence of local standard deviations, for] _[ d][ ∈]_[N][, then we can] get similar results when using the original sequence of relative entropies by using _δ_ = _O_ (10 _[−][d]_[+] _[s/]_[2] ) where _s ∈_ N is defined through the time step as ∆ _t_ = _O_ (10 _[−][s]_ ), since the former is approximately the first derivative of the latter with respect to the time step, as already mentioned. Furthermore, the simplicity and flexibility of the adaptive lag framework in (3.30) or (3.32) further allows for the inclusion of a penalty for large lag values. This is achieved by modifying the criterion (e.g., by using a monotonic polynomial of time as the penalization) and then choosing the largest lag for which this penalized information gain (or its penalized local standard deviation) remains small under the tolerance _δ_ , while prioritizing smaller lags. It is important to note here that in practice, i.e., from a computational standpoint, the adaptive lag in (3.30) and (3.32) is calculated by a backtracking search approach, where _j_ starts from _n −_ 1 and moves backwards towards _Rn_ until the condition in (3.30) or (3.32) is met. Therefore, it is not required to calculate the full � _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[or] _{σ[j,n] }Rn≤j≤n−_ 1 sequences and then identify the corresponding (arg)max. 

## **4 Applications of the Adaptive-Lag Online Smoother** 

This section demonstrates the application of the online smoother in addressing three key scientific challenges: (a) state estimation and causality detection, especially in the presence of intermittency and extreme events, (b) evaluating computational and storage efficiency in a high-dimensional Lagrangian data assimilation application, and (c) developing an online parameter estimation algorithm with partial observations. 

16 

The simulations for all the numerical experiments in this work were carried out on an AMD Ryzen[TM] 7 5800H mobile CPU of 8 cores, 16 threads, with an average clock speed of 3.2 GHz (turbo boosts up to 4.4 GHz), with a TDP of 45W. In terms of memory, a two-memory-module configuration was used, with 2x16GB DDR4 RAM sticks at 3200MT/s. 

## **4.1 Detecting Causal Evidence Using the Adaptive-Lag Online Smoother** 

Causal inference helps identify the mechanisms that drive the dynamics of a system. It advances more accurate predictions, better control, and improved decision-making under uncertainty [ **88, 89** ]. It also reveals the role of extreme events and intermittency in modulating the dynamical evolution of the underlying system. By clarifying cause-effect relationships, causal inference enhances our ability to model, simulate, and intervene in complex systems. This subsection demonstrates how the adaptive online smoother and the associated information gain, using a simple nonlinear dyad model, can reveal causal links by showing how time-delayed information in one process improves state estimation in another. The model generates intermittency and extreme events, and the smoother identifies how long temporal information is needed for causal detection during different phases. 

The dyad model considered here is the following stochastic model with quadratic nonlinearities, multiplicative and crossinteracting noise, and physics-constraints (energy conservation in the quadratic nonlinear terms): 

**==> picture [430 x 31] intentionally omitted <==**

where all parameters are constants, with _du, dv, σu, σv >_ 0, and _γ, σvu, Fu, Fv ∈_ R, while _Wu_ and _Wv_ are two mutually independent Wiener processes. In (4.1)–(4.2), The variable _u_ represents an observed or resolved mode in the turbulent signal, interacting with the unresolved mode _v_ through quadratic nonlinearities. As _v_ influences the damping of _u_ , variations in _v_ cause the time series of _u_ to display intermittency and extreme events. The system (4.1)–(4.2) fits exactly the CGNS framework in (2.1)–(2.2), with **x** = _x_ := _u_ and **y** = _y_ := _v_ . The following parameter values are used for this numerical case study: 

**==> picture [206 x 27] intentionally omitted <==**

The parameters are assigned to induce intermittent and extreme events in the observable variable _u_ through the stochastic damping generated by the unobserved variable _v_ , with the goal of producing highly non-Gaussian PDFs for both observable and unobserved dynamics. These values are also chosen to address potential issues of observability [ **12, 90, 91** ], which is linked to causal detection using the adaptive online smoother. The coupled system in (4.1)–(4.2) loses practical observability when the observed process _u_ provides no information about the unobserved variable _v_ . Intuitively, this occurs during phases where _u ≈_ 0, rendering _v_ ineffective in contributing to the dynamics of _u_ . A numerical integration time step of ∆ _t_ = 0 _._ 005 is used, which also defines the uniform rate of obtaining the observations for the online smoother, with a total simulation time of _T_ = 60 units. 

Figure 4.1 presents various plots comparing the filter and offline smoother posterior estimated states at different levels (this is equivalent to an online smoother which uses _Ln_ = _n_ at each _tn_ = _n_ ∆ _t_ , where _n_ is the current number of observations; see Section 3.3). Panel (a) displays the trajectory of the observed variable _u_ , while Panel (b) displays that for the unobserved variable _v_ . For the latter, we also include the posterior means calculated using Theorems 2.2 and 2.3, along with the first two standard deviations away from the mean, represented by accordingly colored shaded regions. The posterior estimated states overall follow the true values with relatively low uncertainty. As expected, the smoother provides a more accurate estimation during the uncertain quiescent periods of the unobserved variable. During the extreme events which are characterized by a high signal-to-noise ratio, both methods lead to smaller uncertainty. Panel (c) plots the information gain of the filter and smoother posterior distributions relative to the prior statistical attractor (or equilibrium distribution) of _v_ on a logarithmically scaled y-axis. Since both the equilibrium (computed numerically using many long simulated trajectories; see Panel (f)), _p_ att( _v_ ), and posterior distributions (at each time instant) are Gaussian, the information gain in Panel (c) is calculated using the signal–dispersion decomposition formula of relative entropy in (3.25). The temporal evolution of relative entropy reveals that the information gain from the smoother posterior Gaussian distribution is almost everywhere larger than that from the filter solution, as is expected. Notably, the information gain corresponding to the onset of the intermittent phases of _u_ shoots 

17 

up due to the strong signal-to-noise ratios. Note that the information gain using the smoother is more significant than the filter at these phases and the more uncertain quiescent phases due to additional observational information. Panel (d) shows the time-averaged PDF of _u_ generated by its signal over _t ∈_ [20 _,_ 60], alongside the corresponding Gaussian fit, i.e., the normal distribution with the same mean and standard deviation as the truth over the associated period. Due to the intermittent extreme events, we can discern that the induced density is highly non-Gaussian, with an apparent positive skewness and a heavy tail. Panel (e) is the same as (d) but for _v_ , which also includes the densities corresponding to the filter and smoother solutions. We can again see that the density corresponding to _v_ displays some non-Gaussian features. Furthermore, as is expected, the PDF of the smoother solution is better equipped to approximate that of the truth compared to the filter one by better resolving the tail behavior and first few ordered moments. 

**==> picture [541 x 311] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Time Series of u (Observed) (d) Time-Averaged PDF of u<br>1.5<br>u<br>3 Gaussian Fit<br>1<br>2<br>1<br>0.5<br>0<br>0<br>-1 0 1 2 3<br>u<br>(b) Time Series of v (Unobserved) with the Filter and Smoother Solutions (e) Time-Averaged PDF of v<br>1.5<br>2 Truth Filter Smoother 2Std Filter 2Std Smoother du/γ TruthGaussian Fit<br>1 Filter<br>0 Smoother<br>0.5<br>-2<br>-4 0<br>-3 -2 -1 0 1 2<br>(c) Information Gain of Filter and Smoother Beyond the Prior Statistical Attractor of v (f) PDF of Prior Statistical Attractor of v<br>0.6<br>Attractor of v<br>10 [0]<br>Gaussian Fit<br>0.4<br>0.2<br>Filter Smoother<br>10 [-5] 0<br>20 25 30 35 40 45 50 55 60 -3 -2 -1 0 1 2<br>t v<br>u<br>p(u)<br>v<br>p(v)<br>(v)<br>att<br>p<br>Relative Entropy<br>**----- End of picture text -----**<br>


Figure 4.1: Panel (a): Trajectory of the observable variable _u_ . Panel (b): True trajectory of the unobserved variable _v_ (in blue), alongside the filter (in green) and offline smoother (in red) posterior mean time series. Their respective first two standard deviations away from the mean state are also plotted through correspondingly colored shaded regions, with the standard deviation in this case being exactly equal to the square root of the respective posterior covariance. The threshold above which _v_ acts as anti-damping to _u_ , i.e., the line _y_ = _du/γ_ = 1 _/_ 6, is also plotted in a dashed black line. Panel (c): Temporal evolution of the information gain of the filter and smoother posterior Gaussian statistics beyond the statistical attractor of the unobserved variable. This is calculated using the signal–dispersion decomposition of the relative entropy in (3.25). A logarithmic scale is used for the y-axis. Panel (d): Time-averaged PDF of _u_ calculated using the observations over _t ∈_ [20 _,_ 60] (in black), alongside its Gaussian fit density defined by the mean and standard deviation of the signal in the same time period (in dashed magenta). Panel (e): Same as (d) but for the unobserved variable _v_ , together with the PDFs corresponding to the filter and smoother posterior mean time series. Panel (f): PDF of the unobserved variable’s prior statistical attractor, _p_ att( _v_ ). 

Figure 4.2 focuses on a shorter intermittent period � _t ∈_ [32 _._ 5 _,_ 40]�) to assess the performance of the adaptive-lag online smoother using the original sequence of information gains, � _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[, with hyperparameters] _[ b]_[ = 600] (which corresponds to _b_ ∆ _t_ = 3 simulation time units) and _δ_ = 10 _[−]_[4] . For this case study, similar results can be obtained when instead using the LSDev sequence, _{σ[j,n] }Rn≤j≤n−_ 1, as already discussed in Section 3.4.2, by appropriately adjusting 

18 

_δ_ (see also Panel (g) of Figure C.1). Panel (a) shows the signals of _u_ and _v_ over this period, while Panels (b)–(f) illustrate how the online smoother adjusts its state estimation as new observations arrive at five different time instants during this period. The online smoother is compared against the filter solution, which can also produce real-time estimated states with the sequential arrival of observations. We focus on Panels (c) and (d). When using the filter solution, the estimation of _v_ before _u_ reaches the peak of the extreme event contains significant errors. This is because the growth of _v_ , once it exceeds the threshold of _du/γ_ = 1 _/_ 6 to become anti-damping, triggers the extreme event in _u_ (the cause). However, the extreme event (the effect) does not appear instantly, thus introducing a delay in the onset of these instabilities. This is why at _t_ = 36 _._ 50 (Panel (c)), without seeing the future information from the development of the extreme event, the causal variable _v_ cannot be accurately recovered by the filter. By extension, due to the data from the extreme event in the observed signal simply not being available yet at the current time instant, this, in a sense, contaminates the online smoother state, which faithfully follows the filter one regardless of how long the adaptive lag is. Nevertheless, at _t_ = 37 _._ 00 (Panel (d)), with the observed trajectory currently undergoing the effects of the instability caused by _v_ , this allows the adaptive online smoother, which utilizes future information for state estimation unlike the filter one, to correct its previous estimated states based on the value of the calculated adaptive lag, at most for _b_ ∆ _t_ = 3 time units into the past. This is explicitly seen by the online smoother posterior mean, which now better approximates the true signal compared to its state half a time unit ago, thus demonstrating its property to systematically correct biases when future data become available. This attribute is crucial to help identify the current state, therefore, outperforming the filter solution. This crucial discrepancy between the filter and online smoother estimates reveals that information in the dynamics flows from the current state of the unobserved variable (cause) to the future state of the observed one (effect), highlighting a causal relationship between these states. Panel (g) presents the adaptive lag values generated during this period, from using the sequence of information gains or relative entropies as outlined in (3.32) and (3.31). The lag in the online smoother likewise reflects the aforementioned time delay in the causal relationship, with a peak in adaptive lag values at the onset of the extreme event, i.e., the causal period. These are essential to correct past errors and effectively recover the state of the cause _v_ , which triggered the extreme event. In contrast, smaller lag values are needed during the effect period, specifically during the demise of this intermittent event, which is characterized by a high signal-tonoise ratio where both the filter and smoother estimates can effectively capture the relatively deterministic behavior. As such, lower adaptive lag values are required since the “lagged” distribution in (3.28) can yield a quickly decaying information gain function as _j_ decreases from _n −_ 1 to _Rn_ (or to an already small sequence of information gains for these values of _n_ , i.e., below the threshold parameter _δ_ uniformly in _j_ ), thus leading to small values for _Ln_ in (3.32). After all, the lag essentially functions as an interpolation between the past state estimates and a “full” (since _b_ limits how much into the past we can correct) backward-run smoother solution of the online smoother. As such, a close-to-zero lag value signifies that more trust is put in the statistics from the previously calculated online posterior distributions since the observations obtained during this period have tiny impact regions. 

Recall that _P p[j,n]_[defined by (3.28)–(3.29),][is used to determine the adaptive lags depicted] � � updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[,] in Panel (g) (via (3.32) and (3.31)). We define the standardization of this sequence in the following manner: 

**==> picture [470 x 45] intentionally omitted <==**

(Other forms of standardization yield similar results, i.e., by dividing by the standard deviation instead of the maximum over _j_ .) The standardization of the sequence of its LSDevs, _{σ[j,n] }Rn≤j≤n−_ 1, is similarly defined. Henceforth, when we refer to the standardized variant of these sequences, we imply the sequence in _j_ and _n_ defined by (4.3). 

In Panel (h) of Figure 4.2, the standardized sequence of information gains or relative entropies (as defined in (4.3)) is plotted, on a logarithmic scale, as a function of _n_ (for _n_ ∆ _t ∈_ [32 _._ 5 _,_ 40]) and of _n_ ∆ _t − j_ ∆ _t_ (for _j_ ∆ _t ∈_ [ _Rn_ ∆ _t, n_ ∆ _t_ ]). (As a reminder, for the _n_ -th observation of _u_ , the last index _j ∈{Rn, . . . , n −_ 1 _}_ for which _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged� remains below the tolerance value of _δ_ = 10 _[−]_[4] , is _n −_ 1 _− Ln_ .) Of significance here is the observational interval of _n_ ∆ _t ∈_ [35 _._ 5 _,_ 37 _._ 5], which covers the cause and effect of the extreme event. Up until around _t_ = 37 _._ 00, which is on the cusp of the extreme event’s completion and _u_ ’s subsequent decline, the cause is fully captured with a persisting standardized information gain throughout the period which generated said extreme event. This explains the increasing and large adaptive lags leading up to the extreme event (i.e., during its generation), depicted in Panel (g). But, as soon as the effect in _u_ , generated by _v_ , ceases to exist after _t_ = 37 _._ 00, then a causal role reversal is initiated, with _u_ now being the significant factor in the system’s 

19 

dynamics and in driving _v_ ’s decrease or damping via the _−γu_[2] term. As a result, the standardized information gain shows an extremely rapid decay during this regime-switch period, where the high signal-to-noise ratio leads to negligible impact regions for the observations of _u_ on _v_ ’s online smoother state estimation (into the past, during updates). This has the ulterior outcome of smaller adaptive lag values during this period, as shown in Panel (g), compared to the other periods. Importantly, this behavior persists over the following quiescent period, whenever _n_ ∆ _t − j_ ∆ _t_ bridges over and before _t_ = 37 _._ 00. 

Finally, in Panel (i) of Figure 4.2, the spectral radii of the update matrices **D** _[j,n][−]_[2] = _D[j,n][−]_[2] (i.e., their absolute value), are plotted in the same manner as the standardized information gains shown in Panel (h) (though, not standardized). First, it is important to note that for all _j_ and any _n_ the spectral radii of the update matrices stay below the threshold of 1, which ensures the convergence of the online smoother as an iterative contraction mapping. Second, the spectral radii, or in this trivial case of a one-dimensional latent state space, the absolute value of the update operator **D** _[j,n][−]_[2] = _D[j,n][−]_[2] , for every _n_ , behaves overall as an exponentially decreasing function as _j_ decreases down from _n −_ 1 (or as _n − j_ increases from 0), which indicates the exponential decrease of the impact region of each new observation by the turbulent dynamics, as discussed in Section 3.2.1. As discussed in the prequel and observed in Panel (h), similarly here for _n_ values such that _Rn_ ∆ _t ≤ j_ ∆ _t ≤_ ( _n −_ 1)∆ _t_ covers an extreme event, the emergence of an instability in the observed signal induces a rapid regime switch and an additional steep exponential decrease in the spectral radius values, i.e., the exact influence region of this observation, for when _j_ passes through these intermittent periods. Finally, and most remarkably, is the fact that the information-based criterion we have developed in Section 3.4.2, after standardization, showcases an impressively similar temporal behavior (both in observational (in _n_ ) and natural (in _j_ ) time), with slightly differing scales, as the exact metric that defines the observations’ impact or influence region on online smoother state estimation, that being the spectral radii of the update operators (see also Figure 4.5). This is true not just during extreme events, as already discussed, but also during quiescent periods. This provides strong numerical corroboration for our methodology of defining the adaptive lag as an extremely cheap (when compared to the exact method) yet effective approach. 

For completeness, since a study into the trade-off between the computational and storage-wise complexity and lowerorder pathwise error of the fixed- and adaptive-lag online discrete smoother solutions is provided for the high-dimensional Lagrangian data assimilation problem in Section 4.2 (see Figure 4.4), a similar analysis for this dyad-interaction model is also carried out. It illustrates the computational storage advantages of the adaptive-lag online smoother compared to its fixed-lag variant, for a model defined by intermittent instabilities rather than high dimensionality. See Figure C.1 in Appendix C. 

## **4.2 Lagrangian Data Assimilation of a High-Dimensional Flow Field** 

Lagrangian data assimilation (LDA) is a specialized method that utilizes the trajectories of moving tracers (e.g., drifters or floaters) as observations used to recover the unknown flow field driving their motion [ **41, 42, 92, 93, 94** ]. Unlike Eulerian observations, which are fixed at specific locations, Lagrangian drifters track the movement of fluid parcels over time [ **95, 96, 97** ]. This approach is particularly valuable for recovering ocean states in the mid-latitude using floats or in marginal ice zones using sea ice floes as Lagrangian tracers [ **47, 98, 99** ]. However, due to the high dimensionality of the state space of the flow field, which is characterized by a large number of spectral modes or high-resolution mesh grids, running a forward-backward offline smoother for state estimation becomes computationally infeasible. Consequently, the adaptive online smoother is essential in practical applications. 

The coupled tracer-flow model is given as follows, 

**==> picture [474 x 12] intentionally omitted <==**

**==> picture [474 x 14] intentionally omitted <==**

**==> picture [475 x 26] intentionally omitted <==**

where **x** _ℓ_ and **v** _ℓ_ denote the location and velocity of the _ℓ_ -th tracer, respectively, with _ℓ_ = 1 _, . . . , L_ , while **u** ( _t,_ **x** ) is the ocean velocity field expressed through a spectral decomposition in its geostrophically balanced or potential vortical incompressible modes, using a Fourier basis in the doubly-periodic spatial domain [ _−π, π_ ] [ **100** ]. The governing equations of the Fourier coefficients _u_ ˆ **k** are expressed through a set of linear stochastic processes, where **k** _∈ K_ denotes the Fourier wavenumber with _K_ = [ _−K, K_ ][2] _∩_ Z[2] for _K ≥_ 1 denoting the two-dimensional discrete lattice collection of Fourier wavenumbers. Note that the stochastic noise mimics the turbulent effects of nonlinearity present in many practical systems, such as the quasi-geostrophic (QG) ocean model. This approximation is justified in many applications [ **41, 42** ]. Since the primary goal 

20 

**==> picture [541 x 358] intentionally omitted <==**

**----- Start of picture text -----**<br>
(b) t = 34.00 (c) t = 36.50<br>4 [(][a][)][ Real-Time Filter vs. Online Smoother]<br>Observed Trajectory of u 2 2<br>2<br>0 0<br>0<br>-2 -2<br>-2<br>-4 -4 -4<br>Truth Filter Online Smoother 2Std Filter 2Std Online Smoother<br>(d) t = 37.00 (e) t = 38.50 (f) t = 40.00<br>2 2 2<br>0 0 0<br>-2 -2 -2<br>-4 -4 -4<br>33 34 35 36 37 38 39 40 33 34 35 36 37 38 39 40 33 34 35 36 37 38 39 40<br>t t t<br>10 [-7] 10 [-6] 10 [-5] 10 [-4] 10 [-3] 10 [-2] 10 [-1] 10 [0]<br>(g) Adaptive Lag (in Time Units) for δ = 10 [-4] (h) Standardized Info Gain Criterion (i) Spectral Radii of the Update Matrices D [j, n-2]<br>2.5 0 0<br>2<br>1 1<br>1.5<br>1<br>2 2<br>0.5<br>0 3 3<br>33 34 35 36 37 38 39 40 33 34 35 36 37 38 39 40 33 34 35 36 37 38 39 40<br>t nΔt (Observational Time) nΔt (Observational Time)<br>Δt<br>Ln nΔt-jΔt<br>**----- End of picture text -----**<br>


Figure 4.2: Panels (a)–(f): Real-time comparison between the filter posterior mean time series (in green) and the one generated from the adaptive-lag online smoother strategy by Theorem 3.1 (in purple). The observed trajectory of _u_ is plotted in Panel (a) (in black), while the true trajectory of _v_ is showed in all panels for reference (in blue). Panel (g): Adaptive lag values (measured in time units, i.e., _Ln_ ∆ _t_ ) generated by the algorithm defined in Section 3.4.2, specifically through (3.32) and (3.31) (i.e., using the original sequence of relative entropies). Panel (h): Standardized information gain criterion in (4.3) as a function of _n_ (for _n_ ∆ _t ∈_ [32 _._ 5 _,_ 40]) and of _n_ ∆ _t − j_ ∆ _t_ (for _j_ ∆ _t ∈_ [ _Rn_ ∆ _t, n_ ∆ _t_ ]). Plotted on a logarithmically scaled colormap. Panel (i): Same as Panel (h) but for the spectral radii of the update values _D[j,n][−]_[2] , i.e., _|D[j,n][−]_[2] _|_ . Panels (h) and (i) share the same colorbar, and have their y-axis flipped. 

is to illustrate the effectiveness of the online smoother, this simplification is employed in the study here. By treating all the **x** _ℓ_ as the observational variables and all the **v** _ℓ_ and _u_ ˆ **k** as the variables for state estimation, the LDA system in (4.4)– (4.6) belongs to the CGNS family. The parameter values in this simulation are the following. The wavenumber bound is _K_ = 2, such that there are in total 25 modes after excluding the zeroth mode, which corresponds to a time-varying random background mean sweep, or background velocity field. The total simulation time is _T_ = 5 with the numerical integration time step (also the observational time frequency) being ∆ _t_ = 0 _._ 005. The total number of tracers is _L_ = 18. The model parameters are _f_ **k** ( _t_ ) = 0 _._ 15 _e_[5] _[πit]_ , **Σ[x]** _[ℓ]_ = 0 _._ 005 _π_ **I** 2 _×_ 2, _β_ = 1, **Σ[v]** _[ℓ]_ = 0 _._ 1 **I** 2 _×_ 2. The damping and noise coefficients _d_ **k** = _d−_ **k** and _σ_ **k** = _σ−_ **k** are randomly drawn from _U_ �[0 _._ 5 _,_ 1 _._ 5]� and _U_ �[0 _._ 15 _,_ 0 _._ 25]�, respectively, with the conjugacy condition establishing the reality of the underlying velocity field [ **41, 42** ]. 

Figure 4.3 demonstrates the posterior state estimates using the filter (Theorem 2.2) and smoother (Theorem 2.3) in recovering the underlying ocean flow field and the tracer velocity vectors. Note that the amplitudes for the ocean flow field (in blue) and tracer velocity (in the hot colormap) quiver plots are not shown on the same scale. Panels (a)—(c) compare the spatial recovery of the ocean state and tracer velocity vectors at _t_ = 2. Both methods effectively reconstruct the tracer movement in direction and magnitude, with the smoother being slightly more effective. As for the flow velocity field, the smoother exhibits a much higher skill in its recovery compared to the filter solution. This is further illustrated in Panels 

21 

(d)-–(e), where we compare the true time series with the filter and smoother posterior mean states over the observational period for the real part of the ocean Fourier mode **k** = (2 _, −_ 1) `[T]` of the ocean, and the zonal velocity of tracer #1 (noted in Panels (a)–(c)). We can see that the smoother follows the truth more closely and with less uncertainty for both cases. This is observed uniformly among all Fourier modes and all tracer velocity vectors. 

**==> picture [540 x 278] intentionally omitted <==**

Figure 4.3: Panel (a): True state of the underlying flow field at _t_ = 2, where the colormap shows the amplitude and the quiver plot represents the velocity field. It is superimposed by the location of the tracers and their velocity vectors. The magnitudes of the quiver plot for the ocean’s velocity field and velocity vectors for the tracers are on distinct scales. Panels (b)–(c): Similar to (a), but corresponding to the estimated state from the posterior mean, calculated through the filter and smoother, respectively. Panels (d)–(e): Comparison between the true time series (in blue) and the posterior mean time series of the filter (in green) and smoother (in red) solutions for the real part of the ocean Fourier mode **k** = (2 _, −_ 1) `[T]` and zonal velocity of tracer #1 (labeled in Panels (a)–(c)). 

Figure 4.4 compares the computational time (in seconds) and storage requirements (in gigabytes) for the fixed- and adaptive-lag strategies of the online smoother. (For details on how the storage and time values in Panels (a), (b), (d), and (e) are calculated, see Appendix D.) Additionally, we present the normalized root-mean-square error (NRMSE) between the posterior mean time series and the truth as to assess the pathwise accuracy of these methods. The normalized RMSE is computed by dividing the RMSE (calculated in the temporal direction) by the standard deviation of the true signal [ **101, 102** ], such that the NRMSE indicates an error level comparable to the equilibrium variability. This metric is evaluated as a function of the fixed lag and tolerance parameter _δ_ and showed on a logarithmically scaled x-axis, where for the latter a maximum lag bound of _b_ = 300 (corresponding to _b_ ∆ _t_ = 1 _._ 5 simulation time units) is applied throughout, with the sequence of entropies used to define the adaptive lags (i.e., (3.32) and (3.31)). Panels (a) and (b) display the fixed-lag results, while Panels (d) and (e) display the adaptive-lag ones. To provide robust results, computational times in Panels (b) and (e) are averaged over multiple runs to reduce external fluctuations. For the fixed-lag smoother, both storage and time increase algebraically (e.g., linearly) with lag, while the NRMSE converges exponentially, at a significant rate, from the filter solution (zero lag) to the one offline smoother one (maximum lag), indicating the sufficiency of using an overall short lag to significantly save on computational storage for this specific problem instance. On the other hand, the storage needs of the adaptive-lag smoother remain constant with respect to _δ_ , since a fixed _b_ is being used in all cases, while computational time increases algebraically to logarithmically as _δ_ approaches zero. The former result showcases how the adaptive-lag online smoother implicitly minimizes storage requirements when compared to the fixed-lag variant, since for _b_ fixed _δ_ can decrease freely to improve 

22 

the recovery skill, with storage needs remaining unaffected. Note how by using a _b_ ∆ _t_ value close to the uniform impact region of the observations in this LDA problem for a target pathwise recovery skill (e.g., _b_ ∆ _t ≈_ 0 _._ 35 for a target NRMSE of around 0 _._ 35, where we have diminishing returns with decreasing _δ_ ; see Panel (a) in Figure 4.5), there is a potential for significant storage savings to be had in this approach. Of course, the computational time spent unavoidably increases with decreasing _δ_ , since more linear-search checks in (3.32) (or (3.30)) need to be carried out. In Panel (e) we also note at each data point on the time plot the percentage of time spent on the calculation of the adaptive lag (also averaged over many runs); in this calculation we include the time spent evaluating the update matrices **D** _[j,n]_ for _n_ and _Rn ≤ j ≤ n −_ 1, since they are required for the calculation of _Ln_ (see (3.28)–(3.29)). The NRMSE for the adaptive-lag method now decreases algebraically with _δ_ , demonstrating a sharper trade-off between computational resources and error compared to the fixed-lag approach. 

Panels (c) and (f) further illustrate the recovery skill of these approaches through the temporal average of the information gain for the fixed- and adaptive-lag online smoother strategies beyond the filter solution as functions of the fixed lag and tolerance parameter, respectively. Both are plotted on an x-axis that is scaled logarithmically and are calculated using the signal–dispersion formula of the relative entropy in (3.25), since both distributions are Gaussian at each time instant. For reference, we show both the signal and dispersion parts, as well as the total information gain. For the fixed-lag smoother, since the zero-fixed-lag online smoother coincides with the filter solution, the information gain there is zero, but as the fixed lag increases, it rapidly and exponentially converges to the information gain value corresponding to the full-backward offline smoother beyond the filter estimates (see Section 3.3). On the other hand, similarly to the results from Panels (d) and (e), we have that the temporally-averaged information gain beyond the filter solution is a logarithmic to algebraic function in _δ_ , where for large values of _δ_ this is close to zero and approaches the information gain value of the full-backward offline smoother beyond the filter estimates as _δ_ approaches zero. In both cases, these behaviors are demonstrated in both the signal and dispersion parts and, as such, in the total information gain as well. 

Finally, in Figure 4.5, we demonstrate the contrasting behavior of the adaptive-lag online smoother in the LDA problem when compared to the dyad-interaction model with intermittent instabilities from Section 4.1. First, Panel (a), similar to Panel (g) in Figure 4.2, illustrates the adaptive lag values (in time units) of the online smoother with hyperparameters _b_ = 100 (corresponding to _b_ ∆ _t_ = 0 _._ 5 simulation time units), _δ_ = 0 _._ 05 and calculated via the sequence of entropies through (3.32) and (3.31), as a function of time in [2 _,_ 5]. Unlike the adaptive lag values generated from the dyad model in Section 4.1, which highly depend on whether an extreme event is being observed or if we are currently at a period of dormancy, the adaptive lag value here meanders around a constant (about 0 _._ 3 in simulation time units), via uniform, in amplitude, oscillations, and does so steadily in time which indicates the absence of intermittency in the system and the uniform impact each observation has on the online smoother solution. Similar to Panels (h) and (i) of Figure 4.2, Panels (b) and (c) depict the standardized information gain sequence (see (4.3)) and spectral radii of the update matrices **D** _[j,n][−]_[2] but for the LDA problem defined in this section, (4.4)–(4.6). Again, as with the results from the dyad-interaction model, the two metrics showcase significant temporal correlations, with their major discrepancies emerging in the differing scale and noisier behavior of the former. As before, this functions as numerical corroboration to the claim that our proposed informationtheoretic approach to determining the observational impact region of the _n_ -th observation onto the online discrete smoother update is dynamically- and statistically-consistent and effective in recovering the exact approach reflected by the spectrum of the update tensor **D** _[j,n][−]_[2] , while being much more computationally efficient at the same time. But, it is also important to compare and contrast these results with those from Panels (g)–(i) of Figure 4.2. Foremost, the spectral radii of the update tensors **D** _[j,n][−]_[2] , which are high-dimensional matrices in this case, remain below 1 throughout time and for all values of _n_ . Also, in both case studies, these sequences illustrate an exponential behavior in _j_ for all values of _n_ . However, for the LDA problem, we can see a uniform rate of exponential decay as _j_ decreases from _n −_ 1, across all observations (i.e., _n_ ). Recall that, in the dyad-interaction numerical experiment, this rate would change depending on whether a rare or extreme event was forming in the observable signal; it could even exhibit regime switches depending on the emergence of intermittent instabilities. Therefore, for the LDA problem where we recover the flow field’s and tracers’ velocities, the observations from the tracers’ locations have a uniform impact on the online smoother estimate over time, which is a result of the stability that the model in (4.4)–(4.6) has, as well as of the fact that the equilibrium distribution of the tracers is nearly uniform due to the incompressibility of the underlying ocean velocity field [ **41** ]. This contrasts with the dyad-interaction model, which displays intermittent instabilities due to the latent dynamics acting as anti-damping in the observable ones on rare occasions. 

Lastly, in Panel (d) of Figure 4.5, we showcase the standardized LSDev criterion, i.e., for _σ[j,n]_ in (4.3), in the same manner as Panel (b). In this case study, where the absence of the intermittent instabilities allows for an almost consistent exponentially decaying behavior with a constant rate in _j_ for each _n_ for the adaptive-lag-defining criteria, Panels (b) and (d) 

23 

**==> picture [264 x 248] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Storage vs NRMSE for<br>Fixed-Lag Online Smoother<br>60 0.5<br>50 0.45<br>40 0.4<br>30 0.35<br>(b) Computational Time vs NRMSE<br>for Fixed-Lag Online Smoother<br>0.5<br>400<br>300 0.45<br>200<br>0.4<br>100<br>0.35<br>0<br>Storage (Gigabytes)<br>Time (Seconds)<br>**----- End of picture text -----**<br>


**==> picture [262 x 253] intentionally omitted <==**

**----- Start of picture text -----**<br>
(d) Storage vs NRMSE for<br>Adaptive-Lag Online Smoother (bΔt = 1.5)<br>0.45<br>45<br>0.4<br>44<br>0.35<br>43<br>(e) Computational Time vs NRMSE for<br>Adaptive-Lag Online Smoother (bΔt = 1.5)<br>90.32%<br>600<br>91.11% 0.45<br>500<br>93.01%<br>400<br>0.4<br>300 93.06%<br>200 93.65%<br>97.61% 0.35<br>94.28%<br>NRMSE<br>NRMSE<br>**----- End of picture text -----**<br>


**==> picture [502 x 143] intentionally omitted <==**

**----- Start of picture text -----**<br>
(c) Time Avg of the Info Gain Beyond the Filter (f) Time Avg of the Info Gain Beyond the Filter<br>Solution for the Fixed-Lag Online Smoother Solution for the Adaptive-Lag Online Smoother<br>20 20<br>10 10<br>Signal Dispersion Total<br>0 0<br>5 5 10 [1] 5 10 [2] 10 [3] 5 10 [-1] 5 10 [-2] 5 10 [-3] 5 10 [-4]<br>Fixed Lag Value δ (Tolerance Parameter)<br>**----- End of picture text -----**<br>


Figure 4.4: Panels (a)–(b) & (d)–(e): Analysis of the trade-off between the computational complexity, measured in computational time (in seconds), and required storage capacity (in gigabytes), and lower-order pathwise error statistic of the NRMSE between the posterior mean time series and true signal, for the fixed-lag (Panels (a)–(b)) and adaptive-lag online smoother (Panels (d)–(e)). In Panel (e) we also show at each data point of the latter the percentage of time spent on the adaptive-lag calculation (including the calculation of the update matrices **D** _[j,n][−]_[2] ). Details on how the storage and time values are calculated are given in Appendix D. Panels (c) & (f): Temporal average of the information gain for the fixed- (Panel (c)) and adaptive-lag (Panel (f)) online smoother beyond the filter solution for various values of the fixed lag and tolerance parameter, respectively. Both the signal (in green) and dispersion (in blue) parts of the total information gain (in red) are shown. All panels are plotted on a semi-log x-axis, and the x-axes for the adaptive-lag online smoother results are reversed for ease of comparison with the corresponding fixed-lag strategy plots. 

numerically corroborate the note made in the second-to-last paragraph in Section 3.4.2; we can yield analogous adaptive lag values with either sequence (of relative entropies � _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[or of their LSDevs] _[ {][σ][j,n][}][R][n][≤][j][≤][n][−]_[1][) by] a simple adjustment of the _δ_ tolerance value. 

## **4.3 Online Parameter Estimation of Nonlinear Systems with Only Partial Observations** 

Parameter estimation and model identification for complex nonlinear dynamical systems are crucial for effective state estimation, DA, and forecasting. In partially observed nonlinear systems, parameter and state estimation typically occur simultaneously, requiring a solution that often necessitates complicated approximations and expensive numerical methods. 

24 

**==> picture [540 x 299] intentionally omitted <==**

Figure 4.5: Panels (a)–(c): Similar to Panels (g)–(i) of Figure 4.2, respectively. Panel (d): Same as Panel (b) but for the standardized LSDev sequence (i.e., for _σ[j,n]_ in (4.3)). All panels correspond to the LDA model in (4.4)–(4.6). 

Nevertheless, the closed analytic formulae of the online nonlinear smoother (3.10)–(3.11) facilitate an efficient online parameter estimation scheme for the CGNS (2.1)–(2.2) for when only the time series of **x** is observed. In this section, we incorporate the adaptive online smoother into an expectation-maximization (EM) algorithm [ **103, 104, 105, 106** ] to alternately estimate parameters and hidden states, employing closed analytic formulae for both estimations. 

## **4.3.1 The Online EM Parameter Estimation Algorithm** 

The basic EM algorithm is outlined in Appendix E, and the mathematical details for the CGNS framework can be found in [ **107** ]. This reference serves as the foundation for developing an online version that utilizes the adaptive-lag online smoother for simultaneous state estimation and model identification, and also includes the tools necessary for incorporating into this algorithm’s skeleton extensions like block decomposition for learning high-dimensional systems, sparse identification or regularization, and physical and other constraints on the parameters. 

The parameter estimation aims at seeking an optimal estimation of the unknown parameters _**θ**_ by maximizing the loglikelihood function corresponding to the partially observed dynamics, also known as the marginal, partial, or conditional loglikelihood. Essentially, our goal is for model identification under the assumption that only a time series from the observable components **x** can be obtained, with **y** corresponding to the unobserved variables, which nevertheless interacts with **x** in (2.1)–(2.2). Since only the time series of **x** is observed, the maximum likelihood estimator (MLE) for the marginal loglikelihood is given by 

**==> picture [435 x 29] intentionally omitted <==**

where Θ denotes the underlying parameter space, which we assume to be a closed and convex subset of C _[N]_ for _N ∈_ N, and the integration in (4.7), i.e., marginalization, is happening over the state space of **y** . The EM iteration alternates between performing the so-called expectation step (E-step), which estimates the hidden state of **y** using the current estimate for the parameters, and a maximization step (M-step), which computes the parameters that maximize the expected marginal 

25 

log-likelihood found in the E-step [ **104, 108, 109** ]. Since **y** is unobserved throughout time, the conditional expectation in the E-step needs to be taken for those measurable functions (measurable with respect to the current observable _σ_ -algebra) containing **y** when computing the log-likelihood estimate, which takes into account the uncertainty in the state estimation through the optimal a-posteriori statistics of **y** . As is shown in Appendix E, the solution from the E-step is exactly the online smoother posterior distribution. 

## **4.3.2 A Numerical Example** 

The model we study in this numerical simulation is as follows: 

**==> picture [396 x 31] intentionally omitted <==**

where _du, dv, σu, σv >_ 0 and _γ, Fu, Fv ∈_ R, with _Wu_ and _Wv_ being two mutually independent Wiener processes. The system (4.8)–(4.9) fits the CGNS framework for **x** := _u_ and **y** = _v_ . Similar to the model in (4.1)–(4.2) of Section 4.1, the variable _v_ acts as a stochastic damping in the observable process, which leads to intermittent extreme events. The effect of these instabilities in the convergence of the algorithm is especially studied. We assume a time series of _u_ is continuously observed while there is no observation of _v_ . To simplify the study in this section, we assume that the noise feedbacks _σu_ and _σv_ are known, although our framework does not require such a restriction [ **107** ]. Thus, the parameter vector for this model is as follows: 

**==> picture [327 x 13] intentionally omitted <==**

The true parameter values are the following: 

**==> picture [182 x 27] intentionally omitted <==**

The numerical setup is as follows. The initial guess of the parameter values is _**θ**_ 0 = (2 _,_ 6 _,_ 2 _,_ 0 _._ 5 _,_ 0 _._ 6) `[T]` . The numerical integration time step, which is also the observational frequency in such a continuous observational case, is ∆ _t_ = 0 _._ 001. The total length of observations is _T_ = 200 time units. Since implementing the online smoother requires a certain history of previous state estimation solutions, the observed time series of _u_ within a short initial window [0 _, T_ ini], with _T_ ini = 10, is utilized to initially carry out the filtering solution and online smoother estimates, based on _**θ**_ 0. This can be treated as a burn-in or learning period for the algorithm, and also aids in avoiding the possibility of short-time blowup. Afterwards, with the arrival of each new observation, we update the adaptive-lag online smoother state estimations via the procedure in (3.26)–(3.27) and then re-estimate the parameters using the MLE. The update happens at every observation to ensure stability. The hyperparameters in the adaptive-lag method are _b_ = 1000 (where _b_ ∆ _t_ = 1 time unit) and _δ_ = 10 _[−]_[4] , where we use the actual sequence of information gains to define the adaptive lag at each new observation, i.e., (3.32). For a brief discussion on the online EM parameter estimation algorithm’s stability, sensitivity, and convergence skill with respect to the initial parameter values and length of the burn-in or learning period (for this specific model), through a purely empirical and simplified analysis, the interested reader is referred to Appendix F. 

Figure 4.6 presents the results from using the online EM algorithm. Panels (a) and (b) display the true trajectories of the observed and unobserved variables, _u_ and _v_ , respectively, displayed in blue. These trajectories are generated by running equations (4.8)–(4.9) forward in time. Alongside the true trajectories, the time series obtained by simulating the model with the estimated parameters at the final iteration of the online EM algorithm are included in red. Note that the same values for the Wiener processes are used for these two signals, allowing us to have a point-wise comparison. The recovery of the signal for both observable and unobserved variables is notably skillful. It is worth highlighting that, in Panel (b), the dashed horizontal lines indicate the true (in black) and online EM estimated (in green) anti-damping threshold lines, above which the unobserved variable effectively acts as anti-damping in the observable process, initiating intermittent instabilities in the signal. Their consistency is critical for retrieving the true dynamics using the estimated parameters. Panel (c) shows the adaptive lag values, measured in time units (i.e., _Ln_ ∆ _t_ ) for the online smoother, illustrating that longer lags are typically required during the onset of the intermittent phases to effectively capture the dynamics. The efficacious recovery of the true state is also demonstrated through higher-order statistics, such as the PDFs and autocorrelation functions (ACFs) for both _u_ (in Panels (d)–(e)) and _v_ (in Panels (f)–(g)). The use of an upper lag bound of _b_ ∆ _t_ = 1 time unit is enough to capture 

26 

most of the information in the online smoother updates while not overspending on storage (for the chosen tolerance value of _δ_ = 10 _[−]_[4] ). This is showcased in the produced PDFs and ACFs, which indicate faithful model fidelity and memory recovery, respectively, where for the latter, this is true even for time-lags outside the interval of the produced adaptive lag values. Finally, Panels (h)–(m) present the trace plots produced by the online EM iterations for various parameters of interest. The parameters in the observed process _u_ are nearly perfectly recovered, including the nonlinear feedback _γ_ and the deterministic constant forcing _Fv_ in the process of the unobserved variable. The only parameter that is not perfectly recovered is the damping _dv_ in the process of the unobserved variable, with the algorithm converging to twice its true value. This is expected, as these parameters, along with the noise feedback, are typically the hardest to estimate due to observability issues, where their contribution to the observed process is relatively weak. Nevertheless, this inaccuracy does not hinder the model with the estimated parameters from reproducing key dynamical and statistical features, as shown in Panels (a)–(b) and (d)–(g). 

An important observation from the trace plots is that extreme events in the observable signal enhance the convergence skill of the online EM algorithm within the CGNS framework. In Panel (a), four extreme events are marked as A, B, C, and D, characterized by a high signal-to-noise ratio. The trace plots in Panels (h)–(m) demonstrate that extreme events influence parameter convergence. The high signal-to-noise ratio mitigates the uncertainty in observations, resulting in strong observability of the system, which naturally facilitates parameter estimation [ **110** ]. This is particularly evident in the antidamping threshold (Panel (m)), highlighting the role of these events in identifying the intermittent nature of the underlying dynamics. 

For the sake of completeness, in Figure G.1, we provide the results from instead using the fixed-lag online discrete smoother in the outlined online EM parameter estimation algorithm, when applied to this specific model identification problem. See Appendix G for more info and a discussion comparing the fixed- and adaptive-lag online EM parameter estimation results. 

## **5 Conclusions** 

In this paper, a computationally efficient algorithm for online adaptive-lag optimal smoother-based state estimation with partial observations is developed. Closed analytical formulae are available for this online smoother. It applies to CGNS, representing a rich class of CTNDSs with wide applications in neuroscience, ecology, atmospheric science, geophysics, and many other fields. Importantly, the adaptive-lag strategy allows the reduction of computational complexity and storage requirements, creating the potential for the algorithm to significantly outperform both offline smoothing and its fixed-lag counterpart operationally while achieving a comparable skill in state estimation. Notably, an information-theoretic criterion, exploiting uncertainty reduction across the entire posterior distribution, is developed to calculate the adaptive lag value, which helps in preserving dynamical and statistical consistency. 

The adaptive-lag online smoother has been applied to a system with intermittent instabilities (Section 4.1). It effectively recovers extreme events and discovers the causal dependence between different state variables. It is also applicable to highdimensional systems, such as the LDA problem. The state estimation based on such an online smoother shows nearly the same accuracy as the standard forward-backward smoother while requiring significantly less computational storage under suitable choices of the algorithm parameters (Section 4.2). In addition, the online adaptive-lag smoother facilitates real-time parameter estimation. The study highlights the importance of utilizing observed extreme events to accelerate the convergence of parameter estimation (Section 4.3). 

Potential future research topics in this direction are as follows. First, the closed-form expressions of the online smoother estimates can aid in assessing extreme events and their impact on the CGNS dynamics, as well as in identifying the most sensitive directions that exhibit rapid fluctuations during specific events using information-theoretic methods [ **78** ]. This is facilitated by the fact that the CGNS framework enjoys analytic formulae for such conditional distributions [ **33** ]. Second, the adaptive-lag online smoother can serve as a useful tool for causal inference and information flow analysis. On the one hand, one can exploit intermittent extreme events to improve state estimation, which helps reduce the model error in developing parsimonious surrogate models via causal inference. On the other hand, the conditional Gaussianity of the framework allows the application of transfer or causation entropy to explore these topics in future studies. Third, it is necessary to explicitly investigate how the adaptive-lag online smoother has the potential to outperform the fixed-lag alternative by uniformly reducing storage needs and computational complexity in CGNSs. Such a study will involve the derivation of theoretical or empirical representations of these operational metrics, as well as of point-wise or distribution-based error measures during 

27 

**==> picture [541 x 314] intentionally omitted <==**

**----- Start of picture text -----**<br>
2 A (Ba) Time Series of u C (Observed) D 3 (h) Trace Plot of du 2.5 (i) Trace Plot of dv<br>C D<br>1 2.5 2<br>2<br>0 A B<br>B 1.5<br>-1 Truth Adaptive-Lag Online EM True d u/γ valueV Adaptive-Lag Online EM Estimated d u/γ 1.5<br>(b) Time Series of v (Unobserved) 1 1<br>2<br>1 0.5 0.5<br>0 2.5 (j) Trace Plot of Fu 1.5 (k) Trace Plot of Fv<br>-1<br>-2<br>2 1<br>0 10 20 40 60 80 100 120 140 160 180 200<br>t<br>1 (c) Adaptive Lag (in Time Units) for δ = 10 [-4] 1.5 A B 0.5 B C D<br>0.5 1 0<br>(l) Trace Plot of γ (m) Trace Plot of du/γ<br>(Anti-Damping Threshold)<br>0 6 0.55<br>10 20 40 60 80 100 120 140 160 180 200<br>t 5.5 0.5<br>1.5 [(][d][)][ Time-Av][g][ PDF of u] 1 (e) ACF of u 1 [(][f][)][ Time-Av][g][ PDF of v] 1 (g) ACF of v 5 0.45<br>A<br>1 4.5 A 0.4<br>0.5 0.5 0.5 4 0.35<br>0.5<br>3.5 0.3<br>0 0 B D<br>0 0 3 0.25<br>-0.5 0 0.5 1 1.5 0 2 4 -2 -1 0 1 0 2 4 10 50 100 150 200 10 50 100 150 200<br>u t v t t t<br>u<br>v<br>Δt<br>n<br>L<br>p(u) p(v)<br>Autocorr Autocorr<br>**----- End of picture text -----**<br>


Figure 4.6: Panel (a): True trajectory of the observable variable _u_ over the simulation period (in blue), and the recovered trajectory from using the same white noise values used to generate the true signal (by utilizing the same seed number) but where the model in (4.8)–(4.9) is instead defined through the recovered parameter values at the last iteration of the online EM algorithm (in red). The dashed rectangular box denotes the period of running the filter and online smoother algorithms with _**θ**_ 0, which is [0 _,_ 10]. Four extreme events are marked in the observed time series (denoted by A, B, C, and D). Panel (b): Same as (a) but for the unobserved variable _v_ . The true and online EM estimated anti-damping threshold _du/γ_ are marked by dashed lines, in black and green, respectively. Panel (c): Adaptive lag values generated using (3.32) (measured in time units, i.e., _Ln_ ∆ _t_ ), as a function of simulation time. Panels (d)–(g): PDFs of _u_ (Panel (d)) and _v_ (Panel (f)) and their ACFs (Panels (e) and (g), respectively), for both the true model parameters and the ones obtained at the last iteration of the online EM algorithm. Panels (h)–(m): Trace plots produced by the online EM algorithm. 

state estimation, as functions of the fixed lag and adaptive-lag tolerance parameter _δ_ (for a fixed upper lag bound _b_ ). Finally, future work along this line also involves developing a rigorous investigation of the spectral properties of the update tensors **D** _[j,n][−]_[2] used in the online smoother, as well as of the matrices **E** _[j]_ that define them, potentially through suitable concentration inequalities. This includes studying the temporal behavior of the information-theoretic criterion for adaptive lags, _P_ � _p[j,n]_ updated _[, p][j,n]_ lagged� (and its LSDev). Numerical case studies have shown that these quantities showcase exponentially varying behavior over time, with the rate depending on whether a quiescent or intermittent signal is observed. Notably, the spectrum of **D** _[j,n][−]_[2] remains below the convergence threshold of 1, which is reassuring. A rigorous analysis of these properties is a natural future topic. 

## **Acknowledgments** 

The authors thank the reviewers for their constructive feedback and valuable suggestions during the peer-review process. 

N.C. is grateful to acknowledge the support of the Office of Naval Research (ONR) N00014-24-1-2244 and Army Research Office (ARO) W911NF-23-1-0118. M.A. is supported as a research assistant under these grants. 

28 

## **Appendices** 

## **Appendix A Sufficient Assumptions for the Results of the CGNS Framework** 

Let the following denote the standard elements of the vector- and matrix-valued functionals appearing in (2.1)–(2.2) as model parameters: 

**==> picture [406 x 55] intentionally omitted <==**

To be able to obtain the main results which define the CGNS framework and its potency in DA through closed-form expressions for the posterior statistics, a set of sufficient regularity conditions needs to be assumed a-priori. In what follows, each respective pair of indices _i_ and _j_ takes all admissible values and **z** is a _k_ -dimensional function in _C_[0][�] [0 _, T_ ]; C _[k]_[�] : 

**(1)** We assume: 

**==> picture [351 x 52] intentionally omitted <==**

This ensures the existence of the integrals in (2.1)–(2.2) [ **32, 33** ]. 

**(2)** ��Λ **x** _ij_[(] _[t,]_ **[ z]**[)] �� _,_ ��Λ **y** _ij_[(] _[t,]_ **[ z]**[)] �� _≤ L_ 1 for some (uniform) _L_ 1 _>_ 0, _∀t ∈_ [0 _, T_ ]. 

- **(3)** If _g_ ( _t,_ **z** ) denotes any element of the multiplicative factors in the drift dynamics, **Λ[x]** and **Λ[y]** , or of the noise feedback matrices, **Σ[x]** _m_[(] _[t,]_ **[ z]**[)][ and] **[ Σ][y]** _m_[(] _[t,]_ **[ z]**[)][ for] _[ m]_[=][1] _[,]_[ 2][, and] _[ K]_[(] _[s]_[)][ is a nondecreasing right-continuous function taking values] in [0 _,_ 1], then there _∃L_ 2 _, L_ 3 _, L_ 4 _, L_ 5 _>_ 0 such that for any **z** and **w** _k_ -dimensional functions in _C_[0][�] [0 _, T_ ]; C _[k]_[�] we have: 

**==> picture [389 x 58] intentionally omitted <==**

These integrals are to be understood in the Lebesgue–Stieltjes integration sense. 

**(4)** E� _∥_ **x** (0) _∥_[2] 2[+] _[ ∥]_ **[y]**[(0)] _[∥]_[2] 2� _<_ + _∞_ . 

- **(5)** The sum of the Gramians (with respect to the rows) of the noise coefficient matrices in the observable process are uniformly nonsingular, i.e., the elements of the inverse of 

**==> picture [262 x 14] intentionally omitted <==**

are uniformly bounded in [0 _, T_ ]. 

**==> picture [184 x 56] intentionally omitted <==**

**==> picture [376 x 52] intentionally omitted <==**

**==> picture [87 x 11] intentionally omitted <==**

29 

**==> picture [532 x 38] intentionally omitted <==**

**==> picture [474 x 20] intentionally omitted <==**

- **(10)** Let � **x** ∆ _t_ ( _t_ ) _,_ **y** ∆ _t_ ( _t_ )� be the stochastic discrete-time approximation of ( **x** _,_ **y** ), after a continuous-time extension, that is provided by the numerical integration Euler–Maruyama scheme when applied on the CGNS in (2.1)–(2.2) (see (3.1)– (3.2)), over a temporal uniform partition of [0 _, T_ ] with ∆ _t_ being the uniform subinterval length. Then, as in Andreou & Chen [ **55** ], we assume that there exists _L_ 7 _>_ 0 such that: 

**==> picture [241 x 21] intentionally omitted <==**

In other words, we assume that the exact initial distributions are not being severely misidentified by the discrete-time ones (at least in the mean). 

**==> picture [363 x 57] intentionally omitted <==**

- **(13)** As with **(10)** , by adopting a uniform temporal discretization of [0 _, T_ ], with ∆ _t_ = _T/J_ being its norm and _tj_ = _j_ ∆ _t_ for _j_ = 0 _,_ 1 _, . . . , J_ being its nodes, where _J ∈_ N, we assume that 

**==> picture [337 x 35] intentionally omitted <==**

as ∆ _t →_ 0[+] , for every _M_ = _M_ ( _ω_ ) with P( _M <_ + _∞_ ) = 1. 

For more details about the regularity conditions in **(1)** – **(13)** , including possible relaxations, see Andreou & Chen [ **55** ]. Most importantly, in the context of this work, these assumptions are sufficient for establishing the CGNS optimal online forwardin-time discrete smoother from Theorem 3.1. 

## **Appendix B Proof of the Optimal Online Forward-In-Time Discrete Smoother** 

In this appendix we outline the details of the proof to Theorem 3.1 which outlines the procedure for the online forward-intime discrete smoother for optimal state estimation of the unobserved processes. 

_**Proof of Theorem 3.1** ._ From the derivations in Andreou & Chen [ **55** ] concerning the discrete smoother, for _n ∈_ N and _j_ = 0 _,_ 1 _, . . . , n −_ 1, we have that 

**==> picture [532 x 51] intentionally omitted <==**

where 

**==> picture [402 x 35] intentionally omitted <==**

which immediately shows that (3.13) and (3.14) hold by plugging in _j_ = _n −_ 1 into these, since the smoother and filter estimates are the same at the end point, i.e., _**µ**_ s _[n,n]_ = _**µ**[n]_ f[and] **[ R]** s _[n,n]_ = **R** _[n]_ f[.][As such, we just need to prove (3.10) and (3.11).] 

30 

We start by proving the following relation for _n ∈_ N and _j_ = 0 _,_ 1 _, . . . , n −_ 1: 

**==> picture [393 x 43] intentionally omitted <==**

The curved arrow pointing to the right above the product symbol in (B.3) indicates the order or direction with which we expand said product, since we are dealing with matrices, thus making the product, in general, noncommutative. Also, note that (B.3) is able to encompass both the second and third relations of (3.12), but not the first one due to its irregular form. Nonetheless, it could be extraneously incorporated in (B.3) by noting that if _j_ = _n_ , and so the product on the right-hand side is “empty”, then **D** _[n,n][−]_[1] is trivially defined as the identity matrix **I** _l×l_ . 

For _n ∈_ N _≥_ 2 and _j_ = 0 _,_ 1 _, . . . , n −_ 1, we have from iterative application of the appropriate relation in (3.12) (the second and third relations are appropriately applied in what follows, possibly after some reindexing, without loss of generality), that 

**==> picture [493 x 113] intentionally omitted <==**

which proves the relation on the left-hand side of (B.3). Similarly, from the previous result and (3.12) (the first relation), we have 

**==> picture [304 x 45] intentionally omitted <==**

which is the same as the right-hand side of (B.3). For _n_ = 1, and so _j_ = 0 necessarily, we have 

**==> picture [92 x 42] intentionally omitted <==**

by the second relation in (3.12), while by the first relation in (3.12) we have 

**==> picture [106 x 42] intentionally omitted <==**

and so by combining these two results proves (B.3) also for _n_ = 1 and _j_ = 0. Collecting all these results together, establishes (B.3) for _n ∈_ N and _j_ = 0 _, . . . , n −_ 1. 

We proceed now by proving that for _n ∈_ N and 0 _≤ j ≤ n −_ 1, the following equations are valid: 

**==> picture [422 x 35] intentionally omitted <==**

**==> picture [424 x 35] intentionally omitted <==**

We start with the equation for the smoother mean. We have by an iterative application of (B.1) for _n ∈_ N and _j_ = 0 _, . . . , n−_ 1 that 

**==> picture [320 x 35] intentionally omitted <==**

31 

**==> picture [460 x 170] intentionally omitted <==**

Using now (B.3) (possibly after some reindexing, without loss of generality), then this expression reduces down to 

**==> picture [190 x 35] intentionally omitted <==**

which is exactly what we wanted to prove for the smoother mean in (B.4). We now turn our attention to the smoother covariance matrix. In a very similar fashion, now by iteratively using (B.2) for _n ∈_ N and _j_ = 0 _, . . . , n −_ 1, we get 

**==> picture [484 x 241] intentionally omitted <==**

Like we did before, by using (B.3) (possibly after some reindexing, without loss of generality), and by noticing that 

**==> picture [164 x 43] intentionally omitted <==**

for _r_ = _n, n −_ 1 _, . . . , j_ + 1, then the previous expression is equivalent to, 

**==> picture [306 x 35] intentionally omitted <==**

which is exactly what we wanted to prove for the smoother covariance in (B.5). 

32 

Now to verify the recursive formulae given in (3.10) and (3.11), we use (B.4) and (B.5) by looking at the differences _**µ**_ s _[j,n] −_ _**µ**_ s _[j,n][−]_[1] and **R** _[j,n]_ s _−_ **R** _[j,n]_ s _[−]_[1] , respectively. First, observe that (3.10) and (3.11) trivially hold in the case where _n_ = 1, and as such we necessarily have _j_ = 0 _, . . . , n −_ 1 _⇔ j_ = 0. This is immediate by the first relation in (3.12) and the fact that _**µ**_ s[0] _[,]_[0] = _**µ**_[0] f[and] **[ R]** s[0] _[,]_[0] = **R**[0] f[.][As such, we only consider the case where] _[ n][ ∈]_[N] _[≥]_[2][ and] _[ j]_[= 0] _[, . . . , n][ −]_[1][.][From (B.4) we have,] 

**==> picture [264 x 15] intentionally omitted <==**

and by (B.5) we get, 

**==> picture [406 x 14] intentionally omitted <==**

Replacing now the coefficient **D** _[j,n][−]_[1] by **D** _[j,n][−]_[2] **E** _[n][−]_[1] via the third relation in (3.12), since it holds for _n ∈_ N _≥_ 2, _j_ = 0 _, . . . , n −_ 1, for the smoother mean we have, 

**==> picture [278 x 57] intentionally omitted <==**

and for the smoother covariance, 

**==> picture [324 x 57] intentionally omitted <==**

where by (B.3) we have (after the trivial reindexing _n −_ 1 ⇝ _n −_ 2, without loss of generality), 

**==> picture [78 x 43] intentionally omitted <==**

With these we have proved (3.10) and (3.11) for _n ∈_ N and _j_ = 0 _,_ 1 _, . . . , n−_ 1. For _j_ = _n_ , by the fundamental filter-smoother relation, we have _**µ**_ s _[n,n]_ = _**µ**[n]_ f[,] **[ R]** s _[n,n]_ = **R** _[n]_ f[.][This finishes the proof of Theorem 3.1.] ■ 

## **Appendix C Trade-off Analysis Between the Computational and Storage Complexity – and Posterior Solution Skill for the Dyad Model in** (4.1) (4.2) 

Figure C.1, similar to Figure 4.4, compares the computational time (in seconds) and storage requirements (in gigabytes) of the fixed- and adaptive-lag online smoothers against the NRMSE between their posterior mean time series and the true unobserved signal. As with Figure 4.4, computational times in Panels (b), (e), and (g) are averaged over multiple runs to reduce external fluctuations, with corresponding panels being plotted in a similar manner. Details on how the storage and time values are calculated are given in Appendix D. Comparing these with the computational behavior of the fixedand adaptive-lag online smoothers in the LDA application (see Figure 4.4), which is a model that lacks the intermittent instabilities that emerge in the dyad model, (4.1)–(4.2), more intricate results arise. 

Starting with the similarities between the two models, both the storage use (Panel (a), in red) and computational time (Panel (b), in red) of the fixed-lag online smoother show an algebraically increasing behavior with the fixed lag value. Furthermore, as is to be expected, since a constant upper lag bound parameter is used for all simulations of the adaptive-lag online smoother ( _b_ ∆ _t_ = 3 simulation time units), the storage use does not vary with decreasing _δ_ (Panel (d), in red). 

In contrast, the NRMSE of the fixed-lag method in the dyad model (Panels (a)–(b), in blue) roughly indicates an algebraic decrease with increasing fixed lag, instead of the exponential one in LDA (see Panels (a) and (b) of Figure 4.4). With regards to the adaptive-lag online smoother’s computational performance in time (Panel (e), in red), as well as its prediction skill formulated via the NRMSE (Panels (d)–(e), in blue), both are nontrivial functions of the tolerance parameter _δ_ . Specifically, 

33 

with decreasing _δ_ , after a certain tolerance value, there is a regime switch from, roughly speaking, a sub-logarithmic increase for the former and algebraic to exponential decrease for the latter, to a logarithmic to algebraic increase for the former and algebraic decrease for the latter. In Panel (e), like the one in Figure 4.4, we also show at each data point on the computational time curve the percentage of time spent on the adaptive-lag calculation (including the calculation of the update values _D[j,n][−]_[2] ). Due to the one-dimensional observable and unobservable state spaces, the time consumed on this operation is much smaller than that in the LDA case study, but, because of this, the storage need reductions are only marginal in nature. These observations collectively indicate how, in such settings, the adaptive-lag algorithm has the potential to provide a significant reduction in computational complexity beyond its fixed-lag counterpart, while maintaining a skillful state estimation in pathwise error statistics (even when using a relatively inflated upper lag bound of _b_ ∆ _t_ = 3). 

The aforementioned results also emerge in the recovery skill of these algorithms, formulated through the temporallyaveraged information gain beyond the filter solution, depicted in Panels (c) for fixed lag and (f) for adaptive lag. In these, the associated signal and dispersion parts are also plotted. (Note how in the dyad model, due to the intermittent extreme events, the dispersion is comparatively much smaller than the signal part.) In the former, we observe how the time-averaged information gain algebraically increases with respect to the fixed lag value, while in the latter we see a somewhat sublogarithmic behavior with decreasing _δ_ (after the aforementioned tolerance parameter threshold is met). 

Finally, in Panel (g), the results from using the LSDev sequence to define the adaptive lag (i.e., (3.30)–(3.31)) are plotted, similar to Panel (e). Since, as observed from Panel (h) in Figure 4.2, in this case study the extreme events do not allow for the standardized sequence of relative entropies or information gains in (4.3) to behave in an overall exponential manner in _j_ uniformly over _n_ , as in the LDA numerical experiment (see Panel (b) and (d) in Figure 4.5), the LSDev approach showcases a slightly distinct behavior with respect to the tolerance parameter _δ_ when compared to the approach which uses the original sequence (see Panel (e)). Specifically, there is a trade-off to be made; for larger NRMSE the use of the original sequence of relative entropies outperforms in terms of computational time, while for smaller ones, particularly for the apparent lowerbound limit at 0 _._ 6315, the LSDev approach is able to terminate faster. 

## **Appendix D Details of the Storage Value and Computational Time Calculation in Figures 4.4 and C.1** 

The storage values (in gigabytes) depicted in Panels (a) and (d) of Figure 4.4 (and by extension in Panels (a) and (d) of Figure C.1) are calculated by adding the storage required for storing each of the MATLAB nested cell array structures that are used to hold the online smoother mean vectors _**µ**_ s _[j,n]_[, online smoother covariance matrices] **[ R]** _[j,n]_ s[, and the online smoother] update matrices **D** _[j,n][−]_[2] (one nested cell array for each), for that run of the online smoother algorithm (Algorithm 1). The outer cell array (of each nested cell array) is 1 _×_ 1000 in size, where 1000 is the total number of observations in this numerical experiment. Each cell in the outer cell array holds another (1 _× n_ )-sized cell array, where _n_ is the ordinal number of the current observation, which itself, in each of its cells, holds the associated multidimensional quantity mentioned prior (vector or matrix, respectively). Finally, all of these storage values also include the storage requirements for the 2D matrix holding the filter mean vectors and 3D matrices holding the filter covariance matrices and **E** _[j]_ and **F** _[j]_ auxiliary matrices (one for each). For the adaptive-lag online smoother we also include the 2D array holding the adopted adaptive-lag-defining criterion, _P p[j,n]_ � � updated _[, p][j,n]_ lagged�� _Rn≤j≤n−_ 1[, or] _[ {][σ][j,n][}][R][n][≤][j][≤][n][−]_[1][.] 

We utilize nested cell arrays for these case studies to simulate jagged or ragged 3D- and 4D-arrays, since the numerical experiments are not being carried out on an HPC with GPU clusters (and since MATLAB does not natively support jagged multidimensional arrays). Depending on the fixed lag value _L_ for the fixed-lag online smoother and the upper lag bound _b_ for the adaptive-lag online smoother, only the necessary components that are required to carry out the associated online smoother updates are calculated and stored, and therefore added to the aforementioned storage values. While this adopted approach leads to an overcalculation of the computational time required, as MATLAB can struggle with accessing elements in a (nested) cell array (due to how they occupy place in memory), this method allows us to run these algorithms efficiently even for high-dimensional systems without the need for an HPC with GPU clusters. 

As for the computational time values, both for the fixed- and adaptive-lag algorithms, the simulation time does not include the time required for the calculation of the filter statistics, of **E** _[j]_ and **F** _[j]_ (see (3.5)–(3.6)), and of the model parameters at each newly obtained observation. Those are assumed to already be calculated and stored in memory for quick access. Therefore, the computational times depicted in these figures only cumulate the time needed at each _n_ (i.e., each observation) to access 

34 

**==> picture [540 x 251] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Storage vs NRMSE for (d) Storage vs NRMSE for<br>Fixed-Lag Online Smoother Adaptive-Lag Online Smoother (bΔt = 3)<br>28 0.8 28<br>0.8<br>26 26<br>24 24<br>0.7<br>0.7<br>22 22<br>20 20<br>0.6 0.6<br>(e) Computational Time vs NRMSE for<br>(b) Computational Time vs NRMSE<br>Adaptive-Lag Online Smoother (bΔt = 3)<br>for Fixed-Lag Online Smoother<br>0.8 (Using Relative Entropy Sequence) 11.15%<br>0.8<br>280<br>11.15%<br>400<br>260<br>0.7<br>0.7<br>300 240 12.23% 12.06%<br>12.17%<br>200 0.6 220 0.6<br>12.94%<br>NRMSE<br>Storage (Gigabytes)<br>NRMSE<br>Time (Seconds)<br>**----- End of picture text -----**<br>


**==> picture [502 x 301] intentionally omitted <==**

**----- Start of picture text -----**<br>
(c) Time Avg of the Info Gain Beyond the Filter (f) Time Avg of the Info Gain Beyond the Filter<br>Solution for the Fixed-Lag Online Smoother Solution for the Adaptive-Lag Online Smoother<br>0.2 0.2<br>Signal Dispersion Total<br>0.1 0.1<br>0 0<br>10 [1] 10 [2] 10 [3] 10 [4] 5 10 [-1] 5 10 [-2] 5 10 [-3] 5 10 [-4] 5 10 [-5] 5 10 [-6]<br>Fixed Lag Value δ (Tolerance Parameter)<br>(g) Computational Time vs NRMSE for<br>Adaptive-Lag Online Smoother (bΔt = 3)<br>(Using LSDev Sequence) 12.25%<br>280<br>0.8<br>260 12.67% 12.55%<br>0.7<br>13.46% 12.92%<br>240 13.98%<br>0.6<br>5 10 [-4] 5 10 [-5] 5 10 [-6] 5 10 [-7] 5 10 [-8] 5 10 [-9]<br>δ (Tolerance Parameter)<br>NRMSE<br>Time (Seconds)<br>**----- End of picture text -----**<br>


Figure C.1: Panels (a)–(f): Same as Panels (a)–(f) of Figure 4.4, but for the dyad-interaction model, (4.1)–(4.2), from the case study in Section 4.1. Panel (g): Same as Panel (e) but using the LSDev sequence to define the adaptive lags (per (3.30)– (3.31)). 

said memory and to carry out the the calculations in Algorithm 1 for the _j_ ’s defined either by the fixed or adaptive lag value, where for the latter we also include the time required to determine it (i.e., calculate the information gain sequence (and possibly its LSDev) and then use (3.32) (or (3.30))). Importantly, it does not include the time required to create and delete the aforementioned nested cell arrays that hold the online smoother Gaussian statistics and update matrices **D** _[j,n][−]_[2] . 

35 

## **Appendix E Details of the Online Expectation-Maximization Algorithm for Parameter Estimation** 

In this appendix, we outline the basic learning EM algorithm, which sets the baseline structure for the online model identification algorithm developed in Section 4.3.1. As usual, it is assumed that the coupled CGNS in (2.1)–(2.2) is only partially observed, and based on the time discretization setup adopted thus far in this work (see (3.1)–(3.2) in Section 3.1), we denote the set of values of the state variables, when evaluated on the discrete-time steps _tj_ , as _X_ = _{_ **x**[0] _, . . . ,_ **x** _[j] , . . . ,_ **x** _[n] }_ and _Y_ = _{_ **y**[0] _, . . . ,_ **y** _[j] , . . . ,_ **y** _[n] }_ , for the observable and unobservable components, respectively. 

Given an ansatz of the model, the goal here is to maximize an objective function, specifically the log-likelihood of the observational process, with respect to the model parameters, 

**==> picture [228 x 28] intentionally omitted <==**

where _**θ**_ is the collection of model parameters. This is also known as the marginal log-likelihood of the observed data, with the full log-likelihood being given by log � _p_ ( _X , Y_ ; _**θ**_ )�. Using any distribution over the discretized hidden variables, with density _q_ ( _Y_ ), a lower bound on the marginal log-likelihood can be obtained in a rather trivial manner in the following way [ **105** ]: 

**==> picture [442 x 104] intentionally omitted <==**

where the negative value of � _Y[q]_[(] _[Y]_[) log] � _p_ ( _X , Y_ ; _**θ**_ )� d _Y_ is the so-called free energy, while _S_ ( _q_ ) = _−_ � _Y[q]_[(] _[Y]_[) log] � _q_ ( _Y_ )� d _Y_ is the Shannon differential entropy. Therefore, based on the fact that _F_ ( _q,_ _**θ**_ ) _≤ ℓ_ ( _**θ**_ ) for all distributions _q_ over _Y_ , it is clear that maximizing the marginal log-likelihood is equivalent to maximizing _F_ alternatively with respect to the distribution _q_ and the parameters _**θ**_ [ **111, 112** ], thus creating a bridge between the usual MLE algorithm and EM procedure. This alternate maximization of _F_ is the essence of the EM algorithm, where the EM designation stems from the following procedure: 

**==> picture [184 x 50] intentionally omitted <==**

An essential observation in this process is that the maximization in the E-Step is exactly reached when _q_ is the posterior conditional distribution of _Y_ , that is 

**==> picture [110 x 14] intentionally omitted <==**

which in the online setting of sequential arrival of observations corresponds to the online smoother posterior distribution. This is attributed to the equality condition for the Jensen inequality, which we used to prove the bound between the marginal log-likelihood and the objective function _F_ . In Jensen’s integral inequality, _ϕ_ �E [ _X_ ] � _≤_ E� _ϕ_ ( _X_ )� for _ϕ_ being a convex operator and _X_ an arbitrary-valued random variable, it is known that equality holds if and only if _ϕ_ is an affine function or if _X_ is constant almost surely. As such, since the objective function _F_ can be rewritten in the following much more intuitive form: 

**==> picture [164 x 14] intentionally omitted <==**

_p_ ( _X ,Y_ ; _**θ**_ ) where _P_ is the relative entropy from Section 3.4.1, then equality holds when log � _q_ ( _Y_ ) � is an affine function, which is exactly achieved when _q_ ( _Y_ ) = _p_ ( _Y|X_ ; _**θ**_ ) _∝ p_ ( _X , Y_ ; _**θ**_ ), with the proportionality being due to Bayes’. Of course, this fact can also be seen through the Gibbs’ inequality, since for _q_ ( _Y_ ) = _p_ ( _Y|X_ ; _**θ**_ ) the relative entropy term on the right-hand side vanishes [ **113** ]. In such a situation, the bound _F_ ( _q,_ _**θ**_ ) _≤ ℓ_ ( _**θ**_ ) becomes an equality, _F_ ( _q,_ _**θ**_ ) = _ℓ_ ( _**θ**_ ). Note that the conditional 

36 

distribution in the E-Step is very difficult to solve for general CTNDSs. Various numerical methods and approximations are often used [ **105, 104** ], which usually suffer from both approximation errors and the curse of dimensionality. Nevertheless, for the CGNS framework, the distribution _p_ ( _Y|X_ ; _**θ** k_ ) is given in an optimal and unbiased manner by the closed analytic formulae of the online discrete smoother from Theorem 3.1, which greatly facilitates the application of the online EM parameter estimation algorithm to many nonlinear models. On the other hand, since the differential entropy does not depend on _**θ**_ , the maximum in the M-Step is obtained by maximizing the negative of the free energy, 

**==> picture [260 x 28] intentionally omitted <==**

This interpretation of the basic learning EM algorithm is known as the “maximization-maximization procedure” formulation, where the EM algorithm is viewed as two alternating maximization steps, which is a specific application of coordinate descent. We finally note that the EM algorithm enjoys a monotonicity property, which states that improving the negative of the free energy will at least not make the marginal log-likelihood worse with regards to the optimization goal [ **114** ], and that a convergence analysis for the EM method (including results for distributions outside the exponential family), can be found in the fundamental theoretical work of Wu [ **115** ]. As for the explicit expression of _**θ** n_ +1 in the case of the CGNS, as well as of the noise feedbacks in the case of unknown uncertainty matrices, both with respect to the posterior statistics, see the work of Chen [ **107** ]. 

Finally, here we provide a simple numerical trick for accelerating the convergence of the parameters to their true values in the online EM algorithm. This process is based on momentum-based methods from classical convex optimization, which utilize momentum terms in the update to aid the learning process (e.g., Nesterov’s accelerated gradient descent [ **116** ]). We denote by _**θ** n_ and _**θ** n_ +1 the learned parameters (or part of them) in the previous ( _n_ ) and current ( _n_ +1) iteration, respectively. An acceleration of the parameter value at the current step can be achieved by 

**==> picture [146 x 13] intentionally omitted <==**

where _α ∈_ [0 _,_ 1] is a hyperparameter. If _α_ = 0, then there is no acceleration; the acceleration rate depends on the amplitude of _α_ . Such a trick can be applied in the first few iterations of the online EM algorithm, especially for those in the unobserved process when the observability of the system is weak. 

## **Appendix F Stability, Sensitivity, and Convergence of the Adaptive-Lag Online EM Parameter Estimation Algorithm for the Dyad Model** (4.8) **–** (4.9) **in Initial Parameter Values and Learning Duration** 

In this appendix we briefly discuss the stability, sensitivity, and convergence of the (adaptive-lag) online EM parameter estimation algorithm, when applied to the dyad model in (4.8)–(4.9), with respect to the algorithm’s burn-in or learning duration and initial parameter values. 

The results noted and discussed in what follows have been derived on a purely empirical basis, through trial and error, due to the tremendous computational costs that a full parameter space analysis entails. Specifically, this empirical analysis is conducted in a “ceteris paribus” fashion, by adjusting only a single parameter’s initial guess or the algorithm’s learning period, while all other components of the algorithm remain unchanged from those in the simulation presented in Section 4.3.2. Furthermore, these adjustments are made in both directions, i.e., by both decreasing or increasing the component of interest, and done so to severe degrees as to confirm the algorithm’s stability or convergence skill is not localized under this regime. 

For the dyad model in (4.8)–(4.9), the adaptive-lag online EM parameter estimation algorithm carried out to derive the results in Figure 4.6 is extremely stable, both in terms of the initial parameter values as well as in the length of the burn-in or learning period. Here, by stable, we mean that the algorithm does not destructively deteriorate and blow up; the algorithm might still diverge and approach a different subset of the parameter space as it evolves, but at least does so in a stable manner. 

In terms of sensitivity and convergence skill with respect to the initial parameter values and burn-in or learning period, when we apply the adaptive-lag online EM parameter estimation algorithm on the dyad model in (4.8)–(4.9), we have: 

- _du_ : Initial overestimation (i.e., a large positive value) affects _du_ ’s convergence, but it also affects that of _Fv_ (by overestimating it), as is to be expected; overdamping _u_ initially requires a larger positive _Fv_ to counteract this 

37 

through the _−γu_[2] term. The convergence of the other parameters remains unaffected. Relatively large values of initial _du_ are needed to effectively diverge _du_ and _Fv_ away from their true values. 

If _du_ is set equal to zero initially, it remains close to its neighborhood and oscillates there even after extreme event observance. This is compensated by estimating a negative _Fv_ as the algorithm evolves. Other parameters’ convergence is again not severely affected by this. 

Initial underestimation (i.e., a large, in absolute value, negative initial guess) is not corrected with respect to the sign as the algorithm evolves, even after observing extreme events, with _du_ remaining at a significant negative value throughout. _Fv_ diverges as well, with large negative values. The convergence of the other parameters remains unaffected. 

- _γ_ : Overestimating _γ_ initially severely skews the convergence of itself, _dv_ , and _Fv_ , but for _γ_ and _Fv_ this is corrected with the observance of extreme events (especially after extreme event A; see Panel (a) in Figure 4.6). For _dv_ , it converges towards an extremely damped regime, where this is to be expected due to the _−γu_[2] term. 

By starting from zero, _γ_ remains close to it for the whole run, with _du_ being overestimated and the other parameters being underestimated. 

For negative initial _γ_ , the algorithm’s estimation for it remains negative and converges towards _−γ_ , due to the symmetry of the energy conservation condition, but for large negative values it compensates by significantly overestimating _dv_ and having a negative significant _Fv_ . _du_ and _Fu_ are unaffected under this regime. 

Severe positive or negative _γ_ does slow down its convergence, but the true value is well approximated eventually after a sufficiently long run. 

- _Fu_ : Significantly overestimating _Fu_ initially leads to the algorithm to search for an antidamping regime for _u_ over the parameter space (in _du_ ) and to severely underestimate _γ_ , due to the quadratic coupling effects. It also completely misidentifies the _Fv_ value, due to the significant joint contribution of _Fu_ and _Fv_ in achieving system observability. 

Same for underestimating, with very large initial _Fv_ negative values, but in this case _γ_ ’s convergence is fine, with problems only emerging in the other parameters. 

- _dv_ : By initially severely overestimating _dv_ , the convergence can be severely skewed, leading to misidentification, because _v_ is the driving force behind the generation of the intermittent extreme events of the system (in _u_ ); after all, observing these instabilities accelerates and corrects the algorithm’s current estimation of the parameters. 

Same for underestimating, with very large negative values, which, although leading to an incorrect estimation for _dv_ , the algorithm at least immediately corrects the sign to a positive one (unlike in _du_ ’s case). The convergence of all other parameters is effectively unaffected. 

Starting at zero for _dv_ initially has similar results as for negative initial values, i.e., they get quickly corrected, especially at the observance of extreme events. 

Finally, we note that even if _dv_ is misidentified, as in the case of the results shown in Figure 4.6 of Section 4.3.2, leading to lower-order or time-series-based errors, nevertheless the memory and fidelity of the dyad model, represented by the higher-order metrics like the PDFs and ACFs of _u_ and _v_ , are still effectively recovered. 

   - _Fv_ : Only for significant initial overestimation, it only slightly slows down and skews _dv_ ’s convergence, while it marginally aids in the convergence of _du_ and _dv_ when assumed to be negative and large. 

- Learning[=][(2] _[,]_[ 6] _[,]_[ 2] _[,]_[ 0] _[.]_[5] _[,]_[ 0] _[.]_[6)] `[T]`[, we have the following effects from adjusting the length of the] Period:[For the initial guess of] _**[ θ]**_[0] learning period from the 10 time units used in Section 4.3.2 (in [0 _,_ 200]). 

      - Increase: Convergence skill, i.e., reaching the same values as the ones depicted in Figure 4.6 of Section 4.3.2, is not hindered by increasing the learning period. But, we do note that a really long burn-in period, combined with severely wrong initial parameter guesses (which are the ones utilized during it), can be rather destructive and lead to incorrect values and even severe instability and divergence. Also, a significantly long learning period can severely slow 

38 

down convergence even for stable initial parameter values; e.g., by using a 30 time unitslong learning period in this case, we miss out on doing state estimation at the observance of the highly influential extreme event A (see Panel (a) in Figure 4.6). 

- Decrease: Still stable, but trace plots are highly variable initially if chosen to be really brief. These variations are smoothed out relatively quickly, and satisfactory convergence is achieved at the observance of extreme events (but _dv_ still converges to double the true value). Notably though, a training period that is at least a single time unit long is necessary for this case study; too small and _γ_ is thought to be zero, with similar results to as if we started with an initial guess of _γ_ = 0, as the learning period did not have enough data to showcase the presence of the energy-conserving quadratic coupling between _u_ and _v_ . 

We do note that it is possible to make this study into the sensitivity, stability and variability of the online EM parameter estimation algorithm much more rigorous, for this problem or model instance, by formulating an appropriate statistical response problem [ **78** ]: we identify the Fisher information matrix corresponding to the parameter estimation problem at hand as a function of a perturbation induced on the initial parameter values or learning period length, under sufficient regularity conditions, and then search for its most sensitive directions which are defined by its maximal eigenvectors (i.e., those corresponding to its largest eigenvalues). 

## **Appendix G Results of the Fixed-Lag Online EM Parameter Estimation Algorithm on –** (4.8) (4.9) 

In Figure G.1, we showcase the trace plots of the parameter value absolute errors that are produced by the adaptive-lag and fixed-lag online EM parameter estimation algorithms (for the parameters of interest). By noting that the average adaptive lag, over [10 _,_ 200], of the adaptive-lag online EM algorithm is about 0 _._ 1686 time units (see Panel (c) of Figure 4.6), for the fixed-lag online EM parameter estimation algorithm we use a constant lag of _Ln_ ∆ _t_ = 0 _._ 25 time units for all _n_ , i.e., for each newly acquired observation of the observed variable _u_ . This amounts to about a 50% increase from the mean adaptive lag. 

As already observed in the adaptive-lag online EM algorithm implementation from Section 4.3.2, the observed extreme events help accelerate and correct the algorithm’s divergence, regardless of whether a fixed or adaptive lag is used. Additionally, as expected, these two variations of the online EM parameter estimation method do not exhibit significant discrepancies for the forcing parameters, _Fu_ and _Fv_ , and the damping parameter of the unobserved variable, _dv_ . This is especially true after the algorithm is let run for long lead times. 

However, it quickly becomes evident that the adaptive-lag variation is superior in correctly identifying the values of the parameters which are the driving force behind the significant dynamics of the model. Specifically, the adaptive-lag method is better at estimating _du_ and _γ_ , and more importantly, the ratio _du/γ_ ; recall that whenever _v > du/γ_ , this induces an instability in _u_ , via anti-damping, which forms the system’s intermittent extreme events. This is especially apparent during the observation of extreme events, particularly after the highly influential events A and B. As such, despite the use of a fixed lag that is 50% longer than the average one found in the adaptive-lag online EM algorithm, the fact that the latter adaptively chooses longer lags during the emergence of extreme events, thus capturing the significant contributions which influence the posterior smoother state estimation, aids in its efficacious model identification. Furthermore, by using negligible lags during periods of large signal-to-noise ratios (e.g., at the demise of the extreme events in _u_ ), instead of a uniformly large fixed lag value throughout the run, the adaptive-lag strategy can also comparatively show significant storage savings, depending of course on the choice of its upper lag bound parameter ( _b_ ) and the fixed lag length (as is observed from the results in Figures 4.4 and C.1). 

39 

**==> picture [542 x 351] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Trace Plot of Error for d (b) Trace Plot of Error for d (c) Trace Plot of Error for F<br>u v u<br>2 1.2 1.5<br>A B C D A B C D<br>1<br>1.5<br> Adaptive-Lag Online EM 0.8 1<br> Fixed-Lag Online EM<br>1 0.6<br>0.4 0.5<br>0.5<br>0.2<br>A B C D<br>0 0 0<br>10 50 100 150 200 10 50 100 150 200 10 50 100 150 200<br>(f) Trace Plot of Error for d /γ<br>(d) Trace Plot of Error for Fv (e) Trace Plot of Error for γ (Anti-Damping Thresholdu)<br>1.5 3 0.25<br>A B C D A B C D A B C D<br>2.5<br>0.2<br>1 2<br>0.15<br>1.5<br>0.1<br>0.5 1<br>0.05<br>0.5<br>0 0 0<br>10 50 100 150 200 10 50 100 150 200 10 50 100 150 200<br>t t t<br>**----- End of picture text -----**<br>


Figure G.1: Panels (a)–(f): Trace plots of the parameter value absolute errors produced by the adaptive-lag (in red) and fixed-lag (in blue) online EM parameter estimation algorithms. 

40 

## **References** 

- [1] Uriel Frisch. _Turbulence: the legacy of AN Kolmogorov_ . Cambridge university press, 1995. 

- [2] Andrew Majda and Xiaoming Wang. _Nonlinear Dynamics and Statistical Theories for Basic Geophysical Flows_ . Cambridge University Press, 2006. 

- [3] Geoffrey K Vallis. _Atmospheric and Oceanic Fluid Dynamics_ . Cambridge University Press, 2017. 

- [4] Mohammad Farazmand and Themistoklis P. Sapsis. Extreme Events: Mechanisms and Prediction. _Applied Mechanics Reviews_ , 71(5), August 2019. 

- [5] Mark W. Denny, Luke J. H. Hunt, Luke P. Miller, and Christopher D. G. Harley. On the prediction of extreme ecological events. _Ecological Monographs_ , 79(3):397–421, August 2009. 

- [6] Mustafa A. Mohamad and Themistoklis P. Sapsis. Probabilistic Description of Extreme Events in Intermittently Unstable Dynamical Systems Excited by Correlated Stochastic Processes. _SIAM/ASA Journal on Uncertainty Quantification_ , 3(1):709–736, January 2015. 

- [7] Geir Evensen, Femke C Vossepoel, and Peter Jan Van Leeuwen. _Data assimilation fundamentals: A unified formulation of the state and parameter estimation problem_ . Springer Nature, 2022. 

- [8] Robert F Stengel. _Optimal control and estimation_ . Courier Corporation, 1994. 

- [9] Juan Jose Ruiz, Manuel Pulido, and Takemasa Miyoshi. Estimating model parameters with ensemble-based data assimilation: A review. _Journal of the Meteorological Society of Japan. Ser. II_ , 91(2):79–99, 2013. 

- [10] E. Kalnay. _Atmospheric Modeling, Data Assimilation and Predictability_ . Atmospheric Modeling, Data Assimilation, and Predictability. Cambridge University Press, 2003. 

- [11] William Lahoz, Boris Khattatov, and Richard M´enard. _Data Assimilation and Information_ , page 3–12. Springer Berlin Heidelberg, 2010. 

- [12] Andrew J. Majda and John Harlim. _Filtering Complex Turbulent Systems_ . Cambridge University Press, February 2012. 

- [13] Geir Evensen. _Data Assimilation: The Ensemble Kalman Filter_ . Springer Berlin Heidelberg, 2009. 

- [14] K. Law, A. Stuart, and K. Zygalakis. _Data Assimilation: A Mathematical Introduction_ . Texts in Applied Mathematics. Springer International Publishing, 2015. 

- [15] H. E. RAUCH, F. TUNG, and C. T. STRIEBEL. Maximum likelihood estimates of linear dynamic systems. _AIAA Journal_ , 3(8):1445–1450, August 1965. 

- [16] Nan Chen and Andrew J. Majda. Efficient nonlinear optimal smoothing and sampling algorithms for complex turbulent nonlinear dynamical systems with partial observations. _Journal of Computational Physics_ , 410:109381, June 2020. 

- [17] S. S¨arkk¨a and L. Svensson. _Bayesian Filtering and Smoothing_ . Institute of Mathematical Stat. Cambridge University Press, 2023. 

- [18] Sakari M Uppala, PW K˚allberg, Adrian J Simmons, U Andrae, V Da Costa Bechtold, M Fiorino, JK Gibson, J Haseler, A Hernandez, GA Kelly, et al. The ERA-40 re-analysis. _Quarterly Journal of the Royal Meteorological Society: A journal of the atmospheric sciences, applied meteorology and physical oceanography_ , 131(612):2961–3012, 2005. 

- [19] R. E. Kalman and R. S. Bucy. New Results in Linear Filtering and Prediction Theory. _Journal of Basic Engineering_ , 83(1):95–108, 03 1961. 

- [20] R.S. Bucy and P.D. Joseph. _Filtering for Stochastic Processes with Applications to Guidance_ . Chelsea Publishing Series. Chelsea Publishing Company, 1987. 

41 

- [21] Jeffrey L. Anderson. An Ensemble Adjustment Kalman Filter for Data Assimilation. _Monthly Weather Review_ , 129(12):2884–2903, December 2001. 

- [22] Pierre Del Moral. Nonlinear filtering: Interacting particle resolution. _Comptes Rendus de l’Acad´emie des Sciences - Series I - Mathematics_ , 325(6):653–658, September 1997. 

- [23] Jun S. Liu and Rong Chen. Sequential Monte Carlo Methods for Dynamic Systems. _Journal of the American Statistical Association_ , 93(443):1032–1044, September 1998. 

- [24] Genshiro Kitagawa. Monte Carlo Filter and Smoother for Non-Gaussian Nonlinear State Space Models. _Journal of Computational and Graphical Statistics_ , 5(1):1, March 1996. 

- [25] Frances Y Kuo and Ian H Sloan. Lifting the curse of dimensionality. _Notices of the AMS_ , 52(11):1320–1328, 2005. 

- [26] G. A. Gottwald and A. J. Majda. A mechanism for catastrophic filter divergence in data assimilation for sparse observation networks. _Nonlinear Processes in Geophysics_ , 20(5):705–712, September 2013. 

- [27] John Harlim and Andrew J. Majda. Catastrophic filter divergence in filtering nonlinear dissipative systems. _Communications in Mathematical Sciences_ , 8(1):27–43, 2010. 

- [28] Chris Snyder, Thomas Bengtsson, Peter Bickel, and Jeff Anderson. Obstacles to High-Dimensional Particle Filtering. _Monthly Weather Review_ , 136(12):4629–4640, December 2008. 

- [29] Nan Chen and Andrew J. Majda. Predicting observed and hidden extreme events in complex nonlinear dynamical systems with partial observations and short training time series. _Chaos: An Interdisciplinary Journal of Nonlinear Science_ , 30(3), March 2020. 

- [30] Jeroen D. Hol, Thomas B. Schon, and Fredrik Gustafsson. On Resampling Algorithms for Particle Filters. In _2006 IEEE Nonlinear Statistical Signal Processing Workshop_ . IEEE, September 2006. 

- [31] Steven J. Greybush, Eugenia Kalnay, Takemasa Miyoshi, Kayo Ide, and Brian R. Hunt. Balance and Ensemble Kalman Filter Localization Techniques. _Monthly Weather Review_ , 139(2):511–522, February 2011. 

- [32] Robert S. Liptser and Albert N. Shiryaev. _Statistics of Random Processes I: General Theory_ . Springer Berlin Heidelberg, 2001. 

- [33] Robert S. Liptser and Albert N. Shiryaev. _Statistics of Random Processes II: Applications_ . Springer Berlin Heidelberg, 2001. 

- [34] Nan Chen and Andrew Majda. Conditional Gaussian Systems for Multiscale Nonlinear Stochastic Systems: Prediction, State Estimation and Uncertainty Quantification. _Entropy_ , 20(7):509, July 2018. 

- [35] Nan Chen, Yingda Li, and Honghu Liu. Conditional Gaussian nonlinear system: A fast preconditioner and a cheap surrogate model for complex nonlinear systems. _Chaos: An Interdisciplinary Journal of Nonlinear Science_ , 32(5), 2022. 

- [36] Chuanqi Chen, Nan Chen, and Jin-Long Wu. CGNSDE: Conditional Gaussian neural stochastic differential equation for modeling complex systems and data assimilation. _Computer Physics Communications_ , 304:109302, 2024. 

- [37] N. Chen, A. J. Majda, and D. Giannakis. Predicting the cloud patterns of the Madden-Julian Oscillation through a low-order nonlinear stochastic model. _Geophysical Research Letters_ , 41(15):5612–5619, August 2014. 

- [38] Olivier Capp´e, Eric Moulines, and Tobias Ryd´en. Inference in hidden Markov models. In[´] _Springer Series in Statistics_ , 2010. 

- [39] Jimmy Olsson, Olivier Capp´e, Randal Douc, and Eric Moulines.[´] Sequential Monte Carlo smoothing with application to parameter estimation in nonlinear state space models. _Bernoulli_ , 14(1), February 2008. 

42 

- [40] Shashi Poddar and John L. Crassidis. Adaptive Lag Smoother for State Estimation. _Sensors_ , 22(14):5310, July 2022. 

- [41] Nan Chen, Andrew J Majda, and Xin T Tong. Information barriers for noisy Lagrangian tracers in filtering random incompressible flows. _Nonlinearity_ , 27(9):2133–2163, August 2014. 

- [42] Nan Chen, Andrew J. Majda, and Xin T. Tong. Noisy Lagrangian Tracers for Filtering Random Rotating Compressible Flows. _Journal of Nonlinear Science_ , 25(3):451–488, February 2015. 

- [43] Nan Chen, Evelyn Lunasin, and Stephen Wiggins. Lagrangian descriptors with uncertainty. _Physica D: Nonlinear Phenomena_ , 467:134282, 2024. 

- [44] Nan Chen and Andrew J. Majda. Filtering Nonlinear Turbulent Dynamical Systems through Conditional Gaussian Statistics. _Monthly Weather Review_ , 144(12):4885–4917, December 2016. 

- [45] Andrew J Majda and John Harlim. Physics constrained nonlinear regression models for time series. _Nonlinearity_ , 26(1):201–217, November 2012. 

- [46] John Harlim, Adam Mahdi, and Andrew J. Majda. An ensemble Kalman filter for statistical estimation of physics constrained nonlinear regression models. _Journal of Computational Physics_ , 257:782–812, January 2014. 

- [47] Nan Chen, Shubin Fu, and Georgy E Manucharyan. An efficient and statistically accurate Lagrangian data assimilation algorithm with applications to discrete element sea ice models. _Journal of Computational Physics_ , 455:111000, 2022. 

- [48] Nan Chen and Andrew J. Majda. Filtering the Stochastic Skeleton Model for the Madden–Julian Oscillation. _Monthly Weather Review_ , 144(2):501–527, January 2016. 

- [49] Nan Chen and Andrew J. Majda. Beating the curse of dimension with accurate statistics for the Fokker–Planck equation in complex turbulent systems. _Proceedings of the National Academy of Sciences_ , 114(49):12864–12869, November 2017. 

- [50] Nan Chen and Andrew J. Majda. Efficient statistically accurate algorithms for the Fokker–Planck equation in large dimensions. _Journal of Computational Physics_ , 354:242–268, February 2018. 

- [51] M. Branicki and A.J. Majda. Dynamic Stochastic Superresolution of sparsely observed turbulent systems. _Journal of Computational Physics_ , 241:333–363, May 2013. 

- [52] Shane R. Keating, Andrew J. Majda, and K. Shafer Smith. New Methods for Estimating Ocean Eddy Heat Transport Using Satellite Altimetry. _Monthly Weather Review_ , 140(5):1703–1722, May 2012. 

- [53] Andrew J. Majda and Ian Grooms. New perspectives on superparameterization for geophysical turbulence. _Journal of Computational Physics_ , 271:60–77, August 2014. 

- [54] Andrew J. Majda, Di Qi, and Themistoklis P. Sapsis. Blended particle filters for large-dimensional chaotic dynamical systems. _Proceedings of the National Academy of Sciences_ , 111(21):7511–7516, May 2014. 

- [55] Marios Andreou and Nan Chen. A Martingale-Free Introduction to Conditional Gaussian Nonlinear Systems. _Entropy_ , 27(1):2, 2024. 

- [56] Amos Lapidoth. _A Foundation in Digital Communication_ . Cambridge University Press, 2017. 

- [57] Wojciech Kolodziej. _Conditionally Gaussian Processes In Stochastic Control Theory._ Phd thesis, Oregon State University, January 1980. Available at https://ir.library.oregonstate.edu/concern/graduate_ thesis_or_dissertations/6d570069f. 

- [58] Demei Yuan and Lan Lei. Some results following from conditional characteristic functions. _Communications in Statistics-Theory and Methods_ , 45(12):3706–3720, 2016. 

- [59] Hisham Abou-Kandil, Gerhard Freiling, Vlad Ionescu, and Gerhard Jank. _Matrix Riccati Equations in Control and Systems Theory_ . Birkh¨auser Basel, 2003. 

43 

- [60] Adrian N. Bishop and Pierre Del Moral. On the stability of matrix-valued Riccati diffusions. _Electronic Journal of Probability_ , 24(none), January 2019. 

- [61] P.E. Kloeden and E. Platen. _Numerical Solution of Stochastic Differential Equations_ . Applications of mathematics : stochastic modelling and applied probability. Springer, 1992. 

- [62] C. Gardiner. _Stochastic Methods: A Handbook for the Natural and Social Sciences_ . Springer Series in Synergetics. Springer Berlin Heidelberg, 2009. 

- [63] Rafail Khasminskii. _Stochastic Stability of Differential Equations_ . Springer Berlin Heidelberg, 2012. 

- [64] Tobias Neckel and Florian Rupp. _Random Differential Equations in Scientific Computing_ . Versita, 2013. 

- [65] Qi L¨u and Xu Zhang. _Mathematical control theory for stochastic partial differential equations_ , volume 101. Springer, 2021. 

- [66] L. Arnold. _Random Dynamical Systems_ . Springer, 2014. 

- [67] Heydar Radjavi and Peter Rosenthal. _Simultaneous Triangularization_ . Springer New York, 2000. 

- [68] M. Goldberg and G. Zwas. On matrices having equal spectral radius and spectral norm. _Linear Algebra and its Applications_ , 8(5):427–434, October 1974. 

- [69] Kai Liu. _Stochastic stability of differential equations in abstract spaces_ , volume 453. Cambridge University Press, 2019. 

- [70] Thomas M. Cover and Joy A. Thomas. _Elements of Information Theory_ . Wiley, April 2005. 

- [71] Andrew J. Majda and Michal Branicki. Lessons in uncertainty quantification for turbulent dynamical systems. _Discrete & Continuous Dynamical Systems - A_ , 32(9):3133–3221, 2012. 

- [72] Michal Branicki and Andrew J Majda. Quantifying uncertainty for predictions with model error in non-Gaussian systems with intermittency. _Nonlinearity_ , 25(9):2543–2578, August 2012. 

- [73] Dimitrios Giannakis, Andrew J. Majda, and Illia Horenko. Information theory, model error, and predictive skill of stochastic models for complex nonlinear systems. _Physica D: Nonlinear Phenomena_ , 241(20):1735–1752, October 2012. 

- [74] Imre Csisz´ar, Paul C Shields, et al. Information theory and statistics: A tutorial. _Foundations and Trends® in Communications and Information Theory_ , 1(4):417–528, 2004. 

- [75] Friedrich Liese and Igor Vajda. On divergences and informations in statistics and information theory. _IEEE Transactions on Information Theory_ , 52(10):4394–4412, 2006. 

- [76] S. Kullback and R. A. Leibler. On Information and Sufficiency. _The Annals of Mathematical Statistics_ , 22(1):79–86, March 1951. 

- [77] S. Kullback. _Information Theory and Statistics_ . A Wiley publication in mathematical statistics. Dover Publications, 1997. 

- [78] Andrew J. Majda and Boris Gershgorin. Quantifying uncertainty in climate change science through empirical information theory. _Proceedings of the National Academy of Sciences_ , 107(34):14958–14963, August 2010. 

- [79] Richard Kleeman. Information Theory and Dynamical System Predictability. _Entropy_ , 13(3):612–649, March 2011. 

- [80] David Cai, Richard Kleeman, and Andrew Majda. A Mathematical Framework for Quantifying Predictability Through Relative Entropy. _Methods and Applications of Analysis_ , 9(3):425–444, 2002. 

44 

- [81] M. Branicki and A. J. Majda. Quantifying Bayesian filter performance for turbulent dynamical systems through information theory. _Communications in Mathematical Sciences_ , 12(5):901–978, 2014. 

- [82] Richard Kleeman. Measuring Dynamical Prediction Utility Using Relative Entropy. _Journal of the Atmospheric Sciences_ , 59(13):2057 – 2072, 2002. 

- [83] Timothy DelSole. Predictability and Information Theory. Part I: Measures of Predictability. _Journal of the Atmospheric Sciences_ , 61(20):2425–2440, October 2004. 

- [84] Timothy DelSole. Predictability and Information Theory. Part II: Imperfect Forecasts. _Journal of the Atmospheric Sciences_ , 62(9):3368–3381, September 2005. 

- [85] Grant Branstator and Haiyan Teng. Two Limits of Initial-Value Decadal Predictability in a CGCM. _Journal of Climate_ , 23(23):6292–6311, December 2010. 

- [86] Huafeng Liu, Youmin Tang, Dake Chen, and Tao Lian. Predictability of the Indian Ocean Dipole in the coupled models. _Climate Dynamics_ , 48(5–6):2005–2024, June 2016. 

- [87] Marios Andreou and Nan Chen. Statistical Response of ENSO Complexity to Initial Condition and Model Parameter Perturbations. _Journal of Climate_ , August 2024. 

- [88] Jie Sun, Dane Taylor, and Erik M Bollt. Causal network inference by optimal causation entropy. _SIAM Journal on Applied Dynamical Systems_ , 14(1):73–106, 2015. 

- [89] Katerina Hlav´aˇckov´a-Schindler, Milan Paluˇs, Martin Vejmelka, and Joydeep Bhattacharya. Causality detection based on information-theoretic approaches in time series analysis. _Physics Reports_ , 441(1):1–46, 2007. 

- [90] K. Ogata. _Modern Control Engineering_ . Instrumentation and controls series. Pearson, 2010. 

- [91] R.C. Dorf and R.H. Bishop. _Modern Control Systems_ . Pearson, 2017. 

- [92] A. Apte, C. K. R. T. Jones, and A. M. Stuart. A Bayesian approach to Lagrangian data assimilation. _Tellus A_ , March 2008. 

- [93] Kayo Ide, Leonid Kuznetsov, and Christopher K R T Jone. Lagrangian data assimilation for point vortex systems. _Journal of Turbulence_ , 3:N53, January 2002. 

- [94] Annalisa Griffa, AD Kirwan Jr, Arthur J Mariano, Tamay Ozg¨okmen,[¨] and H Thomas Rossby. _Lagrangian analysis and prediction of coastal and ocean dynamics_ . Cambridge University Press, 2007. 

- [95] Sergio Castellari, Annalisa Griffa, Tamay M Ozg¨okmen, and Pierre-Marie Poulain.[¨] Prediction of particle trajectories in the Adriatic Sea using Lagrangian data assimilation. _Journal of Marine Systems_ , 29(1-4):33–50, 2001. 

- [96] H Salman, K Ide, and Christopher KRT Jones. Using flow geometry for drifter deployment in Lagrangian data assimilation. _Tellus A: Dynamic Meteorology and Oceanography_ , 60(2):321–335, 2008. 

- [97] Marc Honnorat, J´erˆome Monnier, and Franc¸ois-Xavier Le Dimet. Lagrangian data assimilation for river hydraulics simulations. _Computing and visualization in science_ , 12(5):235–246, 2009. 

- [98] Nan Chen, Shubin Fu, and Georgy Manucharyan. Lagrangian Data Assimilation and Parameter Estimation of an Idealized Sea Ice Discrete Element Model. _Journal of Advances in Modeling Earth Systems_ , 13(10), September 2021. 

- [99] Jeffrey Covington, Nan Chen, and Monica M Wilhelmus. Bridging Gaps in the Climate Observation Network: A Physics-Based Nonlinear Dynamical Interpolation of Lagrangian Ice Floe Measurements via Data-Driven Stochastic Models. _Journal of Advances in Modeling Earth Systems_ , 14(9):e2022MS003218, 2022. 

- [100] Andrew Majda. _Introduction to PDEs and Waves for the Atmosphere and Ocean_ . American Mathematical Society, January 2003. 

45 

- [101] P. F. J. Lermusiaux. Data Assimilation via Error Subspace Statistical Estimation.: Part II: Middle Atlantic Bight Shelfbreak Front Simulations and ESSE Validation. _Monthly Weather Review_ , 127(7):1408–1432, July 1999. 

- [102] Harry H Hendon, Eunpa Lim, Guomin Wang, Oscar Alves, and Debra Hudson. Prospects for predicting two flavors of El Ni˜no. _Geophys. Res. Lett._ , 36(19), October 2009. 

- [103] Rolf Sundberg. An iterative method for solution of the likelihood equations for incomplete data from exponential families. _Communication in Statistics-Simulation and Computation_ , 5(1):55–64, 1976. 

- [104] Zoubin Ghahramani and Geoffrey E. Hinton. Parameter estimation for linear dynamical systems. Technical report, Technical Report CRG-TR-96-2, University of Totronto, Dept. of Computer Science, 1996. 

- [105] Zoubin Ghahramani and Sam Roweis. Learning Nonlinear Dynamical Systems Using an EM Algorithm. In M. Kearns, S. Solla, and D. Cohn, editors, _Advances in Neural Information Processing Systems_ , volume 11. MIT Press, 1998. 

- [106] Todd K Moon. The expectation-maximization algorithm. _IEEE Signal processing magazine_ , 13(6):47–60, 1996. 

- [107] Nan Chen. Learning nonlinear turbulent dynamics from partial observations via analytically solvable conditional statistics. _Journal of Computational Physics_ , 418:109635, October 2020. 

- [108] A. Dembo and O. Zeitouni. Parameter estimation of partially observed continuous time stochastic processes via the EM algorithm. _Stochastic Processes and their Applications_ , 23(1):91–113, October 1986. 

- [109] Juho Kokkala, Arno Solin, and Simo S¨arkk¨a. Expectation maximization based parameter estimation by sigma-point and particle smoothing. In _17th International Conference on Information Fusion (FUSION)_ , pages 1–8, 2014. 

- [110] Nan Chen and Yinling Zhang. A causality-based learning approach for discovering the underlying dynamics of complex systems from partial observations with stochastic parameterization. _Physica D: Nonlinear Phenomena_ , 449:133743, 2023. 

- [111] Radford M Neal and Geoffrey E Hinton. A view of the EM algorithm that justifies incremental, sparse, and other variants. In _Learning in graphical models_ , pages 355–368. Springer, 1998. 

- [112] Trevor Hastie, Jerome Friedman, and Robert Tibshirani. _The Elements of Statistical Learning_ . Springer New York, 2001. 

- [113] Roderick JA Little and Donald B Rubin. _Statistical analysis with missing data_ , volume 793. John Wiley & Sons, 2019. 

- [114] Yihua Chen and Maya R Gupta. EM Demystified: An expectation-maximization tutorial. _Electrical Engineering_ , 206, 2010. 

- [115] C. F. Jeff Wu. On the Convergence Properties of the EM Algorithm. _The Annals of Statistics_ , 11(1), March 1983. 

- [116] Yurii Nesterov. A method for solving the convex programming problem with convergence rate _O_ (1 _/k_[2] ). In _Dokl akad nauk Sssr_ , volume 269, page 543, 1983. 

46 

