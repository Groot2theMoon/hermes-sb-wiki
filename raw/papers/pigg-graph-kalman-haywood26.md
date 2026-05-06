---
title: "PiGGO: Physics-Guided Learnable Graph Kalman Filters for Virtual Sensing of Nonlinear Dynamic Structures under Uncertainty"
arxiv: "2604.2659"
authors: ["Marcus Haywood-Alexander", "Gregory Duthé", "Eleni Chatzi"]
year: 2026
source: paper
ingested: 2026-05-06
sha256: bcbf01e9ee2d390ad55dd12bcdceec97c701c862951d3c968cec383b70a815b2
conversion: pymupdf4llm
---

# PiGGO: Physics-Guided Learnable Graph Kalman Filters for Virtual Sensing of Nonlinear Dynamic Structures under Uncertainty 

Marcus Haywood-Alexander[a,] _[∗]_ , Gregory Duthé[a] , Eleni Chatzi[a,b] 

> _aDepartment of Civil, Environmental and Geomatic Engineering, ETH Zürich, Wolfgang-Pauli Strasse 5, 8049, Zürich, Switzerland_ 

> _bFuture Resilient Systems, Singapore-ETH Centre, Singapore, Singapore_ 

## **Abstract** 

Digital twins provide a powerful paradigm for diagnostic and prognostic tasks in the monitoring and control of engineered systems; however, their deployment for complex structures remains challenged by model-form uncertainty, arising from unknown nonlinear dynamics, and by sparse sensing. These limitations hinder reliable online state estimation using either purely physics-based or purely data-driven approaches. 

This work introduces the _Physics-Guided Graph Neural ODE (PiGGO)_ framework, a physics-informed, graph-based Bayesian state estimation approach in which a learned _graph neural ordinary differential equation (GNODE)_ serves as the continuous-time state-transition model within an _extended Kalman filter_ . The graph representation explicitly defines the system state-space, while physics-guided inductive biases encode known structural relationships and constrain the learning of nonlinear dynamics. 

By integrating graph-native learned dynamics with recursive Bayesian filtering, the proposed PiGGO framework enables online virtual sensing and uncertainty-aware state estimation for nonlinear systems with unknown model form, while maintaining generalisation across topologically similar structures. Numerical case studies demonstrate improved robustness to model uncertainty and measurement noise, outperforming both open-loop graph neural models and conventional filtering approaches in online prediction tasks. 

_Keywords:_ physics-enhanced machine learning, graph neural networks, physics-guided, neural ordinary differential equation 

## **1. Introduction** 

The development of smart structures relies on digital twins that faithfully represent the dynamics of monitored structures [1, 2], enabling diagnostic and prognostic tasks within the context of _Structural Health Monitoring_ (SHM) [3, 4, 5]. A primary function of digital twins is _virtual sensing_ , defined as the estimation of structural response, commonly represented by state variables **z** , at unmeasured locations based on a sparse set of available observations **y** _[∗]_ [6]. In many _in-situ_ monitoring scenarios, the accessible measurements are limited to accelerations, strains and external forces, while further quantities of primary interest — such as displacement and velocity — must be inferred indirectly [7]. However, deploying such digital twins faces the challenge of model error – both _parameter_ and _model form_ uncertainties [8, 9, 10] – and inherent operational variability that numerical models fail to capture [11, 12, 13]. To maintain the fidelity required for reliable SHM, it is essential to ensure a digital twin architecture that is able to identify and compensate for both epistemic and aleatoric uncertainties [14]. In recent decades, this is often captured through the use of powerful data-driven techniques available from machine learning [15]. 

Although linear systems are relatively simple to capture and model, real-world structures often exhibit complex nonlinearities as a result of material effects, discrete feedback forces, or joint mechanisms, which purely physics-based models struggle to accurately represent [16]. Conversely, purely data-driven models can bypass explicit modelling, but suffer under sparse measurements [17, 18]. This motivates _Physics-Enhanced_ 

> _∗_ Corresponding author 

> _Email addresses:_ `mhaywood@ethz.ch` (Marcus Haywood-Alexander), `dutheg@ethz.ch` (Gregory Duthé), `chatzie@ethz.ch` (Eleni Chatzi) 

_April 30, 2026_ 

_Preprint submitted to Elsevier_ 

_Machine Learning_ (PEML) approaches that combine physical structure with learning-based components [19, 20, 21]. A prominent class of PEML methods are _Physics-Informed Machine Learning_ (PIML) approaches, which leverage physics-based inductive biases to compensate for sensing limitations [22, 23, 24, 25, 26]. However, these methods are restricted to _offline_ settings and rely on the assumption that the prescribed physics is sufficient [27]. An alternative is learning a generative dynamics models, such as physics-guided methods, [28], to capture system evolution directly. 

For ML tasks where the underlying function to be learned is driven by a prescribable topology, _Graph Neural Network_ s (GNNs) offer a flexible, geometry-aware universal function approximator. The response of dynamic structures is driven by local interactive forces between components in the structure, therefore, GNNs provide a powerful framework for dynamical systems, using spatial inductive biases to improve observability, particularly across populations [29, 30]. A subclass of GNNs is the _Graph Neural ODE_ (GNODE) [31], which extends the _Neural-ODE_ [32] to graph-structured dynamical systems. The state transition is defined by a learnable graph-parameterised differential equation, **H**[˙] = **F** ( _G_ ) (cf. Figure 1). State predictions are obtained by numerically integrating this vector field, while an observation operator maps the resulting continuoustime states to measurable outputs **Y** . While GNODEs function well for offline virtual sensing, in purely generative applications in an online setting, natural structural variability can lead to error accumulation and degraded performance when generalising across populations of structures [33]. 

**==> picture [422 x 151] intentionally omitted <==**

Figure 1: State-space transition model for virtual sensing on graphs. 

To mitigate this error accumulation, Bayesian filtering schemes are commonly employed [34, 35]. While a powerful stochastic framework for virtual sensing of structural responses [36, 37], the standard _Extended Kalman Filter_ (EKF) requires an accurate and differentiable state-transition model, often unavailable for complex nonlinear systems [38, 39]. Recent work therefore integrates learnable models within the filtering loop to alleviate model bias and improve robustness [40, 41, 42]. 

Kalman filters have recently been extended to graph-structured data [43], however, as _Graph Kalman Filter_ s (GKFs) contain additional computational complexity, their methods of implementation vary depending on the problem context. In [44], the Kalman gain is calculated using the graph topology, thus simplifying the model formulation. Where adequate model form is available, but identification is difficult, [45], uses GNNs to estimate the parameters of the prescribed underlying model. Alippi and Zambon (2023) exploited the recursive updating capabilities of Bayesian filtering to adaptively infer and update the graph topology, treating the adjacency matrix itself as an evolving latent variable [46]. A common use of GKFs is in traffic prediction, where the capabilities of learned-model-based GKF schemes for novelty detection are highlighted [47]. The computational complexity of GNNs has limited the use of GKFs for high-dimensional data, and such filtering schemes are often applied to low-dimensional latent variables [48]. 

In this work, we introduce the **P** hys **i** cs- **G** uided **G** raph Neural **O** DE _(PiGGO)_ framework, a unified approach for learning and filtering nonlinear structural dynamics under uncertainty. The proposed methodology integrates a learned GNODE as a continuous-time, graph-structured state-transition model within an EKF, thereby coupling physics-guided representation learning with recursive Bayesian state estimation. The PiGGO framework comprises three key components: (i) a graph-based representation that explicitly defines the system state-space, (ii) a physics-guided GNODE that captures the underlying nonlinear dynam- 

2 

ics through inductive biases informed by structural mechanics, and (iii) an EKF that performs online state estimation and uncertainty quantification. By embedding structural relationships directly within the graph and constraining the learning process through physics-guided architectural design, the framework enables the identification of nonlinear dynamics beyond the reach of purely data-driven approaches. 

A key contribution of this work lies in the decoupled yet synergistic training and inference strategy: the PiGGO is first trained offline to learn a topology-aware, generalisable representation of the system dynamics, and is subsequently embedded within an EKF to enable online correction of model-form errors and measurement noise. This results in a scalable and robust virtual sensing framework capable of uncertaintyaware state estimation in nonlinear systems with unknown or partially known governing equations, while maintaining generalisation across topologically similar structures. 

The paper is organised as follows: Section 2 introduces the PiGGO framework for offline virtual sensing. Section 3 presents its integration within a graph Kalman filtering scheme for online inference. Section 4 evaluates the approach on nonlinear structural dynamics case studies, followed by conclusions and future research directions in Section 5. 

## **2. Proposed Method for Offline Virtual Sensing** 

## _2.1. Graph Neural Network_ 

We start by introducing the Graph Neural Network, as this acts as the basis for this approach, which relies on processing graph-structured data. At the core of the GNN lies the _message-passing_ paradigm [49], which provides a unified formulation for information exchange between nodes by aggregating features from their neighbourhoods. Architectures based on this principle are commonly referred to as _message-passing neural networks_ (MPNNs) and underpin most widely used GNN variants implemented in libraries such as `PyTorch-Geometric` [50], `Deep Graph Library (DGL)` [51], and `Spektral` [52]. 

In the message-passing framework, information is propagated between connected nodes as follows. For an edge from node _j_ to node _i_ , a message **m** _ji_ is computed from the associated node and edge features, 

