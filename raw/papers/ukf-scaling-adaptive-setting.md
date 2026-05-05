---
source_url:
ingested: 2026-05-05
sha256: e9e5605af9e762d24382d139582b8cf9768d90440b671d5a95218a4332afcb1b
---

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2411 

- [7] A. Abdessameud and A. Tayebi, “On the coordinated attitude alignment of a group of spacecraft without velocity measurements,” in _Proc. IEEE Conf. Decision Control_ , 2009, pp. 1476–1481. 

- [8] U. Münz, A. Papachristodoulou, and F. Allgöwer, “Delay-dependent rendezvous and flocking of large scale multi-agent systems with communication delays,” in _Proc. IEEE Conf. Decision Control_ , 2008, pp. 2038–2043. 

- [9] Y. Hong-Yong, Z. Xun-Lin, and Z. Si-Ying, “Consensus of secondorder delayed multi-agent systems with leader-following,” _Eur. J. Control_ , vol. 15, pp. 1–15, 2010. 

- [10] Z. Meng, W. Yu, and W. Ren, “Discussion on: Consensus of secondorder delayed multi-agent systems with leader-following,” _Eur. J. Control_ , vol. 2, pp. 200–205, 2010. 

- [11] I. G. Polushin, A. Tayebi, and H. J. Marquez, “Control schemes for stable teleoperation with communication delay based on IOS small gain theorem,” _Automatica_ , vol. 42, pp. 905–915, 2006. 

- [12] N. Chopra, M. W. Spong, and R. Lozano, “Synchronization of bilateral teleoperators with time delay,” _Automatica_ , vol. 44, no. 8, pp. 2142–2148, 2008. 

- [13] S.-J. Chung and J. J. E. Slotine, “Cooperative robot control and concurrent synchronization of Lagrangian systems,” _IEEE Trans. Robotics_ , vol. 25, no. 3, pp. 686–700, 2009. 

- [14] E. Nuño, R. Ortega, L. Basañez, and D. Hill, “Synchronization of networks of nonidentical Euler-Lagrange systems with uncertain parameters and communication delays,” _IEEE Trans. Autom. Control_ , vol. 56, no. 4, pp. 935–941, Apr. 2011. 

- [15] A. Abdessameud and A. Tayebi, “Formation control of VTOL Unmanned Aerial Vehicles with communication delays,” _Automatica_ , vol. 47, pp. 2383–2394, 2011. 

- [16] S.-J. Chung, U. Ahsu, and J. J. E. Slotine, “Application of synchronization to formation flying spacecraft: Lagrangian approach,” _J. Guid., Control Dynam._ , vol. 32, no. 2, pp. 512–526, 2009. 

- [17] J. Erdong, J. Xiaoleib, and S. Zhaoweia, “Robust decentralized attitude coordination control of spacecraft formation,” _Syst. Control Lett._ , vol. 57, pp. 567–577, 2008. 

- [18] J. Erdong and S. Zhaowei, “Robust attitude synchronization controllers design for spacecraft formation,” _IET Control Theory Appl._ , vol. 3, no. 3, pp. 325–339, 2009. 

- [19] Z. Meng, Z. You, G. Li, and C. Fan, “Cooperative attitude control of multiple rigid bodies with multiple time-varying delays and dynamically changing topologies,” _Math. Problems Eng._ pp. 1–19, 2010 [Online]. Available: http://www.hindawi.com/journals/mpe/2010/621594/ 

- [20] Y. Igarashi, T. Hatanaka, M. Fujita, and M. W. Spong, “Passivity-based attitude synchronization in SE(3),” _IEEE Trans. Control Syst. Technol._ , vol. 17, no. 5, pp. 1119–1134, Sep. 2009. 

- [21] M. D. Shuster, “A survey of attitude representations,” _J. Astronaut. Sci._ , vol. 41, no. 4, pp. 439–517, 1993. 

- [22] D. Jungnickel _, Graphs, Networks and Algorithms, Algorithms and Computation in Mathematics_ , 2nd ed. New York: Springer, 2005, vol. 5. 

- [23] A. Tayebi, “Unit quaternion based output feedback for the attitude tracking problem,” _IEEE Trans. Autom. Control_ , vol. 53, no. 6, pp. 1516–1520, Jun. 2008. 

