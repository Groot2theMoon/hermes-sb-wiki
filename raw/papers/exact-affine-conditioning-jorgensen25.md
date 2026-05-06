---
title: "**Exact affine conditioning beyond Gaussians: a unique characterization of the ensemble Kalman update** _[∗]_"
arxiv: "2510.0015"
authors: ["Frederic J. N. Jorgensen", "Youssef M. Marzouk"]
year: 2025
source: paper
ingested: 2026-05-06
sha256: e7525cd858731017df9338c5f08e4169947edd2004074147247ddfe2d3ef3feb
conversion: pymupdf4llm
---

## **Exact affine conditioning beyond Gaussians: a unique characterization of the ensemble Kalman update** _[∗]_ 

## Frederic J. N. Jorgensen _[†]_ and Youssef M. Marzouk _[‡]_ 

**Abstract.** The analysis step of the ensemble Kalman filter, called the ensemble Kalman update (EnKU), is widely used for approximating posterior distributions in inverse problems and data assimilation. The EnKU approximates the posterior distribution _πX|Y_ = _y⋆_ by pushing forward the joint distribution ( _X, Y_ ) _∼ π_ through an affine map _L_[EnKU] _π,y⋆_[(] _[x, y]_[)][that][depends][only][on][the][covariance][structure][of] _[π]_ and the observation _y⋆_ . While the EnKU yields the exact posterior for Gaussian _π_ in the mean-field, this property alone does not uniquely determine the EnKU. In fact, there are infinitely many affine maps _Lπ,y⋆_ that achieve such exact conditioning. In this paper, we offer a novel characterization of the EnKU among all such affine maps. We first exhaustively characterize the set _E_[EnKU] of joint distributions for which the EnKU yields exact conditioning, showing that it is much larger than the set of Gaussians. Next, we show that except for a small class of highly symmetric distributions within _E_[EnKU] , the EnKU is the _unique_ exact affine conditioning map. Further, we characterize the largest possible set of distributions _F_ for which a distribution-dependent, weakly observationdependent, affine map exists, a class of transports that naturally includes the EnKU. We show that _F_ = _E_[EnKU] _∪S_ nl _−_ dec with a small symmetry class _S_ nl _−_ dec, meaning that for affine conditioning beyond the Gaussian setting, the EnKU has an exact set that is essentially maximally large. 

**Key words.** Ensemble Kalman filter; stochastic filtering; measure transport; Bayesian inverse problems; uncertainty quantification; mean-field limit; non-Gaussian setting; exact conditioning; data assimilation. 

**AMS subject classifications.** 65C35, 62F15, 93E11 

**1. Introduction.** Conditioning a joint probability distribution on the realized value of one variable is a fundamental operation in inverse problems and stochastic filtering. Given a joint distribution ( _X, Y_ ) _∼ π_ on R _[n] ×_ R _[m]_ and an observation _y⋆ ∈_ R _[m]_ , the conditional distribution _πX|Y_ = _y⋆_ is defined via disintegration. At the population level, many conditioning algorithms in the setting of filtering and inverse problems approach this task by constructing a transport map _Tπ,y⋆_ : R _[n] ×_ R _[m] →_ R _[n]_ , depending on _π_ and _y⋆_ , whose pushforward of the joint distribution approximately coincides with the conditional distribution [6,7,11,12,41,43], i.e., 

## (1.1) ( _Tπ,y⋆_ ) _♯π ≈ πX|Y_ = _y⋆._ 

In high dimensions, using an affine map _Lπ,y⋆_ for _Tπ,y⋆_ is particularly attractive because it can be implemented using standard linear algebra operations such as matrix-vector products and low-rank updates that scale efficiently with dimension. The transport map most widely 

> _∗_ Submitted to the editors April 26, 2026. 

> **Funding:** The work of the first author was supported by the Singapore-MIT Alliance for Research and Technology (SMART): Wafer-scale Integrated Sensing Devices based on Optoelectronic Metasurfaces (WISDOM) Interdisciplinary Research Group. The work of both authors was supported by the Office of Naval Research, SIMDA (Sea Ice Modeling and Data Assimilation) MURI, award number N00014-20-1-2595. 

> _†_ Department of Mathematics, Massachusetts Institute of Technology (fjorgen@mit.edu). 

> _‡_ Laboratory for Information and Decision Systems, Massachusetts Institute of Technology (ymarz@mit.edu). 

**1** 

**2** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

used in practice, particularly in data assimilation and inverse problems, is indeed affine; it is the update step of the ensemble Kalman filter (EnKF), denoted by _Tπ,y⋆_ = _L_[EnKU] _π,y⋆_[,][which] is well-defined under the assumption that _π_ has finite second moments. This map takes the form 

**==> picture [341 x 16] intentionally omitted <==**

where Σ _XY_ denotes the cross-covariance between _X_ and _Y_ , Σ _Y Y_ is the covariance of _Y_ , and _†_ denotes the Moore–Penrose pseudoinverse [12, 13]. In the data assimilation literature, the matrix _K_ is often referred to as the _Kalman gain_ . We will call the transport map _L_[EnKU] _π,y⋆_ the _ensemble Kalman update_ (EnKU). 

**1.1. Ambiguity of the ensemble Kalman update.** A special property of the EnKU is that when _X_ and _Y_ are jointly Gaussian, this update is _exact_ . That is, the approximation in (1.1) becomes an equality; i.e., 

**==> picture [111 x 18] intentionally omitted <==**

holds _πY_ -a.s. for _y⋆ ∈_ R _[m]_ [7, 12, 13, 34]. However, this property does not single out the EnKU among affine maps. Indeed, as we will explain more later, there are infinitely many affine maps _Lπ,y⋆_ : R _[n] ×_ R _[m] →_ R _[n]_ achieving ( _Lπ,y⋆_ ) _♯π_ = _πX|Y_ = _y⋆_ for Gaussian _π_ . Why, then, the particular choice of _K_ = Σ _XY_ Σ _[†] Y Y_[, and in what sense is the EnKU preferable?][As it turns out,] answering this question requires an analysis in the _non-Gaussian_ regime. In this paper, we consider the conditioning of non-Gaussian distributions to provide a new characterization of the ensemble Kalman update, uniquely identifying it among affine maps through the exactness of its pushforward distributions. 

Before proceeding, we emphasize an important distinction from the existing literature. Prior work shows that the Kalman update is variance-minimizing among linear unbiased _point estimators c_ + _BY_ of _X_ ; i.e., the choice _B_ = _K_ , _c_ = E( _X_ ) _− K_ E( _Y_ ) is optimal in this class. It is the so-called best linear unbiased estimator (BLUE) [7, 15]. This notion of optimality is fundamentally different from our characterization, which is based on _distributional exactness_ and, in particular, considers the EnKU, which outputs an ensemble instead of a point estimate. 

**1.2. Summary of main results.** In order to formalize our uniqueness claim, note that the EnKU takes a pair ( _π, y⋆_ ) and returns an affine map _L_[EnKU] _π,y⋆_[.][As][such,][it][belongs][to][a][broader] class of transports that we term _affine conditioning maps_ . Below and throughout the paper, _P_ 2(R _[d]_ ) denotes the space of Borel probability distributions on R _[d]_ with finite second moment. 

Definition 1.1. _An_ affine conditioning map _is a mapping_ 

**==> picture [389 x 12] intentionally omitted <==**

_such that each Lπ,y⋆ admits the affine representation_ 

**==> picture [219 x 12] intentionally omitted <==**

**==> picture [288 x 12] intentionally omitted <==**

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**3** 

It is clear that the EnKU map _L_[EnKU] : ( _π, y⋆_ ) _�−→ L_[EnKU] _π,y⋆_ defined in Equation (1.2) is an affine conditioning map. Note, however, that _A_ , _B_ , and _c_ as in Definition 1.1 are much more general and allowed to depend on all of _π_ , particularly on all of its moments. We will often write _Lπ,y_ for _L_ to make this dependence explicit. 

Next, to distinguish the EnKU among affine maps, we define what it means to condition exactly. 

Definition 1.2. _Let π ∈P_ 2(R _[n] ×_ R _[m]_ ) _, y⋆ ∈_ R _[m] , and fix a version of the Markov kernel y �→ πX|Y_ = _y. We say that an affine map ℓ_ ( _x, y_ ) := _Ax_ + _By_ + _c with fixed A ∈_ R _[n][×][n] , B ∈_ R _[n][×][m] , c ∈_ R _[n]_ conditions exactly _at y⋆ for π if_ 

**==> picture [72 x 13] intentionally omitted <==**

_We say that an affine conditioning map L conditions exactly at y⋆ for π if ℓ_ := _Lπ,y⋆ conditions exactly at y⋆ for π. Further, if πY -a.s. in y⋆ it holds that L conditions exactly at y⋆ for π, then we say that L is an exact conditioning map for π. This is abbreviated by “L is exact for π” or simply “L is exact” if π is clear from the context._ 

Crucially, note that exact affine conditioning at _y⋆_ for _π_ requires a choice of the Markov kernel _πX|Y_ = _y_ , and we will only invoke this definition if such a choice was made beforehand. Exactness of _Lπ,y_ for _π_ , on the other hand, is independent of the choice of Markov kernel _πX|Y_ = _y_ . 

A simple covariance calculation shows that _L_[EnKU] _π,y⋆_ is indeed an exact conditioning map for any Gaussian _π_ . However, there are infinitely many other affine conditioning maps _Lπ,y⋆_ ( _x, y_ ) = _A_ ( _π, y⋆_ ) _x_ + _B_ ( _π, y⋆_ ) _y_ + _c_ ( _π, y⋆_ ) that are also exact for Gaussians. For example, for a fixed Gaussian _π_ and _y⋆ ∈_ R _[m]_ and for every choice of _F ∈_ R _[n][×][m]_ (assuming Cov( _X_ + _FY_ ) has full rank), there are choices _D ∈_ R _[n][×][n]_ and _c ∈_ R _[n]_ such that _ℓ_ ( _x, y_ ) = _D_ ( _x_ + _Fy_ ) + _c_ is exact. This is a simple consequence of the fact that _X_ + _FY_ is Gaussian and there is an affine transport map between any two non-singular Gaussians. (See also [7] for a complete characterization of these affine maps.) The natural question, then, is why the EnKU should be preferred among all such affine maps that achieve exact conditioning. As we will show, this choice can be justified by studying exact conditioning in the _non-Gaussian_ regime. To understand what distinguishes the EnKU among affine conditioning maps (and what does not), we study the _exact set_ of the EnKU, which we define for a general affine conditioning map _L_ as 

**==> picture [412 x 12] intentionally omitted <==**

We answer the following two questions in this paper, with formal results in Section 2: 

1. What is the set of distributions _π ∈P_ 2(R _[n] ×_ R _[m]_ ) for which the EnKU update _L_[EnKU] is an exact conditioning map, i.e., what is the exact set _E_[EnKU] := _E_ ( _L_[EnKU] )? 

2. Given a distribution _π ∈E_[EnKU] for which the EnKU is exact and an observation _y⋆ ∈_ R _[m]_ , is the EnKU update _L_[EnKU] _π,y⋆_ the _only_ affine map achieving exact affine conditioning? 

The first question is answered in Proposition 2.1. Importantly, _E_[EnKU] is substantially larger than the class of Gaussian distributions. In Theorem 2.7, we answer the second question: 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

**4** 

excluding certain strongly symmetric distributions, given _π ∈E_[EnKU] and _y⋆ ∈_ R _[m]_ , the EnKU update _L_[EnKU] _π,y⋆_ is the _only_ affine map that is exact for _π_ at _y⋆_ . 

Conversely, when choosing an affine conditioning map _L_ from the infinitely many possibilities, to reduce bias we may want an _L_ for which the set _E_ ( _L_ ) is maximally large. In Section 3, to study this maximally large set, we define _weakly observation-dependent affine conditioning maps_ as affine conditioning maps _L_ of the form 

**==> picture [189 x 13] intentionally omitted <==**

generalizing commonly used affine conditioning maps like the EnKU or square root updates [12, 13, 29, 43]. We investigate the size of the largest possible exact set that any weakly observation-dependent _L_ might have, which turns out to take the form 

**==> picture [152 x 27] intentionally omitted <==**

In Theorem 3.3 we show that the EnKU is exact on all of _F_ except for pathological counterexamples, thereby almost achieving the maximal level of exactness any weakly observationdependent affine conditioning map can have. More formally, we show that there is a small symmetry class _S_ nl _−_ dec _⊆F_ such that 

**==> picture [103 x 13] intentionally omitted <==**

This negative result concerning the potential enlargement of the EnKU exactness class through weakly observation-dependent affine transports is consistent with recent developments in learned ensemble filters [5,28,35], where the Kalman gain (corresponding to the matrix _B_ ) was explicitly made observation-dependent to enable conditioning on more general distributions. In particular, those learned maps were not merely weakly observation-dependent, allowing them to go beyond _F_ (see also Remark 3.4). 

**1.3. A comment on ensemble approximations.** In practical implementations, quantities depending on the population distribution _π_ are typically approximated through the empirical distribution 

