---
title: "The Variational Approach in Filtering and Correlated Noise"
arxiv: "2604.03001"
authors: ["Sharan Srinivasan", "Vijay Gupta", "Harsha Honnappa"]
year: 2026
source: paper
ingested: 2026-05-12
sha256: 16248e85a6a04632f1b8fc3cfca5f7b80ce5e13331a5a880c09a20488bd5adff
conversion: pymupdf4llm
---

# **THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE** 

## SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

Abstract. The variational formulation of nonlinear filtering due to Mitter and Newton characterizes the filtering distribution as the unique minimizer of a free energy functional involving the relative entropy with respect to the prior and an expected energy. This formulation rests on an absolute continuity condition between the joint path measure and a product reference measure. We prove that this condition necessarily fails whenever the signal and observation diffusions share a common noise source. Specifically we show that the joint and product measures are mutually singular, so no choice of reference measure can salvage the formulation. We then introduce a conditional variational principle that replaces the prior with a reference measure that preserves the noise correlation structure. This generalization recovers the Mitter–Newton formulation as a special case when the noises are independent, and yields an explicit free energy characterization of the filter in the linear correlated-noise setting. 

## 1. Introduction 

The problem of estimating the state of a stochastic system from partial, noisy observations is among the most fundamental in applied probability and control theory. In the linear Gaussian setting, the Kalman–Bucy filter provides an elegant, finite-dimensional recursive solution. For nonlinear systems, however, the filtering distribution is generally infinitedimensional, and characterizing it requires more sophisticated tools. 

In a landmark paper, Mitter and Newton [9] formulated a variational approach to this problem, showing that the filtering distribution can be characterized as a Gibbs measure and is the unique minimizer of a free energy functional, the sum of the relative entropy with respect to the prior and an expected energy term. A key application of their framework is to nonlinear filtering of diffusions, where the signal ( _X_ ) and observation ( _Y_ ) processes are driven by independent Brownian motions. This independence of the Brownian motions is essential, as it permits the use of the Cameron–Martin–Girsanov theorem to establish that the joint path measure _PXY_ is absolutely continuous with respect to the product _PX ⊗ λY_ for a suitable reference measure _λY_ (Assumption 2.1 below). The entire variational formulation rests on this absolute continuity condition. 

On the other hand, filtering with correlated noise has been extensively studied, primarily through the Kushner–Stratonovich and Zakai equations and their robust formulations; see [3, 7, 6, 5]. These models have also been extended to systems driven by L´evy noise [11, 10] and, more recently, to rough-path frameworks [1, 12]. In this paper, we show that Mitter and Newton’s condition that _PXY ≪ Px ⊗ λY_ fails, and cannot be rescued, when the signal and observation diffusions share a common noise source. We first present a discrete-time system with correlated noise to build intuition, showing that the Radon–Nikodym derivative between the joint measure and the product measure degenerates in the continuum limit. We then prove that Assumption 2.1 can _only_ be satisfied when _PXY ≪ PX ⊗ PY_ , so that no choice of 

1 

SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

2 

reference measure _λY_ can salvage the formulation. In the linear Gaussian case, we establish mutual singularity of the joint and product measures via the Feldman–H´ajek theorem, which provides a clean dichotomy since Gaussian measures on infinite-dimensional spaces are either equivalent or mutually singular. For the general nonlinear setting, we construct an explicit set that has full measure under _PXY_ and null measure under _PX ⊗ PY_ , establishing mutual singularity directly. Finally, we present a variational formulation that strictly generalizes [9] to the correlated noise setting by replacing the prior with a conditional reference measure that preserves the noise coupling structure. 

## 2. The Variational Formulation 

We first recall the variational approach defined in Section 2 of [9]. Let (Ω _, F ,_ P) be a probability space, and let ( **X** _, X_ ) and ( **Y** _, Y_ ) be Borel spaces. Let _X_ : Ω _→_ **X** and _Y_ : Ω _→_ **Y** be two measurable mappings with distributions _PX_ and _PY_ . Their joint distribution on _X × Y_ is _PXY_ . 

**Assumption 2.1.** _There exists a σ-finite measure λY on Y such that_ 

**==> picture [84 x 11] intentionally omitted <==**

We now define a few sets and quantities: 

**Definition 2.2.** Define the map _Q_ : **X** _×_ **Y** _→_ [0 _, ∞_ ) as: 

**==> picture [148 x 29] intentionally omitted <==**

and the set 

**==> picture [228 x 30] intentionally omitted <==**

We have **Y**[¯] _∈Y_ and _PY_ ( **Y[¯]** ) = 1. 

