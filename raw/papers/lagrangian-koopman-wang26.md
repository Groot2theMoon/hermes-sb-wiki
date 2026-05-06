---
title: "A Lagrangian Conditional Gaussian Koopman Network for Data Assimilation and Prediction"
arxiv: "2603.1411"
authors: ["Zhongrui Wang", "Chuanqi Chen", "Jin-Long Wu", "Nan Chen"]
year: 2026
source: paper
ingested: 2026-05-06
sha256: c7508dfce72e79e8c014a254e8d19f02e239d57f25b01fa1a5c269c126d16a5b
conversion: pymupdf4llm
---

# **A Lagrangian Conditional Gaussian Koopman Network for Data Assimilation and Prediction** 

Zhongrui Wang[1] , Chuanqi Chen[2] , Jin-Long Wu[2] , and Nan Chen[1,*] 

1Department of Mathematics, University of Wisconsin–Madison, Madison, WI 53706, USA 

2Department of Mechanical Engineering, University of Wisconsin–Madison, Madison, WI 

53706, USA 

*Corresponding author: Nan Chen, chennan@math.wisc.edu 

March 17, 2026 

## **Abstract** 

Lagrangian data assimilation seeks to recover hidden Eulerian flow fields from sparse and indirect observations of moving tracers. This problem is fundamentally challenging because of the nonlinear coupling between tracer trajectories and the underlying flow, rendering posterior inference computationally intractable for realistic, high-dimensional systems. In this work, we develop a Lagrangian conditional Gaussian Koopman network (LaCGKN), a structure-preserving and data-driven framework for joint data assimilation and prediction from Lagrangian observations. LaCGKN embeds the Eulerian flow dynamics into a low-dimensional latent space governed by a nonlinear stochastic system with conditional Gaussian structures, enabling analytic posterior updates without ensemble forecasting. Different from existing conditional Gaussian Koopman formulations that rely on direct Eulerian observations, the Lagrangian setting introduces additional constraints on the latent representation, which must simultaneously encode the flow dynamics and mediate nonlinear tracer-flow interactions. To address these challenges, the LaCGKN incorporates three key architectural components: (i) tracer homogenization to enforce permutation equivariance and enable generalization across varying numbers of tracers; (ii) Fourier-based positional encoding to capture spatial dependence and reconstruct local flow features at moving tracer locations; and (iii) an SVD-inspired low-rank parameterization of the latent transition operator, which reduces parameter complexity while preserving expressive capacity. An application to a two-layer quasi-geostrophic flow with surface tracer observations demonstrates that LaCGKN achieves accurate and efficient Lagrangian data assimilation and prediction, without reliance on ensemble methods or the governing physical model. These results establish the LaCGKN as a unified and computationally tractable alternative to both traditional model-based approaches and purely black-box data-driven methods. 

## **1 Introduction** 

Lagrangian data consist of trajectories of moving tracers, such as drifters and floats, that follow particle motions within a flow. By recording the time-evolving positions of these tracers, Lagrangian observations provide a direct window into the transport properties of the underlying flow field and are widely used to characterize large-scale circulation patterns, coherent structures, and mixing processes (Businger et al., 1996; Gould et al., 2004; Lumpkin et al., 2017; Centurioni et al., 2017). While valuable information can be extracted from Lagrangian trajectories through direct analysis, a more systematic and powerful approach is to integrate these observations with dynamical or statistical models through Lagrangian data assimilation. In the Lagrangian setting, the data assimilation objective is to estimate the underlying flow state using observations of tracer trajectories (Mariano et al., 2002; Ide et al., 2002). The importance of Lagrangian data assimilation in both geophysical research and operational forecasting continues to grow, driven by the rapid expansion of global Lagrangian observing systems (Legler et al., 

1 

2015; McPhaden et al., 2023). However, a fundamental challenge arises from the nature of the observation process: Lagrangian measurements are obtained by evaluating the local flow velocity at tracer positions that evolve in time, resulting in a highly nonlinear observation operator (Ide et al., 2002; Kuznetsov et al., 2003). When combined with the strongly nonlinear and often turbulent dynamics of geophysical flows, this intrinsic nonlinearity renders Lagrangian data assimilation particularly challenging. As a consequence, analytic expressions for the posterior distribution are generally intractable for realistic, high-dimensional systems. 

Early approaches to Lagrangian data assimilation addressed nonlinearity by augmenting Eulerian flow models with explicit tracer dynamics and applying Kalman-filter-based methods. Representative examples include the use of the extended Kalman filter (EKF) to assimilate tracer trajectories (Ide et al., 2002), the optimal interpolationbased schemes that treat finite-difference Lagrangian velocities as surrogate observations with constant gain (Molcard et al., 2003), and applying the local ensemble transform Kalman filter (LETKF) to drifters (Sun and Penny, 2019; Chen et al., 2022). While these approaches remain attractive for operational applications, their reliance on Gaussian assumptions and linear correction steps can sometimes limit accuracy in strongly nonlinear regimes. To better represent nonlinearity and non-Gaussianity, particle filters (PF; van Leeuwen et al., 2019) and Markov chain Monte Carlo (MCMC) smoothers (Apte et al., 2008) have been explored, but their computational cost poses severe challenges for high-dimensional systems. Hybrid strategies attempt to balance the trade-off between approximation accuracy and computational cost, for example, by combining particle filtering for nonlinear tracer dynamics with ensemble Kalman filtering for near-Gaussian flow estimation (Slivinski et al., 2015), or by exploiting special structures to account for flow nonlinearity (Wang et al., 2025). Despite these advances, designing Lagrangian data assimilation methods that simultaneously achieve high accuracy and computational efficiency remains an open challenge. 

Traditional data assimilation methods are predominantly deductive (model-based), derived from first principles through Bayes’ rule. Posterior inference is carried out explicitly via variational optimization, such as 3D/4D-Variational methods (Lorenc, 1986, 2003), or Monte Carlo-based filtering approaches, such as the ensemble Kalman filter (EnKF; Evensen, 1994). To remain computationally feasible for high-dimensional systems, these methods typically impose strong structural assumptions, most notably Gaussian error statistics and linearized dynamics or observation operators. Driven by advances in machine learning, inductive (data-driven) approaches to data assimilation have gained increasing attention (Cheng et al., 2023; Bach et al., 2025). Developments in scientific machine learning (SciML) have enabled flexible surrogate models for complex dynamical systems, including recurrent neural networks (Schuster and Paliwal, 1997; Hochreiter and Schmidhuber, 1997; Gauthier et al., 2021), neural ODEs (Chen et al., 2019), physics-informed neural networks (Raissi et al., 2019), neural operators (Lu et al., 2021; Li et al., 2021; Chen and Wu, 2025), and generative models for stochastic systems (Du et al., 2024; Dong et al., 2025; Stamatelopoulos and Sapsis, 2025). When combined with traditional filters and smoothers, SciML can enhance data assimilation by providing efficient forecast models (Penny et al., 2022), correcting model errors (Farchi et al., 2023), or learning components of the analysis map (Bach et al., 2025). More recently, hybrid approaches that preserve analytically tractable nonlinear structures, such as conditional Gaussian neural stochastic differential equations, have been proposed to balance expressiveness with efficient posterior inference (Chen et al., 2024). Furthermore, fully data-driven methods attempt to learn the analysis or posterior mapping directly (Bocquet et al., 2024). Other examples include ensemble transport (Spantini et al., 2022), generative data assimilation (Qu et al., 2024; Li et al., 2025; Martin et al., 2025; Yang et al., 2025), and approaches that jointly learn forecast and analysis maps (Fablet et al., 2021; Boudier et al., 2023). Collectively, these developments span a spectrum from deductive to inductive, highlighting an ongoing exploration of the trade-off among physical interpretability, statistical rigor, and computational efficiency. 

However, most data-driven data assimilation methods have been developed for Eulerian observations on fixed spatial grids. In contrast, the use of machine learning for Lagrangian data assimilation remains relatively limited, with only a few recent examples combining neural operators with generative models (Asefi et al., 2025) or multimodal contrastive learning (Baptista et al., 2025). This disparity is notable, as machine learning is particularly well suited to addressing the strong nonlinearity inherent in Lagrangian observations and therefore has substantial potential to improve both accuracy and computational efficiency. A related development is the conditional Gaussian Koopman network (CGKN; Chen et al., 2025a,b), which introduces a data-driven dynamical model embedded within a conditional Gaussian nonlinear stochastic system that admits analytic posterior updates and avoids various tunings often required by ensemble-based methods. By incorporating principled filtering formulas directly into the 

2 

model architecture as an inductive bias, CGKN provides a structured interface between SciML and data assimilation. However, existing CGKN formulations are restricted to systems with direct, partial Eulerian observations, and do not address the fundamental challenges posed by Lagrangian data. 