**==> picture [183 x 33] intentionally omitted <==**

associated with an ensemble of _N_ particles. This leads to an empirical approximation of the conditional distribution, 

**==> picture [125 x 23] intentionally omitted <==**

In this paper, however, we carry out our analysis in the _mean-field_ setting, operating at the level of population distributions _π_ and the corresponding mean-field conditional distribution 

**==> picture [113 x 17] intentionally omitted <==**

This perspective is standard in the theoretical analysis of ensemble-based methods and provides a principled baseline for understanding their behavior [7, 34]. To justify this reduction 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**5** 

mathematically, let _d_ denote a probability metric on _P_ 2(R _[n]_ ). Then the discrepancy between the empirical posterior and the true conditional distribution admits the decomposition 

**==> picture [337 x 35] intentionally omitted <==**

The first “variance” term captures sampling error arising from a finite ensemble, while the second term reflects intrinsic bias of the population-level transport. To control the first term, classical concentration [14, 17, 22, 25] and techniques from propagation of chaos [8, 42] can be used to show that, given sufficient regularity, the variance is _O_ ( _N[−][α]_ ) for some parameter _α >_ 0 and a particular choice of metric _d_ ; see, e.g., [1, 25] for examples of such bounds. This decomposition shows that in regimes where the ensemble size _N_ is large, the _bias_ term dominates the error, making it natural to ask under what conditions this bias vanishes exactly—which is precisely the question addressed in this paper. We will also demonstrate this effect in our numerical experiments (Section 4). Since our analysis is carried out in the mean-field setting, important practical issues related to finite sample size—such as localization, covariance inflation, and direct analysis of small-ensemble behavior—are outside the scope of this work. Another important limitation of our analysis is that it is _single-step_ in nature, focusing on one step of (likelihood-free) Bayesian inference rather than multi-step filtering dynamics; as a result, we do not address issues such as long-term stability or error accumulation over time. Both categories of issues have been extensively studied elsewhere [4, 10, 19, 24, 34, 44, 45]. 

**1.4. Notation.** For _d ∈_ N, we always consider R _[d]_ with inner product _⟨·, ·⟩_ and Euclidean norm _∥· ∥_ 2. _Id_ , or simply _I_ , is the _d × d_ identity matrix. For a matrix _A_ , _A[⊤]_ is the 1 transpose, _A[†]_ the Moore–Penrose pseudoinverse, and _√A_ and _A_ 2 both denote the principal symmetric square root when _A ⪰_ 0. For an endomorphism/square matrix _A_ , we refer to the spectrum as _σ_ ( _A_ ). _ρ_ ( _A_ ) is the spectral radius of such a matrix. GL( _n_ ) is the general linear group. The Frobenius norm is written as _∥· ∥_ F. _Rθ ∈_ R[2] _[×]_[2] denotes the two-dimensional cos _θ −_ sin _θ_ rotation matrix _Rθ_ = , which rotates vectors in R[2] counterclockwise by angle sin _θ_ cos _θ_ � � _θ_ . For a random vector _X_ , its law/distribution is Law( _X_ ) _∈P_ 2(R _[d]_ ), expectation E( _X_ ), covariance Cov( _X_ ) = E �( _X −_ E _X_ )( _X −_ E _X_ ) _[⊤]_[�] , and centered version _X_ := _X −_ E _X_ . For a joint distribution _π ∈P_ 2(R _[n] ×_ R _[m]_ ), _πX ∈P_ 2(R _[n]_ ) and _πY ∈P_ 2(R _[m]_ ) denote the marginals on the first _n_ and last _m_ coordinates. _πX|Y_ = _y_ is a (fixed) version of the conditional distribution (a Markov kernel). Letting ( _X, Y_ ) _∼ π_ , define the cross-covariance Σ _XY_ ( _π_ ) := Cov( _X, Y_ ) and the auto-covariance Σ _Y Y_ ( _π_ ) := Cov( _Y_ ), both under _π_ . We omit the dependence on _π_ when _d_ it is clear from context. We say that _X_ 1 = _X_ 2 for random vectors _X_ 1 _, X_ 2 if they have the same distribution. The Dirac probability measure at _x_ is _δx_ . _T♯µ_ denotes the pushforward of a distribution _µ_ by a measurable map _T_ . _W_ 2 is the 2-Wasserstein distance on _P_ 2(R _[d]_ ). _S_[c] is the complement in _A_ of a subset _S ⊆A_ . 

**2. Characterizing the EnKF update.** As described in the introduction, it is well known that the EnKU, defined in (1.2), is exact for Gaussian distributions [23, 34]. In this section, we will go beyond Gaussian distributions by (i) identifying the set of distributions _E_[EnKU] = 

**6** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

_E_ ( _L_[EnKU] ) (recall (1.3)) on which the EnKU is exact; and (ii) understanding the structure of transport maps that are exact for some element of _E_[EnKU] . 

The EnKU works by taking every _x_ -sample and correcting it linearly with its corresponding increment _K_ ( _y⋆−y_ ). This reveals the underlying structure of the EnKU: rather than operating on a Gaussian assumption per se, it assumes that there is a linear relationship between _X_ and _Y_ . Informally, if we can approximately expand 

**==> picture [111 x 14] intentionally omitted <==**

for _Z_ independent of _Y_ , a matrix _M ∈_ R _[n][×][m]_ , and _O_ ( _Y_[2] ) small, then the EnKU will yield accurate results. The following proposition formalizes this idea, completely characterizing all distributions in _E_[EnKU] . 

Proposition 2.1. _Let_ Lin _be the class of linear maps from_ R _[n] ×_ R _[m] to_ R _[n] . Then the following equation fully characterizes the exact set of the EnKU:_ 

**==> picture [377 x 44] intentionally omitted <==**

A proof can be found in the appendix. 

_Remark_ 2.2. Note that the inclusion _⊇_ in the set equality above is closely related to [41, Remark 4], where exact and generally nonlinear transport-based conditioning is characterized from an independence viewpoint. Specifically, the authors remark that if a map _S ∈_ Lin is invertible in the _x_ -component, and satisfies _S_ ( _X, Y_ ) _⊥⊥ Y_ for ( _X, Y_ ) _∼ π_ , then the map _ℓ_ := _S_ ( _·, y⋆_ ) _[−]_[1] _◦ S_ implements exact conditioning, i.e., _ℓ♯π_ = _πX|Y_ = _y_ . The independentrendering choice _S_ ( _x, y_ ) = _x −_ Σ _XY_ Σ _[†] Y Y[y]_[recovers][precisely][the][EnKU][update.][Motivated] by this perspective, in settings where nonlinear structure is present—specifically, when there _d_ exist nonlinear features _ϕ_ such that _X_ = _ϕ_ ( _Z, Y_ ) for _Z ⊥⊥ Y_ —natural extensions of the EnKU have been proposed and studied, including the conditional mean filter (corresponding to _ϕ_ ( _Z, Y_ ) = _Z_ + _f_ ( _Y_ )) [18,26] and the stochastic map filter (where _ϕ_ has triangular structure [41]). 

The question we answer in the remainder of this section is whether there can be _other_ affine transports 

**==> picture [219 x 13] intentionally omitted <==**

besides the EnKU, that achieve exactness for _π ∈E_[EnKU] . To gain some intuition, we go back to the set of Gaussian _π_ , which is clearly contained in _E_[EnKU] . As we explained in the introduction, there are many other affine maps implementing exact conditioning for Gaussian joint distributions _π_ . The fundamental reason for this degree of freedom in the choice of _L_ is that Gaussian distributions have strong symmetries. The distribution of a Gaussian vector is a _stable distribution_ , meaning that the sum of two independent Gaussians is again Gaussian [30, 37, 49].[1] As a consequence, Gaussians are _self-decomposable_ : specifically, letting 

> 1Gaussians are the only stable random variables with finite second moment [14]. 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**7** 

_G_ denote a Gaussian random vector in R _[d]_ , _G_ is _λ-decomposable_ for every _λ ∈_ (0 _,_ 1) [27,33,38], meaning that there exists another independent Gaussian vector _Gλ_ such that 

**==> picture [69 x 15] intentionally omitted <==**

Another strong symmetry possessed by non-degenerate Gaussian vectors _G_ is a rescale-thenrotate symmetry: there is a matrix _C ∈_ R _[d][×][d]_ (e.g., the inverse of any square root of the covariance matrix) such that the distribution of _CG_ is invariant under any rotation. In the following theory, we will demonstrate that it is due to these symmetries that there are many possible choices of exact affine conditioning maps for Gaussians. A third symmetry leading to many possible choices of conditioning maps is when _Z ∼ ν_ corresponding to some _π ∈E_[EnKU] has constant components, meaning that _v[⊤] Z_ is a.s. constant for some _v_ = 0 (equivalently, that _Z_ has a singular covariance matrix). 

Generalizing these three symmetries (namely, _λ_ -decomposability of the joint distribution, the rescale-then-rotate symmetry, and singular covariance matrices) to non-Gaussian joint distributions leads to the final EnKU characterization result presented in Theorem 2.7. 

Definition 2.3. _We define the sets S_ cov _, S_ dec _, S_ cyc _⊆E_[EnKU] _. Consider any π ∈E_[EnKU] _, meaning that there exists ν ∈P_ 2(R _[n]_ ) _and a linear map M from_ R _[m] to_ R _[n] such that for Y ∼ πY and Z ∼ ν with Y and Z independent,_ ( _Z_ + _MY, Y_ ) _∼ π. Then π ∈S_ cov _if and only if ν has singular covariance. π ∈S_ dec _if and only if there exist complex vectors v ∈_ C _[n] \ {_ 0 _}, w ∈_ C _[m] , and a constant λ ∈_ C _, |λ| <_ 1 _such that_ 

**==> picture [101 x 32] intentionally omitted <==**

~~(~~ _k_ ) _for i.i.d. copies Y of Y . π ∈S_ cyc _if and only if there exist real vectors v_ 1 _, v_ 2 _∈_ R _[n] \ {_ 0 _} such that Z_ cyc = ( _v_ 1 _[⊤][Z, v]_ 2 _[⊤][Z]_[)] _[⊤][satisfies][cyclic][symmetry][of][some][order][k][∈]_[N] _[≥]_[2] _[,][meaning][that]_ 

**==> picture [87 x 17] intentionally omitted <==**

_where Rθ is the two-dimensional rotation by angle θ._ 

We make two remarks about this definition. 

_Remark_ 2.4. Note that _S_ cov _⊂S_ dec by choosing _v ∈_ Ker(Cov( _Z_ )) _\ {_ 0 _}_ and _w_ = 0. 

_Remark_ 2.5. We clarify how Gaussian distributions relate to the three symmetry classes _S_ cov, _S_ dec, and _S_ cyc. Let ( _X, Y_ ) _∼ π_ = _N_ ( _µ,_ Σ) be jointly Gaussian and write ( _X, Y_ ) = ( _Z_ + _MY, Y_ ) with _M_ = Σ _XY_ Σ _[†] Y Y_[.] Then the covariance of _Z_ is the Schur complement Cov( _Z_ ) = Σ _XX −_ Σ _XY_ Σ _[†] Y Y_[Σ] _[Y X][,]_[ which coincides with the posterior covariance.][In particular,] _π ∈S_ cov if and only if the posterior distribution is singular. Next, consider the class _S_ dec. If Cov( _Z_ ) is singular, then _π ∈S_ dec (see the previous remark). If Cov( _Z_ ) is non-singular, then _π ∈S_ dec if and only if _Y_ is non-constant, by additive closedness of Gaussians. Finally, _π ∈S_ cyc always holds for Gaussian distributions since after centering, Gaussians are invariant under sign flips, corresponding to cyclic symmetry of order _k_ = 2. 

**8** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

Within _E_[EnKU] , each of the symmetry classes above carves out a highly non-generic and “small” subset of distributions. Smallness here can be quantified by the number of constraints defining the set. If _π ∈S_ cov, then _ν_ has singular covariance, so _Z_ lives almost surely in a proper affine subspace of R _[n]_ . Let _π ∈S_ dec. Then one linear functional of _Z_ is a geometrically weighted infinite linear combination of a _single_ functional of _Y_ in distribution, imposing infinitely many scalar constraints. In particular, this identity forces _λ_ -decomposability of _v[⊤] Z_ , which is a special non-generic property [27, 33, 38]. A simple way of seeing that _λ_ -decomposability for a random variable _U_ with characteristic function _ϕU_ is easily violated is to note that the defining equation _ϕU_ ( _t_ ) = _ϕU_ ( _λt_ ) _ϕUλ_ ( _t_ ) is unsatisfiable for many characteristic functions with zeros (e.g., uniform distribution, atoms, etc.). Further, _π ∈S_ dec forces the decomposition variable to be a projection _w[⊤] Y_ , imposing a strong self-similar convolution equation on the joint distribution. If _π ∈S_ cyc, there are _v_ 1 _, v_ 2 = 0 so that the two-dimensional projection _Z_ cyc = ( _v_ 1 _[⊤][Z, v]_ 2 _[⊤][Z]_[) is invariant under the finite rotation group] _[ {][R]_ 2 _πm/k[}] m[k][−]_ =0[1][,][imposing strong] symmetry constraints. 