**Definition 2.3.** Let _H_ : **X** _×_ **Y** _→_ ( _−∞, ∞_ ] be defined by 

**==> picture [201 x 36] intentionally omitted <==**

then the Gibbs measure _PX|Y_ : _X ×_ **Y** _→_ [0 _,_ 1] defined by 

**==> picture [338 x 32] intentionally omitted <==**

is the conditional probability measure of _X_ given _Y_ . 

The key proposition [9, Proposition 2.1] (Proposition 2.4) characterizes _PX|Y_ as the minimizer of a free energy: 

**Proposition 2.4.** _Suppose Assumption 2.1 is satisfied, then for any y ∈_ **Y** _such that_ 

**==> picture [364 x 28] intentionally omitted <==**

_PX|Y_ ( _·, y_ ) _is the unique minimizer of_ 

**==> picture [328 x 23] intentionally omitted <==**

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

3 

_where h_ ( _P |Q_ ) _is the relative entropy of the measures P, Q ∈P_ ( _X_ ) _, and_ 

**==> picture [294 x 37] intentionally omitted <==**

This follows directly from the Gibbs variational principle and that the conditional measure _PX|Y_ defined in equation (1) is a Gibbs measure. 

2.1. **Path Measures of Diffusion Processes.** The Proposition 2.4 can be applied to the filtering setting to obtain the filtering measure. Let _X. ∈ C_ ([0 _, T_ ] _,_ R _[d]_ ) and _Y. ∈ C_ ([0 _, T_ ] _,_ R _[n]_ ) be processes satisfying the following Itˆo SDEs: 

**==> picture [346 x 64] intentionally omitted <==**

where _X_ 0 _∼ µ_ , a law on (R _[d] , B[d]_ ), and _b, σ_ and _h_ are measurable mappings. Under suitable regularity conditions on _b, σ_ and _h_ , the SDEs (3), (12) are unique in law and have a weak solution (Ω _, F,_ ( _Ft_ ) _t∈_ [0 _,T_ ] _,_ P _,_ ( _B, W_ ) _,_ ( _X, Y_ )), i.e., a filtered probability space (Ω _, F,_ ( _Ft_ ) _t∈_ [0 _,T_ ] _,_ P) carrying a ( _d_ + _n_ )-dimensional Brownian motion ( _B, W_ ) and a ( _d_ + _n_ )-dimensional semimartingale ( _X, Y_ ) that satisfy equations (3), (4) for all _t ∈_ [0 _, T_ ]. 

The measure spaces ( **X** _, X_ ) and ( **Y** _, Y_ ) become ( _C_ ([0 _, T_ ] _,_ R _[d]_ ) _, BX_ ) and ( _C_ ([0 _, T_ ] _,_ R _[n]_ ) _, BY_ ), where the path spaces are topologized by the uniform norm (we still use ( **X** _, X_ ) and ( **Y** _, Y_ ) for these spaces). Under Assumptions H2, H3 and H4 in [9], we have a strong solution of the _t_ SDE (3), and E[�0 _[|][h]_[(] _[X][s]_[)] _[|]_[2] _[ds]_[]] _[ <][ ∞]_[.][We further assume that] _[ X]_[0][ is independent of the (] _[d]_[+] _[n]_[)-] dimensional Brownian motion ( _B, W_ ). The integrability condition of _h_ (Novikov condition), allows us to use the Cameron-Martin-Girsanov theorem to define a new measure under which the observation process _Y_ is a standard _n_ -dimensional Brownian motion independent of _X_ (independence is manifest from the independence of _B_ and _W_ ). Thus, we take _λY_ in Assumption 2.1 as the Wiener measure on _Y_ , and we have 

**==> picture [395 x 30] intentionally omitted <==**

We need a version of _Q_ that is well defined for all _y ∈_ **Y** . However, from [4] we know that we can perform an “integration by parts” to obtain a robust version of 

**==> picture [352 x 17] intentionally omitted <==**

In what follows from Section 3 in [9], the condition in Proposition 2.4 is satisfied and the conditional (path) measure _PX|Y_ is the unique minimizer of equation (2). 

**==> picture [174 x 10] intentionally omitted <==**

As a warm-up exercise, consider the discrete time processes on a finite horizon _n < N ∈_ N: 

**==> picture [331 x 31] intentionally omitted <==**

where _B, W ∼N_ (0 _,_ ∆ _tI_ ) are independent random variables with ∆ _t ∈_ (0 _, ∞_ ). 

SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

4 

