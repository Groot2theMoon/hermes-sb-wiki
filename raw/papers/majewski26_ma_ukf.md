# Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation of Sigma-Point Weights 

Kenan Majewski*, Michał Modzelewski, Marcin Zugaj,[˙] Piotr Lichota 

_Institute of Aeronautics and Applied Mechanics Warsaw University of Technology_ Warsaw, Poland *kenan.majewski.dokt@pw.edu.pl 

_**Abstract**_ **—The Unscented Kalman Filter (UKF) is a ubiquitous tool for nonlinear state estimation; however, its performance is limited by the static parameterization of the Unscented Transform (UT). Conventional weighting schemes, governed by fixed scaling parameters, assume implicit Gaussianity and fail to adapt to time-varying dynamics or heavy-tailed measurement noise. This work introduces the Meta-Adaptive UKF (MA-UKF), a framework that reformulates sigma-point weight synthesis as a hyperparameter optimization problem addressed via memoryaugmented meta-learning. Unlike standard adaptive filters that rely on instantaneous heuristic corrections, our approach employs a Recurrent Context Encoder to compress the history of measurement innovations into a compact latent embedding. This embedding informs a policy network that dynamically synthesizes the mean and covariance weights of the sigma points at each time step, effectively governing the filter’s trust in the prediction versus the measurement. By optimizing the system end-to-end through the filter’s recursive logic, the MA-UKF learns to maximize tracking accuracy while maintaining estimation consistency. Numerical benchmarks on maneuvering targets demonstrate that the MA-UKF significantly outperforms standard baselines, exhibiting superior robustness to non-Gaussian glint noise and effective generalization to out-of-distribution (OOD) dynamic regimes unseen during training.** 

_**Index Terms**_ **—Unscented Kalman Filter, Meta-Learning, Adaptive Filtering, Nonlinear Estimation, Robust Tracking** 

## I. INTRODUCTION 

The Unscented Kalman Filter (UKF) has established itself as a standard of nonlinear state estimation since its inception by Julier and Uhlmann [1]. By propagating a deterministic set of sigma points through the nonlinear system dynamics, the UKF captures posterior moments accurate to the third order for Gaussian inputs, circumventing the linearization errors inherent in the Extended Kalman Filter (EKF) without requiring explicit Jacobian calculations [2]. However, the performance of the standard UKF is strictly governed by the parameterization of the Unscented Transform (UT), specifically, the scaling parameters ( _α_ , _β_ , _κ_ ) that determine the spread and weighting of the sigma points. While early efforts have explored modelbased learning to optimize these sigma points [3], conventional implementations still largely rely on static parameters selected _a priori_ based on implicit assumptions of Gaussianity and stationary noise statistics. Consequently, the filter’s adaptability 

This work has been submitted to the IEEE for possible publication. Copyright may be transferred without notice, after which this version may no longer be accessible. 

is severely limited in complex environments characterized by maneuvering targets, non-stationary dynamics, or heavy-tailed measurement noise [4]. 

To address these limitations, the field of Adaptive Kalman Filtering (AKF) has historically relied on heuristic noise estimation methods, such as Sage-Husa estimators [5] or Interacting Multiple Model (IMM) architectures [6]. While IMMs offer robustness by switching between varying dynamic models, they are computationally expensive and rely on a predefined, finite set of modes. More recently, the convergence of signal processing and deep learning has given rise to the broader paradigm of AI-aided Kalman filters [7]. Historically, the relationship between recursive estimators and neural networks was often inverted, such as using EKFs to explicitly train the weights of Recurrent Neural Networks (RNNs) [8]. Today, deep learning actively enhances state estimation logic. Recent literature features model-based deep learning for maneuvering targets [9], self-supervised deep state-space models for tracking [10], and hybrid architectures that fuse RNNs with Kalman variants for complex trajectory prediction [11] and real-time sensor drift compensation [12]. 

In parallel, advancements in Differentiable Filtering enable filter parameters to be optimized end-to-end via backpropagation [13], [14]. This concept has successfully been expanded across various Bayesian estimators, including end-toend learning for differentiable particle filters [15] and neuralaugmented adaptive grids for point-mass filters [16]. For continuous state spaces, approaches such as KalmanNet [17] learn to dynamically adjust the Kalman gain or noise covariances from data streams. While these methods improve state estimation, many largely treat the underlying sigma-point geometry as a fixed inductive bias. 

Recognizing this gap, modern studies have begun to explicitly target the adaptation of the Unscented Transform. Recent frameworks have proposed data-driven unknown input estimation for sigma-point filters [18], and utilized RNNs to auto-tune standard UKF hyperparameters dynamically [19]. Furthermore, neural networks have recently been proposed to fine-tune the explicit spatial placement of sample points in Gaussian filters [20]. However, these approaches still largely focus on tuning standard scalar constraints or rely on instantaneous heuristic corrections, stopping short of reformulating the full synthesis of the UT as a continuous hyper-control 

problem. 

Leveraging advancements in Gradient-Based MetaLearning [21], [22], particularly foundational works that cast ”learning to learn” as a temporal sequence modeling problem via Memory-Augmented architectures [23], [24], we propose a novel framework that reformulates the tuning of sigma-point weights as a sequential decision-making process. In this context, the filter is viewed as a differentiable computational graph where hyperparameters are adapted in real-time to unseen dynamic regimes. This represents a shift from static model-based estimation to context-aware meta-learning, where adaptation logic is amortized into the hidden states of an RNN. 

