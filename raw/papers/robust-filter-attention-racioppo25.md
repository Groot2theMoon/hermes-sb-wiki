---
title: "**Robust Filter Attention: Self-Attention as a Parallel State Estimator**"
arxiv: "2509.0415"
authors: ["Peter Racioppo"]
year: 2025
source: paper
ingested: 2026-05-06
sha256: 8a0c2eb8e8aba070aecd2eb728385b5eec6bf6516a090097626d18ef0af122ce
conversion: pymupdf4llm
---

**Robust Filter Attention: Self-Attention as a Parallel State Estimator** 

## **Peter Racioppo**[1] 

## **Abstract** 

We introduce Robust Filter Attention (RFA), an attention mechanism that reformulates selfattention as parallel robust filtering under a latent stochastic differential equation (SDE) prior, where analytically propagated uncertainty defines a time-dependent precision prior over attention weights. This formulation integrates key advantages of existing positional encodings: it preserves RoPE-style rotational structure while achieving long-context stability through explicit modeling of dissipation and diffusion. By imposing isotropic constraints on the dynamics and noise, RFA matches the _O_ ( _N_[2] _d_ ) time and _O_ ( _N_[2] + _Nd_ ) memory complexity of standard attention. Empirically, we find that uncertaintyaware weighting induces specialization into distinct filtering regimes across heads, improving temporal consistency and extrapolation across varying context lengths. 

## **1. Introduction** 

Modern Transformer architectures typically model temporal structure through positional mechanisms such as rotary positional embeddings (RoPE) (Su et al., 2024), which propagate representations through norm-preserving rotations. While this preserves relative phase information, it does not model uncertainty growth, treating distant and recent states as equally reliable. As a result, high-frequency components are not explicitly attenuated with temporal distance, which may contribute to interference during long-range aggregation and reduced stability under long-context extrapolation. 

We reformulate self-attention as a form of robust state estimation, where past tokens are aggregated using weights determined by their consistency under a shared dynamical prior. We formalize this by introducing a linear timeinvariant (LTI) stochastic differential equation (SDE) that serves as a local propagation and uncertainty prior at each query position, yielding closed-form expressions for both 

> 1Independent Researcher, Los Angeles, CA, USA. Correspondence to: Peter Racioppo _<_ pcracioppo@gmail.com _>_ . 

_Preprint. January 30, 2026._ 

transported means and their predicted uncertainty as a function of temporal lag. 

By treating queries and keys as noisy observations under this shared dynamical prior, we derive Robust Filter Attention (RFA). RFA propagates keys into the query frame and computes lag-dependent uncertainty via the Differential Lyapunov Equation (DLE), yielding a precision prior consistent with transport under the learned linear dynamics. This precision is used in residual-based Mahalanobis scoring, allowing the model to weight tokens by their consistency after dynamical propagation. Thus, RFA functions as a parallelized robust filter: the dynamics define a shared transport and uncertainty model, while token weights adapt online through precision-weighted residuals. 

To ensure computational tractability, RFA imposes four structural constraints: (1) LTI dynamics for analytic state and uncertainty propagation; (2) an approximate anchorconditioned factorization of the likelihood across source tokens, enabling _O_ ( _N_[2] ) scaling; (3) simultaneous diagonalizability, enabling analytic solution of the DLE and closedform precision inversion; and (4) an isotropic formulation, preserving the computational and memory complexity of standard attention. 

In the zero-noise and zero-decay limit, our formulation reduces to a purely rotational embedding consistent with RoPE, while ALiBi (Press et al., 2022) can be interpreted as approximating the short-time linear growth of uncertainty predicted by the DLE under Brownian diffusion. 

Finally, we introduce Spectrally-Coupled RFA (SC-RFA), which partitions the frequency spectrum across heads and couples each head’s dissipation rate ( _µ_ ) to its maximum rotation frequency ( _ω_ max). This coupling enforces an inverse relationship between spectral resolution and temporal persistence: high-frequency heads act as sharp, short-range filters, while low-frequency heads function as stable longrange integrators. This induces a multi-resolution prior that separates short- and long-range dependencies across heads. 

Our contributions are: 

**(i)** Casting self-attention as approximate parallel robust state estimation under an SDE prior. 

**(ii)** A dynamical positional framework that recovers RoPE and ALiBi as limiting cases. 

1 

**Robust Filter Attention** 

**(iii)** A scalable isotropic formulation with analytic uncertainty propagation at standard attention cost. 

**(iv)** A spectrally coupled decay prior enabling multiresolution temporal filtering. 

## **2. Related Work** 

## **2.1. Probabilistic and Kernel Views of Attention** 

The standard Transformer architecture (Vaswani et al., 2017) computes attention scores via a scaled dot-product between queries and keys. While originally motivated by computational efficiency and the ability to capture long-range dependencies, a growing body of work has sought to interpret these weights as probabilities derived from latent statistical models. 

Probabilistic Transformers (Gabbur et al., 2021) show that dot-product attention arises as a constrained limit of MAP inference in a Gaussian mixture model. The Bayesian Attention Mechanism (BAM) (Bianchessi et al., 2025) treats positional embeddings as explicit priors over token indices, while the Correlated Gaussian Process Transformer (CGPT) (Bui et al., 2024) interprets asymmetric projections through correlated Gaussian process inference. These approaches introduce probabilistic structure, but rely on static featurespace similarity or fixed prior covariances. 

Other work has interpreted attention as a kernel regression estimator, modifying similarity geometry in feature space to improve robustness or variance properties (Tsai et al., 2019; Han et al., 2023; Nielsen et al., 2024; Liu et al., 2020; Goel & Bartlett, 2024). 

RFA instead weights tokens by prediction error under a shared dynamical prior, with uncertainty evolving via the DLE. This yields a global weighted least-squares estimate of the latent state, rather than a mixture assignment or similarity-based kernel smoothing. 

## **2.2. Filtering, Continuous Dynamics, and SSMs** 

Continuous-time sequence models often parameterize latent dynamics using Neural Ordinary Differential Equations (Neural ODEs) (Chen et al., 2018) and their stochastic extensions, Neural SDEs (Li et al., 2020; Shen & Cheng, 2025), which learn drift and diffusion functions from data. Several architectures integrate attention with continuous dynamics to handle irregular sampling or time-dependent relevance, including Continuous-Time Attention (Chien & Chen, 2021), Attentive Neural Processes (Kim et al., 2019), and ACE-NODE (Jhin et al., 2021). Self-Modulating Attention (SMA) (Chen et al., 2021) adjusts attention weights as a function of temporal distance. 

Other work integrates neural networks with classical filter- 

ing frameworks by learning components of the Kalman filter, such as gains, noise models, or update rules (Jahanshahi & Zhu, 2025; Revach et al., 2022; Liu et al., 2023; Wang et al., 2024; Cohen & Klein, 2025; Shen et al., 2025). In contrast, RFA assumes a structured linear SDE prior whose DLE admits a closed-form solution, enabling parallel precisionweighted aggregation without learning Kalman gains or full covariance updates. 

State space models (SSMs) provide another approach to sequence modeling by assuming linear time-invariant (LTI) dynamics and converting recurrence into convolution via the state transition matrix _e_ _**[A]**_[∆] _[t]_ . Frameworks such as HiPPO (Gu et al., 2020) and S4 (Gu et al., 2022) achieve efficiency by restricting _**A**_ to diagonalizable or diagonal-plus-lowrank forms, reducing state propagation costs from _O_ ( _d_[2] ) to _O_ ( _d_ ). Recent work shows that causal linear attention can be viewed as a special case of LTI convolution (Dao & Gu, 2024). 

Like S4 (Gu et al., 2022), RFA relies on diagonalizable linear dynamics for computational efficiency. However, whereas deterministic SSMs propagate only the state mean, RFA propagates second-order statistics via the DLE, yielding a time-dependent precision kernel that defines a prior over attention weights. While modern SSMs such as Mamba (Gu & Dao, 2024) achieve context sensitivity through datadependent gating of the recurrent state, RFA preserves content-based routing through attention and regularizes it using a prior on predicted uncertainty. 

## **2.3. Positional Encodings and Complex Geometry** 

Modeling relative temporal structure in Transformers has been approached with several geometric methods. RoPE (Su et al., 2024) encodes relative position as complex rotations of queries and keys, preserving phase relationships across time but introducing no explicit notion of decay or uncertainty. ALiBi (Press et al., 2022) instead applies a linear distance-based bias to attention logits, enforcing locality and improving length extrapolation by suppressing distant interactions. xPos (Sun et al., 2023b;a) generalizes RoPE by combining rotations with dimension-wise decay to stabilize long-range behavior. 

While these methods impose useful geometric or monotonic structure, they are not derived from an explicit stochastic model of latent state evolution and do not specify how uncertainty should accumulate or dissipate over time. As a result, their decay and bias terms are typically introduced heuristically, rather than as consequences of a shared dynamical prior. 

RFA performs value aggregation in the stationary eigenframe of the latent dynamics, necessitating a rotate–aggregate–rotate-back operation on the value stream. 

2 

**Robust Filter Attention** 

This ensures that historical updates are aligned in a shared temporal frame before fusion, and then counter-rotated to remain equivariant with the observer’s evolving coordinate system. While methods such as RoPER (Harik, 2023) have applied value rotations previously, RFA derives this structure as the transformation required to maintain dynamical consistency of the state estimate under the shared latent dynamics. 

Common positional embeddings can be viewed as limiting cases of a single latent stochastic process. RoPE implements deterministic phase transport without uncertainty accumulation, while ALiBi enforces locality via a distance bias consistent with a pure-diffusion prior. Similarly, xPos introduces dimension-wise decay but lacks an explicit model of uncertainty growth. By contrast, RFA derives both attenuation and reliability from an underlying SDE in which the same dissipation rate governs signal decay and uncertainty growth. 

This unified parameterization ensures that temporal weighting and precision remain dynamically consistent rather than independently tuned. This distinguishes RFA from recent methods such as YaRN, CARoPE, and Selective RoPE (Peng et al., 2024; Veisi et al., 2025; Movahedi et al., 2025), which improve extrapolation through manual frequency scheduling or length-dependent scaling. 

where the covariance captures both accumulated process noise and the measurement noise of the source token: 

**==> picture [209 x 12] intentionally omitted <==**

Here, _**V**_ (∆ _t_ ) is the solution of the Differential Lyapunov Equation (DLE), which governs noise accumulation in linear SDEs: 

**==> picture [226 x 13] intentionally omitted <==**

The anchor state is not observed directly. Instead, the model forms a query embedding: 

**==> picture [153 x 13] intentionally omitted <==**

which is compared to transported past measurements _**z**_ ˆ _ij_ . The observable residual is therefore: 

**==> picture [67 x 11] intentionally omitted <==**

To obtain a parallelizable estimator, we approximate the joint likelihood by treating _**z** i_ and ˆ _**z** ij_ as conditionally independent noisy measurements of the same latent anchor state (see Appendix A.4). Under this approximation, the residual follows: 

**==> picture [179 x 19] intentionally omitted <==**

## **3. Methods** 

This section summarizes the formulation of RFA; complete derivations are provided in Appendix A and Appendix B. 

## **3.1. Preliminaries** 

We model each token in a sequence of length _N_ as a noisy observation of a latent linear time-invariant (LTI) stochastic dynamical system in state space _**x**_ ( _t_ ) _∈_ R _[d]_ , observed at discrete times _ti_ as embeddings _**z** i ∈_ R _[d]_ : 

**==> picture [127 x 30] intentionally omitted <==**

**==> picture [13 x 10] intentionally omitted <==**

where _**v**_ ( _ti_ ) _∼N_ ( **0** _,_ _**R**_ ) and _d_ _**w**_ ( _t_ ) is a standard Wiener process. 

We denote the latent output at time _ti_ by _**z**[C] i_[:=] _**[Cx]**_[(] _[t][i]_[)][.] Given a past measurement _**z** j_ , we form a transported estimate of the latent output at time _ti_ by propagating through the dynamics: 

**==> picture [211 x 13] intentionally omitted <==**

where ∆ _tij_ = _ti − tj_ and _**C**_ is assumed invertible. 

Under the linear SDE, the transported estimate is distributed as: 

**==> picture [115 x 19] intentionally omitted <==**

where _**R**_ **Γ** models irreducible uncertainty in the anchor representation and prevents precision from diverging as ∆ _t →_ 0. The corresponding precision is _**P**[Z] ij_[:= (] _**[V]**[Z] ij_[)] _[−]_[1][.] 

Relevance between a query and a key is measured by the squared Mahalanobis distance of the observable residual: 

**==> picture [154 x 14] intentionally omitted <==**

which replaces dot-product similarity with a likelihoodbased consistency test under the SDE prior. 

We estimate the anchor state by minimizing the sum of squared Mahalanobis residuals over all transported observations: 

**==> picture [175 x 24] intentionally omitted <==**

Minimizing the resulting sum of independent negative loglikelihood terms yields the precision-weighted estimator: 

**==> picture [184 x 28] intentionally omitted <==**

We obtain data-dependent weights by reweighting the prior precisions: 

**==> picture [65 x 14] intentionally omitted <==**

3 

**Robust Filter Attention** 

where _wij_ is a scalar weight, whose functional form can be chosen according to the desired properties of the estimator: 

**==> picture [173 x 46] intentionally omitted <==**

where _ν_ is a scalar degrees-of-freedom parameter that governs the tail-weight of the estimator. For efficient implementation, we assume the dynamics are simultaneously diagonalizable by an invertible _**S** ∈_ C _[d][×][d]_ . Under this assumption, the DLE decouples into scalar ODEs, yielding the closed-form solution: 

**==> picture [177 x 13] intentionally omitted <==**

**==> picture [173 x 26] intentionally omitted <==**

The total covariance in the eigenbasis is then: 

**==> picture [219 x 13] intentionally omitted <==**

where **Λ** _**C** ,_ **Λ** _**R** ,_ **ΛΓ** are the diagonalized output and noise matrices. 

The Mahalanobis distance diagonalizes as: 

**==> picture [200 x 30] intentionally omitted <==**

**ˆ** where _**zs**_ = _**S**[−]_[1] _**z**_ and _**zs** ,ij_ = _e_ **[Λ]**[∆] _[t][ij]_ _**zs** ,j_ . 

The estimate in the eigenbasis then becomes: 

**==> picture [199 x 57] intentionally omitted <==**

where _**λ**[Z]_ _**P**_[=][diag(] **[Λ]** _[Z]_ _**P**_[)][,][yielding][head-wise,][dimension-] wise normalized attention weights. 

## **3.2. Robust Filter Attention (RFA) Mechanism** 

We instantiate the robust state estimator as a complex-valued attention layer by identifying the abstract diagonalization matrices with learned linear projections. The input projections _**W Q** ,_ _**W K** ,_ _**W V** ∈_ C _[d][×][d]_ learn the transformation into the SDE’s decoupled eigenbasis, absorbing the inverse diagonalizing matrix _**S**[−]_[1] , while the output matrix _**W O**_ absorbs _**S**_ , mapping the filtered estimates back to the original basis: 

