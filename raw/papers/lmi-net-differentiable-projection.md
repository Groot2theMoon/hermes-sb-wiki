---
title: "LMI-Net: Linear Matrix Inequality—Constrained Neural Networks via Differentiable Projection Layers"
arxiv: "2604.05374"
authors: ["Sunbochen Tang", "Andrea Goertzen", "Navid Azizan"]
year: 2026
source: paper
ingested: 2026-05-02
sha256: 363847b6b1725986c7608c9b945cc48ba96ed94bbacc545de3f74e63c91e7590
conversion: pymupdf4llm
---

# **LMI-Net: Linear Matrix Inequality–Constrained Neural Networks via Differentiable Projection Layers** 

Sunbochen Tang, Andrea Goertzen, and Navid Azizan 

_**Abstract**_ **— Linear matrix inequalities (LMIs) have played a central role in certifying stability, robustness, and forward invariance of dynamical systems. Despite rapid development in learning-based methods for control design and certificate synthesis, existing approaches often fail to preserve the hard matrix inequality constraints required for formal guarantees. We propose LMI-Net, an efficient and modular differentiable projection layer that enforces LMI constraints by construction. Our approach lifts the set defined by LMI constraints into the intersection of an affine equality constraint and the positive semidefinite cone, performs the forward pass via Douglas–Rachford splitting, and supports efficient backward propagation through implicit differentiation. We establish theoretical guarantees that the projection layer converges to a feasible point, certifying that LMI-Net transforms a generic neural network into a reliable model satisfying LMI constraints. Evaluated on experiments including invariant ellipsoid synthesis and joint controller-and-certificate design for a family of disturbed linear systems, LMI-Net substantially improves feasibility over soft-constrained models under distribution shift while retaining fast inference speed, bridging semidefiniteprogram-based certification and modern learning techniques.** 

## I. INTRODUCTION 

Linear matrix inequalities (LMIs) have served as a unifying framework across a wide variety of important problems in dynamics and control [1], including stability certificate synthesis, robust invariance analysis, and control design. Although a single LMI-constrained problem can often be handled efficiently offline by numerical solvers, many applications involve families of related instances in which the same semidefinite programming problem template must be solved repeatedly [2]–[5]. For example, this repeated parameterized structure appears when system parameters or operating conditions change, or disturbance descriptions vary. Under such settings, it is desirable to shift as much computation as possible offline by computing a function that maps problem parameters to solutions, so that a new instance can be handled by function evaluation rather than by solving a new optimization problem from scratch. This offline-online decomposition is closely related to the philosophy of explicit MPC [2], which yields piecewise-affine explicit control laws associated with multiparametric quadratic programming formulations. Since such piecewise-affine maps do not exist in general [6], a learned optimizer that satisfies LMI constraints can be highly desirable for enabling fast online evaluation. 

Recent years have seen rapid progress in learning-based methods for certificate synthesis and control design [7], 

The authors are with the Laboratory for Information and Decision Systems (LIDS), Massachusetts Institute of Technology, Cambridge, MA 02139, USA. Emails: _{_ tangsun, agoertz, azizan _}_ @mit.edu 

including approaches that learn stability and safety certificates from data [8]–[11], as well as methods that jointly learn certificates and feedback control policies [12]–[15]. Because the objective is to establish certifiable stability or safety, satisfaction of the underlying certificate and controller constraints is essential [7]. However, obtaining provable guarantees on the behavior of expressive neural models beyond the training data remains difficult, and constraint violations on previously unseen instances can invalidate the resulting certification [9]. 

A common way to encourage constraint satisfaction is to augment the training objective with sample-based regularization terms that penalize constraint violations [7], [15]. While such soft-constrained formulations can be effective empirically, they do not in general guarantee constraint satisfaction at inference time [16], [17], especially on inputs outside the training distribution. A complementary line of work therefore seeks hard feasibility by construction by designing differentiable layers that enforce constraints on the neural network output, as in [8], [16], [17]. These methods design enforcement mechanisms based on the structure of the constraints. Affine constraints are addressed in [8], [16] by designing closed-form projection layers, and convex constraints can be enforced by ray-based feasible parameterization in [17], although the method is restricted to inputindependent constraints. This leaves open the design of an efficient differentiable projection layer for LMI-constrained learning problems. 

We address this challenge with an explicit, differentiable projection layer tailored to LMI constraints. The key observation driving our approach is that the feasible set of a parameterized LMI admits a lifted representation as the intersection of an affine equality constraint and the positive semidefinite cone. Leveraging this structure, we develop a projection mechanism based on the Douglas–Rachford algorithm [18], an iterative splitting method recently shown to be effective in constrained learning contexts [4], [5]. Our approach enables both efficient forward-pass projections onto the decomposed constraint sets and implicit differentiation in the backward pass. The resulting layer is backboneagnostic and converts repeated constrained optimization into a learned computation, enabling fast evaluation while satisfying LMI constraints at inference time. Our framework is, to our knowledge, the first to enforce input-dependent LMI constraints directly on neural network outputs, offering a scalable pathway for integrating convex control constraints into learning systems. 

Our operator-splitting approach enables principled en- 

forcement of LMI constraints within data-driven models. Our key contributions are as follows: 

- We develop a tailored splitting scheme for LMI constraints that decomposes the feasible set into components with tractable structure. This formulation admits explicit and efficient projections onto each set, making it well-suited for integration into differentiable architectures. 

- We establish theoretical convergence guarantees by leveraging classical results for the Douglas–Rachford algorithm. These guarantees provide a rigorous foundation for the correctness and stability of the proposed projection layer. 

- We present experimental results demonstrating consistent constraint satisfaction and stable behavior across a range of settings. In particular, our approach maintains reliability under both in-distribution and out-ofdistribution inputs, highlighting its robustness in practical deployment scenarios. 

