IEEE TRANSACTIONS ON POWER ELECTRONICS 

1 

# Discovering Unknown Inverter Governing Equations via Physics-Informed Sparse Machine Learning 

Jialin Zheng, _Member, IEEE,_ Ruhaan Batta, _Student Member, IEEE,_ Zhong Liu, _Student Member, IEEE,_ Xiaonan Lu, _Member, IEEE_ 

_**Abstract**_ **—Discovering the unknown governing equations of grid-connected inverters from external measurements holds significant attraction for analyzing modern inverter-intensive power systems. However, existing methods struggle to balance the identification of unmodeled nonlinearities with the preservation of physical consistency. To address this, this paper proposes a Physics-Informed Sparse Machine Learning (PISML) framework. The architecture integrates a sparse symbolic backbone to capture dominant model skeletons with a neural residual branch that compensates for complex nonlinear control logic. Meanwhile, a Jacobian-regularized physics-informed training mechanism is introduced to enforce multi-scale consistency including large/small-scale behaviors. Furthermore, by performing symbolic regression on the neural residual branch, PISML achieves a tractable mapping from black-box data to explicit control equations. Experimental results on a high-fidelity Hardwarein-the-Loop platform demonstrate the framework’s superior performance. It not only achieves high-resolution identification by reducing error by over 340 times compared to baselines but also realizes the compression of heavy neural networks into compact explicit forms. This restores analytical tractability for rigorous stability analysis and reduces computational complexity by orders of magnitude. It also provides a unified pathway to convert structurally inaccessible devices into explicit mathematical models, enabling stability analysis of power systems with unknown inverter governing equations.** 

_**Index Terms**_ **—Grid-forming inverter, system identification, stability analysis, neural network, physics-informed machine learning, sparse regression.** 

## I. INTRODUCTION 

HE rapid proliferation of inverter-based resources (IBRs) **T** is fundamentally reshaping the landscape of modern power systems [1], [2]. As conventional synchronous machines are increasingly replaced by software-controlled power electronic converters, grid dynamics are now dominated by embedded control algorithms rather than intrinsic physical properties such as mechanical or electromagnetic coupling [3], [4]. A critical challenge arises because both grid-following (GFL) and grid-forming (GFM) inverters typically operate with proprietary and closed-source control logic, essentially black boxes to grid operators [5], [6]. This structural inaccessibility jeopardizes the effectiveness of traditional stability assessment paradigms, which rely on explicit state-space equations to analyze eigenvalue trajectories and damping characteristics [7]. As a result, a crucial modeling gap is rapidly widening: while inverter penetration continues to increase, theoretical tools for understanding and predicting their dynamic behaviors lag significantly behind [8], [9]. 

With the deployment of advanced sensing technologies such as phasor measurement units (PMUs) and high-bandwidth impedance measurement systems, massive amounts of highresolution dynamic data have become available, offering new 

opportunities to uncover inverter dynamics from observations [10], [11]. However, most existing studies still focus on local linear impedance identification [12]. These methods have evolved from traditional frequency sweeping to realtime signal injection (e.g., chirp signals or pseudo-random binary sequences) and can handle complex scenarios such as parallel inverter configurations through sophisticated decoding networks [13], [14]. While these approaches are effective in fitting observed data, they inherently assume a locally linear time-invariant (LTI) physical structure and thus fail to capture the global consistency of the underlying nonlinear dynamics [15]. As a result, there are still challenges for critical analytical tasks beyond impedance analysis, such as eigenvalue-based stability assessment or transient stability analysis [16]. For grid operators seeking a comprehensive understanding of stability boundaries, relying solely on black-box impedance predictors could be insufficient when large-signal dynamics need to be considered. Consequently, there is a strong need for a data-driven approach capable of discovering explicit control equations governing the system dynamics [17]. 

From a broader scientific perspective, automatically discovering the governing equations of nonlinear systems from external measurements remains a major interdisciplinary challenge [18]. Early approaches such as equation-free modeling and empirical dynamic modeling established foundational ideas but often encountered difficulties in scalability and robustness when dealing with high-dimensional and noisy data [19]. With the development of symbolic regression and genetic programming, researchers began to directly search the mathematical expression space to reconstruct differential equations [20]. In the field of power and energy systems, symbolic regression has shown potential for identifying battery degradation processes [21] and extracting reduced-order grid dynamics [22]. However, symbolic regression implicitly relies on the strong assumption that a predefined function library is sufficiently complete to describe the unknown physics. This assumption often fails in high-dimensional multi-time-scale control architectures, where the search space grows exponentially and the sensitivity to noise increases significantly [23]. 

The emergence of Scientific Machine Learning (SciML) introduced a new paradigm by incorporating physical priors into the learning process. Graph Neural Networks (GNNs) have been adopted to capture the topological structure and component interactions within complex power electronic and power system [24]. By explicitly modeling the connectivity, these methods offer scalability to large-scale networks that is difficult to achieve with standard dense layers [25], [26]. Meanwhile, Neural Ordinary Differential Equations (Neural ODEs) and Universal Differential Equations (UDEs) represent 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

2 

system dynamics through differentiable neural architectures [27], [28]. These methods have been used to characterize battery thermal behavior, learn grid frequency responses, and predict dynamic features of power electronic devices [15], [29]–[31].Although these approaches are expressive in representation, purely neural methods often prioritize data fitting, rather than obey physical consistency constraints and guarantee physical validity [32]. This may result in models that are accurate in prediction but physically inconsistent in structure. Physics-Informed Neural Networks (PINNs) address this issue by integrating physical laws such as energy conservation into the loss function, thereby enhancing generalization under data-scarce conditions [33]–[35]. However, such constraint enforcement does not necessarily yield interpretable, explicit physical equations, and the learned representations still prove difficult to understand. 

In summary, the evolution from impedance identification to symbolic regression and SciML represents a continuous effort to bridge the gap between black-box nonlinear systems and interpretable physical modeling. However, each paradigm faces inherent limitations due to assumptions regarding the physical consistency of unknown dynamics [36]. Impedance identification assumes local linearity and ignores global nonlinear behavior. Symbolic regression assumes a closed-form function structure and struggles with complexity. Neural networks (NNs) assume data sufficiency and often sacrifice interpretability [37]. Consequently, existing methods frequently fail to maintain consistency across different dynamic scales, leading to nonphysical behaviors such as inaccurate eigenvalues. Therefore, there is an urgent need for a unified framework that ensures nonlinear expressiveness, multi-scale physical consistency, and interpretability. 

To overcome these limitations, this paper proposes a Physics-Informed Sparse Machine Learning (PISML) framework that defines the equation discovery problem for inverterbased systems. The central idea of PISML is a co-design of interpretability and expressiveness, achieved through a hybrid symbolic–neural structure. The framework decomposes inverter dynamics into a sparse symbolic backbone, capturing analytically tractable physical laws, and a neural residual NN, modeling complex nonlinearities. Beyond this architectural integration, PISML introduces a physics-informed multi-scale consistency training mechanism that enforces agreement between large-signal trajectory behavior and small-signal perturbation responses. This derivative-level constraint grounds the learned model in physically meaningful Jacobian structures, ensuring that both global and local dynamics remain consistent with the underlying physics. Finally, a symbolic regression process extracts explicit closed-form equations from the trained neural model, bridging the gap between blackbox data fitting and analytical modeling. Through this unified formulation, PISML enables interpretable, physically consistent, and analytically tractable discovery of inverter control equations directly from measurement data. 

The main contributions of this paper are summarized as follows: 

- 1) _Hybrid neural–symbolic architecture_ : Integrates a sparse symbolic backbone with neural residual dynamics. This 

