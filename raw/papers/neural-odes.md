---
source_url: 
ingested: 2026-04-29
sha256: a2363e0520f578c2e469e93411108d47234ed716136153590b6a13b6aa64bf2e
---

## **Neural Ordinary Differential Equations** 

## **Ricky T. Q. Chen*, Yulia Rubanova*, Jesse Bettencourt*, David Duvenaud** University of Toronto, Vector Institute 

����������������������������������������������������� 

## **Abstract** 

We introduce a new family of deep neural network models. Instead of specifying a discrete sequence of hidden layers, we parameterize the derivative of the hidden state using a neural network. The output of the network is computed using a blackbox differential equation solver. These continuous-depth models have constant memory cost, adapt their evaluation strategy to each input, and can explicitly trade numerical precision for speed. We demonstrate these properties in continuous-depth residual networks and continuous-time latent variable models. We also construct continuous normalizing flows, a generative model that can train by maximum likelihood, without partitioning or ordering the data dimensions. For training, we show how to scalably backpropagate through any ODE solver, without access to its internal operations. This allows end-to-end training of ODEs within larger models. 

## **1 Introduction** 

Models such as residual networks, recurrent neural network decoders, and normalizing flows build complicated transformations by composing a sequence of transformations to a hidden state: 

**==> picture [150 x 11] intentionally omitted <==**

where _t ∈{_ 0 _. . . T }_ and **h** _t ∈_ R _[D]_ . These iterative updates can be seen as an Euler discretization of a continuous transformation (Lu et al., 2017; Haber and Ruthotto, 2017; Ruthotto and Haber, 2018). 

What happens as we add more layers and take smaller steps? In the limit, we parameterize the continuous dynamics of hidden units using an ordinary differential equation (ODE) specified by a neural network: 

**==> picture [147 x 22] intentionally omitted <==**

**==> picture [173 x 122] intentionally omitted <==**

**----- Start of picture text -----**<br>
Residual Network ODE Network<br>� �<br>� �<br>� �<br>� �<br>� �<br>� �<br>� � � � � �<br>������������������� �������������������<br>����� �����<br>**----- End of picture text -----**<br>


Figure 1: _Left:_ discrete sequence of finite transformations. _Right:_ A ODE network defines a vector field, which continuously transforms the state. _Both:_ Circles represent evaluation locations. 

Starting from the input layer **h** (0), we can define the output layer **h** ( _T_ ) to be the solution to this ODE initial value problem at some time _T_ . This value can be computed by a black-box differential equation solver, which evaluates the hidden unit dynamics _f_ wherever necessary to determine the solution with the desired accuracy. Figure 1 contrasts these two approaches. 

In Section 2, we show how to compute gradients of a scalar-valued loss with respect to all inputs of any ODE solver, _without backpropagating through the operations of the solver_ . Not storing any intermediate quantities of the forward pass allows us to train our models with constant memory cost as a function of depth, a major bottleneck of training deep models. 

32nd Conference on Neural Information Processing Systems (NeurIPS 2018), Montréal, Canada. 

**Adaptive computation** Euler’s method is perhaps the simplest method for solving ODEs. There have since been more than 120 years of development of efficient and accurate ODE solvers (Runge, 1895; Kutta, 1901; Hairer et al., 1987). Modern ODE solvers provide guarantees about the growth of approximation error, monitor the level of error, and adapt their evaluation strategy on the fly to achieve the requested level of accuracy. This allows the cost of evaluating a model to scale with problem complexity. After training, accuracy can be reduced for real-time or low-power applications. 

When the hidden unit dynamics are parameterized as a continuous function of time, the parameters of nearby “layers” are automatically tied together. In Section 3, we show that this reduces the number of parameters required on a supervised learning task. 

An unexpected side-benefit of continuous transformations is that the change of variables formula becomes easier to compute. In Section 4, we derive this result and use it to construct a new class of invertible density models that avoids the single-unit bottleneck of normalizing flows, and can be trained directly by maximum likelihood. 

**Continuous time-series models** Unlike recurrent neural networks, which require discretizing observation and emission intervals, continuously-defined dynamics can naturally incorporate data which arrives at arbitrary times. In Section 5, we construct and demonstrate such a model. 

## **2 Reverse-mode automatic differentiation of ODE solutions** 

The main technical in training continuous-depth networks is performing reverse-mode differentiation (also known as backpropagation) through the ODE solver. Differentiating through the operations of the forward pass is straightforward, but incurs a high memory cost and introduces additional numerical error. 

We treat the ODE solver as a black box, and compute gradients using the _adjoint sensitivity method_ (Pontryagin et al., 1962). This approach computes gradients by solving a second, augmented ODE backwards in time, and is applicable to all ODE solvers. This approach scales linearly with problem size, has low memory cost, and explicitly controls numerical error. 

Consider optimizing a scalar-valued loss function _L_ (), whose input is the result of an ODE solver: 

**==> picture [396 x 173] intentionally omitted <==**

To optimize _L_ , we require gradients with respect to _θ_ . The first step is to determining how the gradient of the loss depends on the hidden state **z** ( _t_ ) at each instant. This quantity is called the _adjoint_ **a** ( _t_ ) = _[∂L] /∂_ **z** ( _t_ ). Its dynamics are given by another ODE, which can be thought of as the instantaneous analog of the chain rule: 