In this work, we introduce the Meta-Adaptive UKF (MAUKF). In contrast to end-to-end neural architectures that bypass state-space modeling, our framework maintains the structural integrity of the Bayesian recursion while adaptively regulating the UT parameters through a learned policy. Central to our architecture is a Recurrent Context Encoder [25], which compresses the history of measurement innovations into a latent embedding. This embedding enables the system to distinguish between dynamic maneuvers and sensor anomalies without explicit mode-switching logic. A policy network then maps this context to the optimal mean and covariance weights for the sigma points, satisfying the mathematical convexity constraints of the UT. By training the system end-to-end using analytical gradients through time [26], the MA-UKF learns to balance instantaneous tracking accuracy with long-term estimation stability. 

The contributions of this paper are threefold: 

- 1) **Differentiable Meta-Filtering:** We cast the Unscented Transform parameterization as a bi-level optimization problem within a differentiable computational graph. This enables end-to-end learning of optimal, data-driven sigma-point weights via analytical gradients through time.. 

- 2) **Memory-Augmented Adaptation:** We introduce a Recurrent Context Encoder that compresses innovation history into a latent embedding. This temporal context drives a learned policy to dynamically modulate the sigma-point weights in real-time, effectively distinguishing actual maneuvers from sensor anomalies. 

- 3) **Robustness and OOD Generalization:** We demonstrate that the MA-UKF significantly outperforms optimized standard filters and IMM baselines under heavy-tailed glint noise. Crucially, the learned policy exhibits strong out-of-distribution (OOD) generalization, maintaining accurate tracking against high-agility maneuvers unseen during training. 

The remainder of this paper is organized as follows: Section II provides the theoretical framework, detailing the Unscented Transform and the Meta-Learning objective. Section III describes the proposed MA-UKF architecture and the training methodology. Section IV presents the experimental setup and comparative results. Finally, Section V concludes the paper and outlines future research directions. 

## II. THEORETICAL FRAMEWORK 

## _A. Problem Definition_ 

Consider the state estimation problem for a discrete-time nonlinear dynamic system. While standard filtering approaches assume the system follows nominal Gaussian statistics, practical applications often involve regime shifts and distributional mismatches. Let the true generative process be defined by: 

**==> picture [203 x 26] intentionally omitted <==**

where **x** _k ∈_ R _[n][x]_ is the state vector at time step _k_ , **z** _k ∈_ R _[n][z]_ is the measurement vector, and _f_ : R _[n][x] →_ R _[n][x]_ and _h_ : R _[n][x] →_ R _[n][z]_ are nonlinear transition and observation functions, respectively. 

In standard formulations, the process noise **w** _k_ and measurement noise **v** _k_ are assumed to be drawn from fixed Gaussian distributions, i.e., _Dw_ = _N_ ( **0** _,_ **Q** ) and _Dv_ = _N_ ( **0** _,_ **R** ). However, in robust tracking scenarios (e.g., maneuvering targets or radar glint), the true distributions _Dw_ and _Dv_ are time-varying, multimodal, or characterized by non-zero skewness and high kurtosis. 

**==> picture [253 x 93] intentionally omitted <==**

where _τ_ = ( **x** 0: _T ,_ **z** 1: _T_ ) represents a trajectory sampled from the true system distribution _Pτ_ . Unlike traditional adaptive filtering, which attempts to explicitly estimate time-varying noise covariances **Q** or **R** , we seek to optimize the internal integration parameters of the filter itself directly via the parameter set _θ_ . 

## _B. Standard Unscented Kalman Filter Formulation_ 

The UKF approximates the state distribution using a set of 2 _nx_ + 1 sigma points, _Xk−_ 1 = _{Xk[i] −_ 1 _[}]_[2] _i_ =0 _[n][x]_[,][with][associated] weights _Wi_[(] _[m]_[)] for the mean and _Wi_[(] _[c]_[)] for the covariance. ˆ Given the posterior estimate **x** _k−_ 1 and covariance **P** _k−_ 1 from the previous step, the sigma points are generated as: 

**==> picture [246 x 56] intentionally omitted <==**

where [ _·_ ] _i_ denotes the _i_ -th column of the matrix square root, typically computed via the lower-triangular Cholesky decomposition. The scaling parameter is defined as _λ_ = _α_[2] ( _nx_ + _κ_ ) _− nx_ , where _α_ controls the spread of the sigma points and _κ_ is a secondary scaling parameter. 

The constant weights corresponding to these points are given by: 

**==> picture [220 x 48] intentionally omitted <==**

**==> picture [220 x 24] intentionally omitted <==**

where _β_ is a scalar parameter used to incorporate prior knowledge of the underlying distribution (typically _β_ = 2 for optimal Gaussian approximations). 

**Prediction Step:** The sigma points are propagated through the nonlinear process function: 

**==> picture [167 x 14] intentionally omitted <==**

The _a priori_ state mean and covariance are computed via weighted recombination: 

**==> picture [247 x 64] intentionally omitted <==**

**Update Step:** The propagated sigma points are then passed through the measurement function: 

**==> picture [171 x 14] intentionally omitted <==**

The predicted measurement mean **z** ˆ _[−] k_[,][innovation][covariance] **P** _zz_ , and cross-covariance **P** _xz_ are computed as: 

**==> picture [247 x 98] intentionally omitted <==**

Finally, the Kalman gain **K** _k_ is computed, and the posterior estimates are updated: 

**==> picture [182 x 12] intentionally omitted <==**