**==> picture [248 x 78] intentionally omitted <==**

Fig. 1. Problem formulation for identifying grid-connected inverter dynamics. 

   - design decouples dominant physical laws from unmodeled nonlinearities, balancing explicit interpretability with high-fidelity representation. 

- 2) _Multi-Scale Dynamic Consistency_ : Introduces a physicsinformed training strategy via perturbation-response constraints. This ensures the learned model simultaneously achieves accurate large-signal trajectory reconstruction and physically valid small-signal linearization properties. 

- 3) _Interpretable Explicit Discovery_ : Achieves fidelitypreserving compression of the learned dynamics, transforming over-parameterized neural networks into lightweight symbolic equations. This restores analytical tractability for theoretical stability derivation. 

The remainder of this paper is organized as follows. Section II presents the problem formulation for governing equation discovery in power electronic systems. Section III introduces the proposed PISML framework. Section IV provides case studies for validation. Finally, Section V concludes the paper. 

## II. PROBLEM FORMULATION 

## _A. Dynamics of Grid-connected Inverter_ 

The dynamic behavior of a grid-connected inverter is governed by an intricate interaction between its physical power stage and its embedded digital control system. As shown in Fig. 1, the inverter dynamics can be described as a continuoustime nonlinear system, in which the time evolution of the state vector _x_ ( _t_ ) _∈_ R _[n]_ is defined by a vector field _f_ ( _·_ ): 

**==> picture [226 x 25] intentionally omitted <==**

where _xphy_ represents the physical states (e.g., inductor currents and capacitor voltages), while _xctrl_ denotes the internal control states (e.g., integrator outputs, phase angles of phaselocked loops or virtual oscillators). The term _u_ ( _t_ ) corresponds to the external excitation such as the grid voltage at the point of common coupling (PCC), and _uref_ denotes internal control references. 

The subsystem _fphy_ is derived from Kirchhoff’s circuit laws and typically exhibits an analytical and low-order structure. In contrast, the control subsystem _fctrl_ embodies the algorithmic logic of control strategies, such as grid-following (GFL) or grid-forming (GFM), introducing significant nonlinearities through coordinate transformations, synchronization mechanisms, saturation effects, and power computation loops, among other specific control functions. 

## _B. The Modeling Gap in Traditional Methods_ 

In real-world applications, a significant information asymmetry persists between inverter manufacturers and system operators. While the physical stage dynamics _fphy_ are governed by established circuit laws, the control structure _fctrl_ remains 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

3 

**==> picture [505 x 123] intentionally omitted <==**

Fig. 2. Overview of the Physics-Informed Symbolic Machine Learning (PISML) framework. The approach combines a sparse symbolic backbone with a residual neural ODE to capture unknown dynamics. The model is trained using a composite physics-informed loss function ( _Ltotal_ ), followed by a symbolic regression step to extract an explicit, interpretable ODE representation from the neural residue. 

strictly proprietary, effectively constituting a black box. Conventional data-driven approaches, particularly impedance identification techniques, typically linearize the system trajectory around a specific operating point _x_ 0, yielding the approximate form: 

**==> picture [186 x 11] intentionally omitted <==**

where _A_ ( _x_ 0) = _[∂] ∂x[f]_ ��� _x_ 0[denotes the Jacobian matrix at the equi-] librium. While such impedance-based linearization methods are adequate for local small-signal analysis, they inherently cannot capture the global nonlinear behavior of the vector field _f_ ( _x_ ). Consequently, these methods prove insufficient for evaluating large-signal dynamics, such as transient stability assessment, fault ride-through capabilities, and scenarios where source-side intermittence drives the system far from its nominal operating point. The challenge, therefore, extends beyond simple parameter estimation; it demands discovering the explicit functional structure of the governing nonlinear dynamics directly from measurement data. 

## _C. Mathematical Formulation of the Equation Discovery_ 

The central objective of this study is to discover the explicit governing equations of an inverter control system from measurement data, as shown in Fig. 1. Given a data set 

**==> picture [182 x 13] intentionally omitted <==**

comprising discrete measurements of system trajectories, the goal is to identify a model _f_[ˆ] ( _x, u_ ) that satisfies two key requirements. 

First, it must minimize the trajectory reconstruction error in euclidean norm between the model-predicted and measured states: 

**==> picture [222 x 30] intentionally omitted <==**

Second, _f_[ˆ] must be expressed in symbolic closed form to reflect the underlying physical laws. This renders the problem ill-posed, as multiple candidate functions may exhibit identical data-fitting accuracy while representing distinct local Jacobian structures. Therefore, the discovered model must preserve multi-scale dynamic consistency, reproducing both the global nonlinear response and the local linearization characteristics of the true inverter system. 

## III. METHODOLOGY: THE PHYSICS-INFORMED SPARSE MACHINE LEARNING (PISML) FRAMEWORK 

To overcome the trade-off between the interpretability of symbolic regression and the representational power of NNs, this work introduces the PISML framework. As shown in Fig. 2, PISML integrates a hybrid neural-symbolic architecture with a physics-informed multi-scale learning mechanism to enable interpretable model discovery. 

## _A. Physics-Informed Sparse Symbolic Regression_ 

The foundation of the proposed approach lies in the parsimony hypothesis of power electronic systems [20]. Although the state trajectories of grid-connected inverters exhibit complex nonlinear dynamics, their governing equations are not arbitrary mathematical combinations. Instead, they are strictly constrained by electromagnetic principles (e.g., Kirchhoff’s laws) and engineered control architectures (e.g., PI regulators). This implies that within the high-dimensional space of potential functions, the true vector field _f_ ( _x_ ) is composed of a sparse linear combination of a limited set of specific physical interaction terms. To explicitly extract this physical structure from data, this paper proposes a matrix-based sparse regression framework, as shown in Fig. 3. First, the state snapshots sampled at time instants _t_ 1 _, t_ 2 _, . . . , tK_ and their time derivatives **X** ˙ _∈_ R _[K][×][n]_ :are arranged into data matrices **X** _∈_ R _[K][×][n]_ and 

**==> picture [201 x 44] intentionally omitted <==**

Traditional symbolic regression approaches often employ generic polynomial libraries to approximate nonlinearities, which inevitably leads to over-parameterization and loss of interpretability [20]. To address this, the proposed approach discards generic basis functions and proposes a DomainSpecific Physics-Informed Library construction strategy. A candidate function library **Θ** ( **X** ) is constructed as the direct sum of physical constitutive terms Θ _phy_ and control functional terms Θ _ctrl_ : 

**==> picture [193 x 13] intentionally omitted <==**

where the physical sub-library Θ _phy_ comprises the linear state basis describing the fundamental characteristics of the circuits (e.g., RLC filter networks), covering basic state variables such 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

4 

**==> picture [474 x 266] intentionally omitted <==**

Fig. 3. Schematic illustration of the Sparse Identification of Nonlinear Dynamics. The method constructs a library of candidate nonlinear functions **Θ** ( **X** ) and employs sparse regression to select the active coefficients **Ξ** that best describe the time-series data derivatives **X**[˙] , enabling the reconstruction of the underlying governing equations. 

as currents _idq_ and voltages _vdq_ . Within the control sub-library Θ _ctrl_ , two critical nonlinear elements are introduced: the bilinear active and reactive power calculation terms Θ _power_ , defined as _p_ = _vdid_ + _vqiq_ and _q_ = _vqid − vdiq_ , which are essential for capturing GFM or GFL control logic; and the integral state variables _ξ_ = � ( _xref − x_ ) _dt_ , representing the dynamics of integral controllers. Consequently, the augmented feature library is explicitly formulated as: 