_d_ **a** ( _t_ ) = _−_ **a** ( _t_ )[T] _[∂][f]_[(] **[z]**[(] _[t]_[)] _[,][ t][,][ θ]_[)] (4) _dt ∂_ **z** We can compute _[∂L] /∂_ **z** ( _t_ 0) by another call to an ODE solver. This solver must run backwards, starting from the initial value of _[∂L] /∂_ **z** ( _t_ 1). One complication is that solving this ODE requires the knowing value of **z** ( _t_ ) along its entire trajectory. However, we can simply recompute **z** ( _t_ ) backwards in time together with the adjoint, starting from its final value **z** ( _t_ 1). 

Figure 2: Reverse-mode differentiation of an ODE solution. The adjoint sensitivity method solves an augmented ODE backwards in time. The augmented system contains both the original state and the sensitivity of the loss with respect to the state. If the loss depends directly on the state at multiple observation times, the adjoint state must be updated in the direction of the partial derivative of the loss with respect to each observation. 

Computing the gradients with respect to the parameters _θ_ requires evaluating a third integral, which depends on both **z** ( _t_ ) and **a** ( _t_ ): 

**==> picture [160 x 26] intentionally omitted <==**

2 

> _[∂][f][∂][f]_ The vector-Jacobian products **a** ( _t_ ) _[T] ∂_ **z**[and] **[ a]**[(] _[t]_[)] _[T] ∂θ_[in][ (][4][)][ and][ (][5][)][ can be efficiently evaluated by] automatic differentiation, at a time cost similar to that of evaluating _f_ . All integrals for solving **z** , **a** and _[∂L] ∂θ_[can be computed in a single call to an ODE solver, which concatenates the original state, the] adjoint, and the other partial derivatives into a single vector. Algorithm 1 shows how to construct the necessary dynamics, and call an ODE solver to compute all gradients at once. 

**Algorithm 1** Reverse-mode derivative of an ODE initial value problem 

|**Input:** dynamics parameters_θ_, start time_t_0, stop time_t_1, fnal state**z**(_t_1), loss gradient _∂L/∂_**z**(_t_1)|
|---|
|_s_0 = [**z**(_t_1)_,_<br>_∂L_<br>_∂_**z**(_t_1)_,_**0**_|θ|_]<br>_�_Defne initial augmented state<br>**def**aug_dynamics([**z**(_t_)_,_**a**(_t_)_, ·_]_, t, θ_):<br>_�_Defne dynamics on augmented state|
|**return**[_f_(**z**(_t_)_, t, θ_)_, −_**a**(_t_)T _∂f_<br>_∂_**z** _, −_**a**(_t_)T_∂f_<br>_∂θ_ ]<br>_�_Compute vector-Jacobian products|
|[**z**(_t_0)_,_<br>_∂L_<br>_∂_**z**(_t_0)_, ∂L_<br>_∂θ_ ] =ODESolve(_s_0_,_aug_dynamics_, t_1_, t_0_, θ_)<br>_�_Solve reverse-time ODE|
|**return**<br>_∂L_<br>_∂_**z**(_t_0)_, ∂L_<br>_∂θ_<br>_�_Return gradients|



Most ODE solvers have the option to output the state **z** ( _t_ ) at multiple times. When the loss depends on these intermediate states, the reverse-mode derivative must be broken into a sequence of separate solves, one between each consecutive pair of output times (Figure 2). At each observation, the adjoint must be adjusted in the direction of the corresponding partial derivative _[∂L] /∂_ **z** ( _ti_ ). 

The results above extend those of Stapor et al. (2018, section 2.4.2). An extended version of Algorithm 1 including derivatives w.r.t. _t_ 0 and _t_ 1 can be found in Appendix C. Detailed derivations are provided in Appendix B. Appendix D provides Python code which computes all derivatives for ���������������������� by extending the �������� automatic differentiation package. This code also supports all higher-order derivatives. We have since released a PyTorch (Paszke et al., 2017) implementation, including GPU-based implementations of several standard ODE solvers at ������������������������������� . 

## **3 Replacing residual networks with ODEs for supervised learning** 

In this section, we experimentally investigate the training of neural ODEs for supervised learning. 

**Software** To solve ODE initial value problems numerically, we use the implicit Adams method implemented in LSODE and VODE and interfaced through the ��������������� package. Being an implicit method, it has better guarantees than explicit methods such as Runge-Kutta but requires solving a nonlinear optimization problem at every step. This setup makes direct backpropagation through the integrator difficult. We implement the adjoint sensitivity method in Python’s �������� framework (Maclaurin et al., 2015). For the experiments in this section, we evaluated the hidden state dynamics and their derivatives on the GPU using Tensorflow, which were then called from the Fortran ODE solvers, which were called from Python �������� code. 

**Model Architectures** We experiment with a small residual network which downsamples the input twice then applies 6 standard residual blocks He et al. (2016b), which are replaced by an ODESolve module in the ODE-Net variant. We also test a network with the same architecture but where gradients are backpropagated directly through a Runge-Kutta integrator, re- 

Table 1: Performance on MNIST. _[†]_ From LeCun et al. (1998). 

|||Test Error|# Params|Memory|Time|
|---|---|---|---|---|---|
||1-Layer MLP_†_|1.60%|0.24 M|-|-|
||ResNet|0.41%|0.60 M|_O_(_L_)|_O_(_L_)|
||RK-Net<br>ODE-Net|0.47%<br>0.42%|0.22 M<br>0.22 M|_O_(˜_L_)<br>**_O_(1)**|_O_(˜_L_)<br>_O_(˜_L_)|



