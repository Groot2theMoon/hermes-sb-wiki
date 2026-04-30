---
title: "Lipschitz-Based Robustness Certification for Recurrent Neural Networks via Convex Relaxation"
arxiv: "2509.17898"
authors: ["Paul Hamelbeck", "Johannes Schiffer"]
year: 2025
source: paper
ingested: 2026-05-01
sha256: f07c015cf91805349360ec64bb3055e9d272b689d9a846d09e921c5c8d6534be
conversion: pymupdf4llm
---

1 

## Lipschitz-Based Robustness Certification for Recurrent Neural Networks via Convex Relaxation 

Paul Hamelbeck and Johannes Schiffer 

_**Abstract**_ **—Robustness certification against bounded input noise or adversarial perturbations is increasingly important for deployment recurrent neural networks (RNNs) in safety-critical control applications. To address this challenge, we present RNN-SDP, a relaxation based method that models the RNN’s layer interactions as a convex problem and computes a certified upper bound on the Lipschitz constant via semidefinite programming (SDP). We also explore an extension that incorporates known input constraints to further tighten the resulting Lipschitz bounds. RNNSDP is evaluated on a synthetic multi-tank system, with upper bounds compared to empirical estimates. While incorporating input constraints yields only modest improvements, the general method produces reasonably tight and certifiable bounds, even as sequence length increases. The results also underscore the often underestimated impact of initialization errors—an important consideration for applications where models are frequently reinitialized, such as model predictive control (MPC).** 

_**Index Terms**_ **—Robustness Certification, Recurrent Neural Networks, Lipschitz Constant, Semidefinite Programming.** 

## I. INTRODUCTION 

EURAL networks (NNs) have demonstrated remarkable **N** success across a wide range of applications, including computer vision [1], natural language processing [2], and control systems [3], making them indispensable tools in modern machine learning and artificial intelligence. However, their highly non-linear and high-dimensional structure often renders them opaque, leading to their characterization as blackbox models: capable of impressive performance, but offering limited interpretability or formal guarantees regarding their behavior [4]. This opacity becomes particularly problematic in safety-critical domains, such as autonomous driving, medical diagnostics, or large-scale control systems, where even small input perturbations can result in unpredictable or unsafe outcomes [5]. In such settings, formal verification and robustness analysis are essential to ensure reliability, stability, and trust in NN-based decision systems [4]. 

In response to these challenges, substantial efforts have been made to reduce noise sensitivity, while maintaining the predictive capabilities NNs as well as to develop tools for rigorously assessing their robustness. Techniques such as adversarial training [6] and regularization [7] aim to reduce a network’s sensitivity to input perturbations and thereby increas robustness against noise and adversarial attacks. While these robustness-enhancing techniques play a critical role during training, they must be complemented by verification tools that can formally assess the model’s behavior across a range of inputs. Such verification techniques typically fall into one of three categories: _a) reachability-based_ , _b) optimization-based_ , or _c) relaxation-based_ verification methods, each offering a different balance of precision, scalability, and generality. 

_a) Reachability-based:_ Reachability-based verification methods aim to compute the full set of possible outputs _Y_ that a NN can produce for all inputs _X_ within a given region. This is typically achieved through layer-by-layer propagation of the input set, which can be computationally expensive due to the exponential growth in the number of activation regions as the network depth increases. Methods that do not introduce simplifications yield exact reachable sets without over-approximation, but their scalability is limited to small networks [8]. To address this, many approaches incorporate set-based relaxations or over-approximations, which significantly reduce computational complexity and make the analysis tractable for larger models [9]. Additionally, reachability-based methods as a whole are generally limited to networks with ReLU or other piecewise-linear activation functions, as these preserve the geometric structure necessary for sound and efficient set propagation [4]. 

_b) Optimization-based:_ Optimization-based verification methods attempt to either find a counterexample, that is within the set _U_ that produces an output outside the safe region _Y_ [10] or identify the worst-case input that causes the most undesirable behavior, as defined by a given cost function [11]. These approaches commonly encode NNs as a set of mixedinteger linear constraints, enabling formal optimization. While such formulations can be solved using complete solvers like branch-and-bound, which can either find a violation or prove that none exists, they are typically limited to networks with piecewise-linear activation functions, such as ReLU or maxpooling [11]. Another commonly used solver, the satisfiability modulo theories (SMT) solver, can, in principle, also handle arbitrary non-linear activation functions (e.g., sigmoid or tanh). However in practice applications to networks with such activation functions remain limited as computational costs drastically increase and the completness of the approach is lost [12]. 

_c) Relaxation-based:_ Relaxation-based verification methods approximate the constraints imposed by the NN with looser, more tractable formulations, typically to enable scalable analysis [4]. Instead of precisely encoding every activation or network branch, these methods relax non-linear or combinatorial behaviors into convex or piecewise-linear forms. The result is typically a bound on the network’s output or sensitivity, rather than a definitive yes/no certificate. The central trade-off is between tightness of the bound and computational efficiency: coarser relaxations scale well but offer weaker guarantees, while tighter relaxations are more informative but expensive to compute. Prominent examples include: CROWN [13], which propagates linear bounds layer-by-layer; ConvDual [14], which uses dual feasible 

2 

solutions to certify output ranges; and LipSDP [15], which leverages a convex optimization framework, that yields certified upper bounds on the global Lipschitz constant on a feed-forwards neural network (FFNN) by approximating non-linear activation functions with quadratic constraints. 

The LipSDP approach is particularly appealing from a control-theoretic perspective, as the Lipschitz constant, which bounds the worst-case change in output relative to input variation, is a widely used robustness metric in many control frameworks, such as observer design [16], and model predictive control (MPC) [17]. However, recent advances in system identification and control have seen a shift from FFNNs to recurrent neural networks (RNNs), due to their superior capacity for modeling temporal dynamics [18]–[20]. RNNs achieve this by incorporating an internal feedback loop, which enables the retention of historical information and facilitates sequential prediction. In contrast, FFNNs generate outputs based solely on the current input. While this internal recurrence enhances the representational capacity of RNNs for dynamic systems, it also introduces structural complexity that renders many existing verification techniques inapplicable. Bonassi et al. [18] specifically highlight the absence of a method akin to LipSDP, in the context of RNNs, noting its importance for control applications that demand certified robustness. 

_Our Contributions:_ We propose the RNN-SDP framework for tightly bounding the Lipschitz constant of RNNs, enabling robustness and stability analysis. Inspired by LipSDP [15], we propose an SDP-based certifiaction techique tailored to RNNs, producing finite-horizon input–output Lipschitz bounds that account for initialization errors The latter is particularly critical in applications with frequent reinitialization, which prevents the system from reaching a steady state, making initialization effects persistently relevant. Additionally, we present a framework to utilize known input constraints, which are commonly present in practical NN applications [21], to further tighten the estimated bound of the Lipschitz constant. 