**==> picture [255 x 40] intentionally omitted <==**

Based on this physics-informed library, the sparse symbolic backbone, _fsparse_ ( _x_ ), postulates that the time derivative matrix **X**[˙] can be approximated by a sparse linear combination of these library columns: 

**==> picture [187 x 13] intentionally omitted <==**

where Ξ = [ _ξ_ 1 _, ξ_ 2 _, . . . , ξn_ ] _∈_ R _[p][×][n]_ is the coefficient matrix. Each column _ξk_ determines the active terms in the dynamic equation for the _k_ -th state variable. The identification problem is thus cast as a sparse optimization problem: 

**==> picture [219 x 21] intentionally omitted <==**

The _ℓ_ 1 regularization term functions as a physical topology selector. By penalizing the cardinality of non-zero terms, this objective function compels the model to discard redundant terms unnecessary for describing the system dynamics. Consequently, the resulting non-zero coefficients do not merely achieve accurate data reproduction but explicitly reveal the true physical interconnections and control law structures within the system. 

## _B. Neural ODE for Residual Dynamics_ 

While the physics-informed sparse backbone effectively captures the dominant structural dynamics, constructing a truly exhaustive library that encompasses all potential proprietary control logic is practically infeasible and would impose prohibitive data requirements due to the combinatorial explosion of candidate terms. Consequently, the symbolic model _fsparse_ ( _x, u_ ) (Eq. 8) serves as a low-order approximation. The discrepancy between the true system dynamics and this sparse backbone is defined as the residual component: 

**==> picture [189 x 11] intentionally omitted <==**

This residual term _x_ ˙ _resid_ embodies critical high-frequency nonlinear behaviors and unmodeled control logic. To model this residual dynamics, conventional data-driven approaches typically employ discrete-time sequence models, such as Recurrent Neural Networks (RNNs). Fundamentally, these methods learn a discrete mapping _xk �→ xk_ +1. However, this formulation is intrinsically bound to the training sampling interval ∆ _t_ , lacking the continuous-time definition required for variable step-size integration. Consequently, such models induce discretization errors and fail to interface with standard adaptive ODE solvers [15]. 

To address this, the proposed framework bypasses the discrete mapping and directly parameterizes the continuous-time differential equation of the residual using a neural network. As illustrated in Fig. 4, the system states _x_ and external inputs _u_ are fed in parallel into both the sparse symbolic module and the neural network module. Specifically, the residual approximator _N_ ( _x, u_ ; _θNN_ ) is instantiated as a deep Multilayer Perceptron (MLP). Letting _z_ = [ _x[T] , u[T]_ ] _[T]_ denote the concatenated in- 

5 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

**==> picture [489 x 131] intentionally omitted <==**

Fig. 4. Architecture of the proposed Neural Residual ODE. This module compensates for the dynamics gap in the sparse backbone by superimposing a learnable neural vector field. The merged derivatives are integrated via a shared ODE solver, enabling direct end-to-end training using trajectory data. put vector, the layer-wise forward propagation is rigorously defined as: 

**==> picture [238 x 42] intentionally omitted <==**

where _h_[(] _[l]_[)] represents the hidden state vector of the _l_ -th layer, and _σ_ ( _·_ ) denotes the element-wise nonlinear activation function. The set _θNN_ = _{W_[(] _[l]_[)] _, b_[(] _[l]_[)] _}[L] l_ =1[constitutes][the] learnable weights and biases parameters, with the final output layer mapping directly to the unmodeled residual _x_ ˙ _resid_ . 

The total system dynamics are thus formulated as the superposition of the symbolic vector field and the neural residual vector field: 

**==> picture [204 x 11] intentionally omitted <==**

This hybrid vector field constitutes a complete ODE system that can be seamlessly embedded into any standard ODE solver. Consequently, the estimated state _x_ ˆ( _tk_ ) at any time instant _tk_ is obtained by numerically integrating the combined dynamics from the initial condition _x_ ( _t_ 0): 

**==> picture [250 x 35] intentionally omitted <==**

This formulation implies that the model is no longer bound by a fixed discrete step size; instead, it adaptively adjusts the integration step _dτ_ during both training and inference to match the stiffness of the system dynamics, thereby accurately capturing fast transient processes. 

During training, the objective was to minimize the discrepancy between the solver-predicted trajectories and the groundtruth measurements. To this end, the trajectory reconstruction loss function _Ltraj_ is defined as: 

**==> picture [204 x 30] intentionally omitted <==**

where _K_ denotes the total number of sampling points in the trajectory, _xmeas_ ( _tk_ ) represents the measured system state at time _tk_ , and _∥· ∥_ 2 denotes the euclidean norm. To enable scalable training, the adjoint sensitivity method [27] is leveraged. This approach computes gradients by solving an augmented ODE backward in time, thereby decoupling 

Fig. 5. Multi-time-scale physics-informed training mechanism. 

memory consumption from integration depth and facilitating efficient end-to-end optimization. 

_C. Multi-Time-Scale Physics-Informed Training Mechanism_ 

The simultaneous optimization of sparse coefficients Ξ and neural weights _θNN_ presents a severe identifiability challenge. Due to the universal approximation capability of neural networks, unconstrained joint training often leads to the neural component over-parameterizing dominant dynamics that should physically be attributed to the symbolic backbone, causing symbolic degradation. To suppress this competitive interaction and enforce physical plausibility, a physics-informed joint training strategy is adopted, as shown in Fig. 5. Within a unified computational graph, Ξ and _θNN_ are optimized simultaneously, where the separation of duties is driven by the interplay between structural sparsity constraints and physical property alignment. 

To ensure the symbolic backbone prioritizes the capture of dominant physical laws, the joint objective function applies strict _ℓ_ 1 regularization on Ξ while incorporating physical guidance derived from the system’s small-signal characteristics. This dual mechanism functions as a precision filter: the sparsity constraint condenses global dynamics into compact analytical expressions, while the small-signal Jacobian consistency term forces the linearized features of the hybrid model to align with the true physical system. Under this physical guidance, the neural network is implicitly formulated as a 

6 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

**==> picture [489 x 134] intentionally omitted <==**

Fig. 6. Schematic of the two-stage identification framework. The Black Box Stage utilizes a neural predictor as a universal smoother to generate high-fidelity synthetic data from noisy samples. This facilitates the White Box Stage, where sparse symbolic regression is applied to the denoised data to recover an interpretable model consisting of a physical backbone and distilled control logic. 

residual compensator. It is constrained within the framework of the symbolic backbone, induced to learn only the highfrequency nonlinearities and local disturbances that exceed the representational capacity of the rigid symbolic structure. 

The total optimization objective integrates macroscopic trajectory error, microscopic Jacobian constraints, and a sparsity penalty to jointly regulate both parameter sets: 

**==> picture [253 x 22] intentionally omitted <==**

Crucially, the term _Lpert_ introduces physical guidance by rectifying the model’s eigenvalues through microscopic Jacobian consistency. The total analytical Jacobian of the hybrid model, computed via Automatic Differentiation, explicitly couples the symbolic coefficients Ξ with the neural weights _θNN_ : 

**==> picture [235 x 23] intentionally omitted <==**

This analytical Jacobian is aligned with the empirical smallsignal response observed in perturbation data: 

**==> picture [240 x 24] intentionally omitted <==**

Through this coupled optimization, PISML ensures that the learned derivative field remains consistent with the true system’s stability characteristics. This forces Ξ to account for the dominant dynamics that satisfy physical linearization, while _θNN_ focuses on rectifying unmodeled residual dynamics without compromising the physical interpretability of the symbolic backbone. 

## _D. Symbolic Explicit Equation Discovery_ 