**==> picture [239 x 12] intentionally omitted <==**

To preserve the _O_ ( _N_[2] + _Nd_ ) memory complexity of standard attention, we impose isotropic decay and noise in the learned eigenbasis (per head): 

**==> picture [235 x 12] intentionally omitted <==**

where _ωk ∈_ R, _µ, σ_[2] _, η_[2] _, γ_[2] _∈_ R[+] , and **ΛΩ** _∈_ R _[d][×][d]_ is diagonal. These definitions ensure (marginally) stable dynamics and positive semi-definite noise covariances. 

Under isotropic decay and noise, each eigenmode follows independent exponentially decaying rotations with decay _µ_ and angular frequency _ωk_ . This yields simple element-wise rotation factors for forward/backward propagation, and a decay kernel that depends only on the time lag ∆ _tij_ : 

**==> picture [235 x 15] intentionally omitted <==**

We define rotated queries, keys, and values: 

**==> picture [211 x 12] intentionally omitted <==**

The isotropic constraints cause the variance to become independent of the feature dimension: 

**==> picture [228 x 14] intentionally omitted <==**

Here, _σ_ ˜[2] := _[λ]_ _**C**_[2] 2 _µ[σ]_[2][,] _[η]_[2][,][and] _[ γ]_[2][are learned scalar parame-] ters (per head), corresponding respectively to steady-state process uncertainty, historical measurement noise (keyside), and anchor-point uncertainty at the reference timestep (query-side). 

This allows the Mahalanobis distance for all pairs ( _i, j_ ) to be computed by element-wise multiplying a matrix of scalar precisions _**P**_ ∆ _t_ [ _i, j_ ] := 1 _/_ _**V**_ ∆ _t_ [ _i, j_ ] by the scalar squared residual norms _∥_ _**Rqk**_ [ _i, j_ ] _∥_[2] : 

**==> picture [145 x 15] intentionally omitted <==**

where the _ij_ th residual is: 

**==> picture [129 x 13] intentionally omitted <==**

The squared residual norm decomposes into a query magnitude term, a decayed key magnitude term, and a cross-term containing the complex inner product: 

**==> picture [202 x 38] intentionally omitted <==**

where _∗_ denotes the complex conjugate. 

We use a Student’s _t_ attention logit, which improves robustness to outliers: 

**==> picture [228 x 25] intentionally omitted <==**

4 

**Robust Filter Attention** 

where _κ_ := _[ν]_[+] _d[d]_[.][The attention matrix is then] _**[ A]**_[ =] _**A**_ **[ˆ]** _⊙_ _**E**_ , where: 

**==> picture [125 x 14] intentionally omitted <==**

where _**M**_ causal is a causal mask. 

The filtered estimate _**Z**_ **[¯]** is computed by aggregating the rotated values, rotating the values back into the value frame, and projecting back to the original basis: 

**==> picture [155 x 16] intentionally omitted <==**

RFA’s complex-valued operations can be represented entirely in the real domain, as detailed in Appendix D.1. The complete implementation of the Isotropic RFA mechanism is formalized in Algorithm 1 in Appendix D.3.[1] 

## **3.4. Spectrally Coupled Dynamics (SC-RFA)** 

Standard positional mechanisms such as RoPE employ a fixed frequency bank across all heads, allowing highfrequency oscillations to persist indefinitely. At long horizons, this leads to spectral aliasing, where the lack of attenuation makes it difficult to distinguish between fast and slow dynamics. 

To address this, we introduce Spectrally Coupled RFA (SCRFA), which enforces a frequency-dependent dissipation prior: higher frequencies should decay more rapidly. We partition a global frequency bank Ω monotonically across heads, assigning each head _h_ a spectral band [ _ωh,_ min _, ωh,_ max], and couple the dissipation rate in each head to its maximum frequency: 

**==> picture [69 x 11] intentionally omitted <==**

## **3.3. Dynamical Self-Consistency and Positional Embeddings** 

In RFA, the same decay rate _µ_ governs both signal attenuation under state propagation and the evolution of the precision prior _**P**_ ∆ _t_ . This enforces dynamical self-consistency between how past states are transported and how their reliability is assessed. 

RFA employs a rotate–aggregate–rotate-back structure on the value stream. Values are first mapped into a shared reference frame using **Φ[˜]** _−_ , aggregated in that frame, and then transported back to the query frame via **Φ[˜]** +. This alignment is required for the aggregation to correspond to a valid fusion of latent state estimates under the shared dynamical model; without it, values would be combined in mismatched temporal coordinates, breaking the interpretation of the update as a coherent state estimate. 

Several common positional embeddings arise as limiting cases of this formulation (see Appendix B.4). In the deterministic zero-decay limit ( _µ_ = 0, _σ_[2] = 0), state evolution reduces to pure rotations, recovering the geometry of Rotary Positional Embeddings (RoPE). In the zero-decay, smalllag regime, the logarithm of the DLE-predicted precision yields an approximately linear distance penalty, recovering the additive bias structure of ALiBi. 

The relative magnitudes of measurement noise ( _η_[2] ) and steady-state process uncertainty ( _σ_ ˜[2] ) determine the effective filtering regime of each head. Heads may specialize into an **integrative regime** , where early measurements are unreliable and precision increases after short lags as the latent state stabilizes, or a **diffusive regime** , where recent observations dominate and uncertainty progressively suppresses distant history. This allows different heads to specialize in distinct filtering regimes under the same attention expression. 

> 1A multi-head implementation is available at https:// github.com/PCR-git/Robust-Filter-Attention. 

where _b ∈_ R[+] is a shared damping ratio. 

This coupling imposes an inverse relationship between spectral resolution and temporal persistence. High-frequency heads act as sharp, short-range filters, while low-frequency heads behave as stable long-range integrators. The resulting multi-resolution prior stabilizes long-range phase behavior while preserving local expressiveness. 

## **4. Experimental Evaluation and Ablations** 

We evaluate whether explicitly modeling uncertainty growth improves long-context stability while preserving short-range accuracy, comparing RFA against two widely used positional baselines derived from deterministic geometry (RoPE) (Su et al., 2024) and monotonic biasing (ALiBi) (Press et al., 2022), respectively. 

## **4.1. Experimental Setup** 

**Architecture:** All models use a 6-layer Transformer with _h_ = 8 heads and embedding dimension _d_ = 256. To ensure comparable model capacity, we apply identical _d →_ 2 _d → d_ projections in both RFA and the RoPE/ALiBi baselines. RFA introduces only a small number of additional scalar parameters per head for noise and robustness, increasing total parameter count by approximately 0.02%. We employ a pre-norm architecture with an FFN expansion factor of 4. Models are trained for 15 epochs using Adam with a cosine learning rate schedule. 

**Datasets.** We evaluate on WikiText-103, a large-scale wordlevel language modeling benchmark derived from Wikipedia articles and used to measure perplexity and long-context extrapolation (Merity et al., 2017), and on BabyLM-2025 (Strict), a curated English language modeling corpus used as a complementary benchmark under the same training and evaluation protocol (Charpentier et al., 2025). 

5 

**Robust Filter Attention** 

_Table 1._ Long-context extrapolation on WikiText-103 (Test PPL). All models were trained with a fixed context window of 512 tokens. 

|**Model**|**L=512**|**L=1024 **|**L=2048 **|**L=4096**|
|---|---|---|---|---|
|RoPE (B1)<br>ALiBi (B2)<br>Decayed RoPE (B3)|28.48<br>28.59<br>28.52|30.94<br>27.30<br>29.42|44.21<br>**26.54**<br>34.68|72.69<br>**26.30**<br>44.00|
|SC-RoPE (B4)|28.36|29.02|34.99|44.17|
|RFA (M1)|28.01|27.58|29.99|38.46|
|**SC-RFA (M2)**<br>**27.54**<br>_Structural Ablations (Relative to_<br>Gaussian NLL (M2.1)<br>27.98<br>Flat Prior (M2.2)<br>27.69<br>No Mult. Gate (M2.3)<br>27.65<br>No Value Rot. (M2.4)<br>30.24||**26.73**<br>_M2)_<br>27.16<br>28.71<br>29.01<br>92.08|29.46<br>28.95<br>38.11<br>39.18<br>187.29|37.19<br>33.51<br>62.83<br>57.30<br>463.29|
|No Rotations (M2.5)|28.58|27.25|26.61|26.83|
|Pure Rotation (M2.6)|27.97|35.59|69.39|131.29|



Full architectural details and detailed descriptions of all model variants are provided in Appendix E. Analysis of attention maps and noise parameters are provided in Appendix F. 

## **4.2. Results on Wikitext-103** 

We evaluate extrapolation by measuring test perplexity on WikiText-103 at increasing context lengths _L ∈ {_ 512 _,_ 1024 _,_ 2048 _,_ 4096 _}_ , after training all models with a fixed context window of 512 tokens. We compare against standard positional baselines (RoPE, ALiBi), and include two geometry-only decay variants to isolate the effect of damping in rotational embeddings: Decayed RoPE (B3), which applies exponential decay with distance, as in RFA, and SC-RoPE (B4), which couples decay rates to head-wise frequency bands as in SC-RFA. These baselines test whether decay and spectral coupling alone can explain extrapolation gains, without modeling uncertainty. 

We evaluate RFA (M1) and SC-RFA (M2), along with structural ablations relative to M2, designed to isolate the effect of its components when removed: the robust weight (M2.1); the DLE-derived precision prior (M2.2); the multiplicative gating term (M2.3); value rotations (M2.4); all rotations (M2.5); finally, we test a purely rotational, zero dissipation and noise noise variant, analogous to RoPER (M2.6). Results are shown in Table 1. 

RFA variants achieve both stronger local performance and improved extrapolation relative to RoPE. In particular, SCRFA (M2) improves over RoPE by 0 _._ 94 PPL at _L_ = 512 and reduces degradation at long horizons, reaching 37 _._ 19 PPL at _L_ = 4096 compared to RoPE’s 72 _._ 69. This behavior emerges under a fixed training protocol without requiring length-dependent scaling rules or curriculum schedules. 

Introducing decay into rotational embeddings (B3) and spectrally coupling decay across heads (B4) slows the long-range degradation of RoPE. However, both geometry-only variants under-perform RFA across all context lengths, indicating that decay alone is insufficient without explicit uncertainty modeling. 

Compared to ALiBi, SC-RFA achieves lower perplexity at the training length ( _L_ = 512) and at moderate extrapolation ( _L_ = 1024), suggesting improved utilization of fine-grained temporal structure when uncertainty remains bounded. At longer horizons, ALiBi attains lower perplexity by enforcing strong locality, while SC-RFA continues to integrate distant context with attenuated but nonzero precision. This reflects a trade-off between aggressive locality and uncertainty-weighted long-range integration. 

The non-robust variant (M2.1) exhibits a different tradeoff: it under-performs the robust estimator at the training horizon, but achieves lower perplexity at extreme extrapolation lengths. This is consistent with Gaussian likelihoods imposing stronger quadratic penalties on residuals, which suppress extreme deviations more aggressively but reduce sensitivity to small errors when uncertainty is low. 

Removing the DLE-derived precision prior (M2.2) leads to degradation at long horizons, with perplexity increasing to 62 _._ 83 at _L_ = 4096, indicating that representing uncertainty is necessary to control the influence of distant tokens. Removing the multiplicative gating term (M2.3) causes degradation within the training window and worsens extrapolation, suggesting that both the additive and multiplicative precision terms contribute to stability. 

Eliminating value-space rotation and counter-rotation (M2.4) causes severe degradation at long context, reaching 463 _._ 29 PPL at _L_ = 4096. This is consistent with aggregation no longer corresponding to fusion of latent state estimates in a shared temporal frame. Removing all rotations (M2.5) degrades short-context performance but yields strong long-range stability. 

In the zero-noise, zero-decay, pure rotational limit (M2.6), perplexity increases sharply with context length, reflecting the accumulation of unattenuated high-frequency components from distant tokens. This supports the necessity of dissipation to prevent long-range spectral interference in rotational attention mechanisms. 

Table 2 analyzes the effect of the damping coefficient _b_ in SC-RFA. Smaller values of _b_ yield slower decay, improving short-context performance but leading to faster degradation as context increases. Larger values of _b_ produce stronger attenuation and more stable long-range behavior at the cost of reduced short-range precision. Notably, for sufficiently strong damping (e.g., _b_ = 5 _×_ 10 _[−]_[1] ), SC-RFA outperforms ALiBi at intermediate horizons ( _L_ = 2048), with ALiBi 

6 

**Robust Filter Attention** 

_Table 2._ Sensitivity Analysis of the Damping Coefficient _b_ in SC-RFA (M2). Results show Test PPL on WikiText-103 across increasing context lengths. 

|**Damping (**_b_**)**|**L=512**|**L=1024**|**L=2048**|**L=4096**|
|---|---|---|---|---|
|5_×_10_−_4|27.60|28.88|37.34|51.48|
|5_×_10_−_3|27.60|28.71|35.35|43.90|
|5_×_10_−_2|**27.54**|26.73|29.46|37.19|
|5_×_10_−_1|27.61|**26.38**|**26.37**|29.72|
|5_×_100|27.91|26.68|**26.37**|**28.16**|



_Table 3._ Long-context extrapolation on BabyLM-2025 (Test PPL). All models were trained with a fixed context window of 512 tokens. 

|**Model**|**L=512**|**L=1024**|**L=2048**|**L=4096**|
|---|---|---|---|---|
|RoPE (B1)<br>ALiBi (B2)|17.70<br>17.70|18.78<br>17.20|23.33<br>**17.06**|33.29<br>**17.51**|
|RFA (M1)|17.51|17.71|20.61|31.04|
|**SC-RFA (M2)**|**17.36**|**16.99**|18.33|22.25|



retaining an advantage only at the largest tested context length. This behavior is consistent with _b_ acting as a global timescale parameter that controls how rapidly past information is discounted, yielding a predictable stability–resolution trade-off. 

## **4.3. Results on BabyLM-2025** 

We use the same architectures, hyperparameters, and training protocol as on WikiText-103. 

On BabyLM-2025, where language modeling performance is more strongly dominated by short-range context, differences between positional mechanisms are smaller at short context lengths. Both RFA variants outperform RoPE at all evaluated context lengths and outperform ALiBi within the training window. SC-RFA also achieves lower perplexity than ALiBi at intermediate context ( _L_ = 1024), while ALiBi remains strongest at the largest horizons due to its strict locality bias. Overall, these results mirror the tradeoff observed on WikiText-103: uncertainty-aware precision weighting improves robustness over purely rotational embeddings while retaining stronger short- and mid-range performance than aggressively local positional biases. 

