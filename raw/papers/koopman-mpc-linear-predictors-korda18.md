---
title: "Linear predictors for nonlinear dynamical systems: Koopman operator meets model predictive control"
arxiv: "1611.03537"
authors: [Milan Korda, Igor Mezić]
year: 2018
source: paper
ingested: 2026-05-14
sha256: d4968e804b2fbab2ce98c0340687c45858e40e9019eeb5d9844fcaec3c6399d8
conversion: pymupdf4llm
---

# **Linear predictors for nonlinear dynamical systems: Koopman operator meets model predictive control** 

Milan Korda[1] , Igor Mezi´c[1] 

Draft of March 26, 2018 

## **Abstract** 

This paper presents a class of linear predictors for nonlinear controlled dynamical systems. The basic idea is to lift (or embed) the nonlinear dynamics into a higher dimensional space where its evolution is approximately linear. In an uncontrolled setting, this procedure amounts to numerical approximations of the Koopman operator associated to the nonlinear dynamics. In this work, we extend the Koopman operator to controlled dynamical systems and apply the Extended Dynamic Mode Decomposition (EDMD) to compute a finite-dimensional approximation of the operator in such a way that this approximation has the form of a linear controlled dynamical system. In numerical examples, the linear predictors obtained in this way exhibit a performance superior to existing linear predictors such as those based on local linearization or the so called Carleman linearization. Importantly, the procedure to construct these linear predictors is completely data-driven and extremely simple – it boils down to a nonlinear transformation of the data (the lifting) and a linear least squares problem in the lifted space that can be readily solved for large data sets. These linear predictors can be readily used to design controllers for the nonlinear dynamical system using linear controller design methodologies. We focus in particular on model predictive control (MPC) and show that MPC controllers designed in this way enjoy computational complexity of the underlying optimization problem comparable to that of MPC for a linear dynamical system with the same number of control inputs and the same dimension of the state-space. Importantly, linear inequality constraints on the state and control inputs as well as nonlinear constraints on the state can be imposed in a linear fashion in the proposed MPC scheme. Similarly, cost functions nonlinear in the state variable can be handled in a linear fashion. We treat both the full-state measurement case and the input-output case, as well as systems with disturbances / noise. Numerical examples (including a high-dimensional nonlinear PDE control) demonstrate the approach with the source code available online[2] . 

**Keywords:** Koopman operator, Model predictive control, Data-driven control design, Optimal control, Lifting, Embedding. 

> 1Milan Korda and Igor Mezi´c are with the University of California, Santa Barbara, `milan.korda@engineering.ucsb.edu, mezic@engineering.ucsb.edu` 

> 2Code download: `https://github.com/MilanKorda/KoopmanMPC/raw/master/KoopmanMPC.zip` 

1 

## **1 Introduction** 

This paper presents a class of linear predictors for nonlinear controlled dynamical systems. By a predictor, we mean an artificial dynamical system that can predict the future state (or output) of a given nonlinear dynamical system based on the measurement of the current state (or output) and current and future inputs of the system. We focus on predictors possessing a _linear_ structure that allows established linear control design methodologies to be used to design controllers for nonlinear dynamical systems. 

The key step in obtaining accurate predictions of a nonlinear dynamical system as the output of a linear dynamical system is _lifting_ of the state-space to a higher dimensional space, where the evolution of this lifted state is (approximately) linear. For uncontrolled dynamical systems, this idea can be rigorously justified using the Koopman operator theory [15, 16]. The Koopman operator is a _linear_ operator that governs the evolution of scalar functions (often referred to as observables) along trajectories of a given nonlinear dynamical system. A finite-dimensional approximation of this operator, acting on a given finite-dimensional subspace of all functions, can be viewed as a predictor of the evolution of the values of these functions along the trajectories of the nonlinear dynamical system and hence also as a predictor of the values of the state variables themselves provided that they lie in the subspace of functions the operator is truncated on. In the uncontrolled context, the idea of representing a nonlinear dynamical system by an infinite-dimensional linear operator goes back to the seminal works of Koopman, Carleman and Von Neumann [9, 4, 10]. The potential usefulness of such linear representations for prediction and control was suggested in [16]. 

In this work, we extend the definition of the Koopman operator to controlled dynamical systems by viewing the controlled dynamical system as an uncontrolled one evolving on an extended state-space given by the product of the original state-space and the space of all control sequences. Subsequently, we use a modified version of the Extended Dynamic Mode Decomposition (EDMD) [25] to compute a finite-dimensional approximation of this controlled Koopman operator. In particular, we impose a specific structure on the set of observables appearing in the EDMD such that the resulting approximation of the operator has the form of a linear controlled dynamical system. Importantly, the procedure to construct these linear predictors is completely data-driven (i.e., does not require the knowledge of the – underlying dynamics) and extremely simple it boils down to a nonlinear transformation of the data (the lifting) and a linear least squares problem in the lifted space that can readily solved for large data sets using linear algebra. On the numerical examples tested, the linear predictors obtained in this way exhibit a predictive performance superior compared to both Carleman linearization as well as local linearization methods. For a related work on extending Koopman operator methods to controlled dynamical systems, see [2, 18, 19, 24]. See also [22, 21] and [13] for the use of Koopman operator methods for state estimation and nonlinear system identification, respectively. 

Finally, we demonstrate in detail the use of these predictors for model predictive control (MPC) design; see the survey [14] or the book [7] for an overview of MPC. In particular, we show that these predictors can be used to design MPC controllers for _nonlinear_ dynamical systems with computational complexity comparable to MPC controllers for _linear_ dynamical systems with the same number of control inputs and states. Indeed, the resulting MPC 

2 

scheme is extremely simple: In each time step of closed-loop operation it involves one evaluation of a family of nonlinear functions (the lifting) to obtain the initial condition of the linear predictor and the solution of a _convex_ quadratic program affinely parametrized by this lifted initial condition. Importantly, nonlinear cost functions and constraints can be handled in a linear fashion by including all nonlinear terms appearing in these functions among the lifting functions. Therefore, the proposed scheme can be readily used for predictive control of nonlinear dynamical systems, using the tailored and extremely efficient solvers for linear MPC (in our case qpOASES [6]), thereby avoiding the troublesome and computationally expensive solution of nonconvex optimization problems encountered in classical nonlinear MPC schemes [7]. 

The paper is organized as follows: In Section 2 we describe the problem setup and the basic idea behind the use of linear predictors for nonlinear dynamical systems. In Section 3 we derive these linear predictors as finite-dimensional approximations to the Koopman operator extended to nonlinear dynamical systems. In Section 4 we describe a numerical algorithm for obtaining these linear predictors. In Section 5 we describe the use of these predictors for model predictive control. In Section 7 we discuss extensions of the approach to input output systems (Section 7.1) and to systems with disturbances / noise (Section 7.2). In Section 8 we present numerical examples. 

## **– 2 Linear predictors basic idea** 

We consider a discrete-time nonlinear controlled dynamical system 

**==> picture [269 x 14] intentionally omitted <==**

where _x ∈_ R _[n]_ is the state of the system, _u ∈U ⊂_ R _[m]_ the control input, _x_[+] is the successor state and _f_ the transition mapping. The input-output case is treated in Section 7.1. 

The focus of this paper is the prediction of the trajectory of (1) given an initial condition _x_ 0 and the control inputs _{u_ 0 _, u_ 1 _, . . .}_ . In particular, we are looking for simple predictors possessing a linear structure which are suitable for linear control design methodologies such as model predictive control (MPC) [14]. 

The predictors investigated are assumed to be of the form of a controlled _linear_ dynamical system 

**==> picture [274 x 30] intentionally omitted <==**

where _z ∈_ R _[N]_ with (typically) _N ≫ n_ and ˆ _x_ is the prediction of _x_ , _B ∈_ R _[N][×][m]_ and _C ∈_ R _[n][×][N]_ . The initial condition of the predictor (2) is given by 

**==> picture [301 x 51] intentionally omitted <==**

where _x_ 0 is the initial condition of (1) and _ψi_ : R _[n] →_ R, _i_ = 1 _, . . . , N_ , are user-specified (typically nonlinear) lifting functions. The state _z_ is referred to as the _lifted state_ since it 

3 

evolves on a higher-dimensional, lifted, space[3] . Importantly, the control input _u ∈U_ of (2) remains _unlifted_ and hence linear constraints on the control inputs can be imposed in a linear fashion. Notice also that the predicted state _x_ ˆ is a _linear_ function of the lifted state _z_ and hence also linear constraints on the state can be readily imposed. Figure (1) depicts this idea. 