_Remark_ 2.6. Alternatively, smallness of the sets _S_ cov _, S_ dec _, S_ cyc can be understood topologically when ignoring the case of singular observation covariance. Define 

**==> picture [219 x 15] intentionally omitted <==**

and endow it with the relative _W_ 2-topology. Then, _S_ dec _∩E_ 0[EnKU] and _S_ cyc _∩E_ 0[EnKU] are meagre subsets of _E_ 0[EnKU] . In particular, _S_ cov is a meagre subset of _E_ 0[EnKU] . A formal version of this statement appears in the supplement **??** . 

Although the EnKU is exact on each of these symmetry classes, the proof of the following theorem reveals that there are many other affine conditioning maps that are also exact on _S_ cov, _S_ dec, or _S_ cyc. Yet the theorem also shows that as soon as our distribution violates one of these symmetries, the space of possible affine filters contracts sharply. Before presenting the theorem, we uniquely fix the choice of Markov kernel for a given _π ∈E_[EnKU] : let _K_ = Σ _XY_ Σ _[†] Y Y_ where Σ is the covariance matrix of _π_ and define _Z_ = _X − KY_ . Whenever we write down the Markov kernel _πX|Y_ = _y⋆_ , we refer to the choice with distribution given by _Z_ + _Ky⋆_ . The “ _⊆_ ” part in the proof of Proposition 2.1 demonstrates that this is indeed a valid Markov kernel for _π_ . 

Theorem 2.7. _Consider π ∈E_[EnKU] _. Pick some y⋆ ∈_ R _[m] and assume that ℓ_ ( _x, y_ ) = _Ax_ + _By_ + _c conditions exactly for π at y⋆._ 

1. _If π ∈S/_ cov _, then ρ_ ( _A_ ) _≤_ 1 _, and A is diagonalizable on the direct sum of generalized eigenspaces corresponding to eigenvalues λ ∈_ C _with |λ|_ = 1 _._ 

2. _If π ̸∈S_ dec _, then A has no complex eigenvalues with magnitude smaller than_ 1 _and_ 

**==> picture [117 x 15] intentionally omitted <==**

**==> picture [407 x 28] intentionally omitted <==**

3. _If π ̸∈S_ cyc _, then A has no complex eigenvalues with |λ|_ = 1 _and λ ̸_ = 1 _._ 

A proof is included in the appendix. Note that the third point, _π ̸∈S_ cyc, can _never_ occur for Gaussian distributions, while the second, _π ̸∈S_ dec, arises only in pathological edge cases (see 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**9** 

**==> picture [443 x 304] intentionally omitted <==**

**Figure 1.** _Theorem 2.7 shows for any given π ∈E_[EnKU] _that for any symmetry S_ cov _, S_ dec _, S_ cyc _it violates, strong structural constraints are imposed on any affine conditioning map Ax_ + _By_ + _c. By Corollary 2.8, if it violates all these symmetries, Ax_ + _By_ + _c must be the EnKU. This corresponds to the region outside S_ cov _, S_ dec _, and S_ cyc _in the diagram._ 

Remark 2.5), underscoring that our characterization fundamentally relies on non-Gaussian structure. The following corollary, also proved in the appendix, explains that if a distribution violates all three of these symmetries, the only possible exact affine update is the EnKU. To rule out spurious offsets in the constant _c_ , we assume Σ _Y Y_ is invertible. This is natural: singular directions of _Y_ carry no information and can be projected out a priori. 

Corollary 2.8. _Consider π ∈E_[EnKU] _with non-singular covariance_ Σ _Y Y . Pick some y⋆ ∈_ R _[m] and assume that ℓ_ ( _x, y_ ) = _Ax_ + _By_ + _c is an exact affine transport for π at y⋆. If π ̸∈S_ cov _, π ̸∈S_ dec _, and π ̸∈S_ cyc _, then ℓ is the EnKU:_ 

**==> picture [105 x 16] intentionally omitted <==**

This is a unique characterization result of the EnKU. As the set of symmetry-free distributions is the largest part of _E_[EnKU] , Corollary 2.8 supports defaulting to the EnKU to avoid bias within _E_[EnKU] . Moreover, even if some of these symmetries hold, one would still need to identify them in order to construct an exact conditioning map—a requirement that seems inefficient in practical and sample-constrained settings. 

**10** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

**3. Beyond the ensemble Kalman update.** The previous section established that, apart from a small symmetry class _S_ cov _∪S_ dec _∪S_ cyc, the ensemble Kalman update (EnKU) is the unique affine conditioning map that is exact for any element _π ∈E_[EnKU] and observation _y⋆ ∈_ R _[m]_ . This observation raises a natural concern: perhaps the restriction to _E_[EnKU] is too limiting. If one were to consider different affine conditioning maps _Lπ,y⋆_ , could the associated exact set _E_ ( _Lπ,y⋆_ ) be strictly larger than _E_[EnKU] ? In other words, is it possible to design an update rule that is exact for a much broader class of distributions, thereby outperforming the EnKU in terms of bias reduction? 

**3.1. Maximal exactness of weakly observation-dependent affine conditioning maps.** To investigate this possibility, we extend our analysis to the family of _weakly observationdependent affine conditioning maps_ taking the form 

**==> picture [316 x 13] intentionally omitted <==**

Our restriction to this class is motivated by practice: these maps are general enough to cover most update rules practically used in high-dimensional ensemble-based data assimilation [12, 13, 29, 43]. In particular, they encompass commonly used deterministic alternatives such as square root updates. Therefore, weakly observation-dependent affine conditioning maps provide a natural framework in which to ask whether moving beyond the EnKU can substantially enlarge the domain of exactness. Define 

**==> picture [152 x 26] intentionally omitted <==**

The set _F_ is the maximal exact set achievable by any single weakly observation-dependent affine update. We give a simple necessary characterization criterion for elements of _F_ . 

Proposition 3.1. _Let π ∈F. Then there exists a Markov kernel πX|Y_ = _y, a measurable d_ : R _[m] →_ R _[n] , and ν ∈P_ 2 (R _[n]_ ) _such that_ 

**==> picture [162 x 13] intentionally omitted <==**

_where we define the translation operator on distributions Th_ : _P_ 2 (R _[n]_ ) _→P_ 2 (R _[n]_ ) _through Thµ_ := ( _x �→ x_ + _h_ ) _♯µ for every h ∈_ R _[n] . Also, d is πY -a.s. unique up to jointly translating ν and d._ 

A proof can be found in the appendix. Before stating the main result of this section, we introduce the class _S_ nl _−_ dec _⊆F_ , where nl-dec denotes “nonlinearly decomposable.” 

Definition 3.2. _We define S_ nl _−_ dec _⊆F. Let π ∈F and let_ ( _ν, d_ ) _be defined as in Proposition 3.1. Set Z ∼ ν and Y ∼ πY independently. Then we say π ∈S_ nl _−_ dec _if and only if there exist complex vectors v ∈_ C _[n] \ {_ 0 _}, w ∈_ C _[m] , u ∈_ C _[n] , and constants λ ∈_ C _, |λ| <_ 1 _, b ∈_ C _such that_ 

**==> picture [317 x 32] intentionally omitted <==**

_for i.i.d. copies {Y_[(] _[k]_[)] _}k≥_ 0 _of Y ._ 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**11** 

This class is “small” in the same sense as our earlier symmetry classes; it is defined by invariance identities (e.g., a generalized _λ_ -decomposition tying a one-dimensional nonlinear feature of the _Y_ -marginal to a linear functional of _Z_ ). 

Theorem 3.3. _The set of all π ∈P_ 2 (R _[n] ×_ R _[m]_ ) _that have a weakly observation-dependent exact affine update decomposes as_ 

**==> picture [103 x 13] intentionally omitted <==**

The theorem is proved in the appendix and shows that weak observation dependence leaves essentially no room to beat the EnKU: the maximal exact set collapses to _E_[EnKU] up to the small symmetry class _S_ nl _−_ dec. Practically, unless this special nonlinear decomposability can be exploited, any weakly observation-dependent affine rule cannot exceed the exactness domain of the EnKU; in this sense, the EnKU is _almost_ optimal among weakly observation-dependent affine conditioning maps. Nevertheless, _S_ nl _−_ dec _∩_ ( _E_[EnKU] )[c] , with[c] denoting the complement in _F_ , is _nonempty_ : there exist carefully constructed distributions satisfying (3.2) for which exact weakly observation-dependent conditioning is possible while the EnKU is not exact. We give such an example in Subsection 4.2. 

**3.2. Observation-dependent gain.** The maximality result above hinges on the restriction that _A_ ( _π_ ) and _B_ ( _π_ ) are independent of _y⋆_ . If we drop this and allow _fully observationdependent_ affine maps _Lπ,y⋆_ ( _x, y_ ) = _A_ ( _π, y⋆_ ) _x_ + _B_ ( _π, y⋆_ ) _y_ + _c_ ( _π, y⋆_ ), the situation changes: one can engineer many non-Gaussian _π_ with exact affine transports that lie strictly beyond _E_[EnKU] . We present the following example. 

Example 3.1. _Consider any distribution η ∈P_ (R) _and measurable function f_ : R _→_ R _. Define π by pushing forward through ϕ_ : R[2] _→_ R[2] _, ϕ_ ( _z, y_ ) = ( _f_ ( _y_ ) _z, y_ ) _:_ 

**==> picture [83 x 13] intentionally omitted <==**

_Clearly π is not in F for general f and has the exact affine conditioning map Ly⋆_ ( _x, y_ ) = _f_ ( _y⋆_ ) _y._ 

Another example is as follows. 

Example 3.2. _Consider the hypercube C_ = [0 _,_ 1][2] _and any orthogonal R ∈ O_ (2) _. Let_ ( _X, Y_ ) _∼_ Unif ( _RC_ ) _be uniformly distributed. For any y[⋆] in the support of Y there are a_ ( _y[⋆]_ ) _, b_ ( _y[⋆]_ ) _such that_ 

**==> picture [155 x 12] intentionally omitted <==**

_Thus, an exact affine conditioning map is, for example,_ 

**==> picture [221 x 14] intentionally omitted <==**

_Remark_ 3.4. This perspective aligns with recent “learned ensemble filters” [5,28,35], where the analysis maps are chosen as _Lπ,y⋆_ ( _x, y_ ) = _x_ + _B_ ( _π, y⋆_ ) _y_ + _c_ ( _π, y⋆_ ), with the gain terms _B_ and _c_ parameterized by a neural network in an observation-dependent manner. A complementary practical example of choosing _B_ in an observation-dependent way to enlarge the exactness domain—here to include Student- _t_ distributions—is given in [32]. Our negative 

**12** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

result in Theorem 3.3 for weakly observation-dependent maps helps understand why these methods pursue observation-dependent updates: without such dependence, there is essentially no headroom beyond EnKU, whereas allowing _B_ to depend on _y⋆_ (and of course on _π_ ) can potentially realize exact updates for broader constructions. An interesting direction is to understand the enlargement of the exactness class, relative to _F_ , when _A_ and _B_ are allowed to depend on _y⋆_ . 

**4. Numerical experiments.** This section illustrates the two main points of our paper empirically. First, in Subsection 4.1, we demonstrate that the EnKU remains bias-free for highly non-Gaussian and structurally complex joint distributions, whereas other affine updates that are exact only at the level of first and second moments fail for these examples. This behavior supports the uniqueness result of Theorem 2.7 (and Corollary 2.8) within the class _E_[EnKU] . Second, in Subsection 4.2, we present a carefully constructed example from the highly structured class _S_ nl-dec appearing in Theorem 3.3, for which an exact weakly observationdependent affine conditioning map exists while the EnKU is inexact. This example illustrates our maximality result by showing that failures of the EnKU can occur for such pathological elements of _F_ . 

**4.1. Within** _E_[EnKU] **.** We test our main claim in Theorem 2.7 empirically: in the mean-field limit and within affine conditioning maps, the EnKU is the only method that remains exact beyond highly symmetric distributions (such as Gaussians) within _E_[EnKU] . To also account for finite sample effects, we consider the likelihood-free Bayesian inference problem 

**==> picture [420 x 33] intentionally omitted <==**

For this task, we compare several affine conditioning maps _L_ to the EnKU, producing samples of the form 

**==> picture [269 x 13] intentionally omitted <==**

where _π_ � _N_ denotes the empirical distribution of the joint samples _{_ ( _Xi, Yi_ ) _}[N] i_ =1[.][We][study] the resulting approximations as the ensemble size _N_ increases. Specifically, we pick three joint distributions _π ∈E_[EnKU] in dimension _n_ = _m_ = 2, defining them through a distribution _ν ∈P_ 2 (R _[n]_ ) and a linear map _O_ ( _z, y_ ) = _z_ + ([10] 0[100] 1[)] _[ y]_[just][as][in][Equation][(][2.1][).][Thus,] _[π]_[is] fully defined by the marginal choices for _Z ∼ ν_ and _Y ∼ πY_ (listed below), while preserving the linear coupling that places each example in _E_[EnKU] . We test the following three instances of ( _X, Y_ ) _∼ π_ , intentionally constructed to be challenging and ill-conditioned in order to illustrate our theory. 