While the hybrid PISML model successfully captures complex system dynamics, the neural residual component _N_ ( _x_ ; _θNN[∗]_[)][ remains an implicit function encoded within thou-] sands of weights and bias. To overcome this barrier, sparse symbolic regression is again applied to the trained NN. This process functions as a symbolic regression mechanism, projecting the high-dimensional neural NN onto a concise set of closed-form mathematical expressions. As illustrated in Fig. 6, this transformation effectively converts the hybrid symbolic/neural model into a computationally efficient and analytically tractable symbolic model, preserving the high fidelity of the neural proxy while recovering the explicit physical structure required for theoretical analysis. 

The core rationale is to utilize the trained NN as a highfidelity predictor. Unlike performing symbolic regression directly on raw, noisy measurements, which severely restricts library complexity due to overfitting risks, the NN acts as a universal smoother. It generates a dense, noise-free synthetic dataset (Eq. 3) by interrogating the learned NN: 

**==> picture [164 x 11] intentionally omitted <==**

This elevation in data quality permits the deployment of an extended function library Θ _ext_ ( _x_ ). In contrast to the compact library used for the backbone, Θ _ext_ ( _x_ ) is enriched with a comprehensive spectrum of nonlinear candidates, including high-order polynomials, trigonometric functions (sin _,_ cos), and rational terms, which are indispensable for characterizing proprietary control logic such as Phase-Locked Loops (PLLs). 

Leveraging this pristine synthetic data, a secondary sparse regression problem is formulated to identify the explicit structure Ξ _[∗] resid_[of][the][residual][using][Eq.][9.][Finally,][the][distilled] symbolic residual is merged with the original sparse backbone to yield the discovered governing equation: 

**==> picture [204 x 13] intentionally omitted <==**

This formulation represents a complete, closed-form reconstruction of the underlying system. Crucially, since the neural predictor was trained under Jacobian consistency constraints ( _Lpert_ ), the derived explicit equation _f_[ˆ] _final_ ( _x_ ) inherits the correct local stability characteristics, thereby bridging the gap between data-driven modeling and rigorous theoretical analysis. 

## IV. CASE STUDIES: GRID-CONNECTED INVERTER WITH UNKNOWN GOVERNING EQUATIONS 

## _A. Case Study Setup_ 

To comprehensively evaluate the identification capability of the proposed framework under realistic conditions, a highfidelity Hardware-in-the-Loop (HIL) testing environment is established. The target system comprises a GFM inverter connected to a stiff grid via an LCL filter, a topology widely adopted in modern power electronic-dominated grids. The standard GFM dynamic model, as documented in [38] is adopted; this model features a droop control mechanism with cascaded voltage and current loops. The detailed circuit and control parameters utilized in this study are illustrated in Fig. 7 (a) and listed in Table I, serving as the ground truth for 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

7 

TABLE I 

PARAMETERS OF THE GRID-FORMING INVERTER TEST SYSTEM 

|**Parameter**|**Symbol**|**Value**|**Unit**|
|---|---|---|---|
|_System Ratings_||||
|Base Power|_Sbase_|500|kVA|
|Base Voltage (Line-Line)|_Vbase_|480|V|
|Nominal Frequency|_fnom_|60|Hz|
|_LCL Filter & Grid Impedance_||||
|Inverter-side Inductance|_Lf_ (_Li_)|0.10|p.u.|
|Inverter-side Resistance|_Rf_ (_Ri_)|0.02|p.u.|
|Filter Capacitance|_Cf_|0.05|p.u.|
|Damping Resistance|_Rd_|0.05|p.u.|
|Grid-side Inductance|_Lg_ (_Lp_)|0.05|p.u.|
|Grid-side Resistance|_Rg_ (_Rp_)|0.01|p.u.|
|_Control Parameters_||||
|Active Power Droop Gain|_mp_|0.05|p.u.|
|Reactive Power Droop Gain|_mq_|0.05|p.u.|
|Power Filter Cut-off Freq.|_ωc_|10_π_|rad/s|
|Voltage Loop PI Gains<br>Current Loop PI Gains|_KpV , KiV_<br>_KpC, KiC_|0.8, 3.0<br>0.2, 4.0|-<br>-|



validation, although the specific control structure is treated as a black box during the identification process. 

The data acquisition and training pipeline relies on a hybrid digital-analog platform, as depicted in Fig. 7 (b). The power stage dynamics are emulated on a Typhoon HIL404/604 series real-time simulator, while physical control signals are captured via high-bandwidth oscilloscopes to incorporate realistic measurement noise before being processed on a workstation equipped with an NVIDIA A100 GPU for accelerated PISML training. Data is sampled at 10 kHz. To generate a training data set rich in transient dynamics and prevent the model from overfitting to trivial equilibrium points, random perturbations at the PCC are introduced. These excitations include voltage sags ranging from 0.8 to 1.0 p.u. and phase angle jumps between 5 and 10 degrees, ensuring the learned model remains valid across a wide operating range. 

The performance of the proposed PISML is benchmarked against three distinct identification paradigms, with implementation details summarized in Table II. The comparative group includes Standard SINDy using a generic polynomial library, representing conventional sparse identification without domain adaptation; Pure Neural ODE, representing a fully 

**==> picture [248 x 219] intentionally omitted <==**

Fig. 7. Experimental implementation of the proposed framework. (a) Schematic of the single-GFM inverter training pipeline for ODE extraction. (b) The physical hardware experimental platform employed for single-GFM inverter and multi-GFM inverters validation. black-box approach lacking physical constraints; and ModSINDy. Notably, Mod-SINDy utilizes the physics-informed domain library constructed in this work but relies exclusively on sparse symbolic regression. It effectively serves as the symbolic backbone of the proposed framework, isolating the contribution of the neural residual correction in the ablation analysis. 

## _B. Trajectory Reconstruction & Generalization_ 

The trajectory reconstruction capability of the proposed PISML framework is evaluated under data-scarce conditions. To emulate practical limitations in acquiring grid-connected data, the training dataset is strictly limited to 12 trajectories sampled within a conservative operating range of voltage magnitude _u ∈_ [0 _._ 8 _,_ 1 _._ 2] p.u. The trained models are then assessed on a severe dynamic test scenario where the system undergoes a large-signal step disturbance dropping to 0 _._ 4 p.u. This drastic voltage sag pushes the system state far into the Out-of-Distribution (OOD) region, representing a significantly more rigorous test of generalization than static operating point variations. 

TABLE II 

COMPARISON OF IDENTIFICATION METHODS AND HYPERPARAMETER SETTINGS 

|**Method**|**Architecture / Library**|**Optimizer & Regularization**|**Key Settings**|
|---|---|---|---|
|**Baseline A:**|Library: Polynomial (Degree 2)|Solver: STLSQ|Threshold: 0.005|
|Standard SINDy|Features: 120 (approx.)|Reg: Sparse Thresholding|Preproc: MinMaxScaler|
|**Baseline B:**|Library: Physics-Informed|Solver: Ridge Regression|_α_: 1_×_10_−_6|
|Mod-SINDy|Features: Linear + Bilinear Power|Reg: L2 Norm|Preproc: MinMaxScaler|
|**Baseline C:**|Net: MLP (3 Layers)|Optimizer: AdamW|LR: OneCycle (Max 0.005)|
|Pure NODE|Dim: 14_→_128_→_128_→_13|Loss: MSE|Epochs: 50|
||Activation: Tanh|Norm: LayerNorm|Preproc: StandardScaler|
|**Proposed:**|**1) Sparse Backbone:**|Solver: Ridge (_α_= 0_._1)|Library: Physics-Based|
|**PISML**|**2) Neural Residual:**|Optimizer: AdamW|LR: OneCycle (Max 0.005)|
||Net: MLP (3 Layers)|Weight Decay: 1_×_10_−_3|Dropout: 0.05|
||Dim: 14_→_128_→_128_→_13|Norm: LayerNorm|Epochs: 50|