In this work, we develop a Lagrangian conditional Gaussian Koopman network (LaCGKN) for estimating the underlying flow field from tracer trajectories. Beyond the intrinsic nonlinearity of Lagrangian data assimilation, this setting introduces challenges that are qualitatively distinct from those encountered in CGKN with Eulerian observations. In particular, the latent representation must simultaneously support an efficient and accurate encoding of the Eulerian flow dynamics and a nonlinear yet structured observation mechanism that governs tracer motion. The latter plays a central role in Lagrangian data assimilation, as it determines how information carried by moving tracers propagates to the unobserved flow field, thereby imposing additional constraints on the latent embedding that are absent in Eulerian settings. To address these challenges, we construct a purely data-driven surrogate that embeds the Eulerian flow into a low-dimensional latent space while modeling tracer dynamics as a nonlinear function of tracer positions driven by the latent state. This design preserves a nonlinear yet conditional Gaussian structure, enabling analytic filtering in latent space without ensemble forecasting of the physical model. The resulting LaCGKN incorporates three key architectural components: (i) tracer homogenization, which enforces tracer permutation equivariance and enables generalization across varying numbers of tracers; (ii) Fourier-based positional encoding, which captures rich spatial dependence and facilitates reconstruction of local flow features at moving tracer positions; and (iii) an SVD-inspired low-rank parameterization, which maintains expressive capacity at high latent dimensions while controlling computational cost. Together, these design choices enable accurate and efficient Lagrangian data assimilation and prediction, offering a unified alternative to both traditional model-based approaches and purely black-box data-driven methods. 

The rest of the paper is organized as follows. Section 2 introduces the formulation of Lagrangian data assimilation and discrete-time CGKN, and then formalizes the LaCGKN for data assimilation and prediction, highlighting the key architectural design choices. Section 3 demonstrates the proposed method with an application to a two-layer quasi-geostrophic flow with surface tracer observations. For prediction, LaCGKN is compared to a deep-learning baseline that uses a deep neural network (DNN) for tracer prediction and a convolutional neural network (CNN) for flow prediction, as well as a trivial persistence baseline. For data assimilation, LaCGKN is compared to EnKF, OI, and a naive climatology baseline. Section 4 concludes the paper with discussions. 

## **2 Methodology** 

## **2.1 Lagrangian data assimilation** 

Lagrangian data assimilation aims at assimilating Lagrangian observations that are often driven by a flow described under Eulerian coordinates. To illuminate the idea, we focus on a canonical setup: Lagrangian observations of passive tracer positions driven by an Eulerian flow, described as 

**==> picture [302 x 46] intentionally omitted <==**

where **x** _i_ ( _t_ ) _∈_ Ω _⊂_ R _[d]_ is the observed position of the _i_ th tracer, and **v** ( **x** _,t_ ) _∈_ R _[d]_ is the flow velocity field with ( **x** _,t_ ) _∈_ Ω **W** ˙ _×_ and (0 _,_ the _T_ ]. noiseThe flow operatorstrength matrix _F_ **Σ** is nonlinear in general., representing the uncertaintyThe system is stochastic with the Gaussian white noisedue to the unresolved details. This formulation can be generalized to arbitrary Lagrangian observations by modifying (1a) describing the Lagrangian observation with dependence on the tracer position. This canonical setup already reveals a key challenge in Lagrangian data assimilation. That is, the Lagrangian observational process is nonlinear, because the composition **v** ( **x** _i_ ( _t_ ) _,t_ ) is generally nonlinear in **x** _i_ ( _t_ ). 

In practice, a discrete version of (1) is considered as follows: 

3 

**==> picture [317 x 34] intentionally omitted <==**

where **x** _[n] i_[:][=] **[ x]** _[i]_[(] _[t][n]_[)] _[ ∈]_[Ω][and] **[ v]** _[n]_[ :][=] **[ v]**[(] _[·][,][t][n]_[)] _[|]_ Ω[(] **x** _[M]_[)] _∈_ R _[dM]_ are the corresponding state variables evaluated at discrete time _tn_ with time interval _tn_ +1 _− tn_ = ∆ _t_ and an _M_ -point discrete spatial domain Ω[(] **x** _[M]_[)] . The _Th_ and _Fh_ are the solution maps of tracer and flow, respectively, from _tn_ to _tn_ +1. The tracer operator _Th_ typically involves an interpolation or integral operator (e.g., Fourier transform) that evaluates **v** ( **x** _[n] i[,][t][n]_[)][ at a local tracer position] **[ x]** _[n] i_[.] 

The Lagrangian filtering problem defined in the discrete setup (2) seeks to find the posterior distribution of the unobserved flow states **v** _[n]_ given past data of tracer observations _{_ **x** _[n] i[}][I] i_ = _[,][n]_ 1 _,s_ =0[, that is] 

**==> picture [263 x 15] intentionally omitted <==**

Since the solution maps _Th_ and _Fh_ are typically nonlinear, an analytic solution of the posterior distribution is almost intractable for high-dimensional systems in practice, making Lagrangian data assimilation a challenging problem. 

## **2.2 Discrete-time CGKN** 

The conditional Gaussian Koopman network (CGKN; Chen et al., 2025a,b) is a unified deep learning framework that allows efficient data assimilation and state forecast. It transforms the original dynamical system into one with a conditional Gaussian structure, where the posterior distribution of embedded unobserved variables can be solved via analytic formulae. The transformed dynamical system serves as a surrogate model, enabling efficient data assimilation and state forecast. The assimilated and predicted states are then mapped back to the original state space to obtain the final results. 

Consider a partially observed discrete-time dynamical system in the general form of 

**==> picture [266 x 30] intentionally omitted <==**

where **u** 1 _∈_ R _[d]_[1] and **u** 2 _∈_ R _[d]_[2] are vectors representing the observed states and unobserved states, respectively. The state transition operators _G_ 1 and _G_ 2 map the solutions from _tn_ to _tn_ +1, with time interval ∆ _t_ = _tn_ +1 _− tn_ . For the discrete dynamical system (4), CGKN transforms it into a surrogate model of the following form: 

**==> picture [300 x 30] intentionally omitted <==**

where **z** _∈_ R _[d]_ **[z]** are latent embeddings of the original unobserved states **u** 2. The transformation between latent states and original states is realized through **z** = _E_ ( **u** 2) and **u** 2 = _D_ ( **z** ), where _E_ : R _[d]_[2] _�→_ R _[d]_ **[z]** is the encoder and _D_ : R _[d]_ **[z]** _�→_ R _[d]_[2] is the decoder. The coefficients **F** 1, **G** 1, **F** 2, and **G** 2 are functions of the observed states **u** 1. The terms **Σ** 1 _**ϵ**_ 1 and **Σ** 2 _**ϵ**_ 2 are Gaussian white noise multiplied by the noise strength matrices. In practice, the encoder _E_ , the decoder _D_ , and the coefficient functions **F** 1, **G** 1, **F** 2, **G** 2 are parameterized by neural networks. The noise strength matrix **Σ** 1 is estimated by the one-step residual error of the observed states **u** 1 using a trained CGKN without DA loss. The noise strength matrix **Σ** 2 can be set manually or as a training parameter. 

The surrogate model (5) has a notable conditional Gaussian structure that allows for efficient data assimilation. Specifically, because **F** 1, **G** 1, **F** 2, and **G** 2 are only functions of **u** 1, **z** is conditionally linear given an observed trajectory of **u** 1. As a result, the conditional distribution _p_ ( **z** _[n] |{_ **u** _[s]_ 1 _[}][n] s_ =0[) =] _[ N]_[(] _**[µ]**_ **z** _[n][,]_ **[R]** _[n]_ **z**[)][ is Gaussian with the mean] and covariance solvable by the analytic formulae: 

**==> picture [319 x 30] intentionally omitted <==**

4 

where 

**==> picture [309 x 15] intentionally omitted <==**

and **F** _[n] i_[:][=] **[ F]** _[i]_ � **u** _[n]_ 1� _,_ **G** _[n] i_[:][=] **[ G]** _[i]_ � **u** _[n]_ 1�, for _i_ = 1 _,_ 2. The closed analytic formulae allow exact and accurate data assimilation solution and avoid empirical tunings as in many ensemble methods. The posterior mean of the latent states is transformed back to the original states through the decoder _**µ**[n]_ 2[+][1] = _D_ ( _**µ**[n]_ **z**[+][1] ). The posterior covariance **R** _[n]_ 2[of the] unobserved states can be calculated through residual analysis, a post-process of CGKN to quantify the uncertainty of the posterior mean. 

## **2.3 LaCGKN** 

**LaCGKN surrogate.** In the discrete tracer-flow system (2), Lagrangian tracer positions are observed and the Eulerian flow field is to be recovered. This leads to a natural definition of the observed and unobserved variables in the discrete-time CGKN: 

**==> picture [358 x 15] intentionally omitted <==**

where **u** 1 collects all the Lagrangian tracer positions and **u** 2 contains the Eulerian flow states over discrete spatial domain Ω[(] **x** _[M]_[)] . The resulting LaCGKN surrogate model takes the form 

**==> picture [300 x 29] intentionally omitted <==**

which coincides with the general discrete-time CGKN formulation (5), except that **F** 2 and **G** 2 are now trainable constants instead of functions of **u** _[n]_ 1[.][This simplification leverages the physical assumption that passive tracers do] not influence the underlying flow. The Eulerian flow **u** _[n]_ 2[is][mapped][into][a][low-dimensional][latent][embedding] **[z]** _[n]_ via an encoder _E_ , and mapped back to physical states via a decoder _D_ . This flow embedding aligns with modern applied Koopman theory based on deep learning (Lusch et al., 2018), but with a key distinction: the embedded flow **z** is coupled to the nonlinear tracer dynamics through (9a). Together, the linear latent flow dynamics (9b) and the transformed tracer dynamics (9a) consist of the LaCGKN surrogate model. An overview of the LaCGKN is shown in Figure 1. 