_•_ Experiment 1 (Gaussian): As a sanity check, we consider the standard linear-Gaussian problem that classically motivates ensemble filters, namely 

**==> picture [165 x 12] intentionally omitted <==**

As mentioned in the introduction, infinitely many affine transports result in exact conditioning for Gaussians in the mean-field. We use 

**==> picture [207 x 27] intentionally omitted <==**

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**13** 

- Experiment 2 (Gaussian mixtures): This is an example of a distribution that is in the set _E_[EnKU] but strongly multimodal and non-Gaussian: 

**==> picture [287 x 34] intentionally omitted <==**

The parameters _wℓ_ , _µℓ_ , and Σ _ℓ_ are drawn independently from 

**==> picture [245 x 58] intentionally omitted <==**

with Dir denoting the Dirichlet distribution, **1** 6 the vector of 6 ones, covariance matrix 

**==> picture [87 x 27] intentionally omitted <==**

and _C_ defined as the law of the matrix _M_ in 

**==> picture [281 x 33] intentionally omitted <==**

- Experiment 3 (elliptical ring density): We consider another strongly non-Gaussian distribution that is in _E_[EnKU] . Consider _K_ = 3 rings and _M_ = 6 angular modes. We spread out the radii _ℓr, r_ = 1 _, ..., K_ uniformly between _ℓ_ 1 = 1 _._ 4 and _ℓK_ = 4 _._ 0. Consider an independently uniformly distributed ring mode _r ∼_ Unif( _{_ 1 _, . . . , K}_ ) and angular mode _j ∼_ Unif( _{_ 1 _, . . . , M }_ ) with centers _µj_ =[2] _M[π][j]_[.][Conditioning][on][(] _[r, j]_[),][let] 

**==> picture [213 x 14] intentionally omitted <==**

with vM denoting the von Mises distribution and _σ_ = 0 _._ 2. This defines the random variable _U_ with ring density through the polar parametrization 

**==> picture [75 x 27] intentionally omitted <==**

We break Euclidean 6-fold rotational symmetry by defining 

**==> picture [76 x 28] intentionally omitted <==**

For _Y_ , we consider a Gaussian mixture with 6 components, sampled as in Experiment 2, with the modification that _µ_[(] _k[Y]_[ )] i.i.d. _∼N_ (0 _,_ ([150] 0[0] 1[))] _[ , k]_[= 1] _[, . . . ,]_[ 6] _[.]_ 

**14** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

**==> picture [443 x 258] intentionally omitted <==**

**----- Start of picture text -----**<br>
Experiment 1 Experiment 2<br>6.00<br>0.60<br>4.00<br>3.00<br>0.40<br>0.30 L [EnKU] 2.00 L [EnKU]<br>L [D] L [D]<br>L [OT] L [OT]<br>0.20<br>10 [2] 10 [3] 10 [2] 10 [3]<br>N N<br>Experiment 3<br>1.00<br>0.60<br>L [EnKU]<br>L [D]<br>0.40<br>L [OT]<br>0.30<br>10 [2] 10 [3]<br>N<br>W 2 W 2<br>W 2<br>**----- End of picture text -----**<br>


**Figure 2.** _Convergence of affine updates with ensemble size. Log-log W_ 2 _error versus ensemble size N for the three data-generating models. Experiment 1 (Gaussian): all Gaussian-exact affine maps exhibit decreasing error with N (no bias floor). Experiments 2 and 3 (non-Gaussian): EnKU continues to improve with N , whereas the alternative affine maps plateau at a nonzero bias floor, indicating mean-field bias under non-Gaussian structure. Error bars show mean ± standard error over_ 40 _Monte Carlo replicates. For Experiment 2, this also includes resampling of the model parameters._ 

For the posterior approximation in Equation (4.2), we will compare the EnKU, with Kalman gain _K_[ˆ] = Σ[ˆ] _XY_ Σ[ˆ] _[†] Y Y_[estimated][from][the][sample][covariances][ˆΣ,][to][two][other][affine] updates used in likelihood-free Bayesian inversion. First, we will compare to the non-stochastic choice, 

**==> picture [280 x 20] intentionally omitted <==**

which is, for example, introduced in [7]. _m_ ˆ _Y_ (resp. _m_ ˆ _X_ ) is the sample mean of _Yi_ (resp. _Xi_ ) and Σ[ˆ] _X|Y_ := Σ[ˆ] _X −_ Σ[ˆ] _XY_ Σ[ˆ] _[†] Y_[ˆΣ] _[Y X]_[.][All][square][roots][in][the][equation][above][are][principal][choices] and we define 

**==> picture [69 x 11] intentionally omitted <==**

for positive semidefinite square matrices _M_ . Second, we compare to another non-stochastic affine transport given by the _optimal transport_ solution, 

**==> picture [377 x 30] intentionally omitted <==**

The choices _L_[D] � _[L]_[OT] �[particular][versions][of][ensemble][square][root][filters—more] _πN ,y⋆_[and] _πN ,y⋆_[are] specifically, _ensemble adjustment Kalman filters_ (EAKF) [6, 20, 43, 48]. This can be seen by a 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**15** 

straightforward calculation of the mean and covariance. A fuller derivation, explaining connections to the EAKF and the ensemble transform Kalman filter (ETKF), is in Supplement A. 

**==> picture [443 x 333] intentionally omitted <==**

**----- Start of picture text -----**<br>
True L [EnKU] L [D] L [OT]<br>1<br>Experiment<br>2<br>Experiment<br>3<br>Experiment<br>**----- End of picture text -----**<br>


**Figure 3.** _Posterior structure recovered by each method for N_ = 8 _,_ 192 _samples (_ 49 _,_ 152 _samples for the true posterior). For each experiment, we show i.i.d. samples from the true posterior alongside posterior ensembles produced by EnKU, the deterministic map L_[D] _, and the OT map L_[OT] _. Densities are visualized using a two– dimensional Gaussian kernel density estimator with Scott’s rule and a reduced bandwidth factor of_ 0 _._ 6 _. In the Gaussian case (Experiment 1), all methods match the target shape. In the non-Gaussian cases (Experiments 2 and 3), the EnKU best preserves multimodality and ring structure, while L_[D] _and L_[OT] _blur or collapse features– visual evidence of the bias floor quantified in the W_ 2 _plots._ 

Each of these three affine maps is exact for Gaussian distributions at the mean-field level; accordingly, we expect all methods to recover the correct posterior in the Gaussian setting (Experiment 1). We condition on the fixed observation _y⋆_ = (0 _._ 4 _, −_ 0 _._ 2) _[⊤]_ . Ignoring finite sample effects, the particular value of _y⋆_ plays no role in the relative performance of the methods, since all updates depend on _y⋆_ exclusively through the same affine shift _Ky_[ˆ] _⋆_ . We run the affine ensemble algorithms at increasing ensemble sizes, investigating the _W_ 2-error of their predicted posterior compared to the true posterior. In Figure 2, we estimate the empirical _W_ 2 between the predicted analysis ensembles and i.i.d. samples from the ground-truth posterior 

**16** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

using POT’s `ot.emd2` algorithm for each ensemble size _N_ . The results match the meanfield predictions. In Experiment 1 (Gaussian), all three affine maps show error decreasing parametrically with _N_ and no bias floor. For distributions in _E_[EnKU] that are non-Gaussian (Experiments 2 and 3), the EnKU continues to improve as _N_ grows, while the alternative affine maps stabilize at a nonzero error, revealing a mean-field bias floor. The posterior density plots in Figure 3 demonstrate this further: the EnKU reproduces the multimodal and ring-like posterior structure, whereas the other affine updates smear or collapse features, consistent with their moment-matching but distributionally biased behavior. 

**4.2. Beyond** _E_[EnKU] **.** In order to illustrate the class _S_ nl-dec introduced in Theorem 3.3, we present a simple scalar ( _n_ = _m_ = 1) example _π_ that lies in the nonlinear decomposability class _S_ nl-dec but not in _E_[EnKU] , for which an exact weakly observation-dependent affine conditioning map exists, while the EnKU is biased. Let _Y ∼N_ (0 _,_ 1) and define the nonlinear shift _d_ ( _y_ ) := _y_[2] _−_ 1 _._ Fix _λ ∈_ (0 _,_ 1) and _B ∈_ R _\ {_ 0 _}_ . Let _{Y_[(] _[k]_[)] _}k≥_ 0 be i.i.d. copies of _Y_ , independent of _Y_ , and define 

**==> picture [297 x 32] intentionally omitted <==**

according to Equation (3.2), which converges in _L_[2] since _λ ∈_ (0 _,_ 1) and _Y_ , _d_ ( _Y_ ) have finite second moments. Define the joint distribution _π_ of ( _X, Y_ ) by _X_ := _Z_ + _d_ ( _Y_ ) _._ An exact weakly observation-dependent affine conditioning map is given by 

**==> picture [152 x 16] intentionally omitted <==**

as the following computation shows: 

**==> picture [203 x 55] intentionally omitted <==**

_d_ The second equality above follows from the fixed-point-in-distribution identity _Z_ = _λZ_ + _λd_ � _Y_ � + _BY,_ which is an immediate consequence of the definition in Equation (4.3). In particular, we have _π ∈F_ . Further, since E( _X | Y_ = _y_ ) = _d_ ( _y_ ) is nonlinear in _y_ , there does not exist a representation _X_ = _Z_ 0 + _MY_ with _Z_ 0 _⊥⊥ Y_ and _M ∈_ R. Consequently, _π ∈E/_[EnKU] by Proposition 2.1 and the EnKU is inherently biased for this distribution. Hence _π ∈S_ nl-dec. Indeed, in Figure 4 we compare the posterior distributions produced by the EnKU and by _L_[nl-dec] _π,y⋆_ according to the updating Equation (4.2) in finite samples. While _L_[nl-dec] _π,y⋆_ exactly recovers the true posterior, the EnKU is inexact for this distribution and exhibits strong bias. This illustrates that weakly observation-dependent affine conditioning maps can achieve exactness beyond the EnKU domain, but only for specially structured distributions. 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**17** 

**==> picture [443 x 217] intentionally omitted <==**

**----- Start of picture text -----**<br>
L [EnKU]<br>L [nl-dec]<br>True<br>− 5 0 5 10 15 20 25 30<br>x<br>posterior<br>(estimated)<br>of<br>Density<br>**----- End of picture text -----**<br>


**Figure 4.** _Posterior at y⋆_ = 5 _produced by L_[nl] _π,y[-]_[dec] _⋆ and L_[EnKU] _π,y⋆ using N_ = 10[6] _samples as in Equation_ (4.2) _, with parameters λ_ = 0 _._ 1 _and B_ = 1 _. Densities are estimated using kernel density estimation with Scott’s rule and a reduced bandwidth factor of_ 1 _._ 2 _. In agreement with our theoretical analysis, the exact weakly observation-dependent map Lπ,y_[nl] _[-]_[dec] _⋆ coincides with the true posterior, while the EnKU update is substantially biased, illustrating that exact affine conditioning beyond E_[EnKU] _can occur for highly structured nonlinear distributions._ 

Importantly, the example presented here is quite non-generic: it relies on the strong nonlinear decomposability condition in Equation (3.2) defining _S_ nl-dec, which severely restricts the class of admissible joint distributions. Accordingly, the purpose of this example is _not_ to advocate the use of the map _L_[nl-dec] _π,y⋆_ in practice, but rather to illustrate that departing from _E_[EnKU] in Theorem 3.3 requires detailed a priori knowledge of the joint distribution that is generally unavailable. 

**5. Discussion.** Our maximality result for weakly observation-dependent affine maps shows that there is essentially no headroom beyond the EnKU: the largest possible exact set _F_ collapses to _E_[EnKU] up to the narrow symmetry class _S_ nl _−_ dec (Theorem 3.3). Further, we show that within _E_[EnKU] , the EnKU is the unique affine exact conditioning map up to small symmetry classes _S_ cov, _S_ dec, and _S_ cyc (Theorem 2.7). 

Many questions remain open. Importantly, our analysis is mean-field and does not address many practical issues—finite- _N_ sampling error, localization, covariance inflation, model error/misspecification, and adaptive tuning schemes—which are known to strongly impact performance. Further, in practical data assimilation and inverse problems, the true joint distribution rarely lies in _E_[EnKU] and deviates even further from Gaussianity. Regardless, affine filters are applied in these settings. Therefore, another lens for studying the choice of affine filters is the bias–variance tradeoff. Affine filters are usually used in high dimensions where the dimension is large compared to the ensemble size, and where the ensemble is non-i.i.d. after one filtering step. For these two reasons, accepting bias in the estimator to reduce 

**18** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