**==> picture [179 x 12] intentionally omitted <==**

**==> picture [181 x 13] intentionally omitted <==**

_C. The Paradigm of Differentiable Filtering_ 

Differentiable Filtering represents the convergence of Bayesian recursive estimation and deep learning. Traditionally, Kalman filters and neural networks were treated as separate entities: the former as model-based estimators and the latter as data-driven approximators. In the Differentiable Filtering paradigm, the filter itself is cast as a computational graph, analogous to a RNN, but with an inductive bias strictly imposed by the physical equations of motion and the Bayesian update rules [13], [14], [27]. 

Let _Fθ_ denote the single-step UKF update function defined by equations (4) through (19). We can view the filter state at time _k_ as a tuple **s** _k_ = (ˆ **x** _k,_ **P** _k_ ). The filter evolution is then expressed as a differentiable recurrence: 

**==> picture [166 x 11] intentionally omitted <==**

where _θ_ represents the tunable parameters (e.g., the policy network weights governing sigma-point scaling). Crucially, operations such as the Cholesky decomposition required for the matrix square root in (5) and (6) are differentiable for positive-definite matrices. This enables the continuous flow of gradients through the stochastic covariance parameters of the filter [28]. 

To optimize _θ_ , we compute the gradient of the cumulative loss _L_ with respect to the parameters. Since the parameters _θ_ influence the entire trajectory, we employ Backpropagation Through Time (BPTT) [29]. Applying the chain rule, the total gradient is the accumulation of gradients at each time step: 

**==> picture [168 x 30] intentionally omitted <==**

where the total state derivative _[d] dθ_ **[s]** _[k]_[is][computed][recursively:] 

**==> picture [190 x 23] intentionally omitted <==**

Here, _∂∂_ **s** _Fk−θ_ 1[is the Jacobian of the UKF update step, capturing] exactly how uncertainty **P** _k−_ 1 propagates through the system nonlinearities _k_ . By unrolling this computational graph and optimizing _θ_ via automatic differentiation, we successfully retain the structural interpretability of the Kalman filter while gaining the data-driven adaptability of neural networks. 

_D. Context-Driven Meta-Policy Formulation_ 

A fundamental limitation of the standard UKF is the static parameterization of the UT. The weights _W_ = _{W_[(] _[m]_[)] _, W_[(] _[c]_[)] _}_ enforce a time-invariant geometry on the sigma points, implicitly assuming that the system’s nonlinearity and noise statistics remain stationary. In dynamic environments, this rigidity forces a compromise between tracking agility (high reactivity) and noise suppression (high stability). 

To resolve this, we reformulate the filtering problem within the paradigm of _Differentiable Programming_ [24]. We treat the UKF not as a fixed algorithm, but as a directed computational graph, parameterized by a meta-policy _πθ_ . This policy functions as a hyper-controller, dynamically modulating the filter’s integration parameters based on the estimation context. 

At each time step _k_ , the policy processes the measurement innovation _**ν** k_ . This proxy signal is used to update a recurrent hidden state **h** _k_ . This latent state summarizes the history of the trajectory, allowing the network to distinguish between transient maneuvers and non-physical sensor noise. The adaptive weights are then synthesized as: 

**==> picture [190 x 11] intentionally omitted <==**

**==> picture [194 x 14] intentionally omitted <==**

These dynamic weights are immediately injected into the standard UKF prediction and update cycle to produce the posterior state estimate **x** ˆ _k_ . 

This architecture constitutes a bi-level optimization problem [30]. The _inner loop_ performs the recursive Bayesian state estimation, while the _outer loop_ optimizes the policy parameters _θ_ . Since the constituent operations of the UKF, including matrix multiplication, Cholesky decomposition, and linear system solution, are differentiable almost everywhere, the gradient of the cumulative estimation error _∇θL_ can be computed analytically via BPTT. 

## III. META-ADAPTIVE UNSCENTED KALMAN FILTER 

This section details the architecture of the proposed MetaAdaptive UKF (MA-UKF). The framework is designed to decouple the physical state propagation from the statistical parameterization of the filter. As illustrated in Fig. 1, the system comprises three functional modules: innovation feature extraction, recurrent context encoding, and convex weight synthesis. 

## _A. Innovation Feature Extraction_ 

In recursive estimation, the innovation sequence _**ν** k_ constitutes the primary signal for adaptation. While classical adaptive filters utilize scalar metrics such as the Normalized Innovation Squared (NIS) to trigger heuristic logic [31], raw innovation magnitudes are highly sensitive to sensor modality, target range, and scale. 

To ensure numerical stability and facilitate efficient gradient propagation, we employ a learnable feature extraction stage. To circumvent the cyclic dependency we compute a _proxy innovation_ _**ν**_ ˜ _k ∈_ R _[n][z]_ using the nominal geometric spread from the previous time step: 

**==> picture [189 x 30] intentionally omitted <==**

This raw signal is projected into a high-dimensional feature space via a linear projection followed by Layer Normalization [32]: 

**==> picture [210 x 11] intentionally omitted <==**

where **W** in _∈_ R _[d][h][×][n][z]_ is a learnable projection matrix, **b** in _∈_ R _[d][h]_ is a bias, and **e** _k ∈_ R _[d][h]_ denotes the static feature vector of the instantaneous residual. This normalization is essential for robustness in the glint noise regime, where outlier measurements may exceed nominal variances by several orders of magnitude. 

## _B. Recurrent Context Encoding_ 

