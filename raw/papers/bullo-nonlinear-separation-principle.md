---
title: "A Nonlinear Separation Principle via Contraction Theory: Applications to Neural Networks, Control, and Learning"
arxiv: "2604.15238"
authors: ["Anand Gokhale", "Anton V. Proskurnikov", "Yu Kawano", "Francesco Bullo"]
year: 2026
source: paper
ingested: 2026-05-02
sha256: e40bcaac537d255550f5f70012b02b15f1f0cda55a6394fdaa2dbbb362cecf22
conversion: pymupdf4llm
---

## A Nonlinear Separation Principle via Contraction Theory: Applications to Neural Networks, Control, and Learning 

Anand Gokhale, Anton V. Proskurnikov, Yu Kawano, Francesco Bullo 

_**Abstract**_ **— This paper establishes a nonlinear separation principle based on contraction theory and derives sharp stability conditions for recurrent neural networks (RNNs). First, we introduce a nonlinear separation principle that guarantees global exponential stability for the interconnection of a contracting state-feedback controller and a contracting observer, alongside parametric extensions for robustness and equilibrium tracking. Second, we derive sharp linear matrix inequality (LMI) conditions that guarantee the contractivity of both firing rate and Hopfield neural network architectures. We establish structural relationships among these certificates—demonstrating that continuous-time models with monotone non-decreasing activations maximize the admissible weight space—and extend these stability guarantees to interconnected systems and Graph RNNs. Third, we combine our separation principle and LMI framework to solve the output reference tracking problem for RNN-modeled plants. We provide LMI synthesis methods for feedback controllers and observers, and rigorously design a low-gain integral controller to eliminate steady-state error. Finally, we derive an exact, unconstrained algebraic parameterization of our contraction LMIs to design highly expressive implicit neural networks, achieving competitive accuracy and parameter efficiency on standard image classification benchmarks.** 

## I. INTRODUCTION 

_a) Motivation:_ A central problem in control theory is the design of controllers which utilize sensor data to achieve certain objectives, such as stabilization, reference tracking, or optimal control based on some cost function. In linear systems, a separation principle enables the independent design of observers for state reconstruction, and full state feedback controllers. However, in nonlinear systems, a general counterpart remains elusive. Existing approaches typically rely on time-scale separation and high-gain observer constructions [2], [39], or are restricted to specific system classes such as Lur’e 

This work was in part supported by AFOSR project FA9550-221-0059 and by JST FOREST Program Grant Number JPMJFR222E. Anand Gokhale and Francesco Bullo are with the Center for Control, Dynamical Systems, and Computation, UC Santa Barbara, Santa Barbara, CA 93106 USA. email: _{_ anand ~~g~~ okhale,bullo _}_ @ucsb.edu. Anton V. Proskurnikov is with Department of Electronics and Telecommunications, Politecnico di Torino, Italy, 10129. email: anton.p.1982@ieee.org Yu Kawano is with the Graduate School of Advanced Science and Engineering, Hiroshima University, Higashi-Hiroshima 739-8527, Japan. email: ykawano@hiroshima-u.ac.jp Anand Gokhale thanks Alexander Davydov for fruitful discussions. 

systems and control-affine dynamics [19], [27], [35]. These methods often impose restrictive structural assumptions and may exhibit undesirable transient behavior, including peaking and sensitivity to noise and model uncertainty [16]. 

Here, we bridge this gap by establishing a nonlinear separation principle based on contraction theory [7]. A nonlinear system is said to be contracting if any two trajectories of the system approach each other at an exponential rate. While stronger than Lyapunov stability, contraction provides many properties that are desirable in control design. Of particular interest in this work are (i) the existence of a unique globally exponentially stable equilibrium, (ii) robustness via incremental ISS bounds to model errors, and (iii) robust equilibrium tracking errors in time varying environments [13]. 

In parallel, neural networks have become common means of modeling plants in a data-driven form. Recurrent Neural Networks (RNNs), in particular, have garnered significant interdisciplinary interest. They maintain low computational and memory requirements, making them well-suited for deployment in resource-constrained edge applications and realtime data-driven control [11], [12]. Continuous-time versions of RNNs naturally mirror biological neural circuits [33] and enable lower power consumption in analog circuit design [38]. Beyond traditional sequence processing, RNNs are also central to implicit deep learning: in architectures such as Deep Equilibrium Models (DEQs) [41], a cascade of layers is replaced by the steady-state equilibrium of an RNN. 

Motivated by the requirements of our separation principle, we seek to identify sharp, computationally tractable contraction conditions for RNNs. Such conditions not only expand the applicability of our separation principle, but are also of fundamental importance across the aforementioned domains to guarantee reliable, robust implementations. Recent works [11], [15] derive stability conditions for globally nonexpansive activation functions. However, widely used activation functions—such as ReLU, tanh, and sigmoid—are also monotone nondecreasing. Neglecting this additional structure yields overly conservative guarantees. Accordingly, we seek to identify the broadest class of RNNs that are guaranteed to contract under these practical nonlinearities. 

_b) Relevant Literature:_ Existing approaches to nonlinear separation principles have relied heavily on time-scaleseparation arguments and high-gain observers [2], [39]. These methods require the observer dynamics to be sufficiently 

faster than the plant dynamics, which may lead to undesirable transient peaks in the closed-loop trajectories and even finite escape times [16]. Under various structural assumptions on the system, separation principles have been provided for Lur’e systems [19], [35], control-affine systems with linear inputs [27], and SSMs [43]. Our formulation is most directly comparable to the foundational work of [40] which establishes exponential stability via a Lyapunov-based analysis. By adopting a contraction-theoretic framework, we offer an alternative approach that yields three distinct practical advantages. First, we establish global exponential stability with explicit convergence rates in terms of state and observer errors. Second, the incremental input-to-state stability (iISS) inherent to contracting systems provides native robustness against plant model errors. Finally, contraction yields robust equilibrium tracking bounds in time-varying environments [13]; this not only addresses exogenous disturbances but also enables seamless augmentation of the controller with external signals to achieve higher-level goals like reference tracking. 

Contraction of continuous-time neural networks in the _ℓ_ 1 and _ℓ∞_ norms is presented in [23], and the sharpest known conditions in the Euclidean norm are limited to the symmetric case [8]. Discrete-time robust RNNs are parameterized in [31]. 

Control design for discrete time RNNs has been previously studied in the context of asymptotic stability [28] and incremental ISS properties [11], without closed loop guarantees. Structurally, RNNs can be considered a subclass of Lur’etype systems, i.e., feedback interconnections of LTI blocks and static nonlinear maps. A distinguishing feature of RNNs is that their external inputs and outputs may enter and exit the system through a nonlinearity, unlike the affine inputs and linear outputs usually assumed in standard Lur’e-type models [1], [19]. To control RNNs in the general case (in particular, to design a reference tracking controller) we thus employ tools from singular perturbation theory [36]. 

Finally, in implicit deep learning, recent findings show that increasing the number of fixed-point iterations can significantly improve model expressivity [26], an effect enabled by the model’s local Lipschitz dependence on its input. Motivated by this insight, we design input-dependent DEQs that are locally Lipschitz by construction. 

_c) Contributions:_ This paper establishes a nonlinear separation principle based on contraction and derives sharp contractivity conditions for continuous-time and discrete-time firing-rate neural networks (FRNNs) and Hopfield neural networks (HNNs). We apply these results to controller design for RNN-modeled plants and to implicit-model architectures in machine learning. Our specific contributions are as follows. 

First, we introduce a _nonlinear separation principle_ (Theorem 3). This principle states that if a plant can be rendered contracting under full-state feedback and observed through a contracting observer, then the resulting output-feedback closed loop is globally exponentially stable, with explicit estimates of both the observer and state errors. Crucially, this guarantee holds even when the coupled closed-loop system is not itself globally contracting. Building on this framework, we extend the separation principle to parametric systems to establish rigorous robustness guarantees. We derive explicit error 

bounds for two practical scenarios: robustness against model mismatch when the controller and observer are designed using an estimated parameter, and equilibrium tracking performance when the system is subjected to time-varying parameters. 

Second, we derive certificates that guarantee the contraction of FRNNs and HNNs across standard classes of activation functions, summarized in Table I, demonstrate their tightness and establish structural relationships among these conditions, summarized by Theorem 14. Our analysis shows that the set of weight matrices guaranteeing contraction expands when passing from discrete-time to continuous-time models, and enlarges further when the activations are monotone nondecreasing rather than merely non-expansive, as is often assumed [15]. We also show that our certificates are optimal in the case of symmetric matrices. We establish a necessary condition for our certificate to hold for interconnected RNN systems (Theorem 20): such an interconnection may satisfy our contractivity certificate only if each subsystem is either individually satisfies our certificate or can be made to do so via static output feedback. Given that solving for static output feedback gain is an inherently nonconvex problem, this finding further highlights the utility of our separation principle. We also provide sufficient conditions for the global contractivity of Graph RNNs (Theorem 41), demonstrating that identical contracting subsystems preserve stability when coupled over undirected graphs, thereby enabling scalable, decentralized computation for graph neural networks. 

Third, we combine the proposed separation principle with our contraction certificates to address the reference-tracking problem for plants modeled by FRNNs. We provide LMI methods to synthesize full-state feedback controllers and state observers that satisfy the assumptions of our separation principle and also characterize necessary and sufficient conditions for the feasibility of these LMIs. Beyond exponential stability, we derive a synthesis procedure for a low-gain integral controller. Treating this integral controller as a time-varying parameter, we use the equilibrium tracking corollary of our separation principle to show the resulting closed-loop system achieves reference tracking with global exponential stability. 

Finally, we translate our sharp contractivity conditions into practical tools for machine learning. We derive an exact, unconstrained algebraic parameterization of the most expressive set of synaptic matrices characterized by our contraction LMIs (Theorem 35). Motivated by [26], we leverage our parameterization to design highly expressive, yet parameter efficient implicit neural networks with input-dependent weights. We demonstrate that the resulting architecture demonstrates competitive accuracy on the MNIST and CIFAR-10 benchmarks. 

Compared to the early version of this work [20], this extended journal version contains several novel contributions. First, we present a nonlinear separation principle within the framework of contraction theory. Second, we provide an extensive analysis of interconnections of RNNs with specialized results for Graph RNNs. Third, the results on reference tracking in [20] are substantially generalized; in particular, our analysis accommodates open-loop unstable plants, which are excluded by the conditions in [20]. Finally, we provide a formal analysis with an explicit local Lipschitz bound for our 

parameter efficient implicit neural networks. 

The rest of this paper is organized as follows: We introduce some preliminaries in Section II. We present our first main result, a nonlinear separation principle in Section III. Next, we provide an analysis of the conditions for contractivity of FRNNs and HNNs including results on interconnections of RNNs in Section IV. The applications of our theoretical efforts in control design are discussed in Section V and in machine learning are discussed in Section VI. 

## II. BACKGROUND 

_Notation:_ We let 0 _n×m_ be the _n × m_ all zero matrix, _In_ be the _n × n_ identity matrix. For symmetric _A_ , we write _A ≻_ 0 (respectively, _A ⪰_ 0) if _A_ is positive definite (respectively, semidefinite); _A ≻ B_ means _A − B ≻_ 0. The opposite relations _≺, ⪯_ are defined analogously. Given an _n × n_ matrix _P ≻_ 0, we let _∥· ∥P_ denote the _P_ -weighted Euclidean norm on R _[n]_ , defined by _∥x∥P_ := _√x[⊤] Px_ . Given a norm _∥· ∥X_ on R _[n]_ , and _∥· ∥Y_ on R _[m]_ , and a matrix _A ∈_ R _[m][×][n]_ , we denote the induced matrix norm _∥A∥X→Y_ = _∥Ax∥Y_ sup _∥x∥X_ =1 _∥x∥X_[.][Given][two][normed][spaces][(] _[X][,][ ∥· ∥][X]_[ )][and] ( _Y, ∥· ∥Y_ ), a map _F_ : _X →Y_ is Lipschitz with constant _ρ ≥_ 0, if for all _x,_ ˜ _x ∈X_ , _∥F_ ( _x_ ) _− F_ (˜ _x_ ) _∥Y ≤ ρ∥x − x_ ˜ _∥X_ . We denote by Lip( _F_ ) the (smallest) Lipschitz constant of _F_ . If a map depends on several variables, e.g., _x_ and _u_ , we write Lip _x_ ( _F_ ) for the Lipschitz constant with respect to the corresponding variable. We let diag( _A_ 1 _, A_ 2 _, · · · , An_ ) denote the block-diagonal matrix, where each _Ai_ is either a matrix or a scalar. For each matrix _A ∈_ R _[m][×][n]_ , let _A⊥_ denote any full-column-rank matrix satisfying Im _A⊥_ = Ker( _A_ ), that is, a matrix whose columns form a basis of the kernel of _A_ . Given a matrix _X ∈_ R _[n][×][m]_ , we use **vec** ( _X_ ) _∈_ R _[nm]_ for its columnwise vectorization. We denote the upper right Dini derivative of the function _f D_[+] 