IEEE TRANSACTIONS ON POWER ELECTRONICS 

8 

Fig. 8. Comparison of trajectory reconstruction for a GFM inverter. **(a)** _vd_ . **(b)** _vq_ . **(c)** _id_ . **(d)** _iq_ . The green region ( _t <_ 0 _._ 02 s) indicates in-distribution training data, while the red region ( _t ≥_ 0 _._ 02 s) evaluates out-of-distribution (OOD) generalization under a large-signal step disturbance. 

Fig. 9. Trajectory reconstruction for a GFM inverter with nonlinear dual-loop limiting. **(a)** _vd_ . **(b)** _vq_ . **(c)** _id_ . **(d)** _iq_ . The green region evaluates in-distribution performance, while the red region tests OOD generalization under control saturation. 

TABLE III 

ERROR COMPARISON UNDER STANDARD AND SATURATION SCENARIOS 

|**Method**|**Standard**<br>**IOD (%)**<br>**OOD (%)**|**Unknown Sat.**|
|---|---|---|
|||**IOD (%)**<br>**OOD (%)**|
|Std SINDy<br>Mod-SINDy<br>Pure NODE<br>**PISML**|29.65<br>150.36<br>7.10<br>90.83<br>6.48<br>104.82<br>**0.59**<br>**1.94**|207.63<br>934.63<br>68.47<br>483.03<br>6.26<br>120.29<br>**0.92**<br>**2.95**|



_Note:_ IOD: In-Distribution (0–0.02s); OOD: Out-of-Distribution (0.02–0.04s). “Unknown Sat.” refers to unmodeled control saturation. The metric is the Relativeover [ _id, iq, vd, vq_ ], calculated as _ϵ_ = ( _∥_ **y** ˆ _−_ **y** _∥_ 2 _/∥_ **y** _∥_ 2) _×_ 100% _L_ 2, Norm averagedwhere **y** ˆ is the estimate and **y** is the ground truth. 

The time-domain reconstruction results for the standard GFM model are presented in Fig. 8. Standard SINDy exhibits significant steady-state deviation and transient errors due to the inherent stiffness and multi-time-scale nature of GFM dynamics; the generic polynomial library lacks the capacity to sparsely represent the complex trigonometric couplings and bilinear power terms essential to the control topology. In the OOD region ( _t ≥_ 0 _._ 02 s), the limitations of pure data-driven methods become pronounced. Although the Pure Neural ODE maintains a reasonable approximation within the training distribution, its tracking error increases visibly in the OOD region, confirming its inability to extrapolate dynamics correctly without physical inductive bias. Mod-SINDy, while incorporating physical terms, suffers from library truncation error during deep voltage sags. In contrast, PISML achieves high-fidelity tracking in both regions by leveraging the sparse physical backbone for robust extrapolation and the neural residual for precision. 

To further probe the limits of identifiability, the methods are evaluated on a GFM system containing unknown non-linear saturation blocks in the control loops, with the corresponding 

trajectory comparisons illustrated in Fig. 9. As summarized in Table III, both symbolic baselines suffer catastrophic performance degradation, yielding OOD errors exceeding 400%. This failure stems from the fundamental inability of basis functions library to represent hard nonlinearities, resulting in erroneous global polynomial fitting. In contrast, the Pure Neural ODE exhibits inherent adaptability to such non-smooth functions due to its universal approximation capability, avoiding the divergence observed in symbolic methods. However, PISML achieves the superior performance with an OOD error of only 2 _._ 95%. This confirms that the neural residual component effectively compensates for the hard non-linearities and discontinuous behaviors that the symbolic backbone cannot resolve, while the backbone ensures stability in the linear regions. 

## _C. Data Efficiency and Noise Robustness_ 

Subsequently, the data efficiency of the competing paradigms is quantified. Fig. 10 depicts the evolution of reconstruction errors with respect to the training dataset size. Remarkably, Standard SINDy exhibits a counter-intuitive trend where identification performance degrades as data volume increases. This pathology arises because, lacking a complete basis representation for the complex GFM dynamics, the regression algorithm minimizes residuals by overfitting measurement noise through high-order polynomials rather than capturing the underlying physics. While Mod-SINDy maintains stability due to domain-specific priors, it reaches an early performance saturation. Pure NODE adheres to a typical data scaling law, requiring approximately 64 trajectories to match the accuracy that PISML achieves with merely 12. PISML demonstrates superior data efficiency, converging to the noise floor with minimal samples. This efficiency is intrinsic to its decoupled architecture, where the physical backbone rapidly locks onto dominant dynamics, allowing the neural 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

9 

**==> picture [259 x 114] intentionally omitted <==**

Fig. 10. Comparison of data efficiency across different modeling frameworks. **(a)** IOD relative error versus number of trajectories. **(b)** OOD relative error versus number of trajectories. 

**==> picture [259 x 106] intentionally omitted <==**

Fig. 11. Robustness analysis under varying noise conditions. **(a)** IOD relative error versus noise condition (SNR in dB). **(b)** OOD relative error versus noise condition. 

TABLE IV 

QUANTITATIVE EVALUATION OF DISTRIBUTIONAL SHIFT VIA WASSERSTEIN DISTANCE 

|**Method**|**Wasserstein Dist.**|**Relative Ratio**|
|---|---|---|
||(Lower is Better)|(vs. PISML-Phy)|
|Baseline A (Std SINDy)|120.5296|544_._1_×_|
|Baseline B (Mod-SINDy)|83.8019|378_._3_×_|
|Baseline C (Pure NODE)|168.4744|760_._6_×_|
|PISML (w/o Constraints)|75.6735|341_._6_×_|
|**PISML-Phy (Proposed)**|**0.2215**|**1.0** _×_|



_Note:_ The Wasserstein Distance (WD) quantifies the discrepancy between the predicted trajectory distribution and the ground truth. The relative ratio indicates how many times larger the distributional error is compared to the proposed PISML-Phy method. A ratio of 1 _._ 0 _×_ represents the benchmark performance. 

component to dedicate its capacity solely to resolving residual mismatches. 

The robustness against measurement noise is evaluated by training models on raw data corrupted with varying Signalto-Noise Ratios (SNR) without pre-filtering, as shown in Fig. 11. Symbolic methods reveal a critical vulnerability to noise-induced instability. Standard SINDy diverges rapidly even under moderate noise levels due to derivative noise amplification, where numerical differentiation creates spurious high-magnitude targets for the regression. Although Pure NODE avoids divergence, it tends to overfit high-frequency noise components, resulting in non-physical oscillations. In contrast, PISML demonstrates exceptional noise tolerance. The enforcement of Jacobian regularization combined with the _ℓ_ 1 sparsity penalty on physical coefficients acts as a physicsinformed filter, effectively suppressing the identification of spurious noise terms while preserving the fidelity of the true system dynamics. 

## _D. Small-Signal Physical Consistency_ 

Beyond accurate trajectory reconstruction, preserving smallsignal stability is a critical requirement for power electronic modeling. Pure time-domain regression often fails to guarantee the validity of the underlying Jacobian matrix. Therefore, this subsection rigorously evaluates the small-signal behavior of the identified models. For a fair comparison, the baselines utilize their optimal data configurations, with Standard SINDy and Mod-SINDy using 9 trajectories and Pure NODE using 64 trajectories to maximize data-driven potential. The proposed PISML employs only 12 trajectories to highlight data efficiency. The standard PISML and the Physics-informed PISML, denoted as PISML-Phy, are compared to isolate the contribution of the Jacobian regularization mechanism, as detailed in Section III-C. 