_Our Approach:_ By restricting the sequence length for predictions to an arbitrary finite length of _N_ , we can transform the RNN into an equivalent FFNN via unrolling [22]. For this unrolled structure, we exploit the slope-restricted nature of non-linear activation functions to derive an upper bound on the Lipschitz constant through semidefinite programming (SDP). To incorporate input constraints, we refine global slope bounds into local slope restrictions for each neuron, informed by the constrained input domain and the inter-layer interactions. 

_Our Results:_ We evaluate our method on RNNs trained to predict tank levels in a multi-tank system. We compare our Lipschitz bound against estimates obtained via random sampling and active exploration. Our results highlight the potential risks of relying solely on statistical estimation and demonstrate the tightness of our approach across different sequence lengths. For short sequences, where the combined impact of input and initialization disturbances is most pronounced, our method provides bounds roughly 1% above the empirical lower bound estimates, offering strong worst-case guarantees. For longer sequences, the bound loosens to about 30%, reflecting the 

inherent challenge of tight bounding over extended horizons while still maintaining provable robustness. 

_Related Work:_ Lipschitz constant estimation for RNNs is less mature than for feed-forward architectures, but several approaches have emerged. Revay et al. [23] introduced a convex parameterization framework for RNNs that provides robustness and stability guarantees during training. This was later extended into the recurrent equilibrium network (REN) architecture [24], which models RNNs as feedback interconnections of linear systems and monotonic non-linearities. Their method uses incremental quadratic constraints to certify global exponential stability and bounded incremental _L_ 2-gain—effectively a Lipschitz bound on the sequence-tosequence mapping. However, their framework does not account for the impact of initialization. While effective for general system identification, this method tends to be less suitable frequently re-initialized models, where accurate treatment of initialization errors is critical. A similar limitation can be seen in the method of Guo et al. [25]. They provide tight and validated Lipschitz bounds by leveraging interval arithmetic and Clarke-gradient enclosures. This leads to rigorous certification, especially valuable in low-dimensional short sequence data. Their approach assumes a fixed initial-state and therefore does also not account, for initialization impacts. Our proposed approach (RNN-SDP) accounts for these effects and therefore provides a valuable addition to the currently available toolset for robustness certification, especially for frequently reinitialized applications, such as MPC [26]. 

## II. PRELIMINARIES 

In this section, we introduce the notation and provide the definitions and properties of RNNs relevant to this work: RNN layer formulation, stability considerations, and the unrolled representation. 

## _A. Notation_ 

Vectors are denoted by lowercase bold letters (e.g., **x** ), and matrices by uppercase bold letters (e.g., **W** ). Stacked vectors—i.e., vectors formed by vertically concatenating multiple time- or layer-indexed vectors—are denoted by a tilde (e.g., **x** ˜). The _n_ -dimensional identity matrix is denoted by **I** _n_ , while the zero matrix, i.e., a matrix of appropriate dimension with all entries equal to zero, is denoted by **0** . The notation diag( _a_ 1 _, . . . , an_ ) refers to a diagonal matrix with diagonal entries _a_ 1 through _an_ , starting from the upper-left corner. The _p_ -norm of a vector, for _p ≥_ 1, is denoted by _||·||p_ : R _[n] →_ R[+] 0[.] The notation [ _a, b_ ] denotes a closed interval for scalar values or component wise bounds when used with vectors. 

## _B. RNN Layer Definition_ 

We briefly recall the structure of a standard RNN in order to establish our employed notation based on [27]. An RNN maintains an internal _hidden state_ **h** _t ∈_ R _[n]_ that serves as a memory of past inputs and influences future predictions. At each discrete time step _t ∈_ Z _≥_ 0, the hidden state is updated according to 

**h** _t_ = _ϕ_ ( **W** _h_ **h** _t−_ 1 + **W** _x_ **x** _t_ + **b** ) _,_ (1) 

3 

**==> picture [376 x 129] intentionally omitted <==**

**----- Start of picture text -----**<br>
RNN-layer Output-layer<br>x t h t y t<br>ϕ ( W x x t  +  W h h t− 1 +  b ) W out ht  +  b out<br>h t− 1<br>**----- End of picture text -----**<br>


Fig. 1: Structure of a recurrent neural network (RNN). At each time step, the input **x** _t_ and the previous hidden state **h** _t−_ 1 are combined and transformed by a non-linear activation function _ϕ_ ( _·_ ) to produce the next hidden state **h** _t_ . The updated state is then mapped to the output **y** _t_ via a linear output layer. 

where **W** _h ∈_ R _[n][×][n]_ applies a linear transformation to the previous hidden state, **W** _x ∈_ R _[n][×][m]_ transforms the input **x** _t ∈_ R _[m]_ , **b** _∈_ R _[n]_ is a bias vector, and _ϕ_ ( _·_ ) denotes a element wise non-linear activation function, such as the hyperbolic tangent tanh( _·_ ) used in classical RNNs. 

Following the hidden-state update (1), an _output layer_ (typically a linear mapping) produces the network output **y** _t ∈_ R _[p]_ ; i.e., 

**==> picture [172 x 10] intentionally omitted <==**

where **W** out _∈_ R _[p][×][n]_ and **b** out _∈_ R _[p]_ are the output weight matrix and bias, respectively. The overall structure of a single RNN layer paired with a linear output layer is shown in Fig. 1. 

Depending on the task, the output layer can be interpreted in two ways: (i) _sequence-to-sequence_ , where outputs are produced at every time step and stacked into a trajectory, or (ii) _sequence-to-point_ , where only a single output (often the final one) is taken as the prediction. Both variants share the same underlying structure, differing only in how the outputs are collected. 

_existence_ of a finite Lipschitz constant for a given network and therefore must be used in combination with the proposed method to ensure its applicability. In Section III-C we discuss the training of the RNN and show how stability is ensured. 

## _D. Unrolling of RNNs_ 

RNNs can be equivalently represented as feed-forward architectures by _unrolling_ the recurrence over a finite time horizon [22]. In this representation, each time step corresponds to a distinct layer that shares parameters with all others, this structure is shown in Fig. 2. For a sequence of length _N_ , the hidden-state update (1) is applied sequentially from the initial state **h** 0, generating the state sequence **h** _t_ and the output sequence **y** _t_ for all _t_ = [1 _, . . . , N_ ]. Unrolling a RNN removes its explicit recurrence, thereby allowing for easier analysis. The technique is therefore commonly used during the back-propagation step of the training [22]. In this paper, we use unrolling to track the finite-horizon propagation of perturbations by representing the RNN by a FFNN. 