ferred to as RK-Net. Table 1 shows test error, number of parameters, and memory cost. _L_ denotes the number of layers in the ResNet, and _L_[˜] is the number of function evaluations that the ODE solver requests in a single forward pass, which can be interpreted as an implicit number of layers. 

using fewer parameters. For reference, a neural net with a single hidden layer of 300 units has around the same number of parameters as the ODE-Net and RK-Net architecture that we tested. 

3 

**Error Control in ODE-Nets** ODE solvers can approximately ensure that the output is within a given tolerance of the true solution. Changing this tolerance changes the behavior of the network. We first verify that error can indeed be controlled in Figure 3a. The time spent by the forward call is proportional to the number of function evaluations (Figure 3b), so tuning the tolerance gives us a trade-off between accuracy and computational cost. One could train with high accuracy, but switch to a lower accuracy at test time. 

**==> picture [101 x 84] intentionally omitted <==**

**==> picture [101 x 84] intentionally omitted <==**

**==> picture [101 x 83] intentionally omitted <==**

**==> picture [93 x 77] intentionally omitted <==**

Figure 3: Statistics of a trained ODE-Net. (NFE = number of function evaluations.) 

Figure 3c) shows a surprising result: the number of evaluations in the backward pass is roughly half of the forward pass. This suggests that the adjoint sensitivity method is not only more memory efficient, but also more computationally efficient than directly backpropagating through the integrator, because the latter approach will need to backprop through each function evaluation in the forward pass. 

> **Network Depth** A related quantity is the number of evaluations of the hidden state dynamics required, a detail delegated to the ODE solver and dependent on the initial state or input. Figure 3d shows that he number of function evaluations increases throughout training, presumably adapting to increasing complexity of the model. 

## **4 Continuous Normalizing Flows** 

The discretized equation (1) also appears in normalizing flows (Rezende and Mohamed, 2015) and the NICE framework (Dinh et al., 2014). These methods use the change of variables theorem to compute exact changes in probability if samples are transformed through a bijective function _f_ : 

**==> picture [314 x 25] intentionally omitted <==**

Rezende and Mohamed, 2015): 

**==> picture [373 x 25] intentionally omitted <==**

Generally, the main bottleneck to using the change of variables formula is computing of the determinant of the Jacobian _[∂f] /∂_ **z** , which has a cubic cost in either the dimension of **z** , or the number of hidden units. Recent work explores the tradeoff between the expressiveness of normalizing flow layers and computational cost (Kingma et al., 2016; Tomczak and Welling, 2016; Berg et al., 2018). 

Surprisingly, moving from a discrete set of layers to a continuous transformation the computation of the change in normalizing constant: 

**Theorem 1** (Instantaneous Change of Variables) **.** _Let_ **z** ( _t_ ) _be a finite continuous random variable with probability p_ ( **z** ( _t_ )) _dependent on time. Let[d] dt_ **[z]**[=] _[ f]_[(] **[z]**[(] _[t]_[)] _[, t]_[)] _[ be a differential equation describing] a continuous-in-time transformation of_ **z** ( _t_ ) _. Assuming that f is uniformly Lipschitz continuous in_ **z** _and continuous in t, then the change in log probability also follows a differential equation,_ 

**==> picture [259 x 25] intentionally omitted <==**

Proof in Appendix A. Instead of the log determinant in (6), we now only require a trace operation. Also unlike standard finite flows, the differential equation _f_ does not need to be bijective, since if uniqueness is satisfied, then the entire transformation is automatically bijective. 

4 

As an example application of the instantaneous change of variables, we can examine the continuous analog of the planar flow, and its change in normalization constant: 

**==> picture [311 x 25] intentionally omitted <==**

Given an initial distribution _p_ ( **z** (0)), we can sample from _p_ ( **z** ( _t_ )) and evaluate its density by solving this combined ODE. 

**Using multiple hidden units with linear cost** While det is not a linear function, the trace function is, which implies tr([�] _n[J][n]_[) =][ �] _n_[tr][(] _[J][n]_[)][.][Thus if our dynamics is given by a sum of functions then] the differential equation for the log density is also a sum: 

**==> picture [311 x 30] intentionally omitted <==**

the number of hidden units _M_ . Evaluating such ‘wide’ flow layers using standard normalizing flows costs _O_ ( _M_[3] ), meaning that standard NF architectures use many layers of only a single hidden unit. 

**Time-dependent dynamics** We can specify the parameters of a flow as a function of _t_ , making the differential equation _f_ ( **z** ( _t_ ) _, t_ ) change with _t_ . This is parameterization is a kind of hypernetwork (Ha et al., 2016). We also introduce a gating mechanism for each hidden unit, _[d] dt_ **[z]**[=][�] _n[σ][n]_[(] _[t]_[)] _[f][n]_[(] **[z]**[)] where _σn_ ( _t_ ) _∈_ (0 _,_ 1) is a neural network that learns when the dynamic _fn_ ( **z** ) should be applied. We call these models continuous normalizing flows (CNF). 

## **4.1 Experiments with Continuous Normalizing Flows** 

We show that a planar CNF with _M_ hidden units can be at least as expressive as a planar NF with _K_ = _M_ layers, and sometimes much more expressive. 

