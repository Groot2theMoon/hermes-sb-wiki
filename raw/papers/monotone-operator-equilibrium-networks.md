---
title: "Monotone operator equilibrium networks"
arxiv: "2006.08591"
authors: ["Ezra Winston", "J. Zico Kolter"]
year: 2020
source: paper
ingested: 2026-05-03
sha256: c02402322afa71e4d028586bb530fe5f7e2c7c7a72d249511853f60eeb19d667
conversion: pymupdf4llm
---

## **Monotone operator equilibrium networks** 

**Ezra Winston** 

School of Computer Science Carnegie Mellon University Pittsburgh, United States `ewinston@cs.cmu.edu` 

**J. Zico Kolter** 

School of Computer Science Carnegie Mellon University & Bosch Center for AI Pittsburgh, United States `zkolter@cs.cmu.edu` 

## **Abstract** 

Implicit-depth models such as Deep Equilibrium Networks have recently been shown to match or exceed the performance of traditional deep networks while being much more memory efficient. However, these models suffer from unstable convergence to a solution and lack guarantees that a solution exists. On the other hand, Neural ODEs, another class of implicit-depth models, do guarantee existence of a unique solution but perform poorly compared with traditional networks. In this paper, we develop a new class of implicit-depth model based on the theory of monotone operators, the Monotone Operator Equilibrium Network (monDEQ). We show the close connection between finding the equilibrium point of an implicit network and solving a form of monotone operator splitting problem, which admits efficient solvers with guaranteed, stable convergence. We then develop a parameterization of the network which ensures that all operators remain monotone, which guarantees the existence of a unique equilibrium point. Finally, we show how to instantiate several versions of these models, and implement the resulting iterative solvers, for structured linear operators such as multi-scale convolutions. The resulting models vastly outperform the Neural ODE-based models while also being more computationally efficient. Code is available at `http://github.com/locuslab/monotone_op_net` . 

## **1 Introduction** 

Recent work in deep learning has demonstrated the power of _implicit-depth_ networks, models where features are created not by explicitly iterating some number of nonlinear layers, but by finding a solution to some implicitly defined equation. Instances of such models include the Neural ODE [8], which computes hidden layers as the solution to a continuous-time dynamical system, and the Deep Equilibrium (DEQ) Model [5], which finds a fixed point of a nonlinear dynamical system corresponding to an effectively infinite-depth weight-tied network. These models, which trace back to some of the original work on recurrent backpropagation [2, 23], have recently regained attention since they have been shown to match or even exceed to performance of traditional deep networks in domains such as sequence modeling [5]. At the same time, these models show drastically improved memory efficiency over traditional networks since backpropagation is typically done analytically using the implicit function theorem, without needing to store the intermediate hidden layers. 

However, implict-depth models that perform well require extensive tuning in order to achieve stable convergence to a solution. Obtaining convergence in DEQs requires careful initialization and regularization, which has proven difficult in practice [21]. Moreover, solutions to these models are not guaranteed to exist or be unique, making the output of the models potentially ill-defined. While Neural ODEs [8] do guarantee existence of a unique solution, training remains unstable since the ODE problems can become severely ill-posed [10]. Augmented Neural ODEs [10] improve the stability of Neural ODEs by learning ODEs with simpler flows, but neither model achieves efficient 

34th Conference on Neural Information Processing Systems (NeurIPS 2020), Vancouver, Canada. 

convergence nor performs well on standard benchmarks. Crucial questions remain about how models can have guaranteed, unique solutions, and what algorithms are most efficient at finding them. 

In this paper, we present a new class of implicit-depth equilibrium model, the Monotone Operator Equilibrium Network (monDEQ), which guarantees stable convergence to a unique fixed point.[1] The model is based upon the theory of monotone operators [6, 26], and illustrates a close connection between simple fixed-point iteration in weight-tied networks and the solution to a particular form of monotone operator splitting problem. Using this connection, this paper lays the theoretical and practical foundations for such networks. We show how to parameterize networks in a manner that ensures all operators remain monotone, which establishes the existence and uniqueness of the equilibrium point. We show how to backpropagate through such networks using the implicit function theorem; this leads to a corresponding (linear) operator splitting problem for the backward pass, which also is guaranteed to have a unique solution. We then adapt traditional operator splitting methods, such as forward-backward splitting or Peaceman-Rachford splitting, to naturally derive algorithms for efficiently computing these equilibrium points. 

Finally, we demonstrate how to practically implement such models and operator splitting methods, in the cases of typical feedforward, fully convolutional, and multi-scale convolutional networks. For convolutional networks, the most efficient fixed-point solution methods require an inversion of the associated linear operator, and we illustrate how to achieve this using the fast Fourier transform. The resulting networks show strong performance on several benchmark tasks, vastly improving upon the accuracy and efficiency of Neural ODEs-based models, the other implicit-depth models where solutions are guaranteed to exist and be unique. 

## **2 Related work** 

**Implicit models in deep learning** There has been a growing interest in recent years in implicit layers in deep learning. Instead of specifying the explicit computation to perform, a layer specifies some _condition_ that should hold at the solution to the layer, such as a nonlinear equality, or a differential equation solution. Using the implicit function theorem allows for backpropagating through the layer solutions _analytically_ , making these layers very memory efficient, as they do not need to maintain intermediate iterations of the solution procedure. Recent examples include layers that compute inference in graphical models [15], solve optimization problems [12, 3, 13, 1], execute model-based control policies [4], solve two-player games [20], solve gradient-based optimization for meta-learning [24], and many others. 

**Stability of fixed-point models** The issue of model stability has in fact been at the heart of much work in fixed-point models. The original work on attractor-style recurrent models, trained via recurrent backpropagation [2, 23], precisely attempted to ensure that the forward iteration procedure was stable. And indeed, much of the work in recurrent architectures such as LSTMs has focused on these issues of stability [14]. Recent work has revisited recurrent backpropagation in a similar manner to DEQs, with the similar aim of speeding up the computation of fixed points [19]. And other work has looked at the stability of implicit models [11], with an emphasis on guaranteeing the existence of fixed points, but focused on alternative stability conditions, and considered only relatively small-scale experiments. Other recent work has looked to use control-theoretic methods to ensure the stability of implicit models, [25], though again they consider only small-scale evaluations. 

**Monotone operators in deep learning** Although most work in the field of monotone operators is concerned with general convex analysis, the recent work of [9] does also highlight connections between deep networks and monotone operator problems. Unlike our current work, however, that work focused largely on the fact that many common non-linearities can be expressed via proximal operators, and analyzed traditional networks under the assumptions that certain of the operators were monotone, but did not address conditions for the networks to be monotone or algorithms for solving or backpropagating through the networks. 

## **3 A monotone operator view of fixed-point networks** 

This section lays out our main methodological and theoretical contribution, a class of equilibrium networks based upon monotone operators. We begin with some preliminaries, then highlight the 

1We largely use the terms “fixed point” and “equilibrium point” interchangably in this work, using fixed point in the context of an iterative procedure, and equilibrium point to refer more broadly to the point itself. 

2 

basic connection between the fixed point of an “infinite-depth” network and an associated operator splitting problem; next, we propose a parameterization that guarantees the associated operators to be maximal monotone; finally, we show how to use operator splitting methods to both compute the fixed point and backpropagate through the fixed point efficiently. 

## **3.1 Preliminaries** 

**Monotone operator theory** The theory of monotone operators plays a foundational role in convex analysis and optimization. Monotone operators are a natural generalization of monotone functions, which can be used to assess the convergence properties of many forms of iterative fixed-point algorithms. We emphasize that the majority of the work in this paper relies on well-known properties about monotone operators, and we refer to standard references on the topic including [6] and a less formal survey by [26]; we do include a brief recap of the definitions and results we require in Appendix A. Formally, an operator is a subset of the space _F ⊆_ R _[n] ×_ R _[n]_ ; in our setting this will usually correspond to set-valued or single-valued function. Operator splitting approaches refer to methods for finding a zero in a sum of operators, i.e., find _x_ such that 0 _∈_ ( _F_ + _G_ )( _x_ ). There are many such methods, but the two we will use mainly in this work are _forward-backward_ splitting (eqn. A9 in the Appendix) and _Peaceman-Rachford_ splitting (eqn. A10). As we will see, both finding a network equilibrium point and backpropagating through it can be formulated as operator splitting problems, and different operator splitting methods will lead to different approaches in their application to our subsequent implicit networks. 