## _A. Contraction theory_ 

Unless otherwise stated, all vector fields _F_ ( _t, x_ ) _∈_ R _[n]_ , where _t ∈_ R _≥_ 0 and _x ∈_ R _[n]_ , are supposed to be continuous in _t_ and locally Lipschitz in _x_ . We say that _F_ is strongly infinitesimally contracting with respect to _∥·∥P_ with rate _c >_ 0 if for all _x,_ ˜ _x ∈_ R _[n]_ and _t ≥_ 0 the inequality holds 

**==> picture [193 x 13] intentionally omitted <==**

˙ The associated dynamical system _x_ = _F_ ( _t, x_ ) is then said to be contracting in the same sense. If _x_ ( _t_ ) and _x_ ˜( _t_ ) are ˜ two trajectories of this system, then _∥x_ ( _t_ ) _− x_ ( _t_ ) _∥P ≤_ ˜ e _[−][c]_[(] _[t][−][t]_[0][)] _∥x_ ( _t_ 0) _−x_ ( _t_ 0) _∥P_ , for all _t ≥ t_ 0 _≥_ 0. A discrete-time system _x_[+] = _F_ ( _t, x_ ) is strongly contracting with constant _ρ_ if Lip _x_ ( _F_ ) _≤ ρ <_ 1. We refer to [7] for a recent review of contraction theory. A strongly contracting time-invariant system with _F_ ( _t, x_ ) = _F_ ( _x_ ) always admits a unique and globally exponentially stable equilibrium. 

## _B. Incremental multipliers_ 

For our analysis, we utilize incremental matrix multipliers constraints [17] paired with the S-lemma. 

_Definition 1 (Incremental multiplier matrix):_ Consider a function Ψ: R _[m] →_ R _[m]_ , and a symmetric matrix _M ∈_ R[(2] _[m]_[)] _[×]_[(2] _[m]_[)] . The function Ψ is said to admit the incremental multiplier matrix _M_ , if, for any _x,_ ˜ _x ∈_ R _[m]_ , 

**==> picture [213 x 27] intentionally omitted <==**

Henceforth, we primarily consider _diagonal_ nonlinearities Ψ : R _[m] →_ R _[m]_ , where the coordinate Ψ[ _i_ ] depends solely on _x_ [ _i_ ]. We call such a map slope-restricted in [ _k_ 1 _, k_ 2], where _−∞ < k_ 1 _≤ k_ 2 _<_ + _∞_ , if all coordinate functions satisfy 

**==> picture [253 x 54] intentionally omitted <==**

_Definition 2 (CONE and MONE nonlinearities):_ A diagonal nonlinearity Ψ: R _[n] →_ R _[n]_ is said to be: 

- (i) component-wise non-expansive (CONE) if it is sloperestricted in [ _−_ 1 _,_ 1], and 

- (ii) monotonically non-decreasing and non-expansive (MONE) if it is slope-restricted in [0 _,_ 1]. 

_Lemma 1 (Incremental multiplier matrices, see [7, E3.25]):_ If a diagonal nonlinearity Ψ: R _[m] →_ R _[m]_ is slope-restricted in [ _k_ 1 _, k_ 2], then for each diagonal positive definite _Q ∈_ R _[m][×][m]_ , Ψ admits the incremental multiplier matrix: 

**==> picture [241 x 71] intentionally omitted <==**

Consequently, the multiplier matrices 

are admitted by CONE and MONE nonlinearities respectively. 

## _C. Contractivity of Lur’e-type systems_ 

We consider both the continuous and discrete time Lur’etype systems. These are presented below, 

**==> picture [188 x 26] intentionally omitted <==**

Here _x ∈_ R _[n]_ , _A ∈_ R _[n][×][n]_ , _B ∈_ R _[n][×][m]_ , _H ∈_ R _[m][×][n]_ and Ψ: R _[m] →_ R _[m]_ is a nonlinearity. We start with a criteria for absolute contractivity of systems (2) and (3). The term “absolute” emphasizes that the property of contractivity is guaranteed uniformly over a class of nonlinearities, which, throughout this paper, is characterized by a given incremental multiplier _M_ . Note that if Ψ admits the incremental multiplier _M_ , then Ψ( _Hx_ ) admits the incremental multiplier 

**==> picture [226 x 28] intentionally omitted <==**

This criteria follows from the trivial direction of the S-lemma, using the matrix inequality characterizing the nonlinearity to imply the matrix inequality for contractivity. The continuoustime part of the next lemma is presented in [10, Theorem 4.2], we present an extension to discrete time. 

_Lemma 2 (Absolute contractivity of Lur’e systems):_ Let Ψ admit an incremental multiplier _M ∈_ R[2] _[m][×]_[2] _[m]_ , and let _MC_ be defined as in (4). Then, the system (2) is strongly infinitesimally contracting with respect to _∥· ∥P_ with rate _c >_ 0, where _P_ = _P[⊤] ≻_ 0 is a _n × n_ matrix, if 

**==> picture [215 x 25] intentionally omitted <==**

The system (3) is strongly contracting with respect to _∥· ∥P_ with a constant _ρ ∈_ [0 _,_ 1) if 

**==> picture [207 x 25] intentionally omitted <==**

_Proof:_ The proof is presented in Appendix II. 

## III. A NONLINEAR SEPARATION PRINCIPLE 

Certifying the stability of an observer-based feedback loop is a fundamental challenge in nonlinear control. While the classical separation principle elegantly resolves this for linear systems, no general analog exists in the nonlinear setting as dynamic interconnections of nonlinear systems do not inherently preserve stability properties. Existing nonlinear separation results typically rely on time-scale-separation arguments [2], [39] and high-gain observers whose well-known drawbacks are peaking and, in some cases, finite escape times [16]. 

Departing from high-gain methods, we adopt a contractiontheoretic framework. We seek to characterize the closed loop stability of the interconnection of an open loop unstable plant with an observer and a state-feedback controller. Standard interconnection theorems in contraction (e.g., [7, Theorem 3.23]) require that each subsystem is contracting, precluding their application to open-loop unstable plants. The node-wise contraction assumption is inherent to contraction criteria based on log-norm bounds of the network Jacobian, as implied by [7, Theorem 2.32]. The following theorem shows, that when an open-loop unstable plant is rendered contracting by a controller and observed through a contracting observer, the closed-loop system – although not contracting itself – still preserves a key property of contracting systems: the global exponential stability of the equilibrium. Denote for brevity 

**==> picture [222 x 38] intentionally omitted <==**

_Theorem 3 (Separation principle for contracting controllers and observers):_ Given maps _F_ : R _[n] ×_ R _[m] →_ R _[n]_ and _h_ : R _[n] →_ ˙ R _[p]_ , consider the control system _x_ = _F_ ( _x, u_ ) with output _y_ = _h_ ( _x_ ). Let _L_ : R _[n] ×_ R _[m] ×_ R _[p] →_ R _[n]_ be an observer, and let _K_ : R _[n] →_ R _[m]_ be a controller. Given norms _∥· ∥X_ and _∥· ∥O_ on R _[n]_ and a _∥· ∥U_ on R _[m]_ , assume the following conditions: 

˙ (A1) (Plant contraction by state feedback) The dynamics _x_ = _F_ ( _x, K_ ( _x_ )) is strongly infinitesimally contracting with rate _cK_ with respect to _∥· ∥X_ , whose equilibrium is _x[⋆]_ . 

- (A2) (Lipschitz controller and plant input) Let _K_ ( _x_ ) be _ℓK_ - Lipschitz in _x_ from _∥· ∥O_ to _∥· ∥U_ . Let _F_ ( _x, u_ ) be _ℓu_ -Lipschitz in _u_ , from _∥· ∥U_ to _∥· ∥X_ , uniformly in _x_ . 

- (A3) (Plant-observer matching) _L_ ( _x, u, h_ ( _x_ )) = _F_ ( _x, u_ ) for all _x_ and _u_ . 

- ˙ 

- (A4) (Observer contraction) The dynamics _z_ = _L_ ( _z, u, y_ ) is strongly infinitesimally contracting with respect to _∥·∥O_ with rate _cO_ , uniformly in inputs _u_ and _y_ . 

- Then the closed-loop system 

**==> picture [171 x 27] intentionally omitted <==**

has a globally exponentially stable equilibrium ( _x[⋆] , x[⋆]_ ), and its trajectories satisfy the following error bounds: 

**==> picture [211 x 42] intentionally omitted <==**

where _β_ ( _t_ ; _cK, cO_ ) is defined in (7). 

_Proof:_ Combining (A1) and (A3), we find that ( _x[⋆] , x[⋆]_ ) is an equilibrium of the closed-loop system (8), since _L_ ( _x[⋆] , K_ ( _x[⋆]_ ) _, h_ ( _x[⋆]_ )) = _F_ ( _x[⋆] , K_ ( _x[⋆]_ )) = 0 _n_ . To establish (9), we observe that _z_ ( _t_ ) = _x_ ( _t_ ) and _z_ ( _t_ ) = _ξ_ ( _t_ ) are both trajecto˙ ries of _z_ = _L_ ( _z, u, y_ ) corresponding to the same input signals _u_ ( _t_ ) = _K_ ( _ξ_ ( _t_ )) and _y_ ( _t_ ) = _h_ ( _x_ ( _t_ )). For _ξ_ ( _t_ ), this follows from (8b); for _x_ ( _t_ ), it is implied by (8a) and Assumption (A3), ˙ because _x_ = _F_ ( _x, u_ ) = _L_ ( _x, u, h_ ( _x_ )) = _L_ ( _x, u, y_ ). Due to the ˙ contractivity Assumption (A4), all solutions of _z_ = _L_ ( _z, u, y_ ) converge exponentially to one another, resulting in (9). Next, ˙ define the augmented plant dynamics _x_ = _F_ ( _x, K_ ( _x_ )) + _v_ = _F_ aug( _x, v_ ). By (A1), _F_ aug is strongly infinitesimally contracting with respect to _x_ , uniformly with respect to exogenous input _v_ , and 1-Lipschitz with respect to _v_ , uniformly in _x_ . Consider two trajectories of this system: one with initialization _x_ 0 and input _v_ 1 = _F_ ( _x, K_ ( _ξ_ )) _− F_ ( _x, K_ ( _x_ )), and the second the nominal stationary trajectory with initialization _x[⋆]_ and input _v_ 2 = 0. Using the incremental ISS property of contracting systems with Lipschitz inputs [7, Theorem 3.16] and Assumption (A2), we bound the distance between these trajectories: 

**==> picture [253 x 57] intentionally omitted <==**

**==> picture [201 x 27] intentionally omitted <==**

Applying the Comparison Lemma, we obtain 

**==> picture [227 x 41] intentionally omitted <==**

Recognizing the latter integral as _β_ ( _t_ ; _cK, cO_ ), we obtain (10). Since all norms on R _[n]_ are equivalent, ( _x_ ( _t_ ) _, ξ_ ( _t_ )) converges to ( _x[⋆] , x[⋆]_ ) for all initial conditions _x_ (0) _, ξ_ (0) _∈_ R _[n]_ . 

_Remark 4 (Convergence rate):_ The closed-loop convergence rate is determined by _β_ ( _t_ ; _cK, cO_ ), the slowest term on the right-hand side of (9), (10). This function decays as _O_ ( _e[−][ct]_ ) for _c < c∗_ = min( _cK, cO_ ), with _c_ = _c∗_ when for _cK_ = _cO_ . 

_Remark 5 (Extension to discrete time and sampled data systems):_ Analogous result holds for discrete-time systems, with parallel assumptions on contraction and Lipschitz bounds. 

_Remark 6 (Relationship to the linear separation principle):_ Our result seeks to be a nonlinear analog of the classic separation principle [22, Theorem 16.10]. Indeed, when _F_ ( _x, u_ ) = _Ax_ + _Bu_ , _h_ ( _x_ ) = _Cx_ , _K_ ( _ξ_ ) = _K_ 0 _ξ_ and the Luenberger observer has gain _L_ 0, the assumptions in Theorem 3 reduce to stabilizability of ( _A, B_ ) and detectability of ( _A, C_ ). The contraction rates _cK_ and _cO_ correspond to the spectral abscissa of _A − BK_ 0 and _A − L_ 0 _C_ , respectively. 

_Remark 7 (Relationship to iISS and iIOSS):_ Assumptions (A1) and (A2) together imply that the plant can be rendered incremental input-to-state stable (iISS) via full state feedback [7], while Assumptions (A3) and (A4) imply that the plant is incremental input/output-to-state stable (iIOSS) [37]. 

_Parametric extensions:_ Theorem 3 also extends to parameterized systems. If the plant, output map, observer, and controller maps further depend on _θ ∈_ Θ and Assumptions (A1)–(A4) hold uniformly over Θ, the system globally exponentially converges to the parameter-dependent fixed point ( _x[∗]_ ( _θ_ ) _, x[∗]_ ( _θ_ )), with the same bounds as in Theorem 3. 