First, a Jacobian linearization of the trained models is performed at an operating point of _u_ = 0 _._ 8 p.u., with the resulting eigenvalue distributions illustrated in Fig. 12. Although Pure NODE, Mod-SINDy, and the unconstrained PISML achieve acceptable time-domain fitting, their eigenvalues exhibit irregular scattering with multiple poles erroneously located in the right-half plane. This spectral pollution implies mathematical instability despite apparent short-term accuracy. A valid control equation must correctly encode the local vector field structure. In contrast, PISML-Phy successfully eliminates these spurious modes. Its eigenvalues cluster tightly around the analytical ground truth and remain strictly within the lefthalf plane. This confirms that the regularization term _Lpert_ effectively constrains the derivative space and forces the neural residual to respect physical stability boundaries. 

To quantify the discrepancy between the true and identified spectra, the Wasserstein Distance is employed as listed in Table IV. The unconstrained PISML exhibits a Wasserstein metric comparable to the baselines despite superior trajectory reconstruction, indicating limited improvement in small-signal fidelity. However, the introduction of the physical guidance mechanism in PISML-Phy yields a transformative improvement, reducing the distance by a factor of over 340. This empirical result proves that physical constraints are indispensable for identifying correct derivatives from sparse data. Finally, the robustness of these characteristics is evaluated across varying operating points in Fig. 13. While the spectral error for all methods naturally increases as the system shifts from the IOD to the OOD region, PISML-Phy consistently maintains the lowest distance by orders of magnitude. This demonstrates that the proposed physical constraints ensure the identified NN remains topologically consistent with the true physics across the entire operating envelope. 

## _E. Interpretable Explicit Equation Discovery_ 

The ultimate objective of the PISML framework is to transcend the intermediate grey-box representation and achieve fidelity-preserving compression. While the PISML model attains high accuracy via the neural residual, it relies on thousands of opaque parameters. To restore analytical transparency, the symbolic distillation is performed on the neural residual component and merge it with the symbolic backbone to extract a compact, explicit mathematical structure. The evolution 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

10 

**==> picture [516 x 275] intentionally omitted <==**

Fig. 12. Comparative analysis of small-signal stability and eigenvalue distributions across **(a)** Std SINDy, **(b)** Mod SINDy, **(c)** Pure NODE, **(d)** PISML, and **(e)** PISML-Phy. Rows **(a1)–(e1)** show the large-signal trajectory of _vd_ . Rows **(a2)–(e2)** and **(a3)–(e3)** illustrate global and magnified eigenvalue distributions, respectively, where grey ’x’ markers denote the analytical ground truth. 

**==> picture [232 x 109] intentionally omitted <==**

Fig. 13. Robustness analysis of eigenvalue prediction under varying operating points _u ∈_ [0 _._ 2 _,_ 1 _._ 2]. The grouped bar chart illustrates the Wasserstein distance (WD) relative to the ground truth for five different modeling frameworks. of this discovery process is visualized in Fig. 14 (a)–(d). As evidenced by the coefficient heatmaps, the PISML-Phy (Fig. 14b) successfully captures the dominant linear state dependencies, establishing a rigid physical skeleton. Subsequently, the regression output derived from the neural residual (Fig. 14c) does not produce a dense matrix of spurious terms but selectively identifies the specific nonlinear coupling terms initially unmodeled by the physical backbone. The PISML model (Fig. 14d) seamlessly integrates these components, reconstructing a sparse topology that is structurally isomorphic to the Ground Truth (Fig. 14a). This structural alignment proves that PISML has effectively learned the underlying physical causality rather than merely overfitting the dataset. 

To validate that this transition from a neural proxy to an explicit equation incurs no loss of dynamic fidelity, a rigorous performance sweep was conducted across a grid voltage range of 0.2 p.u. to 1.0 p.u. As illustrated in the timedomain trajectories of Fig. 14 (e)–(h), the distilled explicit model (dashed lines) exhibits near-perfect overlap with the Ground Truth (solid lines) even under severe voltage dip and 

recovery scenarios. The quantitative error analysis is detailed in Table V. The results reveal that the regression process incurs negligible information loss, as the average relative errors for active power ( _Pf_ ) and voltage ( _vcd_ ) are merely 0.58% and 0.88%, respectively.Beyond trajectory matching, true interpretability requires the preservation of local stability characteristics. The eigenvalue distributions in Fig. 14 (i)–(l) demonstrate that the modes of the distilled model (marked with ‘x’) align precisely with the Ground Truth (marked with ‘o’). This strict alignment across both low-frequency dominant modes and high-frequency oscillatory modes confirms that the discovered equation accurately reproduces the system’s microscopic differential geometry, allowing the derived explicit form to serve as a reliable instrument for theoretical stability assessment. 

To rigorously quantify the trade-off between model parsimony and predictive capability, a statistical evaluation was performed across different modeling frameworks. As systematically evaluated in Table VI, converting the neural representation into symbolic terms delivers transformative benefits. Regarding model complexity, PISML achieves a compression ratio exceeding 250 times by reducing the parameter count from thousands to fewer than fifty coefficients. This extreme sparsity makes the model lightweight enough for embedded DSP controllers. In the trade-off space illustrated in Fig. 15, Standard SINDy falls into the high-error region, while Pure Neural ODE resides in the high-complexity region with potential overfitting risks. Distinct from these approaches, PISML identifies the minimal set of active physical terms, achieving a favorable balance of low complexity and low error. This ensures superior robustness in out-of-distribution scenarios where high-complexity models tend to diverge. 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

11 

**==> picture [505 x 249] intentionally omitted <==**

Fig. 14. Evaluation of discovered interpretable d equations. **(a)–(d)** Sparse coefficient matrices for Ground True, PISML-Phy, PISML-Distilled, and Final PISML models. The horizontal axis is categorized into two libraries: the Linear Library comprises the constant bias and 13 state variables ( _x_ 0 _, . . . , x_ 12), while the Nonlinear Library consists of 13 candidate functions including bilinear coupling terms (e.g., _xk_ ∆ _P_ ), trigonometric grid voltage terms ( _ug_ cos _δ, ug_ sin _δ_ ), and instantaneous power calculation terms. **(e)–(h)** Comparison of time-domain trajectories for _Pf_ and _vcd_ (Solid: Ground True; Dashed: PISML-Distilled). **(i)–(l)** Global and zoomed eigenvalue distributions, where ’o’ and ’x’ markers denote Ground True and PISML-Distilled modes, respectively. 

**==> picture [232 x 130] intentionally omitted <==**

**==> picture [232 x 99] intentionally omitted <==**

Fig. 16. Schematic diagrams of 3-Buses microgrid topology for validating the interaction between the learned target model and known auxiliary units. 

_F. System-Level Integration & Applications_ 

Fig. 15. Pareto analysis of model robustness versus complexity, comparing PISML variants against black-box NNs and standard sparse regression baselines. 

The definitive advantage of extracting explicit governing equations lies in the capability to integrate the identified model into broader power system simulations. By translating proprietary black-box devices into a unified mathematical language, PISML empowers grid operators to integrate equipment from diverse manufacturers onto a single platform for full-system analysis. This integration capability ensures that the discovered model is not only accurate for time-domain simulation but also reliable for rigorous theoretical stability assessment. 

TABLE V 

RELATIVE ERROR ANALYSIS OF HYBRID AND DISTILLED MODELS UNDER VOLTAGE VARIATIONS 