Instantaneous residuals alone are insufficient to distinguish between measurement outliers and the onset of a maneuver. While both phenomena yield large norms _∥_ _**ν** k∥_ , they exhibit distinct temporal structures: glint is typically uncorrelated and transient, whereas maneuvers manifest as correlated, lowfrequency trends. 

To capture these temporal dependencies, we employ a Gated Recurrent Unit (GRU). The GRU functions as a non-linear Infinite Impulse Response (IIR) filter, integrating information over time to update a latent context embedding **h** _k ∈_ R _[d][h]_ . The update dynamics are governed by: 

**==> picture [219 x 26] intentionally omitted <==**

**==> picture [219 x 13] intentionally omitted <==**

**==> picture [219 x 13] intentionally omitted <==**

where _σg_ ( _·_ ) denotes the sigmoid activation, _⊙_ represents the Hadamard product, and **u** _k_ and **r** _k_ are the update and reset gates, respectively. The parameter matrices are defined as **W** _u,_ **W** _r,_ **W** _h ∈_ R _[d][h][×][d][h]_ for the input weights, and **U** _u,_ **U** _r,_ **U** _h ∈_ R _[d][h][×][d][h]_ for the recurrent weights, with corresponding biases **b** _u,_ **b** _r,_ **b** _h ∈_ R _[d][h]_ . This mechanism allows the policy to selectively suppress high-frequency noise while retaining sensitivity to genuine dynamic shifts. 

## _C. Convex Sigma-Point Weight Synthesis_ 

The core contribution of the MA-UKF is the learned policy mapping _πθ_ : **h** _k →Wk_ , which dynamically synthesizes the Unscented Transform parameters. First, the high-dimensional hidden state is projected onto a lower-dimensional context manifold **c** _k ∈_ R _[d][p]_ : 

**==> picture [228 x 11] intentionally omitted <==**

where **W** _proj ∈_ R _[d][p][×][d][h]_ and **b** _proj ∈_ R _[d][p]_ . 

A critical constraint in Unscented filtering is the numerical stability of the covariance update, which requires the covariance matrices to remain positive semi-definite. Standard parameterizations (e.g., utilizing negative _λ_ values) can yield non-positive definite matrices, inducing numerical instability and potentially leading to Cholesky decomposition failures during training. To guarantee stability, we enforce a _convexity constraint_ on the sigma-point weights. The mean weights _W_[(] _[m]_[)] and covariance weights _W_[(] _[c]_[)] are generated via a Softmax function: 

**==> picture [182 x 51] intentionally omitted <==**

where **W** _π_[(] _[m]_[)] _∈_ R[(2] _[n][x]_[+1)] _[×][d][p]_ and **b**[(] _π[m]_[)] _∈_ R[2] _[n][x]_[+1] . The covariance weights _W_[(] _[c]_[)] are computed similarly. This constraint ensures that[�] _i[W][i]_[=][1][and] _[W][i][>]_[0][,][guaranteeing][that][the] predicted covariance **P** _[−] k_[remains][positive][definite.][While][this] restriction prevents the filter from capturing the higher-order kurtosis effects possible with negative weights, it provides the strict stability guarantee required for end-to-end differentiable training, ensuring that the Cholesky decompositions in the UKF remain valid throughout the optimization process. 

**==> picture [516 x 125] intentionally omitted <==**

**----- Start of picture text -----**<br>
Meta-Learning Loop<br>h k− 1 h k<br>GRU<br>z k − ν ˜ k Encoder e k ProjectionContext c k PolicyHead ConstraintSoftmax Wk<br>Wk− 1 Reweighting<br>Decoder<br>Pk− 1 Differentiable UKF<br>x ˆ k− 1 SigmaGenerationPoint Dynamics f ( · ) Xk|k− 1 Measurement h ( · ) Zk|k− 1 P k<br>UKF Step<br>x ˆ k<br>**----- End of picture text -----**<br>


Fig. 1. Architecture of the Meta-Adaptive UKF (MA-UKF). A Recurrent Context Encoder processes the innovation history to generate a latent context embedding, which drives a policy network to modulate the sigma-point weights in real-time. 

## _D. Algorithm and Computational Flow_ 

The recursive execution of the MA-UKF is summarized in Algorithm 1. A key design principle is the decoupling of the optimization burden: the computationally expensive training of the meta-policy is performed offline, allowing the dynamic, real-time adaptation of the filter parameters to be executed online via a highly efficient single forward pass of the lightweight RNN. 

**==> picture [253 x 274] intentionally omitted <==**

## _E. Computational Complexity Analysis_ 

For real-time tracking applications, computational efficiency is paramount. The overhead introduced by the Meta-Adaptive block is governed by the feature extraction, GRU state update, and policy projection layers, yielding an additive time complexity of _O_ ( _d_[2] _h_[+] _[d][h][n][z]_[+] _[d][h][d][p]_[+] _[n][x][d][p]_[)][.][Given][the] compact dimensionality of the proposed architecture ( _nx_ = 

5 _, nz_ = 2 _, dh_ = 32 _, dp_ = 16), this neural inference sequence strictly requires on the order of a few thousand floatingpoint operations (FLOPs) per recursive cycle. By leveraging highly optimized dense matrix operations, this forward pass incurs sub-microsecond latency on contemporary microprocessors. Consequently, the total execution time of the MAUKF imposes negligible overhead relative to a standard singlemodel UKF, whose performance bottleneck remains the _O_ ( _n_[3] _x_[)] Cholesky decomposition and covariance updates. Crucially, this allows the MA-UKF to achieve robust adaptation while entirely circumventing the _O_ ( _M · n_[3] _x_[)][multiplicative][scaling] inherent to IMM architectures evaluating _M_ parallel hypotheses. 

