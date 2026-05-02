---
title: "Information Shapes Koopman Representation"
arxiv: "2510.13025"
authors: ["Xiaoyuan Cheng", "Wenxuan Yuan", "Yiming Yang", "Yuanzhao Zhang", "Sibo Cheng", "Yi He", "Zhuo Sun"]
year: 2025
source: paper
venue: "ICLR 2026"
ingested: 2026-05-02
sha256: 39996d5a5d77d58e5fa3ef46dcb25cc05ee05f61acc0d5a967867157dc6be647
conversion: pymupdf4llm
github: https://github.com/Wenxuan52/InformationKoopman
---

Published as a conference paper at ICLR 2026 

## INFORMATION SHAPES KOOPMAN REPRESENTATION 

**Xiaoyuan Cheng**[1] _[∗]_ **Wenxuan Yuan**[2] _[∗]_ **Yiming Yang**[1] **Yuanzhao Zhang**[3] **Sibo Cheng**[4] **Yi He**[1] **Zhuo Sun**[5] _[,]_[6] _[†]_ 

1Dynamic Systems Lab, University College London 

2Department of Earth Science and Engineering, Imperial College London 

3Santa Fe Institute 

4CEREA, ENPC and EDF R&D, Institut Polytechnique de Paris 

5School of Statistics and Data Science, Shanghai University of Finance and Economics 

6Institute of Big Data Research, Shanghai University of Finance and Economics 

_∗ Xiaoyuan Cheng and Wenxuan Yuan contributed equally to this work._ 

## ABSTRACT 

The Koopman operator provides a powerful framework for modeling dynamical systems and has attracted growing interest from the machine learning community. However, its infinite-dimensional nature makes identifying suitable finitedimensional subspaces challenging, especially for deep architectures. We argue that these difficulties come from suboptimal representation learning, where latent variables fail to balance expressivity and simplicity. This tension is closely related to the information bottleneck (IB) dilemma: constructing compressed representations that are both compact and predictive. Rethinking Koopman learning through this lens, we demonstrate that latent mutual information promotes simplicity, yet an overemphasis on simplicity may cause latent space to collapse onto a few dominant modes. In contrast, expressiveness is sustained by the von Neumann entropy, which prevents such collapse and encourages mode diversity. This insight leads us to propose an information-theoretic Lagrangian formulation that explicitly balances this tradeoff. Furthermore, we propose a new algorithm based on the Lagrangian formulation that encourages both simplicity and expressiveness, leading to a stable and interpretable Koopman representation. Beyond quantitative evaluations, we further visualize the learned manifolds under our representations, observing empirical results consistent with our theoretical predictions. Finally, we validate our approach across a diverse range of dynamical systems, demonstrating improved performance over existing Koopman learning methods. The implementation is publicly available at https://github.com/Wenxuan52/InformationKoopman. 

## 1 INTRODUCTION 

Modeling and predicting the behavior of nonlinear dynamical systems are fundamental problems in science and engineering (Brunton et al., 2020; Kovachki et al., 2023; Mezic, 2020). Classical approaches typically rely on nonlinear differential equations or black-box learning methods. In contrast, the Koopman operator framework offers a compelling alternative: it represents nonlinear evolution as a linear transformation in an appropriate function space (Koopman, 1931; Fritz, 1995). 

**Motivation.** This linearization principle has recently attracted significant attention in the deep learning community, as it enables complex nonlinear dynamics to be modeled and predicted using linear representations. However, integrating this framework into deep architectures poses a fundamental challenge: the Koopman operator is inherently infinite-dimensional, necessitating the identification or learning of a suitable finite-dimensional subspace for practical implementation. Deep learning models, most notably variational autoencoders (VAEs), have been employed to approximate such 

> _∗_ Email Xiaoyuan Cheng and Wenxuan Yuan to ucesxc4@ucl.ac.uk and wenxuan.yuan@qq.com. 

> _†_ Corresponding Author. Corresponding to Zhuo Sun: sunzhuo@mail.shufe.edu.cn. 

1 

Published as a conference paper at ICLR 2026 

subspaces in a purely data-driven manner (Otto & Rowley, 2019; Pan & Duraisamy, 2020; Liu et al., 2023). Yet in practice, the resulting representations often suffer from instability, mode collapse or fail to produce reliable dynamics. To address these challenges, some studies incorporate domain-specific priors—such as symmetry, conservation laws, dissipation, or ergodicity (Vaidya & Mehta, 2008; Weissenbacher et al., 2022; Azencot et al., 2020; Cheng et al., 2025)—into the Koopman representation. While effective in restricted settings, such approaches lack general principles for guiding Koopman representation. This calls for a more general and principled approach to constructing finite-dimensional representations, one that balances simplicity, in the form of latent linearity, with sufficient expressiveness (more literature review in Appendix C). 

**Information Bottleneck View.** A natural way to achieve the tradeoff between simplicity and expressiveness is through the lens of the Information Bottleneck (IB). The classic IB framework formalizes the idea that a good representation should compress the input as much as possible while preserving information relevant to a downstream task (Tishby et al., 2000; Tishby & Zaslavsky, 2015). In the context of representation learning (see Table 1), this typically means finding a latent variable _z_ that minimizes Complexity( _x, z_ )[1] from input _x_ , while retaining expressiveness by improving Relevance( _z, y_ ) (Vera et al., 2018). Instead of a static latent representation, the goal of Koopman representation is to predict the future state _xn_ given the current state _xn−_ 1 via a latent variable _zn−_ 1. This gives rise to a dynamical information bottleneck formulation: we aim to learn a Koopman representation _zn−_ 1 with maximal linear predictability of future state _xn_ , while remaining as compact as possible. 

Table 1: Information-theoretic comparison between standard and Koopman representations. Here, _β_ controls the trade-off between simplicity and future-state expressiveness. 

||**Latent Representation**|**Koopman Representation**|
|---|---|---|
|**Goal**|Disentangled_z_|Predictive_zn−_1|
|**Info. Flow**|_x→z →y_|_xn−_1_→zn−_1<br>Koopman operator<br>_−−−−−−−−→zn →xn_|
|**Lagrangian**|_β_Complexity(_x, z_) _−_<br>Relevance(_z, y_)|_β_Complexity(_xn−_1_, zn−_1) _−_<br>Relevance(_zn−_1_, xn_)|



**Why Is Finding a Good Koopman Representation Challenging?** Learning Koopman representation imposes stricter constraints than conventional latent representation models (see Table 1). In VAE or _β−_ VAE (Kingma et al., 2013; Burgess et al., 2018), the focus is on reconstructing the input _x_ or sampling from its distribution, which only requires the latent representation _z_ to contain enough information about _y_ . However, in Koopman learning, the latent space needs to support linear forward from _zn_ to _zn_ +1 in some finite-dimensional spaces. This constraint implies that the latent representation must not only capture information about the current state but also conform to a linear predictive structure ( _structural consistency_ ) (Mardt et al., 2018; Kostic et al., 2023a;b; 2024), which imposes a stronger restriction. Prior work has shown that simply increasing the dimensions of the latent space does not necessarily improve performance (Li et al., 2020; Brunton et al., 2021), underscoring the importance of maintaining _temporal coherence_ , i.e., ensuring that latent trajectories evolve consistently over time to prevent instability and error accumulation. Moreover, _predictive sufficiency_ requires that the latent representation retains enough Koopman modes to faithfully reconstruct the system’s future trajectories, such that multi-step prediction accuracy is preserved (Wang et al., 2022; 2025). Unlike standard VAEs and their variants, which emphasize flexible latent representations to support reconstruction, Koopman models demand dynamically consistent latent representations: small deviations can propagate and amplify over time. In summary, while conventional representation learning emphasizes disentanglement and reconstruction, Koopman representation learning requires three key properties: temporal coherence, predictive sufficiency, and structural consistency. The IB framework provides a meta view to navigate these trade-offs. It enables us to ask the central question: 

## _Is it possible to learn Koopman representations that are both structurally simple and expressive, under the guidance of information-theoretic principles?_ 

Motivated by this question, we approach the problem from a fresh IB perspective, leading to core contributions: **Theoretical Insight.** We develop an information-theoretic framework for Koopman representation, proving that mutual information controls error bounds while von Neumann entropy 

> 1By Complexity( _x, z_ ) we mean the mutual information _I_ ( _x_ ; _z_ ) in the IB framework, quantifying how much of the input information _x_ is retained in _z_ . Relevance( _z, y_ ) denotes _I_ ( _z_ ; _y_ ), the information _z_ carries about _y_ . 

2 

Published as a conference paper at ICLR 2026 

determines the effective dimension. By disentangling the information content of Koopman representations, we reveal how temporal coherence, predictive sufficiency, and structural consistency are governed by latent information and how these components are intrinsically connected to the spectral properties of the Koopman operator. This yields a novel information-theoretic Lagrangian that extends the classical IB principle by explicitly incorporating dynamical constraints, thereby making the fundamental trade-off between simplicity and expressivity in Koopman representation mathematically explicit. **Principled Framework.** Building on our information-theoretic Lagrangian, we derive a tractable, architecture-agnostic loss function that translates our theory into a practical algorithm. Each term of the loss corresponds directly to one of the three desiderata—temporal coherence, predictive sufficiency, and structural consistency. This yields a general algorithm that is broadly applicable: it extends naturally from physical dynamical systems to high-dimensional visual inputs and graph-structured dynamics, and our empirical results validate the theoretical predictions. 

## 2 PRELIMINARIES 

**Notation.** Let _M ⊂_ R _[n]_ be a finite-dimensional manifold equipped with a measure _µ_ . Consider a discrete-time nonlinear map _T_ : _M →M_ , so that the state _xt ∈M_ evolves according to _xt_ = _T_ ( _xt−_ 1). We denote by _H_ = _L_[2] ( _M, µ_ ), the Hilbert space of real-valued observables _ϕ_ : _M →_ R. 

**Definition 2.1 (Koopman Operator (Koopman, 1931))** _The_ Koopman operator _K_ : _H →H is a linear operator acting on observables as_ 

**==> picture [288 x 11] intentionally omitted <==**

Despite the appeal of lifting nonlinear dynamics into a linear forward via Koopman representation, practical approximations require projecting the infinite-dimensional function space _H_ onto a finitedimensional subspace. In the Koopman learning framework, this restriction manifests as learning a finite set of effective latent features _{ϕ_ 1 _, ϕ_ 2 _, . . . , ϕd}_ that map the state _x_ as a latent representation _z_ := _ϕ_ ( _x_ ) _∈ Z_ ⊊ _H_ , where _Z_ is the latent space spanned by the selected latent features. The center of this paper is on discussion how to find a good representation _z_ . To ground the principles of information theory, we introduce some essential technical definitions. 

**Definition 2.2 (Mutual Information (MacKay, 2003))** _Given two random variables x and y with joint probability distribution p_ ( _x, y_ ) _and marginal distributions p_ ( _x_ ) _and p_ ( _y_ ) _, the_ mutual information _I_ ( _x_ ; _y_ ) _quantifies the amount of information shared between x and y, and is defined as_ 

**==> picture [180 x 25] intentionally omitted <==**

**Definition 2.3 (Von Neumann Entropy (Witten, 2020))** _Let ρ ∈_ R _[d][×][d] be a symmetric, positive semidefinite matrix with trace_ 1 _. The_ von Neumann entropy _of ρ is defined as_ 

**==> picture [96 x 11] intentionally omitted <==**

_If {λi}[d] i_ =1 _[are the eigenvalues of][ ρ][, then][ S]_[(] _[ρ]_[)][=] _[−]_[�] _[d] i_ =1 _[λ][i]_[ log] _[ λ][i][.][This value reflects latent effec-] tive dimensions: it is close to_ 0 _if ρ is concentrated on a single direction, and close to_ log _d if ρ is spread uniformly. More connection with effective dimension is given in Appendix E._ 

Intuitively, mutual information and the von Neumann entropy provide a principled way to measure the predictability and the intrinsic effective dimension of Koopman representation. Building on these preliminaries, we can quantify the preserved information under Koopman representation. 

## 3 METHOD 

Our approach proceeds as: (1) a probabilistic analysis in Koopman representation how information loss drives error accumulation; (2) an information-theoretic characterization linking lost information to Koopman spectral properties; (3) a general Lagrangian formulation to guide better representation. 

3 

Published as a conference paper at ICLR 2026 

## 3.1 INFORMATION FLOW IN KOOPMAN REPRESENTATION 

**A probabilistic view of Koopman representation.** Firstly, we denote _x_ 1: _t_ and _z_ 1: _t_ as the states and their corresponding autoregressively generated latent variables from time step 1 to _t_ , respectively. According to the direct information flow in Table 1, the Koopman representation induces the following trajectory distribution given _x_ 0: 

**==> picture [337 x 29] intentionally omitted <==**

Here, _p_ ( _z_ 0 _|x_ 0) acts as the encoder, mapping the initial state into a latent variable. The latent forward is modeled by a linear Gaussian transition, where _p_ ( _zn|zn−_ 1) = _N_ ( _zn|Kzn−_ 1 _,_ Σ) is a probabilistic representation of equation 1 with variance Σ. This directly reflects Definition 2.1, as the latent evolution is constrained to be linear. Finally, each state _xn_ is reconstructed from its corresponding latent variable _zn_ via a decoder _p_ ( _xn|zn_ ), typically instantiated as a Gaussian. We now turn to the fundamental question of whether information is inevitably lost during latent propagation. 

_K_ **Proposition 1 (Information Loss in Latent Evolution)** _Let xn−_ 1 _→ zn−_ 1 _−→ zn → xn represent the information propagation in Koopman representation as shown in equation 2. Then, by the property of mutual information, the following holds:_ 

**==> picture [276 x 11] intentionally omitted <==**

The detailed proof and its multi-step extension are provided in Appendix F.1. The first inequality reflects that the mapping _xn−_ 1 _→ zn−_ 1 is a compressed representation, which may discard predictive information about _xn_ . The second inequality indicates that the latent forward propagation _zn−_ 1 _→ zn_ is governed by Koopman operator, inherently limits the information that can be preserved in the latent space. As a result, _I_ ( _zn−_ 1; _xn_ ) is larger than _I_ ( _zn−_ 1; _zn_ ), since the future state _xn_ generally carries more dependencies on _zn−_ 1 than the latent evolution alone. In this sense, _I_ ( _zn−_ 1; _zn_ ) sets the _information limit_ of Koopman representation by the operator _K_ . 

While Proposition 1 shows the degradation of information along latent propagation, it remains an abstract statement that is not directly tractable under the complex trajectory distributions in equation 2. To obtain a tractable measure, we turn to the Kullback–Leibler (KL) divergence as a natural way to quantify the discrepancy between true and Koopman-induced trajectories: 

**==> picture [386 x 14] intentionally omitted <==**

Here, _p_ is the true distribution and _p[KR]_ is the ideal Koopman model distribution in equation 2 without any approximations. _q[KR]_ is the variational approximation, _E_ enc, _E_ tra and _E_ rec are approximation errors induced by the latent representation, Koopman operator and reconstruction (see details in Appendix F.2). This motivates the following result, which formalizes how the information gap translates into an autoregressive error bound for Koopman representations. 

**Proposition 2 (Autoregressive Error Bound of Koopman Representation)** _The distribution discrepancy between the true and Koopman-induced trajectories is bounded by the information gap as_ 

**==> picture [347 x 118] intentionally omitted <==**

_Here, ∥· ∥T V is the total variation distance. The upper error bound is obtained as_ 

_where C_[¯] _is a positive constant and E is related to the approximation error in equation 4._ 

4 

Published as a conference paper at ICLR 2026 

The proof is in Appendix F.3. The KL divergence between the true and Koopman-induced trajectory distributions reflects how much temporal coherence is lost during representation. Here, _I_ ( _xn−_ 1; _xn_ ) quantifies the intrinsic dynamical coupling _T_ in the original system, while _I_ ( _zn−_ 1; _zn_ ) characterizes the information of that coupling that exists under Koopman representation. Since _I_ ( _zn−_ 1; _zn_ ) acts as the information limit (see Proposition 1), the gap _I_ ( _xn−_ 1; _xn_ ) _− I_ ( _zn−_ 1; _zn_ ) measures the information that is lost when nonlinear dynamics are approximated by Koopman representation. Also, we link the upper/lower error bounds and distribution discrepancy in equations 6 (lower bound see equation 25). It reflects the prediction error is bounded by the step-wise information limit. 

## 3.2 INFORMATION COMPONENTS IN KOOPMAN REPRESENTATION 

The latent mutual information quantifies the magnitude of error, but does not uncover how this loss relates to Koopman spectral properties. To sharpen the insight from Propositions 1 and 2, we consider the aggregated quantity _I_ ( _zt_ ; _xt_ ), which measures the total information available to the decoder _p_ ( _xt|zt_ ). Our focus is on how much of this information can be stably propagated from past latent variables _zt−n_ . 