|**Grid Voltage**<br>_u_ (p.u.)|**Hybrid Model Error** (%)<br>Active Power<br>Voltage _vd_|**Distilled Model Error** (%)<br>Active Power<br>Voltage _vd_|
|---|---|---|
|0.2<br>0.4<br>0.6<br>0.8<br>1.0<br>1.2|0.6371<br>0.4884<br>0.3653<br>0.2174<br>0.1430<br>0.8854<br>0.3493<br>1.0561<br>0.8709<br>0.1849<br>0.1823<br>0.3840|0.1457<br>1.0081<br>0.2086<br>1.5530<br>0.4157<br>1.3209<br>0.4206<br>0.0521<br>0.4034<br>0.7935<br>1.8943<br>0.6020|
|**Average**|**0.4246**<br>**0.5360**|**0.5814**<br>**0.8883**|



To validate this capability experimentally, a heterogeneous 3-bus microgrid system is constructed, as illustrated in Fig. 16. The topology consists of the identified Target GFM (represented by the PISML-distilled explicit equations) integrated with two Auxiliary GFMs (Aux GFM 1 & 2) possessing known structures and parameters. The detailed system parameters are listed in Table VII. This setup, implemented on the HIL platform shown in Fig. 7, serves as a rigorous testbed to evaluate the interaction between the ”learned” dynamics and the ”known” physics. 

TABLE VI 

COMPREHENSIVE EFFICIENCY & FIDELITY COMPARISON 

|**Metric**<br>Model Type<br>Small-Signal Error<br>Parameter Count|**Pure NODE**<br>Black-box<br>High (Unstable)<br>_∼_5,000+|**PISML-Phy**<br>Grey-box<br>Low<br>_∼_5,000+|**PISML-Distilled**<br>**White-box**<br>**Low**<br>_<_ **50 (Coeffs)**|
|---|---|---|---|
|Analyticity|Intractable|Intractable|**Tractable**|



First, the accuracy of the PISML model in a multi-converter environment is validated through large-signal disturbance test- 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

12 

## TABLE VII 

SYSTEM AND CONTROL PARAMETERS CONFIGURATION 

|**Category **|**Parameter**|**Symbol **|**GFM 1 **|**GFM 2 **|**GFM 3**|
|---|---|---|---|---|---|
||Active Droop|_mp_|0.03|0.06|0.05|
||Voltage Prop. Gain|_KpV_|1.60|2.00|1.40|
|Control|Voltage Int. Gain|_KiV_|3.00|4.00|2.00|
||Current Prop. Gain|_KpC_|0.50|0.30|0.40|
||Current Int. Gain|_KiC_|4.00|4.00|4.00|
|Line|Line Resistance|_Rline_|0.01|0.01|0.01|
||Line Inductance|_Lline_|0.001|0.001|0.001|
|Load|Load Resistance|_Rload_||0_._9||
||Load Inductance|_Lload_||0_._4358||



**==> picture [237 x 215] intentionally omitted <==**

Fig. 17. Experimental validation of system-level transient dynamics in the 3- bus microgrid under a sudden load step. **(a1)-(a3)** Ground truth output current waveforms measured from the HIL testbench for the Target GFM 1, Aux GFM 2, and Aux GFM 3, respectively. **(b1)-(b3)** Corresponding current trajectories predicted by the PISML-based hybrid simulation. 

**==> picture [237 x 211] intentionally omitted <==**

Fig. 18. Experimental validation of system-level transient dynamics in the 3- bus microgrid under a sudden load step. **(a1)-(a3)** Ground truth output current waveforms measured from the HIL testbench for the Target GFM 1, Aux GFM 2, and Aux GFM 3, respectively. **(b1)-(b3)** Corresponding current trajectories predicted by the PISML-based hybrid simulation. 

**==> picture [259 x 238] intentionally omitted <==**

Fig. 19. System-level eigenvalue trajectories (root loci) of the heterogeneous 3-bus microgrid system under control parameter variations. **(a)-(b)** Impact of varying the voltage proportional gain ( _KpV_ ) of Aux GFM 2 on global and dominant modes. **(c)-(d)** Impact of varying the current proportional gain ( _KpC_ ) of Aux GFM 3. 

ing. A sudden load step change is applied at _t_ = 0 _._ 02 s. To rigorously assess the model’s robustness against varying external dynamics, the system response is simulated under different control parameter settings for the auxiliary analytical GFM inverters, as illustrated in Fig. 17 and Fig. 18. In both scenarios, the output current waveforms demonstrate that the hybrid model (PISML Target + Analytical Auxiliaries) closely tracks the HIL ground truth. This consistency confirms that the PISML-derived equation, despite being trained solely on single-unit data, successfully captures the device’s intrinsic port behaviors and correctly reproduces the transient loadsharing dynamics when interacting with the wider grid. 

Beyond these time-domain results, the explicit nature of the PISML model enables safe and rapid stability assessment for operations that would be hazardous to perform directly on physical hardware. Specifically, before physically connecting a black-box inverter, operators can mathematically analyze how its integration affects global system stability. To demonstrate this, a global eigenvalue analysis of the assembled 3-bus system is conducted. The migration of system eigenvalues is investigated by tuning the control coefficients of the known units—specifically, the voltage proportional gain ( _KpV_ ) and integral gain ( _KiV_ ) of the auxiliary GFMs. As visualized in Fig. 19, the resulting root locus plot reveals the precise trajectory of the system’s dominant modes. This analysis allows operators to identify stability boundaries and optimize the settings of existing assets to accommodate the black-box target. Such theoretical insight, derived directly from the mathematical integration capability of the PISML model, bridges the methodological gap between data-driven identification and rigorous power system engineering. 

## V. CONCLUSION 

This paper proposes the PISML framework to bridge the critical modeling gap in power electronics-dominated grids. 

IEEE TRANSACTIONS ON POWER ELECTRONICS 

13 

By synergizing a sparse symbolic backbone with a neural residual branch under Jacobian-regularized physics-informed training, PISML successfully reconciles the inherent conflict between identifying unmodeled hard non-linearities and preserving physical consistency. Furthermore, the framework advances the fidelity-preserving regression of implicit neural dynamics into compact governing equations restores analytical tractability for algebraic stability design, while drastically reducing complexity for efficient deployment. The framework was rigorously validated on a high-fidelity HIL platform across multiple dimensions, including large-signal trajectory reconstruction, small-signal spectral analysis, and system-level integration capability. Quantitative results confirm that the proposed method reduces identification error by over 340 times compared to symbolic baselines and improves spectral fidelity by two orders of magnitude. By distilling implicit black-box dynamics into explicit control equations, PISML achieves a breakthrough in integration capability, empowering grid operators to integrate proprietary devices into rigorous eigenvalue analysis workflows. Future work will extend this approach to identify complex grid-forming topologies under unstructured grid faults and explore online adaptive implementations. 

## REFERENCES 

- [1] S. Xu _et al._ , “Review of power system support functions for inverterbased distributed energy resources- standards, control algorithms, and trends,” _IEEE Open Journal of Power Electronics_ , vol. 2, pp. 88–105, 2021. 

- [2] Y. Lin _et al._ , “Pathways to the next-generation power system with inverter-based resources: Challenges and recommendations,” _IEEE Electrification Magazine_ , vol. 10, no. 1, pp. 10–21, 2022. 

- [3] Y. Huang _et al._ , “Physics insight of the inertia of power systems and methods to provide inertial response,” _CSEE Journal of Power and Energy Systems_ , vol. 8, no. 2, pp. 559–568, 2022. 