**==> picture [398 x 104] intentionally omitted <==**

**----- Start of picture text -----**<br>
z [+] =  Az  +  Bu H∞<br>z 0 =  ψ ( x 0)<br>⇒ ˆ MPC<br>x  =  Cz<br>x [+] =  f ( x, u )<br>x 0 given dim( z )  ≫ dim( x ) LQR<br>Nonlinear system Linear predictor Linear control design<br>**----- End of picture text -----**<br>


Figure 1: Linear predictor for a nonlinear controlled dynamical system – _z_ is the lifted state evolving on a higher-dimensional state space, _x_ ˆ is the prediction of the true state _x_ and _**ψ**_ is a nonlinear lifting mapping. This predictor can then be used for control design using linear methods, in our case linear MPC. 

Predictors of this form lend themselves immediately to linear feedback control design methodologies. Importantly, however, the resulting feedback controller will be nonlinear in the original state _x_ even though it may be (but is not required to be) linear in the lifted state _z_ . Indeed, from any feedback controller _κ_ lift : R _[N] →_ R _[m]_ for (2), we obtain a feedback controller _κ_ : R _[n] →_ R _[m]_ for the original system (1) defined by 

**==> picture [284 x 13] intentionally omitted <==**

The idea is that if the true trajectory of _x_ generated by (1) and the predicted trajectory of ˆ _x_ generated by (2) are close for each admissible input sequence, then the optimal controller for (2) should be close to the optimal controller for (1). In Section 3 we will see how the linear predictors (2) can be derived within the Koopman operator framework extended to controlled dynamical systems. 

Note, however, that in general one cannot hope that a trajectory of a linear system (2) will be an accurate prediction of the trajectory of a nonlinear system for all future times. Nevertheless, if the predictions are accurate on a long enough time interval, these predictors can facilitate the use of linear control systems design methodologies. Especially suited for this purpose is model predictive control (MPC) that uses only _finite-time predictions_ to generate the control input. 

We will briefly mention in Section 3.2.2 how more complex, bi-linear, predictors of the form 

**==> picture [281 x 28] intentionally omitted <==**

> 3In general, the term “lifted state” may be misleading as, in principle, the same approach can be applied to dynamical systems with states evolving on a (possibly infinite-dimensional) space _M_ , with finitely many observations (or outputs) _**h**_ ( _x_ ) = [ _h_ 1( _x_ ) _, . . . , hp_ ( _x_ )] _[⊤]_ available at each time instance; the lifting is then applied to these output measurements (and possibly their time-delayed versions), i.e., _ψi_ ( _x_ ) in (19) becomes _ψi_ ( _**h**_ ( _x_ )) for some functions _ψi_ : R _[p] →_ R. In other words, rather than the state itself we lift the output of the dynamical system. For a detailed treatment of the input-output case, see Section 7.1. 

4 

can be obtained within the same framework and argue that predictors of this form can be asymptotically tight (in a well defined sense). Nevertheless, predictors of the from (5) are not immediately suited for linear control design and hence in this paper we focus on the linear predictors (2). 

## **– 3 Koopman operator rationale behind the approach** 

We start by recalling the Koopman operator approach for the analysis of an _uncontrolled_ dynamical system 

**==> picture [263 x 13] intentionally omitted <==**

The Koopman operator _K_ : _F →F_ is defined by 

**==> picture [284 x 13] intentionally omitted <==**

for every _ψ_ : R _[n] →_ R belonging to _F_ , which is a space of functions (often referred to as observables) invariant under the action of the Koopman operator. Importantly, the Koopman operator is _linear_ (but typically infinite-dimensional) even if the underlying dynamical system is nonlinear. Crucially, this operator fully captures all properties of the underlying dynamical system provided that the space of observables _F_ contains the components of the state _xi_ , i.e, the mappings _x �→ xi_ belong to _F_ for all _i ∈{_ 1 _, . . . , n}_ . For a detailed survey on Koopman operator and its applications, see [3]. 

## **3.1 Koopman operator for controlled systems** 

There are several ways of generalizing the Koopman operator to controlled systems; see, e.g., [19, 24]. In this paper we present a generalization that is both rigorous and practical. We define the Koopman operator associated to the controlled dynamical system (1) as the Koopman operator associated to the uncontrolled dynamical system evolving on the extended state-space defined as the product of the original state-space and the space of all control sequences, i.e., in our case R _[n] × ℓ_ ( _U_ ), where _ℓ_ ( _U_ ) is the space of all sequences ( _ui_ ) _[∞] i_ =0[with] _ui ∈U_ . Elements of _ℓ_ ( _U_ ) will be denoted by _**u**_ := ( _ui_ ) _[∞] i_ =0[.][The][dynamics][of][the][extended] state 

**==> picture [50 x 29] intentionally omitted <==**

is described by 

**==> picture [307 x 30] intentionally omitted <==**

where _S_ is the left shift operator, i.e. ( _S_ _**u**_ )( _i_ ) = _**u**_ ( _i_ + 1), and _**u**_ ( _i_ ) denotes the _i_[th] element of the sequence _**u**_ . 

The Koopman operator _K_ : _H →H_ associated to (8) is defined by 

**==> picture [285 x 13] intentionally omitted <==**

for each _φ_ : R _[n] × ℓ_ ( _U_ ) _→_ R belonging to some space of observables _H_ . 

5 

The Koopman operator (9) is a linear operator fully describing the non-linear dynamical system (1) provided that _H_ contains the components of the non-extended state[4] _xi_ , _i_ = 1 _, . . . , n_ . For example, spectral properties of the operator _K_ should provide information on spectral properties of the nonlinear dynamical system (1). 

## **3.2 EDMD for controlled systems** 

In this paper, however, we are not interested in spectral properties but rather in timedomain prediction of trajectories of (1). To this end, we construct a finite-dimensional approximation to the operator _K_ which will yield a predictor of the form (2). In order to do so, we adapt the extended dynamic mode decomposition algorithm (EDMD) of [25] to the controlled setting. The EDMD is a data-driven algorithm to construct finite-dimensional approximations to the Koopman operator. The algorithm assumes that a collection of data ( _χj, χ_[+] _j_[),] _[ j]_[= 1] _[, . . . , K]_[satisfying] _[ χ]_[+] _j_[=] _[ F]_[(] _[χ][j]_[) is available and seeks a matrix] _[ A]_[ (the transpose] of the finite-dimensional approximation of _K_ ) minimizing 

**==> picture [298 x 37] intentionally omitted <==**

where 

**==> picture [156 x 18] intentionally omitted <==**

is a vector of lifting functions (or observables) _φi_ : R _[n] × ℓ_ ( _U_ ) _→_ R, _i ∈{_ 1 _, . . . , Nφ}_ . Note that _χ_ = ( _x,_ _**u**_ ) is in general an infinite-dimensional object and hence the objective (10) cannot be evaluated in a finite time unless _φi_ ’s are chosen in a special way. 

## **3.2.1 Linear predictors** 

In order to obtain a linear predictor (2) and a computable objective function in (10) we impose that the functions _φi_ are of the form 

**==> picture [299 x 13] intentionally omitted <==**

where _ψi_ : R _[n] →_ R is in general nonlinear but _Li_ : _ℓ_ ( _U_ ) _→_ R is linear. Without loss of generality (by linearity and causality) we can assume that _Nφ_ = _N_ + _m_ for some _N >_ 0 and that the vector of lifting functions _**φ**_ = [ _φ_ 1 _, . . . , φNφ_ ] _[⊤]_ is of the form 

**==> picture [283 x 29] intentionally omitted <==**

where _**ψ**_ = [ _ψ_ 1 _, . . . ψN_ ] _[⊤]_ and _**u**_ (0) _∈_ R _[m]_ denotes the first component of the sequence _**u**_ . Since we are not interested in predicting future values of the control sequence, we can disregard the last _m_ components of each term _**φ**_ ( _χ_[+] _j_[)] _[ −A]_ _**[φ]**_[(] _[χ][j]_[)][in][(10).][Denoting] _A_[¯] the first _N_ rows 

> 4Note that the definition of the Koopman operator implicitly assumes that _H_ is invariant under the action of _K_ and hence, in the controlled setting, _H_ will typically automatically contain also functions depending on _**u**_ . 

6 

of _A_ and decomposing this matrix such that _A_[¯] = [ _A, B_ ] with _A ∈_ R _[N][×][N]_ , _B ∈_ R _[N][×][m]_ and using the notation _χj_ = ( _xj,_ _**u** j_ ) in (10), leads to the minimization problem 