variance is inevitable. Quantifying this tradeoff in nonlinear settings remains an important direction. A related open question is to treat the corresponding multi-step behavior of the EnKU (e.g., in ensemble Kalman inversion) and to understand how nonlinear effects re-enter through evolving covariances [21, 39, 40]. 

**Appendix A. Connection to ensemble square root filters.** Here, we clarify how the affine transports used in the numerical experiments relate to square root filters. Ensemble square root filters (ESRFs) are deterministic variants of the ensemble Kalman filter that update the ensemble without requiring perturbed observations, typically improving stability and accuracy [6,20,43,48]. They are usually derived in settings where we have access to i.i.d. samples _{Xi}[N] i_ =1 (“forecast”) and we have the dependency _Y_ = _HX_ + _ξ_ with linear _H_ , independent mean-zero _ξ_ , and Cov( _ξ_ ) = Γ finite. Define the forecast matrix _X_[ˆ] _f_ := ( _X_ 1 _. . . XN_ ) _∈_ R _[n][×][N]_ with _n_ the state dimension and the forecast covariance _C_[ˆ] _f_ := _N_ 1 _−_ 1 _[X]_[ˆ] _[f]_ � _IN − N_[1] **[11]** _[⊤]_[�] _[X]_[ˆ] _f[⊤]_[where] **[1]**[is][the] vector with all entries 1. The main idea in ESRFs is to find an affine map 

**==> picture [86 x 11] intentionally omitted <==**

such that with _X_[ˆ] _a_ := _s_ ( _X_[ˆ] _f_ ) we have the following Gaussian-consistent moment conditions: 

**==> picture [127 x 30] intentionally omitted <==**

where 

**==> picture [377 x 53] intentionally omitted <==**

The prediction for the posterior _πX|Y_ = _y⋆_ in an ESRF is then 

**==> picture [102 x 33] intentionally omitted <==**

where _X_[ˆ] _a[i]_[are][the][columns][of] _[X]_[ˆ] _[a]_[.][There][are][multiple][versions][of][ESRFs][as][the][choice][of] _[s]_[is] not unique. The most important versions of the ESRF are the ensemble transform Kalman filter (ETKF) [6, 43] and the ensemble adjustment Kalman filter (EAKF): 

ˆ 1. Theˆ ETKF is defined by requiring _s_ to operate on the anomaly matrix _Xf_[(] _[c]_[)] = _Xf_ � _IN − N_[1] **[11]** _[⊤]_[�] in ensemble space 

**==> picture [103 x 18] intentionally omitted <==**

_T_ whereˆ _∈_ R _[N]_[ˆ] _b[×] ∈[N]_ Ris _[n]_ thereforeis a bias terma matrixuniquelysatisfyingdeterminedthe second-momentby the first-orderconditioncondition [6, 20] . 

**==> picture [279 x 24] intentionally omitted <==**

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**19** 

The unique principal square root of the right-hand side has been shown to be particularly stable. It is usually chosen for _T_[ˆ] [20, 29, 36, 46]. This is unsurprising since it is ˜ the choice that is the “least transformative,” i.e., _√M_ = arg ˜ min _M − I M M_[˜] _[⊤]_ = _M_ ��� ��� _F_[for] 

_√·_ the principal square root, _M_ positive semidefinite, and _∥· ∥F_ the Frobenius norm. Therefore, we let 

**==> picture [273 x 27] intentionally omitted <==**

be the principal square root. 

2. The EAKF, on the other hand, acts on the rows of the anomaly matrix [3,43], meaning that 

**==> picture [107 x 18] intentionally omitted <==**

**==> picture [197 x 14] intentionally omitted <==**

**==> picture [68 x 15] intentionally omitted <==**

The symmetric solution for this equation is given by 

**==> picture [171 x 30] intentionally omitted <==**

with all square roots taken as the principal choice. Another possible choice is 

**==> picture [83 x 21] intentionally omitted <==**

In practice, the following choice of square root is used more frequently instead [3,16,43]: let 

**==> picture [151 x 18] intentionally omitted <==**

where _X_[ˆ] _f_[(] _[c]_[)] = _FGU[T]_ is the SVD and ( _X_[ˆ] _f_[(] _[c]_[)][)] _[⊤][H][⊤]_[Γ] _[−]_[1] _[H][X]_[ˆ] _f_[(] _[c]_[)] = _CDC[T]_ is the eigenvalue decomposition with the eigenvectors in the null space arranged as the final columns of _C_ . 

As we do not make the linear assumption _Y_ = _HX_ + _ξ_ in our paper, we need to translate the expressions for _T_[ˆ] and _A_[ˆ] to this more general setting. Doing this for the EAKF is immediate. We simply replace the estimated analysis covariance with its population counterpart: 

**==> picture [281 x 24] intentionally omitted <==**

This shows directly that _L_[OT] _y⋆_ and _L_[D] _y⋆_[implement][the][EAKF][updates] _[A]_[ˆ][(1)][and] _[A]_[ˆ][(2)][.][For][the] ETKF, the idea is similar. Starting with _T_[ˆ] , we note that the expression containing _HX_[ˆ] _f_[(] _[c]_[)] or Γ involves prior knowledge of the covariance structure, namely the assumption _Y_ = _HX_ + _ξ_ . The generalization of _T_[ˆ] to nonlinear settings is therefore 

**==> picture [207 x 33] intentionally omitted <==**

**20** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

with _Y_[ˆ] _f_[(] _[c]_[)] _∈_ R _[m][×][N]_ the centered ensemble matrix of the observations _Yi_ . As the second term in _T_[ˆ] _[′]_ is a projection onto the row space of _Y_[ˆ] _f_[(] _[c]_[)] , _T_[ˆ] _[′]_ is the principal square root of a projector onto the orthogonal complement of the row space of _Y_[ˆ] _f_[(] _[c]_[)] . Orthogonal projectors are their own principal square roots and therefore 

**==> picture [199 x 29] intentionally omitted <==**

However, now note that 

**==> picture [247 x 51] intentionally omitted <==**

This shows that the generalized ETKF and the EnKU perform the same update. In that sense, everything we say above about the EnKU applies to the ETKF as they are the same outside the linear-Gaussian setting. 

_Remark_ A.1. The presented “generalizations” of the ESRF are not meant to be good filtering methods. In fact, they forfeit the main advantage of ESRFs, namely the deterministic (non-stochastic) update. The point of introducing them above lies instead in providing insight into the bias inherent in ESRF methods and clarifying their connection to the EnKU. 

**Appendix B. Proofs.** We start by presenting a proof of Proposition 2.1 

_Proof of Proposition 2.1. ⊆_ : Pick _π ∈E_[EnKU] , meaning that 

**==> picture [106 x 18] intentionally omitted <==**

_πY_ -a.s. in _y⋆ ∈_ R _[m]_ . Letting ( _X, Y_ ) _∼ π_ and defining _Z_ = _X − KY_ , the equation above is equivalent to 

Law ( _Z_ + _Ky⋆_ ) = _πX|Y_ = _y⋆._ 

Since _Z_ does not depend on _y⋆_ , this shows that for _ν_ = Law( _Z_ ) and _O_ ( _x, y_ ) = _x_ + _Ky_ we have 

**==> picture [98 x 14] intentionally omitted <==**

_πY_ -a.s. in _y⋆_ . _O_ ( _·, y⋆_ ) _♯ν_ is a Markov kernel, concluding this direction. 

_⊇_ : Consider _π_ and its corresponding _O_ and _ν_ as in the right-hand side of the equation we prove in this proposition. Write _O_ ( _x, y_ ) = _A_ 1 _x_ + _A_ 2 _y_ for matrices _A_ 1 _∈_ R _[n][×][n]_ , _A_ 2 _∈_ R _[n][×][m]_ , and let _Z ∼ ν_ . Then _πX|Y_ = _y_ = Law( _A_ 1 _Z_ + _A_ 2 _y_ ) _._ Let _Y ∼ πY_ , independent of _Z_ , so that ( _X, Y_ ) := ( _A_ 1 _Z_ + _A_ 2 _Y, Y_ ) _∼ π_ . By direct computation, 

**==> picture [280 x 12] intentionally omitted <==**

Therefore, _L_[EnKU] _π,y[⋆]_[(] _[x, y]_[) =] _[ x]_[ +] _[ A]_[2][Σ] _[Y Y]_[ (] _[π]_[)Σ] _Y Y[†]_[(] _[π]_[)(] _[y][⋆][−][y]_[)] _[.]_[Let] _[Y]_[˜] _[∼][π][Y]_[ ,][independent][of][(] _[Z, Y]_[ ).] Define the projection _PY_ := Σ _Y Y_ ( _π_ )Σ _[†] Y Y_[(] _[π]_[),][the][orthogonal][projection][onto][Im(Σ] _[Y Y]_[ (] _[π]_[)).] 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**21** 

**==> picture [444 x 59] intentionally omitted <==**

concluding the proof. 

Similarly, we can show Proposition 3.1. 

_Proof of Proposition 3.1._ Let _π ∈F_ . Then there exists a weakly observation-dependent affine map 

**==> picture [185 x 13] intentionally omitted <==**

and a Markov kernel such that there is a Borel set _Q ∈B_ (R _[m]_ ) with _πY_ ( _Q_ ) = 1 and 

**==> picture [96 x 13] intentionally omitted <==**

for all _y⋆ ∈ Q_ . Since _A_ and _B_ do not depend on _y⋆_ , for any _y_ 0 _, y⋆ ∈ Q_ we have 

**==> picture [126 x 12] intentionally omitted <==**

where we set _ν_ := _πX|Y_ = _y_ 0. Now, we construct a measurable _d_ ( _·_ ) such that 

**==> picture [123 x 12] intentionally omitted <==**

for all _y⋆ ∈ Q_ and note that this concludes the proof. Define _d_ : R _[m] →_ R _[n]_ through 

**==> picture [182 x 41] intentionally omitted <==**

For any Borel set _W ∈B_ (R _[n]_ ) we have 

_d[−]_[1] ( _W_ ) = ( _Q ∩ d[−]_[1] ( _W_ )) _∪_ ( _Q_[c] if 0 _∈ W_ ) = _d[−] |Q_[1][(] _[W]_[)] _[ ∪]_[(] _[Q]_[c][if][0] _[ ∈][W]_[)] 

meaning that all we have to show is that the restriction _d|Q_ is measurable. Consider the translation map 

**==> picture [166 x 12] intentionally omitted <==**

where _P_ 2(R _[n]_ ) is endowed with the Wasserstein-topology. The map Φ is continuous and injective; by the Lusin–Souslin Theorem [9, Lemma 8.3.8] and since R _[n]_ and _P_ 2(R _[n]_ ) are Polish spaces, the inverse on its image _O_ = Φ(R _[n]_ ), namely 

**==> picture [143 x 11] intentionally omitted <==**

is measurable with respect to the Borel algebra induced by the subspace topology of _O_ . By the first part of the proof in [2, Lemma 12.4.7], the map _y �→ πX|Y_ = _y_ is _B_ (R _[m]_ )-to-Borel( _P_ 2(R _[n]_ )) measurable; hence its restriction _Q →P_ 2(R _[n]_ ) is ( _Q, B_ ( _Q_ ))-measurable. We established that on _Q_ we have _πX|Y_ = _y ∈O_ and thus we have that 

**==> picture [155 x 15] intentionally omitted <==**

and _d|Q_ is measurable as a composition of measurable maps _y �→ πX|Y_ = _y �→_ Ψ( _πX|Y_ = _y_ ). _Td_ ( _y⋆_ ) _ν_ is a valid choice of Markov kernel by measurability of _d_ . Further, _d_ is _πY_ -a.s. unique by _πY_ -a.s. uniqueness of Markov kernels. 

**22** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

The following theorem, while not explicitly stated in the main paper, is the main theoretical basis for the remaining results presented in this paper. 

Theorem B.1. _Let A ∈_ R _[n][×][n] and let U be an_ R _[n] -valued random vector with_ E _∥U ∥_[2] _< ∞. Assume X ∈_ R _[n] is independent of U . Consider the fixed-point-in-distribution equation_ 

(B.1) _X_ = _[d] AX_ + _U._ 

_By the real Jordan decomposition, there exist A-invariant subspaces such that_ 

**==> picture [89 x 11] intentionally omitted <==**

_and for all restrictions A•_ := _A|V•, • ∈{u, s, r}_ 

1. _all complex eigenvalues of As have magnitude less than_ 1 

2. _all complex eigenvalues of Ar have magnitude equal to_ 1 

3. _all complex eigenvalues of Au have magnitude larger than_ 1 _. Further, decompose the complexification Vr_[C] _[⊆]_[C] _[n]_ 

**==> picture [84 x 14] intentionally omitted <==**

_with Vr_[(1)] _the space of all eigenvectors of Ar with eigenvalues |λ|_ = 1 _. Denote by P• the corresponding projections and write X•_ := _P•X, U•_ := _P•U . There exists a solution X with_ E _∥X∥_[2] 2 _[<][∞][to][Equation]_[(][B.1][)] _[if][and][only][if][U][u][and][U][r][are][a.s.][constant][vectors][and] Ur ∈_ Im( _I − Ar_ ) _a.s. The blockwise solutions, if they exist, satisfy:_ 