## _C. Stability in RNNs_ 

The recurrent connections (1) that enable RNNs to retain information over long time horizons also pose challenges for training [28] and stability [22]. As information is fed back through the network repeatedly, small perturbations can be progressively amplified across time, which results in exploding gradients during training [28]. In such a case, the impact of noise or input perturbations on the model output does not fade or even grow with time. This leads to degraded model performance and no horizon-independent Lipschitz bound to exist, since _L_ ( _T_ ) _→∞_ as _T →∞_ . 

Several methods have been proposed to enforce stability in RNNs, typically by constraining network parameters or imposing specific structural properties. Early work by Jin et al. [29] introduced conditions for absolute stability for the fundamental RNN, while more recent approaches focus on ensuring input-to-state stability (ISS) or incremental inputto-state stability ( _δ_ ISS) for various architectures, including NARX networks [30], Echo State Networks (ESNs) [31], Gated Recurrent Units (GRUs) [32], and Long Short-Term Memory (LSTM) networks [33]. Such methods guarantee the 

## III. METHODOLOGY 

In this section is organized into four subsections. We begin in Subsection III-A by presenting RNN-SDP an SDP-based method for estimating RNN Lipschitz constants, inspired by the LipSDP framework for FFNNs [15]. Building on this, in Subsection III-B we present an approach to further tighten the bounds by incorporating known input bounds into the methodology. We then outline the data generation and stability-constrained training procedure used for evaluation in Subsection III-C. Finally, in Subsection III-D, we present the design of the empirical baseline methods used for comparison. 

## _A. RNN-SDP_ 

To begin, we briefly recall the definition of the Lipschitz constant, as it forms the basis of the subsequent analysis. A constant _L_ is a Lipschitz constant of a function _f_ : R _[m] →_ R _[p]_ if it satisfies the following condition [34]: 

**==> picture [238 x 11] intentionally omitted <==**

Since the inequality (3) holds for all **v** 1 _,_ **v** 2 _∈_ R _[m]_ , we can guarantee that the function _f_ ( _·_ ) does not amplify input 

4 

**==> picture [470 x 157] intentionally omitted <==**

**----- Start of picture text -----**<br>
y t +1 y 1 y N − 1 y N<br>Output-layer Output-layer · · · Output-layer Output-layer<br>h t +1 Unrolling h 1 h N − 1 h N<br>h t h 0 h 1 h N − 1 h N − 1<br>RNN-layer RNN-layer · · · RNN-layer RNN-layer<br>x t +1 x 1 x N − 1 x N<br>**----- End of picture text -----**<br>


Fig. 2: Unfolding of a recurrent neural network (RNN) over a finite time horizon of length _N_ . Starting from the initial hidden state **h** 0, the RNN layer and output layer are applied sequentially at each time step. At each step, the past hidden state **h** _t_ and the current input **x** _t_ +1 are combined to produce the updated hidden state **h** _t_ +1 and the output **y** _t_ +1. The updated state is then passed to the next step and combined with the next input. This process is repeated until the final step _N_ is reached. In the unrolled representation, each time step corresponds to a distinct layer that shares parameters with all others. 

differences by more than a factor of _L_ . In the context of NNs, accurate knowledge of _L_ enables us to estimate the system’s sensitivity to input noise and other perturbations. This is particularly valuable, as neural networks are often highly non-linear, making it difficult to reason about their behavior without such bounds [4]. 

Inspired by [15], we interpret the function _f_ ( _·_ ) as a neural network, transforming a given input **v** _i_ into the network-output _f_ ( **v** _i_ ). For an RNN with the update and output equations (1),(2), the input can be defined as: 

**==> picture [155 x 26] intentionally omitted <==**

with **h** 0 _∈_ R _[n]_ being the initialization of the hidden state and **x** ˜ = [ **x** _[T]_ 1 _[,]_ **[ x]** _[T]_ 2 _[, . . . ,]_ **[ x]** _[T] N_[]] _[T][∈]_[R] _[mN]_[as a stack of all input vectors] **x** _t_ at all _N_ discrete time steps of the sequence. Depending on if the RNN makes point-wise or sequential predictions (see Section II-B) the network output is either the output at the ˜ last time step **y** _N ∈_ R _[p]_ or the full sequence of outputs **y** = [ **y** 1 _[T][,]_ **[ y]** 2 _[T][, . . . ,]_ **[ y]** _N[T]_[]] _[T][∈]_[R] _[pN]_[.][For][this][application][we][choose][a] network with a point-wise output at the last time step, the reasoning for this choice is discussed in Appendix A. Using (4) We can therefore write (3) for (1), (2) as: 

**==> picture [225 x 26] intentionally omitted <==**

For any two input vectors _v_ 1 = [˜ **x** _[T] ,_ **h** _[T]_ 0[]] 1 _[T]_[and] _[ v]_[2][= [˜] **[x]** _[T][ ,]_ **[ h]** _[T]_ 0[]] _[T]_ 2 and their corresponding output vectors **y** _N,_ 2 and **y** _N,_ 1, we can be related to the internal states of the RNN. As such we define a joined state vector: 

**==> picture [226 x 15] intentionally omitted <==**

with **h**[˜] = [ **h** _[T]_ 0 _[,]_ **[ h]** _[T]_ 1 _[, . . . ,]_ **[ h]** _[T] N_[]] _[T][∈]_[R] _[n]_[(] _[N]_[+1)][being][the][stacked] vector of all internal states of the unrolled RNN. The definition 

of **z** ˜ allows us to write the input, internal states and output for (1), (2) as: 

**==> picture [174 x 39] intentionally omitted <==**

with 

**==> picture [210 x 52] intentionally omitted <==**

By squaring (5) and inserting (7), we get: 

**==> picture [221 x 12] intentionally omitted <==**

Rewriting the squared _l_ 2-norms as inner products and introducing _ρ_ = _L_[2] yields: 

**==> picture [214 x 28] intentionally omitted <==**

Since both inner products in (10) are of the same dimension, the matrices can be joint into a singular matrix **M** _∈_ R _[d][z][×][d][z]_ : 

**==> picture [185 x 12] intentionally omitted <==**

with: 

**==> picture [218 x 65] intentionally omitted <==**

The inequality (11) would hold for all **z** ˜1 _,_ ˜ **z** 2 _∈_ R _[d][z]_ if and only if **M** _⪯_ 0. However, this condition is only satisfied in the trivial case, where **W** out = **0** , implying that the neural network outputs zero regardless of the input. In this scenario, any _ρ >_ 0 trivially satisfies the Lipschitz condition. For any non-zero output weights, the Gram matrix **W** out _T_ **W** out is 

5 