**Deep equilibrium models** The monDEQ architecture is closely relate to the DEQ model, which parameterizes a “weight-tied, input-injected” network of the form _zi_ +1 = _g_ ( _zi, x_ ), where _x_ denotes the input to the network, injected at each layer; _zi_ denotes the hidden layer at depth _i_ ; and _g_ denotes a nonlinear function which is the same for each layer (hence the network is weight-tied). The key aspect of the DEQ model is that in this weight-tied setting, instead of forward iteration, we can simply use any root-finding approach to find an equilibrium point of such an iteration _z[∗]_ = _g_ ( _z[∗] , x_ ). Assuming the model is stable, this equilibrium point corresponds to an “infinite-depth fixed point” of the layer. The monDEQ architecture can be viewed as an instance of a DEQ model, but one that relies on the theory of monotone operators, and a specific paramterization of the network weights, to guarantee the existence of a unique fixed point for the network. Crucially, however, as is the case for DEQs, naive forward iteration of this model is _not_ necessarily stable; we therefore employ operator splitting methods to develop provably (linearly) convergent methods for finding such fixed points. 

## **3.2 Fixed-point networks as operator splitting** 

As a starting point of our analysis, consider the weight-tied, input-injected network in which _x ∈_ R _[d]_ denotes the input, and _z[k] ∈_ R _[n]_ denotes the hidden units at layer _k_ , given by the iteration[2] 

_z[k]_[+1] = _σ_ ( _Wz[k]_ + _Ux_ + _b_ ) (1) 

where _σ_ : R _→_ R is a nonlinearity applied elementwise, _W ∈_ R _[n][×][n]_ are the hidden unit weights, _U ∈_ R _[n][×][x]_ are the input-injection weights and _b ∈_ R _[n]_ is a bias term. An equilibrium point, or fixed point, of this system is some point _z[⋆]_ which remains constant after an update: 

_z[⋆]_ = _σ_ ( _Wz[⋆]_ + _Ux_ + _b_ ) _._ (2) 

We begin by observing that it is possible to characterize this equilibrium point exactly as the solution to a certain operator splitting problem, under certain choices of operators and activation _σ_ . This can be formalized in the following theorem, which we prove in Appendix B: 

**Theorem 1.** _Finding a fixed point of the iteration (1) is equivalent to finding a zero of the operator splitting problem_ 0 _∈_ ( _F_ + _G_ )( _z[⋆]_ ) _with the operators_ 

**==> picture [287 x 11] intentionally omitted <==**

_and σ_ ( _·_ ) = prox[1] _f_[(] _[·]_[)] _[ for some convex closed proper (CCP) function][f][,][where]_[prox] _[α] f[denotes the] proximal operator_ 

**==> picture [283 x 23] intentionally omitted <==**

2This setting can also be seen as corresponding to a recurrent network with identical inputs at each time (indeed, this is the view of so-called attractor networks [23]). However, because in modern usage recurrent networks typically refer to sequential models with _different_ inputs at each time, we don’t adopt this terminology. 

3 

It is also well-established that many common nonlinearities used in deep networks can be represented as proximal operators of CCP functions [7, 9]. For example, the ReLU nonlinearity _σ_ ( _x_ ) = [ _x_ ]+ is the proximal operator of the indicator of the positive orthant _f_ ( _x_ ) = _I{x ≥_ 0 _}_ , and tanh, sigmoid, and softplus all have close correspondence with proximal operators of simple expressions [7]. 

In fact, this method establishes that some seemingly unstable iterations can actually still lead to convergent algorithms. ReLU activations, for instance, have traditionally been avoided in iterative models such as recurrent networks, due to exploding or vanishing gradient problems and nonsmoothness. Yet this iteration shows that (with input injection and the above constraint on _W_ ), ReLU operators are perfectly well-suited to these fixed-point iterations. 

## **3.3 Enforcing existence of a unique solution** 

The above connection is straightforward, but also carries interesting implications for deep learning. Specifically, we can establish the existence and uniqueness of the equilibirum point _z[⋆]_ via the simple sufficient criterion that _I − W_ is strongly monotone, or in other words[3] _I − W ⪰ mI_ for some _m >_ 0 (see Appendix A). The constraint is by no means a trivial condition. Although many layers obey this condition under typical initialization schemes, during training it is normal for _W_ to move outside this regime. Thus, the first step of the monDEQ architecture is to parameterize _W_ in such a way that it always satisfies this strong monotonicity constraint. 

**==> picture [397 x 26] intentionally omitted <==**

We therefore propose to simply parameterize _W_ directly in this form, by defining the _A_ and _B_ matrices directly. While this is an overparameterized form for a dense matrix, we could avoid this issue by, e.g. constraining _A_ to be lower triangular (making it the Cholesky factor of _A[T] A_ ), and by making _B_ strictly upper triangular; in practice, however, simply using general _A_ and _B_ matrices has little impact upon the performance of the method. The parameterization does notably raise additional complications when dealing with convolutional layers, but we defer this discussion to Section 4.2. 

## **3.4 Computing the network fixed point** 

Given the monDEQ formulation, the first natural question to ask is: how should we compute the equilibrium point _z[⋆]_ = _σ_ ( _Wz[⋆]_ + _Ux_ + _b_ )? Crucially, it can be the case that the simple forward iteration of the network equation (1) does _not_ converge, i.e., the iteration may be unstable. Fortunately, monotone operator splitting leads to a number of iterative methods for finding these fixed points, which are guaranteed to converge under proper conditions. For example, the forward-backward iteration applied to the monotone operator formulation from Theorem 1 results exactly in a damped version of the forward iteration 

_z[k]_[+1] = prox _[α] f_[(] _[z][k][ −][α]_[((] _[I][ −][W]_[)] _[z][k][ −]_[(] _[Ux]_[ +] _[ b]_[))) = prox] _[α] f_[((1] _[ −][α]_[)] _[z][k]_[ +] _[ α]_[(] _[Wz][k]_[ +] _[ Ux]_[ +] _[ b]_[))] _[.]_[(6)] This iteration is guaranteed to converge linearly to the fixed point _z[⋆]_ provided that _α ≤_ 2 _m/L_[2] , when the operator _I − W_ is Lipschitz and strongly monotone with parameters _L_ (which is simply the operator norm _∥I − W ∥_ 2) and _m_ [26]. 

A key advantage of the monDEQ formulation is the flexibility to employ alternative operator splitting methods that converge much more quickly to the equilibrium. One such example is PeacemanRachford splitting which, when applied to the formulation from Theorem 1, takes the form 

**==> picture [306 x 63] intentionally omitted <==**

where we use the explicit form of the resolvents for the two monotone operators of the model. The advantage of Peaceman-Rachford splitting over forward-backward is two-fold: 1) it typically converges in fewer iterations, which is a key bottleneck for many implicit models; and 2) it converges 

> 3For non-symmetric matrices, which of course is typically the case with _W_ , positive definiteness is defined as the positive definiteness of the symmetric component _I − W ⪰ mI ⇔ I −_ ( _W_ + _W[T]_ ) _/_ 2 _⪰ mI_ . 

4 

|**Algorithm 1**Forward-backward equilibrium solving<br>_z_ := 0;<br>err:= 1<br>**while**err_> ϵ_**do**<br>_z_+ := (1_−α_)_z_+_α_(_Wz_+_Ux_+_b_)<br>_z_+ := prox_α_<br>_f_ (_z_+)<br>err:= _∥z_+_−z∥_2<br>_∥z_+_∥_2<br>_z_ :=_z_+<br>**return**_z_|**Algorithm 2**Peaceman-Rachford equilibrium solving|
|---|---|
||_z, u_:= 0;<br>err:= 1;<br>_V_ := (_I_ +_α_(_I −W_))_−_1<br>**while**err_> ϵ_**do**<br>_u_1_/_2 := 2_z −u_<br>_z_1_/_2 :=_V_(_u_1_/_2 +_α_(_Ux_+_b_))<br>_u_+ := 2_z_1_/_2 _−u_1_/_2<br>_z_+ := prox_α_<br>_f_ (_u_+)<br>err:= _∥z_+_−z∥_2<br>_∥z_+_∥_2<br>_z, u_:=_z_+_, u_+<br>**return**_z_|



for any _α >_ 0 [26], unlike forward-backward splitting which is dependent on the Lipschitz constant of _I − W_ . The disadvantage of Peaceman-Rachford splitting, however, is that it requires an inverse involving the weight matrix _W_ . It is not immediately clear how to apply such methods if the _W_ matrix involves convolutions or multi-layer models; we discuss these points in Section 4.2. A summary of these methods for computation of the forward equilibrium point is given in Algorithms 1 and 2. 

## **3.5 Backprogation through the monotone operator layer** 

Finally, a key challenge for any implicit model is to determine how to perform backpropagation through the layer. As with most implicit models, a potential benefit of the fixed-point conditions we describe is that, by using the implicit function theorem, it is possible to perform backpropagation without storing the intermediate iterates of the operator splitting algorithm in memory, and instead backpropagating directly through the equilibrium point. 