**==> picture [287 x 11] intentionally omitted <==**

where **x** _i_ and **x** _j_ denote node features, **e** _ji_ edge features, and _ϕ_ ( _·_ ) a learnable message function. Messages from the neighbourhood _N_ ( _i_ ) are then aggregated and combined with the current node features to obtain updated representations, 

**==> picture [295 x 25] intentionally omitted <==**

where □ denotes a permutation-invariant aggregation operator and _γ_ ( _·_ ) a learnable update function. A schematic illustration of this process is provided in Figure 2. 

**==> picture [352 x 157] intentionally omitted <==**

Figure 2: The two phases of message-passing in GNNs. Left: Initial message computation phase, where messages are computed on each edge. Right: Aggregation and update phase, where messages from neighbours are combined and the node’s features are updated. The design choices for these two operations define different GNN variants. 

3 

The aggregation operation □ is a _permutation-invariant_ function, which allows the message-passing framework to operate consistently on graphs with varying numbers of neighbours. Typical choices include element-wise summation, mean, or maximum, each inducing different biases with respect to neighbourhood size and feature scaling. The choice of the message and update functions _ϕ_ and _γ_ plays a crucial role in determining the specific architecture and behaviour of a GNN. These choices lead to distinct characteristics that determine their applicability for various physics-problems [53, 54, 55]. Common examples include the _GraphNet_ formulation, which employs generic learnable functions for message construction and aggregation and is widely used in physics-based learning tasks [56, 53, 57], _Graph Attention Networks_ (GATs), which weight messages adaptively using learned attention coefficients [58], and _Graph Isomorphism Networks_ (GINs), which use sum aggregation with injective update functions to maximise expressive power [59]. There are many resources available which detail the characteristics and uses of each of these [60, 61], but for this work, a modified form of the GraphNet, along with a convolutional approach, is used as it is most appropriate for the physics-bias to be introduced, as explained in more detail in Section 2.3. 

In a general form, the overall function to be learnt can be described as a graph convolutional operator _C_ , which captures the message-aggregation-update process described above, 

**==> picture [265 x 11] intentionally omitted <==**

where _G_ = _{_ **X** _,_ **E** _,_ **A** _}_ is the graph, described by the full set of node features **X** _∈_ R _[n][n][×][d][x]_ , full set of edge features **E** _∈_ R _[n][e][×][d][e]_ , and the adjacency matrix **A** _∈_ N _[n][n][×][n][n]_ ; a binary valued matrix defining the connections between nodes, as in [31]. **Θ** = _{_ _**θ** ϕ,_ _**θ** γ}_ are the learnable parameters which govern the chosen message and update functions, _ϕ_ and _γ_ , respectively. 

## _2.2. Graph Neural ODE_ 

Following [31], we formulate the graph differential equation (GDE) for a dynamical system in state-space form. Assuming Markovian evolution of the latent states, the continuous-time state transition over a time interval is defined as 

**==> picture [384 x 49] intentionally omitted <==**

where **Z** _∈_ R _[n][n][×][d][z]_ denotes the hidden states of the graph, **F** represents any external input, _F_ ev defines the state evolution (vector field), and _F_ in denotes the system input mapping. 

In this formulation, _F_ ev governs the continuous-time evolution of the latent state, while _F_ in provides a transformation of the external inputs into a representation suitable for the evolution dynamics. The overall state transition function _F_ st is therefore not an independent model, but is implicitly defined through time integration of the evolution function. Both _F_ ev and _F_ in are expressed as functions of the node, edge, and adjacency representations to allow for flexible modelling of graph-structured systems. 

Depending on the type of available measurements, an observation (readout) function is introduced to map latent states to measurable quantities, 

**==> picture [307 x 11] intentionally omitted <==**

In discrete form, the _state transition_ function used to estimate the current hidden state from the previous time point is written as 

**==> picture [405 x 42] intentionally omitted <==**

Graph Neural ODEs (GNODEs) aim to _learn_ the functions _F_ ev, _F_ in, and _F_ o using graph neural network architectures. In this context, **V** _[′]_ denotes the encoded input, obtained from the measurable input **F** through the input function _F_ in. This mapping may be realised through an input graph convolutional operator _C_ in, 

4 

**==> picture [464 x 181] intentionally omitted <==**

Figure 3: Block diagram of the Graph Neural ODE (GNODE) model, showing the input encoding _F_ in, continuous-time state evolution governed by _F_ ev on the graph, and the observation mapping _F_ o used to recover measurable quantities. 

derived either from known physics (e.g. ground acceleration) or directly from measured system inputs (e.g. force). 

The evolution and observation functions are then parameterised using graph convolutional operators _C_ ev and _C_ o, respectively, 

**==> picture [328 x 50] intentionally omitted <==**

where _G_ = ( **X** _,_ **E** _,_ **A** ) denotes the graph structure and **Θ** the learnable parameters. 

Importantly, during the integration scheme, for dynamic graphs, the instantaneous graph features are evaluated continuously within the convolution operators, ensuring that the evolution is consistent with the time-varying graph representation over the integration window. 

Given the current estimate of the state, the state at the next time point is computed as 

**==> picture [415 x 36] intentionally omitted <==**

where ODEINT denotes a differentiable numerical integrator, such as Runge–Kutta or Velocity Verlet, the latter being used in this work. 

An autoregressive GDE recursively predicts the next state based on previous predictions, similar to recurrent dynamical models. Consequently, accurate prediction depends on a reliable estimate of the initial state. During training, the model parameters are optimised by minimising the discrepancy between predicted observations **Y**[ˆ] = _F_[ˆ] o and measured observations **Y** _[∗]_ in the observation domain Ω _o_ , 

**==> picture [305 x 28] intentionally omitted <==**

## _2.3. GNODEs for Structural Dynamics_ 

We begin by defining the graph-state-space model for structural dynamics problems in a black-box form, i.e. no prior physics knowledge. For two-dimensional structural dynamics problems, the hidden state **z** , the input (external force) **f** , and observations **y** are defined in Cartesian coordinates; for node _i_ , 

**==> picture [421 x 14] intentionally omitted <==**

5 

where _ud_ , _u_ ˙ _d_ , _u_ ¨ _d_ , and _fd_ are the nodal displacement, velocity and acceleration and the external force in the direction _d_ , respectively. The general GNODE formulation allows separate learnable input and state-evolution functions, providing maximum flexibility. However, for structural dynamics problems this formulation can be simplified by embedding the system states and external inputs directly within the graph representation. Specifically, we assume that the system states and external inputs are embedded within, or deterministically mapped to, the node and edge feature spaces, i.e. **Z** _,_ **F** _⊆{_ **X** _,_ **E** _}_ , or more generally that certain graph features are functions of the states and/or external inputs, _f_ ( **Z** _,_ **F** ) _⊆{_ **X** _,_ **E** _}_ . Here, **Z** and **F** denote the flattened state and force vectors over the full graph. 

For structural dynamics, the adjacency matrix is assumed time-invariant, and the state-evolution and observation equations reduce to, 

**==> picture [294 x 30] intentionally omitted <==**

The state transition function _F_ st is not learned independently, but is implicitly defined through time integration of the graph-based state evolution function _F_ ev, as introduced in Section 2.2. 

A distinct advantage of GNNs is their inherent inductive biases which stem from their topology-aware architecture. Additional inductive biases can also be introduced in the form of physics-informed loss functions [62], and for dynamical systems, one can manipulate the architecture to embed further inductive biases via representations of force balances [63, 64]. However, for nonlinear structural dynamics, and other problems where the underlying physics may be partially known, there is an opportunity to exploit the advantages of _physics-guided machine learning_ (PGML). In PGML schemes, there is a trade-off between a lower reliance on data for a larger reliance on the underlying physics model. 

The first step for designing biased GNODEs for structural dynamics is the selection of appropriate features throughout the graph. An important consideration here, is to ensure _equivariance_ of the graph model, such that it is not affected by transformations of the reference coordinate system [65, 66, 67]. First, the node features are set as the rest position **p** 0, external force **f** and equivalent mass _m_ , and the edge features as the connection extensions _ϵ_ , connection extension rates _ϵ_ ˙, cosine and sine of the current bar angles _θ_ , cosine and sine of the rest angles _ϕji_ , stiffness _k_ , and damping _c_ . The cosine and sine are used in order to remove discontinuities in the input features around _±π/_ 2 and represent normalised Euclidean directions of the edge. 

**==> picture [444 x 11] intentionally omitted <==**

where the values of _ϵji,_ ˙ _ϵji, θji_ are continuously updated using corotational kinematic calculations on the current node states **z** _i_ = [ **u** _i,_ **u** ˙ _i_ ] _[T]_ , further details of which are given in Appendix A. In the context of structural mechanics, these geometric nonlinearities are simple to include and a powerful inductive bias, however, one could also omit this prescription, and allow the learner freedom in capturing more complex/unknown geometric nonlinearities by passing the states as part of the node features. 

The state evolution function (as a graph convolution operator) is augmented to be a function _F_ of the physics-based (linear) graph convolution _C_ phy( _G_ ), estimated from the known structural mechanics, and black-box neural-network-based graph convolution _C_ bb( _G,_ **Θ** ), estimated by the GNN forward pass, 

**==> picture [346 x 11] intentionally omitted <==**

