---
source_url: 
ingested: 2026-05-05
sha256: 60e0a5b06ee26892d7121529ce944f6066302d7a73c12faead3a5c0a83a1f792
---

JOURNAL OF GUIDANCE, CONTROL, AND DYNAMICS Vol. 44, No. 12, December 2021 

**==> picture [46 x 46] intentionally omitted <==**

# Higher-Order Unscented Estimator 

Zvonimir Stojanovski[∗] and Dmitry Savransky[†] Cornell University, Ithaca, New York 14853 

https://doi.org/10.2514/1.G006109 

This paper introduces a new extension of the unscented Kalman filter with asymmetric sample points and weights chosen to match third- and fourth-order moments in addition to the mean and covariance. Explicit solutions are obtained for sample points and weights, making their evaluation efficient and robust, and rigorous constraints are derived for their applicability. The use of the new filter is demonstrated with three dynamic systems (an aircraft coordinated turn model, a rotating rigid body, and a projectile with drag), and filter performance is compared with that of the conventional unscented Kalman filter and conjugate unscented transform filters. The new filter is found to be more robustin most caseswhere the initialdistribution, processnoise, and measurement noisehave a high kurtosis, in that it does not generate extreme outliers in the estimation error. Also, execution times for the new filter are found to be only slightly longer than for the conventional unscented Kalman filter and significantly shorter than for the conjugate unscented transform filters. 

## I. Introduction 

T HE Kalman filter, first introduced in 1960 [1], has become anindispensable tool in control, navigation, and tracking, due to its simplicity and robustness [2]. Because the original Kalman filter assumes that the system dynamics and measurements are linear— one of the very few cases where the filter has a closed form—a wide variety of modifications to the Kalman filter, using various approximation methods, have been developed for handling nonlinear systems with possibly non-Gaussian noise. Fang et al. [3] provide an extensive survey of such filters within a Bayesian framework. 

As a more efficient alternative to the previously developed extended Kalman filter (EKF) and particle filter (PF), Julier and Uhlmann [4] introduced the unscented Kalman filter (UKF), which evaluates the state and measurement functions at a finite, deterministic set of points, called sigma points, and uses weighted sums to compute the predicted and updated mean and covariance in the filter. This process is referred to as the unscented transform. The points and weights are chosen so that the computed mean and covariance are exact up to the second and first order in the state, respectively. In cases where the state distribution is symmetric, the third moments are preserved as well, due to the symmetry of the sigma points. As in the original Kalman filter [1], no assumptions are made about the type of distribution—in particular, the distribution need not be Gaussian. 

In recent years, a wide range of filters based on the UKF have been developed. Some have targeted specific applications, such as the Unscented Quaternion Estimator (USQUE) proposed by Crassidis and Markley for quaternion-based attitude estimation [5]. Others have sought to generalize the UKF, particularly by adding estimates of higher moments and higher-order approximations in order to better characterize the state distribution. One straightforward generalization of the UKF is the higher-order unscented filter (HOUF) developed by Tenne and Singh [6]. In HOUF, the sigma points and weights are chosen to match the moments up to a given order; specifically, the points and weights are the solution to a system of polynomial equations with the moments, which is typically obtained using an analytical solver. 

The unscented transform is closely related to multivariate quadrature—or cubature—rules, which approximate multivariate inte- 

Received 5 April 2021; revision received 17 June 2021; accepted for publication 29 June 2021; published online Open Access 11 October 2021. Copyright © 2021 by the American Institute of Aeronautics and Astronautics, Inc. All rights reserved. All requests for copying and permission to reprint should be submitted to CCC at www.copyright.com; employ the eISSN 15333884 to initiate your request. See also AIAA Rights and Permissions www.aiaa.org/randp. 

*Ph.D. Candidate, Sibley School of Mechanical and Aerospace Engineering, 404 Upson Hall; zs66@cornell.edu. Student Member AIAA. 

> †Associate Professor, Sibley School of Mechanical and Aerospace Engineering, 451 Upson Hall; ds264@cornell.edu. Member AIAA. 

grals using weighted sums. A cubature rule in R[n] is called a product rule if it is an n-fold tensor product of univariate quadrature rules. For filtering purposes, n is the dimension of the augmented state, i.e., the system state combined with measurement or process noise. Such cubature rules are simple to design but also suffer from the “curse of dimensionality” [7]. Several filtering methods have been developed using both product and nonproduct cubature rules. – Ito and Xiong [8] use product rules based on Gauss Hermite quadratures in a filter for multivariate Gaussian distributions; this filter is further generalized to Gaussian mixtures. Furthermore, Gauss– Laguerre quadrature rules, combined with spherical cubature rules, form the basis for the third-order cubature Kalman filter (CKF) proposed by Arasaratnam and Haykin [9] and the higher-degree CKF by Jia et al. [10]. Another method, intended for cases where the noise is not linearly correlated with the state, is proposed by Grothe [11]. This method uses sets of points called generators, which are used for computing nonproduct cubature rules (e.g., [12]). With this, Grothe showsthat the original sigma points are a special case of a generator and derives explicit formulas for a fifth-order unscented transform with 2n[2] � 1 points and weights. A more recent filtering method using nonproduct cubature rules is based on the conjugate unscented transform (CUT), developed by Adurthi et al. [13,14]. In this method, the sigma points are generated using scaled conjugate axes; the scales and weights for the points are chosen to match fourth-, sixth-, or eighth-order moments for Gaussian or uniform distributions. The number of sigma points in CUT is O�2[n] �. 

Whereas many filtering methods focus on increasing the accuracy of the state estimates, others aim to keep the computational cost of the filters low. The latter consideration is especially important in realtime applications, embedded systems, or wherever computation time and resources are limited. To this end, Julier and Uhlmann propose a reduced UKF with only n � 2 sigma points based on a simplex and chosen to match the mean and covariance and minimize the skewness [15]. An extension of this method with 2n � 3 points, which matches moments up to the fifth order and minimizes the error for the sixthorder moments, is proposed by Lévesque [16]. 

It is interesting to note that none of the aforementioned filters explicitly propagate higher-order moments, such as the skewness and kurtosis, of the state distribution. Rather, the higher moments of the standardized state—i.e., the state transformed so that its mean is zero and its covariance is the identity matrix—are taken to be known a priori. This is usually done by assuming a particular form for the state distribution, e.g., Gaussian or uniform. Such assumptions, however, are not always accurate. For example, for the problem of crosscalibration in constellations of imaging satellites, Shapiro [17] showed that measurements extracted from images exhibit highly non-Gaussian noise. 

A filtering method that directly accounts for non-Gaussian and nonuniform distributions was proposed by Ponomareva et al. [18]. This method retains the general structure of the UKF, with 2n � 1 