**Density matching** We configure the CNF as described above, and train for 10,000 iterations using Adam (Kingma and Ba, 2014). In contrast, the NF is trained for 500,000 iterations using RMSprop (Hinton et al., 2012), as suggested by Rezende and Mohamed (2015). For this task, we minimize KL ( _q_ ( **x** ) _�p_ ( **x** )) as the loss function where _q_ is the flow model and the target density _p_ ( _·_ ) can be evaluated. Figure 4 shows that CNF generally achieves lower loss. 

**Maximum Likelihood Training** A useful property of continuous-time normalizing flows is that we can compute the reverse transformation for about the same cost as the forward pass, which cannot be said for normalizing flows. This lets us train the flow on a density estimation task by performing 

**==> picture [344 x 138] intentionally omitted <==**

**----- Start of picture text -----**<br>
K=2 K=8 K=32 M=2 M=8 M=32<br>���<br>��<br>1<br>�� �� ��<br>���<br>��<br>2<br>�� �� ��<br>���<br>��<br>3<br>�� �� ��<br>(a) Target (b) NF (c) CNF (d) Loss vs. K/M<br>**----- End of picture text -----**<br>


Figure 4: The model capacity of normalizing flows is determined by their depth (K), while continuous normalizing flows can also increase capacity by increasing width (M), making them easier to train. 

5 

**==> picture [396 x 105] intentionally omitted <==**

**----- Start of picture text -----**<br>
5% 20% 40% 60% 80% 100% 5% 20% 40% 60% 80% 100%<br>Target Target<br>(a) Two Circles (b) Two Moons<br>Density Density<br>Samples Samples<br>NF NF<br>**----- End of picture text -----**<br>


Figure 5: **Visualizing the transformation from noise to data.** Continuous-time normalizing flows are reversible, so we can train on a density estimation task and still be able to sample from the learned density efficiently. 

maximum likelihood estimation, which maximizes E _p_ ( **x** )[log _q_ ( **x** )] where _q_ ( _·_ ) is computed using the appropriate change of variables theorem, then afterwards reverse the CNF to generate random samples from _q_ ( **x** ). 

For this task, we use 64 hidden units for CNF, and 64 stacked one-hidden-unit layers for NF. Figure 5 shows the learned dynamics. Instead of showing the initial Gaussian distribution, we display the transformed distribution after a small amount of time which shows the locations of the initial planar flows. Interestingly, to fit the Two Circles distribution, the CNF rotates the planar flows so that the particles can be evenly spread into circles. While the CNF transformations are smooth and interpretable, we find that NF transformations are very unintuitive and this model has difficulty fitting the two moons dataset in Figure 5b. 

## **5 A generative latent function time-series model** 

neural spiking data is difficult. Typically, observations are put into bins of fixed duration, and the latent dynamics are discretized in the same way. This leads to difficulties with missing data and illdefined latent variables. Missing data can be addressed using generative time-series models (Álvarez and Lawrence, 2011; Futoma et al., 2017; Mei and Eisner, 2017; Soleimani et al., 2017a) or data imputation (Che et al., 2018). Another approach concatenates time-stamp information to the input of an RNN (Choi et al., 2016; Lipton et al., 2016; Du et al., 2016; Li, 2017). 

We present a continuous-time, generative approach to modeling time series. Our model represents each time series by a latent trajectory. Each trajectory is determined from a local initial state, **z** _t_ 0 , and a global set of latent dynamics shared across all time series. Given observation times _t_ 0 _, t_ 1 _, . . . , tN_ and an initial stateobservation.We define this generative model formally through a sampling procedure: **z** _t_ 0 , an ODE solver produces **z** _t_ 1 _, . . . ,_ **z** _tN_ , which describe the latent state at each 

**==> picture [305 x 39] intentionally omitted <==**

Function _f_ is a time-invariant function that takes the value **z** at the current time step and outputs the gradient: _[∂]_ **[z]**[(] _[t]_[)] _/∂t_ = _f_ ( **z** ( _t_ ) _, θf_ ). We parametrize this function using a neural net. Because _f_ is timeinvariant, given any latent state **z** ( _t_ ), the entire latent trajectory is uniquely defined. Extrapolating this latent trajectory lets us make predictions arbitrarily far forwards or backwards in time. 

**Training and Prediction** We can train this latent-variable model as a variational autoencoder (Kingma and Welling, 2014; Rezende et al., 2014), with sequence-valued observations. Our recognition net is an RNN, which consumes the data sequentially backwards in time, and outputs _qφ_ ( **z** 0 _|_ **x** 1 _,_ **x** 2 _, . . . ,_ **x** _N_ ). A detailed algorithm can be found in Appendix E. Using ODEs as a generative model allows us to make predictions for arbitrary time points _t_ 1... _tM_ on a continuous timeline. 

6 

**==> picture [396 x 125] intentionally omitted <==**

**----- Start of picture text -----**<br>
ODE Solve( zt 0 , f, θf , t 0 , ..., tM )<br>ht 0 ht 1����������� htN q ( zt 0 |xµt 0 ...xtNz ) t 0 zt 1 ztN ztN +1 ztM<br>�<br>� σ<br>������������<br>����������<br>ˆ<br>���� x ( t ) x ( t )<br>t 0 t 1 tN tN +1 tM t 0 t 1 tN tN +1 tM<br>�������� ���������� ���������� �������������<br>**----- End of picture text -----**<br>