## _F. Training via End-to-End Analytical Gradients_ 

We formulate the policy optimization as a supervised regression problem over a dataset of _N_ trajectories. The loss function _Lθ_ comprises a primary tracking error term and an auxiliary regularization term: 

**==> picture [248 x 30] intentionally omitted <==**

Here _g_ ( _·_ ) is an auxiliary decoder, weighted by _λaux_ , that reconstructs the innovation from the latent context **c** _k_ . This regularization encourages the latent state **h** _k_ to retain a rich representation of the innovation sequence, preventing mode collapse during training. 

## IV. EXPERIMENTAL EVALUATION 

To validate the efficacy of the proposed MA-UKF, we conducted a series of numerical experiments focusing on robust tracking in the presence of heavy-tailed measurement noise and unmodeled dynamic maneuvers. We benchmark the method against a nominal UKF, a hyperparameter-optimized UKF, and an IMM filter. 

## _A. Simulation Environment and Datasets_ 

We consider a 2D radar tracking scenario where the state vector **x** = [ _px, vx, py, vy, ω_ ] _[⊤]_ evolves according to the Coordinated Turn (CT) kinematic model with a discrete-time 

sampling interval of ∆ _t_ = 0 _._ 1 seconds. The radar provides noisy range and bearing measurements: 

**==> picture [211 x 19] intentionally omitted <==**

_1) Training Regime (Stochastic CT):_ The MA-UKF is trained on a synthetic dataset of stochastic trajectories generated via the standard CT model. For each trajectory, the initial state **x** 0 is randomized: positions _px, py_ are sampled from _U_ ( _−_ 1000 _,_ 1000) m, while the velocity is defined by a speed _v ∼U_ (10 _,_ 30) m/s and a heading _φ ∼U_ (0 _,_ 2 _π_ ) rad. The turn rate is drawn from _ω ∼U_ ([ _−_ 0 _._ 5 _, −_ 0 _._ 1] _∪_ [0 _._ 1 _,_ 0 _._ 5]) rad/s, ensuring the model is trained on distinct left and right maneuvers rather than near-zero turn rates. The noise **v** _k_ is drawn from a Gaussian Mixture Model (GMM): 

**==> picture [201 x 12] intentionally omitted <==**

where _ϵ_ = 0 _._ 1 represents a 10% probability of a glint outlier (signal spike), and **R** is the nominal sensor noise covariance, and _η_ = 20 is the glint scaling factor. 

_2) Evaluation Regime (OOD Generalization):_ Crucially, the evaluation is performed on a dataset representing a dynamic regime unseen during training. We utilize a highagility weave maneuver, where the target undergoes sinusoidal acceleration with randomized parameters: 

**==> picture [205 x 16] intentionally omitted <==**

For each evaluation sequence, the amplitudes _Ax_ , _Ay_ are sampled from _U_ ([ _−_ 20 _, −_ 10] _∪_ [10 _,_ 20]) m/s[2] and frequencies _ωx_ , _ωy_ from _U_ ( _−_ 2 _,_ 2) rad/s. 

This trajectory violates the constant turn-rate assumption inherent in the filter’s state transition function ( _f_ ( _·_ )). Furthermore, we test the robustness of the filter by doubling the severity of the measurement outliers during evaluation, setting the glint scaling factor to _η_ = 40. This combination of unmodeled dynamics and extreme noise strictly tests the generalization capability of the learned policy. 

## _B. Implementation and Baselines_ 

All models were implemented in Python using the JAX and Equinox libraries for differentiable programming. The MA-UKF was trained for 1800 epochs using the Adam optimizer ( _lr_ = 10 _[−]_[3] ) with a batch size of 64 and sequence length of 60 on an NVIDIA RTX 3060 GPU. 

**Baseline 1: Nominal UKF.** We compare against a standard UKF tuned for nominal performance. While the UT often employs a small spread ( _α_ = 10 _[−]_[3] ) to approximate local linearization, such settings are numerically unstable in highnoise regimes. Consequently, we adopt the parameterization proposed by [1]: _α_ = 1 _._ 0, _β_ = 2 _._ 0, and _κ_ = 3 _− nx_ . This setting places sigma points at _±√_ 3 _σ_ from the mean, capturing the fourth-order moment of the Gaussian distribution and providing sufficient geometric spread. The process noise covariance **Q** and measurement noise **R** are fixed to the nominal ground-truth values. 

**Baseline 2: Optimized UKF (UKF** _[⋆]_ **).** To establish a rigorous baseline, we utilized the Optuna framework to perform a hyperparameter optimization search over 100 trials. The resulting parameters ( _α ≈_ 17 _._ 26, _β ≈_ 2 _._ 59, _κ ≈_ 0 _._ 15) represent the empirical upper bound of performance for a static UKF on this specific dataset. 

**Baseline 3: IMM-UKF.** : We also employ an IMM filter mixing two UKF modes: a Constant Velocity (CV) mode for straight-line motion and a CT mode for maneuvers [33]. The transition probability matrix diagonal is fixed at Π _ii_ = 0 _._ 95. A hyperparameter-optimized version (IMM-UKF _[⋆]_ ) is also evaluated. 