2186 

2187 

STOJANOVSKI AND SAVRANSKY 

sigma points, but the points and their corresponding weights are scaled using two factors that take into account third- and fourth-order moments. Specifically, the factors are chosen so that the averages of the third- and fourth-order marginal moments of the state components are preserved in the unscented transform. This method is simpler and more computationally efficient than several other higher-order filters in that it requires O�n� sigma points and does not require solving large systems of polynomials using an analytical solver. Further results on this method can be found in [19]. 

Drawing on the method of Ponomareva et al., we propose a new extension of the UKF with 2n � 1 sigma points that propagates the state skewness and kurtosis in n directions, in addition to the mean and covariance. In this filter’s variant of the unscented transform, the sigma points and their weights are asymmetrically scaled to match all of the propagated moments. We are able to obtain simple, explicit formulas for the sigma points and weights, making their computation efficient and robust. We call this filter the Higher-Order Unscented Estimator (HOUSE). 

In Sec. II, we review the theoretical background of the nonlinear filtering problem and describe unscented transforms using a quadrature-based formalism. In Sec. III, we derive the formulas for the sigma points and their weights and describe constraints under which they are applicable. Finally, in Sec. IV we demonstrate the use of HOUSE on three dynamic systems—an aircraft coordinated turn — model, a rotating rigid body, and a projectilewith drag and compare its performance to that of a conventionalUKF implementation as well as the CUT filters under various conditions. 

Throughout the paper, vectors are denoted by lowercase bold-italic letters (e.g., x) and matrices by uppercase bold-italic letters (e.g., A). An overbar denotes the mean or expected value of a random variable(e.g., x� is the expected value of x). Covariance matrices are denoted by P, with subscripts indicating the variables; e.g., Pxx is the covariance of x, and Pxy is the cross-covariance of x and y. 

## II. Nonlinear Filtering Problem 

Suppose that a system with state vector x evolves in discrete time according to 

**==> picture [172 x 9] intentionally omitted <==**

where w is the process noise, k is the time step, and f is a known state function. Furthermore, suppose that a measurement z is taken at each time step, given by 

**==> picture [189 x 20] intentionally omitted <==**

In some cases, it is reasonable to assume that the PDF p is of a specific type (e.g., Gaussian) or belongs to a broader family of distributions (e.g., the Pearson family). Then, p can be fully characterized by a finite set of generalized moments. 

Given these definitions, we can now describe in detail the processes of prediction, correction, and generalized moment approximation. 

## A. Prediction 

The most general form of the prediction step is given by the – Chapman Kolmogorov equation 

**==> picture [194 x 21] intentionally omitted <==**

where p[�] x[k][�] is the PDF of x�k�, and px[�][k][�][1][j][k][�] is the transition density from x�k� to x�k � 1�, i.e., the conditional PDF of x�k � 1� given x�k� [2]. From Eq. (1), we see that the only random effects in the transition from x�k� to x�k � 1� are due to the process noise w�k�; therefore, we have the conditional probability density for x�k � 1�� x given x�k�� x[0] 

**==> picture [209 x 21] intentionally omitted <==**

where pw[�][k][�][is the PDF of][ w][�][k][�][, and][ δ][ is the Dirac delta function.] A generalized moment ϕ[�] of x�k � 1� can be obtained by substituting Eq. (5) into Eq. (3), which gives 

**==> picture [200 x 21] intentionally omitted <==**

and substituting Eq. (6) gives 

**==> picture [235 x 21] intentionally omitted <==**

Using the properties of the Dirac delta function, this simplifies to 

**==> picture [164 x 10] intentionally omitted <==**

where n is the measurement noise, and h is a known measurement function. We assume that w and n are independent of x. 

The operation of the filter can be divided into two alternating steps: prediction, or finding the distribution of x�k � 1� given the distributions of x�k� and w�k�, and correction or update, or finding the distribution of x�k� given a measurement z�k�, the distribution of n�k�, and the prior predicted distribution of x�k�. 

— Except in some special cases, the true distribution of a variable i.e., its probability density function (PDF)—cannot be determined analytically. This is especially true if f and h are not known explicitly, e.g., if their evaluation requires numerical integration of equations of motion. Although the PDF can be approximated very accurately using numerical methods, such as finite difference or Gaussian mixture models, this is too computationally expensive for many applications. Instead, the distribution may be described by a finite set of generalized moments. For any random variable x ∈ Ω with PDF p and function ϕ:Ω → R, we can define a generalized moment ϕ[�] ∈ R as 

**==> picture [178 x 21] intentionally omitted <==**

**==> picture [204 x 21] intentionally omitted <==**

which is the expected value of ϕ�f�x; w; k��. At this point, in order to simplify the notation in the development of the filter, it is useful to define the augmented state 

**==> picture [154 x 27] intentionally omitted <==**

with PDF p[�] YP[k][�][, given by] 

**==> picture [177 x 28] intentionally omitted <==**

Then, the generalized moment is given in the form of Eq. (3) by 

**==> picture [161 x 21] intentionally omitted <==**

where 

Furthermore, for any functions g:Ω → Ω[0] and ϕ[0] :Ω[0] → R, we can compute a generalized moment of y � g�x�: 

2188 

STOJANOVSKI AND SAVRANSKY 

**==> picture [155 x 27] intentionally omitted <==**

## B. Correction 

Due to Eq. (2), the measurement likelihood function is given by 

**==> picture [209 x 21] intentionally omitted <==**

where pn[�][k][�][�][n][�][is the PDFof][ n][�][k][�][.The optimal correction step isgiven] by Bayes’s rule: 

**==> picture [186 x 29] intentionally omitted <==**

where p[�] x[k][�] is the prior PDF of x�k� and p[�] x[k] jz[�][is the posterior PDF of] x�k�. In some special cases, such as when h is linear, a closed form can be found for the corrector. In many other cases, however, the Bayesian corrector does not have a useful analytical form, and the computational cost of approximating the PDFs numerically is too high for real-time applications. Instead, we use a linear estimator of the form 

**==> picture [144 x 9] intentionally omitted <==**

where A is a constant matrix, and b is a constant vector. In most cases, it is desirable that the estimator error is zero-mean, i.e., E�x^ − x�� 0. The zero-mean linear estimator that gives the smallest mean-square error E��x^ − x�[T] �x^ − x��, called the linear minimum mean-square estimator (LMMSE), is given by [2] 

**==> picture [164 x 10] intentionally omitted <==**

with error covariance 

**==> picture [164 x 11] intentionally omitted <==**

For computing the moments of z�k� and x^�k�, we use an approach similar to that in the prediction step, with an augmented state 

**==> picture [153 x 27] intentionally omitted <==**