The important choice here is that of the graph convolutional operator _C_ bb (i.e. the message-aggregationupdate scheme), where further biases can be introduced by architecture design. 

One such bias permissible, which is used in this work, is to assume the nonlinearity manifests as a conservative force acting on node _i_ by edge _ji_ , thus the message aggregation is a sum. In this work, the node and edge features ( **x** and **e** ) are encoded into their respective latent variables **h** _x_ and **h** _ϵ_ before passing in to the message function, in order to increase flexibility of the learnt function. 

**==> picture [387 x 36] intentionally omitted <==**

**==> picture [362 x 24] intentionally omitted <==**

6 

**==> picture [464 x 236] intentionally omitted <==**

Figure 4: Block diagram of the PiGGO, showing the estimation of the state evolution function _F_ ev (Equation (15)) via the combination of physics-based ( _C_ phy) and data-driven ( _C_ bb) graph convolutional operators. 

where _**ξ**_ nonlin _,i_ represents the nonlinear restoring forces, and **n** ˆ _ji_ = [cos( _θji_ ) _,_ sin( _θji_ )] _[T]_ is the current direction of the edge. The message-passing MLP is chosen to use the LeakyReLU activation function to avoid singularities/gradient explosion, as the values of the kinematics often fluctuate around zero. For the full system state, the evolution is then an additive combination of the known linear and external forces, and unknown nonlinear forces, 

**==> picture [343 x 31] intentionally omitted <==**

For dynamics of point masses, the physics-based (linear) graph convolutional operator can be formulated from the force balance at each node, 

**==> picture [346 x 29] intentionally omitted <==**

where _**ξ**_ lin _,i_ is the sum of the restoring forces exerted on the point mass by all connected edges. This formulation can be directly compared to the aggregation in Equation (2), where the operation can be interpreted as a physics-based message aggregation of restoring forces. The process block diagram showing the PiGGO architecture is shown in Figure 4, which represents the total convolutional approach to continuously estimate the state evolution, **Z**[˙] , given the current estimate of the state, **Z** , (Equation (15)). 

At this stage, the observation-based loss function defined in Equation (9) could be employed. However, to enable optimisation within a physics-consistent objective space, we instead reformulate it as a physicsinformed loss function. To do so, given the predicted states and observed values of the acceleration and force at time point _t_ , the physics loss then minimises a force-balance residual 

**==> picture [342 x 13] intentionally omitted <==**

**==> picture [378 x 29] intentionally omitted <==**

where _**ξ** i_ ( **Z**[˜] ( _t_ )) = _**ξ**_ lin _,i_ ( **Z**[˜] ( _t_ )) + _**ξ**_ nonlin _,i_ ( **Z**[˜] ( _t_ )) is the sum of the linear and nonlinear restoring forces, based on the full graph state **Z**[˜] ( _t_ ), as calculated in the graph convolutional process. The architecture provides two 

7 

primary sources of physics-based inductive biases; the topologically-aware and locally-coherent operations, and the physics-guided state evolution prediction. The former enables learning and prediction from spatially sparse observations, whereas the latter introduces a physics-consistent objective that is partly redundant with the observation loss. To remove this redundancy, one may wish to use the predicted accelerations rather than the observed accelerations in the physics loss, however, this would create a tautology as the predicted accelerations come from the same underlying physics equations. Therefore, in this work, only the physics loss is used in all training, unless otherwise stated. 

**==> picture [256 x 11] intentionally omitted <==**

Compared to traditional physics-informed approaches, this makes for simpler training as it removes any requirement for manual tuning of loss weights. 

**Algorithm 1** Physics-guided GNODE algorithm for virtual sensing with acceleration observation model. **Input** Measured Data **D** _[∗]_ , Structural Information _D_ **Output** Predictions of State Over Entire Graph Domain 

1: **t** _[∗] ,_ **U**[¨] _[∗] ,_ **F** _[∗] ←_ **D** _[∗]_ 

2: **X** _,_ **E** _,_ **A** _←D_ 

3: Initialise GNODE _G_ ( **X** _,_ **E** _,_ **A** ; **Θ** ) 

4: Initialise network weight optimiser `optim_net` ( **Θ** ) 

5: **for** ˆ _i_ = 0 to epochs **do** 6: **Z** ˆ = _∅[n] t[×][n] n[×][n] z ▷_ Initialise tensor to store state predictions 7: **Y** = _∅[n] t[×][n] n[×][n] y ▷_ Initialise tensor to store observations 8: _L_ phy = _∅[n][t]_ 10:9: **forZ** ˆ _s_ = 1[ _s_ ] _←_ to **Z** [ _nst −_ **do** 1] + ODEINT( _C_ ev; _t_ [ _s −_ 1] _, t_ [ _s_ ]) _|_ Ω _p ▷_ Estimate state transition 11: _L_ phy[ _s_ ] _←||_ **R** ( **Z**[ˆ] [ _s_ ] _,_ **F** _[∗]_ [ _s_ ] _,_ **Y** _[∗]_ [ _s_ ]) _||_[2] Ω _o ▷_ Calculate physics residual in observation domain 12: **end for** 13: _L ← n_ 1 _t_ � _L_ phy _▷_ See loss function in Equation (18) 14: Update **Θ** using _∇L_ and `optim_net` 15: **if** _∇L ≤ ϵL_ **then** 16: **end for** _▷_ Early stopping 17: **end if** 18: **end for** 

## **3. Graph-based Bayesian Virtual Sensing under Sparse and Noisy Data** 

Section 2 presented the architecture through which the dynamics of systems with partially known and locally consistent physical behaviour can be learned. Owing to the inductive biases introduced, the resulting model can be directly employed in an offline setting. In this section, we extend this framework by integrating it with a Kalman filtering approach to enable online state estimation. 

## _3.1. Graph Kalman Filters_ 

In civil and mechanical engineering, a popular choice for virtual sensing of weakly nonlinear systems is the Extended Kalman Filter [36], because of its ease of use, robustness and suitability for real-time applications. The process assumes a sequence of available measurements **y** 1: _T_ , which are determined by some hidden states **z** 1: _T_ . The transition from a state **z** _t−_ 1 to the next state **z** _t_ is denoted the _transition_ function, and the process from a state **z** _t_ to its observable variable **y** _t_ is termed the _observation_ function. A full introduction and tutorial for the EKF, and other KF variants, can be found in [68], but an important consideration is that it assumes both these functions as known, 

**z** _t_ = _f_ st( **z** _t−_ 1 _,_ **f** _t−_ 1) + _wt_ (20a) 

8 

**y** _t_ = _f_ o( **z** _t_ ) + _vt_ (20b) 

where _w ∼N_ (0 _,_ **Q** _t_ ) and _v ∼N_ (0 _,_ **R** _t_ ) are Gaussian noise sources for the process and observation, respectively. 

Kalman filtering schemes are reliant on the underlying model which defines the state transition _f_ st and observation _f_ o functions. Following the graph differential equation formulation in Section 2.2, these functions are parameterised through graph-based operators, where the state transition _F_ st is induced via integration of the evolution function _F_ ev, and the observation function _F_ o is defined through a graph readout operator. In the graph setting, these quantities are lifted to graph-level representations, where **Z** _t_ and **Y** _t_ denote the stacked states and observations over all nodes. Accordingly, the filtering equations become, 

**==> picture [307 x 30] intentionally omitted <==**

where _**W** t_ and _**V** t_ are the process and measurement noise terms for all nodes on the graph. The prior distribution of the states over the graph is given by, 

**==> picture [323 x 13] intentionally omitted <==**

**==> picture [317 x 31] intentionally omitted <==**

where **A** _t−_ 1 = _∇_ **Z** _F_ st( **Z** _t−_ 1 _,_ **F** _t−_ 1 _, Gt−_ 1) is the Jacobian of the state transition function at the previous posterior estimate. Then, the posterior distribution for the _update_ step is computed, 

**==> picture [331 x 59] intentionally omitted <==**

where **H** _t_ = _∇_ **Z** _F_ o( **Z** _t, Gt_ ) is the Jacobian of the observation function at the current prior estimate. This posterior is then inserted into the graph feature location to create the posterior estimate of the graph _Gt|t_ . In practice, with modern machine learning libraries, such as Pytorch or JAX, the Jacobians can be returned easily using automatic differentiation. As can be seen in the above equations, the Kalman filtering procedure is performed in a recurrent/autoregressive manner, where previous predictions are used directly in the prediction of the current step. A powerful advantage of KF schemes is their robustness against unknown initial states, as the continuous updating scheme ‘settles’ to an accurate solution over time. 

## _3.2. Learnable Graph Kalman Filters_ 

As the Graph Kalman Filter is inherently probabilistic, the deterministic loss functions introduced in Section 2 do not explicitly account for uncertainty. Therefore, the first task in creating the learnable GKFs is to adapt the loss function to take into account noise and model error. In classical machine learning, likelihoodbased loss functions are often employed to mitigate overfitting; however, in the present context, their primary role is to explicitly account for uncertainty in the residual dynamics. First, the physics-likelihood can be formulated using the force balance residual, which is assumed to have a zero-mean Gaussian distribution _p_ ( **r** ) = _N_ ( **0** _,_ **Σ** _r_ ), where the residual covariance is defined as 

**==> picture [292 x 14] intentionally omitted <==**