It is clear that both _X_ and _Y_ are Gaussian and have mean 0. We have the covariance matrix under the joint distribution: 

**==> picture [184 x 29] intentionally omitted <==**

However, under the product measure _PX ⊗ PY_ , the covariance of X and Y is zero, and we have 

**==> picture [188 x 29] intentionally omitted <==**

The Radon-Nikodym derivative of the two measures is the ratio of the two Gaussian densities: 

**==> picture [15 x 13] intentionally omitted <==**

**==> picture [293 x 30] intentionally omitted <==**

for any _⃗z ∈_ R _[N]_[+] _[N]_ . We write the difference of the matrices in the exponent as 

**==> picture [220 x 30] intentionally omitted <==**

**==> picture [470 x 74] intentionally omitted <==**

In the limit, this ratio either goes to zero for all _⃗z_ or blows up to infinity depending on whether the term in the square brackets is positive or negative. This shows mutual singularity of the measures. 

## 4. Failure under Correlation 

The following result shows that Assumption 2.1 can only be satisfied when the joint measure _PXY_ is absolutely continuous with respect to the product of its marginals. In particular, it cannot be salvaged by a clever choice of reference measure _λY_ . Recall that ( **X** _, X_ ) and ( **Y** _, Y_ ) are standard Borel spaces, and let _PXY_ be a probability measure on _X × Y_ with marginals _PX_ and _PY_ . 

**Proposition 4.1.** _If there exists a σ-finite measure λY on_ ( **Y** _, Y_ ) _such that PXY ≪ PX ⊗λY , then PXY ≪ PX ⊗ PY ._ 

_Proof._ We first show that _PY ≪ λY_ . Let _A ∈Y_ with _λY_ ( _A_ ) = 0. Then 

**==> picture [214 x 13] intentionally omitted <==**

and since _PXY ≪ PX ⊗ λY_ , we have _PXY_ ( _X × A_ ) = 0. By the definition of the marginal, _PY_ ( _A_ ) = _PXY_ ( _X × A_ ) = 0, so _PY ≪ λY_ . 

Now take the Lebesgue decomposition of _λY_ with respect to _PY_ : 

**==> picture [78 x 12] intentionally omitted <==**

where _λ[ac] Y[≪][P][Y]_[and] _[ λ][s] Y[⊥][P][Y]_[ .][Let] _[ S][∈Y]_[be such that] _[ λ][s] Y_[is supported on] _[ S]_[and] _[ P][Y]_[ (] _[S]_[) = 0.] Let _E ∈X ⊗Y_ with ( _PX ⊗ PY_ )( _E_ ) = 0. We show _PXY_ ( _E_ ) = 0 by writing 

**==> picture [276 x 15] intentionally omitted <==**

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

5 

The first term vanishes since _PXY_ ( _X × S_ ) = _PY_ ( _S_ ) = 0. For the second term, since _λ[s] Y_[is] supported on _S_ , 

**==> picture [470 x 48] intentionally omitted <==**

**Corollary 4.1.1.** _Let PX|Y_ ( _·, y_ ) _denote a regular conditional distribution of X given Y . If_ 

**==> picture [186 x 15] intentionally omitted <==**

_then there is no σ-finite measure λY on_ ( **Y** _, Y_ ) _satisfying Assumption 2.1._ 

_Proof._ Suppose for a contradiction that _λY_ satisfies Assumption 2.1. By Proposition 4.1, _PXY ≪ PX ⊗ PY_ . By the chain rule for densities, 

**==> picture [261 x 30] intentionally omitted <==**

In particular, _PX|Y_ ( _·, y_ ) _≪ PX_ for _PY_ -a.e. _y_ , contradicting the hypothesis. □ 

_Remark_ 1 _._ Corollary 4.1.1 is stated on abstract standard Borel spaces and makes no reference to diffusions, Brownian motions, or path spaces. It reduces the question of whether the variational formulation of [9] applies to a given model to a single checkable condition: is the posterior _PX|Y_ ( _·, y_ ) absolutely continuous with respect to the prior _PX_ ? If conditioning on the observation collapses the support of the signal (as occurs whenever signal and observation share a correlated noise source) the variational formulation cannot hold. 

The next section verifies the hypothesis of Corollary 4.1.1 for diffusions with correlated noise. 

5. Diffusions with Correlated Noise 

Consider the signal-observation model: 

**==> picture [398 x 64] intentionally omitted <==**