## C. Approximation of Moments 

In many cases, even when the exact PDF is known, it is impossible to compute the generalized moment using Eq. (3) analytically. However, the integral in this equation can be approximated with reasonable accuracy and efficiency by evaluating ϕ at a deterministic set of sample points x[�][1][�] ; : : : ; x[�][N][�] with corresponding weights w1; : : : ; wN and replacing the integral with a weighted sum 

**==> picture [151 x 26] intentionally omitted <==**

This is the principle behind the unscented transform as well as quadrature methods for numerical integration. In the original unscented transform [4], for a random variable x ∈ R[n] with mean x� and covariance Pxx, the sample points, referred to as sigma points, are given by 

**==> picture [203 x 48] intentionally omitted <==**

where c[�][j][�] denotes the jth column of p������Pxx **�** . The corresponding weights are 

**==> picture [173 x 29] intentionally omitted <==**

where κ is a tuning factor. The square root of the covariance matrix is usually taken to be the lower-triangular Cholesky decomposition, due to its efficiency and numerical stability. We adopt this convention in our work. 

Choosing the points x[�][j][�] and weights wj is equivalent to finding a cubature (multivariate quadrature) rule with p as a weighting function. Let F be the family of functions for which this cubature is exact; that is, 

**==> picture [223 x 28] intentionally omitted <==**

For example, F might include all polynomials up to a certain degree. We want to choose the points x[�][j][�] and weights wj so that all functions ϕ that we use for generalized moments ϕ[�] can be approximated with sufficient accuracy by functions in F . Specifically, suppose that we want to compute ϕ[�][0] � E�ϕ[0] �y��, where y � g�x�, for a polynomial ϕ of degree M and an arbitrary function g. If we want to account for Kth-order terms in the Taylor expansion of g, then F must contain polynomials up to degree KM. 

## III. Higher-Order Unscented Estimator 

A straightforward generalization of the original unscented transform [Eqs. (21) and (22)] was developed by Ponomareva et al. [18], with sigma points 

**==> picture [191 x 49] intentionally omitted <==**

and weights 

**==> picture [198 x 49] intentionally omitted <==**

where α and β are coefficients chosen to preserve the marginal thirdand fourth-order moments averaged over the components of x. We propose a further generalization of this method, with separate coef-ficients αi and βi for each column of p������Pxx **�** . Then, the sigma points are given by 

**==> picture [196 x 48] intentionally omitted <==**

and the corresponding cubature rule is 

2189 

STOJANOVSKI AND SAVRANSKY 

**==> picture [230 x 42] intentionally omitted <==**

In this section, we will derive expressions for the coefficients αi and βi for i � 1; : : : ; n along with the weights wj for j � 1; : : : ; 2n � 1 such that this unscented transform preserves the marginal skewness~ ������ **�** � and kurtosis for each component of x ��pPxx�[−][1] �x − x�. Using these results, wewill describe a newgeneralization of the UKF, which we call the HOUSE. Furthermore, we will derive conditions under which HOUSE can reliably be applied. 

## A. Standardization 

For any x, we can define a random variable 

**==> picture [160 x 12] intentionally omitted <==**

with domain Ω[~] . Then, x~ has a mean of zero and covariance I, the n × n identity matrix. Using a change of variables, we have 

**==> picture [205 x 21] intentionally omitted <==**

wherepoints forp~ is the probability density ofx~ are x~. The corresponding cubature 

**==> picture [192 x 44] intentionally omitted <==**

where the e[�][j][�] are the standard basis vectors, and the cubature rule is 

**==> picture [233 x 51] intentionally omitted <==**

**==> picture [241 x 113] intentionally omitted <==**

demonstrating the bidirectionality of the relationship between the two cubature rules. Therefore, our problem reduces to finding the coefficients αj, βj and the weights wj for a random, zero-mean vector with covariance I. 

## B. Determination of Coefficients and Weights 

Suppose that we want the cubature rule (31) to hold exactly for ψ�x~�� 1 and ψ�x~�� x[k] i[with][ i][ �][1][;][: : : ; n][ and][ k][ �][1][;][ 2][;][ 3][;][ 4][. If][x][~] i has skewness γi and kurtosis κi, then we have the system of equations 

**==> picture [143 x 26] intentionally omitted <==**

and 

**==> picture [158 x 79] intentionally omitted <==**

in unknowns αi, βi, wi, wn�i, and w2n�1 for i � 1; : : : ; n. This system can be solved as follows. First, from Eq. (36), we have 

**==> picture [145 x 19] intentionally omitted <==**

Substituting this into Eq. (37) gives 

**==> picture [149 x 22] intentionally omitted <==**

For ϕ:Ω → R, we define 

and applying Eq. (40) gives 

**==> picture [166 x 12] intentionally omitted <==**

The cubature rule (27) for ϕ holds if and only if Eq. (31) holds for ϕ[~] . This can be shown by supposing that the cubature rule (31) holds forϕ~ . Then 

**==> picture [241 x 97] intentionally omitted <==**

**==> picture [153 x 22] intentionally omitted <==**

If we substitute these two results into the higher-moment Eqs. (38) and (39), we have 

**==> picture [170 x 24] intentionally omitted <==**

and 

**==> picture [171 x 23] intentionally omitted <==**

which simplify to 

**==> picture [143 x 9] intentionally omitted <==**

and 

������ **�** using pPxxe[�][j][�] � c[�][j][�] . Conversely, if Eq. (27) holds for ϕ, we have 

2190 

STOJANOVSKI AND SAVRANSKY 

**==> picture [156 x 11] intentionally omitted <==**

respectively. Combining the last two expressions yields the secondorder polynomial 

**==> picture [164 x 11] intentionally omitted <==**

which has the solution 

**==> picture [161 x 21] intentionally omitted <==**

Because the skewness and kurtosis always satisfy the inequality 

**==> picture [142 x 11] intentionally omitted <==**

we have 

**==> picture [155 x 11] intentionally omitted <==**

**==> picture [183 x 27] intentionally omitted <==**

could give a covariance matrix estimate that is not positive definite. On the other hand, if all of the weights are nonnegative, then the approximated covariance matrix must be at least positive semidefinite. 

One way to ensure that w2n�1 stay nonnegative is to increase the smaller values of kurtosis, so that the κi − γ[2] i[is at least][ κ] min[in each] direction: 

**==> picture [184 x 34] intentionally omitted <==**

We choose κmin to be the value of kurtosis that gives w2n�1 � δ for a symmetric distribution (δ � 0 in the minimal case); that is, 

**==> picture [144 x 17] intentionally omitted <==**

which guarantees that there is a real, positive solution for αi, namely, 

**==> picture [161 x 22] intentionally omitted <==**