Extending these results to parametric systems allows one to translate the robustness properties of contracting dynamics into robust stability of the closed-loop system with explicit convergence rate estimates. We formalize this in two corollaries. The first establishes error bounds when the controller and observer design relies on an imprecise parameter’s estimate. The second bounds the tracking error relative to the instantaneous equilibrium _x[⋆]_ ( _θ_ ( _t_ )) when the parameter varies in time. 

_Corollary 8 (Robustness to model error):_ Let Θ be a subset of a normed space with norm _∥·∥_ Θ. Given maps _F_ : R _[n] ×_ R _[m] ×_ Θ _→_ R _[n]_ and _h_ : R _[n] ×_ Θ _→_ R _[p]_ , consider the control system ˙ _x_ = _F_ ( _x, u, θ_ ) with output _y_ = _h_ ( _x, θ_ ). Let _L_ : R _[n] ×_ R _[m] ×_ R _[p] ×_ Θ _→_ R _[n]_ be an observer, and let _K_ : R _[n] ×_ Θ _→_ R _[m]_ be a controller. Let Assumptions (A1)–(A4) hold uniformly for _θ ∈_ Θ. Further, let _K_ be _ℓK,θ_ -Lipschitz in _θ_ , uniformly in _x_ , and let _L_ be _ℓL,θ_ -Lipschitz in _θ_ , uniformly in its other arguments. Consider the closed-loop system where the plant corresponds to the true parameter _θ_ , while the controller and the observer use the estimate _θ_[ˆ] : 

**==> picture [187 x 13] intentionally omitted <==**

**==> picture [186 x 13] intentionally omitted <==**

Then, the solutions satisfy the differential inequalities 

**==> picture [243 x 45] intentionally omitted <==**

_Proof:_ Consider the trajectory ( _x, ξ_ ) of the closed loop system (12); we suppress the time _t_ throughout. As in the proof of Theorem 3, _z_ = _x_ and _z_ = _ξ_ are, respectively, ˙ the solutions to the dynamical system _z_ = _L_ ( _z, u, y, ϑ_ ), corresponding to the same pair of signals _u_ = _K_ ( _ξ, θ_[ˆ] ), _y_ = _h_ ( _x, θ_ ) yet different parameters _ϑ_ = _θ_ and _ϑ_ = _θ_[ˆ] ; this entails (13) thanks to the iISS property of contracting systems [7, Theorem 3.16]. Similarly, _x_ and _x[⋆]_ ( _θ_ ) are two 

˙ solutions of the system _x_ = _F_ ( _x, K_ ( _x, θ_ ) _, θ_ )+ _v_ , corresponding to inputs _v_ 1 = _F_ ( _x, K_ ( _ξ, θ_[ˆ] ) _, θ_ ) _− F_ ( _x, K_ ( _x, θ_ ) _, θ_ ) and _v_ 2 = 0, respectively. As in the proof of Theorem 3, the iISS property implies (14). Compared to (11), the upper bound for _∥v_ 2 _− v_ 1 _∥X_ acquires an additional term _ℓK,θ∥θ − θ_[ˆ] _∥_ Θ, since the controller is parameter-dependent. 

By Assumption (A1) and [13, Lemma 16], the map _θ �→ x[⋆]_ ( _θ_ ) is Lipschitz, so _x[⋆]_ ( _θ_ ( _t_ )) is locally Lipschitz and almost everywhere differentiable for any smooth curve _θ_ : ( _a, b_ ) _→_ Θ thanks to [13, Lemma 17]. The differential iISS property [7, Theorem 3.16] extends to inputs defined almost everywhere, and can be turned into the integral form via the standard Gr¨onwall inequality; see [13, Theorem 2] for details. 

_Corollary 9 (Equilibrium tracking):_ Let Θ be a subset of a normed space with norm _∥· ∥_ Θ. Given maps _F_ : R _[n] ×_ R _[m] ×_ Θ _→_ R _[n]_ and _h_ : R _[n] ×_ Θ _→_ R _[p]_ , consider the control system ˙ _x_ = _F_ ( _x, u, θ_ ) with output _y_ = _h_ ( _x, θ_ ). Let _L_ : R _[n] ×_ R _[m] ×_ R _[p] ×_ Θ _→_ R _[n]_ be an observer and _K_ : R _[n] ×_ Θ _→_ R _[m]_ be a controller. Let Assumptions (A1)–(A4) hold uniformly for _θ ∈_ Θ. Let _K_ be _ℓK,θ_ -Lipschitz in _θ_ , uniformly in _x_ , and let _F_ be _ℓF,θ_ -Lipschitz in _θ_ , uniformly in its other arguments. Let the parameter _θ_ evolve along a continuously differentiable trajectory _θ_ ( _t_ ). Consider the closed loop system 

**==> picture [204 x 27] intentionally omitted <==**

Let _x[⋆]_ ( _θ_ ( _t_ )) be the time-varying equilibrium curve of the ideal nominal system. Then, for almost all _t_ , one has 

**==> picture [243 x 38] intentionally omitted <==**

_Proof:_ Consider the auxiliary dynamics, 

**==> picture [245 x 11] intentionally omitted <==**

where _T_ : R _[n] ×_ Θ _×_ R _[n] →_ R _[n]_ is Lipschitz in _w_ with constant 1 and Lipschitz in _x_ uniformly in _θ, w_ due to Assumption (A2). By (A1), the system (17) is strongly infinitesimally contracting uniformly in _θ_ and _w_ . Both _x_ ( _t_ ) and _x[⋆]_ ( _θ_ ( _t_ )) are solutions of (17), corresponding to inputs _w_ 1( _t_ ) = _F_ ( _x, K_ ( _ξ, θ_ ( _t_ )) _, θ_ ( _t_ )) _− F_ ( _x, K_ ( _x, θ_ ( _t_ )) _, θ_ ( _t_ )) and ˙ _w_ 2( _t_ ) = _x[⋆]_ ( _θ_ ( _t_ )) (defined for almost all _t_ ). Using the iISS property [7, Theorem 3.16] of contracting systems, 

**==> picture [84 x 12] intentionally omitted <==**

**==> picture [231 x 41] intentionally omitted <==**

In view of [13, Lemma 17], _∥x_ ˙ _[⋆]_ ( _θ_ ( _t_ )) _∥X_ does not exceed _c[−] K_[1][Lip] _θ_[(] _[F]_[(] _[x, K]_[(] _[x, θ]_[)] _[, θ]_[))] _[∥][θ]_[˙][(] _[t]_[)] _[∥]_[Θ][for][almost][all] _[t]_[,][where][the] Lipschitz constant does not exceed _ℓuℓK,θ_ + _ℓF,θ_ . Furthermore, _∥F_ ( _x, K_ ( _ξ, θ_ ( _t_ )) _, θ_ ( _t_ )) _− F_ ( _x, K_ ( _x, θ_ ( _t_ )) _, θ_ ( _t_ )) _∥X ≤ ℓuℓK∥ξ − x∥O_ due to (A2). These estimates entail the desired differential inequality (16) for almost all _t_ . 

_Remark 10 (Applications of time varying parameters):_ The extension of our bounds to time varying parameters is useful 

across many domains. Not only can it be used for modeling plants subject to time varying disturbances, but it is also useful for designing controllers which have additional useful characteristics. Later in this work, we utilize this result to design a low gain reference tracking controller in Theorem 34, other applications include the design of gradient-based controllers building on the work in [9], and the design of controllers with time-varying objectives. 

## IV. CONTRACTION OF FIRING RATE AND HOPFIELD NEURAL NETWORKS 

We are specifically motivated by the study of systems modeled by the firing rate neural network (FRNN), and the Hopfield neural network (HNN) in both continuous and discrete time. In this section, we present sharp contraction conditions and related properties for these dynamics. The continuous time FRNN and HNN dynamics are given below: 

**==> picture [232 x 26] intentionally omitted <==**

Here, the state _x ∈_ R _[n]_ , input _u ∈_ R _[m]_ , output _y ∈_ R _[p]_ , and the synaptic matrix _W ∈_ R _[n][×][n]_ , output matrices _C ∈_ R _[p][×][n]_ , _D ∈_ R _[p][×][m]_ . Ψ( _·_ ) is a diagonal, slope restricted nonlinearity. Equation (18) represents the FRNN dynamics, and equation (19) represents the HNN dynamics. The corresponding discrete time dynamics are 

**==> picture [214 x 27] intentionally omitted <==**

In the HNN models (19), (21), the state _x_ represents the internal membrane potentials of the neurons. Consequently, the measurable output _y_ is read out as a linear combination of their resulting firing rates, Ψ( _x_ ). 

_Remark 11:_ The state evolution in the FRNN and HNN dynamics (18)-(21) is structurally similar to a Lur’e model, which enables the use of Lemma 2 for the analysis of contractivity. However, in classical Lur’e systems, the input enters linearly, and the output is a linear function of the state. In FRNNs, the input appears _inside_ the nonlinearity, and in HNNs, the output is _a nonlinear function_ of the state. This nonlinear coupling precludes the direct application of results developed for standard Lur’e systems [19]. 

_Theorem 12 (Contractivity of FRNN and HNN):_ Consider the FRNN and HNN dynamics (18)-(21), for some constant _u_ . Let _W_ be the synaptic weight matrix and let the activation function Ψ( _·_ ) belong to either the CONE or MONE class. If the corresponding matrix inequality in Table I is satisfied by _P ≻_ 0, diagonal _Q ≻_ 0 and scalar _c >_ 0 or _ρ ∈_ [0 _,_ 1), then the system is infinitesimally strongly contracting with rate _c_ (in continuous time) or strongly contracting with factor _ρ_ (in discrete time) in the norm _∥· ∥P_ . 

_Proof:_ The proof of each of the eight cases follows from Lemma 1 and 2. For simplicity, we provide the proof for only the FRNN case in continuous time for MONE nonlinearities; the other cases follow similarly. Since (18) is a continuoustime Lur’e system of the form (2), with _A_ = _−In, B_ = _In_ and _H_ = _W_ . Per Lemma 1 a MONE nonlinearity admits 

the matrix multiplier _M_ = �0 _nQ×n −Q_ 2 _Q_ �, for some positive diagonal _Q_ . Substituting these equalities into (5) yields (25). 

We refer to each entry in Table I as a contraction certificate. 

## _A. Structural relationships of contractivity conditions_ 

First we show that the discrete-time CONE certificates for both network architectures are reducible to Schur diagonal stability, generalizing prior results on firing-rate models [11]. 

_Lemma 13 (Schur diagonal stability): W ∈_ R _[n][×][n]_ satisfies the discrete-time CONE certificates (22) and (26) if and only if _W_ is Schur diagonally stable. 

_Proof:_ Note that (22) _⇐⇒ P ⪯ Q_ and _W[⊤] QW ⪯ ρ_[2] _P_ . Similarly, (26) _⇐⇒ Q ⪯ ρ_[2] _P_ and _W[⊤] PW ⪯ Q_ . Hence, if (22) holds, then _W[⊤] QW − Q ⪯ ρ_[2] _P − Q ⪯_ ( _ρ_[2] _−_ 1) _Q ≺_ 0, so _W_ is diagonally Schur stable with diagonal matrix _Q_ . Analogously, (26) entails diagonal Schur stability, since that _W[⊤] QW − Q ⪯ ρ_[2] _W[⊤] PW − Q ≤_ ( _ρ_[2] _−_ 1) _Q ≺_ 0. 

Conversely, let _W[⊤] QW − Q ≺_ 0 for some diagonal matrix _Q ≻_ 0. Then _∃ ρ ∈_ (0 _,_ 1) such that _W[⊤] QW − ρ_[2] _Q ⪯_ 0. Then, _P_ = _Q_ satisfies (22) and _P_ = _ρ[−]_[2] _Q_ satisfies (26). 

Next, we establish the relationships between the various certificates in Table I. 

**==> picture [193 x 100] intentionally omitted <==**

**----- Start of picture text -----**<br>
Disc. CONE Cts. CONE<br>⊆<br>W ( ·,  DISC ,  CONE) W ( ·,  CTS ,  CONE)<br>Eq. (22), (26) Eq. (23), (27)<br>⊆ ⊆ ⊆<br>Disc. MONE Cts. MONE<br>W ( ·,  DISC ,  MONE) W ( ·,  CTS ,  MONE)<br>Eq. (24), (28) ⊆ Eq. (25), (29)<br>**----- End of picture text -----**<br>


Fig. 1. A summary of relationships for the contractivity conditions from Table I. The sets _**W**_ **(** _**·, ·, ·**_ **)** are described in Theorem 14. The discrete time CONE condition restricts the weight matrices the most, whereas the continuous time MONE condition enables maximum expressivity. 

