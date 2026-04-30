---
source_url: 
ingested: 2026-04-29
sha256: b40937970770ad7d5cfcb2719905044a921754144424684d303de9b68937c1c6
---

1 

# BRAIN: Bayesian Reasoning via Active Inference for Agentic and Embodied Intelligence in Mobile Networks 

Osman Tugay Basaran, _Student Member, IEEE_ , Martin Maier, and Falko Dressler, _Fellow, IEEE_ 

_**Abstract**_ **—Future sixth-generation (6G) mobile networks will demand artificial intelligence (AI) agents that are not only autonomous and efficient, but also capable of real-time adaptation in dynamic environments and transparent in their decisionmaking. However, prevailing agentic AI approaches in networking, exhibit significant shortcomings in this regard. Conventional deep reinforcement learning (DRL)-based agents lack explainability and often suffer from brittle adaptation, including catastrophic forgetting of past knowledge under non-stationary conditions. In this paper, we propose an alternative solution for these challenges: Bayesian reasoning via Active Inference (** **`BRAIN` ) agent.** **`BRAIN` harnesses a deep generative model of the network environment and minimizes variational free energy to unify perception and action in a single closed-loop paradigm. We implement** **`BRAIN` as O-RAN eXtended application (xApp) on GPU-accelerated testbed and demonstrate its advantages over standard DRL baselines. In our experiments,** **`BRAIN` exhibits** _**(i)**_ **robust** _**causal reasoning**_ **for dynamic radio resource allocation, maintaining slice-specific quality of service (QoS) targets (throughput, latency, reliability) under varying traffic loads,** _**(ii)**_ **superior adaptability with up to 28.3% higher robustness to sudden traffic shifts versus benchmarks (achieved without any retraining), and** _**(iii)**_ **real-time** _**interpretability**_ **of its decisions through human-interpretable belief state diagnostics.** 

_**Index Terms**_ **—Active inference, Embodied-AI, mobile networks, trustworthiness, 6G.** 

## I. INTRODUCTION 

Artificial intelligence (AI) has achieved remarkable advances in recent years, from mastering complex games and control tasks with reinforcement learning (RL) to producing human-like content with large language models (LLMs) and Generative AI. These achievements, however, remain largely _disembodied_ ; models operate in simulated or data-driven domains without direct physical grounding. LLMs, for example, excel at pattern recognition and generation from static datasets but cannot interact with a changing environment. Similarly, deep reinforcement learning (DRL) agents typically train in carefully crafted simulations with fixed reward functions, and they often struggle when faced with real-world dynamics outside their training distribution. In essence, today’s AI systems lack the holistic, adaptive intelligence of an embodied agent that can continually perceive, act, and learn in the real world [1]. 

O.T. Basaran and Falko Dressler are with the School of Electrical Engineering and Computer Science, TU Berlin, Berlin, 10587, Germany. E-mail: basaran@ccs-labs.org, dressler@ccs-labs.org 

Martin Maier is with Optical Zeitgeist Laboratory, INRS, Montreal, QC H5A 1K6, Canada. E-mail: martin.maier@inrs.ca 

This work has been funded by the Federal Ministry of Research, Technology and Space (BMFTR, Germany) as part of the technology transfer hub for the medicine and mobility of the future xG-RIC. 

This gap becomes especially critical in the context of emerging sixth-generation (6G) and beyond networks [2]. These future networks are expected to connect tens of billions of devices and support unprecedented services with stringent performance demands, necessitating _AI-native_ design principles that tightly integrate learning and control intelligence into the infrastructure [2, 3]. The wireless environment is inherently complex and _non-stationary_ : channel conditions, user mobility, and traffic patterns fluctuate constantly [4]. Moreover, 6G must cater to a diverse array of quality of service (QoS)/quality of experience (QoE) requirements across use cases [5]. Yet, most “AI-enabled” networking solutions to date simply apply offthe-shelf deep learning models (e.g., convolutional networks [6] or deep autoencoders [7]) to specific tasks, without fundamentally rethinking the network’s cognitive architecture [8]. While these models can learn mappings from historical data, they often fail to generalize when network conditions deviate from the training set. RL introduces a degree of agency by enabling AI to learn through direct interaction with the environment [9]. Indeed, DRL-based implementations have shown promise in wireless domains, tackling problems from dynamic spectrum allocation and power control to handoff optimization and end-to-end network slicing [10–12]. However, conventional DRL solutions suffer from two major shortcomings that limit their suitability as the “brains” of an autonomous 6G network. First, DRL policies are typically realized by deep neural networks that act as opaque _black boxes_ [13]. Second, standard DRL has very limited adaptability to changing conditions [14]. Once a DRL agent is trained for a given environment or traffic scenario, it tends to _overfit_ to those conditions. Neural policies are prone to _catastrophic forgetting_ : when learning or fine-tuning on new data, they overwrite previously learned behaviors [4]. Figure 1 illustrates this challenge in a network slicing scenario: a baseline DRL agent quickly “forgets” how to serve an enhanced mobile broadband (eMBB) slice once it has adapted to an ultra-reliable low-latency communication (URLLC) slice, and so on, necessitating expensive relearning for each recurrence of prior conditions. 

These limitations point to the need for a fundamental reimagining of network AI. There is a growing consensus that next-generation networks should incorporate higher-level cognitive capabilities; integrating elements of memory, perception, and reasoning rather than relying solely on low-level pattern recognition [8, 15]. In essence, AI agents in such a system are no longer just offline models, but active participants in the physical network environment. This agentic vision naturally leads to _active inference as a promising next step for network intelligence._ Active inference has been described as an ideal framework for realizing such embodied AI, as it 

2 

**==> picture [253 x 233] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.25 P1<br>0.20 P2<br>P3<br>0.15<br>0.10<br>0.05<br>0.00<br>6 4 2 0 2 4 6<br>x<br>(a) Data distribution shifts during learning.<br>Data DistributionPerformance Learning P3<br>Learning P2<br>P1<br>Forgetting: Retrain! Forgetting: Retrain!<br>T0 T1 T2 T3 T4 T5<br>Time<br>(b) Catastrophic forgetting.<br>f)(x<br>Train Episodic Pattern<br>**----- End of picture text -----**<br>


Fig. 1. Preliminary experiment on catastrophic forgetting issue for DRL agent in network slicing. (a) Sequential distribution shifts: DRL agent trains initially on Slice 1 (eMBB, green), then shifts to Slice 2 (URLLC, red), and finally Slice 3 (mMTC, blue), each with distinct QoS requirements and traffic patterns. (b) The impact of distribution shifts on performance. Initially, at _⃝_ 1 the agent learns Slice 1 effectively. When data distribution transitions at _⃝_ 2 to Slice 2, the agent learns new policies while starting to forget previously acquired knowledge (Slice 1). At _⃝_ 3 , another shift to Slice 3 occurs, further reducing performance on previously learned Slices 1 and 2. Eventually, at _⃝_ 4 , the scenario cycles back, requiring costly retraining due to performance degradation caused by catastrophic forgetting. 

biomimics how natural intelligent systems learn and adapt via an action–perception loop grounded in the free energy principle [16]. Originally developed in cognitive neuroscience [17], active inference offers a unified theory of perception, learning, and action based on Bayesian reasoning. In contrast to conventional RL, an active inference agent does not rely on hand-crafted reward signals; instead, it maintains an internal _generative model_ of its environment and desired outcomes. The agent constantly updates its beliefs about the hidden state of the world (perception) and selects actions to fulfill its goals by minimizing _variational free energy_ ; a measure of prediction error or “surprise” between the agent’s expectations and its observations. In essence, the agent tries to anticipate what should happen (given its model and goals) and then acts to make reality align with those expectations, thereby reducing surprise. 

In this paper, we introduce an explainable deep active inference agent for mobile network resource management on AI-RAN testbed. This work is a detailed and expanded version of a workshop paper currently under review. Beyond the original core concept, we _i)_ broaden the experimental depth with additional advanced agent baselines and detailed ablations, _ii)_ add a controlled non-stationarity stress test across _all_ agents to quantify robustness and recovery, and _iii)_ include policy-entropy analysis to make explorationexploitation dynamics comparable across DRL and active inference, alongside expanded sections and discussions. We call our framework `BRAIN` ( **B** ayesian **R** easoning via **A** ctive 

**==> picture [252 x 109] intentionally omitted <==**

**----- Start of picture text -----**<br>
Agent<br>Generative Model<br>Probability of<br>Agent outcome prior beliefs<br>Observation<br>True state<br>Generative Process<br>Environment<br>Environment<br>(a) Traditional DRL Agent. (b) Our BRAIN Agent.<br>Reward Action<br>State<br>**----- End of picture text -----**<br>


Fig. 2. Architecture of conventional DRL and proposed explainable deep active inference agents. 

**IN** ference), envisioning it as the “telecom brain” of an AInative RAN controller. Figure 2 contrasts the paradigm of a conventional DRL agent with that of our proposed `BRAIN` agent. The `BRAIN` architecture employs a deep generative active inference model to design the relationship between latent network states (e.g., congestion levels, channel conditions, user mobility) and observed performance metrics, while also encoding desired outcomes (e.g., slice-specific QoS targets) as prior beliefs. At each control interval, the agent performs active inference by minimizing variational free energy: it infers the most probable current network state (perception step) and then computes the optimal resource allocation action (action step) that will drive the network’s predicted performance closer to the target (i.e., correcting the deviation between expected and desired outcomes). This cycle of inference and action effectively allows `BRAIN` to carry out online learning and control simultaneously. Unlike a DRL agent, which would require retraining whenever the environment changes, `BRAIN` continuously _updates its beliefs in real time_ as new observations arrive, endowing it with a form of lifelong learning that gracefully handles distribution shifts. Moreover, because our agent’s internal computations revolve around probabilistic beliefs and free-energy contributions, we can tap into these intermediate results to understand and explain its behavior. 