Then, using Eq. (45), we have 

The tradeoff of this approach, of course, is that the higher moments are somewhat distorted. Specifically, because the kurtosis increases, the modified distribution has heavier tails and is more non-Gaussian. 

## D. Mixed Moments 

Let Q be the cubature operator from Eq. (31): 

**==> picture [164 x 22] intentionally omitted <==**

which is also real and positive. Furthermore, we can evaluate w1; : : : ; w2n using Eqs. (41) and (42), and we find that these weights are positive as well. Finally, from Eq. (35), we have 

**==> picture [157 x 27] intentionally omitted <==**

## C. Tuning the Sigma Points and Weights From Eqs. (41) and (42), we have 

**==> picture [154 x 22] intentionally omitted <==**

and substituting this into Eq. (53) gives 

**==> picture [160 x 23] intentionally omitted <==**

Furthermore, substituting Eqs. (51) and (52) gives 

**==> picture [165 x 24] intentionally omitted <==**

which holds regardless of the sign chosen in the solution for αi. From the inequality (49), we have 

**==> picture [148 x 22] intentionally omitted <==**

However, this does not guarantee that w2n�1 will be positive, especially if n is large and the κi are small. In some cases, the fact that w2n�1 can be negative can be problematic. For example, approximating the covariance of a random variable y � g�x� by 

**==> picture [234 x 25] intentionally omitted <==**

If 

**==> picture [147 x 23] intentionally omitted <==**

where two or more of the ki are nonzero, then Q�ψ�� 0. Therefore, using the coefficients and weights found in Sec. III.B, the cubaturerule (31) is exact for ψ�x~�� x~i ~xj, since the components of x~ are uncorrelated. Effectively, when computing Q�ψ� for an arbitrary function ψ, the cubature “drops” the third- and fourth-order mixed terms in the Taylor expansion of ψ. We do not expect that this significantly impacts the accuracy of the filter. 

In the special case where the components of x~ are not only uncorrelated, but independent, the quadrature rule is also exact for all third- and fourth-order monomials except those of the form x~[2] i[x][~][2] j[.] This assumption of independence is reasonable if the system state is described using a minimal set of coordinates. 

## E. Constraints 

The main limitation of the HOUSE filter, particularly if the correction (59) is applied, is that the sigma points could grow without bound for large values of kurtosis. One way to ensure that this does not occur is to impose the constraint 

**==> picture [147 x 11] intentionally omitted <==**

for some radius R. Using Eq. (26), we see that this constraint is equivalent to 

**==> picture [179 x 15] intentionally omitted <==**

Furthermore, from Eqs. (51) and (52), we have 

**==> picture [180 x 22] intentionally omitted <==**

2191 

STOJANOVSKI AND SAVRANSKY 

so the constraint (63) can be expressed as 

**==> picture [194 x 33] intentionally omitted <==**

The other constraint on the moments comes from Eq. (56): if all weights are to be nonnegative, then the skewness and kurtosis values must satisfy 

**==> picture [148 x 24] intentionally omitted <==**

symmetric distribution aboutTo obtain simpler inequalities,x�. This is effectively assuming that wewe assume that x has a radially have the same uncertainty in each component of x; although this is clearly not the case in the filter, we believe that this is reasonable for an order-of-magnitude analysis of the filter’s tractability. Then, we have κi � κ, γi � 0, and kc[�][i][�] k � σ for i � 1; : : : ; 2n � 1; in that case, the inequality (66) reduces to 

**==> picture [137 x 10] intentionally omitted <==**

and Eq. (67) reduces to 

**==> picture [131 x 17] intentionally omitted <==**

These two simple inequalities provide an approximate range for κ where the filter can operate 

**==> picture [141 x 21] intentionally omitted <==**

We expect that the filter will perform better if the range for κ is wider; this is satisfied when 

**==> picture [139 x 10] intentionally omitted <==**

Furthermore, because of this inequality, we expect that this filter is better suited for lower-dimensional systems. 

## F. Computational Complexity 

The computational complexity of HOUSE is only slightly greater than that of the conventional UKF. In both filters, the most expensive part of the computation tends to be the evaluation of the nonlinear state and measurement functions, and in both filters these are evaluated 2n � 1 times. The added complexity of HOUSE is due to the evaluation of the sigma point coefficients and weights, which requires O�n� operations, and the estimation of the skewness and kurtosis, which requires O�n[2] � operations. However, these computations are very simple and involve no transcendental functions. The increased memory requirement for HOUSE due to the stored skewness and kurtosis is also O�n�. 

The complete prediction and update procedures for HOUSE are listed in the Appendix. 

## IV. Examples of Application 

In this section, we demonstrate the use of HOUSE with simulations of three dynamic systems: an aircraft performing coordinated turns, a rotating rigid body, and a projectile with drag. In each case, we test the performance of HOUSE against the conventional UKF and the CUT filters with Gaussian and non-Gaussian noise. Potential advantages of CUT include guaranteed positive weights without moment distortion and accounting for higher-order mixed moments [14]. 

In the non-Gaussian case, the noise is sampled from a Pearson type IV distribution, which has a PDF of the form 

**==> picture [228 x 23] intentionally omitted <==**

definedon the entire real line, where a > 0, m > 1∕2, λ, and ν are free parameters, and K is a normalizing factor. Given values of the mean, standard deviation, skewness, and kurtosis, the parameters of the Pearson type IV distribution can be determined uniquely, provided that [20] 

**==> picture [183 x 23] intentionally omitted <==**

Qualitatively, the Pearson type IV distribution has an asymmetric bell shape with heavy tails. It has been used for modeling various random processes, including wind shear fluctuations [21], fluctuating pressure on aircraft skin panels [22], and solar wind intensity [23]. The random noise in our simulations is generated using the procedures described by McGrath and Irving [24]. 

We implemented HOUSE, the conventional UKF, and the CUT filters in C++, using similar program structures to ensure a fair comparison of run times. The CUT sigma points for standardized Gaussiandistributionswereprecomputed usingcodeby Adurthi etal. [25]. We used the Eigen 3 library [26] for matrix operations and Burkardt’s implementation [27] of the Shampine–Gordon solver [28] for ordinary differential equations. The complete filtering and simulation code can be found in [29]. 

## A. Aircraft Coordinated Turn 

This example, representing a simple air traffic tracking scenario, is used by Adurthi et al. [14] to test the performance of the CUT filters. In this scenario, an aircraft executes the following maneuvers at a constant speed of 120 m∕s: heads westward for 125 s, turns southward 90° with a turn rate of 1°∕s, heads southward for 125 s, turns ° westward 90° at −3 ∕s, and then heads westward for 125 s. 