**==> picture [336 x 36] intentionally omitted <==**

Minimizing (13) over _A_ and _B_ leads to the predictor of the form (2) starting from the initial condition 

**==> picture [301 x 51] intentionally omitted <==**

The matrix _C_ is obtained simply as the best projection of _x_ onto the span of _ψi_ ’s in a least squares sense, i.e., as the solution to 

**==> picture [300 x 37] intentionally omitted <==**

We emphasize that (13) and (15) are linear least squares problem that can be readily solved using linear algebra. 

**Remark 1** _Note that the solution to (15) is trivial if the set of lifting functions {ψ_ 1 _, . . . , ψN } contains the state observable, i.e., if, after possible reordering, ψi_ ( _x_ ) = _xi for all i ∈ {_ 1 _, . . . , n}. In this case, the solution to (15) is C_ = [ _I,_ 0] _, where I is the identity matrix of size n._ 

The resulting algorithm for constructing the linear predictor (2) is concisely summarized in Section 4. 

## **3.2.2 Bilinear predictors** 

Predictors with a more complex structure can be obtained by imposing a structure on the functions _φi_ different than the linear structure (11). In particular, bilinear predictors of the form (5) can be obtained by requiring that 

**==> picture [151 x 13] intentionally omitted <==**

for some nonlinear functions _ψi_ , _ξi_ and linear operators _Li_ . 

A bilinear predictor of the form (5) can be tight (in the sense of convergence of predicted trajectories to the true ones as the number of basis functions tends to infinity) under the assumption that the discrete-time mapping (1) comes from a discretization of a continuoustime system and the discretization interval tends to zero and the underlying continuoustime dynamics is input-affine; see Section IV-C of [21] for more details. This bilinearity phenomenon is well known from the classical Carleman linearization in continuous time [4]. In this work, however, we focus on linear predictors since they are immediately amenable to the range of mature linear control design techniques. The use of bilinear predictors for controller design is left for further investigation. 

7 

## **– 4 Numerical algorithm Finding** _A_ **,** _B_ **,** _C_ 

We assume that a set of data 

**==> picture [378 x 15] intentionally omitted <==**

satisfying the relation _yi_ = _f_ ( _xi, ui_ ) is available. Note that we do not assume any temporal ordering of the data. In particular, the data is not required to come from one trajectory of (1). 

Given the data **X** , **Y** , **U** in (16), the matrices _A ∈_ R _[N][×][N]_ and _B ∈_ R _[N][×][m]_ in (2) are obtained as the best linear one-step predictor in the lifted space in a least-squares sense, i.e., they are obtained as the solution to the optimization problem 

**==> picture [307 x 19] intentionally omitted <==**

where 

**==> picture [380 x 16] intentionally omitted <==**

with 

**==> picture [281 x 51] intentionally omitted <==**

being a given basis (or dictionary) of nonlinear functions. The symbol _∥· ∥F_ denotes the Frobenius norm of a matrix. The matrix _C ∈_ R _[n][×][N]_ is obtained as the best linear leastsquares estimate of **X** given **X** lift, i.e., the solution to 

**==> picture [285 x 17] intentionally omitted <==**

The analytical solution to (17) is 

**==> picture [294 x 14] intentionally omitted <==**

where _[†]_ denotes the Moore-Penrose pseudoinverse of a matrix. The analytical solution to (20) is 

**==> picture [61 x 16] intentionally omitted <==**

Notice the close relation of the resulting algorithm to the DMD with control proposed in [18]. There, however, no lifting is applied and the the least squares fit (17) is carried out on the original data, limiting the predictive power. 

## **4.1 Practical considerations** 

The analytical solution (21) is not the preferred method of solving the least-squares problem (17) in practice. In particular, for larger data sets with _K ≫ N_ it is beneficial to solve instead the normal equations associated to (17). The normal equations read 

**==> picture [261 x 13] intentionally omitted <==**

8 

with variable _M_ = [ _A, B_ ] and data 

**==> picture [222 x 32] intentionally omitted <==**

Any solution to (22) is a solution to (17). Importantly, the size of the matrices **G** and **V** is ( _N_ + _m_ ) _×_ ( _N_ + _m_ ) respectively _N ×_ ( _N_ + _m_ ) and hence independent of the number of samples _K_ in the data set (16). The same considerations hold for the least-squares problem (20). Note that, in practice, the lifting functions _ψi_ will typically contain the state itself in which case the solution to (20) is just the selection of appropriate indices of **X** lift, i.e., after possible reordering, _C_ = [ _I,_ 0]. 

If lifting to a very high dimensional space is required, it may be worth exploring the so called kernel methods known from machine learning which do not require an explicit evaluation of the lifting mapping _**ψ**_ . These methods were successfully applied to the standard EDMD algorithm in [26], leading to substantial computational savings. 

## **5 Model predictive control** 

In this section we describe how the linear predictor (2) can be used to design an MPC controller for the nonlinear system (1) with computational complexity comparable to that of an MPC controller for a _linear_ system of the same state-space dimension and number of control inputs. We recall that MPC is a control strategy where the control input at each time step of the closed-loop operation is obtained by solving an optimization problem where a userspecified cost function (e.g., the energy or tracking error) is minimized along a prediction horizon subject to constraints on the control inputs and state variables. Traditionally, linear MPC solves a convex quadratic program, thereby allowing for an extremely fast evaluation of the control input. Nonlinear MPC, on the other hand, solves a difficult non-convex optimization problem, thereby requiring far more computational resources and/or relying on local solutions only; see, e.g., [7] for an overview of nonlinear MPC. Just as linear MPC, the lifting-based MPC for nonlinear systems developed here relies on _convex_ quadratic programming, thereby avoiding all issues associated with non-convex optimization and allowing for an extremely fast evaluation of the control input. We first describe the proposed MPC controller in its most general form and subsequently, in Section 5.2, describe how a traditional nonlinear MPC problem translates to the proposed one. 

The proposed model predictive controller solves at each time instance _k_ of the closed-loop operation the optimization problem 

**==> picture [366 x 81] intentionally omitted <==**

9 

where _Np_ is the prediction horizon and the _convex_ quadratic cost function _J_ is given by 

**==> picture [418 x 37] intentionally omitted <==**

with _Qi ∈_ R _[N][×][N]_ and _Ri ∈_ R _[m][×][m]_ positive semidefinite. The matrices _Ei ∈_ R _[n][c][×][N]_ and _Fi ∈_ R _[n][c][×][m]_ and the vector _bi ∈_ R _[n][c]_ define state and input polyhedral constraints. The optimization problem (23) is parametrized by the current state of the nonlinear dynamical system _xk_ . This optimization problems defines a feedback controller 

**==> picture [80 x 14] intentionally omitted <==**

where _u[⋆]_[denotes][an][optimal][solution][to][problem][(23)][parametrized][by][the][current] 0[(] _[x][k]_[)] state _xk_ . 

Several observations are in order: 

1. The optimization problem (23) is a _convex_ quadratic programming problem (QP). 

2. At each time step _k_ , the predictions are initialized from the lifted state _**ψ**_ ( _xk_ ). 

3. Nonlinear functions of the original state _x_ can be penalized in the cost function and included among the constraints by including these nonlinear functions among the lifting functions _ψi_ . For example, if one wished for some reason to minimize _Np−_ 1 

� _i_ =0 cos( _∥xi∥∞_ ), one could simply set _ψ_ 1 = cos( _∥x∥∞_ ) and _q_ = [1 _,_ 0 _,_ 0 _, . . . ,_ 0] _[⊤]_ . See Section 5.2 for more details. 

## **5.1 Eliminating dependence on the lifting dimension** 

In this section we show that the computational complexity of solving the MPC problem (23) can be rendered independent of the dimension of the lifted state _N_ . This is achieved by transforming (23) in the so-called _dense form_ 

**==> picture [329 x 49] intentionally omitted <==**

for some positive-semidefinite matrix _H ∈_ R _[mN][p][×][mN][p]_ and some matrices and vectors _h ∈_ R _[mNp]_ , _G ∈_ R _[N][×][mNp]_ , _L ∈_ R _[n][c][N][p][×][mNp]_ , _M ∈_ R _[n][c][N][p][×][N]_ and _c ∈_ R _[n][c][N][p]_ . The optimization is over the vector of predicted control inputs _U_ = [ _u[⊤]_ 0 _[, u][⊤]_ 1 _[, . . . , u][⊤] Np−_ 1[]] _[⊤]_[.][This][“dense”][formula-] tion can be readily derived from the “sparse” formulation (23) by solving explicitly for _zi_ ’s and concatenating the point-wise-in-time stage costs and constraints; see the Appendix for explicit expressions for the data matrices of (24) in terms of those of (23). 