The core outcomes of our study are summarized as new contributions (“C”) and new findings (“F”) as follows: 

- **C1.** We introduce `BRAIN` , the first deep active-inference agent for AI-RAN closed-loop RAN slicing in O-RAN. 

- **C2.** We designed `BRAIN` agent intrinsically explainable by exposing posterior beliefs over latent slice conditions and an expected free energy (EFE) decomposition that justifies each action in terms of goal alignment (extrinsic) and uncertainty reduction (epistemic). 

- **F1.** In dynamic slicing experiments, `BRAIN` demonstrates continual adaptation to non-stationary conditions. `BRAIN` more reliably maintains heterogeneous slice intents under dynamic loads. 

- **F2.** Unlike black-box DRL, `BRAIN` exposes interpretable internal variables, enabling _causal_ and auditable explanations for resource-allocation decisions. 

## II. RELATED WORK 

This section situates `BRAIN` within three complementary research threads that underpin agentic intelligence in mobile 

3 

networking. First, we review how RL/DRL has been operationalized for network control and orchestration, particularly in open radio access network (O-RAN) and slicing, as the dominant agentic paradigm in practice. Second, we summarize explainability efforts in wireless AI, including explainable artificial intelligence (XAI) and emerging explainable reinforcement learning (XRL) approaches, highlighting the extent to which interpretability is typically introduced _post hoc_ rather than being intrinsic to the decision process. Third, we discuss active inference as an embodied intelligence framework that unifies perception and action through probabilistic generative modeling and variational inference, and we identify the limited evidence to date on deploying _deep_ active inference with operator-facing explanations in communications systems. Together, these bodies of work clarify the methodological gap addressed by our approach: an _intrinsically interpretable, continually adaptive agent_ for real-time mobile network control. 

**RL on Mobile Networks.** RL as well as DRL models have been increasingly adopted for dynamic resource management and control tasks in wireless networks. Liu _et al._ [11] propose OnSlicing, an online DRL framework for endto-end network slicing across RAN, transport, core, and edge domains. ORANSlice [12], an open source, modular platform for 5G network slicing tailored to the O-RAN ecosystem. It integrates slice lifecycle management, resource orchestration, monitoring, and analytics within a flexible framework. While RL policies can yield remarkable efficiency gains, their opaque nature often manifested as “black-box” neural networks hinders understanding and debugging, limiting practical deployment. Therefore, recent research has begun to explore XRL methodologies to improve transparency by explicitly elucidating policy decisions and learned behaviors. 

**XAI on Mobile Networks.** To overcome the transparency problem, researchers have turned to XAI techniques [18, 19] in the mobile networking domain [20]. In recent years, several works have explored using popular XAI methods (e.g., SHAP [21] and LIME [22]) to interpret complex models for wireless network tasks [23–25]. While useful, such generic XAI approaches have proven insufficient for the needs of mobile networks. They provide only superficial insight and often struggle with the temporal and high-dimensional nature of network data. Recognizing these gaps, some studies have begun to pursue domain-specific XAI and inherently interpretable models for wireless communications. Researchers introduced custom time-series explainers for network traffic models, which track how feature importance evolves over time and identify anomalous patterns leading to errors [26, 27]. In general, these efforts underline that explainability in wireless AI may require expert-driven designs to meet the reliability and insight demands of network operations. It is worth noting that XRL is also gaining traction in other fields (like robotics and autonomous systems), aiming to extract human-comprehensible policies from RL agents. However, in the wireless networking literature, explainable RL or DRL has seen very limited exploration so far. One notable approach is SYMBXRL [28], which introduces a symbolic explanation layer on top of black-box DRL models. In this framework, a symbolic representation generator converts numerical state 

and action variables into discrete first-order logic predicates. In contrast, our proposed framework adopts a fundamentally different paradigm by embedding explainability directly within the agent’s generative and inferential processes. Therefore, there remains a significant need for new methods that can interpret and justify the actions of different learning agents. 

**Active Inference.** In recent years, it has been applied in engineering domains, showing promise for state estimation, planning, and control under uncertainty [29]. These early studies suggest that active inference can serve as a flexible, biologically inspired approach to sequential decision-making, distinct from reinforcement learning [30]. Note that RL formalisms for adaptive decision-making in unknown environments are subsumed by active inference. Researchers have applied active inference to robot control tasks, where the agent’s generative model enables it to handle ambiguous sensory inputs and still pursue goal-directed behavior [31, 32]. An intriguing aspect of active inference is its potential for built-in explainability, though this aspect has yet to be concretely validated [16, 33]. 

## III. PROBLEM FORMULATION FOR AGENTIC AI DESIGN 

## _A. Reinforcement Learning_ 

We model the closed-loop RAN slicing control problem as a sequential decision-making task under uncertainty, which can be formulated as a Markov decision process (MDP). The agent in our scenario is the Near-RT RIC control eXtended application (xApp), and the environment consists of the gNB and its slices (eMBB, URLLC, massive machine-yype communications (mMTC)) along with their traffic and radio conditions. At each discrete control interval _t_ , the environment is in some state _st_ that captures the current slice performance, _st_ can be defined to include each slice’s downlink throughput, buffer occupancy, and transmitted transport block count (as obtained from O-RAN key performance measurement (KPM) reports). The agent observes this state (or an observation derived from it) and then selects an action _at_ from its action space. In our use case, the action _at_ consists of setting the fraction of physical resource blocks (PRBs) allocated to each slice and choosing a scheduling policy (e.g., PF, RR, WFQ) for each slice’s traffic. After the agent’s decision is applied, the environment transitions to a new state _st_ +1 according to the network dynamics (influenced by the agent’s action and external factors such as user traffic and channel variability), and the agent receives a numerical reward _rt_ +1 reflecting the outcome. 

The reward function _R_ ( _st, at, st_ +1) is designed to quantify how well the slice-specific QoS objectives are met at time _t_ . In particular, we assign positive reward for high eMBB throughput, negative reward for large URLLC buffer occupancy (penalizing latency), and positive reward for successful mMTC transmissions. Selected formulation is to define the immediate reward as a weighted sum of key performance metrics for the slices: 

**==> picture [245 x 32] intentionally omitted <==**

4 

where throughput[(] _t_ +1[eMBB][)] is the eMBB slice downlink data rate at time _t_ +1, buffer[(] _t_ +1[URLLC][)] is the URLLC slice’s queue length (a proxy for its latency), TBcount[(] _t_ +1[mMTC][)] is the number of transport blocks successfully delivered for the mMTC slice, and _α, β, γ_ are weighting coefficients reflecting the priority of each slice’s KPI. This reward design encourages the agent to maximize eMBB throughput, minimize URLLC queuing delay, and ensure reliable mMTC delivery, in line with the slices’ requirements. 

The agent’s goal in RL is to learn an optimal policy _π[∗]_ that maximizes the expected cumulative discounted reward. Starting from state _st_ , the objective (also called return) can be written as: 

**==> picture [190 x 31] intentionally omitted <==**

with _γ ∈_ [0 _,_ 1) denoting a discount factor that prioritizes immediate rewards over future rewards. By maximizing this return, the RL agent attempts to jointly satisfy the slices’ performance objectives over time (e.g., sustaining high throughput for eMBB, low latency for URLLC, and robust throughput for mMTC) even as network conditions evolve. 

It is worth noting that the agent does not have direct access to all underlying network information (such as exact channel conditions or future traffic arrivals); it relies on the observed slice metrics as its state representation. In other words, the environment is partially observable from the agent’s perspective. We can view the problem as a partially observable Markov decision process (POMDP), where the O-RAN KPM reports constitute the observation _ot_ that provides a noisy, partial view of the true state _st_ . In our design, we assume these reported metrics are a sufficient statistic of the network’s condition, and the agent (potentially using function approximation or recurrent networks) can internally maintain any additional state context needed. 

## _B. Active Inference_ 

Active inference is a novel decision-making paradigm stemming from cognitive neuroscience that offers a unified approach to action and perception under uncertainty [34]. Instead of learning a policy purely from external reward feedback, an active inference agent leverages an internal generative model of its environment and acts so as to minimize the “surprise” (prediction error) of its observations. In our scenario, this means the agent (our `BRAIN` xApp) is designed with prior expectations about the RAN slicing system; for example, that the URLLC slice’s buffer should remain low (to indicate low latency) and the eMBB slice’s throughput should be high. The agent then continuously adjusts its actions to align the observed slice performance with these internal expectations, thereby reducing unexpected deviations from desired behavior. 

Mathematically, active inference casts the problem of closed-loop control as a variational inference process. The agent possesses a probabilistic _generative model_ of the RAN environment and treats the true network state as a latent (hid- 

den) variable to be inferred. We can formalize this generative model over a time horizon _T_ by the joint distribution: 

**==> picture [246 x 39] intentionally omitted <==**

where _st_ represents the hidden state of the network at time _t_ and _ot_ is the observation (slice performance metrics) at time _t_ . Here _P_ ( _s_ 0) is the prior distribution over the initial state, _P_ ( _st | st−_ 1 _, at−_ 1) is the state transition model encoding the dynamics of the slices (how the true state evolves given the previous state and control action), and _P_ ( _ot | st_ ) is the observation likelihood model (mapping the hidden state to the probability of seeing a particular set of KPM observations). In our context, _st_ may encompass the underlying radio and traffic conditions for each slice (e.g., actual backlog, channel quality, etc.), while _ot_ includes the reported throughput, buffer occupancy, and TB count for each slice. The agent never directly observes _st_ ; instead it receives _ot_ and must infer _st_ from these measurements. 

