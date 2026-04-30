

# BAYESIAN ANALYSIS OF THE COVARIANCE MATRIX OF A MULTIVARIATE NORMAL DISTRIBUTION WITH A NEW CLASS OF PRIORS

BY JAMES O. BERGER<sup>1</sup>, DONGCHU SUN<sup>2</sup> AND CHENGYUAN SONG<sup>\*3</sup>

<sup>1</sup>Department of Statistical Science, Duke University, [berger@stat.duke.edu](mailto:berger@stat.duke.edu)

<sup>2</sup>Department of Statistics, University of Nebraska-Lincoln, [sund9@unl.edu](mailto:sund9@unl.edu)

<sup>3</sup>School of Statistics, East China Normal University, [songchengyuanchina@163.com](mailto:songchengyuanchina@163.com)

Bayesian analysis for the covariance matrix of a multivariate normal distribution has received a lot of attention in the last two decades. In this paper, we propose a new class of priors for the covariance matrix, including both inverse Wishart and reference priors as special cases. The main motivation for the new class is to have available priors—both subjective and objective—that do not “force eigenvalues apart,” which is a criticism of inverse Wishart and Jeffreys priors. Extensive comparison of these “shrinkage priors” with inverse Wishart and Jeffreys priors is undertaken, with the new priors seeming to have considerably better performance. A number of curious facts about the new priors are also observed, such as that the posterior distribution will be proper with just three vector observations from the multivariate normal distribution—regardless of the dimension of the covariance matrix—and that useful inference about features of the covariance matrix can be possible. Finally, a new MCMC algorithm is developed for this class of priors and is shown to be computationally effective for matrices of up to 100 dimensions.

**1. Introduction.** Estimating the unknown covariance matrix of a multivariate normal population has been an important issue for more than half a century. It has a wide range of modern applications including astrophysics ([18, 26]), economics ([23]), the environmental sciences ([11, 13]), climatology ([15]) and genetics ([30]).

Let  $y_1, \dots, y_m$  be a random sample of  $k \times 1$  vectors from the  $N_k(\mathbf{0}, \Sigma)$  distribution, where  $\Sigma$  is the  $k \times k$  unknown covariance matrix. (For simplicity, we assume the normal mean is zero, although essentially the same results would hold for a nonzero mean.) Our goal is to find good prior distributions—objective and subjective—for  $\Sigma$ .

The historical thread of this work starts with efforts to improve upon the “classical” estimator for  $\Sigma$ ,

$$\hat{\Sigma}_0 = \frac{1}{m} S = \frac{1}{m} \sum_{i=1}^m y_i y_i'.$$

This is the maximum likelihood estimate, the unbiased estimator and the posterior mean arising from use of the Jeffreys prior  $\pi^J(\Sigma) = |\Sigma|^{-(k+1)/2}$ . It has long been known to be a suboptimal estimator. First, (modest) improvements were obtained through use of the best equivariant estimator (see Section 4.3 for definition), with major improvements occurring when [33] discovered the value of shrinking together the eigenvalues of  $\hat{\Sigma}_0$ . Important follow-up research included [3, 7–9, 16, 17, 24, 25, 29, 34, 35] and [20].

On the Bayesian side, the early priors that were used (and still are used) were the Jeffreys prior and conjugate inverse Wishart (IW) priors, but they have been criticized in much the

Received August 2018; revised June 2019.

\*Corresponding author.

MSC2020 subject classifications. Primary 62F15; secondary 62C10, 62H10, 62H86.

Key words and phrases. Covariance, objective priors, shrinkage priors, inverse Wishart prior.

same way that  $\hat{\Sigma}_0$  was criticized. Indeed, when transforming to the eigenvalue-eigenvector parameterization, these priors were seen ([35]) to have a term

$$\prod_{i < j} (\lambda_i - \lambda_j)$$

in the density, where  $\lambda_1 > \lambda_2 > \dots > \lambda_k$  are the ordered eigenvalues of  $\Sigma$ . Since this term becomes zero whenever eigenvalues get close together, these common priors have the effect of forcing the eigenvalues of  $\Sigma$  apart. It is thus no surprise that [33] improved on  $\hat{\Sigma}_0$  by shrinking the eigenvalues together; Jeffreys prior (for which  $\hat{\Sigma}_0$  is the posterior mean) had forced the eigenvalues apart in creating the estimate.

The motivation for this work was twofold. First, to develop a class of priors—which we call *shrinkage inverse Wishart (SIW)* priors (including both subjective and objective versions)—that corrects the “forcing eigenvalues apart” problem. Second, to develop computational schemes for the new priors that, while not nearly as simple computationally as the IW priors, allow for computational handling of large dimensional (e.g.,  $k = 100$ ) covariance matrices. Note that approaching this problem from the Bayesian side carries a number of benefits, including the fact that the Bayesian estimates will be guaranteed to be positive definite (a problem with non-Bayesian approaches) and, as usual, the availability of measures of accuracy of estimates.

It is important to note here that we are considering the “vanilla” covariance matrix problem; we are assuming no special structure or sparsity for  $\Sigma$ . There is a vast modern literature dealing with priors for structured or sparse covariance matrices (see [27] for discussion of some of the early contributions).

Some curiosities were observed in this investigation. One such was that the posteriors for the SIW priors are proper when the sample size,  $m$ , is three or more, regardless of the dimension  $k$  of the covariance matrix. It is commonly perceived that one needs  $k$  observations to “identify”  $\Sigma$ , so the situation is interesting. Indeed, we provide some evidence that certain features of  $\Sigma$  (such as its trace) can be learned with much fewer than  $k$  observations, which we call *low rank learning*.

In Section 2, the new class of priors for  $\Sigma$  is proposed; interestingly, it is also a conjugate class. Propriety and moment existence results are obtained for both the prior and posterior distributions, and a method for subjectively eliciting the parameters of the prior is developed for an important special case. Computation for the priors and posteriors is considered in Section 3, with the proposed new method being capable of handling large (e.g.,  $k = 100$ ) dimensional covariance matrices. Section 4 presents extensive comparisons of the new and old priors, with the new priors appearing to be much better. In this section, we also explore issues surrounding low rank learning.

## 2. A new class of priors.

2.1. *Definition.* The new class of priors for  $\Sigma$  consists of densities

