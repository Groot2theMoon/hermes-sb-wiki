---
title: "Contractivity Analysis and Control Design for Lur'e Systems: Lipschitz, Incrementally Sector Bounded, and Monotone Nonlinearities"
arxiv: "2503.20177"
authors: ["Ryotaro Shima", "Alexander Davydov", "Francesco Bullo"]
year: 2025
source: paper
ingested: 2026-05-01
sha256: 397b03c90d0eae77b1d1184f1ef6725c892397cb1c3817a536b280413c9f7f56
conversion: pymupdf4llm
---

# **Contractivity Analysis and Control Design for Lur’e Systems: Lipschitz, Incrementally Sector Bounded, and Monotone Nonlinearities** 

Ryotaro Shima[1] , Alexander Davydov[1] and Francesco Bullo[1] 

_**Abstract**_ **— In this paper, we study the contractivity of Lur’e dynamical systems whose nonlinearity is either Lipschitz, incrementally sector bounded, or monotone. We consider both the discrete- and continuous-time settings. In each case, we provide state-independent linear matrix inequalities (LMIs) which are necessary and sufficient for contractivity. Additionally, we provide LMIs for the design of controller gains such that the closed-loop system is contracting. Finally, we provide a numerical example for control design.** 

## I. INTRODUCTION 

Contraction theory has attracted substantial interest within the nonlinear control community due to its capability to ensure exponential convergence between arbitrary trajectories of nonlinear systems [9], [1]. Beyond traditional stability analysis, contractivity provides significant advantages for the investigation of nonlinear dynamical phenomena, such as synchronization in networked systems [12], [16], design of distributed controllers [13], and enhanced robustness to noise and disturbances [4], [15]. 

Contractivity is typically verified through an inequality condition related to the exponential rate at which the distance between trajectories decreases. For nonlinear systems, however, this inequality is often state-dependent, making its verification challenging. One common solution is the use of a polytopic relaxation, which simplifies the contractivity condition to checking stability at the vertices of a polytope corresponding to linear dynamics [6]. This approach has been successfully applied in contexts such as safety verification [6] and tube-based model predictive control (tube-MPC) [14]. Nonetheless, polytopic relaxation frequently leads to conservative conditions, especially for nonlinearities that are Lipschitz, incrementally sector bounded, or monotone, but not explicitly polytopic. 

Another method involves imposing incremental quadratic constraints on the nonlinearity. The notable early work in [2] presents contractivity conditions assuming that the Lur’e nonlinearity satisfies an incremental inequality constraint. Similar conditions based on monotonicity or Lipschitz continuity have been independently established in [8], [7], [10]. Additionally, [8] and [15] introduce LMIs for designing controllers that guarantee the contractivity of closed-loop systems. More recently, [3] derived necessary and sufficient conditions for contractivity, assuming that the nonlinearity is cocoercive. 

This work was supported in part by AFOSR award FA9550-22-1-0059. 1Ryotaro Shima, Alexander Davydov, and Francesco Bullo are with the Center for Control, Dynamical Systems, and Computation, University of California at Santa Barbara, Santa Barbara, CA 93106 USA. _{_ rshima,davydov,bullo _}_ @ucsb.edu 

_Contributions:_ In this paper, we generalize previous results to obtain unified necessary and sufficient conditions for verifying contractivity in Lur’e systems with Lipschitz, incrementally sector-bounded, and monotone nonlinearities. Extending existing methods from [8], [15], we provide linear matrix inequalities (LMIs) for designing controllers that guarantee closed-loop contractivity. 

Our specific contributions are summarized as follows: 1) In Theorem 1, we introduce an LMI involving the gain matrices and a weighting norm, providing necessary and sufficient conditions for the contractivity of closed-loop systems with Lipschitz nonlinearities. Our LMI generalizes the conditions from [15] by accommodating a broader class of dynamical systems and, notably, proving necessity, whereas previous results established only sufficiency. A detailed comparison is presented in Subsection III-C.1. 

2) We extend the result of Theorem 1 to incrementally sector-bounded and monotone nonlinearities in Theorem 3. Additionally, we demonstrate that monotonicity emerges as a special case of incremental sector boundedness under a mild symmetry assumption. While prior works such as [8] have established only sufficient conditions, our formulation provides both necessity and sufficiency and an explicit estimate of the contractivity rate. 

3) We derive analogous conditions for discrete-time Lur’e systems, obtaining corresponding LMIs to verify contractivity. This result facilitates the direct synthesis and practical implementation of digital controllers. 

4) We provide a concrete example illustrating our proposed controller-design method for a Lipschitz Lur’e system, explicitly demonstrating the applicability of our LMIs to ensure contractivity. 