_Theorem 14 (Reductions and duality of the certificates):_ Let _W_ ( _M, T , N_ ) denote the set of synaptic matrices _W_ satisfying the contraction certificates in Table I for model _M ∈{_ FR _,_ Hop _}_ , time domain _T ∈{_ CTS _,_ DISC _}_ , and nonlinearity class _N ∈{_ CONE _,_ MONE _}_ . The following hold: 

- (i) The set of synaptic matrices satisfying the condition for CONE nonlinearities is contained in the corresponding set for MONE nonlinearities. 

**==> picture [139 x 11] intentionally omitted <==**

- (ii) If a synaptic matrix _W_ satisfies a discrete-time condition with factor _ρ ∈_ [0 _,_ 1), then it also satisfies the corresponding continuous-time condition with rate _c_ = (1 _− ρ_[2] ) _/_ 2: 

**==> picture [123 x 11] intentionally omitted <==**

- (iii) A matrix _W_ satisfies the firing rate condition for some parameters _P ≻_ 0 and diagonal _Q ≻_ 0 if and only if 

TABLE I 

CONTRACTIVITY CONDITIONS FOR FIRING RATE AND HOPFIELD MODELS. SEE THEOREM 12 FOR DEFINITIONS OF SYMBOLS. THE NEURAL NETWORK WITH SYNAPTIC MATRIX _**W**_ CORRESPONDING TO EACH ENTRY IS CONTRACTING (WITH RATE _**c**_ OR FACTOR _**ρ**_ ) IF THERE EXIST _**P ≻**_ **0** AND DIAGONAL _**Q ≻**_ **0** SATISFYING THE CORRESPONDING LMI. 

|**Architecture**<br>**Nonlinearity**|**Discrete Time**|**Continuous Time**|
|---|---|---|
|**Firing Rate**<br>**CONE** [_−_1_,_1]<br><br>_−ρ_2_P_ +_W ⊤QW_<br>0_n×n_<br>0_n×n_<br>_P −Q_<br><br><br>_⪯_0<br>(22)<br><br>_−_2(1_−c_)_P_ +_W ⊤QW_<br>_P_<br>_P_<br>_−Q_<br><br><br>_⪯_0<br>(23)|||
|**MONE** [0_,_1]|<br>_−ρ_2_P_<br>_W ⊤Q_<br>_QW_<br>_P −_2_Q_<br><br><br>_⪯_0<br>(24)|<br>_−_2(1_−c_)_P_<br>_P_ +_W ⊤Q_<br>_P_ +_QW_<br>_−_2_Q_<br><br><br>_⪯_0<br>(25)|
|**Hopfeld**<br>**CONE** [_−_1_,_1]<br><br>_−ρ_2_P_ +_Q_<br>0_n×n_<br>0_n×n_<br>_W ⊤PW −Q_<br><br><br>_⪯_0<br>(26)<br><br>_−_2(1_−c_)_P_ +_Q_<br>_PW_<br>_W ⊤P_<br>_−Q_<br><br><br>_⪯_0<br>(27)|||
|**MONE** [0_,_1]|<br>_−ρ_2_P_<br>_Q_<br>_Q_<br>_W ⊤PW −_2_Q_<br><br><br>_⪯_0<br>(28)|<br>_−_2(1_−c_)_P_<br>_PW_ +_Q_<br>_W ⊤P_ +_Q_<br>_−_2_Q_<br><br><br>_⪯_0<br>(29)|



_W[⊤]_ satisfies the corresponding Hopfield LMI condition for some _P[′] ≻_ 0 and diagonal _Q[′] ≻_ 0. 

**==> picture [181 x 13] intentionally omitted <==**

_Proof:_ To prove (i), notice that the left-hand side of each CONE inequality is the sum of the left-hand side of the corresponding MONE inequality and a negative semidefinite matrix: _M_ 1 = _−W[⊤] QW W−[⊤] Q_ in the FRNN case, and � _QW Q_ � _− M_ 2 = _Q −Q_ in the HNN case. Therefore, the CONE � _Q Q_ � conditions imply the corresponding MONE conditions. 

To prove (ii), notice that each discrete-time LMI condition entails the corresponding continuous-time condition with _c_ = (1 _− ρ_[2] ) _/_ 2 _>_ 0 and 2(1 _− c_ ) = 1 + _ρ_[2] . For instance, in the firing-rate MONE case, the LMI (24) implies (25): 

**==> picture [230 x 52] intentionally omitted <==**

The proofs of (iii) differ in each of the four cases. In the continuous-time cases, under the substitution ( _P, Q, W_ ) _�→_ ( _P[−]_[1] _, Q[−]_[1] _, W[⊤]_ ), each firing-rate condition becomes the corresponding Hopfield condition with _W_ replaced by _W[⊤]_ . For the MONE condition (25), this is proven via the congruence transformation with matrix _T_ = diag( _P[−]_[1] _, Q[−]_[1] ) = _T[⊤] ≻_ 0: 

**==> picture [257 x 25] intentionally omitted <==**

is equivalent to (25) while also being identical to the LMI (29) with new variables _W[′]_ = _W[⊤]_ , _P[′]_ = _P[−]_[1] _≻_ 0, and _Q[′]_ = _Q[−]_[1] _≻_ 0. For the continuous-time CONE case, this is proven via the Schur complement: for _Q ≻_ 0, the firing-rate inequality (23) reduces to 

**==> picture [210 x 12] intentionally omitted <==**

**==> picture [253 x 30] intentionally omitted <==**

which is equivalent, by the Schur complement, to the inequality (27) with _W[′]_ = _W[⊤]_ , _P[′]_ = _P[−]_[1] , and _Q[′]_ = _Q[−]_[1] . 

A similar trick, based on the Schur complement, applies to the discrete-time MONE condition: upon rewriting it as 

**==> picture [198 x 12] intentionally omitted <==**

and pre- and post-multiplying by _Q[−]_[1] , one obtains 

**==> picture [215 x 12] intentionally omitted <==**

which is equivalent, by the Schur complement, to the Hopfield matrix inequality (28) with parameters _W[′]_ = _W[⊤]_ , _P[′]_ = _ρ[−]_[2] _P[−]_[1] , and _Q[′]_ = _Q[−]_[1] . Finally, for the discrete time CONE case, both conditions are reducible to Schur diagonal stability as shown in Lemma 13. We show that _W[⊤] QW ⪯ ρ_[2] _Q_ if and only if _WQ[−]_[1] _W[⊤] ⪯ ρ_[2] _Q[−]_[1] . The former inequality can be written as _X[⊤] X ≤ I_ , where _X_ = _ρ[−]_[1] _Q_[1] _[/]_[2] _WQ[−]_[1] _[/]_[2] , and the latter as _XX[⊤] ≤ I_ . The equivalence follows since _X_ and _X[⊤]_ have same singular values. A more direct proof can be obtained by applying Schur complement to the LMI _I X_ � _X[⊤] I_ � _⪰_ 0 with respect to each diagonal block. _Corollary 15 (Equivalence to LMI):_ For a fixed _c >_ 0 or _ρ ∈_ [0 _,_ 1), each certificate in Table I is equivalent to a Linear Matrix Inequality (LMI) under a bijective change of variables. Consequently, for fixed rate, the set of admissible triplets ( _W, P, Q_ ) is characterized by a convex feasibility problem. 

_Proof:_ By the duality between FRNNs and HNNs (Theorem 14), it suffices to establish the LMI equivalence for one architecture; the other follows via the transformation ( _P, Q, W_ ) _�→_ ( _P[−]_[1] _, Q[−]_[1] _, W[⊤]_ ). For continuous-time Hopfield networks, the substitution _S_ = _W[⊤] P_ renders both the CONE and MONE conditions linear in ( _P, Q, S_ ). In discrete time, the firing-rate MONE condition is linear in ( _P, Q, S_ ) under _S_ = _QW_ . Finally, the discrete-time CONE conditions reduce to Schur diagonal stability (Lemma 13), which admits the LMI reformulation � _ρ_[2] _SQ SQ[⊤]_ � _⪰_ 0 via the Schur complement with _S_ = _QW_ . 

_B. Necessary vs. sufficient conditions for contractivity_ 

Theorem 14 implies that continuous-time FRNNs and HNNs with MONE nonlinearities admit the largest set of synaptic matrices. Next, we seek to characterize the sharpness of these certificates. We focus on the FRNN case, as HNN results hold via duality. First we relate this certificate to the Lyapunov Diagonal Stability (LDS) of _W −In_ . 

_Proposition 16 (Relationship with Lyapunov Diagonal Stability):_ Let _W ∈_ R _[n][×][n]_ be a synaptic matrix for the firing rate neural network (18). The following hold 

- (i) If _W_ satisfies (25) for _P ≻_ 0, diagonal _Q ≻_ 0 and _c >_ 0, then _W − In_ is _Q−_ LDS. 

- (ii) The converse is not true; _W − In_ being LDS is not sufficient to guarantee contraction in any fixed norm. 

_Proof:_ To prove (i), we left and right multiply the matrix inequality (25) by the matrix [ _In, In_ ] _∈_ R _[n][×]_[2] _[n]_ obtaining, 

**==> picture [241 x 27] intentionally omitted <==**

This proves that the _W − In_ is _Q−_ LDS. 

The claim in (ii) is established by the following counterexample[1] . Consider a skew-synaptic weight matrix _W_ = 0 4 _−_ 4 0 . Since _W_ + _W[⊤]_ = 0 _≺_ 2 _I_ , _W − In_ is LDS. � � For contraction in the norm _∥· ∥P_ , the matrix _M_ ( _D_ ) = 2 _P −PDW −W[⊤] DP_ must be positive definite for all diagonal _D ∈_ [0 _, I_ ], e.g., see [8]. Testing the vertices _D_ 1 = diag(1 _,_ 0) and _D_ 2 = diag(0 _,_ 1), 

**==> picture [211 x 52] intentionally omitted <==**

Since the determinants of these matrices need to be positive, 

_• p_ 11 _p_ 22 _> p_[2] 12[+ 4] _[p]_[2] 11[=] _[⇒][p]_[22] _[>]_[ 4] _[p]_[11][.] _• p_ 11 _p_ 22 _> p_[2] 12[+ 4] _[p]_[2] 22[=] _[⇒][p]_[11] _[>]_[ 4] _[p]_[22][.] These conditions contradict to the condition _P ≻_ 0. 

The next proposition shows that the FRNN MONE certificate is tight for symmetric matrices, recovering the optimal contraction rate and contractivity characterizations from [8]. Note that, in the case of Ψ( _x_ ) = _x_ , the FRNN and HNN linear dynamics can only be contracting (i.e., stable) when _W − I_ is Hurwitz, that is, the spectral abscissa of _W_ is less than 1. For _W_ = _W[⊤]_ , this condition is also sufficient. 

_Proposition 17 (Log-optimal characterization for symmetric weights):_ Let _W_ = _W[⊤] ∈_ R _[n][×][n]_ with spectral abscissa _α_ . 

- (i) For _α ≤_ 0, the FRNN MONE certificate (25) holds for _P_ = _−W_ , _Q_ = _In_ , and _c_ = 1. 

- (ii) For 0 _< α <_ 1, there exists _P ≻_ 0 such that _W_ = _P_[1] _[/]_[2] _−_ (4 _α_ ) _[−]_[1] _P_ , and the FRNN MONE certificate (25) holds for this _P_ , _Q_ = 4 _αIn_ , and _c_ = 1 _− α_ ( _W_ ). 

- _Proof:_ Consider the Schur complement of (25). 

**==> picture [239 x 21] intentionally omitted <==**

> 1This counterexample can be found in the literature, e.g., [25, Theorem 7], but we include a proof for completeness. 

If _α <_ 0, this inequality is satisfied by _P_ = _−W ≻_ 0, _Q_ = _In_ and _c_ = 1 into (38). If _α ∈_ (0 _,_ 1), it can be shown [8, Lemma 10] that the equation _W_ = _P_[1] _[/]_[2] _−_ 41 _α[P]_[has a solution] _[ P][≻]_[0][.] Choosing _Q_ = 4 _αI_ , and substituting _W_ and _Q_ into the LHS of (38) and _c_ = 1 _− a_ yields _−_ 2(1 _− c_ ) _P_ + 2 _αP_ = 0. 

_Remark 18:_ The equivalent results to Proposition 17 for HNNs hold via duality (Theorem 14). 

Having shown the sharpness of the FRNN and HNN MONE certificates, and their optimality for the class of symmetric matrices, we define the notion of S-contraction corresponding to these certificates. 

_Definition 3 (S-contraction):_ An FRNN (or HNN) with a MONE nonlinearity is said to be _S-contracting_ if its synaptic matrix satisfies the FRNN(or HNN) MONE contraction certificate (25) (or (29)). 

_Remark 19 (Sharpness and Complexity):_ The term _Scontraction_ signifies the use of the _S-procedure_ to incorporate incremental multiplier matrices. This characterization is: 

- (i) _Polynomial-time verifiable:_ While certifying absolute contractivity for neural networks involves checking 2 _[n]_ matrix inequalities [8], S-contraction is a convex feasibility problem solvable in polynomial time via LMIs. 