positive definite. Consequently, since the upper-left block of **M** is negative definite and the lower-right block is positive definite, the matrix **M** is indefinite, see also [15]. 

**==> picture [186 x 12] intentionally omitted <==**

with: 

It is important to note, however, that the the internal states **z** ˜1 _,_ ˜ **z** 2, while of dimension _dz_ , are not arbitrary vectors in R _[d][z]_ . Due to the dependencies induced by the layer-wise interactions within the network, these individual vectors making up **z** ˜ cannot be freely chosen, restricting the valid-values of **z** ˜1 _,_ ˜ **z** 2 to a subset _Z ⊆_ R _[d][z]_ . In the following, we introduce supplementary equations that reflect the interactions and constraints defining _Z_ , in order to derive an expression guaranteeing the satisfaction of the inequality in (11). 

**==> picture [281 x 601] intentionally omitted <==**

We begin by examining the non-linear activation functions within NNs. For all commonly used NN activation functions, the non-linearity _φ_ ( _·_ ) is _slope-restricted_ [35]. This includes the tanh( _·_ ) non-linearity used in the RNN update step (1). We denote a generic slope-restricted function as _φ_ ( _v_ ) if applied to a scalar _v_ and as _ϕ_ ( **v** ) = [ _φ_ ( _v_ 1) _, φ_ ( _v_ 2) _, . . . , φ_ ( _vn_ )] _[T] , ϕ_ : R _[n] →_ R _[n]_ if applied element wise to a vector **v** . For _φ_ ( _·_ ) the following inequality holds for any two inputs _v_ 1 _, v_ 2 _∈_ R [15]: 

Now we unite **x** ˜ and **h**[˜] as the joined state vector **z** ˜ and can rewrite (19) compactly as: 

with: 

Using the established layer relations, we substitute layer input ˜ **v** _i_ = **Az** + **b**[˜] in (18). From (21) it follows that the layer output _α ≤[φ]_[(] _[v] v_[2] 2[)] _−[ −][φ] v_ 1[(] _[v]_[1][)] _≤ β,_ (13) therefore is _ϕ_ ( **v** _i_ ) = **Bz** ˜. Applying these substitutions to (18), we get: 

where _α_ and _β_ define the minimum and maximum slopes, respectively. This condition can equivalently be expressed as: 

**==> picture [241 x 25] intentionally omitted <==**

By factoring out (˜ **z** 2 _−_ **z** ˜1) we obtain the following equation: 

which, after clearing the denominator, becomes: 

**==> picture [219 x 26] intentionally omitted <==**

**==> picture [142 x 12] intentionally omitted <==**

As shown in [15], the scalar inequality (15) can be rewritten in quadratic form. Multiplying both sides by _−_ 2 to eliminate the fractional coefficients yields: 

Combining the inequalities (24) and (11) yields: 

**==> picture [246 x 27] intentionally omitted <==**

To extend (16) to vector-valued functions, we use the elementwise non-linear transformation _ϕ_ ( **v** ) as well as the set 

If ( **Q** + **M** ) _⪯_ 0, then the left-hand side of the inequality (26) is guaranteed to be less than or equal to zero. This in turn also guarantees the right hand side to be less or equal to zero. This implies that (18) is satisfied, meaning any value of _ρ_ for which ( **Q** + **M** ) is negative semi-definite constitutes a valid upper bound on the Lipschitz constant. Consequently, the Lipschitz constant can be estimated by solving the following optimization problem: 

**==> picture [216 x 13] intentionally omitted <==**

where S _[n]_ denotes the set of symmetric _n × n_ matrices. Then, by Sylvester’s law of inertia [36], for any **T** _∈Tn_ the following inequality holds for all **v** 1 _,_ **v** 2 _∈_ R _[n]_ : 

**==> picture [247 x 27] intentionally omitted <==**

By viewing **v** _i, i ∈{_ 1 _,_ 2 _}_ as the linearly transformed inputs into each network layer and _φ_ ( **v** _i_ ) as the layer output after the non-linear activation function has been applied, the slope restrictions (16) can be applied to the network as a whole [15]. To apply this thinking in the RNN setting, we need to reformulate the update function (1) to apply to the entire network instead of just one time step. Using the stacked inputs **x** ˜ and hidden states **h**[˜] we obtain: 

The decision variables in this optimization problem are _ρ ∈_ R[+] and **T** _∈Tn_ , where _Tn_ in (17) is a convex set. Since the matrix ( **M** + **Q** ) is affine in both _ρ_ and _T_ , the problem is a semidefinite program (SDP) and can be solved efficiently using numerical solvers [37]. Solving the convex formulation yields a global optimum _ρ_ , which gives an upper bound on the squared Lipschitz constant of the unrolled RNN, yielding _L_ = _[√] ρ_ . 

6 

**==> picture [251 x 153] intentionally omitted <==**

**----- Start of picture text -----**<br>
tanh( v ) lb ub<br>cosh(1 v ) [2] β = 1 β = 1<br>α ≈ 0 . 42 α ≈ 0 . 42<br>α  = 0 α  = 0<br>(a) (b)<br>**----- End of picture text -----**<br>


Fig. 3: Impact of upper bound (ub) and lower bound (lb) on the slope restriction parameters _α_ and _β_ . (a) unbounded (b) bounded by (lb,ub) = (-1,1) 

However, (27) only gives the Lipschitz bound for the last output of the sequence, since we chose the network output to be point-wise, see (5). Therefore, (27) does not provide a bound for the deviations that could occur during the sequence, but only at the end. To get a bound for the entire sequence, the optimization (27) needs to be repeated _N_ times, once for each possible sequence length. The overall bound is then obtained by taking: 

**==> picture [205 x 39] intentionally omitted <==**

## _B. Input Restrictions_ 

Using global slope bounds ( _α, β_ ) as in (13) to estimate the Lipschitz constant yields a valid bound for any possible input. In practice, however, NN inputs are often normalized to a fixed range, improving both training convergence and numerical stability [21]. This normalization effectively constrains the inputs of the NN, which in turn can be used to derive tighter local slope bounds, as illustrated in Fig. 3. In this section we explore an approach to exploit this observation to compute _local slope bounds_ , with the aim to further tighten the Lipschitz constant estimates. 

We illustrate the proposed approach using the hyperbolic tangent activation function _f_ : _R_[1] _→_ ( _−_ 1 _,_ 1), 

**==> picture [209 x 25] intentionally omitted <==**

The derivative in (29) is symmetric about _v_ = 0 and decreases monotonically with _|v|_ . The maximum slope _β_ of _φ_ therefore occurs at _v_ = 0 and decreases as _|v|_ grows. Given the preactivationlocal slope bounds follow directly from evaluatingbounds [ _v_ lb[(] _[l]_[)] _,i[, v]_ ub[(] _[l]_[)] _,i_[]][of][a][neuron] _[i]_[in][layer] _φ_ ˙ ( _v_ ) at the _[l]_[,][the] 