**==> picture [369 x 131] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a): Overall Architecture (c): Spectral Water-Filling Effect<br>MI VNE MI + VNE<br>Input Latent space Output<br>Koopman<br>Operator<br>Spectral Mode Allocated Information<br>(b): Spectral Information Disentanglement<br>Encoding<br>Original Space Decoding Latent Space<br>Encoder Decoder Koopman Operator<br>**----- End of picture text -----**<br>


Figure 1: Information-theoretic Koopman framework. (a) Structure overview, (b) Information disentanglement with spectral interpretations, and (c) Water-filling effect of Mutual Information (MI) and von Neumann entropy (VNE) on spectral information allocation. 

**Proposition 3 (Information Disentanglement and Spectral Property)** _The mutual information I_ ( _zt_ ; _xt_ ) _can be disentangled into a summation of three distinct components, each with a spectral interpretation (see proof in Appendix F.4, see Figure 1(b)):_ 

|**_Component_**|_Temporal-coherent_<br>_Fast-dissipating_<br>_Residual_|
|---|---|
|_Spectral property_<br>_λ≈_1<br>_λ <_1<br>_no counterpart_<br>_Mutual info term_<br>_I_(_zt−n_;_zt_)<br>_↑_<br>_I_(_zt_;_xt−_1 _| zt−n_) _↓_<br>_I_(_zt_;_xt | xt−_1) _↓_||



_The decomposition shows that Koopman representations preserve temporal-coherent information associated with spectral modes of the Koopman operator whose eigenvalues lie near the unit circle, while information linked to dissipating modes (|λ| <_ 1 _) decays rapidly and noiselike components have no spectral support, hence compressible._ 

_(1). Temporal-coherent information I_ ( _zt−n_ ; _zt_ ) _(see closed form equation 29)._ This term represents information that persists along the latent evolution _zt−n →· · · → zt_ . It corresponds to conserved or slowly dissipating information that remains stable during latent evolution. From a spectral perspective, _these are associated with Koopman modes whose eigenvalues are near to the complex unit circle (i.e., |λ| ≈_ 1 _)_ , implying that the corresponding information is propagated almost losslessly across time and hence remains mutually informative between past and present latent variables. 

_(2). Fast-dissipating information I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) _(see closed form equation 35)._ This term reflects short-term dependencies that arise from the most recent state _xt−_ 1, beyond what is already encoded in the past latent state _zt−n_ . Such information provides transient predictive power but quickly leaks out, since the autoregressive latent evolution _zt−n →· · · → zt_ cannot continually access external inputs _xt−_ 1. In contrast, _these contributions are associated with Koopman modes whose eigenvalues satisfy |λ| <_ 1, indicating exponential information dissipation with forward steps. Consequently, 

5 

Published as a conference paper at ICLR 2026 

the mutual information they contribute vanishes rapidly as the time step _n_ increases, making those modes inherently cannot be captured by temporal-coherent information. 

_(3). Residual information I_ ( _zt_ ; _xt|xt−_ 1) _(see closed form equation 36)._ This term measures unpredictable information in the current state that cannot be explained from the past state. It corresponds to information injected at the present step—such as noise or anomalies—that interferes with constructing a coherent latent state. Unlike temporal-coherent or fast-dissipating modes, _these residuals have no spectral counterpart in the Koopman operator: they are not tied to any eigenvalue structure_ . From the IB perspective, such non-predictive component is compressible. Having the disentangled information, the next question is how latent mutual information shapes Koopman representations. 

**Proposition 4 (The Role of Latent Mutual Information)** _Maximizing the latent mutual information I_ ( _zt−n_ ; _zt_ ) _allocates spectral weights to temporally coherent modes in the latent space, thereby enhancing the relevance of the Koopman representation. However, excessive emphasis on this objective can lead to mode collapse, where the representation concentrates on only a few dominant modes and loses effective dimension (see Figure 1(c))._ 

In Koopman representation, the latent mutual information admits a closed form 

**==> picture [308 x 21] intentionally omitted <==**

where det denotes the determinant, I is the identity matrix, _C_ := _Cov_ ( _zt−n_ ) is the latent covariance matrix and _Mn_ :=[�] _[n] i_ =0 _[−]_[1] _[K][i]_[Σ(] _[K][i]_[)] _[⊤]_[is][the] _[n][−]_[step][linear][forward][covariance][(see][detailed] explanation and proof in Appendix F.5). We find that, from a Lagrangian perspective, maximizing _I_ ( _zt−n_ ; _zt_ ) of Koopman representation under the finite variance constraint tr( _C_ ) _< ∞_ leads to a _water-filling allocation_ : variance is distributed along the directions corresponding to the largest _−_[1] _−_[1] eigenvalues of _Mn_ 2 _K[n] C_ ( _K[n]_ ) _[⊤] Mn_ 2 . These directions correspond to temporally coherent modes, which explains why higher latent mutual information enhances relevance. However, when the spectrum of this matrix is highly skewed, the water-filling solution degenerates into a low-rank allocation, _squeezing_ information into only a few dominant directions. This effect reduces the effective dimension of the latent space _Z_ , causing some spectral weights to vanish (cf. equation 43). To address the collapse induced by skewed spectral allocation, we next analyze how effective dimension can be preserved through entropy regularization. 

**Proposition 5 (Effective Dimension and Anti-Collapse)** _Low effective dimension (see Proposition 4) in Koopman representation indicates information collapse to few dominant modes and limits the model’s ability to represent rich modes. Penalizing the von Neumann entropy S_ ( tr( _CC_ )[)] _[ encourages more expressive and spectrally diverse representations.]_ 

Connecting to Proposition 4, Appendix F.6 contains a detailed proof via a water-filling and Lagrangian view. The normalized operator tr( _CC_ )[can be regarded as a density matrix in Hilbert space,] and the effective dimension can be measured as exp( _S_ ) (see Definition E.2). When penalized with large the von Neumann entropy, the water-filling solution attains a non-zero allocation across all modes, preventing variance from collapsing entirely onto a few dominant directions (cf. equation 46). This ensures a positive distribution of spectral weights across all modes, thereby avoiding degenerate spectra and increasing the effective dimension of the latent space _Z_ (see Figure 1(c)). 

## 3.3 INFORMATION-THEORETIC FORMULATION FOR PRACTICAL IMPLEMENTATION 

The preceding analysis (Propositions 3, 4 and 5) reveals a fundamental trade-off in Koopman representation learning: maximizing latent mutual information enhances temporal coherence and predictive ability but risks mode collapse, whereas entropy regularization promotes spectral diversity for predictive sufficiency. Based on this principle, we formulate the following unified Lagrangian: 

**==> picture [343 x 19] intentionally omitted <==**

where _α_ , _β_ and _γ_ are Lagrangian multipliers. In equation 8, the first term in equation 7 preserves temporal-coherent information, the second term penalizes fast-dissipating or confounding components ( _I_ ( _zt_ ; _xt|zt−n_ ) = _I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) + _I_ ( _zt_ ; _xt|xt−_ 1), see proof in equation 31), the third term 

6 

Published as a conference paper at ICLR 2026 

rewards larger von Neumann entropy of the normalized covariance to promote spectral diversity in the latent space _Z_ . Lastly, log _p_ ( _xt|zt_ ) is the reconstruction terms from predicted latent variable _zt_ . 

While the Lagrangian in equation 8 captures the desired information-theoretic trade-offs, it is not directly computable. To make it practical, we derive a tractable loss function for satisfying temporal coherence, predictive sufficiency and structural consistency 

**==> picture [357 x 72] intentionally omitted <==**

In VAE structure (shown in Figure 1(a)) , each component of the loss plays a distinct role in balancing the information-theoretic objectives: (1) The mutual information _I_ ( _zn_ ; _Pn_ ) captures temporal coherence by linking _zn_ to its temporal neighborhood _Pn_ = _{zn±i |_ 1 _≤ i ≤ k}_ , which includes immediate past and future latent states; in practice, this can be computed either via the closed form in equation 7 for low-dimensional latents, or approximated by InfoNCE (Wu et al., 2020) for high-dimensional settings. (2) The term _−_ E _pθ_ ( _zn|xn_ )[log _qψ_ ( _zn|zn−_ 1)] _− Hpθ_ ( _zn|xn_ ) serves as an equivalent representation of the conditional mutual information _I_ ( _zt_ ; _xt|zt−_ 1), with linear Gaussian transition _qψ_ ( _zn|zn−_ 1) = _N_ ( _zn|Kψzn−_ 1 _,_ Σ _ψ_ ) and entropy of encoder _Hpθ_ ( _zn|xn_ ) (see Appendix G.1). Minimizing this KL not only encourages the latent representation to capture information from the state _xn_ , but also compresses fast-dissipating and residual components, ensuring that the representation remains expressive yet simple. Here, E _pθ_ ( _zn|xn_ )[log _qψ_ ( _zn|zn−_ 1)] enforces structural consistency in latent space. (3) The term log _pω_ ( _xn|zn_ ) is the decoder loss from predicted _C_ latent variable _zn_ . (4) von Neumann entropy term _S_ � tr( _C_ ) � is computed from the normalized co- 

variance matrix _C_ = _B_ 1 � _Bi_ =1[(] _[z][i][−][z]_[¯][)(] _[z][i][−][z]_[¯][)] _[⊤]_[of][the][latent][codes][within][a][minibatch][of][size] _B_ . This promotes spectral diversity and guards against mode collapse, ensuring that the learned Koopman representation retains predictive sufficiency. (5) _L_ ELBO is the Evidence Lower Bound (ELBO) for training stability and reconstruction (see more analysis and implementation details in Appendix G.1). For AE structure, E _pθ_ ( _zn|xn_ )[log _qψ_ ( _zn|zn−_ 1)] degenerates into a _L_[2] loss enforcing the structural consistency _∥zn_ +1 _−Kψzn∥_[2] , and ELBO becomes AE reconstruction term (see G.2). 

## 4 EXPERIMENTS 

**Tasks.** We evaluate our approach across three types of dynamical data: (1) **Physical simulations** , including Lorenz 63, K´arm´an vortex street, Dam flow, and weather forecasting task (ERA5), which test the ability to capture nonlinear, stochastic and high-dimensional physical dynamics; (2) **Visualinput control** , including image-based Planar, Pendulum, Cartpole, and 3-Link manipulator, which evaluate the ability to extract latent dynamics from high-dimensional visual inputs while controllable in latent spaces; and (3) **Graph-structured dynamics prediction** , including Rope and Soft Robotics, which tests generalized abilities of latent representation on dynamics with graph structures (see experimental details in Appendix G.3). 

**Metrics.** We assess performance on both **forecasting** and **control** . For forecasting, we report (i) normalized root mean square error (NRMSE) for short- and long-term predictions (for physical simulation and graphs-structured dynamics), (ii) physical consistency metrics based on spectral distribution errors based on 1000 _−_ step sequences (SDEs), (iii) distributions of state measured by the Kullback–Leibler divergence (KLD), and (iv) structural similarity index (SSIM) for physical simulations. (v) the quality of low-dimensional manifold construction from high-dimensional visual inputs. For control, we measure the success rate of latent-space control of visual inputs following the setting in (Levine et al., 2020). 

**Baseline Algorithms.** We compare against competitive baselines for each type of task. For **physical simulations** , we include VAE (Burgess et al., 2018), Koopman Autoencoder (KAE) (Pan et al., 2023), Koopman Kernel Regression (KKR) (Bevanda et al., 2023), and a SOTA Koopman variant for chaos - Poincar´e Flow Neural Network (PFNN) (Cheng et al., 2025). For **visual-input control** , 

7 

Published as a conference paper at ICLR 2026 

we consider VAE-based representation learning methods, including Embed to Control (E2C) (Banijamali et al., 2019), as well as Prediction, Consistency and Curvature (PCC) (Levine et al., 2020), together with KAE. For **graph-structured dynamics** , we compare with Compositional Koopman Operator (CKO) (Li et al., 2020), the current SOTA method for graph-structured dynamics. 

Table 2: Performance comparison of five algorithms on physical simulation tasks. PFNN is designed for chaotic dynamics and is thus not evaluated on Dam Flow. Here, _N_ -NRMSE and _N_ -SSIM denote errors at _N_ prediction steps, values in parentheses indicate variance, and SDE is the spectral distribution error. Best results are highlighted in bold with green, second best are shaded in blue. 

|Task|Metric|VAE|KAE|KKR|PFNN|Ours|
|---|---|---|---|---|---|---|
||5-NRMSE|0.005 (0.002)|0.006 (0.003)|0.004 (0.002)|0.005 (0.003)|**0.003 (0.002)**|
|Lorenz 63|20-NRMSE|0.011 (0.007)|0.014 (0.009)|0.009 (0.008)|0.011 (0.007)|**0.007 (0.004)**|
|(_n_ = 3)|50-NRMSE|0.019 (0.011)|0.023 (0.013)|0.017 (0.009)|0.017 (0.007)|**0.013 (0.008)**|
||KLD|1.047|0.464|0.342|0.293|**0.285**|
||5-NRMSE|0.127 (0.005)|0.149 (0.011)|0.114 (0.065)|0.075 (0.007)|**0.068 (0.006)**|
||20-NRMSE|0.134 (0.003)|0.195 (0.015)|0.157 (0.057)|0.125 (0.012)|**0.114 (0.015)**|
|K´arm´an Vortex<br>(_n_ = 64_×_64_×_2)|50-NRMSE<br>5-SSIM<br>20-SSIM|0.211 (0.018)<br>0.743 (0.100)<br>0.720 (0.079)|0.233 (0.027)<br>0.719 (0.030)<br>0.586 (0.039)|0.209 (0.028)<br>0.868 (0.087)<br>0.732 (0.086)|**0.137 (0.015)**<br>0.920 (0.030)<br>0.800 (0.050)|0.138 (0.018)<br>**0.936 (0.025)**<br>**0.823 (0.047)**|
||50-SSIM|0.539 (0.045)|0.571 (0.037)|0.581 (0.061)|**0.710 (0.030)**|0.688 (0.020)|
||SDE|0.538|0.620|0.799|0.278|**0.256**|
||5-NRMSE|0.030 (0.001)|0.037 (0.000)|0.019 (0.003)|–|**0.018 (0.001)**|
||20-NRMSE|0.033 (0.000)|0.042 (0.000)|0.028 (0.002)|–|**0.024 (0.001)**|
|Dam Flow<br>(_n_ = 64_×_64_×_2)|50-NRMSE<br>5-SSIM<br>20-SSIM|0.034 (0.000)<br>0.522 (0.021)<br>0.443 (0.007)|0.046 (0.001)<br>0.419 (0.031)<br>0.282 (0.024)|0.031 (0.002)<br>0.720 (0.034)<br>0.584 (0.025)|–<br>–<br>–|**0.026 (0.003)**<br>**0.760 (0.012)**<br>**0.627 (0.010)**|
||50-SSIM|0.404 (0.005)|0.176 (0.008)|0.502 (0.010)|–|**0.577 (0.006)**|
||SDE|0.563|0.488|0.373|–|**0.244**|
||5-NRMSE|–|0.055|0.058|0.049|**0.028**|
||10-NRMSE|–|0.063|0.068|0.060|**0.035**|
|ERA5 Weather|50-NRMSE|–|0.118|0.074|0.079|**0.068**|
|(channel avg)|5-SSIM|–|0.666|0.664|0.697|**0.867**|
||10-SSIM|–|0.619|0.606|0.635|**0.808**|
||50-SSIM|–|0.481|0.707|0.695|**0.781**|



**Result Analysis.** Our analysis is organized around the contributions established in propositions(Section 3), and we structure the discussion by addressing the following key questions. _(1) Does the latent mutual information determine the predictive limit of the Koopman representation? (Proposition 2)_ – Yes. This is verified by the quantitative results of physical simulations in Table 2. Consistent with proposition, the prediction error under Koopman representation inevitably accumulates and is bounded by the latent mutual information. By regularizing with latent mutual information, both short- and long-term predictions are improved. Notably, PFNN (Cheng et al., 2025) is a SOTA model specifically designed with domain-specific knowledge, while our method, grounded in general information theory, achieves comparable performance on chaotic tasks (Lorenz 63 and K´arm´an vortex). Compared with other Koopman-based methods, our approach yields substantial improvements in both physical consistency and predictive accuracy. 

_(2) How is the preserved information—particularly that associated with Koopman eigenmodes near the unit circle—shaped by latent mutual information and von Neumann entropy in constructing a dynamics-relevant manifold? (Proposition 4 and 5)_ The preserved information manifests in Koopman modes with eigenvalues lying close to the unit circle, capturing the recurrent structure of the K´arm´an vortex limit cycle, as shown in Figure 2 (left). However, KAE suffers from some eigenvalues collapse toward zero, reducing the effective latent dimension. This collapse explains the drift observed in its autoregressive prediction. In contrast, our model captures the limit-cycle structure and produces stable autoregressive trajectories, consistently revolving around the true orbit (Figure 2, right). Baselines such as KKR and PFNN also capture limit-cycle structure (via one-step reconstruction) but gradually deviate from the correct trajectory over long horizons. By incorporating latent mutual information, we ensure that temporal-coherent information is retained, while von Neumann entropy prevents eigenvalue degeneration and preserves sufficient modes. Consequently, the information behind those modes can be preserved over long horizons, which directly translates into improved long-term prediction accuracy and statistical consistency, as also reported in Table 2. 