- (ii) _Sharp:_ The conditions are _sharp_ as they constitute the tightest constraints obtainable via the S-lemma using incremental multipliers for absolute contractivity. 

## _C. Interconnections of RNNs_ 

The study of interconnected recurrent neural networks (RNNs) is motivated by both biological [25] and engineering [11] contexts. We first establish a necessary condition for a network of interconnected RNNs to be S-contracting. 

_Theorem 20 (Necessary conditions for S-contraction of interconnections of FRNNs):_ Consider an interconnection of _N_ FRNN subsystems (18) with MONE nonlinearities where the _i_ th subsystem is given by 

**==> picture [190 x 25] intentionally omitted <==**

where _xi ∈_ R _[n][i] , ui ∈_ R _[m][i] , yi ∈_ R _[k][i]_ . Consider an interconnection of these systems of the form _ui_ =[�] _[N] j_ =1 _[A][ij][y][j]_[.][Let] **A** be the block matrix whose ( _i, j_ )th block is _Aij_ . Further, let _W_ = diag( _W_ 1 _, . . . , WN_ ), _B_ = diag( _B_ 1 _, . . . , BN_ ), _C_ = diag( _C_ 1 _, . . . , CN_ ), and _D_ = diag( _D_ 1 _, . . . , DN_ ). 

If the interconnection is well-posed, meaning _Im − N_ **A** _D_ is invertible (where _m_ = � _i_ =1 _[m][i]_[),] then, for 

- ∆= ( _Im −_ **A** _D_ ) _[−]_[1] **A** , 

- (i) The interconnected system is an FRNN with synaptic matrix _Wnet_ = _W_ + _B_ ∆ _C_ . 

- (ii) Further, if the interconnected FRNN is S-contracting, then for each _i_ , the FRNN with the synaptic matrix _Wi_ + _Bi_ ∆ _iiCi_ is S-contracting, where ∆ _ii_ is the _i_ th principal diagonal block of ∆. 

_Proof:_ Let _x_ = [ _x[⊤]_ 1 _[, . . . , x][⊤] N_[]] _[⊤]_[,] _[u]_[=][[] _[u][⊤]_ 1 _[, . . . , u][⊤] N_[]] _[⊤]_[,][and] _y_ = [ _y_ 1 _[⊤][, . . . , y] N[⊤]_[]] _[⊤]_[denote][the][stacked][network][vectors.][The] decoupled open-loop dynamics may be written as 

**==> picture [178 x 25] intentionally omitted <==**

where Ψ( _z_ ) = [Ψ1( _z_ 1) _[⊤] , . . . ,_ Ψ _N_ ( _zN_ ) _[⊤]_ ] _[⊤]_ . The interconnection imposes the relationship _u_ = **A** _y_ . When _Im −_ **A** _D_ is invertible, substituting the output from (42) yields 

**==> picture [179 x 12] intentionally omitted <==**

Substituting this into (41) and denoting ∆= ( _Im −_ **A** _D_ ) _[−]_[1] **A** , the system turns into the FRNN with synaptic matrix _Wnet_ : 

**==> picture [189 x 11] intentionally omitted <==**

which proves (i). Now, if the system (44) is S-contracting, 

**==> picture [205 x 25] intentionally omitted <==**

Any principal submatrix of a negative semidefinite matrix must also be negative semidefinite. Extracting the _i_ th diagonal block from each of the four entries results in the inequality 

**==> picture [228 x 25] intentionally omitted <==**

Note that ( _Wnet_ ) _ii_ = _Wi_ + _Bi_ ∆ _iiCi_ , where ∆ _ii_ is the _i_ th diagonal block of ∆. Therefore, an FRNN with synaptic matrix _Wi_ + _Bi_ ∆ _iiCi_ is S-contracting, with _P_ = _Pii, Q_ = _Qi_ . 

_Remark 21:_ Theorem 20 shows that an interconnection of FRNNs can be S-contracting only if each FRNN is S- contracting either independently or via static output feedback. When there is no feed-through ( _Di_ = 0) and no self-loops ( _Aii_ = 0), output feedback is unavailable, so each FRNN must be independently S-contracting. Parallel results hold for the interconnected HNNs (19), as well as in discrete time. 

_Remark 22:_ Interconnections of RNNs are particularly useful in control design [11]. Theorem 20 shows that a static output interconnection involving open-loop unstable subsystems can only be contracting if every such subsystem is stabilized by static output feedback, which is an inherently nonconvex problem. This highlights the practical utility of our separation principle (Theorem 3), which relies on a dynamic observerbased controller that can be designed via LMI feasibility. 

_Homogeneous networks:_ Next, we discuss the special case where the subsystems are identical. Such interconnections arise in graph neural network architectures, such as implicit graph neural networks [21], continuous graph neural ODEs [42], and single-layer graph convolutional ODEs [29]. Consider the Graph FRNN: 

**==> picture [189 x 12] intentionally omitted <==**

Here _X ∈_ R _[m][×][n]_ represents the state matrix, and _U ∈_ R _[p][×][n]_ represents the input node features, _W ∈_ R _[m][×][m]_ is the synaptic matrix of each FRNN, _B ∈_ R _[m][×][p]_ is the input matrix, and _A ∈_ R _[n][×][n]_ is the adjacency matrix. Although the graph FRNN (47) is expressed in matrix form, its vectorized form is structurally identical to a standard FRNN with the synaptic matrix _A[⊤] ⊗ W_ : introducing the state _X_[˜] = **vec** ( _X_ ), one has 

**==> picture [214 x 15] intentionally omitted <==**

Next, we study the S-contraction of Graph FRNNs. 

_Theorem 23 (Contraction of Graph FRNN):_ Consider the dynamics (48) with a MONE nonlinearity Ψ. If 

(A1) The adjacency matrix satisfies _A_ = _A[⊤]_ . (A2) The eigenvalues of _A_ lie in [0 _,_ 1]. 

(A3) _W_ satisfies matrix inequality (25) for _P ≻_ 0, diagonal _Q ≻_ 0, rate _c >_ 0, which satisfy _PQ[−]_[1] _P ⪯_ 4(1 _− c_ ) _P_ . Then, the dynamics (48) are strongly infinitesimally contracting with rate _c_ in the norm _∥· ∥In ⊗ P_ . 

_Proof:_ We show that the synaptic matrix _A[⊤] ⊗ W_ from (48) satisfies (25) with _P_ and _Q_ replaced by _In ⊗ P_ and _In ⊗ Q_ . Substituting these matrices into (25) and applying the mixed product property (see Lemma 40 in Appendix) yields _−_ 2(1 _− c_ ) _In ⊗ P In ⊗ P_ + _A ⊗ W[⊤] Q_ � _In ⊗ P_ + _A ⊗ QW −_ 2 _In ⊗ Q_ � _⪯_ 0 _,_ (49) 

where we have used _A_ = _A[⊤]_ . Since _A_ is symmetric, it admits the eigendecomposition _A_ = _U_ Λ _U[⊤]_ , where each entry of Λ (being an eigenvalue of _A_ ) lies in [0 _,_ 1]. Applying the unitary transform _T_ = diag( _U ⊗ In, U ⊗ In_ ) to (93) and utilizing _U[⊤] U_ = _UU[⊤]_ = _In_ yields 

**==> picture [207 x 24] intentionally omitted <==**

It can be shown (e.g., by applying the Schur complement and examining the resulting block-diagonal matrix) that, since Λ is diagonal, the condition (94) splits into _n_ independent LMIs 

**==> picture [237 x 25] intentionally omitted <==**

where _λi_ is the _i_ th diagonal element of Λ. Since this condition is linear in _λi_ , and _λi ∈_ [0 _,_ 1], it suffices to verify it at _λ_ = 0 and _λ_ = 1. At _λ_ = 1, this condition is identical to (25). At _λ_ = 0, the condition is implied by (A3), since 

**==> picture [231 x 25] intentionally omitted <==**

This finishes the proof. 

_Remark 24 (Computational Tractability for Large Graphs):_ In applications such as implicit neural networks, only the fixed point of the FRNN dynamics is of interest, not the trajectory. In small-scale systems, alternative methods such as Peaceman-Rachford operator splitting can be used to find this fixed point, and accommodate a larger set of synaptic matrices than S-contraction requires. However, this approach scales poorly, particularly in the context of graph neural networks [4]. Peaceman-Rachford requires to invert the matrix ( _Inm − αA[⊤] ⊗ W_ ), for some constant _α ∈_ R. This operation is computationally expensive ( _O_ ( _m_[3] _n_[3] ) in time, _O_ ( _m_[2] _n_[2] ) in memory), destroys the natural sparse structure of the adjacency matrix, and precludes decentralized execution. While the system (47) restricts the set of synaptic matrices, it is computationally efficient and permits a distributed implementation. 

_Remark 25 (Assumptions on Graph Structure):_ We assume that the underlying graph is undirected. Restricting the eigenvalues to be in [0 _,_ 1] is common in Graph RNNs [24]. Given an arbitrary adjacency matrix _A_[˜] , one can introduce the normalized adjacency matrix _A_ = 12[( ˜] _[D][−]_[1] _[/]_[2] _[A]_[˜][ ˜] _[D][−]_[1] _[/]_[2][+] _[I][n]_[)][,] where _D_[˜] is the diagonal weight degree matrix for _A_[˜] . 

Extending our contraction guarantees to directed graphs remains an open problem. 

_Remark 26 (Comparisons to Small gain based results):_ General converse results for heterogeneous networks may be obtained via small gain theorems for contractivity [7, Theorem 3.23] and exponential stability [18]. Typically, these results treat other systems as disturbances, and as such, yield convergence rates worse than the rates of each subsystem, which we are able to maintain in the homogeneous S-contracting case. 

An extension of our results to diagonally symmetrizable graphs is presented in Appendix IV 

## V. APPLICATIONS TO CONTROL DESIGN WITH RNNS 

In this section, we combine the separation principle (Theorem 3) with our S-contraction certificates (Theorem 12) to design a reference tracking controller for a plant modeled by an RNN. We propose an LMI-based method for designing a full-state feedback controller that renders the plant contracting, alongside a contracting observer; similar contraction conditions for discrete-time models appear in [11], [28]. We also establish necessary and sufficient feasibility conditions for the derived LMIs, drawing direct parallels to classical linear stabilizability and detectability. In accordance with Theorem 3, the interconnection of this observer and controller is exponentially stable. Finally, in order to achieve reference tracking, we design a low-gain integral controller motivated by [36] and relying on Corollary 9. Throughout the section, the continuous-time FRNN model (18) with MONE nonlinearities is considered; the analysis extends to all models from Table I. 

## _A. Contraction via full state feedback_ 

We begin with an LMI-based design for a full-state feedback controller. 

_Proposition 27 (Contraction via state feedback controller):_ Consider a plant described by an FRNN (18) with a MONE nonlinearity, with access to the full state, i.e. _C_ = _In_ . For the control law _u_ = _Kx_ , for _K ∈_ R _[m][×][n]_ , the following hold: 

- (i) The closed-loop system is an FRNN with state _x_ , and the closed-loop weight matrix is _Wcl_ = _W_ + _BK_ . 

- (ii) The closed loop system is S-contracting for a given contraction rate _c ∈_ (0 _,_ 1] if and only if there exist a positive definite _X ∈_ R _[n][×][n]_ , a positive diagonal matrix _D_ , and a matrix _Y ∈_ R _[m][×][n]_ satisfying the LMI: 

**==> picture [225 x 25] intentionally omitted <==**

If (52) holds, the state feedback gain guaranteeing contraction is given by _K_ = _Y X[−]_[1] . 

_Proof:_ The proof is presented in Appendix III-A _Corollary 28 (Necessity of linear stabilizability):_ An FRNN with synaptic matrix _W_ , and input matrix _B_ can be rendered S-contracting via full-state feedback with some _c >_ 0 only if ( _W − In, B_ ) is stabilizable. 

_Proof:_ Pre- and post-multiplying (52) by � _In In_ � and its transpose, respectively, and simplifying yields 

**==> picture [207 x 11] intentionally omitted <==**

**==> picture [226 x 28] intentionally omitted <==**

which is the condition for stabilizability of ( _W − In, B_ ). 

Similar to the problem of control design for linear systems, we may also apply the projection lemma [6, Section 2.6.2]. 

_Corollary 29 (Necessary and sufficient conditions for S– contraction via full state feedback):_ Let Π _B_ denote a matrix whose columns form a basis for the null space of _B[⊤]_ , such that _B[⊤]_ Π _B_ = 0. An FRNN with synaptic matrix _W_ , and input matrix _B_ can be rendered S-contracting via full state feedback with some _c >_ 0 if and only if the following inequality holds 

**==> picture [246 x 25] intentionally omitted <==**

**==> picture [253 x 69] intentionally omitted <==**