where _X_ 0 _∼ µ_ , _b, σ_ 0 _, σ_ 1 _, h_ are measurable mappings, and _B_ and _W_ are independent Brownian motions. We use the same measure spaces as in Section 2. Let _X_ , _Y_ and ( _X, Y_ ) have distributions _PX_ , _PY_ and _PXY_ , respectively. 

5.1. **Gaussian Case.** We first verify the hypothesis of Corollary 4.1.1 in the linear Gaussian setting, where the Feldman-Hajek theorem (see [2, Theorem 2.7.2]) provides the clean dichotomy that Gaussian measures on path spaces are either equivalent or mutually singular. We take the diffusion coefficients _σ_ 0 and _σ_ 1 to be state-independent and _b_ ( _t, ·_ ) : R _[d] →_ R _[d]_ linear, so that (11) becomes: 

**==> picture [375 x 30] intentionally omitted <==**

Recall the following definitions. 

SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

6 

**Definition 5.1.** Let **X** be a locally convex space, and let _µ_ be a measure on ( **X** _, X_ ) such that **X** _[∗] ⊂ L_[2] ( _µ_ ). The mean of _µ_ , denoted _aµ_ , is an element of ( **X** _[∗]_ ) _[′]_ defined as: 

**==> picture [120 x 28] intentionally omitted <==**

where ( **X** _[∗]_ ) _[′]_ is the space of linear functionals on **X** _[∗]_ . The operator _Rµ_ : **X** _[∗] →_ ( **X** _[∗]_ ) _[′]_ defined as: 

**==> picture [361 x 28] intentionally omitted <==**

is called the covariance operator of _µ_ . 

Let _γ_ be a Gaussian measure on ( **X** _, X_ ), define a norm on **X** as 

**==> picture [216 x 14] intentionally omitted <==**

**Definition 5.2.** The Cameron-Martin space of _γ_ ( _H_ ( _γ_ )) is defined as: 

(15) _H_ ( _γ_ ) := _{h ∈ X_ : _|h|H_ ( _γ_ ) _< ∞}._ 

We can now state the Feldman-Hajek theorem 

**Theorem 5.3.** _Let X be a locally convex space, and µ, ν be centered Gaussian measures on X. Then µ ∼ ν or µ ⊥ ν. Furthermore, µ ∼ ν if and only if the following conditions hold:_ 

- (1) _The Cameron-Martin spaces of µ and ν are the same as sets, i.e., H_ ( _µ_ ) = _H_ ( _ν_ ) = _H._ 

- (2) _There exists a nuclear operator C such that CC[∗] − I is a Hilbert-Schmidt operator on H (has finite Hilbert-Schmidt norm)._ 

**Theorem 5.4.** _Given signal-observation processes (13), (12), let PXY be their joint path measure. Then there is no measure λY on_ ( **Y** _, Y_ ) _such that PXY ≪ PX ⊗ λY ._ 

_Proof._ By Corollary 4.1.1, it suffices to show that _PXY ⊥ PX ⊗ PY_ . The measures _PXY_ and _PX ⊗ PY_ are both Gaussian. Under _PXY_ , we have: 

**==> picture [347 x 29] intentionally omitted <==**

Under _PX ⊗ PY_ ( _X_ and _Y_ are independent): 

**==> picture [470 x 62] intentionally omitted <==**

5.2. **The General Case.** For the general case, we require that _σ_ 0 is a smooth vector field satisfying the H¨ormander condition, ensuring that _Xt_ admits a density with respect to Lebesgue measure for every _t ∈_ [0 _, T_ ] (see [8, Section 4.1.2]). 

**Assumption 5.5.** _The set_ 

**==> picture [146 x 14] intentionally omitted <==**

_has Lebesgue measure 0 a.e. t ∈_ [0 _, T_ ] _, and the vector fields σ_ 0 _satisfy the H¨ormander condition at X_ 0 _almost surely._ 

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

7 

We now verify the hypothesis of Corollary 4.1.1 for the full nonlinear model (11), (12) under Assumption 5.5. 

**Theorem 5.6.** _Given SDEs (11), (12), with joint measure PXY and Assumption 5.5 is satisfied. Then there is no measure λY on_ ( **Y** _, Y_ ) _such that PXY ≪ PX ⊗ λY ._ 

_Proof._ By Corollary 4.1.1, it suffices to show that _PXY ⊥ PX ⊗ PY_ . Consider the map _Qn_[[0] _[,t]_[]] : **X** _×_ **Y** _→_ R _[d][×][n]_ defined as: 

**==> picture [343 x 36] intentionally omitted <==**

where the sum is taken over dyadic intervals of [0 _, t_ ] _⊆_ [0 _, T_ ]. Under the joint measure _PXY_ , we have the quadratic variation: 