To begin, we present a standard approach to differentiating through the fixed point _z[⋆]_ using the implicit function theorem. This formulation has some compelling properties for monDEQ, namely the fact that this (sub)gradient will always exist. When training a network via gradient descent, we need to compute the gradients of the loss function 

**==> picture [233 x 24] intentionally omitted <==**

where ( _·_ ) denotes some input to the layer or parameters, i.e. _W_ , _x_ , etc. The challenge here is computing (or left-multiplying by) the Jacobian _∂z[⋆] /∂_ ( _·_ ), since _z[⋆]_ is not an explicit function of the inputs. While it would be possible to simply compute gradients through the “unrolled” updates, e.g. _z[k]_[+1] = _σ_ ( _Wz[k]_ + _Ux_ + _b_ ) for forward iteration, this would require storing each intermediate state _z[k]_ , a potentially memory-intensive operation. Instead, the following theorem gives an explicit formula for the necessary (sub)gradients. We state the theorem more directly in terms of the operators mentioned Theorem 1; that is, we use prox[1] _f_[(] _[·]_[)][ in place of] _[ σ]_[(] _[·]_[)][.] 

**Theorem 2.** _For the equilibrium point z[⋆]_ = prox[1] _f_[(] _[Wz][⋆]_[+] _[ Ux]_[ +] _[ b]_[)] _[, we have]_ 

**==> picture [293 x 25] intentionally omitted <==**

_where_ 

**==> picture [260 x 14] intentionally omitted <==**

_denotes the Clarke generalized Jacobian of the nonlinearity evaluated at the point Wz[⋆]_ + _Ux_ + _b. Furthermore, for the case that_ ( _I − W_ ) _⪰ mI, this derivative always exists._ 

To apply the theorem in practice to perform reverse-mode differentiation, we need to solve the system 

**==> picture [248 x 27] intentionally omitted <==**

The above system is a linear equation and while it is typically computationally infeasible to compute the inverse ( _I − JW_ ) _[−][T]_ exactly, we could compute a solution to ( _I − JW_ ) _[−][T] v_ using, e.g., conjugate gradient methods. However, we present an alternative formulation to computing (11) as the solution to a (linear) monotone operator splitting problem: 

5 

**Algorithm 3** Forward-backward equilibrium **Algorithm 4** Peaceman-Rachford equilibrium backpropagation backpropagation _∂ℓ[−]_ 

|backroaation||||||
|---|---|---|---|---|---|
|ppg<br>_u_:= 0;<br>err:= 1;<br>_v_ :=<br>**while**err_> ϵ_**do**|_∂ℓ_<br>_∂z∗_|_z, u_:= 0;<br>err:= 1;<br>_v_ <br>**while**err_> ϵ_**do**<br>_u_1_/_2 := 2_z −u_|:=|_∂ℓ_<br>_∂z∗_;|_V_ := (_I_+_α_(_I −W_))_−_1|
|_u_+ := (1_−α_)_u_+_αW T u_<br>_u_+<br>_i_ :=<br>�<br>_u_+<br>_i_ +_αvi_<br>1+_α_(1+_Dii_)<br>if_Dii < ∞_<br>0<br>if_Dii_ =_∞_<br>err:= _∥u_+_−u∥_2<br>_∥u_+_∥_2<br>_u_:=_u_+||_z_1_/_2 :=_V T u_1_/_2<br>_u_+ := 2_z_1_/_2 _−u_1_/_2<br>_z_+<br>_i_ :=<br>�<br>_u_+<br>_i_ +_αvi_<br>1+_α_(1+_Dii_)<br>0<br>err:= _∥z_+_−z∥_2<br>_∥z_+_∥_2|if <br>if|_Dii < _<br>_Dii_ =|_∞_<br>_∞_|
|**return**_u_||_z, u_:=_z_+_, u_+||||
|||**return**_z_||||



**Theorem 3.** _Let z[⋆] be a solution to the monotone operator splitting problem defined in Theorem 1, and define J as in (10). Then for v ∈_ R _[n] the solution of the equation_ 

**==> picture [240 x 12] intentionally omitted <==**

_is given by_ 

**==> picture [233 x 11] intentionally omitted <==**

_where u_ ˜ _[⋆] is a zero of the operator splitting problem_ 0 _∈_ ( _F_[˜] + _G_[˜] )( _u[⋆]_ ) _, with operators defined as_ 

**==> picture [282 x 13] intentionally omitted <==**

_where D is a diagonal matrix defined by J_ = ( _I_ + _D_ ) _[−]_[1] _(where we allow for the possibility of Dii_ = _∞ for Jii_ = 0 _)._ 

An advantage of this approach when using Peaceman-Rachford splitting is that it allows us to reuse a fast method for multiplying by ( _I_ + _α_ ( _I − W_ )) _[−]_[1] which is required by Peaceman-Rachford during both the forward pass (equilibrium solving) and backward pass (backpropagation) of training a monDEQ. Algorithms detailing both the Peaceman-Rachford and forward-backward solvers for the backpropagation problem (14) are given in Algorithms 3 and 4. 

## **4 Example monotone operator networks** 

With the basic foundations from the previous section, we now highlight several different instantiations of the monDEQ architecture. In each of these settings, as in Theorem 1, we will formulate the objective as one of finding a solution to the operator splitting problem 0 _∈_ ( _F_ + _G_ )( _z[⋆]_ ) for 

**==> picture [286 x 11] intentionally omitted <==**

or equivalently as computing an equilibrium point _z[⋆]_ = prox[1] _f_[(] _[Wz][⋆]_[+] _[ Ux]_[ +] _[ b]_[)][.] 

In each of these settings we need to define what the input and hidden state _x_ and _z_ correspond to, what the _W_ and _U_ operators consist of, and what is the function _f_ which determines the network nonlinearity. Key to the application of monotone operator methods are that 1) we need to constrain the _W_ matrix such that _I − W ⪰ mI_ as described in the previous section and 2) we need a method to compute (or solve) the inverse ( _I_ + _α_ ( _I − W_ )) _[−]_[1] , needed e.g. for Peaceman-Rachford; while this would not be needed if using only forward-backward splitting, we believe that the full power of the monotone operator view is realized precisely when these more involved methods are possible. 

## **4.1 Fully connected networks** 

The simplest setting, of course, is the case we have largely highlighted above, where _x ∈_ R _[d]_ and _z ∈_ R _[n]_ are unstructured vectors, and _W ∈_ R _[n][×][n]_ and _U ∈_ R _[n][×][d]_ and _b ∈_ R _[n]_ are dense matrices and vectors respectively. As indicated above, we parameterize _W_ directly by _A, B ∈_ R _[n][×][n]_ as in (5). Since the _Ux_ term simply acts as a bias in the iteration, there is no constraint on the form of _U_ . 

We can form an inverse directly by simply forming and inverting the matrix _I_ + _α_ ( _I − W_ ), which has cost _O_ ( _n_[3] ). Note that this inverse needs to be formed only once, and can be reused over all iterations of the operator splitting method and over an entire batch of examples (but recomputed, of course, when _W_ changes). Any proximal function can be used as the activation: for example the ReLU, though as mentioned there are also close approximations to the sigmoid, tanh, and softplus. 

6 

## **4.2 Convolutional networks** 

The real power of monDEQs comes with the ability to use more structured linear operators such as convolutions. We let _x ∈_ R _[ds]_[2] be a _d_ -channel input of size _s × s_ and _z ∈_ R _[ns]_[2] be a _n_ -channel hidden layer. We also let _W ∈_ R _[ns]_[2] _[×][ns]_[2] denote the linear form of a 2D convolutional operator and similarly for _U ∈_ R _[ns]_[2] _[×][ds]_[2] . As above, _W_ is parameterized by two additional convolutional operators _A, B_ of the same form as _W_ . Note that this implicitly increases the receptive field size of _W_ : if _A_ and _B_ are 3 _×_ 3 convolutions, then _W_ = (1 _− m_ ) _I − A[T] A_ + _B − B[T]_ will have an effective kernel size of 5. 

**Inversion** The benefit of convolutional operators in this setting is the ability to perform efficient inversion via the fast Fourier transform. Specifically, in the case that _A_ and _B_ represent circular convolutions, we can reduce the matrices to block-diagonal form via the discrete Fourier transform (DFT) matrix 

**==> picture [228 x 11] intentionally omitted <==**

where _Fs_ denotes (a permuted form of) the 2D DFT operator and _DA ∈_ C _[ns]_[2] _[×][ns]_[2] is a (complex) block diagonal matrix where each block _DAii ∈_ C _[n][×][n]_ corresponds to the DFT at one particular location in the image. In this form, we can efficiently multiply by the inverse of the convolutional operator, noting that 

**==> picture [326 x 26] intentionally omitted <==**

