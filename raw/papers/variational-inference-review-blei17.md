---
title: "Variational Inference: A Review for Statisticians"
arxiv: "1601.00670"
authors: [David M. Blei, Alp Kucukelbir, Jon D. McAuliffe]
year: 2017
source: paper
ingested: 2026-05-14
sha256: 0b418b726908536b4fd7c5d5f1e130868e3a5c11c40536f088f59afc416a3817
conversion: pymupdf4llm
---

# **Variational Inference: A Review for Statisticians** 

David M. Blei Department of Computer Science and Statistics Columbia University 

Alp Kucukelbir Department of Computer Science Columbia University 

Jon D. McAuliffe Department of Statistics University of California, Berkeley 

May 11, 2018 

## **Abstract** 

One of the core problems of modern statistics is to approximate difficult-to-compute probability densities. This problem is especially important in Bayesian statistics, which frames all inference about unknown quantities as a calculation involving the posterior density. In this paper, we review variational inference (VI), a method from machine learning that approximates probability densities through optimization. VI has been used in many applications and tends to be faster than classical methods, such as Markov chain Monte Carlo sampling. The idea behind VI is to first posit a family of densities and then to find the member of that family which is close to the target. Closeness is measured by Kullback-Leibler divergence. We review the ideas behind mean-field variational inference, discuss the special case of VI applied to exponential family models, present a full example with a Bayesian mixture of Gaussians, and derive a variant that uses stochastic optimization to scale up to massive data. We discuss modern research in VI and highlight important open problems. VI is powerful, but it is not yet well understood. Our hope in writing this paper is to catalyze statistical research on this class of algorithms. 

_Keywords:_ Algorithms; Statistical Computing; Computationally Intensive Methods. 

1 

## **1 Introduction** 

One of the core problems of modern statistics is to approximate difficult-to-compute probability densities. This problem is especially important in Bayesian statistics, which frames all inference about unknown quantities as a calculation about the posterior. Modern Bayesian statistics relies on models for which the posterior is not easy to compute and corresponding algorithms for approximating them. 

In this paper, we review variational inference (VI), a method from machine learning for approximating probability densities (Jordan et al., 1999; Wainwright and Jordan, 2008). Variational inference is widely used to approximate posterior densities for Bayesian models, an alternative strategy to Markov chain Monte Carlo (MCMC) sampling. Compared to MCMC, variational inference tends to be faster and easier to scale to large data—it has been applied to problems such as large-scale document analysis, computational neuroscience, and computer vision. But variational inference has been studied less rigorously than MCMC, and its statistical properties are less well understood. In writing this paper, our hope is to catalyze statistical research on variational inference. 

First, we set up the general problem. Consider a joint density of latent variables **z** = _z_ 1: _m_ and observations **x** = _x_ 1: _n_ , 

**==> picture [88 x 11] intentionally omitted <==**

In Bayesian models, the latent variables help govern the distribution of the data. A Bayesian model draws the latent variables from a prior density _p_ ( **z** ) and then relates them to the observations through the likelihood _p_ ( **x** _|_ **z** ). Inference in a Bayesian model amounts to conditioning on data and computing the posterior _p_ ( **z** _|_ **x** ). In complex Bayesian models, this computation often requires approximate inference. 

For decades, the dominant paradigm for approximate inference has been MCMC (Hastings, 1970; Gelfand and Smith, 1990). In MCMC, we first construct an ergodic Markov chain on **z** whose stationary distribution is the posterior _p_ ( **z** _|_ **x** ). Then, we sample from the chain to collect samples from the stationary distribution. Finally, we approximate the posterior with an empirical estimate constructed from (a subset of) the collected samples. 

MCMC sampling has evolved into an indispensable tool to the modern Bayesian statistician. Landmark developments include the Metropolis-Hastings algorithm (Metropolis et al., 1953; Hastings, 1970), the Gibbs sampler (Geman and Geman, 1984) and its application to Bayesian statistics (Gelfand and Smith, 1990). MCMC algorithms are under active investigation. They have been widely studied, extended, and applied; see Robert and Casella (2004) for a perspective. 

However, there are problems for which we cannot easily use this approach. These arise particularly when we need an approximate conditional faster than a simple MCMC algorithm can produce, such as when data sets are large or models are very complex. In these settings, variational inference provides a good alternative approach to approximate Bayesian inference. 

Rather than use sampling, the main idea behind variational inference is to use optimization. First, we posit a _family_ of approximate densities _�_ . This is a set of densities over the latent variables. Then, we try to find the member of that family that minimizes the Kullback-Leibler (KL) divergence to the exact posterior, 

**==> picture [258 x 19] intentionally omitted <==**

Finally, we approximate the posterior with the optimized member of the family _q[∗]_ ( _·_ ). 

2 

Variational inference thus turns the inference problem into an optimization problem, and the reach of the family _�_ manages the complexity of this optimization. One of the key ideas behind variational inference is to choose _�_ to be flexible enough to capture a density close to _p_ ( **z** _|_ **x** ), but simple enough for efficient optimization.[1] 

We emphasize that MCMC and variational inference are different approaches to solving the same problem. MCMC algorithms sample a Markov chain; variational algorithms solve an optimization problem. MCMC algorithms approximate the posterior with samples from the chain; variational algorithms approximate the posterior with the result of the optimization. 

**Comparing variational inference and MCMC.** When should a statistician use MCMC and when should she use variational inference? We will offer some guidance. MCMC methods tend to be more computationally intensive than variational inference but they also provide guarantees of producing (asymptotically) exact samples from the target density (Robert and Casella, 2004). Variational inference does not enjoy such guarantees—it can only find a density close to the target—but tends to be faster than MCMC. Because it rests on optimization, variational inference easily takes advantage of methods like stochastic optimization (Robbins and Monro, 1951; Kushner and Yin, 1997) and distributed optimization (though some MCMC methods can also exploit these innovations (Welling and Teh, 2011; Ahmed et al., 2012)). 

Thus, variational inference is suited to large data sets and scenarios where we want to quickly explore many models; MCMC is suited to smaller data sets and scenarios where we happily pay a heavier computational cost for more precise samples. For example, we might use MCMC in a setting where we spent 20 years collecting a small but expensive data set, where we are confident that our model is appropriate, and where we require precise inferences. We might use variational inference when fitting a probabilistic model of text to one billion text documents and where the inferences will be used to serve search results to a large population of users. In this scenario, we can use distributed computation and stochastic optimization to scale and speed up inference, and we can easily explore many different models of the data. 

Data set size is not the only consideration. Another factor is the geometry of the posterior distribution. For example, the posterior of a mixture model admits multiple modes, each corresponding label permutations of the components. Gibbs sampling, if the model permits, is a powerful approach to sampling from such target distributions; it quickly focuses on one of the modes. For mixture models where Gibbs sampling is not an option, variational inference may perform better than a more general MCMC technique (e.g., Hamiltonian Monte Carlo), even for small datasets (Kucukelbir et al., 2015). Exploring the interplay between model complexity and inference (and between variational inference and MCMC) is an exciting avenue for future research (see Section 5.4). 

The relative accuracy of variational inference and MCMC is still unknown. We do know that variational inference generally underestimates the variance of the posterior density; this is a consequence of its objective function. But, depending on the task at hand, underestimating the variance may be acceptable. Several lines of empirical research have shown that variational inference does not necessarily suffer in accuracy, e.g., in terms of posterior predictive densities (Blei and Jordan, 2006; Braun and McAuliffe, 2010; Kucukelbir et al., 2016); other research focuses on where variational inference falls short, especially around the posterior variance, and tries to more closely match the inferences made by MCMC (Giordano et al., 2015). In general, a statistical theory and understanding around variational 

> 1We focus here on KL( _q||p_ )-based optimization, also called Kullback Leibler variational inference (Barber, 2012). Wainwright and Jordan (2008) emphasize that any procedure which uses optimization to approximate a density can be termed “variational inference.” This includes methods like expectation propagation (Minka, 2001), belief propagation (Yedidia et al., 2001), or even the Laplace approximation. We briefly discuss alternative divergence measures in Section 5. 

3 

inference is an important open area of research (see Section 5.2). We can envision future results that outline which classes of models are particularly suited to each algorithm and perhaps even theory that bounds their accuracy. More broadly, variational inference is a valuable tool, alongside MCMC, in the statistician’s toolbox. 

It might appear to the reader that variational inference is only relevant to Bayesian analysis. Indeed, both variational inference and MCMC have had a significant impact on applied Bayesian computation and we will be focusing on Bayesian models here. We emphasize, however, that these techniques also apply more generally to computation about intractable densities. MCMC is a tool for simulating from densities and variational inference is a tool for approximating densities. One need not be a Bayesian to have use for variational inference. 

**Research on variational inference.** The development of variational techniques for Bayesian inference followed two parallel, yet separate, tracks. Peterson and Anderson (1987) is arguably the first variational procedure for a particular model: a neural network. This paper, along with insights from statistical mechanics (Parisi, 1988), led to a flurry of variational inference procedures for a wide class of models (Saul et al., 1996; Jaakkola and Jordan, 1996, 1997; Ghahramani and Jordan, 1997; Jordan et al., 1999). In parallel, Hinton and Van Camp (1993) proposed a variational algorithm for a similar neural network model. Neal and Hinton (1999) (first published in 1993) made important connections to the expectation maximization (EM) algorithm (Dempster et al., 1977), which then led to a variety of variational inference algorithms for other types of models (Waterhouse et al., 1996; MacKay, 1997). 

Modern research on variational inference focuses on several aspects: tackling Bayesian inference problems that involve massive data; using improved optimization methods for solving Equation (1) (which is usually subject to local minima); developing generic variational inference, algorithms that are easy to apply to a wide class of models; and increasing the accuracy of variational inference, e.g., by stretching the boundaries of _�_ while managing complexity in optimization. 

**Organization of this paper.** Section 2 describes the basic ideas behind the simplest approach to variational inference: mean-field inference and coordinate-ascent optimization. Section 3 works out the details for a Bayesian mixture of Gaussians, an example model familiar to many readers. Sections 4.1 and 4.2 describe variational inference for the class of models where the joint density of the latent and observed variables are in the exponential family—this includes many intractable models from modern Bayesian statistics and reveals deep connections between variational inference and the Gibbs sampler of Gelfand and Smith (1990). Section 4.3 expands on this algorithm to describe stochastic variational inference (Hoffman et al., 2013), which scales variational inference to massive data using stochastic optimization (Robbins and Monro, 1951). Finally, with these foundations in place, Section 5 gives a perspective on the field—applications in the research literature, a survey of theoretical results, and an overview of some open problems. 

## **2 Variational inference** 

The goal of variational inference is to approximate a conditional density of latent variables given observed variables. The key idea is to solve this problem with optimization. We use a family of densities over the latent variables, parameterized by free “variational parameters.” The optimization finds the member of this family, i.e., the setting of the parameters, that is closest in KL divergence to the conditional of interest. The fitted variational density then serves as a proxy for the exact conditional density. (All vectors defined below are column vectors, unless stated otherwise.) 

4 

## **2.1 The problem of approximate inference** 

Let **x** = _x_ 1: _n_ be a set of observed variables and **z** = _z_ 1: _m_ be a set of latent variables, with joint density _p_ ( **z** , **x** ). We omit constants, such as hyperparameters, from the notation. 

The inference problem is to compute the conditional density of the latent variables given the observations, _p_ ( **z** _|_ **x** ). This conditional can be used to produce point or interval estimates of the latent variables, form predictive densities of new data, and more. 

We can write the conditional density as 

**==> picture [224 x 24] intentionally omitted <==**

The denominator contains the marginal density of the observations, also called the _evidence_ . We calculate it by marginalizing out the latent variables from the joint density, 

**==> picture [229 x 27] intentionally omitted <==**

For many models, this evidence integral is unavailable in closed form or requires exponential time to compute. The evidence is what we need to compute the conditional from the joint; this is why inference in such models is hard. 

Note we assume that all unknown quantities of interest are represented as latent random variables. This includes parameters that might govern all the data, as found in Bayesian models, and latent variables that are “local” to individual data points. 

**Bayesian mixture of Gaussians.** Consider a Bayesian mixture of unit-variance univariate Gaussians. There are _K_ mixture components, corresponding to _K_ Gaussian distributions with means _**µ**_ = _{µ_ 1,..., _µK }_ . The mean parameters are drawn independently from a common prior _p_ ( _µk_ ), which we assume to be a Gaussian _�_ (0, _σ_[2] ); the prior variance _σ_[2] is a hyperparameter. To generate an observation _xi_ from the model, we first choose a cluster assignment _ci_ . It indicates which latent cluster _xi_ comes from and is drawn from a categorical distribution over _{_ 1,..., _K}_ . (We encode _ci_ as an indicator _K_ -vector, all zeros except for a one in the position corresponding to _xi_ ’s cluster.) We then draw _xi_ from the corresponding Gaussian _�_ ( _ci[⊤]_ _**[µ]**_[,1][)][.] 

The full hierarchical model is 

**==> picture [316 x 44] intentionally omitted <==**

For a sample of size _n_ , the joint density of latent and observed variables is 

**==> picture [264 x 28] intentionally omitted <==**

The latent variables are **z** = _{_ _**µ**_ , **c** _}_ , the _K_ class means and _n_ class assignments. Here, the evidence is 

**==> picture [274 x 29] intentionally omitted <==**

The integrand in Equation (8) does not contain a separate factor for each _µk_ . (Indeed, each _µk_ appears in all _n_ factors of the integrand.) Thus, the integral in Equation (8) does not 

5 

reduce to a product of one-dimensional integrals over the _µk_ ’s. The time complexity of numerically evaluating the _K_ -dimensional integral is _�_ ( _K[n]_ ). 

If we distribute the product over the sum in (8) and rearrange, we can write the evidence as a sum over all possible configurations **c** of cluster assignments, 

**==> picture [273 x 28] intentionally omitted <==**

Here each individual integral is computable, thanks to the conjugacy between the Gaussian prior on the components and the Gaussian likelihood. But there are _K[n]_ of them, one for each configuration of the cluster assignments. Computing the evidence remains exponential in _K_ , hence intractable. 

## **2.2 The evidence lower bound** 

In variational inference, we specify a family _�_ of densities over the latent variables. Each _q_ ( **z** ) _∈�_ is a candidate approximation to the exact conditional. Our goal is to find the best candidate, the one closest in KL divergence to the exact conditional.[2] Inference now amounts to solving the following optimization problem, 