## **4.4. Learning Dynamics and Head Specialization** 

RFA variants converge faster and achieve lower validation perplexity earlier in training than RoPE and ALiBi, indicating that the SDE-based prior provides an effective inductive bias for latent state estimation (Appendix F.1). Analysis of learned noise, decay, and robustness parameters reveals systematic head specialization into distinct uncertainty and selectivity regimes, with different heads converging to dif- 

ferent tolerances for temporal inconsistency and noise (Appendix F.2). 

Attention map visualizations at long context lengths further reveal an emergent integrative regime in low-decay heads, where recent tokens are initially downweighted and historical states receive increasing emphasis as uncertainty stabilizes (Appendix F). Spectral coupling in SC-RFA substantially alters long-range attention structure: compared to RFA and RoPE, heads exhibit fewer and sharper periodic bands, reduced checkerboard aliasing, and clearer separation between local and long-range interactions (Appendix F). Together, these diagnostics support the interpretation of RFA as learning uncertainty-aware temporal filtering rather than relying solely on geometric positional bias. 

## **5. Conclusion** 

We show that self-attention can be reformulated as a tractable precision-weighted state estimator under a linear time-invariant SDE prior. This yields Robust Filter Attention (RFA), a dynamically consistent and uncertainty-aware generalization of standard attention. RFA preserves the asymptotic complexity of standard attention while propagating uncertainty through linear dynamics and performing robust Mahalanobis reweighting, improving both in-window performance and long-context stability. We show that rotary and linear bias positional embeddings can be recovered as limiting cases of this filtering formulation. We also introduce SC-RFA, which enforces frequency-dependent dissipation and further improves performance by separating shortand long-range temporal structure across heads. 

Future work should examine whether RFA’s simplifying assumptions—such as isotropic noise and simultaneously diagonalizable dynamics—can be relaxed while maintaining computational tractability. Another promising direction is to characterize the relationship between filtering-based formulations of attention and recurrent state-space models, and to study how these perspectives interact with normalization, residual connections, and depth in Transformers. 

## **Impact Statement** 

This work provides a method for uncertainty propagation in attention-based models. We do not identify any ethical concerns beyond those generally associated with advances in machine learning methodology. 

## **References** 

Bianchessi, A. S., Aguirre, Y. C., Barros, R. C., and Kupssinsku,¨ L. S. Bayesian attention mechanism: A probabilistic framework for positional encoding and context length extrapolation, 2025. URL https://arxiv. 

7 

**Robust Filter Attention** 

org/abs/2505.22842. 

- Bui, L. M., Huu, T. T., Dinh, D., Nguyen, T. M., and Hoang, T. N. Revisiting kernel attention with correlated Gaussian process representation. In _Proceedings of the Fortieth Conference on Uncertainty in Artificial Intelligence_ , UAI ’24. JMLR.org, 2024. 

- Charpentier, L., Choshen, L., Cotterell, R., Gul, M. O., Hu, M. Y., Liu, J., Jumelet, J., Linzen, T., Mueller, A., Ross, C., Shah, R. S., Warstadt, A., Wilcox, E. G., and Williams, A. Findings of the third BabyLM challenge: Accelerating language modeling research with cognitively plausible data. In Charpentier, L., Choshen, L., Cotterell, R., Gul, M. O., Hu, M. Y., Liu, J., Jumelet, J., Linzen, T., Mueller, A., Ross, C., Shah, R. S., Warstadt, A., Wilcox, E. G., and Williams, A. (eds.), _Proceedings of the First BabyLM Workshop_ , pp. 399–420, Suzhou, China, November 2025. Association for Computational Linguistics. doi: 10.18653/v1/2025. babylm-main.28. URL https://aclanthology. org/2025.babylm-main.28/. 

- Chen, C., Geng, H., Yang, N., Yan, J., Xue, D., Yu, J., and Yang, X. Learning self-modulating attention in continuous time space with applications to sequential recommendation. In Meila, M. and Zhang, T. (eds.), _Proceedings of the 38th International Conference on Machine Learning_ , volume 139 of _Proceedings of Machine Learning Research_ , pp. 1606–1616. PMLR, 18–24 Jul 2021. URL https://proceedings.mlr.press/ v139/chen21h.html. 

- Chen, R. T. Q., Rubanova, Y., Bettencourt, J., and Duvenaud, D. Neural ordinary differential equations. In _Proceedings of the 32nd International Conference on Neural Information Processing Systems_ , NIPS’18, pp. 6572–6583, Red Hook, NY, USA, 2018. Curran Associates Inc. 

- Chien, J.-T. and Chen, Y.-H. Continuous-time self-attention in neural differential equation. In _ICASSP 2021 - 2021 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)_ , pp. 3290–3294, 2021. doi: 10.1109/ICASSP39728.2021.9414104. 

- Cohen, N. and Klein, I. Adaptive Kalman-informed Transformer. _Engineering Applications of Artificial Intelligence_ , 146:110221, April 2025. ISSN 0952-1976. doi: 10. 1016/j.engappai.2025.110221. URL http://dx.doi. org/10.1016/j.engappai.2025.110221. 

- Dao, T. and Gu, A. Transformers are SSMs: generalized models and efficient algorithms through structured state space duality. In _Proceedings of the 41st International Conference on Machine Learning_ , ICML’24. JMLR.org, 2024. 

- Gabbur, P., Bilkhu, M., and Movellan, J. Probabilistic attention for interactive segmentation. In Beygelzimer, A., Dauphin, Y., Liang, P., and Vaughan, J. W. (eds.), _Advances in Neural Information Processing Systems_ , 2021. URL https://openreview.net/forum? id=JpDlWGTBHB. 

- Goel, G. and Bartlett, P. Can a Transformer represent a Kalman filter? In Abate, A., Cannon, M., Margellos, K., and Papachristodoulou, A. (eds.), _Proceedings of the 6th Annual Learning for Dynamics &; Control Conference_ , volume 242 of _Proceedings of Machine Learning Research_ , pp. 1502–1512. PMLR, 15–17 Jul 2024. URL https://proceedings.mlr.press/ v242/goel24a.html. 

- Gu, A. and Dao, T. Mamba: Linear-time sequence modeling with selective state spaces. In _First Conference on Language Modeling_ , 2024. URL https://openreview. net/forum?id=tEYskw1VY2. 

- Gu, A., Dao, T., Ermon, S., Rudra, A., and Re, C.´ HiPPO: recurrent memory with optimal polynomial projections. In _Proceedings of the 34th International Conference on Neural Information Processing Systems_ , NIPS ’20, Red Hook, NY, USA, 2020. Curran Associates Inc. ISBN 9781713829546. 

- Gu, A., Goel, K., and Re, C. Efficiently modeling long sequences with structured state spaces. In _International Conference on Learning Representations_ , 2022. URL https://openreview.net/forum? id=uYLFoz1vlAC. 

- Han, X., Ren, T., Nguyen, T. M., Nguyen, K., Ghosh, J., and Ho, N. Designing robust Transformers using robust kernel density estimation. In _Thirty-seventh Conference on Neural Information Processing Systems_ , 2023. URL https: //openreview.net/forum?id=BqTv1Mtuhu. 

- Harik, G. Rotary positional embeddings with relative distance (RoPER). https://research.labml.ai/ RoPER.html, 2023. Online implementation and derivation via labml.ai. 

- Jahanshahi, H. and Zhu, Z. H. Uncertainty propagation networks for neural ordinary differential equations, 2025. URL https://arxiv.org/abs/2508.16815. 

- Jhin, S. Y., Jo, M., Kong, T., Jeon, J., and Park, N. ACENODE: Attentive co-evolving neural ordinary differential equations. In _Proceedings of the 27th ACM SIGKDD Conference on Knowledge Discovery & Data Mining_ , KDD ’21, pp. 736–745, New York, NY, USA, 2021. Association for Computing Machinery. ISBN 9781450383325. doi: 10.1145/3447548.3467419. URL https://doi. org/10.1145/3447548.3467419. 

8 

**Robust Filter Attention** 

- Kim, H., Mnih, A., Schwarz, J., Garnelo, M., Eslami, A., Rosenbaum, D., Vinyals, O., and Teh, Y. W. Attentive neural processes. In _International Conference on Learning Representations_ , 2019. URL https:// openreview.net/forum?id=SkE6PjC9KX. 

- Li, X., Wong, T.-K. L., Chen, R. T. Q., and Duvenaud, D. K. Scalable gradients and variational inference for stochastic differential equations. In Zhang, C., Ruiz, F., Bui, T., Dieng, A. B., and Liang, D. (eds.), _Proceedings of The 2nd Symposium on Advances in Approximate Bayesian Inference_ , volume 118 of _Proceedings of Machine Learning Research_ , pp. 1–28. PMLR, 08 Dec 2020. URL https://proceedings.mlr.press/ v118/li20a.html. 

- Liu, H., Lu, J., Zhao, X., Xu, S., Peng, H., Liu, Y., Zhang, Z., Li, J., Jin, J., Bao, Y., and Yan, W. Kalman filtering attention for user behavior modeling in CTR prediction. In _Proceedings of the 34th International Conference on Neural Information Processing Systems_ , NIPS ’20, Red Hook, NY, USA, 2020. Curran Associates Inc. ISBN 9781713829546. 

- Liu, W., Lai, Z., Bacsa, K., and Chatzi, E. Neural extended Kalman filters for learning and predicting dynamics of structural systems. _Structural Health Monitoring_ , 23(2): 1037–1052, June 2023. ISSN 1741-3168. doi: 10.1177/ 14759217231179912. URL http://dx.doi.org/ 10.1177/14759217231179912. 

- Merity, S., Xiong, C., Bradbury, J., and Socher, R. Pointer sentinel mixture models. In _International Conference on Learning Representations_ , 2017. URL https:// openreview.net/forum?id=Byj72udxe. 

- Movahedi, S., Carstensen, T., Afzal, A., Hutter, F., Orvieto, A., and Cevher, V. Selective rotary position embedding. _CoRR_ , abs/2511.17388, November 2025. URL https: //doi.org/10.48550/arXiv.2511.17388. 

- Nielsen, S., Abdullaev, L., Teo, R., and Nguyen, T. M. Elliptical attention. In _The Thirty-eighth Annual Conference on Neural Information Processing Systems_ , 2024. URL https://openreview.net/forum? id=Ejg4d4FVrs. 

- Peng, B., Quesnelle, J., Fan, H., and Shippole, E. YaRN: Efficient context window extension of large language models. In _The Twelfth International Conference on Learning Representations_ , 2024. URL https://openreview. net/forum?id=wHBfxhZu1u. 

- Press, O., Smith, N., and Lewis, M. Train short, test long: Attention with linear biases enables input length extrapolation. In _International Conference on Learning Representations_ , 2022. URL https://openreview.net/ forum?id=R8sQPpGCv0. 

- Revach, G., Shlezinger, N., Ni, X., Escoriza, A. L., van Sloun, R. J. G., and Eldar, Y. C. KalmanNet: Neural network aided Kalman filtering for partially known dynamics. _IEEE Transactions on Signal Processing_ , 70: 1532–1547, 2022. ISSN 1941-0476. doi: 10.1109/ tsp.2022.3158588. URL http://dx.doi.org/10. 1109/TSP.2022.3158588. 

- Shen, M. and Cheng, C. Neural SDEs as a unified approach to continuous-domain sequence modeling, 2025. URL https://arxiv.org/abs/2501.18871. 

- Shen, S., Chen, J., Yu, G., Zhai, Z., and Han, P. KalmanFormer: using Transformer to model the Kalman gain in Kalman filters. _Frontiers in Neurorobotics_ , 18:1460255, 2025. doi: 10.3389/fnbot.2024.1460255. URL https: //doi.org/10.3389/fnbot.2024.1460255. 

- Su, J., Ahmed, M., Lu, Y., Pan, S., Bo, W., and Liu, Y. RoFormer: Enhanced transformer with rotary position embedding. _Neurocomput._ , 568(C), February 2024. ISSN 0925-2312. doi: 10.1016/j.neucom. 2023.127063. URL https://doi.org/10.1016/ j.neucom.2023.127063. 

- Sun, Y., Dong, L., Huang, S., Ma, S., Xia, Y., Xue, J., Wang, J., and Wei, F. Retentive Network: A successor to Transformer for large language models, 2023a. URL https://arxiv.org/abs/2307.08621. 

- Sun, Y., Dong, L., Patra, B., Ma, S., Huang, S., Benhaim, A., Chaudhary, V., Song, X., and Wei, F. A lengthextrapolatable Transformer. In Rogers, A., Boyd-Graber, J., and Okazaki, N. (eds.), _Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)_ , pp. 14590–14604, Toronto, Canada, July 2023b. Association for Computational Linguistics. doi: 10.18653/v1/2023.acl-long. 816. URL https://aclanthology.org/2023. acl-long.816/. 

- Tsai, Y.-H. H., Bai, S., Yamada, M., Morency, L.-P., and Salakhutdinov, R. Transformer dissection: A unified understanding for Transformer’s attention via the lens of kernel. In Inui, K., Jiang, J., Ng, V., and Wan, X. (eds.), _Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing and the 9th International Joint Conference on Natural Language Processing (EMNLP-IJCNLP)_ , pp. 4344–4353, Hong Kong, China, November 2019. Association for Computational Linguistics. doi: 10.18653/v1/D19-1443. URL https://aclanthology.org/D19-1443/. 

- Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, L. u., and Polosukhin, I. Attention is all you need. In Guyon, I., Luxburg, U. V., Bengio, S., Wallach, H., Fergus, R., Vishwanathan, S., 

9 

**Robust Filter Attention** 

and Garnett, R. (eds.), _Advances in Neural Information Processing Systems_ , volume 30. Curran Associates, Inc., 2017. URL https://proceedings.neurips. cc/paper_files/paper/2017/file/ 3f5ee243547dee91fbd053c1c4a845aa-Paper. pdf. 

Veisi, A., Fartoot, D., and Amirzadeh, H. Context-aware rotary position embedding, 2025. URL https://arxiv. org/abs/2507.23083. 

Wang, J., Geng, X., and Xu, J. Nonlinear Kalman filtering based on self-attention mechanism and lattice trajectory piecewise linear approximation, 2024. URL https: //arxiv.org/abs/2404.03915. 

10 

**Robust Filter Attention** 

## **Appendix Table of Contents** 

1. **Appendix A: Attention as Parallelized Robust State Estimation** 12 

||• _Derives self-attention as parallel robust state estimation under a linear SDE prior with analytically propagated_|
|---|---|
||_uncertainty._|
|2.|**Appendix B: Robust Filter Attention Mechanism**<br>19|
||• _Derives the transition from the full anisotropic tensor formulation of RFA to the scalable isotropic variant. Also_|
||_provides a physical interpretation of common positional embeddings, showing how RoPE and ALiBi arise as_|
||_limiting cases of the RFA framework._|
|3.|**Appendix C: Model Extensions**<br>26|
||• _Describes extensions including Spectrally-Coupled RFA, inhomogeneous drift, and a confdence-based information_|
||_fusion gate._|
|4.|**Appendix D: Implementation Details**<br>31|



