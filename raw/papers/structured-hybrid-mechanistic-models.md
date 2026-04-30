---
source_url: 
ingested: 2026-04-29
sha256: c2eb19889549b546ea82b497e4ae2f17f7dd7c086375194d6aebbbee8165e19f
---

# **Structured Hybrid Mechanistic Models for Robust Estimation of Time-Dependent Intervention Outcomes** 

**Tomer Meir**[1,][:] **, Ori Linial**[1] **, Danny Eytan**[1] **, and Uri Shalit**[2] 

> 1 _**Technion - Israel Institute of Technology**_ 

> 2 _**Tel Aviv University**_ 

> : _**Corresponding Author: tomer.me@campus.technion.ac.il**_ 

## **Abstract** 

Estimating intervention effects in dynamical systems is crucial for outcome optimization. In medicine, such interventions arise in physiological regulation (e.g., cardiovascular system under fluid administration) and pharmacokinetics, among others. Propofol administration is an anesthetic intervention, where the challenge is to estimate the optimal dose required to achieve a target brain concentration for anesthesia, given patient characteristics, while avoiding under- or over-dosing. The pharmacokinetic state is characterized by drug concentrations across tissues, and its dynamics are governed by prior states, patient covariates, drug clearance, and drug administration. While data-driven models can capture complex dynamics, they often fail in out-ofdistribution (OOD) regimes. Mechanistic models on the other hand are typically robust, but might be oversimplified. We propose a hybrid mechanistic-data-driven approach to estimate time-dependent intervention outcomes. Our approach decomposes the dynamical system’s transition operator into parametric and nonparametric components, further distinguishing between intervention-related and unrelated dynamics. This structure leverages mechanistic anchors while learning residual patterns from data. For scenarios where mechanistic parameters are unknown, we introduce a two-stage procedure: first, pre-training an encoder on simulated data, and subsequently learning corrections from observed data. Two regimes with incomplete mechanistic knowledge are considered: periodic pendulum and Propofol bolus injections. Results demonstrate that our hybrid approach outperforms purely data-driven and mechanistic approaches, particularly OOD. This work highlights the potential of hybrid mechanistic-data-driven models for robust intervention optimization in complex, real-world dynamical systems. 

_**K**_ **eywords** _Hybrid Models; Dynamical Systems; Time-dependent Intervention; Causal Inference; Personalized Treatment_ 

A Preprint - February 13, 2026 

**==> picture [469 x 208] intentionally omitted <==**

**----- Start of picture text -----**<br>
State Vector Mechanistic State Vector Mechanistic Hybrid Model<br>with  Encoder with  Encoder of<br>Intervention Intervention<br>Mechanistic ODE<br>ODE<br>Solver<br>Correction<br>Networks<br>Mechanistic ODE Original Dataset<br>Data Generator<br>Step 1 - Encoder  Step 2 - Correction<br>Training Networks Training<br>**----- End of picture text -----**<br>


Figure 1: A hybrid mechanistic-data-driven model with a two-step training process. In Step 1 (left), we generate synthetic training data from the known mechanistic model, which provides ground-truth parameter labels. This labeled data is used to train an encoder that maps the state trajectory and interventions to the parameter vector, using a mean squared error (MSE) loss between true and predicted parameters. In Step 2 (right), we train the correction networks using the original dataset while keeping the encoder network fixed, optimizing an MSE reconstruction loss between the observed and reconstructed signals. 

## **1 Introduction** 

Predicting the trajectory of a dynamical system under varying interventions is a prerequisite for optimal decision-making. In medicine, interventions in dynamical systems are common and include, for example, fluid administration in cardiovascular systems and joint interventions in musculoskeletal systems, among others. For example, determining the optimal dose for a patient, a critical task in anesthesia, diabetes management and more. In such cases, the system’s response is dictated by its pharmacokinetic (PK) state, while the underlying dynamics are driven by drug administration, clearance rates, and patient covariates. For example, consider Propofol administration, a standard intervention in anesthesia: the challenge lies in estimating the optimal infusion dose schedule to achieve the target concentration in the brain required for anesthesia given patient’s characteristics, without incurring the adverse effects of Propofol under- or over- dose. 

A central challenge in causal modeling of dynamical systems is that interventions do not merely shift the distribution of a single outcome at a fixed time point, but rather modify the underlying transition operator that maps one state to the next. Estimating trajectories under interventions therefore requires characterizing the transition operator and the full path of potential states under different treatments (Lim et al., 2018). In such settings, even minor structural errors in the transition operator can accumulate over time, causing predicted trajectories to diverge substantially at later horizons. Yet in many biomedical applications the governing dynamics are only partially known, and are based on small sample size – we do not have anything close to an accurate, complete dynamical-system 

2 

A Preprint - February 13, 2026 

characterization of the human body. In this work we develop a hybrid mechanistic-data-driven approach for estimating the effects of interventions in dynamical systems. We focus on settings where the system state is observed, and where interventions are time-dependent but known _a priori_ (i.e., not adaptive). An example of such a scenario is choosing a medication schedule for a patient based on their baseline covariates and state at time _t_ 0 so as to reach a desired clinical state post treatment. Modeling the transition operator in these settings raises a familiar tradeoff (Karpatne et al., 2017; Baker et al., 2018). On one hand, mechanistic models (often specified as ordinary differential equations) encode prior scientific knowledge through parametric structure; data is then used primarily to estimate a very small set of parameters describing the overall system. These models can be interpretable and stable, but in practice they are frequently misspecified due to missing mechanisms, unmodeled heterogeneity, or inaccurate parameterization. On the other hand, fully nonparametric models (e.g., neural networks) can represent complex dynamics with minimal prior assumptions, but their learned relationships may be difficult to interpret and can be brittle when deployed outside the training distribution. This brittleness is particularly problematic for causal questions: prediction under interventions is inherently performed under a distribution shift, and models that rely on statistical associations rather than causal structure may fail in precisely the regimes of interest (Schölkopf et al., 2021). Our goal is to retain the stability conferred by mechanistic structure while using data-driven components to absorb model mismatch. 

This tension has motivated hybrid approaches that combine the strengths of both paradigms, leveraging the stability of mechanistic models together with the flexibility of nonparametric components (Baker et al., 2018; Raissi et al., 2019; Rackauckas et al., 2020; Miller et al., 2021). We demonstrate the utility of the hybrid approach through settings where mechanistic knowledge can be expressed through ordinary differential equations (ODEs) and combine this mechanistic structure with nonparametric components learned from data. Specifically we choose to use Neural ODE models (Chen et al., 2018) for this purpose, due to their flexibility and wide use. Our framework models the transition operator as a sum of parametric and nonparametric contributions, enabling the correction of mechanistic misspecification while retaining stability. Notably, we do not attempt to identify the “missing” dynamics parametrically, as in approaches such as SINDy or CONFIDE (Brunton et al., 2016; Linial et al., 2024). Instead, we intentionally leave nonparametric components to absorb model mismatch while keeping the known mechanistic core intact. Crucially, we explicitly distinguish between intervention-dependent and intervention-independent corrections. This structural decomposition allows the model to disentangle natural dynamic drift from treatment effects, yielding improved modeling of counterfactual intervention outcomes. A formal presentation of the general dynamicalsystem framework and our hybrid modeling approach is provided in Section 2. 

To demonstrate the versatility of our approach, we examine two case studies involving incomplete mechanistic models. First, we analyze a pendulum case study to evaluate the model’s ability to recover dynamics under parametric uncertainty and distributional shifts in intervention magnitude. We propose a training procedure to handle unknown physical parameters. 

3 

A Preprint - February 13, 2026 

Second, we address anesthesia dosage control, a PK challenge requiring sequential bolus injections to maintain patient-specific target concentrations. Unlike the pendulum, the patient covariates here are known, but the mechanistic model is structurally deficient (Enlund, 2008). We evaluate robustness against OOD shifts in patient parameters, which also affects intervention regimes. 