The inner term here is itself a block diagonal matrix with complex _n × n_ blocks (each block is also guaranteed to be invertible by the same logic as for the full matrix). Thus, we can multiply a set of hidden units _z_ by the inverse of this matrix by simply inverting each _n × n_ block, taking the fast Fourier transform (FFT) of _z_ , multiplying each corresponding block of _Fsz_ by the corresponding inverse, then taking the inverse FFT. The details are given in Appendix C. 

The computational cost of multiplying by this inverse is _O_ ( _n_[2] _s_[2] log _s_ + _n_[3] _s_[2] ) to compute the FFT of each convolutional filter and precompute the inverses, and then _O_ ( _bns_[2] log _s_ + _bn_[2] _s_[2] ) to multiply by the inverses for a set of hidden units with a minibatch of size _b_ . Note that just computing the convolutions in a normal manner has cost _O_ ( _bn_[2] _s_[2] ), so that these computations are on the same order as performing typical forward passes through a network, though empirically 2-3 times slower owing to the relative complexity of performing the necessary FFTs. 

One drawback of using the FFT in this manner is that it requires that all convolutions be circular; however, this circular dependence can be avoided using zero-padding, as detailed in Section C.2. 

## **4.3 Forward multi-tier networks** 

Although a single fully-connected or convolutional operator within a monDEQ can be suitable for small-scale problems, in typical deep learning settings it is common to model hidden units at different hierarchical levels. While monDEQs may seem inherently “single-layer,” we can model this same hierarchical structure by incorporating structure into the _W_ matrix. For example, assuming a convolutional setting, with input _x ∈_ R _[ds]_[2] as in the previous section, we could partition _z_ into _L_ different hierarchical resolutions and let _W_ have a multi-tier structure, e.g. 

**==> picture [290 x 60] intentionally omitted <==**

where _zi_ denotes the hidden units at level _i_ , an _si × si_ resolution hidden unit with _ni_ channels, and where _Wii_ denotes an _ni_ channel to _ni_ channel convolution, and _Wi_ +1 _,i_ denotes an _ni_ to _ni_ +1 channel, _strided_ convolution. This structure of _W_ allows for both inter- and intra-tier influence. 

One challenge is to ensure that we can represent _W_ with the form (1 _− m_ ) _I − A[T] A_ + _B − B[T]_ while still maintaining the above structure, which we achieve by parameterizing each _Wij_ block appropriately. Another consideration is the inversion of the multi-tier operator, which can be achieved via the FFT similarly as for single-convolutional _W_ , but with additional complexity arising from the fact that the _Ai_ +1 _,i_ convolutions are strided. These details are described in Appendix D. 

7 

**CIFAR-10** 

|**Method**|**Model size**|**Acc.**|
|---|---|---|
|Neural ODE|172K|55.3_±_0.3%|
|Aug. Neural ODE<br>Neural ODE_†∗_<br>Aug. Neural ODE_†∗_<br>monDEQ (ours)<br>Single conv<br>Multi-tier|172K<br>1M<br>1M<br>172K<br>170K|58.9_±_2.8%<br>59.9%<br>73.4%<br>**74.0**_±_**0.1%**<br>72.0_±_0.3%|
|Single conv_∗_|854K|82.0_±_0.3%|
|Multi-tier_∗_|1M|**89.0**_±_**0.3%**|
||**SVHN**||
|**Method**<br>Neural ODE_‡_<br>Aug. Neural ODE_‡_|**Model size**<br>172K<br>172K|**Acc.**<br>81.0%<br>83.5%|
|monDEQ (ours)|||
|Single conv|172K|88.7_±_1.1%|
|Multi-tier|170K|**92.4**_±_**0.1%**|
|**MNIST**|||
|**Method**<br>Neural ODE_‡_<br>Aug. Neural ODE_‡_|**Model size**<br>84K<br>84K|**Acc.**<br>96.4%<br>98.2%|
|monDEQ (ours)|||
|Fully connected|84K|98.1_±_0.1%|
|Single conv|84K|**99.1**_±_**0.1%**|
|Multi-tier|81K|99.0_±_0.1%|



Table 1: Test accuracy of monDEQ models compared to Neural ODEs and Augmented Neural ODEs. *with data augmentation; _[†]_ best test accuracy before training diverges; _[‡]_ as reported in [10]. 

**==> picture [216 x 351] intentionally omitted <==**

**----- Start of picture text -----**<br>
CIFAR-10<br>80<br>70<br>60<br>50<br>Single conv NODE<br>40 Multi-tier ANODE<br>1 10 20 30 40<br>Epochs<br>Figure 1: Test accuracy of monDEQs during training<br>on CIFAR-10, with NODE [8] and ANODE [10] for<br>comparison. NODE and ANODE curves obtained using<br>code provided by [10].<br>Forward-pass iterations<br>80 ® = 1<br>® tuned<br>60<br>40<br>20<br>0 20 40 60<br>Epochs<br>% Test accuracy<br>Iterations<br>**----- End of picture text -----**<br>


Figure 2: Iterations required by Peaceman-Rachford equilibrium solving over the course of training, for best _α_ and _α_ = 1. 

## **5 Experiments** 

To test the expressive power and training stability of monDEQs, we evaluate the monDEQ instantiations described in Section 4 on several image classification benchmarks. We take as a point of comparison the Neural ODE (NODE) [8] and Augmented Neural ODE (ANODE) [10] models, the only other implicit-depth models which guarantee the existence and uniqueness of a solution. We also assess the stability of training standard DEQs of the same form as our monDEQs. 

The training process relies upon the operator splitting algorithms derived in Sections 3.4 and 3.5; for each batch of examples, the forward pass of the network involves finding the network fixed point (Algorithm 1 or 2), and the backward pass involves backpropagating the loss gradient through the fixed point (Algorithm 3 or 4). We analyze the convergence properties of both the forward-backward and Peaceman-Rachford operator splitting methods, and use the more efficient Peaceman-Rachford splitting for our model training. For further training details and model architectures see Appendix E. Experiment code can be found at `http://github.com/locuslab/monotone_op_net` . 

**Performance on image benchmarks** We train small monDEQs on CIFAR-10 [17], SVHN [22], and MNIST [18], with a similar number of parameters as the ODE-based models reported in [8] and [10]. The results (averages over three runs) are shown in Table 1. Training curves for monDEQs, NODE, and ANODE on CIFAR-10 are show in Figure (1) and additional training curves are shown in Figure F1. Notably, except for the fully-connected model on MNIST, all monDEQs significantly outperform the ODE-based models across datasets. We highlight the performance of the small single convolution monDEQ on CIFAR-10 which outperforms Augmented Neural ODE by 15.1%. 

8 

**==> picture [397 x 170] intentionally omitted <==**

**----- Start of picture text -----**<br>
Forward-backward Peaceman-Rachford<br>2<br>10<br>0<br>10<br>-2<br>10<br>-4<br>10<br>0 50 100 150 200 250 0 50 100 150 200 250<br>Iterations Iterations<br>α = 1 α = 1/4 α = 1/8 α = 1/16 α = 1/32 α = 1/64<br>Residual<br>**----- End of picture text -----**<br>


Figure 3: Convergence of Peaceman-Rachford and forward-backward equilibrium solving, on fully-trained model. 

We also attempt to train standard DEQs of the same structure as our small multi-tier convolutional monDEQ. We train DEQs both with unconstrained _W_ and with _W_ having the monotone parameterization (5), and solve for the fixed point using Broyden’s method as in [5]. All models quickly diverge during the first few epochs of training, even when allowed 300 iterations of Broyden’s method. 

Additionally, we train two larger monDEQs on CIFAR-10 with data augmentation. The strong performance (89% test accuracy) of the multi-tier network, in particular, goes a long way towards closing the performance gap with traditional deep networks. For comparison, we train larger NODE and ANODE models with a comparable number of parameters (~1M). These attain higher test accuracy than the smaller models during training, but diverge after 10-30 epochs (see Figure F1). 

**Efficiency of operator splitting methods** We compare the convergence rates of PeacemanRachford and forward-backward splitting on a fully trained model, using a large multi-tier monDEQ trained on CIFAR-10. Figure 3 shows convergence for both methods during the forward pass, for a range of _α_ . As the theory suggests, the convergence rates depend strongly on the choice of _α_ . Forward-backward does not converge for _α >_ 0 _._ 125, but convergence speed varies inversely with _α_ for _α <_ 0 _._ 125. In contrast, Peaceman-Rachford is guaranteed to converge for any _α >_ 0 but the dependence is non-monotonic. We see that, for the optimal choice of _α_ , Peaceman-Rachford can converge much more quickly than forward-backward. The convergence rate also depends on the Lipschitz parameter _L_ of _I − W_ , which we observe increases during training. Peaceman-Rachford therefore requires an increasing number of iterations during both the forward pass (Figure 2) and backward pass (Figure F2). 