_Notation:_ We denote the _n_ -dimensional identity matrix by _In_ , the set of positive definite matrices of size _n × n_ by S _[n]_ +[,][the][weighted][Euclidean][norm] _√v[⊤] Pv_ by _∥v∥P_ , where _P ∈_ S _[n]_ +[, and a block-diagonal matrix whose diagonal blocks] are _A_ and _B_ by diag[ _A, B_ ]. _⟨A⟩_ := _A_ + _A[⊤]_ , where _A_ is a square matrix. [ _v_ ; _w_ ] := � _v[⊤] w[⊤]_[�] _[⊤]_ , where _v_ and _w_ are vectors. For symmetric matrices _A, B_ , we say that _A ⪰ B_ if _A − B_ is positive semidefinite. 

## II. PRELIMINARIES 

## _A. Lur’e Dynamics and Its Contraction_ 

Consider the following continuous-time Lur’e system (hereinafter we call CTLS): 

**==> picture [177 x 25] intentionally omitted <==**

**==> picture [177 x 11] intentionally omitted <==**

where _x_ ˙ denotes the time derivative of _x_ , _x ∈_ R _[n][x]_ , _y ∈_ R _[n][y]_ , _u ∈_ R _[n][u]_ , Ψ : R _[n][y] →_ R _[n]_[Ψ] , and _A, B, B_ Ψ _, C, K, K_ Ψ are matrices of appropriate sizes. Hereinafter, we refer to Ψ as a Lur’e nonlinearity. The closed-loop system is in the following continuous-time Lur’e form: 

**==> picture [175 x 25] intentionally omitted <==**

**==> picture [175 x 9] intentionally omitted <==**

_Assumption 1: nx ≥ ny_ and _C ∈_ R _[n][y][×][n][x]_ is row full rank. 

One can always make _C_ row full rank by redefining Ψ. 

_Definition 1 (Contractivity of CTLS):_ Consider _P ∈_ S _[n]_ + _[x]_ and a positive constant _η_ . The CTLS (1) is said to be strongly infinitesimally contracting with respect to norm _∥·∥P_ and rate _η_ if, for any pair of solutions _x_[(1)] ( _t_ ) _, x_[(2)] ( _t_ ) of the CTLS (1), the following inequality holds for any _t ≥ s ≥_ 0: 

**==> picture [240 x 13] intentionally omitted <==**

_Remark 1:_ The CTLS (1) is strongly infinitesimally contracting with respect to norm _∥· ∥P_ and rate _η_ if and only if the following inequality holds for all _x_[(1)] _, x_[(2)] _∈_ R _[n][x]_ : 

**==> picture [237 x 29] intentionally omitted <==**

In addition, suppose Ψ is differentiable. Then, (6) hold if and only if the following inequality holds for all _x ∈_ R _[n][x]_ : 

**==> picture [205 x 23] intentionally omitted <==**

See [5, Theorem 29]) for these equivalences. 

In parallel, we consider the following discrete-time Lur’e system (hereinafter we call DTLS): 

**==> picture [180 x 12] intentionally omitted <==**

**==> picture [173 x 10] intentionally omitted <==**

**==> picture [174 x 10] intentionally omitted <==**

where _x_[+] denotes _x_ at the next time step. The dynamics can be rewritten in the following discrete-time Lur’e form: 

**==> picture [175 x 12] intentionally omitted <==**

where _A_ cl and _B_ cl are defined as in (3) and (4), respectively. 

_Definition 2 (Contractivity of DTLS):_ Consider _P ∈_ S _[n]_ + _[x]_ and a constant 0 _≤ η <_ 1. The DTLS (9) is said to be strongly contracting with respect to norm _∥· ∥P_ and factor _η_ if, for any pair of solutions _x_[(1)] ( _k_ ) _, x_[(2)] ( _k_ ) of the DTLS (9), the following inequality holds for any _k ≥ ℓ ≥_ 0: 

**==> picture [236 x 13] intentionally omitted <==**

_Remark 2:_ The DTLS (9) is strongly contracting with respect to norm _∥·∥P_ and factor _η_ if and only if the following inequality holds for all _x_[(1)] _, x_[(2)] _∈_ R _[n][x]_ : 

**==> picture [221 x 28] intentionally omitted <==**

**==> picture [239 x 13] intentionally omitted <==**

In addition, suppose Ψ is differentiable. As in the CTLS, (12) holds if and only if the following inequality holds for all _x ∈_ R _[n][x]_ : 

**==> picture [238 x 37] intentionally omitted <==**

See [1, Theorem 3.7] for these equivalences. 

In this paper, we discuss how to design the gain matrices _K, K_ Ψ with which the closed-loop system is contracting. The difficulty in such gain design lies in the fact that (6) ((8), (12), or (14)) must be satisfied throughout the space of R _[n][x]_ due to the nonlinearity Ψ. To address this, we impose a nonlinearity condition on Ψ. 

## _B. Nonlinearity Conditions_ 

In this paper, we consider three types of conditions on the Lur’e nonlinearity: Lipschitzness, incremental sector boundedness, and monotonicity. 