## II. PROBLEM FORMULATION 

- _A. Parameterized Optimization under LMI Constraints_ 

Consider the parameterized optimization problem, 

**==> picture [238 x 40] intentionally omitted <==**

where the symmetric matrices _Fi_ ( _ξ_ ) _∈_ S _[n] , i ∈{_ 0 _, ..., m}_ are known and parameterized by _ξ ∈_ R _[p]_ , _c_ ( _·_ ) is a cost function. _y ∈_ R _[m]_ is the decision variable, and the optimal solution is a function of _ξ_ , _y[∗]_ ( _ξ_ ). Note that _F_ ( _y_ ; _ξ_ ) _⪰_ 0 is a general form that can represent a set of LMIs, as multiple LMIs _F_[(1)] ( _y_ ; _ξ_ ) _⪰_ 0 _, ..., F_[(] _[N]_[)] ( _y_ ; _ξ_ ) _⪰_ 0 can be reformulated as _F_ ( _y_ ; _ξ_ ) = diag ( _F_[(1)] ( _y_ ; _ξ_ ) _, ..., F_[(] _[N]_[)] ( _y_ ; _ξ_ )) _⪰_ 0. 

The optimization in (1) is a reduction of many problems in control theory, where the structure of the objective function _c_ ( _·_ ) and constraints remain fixed for a family of systems, and _ξ_ encodes system-specific parameters. For example, synthesizing a Lyapunov stability certificate for a family of linear systems, _{_ ˙ _x_ = _Ax_ : _A ∈ S_ ( _A_ ) _}_ where _S_ ( _A_ ) is a set of Hurwitz matrices, can be formulated as solving a semidefinite program parameterized by _A_ . Given a specific _A_ , the stability certificate synthesis problem is then an instance of the parameterized optimization problem. Instead of repeatedly invoking a numerical solver for each different instance of _A_ , learning a map _ξ → y[∗]_ ( _ξ_ ) that approximates the optimizer can significantly speed up computation, which is especially beneficial in real-time or distributed settings. 

## _B. Self-supervised Learning with Feasibility by Construction_ 

The objective is to learn a neural network _y_ ˆ( _ξ_ ; _θ_ ) that approximates the optimal solution of (1). Instead of using labeled data that relies on a solver to provide supervised signals, we adopt a self-supervised setting, where we define the training loss to be the average cost function value over different _ξ_ . More formally, given a dataset consisting of _ξ_ 

drawn from a known distribution, _D_ train = _{ξ_[(] _[i]_[)] _}[N] i_ =1[train][,][the] training process solves the following optimization problem, 

**==> picture [207 x 45] intentionally omitted <==**

where Ξ _⊂_ R _[p]_ is the set of admissible parameter values. Our goal is to design a learned optimizer that is _feasible by construction_ . The constraint in (2b) needs to be satisfied for all admissible parameters _ξ ∈_ Ξ, not just for those in the training data _D_ train. 

For problems such as stability certificate synthesis and control design, feasibility by construction is highly desirable, enabling formal guarantees of safety and stability in physical system applications. To enforce feasibility, we define a context-dependent projection, Π _ξ_ : R _[m] →_ R _[m]_ that maps any generic neural network output _y_ NN( _ξ_ ; _θ_ ) _∈_ R _[m]_ to a feasible ˆ point _y_ ( _ξ_ ; _θ_ ) = Π _ξ_ ( _y_ NN( _ξ_ ; _θ_ )) satisfying _F_ (ˆ _y_ ( _ξ_ ; _θ_ ); _ξ_ ) _⪰_ 0. Key requirements for such a projection operator Π _ξ_ include: (i) the output needs to be provably feasible for all inputs; (ii) Π _ξ_ needs to be fully differentiable for training purposes; (iii) Π _ξ_ is computationally efficient during inference. As studied extensively in the literature [1], developing an explicit projection operator for an LMI constraint is difficult in general. We address this issue by decomposing the LMI constraint into the intersection of an affine constraint and a positive semidefinite cone constraint, and leveraging the DouglasRachford algorithm for efficient computation and provable convergence to a feasible point. The details of our approach are discussed in Section III. 

## _C. Illustrative Example: Ellipsoidal Invariant Sets for Disturbed Linear Systems_ 

Consider a linear system under disturbance, 

**==> picture [185 x 12] intentionally omitted <==**

where _A ∈_ R _[n][×][n]_ is a Hurwitz matrix, _Bw ∈_ R _[n][×][n][w]_ , and _w_ is a norm-bounded disturbance. The goal is to find an ellipsoidal set _E_ ( _P_ ) = _{x_ : _x[T] Px ≤_ 1 _}_ with _P ≻_ 0 that is forward invariant for (3). 

Consider a Lyapunov-like storage function candidate _V_ ( _x_ ) = _x[T] Px_ with _P ≻_ 0. A sufficient condition for _E_ ( _P_ ) to be robustly invariant is 

**==> picture [230 x 13] intentionally omitted <==**

where _V_[˙] ( _x, w_ ) = _x[T]_ ( _A[T] P_ + _PA_ ) _x_ + 2 _x[T] PBww_ . Using the S-procedure [19], (4) holds if there exist _α, β ≥_ 0 such that for all _x_ and _w_ , 

**==> picture [189 x 13] intentionally omitted <==**

Without loss of generality, assuming _α_ = _β ≥_ 0, the above condition, combined with _P ≻_ 0, simplifies to 

**==> picture [219 x 25] intentionally omitted <==**

For fixed _α ≥_ 0 and _ϵ >_ 0, the optimization problem is: find _P_ subject to (5). The objective can be chosen as minimizing the volume of _E_ ( _P_ ), i.e., min _−_ log det _P_ . 