**==> picture [258 x 18] intentionally omitted <==**

Once found, _q[∗]_ ( _·_ ) is the best approximation of the conditional, within the family _�_ . The complexity of the family determines the complexity of this optimization. 

However, this objective is not computable because it requires computing the evidence log _p_ ( **x** ) in Equation (3). (That the evidence is hard to compute is why we appeal to approximate inference in the first place.) To see why, recall that KL divergence is 

**==> picture [289 x 10] intentionally omitted <==**

where all expectations are taken with respect to _q_ ( **z** ). Expand the conditional, 

**==> picture [309 x 10] intentionally omitted <==**

This reveals its dependence on log _p_ ( **x** ). 

Because we cannot compute the KL, we optimize an alternative objective that is equivalent to the KL up to an added constant, 

**==> picture [270 x 11] intentionally omitted <==**

This function is called the evidence lower bound (ELBO). The ELBO is the negative KL divergence of Equation (12) plus log _p_ ( **x** ), which is a constant with respect to _q_ ( **z** ). Maximizing the ELBO is equivalent to minimizing the KL divergence. 

Examining the ELBO gives intuitions about the optimal variational density. We rewrite the ELBO as a sum of the expected log likelihood of the data and the KL divergence between the prior _p_ ( **z** ) and _q_ ( **z** ), 

**==> picture [220 x 25] intentionally omitted <==**

> 2 The KL divergence is an information-theoretic measure of proximity between two densities. It is asymmetric— that is, KL ( _q∥p_ ) _̸_ = KL ( _p∥q_ )—and nonnegative. It is minimized when _q_ ( _·_ ) = _p_ ( _·_ ). 

6 

Which values of **z** will this objective encourage _q_ ( **z** ) to place its mass on? The first term is an expected likelihood; it encourages densities that place their mass on configurations of the latent variables that explain the observed data. The second term is the negative divergence between the variational density and the prior; it encourages densities close to the prior. Thus the variational objective mirrors the usual balance between likelihood and prior. 

Another property of the ELBO is that it lower-bounds the (log) evidence, log _p_ ( **x** ) _≥_ ELBO( _q_ ) for any _q_ ( **z** ). This explains the name. To see this notice that Equations (12) and (13) give the following expression of the evidence, 

**==> picture [268 x 10] intentionally omitted <==**

The bound then follows from the fact that KL ( _·_ ) _≥_ 0 (Kullback and Leibler, 1951). In the original literature on variational inference, this was derived through Jensen’s inequality (Jordan et al., 1999). 

The relationship between the ELBO and log _p_ ( **x** ) has led to using the variational bound as a model selection criterion. This has been explored for mixture models (Ueda and Ghahramani, 2002; McGrory and Titterington, 2007) and more generally (Beal and Ghahramani, 2003). The premise is that the bound is a good approximation of the marginal likelihood, which provides a basis for selecting a model. Though this sometimes works in practice, selecting based on a bound is not justified in theory. Other research has used variational approximations in the log predictive density to use VI in cross-validation based model selection (Nott et al., 2012). 

Finally, many readers will notice that the first term of the ELBO in Equation (13) is the expected complete log-likelihood, which is optimized by the EM algorithm (Dempster et al., 1977). The EM algorithm was designed for finding maximum likelihood estimates in models with latent variables. It uses the fact that the ELBO is equal to the log likelihood log _p_ ( **x** ) (i.e., the log evidence) when _q_ ( **z** ) = _p_ ( **z** _|_ **x** ). EM alternates between computing the expected complete log likelihood according to _p_ ( **z** _|_ **x** ) (the E step) and optimizing it with respect to the model parameters (the M step). Unlike variational inference, EM assumes the expectation under _p_ ( **z** _|_ **x** ) is computable and uses it in otherwise difficult parameter estimation problems. Unlike EM, variational inference does not estimate fixed model parameters—it is often used in a Bayesian setting where classical parameters are treated as latent variables. Variational inference applies to models where we cannot compute the exact conditional of the latent variables.[3] 

## **2.3 The mean-field variational family** 

We described the ELBO, the variational objective function in the optimization of Equation (10). We now describe a variational family _�_ , to complete the specification of the optimization problem. The complexity of the family determines the complexity of the optimization; it is more difficult to optimize over a complex family than a simple family. 

In this review we focus on the _mean-field variational family_ , where the latent variables are mutually independent and each governed by a distinct factor in the variational density. A generic member of the mean-field variational family is 

**==> picture [224 x 29] intentionally omitted <==**

> 3Two notes: (a) Variational EM is the EM algorithm with a variational E-step, i.e., a computation of an approximate conditional. (b) The coordinate ascent algorithm of Section 2.4 can look like the EM algorithm. The “E step” computes approximate conditionals of local latent variables; the “M step” computes a conditional of the global latent variables. 

7 

Each latent variable _z j_ is governed by its own variational factor, the density _q j_ ( _z j_ ). In optimization, these variational factors are chosen to maximize the ELBO of Equation (13). 

We emphasize that the variational family is not a model of the observed data—indeed, the data **x** does not appear in Equation (15). Instead, it is the ELBO, and the corresponding KL minimization problem, that connects the fitted variational density to the data and model. 

Notice we have not specified the parametric form of the individual variational factors. In principle, each can take on any parametric form appropriate to the corresponding random variable. For example, a continuous variable might have a Gaussian factor; a categorical variable will typically have a categorical factor. We will see in Sections 4, 4.1 and 4.2 that there are many models for which properties of the model determine optimal forms of the mean-field variational factors _q j_ ( _z j_ ). 

Finally, though we focus on mean-field inference in this review, researchers have also studied more complex families. One way to expand the family is to add dependencies between the variables (Saul and Jordan, 1996; Barber and Wiegerinck, 1999); this is called structured variational inference. Another way to expand the family is to consider mixtures of variational densities, i.e., additional latent variables within the variational family (Bishop et al., 1998). Both of these methods potentially improve the fidelity of the approximation, but there is a trade off. Structured and mixture-based variational families come with a more difficult-to-solve variational optimization problem. 

**Bayesian mixture of Gaussians (continued).** Consider again the Bayesian mixture of Gaussians. The mean-field variational family contains approximate posterior densities of the form 

**==> picture [268 x 30] intentionally omitted <==**

Following the mean-field recipe, each latent variable is governed by its own variational factor. The factor _q_ ( _µk_ ; _mk_ , _sk_[2][)][ is a Gaussian distribution on the] _[k]_[th mixture component’s] mean parameter; its mean is _mk_ and its variance is _sk_[2][.][The factor] _[ q]_[(] _[c][i]_[;] _[ϕ][i]_[)][ is a distribution] on the _i_ th observation’s mixture assignment; its assignment probabilities are a _K_ -vector _ϕi_ . 

Here we have asserted parametric forms for these factors: the mixture components are Gaussian with variational parameters (mean and variance) specific to the _k_ th cluster; the cluster assignments are categorical with variational parameters (cluster probabilities) specific to the _i_ th data point. In fact, these are the optimal forms of the mean-field variational density for the mixture of Gaussians. 

With the variational family in place, we have completely specified the variational inference problem for the mixture of Gaussians. The ELBO is defined by the model definition in Equation (7) and the mean-field family in Equation (16). The corresponding variational optimization problem maximizes the ELBO with respect to the variational parameters, i.e., the Gaussian parameters for each mixture component and the categorical parameters for each cluster assignment. We will see this example through in Section 3. 

**Visualizing the mean-field approximation.** The mean-field family is expressive because it can capture any marginal density of the latent variables. However, it cannot capture correlation between them. Seeing this in action reveals some of the intuitions and limitations of mean-field variational inference. 

Consider a two dimensional Gaussian distribution, shown in violet in Figure 1. This density is highly correlated, which defines its elongated shape. 

8 

**==> picture [188 x 94] intentionally omitted <==**

**----- Start of picture text -----**<br>
Exact Posterior<br>x 2 Mean-field Approximation<br>x 1<br>**----- End of picture text -----**<br>


**Figure 1:** Visualizing the mean-field approximation to a two-dimensional Gaussian posterior. The ellipses show the effect of mean-field factorization. (The ellipses are 2 _σ_ contours of the Gaussian distributions.) 

The optimal mean-field variational approximation to this posterior is a product of two Gaussian distributions. Figure 1 shows the mean-field variational density after maximizing the ELBO. While the variational approximation has the same mean as the original density, its covariance structure is, by construction, decoupled. 

Further, the marginal variances of the approximation under-represent those of the target density. This is a common effect in mean-field variational inference and, with this example, we can see why. The KL divergence from the approximation to the posterior is in Equation (11). It penalizes placing mass in _q_ ( _·_ ) on areas where _p_ ( _·_ ) has little mass, but penalizes less the reverse. In this example, in order to successfully match the marginal variances, the circular _q_ ( _·_ ) would have to expand into territory where _p_ ( _·_ ) has little mass. 

## **2.4** 

Using the ELBO and the mean-field family, we have cast approximate conditional inference as an optimization problem. In this section, we describe one of the most commonly used algorithms for solving this optimization problem, coordinate ascent variational inference (CAVI) (Bishop, 2006). CAVI iteratively optimizes each factor of the mean-field variational density, while holding the others fixed. It climbs the ELBO to a local optimum. 

**The algorithm.** We first state a result. Consider the _j_ th latent variable _z j_ . The _complete conditional_ of _z j_ is its conditional density given all of the other latent variables in the model and the observations, _p_ ( _z j |_ **z** _− j_ , **x** ). Fix the other variational factors _qℓ_ ( _zℓ_ ), _ℓ_ = _j_ . The optimal _q j_ ( _z j_ ) is then proportional to the exponentiated expected log of the complete conditional, 

**==> picture [267 x 14] intentionally omitted <==**

The expectation in Equation (17) is with respect to the (currently fixed) variational density over **z** _− j_ , that is, � _ℓ_ = _j[q][ℓ]_[(] _[z][ℓ]_[)][.][Equivalently, Equation (17) is proportional to the exponenti-] ated log of the joint, 

**==> picture [267 x 15] intentionally omitted <==**

Because of the mean-field family assumption—that all the latent variables are independent— the expectations on the right hand side do not involve the _j_ th variational factor. Thus this is a valid coordinate update. 

These equations underlie the CAVI algorithm, presented as Algorithm 1. We maintain a set of variational factors _qℓ_ ( _zℓ_ ). We iterate through them, updating _q j_ ( _z j_ ) using Equation (18). 

9 

**Algorithm 1:** Coordinate ascent variational inference (CAVI) 

**Input:** A model _p_ ( **x** , **z** ), a data set **x** _m_ **Output:** A variational density _q_ ( **z** ) = � _j_ =1 _[q][j]_[(] _[z][j]_[)] **Initialize:** Variational factors _q j_ ( _z j_ ) **while** _the_ ELBO _has not converged_ **do for** _j ∈{_ 1,..., _m}_ **do** Set _q j_ ( _z j_ ) _∝_ exp _{_ � _− j_ [log _p_ ( _z j |_ **z** _− j_ , **x** )] _}_ **end** Compute ELBO( _q_ ) = � [log _p_ ( **z** , **x** )] _−_ � [log _q_ ( **z** )] **end return** _q_ ( **z** ) 

CAVI goes uphill on the ELBO of Equation (13), eventually finding a local optimum. As examples we show CAVI for a mixture of Gaussians in Section 3 and for a nonconjugate linear regression in Appendix A. 

CAVI can also be seen as a “message passing” algorithm (Winn and Bishop, 2005), iteratively updating each random variable’s variational parameters based on the variational parameters of the variables in its Markov blanket. This perspective enabled the design of automated software for a large class of models (Wand et al., 2011; Minka et al., 2014). Variational message passing connects variational inference to the classical theories of graphical models and probabilistic inference (Pearl, 1988; Lauritzen and Spiegelhalter, 1988). It has been extended to nonconjugate models (Knowles and Minka, 2011) and generalized via factor graphs (Minka, 2005). 

Finally, CAVI is closely related to Gibbs sampling (Geman and Geman, 1984; Gelfand and Smith, 1990), the classical workhorse of approximate inference. The Gibbs sampler maintains a realization of the latent variables and iteratively samples from each variable’s complete conditional. Equation (18) uses the same complete conditional. It takes the expected log, and uses this quantity to iteratively set each variable’s variational factor.[4] 

**Derivation.** We now derive the coordinate update in Equation (18). The idea appears in Bishop (2006), but the argument there uses gradients, which we do not. Rewrite the ELBO of Equation (13) as a function of the _j_ th variational factor _q j_ ( _z j_ ), absorbing into a constant the terms that do not depend on it, 

**==> picture [317 x 14] intentionally omitted <==**

We have rewritten the first term of the ELBO using iterated expectation. The second term we have decomposed, using the independence of the variables (i.e., the mean-field assumption) and retaining only the term that depends on _q j_ ( _z j_ ). 

Up to an added constant, the objective function in Equation (19) is equal to the negative KL divergence between _q j_ ( _z j_ ) and _q[∗] j_[(] _[z][j]_[)][ from Equation (18).][Thus we maximize the][ELBO] with respect to _q j_ when we set _q j_ ( _z j_ ) = _q[∗] j_[(] _[z][j]_[)][.] 

> 4Many readers will know that we can significantly speed up the Gibbs sampler by marginalizing out some of the latent variables; this is called collapsed Gibbs sampling. We can speed up variational inference with similar reasoning; this is called collapsed variational inference. It has been developed for the same class of models described here (Sung et al., 2008; Hensman et al., 2012). These ideas are outside the scope of our review. 

10 

## **2.5 Practicalities** 

Here, we highlight a few things to keep in mind when implementing and using variational inference in practice. 

**Initialization.** The ELBO is (generally) a non-convex objective function. CAVI only guarantees convergence to a local optimum, which can be sensitive to initialization. Figure 2 shows the ELBO trajectory for 10 random initializations using the Gaussian mixture model. The means of the variational factors were randomly initialized by drawing from a factorized Gaussian calibrated to the empirical mean and variance of the dataset. (This inference is on images; see Section 3.4.) Each initialization reaches a different value, indicating the presence of many local optima in the ELBO. In terms of KL( _q||p_ ), better local optima give variational densities that are closer to the exact posterior. 

**==> picture [355 x 118] intentionally omitted <==**