and _σr,i_[2][denotes the variance of the residual at node] _[ i]_[, capturing the effects of measurement noise and model] error. 

Given the residual calculation in Equation (17), and assuming conditional independence of the residuals across nodes, the likelihood can be written as 

**==> picture [370 x 43] intentionally omitted <==**

9 

**==> picture [464 x 200] intentionally omitted <==**

Figure 5: Block diagram of the graph extended Kalman filter. 

**Algorithm 2** Graph extended Kalman filter algorithm for virtual sensing of structure. 

**Input** Measured Data **D** _[∗]_ , Model Information _D_ **Output** Predictions of State Over Entire Graph Domain 1: **t** _[∗] ,_ **Y** _[∗] ,_ **F** _[∗] ←_ **D** _[∗]_ 2: **X** _,_ **E** _,_ **A** _←D_ 3: Initialise graph model _G_ ( **X** _,_ **E** _,_ **A** ; **Θ** ) 4: **Z**[ˆ] = _∅[n][s][×][n][n][×][n][z] ▷_ Initialise 5: **Y**[ˆ] = _∅[n][s][×][n][n][×][n][y] ▷_ Initialise 6: _**µ**_ 0 _|_ 0 = _∅[n][n][×][n][z] ▷_ 7: **for** _s_ = 1 to _ns_ **do** 8: _t_ = **t** [ _s_ ] 9: Predict prior distribution _**µ** t|t−_ 1 _,_ Σ _t|t−_ 1 using Equations (22b) and (22c) 10: Compute Kalman gain _Kt_ using Equation (23a) 11: Predict posterior distribution _**µ** t|t,_ Σ _t|t_ using Equations (23b) and (23c) 12: Update graph if necessary _Gt|t ←_ _**µ** t|t, f_ ( _**µ** t|t_ ) 13: Store posterior predictions **Z**[ˆ] [ _s_ ] _←_ _**µ** t|t,_ **Y**[ˆ] [ _s_ ] _←F_ o( _**µ** t|t, Gt|t_ ) 14: **end for** 

_▷_ Initialise tensor to store state predictions _▷_ Initialise tensor to store state predictions _▷_ Initialise states of graph to zero 

10 

where the estimated state one step ahead is given by the prediction process over the graph in Equation (4). During training, the residual variance is estimated from the measurement noise of the acceleration and force, 

**==> picture [278 x 13] intentionally omitted <==**

This derivation assumes that the residual variance is fully attributable to measurement noise, thereby neglecting explicit modelling of model-form uncertainty. The physics-loss is given using the negative-log-likelihood of the observations based on the predicted force balance at the current time step, 

**==> picture [309 x 28] intentionally omitted <==**

The acceleration and force variances can be included in the set of learnable parameters in order to be learned. In this work, we assume these observation noise variances can be estimated _a priori_ , which can be done practically with measurements at known rest. 

For the work shown in this paper, the initial model training is still performed in the standard physicsguided GNODE workflow outlined in Algorithm 1, followed by the trained model being used in the GEKF workflow as in Algorithm 2. The reason for this is that the additional computational complexity of an _all-in-one graph-neural-EKF_ would greatly increase training cost and challenges. One benefit of _all-inone neural-EKF_ for non-topological architectures (such as a standard _Recurrent Neural Network_ (RNN)) is that they allow for KF-based virtual sensing paradigms to be included within learning architectures to improve sparse estimates without an inductive bias. Here, as there are strong inductive biases, offline virtual sensing through scenario-specific training results in a good estimate of the underlying model for the filtering procedures. The purpose of the filtering on this pretrained model, is to improve generalisation over domains which are topologically and functionally similar, but with natural variations which increase the model error. 

## **4. Nonlinear Structural Dynamics Case Studies** 

To analyse the architecture outlined here, a number of nonlinear structural dynamics problems are tested. The first two problems are simulated examples of nonlinear dynamics; the first of which is a random springmass array with cubic nonlinearities, and the second of which is a truss-bridge array with an angular-gap nonlinearity. For all system setups, observation sparsity was introduced by setting every _nm_ -th node as unmeasured, where _nm_ is defined by a sparsity percentage _ps_ , 

**==> picture [289 x 20] intentionally omitted <==**

## _4.1. Sobol array with cubic stiffness_ 

The first problem is a random truss array, defined by setting _nn_ nodes within a 5m x 5m square domain, generated using a Sobol sequence over the two-dimensional plane, which are then connected via Delaunay triangulation. The system then treats the connections between node as a spring-damper; for a connection between nodes _i_ and _j_ , the spring-damper _ij_ exerts a linear restoring force on node _i_ , a nonlinear cubic stiffness restoring force 

**==> picture [290 x 13] intentionally omitted <==**

where _kij_ , _cij_ and _κij_ are the equivalent spring stiffness, viscous damping, and nonlinear stiffness in the direction of the connection and _rij_ denotes the scalar restoring force along edge _ij_ , which contributes to the nodal force _**ξ** i_ in the global coordinate system. Boundary conditions are then assigned to the outermost (furthest from topological centre) nodes, which are connected with additional spring-damper connections to a fixed boundary of a square, for which the size depends on the number of nodes. This system is then simulated with a force input of banded white noise, applied to the lowest 4 nodes, i.e. _fi_ ( _t_ ) =GWN(0.5rad, 4rad, 2.0s). An example of such an array for 12 nodes and a measurement sparsity _ps_ = 50% is shown in Figure 6. 

11 

**==> picture [398 x 179] intentionally omitted <==**

Figure 6: Example of the random truss array with (Left) the spring mass model, where the boundary connections are shown in red and (Right) the equivalent graph model, where the boundary conditions are shown with red self-loops. The orange nodes represent those which are unmeasured. 

## _4.2. Bridge truss with angular expansion joints_ 

The second problem used in this work is a bridge-truss array, which is characterized by non-smooth nonlinearity in the form of an angular clearance stiffness. In this setup, the restoring forces acting on node _i_ from truss _ij_ is dependent on the truss angles relative to their rest angle _ϕij_ and clearance angle Φ _ij_ , 

**==> picture [360 x 31] intentionally omitted <==**

The boundary conditions were set as fixed at the outer and centres nodes, on the lowest level – representing a span bridge with a support column in the centre of the span. The equivalent spring-model and its corresponding graph is shown in Figure 7, where the boundary conditions are embedded in the graph by setting the self-loops on all nodes connected to the fixed nodes of the bridge truss model. 

**==> picture [464 x 76] intentionally omitted <==**

Figure 7: Example of the bridge truss array with (Left) the spring mass model, where the boundary connections are shown in red and (Right) the equivalent graph model, where the boundary conditions are shown with red self-loops. The orange nodes represent those which are unmeasured. 

## _4.3. Introducing Uncertainty_ 

The first and most important source of error in the model is introduced in the form of model uncertainty. For both simulation problems, the true structural parameters used in the simulation are sampled from a normal distribution, and the mean values are the nominal values prescribed in the underlying GNODE model, 

**==> picture [310 x 12] intentionally omitted <==**

The same is done for the nonlinear system parameters, however, these are assumed unknown in the PGGNODE model, 

**==> picture [365 x 12] intentionally omitted <==**

12 

Uncertainty is then introduced into the model by setting the standard deviation of the system parameters to 5% of the mean value, representing a 95% tolerance interval of _±_ 10%, the values of which are shown in Table 1. As the edges in the underlying GNN act the same function to estimate the nonlinear functions, which in truth have varying parameters but the same model form, they effectively perform mean field approximation of the nonlinear function. 

Table 1: Values of prescribed parameter distributions for simulated models. 

|Parameter _θ_|Random array system<br>_k_ [N_/_m]<br>_c_ [Ns_/_m]<br>_κ_ [N_/_m3]|Bridge truss system|
|---|---|---|
|||_k_ [N_/_m]<br>_c_ [Ns_/_m]<br>_kr_ [N_/_rad]<br>Φ [_◦_]|
|Mean _µθ_<br>STD _σθ_|200.0<br>0.1<br>1,000.0<br>10.0<br>5e-3<br>50.0|2,000.0<br>0.1<br>100.0<br>1.0<br>100.0<br>0.005<br>5.0<br>0.05|



The second source of error is in the form of measurement noise; the measured acceleration and force signals are corrupted with Gaussian white noise equivalent to a signal-to-noise ratio of 25. 

## **5. Results** 

For each system type, the offline training is performed on a smaller system (denoted the _training set_ ), and online prediction is performed on a larger similar system and over a longer time window (denoted the _testing set_ ). Details of the different model-system combinations for each prediction scheme are given in Table 2. An important note is that the larger systems all contain the same _form_ of nonlinearity, but with varied underlying true parameters as shown in Table 1. 

Table 2: Problem testing assortment. 

|System Type|Ofine training|Online prediction|
|---|---|---|
|||Models<br>System Size & Window Lengths<br>Sparsities|
|Sobol array|PGGNODE<br>16 nodes<br>4s<br>75%/87.5%|PGGNODE<br>GEKF<br>16 nodes - 4s<br>32 nodes - 8s<br>64 nodes - 8s<br>75%<br>87.5%|
|Bridge truss|PGGNODE<br>8m span<br>2s<br>75%/87.5%|PGGNODE<br>GEKF<br>8m span - 2s<br>16m span - 4s<br>24m span - 4s<br>75%s<br>87.5%s|