Notice that, crucially, the size of the Hessian _H_ or the number of the constraints _nc_ in the dense formulation (24) is _independent_ of the size of the lift _N_ . Hence, once the nonlinear mapping _z_ 0 = _**ψ**_ ( _xk_ ) is evaluated, the computational cost of solving (24) is comparable to 

10 

solving a standard _linear_ MPC on the same prediction horizon, with the same number of control inputs and with the dimension of the state-space equal to _n_ rather than _N_ . This comes from the fact that the cost of solving an MPC problem in a dense form is independent of the dimension of the state-space, once the data matrices in (24) are formed. Importantly, these matrices are _fixed_ and _precomputed offline_ before deploying the controller (with the exception of the inexpensive matrix-vector multiplication _z_ 0 _[⊤][G]_[).][This][is][in][contrast][with] other MPC schemes for nonlinear systems where these matrices have to be re-computed at each time step of the closed-loop operation, thereby greatly increasing the computational cost. 

The closed-loop operation of the lifting-based MPC can be summarized by the following algorithm, where _U_ 1: _[⋆] m_[denotes][the][first] _[m]_[components][of] _[U][ ⋆]_[:] 

## – **Algorithm 1** Lifting MPC closed-loop operation 

1: **for** _k_ = 0 _,_ 1 _, . . ._ **do** 

- 2: Set _z_ 0 := _**ψ**_ ( _xk_ ) 3: Solve (24) to get an optimal solution _U[⋆]_ 

4: Set _uk_ = _U_ 1: _[⋆] m_ 

- 5: _xk_ +1 = _f_ ( _xk, uk_ ) [ = apply _uk_ to the system (1)] 

## **5.2 Transforming NMPC to Koopman MPC** 

In this section we describe in detail how a traditional nonlinear MPC problem translates[5] to the proposed MPC (23). We assume a nonlinear MPC problem which at each time step _k_ of the closed-loop operation solves the optimization problem 

**==> picture [369 x 80] intentionally omitted <==**

where the notation _x_ ¯ is used to distinguish the predicted state _x_ ¯, used only within the optimization problem (25), from the true measured state _x_ of the dynamical system (1). Notice that the true nonlinear dynamics _x_[+] = _f_ ( _x, u_ ) appears as a constraint of (25); in addition, the functions _li_ and _cxi_ can be nonlinear and hence the optimization problem (25) is in general nonconvex and extremely hard to solve to global optimality. 

In order to translate (25) to the proposed form (23) we assume that a predictor of the form (2) with matrices _A_ and _B_ has been constructed as described in Section 4, using a lifting mapping _**ψ**_ = [ _ψ_ 1 _, . . . , ψN_ ] _[⊤]_ . The matrices _A_ , _B_ appear in the first constraint of (23) and the lifting mapping _**ψ**_ is used for initialization _z_ 0 = _**ψ**_ ( _xk_ ). In order to obtain the remaining data matrices of (23) we assume without loss of generality that _ψi_ ( _x_ ) = _li_ ( _x_ ), _i_ = 

> 5By translate, we do not mean to rewrite in an equivalent form. The problem (23) is of course only an approximation to (25) since the lifted linear predictor is not exact unless the dynamical system is linear. 

11 

0 _, . . . , Np_ and _ψNp_ + _i_ ( _x_ ) = _cxi_ ( _x_ ), _i_ = 0 _, . . . , Np_ . With this assumption, the remaining data is given by _Qi_ = 0, _Ri_ = _R_[¯] _i_ , _r_ = _r_ ¯ _i_ , _qi_ = [01 _×i,_ 1 _,_ 01 _×N −_ 1 _−i_ ], _Ei_ = [01 _×Np_ + _i,_ 1 _,_ 01 _×N −Np−_ 1 _−i_ ], _Fi_ = _c[⊤] ui_[,] _[b][i]_[=][0,][where][0] _[i][×][j]_[denotes][the][matrix][of][zeros][of][size] _[i][×][j]_[.] Note that this derivation assumed that the constraint functions _cxi_ and _cui_ are scalar-valued; for vector valued constraint functions, the approach is analogous, setting the lifting functions _ψi_ equal to the individual components of the constraint functions _cxi_ . 

We also note that this canonical approach always leads to a linear cost function in (23). However, in special cases, when some of the cost functions _li_ ( _xi_ ) are convex quadratic, one may want to use the freedom of the formulation (23) and instead of setting _ψi_ = _li_ , use the quadratic terms in the cost function of (23), thereby reducing the dimension of the lift. See Section 8.2 for an example. 

## **6 Theoretical analysis** 

In this section we discuss theoretical properties of the EDMD algorithm of Section 3.2. Full exposition of the theoretical analysis of EDMD is beyond the scope of this paper and therefore we only summarize the authors’ results obtained concurrently in [11], where the reader is referred to for proofs of the theorems stated in this section and additional results. Note that the results of Theorems 1 and 2 are not new and were, to the best of our knowledge, first rigorously proven in [8, Section 3.4] and alluded to already in the original EDMD paper [25]; here we state them in a language suitable for our purposes. 

We work in an abstract setting with a dynamical system 

**==> picture [57 x 14] intentionally omitted <==**

with _F_ : _M →M_ , where _M_ is a given separable topological space. This encompasses both the finite-dimensional setting with _M_ = R _[n]_ and the infinite-dimensional controlled setting of Section 3.1 with _M_ = R _[n] × l_ ( _U_ ). The Koopman operator _K_ : _H →H_ on a space of observables _H_ (with _φ_ : _M →_ R for all _φ ∈H_ ) is defined as in (9) by _Kφ_ = _φ ◦ F_ for all _φ ∈H_ . We assume the EDMD algorithm of Section 3.2, i.e., we solve the optimization problem 

**==> picture [317 x 35] intentionally omitted <==**

where 

**==> picture [144 x 18] intentionally omitted <==**

with _φi ∈H_ , _i_ = 1 _, . . . , N_ , being linearly independent basis functions. Denoting _HN_ the span of _φ_ 1 _, . . . , φN_ , the finite-dimensional approximation of the Koopman operator _KN,K_ : _HN →HN_ obtained from (26) is defined for any _g_ = _c[⊤]_ _**φ** ∈HN_ by 

**==> picture [285 x 15] intentionally omitted <==**

where _AN,K_ is the optimal solution of (26). 

12 

## **6.1 EDMD as** _L_ 2 **projection** 

First we give a characterization of the EDMD algorithm as an _L_ 2 projection. Given an arbitrary nonnegative measure _µ_ on _M_ , we define the _L_ 2( _µ_ ) projection[6] of a function _g_ onto _HN_ as 

**==> picture [369 x 61] intentionally omitted <==**

We have the following characterization of _KN,K_ . 

**Theorem 1** _Let µ_ ˆ _K denote the empirical measure associated to the points χ_ 1 _, . . . , χK, i.e.,_ ˆ _K µK_ = _K_[1] � _i_ =1 _[δ][χ] i[,][where][δ][χ] i[denotes][the][Dirac][measure][at][χ][i][.][Then][for][any][g][∈H][N]_ 

**==> picture [346 x 24] intentionally omitted <==**

_i.e.,_ 

**==> picture [282 x 16] intentionally omitted <==**

_where K|HN_ : _HN →H is the restriction of the Koopman operator to the subspace HN ._ 

In words, the operator _KN,K_ is the _L_ 2 projection of the operator _K_ on the span of _φ_ 1 _, . . . , φN_ with respect to the empirical measure supported on the samples _χ_ 1 _, . . . , χK_ . 

## **6.2 Convergence of EDMD** 

Now we turn into analyzing convergence _KN,K_ to _K_ as the number of samples _K_ and the number of basis functions _N_ tend to infinity. 

First we analyze convergence as _K_ tends to infinity. For this we assume a probabilistic sampling model. That is, we assume that the space _M_ is endowed with a probability measure _µ_ and that the samples _χ_ 1 _, . . . , χK_ are independent identically distributed (iid) samples from the distribution _µ_ and we assume that _H_ = _L_ 2( _µ_ ). We invoke the following non-restrictive assumption 

**Assumption 1 (** _µ_ **independence)** _The basis functions φ_ 1 _, . . . , φN are such that_ 

**==> picture [156 x 16] intentionally omitted <==**

_for all nonzero c ∈_ R _[N] ._ 