- [24] H. K. Khalil _, Nonlinear systems_ , Third edition ed. Englewood Cliffs, NJ: Prentice-Hall, 2002. 

## **Unscented Kalman Filter: Aspects and Adaptive Setting of Scaling Parameter** 

Jindˇrich Duník, Miroslav Simandl, and[ˇ] Ondˇrej Straka 

_**Abstract—**_ **This technical note deals with the unscented Kalman filter for state estimation of nonlinear stochastic dynamic systems with a special focus on the scaling parameter of the filter. Its standard choice is analyzed and its impact on the estimation quality is discussed. On the basis of the analysis, a novel method for adaptive setting of the parameter in the unscented Kalman filter is proposed. The results are illustrated in a numerical example.** 

_**Index Terms—**_ **Bayesian methods, nonlinear filters, state estimation, stochastic systems.** 

## I. INTRODUCTION 

The problem of nonlinear recursive state estimation of discrete-time stochastic dynamic systems from noisy measured data has been a subject of considerable research interest for the last several decades. In this technical note, the discrete-time nonlinear stochastic system 

**==> picture [197 x 10] intentionally omitted <==**

**==> picture [187 x 9] intentionally omitted <==**

is considered, where the vectors xk 2 n and zk 2 n represent the immeasurable state of the system and measurement at time instant k , respectively, fk : n ! n , hk : n ! n are known vector functions, and wk 2 n , vk 2 n are independent state and measurement white noises. The probability density functions (pdfs) of the noises are supposed to be Gaussian with zero means and known covariance matrices Qk and Rk , i.e., pw (wk) = N fwk : 0n 1[;][ Q] k[g][ and] pv (vk) = N fvk : 0n 1[;][ R] k[g][, respectively. The initial state][ x] 0[is] supposed to have Gaussian distribution px (x0) = N fx0 : x0; P0g and is independent of the noises. 

The general solution to the estimation problem is given by the Bayesian recursive relations (BRRs) for computation of probability density functions (pdfs) of the state conditioned by the measurements [1]. These pdfs provide a full description of the estimated state. The BRRs are assumed in the following form: 

**==> picture [197 x 23] intentionally omitted <==**

**==> picture [206 x 21] intentionally omitted <==**

Manuscript received April 01, 2010; revised August 26, 2011, November 30, 2011, and January 6, 2012; accepted January 26, 2012. Date of publication February 17, 2012; date of current version August 24, 2012. This work was supported by the European Regional Development Fund (ERDF), project “NTIS—New Technologies for Information Society”, European Centre of Excellence, CZ.1.05/1.1.00/02.0090, and by the Czech Science Foundation, project GACR P103/11/1353. Recommended by Associate Editor L. Schenato. 

The authors are with the Department of Cybernetics, Faculty of Applied Sciences, University of West Bohemia, Univerzitní 8, 306 14 Pilsen, Czech Republic (e-mail: dunikj@kky.zcu.cz; simandl@kky.zcu.cz; straka30@kky.zcu. cz). 

Color versions of one or more of the figures in this paper are available online at http://ieeexplore.ieee.org. 

Digital Object Identifier 10.1109/TAC.2012.2188424 

0018-9286/$31.00 © 2012 IEEE 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2412 

where p(xkjz[k] ) is the filtering pdf, p(xk+1jz[k] ) one-step ahead predictive pdf, p(xk+1jxk) state transition pdf obtained from (1), p(zkjxk) measurement pdf obtained from (2), and p(zkjz[k][�][1] ) = p(xkjz[k][�][1] )p(zkjxk)dxk . The closed form solution to the BRRs is available only for a few special cases [1], e.g., for linear Gaussian system, which leads to the well-known Kalman filter. In other cases it is necessary to apply some approximate methods. These methods can be divided into two groups: local and global methods [2]. 

The local methods are often based on an approximation of the nonlinear functions in the state and measurement equations (1) and (2) so that the Kalman filter design technique can be used for the BRR’s solution, i.e., conditional mean value and covariance matrix are computed instead of the conditional pdf. This rough approximation of the model and a posteriori estimates induces local validity of the state estimates and consequently impossibility to generally ensure convergence of the local filter estimates. On the other hand, the advantage of the local methods can be found in the simplicity of the BRR’s solution. 