8 

Published as a conference paper at ICLR 2026 

**==> picture [393 x 67] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ours KAE<br>𝑅𝑒(𝜆) 𝑅𝑒(𝜆)<br>𝐼𝑚(𝜆) 𝐼𝑚(𝜆)<br>**----- End of picture text -----**<br>


Figure 2: Eigenvalue comparison and manifold visualization of the K´arm´an vortex street. **Left:** Eigenvalue distributions of Koopman operators. **Right:** t-SNE visualization of learned latent manifolds for five methods on the K´arm´an vortex. The underlying dynamics is abstracted as a limit cycle. 

_(3) How does explicit information-theoretic regularization sufficiently capture essential dynamics, compared with VAEs and Koopman autoencoders? (Proposition 4 and 5)_ As shown in the reconstructed manifolds of Figure 3, our method produces a latent manifold that aligns most closely with the ground truth. For E2C, which is directly built on a VAE architecture, the latent geometry is heavily distorted (the loss of coherence). The manifold learned by KAE collapses into a nearly onedimensional structure, reflecting the lack of effective dimensions in its latent space. PCC, a modified VAE-based method designed to improve manifold construction, demonstrates partial improvement but still exhibits a gap compared with our approach. By preserving both effective dimensionality and temporal coherence, our Koopman representation achieves the best average control performance in both noiseless and noisy environments (Table 8 and 9 in Appendix G.5.2). 

**==> picture [378 x 75] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground truth E2C manifold PCC manifold KAE manifold Our manifold<br>Y-axis position<br>**----- End of picture text -----**<br>


Figure 3: Latent manifolds of Planar visualized using locally linear embedding. The first subfigure shows the ground truth, while the second to fifth depict manifolds learned by different algorithms. 

**==> picture [390 x 211] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth KAE KKR PFNN Ours<br>0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840<br>0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472<br>0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840 0.00000 0.00614 0.01227 0.01840<br>0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472 0.00000 0.00491 0.00981 0.01472<br>08:00<br>2018-01-01<br>Error<br>08:00<br>2018-01-08<br>Error<br>**----- End of picture text -----**<br>


Figure 4: Comparison of continuous predictions for the global humidity starting from 2018 _−_ 01 _−_ 01 _−_ 00 : 00 to 2018 _−_ 01 _−_ 08 _−_ 08 : 00. Error maps in the lower panels demonstrate that, compared with other models, showing with more stable and accurate results of our model (see more demonstration in Appendix G.5.1). 

9 

Published as a conference paper at ICLR 2026 

_(4) How robust are the findings under noise, extended prediction horizons, and large-scale settings? (Proposition 1 and 2)_ Our method remains robust under both noisy observations and extended prediction horizons. As shown in Table 2 and Figure 4, it maintains stable performance in long-term rollouts and physical statistics in large scale weather forecasting. Moreover, our approach supports control under noisy environments, achieving competitive performance. These quantitative results are consistent with our probabilistic propositions. 

_(5) To what extent can our Lagrangian formulation be generalized to diverse architectures and adapted to support downstream tasks? (Proposition 1-5)_ Our formulation demonstrates broad applicability: it consistently improves performance across physical simulations (see Table 2), visual perception tasks for manifold construction and control (see Figure 3, Tables 8 and 9 in Appendix G.5.2), and graph-structured dynamics prediction (see Figure 5). These gains indicate that the proposed Lagrangian principle is architecture-agnostic and can be readily incorporated into different settings to enhance both predictive accuracy and task effectiveness (more results are referred to Appendix G.5). 

**==> picture [378 x 73] intentionally omitted <==**

Figure 5: Comparison of prediction over 100 rollout steps. The left two figures show results for the Rope environment ( _n ∈_ [40 _,_ 56]) with and without noise; the right two subfigures are the results for the Soft environment ( _n ∈_ [160 _,_ 224]). 

**==> picture [378 x 66] intentionally omitted <==**

**----- Start of picture text -----**<br>
𝛼= 0, 𝛽= 2, 𝛾= 0.5 𝛼= 1, 𝛽= 0, 𝛾= 0.5 𝛼= 1, 𝛽= 2, 𝛾= 0 𝛼= 4, 𝛽= 2, 𝛾= 0 𝛼= 2, 𝛽= 2, 𝛾= 0.5 𝛼= 3, 𝛽= 2, 𝛾= 0.5<br>π<br>−π<br>Pendulum  Angle<br>**----- End of picture text -----**<br>


Figure 6: Ablation study on the pendulum task. Latent manifolds are learned from high-dimensional pendulum images, where the ground-truth phase space is isomorphic to _S_[1] _×_ R. Color represents the pendulum angle. Each subplot corresponds to removing or adjusting one regularization term: latent mutual information ( _α_ ), KL divergence ( _β_ ), and von Neumann entropy ( _γ_ ). 

**Ablation Studies.** We analyze the effect of varying each Lagrangian multiplier to understand its role in shaping Koopman representation. In the pendulum task, the ground-truth phase space is _S_[1] _×_ R, consisting of a periodic angle and an angular velocity. The ablation study in Figure 6 illustrates how each regularization term contributes to recovering this manifold from high-dimensional visual inputs. Without mutual information regularization ( _α_ = 0), temporal coherence is lost and the latent space degenerates into scattered points without geometric structure. Without structural consistency ( _β_ = 0), the latent manifold collapses, highlighting its role in enforcing the dynamics of Koopman representation. Removing the von Neumann entropy term ( _γ_ = 0) retains the circular _S_[1] component but suppresses the R dimension, indicating the necessity of preserving effective dimensions. Increasing mutual information alone concentrates the representation on the _S_[1] component (reflecting Proposition 4), while regularizing with von Neumann entropy yields a manifold that closely approximates the full _S_[1] _×_ R structure. These observations align with the theoretical roles of the three penalties: temporal coherence, structural consistency and predictive sufficiency. 

## 5 CONCLUSION 

We presented a new perspective on Koopman representation by formulating it through an information-theoretic lens, leading to a general Lagrangian formulation that balances simplicity and expressiveness. Our analysis reveals the relationship between Koopman spectral properties and information in deep architectures. The proposed algorithm based on the Lagrangian formulation consistently improves the performance in a wide range of dynamical system tasks. 

10 

Published as a conference paper at ICLR 2026 

## ACKNOWLEDGMENTS 

Zhuo Sun is supported by Fundamental Research Funds for the Central Universities 2025110590 of Shanghai University of Finance and Economics. 

## ETHICS STATEMENT AND REPRODUCIBILITY STATEMENT 

This work raises no specific ethical concerns beyond standard practices in machine learning research. All methods, datasets, and hyperparameters are described in detail, and core code is released in supplementary materials. 

## REFERENCES 

Daniel Alpay. _Reproducing kernel spaces and applications_ , volume 143. Birkh¨auser, 2012. 

- Hassan Arbabi and Igor Mezic. Ergodic theory, dynamic mode decomposition, and computation of spectral properties of the koopman operator. _SIAM Journal on Applied Dynamical Systems_ , 16 (4):2096–2126, 2017. 

- Omri Azencot, N Benjamin Erichson, Vanessa Lin, and Michael Mahoney. Forecasting sequential data using consistent koopman autoencoders. In _International Conference on Machine Learning_ , pp. 475–485. PMLR, 2020. 

Francis Bach. Information theory with kernel methods. _IEEE Transactions on Information Theory_ , 69(2):752–775, 2022. 

Mark R Baker and Rajendra B Patil. Universal approximation theorem for interval neural networks. _Reliable Computing_ , 4(3):235–239, 1998. 

- Ershad Banijamali, Rui Shu, Hung Bui, Ali Ghodsi, et al. Robust locally-linear controllable embedding. In _International Conference on Artificial Intelligence and Statistics_ , pp. 1751–1759. PMLR, 2019. 

- Alain Berlinet and Christine Thomas-Agnan. _Reproducing kernel Hilbert spaces in probability and statistics_ . Springer Science & Business Media, 2011. 

- Petar Bevanda, Max Beier, Armin Lederer, Stefan Sosnowski, Eyke H¨ullermeier, and Sandra Hirche. Koopman kernel regression. _Advances in Neural Information Processing Systems_ , 36:16207– 16221, 2023. 

Petar Bevanda, Max Beier, Armin Lederer, Alexandre Capone, Stefan Sosnowski, and Sandra Hirche. Koopman-equivariant gaussian processes. _arXiv preprint arXiv:2502.06645_ , 2025. 

Stephen P Boyd and Lieven Vandenberghe. _Convex optimization_ . Cambridge university press, 2004. 

Morten Breivik and Thor I Fossen. Guidance laws for planar motion control. In _2008 47th IEEE Conference on Decision and Control_ , pp. 570–577. IEEE, 2008. 

Steven L Brunton, Bernd R Noack, and Petros Koumoutsakos. Machine learning for fluid mechanics. _Annual review of fluid mechanics_ , 52(1):477–508, 2020. 

- Steven L Brunton, Marko Budiˇsi´c, Eurika Kaiser, and J Nathan Kutz. Modern koopman theory for dynamical systems. _arXiv preprint arXiv:2102.12086_ , 2021. 

- Christopher P Burgess, Irina Higgins, Arka Pal, Loic Matthey, Nick Watters, Guillaume Desjardins, and Alexander Lerchner. Understanding disentangling in beta-vae. _arXiv preprint arXiv:1804.03599_ , 2018. 

- Xiaoyuan Cheng, Yi He, Yiming Yang, Xiao Xue, Sibo Cheng, Daniel Giles, Xiaohang Tang, and Yukun Hu. Learning chaos in a linear way. _arXiv preprint arXiv:2503.14702_ , 2025. 

Thomas M Cover. _Elements of information theory_ . John Wiley & Sons, 1999. 

11 

Published as a conference paper at ICLR 2026 

Imre Csisz´ar, Paul C Shields, et al. Information theory and statistics: A tutorial. _Foundations and Trends® in Communications and Information Theory_ , 1(4):417–528, 2004. 

- Suddhasattwa Das and Dimitrios Giannakis. Koopman spectra in reproducing kernel hilbert spaces. _Applied and Computational Harmonic Analysis_ , 49(2):573–607, 2020. 

- Suddhasattwa Das, Dimitrios Giannakis, and Joanna Slawinska. Reproducing kernel hilbert space compactification of unitary evolution groups. _Applied and Computational Harmonic Analysis_ , 54:75–136, 2021. 

- Marco Federici, Patrick Forr´e, Ryota Tomioka, and Bastiaan S Veeling. Latent representation and simulation of markov processes via time-lagged information bottleneck. _arXiv preprint arXiv:2309.07200_ , 2023. 

- J Fritz. John von neumann and ergodic theory. _The Neumann Compendium (F. Br ody and T. V amos, eds.), World Scientific, Singapore_ , pp. 127–131, 1995. 

- Katsuhisa Furuta, Masaki Yamakita, and Seiichi Kobayashi. Swing up control of inverted pendulum. In _Proceedings of IECON’91: 1991 International Conference on Industrial Electronics, Control and Instrumentation_ , pp. 2193–2198, 1991. 

- Shlomo Geva and J. Sitte. A cartpole experiment benchmark for trainable controllers. _Unpublished benchmark description (often cited in RL literature)_ , 1993. often referenced as the visual cartpole, see e.g. in RL benchmarks. 

- Hans Hersbach, Bill Bell, Paul Berrisford, Shoji Hirahara, Andr´as Hor´anyi, Joaqu´ın Mu˜noz-Sabater, Julien Nicolas, Carole Peubey, Raluca Radu, Dinand Schepers, Adrian Simmons, Cornel Soci, Saleh Abdalla, Xavier Abellan, Gianpaolo Balsamo, Peter Bechtold, Gionata Biavati, Jean Bidlot, Massimo Bonavita, Giovanna De Chiara, Per Dahlgren, Dick Dee, Michail Diamantakis, Rossana Dragani, Johannes Flemming, Richard Forbes, Manuel Fuentes, Alan Geer, Leo Haimberger, Sean Healy, Robin J. Hogan, El´ıas H´olm, Marta Janiskov´a, Sarah Keeley, Patrick Laloyaux, Philippe Lopez, Cristina Lupu, Gabor Radnoti, Patricia de Rosnay, Iryna Rozum, Freja Vamborg, Sebastien Villaume, and Jean-No¨el Th´epaut. The era5 global reanalysis. _Quarterly Journal of the Royal Meteorological Society_ , 146(730):1999–2049, 2020. 

- Patrick Kidger and Terry Lyons. Universal approximation with deep narrow networks. In _Conference on learning theory_ , pp. 2306–2327. PMLR, 2020. 

Diederik P Kingma, Max Welling, et al. Auto-encoding variational bayes, 2013. 

- Bernard O Koopman. Hamiltonian systems and transformation in hilbert space. _Proceedings of the National Academy of Sciences_ , 17(5):315–318, 1931. 

- Bernard O Koopman and J v Neumann. Dynamical systems of continuous spectra. _Proceedings of the National Academy of Sciences_ , 18(3):255–263, 1932. 

- Milan Korda and Igor Mezi´c. Optimal construction of koopman eigenfunctions for prediction and control. _IEEE Transactions on Automatic Control_ , 65(12):5114–5129, 2020. 

- Vladimir Kostic, Pietro Novelli, Andreas Maurer, Carlo Ciliberto, Lorenzo Rosasco, and Massimiliano Pontil. Learning dynamical systems via koopman operator regression in reproducing kernel hilbert spaces. _Advances in Neural Information Processing Systems_ , 35:4017–4031, 2022. 

- Vladimir Kostic, Karim Lounici, Pietro Novelli, and Massimiliano Pontil. Sharp spectral rates for koopman operator learning. _Advances in Neural Information Processing Systems_ , 36:32328– 32339, 2023a. 

- Vladimir R Kostic, Pietro Novelli, Riccardo Grazzi, Karim Lounici, and Massimiliano Pontil. Learning invariant representations of time-homogeneous stochastic dynamical systems. _arXiv preprint arXiv:2307.09912_ , 2023b. 

- Vladimir R Kostic, Karim Lounici, Prune Inzerilli, Pietro Novelli, and Massimiliano Pontil. Consistent long-term forecasting of ergodic dynamical systems. In _Forty-first International Conference on Machine Learning_ , 2024. 

12 

Published as a conference paper at ICLR 2026 

Nikola Kovachki, Zongyi Li, Burigede Liu, Kamyar Azizzadenesheli, Kaushik Bhattacharya, Andrew Stuart, and Anima Anandkumar. Neural operator: Learning maps between function spaces with applications to pdes. _Journal of Machine Learning Research_ , 24(89):1–97, 2023. 

- Nir Levine, Yinlam Chow, Rui Shu, Ang Li, Mohammad Ghavamzadeh, and Hung Bui. Prediction, consistency, curvature: Representation learning for locally-linear control. _arXiv preprint arXiv:1909.01506_ , 2020. 

- Yunzhu Li, Hao He, Jiajun Wu, Dina Katabi, and Antonio Torralba. Learning compositional koopman operators for model-based control. _arXiv preprint arXiv:1910.08264_ , 2020. 

- Yong Liu, Chenyu Li, Jianmin Wang, and Mingsheng Long. Koopa: Learning non-stationary time series dynamics with koopman predictors. _Advances in neural information processing systems_ , 36:12271–12290, 2023. 

Jan CA Lubbe. _Information theory_ . Cambridge university press, 1997. 

- David JC MacKay. _Information theory, inference and learning algorithms_ . Cambridge university press, 2003. 

- Andreas Mardt, Luca Pasquali, Hao Wu, and Frank No´e. Vampnets for deep learning of molecular kinetics. _Nature communications_ , 9(1):5, 2018. 

- Alexandre Mauroy, Y Susuki, and Igor Mezic. _Koopman operator in systems and control_ , volume 7. Springer, 2020. 

- Igor Mezic. Koopman operator, geometry, and learning. _arXiv preprint arXiv:2010.05377_ , 2020. 

Samuel E Otto and Clarence W Rowley. Linearly recurrent autoencoder networks for learning dynamics. _SIAM Journal on Applied Dynamical Systems_ , 18(1):558–593, 2019. 

- Shaowu Pan and Karthik Duraisamy. Physics-informed probabilistic learning of linear embeddings of nonlinear dynamics with guaranteed stability. _SIAM Journal on Applied Dynamical Systems_ , 19(1):480–509, 2020. 