The state vector isThe aircraft’s motion is described by the coordinated turn model. x �� ξ ξ_ η η_ Ω �[T] , where (ξ, η) is the aircraft’s position and Ω is its turn rate. The state dynamics are modeled in discrete time as 

**==> picture [221 x 87] intentionally omitted <==**

where T is the time between steps. The covariance matrix of the noise w is given by 

**==> picture [191 x 86] intentionally omitted <==**

where L1 and L2 are constants. A radar takes measurements of range 

**==> picture [157 x 17] intentionally omitted <==**

and bearing 

2192 

STOJANOVSKI AND SAVRANSKY 

θ � atan2�η; ξ�� nθ 

**==> picture [16 x 9] intentionally omitted <==**

where nr and nθ represent measurement noise. 

In the simulations, the process noise constants are L1 � 0.16 and L2 � 0.01; the standard deviations of the process noise nr and nθ are 100 m and 1°, respectively. The initial (prior) distribution of the state� has mean x�0���25000m −120m 10000m 0m∕s 0.000001rad∕ s�[T] and standard deviation 1000 m for the position, 10 m∕s for the velocity, and 1°∕s for the turn rate. 

We consider two cases: one in which the measurement noise is Gaussian and another in which it has a Pearson type IV distribution with skewness γ � −1 and kurtosis κ � 20. In addition, in the Pearson case, the initial state distribution and process noise are assumed to have kurtosis κ � 10. For each case, we test the performance of HOUSE, the UKF (with κ � 1), CUT-4, CUT-6, and CUT8 over 100 trials. 

Figure 1 shows the root-mean-square error (RMSE) for each filter and length of time between measurements. The RMSE values for the UKFand CUT filters with Gaussian noise are nearly identical to those in [14]. In the case with Gaussian noise, the RMSE is of the same order of magnitude for HOUSE and UKF but lower by an order of magnitude or more for CUT-4, CUT-6, and CUT-8. This is expected, because the CUT filters are designed specifically to match the higherorder moments of Gaussian distributions. 

For the case with Pearson type IV noise, Fig. 1 shows that the RMSE for HOUSE is lower than for any of the other filters for T � 1 s. On the other hand, for larger values of T, the estimation error is lower for CUT-4, CUT-6, and CUT-8. This is due to one of the limitations of HOUSE discussed in Sec. III.E: the distance of the sigma points from the mean can rapidly increase with the standard deviation and kurtosis of the state and noise. In this case, we know 

from Eq. (75) that the standard deviation of the process noise, and therefore the distance of the sigma points from the mean, increases with T; this can lead to unrealistic values for the state components, particularly the turn rate Ω, for large values of T. Modeling the process noise with a smaller kurtosis value could mitigate this problem, but it could also produce negative weights: because the dimension of the augmented state is n � 10, the kurtosis value used here (κ � 10) is already the smallest value that guarantees nonnegative weights, given by Eq. (60). 

Figures 2 and 3 show the error distribution for T � 1 s and T � 5 s, respectively, for each of the filters. In Fig. 2, we see that the RMSE for Pearson type IV noise is driven by outliers for all of the filters except HOUSE. This effect is closely related to the kurtosis of the noise distributions and is an important characteristic of HOUSE, as discussed in the next example. However, from Fig. 3, we see how the performance of HOUSE degrades for a larger value of T; in that case, HOUSE produces even more outliers than the other filters. 

## B. Projectile 

The projectile’s state consists of the position (x, y, y) and velocity �x;_ _y; _z�, and its equations of motion are 

**==> picture [149 x 56] intentionally omitted <==**

where b isa constant,(fx, fy, fz) are the specific disturbance forces, g is the acceleration due to gravity (9.80665 m∕s[2] ), and v is the speed: 

**==> picture [360 x 365] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Noise Pearson Type IV Noise<br>10 [7]<br>10 [6]<br>10 [5]<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [8]<br>10 [7]<br>HOUSE<br>10 [6]<br>UKF<br>10 [5]<br>CUT−4<br>10 [4]<br>CUT−6<br>10 [3]<br>CUT−8<br>10 [2]<br>10 [0]<br>10 [−1]<br>1 2 3 4 5 1 2 3 4 5<br>Time Interval (s)<br>Position RMSE (m)<br>Velocity RMSE (m/s)<br>Turn Rate RMSE (rad/s)<br>**----- End of picture text -----**<br>


Fig. 1 Root-mean-square error for aircraft coordinated turn example. 

2193 

STOJANOVSKI AND SAVRANSKY 

**==> picture [364 x 381] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Noise Pearson Type IV Noise<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [5]<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [−2]<br>10 [−3]<br>10 [−4]<br>HOUSE UKF CUT−4 CUT−6 CUT−8 HOUSE UKF CUT−4 CUT−6 CUT−8<br>Fig. 2 Distribution of estimation error for coordinated turn example with sampling time interval 1 s.<br>Position Error (m)<br>Velocity Error (m/s)<br>Turn Rate Error (rad/s)<br>**----- End of picture text -----**<br>


**==> picture [157 x 17] intentionally omitted <==**

The constant b is given by 

**==> picture [141 x 20] intentionally omitted <==**

where A is the projectile’s surface area, CD is its drag coefficient, m is its mass, and ρ is the atmospheric density. In this example, we take b � 0.001 m[−][1] . The observer is located at the origin and takes measurements of azimuth 

**==> picture [162 x 9] intentionally omitted <==**

and elevation 

**==> picture [177 x 22] intentionally omitted <==**

where nα and nϵ represent measurement noise. 

The disturbance forces are taken to be independent with mean zero and standard deviation 0.01 m∕s[2] . The two components of the measurementnoise nα and nϵ areassumedtobeindependentwithmeanzero and a standard deviation of one arcminute. The initial (prior) state distributionhasmean �1000; 1000; 0� m andstandarddeviation 250m for the position and mean �500; 0; 500� m∕s and standard deviation 100 m∕s for the velocity. All components of the initial state are assumed to be independent as well. We consider two cases: one in which the distributions of the initial state, process noise, and measurement noise are Gaussian, and one in which they are Pearson type IV. 

In the latter case, all of the distributions have kurtosis 30; the initial state and process noise have skewness 1, and the measurement noise has skewness −1. The measurements are sampled at a rate of 5 Hz. 

For both the Gaussian case and the Pearson type IV case, we compare HOUSE to the UKF (with tuning factor κ � 1), CUT-4, and CUT-6 over 100 trials. (We do not test CUT-8 in this example, because the augmented state in the prediction step has dimension n � 9, whereas solutions for CUT-8 sigma points are known for n ≤ 6 [14].) In each trial, the projectile’s trajectory is simulated with randomly generated initial conditions and process noise, with a terminal condition of z � 0 (i.e., when the projectile hits the ground). Trajectories lasting less than 1 s are rejected. Based on each trajectory, a sequence of azimuth-elevation measurements is generated with random measurement noise. 