Finally, we compare the efficiency of monDEQ to that of the ODE-based models. We report the time and number of function evaluations (OED solver steps or operator splitting iterations) required by the ~170k-parameter models to train on CIFAR-10 for 40 epochs. The monDEQ, neural ODE, and ANODE training takes respectively 1.4, 4.4, and 3.3 hours, with an average of 20, 96, and 90 function evals per minibatch. Note however that training the larger 1M-parameter monDEQ on CIFAR-10 requires 65 epochs and takes 16 hours. All experiments are run on a single RTX 2080 Ti GPU. 

## **6 Conclusion** 

The connection between monotone operator splitting and implicit network equilibria brings a new suite of tools to the study of implicit-depth networks. The strong performance, efficiency, and guaranteed stability of monDEQ indicate that such networks could become practical alternatives to deep networks, while the flexibility of the framework means that performance can likely be further improved by, e.g. imposing additional structure on _W_ or employing other operator splitting methods. At the same time, we see potential for the study of monDEQs to inform traditional deep learning itself. The guarantees we can derive about what architectures and algorithms work for implicit-depth networks may give us insights into what will work for explicit deep networks. 

9 

## **Broader impact statement** 

While the main thrust of our work is foundational in nature, we do demonstrate the potential for implicit models to become practical alternatives to traditional deep networks. Owing to their improved memory efficiency, these networks have the potential to further applications of AI methods on edge devices, where they are currently largely impractical. However, the work is still largely algorithmic in nature, and thus it is much less clear the immediate societal-level benefits (or harms) that could result from the specific tehniques we propose and demonstrate in this paper. 

## **Acknowledgements** 

Ezra Winston is supported by a grant from the Bosch Center for Artificial Intelligence. 

## **References** 

- [1] A. Agrawal, B. Amos, S. Barratt, S. Boyd, S. Diamond, and J. Z. Kolter. Differentiable convex optimization layers. In _Neural Information Processing Systems_ , 2019. 

- [2] L. B. Almeida. A learning rule for asynchronous perceptrons with feedback in a combinatorial environment. In _Artificial Neural Networks_ . 1990. 

- [3] B. Amos and J. Z. Kolter. OptNet: Differentiable optimization as a layer in neural networks. In _International Conference on Machine Learning_ , 2017. 

- [4] B. Amos, I. Jimenez, J. Sacks, B. Boots, and J. Z. Kolter. Differentiable mpc for end-to-end planning and control. In _Advances in Neural Information Processing Systems_ , pages 8299–8310, 2018. 

- [5] S. Bai, J. Z. Kolter, and V. Koltun. Deep equilibrium models. In _Advances in Neural Information Processing Systems_ , pages 688–699, 2019. 

- [6] H. H. Bauschke, P. L. Combettes, et al. _Convex analysis and monotone operator theory in Hilbert spaces_ , volume 408. Springer, 2011. 

- [7] A. Bibi, B. Ghanem, V. Koltun, and R. Ranftl. Deep layers as stochastic solvers. In _International Conference on Learning Representations_ , 2019. URL `https://openreview.net/forum? id=ryxxCiRqYX` . 

- [8] T. Q. Chen, Y. Rubanova, J. Bettencourt, and D. K. Duvenaud. Neural ordinary differential equations. In _Advances in neural information processing systems_ , pages 6571–6583, 2018. 

- [9] P. L. Combettes and J.-C. Pesquet. Deep neural network structures solving variational inequalities. _Set-Valued and Variational Analysis_ , pages 1–28, 2020. 

- [10] E. Dupont, A. Doucet, and Y. W. Teh. Augmented neural odes. In _Advances in Neural Information Processing Systems_ , pages 3134–3144, 2019. 

- [11] L. El Ghaoui, F. Gu, B. Travacca, and A. Askari. Implicit deep learning. _arXiv preprint arXiv:1908.06315_ , 2019. 

- [12] S. Gould, B. Fernando, A. Cherian, P. Anderson, R. S. Cruz, and E. Guo. On differentiating parameterized argmin and argmax problems with application to bi-level optimization. _arXiv preprint arXiv:1607.05447_ , 2016. 

- [13] S. Gould, R. Hartley, and D. Campbell. Deep declarative networks: A new hope. _arXiv preprint arXiv:1909.04866_ , 2019. 

- [14] S. Hochreiter and J. Schmidhuber. Long short-term memory. _Neural computation_ , 9(8): 1735–1780, 1997. 

- [15] M. Johnson, D. K. Duvenaud, A. Wiltschko, R. P. Adams, and S. R. Datta. Composing graphical models with neural networks for structured representations and fast inference. In _Advances in Neural Information Processing Systems_ , 2016. 

- [16] D. P. Kingma and J. Ba. Adam: A method for stochastic optimization. In Y. Bengio and Y. LeCun, editors, _3rd International Conference on Learning Representations, ICLR 2015, San Diego, CA, USA, May 7-9, 2015, Conference Track Proceedings_ , 2015. URL `http: //arxiv.org/abs/1412.6980` . 

10 

- [17] A. Krizhevsky and G. Hinton. Learning multiple layers of features from tiny images. Technical report, University of Toronto, 2009. 

- [18] Y. LeCun, C. Cortes, and C. Burges. Mnist handwritten digit database. _ATT Labs [Online]. Available: http://yann.lecun.com/exdb/mnist_ , 2, 2010. 

- [19] R. Liao, Y. Xiong, E. Fetaya, L. Zhang, K. Yoon, X. Pitkow, R. Urtasun, and R. Zemel. Reviving and improving recurrent back-propagation. In _International Conference on Machine Learning_ , pages 3082–3091, 2018. 

- [20] C. K. Ling, F. Fang, and J. Z. Kolter. What game are we playing? End-to-end learning in normal and extensive form games. In _International Joint Conference on AI_ , 2018. 

- [21] D. Linsley, A. K. Ashok, L. N. Govindarajan, R. Liu, and T. Serre. Stable and expressive recurrent vision models, 2020. 

- [22] Y. Netzer, T. Wang, A. Coates, A. Bissacco, B. Wu, and A. Y. Ng. Reading digits in natural images with unsupervised feature learning. In _NIPS Workshop on Deep Learning and Unsupervised Feature Learning_ , 2011. 

- [23] F. J. Pineda. Generalization of back propagation to recurrent and higher order neural networks. In _Advances in Neural Information Processing Systems_ , 1988. 

- [24] A. Rajeswaran, C. Finn, S. M. Kakade, and S. Levine. Meta-learning with implicit gradients. In _Advances in Neural Information Processing Systems_ , 2019. 

- [25] M. Revay and I. R. Manchester. Contracting implicit recurrent neural networks: Stable models with improved trainability. _arXiv preprint arXiv:1912.10402_ , 2019. 

- [26] E. K. Ryu and S. Boyd. Primer on monotone operator methods. _Appl. Comput. Math_ , 15(1): 3–43, 2016. 

- [27] L. N. Smith and N. Topin. Super-convergence: Very fast training of neural networks using large learning rates. In _Artificial Intelligence and Machine Learning for Multi-Domain Operations Applications_ , volume 11006, page 1100612. International Society for Optics and Photonics, 2019. 

11 

## **A Monotone operator theory** 

We briefly review some of the basic properties of monotone operators that we make use of throughout this work. A _relation_ or _operator_ (which in our setting will often roughly correspond to a set-valued function), is a subset of the space _F ⊆_ R _[n] ×_ R _[n]_ ; we use the notation _F_ ( _x_ ) = _{y|_ ( _x, y_ ) _∈ F }_ or simply _F_ ( _x_ ) = _y_ if only a single _y_ is contained in this set. We make use of a few basic operators and relations: the identity operator _I_ = _{_ ( _x, x_ ) _|x ∈_ R _[n] }_ ; the operator sum ( _F_ + _G_ )( _x_ ) = _{_ ( _x, y_ + _z_ ) _|_ ( _x, y_ ) _∈ F,_ ( _x, z_ ) _∈ G}_ ; the inverse operator _F[−]_[1] ( _x, y_ ) = _{_ ( _y, x_ ) _|_ ( _x, y_ ) _∈ F }_ ; and the subdifferential operator _∂f_ = _{_ ( _x, ∂f_ ( _x_ )) _| ∈_ dom _f }_ . An operator _F_ has Lipschitz constant _L_ if for any ( _x, u_ ) _,_ ( _y, v_ ) _∈ F_ 

**==> picture [248 x 11] intentionally omitted <==**

An operator _F_ is monotone if 