- Shaowu Pan, Eurika Kaiser, Brian M de Silva, J Nathan Kutz, and Steven L Brunton. Pykoopman: A python package for data-driven approximation of the koopman operator. _arXiv preprint arXiv:2306.12962_ , 2023. 

- Stephan Rasp, Stephan Hoyer, Alexander Merose, Ian Langmore, Peter Battaglia, Tyler Russell, Alvaro Sanchez-Gonzalez, Vivian Yang, Rob Carver, Shreya Agrawal, Matthew Chantry, Zied Ben Bouallegue, Peter Dueben, Carla Bromberg, Jared Sisk, Luke Barrington, Aaron Bell, and Fei Sha. Weatherbench 2: A benchmark for the next generation of data-driven global weather models. _Journal of Advances in Modeling Earth Systems_ , 16(6):e2023MS004019, 2024. 

- Olivier Roy and Martin Vetterli. The effective rank: A measure of effective dimensionality. In _2007 15th European signal processing conference_ , pp. 606–610. IEEE, 2007. 

- James V Stone. Information theory: A tutorial introduction to the principles and applications of information theory. 2024. 

- Naoya Takeishi, Yoshinobu Kawahara, and Takehisa Yairi. Learning koopman invariant subspaces for dynamic mode decomposition. _Advances in neural information processing systems_ , 30, 2017. 

- Naftali Tishby and Noga Zaslavsky. Deep learning and the information bottleneck principle. In _2015 ieee information theory workshop (itw)_ , pp. 1–5. Ieee, 2015. 

- Naftali Tishby, Fernando C Pereira, and William Bialek. The information bottleneck method. _arXiv preprint physics/0004057_ , 2000. 

- Umesh Vaidya and Prashant G Mehta. Lyapunov measure for almost everywhere stability. _IEEE Transactions on Automatic Control_ , 53(1):307–323, 2008. 

- Darko Veberiˇc. Lambert w function for applications in physics. _Computer Physics Communications_ , 183(12):2622–2628, 2012. 

13 

Published as a conference paper at ICLR 2026 

Matias Vera, Pablo Piantanida, and Leonardo Rey Vega. The role of the information bottleneck in representation learning. In _2018 IEEE international symposium on information theory (ISIT)_ , pp. 1580–1584. IEEE, 2018. 

- Haoqing Wang, Xun Guo, Zhi-Hong Deng, and Yan Lu. Rethinking minimal sufficient representation in contrastive learning. In _Proceedings of the IEEE/CVF conference on computer vision and pattern recognition_ , pp. 16041–16050, 2022. 

- Yiyi Wang, Jian’an Zhang, Hongyi Duan, Haoyang Liu, and Qingyang Li. Rethinking selectivity in state space models: A minimal predictive sufficiency approach. _arXiv preprint arXiv:2508.03158_ , 2025. 

Matthias Weissenbacher, Samarth Sinha, Animesh Garg, and Kawahara Yoshinobu. Koopman q- learning: Offline reinforcement learning via symmetries of dynamics. In _International conference on machine learning_ , pp. 23645–23667. PMLR, 2022. 

- Matthew O Williams, Ioannis G Kevrekidis, and Clarence W Rowley. A data–driven approximation of the koopman operator: Extending dynamic mode decomposition. _Journal of Nonlinear Science_ , 25(6):1307–1346, 2015. 

- Edward Witten. A mini-introduction to information theory. _La Rivista del Nuovo Cimento_ , 43(4): 187–227, 2020. 

- Mike Wu, Chengxu Zhuang, Milan Mosse, Daniel Yamins, and Noah Goodman. On mutual information in contrastive learning for visual representations. _arXiv preprint arXiv:2005.13149_ , 2020. 

- Xingjian Wu, Xiangfei Qiu, Hongfan Gao, Jilin Hu, Bin Yang, and Chenjuan Guo. _k_ 2 vae: A koopman-kalman enhanced variational autoencoder for probabilistic time series forecasting. _arXiv preprint arXiv:2505.23017_ , 2025. 

Yuanchao Xu, Jing Liu, Zhongwei Shen, and Isao Ishikawa. Reinforced data-driven estimation for spectral properties of koopman semigroup in stochastic dynamical systems. _arXiv preprint arXiv:2509.04265_ , 2025a. 

- Yuanchao Xu, Kaidi Shao, Isao Ishikawa, Yuka Hashimoto, Nikos Logothetis, and Zhongwei Shen. A data-driven framework for koopman semigroup estimation in stochastic dynamical systems. _arXiv preprint arXiv:2501.13301_ , 2025b. 

- Yuanchao Xu, Kaidi Shao, Nikos Logothetis, and Zhongwei Shen. Reskoopnet: Learning koopman representations for complex dynamics with spectral residuals. _arXiv preprint arXiv:2501.00701_ , 2025c. 

- Yiming Yang, Xiaoyuan Cheng, Daniel Giles, Sibo Cheng, Yi He, Xiao Xue, Boli Chen, and Yukun Hu. Tensor-var: Efficient four-dimensional variational data assimilation. In _Forty-second International Conference on Machine Learning_ , 2025. 

- Raymond W Yeung. _Information theory and network coding_ . Springer Science & Business Media, 2008. 

Luo Yining, Chen Yingfa, and Zhang Zhen. Cfdbench: A large-scale benchmark for machine learning methods in fluid dynamics. _arXiv preprint arXiv:2310.05963_ , 2023. 

14 

Published as a conference paper at ICLR 2026 

## THE USE OF LARGE LANGUAGE MODELS (LLMS) 

During the preparation of this manuscript, the authors used ChatGPT to polish the writing (e.g., improving grammar, readability, and clarity). The content, technical contributions, and conclusions of the paper were developed entirely by the authors, who take full responsibility for all ideas and results presented. 

## A NOTATION 

Table 3: Notations in the Main Text 

|Notations|Meaning|
|---|---|
|_d_|latent dimension|
|det|determinant of matrix|
|_n_|state dimension|
|_p_|probability distribution|
|_pKR_|probability distribution of the Koopman-induced trajectory|
|_qKR_|variational approximation of the Koopman-induced trajectory|
|_t_|time step|
|tr|trace of matrix|
|_x_|state of dynamical systems|
|_z_|latent variable of dynamical systems|
|_C_|latent covariance matrix|
|_H_|Hilbert space|
|_I_|mutual information|
|I|identity matrix|
|_K_|Koopman operator|
|_D_KL|KL divergence|
|_L_2(_M, µ_)|Lebesgue space equipped with inner product|
|_Mn_|_n−_step linear forward covariance|
|_M_|fnite-dimensional manifold|
|_N_|Gaussian distribution|
|_S_|von Neumann entropy|
|_T_|discrete-time nonlinear map of dynamics|
|_Z_|latent space spanned by_{ϕ_1_, . . . , ϕd}_|
|_α, β, γ_|Lagrangian multipliers|
|_λ_|eigenvalues|
|_ρ_|density matrix|
|_ϕ_|observable/feature|
|_ψ, θ, ω_|parameters for neural networks in Koopman representation|



15 

Published as a conference paper at ICLR 2026 

## B A GENTLE INTRODUCTION TO APPENDIX 

The appendix is organized to complement the main paper with precise definitions, detailed theoretical analysis, and additional experimental material. Given the information density of the appendix, we provide here a short roadmap to guide the reader: 

- **Appendix C More Literature review.** We provide the classic to modern Koopman learning methods. 

- **Appendix D Limitations and Future Directions.** We state the limitations of framework and propose some future directions for Koopman representation. 

- **Appendix E. Technical definitions.** We collect the technical background, notations, and formal definitions used throughout the paper for ease of reference. 

- **Appendix F. Theoretical analysis.** This section develops our theory step by step, where each proposition answers a natural “next question” in the following chain: 

- **Q1.** _Will information be lost?_ (Proposition 1) 

- **Q2.** _If so, how much is lost?_ (Proposition 2) 

- **Q3.** _What kind of information is lost?_ (Proposition 3) 

- **Q4.** _How can we optimize information retention?_ (Proposition 4) 

- **Q5.** _How can we avoid negative side effects such as mode collapse?_ (Proposition 5) 

- In this way, the proofs form a coherent progression: each proposition is the answer to the next natural question raised by the previous one. 

- **Appendix G. Experimental setup and additional results.** We provide implementation details, dataset descriptions, and supplementary results to support and validate the propositions made in the main text. 

This structure ensures that readers can navigate the appendix according to their interests: consult Appendix A for notation, Appendix B for the full theoretical journey. 

16 

Published as a conference paper at ICLR 2026 

## C MORE LITERATURE REVIEW RELATED TO KOOPMAN REPRESENTATION 

The Koopman operator was originally introduced by Koopman and von Neumann as a linear embedding of Hamiltonian dynamical systems (Koopman, 1931; Koopman & Neumann, 1932). However, its infinite-dimensional nature makes it difficult to identify suitable handcrafted basis functions using conventional methods (Brunton et al., 2021). To address this, kernel techniques from functional analysis have been employed as bases for learning the Koopman operator (Das & Giannakis, 2020; Das et al., 2021; Kostic et al., 2022; Bevanda et al., 2025). Owing to the well-posed properties of kernel functions in reproducing kernel Hilbert spaces (e.g., linearity, existence, and convergence guarantees), the Koopman operator can be directly approximated via (extended) dynamic mode decomposition (DMD or EDMD) (Williams et al., 2015; Takeishi et al., 2017; Arbabi & Mezic, 2017; Xu et al., 2025a). Despite these theoretical advantages, fixed kernel functions are often too restrictive to capture a general function space (Berlinet & Thomas-Agnan, 2011; Alpay, 2012). 

In contrast, deep learning frameworks provide a more flexible alternative: leveraging the universal approximation property of neural networks (Baker & Patil, 1998; Kidger & Lyons, 2020), they allow learning a general Koopman representation without relying on predefined kernels. Following this principle, (variational) autoencoder (AE/VAE) architectures have been widely adopted to extract features spanning the Koopman subspace (Liu et al., 2023; Wu et al., 2025; Xu et al., 2025b;c). The resulting latent representations are flexible and support downstream tasks such as prediction and control (Li et al., 2020; Mauroy et al., 2020; Korda & Mezi´c, 2020; Weissenbacher et al., 2022). However, these representations are typically learned in a purely self-supervised manner, lacking explicit grounding in dynamical systems theory. To improve their reliability, recent studies incorporate domain-specific priors—such as symmetry, conservation laws, dissipation, or ergodicity—into the Koopman representation (Vaidya & Mehta, 2008; Weissenbacher et al., 2022; Azencot et al., 2020; Cheng et al., 2025). Within the VAE setting, recent studies (Federici et al., 2023) have started to link Markovian dynamics and information theory, demonstrating that time-lagged tricks can exploit mutual information to obtain better latent representations. While existing approaches are effective for specific dynamical systems, a formal theoretical foundation for guiding the learning of Koopman representations remains insufficient. In this work, we investigate how general information-theoretic principles can be employed to fill this gap. 

## D LIMITATIONS AND FUTURE DIRECTIONS 

A current limitation of our framework is that it does not address the sample complexity or nonasymptotic convergence of the Koopman representation; future work could explore more rigorous theoretical analyses in this direction. In addition, recent studies have highlighted connections between kernel methods (Kostic et al., 2022; 2023a; 2024) and information theory (Bach, 2022), suggesting an interesting avenue for extending conventional kernel techniques in Koopman theory through an information-theoretic perspective. 

17 

Published as a conference paper at ICLR 2026 

## E KEY TECHNICAL DEFINITIONS AND RELATED PROPERTIES 

**Definition E.1 (Density Matrix (Bach, 2022))** _A_ density matrix _ρ ∈_ R _[d][×][d] is a real symmetric matrix satisfying:_ 

- _ρ is positive semi-definite: ρ ⪰_ 0 

- _The trace of ρ is 1:_ tr( _ρ_ ) = 1 

_Such a matrix can be interpreted as a probability-weighted combination of orthonormal directions in_ R _[d] . It admits a spectral decomposition:_ 

**==> picture [296 x 30] intentionally omitted <==**

**Definition E.2 (Effective Dimension (Roy & Vetterli, 2007))** _Given a density matrix ρ on a Hilbert space, the_ effective dimension _is defined as_ 

**==> picture [96 x 13] intentionally omitted <==**

_where S_ ( _ρ_ ) = _−_ Tr( _ρ_ log _ρ_ ) _is the von Neumann entropy of ρ._ 

The _effective dimension_ measures how many directions in a representation space are substantially used. Given a symmetric, positive semi-definite matrix _ρ_ with unit trace, its von Neumann entropy 

**==> picture [90 x 11] intentionally omitted <==**

quantifies the spectral diversity of _ρ_ . The effective dimension is then defined as 

**==> picture [88 x 13] intentionally omitted <==**

so that _d_ eff ( _ρ_ ) can be interpreted as the number of dimensions effectively occupied by the latent variable. In particular, _d_ eff ( _ρ_ ) = 1 when _ρ_ is concentrated on a single direction (pure state in quantum mechanics), while _d_ eff ( _ρ_ ) = _d_ when _ρ_ is maximally mixed and spreads uniformly over all _d_ directions. A higher effective feature dimension is often required to ensure predictive sufficiency. 

**==> picture [208 x 119] intentionally omitted <==**

**----- Start of picture text -----**<br>
H ( z ) H ( x )<br>H ( z|x ) I ( z ;  x ) H ( x|z )<br>**----- End of picture text -----**<br>


Figure 7: A Venn diagram illustrating entropy, conditional entropy, and mutual information between the true state _x_ and latent variable _z_ . _H_ ( _x_ ) and _H_ ( _z_ ) denote the Shannon entropy (total information) of _x_ and _z_ , respectively. Their symmetric overlap, _I_ ( _z_ ; _x_ ), represents the mutual information that quantifies how much information about the true dynamics is preserved in the Koopman representation. The non-overlapping regions, _H_ ( _x|z_ ) and _H_ ( _z|x_ ), correspond to the residual uncertainty not captured by _I_ ( _z_ ; _x_ ). 

**Definition E.3 (Entropy, Mutual Information and Conditional Mutual Information)** _Let x, y, z be random variables. Beyond the Definition 2.2 in the main text, we give a standard definition of (conditional) mutual information based on Shannon entropy (shown in Figure 7, (Csisz´ar et al., 2004))._ 

- _**D1 Entropy** of a random variable x is defined as_ 

**==> picture [126 x 23] intentionally omitted <==**

18 

Published as a conference paper at ICLR 2026 

## • _**D2 Mutual Information** is defined as_ 

_I_ ( _z_ ; _x_ ) := _H_ ( _z_ ) + _H_ ( _x_ ) _− H_ ( _z, x_ ) _,_ 

_equivalently,_ 

**==> picture [188 x 11] intentionally omitted <==**

_It can also be expressed in terms of the Kullback–Leibler (KL) divergence:_ 

**==> picture [146 x 14] intentionally omitted <==**

_where_ 

**==> picture [166 x 25] intentionally omitted <==**

- _**D3. Conditional Mutual Information** is defined as_ 

_I_ ( _x_ ; _y | z_ ) := _H_ ( _x | z_ ) + _H_ ( _y | z_ ) _− H_ ( _x, y | z_ ) _,_ 

_equivalently,_ 

**==> picture [152 x 11] intentionally omitted <==**

_In terms of KL divergence,_ 

**==> picture [219 x 41] intentionally omitted <==**

19 

Published as a conference paper at ICLR 2026 

## F THEORETICAL FRAMEWORK 

To ground our theoretical analysis, we first formalize the autoregressive structure of Koopman representations illustrated in Figure 8. The original dynamics evolve as a nonlinear transformation 

**==> picture [122 x 8] intentionally omitted <==**

In parallel, states are _encoded_ into latent variables _zt−n_ , which propagate linearly under the Koopman operator _K_ and are subsequently _decoded_ back to approximate the original states. This twolayer structure makes clear where information may dissipate: (i) during encoding from _x_ to _z_ , (ii) along the linear latent evolution governed by _K_ , and (iii) during reconstruction from _z_ to _x_ . Analyzing this flow of information is therefore essential for understanding the fundamental limits of Koopman representations, and the proofs of the following propositions will be developed around this structure. 

**==> picture [320 x 77] intentionally omitted <==**

**----- Start of picture text -----**<br>
T T T<br>xt−n xt−n +1 · · · xt<br>encoding decoding decoding<br>K K K<br>zt−n zt−n +1 · · · zt<br>**----- End of picture text -----**<br>


Figure 8: The autoregressive structure of Koopman representation. **Top row (solid arrows):** the original states _xt−n_ evolve under the nonlinear map _T_ . **Bottom row (dashed arrows):** the states are first _encoded_ into latent variables _zt−n_ , which then evolve linearly under the Koopman operator _K_ . The latent variables are subsequently _decoded_ back to approximate the original states. Thus, the latent evolution under Koopman representation captures essential structure but do not directly contain the full state information. Note: the dashed arrows represent the approximated Koopman representation in latent space, whereas the solid arrows denote the true underlying dynamics. 