Figure 4 shows RMSE throughout the projectile’s flight for each of the filters, averaged over 100 trials. Because the total time-of-flight varies between trials, we consider the percentage of the total time-offlight, rather than the actual time. In the case with Gaussian distributions, the RMSE is nearly equal for HOUSE and the conventional UKF, but it is an order of magnitude lower for CUT-4 and CUT-6. Again, this is expected, because of the design of the CUT filters. However, in the case with Pearson type IV distributions, the RMSE is between one and three orders of magnitude lower for HOUSE than for the UKF, CUT-4, or CUT-6. 

Figure 5 shows the overall distribution of the estimation error for each of the filters for time t > 1 s after launch. (We do not consider the first second of flight, because the high initial errors are not representative of the filters’ performance.) It is clear that, in the case with Pearson type IV distributions, the RMSE for the UKF, CUT-4, and CUT-6 is dominated — by outliers those cases in which the position error is 10 km or greater. Except for these outliers, the error distributions for the UKF, CUT-4,and 

2194 

STOJANOVSKI AND SAVRANSKY 

**==> picture [366 x 365] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Noise Pearson Type IV Noise<br>10 [6]<br>10 [5]<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [8]<br>10 [7]<br>10 [6]<br>10 [5]<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [−2]<br>10 [−3]<br>10 [−4]<br>HOUSE UKF CUT−4 CUT−6 CUT−8 HOUSE UKF CUT−4 CUT−6 CUT−8<br>Position Error (m)<br>Velocity Error (m/s)<br>Turn Rate Error (rad/s)<br>**----- End of picture text -----**<br>


Fig. 3 Distribution of estimation error for coordinated turn example with sampling time interval 5 s. 

**==> picture [356 x 268] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Distributions Pearson Type IV Distributions<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [1]<br>HOUSE<br>10 [0]<br>UKF<br>10 [4]<br>CUT−4<br>10 [3] CUT−6<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>0 25 50 75 100 0 25 50 75 100<br>Time−of−Flight (%)<br>Position RMSE (m)<br>Velocity RMSE (m/s)<br>**----- End of picture text -----**<br>


Fig. 4 Root-mean-square estimation error for projectile example. 

2195 

STOJANOVSKI AND SAVRANSKY 

**==> picture [364 x 377] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Distributions Pearson Type IV Distributions<br>10 [5]<br>10 [4]<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [−2]<br>10 [−3]<br>10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>10 [−1]<br>10 [−2]<br>10 [−3]<br>HOUSE UKF CUT−4 CUT−6 HOUSE UKF CUT−4 CUT−6<br>Fig. 5 Distribution of estimation error for projectile example.<br>Position Error (m)<br>Velocity Error (m/s)<br>**----- End of picture text -----**<br>


CUT-6 are very similar to that of HOUSE. In the case with Gaussian distributions,ontheotherhand,therearenosuchoutliers.Thisisadirect effect of the kurtosis of the distributions, which is interpreted as their “propensity to produce outliers” [30]. Specifically, because a Pearson type IV distribution has a higher kurtosis than a Gaussian distribution, we expect to see more outliers in the Pearson type IV case. Based on Figs. 4 and 5, it appears that HOUSE, which directly accounts for the higher kurtosis, is more robust in the presence of outliers than CUT-4, CUT-6, or the UKF. 

Figure 6 shows the average run times for each of the filters. Although HOUSE is slightly slower than the UKF, it is an order of magnitude faster than the CUT-4 or CUT-6 filters, because HOUSE requires many fewer sigma points. 

## C. Rigid Body 

We consider a rigid body with principal moments of inertia about the center of mass I1, I2, I3 and angular velocity components �ω1; ω2; ω3� in the directions of the principal axes, respectively. The time evolution of the angular velocities is described by the Euler equations 

**==> picture [171 x 10] intentionally omitted <==**

**==> picture [200 x 212] intentionally omitted <==**

**----- Start of picture text -----**<br>
10 [3]<br>10 [2]<br>10 [1]<br>10 [0]<br>HOUSE UKF CUT−4 CUT−6<br>Gaussian Distributions<br>Pearson Type IV Distributions<br>Fig. 6 Filter run times for projectile example.<br>Average Run Time (ms)<br>**----- End of picture text -----**<br>


**==> picture [171 x 10] intentionally omitted <==**

**==> picture [171 x 10] intentionally omitted <==**

where τ1, τ2, τ3 are external disturbance torques about the center of mass in the directions of the principal axes, respectively. We assume that only ω1 is measured directly. 

In our simulations, we consider an asymmetric rigid body with I1 � 900 kg ⋅ m[2] , I2 � 800 kg ⋅ m[2] , and I3 � 700 kg ⋅ m[2] . The 

disturbance torques are taken to be zero-mean and independent, with standard deviation 0.001 N ⋅ m. The initial angular velocities are sampled from a distribution with mean zero and standard deviation 0.01 rad∕s in each direction. The measurement noise has mean zero and standard deviation 0.001 rad∕s, and the measurements are sampled at 10 Hz. As in the previous example, we consider Gaussian and Pearson type IV distributions for the initial state, process noise, and measurement noise; specifically, we consider Pearson distributions with skewness γ � −1 and kurtosis κ � 30. 

2196 

STOJANOVSKI AND SAVRANSKY 

**==> picture [421 x 701] intentionally omitted <==**

**----- Start of picture text -----**<br>
Gaussian Distributions Pearson Type IV Distributions<br>0.04<br>0.03 HOUSE<br>UKF<br>0.02 CUT−4<br>CUT−6<br>0.01 CUT−8<br>0.00<br>0 200 400 600 0 200 400 600<br>Time (s)<br>Fig. 7 Root-mean-square estimation error for rigid body example.<br>Gaussian Distributions Pearson Type IV Distributions<br>0.15<br>0.10<br>0.05<br>0.00<br>HOUSE UKF CUT−4 CUT−6 CUT−8 HOUSE UKF CUT−4 CUT−6 CUT−8<br>Fig. 8 Distribution of estimation error for rigid body example.<br>For both distribution types, we test HOUSE, the UKF (with tuning similar effect as with the projectile: HOUSE<br> κ � 1), CUT-4, CUT-6, and CUT-8 in 100 trials.), CUT-4, CUT-6, and CUT-8 in 100 trials.<br>RMSE and error distributions for the filters are shown in is evidence that HOUSE is better equipped to<br>Figs. 7 and 8, respectively. Overall, the differences in RMSE between because of its propagation of kurtosis.<br>the filters are small, and the RMSE is of the same order of magnitude<br>for all of the filters. The filters’ error quartiles are very similar as well.’ error quartiles are very similar as well. error quartiles are very similar as well.<br>However, in the casewith Pearson type IV distributions, we observe a<br>V. Conclusions<br>10 [4]<br>and fourth-order moment matching and explicit<br>sigma points and weights. Its computational<br>10 [3]<br>10 [2] found that the new filter is more robust for<br>has been found that HOUSE generates many<br>10 [1]<br>are significantly shorter than for the CUT filters<br>longer than for the conventional UKF.<br>10 [0]<br>HOUSE UKF CUT−4 CUT−6 CUT−8 to increase its accuracy and range of<br>modifications to HOUSE that would minimize<br>Gaussian Distributions moments and make the filter’s’ss performance less<br>Pearson Type IV Distributions<br>ments would most the<br>Angular Velocity RMSE (rad/s)<br>Angular Velocity Error (rad/s)<br>Average Run Time (ms)<br>**----- End of picture text -----**<br>