**==> picture [274 x 70] intentionally omitted <==**

almost surely. 

Under the product measure _PX ⊗ PY_ , the mean of _Qn_[[0] _[,t]_[]] under the limit _n →∞_ is 

**==> picture [340 x 76] intentionally omitted <==**

Since both _b_ and _h_ have at most linear growth, we have: 

**==> picture [350 x 76] intentionally omitted <==**

where the constant _C_[˜] := _C_ sup0 _≤s≤T_ E _X_ [1 + _|Xs|_ ]E _Y_ [1 + _|Ys|_ ] _}_ is finite, since the moments of a strong solution of an Itˆo SDE are bounded. Hence lim _n→∞_ E[ _Qn_[[0] _[,t]_[]] ( _X, Y_ )] = 0 under the product measure. 

The variance under the limit _n →∞_ is 

**==> picture [358 x 76] intentionally omitted <==**

8 SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

Since the maps _σ_ 0 and _σ_ 1 have at most linear growth, 

**==> picture [288 x 76] intentionally omitted <==**

where _C_[˜] _[′]_ := _C[′]_ sup0 _≤s≤T_ E _X_ [(1 + _|Xs|_ )[2] ] is bounded due to bounded moments of a strong solution to an Itˆo SDE. 

Thus, we have _Qn_[[0] _[,t]_[]] _→_ 0 in _L_[2] as _n →∞_ . From Markov’s inequality, it follows that _Qn_[[0] _[,t]_[]] ( _X, Y_ ) _→_ 0 in probability as _n →∞_ . In order to show convergence almost surely, we choose an increasing subsequence _{nk}k∈_ N such that 

**==> picture [148 x 25] intentionally omitted <==**

Since 

**==> picture [160 x 27] intentionally omitted <==**

from the Borel-Cantelli lemma, 

**==> picture [188 x 22] intentionally omitted <==**

i.e., the event _{|Qn_[[0] _k[,t]_[]][(] _[X, Y]_[ )] _[|][ >]_[ 1] _[/k][}]_[ occurs only finitely many times almost surely.][Therefore,] for almost every _ω ∈_ Ω, there exists _K_ ( _ω_ ) such that for all _l > K_ ( _ω_ ), 

**==> picture [92 x 26] intentionally omitted <==**

Since the sequence _{nk}_ is increasing, we have _Qn_[[0] _[,t]_[]] ( _X, Y_ ) _→_ 0 almost surely as _n →∞_ . Define the sets 

**==> picture [314 x 53] intentionally omitted <==**

We have _PXY_ ( _A_[[0] _[,t]_[]] ) = 1 and ( _PX ⊗ PY_ )( _B_[[0] _[,t]_[]] ) = 1 for all _t ∈_ [0 _, T_ ]. In order to show the mutual singularity of the two measures, we need to show that for some _s ∈_ [0 _, T_ ], ( _PX ⊗ PY_ )( _A_[[0] _[,s]_[]] ) = 0. For all _t ∈_ [0 _, T_ ], we have 

**==> picture [384 x 15] intentionally omitted <==**

Since ( _PX ⊗ PY_ )(( _B_[[0] _[,t]_[]] ) _[c]_ ) = 0, ( _PX ⊗ PY_ )( _A_[[0] _[,t]_[]] _∩_ ( _B_[[0] _[,t]_[]] ) _[c]_ ) = 0. The set _A_[[0] _[,t]_[]] _∩ B_[[0] _[,t]_[]] is given by: 

**==> picture [282 x 31] intentionally omitted <==**

If there exists a _t ∈_ [0 _, T_ ] such that _A_[[0] _[,t]_[]] _∩ B_[[0] _[,t]_[]] = _∅_ , then we have ( _PX ⊗ PY_ )( _A_[[0] _[,t]_[]] ) = ( _PX ⊗ PY_ )( _A_[[0] _[,t]_[]] _∩ B_[[0] _[,t]_[]] ) = 0, we are done. If there is no _t ∈_ [0 _, T_ ] such that _A_[[0] _[,t]_[]] _∩ B_[[0] _[,t]_[]] = _∅_ , 

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

9 

then there exists _x ∈_ **X** such that 

**==> picture [98 x 30] intentionally omitted <==**

for all _t ∈_ [0 _, T_ ]. This means that _σ_ 1( _t, xt_ ) = 0 for almost every _t ∈_ [0 _, T_ ]. We now show that the product measure _PX ⊗ PY_ assigns no mass to the set 

**==> picture [262 x 13] intentionally omitted <==**