**Proposed MA-UKF.** The policy network utilizes a GRU with a hidden dimension of _dh_ = 32. The context encoder projects the innovation proxy _**ν**_ ˜ _k_ into the hidden space, and a subsequent projection layer maps the GRU output to a lower-dimensional manifold ( _dp_ = 16) before the final policy head synthesizes the sigma-point weights. Throughout both the training and evaluation phases, the scaling parameter governing the sigma-point spread is fixed at _γ_ = 3. 

## _C. Quantitative Results_ 

We conducted a Monte Carlo analysis encompassing _N_ = 1000 independent tracking episodes across both the training dataset and the unseen high-agility weave dataset, with each episode evaluated over a sequence length of 60 time steps. Table I summarizes the Average Root Mean Square Error (ARMSE) and the associated standard deviation for the position estimates. 

TABLE I 

MONTE CARLO PERFORMANCE BENCHMARK (1000 RUNS) 

||**Method**|**Training Regime**<br>ARMSE (m)|**Unseen Maneuver**<br>ARMSE (m)|
|---|---|---|---|
||UKF<br>IMM-UKF<br>UKF_⋆_|105_._0 _±_129_._6<br>86_._4 _±_121_._5<br>17_._8 _±_14_._5|196_._0 _±_229_._9<br>184_._5 _±_175_._8<br>49_._7 _±_33_._9|
||IMM-UKF_⋆_|18_._5 _±_17_._4|58_._0 _±_48_._8|
||**MA-UKF (Ours)**|**6**_._**3** _±_**7**_._**3**|**44**_._**6** _±_**28**_._**8**|



_1) Robustness to Heavy-Tailed Noise:_ In the training regime, where the generative motion model closely aligns with the filter’s internal dynamics, baseline performance is predominantly limited by sensor anomalies. The nominal UKF yields an ARMSE of 105 _._ 0 m, while the optimized UKF _[⋆]_ achieves 17 _._ 8 m. This degradation is directly attributable to the heavy-tailed measurement noise. The standard weighted averaging operation of the UT is highly sensitive to outliers; consequently, a single glint measurement significantly biases the posterior mean and violates the implicit Gaussian assumption. 

In contrast, the MA-UKF achieves an ARMSE of just 6 _._ 3 m, representing a 64.6% reduction in error compared to the optimized UKF _[⋆]_ and a 94.0% reduction against the nominal UKF. By analyzing the latent innovation embedding, the network identifies the spectral signature of glint, characterized by high amplitude and low temporal correlation. The system responds 

by dynamically down-weighting the sigma points. This mechanism seamlessly performs ”soft” outlier rejection without the need for brittle validation gating or explicit thresholds. 

_2) Generalization to Unseen Maneuvers (OOD):_ The evaluation regime leverages a high-agility weave trajectory that presents a severe structural mismatch to the filter’s constant turn-rate prediction model. This scenario tests the algorithm’s capacity to balance model trust against measurement reliance. 

As illustrated in Fig. 2, the baseline filters fail to handle the compounding severity of unmodeled dynamics and extreme noise. The UKF _[⋆]_ exhibits track divergence, losing the target entirely. The IMM-UKF _[⋆]_ , while attempting to switch dynamic models to recapture the target, suffers from massive correction artifacts and erratic, high-amplitude jumps. 

**==> picture [253 x 110] intentionally omitted <==**

Fig. 2. Trajectory tracking performance on the OOD maneuver. The optimized UKF _[⋆]_ (Blue) suffers catastrophic divergence, while the IMM-UKF _[⋆]_ (Green) exhibits violent corrections. The MA-UKF (Red) sustains robust track continuity for longer, and closely hugs the underlying ground truth despite the simultaneous model mismatch and severe glint noise. 

The MA-UKF, conversely, successfully preserves the structural geometry of the ground truth. It maintains consistent track continuity over longer periods and effectively smooths out the severe anomalies, outperforming the UKF _[⋆]_ by 10.3% and the IMM-UKF _[⋆]_ by 23.1%. Crucially, the standard deviation of the MA-UKF error ( _±_ 28 _._ 8 m) is nearly 8 _×_ lower than that of the nominal baseline UKF ( _±_ 229 _._ 9 m). The severe variance in the baselines correlates directly with the divergence events seen in the plot. By modulating the UT weights, the MA-UKF creates a flexible uncertainty manifold that instantaneously inflates the covariance yielding a highly resilient estimate. 

## _D. Analysis of Learned Adaptation Strategy_ 

To elucidate the decision-making logic of the meta-learner, we analyze the temporal evolution of the synthesized sigmapoint weights. Fig. 3 displays the complete set of weight trajectories ( _W_ 0 through _W_ 10) for both the mean ( _W_[(] _[m]_[)] ) and covariance ( _W_[(] _[c]_[)] ) distributions during a representative tracking sequence. 

Contrary to the static parameterization of standard filtering (where UT scaling constants are strictly fixed), the MAUKF exhibits a highly dynamic, context-dependent weighting strategy. Two distinct behavioral paradigms emerge from this analysis, reflecting the network’s dual capacity for steady-state precision and transient robustness: 

**==> picture [253 x 289] intentionally omitted <==**

Fig. 3. Temporal evolution of the learned sigma-point weights ( _W_ 0 to _W_ 10) during the maneuver. The distinct impulsive spiking behavior across the entire geometry, contrasted with the continuous micro-modulation between events, indicates that the policy dynamically expands and contracts the local geometric spread to accommodate rapid directional changes and reject anomalies. 