**LaCGKN for data assimilation and state forecast.** LaCGKN performs efficient data assimilation and state forecasting in latent space. For data assimilation, the posterior mean and covariance of the latent state are updated analytically using the conditional Gaussian filter (6), which avoids ensemble propagation and empirical tunings. The posterior mean of the physical flow is then obtained by decoding the latent posterior mean via the decoder _D_ . While the posterior uncertainty of the physical flow does not admit a closed-form expression because of the nonlinear decoding, an auxiliary uncertainty network _U_ can be employed as a post-processing step to estimate the posterior covariance in physical space. The network _U_ takes the observed state **u** 1 as input and predicts the residual _∥_ **u** _[⋆]_ 2 _[−]_ _**[µ]**_[2] _[∥]_[,][where] **[ u]** _[⋆]_ 2[denotes the ground truth and] _**[ µ]**_[2][ =] _[ D]_[(] _**[µ]**_ **[z]**[)][ is the decoded posterior mean.][Under a] Gaussian assumption, this residual provides a maximum-likelihood estimate of the posterior standard deviation of the physical flow. For state forecasting, the tracer state and latent flow are advanced using the LaCGKN surrogate model (9), and the physical flow is recovered by decoding the predicted latent flow. Since both filtering and forecasting operate in a typically low-dimensional latent space, LaCGKN is highly efficient for high-dimensional turbulent systems. 

It is worth highlighting that the Lagrangian observations (i.e., tracer positions) are indirect observations of the hidden system states (i.e., flow fields), and are coupled with the hidden states through a nonlinear dynamical process. This differs from previous applications of CGKN, where the observed variables are direct yet partial observations of the same underlying system. The Lagrangian data assimilation is thus a more challenging yet practical problem for CGKN, where not only the nonlinear flow dynamics needs to be well approximated by a latent linear dynamics, as in standard Koopman theory, but also the nonlinear tracer dynamics should be well approximated by (5a). The latter is crucial to data assimilation, as it captures the information propagation from observed states to unobserved states. This imposes additional requirements and regularizations for latent embedding **z** . Furthermore, 

5 

**==> picture [454 x 328] intentionally omitted <==**

Figure 1: Overview of the Lagrangian conditional Gaussian Koopman network (LaCGKN). (a) The nonlinear tracer-flow system is mapped to a neural conditional Gaussian nonlinear system (Neural CGNS) by encoding the unobserved flow and mapped back by decoding the latent variables. (b) LaCGKN consists of an auto-encoder ( _E, D_ ) and conditional Gaussian network (CGN) _η_ . The CGN outputs the coefficients **F** 1 _,_ **G** 1 _,_ **F** 2 _,_ **G** 2 of the Neural CGNS. The parameterization of **F** 1 and **G** 1 incorporates tracer homogenization and Fourier positional encoding, while **G** 2 is represented by an SVD-inspired low-rank approximation. An auxiliary uncertainty network _U_ is used to estimate the posterior standard deviation of the flow. (c) LaCGKN performs efficient data assimilation and prediction in latent space using the conditional Gaussian filter. 

6 

when the modeling system is high-dimensional and highly turbulent, as is common in geophysical applications, a relatively large latent dimension may be needed, thus increasing the computational cost of CGKN. In this work, we address these challenges by introducing the following innovative design choices. 

**(a) Homogenization over tracers.** Lagrangian tracers can often be assumed to be homogeneous and exchangeable. This is already implied in tracer equation (1a), where different tracers obey the same dynamical law. We therefore construct the LaCGKN observation operators **F** 1 and **G** 1 by applying the same neural networks to each tracer position independently, namely, 

**==> picture [308 x 34] intentionally omitted <==**

where **f** _θ_ : R _[d] →_ R _[d]_ and **G** _θ_ : R _[d] →_ R _[d][×][d]_ **[z]** are neural networks with shared parameters across all tracers. The tracer update then takes the form 

**==> picture [331 x 13] intentionally omitted <==**

This design ensures that the surrogate dynamics is permutation-equivariant with respect to tracers, and it allows the same LaCGKN to be trained once and then applied to an arbitrary number of tracers in the test stage. In implementation, the invariance to tracer permutation is further encouraged by randomly subsampling different tracer subsets during training, while prediction and filtering always use the same set of shared networks **f** _θ_ and **G** _θ_ . Compared to using large neural networks that take all tracer positions **u** _[n]_ 1[as input to parameterize] **[ F]**[1][and] **[ G]**[1][,] tracer homogenization greatly regularizes the model, simplifies model development, and improves computational efficiency. 

**(b) Fourier-based positional encoding.** To accurately reconstruct the local value of the Eulerian flow field at moving tracer locations, **G** _θ_ ( **x** _[n] i_[)][must][learn][a][rich][and][nonlinear][dependence][on][position.][We][therefore][adopt] Fourier-based positional encoding for tracer locations, which has been shown to significantly improve the ability of neural networks to represent high-frequency spatial variations (Tancik et al., 2020; Mildenhall et al., 2020). For a tracer at position **x** _[n] i_[= (] _[x] i[n] ,_ 1 _[,...,][x] i[n] ,d_[)][on][a][periodic][domain,][a][Fourier][positional][feature][can][be][constructed][by] augmenting **x** _[n] i_[with a sequence of trigonometric functions:] 

**==> picture [348 x 19] intentionally omitted <==**

which is then fed into the networks **f** _θ_ and **G** _θ_ . This encoding also admits physical heuristics from the tracer equation. Recall that the solution operator _Th_ � **x** _[n] i[,]_ **[v]** _[n]_[�] in (2a) typically involves evaluating the Eulerian velocity field at tracer locations **v** ( **x** _[n] i[,][t][n]_[)][ through Fourier transforms, where Fourier coefficients at different frequencies are] multiplied by their corresponding Fourier basis functions and are then linearly summed up. The Fourier-based positional encoding plays a similar role as the Fourier basis function here. It greatly enhances the expressivity of **G** 1� **u** _[n]_ 1� **z** _[n]_ in approximating the nonlinear composition **v** ( **x** _[n] i[,][t][n]_[)][,][and][facilitates the][discovery of][a compact][latent] embedding **z** . 

**(c) Low-rank approximation of G** 2 **for scalability.** When a relatively high latent dimension is needed for embedding high-dimensional complex flow systems, the latent transition matrix **G** 2 _∈_ R _[d]_ **[z]** _[×][d]_ **[z]** can be a computational bottleneck of CGKN, as its parameter count scales quadratically with the latent dimension _d_ **z** . To ensure scalability while retaining expressive capacity, a low-rank approximation of **G** 2 is adopted: 

**==> picture [120 x 12] intentionally omitted <==**

where **U** _,_ **V** _∈_ R _[d]_ **[z]** _[×][r]_ are orthonormal matrices, **s** _∈_ R _[r]_ contains nonnegative singular values, and _**δ** ∈_ R _[d]_ **[z]** is a learnable diagonal correction. The effective rank _r ≪ d_ **z** controls the trade-off between model capacity and efficiency. During training, **U** and **V** are obtained by QR orthogonalization of unconstrained matrices **U** raw and **V** raw, ensuring 

7 

that **U** _[⊤]_ **U** = **V** _[⊤]_ **V** = **I** _r_ at each forward pass, while **s** is parameterized through a softplus transformation to enforce positivity. The additional diagonal term diag( _**δ**_ ) serves as a residual correction, improving conditioning and allowing independent scaling across latent modes. This parameterization reduces the number of trainable parameters from _O_ ( _d_ **z**[2][)][to] _[O]_[(] _[d]_ **[z]** _[r]_[)][,][substantially][decreasing][both][memory][and][computational][costs][in][the][latent][update][(][9b][).] In practice, we find that moderate ranks (e.g., _r_ = 64 to 128) already capture the essential coupling structures of the latent flow dynamics while maintaining numerical stability. This low-rank SVD-inspired construction of **G** 2 thus enables LaCGKN to scale efficiently to high-dimensional turbulent flows without compromising much representational power. 

**Learning LaCGKN from data.** The LaCGKN is trained by minimizing a composite loss function: 

**==> picture [409 x 12] intentionally omitted <==**

where 

**==> picture [323 x 145] intentionally omitted <==**

The loss functions (14a)–(14d) represent the auto-encoder reconstruction loss for Eulerian flow, the forecast loss for physical variables **u** = _{_ **u** 1 _,_ **u** 2 _} ∈_ R _[d]_ **[u]** , the forecast loss for latent variables **z** , and the data assimilation loss based on the posterior mean _**µ**[n]_ 2[obtained][from][the][conditional][Gaussian][filter][and][decoder,][respectively.][The] subscript _[⋆]_ denotes the reference (ground-truth) solution, and _∥· ∥_ 2 denotes the Euclidean _ℓ_[2] -norm. The forecast steps _Ns_ , data assimilation steps _Nl_ , data assimilation warm-up steps _Nb_ , and the loss weights _λ_ AE, _λ_ **u** , _λ_ **z** , and _λ_ DA are tunable hyper-parameters. 

To learn the LaCGKN (9) from data, we follow the two-stage training strategy developed for discrete-time CGKN as in Chen et al. (2025b). In Stage 1, the autoencoder ( _E, D_ ) and the coefficients ( **F** 1 _,_ **G** 1 _,_ **F** 2 _,_ **G** 2) are jointly learned by minimizing the composite loss (13) with data assimilation loss excluded ( _λ_ DA = 0). Once finishing Stage 1, the noise strength matrix **Σ** 1 is estimated by the one-step prediction root mean squared error (RMSE) of the observed states **u** 1. The noise strength matrix **Σ** 2 is manually set in this work, although it can be estimated by the one-step prediction RMSE of latent states **z** or set as a trainable parameter as well. In Stage 2, the LaCGKN surrogate is refined for data assimilation by minimizing the complete composite loss (13) with _L_ DA included. The resulting LaCGKN thus learns a model both for tracer–flow prediction and Lagrangian data assimilation. 