extreme points of this interval: 

**==> picture [240 x 70] intentionally omitted <==**

For other differentiable slope-restricted activation functions, the same principle applies, although determining the extrema _·_ may not be as direct as in the tanh( ) case. The pre-activation bounds [ _v_ lb[(] _[l]_[)] _,i[, v]_ ub[(] _[l]_[)] _,i_[]][depend][on][bounds][on][the][current][input] **u** and the previous hidden state **h**[(] _[l][−]_[1)] as well as the bias **b** . Input bounds [ **u** lb _,_ **u** ub] are assumed to be constant and known based on normalization applied to the inputs of the NN. The hidden-state bounds [ **h**[(] lb _[l]_[)] _[,]_ **[ h]**[(] ub _[l]_[)][]][evolve][layer][by][layer:][the] bounds of the initial state **h**[(0)] are conservatively set to [ _−_ 1 _,_ 1] element-wise, matching the output range of tanh( _·_ ). For _l >_ 0, bounds are updated from the previous layer’s post-activation outputs. The pre-activation limits are obtained by solving: 

**==> picture [215 x 59] intentionally omitted <==**

and can then be used to update the hidden-state bounds for layer _l_ : 

**==> picture [172 x 40] intentionally omitted <==**

These updated bounds [ **h**[(] lb _[l]_[)] _[,]_ **[ h]**[(] ub _[l]_[)][]][are][then][used][in][(31)][for] the following layer. Repeating the calculations in (31), (30), and (32) as shown in Algorithm 1 for all layers of the NN yields the complete set of local slope bounds _αi_[(] _[l]_[)] and _βi_[(] _[l]_[)] for each neuron _i_ in each layer _l_ . 

**Algorithm 1** Local Slope Bound Estimation 

1: **Input:** Input and initial hidden bounds [ _xlb, xub_ ], [ _h_[0] _lb[, h]_[0] _ub_[]] 

- 2: **Initialize:** _l ←_ 0 

- 3: **repeat** 4: Compute input bounds [ _vlb,i_[(] _[l]_[)] _[, v] ub,i_[(] _[l]_[)][]][using][(31)] 5: Compute local slope bounds [ _αi_[(] _[l]_[)] _[, β] i_[(] _[l]_[)][]][using][(30)] 6: Compute next layer bounds [ **h** _[l] lb_[+1] _[,]_ **[ h]** _[l] ub_[+1][]][using][(32)] 7: _l ← l_ + 1 

8: **until** _l_ is the last layer 

- 9: **Output:** All local slope bounds _αi_[(] _[l]_[)][,] _[β] i_[(] _[l]_[)] 

In the original formulation of the **Q** matrix in (25), the slope-restriction parameters _α_ and _β_ were assumed identical for all neurons in a layer. This uniformity does not hold once neuron-specific local bounds _αi_[(] _[l]_[)] and _βi_[(] _[l]_[)] have been 

7 

is defined as **x** _t_ = [ _u_ 0 _, u_ 1 _, . . . , un_ ] _[⊤]_ , where _ui_ denotes the inflow into tank _i_ . The corresponding network output is **y** _t_ = [ _h_ 0 _, h_ 1 _, . . . , hn_ ] _[⊤]_ , representing the tank water levels. The tank dynamics are modeled in discrete time with step size ∆ _t_ = 1 s, based on the simplified physical approximation: 

computed. To accommodate per-neuron parameters at layer _l_ , replace the scalars in (25) with diagonal matrices 

**==> picture [232 x 66] intentionally omitted <==**

**==> picture [240 x 45] intentionally omitted <==**

and define 

**==> picture [229 x 25] intentionally omitted <==**

where _ai_ is a positive parameter reflecting the outflow characteristics of tank _i_ (e.g., pipe dimensions). Using (39), synthetic data for a three-tank setup was generated. The resulting data set consists of 1000 sequences of length 100, split into 70% for training and 30% for validation. 

When _αi_[(] _[l]_[)] _≡ α_ and _βi_[(] _[l]_[)] _≡ β_ for all _i_ and _l_ , we have **D** _×_ = ( _αβ_ ) **I** and **D** + = ( _α_ + _β_ ) **I** , and (34) reduces to the globalslope form in (25). 

The formulation in (34) preserves the structural role of **Q** , enabling the main method to be applied without major changes, while accommodating neuron-specific slope constraints. The impact of these modifications on the Lipschitz constant estimation is examined in Section IV. 

## _D. Empirical Lipschitz Estimation_ 

To evaluate the tightness of the RNN-SDP estimation (28) with (25) or (34), we compare the derived upper bounds to two empirical methods, that provide a lower bound of the Lipschitz constant: a naive _random exploration_ and a more targeted _active exploration_ . 

## _C. Network Training_ 

training is essential for achieving good perfor- _a) Random Exploration:_ A straightforward approach is NN. For RNNs, however, special care must be to estimate the Lipschitz constant by evaluating the network _stability_ , as this guarantees a finite Lipschitz on randomly generated input pairs, with the expectation that our method to be applied. The primary some may approximate the worst-case scenario. Since such cases typically occupy only a small subset of the input space, (MSE) on the RNN output: they are unlikely to be identified through naive sampling. _N_ Consequently, this method generally underestimates the true _L_ ac = _N −_ 1 25 _i_ �=25( **y** _i −_ **y** _i[∗]_[)][2] _[,]_ (35) constant, with the degree of underestimation depending on thenumber and diversity of samples. Nevertheless, it provides a guaranteed lower bound on the Lipschitz constant and can serve as a useful consistency check. 

Appropriate training is essential for achieving good performance in any NN. For RNNs, however, special care must be taken to ensure _stability_ , as this guarantees a finite Lipschitz constant and allows our method to be applied. The primary component of our employed loss function is the standard mean squared error (MSE) on the RNN output: 

where the first 25 samples of each sequence are omitted (washout) to avoid learning from initial transients that do not reflect the true system dynamics [38]. 

We generate random input sequences uniformly from [ _−_ 1 _,_ 1] and perturb them with additive Gaussian noise of variance 10 _[−]_[3] and mean zero. For each pair of original and perturbed inputs, we evaluate the empirical Lipschitz constant using a rearranged form of (5): 

To promote stability, we include a regularization term that activates when the spectral norm of the recurrent weight matrix **W** _h_ exceeds 1, since _∥_ **W** _h∥_ 2 _<_ 1 is the condition for absolute stability in RNNs [29]. This term is implemented as: 