**Fact F.1** _As shown in Figure 8, we set that the latent variable zt is obtained via a probabilistic encoder that depends only on the current true state xt, i.e., p_ ( _zt | xt_ ) _. Consequently, the information content of zt cannot exceed that of xt, so H_ ( _zt_ ) _≤ H_ ( _xt_ ) _(due to the data processing inequality (Stone, 2024)). Moreover, under this setting, zt is conditionally independent of any other variable in the dynamical system given xt, i.e.,_ 

_I_ ( _zt_ ; □ _| xt_ ) = 0 _, or equivalently_ □ _⊥⊥ zt | xt,_ 

_where_ □ _denotes any variable in the dynamical system._ 

## F.1 PROOF OF PROPOSITION 1 

Beyond establishing Proposition F.1, it is crucial to highlight the phenomenon of _information dissipation_ in the autoregressive Koopman representation (see Figure 8) and to clarify how the Koopman operator _K_ connects to the _information limit_ . By a fundamental principle of information theory, a compressed representation can never increase the available information. While this observation yields a one-step inequality 3, our analysis extends it to the multi-step analysis, where the cumulative effect of encoding, autoregressive latent evolution via _K_ , and decoding can be rigorously tracked. This extension makes explicit how information gradually dissipates at each stage of the Koopman representation, ultimately leading to the error accumulation. 

**Lemma F.2 (Chain Rule of Information)** _For variables x, y, z, the mutual information with their joint variable satisfies_ 

_I_ ( _x_ ; _y_ ) = _I_ ( _x_ ; ( _y, z_ )) _− I_ ( _x_ ; _z | y_ ) _,_ 

_where_ ( _y, z_ ) _is treated as the joint random variable with distribution p_ ( _y, z_ ) _. According to the non-negativity of conditional mutual information, it is obvious that_ 

_I_ ( _x_ ; ( _y, z_ )) _≥ I_ ( _x_ ; _y_ ) _._ 

20 

Published as a conference paper at ICLR 2026 

**Proof 1** _We prove this proposition as two steps._ 

_**Step 1.** According to the autoregressive structure of the Koopman representation, the first inequality 3 follows directly from the data processing inequality (Stone, 2024). Since the latent variable zt−_ 1 _is a compressed representation of xt−_ 1 _, the mutual information between successive states cannot exceed that induced by the original dynamics T . Formally,_ 

**==> picture [249 x 11] intentionally omitted <==**

_This can be derived based on the Fact F.1, it can be factorized as_ 