**Algorithm 1** Learning LaCGKN from data 

|**Input:**<br>�<br>**u**_n⋆_<br>1 _,_**u**_n⋆_<br>2<br>�_N_<br>_n_=0|_▷_Training data: tracer positions and fow felds|
|---|---|
|**_θ_**(1)<br>_E ,_**_θ_**(1)<br>_D ,_**_θ_**(1)<br>_η_<br>_←_argmin_{λ_AE_L_AE+_λ_**u**_L_**u**+_λ_**z**_L_**z**_}_|_▷_Train LaCGKN without data assimilation loss|
|diag(**Σ**1)_←_RMSE(**u**_⋆_<br>1_,_**u**1), diag(**Σ**2)_←_manually set|_▷_Uncertainty quantifcation for state forecast|
|**_θ_**(2)<br>_E ,_**_θ_**(2)<br>_D ,_**_θ_**(2)<br>_η_<br>_←_argmin_{λ_AE_L_AE+_λ_**u**_L_**u**+_λ_**z**_L_**z**+_λ_DA_L_DA_}_<br>**_θ_**_∗_<br>_U_ =argminMSE<br>�<br>_∥_**u**_⋆_<br>2 _−_**_µ_**2_∥,U_(**u**1;**_θ_**_U_)<br>�|_▷_Train LaCGKN with data assimilation loss<br>_▷_Uncertainty quantifcation for data assimilation|
|**Output**: **_θ_**(2)<br>_E ,_**_θ_**(2)<br>_D ,_**_θ_**(2)<br>_η ,_**_θ_**_∗_<br>_U,_**Σ**1_,_**Σ**2|_▷_Trained parameters and noise strengths|



8 

## **3 Numerical experiments** 

## **3.1 Application to the two-layer quasi-geostrophic flow with surface tracer observations** 

The quasi-geostrophic (QG) equations provide a nonlinear yet analytically clean model that captures the essential physics of mid-latitude atmosphere and ocean dynamics, and are widely used to study large-scale geophysical flows (Vallis, 2017). In this work, the LaCGKN is applied to a tracer–flow system in which the flow is governed by a two-layer QG model with baroclinic instability (Qi and Majda, 2016): 

**==> picture [439 x 55] intentionally omitted <==**

where _ψℓ_ ( **x** _,t_ ) _∈_ R _,_ ( _ℓ_ = 1 _,_ 2) denotes the _ℓ_ th-layer stream function defined on ( **x** _,t_ ) _∈_ Ω _×_ (0 _, T_ ] _⊂_ R[2] _×_ R and is the primary quantity of interest. The potential vorticity disturbances in the upper and lower layers are defined as 

**==> picture [350 x 23] intentionally omitted <==**

respectively. Here, _h_ is the bottom topography, _J_ ( _A, B_ ) = _AxBy − AyBx_ is the Jacobian, ( _U_ 1 _,U_ 2) are the mean flows in the two layers, _kd_ is the deformation wavenumber associated with the Rossby deformation radius, and _β_ is the Rossby parameter. The term _κ_ ∇[2] _ψ_ 2 represents Ekman damping in the lower layer (bottom friction), and _ν_ ∆ _[s] qi_ denotes hyperviscosity in each layer. In this work, we set ( _U_ 1 _,U_ 2) = ( _U, −U_ ) to impose symmetric vertical shear which introduces baroclinic instability, and consider equal layer depths _H_ 1 = _H_ 2 = _H/_ 2. The incompressible velocity field of the _ℓ_ th layer is related to the stream function by 

**==> picture [276 x 27] intentionally omitted <==**

Tracers are treated as passive and are advected by the surface velocity field according to (2a). 

The two-layer QG flow with surface tracer observations provides a challenging testbed for the LaCGKN due to its intrinsic multiscale turbulent dynamics, strong nonlinearity, and the existence of an unobserved bottom topography. As in (8), LaCGKN takes tracer positions � **x** _[n]_ 1 _[,...,]_ **[x]** _I[n]_ � as the observed state **u** _[n]_ 1[, but the stream function] fields ( _ψ_ 1 _[n][,][ψ]_ 2 _[n]_[)][ (rather than the velocity fields) as the unobserved state] **[ u]** _[n]_ 2[.][The unobserved state] **[ u]** _[n]_ 2[is encoded by] a convolutional autoencoder into a latent state **z** _[n] ∈_ R _[d]_ **[z]** with spatial structure ( _zh, zw, nc_ ). We find that choosing the number of channels _nc_ to match the number of layers often yields a better latent representation. Since the domain is doubly periodic, tracer positions are encoded via an angular embedding ( _x, y_ ) _�→_ (cos _x,_ sin _x,_ cos _y,_ sin _y_ ), and the convolutional autoencoder uses circular padding in order to respect the periodicity (see Appendix A for details). As described in Section 2.3, the LaCGKN observation operators ( **F** 1 _,_ **G** 1) employ Fourier positional encoding and share parameters across all tracers. When using a relatively high latent dimension (e.g., _zh_ = _zw_ = 32), the latent evolution matrix **G** 2 is parameterized by the SVD-inspired low-rank approximation to reduce trainable parameters. 

## **3.2 Experimental design** 

The proposed LaCGKN is evaluated on the two-layer QG flow with surface tracer observations. Its performance in state forecasting and data assimilation is compared against several baseline methods listed below. 

**State forecast.** The following methods are evaluated for one-step prediction of both the flow field and tracer positions. 

> (i) _LaCGKN._ The proposed deep learning method based on the LaCGKN surrogate (9), which jointly predicts tracer and flow dynamics. The latent dimension is _d_ **z** = 16 _×_ 16 _×_ 2 by default. 

9 

- (ii) _LaCGKN32._ A higher-capacity variant of LaCGKN with an increased latent dimension _d_ **z** = 32 _×_ 32 _×_ 2, in order to enhance model expressivity. 

- (iii) _DNN(tracer) + CNN(flow)._ A modular deep-learning baseline that predicts tracer positions with deep neural network (DNN) and predicts flow with CNN. For tracer prediction, each tracer position is first embedded through the Fourier positional encoding (12). Feature-wise Linear Modulation (FiLM; Perez et al., 2017) is then applied to enhance the retrieval of local flow information at tracer positions: 

**==> picture [298 x 13] intentionally omitted <==**

where **u** ˜ _[n]_ 1[=] _[ P]_[(] **[u]** _[n]_ 1[)][ is the positionally encoded tracer state and] _[ ⊙]_[is the elementwise product.][The modulation] parameters _β_ and _γ_ are given by two shallow fully connected networks. For flow prediction, a CNN with circular padding is used to predict **u** _[n]_ 2[+][1] from **u** _[n]_ 2[.][This modular architecture serves as a strong deep-learning] baseline for pure state forecast. 

- (iv) _Persistence._ A trivial baseline that assumes no temporal evolution, i.e., **u** _[n]_[+][1] = **u** _[n]_ . Persistence provides a lower bound on forecast skill and reveals the improvement over simply copying the current state. 

**Data assimilation.** The following methods are evaluated for data assimilation, which aims to infer the Eulerian flow state from surface tracer observations. 

- (i) _LaCGKN._ The proposed method, which performs analytic filtering in latent space using the conditional Gaussian filter (6), followed by decoding to physical space. No access to the physical model is used during assimilation. 

- (ii) _Ensemble Kalman filter (EnKF)._ A classical sequential data assimilation method for nonlinear systems (Evensen, 1994). We employ a deterministic EnKF variant, the ensemble adjustment Kalman filter (EAKF; Anderson, 2001), using an augmented state formulation for Lagrangian data assimilation as in Wang et al. (2025). A constant multiplicative covariance inflation (Anderson and Anderson, 1999) and Gaspari–Cohn localization (Gaspari and Cohn, 1999) are applied. EAKF runs ensemble forecast using the perfect QG model. It serves as a strong physics-based baseline and highlights the accuracy and efficiency of LaCGKN. 

- (iii) _Optimal Interpolation (OI)._ A simplified Kalman-filter-based method with prescribed, time-invariant background and observation error covariances. Following Molcard et al. (2003, 2005), OI is applied by constructing Lagrangian velocities via finite-differencing tracer positions over ∆ _t_ obs (thus converting position observations into velocity observations), and projecting surface-layer corrections to the lower layer via linear regression. Gaussian localization is applied. OI runs the flow forecast with the perfect QG model. It provides a simplified baseline and contrasts the importance of capturing strong nonlinearity in tracer–flow dynamics. 

- (iv) _Climatology._ A naive baseline that ignores observations and uses the long-term mean flow as a fixed background state. It provides a reference error level without assimilation. 

