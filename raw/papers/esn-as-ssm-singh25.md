---
source_url: https://arxiv.org/abs/2509.04422
ingested: 2026-04-30
sha256: d4b9eadc3dbcbd9468d0a4d04967cb3e08b3a0b7ae653d9c7133eeaf62b30f50
source: paper
conversion: pymupdf4llm

---

# **Echo State Networks as State-Space Models: A Systems Perspective** 

Pradeep Singh ∗, Balasubramanian Raman † 

Department of Computer Science and Engineering Indian Institute of Technology Roorkee Roorkee-247667, India 

## **Abstract** 

Echo State Networks (ESNs) are typically presented as efficient, readout-trained recurrent models, yet their dynamics and design are often guided by heuristics rather than first principles. We recast ESNs explicitly as state-space models (SSMs), providing a unified systems-theoretic account that links reservoir computing with classical identification and modern kernelized SSMs. First, we show that the echo-state property is an instance of input-to-state stability for a contractive nonlinear SSM and derive verifiable conditions in terms of leak, spectral scaling, and activation Lipschitz constants. Second, we develop two complementary mappings: (i) small-signal linearizations that yield locally valid LTI SSMs with interpretable poles and memory horizons; and (ii) lifted/Koopman random-feature expansions that render the ESN a linear SSM in an augmented state, enabling transfer-function and convolutional-kernel analyses. This perspective yields frequency-domain characterizations of memory spectra and clarifies when ESNs emulate structured SSM kernels. Third, we cast teacher forcing as state estimation and propose Kalman/EKF-assisted readout learning, together with EM for hyperparameters (leak, spectral radius, process/measurement noise) and a hybrid subspace procedure for spectral shaping under contraction constraints. 

## **1 Introduction** 

Reservoir Computing (RC) offers a remarkably frugal route to sequence modeling: by freezing a randomly initialized recurrent operator and training only a linear readout, Echo State Networks (ESNs) achieve competitive modeling capacity with modest computational and statistical burden [19, 29]. Despite two decades of empirical success and a maturing approximation theory for causal fading–memory maps [5, 13, 11], the analytical vocabulary used for ESNs remains partly bespoke—centered on the Echo State Property (ESP), spectral–norm heuristics, and memory–capacity diagnostics—rather than the lingua franca of systems theory. This gap obscures connections to well–developed tools in control, identification, and signal processing, and makes it harder to compare ESNs with the recent wave of state–space sequence models (SSMs) that dominate long–context learning through structured kernels and dissipative dynamics [15, 16, 14]. 

This paper puts forward a unifying perspective: _ESNs are naturally expressible as state–space models_ . Concretely, the leaky ESN recursion can be written as a nonlinear discrete–time SSM with process and measurement noise, 

**==> picture [363 x 12] intentionally omitted <==**

and, under standard small–signal or operating–point assumptions, admits linear or bilinear SSM surrogates with interpretable poles, gains, and impulse responses. The “leak” parameter _λ_ acquires a precise dynamical meaning as a timestep–scaled dissipation factor arising from forward–Euler discretization of a continuous–time ESN ODE/SDE, while readout training corresponds to a classical linear regression (or Bayesian linear estimation) on latent states. Framing ESNs as SSMs imports a powerful arsenal: input–to–state stability (ISS) directly translates and strengthens ESP statements [41, 20, 30]; controllability and observability of lifted or linearized representations offer principled criteria for input scaling and spectral shaping [27, 34]; and frequency–domain analysis via transfer functions ties “memory spectra” to pole geometry and convolutional kernels [22]. 

> ∗Email: pradeep.cs@sric.iitr.ac.in 

> †Email: bala@cs.iitr.ac.in 

1 

Theoretical results on RC already show universality for time–invariant, causal fading–memory filters and precise approximation rates under mixing and Lipschitz assumptions [13, 11]. Yet these results are typically phrased without explicit recourse to SSM structure, and ESP is often certified by sufficient conditions such as _ρ_ ( _W_ ) < 1 after rescaling or global Lipschitz bounds on _σ_ . By recasting ESNs within the SSM framework, one can replace ad hoc spectral–radius rules with ISS–based contraction arguments that (i) incorporate input gains _U_ and leaks _λ_ in a single small–gain inequality, (ii) quantify fading memory through BIBO/ISS Lyapunov functions rather than scalar heuristics, and (iii) extend to multi–rate and deep (stacked) reservoirs via block–SSM composition with guaranteed stability margins [41, 27]. In turn, the SSM lens clarifies when and why ESNs emulate modern SSM layers: linearizations and random–feature lifts induce rational transfer functions whose impulse responses are precisely the exponentially decaying kernels exploited by recent S4–type architectures [15, 16]. 

A second payoff of the SSM view is methodological. Teacher forcing can be interpreted as (noisy) state observation; state denoising during training aligns with classical filtering and smoothing [39]. Hyperparameters customarily tuned by grid search—leak _λ_ , spectral radius/scaling of _W_ , input scaling, effective noise levels—admit principled estimation via likelihood maximization or expectation–maximization in SSMs, while subspace identification offers recipes for shaping reservoir spectra subject to ESP/ISS constraints [27, 34]. Moreover, Koopman–style lifts supply linear SSMs in expanded coordinates, unifying ESN random features with operator–theoretic embeddings and illuminating the approximation–stability trade–off [33, 43]. These translations do not merely relabel known ESN practice; they provide a common foundation to compare ESNs, linear RNNs, and structured SSMs, and to reason about generalization through system poles, gains, and dissipativity. 

**Scope and contributions.** Our contributions are threefold. First, we formalize canonical mappings from ESNs to (i) nonlinear SSMs with exogenous noise, (ii) local linear/bi-linear SSMs via operating–point expansions, and (iii) lifted linear SSMs through random features and Koopman–inspired coordinates. Each mapping comes with explicit conditions under which the induced SSM is well posed and inherits ESP from ISS–type contraction bounds [41, 30]. Second, we translate core ESN properties into systems language: ESP ⇔ ISS for the driven recursion; fading memory via Lyapunov and gain–margin certificates; and controllability/observability tests for the linearized/lifted models, connecting reservoir hyperparameters to identifiability and effective memory length [20, 27]. Third, we develop a frequency–domain account for ESNs: linearizations yield transfer functions _H_ ( _z_ ) = _C_ ( _I_ − _z_[−][1] _A_ )[−][1] _B_ whose poles quantify memory–accuracy trade–offs and whose impulse responses recover the structured convolutional kernels underlying recent SSM layers [22, 16]. Throughout, we emphasize how these translations sharpen existing universality theorems and suggest principled design/regularization guidelines without departing from the ESN training paradigm [13, 11]. 

**Positioning.** Prior work situates ESNs within RC and nonlinear operator approximation [19, 29], while modern sequence models formulate learnable, stable SSMs with long memory via carefully structured kernels [15, 16, 14]. Our thesis is that both lines inhabit the same systems–theoretic landscape. By placing ESNs squarely in SSM territory, we make stability, identifiability, and frequency response first–class analytical objects, enabling apples–to–apples comparisons and cross–fertilization of techniques from classical identification and contemporary deep SSMs [27, 39]. 

**Organization.** Section 2 fixes notation for ESNs and SSMs. Section 3 develops the canonical SSM forms for ESNs (nonlinear, linearized, lifted) and states ISS–based ESP results. Section 4 analyzes controllability/observability and fading memory in the SSM view. Section 5 gives the frequency–domain account and kernel connections. Section 6 outlines identification perspectives (filtering/EM/subspace) for ESN hyperparameters. Section 9 situates our perspective in prior work, and Section 10 discusses limitations and avenues for structured, multi–rate, and probabilistic reservoirs. 

_Remark._ We adopt discrete time as the default analytical setting; continuous–time analogues obtained via standard discretizations (e.g., forward–Euler/Tustin) are noted where relevant. 

## **2 Preliminaries and Notation** 

Throughout, vectors are column–vectors; ∥⋅∥ denotes the Euclidean norm and its induced operator norm for matrices; _ρ_ ( _A_ ) is the spectral radius of _A_ ; _In_ is the _n_ × _n_ identity. Inputs _ut_ ∈ R _[m]_ , states _xt_ ∈ R _[n]_ , and outputs _yt_ ∈ R _[p]_ . For a sequence ( _ξt_ ) _t_ ∈Z, write _ξa_ ∶ _b_ = ( _ξa,...,ξb_ ), and _ℓ_ ∞(Z≤ _t_ ; R _[m]_ ) for 

2 

**==> picture [438 x 170] intentionally omitted <==**

**----- Start of picture text -----**<br>
y t<br>ESN core (frozen reservoir, linear readout) Canonical SSM views<br>Analyses<br>C Nonlinear SSM<br>u t xt +1 = f ( xt, ut ), yt = g ( xt, ut ) Stability & ESP<br>ISS ⇔ Echo State (contraction / LMI)<br>state stream<br>Leaky ESN core Local LTI (linearization)<br>( W, U, λ, σ ) fixed ( A, B, C, D ) at (¯ x,  ¯ u )<br>Frequency view<br>x t x t +1 Lifted LTI (Koopman) H ( z ), impulse kernel {hk}<br>z = ϕ ( x ), ( Aϕ, Bϕ, Cϕ )<br>nonlinear SSM local LTI lifted LTI analysis<br>**----- End of picture text -----**<br>


Figure 1: **ESNs as SSMs: canonical views and analyses.** Left: a leaky ESN core with fixed reservoir parameters ( _W,U,λ,σ_ ) maps ( **u** _t,_ **x** _t_ ) ↦ **x** _t_ +1; a linear readout _C_ yields **y** _t_ (only _C_ is trained). Middle: the same core is viewed in three canonical SSM forms: (i) a _nonlinear SSM_ , _xt_ +1 = _f_ ( _xt,ut_ ) _, yt_ = _g_ ( _xt,ut_ ); (ii) a _local LTI_ model obtained by small–signal linearization at an operating pair, with ( _A,B,C,D_ ); and (iii) a _lifted/Koopman LTI_ model in features _z_ = _ϕ_ ( _x_ ) with ( _Aϕ,Bϕ,Cϕ_ ). Right: each view supports a complementary analysis. The nonlinear SSM yields _stability_ via input–to–state stability (ISS), which is equivalent to the ESP under contraction or LMI certificates. The LTI views expose the _frequency domain_ : transfer function _H_ ( _z_ ) = _C_ ( _I_ − _z_[−][1] _A_ )[−][1] _B_ and impulse kernel _hk_ = _CA[k] B_ , whose poles _λi_ ( _A_ ) set memory decay ∣ _λi_ ∣ and oscillation arg _λi_ . Together these mappings justify ESN design dials (leak/time constant, spectral scaling, input gain), clarify interpretability (poles/residues ↔ memory/selectivity), and enable principled identification (KF/EM/subspace) within a unified SSM framework (Secs. 3–6). 

bounded semi-infinite input histories. We use “filter” to mean a causal, time-invariant map from input histories to outputs/states. 

## **2.1 Echo State Networks (leaky update, readout, ESP/fading memory)** 

An Echo State Network (ESN) specifies a driven recurrence with a fixed (random) reservoir and a trained linear readout [19, 29]. The _leaky_ ESN update with affine bias is 

**==> picture [355 x 12] intentionally omitted <==**

where _W_ ∈ R _[n]_[×] _[n]_ and _U_ ∈ R _[n]_[×] _[m]_ are fixed after initialization, _C_ ∈ R _[p]_[×] _[n]_ (and optionally _d_ ∈ R _[p]_ ) are trained, _σ_ ∶ R _[n]_ → R _[n]_ acts componentwise, and _λ_ ∈(0 _,_ 1] is the leak. We adopt: 

**Assumption A1 (activation).** _σ_ is globally Lipschitz with constant _Lσ_ (e.g., tanh has _Lσ_ = 1) and _σ_ (0) = 0. 

**Remark (continuous–time origin of the leak).** (2) arises from forward–Euler discretization of the ODE _τ_ ˙ _x_ = − _x_ + _σ_ ( _Wx_ + _Uu_ + _b_ ) with step ∆ _t_ , identifying _λ_ = ∆ _t_ / _τ_ . Thus _λ_ controls dissipation/time–scale, a fact we exploit when relating ESNs to SSMs. 

**Readout learning.** Given a sequence of states ( _xt_ ) and targets ( _yt_ ), the readout is typically estimated by ridge regression (or Bayesian linear regression) of _yt_ on _xt_ [19]. Training may use teacher forcing to generate the state trajectory. 

**Echo State Property.** Fix bounded inputs _u_ ∈ _ℓ_ ∞(Z; R _[m]_ ). The ESN has the ESP if for every pair of initial states _x_ 0 _,x_[′] 0[the induced trajectories satisfy][ ∥] _[x][t]_[ −] _[x] t_[′][∥→][0][ as] _[ t]_[ →∞][; equivalently, for each] _[ t]_[ there] 

3 

exists a unique state _xt_ = X( _u_ −∞∶ _t_ ) that depends causally on the entire past input and is independent of the initial condition [30]. A sufficient contraction condition under A1 is 

**==> picture [334 x 19] intentionally omitted <==**

uniformly in _ζ_ , which ensures a global input-to-state contraction and thus ESP [30]. Classical heuristics (e.g., rescaling to _ρ_ ( _W_ ) < 1) are special cases when _Lσ_ ≤ 1. 

**Fading memory.** Let _dα_ ( _u,v_ ) = sup _k_ ≤0 _α_[−] _[k]_ ∥ _uk_ − _vk_ ∥ for some _α_ ∈(0 _,_ 1) be a weighted metric on histories. A causal filter _F_ ∶ _u_ −∞∶ _t_ ↦ _zt_ has the _fading memory property_ (FMP) if it is continuous from ( _ℓ_ ∞ _,dα_ ) to R _[q]_ , i.e., remote past inputs are exponentially down-weighted. Under (3), the state map _u_ −∞∶ _t_ ↦ _xt_ and thus the output map _u_ −∞∶ _t_ ↦ _yt_ have FMP, connecting ESNs to the universality theorems for fading-memory filters [5, 13, 11]. 