It is enough to show that _PX_ ( _{x_ : _σ_ 1( _t, xt_ ) = 0 a.e. _t ∈_ [0 _, T_ ] _}_ ) = 0. From Assumption 5.5, _Xt_ admits a density with respect to the Lebesgue measure. Since, _Z_ = _{z ∈_ R _[d]_ : _σ_ 1( _t, z_ ) = 0 _}_ has Lebesgue measure 0 a.e. _t ∈_ [0 _, T_ ], we have 

**==> picture [282 x 44] intentionally omitted <==**

Thus, _PX_ ( _{x_ : _σ_ 1( _t, xt_ ) = 0 _}_ ) = 0 a.e. _t ∈_ [0 _, T_ ], from which we have that _PX ⊗ PY_ assigns no mass to the set _S_ . Therefore, _PXY_ is not absolutely continuous with respect to _PX ⊗ PY_ . □ 

## 6. A Variational Formulation for Correlated Noise 

The results of the preceding sections show that Assumption 2.1 cannot be satisfied when the signal and observation share a common Brownian motion, and moreover that the filtering measure _PX|Y_ ( _·, y_ ) is singular with respect to the prior _PX_ . This _rules out_ any Gibbs representation of the form _dPX|Y ∝ e[−][H] dPX_ . In this section, we show that a variational characterization of the filter can be recovered by replacing the prior with a _conditional reference measure_ that preserves the noise correlation structure. We first present an abstract variational principle, paralleling Proposition 4.1. 

6.1. **Conditional Variational Formula.** Let ( _X , X_ ) and ( _Y, Y_ ) be standard Borel spaces, and let _PXY_ be a probability measure on _X × Y_ with marginals _PX_ and _PY_ . 

**Assumption 6.1.** _There exists a probability measure Q on X × Y with marginal QY_ = _PY such that, for PY -a.e. y ∈Y,_ 

**==> picture [122 x 14] intentionally omitted <==**

_Remark_ 2 _._ Assumption 6.1 replaces Assumption 2.1 of Mitter and Newton. It requires absolute continuity of the _conditional_ measures rather than of the joint measure with respect to a product. The condition _QY_ = _PY_ is a normalization that ensures the two models agree on the observation marginal. 

**Definition 6.2.** Given _Q_ satisfying Assumption 6.1, define the energy _H_ : _X ×Y →_ ( _−∞, ∞_ ] by 

**==> picture [164 x 31] intentionally omitted <==**

and the normalizing constant 

**==> picture [202 x 28] intentionally omitted <==**

SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

10 

Define 

**==> picture [422 x 30] intentionally omitted <==**

**Proposition 6.3.** _Under Assumption 6.1, PY_ ( _Y_[¯] ) = 1 _, and for every y ∈ Y_[¯] _, the filtering measure PX|Y_ ( _·, y_ ) _is a Gibbs measure with energy H_ ( _·, y_ ) _and reference QX|Y_ ( _·, y_ ) _:_ 

**==> picture [280 x 33] intentionally omitted <==**

_Proof._ This is immediate from the definition of _H_ . By Assumption 6.1, the Radon-Nikodym derivative exists, and 

**==> picture [170 x 30] intentionally omitted <==**

Since _PX|Y_ ( _·, y_ ) is a probability measure, _Z_ ( _y_ ) = 1 for _PY_ -a.e. _y_ . The integrability condition defining _Y_[¯] holds _PY_ -a.e. because _H_ exp( _−H_ ) is integrable under _PX|Y_ ( _·, y_ ) whenever _H_ has finite entropy under the posterior, which holds _PY_ -a.e. by the finiteness of _h_ ( _PX|Y_ ( _·, y_ ) _∥QX|Y_ ( _·, y_ )). □ 

**Theorem 6.4.** _Under Assumption 6.1, for every y ∈ Y_[¯] _, the conditional measure PX|Y_ ( _·, y_ ) _is the unique minimizer of_ 

**==> picture [348 x 27] intentionally omitted <==**

_Proof._ By Proposition 6.3, _PX|Y_ ( _·, y_ ) is a Gibbs measure with energy _H_ ( _·, y_ ) and reference _QX|Y_ ( _·, y_ ). The result follows from the Gibbs variational principle. □ 

_Remark_ 3 (Reduction to Mitter–Newton) _._ When _PX|Y_ ( _·, y_ ) _≪ PX_ for _PY_ -a.e. _y_ (as holds when signal and observation are driven by independent noises) one may take _Q_ = _PX ⊗ PY_ , so that _QX|Y_ ( _·, y_ ) = _PX_ for all _y_ . Then Assumption 6.1 reduces to Assumption 2.1 with _λY_ = _PY_ , the energy recovers the Mitter–Newton energy, and Theorem 6.4 reduces to Proposition 2.4. 