**==> picture [191 x 39] intentionally omitted <==**

**==> picture [187 x 13] intentionally omitted <==**

with the leaky rectified linear unit 

**==> picture [188 x 31] intentionally omitted <==**

The final estimate, denoted _L_ rand in the results, is the maximum value observed across all evaluated pairs. In our experiments, we tested 10[7] independent random samples. 

and _a_ 1 _≫ a_ 2. This choice of _a_ 1 and _a_ 2 strongly penalizes _∥_ **W** _h∥_ 2 _>_ 1 while making further reductions below one have only a minor effect, thus avoiding unnecessary loss of accuracy. 

_b) Active Exploration:_ Instead of relying on chance, we can actively search for inputs that maximize the Lipschitz constant. In this method, both the base input and its perturbation are treated as optimization variables. We perform gradient ascent on _L_ emp by minimizing _L_ = _−L_ emp from (40). To reduce the likelihood of converging to a local maximum, we repeat the optimization from five different random initializations, retaining the best result as the empirical constant. 

The full training objective is therefore 

**==> picture [159 x 10] intentionally omitted <==**

RNNs were trained using the Adam optimizer [39]. Training stopped if the validation loss did not improve for ten consecutive epochs and _∥_ **W** _h∥_ 2 _<_ 1 was satisfied. 

For comparison with both bounded and unbounded RNNSDP settings, we also implement a bounded variant: the inputs are passed through a scaled tanh( _·_ ) to constrain them to [ _−_ 1 _,_ 1], and perturbations are constrained to [ _−_ 10 _[−]_[3] _,_ 10 _[−]_[3] ]. 

The training data for the RNNs was synthetically generated using a multi-tank system. The input at each time step _t_ 

8 

**==> picture [238 x 189] intentionally omitted <==**

**----- Start of picture text -----**<br>
LRNN LRNN,b Lact Lact,b LRand<br>0 . 8<br>0 . 6<br>0 . 4<br>0 . 2<br>20 40 60 80 100<br>Number of Unfolds [-]<br>[-]<br>L<br>Estimated<br>**----- End of picture text -----**<br>


Fig. 4: Upper bounds on the Lipschitz constant estimated by RNN-SDP ( _L_ RNN, _L_ RNN _,b_ ) and the empirical lower bounds, derived by active exploration ( _L_ act, _L_ act _,b_ ) and random exploration ( _L_ rand). The subscript _b_ indicates the bounded version of an approach. The y-axis shows the estimated Lipschitz constant, based on the average of 100 NNs. The x-axis shows the number of times the RNN has been unrolled. 

The smooth bounding ensures differentiability for stable convergence. Training stops if no improvement is seen for 10 consecutive epochs. 

The evaluation results are presented in the next section. 

## IV. RESULTS 

In this section, we evaluate the tightness of the Lipschitz bounds obtained with RNN-SDP. Specifically, we compare the certified upper bounds to empirically derived lower bounds to assess estimation accuracy. The evaluation was conducted on 100 RNNs trained as described in Section III-C. 

The estimated Lipschitz constants over sequence lengths from 1 to 100 are shown in Fig. 4. Five methods are compared: the RNN-SDP estimation ( _L_ RNN), its bounded-input variant ( _L_ RNN _,_ b), active search ( _L_ act), and its bounded-input variant ( _L_ act _,_ b), and random sampling ( _L_ Rand). Each curve reports the mean estimate across 100 trained RNNs. 

Across all methods, the estimates initially decrease with increasing sequence length and then converge to a plateau. This reflects the training objective, which enforced stability of the recurrent dynamics: as the RNN unrolls, the effect of initialization diminishes and sensitivity converges to a steady level. Convergence occurs around the 10[th] unrolling for activesearch methods and slightly earlier for the RNN-SDP. The effect is also evident in the worst-case trajectories identified by active exploration (Fig. 5), where for a long sequence, inputs are initially identical and diverge only near the end of the horizon, where they can impact the final output. 

The lower bound on the Lipschitz constant estimated via random sampling ( _L_ Rand) is consistently smaller than that obtained through active search, with the discrepancy increasing over longer horizons. This underestimation arises from the 

**==> picture [239 x 189] intentionally omitted <==**

**----- Start of picture text -----**<br>
input disturbed input<br>1<br>0 . 5<br>0<br>− 0 . 5<br>85 90 95 100<br>Timestep [-]<br>[-]<br>Input<br>**----- End of picture text -----**<br>


Fig. 5: Normalized input trajectories of the first tank yielding the largest Lipschitz constant found by active exploration over a sequence of 100 steps (only last 20 steps shown for clarity of presentation). 

low probability of encountering worst-case trajectories through naive sampling, as the input space expands significantly with longer sequences. Consequently, _L_ Rand represents a valid but overly loose lower bound that may _misleadingly suggest low overall model sensitivity_ , and is not suited for comparing the tightness of our method against, the active search method is used instead. 

The proposed analytical method (RNN-SDP, _L_ RNN) initially yields bounds that are very close to the active exploration results. At sequence length 1, the certified upper bound is less than 1% larger than the empirical lower bound. With increasing sequence length, the bounds gradually loosen, stabilizing at roughly 30% more conservative estimates. This degradation is likely due to compounding over-approximations from recursive bounding and local slope restrictions, rather than insufficient exploration in the active method. Nonetheless, the deviation remains moderate and consistent. 

The high Lipschitz constant for short sequences also highlights the influence of the initialization, which is often not accounted for due to its effect diminishing after a short time [23], [25]. However, for applications such as MPC, where the models are frequently reinitialized [26], this effect must be accounted for in robustness analysis. 

Bounding the input ( _L_ RNN _,_ b, _L_ act _,_ b) produces only marginally smaller constants. On average, bounding reduced the analytical estimates by 1.1%, with short (1–10), medium (10–50), and long (50–100) sequences improving by 0.8%, 1.2%, and 1.3%, respectively (Fig. 6). This suggests that the most sensitive inputs are already concentrated in the range [ _−_ 1 _,_ 1], which is consistent with the steepest slope of the tanh( _·_ ) activation near the origin. While bounding somewhat counteracts the compounding looseness of the method, the effect is too small to justify moving from a globally valid to a locally normalized bound. 

Overall, the analytical method provides sound and certifi- 

9 

**==> picture [221 x 157] intentionally omitted <==**

**----- Start of picture text -----**<br>
300<br>short<br>medium<br>long<br>200<br>100<br>0<br>0 0 . 5 1 1 . 5 2 2 . 5 3<br>Relative Decrease in L [%]<br>[-]<br>Samples<br>**----- End of picture text -----**<br>