similar effect as with the projectile: HOUSE has fewer and less extreme outliers than the UKF or any of the CUT filters. Again, this is evidence that HOUSE is better equipped to process outliers because of its propagation of kurtosis. 

For both distribution types, we test HOUSE, the UKF (with tuning factor κ � 1), CUT-4, CUT-6, and CUT-8 in 100 trials.), CUT-4, CUT-6, and CUT-8 in 100 trials. 

The RMSE and error distributions for the filters are shown in Figs. 7 and 8, respectively. Overall, the differences in RMSE between the filters are small, and the RMSE is of the same order of magnitude for all of the filters. The filters’ error quartiles are very similar as well.’ error quartiles are very similar as well. error quartiles are very similar as well. However, in the casewith Pearson type IV distributions, we observe a 

Figure 9 shows the average runtimes for each of the filters. As in the projectile example, HOUSE is slightly slower than the UKF but significantly faster than CUT-4, CUT-6, and especially CUT-8. 

This paper has proposed a new extension of the UKF with thirdand fourth-order moment matching and explicit formulas for the sigma points and weights. Its computational cost is only slightly greater than that of the conventional UKF. Conditions under which the sigma point formulas are applicable and the filter is operable have also been described. In simulations of dynamic systems, it has been found that the new filter is more robust for distributions with high kurtosis than the conventional UKF or the CUT filters. Specifically, it has been found that HOUSE generates many fewer outliers in the estimation error in cases where the initial conditions and noise have high kurtosis. Also, it has been found that the run times for HOUSE are significantly shorter than for the CUT filters and only slightly longer than for the conventional UKF. 

In our future work, the plan is to further refine the HOUSE method to increase its accuracy and range of applicability. In particular, modifications to HOUSE that would minimize the distortion of moments and make the filter’s’ss performance less sensitive to the dimension of the system will be investigated. Because these improvements would most likely require increasing the number of sigma points, and hence the computational complexity, the tradeoff between 

Fig. 9 Filter run times for rigid body example. 

2197 

STOJANOVSKI AND SAVRANSKY 

the speed and accuracy of higher-moment unscented filters will also be studied in detail. 

Finally, the plan is to apply HOUSE to the problem of satellite tracking using unconventional measurements—such as those obtained from ground imaging data—coupled with more conventional measurement techniques. Because the unconventional measurements might have highly non-Gaussian distributions, it is expected that HOUSE would be well suited for this problem. The plan is to test the performance of these new methods in spacecraft navigation and attitude determination using a realistic simulation of a satellite’s dynamics and sensors. 

## Appendix: Filtering Procedures 

Here, we summarize the HOUSE prediction and correction procedures.AC++ implementation of theseprocedures canbe found in[29]. 

## A. Prediction 

1) For the augmented state 

**==> picture [158 x 28] intentionally omitted <==**

**==> picture [163 x 27] intentionally omitted <==**

and weights wj�k�, as described in Sec. III.B. 

2) Compute the measurement for each sigma point: 

**==> picture [175 x 11] intentionally omitted <==**

- 3) Compute the measurement mean and covariance: 

**==> picture [159 x 26] intentionally omitted <==**

**==> picture [241 x 26] intentionally omitted <==**

**==> picture [241 x 26] intentionally omitted <==**

4) Compute the LMMSE-updated mean and covariance for the state: 

generate the modified sigma points 

**==> picture [164 x 28] intentionally omitted <==**

and weights wj�k�, as described in Sec. III.B. 

- 2) Propagate the state for each sigma point: 

**==> picture [187 x 10] intentionally omitted <==**

- 3) Compute the predicted mean and covariance: 

**==> picture [211 x 26] intentionally omitted <==**

**==> picture [218 x 10] intentionally omitted <==**

**==> picture [219 x 27] intentionally omitted <==**

- 4) Compute the standardized states at the sigma points: 

**==> picture [217 x 12] intentionally omitted <==**

- 5) Compute the skewness and kurtosis of the standardized state: 

**==> picture [184 x 64] intentionally omitted <==**

## B. Correction 

Here, z�k� denotes the true measurement. 1) For the augmented state 

**==> picture [153 x 27] intentionally omitted <==**

generate the modified sigma points 

**==> picture [219 x 11] intentionally omitted <==**

**==> picture [228 x 11] intentionally omitted <==**

5) Compute the LMMSE error and standardized state at the sigma points: 

**==> picture [236 x 11] intentionally omitted <==**

**==> picture [227 x 12] intentionally omitted <==**

- 6) Compute the skewness and kurtosis of the standardized state: 

**==> picture [162 x 63] intentionally omitted <==**

## Acknowledgement 

The authors acknowledge support for this work from the NASA Space Technology Research Grants Early Career Faculty program under NASA grant 80NSSC20 K0068. 

## References 

- [1] Kalman, R. E., “A New Approach to Linear Filtering and Prediction Problems,” Journal of Basic Engineering, Vol. 82, No. 1, 1960, pp. 35–45. https://doi.org/10.1115/1.3662552 

- [2] Bar-Shalom, Y., Li, X. R., and Kirubarajan, T., Estimation with Applications to Tracking and Navigation, Wiley, Hoboken, NJ, 2001. 

- [3] Fang, H., Tian, N., Wang, Y., Zhou, M., and Haile, M. A., “Nonlinear Bayesian Estimation: From Kalman Filtering to a Broader Horizon,” Journal of Automatica Sinica, Vol. 5, No. 2, 2018, pp. 401–417. https://doi.org/10.1109/JAS.2017.7510808 

- [4] Julier, S. J., and Uhlmann, J. K., “New Extension of the Kalman Filter to Nonlinear Systems,” Signal Processing, Sensor Fusion, and Target Recognition VI, Proceedings of SPIE, Vol. 3068, International Soc. for Optical Engineering, Orlando, FL, 1997, pp. 182–193. https://doi.org/10.1117/12.280797 