_Definition 3 (Lipschitzness):_ Let Θ _y ∈_ S _[n]_ + _[y][,]_[ Θ][Ψ] _[∈]_[S] _[n]_ +[Ψ][.] A function Ψ: R _[n][y] →_ R _[n]_[Ψ] is said to be _ρ_ -Lipschitz with input norm _∥· ∥_ Θ _y_ and output norm _∥· ∥_ ΘΨ if the following inequality holds for each _y_[(1)] _, y_[(2)] _∈_ R _[n][y]_ : 

**==> picture [190 x 13] intentionally omitted <==**

where ∆ _y_ := _y_[(1)] _− y_[(2)] , ∆ _y_ Ψ := Ψ( _y_[(1)] ) _−_ Ψ( _y_[(2)] ). 

_Remark 3:_ If Ψ is differentiable, then Ψ is _ρ_ -Lipschitz with input norm _∥· ∥_ Θ _y_ and output norm _∥· ∥_ ΘΨ if and only if for all _y ∈_ R _[n][y]_ , the following inequality holds, 

**==> picture [187 x 24] intentionally omitted <==**

_Definition 4 (incremental sector boundedness):_ Consider Θ _∈_ S _[n]_ +[Ψ][,][Γ] _[∈]_[R] _[n][y][×][n]_[Ψ][,][and][a][function][Ψ][:][R] _[n][y][→]_[R] _[n]_[Ψ][.] Ψ is said to be incrementally sector bounded with sector bound [0 _,_ Γ] and weight Θ if the following inequality holds for all _y_[(1)] _, y_[(2)] _∈_ R _[n][y]_ : 

**==> picture [181 x 13] intentionally omitted <==**

where ∆ _y_ := _y_[(1)] _− y_[(2)] and ∆ _y_ Ψ := Ψ( _y_[(1)] ) _−_ Ψ( _y_[(2)] ). Similarly, Ψ is said to be differentially sector bounded with sector bound [0 _,_ Γ] and weight Θ if the following inequality holds for all _y ∈_ R _[n][y]_ : 

**==> picture [199 x 23] intentionally omitted <==**

_Remark 4:_ The differential sector boundedness in the above definition is addressed in [8]. Furthermore, the incremental sector boundedness with sector bound [0 _, β_[1] _[I]_[]][,] _[ β][>]_[ 0][,] and weight Θ = _I_ is called cocoerciveness [11], [3]. 

_Definition 5 (monotonicity):_ Suppose _ny_ = _n_ Ψ. Let Γ _∈_ S _[n]_ +[Ψ][.][A][differentiable][function][Ψ][:][R] _[n]_[Ψ] _[→]_[R] _[n]_[Ψ][is][said][to] be monotone with upper bound Γ if the following property holds for all _y ∈_ R _[n][y]_ : 

**==> picture [199 x 25] intentionally omitted <==**

The monotonicity in the above definition is considered in [8]. We will later prove that monotonicity with an upper bound is a special case of the incremental sector boundedness under the following assumption. 

_Assumption 2:_ The derivative of Ψ is symmetric, i.e., 

**==> picture [194 x 24] intentionally omitted <==**

Note that [8] has also assumed (20) to derive an LMI for controller design. Many functions, such as an element-wise activation function, a log-sum-exp function, and the gradient of scalar functions, satisfy (20). 

## III. MAIN RESULTS 

In this section, we provide contraction analysis of the Lur’e systems and LMIs for controller design which guarantees closed-loop contractivity. In Subsection III-A, we present our results for Lipschitz Lur’e nonlinearity. In Subsection III-B, we present the counterpart for incrementally sector bounded or monotone Lur’e nonlinearity, together with a lemma claiming that the monotonicity is a special case of the incremental sector boundedness under Assumption 2. Our LMI is compared with that of literature in Subsection III-C. 

Note that statement 2) in each theorem provides an LMI with respect to _W, Z, K_ Ψ. Using a feasible solution ( _W, Z, K_ Ψ) of the LMI, we obtain controller gains _K_ and _K_ Ψ in (1c) (or (9c)) where _K_ = _ZW[−]_[1] . In addition, our matrix inequalities are necessary and sufficient for contractivity under each Lur’e nonlienarity. 

## _A. Contraction under Lipschitzness of Lur’e nonlinearity_ 

_Theorem 1 (Continuous-time Lipschitz Lur’e models):_ Consider the CTLS (1) with Assumption 1. Let _A_ cl as in (3), _B_ cl as in (4), Θ _y ∈_ S _[n]_ + _[y]_[,][Θ][Ψ] _[∈]_[S] _[n]_ +[Ψ][,][and] _[η]_[be][a] positive constant. Suppose _B_ cl = 0. Then, the following three statements are equivalent: 

**==> picture [236 x 42] intentionally omitted <==**

**==> picture [157 x 12] intentionally omitted <==**

**==> picture [211 x 48] intentionally omitted <==**

where _W_ := _P[−]_[1] _, Z_ := _KP[−]_[1] _, B_ cl = _B_ Ψ + _BK_ Ψ. 