Fig. 6: Histogram of the relative reduction in estimated Lipschitz constant, when using the bounding method presented in Section III-B. The top of the stacked bars represent the distribution of the improvement within the data set. The colors within each bar indicate from which category of sequence length the samples came: short(1-10), medium(10-50), long(50-100). Showing that while an average improvement of 1.1% was achieved, short sequences on average improved less (0.8%) then medium (1.2%) and long sequences (1.2%) 

able bounds. While about 30% more conservative than active search for long sequences, it guarantees validity, which is essential in safety-critical applications. Importantly, the certified bounds deviate by less than 1% from the largest empirically observed constants, highlighting both their reliability and practical utility, especially for worst case estimations. The results also emphasize the risks of relying on random sampling, which systematically fails to capture critical worst-case behaviors. 

## V. CONCLUSION 

In this paper, we introduced RNN-SDP, a novel method for computing certified upper bounds on the Lipschitz constant of RNNs over finite horizons. The approach explicitly accounts for both input disturbances and initialization uncertainty, providing a practical framework for robustness analysis in controloriented and safety certification settings. 

Our evaluation shows that the proposed upper bounds deviate by less than 1% from empirical lower bounds for short sequences and remain within about 30% conservatism for long sequences. This accuracy is valuable for short-horizon tasks such as real-time feedback control and anomaly detection, and sufficiently robust for long-horizon tasks such as multi-step trajectory planning. Combined with formal validity guarantees, the method is well suited for safety-critical applications. In contrast, a naive empirical approach such as random sampling was found to consistently underestimated the Lipschitz constant, illustrating the risks of relying on naive statistical estimation-methods. 

We further examined whether bounds could be tightened by incorporating input-domain constraints through local slope restrictions. While this modification yielded slight improvements, 1.1% on average, the gains were too small to justify 

abandoning globally valid guarantees and adding additional complexity to the approach. 

Overall, the proposed framework provides a step towards certifiable robustness analysis of RNNs, offering informative and guaranteed bounds that can serve as a foundation for robust model predictive control and related applications. 

## REFERENCES 

- [1] K. He, X. Zhang, S. Ren, and J. Sun, “Deep residual learning for image recognition,” in _2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ . IEEE, 2016, pp. 770–778. 

- [2] C. Manning, M. Surdeanu, J. Bauer, J. Finkel, S. Bethard, and D. McClosky, “The Stanford CoreNLP natural language processing toolkit,” in _Proceedings of 52nd Annual Meeting of the Association for Computational Linguistics: System Demonstrations_ . Stroudsburg, PA, USA: Association for Computational Linguistics, 2014. 

- [3] K. S. Narendra, “Neural networks for control theory and practice,” _Proceedings of the IEEE_ , vol. 84, no. 10, pp. 1385–1406, 1996. 

- [4] C. Liu, T. Arnon, C. Lazarus, C. Strong, C. Barrett, and M. J. Kochenderfer, “Algorithms for verifying deep neural networks,” _Foundations and Trends_ ® _in Optimization_ , vol. 4, no. 3-4, pp. 244–404, 2021. 

- [5] C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus, “Intriguing properties of neural networks,” 2014. [Online]. Available: http://arxiv.org/pdf/1312.6199v4 

- [6] S. Zheng, Y. Song, T. Leung, and I. Goodfellow, “Improving the robustness of deep neural networks via stability training,” in _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2016. 

- [7] B. Wu, J. Chen, D. Cai, X. He, and Q. Gu, “Do wider neural networks really help adversarial robustness?” in _Advances in Neural Information Processing Systems_ , M. Ranzato, A. Beygelzimer, Y. Dauphin, P.S. Liang, and J. Wortman Vaughan, Eds., vol. 34. Curran Associates, Inc, 2021, pp. 7054–7067. 

- [8] W. Xiang, H.-D. Tran, and T. T. Johnson, “Reachable set computation and safety verification for neural networks with relu activations,” 2017. 

- [9] T. Gehr, M. Mirman, D. Drachsler-Cohen, P. Tsankov, S. Chaudhuri, and M. Vechev, “Ai2: Safety and robustness certification of neural networks with abstract interpretation,” in _2018 IEEE Symposium on Security and Privacy (SP)_ . IEEE, 2018, pp. 3–18. 

- [10] A. Lomuscio and L. Maganti, “An approach to reachability analysis for feed-forward ReLU neural networks,” 2017. 

- [11] V. Tjeng, K. Xiao, and R. Tedrake, “Evaluating robustness of neural networks with mixed integer programming,” 2017. [Online]. Available: http://arxiv.org/pdf/1711.07356 

- [12] D. Guidotti, L. Pandolfo, and L. Pulina, “Leveraging satisfiability modulo theory solvers for verification of neural networks in predictive maintenance applications,” _Information_ , vol. 14, no. 7, p. 397, 2023. 

- [13] Huan Zhang, Tsui-Wei Weng, Pin-Yu Chen, Cho-Jui Hsieh, and Luca Daniel, “Efficient neural network robustness certification with general activation functions,” _Neural Information Processing Systems http://nips.cc/_ , vol. 32, 2018. 

- [14] Eric Wong and Zico Kolter, “Provable defenses against adversarial examples via the convex outer adversarial polytope,” _International Conference on Machine Learning_ , pp. 5286–5295, 2018. 

- [15] M. Fazlyab, A. Robey, H. Hassani, M. Morari, and G. J. Pappas, _Efficient and accurate estimation of lipschitz constants for deep neural networks_ . Red Hook, NY, USA: Curran Associates Inc., 2019. 

- [16] R. Rajamani, “Observers for Lipschitz nonlinear systems,” _IEEE Transactions on Automatic Control_ , vol. 43, no. 3, pp. 397–401, 1998. 

- [17] S. Yu, C. Maier, H. Chen, and F. Allg¨ower, “Tube MPC scheme based on robust control invariant set with application to Lipschitz nonlinear systems,” _Systems & Control Letters_ , vol. 62, no. 2, pp. 194–200, 2013. 

- [18] F. Bonassi, M. Farina, J. Xie, and R. Scattolini, “On recurrent neural networks for learning-based control: Recent results and ideas for future developments,” _Journal of Process Control_ , vol. 114, pp. 92–104, 2022. [Online]. Available: https://www.sciencedirect.com/ science/article/pii/S0959152422000610 

- [19] W. C. Wong, E. Chee, J. Li, and X. Wang, “Recurrent neural networkbased model predictive control for continuous pharmaceutical manufacturing,” _Mathematics_ , vol. 6, no. 11, p. 242, 2018. 

- [20] N. Mohajerin and S. L. Waslander, “Multistep prediction of dynamic systems with recurrent neural networks,” _IEEE transactions on neural networks and learning systems_ , vol. 30, no. 11, pp. 3370–3383, 2019. 