$$(2.1) \quad \pi(\Sigma \mid a, b, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{|\Sigma|^a [\prod_{i < j} (\lambda_i - \lambda_j)]^b},$$

where  $\lambda_1 > \dots > \lambda_k > 0$  are the eigenvalues of  $\Sigma$ ,  $a$  is a real constant,  $b$  is a number in  $[0, 1]$ ,  $H$  is a positive semidefinite matrix and  $\text{etr}(A) = \exp\{\text{trace}(A)\}$  for a square matrix  $A$ . If  $b = 0$ , this becomes the inverse Wishart density (denoted by  $\Sigma \sim \text{IW}(a, H)$ )

$$(2.2) \quad \pi^{\text{IW}}(\Sigma \mid a, H) = \frac{|H|^{a-(k+1)/2} \text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{2^{(2a-k-1)k/2} \pi^{k(k-1)/4} \prod_{i=1}^k \Gamma(\frac{2a-k-1}{2}) |\Sigma|^a},$$

which is proper if  $a > k$ .

Common objective priors that are in this class include:

- the constant prior,  $\pi^C(\Sigma) = 1$  (corresponding to  $a = b = 0$ ,  $H = \mathbf{0}$ );
- the Jeffreys prior ([22]),  $\pi^J(\Sigma) = |\Sigma|^{-(k+1)/2}$  (corresponding to  $a = (k+1)/2$ ,  $b = 0$  and  $H = \mathbf{0}$ );
- the [35] reference prior,  $\pi^R(\Sigma) = |\Sigma|^{-1}[\prod_{i < j}(\lambda_i - \lambda_j)]^{-1}$  (corresponding to  $a = b = 1$  and  $H = \mathbf{0}$ );
- the modified reference prior,  $\pi^{MR}(\Sigma) = |\Sigma|^{-[1-1/(2k)]}[\prod_{i < j}(\lambda_i - \lambda_j)]^{-1}$  (corresponding to  $a = 1 - 1/(2k)$ ,  $b = 1$  and  $H = \mathbf{0}$ ), which was suggested in [2] for use with covariance matrices that occurred at higher levels of a hierarchical model.

2.1.1. *Shrinkage inverse Wishart priors.* In this paper, we focus on the subclass in (2.1) when  $b = 1$ :

$$(2.3) \quad \pi^{\text{SIW}}(\Sigma \mid a, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{|\Sigma|^a \prod_{i < j}(\lambda_i - \lambda_j)}.$$

This will be called the *shrinkage inverse Wishart* (SIW) class. To see why the label “shrinkage” is attached to this class, consider the one-to-one transformation from  $\Sigma$  to  $\Lambda = \text{diag}(\lambda_1, \dots, \lambda_k)$  and the orthogonal matrix  $\Gamma$  of corresponding eigenvectors; it follows from [12] that the Jacobian is

$$(2.4) \quad \left| \frac{\partial \Sigma}{\partial(\Lambda, \Gamma)} \right| = \prod_{i < j}(\lambda_i - \lambda_j),$$

and the prior density (2.1) for  $\Sigma$  becomes the density of  $(\Lambda, \Gamma)$

$$(2.5) \quad \pi(\Lambda, \Gamma \mid a, b, H) \propto \frac{\text{etr}(-\frac{1}{2}\Gamma\Lambda^{-1}\Gamma'H)}{|\Lambda|^a[\prod_{i < j}(\lambda_i - \lambda_j)]^{b-1}} 1_{\{\lambda_1 > \dots > \lambda_k\}},$$

with respect to Lebesgue measure on  $(\lambda_1, \dots, \lambda_k)$  and the invariant Haar measure over the space of all orthonormal matrices  $\Gamma$ . The invariant prior on  $\Gamma$  (essentially a uniform prior over rotations) is natural and noncontroversial. However, when  $b = 0$  (which corresponds to the commonly used priors such as inverse Wishart, Jeffreys and constant), the presence of the term  $[\prod_{i < j}(\lambda_i - \lambda_j)]$  in the prior is quite strange; the prior is near zero whenever eigenvalues are close together, so that the prior effectively forces eigenvalues apart. This seems contrary to common intuition and typical prior beliefs.

In contrast, the SIW priors have  $b = 1$ , so that the questionable term in the density disappears. The SIW priors are essentially neutral as to how the eigenvalues should be spread out; in that sense, calling them “shrinkage” priors is something of a misnomer, but they are shrinkage priors compared to the commonly used  $b = 0$  priors.

2.1.2. *SIW priors with  $H \propto I_k$ .* Unfortunately, working with the SIW priors is not as easy as working with the IW priors, but the special case of  $\text{SIW}(a, cI_k)$  priors is quite tractable. With  $\text{IW}(a, H)$  priors,  $H$  is very often chosen to be a multiple of the identity, so this subclass of SIW priors is important. Note, from (2.5), that the density of  $(\Lambda, \Gamma)$  for this subclass is

$$\pi(\Lambda, \Gamma \mid a, c) \propto \prod_{i=1}^k \frac{1}{\lambda_i^a} e^{-\frac{c}{2\lambda_i}} 1_{\{\lambda_1 > \lambda_2 > \dots > \lambda_k\}}.$$

TABLE 1  
 Different priors for  $\Sigma$  and corresponding priors for  $(\Lambda, \Gamma)$  where  
 $\mathcal{A} = \{(\lambda_1, \dots, \lambda_k) \mid \lambda_1 > \dots > \lambda_k\}$ .

| Prior for $\Sigma$                                                                                                                         | Prior for $(\Lambda, \Gamma)$                                                                                                                                           |
|--------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| $\pi(\Sigma \mid a, b, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{ \Sigma ^a \prod_{i < j} (\lambda_i - \lambda_j)^b}$         | $\pi(\Lambda, \Gamma \mid a, b, H) \propto \frac{\text{etr}(-\frac{1}{2}\Gamma \Lambda^{-1} \Gamma' H) 1_A}{ \Lambda ^a \prod_{i < j} (\lambda_i - \lambda_j)^{b-1}}$   |
| $\pi^{\text{IW}}(\Sigma \mid a, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{ \Sigma ^a}$                                        | $\pi^{\text{IW}}(\Lambda, \Gamma \mid a, H) \propto \frac{\prod_{i < j} (\lambda_i - \lambda_j) 1_A}{ \Lambda ^a \text{etr}(\frac{1}{2}\Gamma \Lambda^{-1} \Gamma' H)}$ |
| $\pi^{\text{SIW}}(\Sigma \mid a, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{ \Sigma ^a \prod_{i < j} (\lambda_i - \lambda_j)}$ | $\pi^{\text{SIW}}(\Lambda, \Gamma \mid a, H) \propto \frac{\text{etr}(-\frac{1}{2}\Gamma \Lambda^{-1} \Gamma' H) 1_A}{ \Lambda ^a}$                                     |
| $\pi^J(\Sigma) \propto \frac{1}{ \Sigma ^{(k+1)/2}}$                                                                                       | $\pi^J(\Lambda, \Gamma) \propto \frac{\prod_{i < j} (\lambda_i - \lambda_j)}{ \Lambda ^{(k+1)/2}} 1_A$                                                                  |
| $\pi^R(\Sigma) \propto \frac{1}{ \Sigma  \prod_{i < j} (\lambda_i - \lambda_j)}$                                                           | $\pi^R(\Lambda, \Gamma) \propto \frac{1}{ \Lambda } 1_A$                                                                                                                |
| $\pi^{\text{MR}}(\Sigma) \propto \frac{1}{ \Sigma ^{1/(1-2k)} \prod_{i < j} (\lambda_i - \lambda_j)}$                                      | $\pi^{\text{MR}}(\Lambda, \Gamma) \propto \frac{1}{ \Lambda ^{1/(1-2k)}} 1_A$                                                                                           |
| $\pi^C(\Sigma) \propto 1$                                                                                                                  | $\pi^C(\Lambda, \Gamma) \propto \prod_{i < j} (\lambda_i - \lambda_j) 1_A$                                                                                              |
| $\pi^U(\Sigma) \propto \frac{1}{\prod_{i < j} (\lambda_i - \lambda_j)}$                                                                    | $\pi^U(\Lambda, \Gamma) \propto 1_A$                                                                                                                                    |

REMARK 1. The prior for  $\Gamma$  is constant, and the marginal prior density of  $(\lambda_1, \dots, \lambda_k)$  is

$$\pi(\Lambda \mid a, c) \propto \prod_{i=1}^k \frac{1}{\lambda_i^a} e^{-\frac{c}{2\lambda_i}} 1_{\{\lambda_1 > \lambda_2 > \dots > \lambda_k\}},$$

which will be seen to be equivalent to the eigenvalues,  $\lambda_1 > \dots > \lambda_k$ , arising as the order statistics of  $k$  observations from the Inverse Gamma( $a - 1, \frac{c}{2}$ ) distribution.

2.1.3. *Summary of priors.* The various priors for  $\Sigma$  considered above, and the corresponding priors for  $(\Lambda, \Gamma)$ , are summarized in Table 1. One additional prior is given therein, namely  $\pi^U$ , labeled as the uniform prior because it corresponds to the constant prior for  $(\Lambda, \Gamma)$ .

2.1.4. *SIW posteriors.* For a simple random sample,  $Y = (y_1, \dots, y_m)$ , from  $N_k(\mathbf{0}, \Sigma)$  and using the prior  $\text{SIW}(a, H)$ , the posterior is given by

$$(2.6) \quad \pi(\Sigma \mid Y) \propto \frac{1}{|\Sigma|^r \prod_{i < j} (\lambda_i - \lambda_j)} \text{etr}\left(-\frac{1}{2}\Sigma^{-1}H_0\right),$$

where  $r = a + m/2$  and  $H_0 = H + S$ . This is the  $\text{SIW}(r, H_0)$  distribution, so the SIW priors are a conjugate family.

2.2. *Propriety of SIW priors and posteriors.* The following theorem, whose proof is in Appendix A.1, gives sufficient conditions for propriety of the SIW prior distribution.

THEOREM 1. For the  $\text{SIW}(a, H)$  prior for  $\Sigma$ , with  $p = \text{rank}(H) > 0$ ,

- (a) when  $p = k$ , the prior is proper iff  $a > 1$ ;
- (b) when  $0 < p < k$ , the prior is proper iff  $1 < a < 1 + p/2$ .

It follows from Theorem 1 that, for the priors (2.1) with  $p = \text{rank}(H) < k$ ,  $a = 1 + p/2$  is the boundary of impropriety.

For propriety of the posterior, we need the following lemma, whose proof is given in Appendix A.1.

LEMMA 1. Let  $\mathbf{H}$  be the prior scale matrix with  $\text{rank}(\mathbf{H}) = p$ . Then, with probability one,

$$(2.7) \quad p^* = \text{rank}(\mathbf{H}_0) = \text{rank}(\mathbf{H} + \mathbf{S}) = \min\{k, m + p\}.$$

Hence the conditions for posterior propriety can be read from Theorem 1 by replacing  $p$  with  $p^*$  and  $a$  with  $a + m/2$ .

### 2.3. Moments of SIW priors and posteriors.

2.3.1. *Existence of prior and posterior moments.* The following theorem gives some necessary and sufficient conditions for the existence of SIW prior and posterior moments.

THEOREM 2. For the SIW( $a, \mathbf{H}$ ) prior for  $\Sigma$ , with  $p = \text{rank}(\mathbf{H}) > 0$ ,

- (a) when  $p = k$ ,  $E(\Sigma^{-1})$  exists iff  $a > 1$  while, for any positive integer  $q$ ,  $E(\Sigma^q)$  exists iff  $a > 1 + q$ ;
- (b) when  $0 < p < k$ ,  $E(\Sigma^{-1})$  exists iff  $1 < a < p/2$  while, for any positive integer  $q$ ,  $E(\Sigma^q)$  exists iff  $1 + q < a < 1 + p/2$ .

Existence results for the posterior moments are found, with probability one, by replacing  $p$  by  $p^*$  from (2.7) and  $a$  by  $a + m/2$ .

PROOF. For parts (a1) and (b1), it follows from Lemma 4 (see Appendix A.1) that

$$(2.8) \quad E(\Sigma^{-1}) = \frac{\int \int \mathbf{\Gamma} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' |\mathbf{\Lambda}|^{-a} \text{etr}(-\frac{1}{2} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' \mathbf{H} \mathbf{\Gamma}) d\mathbf{\Gamma} d\mathbf{\Lambda}}{\int \int |\mathbf{\Lambda}|^{-a} \text{etr}(-\frac{1}{2} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' \mathbf{H} \mathbf{\Gamma}) d\mathbf{\Gamma} d\mathbf{\Lambda}}.$$

Theorem 1 gives a condition when the denominator exists. Let  $\mathbf{E}_{hj}$  be the  $k \times k$  matrix with 1 in the  $(h, j)$  entry and 0 elsewhere, and  $\mathbf{o}_j$  be the  $k$ -dimensional vector with 1 in the  $j$ th component and 0 elsewhere, for  $h, j \leq k$ . Then the numerator in (2.8) equals

$$\sum_{h=1}^k \sum_{j=1}^k \mathbf{E}_{hj} C_{hj} \quad \text{where } C_{hj} = \int \int \mathbf{o}'_h \mathbf{\Lambda}^{-1} \mathbf{o}_j \prod_{i=1}^k \frac{1}{\lambda_i^q} \text{etr}\left(-\frac{1}{2} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' \mathbf{H} \mathbf{\Gamma}\right) d\mathbf{\Lambda} d\mathbf{\Gamma}.$$

Clearly,  $\lambda_1^{-1} \leq |\mathbf{o}'_h \mathbf{\Lambda}^{-1} \mathbf{o}_j| \leq \lambda_k^{-1}$ . Then

$$C_{hj} \leq \int \int \lambda_k^{-(a+1)} \prod_{i=1}^{k-1} \lambda_i^{-q} \text{etr}\left(-\frac{1}{2} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' \mathbf{H} \mathbf{\Gamma}\right) d\mathbf{\Lambda} d\mathbf{\Gamma},$$

$$C_{hj} \geq \int \int \lambda_1^{-(a+1)} \prod_{i=2}^k \lambda_i^{-q} \text{etr}\left(-\frac{1}{2} \mathbf{\Lambda}^{-1} \mathbf{\Gamma}' \mathbf{H} \mathbf{\Gamma}\right) d\mathbf{\Lambda} d\mathbf{\Gamma}.$$

Proceeding as in the proof of Theorem 1, one can show that  $C_{hj}$  is finite if and only if either ( $p = k, a > 1$ ) or ( $0 < p < k, 1 < a < 1 + p/2$ ) holds. Parts (a1) and (b1) are proved. The proofs of parts (a2) and (b2) are similar.  $\square$

Recall that the constant prior,  $\pi^C$ , the reference prior,  $\pi^R$ , the modified reference prior,  $\pi^{\text{MR}}$ , and the uniform prior for  $(\mathbf{\Lambda}, \mathbf{\Gamma})$ ,  $\pi^U$ , are improper. Table 2 presents sample sizes  $m$  needed for existence of  $\pi(\Sigma | \mathbf{S})$ ,  $E(\Sigma^{-1} | \mathbf{S})$  and  $E(\Sigma | \mathbf{S})$  under  $\pi^C$ ,  $\pi^R$ ,  $\pi^{\text{MR}}$ , and  $\pi^U$ . Among the four priors,  $\pi^{\text{MR}}$  requires the least number of observations for the posterior to be proper; indeed, it is surprising that a single (vector) observation suffices to yield posterior propriety, since the common perception is that a  $k \times k$  covariance matrix needs  $k$  observations to be “identifiable.” It is equally surprising that the constant prior requires more than  $2k$  observations; the suggestion is that the constant prior is way too diffuse. (See [4] for discussion.)

TABLE 2  
 Sample size,  $m$ , needed for the existence of  $\pi(\Sigma | S)$ ,  
 $E(\Sigma^{-1} | S)$  and  $E(\Sigma | S)$  under  $\pi^C$ ,  $\pi^R$ ,  $\pi^{MR}$  and  $\pi^U$

| Prior      | Existence of<br>$\pi(\Sigma   S)$ | Existence of<br>$E(\Sigma^{-1}   S)$ | Existence of<br>$E(\Sigma   S)$ |
|------------|-----------------------------------|--------------------------------------|---------------------------------|
| $\pi^C$    | $m > 2k$                          | $m > 2k$                             | $m > 2k + 2$                    |
| $\pi^R$    | $m \geq k$                        | $m \geq k$                           | $m \geq \max(k, 3)$             |
| $\pi^{MR}$ | $m \geq 1$                        | $m \geq k$                           | $m \geq 3$                      |
| $\pi^U$    | $m \geq 3$                        | $m \geq \max(k, 3)$                  | $m \geq 5$                      |

2.3.2. *Expressions for prior and posterior moments.* To work with the SIW priors as subjective priors, one must assess the parameters  $a$  and  $H$ . As with inverse Wishart priors, this is most naturally done by subjectively specifying prior moments, and then solving for  $a$  and  $H$ . We first give general expressions for the SIW prior and posterior moments (the proof in Appendix A.2), and then specialize to the important special case where  $H \propto I_k$ .

THEOREM 3. Consider the priors  $\text{SIW}(a, H)$  for  $\Sigma$  with  $p = \text{rank}(H) > 0$ . Consider the eigenvalue-eigenvector decomposition  $H = Z \Delta Z'$ . For any integer  $q \geq -1$ , if  $(a, p)$  satisfies the conditions of Theorem 2,

$$(2.9) \quad E(\Sigma^q) = Z \text{diag}(\phi_{q,1}, \dots, \phi_{q,k}) Z',$$

where for  $i = 1, \dots, k$ ,

$$(2.10) \quad \phi_{q,i}(a, \Delta) = \frac{k\Gamma(a-q-1)}{2^q\Gamma(a-1)} \int t_{i1}^2 \|\bar{t}_1\|^{2q} \prod_{j=1}^k \|\bar{t}_j\|^{-2(a-1)} dT,$$

with  $T = (t_{ij})$  being orthogonal and  $\|\bar{t}_j\|^2 = \sum_{h=1}^k \delta_h t_{hj}^2$ , where the  $\delta_h$  are the diagonal elements of  $\Delta$ .

The posterior moments are found by replacing (above)  $p$  by  $p^*$  from (2.7),  $a$  by  $a + m/2$ , and  $H$  by  $H_0 = H + S$ .

COROLLARY 1. Consider the priors  $\text{SIW}(a, cI_k)$  for  $\Sigma$ .

$$(a) \text{ If } a > 1, E(\Sigma^{-1}) = \frac{2(a-1)}{c} I_k.$$

$$(b) \text{ If } a > 2, \text{ the first moment of (2.1) is } E(\Sigma) = \frac{c}{2(a-2)} I_k.$$

$$(c) \text{ If } a > 3, \text{ the second moment of (2.1) is } E(\Sigma^2) = \frac{c^2}{4(a-2)(a-3)} I_k.$$

PROOF. When  $H = cI_k$ ,  $\|\bar{t}_j\|^2 = c$  in (2.10) so, for any integer  $q \geq -1$  and  $a > q$ , (2.10) becomes

$$(2.11) \quad \phi_{q,i} = \frac{k\Gamma(a-q-1)}{2^q\Gamma(a-1)} c^q \int t_{i1}^2 dT = \frac{c^q\Gamma(a-q-1)}{2^q\Gamma(a-1)}.$$

The results hold.  $\square$

2.4. *Eliciting prior parameters for IW and SIW priors.* We confine consideration to the case  $H \propto I_k$ . First, for  $\Sigma \sim \text{IW}(\alpha, \beta I_k)$ , a natural way to specify  $\alpha$  and  $\beta$  is to subjectively specify the mean,  $\mu$ , and variance,  $\tau^2$  (smaller than  $\mu^2$ ), of a diagonal element of  $\Sigma$  (noting

that all diagonal elements have the same distribution). Noting that the prior mean and variance of, say,  $\sigma_{11}$  are (for  $\alpha > k + 2$ )

$$E[\sigma_{11}] = \frac{\beta}{2(\alpha - k - 1)} \quad \text{and} \quad \text{Var}[\sigma_{11}] = \frac{\beta^2}{4(\alpha - k - 1)(\alpha - k - 2)},$$

we equate these with the subjectively specified  $\mu$  and  $\tau^2$  and solve to obtain

$$(2.12) \quad \alpha = k + 2 - \frac{\mu^2}{\mu^2 - \tau^2} \quad \text{and} \quad \beta = 2\mu(\alpha - k - 1).$$

The variance of  $\sigma_{11}$  from the  $\text{SIW}(a, c\mathbf{I}_k)$  prior is not readily available, but  $E[\Sigma^2]$  is available from Corollary 1, so we can equate the first and second moments of  $\Sigma$  for the  $\text{SIW}(a, c\mathbf{I}_k)$  and  $\text{IW}(\alpha, \beta\mathbf{I}_k)$  priors, and solve to obtain  $a$  and  $c$ , in terms of (2.12). The result is in the following lemma.

LEMMA 2.  $\Sigma$  has the same first two moments for the  $\text{SIW}(a, c\mathbf{I}_k)$  and  $\text{IW}(\alpha, \beta\mathbf{I}_k)$  priors, when  $\alpha > k + 2$ , if

$$a = 2 + \frac{(2\alpha - k - 2)(\alpha - k - 1)}{\alpha(k + 1) - k(k + 2)} \quad \text{and} \quad c = \frac{\beta(2\alpha - k - 2)}{\alpha(k + 1) - k(k + 2)}.$$

PROOF. The first two moments of the  $\text{SIW}(a, c\mathbf{I}_k)$  prior are given in Corollary 1. The first two moments of the inverse Wishart distribution are (from Section 5 of [28])

$$E(\Sigma) = \frac{\beta}{2(\alpha - k - 1)} \mathbf{I}_k \quad \text{if } \alpha > k + 1, \\ E(\Sigma^2) = \frac{\beta^2(2\alpha - k - 2)}{4(2\alpha - 2k - 1)(\alpha - k - 1)(\alpha - k - 2)} \mathbf{I}_k \quad \text{if } \alpha > k + 2.$$

Equating the moments and solving for  $a$  and  $c$  gives the result.  $\square$

2.5. *Bayes estimation under loss functions.* The most common loss function for estimating  $\Sigma$  by  $\hat{\Sigma}$  is the entropy loss ([32])

$$(2.13) \quad L_1(\Sigma, \hat{\Sigma}) = \text{tr}(\hat{\Sigma}\Sigma^{-1}) - \log|\hat{\Sigma}\Sigma^{-1}| - k.$$

Sinha and Ghosh [31] studied the similar entropy loss,

$$(2.14) \quad L_2(\Sigma, \hat{\Sigma}) = \text{tr}(\Sigma\hat{\Sigma}^{-1}) - \log|\Sigma\hat{\Sigma}^{-1}| - k,$$

which we utilize herein because the Bayesian estimator is the posterior mean

$$(2.15) \quad \hat{\Sigma}_{B2} = E(\Sigma | Y).$$

A third common loss is the quadratic loss ([35]),

$$(2.16) \quad L_3(\Sigma, \hat{\Sigma}) = \text{tr}(\hat{\Sigma}\Sigma^{-1} - \mathbf{I}_k)^2.$$

In the risk analyses, all three losses gave similar results so we only present the results for  $L_2$  in this paper; the results for  $L_1$  and  $L_3$  are in the Supplementary Material [5].

For the  $\text{SIW}(a, c\mathbf{I})$  prior (including  $\pi^R$ ,  $\pi^{\text{MR}}$  and  $\pi^U$ ), Theorem 3 immediately gives expressions for the Bayes estimates under  $L_2$ ; just choose  $q = 1$ . Those expressions can also be used to prove the following lemma.

LEMMA 3. For a  $SIW(a, c\mathbf{I})$  prior, the frequentist risks (letting  $\hat{\Sigma}_{Bj}$  denote the Bayes estimator under  $L_j$ )  $R_j(\Sigma, \hat{\Sigma}_{Bj}) = E[L_j(\Sigma, \hat{\Sigma}_{Bj})]$ ,  $j = 1, 2, 3$ , are equivariant, that is, they depend only on the eigenvalues of  $\Sigma$ .

PROOF. For any orthogonal transformation of the data,  $\tilde{y} = \tilde{\Gamma}y$ , the loss  $L_j$  and its Bayesian estimate  $\hat{\Sigma}_{Bj}(S)$  are both equivariant, where  $j = 1, 2$ . In fact, it follows from (2.10) that  $\tilde{\Gamma}'\hat{\Sigma}_{Bj}(S)\tilde{\Gamma} = \hat{\Sigma}_{Bj}(\tilde{\Gamma}'S\tilde{\Gamma})$ ; also  $L_j(\Sigma, \hat{\Sigma}_{Bj}(S)) = L_j(\tilde{\Gamma}'\Sigma\tilde{\Gamma}, \tilde{\Gamma}'\hat{\Sigma}_{Bj}(S)\tilde{\Gamma})$ . If one chooses  $\tilde{\Gamma} = \Gamma$ , it yields

$$\begin{aligned} R_j(\Sigma, \hat{\Sigma}_{Bj}(S)) &= E^{S|\Sigma}[L_j(\Sigma, \hat{\Sigma}_{Bj}(S))] = E^{S|\Sigma}[L_j(\Gamma'\Sigma\Gamma, \Gamma'\hat{\Sigma}_{Bj}(S)\Gamma)] \\ &= E^{S|\Sigma}[L_j(\Lambda, \hat{\Sigma}_{Bj}(\Gamma'\Sigma\Gamma))] = R_j(\Lambda, \hat{\Sigma}_{Bj}(\Gamma'\Sigma\Gamma)). \end{aligned}$$

Since the distribution of  $\Gamma'\Sigma\Gamma$  depends only on  $\Lambda$ , the result holds.  $\square$

The value of this lemma is that, in the extensive later simulations, it suffices to consider only diagonal covariance matrices  $\Sigma$ .

**3. Computation with the SIW posterior.** The posterior distribution for the  $SIW(a, H)$  prior can be written

$$(3.1) \quad \pi(\Sigma | Y) \propto \frac{1}{|\prod_{i=1}^k \lambda_i|^r |\prod_{i < j} (\lambda_i - \lambda_j)|} \operatorname{etr}\left(-\frac{1}{2}\Sigma^{-1}H_0\right),$$

where  $r = a + m/2$  and  $H_0 = H + S$ . In this section, methods for simulating from this posterior are discussed. Of course, the methods can also be used to simulate from the prior.

3.1. *Previously suggested sampling methods for  $\Sigma$ .* Method 1. *Metropolis–Hastings Algorithm* ([19]). Let  $\Sigma_0$  be some starting point (e.g., the marginal maximum likelihood estimate or just  $\mathbf{I}_k$ ). At iteration  $t = 0, 1, 2, \dots$ ,

Step 1. Generate  $\Sigma^* \sim \text{Inverse Wishart}(\frac{m+k+1}{2}, H_0)$ .

Step 2. Let  $\lambda_i^*$  and  $\lambda_i^t$  be the eigenvalues of  $\Sigma^*$  and  $\Sigma_t$ , respectively. Define

$$\alpha = \min \left\{ 1, \prod_{i < j} \frac{\lambda_i^t - \lambda_j^t}{\lambda_i^* - \lambda_j^*} \cdot \prod_{i=1}^k \left( \frac{\lambda_i^*}{\lambda_i^t} \right)^{\frac{k+1-2a}{2}} \right\}.$$

Step 3. Let

$$\Sigma_{t+1} = \begin{cases} \Sigma^* & \text{with probability } \alpha, \\ \Sigma_t & \text{otherwise.} \end{cases}$$

Method 2. *Hit-and-Run* (see [6, 35]). Define  $\Sigma^* = \log(\Sigma)$ , or  $\Sigma = \exp(\Sigma^*)$ , in the sense that

$$\Sigma = \sum_{i=1}^{\infty} \frac{(\Sigma^*)^i}{i!}.$$

By Lemma 2 of [35], the posterior density of  $\Sigma^* = \Gamma\Lambda^*\Gamma'$ , where  $\Lambda^* = \operatorname{diag}(\lambda_1^*, \dots, \lambda_k^*)$ ,  $\lambda_1^* \geq \dots \geq \lambda_k^*$ , and  $\Gamma$  is orthogonal is then

$$\pi^*(\Sigma^* | H_0) \propto \frac{1}{\prod_{i < j} (\lambda_i^* - \lambda_j^*)} \operatorname{etr} \left\{ -\sum_{i=1}^k (r-1)\lambda_i^* - \frac{1}{2}\Gamma \exp(-\Lambda^*)\Gamma' H_0 \right\}.$$

The sampling procedure proceeds as follows:

Step 1. Select a starting p.d. matrix  $\Sigma_0$ , set  $\Sigma_0^* = \log \Sigma_0$  and  $t = 0$ .

Step 2. At iteration  $t$ , simulate a random direction symmetric matrix  $U_0 = (u_{ij})_{k \times k}$ , whose elements are  $u_{ij} = g_{ij}/\sqrt{\sum_{1 \leq l \leq h \leq k} g_{lh}^2}$ , where  $g_{lh} \stackrel{i.i.d.}{\sim} N(0, 1)$ ,  $1 \leq l < h \leq k$ .

Step 3. Generate  $x \sim N(0, 1)$ . Set  $X = \Sigma_t^* + xU_0$  and

$$\Sigma_{t+1}^* = \begin{cases} X & \text{with the probability } \min(1, \pi^*(X)/\pi^*(\Sigma_t^*)), \\ \Sigma_t^* & \text{otherwise.} \end{cases}$$

Step 4. Set  $\Sigma_{t+1} = \exp(\Sigma_{t+1}^*)$ .

3.2. *A new method.* The Metropolis and hit-and-run methods work only for small or moderate dimensional covariance matrices. Here, we consider a new Gibbs sampling method (drawing heavily on [21]) that has considerable promise for much higher dimensions.

From (2.4) and Lemma 4 (in the Appendix), (3.1) can be transformed to

$$(3.2) \quad \pi(\Lambda, \Gamma | H_0) \propto \frac{1}{\prod_{i=1}^k \lambda_i^r} \operatorname{etr} \left( -\frac{1}{2} \Lambda^{-1} \Gamma' H_0 \Gamma \right),$$

with the understanding that the  $\lambda_i$  are to be ordered after they are drawn from this distribution.

3.2.1. *Simulating  $\Lambda$  given  $(\Gamma, Y)$ .* To sample  $\Lambda$  from the full conditional given  $\Gamma$ , note that

$$\frac{1}{2} \operatorname{tr}(\Lambda^{-1} \Gamma' H_0 \Gamma) = \sum_{i=1}^k \frac{c_i}{\lambda_i},$$

where  $c_i$  is the  $(i, i)$  element of  $\Gamma' H_0 \Gamma/2$ . Thus

$$(3.3) \quad \pi(\Lambda | \Gamma, H_0) \propto \prod_{i=1}^k \frac{1}{\lambda_i^r} e^{-c_i/\lambda_i}.$$

For given  $\Gamma$ , we can directly sample  $\lambda_i$  independently from Inverse Gamma  $(r - 1, c_i)$ . Then rearrange  $\lambda_i$ , so that  $\lambda_1 \geq \dots \geq \lambda_k$ .

3.2.2. *Simulating  $\Gamma$  given  $(\Lambda, Y)$ .* To sample from  $\pi(\Gamma | \Lambda, H_0)$ , note that

$$(3.4) \quad \pi(\Gamma | \Lambda, H_0) \propto \operatorname{etr} \left( -\frac{1}{2} \Lambda^{-1} \Gamma' H_0 \Gamma \right).$$

Here, without loss of generality, assume that  $H_0 = \operatorname{diag}(h_1, \dots, h_k)$ .

Hoff [21] proposed a Gibbs sampler for simulating  $\Gamma$  from (3.4). His method was to randomly select two columns  $i < j$  of  $\Gamma$ , and then does a Gibbs update of the columns.

We use a slight modification of his method, namely updating the rows of  $\Gamma$ . When  $m$  is large, there is no real difference in the speed of the methods but recall that, for SIW,  $m$  can be much less than  $k$ , in which case sampling the rows can be much faster; see Remark 2 for an explanation.

From (3.4), the conditional density of  $\Gamma$ , given  $\Lambda$  and  $H_0$ , can be rewritten

$$(3.5) \quad \pi(\Gamma | \Lambda; H_0) \propto \operatorname{etr} \left( -\frac{1}{2} H_0 \Gamma \Lambda^{-1} \Gamma' \right).$$

To update the first two rows of  $\Gamma$ , we write  $\Gamma = \operatorname{diag}(X, I_{k-2})(T'_{12}, T'_{-12})'$ , where  $T_{12}$  is the first 2 rows of  $\Gamma$ ,  $T_{-12}$  is the remaining  $k - 2$  rows of  $\Gamma$ , and

$$X = D_\epsilon X_\theta \equiv \begin{pmatrix} \epsilon_1 & 0 \\ 0 & \epsilon_2 \end{pmatrix} \begin{pmatrix} \cos \theta & -\sin \theta \\ \sin \theta & \cos \theta \end{pmatrix}.$$

Here,  $\theta \in (-\frac{\pi}{2}, \frac{\pi}{2}]$  and  $\epsilon_i = \pm 1$  for  $i = 1, 2$ . Write  $H_1 = \text{diag}(h_1, h_2)$  and  $H_2 = \text{diag}(h_3, \dots, h_k)$ . Then the conditional posterior of  $\theta$  is

$$\begin{aligned} & \pi(\theta | T_{12}, T_{-12}, \Lambda; H_0) \\ & \propto \text{etr} \left\{ -\frac{1}{2} \begin{pmatrix} H_1 & 0 \\ 0 & H_2 \end{pmatrix} \begin{pmatrix} X & 0 \\ 0 & I_{k-2} \end{pmatrix} \begin{pmatrix} T_{12} \\ T_{-12} \end{pmatrix} \Lambda^{-1} (T'_{12}, T'_{-12}) \begin{pmatrix} X' & 0 \\ 0 & I_{k-2} \end{pmatrix} \right\} \\ & \propto \text{etr} \left\{ -\frac{1}{2} H_1 X T_{12} \Lambda^{-1} T'_{12} X' \right\} = \text{etr} \left\{ -\frac{1}{2} H_1 X_\theta T_{12} \Lambda^{-1} T'_{12} X'_\theta \right\}. \end{aligned}$$

Write

$$T_{12} \Lambda^{-1} T'_{12} = \begin{pmatrix} \cos \omega & -\sin \omega \\ \sin \omega & \cos \omega \end{pmatrix} \begin{pmatrix} s_1 & 0 \\ 0 & s_2 \end{pmatrix} \begin{pmatrix} \cos \omega & \sin \omega \\ -\sin \omega & \cos \omega \end{pmatrix},$$

where  $\omega \in (-\pi/2, \pi/2]$ , and  $s_1 > s_2$ . Then the conditional posterior of  $\theta$  is

$$(3.6) \quad \pi(\theta | T_{12}, T_{-12}, \Lambda; H_0) \propto \exp\{c_0 \cos^2(\theta + \omega)\}, \quad \theta \in (-\pi/2, \pi/2],$$

where  $c_0 = -\frac{1}{2}(s_1 - s_2)(h_1 - h_2) \leq 0$ . Let  $\alpha = \cos^2(\theta + \omega)$ . Then the full conditional density of  $\alpha$  is

$$(3.7) \quad \pi(\alpha | O_{-12}, D; H_0) \propto e^{c_0 \alpha} \alpha^{-\frac{1}{2}} (1 - \alpha)^{-\frac{1}{2}}, \quad \alpha \in (0, 1).$$

As [21] discussed, sampling  $\alpha \in (0, 1)$  can be done by rejection sampling, with the proposal being the  $\text{Beta}(\frac{1}{2}, \frac{1}{2})$  distribution.

For updating any other  $i$  and  $j$  rows, the corresponding conditional density of  $\theta$  has a similar formula as in (3.6), with  $c_0 = -\frac{1}{2}(s_1 - s_2)(h_i - h_j)$  and  $(s_1, s_2)$  being the eigenvalues of  $T_{ij} \Lambda^{-1} T'_{ij}$ , and  $T_{ij}$  consists of the  $(i, j)$ th rows of  $\Gamma$ .

**REMARK 2.** When  $p \equiv \text{rank}(H_0) < k$ ,  $h_{p+1} = \dots = h_k = 0$ . To update  $(i, j)$  rows with  $i \leq p$  and  $j > p$ , the conditional density of  $\theta$  is of the form (3.6) with  $c_0 = -\frac{1}{2}(s_1 - s_2)h_i$ . Furthermore, to update  $(i, j)$  rows with  $i > p$  and  $j > p$ , the conditional density of  $\theta$  is then simply  $\text{Uniform}[-\pi/2, \pi/2]!$  Therefore, updating the rows of  $\Gamma$  are more efficient than Hoff's method of updating the columns of  $\Gamma$ , when  $p \ll k$ . This will be the case, for the reference prior and modified reference prior of  $\Sigma$  and the uniform prior for  $(\Lambda, \Gamma)$ , when  $m$  is small compared to  $k$ .

**3.3. Comparing the three sampling methods.** To compare the three simulation methods, we choose  $\Sigma_0$  and obtain a sample  $Y = (y_1, \dots, y_m)$  from  $N_k(\mathbf{0}, \Sigma_0)$ . Then we simulate  $\Sigma$  from the posterior under the modified reference prior,  $\pi^{\text{MR}}(\Sigma)$ .

Instead of looking at the convergence of the posterior for various components of  $\Sigma$ , we monitor the convergence of  $L_2(\hat{\Sigma}_{B1}, \Sigma_0)$ , namely the entropy loss in (2.13) evaluated at the Bayes estimate,  $\hat{\Sigma}_{B2}$ , computed by simulation. This provides an overall assessment of convergence of the simulation. Convergence was judged using the criterion in [14].

The following four cases of  $(k, m)$  and  $\Sigma_0$  are considered:

Case I:  $(k, m) = (5, 15)$  and  $\Sigma_0 = \text{diag}(16, 8, 4, 2, 1)$ . The observed  $S$  has the eigenvalues (286, 223, 39, 16, 15).

Case II:  $(k, m) = (10, 40)$  and  $\Sigma_0 = \text{diag}(512, 256, 128, 64, 32, 16, 8, 4, 2, 1)$ . The observed  $S$  has the eigenvalues (15,255, 11,170, 5185, 3447, 1085, 577, 159, 128, 49, 43).

Case III:  $(k, m) = (50, 100)$  and  $\Sigma_0 = \text{diag}(50, \dots, 2, 1)$ . The first and last five eigenvalues of  $S$  are (8083, 7903, 7104, 6871, 6352) and (207, 181, 131, 98, 60), respectively.

Case IV:  $(k, m) = (100, 300)$  and  $\Sigma_0 = \text{diag}(100, \dots, 2, 1)$ . The first and last five eigenvalues of  $S$  are (46,293, 45,558, 44,045, 42,976, 41,887) and (827, 684, 529, 440, 221), respectively.

TABLE 3  
Comparison of computing time for the three methods

|                          | Method      | Time (seconds)<br>for $10^3$ circles | # of iterations<br>to convergence | Total time<br>(seconds) |
|--------------------------|-------------|--------------------------------------|-----------------------------------|-------------------------|
| Case I<br>( $k = 5$ )    | Metropolis  | 1.61                                 | $2.0 \times 10^7$                 | $3.22 \times 10^4$      |
|                          | Hit-and-Run | 3.01                                 | $2.0 \times 10^7$                 | $6.02 \times 10^4$      |
|                          | New Method  | 2.88                                 | $1.5 \times 10^5$                 | $4.32 \times 10^2$      |
| Case II<br>( $k = 10$ )  | Metropolis  | 1.79                                 | $4.0 \times 10^7$                 | $7.16 \times 10^4$      |
|                          | Hit-and-Run | 4.73                                 | $3.5 \times 10^7$                 | $1.65 \times 10^5$      |
|                          | New Method  | 5.85                                 | $7.0 \times 10^5$                 | $4.09 \times 10^3$      |
| Case III<br>( $k = 50$ ) | Metropolis  | 4.68                                 | stop at $1.5 \times 10^8$         | $>7.02 \times 10^5$     |
|                          | Hit-and-Run | 18.20                                | $4.0 \times 10^7$                 | $7.28 \times 10^5$      |
|                          | New Method  | 43.96                                | $1.0 \times 10^6$                 | $4.39 \times 10^4$      |
| Case IV<br>( $k = 100$ ) | Metropolis  | 23.84                                | stop at $1.2 \times 10^8$         | $>2.86 \times 10^6$     |
|                          | Hit-and-Run | 80.42                                | stop at $1.2 \times 10^8$         | $>9.65 \times 10^6$     |
|                          | New Method  | 262.03                               | $1.5 \times 10^6$                 | $3.93 \times 10^5$      |

The results are given in Table 3. While the new method can be substantially more expensive per iteration, it requires many fewer iterations for convergence (i.e., mixes much better), so its overall computational time is less. For the  $k = 5$  case, the new method was 1000 times faster. But its real benefit was in the high dimensional cases: for  $k = 50$ , Metropolis simply failed to converge, and both Metropolis and Hit-and-Run failed for  $k = 100$ .

The story is told, perhaps even more clearly, by looking at the trace plots of  $L_2(\hat{\Sigma}_B, \Sigma_0)$ , for the three methods and the four cases; these are plotted in Figure 1. The much faster convergence of the new method (blue curves) is clear, as is the poor performance of Metropolis (black curves) and its utter failure in higher dimensions. Hit-and-Run (red curves) does better, converging for  $k = 50$  and getting reasonably close for  $k = 100$ ; but a much longer running time would be needed for actual convergence.

**4. Comparing the IW and SIW priors and posteriors.** In this section, we compare the IW and SIW priors and posteriors. In all sections, the two priors will have been matched to two moments, using Lemma 2.

![Figure 1: Trace plots of the three computational algorithms for k = 5, 10, 50, 100. The figure consists of four subplots: (a) k=5, (b) k=10, (c) k=50, and (d) k=100. Each subplot shows 'loss' on the y-axis versus 'iteration' on the x-axis. Three methods are compared: Metropolis (black line), Hit-and-Run (red line), and New method (blue line). In all cases, the New method converges very quickly to a stable loss value. Metropolis and Hit-and-Run show much slower convergence, with Metropolis failing to converge in the higher-dimensional cases (k=50 and k=100).](72d357d406618f3f884c3876fc3058ee_img.jpg)

Figure 1: Trace plots of the three computational algorithms for k = 5, 10, 50, 100. The figure consists of four subplots: (a) k=5, (b) k=10, (c) k=50, and (d) k=100. Each subplot shows 'loss' on the y-axis versus 'iteration' on the x-axis. Three methods are compared: Metropolis (black line), Hit-and-Run (red line), and New method (blue line). In all cases, the New method converges very quickly to a stable loss value. Metropolis and Hit-and-Run show much slower convergence, with Metropolis failing to converge in the higher-dimensional cases (k=50 and k=100).

FIG. 1. Trace plots of the three computational algorithms for  $k = 5, 10, 50, 100$ .

In Section 4.1, we look at contours of the largest and smallest eigenvalues of  $\Sigma$ , from the prior and posterior distributions. The point is to see if the eigenvalues are, indeed, considerably more spread for the IW priors and posteriors than for those of SIW.

In Section 4.2, we compare Bayes risks arising in estimating  $\Sigma$ , using either IW or SIW as the true parameter-generating prior, and then doing the Bayesian analysis under both priors. Of course, the Bayesian analysis using the true prior will be optimal, but it is instructive to see how much worse the results are under the other prior.

In Section 4.3, we consider the usual  $m > k$  situation and compare the frequentist risks of IW and SIW in a variety of situations. We also include in the risk comparison the other priors that were earlier discussed.

In Section 4.4, we investigate the  $m < k$  scenario, calling this *low rank learning*. That many fewer observations than the dimension of the covariance matrix can result in proper posteriors was a surprise, and studying the resulting posteriors is of considerable interest; can we learn anything useful about  $\Sigma$  in this situation and do certain priors result in a better job of low rank learning than others?

In all four comparisons, SIW does considerably better than IW. This is—at the same time—puzzling and expected. It is puzzling because the IW priors that are considered are proper, and hence, cannot uniformly be improved upon. Yet we seem to be unable to construct a scenario in which they do better (except that of generating from the IW prior and using it for analysis). But this is perhaps expected, in that we began the paper by saying that the eigenvalue inflation property of IW priors is counterintuitive, and our inability to create scenarios where the IW priors are better reflects this.

**4.1. Comparing eigenvalue contours for the priors and posteriors.** It is of interest to see the extent to which IW priors spread eigenvalues apart more so than do SIW priors. One way to look at this is to match the two priors via Lemma 2, and then examine contour plots of the resulting largest and smallest eigenvalues,  $\lambda_1$  and  $\lambda_k$ .

For the SIW( $a, cI_k$ ) prior, let  $f(x)$  and  $F(x)$  be the probability density and cumulative distribution function of IG( $a - 1, c/2$ ), respectively. It follows from Remark 1 that the joint density of  $(\lambda_1, \lambda_k)$  is of the form

$$(4.1) \quad \pi(\lambda_1, \lambda_k) = k(k-1)[F(\lambda_1) - F(\lambda_k)]^{k-2} f(\lambda_1) f(\lambda_k),$$

where  $\lambda_1 > \lambda_k > 0$ . For the comparison, we chose

$$(4.2) \quad E(\Sigma) = I_k \quad \text{and} \quad E(\Sigma^2) = 2I_k.$$

From Corollary 1, we get, as the matching SIW parameters,  $(a, c) = (4, 4)$  (regardless of the dimension  $k$ ). The corresponding matching IW parameters (solving in Lemma 2) are

$$(4.3) \quad \alpha = \frac{3}{2} + \frac{5}{4}k + \frac{1}{4}\sqrt{(2+k)^2 + 16} \quad \text{and} \quad \beta = 2(\alpha - k - 1).$$

We consider both  $k = 5$  and  $k = 50$  dimensional covariance matrices, for which, respectively,

$$(4.4) \quad (\alpha, \beta) = (9.7656, 7.5311) \quad \text{and} \quad (\alpha, \beta) = (77.0384, 52.0768).$$

Figure 2 shows the contour plots of the moment matched IW( $\alpha, \beta I_k$ ) and SIW( $a, cI_k$ ) prior densities of  $(\lambda_1, \lambda_k)$ , for  $k = 5$  and  $50$ . The contours for SIW( $a, cI_k$ ) are based on (4.1), while those for IW( $\alpha, \beta I_k$ ) are based on 100,000 simulated values of  $\Sigma$  from the prior. For  $k = 5$  (the left two plots), it is clear that the smallest eigenvalue,  $\lambda_k$ , is typically much smaller for IW than for SIW. The largest eigenvalue for IW is clearly typically larger than that for SIW when  $k = 5$ . For  $k = 50$  (the right two plots), the situation is somewhat muddled, because apparently the SIW prior has fatter tails than the IW prior; but note that for, say, the

![Figure 2: Contour plots of moment matched IW(a, beta I_k) and SIW(a, c I_k) prior densities of (lambda_1, lambda_k).](b05a8a3551db31147979064952179990_img.jpg)

Figure 2 consists of four contour plots arranged in a 1x4 grid, labeled (a) through (d). Each plot shows the joint density of  $\lambda_1$  (y-axis) and  $\lambda_k$  (x-axis).  
 (a) IW(7.656, 7.5311 $I_5$ ): The x-axis ranges from 0.0 to 0.8, and the y-axis ranges from 0 to 5. The contours are centered around  $\lambda_k \approx 0.3$  and  $\lambda_1 \approx 3$ .  
 (b) SIW(4, 4 $I_5$ ): The axes are the same as in (a). The contours are more spread out, centered around  $\lambda_k \approx 0.4$  and  $\lambda_1 \approx 2$ .  
 (c) IW(77.0384, 52.0768 $I_{50}$ ): The x-axis ranges from 0.10 to 0.40, and the y-axis ranges from 2 to 10. The contours are very narrow and centered around  $\lambda_k \approx 0.2$  and  $\lambda_1 \approx 6$ .  
 (d) SIW(4, 4 $I_{50}$ ): The axes are the same as in (c). The contours are more spread out, centered around  $\lambda_k \approx 0.25$  and  $\lambda_1 \approx 6$ .

Figure 2: Contour plots of moment matched IW(a, beta I\_k) and SIW(a, c I\_k) prior densities of (lambda\_1, lambda\_k).

FIG. 2. Contour plots of moment matched  $\text{IW}(\alpha, \beta I_k)$  and  $\text{SIW}(a, c I_k)$  prior densities of  $(\lambda_1, \lambda_k)$ , when  $E(\Sigma) = I_k$  and  $E(\Sigma^2) = 2I_k$  for  $k = 5$  (left two plots) and  $k = 50$  (right two plots).

central level 2 contour, it is clear that the IW largest eigenvalue tends to be much larger than that from SIW. So the figure clearly supports the presumption that IW will force the eigenvalues apart more so than will SIW.

Next, we look at posterior contour plots for the above priors. For economy of space, we only present the  $k = 50$  results; the results for  $k = 5$  exhibited the same pattern and are available in the Supplementary Material [5]. The sample sizes used are  $m = 50$  (first and fourth columns) and  $m = 200$  (second and third columns). To obtain the posteriors, the data was generated from  $I_{50}$  (compatible with the prior distributions) and  $\Sigma_{50} = \text{diag}(50, \dots, 1)$  (incompatible with the priors) by sampling  $S$  from  $\text{Wishart}_{50}(m, I_k)$  and  $\text{Wishart}_{50}(m, \Sigma_k)$ . For each of the cases, we simulate  $10^6$  values of  $\Sigma$  from the posteriors,  $\pi(\Sigma | S)$ , under the two priors.

Figure 3 presents the contour plots of posterior densities of  $(\lambda_1, \lambda_{50})$  based on these  $10^6$  points. The first row of each table presents the results for IW; the second row, those for SIW. The first two columns are with  $I_{50}$ ; the last two are with  $\Sigma_{50}$ . These figures clearly show the expected pattern:  $\lambda_1$  tends to be much larger—and  $\lambda_{50}$  much smaller—for the IW posteriors than for the SIW posteriors.

![Figure 3: Posterior contour plots for (lambda_1, lambda_k) of moment matched IW and SIW prior densities.](c222a9006d6d60a8d81e6ffbfc0e74ad_img.jpg)

Figure 3 consists of eight contour plots arranged in a 2x4 grid, labeled (a1) through (b4). Each plot shows the joint density of  $\lambda_1$  (y-axis) and  $\lambda_k$  (x-axis).  
 (a1)  $k=50, m=50, I_{50}, \text{IW}$ : The x-axis ranges from 0.0 to 0.8, and the y-axis ranges from 0 to 5. The contours are narrow and centered around  $\lambda_k \approx 0.2$  and  $\lambda_1 \approx 3.5$ .  
 (a2)  $k=50, m=200, I_{50}, \text{IW}$ : The axes are the same as in (a1). The contours are even narrower and centered around  $\lambda_k \approx 0.4$  and  $\lambda_1 \approx 3$ .  
 (a3)  $k=50, m=50, \Sigma_{50}, \text{IW}$ : The x-axis ranges from 0.0 to 1.2, and the y-axis ranges from 50 to 100. The contours are narrow and centered around  $\lambda_k \approx 0.2$  and  $\lambda_1 \approx 80$ .  
 (a4)  $k=50, m=200, \Sigma_{50}, \text{IW}$ : The axes are the same as in (a3). The contours are narrower and centered around  $\lambda_k \approx 0.6$  and  $\lambda_1 \approx 75$ .  
 (b1)  $k=50, m=50, I_{50}, \text{SIW}$ : The axes are the same as in (a1). The contours are more spread out and centered around  $\lambda_k \approx 0.3$  and  $\lambda_1 \approx 2.5$ .  
 (b2)  $k=50, m=200, I_{50}, \text{SIW}$ : The axes are the same as in (a1). The contours are more spread out and centered around  $\lambda_k \approx 0.5$  and  $\lambda_1 \approx 1.5$ .  
 (b3)  $k=50, m=50, \Sigma_{50}, \text{SIW}$ : The axes are the same as in (a3). The contours are very spread out and centered around  $\lambda_k \approx 0.4$  and  $\lambda_1 \approx 70$ .  
 (b4)  $k=50, m=200, \Sigma_{50}, \text{SIW}$ : The axes are the same as in (a3). The contours are more concentrated and centered around  $\lambda_k \approx 0.8$  and  $\lambda_1 \approx 60$ .

Figure 3: Posterior contour plots for (lambda\_1, lambda\_k) of moment matched IW and SIW prior densities.

FIG. 3. Posterior contour plots for  $(\lambda_1, \lambda_k)$  of moment matched  $\text{IW}(\alpha, \beta I_{50})$  (top) and  $\text{SIW}(a, c I_{50})$  (bottom) prior densities, when  $E(\Sigma) = I_{50}$  and  $E(\Sigma^2) = 2I_{50}$ . Here,  $k = 50$ ,  $m = 50$  or  $m = 200$ , and the true  $\Sigma$  was either  $I_{50}$  or  $\Sigma_{50} = \text{diag}(50, \dots, 1)$ .

4.2. *Comparing Bayes risks under IW and SIW priors.* We choose  $k = 5, 20, m = 2k + 3, 5k$ . For the  $IW_k(\alpha, \beta I_k)$  and  $SIW(a, cI_k)$  priors, we match

$$(4.5) \quad E(\Sigma) = I_k \quad \text{and} \quad E(\Sigma^2) = 3I_k.$$

Corollary 1 yields  $(a, c) = (3.5, 3)$  and, solving in (Lemma 2), yields  $(\alpha, \beta) = (8.3228, 4.6457)$  for  $k = 5$  and  $(\alpha, \beta) = (26.8776, 11.7552)$  for  $k = 20$ .

To compute the Bayes risks, we repeatedly draw  $\Sigma$  from the true prior (either IW or SIW), simulate  $S | \Sigma \sim \text{Wishart}_k(m, \Sigma)$ , compute the Bayes estimators for both priors for the loss  $L_2$ , from the expressions in Section 2.5 and finally compute the actual losses of the Bayes estimators. This is repeated 10,000 times, and the losses averaged to obtain an estimate of the Bayes risks, which are denoted  $r_2(\pi_T, \hat{\Sigma}_{B2}^\pi)$ ,  $\pi_T$  being the true prior,  $\pi_W$  being the other prior, and  $\pi$  being the prior used to compute the Bayes estimate  $\hat{\Sigma}_{B2}^\pi$  under that loss. Of course, the smallest risks are obtained when the true prior is used to compute the Bayes estimates, but it is useful to look at the ratio

$$\frac{r_2(\pi_T, \hat{\Sigma}_{B2}^{\pi_W})}{r_2(\pi_T, \hat{\Sigma}_{B2}^{\pi_T})},$$

where the denominator is this optimal risk for the true prior and the numerator is the Bayes risk when the wrong prior is used.

These ratios are presented in Table 4. The first entry, 1.133, shows that the SIW prior's performance is 13.3% worse than that of the IW prior, when the IW prior is the true prior. The interesting feature of this table is that the IW performance, when SIW is true, is considerably worse than the SIW performance, when IW is true. The most extreme case is when  $k = 20$  and  $m = 43$ , in which case the SIW risk is only 7.5% worse when IW is the true prior, but the IW risk is 44.8% worse when SIW is the true prior. This asymmetry strongly suggests that SIW is the more robust prior.

4.3. *Comparing risk functions for  $m \geq k$ .* We compare the frequentist risk (expected loss),  $R_2(\Sigma, \hat{\Sigma}_{B2})$ , of the Bayes estimates under the seven priors,  $\pi^R, \pi^{MR}, \pi^U, \pi^J, \pi^C$  and  $IW_k(\alpha, \beta I_k)$  and  $SIW(a, cI_k)$  as in the previous section, under loss  $L_2$  when  $m \geq k$ . The results for losses  $L_1$  and  $L_3$  exhibit the same pattern, and are available in the Supplementary Material [5]. We also consider the risk function of the best equivariant estimator,  $\hat{\Sigma}_{E2}$ , of  $\Sigma$ . From [10], the best equivariant estimator of  $\Sigma$ , under the loss function  $L_2$ , utilizing the lower triangular Cholesky decomposition  $S = KK'$ , is  $\hat{\Sigma}_{E2} = K \Lambda_{E2} K'$ , where  $\Lambda_{E2}$  is a diagonal matrix with elements  $\lambda_{2i} = (m - 1)/[(m - i - 1)(m - i)]$ ,  $i = 1, \dots, k$ .

TABLE 4  
Comparison of Bayes risks for matched SIW and IW priors (matching to  $E(\Sigma) = I_k, E(\Sigma^2) = 3I_k$ ), using first one and then the other as the truth, under  $L_2$

| Loss  | Bayes risk ratio                                                             | $k = 5$                            |          | $k = 20$                             |           |
|-------|------------------------------------------------------------------------------|------------------------------------|----------|--------------------------------------|-----------|
|       |                                                                              | $(\alpha, \beta) = (8.322, 4.645)$ |          | $(\alpha, \beta) = (26.877, 11.755)$ |           |
|       |                                                                              | $m = 13$                           | $m = 25$ | $m = 43$                             | $m = 100$ |
| $L_2$ | $\frac{r_2(IW, \hat{\Sigma}_{B2}^{SIW})}{r_2(IW, \hat{\Sigma}_{B2}^{IW})}$   | 1.133                              | 1.109    | 1.075                                | 1.033     |
|       | $\frac{r_1(SIW, \hat{\Sigma}_{B2}^{IW})}{r_1(SIW, \hat{\Sigma}_{B2}^{SIW})}$ | 1.254                              | 1.243    | 1.448                                | 1.316     |

TABLE 5

Risks (expected losses under  $L_2$ ) of Bayes estimates under the indicated priors and the equivariant estimator  $E$ , for  $k = 5, 20, m = 2k + 3, 5k, 10k$ ,  $\Sigma = I_k$ ,  $\Sigma_{k1} = \text{diag}(8k - 7, \dots, 9, 1)$ , and  $\Sigma_{k2} = \text{diag}(\lfloor \frac{k+1}{2} \rfloor - 1, \dots, 1, \frac{1}{2}, \dots, \lfloor \frac{k+1}{2} \rfloor^{-1})$

| Loss  | $k$ | $(m, \Sigma)$         | $\pi^{\text{IW}}$ | $\pi^{\text{SIW}}$ | $\pi^R$ | $\pi^{\text{MR}}$ | $\pi^U$ | $\pi^J$ | $\pi^C$ | $E$  |
|-------|-----|-----------------------|-------------------|--------------------|---------|-------------------|---------|---------|---------|------|
| $L_2$ | 5   | (13, $I_5$ )          | 0.78              | 0.23               | 0.48    | 0.47              | 0.50    | 1.74    | 7.19    | 1.51 |
|       |     | (25, $I_5$ )          | 0.54              | 0.16               | 0.23    | 0.22              | 0.23    | 0.72    | 1.04    | 0.68 |
|       |     | (50, $I_5$ )          | 0.30              | 0.09               | 0.10    | 0.10              | 0.11    | 0.33    | 0.38    | 0.32 |
|       |     | (13, $\Sigma_{k1}$ )  | 3.13              | 1.51               | 1.12    | 1.11              | 1.24    | 1.75    | 7.19    | 1.51 |
|       |     | (25, $\Sigma_{k1}$ )  | 1.07              | 0.64               | 0.55    | 0.54              | 0.57    | 0.73    | 1.04    | 0.68 |
|       |     | (50, $\Sigma_{k1}$ )  | 0.41              | 0.30               | 0.28    | 0.28              | 0.29    | 0.33    | 0.38    | 0.32 |
|       |     | (13, $\Sigma_{k2}$ )  | 0.94              | 0.85               | 1.11    | 1.09              | 1.06    | 1.76    | 7.19    | 1.51 |
|       |     | (25, $\Sigma_{k2}$ )  | 0.55              | 0.51               | 0.59    | 0.58              | 0.57    | 0.73    | 1.05    | 0.68 |
|       |     | (50, $\Sigma_{k2}$ )  | 0.29              | 0.27               | 0.30    | 0.29              | 0.29    | 0.33    | 0.38    | 0.32 |
|       |     | (43, $I_{20}$ )       | 4.27              | 0.39               | 0.56    | 0.55              | 0.50    | 7.48    | 5.20    | 6.10 |
|       | 20  | (100, $I_{20}$ )      | 2.17              | 0.19               | 0.21    | 0.21              | 0.20    | 2.45    | 3.32    | 2.29 |
|       |     | (200, $I_{20}$ )      | 1.09              | 0.10               | 0.10    | 0.10              | 0.09    | 1.13    | 1.28    | 1.09 |
|       |     | (43, $\Sigma_{k1}$ )  | 16.99             | 3.61               | 3.25    | 3.24              | 3.24    | 7.49    | 5.22    | 6.10 |
|       |     | (100, $\Sigma_{k1}$ ) | 3.66              | 1.63               | 1.60    | 1.60              | 1.60    | 2.45    | 3.32    | 2.29 |
|       |     | (200, $\Sigma_{k1}$ ) | 1.40              | 0.89               | 0.88    | 0.88              | 0.88    | 1.13    | 1.28    | 1.09 |
|       |     | (43, $\Sigma_{k2}$ )  | 5.67              | 4.85               | 5.14    | 5.14              | 4.93    | 7.48    | 20.19   | 6.10 |
|       |     | (100, $\Sigma_{k2}$ ) | 2.33              | 2.06               | 2.12    | 2.11              | 2.09    | 2.46    | 3.32    | 2.29 |
|       |     | (200, $\Sigma_{k2}$ ) | 1.12              | 1.03               | 1.05    | 1.04              | 1.04    | 1.13    | 1.28    | 1.09 |

We chose  $k = 5, 20$ ,  $m = 2k + 3, 5k, 10k$ , and evaluated the risks at the three covariance matrices  $\Sigma = I_k$ ,  $\Sigma_{k1} = \text{diag}(8k - 7, \dots, 9, 1)$  and  $\Sigma_{k2} = \text{diag}(\lfloor \frac{k+1}{2} \rfloor - 1, \dots, 1, \frac{1}{2}, \dots, \lfloor \frac{k+1}{2} \rfloor^{-1})$ , where  $\lfloor \cdot \rfloor$  is a floor function. The identity covariance matrix is completely compatible with the IW and SIW priors, but might be thought to favor SIW, since the eigenvalues are the same. The second covariance matrix is completely incompatible with the IW and SIW priors, and serves to measure the robustness of the priors to misspecification of their inputs. The third covariance matrix is reasonably compatible with the IW and SIW priors, but has spread eigenvalues and so was thought to perhaps favor the IW prior.

The risks of the seven Bayesian estimators, together with that of  $\hat{\Sigma}_{E2}$ , are given in Table 5. They were computed by averaging the losses over 3000 draws of  $S \sim \text{Wishart}_k(m, \Sigma)$  and using  $2 \times 10^5$  posterior draws to compute  $\hat{\Sigma}_{B2}$ . Some observations from the table:

- SIW always has smaller risk than IW—often by a large margin—even for  $\Sigma_{k2}$ , which was included as a guess of a covariance matrix that would be better for IW.
- The constant prior is almost always the worst; this is yet another warning that this commonly used prior is problematical.
- Of the objective priors,  $\pi^{\text{MR}}$  and  $\pi^R$  are very close, with  $\pi^{\text{MR}}$  being slightly better. But, surprisingly,  $\pi^U$  is a strong competitor, being modestly better and worse than  $\pi^{\text{MR}}$ , in roughly equal proportions.
- The Jeffreys prior was decidedly inferior.
- While SIW could be expected to be optimal (and was) in estimating the identity matrix, its strong performance for the other two covariance matrices was unexpected. Especially surprising were the results for  $\Sigma_{k1}$ , which was far out in the tails of the SIW prior, and yet the risks using SIW were only moderately higher than those using  $\pi^{\text{MR}}$ .

4.4. *Low rank learning.* When the sample size  $m$  is smaller than  $k$ , we saw that the posterior distributions of  $\Sigma$  could be proper under the priors  $\text{IW}_k(\alpha, \beta I_k)$ ,  $\text{SIW}(a, c I_k)$ ,  $\pi^{\text{MR}}$

and  $\pi^U$ . Clearly, such posteriors cannot illuminate all of  $\Sigma$  (we know that at least  $m$  observations are needed to “identify”  $\Sigma$ ), but the posteriors might be able to illuminate some features of  $\Sigma$ . This is explored in Section 4.4.1.

The low rank case is also an interesting domain in which to investigate estimation risks of the various priors, as low rank might be expected to exacerbate problems with a prior. This is studied in Section 4.4.2.

**4.4.1. Posterior distributions of features of  $\Sigma$ .** We consider here the largest eigenvalue,  $\lambda_1$ , and the trace,  $\text{tr}(\Sigma)$ ; these were chosen as often being of interest and because they were representative of two extremes involving low rank learning. To challenge the possibility of learning features of the posteriors under the four priors, we chose  $k = 100$  with much smaller sample sizes. For the  $\text{IW}_k(\alpha, \beta I_k)$  and  $\text{SIW}(a, cI_k)$  priors, we follow (4.5) in Section 4.3, and set  $(a, c) = (3.5, 3)$  and (solving in Lemma 2)  $(\alpha, \beta) = (126.78, 51.56)$ .

For the true  $\Sigma_1 = I_k$  (compatible with IW and SIW) and  $\Sigma_k = \text{diag}(k, \dots, 1)$  (not compatible with IW and SIW), we sample  $S$  from  $\text{Wishart}_k(m, \Sigma_j)$ , for  $j = 1, 2$  and  $m = 5, 20, 100$ . Then we generate  $2 \times 10^5$  posterior samples of  $\Sigma$  given  $S$  under the IW, SIW,  $\pi^{\text{MR}}$  and  $\pi^U$  priors. Table 6 summarizes the corresponding posterior means and standard deviations of  $\lambda_1$  and  $\text{tr}(\Sigma)$ , under the four priors.

None of the posteriors for  $\lambda_1$  are accurate, in the sense of the mean being close to the true value and the mean plus or minus two standard deviations covering the true value. For  $\text{tr}(\Sigma)$ , however, many of the posteriors are reasonably accurate especially those from SIW, covering the true value in four of the six cases, and only missing moderately in the other two cases.

We repeated this exercise with numerous other features of  $\Sigma$ , and the above results seemed to generalize. One cannot use low rank learning effectively with individual elements of  $\Sigma$ —such as variances, covariances or eigenvalues—but overall properties of  $\Sigma$ —such as the trace or determinant—are approachable with low rank learning.

**4.4.2. Comparison of estimation risks under loss  $L_2$ .** We next compare the risks,  $R_2(\Sigma, \hat{\Sigma}_{B2})$ , in lower rank learning under loss  $L_2$  under the five priors  $\text{IW}_k(\alpha, \beta I_k)$ ,  $\text{SIW}(3.5, 3I_k)$ ,  $\pi^R$ ,  $\pi^{\text{MR}}$  and  $\pi^U$ . We fix  $m = 5$  and choose  $k = 5$  (for which the matching

TABLE 6

Posterior means and standard deviations of  $\lambda_1$  and  $\text{tr}(\Sigma)$  under  $\text{IW}(126.78, 51.56I_k)$ ,  $\text{SIW}(3.5, 3I_k)$   $\pi^{\text{MR}}$  and  $\pi^U$  priors, for  $k = 100$ ,  $m = 5, 20, 100$  and  $\Sigma = I_k$  and  $\Sigma_k = \text{diag}(k, k - 1, \dots, 1)$

| $\Sigma$   | Feature of $\Sigma$        | $m$ | IW    |       | SIW   |     | $\pi^{\text{MR}}$ |      | $\pi^U$ |        |
|------------|----------------------------|-----|-------|-------|-------|-----|-------------------|------|---------|--------|
|            |                            |     | Mean  | sd    | Mean  | sd  | Mean              | sd   | Mean    | sd     |
| $I_k$      | $\lambda_1 = 1$            | 5   | 5.2   | 0.47  | 5.9   | 2.7 | 22.0              | 23.7 | 147.6   | 1112   |
|            |                            | 20  | 5.0   | 0.43  | 4.2   | 1.1 | 7.5               | 1.9  | 6.4     | 1.9    |
|            |                            | 100 | 4.1   | 0.27  | 2.2   | 0.3 | 2.3               | 0.3  | 2.4     | 0.3    |
|            | $\text{tr}(\Sigma) = 100$  | 5   | 100.2 | 1.93  | 101.8 | 6.4 | 172.8             | 33.6 | 517     | 1122   |
|            |                            | 20  | 99.9  | 1.80  | 99.7  | 3.5 | 110.7             | 6.4  | 124     | 6.1    |
|            |                            | 100 | 99.4  | 1.31  | 98.9  | 1.5 | 100.9             | 1.6  | 103     | 1.6    |
| $\Sigma_k$ | $\lambda_1 = 100$          | 5   | 80    | 9.55  | 997   | 438 | 2339              | 2470 | 7567    | 40,000 |
|            |                            | 20  | 216   | 28.78 | 401   | 87  | 395               | 105  | 342     | 100    |
|            |                            | 100 | 161   | 12.39 | 167   | 24  | 173               | 25   | 176     | 26     |
|            | $\text{tr}(\Sigma) = 5050$ | 5   | 344   | 16.93 | 3015  | 711 | 8923              | 3160 | 26,668  | 41,231 |
|            |                            | 20  | 1511  | 68.60 | 4491  | 301 | 5726              | 339  | 6437    | 318    |
|            |                            | 100 | 2509  | 42.21 | 4781  | 82  | 5070              | 89   | 5175    | 90     |

TABLE 7  
Risks (expected losses using  $L_2$ ) for  $\pi^{\text{IW}}, \pi^{\text{SIW}}, \pi^{\text{MR}}, \pi^R$  and  $\pi^U$ , when  $m = 5, k = 5, 20$  and  $\Sigma = I_k$  or  $\Sigma_{1k} \equiv \text{diag}(8k - 7, \dots, 9, 1)$

| $(k, \Sigma)$       | $\pi^{\text{IW}}$ | $\pi^{\text{SIW}}$ | $\pi^R$ | $\pi^{\text{MR}}$ | $\pi^U$ |
|---------------------|-------------------|--------------------|---------|-------------------|---------|
| $(5, I_5)$          | 0.7457            | 0.2422             | 29.6682 | 3.7089            | 3.6429  |
| $(5, \Sigma_{1k})$  | 6.6057            | 2.3119             | 39.3877 | 5.9465            | 5.5438  |
| $(20, I_{20})$      | 1.9201            | 0.4720             | NA      | 6.9858            | 15.3567 |
| $(20, \Sigma_{1k})$ | 157.7758          | 37.0476            | NA      | 12.9270           | 22.6516 |

$(\alpha, \beta) = (8.3228, 4.6457)$ ) and  $k = 20$   $((\alpha, \beta) = (26.8776, 11.755))$  and  $\Sigma = I_k$  (compatible with the prior information) and  $\Sigma_{1k} = \text{diag}(8k - 7, \dots, 9, 1)$  (not compatible).

The risks of the Bayes estimators are given in Table 7 and were obtained by averaging the expected losses over 3000 draws of  $S \sim \text{Wishart}_k(m, \Sigma)$ , and utilizing  $2 * 10^5$  posterior draws, for each given  $S$ , to compute the Bayes estimate. The performance of SIW continues to impress, soundly beating IW, and even beating the objective priors, except when  $k = 20$  and  $\Sigma_{1k}$  (a matrix far in the tail of the SIW prior) is the true covariance matrix.

**5. Generalizations.** While we were just considering the vanilla covariance matrix problem here, there have been many generalizations of the vanilla IW prior to structured IW priors, especially in high dimensions ([29] and [27] being two examples). A major difficulty in similar extensions of the SIW prior is that marginal and some conditional distributions are considerably more difficult to work with for the SIW priors; in particular, the marginal distribution of a diagonal block of  $\Sigma$  does not have a SIW distribution (a diagonal block of an IW distribution is IW).

At one level, generalizing a highly structured IW prior to a highly structured SIW prior is trivial; just replace every IW component in the IW prior with a SIW component. But important interconnections between the IW components or important update considerations could be destroyed by this. Thus one would need to go through each structured IW scenario carefully, determining the extent to which IW could be replaced by SIW. Such an exploration is beyond the scope of this paper.

There is also much more work that could be done involving low rank learning. The key, however, is finding a structured way to investigate the problem. For instance, one could consider the  $k > m$  scenario, with  $m$  growing, but the focus now being on low rank learning without sparsity assumptions. Perhaps consistency results (e.g., for the trace of  $\Sigma$ ) are available.

## APPENDIX

**A.1. Proofs of Theorem 1 and Lemma 1.** We will need the following lemmas.

**LEMMA 4.** Let  $R = (r_{ij})$  be  $I \times J$  random matrix, whose element  $r_{ij}$  is a function of  $\Gamma \Lambda \Gamma'$  with final integral with respect to  $(\Lambda, \Gamma)$ . Then

$$\int \int R \mathbf{1}_{\{\lambda_1 > \dots > \lambda_k\}} d\Lambda d\Gamma = \frac{1}{k!} \int \int R d\Lambda d\Gamma.$$

**PROOF.** For any given  $(i, j)$ , by Lemma 3.4 in [2],

$$\int \int r_{ij} \mathbf{1}_{\{\lambda_1 > \dots > \lambda_k\}} d\Lambda d\Gamma = \frac{1}{k!} \int \int r_{ij} d\Lambda d\Gamma.$$

The proof is complete.  $\square$

LEMMA 5. Let  $X$  be a random variable and  $f_i$  be a nonnegative function satisfying  $\sum_{i=1}^k f_i(x) = C$  for any  $x \in \Omega$ . If all  $g_i$ 's are monotone increasing or decreasing on  $[0, C]$ ,

$$(A.1) \quad E\left(\prod_{i=1}^k g_i(f_i(X))\right) \leq \prod_{i=1}^k E(g_i(f_i(X))).$$

PROOF. It is enough to show the result for  $k = 2$ . In fact, for any  $x_1$  and  $x_2 \in \Omega$ , we have  $[g_1(f_1(x_1)) - g_1(f_1(x_2))][g_2(f_2(x_1)) - g_2(f_2(x_2))] \leq 0$ . Therefore,  $E[g_1(f_1(X_1)) - g_1(f_1(X_2))][g_2(f_2(X_1)) - g_2(f_2(X_2))] \leq 0$ , which implies that

$$(A.2) \quad E[g_1(f_1(X))g_2(f_2(X))] \leq E[g_1(f_1(X))]E[g_2(f_2(X))].$$

This proves the result for  $k = 2$ .  $\square$

**Proof of Theorem 1.** First, we consider the sufficient conditions of parts (a) and (b). From (2.4), we get

$$\int \pi^{\text{SIW}}(\Sigma) d\Sigma = \int \int |\Lambda|^{-a} \text{etr}\left(-\frac{1}{2}\Lambda^{-1}\Gamma' H \Gamma\right) 1_{[\lambda_1 > \dots > \lambda_k]} d\Lambda d\Gamma.$$

It follows from Lemma 4 that

$$\int \pi^{\text{SIW}}(\Sigma) d\Sigma = \frac{1}{k!} \int \int |\Lambda|^{-a} \text{etr}\left(-\frac{1}{2}\Lambda^{-1}\Gamma' H \Gamma\right) d\Lambda d\Gamma.$$

Write  $H = Z\Delta Z'$ , where  $Z$  is an orthogonal matrix and  $\Delta = \text{diag}\{\delta_1, \dots, \delta_p, 0, \dots, 0\}$  and  $\delta_1 \geq \dots \geq \delta_p > 0$ . We define  $T = (t_{ij}) = \Gamma'Z$ . Clearly,  $\text{tr}(\Lambda^{-1}\Gamma' H \Gamma) = \text{tr}(\Lambda^{-1}\Gamma' Z \Delta Z' \Gamma) = \text{tr}(\Lambda^{-1}T \Delta T')$ . Then

$$\int \pi^{\text{SIW}}(\Sigma) d\Sigma = \frac{1}{k!} \int \int |\Lambda|^{-a} \text{etr}\left(-\frac{1}{2}\Lambda^{-1}T \Delta T'\right) d\Lambda dT.$$

For  $i = 1, \dots, k$ , let  $\tilde{t}_i = (t_{i1}, \dots, t_{ip})'$  be the first  $p$  components of the  $i$ th row of  $T$ . Then

$$\begin{aligned} \int \pi^{\text{SIW}}(\Sigma) d\Sigma &= \frac{1}{k!} \int \int |\Lambda|^{-a} \exp\left\{-\frac{1}{2} \sum_{i=1}^k \frac{\sum_{j=1}^p \delta_j t_{ij}^2}{\lambda_i}\right\} d\Lambda dT \\ (A.3) \quad &\leq \frac{1}{k!} \int \int |\Lambda|^{-a} \exp\left\{-\frac{\delta_p}{2} \sum_{i=1}^k \frac{\|\tilde{t}_i\|^2}{\lambda_i}\right\} d\Lambda dT. \end{aligned}$$

If  $p = k$ ,  $\|\tilde{t}_i\| = 1$  and  $\int dT = 1$ . From (A.3), it yields

$$(A.4) \quad \int \pi^{\text{SIW}}(\Sigma) d\Sigma \leq \frac{1}{k!} \int \prod_{i=1}^k \lambda_i^{-a} \exp\left\{-\frac{\delta_k}{2} \sum_{i=1}^k \frac{1}{\lambda_i}\right\} d\Lambda,$$

which is proper if  $a > 1$ .

Next, we consider the case when  $0 < p < k$ . From (A.3), if  $a > 1$ , note that

$$\begin{aligned} \int \pi^{\text{SIW}}(\Sigma) d\Sigma &\leq \frac{1}{k!} \int \left[ \prod_{i=1}^k \int_0^\infty \lambda_i^{-a} \exp\left\{-\frac{\delta_p}{2} \frac{\|\tilde{t}_i\|^2}{\lambda_i}\right\} d\lambda_i \right] dT \\ (A.5) \quad &\leq C \int \prod_{i=1}^k \|\tilde{t}_i\|^{-2(a-1)} dT, \end{aligned}$$

where  $C = \frac{1}{k!}(\delta_p/2)^{-k(a-1)}[\Gamma(a-1)]^k$ . By Lemma 5, since  $\|\tilde{t}_1\|^2 + \dots + \|\tilde{t}_k\|^2 = p$ , it yields

$$(A.6) \quad \int \pi^{\text{SIW}}(\Sigma) d\Sigma \leq C \prod_{i=1}^k \int \|\tilde{t}_i\|^{-2(a-1)} dT = C \left( \int \|\tilde{t}_k\|^{-2(a-1)} dT \right)^k.$$

It suffices to verify that  $\int \|\tilde{t}_k\|^{-2(a-1)} dT$  is finite. Note that

$$T = (T_{12} T_{13} \dots T_{1k})(T_{23} \dots T_{2k}) \dots (T_{k-1,k}) \Lambda_\epsilon,$$

where  $T_{ij}$  is a simple orthogonal matrix such as

$$(A.7) \quad T_{ij} = T_{ij}(\theta_{ij}) = \begin{pmatrix} I & 0 & 0 & 0 & 0 \\ 0 & \cos \theta_{ij} & 0 & -\sin \theta_{ij} & 0 \\ 0 & 0 & I & 0 & 0 \\ 0 & \sin \theta_{ij} & 0 & \cos \theta_{ij} & 0 \\ 0 & 0 & 0 & 0 & I \end{pmatrix}.$$

Here,  $-\pi/2 < \theta_{ij} \leq \pi/2$  and  $\Lambda_\epsilon$  being a diagonal matrix with diagonal elements 1 or  $-1$  (see [1]). It follows from [1] that the Jacobian is

$$\left| \frac{\partial T}{\prod_{i < j} \partial \theta_{ij}} \right| = \prod_{i=1}^{k-1} \prod_{j=i+1}^p \cos^{j-i-1} \theta_{ij}.$$

Define  $\Omega = \{-\frac{\pi}{2} \leq \theta_{ij} \leq \pi/2, i < j\}$ . Therefore, we get

$$(A.8) \quad \int \|\tilde{t}_k\|^{-2(a-1)} dT = \int_{\Omega} \|\tilde{t}_k\|^{-2(a-1)} \left( \prod_{i=1}^{k-1} \prod_{j=i+1}^k \cos^{j-i-1} \theta_{ij} d\theta_{ij} \right)$$

$$(A.9) \quad \leq \int_{\Omega} \|\tilde{t}_k\|^{-2(a-1)} \left( \prod_{i=1}^{k-1} \prod_{j=i+1}^k d\theta_{ij} \right).$$

For  $i < j < l < k$ , it is easy to verify  $T_{ik} T_{jl} = T_{jl} T_{ik} = T_{ik} + T_{jl} - I_k$ . Using the relationship, it yields

$$T = \left( \prod_{j=l+1}^{k-2} \prod_{i=j+1}^{k-1} T_{jl} \right) \left( \prod_{i=1}^k T_{ik} \right) \Lambda_\epsilon.$$

Note that, the  $k$ th row of  $\prod_{j=l+1}^{k-2} \prod_{i=j+1}^{k-1} T_{jl}$  is  $(0, 0, \dots, 0, 1)$  and the  $k$ th row of  $\prod_{i=1}^k T_{ik}$  is

$$(A.10) \quad \left( \sin \theta_{1k}, \sin \theta_{2k} \cos \theta_{1k}, \dots, \sin \theta_{k-1,k} \prod_{i=1}^{k-2} \cos \theta_{ik}, \prod_{i=1}^{k-1} \cos \theta_{ik} \right).$$

Therefore,  $\|\tilde{t}_k\|^2$  is the sum of squares of the first  $p$  components of (A.10), that is,

$$(A.11) \quad \begin{aligned} \|\tilde{t}_k\|^2 &= \sin^2 \theta_{1k} + \cos^2 \theta_{1k} \sin^2 \theta_{2k} + \dots + \left( \prod_{i=1}^{p-1} \cos^2 \theta_{ik} \right) \sin^2 \theta_{pk} \\ &= 1 - \prod_{i=1}^p \cos^2 \theta_{ik}. \end{aligned}$$

Defining  $\Omega_k = \{(\theta_{1k}, \dots, \theta_{pk}) : 0 \leq \theta_{ik} \leq \pi/2, i = 1, \dots, p\}$ , (A.9) implies

$$\int \|\tilde{t}_k\|^{-2(a-1)} dT \leq 2^p \int_{\Omega_k} \|\tilde{t}_k\|^{-2(a-1)} \prod_{i=1}^p d\theta_{ik}.$$

From (A.11), it yields

$$\begin{aligned} \|\tilde{t}_k\|^2 &\geq 1 - \left( \prod_{i=1}^p \cos^2 \theta_{ik} \right)^{\frac{1}{p}} \geq \frac{p}{p} - \frac{1}{p} (\cos^2 \theta_{1k} + \cdots + \cos^2 \theta_{pk}) \\ (A.12) \qquad \qquad \qquad &= \frac{1}{p} (\sin^2 \theta_{1k} + \sin^2 \theta_{2k} + \cdots + \sin^2 \theta_{pk}). \end{aligned}$$

The second step follows the mean value inequality. Therefore, it yields that

$$\int_{\Omega_k} \|\tilde{t}_k\|^{-2(a-1)} \prod_{i=1}^p d\theta_{ik} \leq 2^p p^{a-1} \int_{\Omega_0} \frac{\prod_{i=1}^p d\theta_{ik}}{(\sin^2 \theta_{1k} + \cdots + \sin^2 \theta_{pk})^{a-1}},$$

where  $\Omega_0 = \{0 \leq \theta_{ik} \leq \pi/4, i \leq p\}$ . If  $p = 1$ , define  $x = \sin \theta_{1k}$ , so  $d\theta_{1k} = \sqrt{1-x^2} dx$ , and

$$\int_{\Omega_k} \|\tilde{t}_k\|^{-2(a-1)} d\theta_{1k} \leq 2 \int_0^{\frac{\pi}{4}} (\sin \theta_{1k})^{-2(a-1)} d\theta_{1k} \leq \int_0^1 x^{-2(a-1)} (1-x)^{-1/2} dx,$$

which is finite if  $a < 3/2$ . For  $p > 1$ , we make the transformations  $x_i = \sin \theta_{ik}$  for  $i = 1, \dots, p$ , and get

$$\begin{aligned} (A.13) \qquad \qquad \qquad \int_{\Omega_k} \|\tilde{t}_k\|^{-2(a-1)} \prod_{i=1}^p d\theta_{ik} &\leq 2^{\frac{3p}{2}} p^{a-1} \int_{\{x_1^2 + \cdots + x_p^2 \leq p, x_i \geq 0, i \leq p\}} \frac{1}{(x_1^2 + \cdots + x_p^2)^{a-1}} \prod_{i=1}^p dx_i. \end{aligned}$$

Let  $z = x_1^2 + \cdots + x_p^2$  and  $y_i = x_i^2/z$  for  $i < p$ . From (A.13), we have

$$\begin{aligned} &\int_{\Omega_k} \|\tilde{t}_k\|^{-2(a-1)} \prod_{i=1}^p d\theta_{ik} \\ &\leq 2^{\frac{3p}{2}} p^a \int_0^p z^{-a+\frac{p}{2}} dz \int_{\{y_i > 0, y_1 + \cdots + y_{p-1} < 1\}} \left( 1 - \sum_{i=1}^{p-1} y_i \right)^{-\frac{1}{2}} \prod_{i=1}^{p-1} y_i^{-\frac{1}{2}} dy_i, \end{aligned}$$

which is finite if  $a < \frac{p}{2} + 1$ . The proof of the sufficient condition is completed.

For the necessary condition of parts (a) and (b), note that

$$\int \pi^{\text{SIW}}(\boldsymbol{\Sigma}) d\boldsymbol{\Sigma} \geq \frac{1}{k!} \int \left[ \prod_{i=1}^k \int_0^\infty \lambda_i^{-a} \exp \left\{ -\frac{\delta_i}{2} \frac{\|\tilde{t}_i\|^2}{\lambda_i} \right\} d\lambda_i \right] d\mathbf{T},$$

the integration with respect to  $d\boldsymbol{\Lambda}$  is infinite if  $a \leq 1$ . Furthermore, if  $0 < p < k$ , note that  $\|\tilde{t}_i\|^2 \leq 1$  and  $a > 1$ . Then we get

$$\int \pi^{\text{SIW}}(\boldsymbol{\Sigma}) d\boldsymbol{\Sigma} \geq C_1 \int \prod_{i=1}^k \|\tilde{t}_i\|^{-2(a-1)} d\mathbf{T} \geq C_1 \int \|\tilde{t}_k\|^{-2(a-1)} d\mathbf{T},$$

where  $C_1 = (k!)^{-1} (\delta_1/2)^{-k(a-1)} \Gamma^k(a-1)$ . Define  $\Omega_1 = \{0 \leq \theta_{ij} \leq \pi/4, i < j\}$ , from (A.8), we have

$$\int \|\tilde{t}_k\|^{-2(a-1)} d\mathbf{T} \geq 2^{-k(k-1)} \int_{\Omega_1} \|\tilde{t}_k\|^{-2(a-1)} \left( \prod_{i=1}^{k-1} \prod_{j=i+1}^k d\theta_{ij} \right).$$

From (A.11), we have  $\|\tilde{t}_k\|^2 \leq \sum_{i=1}^p \sin^2 \theta_{ik}$ . Therefore,

$$\begin{aligned} \int \pi^{\text{SIW}}(\Sigma) d\Sigma &\geq 2^{-k(k-1)} C_1 \int_{\Omega_1} \frac{\prod_{i=1}^{k-1} \prod_{j=i+1}^k d\theta_{ij}}{(\sin^2 \theta_{1k} + \dots + \sin^2 \theta_{pk})^{a-1}} \\ (A.14) \qquad \qquad \qquad &\geq 2^{-k(k-1)} C_1 \int_{\Omega_0} \frac{\prod_{i=1}^p d\theta_{ik}}{(\sin^2 \theta_{1k} + \dots + \sin^2 \theta_{pk})^{a-1}}. \end{aligned}$$

By an argument similar to that for proving sufficiency, (A.14) is infinite if  $a \geq 1 + p/2$ .

PROOF OF LEMMA 1. If  $p = 0$ , or  $p = k$ , Lemma 1 holds. For  $1 < p < k$ , write  $H = O'DO$ , where  $O$  is orthogonal matrix, and  $D$  is diagonal matrix with last  $p$  diagonal elements greater than 0, and the rest 0. Clearly,  $r_0 = \text{rank}(D + O\tilde{S}O')$ . The matrices  $D$ ,  $O\tilde{S}O'$  and  $O\Sigma O'$  can be partitioned as

$$D = \begin{pmatrix} D_1 & 0 \\ 0 & D_2 \end{pmatrix}, \quad O\tilde{S}O' = \begin{pmatrix} \tilde{S}_{11} & \tilde{S}_{12} \\ \tilde{S}'_{12} & \tilde{S}_{22} \end{pmatrix}, \quad O\Sigma O' = \begin{pmatrix} \tilde{\Sigma}_{11} & \tilde{\Sigma}_{12} \\ \tilde{\Sigma}'_{12} & \tilde{\Sigma}_{22} \end{pmatrix},$$

where  $D_1$ ,  $\tilde{S}_{11}$  and  $\tilde{\Sigma}_{11}$  are  $m \times m$  diagonal matrices.  $\tilde{S}_{11} \sim \text{Wishart}_m(m, \tilde{\Sigma}_{11})$ , so  $\text{rank}(\tilde{S}_{11}) = m$  with probability one. Note that

$$D + O\tilde{S}O' = \begin{pmatrix} D_1 + \tilde{S}_{11} & \tilde{S}_{12} \\ S'_{12} & D_2 + \tilde{S}_{22} \end{pmatrix},$$

and

$$\begin{aligned} &\begin{pmatrix} I_m & 0 \\ -S'_{12}(D_1 + \tilde{S}_{11})^{-1} & I_{k-m} \end{pmatrix} \begin{pmatrix} D_1 + \tilde{S}_{11} & \tilde{S}_{12} \\ S'_{12} & D_2 + \tilde{S}_{22} \end{pmatrix} \begin{pmatrix} I_m & -(D_1 + \tilde{S}_{11})^{-1}\tilde{S}_{12} \\ 0 & I_{k-m} \end{pmatrix} \\ &= \begin{pmatrix} D_1 + \tilde{S}_{11} & 0 \\ 0 & D_2 + \Phi \end{pmatrix}, \end{aligned}$$

where  $\Phi = \tilde{S}_{22} - \tilde{S}'_{12}(D_1 + \tilde{S}_{11})^{-1}\tilde{S}_{12}$ . Since  $\text{rank}(O\Sigma O') = \text{rank}(\tilde{S}_{11}) = m$ ,  $\text{rank}(\tilde{S}_{22} - \tilde{S}'_{12}\tilde{S}_{11}^{-1}\tilde{S}_{12}) = \text{rank}(O\Sigma O') - \text{rank}(\tilde{S}_{11}) = 0$  with probability one. Therefore,  $\Phi$  is nonnegative definite, and

$$r_0 = \text{rank}(D_1 + \tilde{S}_{11}) + \text{rank}(D_2 + \Phi) \geq m + \text{rank}(D_2).$$

Since  $\text{rank}(D_2) = \min(k - m, p)$ ,  $r_0 \geq \min[k, m + p]$ . It is clear that  $r_0 \leq \min[k, \text{rank}(H) + \text{rank}(S)] = \min[k, m + p]$ . The lemma is proved.  $\square$

A.2. Proof of Theorem 3. From Theorem 2,  $E(\Sigma^q | Y)$  exists. From Lemma 4, we have

$$E(\Sigma^q) = \frac{\int \int \Gamma \Lambda^q \Gamma' |\Lambda|^{-a} \text{etr}(-\frac{1}{2} \Lambda^{-1} \Gamma' H \Gamma) d\Lambda d\Gamma}{\int \int |\Lambda|^{-a} \text{etr}(-\frac{1}{2} \Lambda^{-1} \Gamma' H \Gamma) d\Lambda d\Gamma}.$$

Recall  $H = Z\Delta Z'$ , we define  $T = Z'T$ . Then  $\Gamma \Lambda^q \Gamma' = Z T \Lambda^q T' Z'$  and  $E(\Sigma^q) = Z \Phi Z'$ , where

$$\Phi = \frac{\int \int T \Lambda^q T' \prod_{i=1}^k \lambda_i^{-a} \text{etr}(-\frac{1}{2} \Lambda^{-1} T' \Delta T) d\Lambda dT}{\int \int \prod_{i=1}^k \lambda_i^{-a} \text{etr}(-\frac{1}{2} \Lambda^{-1} T' \Delta T) d\Lambda dT}.$$

We now show that  $\Phi$  is diagonal. In fact, for  $i \neq i'$ , we have

$$\Phi(i, i') = \sum_{h=1}^k \frac{\int \int h^q t_h t_{h'} \prod_{i=1}^k \lambda_i^{-a} \exp\{-\sum_{j=1}^k \frac{\|\tilde{t}_j\|^2}{2\lambda_j}\} d\Lambda dT}{\int \int \prod_{i=1}^k \lambda_i^{-a} \exp\{-\sum_{j=1}^k \frac{\|\tilde{t}_j\|^2}{2\lambda_j}\} d\Lambda dT}.$$

For any given  $\Lambda$ , we have

$$\begin{aligned} & \int t_{ih} t_{i'h} \prod_{i=1}^k \exp \left\{ - \sum_{j=1}^k \frac{\|\tilde{t}_j\|^2}{2\lambda_j} \right\} dT \\ &= \left\{ \int_{t_{ih}t_{i'h}>0} + \int_{t_{ih}t_{i'h}<0} \right\} t_{ih} t_{i'h} \prod_{i=1}^k \exp \left\{ - \frac{\|\tilde{t}_j\|^2}{2\lambda_j} \right\} dT = 0. \end{aligned}$$

Thus the off diagonal elements are 0. For the  $(i, i)$ th diagonal element of  $\Phi$ ,

$$\begin{aligned} \Phi(i, i) &= \sum_{h=1}^k \frac{\int \int \lambda_h^q t_{ih}^2 \prod_{i=1}^k \lambda_i^{-a} \exp \{ - \sum_{j=1}^k \frac{\|\tilde{t}_j\|^2}{2\lambda_j} \} d\Lambda dT}{\int \int \prod_{i=1}^k \lambda_i^{-a} \exp \{ - \sum_{j=1}^k \frac{\|\tilde{t}_j\|^2}{2\lambda_j} \} d\Lambda dT} \\ &= \frac{\Gamma(a - q - 1)}{2^q \Gamma(a - 1)} \sum_{h=1}^k \frac{\int t_{ih}^2 \|\tilde{t}_h\|^{2q} \prod_{j=1}^k \|\tilde{t}_j\|^{-2(a-1)} dT}{\int \prod_{j=1}^k \|\tilde{t}_j\|^{-2(a-1)} dT} = \phi_{q,i}. \end{aligned}$$

The last equality holds since the integration in the numerator is equal for each  $h = 1, \dots, k$ . The theorem is proved.

**Acknowledgments.** J. O. Berger is supported by US NSF Grant DMS-1407775. J. O. Berger and C. Sun are supported in part by Chinese 111 Project B14019 and Chinese NSF Grant 11671147. C. Sun is also a professor at East China Normal University.

Dongchu Sun is also affiliated with the School of Statistics, East China Normal University.

## SUPPLEMENTARY MATERIAL

**Supplement to “Bayesian analysis of the covariance matrix of a multivariate normal distribution with a new class of priors”** (DOI: 10.1214/19-AOS1891SUPP; .pdf). The results for  $L_1$  and  $L_3$  are in the Supplementary Material.

## REFERENCES

- [1] ANDERSON, T. W., OLKIN, I. and UNDERHILL, L. G. (1987). Generation of random orthogonal matrices. *SIAM J. Sci. Statist. Comput.* **8** 625–629. MR0892309 <https://doi.org/10.1137/0908055>
- [2] BERGER, J. O., STRAWDERMAN, W. and TANG, D. (2005). Posterior propriety and admissibility of hyperpriors in normal hierarchical models. *Ann. Statist.* **33** 606–646. MR2163154 <https://doi.org/10.1214/00905360500000075>
- [3] BERGER, J. O. and SUN, D. (2008). Objective priors for the bivariate normal model. *Ann. Statist.* **36** 963–982. MR2396821 <https://doi.org/10.1214/07-AOS501>
- [4] BERGER, J. O., SUN, D. and SONG, C. (2020). An objective prior for hyperparameters in normal hierarchical models. *J. Multivariate Anal.* To appear.
- [5] BERGER, J. O., SUN, D. and SONG, C. (2020). Supplement to “Bayesian analysis of the covariance matrix of a multivariate normal distribution with a new class of priors.” <https://doi.org/10.1214/19-AOS1891SUPP>.
- [6] CHEN, M.-H. and SCHEMSER, B. (1993). Performance of the Gibbs, hit-and-run, and Metropolis samplers. *J. Comput. Graph. Statist.* **2** 251–272. MR1272394 <https://doi.org/10.2307/1390645>
- [7] DANIELS, M. J. and KASS, R. E. (1999). Nonconjugate Bayesian estimation of covariance matrices and its use in hierarchical models. *J. Amer. Statist. Assoc.* **94** 1254–1263. MR1731487 <https://doi.org/10.2307/2669939>
- [8] DANIELS, M. J. and KASS, R. E. (2001). Shrinkage estimators for covariance matrices. *Biometrics* **57** 1173–1184. MR1950425 <https://doi.org/10.1111/j.0006-341X.2001.01173.x>
- [9] DEY, D. K. and SRINIVASAN, C. (1985). Estimation of a covariance matrix under Stein’s loss. *Ann. Statist.* **13** 1581–1591. MR0811511 <https://doi.org/10.1214/aos/1176349756>
- [10] EATON, M. L. and OLKIN, I. (1987). Best equivariant estimators of a Cholesky decomposition. *Ann. Statist.* **15** 1639–1650. MR0913579 <https://doi.org/10.1214/aos/1176350615>

- [11] EGUCHI, N., SAITO, R., SAEKI, T., NAKATSUKA, Y., BELIKOV, D. and MAKSYUTOV, S. (2010). A priori covariance estimation for CO<sub>2</sub> and CH<sub>4</sub> retrievals. *J. Geophys. Res.* **115** Art. ID D10215.
- [12] FARRELL, R. H. (1985). *Multivariate Calculation: Use of the Continuous Groups. Springer Series in Statistics*. Springer, New York. MR0770934 <https://doi.org/10.1007/978-1-4613-8528-8>
- [13] FREI, M. and KUNSCH, H. R. (2012). Sequential state and observation noise covariance estimation using combined ensemble Kalman and particle filters. *Mon. Weather Rev.* **140** 1476–1495.
- [14] GELMAN, A. and RUBIN, D. B. (1992). Inference from iterative simulation using multiple sequences. *Statist. Sci.* **7** 457–472.
- [15] GUILLOT, D., RAJARATNAM, B. and EMILE-GEAY, J. (2015). Statistical paleoclimate reconstructions via Markov random fields. *Ann. Appl. Stat.* **9** 324–352. MR3341118 <https://doi.org/10.1214/14-AOS794>
- [16] HAFF, L. R. (1979). Estimation of the inverse covariance matrix: Random mixtures of the inverse Wishart matrix and the identity. *Ann. Statist.* **7** 1264–1276. MR0550149
- [17] HAFF, L. R. (1991). The variational form of certain Bayes estimators. *Ann. Statist.* **19** 1163–1190. MR1126320 <https://doi.org/10.1214/aos/117638244>
- [18] HAMIMECHE, S. and LEWIS, A. (2009). Properties and use of CMB power spectrum likelihoods. *Phys. Rev. D* **79** Art. ID 83012.
- [19] HASTINGS, W. K. (1970). Monte Carlo sampling methods using Markov chains and their applications. *Biometrika* **57** 97–109. MR3363437 <https://doi.org/10.1093/biomet/57.1.97>
- [20] HOFF, P. D. (2009). A hierarchical eigenmodel for pooled covariance estimation. *J. R. Stat. Soc. Ser. B. Stat. Methodol.* **71** 971–992. MR2750253 <https://doi.org/10.1111/j.1467-9868.2009.00716.x>
- [21] HOFF, P. D. (2009). Simulation of the matrix Bingham–von Mises–Fisher distribution, with applications to multivariate and relational data. *J. Comput. Graph. Statist.* **18** 438–456. MR2749840 <https://doi.org/10.1198/jcgs.2009.07177>
- [22] JEFFREYS, H. (1961). *Theory of Probability*, 3rd ed. Clarendon Press, Oxford. MR0187257
- [23] LEDOTT, O. and WOLF, M. (2004). Honey, I shrunk the sample covariance matrix. *J. Portf. Manag.* **4** 110–119.
- [24] LEDOTT, O. and WOLF, M. (2004). A well-conditioned estimator for large-dimensional covariance matrices. *J. Multivariate Anal.* **88** 365–411. MR2026339 [https://doi.org/10.1016/S0047-259X\(03\)00096-4](https://doi.org/10.1016/S0047-259X(03)00096-4)
- [25] LIN, S. P. and PERLMAN, M. D. (1985). A Monte Carlo comparison of four estimators of a covariance matrix. In *Multivariate Analysis VI (Pittsburgh, Pa., 1983)* 411–429. North-Holland, Amsterdam. MR0822310
- [26] POPE, A. C. and SZAPUDI, I. (2005). Shrinkage estimation of the power spectrum covariance matrix. *Mon. Not. R. Astron. Soc.* **389** 766–774.
- [27] POURAHMADI, M. (2011). Covariance estimation: The GLM and regularization perspectives. *Statist. Sci.* **26** 369–387. MR2917961 <https://doi.org/10.1214/11-STS358>
- [28] PRESS, S. J. (2012). *Applied Multivariate Analysis: Using Bayesian and Frequentist Methods of Inference*. Courier Corporation, North Chelmsford, MA.
- [29] RAJARATNAM, B., MASSAM, H. and CARVALHO, C. M. (2008). Flexible covariance estimation in graphical Gaussian models. *Ann. Statist.* **36** 2818–2849. MR2485014 <https://doi.org/10.1214/08-AOS619>
- [30] SCHÄFER, J. and STRIMMER, K. (2005). A shrinkage approach to large-scale covariance matrix estimation and implications for functional genomics. *Stat. Appl. Genet. Mol. Biol.* **4** Art. ID 32. MR2183942 <https://doi.org/10.2202/1544-6115.1175>
- [31] SINHA, B. K. and GHOSH, M. (1987). Inadmissibility of the best equivariant estimators of the variance–covariance matrix, the precision matrix, and the generalized variance under entropy loss. *Statist. Decisions* **5** 201–227. MR0905238
- [32] STEIN, C. (1956). Some problems in multivariate analysis. Part I. Technical Report 6, Dept. Statistics, Stanford Univ.
- [33] STEIN, C. (1975). Estimation of a covariance matrix, Rietz Lecture. In *39th Annual Meeting IMS, Atlanta, GA*.
- [34] SUN, D. and BERGER, J. O. (2007). Objective Bayesian analysis for the multivariate normal model. In *Bayesian Statistics 8. Oxford Sci. Publ.* 525–562. Oxford Univ. Press, Oxford. MR2433206
- [35] YANG, R. and BERGER, J. O. (1994). Estimation of a covariance matrix using the reference prior. *Ann. Statist.* **22** 1195–1211. MR1311972 <https://doi.org/10.1214/aos/1176325625>