This is a natural assumption ensuring that the measure _µ_ is not supported on a zero level set of a nontrivial linear combination of the basis functions used. 

> 6The Hilbert space _L_ 2( _µ_ ) is the space of all square integrable functions with respect to the measure _µ_ . 

13 

Finally we define 

**==> picture [274 x 14] intentionally omitted <==**

i.e., the _L_ 2( _µ_ ) projection of the Koopman operator _K_ on _HN_ . Then we have the following result: 

**Theorem 2** _If Assumption 1 holds, then with probability one_ 

**==> picture [296 x 18] intentionally omitted <==**

_where ∥· ∥ is any operator norm and_ 

**==> picture [317 x 19] intentionally omitted <==**

_where σ_ ( _·_ ) _⊂_ C _denotes the spectrum of an operator and_ dist( _·, ·_ ) _the Hausdorff metric on subsets of_ C _._ 

Theorem 2 says that the EDMD approximations _KN,K_ converge in the operator norm to the _L_ 2( _µ_ ) projection of the Koopman operator onto the span of the basis functions _φ_ 1 _, . . . , φN_ . Having established convergence of _KN,K_ to _K_ we turn to studying convergence of _KN_ to _K_ . Since the operator _KN,K_ is defined only on _HN_ we extend it to all of _H_ by precomposing with the projection on _HN_ , i.e., we study convergence of _KN PN[µ]_[:] _[ H →H]_[to] _[K]_[ :] _[ H →H]_[.] We have the following result: 

**Theorem 3** _If_ ( _φi_ ) _[∞] i_ =1 _[forms][an][orthonormal][basis][of][H]_[=] _[L]_[2][(] _[µ]_[)] _[and][if][K]_[:] _[H][→H][is] continuous, then the sequence of operators KN PN[µ]_[=] _[P][ µ] N[K][P][ µ] N[converges][to][K][as][N][→∞][in] the strong operator topology, i.e., for all g ∈H_ 

**==> picture [155 x 18] intentionally omitted <==**

_In particular, if g ∈HN_ 0 _for some N_ 0 _∈_ N _, then_ 

**==> picture [139 x 18] intentionally omitted <==**

Theorem 3 tells us that the sequence of operators _KN PN[µ]_[converges][strongly][to] _[K]_[.] For additional results on spectral convergence of _KN_ to _K_ , weak spectral convergence of _KN,N_ (i.e., with _K_ = _N_ ) to _K_ and for a method to construct _KN_ directly, without the need for sampling, see [11]. 

Now we use Theorem 3 to establish convergence of finite-horizon predictions of a given vector-valued observable _g ∈HN[n][g]_ 0[.][For][our][purposes,][the][most][pertinent][situation][is][when] _[g]_ is the state observable, i.e., _g_ ( _x_ ) = _x_ in which case the following result pertains to predictions of the state itself. We let _AN,K_ denote the solution to (26) and set _AN_ = lim _K→∞ AN,K_ . Since _g ∈HN[n][g]_ 0[, it follows that for every] _[ N][≥][N]_[0][there exists a matrix] _[ C][N][∈]_[R] _[n][g][×][N]_[such that] _g_ = _CN_ _**φ** N_ , where _**φ** N_ = [ _φ_ 1 _, . . . , φN_ ] _[⊤]_ . With this notation the following result holds: 

14 

**Corollary 1** _If the assumptions of Theorem 3 hold and g ∈HN[n][g]_ 0 _[for][some][N]_[0] _[∈]_[N] _[,][then][for] any finite prediction horizon Np ∈_ N 

**==> picture [356 x 30] intentionally omitted <==**

In words, predictions over any _finite_ horizon converge in the _L_ 2( _µ_ ) norm. Unfortunately, Corollary 1 does not immediately apply to the linear predictors designed in Section 3.2 as the set of basis functions (12) does not form an orthonormal basis of _H_ because of the special structure of these basis functions which ensures linearity of the resulting predictors. In this setting, one can only prove convergence of _KN_ to _P∞[µ][K][|H] ∞_[, where] _[ P][ µ] ∞_[is the] _[ L]_[2][(] _[µ]_[) projection] onto _H∞_ := _{φi | i ∈_ N _}_ . 

## **7 Extensions** 

In this section, we describe extensions of the proposed approach to input-output dynamical systems and to systems with disturbances / noise. 

## **7.1 Input-output dynamical systems** 

In this section we describe how the approach can be generalized to the case when full state measurements are not available, but rather only certain output is measured. To this end, consider the dynamical system 

**==> picture [269 x 31] intentionally omitted <==**

where _y_ is the measured output and _h_ : R _[n] →_ R _[n][h]_ . 

## **7.1.1 Dynamics (35) is known** 

If the dynamics (35) is known, one can construct a predictor of the form (2) by applying the algorithm of Section 4 to data obtained from simulation of the dynamical system (35). In closed-loop operation, the predictor (2) is then used in conjunction with a state-estimator for the dynamical system (35). Alternatively, one can design, using linear observer design methodologies, a state estimator directly for the linear predictor (2). Interestingly, doing so obviates the need to evaluate the lifting mapping _z_ = _**ψ**_ ( _x_ ) in closed loop, as the lifted state is directly estimated. This idea is closely related to the use of the Koopman operator for state estimation [22, 21]. 

## **7.1.2 Dynamics (35) is not known** 

If the dynamics (35) is not known and only input-output data is available, one could construct a predictor of the form (2) or (5) by taking as lifting functions only functions of the output 

15 

_y_ , i.e., _ψi_ ( _x_ ) = _φi_ ( _h_ ( _x_ )). This, however, would be extremely restrictive as this severely restricts the class of lifting functions available. Indeed, if, for example, _h_ ( _x_ ) = _x_ 1, only functions of the first component are available. However, this problem can be circumvented by utilizing the fact that subsequent measurements, _h_ ( _x_ ), _h_ ( _f_ ( _x_ )), _h_ ( _f_ ( _f_ ( _x_ ))), etc., are available and therefore we can define observables depending not only on _h_ but also on repeated composition of _h_ with _f_ . In practice this corresponds to having the lifting functions depend not only on the current measured output but also on several previous measured outputs (and inputs, in the controlled setting). The use of time-delayed measurements is classical in system identification theory (see, e.g., [12]) but has also appeared in the context of Koopman operator approximation (see, e.g., [1, 23]). 

Assume therefore that we are given a collection of data 

**==> picture [283 x 15] intentionally omitted <==**

where 

**==> picture [391 x 56] intentionally omitted <==**

with ( _yi,j_ ) _[n] j_ =0 _[d]_[+1] being a vector of consecutive output measurements generated by (¯ _ui,j_ ) _[n] j_ =0 _[d]_ consecutive inputs. We note that there does not need to be any temporal relation between _**ζ** i_ and _**ζ** i_ +1. If, however, _**ζ** i_ and _**ζ** i_ +1 are in fact successors, then the matrices **X[˜]** and **Y[˜]** have the familiar (quasi)-Hankel structure known from system identification theory. 

Computation of a linear predictor then proceeds in the same way as for the full-state measurement: We lift the collected data and look for the best one-step predictor in the lifted space. This leads to the optimization problem 

**==> picture [308 x 21] intentionally omitted <==**

where 

and 

**==> picture [380 x 84] intentionally omitted <==**

is a vector of real or complex-valued, possibly nonlinear, lifting functions. This leads to a linear predictor in the lifted space 

**==> picture [272 x 31] intentionally omitted <==**

where _y_ ˆ is the prediction of _y_ and _C_ is the solution to 

**==> picture [320 x 24] intentionally omitted <==**

**==> picture [13 x 9] intentionally omitted <==**

The predictor (39) starts from the initial condition 

**==> picture [60 x 13] intentionally omitted <==**

where 

_**ζ**_ 0 = � _y_ 0 _[⊤] u_ ¯ _[⊤] −_ 1 _y−[⊤]_ 1 _. . . u_ ¯ _[⊤] −nd y−[⊤] nd_ � _⊤_ 

is the vector of _nd_ + 1 most recent output measurements and _nd_ input measurements. We remark that the solution to (40) is trivial provided that the outputs and its delays are included among the lifting functions (e.g., if _ψj_ ( _**ζ**_ ) = _**ζ**_ (2 _j_ ), _j_ = 0 _, . . . , nd_ ); see Remark 1. 