- 3) There exists _P ∈_ S _[n]_ + _[x]_ such that the CTLS (1) is strongly infinitesimally contracting with norm _∥· ∥P_ and rate _η_ for each nonlinearity Ψ that is _ρ_ -Lipschitz with input norm _∥· ∥_ Θ _y_ and output norm _∥· ∥_ ΘΨ. 

- The proof of Theorem 1 is shown in Appendix A. 

_Theorem 2 (Discrete-time Lipschitz Lur’e models):_ 

Consider the DTLS (9) with Assumption 1. Let _A_ cl as in (3), _B_ cl as in (4), Θ _y ∈_ S _[n]_ + _[y]_[,][Θ][Ψ] _[∈]_[S] _[n]_ +[Ψ][,][and] _[η]_[be][a][positive] constant satisfying 0 _< η <_ 1. Then, the following three statements are equivalent: 

**==> picture [235 x 139] intentionally omitted <==**

where _W_ := _P[−]_[1] _, Z_ := _KP[−]_[1] _, B_ cl = _B_ Ψ + _BK_ Ψ. 

- 3) There exists _P ∈_ S _[n]_ + _[x]_ such that the system (10) is strongly contracting with norm _∥· ∥P_ and factor _η_ for each nonlinearity Ψ that is _ρ_ -Lipschitz with input norm _∥· ∥_ Θ _y_ and output norm _∥· ∥_ ΘΨ. 

The proof of Theorem 2 is shown in Appendix B. 

_B. Contraction under incremental sector boundedness or monotonicity of Lur’e nonlinearity_ 

_Lemma 1:_ Consider a function Ψ : R _[n]_[Ψ] _→_ R _[n]_[Ψ] satisfying Assumption 2. Let Γ _∈_ S _[n]_ +[Ψ][.][Then,][Ψ][is][monotone][with] an upper bound Γ if and only if Ψ is differentially sector bounded with sector bound [0 _,_ Γ] and weight Γ _[−]_[1] . 

The proof of Lemma 1 is shown in Appendix C. 

_Theorem 3 (Continuous-time sector-bounded Lur’e models):_ Consider the CTLS (1) with Assumption 1. Let _A_ cl as in (3), _B_ cl as in (4), Θ _∈_ S _[n]_ +[Ψ][,][Γ] _[∈]_[R] _[n][y][×][n]_[Ψ][,] _[G]_[:=] _[C][⊤]_[Γ] _[⊤]_[Θ][,] and _η_ be a positive constant. Then, the following three statements are equivalent: 

- 1) There exists _P ∈_ S _[n]_ + _[x]_[that][satisfies] 

**==> picture [182 x 25] intentionally omitted <==**

- 2) There exists _P ∈_ S _[n]_ + _[x]_[that][satisfies] 

**==> picture [206 x 25] intentionally omitted <==**

where _W_ := _P[−]_[1] _, Z_ := _KP[−]_[1] _, B_ cl = _B_ Ψ + _BK_ Ψ. 3) There exists _P ∈_ S _[n]_ + _[x]_ such that the CTLS (1) is strongly infinitesimally contracting with norm _∥· ∥P_ and rate _η_ for each nonlinearity Ψ that is incrementally sector bounded with sector bound [0 _,_ Γ] and weight Θ. Furthermore, if Ψ is differentiable, the above three statements are equivalent to the following statement. 

- 4) There exists _P ∈_ S _[n]_ + _[x]_ such that the CTLS (1) is strongly infinitesimally contracting with norm _∥· ∥P_ and rate _η_ for each nonlinearity Ψ that is differentially sector bounded with sector bound [0 _,_ Γ] and weight Θ. 

- Moreover, suppose _ny_ = _n_ Ψ, Γ _∈_ S _[n]_ + _[y]_[,][and][Θ = Γ] _[−]_[1][.][Then,] under Assumption 2, the above four statements are equivalent to the following statement as well. 

- 5) There exists _P ∈_ S _[n]_ + _[x]_ such that the CTLS (1) is strongly infinitesimally contracting with norm _∥· ∥P_ 

and rate _η_ for each nonlinearity Ψ that is monotone with upper bound Γ. 

The proof of Theorem 3 is shown in Appendix D. 

_Theorem 4 (Discrete-time sector-bounded Lur’e models):_ Consider the DTLS (9) with Assumption 1. Let _A_ cl as in (3), _B_ cl as in (4), Θ _∈_ S _[n]_ +[Ψ][,][Γ] _[∈]_[R] _[n][y][×][n]_[Ψ][,] _[G]_[:=] _[C][⊤]_[Γ] _[⊤]_[Θ][,][and] _η_ be a constant satisfying 0 _< η <_ 1. Let _G_ := _C[⊤]_ Γ _[⊤]_ Θ. Then, the following three statements are equivalent: 

1) There exists _P ∈_ S _[n]_ + _[x]_[that][satisfies] 

**==> picture [203 x 25] intentionally omitted <==**

2) There exists _P ∈_ S _[n]_ + _[x]_[that][satisfies] 

**==> picture [210 x 37] intentionally omitted <==**