_I_ ( _xt−_ 1; _xt_ ) = _I_ (( _xt−_ 1 _, zt−_ 1); _xt_ ) _− I_ ( _zt−_ 1; _xt|xt−_ 1) _(Lemma F.2)_ = _I_ (( _xt−_ 1 _, zt−_ 1); _xt_ ) _−_ ((( _I_ ( _zt−_ 1;[((((] _xt|xt−_ 1) _(Fact F.1)_ = _I_ ( _zt−_ 1; _xt_ ) + _I_ ( _xt−_ 1; _xt|zt−_ 1) _(Lemma F.2) ≥ I_ ( _zt−_ 1; _xt_ ) _. (non-negativity of mutual information)_ (11) 

_Thus, the first inequality is derived._ _**Step 2.** In terms of seconding inequality, we derive it as follow_ 

_I_ ( _zt−_ 1; _xt_ ) = _I_ ( _zt−_ 1; ( _xt, zt_ )) _− I_ ( _zt−_ 1; _zt|xt_ ) _(Lemma F.2)_ = _I_ ( _zt−_ 1; ( _xt, zt_ )) _−_ (( _I_ ( _zt−_[((((] 1; _zt|xt_ ) _(Fact F.1)_ = _I_ ( _zt−_ 1; _zt_ ) + _I_ ( _zt−_ 1; _xt|zt_ ) _(Lemma F.2) ≥ I_ ( _zt−_ 1; _zt_ ) _. (non-negativity of mutual information)_ (12) _Here, the proof for the proposition ends._ 

Beyond the proposition, we would like to disentangle the what information is lost during the Koopman representation. Combining equations 11 and 12, we obtain 

**==> picture [325 x 25] intentionally omitted <==**

then, 

**==> picture [334 x 26] intentionally omitted <==**

Furthermore, we extend from one-step mutual information to multi-step ones (with _n ≥_ 1), such that 

**==> picture [394 x 63] intentionally omitted <==**

Also, _I_ ( _xt−n_ ; _xt|zt−n_ ) can be disentangled as follows: 

**Step 1 — Introduce** _zt−n_ +1 Apply Lemma F.2: 

**==> picture [306 x 11] intentionally omitted <==**

Here, the graphical structure ensures that: 

**==> picture [130 x 11] intentionally omitted <==**

so there is no correction term. 

**Step 2 — Introduce** _zt−n_ +2 **.** Expand the second term via Lemma F.2: 

**==> picture [266 x 25] intentionally omitted <==**

21 

Published as a conference paper at ICLR 2026 

Again, the graphical structure implies: 

**==> picture [164 x 11] intentionally omitted <==**

**Step 3 — Repeat recursively.** For each _i_ = _t − n_ + 1 _, t − n_ + 2 _, . . . , t_ : 

**==> picture [288 x 11] intentionally omitted <==**

where 

**==> picture [136 x 11] intentionally omitted <==**

Equivalently, in compact notation: 

**==> picture [343 x 30] intentionally omitted <==**

Thus, by combining equations 15 and 16, the multi-step lost information becomes 

**==> picture [341 x 46] intentionally omitted <==**

Here, we interpret the physical meaning of the three parts in Koopman representation. Each term _I_ ( _xt−n_ ; _zi|zt−n_ : _i−_ 1) measures how much new information about past state _xt−n_ revealed by the latent variable the latent variable _zi_ , given all previous latent states. Physically, this corresponds to the fast-dissipating modes that decay quickly; as more latent steps are added, this residual information diminishes rapidly to zero. 

The second term _I_ ( _xt−n_ ; _xt|zt−n_ : _t_ ) measures the residual dependency between the past and the current state that cannot be fully represented the latent sequence _{zt−n_ : _t}_ due to the compressed representation. 

The quantity _I_ ( _zt−n_ ; _xt|zt_ ) measures the information about the state _xt_ that remains in the past latent variable _zt−n_ but is not preserved in the current latent _zt_ . A positive value therefore indicates information loss during latent evolution. This phenomenon arises from Koopman modes with eigenvalues _|λ| <_ 1, whose contributions decay over time and thus dissipate predictive information in the Koopman representation. 

22 

Published as a conference paper at ICLR 2026 

## F.2 DERIVATION OF VARIATIONAL DISTRIBUTION 

The derivation of discrepancy between true and Koopman-induced trajectories is listed as follow: 

**==> picture [388 x 263] intentionally omitted <==**

Here, _q[KR]_ denotes the variational approximation. For notational convenience, we denote the last three terms in equation 18 by _E_ enc, _E_ tra, and _E_ rec, respectively. Also, the logic from third line to fourth line holds since the inequality follows from the fact that marginalization cannot increase KL divergence. 

## F.3 PROOF OF PROPOSITION 2 

Before proving Proposition 2, we first introduce a technical lemma. 

**Lemma F.3 (Pinsker’s Inequality (Yeung, 2008))** _For any two probability distributions p and q over the same space X, the total variation distance_ 

**==> picture [140 x 17] intentionally omitted <==**

_is equal to one half of their L_[1] _distance:_ 

**==> picture [148 x 23] intentionally omitted <==**

_Moreover, it is bounded by the Kullback–Leibler divergence:_ 

**==> picture [234 x 23] intentionally omitted <==**

**Proof 2** _The proof proceeds in four steps: (1) establish the connection between KL divergence and total variation distance, (2) relate KL divergence to latent mutual information, (3) derive the upper error bound via information-theoretic limits, and (4) show that the lower bound decays exponentially with increasing latent mutual information._ 

23 

Published as a conference paper at ICLR 2026 

_**Step 1.** By applying Pinsker’s inequality (Lemma F.3) and equation 18, we can directly bound the distributional discrepancy as_ 

**==> picture [382 x 34] intentionally omitted <==**

_**Step 2.** The connection between mutual information and KL divergence is given as follows:_ 

**==> picture [313 x 159] intentionally omitted <==**

_By recursively using the result in equation 20, we can summation the results as_ 

**==> picture [303 x 96] intentionally omitted <==**

_Here, p_ ( _xn|xn−_ 1) _and p_ ( _zn|zn−_ 1) _are governed by the original nonlinear dynamics T and Koopman operator N_ ( _zt|Kzt−_ 1 _,_ Σ) _, respectively. Based on this fact, we can further to develop equation 21 as_ 

**==> picture [301 x 100] intentionally omitted <==**

_Plugging equation 22 into equation 19 in Step 1, we have_ 

**==> picture [314 x 94] intentionally omitted <==**

24 

Published as a conference paper at ICLR 2026 

_**Step 3.** Based on the distributional discrepancy in equation 23, we have the following inequality_ 

��E _qKR_ [ _x_ 1: _t | x_ 0] _−_ E _p_ [ _x_ 1: _t | x_ 0]��2 = _x_ 1: _t dq[KR]_ ( _x_ 1: _t | x_ 0) _− x_ 1: _t dp_ ( _x_ 1: _t | x_ 0) _(Lebesgue measure)_ ��� � � ���2 _KR ≤_ �� _x_ 1: _t_ �� _∞_ �� _q_ ( _x_ 1: _t | x_ 0) _− p_ ( _x_ 1: _t | x_ 0)�� _dx_ 1: _t (triangle inequality)_ � � �� � _L_[1] _distance ≤_ 2 _C_[¯] �� _p_ ( _x_ 1: _t | x_ 0) _− qKR_ ( _x_ 1: _t | x_ 0)�� _T V (Lemma F.3) ≤C_[¯] �2 _D_ KL( _p_ ( _x_ 1: _t | x_ 0) _∥ q[KR]_ ( _x_ 1: _t | x_ 0)) _(Pinsker’s inequality)_ ~~�~~ � _t_ � _≤C_[¯] 2 � � _I_ ( _xn−_ 1; _xn_ ) _− I_ ( _zn−_ 1; _zn_ )� + _Eenc_ + _Etra_ + _Erec, (via equation 19)._ � _n_ =1 

_where the state x lies in a compact space M with a complete metric, ensuring ∥x_ 1: _t∥∞ ≤ C_[¯] _< ∞. The proof ends._ 

_**Step 4.** The classical rate-distortion theorem (Cover, 1999) states that x_ 1: _t ∈_ R _[n][×][t] , under L_[2] _error distortion via the ideal Koopman model p[KR] , the minimal achievable distortion D is bounded by_ 

**==> picture [304 x 30] intentionally omitted <==**

_Since the entropy H_ ( _x_ 1: _t_ ) _can be totally measured by the mutual information_ � _tn_ =1 _[I]_[(] _[x][n][−]_[1][;] _[ x][n]_[)] _[of][original][dynamics][T][.] Then the accumulative mean-squared error after t steps given x_ 0 _is bounded below as_ 

**==> picture [372 x 29] intentionally omitted <==**

_where the constant C_ = 2 _ntπe_[exp(] _nt_[2] � _tn_ =1 _[I]_[(] _[x][n][−]_[1][;] _[ x][n]_[))] _[absorbs][the][marginal][entropy][of][the] trajectory._ 

**Remark F.4** _A special case of Proposition 2 is ergodic system, conditioning on x_ 0 _and then taking the long-time average_ 

**==> picture [358 x 30] intentionally omitted <==**

_which follows from Proposition 2. The left-hand side is the_ relative entropy rate _, and the inequality shows that the dynamic discrepancy between p and q[KR] can be controlled by the per-step information difference._ 

## F.4 PROOF OF PROPOSITION 3 

Beyond establishing Proposition 3, it is even more important to clarify the connection between spectral theory and the information components of the Koopman representation. Before proceeding to the detailed proof, we first derive the closed-form expression of latent mutual information under the Koopman representation. This will allow us to interpret the spectral properties of the Koopman operator from an information-theoretic perspective. 

For one-step forward under Koopman representation, we have 

**==> picture [160 x 11] intentionally omitted <==**

For multi-step forward, it can be recursively derived as 

**==> picture [126 x 11] intentionally omitted <==**

25 

Published as a conference paper at ICLR 2026 

**==> picture [389 x 119] intentionally omitted <==**

Figure 9: Spectral behavior of the Koopman operator under different regimes. **Left:** Eigenvalues of _K_ (orange dots) lie on the complex unit circle ( _|λ|_ = 1), and those of _K[n]_ with _n_ = 7 (blue crosses) remain on the unit circle, indicating temporal coherence and preservation of information. **Right:** Eigenvalues of _K_ lie strictly inside the complex unit circle ( _|λ| <_ 1), and the spectrum of _K[n]_ contracts toward the origin as _n_ increases, reflecting fast mixing and information dissipation. 

then, 

**==> picture [114 x 30] intentionally omitted <==**

Here, _ϵt−i ∼N_ (0 _,_ Σ) is a time-independent Gaussian distribution for all _i_ . Therefore, _zt_ follows the distribution as _N_ ( _K[n] zt−n,_[�] _[n] i_ =0 _[−]_[1] _[K][i]_[Σ(] _[K][i]_[)] _[⊤]_[)][.][For][convenience,][we][denote][the][covariance][matrix] as 

**==> picture [312 x 30] intentionally omitted <==**

Without loss of generality, we can set _zt−n ∼N_ (0 _, C_ ) and the covariance matrix is denoted as _C_ := _Cov_ ( _zt−n_ ). Given the latent variable _zt−n_ , the conditional entropy _H_ ( _zt|zt−n_ ) is calculated as 

**==> picture [275 x 21] intentionally omitted <==**

On the other hand, the entropy _H_ ( _zt_ ) is calculated as 

**==> picture [298 x 22] intentionally omitted <==**

**Proof 3** _The proof of this proposition proceeds in three steps: (1) we first interpret latent mutual information in relation to the spectral properties of the Koopman representation; (2) we disentangle the mutual information I_ ( _zt_ ; _xt_ ) _to clarify the role of each component and its associated spectral behavior; and (3) we derive the closed-form expression of mutual information under the Koopman representation, which highlights how the Koopman operator governs the information flow._ 

_**Step 1. Spectral Properties in Latent Mutual Information.** Based on the Definition E.3, mutual information I_ ( _zt−n, zt_ ) _is calculated via equations 26, 27 and 28 as_ 

**==> picture [356 x 89] intentionally omitted <==**

_We now examine how the behavior of the Koopman representation depends on its spectral properties, by analyzing the cases where the eigenvalues of K satisfy |λ| >_ 1 _, |λ| ≈_ 1 _, and |λ| <_ 1 _._ 

26 

Published as a conference paper at ICLR 2026 

- _|λ| >_ 1 _: The Koopman representation is explosive: ∥K[n] ∥ grows exponentially, so the term K[n] C_ ( _K[n]_ ) _[⊤] dominates. As a result, the mutual information I_ ( _zt−n_ ; _zt_ ) _diverges with n, reflecting amplification of initial uncertainty._ 

- _|λ| ≈_ 1 _: The Koopman representation is temporally coherent: K[n] C_ ( _K[n]_ ) _[⊤] remains bounded, and when noise is small the mutual information is approximately conserved at a constant level. This corresponds to the temporal-coherent information component._ 

- _|λ| <_ 1 _: The Koopman represent is fast mixing: K[n] →_ 0 _as n →∞, so the additional term vanishes relative to Mn. Thus the mutual information I_ ( _zt−n_ ; _zt_ ) _→_ 0 _, indicating that information from the remote past information is asymptotically lost due to contraction and noise accumulation._ 

_An illustration is given in Figure 9, where the left panel shows the |λ|_ = 1 _case with eigenvalues lying on the unit circle, and the right panel shows the |λ| <_ 1 _case with eigenvalues contracting toward the origin as n increases._ 

_**Step 2. Disentanglement of mutual information** I_ ( _zt_ ; _xt_ ) _**.**_ 

_According to the chain rule of mutual information, we have_ 

**==> picture [248 x 11] intentionally omitted <==**

_where H_ ( _x | z_ ) _measures the irreducible uncertainty of x given the latent variable (i.e., the information lost in the latent space), and I_ ( _z_ ; _x_ ) _quantifies the total amount of information about x preserved in the latent representation._ 

_In this sense, I_ ( _z_ ; _x_ ) _can be regarded as the_ maximum information that the decoder can retain _about the data through the latent variables. To better understand the role of structural consistency, we next_ decompose _I_ ( _z_ ; _x_ ) _into components, in order to examine how much of this retained information is attributable to the latent forward via Koopman representation._ 

_I_ ( _zt_ ; _xt_ ) = _I_ ( _zt,_ ( _zt−n, xt_ )) _−_ ((( _I_ ( _zt−n_ ;[(((] _zt|xt_ ) _(Fact F.1)_ = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; _xt|zt−n_ ) = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; ( _xt−_ 1 _, xt_ ) _|zt−n_ ) _−_ (((( _I_ ( _zt_ ; _xt−_ 1[(((((] _|zt−n, xt_ ) _(Fact F.1)_ = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) + _I_ ( _zt_ ; _xt|zt−n, xt−_ 1) (31) = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) + _I_ ( _zt_ ; ( _zt−n, xt_ ) _|xt−_ 1) _−_ (((( _I_ ( _zt−n_ ; _zt_[(((((] _|xt−_ 1 _, xt_ ) = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) + _I_ ( _zt_ ; _xt|xt−_ 1) _−_ (((( _I_ ( _zt_ ; _zt−n_[(((((] _|xt−_ 1 _, xt_ ) = _I_ ( _zt−n_ ; _zt_ ) + _I_ ( _zt_ ; _xt−_ 1 _|zt−n_ ) + _I_ ( _zt_ ; _xt|xt−_ 1) _._ 

_**Step 3.** According to Step 1, the latent mutual information has been thoroughly explained; we now turn to the second and third terms in equation 31._ 

_For linear conditional Gaussian (Lubbe, 1997), the mutual information for_ 

**==> picture [261 x 26] intentionally omitted <==**

_where_ Σ _a|c and_ Σ _b|c denote the conditional covariance matrices of a and b given c, respectively, and_ Σ _a,b|c denotes the joint conditional covariance matrix of_ ( _a, b_ ) _given c, i.e.,_ 

**==> picture [106 x 25] intentionally omitted <==**

_with_ Σ _ab|c and_ Σ _ba|c being the conditional cross-covariances._ 

27 

Published as a conference paper at ICLR 2026 

_The closed-form expression for the mutual information I_ ( _zt_ ; _xt−_ 1 _| zt−n_ ) _is derived as follows. Conditioned on zt−n, we have the linear–Gaussian relations_ 

**==> picture [268 x 30] intentionally omitted <==**

_where Mk_ =[�] _[k] i_ =0 _[−]_[1] _[K][ i]_[ Σ (] _[K][ i]_[)] _[⊤][.][Assume][ x][t][−]_[1][=] _[D][z][t][−]_[1][+] _[ ϵ][t][−]_[1] _[with][ ϵ][t][−]_[1] _[∼N]_[(0] _[, R]_[)] _[,][inde-] pendent of the process noise. Then_ 

**==> picture [294 x 25] intentionally omitted <==**

_Plugging equation 33–equation 34 into the Gaussian closed-form identity yields_ 

**==> picture [329 x 39] intentionally omitted <==**

_To analyze how I_ ( _zt_ ; _xt−_ 1 _| zt−n_ ) _scales with n, it suffices to study the growth of Mn_ = � _ni_ =0 _−_ 1 _[K][ i]_[Σ(] _[K][ i]_[)] _[⊤][.][If][the][spectral][radius][ρ]_[(] _[K]_[)] _[<]_[1] _[,][then][M][n][converges][to][the][unique][solu-] tion M∞ of the discrete Lyapunov equation M∞_ = Σ + _KM∞K[⊤] ., hence I_ ( _zt_ ; _xt−_ 1 _| zt−n_ ) _remains bounded (“compressible”). Conversely, if ρ_ ( _K_ ) _>_ 1 _, then Mn diverges and the information grows unbounded along the unstable directions. When ρ_ ( _K_ ) _≈_ 1 _, the growth is slow and reflects long-term temporal coherence (then it contradicts with equation 29, and can be captured by the latent mutual information). Therefore, this compressible information corresponds to the spectral radius ρ_ ( _K_ ) _<_ 1 _._ 

_As for the residual term I_ ( _zt_ ; _xt | xt−_ 1) _, it can be expanded as_ 

**==> picture [303 x 29] intentionally omitted <==**

_where the second equality follows from the observation model xt_ = _Dzt_ + _ϵt with ϵt ∼N_ (0 _, R_ ) _, which implies H_ ( _xt | zt, xt−_ 1) =[1] 2[log det((2] _[πe]_[)] _[d][R]_[)] _[.][Therefore,][this][residual][mutual][infor-] mation depends only on the noise covariance R and original dynamics T , but it has no spectral counterpart in the Koopman operator._ _**Summary.** The mutual information I_ ( _zt_ ; _xt_ ) _naturally decomposes into three parts: (i) temporal-coherent information I_ ( _zt−n_ ; _zt_ ) _, which captures temporal coherence when eigenvalues of Koopman operator λ ≈_ 1 _; (ii) fast-dissipating information I_ ( _zt_ ; _xt−_ 1 _| zt−n_ ) _, which remains bounded only in the stable regime ρ_ ( _K_ ) _<_ 1 _; and (iii) residual information I_ ( _zt_ ; _xt|xt−_ 1) _, which reflects observation noise and has no spectral counterpart. These three components and their spectral interpretations are summarized in Table 4._ 

Table 4: Spectral interpretation of information components in Koopman representation 

|**Information**|**Spectral property**|**Temporal**|**behavior**|**behavior**|**Information mean-**|
|---|---|---|---|---|---|
||||||**ing**|
|Temporal-coherent|_λ ≈_1|Long-lived,||persis-|Predictable, low en-|
|||tent|||tropy|
|Fast-dissipating|_λ <_1|Rapidly|decaying,||Transient,<br>com-|
|||short-lived|||pressible under IB|
|Residual / Confounding|– (no spectral coun-|Unpredictable,|||Noise,<br>anomalies,|
||terpart)|injected at||present|non-predictive left-|
|||step|||overs|



28 

Published as a conference paper at ICLR 2026 

## F.5 PROOF OF PROPOSITION 4 

To establish this proposition, we analyze the problem from a Lagrangian perspective. Specifically, we investigate how the Koopman representation behaves when the latent mutual information _I_ ( _zt−n_ ; _zt_ ) is maximized under a finite variance constraint. This perspective reveals a water-filling allocation principle that governs how variance is distributed across spectral modes, thereby clarifying the connection between latent mutual information and the latent variable _z_ . 

**Proof 4** _Consider latent variable under Koopman representation showing equation 26_ 

**==> picture [308 x 13] intentionally omitted <==**

_where denotes the covariance matrix of zt−n. The matrix C characterizes the spectral distribution of the latent variable, and our goal is to investigate how maximizing latent mutual information influences Koopman representation._ 

_According to the previous proof in equation 29, we have_ 

**==> picture [224 x 21] intentionally omitted <==**

_−_[1] _Denote the singular value decomposition Mn_ 2 ( _K_ ) _[n]_ = _U diag_ ( _[√] gi_ ) _V[⊤] with gi ≥_ 0 _. Then_ 

**==> picture [320 x 21] intentionally omitted <==**

_As_ tr( _C_ ) _measures the total second moment, we impose_ tr( _C_ ) _≤ C for some finite constant C. This assumption ensures that the Koopman representation has a bounded total variance, preventing degenerate solutions where the variance grows without bound._ 

_Under the constraint_ tr( _C_ ) _≤ C, maximizing the latent mutual information under Koopman representation becomes an optimization problem as_ 

**==> picture [304 x 36] intentionally omitted <==**

_In equation 38, the matrices U and V are orthogonal, and C is a symmetric positive semidefinite matrix with eigenvalues {p_ 1 _, . . . , pd} with pi ≥_ 0 _for all i. We interpret these eigenvalues as spectral weights of the Koopman observables/features, indicating how variance is allocated across the observable/feature directions {ϕ_ 1 _, . . . , ϕd} defined in equation 1. Then, optimization problem in equation 39 becomes a water-filling problem as_ 

**==> picture [259 x 31] intentionally omitted <==**

_The Lagrangian formulation becomes_ 

**==> picture [299 x 30] intentionally omitted <==**

_According to Karush–Kuhn–Tucker (KKT) condition (Boyd & Vandenberghe, 2004), we obtain_ 

**==> picture [322 x 24] intentionally omitted <==**

**==> picture [380 x 36] intentionally omitted <==**

29 

Published as a conference paper at ICLR 2026 

_where µ is the Lagrange multiplier determined by the variance budget constraint. This solution characterizes the spectral weights of the Koopman representation along each observable/feature direction, and reveals two key phenomena:_ 

- _**Concentration on temporally coherent modes.** Since gi depends on the Koopman eigenvalues through K[n] , larger pi in equation 43 are assigned to eigen-directions with |λ| ≈_ 1 _, corresponding to temporal-coherent modes._ 

- _**Mode collapse.** Because_[�] _[d] i_ =1 _[p][i][≤][C][,][variance is preferentially allocated to direc-] tions with larger gain gi, while less informative directions receive zero weight. This leads to a low-rank allocation (low effective dimension) where only a subset of modes are retained._ 

_In summary, this proof demonstrates that maximizing latent mutual information is equivalent to a water-filling allocation of spectral weights, which naturally explains why emphasizing this objective can lead to mode collapse in the Koopman representation._ 

## F.6 PROOF OF PROPOSITION 5 

Connecting to Proposition 4, we continue to prove Proposition 5 via Lagrangian formulation. Without entropy regularization, the solution degenerates to low-rank (mode collapse); with entropy regularization, the solution assigns non-zero weights to all directions, improving effective dimension. 

**==> picture [358 x 53] intentionally omitted <==**

_with pi is the eigenvalue of C. Under a given regularization coefficient γ, this normalization allows us to improve the effecitve dimension. Based on equation 41, the modified Lagrangian formulation under the regularized Von Neumann entropy becomes_ 

**==> picture [380 x 95] intentionally omitted <==**

**==> picture [169 x 21] intentionally omitted <==**

_Since a closed-form solution is not directly available, we proceed with further algebraic transformation. By reorganization,_ log _pi_[tr][(] _[C]_[)] _gi −_ 1 _._ tr( _C_ )[=] _γ_ � 2(1 + _gipi_ ) _[−][µ]_ � _Exponential both sides:_ tr( _piC_ )[= exp] � tr( _γC_ ) � 2(1 + _g gi ipi_ ) _[−][µ]_ � _−_ 1� 

_Exponential both sides:_ 

30 

Published as a conference paper at ICLR 2026 

_Then,_ 

**==> picture [319 x 84] intentionally omitted <==**

_We can transform the above form as,_ 

_Here C_ 1 = tr( _C_ ) exp _−_ 1 _−_[tr][(] _γ[C]_[)] _[µ] is a positive constant Introducing y_ = 1 + _gipi, we can_ � � _write equation 46 via algebraic transform:_ 

**==> picture [262 x 25] intentionally omitted <==**

_The above equation is related to the form x_ exp( _x_ ) + _rx_ = _constant, we can solve it via the generalized Lambert W function (also known as r-Lambert W[a] , see (Veberiˇc, 2012))_ 

**==> picture [240 x 38] intentionally omitted <==**

_Here, W_ 1 _/_ ( _giC_ 1)( _·_ ) _is the r-Lambert W function. Since pi_ = _[y] g[−] i_[1] _[, the closed form of][ p][i][ becomes]_ 

**==> picture [262 x 38] intentionally omitted <==**

_Then, the solution of equation 44 under the regularized von Neumann entropy assigns non-zero spectral weight to all observable/feature directions {ϕ_ 1 _, . . . , ϕd}, since pi >_ 0 _holds according to equation 46. Consequently, the effective dimension is provably improved._ 

> _aWr_ denotes the generalized Lambert W function, defined as the solution of _x_ exp( _x_ ) + _rx_ = _constant_ . 

31 

Published as a conference paper at ICLR 2026 

G PRACTICAL DETAILS, IMPLEMENTATION AND EXPERIMENTAL DETAILS 

G.1 IMPLEMENTATION DETAILS FOR VAE 

**Algorithm 1** Information-Theoretic Koopman Representation (VAE, probabilistic) 

**Require:** Dataset _D_ = _{xn}[T] n_ =0[; network parameters][ (] _[α, β, γ]_[)][; learning rate] _[ η]_[; number of epochs] _K_ ; batch size _B_ ; neighbor window _k_ ; temperature _τ_ . 1: Initialize encoder _pθ_ ( _z|x_ ), decoder _pω_ ( _x|z_ ), and latent dynamics network _qψ_ ( _zn|zn−_ 1). 2: **for** epoch = 1 to _K_ **do** 3: **for** each minibatch _{x_ 1 _, . . . , xB}_ from _D_ **do** 4: Sample latents _zi ∼ pθ_ ( _z|xi_ ). 5: **Temporal coherence (InfoNCE)** : For each _zn_ , treat its _temporal_ neighbors _Pn_ = _{zn±i |_ 1 _≤ i ≤ k}_ as positive samples, compute 

**==> picture [197 x 30] intentionally omitted <==**

- 6: **Structural consistency** : compute latent likelihood 

**==> picture [115 x 12] intentionally omitted <==**

7: **Predictive sufficiency** : compute covariance _C_ = _B_ 1 � _i_[(] _[z][i][−][z]_[¯][)(] _[z][i][−][z]_[¯][)] _[⊤]_[,][where] _[z]_[¯][=] 1 _B_ � _i[z][i]_[; normalize] _[ P]_[=] _[ C][/]_[tr(] _[C]_[)][, then compute] _S_ ( _P_ ) = _−_ � _λj_ log _λj,_ where _λj_ denotes _j_ th eigenvalue of _P. j_ 

8: **Standard Evidence Lower Bound (ELBO) term (for training stability and reconstruction)** : 

**==> picture [263 x 11] intentionally omitted <==**

9: **Total Loss** : 

**==> picture [266 x 41] intentionally omitted <==**

10: Update _θ, ω, ψ_ using Adam step _η_ 11: **end for** 12: **end for** 

**Connection to Structural Consistency.** By Definition E.3, when given _zn−_ 1 the conditional mutual information is 

**==> picture [222 x 11] intentionally omitted <==**

Since the encoder is independent of _zn−_ 1 in our setting (according to Figure 8), this simplifies to 

_I_ ( _zn_ ; _xn | zn−_ 1) = _H_ ( _zn | zn−_ 1) _− H_ ( _zn | xn_ ) _._ (50) 

Consider the encoder distribution 

**==> picture [50 x 11] intentionally omitted <==**

which maps observations to latent variables, and the Koopman prior 

**==> picture [160 x 13] intentionally omitted <==**

which models latent evolution as a linear Gaussian transition governed by the Koopman operator _Kψ_ . 

32 

Published as a conference paper at ICLR 2026 

Then the conditional mutual information can be equivalently written as the following form according to Definition E.3 or equation 50: 

**==> picture [305 x 26] intentionally omitted <==**

Expanding the term in equation 51, we 

**==> picture [278 x 12] intentionally omitted <==**

has two effects: 

1. **Alignment with Koopman dynamics.** The expectation term E _pθ_ ( _zn|xn_ )[ _−_ log _qψ_ ( _zn|zn−_ 1)] requires samples drawn from the encoder to lie in regions of high likelihood under the Koopman prior. Since the prior is parameterized as a linear Gaussian transition, minimizing the KL forces the encoder outputs to be predictable under a linear structure. 

2. **Entropy regularization.** The entropy term _Hpθ_ ( _zn|xn_ ) encourages that the encoder not to be deterministic. 

Together, these effects ensure that the latent variables produced by the encoder not only encode information about the current state but also evolve consistently with the linear Gaussian dynamics imposed by the Koopman operator. Formally, 

_pθ_ ( _zn | xn_ ) _≈ qψ_ ( _zn | zn−_ 1) = _⇒ zn_ evolves approximately linearly under _Kψ,_ 

which enforces _structural consistency_ in the latent space. 

33 

Published as a conference paper at ICLR 2026 

## G.2 IMPLEMENTATION DETAILS FOR AE 

**Algorithm 2** Information-Theoretic Koopman Representation (AE, deterministic) 

**Require:** Dataset _D_ = _{xn}[T] n_ =0[; hyperparameters][ (] _[α, β, γ]_[)][; learning rate] _[ η]_[; number of epochs] _[ K]_[;] batch size _B_ ; neighbor window _k_ ; temperature _τ_ . ˆ 1: Initialize deterministic encoder _zn_ = _fθ_ ( _xn_ ), decoder _xn_ = _gω_ ( _zn_ ), and Koopman operator _Kψ_ . 

2: **for** epoch = 1 to _K_ **do** 3: **for** each minibatch _{x_ 1 _, . . . , xB}_ from _D_ **do** 4: Encode latents _zi_ = _fθ_ ( _xi_ ) for _i_ = 1 _, . . . , B_ . 5: **Temporal coherence (InfoNCE)** : _I_ ( _zn_ ; _Pn_ ) _≈ |P_ 1 _n|_ � log _B_ exp( _zn[⊤][z][p][/][τ]_[)] _. p∈Pn_ � _j_ =1[exp(] _[z] n[⊤][z][j][/τ]_[)] 

6: **Structural consistency (deterministic)** : 

_L_ Koop = _∥zn_ +1 _−Kψzn∥_[2] _._ 

7: **Predictive sufficiency** : compute _S_ ( _P_ ) from normalized covariance _P_ = tr( _CC_ )[,] _[C]_[=] 1 ¯ ¯ _⊤ B_ �( _zi − z_ )( _zi − z_ ) . 8: **Reconstruction** : _L_ rec = _∥xn − gω_ ( _zn_ ) _∥_[2] _._ 

9: **Total Loss** : 

**==> picture [179 x 12] intentionally omitted <==**

10: Update _θ, ω, ψ_ with Adam step _η_ . 11: **end for** 12: **end for** 

34 

Published as a conference paper at ICLR 2026 

## G.3 EXPERIMENT SETTINGS AND ADDITIONAL RESULTS 

## G.3.1 PHYSICAL SIMULATION 

**Lorenz.** The Lorenz dataset is generated from the classical Lorenz system of ordinary differential equations (ODEs), which model simplified atmospheric convection. The governing equations are: 

**==> picture [236 x 38] intentionally omitted <==**

where _σ_ = 10, _ρ_ = 28, and _β_ = 8 _/_ 3 are the standard chaotic parameters. The system is integrated using a fixed time step ∆ _t_ = 0 _._ 1 s with a fourth-order Runge–Kutta method. The resulting trajectories exhibit chaotic behavior and are commonly used as benchmarks for nonlinear dynamical system identification. 

**K´arm´an Vortex.** The K´arm´an vortex street dataset is generated from the two-dimensional incompressible Navier–Stokes equations, which describe the velocity field ( _u, v_ ) and pressure _p_ of a viscous fluid: 

**==> picture [302 x 81] intentionally omitted <==**

where _Re_ = _UL/ν_ is the Reynolds number, defined with characteristic velocity _U_ , length _L_ , and kinematic viscosity _ν_ . The training dataset covers flows with _Re ∈_ [40 _,_ 1000], while the test dataset focuses on _Re_ = 1000. The flow is simulated around a cylinder, producing the characteristic alternating vortex shedding pattern. The domain is discretized on a 64 _×_ 64 grid, with time step ∆ _t_ = 0 _._ 001 s, and both _u_ and _v_ velocity components are recorded at each grid point (data from (Yining et al., 2023)). 

**Dam Flow.** The dam flow dataset is also generated from the two-dimensional incompressible Navier–Stokes equations, using the same formulation as in the K´arm´an vortex case. The training dataset spans _Re ∈_ [40 _,_ 1000] and the test dataset uses _Re_ = 1000. The flow is initialized in a rectangular channel with a fixed dam obstacle, where an imposed inlet velocity drives the fluid past the dam-like structure, generating a simple wake pattern downstream. The domain is discretized on a 64 _×_ 64 spatial grid, with temporal resolution ∆ _t_ = 0 _._ 1 s (data from (Yining et al., 2023)). 

The ERA5 dataset is a global atmospheric reanalysis produced by the European Centre for MediumRange Weather Forecasts (ECMWF), providing a physically consistent estimate of the large-scale circulation from 1940 to the present (Hersbach et al., 2020). The physic state consists of five channels: 500,hPa geopotential, 850,hPa temperature, 700,hPa specific humidity, and 850,hPa wind components in the zonal and meridional directions. We train all baselines from 1979-01-01 to 2016-0101 and test after 2018-01-01 (data from (Rasp et al., 2024)). Illustrations are provided in Figure 10. 

## G.3.2 VISUAL INPUTS 

**Planar System** In this task the main goal is to navigate an agent in a surrounded area on a 2D plane (Breivik & Fossen, 2008), whose goal is to navigate from a corner to the opposite one, while avoiding the six obstacles in this area. The system is observed through a set of 40 _×_ 40 pixel images taken from the top view, which specifies the agent’s location in the area. Actions are twodimensional and specify the _x − y_ direction of the agent’s movement, and given these actions the next positional state of the agent is generated by a deterministic underlying (unobservable) state evolution function. **Start State** : one of three corners (excluding bottom-right). **Goal State** : bottomright corner. **Agent’s Objective** : agent is within Euclidean distance of 2 from the goal state. 

35 

Published as a conference paper at ICLR 2026 

**==> picture [397 x 149] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a). Lorenz63 Lorenz 63 (b). Kármán Vortex Kármán Vortex (c). Dam Flow Dam Flow<br>(d).<br>**----- End of picture text -----**<br>


Figure 10: Examples of physical simulation: (a).Lorenz 63, (b).K´arm´an Vortex, (c).Dam Flow, (d).ERA5 

**Inverted Pendulum — SwingUp & Balance** This is the classic problem of controlling an inverted pendulum (Furuta et al., 1991) from 48 _×_ 48 pixel images. The goal of this task is to swing up an under-actuated pendulum from the downward resting position (pendulum hanging down) to the top position and to balance it. The underlying state _st_ of the system has two dimensions: angle and angular velocity, which is unobservable. The control (action) is 1-dimensional, which is the torque applied to the joint of the pendulum. To keep the Markovian property in the observation (image) space, similar to the setting in E2C, each observation _xt_ contains two images generated from consecutive time-frames (from current time and previous time). This is because each image only shows the position of the pendulum and does not contain any information about the velocity. **Start State** : Pole is resting down (SwingUp), or randomly sampled in _±π/_ 6 (Balance). **Agent’s Objective** : pole’s angle is within _±π/_ 6 from an upright position. 

**CartPole** This is the visual version of the classic task of controlling a cart-pole system (Geva & Sitte, 1993). The goal in this task is to balance a pole on a moving cart, while the cart avoids hitting the left and right boundaries. The control (action) is 1-dimensional, which is the force applied to the cart. The underlying state of the system _st_ is 4-dimensional, which indicates the angle and angular velocity of the pole, as well as the position and velocity of the cart. Similar to the inverted pendulum, in order to maintain the Markovian property the observation _xt_ is a stack of two 80 _×_ 80 pixel images generated from consecutive time-frames. **Start State** : Pole is randomly sampled in _±π/_ 6. **Agent’s Objective** : pole’s angle is within _±π/_ 10 from an upright position. 

**3-link Manipulator — SwingUp & Balance** The goal in this task is to move a 3-link manipulator from the initial position (which is the downward resting position) to a final position (which is the top position) and balance it. In the 1-link case, this experiment is reduced to inverted pendulum. In the 2-link case the setup is similar to that of acrobot , except that we have torques applied to all intermediate joints, and in the 3-link case the setup is similar to that of the 3-link planar robot arm domain that was used in the E2C paper, except that the robotic arms are modeled by simple rectangular rods (instead of real images of robot arms), and our task success criterion requires both the swing-up (manipulate to final position) and balance. The underlying (unobservable) state _st_ of the system is 6-dimensional, which indicates the relative angular velocities and relative angles of the 3 links. **Start State** : Pole is resting down. **Agent’s Objective** : pole’s angle is within _±π/_ 6 from an upright position. 

The control algorithm is linear quadratic control in the latent space and the corresponding control horizon follows the setting in (Levine et al., 2020). 

## G.3.3 GRAPH-STRUCTURED DYNAMICS FOR SIMULATION 

In the numerical experiments, we adopt the graph environments introduced in (Li et al., 2020), where interactions among objects are modeled differently according to their connection types and physical 

36 

Published as a conference paper at ICLR 2026 

**==> picture [278 x 101] intentionally omitted <==**

Figure 11: The examples of visual inputs: Planar (left), Pendulum (middle), Cartpole (right). 

properties. These environments are designed to capture diverse interaction dynamics through a Koopman representation (see illustrative examples in Figure 12), as detailed below: 

In the Rope environment, the top mass is fixed in height and is treated differently from the other masses, resulting in two distinct types of self-interactions: one for the top mass and one for non-top masses. Additionally, there are eight types of interactions between different objects. Each mass is represented by four dimensions, encoding its state and velocity. Objects in a relation can be either the top mass or a non-top mass, yielding four possible combinations. Interactions may occur between adjacent masses or between masses that are two hops apart. In total, this gives 4 _×_ 2 = 8 types of interactions between different objects. Training is performed on environments with 5–9 objects, while testing uses 10–14 objects. The overall dimensionality ranges from 40 to 56. 

In the Soft environments, quadrilaterals are categorized into four types: rigid, soft, actuated, and fixed, each with its own form of self-interaction. For interactions between objects, an edge is defined between two quadrilaterals only if they are connected at a point or along an edge. Connections from different directions are treated as distinct relations, with eight possible directions: up, down, left, right, up-left, down-left, up-right, and down-right. Relation types also encode the category of the receiving object, resulting in a total of (8 + 1) _×_ 4 = 36 possible relation types between objects. Training is conducted on environments with 5–9 quadrilaterals, while testing uses 10–14 quadrilaterals. Each quadrilateral is represented by a 16-dimensional vector, giving a total dimensionality ranging from 160 to 224. 

In noisy environment, the additive noise is zero-mean Gaussian with standard deviation equal to 10% of the standard deviation of the observation data. 

**==> picture [318 x 85] intentionally omitted <==**

**----- Start of picture text -----**<br>
Rope 1 Rope 2 Soft 1 Soft 2 Graph of Soft 2<br>**----- End of picture text -----**<br>


Figure 12: Examples of ropes and soft robots. Left: Blue nodes denote the initial states of Rope 1 and Rope 2, while orange nodes show their states after 40 time steps. Right: Interconnected quadrilaterals indicate the initial states, and the boxes represent the states of the soft robots after 40 time steps. The second soft robot (Soft 2) can be abstracted as a graph structure shown on the right. 

- G.4 IMPLEMENTATION ALGORITHM OF THREE TASKS 

37 

Published as a conference paper at ICLR 2026 

Table 5: Model structures across experimental environments. Here, _Kzt_ + _Bat_ denotes a controlled latent transition with linear control input _at_ (Visual Inputs case). _K_ ( _A_ ) denotes an adjacencyconditioned Koopman operator, corresponding to a shared Koopman composition modulated by the adjacency matrix _A_ (i.e., _K_ ( _A_ ) := _A ⊗K_ in graph environments; see Li et al. (2020, Page 4) for details). 

|**Environment**|**Structure**|**Key Features**|
|---|---|---|
|Physical Simulation|AE (G.2)|_zt_+1 = _Kzt_; reconstruction; Koopman linear forward;|
|||InfoNCE; von Neumann entropy|
|Visual Inputs (Con-|VAE (G.1)|_zt_+1 = _Kzt_ +_Bat_ +_ϵ_(Linear Gaussian); VAE ELBO;|
|trol Tasks)||reconstruction; InfoNCE; von Neumann entropy|
|Graph-structured|AE (G.2)|_zt_+1 =_K_(_A_)_zt_(adjacency-conditioned); reconstruction;|
|Dynamics||InfoNCE; von Neumann entropy|



38 

Published as a conference paper at ICLR 2026 

## G.5 MORE EXPERIMENTAL RESULTS 

## G.5.1 PHYSICAL SIMULATIONS 

**==> picture [238 x 253] intentionally omitted <==**

Figure 13: Comparison of sampled spatial distributions based on 100000 _−_ step data for Lorenz 63. **Green** denotes the ground-truth distribution from the physical solver, and **purple** denotes samples generated by our method. Across both marginal and joint projections, the two distributions exhibit close agreement, demonstrating that our empirical results capture the underlying dynamics. 

**==> picture [338 x 211] intentionally omitted <==**

**----- Start of picture text -----**<br>
Kármán vortex street: Continuous Prediction from t=0.7s<br>Ground Truth VAE KAE KKR PFNN Ours<br>10<br>8<br>6<br>4<br>2<br>0<br>1.0<br>0.8<br>0.6<br>0.4<br>0.2<br>0.0<br>10<br>8<br>6<br>4<br>2<br>0<br>6<br>4<br>2<br>t = 0.71s<br>Error<br>t = 0.8s<br>Error<br>**----- End of picture text -----**<br>


Figure 14: Comparison of continuous predictions for the K´arm´an vortex street starting from _t_ = 0 _._ 7 _s_ . Ground truth are contrasted with predictions from VAE, KAE, KKR, PFNN, and our method. Error maps in the lower panels demonstrate that, compared with other models, our method achieves the closest agreement and effectively prevents collapse in the predicted fields. 

39 

Published as a conference paper at ICLR 2026 

**==> picture [338 x 257] intentionally omitted <==**

**----- Start of picture text -----**<br>
CFDBench Dam Flow: Continuous Prediction from t=5.0s<br>Ground Truth VAE KAE KKR Ours<br>2.5<br>2.0<br>1.5<br>1.0<br>0.5<br>0.0<br>1.0<br>0.8<br>0.6<br>0.4<br>0.2<br>2.0<br>1.5<br>1.0<br>0.5<br>0.0<br>1.5<br>1.0<br>0.5<br>t = 5.5s<br>Error<br>t = 7.5s<br>Error<br>**----- End of picture text -----**<br>


Figure 15: Comparison of continuous predictions for the dam flow starting from _t_ = 5 _._ 0 _s_ . Ground truth are contrasted with predictions from VAE, KAE, KKR, and our method. Error maps in the lower panels demonstrate that, compared with other models, our method more effectively prevents collapse in the predicted fields for dam flow. 

40 

Published as a conference paper at ICLR 2026 

Table 6: Per-channel performance comparison on ERA5 weather forecasting. _N_ -NRMSE and _N_ - SSIM denote errors at _N_ prediction steps; values in parentheses indicate the standard deviation across test samples. Even under the highly stochastic and high-dimensional ERA5 weather dynamics, our approach outperforms all baselines across both short-term and long-term prediction horizons. 

|Channel|Metric|KAE|KKR|PFNN|Ours|
|---|---|---|---|---|---|
||5-NRMSE|0.058 (0.020)|0.061 (0.027)|0.046 (0.012)|**0.023 (0.005)**|
||10-NRMSE|0.068 (0.018)|0.074 (0.026)|0.062 (0.018)|**0.032 (0.010)**|
|Geopotential|50-NRMSE<br>5-SSIM|0.157 (0.071)<br>0.860 (0.054)|0.082 (0.025)<br>0.852 (0.064)|0.082 (0.016)<br>0.882 (0.036)|**0.075 (0.017)**<br>**0.964 (0.011)**|
||10-SSIM|0.836 (0.051)|0.820 (0.065)|0.848 (0.052)|**0.943 (0.028)**|
||50-SSIM|0.665 (0.195)|0.790 (0.049)|0.765 (0.055)|**0.806 (0.039)**|
||5-NRMSE|0.049 (0.019)|0.052 (0.032)|0.040 (0.009)|**0.022 (0.003)**|
||10-NRMSE|0.056 (0.017)|0.064 (0.028)|0.051 (0.015)|**0.026 (0.006)**|
|Temperature|50-NRMSE<br>5-SSIM|0.114 (0.054)<br>0.866 (0.046)|0.074 (0.030)<br>0.862 (0.058)|0.067 (0.018)<br>0.888 (0.026)|**0.063 (0.019)**<br>**0.956 (0.008)**|
||10-SSIM|0.844 (0.044)|0.829 (0.063)|0.859 (0.042)|**0.942 (0.019)**|
||50-SSIM|0.671 (0.216)|0.802 (0.059)|0.803 (0.051)|**0.825 (0.042)**|
||5-NRMSE|0.064 (0.029)|0.069 (0.043)|0.055 (0.011)|**0.031 (0.003)**|
||10-NRMSE|0.077 (0.027)|0.085 (0.041)|0.070 (0.020)|**0.038 (0.006)**|
|Humidity|50-NRMSE<br>5-SSIM|0.165 (0.086)<br>0.859 (0.056)|0.093 (0.040)<br>0.856 (0.076)|0.088 (0.021)<br>0.880 (0.026)|**0.084 (0.028)**<br>**0.954 (0.008)**|
||10-SSIM|0.818 (0.064)|0.805 (0.095)|0.835 (0.053)|**0.933 (0.021)**|
||50-SSIM|0.663 (0.220)|0.781 (0.087)|0.776 (0.058)|**0.799 (0.057)**|
||5-NRMSE|0.055 (0.009)|0.056 (0.011)|0.053 (0.006)|**0.032 (0.006)**|
||10-NRMSE|0.059 (0.008)|0.061 (0.009)|0.060 (0.008)|**0.041 (0.010)**|
|Wind_u_direction|50-NRMSE<br>5-SSIM|0.096 (0.030)<br>0.505 (0.122)|0.063 (0.006)<br>0.502 (0.141)|0.070 (0.007)<br>0.537 (0.084)|**0.062 (0.005)**<br>**0.814 (0.051)**|
||10-SSIM|0.433 (0.115)|0.415 (0.134)|0.424 (0.120)|**0.721 (0.107)**|
||50-SSIM|0.300 (0.251)|0.361 (0.085)|0.267 (0.100)|**0.382 (0.068)**|
||5-NRMSE|0.051 (0.008)|0.051 (0.009)|0.050 (0.006)|**0.031 (0.005)**|
||10-NRMSE|0.054 (0.007)|0.054 (0.008)|0.055 (0.007)|**0.040 (0.010)**|
|Wind_v_direction|50-NRMSE<br>5-SSIM|0.060 (0.006)<br>0.240 (0.159)|**0.057 (0.005)**<br>0.247 (0.183)|0.087 (0.025)<br>0.300 (0.091)|**0.057 (0.005)**<br>**0.649 (0.098)**|
||10-SSIM|0.163 (0.133)|0.163 (0.150)|0.208 (0.101)|**0.499 (0.163)**|
||50-SSIM|0.105 (0.077)|0.093 (0.082)|**0.165 (0.193)**|0.094 (0.074)|



Table 7: Training time statistics for different models and tasks. Epoch times are reported as mean _±_ std (in seconds). For _Ours_ , InfoNCE and entropy (von Neumann entropy) rows correspond to the total per-epoch computation. Notably, the overhead introduced by InfoNCE and von Neumann entropy is marginal, accounting for only a small percentage of the total training time. 

. 

||||.||||
|---|---|---|---|---|---|---|
|Task|Metric|VAE|KAE|KKR|PFNN|Ours|
||Epoch time (s)|172_._94_±_4_._11|195_._26_±_3_._47|186_._47_±_1_._86|182_._52_±_2_._53|201_._23_±_1_._07|
|K´arm´an vortex|InfoNCE time (s)|–|–|–|–|13_._78_±_0_._93|
||Entropy time (s)|–|–|–|–|0_._97_±_0_._13|
||Epoch time (s)|16_._21_±_0_._29|16_._95_±_0_._33|17_._48_±_0_._29|–|18_._92_±_0_._36|
|Dam Flow|InfoNCE time (s)|–|–|–|–|0_._76_±_0_._04|
||Entropy time (s)|–|–|–|–|0_._56_±_0_._08|
||Epoch time (s)|–|240_._20_±_0_._52|224_._95_±_0_._54|242_._33_±_0_._71|253_._24_±_2_._05|
|ERA5|InfoNCE time (s)|–|–|–|–|15_._09_±_0_._80|
||Entropy time (s)|–|–|–|–|7_._43_±_0_._64|



41 

Published as a conference paper at ICLR 2026 

**==> picture [390 x 210] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth KAE KKR PFNN Ours<br>43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504<br>0 4122 8244 12366 0 4122 8244 12366 0 4122 8244 12366 0 4122 8244 12366<br>43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504 43802 48703 53603 58504<br>0 4122 8244 12366 0 4122 8244 12366 0 4122 8244 12366 0 4122 8244 12366<br>08:00<br>2018-01-01<br>Error<br>08:00<br>2018-01-08<br>Error<br>**----- End of picture text -----**<br>


Figure 16: Comparison of continuous predictions for the global geopotential starting from 2018 _−_ 01 _−_ 01 _−_ 00 : 00 to 2018 _−_ 01 _−_ 08 _−_ 08 : 00. Ground truth are contrasted with predictions from KAE, KKR, PFNN, and our method. Error maps in the lower panels demonstrate that, compared with other models, showing with more stable and accurate results of our model. 

42 

Published as a conference paper at ICLR 2026 

**==> picture [390 x 210] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth KAE KKR PFNN Ours<br>223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06<br>0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18<br>223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06 223.89 250.95 278.00 305.06<br>0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18 0.00 20.73 41.45 62.18<br>08:00<br>2018-01-01<br>Error<br>08:00<br>2018-01-08<br>Error<br>**----- End of picture text -----**<br>


Figure 17: Comparison of continuous predictions for the global temperature starting from 2018 _−_ 01 _−_ 01 _−_ 00 : 00 to 2018 _−_ 01 _−_ 08 _−_ 08 : 00. Ground truth are contrasted with predictions from KAE, KKR, PFNN, and our method. Error maps in the lower panels demonstrate that, compared with other models, showing with more stable and accurate results of our model. 

43 

Published as a conference paper at ICLR 2026 

**==> picture [390 x 210] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth KAE KKR PFNN Ours<br>32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64<br>0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58<br>32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64 32.29 8.98 14.33 37.64<br>0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58 0.00 17.53 35.06 52.58<br>08:00<br>2018-01-01<br>Error<br>08:00<br>2018-01-08<br>Error<br>**----- End of picture text -----**<br>


Figure 18: Comparison of continuous predictions for the global _u−_ direction wind starting from 2018 _−_ 01 _−_ 01 _−_ 00 : 00 to 2018 _−_ 01 _−_ 08 _−_ 08 : 00. Ground truth are contrasted with predictions from KAE, KKR, PFNN, and our method. Error maps in the lower panels demonstrate that, compared with other models, showing with more stable and accurate results of our model. 

44 

Published as a conference paper at ICLR 2026 

**==> picture [390 x 210] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground Truth KAE KKR PFNN Ours<br>34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60<br>0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48<br>34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60 34.89 12.73 9.43 31.60<br>0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48 0.00 15.83 31.65 47.48<br>08:00<br>2018-01-01<br>Error<br>08:00<br>2018-01-08<br>Error<br>**----- End of picture text -----**<br>


Figure 19: Comparison of continuous predictions for the global _v−_ direction wind starting from 2018 _−_ 01 _−_ 01 _−_ 00 : 00 to 2018 _−_ 01 _−_ 08 _−_ 08 : 00. Ground truth are contrasted with predictions from KAE, KKR, PFNN, and our method. Error maps in the lower panels demonstrate that, compared with other models, showing with more stable and accurate results of our model. 

45 

Published as a conference paper at ICLR 2026 

**==> picture [376 x 508] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.0 Epoch 1 1.0 Epoch 10 1.0 Epoch 20 1.0 Epoch 30 1.0 Epoch 40<br>0.8 0.8 0.8 0.8 0.8<br>0.6 0.6 0.6 0.6 0.6<br>0.4 0.4 0.4 0.4 0.4<br>0.2 0.2 0.2 0.2 0.2<br>0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values<br>(a) 1.0 Epoch 50 1.0 Epoch 60 1.0 Epoch 70 1.0 Epoch 80 1.0 Epoch 90<br>0.8 0.8 0.8 0.8 0.8<br>0.6 0.6 0.6 0.6 0.6<br>0.4 0.4 0.4 0.4 0.4<br>0.2 0.2 0.2 0.2 0.2<br>0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values 0.0 Eigen Values<br>With Without<br>Epoch 1 Epoch 10 Epoch 20 Epoch 30 Epoch 40<br>6<br>5<br>4<br>(b) Epoch 50 Epoch 60 Epoch 70 Epoch 80 Epoch 90<br>3<br>2<br>1<br>0<br>Epoch 1 Epoch 10 Epoch 20 Epoch 30 Epoch 40<br>6<br>5<br>4<br>(c) Epoch 50 Epoch 60 Epoch 70 Epoch 80 Epoch 90<br>3<br>2<br>1<br>0<br>**----- End of picture text -----**<br>


Figure 20: Comparison between _γ_ = 0 _._ 0 and _γ_ = 0 _._ 5 on the physical simulation task with latent dimension 32. **(a)** Evolution of the eigenvalue spectrum over training epochs. **(b)** Heatmap of the latent covariance matrix for _γ_ = 0 _._ 0 across epochs. **(c)** Heatmap of the latent covariance matrix for _γ_ = 0 _._ 5 across epochs. With the addition of the von Neumann entropy regularizer, two clear effects emerge during training. First, the latent covariance matrix no longer collapses to a few dominant modes: the eigenvalue distribution becomes more uniform and remains close to full rank throughout optimization (see **(a)** ), indicating that the model learns a richer set of modes rather than compressing them into a low-dimensional subspace. Second, the covariance structure transitions from highly sparse (when _γ_ = 0) to dense and full-rank under entropy regularization (from **(b)** to **(c)** ), verifying our theoretical prediction in Proposition 5. 

46 

Published as a conference paper at ICLR 2026 

**==> picture [392 x 108] intentionally omitted <==**

**----- Start of picture text -----**<br>
Kármán Vortex Dam Flow ERA5<br>3.0 Total Loss Entropy Loss 0.5 65 Total LossEntropy Loss 1.6 350 Total LossEntropy Loss 4.0<br>2.5 0.4 1.4 300 3.5<br>2.0 0.3 4 1.2 250 3.0<br>3 2.5<br>(a) 1.5 0.2 (b) 1.0 (c) 200 2.0<br>1.0 2<br>0.8 150 1.5<br>0.5 0.1 1 1.0<br>0.6<br>0.0 0.0 0 100 0.5<br>Epoch Epoch Epoch<br>Total Loss Total Loss Total Loss<br>Entropy Loss Entropy Loss Entropy Loss<br>**----- End of picture text -----**<br>


Figure 21: Visualization of the von Neumann entropy regularization loss and the total training loss over epochs for the physical simulation tasks. The stable behavior of both the total loss and the von Neumann entropy loss indicates that our training procedure is numerically stable and robust across different systems. 

47 

Published as a conference paper at ICLR 2026 

## G.5.2 VISUAL PERCEPTION 

Table 8: Percentage to Goal (%) for different algorithms under noisy rollout. A higher value indicates that the system reaches closer to the goal within a fixed number of control steps. 

|Domain<br>E2C<br>PCC<br>KAE<br>Ours|Domain<br>E2C<br>PCC<br>KAE<br>Ours|
|---|---|
|Planar(_n_= 40_×_40)<br>Pendulum(_n_= 48_×_40_×_2)<br>Cartpole(_n_= 80_×_80_×_2)<br>3-link(_n_= 80_×_80_×_2)|6.2 (1.5)<br>34.8 (3.6)<br>5.1 (1.2)<br>**39.6 (2.8)**|
||45.5 (3.9)<br>59.8 (3.2)<br>26.3 (2.8)<br>**62.7 (2.9)**|
||8.1 (1.6)<br>53.1 (3.5)<br>57.2 (3.8)<br>**61.9 (3.0)**|
||5.0 (1.0)<br>**21.3 (1.9)**<br>2.1 (0.6)<br>19.5 (2.0)|



Table 9: Percentage to Goal (%) for different algorithms under noiseless rollouts. 

|Domain<br>E2C<br>PCC<br>KAE<br>Ours|Domain<br>E2C<br>PCC<br>KAE<br>Ours|
|---|---|
|Planar(_n_= 40_×_40)<br>Pendulum(_n_= 48_×_40_×_2)<br>Cartpole(_n_= 80_×_80_×_2)<br>3-link(_n_= 80_×_80_×_2)|37.8 (3.5)<br>71.4 (0.6)<br>12.2 (1.4)<br>**73.8 (0.5)**|
||88.5 (0.6)<br>90.1 (0.5)<br>68.2 (1.9)<br>**91.5 (0.4)**|
||39.5 (3.3)<br>94.1 (1.6)<br>98.5 (0.3)<br>**97.6 (1.2)**|
||21.5 (0.9)<br>**48.5 (1.6)**<br>11.8 (0.8)<br>47.9 (1.4)|



## G.5.3 GRAPH-STRUCTURED DYNAMICS 

**==> picture [394 x 260] intentionally omitted <==**

**----- Start of picture text -----**<br>
Time Direction<br>Rope<br>Soft<br>**----- End of picture text -----**<br>


Figure 22: Comparison of ground truth and our predictions over time for rope and soft-body dynamics. Top row (Rope): red dots indicate ground truth positions, while blue dots show our predicted trajectories. Middle and bottom rows (Soft): translucent shapes represent ground truth deformations, and solid colored blocks denote our predictions. The time axis progresses from left to right. 

48 

Published as a conference paper at ICLR 2026 

## G.5.4 MODEL ARCHITECTURE 

Table 10: Model architecture for K´arm´an Vortex and Dam Flow task with input dimension ( _C, H, W_ ), where _C_ denotes the number of velocity components and _H × W_ is the spatial resolution. 

|**Components**|**Layer**|**Layer number**||_C,_ (_H, W_)|_C,_ (_H, W_)|_C,_ (_H, W_)||**Activation**|
|---|---|---|---|---|---|---|---|---|
|Encoder|Convolution Block<br>Convolution Block<br>Convolution2d<br>Flatten<br>Fully Connected|1<br>3<br>1<br>–<br>1||_C →_8_C,_( _H_<br>2 _, _<br>8_C →_64_C,_( _H_<br>16_,_<br>64_C →_128_C,_( _H_<br>16<br>128_C,_( _H_<br>16_, W_<br>16 )_→_<br>_CHW_<br>2<br>_→ds_|||_W_<br>2 )<br> _W_<br>16 )<br><br>_, W_<br>16 )<br>_CHW_<br>2|ReLU<br>ReLU<br>ReLU<br>–<br>–|
|Koopman Operator|Linear|1|||_ds →ds_|||–|
|Decoder|Fully Connected<br>Transpose<br>ConvTranspose Block<br>ConvTranspose2d<br>Conv2d Refnement|1<br>–<br>3<br>1<br>3||_CHW_||_CHW_||ReLU<br>–<br>ReLU<br>–<br>ReLU|



Table 11: Model architecture for ERA5 task with input dimension ( _C, H, W_ ), where _C_ denotes the number of channels and _H × W_ is the spatial resolution, using a factorized-attention encoder. 

|**Components**|**Layer**|**Layer number**||_C,_ (_H, W_)|_C,_ (_H, W_)|**Activation**|
|---|---|---|---|---|---|---|
|Encoder|Conv2d<br>Conv2d<br>FactorizedBlock<br>Flatten<br>Fully Connected|1<br>1<br>1<br>–<br>1||_C →_64_C_<br>5 _,_ (_H, W_)<br>64_C_<br>5<br>_→_64_C_<br>5 _,_ ( _H_<br>4 _, W_<br>4 )<br>64_C_<br>5 _,_ ( _H_<br>4 _, W_<br>4 )<br>64_C_<br>5 _,_ ( _H_<br>4 _, W_<br>4 )_→_4_CHW_<br>5<br>4_CHW_<br>5<br>_→ds_||–<br>–<br>GELU<br>–<br>–|
|Koopman Operator|Linear|1|||_ds →ds_|–|
|Decoder|Fully Connected<br>Transpose<br>ConvTranspose2d<br>Conv2d<br>Conv2d Refnement|1<br>–<br>2<br>1<br>3||4_CH_||ReLU<br>–<br>ReLU<br>–<br>ReLU|



For fair comparison, the architectures for visual input and graph-structured dynamics follow the settings in Levine et al. (2020) and Li et al. (2020). 

Table 12: Hyperparameter settings across physical simulations, visual inputs, and graph-structured dynamics 

|**Parameter**|**Symbol**|**Physical Sim.**|**Visual Inputs**|**Graph Dyn.**|
|---|---|---|---|---|
|Temporal coherence|_α_|2.00|3.00|2.00|
|Structural consistency|_β_|–|2.00|–|
|von Neumann entropy|_γ_|0.10|0.50|0.10|
|InfoNCE neighborhood|_k_|3|5|5|



49 

Published as a conference paper at ICLR 2026 

## G.6 BASELINE ALGORITHMS 

## **Physical Simulation Tasks.** 

- **VAE** (Kingma et al., 2013): Baseline implemented using a standard variational autoencoder with a nonlinear forward map in latent space. Code available at https://github. com/bvezilic/Variational-autoencoder. 

- **KAE** (Pan et al., 2023): Koopman learning with an autoencoder architecture. Code available at https://github.com/dynamicslab/pykoopman. 

- **KKR** (Bevanda et al., 2023): For the low-dimensional Lorenz–63 system, we adopt fixed kernel functions as basis following the implementation in https://github. com/TUM-ITR/koopcore. For high-dimensional systems, we use deep kernel features following Yang et al. (2025), with code available at https://github.com/ yyimingucl/TensorVar/blob/main/model/KS_model.py. 

- **PFNN** (Cheng et al., 2025): A state-of-the-art Koopman variant for learning and predicting chaotic dynamics. Code available at https://github.com/Hy23333/PFNN. 

## **Visual Inputs.** 

- **E2C** (Banijamali et al., 2019): A latent embedding approach based on the VAE framework. Code available at https://github.com/ericjang/e2c. 

- **KAE** (Pan et al., 2023): Koopman learning with an autoencoder architecture. Code available at https://github.com/dynamicslab/pykoopman. 

- **PCC** (Banijamali et al., 2019): A state-of-the-art latent embedding algorithm also based on the VAE framework. Code available at https://github.com/VinAIResearch/ PCC-pytorch/tree/master/sample_results. 

## **Graph-Structured Dynamics.** 

- **CKO** (Li et al., 2020): A Koopman-based framework for learning and predicting general graph-structured dynamics. Code available at https://github.com/YunzhuLi/ CompositionalKoopmanOperators. 

50 