**Remark 2 (Closed-loop operation)** _The closed-loop operation of the resulting MPC controller follows the steps of Algorithm 1, only the initialization z_ 0 = _**ψ**_ ( _xk_ ) _in line 2 is replaced by z_ 0 = _**ψ**_ ( _**ζ** k_ ) _, where_ _**ζ** k_ = [ _yk[⊤][, u][⊤] k−_ 1 _[, y] k[⊤] −_ 1 _[, . . . , u][⊤] k−nd[, y] k[⊤] −nd_[]] _[⊤][.]_ 

## **7.2 Disturbance / Noise propagation** 

The approach can be readily extended to systems affected by a disturbance or noise of the form 

**==> picture [276 x 14] intentionally omitted <==**

where _w_ is the disturbance or process noise. The goal is to construct a predictor for (41) of the form 

**==> picture [289 x 30] intentionally omitted <==**

starting from the initial condition _z_ 0 = _**ψ**_ ( _x_ 0), where _**ψ**_ ( _·_ ) is the lifting mapping defined in (19). For example, if _w_ is a stochastic disturbance with known distribution, the linear predictor of the form (42) can be used to approximately compute the distribution of the state _x_ at a future time instance, given a sequence of control inputs up to that time. 

In order to obtain the matrices of the predictor (42), we assume that we are given data of the form 

**==> picture [332 x 15] intentionally omitted <==**

**==> picture [337 x 15] intentionally omitted <==**

satisfying _yi_ = _f_ ( _xi, ui, wi_ ) for all _i_ = 1 _, . . . , K_ . As in Section 4, the matrices are then obtained using least-squares regression: 

**==> picture [386 x 19] intentionally omitted <==**

If measurements of the disturbance _w_ are not available, then these must best estimated from the available data, either using one of the nonlinear estimation techniques or using the Koopman operator-based estimator proposed in [22, 21]. Alternatively, if the mapping _f_ is known (either analytically or in the form of an algorithm) and an algorithm to draw samples from the distribution of _w_ is available, one can obtain data (43) by simulation. 

**Remark 3** _If full-state measurements are not available, the approach can be readily combined with the approach of Section 7.1.1 or 7.1.2._ 

17 

## **8 Numerical examples** 

In this section we compare the prediction accuracy of the linear lifting-based predictor (2) with several other predictors and demonstrate the use of the lifting-based MPC proposed in Section 5 for feedback control of a bilinear model of a motor and of the Korteweg–de Vries nonlinear partial differential equation. The source code for the numerical examples is available from `https://github.com/MilanKorda/KoopmanMPC/raw/master/KoopmanMPC.zip` . 

## **8.1 Prediction comparison** 

In order to evaluate the proposed predictor, we compare its prediction quality with that of several commonly used predictors. The system to compare the predictors on is the classical forced Van der Pol oscillator with dynamics given by 

**==> picture [169 x 29] intentionally omitted <==**

The predictors compared are: 

1. Predictor based on local linearization of the dynamics at the origin, 

2. Predictor based on local linearization of the dynamics at a given initial condition _x_ 0, 

3. Carleman linearization predictor [4], 

4. The proposed lifting-based predictor (2). 

In order to obtain the lifting-based predictor, we discretize the dynamics using the RungeKutta four method with discretization period _Ts_ = 0 _._ 01 s and simulate 200 trajectories over 1000 sampling periods (i.e., 20 s per trajectory). The control input for each trajectory is a random signal with uniform distribution over the interval [ _−_ 1 _,_ 1]. The trajectories start from initial conditions generated randomly with uniform distribution on the unit box [ _−_ 1 _,_ 1][2] . This data collection process results in the matrices **X** and **Y** of size 2 _×_ 2 _·_ 10[5] and matrix **U** of size 1 _×_ 10[5] . The lifting functions _ψi_ are chosen to be the state itself (i.e., _ψ_ 1 = _x_ 1, _ψ_ 2 = _x_ 2) and 100 thin plate spline radial basis functions[7] with centers selected randomly with uniform distribution on the unit box. The dimension of the lifted state-space is therefore _N_ = 102. 

The degree of the Carleman linearization is set to 14, resulting in the size of the Carleman linearization predictor of 120 (= the number of monomials of degree less than or equal to 14 in two variables). The _B_ matrix for Carleman linearization predictor is set to [0 _,_ 1 _,_ 0 _, . . . ,_ 0] _[⊤]_ . Figure 2 compares the predictions starting from two initial conditions _x_[1] 0[= [0] _[.]_[5] _[,]_[ 0] _[.]_[5]] _[⊤]_[,] _[x]_[2] 0[=] [ _−_ 0 _._ 1 _, −_ 0 _._ 5] _[⊤]_ generated by a control signal _u_ ( _t_ ) being a square wave with unit magnitude 

> 7Thin plate spline radial basis function with center at _x_ 0 is defined by _ψ_ ( _x_ ) = _∥x − x_ 0 _∥_ 2 log( _∥x − x_ 0 _∥_ ). 

18 

and period 0 _._ 3 s. Table 1 reports the relative root mean squared errors (RMSE) 

**==> picture [355 x 77] intentionally omitted <==**

for each predictor averaged over 100 randomly sampled initial conditions with the same square wave forcing. We observe that the lifting-based Koopman predictor is far superior to the remaining predictors. Finally, Table 2 reports the prediction accuracy of the lifting predictor in terms of the average RMSE error as a function of the dimension of the lift _N_ ; we observe that, as expected, the prediction error decreases with increasing _N_ , albeit not monotonously. 

**==> picture [436 x 330] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>True True<br>1 Koopman 0.8 Koopman<br>Local at 0 0.6 Local at 0<br>Local at x0 Local at x0<br>0.5 Carleman 0.4 Carleman<br>0.2<br>0<br>x 1 0 x 2<br>-0.2<br>-0.4<br>-0.5<br>-0.6<br>-0.8<br>-1 -1<br>0 0.5 1 1.5 2 2.5 3 0 0.5 1 1.5 2 2.5 3<br>time [s] time [s]<br>1.5<br>1.2 True True<br>Koopman Koopman<br>1 Local at 0 Local at 0<br>1<br>0.8 Local at x0 Local at x0<br>Carleman Carleman<br>0.6<br>0.4 0.5<br>x 1 0.2 x 2<br>0<br>0<br>-0.2<br>-0.4<br>-0.6 -0.5<br>-0.8<br>0 0.5 1 time [s] 1.5 2 2.5 3 0 0.5 1 time [s] 1.5 2 2.5 3<br>**----- End of picture text -----**<br>


Figure 2: Prediction comparison for the forced Van der Pol oscillator. Top: initial condition _x_ 0 = [0 _._ 5 _,_ 0 _._ 5] _[⊤]_ . Bottom: initial condition _x_ 0 = [ _−_ 0 _._ 1 _, −_ 0 _._ 5] _[⊤]_ . The forcing _u_ ( _t_ ) is in both cases a square wave with unit amplitude and period 0 _._ 3 s. 

19 

Table 1: Prediction comparison – average RMSE (45) over 100 randomly sampled initial conditions: comparison among different predictors. 

||_x_0|||Average RMSE|
|---|---|---|---|---|
||Koopman|||24.4 %|
|Local|linearization|at|_x_0|2_._83_·_103 %|
|Local|linearization|at|0|912.5 %|
||Carleman|||5_._08_·_1022 %|



Table 2: Prediction comparison – lifting-based Koopman predictor – average prediction RMSE over 100 randomly sampled initial conditions as a function of the dimension of the lift. 

|_N_||5||10||25||50||75||100|
|---|---|---|---|---|---|---|---|---|---|---|---|---|
|Average|RMSE|66_._5|%|44_._9|%|47_._0|%|38_._7|%|30_._6|%|24_._4 %|



## **8.2 Feedback control of a bilinear motor** 

In this section we apply the proposed approach to the control of a bilinear model of a DC motor [5]. The model reads 

**==> picture [210 x 47] intentionally omitted <==**

where _x_ 1 is the rotor current, _x_ 2 the angular velocity and the control input _u_ is the stator current and the output _y_ is the angular velocity. The parameters are _La_ = 0 _._ 314, _Ra_ = 12 _._ 345, _km_ = 0 _._ 253, _J_ = 0 _._ 00441, _B_ = 0 _._ 00732, _τl_ = 1 _._ 47, _ua_ = 60. Notice in particular the bilinearity between the state and the control input. The physical constraints on the control input are _u ∈_ [ _−_ 4 _,_ 4], which we scale to [ _−_ 1 _,_ 1] _._ 