where _W_ := _P[−]_[1] _, Z_ := _KP[−]_[1] _, B_ cl = _B_ Ψ + _BK_ Ψ. 

- 3) There exists _P ∈_ S _[n]_ + _[x]_ such that the DTLS (9) is strongly contracting with norm _∥· ∥P_ and factor _η_ for each nonlinearity Ψ that is incrementally sector bounded with sector bound [0 _,_ Γ] and weight Θ. 

Furthermore, if Ψ is differentiable, the above two statements are equivalent to the following statement as well. 

- 4) There exists _P ∈_ S _[n]_ + _[x]_ such that the DTLS (9) is strongly contracting with norm _∥· ∥P_ and factor _η_ for each nonlinearity Ψ that is differentially sector bounded with sector bound [0 _,_ Γ] and weight Θ. 

- Moreover, suppose _ny_ = _n_ Ψ, Γ _∈_ S _[n]_ + _[y]_[,][and][Θ][=][Γ] _[−]_[1][.] Then, under Assumption 2, the above three statements are equivalent to the following statement as well. 

- 5) There exists _P ∈_ S _[n]_ + _[x]_ such that the DTLS (9) is strongly contracting with norm _∥· ∥P_ and factor _η_ for each nonlinearity Ψ that is monotone with upper bound Γ. 

The proof of Theorem 4 is shown in Appendix E. 

## _C. Comparison with LMIs in other literature_ 

## _1) Lipschitz case:_ 

_Lemma 2:_ Suppose _nx_ = _ny_ = _n_ Ψ _, B_ Ψ = _C_ = Θ _y_ = ΘΨ = _Inx, K_ Ψ = 0, Θ _y_ = ΘΨ = _Inx_ . Then, the following matrix inequality is sufficient for (22): 

**==> picture [190 x 11] intentionally omitted <==**

_Proof:_ Substitution of _B_ Ψ = _C_ = Θ _y_ = ΘΨ = _Inx_ and _K_ Ψ = 0 into (22) leads to the following inequality: 

**==> picture [229 x 38] intentionally omitted <==**

By taking the Schur complement of the lower right 2 _×_ 2 block in the left hand side of (30), we observe that (30) is equivalent to the following matrix inequality: 

**==> picture [179 x 12] intentionally omitted <==**

Young’s inequality implies 2 _ρW ⪯ Inx_ + _ρ_[2] _WC[⊤] CW_ . Therefore, (30) implies (29). 

[15, Lemma 1] claims that robust invariance against an upper-bounded disturbance _w_ is guaranteed by the exponential stability of the error system (i.e., strong infinitesimal contractivity), and an LMI for the controller design that guarantees the contractivity of the closed-loop system is provided in the upper left part of (14) in [15]. Notably, Lemma 2 tells us that the LMI in [15] is a special case of the LMI (22) in Theorem 1. In fact, the negative semidefiniteness of the upper left block of (14) in [15] is identical to (29) if the Lipschitz constant _L_ (see (11) in [15]) is renamed as _ρ_ and contraction rate (see (6) in [15]) is redefined as 2 _η_ and if we select a constant _λ_ 0 as 2( _η_ + _ρ_ ). 

_2) Incremental sector bounded and monotone case:_ Propositions 1 and 2 in [8] have shown that (25) is sufficient for the contractivity (under a slightly different definition) under the assumption that the Lur’e nonlinearity is differentially sector bounded or monotone, respectively. Theorem 3 also claims the converse. In addition, Lemma 1 claims that monotonicity is a special case of differential sector boundedness. 

IV. EXAMPLE OF CONTROLLER DESIGN 

Consider the DTLS (9) with the following _A, B, B_ Ψ _, C_ : 

**==> picture [237 x 64] intentionally omitted <==**

We design gain matrices _K_ = � _k_ 1 _k_ 2 _k_ 3� _, K_ Ψ _∈_ R. Suppose that the Lur’e nonlinearity Ψ is _ρ_ -Lipschitz with _ρ_ = 0 _._ 5, Θ _y_ = diag[4 _,_ 1], ΘΨ = 1. Note that _B_ Ψ+ _BK_ Ψ = 0 for all _K_ Ψ _∈_ R. 

Let _η_ = 0 _._ 9. Then, _W_ = diag[0 _._ 1 _,_ 0 _._ 05 _,_ 0 _._ 2] _, Z_ = � _−_ 0 _._ 6 _−_ 0 _._ 03 0 _._ 3� _, K_ Ψ = _−_ 1 is a feasible solution of LMI (24) in Theorem 2, which leads to _K_ = � _−_ 6 _−_ 0 _._ 6 1 _._ 5[�] . Thus, we obtain the controller (9c) which guarantees the closed-loop contractivity. To show that the closed-loop system is strongly contracting with these gains, we select three initial states _x_[(1)] (0) = [1; 1; 1] _, x_[(2)] (0) = [ _−_ 1; _−_ 1; _−_ 1]. As examples of Lipschitz nonlinearity, we select Ψ(1)( _x_[(1)] _, x_[(2)] ) = 101[log(exp(5] _[x]_[2][)+] exp( _−_ 5 _x_ 2)) + 7, Ψ(2)( _x_ 1 _, x_ 2) = 0 _._ 5 _/_ (1 + exp(0 _._ 5 _x_ 1 _− x_ 2)) _−_ 5, Ψ(3)( _x_ 1 _, x_ 2) = 0 _._ 5 cos(0 _._ 5 _x_ 1) sin( _x_ 2). For each Lur’e nonlinearity and initial condition, we calculate the trajectories _x_ ( _k_ ) for _k_ = 1 _, . . . ,_ 10 according to (9). 