**Data generation.** The tracer-flow system is integrated numerically to generate paired Lagrangian tracer observations and Eulerian QG flow fields. The QG flow evolves in a turbulent regime with nondimensional parameters _kd_ = 10, _β_ = 22, _U_ = 1, _κ_ = 9, _ν_ = 10 _[−]_[12] , _s_ = 4, and _h_ ( _x, y_ ) = 40cos _x_ + 80cos(2 _y_ ). The QG equations are solved on a 128 _×_ 128 pseudo-spectral grid over the doubly periodic domain Ω = [0 _,_ 2 _π_ )[2] . The flow is initialized by sampling the potential vorticity disturbances as _q_[0] 1[=] _[ q]_[0] 2 _[∼N]_[(][0] _[,]_[10][2][)][ and integrated for] _[ N][t]_[=][ 2] _[×]_[10][6][ steps after] a warm-up of 1000 steps, with time step ∆ _t_ = 2 _×_ 10 _[−]_[3] . A total of 1024 tracers are initialized as **x**[0] _i[∼N]_[(] _[π][,]_[0] _[.]_[1][2][)] and advected by the surface flow with stochastic noises of strength _σx_ = _σy_ = 0 _._ 1. Synthetic tracer observations are constructed by adding independent Gaussian measurement noise _N_ (0 _,_ 0 _._ 01[2] ). The same level of noise is added to the stream function fields during training to mimic realistic deployments and assess robustness. The data are then sub-sampled to a 64 _×_ 64 grid with observation interval ∆ _t_ obs = 4 _×_ 10 _[−]_[2] . The resulting dataset consists of tracer _I,Ntobs M,Ntobs_ position data _{_ **x** _[n] i[}] i_ =1 _,n_ =0[and Eulerian QG flow fields] _[ {][ψ]_ 1 _[n] ,m[,][ψ]_ 2 _[n] ,m[}] m_ =1 _,n_ =0[,][where] _[ M]_[ =][ 64] _[ ×]_[ 64 and] _[ N][t] obs_[=][ 10][5][.] 

10 

The dataset is split into training/validation/testing segments with 80 _,_ 000 _/_ 10 _,_ 000 _/_ 10 _,_ 000 assimilation steps, respectively. Unless otherwise stated, only _I_ = 64 tracers are used in forecast and assimilation. During training, a random subset of 64 tracers is drawn from the total 1024 tracers at each batch to encourage tracer homogenization of ( **F** 1 _,_ **G** 1) and improve generalization. 

**LaCGKN training setup.** The LaCGKN consists of a circular CNN autoencoder ( _E, D_ ) for the Eulerian flow and a conditional Gaussian network (9) with coefficients ( **F** 1 _,_ **G** 1 _,_ **F** 2 _,_ **G** 2). By default, the encoder _E_ : R[64] _[×]_[64] _[×]_[2] _�→_ R[16] _[×]_[16] _[×]_[2] maps the flow field **u** _[n]_ 2[to a latent state] **[ z]** _[n]_[ (] _[d]_ **[z]**[ =][ 512).][The decoder] _[ D]_[ :][ R][16] _[×]_[16] _[×]_[2] _[ �→]_[R][64] _[×]_[64] _[×]_[2][ mirrors the] encoder, mapping **z** _[n]_ back to **u** _[n]_ 2[.][Given angular embedded tracer positions] **[ u]** _[n]_ 1 _[∈]_[R][4] _[I]_[, each angular representation] (cos _xi,_ sin _xi,_ cos _yi,_ sin _yi_ ) is first converted back to ( _xi, yi_ ) and then embedded via Fourier positional encoding with _K_ = 6 frequencies, yielding **x** ˜ _[n] i_[=] _[ P]_[(] **[x]** _[n] i_[)] _[ ∈]_[R][26][ per tracer.][The sub-networks] **[ f]** _[θ]_[:][ R][26] _[ →]_[R][4][ and] **[ G]** _[θ]_[:][ R][26] _[ →]_[R][4] _[×]_[512] that are DNNs take **x** ˜ _[n] i_[as input, and construct] **[ F]**[1] _[ ∈]_[R][4] _[I]_[and] **[ G]**[1] _[ ∈]_[R][4] _[I][×]_[512][.][The latent transition parameters] **[ F]**[2] _[ ∈]_ R[512] and **G** 2 _∈_ R[512] _[×]_[512] are learned constants. To explore higher-capacity models, a larger latent dimension _d_ **z** = 32 _×_ 32 _×_ 2 is also considered, referred to as LaCGKN32; in this case, an SVD-inspired low-rank parameterization of **G** 2 (Section 2.3) is applied with effective rank _r_ = 64. The training settings of LaCGKN are: state forecast steps _Ns_ = 1 (i.e., one-step prediction), data assimilation steps _Nl_ = 100, data assimilation warm-up steps _Nb_ = 20, and the loss weights _λ_ AE = _λ_ **u** = _λ_ **z** = _λ_ DA = 1. 

**Test and evaluation.** Over the 10 _,_ 000-step testing dataset, the one-step prediction error is evaluated for state forecast, and posterior error is evaluated for data assimilation with the first 50 steps excluded as spin-up. LaCGKN performs analytic latent-space filtering initialized as **z**[0] _∼N_ ( **0** _,_ 0 _._ 1[2] **I** ). EnKF and OI perform sequential filtering using the perfect QG model, with flow initialized as _ψℓ,_[0] _m[∼N]_[(][0] _[,]_[0] _[.]_[1][2][)][ at each grid point and in each layer.][For] EnKF, each simulated tracer is initialized around the initial tracer observation **x**[0] _∼N_ ( **x**[0] obs _[,]_[0] _[.]_[01][2] **[I]**[)][.][EnKF][uses] ensemble size _Ne_ = 40, inflation factor 1.025, and localization radius of 16 grid points. OI uses a prescribed background error standard deviation _σb_ = 1 _._ 0 of velocity and Gaussian localization radius of 1 grid point. The regression coefficients used for projecting surface corrections to the lower layer is calculated based on per-grid velocities between the two layers. All tunable parameters are empirically optimized. 

**Evaluation metric.** The RMSE is used as the point-estimation metric. For a quantity of interest **a** _∈_ R _[d]_ **[a]** (e.g., stacked tracer positions or a flattened flow field) and its reference value **a** _[⋆]_ , the RMSE is 

**==> picture [290 x 28] intentionally omitted <==**

For data assimilation, EnKF and OI use the posterior mean as the point estimate, while LaCGKN uses the decoded latent posterior mean _**µ**_ 2 = _D_ ( _**µ**_ **z** ). For all deep-learning-based methods, the number of trainable parameters is chosen to be comparable to ensure a fair comparison. The trainable parameter counts are 1 _,_ 021 _,_ 512 for the default LaCGKN, 927 _,_ 932 for LaCGKN32, and 1 _,_ 089 _,_ 894 for DNN+CNN. 

## **3.3 Numerical results** 

The performance of LaCGKN is evaluated in terms of both one-step prediction and data assimilation. A key distinction is that LaCGKN performs forecasting and data assimilation within a unified framework, whereas the benchmark methods considered below address only one of these two tasks. The key findings are summarized below: 

- **Accurate and stable flow forecasting.** The default LaCGKN substantially outperforms persistence, demonstrating its ability to learn nontrivial dynamical structure. Increasing the latent dimension (LaCGKN32) yields the lowest RMSE among all comparing methods and maintains stable long-term rollouts, whereas the CNN baseline becomes unstable after about 10 steps (Table 1 and Fig. 2). 

11 

- **Accurate data assimilation with reliable uncertainty quantification.** Without access to the physical model, LaCGKN achieves the lowest posterior RMSEs with coherent flow structures compared to the physics-based EnKF, OI and climatology that use the perfect QG model (Table 2 and Fig. 3). LaCGKN also provides well-calibrated posterior uncertainty quantification, with the posterior spread closely matching the posterior RMSE over time (Fig. 4). 

- **High computational efficiency and scalability.** LaCGKN is approximately two orders of magnitude faster than the parallelized EnKF while achieving lower posterior RMSE, and its efficiency advantage becomes more pronounced as the number of tracers increases. Furthermore, once trained, LaCGKN generalizes across different tracer numbers without retraining (Fig. 5). 

The detailed results are presented as follows. 

**State forecast.** The one-step prediction RMSEs across different methods are summarized in Table 1. Both the default LaCGKN and the LaCGKN32 have substantially lower RMSEs than persistence across all variables, indicating that the learned surrogates capture meaningful dynamical structure rather than merely memorizing the data. The improvement is especially pronounced for the upper-layer flow, where persistence errors are large due to strong turbulence variability. Although the default LaCGKN has larger RMSEs than the DNN+CNN baseline, increasing the latent dimension of LaCGKN significantly improves the flow prediction accuracy. In particular, LaCGKN32 reduces the two-layer RMSE from 0.104 to 0.037, achieving the lowest RMSEs among all methods. This substantial gain highlights the importance of latent embedding capacity in representing complex turbulent flows. When sufficient latent dimension is provided, the conditional Gaussian surrogate can well approximate the underlying nonlinear dynamical system. 

For tracer position prediction, LaCGKN does not outperform DNN+CNN. This is expected since the DNN baseline directly exploits the flow fields in physical space to advect tracers, whereas LaCGKN relies on latent embeddings that are required to capture both the tracer-flow interactions and the flow dynamics. Nevertheless, the primary focus of this work is on accurate flow prediction, where LaCGKN32 clearly excels. This advantage is further illustrated in the autoregressive multi-step prediction of the flow field (Fig. 2), where LaCGKN32 maintains stable and physically coherent flow structures over long rollouts, while the CNN model becomes unstable after about 10 steps. These results highlight that LaCGKN is not merely a predictor but a dynamical surrogate enforcing structured latent evolution, which encourages long-horizon stability. Moreover, LaCGKN can perform efficient data assimilation beyond standalone forecasting, providing a key advantage over purely predictive deep learning models. 