10 

- [21] P. Fergus and C. Chalmers, _Fundamentals of Machine Learning_ . Cham: Springer International Publishing, 2022, pp. 27–61. [Online]. Available: https://doi.org/10.1007/978-3-031-04420-5 2 

- [22] J. Miller and M. Hardt, “Stable recurrent models.” 

- [23] M. Revay, R. Wang, and I. R. Manchester, “A convex parameterization of robust recurrent neural networks,” _IEEE Control Systems Letters_ , vol. 5, no. 4, pp. 1363–1368, 2020. 

- [24] ——, “Recurrent equilibrium networks: Flexible dynamic models with guaranteed stability and robustness,” _IEEE Transactions on Automatic Control_ , vol. 69, no. 5, pp. 2855–2870, 2024. 

- [25] Y. Guo, Y. Li, and A. Farjudian, “Validated computation of lipschitz constant of recurrent neural networks,” in _Proceedings of the 2023 7th International Conference on Machine Learning and Soft Computing_ , ser. ICMLSC ’23. New York, NY, USA: Association for Computing Machinery, 2023, p. 46–52. [Online]. Available: https://doi.org/10.1145/3583788.3583795 

- [26] L. B. d. Giuli, A. L. Bella, M. Farina, and R. Scattolini, “Modeling and predictive control of networked systems via physics-informed neural networks,” in _2024 IEEE 63rd Conference on Decision and Control (CDC)_ , 2024, pp. 3005–3010. 

- [27] I. Sutskever, J. Martens, and G. E. Hinton, “Generating text with recurrent neural networks,” in _Proceedings of the 28th international conference on machine learning (ICML-11)_ , 2011, pp. 1017–1024. 

- [28] R. Pascanu, T. Mikolov, and Y. Bengio, “On the difficulty of training recurrent neural networks,” in _Proceedings of the 30th International Conference on Machine Learning_ , ser. Proceedings of Machine Learning Research, S. Dasgupta and D. McAllester, Eds., vol. 28. Atlanta, Georgia, USA: PMLR, 2013, pp. 1310–1318. [Online]. Available: https://proceedings.mlr.press/v28/pascanu13.html 

- [29] L. Jin, P. Nikiforuk, and M. Gupta, “Absolute stability conditions for discrete-time recurrent neural networks,” _IEEE Transactions on Neural Networks_ , vol. 5, no. 6, pp. 954–964, 1994. 

- [30] F. Bonassi, M. Farina, and R. Scattolini, “Stability of discretetime feed-forward neural networks in NARX configuration,” _IFACPapersOnLine_ , vol. 54, no. 7, pp. 547–552, 2021, 19th IFAC Symposium on System Identification SYSID 2021. [Online]. Available: https://www.sciencedirect.com/science/article/pii/S2405896321011915 

- [31] L. B. Armenio, E. Terzi, M. Farina, and R. Scattolini, “Model predictive control design for dynamical systems learned by echo state networks,” _IEEE Control Systems Letters_ , vol. 3, pp. 1044–1049, 2019. [Online]. Available: https://api.semanticscholar.org/CorpusID:195065241 

- [32] F. Bonassi, M. Farina, and R. Scattolini, “On the stability properties of gated recurrent units neural networks,” _Systems and amp; Control Letters_ , vol. 157, p. 105049, Nov. 2021. 

- [33] E. Terzi, F. Bonassi, M. Farina, and R. Scattolini, “Learning model predictive control with long short-term memory networks,” _International Journal of Robust and Nonlinear Control_ , vol. 31, no. 18, pp. 8877–8896, 2021. [Online]. Available: https://onlinelibrary.wiley. com/doi/abs/10.1002/rnc.5519 

- [34] S¸. Cobzas¸, R. Miculescu, and A. Nicolae, _Lipschitz Functions_ . Cham: Springer International Publishing, 2019, vol. 2241. 

- [35] M. Fazlyab, M. Morari, and G. J. Pappas, “Safety verification and robustness analysis of neural networks via quadratic constraints and semidefinite programming,” _IEEE Transactions on Automatic Control_ , vol. 67, no. 1, pp. 1–15, 2020. 

- [36] J. J. Sylvester, “A demonstration of the theorem that every homogeneous quadratic polynomial is reducible by real orthogonal substitutions to the form of a sum of positive and negative squares,” _The London, Edinburgh, and Dublin Philosophical Magazine and Journal of Science_ , vol. 4, no. 23, pp. 138–142, 1852. 

_point_ fashion. In **x** ˜ the first case, the model maps an input sequence **u** = � **h** 0� to the stacked outputs 

**==> picture [248 x 42] intentionally omitted <==**

while in the sequence-to-point case only the final prediction is taken: 

**==> picture [207 x 13] intentionally omitted <==**

Both definitions can in principle be used to estimate Lipschitz constants. However, for dynamical-system applications, the sequence-based definition can underestimate sensitivity due to causality. Specifically, the Lipschitz ratio for _f_ seq is 

**==> picture [246 x 24] intentionally omitted <==**

For _N_ = 2, this becomes 

**==> picture [178 x 25] intentionally omitted <==**

Since **y** 1 depends only on _u_ 1, including ∆ _u_ 2 in the denominator dilutes the apparent sensitivity at step 1. For example, with 

**==> picture [199 x 11] intentionally omitted <==**

we obtain 

**==> picture [245 x 25] intentionally omitted <==**

Here, the sequence-to-sequence definition undervalues the true stepwise sensitivity. In general, early outputs can appear artificially less sensitive because the denominator contains future inputs that cannot influence them. 

To avoid this dilution, we adopt a pointwise analysis: for each horizon _t_ , compute 

**==> picture [230 x 25] intentionally omitted <==**

and take _L_ = max _t_ =1 _,...,N Lt_ . This definition respects causality and ensures that worst-case step sensitivities are captured correctly. 

- [37] G¨artner, Bernd and Matouˇsek, Jiˇr´ı, “Semidefinite programming,” in _Approximation Algorithms and Semidefinite Programming_ . Berlin, Heidelberg: Springer Berlin Heidelberg, 2012, pp. 15–25. 

- [38] H. Jaeger, _The “echo state” approach to analysing and training recurrent neural networks-with an erratum note_ , 2001. [Online]. Available: https://www.ai.rug.nl/minds/uploads/echostatestechrep.pdf 

- [39] D. P. Kingma and J. Ba, _Adam: A Method for Stochastic Optimization_ , 2017. 

## APPENDIX POINT-WISE VS. SEQUENCE OUTPUTS IN RNN LIPSCHITZ ANALYSIS 

As noted in Section II-B, the output of an RNN can be defined either in a _sequence-to-sequence_ or a _sequence-to-_ 