_Remark_ 4 (Role of the reference joint law _Q_ ) _._ The choice of _Q_ determines both the reference measure _QX|Y_ ( _·, y_ ) and the energy _H_ . In the abstract setting, _Q_ need only satisfy Assumption 6.1; any such _Q_ yields a valid variational characterization. The formulation acquires specific content when _Q_ is chosen to have a natural interpretation. For instance, in the linear diffusion model with correlated noise, the canonical choice is the driftless system that preserves the noise coupling (Section 6.2 below), giving _QX|Y_ ( _·, y_ ) a concrete probabilistic meaning as the signal dynamics with shared noise frozen to _y_ and all drifts removed. 

6.2. **A Variational Formulation for Linear Diffusions with Correlated Noise.** We restrict to the linear signal-observation setting for clarity: 

**==> picture [256 x 32] intentionally omitted <==**

where _A ∈_ R _[d][×][d]_ , _C ∈_ R _[n][×][d]_ , _σ_ 0 _∈_ R _[d][×][d]_ , _σ_ 1 _∈_ R _[d][×][n]_ , _B_ is a _d_ -dimensional Brownian motion, _W_ is an _n_ -dimensional Brownian motion independent of _B_ , and _x_ 0 is deterministic. We assume _σ_ 0 is invertible. 

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

11 

Define the _driftless reference system_ by removing all drift terms while preserving the noise coupling: 

**==> picture [122 x 34] intentionally omitted <==**

Let _Q_ denote the joint law of ( _X_[0] _, Y_[0] ) on _X × Y_ . 

**Definition 6.5.** For each _y ∈Y_ , define the _conditional reference measure µy_ ( _·_ ) := _QX|Y_ ( _·, y_ ). Under _µy_ , the signal process satisfies 

(20) 

**==> picture [118 x 12] intentionally omitted <==**

where _B_ is a _d_ -dimensional Brownian motion. In particular, _µy_ is a Gaussian measure on _X_ with mean _m_[0] _t_[(] _[y]_[) :=] _[ x]_[0][+] _[ σ]_[1] _[y][t]_[and][covariance][Cov(] _[X][s][, X][t]_[) =] _[ |][σ]_[0] _[|]_[2][ min(] _[s, t]_[).] 

6.2.1. _Absolute Continuity and the Free Energy._ Under the true law _P_ , conditioning on _t Y_ = _y_ constrains _Wt_ = _yt − C_ �0 _[X][s][ ds]_[,][so][the][signal][satisfies] 

(21) 

**==> picture [220 x 13] intentionally omitted <==**

The difference between (21) and (20) is precisely the drift term _β_ ( _Xt_ ) = ( _A − σ_ 1 _C_ ) _Xt_ . 

**Proposition 6.6.** _For PY -a.e. y ∈Y, PX|Y_ ( _·, y_ ) _≪ µy, and the Radon-Nikodym derivative is given by_ 

**==> picture [447 x 85] intentionally omitted <==**

_where_ 

_and Z_ ( _y_ ) := � _X_[exp(] _[−][H]_[(] _[x, y]_[))] _[ µ][y]_[(] _[dx]_[)] _[is][the][normalizing][constant.]_ 

_Proof._ Under _µy_ , the Brownian motion _B_ is recovered as 

**==> picture [301 x 14] intentionally omitted <==**

The transition from _µy_ to _PX|Y_ ( _·, y_ ) amounts to adding the drift _β_ ( _Xt_ ) to the equation (20). By the Cameron-Martin-Girsanov theorem applied to _B_ , 

**==> picture [423 x 31] intentionally omitted <==**

Substituting (24), i.e., _σ_ 0 _dBt_ = _dxt − σ_ 1 _dyt_ , and normalizing yields (22)–(23). The Novikov condition is satisfied since _β_ has linear growth and _X_ has bounded moments on [0 _, T_ ] under _µy_ . □ 

_Remark_ 5 (Reduction to the independent noise case) _._ When _σ_ 1 = 0, the conditional reference measure _µy_ has no _y_ -dependence, and (20) becomes _Xt_ = _x_ 0 + _σ_ 0 _Bt_ . The free energy (23) reduces to the standard Girsanov density of Mitter and Newton [9]. Thus, Theorem 6.4 contains the independent noise formulation as a special case. 