Figure 6: Computation graph of the latent ODE model. 

**Poisson Process likelihoods** The fact that an observation occurred often tells us something about the latent state. For example, a patient may be more likely to take a medical test if they are sick. The rate of events can be parameterized by a function of the latent state: _p_ (event at time _t|_ **z** ( _t_ )) = _λ_ ( **z** ( _t_ )). Given this rate function, the likelihood of a set of independent observation times in the interval [ _t_ start _, t_ end] is given by an inhomogeneous Poisson process (Palm, 1943): 

_t_ 

**==> picture [399 x 59] intentionally omitted <==**

We can parameterize _λ_ ( _·_ ) using another neural network. Conveniently, we can evaluate both the latent trajectory and the Poisson process likelihood together in a single call to an ODE solver. Figure 7 shows the event rate learned by such a model on a toy dataset. 

A Poisson process likelihood on observation times can be combined with a data likelihood to jointly model all observations and the times at which they were made. 

## **5.1 Time-series Latent ODE Experiments** 

The recognition network is an RNN with 25 hidden units. We use a 4-dimensional latent space. We parameterize the dynamics function _f_ with a one-hidden-layer network with 20 hidden units. The decoder computing _p_ ( **x** _ti |_ **z** _ti_ ) is another neural network with one hidden layer with 20 hidden units. Our baseline was a recurrent neural net with 25 hidden units trained to minimize negative Gaussian log-likelihood. We trained a second version of this RNN whose inputs were concatenated with the time difference to the next observation to aid RNN with irregular observations. 

Table 2: Predictive RMSE on test set 

**Bi-directional spiral dataset** We generated a dataset of 1000 2-dimensional spirals, each starting at a different point, sampled at 100 equallyspaced timesteps. The dataset contains two RNN types of spirals: half are clockwise while the other half counter-clockwise. To make the task more realistic, we add gaussian noise to the observations. 

|# Observations|30/100|50/100|100/100|
|---|---|---|---|
|RNN|0.3937|0.3202|0.1813|
|Latent ODE|**0.1642**|**0.1502**|**0.1346**|



**Time series with irregular time points** To generate irregular timestamps, we randomly sample points from each trajectory without replacement ( _n_ = _{_ 30 _,_ 50 _,_ 100 _}_ ). We report predictive rootmean-squared error (RMSE) on 100 time points extending beyond those that were used for training. Table 2 shows that the latent ODE has substantially lower predictive RMSE. 

Figure 8 shows examples of spiral reconstructions with 30 sub-sampled points. Reconstructions from the latent ODE were obtained by sampling from the posterior over latent trajectories and decoding it 

7 

Figure 9: Data-space trajectories decoded from varying one dimension of **z** _t_ 0. Color indicates progression through time, starting at purple and ending at red. Note that the trajectories on the left are counter-clockwise, while the trajectories on the right are clockwise. 

to data-space. Examples with varying number of time points are shown in Appendix F. We observed that reconstructions and extrapolations are consistent with the ground truth regardless of number of observed points and despite the noise. 

**Latent space interpolation** Figure 8c shows latent trajectories projected onto the first two dimensions of the latent space. The trajectories form two separate clusters of trajectories, one decoding to clockwise spirals, the other to counter-clockwise. Figure 9 shows that the latent trajectories change smoothly as a function of the initial point **z** ( _t_ 0), switching from a clockwise to a counter-clockwise spiral. 