Each trajectory of the first state _x_ 1( _k_ ) for each initial condition _x_[(] _[i]_[)] (0) _, i_ = 1 _,_ 2 and Lur’e nonlinearity Ψ( _a_ ) _, a_ = 1 _,_ 2 _,_ 3 is depicted in Fig. 1, where the solid lines represent the trajectories for the initial condition _x_[(1)] (0) and the dashed lines for _x_[(2)] (0), while the blue lines represent the trajectories for nonlinearity Ψ(1), the red lines for Ψ(2), and the green lines for Ψ(3). It shows that trajectories of _x_ 1 with initial states _x_[(1)] (0) _, x_[(2)] (0) converge to the same value for each nonlinearity. In addition, we evaluate 

**==> picture [221 x 162] intentionally omitted <==**

**----- Start of picture text -----**<br>
i  = 1 , a  = 1 i  = 2 , a  = 1<br>i  = 1 , a  = 2 i  = 2 , a  = 2<br>i  = 1 , a  = 3 i  = 2 , a  = 3<br>1<br>0<br>− 1<br>0 1 2 3 4 5 6 7 8 9 10<br>time step k<br>)<br>k<br>(<br>1<br>x<br>**----- End of picture text -----**<br>


Fig. 1. Trajectories of _x_ 1 for each nonlinearity and initial condition. 

the distance _∥x_[(1)] ( _k_ ) _− x_[(2)] ( _k_ ) _∥P_ , where _P_ = _W[−]_[1] = diag[10 _,_ 20 _,_ 5]. The maximum value of the decreasing rate _∥x_[(1)] ( _k_ + 1) _− x_[(2)] ( _k_ + 1) _∥P /∥x_[(1)] ( _k_ ) _− x_[(2)] ( _k_ ) _∥P , k_ = 0 _, . . . ,_ 9 is observed to be 0 _._ 658, which is less than _η_ = 0 _._ 9. 

## V. CONCLUSION 

In this paper, we have proposed LMIs for designing controllers that guarantee contractivity of closed-loop Lur’e systems under Lipschitz, incrementally sector-bounded, and monotone nonlinearities. We demonstrated our approach through a practical example illustrating controller synthesis using the developed LMIs. Our results expand upon previous frameworks, offering both necessary and sufficient conditions, and enabling broader applicability to various classes of nonlinear systems. Potential applications of our contraction-based controller design include tube-based model predictive control (tube-MPC) [15] and proportional-integral (PI) control [8]. Future research directions include further generalizations of incremental quadratic constraints to a wider range of nonlinear dynamics. 

## APPENDIX 

## A. PROOF OF THEOREM 1 

_Proof:_ Schur complement of _− ρ_[1][2][Θ] _[−] y_[1] in the left hand side of (22) leads to the equivalence between (22) and the following inequality: 

**==> picture [230 x 25] intentionally omitted <==**

Upon pre- and post-multiplying this inequality by diag[ _P, I_ ] (which is a congruence transformation and therefore does not lose equivalence), we obtain the equivalence 1) _⇔_ 2). 

To prove the equivalence 1) _⇔_ 3), note that (6) can be reformulated as follows: 

**==> picture [197 x 27] intentionally omitted <==**

where ∆ _x_ and ∆ _x_ Ψ is defined in (7). On the other hand, Assumption 1 implies that, for each _y_[(1)] _, y_[(2)] _∈_ R _[n][y]_ , there exist _x_[(1)] _, x_[(2)] _∈_ R _[n][x]_ satisfying _y_[(1)] = _Cx_[(1)] , _y_[(2)] = 

_Cx_[(2)] . Therefore, (15) holds for any _y_[(1)] _, y_[(2)] _∈_ R _[n][y]_ if and only if the following inequality holds for any _x_[(1)] _, x_[(2)] _∈_ R _[n][x]_ : 

**==> picture [222 x 27] intentionally omitted <==**

where ∆ _x_ and ∆ _x_ Ψ is defined in (7). Furthermore, the arbitrariness of _x_[(1)] , _x_[(2)] , and Ψ implies arbitrariness of [∆ _x_ ; ∆ _x_ Ψ] _∈_ R _[n][x]_[+] _[n]_[Ψ] . S-lemma states that the claim that “any vector [∆ _x_ ; ∆ _x_ Ψ] _∈_ R _[n][x]_[+] _[n]_[Ψ] that satisfies (15) satisfies (6)” is equivalent to the existence of _λ ≥_ 0 such that the following inequality holds: 