- 1) **Continuous Micro-Modulation:** Between major dynamic shifts, the entire set of mean and covariance weights represents a continuously shifting geometry, fluctuating dynamically around nominal baselines. This indicates that the filter actively and continuously compensates for localized linearization errors inherent to a fixed UT spread at every individual time step. 

- 2) **Impulsive Covariance Resetting:** Upon detecting unmodeled dynamic shifts or severe glint anomalies, the policy triggers a rapid reconfiguration of the sigma-point weights. As seen in Fig. 3, the distribution maintains mostly flat baseline while triggering sharp, sparse spikes that strictly correlate with maneuver inflection points and outlier events. This coordinated, impulsive action injects structural uncertainty to accommodate unmodeled acceleration, increasing the Kalman gain’s reactivity, while simultaneously leveraging the latent context embedding to gate out non-physical sensor noise. 

These observations visually confirm that the MA-UKF successfully internalizes a control policy. Rather than converging to static optimal parameters, it dynamically orchestrates the 11 pairs of UT weights as control inputs to continuously trade off trust between the process and measurement models, emulating an advanced adaptive filter within a fully continuous, differentiable architecture. 

## V. CONCLUSION AND FUTURE WORK 

This paper introduced the Meta-Adaptive Unscented Kalman Filter (MA-UKF), a novel framework uniting rigorous Bayesian estimation with data-driven meta-learning. By casting the parameterization of the Unscented Transform as an end-to-end differentiable optimization problem, the MA-UKF learns to dynamically modulate its sigma-point geometry in real-time. This enables the filter to autonomously adapt to nonstationary dynamics and out-of-distribution regimes without relying on hand-crafted heuristics. 

Utilizing a Recurrent Context Encoder to map historical innovation sequences into an actionable latent embedding, the proposed architecture effectively disentangles transient sensor anomalies from genuine target maneuvers. Empirical results on complex, out-of-distribution tracking scenarios under heavy-tailed glint noise demonstrate that the MA-UKF achieves robust generalization, reducing position ARMSE by 77.2% and 10.3% compared to the nominal and rigorously hyperparameter-optimized UKF baselines, respectively. 

Future work will focus on validating the MA-UKF with real-world sensor data to assess Sim-to-Real transferability, and extending the differentiable formulation to Lie Groups to support robust 3D pose and orientation estimation in aerospace applications. 

## REFERENCES 

- [1] S. J. Julier and J. K. Uhlmann, “New extension of the kalman filter to nonlinear systems,” in _Proceedings of Signal Processing, Sensor Fusion, and Target Recognition VI_ , vol. 3068. Spie, 1997, pp. 182–193. 

- [2] E. A. Wan and R. Van Der Merwe, “The unscented kalman filter for nonlinear estimation,” in _Proceedings of of the IEEE 2000 Adaptive Systems for Signal Processing, Communications, and Control Symposium_ . IEEE, 2000, pp. 153–158. 

- [3] R. Turner and C. E. Rasmussen, “Model based learning of sigma points in unscented kalman filtering,” _Neurocomputing_ , vol. 80, pp. 47–53, 2012. 

- [4] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation with applications to tracking and navigation: theory algorithms and software_ . John Wiley & Sons, 2001. 

- [5] A. P. Sage and G. W. Husa, “Adaptive filtering with unknown prior statistics,” in _Proceedings of Joint Automatic Control Conference_ , no. 7, 1969, pp. 760–769. 

- [6] H. A. Blom and Y. Bar-Shalom, “The interacting multiple model algorithm for systems with markovian switching coefficients,” _IEEE Transactions on Automatic Control_ , vol. 33, no. 8, pp. 780–783, 1988. 

- [7] N. Shlezinger, G. Revach, A. Ghosh, S. Chatterjee, S. Tang, T. Imbiriba, J. Dunik, O. Straka, P. Closas, and Y. C. Eldar, “Artificial intelligenceaided kalman filters: Ai-augmented designs for kalman-type algorithms,” _IEEE Signal Processing Magazine_ , 2025. 

- [8] X. Wang and Y. Huang, “Convergence study in extended kalman filterbased training of recurrent neural networks,” _IEEE Transactions on Neural Networks_ , vol. 22, no. 4, pp. 588–600, 2011. 

- [9] N. Forti, L. M. Millefiori, P. Braca, and P. Willett, “Model-based deep learning for maneuvering target tracking,” in _2023 26th International Conference on Information Fusion (FUSION)_ . IEEE, 2023, pp. 1–6. 

- [10] G. Wang, P. Cheng, S. Li, Y. Chen, B. Vucetic, and Y. Li, “Selfsupervised deep state space model for enhanced indoor tracking,” in _ICC 2025-IEEE International Conference on Communications_ . IEEE, 2025, pp. 692–697. 

- [11] C. Jia, J. Ma, and W. M. Kouw, “Multiple variational kalman-gru for ship trajectory prediction with uncertainty,” _IEEE Transactions on Aerospace and Electronic Systems_ , vol. 61, no. 2, pp. 3654–3667, 2024. 

- [12] D. Li, J. Zhou, and Y. Liu, “Recurrent-neural-network-based unscented kalman filter for estimating and compensating the random drift of mems gyroscopes in real time,” _Mechanical Systems and Signal Processing_ , vol. 147, p. 107057, 2021. 