## **2.2 State Space Models (DT/CT; linear, bilinear, and nonlinear SSMs)** 

We summarize discrete-time (DT) and continuous-time (CT) state space models in a form that will serve as the receiving framework for ESNs. 

**Linear time-invariant SSMs (DT/CT).** The DT LTI model with process/measurement perturbations is 

**==> picture [336 x 11] intentionally omitted <==**

while the CT counterpart is 

**==> picture [372 x 12] intentionally omitted <==**

Here _A_ ∈ R _[n]_[×] _[n]_ , _B_ ∈ R _[n]_[×] _[m]_ , _C_ ∈ R _[p]_[×] _[n]_ , _D_ ∈ R _[p]_[×] _[m]_ . Stability (e.g., _ρ_ ( _A_ ) < 1 in DT, Re _λi_ ( _A_ ) < 0 in CT), controllability/observability, and frequency-domain transfer functions _H_ ( _z_ ) = _C_ ( _I_ − _z_[−][1] _A_ )[−][1] _B_ + _D_ (DT) or _H_ ( _s_ ) = _C_ ( _sI_ − _A_ )[−][1] _B_ + _D_ (CT) are standard [22]. Discretization with step ∆ _t_ yields _Ad_ = _e[A]_[∆] _[t]_ , ∆ _t Bd_ = ∫0 _e[Aτ] dτ B_ , linking (5) to (4). 

**Bilinear SSMs.** Input–state interactions can be modeled bilinearly: 

**==> picture [366 x 27] intentionally omitted <==**

˙ or in CT form _x_ = _Ax_ + _Bu_ + ∑ _i uiBix_ + _w_ . Bilinear systems interpolate between LTI and general nonlinear SSMs while retaining useful analysis tools [22, 27]. 

**Nonlinear SSMs and regularity.** A general SSM is 

**==> picture [328 x 12] intentionally omitted <==**

with _f_ ∶ R _[n]_ × R _[m]_ → R _[n]_ , _g_ ∶ R _[n]_ × R _[m]_ → R _[p]_ . Under global Lipschitz or one-sided Lipschitz conditions on _f_ (in _x_ ) and bounded inputs, input-to-state stability (ISS) yields unique causal filters _u_ −∞∶ _t_ ↦ _xt_ and fading memory for _yt_ [41, 20]. Linearization of (7) about an operating point ( _x,_ ¯ ¯ _u_ ) gives an LTI surrogate with _A_ = _∂xf_ ( _x,_ ¯ ¯ _u_ ), _B_ = _∂uf_ ( _x,_ ¯ ¯ _u_ ), _C_ = _∂xg_ ( _x,_ ¯ ¯ _u_ ), _D_ = _∂ug_ ( _x,_ ¯ ¯ _u_ ); higher-order terms quantify the validity region. 

**Noise models and estimation.** The perturbations _wt,vt_ (or _w_ ( _t_ ) _,v_ ( _t_ )) may be deterministic bounded disturbances or stochastic (e.g., zero-mean with covariances _Q,R_ ). Classical filtering/smoothing (KF, EKF/UKF in the nonlinear case) and likelihood/EM-based identification operate in (4)–(7) [27, 39]. These tools will later instantiate ESN hyperparameter estimation and state denoising in the SSM view. 

**ESNs as SSMs (preview).** Equation (2) is a special case of (7) with _f_ ( _x,u_ ) = (1 − _λ_ ) _x_ + _λσ_ ( _Wx_ + _Uu_ + _b_ ) and _g_ ( _x,u_ ) = _Cx_ + _d_ . Small-signal linearization and random-feature (lifted) coordinates yield 

4 

LTI surrogates with explicit poles and impulse responses, placing ESNs within the same analytical – envelope as (4) (6). This identification underpins our use of ISS/ESP, controllability/observability, and frequency-domain tools in subsequent sections. 

## **2.3 Stability, contractivity, controllability, observability (definitions)** 

We collect the notions used throughout. Unless stated otherwise, all norms are Euclidean and the induced operator norm. 

**Internal/exponential stability (DT/CT).** Consider the autonomous DT system _xt_ +1 = _f_ ( _xt_ ) with equilibrium at the origin. It is _(globally) exponentially stable_ if ∃ _M_ ≥1, _α_ ∈(0 _,_ 1) such that for all _x_ 0, 

**==> picture [297 x 14] intentionally omitted <==**

For an LTI DT system _xt_ +1 = _Axt_ , exponential stability is equivalent to _ρ_ ( _A_ ) < 1. In CT, _x_ ˙ = _f_ ( _x_ ) is exponentially stable if ∥ _x_ ( _t_ )∥≤ _Me_[−] _[µt]_ ∥ _x_ (0)∥ for some _M,µ_ > 0; for LTI _x_ ˙ = _Ax_ , this is equivalent to max _i_ Re _λi_ ( _A_ ) < 0 [22]. 

**BIBO stability.** A causal input–output map is _bounded–input bounded–output_ (BIBO) stable if sup _t_ ∥ _ut_ ∥< ∞⇒ sup _t_ ∥ _yt_ ∥< ∞. For DT LTI _xt_ +1 = _Axt_ + _But, yt_ = _Cxt_ + _Dut_ , BIBO stability holds iff _A_ is DT exponentially stable (as above), equivalently the impulse response is absolutely summable, and the transfer _H_ ( _z_ ) = _C_ ( _I_ − _z_[−][1] _A_ )[−][1] _B_ + _D_ has no poles on/ outside the unit circle [22]. 

**Input-to-state stability (ISS).** For the DT system _xt_ +1 = _f_ ( _xt,ut_ ), ISS means there exist comparison functions[1] _β_ ∈KL and _γ_ ∈K∞ such that for all initial states and inputs 

**==> picture [305 x 22] intentionally omitted <==**

ISS implies the state is a causal, well–posed, fading–memory functional of the input; for LTI it reduces to exponential stability plus a bounded convolution operator. ISS provides the right language for the ESP used in ESNs [41, 20, 30]. 

**Incremental stability / contraction.** Let _Fu_ ∶ R _[n]_ → R _[n]_ be the one-step state map at input _u_ , i.e. _xt_ +1 = _Fut_ ( _xt_ ). The system is _contractive_ in a norm ∥⋅∥∗ if there exists _κ_ ∈(0 _,_ 1) such that 

**==> picture [379 x 13] intentionally omitted <==**

Uniform contraction implies _incremental ISS_ : for two trajectories driven by inputs _u,_ ¯ _u_ , 

**==> picture [346 x 29] intentionally omitted <==**

for some _Lu_ (Lipschitz in the input). In particular, with identical inputs the difference decays geometrically, which yields uniqueness of the input–driven state (ESP) and exponential fading memory [41, 30, 1]. For ESNs, a sufficient condition is ∥(1 − _λ_ ) _I_ + _λWJσ_ ( _ζ_ )∥< 1 uniformly (cf. (3)). 

**Controllability (reachability).** For DT LTI _xt_ +1 = _Axt_ + _But_ , the pair ( _A,B_ ) is _controllable_ if for any _x_ 0 _,xf_ there exists a finite input sequence steering _x_ 0 to _xf_ . Equivalently, 

**==> picture [324 x 13] intentionally omitted <==**

> 1 A function _α_ ∶ R≥0 → R≥0 is K if continuous, strictly increasing, _α_ (0) = 0; K∞ if additionally _α_ ( _r_ )→∞ as _r_ →∞. A function _β_ is KL if _β_ (⋅ _, t_ ) ∈K for each _t_ and _β_ ( _r, t_ )→ 0 as _t_ →∞ for each _r_ . 

5 

If _A_ is DT stable, controllability is also equivalent to the _reachability Gramian_ 

**==> picture [282 x 27] intentionally omitted <==**

being positive definite; _x_[⊺] _Wc_[−][1] _[x]_[ is the minimal input energy to reach] _[ x]_[ from][ 0][ [][22][]. For nonlinear SSMs] _xt_ +1 = _f_ ( _xt,ut_ ), _(small-time) local controllability_ is defined via reachability of a neighborhood and can be analyzed by the linearization ( _A,B_ ) = ( _∂xf,∂uf_ ) or, more generally, by Lie-algebraic conditions (Hermann–Krener) [17, 22]. 

**Observability.** For DT LTI _xt_ +1 = _Axt, yt_ = _Cxt_ , the pair ( _A,C_ ) is _observable_ if the initial state is uniquely determined from a finite output history. Equivalently, 

**==> picture [305 x 47] intentionally omitted <==**

If _A_ is DT stable, the _observability Gramian_ 

**==> picture [281 x 27] intentionally omitted <==**

is positive definite; _y_ -energy ∑ _t_ ∥ _yt_ ∥[2] equals _x_[⊺] 0 _[W][o][x]_[0][ for the zero-input response [][22][]. For nonlinear] systems, _local weak observability_ is defined via the rank of the differential of the _observability map_ formed by repeated Lie derivatives of the output along the dynamics (Hermann–Krener rank test) [17]. In this paper we use these LTI notions primarily for linearized/lifted ESN–as–SSM surrogates, where they provide practical tests and energy interpretations. 

The symbols in Tab. 1 are reused verbatim in Sections 3–5. When a specific norm or inner product different from Euclidean is used (e.g., weighted norms for contraction), this will be indicated explicitly. 

## **3 Canonical Forms** 

## **3.1 ESN as a nonlinear SSM** 

We rewrite the leaky ESN as a (possibly stochastic) discrete–time nonlinear state–space model: 

**==> picture [334 x 19] intentionally omitted <==**

with 

**==> picture [367 x 12] intentionally omitted <==**

where _xt_ ∈ R _[n]_ , _ut_ ∈ R _[m]_ , _yt_ ∈ R _[p]_ , _λ_ ∈(0 _,_ 1], _σ_ acts componentwise, and _ωt,νt_ are process/measurement perturbations (deterministic bounded or stochastic). 

**Regularity and Lipschitz moduli.** Under Assumption A1 ( _σ_ globally Lipschitz with constant _Lσ_ and _σ_ (0) = 0), _f_ is globally Lipschitz: 

**==> picture [395 x 29] intentionally omitted <==**

Hence, for bounded inputs, (16) is well posed and defines a causal filter. 

**ISS/ESP in SSM language.** If _Lx_ < 1, the one–step map _x_ ↦ _f_ ( _x,u_ ) is a contraction uniformly over bounded inputs; standard incremental stability (contraction) then yields input–to–state stability (ISS) and the ESP: the state _xt_ is the unique causal functional of _u_ −∞∶ _t_ independent of _x_ 0, with exponential fading 

6 

Table 1: **Symbols and notation used throughout.** 

|**Symbol**|**Meaning**|**Type / Dimensions**||||
|---|---|---|---|---|---|
|_t_,∆_t_|discrete time index; step size|Z≥0;R>0||||
|_ut,xt,yt_|input, state, output at time_t_|R_m,_R_n,_R_p_||||
|_wt,vt_|process/measurement perturbations|sequences inR_n,_R_p_||||
|_W,U,b_|ESN reservoir/input weights, bias|_W_∈R_n_×_n_,_U_∈R_n_×_m_,_b_∈R_n_||||
|_C,d_|readout matrix, bias|_C_∈R_p_×_n_,_d_∈R_p_||||
|_λ_|leak (dissipation) parameter|scalar in(0_,_1]||||
|_σ_,_Jσ_|activation (componentwise), its Jacobian|_σ_∶R_n_→R_n_;_Jσ_ ∈R_n_×_n_||||
|_Lσ_|global Lipschitz constant of_σ_|_Lσ_ ∈[0_,_∞)||||
|_A,B,C,D_|SSM/system matrices (LTI)|_A_∈R_n_×_n,B_∈R_n_×_m,C_∈R_p_×_n,D_∈R_p_×_m_||||
|_Bi_|bilinear input–state matrices|_Bi_∈R_n_×_n_||||
|_ρ_(_A_),_λi_(_A_)|spectral radius; eigenvalues of_A_|_ρ_(_A_) =max_i_∣_λi_(_A_)∣||||
|∥_x_∥,∥_M_∥|Euclidean norm; induced operator norm|∥_M_∥=sup∥_x_∥=1∥_Mx_∥||||
|_σ_min(_M_)_,σ_max(_M_)|extremal singular values|nonnegative scalars||||
|_In,_0_a_×_b_|identity; zero matrix|_n_×_n_;_a_×_b_||||
|⟨_x,y_⟩|inner product|_x_⊺_y_||||
|_ℓ_∞|bounded sequences space|{_ξ_∶sup_t_∥_ξt_∥<∞}||||
|K_,_K∞_,_KL|comparison function classes|see text (ISS)||||
|_H_(_z_)_,H_(_s_)|DT/CT transfer function|matrix–valued rational function||||
|C_,_O|controllability/observability matrices|C = [_B AB ... An_−1_B_];O =|⎡⎢⎢⎢⎢⎢⎢⎢⎢⎣<br>_C_<br>_CA_<br>⋮<br>_CAn_−1||⎤⎥⎥⎥⎥⎥⎥⎥⎥⎦|
|_Wc,Wo_|reachability/observability Gramians|_Wc_= ∑_k_≥0_AkBB_⊺(_A_⊺)_k_,_Wo_= ∑_k_≥0(_A_⊺)_kC_⊺_CAk_||||
|vec(⋅),⊗|vectorization; Kronecker product|standard linear–algebra ops||||
|blkdiag(⋅)|block–diagonal operator|matrix constructor||||