To enable principled inference, the agent maintains an approximate posterior belief _q_ ( _st_ ) over the hidden state and refines this belief with each new observation. The quality of the agent’s belief relative to the true state is quantified by the _variational free energy_ (VFE) [35]: 

**==> picture [221 x 19] intentionally omitted <==**

which measures how “surprising” the observation _ot_ is under the agent’s current belief (it can be viewed as the negative evidence lower bound for the model). By minimizing _F_ with respect to _q_ ( _st_ ), the agent updates its posterior to better explain the observed data; in effect, performing a Bayesian update to reduce prediction error. This continual belief update (often implemented via gradient descent or closed-form Bayesian filtering) corresponds to the perception phase of active inference: the xApp assimilates the latest KPM measurements and adjusts its internal state estimate so that its predictions about slice performance become more accurate. 

What truly distinguishes active inference from passive inference schemes is that the agent also _acts_ to minimize expected future surprise. In other words, beyond updating its beliefs, the agent plans and takes actions that it expects will lead to observations aligning with its preferences (and reducing uncertainty). This is formalized through the EFE of a policy _π_ . A policy _π_ = _{at, at_ +1 _, . . . , at_ + _H }_ is a sequence of future actions of length _H_ (the planning horizon). The EFE for such a policy can be expressed as: 

**==> picture [251 x 28] intentionally omitted <==**

where _o>t_ and _s>t_ denote the future observations and states from time _t_ + 1 up to _T_ (under the hypothesis that policy _π_ is executed). Intuitively, _G_ ( _π_ ) predicts how much “surprise” would be encountered if the agent were to follow policy _π_ . Policies that are expected to produce observations close to the agent’s preferred outcomes (and that reduce uncertainty about the state) will have lower _G_ ( _π_ ). Thus, the action selection rule in active inference is to choose the policy (or action, 

5 

in a look-ahead setting) that minimizes _G_ ( _π_ ). In our RAN slicing use case, this means the agent will favor actions that it believes will drive the slice metrics towards their ideal ranges; keeping the URLLC buffer near empty and the eMBB throughput high; while also gathering information to improve its state estimates when needed. In effect, the agent balances exploitation and exploration automatically: actions are chosen both to fulfill slice QoS goals (according to the agent’s internal goal preferences) and to resolve significant uncertainties (if the agent is unsure about some aspect of the network state). 

## Generative Model 

**1 States (** _S_ **):** Hidden state variables _s ∈ S_ representing the true underlying condition of the RAN slices. This can include factors like actual traffic load and channel quality for each slice, which are not directly observed but influence performance. The hidden state at time _t_ mediates the generation of observations _ot_ . **2 Observations (** _O_ **):** Measurable outputs _o ∈ O_ that the agent can perceive from the environment. In our case, these are the slice-level KPMs (throughput, buffer occupancy, TB count per slice) reported at each control interval. In a fully observable setting one might have _ot_ = _st_ , but here _ot_ provides a partial, noisy view of _st_ . **3 Actions (** _U_ **):** Control inputs _u ∈ U_ that the `BRAIN` agent can take to influence the state. For the slicing scenario, an action defines how resources are allocated to slices (PRB fractions) and which scheduling policy is applied, thereby affecting how the state _s_ evolves (e.g., altering how quickly a slice’s queue is drained or how throughput is shared). **4 Observation Model (** _A_ **):** The probabilistic mapping from states to observations. _A_ specifies the likelihood of each possible observation given a state, _Ao,s_ = _P_ ( _o | s_ ). In our model, _A_ captures how a particular network state (with certain true throughput demand, backlog, channel conditions, etc.) would probabilistically produce the observed KPM metrics. This includes any measurement noise or uncertainty in observation. **5 Transition Model (** _B_ **):** The state transition dynamics under actions. _B_ is defined such that _Bs_[(] _[u][′] ,s_[)][=] _[P]_[(] _[s][t]_[=] _[s][′][|][s][t][−]_[1][=] _[s,][u][t][−]_[1][=] _[u]_[)][,] describing the probability of the state moving from _s_ to _s[′]_ given that action _u_ was taken. In the RAN slicing context, _B_ encodes the effect of control actions on the network state. 

In summary, our active inference-based controller continuously updates its internal model of the RAN slices and selects resource control actions that minimize the expected free energy. This leads to a closed-loop behavior wherein the agent seeks to make its observations unsurprising by ensuring slice performance meets the target objectives. Notably, this framework naturally handles partial observability (treating the true network conditions as latent variables to be inferred) and accommodates multiple slice objectives through built-in preference encoding (each slice’s QoS target is reflected in 

the agent’s model as a preferred outcome). The result is a principled control strategy that, unlike standard RL, does not require an externally defined reward function for each scenario but rather emerges from the agent’s intrinsic drive to minimize prediction error and uphold its modeled service goals. 

## IV. EXPLAINABLE DEEP ACTIVE INFERENCE DESIGN 

## _A. Generative Model Design_ 

At the core of our framework is a generative model that describes the network slicing environment without hierarchical abstractions. We define a set of hidden state variables _st_ that characterize the real-time status of the network and its slices at time _t_ . _st_ include latent features such as per-slice traffic load, channel quality indicators, or queue lengths for each network slice. The agent receives observations _ot_ (e.g., measured throughput, latency, or slice performance metrics) that are probabilistically generated from the hidden state. The agent can also perform actions _at_ (or controls) corresponding to slice resource allocation decisions. Without loss of generality, we refer to scenarios such as distributing a limited pool of PRB among slices or selecting scheduling policies for each slice, as typically encountered in O-RAN systems. In Algorithm 1, `BRAIN` ’s generative model is expressed as a joint distribution over states, observations, and actions across time, _P_ ( _s_ 0: _T , o_ 0: _T , a_ 0: _T_ ), which factorizes into dynamical and observational components: 

**==> picture [224 x 45] intentionally omitted <==**

## _B. Variational Inference and Policy Selection via Free Energy Minimization_ 

_Perception as Variational Inference:_ Upon receiving new observation _ot_ (e.g., current slice throughput levels), the agent must infer the latent state _st_ (e.g., actual demand or user load causing those throughput levels). `BRAIN` performs this by minimizing the variational free energy _Ft_ , which serves as a proxy for Bayesian inference. We define the free energy at time _t_ as: 

**==> picture [210 x 26] intentionally omitted <==**

where H[ _Q_ ] is the entropy of the approximate posterior _Q_ . Intuitively, minimizing _Ft_ encourages the posterior _Q_ ( _st_ ) to explain the observation well (high likelihood _P_ ( _ot | st_ )) while staying close to the prior prediction _P_ ( _st | st−_ 1 _, at−_ 1) (which is the generative model’s forecast from the previous time, ensuring temporal consistency). In practice, we assume a tractable form for _Q_ ( _st_ ) (i.e., Gaussian distribution or delta at a point estimate) and perform a gradient-based update (or closed-form update if linear-Gaussian) to find _Q[∗]_ ( _st_ ) _≈ P_ ( _st | o≤t, a<t_ ). This posterior belief _Q_ ( _st_ ) encapsulates the agent’s current understanding of network conditions after seeing the data. Notably, because the generative model is explicit, this belief is fully transparent: each variable in _st_ (say, 

6 

**Algorithm 1:** Proposed `BRAIN` Agent 

- **Input:** Generative model _P_ ( _st_ +1 _, ot_ +1 _| st, at_ ); Preference distribution _P_ pref( _o_ ); Action set _A_ ; Time horizon _T_ ; Prior belief _Q_ ( _s_ 0). 

- **Output:** Selected action sequence _{a_ 0 _, a_ 1 _, . . . , aT −_ 1 _}_ ; Logged beliefs and free-energy terms for explainability. 

- Initialize _Q_ ( _s_ 0) (prior belief over states) **for** _t ←_ 0 **to** _T −_ 1 **do** _ot ←_ observe new data from environment // Receive observation _ot_ (e.g., 

- current network slice metrics) 

- _Q_ ( _st_ ) _←_ BayesianUpdate( _Q_ ( _st−_ 1) _, ot_ ) // Update posterior state belief 

- given _ot_ 

- // Belief update yields _Q_ ( _st_ ) **foreach** _at ∈A_ **do** Compute _Q_ ( _ot_ +1 _| at_ ) using generative model // Predict observation 

- distribution if action _at_ is taken 

   - KLpref _← D_ KL _Q_ ( _ot_ +1 _| at_ ) _P_ pref( _ot_ +1) � ��� � 

   - // Divergence from preferred 

   - outcomes (extrinsic term) 

   - _I_ gain _← I_ ( _st_ +1; _ot_ +1 _| at_ ) // Expected information gain 

   - (epistemic term) 

   - _G_ ( _at_ ) _←_ KLpref _− I_ gain // Expected free energy _G_ ( _at_ ) 

   - _a[∗] t[←]_[arg min] _[a] t[∈A][G]_[(] _[a][t]_[)] // Select action that minimizes 

   - expected free energy 

   - Execute _a[∗] t_[on][environment] // Apply chosen action (Adjust 

   - network slice resources) 

   - Log _Q_ ( _st_ ), _{G_ ( _a_ ) : _a ∈A}_ , and _a[∗] t_[for][analysis] // Record beliefs and free-energy 

   - terms for explainability 

the estimated load on slice 1) has a quantitative posterior that can be reported or visualized. The ability to inspect _Q_ ( _st_ ) at any time means that the agent’s situational awareness is interpretable and auditable. 

## _C. Action Selection as Expected Free Energy Minimization_ 

After updating its beliefs, the agent must decide on the next action _at_ (e.g., how to reallocate resources among slices) before the next observation arrives. Instead of using a learned Q-value or policy network as in RL, `BRAIN` evaluates prospective actions by their expected free energy _G_ ( _π_ ), where _π_ denotes a candidate policy (a sequence of future actions, or simply the single action _at_ in a one-step horizon case). The agent chooses the policy that minimizes _G_ ( _π_ ), reflecting the principle of active inference: actions are chosen to minimize 