The global methods are based on a certain type of approximation of the BRRs and they generate the conditional pdf of the state [3]. Global methods are represented by e.g., the particle filter, the pointmass method or the Gaussian sum approach. The global methods are not considered in this technical note. 

The standard local methods use for the approximation of the nonlinear functions in (1) and (2) the Taylor expansion of the first or second order [1]. As an example the extended Kalman filter can be mentioned. 

In the last decade, the derivative-free approaches to local filter design based on the polynomial interpolation [4]–[7], the unscented transformation [6]–[9] or the numerical integration [10] have been published. The approximation of the nonlinear functions by means of Stirling’s polynomial interpolation leads to the divided difference filters (DDFs). Further, the DDFs can be classified into the divided difference filter first order (DD1) and the divided difference filter second order (DD2), which are based on the first and second order Stirling’s interpolation formula,respectively[4].Insteadofadirectsubstitutionofthenonlinear functions in the system description, an approximation of the “already approximated” pdfs representing state estimates by a set of deterministically chosen weighted points can be utilized as a basis for the local filters. This transformation is often called the unscented transformation and the unscented Kalman filter (UKF) [8] exemplifies this approach. Alternatively, the quadrature or cubature rules can be used in a numerical solution to integrals in the BRRs, which leads to the Gauss-Hermite filter [6] or the cubature Kalman filter (CKF) [10], respectively. Although, the UKF, CKF, and the DDFs (and their variants) come from quite different basic ideas, due to the common features, they can be viewed as one class of filters, namely derivative-free filters [4], [7]. 

It can be shown that the UKF and the CKF have identical algorithms which differ only in a choice of a scaling parameter. There is a recommendation of the scaling parameter value within the UKF algorithm, however a different value may be chosen according to the user. The CKF algorithm then matches the UKF algorithm with zero scaling parameter. 

These facts represent the main motivation of this technical note, which will focus on the choice of the scaling parameter. 

The aim is to analyze the standard choice of the scaling parameter within the UKF and to illustrate importance of a choice of the scaling parameter. Based on the analysis a novel algorithm for the adaptive setting of the parameter in the UKF will be proposed. 

The rest of the technical note is organized as follows. Section II introduces the UKF. In Section III the role of the scaling parameter is analyzed and the novel algorithm for the setting the scaling parameter in the UKF is proposed. Section IV illustrates the UKF with the proposed scaling parameter adaptation using a numerical example and finally, Section V gives some concluding remarks. 

## II. UNSCENTED KALMAN FILTER 

The algorithm of the UKF follows the standard local filter structure where the filtering and predictive means and covariance matrices are recursively computed with the aid of an moment approximation technique. In the UKF, the state and measurement predictive moments are computed by the unscented transformation (UT). 

The UT approximations will be illustrated by an example of transformation of a random variable through a nonlinear function and then applied in the UKF design [4], [8]. 

## _A. Unscented Transformation_ 

Let x 2 n and y 2 n be random vector variables related through the known nonlinear function 

**==> picture [192 x 12] intentionally omitted <==**

The variable x is given by the first two moments, i.e., by the mean x^ and the covariance matrix Px . The aim is to calculate the mean and the covariance matrix of y , and the cross-covariance matrix Pxy , i.e., 

**==> picture [197 x 38] intentionally omitted <==**

The considered solution to the problem is the unscented transformation [8] approximating description of the random variable x by a set of deterministically chosen points, so called sigma-points, fXig with corresponding weights fWig 

**==> picture [209 x 41] intentionally omitted <==**

**==> picture [223 x 17] intentionally omitted <==**

where i = 1; . . . ; nx , the term (nx + )Px = i (nx + )Sx represents i -th column of the matrix i (nx + )Px = (nx + )Sx and is the scaling parameter influencing spreading of the points in the state-space and thus the accuracy of the approximation. The matrix Sx is the square-root of the covariance matrix Px so that Px = SxS[T] x[. Then, each sigma-point is] transformed via the nonlinear function 

**==> picture [156 x 10] intentionally omitted <==**

and the resulting characteristics are given as 

**==> picture [210 x 58] intentionally omitted <==**