The results are split into sections for offline and online prediction, where the former section shows the results of the initial training which additionally acts as a reference for schemes which might aim to simply utilise offline prediction. The latter section then shows having used the pretrained models to predict in an _online_ fashion, i.e. data is streamed directly to the prediction scheme. 

For assessment of the predicted structural dynamics, the _Normalised Mean Squared Error_ (NMSE) is calculated, 

**==> picture [316 x 30] intentionally omitted <==**

where **u** is the vector of the true values and **u** ¯ is the norm of the true values. 

## _5.1. Offline training_ 

In order to assess the capability of the PGGNODE to estimate the unobserved nodes on the graphstructure, this section begins with the results of the _offline training_ stage of the architecture. For all training and results, the state estimation is performed in a recurrent manner throughout the whole time window, with no batching. 

13 

## _5.1.1. Sobol array - cubic nonlinearity_ 

Figure 8 shows the predicted and true signals of the offline training stage for the random truss array with cubic nonlinearity. The estimated signals match well with the ground truth, particularly in the acceleration and velocity estimations. There also appears to be an increasing bias in the state estimation, which is a common issue with evolutionary training methods with integration-based observations. 

**==> picture [464 x 251] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>2<br>0 . 1 25<br>0 . 0 0 0<br>− 0 . 1 − 25<br>− 2<br>0 1 2 3 4 0 1 2 3 4 0 1 2 3 4<br>2<br>0 . 1 25<br>0 . 0 0 0<br>− 0 . 1 − 2 − 25<br>0 1 2 3 4 0 1 2 3 4 0 1 2 3 4<br>0 . 2 2 25<br>0 . 0 0 0<br>− 0 . 2 − 2 − 25<br>0 1 2 3 4 0 1 2 3 4 0 1 2 3 4<br>0 . 2 2<br>25<br>0 . 0 0 0<br>− 0 . 2 − 2 − 25<br>0 1 2 3 4 0 1 2 3 4 0 1 2 3 4<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>Figure 8<br>2<br>Node<br>6<br>Node<br>10<br>Node<br>14<br>Node<br>**----- End of picture text -----**<br>


To see any effects of topology on the estimation, Figure 9 shows the NMSE at each node, for each dynamic variable. There appears to be no correlation between topology and quality of fit of the estimation to the ground truth. One potential influence would have been from boundary conditions, but there appears to be no correlation from this either. An additional potential cause may be the forcing location, but there also appears to be no effect from this. 

**==> picture [464 x 135] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud u ˙ d u ¨ d<br>0 . 20<br>0 . 06 0 . 08<br>0 . 15 0 . 06<br>0 . 04<br>0 . 04<br>0 . 10<br>0 . 02<br>0 . 02<br>0 . 05<br>Figure 9<br>NMSE NMSE NMSE<br>**----- End of picture text -----**<br>


Figure 10: Normalised mean squared error (NMSE) per node of offline GNODE predictions over 2D random array training set. 

## _5.1.2. Bridge truss - angular expansion nonlinearity_ 

The results of the estimated signals for a selection of unmeasured nodes is shown in Figure 11, where, as with the random array, the estimated signals match well with the ground truth. Compared to the random array, there appears to be less error in the displacement estimation, which is likely due to the higher stiffness of the system reducing integration drift. 

14 

**==> picture [464 x 232] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>0 . 1 2<br>25<br>0 . 0 0 0<br>− 25<br>− 0 . 1 − 2<br>0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0<br>2 . 5 50<br>0 . 1<br>0 . 0 0 . 0 0<br>− 0 . 1<br>− 2 . 5 − 50<br>0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0<br>0 . 1 2 50<br>0 . 0 0 0<br>− 0 . 1 − 2 − 50<br>0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0<br>0 . 1 2 50<br>0 . 0 0 0<br>− 0 . 1 − 2 − 50<br>0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0 0 . 0 0 . 5 1 . 0 1 . 5 2 . 0<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>0<br>Node<br>3<br>Node<br>8<br>Node<br>11<br>Node<br>**----- End of picture text -----**<br>


Figure 11: Offline GNODE predictions for the bridge truss system over the training dataset, illustrating the agreement between predicted and reference responses at selected measured and unmeasured nodes. 

The NMSE for each node and the dynamic variable for the bridge truss is shown in Figure 12, where again there is no strong effect of topology on the accuracy of the prediction. 

**==> picture [310 x 233] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud<br>0 . 04<br>0 . 02<br>u ˙ d<br>0 . 04<br>0 . 02<br>u ¨ d<br>0 . 15<br>0 . 10<br>0 . 05<br>NMSE<br>NMSE<br>NMSE<br>**----- End of picture text -----**<br>


Figure 12: Normalised mean squared error (NMSE) per node of offline GNODE predictions over 2D bridge truss training set. 

## _5.2. Online virtual sensing_ 

Following the offline training of the systems, _online sensing_ is performed with different schemes. The first scheme is to directly employ the PiGGO to attempt to estimate the response of the structure using the measured force. The second scheme is to use the GKF where the underlying transition model is performed 

15 

by the pre-trained PiGGO. For plotting of response signal estimations, the signals are bounded by a shaded area representing the 95% confidence interval, calculated as _µ ±_ 2 _σ_ . For the PiGGO the confidence interval is given for the acceleration, where _σu_ ¨ is estimated from Equation (26). For estimation from the GKF models, the state signal variances are extracted from the diagonal of Σ _t|t_ returned from the filtering scheme. The estimated variance of the observation signal (acceleration) is calculated as, 

**==> picture [286 x 14] intentionally omitted <==**

where **H** _t|t_ = _∇_ **Y** ( _f_ o( _Gt|t_ )) is the Jacobian of the observation function at the posterior estimate. 

## _5.2.1. Random truss - cubic nonlinearity_ 

_GNODE model prediction._ The response signals for four unmeasured nodes, estimed using solely using the PiGGO model are shown in Figure 8, for the latter four seconds of the signal. Compared to the offline prediction, these signals are much less accurate to the ground truth. The predictions offer a smooth response estimation, indicating that the estimated form of the function of the nonlinearity to be smooth. However, there is significant phase drift and amplitude discrepancies, indicating that the learnt model is not adequately generalised to structures with variable structural parameters. 

**==> picture [464 x 232] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>0 . 2 1 20<br>0 . 0 0 0<br>− 0 . 2 − 1 − 20<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>0 . 2 1 20<br>0 . 0 0 0<br>− 0 . 2 − 1 − 20<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>0 . 2 2 25<br>0 . 0 0 0<br>− 0 . 2 − 2 − 25<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>2<br>0 . 25 25<br>0 . 00 0 0<br>− 0 . 25 − 2 − 25<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>4<br>Node<br>11<br>Node<br>18<br>Node<br>25<br>Node<br>**----- End of picture text -----**<br>


Figure 13: Sobol array online GNODE predictions over testing set 

Figure 14 shows the NMSE at each node for the predicted response using the PiGGO. For acceleration and velocity estimation, there does not appear to be any correlation between topology and prediction accuracy, however, the appears to be larger error towards the "left" part of the structure for the displacement estimation. As the topology, forcing and boundary conditions are symmetric, this is likely to be a non-deterministic grouping of integration error. 

_GEKF model prediction._ Figure 15 shows the response estimation an in online virtual sensing context using the GKF model, which, compared to the PiGGO prediction, is much more accurate to the ground truth. There appears to be a constant bias error for the displacement prediction signal, similar to the offline training results, which is again a common issue with integration-based estimation schemes. The posterior estimate of the covariance show a reasonable uncertainty in the prediction, and is consistent over all the plotted signals. 

The NMSE at each node for the GKF prediction is shown in Figure 16. The first notable observation is the much lower error for all variables compared to the PiGGO prediction. Though the displacement estimation is has lower error, it does have again the ‘grouping’ of the error to an area of the graph. However, this time it is in a different location, indicating that this grouping is nondeterministic to the structural topology and boundary conditions. 

16 

**==> picture [464 x 380] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud u ˙ d u ¨ d<br>12 1 . 50 2 . 0<br>10 1 . 25 1 . 5<br>8 1 . 00<br>1 . 0<br>0 . 75<br>6<br>0 . 50 0 . 5<br>4<br>Figure 14: Normalised mean squared error (NMSE) per node of online GNODE predictions over 2D sobol array testing set.<br>ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>0 . 1 1 20<br>0 . 0 0 0<br>− 0 . 1 − 1 − 20<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>0 . 1 1 20<br>0 . 0 0 0<br>− 0 . 1 − 1 − 20<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>25<br>0 . 1 1<br>0 . 0 0 0<br>− 0 . 1 − 1 − 25<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>0 . 2 2 25<br>0 . 0 0 0<br>− 0 . 2 − 2 − 25<br>4 5 6 7 8 4 5 6 7 8 4 5 6 7 8<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>NMSE NMSE NMSE<br>4<br>Node<br>11<br>Node<br>18<br>Node<br>25<br>Node<br>**----- End of picture text -----**<br>


Figure 15: Sobol array online GEKF predictions over testing set 