- [13] T. Haarnoja, A. Ajay, S. Levine, and P. Abbeel, “Backprop KF: Learning discriminative deterministic state estimators,” _Advances in Neural Information Processing Systems (NeurIPS)_ , vol. 29, 2016. 

- [14] R. Jonschkowski, D. Rastogi, and O. Brock, “Differentiable particle filters: End-to-end learning with algorithmic priors,” in _Proceedings of Robotics: Science and Systems_ , Pittsburgh, Pennsylvania, June 2018. 

- [15] H. Wen, X. Chen, G. Papagiannis, C. Hu, and Y. Li, “End-to-end semisupervised learning for differentiable particle filters,” in _2021 IEEE International Conference on Robotics and Automation (ICRA)_ . IEEE, 2021, pp. 5825–5831. 

- [16] J. Trejbal, J. Matouˇsek, and J. Dun´ık, “Neural augmented adaptive grid design for point-mass filter,” in _2025 26th International Carpathian Control Conference (ICCC)_ . IEEE, 2025, pp. 1–6. 

- [17] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, “Kalmannet: Neural network aided kalman filtering for partially known dynamics,” _IEEE Transactions on Signal Processing_ , vol. 70, pp. 1532–1547, 2022. 

- [18] J. Y. Loo, Z. Y. Ding, V. M. Baskaran, S. G. Nurzaman, and C. P. Tan, “Sigma-point kalman filter with nonlinear unknown input estimation via optimization and data-driven approach for dynamic systems,” _IEEE Transactions on Systems, Man, and Cybernetics: Systems_ , vol. 54, no. 10, pp. 6068–6081, 2024. 

- [19] Z. Fan, D. Shen, Y. Bao, K. Pham, E. Blasch, and G. Chen, “Rnnukf: Enhancing hyperparameter auto-tuning in unscented kalman filters through recurrent neural networks,” in _2024 27th International Conference on Information Fusion (FUSION)_ . IEEE, 2024, pp. 1–8. 

- [20] H. Liu, Y. Chen, X. Sun, Y. Zhu, X. Wang, and H. Gui, “Finetuning the sample points in gaussian filters via neural networks,” _IEEE Signal Processing Letters_ , vol. 33, pp. 371–375, 2025. 

- [21] Y. Duan, J. Schulman, X. Chen, P. L. Bartlett, I. Sutskever, and P. Abbeel, “RL[2] : Fast reinforcement learning via slow reinforcement learning,” _arXiv preprint arXiv:1611.02779_ , 2016. 

- [22] C. Finn, P. Abbeel, and S. Levine, “Model-agnostic meta-learning for fast adaptation of deep networks,” in _Proceedings of International Conference on Machine Learning (ICML)_ . PMLR, 2017, pp. 1126– 1135. 

- [23] J. X. Wang, Z. Kurth-Nelson, D. Tirumala, H. Soyer, J. Z. Leibo, R. Munos, C. Blundell, D. Kumaran, and M. Botvinick, “Learning to reinforcement learn,” _arXiv preprint arXiv:1611.05763_ , 2016. 

- [24] N. Mishra, M. Rohaninejad, X. Chen, and P. Abbeel, “A simple neural attentive meta-learner,” _arXiv preprint arXiv:1707.03141_ , 2017. 

- [25] K. Cho, B. van Merri¨enboer, C. Gulcehre, D. Bahdanau, F. Bougares, H. Schwenk, and Y. Bengio, “Learning phrase representations using RNN encoder–decoder for statistical machine translation,” in _Proceedings of the 2014 Conference on Empirical Methods in Natural Language Processing (EMNLP)_ , A. Moschitti, B. Pang, and W. Daelemans, Eds. Doha, Qatar: Association for Computational Linguistics, October 2014, pp. 1724–1734. 

- [26] L. Franceschi, M. Donini, P. Frasconi, and M. Pontil, “Forward and reverse gradient-based hyperparameter optimization,” in _Proceedings of International Conference on Machine Learning (ICML)_ . PMLR, 2017, pp. 1165–1173. 

- [27] A. Kloss, M. Bauza, J. Wu, J. B. Tenenbaum, A. Rodriguez, and J. Bohg, “Accurate vision-based manipulation through contact reasoning,” in _2020 IEEE International Conference on Robotics and Automation (ICRA)_ . IEEE, 2020, pp. 6738–6744. 

- [28] I. Murray, “Differentiation of the cholesky decomposition,” _arXiv preprint arXiv:1602.07527_ , 2016. 

- [29] P. Werbos, “Backpropagation through time: what it does and how to do it,” _Proceedings of the IEEE_ , vol. 78, no. 10, pp. 1550–1560, 1990. 

- [30] T. Hospedales, A. Antoniou, P. Micaelli, and A. Storkey, “Meta-learning in neural networks: A survey,” _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , vol. 44, no. 9, pp. 5149–5169, 2021. 

- [31] Z. Chen, C. Heckman, S. Julier, and N. Ahmed, “Weak in the NEES?: Auto-tuning kalman filters with bayesian optimization,” in _2018 21st International Conference on Information Fusion (FUSION)_ , 2018, pp. 1072–1079. 

- [32] J. L. Ba, J. R. Kiros, and G. E. Hinton, “Layer normalization,” 2016. [Online]. Available: https://arxiv.org/abs/1607.06450 

- [33] L. Cork and R. Walker, “Sensor fault detection for uavs using a nonlinear dynamic model and the imm-ukf algorithm,” in _2007 Information, Decision and Control_ . IEEE, 2007, pp. 230–235. 