memory [41, 30]. The sufficient condition _Lx_ < 1 reduces to the usual ESN heuristic (1− _λ_ )+ _λ_ ∥ _W_ ∥ _Lσ_ < 1 and implies _ρ_ ( _∂xf_ (⋅)) ≤ _Lx_ < 1 (see also Sec. 2.3). 

**Continuous–time provenance.** Let _τ_ ˙ _x_ = − _x_ + _σ_ ( _Wx_ + _Uu_ + _b_ ) and discretize with forward–Euler step ∆ _t_ , identifying _λ_ = ∆ _t_ / _τ_ . Process noise _ωt_ corresponds to integrated CT disturbances; this connects leak _λ_ to a dissipation time–scale and will matter when we linearize or lift (16). 

## **3.2 Small–signal linearization around operating regimes (A, B, C, D; validity domains)** 

Let ( _x,_ ¯ ¯ _u_ ) be an _operating pair_ (e.g., an equilibrium satisfying _x_ ¯ = _f_ ( _x,_ ¯ ¯ _u_ ), or a point on a nominal trajectory _t_ ↦( _x_ ¯ _t,_ ¯ _ut_ )). Define small deviations _δxt_ ∶= _xt_ − _x_ ¯ and _δut_ ∶= _ut_ − _u_ ¯ (or _δxt_ ∶= _xt_ − _x_ ¯ _t_ , _δut_ ∶= _ut_ − _u_ ¯ _t_ in the time–varying case). A first–order Taylor expansion of (16) gives the LTI/LTV surrogate 

**==> picture [352 x 13] intentionally omitted <==**

with Jacobian blocks evaluated at the operating pair (or along the nominal trajectory) 

**==> picture [418 x 20] intentionally omitted <==**

where _ξ_ ∶= _Wx_ + _Uu_ + _b_ and _Jσ_ ( _ξ_ ) = diag( _σ_[′] ( _ξ_ 1) _,...,σ_[′] ( _ξn_ )). The remainders _rt,ηt_ collect second–order (and higher) terms. 

**LTI vs. LTV linearization.** If ( _x,_ ¯ ¯ _u_ ) is constant, ( _A,B,Cy,D_ ) is LTI. If we linearize along a nominal schedule ( _x_ ¯ _t,_ ¯ _ut_ ), we obtain an LTV model with _At_ = (1 − _λ_ ) _I_ + _λJσ_ ( _ξt_ ) _W_ and _Bt_ = _λJσ_ ( _ξt_ ) _U_ ; the transfer analysis in Sec. 5 specializes to frozen–time arguments in that case. 

7 

**Stability of the linearization.** ∥ _A_ ∥≤(1 − _λ_ ) + _λ_ ∥ _W_ ∥ _Lσ_ = _Lx_ . Thus, under the ESP/ISS sufficient condition _Lx_ < 1, any frozen–time _A_ is a contraction; in particular, _ρ_ ( _A_ ) ≤∥ _A_ ∥< 1, guaranteeing DT exponential stability of the small–signal model (and BIBO stability of its input–output map) [22]. 

**Validity domains and remainder bounds.** Assume _σ_ ∈ _C_[2] with uniformly bounded second derivative on a forward–invariant compact set S ⊂ R _[n]_ : ∥ _D_[2] _σ_ ( _z_ )∥≤ _Lσ_[(][2][)] for all _z_ ∈ _Wx_ + _Uu_ + _b_ with ( _x,u_ ) ∈S × U. Then by Taylor’s theorem, 

**==> picture [319 x 23] intentionally omitted <==**

so the linearization error is _O_ (∥( _δxt,δut_ )∥[2] ). A convenient validity domain is the tube 

**==> picture [339 x 12] intentionally omitted <==**