**==> picture [210 x 27] intentionally omitted <==**

Note that these results are only approximations of the true mean and the covariance matrices which cannot generally be computed. 

The introduced UT (9)–(15) represents a basic algorithm which suffers from one main weakness, the possible loss of positive semi-definiteness of Py[UKF] (14), as discussed later in detail. Thus, several improved algorithms have been proposed which differ mainly in sigmapoint computation, e.g., scaled, reduced or higher order UT [9]. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2413 

## _B. Unscented Kalman Filter_ 

TABLE I 

MSE OF THE CKF AND THE UKFS FOR DIFFERENT CHOICES OF 

The unscented transformation (9)–(15) can be directly used in the design of the UKF [8]. The resulting algorithm of the UKF can be summarized as follows. 

**==> picture [231 x 31] intentionally omitted <==**

Step 1: Set the time instant k = 0 and define _a priori_ initial condition by the predictive mean x^0j�1 = E[x0] = x0 and the predictive covariance matrix P0j�1 = cov[x0] = P0 . 

recommendations inevitably lead to necessity of a further examination or analysis of the scaling parameter setting. 

Step 2: The state predictive estimate is updated with respect to the last measurement zk according to 

Let us start with the motivational example illustrating the impact of the scaling parameter on the UKF performance. The considered model, describing the bearings-only tracking [3], is of the form 

**==> picture [193 x 25] intentionally omitted <==**

**==> picture [198 x 23] intentionally omitted <==**

**==> picture [211 x 12] intentionally omitted <==**

**==> picture [188 x 22] intentionally omitted <==**

**==> picture [221 x 13] intentionally omitted <==**

**==> picture [230 x 25] intentionally omitted <==**

where k = 0; 1; . . . ; N , N = 500 , p(x0) = N fx0 : [20; 5][T] ; 0:1 0:1 0:05 I2g , Qk = , Rk = 0:025 , 8 k . 0:05 0:1 

**==> picture [215 x 12] intentionally omitted <==**

**==> picture [16 x 9] intentionally omitted <==**

The state is estimated using five UKFs with the scaling parameter equal to = 0 , 1, 2, 3, 4. The filter performance is measured by the mean-squared error using M = 10[3] Monte Carlo simulations, i.e., 

where the measurement predictive moments (18)–(20) are computed according to (13)–(15) considering ^x as ^xkjk�1 , Px as Pkjk�1 , g( ) as hk( ) , y^[UKF] as ^zkjk�1 , Py[UKF] as Pz;kjk�1 , and Pxy[UKF] as Pxz;kjk�1 . Step 3: The predictive statistics are given by relations 

**==> picture [197 x 34] intentionally omitted <==**

**==> picture [211 x 13] intentionally omitted <==**

where x[(] i;k[m][)][is the][ i][-th component of the true state in the][ m][-th simula-] tion at time k and x^[(] i;k[m] j[)] k[is its filtering estimate.] 

**==> picture [126 x 11] intentionally omitted <==**

**==> picture [164 x 12] intentionally omitted <==**

In Table I, the resulting MSEs are summarized. It can be seen that although the recommended choice of the scaling parameter is = 3 � nx = 1 according to [8] and = 0 according to [10], none of these lead to the highest estimate quality. Higher estimate quality is achieved by larger scaling parameter settings ( = 2; 3; 4) . Therefore, the scaling parameter is still rather a user-defined parameter. 

where the state predictive moments (21) and (22) are computed according to (13) and (14) considering x^ as x^kjk , Px as Pkjk , g( ) as fk( ) , y^[UKF] as x^k+1jk , and Py[UKF] as Pk+1jk . 

Let k = k + 1 . The algorithm then continues by Step 2. 

Table I demonstrates that the proposed rules and recommendations concerning parameter choice need not lead to the best results. One of the reasons of these results is that the scaling parameter is chosen _a priori,_ without respecting particular system description. At best, its standard choice depends on the system order. The question which may arise is: How to choose the scaling parameter respecting the system description? 

The only remaining and crucial question in design of the UKF is selection of the scaling parameter which is discussed in Section III. 

## III. SCALING PARAMETER—ANALYSIS AND ADAPTIVE SETTING 