expected surprise and fulfill preferences. We formulate _G_ ( _π_ ) (for simplicity, with a one-step horizon _π_ = _at_ ) as: 

**==> picture [228 x 40] intentionally omitted <==**

where the expectation is taken with respect to the predicted next-state distribution under action _at_ , and inside we consider two quantities for the next time step _t_ + 1: 

- _⃝_ 1 Expected “Surprise” w.r.t Preferences: _−_ ln _P_ ( _ot_ +1 _| C_ ) is the surprisal (negative log-probability) of a future observation _ot_ +1 under the preference model. If an action is likely to produce outcomes aligned with _C_ (e.g., all slices meet their targets), this term will be low; if the action would result in poor performance for some slice, yielding an observation far from the preferred range, this term will be high. Thus, the expected value E[ _−_ ln _P_ ( _ot_ +1 _| C_ )] serves as a risk or phenotypic cost for that action. 

- _⃝_ 2 Expected Information Gain (Epistemic Value): The second term DKL[ _Q_ ( _st_ +1 _| ot_ +1) _|Q_ ( _st_ +1)] is the KL divergence between the posterior and prior predicted state at _t_ +1, which quantifies how much we expect to learn about the hidden state by observing _ot_ +1. Equivalently, it can be expressed as the mutual information _I_ [ _st_ +1; _ot_ +1] between state and observation under that action. An action that is expected to resolve uncertainty (e.g., probing an uncertain slice’s condition by allocating it resources to see if throughput improves) will have a high information gain, reducing _G_ . This corresponds to the perceptual ambiguity term in active inference, encouraging exploratory actions that reduce uncertainty. 

## _D. Introspective Explainability of Decisions_ 

At each time _t_ , the `BRAIN` agent maintains a posterior belief distribution over the latent slice states _st_ (e.g., each slice’s current demand level or reliability). We denote this belief as: 

**==> picture [185 x 11] intentionally omitted <==**

with the probability of each hidden state given all past observations _o_ 1: _t_ and actions _a_ 1: _t−_ 1. In practice, _Q_ ( _st_ ) is computed via the agent’s variational Bayes update after receiving observation _ot_ . For example, if slice demand can be high or low, _Q_ ( _st_ ) might be a probability _P_ ( _st_ = high) or _P_ ( _st_ = low) that is updated as new traffic measurements come in. These posterior beliefs are introspective variables because they represent the agent’s internal knowledge about the network (and can be exposed for explainability). The distribution _Q_ ( _st_ ) is normalized and reflects the agent’s confidence in different slice conditions at time _t_ . 

The agent encodes prior preferences about desirable outcomes for the network slices. Let _P_ pref ( _o_ ) denote the preferred distribution over observations (or performance metrics). _P_ pref ( _o_ ) could assign high probability to outcomes where each slice’s throughput or latency meets its target. At each decision step, the agent predicts the distribution of next observations _Q_ ( _ot_ +1 _| at_ ) for a candidate action _at_ (by marginalizing over its state beliefs). We define a preference alignment cost as 

7 

**==> picture [227 x 151] intentionally omitted <==**

Fig. 3. Overview of GPU-Accelerated Testbed. 

the Kullback–Leibler (KL) divergence between the predicted outcome distribution and the preferred distribution. Formally, for action _at_ : 

**==> picture [204 x 50] intentionally omitted <==**

This term measures how well the agent’s expected observations align with its preferences (a form of phenotypic risk). A lower KL value means the predicted network performance under action _at_ is closer to the ideal (preferences), indicating good extrinsic alignment with the slice QoS goals. A high value indicates a misalignment; particularly the agent expects outcomes (like a slice throughput shortfall) that deviate from what is desired. Minimizing this term drives the agent to choose actions that fulfill slice requirements (extrinsic reward-seeking behavior). In parallel, the agent quantifies the epistemic value of actions, i.e., the expected information gain about the latent slice states. This captures the action’s exploratory benefit: how much taking action _at_ will reduce uncertainty in _st_ +1. Mathematically, we can define the epistemic value as the mutual information between future states and observations, conditioned on _at_ . One convenient form is the expected reduction in entropy of the state-belief after observing _ot_ +1: 

**==> picture [213 x 34] intentionally omitted <==**

where _H_ [ _Q_ ( _s_ )] = _−_[�] _s[Q]_[(] _[s]_[) ln] _[ Q]_[(] _[s]_[)][is][the][entropy.][Intu-] itively, _H_ [ _Q_ ( _st_ +1 _| at_ )] is the agent’s prior uncertainty about the next state before taking action _at_ , and the second term is the expected posterior uncertainty after seeing the new observation. Their difference is the expected information gain. If action _at_ is purely informational (i.e., a probing action that reveals a slice’s condition), this quantity will be high, meaning the agent anticipates learning a lot (large epistemic value). If an action is not informative, i.e., it does not affect observations, the epistemic value is low. In many active inference formulations, this corresponds to reducing _perceptual ambiguity_ . 

## V. EXPERIMENT DESIGN 

## _A. GPU-Accelerated AI-RAN Testbed_ 

We deploy a private 5G testbed (see Figure 3) featuring a GPU-accelerated O-RAN architecture built on the NVIDIA Aerial Research Cloud (ARC) platform [36, 37] and Aerial SDK [38]. In our setup, the gNB’s protocol stack is split into an O-DU Low (Layer-1 PHY) running on an NVIDIA GPU and an O-DU High/CU (higher layer protocols) running on _x_ 86 CPUs with OpenAirInterface (OAI) [39]. The two halves communicate via the Small Cell Forum’s FAPI interface, enabling inline acceleration of PHY-layer DSP tasks on the GPU while maintaining a standard OAI software stack for MAC/RLC/PDCP/RRC. Foxconn O-RU [40] operating in the n78 TDD band (mid-band FR1) provides the radio front-end, connected over a standard O-RAN 7.2 fronthaul interface. This O-RU supports a 100 MHz channel bandwidth (273 PRBs at 30 kHz subcarrier spacing) in TDD mode, with a TDD pattern configured according to 3GPP Release 15 specifications (e.g., DDDSU slots). The testbed is equipped with both commercial and softwarized UEs to generate multislice traffic. In particular, we use a COTS 5G UE (Sierra Wireless EM9191 modem module) and an OAI-based soft UE (nrUE) as two end devices. 

The Sierra Wireless EM9191 provides a real 5G NR user equipment that connects over-the-air to the gNB. The OAI nrUE is a software UE stack (also running on a server with an SDR front-end) that emulates a second 5G UE, allowing finegrained control of its traffic and slicing configuration. Both UEs support establishing multiple PDU sessions concurrently, which we map to different network slices (as described next). 

## _B. Use Case: Intelligent Orchestration_ 

We consider a multi-slice RAN scenario where an intelligent xApp is deployed as an autonomous agent for closed-loop slice resource orchestration. O-RAN near-RT RIC hosts our `BRAIN` xApp, which observes network state and dynamically controls a gNB serving multiple slices. In our setup, a single 100 MHz cell (one O-RU/gNB) serves two UEs with three slice types; eMBB, URLLC, and massive mMTC each with distinct QoS requirements (high throughput for eMBB, low latency for URLLC, high reliability for mMTC). The gNB’s MAC is sliceaware, maintaining separate buffers and scheduler queues per slice, and the UEs generate traffic for their respective slices (e.g., one UE carries a video stream on eMBB and a realtime control flow on URLLC via separate PDU sessions, while the other carries sporadic IoT telemetry on mMTC). This forms a rich environment for the xApp agent to orchestrate intelligently. 

The `BRAIN` xApp continuously monitors slice performance via the O-RAN E2 interface. A lightweight KPM monitor xApp streams real-time telemetry [41]; such as slice-specific downlink throughput, buffer occupancy (queue length), and downlink transport block count into the RIC’s data layer (using the standard O-RAN KPM service model). These metrics, shown in prior work [42] to effectively capture slice traffic demand and QoS conditions, constitute the state _s_ that our agent observes. At each control interval (on the order of tens of 

8 

**==> picture [516 x 223] intentionally omitted <==**

**----- Start of picture text -----**<br>
500400 2.52.0 BRAINA2CDQNREINFORCE Tuned HeuristicPPOSAC 2.52.0 BRAIN Tuned HeuristicA2CPPO DQN SACREINFORCE<br>300 1.5 1.5<br>200 1.0 1.0<br>BRAIN A2C<br>100 Tuned Heuristic PPO 0.5 0.5<br>DQN REINFORCE<br>SAC<br>0 0 2000 4000 6000 8000 10000 12000 14000 0.0 0 2000 4000 6000 8000 10000 12000 14000 0.0 0 2000 4000 6000 8000 10000 12000 14000<br>Episode Episode Episode<br>(a) Mean cumulative reward. (b) Average loss (stability). (c) Policy entropy.<br>Fig. 4. Training dynamics of agentic (RL/DRL) and embodied (active-inference) Agents on AI-RAN testbed: i) Mean cumulative reward per episode (higher<br>is better), showing convergence speed and asymptotic control performance.  ii)  Average training loss (lower is better), used as a stability proxy for optimization<br>dynamics during online learning. iii) Policy entropy (higher indicates more exploration), capturing the exploration-exploitation evolution over training.<br>Check Check Check Check Check Check<br>1.0 1.0 1.0<br>High High High<br>Medium 0.5 Medium 0.5 Medium 0.5<br>Low Low Low<br>0.0 0.0 0.0<br>0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100 0 10 20 30 40 50 60 70 80 90 100<br>Time Step Time Step Time Step<br>(a) Belief State H. - eMBB Slice . (b) Belief State H.- URLLC Slice . (c) Belief State H. - mMTC Slice .<br>Mean Reward Average Loss Policy Entropy<br>Demand State Belief Probability Demand State Belief Probability Demand State Belief Probability<br>**----- End of picture text -----**<br>