Since _P ∈_ S _[n]_ , it has _m_ = _[n]_[(] _[n]_ 2[+][1][)] degrees of freedom. Let _{Ej}[m] j_ =1[be an orthonormal basis for][ S] _[n]_[under the Frobenius] inner product. We parameterize _P_ as 

**==> picture [183 x 30] intentionally omitted <==**

Substituting into (5), the constraint takes the standard form (1) with _ξ_ = ( _A, Bw_ ). The learned mapping is _ξ �→ y_ , where the neural network outputs the coefficients of a feasible _P_ . 

## III. DIFFERENTIABLE PROJECTION LAYERS VIA DOUGLAS-RACHFORD SPLITTING 

## _A. The Douglas-Rachford Algorithm_ 

The Douglas-Rachford algorithm is used to solve optimization problems of the form 

**==> picture [168 x 16] intentionally omitted <==**

Here, _z ∈_ R _[l]_ is a decision variable, _ξ ∈_ R _[p]_ is a context parameter, and _fξ_ : R _[l] →_ R and _gξ_ : R _[l] →_ R are convex objectives. Douglas-Rachford solves the combined objective via an iterative method that alternates between proximal and reflection steps. Specifically, a Douglas-Rachford iteration is performed as follows. 

**==> picture [240 x 89] intentionally omitted <==**

The objectives are incorporated to each iteration via the proximal operator, prox _hσ_ (¯ _z_ ) = argmin _h_ ( _z_ ) + 2[1] _σ[||][z]_[¯] _[ −][z][||]_[2][,] _z_ 

which balances minimizing the specific objective _h_ with remaining close to the input point _z_ ¯. Douglas-Rachford is useful for problems in which the combined objective in (7) is difficult to solve but the proximal operator for both _fξ_ ( _z_ ) and _gξ_ ( _z_ ) is straightforward to compute, particularly when the solutions can be evaluated in closed-form. 

## _B. Douglas-Rachford for Feasibility Problems_ 

The Douglas-Rachford algorithm can be used to solve feasibility problems by formulating constraint satisfaction as a convex optimization problem. Consider two convex constraint sets _C_ 1 and _C_ 2 with _C_ 1 _∩C_ 2 = _∅_ . Define _f_ ( _z_ ) and _g_ ( _z_ ) in (7) with _IC_ 1( _z_ ) and _IC_ 2( _z_ ), respectively. _ICi_ ( _z_ ) is defined to be 0 when the constraint _z ∈Ci_ is satisfied and _∞_ otherwise. With this definition for _f_ ( _z_ ) and _g_ ( _z_ ), it is clear that the solution to (7) occurs only when both constraints are satisfied. Computing the proximal solution for each of the two sets is therefore equivalent to solving prox _Ciσ_ (¯ _z_ ) = argmin _ICi_ ( _z_ ) + 21 _σ[||][z]_[¯] _[−][z][||]_[2][.][That][is,][for] 

_z_ 

the feasibility problem, the proximal solution step in (8) is simply the Euclidean projection onto the respective constraint. Although we drop the dependence on the context parameter _ξ_ for _fξ_ and _gξ_ for notational convenience, we emphasize that Douglas-Rachford readily handles contextdependent constraints, so long as they remain convex. 

For a constraint set _C_ , Douglas-Rachford offers an efficient projection of points onto the feasible set when _C_ can be decomposed into two sets _C_ 1 and _C_ 2 (with _C_ = _C_ 1 _∩C_ 2) whose projections are readily computable. While many splits for _C_ 1 and _C_ 2 may exist, selecting a splitting scheme where the respective Euclidean projections onto each constraint set are computable in closed-form reduces computational burden. Therefore, the efficiency provided by Douglas-Rachford for feasibility problems is often ultimately enabled by the choice of splitting scheme, making the selection of the right scheme for the right problem an important strategic objective. 

## _C. LMI as the Intersection of Two Convex Sets_ 

In this work, we propose a splitting scheme that decomposes the LMI condition _F_ ( _y_ ) _⪰_ 0 into the intersection of an affine equality condition and the positive semidefinite cone. Although the projection onto _F_ ( _y_ ) _⪰_ 0 is generally intractable, our splitting scheme enables efficient projection onto the two individual sets. 

**==> picture [238 x 52] intentionally omitted <==**

Here, _x_ = vec( _X_ ) _∈_ R _[n]_[2] is an auxiliary variable included as an intermediate to enable efficient projection onto the positive semidefinite cone. The projection Π _m_ : R _[m]_[+] _[n]_[2] _→_ R _[m]_ is a final projection onto the first _m_ entries of _z_ = [ _y[T] x[T]_ ] _[T]_ , selecting only _y_ as an output and ignoring the auxiliary variable _x_ . The intersection _C_ 1 _∩C_ 2 is clearly equivalent to the LMI condition _F_ ( _y_ ) _⪰_ 0. We define an optimization problem of the form (7) for the closest projection of the neural network output _y_ ˆ _θ_ onto the constraint _C_ . 

**==> picture [211 x 18] intentionally omitted <==**

Note that _y_ = Π _m_ ( _z_ ) = _z_ 1: _m_ . Equation (10) can be separated into two convex objective functions _f_ ( _z_ ) = _||y − y_ ˆ _θ||_[2] + _IC_ 1( _z_ ) and _g_ ( _z_ ) = _IC_ 2( _z_ ). We now propose efficient computations of the proximal operator for each of the two objectives. We use ¯ _·_ to denote variables that are the input to the proximal projection. For _g_ ( _z_ ) = _IC_ 2( _z_ ), the proximal operator is the minimum-distance projection onto the set _C_ 2. We compute this projection efficiently¯ via an eigenvalue clipping operation. Specifically, let _X_ = _U_ Λ _U[T]_ be the eigendecomposition of the symmetric matrix _X_[¯] . We can then define the projection 