**----- Start of picture text -----**<br>
− 1.6  ·  10 [6]<br>− 1.8  ·  10 [6]<br>− 2  ·  10 [6]<br>− 2.2  ·  10 [6]<br>− 2.4  ·  10 [6] CAVI<br>0 10 20 30 40 50<br>Seconds<br>ELBO<br>**----- End of picture text -----**<br>


**Figure 2:** Different initializations may lead CAVI to find different local optima of the ELBO. 

This is not always a disadvantage. Some models, such as the mixture of Gaussians (Section 3 and appendix B) and mixed-membership model (Appendix C), exhibit many posterior modes due to label switching: swapping cluster assignment labels induces many symmetric posterior modes. Representing one of these modes is sufficient for exploring latent clusters or predicting new observations. 

**Assessing convergence.** Monitoring the ELBO in CAVI is simple; we typically assess convergence once the change in ELBO has fallen below some small threshold. However, computing the ELBO of the full dataset may be undesirable. Instead, we suggest computing the average log predictive of a small held-out dataset. Monitoring changes here is a proxy to monitoring the ELBO of the full data. (Unlike the full ELBO, held-out predictive probability is not guaranteed to monotonically increase across iterations of CAVI.) 

**Numerical stability.** Probabilities are constrained to live within [0, 1]. Precisely manipulating and performing arithmetic of small numbers requires additional care. When possible, we recommend working with logarithms of probabilities. One useful identity is the “log-sum-exp” trick, 

**==> picture [284 x 29] intentionally omitted <==**

The constant _α_ is typically set to max _i xi_ . This provides numerical stability to common computations in variational inference procedures. 

## **3 A complete example: Bayesian mixture of Gaussians** 

As an example, we return to the simple mixture of Gaussians model of Section 2.1. To review, consider _K_ mixture components and _n_ real-valued data points _x_ 1: _n_ . The latent variables 

11 

are _K_ real-valued mean parameters _**µ**_ = _µ_ 1: _K_ and _n_ latent-class assignments **c** = _c_ 1: _n_ . The assignment _ci_ indicates which latent cluster _xi_ comes from. In detail, _ci_ is an indicator _K_ -vector, all zeros except for a one in the position corresponding to _xi_ ’s cluster. There is a fixed hyperparameter _σ_[2] , the variance of the normal prior on the _µk_ ’s. We assume the observation variance is one and take a uniform prior over the mixture components. 

The joint density of the latent and observed variables is in Equation (7). The variational family is in Equation (16). Recall that there are two types of variational parameters— categorical parameters _ϕi_ for approximating the posterior cluster assignment of the _i_ th data point and Gaussian parameters _mk_ and _sk_[2][for approximating the posterior of the] _[k]_[th] mixture component. 

We combine the joint and the mean-field family to form the ELBO for the mixture of Gaussians. It is a function of the variational parameters **m** , **s**[2] , and _**ϕ**_ , 

**==> picture [334 x 96] intentionally omitted <==**

In each term, we have made explicit the dependence on the variational parameters. Each expectation can be computed in closed form. 

The CAVI algorithm updates each variational parameter in turn. We first derive the update for the variational cluster assignment factor; we then derive the update for the variational mixture component factor. 

## **3.1 The variational density of the mixture assignments** 

We first derive the variational update for the cluster assignment _ci_ . Using Equation (18), 

**==> picture [303 x 14] intentionally omitted <==**

The terms in the exponent are the components of the joint density that depend on _ci_ . The expectation in the second term is over the mixture components _**µ**_ . 

The first term of Equation (22) is the log prior of _ci_ . It is the same for all possible values of _ci_ , log _p_ ( _ci_ ) = _−_ log _K_ . The second term is the expected log of the _ci_ th Gaussian density. Recalling that _ci_ is an indicator vector, we can write 

**==> picture [121 x 30] intentionally omitted <==**

We use this to compute the expected log probability, 

**==> picture [348 x 77] intentionally omitted <==**

12 

In each line we remove terms that are constant with respect to _ci_ . This calculation requires � [ _µk_ ] and � � _µ_[2] _k_ � for each mixture component, both computable from the variational Gaussian on the _k_ th mixture component. 

Thus the variational update for the _i_ th cluster assignment is 

**==> picture [290 x 13] intentionally omitted <==**

Notice it is only a function of the variational parameters for the mixture components. 

## **3.2 The variational density of the mixture-component means** 

We turn to the variational density _q_ ( _µk_ ; _mk_ , _sk_[2][)][ of the] _[k]_[th mixture component.][Again we] use Equation (18) and write down the joint density up to a normalizing constant, 

**==> picture [323 x 13] intentionally omitted <==**

We now calculate the unnormalized log of this coordinate-optimal _q_ ( _µk_ ). Recall _ϕik_ is the probability that the _i_ th observation comes from the _k_ th cluster. Because _ci_ is an indicator vector, we see that _ϕik_ = � [ _cik_ ; _ϕi_ ]. Now 

**==> picture [326 x 95] intentionally omitted <==**

This calculation reveals that the coordinate-optimal variational density of _µk_ is an exponen- _n_ tial family with sufficient statistics _{µk_ , _µ_[2] _k[}]_[ and natural parameters] _[ {]_ � _i_ =1 _[ϕ][ik][x][i]_[,] _[−]_[1] _[/]_[2] _[σ]_[2] _[ −]_ � _ni_ =1 _[ϕ][ik][/]_[2] _[}]_[, i.e., a Gaussian.][Expressed in terms of the variational mean and variance, the] updates for _q_ ( _µk_ ) are 

**==> picture [285 x 28] intentionally omitted <==**

These updates relate closely to the complete conditional density of the _k_ th component in the mixture model. The complete conditional is a posterior Gaussian given the data assigned to the _k_ th component. The variational update is a weighted complete conditional, where each data point is weighted by its variational probability of being assigned to component _k_ . 

## **3.3 CAVI for the mixture of Gaussians** 

Algorithm 2 presents coordinate-ascent variational inference for the Bayesian mixture of Gaussians. It combines the variational updates in Equation (22) and Equation (34). The algorithm requires computing the ELBO of Equation (21). We use the ELBO to track the progress of the algorithm and assess when it has converged. 

Once we have a fitted variational density, we can use it as we would use the posterior. For example, we can obtain a posterior decomposition of the data. We assign points to their ˆ most likely mixture assignment _ci_ = argmax _k ϕik_ and estimate cluster means with their variational means _mk_ . 

13 

**Algorithm 2:** CAVI for a Gaussian mixture model 

**==> picture [349 x 255] intentionally omitted <==**

We can also use the fitted variational density to approximate the predictive density of new data. This approximate predictive is a mixture of Gaussians, 

**==> picture [259 x 29] intentionally omitted <==**

where _p_ ( _x_ new _| mk_ ) is a Gaussian with mean _mk_ and unit variance. 

## **3.4 Empirical study** 

We present two analyses to demonstrate the mixture of Gaussians algorithm in action. The first is a simulation study; the second is an analysis of a data set of natural images. 

**Simulation study.** Consider two-dimensional real-valued data **x** . We simulate _K_ = 5 Gaussians with random means, covariances, and mixture assignments. Figure 3 shows the data; each point is colored according to its true cluster. Figure 3 also illustrates the initial variational density of the mixture components—each is a Gaussian, nearly centered, and with a wide variance; the subpanels plot the variational density of the components as the CAVI algorithm progresses. 

The progression of the ELBO tells a story. We highlight key points where the ELBO develops “elbows”, phases of the maximization where the variational approximation changes its shape. These “elbows” arise because the ELBO is not a convex function in terms of the variational parameters; CAVI iteratively reaches better plateaus. 

Finally, we plot the logarithm of the Bayesian predictive density as approximated by the variational density. Here we report the average across held-out data. Note this plot is smoother than the ELBO. 

**Image analysis.** We now turn to an experimental study. Consider the task of grouping images according to their color profiles. One approach is to compute the color histogram 

14 

**==> picture [234 x 110] intentionally omitted <==**

**==> picture [349 x 178] intentionally omitted <==**

**----- Start of picture text -----**<br>
Initialization Iteration 20<br>Iteration 28 Iteration 35 Iteration 50<br>**----- End of picture text -----**<br>


**==> picture [351 x 128] intentionally omitted <==**

**----- Start of picture text -----**<br>
Evidence Lower Bound Average Log Predictive<br>�<br>3;200<br>�1<br>�3;500 �1:1<br>�1:2<br>�<br>3;800<br>�1:3<br>�4;100 �1:4<br>0 10 20 30 40 50 60 0 10 20 30 40 50 60<br>Iterations Iterations<br>**----- End of picture text -----**<br>


**Figure 3:** A simulation study of a two dimensional Gaussian mixture model. The ellipses are 2 _σ_ contours of the variational approximating factors. 

15 

of the images. Figure 4 shows the red, green, and blue channel histograms of two images from the imageCLEF data (Villegas et al., 2013). Each histogram is a vector of length 192; concatenating the three color histograms gives a 576-dimensional representation of each image, regardless of its original size in pixel-space. 

We use CAVI to fit a Gaussian mixture model with thirty clusters to image histograms. We randomly select two sets of ten thousand images from the imageCLEF collection to serve as training and testing datasets. Figure 5 shows similarly colored images assigned to four randomly chosen clusters. Figure 6 shows the average log predictive accuracy of the testing set as a function of time. We compare CAVI to an implementation in Stan (Stan Development Team, 2015), which uses a Hamiltonian Monte Carlo-based sampler (Hoffman and Gelman, 2014). (Details are in Appendix B.) CAVI is orders of magnitude faster than this sampling algorithm.[5] 

**==> picture [177 x 118] intentionally omitted <==**

**==> picture [178 x 119] intentionally omitted <==**

**==> picture [159 x 256] intentionally omitted <==**

**----- Start of picture text -----**<br>
Pixel Intensity<br>Pixel Intensity<br>Counts<br>Pixel<br>Counts<br>Pixel<br>**----- End of picture text -----**<br>


**Figure 4:** Red, green, and blue channel image histograms for two images from the imageCLEF dataset. The top image lacks blue hues, which is reflected in its blue channel histogram. The bottom image has a few dominant shades of blue and green, as seen in the peaks of its histogram. 

## **4 Variational inference with exponential families** 

We described mean-field variational inference and derived CAVI, a general coordinate-ascent algorithm for optimizing the ELBO. We demonstrated this approach on a simple mixture of Gaussians, where each coordinate update was available in closed form. 

> 5 This is not a definitive comparison between variational inference and MCMC. Other samplers, such as a collapsed Gibbs sampler, may perform better than Hamiltonian Monte Carlo sampling. 

16 

**==> picture [73 x 74] intentionally omitted <==**

**==> picture [73 x 74] intentionally omitted <==**

**==> picture [73 x 74] intentionally omitted <==**

**==> picture [73 x 74] intentionally omitted <==**

**==> picture [305 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a)  Purple (b)  Green & White (c)  Orange (d)  Grayish Blue<br>**----- End of picture text -----**<br>


**Figure 5:** Example clusters from the Gaussian mixture model. We assign each image to its most likely mixture cluster. The subfigures show nine randomly sampled images from four clusters; their namings are subjective. 

**==> picture [358 x 122] intentionally omitted <==**

**----- Start of picture text -----**<br>
0<br>�300<br>�600<br>CAVI<br>�900 NUTS (Hoffman et al. 2013)<br>0 50 100 150 200 250<br>Seconds<br>Average Log Predictive<br>**----- End of picture text -----**<br>


**Figure 6:** Comparison of CAVI to a Hamiltonian Monte Carlo-based sampling technique. CAVI fits a Gaussian mixture model to ten thousand images in less than a minute. 

The mixture of Gaussians is one member of the important class of models where each complete conditional is in the exponential family. This includes a number of widely used models, such as Bayesian mixtures of exponential families, factorial mixture models, matrix factorization models, certain hierarchical regression models (e.g., linear regression, probit regression), stochastic blockmodels of networks, hierarchical mixtures of experts, and a variety of mixed-membership models (which we will discuss below). 

Working in this family simplifies variational inference: it is easier to derive the corresponding CAVI algorithm, and it enables variational inference to scale up to massive data. In Section 4.1, we develop the general case. In Section 4.2, we discuss conditionally conjugate models, i.e., the common Bayesian application where some latent variables are “local” to a data point and others, usually identified with parameters, are “global” to the entire data set. Finally, in Section 4.3, we describe stochastic variational inference (Hoffman et al., 2013), a stochastic optimization algorithm that scales up variational inference in this setting. 

## **4.1 Complete conditionals in the exponential family** 

Consider the generic model _p_ ( **z** , **x** ) of Section 2.1 and suppose each complete conditional is in the exponential family: 

**==> picture [300 x 14] intentionally omitted <==**

where _z j_ is its own sufficient statistic, _h_ ( _·_ ) is a base measure, and _a_ ( _·_ ) is the log normalizer (Brown, 1986). Because this is a conditional density, the parameter _η j_ ( **z** _− j_ , **x** ) is a function of the conditioning set. 

Consider mean-field variational inference for this class of models, where we fit _q_ ( **z** ) = 

17 

� _j[q][j]_[(] _[z][j]_[)][.][The][exponential][family][assumption][simplifies][the][coordinate][update][of][Equa-] tion (17), 

**==> picture [316 x 55] intentionally omitted <==**

This update reveals the parametric form of the optimal variational factors. Each one is in the same exponential family as its corresponding complete conditional. Its parameter has the same dimension and it has the same base measure _h_ ( _·_ ) and log normalizer _a_ ( _·_ ). 

Having established their parametric forms, let _ν j_ denote the variational parameter for the _j_ th variational factor. When we update each factor, we set its parameter equal to the expected parameter of the complete conditional, 

**==> picture [229 x 14] intentionally omitted <==**

This expression facilitates deriving CAVI algorithms for many complex models. 

## **4.2 Conditional conjugacy and Bayesian models** 

One important special case of exponential family models are _conditionally conjugate models_ with local and global variables. Models like this come up frequently in Bayesian statistics and statistical machine learning, where the global variables are the “parameters” and the local variables are per-data-point latent variables. 

**Conditionally conjugate models.** Let _β_ be a vector of _global latent variables_ , which potentially govern any of the data. Let **z** be a vector of _local latent variables_ , whose _i_ th component only governs data in the _i_ th “context.” The joint density is 

**==> picture [255 x 28] intentionally omitted <==**