Fig. 5. Agent’s posterior belief trajectory over hidden traffic demand levels ( `Low` , `Medium` , `High` ) for each network slice across episodes. Time on the x-axis indexes discrete decision epochs (e.g., observation-update intervals _×_ 10[3] ), and the y-axis enumerates the three demand states ( `Low` at bottom to `High` at top). Color encodes the belief probability _Q_ ( _st_ ) ( _brighter/yellow = higher, darker/purple = lower_ ). White arrows mark the agent’s explicit information-gathering `Check` actions. 

**==> picture [516 x 84] intentionally omitted <==**

**----- Start of picture text -----**<br>
2.00 Extrinsic (Preference Cost) 1.61.4 Extrinsic (Preference Cost) 3.0 Extrinsic (Preference Cost)<br>1.751.501.25 Epistemic (Information Gain) 1.21.0 Epistemic (Information Gain) 2.52.0 Epistemic (Information Gain)<br>1.00 0.8 1.5<br>0.75 0.6 1.0<br>0.50 0.4<br>0.25 0.2 0.5<br>0.00 0.0 0.0<br>0 500 1000 1500 2000 2500 0 500 1000 1500 2000 2500 0 500 1000 1500 2000 2500<br>Time Step Time Step Time Step<br>(a) EFE Components - eMBB Slice . (b) EFE Components - URLLC Slice . (c) EFE Components - mMTC Slice .<br>Expected Free En. Expected Free En. Expected Free En.<br>**----- End of picture text -----**<br>


Fig. 6. Interpretation of the EFE ( _G_ ( _π_ )) decomposition. At each time step, the chosen action’s epistemic (soft green) and extrinsic (soft red) terms presented. Epistemic value dominates early on (favoring exploration) and then gives way to extrinsic value (favoring QoS/exploitation). 

TABLE I 

HYPERPARAMETERS OF BASELINE RL MODELS. 

|Model|Learning|Discount|Replay|
|---|---|---|---|
||R.|F.|Buffer|
|Deep Q-Network (DQN)<br>Actor-Critic (A2C)<br>Policy Gradient (REINFORCE)<br>Proximal Policy Opt. (PPO)|1_×_10_−_3<br>1_×_10_−_3<br>5_×_10_−_4<br>5_×_10_−_4|0.99<br>0.99<br>0.99<br>0.99|105 exp.<br>on-policy<br>on-policy<br>on-policy|
|Soft Actor-Critic (SAC)|1_×_10_−_3|0.99|105 exp.|



milliseconds), `BRAIN` computes an action _a_ to adjust the RAN slicing policy. The action space includes tuning the PRB allocation fraction for each slice (partitioning the cell’s bandwidth among eMBB/URLLC/mMTC) and selecting the scheduling algorithm per slice (e.g., proportional fair, round-robin, or weighted fair queueing). These commands are dispatched to the gNB via an O-RAN E2 control message (using a custom control service model aligning with O-RAN specifications), thereby closing the control loop. In this agentic deployment, the xApp autonomously adapts network parameters in real time to satisfy slice service-level objectives. 

Slice-specific QoS priorities are encoded into the agent’s reward (or utility) function to drive its behavior. In our design, the eMBB slice is throughput-oriented (the agent rewards high 

eMBB data rates), the URLLC slice is latency-sensitive (the agent penalizes large URLLC buffer occupancy to minimize queuing delay), and the mMTC slice is reliability-focused (the agent rewards successful delivery of mMTC transport blocks, which correlates with reliable coverage for sporadic IoT traffic). Guided by these objectives, the `BRAIN` xApp can, for example, allocate extra PRBs to URLLC during congestion to promptly drain its queue, or switch the mMTC slice’s scheduler to a more opportunistic mode when sporadic uplink packets arrive. The constantly updated KPM state from the monitor xApp allows `BRAIN` to verify if slice performance indicators are being met and react quickly if not. 

## _C. Baseline Agents and Training Methodology_ 

**Tuning Baseline Agents.** To evaluate our `BRAIN` agent, we compare it against a broader suite of baseline agents, including both learned policies and a heuristic scheduler. Specifically, we implement: **1** _Tuned Heuristic_ that statically partitions PRBs among slices (according to fixed priority weights) and uses a weighted round-robin scheduler (a nonlearning baseline), **2** Deep Q-Network (DQN) agent for slice control [43], **3** Advantage Actor-Critic (A2C) agent [44], **4** Vanilla Policy Gradient agent (REINFORCE [45]), 

9 

**==> picture [516 x 140] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.0 1.0 1.0<br>BRAIN BRAIN BRAIN<br>A2C A2C A2C<br>0.8 DQN 0.8 DQN 0.8 DQN<br>REINFORCE REINFORCE REINFORCE<br>Tuned Heuristic Tuned Heuristic Tuned Heuristic<br>0.6 PPO 0.6 PPO 0.6 PPO<br>SAC SAC SAC<br>0.4 0.4 0.4<br>Better Better Better<br>0.2 0.2 0.2<br>0.0 0.0 0.0<br>3.0 3.2 3.4 3.6 3.8 4.0 4.2 4.4 0.5 0.6 0.7 0.8 0.9 1.0 0 20 40 60 80 100 120 140<br>Throughput [Mbps] PRB ratio PHY TBs [tb/s]<br>(a) eMBB Slice . (b) URLLC Slice . (c) mMTC Slice .<br>CDF CDF CDF<br>**----- End of picture text -----**<br>


Fig. 7. Comparative network slicing performance of the proposed `BRAIN` agent against a broader set of baselines: Tuned Heuristic (weighted round-robin), and DRL agents DQN, A2C (AC), REINFORCE (PG), PPO, and SAC, evaluated across three heterogeneous network slices under the same state/action interface for a fair comparison. 

> **5** Proximal Policy Optimization (PPO) agent [46], and **6** Soft Actor-Critic (SAC) agent [47]. All learning-based xApps observe the same state (slice KPM metrics) and produce the same type of actions (PRB allocations and scheduler choices) as `BRAIN` , ensuring a fair comparison. For fairness, we also give each RL agent a comparable model architecture (a 5-layer fully-connected neural network with _∼_ 30 neurons per layer) and tune their hyperparameters accordingly (see Table I). In particular, all use a discount factor _γ_ = 0 _._ 99 and learning rates on the order of 10 _[−]_[3] , with on-policy methods (A2C, REINFORCE, PPO) relying on fresh trajectory rollouts and off-policy methods (DQN, SAC) utilizing experience replay buffers. All custom agents are implemented in PyTorch and deployed as containerized xApps, making them compatible with the O-RAN near-RT RIC platform. We train each agent through direct interaction with our RAN testbed in an online learning fashion (agentic xApps continuously updates its policy as it receives new observations and rewards). To ensure a fair evaluation, every learning agent is trained for the same number of time steps (on the order of 10[5] environment interactions, which equates to several hours of network time at a 20 ms control interval). We repeat each training experiment across multiple random seeds (e.g., 5 independent runs per agent) and report the mean performance with 95% confidence intervals to account for stochastic variability. We compare both convergence speed in terms of training iterations and actual wall-clock time, since on-policy methods like PPO require more interactions but less computation per step, whereas offpolicy methods like SAC can learn from fewer interactions at the cost of more intensive updates. 

**Tranining.** To characterize the _exploration-exploitation_ behavior of all controllers with a common scalar, we report _policy entropy_ over training time. For each episode, we compute the Shannon entropy of the _action-selection distribution_ used to generate decisions at each time step and average it across the episode: 

**==> picture [190 x 56] intentionally omitted <==**

**==> picture [215 x 106] intentionally omitted <==**

**----- Start of picture text -----**<br>
9<br>8<br>7<br>6<br>5<br>BRAIN Tuned Heuristic<br>4 A2C PPO<br>3 DQNREINFORCE SAC<br>0.0 0.2 0.4 0.6 0.8 1.0<br>Time Step ×10 [6]<br>QoS Satis.<br>**----- End of picture text -----**<br>


Fig. 8. Resilience to a controlled non-stationarity event (traffic distribution shift) measured via all-slices QoS satisfaction. The vertical dashed line at time step 0 _._ 5 _x_ 10[6] marks the non-stationary event traffic surge. 

where _A_ denotes the (discrete) action space and _pt_ ( _a_ ) is the probability of selecting action _a_ at time step _t_ . For comparability across methods, we compute entropy over the same action abstraction used by the xApps, i.e., the joint decision over PRB allocation templates and scheduler choices. 

For or on-policy methods, the action-selection distribution is the learned stochastic policy, hence _pt_ ( _a_ ) = _πθ_ ( _a | st_ ). We compute _Ht_ directly from the categorical action probabilities output by the actor network at each time step and then average over the rollout trajectory within the episode using (13). This measure is consistent with the entropy quantities commonly used for entropy regularization in on-policy RL, and it captures how quickly the learned policy collapses from broad exploration (high entropy) to confident decisions (lower entropy) during training. For SAC, the action-selection distribution is also the learned stochastic actor, i.e., _pt_ ( _a_ ) = _πθ_ ( _a | st_ ). We compute entropy from the actor distribution at each time step and average per episode. Because SAC explicitly optimizes an entropy-regularized objective, its entropy often remains higher for longer than standard on-policy methods, reflecting sustained stochasticity in the learned control policy even after rewards stabilize. 

DQN does not parameterize an explicit stochastic policy; it learns action-values _Qθ_ ( _s, a_ ). To enable a meaningful entropy comparison, we define _pt_ ( _a_ ) as the _behavior policy_ used to select actions during training. With _ϵ_ -greedy exploration, this 