An application of the Projection Lemma (Lemma 38) states that the inequality (54) holds if and only if _U⊥[⊤][M][U][⊥][≺]_[0] and _V⊥[⊤][M][V][⊥][≺]_[0][. The second condition always holds, as the] (2,2) block of _M_ is negative definite. The first condition is identical to inequality (53). 

## _B. Contracting observer design_ 

We now consider the dual problem of state estimation. We seek to estimate _x ∈_ R _[n]_ , given the output _y ∈_ R _[p]_ , and we propose the following observer architecture: 

**==> picture [253 x 44] intentionally omitted <==**

_Proposition 30 (S-Contracting observer design):_ Consider the observer (55) with exogenous inputs _u_ and _y_ . 

- (i) The observer is an FRNN with state _x_ ˆ, and a weight matrix _Wobs_ = _W − LC_ . 

- (ii) The observer is S-contracting for a given contraction rate _c ∈_ (0 _,_ 1] if and only if there exist _P ≻_ 0, diagonal _Q ≻_ 0 and a matrix _M_ such that, 

**==> picture [233 x 54] intentionally omitted <==**

_Proof:_ The proof is presented in Appendix III-B _Corollary 31 (Necessity of linear detectability):_ An FRNN with synaptic matrix _W_ , and output matrix _C_ can be observed by an S-contracting FRNN only if the pair ( _W − In, C_ ) is detectable. 

_Proof:_ Pre- and post-multiplying (56) by � _In In_ � and its transpose, respectively, yields 

**==> picture [207 x 12] intentionally omitted <==**

Substituting _M_ = _QL_ and using the fact that _−_ 2 _cP ≺_ 0, 

**==> picture [189 x 12] intentionally omitted <==**

which is the standard continuous-time Lyapunov condition for the pair ( _W − In, C_ ) to be detectable. 

_Corollary 32 (Necessary and sufficient conditions for S– contracting observer design):_ Let Π _C_ denote a matrix whose columns form a basis for the null space of _C_ , such that _C_ Π _C_ = 0. An FRNN with synaptic matrix _W_ , and output matrix _C_ can be observed by an S-contracting FRNN if and only if the following strict inequality holds for some _c >_ 0: 

**==> picture [244 x 25] intentionally omitted <==**

_Proof:_ Let _U_ = � _C_ 0 _p×n_ �. Let _V_ = �0 _n×n In_ �. Let _Y_ = _−M[⊤]_ . By continuity, the LMI (56) holds strictly for some _c >_ 0 if and only if 

**==> picture [243 x 39] intentionally omitted <==**

An application of the Projection Lemma 38 states that the inequality (58) holds if and only if _U⊥[⊤][M][U][⊥][≺]_[0][and] _V⊥[⊤][M][V][⊥][≺]_[0][.][The][second][condition][always][holds,][as][the] (1,1) block of _M_ is negative definite. The first condition is Π _C_ 0 identical to inequality (57) since _U⊥_ = . � 0 _In_ � 

## _C. Low gain Integral control_ 

Having designed a controller in Proposition 27, and an observer in Proposition 30, which satisfies the assumptions in our separation principle in Theorem 3, we now proceed to perform reference tracking via an integral controller and a singular perturbation argument. As a first step, we identify sufficient conditions for the contraction of the reduced dynamics. 

_Lemma 33 (Contractivity of the reduced dynamics):_ Let a map _x[⋆]_ : R _[m] →_ R _[n]_ exist that satisfies the equation 

**==> picture [183 x 11] intentionally omitted <==**

where _W ∈_ R _[n][×][n] , B ∈_ R _[n][×][m]_ . Let _A_ = _In − W, C ∈_ R _[p][×][n]_ , and _Q ∈_ R _[n][×][n]_ be a diagonal positive matrix. Assume: (A1) Ψ is slope-restricted in [ _δ,_ 1], for _δ >_ 0. 

(A2) There exists _u[⋆]_ such that _r_ = _Cx[⋆]_ ( _u[⋆]_ ). 

- (A3) With the shorthands _Z_ = _B[⊤] Q_ ((1 _− δ_ ) _In_ + 2 _δA_ ) and _R_ = 2 _δA[⊤] QA_ + (1 _− δ_ )( _QA_ + _A[⊤] Q_ ), there exist matrices _Y_ and _P ≻_ 0 such that 

**==> picture [191 x 25] intentionally omitted <==**

Then, with _K_ = _ε[−]_[1] _P[−]_[1] _Y_ , the dynamical system 

**==> picture [172 x 11] intentionally omitted <==**

is strongly infinitesimally contracting with rate _cr_ in _∥· ∥P_ . 

_Proof:_ The dynamics (61) form a Lur’e system, where the nonlinearity is given by _x[⋆]_ ( _u_ ) and admits an incremental multiplier (Lemma 39). Applying Lemma 2 to (61), one obtains the following LMI condition for contractivity in the norm _∥· ∥P_ : 

**==> picture [247 x 37] intentionally omitted <==**

where _M_ is the matrix multiplier for the nonlinearity Ψ. Using _−_ 2 _δQ_ (1 + _δ_ ) _Q_ Lemma 1, we may substitute _M_ as �(1 + _δ_ ) _Q −_ 2 _Q_ �. The second term in (62) resolves to _−_ 2 _δB⊤QB −_ 2 _δB[⊤] QW_ + (1 + _δ_ ) _B[⊤] Q_ � _∗_ (1 + _δ_ )( _W[⊤] Q_ + _QW_ ) _−_ 2 _Q −_ 2 _δW[⊤] QW_ � 

Now, let us set _A_ = _In − W_ . First, note that 

**==> picture [217 x 28] intentionally omitted <==**

Now, we may rewrite (62) using these simplifications. 

**==> picture [209 x 25] intentionally omitted <==**

Reparameterizing _Y_ = _εPK_ we get the condition (60). 

Finally, we may now design a low gain integral controller. _Theorem 34 (Reference Tracking):_ Consider the FRNN plant (18) with synaptic matrix _W ∈_ R _[n][×][n]_ , input matrix _B ∈_ R _[n][×][m]_ , output matrix _C ∈_ R _[p][×][n]_ , and reference signal _r ∈_ R _[p]_ . Suppose the following conditions hold. 

- (A1) (Plant contraction by state-feedback) There exists a matrix _Kf ∈_ R _[m][×][n]_ such that the FRNN with synaptic matrix _W_ + _BKf_ is strongly infinitesimally contracting with rate _cK >_ 0 in the norm _∥· ∥X_ . 

- (A2) (Observer contraction) There exists a matrix _L ∈_ R _[n][×][p]_ such that the FRNN with synaptic matrix _W − LC_ is strongly infinitesimally contracting with rate _cO >_ 0 in the norm _∥· ∥O_ . 

- (A3) (Contraction of reduced-order dynamics) For each constant input _u_ , let _x[⋆]_ ( _u_ ) denote the unique equilibrium of the FRNN with synaptic matrix _W_ + _BKf_ and input matrix _B_ . Assume there exists _u[⋆] ∈_ R _[m]_ such that _r_ = _Cx[⋆]_ ( _u[⋆]_ ). The reduced dynamics 

**==> picture [174 x 13] intentionally omitted <==**

be strongly infinitesimally contracting with rate _cr >_ 0 in the norm _∥· ∥R_ . 

- (A4) (Low-gain condition) Define the induced-norm constants 

**==> picture [187 x 27] intentionally omitted <==**

The gain parameter _ε >_ 0 satisfies 

**==> picture [186 x 28] intentionally omitted <==**

Consider the closed-loop system 

**==> picture [235 x 29] intentionally omitted <==**

driven by the integral controller 

**==> picture [168 x 13] intentionally omitted <==**

Then the following statements hold. 

- (i) (Global exponential stability) For every constant _u_ ext, the subsystem (67) possesses a unique equilibrium 

   - _x[⋆]_ ( _u_ ext) _, x[⋆]_ ( _u_ ext)� that is globally exponentially sta- 

   - ble, uniformly in _u_ ext. 

- (ii) (Reference tracking) The full closed-loop system (67)– (68) possesses the globally exponentially stable equilibrium � _x[⋆]_ ( _u[⋆]_ ) _, x[⋆]_ ( _u[⋆]_ ) _, u[⋆]_[�] . In particular, lim _t→∞ Cx_ ( _t_ ) = _r_ . 

_Proof:_ By Theorem 3, Assumptions (A1)-(A2) and the Lipschitz nature of the controller ensure the closed-loop system (67) is globally exponentially stable to the unique fixed point ( _x[⋆]_ ( _u_ ext) _, x[⋆]_ ( _u_ ext)), uniformly in _u_ ext. 

Now, consider the functions, _V_ 1 = _∥ξ − x∥O_ , _V_ 2 = _∥x − x[⋆]_ ( _u_ ext) _∥X_ , and _V_ 3 = _∥u_ ext _− u[⋆] ∥R_ . We will bound each of their Dini derivatives. First, from Assumption (A2) 

**==> picture [245 x 119] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.0<br>0.5<br>0.0<br>−0.5 Reference<br>Learned plant<br>−1.0 True plant<br>0 200 400 600 800 1000<br>Time [s]<br>Output<br>**----- End of picture text -----**<br>


Fig. 2. For a two tank system modeled by an FRNN, we utilize our design mechanism for the full state feedback controller, the contracting observer and the integral gain to design a closed loop system capable of tracking references, validating the proposed theoretical results. 

**==> picture [162 x 11] intentionally omitted <==**

Next, utilizing Corollary 9 for _V_ 2 and treating the low gain integral controller as the time varying parameter, 

**==> picture [235 x 23] intentionally omitted <==**

˙ Substituting _r_ = _Cx[⋆]_ ( _u[⋆]_ ) in the expression for _∥u_ ext _∥U_ , 

**==> picture [228 x 42] intentionally omitted <==**

Since _x[⋆]_ ( _u_ ) is globally Lipschitz in _u_ with constant _ℓu/cK_ , 

**==> picture [129 x 24] intentionally omitted <==**

Substituting _∥u_ ˙ ext _∥U_ back into (70) yields: 

**==> picture [246 x 25] intentionally omitted <==**

In order to find the Dini derivative of _V_ 3, we first rewrite the integral controller (68) as 

**==> picture [239 x 11] intentionally omitted <==**

Treating the second term as a disturbance to the contracting reduced order dynamics (64), from the incremental ISS property of contracting systems [7, Theorem 3.16], 

**==> picture [213 x 27] intentionally omitted <==**

Upon stacking inequalities (69), (71), (72), we obtain the following inequality, 

**==> picture [231 x 59] intentionally omitted <==**

Next, we show that _M_ ( _ε_ ) is Hurwitz. The eigenvalues of _M_ ( _ε_ ) are obtained upon solving det( _M_ ( _ε_ ) _− λI_ 3) = 0. One eigenvalue is _−cO_ , and the other two must be determined by the lower right 2 _×_ 2 block. For both of the remaining eigenvalues to be negative, this block must have a negative 

trace, and a positive determinant. Both these conditions are met under assumption (A4). 

By continuity, _M_ ( _ε_ ) + _ηI_ 3 remains Hurwitz for small _η >_ 0. Since _M_ ( _ε_ ) + _ηI_ 3 is Metzler, this is equivalent to guaranteeing the existence of an _α_ = [ _α_ 1 _, α_ 2 _, α_ 3] _[⊤]_ , such that ( _M_ ( _ε_ )+ _ηI_ 3) _[⊤] α_ is elementwise negative. Therefore, denoting _V_ = _α_ 1 _V_ 1 + _α_ 2 _V_ 2 + _α_ 3 _V_ 3, one has _D_[+] _V ≤−α[⊤] M_ ( _ε_ ) _V ≤ −ηV_ , guaranteeing exponential stability to the fixed point ( _x[⋆]_ ( _u[⋆]_ ) _, x[⋆]_ ( _u[⋆]_ ) _, u[⋆]_ ). Since _r_ = _Cx[⋆]_ ( _u[⋆]_ ), the output of the plant settles exponentially to the value _r_ . 

## _D. Numerical Validation_ 

To validate our approach numerically, we apply our controller synthesis on a normalized version of the two tank benchmark system [34]. We performed system identification using Neuromancer [14], fitting the plant to an FRNN with _n_ = 8 neurons and tanh ( _·_ ) activations. We apply Propositions 27 and 30 to design a controller and an observer respectively, and design a gain for the integral controller via Lemma 33. As shown in Figure 2, our control architecture successfully tracks piecewise constant references. 

## VI. APPLICATIONS IN MACHINE LEARNING 

We now utilize S-contraction for Deep Equilibrium Models (DEQs) [3]. DEQs replace finite-depth architectures by defining their output as solution of an implicit equation, which in turn is solved by iterating a dynamical system. For these models to be well-posed, the equilibrium must be unique and globally asymptotically stable—properties natively guaranteed by a contracting continuous-time FRNN. 

We first derive an unconstrained parameterization of weight matrices that satisfies our contractivity LMI by construction. We then utilize this parameterization to design an architecture where the weight and input matrices are input dependent. This allows the DEQ to model locally Lipschitz functions and improves parameter efficiency. 