The goal is to design an MPC controller based on Section 7.1.2, i.e., assuming only inputoutput data available and no explicit knowledge of the model. In order to obtain the liftingbased predictor (39), we discretize the scaled dynamics using the Runge-Kutta four method with discretization period _Ts_ = 0 _._ 01 s and simulate 200 trajectories over 1000 sampling periods (i.e., 20 s per trajectory). The control input for each trajectory is a random signal uniformly distributed on [ _−_ 1 _,_ 1]. The trajectories start from initial conditions generated randomly with uniform distribution on the unit box [ _−_ 1 _,_ 1][2] . We choose the number of delays _nd_ = 1. The lifting functions _ψi_ are chosen to be the time-delayed vector _**ζ** ∈_ R[3] , defined in (36), and 100 thin plate spline radial basis functions (see Footnote 7) with centers selected randomly with uniform distribution over [ _−_ 1 _,_ 1][3] . The dimension of the lifted state-space is therefore _N_ = 103. First, in Figure 3, we compare the output predictions for two different, randomly chosen, initial conditions against the predictor based on local linearization at a given initial condition. The prediction accuracy of the proposed predictor is superior, especially for longer prediction times. This is documented further in Table 3 

20 

by the relative root mean-squared errors (45) over a one-second prediction horizon averaged over one hundred randomly sampled initial conditions. Both in Figure 3 and Table 3, the control signal was a pseudo-random binary signal generated anew for each initial condition. 

Table 3: Feedback control of a bilinear motor – prediction RMSE (45) for 100 randomly generated initial condtions. 

**==> picture [433 x 226] intentionally omitted <==**

**----- Start of picture text -----**<br>
Koopman Local linearization at x 0<br>Average RMSE 32.3 % 135.5 %<br>0.5<br>1 True True<br>Koopman Koopman<br>Local at x0 Local at x0<br>0.5 0<br>0<br>y y -0.5<br>-0.5<br>-1<br>-1<br>0 0.2 0.4 0.6 0.8 1 0 0.2 0.4 0.6 0.8 1<br>time[ s ] time[ s ]<br>**----- End of picture text -----**<br>


Figure 3: Feedback control of a bilinear motor – predictor comparison. Left: initial condition _x_ 0 = [0 _._ 887 _,_ 0 _._ 587] _[⊤]_ . Right: initial condition _x_ 0 = [ _−_ 0 _._ 404 _, −_ 0 _._ 126] _[⊤]_ . 

The control objective is to track a given angular velocity reference _y_ r, which translates into the objective function minimized in the MPC problem 

**==> picture [346 x 56] intentionally omitted <==**

with _C_ = [1 _,_ 0 _, . . . ,_ 0]. This tracking objective function readily translates to the canonical form (23) by expanding the quadratic forms and neglecting constant terms. The cost function matrices were chosen as _Q_ = _QNp_ = 1 and _R_ = 0 _._ 01. The prediction horizon was set to one second, which results in _Np_ = 100. We compare the Koopman operator-based MPC controller (K-MPC) with an MPC controller based on local linearization (L-MPC) in two scenarios. In the first one we do not impose any constraints on the output and track a piecewise constant reference. In the second one, we impose the constraint _y ∈_ [ _−_ 0 _._ 4 _,_ 0 _._ 4] and track a time-varying reference _y_ r( _t_ ) = 0 _._ 5 cos(2 _πt/_ 3), which violates the output constraint for some portion of the simulated period. The simulation results are shown in Figure 4. We observe a virtually identical tracking performance in the first case. In the second case, however, the local-linearization controller becomes infeasible and hence cannot complete 

21 

**==> picture [405 x 316] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0.6<br>0.4 0.5<br>0.2<br>0<br>y 0 u<br>-0.2 -0.5<br>K-MPC<br>K-MPC L-MPC<br>-0.4 L-MPC -1 Constraints<br>Reference<br>-0.6 0 1 2 3<br>0 0.5 1 1.5 2 2.5 3<br>time[ s ] time[ s ]<br>0.6<br>K-MPC 1<br>L-MPC<br>0.4 Reference YHH<br>0.2 [CO] CC Constraints 0.80.6 0.80.61<br>C<br>y 0 C u 0.4<br>0.4 0.2<br>C 0 0.05 0.1 0.15 0.2<br>L-MPC<br>-0.2 K-MPC<br>infeasible 0.2<br>L-MPC<br>-0.4 Constraint<br>0<br>0 1 2 3<br>0 0.5 1 1.5 2 2.5 3<br>time[ s ] time[ s ]<br>**----- End of picture text -----**<br>


Figure 4: Feedback control of a bilinear motor – reference tracking. Top: piecewise constant reference, _x_ 0 = [0 _,_ 0 _._ 6] _[⊤]_ , no state constraints. Right: time-varying reference, _x_ 0 = [ _−_ 0 _._ 1 _,_ 0 _._ 1] _[⊤]_ , constraints on the output imposed. 

the entire simulation period[8] . This infeasibility occurs due to the inaccurate predictions of the local linearization predictor over longer prediction horizons. The proposed K-MPC controller, on the other hand, does not run infeasible and completes the simulation period without violating the constraints. 

Note that, even in the first scenario where the two controllers perform equally, the K-MPC controller has the benefit of being completely _data-driven_ and requiring only _output measurements_ , whereas the L-MPC controller requires a model (to compute the local linearization) and full state measurements. In addition, the average computation time[9] required to evaluate the control input of the K-MPC controller was 6 _._ 86 ms (including the evaluation of the lifting mapping _**ψ**_ ( _**ζ**_ )), as opposed to 103 ms for the L-MPC controller. This discrepancy is due to the fact that the local linearization and all data defining the underlying optimization problem that depend on it have to be re-computed at every iteration, which is costly on its own and also precludes efficient warm-starting; on the other hand, all data (except for the initial condition) of the underlying optimization problem of K-MPC are precomputed offline. In both cases, the computation times could be significantly reduced with a more efficient 

> 8Infeasibility of the underlying optimization problem is a common problem encountered in predictive control with various heuristic (e.g., soft constraints) or theoretically substantiated (e.g., set invariance) approaches trying to address them. See, e.g., [7, 20] for more details. 

> 9The optimization problems were solved by qpOASES [6] running on Matlab and 2 GHz Intel Core i7 with 8 GB RAM. 

22 

implementation. However, we believe, that the proposed approach would still be superior in terms of computational speed. 

## **8.3 Nonlinear PDE control** 

In order to demonstrate the scalability and versatility of the approach, we use it to control the nonlinear Korteweg–de Vries (KdV) equation modelling the propagation of acoustic waves in a plasma or shallow-water waves [17]. The equation reads 

**==> picture [240 x 27] intentionally omitted <==**

where _y_ ( _t, x_ ) is the unknown function and _u_ ( _t, x_ ) the control input. We consider a periodic boundary condition on the spatial variable _x ∈_ [ _−π, π_ ]. The nonlinear PDE is discretized using the split-stepping method with spatial mesh of 128 points and time discretization of ∆ _t_ = 0 _._ 01 s, resulting in a computational state-space of dimension _n_ = 128. The control input _u_ is considered to be of the form _u_ ( _t, x_ ) =[�][3] _i_ =1 _[u][i]_[(] _[t]_[)] _[v][i]_[(] _[x]_[), where the coefficients] _[ u][i]_[(] _[t]_[) are] to be determined by the controller and _vi_ are fixed spatial profiles given by _vi_ ( _x_ ) = _e[−]_[25(] _[x][−][c][i]_[)][2] with _c_ 1 = _−π/_ 2, _c_ 2 = 0, _c_ 3 = _π/_ 2. The control inputs are constrained to _ui_ ( _t_ ) _∈_ [ _−_ 1 _,_ 1]. The lifting-based predictors are constructed from data in the form of 1000 trajectories of length 200 samples. The initial conditions of the trajectories are random convex combinations of three fixed spatial profiles given by _y_ 0[1][=] _[e][−]_[(] _[x][−][π/]_[2)][2][,] _[y]_ 0[2][=] _[−]_[sin(] _[x/]_[2)][2][,] _[y]_ 0[3][=] _[e][−]_[(] _[x]_[+] _[π/]_[2)][2][;][the] control inputs _ui_ ( _t_ ) are distributed uniformly in [ _−_ 1 _,_ 1][3] . The lifting mapping _**ψ**_ is composed of the state itself, the elementwise square of the state, the elementwise product of the state with its periodic shift and the constant function, resulting in the dimension of the lifted state _N_ = 3 _·_ 128 + 1 = 385. The control goal is to track a constant-in-space reference that varies in time in a piecewise constant manner. In order to do so we design the lifting-based Koopman MPC (23) with the reference tracking objective (46) with _Q_ = _QNp_ = _I_ , _R_ = 0, _C_ = [ _I_ 128 _,_ 0] and prediction horizon _Np_ = 10 (i.e., 0 _._ 1 s). The results are depicted in Figure 5; we observe a fast and accurate tracking of the reference profile. The average computation time to evaluate the control input was 0 _._ 28 ms (using the dense form (24) and the hardware configuration described in Footnote 9), allowing for deployment in real-time applications requiring very fast sampling rates. 