10 

distribution is: 

**==> picture [240 x 22] intentionally omitted <==**

and the corresponding entropy is computed via (12)–(13). This yields an episode-wise entropy curve that reflects the exploration schedule (e.g., annealing _ϵt_ ) and the induced concentration of behavior on the greedy action over time. The tuned heuristic applies a deterministic rule (static PRB partitioning with weighted round-robin scheduling). Consequently, the induced action-selection distribution is approximately a point mass and its entropy is near zero, serving as a reference that highlights the absence of learned exploration in the nonlearning baseline. 

For `BRAIN` , we define policy entropy using the posterior distribution over actions inferred from EFE. At each time step, `BRAIN` evaluates the EFE _G_ ( _a | st_ ) for each candidate action and forms an action posterior: 

**==> picture [258 x 34] intentionally omitted <==**

where _γ_ is a precision (inverse-temperature) parameter controlling decisiveness. We then set _pt_ ( _a_ ) = _qt_ ( _a_ ) and compute _Ht_ and _H_[¯] ep using (12)-(13). This entropy has a principled interpretation in active inference: it quantifies uncertainty in the inferred control decision given the agent’s beliefs and preferences, and it typically decreases as the posterior sharpens with experience (without necessarily collapsing to zero if stochasticity is retained for robustness). In addition to overall performance, we design experiments to probe each controller’s adaptability and robustness. We introduce controlled nonstationary during training/deployment. For instance, a sudden change in traffic intensity or a switch in channel conditions partway through an experiment to evaluate how quickly each agent re-adjusts to new network dynamics. This tests for resilience to changing conditions and potential _catastrophic forgetting_ in the RL baselines (i.e., whether a policy trained under one traffic profile fails when the profile shifts). We also conduct sensitivity analyses on key parameters of our `BRAIN` agent, including the slice preference model and reward weighting (extrinsic QoS objectives vs. epistemic exploration bonus), the planning horizon length used in its decisionmaking, and the level of observation noise in the state input. By varying these factors, we assess how robust the agent’s performance is to mis-specified preferences or uncertainty. 

## VI. EVALUATION 

**Analyzing Performance of Intelligent Agents.** Fig. 4 summarizes the training performance of the `BRAIN` agent versus a tuned heuristic baseline and various DRL agents (A2C, PPO, DQN, SAC, REINFORCE) in AI-RAN testbed. In Fig. 4a, `BRAIN` agent’s reward curve climbs steeply, converging in far fewer episodes and reaching a higher asymptotic reward than all baselines (including the tuned heuristic). This indicates that `BRAIN` learns an effective policy with significantly higher sample efficiency; extracting more cumulative reward from limited interactions. By contrast, the DRL agents exhibit slower reward growth and lower plateaus, reflecting the heavy 

trial-and-error search typical of model-free RL. Faster reward convergence means BRAIN can attain near-optimal control decisions with much less training data than the DRL benchmarks which is a critical advantage in real-world networks where each training episode (e.g. a timeslot of suboptimal decisions) has tangible costs. Fig. 4b plots the average training loss, where again `BRAIN` distinguishes itself with a markedly lower and more stable loss trajectory throughout training. `BRAIN` agent’s loss remains near an order of magnitude lower than the deep RL agents’ losses and shows minimal oscillation. This stability indicates that `BRAIN` ’s learning updates are well-behaved, preventing the large gradient swings or divergence issues that often plague DRL training. In contrast, the RL baselines (especially more volatile ones like DQN or REINFORCE) exhibit higher loss values with noticeable fluctuations, signaling less stable learning. Such instability in RL can arise from the algorithms struggling to adjust to the RAN’s non-stationary dynamics: when the environment’s “rules” (e.g. user load, channel conditions) change continually, a conventional RL agent has trouble re-using prior knowledge and may need to relearn repeatedly. Fig. 4 illustrates the policy entropy over time, shedding light on each agent’s exploration–exploitation balance. `BRAIN` ’s entropy starts high (encouraging exploration) and then declines gradually as training progresses. Importantly, it never collapses to zero; instead, `BRAIN` ’s entropy tapers to a moderate level, indicating a controlled exploration strategy. This steady entropy reduction suggests `BRAIN` is systematically exploring the action space early on and then confidently exploiting its learned policy as it converges, all without prematurely losing diversity in its decisions. 

**Explainability Analysis.** We model each slice’s demand as a hidden state ( `Low` / `Medium` / `High` ) and visualize the agent’s posterior belief over time as heatmaps in Fig. 5. In the `eMBB Slice` (Fig. 5a), the agent quickly concentrates its belief on the `High` demand state (bright band in the top row) once high traffic is observed. Around _t ≈_ 40, the underlying demand drops and the belief becomes less concentrated, spreading across states before refocusing on `Medium` . After the arrowlabeled `Check` actions, the belief sharpens again and returns to `High` by _t ≈_ 70. This matches the intuition that the agent becomes more certain when informative observations arrive (a single dominant bright band) and remains more uncertain otherwise (belief distributed across multiple states). In Fig. 5b, the posterior initially alternates mainly between `High` and `Low` , reflecting ambiguity in early observations. At _t ≈_ 30, a demand shift drives rapid belief concentration toward `Low` . Following the epistemic `Check` at _t ≈_ 60, the belief becomes more peaked and consolidates strongly on `Medium` demand. In Fig. 5c, the agent begins with low uncertainty, confidently focusing on `Low` . After `Check` at _t ≈_ 20, the belief shifts decisively toward `High` . Around _t ≈_ 50, changing conditions increase uncertainty (belief spreads across states) before gradually concentrating toward the `Medium` state by _t ≈_ 70. 

In Fig. 6a for the `eMBB Slice` , we observe that the epistemic value dominates in the early phase, where the green area is most prominent. This indicates that the agent is initially 

11 

exploring uncertain aspects of `eMBB` traffic demands, likely performing observation-driven or probing actions to refine its internal beliefs about bandwidth requirements. Over time, the epistemic term steadily declines, while the extrinsic cost increases. This transition reflects that the agent has gained enough confidence in its beliefs and begins to shift toward exploitative behavior, focusing on aligning slice resource allocations with performance preferences. In Fig. 6b for the `URLLC Slice` , a slightly different pattern emerges. The epistemic and extrinsic components are more balanced during the early stages, implying that the agent simultaneously explores and regulates `URLLC` ’s latency-critical requirements. This behavior reflects the tight QoS constraints of `URLLC` , which necessitate that even early decisions consider extrinsic risks. In Fig. 6c for `mMTC Slice` , we see the strongest and longest-lasting epistemic engagement. The green region dominates the first half of the plot, suggesting that the agent initially dedicates extensive exploration effort to understand `mMTC` ’s demand dynamics, which are likely bursty and sparse in nature. After _t_ = 2000, a sharp increase in extrinsic value occurs as the agent begins enforcing goal-directed behavior. 

**Slicing Performance.** Fig. 7 reports _per-slice empirical CDFs_ of KPMs for the three heterogeneous slices, measured on the AI-RAN testbed under the same state/action interface for all agents. Using CDFs (rather than only means) is important because it exposes _tail behavior_ and reliability: a right-shift of the CDF indicates that an agent achieves larger KPM values more frequently `("Better` _→_ `")` , while a steeper CDF indicates reduced variability (more predictable operation). Fig. 7a shows that `BRAIN` yields the most favorable throughput distribution; relative to all DRL baselines and the tuned heuristic, indicating higher throughput across essentially the entire operating range. Qualitatively, `BRAIN` improves not only the median throughput but also the upper quantiles, suggesting that the agent learns a slicing policy that preserves eMBB capacity even while meeting stricter URLLC/mMTC requirements. In contrast, baselines exhibit either _i)_ lower medians or _ii)_ larger dispersion, implying less consistent eMBB service under the same traffic mix and control budget. Fig. 7b reports the distribution of the URLLC PRB ratio (i.e., the fraction of physical resources effectively assigned/available to URLLC by the slicing and scheduling decisions). Higher URLLC PRB-ratio CDF reflects stronger _resource protection_ for URLLC, which is consistent with meeting latency-sensitive objectives under congestion. `BRAIN` exhibits the most right-shifted curve, indicating that it allocates/maintains higher URLLC resource shares more reliably when needed. This behavior aligns with the embodied activeinference design: the agent’s action posterior (formed via EFE) naturally increases precision toward URLLC-protective actions when beliefs indicate rising queue pressure, rather than relying on brittle reward shaping or episodic retraining. Several DRL baselines (notably REINFORCE and the tuned heuristic) show substantially more mass at lower PRB ratios, which typically corresponds to periods where URLLC is under-provisioned and thus more vulnerable to queue buildup and latency violations. Fig. 7c compares the distribution of delivered downlink PHY TBs for the mMTC slice, which we 

use as a reliability-oriented proxy in our setup (successful TB deliveries reflect sustained service for sporadic IoT/telemetry traffic). `BRAIN` provides a modest but consistent for the TB distribution versus DRL baselines, suggesting improved reliability _without_ sacrificing eMBB throughput or URLLC protection. Importantly, the low-performance tail is reduced: `BRAIN` yields fewer ”near-starvation” intervals (very low TB rates), which is critical for mMTC where sporadic bursts must still be delivered predictably. 