## **1.1 Related Work** 

Mechanistic ODEs are widely used in physiology, including, for example, PK (Eleveld et al., 2018; Schnider et al., 1998) or cardiovascular (Tannenbaum et al., 2023). While interpretable and stable, they oversimplify complex biological interactions, motivating hybrid approaches that retain mechanistic stability while capturing unmodeled dynamics (Grigorian et al., 2024). Indeed, hybrid mechanisticdata-driven modeling has gained increasing attention in scientific machine learning. Such models, also referred to as grey-box models, SciML, or physics-informed neural networks (PINNs), integrate mechanistic structure with trainable components to improve robustness (von Rueden et al., 2023). Applications span systems biology (Lan et al., 2025; Noordijk et al., 2024), engineering (Willard et al., 2022), agronomy (Maestrini et al., 2022), and physics (Karniadakis et al., 2021). 

Semiparametric ODE models (Xue et al., 2019) use nonparametric components for state-smoothing and parameter estimation, however, they assume the underlying mechanistic structure is correct. In contrast, our framework treats the mechanistic model as a potentially incomplete prior, utilizing neural components to learn and compensate for missing or misspecified dynamical terms. 

Neural ordinary differential equations (Neural ODEs) (Chen et al., 2018) provide a natural framework for learning continuous-time dynamics and have been extended to incorporate mechanistic priors (Rackauckas et al., 2020). Hybrid dynamical systems approaches such as latent ODEs (Rubanova et al., 2019) or neural controlled differential equations (Kidger et al., 2020) introduce flexible data-driven dynamics, yet they do not incorporate explicit mechanistic models or exploit known scientific structure. Additional work handles known unknowns (Linial et al., 2021). In contrast to these approaches, we focus on counterfactual questions by introducing a structural distinction between interventiondependent and intervention-independent components. Moreover, we propose a principled method for estimating the parameters of the mechanistic prior when they are unavailable and demonstrate how such priors facilitate generalization in OOD regimes inherent to causal inference. 

Purely data-driven models achieve strong predictive accuracy in time-series forecasting (Lim et al., 2018), yet they typically rely on statistical associations rather than causal or mechanistic relations. This limits their performance in counterfactual or OOD settings common in medicine (Schölkopf et al., 2021). Related work in model-based reinforcement learning and differentiable simulation (Chua et al., 2018; Deisenroth and Rasmussen, 2011) similarly focuses on optimal decision making under partially learned dynamics. However, these approaches often prioritize policy optimization over the causal validity of the underlying transition operator. In clinical settings, we argue that optimal decision making must be grounded in physical or physiological laws to ensure safety and robustness in OOD regimes - a fundamental requirement for reliable causal inference. 

4 

A Preprint - February 13, 2026 

From a causal inference perspective, Lok (2008) established the theoretical basis for potential outcomes in continuous time. Subsequent methods have addressed treatment effect estimation in both unconfounded (Soleimani et al., 2017; Schulam and Saria, 2017) and confounded settings (Bica et al., 2020). However, these approaches typically model dynamics via flexible, nonparametric approaches and do not exploit the rich, albeit imperfect, mechanistic knowledge available in biomedical domains. Our work bridges this gap by anchoring the transition operator to a mechanistic core while utilizing nonparametric components to correct for misspecification, specifically tailored for intervention effect estimation. 

## **1.2 Main Contributions** 

This work makes the following contributions: 

- **Structural decomposition for counterfactual dynamics:** We introduce a hybrid architecture that partitions the transition operator into parametric versus nonparametric, and interventiondependent versus independent components. This explicit inductive bias facilitates robust counterfactual prediction compared to purely data-driven Neural ODEs. 

- **Two-stage inference for latent parameters:** We propose a framework to handle unobserved physical parameters via simulation-based encoder pre-training. This amortized inference provides a grounded initialization for the mechanistic core, preventing the optimization pathology where hybrid models bypass physical constraints to rely solely on data-driven components. 

- **Robustness to interventional distribution shift:** We demonstrate that anchoring nonparametric corrections to a mechanistic core significantly improves generalization in OOD regimes. Experiments on pendulum dynamics and Propofol PK show superior stability in counterfactual scenarios involving unseen intervention magnitudes and patient covariates. 

## **2 Setup** 

We consider a dynamical system whose state evolution is governed by the following ODE model: 

**==> picture [346 x 42] intentionally omitted <==**

Here, _t_ P r _t_ 0 _, t_ maxs denotes continuous time, **X** p _t_ q P _X_ Ď R _[k]_ is the _k_ -dimensional state vector representing the system at time _t_ , and **X** p _t_ 0q “ **X** 0 represents the initial state. The function **F**[r] represents the vector field governing the instantaneous rate of change. The dynamics are influenced by two distinct types of inputs: 

- System Parameters ( _**β**_ ): A _p_ -dimensional vector of constant parameters characterizing the individual unit (e.g., patient physiology or physical constants). We partition this vector into 

5 

A Preprint - February 13, 2026 

**==> picture [468 x 262] intentionally omitted <==**

Figure 2: Cylindrical and point-mass pendulums 

observed components _**β**_[obs] and unobserved latent components _**β**_[U] , such that _**β**_ “ p _**β**_[obs] _,_ _**β**_[U] q P _B_ , where _B_ is the set of all possible constant parameters of the system. 

- Intervention ( _**η**_ ): An _r_ -dimensional vector of time-varying external intervention _**η**_ p _t_ q P _H_ , applied to the system (e.g., drug infusion rate), where _H_ is the set of all possible interventions in the dynamics. 

While Eq. (1) describes the deterministic dynamics of a single unit, we require reasoning over a population. Accordingly, we treat the unit-specific tuple of the initial state, parameters, and intervention, p **X** 0 _,_ _**β** ,_ _**η**_ q, as a realization of random variables drawn from a joint distribution _P_ over the configuration space _X_ ˆ _B_ ˆ _H_ . This probabilistic formulation establishes the basis for the independence assumptions discussed in Section 3. We demonstrate the formulation using the pendulum example provided in Box 1. 

Our goal is to estimate the state evolution **X** p _t_ q under different interventions _**η**_ p _t_ q, with interventions both within-distribution and out-of-distribution (OOD). We assume the true generative process is unknown, and potentially more complex than our best mechanistic approximation, and that the parameters _**β**_ may also be unknown. 

To estimate the effect of the intervention _**η**_ p _t_ q on the state vector **X** p _t_ q, we decompose the transition dynamics in Eq. (1) into four parts: parametric vs. nonparametric, and intervention-dependent vs. intervention-independent components. Specifically, we impose the following structural assumption on the transition operator: 

6 

A Preprint - February 13, 2026 

**Assumption 1** (Additive Treatment Effect) **.** _The transition operator governing the underlying dynamics,[d]_ **[X]** _dt_[p] _[t]_[q] _[,][can][be][decomposed][into][intervention-dependent][and][intervention-independent][components:]_ 

**==> picture [196 x 33] intentionally omitted <==**

The functions **F**[r] _[ψ]_ are nuisance components, whereas **F**[r] _[η]_ represents the treatment effect. We assume that each of these functions can be further decomposed into parametric and nonparametric parts as follows: 

**Box 1: Pendulum Example** Consider two models of a pendulum. In the simplest case, a frictionless 2D pendulum, the dynamics are described by the following ODE: 

**==> picture [180 x 25] intentionally omitted <==**