**==> picture [180 x 13] intentionally omitted <==**

The max operation is applied element-wise to the eigenvalue matrix Λ. Equation (11) clearly outputs a positive semidefinite matrix. 

We now define a closed-form solution for the projection ˆ onto the constraint _C_ 1. For _f_ ( _z_ ) = _||yθ − y||_[2] + _IC_ 1( _z_ ), ˆ the proximal operator is prox _fσ_ (¯ _z_ ) = argmin _||y − yθ||_[2] + _z_ 

from _IC_ 1( _z_ )+the 2[1] input _σ[||][z]_[¯] _[−]_ point _[z][||]_[2][. This differs from a Euclidean projection] _z_ ¯, because it balances minimizing the distance between the projected point and both the input point _z_ ¯ _and_ the model output _y_ ˆ _θ_ . The tradeoff between these two objectives for a given Douglas-Rachford iteration is tuned with _σ_ . By expanding the competing objectives and completing the square, we can write the objective as a Euclidean projection from a point that is a weighted average of _y_ ˆ _θ_ and _z_ ¯. 

**==> picture [239 x 50] intentionally omitted <==**

Note that the optimization variable _z_ includes both _y_ and the auxiliary variable _X_ . We now define a closed-form solution for the projection onto constraint _C_ 1. Our proposed constraint decomposition scheme in (9) makes the necessary projection onto _C_ 1 linear in [ _y[T] x[T]_ ] _[T]_ , enabling the use of a closed-form linear equality constraint projection. We define the projection 

**==> picture [239 x 51] intentionally omitted <==**

where _y_ avg = 2 _σ_ 1+1[(2] _[σ][y]_[ˆ] _[θ]_[+] _[y]_[¯][)][.][Note][that][there][is][no][need] to define an _X_ avg, since _X_ is an auxiliary variable that does not have a corresponding neural network output. By vectorizing the matrix _X_ , this problem becomes a Euclidean distance minimization subject to linear constraints on _y_ and _X_ . We vectorize _x_ ¯ = vec( _X_[¯] ), _c_ = vec( _F_ 0), and _L_ = [vec( _F_ 1) _,_ vec( _F_ 2) _, ...,_ vec( _Fm_ )]. The constraint _F_ ( _y_ ) = _X_ is now defined by _Ly_ + _c_ = _x_ , a linear combination of vectors, rather than a linear combination of matrices. We substitute the constraint into (13), 

**==> picture [241 x 25] intentionally omitted <==**

A closed-form solution to (14) can be computed by setting the gradient of the objective to 0. This gives the closed-form projection. 

**==> picture [204 x 43] intentionally omitted <==**

The alternating projection proposed can be summarized as a decomposition of the projection onto _C_ into two subprojections that are efficiently computable in closed form. In practice, we exploit the symmetry of _X_ to solve for 

only _n_ ( _n_ + 1) _/_ 2 auxiliary variables, using a weighted matrix for the projection Π _C_ 1 such that the projection is computed with respect to the Frobenius norm of the full matrix _X_ as in Equation (14). The projection layer here is backbone-agnostic, meaning it can be used with any neural network backbone to enforce LMI constraints. Algorithm 1 describes the end-to-end constraint enforcement procedure using Douglas-Rachford. 

## **Algorithm 1** Neural Network with LMI Constraint Enforcement Forward Pass 

**Input:** _ξ_ , _n_ iter, _σ_ , _θ_ **Output:** _y[∗]_ 

**==> picture [240 x 95] intentionally omitted <==**

## _D. Backpropagation via Implicit Differentiation_ 

To compute gradients during training, we use an implicit differentiation scheme, introduced in [5], to avoid differentiating through all _n_ iter iterations of the Douglas-Rachford algorithm. The gradients of the neural network output _y_ ˆ _θ_ with respect to the parameters _θ_ can be computed with standard backpropagation approaches, so we focus on the computation of gradients through the Douglas-Rachford operation. That is, we seek an efficient computation for 

**==> picture [191 x 24] intentionally omitted <==**

We follow the approach in [5], leveraging the implicit function theorem to efficiently compute the vector-Jacobian product (VJP) with the Jacobian in (16). We are specifically interested in calculating the VJP 

**==> picture [242 x 61] intentionally omitted <==**

Since Π _C_ 1 is linear in both _z_ and _y_ ˆ _θ_ , its gradients with respect to _zn_ iter and _y_ ˆ _θ_ are straightforward to compute. We focus on computing the VJP 

**==> picture [58 x 24] intentionally omitted <==**

Computing _∂zk/∂y_ ˆ _θ_ in general requires differentiation through each iteration of the Douglas-Rachford algorithm, since _zk_ +1(ˆ _yθ_ ) = Φ( _zk_ (ˆ _yθ_ ) _,_ ˆ _yθ_ ), with Φ being a single Douglas-Rachford iteration. This problem is avoided at the fixed point _z[⋆]_ where _z[⋆]_ (ˆ _yθ_ ) = Φ( _z[⋆]_ (ˆ _yθ_ ) _,_ ˆ _yθ_ ). The implicit function theorem therefore gives 

**==> picture [195 x 26] intentionally omitted <==**

Note that since _z[⋆]_ is computationally intractable, we evaluate _[∂] ∂z_[Φ][at] _[ z][n]_[iter][in practice. We could solve this linear system] _∂z_ to isolate ˆ[but][that][adds][unnecessary][computational] _∂yθ_[,] _[∂z]_ burden, since we are more interested in the VJP _v[T] ∂y_ ˆ _θ_[.][We] instead define a vector _λ_ that is the solution to the linear system 