It can be shown that the UKF with = 0 and the CKF, although based on completely different ideas, are identical algorithms. The identity can, however, be interpreted as having two different recommendations how to choose the scaling parameter for the UKF. 

To answer the question correctly, it is necessary to analyse the approximation error induced by the UT with respect to the choice of the scaling parameter. 

The recommendations come from different incentives but in the end one should answer the question which one of these recommendations is more suitable for a given state estimation problem or nay if there is another choice of the scaling parameter leading to higher estimate quality than the two recommendations. And the train of thoughts may continue with the question whether it is reasonable for the scaling parameter to be constant or it might be better to adapt it in time. 

## _B. Analysis of Mean Approximation Error_ 

The analysis will study an error between the mean y^ of a random variable y from Section II-A and its UT approximation y^[UKF] given ibidem. The error, denoted as y~ , is given by 

**==> picture [220 x 26] intentionally omitted <==**

This section aims to provide answers for the questions based on discussion regarding choices of the scaling parameter of the UKF, numerical illustration, and theoretical analysis. After that a novel technique for the parameter setting is proposed. 

where p(x) is the pdf of x . The pdf will be supposed to be Gaussian with mean ^x and covariance matrix Px . Now, the nonlinear function g will be replaced in (26) by its Taylor series [11] at x^ as 

_A. Standard Choice of the Scaling Parameter and Motivational Example_ 

**==> picture [185 x 26] intentionally omitted <==**

scaling parameterAn analysis given = 3 in � [8] n leads x , nx to 3 the. To prevent the loss of positiverecommended setting of the g x g x j=1 j! n x � x T semi-definiteness, should be chosen to be zero for nx > 3 . Another d[j] g(x) ^ possible setting is = 0 , 8 nx according to the CKF. These different dx[j] x=^x(x � x) Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply. 

**==> picture [131 x 25] intentionally omitted <==**

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2414 

where A B denotes the Kronecker product of matrices A and B , A[n] denotes the n -th Kronecker power of A and the vector derivative of order k of g by x is defined as 

Finally, the standard choice of the scaling parameter = 3 � nx was designed so that the relation (34) holds even for l = 2 . In such case the UT approximation error is given by 

**==> picture [233 x 35] intentionally omitted <==**

and the vec operator is a mapping defined as 

**==> picture [192 x 39] intentionally omitted <==**

where A is a p q matrix and ai is its i -th column, i.e., vec : p q ! pq in this case. Using the Taylor series, the UT approximation error is given by 

**==> picture [236 x 120] intentionally omitted <==**

**==> picture [240 x 28] intentionally omitted <==**

Although = 3 � nx is a straightforward choice to use the scaling parameter to eliminate the fourth order term of the sum (33), the remaining terms (35) may cause an error of a larger magnitude than the eliminated one T4(x)Nfx : x^; Pgdx � 2i=0n[W][i][T][4][(][X][i][)][ based on] the mean ^x and covariance matrix Px and naturally based on the function g . 

In the context of the dynamical state estimation, the scaling parameter thus depends on the functions in the state and measurement equations, properties of the noises, and on the particular operating point, i.e., on the estimated means and covariance matrices. 

As a result, there may be a scaling parameter choice, probably different from the standard one (see Table I indicating better choice according to the MSE to be = 4 ), which minimizes the error (33). 

A natural approach to reduce the approximation error within the UKF context is to find an optimal scaling parameter by minimizing (33). But such an approach would not be wise as the scaling parameter is also used to calculate the covariance matrices Py and Pxy approximates and their approximation errors should be taken into account as well. Thus, the minimization with respect to estimation errors of ^y , Py , and Pxy would be computationally intensive and unacceptable. Note that exact evaluation of the error is possible only for special cases such as polynomial functions g . 

For clarity purposes, the following notation will be introduced: 

**==> picture [252 x 36] intentionally omitted <==**

Now, using the identities g(^x)N fx : x^; Pgdx = g(^x) and 2i=0n[W][i][=][1][, it holds that] 

**==> picture [240 x 60] intentionally omitted <==**

From the fact that odd central moments of a multivariate normally distributed random variable are zero, it follows that Tj (x)Nfx : x^; Pgdx = 0 for j odd. Also, as the sigma-points are placed symmetrically around the mean, the relation (Xi � x^)[j] = �(Xn +i[�][x][^][)][j] 2n 1 holds for j odd and consequently i=0[W][i] j=1[T][j][(][X][i][)] = 0 for j odd. 