where _m_ is the total mass, _g_ is the gravitational constant, _Is_ is the moment of inertia about the fixed axis, _lcm_ is the distance from the pivot to the center of mass, and _τ_ extp _t_ q denotes the total external torque acting about the fixed axis. This second-order differential equation can be rewritten as a system of first-order differential equations using the simplified version of the state vector representation described in Eq. (1). Specifically, for the case of a cylindrical rod rotating about its edge with _Is_ “[1] 4 _[mR]_[2][ `] 3[1] _[mL]_[2][and] _**[β]**_[“ t] _[m, L, R]_[u][we][obtain:] 

**==> picture [342 x 55] intentionally omitted <==**

and for the case of a point-mass pendulum with _Is_ “ _mlcm_[2][and] _**[ β]**_[“ t] _[m, l][cm]_[u][the][system][becomes:] 

**==> picture [306 x 54] intentionally omitted <==**

In both cases the state vector is **X** p _t_ q “ t _θ_ p _t_ q _, ω_ p _t_ qu[J] , and the intervention _**η**_ p _t_ q corresponds to _τ_ extp _t_ q. An illustrative sketch of the point-mass and cylindrical pendulums is shown in Fig. 2. 

**Assumption 2** (Hybrid Transition Operator) **.** _Both the intervention dependent and the intervention independent components of the transition operator are composed of two additive components: a_ 

7 

A Preprint - February 13, 2026 

_parametric mechanistic term and a nonparametric term, i.e.,_ 

**==> picture [240 x 35] intentionally omitted <==**

where t **F** _[ψ] p[,]_ **[ F]** _[η] p_[u][and][t] **[F]** _[ψ] np[,]_ **[ F]** _[η] np_[u][denote][the][parametric][and][nonparametric][components][of] **[˜F]**[,][respec-] tively. 

Therefore, the overall model takes the form 

**==> picture [357 x 66] intentionally omitted <==**

In addition, we add identifiability assumptions 

**Assumption 3** (Mechanistic Identifiability) **.** _The observed parameters_ _**β**[obs] of the mechanistic components_ **F** _[ψ] p[and]_ **[F]** _[η] p[is][assumed][to][be][uniquely][recoverable][from][data][generated][under][the][parametric] model: Let Fp[ψ,η]_ : t _**β**[obs] ,_ _**X**_ 0 _,_ _**η**_ p _t_ qu Ñ _D_ P _X_[r][0] _[,T]_[max][s] _be the function that maps_ t _**β**[obs] ,_ _**X**_ 0 _,_ _**η**_ p _t_ qu _to data generated by the parametric model. We assume Fp[ψ,η] is injective in_ _**β**[obs] ._ 

An additional assumption is the absence of time-independent unobserved confounding (UC) 

**Assumption 4** (No Time-Independent UC) **.** _The time dependent intervention is independent of all unobserved parameters,_ _**η**_ KK _**β**[U]_ | _**X** ,_ _**β**[obs]_ @ _t_ P r _t_ 0 _, t_ maxs _._ Furthermore, because the intervention is time-dependent, we require no feedback condition: **Assumption 5** (No Time-Dependent UC) **.** _The intervention_ _**η**_ p _t_[1] q @ _t_[1] P r _t_ 0 _, t_ maxs _is known_ a priori _and is independent of states and parameters at earlier times_ r _t_ 0 _, t_[1] q _._ _**η**_ p _t_[1] q KK _**X**_ p _s_ q _,_ _**β**_ @ _s_ P r _t_ 0 _, t_[1] q _,_ @ _t_[1] P r _t_ 0 _, t_ maxs 

The last two assumptions imply that we focus on interventions that, while potentially time-varying and covariate specific, are _non-adaptive_ : they are fixed _a priori_ . 

To illustrate the assumptions, consider the pendulum example. Suppose the dataset of observations is generated by a cylindrical rod rotating about its edge, while our mechanistic prior t **F** _[ψ] p[,]_ **[ F]** _[η] p_[u][is][based] on the simplified point-mass pendulum model of Eq. (3). Thus, 

**==> picture [178 x 35] intentionally omitted <==**

Our goal is to estimate the parameter vector _**β**_ “ t _m, lcm_ u and the nonparametric vectors of functions t **F** _[ψ] np[,]_ **[ F]** _[η] np_[u][in][order][to][estimate][the][state][vector][under][different][types][of][interventions.][The] nonparametric components may be implemented using neural networks of various types, where their 

8 

A Preprint - February 13, 2026 

input consists of the information known at the current time step and their output is a correction term. We note that in the pendulum example, when _τ_ ext “ 0 the parameter _m_ does not influence the dynamics and is therefore not identifiable from data. 

## **3 Methods** 

A major challenge in training a hybrid model is that, in many cases, the actual generative model and the required physical parameters, _**β**_ , or their labels in the dataset - are unknown. We observe only the time-dependent state vectors of the samples, **X** p _t_ q, in the dataset, together with the interventions, _**η**_ p _t_ q. Another well-known challenge in designing and training hybrid models is that enforcing parametric physical constraints often increases the error during data-driven optimization, causing the overall model to eventually ignore the constrained component and rely solely on the data-driven part (Takeishi and Kalousis, 2021). To address these challenges, we develop the following method, illustrated in Fig. 1 and detailed in Alg. 1. 

We distinguish between two settings. In some applications, the mechanistic parameters _**β**_ are observed, as in the Propofol example (Section 4.2). In other cases, such as the pendulum example, _**β**_ is unobserved and must be inferred. For the latter, we introduce an auxiliary pretraining step based on simulated data. Specifically, we generate a _mechanistic simulated dataset_ by sampling _**β**_ from user-defined ranges and simulating trajectories under the known parametric dynamics, t **F** _[ψ] p[,]_ **[ F]** _[η] p_[u][.][This] dataset consists of state trajectories **X** p _t_ q, interventions _**η**_ p _t_ q, and corresponding parameter labels _**β**_ . An encoder is then trained to map simulated trajectories to estimates of _**β**_ using a MSE loss. The inferred parameters _**β**_[p] should not be interpreted as estimates of the true generative parameters, but rather as effective parameters that enable the mechanistic component to provide a meaningful inductive bias when combined with the nonparametric correction. 

Then, once the mechanistic component is complete - either because the true parameters are known or because they have been inferred - we freeze the mechanistic component of each sample, and the encoder weights when applicable, and train the complementary data-driven correction components t **F** _[ψ] np[,]_ **[ F]** _[η] np_[u][,][conditioned][on][the][parametric][part.][This][allows][the][model][to][learn][patterns][from][data] without discarding the parametric contribution. Training the nonparametric part separately from the mechanistic and encoder components thereby addresses the second challenge. Furthermore, separating the effects into intervention-related **F** _[η]_ and intervention-unrelated **F** _[ψ]_ components enables more accurate estimation of the intervention effect, as opposed to relying on a fully nonparametric signal estimation where the intervention is part of the input. This, in turn, is expected to promote better intervention-related generalization. Additional design choices and considerations are provided in Appendix C. 

9 

A Preprint - February 13, 2026 

## **Algorithm 1** Hybrid model training procedure 

**input:** tp **X** _i_ p _t_ q _,_ _**η** i_ p _t_ qqu _[n] i_ “[train] 1[,][tp] **[X]** _[j]_[p] _[t]_[q] _[,]_ _**[ η]** j_[p] _[t]_[qqu] _[n] j_ “[test] 1[for][all] _[t]_[ P r] _[t]_[0] _[, t]_[max][s][:][training][and][test][set] **input:** t _**η**_[1] _j_[p] _[t]_[qu] _[n] j_ “[test] 1[:][counterfactual][interventions] **input:** t **F** _[ψ] p[,]_ **[ F]** _[η] p_[u][:][prior][knowledge][of] _[d]_ **[X]**[{] _[dt]_ **input:** ( optional) t _**β** i_ u _[n] i_ “[train] 1[,][t] _**[β]** j_[u] _[n] j_ “[test] 1[:][training][and][test][set][mechanistic][parameters][(if][known)] 

- 1: **if** BetaUnknown **then** 

- 2: Generate synthetic trajectories under the mechanistic model with parameter labels _**β**_ . 3: Train an encoder _En_ to predict _**β**_ from trajectories, e.g. by minimizing the _MSE_ p _**β** ,_ _**β**_[p] q. _i_ 

- 4: For each training sample _i_ , set _**β**_[p] Ð _En_ p **X** _i_ p¨q _,_ _**η** i_ p¨qq. 5: **else** _i_ 

- 6: For each training sample _i_ , set _**β**_[p] Ð _**β** i_ . 

- 7: **end if** 

- _i_ 

- 8: Train the hybrid Neural ODE by fitting **F** _[ψ] np_[and] **[F]** _[η] np_[conditioned][on] _**[β]**_[p] , _**η** i_ p _t_ q, **F** _ψp_[,][and] **[F]** _[η] p_[,][e.g.,] by minimizing reconstruction MSE. 

- 9: **if** BetaUnknown **then** _j_ 

- 10: For each test sample _j_ , use the beginning of the sequence to predict _**β**_[p] Ð _En_ p **X** _j_ p¨q _,_ _**η** j_ p¨qq 11: **else** _j_ 

- 12: For each test sample _j_ , set _**β**_[p] Ð _**β** j_ . 13: **end if** 

- 14: For each test sample _j_ , use the hybrid model to predict the counterfactuals **X**[1] _j_[p] _[t]_[q][under] _**[η]**_[1] _j_[p] _[t]_[q] given _**β**_[p] _j_ . **output:** t **X**[1] _j_[p] _[t]_[qu] _[n] j_ “[test] 1[:][outcomes][under][counterfactual][interventions] 

## **4 Experiments** 

We demonstrate our approach through two case studies.For each, we employ a complex generative process as the ground truth, while a simpler, incomplete model represents the available prior knowledge used as the integrated parametric component. The first case is a pendulum system with periodic dynamics and a steady intervention, where the observed data are time-dependent state trajectories, and the physical parameters are unknown and must be inferred. The second is a model of the PK of Propofol, in which patient parameters are given, and the objective is to select the total dose, administered as a sequence of bolus infusions, to reach a target effect-site level. These cases cover different types of dynamics, with different data-availability scenarios and analysis goals, all of which are common in practice. 

We analyze both case studies through the lens of three approaches: purely mechanistic models expressed through physical ODEs, purely data-driven models implemented with Neural ODE (Chen et al., 2018), and our hybrid framework, which uses physical ODEs as a mechanistic prior integrated with correction networks using a Neural ODE architecture. Our nonparametric networks are implemented using Multilayer Perceptrons (MLPs). Additional details are provided in Appendices A-B. 

10 

A Preprint - February 13, 2026 

## **4.1 Pendulum Experiments** 

Consider a case in which the data describe the current state of a rigid cylinder rotating about its edge. Our prior knowledge of pendulum dynamics is represented by the simplified point-mass pendulum. Both scenarios are illustrated in Fig. 2. The goal of this experiment is to evaluate how effectively the proposed hybrid models leverage imperfect mechanistic knowledge, together with data generated from the true generative model, to predict system trajectories under observed interventions. Here, test samples differ from training samples not by reconstructing previously observed trajectories, but by predicting trajectories for new initial conditions, parameter values, and interventions that were not encountered during training. 

We generate a dataset consisting of _n_ “ 5000 observations, each with state vectors t _θ_ p _t_ q _, ω_ p _t_ qu that follow the dynamics of cylinder rotating about its edge described in Eq. (2). We begin by sampling the true parameters t _m, L, R_ u of the cylinder such that _m_ „ _U_ p3 _._ 5 _,_ 4q kg, _L_ „ _U_ p4 _,_ 4 _._ 5q meter, _R_ „ _U_ p2 _,_ 2 _._ 5q meter, and the initial conditions t _θ_ 0 _, ω_ 0u with _θ_ 0 „ _U_ p´0 _._ 2 _,_ 0 _._ 2q rad and _ω_ 0 „ _U_ p´0 _._ 1 _,_ 0 _._ 1q rad/sec. 

For each observation, we apply a constant intervention such that, for all _t_ , the intervention magnitude satisfies _τ_ extp _t_ q “ 10 ` 0 _._ 5 _k_ , where _k_ „ _U_ t0 _, . . . ,_ 4u. The state trajectories are then constructed over the time interval _t_ P t0 _, . . . , t_ maxu, with _t_ max “ 10, using a Runge-Kutta integration method and a step size of ∆ _t_ “ 0 _._ 1. We generate two types of test sets in a similar fashion, with the two differing only in the intervention distribution: one is **in-distribution** (same as training set) and one is **out-of-distribution** with _k_ „ _U_ t5 _,_ 6 _,_ 7u. 

The known prior knowledge is given as the point-mass pendulum equation system described in Eq. (3), with unknown parameters that must be inferred. Thus, we include an encoder based on Eq. (3) to infer the parameters of the mechanistic model t _m, lcm_ u. 

The hybrid model follows the point-mass prior with correction networks, i.e., 

**==> picture [337 x 113] intentionally omitted <==**

where t _Fnp, Fnp[η][,][ G][np][,][ G][η] np_[u][ are correction networks learned from data.][Lastly, we compared the results] of the mechanistic only and hybrid models to a fully data-driven baseline model as defined in Eq. (1). In our implementation, the encoder and the networks denoted by _Fnp, Fnp[η][, G][np][, G][η] np_[and][the][fully] data-driven networks are all multilayer perceptrons (MLPs). These networks parameterize the righthand side of the system’s differential equation. Given initial conditions, _[d]_ **[X]** _dt_[p] _[t]_[q] is integrated using a 

11 

A Preprint - February 13, 2026 

**==> picture [376 x 125] intentionally omitted <==**

Figure 3: **Test Reconstruction Results on Pendulum** : Box-plot across 20 replications of the mean reconstruction MSE (averaged over samples and time) for 50,000 test trajectories under **in-distribution** and **out-of-distribution** intervention types, on a logarithmic scale. Here, reconstruction refers to forecasting the system trajectory from randomly sampled initial conditions and parameters drawn from the training distribution, under given interventions (in-distribution or out-of-distribution), using the learned models, and comparing the resulting trajectories to those generated by the true underlying dynamics. 

numerical ODE solver to generate the state trajectories up to _T_ max. During training, we minimize a reconstruction MSE, defined as the squared difference between the reconstructed and observed trajectories, by optimizing the network parameters (Chen et al., 2018). 

## **4.1.1 Test Reconstruction Performance** 

A box-plot of the mean test reconstruction MSE, for the three models, based on 20 replications of the experiment, are shown in log-scale in Fig. 3. Evidently, relying solely on the simplified mechanistic prior knowledge - namely, the physics-only model - yields the worst performance, as expected, due to its incomplete physics. The fully data-driven and hybrid models are comparable in-distribution, with a slight advantage for the hybrid model. In the OOD regime, all models exhibit higher MSE comparing to their results in-distribution, as expected; nevertheless, the hybrid model maintains its performance better than the fully data-driven model and achieves the best results. 

## **4.1.2 Intervention Outcome Prediction** 

Next, we evaluate the models’ ability to predict intervention outcomes to facilitate optimal intervention selection. We generate 5,000 observations that follow the cylinder dynamics with _T_ max “ 20 seconds and ∆ _t_ “ 0 _._ 1 second. In the first 100 time points (up to _t_ “ 10), we apply an intervention of _τ_ extp _t_ q “ 10. At _t_ “ 10, we generate a set of counterfactuals for each observation using _τ_ extp _t_ q “ 6 ` _k_ , _k_ “ 0 _, . . . ,_ 5. We then compare the models’ ability to predict these outcomes, where the interventions _τ_ extp _t_ q P t10 _,_ 11u are considered in-distribution and _τ_ extp _t_ q P t6 _, . . . ,_ 9u, are considered OOD. In this experiment, the first 100 time points are used by the encoder to infer the unknown mechanistic parameters. The subsequent 100 time points are withheld from the models and serve as the ground truth for evaluating intervention-outcome predictions. The mean intervention outcome prediction MSE for the three models, across all counterfactual values, is shown in Fig. 4. The fully data-driven 

12 

A Preprint - February 13, 2026 

and hybrid models are comparable in-distribution. However, similarly to the reconstruction results, when moving further beyond previously seen interventions, i.e., deeper into the OOD regime, the hybrid model maintains its performance better than the fully data-driven model. 

## **4.2 Pharmacokinetics Experiment** 

PK models describe the time evolution of drug concentration in the body using differential equations that account for drug absorption, transport, and clearance. A standard mathematical representation is the three-compartment mammillary model presented in Fig. S1. The central compartment ( _V_ 1) represents the blood and highly perfused tissues, while two peripheral compartments ( _V_ 2 _, V_ 3) represent muscle and adipose tissue, respectively. The dynamics are described by: 

**==> picture [359 x 51] intentionally omitted <==**

where _Ai_ denotes the amount of drug in compartment _i_ , _kij_ represents the transfer rate from compartment _i_ to _j_ , and _u_ p _t_ q is the infusion rate. 

To link concentration to clinical effect, e.g., loss of consciousness, an effect-site compartment is added. The effect-site concentration ( _Ce_ ) lags behind the plasma concentration ( _Cp_ “ _A_ 1{ _V_ 1) according to a first-order delay governed by the rate constant _ke_ 0: 

**==> picture [284 x 24] intentionally omitted <==**

The clinical goal is to target a specific effect level, e.g. reduction of brain activity by 50%, by achieving the required concentration at the effect site _Ce_ . 

Propofol is the most widely used intravenous anesthetic agent for the induction and maintenance of general anesthesia. The model of Schnider et al. (1998) parameterizes a three-compartment PK structure using patient covariates such as age, height, weight, and lean body mass. Owing to the practical difficulty of conducting interventional studies in humans, the model was developed from a small cohort of _n_ “ 24 healthy adults. The linear covariate structure fails to capture nonlinear physiological scaling effects, leading to biased predictions, particularly in high body mass index (BMI) and extreme-age regimes. The Eleveld et al. (2018) model is a unified population PK model for Propofol, developed on a much larger cohort ( _n_ “ 1000) spanning wide age and BMI ranges. It uses allometric scaling, maturation functions, and rich covariate effects, yielding improved accuracy across pediatric and adult populations. Accordingly, in this experiment, Eleveld et al. (2018) is used as the generative model, while the Schnider et al. (1998) model serves as simplified prior. 

In modern practice, PK models such as Schnider et al. (1998) are embedded in Target Controlled Infusion (TCI) pumps. The system solves an inverse problem: given a clinician-set target _Ce_ and patient characteristics, the pump computes the required infusion dose, delivered as bolus injections 

13 

A Preprint - February 13, 2026 

**==> picture [469 x 280] intentionally omitted <==**

Figure 4: **Intervention Outcome Prediction Pendulum** : Mean MSE and SEM across 5,000 test samples for different intervention values for all three models as a function of distance from training intervention set (logarithmic scale). 

every several seconds until the total dose is administered. The accuracy of this intervention, and its ability to achieve the anesthetic state without missing the target or overshooting and causing adverse effects, depend critically on the fidelity of the underlying model (Enlund, 2008). Our goal is to compare the mechanistic, hybrid, and fully data-driven models in their ability to function as such controllers to give the correct dosing schedule. 

So far, we used observations with randomly sampled, uncorrelated covariates. In practice, however - especially in healthcare - patient covariates are often correlated through both known and unknown relationships. Therefore, we consider an experimental setting with realistic covariates, along with simulated treatments and outcomes. Specifically, we consider _N_ “ 12 _,_ 155 patients from the MIMIC-IV database (Johnson et al., 2022; Goldberger et al., 2000) who have records of Propofol administration during their admission. For each patient we extract age, sex, weight, height, and a binary indicator of opioid treatment prior to the first record of Propofol. The target concentration at the effectsite, denoted _Ce_[˚][,][is][known][to][be][age][dependent][(Schnider][et][al.,][1999)][and][here][is][simulated][as] _Ce_[˚][p][age][q “][ 4][ ´][ 0] _[.]_[04][p][age][ ´][ 18][q][.][Initial][Propofol][concentrations][are][zero][in][all][compartments.][Infusion] is delivered as a series of 30 mg boluses every 10 seconds until a total dose _D_ is reached. The optimal dose _D_[˚] is chosen by simulating age-dependent candidate doses and selecting the one whose trajectory yields an effect-site concentration closest to _Ce_[˚][.][The][candidate][dose][set][is][weight][dependent][and] is defined as _D_ pweightq “ weight ¨ _d_ , where the normalized dose values _d_ are similar to the FDA 

14 

A Preprint - February 13, 2026 

Propofol guidelines (Food and Administration, April 2017). Specifically, _d_ P t1 _._ 5 _, . . . ,_ 2 _._ 5u[m] kg[g][with] step 0 _._ 1[m] kg[g][for][patients][younger][than][55][and] _[d]_[ P t][1] _[, . . . ,]_[ 1] _[.]_[5][u][m] kg[g][with][step][0] _[.]_[1][m] kg[g][for][patients][aged][55] or older. Ground-truth synthetic trajectories are generated using the oracle model of Eleveld et al. (2018) with _T_ max “ 210 seconds and ∆ _t_ “ 0 _._ 5 seconds. An example of the intervention and resulting trajectories is shown in Fig. S3. We randomly hold out 25% of the data as a test set. In addition, patients with BMI ą 30 or age ą 60 are excluded from the training set and instead form an OOD population used exclusively for testing. Overall, we consider three test groups: in-distribution (held out, but from the same training set distribution); OOD (age ą 60 or BMI ą 30); and extreme OOD (age ą 60 and BMI ą 30). Note that OOD is defined with respect to the training distribution of the neural networks only. The mechanistic model of Schnider et al. (1998) was estimated using _n_ “ 24 patients aged 26–81. 

As the mechanistic model we use the three compartment model, i.e. Eq. (6)-(7), with the parameters of the Schnider et al. (1998) model. In our notation defined in Eq. (4) these are **F** _[ψ] p_[and] **[F]** _[η] p_[,][while] the intervention _u_ p _t_ q is _**η**_ p _t_ q. Due to the model structure, where _A_ 2 and _A_ 3 interact linearly only with _A_ 1 and not with each other, and because the intervention is applied directly at _A_ 1 rather than on the other compartments, we include correction networks only in the _A_ 1 dynamics. This is expected to capture the full correction needed for the plasma concentration _Cp_ . Additionally, we add correction networks to the effect-site concentration _Ce_ . Given its original mechanistic structure, we allow corrections to both the time constant and an additional additive term. Thus, the hybrid components are: 

**==> picture [359 x 81] intentionally omitted <==**

together with the mechanistic _[dA] dt_[2][and] _[dA] dt_[3][.][We][ensure][the][output][of] _[G][np]_[is][positive,][and][p¨q] _[p]_[denotes] the parameteric components. Lastly, the fully data-driven model is as defined in Eq. (1). In our example, t _Fnp[ψ][, F] np[ η][, G][np][, G][ψ] np_[u][and][the][fully][data-driven][model][networks][are][all][MLPs.] 

We train the correction networks by minimizing the MSE reconstruction loss of the predicted plasma ( _Cp_ ) and effect-site ( _Ce_ ) concentrations. Training is done using batches of time windows of 40 seconds. Here, the intervention is sparse and the initial conditions are zero (and do not return to zero within the experiment time frame). Therefore, we ensure that at least 15% of each batch starts at _t_ “ 0, and additional 15% of each batch includes non-zero intervention. The remaining starting points of the windows in the batch are sampled uniformly at random. 

**Results** We assess the clinical utility of the models by evaluating their ability to infer the optimal induction bolus dose. For each test patient, we use each model to generate personlized counterfactual trajectories. We select the normalized dose _d_ that yields an effect-site concentration _Ce_ closest to the target _Ce_[˚][.][For][each][patient,][we][then][compute][the][absolute][percentage][error][(APE)][between][the] 

15 

A Preprint - February 13, 2026 

**==> picture [376 x 322] intentionally omitted <==**

Figure 5: **PK Test Results** : Selected-dose MAPE: mean and SEM over 20 replications for three test groups: In-distribution, OOD (age ą 60 **or** BMI ą 30), and extreme OOD (age ą 60 **and** BMI ą 30). OOD is defined with respect to the networks’ training distribution only. The mechanistic model of Schnider et al. (1998) was estimated using 24 patients aged 26-81. 

selected dose _d_ and the optimal dose _d_[˚] that achieves _Ce_[˚][according][to][the][oracle][model][of][Eleveld] et al. (2018). The mean APE (MAPE) is computed across patients within each distribution group (in-distribution, OOD, and extreme OOD). The training and evaluation procedure is repeated 20 times, and the mean and SEM of the selected dose MAPE across replications are reported in Fig. 5. The fully data-driven model achieves the best performance in-distribution. However, as we move to OOD and extreme OOD settings, the hybrid model exhibits greater robustness, with consistently lower error. The mechanistic model yields the highest error overall, except in the extreme OOD regime, where the fully data-driven model performs worst. 

## **5 Discussion** 

We discuss hybrid mechanistic-data-driven framework for estimating outcomes under predefined, time-dependent interventions in dynamical systems with incomplete mechanistic knowledge. The core modeling idea is representing the transition operator as a mechanistic component plus learned corrections, and we explicitly separate intervention-independent from intervention-dependent effects. 

16 

A Preprint - February 13, 2026 

This decomposition is intended to preserve mechanistic anchors while letting data-driven modules absorb misspecification, focusing on counterfactual prediction. 

The two case studies illustrate the same general template instantiated under different, practically motivated constraints. In the pendulum setting, mechanistic parameters are unobserved. We proposed a two-stage procedure: an encoder is pre-trained on synthetic trajectories generated from the mechanistic prior and then used to infer parameters for the real dataset before learning the corrections. In contrast, in the PK setting the relevant patient characteristics are available, so no parameter inference is needed, and modeling decisions are driven by the mechanistic structure and by the intervention (bolus dosing). Concretely, corrections are applied where they can most directly compensate for known deficiencies (e.g., plasma/effect-site components). In both cases, we demonstrate that the hybrid approach outperforms both the purely data-driven and purely physics-based models, and hybrid modeling is most helpful when extrapolating beyond the training distribution of interventions or covariates - which is inherent in causal inference. 

## **References** 

- Ruth E. Baker, Jose-Maria Peña, Jayaratnam Jayamohan, and Antoine Jérusalem. Mechanistic models versus machine learning, a fight worth fighting for the biological community? _Biology Letters_ , 14(5):20170660, 2018. doi: 10.1098/rsbl.2017.0660. 

- Ioana Bica, Ahmed M. Alaa, and Mihaela Van Der Schaar. Time series deconfounder: estimating treatment effects over time in the presence of hidden confounders. In _Proceedings of the 37th International Conference on Machine Learning_ , ICML’20, 2020. 

- Steven L. Brunton, Joshua L. Proctor, and J. Nathan Kutz. Discovering governing equations from data by sparse identification of nonlinear dynamical systems. _Proceedings of the National Academy of Sciences_ , 113(15):3932–3937, 2016. doi: 10.1073/pnas.1517384113. 

- Ricky T. Q. Chen, Yulia Rubanova, Jesse Bettencourt, and David Duvenaud. Neural ordinary differential equations. In _Proceedings of the 32nd International Conference on Neural Information Processing Systems_ , pages 6572–6583, 2018. doi: 10.5555/3327757.3327764. 

- Kurtland Chua, Roberto Calandra, Rowan McAllister, and Sergey Levine. Deep reinforcement learning in a handful of trials using probabilistic dynamics models. In _Proceedings of the 32nd International Conference on Neural Information Processing Systems_ , NIPS’18, page 4759–4770, 2018. 

- Marc Peter Deisenroth and Carl Edward Rasmussen. Pilco: a model-based and data-efficient approach to policy search. In _Proceedings of the 28th International Conference on International Conference on Machine Learning_ , ICML’11, page 465–472, 2011. 

- D.J. Eleveld, P. Colin, A.R. Absalom, and M.M.R.F. Struys. Pharmacokinetic–pharmacodynamic model for propofol for broad application in anaesthesia and sedation. _British Journal of Anaesthesia_ , 120(5):942–959, 2018. ISSN 0007-0912. doi: 10.1016/j.bja.2018.01.018. 

17 

A Preprint - February 13, 2026 

- Mats Enlund. TCI: Target controlled infusion, or totally confused infusion? call for an optimised population based pharmacokinetic model for propofol. _Upsala journal of medical sciences_ , 113(2): 161–170, 2008. 

- Food and Drug Administration. Diprivan (propofol) injectable emulsion, usp, April 2017. URL `https://www.accessdata.fda.gov/drugsatfda_docs/label/2017/019627s066lbl.pdf` . 

- Ary L. Goldberger, Luis A. N. Amaral, Leon Glass, Jeffrey M. Hausdorff, Plamen Ch. Ivanov, Roger G. Mark, Joseph E. Mietus, George B. Moody, Chung-Kang Peng, and H. Eugene Stanley. PhysioBank, PhysioToolkit, and PhysioNet: Components of a New Research Resource for Complex Physiologic Signals. _Circulation_ , 101(23), June 2000. ISSN 0009-7322, 1524-4539. doi: 10.1161/01.CIR.101.23. e215. 

- Gevik Grigorian, Sandip V. George, Sam Lishak, Rebecca J. Shipley, and Simon Arridge. A hybrid neural ordinary differential equation model of the cardiovascular system. _Journal of The Royal Society Interface_ , 21(212):20230710, 2024. doi: 10.1098/rsif.2023.0710. 

- Alistair Johnson, Lucas Bulgarelli, Tom Pollard, Steven Horng, Leo Anthony Celi, and Roger Mark. MIMIC-IV (version 2.0). _PhysioNet_ , June 2022. doi: https://doi.org/10.13026/7vcr-e114. 

- George Em Karniadakis, Ioannis G. Kevrekidis, Lu Lu, Paris Perdikaris, Sifan Wang, and Liu Yang. Physics-informed machine learning. _Nature Reviews Physics_ , 3:422–440, 2021. doi: 10.1038/ s42254-021-00314-5. 

- Anuj Karpatne, Gowtham Atluri, James H Faghmous, Michael Steinbach, Arindam Banerjee, Auroop Ganguly, Shashi Shekhar, Nagiza Samatova, and Vipin Kumar. Theory-guided data science: A new paradigm for scientific discovery from data. _IEEE Transactions on knowledge and data engineering_ , 29(10):2318–2331, 2017. 

- Patrick Kidger, James Morrill, James Foster, and Terry Lyons. Neural controlled differential equations for irregular time series. In _Proceedings of the 34th International Conference on Neural Information Processing Systems_ , NIPS ’20, 2020. 

- Yunduo Lan, Sung-Young Shin, and Lan K. Nguyen. From shallow to deep: The evolution of machine learning and mechanistic model integration in cancer research. _Current Opinion in Systems Biology_ , 40:100541, 2025. doi: https://doi.org/10.1016/j.coisb.2025.100541. 

- Bryan Lim, Ahmed Alaa, and Mihaela Van Der Schaar. Forecasting treatment responses over time using recurrent marginal structural networks. _Proceedings of the 32nd Conference on Neural Information Processing Systems_ , page 7494–7504, 2018. doi: 10.5555/3327757.3327849. 

- Ori Linial, Neta Ravid, Danny Eytan, and Uri Shalit. Generative ode modeling with known unknowns. In _Proceedings of the Conference on Health, Inference, and Learning_ , CHIL ’21, page 79–94, New York, NY, USA, 2021. Association for Computing Machinery. ISBN 9781450383592. doi: 10.1145/3450439.3451866. 

- Ori Linial, Orly Avner, and Dotan Di Castro. Confide: Contextual finite difference modelling of pdes. In _Proceedings of the 30th ACM SIGKDD Conference on Knowledge Discovery and Data Mining_ , 

18 

A Preprint - February 13, 2026 

KDD ’24, page 1839–1850, New York, NY, USA, 2024. Association for Computing Machinery. ISBN 9798400704901. doi: 10.1145/3637528.3671676. 

- Judith J. Lok. Statistical modeling of causal effects in continuous time. _The Annals of Statistics_ , 36 (3):1464–1507, 2008. doi: 10.1214/009053607000000820. 

- Bernardo Maestrini, Gordan Mimić, Pepijn A.J. van Oort, Keiji Jindo, Sanja Brdar, Ioannis N. Athanasiadis, and Frits K. van Evert. Mixing process-based and data-driven approaches in yield prediction. _European Journal of Agronomy_ , 139:126569, 2022. doi: 10.1016/j.eja.2022.126569. 

- Andrew C. Miller, Nicholas J. Foti, and Emily B. Fox. Breiman’s two cultures: You don’t have to choose sides. _Observational Studies_ , 7(1):161–169, 2021. doi: 10.1353/obs.2021.0003. 

- Ben Noordijk, Monica L. Garcia Gomez, Kirsten H. W. J. ten Tusscher, Dick de Ridder, Aalt D. J. van Dijk, and Robert W. Smith. The rise of scientific machine learning: a perspective on combining mechanistic modelling with machine learning for systems biology. _Frontiers in Systems Biology_ , 4, 2024. doi: 10.3389/fsysb.2024.1407994. 

- Christopher Rackauckas, Yingbo Ma, Julius Martensen, Collin Warner, Kirill Zubov, Rohit Supekar, Dominic Skinner, Ali Ramadhan, and Alan Edelman. Universal differential equations for scientific machine learning. _arXiv_ , 2020. doi: 10.21203/rs.3.rs-55125/v1. 

- Maziar Raissi, Paris Perdikaris, and George E. Karniadakis. Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations. _Journal of Computational Physics_ , 378:686–707, 2019. doi: 10.1016/j.jcp.2018.10.045. 

- Yulia Rubanova, Ricky T. Q. Chen, and David K Duvenaud. Latent ordinary differential equations for irregularly-sampled time series. In _Advances in Neural Information Processing Systems_ , volume 32. Curran Associates, Inc., 2019. 

- Thomas W Schnider, Charles F Minto, Steven L Shafer, Pedro L Gambus, Corina Andresen, David B Goodale, and Elizabeth J Youngs. The influence of age on propofol pharmacodynamics. _Anesthesiology_ , 90(6):1502–1516, 1999. 

- T.W. Schnider, C. F. Minto, P. L. Gambus, and et al. The influence of method of administration and covariates on the pharmacokinetics of propofol in adult volunteers. _Anesthesiology_ , 88(5):1170–1182, 1998. doi: 10.1097/00000542-199805000-00006. 

- Peter Schulam and Suchi Saria. Reliable decision support using counterfactual models. In _Proceedings of the 31st International Conference on Neural Information Processing Systems_ , NIPS’17, page 1696–1706, Red Hook, NY, USA, 2017. Curran Associates Inc. ISBN 9781510860964. 

- Bernhard Schölkopf, Francesco Locatello, Stefan Bauer, Nan Rosemary Ke, Nal Kalchbrenner, Anirudh Goyal, and Yoshua Bengio. Toward causal representation learning. _Proceedings of the IEEE_ , 109 (5):612–634, 2021. doi: 10.1109/JPROC.2021.3058954. 

- Hossein Soleimani, Adarsh Subbaswamy, and Suchi Saria. Treatment-response models for counterfactual reasoning with continuous-time, continuous-valued interventions, 2017. URL `https: //arxiv.org/abs/1704.02038` . 

19 

A Preprint - February 13, 2026 

- Naoya Takeishi and Alexandros Kalousis. Physics-integrated variational autoencoders for robust and interpretable generative modeling. In _Proceedings of the 35th International Conference on Neural Information Processing Systems_ , NeurIPS ’21, Red Hook, NY, USA, 2021. Curran Associates Inc. 

- Neta Tannenbaum, Omer Gottesman, Azadeh Assadi, Mjaye Mazwi, Uri Shalit, and Danny Eytan. icvs - inferring cardio-vascular hidden states from physiological signals available at the bedside. _PLoS Computational Biology_ , 19(9):e1010835, 2023. doi: 10.1371/journal.pcbi.1010835. 

- Laura von Rueden, Sebastian Mayer, Katharina Beckh, Bogdan Georgiev, Sven Giesselbach, Raoul Heese, Birgit Kirsch, Julius Pfrommer, Annika Pick, Rajkumar Ramamurthy, Michal Walczak, Jochen Garcke, Christian Bauckhage, and Jannis Schuecker. Informed machine learning – a taxonomy and survey of integrating prior knowledge into learning systems. _IEEE Transactions on Knowledge and Data Engineering_ , 35(1):614–633, 2023. doi: 10.1109/TKDE.2021.3079836. 

- Jared Willard, Xiaowei Jia, Shaoming Xu, Michael Steinbach, and Vipin Kumar. Integrating scientific knowledge with machine learning for engineering and environmental systems. _ACM Comput. Surv._ , 55(4), 2022. doi: 10.1145/3514228. 

- Hongqi Xue, Arun Kumar, and Hulin Wu. Parameter estimation for semiparametric ordinary differential equation models. _Communications in Statistics – Theory and Methods_ , 48(24):5985– 6004, 2019. doi: 10.1080/03610926.2018.1523433. 

20 

A Preprint - February 13, 2026 

## **A Pendulum Experiments - Additional Details** 

This appendix provides additional details on the model architectures and training procedures for all models used in the experiments. 

## **A.1 Physics Only / Encoder Architecture and Training** 

The encoder estimates the physical parameters of the mass pendulum dynamics _β_ “ p _m, lcm_ q from a trajectory with a given intervention t _θi_ p _t_ q _, ωi_ p _t_ q _, τ_ extp _t_ qu. 

The network architecture is a fully connected stack with: 

- Batch normalization of the flattened input, 

- Linear layer p _T_ enc _d_ q Ñ _H_ , batch normalization, ReLU, 

- Two additional hidden linear layers of size _H_ Ñ _H_ with batch normalization, ReLU, 

- Linear layer _H_ Ñ _H_ {2 with batch normalization, ReLU, 

- p 

- • Linear output layer p _H_ {2q Ñ 2 producing p _m,_[p] _lcm_ q. 

The hidden dimension was set to _H_ “ 128. 

For training the encoder we used the synthetic simulated data generated as described in Section 4.1, together with labels corresponding to the true physical parameters _β_ “ p _m, L_ q for each sample. The dataset is randomly split into 80% training and 20% validation sets. The encoder is trained using the Adam optimizer with learning rate 10[´][3] , batch size _B_ “ 256, weight decay 10[´][5] , and mean-squared error loss 

**==> picture [112 x 32] intentionally omitted <==**

We employ a learning-rate reduction on plateau with mode=’min’, factor=0.5, patience=5, and early stopping with tolerance tol “ 10[´][4] over 25 epochs. 

## **A.2 Multilayer Perceptron** 

Multilayer perceptron (MLP) networks are used for both the hybrid correction networks and the data-driven model. Each residual block consists of a sequence of LayerNorm, linear layers (from hidden dimension to hidden dimension), and Tanh activations. The output of each block is added to the input via a skip connection. The MLP architecture includes a linear projection from the input dimension to the hidden dimension, followed by a sequence of _r_ residual blocks, a final normalization layer, and an output projection layer. 

21 

A Preprint - February 13, 2026 

## **A.3 Data-Driven Neural ODE** 

The data-driven Neural ODE is composed of two MLPs: one for _[dθ] dt_[and][one][for] _[dω] dt_[,][with][a][hidden] dimension of _d_ “ 128, _r_ “ 6 residual blocks, and Xavier initialization with gain “ 1. 

For trajectory reconstruction, we use `odeint` with the `RK4` method. Training minimizes the trajectory prediction error: 

**==> picture [328 x 30] intentionally omitted <==**

using the following Neural-ODE training configuration: batch size 64, learning rate 10[´][3] , and early stopping after 12 epochs with no improvement in validation performance. 

## **A.4 Hybrid Mechanistic-Data-Driven Model** 

The hybrid model augments the mechanistic pendulum equations with learned residual corrections and uses the encoder to estimate p _m, lcm_ q. The nonparametric correction components are MLP networks with hidden dimension of _d_ “ 64, _r_ “ 4 residual blocks, and Xavier initialization with gain “ 0 _._ 3. The model is trained to minimize the trajectory reconstruction loss described in Eq. (9) using the Adam optimizer with a learning rate of 2 ˆ 10[´][4] , a batch size of 64, and early stopping after 12 epochs with no improvement in validation performance. 

22 

A Preprint - February 13, 2026 

## **B Pharmacokinetics Experiment** 

## **B.1 Models** 

## **B.1.1 Mechanistic Baseline Schnider et al. (1998)** 

In this experiment, patient’s parameters are given in the data. Thus no encoder is required. The mechanistic baseline uses the Schnider et al. (1998) model parameters. This model is known to have limitations in obese populations due to its reliance on the James equation for Lean Body Mass (LBM), which can produce inaccurate results at high BMIs. 

## **B.1.2 Hybrid Model (Schnider + Learned Residual)** 

The hybrid model augments the Schnider et al. (1998) mechanistic structure with MLP neural correction networks with hidden dimension of _d_ “ 64, _r_ “ 4 residual blocks, and Xavier initialization with gain “ 0 _._ 2. 

## **B.1.3 Data-driven Neural ODE** 

The fully data-driven baseline utilizes a 2-state formulation ( _Cp, Ce_ ), learning the dynamics via two separate MLP networks with _d_ “ 64, _r_ “ 4 residual blocks, and Xavier initialization with gain “ 1. 

## **B.2 Training and Evaluation Protocol** 

To balance the contributions of plasma ( _Cp_ ) and effect-site ( _Ce_ ) concentrations, we use a relative Mean Squared Error (MSE) normalized by clinically relevant thresholds: 

**==> picture [370 x 25] intentionally omitted <==**

where 25 _._ 0 _µ_ g/mL is the safety limit for _Cp_ and 3 _._ 5 _µ_ g/mL is the typical target for _Ce_ . Training is performed using random 40-second windows (80 timesteps). We set number of training epochs to 100, batch size to 32, and learning rate to 10[´][3] 

Models are evaluated on their ability to select an optimal induction bolus. The selection criteria are prioritized as follows: 

1. **Safety:** _Cp_ ă 25 _._ 0 _µ_ g/mL. 

2. **Target Achievement:** Reach _Ce,_ goalpageq. 

3. **Precision:** Minimize | maxp _Ce_ p _t_ qq ´ _Ce_[˚][|][.] 

Performance is quantified using Median Absolute Performance Error (MDAPE): 

**==> picture [289 x 25] intentionally omitted <==**

23 

A Preprint - February 13, 2026 

## **C Practical Considerations and Design Choices** 

In this appendix, we describe the technical and methodological lessons learned during the construction and training of hybrid mechanistic-data-driven networks for intervention outcome prediction. 

## **C.1 Architectural Considerations** 

In developing hybrid models for time-series intervention outcome prediction, beyond the architecture presented in the paper, we identified additional principles to consider: 

- **When are hybrid models most beneficial:** Hybrid models operate within a specific “grey area" of knowledge. If mechanistic knowledge is too poor, requiring massive corrections, a **fully data-driven** approach may perform better by avoiding the bias of incorrect priors. Conversely, if the physics is already well-described, adding data-driven components may introduce noise and harm prediction. The hybrid approach is most beneficial when there is relevant but incomplete working knowledge that can be refined to present a full picture. 

- **Efficiency of Simple Architectures:** Despite the complexity of the underlying physics, Multi-Layer Perceptrons (MLPs) proved to be simple yet powerful tools for predicting required corrections. When conditioned on the current state and the known mechanistic parameters, MLPs effectively captured degrees of freedom which were missing in the simplified physical model. 

## **C.2 Training Procedure** 

During the training procedure, additional considerations should be taken into account: 

## **C.2.1 Window-Based Training** 

Training the model on sub-sequences (windows) instead of full trajectories proved essential for the convergence. Shorter windows minimize the requirement for long-range extrapolation during the early stages of training, reduce the computational overhead associated with numerical integration, and reduce the chance of convergence to an average constant. However, the following considerations should be taken into account: 

- **Intervention Sparsity:** Because interventions are often sparse (e.g., discrete bolus doses), a multiplicative correction is multiplied by zero most of the time. This leads to “dead” gradients, making it challenging for the intervention-dependent network to learn. We address this issue through batch composition, ensuring that each batch contains a certain proportion of nonzero interventions. 

- **Zero Initial Conditions:** Initial conditions are sometimes zero before interventions and do not return to zero afterward. When using window-based training, if the starting point is sampled uniformly over the time grid, zero initial conditions are almost never selected. As a 

24 

A Preprint - February 13, 2026 

result, zero initial conditions become effectively OOD, leading to large inference-time errors, since such conditions are rarely observed during training. We address this issue by enriching each batch with at least a certain proportion of samples that start from zero initial conditions. 

- **Time constant:** In our pendulum example, where the dynamics are cyclic, small windows were sufficient to capture the governing laws. In our PK example, however, longer windows were required to capture the physical changes and train thecorrection networks. The known physics can be used for selecting an appropriate window size. 

## **C.2.2 Initialization and Balancing** 

Lastly, we highlight additional design choices that facilitated the convergence of the correction networks: 

- **Weight Initialization:** We found it helpful to start with a small non-zero initialization for the correction networks (using a non-default gain hyper-parameter). This allows the mechanistic model to lead the initial training phase while the ML component gradually introduces corrections. 

- **Balance Hyper-parameters:** A dedicated weight hyper-parameter was used to balance the initial contribution of the physics-based components and the corrections, which was helpful for achieving convergence. 

25 

A Preprint - February 13, 2026 

**==> picture [469 x 286] intentionally omitted <==**

**----- Start of picture text -----**<br>
Drug Input<br>u(t)<br>k k<br>12 13<br>V2 V1 V3<br>Peripheral  Central  Peripheral<br>Compartment Compartment Compartment<br>k k<br>21 31<br>k<br>1e<br>k<br>10<br>k<br>e0<br>Effect Site<br>**----- End of picture text -----**<br>


Figure S1: Three Compartments Pharmacokinetics Model. 

26 

A Preprint - February 13, 2026 

**==> picture [469 x 546] intentionally omitted <==**

Figure S2: Prediction examples of pendulum dynamics. 

27 

A Preprint - February 13, 2026 

**==> picture [468 x 466] intentionally omitted <==**

Figure S3: Optimal Dose Selection Simulation. 

28 

A Preprint - February 13, 2026 

**==> picture [469 x 562] intentionally omitted <==**

Figure S4: Prediction example of propofol pharmacokinetics dynamics. 

29 