## _A. Parameterization_ 

We first derive an unconstrained parameterization for synaptic matrices of S-contracting FRNNs. 

_Theorem 35 (Parameterization of weight matrices):_ The following statements are equivalent: 

- (i) The synaptic matrix _W_ satisfies the continuous time MONE FRNN certificate (25) for some _P ≻_ 0, diagonal matrix _Q ≻_ 0, and _c ∈_ [0 _,_ 1]. 

- (ii) _W_ can be written as 

**==> picture [210 x 12] intentionally omitted <==**

where _S ∈_ R _[n][×][n]_ satisfies _S[⊤] S ⪯ In_ , _V_ is a full rank matrix in R _[n][×][n]_ , and _d ∈_ R _[n]_ . 

_Proof:_ Using the Schur complement, the inequality (25) is equivalent to 

**==> picture [214 x 13] intentionally omitted <==**

From the Douglas-Fillmore-Williams Lemma [5, Theorem 8.6.2], the inequality (73) is true if and only if there exists a matrix _S ∈_ R _[n][×][n]_ satisfying _S[⊤] S ⪯ In_ and 

**==> picture [208 x 13] intentionally omitted <==**

Upon rearranging to solve for _W_ , 

**==> picture [202 x 12] intentionally omitted <==**

Now, the set of all valid _Q_ can be parameterized using diag(e _[−]_[2] _[d]_ ), and the set of all _P ≻_ 0 can be parameterized as _V[⊤] V_ for full rank _V ∈_ R _[n][×][n]_ . 

_Remark 36 (Unconstrained Optimization Formulation):_ In numerical implementations, the set of all matrices _S_ such that _S[⊤] S ⪯ In_ may be parameterized via a free variable _X ∈_ R _[n][×][n]_ by setting _S_ = _X_ ( _I_ + _X[⊤] X_ ) _[−]_[1] _[/]_[2] . Similarly, to ensure _V[⊤] V_ does not lose rank, we may approximate _V[⊤] V_ using a free matrix _Y ∈_ R _[n][×][n]_ and a small constant _ϵ >_ 0 by setting _P_ = _Y[⊤] Y_ + _ϵIn_ . 

Theorem 35 provides a constructive mechanism to design continuous-time FRNNs that are contracting by construction. By optimizing over the free variables _{X, Y, d}_ , stability is preserved during learning. 

## _B. Applications to implicit neural networks_ 

Recent literature [26] suggests that increasing the number of iterations of a DEQ improves its expressivity. This is due to the fact that one can model locally Lipschitz maps via fixed point equations. In order to canonically integrate this insight into a DEQ, we propose the following architecture. 

_Proposition 37 (Local Lipschitz continuity of the equilibrium map):_ Let _W_ : _U →_ R _[n][×][n]_ and _B_ : _U →_ R _[n]_ be globally Lipschitz with constants _ℓW_ and _ℓB_ . Let Ψ : R _[n] →_ R _[n]_ be MONE. Define the map _x[⋆]_ : _U →_ R _[n]_ by the implicit equation 

**==> picture [195 x 11] intentionally omitted <==**

If _W_ ( _u_ ) _− In_ is Lyapunov diagonally stable uniformly in _u_ , then the map _x[⋆]_ ( _u_ ) is locally Lipschitz for each _u ∈U_ . 

_Proof:_ Let _u, u[′] ∈U_ , and let _x_ := _x[⋆]_ ( _u_ ) _, x[′]_ := _x[⋆]_ ( _u[′]_ ). Set _ε_ := ( _W_ ( _u_ ) _−W_ ( _u[′]_ )) _x[′]_ + _B_ ( _u_ ) _−B_ ( _u[′]_ ). Since _W − In_ is LDS, there must exist a positive diagonal _Q ≻_ 0 and _δ >_ 0 such that _QW_ ( _u_ )+ _W_ ( _u_ ) _[⊤] Q ≤_ 2 _Q−_ 2 _δIn_ . Using the MONE incremental matrix multiplier, 

Applying the LDS bound to the first term on the right cancels _∥x − x[′] ∥_[2] _Q_[from][both][sides,][yielding,] 

**==> picture [183 x 12] intentionally omitted <==**

Through Cauchy Schwarz and global Lipschitz continuity of _W, B_ we obtain the Lipschitz bound, 

**==> picture [245 x 23] intentionally omitted <==**

Fixing _u_ 0 _∈U_ and _r >_ 0, applying (79) with _u[′]_ = _u_ 0 yields a uniform bound _∥x[⋆]_ ( _u[′]_ ) _∥≤ R_ ( _u_ 0 _, r_ ) _< ∞_ for all _u[′] ∈ B_ ( _u_ 0 _, r_ ). Substituting back into (79) gives Lipschitz constant _L_ ( _u_ 0 _, r_ ) = _[∥][D] δ[∥]_[(] _[ℓ][W][ R]_[(] _[u]_[0] _[, r]_[) +] _[ ℓ][B]_[)] _[ <][ ∞]_[on] _[B]_[(] _[u]_[0] _[, r]_[)][.] 

To make _W_ and _B_ input-dependent while maintaining the contractivity of the FRNN, we parameterize _W_ according to Theorem 35, replacing each free variable and _B_ with an inputdependent feedforward neural network. Because these feedforward networks typically consist of compositions of linear transformations and MONE nonlinearities, they are globally Lipschitz. This allows us to design a highly expressive, locally Lipschitz implicit neural network that remains mathematically guaranteed to be well-posed and strictly contracting. We validate this approach on the MNIST and CIFAR-10 image classification benchmarks. As shown in Table II, our model achieves competitive accuracy while remaining parameter efficient, due to a higher expressivity. Full implementation details and code are provided in our repository.[2] 

TABLE II 

COMPARATIVE PERFORMANCE ON IMAGE CLASSIFICATION BENCHMARKS 

||**Method**|**Model size**<br>**MNIST**|**Acc.**|
|---|---|---|---|
||LBEN [30]<br>monDEQ [41]<br>**Ours**|–<br>84K<br>**89K**|98.2%<br>99.1_±_0.1%<br>**99.33%**|
|||**CIFAR-10**||
||LBEN [30]<br>monDEQ [41]|–<br>172K|71.6%<br>74.0_±_0.1%|
||monDEQ_∗_[41]|854K|82.0_±_0.3%|
||**Ours**<br>**Ours**_∗_|**134K**<br>**134K**|**78.27%**<br>**82.30%**|



> _∗_ indicates models trained with data augmentation. 

## VII. CONCLUSION 

In this paper, we established a contraction-based nonlinear separation principle and developed a comprehensive framework for the robust analysis, control design, and machine learning deployment of recurrent neural networks (RNNs). First, we introduced the separation principle alongside its parametric extensions for robustness and equilibrium tracking. Next, we derived sharp contraction certificates for FRNNs and HNNs, and investigated the fundamental properties of RNN interconnections, including an extension of our certificates to Graph RNNs. Building upon these theoretical foundations, 

**==> picture [218 x 14] intentionally omitted <==**

> 2https://github.com/AnandGokhale/Contractivity ~~N~~ eural ~~N~~ etworks 

we proposed a solution to the reference tracking problem for plants modeled by RNNs via LMI-based synthesis and lowgain integral control. Finally, we applied our certificates to implicit deep learning by deriving an exact, unconstrained algebraic parameterization. This parameterization enabled the design of parameter-efficient implicit neural networks that demonstrated improved expressivity and competitive benchmark accuracy. 

Several promising directions for future work remain. First, we utilize our parametric extension of the separation principle with a low gain controller, an interesting direction is to consider extensions to optimization based controllers [9]. Second, extending the Graph RNN to undirected graphs would significantly broaden its applicability. Third, while our current analysis is restricted to standard RNNs, extending this contraction-based framework to more complex sequencemodeling architectures, such as LSTMs or transformers, is of major theoretical interest. Finally, deploying our robust contraction certificates in broader application domains, such as learning-to-optimize and large-scale network control, present an exciting avenue for future research. 

**==> picture [52 x 9] intentionally omitted <==**

**==> picture [93 x 9] intentionally omitted <==**

The following result is described in [6, Section 2.6.2] 

_Lemma 38 (Projection Lemma):_ Let _U ∈_ R _[m][×][p]_ and _V ∈_ R _[n][×][p]_ , and let _Q_ = _Q[⊤] ∈_ R _[p][×][p]_ . There exists a matrix _X ∈_ R _[m][×][n]_ satisfying, 

**==> picture [184 x 12] intentionally omitted <==**

if and only if 

**==> picture [199 x 12] intentionally omitted <==**

Next, we introduce an incremental matrix multiplier for this fixed point map from [10]. 

_Lemma 39:_ Let the map Ψ: R _[n] →_ R _[n]_ admit an incremental matrix multiplier _M_ . Let the map _x[⋆]_ : R _[m] →_ R _[n]_ be wellposed and defined as the solution of the implicit equation, 

**==> picture [183 x 11] intentionally omitted <==**

where _W ∈_ R _[n][×][n] , B ∈_ R _[n][×][m]_ . Then the map _x[⋆]_ ( _u_ ) admits the incremental multiplier matrix 

**==> picture [179 x 28] intentionally omitted <==**

_Lemma 40 (Mixed Product Property):_ Consider matrices _A ∈_ R _[n][×][m] , B ∈_ R _[m][×][p] , C ∈_ R _[k][×][l] , D ∈_ R _[l][×][q]_ . _AB ⊗ CD_ = ( _A ⊗ C_ )( _B ⊗ D_ ). 

**==> picture [97 x 20] intentionally omitted <==**

**==> picture [253 x 65] intentionally omitted <==**

**==> picture [253 x 42] intentionally omitted <==**

The continuous time result is a special case of the result in [10, Theorem 4.2]. In the discrete time case, right and left multiplying (6) by �∆ _x[⊤]_ ∆Ψ _[⊤]_[�] _[⊤]_ and its transpose respectively, and using (84) we get, 

**==> picture [231 x 41] intentionally omitted <==**

This is precisely the contraction condition for discrete-time systems. 

**==> picture [113 x 21] intentionally omitted <==**

## _A. Proof of Proposition 27_ 

_Proof:_ Under the full state feedback control law _u_ = _Kx_ , the closed-loop dynamics are given by 

**==> picture [231 x 11] intentionally omitted <==**

where _Wcl_ = _W_ + _BK_ . For a given contraction rate _c ∈_ (0 _,_ 1], the contraction condition (25) for _Wcl_ is 

**==> picture [202 x 25] intentionally omitted <==**

where _P ≻_ 0 is a symmetric matrix and _Q ≻_ 0 is a diagonal matrix. To convert this expression into an LMI, we pre- and post-multiply (88) by the block diagonal matrix diag( _P[−]_[1] _, Q[−]_[1] ). This yields the equivalent inequality: 

**==> picture [214 x 25] intentionally omitted <==**

Applying the change of variables _X_ = _P[−]_[1] and _D_ = _Q[−]_[1] , and substituting _Wcl_ = _W_ + _BK_ , the (2 _,_ 1) block becomes 

**==> picture [197 x 10] intentionally omitted <==**

Defining the variable _Y_ = _KX_ , the transformed inequality is rendered into an LMI in the variables ( _X, D, Y_ ), given by, 

**==> picture [235 x 25] intentionally omitted <==**

The original _P_ and _Q_ matrices may be recovered via _P_ = _X[−]_[1] and _Q_ = _D[−]_[1] , and the stabilizing state feedback gain is uniquely recovered via _K_ = _Y X[−]_[1] . 

## _B. Proof of Proposition 30_ 

ˆ ˆ _Proof:_ We begin by noting that substituting _y_ = _Cx_ into the observer dynamics (55) yields an FRNN with synaptic matrix _Wobs_ = _W − LC_ . Writing (25) for _Wobs_ , substituting _M_ = _QL_ , we obtain, 

**==> picture [253 x 52] intentionally omitted <==**

## APPENDIX IV 

## EXTENSION TO DIAGONALLY SYMMETRIZABLE GRAPHS 

_Theorem 41 (Contraction of Graph FRNN):_ Consider the dynamics (48) with a MONE nonlinearity Ψ. If 

(A1) The adjacency matrix _A_ can be decomposed as _A_ = _HD[−]_[1] , where _D ≻_ 0 is diagonal and _H_ = _H[⊤]_ . 

- (A2) The eigenvalues of _A_ lie in [0 _,_ 1]. 

(A3) _W_ satisfies matrix inequality (25) for _P ≻_ 0, diagonal _Q ≻_ 0, rate _c >_ 0, which satisfy _PQ[−]_[1] _P ≺_ 4(1 _− c_ ) _P_ . Then, the dynamics (48) are strongly infinitesimally contracting with rate _c_ in the norm _∥· ∥D ⊗ P_ . 

_Proof:_ We show that the weight matrix _A[⊤] ⊗ W_ satisfies (25) for weights _D ⊗ P_ and _D ⊗ Q_ . Substituting these weights into (25), and using the mixed product property of Kronecker products Lemma 40 yields 