The mixture of Gaussians of Section 3 is an example. The global variables are the mixture components; the _i_ th local variable is the cluster assignment for data point _xi_ . 

We will assume that the modeling terms of Equation (41) are chosen to ensure each complete conditional is in the exponential family. In detail, we first assume the joint density of each ( _xi_ , _zi_ ) pair, conditional on _β_ , has an exponential family form, 

**==> picture [284 x 12] intentionally omitted <==**

where _t_ ( _·_ , _·_ ) 

Next, we take the prior on the global variables to be the corresponding conjugate prior (Diaconis et al., 1979; Bernardo and Smith, 1994), 

**==> picture [271 x 12] intentionally omitted <==**

This prior has natural (hyper)parameter _α_ = [ _α_ 1, _α_ 2] _[⊤]_ , a column vector, and sufficient statistics that concatenate the global variable and its log normalizer in the density of the local variables. 

With the conjugate prior, the complete conditional of the global variables is in the same family. Its natural parameter is 

**==> picture [261 x 15] intentionally omitted <==**

18 

Turn now to the complete conditional of the local variable _zi_ . Given _β_ and _xi_ , the local variable _zi_ is conditionally independent of the other local variables **z** _−i_ and other data **x** _−i_ . This follows from the form of the joint density in Equation (41). Thus 

**==> picture [257 x 10] intentionally omitted <==**

We further assume that this density is in an exponential family, 

**==> picture [292 x 12] intentionally omitted <==**

This is a property of the local likelihood term _p_ ( _zi_ , _xi | β_ ) from Equation (42). For example, in the mixture of Gaussians, the complete conditional of the local variable is a categorical. 

**Variational inference in conditionally conjugate models.** We now describe CAVI for this general class of models. Write _q_ ( _β | λ_ ) for the variational posterior approximation on _β_ ; we call _λ_ the “global variational parameter”. It indexes the same exponential family density as the prior. Similarly, let the variational posterior _q_ ( _zi | ϕi_ ) on each local variable _zi_ be governed by a “local variational parameter” _ϕi_ . It indexes the same exponential family density as the local complete conditional. CAVI iterates between updating each local variational parameter and updating the global variational parameter. 

The local variational update is 

**==> picture [228 x 11] intentionally omitted <==**

This is an application of Equation (40), where we take the expectation of the natural parameter of the complete conditional in Equation (45). 

The global variational update applies the same technique. It is 

**==> picture [273 x 16] intentionally omitted <==**

Here we take the expectation of the natural parameter in Equation (44). 

CAVI optimizes the ELBO by iterating between local updates of each local parameter and global updates of the global parameters. To assess convergence we can compute the ELBO at each iteration (or at some lag), up to a constant that does not depend on the variational parameters, 

**==> picture [363 x 16] intentionally omitted <==**

This is the ELBO in Equation (13) applied to the joint in Equation (41) and the corresponding mean-field variational density; we have omitted terms that do not depend on the variational parameters. The last term is 

**==> picture [316 x 27] intentionally omitted <==**

CAVI for the mixture of Gaussians model (Algorithm 2) is an instance of this method. Appendix C presents another example of CAVI for latent Dirichlet allocation (LDA), a probabilistic topic model. 

## **4.3 Stochastic variational inference** 

Modern applications of probability models often require analyzing massive data. However, most posterior inference algorithms do not easily scale. CAVI is no exception, particularly in 

19 

the conditionally conjugate setting of Section 4.2. The reason is that the coordinate ascent structure of the algorithm requires iterating through the entire data set at each iteration. As the data set size grows, each iteration becomes more computationally expensive. 

An alternative to coordinate ascent is gradient-based optimization, which climbs the ELBO by computing and following its gradient at each iteration. This perspective is the key to scaling up variational inference using stochastic variational inference (SVI) (Hoffman et al., 2013), a method that combines natural gradients (Amari, 1998) and stochastic optimization (Robbins and Monro, 1951). 

SVI focuses on optimizing the global variational parameters _λ_ of a conditionally conjugate model. The flow of computation is simple. The algorithm maintains a current estimate of the global variational parameters. It repeatedly (a) subsamples a data point from the full data set; (b) uses the current global parameters to compute the optimal local parameters for the subsampled data point; and (c) adjusts the current global parameters in an appropriate way. SVI is detailed in Algorithm 3. We now show why it is a valid algorithm for optimizing the ELBO. 

**The natural gradient of the ELBO.** In gradient-based optimization, the _natural gradient_ accounts for the geometric structure of probability parameters (Amari, 1982, 1998). Specifically, natural gradients warp the parameter space in a sensible way, so that moving the same distance in different directions amounts to equal change in symmetrized KL divergence. The usual Euclidean gradient does not enjoy this property. 

In exponential families, we find the natural gradient with respect to the parameter by premultiplying the usual gradient by the inverse covariance of the sufficient statistic, _a[′′]_ ( _λ_ ) _[−]_[1] . This is the inverse Riemannian metric and the inverse Fisher information matrix (Amari, 1982). 

Conditionally conjugate models enjoy simple natural gradients of the ELBO. We focus on gradients with respect to the global parameter _λ_ . Hoffman et al. (2013) derive the Euclidean gradient of the ELBO, 

**==> picture [251 x 13] intentionally omitted <==**

where � _ϕ_ [ _α_ ˆ] is in Equation (48). Premultiplying by the inverse Fisher information gives the natural gradient _g_ ( _λ_ ), 

**==> picture [227 x 12] intentionally omitted <==**

It is the difference between the coordinate updates � _ϕ_ [ _α_ ˆ] and the variational parameters _λ_ at which we are evaluating the gradient. In addition to enjoying good theoretical properties, the natural gradient is easier to calculate than the Euclidean gradient. For more on natural gradients and variational inference see Sato (2001) and Honkela et al. (2008). 

We can use this natural gradient in a gradient-based optimization algorithm. At each iteration, we update the global parameters, 

**==> picture [236 x 11] intentionally omitted <==**

where _εt_ is a step size. 

Substituting Equation (52) into the second term reveals a special structure, 

**==> picture [250 x 12] intentionally omitted <==**

Notice this does not require additional types of calculations other than those for coordinate ascent updates. At each iteration, we first compute the coordinate update. We then adjust the current estimate to be a weighted combination of the update and the current variational parameter. 

20 

Though easy to compute, using the natural gradient has the same cost as the coordinate update in Equation (48); it requires summing over the entire data set and computing the optimal local variational parameters for each data point. With massive data, this is prohibitively expensive. 

**Stochastic optimization of the ELBO.** Stochastic variational inference solves this problem by using the natural gradient in a stochastic optimization algorithm. Stochastic optimization algorithms follow noisy but cheap-to-compute gradients to reach the optimum of an objective function. (In the case of the ELBO, stochastic optimization will reach a local optimum.) In their seminal paper, Robbins and Monro (1951) proved results implying that optimization algorithms can successfully use noisy, unbiased gradients, as long as the step size sequence satisfies certain conditions. This idea has blossomed (Spall, 2003; Kushner and Yin, 1997). Stochastic optimization has enabled modern machine learning to scale to massive data (Le Cun and Bottou, 2004). 

Our aim is to construct a cheaply computed, noisy, unbiased natural gradient. We expand the natural gradient in Equation (52) using Equation (44) 

**==> picture [275 x 19] intentionally omitted <==**

where _ϕi[∗]_[indicates that we consider the optimized local variational parameters (at fixed] global parameters _λ_ ) in Equation (47). We construct a noisy natural gradient by sampling an index from the data and then rescaling the second term, 

**==> picture [252 x 10] intentionally omitted <==**

**==> picture [267 x 16] intentionally omitted <==**

The noisy natural gradient _g_ ˆ( _λ_ ) is unbiased: � _t_ [ _g_ ˆ( _λ_ )] = _g_ ( _λ_ ). And it is cheap to compute— it only involves a single sampled data point and only one set of optimized local parameters. (This immediately extends to minibatches, where we sample _B_ data points and rescale appropriately.) Again, the noisy gradient only requires calculations from the coordinate ascent algorithm. The first two terms of Equation (57) are equivalent to the coordinate update in a model with _n_ replicates of the sampled data point. 

Finally, we set the step size sequence. It must follow the conditions of Robbins and Monro (1951), 

**==> picture [250 x 22] intentionally omitted <==**

Many sequences will satisfy these conditions, for example _εt_ = _t[−][κ]_ for _κ ∈_ (0.5, 1]. The full SVI algorithm is in Algorithm 3. 

We emphasize that SVI requires no new derivation beyond what is needed for CAVI. Any implementation of CAVI can be immediately scaled up to a stochastic algorithm. 

**Probabilistic topic models.** We demonstrate SVI with a probabilistic topic model. Probabilistic topic models are mixed-membership models of text, used to uncover the latent “topics” that run through a collection of documents. Topic models have become a popular technique for exploratory data analysis of large collections (Blei, 2012). 

In detail, each latent topic is a distribution over terms in a vocabulary and each document is a collection of words that comes from a mixture of the topics. The topics are shared across the collection, but each document mixes them with different proportions. (This is the hallmark of a mixed-membership model.) Thus topic modeling casts topic discovery as a posterior inference problem. Posterior estimates of the topics and topic proportions can be used to summarize, visualize, explore, and form predictions about the documents. 

21 

|1|1|2|2|3|3|4|4|5|5|
|---|---|---|---|---|---|---|---|---|---|
|||~~li~~||~~fil~~|||~~k~~|~~i~~||
|~~ga~~<br>|~~me~~<br>|~~k~~|~~e~~<br>||~~m~~<br>~~i~~|~~li~~<br>~~bo~~|~~o~~|~~w~~|~~ne~~|
|~~sea~~<br>|~~son~~<br>|~~n~~|~~l~~<br>~~ow~~|~~h~~<br>~~mo~~|~~ve~~||~~e~~<br>~~k~~|~~str~~<br>~~h~~|~~eet~~<br>~~l~~|
|~~te~~<br>|~~m~~<br>~~h~~|~~sc~~|~~oo~~|~~li~~<br>~~s~~|~~ow~~|~~bo~~<br>|~~s~~<br>~~l~~|~~h~~<br>~~o~~|~~te~~|
|~~l~~<br>~~co~~|~~c~~|~~str~~<br>|~~eet~~<br>|~~l~~|~~e~~<br>~~ii~~|~~no~~|~~ve~~|~~o~~<br>|~~se~~<br>|
|~~p~~<br>~~i~~|~~ay~~<br>|~~f~~<br>~~m~~|~~il~~<br>~~an~~|~~teev~~<br>~~fil~~|~~son~~<br>|~~st~~|~~ry~~|~~i~~<br>~~ro~~|~~h~~<br>~~m~~|
|~~po~~|~~nts~~|~~a~~<br>|~~y~~<br>|~~i~~<br>|~~s~~|~~m~~<br>|~~an~~<br>|~~n~~<br>~~l~~|~~t~~<br>|
|~~ga~~<br>~~i~~|~~es~~<br>|~~h~~<br>~~sa~~|~~ys~~|~~dre~~|~~ctor~~|~~h~~<br>~~aut~~|~~or~~|~~pa~~<br>|~~ce~~<br>|
|~~ga~~|~~nts~~|~~o~~<br>~~hil~~|~~se~~<br>|~~m~~<br>|~~an~~<br>|~~o~~<br>|~~se~~<br>|~~resta~~|~~k~~<br>~~urant~~|
|~~sec~~<br>~~l~~|~~ond~~<br>|~~c~~<br>~~i~~|~~ren~~<br>~~h~~|~~st~~|~~ry~~|~~hil~~<br>~~w~~|~~ar~~|~~pa~~<br>|~~r~~<br>|
|~~pa~~|~~ers~~|~~n~~|~~t~~|~~sa~~|~~ys~~|~~c~~|~~ren~~|~~gar~~|~~en~~|
|6||7||8||9||10||
||~~h~~|~~il~~|~~i~~|||||||
|~~bu~~<br>|~~s~~<br>~~i~~|~~bu~~|~~ng~~|~~w~~|~~n~~|~~yan~~|~~ees~~|~~gover~~<br>|~~ment~~<br>|
|~~li~~<br>~~cam~~|~~agn~~|~~str~~<br>|~~eet~~<br>|~~te~~|~~m~~|~~ga~~<br>|~~me~~<br>|~~w~~<br>~~ili~~|~~ar~~<br>|
|~~cn~~<br>|~~ton~~<br>~~li~~|~~squ~~<br>~~h~~|~~are~~<br>~~i~~|~~sec~~<br>|~~ond~~<br>|~~m~~|~~ts~~|~~ffi~~<br>~~m~~|~~il~~<br>~~ary~~|
|~~h~~<br>~~repu~~|~~can~~|~~h~~<br>~~ou~~|~~sng~~|~~ra~~<br>|~~ce~~<br>|~~sea~~<br>|~~son~~<br>|~~o~~<br>~~i~~|~~as~~<br>|
|~~o~~<br>|~~se~~<br>|~~o~~<br>~~il~~|~~se~~<br>~~i~~|~~ro~~<br>|~~nd~~<br>|~~r~~<br>~~l~~|~~n~~<br>|~~r~~<br>~~f~~|~~q~~<br>|
|~~pa~~<br>|~~rty~~<br>~~i~~|~~l~~<br>~~bu~~|~~ngs~~|~~c~~|~~p~~|~~ea~~<br>|~~gue~~<br>~~ll~~|~~or~~<br>~~i~~|~~es~~<br>~~i~~|
|~~li~~<br>~~demo~~|~~il~~<br>~~cratc~~|~~deveo~~|~~pment~~|~~op~~|~~en~~|~~bas~~|~~ba~~|~~r~~|~~q~~|
|~~po~~<br>|~~ca~~<br>|~~sp~~|~~ce~~|~~ga~~<br>~~l~~|~~me~~<br>|~~te~~<br>|~~m~~<br>|~~ar~~<br>|~~my~~<br>|
|~~dem~~|~~crats~~|~~per~~<br>|~~ent~~<br>~~l~~|~~p~~<br>|~~ay~~<br>|~~ga~~<br>|~~es~~<br>~~i~~|~~tro~~<br>~~l~~|~~ps~~<br>~~i~~|
|~~sen~~|~~ator~~|~~re~~|~~a~~|~~w~~|~~n~~||~~t~~|~~so~~|~~ers~~|
|11||12||13||14||15||
|~~hil~~|||~~k~~|~~h~~|~~h~~||||~~i~~|
|~~c~~|~~l~~<br>~~ren~~|~~st~~|~~c~~|~~cu~~|~~rc~~|~~a~~<br>|~~rt~~<br>|~~po~~|~~ce~~|
|~~sc~~<br>|~~oo~~<br>|~~per~~<br>|~~ent~~<br>~~i~~|~~w~~<br>|~~ar~~<br>|~~h~~<br>~~mus~~|~~eum~~|~~yest~~<br>|~~rday~~<br>|
|~~f~~<br>~~wo~~|~~il~~<br>~~en~~|~~comp~~<br>~~f~~|~~anes~~<br>|~~li~~<br>~~wo~~|~~en~~|~~s~~<br>~~l~~|~~ow~~<br>|~~m~~<br>~~ffi~~|~~an~~<br>|
|~~a~~<br>|~~y~~<br>|~~u~~|~~k~~<br>~~nd~~|~~l~~|~~e~~<br>~~k~~|~~ga~~|~~k~~<br>~~ery~~|~~o~~<br>~~ffi~~|~~cer~~<br>|
|~~par~~<br>|~~nts~~<br>~~il~~|~~ma~~<br>|~~et~~<br>~~k~~|~~li~~<br>~~b~~|~~il~~<br>~~c~~|~~wo~~<br>|~~rs~~<br>|~~o~~|~~ers~~|
|~~li~~<br>~~c~~|~~d~~|~~ba~~<br>~~i~~|~~n~~<br>|~~po~~<br>|~~ca~~<br>~~li~~|~~art~~|~~sts~~|~~ca~~<br>~~f~~|~~se~~<br>|
||~~e~~<br>|~~nve~~<br>~~f~~|~~tors~~<br>|~~cat~~|~~oc~~|~~str~~<br>|~~eet~~<br>~~i~~|~~ou~~<br>~~h~~|~~nd~~<br>|
|~~sa~~<br>~~h~~|~~ys~~<br>~~l~~|~~fi~~<br>~~u~~|~~il~~<br>~~ds~~|~~gover~~<br>|~~ment~~<br>~~ih~~|~~ar~~<br>~~i~~|~~st~~<br>~~i~~|~~ca~~|~~ged~~|
||~~p~~<br>~~h~~|~~i~~<br>~~na~~|~~ca~~|~~jew~~<br>|~~s~~<br>|~~hi~~<br>~~pan~~|~~ii~~<br>~~ngs~~|~~str~~<br>|~~eet~~<br>|
|~~mo~~|~~er~~|~~bus~~|~~ess~~|~~po~~|~~pe~~|~~ex~~|~~ton~~|~~s~~|~~ot~~|