The UT approximation error is then 

**==> picture [240 x 28] intentionally omitted <==**

Further, the sigma-points fXigi[2] =0[n][and the weights][ fW][i][g] i[2] =0[n][given by] (9)–(11) were designed so that for l = 1 

**==> picture [198 x 27] intentionally omitted <==**

**==> picture [9 x 21] intentionally omitted <==**

## _C. Methods for Selection of the Scaling Parameter_ 

Besides the above mentioned standard choice of the scaling parameter, there is a possibility to compute the scaling parameter off-line [12]. The approach estimates the scaling parameter (or set of parameters) _a priori_ to the experiment using the discriminative learning method (maximizing the likelihood function) and training set of data. As the parameter is identified _a priori,_ there is no computational overhead of the filtering algorithm. Another advantage can be seen in possible estimation of the noise covariance matrices. The weakness of such approach lies in the necessity to have a training data set including not only the input and measurement sequences but also a highly accurate measurement of the state or a subset of the state that is used solely for the purpose of training. 

This property subsequently induces the main disadvantage of the method, change of the working point requires a new training procedure. Based on the analysis given above this approach is not suitable for dynamical system changing the operating point often because the UT error (and the selection of the scaling parameter) depends on the estimated state statistics. For these systems an on-line adaptive technique for the scaling parameter selection seems to be natural option. 

As no technique for the adaptive setting of the scaling parameter has been proposed, the next part is devoted to design of the technique. 

## _D. Adaptive Setting of the Scaling Parameter_ 

The proposed adaptive technique for the scaling parameter setting is based on choosing a parameter achieving the highest value of a criterion within a set of feasible scaling parameters. This choice will be made before the filtering step at each time instant. 

As the criterion, the likelihood function can be chosen. The likelihood function p(zkjz[k][�][1] ) is generally unknown. However, as argued 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2415 

TABLE II 

MSE, AVERAGE FILTERING COVARIANCE, AND COMPUTATIONAL COSTS OF THE UKFS FOR DIFFERENT CHOICES OF 

**==> picture [450 x 49] intentionally omitted <==**

in [10], it can be approximated by the Gaussian pdf in some cases. The approximate likelihood function is given by 

**==> picture [220 x 12] intentionally omitted <==**

and it depends on due to the -depending measurement predictive statistics. As the measurement zk is available at the time instant k , the estimate of the parameter achieving the highest likelihood at time k is of the form 

**==> picture [180 x 16] intentionally omitted <==**

where K = f : min 2 ; max 2 ; min maxg is a set of feasible scaling parameters guaranteeing positive definiteness of the covariance matrix. Thus, the lower bound min is usually chosen to be zero and the upper bound is suggested not to exceed max = 9nx which ensures that the weight of the central sigma-point X0 is W0 = 2n 0:9 and sum of weights of remaining points is i=1[W][i][=][0][:][1][. That] means the effect of non-central sigma-points is not negligible. 

In most cases it is not possible to find a closed-form solution to relation (37) with respect to relations (18) and (19) and it is necessary to use a numerical technique. As suitable techniques the following two can be mentioned. First, a numerical “grid method” which covers a feasible maximization domain h min; maxi within is sought by an equally spaced grid of points. The likelihood function is evaluated in these points and the point with maximal value of the likelihood is chosen and considered to be the resulting estimate ^k (37). Second, the global “adaptive random search maximization method” seems to be suitable because it is applicable also to non-differentiable or discontinuous functions [13]. 

Note that other criteria may be used for adaptation of the scaling parameter [14]. They are based on moments only and do not require Gaussian approximation of the likelihood function. 

Also note that utilizing the maximum likelihood criterion is frequently used for simultaneous state and parameter estimation, where the parameter is a part of the system model, see e.g., [15] for an on-line procedure or [16] for an off-line procedure. 

## _E. Unscented Kalman Filter With Adaptive Setting of Scaling Parameter_ 

The algorithm of the UKF with the adaptive setting of the parameter can be summarized as follows: 

- Step 1: Set the time instant k = 0 and define _a priori_ initial condition as x^0j�1 = x0 and P0j�1 = P0 . 