**==> picture [240 x 25] intentionally omitted <==**

Next, we apply a congruence transformation. Left and right multiplying (93) by the non-singular block diagonal matrix _TQ_ = diag( _D[−]_[1] _[/]_[2] _⊗ In, D[−]_[1] _[/]_[2] _⊗ In_ ) yields, 

**==> picture [212 x 25] intentionally omitted <==**

where _H_[¯] = _D[−]_[1] _[/]_[2] _HD[−]_[1] _[/]_[2] . Since _H_ is symmetric and _D_ is diagonal, _H_[¯] is also symmetric. Further, the eigenvalues of _A_ are identical to that of _H_[¯] , as _D_[1] _[/]_[2] _AD[−]_[1] _[/]_[2] = _H_[¯] . 

Performing an SVD for _H_[¯] yields _H_[¯] = _U_ Λ _U[⊤]_ , due to its symmetric nature. Further, each entry of Λ is in [0 _,_ 1]. We now apply the unitary transform, _T_ = diag( _U ⊗ In, U ⊗ In_ ) to (94). Utilizing the fact that _U[⊤] U_ = _UU[⊤]_ = _Im_ , (94) is 

**==> picture [253 x 39] intentionally omitted <==**

Due to the diagonal nature of _In_ and Λ, this matrix may be permuted into a block diagonal form through the perfect shuffle permutation [32, Proposition 1]. Therefore, the condition (95) is decomposable into _n_ conditions, and the _i_ th condition has the form, 

**==> picture [200 x 25] intentionally omitted <==**

where _λi_ is the _i_ th diagonal element of the Λ. Since this condition is linear in _λi_ , and _λi ∈_ [0 _,_ 1]. this condition is true as long as it holds for _λ_ = 0 and _λ_ = 1. At _λ_ = 1, this condition is identical to (25). At _λ_ = 0, we obtain, 

**==> picture [231 x 25] intentionally omitted <==**

The equivalence occurs due to the Schur complement along the (2 _,_ 2) block. Since _W_ satisfies (25), and _PQ[−]_[1] _P ≺_ 4(1 _−c_ ) _P_ as per (A3), the proof holds. 

_Remark 42 (Assumptions on Graph Structure):_ The decomposition _A_ = _HD[−]_[1] restricts the network topology to diagonally symmetrizable graphs. This naturally encompasses undirected graphs when _D_ = _In_ . Furthermore, the condition on the eigenvalues (A2) can be performed by preprocessing the adjacency matrix _A_ =[1] 2[(] _∥A[A] orig[ori][g] ∥_[+] _[ I][n]_[)][.] 

## REFERENCES 

- [1] V. Andrieu and S. Tarbouriech. LMI conditions for contraction and synchronization. In _IFAC Symposium on Nonlinear Control Systems_ , volume 52, pages 616–621, 2019. doi:10.1016/j.ifacol. 2019.12.030. 

- [2] A. N. Atassi and H. K. Khalil. A separation principle for the stabilization of a class of nonlinear systems. _IEEE Transactions on Automatic Control_ , 44(9):1672–1687, 2002. doi:10.1109/9.788534. 

- [3] S. Bai, J. Z. Kolter, and V. Koltun. Deep equilibrium models. In _Advances in Neural Information Processing Systems_ , 2019. URL: https://arxiv.org/abs/1909.01377. 

- [4] J. Baker, Q. Wang, C. D. Hauck, and B. Wang. Implicit graph neural networks: A monotone operator viewpoint. In _Int. Conf. on Machine Learning_ , volume 202 of _Proceedings of Machine Learning Research_ , pages 1521–1548, 2023. URL: https://proceedings.mlr.press/ v202/baker23a.html. 

- [5] D. S. Bernstein. _Matrix Mathematics_ . Princeton University Press, 2 edition, 2009, ISBN 0691140391. 

- [6] S. Boyd, L. El Ghaoui, E. Feron, and V. Balakrishnan. _Linear Matrix Inequalities in System and Control Theory_ . SIAM, 1994, ISBN 089871334X. 

- [7] F. Bullo. _Contraction Theory for Dynamical Systems_ . Kindle Direct Publishing, 1.3 edition, 2026, ISBN 979-8836646806. URL: https:// fbullo.github.io/ctds. 

- [8] V. Centorrino, A. Gokhale, A. Davydov, G. Russo, and F. Bullo. Euclidean contractivity of neural networks with symmetric weights. _IEEE Control Systems Letters_ , 7:1724–1729, 2023. doi:10.1109/ LCSYS.2023.3278250. 

- [9] M. Colombino, E. Dall’Anese, and A. Bernstein. Online optimization as a feedback controller: Stability and tracking. _IEEE Transactions on Control of Network Systems_ , 7(1):422–432, 2020. doi:10.1109/ TCNS.2019.2906916. 

- [10] L. D’Alto and M. Corless. Incremental quadratic stability. _Numerical Algebra, Control and Optimization_ , 3:175–201, 2013. doi:10.3934/ naco.2013.3.175. 

- [11] W. D’Amico, A. La Bella, and M. Farina. An incremental input-tostate stability condition for a class of recurrent neural networks. _IEEE Transactions on Automatic Control_ , 69(4):2221–2236, 2024. doi:10. 1109/tac.2023.3327937. 

- [12] W. D’Amico, A. La Bella, and M. Farina. Data-driven control of echo state-based recurrent neural networks with robust stability guarantees. _Systems & Control Letters_ , 195:105974, 2025. doi:10.1016/j. sysconle.2024.105974. 

- [13] A. Davydov, V. Centorrino, A. Gokhale, G. Russo, and F. Bullo. Timevarying convex optimization: A contraction and equilibrium tracking approach. _IEEE Transactions on Automatic Control_ , 70(11):7446–7460, 2025. doi:10.1109/TAC.2025.3576043. 

- [14] J. Drgona, A. Tuor, J. Koch, M. Shapiro, B. Jacob, and D. Vrabie. NeuroMANCER: Neural Modules with Adaptive Nonlinear Constraints and Efficient Regularizations. 2023. URL: https://github.com/pnnl/ 

   - neuromancer. 

- [15] L. El Ghaoui, F. Gu, B. Travacca, A. Askari, and A. Tsai. Implicit deep learning. _SIAM Journal on Mathematics of Data Science_ , 3(3):930–958, 2021. doi:10.1137/20M1358517. 

- [16] F. Esfandiari and H. K. Khalil. Output feedback stabilization of fully linearizable systems. _International Journal of Control_ , 56(5):1007– 1037, 1992. doi:10.1080/00207179208934355. 

- [17] M. Fazlyab, A. Robey, H. Hassani, M. Morari, and G. J. Pappas. Efficient and accurate estimation of Lipschitz constants for deep neural networks. In _Advances in Neural Information Processing Systems_ , 2019. URL: https://arxiv.org/abs/1906.04893. 

- [18] C. Gatke, J. D. Schiller, and M. A. M¨uller. Small-gain analysis of exponential incremental input/output-to-state stability for large-scale distributed systems. _arXiv preprint arXiv:2604.07081_ , 2026. 

- [19] M. Giaccagli, V. Andrieu, S. Tarbouriech, and D. Astolfi. LMI conditions for contraction, integral action, and output feedback stabilization for a class of nonlinear systems. _Automatica_ , 154:111106, 2023. doi: 10.1016/j.automatica.2023.111106. 

- [20] A. Gokhale, A. V. Proskurnikov, Y. Kawano, and F. Bullo. Contracting neural networks: Sharp LMI conditions with applications to integral control and deep learning. In _IEEE Conf. on Decision and Control_ , Honolulu, Hawaii, 2026. Submitted. doi:10.48550/arXiv.2604. 00119. 

- [21] F. Gu, H. Chang, W. Zhu, S. Sojoudi, and L. El Ghaoui. Implicit graph neural networks. In _Advances in Neural Information Processing Systems_ , 2020. URL: https://arxiv.org/abs/2009.06211. 

- [22] J. P. Hespanha. _Linear Systems Theory_ . Princeton University Press, 2009, ISBN 0691140219. 

- [23] S. Jafarpour, A. Davydov, A. V. Proskurnikov, and F. Bullo. Robust implicit networks via non-Euclidean contractions. In _Advances in Neural Information Processing Systems_ , December 2021. doi:10. 48550/arXiv.2106.03194. 

- [24] T. N. Kipf and M. Welling. Semi-supervised classification with graph convolutional networks. _arXiv preprint arXiv:1609.02907_ , 2016. 

- [25] L. Kozachkov, M. Ennis, and J.-J. E. Slotine. RNNs of RNNs: Recursive construction of stable assemblies of recurrent neural networks. In _Advances in Neural Information Processing Systems_ , December 2022. doi:10.48550/arXiv.2106.08928. 

- [26] J. Liu, L. Ding, S. Osher, and W. Yin. Implicit models: Expressive power scales with test-time compute. _arXiv preprint_ , 2025. doi: 10.48550/arXiv.2510.03638. 

- [27] I. R. Manchester and J.-J. E. Slotine. Transverse contraction criteria for existence, stability, and robustness of a limit cycle. _Systems & Control Letters_ , 63:32–38, 2014. doi:10.1016/j.sysconle.2013.10. 005. 

- [28] A. Nikolakopoulou, M. Hong, and R. D. Braatz. Dynamic state feedback controller and observer design for dynamic artificial neural network models. _Automatica_ , 146:110622, 2022. doi:10.1016/j. automatica.2022.110622. 

- [29] M. Poli, S. Massaroli, J. Park, A. Yamashita, H. Asama, and J. Park. Graph neural ordinary differential equations. _arXiv preprint arXiv:1911.07532_ , 2019. 

- [30] M. Revay, R. Wang, and I. R. Manchester. Lipschitz bounded equilibrium networks. _arXiv preprint arXiv:2010.01732_ , 2020. doi: 10.48550/arXiv.2010.01732. 

- [31] M. Revay, R. Wang, and I. R. Manchester. A convex parameterization of robust recurrent neural networks. _IEEE Control Systems Letters_ , 5(4):1363–1368, 2021. doi:10.1109/LCSYS.2020.3038221. 

- [32] D. J. Rose. Matrix identities of the fast Fourier transform. _Linear Algebra and its Applications_ , 29:423–443, 1980. doi:10.1016/ 0024-3795(80)90253-0. 

- [33] C. J. Rozell, D. H. Johnson, R. G. Baraniuk, and B. A. Olshausen. Sparse coding via thresholding and local competition in neural circuits. _Neural Computation_ , 20(10):2526–2563, 2008. doi:10.1162/neco. 2008.03-07-486. 

- [34] M. Schoukens and J. P. No¨el. Three benchmarks addressing open challenges in nonlinear system identification. _IFAC World Congress_ , 50(1):446–451, 2017. doi:10.1016/j.ifacol.2017.08.071. 

- [35] A. Shiriaev, R. Johansson, A. Robertsson, and L. Freidovich. Separation principle for a class of nonlinear feedback systems augmented with observers. _IFAC Proceedings Volumes_ , 41(2):6196–6201, 2008. doi: 10.3182/20080706-5-KR-1001.01046. 

- [36] J. W. Simpson-Porco. Analysis and synthesis of low-gain integral controllers for nonlinear systems. _IEEE Transactions on Automatic Control_ , 66(9):4148–4159, 2021. doi:10.1109/tac.2020.3035569. 

- [37] E. D. Sontag and Y. Wang. Output-to-state stability and detectability of nonlinear systems. _Systems & Control Letters_ , 29(5):279–290, 1997. doi:10.1016/S0167-6911(97)90013-X. 

- [38] D. W. Tank and J. J. Hopfield. Simple ”neural” optimization networks: An A/D converter, signal decision circuit, and a linear programming circuit. _IEEE Transactions on Circuits and Systems_ , 33(5):533–541, 1986. doi:10.1109/TCS.1986.1085953. 

- [39] A. Teel and L. Praly. Tools for semiglobal stabilization by partial state and output feedback. _SIAM Journal on Control and Optimization_ , 33(5):1443–1488, 1995. doi:10.1137/S0363012992241430. 

- [40] M. Vidyasagar. On the stabilization of nonlinear systems using state detection. _IEEE Transactions on Automatic Control_ , 25(3):504–509, 1980. doi:10.1109/TAC.1980.1102376. 

- [41] E. Winston and J. Z. Kolter. Monotone operator equilibrium networks. In _Advances in Neural Information Processing Systems_ , 2020. URL: https://arxiv.org/abs/2006.08591. 

- [42] L.-P. Xhonneux, M. Qu, and J. Tang. Continuous graph neural networks. In _International conference on machine learning_ , pages 10432–10441. PMLR, 2020. 

- [43] M. Zakwan, V. Gupta, A. Karimi, E. C. Balta, and G. Ferrari-Trecate. Controller design for structured state-space models via contraction theory. _arXiv preprint arXiv:2604.07069_ , 2026. 