(a) _There is a_ unique _solution in distribution in the stable component given by_ 

**==> picture [83 x 32] intentionally omitted <==**

_where {Us_[(] _[k]_[)] _}k≥_ 0 _are i.i.d. copies of Us, independent of each other; the series converges in L_[2] _._ (b) _Xr_[(2)] _is a.s. constant._ 

(c) _Xu is a.s. constant with the a.s. value_ 

**==> picture [99 x 13] intentionally omitted <==**

Before presenting a proof, we need to show a few lemmas. 

Lemma B.2. _Consider a matrix B ∈_ R _[d][×][d] with ρ_ ( _B_ ) _<_ 1 _. Then there is a norm ∥· ∥ on_ R _[d] such that the operator norm satisfies ∥B∥ <_ 1 _._ 

_Proof._ The discrete Lyapunov equation 

**==> picture [84 x 11] intentionally omitted <==**

has a unique positive-definite solution _P ≻_ 0 [31]. Define the (equivalent) norm _∥x∥P_ := ( _x[⊤] Px_ )[1] _[/]_[2] . Then 

**==> picture [353 x 21] intentionally omitted <==**

Note that _∥x∥_[2] _P_[=] _[x][⊤][Px]_[=] _[x][⊤][B][⊤][PBx]_[ +] _[ ∥][x][∥]_[2] _I[≥∥][x][∥]_[2] _I_[implies][that] _[λ]_[max][(] _[P]_[)] _[≥]_[1.][Hence] _∥B∥P ≤_ ~~�~~ 1 _−_ 1 _/λ_ max( _P_ ) =: _q <_ 1 as claimed. 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**23** 

Lemma B.3. _Let J ∈_ R _[n][×][n] be a Jordan block for an eigenvalue |λ|_ = 1 _. Let Q ⪰_ 0 _. If a symmetric P ⪰_ 0 _satisfies the discrete Lyapunov (Stein) equation_ 

**==> picture [77 x 11] intentionally omitted <==**

_then necessarily Q_ = 0 _. Further, all entries of P but P_ 11 _must be zero. If instead |λ| >_ 1 _, there can only be a solution if P_ = _Q_ = 0 _._ 

_Proof._ Consider the case _|λ|_ = 1 first. If _n_ = 1 there is nothing to show, so we can assume _n >_ 1. Say _P ⪰_ 0 is a matrix satisfying the Lyapunov equation. Write _J_ = _λI_ + _N_ . Translating the Lyapunov equation _P_ = ( _λI_ + _N_ ) _P_ ( _λI_ + _N[T]_ ) + _Q_ into components, writing _pij_ and _qij_ for the entries of _P_ and _Q_ yields 

**==> picture [175 x 13] intentionally omitted <==**

for all _i, j_ with _pab_ = 0 if an index exceeds _n_ . We proceed by induction over _n_ + 1 _≥ m >_ 1 with the hypothesis that _qm,m_ = _pm,m_ = 0. Our inductive base is _m_ = _n_ + 1 for which there is nothing to show. Let _m >_ 1 and assume that _pm_ +1 _,m_ +1 = _qm_ +1 _,m_ +1 = 0. Then by CauchySchwarz also _pij_ = _qij_ = 0 if either _i_ or _j_ is _m_ + 1. The ( _i, j_ ) = ( _m, m_ ) equation tells us that _qm,m_ = 0. The ( _i, j_ ) = ( _m, m −_ 1) equation says _λpm,m_ + _qm,m−_ 1 = 0 and by Cauchy-Schwarz _qm,m−_ 1 = 0, showing that _pm,m_ = _qm,m_ = 0. This induction shows that _qij_ = _pij_ = 0 except for _i_ = _j_ = 1. Finally, the ( _i, j_ ) = (1 _,_ 1) equation is simply _qij_ = 0, completing the proof of the first part. 

Now let _|λ| >_ 1. Our strategy is to construct a unique solution to the unconstrained problem for _P_ and show uniqueness for this solution. Consider the series 

**==> picture [105 x 32] intentionally omitted <==**

Because _ρ_ ( _J[−]_[1] ) _<_ 1, by Lemma B.2 the sequence _∥J[−][k] ∥_ decays geometrically in some matrix norm, ensuring absolute convergence of the series. A direct computation shows that it solves the unconstrained equation 

**==> picture [273 x 32] intentionally omitted <==**

Say _Q ̸_ = 0. Then _P_ is negative semidefinite and nonzero contradicting positive semidefiniteness. Therefore _Q_ = _P_ = 0 for this solution. We conclude the proof by showing that this is the unique solution of the unconstrained problem. The unconstrained problem is a linear operator problem that can be vectorized 

**==> picture [75 x 12] intentionally omitted <==**

with Ψ( _X_ ) = vec( _X_ ) _−_ ( _J[∗] ⊗ J_ )vec( _X_ ). The spectrum of _J[∗] ⊗ J_ consists of the products _{λ_[¯] _iλj}_ where _{λi}_ are the eigenvalues of _J_ . Since every _|λ_[¯] _iλj| >_ 1, the operator Ψ has a trivial kernel and the solution is unique. 

**24** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

The following is a well-known fact following from the equidistribution theorem [47]. 

Lemma B.4. _Let r ∈_ R _. The set_ 

**==> picture [93 x 12] intentionally omitted <==**

_is dense in_ [0 _,_ 1] _if and only if r is irrational._ 

We can use it to prove the following lemma. 

Lemma B.5. _Consider a random vector X ∈_ R[2] _that is symmetric under a rotation Rθ of angle θ ∈_ [0 _,_ 2 _π_ ) 

**==> picture [51 x 15] intentionally omitted <==**

_θ Then[or][X][is][invariant][under][all][rotations.]_ 2 _π[∈]_[Q] 

_Proof._ Assume 2 _θπ[̸∈]_[Q][and][define][the][set] _[S]_[=] � 2 _θkπ_[mod 1] _[ |][k][∈]_[N] �. _S_ is dense in [0 _,_ 1) by Lemma B.4. Pick any point _s ∈_ [0 _,_ 1) and choose a sequence _sk ∈ S_ such that lim[=] _[s]_[.] _k→∞[s][k]_ Consider any _f_ : R[2] _→_ R that is bounded and continuous. By repeatedly applying invariance, we have E ( _f_ ( _R_ 2 _πsk X_ )) = E ( _f_ ( _X_ )) for any _k_ . Therefore, 

**==> picture [429 x 27] intentionally omitted <==**

where the second equality is the dominated convergence theorem. 

We are now in a position to prove Theorem B.1. 

_Proof of Theorem B.1._ Suppose _X_ with E _∥X∥_[2] 2 _[<][ ∞]_[is a solution of the fixed-point equa-] tion. We will proceed by showing that this implies that _Uu_ and _Ur_ are a.s. constant vectors, _Ur ∈_ Im( _I − Ar_ ) a.s., and _X_ satisfies (a)–(c). From _X_ = _[d] AX_ + _U_ and subspace-invariance we can conclude the following equations: 

**==> picture [85 x 14] intentionally omitted <==**

We proceed by treating each block separately. 

(a) Stable block _Vs_ . We can choose a norm with _∥As∥ <_ 1 by Lemma B.2 since _ρ_ ( _As_ ) _<_ 1. Define _T_ ( _µ_ ) := ( _As_ )# _µ ∗_ Law( _Us_ ) on the metric space ( _P_ 2( _Vs_ ) _, W_ 2) with _∗_ the convolution of distributions. Pushforward by _As_ is Lipschitz in the Wasserstein-2 metric induced by _∥· ∥_ with constant _∥As∥ <_ 1 and convolution is 1-Lipschitz, so _T_ is a strict contraction; by Banach’s fixed-point theorem, there is a unique fixed point _µs_ . Now, let _m_ := E _Us_ and write _Us_[(] _[k]_[)] = _U_[˜] _s_[(] _[k]_[)] + _m_ with i.i.d. copies _{Us_[(] _[k]_[)] _}k≥−_ 1 of _Us_ . Set 

**==> picture [203 x 32] intentionally omitted <==**

Since _∥As∥ <_ 1, the Neumann series[�] _A[k] s_[converges][in][operator][norm][and] _[X] s_[det] is well- _k≥_ 0 defined. For the random series, 

**==> picture [275 x 33] intentionally omitted <==**

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**25** 

where the cross terms vanish because the summands are independent and centered. By the geometric series[�] _∥A[k] s[∥]_[2] _[<][∞]_[,][this][shows][Cauchy][in] _[L]_[2][,][hence] _[X] s_[rnd] converges in _L_[2] by _k≥_ 0 completeness. Defining 

**==> picture [101 x 14] intentionally omitted <==**

by the continuous mapping theorem 

**==> picture [294 x 28] intentionally omitted <==**

Thus Law( _Xs_ ) is the unique fixed point on _Vs_ . 

(b) Rotational block _Vr_ . Choose a complex basis _v_ 1 _, . . . , vdr_ of the complexified space ( _Vr_ )[C] with _dr_ its dimension and put _Ar_ into its complex Jordan form diag( _J_ 1 _, . . . , Jnr_ ) _∈_ C _[d][r][×][d][r]_ with Jordan blocks _Ji_ . For every Jordan block, the distributional equation 

**==> picture [77 x 16] intentionally omitted <==**

holds where _Xr[i][, U] r[i]_[are][the][coordinates][of] _[X][r][, U][r]_[in][the][Jordan][block] _[J][i]_[.][Computing][complex] covariances yields 

**==> picture [75 x 12] intentionally omitted <==**

for _P_ and _Q_ the complex covariance matrices of _Xr[i]_[and] _[U] r[i]_[.][Apply][the][first][part][of][Lemma] B.3 to see from this that _Q_ = 0 and that _P_ 11 is the only nonzero index of _P_ . Note that _P_ 11 corresponds to the eigenvector in the Jordan chain of _Ji_ . Applying this argument to every block shows that _Ur_ is a.s. constant and the only potentially non-a.s.-constant part of _Xr_ is the eigenvector component _Xr_[(1)][.][Note][also][by][taking][expectations][that] 

**==> picture [113 x 12] intentionally omitted <==**

which means that since _Ur_ is a.s. constant it must be a.s. in the image of ( _I − Ar_ ). 

(c) Unstable block _Vu_ ( _ρ_ ( _Au_ ) _>_ 1). Using the same Jordan reduction argument as in (b), we arrive at the equation 

**==> picture [77 x 11] intentionally omitted <==**

Apply the second part of Lemma B.3 to conclude that _Uu_ and _Xu_ are a.s. constant. The distributional equation becomes an a.s. equation and we have that a.s. 

**==> picture [99 x 14] intentionally omitted <==**

Now, conversely, say that _Uu_ and _Ur_ are a.s. constant vectors with _Ur ∈_ Im( _I − Ar_ ) a.s. Construct the solution blockwise and make the blocks statistically independent so that blockwise satisfaction of the distributional equation is sufficient. In the stable and unstable blocks choose the solution as described in the theorem statement. Finally, choose _Xr_ constant such that it solves the linear equation 

**==> picture [80 x 12] intentionally omitted <==**

a.s. It is clear that this is a valid solution from our previous argument, completing the proof. 

**26** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

Using Theorem B.1, we can prove Theorem 2.7. 

_Proof of Theorem 2.7. π ∈E_[EnKU] means that there is a distribution _ν ∈P_ 2 (R _[n]_ ) such that for _Z ∼ ν_ independent of _Y ∼ πY_ , ( _X, Y_ ) = ( _Z_ + _MY, Y_ ) _∼ π_ for _M_ = Σ _XY_ Σ _[†] Y Y_[.][Fix] _y⋆ ∈_ R _[m]_ and an affine map _ℓ_ ( _x, y_ ) = _Ax_ + _By_ + _c_ that conditions exactly at _y⋆_ . This means that 

**==> picture [126 x 15] intentionally omitted <==**

which can be rewritten as 

**==> picture [339 x 15] intentionally omitted <==**

Defining _U_ = ( _AM_ + _B_ ) _Y_ + (( _A − I_ )E( _Z_ ) + ( _AM_ + _B_ )E( _Y_ ) + _c − My⋆_ ), this is equivalent to the following fixed point equation with _Z ⊥⊥ U_ : 

**==> picture [65 x 13] intentionally omitted <==**

(a) _π ̸∈S_ cov. Assume _ν_ has a non-singular covariance meaning it does not have a constant linear component. By Theorem B.1 (in the notation of the theorem), _Zr_[(2)] and _Zu_ are a.s. constant. However, as we assumed that _Z_ has non-singular covariance, this means that the sum of generalized eigenspaces of _A_ with _|λ| >_ 1 is empty and that _A_ is diagonalizable over the generalized eigenspace of all eigenvalues with magnitude 1. In particular, _ρ_ ( _A_ ) _≤_ 1. 