## **9 Conclusion and outlook** 

In this paper, we described a class of linear predictors for nonlinear controlled dynamical systems building on the Koopman operator framework. The underlying idea is to lift the nonlinear dynamics to a higher dimensional space where its evolution is approximately linear. The predictors exhibit superior performance on the numerical examples tested and can be readily used for feedback control design using linear control design methods. In particular, linear model predictive control (MPC) can be readily used to design controllers for the nonlinear dynamical system without resorting to non-linear numerical optimization schemes. Linear inequality constraints on the states and control inputs as well as nonlinear constraints on the states can be imposed in a linear fashion; in addition cost functions nonlinear in the 

23 

**==> picture [498 x 132] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.8 1<br>0.7 SpatialReferencemean of y(t; x) 0.8 uu12((tt))<br>0.6 0.6 u3(t)<br>0.5 0.4<br>0.2<br>0.4<br>0<br>0.3<br>-0.2<br>0.2<br>-0.4<br>0.1 -0.6<br>0 -0.8<br>-0.1 -1<br>0 10 20 30 40 50 0 10 20 30 40 50<br>t [s] x t [s] t  [s]<br>)<br>t, x<br>(<br>y<br>**----- End of picture text -----**<br>


Figure 5: Nonlinear PDE control – Tracking of a time-varying constant-in-space reference profile for the Korteweg–de Vries equation. Left: closed-loop solution. Middle: spatial mean of the solution. Right: control inputs. 

state can be handled in a linear fashion as well. Computational complexity of the underlying optimization problem is comparable to that of an MPC problem for a linear dynamical system of the same size. This is achieved by using the so-called dense form of an MPC problem whose computational complexity depends only on the number of control inputs and is virtually independent of the number of states. Importantly, the entire control design procedure is data-driven, requiring only input-output measurements. 

Future work should focus on imposing or proving closed-loop guarantees (e.g., stability or degree of suboptimality) of the controller designed using the presented methodology and on optimal selection of the lifting functions given some prior information on the dynamical system at hand. 

## **10 Acknowledgments** 

The first author would like to thank Colin N. Jones for initial discussions on the topic and for comments on the manuscript, as well as to the three anonymous referees for their constructive comments that helped improve the manuscript. The authors would also like to thank P´eter Koltai for bringing to our attantion reference [8]. 

This research was supported in part by the ARO-MURI grant W911NF-14-1-0359 and the DARPA grant HR0011-16-C-0116. The research of M. Korda was supported by the Swiss National Science Foundation under grant P2ELP2 ~~1~~ 65166. 

## **Appendix** 

This appendix expresses explicitly the matrices in the “dense-form” MPC problem (24) as a function of the data defining the “sparse-form” MPC problem (23). The matrices are given by 

**==> picture [259 x 38] intentionally omitted <==**

24 

where 

**==> picture [373 x 128] intentionally omitted <==**

with diag( _·, . . . , ·_ ) denoting a block-diagonal matrix composed of the arguments. 

## **References** 

- [1] S. L. Brunton, B. W. Brunton, J. L. Proctor, E. Kaiser, and J. N. Kutz. Chaos as an intermittently forced linear system. _Nature communications_ , 8(1), 2017. 

- [2] S. L. Brunton, B. W. Brunton, J. L. Proctor, and J. N. Kutz. Koopman invariant subspaces and finite linear representations of nonlinear dynamical systems for control. _PloS one_ , 11(2):e0150171, 2016. 

- [3] M. Budiˇsi´c, R. Mohr, and I. Mezi´c. Applied Koopmanism. _Chaos: An Interdisciplinary Journal of Nonlinear Science_ , 22(4):047510, 2012. 

- [4] T. Carleman. Application de la th´eorie des ´equations int´egrales lin´eaires aux syst´emes d’´equations diff´erentielles non lin´eaires. _Acta Mathematica_ , 59(1):63–87, 1932. 

- [5] S. Daniel-Berhe and H. Unbehauen. Experimental physical parameter estimation of a thyristor driven DC-motor using the HMF-method. _Control Engineering Practice_ , 6(5):615–626, 1998. 

- [6] H. J. Ferreau, C. Kirches, A. Potschka, H. G. Bock, and M. Diehl. qpOASES: A parametric active-set algorithm for quadratic programming. _Mathematical Programming Computation_ , 6(4):327–363, 2014. 

- [7] L. Gr¨une and J. Pannek. Nonlinear model predictive control. In _Nonlinear Model Predictive Control_ . Springer, 2011. 

- [8] S. Klus, P. Koltai, and C. Sch¨utte. On the numerical approximation of the PerronFrobenius and Koopman operator. _Journal of Computational Dynamics_ , 3(1):51–79, 2016. 

- [9] B. Koopman. Hamiltonian systems and transformation in Hilbert space. _Proceedings of the National Academy of Sciences of the United States of America_ , 17(5):315–318, 1931. 

25 

- [10] B. Koopman and J. von Neuman. Dynamical systems of continuous spectra. _Proceedings of the National Academy of Sciences of the United States of America_ , 18(3):255–263, 1932. 

- [11] M. Korda and I. Mezi´c. On convergence of Extended dynamic mode decomposition to the Koopman operator. _Journal of Nonlinear Science_ , 28(2):687–710, 2018. 

- [12] L. Ljung. System identification. In _Signal Analysis and Prediction_ , pages 163–173. Springer, 1998. 

- [13] A. Mauroy and J. Goncalves. Linear identification of nonlinear systems: A lifting technique based on the Koopman operator. In _Conference on Decision and Control (CDC)_ , 2016. 

- [14] D. Q. Mayne, J. B. Rawlings, C. V. Rao, and P. O. Scokaert. Constrained model predictive control: Stability and optimality. _Automatica_ , 36(6):789–814, 2000. 

- [15] I. Mezi´c. Spectral properties of dynamical systems, model reduction and decompositions. _Nonlinear Dynamics_ , 41(1-3):309–325, 2005. 

- [16] I. Mezi´c and A. Banaszuk. Comparison of systems with complex behavior. _Physica D: Nonlinear Phenomena_ , 197(1-2):101–133, 2004. 

- [17] R. M. Miura. The korteweg–devries equation: A survey of results. _SIAM review_ , 18(3):412–459, 1976. 

- [18] J. L. Proctor, S. L. Brunton, and J. N. Kutz. Dynamic mode decomposition with control. _SIAM Journal on Applied Dynamical Systems_ , 15(1):142–161, 2016. 

- [19] J. L. Proctor, S. L. Brunton, and J. N. Kutz. Generalizing Koopman theory to allow for inputs and control. _arXiv preprint arXiv:1602.07647_ , 2016. 

- [20] J. B. Rawlings and D. Q. Mayne. _Model Predictive Control: Theory and Design_ . Nob Hill Publishing, first edition, 2009. 

- [21] A. Surana. Koopman operator based observer synthesis for control-affine nonlinear systems. In _Conference on Decision and Control (CDC)_ , 2016. 

- [22] A. Surana and A. Banaszuk. Linear observer synthesis for nonlinear systems using Koopman operator framework. In _IFAC Symposium on Nonlinear Control Systems (NOLCOS)_ , 2016. 

- [23] J. H. Tu, C. W. Rowley, D. M. Luchtenburg, S. L. Brunton, and J. N. Kutz. On dynamic mode decomposition: theory and applications. _Journal of Computational Dynamics_ , 1(2):391–421, 2014. 

- [24] M. O. Williams, M. S. Hemati, S. T. M. Dawson, I. G. Kevrekidis, and C. W. Rowley. Extending data-driven Koopman analysis to actuated systems. In _IFAC Symposium on Nonlinear Control Systems (NOLCOS)_ , 2016. 

26 

- [25] M. O. Williams, I. G. Kevrekidis, and C. W. Rowley. A data–driven approximation of the Koopman operator: Extending dynamic mode decomposition. _Journal of Nonlinear Science_ , 25(6):1307–1346, 2015. 

- [26] M. O. Williams, C. W. Rowley, and I. G. Kevrekidis. A kernel-based approach to datadriven Koopman spectral analysis. _Journal of Computational Dynamics_ , 2(2):247–265, 2015. 

27 