Beyond average reward, we evaluate whether controllers _maintain slice-specific service guarantees_ under distribution shifts. Concretely, we measure how reliably each agent keeps all slices within their QoS targets before and after a controlled non-stationarity event. In Fig. 8, before the non-stationarity event ( _k_ shift _≈_ 0 _._ 5 _×_ 10[6] ), `BRAIN` achieves the highest all-slices QoS satisfaction, indicating it most consistently keeps _all_ slice constraints within target under the nominal regime. At _k_ shift, all learning-based agents exhibit an abrupt drop in QoS Sat( _t_ ) due to the traffic surge; however, `BRAIN` shows the _smallest degradation_ and the _fastest recovery_ toward its pre-shift level. In contrast, DRL baselines suffer a larger post-shift drop and recover more slowly, stabilizing at lower QoS-satisfaction levels; consistent with reduced adaptability and partial forgetting under distribution shift. The tuned heuristic remains largely flat and well below the learned agents throughout, confirming that static slicing policies cannot react to sudden regime changes. 

## VII. CONCLUSION 

This work demonstrates that _deep active inference_ is not only a conceptual fit for agentic and embodied intelligence in mobile networks, but also a practical control paradigm on a real open AI-RAN stack. We introduced `BRAIN` as an xApp that closes the network action–perception loop through two tightly coupled operations: (i) _Bayesian belief updating_ over latent slice conditions from streaming KPMs, and (ii) _expected free-energy minimization_ to select resource-allocation actions that jointly satisfy slice intents and reduce uncertainty. Across a GPU-accelerated AI-RAN testbed with heterogeneous slices, `BRAIN` yielded three concrete outcomes. First, it achieved stronger slicing performance than a tuned heuristic and a broad set of DRL baselines. Second, it provided robust adaptation under non-stationarity: when the traffic distribution shifted abruptly, `BRAIN` exhibited the smallest QoSsatisfaction degradation and the fastest recovery without retraining. Third, it delivered _operator-facing interpretability at runtime_ . Beyond the empirical advantage, the broader insight is that active inference enables genuinely agentic, embodied control by grounding decisions in principled Bayesian belief updating rather than reward engineering. 

For future work, promising directions include extending the framework to hierarchical, multi-timescale active inference in O-RAN, where near-RT xApps operate under non-RT intent and policy coordination using structured generative models. Another important research can be to scale to multi-cell and multi-agent deployments, enabling coordination among xApps under interference and mobility coupling and studying distributed belief sharing under realistic telemetry and fronthaul constraints. 

12 

## REFERENCES 

- [1] H. Liu, D. Guo, and A. Cangelosi, “Embodied Intelligence: A Synergy of Morphology, Action, Perception and Learning,” _ACM Computing Surveys_ , vol. 57, no. 7, pp. 1–36, Mar. 2025. 

- [2] W. Saad, O. Hashash, C. K. Thomas, C. Chaccour, M. Debbah, N. Mandayam, and Z. Han, “Artificial General Intelligence (AGI)-Native Wireless Systems: A Journey Beyond 6G,” _Proceedings of the IEEE_ , vol. 113, no. 9, pp. 849–887, Sep. 2025. 

- [3] M. Polese, M. Dohler, F. Dressler, M. Erol-Kantarci, R. Jana, R. Knopp, and T. Melodia, “Empowering the 6G Cellular Architecture with Open RAN,” _IEEE Journal on Selected Areas in Communications_ , vol. 42, no. 2, pp. 245–262, Feb. 2024. 

- [4] X. Cheng, Z. Huang, and L. Bai, “Channel Nonstationarity and Consistency for Beyond 5G and 6G: A Survey,” _IEEE Communications Surveys & Tutorials_ , vol. 24, no. 3, pp. 1634–1669, 2022. 

- [5] W. Saad, M. Bennis, and M. Chen, “A Vision of 6G Wireless Systems: Applications, Trends, Technologies, and Open Research Problems,” _IEEE Network_ , vol. 34, no. 3, pp. 134–142, May 2020. 

- [6] Y. LeCun and Y. Bengio, “Convolutional Networks for Images, Speech, and Time Series,” in _Handbook of Brain Theory and Neural Networks_ , M. A. Arbib, Ed., MIT Press, 2003, pp. 255–258. 

- [7] D. Bank, N. Koenigstein, and R. Giryes, “Autoencoders,” arXiv, cs.NI 2003.05991, Apr. 2021. 

- [8] C. K. Thomas, C. Chaccour, W. Saad, M. Debbah, and C. S. Hong, “Causal Reasoning: Charting a Revolutionary Course for NextGeneration AI-Native Wireless Networks,” _IEEE Vehicular Technology Magazine_ , vol. 19, no. 1, pp. 16–31, Mar. 2024. 

- [9] R. S. Sutton and A. G. Barto, _Reinforcement Learning: An Introduction_ . Cambridge, MA: MIT Press, 1998, p. 322. 

- [10] F.-L. Vincent, H. Peter, I. Riashat, G. B. Marc, and P. Joelle, “An Introduction to Deep Reinforcement Learning,” _Foundations and Trends® in Machine Learning_ , vol. 11, no. 3–4, pp. 219–354, Dec. 2018. 

- [11] Q. Liu, N. Choi, and T. Han, “OnSlicing: Online End-to-End Network Slicing with Reinforcement Learning,” in _17th ACM International Conference on Emerging Networking Experiments and Technologies (CoNEXT 2021)_ , Virtual Conference: ACM, Dec. 2021, pp. 141–153. 

- [12] H. Cheng, S. D’Oro, R. Gangula, S. Velumani, D. Villa, L. Bonati, M. Polese, T. Melodia, G. Arrobo, and C. Maciocco, “ORANSlice: An Open Source 5G Network Slicing Platform for O-RAN,” in _30th ACM International Conference on Mobile Computing and Networking (MobiCom 2024)_ , Washington, D.C.: ACM, Nov. 2024, pp. 2297–2302. 

- [13] G. A. Vouros, “Explainable Deep Reinforcement Learning: State of the Art and Challenges,” _ACM Computing Surveys_ , vol. 55, no. 5, pp. 1–39, Dec. 2022. 

- [14] X. Yang, Y. Shi, J. Liu, Z. Xie, M. Sheng, and J. Li, “GeneralizationEnhanced DRL-Based Resource Allocation in Wireless Communication Networks With Dynamic User Loads,” _IEEE Wireless Communications Letters_ , vol. 14, no. 12, pp. 3902–3906, Dec. 2025. 

- [15] L. Bariah and M. Debbah, “AI Embodiment Through 6G: Shaping the Future of AGI,” _IEEE Wireless Communications_ , vol. 31, no. 5, pp. 174–181, Oct. 2024. 

- [16] M. Maier, “From artificial intelligence to active inference: the key to true AI and the 6G world brain [Invited],” _Journal of Optical Communications and Networking_ , vol. 18, no. 1, A28–A43, Jan. 2026. 

- [17] K. J. Friston, T. FitzGerald, F. Rigoli, P. Schwartenbeck, J. ODoherty, and G. Pezzulo, “Active inference and learning,” _Neuroscience & Biobehavioral Reviews_ , vol. 68, pp. 862–879, Sep. 2016. 

- [18] S. Ali, T. Abuhmed, S. El-Sappagh, K. Muhammad, J. M. AlonsoMoral, R. Confalonieri, R. Guidotti, J. Del Ser, N. D´ıaz-Rodr´ıguez, and F. Herrera, “Explainable Artificial Intelligence (XAI): What we know and what is left to attain Trustworthy Artificial Intelligence,” _Elsevier Information Fusion_ , vol. 99, p. 101 805, Nov. 2023. 

- [19] L. Longo, M. Brcic, F. Cabitza, J. Choi, R. Confalonieri, J. D. Ser, R. Guidotti, Y. Hayashi, F. Herrera, A. Holzinger, R. Jiang, H. Khosravi, F. Lecue, G. Malgieri, A. P´aez, W. Samek, J. Schneider, T. Speith, and S. Stumpf, “Explainable Artificial Intelligence (XAI) 2.0: A manifesto of open challenges and interdisciplinary research directions,” _Elsevier Information Fusion_ , vol. 106, p. 102 301, Jun. 2024. 

- [20] W. Guo, “Explainable Artificial Intelligence for 6G: Improving Trust between Human and Machine,” _IEEE Communications Magazine_ , vol. 58, no. 6, pp. 39–45, Jun. 2020. 

- [21] S. M. Lundberg and S.-I. Lee, “A Unified Approach to Interpreting Model Predictions,” in _31st International Conference on Neural Information Processing Systems (NIPS 2017)_ , Long Beach, CA: Curran Associates Inc., Dec. 2017, pp. 4768–4777. 

- [22] M. T. Ribeiro, S. Singh, and C. Guestrin, ““Why Should I Trust You?”: Explaining the Predictions of Any Classifier,” in _22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining_ , San Francisco, CA: ACM, Aug. 2016, pp. 1135 –1144. 

- [23] O. T. Basaran and F. Dressler, “XAInomaly: Explainable, Interpretable and Trustworthy AI for xURLLC in 6G Open-RAN,” in _3rd International Conference on 6G Networking (6GNet 2024)_ , Paris, France: IEEE, Oct. 2024, pp. 93–101. 

- [24] C. Fiandrino, L. Bonati, S. D’Oro, M. Polese, T. Melodia, and J. Widmer, “EXPLORA: AI/ML EXPLainability for the Open RAN,” _Proceedings of the ACM on Networking_ , vol. 1, pp. 1–26, Nov. 2023. 

- [25] A. K. Gizzini, Y. Medjahdi, A. J. Ghandour, and L. Clavier, “Towards Explainable AI for Channel Estimation in Wireless Communications,” _IEEE Transactions on Vehicular Technology_ , vol. 73, no. 5, pp. 7389– 7394, May 2024. 

- [26] P. F. P´erez, I. Bravo, A. Kamath, C. Fiandrino, and J. Widmer, “ChronoProf: Profiling Time Series Forecasters and Classifiers in Mobile Networks with Explainable AI,” in _26th IEEE International Symposium on a World of Wireless, Mobile and Multimedia Networks (WoWMoM 2025)_ , Fort Worth, TX: IEEE, May 2025, pp. 41–50. 