**==> picture [189 x 25] intentionally omitted <==**

This gives the following VJP of interest. 

**==> picture [159 x 23] intentionally omitted <==**

This strategy of computing gradients through the projection layer via implicit differentiation, rather than considering every iteration in Algorithm 1, provides an efficient backpropagation scheme for training. 

## IV. CONVERGENCE ANALYSIS 

In this section, we show that the LMI-Net alternating projection satisfies standard Douglas-Rachford assumptions and therefore converges to a point that satisfies the LMI constraint. 

_Lemma 1 (Eigenvalue clipping as a Euclidean projection):_ For a symmetric matrix _X_[¯] with eigendecomposition _U_ Λ _U[T]_ , the eigenvalue clipping operation _U_ max(0 _,_ Λ) _U[T]_ is the Euclidean projection onto the positive semidefinite cone. 

_Proof:_ The Euclidean projection onto the positive semidefinite cone is 

**==> picture [156 x 18] intentionally omitted <==**

where S+ denotes the set of all real symmetric positive semidefinite matrices. Note that for a symmetric matrix, the eigenvector matrix _U_ is unitary (i.e., _U[T] U_ = _I_ ). The Frobenius norm is unitarily invariant, which gives 

**==> picture [239 x 36] intentionally omitted <==**

Define _W_ = _U[T] XU_ . When _X_ is positive semidefinite, _W_ is too. To see this, consider _z[T] Wz_ = _z[T] U[T] XUz_ = _z_ ¯ _[T] Xz_ ¯ with _z_ ¯ = _Uz_ . Clearly, when _X ⪰_ 0, then _W ⪰_ 0. The Euclidean projection can then be written as _X[∗]_ = _UW[∗] U[T]_ , where 

**==> picture [208 x 81] intentionally omitted <==**

The optimal _W_ is therefore diagonal. To see this, consider _D_ = diag ([ _W_ 11 _, W_ 22 _, . . . , Wnn_ ]). When _W ⪰_ 0, its 

diagonals are nonnegative, so _D ⪰_ 0. _D_ never gives a larger objective value than _W_ , since the off-diagonals can only increase the objective. Therefore, the optimal _W_ will be diagonal, giving the new objective 

**==> picture [193 x 22] intentionally omitted <==**

where _λ_ and _w_ are the diagonal elements of Λ and _W_ , respectively. Clearly, this objective is minimized with the clipping operator _w_ = max(0 _, λ_ ). This gives _X[∗]_ = _UW[∗] U[T]_ = _U_ max(0 _,_ Λ) _U[T]_ , which is equivalent to the eigenvalue clipping operation. 

_Remark 1 (On the symmetry of X_[¯] _):_ Lemma 1 requires that _X_[¯] is symmetric. That is, the input into the projection onto _C_ 2, defined by (11), must be symmetric. The alternating nature of the Douglas-Rachford algorithm means the projection onto _C_ 1, defined in (15), should output a symmetric _X_ . The projection Π _C_ 1 is guaranteed to output a symmetric _x_ because it satisfies the constraint _F_ ( _y_ ) = _X_ by design. _F_ ( _y_ ) is defined in (1) to be a linear combination of symmetric matrices, so _X_ is symmetric by design. 

_Theorem 1:_ Assume _C_ 1, _C_ 2 are closed, nonempty, convex sets and _C_ 1 _∩C_ 2 = _∅_ . Then the sequence _zk_ generated by Algorithm 1 converges to a fixed point _z[⋆]_ of the DouglasRachford operator, and the shadow sequence 

**==> picture [73 x 11] intentionally omitted <==**

converges to a point _w[⋆] ∈C_ 1 _∩C_ 2. In particular, the output _y[⋆]_ = Π _m_ ( _w[⋆]_ ) satisfies the LMI condition _F_ ( _y_ ) _⪰_ 0. 

_Proof:_ Since _C_ 1 and _C_ 2 are convex, their indicator functions _IC_ 1( _z_ ) and _IC_ 2( _z_ ) are convex, making the objectives ˆ _f_ ( _z_ ) = _||y − yθ||_[2] + _IC_ 1( _z_ ) and _g_ ( _z_ ) = _IC_ 2( _z_ ) convex. 

By Lemma 1, Π _C_ 2( _z_ ) is the true proximal operator for _g_ ( _z_ ) = _IC_ 2( _z_ ). By definition, Π _C_ 1( _z,_ ˆ _yθ_ ) is the true proximal ˆ operator for _f_ ( _z_ ) = _||y − yθ||_[2] + _IC_ 1( _z_ ). Therefore, Algorithm 1 is exactly an instance of Douglas-Rachford applied to ˆ the problem of minimizing _||y − yθ||_[2] subject to _y ∈C_ 1 _∩C_ 2. The convergence therefore follows from standard DouglasRachford results [20, Corollary 28.3] [21, Corollary 1]. 

## V. NUMERICAL EXPERIMENTS 

We evaluate LMI-Net on two problems for linear systems under disturbance: (i) invariant ellipsoid synthesis and (ii) joint controller and invariant ellipsoid design. For both tasks, we compare LMI-Net against a soft-constrained baseline trained with the same augmented loss described in (21) and against CVXPY/SCS [22] as a solver baseline. The comparison metrics we report are constraint violation, runtime, and closed-loop instability when applicable. For ease of exposition, we provide detailed descriptions of the learning problem formulation under LMI constraints, dataset construction, and hyperparameter choice in the appendix. 

It is worth noting that at inference time, the fixed LMI-Net can be adapted naturally to different Douglas-Rachford (DR) iterations. The number of DR iterations, therefore, provides 