**==> picture [109 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Recurrent Neural Network<br>**----- End of picture text -----**<br>


## **6 Scope and Limitations** 

**Minibatching** The use of mini-batches is less straightforward than for standard neural networks. One can still batch together evaluations through the ODE solver by concatenating the states of each batch element together, creating a combined ODE with dimension _D ×K_ . In some cases, controlling error on all batch elements together might require evaluating the combined system _K_ times more often than if each system was solved individually. However, in practice the number of evaluations did not increase substantially when using minibatches. 

> **Uniqueness** When do continuous dynamics have a unique solution? Picard’s existence theorem (Coddington and Levinson, 1955) states that the solution to an initial value problem exists and is unique if the differential equation is uniformly Lipschitz continuous in **z** and continuous inthe neural network has finite weights and uses _t_ . This theorem holds for our model if Lipshitz nonlinearities, such as ���� or ���� . 

**==> picture [176 x 56] intentionally omitted <==**

**----- Start of picture text -----**<br>
(b) Latent Neural Ordinary Differential Equation<br>������������<br>�����������<br>����������<br>�������������<br>**----- End of picture text -----**<br>


(c) Latent Trajectories 

Figure 8: (a): Reconstruction and extrapolation of spirals with irregular time points by a recurrent neural network. (b): Reconstructions and extrapolations by a latent neural ODE. Blue curve shows model prediction. Red shows extrapolation. (c) A projection of inferred 4-dimensional latent ODE trajectories onto their first two dimensions. Color indicates the direction of the corresponding trajectory. The model has learned latent dynamics which distinguishes the two directions. 

**Setting tolerances** Our framework allows the user to trade off speed for precision, but requires the user to choose an error tolerance on both the forward and reverse passes during training. For sequence modeling, the default value of ������ was used. In the classification and density estimation experiments, we were able to reduce the tolerance to ���� and ���� , respectively, without degrading performance. 

**Reconstructing forward trajectories** Reconstructing the state trajectory by running the dynamics backwards can introduce extra numerical error if the reconstructed trajectory diverges from the original. This problem can be addressed by checkpointing: storing intermediate values of **z** on the 

8 

forward pass, and reconstructing the exact forward trajectory by re-integrating from those points. We did not find this to be a practical problem, and we informally checked that reversing many layers of continuous normalizing flows with default tolerances recovered the initial states. 

## **7 Related Work** 

The use of the adjoint method for training continuous-time neural networks was previously proposed (LeCun et al., 1988; Pearlmutter, 1995), though was not demonstrated practically. The interpretation of residual networks He et al. (2016a) as approximate ODE solvers spurred research into exploiting reversibility and approximate computation in ResNets (Chang et al., 2017; Lu et al., 2017). We demonstrate these same properties in more generality by directly using an ODE solver. 

**Adaptive computation** One can adapt computation time by training secondary neural networks to choose the number of evaluations of recurrent or residual networks (Graves, 2016; Jernite et al., 2016; Figurnov et al., 2017; Chang et al., 2018). However, this introduces overhead both at training and test time, and extra parameters that need to be fit. In contrast, ODE solvers offer well-studied, computationally cheap, and generalizable rules for adapting the amount of computation. 

**Constant memory backprop through reversibility** Recent work developed reversible versions of residual networks (Gomez et al., 2017; Haber and Ruthotto, 2017; Chang et al., 2017), which gives the same constant memory advantage as our approach. However, these methods require restricted architectures, which partition the hidden units. Our approach does not have these restrictions. 

**Learning differential equations** Much recent work has proposed learning differential equations from data. One can train feed-forward or recurrent neural networks to approximate a differential equation (Raissi and Karniadakis, 2018; Raissi et al., 2018a; Long et al., 2017), with applications such as fluid simulation (Wiewel et al., 2018). There is also significant work on connecting Gaussian Processes (GPs) and ODE solvers (Schober et al., 2014). GPs have been adapted to fit differential equations (Raissi et al., 2018b) and can naturally model continuous-time effects and interventions (Soleimani et al., 2017b; Schulam and Saria, 2017). Ryder et al. (2018) use stochastic variational inference to recover the solution of a given stochastic differential equation. 

**Differentiating through ODE solvers** The ������ library (Farrell et al., 2013) implements adjoint computation for general ODE and PDE solutions, but only by backpropagating through the individual operations of the forward solver. The Stan library (Carpenter et al., 2015) implements gradient estimation through ODE solutions using forward sensitivity analysis. However, forward sensitivity analysis is quadratic-time in the number of variables, whereas the adjoint sensitivity analysis is linear (Carpenter et al., 2015; Zhang and Sandu, 2014). Melicher et al. (2017) used the adjoint method to train bespoke latent dynamic models. 

In contrast, by providing a generic vector-Jacobian product, we allow an ODE solver to be trained end-to-end with any other differentiable model components. While use of vector-Jacobian products for solving the adjoint method has been explored in optimal control (Andersson, 2013; Andersson et al., In Press, 2018), we highlight the potential of a general integration of black-box ODE solvers into automatic differentiation (Baydin et al., 2018) for deep learning and generative modeling. 

## **8 Conclusion** 

We investigated the use of black-box ODE solvers as a model component, developing new models for time-series modeling, supervised learning, and density estimation. These models are evaluated adaptively, and allow explicit control of the tradeoff between computation speed and accuracy. Finally, we derived an instantaneous version of the change of variables formula, and developed continuous-time normalizing flows, which can scale to large layer sizes. 

9 

## **9 Acknowledgements** 

We thank Wenyi Wang and Geoff Roeder for help with proofs, and Daniel Duckworth, Ethan Fetaya, Hossein Soleimani, Eldad Haber, Ken Caluwaerts, and Daniel Flam-Shepherd for feedback. We thank Chris Rackauckas, Dougal Maclaurin, and Matthew James Johnson for helpful discussions. 

## **References** 

Mauricio A Álvarez and Neil D Lawrence. Computationally efficient convolved multiple output Gaussian processes. _Journal of Machine Learning Research_ , 12(May):1459–1500, 2011. 

Brandon Amos and J Zico Kolter. OptNet: Differentiable optimization as a layer in neural networks. In _International Conference on Machine Learning_ , pages 136–145, 2017. 

Joel Andersson. _A general-purpose software framework for dynamic optimization_ . PhD thesis, 2013. 

- Joel A E Andersson, Joris Gillis, Greg Horn, James B Rawlings, and Moritz Diehl. CasADi – A software framework for nonlinear optimization and optimal control. _Mathematical Programming Computation_ , In Press, 2018. 

- Atilim Gunes Baydin, Barak A Pearlmutter, Alexey Andreyevich Radul, and Jeffrey Mark Siskind. Automatic differentiation in machine learning: a survey. _Journal of machine learning research_ , 18 (153):1–153, 2018. 

- Rianne van den Berg, Leonard Hasenclever, Jakub M Tomczak, and Max Welling. Sylvester normalizing flows for variational inference. _arXiv preprint arXiv:1803.05649_ , 2018. 

- Bob Carpenter, Matthew D Hoffman, Marcus Brubaker, Daniel Lee, Peter Li, and Michael Betancourt. The Stan math library: Reverse-mode automatic differentiation in c++. _arXiv preprint arXiv:1509.07164_ , 2015. 

- Bo Chang, Lili Meng, Eldad Haber, Lars Ruthotto, David Begert, and Elliot Holtham. Reversible architectures for arbitrarily deep residual neural networks. _arXiv preprint arXiv:1709.03698_ , 2017. 

- Bo Chang, Lili Meng, Eldad Haber, Frederick Tung, and David Begert. Multi-level residual networks from dynamical systems view. In _International Conference on Learning Representations_ , 2018. URL ����������������������������������������� . 

- Zhengping Che, Sanjay Purushotham, Kyunghyun Cho, David Sontag, and Yan Liu. Recurrent neural networks for multivariate time series with missing values. _Scientific Reports_ , 8(1):6085, 2018. URL ������������������������������������������ . 

- Edward Choi, Mohammad Taha Bahadori, Andy Schuetz, Walter F. Stewart, and Jimeng Sun. Doctor AI: Predicting clinical events via recurrent neural networks. In _Proceedings of the 1st Machine Learning for Healthcare Conference_ , volume 56 of _Proceedings of Machine Learning Research_ , pages 301–318. PMLR, 18–19 Aug 2016. URL ����������������������������� ��������������� . 

- Earl A Coddington and Norman Levinson. _Theory of ordinary differential equations_ . Tata McGrawHill Education, 1955. 

- Laurent Dinh, David Krueger, and Yoshua Bengio. NICE: Non-linear independent components estimation. _arXiv preprint arXiv:1410.8516_ , 2014. 

- Nan Du, Hanjun Dai, Rakshit Trivedi, Utkarsh Upadhyay, Manuel Gomez-Rodriguez, and Le Song. Recurrent marked temporal point processes: Embedding event history to vector. In _International Conference on Knowledge Discovery and Data Mining_ , pages 1555–1564. ACM, 2016. 

- Patrick Farrell, David Ham, Simon Funke, and Marie Rognes. Automated derivation of the adjoint of high-level transient finite element programs. _SIAM Journal on Scientific Computing_ , 2013. 

- Michael Figurnov, Maxwell D Collins, Yukun Zhu, Li Zhang, Jonathan Huang, Dmitry Vetrov, and Ruslan Salakhutdinov. Spatially adaptive computation time for residual networks. _arXiv preprint_ , 2017. 

10 

- J. Futoma, S. Hariharan, and K. Heller. Learning to Detect Sepsis with a Multitask Gaussian Process RNN Classifier. _ArXiv e-prints_ , 2017. 

- Aidan N Gomez, Mengye Ren, Raquel Urtasun, and Roger B Grosse. The reversible residual network: Backpropagation without storing activations. In _Advances in Neural Information Processing Systems_ , pages 2211–2221, 2017. 

Alex Graves. Adaptive computation time for recurrent neural networks. _arXiv preprint arXiv:1603.08983_ , 2016. 

David Ha, Andrew Dai, and Quoc V Le. Hypernetworks. _arXiv preprint arXiv:1609.09106_ , 2016. 

- Eldad Haber and Lars Ruthotto. Stable architectures for deep neural networks. _Inverse Problems_ , 34 (1):014004, 2017. 

- E. Hairer, S.P. Nørsett, and G. Wanner. _Solving Ordinary Differential Equations I – Nonstiff Problems_ . Springer, 1987. 

- Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Deep residual learning for image recognition. In _Proceedings of the IEEE conference on computer vision and pattern recognition_ , pages 770–778, 2016a. 

- Kaiming He, Xiangyu Zhang, Shaoqing Ren, and Jian Sun. Identity mappings in deep residual networks. In _European conference on computer vision_ , pages 630–645. Springer, 2016b. 

- Geoffrey Hinton, Nitish Srivastava, and Kevin Swersky. Neural networks for machine learning lecture 6a overview of mini-batch gradient descent, 2012. 

- Yacine Jernite, Edouard Grave, Armand Joulin, and Tomas Mikolov. Variable computation in recurrent neural networks. _arXiv preprint arXiv:1611.06188_ , 2016. 

- Diederik P Kingma and Jimmy Ba. Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ , 2014. 

- Diederik P. Kingma and Max Welling. Auto-encoding variational Bayes. _International Conference on Learning Representations_ , 2014. 

- Diederik P Kingma, Tim Salimans, Rafal Jozefowicz, Xi Chen, Ilya Sutskever, and Max Welling. Improved variational inference with inverse autoregressive flow. In _Advances in Neural Information Processing Systems_ , pages 4743–4751, 2016. 

- W. Kutta. Beitrag zur näherungsweisen Integration totaler Differentialgleichungen. _Zeitschrift für Mathematik und Physik_ , 46:435–453, 1901. 

- Yann LeCun, D Touresky, G Hinton, and T Sejnowski. A theoretical framework for back-propagation. In _Proceedings of the 1988 connectionist models summer school_ , volume 1, pages 21–28. CMU, Pittsburgh, Pa: Morgan Kaufmann, 1988. 

Yann LeCun, Léon Bottou, Yoshua Bengio, and Patrick Haffner. Gradient-based learning applied to document recognition. _Proceedings of the IEEE_ , 86(11):2278–2324, 1998. 

Yang Li. Time-dependent representation for neural event sequence prediction. _arXiv preprint arXiv:1708.00065_ , 2017. 

- Zachary C Lipton, David Kale, and Randall Wetzel. Directly modeling missing data in sequences with RNNs: Improved classification of clinical time series. In _Proceedings of the 1st Machine Learning for Healthcare Conference_ , volume 56 of _Proceedings of Machine Learning Research_ , pages 253– 270. PMLR, 18–19 Aug 2016. URL ���������������������������������������������� . 

- Z. Long, Y. Lu, X. Ma, and B. Dong. PDE-Net: Learning PDEs from Data. _ArXiv e-prints_ , 2017. 

- Yiping Lu, Aoxiao Zhong, Quanzheng Li, and Bin Dong. Beyond layer neural networks: Bridging deep architectures and numerical differential equations. _arXiv preprint arXiv:1710.10121_ , 2017. 

11 

- Dougal Maclaurin, David Duvenaud, and Ryan P Adams. Autograd: Reverse-mode differentiation of native Python. In _ICML workshop on Automatic Machine Learning_ , 2015. 

- Hongyuan Mei and Jason M Eisner. The neural Hawkes process: A neurally self-modulating multivariate point process. In _Advances in Neural Information Processing Systems_ , pages 6757– 6767, 2017. 

- Valdemar Melicher, Tom Haber, and Wim Vanroose. Fast derivatives of likelihood functionals for ODE based models using adjoint-state method. _Computational Statistics_ , 32(4):1621–1643, 2017. 

- Conny Palm. Intensitätsschwankungen im fernsprechverker. _Ericsson Technics_ , 1943. 

- Adam Paszke, Sam Gross, Soumith Chintala, Gregory Chanan, Edward Yang, Zachary DeVito, Zeming Lin, Alban Desmaison, Luca Antiga, and Adam Lerer. Automatic differentiation in pytorch. 2017. 

- Barak A Pearlmutter. Gradient calculations for dynamic recurrent neural networks: A survey. _IEEE Transactions on Neural networks_ , 6(5):1212–1228, 1995. 

- Lev Semenovich Pontryagin, EF Mishchenko, VG Boltyanskii, and RV Gamkrelidze. The mathematical theory of optimal processes. 1962. 

- M. Raissi and G. E. Karniadakis. Hidden physics models: Machine learning of nonlinear partial differential equations. _Journal of Computational Physics_ , pages 125–141, 2018. 

- Maziar Raissi, Paris Perdikaris, and George Em Karniadakis. Multistep neural networks for datadriven discovery of nonlinear dynamical systems. _arXiv preprint arXiv:1801.01236_ , 2018a. 

- Maziar Raissi, Paris Perdikaris, and George Em Karniadakis. Numerical Gaussian processes for time-dependent and nonlinear partial differential equations. _SIAM Journal on Scientific Computing_ , 40(1):A172–A198, 2018b. 

- Danilo J Rezende, Shakir Mohamed, and Daan Wierstra. Stochastic backpropagation and approximate inference in deep generative models. In _Proceedings of the 31st International Conference on Machine Learning_ , pages 1278–1286, 2014. 

- Danilo Jimenez Rezende and Shakir Mohamed. _arXiv preprint arXiv:1505.05770_ , 2015. 

- C. Runge. Über die numerische Auflösung von Differentialgleichungen. _Mathematische Annalen_ , 46: 167–178, 1895. 

- Lars Ruthotto and Eldad Haber. Deep neural networks motivated by partial differential equations. _arXiv preprint arXiv:1804.04272_ , 2018. 

- T. Ryder, A. Golightly, A. S. McGough, and D. Prangle. Black-box Variational Inference for Stochastic Differential Equations. _ArXiv e-prints_ , 2018. 

- Michael Schober, David Duvenaud, and Philipp Hennig. Probabilistic ODE solvers with Runge-Kutta means. In _Advances in Neural Information Processing Systems 25_ , 2014. 

- Peter Schulam and Suchi Saria. What-if reasoning with counterfactual Gaussian processes. _arXiv preprint arXiv:1703.10651_ , 2017. 

- Hossein Soleimani, James Hensman, and Suchi Saria. Scalable joint models for reliable uncertaintyaware event prediction. _IEEE transactions on pattern analysis and machine intelligence_ , 2017a. 

- Hossein Soleimani, Adarsh Subbaswamy, and Suchi Saria. Treatment-response models for counterfactual reasoning with continuous-time, continuous-valued interventions. _arXiv preprint arXiv:1704.02038_ , 2017b. 

- Jos Stam. Stable fluids. In _Proceedings of the 26th annual conference on Computer graphics and interactive techniques_ , pages 121–128. ACM Press/Addison-Wesley Publishing Co., 1999. 

12 

Paul Stapor, Fabian Froehlich, and Jan Hasenauer. Optimization and uncertainty analysis of ODE models using second order adjoint sensitivity analysis. _bioRxiv_ , page 272005, 2018. 

Jakub M Tomczak and Max Welling. Improving variational auto-encoders using Householder flow. _arXiv preprint arXiv:1611.09630_ , 2016. 

Steffen Wiewel, Moritz Becher, and Nils Thuerey. Latent-space physics: Towards learning the temporal evolution of fluid flow. _arXiv preprint arXiv:1802.10123_ , 2018. 

Hong Zhang and Adrian Sandu. Fatode: a library for forward, adjoint, and tangent linear integration of ODEs. _SIAM Journal on Scientific Computing_ , 36(5):C504–C523, 2014. 

13 