**==> picture [235 x 25] intentionally omitted <==**

If _λ_ = 0, then (34) implies _PB_ cl = 0, which contradicts with _B_ cl = 0 and _P ≻_ 0. Therefore, we have _λ >_ 0. By redefining _P/λ_ as _P_ , we obtain (21). 

## B. PROOF OF THEOREM 2 

_Proof:_ Schur complement of the lower right 2 _×_ 2 block in the left hand side of (24) leads to the equivalence between (24) and the following inequality: 

**==> picture [230 x 54] intentionally omitted <==**

By pre- and post-multiplying diag[ _P, I_ ] by (35) (which is a congruence transformation and therefore does not lose equivalence), we obtain the equivalence 1) _⇔_ 2). 

We remark that (12) can be reformulated as follows: 

**==> picture [217 x 27] intentionally omitted <==**

where ∆ _x_ and ∆ _x_ Ψ is defined in (7). Identically to the proof of Theorem 1, S-lemma tells us that 3) is equivalent to the existence of _λ ≥_ 0 such that the following inequality holds. 

**==> picture [238 x 35] intentionally omitted <==**

If _λ_ = 0, then (36) implies _B_ cl _[⊤][PB]_[cl] _[⪯]_[0][,][which][contradicts] with _B_ cl = 0 and _P ≻_ 0. Therefore, we have _λ >_ 0. Thus, we obtain (23) by redefining _P/λ_ as _P_ . 

## C. PROOF OF LEMMA 1 

The statement of Lemma 1 is directly deduced by the following lemma with _S_ =[1] 2 _[⟨][∂] ∂y_[Ψ][(] _[y]_[)] _[⟩]_[.] _Lemma 3:_ Let Γ _∈_ S _[n]_ +[and] _[S][∈]_[R] _[n][×][n]_[be][symmetric.] Then, the following equivalence holds: 

0 _⪯ S ⪯_ Γ _⇐⇒ S_ Γ _[−]_[1] ( _S −_ Γ) _⪯_ 0 _._ (37) _Proof: S_ Γ _[−]_[1] ( _S −_ Γ) is the Schur’s complement of Γ in the following matrix: 

**==> picture [153 x 25] intentionally omitted <==**

As in the proof of Theorem 1, _B_ cl = 0 leads to _λ >_ 0, and again we obtain (25) by redefining _P/λ_ as _P_ . 

Therefore, what we need to prove is the following equivalence: 

Lemma 1 proves the equivalence 4) _⇔_ 5). 

**==> picture [178 x 12] intentionally omitted <==**

## E. PROOF OF THEOREM 4 

**==> picture [134 x 10] intentionally omitted <==**

_Proof:_ Schur complement of _−W_ in the left hand side of (28) leads to the equivalence between (28) and the following inequality: 

**==> picture [182 x 27] intentionally omitted <==**

In addition, _S ⪯_ Γ implies the following relation: 

**==> picture [434 x 54] intentionally omitted <==**

Therefore, we have _S_[ˆ] _⪰_ 0. 

( _⇒_ ) _S ⪰_ 0 comes from _S_[ˆ] _⪰_ 0 because _S_ is the upper left block of _S_[ˆ] . In addition, _S_[ˆ] _⪰_ 0 implies the following relation: 

On pre- and post-multiplying diag[ _P, I_ ] by (47) (which is a congruence transformation and therefore does not lose equivalence), we obtain the equivalence 1) _⇔_ 2). 

**==> picture [184 x 28] intentionally omitted <==**

The proof of the equivalence 1) _⇔_ 3) is parallel to that in the proof of Theorem 2 except that Lipschitzness is replaced by incremental sector boundedness. 

which leads us to _S ⪯_ Γ. 

The proof of the equivalence 1) _⇔_ 4) is parallel to that in the proof of Theorem 3 except that the contractivity of the CTLS is replaced by that of the DTLS. 

## D. PROOF OF THEOREM 3 

_Proof:_ On pre- and post-multiplying diag[ _P, I_ ] by (26) (which is a congruence transformation and therefore does not lose equivalence), we obtain the equivalence 1) _⇔_ 2). 

Lemma 1 proves the equivalence 4) _⇔_ 5). 

Regarding the equivalences 1) _⇔_ 3), we observe that, providing Assumption 1, (17) holds for any _y_[(1)] _, y_[(2)] _∈_ R _[n][y]_ if and only if the following inequality holds for any _x_[(1)] _, x_[(2)] _∈_ R _[n][x]_ : 

## REFERENCES 

- [1] F. Bullo. _Contraction Theory for Dynamical Systems_ . Kindle Direct Publishing, 1.2 edition, 2024, ISBN 979-8836646806. URL: https: //fbullo.github.io/ctds. 

- [2] L. D’Alto and M. Corless. Incremental quadratic stability. _Numerical Algebra, Control and Optimization_ , 3:175–201, 2013. doi:10. 3934/naco.2013.3.175. 