- Step 2: The scaling parameter ^k is computed to achieve the highest likelihood (36). 

- Step 3: The filtering statistics x^kjk , Pkjk are given by relations (16)–(17) with = ^k . 

- Step 4: The predictive statistics x^k+1jk , Pk+1jk are given by relations (21)–(22) with = ^k . 

- Let k = k + 1 . The algorithm then continues by Step 2. 

The only condition of application of the adaptive technique in the UKF is that the approximate likelihood function (36) has to be -dependent. For example, for a linear function in the measurement equa- 

tion the likelihood does not depend on and application of the adaptive algorithm is useless. 

Note that any of the derivative-free local filters with a scaling parameter can be straightforwardly supplemented with the adaptive algorithm for selecting the parameter. 

## IV. NUMERICAL ILLUSTRATION 

The UKF with the adaptive setting of the scaling parameter can be illustrated using the model (23) and (24). Besides the MSE (25), the filter performance will also be measured using the criterion characterizing the average filtering covariance matrix Pkjk given by 

**==> picture [167 x 35] intentionally omitted <==**

where jP[(] k[m] jk[)][j][is][the][determinant][of][the][filtering][covariance][matrix][at] the m -th simulation. 

Table II summarizes the results for six fixed values and four adaptive choices of . The notation 2 f min : step : maxg means that the likelihood function (36) is maximized at each time instant k by means of the grid method on interval min and max with the increment step . 

To demonstrate the advances of adaptive specification of the scaling parameter, an off-line estimate of the scaling parameter was also computed by maximizing prediction likelihood [12], [17] using 100 training simulations. The estimated value of the scaling parameter was = 6:09 and the MSE of the UKF estimate using this parameter was MSE = 5:67 . Note that the MSE is in this case even higher than for example for the UKF with an ad hoc choice = 8 . The reason is that the training data were different from the data used for the estimation experiment. Moreover, the optimization criterion (maximum predictive likelihood) is different from the criterion (MSE) used for assessment of the filter performance. 