||• _Provides the complex-to-real isomorphism for hardware-effcient computation and full pseudocode for the isotropic_|• _Provides the complex-to-real isomorphism for hardware-effcient computation and full pseudocode for the isotropic_|
|---|---|---|
||_RFA layer._||
|5.|**Appendix E: Experimental Details and Ablations**|34|
||• _Defnes all ablation variants, training setup, and hyperparameters._||
|6.|**Appendix F: Additional Experimental Results**|36|



- _Analyzes learned noise parameters, head specialization, and long-context attention maps to illustrate how RFA implements multi-scale filtering behavior in practice._ 

11 

**Robust Filter Attention** 

## **A. Attention as Parallel State Estimation.** 

We interpret attention as a parallel state estimation procedure under a shared linear dynamical prior. Rather than defining a single global generative model for the entire sequence, the SDE acts as a local prior at each anchor position: it specifies how other tokens are transported to that anchor time and how uncertainty grows with temporal separation. Under this view, each token provides a noisy, dynamically transported prediction of the anchor state, and attention aggregates these predictions in a precision-weighted manner. 

We first review how uncertainty propagates under a linear SDE. We then show how this yields a pairwise consistency score between tokens based on predicted residual variance. Next, we derive attention as a parallel precision-weighted estimator of the anchor state under a conditional independence approximation. Finally, we apply robust M-estimation to obtain data-dependent reweighting of these precision terms. 

## **A.1. Propagation of Uncertainty Through a Linear SDE** 

We consider a linear time-invariant Ito SDE as a shared prior over latent representations, used to define how uncertainty andˆ similarity propagate across time, with latent state _**x**_ ( _t_ ) and observations _**z** i_ : 

**==> picture [238 x 11] intentionally omitted <==**

where _d_ _**w**_ ( _t_ ) is standard Wiener noise, _**v**_ ( _ti_ ) is measurement noise, and _**C**_ is assumed to be invertible. Our aim is to estimate the latent trajectory _{_ _**x** i}[N] i_ =1[from the sequence of noisy measurements] _[ {]_ _**[z]**[j][}][N] j_ =1[.][Since] _**[ C]**_[is invertible, this is equivalent to] estimating _**z**[C] i_[:=] _**[ Cx]**_[(] _[t][i]_[)][, and we work in this space for convenience.] 

## A.1.1. STATE PROPAGATION AND COVARIANCE ACCUMULATION 

For a past measurement at _tj_ and a target time _ti_ , letting ∆ _tij_ = _ti − tj_ , the conditional mean at time _ti_ given _**x**_ ( _tj_ ) under the linear dynamics is: 

**==> picture [81 x 13] intentionally omitted <==**

This defines how a past latent state is transported into the reference frame of time _ti_ under the shared dynamics. The accumulated process noise over ∆ _tij_ is given by the state covariance: 

**==> picture [211 x 26] intentionally omitted <==**

which satisfies the differential Lyapunov equation (DLE): 

**==> picture [206 x 22] intentionally omitted <==**

The propagated state is Gaussian: 

**==> picture [111 x 13] intentionally omitted <==**

Thus, the uncertainty of the conditional mean grows or contracts with temporal separation depending on the values of _**A**_ and _**Q**_ . Backward propagation from a future measurement ( _tj > ti_ , i.e. the non-causal case) may be defined analogously via: 

**==> picture [163 x 14] intentionally omitted <==**

yielding the same Gaussian form with covariance _**V** B_ (∆ _tij_ ). 

## A.1.2. MEASUREMENT COVARIANCE AND PRECISION 

RFA requires the estimate of the current measurement _**z**[C] i_[=] _**[ Cx]**_[(] _[t][i]_[)][ given a past measurement] _**[ z]**[j]_[.][We define a “pulled-] forward” (conditional mean) measurement as: 

**==> picture [219 x 14] intentionally omitted <==**

This represents how a past observed token is mapped into the coordinate system of the target time step before comparison or aggregation. 

12 

**Robust Filter Attention** 

The total propagated measurement covariance combines (i) accumulated process noise between _tj_ and _ti_ , and (ii) the measurement noise of the source token propagated through the dynamics: 

**==> picture [228 x 13] intentionally omitted <==**

The measurement estimate is thus Gaussian: 

**==> picture [109 x 14] intentionally omitted <==**

Figure 1 illustrates state propagation and uncertainty in a stable LTI. 

**==> picture [293 x 259] intentionally omitted <==**

_Figure 1._ Illustration of uncertainty aggregation in a stable two-dimensional LTI SDE model. The true trajectory is shown in black. For five target points _ti_ , the plot visualizes the ensemble of estimates ˆ _**z** ij_ mapped through the deterministic transition _e_ **[A]**[∆] _[t][ij]_ from all other noisy measurements ( _j_ = _i_ ). The ellipses are centered at the precision-weighted average and scaled by the total posterior covariance ([�] _j_ _**[P]**[ C] ij_[)] _[−]_[1][, representing the estimate’s uncertainty.][Under stable dynamics, forward propagation (causal) acts as a dissipative filter that] attenuates historical noise, while backward propagation (non-causal) amplifies measurement error as the system is integrated against its natural stability. 

## **A.2. Analytical Solution of the Differential Lyapunov Equation (DLE)** 

For parallel aggregation across all token pairs, we must construct the pairwise propagated precision kernel _**P**[C]_ (∆ _tij_ ) for all _i, j ∈_ [1 _, N_ ]. To obtain an analytically tractable solution, we assume the system matrices are simultaneously diagonalizable by an invertible _**S** ∈_ C _[d][×][d]_ , where _**A**_ = _**S**_ **Λ** _**S**[−]_[1] and _**Q**_ = _**S**_ **Λ** _**QS**[†]_ . This assumption corresponds to learning dynamics in a basis of decoupled modes. 

The forward-propagated state covariance, _**V**_ (∆ _tij_ ), is the solution to the DLE (Equation 2): 

**==> picture [139 x 26] intentionally omitted <==**

Transforming to the eigenbasis, the covariance becomes: 

**==> picture [115 x 13] intentionally omitted <==**

13 

**Robust Filter Attention** 

where each diagonal entry of **Λ** _**V**_ (∆ _tij_ ) satisfies the scalar integral: 

**==> picture [271 x 26] intentionally omitted <==**

(where **Λ** _**V**_ = diag( _λ_ _**V**_ ) and **Λ** _**Q**_ = diag( _λ_ _**Q**_ )). Each mode accumulates noise according to its real decay rate Re( _λk_ ). Modes with weak decay accumulate uncertainty rapidly over time, while strongly damped modes suppress long-range contributions. 

Evaluating this integral yields the analytical solution _φ_ ( _λ, λ_ _**Q** ,_ ∆ _t_ ) (for the causal case): 

**==> picture [209 x 66] intentionally omitted <==**

## **A.3. The Measurement Residual and its Covariance** 

In RFA, the interaction between a query and a key is a statistical comparison between the observer’s current state and a past observation propagated through the latent dynamics. We observe a noisy query embedding: 

**==> picture [153 x 13] intentionally omitted <==**

and define the measurement residual: 

**==> picture [103 x 13] intentionally omitted <==**

which measures disagreement after removing the deterministic evolution predicted by the SDE. Unlike dot-product attention, which compares embeddings in a static feature space, RFA evaluates consistency in the dynamical reference frame of the observer. 

Hence, the covariance of the residual consists of two contributions: 

**==> picture [207 x 28] intentionally omitted <==**

In a global LTI generative model, the same measurement noise would apply to both historical and current observations, i.e. _**R**_ = _**R**_ **Γ** . Since we instead treat each anchor position as a local estimation problem, we allow the uncertainty of transported observations and the uncertainty of the anchor observation to be modeled separately. The observer noise ensures that precision remains bounded as ∆ _t →_ 0, reflecting that even perfectly aligned observations are limited by the observer’s own uncertainty. 

The residual is distributed as: 

**==> picture [101 x 14] intentionally omitted <==**

Assuming simultaneous diagonalization of the measurement parameters, _**C**_ = _**S**_ **Λ** _**CS**[−]_[1] , _**R**_ = _**S**_ **Λ** _**RS**[†]_ , _**R**_ **Γ** = _**S**_ **ΛΓ** _**S**[†]_ , the total covariance decouples in the eigenbasis: 

**==> picture [121 x 14] intentionally omitted <==**

The diagonal matrix **Λ** _[Z]_ _**V**_[(∆] _[t][ij]_[)][ is then:] 

**==> picture [238 x 13] intentionally omitted <==**

This is bounded for all ∆ _tij_ in the causal direction if and only if every component of Re( **Λ** ) is negative, i.e., the dynamics are stable. 

The required residual precision matrix, _**P**[Z]_ (∆ _tij_ ), is then obtained by diagonal inversion in the eigenbasis: 

**==> picture [279 x 15] intentionally omitted <==**

14 

**Robust Filter Attention** 

**Isotropic Case** In particular, consider the isotropic case _**A**_ = _−µ_ _**I**_ + **Ω** _∈_ R _[d][×][d]_ where _µ ∈_ R[+] and **Ω** _∈_ R _[d][×][d]_ is diagonalizable over C, and has strictly imaginary eigenvalues, i.e. **Ω** = _**S**_ **Λ** Ω _**S**[−]_[1] , where _**S** ∈_ C _[d][×][d]_ , **Λ** Ω = diag( _λ_ Ω _,_ 1 _, . . . λ_ Ω _,d_ ), with _λ_ Ω _,k ∈ i_ R. If we also assume that the process and measurement noise are isotropic, **Λ** _Q_ = _σ_[2] _**I**_ , **Λ** _R_ = _η_[2] _**I**_ , **Λ** Γ = _γ_[2] _**I**_ , and **Λ** _C_ = _λC_ _**I**_ . Then: 

**==> picture [341 x 25] intentionally omitted <==**

Collecting terms, we can express the kernel in the form: 

**==> picture [93 x 12] intentionally omitted <==**

where: 

**==> picture [218 x 25] intentionally omitted <==**

As _τ →∞_ , the variance saturates at the total uncertainty floor _β_ . The sign of _α_ dictates the qualitative evolution of the observer’s uncertainty: 

- **Integrative (Denoising) Regime (** _α >_ 0 **):** Occurs when the initial measurement noise is high _η_[2] _> σ_ ˜[2] . The variance decays from its initial peak toward the equilibrium floor _β_ , representing a system that “settles” into a more reliable latent state as transient measurement noise is filtered out by the stable dynamics. 

- **Diffusive (Forgetting) Regime (** _α <_ 0 **):** Occurs when steady-state process uncertainty exceeds the measurement noise variance: _σ_ ˜[2] _> η_[2] . As the temporal lag _τ_ increases, the variance grows toward the steady-state floor _β_ , representing the “blurring” of historical information. 

In the integrative regime, zero process noise is statistically equivalent to larger measurement noise, since both produce the same steady-state uncertainty, so the noise decomposition becomes non-identifiable. The utility of modeling process noise is that it allows a model to learn to represent the diffusive regime. 

**The Mahalanobis Distance** To evaluate residuals under this conditional model, we use the Mahalanobis distance _d_[2] _ij_[,] which normalizes the error by the total propagated covariance _**V**[Z] ij_[:] 

**==> picture [73 x 14] intentionally omitted <==**

This measures the size of the residual relative to the uncertainty predicted by the SDE prior. Large values indicate that the propagated observation is statistically inconsistent with the anchor state, given the uncertainty accumulated over ∆ _tij_ . 

## **A.4. Local Conditional Estimation Under Observable Residual Noise** 

Under the linear SDE prior, the exact likelihood of the full measurement sequence induces dense temporal correlations, requiring sequential inference (e.g., Kalman filtering). To obtain a parallel estimator, we approximate the likelihood by treating transported observations as conditionally independent given the latent anchor state _**z**[C] i_[:] 

**==> picture [212 x 24] intentionally omitted <==**

which ignores cross-covariances induced by shared process noise. 

Rather than explicitly estimating the latent anchor state _**z**[C] i_[, we instead evaluate the marginal likelihood of the observable] ˆ residuals _**r** ij_ = _**z** i −_ _**z** ij._ Since _**z** i_ and ˆ _**z** ij_ are, by assumption, independent noisy observations of the same latent state, the residual is distributed as: 

**==> picture [227 x 21] intentionally omitted <==**

where _**P**[Z] ij_[denotes the precision of the observable residual.] 

15 

**Robust Filter Attention** 

We then seek an estimate ¯ _**z** i_ that minimizes the sum of squared Mahalanobis distances: 

**==> picture [181 x 24] intentionally omitted <==**

Setting the gradient to zero yields the precision-weighted batch estimator: 

**==> picture [134 x 28] intentionally omitted <==**

This reduction enables parallel _O_ ( _N_[2] ) aggregation. 

**Remark on Approximation Validity.** The conditional independence approximation is supported by the SDE dynamics in two complementary limits, defined by the ratio of steady-state process uncertainty to measurement noise, _R_ := _σ_ ˜[2] _/η_[2] . **Integrative Limit (** _R ≪_ 1 **).** Strong dissipation and low process noise suppress cross-temporal correlations. **Diffusive Limit (** _R ≫_ 1 **).** Although temporal correlations increase, the marginal precisions _**P**[Z] ij_[decay rapidly with temporal] lag as uncertainty accumulates. This induces an implicit self-regularization: distant tokens—those for which independence is least accurate—receive negligible weight under the SDE prior. 

## **A.5. Robust State Estimation** 

The estimator in Section A.4 weights each transported observation according to its predicted uncertainty under the SDE prior. This accounts for temporal reliability, but the weights are independent of the observed residuals. We therefore introduce data-dependent reweighting based on statistical consistency with the anchor state. 

To incorporate this effect, we reweight the SDE-derived precision by a scalar function of the Mahalanobis distance: 

**==> picture [169 x 14] intentionally omitted <==**

This preserves the analytically derived temporal kernel while introducing data-dependent reweighting based on statistical consistency with the predicted state. 

Since the squared Mahalanobis distance _d_[2] _ij_[depends on the unknown anchor estimate, the resulting weights] _[ w][ij]_[are implicitly] functions of ¯ _**z** i_ . The corresponding update therefore defines a fixed-point equation that can be interpreted as one step of an iteratively reweighted least-squares (IRLS) procedure (see Appendix C.3). 

Given a current estimate (or proxy) of the anchor state _**z** i_ , the reweighted update takes the form: 

**==> picture [241 x 28] intentionally omitted <==**

In practice, RFA applies this reweighted aggregation once per layer, yielding an efficient approximation to robust state estimation while preserving full parallelism. 