**==> picture [464 x 118] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud u ˙ d u ¨ d<br>1 . 5<br>1 . 0<br>1 . 4<br>0 . 8<br>1 . 0<br>1 . 2<br>0 . 6<br>1 . 0<br>0 . 4 0 . 5<br>0 . 8 0 . 2<br>0 . 6<br>NMSE NMSE NMSE<br>**----- End of picture text -----**<br>


Figure 16: Normalised mean squared error (NMSE) per node of online GEKF predictions over 2D random array testing set. 

## _5.2.2. Bridge truss - angular expansion nonlinearity_ 

_GNODE model prediction._ The results of the online prediction using the PiGGO model on the testing set bridge truss structure are shown in Figure 17. Compared to the online PiGGO predictions for the random array, the bridge truss system appears to have better accuracy to the ground truth. This could be explained together with the lesser displacement error of the offline training, as a result of the overall stiffer system resulting in improved generalisation for locally variational structural parameters. 

17 

**==> picture [464 x 232] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>0 . 2 2 . 5 50<br>0 . 0 0 . 0 0<br>− 0 . 2 − 2 . 5 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1 1 25<br>0 . 0 0 0<br>− 0 . 1 − 1 − 25<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1 2 50<br>0 . 0 0 0<br>− 0 . 1 − 2 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1 2 50<br>0 . 0 0 0<br>− 0 . 1 − 2 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>25<br>0 . 1 1<br>0 . 0 0 0<br>− 0 . 1 − 1 − 25<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>0<br>Node<br>7<br>Node<br>14<br>Node<br>21<br>Node<br>28<br>Node<br>**----- End of picture text -----**<br>


Figure 17: Bridge truss online GNODE predictions over testing set 

Figure 18 shows the NMSE at each node for the online predictions of the bridge truss testing structure using PiGGO. Similar to the random array, there appears to be a grouping of nodes with lower accuracy, though this time this inaccuracy is for all dynamic variables, not solely displacement. This highlights further the indetermenistic nature of the error fo the predictions using this scheme. 

**==> picture [464 x 233] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud<br>7 . 5<br>5 . 0<br>2 . 5<br>u ˙ d<br>4<br>2<br>u ¨ d<br>0 . 8<br>0 . 6<br>0 . 4<br>NMSE<br>NMSE<br>NMSE<br>**----- End of picture text -----**<br>


Figure 18: Normalised mean squared error (NMSE) per node of online GNODE predictions over 2D bridge trust testing set. 

_GEKF model prediction._ The results of the online prediction using the GKF model on the testing set bridge truss structure are shown in Figure 19. Compared to the online PiGGO predictions, the GKF appears to have better accuracy to the ground truth. There is once again the issue of constant bias for the displacement prediction. 

18 

**==> picture [464 x 232] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud [m] u ˙ d [m/s] u ¨ d [m/s [2] ]<br>0 . 2 2 . 5 50<br>0 . 0 0 . 0 0<br>− 0 . 2 − 2 . 5 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1<br>1 25<br>0 . 0 0 0<br>− 0 . 1 − 1 − 25<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1 2 . 5<br>50<br>0 . 0 0 . 0 0<br>− 0 . 1 − 2 . 5 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>2 . 5<br>0 . 1 50<br>0 . 0 0 . 0 0<br>− 0 . 1 − 2 . 5 − 50<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>0 . 1 1 25<br>0 . 0 0 0<br>− 0 . 1 − 1 − 25<br>2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0 2 . 0 2 . 5 3 . 0 3 . 5 4 . 0<br>Time, t [s] Time, t [s] Time, t [s]<br>Ground Truth Predicted Direction x Direction y<br>0<br>Node<br>7<br>Node<br>14<br>Node<br>21<br>Node<br>28<br>Node<br>**----- End of picture text -----**<br>


Figure 19: Bridge truss online GEKF predictions over testing set 

The per-node NMSE for the GKF prediction is shown in Figure 20, where the local clustering of prediction error appears to be lessened, though is still possibly apparent for the displacement predictions. For the entire topology, the GKF predictions have much lower error compared to the PiGGO for online prediction. 

**==> picture [464 x 234] intentionally omitted <==**

**----- Start of picture text -----**<br>
ud<br>4<br>2<br>u ˙ d<br>3<br>2<br>1<br>u ¨ d<br>3<br>2<br>1<br>NMSE<br>NMSE<br>NMSE<br>**----- End of picture text -----**<br>


Figure 20: Normalised mean squared error (NMSE) per node of online GEKF predictions over 2D bridge truss testing set. 

A summary of the total NMSE over the entire structure is given in Table 3, where each variable is calculated using Equation (33) independently. It can be seen from the table that the GKF consistently reduces the error in the prediction of response of the structure, given a noisy measured input. 

19 

**==> picture [446 x 300] intentionally omitted <==**

**----- Start of picture text -----**<br>
Displacement, u Velocity, u ˙ Acceleration, u ¨<br>10 [3]<br>100<br>10<br>1<br>0 . 1<br>0 . 01<br>10 [−] [3]<br>32N 64N 32N 64N 32N 64N<br>10 [3]<br>100<br>10<br>1<br>0 . 1<br>0 . 01<br>10 [−] [3]<br>30N 45N 30N 45N 30N 45N<br>Test Size Test Size Test Size<br>ptr =75% - ps =75% ptr =75% - ps =87% ptr =87% - ps =75% ptr =87% - ps =87%<br>GNODE<br>GNEKF<br>Sobol<br>NMSE<br>Array<br>Bridge<br>NMSE<br>Truss<br>**----- End of picture text -----**<br>


Figure 21: Comparison of averaged NMSE values for different combinations of training sparsity, testing sparsity and prediction model for the Sobol array and bridge truss systems. 

Table 3: Summary of NMSE of the case studies. 

|System|PGGNODE<br>**u**<br>˙**u**<br>¨**u**|PGGNODE-GEKF|
|---|---|---|
|||**u**<br>˙**u**<br>¨**u**|
|16-node random array|4.077<br>0.020<br>0.013|3.463<br>0.034<br>0.023|
|32-node random array|24.538<br>2.644<br>2.730|0.298<br>0.016<br>0.016|
|8m wide bridge|0.088<br>0.052<br>0.075|0.051<br>0.012<br>0.026|
|16m wide bridge|30.199<br>0.377<br>0.316|0.758<br>0.027<br>0.052|



## **6. Discussion** 

The first stage of the proposed scheme involves offline training of the PiGGO model, which by itself additionally acts as an approach for offline virtual sensing. The accuracy of the virtual sensing scheme for recovering the response at unmeasured nodes is highlighted in Figures 8, 9, 11 and 12, where it shows the inductive biases provide a powerful model for such a scheme. However, such a model appears to not be well generalised for structures with uncertainty in local properties, as indicated by the lower performance when estimating the response of a different larger, but topologically and functionally similar, structure. The smoothness of the prediction, indicates that the estimated function is adequately smooth, but the model form assumes constant model parameter; i.e. it estimates the nonlinearity to have the same stiffness or clearance angle everywhere in the structure. 

By implementing the learnt PiGGO model into a GKF framework, online predictions on unseen structures are significantly improved. As seen in the PiGGO predictions, the model suffers from unknown variation in structural properties, which reduces generalisation over structural topology. Furthermore, although the predicted uncertainty is larger, the filtering scheme provides an improved and more appropriate estimate. 

20 

Not only does the scheme provide estimates for all dynamic variables, the uncertainty bounds enevelope the true responses, indicating a better match. This is intuitive, as the uncertainty is estimated directly from comparisons between predictions and data, thus capture model form and noise uncertainty, as opposed to with the PiGGO scheme where they are estimated from equations which assume no model uncertainty. 

As the GKF model uses the extended Kalman filter scheme, it can be deduced that the PiGGO is well generalised to the model _form_ (reminder; it assumes the local nonlinearities to have the same form and parameter). The filtering schemes assumes Gaussian error which does not handle discrete errors well, indicating that the representative equation of the learned model is inaccurate in the form of a normallydistributed error. However, this also highlights a potential limitation; that the underlying uncertainty which reduces generalisation follows a Gaussian distribution, though this could be tackled by employing _Kalman Filter_ (KF) schemes adapted to handle non-Gaussian distributions, such as unscented or particle filtering schemes. 

An additional limitation of the proposed scheme is that the offline training requires the known initial position. As the nature of the scheme is to learn a generalised model for structures of similar types, but varying topologies, this limitation may not be excessively restricting, as the learning stage can be performed in a controlled or experimental context, where initial states are known. For scenarios where initial states are difficult to obtain, such as a population of in-situ structures with no rest, then one would need to train a Graph-Neural Extended Kalman Filter with a long time window, to overcome initial state error. The longer required time window, combined with the additional training model complexity, would present a difficult technical challenge for training and is beyond the scope of this work. 

A final consideration of the architecture is that there is an assumption of global nonlinearities, i.e. that the nonlinearities exist and are of the same form over the entire structure. Further work is required to account for such problems, where the achitecture can be adapted to include local estimation of the presence, or form, of nonlinearities. This could be done with layered GNNs, where an additional layer is used as a ‘switching’ model for the nonlinearity. An alternative approach is to adapt the prescription of the GKF by Alippi & Zambon [46], where the adjacency matrix is an additional accountable uncertainty, which determines the time-variant existence of edge connections representing nonlinearities. 

## **7. Conclusion** 