From the table it can be seen that the adaptive setting of the scaling parameter with respect to maximization of the likelihood function has a significant impact on the improvement of the estimation quality measured by the MSE. In this case, the impact of the chosen increment step is rather insignificant. The reason is the likelihood function p^(zkjz[k][�][1] ; k) is at most time instants monotonous on given interval min = 0 and max = 4 and the scaling parameter estimate ^k usually lies on the bounds. This is illustrated by Fig. 1 where maximum likelihood estimates ^k are shown. From the figure, it also follows that an off-line specification of a constant scaling parameter would bring a worse estimation quality. The last row in Table II illustrates average computational costs in seconds necessary for computation of the filtering and prediction step at one time instant. It can be seen that better results can be obtained by the UKF with the adaptive setting of the scaling parameter with a slight increase of the computational demands (as in the case of the UKF( = f0 : 4 : 4g) . For completeness, a typical example of the true and estimated state behavior is shown in Fig. 1. It should be noted that contrary to the UKF( 2 f0 : 0:1 : 4g) with the adaptive setting of the parameter, the UKF( = 2) with fixed occasionally provides significantly worse estimation quality. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 57, NO. 9, SEPTEMBER 2012 

2416 

**==> picture [285 x 243] intentionally omitted <==**

Fig. 1. Typical example of the true and estimated state and values of the scaling parameter with respect to maximization of the approximate likelihood function. 

Mention that further simulation studies comparing different filters (also with other types of scaling parameter estimation schemes) in different simulation scenarios can be found e.g., in [12], [14], [18]. 

## V. CONCLUDING REMARKS 

In this technical note, the unscented Kalman filter was discussed with respect to the choice of the scaling parameter. The crucial importance of the scaling parameter selection for the filter performance was illustrated using a numerical example. It was shown that the estimation performance can differ by an order of magnitude for different choices of the parameter; moreover, the commonly used recommended parameter values need not lead to the best performance. Motivated by the numerical results, the UKF was analyzed and the novel adaptive algorithm for the setting of the scaling parameter was proposed. According to the numerical simulations, the UKF with the adaptive scaling parameter significantly outperforms a fixed parameter UKF. The adaptive algorithm can be also easily incorporated into any local filter having the scaling parameter (e.g., the divided difference filters). 

## ACKNOWLEDGMENT 

The authors wish to thank the reviewers for very useful and constructive feedback. 

## REFERENCES 

- [1] B. D. O. Anderson and J. B. Moore _, Optimal Filtering_ . Englewood Cliffs, NJ: Prentice-Hall, 1979. 

- [2] H. W. Sorenson, “On the development of practical nonlinear filters,” _Inform. Sci._ , vol. 7, pp. 253–270, 1974. 

- [3] M. Simandl,[ˇ] J. Královec, and T. Söderström, “Anticipative grid design in point-mass approach to nonlinear state estimation,” _IEEE Trans. Autom. Control_ , vol. 47, no. 4, pp. 699–702, Apr. 2002. 

   - [6] K. Ito and K. Xiong, “Gaussian filters for nonlinear filtering problems,” _IEEE Trans. Autom. Control_ , vol. 45, no. 5, pp. 910–927, May 2000. 

   - [7] M. Simandl[ˇ] and J. Duník, “Derivative-free estimation methods: New results and performance analysis,” _Automatica_ , vol. 45, no. 7, pp. 1749–1757, 2009. 

   - [8] S. J. Julier, J. K. Uhlmann, and H. F. Durrant-White, “A new method for the nonlinear transformation of means and covariances in filters and estimators,” _IEEE Trans. Autom. Control_ , vol. 45, no. 3, pp. 477–482, Mar. 2000. 

   - [9] S. J. Julier and J. K. Uhlmann, “Unscented filtering and nonlinear estimation,” _Proc. IEEE_ , vol. 92, no. 3, pp. 401–421, Mar. 2004. 

   - [10] I. Arasaratnam and S. Haykin, “Cubature Kalman filters,” _IEEE Trans. Autom. Control_ , vol. 54, no. 6, pp. 1254–1269, Jun. 2009. 

   - [11] T. Kollo and D. von Rosen _, Advanced Multivariate Statistics With Matrices, Volume 579 of Mathematics and Its Applications_ . Berlin, Germany: Springer, 2005. 

   - [12] A. Sakai and Y. Kuroda, “Discriminatively trained unscented Kalman filter for mobile robot localization,” _J. Adv. Res. Mech. Eng._ , vol. 1, no. 3, pp. 153–161, 2010. 

   - [13] É. Walter and L. Pronzato _, Identification of Parametric Models From Experimental Data_ . Berlin, Germany: Springer, 1997. 

   - [14] O. Straka, J. Duník, and Simandl,[ˇ] “Gaussian sum unscented Kalman filter with adaptive scaling parameters,” in _Proc. 14th Int. Conf. Information Fusion_ , Chicago, IL, Jul. 2011. 

   - [15] G. Pillonetto and S. Carpin, “Multirobot localization with unknown variance parameters using iterated Kalman filtering,” in _Proc. 2007 IEEE Int. Conf. Intelligent Robots and Systems_ , 2007. 

   - [16] N. Kristensen, H. Madsen, and S. B. Jorgensen, “Parameter estimation in stochastic grey-box models,” _Automatica_ , vol. 40, no. 2, pp. 225–237, 2004. 

   - [17] P. Abbeel, A. Coates, M. Montemerlo, A. Y. Ng, and S. Thrun, “Discriminative training of Kalman filters,” in _Proceedings of Robotics: Science and Systems_ , Cambridge, MA, Jun. 2005. 

   - [18] O. Straka, J. Duník, and M. Simandl, “Performance evaluation of local[ˇ] state estimation methods in bearings-only tracking problems,” in _Proc. 14th Int. Conf. Information Fusion_ , Chicago, IL, Jul. 2011. 

- [4] M. Nørgaard, N. K. Poulsen, and O. Ravn, “New developments in state estimation for nonlinear systems,” _Automatica_ , vol. 36, no. 11, pp. 1627–1638, 2000. 

- [5] T. S. Schei, “A finite-difference method for linearization in nonlinear estimation algorithms,” _Automatica_ , vol. 33, no. 11, pp. 2053–2058, 1997. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on May 05,2026 at 13:29:49 UTC from IEEE Xplore.  Restrictions apply.