(b) _π ̸∈S_ dec. Let _π ̸∈S_ dec and assume that _Vs_ is non-trivial, meaning that there is at least one complex eigenvalue _λ_ of _A_ with magnitude _|λ| <_ 1. There exists a left nonzero eigenvector _p ∈_ C _[n]_ such that 

**==> picture [59 x 14] intentionally omitted <==**

Plugging into the fixed point equation yields the 1D fixed point equation for _p[⊤] Z_ 

**==> picture [99 x 15] intentionally omitted <==**

By point (a) of Theorem B.1 this implies that 

**==> picture [98 x 31] intentionally omitted <==**

for i.i.d. copies _U_[(] _[k]_[)] of _U_ . Writing _q[⊤]_ = _p[⊤]_ ( _AM_ + _B_ ) and centering, we can rewrite this as 

**==> picture [101 x 31] intentionally omitted <==**

for i.i.d. copies _Y_[(] _[k]_[)] of _Y_ . However, this means that _π ∈S_ dec and so _Vs_ must have been trivial. This implies that _U_ is constant by Theorem B.1 and therefore ( _AM_ + _B_ ) _PY_ = 0 where _PY_ is the orthogonal projector onto the column space of Cov( _Y_ ). This part of the statement is finalized by recognizing that _MPY_ = Σ _XY_ Σ _[†] Y Y[P][Y]_[as][shown][in][the][proof][of][Proposition][2.1][.] 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**27** 

(c) _π ̸∈S_ cyc. Finally, assume that _π ̸∈S_ cyc. By projection, we have that 

**==> picture [83 x 15] intentionally omitted <==**

By Theorem B.1, _Ur_ is a.s. constant. Taking expectations shows that since _Zr_ is mean-zero, _Ur_ is a.s. 0 so that we have 

**==> picture [57 x 15] intentionally omitted <==**

Assume that _Ar_ has an eigenvalue _|λ|_ = 1 with _λ_ = 1 and derive a contradiction. Consider the case _λ_ = _−_ 1. Then there is a nonzero real _p_ such that _p[⊤] A_ = _−p[⊤]_ . This implies that 

**==> picture [74 x 15] intentionally omitted <==**

contradicting _π ̸∈S_ cyc for _Z_ cyc = ( _p[⊤] PrZ, p[⊤] PrZ_ ) and angle _θ_ = _π_ . So _λ_ cannot be real. Write _λ_ = _e[iθ]_ and let _p_ = _p_ 1 + _ip_ 2 be a nonzero left eigenvector for _λ_ . Note that neither _p_ 1 nor _p_ 2 can be zero as otherwise the equation _Arpi_ = _e[iθ] pi_ would hold for one of _i_ = 1 _,_ 2. This is impossible because the left-hand side is purely real while the right-hand side is not. Taking real and imaginary parts of _A[⊤] r[p]_[ =] _[ e][iθ][p]_[yields] 

**==> picture [253 x 14] intentionally omitted <==**

This implies that 

**==> picture [341 x 37] intentionally omitted <==**

By Lemma B.5, we have _θ_ = 2 _πs/t_ for some 1 _≤ s < t_ , _t ∈_ N, with gcd( _s, t_ ) = 1. Since the cyclic subgroup of R _/_ Z generated by _s/t_ is the same as the one generated by 1 _/t_ , iterating the preceding invariance relation shows that the same relation also holds with angle 2 _π/t_ . This implies _π ∈S_ cyc, contradicting _π ∈S/_ cyc. Hence we must have _λ_ = 1. 

Corollary 2.8 follows from Theorem 2.7. 

_Proof of Corollary 2.8._ Since _π ̸∈S_ cov, Theorem 2.7 implies that _ρ_ ( _A_ ) _≤_ 1 and _A_ is diagonal in the generalized eigenspace of all eigenvalues with magnitude 1. Further, since _π ̸∈S_ dec, the spectrum of _A_ has no eigenvalues with magnitude smaller than 1, so we can write _A_ = _PDP[−]_[1] for _P, D ∈_ C _[n][×][n]_ with _D_ diagonal and all diagonal entries of complex magnitude one. As _π ̸∈S_ cyc, _A_ has no eigenvalues with _|λ|_ = 1 and _λ_ = 1, so _A_ = _I_ . Additionally, by _π ̸∈S_ dec and full covariance rank of Σ _Y Y_ , 

**==> picture [42 x 9] intentionally omitted <==**

where _K_ = Σ _XY_ Σ _[†] Y Y_[.][Finally,][we][derive][the][value][of] _[c]_[.][Pick] _[ν]_[such][that][(] _[Z]_[+] _[ MY, Y]_[ )] _[∼][π]_ for _Z ∼ ν_ independent of _Y ∼ πY_ and _M_ = _K_ . Then, by exactness 

**==> picture [149 x 15] intentionally omitted <==**

Taking expectations on both sides shows 

**==> picture [40 x 11] intentionally omitted <==**

and completes the proof. 

**28** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

Now, we can prove Theorem 3.3. 

_Proof of Theorem 3.3._ Say _π ∈F ∩S_ nl[c] _−_ dec[.][We][show] _[π][∈E]_[EnKU][.][By][Proposition][3.1] there are measurable _d_ : R _[m] →_ R _[n]_ and _ν ∈P_ 2 (R _[n]_ ) such that 

**==> picture [165 x 14] intentionally omitted <==**

Letting ( _X, Y_ ) = ( _Z_ + _d_ ( _Y_ ) _, Y_ ) for _Z ∼ ν_ independent of _Y ∼ πY_ , this means that ( _X, Y_ ) _∼ π_ . Since _π_ has an exact weakly observation-dependent affine conditioning map there are _A ∈_ R _[n][×][n]_ , _B ∈_ R _[n][×][m]_ , and _c_ : R _[m] →_ R _[n]_ such that 

**==> picture [189 x 15] intentionally omitted <==**

_πY_ -a.s. For any such _y⋆_ we can rewrite this as 

**==> picture [63 x 14] intentionally omitted <==**

for _U_ = ( _A − I_ )E( _Z_ ) + _Ad_ ( _Y_ ) _− d_ ( _y⋆_ ) + _BY_ + _c_ ( _y⋆_ ). Theorem B.1 implies that _Uu_ and _Ur_ are a.s. constant vectors. Further, writing _As_ = _PsAPs_ , we have 

**==> picture [79 x 31] intentionally omitted <==**

for _Us_[(] _[k]_[)] independent copies of _Us_ that are chosen through independent copies _Ys_[(] _[k]_[)] of _Y_ . Say _Vs_ is nontrivial, then there is a nonzero eigenvector _p_ of _A[⊤] s_[with][eigenvalue] _[|][λ][|][<]_[1.][This] implies that 

**==> picture [105 x 32] intentionally omitted <==**

for some _|λ| <_ 1. We can expand 

**==> picture [363 x 14] intentionally omitted <==**

and defining _b_ = 1 _−_ 1 _λ[p][⊤][P][s]_[ ((] _[A][ −][I]_[)][E][(] _[Z]_[)] _[ −][d]_[(] _[y][⋆]_[) +] _[ c]_[(] _[y][⋆]_[)),] _[w][⊤]_[=] _[p][⊤][P][s][B]_[,] _[u][⊤]_[=] _[p][⊤][P][s][A]_[,] _[v][⊤]_[=] _p[⊤] Ps_ we can rewrite this as 

**==> picture [199 x 31] intentionally omitted <==**

Since _v_ = 0, this contradicts _π ∈S_ nl[c] _−_ dec[and][thus][we][must][have][that] _[V][s]_[is][trivial.][Therefore,] _U_ (and in particular _Ad_ ( _Y_ ) + _BY_ ) is a.s. constant. Further, _A ∈_ GL( _n_ ) as the stable block is trivial. Therefore, almost surely 

**==> picture [103 x 13] intentionally omitted <==**

for a constant _f ∈_ R _[n]_ , meaning that _d_ is a.s. affine. However, then _π ∈E_[EnKU] . 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**29** 

Finally, we prove the statement from Remark 2.6, restated here in the form of a proposition. Proposition B.6. _Define_ 

**==> picture [219 x 15] intentionally omitted <==**

_and endow it with the relative W_ 2 _topology. Then S_ dec _∩E_ 0[EnKU] _and S_ cyc _∩E_ 0[EnKU] _are meagre subsets of E_ 0[EnKU] _._ 

_Proof of Proposition B.6._ By Proposition 2.1, every _π ∈E_ 0[EnKU] admits a representation 

**==> picture [167 x 12] intentionally omitted <==**

with _M ∈_ R _[n][×][m]_ . Taking the cross-covariance of the left- and right-hand sides yields 

**==> picture [105 x 11] intentionally omitted <==**

which uniquely determines the decomposition. Now define 

**==> picture [171 x 13] intentionally omitted <==**

with the nondegenerate set 

**==> picture [221 x 15] intentionally omitted <==**

where Σ( _ν_ ) is the full covariance matrix of _ν_ , and let 

**==> picture [281 x 12] intentionally omitted <==**

Φ is continuous by a standard _W_ 2-stability triangle inequality argument. Its inverse is 

**==> picture [296 x 20] intentionally omitted <==**

The inverse map is also continuous. For the third component, continuity follows since second moments depend continuously on _π_ in _W_ 2, and matrix inversion is continuous on the open set of invertible matrices. Continuity of the second component is immediate. For the first component, continuity follows from a standard _W_ 2 stability argument: linear pushforwards are continuous in _W_ 2, and combining this with a triangle inequality to also control the _M_ -term yields the claim. Hence 

**==> picture [78 x 13] intentionally omitted <==**

is a homeomorphism. It therefore suffices to prove meagreness of the pullbacks of the sets under consideration to _X_ 0. 

Further, let _A ⊂P_ 2(R _[n]_ ) be the set of all finitely supported distributions 

**==> picture [60 x 34] intentionally omitted <==**

with _pi >_ 0 and _xi_ distinct such that: 

**30** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

1. the centered support spans R _[n]_ , i.e., 

**==> picture [285 x 85] intentionally omitted <==**

2. all subset sums of the weights are distinct: 

Importantly, the set _A_ is dense in _P_ 2(R _[n]_ ). Indeed, finitely supported distributions are dense in _W_ 2, and the two additional properties can be enforced by arbitrarily small perturbations of any finitely supported distribution. More precisely, the spanning condition can be ensured by splitting a support point into _n_ + 1 affinely independent points placed arbitrarily close together. The distinct subset-sum condition can be achieved by perturbing the weights: the configurations violating this property are characterized by a finite union of proper affine hyperplanes in the probability simplex, whose complement is therefore dense. 

(a) Meagreness of _S_ cyc. We prove that _S_ cyc is meagre by writing it as a countable union of closed sets, each disjoint from _A_ . Since _A_ is dense, it follows that each of these sets is nowhere dense. To define these sets, for _k ≥_ 2 and _q ≥_ 1, let 

**==> picture [275 x 20] intentionally omitted <==**

and write _Rk_ := _R_ 2 _π/k_ . Also define 

**==> picture [115 x 13] intentionally omitted <==**

and 

**==> picture [298 x 21] intentionally omitted <==**

By definition, 

**==> picture [287 x 40] intentionally omitted <==**

Therefore, to conclude meagreness of _S_ cyc _∩E_ 0[EnKU] , it suffices to show that each _Ck,q_ is closed and disjoint from _A_ . To prove closedness, let _µℓ ∈ Ck,q_ with _µℓ → µ_ in _W_ 2. By definition of _Ck,q_ , for each _ℓ_ there exists _Aℓ ∈ Kq_ such that 

**==> picture [125 x 14] intentionally omitted <==**

Since _Kq_ is compact, there exists a subsequence (not relabeled) such that _Aℓ → A ∈ Kq_ . Because _Kq_ is compact and the map ( _µ, A_ ) _�→ A♯µ_ is continuous in _W_ 2, we can take limits of both sides of the equation and obtain ( _A_ ) _♯µ_ = ( _Rk_ ) _♯_ �( _A_ ) _♯µ_ � _._ This shows _Ck,q_ is closed. Next, we show that _Ck,q ∩A_ = ∅. Indeed, fix _µ ∈A_ , and suppose that _µ ∈ Ck,q_ . By definition, 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**31** 

for some _A ∈ Kq_ , the finitely supported distribution _A♯µ_ is invariant under the nontrivial rotation _Rk_ . Write _S_ for the support and 

**==> picture [79 x 27] intentionally omitted <==**

Each mass _my_ is a subset sum of the weights _pi_ . Rotational invariance gives 

**==> picture [138 x 12] intentionally omitted <==**

Since all subset sums of the _pi_ are distinct, equality of masses implies equality of the corresponding subsets of indices in the underlying finite particle distribution _µ_ . In particular, _Rky_ = _y_ for every support point _y_ . But a nontrivial planar rotation fixes only the origin, so _S_ = _{_ 0 _}_ . Therefore 

**==> picture [145 x 12] intentionally omitted <==**