This study introduced the Physics-Guided Graph Neural ODE (PiGGO) framework, which combines a graph-based, physics-informed state evolution model with extended Kalman filtering for online virtual sensing of nonlinear structural systems. The proposed approach leverages inductive biases derived from structural mechanics to constrain the learning of nonlinear dynamics, enabling robust performance under sparse sensing and model-form uncertainty, where only nominal system parameters are assumed _a priori_ . The numerical investigations demonstrate that the PiGGO–EKF scheme achieves accurate and stable state estimation across structurally similar systems with varying properties, outperforming purely datadriven and open-loop graph neural models in terms of generalisation and robustness. In addition, the probabilistic filtering formulation provides uncertainty-aware predictions, with posterior covariance estimates that meaningfully capture the variability in the true system response. 

Overall, the framework offers a unified approach for integrating physics-guided learning and Bayesian filtering within a graph-based representation of structural systems. Future work will focus on extending the methodology to more complex nonlinearities, including localised and non-smooth behaviours, as well as exploring adaptive graph representations and fully integrated end-to-end learning of the filtering process. 

## **Supplementary information** 

All the code and data for this article is available open access at a Github repository available at https://github.com/MarcusHA94/struct-pggnode. 

## **Acknowledgements** 

The authors gratefully acknowledge the funding from the State Secretariat for Education, Research, and Innovation (SERI) as matching funding for the Horizon Europe project ‘ReCharged - Climate-aware 

21 

Resilience for Sustainable Critical and interdependent Infrastructure Systems enhanced by emerging Digital Technologies’ (grant agreement No: 101086413), and funding from the French National Research Agency (ANR PRCI Grant No. 266157) and the Swiss National Science Foundation (Grant No. 200021L_212718) for the MISTERY project. 

## **Declarations** 

The authors declare no conflicts of interest. 

## **Appendix A Corotational Kinematics Calculations** 

- **p** 0 _,k ∈_ R[2] : The nominal position of node _k_ in _x_ and _y_ directions. 

- **u** _k_ ( _t_ ) _∈_ R[2] : The displacement of node _k_ in _x_ and _y_ directions. 

- **p** _k_ ( _t_ ) = **p** 0 _,k_ + **u** _k_ : The current position of node _k_ . 

- **v** _k_ ( _t_ ) = _[d] dt_ **[p]** _[k]_[:][The][velocity][of][node] _[k]_[.] 

- **p** _a,j ∈_ R[2] : The position of a fixed anchor point for a boundary node _j_ . 

- _L_ 0 _,ij_ : The rest length of the edge. 

The current vector for edge _ij_ is 

**==> picture [265 x 12] intentionally omitted <==**

And for self-loop edges (boundary edges), with anchor points **p** _a,i_ 

**==> picture [268 x 11] intentionally omitted <==**

Then, the edge length and direction are 

**==> picture [293 x 24] intentionally omitted <==**

Finally, the edge extension, rate, and angle are, 

**==> picture [392 x 11] intentionally omitted <==**

## **References** 

- [1] J. Michael, J. Blankenbach, J. Derksen, B. Finklenburg, R. Fuentes, T. Gries, S. Hendiani, S. Herlé, S. Hesseler, M. Kimm, et al., Integrating models of civil structures in digital twins: State-of-the-art and challenges, Journal of Infrastructure Intelligence and Resilience 3 (3) (2024) 100100. 

- [2] M. Torzoni, M. Tezzele, S. Mariani, A. Manzoni, K. E. Willcox, A digital twin framework for civil engineering structures, Computer Methods in Applied Mechanics and Engineering 418 (2024) 116584. 

- [3] C. Ye, L. Butler, C. Bartek, M. Iangurazov, Q. Lu, A. Gregory, M. Girolami, C. Middleton, A digital twin of bridges for structural health monitoring, in: 12th International Workshop on Structural Health Monitoring 2019, Stanford University, 2019. 

- [4] X. Lai, L. Yang, X. He, Y. Pang, X. Song, W. Sun, Digital twin-based structural health monitoring by combining measurement and computational data: An aircraft wing example, Journal of Manufacturing Systems 69 (2023) 76–90. 

- [5] T. Hielscher, S. Khalil, N. Virgona, S. Hadigheh, A neural network based digital twin model for the structural health monitoring of reinforced concrete bridges, in: Structures, Vol. 57, Elsevier, 2023, p. 105248. 

22 

- [6] S. Vettori, E. Di Lorenzo, B. Peeters, M. Luczak, E. Chatzi, An adaptive-noise augmented kalman filter approach for input-state estimation in structural dynamics, Mechanical Systems and Signal Processing 184 (2023) 109654. 

- [7] S. Vettori, E. Di Lorenzo, B. Peeters, E. Chatzi, A virtual sensing approach to operational modal analysis of wind turbine blades, in: Proceedings of ISMA2020 International Conference on Noise and Vibration Engineering, Leuven, Belgium, 2020. 

- [8] A. Kamariotis, E. Chatzi, Bayesian decision-theoretic model selection for monitored systems, in: IMAC, A Conference and Exposition on Structural Dynamics, Springer, 2024, pp. 115–121. 

- [9] M. G. Kapteyn, J. V. Pretorius, K. E. Willcox, A probabilistic graphical model foundation for enabling predictive digital twins at scale, Nature Computational Science 1 (5) (2021) 337–347. 

- [10] K. Worden, E. Cross, R. Barthorpe, D. Wagg, P. Gardner, On digital twins, mirrors, and virtualizations: Frameworks for model verification and validation, ASCE-ASME J Risk and Uncert in Engrg Sys Part B Mech Engrg 6 (3) (2020). 

- [11] E. Simoen, G. De Roeck, G. Lombaert, Dealing with uncertainty in model updating for damage assessment: A review, Mechanical Systems and Signal Processing 56 (2015) 123–149. 

- [12] J. Ríos, G. Staudter, M. Weber, R. Anderl, A. Bernard, Uncertainty of data and the digital twin: a review, International Journal of Product Lifecycle Management 12 (4) (2020) 329–358. 

- [13] G. Shi, Z. Liu, D. Lu, Z. Wang, Z. Jiao, C. Ji, Z. Zhang, Construction error control method of large-span spatial structures based on digital twin, Journal of Building Engineering 98 (2024) 111311. 

- [14] K. Worden, C. R. Farrar, G. Manson, G. Park, The fundamental axioms of structural health monitoring, Proceedings of the Royal Society A: Mathematical, Physical and Engineering Sciences 463 (2082) (2007) 1639–1664. 

- [15] C. R. Farrar, K. Worden, Structural health monitoring: a machine learning perspective, John Wiley & Sons, 2012. 

- [16] J. Legault, R. Langley, J. Woodhouse, Physical consequences of a nonparametric uncertainty model in structural dynamics, Journal of sound and vibration 331 (2012) 5469–5487. 

- [17] R. J. Barthorpe, On model-and data-based approaches to structural health monitoring, Ph.D. thesis, University of Sheffield (2010). 

- [18] A. Ghadami, B. I. Epureanu, Data-driven prediction in dynamical systems: recent developments, Philosophical Transactions of the Royal Society A 380 (2229) (2022) 20210213. 

- [19] A. Cicirello, Physics-enhanced machine learning: a position paper for dynamical systems investigations, in: Journal of Physics: Conference Series, Vol. 2909, IOP Publishing, 2024, p. 012034. 

- [20] E. J. Cross, S. J. Gibson, M. R. Jones, D. J. Pitchforth, S. Zhang, T. J. Rogers, Physics-informed machine learning for structural health monitoring, in: Structural health monitoring based on data science techniques, Springer, 2021, pp. 347–367. 

- [21] M. Haywood-Alexander, W. Liu, K. Bacsa, Z. Lai, E. Chatzi, Discussing the spectrum of physicsenhanced machine learning: a survey on structural mechanics applications, Data-Centric Engineering 5 (2024) e30. 

- [22] L. Sun, H. Sun, W. Zhang, Y. Li, Hybrid monitoring methodology: A model-data integrated digital twin framework for structural health monitoring and full-field virtual sensing, Advanced Engineering Informatics 60 (2024) 102386. 

- [23] S. A. Zargar, F.-G. Yuan, Physics-informed deep learning for scattered full wavefield reconstruction from a sparse set of sensor data for impact diagnosis in structural health monitoring, Structural Health Monitoring 23 (5) (2024) 2963–2979. 

23 

- [24] M. Zhang, T. Guo, G. Zhang, Z. Liu, W. Xu, Physics-informed deep learning for structural vibration identification and its application on a benchmark structure, Philosophical Transactions of the Royal Society A 382 (2264) (2024) 20220400. 

- [25] M. Haywood-Alexander, G. Arcieri, A. Kamariotis, E. Chatzi, Response estimation and system identification of dynamical systems via physics-informed neural networks, Advanced Modeling and Simulation in Engineering Sciences 12 (1) (2025) 8. 

- [26] R. Zhang, G. P. Warn, A. Radlińska, Dual state-parameter estimation of continuous structural systems with physics-informed parallel neural networks, Journal of Sound and Vibration 571 (2024) 118138. 

- [27] V. Gupta, F. Marsili, S. Kessler, M. Maleshkova, Physics-informed neural networks used for structural health monitoring in civil infrastructures: State of art and current challenges (2025). 