**Figure 7:** Topics found in a corpus of 1.8M articles from the New York Times. Reproduced with permission from Hoffman et al. (2013). 

One motivation for topic modeling is to get a handle on massive collections of documents. Early inference algorithms were based on coordinate ascent variational inference (Blei et al., 2003) and analyzed collections in the thousands or tens of thousands of documents. (Appendix C presents this algorithm). With SVI, topic models scale up to millions of documents; the details of the algorithm are in Hoffman et al. (2013). Figure 7 illustrates topics inferred using the latent Dirichlet allocation model (Blei et al., 2003) from 1.8M articles from the _New York Times_ . This analysis would not have been possible without SVI. 

## **5 Discussion** 

We described variational inference, a method that uses optimization to make probabilistic computations. The goal is to approximate the conditional density of latent variables **z** given observed variables **x** , _p_ ( **z** _|_ **x** ). The idea is to posit a family of densities _�_ and then to find the member _q[∗]_ ( _·_ ) that is closest in KL divergence to the conditional of interest. Minimizing the KL divergence is the optimization problem, and its complexity is governed by the complexity of the approximating family. 

We then described the mean-field family, i.e., the family of fully factorized densities of the latent variables. Using this family, variational inference is particularly amenable to coordinate-ascent optimization, which iteratively optimizes each factor. (This approach closely connects to the classical Gibbs sampler (Geman and Geman, 1984; Gelfand and Smith, 1990).) We showed how to use mean-field VI to approximate the posterior density of a Bayesian mixture of Gaussians, discussed the special case of exponential families and conditional conjugacy, and described the extension to stochastic variational inference (Hoffman 

22 

**Algorithm 3:** SVI for conditionally conjugate models 

**Input:** Model _p_ ( **x** , **z** ), data **x** , and step size sequence _εt_ 

**Output:** Global variational densities _qλ_ ( _β_ ) **Initialize:** Variational parameters _λ_ 0 

**while** _TRUE_ **do** 

Choose a data point uniformly at random, _t ∼_ Unif(1,..., _n_ ) Optimize its local variational parameters _ϕ[∗] t_[=][ �] _[λ]_[ [] _[η]_[(] _[β]_[,] _[ x][t]_[)]] Compute the coordinate update as though _x t_ was repeated _n_ times, 

**==> picture [101 x 15] intentionally omitted <==**

Update the global variational parameter, _λt_ = (1 _− εt_ ) _λt_ + _εt λ_[ˆ] _t_ 

**end return** _λ_ 

## **5.1 Applications** 

Researchers in many fields have used variational inference to solve real problems. Here we focus on example applications of mean-field variational inference and structured variational inference based on the KL divergence. This discussion is not exhaustive; our intention is to outline the diversity of applications of variational inference. 

**Computational biology.** VI is widely used in computational biology, where probabilistic models provide important building blocks for analyzing genetic data. For example, VI has been used in genome-wide association studies (Carbonetto and Stephens, 2012; Logsdon et al., 2010), regulatory network analysis (Sanguinetti et al., 2006), motif detection (Xing et al., 2004), phylogenetic hidden Markov models (Jojic et al., 2004), population genetics (Raj et al., 2014), and gene expression analysis (Stegle et al., 2010). **Computer vision and robotics.** Since its inception, variational inference has been important to computer vision. Vision researchers frequently analyze large and high-dimensional data sets of images, and fast inference is important to successfully deploy a vision system. Some of the earliest examples included inferring non-linear image manifolds (Bishop and Winn, 2000) and finding layers of images in videos (Jojic and Frey, 2001). As other examples, variational inference is important to probabilistic models of videos (Chan and Vasconcelos, 2009; Wang and Mori, 2009), image denoising (Likas and Galatsanos, 2004), tracking (Vermaak et al., 2003; Yu and Wu, 2005), place recognition and mapping for robotics (Cummins and Newman, 2008; Ramos et al., 2012), and image segmentation with Bayesian nonparametrics (Sudderth and Jordan, 2009). Du et al. (2009) uses variational inference in a probabilistic model to combine the tasks of segmentation, clustering, and annotation. 

**Computational neuroscience.** Modern neuroscience research also requires analyzing very large and high-dimensional data sets, such as high-frequency time series data or high-resolution functional magnetic imaging data. There have been many applications of variational inference to neuroscience, especially for autoregressive processes (Roberts and Penny, 2002; Penny et al., 2003, 2005; Flandin and Penny, 2007; Harrison and Green, 2010). Other applications of variational inference to neuroscience include hierarchical models of multiple subjects (Woolrich et al., 2004), spatial models (Sato et al., 2004; Zumer et al., 

23 

2007; Kiebel et al., 2008; Wipf and Nagarajan, 2009; Lashkari et al., 2012; Nathoo et al., 2014), brain-computer interfaces (Sykacek et al., 2004), and factor models (Manning et al., 2014; Gershman et al., 2014). There is a software toolbox that uses variational methods for solving neuroscience and psychology research problems (Daunizeau et al., 2014). 

**Natural language processing and speech recognition.** In natural language processing, variational inference has been used for solving problems such as parsing (Liang et al., 2007, 2009), grammar induction (Kurihara and Sato, 2006; Naseem et al., 2010; Cohen and Smith, 2010), models of streaming text (Yogatama et al., 2014), topic modeling (Blei et al., 2003), and hidden Markov models and part-of-speech tagging (Wang and Blunsom, 2013). In speech recognition, variational inference has been used to fit complex coupled hidden Markov models (Reyes-Gomez et al., 2004) and switching dynamic systems (Deng, 2004). 

**Other applications.** There have been many other applications of variational inference. Fields in which it has been used include marketing (Braun and McAuliffe, 2010), optimal control and reinforcement learning (Van Den Broek et al., 2008; Furmston and Barber, 2010), statistical network analysis (Wiggins and Hofman, 2008; Airoldi et al., 2008), astrophysics (Regier et al., 2015), and the social sciences (Erosheva et al., 2007; Grimmer, 2011). General variational inference algorithms have been developed for a variety of classes of models, including shrinkage models (Armagan et al., 2011; Armagan and Dunson, 2011; Neville et al., 2014), general time-series models (Roberts et al., 2004; Barber and Chiappa, 2006; Archambeau et al., 2007b,a; Johnson and Willsky, 2014; Foti et al., 2014), robust models (Tipping and Lawrence, 2005; Wang and Blei, 2015), and Gaussian process models (Titsias and Lawrence, 2010; Damianou et al., 2011; Hensman et al., 2014). 

## **5.2 Theory** 

Though researchers have not developed much theory around variational inference, there are several threads of research about theoretical guarantees of variational approximations. As we mentioned in the introduction, one of our purposes for writing this paper is to catalyze research on the statistical theory around variational inference. 

Below, we summarize a variety of results. In general, they are all of the following type: treat VI posterior means as point estimates (or use M-step estimates from variational EM) and confirm that they have the usual frequentist asymptotics. (Sometimes the research finds that they do not enjoy the same asymptotics.) Each result revolves around a single model and a single family of variational approximations. 

You et al. (2014) study the variational posterior for a classical Bayesian linear model. They put a normal prior on the coefficients and an inverse gamma prior on the response variance. They find that, under standard regularity conditions, the mean-field variational posterior mean of the parameters are consistent in the frequentist sense. Ormerod et al. (2014) build on their earlier work with a spike-and-slab prior on the coefficients and find similar consistency results. 

Hall et al. (2011a,b) examine a simple Poisson mixed-effects model, one with a single predictor and a random intercept. They use a Gaussian variational approximation and estimate parameters with variational EM. They prove consistency of these estimates at the parametric rate and show asymptotic normality with asymptotically valid standard errors. 

Celisse et al. (2012) and Bickel et al. (2013) analyze network data using stochastic blockmodels. They show asymptotic normality of parameter estimates obtained using a mean-field variational approximation. They highlight the computational advantages and theoretical 

24 

guarantees of the variational approach over maximum likelihood for dense, sparse, and restricted variants of the stochastic blockmodel. 

Westling and McCormick (2015) study the consistency of VI through a connection to M- estimation. They focus on a broader class of models (with posterior support in real coordinate space) and analyze an automated VI technique that uses a Gaussian variational approximation (Kucukelbir et al., 2015). They derive an asymptotic covariance matrix estimator of the variational approximation and show its robustness to model misspecification. 

Finally, Wang and Titterington (2006) analyze variational approximations to mixtures of Gaussians. Specifically, they consider Bayesian mixtures with conjugate priors, the meanfield variational approximation, and an estimator that is the variational posterior mean. They confirm that CAVI converges to a local optimum, that the VI estimator is consistent, and that the VI estimate and maximum likelihood estimate (MLE) approach each other at a rate of _�_ ([1] _/n_ ). In Wang and Titterington (2005), they show that the asymptotic variational posterior covariance matrix is “too small”—it differs from the MLE covariance (i.e., the inverse Fisher information) by a positive-definite matrix. 

## **5.3 Beyond conditional conjugacy** 

We focused on models where the complete conditional is in the exponential family. Many models, however, do not enjoy this property. A simple example is Bayesian logistic regression, 

**==> picture [111 x 27] intentionally omitted <==**

where _σ_ ( _·_ ) is the logistic function. The posterior density of the coefficients is not in an exponential family and we cannot apply the variational inference methods we discussed above. Specifically, we cannot compute the expectations in the first term of the ELBO in Equation (13) or the coordinate update in Equation (18). 

Exploring variational methods for such models has been a fruitful area of research. An early example is Jaakkola and Jordan (1997, 2000), who developed a variational bound tailored to logistic regression. Blei and Lafferty (2007) later adapted their idea to nonconjugate topic models, and researchers have continued to improve the original bound (Khan et al., 2010; Marlin et al., 2011; Ermis and Bouchard, 2014). In other work, Braun and McAuliffe (2010) derived a variational inference algorithm for the discrete choice model, which also lies outside of the class of conditionally conjugate models. They developed a delta method to approximate the difficult-to-compute expectations. Finally, Wand et al. (2011) use auxiliary variable methods, quadrature, and mixture approximations to handle a variety of likelihood terms that fall outside of the exponential family. 

More recently, researchers have generalized nonconjugate inference, seeking recipes that can be used across many models. Wang and Blei (2013) adapted Laplace approximations and the delta method to this end, improving inference in nonconjugate generalized linear models and topic models; this approach is also used by Bugbee et al. (2016) for semiparametric regression. Knowles and Minka (2011) generalized the Jaakkola and Jordan (1997, 2000) bound in a message-passing algorithm and Wand (2014) further simplified and extended their approach. Tan and Nott (2013, 2014) applied these message-passing methods to generalized linear mixed models (and also combined them with SVI). Rohde and Wand (2015) unified many of these algorithmic developments and provided practical insights into their numerical implementations. 

Finally, there has been a flurry of research on optimizing difficult variational objectives with Monte Carlo (MC) estimates of the gradient. The idea is to write the gradient of the 

25 

ELBO as an expectation, compute MC estimates of it, and then use stochastic optimization with repeated MC gradients. This first appeared independently in several papers (Ji et al., 2010; Nott et al., 2012; Paisley et al., 2012; Wingate and Weber, 2013). The newest approaches avoid any model-specific derivations, and are termed “black box” inference methods. As examples, see Kingma and Welling (2014); Rezende et al. (2014); Ranganath et al. (2014, 2016); Salimans and Knowles (2014); Titsias and Lázaro-Gredilla (2014), and Tran et al. (2016). Kucukelbir et al. (2016) leverage these ideas toward an automatic VI technique that works on any model written in the probabilistic programming system Stan (Stan Development Team, 2015). This is a step towards a derivation-free, easy-to-use VI algorithm. 

## **5.4 Open problems** 

There are many open avenues for statistical research in variational inference. 

We focused on optimizing KL ( _q_ ( **z** ) _||p_ ( **z** _|_ **x** )) as the variational objective function. A promising avenue of research is to develop variational inference methods that optimize other measures, such as _α_ -divergence measures. As one example, expectation propagation (Minka, 2001) is inspired by the KL divergence “in the other direction,” between _p_ ( **z** _|_ **x** ) and _q_ ( **z** ). Other work has developed divergences based on lower bounds that are tighter than the ELBO (Barber and de van Laar, 1999; Leisink and Kappen, 2001). While alternative divergences may be difficult to optimize, they may give better approximations (Minka, 2005; Opper and Winther, 2005). 

Though it is flexible, the mean-field family makes strong independence assumptions. These assumptions help with scalable optimization, but they limit the expressibility of the variational family. Further, they can exacerbate issues with local optima of the objective and underestimating posterior variances; see Figure 1. A second avenue of research is to develop better approximations while maintaining efficient optimization. 

As we mentioned above, structured variational inference has its roots in the early days of the method (Saul and Jordan, 1996; Barber and Wiegerinck, 1999). More recently, Hoffman and Blei (2015) use generic structured variational inference in a stochastic optimization algorithm; Kucukelbir et al. (2016), Challis and Barber (2013), and Tan and Nott (2016) take advantage of Gaussian variational families with non-diagonal covariance; Giordano et al. (2015) post-process the mean-field parameters to correct for underestimating the variance; and Ranganath et al. (2016) embed the mean-field parameters themselves in a hierarchical model to induce variational dependencies between latent variables. 

The interface between variational inference and MCMC remains relatively unexplored. Freitas et al. (2001) used fitted variational distributions as a component of a proposal distribution for Metropolis-Hastings. Mimno et al. (2012) and Hoffman and Blei (2015) studied MCMC as a method of approximating coordinate updates, e.g., to include structure in the variational family. Salimans et al. (2015) propose a variational approximation to the MCMC chain; their method enables an explicit trade off between computational accuracy and speed. Understanding how to combine these two strategies for approximate inference is a ripe area for future research. A principled analysis of when to use (and combine) variational inference and MCMC would have both theoretical and practical impact in the field. 

Finally, the statistical properties of variational inference are not yet well understood, especially in contrast to the wealth of analysis of MCMC techniques. There has been some progress; see Section 5.2. A final open research problem is to understand variational inference as an estimator and to understand its statistical profile relative to the exact posterior. 

26 

## **A Bayesian Linear Regression with Automatic Relevance Determination** 

Consider a dataset of **y** = _y_ 1: _n ∈_ � _[n]_ outputs and **x** = _x_ 1: _n ∈_ �[(] _[n][×][D]_[)] _D_ -dimensional inputs, where each _xi ∈_ � _[D]_ . 

A linear regression model assumes a linear relationship between the inputs and the conditional mean of the output given the inputs. The latent variable _β ∈_ � _[D]_ is a vector of the regression coefficients. 

Automatic relevance determination (ARD) assigns a separate prior for each regression coefficient; the idea is to automatically shrink irrelevant coefficients during inference (MacKay, 1992; Neal, 2012; Tipping, 2001; Wipf and Nagarajan, 2008). ARD works by pairing the prior precision of each regression coefficient with its own latent variable _αd_ . The hyper-prior on these relevance variables _α_ encourages small values; this, in turn, selects relevant regression coefficients. 

Here we present a conditionally conjugate Bayesian linear regression model with an ARD prior, based on Drugowitsch (2013). All Gaussian distributions below follow the precision parameterization. 

Define a Gaussian likelihood with precision parameter _τ_ as 

**==> picture [152 x 28] intentionally omitted <==**

ARD then posits the following hierarchical prior 

**==> picture [205 x 10] intentionally omitted <==**

where _α_ is a _D_ -dimensional relevance variable 

**==> picture [117 x 29] intentionally omitted <==**

Here _a_ 0, _b_ 0, _c_ 0, and _d_ 0 are fixed hyper-parameters. The latent variable _α_ determines the relevance of each regression coefficient. 

The posterior _p_ ( _β_ , _τ_ , _α |_ **y** ; **x** ) is not available in closed form. A simpler model that does not include _α_ admits a closed form posterior because the normal-gamma distribution is conjugate to a normal likelihood with unknown mean and precision. 

We derive a CAVI algorithm for this model. First, factorize the variational approximation as 

**==> picture [104 x 11] intentionally omitted <==**

Here we consider _β_ and _τ_ in a single factor. 

Begin by applying Equation (18) to identify the optimal form of _q_ ( _β_ , _τ_ ) as 

log _q_ ( _β_ , _τ_ ) = log _p_ ( **y** _| β_ , _τ_ ; **x** ) + � _α_ [log _p_ ( _β_ , _τ | α_ )] + const. 

**==> picture [290 x 88] intentionally omitted <==**

27 

The optimal variational approximation to the regression coefficients and the precision is thus a normal-gamma with the following parameters: 

**==> picture [150 x 105] intentionally omitted <==**

Next consider the optimal form of the relevance variables _α_ . Again, apply Equation (18) to _D_ identify the optimal form of _q_ ( _α_ ) = � _d_ =1 _[q]_[(] _[α][d]_[)][ as] 

**==> picture [274 x 53] intentionally omitted <==**

The optimal variational approximation to the relevance variable is thus a Gamma with the following parameters: 

**==> picture [99 x 46] intentionally omitted <==**

Finally, compute the expectations as 

**==> picture [130 x 28] intentionally omitted <==**

where [ _·_ ] _d_ indicates the _d_ th diagonal entry of a matrix. 

Iteratively updating _a∗_ , _b∗_ , _c∗_ , _d∗_ , _V∗[−]_[1] , and _β∗_ defines CAVI for this model. These quantities also define the ELBO; Drugowitsch (2013) presents the additional algebra that computes the ELBO. 

28 

## **B Gaussian Mixture Model of Image Histograms** 

We present a multivariate ( _D_ -dimensional), diagonal covariance Gaussian mixture model (GMM). Denote a dataset of _n_ observations as **x** = _x_ 1: _n ∈_ �[(] _[n][×][D]_[)] , where each _xi ∈_ � _[D]_ . Assume _K_ mixture components. 

The cluster assignment latent variables are **z** = _z_ 1: _n ∈_ �[(] _[n][×][K]_[)] where each _zi_ is a _K_ -indicator vector. The cluster assignments depend on the mixing vector latent variable _π_ , which lives in a _K_ -simplex. 

The mean latent variables are _**µ**_ = _µ_ 1: _K ∈_ �[(] _[K][×][D]_[)] , where each _µk ∈_ � _[D]_ , and the precision latent variables are _**τ**_ = _τ_ 1: _K ∈_ �[(] _[K][×][D]_[)] , where each _τk ∈_ � _>[D]_ 0[.] 

The joint density of the model factorizes as 

**==> picture [228 x 10] intentionally omitted <==**

The likelihood is Gaussian with precision parameterization 

**==> picture [207 x 31] intentionally omitted <==**

The marginal over cluster assignments is a categorical distribution, 

**==> picture [93 x 29] intentionally omitted <==**

The prior over the mixing vector is a Dirichlet distribution with fixed hyperparameters _a_ 0, 

**==> picture [154 x 30] intentionally omitted <==**

The prior over mean and precision parameters is a normal-gamma distribution with hyperparameters _m_ 0, _b_ 0, _α_ 0, _β_ 0, 

**==> picture [291 x 63] intentionally omitted <==**

We use the following values for the hyperparameters 

**==> picture [270 x 22] intentionally omitted <==**

Bishop (2006, Chapter 10.2) derives a CAVI algorithm for this model. 

Figure 8 presents Stan code that implements this model. Since Stan does not support discrete latent variables, we marginalize over the assignment variables. 

29 

**data** { **int** < lower =0> N; // number of data points in dataset **int** < lower =0> K; // number of mixture components **int** < lower =0> D; // dimension **vector** [D] x [N ] ; // observations } **transformed data** { **vector** < lower =0>[K] alpha0_vec ; **f o r** (k **in** 1:K) { // convert the s c a l a r d i r i c h l e t p r i o r 1/K alpha0_vec [ k ] < - 1.0/K; // to a vector } } **parameters** { simplex [K] theta ; // mixing proportions **vector** [D] mu[K] ; // l o c a t i o n s of mixture components **vector** < lower =0>[D] sigma [K] ; // standard d e v i a t i o n s of mixture components } **model** { // p r i o r s theta ~ d i r i c h l e t ( alpha0_vec ) ; **f o r** (k **in** 1:K) { mu[ k ] ~ normal ( 0 . 0 , 1.0/ sigma [ k ] ) ; sigma [ k ] ~ inv_gamma ( 1 . 0 , 1 . 0 ) ; } // l i k e l i h o o d **f o r** (n **in** 1:N) { **r e a l** ps [K] ; **f o r** (k **in** 1:K) { ps [ k ] < - log ( theta [ k ] ) + normal_log (x [ n ] , mu[ k ] , sigma [ k ] ) ; } increment_log_prob ( log_sum_exp ( ps ) ) ; } } 

**Figure 8:** Stan code for the GMM of image histograms. 

30 

## **C Latent Dirichlet Allocation** 

Probabilistic topic models are mixed-membership models of text, used to uncover the latent “topics” that run through a collection of documents. Topic models have become a popular technique for exploratory data analysis of large collections (Blei, 2012). 

Latent Dirichlet allocation (LDA) (Blei et al., 2003) is a conditionally conjugate topic model (Section 4.2). It treats documents as containing multiple topics, where a topic is a distribution over words in a vocabulary. 

Following the notation of Hoffman et al. (2013), let _K_ be a specific number of topics and _V_ the size of the vocabulary. LDA defines the following generative process: 

1. For each topic in _k_ = 1,..., _K_ , 

   - (a) draw a distribution over words _βk ∼_ Dir _V_ ( _η_ ). 

2. For each document in _d_ = 1,..., _D_ , 

   - (a) draw a vector of topic proportions _θd ∼_ Dir _K_ ( _α_ ). 

   - (b) For each word in _n_ = 1,..., _N_ , 

      - i. draw a topic assignment _zdn ∼_ Mult( _θd_ ), then 

      - ii. draw a word _wdn ∼_ Mult( _βzdn_ ). 

Here _η ∈_ � _>_ 0 is a fixed parameter of the symmetric Dirichlet prior on the topics _β_ , and _α ∈_ � _[K]_[fixed][parameters][of][the][Dirichlet][prior][on][the][topic][proportions][for][each] _>_ 0[are] document. Similar to the GMM example in Section 3, we encode categorical variables as indicator vectors. Thus _zdn_ is a _K_ -vector where _zdn[k]_[=][ 1 indicates the] _[n]_[th word in document] _d_ is assigned to the _k_ th topic. Similarly, _wdn_ is a _V_ -vector where _w[v] dn_[=][ 1 indicates that the] _n_ th word in document _d_ is the _v_ th word in the vocabulary. We occasionally abuse these indicator vectors as indices—for example, if _zdn[k]_[=][ 1, then] _[ β][z] dn_[is the] _[k]_[th topic, denoted by] _βk_ . 

The posterior _p_ ( _β_ , _θ_ , _z | w_ ) is not available in closed form. While the topic assignments _z_ and their proportions _θ_ enjoy a conjugate relationship, the introduction of the topics _β_ renders this posterior analytically intractable. 

We derive a CAVI algorithm for this model, based on Hoffman et al. (2013). Posit a mean-field variational family 

**==> picture [252 x 30] intentionally omitted <==**

Since LDA is a conditionally conjugate model, we can directly identify the family of each factor (Section 4.2). 

Begin with the complete conditional of the topic assignment. This is a multinomial, 

**==> picture [212 x 14] intentionally omitted <==**

The variational approximation to the topic assignments is also a multinomial distribution, with parameters _φdn_ . 

Follow with the complete conditional of the topic proportions. This is a _K_ -dimensional Dirichlet 

**==> picture [132 x 30] intentionally omitted <==**

31 

The variational approximation to the topic proportions is also a _K_ -dimensional Dirichlet with parameters _γd_ . 

End with the complete conditional of the topics. This is a _V_ -dimensional Dirichlet 

**==> picture [171 x 30] intentionally omitted <==**

In words, the _v_ th element of the _k_ th topic is a Dirichlet with parameter equal to the sum of the fixed scalar _η_ and the number of times term _v_ (denoted by _wdn_ ) was assigned to topic _k_ (denoted by _zdn[k]_[).][The variational approximation to the topic proportions is a] _[ V]_[-dimensional] Dirichlet with parameters _λk_ . 

The CAVI updates for the topic assignment and topic proportions require iterating over the following for each word within each document until convergence: 

**==> picture [288 x 78] intentionally omitted <==**

This is a direct application of Equation (47) to the complete conditionals above. 

The updates for _φ_ and _γ_ depend on the variational parameters for the topics _λ_ . The update for the topics, in turn, depends on the variational parameters for the topic proportions. That update is 

**==> picture [240 x 30] intentionally omitted <==**

This update only depends on the variational parameter for the topic assignments _φdn_ . 

Algorithm 4 presents the full CAVI algorithm for LDA. A similar computation defines the ELBO for LDA; Hoffman et al. (2013) present the additional algebra for the ELBO. 

## **Algorithm 4:** CAVI for LDA 

**Input:** LDA model and a set of words in documents _w_ . **Output:** Variational parameters _λ_ , _γ_ , _φ_ . **Initialize:** Variational parameters _λ_ , _γ_ randomly. 

**while** _the_ ELBO _has not converged_ **do** 

## **repeat** 

**for** _each document d_ **do for** _each word n_ **do** Compute updates to _φ_ and _γ_ via Equations (59) and (60). 

**end** 

## **end** 

**until** _φ and γ have converged_ ; Compute update to _λ_ via Equation (61). 

**end** 

32 

## **References** 

- Ahmed, A., Aly, M., Gonzalez, J., Narayanamurthy, S., and Smola, A. (2012). Scalable inference in latent variable models. In _International Conference on Web Search and Data Mining_ . 

- Airoldi, E., Blei, D., Fienberg, S., and Xing, E. (2008). Mixed membership stochastic blockmodels. _Journal of Machine Learning Research_ , 9:1981–2014. 

- Amari, S. (1982). Differential geometry of curved exponential families-curvatures and information loss. _The Annals of Statistics_ , 10(2):357–385. 

- Amari, S. (1998). Natural gradient works efficiently in learning. _Neural Computation_ , 10(2):251–276. 

- Archambeau, C., Cornford, D., Opper, M., and Shawe-Taylor, J. (2007a). Gaussian process approximations of stochastic differential equations. _Workshop on Gaussian Processes in Practice_ , 1:1–16. 

- Archambeau, C., Opper, M., Shen, Y., Cornford, D., and Shawe-Taylor, J. (2007b). Variational inference for diffusion processes. In _Neural Information Processing Systems_ . 

- Armagan, A., Clyde, M., and Dunson, D. (2011). Generalized beta mixtures of Gaussians. In _Neural Information Processing Systems_ . 

- Armagan, A. and Dunson, D. (2011). Sparse variational analysis of linear mixed models for large data sets. _Statistics & Probability Letters_ , 81(8):1056–1062. 

- Barber, D. (2012). _Bayesian Reasoning and Machine Learning_ . Cambridge University Press. 

- Barber, D. and Chiappa, S. (2006). Unified inference for variational Bayesian linear Gaussian state-space models. In _Neural Information Processing Systems_ . 

- Barber, D. and de van Laar, P. (1999). Variational cumulant expansions for intractable distributions. _Journal of Artificial Intelligence Research_ , pages 435–455. 

- Barber, D. and Wiegerinck, W. (1999). Tractable variational structures for approximating graphical models. In _Neural Information Processing Systems_ . 

- Beal, M. and Ghahramani, Z. (2003). The variational Bayesian EM algorithm for incomplete data: With application to scoring graphical model structures. In Bernardo, J., Bayarri, M., Berger, J., Dawid, A., Heckerman, D., Smith, A., and West, M., editors, _Bayesian Statistics 7_ . Oxford University Press. 

- Bernardo, J. and Smith, A. (1994). _Bayesian Theory_ . John Wiley & Sons Ltd., Chichester. 

- Bickel, P., Choi, D., Chang, X., Zhang, H., et al. (2013). Asymptotic normality of maximum likelihood and its variational approximation for stochastic blockmodels. _The Annals of Statistics_ , 41(4):1922–1943. 

- Bishop, C. (2006). _Pattern Recognition and Machine Learning_ . Springer New York. 

- Bishop, C., Lawrence, N., Jaakkola, T., and Jordan, M. I. (1998). Approximating posterior distributions in belief networks using mixtures. In _Neural Information Processing Systems_ . 

- Bishop, C. and Winn, J. (2000). Non-linear Bayesian image modelling. In _European Conference on Computer Vision_ . 

- Blei, D. (2012). Probabilistic topic models. _Communications of the ACM_ , 55(4):77–84. 

- Blei, D. and Jordan, M. I. (2006). Variational inference for Dirichlet process mixtures. _Journal of Bayesian Analysis_ , 1(1):121–144. 

33 

- Blei, D. and Lafferty, J. (2007). A correlated topic model of Science. _Annals of Applied Statistics_ , 1(1):17–35. 

- Blei, D., Ng, A., and Jordan, M. I. (2003). Latent Dirichlet allocation. _Journal of Machine Learning Research_ , 3:993–1022. 

- Braun, M. and McAuliffe, J. (2010). Variational inference for large-scale models of discrete choice. _Journal of the American Statistical Association_ , 105(489):324–335. 

- Brown, L. (1986). _Fundamentals of Statistical Exponential Families_ . Institute of Mathematical Statistics, Hayward, CA. 

- Bugbee, B., Breidt, F., and van der Woerd, M. (2016). Laplace variational approximation for semiparametric regression in the presence of heteroscedastic errors. _Journal of Computational and Graphical Statistics_ , 25:225–245. 

- Carbonetto, P. and Stephens, M. (2012). Scalable variational inference for Bayesian variable selection in regression, and its accuracy in genetic association studies. _Bayesian Analysis_ , 7(1):73–108. 

- Celisse, A., Daudin, J.-J., Pierre, L., et al. (2012). Consistency of maximum-likelihood and variational estimators in the stochastic block model. _Electronic Journal of Statistics_ , 6:1847–1899. 

- Challis, E. and Barber, D. (2013). Gaussian Kullback-Leibler approximate inference. _The Journal of Machine Learning Research_ , 14(1):2239–2286. 

- Chan, A. and Vasconcelos, N. (2009). Layered dynamic textures. _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 31(10):1862–1879. 

- Cohen, S. and Smith, N. (2010). Covariance in unsupervised learning of probabilistic grammars. _The Journal of Machine Learning Research_ , 11:3017–3051. 

- Cummins, M. and Newman, P. (2008). FAB-MAP: Probabilistic localization and mapping in the space of appearance. _The International Journal of Robotics Research_ , 27(6):647–665. 

- Damianou, A., Titsias, M., and Lawrence, N. (2011). Variational Gaussian process dynamical systems. In _Neural Information Processing Systems_ . 

- Daunizeau, J., Adam, V., and Rigoux, L. (2014). VBA: A probabilistic treatment of nonlinear models for neurobiological and behavioural data. _PLoS Comput Biol_ , 10(1):e1003441. 

- Dempster, A., Laird, N., and Rubin, D. (1977). Maximum likelihood from incomplete data via the EM algorithm. _Journal of the Royal Statistical Society, Series B_ , 39:1–38. 

- Deng, L. (2004). Switching dynamic system models for speech articulation and acoustics. In _Mathematical Foundations of Speech and Language Processing_ , pages 115–133. Springer. 

- Diaconis, P., Ylvisaker, D., et al. (1979). Conjugate priors for exponential families. _The Annals of Statistics_ , 7(2):269–281. 

- Drugowitsch, J. (2013). Variational Bayesian inference for linear and logistic regression. _arXiv preprint arXiv:1310.5438_ . 

- Du, L., Lu, R., Carin, L., and Dunson, D. (2009). A Bayesian model for simultaneous image clustering, annotation and object segmentation. In _Neural Information Processing Systems_ . 

- Ermis, B. and Bouchard, G. (2014). Iterative splits of quadratic bounds for scalable binary tensor factorization. In _Uncertainty in Artificial Intelligence_ . 

- Erosheva, E. A., Fienberg, S. E., and Joutard, C. (2007). Describing disability through individual-level mixture models for multivariate binary data. _The Annals of Applied Statistics_ , 1(2):346–384. 

34 

- Flandin, G. and Penny, W. (2007). Bayesian fMRI data analysis with sparse spatial basis function priors. _NeuroImage_ , 34(3):1108–1125. 

- Foti, N., Xu, J., Laird, D., and Fox, E. (2014). Stochastic variational inference for hidden Markov models. In _Neural Information Processing Systems_ . 

- Freitas, N. D., Højen-Sørensen, P., Jordan, M., and Russell, S. (2001). Variational MCMC. In _Uncertainty in Artificial Intelligence_ . 

- Furmston, T. and Barber, D. (2010). Variational methods for reinforcement learning. In _Artificial Intelligence and Statistics_ . 

- Gelfand, A. and Smith, A. (1990). Sampling based approaches to calculating marginal densities. _Journal of the American Statistical Association_ , 85:398–409. 

- Geman, S. and Geman, D. (1984). Stochastic relaxation, Gibbs distributions and the Bayesian restoration of images. _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 6:721–741. 

- Gershman, S. J., Blei, D. M., Norman, K. A., and Sederberg, P. B. (2014). Decomposing spatiotemporal brain patterns into topographic latent sources. _NeuroImage_ , 98:91–102. 

- Ghahramani, Z. and Jordan, M. I. (1997). Factorial hidden Markov models. _Machine Learning_ , 29(2-3):245–273. 

- Giordano, R. J., Broderick, T., and Jordan, M. I. (2015). Linear response methods for accurate covariance estimates from mean field variational Bayes. In _Neural Information Processing Systems_ . 

- Grimmer, J. (2011). An introduction to Bayesian inference via variational approximations. _Political Analysis_ , 19(1):32–47. 

- Hall, P., Ormerod, J., and Wand, M. (2011a). Theory of Gaussian variational approximation for a Poisson mixed model. _Statistica Sinica_ , 21:369–389. 

- Hall, P., Pham, T., Wand, M., and Wang, S. (2011b). Asymptotic normality and valid inference for Gaussian variational approximation. _Annals of Statistics_ , 39(5):2502–2532. 

- Harrison, L. and Green, G. (2010). A Bayesian spatiotemporal model for very large data sets. _Neuroimage_ , 50(3):1126–1141. 

- Hastings, W. (1970). Monte Carlo sampling methods using Markov chains and their applications. _Biometrika_ , 57:97–109. 

- Hensman, J., Fusi, N., and Lawrence, N. (2014). Gaussian processes for big data. In _Uncertainty in Artificial Intelligence_ . 

- Hensman, J., Rattray, M., and Lawrence, N. (2012). Fast variational inference in the conjugate exponential family. In _Neural Information Processing Systems_ . 

- Hinton, G. and Van Camp, D. (1993). Keeping the neural networks simple by minimizing the description length of the weights. In _Computational Learning Theory_ . 

- Hoffman, M. D., Blei, D., Wang, C., and Paisley, J. (2013). Stochastic variational inference. _Journal of Machine Learning Research_ , 14:1303–1347. 

- Hoffman, M. D. and Blei, D. M. (2015). Structured stochastic variational inference. In _Artificial Intelligence and Statistics_ . 

- Hoffman, M. D. and Gelman, A. (2014). The No-U-turn sampler: Adaptively setting path lengths in Hamiltonian Monte Carlo. _The Journal of Machine Learning Research_ , 15(1):1593–1623. 

35 

- Honkela, A., Tornio, M., Raiko, T., and Karhunen, J. (2008). Natural conjugate gradient in variational inference. In _Neural Information Processing_ , pages 305–314. Springer. 

- Jaakkola, T. and Jordan, M. I. (1996). Computing upper and lower bounds on likelihoods in intractable networks. In _Uncertainty in Artificial Intelligence_ . 

- Jaakkola, T. and Jordan, M. I. (1997). A variational approach to Bayesian logistic regression models and their extensions. In _Artificial Intelligence and Statistics_ . 

- Jaakkola, T. and Jordan, M. I. (2000). Bayesian parameter estimation via variational methods. _Statistics and Computing_ , 10(1):25–37. 

- Ji, C., Shen, H., and West, M. (2010). Bounded approximations for marginal likelihoods. Technical report, Duke University. 

- Johnson, M. and Willsky, A. (2014). Stochastic variational inference for Bayesian time series models. In _International Conference on Machine Learning_ . 

- Jojic, N. and Frey, B. (2001). Learning flexible sprites in video layers. In _Computer Vision and Pattern Recognition_ . 

- Jojic, V., Jojic, N., Meek, C., Geiger, D., Siepel, A., Haussler, D., and Heckerman, D. (2004). Efficient approximations for learning phylogenetic HMM models from data. _Bioinformatics_ , 20:161–168. 

- Jordan, M. I., Ghahramani, Z., Jaakkola, T., and Saul, L. (1999). Introduction to variational methods for graphical models. _Machine Learning_ , 37:183–233. 

- Khan, M. E., Bouchard, G., Murphy, K. P., and Marlin, B. M. (2010). Variational bounds for mixed-data factor analysis. In _Neural Information Processing Systems_ . 

- Kiebel, S., Daunizeau, J., Phillips, C., and Friston, K. (2008). Variational Bayesian inversion of the equivalent current dipole model in EEG/MEG. _NeuroImage_ , 39(2):728–741. 

- Kingma, D. and Welling, M. (2014). Auto-encoding variational Bayes. In _International Conference on Learning Representations_ . 

- Knowles, D. and Minka, T. (2011). Non-conjugate variational message passing for multinomial and binary regression. In _Neural Information Processing Systems_ . 

- Kucukelbir, A., Ranganath, R., Gelman, A., and Blei, D. (2015). Automatic variational inference in Stan. In _Neural Information Processing Systems_ . 

- Kucukelbir, A., Tran, D., Ranganath, R., Gelman, A., and Blei, D. M. (2016). Automatic differentiation variational inference. _arXiv preprint arXiv:1603.00788_ . 

- Kullback, S. and Leibler, R. (1951). On information and sufficiency. _The Annals of Mathematical Statistics_ , 22(1):79–86. 

- Kurihara, K. and Sato, T. (2006). Variational Bayesian grammar induction for natural language. In _Grammatical Inference: Algorithms and Applications_ , pages 84–96. Springer. 

- Kushner, H. and Yin, G. (1997). _Stochastic Approximation Algorithms and Applications_ . Springer New York. 

- Lashkari, D., Sridharan, R., Vul, E., Hsieh, P., Kanwisher, N., and Golland, P. (2012). Search for patterns of functional specificity in the brain: A nonparametric hierarchical Bayesian model for group fMRI data. _Neuroimage_ , 59(2):1348–1368. 

- Lauritzen, S. and Spiegelhalter, D. (1988). Local computations with probabilities on graphical structures and their application to expert systems. _Journal of the Royal Statistical Society. Series B_ , pages 157–224. 

36 

- Le Cun, Y. and Bottou, L. (2004). Large scale online learning. In _Neural Information Processing Systems_ . 

- Leisink, M. and Kappen, H. (2001). A tighter bound for graphical models. _Neural Computation_ , 13(9):2149–2171. 

- Liang, P., Jordan, M. I., and Klein, D. (2009). Probabilistic grammars and hierarchical Dirichlet processes. In O’Hagan, T. and West, M., editors, _The Handbook of Applied Bayesian Analysis_ . New York: Oxford Univ. Press. 

- Liang, P., Petrov, S., Klein, D., and Jordan, M. I. (2007). The infinite PCFG using hierarchical Dirichlet processes. In _Empirical Methods in Natural Language Processing_ . 

- Likas, A. and Galatsanos, N. (2004). A variational approach for Bayesian blind image deconvolution. _IEEE Transactions on Signal Processing_ , 52(8):2222–2233. 

- Logsdon, B., Hoffman, G., and Mezey, J. (2010). A variational Bayes algorithm for fast and accurate multiple locus genome-wide association analysis. _BMC Bioinformatics_ , 11(1):58. 

- MacKay, D. J. (1992). Bayesian interpolation. _Neural Computation_ , 4(3):415–447. 

- MacKay, D. J. (1997). Ensemble learning for hidden Markov models. Unpublished manuscript from http://www.inference.eng.cam.ac.uk/mackay/ensemblePaper.pdf. 

- Manning, J. R., Ranganath, R., Norman, K. A., and Blei, D. M. (2014). Topographic factor analysis: a Bayesian model for inferring brain networks from neural data. _PloS one_ , 9(5):e94914. 

- Marlin, B. M., Khan, M. E., and Murphy, K. P. (2011). Piecewise bounds for estimating Bernoulli-logistic latent Gaussian models. In _International Conference on Machine Learning_ . 

- McGrory, C. A. and Titterington, D. M. (2007). Variational approximations in Bayesian model selection for finite mixture distributions. _Computational Statistics and Data Analysis_ , 51(11):5352–5367. 

- Metropolis, N., Rosenbluth, A., Rosenbluth, M., Teller, M., and Teller, E. (1953). Equations of state calculations by fast computing machines. _Journal of Chemical Physics_ , 21:1087–1092. 

- Mimno, D., Hoffman, M., and Blei, D. (2012). Sparse stochastic inference for latent Dirichlet allocation. In _International Conference on Machine Learning_ . 

- Minka, T. (2005). Divergence measures and message passing. Technical Report TR-2005-173, Microsoft Research. 

- Minka, T., Winn, J., Guiver, J., Webster, S., Zaykov, Y., Yangel, B., Spengler, A., and Bronskill, J. (2014). Infer.NET 2.6. 

- Minka, T. P. (2001). Expectation propagation for approximate Bayesian inference. In _Uncertainty in Artificial Intelligence_ . 

- Naseem, T., Chen, H., Barzilay, R., and Johnson, M. (2010). Using universal linguistic knowledge to guide grammar induction. In _Empirical Methods in Natural Language Processing_ . 

- Nathoo, F., Babul, A., Moiseev, A., Virji-Babul, N., and Beg, M. (2014). A variational Bayes spatiotemporal model for electromagnetic brain mapping. _Biometrics_ , 70(1):132–143. 

- Neal, R. and Hinton, G. (1999). A view of the EM algorithm that justifies incremental, sparse, and other variants. In _Learning in Graphical Models_ , pages 355–368. MIT Press. 

- Neal, R. M. (2012). _Bayesian Learning for Neural Networks_ . Springer Science & Business Media. 

37 

- Neville, S., Ormerod, J., and Wand, M. (2014). Mean field variational Bayes for continuous sparse signal shrinkage: pitfalls and remedies. _Electronic Journal of Statistics_ , 8(1):1113– 1151. 

- Nott, D. J., Tan, S. L., Villani, M., and Kohn, R. (2012). Regression density estimation with variational methods and stochastic approximation. _Journal of Computational and Graphical Statistics_ , 21(3):797–820. 

- Opper, M. and Winther, O. (2005). Expectation consistent approximate inference. _The Journal of Machine Learning Research_ , 6:2177–2204. 

- Ormerod, J., You, C., and Muller, S. (2014). A variational Bayes approach to variable selection. Unpublished manuscript from http://www.maths.usyd.edu.au/u/jormerod/JTOpapers/VariableSelectionFinal.pdf. 

- Paisley, J., Blei, D., and Jordan, M. I. (2012). Variational Bayesian inference with stochastic search. In _International Conference on Machine Learning_ . 

- Parisi, G. (1988). _Statistical Field Theory_ . Addison-Wesley. 

- Pearl, J. (1988). _Probabilistic Reasoning in Intelligent Systems: Networks of Plausible Inference_ . Morgan Kaufmann. 

- Penny, W., Kiebel, S., and Friston, K. (2003). Variational Bayesian inference for fMRI time series. _NeuroImage_ , 19(3):727–741. 

- Penny, W., Trujillo-Barreto, N., and Friston, K. (2005). Bayesian fMRI time series analysis with spatial priors. _Neuroimage_ , 24:350–362. 

- Peterson, C. and Anderson, J. (1987). A mean field theory learning algorithm for neural networks. _Complex Systems_ , 1(5):995–1019. 

- Raj, A., Stephens, M., and Pritchard, J. (2014). fastSTRUCTURE: Variational inference of population structure in large SNP data sets. _Genetics_ , 197(2):573–589. 

- Ramos, F., Upcroft, B., Kumar, S., and Durrant-Whyte, H. (2012). A Bayesian approach for place recognition. _Robotics and Autonomous Systems_ , 60(4):487–497. 

- Ranganath, R., Gerrish, S., and Blei, D. (2014). Black box variational inference. In _Artificial Intelligence and Statistics_ . 

- Ranganath, R., Tran, D., and Blei, D. (2016). Hierarchical variational models. In _International Conference on Machine Learning_ . 

- Regier, J., Miller, A., McAuliffe, J., Adams, R., Hoffman, M., Lang, D., Schlegel, D., and Prabhat (2015). Celeste: Variational inference for a generative model of astronomical images. In _International Conference on Machine Learning_ . 

- Reyes-Gomez, M., Ellis, D., and Jojic, N. (2004). Multiband audio modeling for singlechannel acoustic source separation. In _Acoustics, Speech, and Signal Processing_ . 

- Rezende, D. J., Mohamed, S., and Wierstra, D. (2014). Stochastic backpropagation and approximate inference in deep generative models. In _International Conference on Machine Learning_ . 

- Robbins, H. and Monro, S. (1951). A stochastic approximation method. _The Annals of Mathematical Statistics_ , 22(3):400–407. 

- Robert, C. and Casella, G. (2004). _Monte Carlo Statistical Methods_ . Springer Texts in Statistics. Springer-Verlag, New York, NY. 

38 

- Roberts, S., Guilford, T., Rezek, I., and Biro, D. (2004). Positional entropy during pigeon homing I: Application of Bayesian latent state modelling. _Journal of Theoretical Biology_ , 227:39–50. 

- Roberts, S. and Penny, W. (2002). Variational Bayes for generalized autoregressive models. _IEEE Transactions on Signal Processing_ , 50(9):2245–2257. 

- Rohde, D. and Wand, M. (2015). Semiparametric mean field variational Bayes: General principles and numerical issues. Unpublished manuscript from http://mattwand.utsacademics.info/RohdeWand.pdf. 

- Salimans, T., Kingma, D., and Welling, M. (2015). Markov chain Monte Carlo and variational inference: Bridging the gap. In _International Conference on Machine Learning_ , pages 1218– 1226. 

- Salimans, T. and Knowles, D. (2014). On using control variates with stochastic approximation for variational Bayes. _arXiv preprint arXiv:1401.1022_ . 

- Sanguinetti, G., Lawrence, N., and Rattray, M. (2006). Probabilistic inference of transcription factor concentrations and gene-specific regulatory activities. _Bioinformatics_ , 22(22):2775– 2781. 

- Sato, M. (2001). Online model selection based on the variational Bayes. _Neural Computation_ , 13(7):1649–1681. 

- Sato, M., Yoshioka, T., Kajihara, S., Toyama, K., Goda, N., Doya, K., and Kawato, M. (2004). Hierarchical Bayesian estimation for MEG inverse problem. _NeuroImage_ , 23(3):806–826. 

- Saul, L. and Jordan, M. I. (1996). Exploiting tractable substructures in intractable networks. In _Neural Information Processing Systems_ . 

- Saul, L. K., Jaakkola, T., and Jordan, M. I. (1996). Mean field theory for sigmoid belief networks. _Journal of Artificial Intelligence Research_ , 4(1):61–76. 

- Spall, J. (2003). _Introduction to Stochastic Search and Optimization: Estimation, Simulation, and Control_ . John Wiley and Sons. 

- Stan Development Team (2015). _Stan Modeling Language Users Guide and Reference Manual, Version 2.8.0_ . 

- Stegle, O., Parts, L., Durbin, R., and Winn, J. (2010). A Bayesian framework to account for complex non-genetic factors in gene expression levels greatly increases power in eqtl studies. _PLoS Comput Biol_ , 6(5):e1000770. 

- Sudderth, E. B. and Jordan, M. I. (2009). Shared segmentation of natural scenes using dependent Pitman-Yor processes. In _Neural Information Processing Systems_ . 

- Sung, J., Ghahramani, Z., and Bang, Y. (2008). Latent-space variational Bayes. _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 30(12):2236–2242. 

- Sykacek, P., Roberts, S., and Stokes, M. (2004). Adaptive BCI based on variational Bayesian Kalman filtering: An empirical evaluation. _IEEE Transactions on Biomedical Engineering_ , 51(5):719–727. 

- Tan, L. and Nott, D. (2013). Variational inference for generalized linear mixed models using partially noncentered parametrizations. _Statistical Science_ , 28(2):168–188. 

- Tan, L. and Nott, D. (2014). A stochastic variational framework for fitting and diagnosing generalized linear mixed models. _Bayesian Analysis_ , 9(4):963–1004. 

- Tan, L. and Nott, D. (2016). Gaussian variational approximation with sparse precision matrix. _arXiv:1605.05622_ . 

39 

- Tipping, M. and Lawrence, N. (2005). Variational inference for Student-t models: Robust Bayesian interpolation and generalised component analysis. _Neurocomputing_ , 69(1):123– 141. 

- Tipping, M. E. (2001). Sparse Bayesian learning and the relevance vector machine. _Journal of Machine Learning Research_ , 1(Jun):211–244. 

- Titsias, M. and Lawrence, N. (2010). Bayesian Gaussian process latent variable model. In _Artificial Intelligence and Statistics_ . 

- Titsias, M. and Lázaro-Gredilla, M. (2014). Doubly stochastic variational Bayes for nonconjugate inference. In _International Conference on Machine Learning_ . 

- Tran, D., Ranganath, R., and Blei, D. M. (2016). The variational Gaussian process. In _International Conference on Learning Representations_ . 

- Ueda, N. and Ghahramani, Z. (2002). Bayesian model search for mixture models based on optimizing variational bounds. _Neural Networks_ , 15(10):1223–1241. 

- Van Den Broek, B., Wiegerinck, W., and Kappen, B. (2008). Graphical model inference in optimal control of stochastic multi-agent systems. _Journal of Artificial Intelligence Research_ , 32:95–122. 

- Vermaak, J., Lawrence, N. D., and Pérez, P. (2003). Variational inference for visual tracking. In _Computer Vision and Pattern Recognition_ . 

- Villegas, M., Paredes, R., and Thomee, B. (2013). Overview of the ImageCLEF 2013 Scalable Concept Image Annotation Subtask. In _CLEF Evaluation Labs and Workshop_ . 

- Wainwright, M. J. and Jordan, M. I. (2008). Graphical models, exponential families, and variational inference. _Foundations and Trends in Machine Learning_ , 1(1-2):1–305. 

- Wand, M. (2014). Fully simplified multivariate normal updates in non-conjugate variational message passing. _Journal of Machine Learning Research_ , 15:1351–1369. 

- Wand, M., Ormerod, J., Padoan, S., and Fuhrwirth, R. (2011). Mean field variational Bayes for elaborate distributions. _Bayesian Analysis_ , 6:847–900. 

- Wang, B. and Titterington, D. (2005). Inadequacy of interval estimates corresponding to variational Bayesian approximations. In _Artificial Intelligence and Statistics_ . 

- Wang, B. and Titterington, D. (2006). Convergence properties of a general algorithm for calculating variational Bayesian estimates for a normal mixture model. _Bayesian Analysis_ , 1:625–650. 

- Wang, C. and Blei, D. (2013). Variational inference in nonconjugate models. _Journal of Machine Learning Research_ , 14:1005–1031. 

- Wang, C. and Blei, D. (2015). A general method for robust Bayesian modeling. _arXiv preprint arXiv:1510.05078_ . 

- Wang, P. and Blunsom, P. (2013). Collapsed variational Bayesian inference for hidden Markov models. In _Artificial Intelligence and Statistics_ . 

- Wang, Y. and Mori, G. (2009). Human action recognition by semilatent topic models. _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 31(10):1762–1774. 

- Waterhouse, S., MacKay, D., and Robinson, T. (1996). Bayesian methods for mixtures of experts. _Neural Information Processing Systems_ . 

- Welling, M. and Teh, Y. (2011). Bayesian learning via stochastic gradient Langevin dynamics. In _International Conference on Machine Learning_ . 

40 

- Westling, T. and McCormick, T. H. (2015). Establishing consistency and improving uncertainty estimates of variational inference through M-estimation. _arXiv preprint arXiv:1510.08151_ . 

- Wiggins, C. and Hofman, J. (2008). Bayesian approach to network modularity. _Physical Review Letters_ , 100(25). 

- Wingate, D. and Weber, T. (2013). Automated variational inference in probabilistic programming. _arXiv preprint arXiv:1301.1299_ . 

- Winn, J. and Bishop, C. (2005). Variational message passing. _Journal of Machine Learning Research_ , 6:661–694. 

- Wipf, D. and Nagarajan, S. (2009). A unified Bayesian framework for MEG/EEG source imaging. _NeuroImage_ , 44(3):947–966. 

- Wipf, D. P. and Nagarajan, S. S. (2008). A new view of automatic relevance determination. In _Neural Information Processing Systems_ . 

- Woolrich, M., Behrens, T., Beckmann, C., Jenkinson, M., and Smith, S. (2004). Multilevel linear modeling for fMRI group analysis using Bayesian inference. _Neuroimage_ , 21:1732– 1747. 

- Xing, E., Wu, W., Jordan, M. I., and Karp, R. (2004). Logos: A modular Bayesian model for de novo motif detection. _Journal of Bioinformatics and Computational Biology_ , 2(01):127– 154. 

- Yedidia, J. S., Freeman, W. T., and Weiss, Y. (2001). Generalized belief propagation. In _Neural Information Processing Systems_ . 

- Yogatama, D., Wang, C., Routledge, B., Smith, N. A., and Xing, E. (2014). Dynamic language models for streaming text. _Transactions of the Association for Computational Linguistics_ , 2:181–192. 

- You, C., Ormerod, J., and Muller, S. (2014). On variational Bayes estimation and variational information criteria for linear regression models. _Australian & New Zealand Journal of Statistics_ , 56(1):73–87. 

- Yu, T. and Wu, Y. (2005). Decentralized multiple target tracking using netted collaborative autonomous trackers. In _Computer Vision and Pattern Recognition_ . 

- Zumer, J., Attias, H., Sekihara, K., and Nagarajan, S. (2007). A probabilistic algorithm integrating source localization and noise suppression for MEG and EEG data. _NeuroImage_ , 37(1):102–115. 

41 