> on whichalong ( _x_ ¯ _t_ (19) _,_ ¯ _ut_ ) approximates), the same bound holds pointwise with (16) with one–step error bounded by _ξt_ = _W_ ¯ _xt_ + _U[λ]_ 2 _[L]_ ¯ _uσ_[(] _t_[2] +[)] _br_[2] .. In LTV form (linearization 

**Remark (bilinearized surrogates).** Keeping the first–order dependence of _Jσ_ ( _ξ_ ) on the small perturbations produces a bilinear correction _δxt_ +1 ≈ _Aδxt_ + _B δut_ + ∑ _i_ ( _δut_ ) _i Bi δxt_ with _Bi_ = _λ_ diag( _σ_[′′] ( _ξ_ )( _Uei_ )) _W_ . This is often unnecessary in practice but clarifies how input–dependent effective dynamics arise [22]. 

## **3.3 Lifted/Koopman SSMs: feature maps to obtain linear models in expanded state** 

The _Koopman operator_ acts linearly on observables of a nonlinear dynamical system [33, 38]. This suggests embedding ESN states into a higher–dimensional _lifted_ space where the evolution is approximately linear. 

**Dictionary of observables and lifted state.** Choose a feature map (dictionary) _ϕ_ ∶ R _[n]_ → R _[N]_ and define the lifted state _zt_ ∶= _ϕ_ ( _xt_ ). For the ESN map _xt_ +1 = _f_ ( _xt,ut_ ), the lifted one–step image is 

**==> picture [273 x 14] intentionally omitted <==**

If the dictionary is _closed under composition with f_ (i.e., each component of _ϕ_ ○ _f_ lies in the span of {1 _,ϕ_ 1 _,...,ϕN_ } and possibly input features), then there exist matrices _Aϕ,Bϕ,Dϕ_ and vector _cϕ_ such that the lifted dynamics is _exactly_ linear (or bilinear) in _zt_ and _ut_ : 

**==> picture [384 x 21] intentionally omitted <==**

The output becomes _yt_ = _Cϕzt_ + _d_ with _Cϕ_ selecting the identity component if _ϕ_ contains _x_ . 

**Approximate closure: EDMD/Carleman/random features.** For general analytic _σ_ , exact closure is unavailable with finite _N_ . Three standard approximations yield (24) with bounded residuals: 

1. _Extended DMD (EDMD)._ Take a finite dictionary _ϕ_ (polynomials, radial basis, Fourier, delays). The Koopman action on _ϕ_ is approximated in least squares, yielding _Aϕ,Bϕ,cϕ_ that minimize the one–step residual _et_ ∶= _ϕ_ ( _f_ ( _xt,ut_ )) −( _Aϕϕ_ ( _xt_ ) + _Bϕut_ + _cϕ_ ) [43, 38]. In theory sections, we assume access to such a representation with a known uniform bound ∥ _et_ ∥≤ _ε_ on a compact forward–invariant set.[2] 

2. _Carleman lifting._ Expand the analytic nonlinearity via Taylor series and collect monomials of _x_ (and _u_ ) up to degree _d_ . The augmented monomial vector _ψd_ ( _x,u_ ) evolves under a _block upper–triangular_ linear operator; truncation at degree _d_ yields a linear model with remainder controlled by the tail of the series on a compact domain [26]. For the ESN, expanding _σ_ ( _ξ_ ) = ∑[∞] _k_ =0 _[a][k][ξ][k]_[around an operating] point makes _ξ_ = _Wx_ + _Uu_ + _b_ polynomial in ( _x,u_ ), hence Carleman applies. 

> 2We analyze the consequences of such a bound; empirical identification of _Aϕ, Bϕ, cϕ_ is orthogonal to our theoretical claims. 

8 

3. _Random/kernal features._ For shift–invariant kernels, random Fourier features approximate nonlinear maps by finite–dimensional features _ϕ_ ( _x_ ) = √2/ _N_ [cos( _ωi_[⊺] _[x]_[ +] _[ b][i]_[)]] _i[N]_ =1[. One can then regress a linear] _Aϕ,Bϕ_ so that _ϕ_ ○ _f_ ≈ _Aϕϕ_ + _Bϕu_ + _cϕ_ on a compact set, with uniform error controlled by kernel approximation plus regression error (Stone–Weierstrass–type arguments apply to rich dictionaries). 

**A generic lifted surrogate and its guarantees.** Assume a compact forward–invariant set S × U and a dictionary _ϕ_ containing a constant and the identity, such that 

**==> picture [340 x 25] intentionally omitted <==**

Then the lifted LTI SSM 

**==> picture [345 x 12] intentionally omitted <==**

with _zt_ = _ϕ_ ( _xt_ ), approximates the ESN on S × U with one–step model error ∥ _ω_ ˜ _t_ ∥≤ _ε_ . If _ρ_ ( _Aϕ_ ) < 1, the lifted surrogate is DT exponentially stable and BIBO stable; standard small–gain arguments imply an _a priori_ bound on the _k_ -step prediction error that contracts at rate _ρ_ ( _Aϕ_ ) and accumulates linearly in _ε_ (geometric series). 

**Connecting to frequency–domain kernels.** When _ϕ_ includes identity and low–order monomials of preactivations _ξ_ = _Wx_ + _Uu_ + _b_ , the block structure of _Aϕ_ is (nearly) upper triangular with a stable diagonal block equal to the small–signal _A_ from (20). The induced transfer function _H_ ( _z_ ) = _Cϕ_ ( _I_ − _z_[−][1] _Aϕ_ )[−][1] _Bϕ_ + _Dϕ_ has exponentially decaying impulse responses whose time constants are controlled by the eigenvalues of _Aϕ_ . This makes precise how ESNs, when viewed through linearizations or lifts, implement the structured convolutional kernels exploited by modern SSM layers [15, 16]. 

**Remarks.** (i) If _ϕ_ augments the identity with time–delay coordinates (Hankel features), then (26) recovers classical finite–impulse–response approximations to fading–memory filters within a linear state–space [22]. (ii) Stability of the base ESN (ISS/ESP) aids the lift: if _xt_ stays in a compact S for bounded inputs, then _ϕ_ and the Taylor/EDMD residuals are uniformly controlled on S. 

## **3.4 Random-feature SSMs** 

Consider the leaky ESN map 

**==> picture [399 x 12] intentionally omitted <==**

For each coordinate, approximate the static nonlinearity _σ_ ∶ R→R on a compact set Ψ ⊂ R by a fixed (data-independent) feature dictionary _ϕ_ ∶ R→R _[N]_ and a linear combiner: 

**==> picture [326 x 22] intentionally omitted <==**

with _v_ ∈ R _[N]_ . Choices include random Fourier features for shift-invariant kernels, random ridge features, or bounded orthonormal systems; approximation rates of order _O_ P(1/ ~~√~~ _N_ ) are classical under RKHS/Barron-type regularity [35, 36, 3, 2]. Stacking these approximations componentwise yields a matrix _V_ ∈ R _[n]_[×] _[N]_ and a vector feature map Φ ∶ R _[n]_ →R _[N]_ such that 

**==> picture [334 x 21] intentionally omitted <==**

**Lur’e form and “augmented LTI core.”** Substituting (29) gives 

**==> picture [413 x 12] intentionally omitted <==**

with _A_ 0 = (1 − _λ_ ) _I_ , _Bu_ = 0 (or a direct term if desired), _Bz_ = _λV_ , _Gx_ = _W_ , _Gu_ = _U_ , _g_ 0 = _b_ . The pair ( _A_ 0 _,Bz_ ) defines a _linear time-invariant core_ fed back through the _static, memoryless_ nonlinearity 

9 

_z_ = Φ(⋅); this is the canonical Lur’e interconnection. If Φ is globally Lipschitz on Ψ _[n]_ with constant _L_ Φ, the closed loop inherits ISS/ESP from small-gain (circle-criterion/IQC) conditions. 

**A sufficient small-gain condition (robust to RF error).** Let _L_ Φ ∶= sup _ξ_ ≠ _ξ_ ′ ∥Φ( _ξ_ )− Φ( _ξ_[′] )∥/∥ _ξ_ − _ξ_[′] ∥ on Ψ _[n]_ . Then for the idealized model (no RF error), 

**==> picture [418 x 12] intentionally omitted <==**

**==> picture [307 x 19] intentionally omitted <==**

Hence a uniform contraction (and thus ESP/ISS) holds if 

**==> picture [380 x 19] intentionally omitted <==**

When the RF approximation incurs uniform error _ε_ as in (29), the one-step model mismatch acts as ˜ ˜ an additive disturbance _ωt_ with ∥ _ωt_ ∥≤ _λε_ . Under (33), the induced state error remains bounded by a geometric series, yielding an ISS bound with ultimate radius _O_ ( _λε_ /(1 − _κ_ )), where _κ_ ∶= (1 − _λ_ ) + _λ_ ∥ _V_ ∥ _L_ Φ∥ _W_ ∥ [41, 1]. 

**LMI (quadratic) certificate via circle criterion.** Suppose Φ is sector-bounded/Lipschitz: ∥Φ( _ξ_ ) − Φ( _ξ_[′] )∥≤ _L_ Φ∥ _ξ_ − _ξ_[′] ∥. A quadratic Lyapunov certificate for absolute stability of (30) is given by _P_ ≻ 0 satisfying the LMI (one formulation) 

**==> picture [309 x 30] intentionally omitted <==**

which implies a contraction in the weighted norm ∥ _x_ ∥ _P_ ∶= ~~√~~ _x_[⊺] _Px_ for the feedback interconnection (discrete-time circle criterion/IQC; see, e.g., [23, 31]). This yields an ESP/ISS guarantee that can be tuned via _λ_ , ∥ _V_ ∥, and ∥ _W_ ∥. 

**Remarks.** (i) The random-feature view keeps the dynamics linear in the _unknown_ parameters while isolating nonlinearity in a fixed, memoryless block; it is thus complementary to Koopman lifts (Sec. 3.3). (ii) If Φ contains the identity and low-order monomials of preactivations, one recovers the small-signal matrices _A_ = (1 − _λ_ ) _I_ + _λJσ_ ( _ξ_ ) _W_ , _B_ = _λJσ_ ( _ξ_ ) _U_ as first-order terms. (iii) For design, (33) suggests trading off _λ_ and ∥ _V_ ∥∥ _W_ ∥ to target a memory timescale 1/(1 − _κ_ ) while preserving ESP. 

## **3.5 Continuous-time ESN as ODE/SDE and its discretization** 

A continuous-time (CT) ESN with time constant _τ_ > 0 is the first-order lag driven by a static nonlinearity: 

**==> picture [395 x 15] intentionally omitted <==**

where _wc,vc_ are (deterministic bounded) disturbances or, in an SDE model, white-noise terms:[3] 

**==> picture [392 x 24] intentionally omitted <==**

**Explicit-Euler (forward-Euler) discretization.** Sampling with period ∆ _t_ and zero-order hold on _u_ yields the Euler–Maruyama scheme [18, 25]: 

**==> picture [362 x 24] intentionally omitted <==**

**==> picture [341 x 31] intentionally omitted <==**

> 3 1 SDE form: _dx_ = _τ_[( −] _[x]_[ +] _[ σ]_[(⋅))] _[ dt]_[ +][ Σ] _[ dB][t]_[, with] _[ B][t]_[a Wiener process and diffusion][ Σ][.] 

10 

with _ωt_ ∼N(0 _,Qd_ ) in the SDE case, where _Qd_ = ∆ _t_ ΣΣ[⊺] (to first order). Thus the discrete-time leak _λ_ is the Euler step-normalized inverse time constant. For ∆ _t_ ≪ _τ_ , this coincides with the “leaky ESN” update used throughout. 

**Exact discretization of the linearized CT model.** Linearize (35) around an operating pair ( _x,_ ¯ ¯ _u_ ). Writing _fc_ ( _x,u_ ) ∶= _τ_[1][( −] _[x]_[ +] _[ σ]_[(] _[Wx]_[ +] _[ Uu]_[ +] _[ b]_[))][, the linearization has matrices] 

**==> picture [445 x 19] intentionally omitted <==**

Under zero-order hold, the exact DT equivalent is [22, 39] 

**==> picture [393 x 24] intentionally omitted <==**

with _Qc_ = ΣΣ[⊺] the CT diffusion. For small ∆ _t_ , _Ad_ = _I_ + ∆ _tAc_ + _O_ (∆ _t_[2] ) and _Bd_ = ∆ _tBc_ + _O_ (∆ _t_[2] ), recovering Euler. 

**Bilinear/Tustin (trapezoidal) discretization.** An alternative numerically stable mapping (the bilinear or Tustin transform) applied to the scalar lag _τ_ ˙ _x_ = − _x_ + _s_ ( _t_ ) gives the DT update 

**==> picture [371 x 24] intentionally omitted <==**

In the ESN, _st_ = _σ_ ( _Wxt_ + _Uut_ + _b_ ). Hence the effective “leak” is 

**==> picture [332 x 30] intentionally omitted <==**

For ∆ _t_ ≪ _τ_ , _λ_ Tustin ≈ ∆ _t_ / _τ_ = _λ_ ; for larger ∆ _t_ , Tustin yields a slightly smaller effective leak (more damping) and improved numerical robustness [8]. 

**ISS/ESP in CT and preservation under discretization.** If _σ_ is globally Lipschitz with constant _Lσ_ , then _fc_ is one-sided Lipschitz with constant _µc_ = _τ_[1][(−][1][ +] _[ L][σ]_[∥] _[W]_[∥)][.][Whenever][ −][1][ +] _[ L][σ]_[∥] _[W]_[∥<][ 0] (i.e., _Lσ_ ∥ _W_ ∥< 1), the CT system is incrementally exponentially stable (hence ISS) for bounded inputs; explicit Euler with sufficiently small ∆ _t_ preserves incremental stability (and thus ESP) because the DT contraction factor satisfies 

**==> picture [353 x 15] intentionally omitted <==**

matching the discrete small-gain condition in Secs. 2.1–3.1. 

**Noise mapping (SDE** → **DT).** In the linearized SDE, the DT process covariance is the Lyapunov integral in (40). To first order, _Qd_ ≈ _Qc_ ∆ _t_ . This scaling underlies the common practice of tying the ESN process noise magnitude to the sampling period in probabilistic formulations [39]. 

**Takeaways.** (i) The leaky ESN is the explicit-Euler discretization of a simple CT lag; the “leak” is _λ_ = ∆ _t_ / _τ_ to first order. (ii) Exact (linearized) discretization and Tustin yield alternative _λ_ –∆ _t_ relations – (40) (42) with better numerical damping at larger steps. (iii) ISS/ESP conditions match between CT and DT descriptions when expressed in terms of dissipation 1/ _τ_ , Lipschitz slope _Lσ_ ∥ _W_ ∥, and step ∆ _t_ . 

## **4 S stem-Theoretic Pro erties of ESN-as-SSM y p** 

– We work with the nonlinear SSM formulation of the leaky ESN from (16) (17), under Assumption A1 ( _σ_ globally Lipschitz with constant _Lσ_ , _σ_ (0) = 0). Norms are Euclidean unless stated otherwise. 

11 

## **4.1 Echo State Property as input-to-state stability** 

**Setup.** Consider _xt_ +1 = _f_ ( _xt,ut_ ) with _f_ ( _x,u_ ) = (1 − _λ_ ) _x_ + _λσ_ ( _Wx_ + _Uu_ + _b_ ). Let U _M_ ∶= { _u_ ∶ sup _t_ ∥ _ut_ ∥≤ _M_ } be a bounded input class. Recall: ISS means ∃ _β_ ∈KL _, γ_ ∈K∞ s.t. 

**==> picture [307 x 22] intentionally omitted <==**

and _incremental ISS_ (iISS) means for any two solutions under inputs _u,_ ¯ _u_ , 

**==> picture [328 x 29] intentionally omitted <==**

for some _κ_ ∈(0 _,_ 1), _Lu_ ≥ 0. The ESP asserts: for every _u_ ∈U _M_ there exists a unique entire state trajectory ( _xt_ ) that is a causal functional of _u_ −∞∶ _t_ and independent of _x_ 0 [30]. 

**Proposition 4.1** (ESP ⇔ (incremental) ISS for ESN) **.** _Suppose f is globally Lipschitz in x with constant Lx_ < 1 _and Lipschitz in u with constant Lu (Sec. 3.1). Then: (i) the map x_ ↦ _f_ ( _x,u_ ) _is a global contraction uniformly over bounded u; hence incremental ISS_ (45) _holds with κ_ = _Lx; (ii) for each u_ ∈U _M there exists a unique input-driven solution xt_ = X( _u_ −∞∶ _t_ ) _satisfying ESP; (iii) the state and output maps have exponential fading memory and_ (44) _holds (ISS). Conversely, if ESP holds uniformly over_ U _M and f is continuous and globally Lipschitz in u, then there exists an equivalent norm_ ∥⋅∥∗ _under which f_ (⋅ _,u_ ) _is a contraction with a common constant κ_ < 1 _on compact forward-invariant sets, implying iISS._ 

_Sketch._ The forward implication follows from standard contraction/iISS arguments (Banach fixedpoint theorem on the state-update operator and telescoping differences) and yields ESP plus fading memory [41, 1, 30]. The reverse direction uses equivalence of norms on finite-dimensional spaces and uniform attractivity of the input-driven solution to construct an ISS-Lyapunov function and a contracting metric [41]. ◻ 

**Constants for the ESN.** With Assumption A1, 

**==> picture [395 x 30] intentionally omitted <==**

Thus _Lx_ < 1 is a sufficient global condition for ESP/ISS; see also the weighted-norm generalization in Sec. 4.2. 

## **4.2 Sufficient conditions via Lipschitz constants and spectral radius** 

We collect three practically checkable sufficient conditions ensuring contraction (hence ESP/ISS). 

**(C1) Global Lipschitz contraction.** As above, 

**==> picture [364 x 12] intentionally omitted <==**

This is norm-dependent but conservative; it transparently links leak _λ_ , reservoir gain ∥ _W_ ∥, and nonlinearity slope _Lσ_ . 

**(C2) Weighted (quadratic) contraction via an LMI.** Let _Jσ_ ( _ξ_ ) be the diagonal Jacobian with ∥ _Jσ_ ( _ξ_ )∥≤ _Lσ_ for all _ξ_ . Define the Jacobian of the one-step map in _x_ : 

**==> picture [329 x 12] intentionally omitted <==**

If there exists _P_ ≻ 0 and _κ_ ∈(0 _,_ 1) such that the uniform matrix inequality 

**==> picture [384 x 14] intentionally omitted <==**

holds, then ∥ _x_ ∥ _P_ ∶= ~~√~~ _x_[⊺] _Px_ is a contracting metric and ESP/ISS follow with rate _κ_ . A sufficient 

12 

(conservative) LMI independent of ( _x,u_ ) is 

**==> picture [405 x 21] intentionally omitted <==**

obtainable by S-procedure/IQC bounds for slope-restricted _σ_ (discrete-time circle criterion) [23, 31]. 

**(C3) Local small-signal (spectral-radius) condition.** At an operating pair ( _x,_ ¯ ¯ _u_ ) (or along a nominal trajectory), the small-signal model has 

**==> picture [337 x 11] intentionally omitted <==**

If _ρ_ ( _A_ ) < 1 (equivalently, there exists _P_ ≻ 0 with _A_[⊺] _PA_ ≺ _P_ ), the linearized dynamics is DT exponentially stable; this certifies local (tube) contraction of the nonlinear map and local ESP with an _O_ (∥( _δx,δu_ )∥[2] ) remainder (Sec. 3.2; [22]). A conservative but convenient bound is _ρ_ ( _A_ ) ≤∥ _A_ ∥≤ (1 − _λ_ ) + _λLσ_ ∥ _W_ ∥. 

**Input gains and iISS.** Under any of (C1)–(C3), the input Lipschitz constant _Lu_ = _λ_ ∥ _U_ ∥ _Lσ_ yields the iISS bound (45). This makes explicit the memory-versus-gain trade-off: as _κ_ ↑ 1, the effective horizon grows (Sec. 4.4), but sensitivity to input perturbations increases proportionally to 1/(1 − _κ_ ). 

## **4.3 Controllability/observability of the lifted (linear) system** 

We analyze the lifted surrogate from Sec. 3.3: 

**==> picture [325 x 12] intentionally omitted <==**

(neglecting bounded approximation error for exposition). These notions govern identifiability and the effectiveness of readouts on lifted states. 

**LTI rank tests.** For an LTI surrogate with stable _Aϕ_ ∈ R _[N]_[×] _[N]_ : 

**==> picture [368 x 78] intentionally omitted <==**

Equivalently, Gramians 

**==> picture [368 x 27] intentionally omitted <==**

are positive definite [22]. 

**Practical criteria for large** _N_ **.** (i) _Truncated Gramians._ For _ρ_ ( _Aϕ_ ) < 1, ∥ _A[k] ϕ_[∥≤] _[cρ]_[(] _[A][ϕ]_[)] _[k]_[;][thus] finite truncations _Wc_[(] _[T]_[)] ∶= ∑ _[T] k_ =0 _[A][k] ϕ[B][ϕ][B] ϕ_[⊺][(] _[A]_[⊺] _ϕ_[)] _[k]_[converge geometrically to] _[ W][c]_[.][In practice one tests] _λ_ min( _Wc_[(] _[T]_[)] ) > _ϵ_ for moderate _T_ (e.g., _T_ ≈⌈5/(1 − _ρ_ ( _Aϕ_ ))⌉). (ii) _Persistent excitation._ Identification and controllability require inputs that are _persistently exciting of order N_ : there exists _α_ > 0 such that the block Toeplitz input covariance over a window _T_ ≥ _N_ is ⪰ _αI_ [27, 34]. This ensures _Wc_[(] _[T]_[)] ≻ 0 empirically. (iii) _Dictionary design._ If _ϕ_ includes the identity on _x_ and _Cϕ_ selects those coordinates, then observability of the base block is immediate; otherwise one must ensure that the chosen readout _Cϕ_ “sees” all dynamically active directions (e.g., include identity and low-order monomials of _x_ or preactivations _ξ_ ). (iv) _Numerical conditioning._ Even when rank tests pass, ill-conditioned _Wo,Wc_ imply 

13 

weak identifiability and large variance in readouts/regression. Regularization (ridge, priors) or structural constraints on _Aϕ_ (normal/banded/diagonal-plus-low-rank) mitigate this. 

**Local analysis via small-signal blocks.** In the small-signal LTI model ( _A,B,C_ ) of Sec. 3.2, controllability/observability of ( _A,B_ ), ( _A,C_ ) give local criteria for how input scaling ( _U_ ) and readout placement ( _C_ ) affect excitation and identifiability. In particular, if _A_ is close to normal with eigenvalues inside the unit disk, _Wo_ concentrates along eigen-directions with ∣ _λi_ ( _A_ )∣ near 1; these directions carry long memory and are easiest to observe [22]. 

## **4.4 Fading memory and effective horizon; links to eigenvalues and mixing** 

**Fading memory via contraction.** Under iISS with contraction factor _κ_ ∈(0 _,_ 1) and input Lipschitz _Lu_ , a perturbation _δut_ at time _t_ − _h_ affects _xt_ by at most _κ[h]_[−][1] _Lu_ ∥ _δut_ − _h_ ∥. Fix _ε_ > 0 and bound ∥ _δu_ ∥≤ _M_ . The _effective memory horizon Hε_ (the smallest _h_ so that contributions older than _h_ are below _ε_ ) satisfies 

**==> picture [329 x 32] intentionally omitted <==**

so _Hε_ scales like 1/(1 − _κ_ ) near the edge of stability. This provides a quantitative design rule linking leak/spectral scaling ( _κ_ ) to memory length [41, 5]. 

**Frequency-domain view (linearized/lifted).** For a stable LTI/LTI-lifted surrogate, _yt_ = ∑ _k_ ≥0 _hkut_ − _k_ with impulse blocks _hk_ = _CA[k] B_ . Then ∥ _hk_ ∥≤∥ _C_ ∥∥ _A[k]_ ∥∥ _B_ ∥≤ _c_ ∥ _C_ ∥∥ _B_ ∥ _ρ_ ( _A_ ) _[k] ,_ so memory decay is governed by _ρ_ ( _A_ ). If _A_ is diagonalizable _A_ = _V_ Λ _V_[−][1] , then _hk_ = _CV_ Λ _[k] V_[−][1] _B_ = ∑ _i λ[k] i[Cv][i][w] i_[⊺] _[B]_ revealing oscillatory memory (complex _λi_ = _re[jω]_ ) with envelope _r[k]_ . Directions with ∣ _λi_ ∣≈ 1 dominate long-horizon responses and contribute most to observability/controllability Gramians [22]. This explains the kernel shapes used in modern SSMs (exponentially decaying/oscillatory) and their ESN counterparts (Sec. 5; [16]). 

**Stochastic inputs/noise and mixing.** With bounded Lipschitz _f_ and additive disturbances/noise ( _ωt_ ) or random inputs _ut_ , the state process ( _xt_ ) is a time-homogeneous Markov chain on R _[n]_ with a global contraction in a Wasserstein (or weighted Euclidean) metric when _κ_ < 1. Standard results imply geometric ergodicity and geometric decay of mixing coefficients at rate _κ_ (up to constants), i.e., _β_ ( _h_ ) ≤ _C κ[h]_ [32, Ch. 15]. Thus the deterministic fading-memory rate and the stochastic mixing rate coincide, tying effective horizon to statistical dependence decay. 

**Memory capacity heuristics.** For scalar LTI surrogates _xt_ +1 = _axt_ + _but_ , the contribution of _ut_ − _h_ to _yt_ scales like _a[h]_ , yielding the classical “memory capacity” growth as _a_ ↑ 1 (edge-of-stability) but with increased sensitivity to noise/perturbations—precisely the 1/(1 − _κ_ ) trade-off that appears in (56) [5]. (For information-theoretic capacity measures in RC, see [7].) 

The properties above—ESP as ISS, contraction-based sufficient conditions, CO tests on lifted surrogates, and quantitative memory horizons—provide a unified, systems-theoretic foundation for ESNs. They justify principled design dials (leak _λ_ , spectral scaling ∥ _W_ ∥, input gain ∥ _U_ ∥) and clarify trade-offs between long memory, stability margins, and identifiability. 

## **5 Fre uenc –Domain View and Convolutional Kernels q y** 

We analyze the (linearized or lifted) ESN–as–SSM in the frequency domain and relate its impulse kernels to modern SSM convolutions. Throughout this section, _A_ ∈ R _[N]_[×] _[N]_ , _B_ ∈ R _[N]_[×] _[m]_ , _C_ ∈ R _[p]_[×] _[N]_ denote a stable LTI surrogate obtained either by small–signal linearization (Sec. 3.2) or by a lifted representation (Sec. 3.3); _D_ is an optional feedthrough (zero for the standard ESN readout). 

## **5.1 Transfer function (linearized/lifted case)** 

For the discrete–time LTI model 

**==> picture [315 x 11] intentionally omitted <==**

14 

the (matrix) _transfer function_ is the _z_ –transform of the impulse response [22]: 

**==> picture [360 x 36] intentionally omitted <==**

with region of convergence ∣ _z_ ∣> _ρ_ ( _A_ ). Stability ( _ρ_ ( _A_ ) < 1) ensures that the boundary evaluation _H_ ( _e[ȷω]_ ) is well–defined and bounded for all _ω_ ∈[− _π,π_ ]. 

If _A_ is diagonalizable, _A_ = _V_ Λ _V_[−][1] with Λ = diag( _λ_ 1 _,...,λN_ ), then 

**==> picture [287 x 29] intentionally omitted <==**

_w_[⊺] 1 where _vi_ and _wi_[⊺][are][right/left][eigenvectors][(] _[V]_[−][1][=] ⋯ ). Thus the poles of _H_ are precisely the ⎡⎢⎢⎢⎢⎣ _wN_[⊺] ⎤⎥⎥⎥⎥⎦ 

eigenvalues of _A_ ; their radii ∣ _λi_ ∣ set decay rates, and their arguments arg( _λi_ ) set oscillation frequencies (discrete–time resonances). 

Two norms are useful: the _H_ ∞ norm ∥ _H_ ∥ _H_ ∞ = sup _ω σ_ max( _H_ ( _e[ȷω]_ )) controls worst–case gain, while ∥ _H_ ∥ _H_ 2 (finite for strictly proper _D_ = 0) relates to output energy under white excitation and equals tr( _CWcC_[⊺] ) where _Wc_ solves _Wc_ = _AWA_[⊺] + _BB_[⊺] [22]. 

## **5.2 Impulse–response kernels, memory spectra, and Bode intuition** 

The time–domain input–output relation of (57) is a causal convolution 

**==> picture [354 x 27] intentionally omitted <==**

Hence the ESN’s linearized/lifted behavior is entirely encoded by the _impulse kernel_ ( _hk_ ) _k_ ≥0. Three basic consequences: 

**(i) Decay and “effective memory.”** If _ρ_ ( _A_ ) < 1, then ∥ _A[k]_ ∥≤ _cρ_ ( _A_ ) _[k]_ for some _c_ ≥ 1. Therefore ∥ _hk_ ∥≤ _c_ ∥ _C_ ∥∥ _B_ ∥ _ρ_ ( _A_ ) _[k]_ . The contribution of inputs older than _H_ time steps satisfies ∑ _k_ > _H_ ∥ _hk_ ∥≲ “ ∥ _C_ ∥∥ _B_ ∥ _ρ_ ( _A_ ) _[H]_[+][1] /(1 − _ρ_ ( _A_ )), so the _ε_ –horizon” grows like _Hε_ ≃ log(∥ _C_ ∥∥ _B_ ∥/ _ε_ )/(1 − _ρ_ ( _A_ )) (cf. Sec. 4.4). Near the edge of stability ( _ρ_ ( _A_ ) ↑ 1) the memory length diverges at rate 1/(1 − _ρ_ ( _A_ )). 

**(ii) Modal oscillations and selectivity.** Write _λi_ = _rie[ȷω][i]_ with 0 < _ri_ < 1. Modal contributions are _hk_ = ∑ _i ri[k][e][ȷkω][i]_[ (] _[Cv][i]_[)(] _[w] i_[⊺] _[B]_[)] _[,]_[ i.e., exponentially decaying sinusoids. Thus] _[ H]_[(] _[e][ȷω]_[)][ exhibits] _[ Bode]_[ peaks] near _ω_ = _ωi_ ; sharper peaks occur when _ri_ is close to 1 or when the modal residue ( _Cvi_ )( _wi_[⊺] _[B]_[)][ is large.] Complex–conjugate pole pairs generate narrowband oscillatory memory; real poles near +1 generate broadband slow decay. 

**(iii) Power spectra under stochastic excitation.** With zero–mean, wide–sense stationary input _u_ having spectral density _Su_ ( _ω_ ), the output spectral density is 

**==> picture [299 x 13] intentionally omitted <==**

so _H_ shapes input spectra multiplicatively. For white input _Su_ ( _ω_ ) = _σ_[2] _I_ , peaks of _Sy_ coincide with resonant modes of _A_ . This ties kernel design to spectral selectivity in sequence tasks [22]. 

**Bounds that connect time and frequency views.** Let _Wc_ and _Wo_ be the reachability/observability Gramians of ( _A,B_ ) and ( _A,C_ ). Then ∑ _k_ ≥0 tr( _hkh_[⊺] _k_[) =][ tr][(] _[CW][c][C]_[⊺][) =] 21 _π_[∫] − _ππ_[tr][(] _[H]_[(] _[e][ȷω]_[)] _[H]_[(] _[e][ȷω]_[)][∗][)] _[dω,]_ which equivalently views kernel energy as an average (over frequency) gain [22]. Directions with large Gramian weight correspond to long-memory eigenmodes (eigenvalues near the unit circle). 

15 

## **5.3 Relation to modern SSM kernels and when ESNs emulate them** 

Modern “SSM layers” in deep sequence models (e.g., HiPPO and S4 families) implement long–range convolutions by parameterizing a stable state matrix with _structured spectra_ and learning the input/output couplings [15, 16, 14]. Their discrete- or continuous-time kernels take the canonical forms 

**==> picture [331 x 14] intentionally omitted <==**

often with _A_ diagonal or normal in a known basis (e.g., diagonal–plus–low–rank (DPLR), Fourier/Legendre bases), enabling fast convolution via recurrences or FFTs. We now state precise conditions under which an ESN emulates these kernels. 

**(E1) Small–signal linearization with near–normal reservoir.** Suppose the ESN operates in a regime where _Jσ_ ( _ξ_ ) ≈ _αI_ (e.g., symmetric slope about 0 for tanh) so that the linearized _A_ ≈(1 − _λ_ ) _I_ + _λαW_ . If _W_ is chosen normal with prescribed eigenvalues (e.g., random unitary times diagonal radii) then _A_ inherits those eigenvectors and has poles _λi_ ( _A_ ) = (1 − _λ_ ) + _λα λi_ ( _W_ ). The resulting kernel _hk_ = _CA[k] B_ is a mixture of decaying sinusoids whose rates and frequencies are controlled directly by the spectrum of _W_ ; this realizes the same family of exponentially decaying/oscillatory kernels parameterized in S4 via diagonal _A_ in a special basis [16]. 

_Design corollary._ To match a target kernel envelope with time constants { _τi_ } and frequencies { _ωi_ }, 1 assign eigenvalues _λi_ ( _A_ ) = _e_[−][1][/] _[τ][i] e[ȷω][i]_ and choose _W_ ≈ _λα_[(] _[λ][i]_[(] _[A]_[) −(][1][ −] _[λ]_[))][ along those modes; then] set _B_ and _C_ (via _U_ and readout) to realize desired modal residues. 

**(E2) Lifted/Koopman LTI surrogates with DPLR structure.** In a lifted ESN (Sec. 3.3), select a dictionary _ϕ_ so that the identified _Aϕ_ is (approximately) diagonalizable with known basis and low–rank input/output couplings (e.g., _ϕ_ includes identity and a small set of oscillatory features). If _Aϕ_ is diagonal and _Bϕ,Cϕ_ are low rank, then the kernel _hk_ = _CϕA[k] ϕ[B][ϕ]_[ has the same DPLR structure exploited in S4] for _O_[˜] ( _N_ ) kernel generation and convolution [16]. The ESN thus “inherits” an SSM kernel through its lift, while its nonlinear core ensures the lift remains expressive on nonlinearly separable inputs. 

**(E3) Continuous–time equivalence and discretization.** For CT parameterizations with _Ac_ Hurwitz (eigenvalues _αi_ + _ȷωi_ with _αi_ < 0), the kernel _k_ ( _t_ ) = _Ce[A][c][t] B_ = ∑ _i e[α][i][t] e[ȷω][i][t] Cviwi_[⊺] _[B]_[. Discretizing with] step ∆ _t_ maps eigenvalues by _λi_ ( _A_ ) = _e_[(] _[α][i]_[+] _[ȷω][i]_[)][∆] _[t]_ ; therefore CT SSM kernels (e.g., HiPPO/S4) and DT ESN linearizations coincide after sampling. Tustin/bilinear discretization slightly shrinks radii (extra damping), which can be compensated in design (Sec. 3.5; [8]). 

**(E4) When the ESN does** _**not**_ **emulate structured SSM kernels.** If _W_ is highly non-normal with widely spread pseudospectra, _A_ may produce long transients unrelated to its eigenvalues, leading to kernels that are not well captured by diagonal/DPLR parameterizations; conversely, steeply saturating _σ_ invalidates the _Jσ_ ≈ _αI_ approximation, and the small–signal kernel changes with input amplitude. These regimes fall outside the clean equivalence with S4–style kernels and are better treated in the nonlinear time–domain (ISS) view. 

**Bode intuition and ESN hyperparameters.** The leak _λ_ radially contracts/expands poles of _A_ (around 1), hence sets the global memory scale; input scaling (∥ _U_ ∥) and readout ( _C_ ) scale modal residues; the reservoir spectrum (via _W_ ) sets pole radii and angles. Tuning ( _λ,W,U_ ) in ESNs is therefore equivalent, in the linearized/lifted sense, to shaping the SSM kernel’s passband, roll–off, and resonances—exactly the dials exposed by modern SSM layers [16, 15]. 

## **6 Identification and Training via SSM Inference** 

We cast ESN training and hyperparameter selection as inference in (linearized or lifted) state–space models. This yields denoised latent states, principled updates for noise covariances and dynamical hyperparameters, and spectral design knobs compatible with ESP/ISS. 

16 

## **6.1 Teacher forcing as state estimation; KF/UKF/EKF perspectives** 

Consider the linearized/lifted surrogate 

**==> picture [324 x 11] intentionally omitted <==**

where _At_ ≡ _A_ in the LTI case (Sec. 3.2) or _At_ is frozen from a relinearization along a nominal trajectory (LTV). With Gaussian _wt_ ∼N(0 _,Q_ ), _vt_ ∼N(0 _,R_ ), the posterior over states is Gaussian and can be computed by Kalman filtering and Rauch–Tung–Striebel (RTS) smoothing [37, 39, 22]. Denote filter means/covariances by ( _µt_ ∣ _t,Pt_ ∣ _t_ ) and one–step predictions by ( _µt_ +1∣ _t,Pt_ +1∣ _t_ ). The forward recursions are 

**==> picture [332 x 14] intentionally omitted <==**

**==> picture [439 x 15] intentionally omitted <==**

**==> picture [262 x 16] intentionally omitted <==**

**==> picture [380 x 14] intentionally omitted <==**

and the smoothed cross–covariance _Pt,t_ +1∣ _T_ = _JtPt_ +1∣ _T_ (for LTI; the general formula includes an extra correction term) [39]. 

In this lens, _teacher forcing_ —running the reservoir on the measured _u_ and using measured _y_ for supervision—becomes _state estimation_ : the smoothed means _µt_ ∣ _T_ ≈ E[ _xt_ ∣ _y_ 1∶ _T ,u_ 1∶ _T_ ] are denoised “teacher–forced” states, with uncertainty _Pt_ ∣ _T_ . For genuine nonlinear SSMs one uses EKF/RTS (linearize _f,g_ at _µ_ ) or UKF/URTS (unscented transform) to approximate the same objects [21, 42, 39]. These posteriors are the sufficient statistics driving the EM updates below. 

## **6.2 EM for hyperparameters** 

Let _θ_ collect the parameters to estimate. In our setting _θ_ can include (i) the discrete leak _λ_ or its CT time constant _τ_ (Sec. 3.5), (ii) a _spectral scaling α_ multiplying the reservoir in small–signal form _A_ ( _θ_ ) ≈(1 − _λ_ ) _I_ + _λα W_[¯] with _W_[¯] fixed (e.g., normalized _W_ or a Jacobian average), and (iii) noise covariances _Q,R_ . With the linear–Gaussian surrogate (63), maximum likelihood can be performed by EM [40, 10, 39]. 

**E–step.** Run a KF/RTS (or EKF/UKF smoother) under current _θ_[(] _[k]_[)] to compute 

**==> picture [442 x 59] intentionally omitted <==**

**M–step:** _Q,R_ **.** For fixed _At,Bt,C_ the covariance updates are closed–form: 

**==> picture [398 x 62] intentionally omitted <==**

**==> picture [343 x 29] intentionally omitted <==**

1 The compact form is _Q_ = _T_ −1[∑][E][[(] _[x][t]_[+][1][ −] _[A][t][x][t]_[ −] _[B][t][u][t]_[)(⋅)][⊺][∣] _[y,u]_[]][,] _[ R]_[ =] _T_[1][∑][E][[(] _[y][t]_[ −] _[Cx][t]_[)(⋅)][⊺][∣] _[y,u]_[]] [10, 39]. 

17 

**M–step:** _λ_ **, spectral scaling** _α_ **.** Treat _A_ as _structured linear_ in _θ_ : _A_ ( _θ_ ) = ∑ _[r] i_ =1 _[θ][i][M][i]_[with][basis] _M_ 1 = _I_ , _M_ 2 = _W_[¯] so that _θ_ 1 = 1 − _λ_ , _θ_ 2 = _λα_ . Maximizing the expected complete–data log–likelihood is equivalent to minimizing the quadratic prediction error 

**==> picture [339 x 29] intentionally omitted <==**

Let _A_ LS ∶= [∑ _t_ ˆ _xt_ +1 _x_ ˆ[⊺] _t_[−] _[B]_[ ∑] _t[u][t][x]_[ˆ][⊺] _t_[]][[∑] _t[X]_[ˆ] _[t]_[]][−][1][be][the][(temporarily)][unconstrained][least–squares] estimate of the state transition. Project _A_ LS onto the span span{ _M_ 1 _,M_ 2} in Frobenius norm: write _M_ = [vec( _M_ 1) vec( _M_ 2)] and set 

**==> picture [337 x 14] intentionally omitted <==**

Recover _λ,α_ from _θ_[ˆ] 1 = 1 − _λ_ , _θ_[ˆ] 2 = _λα_ , and (optionally) project ( _λ,α_ ) to _λ_ ∈(0 _,_ 1] _, α_ > 0. To respect ESP/ISS, either enforce the conservative small–gain constraint (1 − _λ_ ) + _λLσ_ ∥ _αW_[¯] ∥<1 or the quadratic LMI certificate of Sec. 4.2 during the projection (nearest–feasible projection) [23, 31]. 

Two refinements are standard. First, in an _iterative local–linearization EM_ , recompute _W_[¯] (e.g., as an average _Jσ_ ( _ξ_[ˆ] _t_ ) _W_ ) from the latest smoothed states and repeat. Second, in a lifted LTI model (Sec. 3.3) the same EM applies with _Aϕ,Bϕ,Cϕ,Q,R_ unconstrained, after which _Aϕ_ can be reduced to a diagonal/DPLR form if desired (Sec. 5). 

## **6.3 Readout learning with state uncertainty: ridge/Bayesian forms** 

Given smoothed posteriors { _x_ ˆ _t,Pt_ ∣ _T_ }, the readout _C_ in _yt_ = _Cxt_ + _vt_ is the maximizer of the conditional likelihood 

**==> picture [305 x 28] intentionally omitted <==**

This yields the closed form 

**==> picture [341 x 26] intentionally omitted <==**

Adding Tikhonov (ridge) regularization _[λ]_ 2 _[r]_[∥] _[C]_[∥] _F_[2][modifies the denominator to][ ∑] _[t][X]_[ˆ] _[t]_[ +] _[ λ][r][I]_[.] A fully Bayesian treatment places a Gaussian prior vec( _C_ ) ∼N(0 _,τ_[−][1] _I_ ). Approximating the latent state by its posterior (Laplace/plug–in), the posterior over vec( _C_ ) is Gaussian with precision 

**==> picture [367 x 22] intentionally omitted <==**

where ⊗ is the Kronecker product [4]. This quantifies readout uncertainty inherited from state uncertainty. In the lifted LTI case one can similarly update _D_ (if present) and treat multi–output couplings. 

## **6.4 Hybrid subspace identification to shape reservoir spectra under ESP** 

Subspace identification (SSI) offers nonparametric estimates of _A,B,C_ from input–output trajectories via Hankel matrices and orthogonal projections (MOESP/N4SID) [34, 27]. In the ESN–as–SSM view, SSI can _shape_ the reservoir spectrum in a data–driven but stability–aware manner. 

The workflow is conceptual. First, compute an SSI estimate ( _A_ ssi _,B_ ssi _,C_ ssi) for a chosen model order on persistently exciting data. This gives a target pole set and residue structure that match the task’s memory spectrum (Sec. 5). Second, _project_ this target onto the ESN’s small–signal form. With _A_ ( _θ_ ) = _θ_ 1 _I_ + _θ_ 2 _W_[¯] as above, solve 

**==> picture [366 x 19] intentionally omitted <==**

using the linear projection (71) followed by a nearest–feasible projection onto the contractive set. If one is allowed to _design W_ , choose _W_ normal with eigenvalues that pull the poles of _A_ ( _θ_ ) toward those of 

18 

_A_ ssi while enforcing (1 − _λ_ ) + _λLσ_ ∥ _αW_ ∥< 1 (or the LMI). This preserves ESP/ISS and imports SSI’s spectral profile. 

When using lifted models, apply SSI on the lifted state _zt_ (estimated via EDMD features) to obtain _Aϕ_ with a diagonal/DPLR structure; this immediately delivers S4–like kernels (Sec. 5) while the original ESN nonlinearity governs feature construction. In all cases, persistent excitation of inputs and well–conditioned Gramians are essential for identifiability and low variance [34, 27]. 

**Remarks.** (i) EM and SSI can be combined: use SSI to initialize ( _A,B,C_ ), then refine _Q,R_ and the structured _θ_ by EM with a contraction constraint. (ii) Enforcing ESP/ISS during identification is not merely cosmetic: it regularizes ill–posed long–memory fits and mitigates drift, echoing the small–gain/LMI design in Sec. 4.2. (iii) In CT formulations, the same pipeline applies with _Ac_ Hurwitz, then discretized (Sec. 3.5). 

## **7 Design Recipes and Practical Guidelines** 

We synthesize system–theoretic insights into practical knobs for ESNs viewed as SSMs. Let _A_ denote a linearized/lifted state matrix (Sec. 3.2, 3.3), with contraction factor _κ_ ∶= ∥ _A_ ∥ (or a certified _κ_ < 1 in a weighted norm via Sec. 4.2). Unless noted, _σ_ = tanh so _Lσ_ ≤ 1. 

## **7.1 Choosing leak, spectral radius, input scaling: rules of thumb from poles & kernels** 

**Target memory** ⇒ **pole radius.** Pick an _effective horizon H_ in steps at tolerance _ε_ . For a stable LTI surrogate, contributions older than _H_ scale like _ρ_ ( _A_ ) _[H]_ . A convenient target is the half–life _H_ 1/2 = ln2/(− ln _ρ_ ( _A_ )). Equivalently, 

**==> picture [311 x 16] intentionally omitted <==**

(cf. the _ε_ –horizon estimate in (56)). Choose _r_ ⋆ small for short memory; push _r_ ⋆ ↑ 1 for long memory (noting the 1/(1 − _r_ ⋆) sensitivity trade–off). 

**Mapping** ( _λ,W_ ) ↦ _ρ_ ( _A_ ) **.** Around typical operating slopes _s_ ∶= E[ _σ_[′] ( _ξ_ )] ∈(0 _,Lσ_ ], the linearization reads 

**==> picture [280 x 11] intentionally omitted <==**

If _W_ is normal with _ρ_ ( _W_ ) = _γ_ , then _ρ_ ( _A_ ) ≈(1 − _λ_ ) + _λsγ_ . To hit _r_ ⋆ for a chosen _λ_ , 

**==> picture [353 x 25] intentionally omitted <==**

When _s_ is uncertain, design with _s_ = _Lσ_ to preserve a guaranteed ESP margin; in practice _s_ ∈[0 _._ 5 _,_ 1) for tanh if preactivations are near zero–mean with unit scale, yielding less conservative _γ_ . 

**Leak as a time–constant.** In CT form _τ_ ˙ _x_ = − _x_ + _σ_ (⋅) and explicit Euler with step ∆ _t_ gives _λ_ = ∆ _t_ / _τ_ (Sec. 3.5). Thus _τ_ sets a global decay scale. For multi–rate memory, use _block leaks λ_ = blkdiag( _λ_ 1 _,...,λG_ ) (or stacked reservoirs), covering a log–spaced set of time constants _τg_ whose induced _ρ_ ( _Ag_ ) tile ( _r_ min _,r_ max). 

**Spectrum shaping.** Prefer _W normal_ (e.g., unitary times diagonal radii) so _A_ inherits well–behaved modes; place a fraction of poles as real radii near +1 (slow trends) and the rest as complex–conjugate pairs with ∣ _λi_ ∣= _r_ ⋆ and arg( _λi_ ) tiling [0 _,π_ ] (oscillatory memory). A _log–uniform_ spread of radii ∣ _λi_ ∣∈[ _r_ min _,r_ max) approximates a 1/ _f_ –like bank of time scales. 

**Guaranteed ESP margin.** A conservative global certificate (Sec. 2.1, 4.2) is 

**==> picture [337 x 12] intentionally omitted <==**

19 

independent of _λ_ . In practice enforce ∥ _W_ ∥≤ _η_ / _Lσ_ with _η_ ∈(0 _,_ 1) to retain margin under input–dependent slope variation; then tune _λ_ and the _modal placement_ within that budget to reach _r_ ⋆. For tighter, less conservative guarantees, certify contraction in a weighted norm via the LMI in (50). 

**Input scaling** _U_ **: keep** _ξ_ = _Wx_ + _Uu_ + _b_ **in the linear–slope region.** Favour regimes where ∣ _ξi_ ∣≲ 2 so _σ_[′] ( _ξ_ ) stays large (for tanh). Whiten inputs (pre–scale _u_ so Cov( _u_ ) ≈ _I_ ), then choose _U_ with per–row norm ∥ _Ui_ ∶∥2 ≈ _υ_ producing Var( _ξi_ ) ≈ _υ_[2] near 1. A simple default is ∥ _U_ ∥[2] _F_[≈] _[n]_[ (unit variance per neuron] when _u_ is white). If the reservoir already yields Var( _Wx_ ) near unity, reduce _υ_ to avoid saturation; if _Wx_ is small (strong leak), increase _υ_ to preserve sensitivity. The input Lipschitz _Lu_ = _λ_ ∥ _U_ ∥ _Lσ_ (Sec. 2.1) quantifies the gain/noise trade–off. 

## **7.2 Noise modeling as regularization; robustness to drift & shift** 

**Process/measurement noise as** _**state**_ **and** _**output**_ **regularizers.** In a linearized/lifted SSM with Gaussian _wt_ ∼N(0 _,Q_ ), _vt_ ∼N(0 _,R_ ), the maximum–likelihood state estimate minimizes 

**==> picture [332 x 29] intentionally omitted <==**

so _Q_ penalizes fast variations of the latent dynamics (a _temporal_ Tikhonov term), while _R_ penalizes readout misfit (a _measurement_ weighting). Larger _Q_ induces smoother, more robust hidden states; larger _R_ downweights noisy outputs and curbs overfitting of _C_ (Sec. 6.1, 6.3) [39, 22]. 

**ISS robustness bound.** With contraction factor _κ_ < 1, additive model error/disturbance _dt_ (e.g., RF approximation error, shifts) produces a bounded state deviation 

**==> picture [352 x 29] intentionally omitted <==**

so designing for a margin 1 − _κ_ trades longer memory for bounded sensitivity (Sec. 4.4) [41, 1]. This is the core robustness lever under drift/shift: keep _κ_ comfortably below 1 when reliability trumps horizon. 

**Distribution shift: forgetting and covariance scheduling.** Under nonstationarity, use _exponential forgetting_ in readout estimation (recursive ridge/least squares with factor _β_ ∈(0 _,_ 1)) to bias toward recent regimes; in SSM inference, increase _Q_ (or reduce _β_ ) when mismatch grows, and decrease _R_ when outputs are trusted—both are principled levers in KF/RTS that correspond to adaptive regularization [39]. For shifts that alter the signal’s passband, re–place poles (Sec. 7.1) or switch among predesigned spectral tiles (block leaks) rather than pushing a single _κ_ to the edge. 

**Sector/LMI robustness to slope variation.** If inputs can drive _σ_[′] anywhere in [0 _,Lσ_ ], certify absolute stability with the LMI in (50) (discrete circle–criterion). This gives a _uniform_ ESP certificate that tolerates slope fluctuations and small modeling errors without re–tuning _λ_ or ∥ _W_ ∥ [23, 31]. 

## **7.3 Computational complexity, batching, and long–sequence throughput** 

**Per–step update.** A dense reservoir update costs _O_ ( _n_[2] ) flops for _Wxt_ plus _O_ ( _nm_ ) for _Uut_ and _O_ ( _n_ ) for _σ_ (⋅). With _k_ nonzeros per row (sparsity), the cost is _O_ ( _kn_ ). Orthogonal/FFT–like _W_ (Hadamard/DFT with diagonal scalings) yields _O_ ( _n_ log _n_ ) multiplies while preserving normality and good spectra. **Readout estimation.** Closed–form ridge on _T_ steps forms the Gram ∑ _t xtx_[⊺] _t_[in] _[ O]_[(] _[Tn]_[2][)][ and inverts] an _n_ × _n_ matrix in _O_ ( _n_[3] ). For long sequences, maintain running sums (streaming ridge) and solve once; for very large _n_ , use conjugate gradients on the normal equations with the Gram as a linear operator. With state uncertainty (Sec. 6.3), replace _xtx_[⊺] _t_[by] _[X]_[ˆ] _[t]_[ =] _[ P][t]_[∣] _[T]_[+][ ˆ] _[x][t][x]_[ˆ][⊺] _t_[.] 

20 

**Kalman smoothing.** Dense KF/RTS is _O_ ( _n_[3] ) per time step due to Riccati updates. Structure drops this: diagonal/banded _A_ yields _O_ ( _n_ )/ _O_ ( _nb_[2] ); normal _A_ = _Q_ Λ _Q_[∗] with isotropic _Q_ allows fast transforms in prediction/innovation covariances. In lifted SSMs with diagonal/DPLR _A_ (Sec. 3.3, 5), convolutions can be executed in _O_ ( _N_ log _N_ ) via FFT–style kernels. 

**Batching and long sequences.** For _B_ sequences of length _L_ , teacher forcing is embarrassingly parallel across sequences. In memory–bound settings, use _chunked_ unrolling: process windows of length _Lw_ with overlap _H_ (the effective horizon), carrying only the final states between chunks—errors beyond _H_ are negligible by design (cf. (56)). Keep computations in float64 when _ρ_ ( _A_ ) ≈ 1 to avoid accumulation error; renormalize states intermittently if using non–normal _W_ . 

**When to linearize/lift for speed.** If the downstream pipeline only needs linear responses (e.g., fixed kernels), freeze a lifted LTI surrogate with certified stability and run _yt_ = ∑ _k_ ≥0 _hkut_ − _k_ via FFTs (Sec. 5). Use the full nonlinear ESN only when input–dependent gating is essential; otherwise linearized kernels offer substantial throughput gains with predictable memory spectra. 

Taken together: (i) pick a memory target and place poles (via _λ_ , _ρ_ ( _W_ ), and modal geometry) to hit _r_ ⋆; (ii) keep preactivations in the linear–slope regime by whitening inputs and scaling _U_ ; (iii) retain an ESP margin (global Lipschitz or LMI certificate) for robustness; (iv) treat _Q,R_ as principled regularizers against drift and noise; and (v) exploit structure (normal/sparse _W_ , diagonal/DPLR lifts) to keep cost linear or near–linear in _n_ and sequence length. 

## **8 Extensions** 

## **8.1 Deep/stacked ESNs as block SSMs; skip connections and multi–rate leaks** 

Consider _L_ leaky ESN layers with intra–layer recurrent weights _Wℓ_ , inter–layer feedforward _Vℓ_ (from layer _ℓ_ −1 to _ℓ_ ), input matrices _Uℓ_ , and leaks _λℓ_ ∈(0 _,_ 1]: 

**==> picture [395 x 84] intentionally omitted <==**

with optional _skip connections_ (residuals) from earlier layers to the readout. Linearizing around an operating trajectory produces a block lower–triangular SSM 

**==> picture [389 x 67] intentionally omitted <==**

where _Aℓℓ_ = (1 − _λℓ_ ) _I_ + _λℓJσ_ ( _ξℓ_ ) _Wℓ_ and _Aℓ,ℓ_ −1 = _λℓJσ_ ( _ξℓ_ ) _Vℓ_ . Because _A_ blk is block triangular, 

**==> picture [278 x 16] intentionally omitted <==**

Hence, if each layer satisfies the single–layer contraction (e.g., (1 − _λℓ_ ) + _λℓLσ_ ∥ _Wℓ_ ∥< 1), then the deep stack is (globally) exponentially stable in the linearized sense; with slope–restricted _σ_ , the weighted–norm LMI (circle–criterion/IQC) yields a _uniform_ ESP certificate for the full deep ESN (Sec. 4.2; [23, 31]). 

**Multi–rate leaks.** Choosing { _λℓ_ } on a log–spaced grid of time constants _τℓ_ = ∆ _t_ / _λℓ_ tiles a bank of memory scales—equivalently, _Aℓℓ_ places pole radii ∣ _λi_ ( _Aℓℓ_ )∣ across [ _r_ min _,r_ max). Residual/skip readouts 

21 

improve observability by exposing both short– and long–memory layers to the linear head. See also deep/stacked RC [9, 28]. 

## **8.2 Bilinear/multiplicative SSM formulations for input–gated reservoirs** 

Input–dependent _gating_ can be expressed bilinearly. Two equivalent views: 

## **(i) Bilinear SSM.** 

**==> picture [366 x 26] intentionally omitted <==**

with _Bi_ capturing multiplicative modulation by input channel _i_ [22]. This arises from a first–order expansion of _Jσ_ ( _ξ_ ) around a nominal _ξ_[¯] (Sec. 3.2: “bilinearized surrogates”). 

## **(ii) Gated ESN map.** 

**==> picture [362 x 52] intentionally omitted <==**

with Γ( _ut_ ) diagonal or low rank (e.g., Γ( _ut_ ) = diag( _Gut_ )). Under bounded _ut_ and slope–restricted _σ_ , the closed loop admits a contraction certificate if 

**==> picture [373 x 15] intentionally omitted <==**

or via the quadratic LMI of Sec. 4.2 (replace _Bz_ and _Gx_ accordingly). Bilinear/gated SSMs retain linear readouts and enable selective memory injection without sacrificing ESP [23, 31]. 

## **8.3 Spatiotemporal inputs: convolutional reservoirs as local SSMs on grids** 

Let images _ut_ ∈ R _[H]_[×] _[W]_[×] _[c]_ , states _xt_ ∈ R _[H]_[×] _[W]_[×] _[n]_ . A _local SSM_ with periodic boundaries is 

**==> picture [344 x 11] intentionally omitted <==**

where ∗ denotes spatial convolution and _A_ ∗ is a bank of _n_ × _n_ kernels (e.g., 3×3 or 5×5). Vectorizing the field reveals a block–circulant–with–circulant–blocks (BCCB) matrix A whose eigenvectors are 2D Fourier modes; the _symbol A_[̂] ( _ωx,ωy_ ) ∈ R _[n]_[×] _[n]_ is the DFT of the kernels. Stability and memory follow _frequencywise_ : 

**==> picture [399 x 23] intentionally omitted <==**

Thus design can place per–frequency poles (lowpass/ bandpass/ directional) by shaping _A_[̂] , exactly paralleling CNN intuition with system guarantees [22, 12]. 

A _convolutional ESN_ instantiates (88) by replacing _A_ ∗∗ _xt_ with (1− _λ_ ) _xt_ + _λσ_ (( _W_ ∗∗ _xt_ )+( _U_ ∗∗ _ut_ )+ _b_ ), where _W_ ∗ and _U_ ∗ are random fixed kernels (shared spatially). The small–signal _A_ ∗( _ξ_ ) = (1 − _λ_ ) _I_ + _λJσ_ ( _ξ_ ) _W_ ∗ yields a BCCB _A_ ; the same frequencywise radius test applies. On graphs or irregular grids, replace convolutions by polynomials of the (normalized) Laplacian _L_ : _A_ ≈(1 − _λ_ ) _I_ + _λs_ ∑ _[K] k_ =0 _[α][k][T][k]_[(] _[L]_[˜][)][,] with Chebyshev polynomials _Tk_ diagonalized by the graph Fourier basis; stability holds if the polynomial stays inside the unit disk on the Laplacian spectrum [22]. 

## **8.4 Probabilistic ESNs: process/measurement noise, smoothing, and uncertainty** 

Adopt the linearized/lifted model with Gaussian noise: 

**==> picture [397 x 12] intentionally omitted <==**

22 

Kalman filtering/smoothing yields posteriors _p_ ( _xt_ ∣ _y_ 1∶ _T ,u_ 1∶ _T_ ) = N( _µt_ ∣ _T ,Pt_ ∣ _T_ ) (Sec. 6.1; [39, 22]). The _predictive_ distribution at horizon _h_ is 

**==> picture [386 x 30] intentionally omitted <==**

with Σ _h_ = _A[h] Pt_ ∣ _t_ ( _A_[⊺] ) _[h]_ + ∑ _[h] j_ =[−] 0[1] _[A][j][Q]_[(] _[A]_[⊺][)] _[j]_[.][Credible][bands][follow][immediately.][In][the][nonlinear] ESN, EKF/UKF provide Gaussian approximations to the same objects. Bayesian readouts (ridge priors) propagate latent uncertainty into output uncertainty (Sec. 6.3; [4]). These probabilistic views formalize ESN robustness to noise/drift and support principled model selection through marginal likelihood (EM; Sec. 6.2). 

## **9 Related Work** 

## **9.1 Reservoir computing & fading–memory theory** 

Echo State Networks and Liquid State Machines introduced the RC paradigm of fixed recurrent cores with trained linear readouts [19, 29]. Foundational analyses connect RC to causal fading–memory filters [5], establish universality and rates for ESN–like architectures under Lipschitz/mixing assumptions [13, 11], and characterize the ESP via contraction and input–to–state stability (ISS) [30]. Practical surveys and tutorials cover design choices and training (ridge, teacher forcing) [28]. Our contribution recasts these results in standard SSM language, enabling direct use of ISS, Gramians, and frequency–domain tools. 

## **9.2 System identification and SSMs (classical to modern)** 

The classical LTI/SSM canon (transfer functions, BIBO, controllability/observability, Gramians) is well established [22]. Identification methods include subspace identification (MOESP/N4SID) and likelihood/EM for linear–Gaussian models [34, 27, 10, 40], with Kalman filtering/smoothing as the core inference engine [39, 37]. Our SSM view of ESNs imports these tools: state denoising via KF/RTS, EM updates for _Q,R_ and spectral scaling under ESP constraints, and SSI–based spectral shaping. For nonlinear systems, contraction/ISS and circle–criterion/IQC LMIs provide robust, slope–restricted stability certificates [23, 31]. 

## **9.3 Connections to neural ODE/CDE and kernel/state–space Transformers** 

˙ Neural ODEs and CDEs parameterize flows _x_ = _fθ_ ( _x,t_ ) and controlled dynamics _dx_ = _fθ_ ( _x,t_ ) _dt_ + _gθ_ ( _x,t_ ) _dUt_ , connecting deep models to continuous–time dynamical systems and rough paths [6, 24]. Parallelly, modern sequence models based on _structured state space_ layers (HiPPO, S4, and successors) learn long–range convolutional kernels _kk_ = _CA[k] B_ (or _k_ ( _t_ ) = _Ce[At] B_ ) with spectra designed for stability and efficiency [15, 16, 14]. Our analysis shows that ESNs, under linearization or lifting, yield precisely such kernels: poles of the small–signal _A_ set decay/oscillation; residues determine passbands; leaks control global time–constants. The SSM lens therefore provides a rigorous bridge between classical RC and contemporary kernel/SSM architectures, while ESP/ISS–based certificates offer principled stability beyond heuristic spectral–radius tuning. 

## **10 Discussion and Limitations** 

## **10.1 When ESN-as-SSM helps—and when it does not** 

Casting ESNs as SSMs is most advantageous when the driven dynamics admit a uniform contraction (or a verifiable weighted contraction) on a forward–invariant set and when the task can be characterized by stable, exponentially decaying (possibly oscillatory) memory kernels. In these regimes, poles and residues give interpretable handles on horizon, selectivity, and gain; ISS certificates translate directly into Echo State guarantees; and identification tools (Kalman smoothing, EM, and subspace methods) become well posed, providing denoised latent states and principled hyperparameter updates (Secs. 4–6). The frequency–domain view then supplies Bode–style intuition for passbands and roll–off (Sec. 5), while structured designs—normal or diagonal–plus–low–rank state matrices, block leaks, and 

23 

convolutional/graph local SSMs—deliver predictable behavior with efficient implementations (Secs. 7, 8). 

The reduction is less faithful when the update departs strongly from the slope–restricted regime or when input–dependent switching dominates. Highly non–Lipschitz maps (e.g., polynomial activations without domain restriction), hard resets or discontinuities, and aggressive multiplicative gating can break a uniform contraction and invalidate small–signal surrogates except on tiny tubes. Severe saturation is also problematic: if the preactivation spends long intervals where _σ_[′] ( _ξ_ )≈0, then the effective Jacobian becomes state–dependent in a way that undermines any frozen _A_ , and the lifted LTI approximation must be reidentified continually (Sec. 3.2). Strong non–normal reservoirs create large transient growth unrelated to eigenvalues; linearized pole placement then mispredicts short–timescale amplification even if _ρ_ ( _A_ ) < 1. Finally, tasks that require algebraically long memory, noncausal context, or exact time–delay lines are not well captured by exponentially decaying kernels; in such cases (e.g., nearly lossless propagation or delay–dominant physics), the SSM kernel family needs augmentation with near–unit–modulus modes or explicit delay embeddings. 

## **10.2 Identifiability caveats, data requirements, and brittleness to mis–specification** 

State–space parametrizations are identifiable only up to similarity transforms; consequently, linearized or lifted models admit multiple equivalent representations with indistinguishable input–output behavior. In lifted spaces, nonuniqueness is amplified: different dictionaries _ϕ_ (EDMD, random features, Carleman truncations) induce distinct coordinates _z_ and hence distinct ( _Aϕ,Bϕ,Cϕ_ ) that approximate the same nonlinear filter on a compact set. Without further structure, diagonal or DPLR reductions are model choices rather than truths. This places a premium on explicit structural priors (normality, bandedness, diagonal blocks) and on stability certificates that are invariant to coordinate changes (ISS/LMI conditions in Sec. 4.2). 

Reliable identification also demands sufficient excitation and window length. Subspace methods require persistently exciting inputs of order equal to the lifted dimension and observation windows covering the effective horizon; EM needs adequate signal–to–noise and well–conditioned Gramians to avoid degenerate _Q_ / _R_ estimates. In practice, confounding between leak _λ_ and spectral scaling of _W_ is common: multiple ( _λ,α_ ) pairs can realize nearly the same pole radii in _A_ . Regularization or constraints (e.g., fixing ∥ _W_ ∥ and estimating _λ_ ) mitigate this ambiguity, but the resulting point estimates should be interpreted as one of several observationally equivalent parametrizations. 

Model mis–specification introduces brittleness that the SSM lens makes explicit. Gaussian, time–invariant _Q_ / _R_ are convenient but often unrealistic; colored disturbances, heavy tails, and nonstationary noise alter Kalman gains and can bias EM. Piecewise–stationary data induce LTV linearizations whose frozen _At_ change faster than identification can track; if relinearization is too infrequent, the kernel view drifts from the true behavior. Approximate closure errors in lifts (finite dictionaries) act as persistent disturbances; their accumulation scales as _O_ ( _ε_ /(1 − _κ_ )) and can dominate when the design is pushed to the edge of stability. These effects highlight the value of maintaining a stability margin (not just _ρ_ ( _A_ )<1 but a certified contraction) and of treating _Q_ as a tunable regularizer rather than a physical covariance (Secs. 7.2, 6.2). 

## **10.3 Opportunities for structure** 

The SSM framing surfaces principled opportunities for structure that trade a small amount of generality for strong guarantees and speed. Normal or near–normal _A_ provides transparent pole geometry and well–behaved transient growth; diagonal–plus–low–rank forms preserve expressivity while enabling fast kernel application and stable identification. Banded or Toeplitz–like _A_ captures local couplings and admits _O_ ( _N_ )– _O_ ( _N_ log _N_ ) algorithms; convolutional and graph–polynomial parametrizations extend this to images and networks with per–frequency stability checks (Sec. 8.3). Multi–rate leaks and block–triangular stacks orchestrate time–scale tiling without losing global ESP because the block spectral radius reduces to the worst layer (Sec. 8.1). Finally, sector/IQC LMIs furnish coordinate–free stability certificates that tolerate slope variation, allowing one to dial memory close to the boundary while maintaining robustness (Sec. 4.2). Each of these structures integrates naturally with the probabilistic and identification pipelines of Sec. 6, encouraging stable, interpretable, and efficient ESN designs. 

24 

## **11 Conclusion** 

We have argued that Echo State Networks sit squarely inside the state–space modeling landscape. Written as a nonlinear SSM, a leaky ESN inherits ISS as the proper translation of the Echo State Property; linearizations and lifts expose poles, residues, and impulse kernels that determine memory and selectivity; and standard inference tools—Kalman smoothing, EM, and subspace identification—supply denoised states, principled hyperparameter updates, and spectral shaping. This unified view turns familiar ESN heuristics into certified design rules: leaks become time constants; spectral scaling becomes pole placement; kernel decay and oscillation become Bode–style dials; and stability moves from spectral–radius folklore to contraction certificates and LMIs. At the same time, the framework delineates its limits—non–Lipschitz regimes, heavy switching, non–normal transients, and long–delay tasks—and suggests remedies rooted in structure, margin, and probabilistic regularization. 

Beyond clarifying practice, the perspective opens concrete research directions: contraction–metric learning and data–driven certificates for ESNs; principled dictionary selection for lifts that balance closure with stability; structured reservoirs (normal, DPLR, banded) with fast kernels and end–to–end guarantees; multi–rate and convolutional ESNs for spatiotemporal domains; and probabilistic ESNs with calibrated uncertainty under drift. By bridging classical RC and modern SSM layers, the analysis provides a common language in which stability, identifiability, and efficiency are first–class citizens—an inviting basis for the next generation of reservoir designs. 

## **References** 

- [1] D. Angeli. A lyapunov approach to incremental stability properties. _IEEE Transactions on Automatic Control_ , 47(3):410–421, 2002. 

- [2] F. Bach. Breaking the curse of dimensionality with convex neural networks. _J. Mach. Learn. Res._ , 18(1):629–681, Jan. 2017. 

- [3] A. Barron. Universal approximation bounds for superpositions of a sigmoidal function. _IEEE Transactions on Information Theory_ , 39(3):930–945, 1993. 

- [4] C. M. Bishop. _Pattern Recognition and Machine Learning_ . Springer, 2006. 

- [5] S. Boyd and L. Chua. Fading memory and the problem of approximating nonlinear operators with volterra series. _IEEE Transactions on Circuits and Systems_ , 32(11):1150–1161, 1985. 

- [6] R. T. Q. Chen, Y. Rubanova, J. Bettencourt, and D. Duvenaud. Neural ordinary differential equations. In _Proceedings of the 32nd International Conference on Neural Information Processing Systems_ , NIPS’18, page 6572–6583, Red Hook, NY, USA, 2018. Curran Associates Inc. 

- [7] J. Dambre, D. Verstraeten, B. Schrauwen, and S. Massar. Information processing capacity of dynamical systems. _Scientific Reports_ , 2:514, 2012. 

- [8] G. F. Franklin, J. D. Powell, and A. Emami-Naeini. _Feedback Control of Dynamic Systems_ . Pearson, Boston, 7 edition, 2015. 

- [9] C. Gallicchio and A. Micheli. Deep echo state network (deepesn): A brief survey. _arXiv preprint arXiv:1712.04303_ , 2017. 

- [10] Z. Ghahramani and G. E. Hinton. Parameter estimation for linear dynamical systems. Technical Report CRG-TR-96-2, University of Toronto, 1996. 

- [11] L. Gonon, L. Grigoryeva, and J.-P. Ortega. Risk bounds for reservoir computing. _J. Mach. Learn. Res._ , 21(1), Jan. 2020. 

- [12] R. M. Gray. _Toeplitz and Circulant Matrices: A Review_ , volume 2(3) of _Foundations and Trends in Communications and Information Theory_ . Now Publishers, 2006. 

- [13] L. Grigoryeva and J.-P. Ortega. Echo state networks are universal. _Neural Networks_ , 108:495–508, 2018. 

- [14] A. Gu and T. Dao. Mamba: Linear-time sequence modeling with selective state spaces. _arXiv preprint arXiv:2312.00752_ , 2023. 

- ´ 

- [15] A. Gu, T. Dao, S. Ermon, A. Rudra, and C. Re. Hippo: recurrent memory with optimal polynomial 

25 

projections. In _Proceedings of the 34th International Conference on Neural Information Processing Systems_ , NIPS ’20, Red Hook, NY, USA, 2020. Curran Associates Inc. 

- [16] A. Gu, K. Goel, and C. Re.´ Efficiently modeling long sequences with structured state spaces. In _International Conference on Learning Representations (ICLR)_ , 2022. 

- [17] R. Hermann and A. Krener. Nonlinear controllability and observability. _IEEE Transactions on Automatic Control_ , 22(5):728–740, 1977. 

- [18] D. J. Higham. An algorithmic introduction to numerical simulation of stochastic differential equations. _SIAM Review_ , 43(3):525–546, 2001. 

- [19] H. Jaeger. The “echo state” approach to analysing and training recurrent neural networks. _GMD Technical Report_ , 148:1–47, 2001. 

- [20] Z.-P. Jiang and Y. Wang. Input-to-state stability for discrete-time nonlinear systems. _Automatica_ , 37(6):857–869, 2001. 

- [21] S. J. Julier and J. K. Uhlmann. A new extension of the kalman filter to nonlinear systems. In _Proceedings of AeroSense: 11th Int. Symp. on Aerospace/Defense Sensing, Simulation, and Controls_ . SPIE, 1997. 

- [22] T. Kailath, A. H. Sayed, and B. Hassibi. _Linear Estimation_ . Prentice Hall, Upper Saddle River, NJ, 2000. 

- [23] H. K. Khalil. _Nonlinear Systems_ . Prentice Hall, Upper Saddle River, NJ, 3 edition, 2002. 

- [24] P. Kidger, J. Morrill, J. Foster, and T. Lyons. Neural controlled differential equations for irregular time series. In _Proceedings of the 34th International Conference on Neural Information Processing Systems_ , NIPS ’20, Red Hook, NY, USA, 2020. Curran Associates Inc. 

- [25] P. E. Kloeden and E. Platen. _Numerical Solution of Stochastic Differential Equations_ , volume 23 of _Applications of Mathematics_ . Springer, Berlin, Heidelberg, 1992. 

- [26] K. Kowalski and W.-H. Steeb. _Nonlinear Dynamical Systems and Carleman Linearization_ . World Scientific, 1991. 

- [27] L. Ljung. _System identification (2nd ed.): theory for the user_ . Prentice Hall PTR, USA, 1999. 

- [28] M. Lukoseviˇ cius.ˇ A practical guide to applying echo state networks. In G. Montavon, G. B. Orr, and K.-R. Muller, editors,¨ _Neural Networks: Tricks of the Trade (2nd Ed.)_ , volume 7700 of _Lecture Notes in Computer Science_ , pages 659–686. Springer, 2012. 

- [29] W. Maass, T. Natschlager, and H. Markram.¨ Real-time computing without stable states: A new framework for neural computation based on perturbations. _Neural Computation_ , 14(11):2531–2560, 2002. 

- [30] G. Manjunath and H. Jaeger. Echo state property linked to an input: Exploring a fundamental characteristic of recurrent neural networks. _Neural Computation_ , 25(3):671–696, 2013. 

- [31] A. Megretski and A. Rantzer. System analysis via integral quadratic constraints. _IEEE Transactions on Automatic Control_ , 42(6):819–830, 1997. 

- [32] S. P. Meyn and R. L. Tweedie. _Markov Chains and Stochastic Stability_ . Cambridge University Press, Cambridge, 2 edition, 2009. 

- [33] I. Mezic. Spectral properties of dynamical systems, model reduction and decompositions.´ _Nonlinear Dynamics_ , 41(1–3):309–325, 2005. 

- [34] P. V. Overschee and B. D. Moor. _Subspace Identification for Linear Systems: Theory—Implementation—Applications_ . Kluwer Academic Publishers, Boston, 1996. 

- [35] A. Rahimi and B. Recht. Random features for large-scale kernel machines. In _Proceedings of the 21st International Conference on Neural Information Processing Systems_ , NIPS’07, page 1177–1184, Red Hook, NY, USA, 2007. Curran Associates Inc. 

- [36] A. Rahimi and B. Recht. Weighted sums of random kitchen sinks: replacing minimization with randomization in learning. In _Proceedings of the 22nd International Conference on Neural Information Processing Systems_ , NIPS’08, page 1313–1320, Red Hook, NY, USA, 2008. Curran Associates Inc. 

26 

- [37] H. E. Rauch, F. Tung, and C. T. Striebel. Maximum likelihood estimates of linear dynamic systems. _AIAA Journal_ , 3(8):1445–1450, 1965. 

- [38] C. W. Rowley, I. Mezic, S. Bagheri, P. Schlatter, and D. S. Henningson. Spectral analysis of nonlinear flows. _Journal of Fluid Mechanics_ , 641:115–127, 2009. 

- [39] S. S¨arkk¨a. _Bayesian Filtering and Smoothing_ . Cambridge University Press, Cambridge, 2013. 

- [40] R. H. Shumway and D. S. Stoffer. An approach to time series smoothing and forecasting using the em algorithm. _Journal of Time Series Analysis_ , 3(4):253–264, 1982. 

- [41] E. D. Sontag. Input to state stability: Basic concepts and results. In A. Astolfi and L. Praly, editors, _Nonlinear and Optimal Control Theory_ , volume 1932 of _Lecture Notes in Mathematics_ , pages 163–220. Springer, Berlin, Heidelberg, 2008. 

- [42] E. Wan and R. Van Der Merwe. The unscented kalman filter for nonlinear estimation. In _Proceedings of the IEEE 2000 Adaptive Systems for Signal Processing, Communications, and Control Symposium (Cat. No.00EX373)_ , pages 153–158, 2000. 

- [43] M. O. Williams, I. G. Kevrekidis, and C. W. Rowley. A data-driven approximation of the koopman operator: Extended dynamic mode decomposition. _Journal of Nonlinear Science_ , 25(6):1307–1346, 2015. 

27 