## A.5.1. ROBUST INFLUENCE FUNCTIONS FOR PRECISION REWEIGHTING 

The choice of _w_ ( _·_ ) determines how strongly inconsistent observations are down-weighted and thus defines the estimator’s robustness profile. 

A natural baseline is an exponential influence function, 

**==> picture [81 x 20] intentionally omitted <==**

which recovers the functional form of Softmax attention with temperature _ν_ . However, exponential decay assigns negligible weight to moderately inconsistent observations, yielding brittle, winner-take-all behavior under low signal-to-noise. 

To obtain heavier tails, we adopt a power-law family of influence functions, 

**==> picture [85 x 20] intentionally omitted <==**

where _κ >_ 0 controls the rate at which inconsistent observations are suppressed. This form mitigates the influence of outliers, which also helps reduce the overconfidence induced by the conditional independence approximation. 

16 

**Robust Filter Attention** 

## **A.6. Parallel Aggregation via Diagonalization** 

To obtain a scalable implementation, we transform the robust precision-weighted estimator to the eigenbasis in which the propagated precision is diagonal. We define the state and propagated measurements in this basis as: 

**==> picture [169 x 13] intentionally omitted <==**

Using the simultaneous diagonalization _**P**[Z] ij_[=] _**[ S]**[−†]_ **[ Λ]** _[Z]_ _**P**_[(∆] _[t][ij]_[)] _**[ S]**[−]_[1] _[,]_[ the Mahalanobis distance decomposes into independent] scalar components: 

**==> picture [315 x 30] intentionally omitted <==**

This allows the robust weights _wij_ = _w_ ( _d_[2] _ij_[)][ to be computed efficiently for all token pairs.] Applying the robust reweighted estimator in this basis yields: 

**==> picture [192 x 28] intentionally omitted <==**

Since all matrices are diagonal, both the sum and inverse are element-wise operations. Writing _**λ**[Z]_ _**P** ,ij_[:= diag(] **[Λ]** _**P**[Z] ,ij_[)] _[,]_[ we define the unnormalized attention weights as:] 

**==> picture [73 x 14] intentionally omitted <==**

and the normalized weights as: 

**==> picture [111 x 29] intentionally omitted <==**

where _⊘_ denotes element-wise division. The aggregation then takes the familiar attention form: 

**==> picture [95 x 23] intentionally omitted <==**

Finally, the output in the original coordinate system is recovered by _**z**_ ¯ _i_ = _**S**_ ¯ _**zs** ,i._ All operations are _O_ ( _d_ ) per token pair, yielding an overall complexity of _O_ ( _N_[2] _d_ ) with no matrix inversions. 

Equivalently, this normalization can be written in Softmax form by defining dimension-wise attention logits. For Gaussian reweighting _wij ∝_ exp( _−d_[2] _ij[/ν]_[)][, the logit becomes:] 

**==> picture [201 x 15] intentionally omitted <==**

yielding: 

**==> picture [113 x 26] intentionally omitted <==**

For the power law influence function _wij ∝_ (1 + _d_[2] _ij[/ν]_[)] _[−][κ]_[, the corresponding logit becomes:] 

**==> picture [247 x 18] intentionally omitted <==**

This defines a Softmax-style aggregation over heavy-tailed consistency scores, yielding robust attention under model mismatch and non-Gaussian noise. 

In the isotropic case where _λ[Z]_ _**P** ,k_[(∆] _[t][ij]_[) =] _[ λ]_ _**P**[Z] ,ij_[is a shared scalar across dimensions, both kernels reduce to scalar logits:] 

**==> picture [192 x 13] intentionally omitted <==**

which is a Softmax normalization over scalar similarity scores. 

17 

**Robust Filter Attention** 

## A.6.1. LIKELIHOOD-CALIBRATED ATTENTION IN THE ISOTROPIC CASE 

Under an isotropic covariance constraint: 

**==> picture [84 x 14] intentionally omitted <==**

where _σ_ _**V**_[2][(∆] _[t][ij]_[)] _[ ∈]_[R][+][, the robust precision-reweighted attention score may be written as:] 

**==> picture [199 x 19] intentionally omitted <==**

where _d_[2] _ij_[=] _[ ∥]_ _**[r]**[ij][∥]_[2] _[/σ]_ _**V**_[2][(∆] _[t][ij]_[)][ is the isotropic Mahalanobis distance.] 

Choosing _κ_ = _[ν]_[+] _d[d]_ makes this expression proportional (up to additive constants) to the dimension-normalized negative log-likelihood of an isotropic multivariate Student’s _t_ distribution: 

**==> picture [196 x 19] intentionally omitted <==**

Thus, in the isotropic case, robust precision-weighted filtering with power-law influence and exponent _κ_ = ( _ν_ + _d_ ) _/d_ is equivalent (up to constants) to using dimension-normalized Student- _t_ log-likelihoods as attention logits. 

The dimension normalization is critical for stability: in high-dimensional spaces, squared Mahalanobis distances concentrate, causing unnormalized likelihoods to produce overly sharp, near-deterministic weights. Normalizing by dimension preserves sensitivity to relative consistency rather than absolute norm. 

In the limit _d →∞_ , the exponent satisfies _κ →_ 1, and the influence function reduces to the standard rational form of an M-estimator: 

**==> picture [89 x 14] intentionally omitted <==**

18 

**Robust Filter Attention** 

## **B. Robust Filter Attention Mechanism** 

## **B.1. Anisotropic Tensor RFA (Naive Implementation)** 

We first present an Anisotropic Tensor formulation of RFA, representing the most general form implied by our derivation under diagonalizable dynamics. Although it is not scalable due to its _O_ ( _N_[2] _d_ ) memory cost, it provides the reference estimator from which an efficient variant is derived. 

## B.1.1. LEARNED CHANGE-OF-BASIS PROJECTIONS 

The transformation to the decoupled eigenbasis is learned directly through complex-valued projections. We define: 

**==> picture [137 x 13] intentionally omitted <==**

where _d_ is the embedding dimension. The input projections _{_ _**W Q** ,_ _**W K** ,_ _**W V** }_ parameterize the learned diagonalizing basis _**S**[−]_[1] , mapping the real-world input into the complex latent frame where the DLE is analytically solvable. Conversely, the output projection _**W O**_ parameterizes the reconstruction basis _**S**_ , mapping the filtered state estimate back into the original embedding space. 

Given input sequence _**Z** ∈_ R _[d][×][N]_ , we obtain the latent representations: 

**==> picture [187 x 11] intentionally omitted <==**

## B.1.2. LATENT PROPAGATION VIA LINEAR DYNAMICS 

The SDE framework allows for separate dynamics and noise parameters _{_ _**λ** ,_ _**λ** Q,_ _**λ** R,_ _**λ**_ Γ _,_ _**λ** C}_ for the query/key and value latent spaces, allowing independent modeling of the precision prior and the precision used in the Mahalanobis distance. For simplicity and parameter efficiency, we instead use a shared embedding dimension _d_ and a unified set of parameters. 

In this reference model, every feature _k_ possesses its own complex eigenvalue _λk_ , allowing the model to learn a bank of filters with diverse damping rates and resonant frequencies. We define the propagation tensors _E_ and the resulting conditional means _V_[ˆ] : 

**==> picture [235 x 13] intentionally omitted <==**

## B.1.3. MEASUREMENT RESIDUALS & PRECISION 

We compute the measurement residual tensor _R_ _**qk**_ : 

**==> picture [175 x 12] intentionally omitted <==**

This is weighted by the analytic precision tensor _P[Z]_ , which is defined element-wise for each channel _k_ using the DLE solution: 

**==> picture [244 x 21] intentionally omitted <==**

where _µk_ = _−_ Re( _λk_ ). 

## B.1.4. AGGREGATION 

Unlike standard attention, which applies a single scalar score per head, tensor RFA computes an attention tensor _A ∈_ R _[d][×][N][×][N]_ . This enables independent, precision-weighted routing for every individual feature dimension. The score tensor combines a dimension-specific precision prior with a shared robust residual penalty: 

**==> picture [325 x 31] intentionally omitted <==**

The final estimate is computed via a row-wise Softmax over the logits, followed by a precision-weighted aggregation: 

**==> picture [283 x 24] intentionally omitted <==**

19 

**Robust Filter Attention** 

The final estimate is then projected back to the real-valued embedding space: 

## _**Z**_ **¯** = Re( _**W OV**_ **[¯]** ) _._ 

The time complexity remains _O_ ( _N_[2] _d_ ), but storing the conditional means, residuals, and attention tensors requires _O_ ( _N_[2] _d_ ) memory, limiting scalability. We therefore derive a memory-efficient implementation that avoids explicit tensor storage. 

## **B.2. Complexity Reduction via Factorization** 

We introduce the following factorizations to simplify the computation: 

## B.2.1. TOEPLITZ KERNEL FOR PRECISION 

If the measurements occur at equal time intervals _δt_ , the analytic precision kernel _P[Z]_ [ _k, i, j_ ] depends only on the channel _k_ and the time lag _τ_ = _|i − j|_ . This induces a Toeplitz structure along the temporal dimensions for each channel. 

Letting ∆ _tij_ = _τδt_ , we can thus pre-compute 1D covariance and precision kernels: _K[V] ∈_ R _[d][×][N]_ : 

**==> picture [211 x 14] intentionally omitted <==**

The full precision tensor is then simply the element-wise inverse of this kernel: 

**==> picture [197 x 12] intentionally omitted <==**

## B.2.2. FACTORIZING THE CONDITIONAL MEANS 

Because the dynamics are LTI, we can avoid explicitly constructing _O_ ( _N_[2] _d_ ) estimates by decomposing the transition factor _E_ into separate forward and backward transition factors for each dimension _k_ : 

**==> picture [351 x 13] intentionally omitted <==**

We can then define stationary representations: 

**==> picture [385 x 13] intentionally omitted <==**

The conditional means are then refactored as products: 

**==> picture [255 x 13] intentionally omitted <==**

This reduces the memory requirement from _O_ ( _N_[2] _d_ ) to _O_ ( _Nd_ ). 

Since **Φ**[+] [ _k, i_ ] does not depend on _j_ , we can pull it outside the sum: 

**==> picture [283 x 23] intentionally omitted <==**

## B.2.3. MEMORY AND STABILITY CONSTRAINTS 

Recall that: 

**==> picture [136 x 13] intentionally omitted <==**

Plugging in the factorizations for _**Q**_ **[ˆ]** [ _k, j_ ] and _K_[ˆ] [ _k, i, j_ ], the residual becomes: 

**==> picture [309 x 13] intentionally omitted <==**

The Mahalanobis distance now becomes: 

**==> picture [393 x 37] intentionally omitted <==**

20 

**Robust Filter Attention** 

The remaining bottleneck is the _k_ -dependence of the precision kernel _K[P]_ in the evaluation of the cross-term: 

**==> picture [175 x 24] intentionally omitted <==**

In standard attention, scores are computed with a single matrix multiplication ( _**QK**[⊤]_ ). Here, however, the precision kernel _K[P]_ [ _k, |i − j|_ ] weights each feature differently as a function of time lag, so the summation over _k_ cannot be expressed as a single matmul. Consequently, computing this term for all ( _i, j_ ) pairs does not admit a reduction in memory or bandwidth without additional structure. Achieving _O_ ( _N_[2] + _Nd_ ) memory therefore requires the precision kernel to be independent of the feature index _k_ , allowing it to factor outside the summation. 

A degenerate case occurs in the zero-noise limit, where uncertainty no longer accumulates with temporal separation and the precision kernel becomes independent of _|i−j|_ . This recovers a memory-efficient formulation with anisotropic (feature-wise) decay, similar to xPos. 

However, for stable dynamics with _µk >_ 0, the backward transition factor **Φ** _[−]_ [ _k, j_ ] = _e_[(] _[µ][k][−][iω][k]_[)] _[t][j]_ grows exponentially with sequence length. When decay rates vary across features, the stationary representations _**Q**_ **[ˆ]** _,_ _**K**_ **[ˆ]** _,_ _**V**_ **[ˆ]** grow exponentially with sequence length, making fully parallel computation numerically unstable because forward and backward factors cancel only after multiplication, allowing intermediate values to overflow. 

Therefore, retaining a non-constant precision kernel while ensuring numerical stability under extrapolation requires restricting decay to be isotropic within each head. This allows decay to be factored at the head level rather than per feature, enabling stable, fully parallel attention with _O_ ( _N_[2] + _Nd_ ) memory. This motivates the Isotropic RFA variant introduced next. 

## **B.3. The Scalable Isotropic RFA Mechanism** 

## B.3.1. ISOTROPIC DECAY AND NOISE ASSUMPTIONS 

All assumptions in this section are applied _per attention head_ . In particular, the real part of the eigenvalues within a head is taken to be a shared scalar _−µ_ : 

**==> picture [157 x 12] intentionally omitted <==**

This corresponds to a system with an isotropic plus skew-symmetric state matrix ( **Ω** = _−_ **Ω** _[⊤] ∈_ R _[d][×][d]_ ), 

**==> picture [65 x 10] intentionally omitted <==**

We also assume that the noise is isotropic, i.e. that the noise covariances are scalar multiples of identity: 

**==> picture [160 x 12] intentionally omitted <==**

Under this constraint, the covariance kernels simplify to scalar functions: 

**==> picture [233 x 14] intentionally omitted <==**

Hence, the precision kernel becomes a scalar function of the time lag _τ_ = _|i − j|_ , allowing it to be pulled outside the feature summation. Defining _**V**_ ∆ _t_ [ _i, j_ ] := _σ_ _**V**_[2][(] _[|][i][ −][j][|]_[)][ and] _**[ P]**_[ ∆] _[t]_[[] _[i, j]_[] := 1] _[/]_ _**[V]**_[∆] _[t]_[[] _[i, j]_[]][, the matrix of Mahalanobis distances become:] 

**==> picture [293 x 25] intentionally omitted <==**

(Note that �� _**Rqk**_ �� denotes a matrix of vector norms, not a matrix norm.) 

## B.3.2. SIMPLIFYING THE SQUARED RESIDUAL NORM 

The isotropic constraint allows the dynamics to be factored into a stable decay term and complex forward/backward rotations: 

**==> picture [265 x 15] intentionally omitted <==**

We can then define backward-rotated queries, keys, and values: 

**==> picture [219 x 12] intentionally omitted <==**

21 

**Robust Filter Attention** 

Note that: 

**==> picture [311 x 15] intentionally omitted <==**

Plugging this into the expression for the Mahalanobis distance, and using the fact that complex rotation preserves magnitude: 

**==> picture [443 x 69] intentionally omitted <==**

Or, in vectorized form: 

**==> picture [275 x 34] intentionally omitted <==**