Table 1: RMSEs of state forecast (one-step prediction) across different methods, including LaCGKN with default latent dimension, LaCGKN32 with an increased latent dimension _d_ **z** = 32 _×_ 32 _×_ 2, DNN(tracer)+CNN(flow), and persistence. Errors are computed for tracer positions, the upper-layer stream function _ψ_ 1, the lower-layer stream function _ψ_ 2, and the two-layer stream functions in total. 

|**Method**|**Tracer**|**Upper Layer**|**Lower Layer**|**Two Layers**|
|---|---|---|---|---|
|LaCGKN|0.099|0.125|0.079|0.104|
|LaCGKN32|0.094|0.042|0.032|0.037|
|DNN+CNN|0.064|0.071|0.069|0.070|
|Persistence|0.136|0.294|0.177|0.243|



**Data assimilation.** Table 2 summarizes the posterior RMSEs of flow estimates across different methods. Without using the physical QG model, the default LaCGKN achieves lower RMSEs than EnKF, OI, and climatology in both layers. The advantage of LaCGKN over OI is particularly pronounced. Because OI only introduces local corrections near tracer locations and propagates corrections through linear projections between layers, it performs poorly in this strongly nonlinear turbulent regime. EnKF as a stronger physics-based benchmark more effectively captures nonlinearity by propagating ensemble forecasts with full physical model and estimating flow-dependent 

12 

error covariances. Nevertheless, LaCGKN achieves lower posterior RMSEs than EnKF without requiring fullmodel ensemble propagation or empirical tuning of hyper-parameters such as inflation and localization. Snapshots of the flow fields in Fig. 3 further confirm that LaCGKN accurately recovers coherent flow structures in both layers. These results indicate that the learned LaCGKN surrogate successfully captures the nonlinear tracer-flow coupling and multi-layer interactions required for accurate data assimilation. In addition, the close agreement between posterior spread and the posterior RMSE over time demonstrates that LaCGKN provides reliable uncertainty quantification alongside accurate mean estimates (Fig. 4). 

**Sensitivity and computational cost.** Figure 5 compares the posterior RMSEs and computational costs (wallclock time on a CPU) of LaCGKN and EnKF under varying numbers of tracers. The results admit several key observations. First, LaCGKN consistently achieves lower posterior RMSEs than EnKF across tracer numbers. The performance gap widens as the number of tracers increases, suggesting that the learned surrogate effectively leverages additional observational information. Second, LaCGKN is approximately _O_ (100) times faster than the parallelized EnKF. This efficiency gain arises from filtering in a low-dimensional latent space using closed-form updates, rather than propagating and updating ensembles in the full physical space. The computational complexity scales primarily with latent dimension rather than ensemble size. Third, LaCGKN is invariant to tracer numbers at inference time. Once trained for a given configuration, the same model can be directly applied to different tracer numbers without retraining. In contrast, EnKF requires retuning of hyper-parameters to maintain optimal performance as the number of tracers changes. This tracer-number invariance greatly reduces the operational cost in realistic deployments, where the number of drifting instruments may vary over time. Overall, these results demonstrate that LaCGKN not only performs accurate data assimilation with reliable uncertainty quantification, but also remains highly efficient in both training and inference. 

Table 2: RMSEs of data assimilation posterior estimates across different methods, including LaCGKN with default latent dimension, EnKF, OI, and climatology. Errors are computed for the upper-layer stream function _ψ_ 1, the lower-layer stream function _ψ_ 2, and the two-layer stream functions in total. 

|**Method**|**Upper Layer**|**Lower Layer**|**Two Layers**|
|---|---|---|---|
|LaCGKN|0.579|0.310|0.464|
|EnKF|0.599|0.321|0.481|
|OI|0.890|0.467|0.710|
|Climatology|0.870|0.414|0.681|



## **4 Conclusion and discussions** 

A Lagrangian Conditional Gaussian Koopman network (LaCGKN) is developed to address the challenging tasks of Lagrangian data assimilation and prediction, focusing on inferring high-dimensional Eulerian flow fields from Lagrangian tracer observations. The main difficulty stems from the intrinsic nonlinearity induced by evaluating the flow at moving tracer positions, together with the strongly nonlinear and turbulent nature of flow dynamics. LaCGKN addresses this challenge by learning a surrogate model with a conditional Gaussian structure: the Eulerian flow is encoded into a low-dimensional latent state with approximately linear dynamics, while represented by a nonlinear yet structured model driven by the latent flow. This structure enables analytic latent-space filtering with closed-form posterior updates. To improve robustness and scalability in the Lagrangian setting, we introduce (i) tracer homogenization to enforce permutation equivariance and enable generalization across tracer counts, (ii) Fourier-based positional encoding to capture rich nonlinear spatial dependence of the flow at tracer locations, and (iii) an SVD-inspired low-rank parameterization of the latent transition matrix **G** 2 to reduce the number of trainable parameters while retaining expressivity and efficiency. The resulting LaCGKN is trained via a composite loss, yielding a unified deep learning model for both prediction and data assimilation. 

The LaCGKN is evaluated on a turbulent two-layer quasi-geostrophic (QG) system with surface tracer position observations. For state forecast, the default LaCGKN already provides a useful forecast model by substantially 

13 

outperforming persistence, and increasing the latent dimension (LaCGKN32) yields the best flow prediction accuracy among the comparing methods. LaCGKN also produces stable and accurate multi-step rollouts, whereas the CNN baseline becomes unstable after about 10 steps. For data assimilation, LaCGKN achieves posterior RMSEs that are comparable to a physics-based EnKF that uses the perfect QG model and significantly lower than those of OI and climatology, while also providing reliable uncertainty quantification. In addition, LaCGKN is very computationally efficient, approximately _O_ (100) times faster than the parallelized EnKF, while maintaining strong accuracy, with the advantages becoming more pronounced as the number of tracers increases. Finally, because LaCGKN is designed to be invariant to tracer number, it can be trained once and applied to different tracer numbers without retraining, reducing both development and deployment costs and providing an efficient, purely data-driven alternative for Lagrangian data assimilation and prediction. 

The conditional Gaussian (CG) filter generalizes the Kalman-Bucy filter to systems with nonlinear observation processes, originating from the continuous-time formulation of filtering (Kalman and Bucy, 1961; Jazwinski, 1970; Chen and Majda, 2018). While the discrete-time formulation of filtering, typified by the Kalman filter, is fundamentally different from its continuous-time counterpart (Wang et al., 2025). The distinction is not merely due to time discretization, as discrete-time versions of CG filter also exist, but rather arises from the observation formulation itself. In standard discrete-time filtering, observation noise is independent of system dynamics, whereas in continuous-time filtering (and its discretized surrogates), observation noise enters directly into the dynamics. In the current CGKN formulation, measurement errors in tracer positions are not explicitly modeled but are implicitly approximated by dynamical noise. Although our numerical results demonstrate robustness to small measurement noise, it is of interest to explicitly incorporate measurement noise into the CGKN framework, potentially bridging continuous- and discrete-time filtering formulations, and further improving assimilation accuracy under noisy observations. 

14 

**==> picture [396 x 534] intentionally omitted <==**

Figure 2: Snapshots of the stream function flow field for state forecast comparison. The forecasts are initialized at time _t_ = 360, and are autoregressly rolled out for multiple steps. Results are compared among the ground truth, LaCGKN (default latent dimension _d_ **z** = 16 _×_ 16 _×_ 2), LaCGKN32 (latent dimension _d_ **z** = 32 _×_ 32 _×_ 2) and CNN. 

15 

**==> picture [396 x 533] intentionally omitted <==**

Figure 3: Snapshots of the stream function flow field for data assimilation comparison. The ground truth is compared to the posterior estimates from LaCGKN, EnKF, and OI. 

16 

**==> picture [419 x 345] intentionally omitted <==**

Figure 4: (a) Time series of the data assimilation posterior estimates at position ( _x, y_ ) = (2 _._ 45 _,_ 2 _._ 45). Truth is denoted by black lines. The comparing methods are LaCGKN (red lines), EnKF (blue lines), and OI (yellow lines). Uncertainties are illustrated as _±_ 2 posterior standard deviation using the corresponding shaded areas. (b) Time series of the data assimilation posterior RMSEs (solid lines) and posterior spread (standard deviation; dashed lines) for LaCGKN (red lines), EnKF (blue lines), and OI (yellow lines). 

17 

**==> picture [372 x 160] intentionally omitted <==**

Figure 5: Posterior RMSEs and computational costs (wall-clock time) of LaCGKN and EnKF varying with number of tracers. The wall-clock time is collected by running the program on the same CPU. The model forecasting of EnKF is parallelized over ensemble members. 

18 

**Acknowledgments.** The research of N.C. is funded by the Office of Naval Research N00014-24-1-2244 and the Army Research Office W911NF-23-1-0118. Z.W. is partially supported by these grants. The research of C.C. and J.W. was funded by the University of Wisconsin-Madison, Office of the Vice Chancellor for Research and Graduate Education, with funding from the Wisconsin Alumni Research Foundation. 

**Data availability statement.** The code can be found at: `https://github.com/zhongruiw/LaCGKN` . 

## **Appendix A. Technical details for handling periodic conditions.** 

## **A.1. Circularity of tracer positions.** 