( _u − v_ ) _[T]_ ( _x − y_ ) _≥_ 0 _, ∀_ ( _x, u_ ) _,_ ( _y, v_ ) _∈ F_ (A2) 

which for the case of _F_ being a function _F_ : R _[n] →_ R _[n]_ is equivalent to the condition 

( _F_ ( _x_ ) _− F_ ( _y_ )) _[T]_ ( _x − y_ ) _≥_ 0 _, ∀x, y ∈_ dom _F._ (A3) 

In the case of scalar-valued functions, this corresponds to our common notion of a monotonic function. The operator _F_ is strongly monotone with parameter _m_ if 

( _u − v_ ) _[T]_ ( _x − y_ ) _≥ m∥x − y∥_[2] _, ∀_ ( _x, u_ ) _,_ ( _y, v_ ) _∈ F._ (A4) 

A monotone operator _F_ is _maximal monotone_ if no other monotone operator strictly contains it; formally, most of the convergence properties we use require maximal monotonicity, though we are intentionally informal about this and merely use the established fact that several well-known operators are maximal monotone. Specifically, a linear operator _F_ ( _x_ ) = _Gx_ + _h_ for _G ∈_ R _[n][×][n]_ and _h ∈_ R _[n]_ is (maximal) monotone if and only if _G_ + _G[T] ⪰_ 0 and strongly monotone if _G_ + _G[T] ⪰ mI_ . Similarly, a subdifferentiable operator _∂f_ is maximal monotone iff _f_ is a convex closed proper (CCP) function. 

The resolvent and Cayley operators for an operator _F_ are denoted _RF_ and _CF_ and respectively 

_RF_ = ( _I_ + _αF_ ) _[−]_[1] _, CF_ = 2 _RF − I_ (A5) 

for any _α >_ 0. The resolvent and Cayley operators are non-expansive (i.e., have Lipschitz constant _L ≤_ 1) for any maximal monotone _F_ , and are contractive (i.e. _L <_ 1) for strongly monotone _F_ . 

We will mainly use two well-known properties of these operators. First, when _F_ ( _x_ ) = _Gx_ + _h_ is linear, then 

_RF_ ( _x_ ) = ( _I_ + _αG_ ) _[−]_[1] ( _x − αh_ ) (A6) 

and when _F_ = _∂f_ for some CCP function _f_ , then the resolvent is given by a proximal operator 

**==> picture [304 x 23] intentionally omitted <==**

Operator splitting approaches refer to methods to find a zero in a sum of operators (assumed here to be maximal monotone), i.e., find _x_ such that 

0 _∈_ ( _F_ + _G_ )( _x_ ) _._ (A8) 

There are many such operator splitting methods, which lead to different approaches in their application to our subsequent implicit networks, but the two we use mainly in this work are 1) _forward-backward_ splitting, given by the update 

**==> picture [258 x 12] intentionally omitted <==**

and 2) _Peaceman-Rachford_ splitting, which is given by the iteration 

_u[k]_[+1] = _CF CG_ ( _u[k]_ ) _, x[k]_ = _RG_ ( _u[k]_ ) _._ (A10) 

Both methods will converge linearly to an _x_ that is a zero of the operator sum under certain conditions: a sufficient condition for forward-backward to converge is that _F_ be strongly monotone with parameter _m_ and Lipschitz with constant _L_ and _α <_ 2 _m/L_[2] ; for Peaceman-Rachford, the method will converge for any choice of _α_ for strongly monotone _F_ , though the convergence speed will often vary substantially based upon _α_ . 

12 

## **B Proofs** 

## **B.1 Proof of Theorem 1** 

_Proof._ The proof here is immediate: the forward-backward algorithm applied to the above operators with _α_ = 1 corresponds exactly to the network’s fixed-point iteration: 

**==> picture [198 x 47] intentionally omitted <==**

## **B.2 Proof of Proposition 1** 

_Proof._ First assume _W_ is of this form. Then clearly 

**==> picture [300 x 12] intentionally omitted <==**

Alternatively, if _I − W ⪰ mI ⇐⇒_ (1 _− m_ ) _I ⪰_ ( _W_ + _W[T]_ ) _/_ 2, then 

**==> picture [273 x 12] intentionally omitted <==**

Thus 

**==> picture [152 x 29] intentionally omitted <==**

## **B.3 Proof of Theorem 2** 

_Proof._ Differentiating both sides of the fixed-point equation _z[⋆]_ = _σ_ ( _Wz[⋆]_ + _Ux_ + _b_ ) we have 

**==> picture [286 x 55] intentionally omitted <==**

for _J_ defined in (10) (we require the Clarke generalized Jacobian owing to the fact that the nonlinearity need not be a smooth function). Rearranging we get 

**==> picture [307 x 53] intentionally omitted <==**

To show that this derivative always exists, we need to show that the _I − JW_ matrix is nonsingular. Owing to the fact that proximal operators are monotone and non-expansive, we have 0 _≤ Jii ≤_ 1. First, letting _λ_ ( _·_ ) denote the set of eigenvalues of a matrix, note that 

**==> picture [271 x 13] intentionally omitted <==**

This follows from the similarity transform _λ_ ( _I − JW_ ) = _λ_ ( _J[−]_[1] _[/]_[2] ( _I − JW_ ) _J_[1] _[/]_[2] ) for _J >_ 0 and the case of _Jii_ = 0 follows via the continuity of eigenvalues taking lim _Jii →_ 0. Now, using the fact that 0 _⪯ J ⪯ I_ , we have 

**==> picture [284 x 30] intentionally omitted <==**

since _I − W ⪰ mI_ and _I − J ⪰_ 0. 

## **B.4 Proof of Theorem 3** 

_Proof._ We begin with the case where _Jii_ = 0 and thus _Dii < ∞_ . As above, because proximal operators are themselves monotone non-expansive operators, we always 0 _≤ Jii ≤_ 1, so that _Dii ≥_ 0. 

13 

Now, first assuming that _Jii >_ 0, and hence _Dii < ∞_ , we have 

**==> picture [80 x 12] intentionally omitted <==**

**==> picture [292 x 77] intentionally omitted <==**

where we define _u_ ˜ = _W[−][T] u_ . To simplify the right hand side of this equation and remove the explicit _W[−][T] v_ terms[4] we note that 

**==> picture [321 x 13] intentionally omitted <==**

Thus, we can always solve the above equation with the _v_ term of the form _W[T] Jv_ , giving 

**==> picture [282 x 12] intentionally omitted <==**

This gives us a (linear) operator splitting problem with the _F_[˜] and _G_[˜] operators given in (14). 

To handle the case where _Jii_ = 0 _⇔ Dii_ = _∞_ , we can simply take the limit _Dii →∞_ , and note that all the operators are well-defined for this case. For instance, the resolvent operator 

**==> picture [276 x 13] intentionally omitted <==**

and thus 

**==> picture [265 x 23] intentionally omitted <==**

as _Dii →∞_ . 

Finally, owing to the fact that _I − W[T] ⪰ mI_ and _Dii ≥_ 0, the _F_[˜] and _G_[˜] operators are strongly monotone and monotone respectively, we conclude that operator splitting techniques applied to the problem will be guaranteed to converge. 

## **C Convolutional monDEQs** 

## **C.1 Inversion via the discrete Fourier transform** 

First consider the case where _W ∈_ R _[s]_[2] _[×][s]_[2] is the matrix representation of an unstrided (circular) convolution with a single input channel and single output channel. The convolution operates on vectorized _s×s_ inputs. It is well known that _W_ is diagonalized by the 2D DFT operator _Fs_ = _Fs⊗Fs_ where _Fs_ is the Fourier basis matrix ( _Fs_ ) _ij_ = 1 _s[ω]_[(] _[i][−]_[1)(] _[j][−]_[1)][and] _[ω]_[=][exp(2] _[πι/s]_[)][.][We][denote] _ι_ = _[√] −_ 1 to avoid confusion with the index _i_ . So _FsW Fs[∗]_[=] _[ D,]_ (C1) 

a complex diagonal matrix. 

Now take the case where _W ∈_ R _[ns]_[2] _[×][ns]_[2] has _n_ input and output channels. Then 

**==> picture [326 x 49] intentionally omitted <==**

where _In_ is the _n × n_ identity matrix and each block _Dij ∈_ C _[s]_[2] _[×][s]_[2] is a complex diagonal matrix. We will denote _Fs,n_ = _In ⊗ Fs_ . 

> 4Although we could solve this operator splitting problem directly, the presence of the _W −T v_ term has two notable downsides: 1) even if the _W_ matrix itself is nonsingular, it may be arbitrarily close to a singular matrix, thus making direct solutions with this matrix introduce substantial numerical errors; and 2) for operator splitting methods that do _not_ require an inverse of _W_ (e.g. forward-backward splitting), it would be undesirable to require an explicit inverse in the backward pass. 