(since _∥_ _**Q** i∥_[2] = _∥_ _**Q**_ **[˜]** _i∥_[2] and _∥_ _**K** i∥_[2] = _∥_ _**K**_ **[˜]** _i∥_[2] ). The cross-term Re( _**Q**_ **[˜]** _†_ _**K**_ **˜** ) is computed using one _O_ ( _N_[2] _d_ ) matrix multiplication, achieving the required memory efficiency. 

## B.3.3. THE ATTENTION MATRIX AND ESTIMATE 

The score matrix _**L**_ is defined using the negative log-likelihood of the robust M-estimator, which combines the uncertainty 2 _ν_ + _d_ prior _**V**_ ∆ _t_ and the squared Mahalanobis distance _**P**_ ∆ _t ⊙_ �� _**Rqk**_ �� . Letting _κ_ = _d_[, this is:] 

**==> picture [225 x 25] intentionally omitted <==**

Defining a causal mask _**M**_ causal, we can then express the row-normalization using row-wise Softmax: 

**==> picture [157 x 14] intentionally omitted <==**

The value aggregation is refactored for stability: 

**==> picture [225 x 25] intentionally omitted <==**

**==> picture [175 x 26] intentionally omitted <==**

Hence, defining a decayed attention matrix _**A**_ := _**A**_ **[ˆ]** _⊙_ _**E**_ , the filtered estimate _**V**_ **[¯]** is computed by transforming the aggregation back into the forward-rotated frame: 

**==> picture [89 x 15] intentionally omitted <==**

Or, in a form more typical for attention: 

**==> picture [105 x 15] intentionally omitted <==**

This rotate-aggregate-rotate-back structure ensures that the value aggregation is equivariant to temporal shifts, allowing the model to preserve the dynamical phase relationships of the SDE regardless of the absolute position in the sequence (Fig. 2). 

22 

**Robust Filter Attention** 

**==> picture [293 x 125] intentionally omitted <==**

_Figure 2._ **Rotate, aggregate, rotate-back structure of Isotropic RFA.** Queries, keys, and values are rotated into a common frame to compute attention and aggregate values. The resulting estimate is then rotated back to the initial frame, yielding a state that preserves relative phase while remaining equivariant to absolute position. 

## **B.4. A Physical Interpretation of Positional Embeddings** 

## B.4.1. LEARNABLE GATES AND PHYSICAL PHASE TRANSITIONS 

RFA’s behavior is fundamentally determined by the balance between initial measurement uncertainty ( _η_[2] ) and the steadystate process uncertainty accumulated through stochastic drift. We characterize this balance through the combined noise coefficients: 

**==> picture [218 x 25] intentionally omitted <==**

In particular, the sign of _α_ defines a phase transition between a _Diffusive_ and an _Integrative_ regime. Note that the model is constrained by the physical reality that the total steady-state uncertainty _β_ must always bound the transient components ( _|α| ≤ β_ ), ensuring strictly positive variances. 

Here, we examine the behavior of the additive bias _**B**_ ∆ _t_ := log( _**P**_ ∆ _t_ ) and the multiplicative gating term _**P**_ ∆ _t_ . The behavior of each regime is illustrated in Fig 3, and the effect of the decay is shown in Fig 4. 

**I. The Diffusive (Forgetting) Regime (** _α <_ 0 **)** In this regime, stochastic drift accumulates faster than the initial signal settles, representing a system where process uncertainty grows over time. Memory is aggressively eroded by stochastic drift as the temporal lag ∆ _t_ increases. 

**Additive Bias (** _**B**_ ∆ _t_ **): Acts as a Forgetting Prior.** Letting _α[′]_ = _−α >_ 0, the bias follows a logarithmic decay: 

**==> picture [173 x 25] intentionally omitted <==**

The bias starts at its maximum value at ∆ _t_ = 0 and decays toward a floor of _−_ log( _β_ ) as ∆ _t →∞_ . 

**Multiplicative Gate (** _**P**_ ∆ _t_ **): Functions as a Closing Gate.** The precision decays as: 

**==> picture [110 x 15] intentionally omitted <==**

Selectivity is maximal at ∆ _t ≈_ 0 and rapidly blurs out as the lag between tokens increases. 

**II. The Integrative (Denoising) Regime (** _α >_ 0 **)** Here, initial measurement noise ( _η_[2] ) is the primary error source. The SDE dynamics settle faster than drift accumulates, allowing the model to denoise the signal. 

**Additive Bias (** _B_ ∆ _t_ **): Acts as a Settling Prior.** The bias follows a mirrored Softplus: 

**==> picture [197 x 11] intentionally omitted <==**

The budget for the token starts low and curves up toward its maximum as key-side measurement noise _η_[2] dissipates. 

**Multiplicative Gate (** _**P**_ ∆ _t_ **): Functions as an Opening Gate.** The precision follows a sigmoid: 

**==> picture [163 x 24] intentionally omitted <==**

23 

**Robust Filter Attention** 

Selectivity is low initially to avoid over-committing to a noisy initial observation, with the gate waiting until the signal settles into a reliable latent position to open. 

RFA parameterizes both regimes through the same learned noise variances (˜ _σ_[2] _, η_[2] _, γ_[2] ), allowing attention heads to move smoothly between diffusive and integrative behavior during training. 

## B.4.2. THE ZERO-DECAY LIMIT 

If the queries and keys are normalized, the matrix of squared residual norms becomes: 

**==> picture [171 x 20] intentionally omitted <==**

In the zero-decay limit ( _µ →_ 0), the relative decay vanishes ( _**E**_ = **1** ), and the residual simplifies to the chordal distance on the unit-norm hypersphere: 

**==> picture [130 x 19] intentionally omitted <==**

Substituting this into the NLL, 

**==> picture [249 x 21] intentionally omitted <==**

> _†_ **˜** Expanding around _**Q**_ **[˜]** _**K**_ = **0** , this is approximately: 

**==> picture [213 x 35] intentionally omitted <==**

When _µ_ = 0, the total covariance becomes a linear function of time: 

**==> picture [151 x 12] intentionally omitted <==**

Without dissipation to bound this growth, the precision _**P**_ ∆ _t ∝_ 1 _/σ_ _**V**_[2][vanishes as][ ∆] _[t][ →∞]_[.] The resulting additive bias is: 

The first term is: 

**==> picture [212 x 58] intentionally omitted <==**

Expanding around ∆ _t_ = 0 yields the linear approximation: 

**==> picture [169 x 25] intentionally omitted <==**

The second term is: 

**==> picture [184 x 22] intentionally omitted <==**

which rapidly disappears as ∆ _t_ grows. For ∆ _t ≈_ 0, this is: 

Hence, for small ∆ _t_ , 

**==> picture [283 x 73] intentionally omitted <==**

The first term reflects linear variance growth under Brownian diffusion, while the second arises from the robust (Student- _t_ ) likelihood correction. In high-dimensional settings, where typically _ν_ = _O_ ( _d_ ) and _κ_ = ( _ν_ + _d_ ) _/d_ = _O_ (1), the second term is suppressed, and the bias is dominated by the diffusion-driven component. 

Thus, in the zero-decay and short-time regime, the RFA prior induces an approximately linear distance-dependent bias, analogous in form to the linear penalties used in methods such as ALiBi. 

24 