- [4] Y. Qi _et al._ , “Synthetic inertia control of grid-connected inverter considering the synchronization dynamics,” _IEEE Transactions on Power Electronics_ , vol. 37, no. 2, pp. 1411–1421, 2022. 

- [5] M. Nestor _et al._ , “Data-driven communication and control design for distributed frequency regulation with black-box inverters,” 2025. [Online]. Available: https://arxiv.org/abs/2510.17769 

- [6] R. Rosso _et al._ , “Grid-forming converters: Control approaches, gridsynchronization, and future trends—a review,” _IEEE Open Journal of Industry Applications_ , vol. 2, pp. 93–109, 2021. 

- [7] U. Markovic _et al._ , “Partial grid forming concept for 100% inverterbased transmission systems,” in _2018 IEEE Power & Energy Society General Meeting (PESGM)_ , pp. 1–5, 2018. 

- [8] N. Hatziargyriou _et al._ , “Definition and classification of power system stability – revisited & extended,” _IEEE Transactions on Power Systems_ , vol. 36, no. 4, pp. 3271–3281, 2021. 

- [9] T. C. Green _et al._ , “Zero-inertia power systems: Data-driven stability assessment,” _IEEE Power and Energy Magazine_ , vol. 18, no. 2, pp. 56– 65, 2020. 

- [10] L. He _et al._ , “A neural network-based online parameter identification method for fractional-order power electronics,” _IEEE Transactions on Circuits and Systems I: Regular Papers_ , vol. 72, no. 9, pp. 4868–4876, 2025. 

- [11] I. Kamwa _et al._ , “Pmu configuration for system dynamic performance measurement in large, multiarea power systems,” _IEEE Transactions on Power Systems_ , vol. 17, no. 2, pp. 385–394, 2002. 

- [12] X. Wang _et al._ , “Unified impedance model of grid-connected voltagesource converters,” _IEEE Transactions on Power Electronics_ , vol. 33, no. 2, pp. 1775–1787, 2018. 

- [13] X. Weng _et al._ , “Chirp signal injection method and real-time impedance characteristic measurement of electric energy router,” _IEEE Journal of Emerging and Selected Topics in Power Electronics_ , vol. 10, no. 5, pp. 5564–5577, 2022. 

   - [15] J. Zheng _et al._ , “Latent-feature-informed neural ode modeling for lightweight stability evaluation of black-box grid-tied inverters,” _IEEE Transactions on Power Electronics_ , pp. 1–6, 2025. 

   - [16] Y. Gu _et al._ , “Power system stability with a high penetration of inverterbased resources,” _Proc. IEEE_ , vol. 111, no. 7, pp. 832–853, 2023. 

   - [17] J. Zheng _et al._ , “Neural surrogate solver for efficient edge inference of power electronic hybrid dynamics,” _IEEE Transactions on Industrial Electronics_ , pp. 1–6, 2026. 

   - [18] H. Wang _et al._ , “Scientific discovery in the age of artificial intelligence,” _Nature_ , vol. 620, no. 7972, pp. 47–60, 2023. 

   - [19] K. Course _et al._ , “State estimation of a physical system with unknown governing equations,” _Nature_ , vol. 622, no. 7982, pp. 261–267, 2023. 

   - [20] S. L. Brunton _et al._ , “Discovering governing equations from data by sparse identification of nonlinear dynamical systems,” _Proceedings of the National Academy of Sciences_ , vol. 113, no. 15, pp. 3932–3937, 2016. 

   - [21] N. Hadifar _et al._ , “Data-driven modeling of power electronic converters using symbolic regression for digital twin applications,” in _2025 IEEE Electric Ship Technologies Symposium (ESTS)_ , pp. 135–142, 2025. 

   - [22] A. T. Sari´c _et al._ , “Symbolic regression for data-driven dynamic model refinement in power systems,” _IEEE Transactions on Power Systems_ , vol. 36, no. 3, pp. 2390–2402, 2021. 

   - [23] X. Shi _et al._ , “Physical-informed detailed aggregation of wind farm based on symbolic regression: Structure, solution and generalizability,” _IEEE Transactions on Sustainable Energy_ , pp. 1–14, 2025. 

   - [24] K. Egan _et al._ , “Automatically discovering ordinary differential equations from data with sparse regression,” _Communications Physics_ , vol. 7, no. 1, p. 20, 2024. 

   - [25] Q. Guo _et al._ , “Physics-informed neural network combined with sparse identification nonlinear dynamics for battery soc estimation,” in _2025 IEEE International Conference on Environment and Electrical Engineering and 2025 IEEE Industrial and Commercial Power Systems Europe (EEEIC / I&CPS Europe)_ , pp. 1–6, 2025. 

   - [26] G. W. Koo _et al._ , “Efficient algorithm based on sindy-pinn-pso for transformer air-gap design in obc,” _IEEE Transactions on Power Electronics_ , vol. 41, no. 1, pp. 56–60, 2026. 

   - [27] R. T. Chen _et al._ , “Neural ordinary differential equations,” _Advances in neural information processing systems_ , vol. 31, 2018. 

   - [28] C. Rackauckas _et al._ , “Universal differential equations for scientific machine learning,” _arXiv preprint arXiv:2001.04385_ , 2020. 

   - [29] Z. Liu _et al._ , “Dissipation-based dynamics-aware learning scheme for transient stability analysis of networked black-box grid-forming inverters,” _IEEE Transactions on Power Electronics_ , vol. 41, no. 3, pp. 3165– 3170, 2026. 

   - [30] J. Zheng _et al._ , “Stability evaluation of black-box grid-forming inverters via physical-informed neural ordinary differential equations,” in _2025 IEEE Energy Conversion Conference Congress and Exposition (ECCE)_ , pp. 1–5, 2025. 

   - [31] J. Zheng _et al._ , “Physics-embedded neural odes for sim-to-real edge digital twins of hybrid power electronics systems,” _IEEE Transactions on Industrial Electronics_ , pp. 1–12, 2026. 

   - [32] Y. Lian _et al._ , “Physically consistent multiple-step data-driven predictions using physics-based filters,” _IEEE Control Systems Letters_ , vol. 7, pp. 1885–1890, 2023. 

   - [33] B. Huang _et al._ , “Applications of physics-informed neural networks in power systems - a review,” _IEEE Transactions on Power Systems_ , vol. 38, no. 1, pp. 572–588, 2023. 

   - [34] G. E. Karniadakis _et al._ , “Physics-informed machine learning,” _Nature Reviews Physics_ , vol. 3, no. 6, pp. 422–440, 2021. 

   - [35] Y. Fassi _et al._ , “Toward physics-informed machine-learning-based predictive maintenance for power converters—a review,” _IEEE Transactions on Power Electronics_ , vol. 39, no. 2, pp. 2692–2720, 2024. 

   - [36] S. Kolev _et al._ , “Physically consistent state estimation and system identification for contacts,” in _2015 IEEE-RAS 15th International Conference on Humanoid Robots (Humanoids)_ , pp. 1036–1043, 2015. 

   - [37] F.-L. Fan _et al._ , “On interpretability of artificial neural networks: A survey,” _IEEE Transactions on Radiation and Plasma Medical Sciences_ , vol. 5, no. 6, pp. 741–760, 2021. 

   - [38] N. Pogaku _et al._ , “Modeling, analysis and testing of autonomous operation of an inverter-based microgrid,” _IEEE Transactions on power electronics_ , vol. 22, no. 2, pp. 613–625, 2007. 

- [14] H. Gong _et al._ , “Dq-frame impedance measurement of three-phase converters using time-domain mimo parametric identification,” _IEEE Transactions on Power Electronics_ , vol. 36, no. 2, pp. 2131–2142, 2021. 