Tracers evolve on a doubly-periodic domain, and their raw Cartesian coordinates exhibit discontinuities upon crossing boundaries. This makes standard Euclidean representations unsuitable, as a small displacement across the 2 _π_ -boundary would appear as a large jump. To avoid such artifacts, all tracer positions are encoded using an angular embedding 

( _x, y_ ) _�→_ (cos _x,_ sin _x,_ cos _y,_ sin _y_ ) _,_ 

which preserves periodicity and continuity on the torus. This unit-vector representation is then mapped back to physical coordinates and further augmented with Fourier features, before being fed into the networks **f** _θ_ and **G** _θ_ . This representation ensures that neural networks are exposed to geometrically consistent inputs and prevents spurious discontinuities in the training data. 

## **A.2. Circular CNN autoencoder for flow.** 

The Eulerian flow field on the 64 _×_ 64 doubly-periodic grid is encoded and decoded by a convolutional autoencoder whose layers all use wrap-around (circular) padding in both spatial directions. Thus, each convolution effectively acts on a torus, so that no artificial edges are created. The encoder _E_ compresses the multi-channel flow into the latent state **z** _[n]_ via stacked circular 3 _×_ 3 convolutions and pooling, and the decoder _D_ inverts this mapping using circular transposed convolutions. This design yields a compact, translation-equivariant latent representation that enforces periodicity of the reconstructed flow by construction. 

## **References** 

- Anderson, J. L., 2001: An Ensemble Adjustment Kalman Filter for Data Assimilation. _Monthly Weather Review_ , **129 (12)** , 2884–2903, https://doi.org/10.1175/1520-0493(2001)129<2884:AEAKFF>2.0.CO;2. 

- Anderson, J. L., and S. L. Anderson, 1999: A Monte Carlo Implementation of the Nonlinear Filtering Problem to Produce Ensemble Assimilations and Forecasts. _Monthly Weather Review_ , https://doi.org/https://doi.org/10. 1175/1520-0493(1999)127<2741:AMCIOT>2.0.CO;2. 

- Apte, A., C. K. R. T. Jones, and A. M. Stuart, 2008: A Bayesian approach to Lagrangian data assimilation. _Tellus A: Dynamic Meteorology and Oceanography_ , **60 (2)** . 

- Asefi, N., L. Lupin-Jimenez, T. Wu, R. He, and A. Chattopadhyay, 2025: Generative Lagrangian data assimilation for ocean dynamics under extreme sparsity. arXiv, URL http://arxiv.org/abs/2507.06479, arXiv:2507.06479 [physics], https://doi.org/10.48550/arXiv.2507.06479. 

- Bach, E., R. Baptista, E. Calvello, B. Chen, and A. Stuart, 2025: Learning Enhanced Ensemble Filters. arXiv, URL http://arxiv.org/abs/2504.17836, arXiv:2504.17836 [stat], https://doi.org/10.48550/arXiv.2504.17836. 

- Baptista, R., A. M. Stuart, and S. Tran, 2025: A Mathematical Perspective On Contrastive Learning. arXiv, URL http://arxiv.org/abs/2505.24134, arXiv:2505.24134 [stat], https://doi.org/10.48550/arXiv.2505.24134. 

19 

- Bocquet, M., A. Farchi, T. S. Finn, C. Durand, S. Cheng, Y. Chen, I. Pasmans, and A. Carrassi, 2024: Accurate deep learning-based filtering for chaotic dynamics by identifying instabilities without an ensemble. _Chaos: An Interdisciplinary Journal of Nonlinear Science_ , **34 (9)** , 091 104, https://doi.org/10.1063/5.0230837. 

- Boudier, P., A. Fillion, S. Gratton, S. Gürol, and S. Zhang, 2023: Data Assimilation Networks. _Journal of Advances in Modeling Earth Systems_ , **15 (4)** , e2022MS003 353, https://doi.org/10.1029/2022MS003353. 

- Businger, S., S. R. Chiswell, W. C. Ulmer, and R. Johnson, 1996: Balloons as a Lagrangian measurement platform for atmospheric research. _Journal of Geophysical Research: Atmospheres_ , **101 (D2)** , 4363–4376, https://doi.org/ 10.1029/95JD00559. 

- Centurioni, L., A. Horányi, C. Cardinali, E. Charpentier, and R. Lumpkin, 2017: A Global Ocean Observing System for Measuring Sea Level Atmospheric Pressure: Effects and Impacts on Numerical Weather Prediction. _Bulletin of the American Meteorological Society_ , https://doi.org/10.1175/BAMS-D-15-00080.1. 

- Chen, C., N. Chen, and J.-L. Wu, 2024: CGNSDE: Conditional Gaussian neural stochastic differential equation for modeling complex systems and data assimilation. _Computer Physics Communications_ , **304** , 109 302, https://doi.org/10.1016/j.cpc.2024.109302. 

- Chen, C., N. Chen, Y. Zhang, and J.-L. Wu, 2025a: CGKN: A deep learning framework for modeling complex dynamical systems and efficient data assimilation. _Journal of Computational Physics_ , **532** , 113 950, https://doi.org/ 10.1016/j.jcp.2025.113950. 

- Chen, C., Z. Wang, N. Chen, and J.-L. Wu, 2025b: Modeling partially observed nonlinear dynamical systems and efficient data assimilation via discrete-time conditional Gaussian Koopman network. _Computer Methods in Applied Mechanics and Engineering_ , **445** , 118 189, https://doi.org/10.1016/j.cma.2025.118189. 

- Chen, C., and J.-L. Wu, 2025: Neural dynamical operator: Continuous spatial-temporal model with gradient-based and derivative-free optimization methods. _Journal of Computational Physics_ , **520** , 113 480, https://doi.org/10. 1016/j.jcp.2024.113480. 

- Chen, N., S. Fu, and G. E. Manucharyan, 2022: An efficient and statistically accurate Lagrangian data assimilation algorithm with applications to discrete element sea ice models. _Journal of Computational Physics_ , **455** , 111 000, https://doi.org/10.1016/j.jcp.2022.111000. 

- Chen, N., and A. J. Majda, 2018: Conditional Gaussian Systems for Multiscale Nonlinear Stochastic Systems: Prediction, State Estimation and Uncertainty Quantification. _Entropy_ , **20 (7)** , 509, https://doi.org/ 10.3390/e20070509. 

- Chen, R. T. Q., Y. Rubanova, J. Bettencourt, and D. Duvenaud, 2019: Neural Ordinary Differential Equations. arXiv, URL http://arxiv.org/abs/1806.07366, arXiv:1806.07366 [cs, stat], https://doi.org/10.48550/arXiv.1806. 07366. 

- Cheng, S., and Coauthors, 2023: Machine learning with data assimilation and uncertainty quantification for dynamical systems: a review. arXiv, URL http://arxiv.org/abs/2303.10462, arXiv:2303.10462 [cs]. 

- Dong, X., C. Chen, and J.-L. Wu, 2025: Data-driven stochastic closure modeling via conditional diffusion model and neural operator. _Journal of Computational Physics_ , **534** , 114 005, https://doi.org/10.1016/j.jcp.2025.114005. 

- Du, P., M. H. Parikh, X. Fan, X.-Y. Liu, and J.-X. Wang, 2024: Conditional neural field latent diffusion model for generating spatiotemporal turbulence. _Nature Communications_ , **15 (1)** , https://doi.org/10.1038/ s41467-024-54712-1. 

- Evensen, G., 1994: Sequential data assimilation with a nonlinear quasi-geostrophic model using Monte Carlo methods to forecast error statistics. _Journal of Geophysical Research_ , **99 (C5)** , 10 143, https://doi.org/10.1029/ 94JC00572. 

20 

- Fablet, R., B. Chapron, L. Drumetz, E. Mémin, O. Pannekoucke, and F. Rousseau, 2021: Learning Variational Data Assimilation Models and Solvers. _Journal of Advances in Modeling Earth Systems_ , **13 (10)** , e2021MS002 572, https://doi.org/10.1029/2021MS002572. 

- Farchi, A., M. Chrust, M. Bocquet, P. Laloyaux, and M. Bonavita, 2023: Online Model Error Correction With Neural Networks in the Incremental 4D-Var Framework. _Journal of Advances in Modeling Earth Systems_ , **15 (9)** , e2022MS003 474, https://doi.org/10.1029/2022MS003474. 

- Gaspari, G., and S. Cohn, 1999: Construction of correlation functions in two and three dimensions. _Quarterly Journal of the Royal Meteorological Society_ , **125 (554)** , 723–757, https://doi.org/10.1256/smsqj.55416. 

- Gauthier, D. J., E. Bollt, A. Griffith, and W. A. S. Barbosa, 2021: Next generation reservoir computing. _Nature Communications_ , **12 (1)** , 5564, https://doi.org/10.1038/s41467-021-25801-2. 

- Gould, J., and Coauthors, 2004: Argo profiling floats bring new era of in situ ocean observations. _Eos, Transactions American Geophysical Union_ , **85 (19)** , 185–191, https://doi.org/10.1029/2004EO190002. 

- Hochreiter, S., and J. Schmidhuber, 1997: Long Short-Term Memory. _Neural Computation_ , **9 (8)** , 1735–1780, https://doi.org/10.1162/neco.1997.9.8.1735. 

- Ide, K., L. Kuznetsov, and C. K. R. T. Jones, 2002: Lagrangian data assimilation for point vortex systems*. _Journal of Turbulence_ , **3 (1)** , 053, https://doi.org/10.1088/1468-5248/3/1/053. 