**==> picture [91 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
Robust Filter Attention<br>**----- End of picture text -----**<br>


**==> picture [293 x 234] intentionally omitted <==**

_Figure 3._ By varying the ratio of steady-state process uncertainty _σ_ ˜[2] to measurement noise _η_[2] , RFA heads can specialize into distinct physical regimes: a **diffusive regime** that favors local recency (top row) and an **integrative regime** (bottom row) that filters transient noise to identify stable historical trends. The multiplicative gate _P_ ∆ _t_ controls the selectivity (adaptive gain) of the attention, while the additive bias _B_ ∆ _t_ defines the prior budget allocated to tokens at a given temporal lag. 

**==> picture [293 x 235] intentionally omitted <==**

_Figure 4._ The damping parameter _µ_ dictates the speed of the phase transition. As _µ →_ 0, the model recovers non-stationary Brownian dynamics, where precision drops linearly with time. As _µ_ increases, the model enforces stationarity, where the attention bias saturates to a learned global noise floor _β_ , providing a principled mechanism for long-range context retention. 

25 

**Robust Filter Attention** 

## **C. Extensions** 

This section describes extensions and special cases of RFA that preserve its computational and stability guarantees. 

## **C.1. Spectrally Coupled RFA** 

Isotropic RFA introduces exponential decay to improve extrapolation relative to purely rotational positional encodings. However, a single decay parameter per head applies uniformly across all spectral components represented within that head. Because each attention head implicitly represents a mixture of oscillatory modes, this isotropic treatment cannot distinguish between low-frequency components that encode stable long-range structure and high-frequency components that primarily capture short-range variation. As a result, high-frequency components may persist long enough to contaminate long-range attention, while low-frequency components would remain stable under much weaker decay. 

In the zero-rotation limit, ALiBi removes oscillatory positional structure entirely, eliminating high-frequency leakage into long-range attention at the cost of reduced spectral expressivity. 

Motivated by this tradeoff, we introduce _Spectrally Coupled RFA_ (SC-RFA), which aligns decay rates with spectral scale across attention heads: rather than treating each head as spectrally uniform, we partition the rotational spectrum across heads and couple decay to spectral scale (Fig. 5). Heads associated with higher-frequency rotations are assigned stronger decay, while heads dominated by low-frequency structure use weaker or near-zero decay. This induces a multi-resolution prior in which high-frequency heads act as short-range filters whose influence rapidly diminishes with distance, while low-frequency heads preserve stable long-range dependencies. 

In particular, we fix the relative scale between decay and rotation by parameterizing the decay of the _k_ -th head as: 

**==> picture [77 x 11] intentionally omitted <==**

where _ωk_ denotes the rotational spectrum assigned to that head and _b_ is a dimensionless damping ratio. This ensures that all heads retain context for a roughly equivalent number of oscillatory cycles, rather than a fixed absolute duration. Setting _b ≈_ 1 corresponds to a balanced regime where the signal decay timescale matches the rotational period, effectively suppressing aliasing artifacts beyond a single phase cycle. 

**==> picture [234 x 146] intentionally omitted <==**

**==> picture [234 x 146] intentionally omitted <==**

_Figure 5._ **Eigenvalue spectra of rotational positional encodings (with b=1.0).** _Left:_ Standard RoPE with isotropic decay, where each head uses the full range of frequencies (note that we require the eigenvalues to appear in complex conjugate pairs). _Right:_ Spectrally Coupled RoPE, where decay increases with rotational frequency, selectively suppressing high-frequency modes while preserving lowfrequency structure. 

## **C.2. Inhomogeneous Dynamics and Measurement Bias** 

The RFA framework is robust to deterministic complexities because, in the diagonalized eigenbasis, their effects collapse analytically into constant bias vectors. 

Consider an inhomogeneous linear SDE with a constant drift _**u**_ and a measurement model with bias _**bz**_ : 

**==> picture [153 x 30] intentionally omitted <==**

26 

**Robust Filter Attention** 

We assume _**A**_ is Hurwitz and _**A** ,_ _**C**_ are invertible. In classical systems theory, the deterministic drift _**u**_ is typically eliminated by augmenting the state space with an extra dimension: 

**==> picture [55 x 24] intentionally omitted <==**

This yields a homogeneous SDE: 

**==> picture [179 x 11] intentionally omitted <==**

where _**A**_ aug contains the _**u**_ term. However, this method is incompatible with the RFA framework because the augmented system matrix _**A**_ aug and the augmented process noise covariance _**Q**_ aug = _**G**_ aug _**G**[⊤]_ aug[become singular and are no longer] simultaneously diagonalizable. Consequently, the analytic solution to the DLE, which is essential for RFA’s _O_ ( _N_[2] _d_ ) complexity, fails. For this reason, we must handle the inhomogeneous case directly by seeking a solution that preserves the structure of the underlying homogeneous system. 

The SDE can be written in the standard OU form by identifying the equilibrium point _**µ**_ : 

**==> picture [231 x 13] intentionally omitted <==**

The solution to the SDE, propagating the state forward from _**x**_ ( _tj_ ) to _**x**_ ( _ti_ ), is: 

**==> picture [333 x 31] intentionally omitted <==**

Letting _**Gu**_ (∆ _tij_ ) = �0∆ _tij e[−]_ _**[A]**[τ] dτ_ , the conditional mean of the state at _ti_ given the state at _tj_ is: 

**==> picture [155 x 19] intentionally omitted <==**

Letting _**us**_ := _**S**[−]_[1] _**u**_ , the drift term is: 

**==> picture [260 x 27] intentionally omitted <==**

Hence, the conditional mean in the eigenbasis becomes: 

**==> picture [195 x 55] intentionally omitted <==**

(where division is element-wise). Including the measurement model: 

**==> picture [242 x 49] intentionally omitted <==**

where _**bz,s**_ = _**S**[−]_[1] _**bz**_ and _**β**_ = **[Λ]** _**[C]**_ **Λ** _**[u][s]** −_ _**bz,s**_ . Because the drift contributes only a deterministic mean shift, the covariance evolution—and hence the DLE solution—remains identical to the homogeneous case. 

Hence, the drift and measurement bias terms can be accounted for by defining bias terms _**bq** ,_ _**bk** ,_ _**bv** ∈_ C _[d][×]_[1] in the input projections defining the queries, keys, and values: 

**==> picture [385 x 40] intentionally omitted <==**

27 

**Robust Filter Attention** 

These bias terms correspond to the steady-state offset induced by constant drift in the diagonalized dynamics. This allows the residual tensor to maintain the same form as the homogeneous case, using the biased tensors: 

**==> picture [195 x 11] intentionally omitted <==**

The attention output is: 

**==> picture [271 x 61] intentionally omitted <==**

This final bias can be absorbed into the bias of the output projection: _**bO**_ := _**W ObV**_ . 

Hence, the inhomogeneous SDE with constant drift _**u**_ and measurement bias _**bz**_ is structurally equivalent to the homogeneous RFA mechanism, provided the deterministic effects are absorbed into constant bias vectors in the input and output projections ( _**bQ** ,_ _**bK** ,_ _**bV** ,_ _**bO**_ ). 

## **C.3. Stacked Attention Layers as an Unrolled Iterative State Estimator** 

The robust M-estimator derived in Appendix A.5 is defined implicitly, as the optimal weights _wij_ depend on the residuals between each historical measurement _**z** j_ and the unknown latent anchor state _**x** i_ . Since _**x** i_ is unobserved, these residuals—and hence the weights—must be computed with respect to the current estimate of the state, obtained by aggregating the propagated measurements, denoted _**z**_ **¯** _i_ . 

Because the weights depend on the state estimate, and the state estimate depends on the weights, the solution requires iterative reweighting. This admits an interpretation of each attention layer as one step of an Iteratively Reweighted Least Squares (IRLS)-like procedure: given a state estimate from the previous layer, the current layer recomputes residuals, updates the weights, and produces a refined precision-weighted estimate. 

The estimation is performed in the decoupled eigenbasis of the dynamical system, leveraging the diagonal precision matrices **Λ** _[Z]_ _**P**_[.][Let] _**[ z][s]**[i]_[:=] _**[ S]**[−]_[1] _**[z]**[i]_[, and initialize:] _**[z]**_ **[ˆ]**[(1)] _**s** ii_[=] _**[ z][s]**[i][.]_[ A single refinement step] _[ k]_[ updates:] 

**==> picture [295 x 31] intentionally omitted <==**

Weights are recomputed from the Mahalanobis residuals: 

**==> picture [255 x 19] intentionally omitted <==**

To improve numerical stability and prevent oscillatory updates, a convex combination (residual connection) may be applied: 

**==> picture [129 x 14] intentionally omitted <==**

Stacking _L_ attention layers with shared dynamical structure is therefore equivalent to unrolling _L_ steps of this truncated iterative estimation procedure. Learning can be viewed as learning both the inference procedure and the underlying dynamical prior end-to-end through a fixed number of refinement steps. 

## **C.4. Confidence-Gated Information Fusion** 

A significant limitation of standard Softmax attention is that the normalization[�] _j_ _**[A]**[ij]_[=][1][ removes the absolute scale] of evidence supporting an estimate. In contrast, the Student- _t_ reweighting in RFA fixes an absolute reference through the constant term in 1 + _d_[2] _ij[/ν]_[.][Because] _[ d]_[2] _ij_[depends on the learned residual precision, the scale of precision is identifiable,] making sums of unnormalized weights interpretable as accumulated evidence. Consequently, the learned noise parameters (˜ _σ_[2] _, η_[2] _, γ_[2] ) are pushed toward meaningful uncertainty levels relative to the residuals, rather than arbitrary rescalings that would otherwise be absorbed by Softmax normalization. 

28 

**Robust Filter Attention** 

We first quantify the total evidence supporting the latent state at time _ti_ by computing the aggregate observed Fisher information _**p**_ **ˆ** tot _,i_ for each head: 

**==> picture [269 x 24] intentionally omitted <==**

The model must decide whether to trust the SDE-propagated estimate _**V**_ **[¯]** _i_ or the raw local observation _**V** i_ . We formulate this as a ratio between the gathered precision _**p**_ **ˆ** _i_ and a learned prior precision _p_ prior. If _**p**_ **ˆ** _i ≫ p_ prior, the context provides sufficient evidence to override the local noise. We define the gate _**g** i ∈_ (0 _,_ 1) _[h][×][N]_ using a sigmoid in log-precision space: 

**==> picture [149 x 19] intentionally omitted <==**

In this formulation, _p_ prior _∈_ (R[+] ) _[h]_ sets the absolute threshold for evidence required to open the gate, while _p_ scale _∈_ (R[+] ) _[h]_ dictates the sensitivity to changes in the evidence. We initialize _p_ scale to a small positive value and log _p_ prior to a large negative value, so that _**g** i ≈_ **1** . 

The filtered state is then computed as a convex combination: 

**==> picture [147 x 15] intentionally omitted <==**

This enables the model to act as a self-correcting observer: when the context provides high-precision evidence ( _gi →_ 1), the model trusts the SDE; if the evidence is insufficient ( _gi →_ 0), it reverts to the local input. 

## **C.5. Stochastic Latent Sampling** 

For sequential generation and forecasting, RFA provides a principled marginal for the next-step state by sampling directly from the robust latent estimate and its associated uncertainty. 

The filtered state covariance **Λ** filt _,i_ represents the estimation error accumulated across the context window. Given the isotropic constraint, this is the element-wise inverse of the calibrated posterior precision: 

**==> picture [69 x 13] intentionally omitted <==**

The total predictive covariance combines the propagated estimation error and the intrinsic measurement noise variance of the observation _γ_[2] : 

**==> picture [89 x 13] intentionally omitted <==**

Sampling occurs in the complex latent frame, distributing variance equally between real and imaginary components: 

**==> picture [259 x 19] intentionally omitted <==**

This produces stochastic latent states consistent with the learned dynamics. Scaling the noise by the aggregate precision increases exploration when contextual uncertainty is high, while the SDE prior maintains structural coherence. 

## **C.6. State Prediction at Future Horizons** 

To predict ∆ _t_ + steps ahead, we project each historical measurement _**z** j_ through the learned dynamics to the target time _ti_ + ∆ _t_ + and then aggregate the projections. Over this interval, the uncertainty grows, requiring _covariance inflation_ . 

Formally, this modifies the relative-time kernel _**E**_ as: 

**==> picture [233 x 13] intentionally omitted <==**

where _ζ_ = _e[−][µ]_[∆] _[t]_[+] can be either fixed or learned. 

The forward projection of the latent value through the dynamics can be absorbed into the output linear layer, and any additional covariance offset can be absorbed into _γ_[2] . Effectively, predicting at a future horizon only requires rescaling _**E**_ by _ζ_ , leaving the underlying RFA mechanism unchanged. 

29 

**Robust Filter Attention** 

## **C.7. Generalized Analytic Priors via Time-Structured Noise** 

The derivation in Section A.2 assumed white process noise. However, each diagonal DLE is a linear ODE, and allowing the noise injection rate _qk_ ( _t_ ) to vary in time yields a richer class of analytic priors. For each mode _k_ with decay _µk_ = _−_ Re( _λk_ ), the covariance satisfies: 

**==> picture [250 x 22] intentionally omitted <==**

The unique solution is given by the convolution of the mode-specific noise source _qk_ ( _s_ ) with the system’s exponential impulse response: 

**==> picture [161 x 26] intentionally omitted <==**

To ensure _λV,k_ (∆ _t_ ) remains analytically tractable and computable in parallel, we restrict the noise source to the class of functions closed under exponential convolution: the complex exponentials. Letting _qk_ ( _s_ ) =[�] _j[c][j][e][γ][j][s]_[ for] _[ c][j][, γ][j][∈]_[C][, the] integral yields a weighted sum of exponential differences: 

**==> picture [187 x 30] intentionally omitted <==**

This structure allows the model to analytically represent an oscillatory precision prior, which may help regularize the model by offloading predictable noise variability into the prior, reducing the burden on the data-dependent attention weights. 

30 

**Robust Filter Attention** 

## **D. Implementation** 

## **D.1. Complex-valued Computations** 

RFA is formulated in a complex latent space to represent oscillatory dynamics. In practice, all operations are implemented using real-valued tensors by stacking real and imaginary components, i.e., via the standard isomorphism C _[d][∼]_ = R[2] _[d]_ , so that complex multiplications and projections reduce to ordinary real-valued linear algebra. 

We denote a complex linear layer by _L_ ( _·_ ). For an input _**x**_ = [ _**x** r,_ _**x** i_ ] _[⊤]_ with _**x** r,_ _**x** i ∈_ R _[d]_ , the layer computes: 

**==> picture [143 x 31] intentionally omitted <==**

Here _**W** r,_ _**W** i ∈_ R _[d][×][d]_ are the real and imaginary components of the weight matrix and _**b** r,_ _**b** i ∈_ R _[d]_ the bias. This is equivalent to multiplication by a complex matrix _**W**_ = _**W** r_ + _i_ _**W** i_ with bias _**b**_ = _**b** r_ + _i_ _**b** i_ , while remaining in the real domain. 

Assuming the inputs and outputs are purely real, only the real-input columns of the input projections and the real-output columns of the output projections are required: 

**==> picture [149 x 55] intentionally omitted <==**

Hence, both projections may be implemented using standard real-valued linear layers in R[2] _[d]_ . We define queries, keys, and values using: 

**==> picture [223 x 14] intentionally omitted <==**

We define cosine and sine matrices: 

**==> picture [173 x 11] intentionally omitted <==**

Complex rotations are applied as: 

**==> picture [239 x 32] intentionally omitted <==**

and likewise for keys and values. This is algebraically identical to RoPE. 

To ensure the underlying system matrix _**A**_ is real-valued, we enforce that latent frequencies appear in complex conjugate pairs: 

**==> picture [141 x 13] intentionally omitted <==**

The Mahalanobis distance requires the real part of the complex inner product, 

**==> picture [221 x 26] intentionally omitted <==**

This is implemented as a single real matrix multiplication in R[2] _[d]_ . 

Value aggregation, _**V**_ **[¯]** , is computed in the R[2] _[d]_ domain. The real-valued attention matrix _**A**_ is applied identically to both the real and imaginary components of the complex-rotated values: 

**==> picture [75 x 52] intentionally omitted <==**

**Robust Filter Attention** 

The inverse rotation yields: 

**==> picture [219 x 25] intentionally omitted <==**

The final output is projected back to the real domain using the _L_[C] _[→]_[R] layer: 

**==> picture [210 x 13] intentionally omitted <==**

All components of RFA are therefore implemented using standard real-valued operations. 

## **D.2. Initialization** 

The RFA model initializes complex projections and dynamics to cover multiple temporal scales and ensure numerical stability. 

**Isotropic Complex Projections.** Complex weights _**W**_ = _**W** r_ + _i_ _**W** i_ are represented in R[2] _[d]_ and initialized isotropically: 

**==> picture [319 x 26] intentionally omitted <==**

Output projections ( _**W O**_ ) are scaled by 1 _/√_ 2 to preserve variance when converting back to real space. 

**Dynamics and Head Specialization.** In SC-RFA, we define a global frequency bank and partition it across heads such that each head specializes in a distinct spectral band. To ensure stability, the decay rate _µh_ is coupled to the head’s maximum frequency: _µh_ = _b ·_ max( _ωh_ ). In RFA (non spectrally coupled), we use the same spread of decay rates, though each head receives the full range of angular frequencies. In our primary models (M1-M2.6), we use a damping coefficient _b_ = 0 _._ 05, prioritizing near-field accuracy rather than long-context extrapolation. We reserve a fraction of heads (2 out of 8) with _µ_ = 0 to give the model the capacity to learn lossless, infinite-horizon integrators. 

**Noise and Robustness.** We initialize a constant steady-state uncertainty _σ_ ˜ across heads, i.e. _σ ∝ µ_ . We initialize measurement noise ( _η_[2] _, γ_[2] ) such that such that the model begins in the integrative regime ( _η_[2] _> σ_ ˜[2] ), to preserve long-range gradient flow early in training. 

The Student- _t_ degrees of freedom _ν_ are initialized as a multiple of head dimension _d_ . We set _ν_ = 4 _d_ , placing the model in a quasi-Gaussian regime during the initial phase of training. This provides a broad “trusting prior” that prevents the premature rejection of tokens while the Query-Key representations are still unoptimized. 

**Note.** In our implementation, _σ_[2] was learned directly. A potentially preferable parameterization is in terms of _σ_ ˜[2] := _|λ_ _**C** |_[2] _σ_[2] _/_ (2 _µ_ ), which decouples the steady-state variance floor from the dissipation rate _µ_ and may improve numerical conditioning. We also suggest initializing near the boundary between the diffusive and integrative regimes ( _α_ = 0), particularly for heads with small decay rates, as a reasonable default when no prior on the noise regime is available. 

32 

**Robust Filter Attention** 

## **D.3. Algorithm** 

Algorithm 1 details the implementation of Isotropic RFA. 

( **Note:** We use _⊕_ to denote broadcast addition.) 

**Algorithm 1** Robust Filter Attention (Isotropic; Single Head) 

**Input:** Input sequence _**Z** ∈_ R _[d][×][N]_ 

**Definitions:** 

**Linear layers:** _L_[R] _**Q**[→]_[C] _, L_[R] _**K**[→]_[C] _, L_[R] _**V**[→]_[C] _, L_[C] _**O**[→]_[R] ; dynamics/noise variance parameters: _µ[′] ,_ _**ω**[′] , σ[′] , η[′] , γ[′]_ ; robustness parameter _ν_ ; Softmax temperature _τs_ . 

**Constants:** Causal mask _**M**_ causal _∈{_ 0 _, −∞}[N][×][N]_ ; stability constant _ϵ_ . 

**Enforce Conjugate Symmetry:** _**ω** ∈{ω_ 1 _[′][,][ −][ω]_ 1 _[′][, . . . , ω] d/[′]_ 2 _[,][ −][ω] d/[′]_ 2 _[}]_[.] 

## **Ensure positive noise/decay parameters:** 

_{µ,_ ˜ _σ_[2] _, η_[2] _, γ_[2] _} ←_ softplus( _{µ[′] , σ[′] , η[′] , γ[′] }_ ) + _ϵ_ 

## **Input projections:** 

(Re( _**Q**_ ) _,_ Im( _**Q**_ )) _←L_[R] _**Q**[→]_[C] ( _**Z**_ ), (Re( _**K**_ ) _,_ Im( _**K**_ )) _←L_[R] _**K**[→]_[C] ( _**Z**_ ), (Re( _**V**_ ) _,_ Im( _**V**_ )) _←L_[R] _**V**[→]_[C] ( _**Z**_ ) 

**==> picture [445 x 111] intentionally omitted <==**

2[�] **Logits:** _**L**_ = _**B**_ ∆ _t − κ_ log �1 + _ν_[1] _**[P]**_[ ∆] _[t][ ⊙]_ �� _**Rqk**_ �� , where _κ_ = _[ν]_[+] _d[d][.]_ **Attention matrix:** _**A**_ **[ˆ]** [ _i, j_ ] = Softmax _j_ � _τs_ _**L**_ [ _i, j_ ] + _**M**_ causal� _,_ _**A**_ = _**A**_ **[ˆ]** _⊙_ _**E**_ + _⊤_ **Output with value counter-rotations:** _**V**_ **[¯]** = **Φ[˜]** _⊙_ ( _**V A**_ **˜** ) 

**==> picture [226 x 13] intentionally omitted <==**

**Return:** Re( _**Z**_ **[¯]** ) 

Our current implementation is written in high-level PyTorch and incurs an approximately 2 _×_ training overhead relative to PyTorch’s optimized scaled dot-product attention backend. 

33 

**Robust Filter Attention** 

## **E. Experimental Details and Ablations** 

## **E.1. Experimental Setup** 

**Architecture and Model Configuration** All experiments were conducted using a 6-layer decoder-only Transformer architecture. We set the model dimension to _d_ model = 256 with _h_ = 8 attention heads. The attention mechanism maps the model dimension to a total latent dimension of 512 via the _d ×_ 2 _d_ query, key, and value projections (split into _dk_ = 64 per head), while the 2 _d × d_ output projection maps back down to 256. 

We employ a Pre-Norm configuration using Layer Normalization. The position-wise Feed-Forward Network utilizes an expansion factor of 4. To optimize the parameter budget, we implement weight tying between the token embedding layer and the final linear output head. We use the GPT-2 byte-pair encoding (BPE) tokenizer with a vocabulary size of 50,257 for all language modeling experiments. 

To ensure a fair comparison, RFA models and the baselines (RoPE and ALiBi) were designed with near-identical parameter counts. RFA introduces only a small set of scalar coefficients per head to parameterize the SDE-based drift ( _µ_ ), noise ˜ ( _σ_[2] _, η_[2] _, γ_[2] ), and robustness ( _ν, τs_ ). Hence, the RFA models match the baseline parameter count (19 _._ 36M), with only a 0.02% increase due to additional scalar coefficients. 

**Training and Optimization Protocol** Models were trained for 15 epochs using the Adam optimizer. We utilized a OneCycleLR scheduler with cosine annealing and a 5% warmup period. For RFA models, we adopted a decoupled optimization strategy to ensure the stability of the SDE coefficients: 

- **Feature Weights:** Peak LR of 1 _×_ 10 _[−]_[3] with momentum _β_ 1 = 0 _._ 9 (same as in baselines). 

- **SDE Coefficients:** Peak LR of 5 _×_ 10 _[−]_[4] with no momentum ( _β_ 1 = 0 _._ 0) and a higher _ϵ_ = 10 _[−]_[7] to prevent numerical instability and oscillatory updates. 

We apply global gradient clipping at a threshold of 1 _._ 0. For the RFA-specific physics parameters, we apply a stricter local clipping threshold of 1 _×_ 10 _[−]_[4] as a precaution. All models were trained on the WikiText-103 and BabyLM-2025 datasets using a standard causal language modeling objective. 

## **E.2. Model Variants and Ablation Design** 

This section presents a series of ablations designed to isolate the contributions of RFA’s core components. 

We distinguish between three categories of models: 

1. Positional baselines used in the main text (B1–B4), 

2. Final RFA variants evaluated in Section 4 (M1–M2), and 

3. Structural diagnostic ablations (M2.1–M2.6), which progressively remove components of the filtering formulation to test necessity and failure modes. These models are not intended as competitive models, but rather as mechanistic probes of stability and extrapolation behavior. 

## **Baselines:** 

- **B1: Standard Transformer + RoPE.** Dot-product attention with rotary positional embeddings (Su et al., 2024). Applies _d →_ 2 _d → d_ projections to match RFA parameterization. 

- **B2: Standard Transformer + ALiBi.** Dot-product attention with linear distance bias (Press et al., 2022). Tests whether static geometric penalties are sufficient for stability. 

- **B3: Decayed RoPE.** RoPE with an additional exponential decay applied to attention scores per-head, as in RFA, testing whether explicit dissipation alone suffices in the absence of uncertainty modeling. 

- **B4: Spectrally Coupled RoPE (SC-RoPE).** Frequency-partitioned RoPE with head-wise decay schedules, testing whether multi-scale geometric heuristics alone can recover SC-RFA’s stability. 

34 

**Robust Filter Attention** 

## **Primary RFA Models:** 

- **M1: Isotropic RFA.** Isotropic RFA as described in Algorithm D.3, replacing the attention module in a standard Transformer. 

- **M2: Spectrally Coupled RFA (SC-RFA).** M1 with explicit coupling between rotation frequencies and decay rates, yielding a multi-resolution filtering prior. 

**Structural Diagnostic Ablations:** These ablations progressively remove components of the filtering formulation, starting from the full SC-RFA model (M2) and simplifying toward standard attention. Their purpose is to isolate which mechanisms are required for stable extrapolation. 

- **M2.1: Exponential Kernel.** M2 with Student’s - _t_ influence function replaced by an exponential weighting, i.e., _wij_ = exp( _−d_[2] _ij[/ν]_[)][.][This isolates the effect of heavy-tailed robust reweighting under the same dynamical precision] prior. 

- **M2.2: Flat Precision Prior.** M2 with noise parameters removed so that _**P**_ ∆ _t_ is constant across time lag. Tests whether dynamics alone suffice without uncertainty accumulation. 

- **M2.3: No Multiplicative Gate.** M2 with the multiplicative gating term _**P**_ ∆ _t_ set to a constant, to test the impact of the additive bias _**B**_ ∆ _t_ in isolation. 

- **M2.4: No Value Frame Alignment.** M2 without value rotation and counter-rotation, testing the necessity of aggregating in a shared temporal frame. 

- **M2.5: No Rotational Dynamics.** M2 without rotations applied to queries, keys, or values, isolating the effect of decay-only dynamics. 

- **M2.6: Unitary Dot-Product Limit.** No decay, no process or measurement noise, and no magnitude normalization, so that attention weights reduce to normalized complex dot products between unit-modulus rotated embeddings. This yields a unitary, phase-only attention mechanism analogous to RoPER (Harik, 2023). 

35 

**Robust Filter Attention** 

## **F. Additional Experimental Results** 

## **F.1. Training Dynamics and Extrapolation Behavior** 

To assess learning efficiency, we track validation perplexity throughout training (Fig. 6a). Both RFA (M1) and SC-RFA (M2) converge faster than RoPE (B1) and ALiBi (B2), reaching lower validation perplexity earlier in training. This suggests that the SDE-based prior provides a more informative inductive bias for latent state estimation than purely geometric positional encodings. SC-RFA consistently outperforms Isotropic RFA, indicating that spectral coupling improves both optimization and final accuracy. 

Figure 6b visualizes training dynamics and length extrapolation trends corresponding to the tabulated results in Section 4. RFA variants converge faster and degrade more gradually with context length than RoPE, while ALiBi remains stable due to its enforced locality. 

**==> picture [317 x 185] intentionally omitted <==**

**==> picture [166 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a)  Validation perplexity over training epochs.<br>**----- End of picture text -----**<br>


**==> picture [317 x 189] intentionally omitted <==**

**==> picture [316 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(b)  Test perplexity under length extrapolation beyond the training window (512 tokens).<br>**----- End of picture text -----**<br>


_Figure 6._ **Training dynamics and length extrapolation on WikiText-103.** RFA variants converge faster during training and degrade more gradually with increasing context length than RoPE, while ALiBi remains stable due to enforced locality. 

Figure 7 shows the sensitivity analysis over damping values _b_ reported in Table 2. Increasing damping improves long-range stability by suppressing high-frequency propagation, but excessively large damping degrades short-range modeling. The optimal trade-off among the values we tested occurs near _b ≈_ 5 _×_ 10 _[−]_[2] , which maximizes medium-range context utilization 

36 

**Robust Filter Attention** 

while preserving stability. 

**==> picture [317 x 188] intentionally omitted <==**

_Figure 7._ **Impact of the Damping Coefficient** _b_ **on Length Extrapolation.** Perplexity curves for varying _b_ demonstrate that higher damping coefficient values effectively stabilize long-range integration. 

## **F.2. Parameter Dynamics in RFA** 

Learned measurement and process noise parameters over the course of training are shown in Fig. 8 for the last layer of both RFA (M1) and SC-RFA (M2). The learned noise parameters reveal structured head specialization and adaptive uncertainty calibration. Distinct trajectories in query and key noise parameters indicate that different heads self-organize into separate signal-to-noise regimes. We plot inverse temperature _τs_ and robustness parameter _ν/d_ in Fig. 9. 

In general, lower-decay heads tend to converge to lower measurement noise variance ( _η_[2] _, γ_[2] ), lower robustness parameter ( _ν/d_ ), and higher inverse temperature _τs_ , consistent with stable long-range integration, while higher-decay heads tend to tolerate larger measurement noise and focus on local structure. 

Intermediate heads tend to converge to the highest measurement noise variance, lowest steady-state process uncertainty, and strongest robustness, consistent with modeling heterogeneous and noisy mid-range structure, while extreme short- and long-range heads tend to remain more tolerant to outliers. 

The spectrally coupled model (M2, SC-RFA) exhibits lower average query and key noise variance and more clustered trajectories across heads. 

When initialized in the diffusive regime, we observed that higher-decay heads consistently transitioned into the integrative regime ( _α >_ 0), while the lowest-decay heads remained diffusive (Fig. 10). 

37 

**Robust Filter Attention** 

**==> picture [234 x 122] intentionally omitted <==**

**==> picture [234 x 122] intentionally omitted <==**

**==> picture [487 x 310] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) M1 Query Measurement Noise Variance ( γ [2] ) (b) M2 Query Measurement Noise Variance ( γ [2] )<br>(c) M1 Key Measurement Noise Variance ( η [2] ) (d) M2 Key Measurement Noise Variance ( η [2] )<br>(e) M1 Steady State Process Variance ( σ [2] / 2 µ ) (f) M2 Steady State Process Variance ( σ [2] / 2 µ )<br>**----- End of picture text -----**<br>


_Figure 8._ variance for M1 and M2, over the course of training. **Measurement and Process Noise Parameters Comparison.** (Note that _σ_ ˜[2] is undefined for heads 0 and 1, withQuery and key measurement noise variance and state process _µ_ = 0.) 

38 

**Robust Filter Attention** 

**==> picture [234 x 120] intentionally omitted <==**

**==> picture [234 x 120] intentionally omitted <==**

**==> picture [487 x 164] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) M1 Robustness Parameter ( ν/d ) (b) M2 Robustness Parameter ( ν/d )<br>(c) M1 Inverse Temperature ( τ ) (d) M2 Inverse Temperature ( τ )<br>**----- End of picture text -----**<br>