- [5] Crassidis, J. L., and Markley, F. L., “Unscented Filtering for Spacecraft Attitude Estimation,” Journal of Guidance, Control, and Dynamics, Vol. 26, No. 4, 2003, pp. 536–542. https://doi.org/10.2514/2.5102 

2198 

STOJANOVSKI AND SAVRANSKY 

- [6] Tenne, D., and Singh, T., “The Higher Order Unscented Filter,” Proceedings of the 2003 American Control Conference, Vol. 3, Inst. of Electrical and Electronics Engineers, New York, 2003, pp. 2441– 2446. https://doi.org/10.1109/ACC.2003.1243441 

- [7] Stroud, A. H., Approximate Calculation of Multiple Integrals, PrenticeHall, Upper Saddle River, NJ, 1971. 

- [8] Ito, K., and Xiong, K., “Gaussian Filters for Nonlinear Filtering Problems,” IEEE Transactions on Automatic Control, Vol. 45, No. 5, 2000, pp. 910–927. 

https://doi.org/10.1109/9.855552 

- [9] Arasaratnam, I., and Haykin, S., “Cubature Kalman Filters,” IEEE Transactions on Automatic Control, Vol. 54, No. 6, 2009, pp. 1254– 1269. https://doi.org/10.1109/TAC.2009.2019800 

- [10] Jia, B., Xin, M., and Cheng, Y., “High-Degree Cubature Kalman Filter,” Automatica, Vol. 49, No. 2, 2013, pp. 510–518. https://doi.org/10.1016/j.automatica.2012.11.014 

- [11] Grothe, O., “A Higher Order Correlation Unscented Kalman Filter,” Applied Mathematics and Computation, Vol. 219, No. 17, 2013, pp. 9033–9042. https://doi.org/10.1016/j.amc.2013.03.019 

- [12] Keister, B. D., “Multidimensional Quadrature Algorithms,” Computers in Physics, Vol. 10, No. 2, 1996, pp. 119–122. https://doi.org/10.1063/1.168565 

- [13] Adurthi, N., Singla, P., and Singh, T., “Conjugate Unscented Transform Rules for Uniform Probability Density Functions,” 2013 American Control Conference, Inst. of Electrical and Electronics Engineers, New York, 2013, pp. 2454–2459. https://doi.org/10.1109/ACC.2013.6580202 

- [14] Adurthi, N., Singla, P., and Singh, T., “Conjugate Unscented Transformation: Applications to Estimation and Control,” Journal of Dynamic Systems, Measurement, and Control, Vol. 140, No. 3, 2018, pp. 1–22. https://doi.org/10.1115/1.4037783 

- [15] Julier, S., and Uhlmann, J., “Reduced Sigma Point Filters for the Propagation of Means and Covariances Through Nonlinear Transformations,” Proceedings of the 2002 American Control Conference, Vol. 2, Inst. of Electrical and Electronics Engineers, New York, 2002, pp. 887–892. https://doi.org/10.1109/ACC.2002.1023128 

- [16] Lévesque, J.-F., “Second-Order Simplex Sigma Points for Nonlinear Estimation,” AIAA Guidance, Navigation, and Control Conference and Exhibit, AIAA Paper 2006-6093, 2006. https://doi.org/10.2514/6.2006-6093 

- [17] Shapiro, J., “Using Modern Mathematical and Computational Tools for Image Processing,” Ph.D. Thesis, Cornell Univ. Press, Ithaca, NY, Dec. 2020. 

- [18] Ponomareva, K., Date, P., and Wang, Z., “A New Unscented Kalman Filter with Higher Order Moment-Matching,” Proceedings of the 19th International Symposium on Mathematical Theory of Networks and Systems, Eötvös Loránd Univ., Budapest, 2010, pp. 1609–1613. https://doi.org/10.13140/2.1.1472.6089 

- [19] Ponomareva, K., and Date, P., “Higher Order Sigma Point Filter: A New Heuristic for Nonlinear Time Series Filtering,” Applied Mathematics and Computation, Vol. 221, Sept. 2013, pp. 662–671. https://doi.org/10.1016/j.amc.2013.06.084 

- [20] Elderton, W. P., and Johnson, N. L., Systems of Frequency Curves, Cambridge Univ. Press, Cambridge, England, U.K., 1969. 

- [21] Ramsdell, J. V., “Wind Shear Fluctuations Downwind of Large Surface Roughness Elements,” Journal of Applied Meteorology, Vol. 17, No. 4, 1978, pp. 436–443. https://doi.org/10.1175/1520-0450(1978)017<0436:WSFDOL>2.0. CO;2 

- [22] Steinwolf, A., and Rizzi, S. A., “Non-Gaussian Analysis of Turbulent Boundary Layer Fluctuating Pressure on Aircraft Skin Panels,” AIAA Journal of Aircraft, Vol. 43, No. 6, 2012, pp. 1662–1675. https://doi.org/10.2514/1.18294 

- [23] Krafft, C., Volokitin, A., and Gauthier, G., “Turbulence and MicroprocessesinInhomogeneous SolarWind Plasmas,” Fluids, Vol. 4, No.2, 2019, pp. 43–45. 

   - https://doi.org/10.3390/fluids4020069 

- [24] McGrath, E. J., and Iriving, D. C., “Random Number Generation for Selected Probability Distributions,” Office of Naval Research TR ORNL-RSIC-38 (Vol. II), Arlington, VA, 1975. 

- [25] Adurthi, N., Singla, P., and Singh, T., “Conjugate Unscented Transform Points,” GitHub Repository, 2017, https://github.com/nadurthi/CUTpoints. 

- [26] Guennebaud, G., and Jacob, B., “Eigen 3,” Software Library, 2010, http://eigen.tuxfamily.org. 

- [27] Burkardt,J., “ODE:ShampineandGordonODESolver,” SoftwareLibrary, 2020, https://people.sc.fsu.edu/jburkardt/cpp_src/ode/ode.html. 

- [28] Shampine, L., and Gordon, M., Computer Solution of Ordinary Differential Equations: The Initial Value Problem, Freeman, San Francisco, CA, 1975. 

- [29] Stojanovski, Z., and Savransky, D., “The Higher-Order Unscented Estimator,” GitHub Repository, 2021, https://github.com/SIOSlab/ HOUSE. 

- [30] Westfall, P. H., “Kurtosis as Peakedness, 1905–2014. R.I.P.,” American Statistician, Vol. 68, No. 3, 2014, pp. 191–195. https://doi.org/10.1080/00031305.2014.917055 