SHARAN SRINIVASAN, VIJAY GUPTA, AND HARSHA HONNAPPA 

12 

_Remark_ 6 (Interpretation) _._ The reference measure _µy_ encodes the structural coupling between signal and observation. The energy _H_ encodes the drift information. The free energy minimization (19) combines these two sources of information, and shows that among all measures on signal paths, the filter uniquely minimizes the sum of the informational cost of deviating from the correlated reference dynamics and the expected energy from the drift. In the independent noise case, the coupling is trivial and the reference reduces to the prior; in the correlated case, the reference necessarily depends on the observation path through the shared noise. 

_Remark_ 7 (Non-degeneracy of _σ_ 0) _._ The invertibility of _σ_ 0 is essential. It ensures that the “private” noise _B_ is recoverable from ( _x, y_ ) via (24), and that the Girsanov change of measure between _µy_ and _PX|Y_ ( _·, y_ ) is well-defined. When _σ_ 0 = 0 (i.e., signal is driven entirely by the correlated noise), conditioning on _Y_ = _y_ determines _X_ up to the drift, and the conditional law degenerates. Thus, no variational formulation of this type is possible. 

## 7. Conclusion 

We have shown that the Mitter–Newton variational formulation of nonlinear filtering fails when signal and observation diffusions share a common noise source, and that this failure is fundamental. We introduced a conditional variational principle that replaces the prior with a reference measure _µy_ that preserves the noise correlation structure, and showed that this formulation resolves the limitation in the linear setting while strictly containing [9] as a special case. Extending this formulation to the nonlinear setting remains an open problem. 

## Acknowledgment 

This paper was funded by the Office of Naval Research (ONR) through grant number FA9550-24-1-0210. 

## References 

1. Andrew L Allan, Jost Pieper, and Josef Teichmann, _Rough SDEs and robust filtering for jump-diffusions_ , arXiv preprint arXiv:2507.05930 (2025). 

2. Vladimir Igorevich Bogachev, _Gaussian measures_ , no. 62, American Mathematical Soc., 1998. 

3. J. M. C. Clark, _The design of robust approximations to the stochastic differential equations of nonlinear filtering_ , Communication Systems and Random Process Theory **25** (1978), 721–734. 

4. John MC Clark and Dan Crisan, _On a robust version of the integral representation formula of nonlinear filtering_ , Probability theory and related fields **133** (2005), no. 1, 43–56. 

5. D. Crisan, J. Diehl, P. K. Friz, and H. Oberhauser, _Robust filtering: Correlated noise and multidimensional observation_ , The Annals of Applied Probability **23** (2013), no. 5, 2139–2160. 

6. Mark H.A. Davis and Michael P. Spathopoulos, _Pathwise nonlinear filtering for nondegenerate diffusions with noise correlation_ , SIAM Journal on Control and Optimization **25** (1987), no. 2, 260–278. 

7. Robert J Elliott and Michael Kohlmann, _Robust filtering for correlated multidimensional observations_ , Mathematische Zeitschrift **178** (1981), no. 4, 559–578. 

8. Xi Geng, _An introduction to the theory of rough paths_ , Lecture Notes (2021), 9. 

9. Sanjoy K Mitter and Nigel J Newton, _A variational approach to nonlinear estimation_ , SIAM journal on control and optimization **42** (2003), no. 5, 1813–1833. 

10. Huijie Qiao, _Convergence of nonlinear filtering for multiscale systems with correlated L´evy noises_ , Stochastics and Dynamics **23** (2023), no. 02, 2350016. 

11. Huijie Qiao and Jinqiao Duan, _Nonlinear filtering of stochastic dynamical systems with L´evy noises_ , Advances in Applied Probability **47** (2015), no. 3, 902–918. 

THE VARIATIONAL APPROACH IN FILTERING AND CORRELATED NOISE 

13 

12. Sharan Srinivasan, Vijay Gupta, and Harsha Honnappa, _Robust filtering of l´evy-driven stochastic models_ , arXiv preprint arXiv:2602.14310 (2026). 

(S. Srinivasan) Elmore Family School of Electrical and Computer Engineering, Purdue University, West Lafayette, IN, USA 

_Email address_ : `srini256@purdue.edu` 

(V. Gupta) Elmore Family School of Electrical and Computer Engineering, Purdue University, West Lafayette, IN, USA 

_Email address_ : `gupta869@purdue.edu` 

(H. Honnappa) Edwardson School of Industrial Engineering, Purdue University, West Lafayette, IN, USA 

_Email address_ : `honnappa@purdue.edu` 