- [28] W. Liu, Z. Lai, K. Bacsa, E. Chatzi, Physics-guided deep markov models for learning nonlinear dynamical systems with uncertainty, Mechanical Systems and Signal Processing 178 (2022) 109276. 

- [29] G. Tsialiamanis, C. Mylonas, E. Chatzi, N. Dervilis, D. J. Wagg, K. Worden, Foundations of populationbased shm, part iv: The geometry of spaces of structures and their feature spaces, Mechanical Systems and Signal Processing 157 (2021) 107692. 

- [30] X. Jian, Y. Xia, G. Duthé, K. Bacsa, W. Liu, E. Chatzi, Using graph neural networks and frequency domain data for automated operational modal analysis of populations of structures, Data-Centric Engineering 6 (2025) e45. 

- [31] M. Poli, S. Massaroli, J. Park, A. Yamashita, H. Asama, J. Park, Graph neural ordinary differential equations, arXiv preprint arXiv:1911.07532 (2019). 

- [32] R. T. Chen, Y. Rubanova, J. Bettencourt, D. K. Duvenaud, Neural ordinary differential equations, Advances in neural information processing systems 31 (2018). 

- [33] G. Tsialiamanis, N. Dervilis, D. J. Wagg, K. Worden, Towards a population-informed approach to the definition of data-driven models for structural dynamics, Mechanical Systems and Signal Processing 200 (2023) 110581. 

- [34] K. E. Tatsis, V. K. Dertimanis, E. N. Chatzi, Sequential bayesian inference for uncertain nonlinear dynamic systems: a tutorial, arXiv preprint arXiv:2201.08180 (2022). 

- [35] S. E. Azam, E. Chatzi, C. Papadimitriou, A dual kalman filter approach for state estimation via outputonly acceleration measurements, Mechanical systems and signal processing 60 (2015) 866–886. 

- [36] C. K. Chui, G. Chen, Kalman filtering: with real-time applications, Springer, 2009. 

- [37] D. Simon, Optimal state estimation: Kalman, H infinity, and nonlinear approaches, John Wiley & Sons, 2006. 

- [38] L. Pyrhönen, S. Jaiswal, A. Garcia-Agundez, D. García Vallejo, A. Mikkola, Linearization-based statetransition model for the discrete extended kalman filter applied to multibody simulations, Multibody System Dynamics 57 (1) (2023) 55–72. 

- [39] D. Li, Y. Wang, Parameter identification of a differentiable bouc-wen model using constrained extended kalman filter, Structural Health Monitoring 20 (1) (2021) 360–378. 

- [40] W. Liu, Z. Lai, K. Bacsa, E. Chatzi, Neural extended kalman filters for learning and predicting dynamics of structural systems, Structural Health Monitoring 23 (2) (2024) 1037–1052. 

- [41] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, Y. C. Eldar, Kalmannet: Neural network aided kalman filtering for partially known dynamics, IEEE Transactions on Signal Processing 70 (2022) 1532–1547. 

24 

- [42] J. Xia, D. Li, H. Gu, T. Lu, P. Zhang, L. Shang, N. Gu, Neural kalman filtering for robust temporal recommendation, in: Proceedings of the 17th ACM International Conference on Web Search and Data Mining, 2024, pp. 836–845. 

- [43] W. Li, X. Fu, B. Zhang, Y. Liu, Unscented kalman filter of graph signals, Automatica 148 (2023) 110796. 

- [44] G. Sagi, N. Shlezinger, T. Routtenberg, Extended kalman filter for graph signals in nonlinear dynamic systems, in: ICASSP 2023-2023 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP), IEEE, 2023, pp. 1–5. 

- [45] M. Sabbaqi, R. Taormina, E. Isufi, Gknet: Graph kalman filtering and model inference via model-based deep learning (2025). `arXiv:2506.22004` . URL `https://arxiv.org/abs/2506.22004` 

- [46] C. Alippi, D. Zambon, Graph kalman filters, arXiv preprint arXiv:2303.12021 (2023). 

- [47] Y. Sun, Y.-C. Lu, K. Fu, F. Chen, C.-T. Lu, Detecting anomalous traffic behaviors with seasonal deep kalman filter graph convolutional neural networks, Journal of King Saud University-Computer and Information Sciences 34 (8) (2022) 4729–4742. 

- [48] I. Buchnik, G. Sagi, N. Leinwand, Y. Loya, N. Shlezinger, T. Routtenberg, Gsp-kalmannet: Tracking graph signals via neural-aided kalman filtering, IEEE Transactions on Signal Processing (2024). 

- [49] J. Gilmer, S. S. Schoenholz, P. F. Riley, O. Vinyals, G. E. Dahl, Neural message passing for quantum chemistry, in: International conference on machine learning, Pmlr, 2017, pp. 1263–1272. 

- [50] M. Fey, J. E. Lenssen, Fast graph representation learning with pytorch geometric, arXiv preprint arXiv:1903.02428 (2019). 

- [51] M. Y. Wang, Deep graph library: Towards efficient and scalable deep learning on graphs, in: ICLR workshop on representation learning on graphs and manifolds, 2019. 

- [52] D. Grattarola, C. Alippi, Graph neural networks in tensorflow and keras with spektral [application notes], IEEE Computational Intelligence Magazine 16 (1) (2021) 99–106. 

- [53] A. Sanchez-Gonzalez, J. Godwin, T. Pfaff, R. Ying, J. Leskovec, P. Battaglia, Learning to simulate complex physics with graph networks, in: International conference on machine learning, PMLR, 2020, pp. 8459–8468. 

- [54] F. de N Santos, G. Duthé, I. Abdallah, P.-É. Réthoré, W. Weijtjens, E. Chatzi, C. Devriendt, Multivariate prediction on wake-affected wind turbines using graph neural networks, in: Journal of Physics: Conference Series, Vol. 2647, IOP Publishing, 2024, p. 112006. 

- [55] G. Duthé, I. Abdallah, E. Chatzi, Graph transformers for inverse physics: reconstructing flows around arbitrary 2d airfoils, arXiv preprint arXiv:2501.17081 (2025). 

- [56] P. W. Battaglia, J. B. Hamrick, V. Bapst, A. Sanchez-Gonzalez, V. Zambaldi, M. Malinowski, A. Tacchetti, D. Raposo, A. Santoro, R. Faulkner, et al., Relational inductive biases, deep learning, and graph networks, arXiv preprint arXiv:1806.01261 (2018). 

- [57] T. Pfaff, M. Fortunato, A. Sanchez-Gonzalez, P. Battaglia, Learning mesh-based simulation with graph networks, in: International conference on learning representations, 2020. 

- [58] P. Veličković, G. Cucurull, A. Casanova, A. Romero, P. Lio, Y. Bengio, Graph attention networks, arXiv preprint arXiv:1710.10903 (2017). 

- [59] K. Xu, W. Hu, J. Leskovec, S. Jegelka, How powerful are graph neural networks?, arXiv preprint arXiv:1810.00826 (2018). 

- [60] S. Zhang, H. Tong, J. Xu, R. Maciejewski, Graph convolutional networks: a comprehensive review, Computational Social Networks 6 (1) (2019) 1–23. 

25 

- [61] J. M. Thomas, A. Moallemy-Oureh, S. Beddar-Wiesing, C. Holzhüter, Graph neural networks designed for different graph types: A survey, arXiv preprint arXiv:2204.03080 (2022). 

- [62] Q.-H. Ngo, B. L. Nguyen, T. V. Vu, J. Zhang, T. Ngo, Physics-informed graphical neural network for power system state estimation, Applied Energy 358 (2024) 122602. 

- [63] S. Bishnoi, R. Bhattoo, S. Ranu, N. Krishnan, Enhancing the inductive biases of graph neural ode for modeling dynamical systems, arXiv preprint arXiv:2209.10740 (2022). 

- [64] A. Thangamuthu, G. Kumar, S. Bishnoi, R. Bhattoo, N. Krishnan, S. Ranu, Unravelling the performance of physics-informed graph neural networks for dynamical systems, Advances in Neural Information Processing Systems 35 (2022) 3691–3702. 

- [65] S. Batzner, A. Musaelian, L. Sun, M. Geiger, J. P. Mailoa, M. Kornbluth, N. Molinari, T. E. Smidt, B. Kozinsky, E(3)-equivariant graph neural networks for data-efficient and accurate interatomic potentials, Nature Communications 13 (1) (May 2022). `doi:10.1038/s41467-022-29939-5` . URL `http://dx.doi.org/10.1038/s41467-022-29939-5` 

- [66] V. G. Satorras, E. Hoogeboom, M. Welling, E(n) equivariant graph neural networks (2022). `arXiv: 2102.09844` . URL `https://arxiv.org/abs/2102.09844` 

- [67] V. Sharma, R. T. Oddon, P. Tesini, J. Ravesloot, C. Taal, O. Fink, Equi-euler graphnet: An equivariant, temporal-dynamics informed graph neural network for dual force and trajectory prediction in multibody systems, Mechanical Systems and Signal Processing 241 (2025) 113533. `doi:https://doi.org/ 10.1016/j.ymssp.2025.113533` . URL `https://www.sciencedirect.com/science/article/pii/S0888327025012348` 

- [68] Y. Kim, H. Bang, Introduction to kalman filter and its applications, in: Introduction and implementations of the Kalman filter, IntechOpen, 2018. 

26 