**==> picture [209 x 28] intentionally omitted <==**

- [3] A. Davydov and F. Bullo. Exponential stability of parametric optimization-based controllers via Lur’e contractivity. _IEEE Control Systems Letters_ , 8:1277–1282, 2024. doi:10.1109/LCSYS. 2024.3408110. 

where ∆ _x_ and ∆ _x_ Ψ is defined in (7). The rest of the proof is parallel to the proof of Theorem 1. 

To prove the equivalence 1) _⇔_ 4), we consider an arbitrary vector _δx ∈_ R _[n][x]_ and introduce the following vector: 

- [4] A. Davydov, V. Centorrino, A. Gokhale, G. Russo, and F. Bullo. Timevarying convex optimization: A contraction and equilibrium tracking approach. _IEEE Transactions on Automatic Control_ , June 2023. Conditionally accepted. doi:10.48550/arXiv.2305.15595. 

**==> picture [170 x 26] intentionally omitted <==**

- [5] A. Davydov, S. Jafarpour, and F. Bullo. Non-Euclidean contraction theory for robust nonlinear stability. _IEEE Transactions on Automatic Control_ , 67(12):6667–6681, 2022. doi:10.1109/TAC.2022. 3183966. 

We remark that (8) holds if and only if the following inequality holds for any _δx ∈_ R _[n][x]_ : 

- [6] C. Fan, J. Kapinski, X. Jin, and S. Mitra. Simulation-driven reachability using matrix measures. _ACM Transactions on Embedded Computing Systems_ , 17(1):1–28, 2018. doi:10.1145/3126685. 

**==> picture [199 x 24] intentionally omitted <==**

- [7] M. Fazlyab, M. Morari, and G. J. Pappas. Safety verification and robustness analysis of neural networks via quadratic constraints and semidefinite programming. _IEEE Transactions on Automatic Control_ , 67(1):1–15, 2022. doi:10.1109/TAC.2020.3046193. 

On the other hand, Assumption 1 implies that there exists _x ∈_ R _[n][x]_ such that _y_ = _Cx_ and that _Cδx_ spans R _[n][y]_ . Therefore, on pre- and post-multiplying _Cδx_ by (19) and reformulating the product, we observe that (19) is equivalent to the following statement: 

- [8] M. Giaccagli, V. Andrieu, S. Tarbouriech, and D. Astolfi. LMI conditions for contraction, integral action, and output feedback stabilization for a class of nonlinear systems. _Automatica_ , 154:111106, 2023. doi:10.1016/j.automatica.2023.111106. 

- [9] W. Lohmiller and J.-J. E. Slotine. On contraction analysis for nonlinear systems. _Automatica_ , 34(6):683–696, 1998. doi:10.1016/ S0005-1098(98)00019-3. 

**==> picture [224 x 25] intentionally omitted <==**

- [10] M. Revay, R. Wang, and I. R. Manchester. Lipschitz bounded equilibrium networks. _arXiv preprint arXiv:2010.01732_ , 2020. doi: 10.48550/arXiv.2010.01732. 

Furthermore, the arbitrariness of _δx_ and Ψ implies the arbitrariness of _δv_ . Therefore, S-lemma implies that “(19) implies (8)” is equivalent to the existence of _λ ≥_ 0 that satisfies the following inequality: 

- [11] E. K. Ryu and S. Boyd. Primer on monotone operator methods. _Applied Computational Mathematics_ , 15(1):3–43, 2016. 

- [12] L. Scardovi, M. Arcak, and E. D. Sontag. Synchronization of interconnected systems with applications to biochemical networks: An input-output approach. _IEEE Transactions on Automatic Control_ , 55(6):1367–1379, 2010. doi:10.1109/TAC.2010.2041974. 

**==> picture [221 x 25] intentionally omitted <==**

- [13] H. S. Shiromoto, M. Revay, and I. R. Manchester. Distributed nonlinear control design using separable control contraction metrics. _IEEE Transactions on Control of Network Systems_ , 6(4):1281–1290, 2019. doi:10.1109/TCNS.2018.2885270. 

- [14] S. Yu, C. B¨ohm, H. Chen, and F. Allg¨ower. Robust model predictive control with disturbance invariant sets. In _American Control Conference_ , pages 6262–6267, 2010. doi:10.1109/ACC.2010. 5531520. 

- [15] S. Yu, C. Maier, H. Chen, and F. Allg¨ower. Tube MPC scheme based on robust control invariant set with application to Lipschitz nonlinear systems. _Systems & Control Letters_ , 62(2):194–200, 2013. doi: 10.1016/j.sysconle.2012.11.004. 

- [16] F. Zhang, H. L. Trentelman, and J. M. A. Scherpen. Fully distributed robust synchronization of networked Lur’e systems with incremental nonlinearities. _Automatica_ , 50(10):2515–2526, 2014. doi:10. 1016/j.automatica.2014.08.033. 