a practical tuning parameter that trades off feasibility with computation speed, as the algorithm provably converges to a feasible point under increasing iterations. 

## _A. Invariant Ellipsoid Synthesis_ 

We first evaluate the disturbed linear-system invariant ellipsoid synthesis problem introduced in Section II-C. We test on the training distribution and on two out-of-distribution testing datasets: OOD-SLOW, which moves eigenvalues closer to the imaginary axis and therefore has slower dynamics; OOD-LARGE, which increases the magnitude of the disturbance. Table I reports violation fractions, and Table II reports runtime. 

The soft-constrained baseline degrades significantly in feasibility under distribution shift, with violation rates of 94.4% on OOD-SLOW and 77.7% on OOD-LARGE. In contrast, LMI-Net improves strict constraint satisfaction monotonically as more DR iterations are used at inference time. At 2000 iterations, violations are already zero on TRAIN and OOD-SLOW. With 4000 iterations, LMI-Net matches CVXPY feasibility on all three datasets, while remaining 9-35 _×_ faster than CVXPY/SCS. These results show that the hard-constrained approach in LMI-Net substantially improves out-of-distribution feasibility while preserving fast inference. 

TABLE I 

CONSTRAINT VIOLATION FRACTION ON TRAINING AND TESTING SETS 

|Method|TRAIN|OOD-SLOW|OOD-LARGE|
|---|---|---|---|
|Soft constrained model|12.0%|94.4%|77.7%|
|LMI-Net (DR 500)|12.9%|2.8%|26.0%|
|LMI-Net (DR 1000)|4.9%|1.4%|12.7%|
|LMI-Net (DR 2000)|**0.0%**|**0.0%**|2.7%|
|LMI-Net (DR 3000)|**0.0%**|**0.0%**|0.3%|
|LMI-Net (DR 4000)|**0.0%**|**0.0%**|**0.0**%|
|CVXPY/SCS|0.0%|0.0%|0.0%|



TABLE II 

COMPUTATION TIME COMPARISON (MS/SAMPLE) 

|Method|TRAIN|OOD-SLOW|OOD-LARGE|
|---|---|---|---|
|Soft constrained model|0.2|0.6|0.1|
|LMI-Net (DR 500)|0.8|5.3|1.4|
|LMI-Net (DR 1000)|0.7|4.6|1.1|
|LMI-Net (DR 2000)|1.0|5.7|1.6|
|LMI-Net (DR 3000)|1.1|5.8|1.5|
|LMI-Net (DR 4000)|1.5|7.6|2.1|
|CVXPY/SCS|53.3|72.0|56.8|



## _B. Joint Controller and Invariant Ellipsoid Design_ 

We next consider joint synthesis of a stabilizing feedback controller and an invariant ellipsoid for a disturbed linear system. We test on the training distribution and an out-ofdistribution (OOD) testing dataset, which increases the magnitude of unstable eigenvalues in the open-loop dynamics. Tables III and IV report violation rate, closed-loop instability, and runtime on the training and OOD datasets, respectively. 

The soft-constrained baseline fails to satisfy the LMI constraint, and can destabilize the system, especially on OOD samples, where 79.2% of predictions are infeasible and 56.7% produce unstable closed-loop dynamics. LMI-Net eliminates closed-loop instability with 1000 DR iterations on both datasets, and continues to improve feasibility as the number of inference-time DR iterations increases. Figure 1 further illustrates this contrast on a representative OOD sample: LMI-Net produces a stabilizing controller whose trajectories remain within the certified invariant ellipsoid, while the soft-constrained model outputs a destabilizing gain. 

On the training set, LMI-Net reaches zero violations at 3000 iterations while remaining 3.5 _×_ faster than CVXPY/SCS. On the OOD set, its violation percentage drops from 14.6% at 500 iterations to 3.4% at 4000 iterations. These observations validate the practical advantage of the LMI-Net, where the number of DR iterations serves as a tunable speed-feasibility tradeoff parameter. 

## TABLE III 

PERFORMANCE COMPARISON ON THE TRAINING DATASET 

|Method|violation %|CL unstable %|ms/sample|
|---|---|---|---|
|Soft constrained model|46.6%|3.2%|0.003|
|LMI-Net (DR 500)|3.2%|**0.0%**|0.208|
|LMI-Net (DR 1000)|1.2%|**0.0%**|0.414|
|LMI-Net (DR 2000)|0.6%|**0.0%**|0.826|
|LMI-Net (DR 3000)|**0.0%**|**0.0%**|1.234|
|LMI-Net (DR 4000)|**0.0%**|**0.0%**|1.638|
|CVXPY (SCS)|**0.0%**|**0.0%**|4.290|



## TABLE IV 

PERFORMANCE COMPARISON ON THE OUT-OF-DISTRIBUTION DATASET 

|Method|violation %|CL unstable %|ms/sample|
|---|---|---|---|
|Soft constrained model|79.2%|56.7%|0.006|
|LMI-Net (DR 500)|14.6%|0.6%|0.331|
|LMI-Net (DR 1000)|9.0%|**0.0%**|0.661|
|LMI-Net (DR 2000)|5.6%|**0.0%**|1.317|
|LMI-Net (DR 3000)|4.5%|**0.0%**|1.973|
|LMI-Net (DR 4000)|3.4%|**0.0%**|2.628|
|CVXPY (SCS)|**0.0%**|**0.0%**|5.067|



**==> picture [253 x 124] intentionally omitted <==**

Fig. 1. Our proposed LMI-Net with 3000 DR iterations during evaluation jointly learned a stabilizing feedback controller and an invariant ellipsoid, while the soft-constrained model outputs a feedback gain that results in an unstable closed-loop system. 