14 

It is more efficient to consider the permuted form of _D_ 

**==> picture [265 x 56] intentionally omitted <==**

where each block _D_[ˆ] _[k] ∈_ C _[n][×][n]_ , consists of the _k_ th diagonal elements of all the _Dij_ , that is _D_[ˆ] _ij[k]_[=] ( _Dij_ ) _kk_ . Then inverting or multiplying by _D_[ˆ] reduces to inverting or multiplying by the diagonal blocks, which is amenable to accelerated batch-wise computation in the form of an _s_[2] _× n × n_ tensor. However, the original form (C2) is more convenient mathematically and we use that here. 

To perform the required inversion of the operator 

**==> picture [308 x 13] intentionally omitted <==**

we use the fact that _Fs,n_ is unitary and obtain 

**==> picture [375 x 43] intentionally omitted <==**

The inner term here itself has the blockwise-diagonal form (C2). Thus, we can multiply a set of hidden units _z_ by the inverse of this matrix by considering the permuted form (C3), inverting each block _D_[ˆ] _[i]_ , taking the FFT of _z_ , multiplying each corresponding block of _Fs,nz_ by the corresponding inverse, then taking the inverse FFT. 

## **C.2 Zero padding** 

One drawback to the above method is that using the FFT in this manner requires that all convolutions be circular. While empirically there is little drawback to simply replacing traditional convolutions with their circular variants, in some cases it may be desirable to avoid this setting, where information about the image may wrap around the borders. If it is desirable to avoid this, we explicitly remove any circular dependence by zero-padding the hidden units with ( _k −_ 1) _/_ 2 border pixels, where _k_ denotes the receptive field size of the convolution. This zero padding can then be enforced by simply setting all the border entries to zero within the _nonlinearity_ of the network; because setting an element to zero is equivalent to the proximal operator for the indicator of the zero set, such operations still fit within the monotone operator setting. 

## **D Multi-tier monDEQs** 

## **D.1 Parameterization** 

Recall the setting of Section 4.3, with 

**==> picture [347 x 61] intentionally omitted <==**

To ensure _W_ has the form (1 _− m_ ) _I − A[T] A_ + _B − B[T]_ , we restrict both _A_ and _B_ to have the same bidiagonal structure as _W_ . Then the diagonal terms _Wii_ have the form 

**==> picture [311 x 14] intentionally omitted <==**

for _i < L_ and 

**==> picture [294 x 12] intentionally omitted <==**

15 

To compute the off-diagonal terms _Wi_ +1 _,i_ note that restricting _W_ to be bidiagonal makes the offdiagonal terms of _B_ redundant. E.g. since _W_ 12 = 0, then 

**==> picture [286 x 28] intentionally omitted <==**

## **D.2 Inversion via the discrete Fourier transform** 

Consider _W_ of the form (D1) with convolutions 

**==> picture [318 x 47] intentionally omitted <==**

Here the _Aii_ and _Bii_ terms are unstrided convolutions with _ni_ input and _ni_ output channels, while the _Ai,i_ +1 are strided convolutions with _ni_ input channels and _ni_ +1 output channels. 

In order to multiply by ( _I_ + _α_ ( _I − W_ )) _[−]_[1] , we use back substitution to solve for _x_ in 

**==> picture [247 x 11] intentionally omitted <==**

Let _W[′]_ = ( _I_ + _α_ ( _I − W_ )). The back substitution proceeds by tiers, i.e. 

**==> picture [252 x 64] intentionally omitted <==**

Therefore only the diagonal blocks _Wii[′]_[need be inverted.][The inversion of e.g.] 

_W_ 11 _[′]_[= (1 +] _[ αm]_[)] _[I]_[+] _[ α]_[(] _[A][T]_ 11 _[A]_[11][+] _[ A][T]_ 21 _[A]_[21][+] _[ B]_[11] _[−][B]_ 11 _[T]_[)] (D8) is complicated by the fact that _A_ 21 is strided, so that it is no longer diagonalized by the DFT. Instead, we perform inversion using the following proposition. 

**Proposition D1.** _Let A ∈_ R _[n]_[1] _[s]_[2] _[×][n]_[1] _[s]_[2] _be an unstrided circular convolution with n_ 1 _input and n_ 1 _output channels, and B ∈_ R _[n]_[2] _[s]_[2] _[×][n]_[1] _[s]_[2] _a strided circular convolution with n_ 1 _input and n_ 2 _output channels and stride r where r divides s. Then_ 

( _A_ + _B[T] B_ ) _[−]_[1] = _Fs,n[∗]_ 1[(] _[D] A[−]_[1] _[−][D] A[−]_[1] _[D] B[∗]_[(] _[I][n]_ 2 _[⊗][K]_[)] _[D][B][D] A[−]_[1][)] _[F][s,n]_ 1 (D9) 

_where_ 

**==> picture [303 x 28] intentionally omitted <==**

_where J_ = 1 _r_ 2 _⊗ Is_ 2 _/r_ 2 _is r_[2] _stacked identity matrices of size_ ( _s_[2] _/r_[2] ) _×_ ( _s_[2] _/r_[2] ) _and S_ = ( _Ir ⊗ Ss/r,s_ ) _is a permutation matrix where Sa,b ∈_ R _[ab][×][ab] denotes the perfect shuffle matrix defined by subselecting rows of the identity matrix Iab, here given in_ MATLAB _notation:_ 

**==> picture [259 x 51] intentionally omitted <==**

_Proof._ We will show that 

**==> picture [335 x 21] intentionally omitted <==**

The desired result then follows by applying the Woodbury matrix idenetity. 

We start by breaking _B_ into an unstrided convolution _B[′]_ which can be diagonalized by the DFT and a matrix _Ur,s_ which performs the striding on each channel: 

**==> picture [304 x 13] intentionally omitted <==**

16 

where _Ur,s ∈_ R[(] _[s]_[2] _[/r]_[2][)] _[×][s]_[2] is defined by subselecting rows of the identity matrix: 

**==> picture [304 x 62] intentionally omitted <==**

So 

_B[T] B_ = _Fs,n[∗]_ 1 _[D] B[∗]_[(] _[I][n]_ 2 _[⊗]_[(] _[F][s][U] r,s[ T][U][r,s][F][ ∗] s_[))] _[D][B][F][s,n]_ 1 _[.]_ (D15) We want to show that _FsUr,s[T][U][r,s][F][ ∗] s_[=] _s_[2] 1 _r_[2] _[S][T][ JJ][T][ S]_[.][Observe that] _Ur,s[T][U][r,s]_[= (] _[T][r,s][⊗][T][r,s]_[)] (D16) 

where _Tr,s ∈_ R _[s][×][s]_ is given by 

**==> picture [287 x 25] intentionally omitted <==**

Then by the properties of Kronecker product 

**==> picture [378 x 14] intentionally omitted <==**

We now show that ( _FsTr,sFs[∗]_[) =] _[ L]_[ where] 

**==> picture [265 x 25] intentionally omitted <==**

To do so we use several properties of the roots of unity _z[k]_ = exp(2 _πιk/s_ ). 

1. If _a ≡ b_ (mod _s_ ) then _z[a]_ = _z[b]_ . 

2. If _z_ is a primitive _s_ th root of unity then _z[m]_ is a primitive _a_ th root of unity where _a_ = gcd( _sm,s_ )[.] 

3. The sum of the _s_ th roots of unity[�] _[s] k[−]_ =0[1] _[z][k]_[= 0][ if] _[ s >]_[ 1][.] 

We first compute _Lij_ for the case when _i ≡ j_ (mod _s/r_ ), or in other words _i_ = _j_ + _[ks] r_[for some] integer _k_ . We have 

**==> picture [280 x 153] intentionally omitted <==**

17 

For the case when _i ̸≡ j_ (mod _s/r_ ), or in other words _i_ = _j_ + _[ks] r_[+] _[ m]_[ for some integers] _[ k]_[ and] _[ m]_ with _− r[s][< m <] r[s]_[, we have] 

**==> picture [287 x 134] intentionally omitted <==**

By property (2), since exp(2 _πιr/s_ ) is a primitive _r[s]_[th root of unity, then][ exp(2] _[πιmr/s]_[)][ is a primitive] _s/r d_ th root of unity where _d_ = gcd( _m,s/r_ )[.][Since] _[ d]_[ divides] _[ s/r]_[, we can split the sum into several sums] of _d_ th roots of unity using property (1), each of which will sum to zero by property (3). 

**==> picture [285 x 119] intentionally omitted <==**

where the second equality follows from property (1) since _p_ = _p_ + _qd_ (mod _d_ ) and each sum in the third line is zero by property (3) since exp(2 _πιmr/s_ ) is a primitive _d_ th root of unity. 