- Jazwinski, A., 1970: 5 Introduction to Filtering Theory. _Stochastic Processes and Filtering Theory_ , Vol. 64, Elsevier, 142–161, https://doi.org/10.1016/S0076-5392(09)60374-X, URL https://linkinghub.elsevier.com/retrieve/ pii/S007653920960374X. 

- Kalman, R., and R. Bucy, 1961: New results in linear filtering and prediction theory. _Journal of Fluids Engineering, Transactions of the ASME_ , **83 (1)** , 95–108, https://doi.org/10.1115/1.3658902. 

- Kuznetsov, L., K. Ide, and C. K. R. T. Jones, 2003: A Method for Assimilation of Lagrangian Data. _Monthly Weather Review_ , https://doi.org/https://doi.org/10.1175/1520-0493(2003)131<2247:AMFAOL>2.0.CO;2. 

- Legler, D., and Coauthors, 2015: The current status of the real-time in situ Global Ocean Observing System for operational oceanography. _Journal of Operational Oceanography_ , **8 (sup2)** , s189–s200, https://doi.org/10.1080/ 1755876X.2015.1049883. 

- Li, S., T. Zheng, A. Farchi, M. Bocquet, and P. Gentine, 2025: Probabilistic Data Assimilation for Ensemble Distribution Projections With Generative Machine Learning: A Lorenz ’96 Proof-of-Concept. _Geophysical Research Letters_ , **52 (12)** , e2024GL112 523, https://doi.org/10.1029/2024GL112523. 

- Li, Z., N. Kovachki, K. Azizzadenesheli, B. Liu, K. Bhattacharya, A. Stuart, and A. Anandkumar, 2021: Fourier Neural Operator for Parametric Partial Differential Equations. arXiv, URL http://arxiv.org/abs/2010.08895, arXiv:2010.08895 [cs], https://doi.org/10.48550/arXiv.2010.08895. 

- Lorenc, A. C., 1986: Analysis methods for numerical weather prediction. _Quarterly Journal of the Royal Meteorological Society_ , **112 (474)** , 1177–1194, https://doi.org/10.1002/qj.49711247414. 

- Lorenc, A. C., 2003: Modelling of error covariances by 4D-Var data assimilation. _Quarterly Journal of the Royal Meteorological Society_ , **129 (595)** , 3167–3182, https://doi.org/10.1256/qj.02.131. 

- Lu, L., P. Jin, G. Pang, Z. Zhang, and G. E. Karniadakis, 2021: Learning nonlinear operators via DeepONet based on the universal approximation theorem of operators. _Nature Machine Intelligence_ , **3 (3)** , 218–229, https://doi.org/10.1038/s42256-021-00302-5. 

- Lumpkin, R., T. Özgökmen, and L. Centurioni, 2017: Advances in the Application of Surface Drifters. _Annual Review of Marine Science_ , **9 (1)** , 59–81, https://doi.org/10.1146/annurev-marine-010816-060641. 

21 

- Lusch, B., J. N. Kutz, and S. L. Brunton, 2018: Deep learning for universal linear embeddings of nonlinear dynamics. _Nature Communications_ , **9 (1)** , 4950, https://doi.org/10.1038/s41467-018-07210-0. 

- Mariano, A. J., A. Griffa, T. M. Özgökmen, and E. Zambianchi, 2002: Lagrangian Analysis and Predictability of Coastal and Ocean Dynamics 2000. _Journal of Atmospheric and Oceanic Technology_ . 

- Martin, S. A., G. E. Manucharyan, and P. Klein, 2025: Generative Data Assimilation for Surface Ocean State Estimation From Multi-Modal Satellite Observations. _Journal of Advances in Modeling Earth Systems_ , **17 (8)** , e2025MS005 063, https://doi.org/10.1029/2025MS005063. 

- McPhaden, M. J., K. J. Connell, G. R. Foltz, R. C. Perez, and K. Grissom, 2023: Tropical Ocean Observations for Weather and Climate: A Decadal Overview of the Global Tropical Moored Buoy Array | Oceanography. _Oceanography_ , https://doi.org/https://doi.org/10.5670/oceanog.2023.211. 

- Mildenhall, B., P. P. Srinivasan, M. Tancik, J. T. Barron, R. Ramamoorthi, and R. Ng, 2020: NeRF: Representing Scenes as Neural Radiance Fields for View Synthesis. arXiv, URL http://arxiv.org/abs/2003.08934, arXiv:2003.08934 [cs], https://doi.org/10.48550/arXiv.2003.08934. 

- Molcard, A., A. Griffa, and T. M. Özgökmen, 2005: Lagrangian Data Assimilation in Multilayer Primitive Equation Ocean Models. _Journal of Atmospheric and Oceanic Technology_ , https://doi.org/10.1175/JTECH-1686.1. 

- Molcard, A., L. I. Piterbarg, A. Griffa, T. M. Özgökmen, and A. J. Mariano, 2003: Assimilation of drifter observations for the reconstruction of the Eulerian circulation field. _Journal of Geophysical Research: Oceans_ , **108 (C3)** , https://doi.org/10.1029/2001JC001240. 

- Penny, S. G., T. A. Smith, T.-C. Chen, J. A. Platt, H.-Y. Lin, M. Goodliff, and H. D. I. Abarbanel, 2022: Integrating Recurrent Neural Networks With Data Assimilation for Scalable Data-Driven State Estimation. _Journal of Advances in Modeling Earth Systems_ , **14 (3)** , e2021MS002 843, https://doi.org/10.1029/2021MS002843. 

- Perez, E., F. Strub, H. d. Vries, V. Dumoulin, and A. Courville, 2017: FiLM: Visual Reasoning with a General Conditioning Layer. arXiv, URL http://arxiv.org/abs/1709.07871, arXiv:1709.07871 [cs], https://doi.org/ 10.48550/arXiv.1709.07871. 

- Qi, D., and A. J. Majda, 2016: Low-Dimensional Reduced-Order Models for Statistical Response and Uncertainty Quantification: Two-Layer Baroclinic Turbulence. _Journal of the Atmospheric Sciences_ , https://doi.org/10.1175/ JAS-D-16-0192.1. 

- Qu, Y., J. Nathaniel, S. Li, and P. Gentine, 2024: Deep Generative Data Assimilation in Multimodal Setting. arXiv, URL http://arxiv.org/abs/2404.06665, arXiv:2404.06665 [cs]. 

- Raissi, M., P. Perdikaris, and G. E. Karniadakis, 2019: Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations. _Journal of Computational Physics_ , **378** , 686–707, https://doi.org/10.1016/j.jcp.2018.10.045. 

- Schuster, M., and K. Paliwal, 1997: Bidirectional recurrent neural networks. _IEEE Transactions on Signal Processing_ , **45 (11)** , 2673–2681, https://doi.org/10.1109/78.650093. 

- Slivinski, L., E. Spiller, A. Apte, and B. Sandstede, 2015: A Hybrid Particle–Ensemble Kalman Filter for Lagrangian Data Assimilation. _Monthly Weather Review_ , https://doi.org/10.1175/MWR-D-14-00051.1. 

- Spantini, A., R. Baptista, and Y. Marzouk, 2022: Coupling techniques for nonlinear ensemble filtering. arXiv, URL http://arxiv.org/abs/1907.00389, arXiv:1907.00389 [stat], https://doi.org/10.48550/arXiv.1907.00389. 

- Stamatelopoulos, S., and T. P. Sapsis, 2025: Can diffusion models capture extreme event statistics? _Computer Methods in Applied Mechanics and Engineering_ , **435** , 117 589, https://doi.org/10.1016/j.cma.2024.117589. 

22 

- Sun, L., and S. G. Penny, 2019: Lagrangian Data Assimilation of Surface Drifters in a Double-Gyre Ocean Model Using the Local Ensemble Transform Kalman Filter. _Monthly Weather Review_ , https://doi.org/10.1175/ MWR-D-18-0406.1. 

- Tancik, M., and Coauthors, 2020: Fourier Features Let Networks Learn High Frequency Functions in Low Dimensional Domains. arXiv, URL http://arxiv.org/abs/2006.10739, arXiv:2006.10739 [cs], https://doi.org/ 10.48550/arXiv.2006.10739. 

- Vallis, G. K., 2017: Atmospheric and Oceanic Fluid Dynamics: Fundamentals and LargeScale Circulation. Cambridge University Press, URL https://www.cambridge.org/core/books/ atmospheric-and-oceanic-fluid-dynamics/41379BDDC4257CBE11143C466F6428A4, iSBN: 9781107065505 9781107588417, https://doi.org/10.1017/9781107588417. 

- van Leeuwen, P. J., H. R. Künsch, L. Nerger, R. Potthast, and S. Reich, 2019: Particle filters for high-dimensional geoscience applications: A review. _Quarterly Journal of the Royal Meteorological Society_ , **145 (723)** , 2335– 2365, https://doi.org/10.1002/qj.3551. 

- Wang, Z., N. Chen, and D. Qi, 2025: A Nonlinear Data Assimilation Algorithm with Closed-Form Approximations for Multilayer Flow Fields. _Monthly Weather Review_ , https://doi.org/10.1175/MWR-D-24-0277.1. 

- Yang, S., and Coauthors, 2025: Generative assimilation and prediction for weather and climate. arXiv, URL http: //arxiv.org/abs/2503.03038, arXiv:2503.03038 [cs], https://doi.org/10.48550/arXiv.2503.03038. 

23 