## VI. CONCLUSIONS 

We introduced LMI-Net, a modular differentiable projection layer that turns a standard neural network into a feasibleby-construction model that satisfies linear matrix inequality (LMI) constraints. By decomposing the LMI-constrained set into an affine constraint and a positive semidefinite cone, we leveraged Douglas-Rachford (DR) splitting to design an iterative forward pass and an efficient backward pass through implicit differentiation. We provide theoretical results that establish formal convergence guarantees as the number of DR iterations increases. In the numerical experiments based on classical LMI reformulations, LMI-Net substantially reduced constraint violation instances and improved closedloop stability compared to soft-constrained models, while retaining lower computation cost over solving each semidefinite program from scratch. The experiments also highlight a practical advantage of the LMI-Net design, where DR iterations provide a simple knob for trading computation for tighter feasibility without retraining. Future work includes scaling to higher-dimensional problems with advanced backbone architectures and extending the framework to practical control tasks such as tube MPC and contraction-metric-based controller synthesis. 

## APPENDIX 

## _Soft-constrained Approaches for LMI-constrained Learning_ 

Current soft-constrained approaches incorporate a regularization term that penalizes constraint violation, an example of which is outlined in the following optimization problem. 

**==> picture [206 x 58] intentionally omitted <==**

Here, _λ_ min( _·_ ) is the minimum eigenvalue of the matrix, and _β_ soft _>_ 0 is a weighting parameter. This approach cannot provide guarantees of constraint satisfaction, especially on _ξ_ values outside the training distributions. 

## _Additional Details in Numerical Experiments_ 

We provide implementation details of numerical experiments in this section. In both experiments, the softconstrained baseline and LMI-Net use the same two-layer MLP backbone with 64 neurons per layer and ReLU activations, and both are trained with the augmented loss in (21) with _β_ soft = 100. At inference time, the LMI-Net (fixed after training) is run with _{_ 500 _,_ 1000 _,_ 2000 _,_ 3000 _,_ 4000 _}_ DouglasRachford (DR) iterations to study the runtime-feasibility tradeoff without retraining. 

## _Invariant ellipsoid problem_ 

We use the linear system under disturbance, introduced in Section II-C, with _nx_ = 2, _nw_ = 1, and fixed _α_ = 0 _._ 1. When creating the datasets, each matrix _A_ is generated as 

**==> picture [101 x 13] intentionally omitted <==**

where _λi ∼_ Uniform( _−λ_ max _, −λ_ min) and _U_ is drawn uniformly from the orthogonal group. Each entry of _Bw_ is sampled independently from _N_ (0 _, σB_[2] _w_[)][.] 

The training distribution uses ( _λ_ min _, λ_ max _, σBw_ ) = (0 _._ 5 _,_ 5 _._ 0 _,_ 1 _._ 0). For the two out-of-distribution (OOD) testing sets, OOD-SLOW is generated with (0 _._ 05 _,_ 0 _._ 5 _,_ 1 _._ 0), and OOD-LARGE with (0 _._ 5 _,_ 5 _._ 0 _,_ 3 _._ 0). 

The network maps the flattened input ( _A, Bw_ ) to the upper-triangular entries of _P_ . The objective _c_ in (2a) is defined as _−_ log det( _P_ ), which would minimize the volume of the invariant ellipsoid. Both models are trained with Adam for 500 epochs. For LMI-Net, we use _σ_ = 0 _._ 1 and 500 DR iterations during training. A sample is counted towards constraint violation when the maximum eigenvalue of the LMI residual in the left-hand side of (5) is positive. 

## _Joint controller and invariant ellipsoid problem_ 

We consider a linear system with control input under bounded disturbance, assuming that ( _A, B_ ) is stabilizable: 

**==> picture [203 x 11] intentionally omitted <==**

The goal is to jointly design a feedback gain _K_ and an invariant ellipsoid _{x_ : _x[⊤] Px ≤_ 1 _}_ under the control law _u_ = _Kx_ . Following the reformulation in [1], using the change of variables _Q_ = _P[−]_[1] and _Y_ = _KQ_ , the problem can be reduced to the following LMI: 

**==> picture [244 x 33] intentionally omitted <==**

with _ε_ = 10 _[−]_[3] , and the fixed S-procedure parameter _α_ = 0 _._ 1. The two constraints are combined into a single blockdiagonal LMI. After solving for ( _Q, Y_ ), the controller is recovered as _K_ = _Y Q[−]_[1] and the invariant ellipsoid as _E_ ( _Q_ ) = _{x_ : _x[⊤] Q[−]_[1] _x ≤_ 1 _}_ . 

Each sample in the training and testing datasets is a tuple ( _A, B, Bw_ ). Both matrices _B ∈_ R[2] _[×]_[1] and _Bw ∈_ R[2] _[×]_[1] are filled with entries drawn from _N_ (0 _,_ 1), same for both training and testing sets. Each eigenvalue magnitude in matrix _A ∈_ R[2] _[×]_[2] , _|λi|_ , is drawn uniformly from [ _λ_ min _, λ_ max], and its sign is assigned differently in the training set and testing set. The training set draws each eigenvalue magnitude uniformly from [0 _._ 1 _,_ 1 _._ 0], then assigns a positive sign to each eigenvalue with 50% probability independently. The out-of-distribution (OOD) test set shifts to eigenvalue magnitudes in [0 _._ 3 _,_ 1 _._ 5] with all samples having one unstable eigenvalue. We filter out the samples within these datasets where ( _A, B_ ) are not stabilizable. 