_Figure 9._ **Robustness and inverse temperature.** Robustness parameter and inverse temperature for M1 and M2, over the course of training. 

**==> picture [234 x 122] intentionally omitted <==**

**==> picture [234 x 123] intentionally omitted <==**

**==> picture [433 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Phase parameter  α  by head (M2) (b) Diffusive  → integrative transition during training<br>**----- End of picture text -----**<br>


_Figure 10._ **Integrative dynamics in SC-RFA.** (a) Phase parameter ( _α_ ) under standard initialization, showing specialization across heads. (b) When initialized in the diffusive regime ( _α <_ 0), most heads transitioned into the integrative regime ( _α >_ 0) during training, while the two lowest-decay heads remained diffusive. (Note that _α_ is undefined for heads 0 and 1, with _µ_ = 0.) 

39 

**Robust Filter Attention** 

## **F.3. Analysis of Attention Matrices** 

We plot attention matrices at a context length of 4096 to visualize long-range behaviors induced by each positional prior: the baselines RoPE (B1) (Fig 11) and ALiBi (B2) (Fig 12); and the RFA (M1) (Fig 13) and SC-RFA (M2) (Fig 14) models. We use attention matrices from the last layer of each model. 

**Note:** For the RFA models, for improved visualization, we plot the unattenuated attention matrix _**A**_ **[ˆ]** rather than the physical (decayed) attention matrix _**A**_ := _**A**_ **[ˆ]** _⊙_ _**E**_ (see Appendix B.3.3). 

**==> picture [439 x 222] intentionally omitted <==**

_Figure 11._ **Baseline RoPE Transformer (B1) at** _L_ = 4096 **:** Attention map exhibits persistent checkerboard structure. 

**==> picture [439 x 224] intentionally omitted <==**

_Figure 12._ **ALiBi Transformer (B2) at** _L_ = 4096 **:** Attention map remains tightly localized to the diagonal across all heads, with only modest widening in higher heads. Long-range structure is suppressed rather than integrated. 

40 

**Robust Filter Attention** 

**==> picture [439 x 257] intentionally omitted <==**

_Figure 13._ **Robust Filter Attention (M1) at** _L_ = 4096 **:** RFA demonstrates emergent scale separation and dynamical consistency. Periodic bands are clearly visible. High-decay heads concentrate focus on the local diagonal, while low-decay heads exhibit the **Integrative (Opening Gate)** regime: the bottom-right corner near the diagonal is suppressed as the model waits for the SDE dynamics to suppress initial measurement noise before assigning high precision to the state estimate. 

**==> picture [439 x 257] intentionally omitted <==**

_Figure 14._ **Spectrally-Coupled RFA (M2,** _b_ = 0 _._ 05 **) at** _L_ = 4096 **.** Frequency-dependent damping ( _µh_ = _b · ωh,_ max) substantially alters long-range attention structure. SC-RFA has fewer periodic bands than RFA. Heads 3-5 each have only a single band, which become narrower and moves closer to the diagonal as decay increases. 

41 

**Robust Filter Attention** 

The attention maps for RoPE exhibit persistent “checkerboard” artifacts and high-frequency oscillations that remain visible even at large temporal offsets. A possible explanation is that, because RoPE implicitly assumes zero decay, high-frequency spectral components remain unattenuated into the far-field context, and may fail to settle into a smooth summary, potentially contributing to the chaotic, non-local attention patterns observed at long distances. 

In ALiBi, attention remains strongly localized to the diagonal across all heads, reflecting ALiBi’s fixed distance-based bias. Higher heads exhibit modestly broader receptive fields, but attention never transitions to a global integrative regime: long-range context is suppressed rather than accumulated, yielding stable extrapolation through enforced locality rather than dynamical state propagation. 

The periodic banding visible in M1 and M2 is more clearly visible than in RoPE. By rotating values into a stationary frame before aggregation, RFA preserves dynamical phase relationships. In contrast, RoPE aggregates in the observation frame, potentially causing cumulative phase lag and destructive interference across time. 

In some low-decay heads, RFA exhibits a distinct “opening gate” behavior where the attention weight for a given query is not maximal at the immediate diagonal (∆ _t_ = 0), but instead peaks at a specific historical lag. This is visible as a dark band directly following the diagonal, which then transitions into a bright region of high-precision attention. This is visible, for example, in heads 3 and 4 of SC-AFA. 

Coupling decay to frequency ( _µh_ = _b · ωh,_ max) causes different heads to specialize at different time scales. Compared to M1, where heads mix many oscillatory patterns, intermediate heads in M2 (Heads 3–5) show fewer, sharper periodic bands. As frequency (and thus decay) increases, these bands become narrower and concentrate closer to the diagonal. For high-decay heads (6 and 7), structure in the attention map is confined to a narrow band near the diagonal, while the flat horizontal bands indicate that the model has reached its precision floor. By head 8, the attention map becomes effectively diagonal. 

Spectral coupling in SC-RFA (M2) restores clean vertical attention lines corresponding to retrieval of salient “anchor” tokens. In purely rotational models like RoPE, such content-based signals are often obscured by checkerboard aliasing, where high-frequency positional jitter propagates without decay and creates widespread interference. By selectively damping fast frequencies, SC-RFA suppresses this positional noise, allowing low-frequency heads (Heads 1–3) to lock onto globally significant tokens and maintain high-precision connections over long horizons. 

In SC-RFA (M2), attention maps exhibit clear vertical structures corresponding to repeated retrieval of salient “anchor” tokens. This suggests that by coupling higher frequencies with stronger decay, SC-RFA reduces the influence of rapidly varying components, allowing lower-frequency heads (Heads 1–3) to more consistently attend to globally relevant tokens over long contexts. Taken together, these patterns suggest that RFA models learn physically meaningful multi-scale filtering behavior, rather than merely exploiting dataset-specific positional correlations. 

42 