We now have _FsUr,s[T][U][r,s][F][ ∗] s_[=] _[ L][ ⊗][L]_[ and it remains to use properties of Kronecker product to show] that _L ⊗ L_ = _s_[2] 1 _r_[2] _[S][T][ JJ][T][ S]_[.][In particular we need associativity and the fact that for] _[ A][ ∈]_[R] _[n][×][n]_[and] _B ∈_ R _[m][×][m]_ , we have 

_B ⊗ A_ = _Sn,m_ ( _A ⊗ B_ ) _Sn,m[T]_ (D23) where _Sn,m_ is the perfect shuffle matrix. Note that _L_ = _sr_ 1[1] _[r][×][r][⊗][I][s/r]_[where][1] _[r][×][r]_[is][the] _[r][ ×][ r]_ matrix of all ones. Then 

**==> picture [319 x 141] intentionally omitted <==**

which completes the proof. 

18 

|||**CIFAR-10**|**CIFAR-10**||
|---|---|---|---|---|
||Single conv|Multi-tier|Single conv lg.|Multi-tier lg.|
|Num. channels|81|(16,32,60)|200|(64,128,128)|
|Num. params|172,218|170,194|853,612|1,014,546|
|Epochs|40|40|65|65|
|Initial lr|0.001|0.01|0.001|0.001|
|Lr schedule|step decay|step decay|1-cycle|1-cycle|
|Lr decay steps|25|10|-|-|
|Lr decay factor|10|10|-|-|
|Max learning rate|-|-|0.01|0.05|
|Data augmentation|-|-|✓|✓|



|**SVHN**<br>**MNIST**|**SVHN**<br>**MNIST**|
|---|---|
|||
|Single conv<br>Multi-tier|FC<br>Single conv<br>Multi-tier|
|||
|Num. channels<br>81<br>(16,32,60)<br>Num. params<br>172,218<br>170,194<br>Initial lr<br>0.001<br>0.001<br>Epochs<br>40<br>40<br>Lr decay steps<br>25<br>10<br>Lr decay factor %<br>10<br>10|87*<br>54<br>(16, 32, 32)<br>84,313<br>84,460<br>81,394<br>0.001<br>0.001<br>0.001<br>40<br>40<br>40<br>10<br>10<br>10<br>10<br>10<br>10|



Table E1: Model hyperparameters. *FC is a dense layer with output dimension of 87. 

## **E Experiment details** 

## **E.1 Model architecture** 

Recall that a monDEQ is defined by a choice of linear operators _W_ and _U_ , bias _b_ , and nonlinearity _σ_ , and that we parameterize _W_ via linear operators _A_ and _B_ . For all experiments we use _σ_ = ReLU. In the fully-connected network _A, B_ and _U_ are dense matrices; in the single-convolution network they are unstrided convolutions with kernel size 3. The structure of the multi-tier network is as described in (D1) and (D5); we use three tiers with unstrided convolutions for _U_ and _Aii, Bii_ and stride-2 convolutions for the subdiagonal terms _Ai,i_ +1, all with kernels of size 3. The number of channels for single and multi-tier convolutional models varies by dataset, as shown in Table E1. 

For all models, the fixed point _z[⋆]_ is mapped to logits _y_ ˆ via a dense output layer, and the single convolution model first applies 4 _×_ 4 average pooling: 

ˆ ˆ _y_ = _Woz[⋆]_ + _bo_ or _y_ = _Wo_ AvgPool4 _×_ 4( _z[⋆]_ ) + _bo._ 

## **E.2 Training details** 

Because _W_ = (1 _− m_ ) _I − A[T] A_ + _B − B[T]_ contains both linear and quadratic terms, we find that a variant of weight normalization helps to keep the gradients of the different parameters on the same scale. For example, when _W_ is a dense matrix, we reparameterize _A[T] A_ as _g ∥[A] A[T] ∥[ A]_[2][and] _[ B]_[ as] _[ h] ∥[B] B∥_[,] where _g_ and _h_ are learned scalars. When _W_ consists of a single or multi-tiered convolutions, we reparameterize each convolution kernel analogously. 

All models are trained by running Peaceman-Rachford with error tolerence _ϵ_ =1e-2, which reduces the number of iterations without impacting performance. The monotonicity parameter _m_ also affects convergence speed since it controls the contraction factor of the relevant operators; consistent with this, we find that Peaceman-Rachford takes longer to converge for smaller _m_ , and use _m_ = 1 for all models since model performance is not sensitive to _m ∈_ [0 _._ 01 _,_ 1]. We also find that the Lipschitz parameter _L_ of _I − W_ increases during training, changing the optimal _α_ value. We therefore tune _α ∈{_ 1 _,_ 1 _/_ 2 _,_ 1 _/_ 4 _, . . .}_ over the course of training so as to minimize forward-pass iterations. 

One detail about stopping criteria for the splitting method: computing the residual _∥z[k]_[+1] _− f_ ( _z[k]_[+1] ) _∥/∥z[k]_[+1] _∥_ requires an additional call to the function _f_ . Therefore during training we instead use the criterion _∥z[k]_[+1] _− z[k] ∥/∥z[k]_[+1] _∥≤ ϵ_ . The error shown in Figure 3 is the former, while the stopping criterion used in Figures 2 and F2 is the latter. Technically this latter criterion itself depends on both _α_ and _L_ ; for different _α_ and _L_ values, having _∥z[k]_[+1] _− z[k] ∥/∥z[k]_[+1] _∥≤ ϵ_ implies different bounds on the residual. However, we find that this effect is minimal, so that both stopping criteria work equally well in practice. 

19 

||**Train examples**|**Test examples**|**Image**|**dim.**|**Num. channels**|
|---|---|---|---|---|---|
|MNIST|60,000|10,000|28|_×_28|1|
|SVHN|73,257|26,032|32|_×_32|3|
|CIFAR-10|50,000|10,000|32|_×_32|3|



Table E2: Dataset statistics 

Table E1 gives details of the training hyperparameters used for each model. All models are trained with ADAM [16], using batch size of 128. For all but the large CIFAR-10 models, the initial learning rate is chosen from {1e-2, 1e-3} and decayed by a factor of 10 after every 10 or 25 epochs, and the default ADAM momentum parameters are used. All training data is normalized to mean _µ_ = 0, standard deviation _σ_ = 1. 

**CIFAR-10 with data augmentation** When training large models on CIFAR-10 we use standard data augmentation, consisting of zero-padding the 32 _×_ 32 images to 40 _×_ 40, then randomly cropping back to 32x32, and finally performing random horizontal flips. In order to reduce the number of training epochs, we use a single cycle of increasing and decreasing learning rate to achieve superconvergence [27]. The learning rate is increased from 1e-3 to the max learning rate (see Table E1) over 30 epochs, then decreased back to 1e-3 over 30 epochs, then held at 1e-3 for 5 epochs. (The max learning rate is chosen by training for a single epoch while increasing the learning rate until the loss diverges.) The momentum is also decreased from 0.95 to 0.85 over 30 epochs, then back to 0.95 over 30 epochs, then held at 0.95 for 5 epochs. However, we note that the model obtains the same performance when trained with constant learning rate of 1e-3 for around 200 epochs. 

## **E.3 Dataset statistics** 

MNIST [18] consists of black and white examples of handwritten digits 0-9. SVHN [22] consists of color images of digits 0-9 extracted from house numbers captured by Google Stree View. CIFAR-10 [17] consists of small images from 10 object classes. Dataset statistics are shown in Table E2. 

20 

## **F Additional results and figures** 

**==> picture [414 x 304] intentionally omitted <==**

**----- Start of picture text -----**<br>
SVHN CIFAR-10 + data augmentation<br>90<br>90<br>80<br>70<br>80<br>60 Single conv lg.<br>Multi-tier lg.<br>50<br>70 Single conv NODE lg.<br>Multi-tier 40 ANODE lg.<br>1 10 20 30 40 1 20 40 60<br>Epochs Epochs<br>MNIST<br>99<br>98<br>97<br>96 Single conv<br>Multi-tier<br>95 Fully connected<br>1 10 20 30 40<br>Epochs<br>% Test accuracy<br>% Test accuracy<br>**----- End of picture text -----**<br>


Figure F1: Test accuracy of monDEQs and Neural ODE models during training. 

**==> picture [97 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
Backward-pass iterations<br>**----- End of picture text -----**<br>


**==> picture [195 x 133] intentionally omitted <==**

**----- Start of picture text -----**<br>
50<br>® = 1<br>® tuned<br>40<br>30<br>20<br>10<br>0 20 40 60<br>Epochs<br>Iterations<br>**----- End of picture text -----**<br>


Figure F2: Iterations required by Peaceman-Rachford backprop over the course of training. 

21 