The neural network maps the flattened input (vech( _A_ ) _,_ vec( _B_ ) _,_ vec( _Bw_ )) _∈_ R[7] to the decision variables (vech( _Q_ ) _,_ vec( _Y_ )) _∈_ R[5] . The objective _c_ in (2a) is chosen as log det( _Q_ ), which minimizes the invariant ellipsoid volume. We train both the soft-constrained model and our LMI-Net with Adam for 1000 epochs on the same training dataset. The LMI-Net is trained with 500 DR iterations and _σ_ = 0 _._ 01. 

The evaluation metric _Violation fraction_ refers to the percentage of samples whose maximum eigenvalue violation 

of the LMI constraint exceeds 0. The metric _CL instability_ refers to the percentage of samples for which _A_ + _BK_ has at least one eigenvalue with a positive real part. The metric _Computation time_ reports the wall-clock milliseconds per sample, evaluated on a workstation with an Intel Ultra 9 285K CPU and an NVIDIA RTX5080 GPU. 

## REFERENCES 

- [1] S. Boyd, L. El Ghaoui, E. Feron, and V. Balakrishnan, _Linear matrix inequalities in system and control theory_ . SIAM, 1994. 

- [2] A. Alessio and A. Bemporad, “A survey on explicit model predictive control,” in _Nonlinear model predictive control: towards new challenging applications_ , pp. 345–369, Springer, 2009. 

- [3] P. Apkarian and H. D. Tuan, “Parameterized LMIs in control theory,” _SIAM journal on control and optimization_ , vol. 38, no. 4, pp. 1241– 1264, 2000. 

- [4] R. Sambharya, G. Hall, B. Amos, and B. Stellato, “End-to-end learning to warm-start for real-time quadratic optimization,” in _Learning for dynamics and control conference_ , pp. 220–234, PMLR, 2023. 

- [5] P. D. Grontas, A. Terpin, E. C. Balta, R. D’Andrea, and J. Lygeros, “Pinet: Optimizing hard-constrained neural networks with orthogonal projection layers,” in _International Conference on Learning Representations (ICLR)_ , 2026. 

- [6] A. Bellon, D. Henrion, V. Kungurtsev, and J. Mareˇcek, “Parametric semidefinite programming: geometry of the trajectory of solutions,” _Mathematics of Operations Research_ , vol. 50, no. 1, pp. 410–430, 2025. 

- [7] C. Dawson, S. Gao, and C. Fan, “Safe control with learned certificates: A survey of neural lyapunov, barrier, and contraction methods for robotics and control,” _IEEE Transactions on Robotics_ , vol. 39, no. 3, pp. 1749–1767, 2023. 

- [8] J. Z. Kolter and G. Manek, “Learning stable deep dynamics models,” _Advances in neural information processing systems_ , vol. 32, 2019. 

- [9] N. Boffi, S. Tu, N. Matni, J.-J. Slotine, and V. Sindhwani, “Learning stability certificates from data,” in _Conference on Robot Learning_ , pp. 1341–1350, PMLR, 2021. 

- [10] S. Tang, T. Sapsis, and N. Azizan, “Learning dissipative chaotic dynamics with boundedness guarantees,” _arXiv preprint arXiv:2410.00976_ , 2024. 

- [11] A. Goertzen, S. Tang, and N. Azizan, “ECO: Energy-constrained operator learning for chaotic dynamics with boundedness guarantees,” _arXiv preprint arXiv:2512.01984_ , 2025. 

- [12] L. Lindemann, H. Hu, A. Robey, H. Zhang, D. Dimarogonas, S. Tu, and N. Matni, “Learning hybrid control barrier functions from data,” in _Conference on robot learning_ , pp. 1351–1370, PMLR, 2021. 

- [13] Y. Min, S. M. Richards, and N. Azizan, “Data-driven control with inherent lyapunov stability,” in _2023 62nd IEEE Conference on Decision and Control (CDC)_ , pp. 6032–6037, IEEE, 2023. 

- [14] N. Rezazadeh, M. Kolarich, S. S. Kia, and N. Mehr, “Learning contraction policies from offline data,” _IEEE Robotics and Automation Letters_ , vol. 7, no. 2, pp. 2905–2912, 2022. 

- [15] H. Tsukamoto, S.-J. Chung, and J.-J. E. Slotine, “Contraction theory for nonlinear stability analysis and learning-based control: A tutorial overview,” _Annual Reviews in Control_ , vol. 52, pp. 135–169, 2021. 

- [16] Y. Min and N. Azizan, “HardNet: Hard-constrained neural networks with universal approximation guarantees,” _arXiv preprint arXiv:2410.10807_ , 2024. 

- [17] J. Tordesillas, J. P. How, and M. Hutter, “RAYEN: Imposition of hard convex constraints on neural networks,” _arXiv preprint arXiv:2307.08336_ , 2023. 

- [18] P.-L. Lions and B. Mercier, “Splitting algorithms for the sum of two nonlinear operators,” _SIAM Journal on Numerical Analysis_ , vol. 16, no. 6, pp. 964–979, 1979. 

- [19] V. A. Yakubovich, “S-procedure in nonlinear control theory,” _Vestnik Leningrad University Mathematics_ , vol. 4, pp. 73–93, 1977. English translation; original Russian publication in _Vestnik Leningradskogo Universiteta, Seriya Matematika_ (1971), pp. 62–77. 

- [20] H. H. Bauschke and P. L. Combettes, “Convex analysis and monotone operator theory in hilbert spaces,” Springer. 

- [21] D. Davis and W. Yin, “Convergence rate analysis of several splitting schemes,” in _Splitting methods in communication, imaging, science, and engineering_ , pp. 115–163, Springer, 2017. 

- [22] S. Diamond and S. Boyd, “CVXPY: A Python-embedded modeling language for convex optimization,” _Journal of Machine Learning Research_ , vol. 17, no. 83, pp. 1–5, 2016. 