- [27] C. Fiandrino, E. P. G´omez, P. F. P´erez, H. Mohammadalizadeh, M. Fiore, and J. Widmer, “AIChronoLens: Advancing Explainability for Time Series AI Forecasting in Mobile Networks,” in _43rd IEEE International Conference on Computer Communications (INFOCOM 2024)_ , Vancouver, Canada: IEEE, May 2024, pp. 1521–1530. 

- [28] A. Duttagupta, M. Jabbari, C. Fiandrino, M. Fiore, and J. Widmer, “SYMBXRL: Symbolic Explainable Deep Reinforcement Learning for Mobile Networks,” in _44th IEEE International Conference on Computer Communications (INFOCOM 2025)_ , London, United Kingdom: IEEE, May 2025, pp. 1–10. 

- [29] L. Da Costa, T. Parr, N. Sajid, S. Veselic, V. Neacsu, and K. J. Friston, “Active inference on discrete state-spaces: A synthesis,” _Journal of Mathematical Psychology_ , vol. 99, p. 102 447, Dec. 2020. 

- [30] A. Tschantz, B. Millidge, A. K. Seth, and C. L. Buckley, “Reinforcement Learning through Active Inference,” arXiv, cs.LG, Feb. 2020. 

- [31] G. Oliver, P. Lanillos, and G. Cheng, “An Empirical Study of Active Inference on a Humanoid Robot,” _IEEE Transactions on Cognitive and Developmental Systems_ , vol. 14, no. 2, pp. 462–471, Jun. 2022. 

- [32] K. Fujii, T. Isomura, and S. Murata, “Real-World Robot Control Based on Contrastive Deep Active Inference With Demonstrations,” _IEEE Access_ , vol. 12, pp. 172 343–172 357, 2024. 

- [33] M. Albarracin, I. Hip´olito, S. E. Tremblay, J. G. Fox, G. Ren´e, K. J. Friston, and M. J. D. Ramstead, “Designing explainable artificial intelligence with active inference: A framework for transparent introspection and decision-making,” arXiv, cs.AI, Jun. 2023. 

- [34] T. Parr, G. Pezzulo, and K. J. Friston, _Active Inference: The Free Energy Principle in Mind, Brain, and Behavior_ . The MIT Press, 2022. 

- [35] K. J. Friston, “The free-energy principle: a unified brain theory?” _Nature Reviews Neuroscience_ , vol. 11, no. 2, pp. 127–138, Jan. 2010. 

- [36] A. Kelkar and C. Dick, “Aerial: A GPU Hyperconverged Platform for 5G,” in _ACM SIGCOMM 2021, Demo Session_ , Virtual Conference: ACM, Aug. 2021, pp. 79–81. 

- [37] A. Kelkar and C. Dick, “NVIDIA Aerial GPU Hosted AI-on-5G,” in _4th IEEE 5G World Forum (5GWF 2021)_ , Montr´eal, Canada: IEEE, Oct. 2021, pp. 64–69. 

- [38] NVIDIA. “NVIDIA Aerial SDK. ”[Online]. Available: https : / / developer.nvidia.com/aerial-sdk (accessed: 15.01.2026). 

- [39] F. Kaltenberger, A. P. Silva, A. Gosain, L. Wang, and T.-T. Nguyen, “OpenAirInterface: Democratizing innovation in the 5G Era,” _Elsevier Computer Networks_ , vol. 176, p. 107 284, Jul. 2020. 

- [40] Foxconn. “Foxconn RPQN. ”[Online]. Available: https://fcc.report/ FCC-ID/2AQ68RPQN7801/5573870.pdf (accessed: 15.01.2026). 

- [41] O-RAN SC. “OSC Near Realtime RIC. ”[Online]. Available: https: //wiki.o-ran-sc.org/display/RICP/2022-05-24+Release+E (accessed: 15.01.2026). 

- [42] M. Polese, L. Bonati, S. D’Oro, S. Basagni, and T. Melodia, “ColORAN: Developing Machine Learning-Based xApps for Open RAN Closed-Loop Control on Programmable Experimental Platforms,” _IEEE Transactions on Mobile Computing_ , vol. 22, no. 10, pp. 5787– 5800, Oct. 2023. 

- [43] V. Mnih, K. Kavukcuoglu, D. Silver, A. Graves, I. Antonoglou, D. Wierstra, and M. Riedmiller, “Playing Atari with Deep Reinforcement Learning,” arXiv, cs.LG 1312.5602, Dec. 2013. 

- [44] H. van Hasselt, A. Guez, and D. Silver, “Deep Reinforcement Learning with Double Q-learning,” in _30th AAAI Conference on Artificial Intelligence (AAAI 2016)_ , Phoenix, AZ: AAAI Press, Feb. 2016, pp. 2094–2100. 

13 

- [45] R. J. Williams, “Simple statistical gradient-following algorithms for connectionist reinforcement learning,” _Machine Learning_ , vol. 8, no. 3–4, pp. 229–256, May 1992. 

- [46] J. Schulman, R. Wolski, P. Dhariwal, A. Radford, and O. Klimov, “Proximal Policy Optimization Algorithms,” arXiv, cs.LG, Jul. 2017, pp. 1–12. 

- [47] T. Haarnoja, A. Zhou, P. Abbeel, and S. Levine, “Soft Actor-Critic: Off-Policy Maximum Entropy Deep Reinforcement Learning with a Stochastic Actor,” arXiv, cs.LG 1801.01290, Aug. 2018. 

**Osman Tugay Basaran** is a 6G/AI Research Scientist at Prof. Dr.-Ing. Falko Dressler’s Telecommunications Networks Group (TKN), School of Electrical Engineering and Computer Science, Technical University of Berlin, Germany, while holding two Visiting Research Scientist positions at the Fraunhofer Heinrich Hertz Institute, Wireless Communications and Networks Department, Signal and Information Processing Research Group of Prof. Dr.-Ing. Slawomir Stanczak and at Optical Zeitgeist Laboratory of Prof. Dr. Martin Maier, Montr´eal, Canada. Within the scope of 6G-Platform, 6G-RIC and xG-RIC projects, he is focusing on Domain-specific Generative AI (GenAI) and Explainable AI (XAI) algorithms for the implementation and execution of Next-Generation, AI-Native 6G and Beyond as well as cognitive skilled agents for future wireless systems. He has been selected as one of the Research Fellow (36 Fellow selected across all German Technical Universities) in the Software Campus Executive Leadership Cohort 2025. As a Principal Investigator in collaboration with Huawei, he is leading collaborative project titled “NEXT-G: Explainable and Trustworthy AI/ML for 6G and Beyond”. He also serves as a Scientific Reviewer in top-tier IEEE Journal/Conferences such as different Transactions, Magazines, INFOCOM, ICC, and GLOBECOM. 

**Falko Dressler** is full professor and Chair for Telecommunication Networks at the School of Electrical Engineering and Computer Science, TU Berlin. He received his M.Sc. and Ph.D. degrees from the Dept. of Computer Science, University of Erlangen in 1998 and 2003, respectively. Dr. Dressler has been associate editor-in-chief for IEEE Trans. on Network Science and Engineering, IEEE Trans. on Mobile Computing and Elsevier Computer Communications as well as an editor for journals such as IEEE/ACM Trans. on Networking, Elsevier Ad Hoc Networks, and Elsevier Nano Communication Networks. He has been chairing conferences such as IEEE INFOCOM, ACM MobiSys, ACM MobiHoc, IEEE VNC, IEEE GLOBECOM. He authored the textbooks SelfOrganization in Sensor and Actor Networks published by Wiley & Sons and Vehicular Networking published by Cambridge University Press. He has been an IEEE Distinguished Lecturer as well as an ACM Distinguished Speaker. Dr. Dressler is an IEEE Fellow, an ACM Fellow, and an AAIA Fellow. He is a member of the German National Academy of Science and Engineering (acatech). He has been serving on the IEEE COMSOC Conference Council and the ACM SIGMOBILE Executive Committee. His research objectives include next generation wireless communication systems in combination with distributed machine learning and edge computing for improved resiliency. Application domains include the internet of things, cyber-physical systems, and the internet of bio-nano-things. 

**Martin Maier** is a full professor with INRS, Montr´eal, Canada. He was educated at the Technical University of Berlin, Germany, and received M.Sc. and Ph.D. degrees both with distinctions (summa cum laude) in 1998 and 2003, respectively. In 2003, he was a postdoc fellow at the Massachusetts Institute of Technology (MIT), Cambridge, MA. He was a visiting professor at Stanford University, Stanford, CA, 2006 through 2007. In 2017, he received the Friedrich Wilhelm Bessel Research Award from the Alexander von Humboldt (AvH) Foundation in recognition of his accomplishments in research on FiWi-enhanced mobile networks. In 2017, he was named one of the three most promising scientists in the category “Contribution to a better society” of the Marie SklodowskaCurie Actions (MSCA) 2017 Prize Award of the European Commission. In 2019/2020, he held a UC3MBanco de Santander Excellence Chair at Universidad Carlos III de Madrid (UC3M), Madrid, Spain. Recently, in December 2023, he was awarded with the 2023 Technical Achievement Award of the IEEE Communications Society (ComSoc) Tactile Internet Technical Committee for his contribution on 6G/Next G and the design of Metaverse concepts and architectures as well as the 2023 Outstanding Paper Award of the IEEE Computer Society Bio-Inspired Computing STC for his contribution on the symbiosis between INTERnet and Human BEING (INTERBEING). He is co-author of the book “Toward 6G: A New Era of Convergence” (Wiley-IEEE Press, January 2021) and author of the sequel “6G and Onward to Next G: The Road to the Multiverse” (Wiley-IEEE Press, February 2023). 