which contradicts the fact that the centered support spans R _[n]_ and _A ̸_ = 0. Thus _A∩ Ck,q_ = ∅. (b) Meagreness of _S_ dec. For _N ≥_ 1, define 

and 

**==> picture [359 x 64] intentionally omitted <==**

We then set _DN ⊂ XN_ to be the set of all pairs ( _µ, ν_ ) _∈ XN_ such that for some ( _v, w, λ_ ) _∈ LN_ , 

**==> picture [103 x 32] intentionally omitted <==**

where _Z ∼ µ_ , _Y_[(] _[j]_[)][i.i.d.] _∼ ν_ , and all variables are independent. Since 

**==> picture [202 x 40] intentionally omitted <==**

it suffices to show that every _DN_ is closed in the relative topology of _P_ 2(R _[n]_ ) _× P_ 2 _,_ nd(R _[m]_ ) and has empty interior. Define 

**==> picture [301 x 14] intentionally omitted <==**

and 

**==> picture [257 x 26] intentionally omitted <==**

by 

**==> picture [257 x 40] intentionally omitted <==**

**32** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

We show that _DN_ is closed. Let ( _µℓ, νℓ_ ) _∈ DN_ with ( _µℓ, νℓ_ ) _→_ ( _µ, ν_ ) in _W_ 2. For each _ℓ_ , choose ( _vℓ, wℓ, λℓ_ ) _∈ LN_ such that 

(B.2) 

**==> picture [131 x 12] intentionally omitted <==**

Since _LN_ is compact, after passing to a subsequence we may assume ( _vℓ, wℓ, λℓ_ ) _→_ ( _v, w, λ_ ) _∈ LN ._ We claim closedness, i.e. 

**==> picture [109 x 12] intentionally omitted <==**

The left-hand side of (B.2) converges to Θ( _v, µ_ ) because Θ is continuous. By uniqueness of the limit, it is enough to show that Ω( _vℓ, wℓ, λℓ, νℓ_ ) _→_ Ω( _v, w, λ, ν_ ) in _W_ 2. Let 

**==> picture [215 x 33] intentionally omitted <==**

where ( _Yℓ_[(] _[j]_[)] _, Y_[(] _[j]_[)] ) _j≥_ 0 are i.i.d. copies of an optimal coupling of _νℓ_ and _ν_ . Then 

**==> picture [230 x 15] intentionally omitted <==**

where we write _∥X∥_[2] _L_[2][:=][ E] _[∥][X][∥]_[2] 2[.][Decomposing][each][summand][as] 

**==> picture [395 x 17] intentionally omitted <==**

the triangle inequality gives 

**==> picture [235 x 12] intentionally omitted <==**

where elementary bounds show 

**==> picture [254 x 108] intentionally omitted <==**

where _r_ := 1 _−_[1][In][particular,] _N[.]_ 

**==> picture [255 x 12] intentionally omitted <==**

We now show that each _DN_ has empty interior. Let _V ⊂P_ 2 _,_ nd(R _[m]_ ) denote the set of laws with smooth density. This set is dense in _P_ 2 _,_ nd(R _[m]_ ), for instance by convolution with a nondegenerate Gaussian of arbitrarily small variance. Therefore, _A × V_ is dense in _P_ 2(R _[n]_ ) _× P_ 2 _,_ nd(R _[m]_ ) and to show that _DN_ has empty interior it suffices to prove that _DN ∩_ ( _A×V_ ) = ∅. Fix ( _µ, ν_ ) _∈A × V_ . If _v_ = 0 and letting _Z ∼ µ_ , _v[⊤] Z_ is a nondegenerate finite atomic law, 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**33** 

because _µ_ is finitely supported and the centered support of _µ_ spans R _[n]_ . On the other hand, if _w_ = 0, then for _Y ∼ ν_ 

**==> picture [85 x 33] intentionally omitted <==**

is degenerate. If _w_ = 0, then _w[⊤] Y_ is non-atomic since _ν_ has a smooth density, and therefore 

**==> picture [190 x 33] intentionally omitted <==**

is also non-atomic as the convolution of a non-atomic law with an independent law. Thus equality in distribution of these two is impossible and 

**==> picture [94 x 12] intentionally omitted <==**

**Acknowledgments.** The authors acknowledge the use of AI tools for proofreading and language checking. All mathematical content and conclusions are solely those of the authors. 

## **REFERENCES** 

- [1] O. Al-Ghattas and D. Sanz-Alonso, _Non-asymptotic analysis of ensemble kalman updates: effective dimension and localization_ , Information and Inference: A Journal of the IMA, 13 (2024), p. iaad043. 

- [2] L. Ambrosio, N. Gigli, and G. Savar´e, _Gradient flows: in metric spaces and in the space of probability measures_ , Springer, 2005. 

- [3] J. L. Anderson, _An ensemble adjustment kalman filter for data assimilation_ , Monthly weather review, 129 (2001), pp. 2884–2903. 

- [4] J. L. Anderson, _An adaptive covariance inflation error correction algorithm for ensemble filters_ , Tellus A: Dynamic meteorology and oceanography, 59 (2007), pp. 210–224. 

- [5] E. Bach, R. Baptista, E. Calvello, B. Chen, and A. M. Stuart, _Learning enhanced ensemble filters_ , arXiv preprint arXiv:2504.17836, (2025). 

- [6] C. H. Bishop, B. J. Etherton, and S. J. Majumdar, _Adaptive sampling with the ensemble transform kalman filter. part i: Theoretical aspects_ , Monthly weather review, 129 (2001), pp. 420–436. 

- [7] E. Calvello, S. Reich, and A. M. Stuart, _Ensemble kalman methods: A mean-field perspective_ , Acta Numerica, 34 (2025), pp. 123–291. 

- [8] L.-P. Chaintron and A. Diez, _Propagation of chaos: a review of models, methods and applications. i. models and methods_ , arXiv preprint arXiv:2203.00446, (2022). 

- [9] D. L. Cohn, _Measure theory_ , vol. 1, Springer, 2013. 

- [10] P. Del Moral and J. Tugaut, _On the stability and the uniform propagation of chaos properties of ensemble kalman–bucy filters_ , The Annals of Applied Probability, 28 (2018), pp. 790–850. 

- [11] T. A. El Moselhy and Y. M. Marzouk, _Bayesian inference with optimal maps_ , Journal of Computational Physics, 231 (2012), pp. 7815–7850. 

- [12] G. Evensen, _The ensemble kalman filter: Theoretical formulation and practical implementation_ , Ocean dynamics, 53 (2003), pp. 343–367. 

- [13] G. Evensen, _The ensemble kalman filter for combined state and parameter estimation_ , IEEE Control Systems Magazine, 29 (2009), pp. 83–104. 

- [14] W. Feller et al., _An introduction to probability theory and its applications_ , Wiley New York, 1971. 

- [15] A. Gelb et al., _Applied optimal estimation_ , MIT press, 1974. 

- [16] I. Grooms, _A note on the formulation of the ensemble adjustment kalman filter_ , arXiv preprint arXiv:2006.02941, (2020). 

- [17] P. Hall and C. C. Heyde, _Martingale limit theory and its application_ , Academic press, 2014. 

**34** 

**FREDERIC J. N. JORGENSEN, YOUSSEF MARZOUK** 

- [18] T.-V. Hoang, S. Krumscheid, H. G. Matthies, and R. Tempone, _Machine learning-based conditional mean filter: A generalization of the ensemble kalman filter for nonlinear data assimilation_ , arXiv preprint arXiv:2106.07908, (2021). 

- [19] P. L. Houtekamer and H. L. Mitchell, _A sequential ensemble kalman filter for atmospheric data assimilation_ , Monthly weather review, 129 (2001), pp. 123–137. 

- [20] B. R. Hunt, E. J. Kostelich, and I. Szunyogh, _Efficient data assimilation for spatiotemporal chaos: A local ensemble transform kalman filter_ , Physica D: Nonlinear Phenomena, 230 (2007), pp. 112–126. 

- [21] M. A. Iglesias, K. J. Law, and A. M. Stuart, _Ensemble kalman methods for inverse problems_ , Inverse Problems, 29 (2013), p. 045001. 

- [22] O. Kallenberg, _Foundations of modern probability_ , Springer, 1997. 

- [23] R. E. Kalman, _A new approach to linear filtering and prediction problems_ , Journal of Basic Engineering, (1960). 

- [24] K. Law, A. M. Stuart, and K. Zygalakis, _Data assimilation_ , Cham, Switzerland: Springer, 214 (2015). 

- [25] F. Le Gland, V. Monbet, and V.-D. Tran, _Large sample asymptotics for the ensemble Kalman filter_ , PhD thesis, INRIA, 2009. 

- [26] J. Lei and P. Bickel, _A moment matching ensemble filter for nonlinear non-gaussian data assimilation_ , Monthly Weather Review, 139 (2011), pp. 3964–3973. 

- [27] M. Lo`eve, _Nouvelles classes de lois limites_ , Bulletin de la Soci´et´e Math´ematique de France, 73 (1945), pp. 107–126. 

- [28] M. McCabe and J. Brown, _Learning to assimilate in chaotic dynamical systems_ , Advances in neural information processing systems, 34 (2021), pp. 12237–12250. 

- [29] L. Nerger, T. Janji´c, J. Schr¨oter, and W. Hiller, _A unification of ensemble square root kalman filters_ , Monthly Weather Review, 140 (2012), pp. 2335–2345. 

- [30] J. P. Nolan, _Multivariate stable distributions: Approximation, estimation, simulation and identification_ , in A Practical Guide to Heavy Tails: Statistical Techniques and Applications, 1998, pp. 509–525. 

- [31] P. Parks, _Liapunov and the schur-cohn stability criterion_ , IEEE Transactions on Automatic Control, 9 (1964), pp. 121–121. 

- [32] M. L. Provost, R. Baptista, J. D. Eldredge, and Y. Marzouk, _An adaptive ensemble filter for heavy-tailed distributions: Tuning-free inflation and localization_ , arXiv preprint arXiv:2310.08741, (2023). 

- [33] T. Rajba, _On multiple decomposability of probability measures on r_ , Demonstratio Mathematica, 34 (2001), pp. 63–82. 

- [34] S. Reich and C. Cotter, _Probabilistic forecasting and Bayesian data assimilation_ , Cambridge University Press, 2015. 

- [35] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, _Kalmannet: Neural network aided kalman filtering for partially known dynamics_ , IEEE Transactions on Signal Processing, 70 (2022), pp. 1532–1547. 

- [36] P. Sakov and P. R. Oke, _Implications of the form of the ensemble transformation in the ensemble square root filters_ , Monthly Weather Review, 136 (2008), pp. 1042–1053. 

- [37] G. Samorodnitsky and M. S. Taqqu, _Stable non-Gaussian random processes: stochastic models with infinite variance_ , vol. 1, CRC press, 1994. 

- [38] K.-I. Sato, _L´evy processes and infinitely divisible distributions_ , vol. 68, Cambridge university press, 1999. 

- [39] C. Schillings and A. M. Stuart, _Analysis of the ensemble kalman filter for inverse problems_ , SIAM Journal on Numerical Analysis, 55 (2017), pp. 1264–1290. 

- [40] C. Schillings and A. M. Stuart, _Convergence analysis of ensemble kalman inversion: the linear, noisy case_ , Applicable Analysis, 97 (2018), pp. 107–123. 

- [41] A. Spantini, R. Baptista, and Y. Marzouk, _Coupling techniques for nonlinear ensemble filtering_ , SIAM Review, 64 (2022), pp. 921–953. 

- [42] A.-S. Sznitman, _Topics in propagation of chaos_ , in Ecole d’´et´e de probabilit´es de Saint-Flour XIX—1989, Springer, 2006, pp. 165–251. 

- [43] M. K. Tippett, J. L. Anderson, C. H. Bishop, T. M. Hamill, and J. S. Whitaker, _Ensemble square root filters_ , Monthly weather review, 131 (2003), pp. 1485–1490. 

- [44] X. T. Tong, A. J. Majda, and D. Kelly, _Nonlinear stability of the ensemble kalman filter with adaptive_ 

**UNIQUE CHARACTERIZATION OF THE ENSEMBLE KALMAN UPDATE** 

**35** 

   - _covariance inflation_ , arXiv preprint arXiv:1507.08319, (2015). 

- [45] R. Van Handel, _Uniform observability of hidden markov models and filter stability for unstable signals_ , (2009). 

- [46] X. Wang, C. H. Bishop, and S. J. Julier, _Which is better, an ensemble of positive–negative pairs or a centered spherical simplex ensemble?_ , Monthly Weather Review, 132 (2004), pp. 1590–1605. 

- [47] H. Weyl, _Uber[¨] die gleichverteilung von zahlen mod. eins_ , Mathematische Annalen, 77 (1916), pp. 313– 352. 

- [48] J. S. Whitaker and T. M. Hamill, _Ensemble data assimilation without perturbed observations_ , Monthly weather review, 130 (2002), pp. 1913–1924. 

- [49] V. M. Zolotarev, _One-dimensional stable distributions_ , vol. 65, American Mathematical Soc., 1986. 

