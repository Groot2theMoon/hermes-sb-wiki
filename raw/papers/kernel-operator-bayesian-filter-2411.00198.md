---
title: "Kernel Operator-Theoretic Bayesian Filter for Nonlinear Dynamical Systems"
arxiv: "2411.00198"
authors: ["Kan Li", "José C. Príncipe"]
year: 2024
source: paper
ingested: 2026-05-11
sha256: 26a19dfabc100ff5424530abe8b1af28aaaf377a18f08ddd07c280a32e4e3b2c
conversion: pymupdf4llm
---

1 

# Kernel Operator-Theoretic Bayesian Filter for Nonlinear Dynamical Systems 

Kan Li, Member, IEEE and Jos´e C. Pr´ıncipe, Life Fellow, IEEE 

Abstract—Motivated by the surge of interest in Koopman operator theory, we propose a machine-learning alternative based on a functional Bayesian perspective for operator-theoretic modeling of unknown, data-driven, nonlinear dynamical systems. This formulation is directly done in an infinite-dimensional space of linear operators or Hilbert space with universal approximation property. The theory of reproducing kernel Hilbert space (RKHS) allows the lifting of nonlinear dynamics to a potentially infinite-dimensional space via linear embeddings, where a general nonlinear function is represented as a set of linear functions or operators in the functional space. This allows us to apply classical linear Bayesian methods such as the Kalman filter directly in the Hilbert space, yielding nonlinear solutions in the original input space. This kernel perspective on the Koopman operator offers two compelling advantages. First, the Hilbert space can be constructed deterministically, agnostic to the nonlinear dynamics. The Gaussian kernel is universal, approximating uniformly an arbitrary continuous target function over any compact domain. Second, Bayesian filter is an adaptive, linear minimum-variance algorithm, allowing the system to update the Koopman operator and continuously track the changes across an extended period of time, ideally suited for modern data-driven applications such as real-time machine learning using streaming data. In this paper, we present several practical implementations to obtain a finite-dimensional approximation of the functional Bayesian filter (FBF). Due to the rapid decay of the Gaussian kernel, excellent approximation is obtained with a small dimension. We demonstrate that this practical approach can obtain accurate results and outperform finite-dimensional Koopman decomposition. 

Index Terms—Functional Bayesian filter, kernel adaptive filtering (KAF), kernel method, nonlinear dynamical system, reproducing kernel Hilbert space (RKHS), Koopman operator theory. 

## I. INTRODUCTION 

The recent surge of interest in the field of dynamical systems is closely tied to the emergence of statistical learning and machine learning (ML), fueled by the increasing abundance of data with advances in sensing and data acquisition technologies across all disciplines, especially engineering, biological, physical, and social sciences, revolutionizing our ability to analyze complex systems and relationships in real time, utilizing rich multi-modal and multi-fidelity time-series data. 

A plethora of mathematical models and algorithms have arisen to meet this demand. Among them, deep neural networks (DNNs) stands out as particularly popular, with its foundational learning components inspired by biological neurons [1]. Algorithms grounded in DNNs have made significant 

This work was supported by the ONR grant N00014-23-1-2084. The authors are with the Computational NeuroEngineering Laboratory, University of Florida, Gainesville, FL 32611 USA (e-mail: likan@ufl.edu; principe@cnel.ufl.edu). 

strides in fields such as image classification, speech recognition, and natural language processing, surpassing even humanlevel performances [2]–[5]. While accuracy and interpretability are not necessarily mutually exclusive, in the field of deep learning, the extraordinary achievements in performance often comes at the detriment of the other [6]. Furthermore, these successes predominantly involve static pattern recognition or generation tasks. Deep learning methodologies become brittle and face significant challenges in dynamically changing environments [7], [8], such as those found in autonomous driving, due to their limited adaptation to temporal dynamics. In contrast, the dynamical system framework naturally accommodates translations in time, and the understanding of dynamics is of paramount importance. 

Dynamical systems theory has a rich history of utilizing data to enhance modeling insights, develop parsimonious and interpretable models, and enable forecasting capabilities. In 1960, Kalman famously introduced a mathematical framework allowing the combination of observations and models through data assimilation techniques, particularly useful for forecasting and control [9]. The integration of streaming data and dynamical models has a history of nearly seven decades. In the modern era, there is a growing trend to construct dynamical models directly from data using machine learning, especially in complex systems lacking first-principles models or where the correct state-space variable is unknown [10]–[12]. 

Nonlinearity presents a major challenge in the study of dynamical systems, giving rise to a wide array of phenomena such as bifurcations and chaos, which are observed across various disciplines. Despite its importance, there is no comprehensive mathematical framework available for the explicit and general characterization of nonlinear systems: the principle of linear superposition does not apply to nonlinear dynamical systems, resulting in a range of intriguing phenomena, such as harmonics and frequency shifts [13]. Conversely, linear systems are fully characterized by their spectral decomposition (eigenvalues and eigenvectors), enabling the development of generic and computationally efficient algorithms for prediction, estimation, and control. 

The past two decades has seen a renaissance of the Koopman operator theory [14] due to its strong connections to datadriven modeling, offering a linear framework for the analysis and prediction of nonlinear behavior. Instead of directly analyzing the state space, it transforms a nonlinear dynamical system into a linear one in an infinite-dimensional space of observables (functions of the state). The Koopman operator advances these observables in time, offering a linear perspective on the evolution of the system, even if the underlying system is 

2 

nonlinear, with its spectral decomposition fully characterizing the behavior of the nonlinear system. 

This operator theoretic perspective of dynamical systems was initially introduced to describe the evolution of measurements (flows) of Hamiltonian systems in 1931 [14]. In the following year, it was generalized by Koopman and von Neumann to systems with a continuous eigenvalue spectrum [15]. The Koopman operator also played a central role to the ergodic theory by von Neumann [16] and Birkhoff [17]. More recently, Rowley et al. [18] connected the Koopman mode decomposition, introduced by Mezi´c in 2005 [19], with the dynamic mode decomposition (DMD), Schmid’s numerical algorithm for fluid mechanics [20], based on the discrete Fourier transform (DFT) and the singular value decomposition (SVD), both of which provide unitary coordinate transformations [21]. Discovering tractable finite-dimensional representations of the Koopman operator is closely tied to identifying effective coordinate transformations that linearize the nonlinear dynamics. Judiciously chosen observables result in spatiotemporal features of the complex system that are physically meaningful and facilitate the application of manifold learning methods. 

Koopman theory is connected to several related concepts. The Karhunen-Lo`eve theorem [22], also known as the principal component analysis (PCA) in statistics which generally traces back more than a century to Pearson [23], provides a way to decompose a stochastic process into orthogonal functions, which can be seen as a form of optimal basis for representing the process. The relationship between the Karhunen–Lo`eve theorem and Koopman operator theory lies in their use of eigenfunctions and spectral decomposition, but with different goals and contexts. Karhunen–Lo`ve decomposes a stochastic process using eigenfunctions of the covariance operator, identifying dominant modes of variation, while Koopman decomposes the evolution of observables using eigenfunctions of the Koopman operator, revealing the underlying structure of a nonlinear dynamical system. Karhunen–Lo`eve provides a linear representation of the data variability, useful for dimensionality reduction, while Koopman provides a linear representation of a nonlinear dynamical system’s evolution in an infinite-dimensional space, aiding in the understanding and prediction of complex dynamics. Both methods can be used to analyze dynamical systems, but Koopman is specifically designed to handle nonlinear dynamics by leveraging linear operator theory on observables. Karhunen–Lo`eve, on the other hand, focuses on the statistical properties of the data generated by the system. DMD, in the context of Koopman spectral analysis, generates a collection of modes, each linked to a constant oscillation frequency and a decay/growth rate. Unlike PCA, which yields orthogonal modes without predetermined temporal characteristics, DMD captures inherent temporal patterns within each mode. It does not assume linearity, and, unlike proper orthogonal decomposition (POD), the basis functions represented by the Koopman modes are not necessarily orthogonal [24], with the growth rate determined by its real part, and its frequency identified by the imaginary part. Although DMD-based representations may be less parsimonious compared to PCA due to their non-orthogonal nature, they offer greater physical significance 

**==> picture [185 x 145] intentionally omitted <==**

Fig. 1. In a discrete-time nonlinear dynamical system, the nonlinearity generates a nonlinear manifold on which the time-series xi resides. DMD approximates the evolution on a nonlinear manifold using a least-squares fit linear dynamical system. The Koopman operator linearizes the space the data is embedded. Similarly, in the theory of the RKHS, the input data is mapped to a higher-dimensional functional space where a linear operator F advances the states of the system, approximating the general nonlinear transition function f (·) in the input space. 

since each mode corresponds to a damped or driven sinusoidal behavior over time. 

Koopman operator theory is also closely related to the theory of reproducing kernel Hilbert space (RKHS) [25] or kernel methods [26]. Both operate in a potentially infinite feature space and are data-driven. Koopman operates in the space of observables, which can be infinite-dimensional, while kernel methods operate in a functional space induced by a reproducing kernel, which can be infinite-dimensional depending on the kernel choice. Koopman linearizes the dynamics by considering the temporal evolution in an infinite-dimensional space of observables. Kernel methods, on the other hand, simplify the design of classification or regression problems by mapping data into a higher-dimensional (potentially infinite) linear feature space (nonlinear relative to the input space) where linear methods can be applied. The effectiveness of Koopman methods hinges primarily on selecting an appropriate set of observables. An important practical consideration is the computational cost as the number of observables or feature dimension increases. Central to the idea of kernel methods is the kernel trick: instead of considering the actual space of features, a kernel function is used to consider a large class of potential observables without considering the actual observation vector, making the computation efficient and tractable. Using this compact representation of the feature space, kernelized versions of DMD implicitly compute the inner products required for the Koopman decomposition [27], [28]. Fig. 1 illustrates the underlying principle in the RKHS and Koopman operator theoretic view. 

Despite the overwhelming usefulness of both methods, there still exist significant gaps between the two theories. Koopman operator theory does not provide insights on how to construct the space of infinite-dimensional observables or its finite approximation for a particular application, and its performance is sensitive to the choice of observables. Physically interpretable spatiotemporal features have to be judiciously chosen and can be prohibitively challenging and may rival that of first- 

3 

principles modeling. Conventional kernel methods, on the other hand, take the infinite-dimensional space for granted (automatically induced by an appropriate reproducing kernel function), but lack instructions on how to properly handle dynamics in the RKHS. 

There are also many practical issues using kernels. Despite circumventing the need to consider the actual dimension of the RKHS, the computational complexity of kernel methods can grow linearly and superlinearly with the number of data points or time steps, without introducing additional sparsification techniques. This becomes especially problematic for time series with complex dynamics and where the temporal dimension is significantly larger than the spatial dimension, e.g., streaming data. Furthermore, not having an explicit mapping of the input data gives rise to the problem of finding the preimage of a feature vector in the RKHS induced by a kernel. 

The major contribution of this paper is a novel algorithm that bridges the two concepts for dynamical systems analysis by combining the best of both worlds: a completely datadriven approach that maps nonlinear dynamics to a finitedimensional RKHS using predetermined, explicit mapping, and applies classical linear recursive Bayesian estimation on the feature-space state variables to derive a nonlinear solution in the original input space. 

The current development represents the next phase in the evolution of research on kernel adaptive filtering (KAF) for discrete-time nonlinear dynamical systems. We first proposed a full state-space representation of a general nonlinear dynamical model over an RKHS and its learning algorithm called the kernel adaptive autoregressive-moving-average (KAARMA) in [29], then followed up with a general nonlinear Bayesian inference for high-dimensional state estimation or the functional Bayesian filter (FBF) [30]. In [31], we showed that an equivalent, finite-dimensional Hilbert space can be constructed using numerical integration methods such as Gaussian quadrature (GQ) and Taylor series (TS) expansion that leads to significant savings in performing KAF on streaming data with comparable performance to their infinite dimensional counterparts and avoids the pre-image problem plaguing conventional kernel methods. We combine these features here to propose an explicit-space functional Bayesian filter (expFBF) that constructs a suitable finite-dimensional RKHS a priori that linearizes the dynamics, then recursively learn and track the linear dynamics using Bayesian update. 

The Kalman filter is the most popular Bayesian method that provides an analytical linear solution to estimate the target state while minimizing the error associated with the estimation. It is optimal for linear dynamical systems under additive noise with finite second-order moments, recursively estimating the state by combining predictions from a model with measurements, updating the state estimates and uncertainties over time. The major shortcoming of the Kalman approach is that the dynamics are assumed known. Kernel methods can map the input data into a higher-dimensional feature space where the dynamics are linearly separable, allowing the use of Kalman filtering in that space, but without precise knowledge of the system dynamics (real-world applications often involve unknown and nonstationary transformations), the performance 

TABLE I 

KEY FEATURES OF THE KOOPMAN THEORY AND RKHS. 

|Property<br>Theory|Koopman Operator<br>(DMD)|KAF<br>(Explicit-Space FBF)|
|---|---|---|
|Feature Space<br>Dimension|unknown<br>(requires judicious selection)<br>fnite to ∞|induced by kernel<br>(predetermined)<br>fnite to ∞<br>(fnite)|
|Data<br>Duration|data-driven + expert knowledge<br>(batch)<br>short-term|data-driven<br>(online)<br>long-term|
|Dynamics|nonlinear|nonlinear|
|Stationarity<br>Performance|stationary<br>sensitive to choice<br>of observables|nonstationary<br>(tracks the posterior)<br>robust<br>(minimum variance)|



suffers due to parametric errors in the model. The FBF [30] is a purely data-drive approach that constructs a state-space representation of the data in an RKHS and jointly estimates the model parameters and the states of the linear dynamical system, recursively updating not only the weight changes, but also the state variables (activities in the learning network) in response to the weights while minimizing their respective uncertainties. This enables continuous learning and tracking of complex dynamics over a long-term that the conventional Koopman operator theory cannot. We summarize the key attributes of both paradigms in Table I. 

Motivated by the above discussion, we propose an operatortheoretic data-fusion approach for learning the Koopman operator, formulated directly in the finite-dimensional space of linear operators or RKHS. The rest of this paper is organized as follows. In Section II, state-space model in the RKHS is reviewed, followed by the finite-dimensional explicit-space RKHS. In Section III we present the proposed explicit-space functional Bayesian filter algorithm. Section IV shows the experimental results for unknown chaotic time series and nonlinear partial differential equation (PDE), comparing our novel method with several existing algorithms including the DMD and Koopman methods. Finally, Section V concludes this paper. 

II. BAYESIAN FILTERING IN THE RKHS 

**==> picture [207 x 57] intentionally omitted <==**

Fig. 2. General state-space model for dynamical system. 

For nonlinear dynamical systems, we are interested in estimating the state variables recursively via the sequence of noisy measurements (observations) dependent on the state. Let a dynamical system (Fig. 2) be defined in terms of a general nonlinear state-transition and observation functions, f(·, ·) and h(·), respectively, 

**==> picture [176 x 26] intentionally omitted <==**

4 

where 

**==> picture [239 x 44] intentionally omitted <==**

with input ui ∈ R[n][u] , state xi ∈ R[n][x] , output yi ∈ R[n][y] , additive dynamic noise wi, and observation noise v are statistically independent processes of zero mean and known covariance matrices, and the parenthesized superscript[(][k][)] denotes the k- th column of a matrix or the k-th component of a vector. For versatility, the input, state, and output variables have independent degrees of freedom (dimensionality). 

We can simplify the expression above by expressing the dynamical system equations (1-2) in terms of a new hidden state vector 

**==> picture [202 x 70] intentionally omitted <==**

where Iny is an ny × ny identity matrix, 0 is an ny × nx zero matrix, and ◦ is the function composition operator. This augmented state vector si ∈ R[n][s] is formed by concatenating the output yi with the original state vector xi, i.e., an augmented state with dimension ns = nx + ny. With this rewriting, the measurement equation simplifies to a fixed selector matrix I =∆ 0 Iny . Despite the parsimonious structure of (6), there � � is no restriction on the measurement equation, as h ◦ f in (5) is its own set of general nonlinear equations, i.e., this is functionally equivalent to the generative model in Fig. 2. 

Next, we define an equivalent transition function g(si−1, ui) = f(xi−1, ui) using the augmented state variable s as argument. The dynamic system in (1-2) becomes 

**==> picture [186 x 11] intentionally omitted <==**

**==> picture [186 x 11] intentionally omitted <==**

The theory of RKHS enables the lifting of the dynamics to a potentially infinite-dimensional space via linear embeddings, where a general nonlinear function is represented as a set of linear weights (operators) Ω in the feature (functional) space. To learn the general continuous nonlinear transition and observation functions, g(·, ·) and h ◦ g(·, ·), respectively, we map the augmented state vector si and the input vector ui into separate RKHSs as ϕ(si) ∈Hs and φ(ui) ∈Hu. By the representer theorem, the state-space model defined by (7-8) can be expressed as the following set of weights (functions) ∆ in the joint RKHS Hsu = Hs ⊗Hu: 

**==> picture [181 x 31] intentionally omitted <==**

where ⊗ is the tensor-product operator. This formulation preserves the functionalities of the separate state-transition and observation equations while consolidating them into a single set of weights in the RKHS (i.e., a single, parsimonious network), which greatly facilitates the construction of an empirical model and the adaptation of parameters. 

Finally, the state-space model in the RKHS becomes 

**==> picture [168 x 27] intentionally omitted <==**

where new features were defined using a tensor-product in [29] and [30] as 

**==> picture [206 x 14] intentionally omitted <==**

## A. Finite-Dimensional RKHS 

In [31], we demonstrated that for continuous shift-invariant kernel functions, such as the Gaussian, one can construct finite-dimensional explicit mappings or deterministic features that define an approximately equivalent reproducing kernel and achieve similar performances in KAF using a fixed finitedimensional weight vector. This new kernel can approximate the original universal kernel to arbitrary accuracy with appropriate truncation of the Taylor series or Hermite polynomial expansion. This not only enables efficient implementations of KAF, but also, more importantly, allows access to the pre-image or reverse mapping, without compromising performance. For completeness, we summarize the findings below. 

Theorem 1 (Bochner, 1932 [32]). A continuous shift-invariant properly-scaled kernel k(x, x′) = k(x − x′) : R[d] × R[d] → R, and k(x, x) = 1, ∀x, is positive definite if and only if k is the Fourier transform of a proper probability distribution. 

**==> picture [252 x 68] intentionally omitted <==**

where ⟨·, ·⟩ is the Hermitian inner product ⟨x, x′⟩ =[�] i[x][i] x′i, and ⟨e[j][ω][⊺][x] , e[j][ω][⊺][x][′] ⟩ is an unbiased estimate of the properly scaled shift-invariant kernel k(x − x′) when ω is drawn from the probability distribution p(ω). 

Typically, we ignore the imaginary part of the complex exponentials to obtain a real-valued mapping. This can be further generalized by considering the class of kernel functions with the following construction 

**==> picture [203 x 24] intentionally omitted <==**

**==> picture [253 x 65] intentionally omitted <==**

with feature space R[D] and {vi}[D] i=1[sampled][independently] from the spectral measure. 

Instead of using random features to construct the explicit Hilbert space, which yields large variances in performance, related to the location of the expansion points vi, especially for smaller dimensions, we can approximate the integral in (13) with a discrete sum of judiciously selected points. An explicit finite-dimensional RKHS using Gaussian quadrature can accurately approximate the continuous shift-invariant kernel including all sub-Gaussian densities as k(x, x′) : X × 

5 

X → R ≈ φ[�] (x)[⊺] φ[�] (x′), where φ[�] : X → R[D] defines an explicit mapping to a finite-dimensional feature space [31], [33]. Here, we are primarily concerned with the Gaussian kernel since it is universal, i.e., approximates an arbitrary continuous function uniformly on any compact subset of the input space [34]. Nonetheless, any kernel function can be approximated by its convolution with the Gaussian, resulting in a significantly smaller approximation error than the noise from data generation. 

Specifically, we consider the Gauss–Hermite quadrature, which employs Hermite polynomials which are the eigenfunctions of the Gaussian kernel and form a Hermite spectral decomposition. To extend one-dimensional GQ (accurate for polynomials up to degree R) to higher dimensions, the following must be satisfied 

**==> picture [228 x 31] intentionally omitted <==**

for all r ∈ N[d] such that[�] l[r][l][≤][R][,][where][ e][l][are][the][standard] basis vectors. 

To construct GQ features, we can randomly select points ωi, then solve (17) for the weights ai using non-negative least squares (NNLS) algorithm. This works well in low dimensions, but for larger values of d and R, grid-based quadrature rules can be constructed more efficiently. 

The major drawback of the grid-based construction is the lack of fine tuning for the feature dimension. Since the number of samples extracted in the feature map is determined by the degree of polynomial exactness, even a small incremental change can cause a significant increase in the number of features. Subsampling according to the distribution determined by their weights is used to combat both the curse of dimensionality and the lack of detailed control over the exact sample number. There are also data-adaptive methods to choose a quadrature rule for a predefined number of samples [33]. 

Another useful finite-dimensional approximation is the Taylor series expansion polynomial features [35], a special case in the class of analytic positive definite multivariate functions called the power series kernels [36], where each term is expressed as a sum of matching monomials in x and x′, i.e., 

**==> picture [230 x 17] intentionally omitted <==**

We can easily factor out the terms that depend on x and x′ independently. The cross term in (18) can be expressed as a power series or infinite sum using Taylor polynomials as 

**==> picture [188 x 28] intentionally omitted <==**

This produces the following explicit feature map 

**==> picture [194 x 30] intentionally omitted <==**

yielding 

**==> picture [230 x 11] intentionally omitted <==**

**==> picture [195 x 29] intentionally omitted <==**

We can truncate the infinite sum to derive an approximation that is exact up to polynomials of degree r. The dimensionality 

**==> picture [252 x 145] intentionally omitted <==**

where 

and α = (α1, α2, · · · , αd) and x[α] = x[α] 1[1][x][α] 2[2][· · ·][ x][α] d[d][.] The Taylor series for e[x] has an infinite radius of convergence. The truncation error is bounded using Taylor’s theorem: 

**==> picture [247 x 43] intentionally omitted <==**

which yields the following upper bound for the difference in kernel evaluations 

**==> picture [205 x 34] intentionally omitted <==**

where |⟨x, x′⟩| ≤∥x∥∥x′∥ by the Cauchy-Schwarz inequality. For simplicity, we will express the Gaussian kernel in terms of the kernel parameter a = 2σ1[2][ ,][i.e.,][k][(][x][,][ x][′][) =][ e][−][a][∥][x][−][x][′∥][2][.] 

## III. FUNCTIONAL BAYESIAN FILTERING OVER FINITE-DIMENSIONAL RKHS 

The Bayesian solution provides a unifying framework for solving the recursive estimation of state variables in a dynamical system. Since the functions are represented as linear operators or weights Ω in the RKHS, we can apply Kalman filtering to the explicitly mapped points in the finite-dimensional Hilbert space. However, it cannot be applied directly due to the unknown dynamics. As shown in [30], the Bayesian framework further allows us to jointly estimate the states and the weights by treating Ω as part of the state variables. 

First, we construct the following linear form of the statespace representation: 

**==> picture [174 x 25] intentionally omitted <==**

where the super-augmented state vector is defined as 

**==> picture [149 x 31] intentionally omitted <==**

with si = [xi, yi][⊺] , same as in (5), and we treat the weight matrix Ωi in the RKHS at time i as an nΩ-dimensional (finite for explicit RKHS) vector rather than a matrix, via an orderly arrangement of the weight parameters (e.g., stacking each transposed row vertically). Next, the state transition matrix can be expressed in block form as 

**==> picture [171 x 30] intentionally omitted <==**

6 

**==> picture [477 x 78] intentionally omitted <==**

where F1(i) is an ns × ns matrix, F2(i) is an ns × nΩ matrix, and InΩ is an nΩ × nΩ identity matrix. The unknown weight vector is assumed to be invariant, i.e., Ωi+1 = Ωi. State transition equation (27) becomes 

From (34), the Jacobian with respect to the weights can be written in block form as F2(i) = �F[(] 2[A][)][(][i][)] F[(] 2[B][)][(][i][)] � with ∂si F[(] 2[A][)][(][i][) =] (39) ∂A(i) 

Since the network output yi is a subvector of the hidden state si, the measurement function Hi in (28) becomes a simple projection onto the last ny components of si 

**==> picture [206 x 31] intentionally omitted <==**

and 

**==> picture [162 x 24] intentionally omitted <==**

with H ∈ R[n][y][×][(][n][s][+][n][Ω][)] and I =∆ 0 Iny ∈ R[n][y][×][n][s] being a � � selector matrix. 

Note here that the weight vector is arranged element-wise in a single column as 

In [30], we used the tensor product kernel to construct the infinite-dimensional joint RKHS for the state and control inputs Hsu. Finite-dimensional explicitly defined RKHS allows us a greater degree of flexibility on how to combine the two feature spaces. Without loss of generality, we use the canonical linear state-space representation to propagate the states with a sum instead of product, replacing (10) with 

∆ ⊺ Ω = �α11, α12, · · · , αnsnψ�(s)[|][β][11][,][ β][12][,][ · · ·][,][ β][n][s][n] φ[ �] (u) � (41) where αij and βij are the elements of A and B, respectively. The a priori estimate covariance matrix is given by 

**==> picture [190 x 12] intentionally omitted <==**

where 

**==> picture [181 x 14] intentionally omitted <==**

**==> picture [159 x 11] intentionally omitted <==**

where Ai ∈ R[n][s][×][n][Ω][s] and Bi ∈ R[n][s][×][n][Ω][u] are the weight vectors for the state features ψ[�] (s) and input features φ[�] (u), respectively. Note, the tensor-product construction is more expressive (explicitly defines all the cross terms between the state and control variables as features). However, this creates more complexity in the explicit space as the number of parameters becomes multiplicative, instead of additive. Furthermore, (33) is a direct analog to the model used in discrete-time linear time-invariant (LIT) control system. 

is the process noise covariance matrix. In general, Q may have non-zero off-diagonal elements (indicating correlated state variables). However, for simplicity, we will assume diagonal matrices for the noise covariance matrices (unless specified otherwise) and, likewise, initialize the unknown state covariance P as a diagonal matrix. 

The block structure of the state transition matrix F yields the following estimated state covariance matrix decomposition 

For applications involving known nonlinear dynamics or observable state variables, we can propagate the states directly in the RKHS, i.e., 

**==> picture [158 x 31] intentionally omitted <==**

**==> picture [190 x 14] intentionally omitted <==**

**==> picture [252 x 119] intentionally omitted <==**

For the case involving only state transitions, e.g., for many nonlinear PDE problems, (34) simplifies to 

**==> picture [167 x 11] intentionally omitted <==**

Since the RKHS can be explicitly defined and is finitedimensional by construction, to obtain the inverse map, we can simply augment the feature space by concatenating the original state variables si with the mapped feature-space states (observables) ψ(s)i and output the first ns components at each time step, i.e., 

**==> picture [242 x 72] intentionally omitted <==**

**==> picture [180 x 31] intentionally omitted <==**

This is consistent with Koopman theory that allows a broader set of observables which often includes the original states as a subset. This way, the algorithm produces both a state estimation as well as the linearized nonlinearity. 

From the innovation covariance matrix 

**==> picture [252 x 40] intentionally omitted <==**

## A. Bayesian Update 

From the state-space model in (31), the state-transition matrix block in (30) consists of the following Jacobians 

7 

**==> picture [237 x 146] intentionally omitted <==**

where the following matrices store intermediate results: 

**==> picture [171 x 50] intentionally omitted <==**

**==> picture [167 x 16] intentionally omitted <==**

with L1 ∈ R[n][s][×][n][y] (last ny columns of P[−] 1[),][L][2][∈][R][n][Ω][×][n][y] (last ny rows of P[−] 2[,][transposed),][and][M][i][∈][R][n][y][×][n][y][(the] ny × ny lower-right corner of P[−] 1[)][being][submatrices][of] the decomposed state-covariance matrix P, since the linear mappings H and I are defined in (32) as simple projections onto the last ny coordinates of state si, and N is the inverse of the innovation covariance matrix. 

Clearly, the Kalman gain matrix consists of two parts 

**==> picture [172 x 31] intentionally omitted <==**

where K1 ∈ R[n][s][×][n][y] describes the changes in network activity si, and K2 ∈ R[n][Ω][×][n][y] corresponds to changes in the weights Ωi, in response to errors e. 

Updating the a posteriori state estimate gives 

**==> picture [183 x 48] intentionally omitted <==**

Updating the a posteriori covariance estimate gives 

**==> picture [233 x 112] intentionally omitted <==**

Specifically, measurement updates are given by 

**==> picture [167 x 72] intentionally omitted <==**

The covariance blocks are initialized as follows 

**==> picture [159 x 42] intentionally omitted <==**

where diagonal matrices are used for simplicity, and the initial state is assumed to be independent of the filter weights. The explicit Hilbert space functional Bayesian filter (expFBF) algorithm is summarized in Algorithm 1. Detailed derivation of the Jacobians F1(i) and F2(i) is presented in the Appendix. 

## B. Relationship to the Koopman Operator 

Koopman originally formulated the linear operator as a discrete-time mapping for Hamiltonian systems [14]. The Koopman operator can be generalized as follows: 

Definition 1 (Koopman Operator). For a continuous-time dynamical system 

**==> picture [148 x 22] intentionally omitted <==**

where x ∈X is the state on a smooth nx-dimensional manifold X . The Koopman operator K is an infinite-dimensional linear operator that acts on all observable functions g : X → C such that 

**==> picture [188 x 11] intentionally omitted <==**

By design, the Koopman operator is a linear, infinitedimensional operator that acts on the Hilbert space H of all scalar measurement functions g. Similarly, the weight Ω we learn in the RKHS acts on functions of the state space of the dynamical system, trading nonlinear finite-dimensional dynamics for linear infinite-dimensional dynamics. The two operators are theoretically equivalent. The Koopman perspective offers two compelling advantages: nonlinear problems can be addressed utilizing standard linear operator theory and spectral decomposition. In practice, the computation of the Koopman operator requires a finite-dimensional representation, by considering a sufficiently large yet finite sum of modes to approximate the Koopman spectra. Crucial to numerical implementation of this definition is understanding how to select a finite set of observables g(x), which remains an ongoing challenge. 

The ML kernel perspective offers two significant benefits: 

- 1) The Hilbert space can be constructed deterministically, agnostic to the nonlinear dynamics. The mappings induce a positive definite kernel function satisfying Mercer’s conditions under the closure properties (where, positive-definite kernels are closed under addition, multiplication, and scaling). The Gaussian kernel has universal approximation property: it approximates uniformly an arbitrary continuous target function over any compact domain. 

- 2) Bayesian filter can adaptively learn the Koopman operator that is minimum variance, allowing the system to continuously track the changes across an extended period of time, ideally suited for modern data-driven applications such as real-time ML using streaming data. 

8 

Algorithm 1 Explicit Hilbert Space Functional Bayesian Filter Initialization: 

nu: input dimension 

ny: output dimension 

ns: state dimension 

au: input kernel parameter 

a�s: state kernel parameter φ�(·) input feature map ψ(·) state feature map 

nΩ: feature-space dimension 

σs[2][:][state][variance] σ[2][output][variance] y[:] σΩ[2][:][weight][variance] P1(0) = σs[2][I][n] s P4(0) = σΩ[2][I][n] Ω P2(0) = 0 Randomly initialize state s0 Randomly initialize weights Ω: matrices A and B I = 0 Iny ∈ R[n][y][×][n][s] : measurement matrix � � 

for i = 1, · · · do Predict: 

Get current input ui and past state si−1 Map input ui to φ[�] (ui) Map state si to ψ[�] (si) Propagate a priori state estimate s[−] i[=][ A][i][ �][ψ][(][s][i][−][1][) +][ B][i][ �][φ][(][u][i][)] (33) Compute state transition dynamics: 

**==> picture [211 x 47] intentionally omitted <==**

**==> picture [162 x 10] intentionally omitted <==**

**==> picture [221 x 68] intentionally omitted <==**

**==> picture [236 x 187] intentionally omitted <==**

For practical applications, we can define a finite-dimensional FBF using polynomial approximation of the universal kernel. 

## IV. EXPERIMENTS AND RESULTS 

Here, we illustrate and evaluate the proposed explicit Hilbert space Functional Bayesian Filter using numerical examples. As a proof-of-concept, we consider the following tasks: chaotic time series estimation and modeling nonlinear PDE. 

## A. Cooperative Filtering for Signal Enhancement 

First, we consider the scenario of an unknown nonlinear dynamical system with only noisy observations available, and compare the denoising performances (signal enhancement) between the functional Bayesian filter [30], its finite-dimensional counterpart the expFBF, and the cubature Kalman filter (CKF) [37] on the Mackey-Glass (MG) chaotic time series yt [38], defined by the following delay differential equation 

**==> picture [100 x 27] intentionally omitted <==**

where β = 0.2, γ = 0.1, τ = 30, n = 10, discretized at a sampling period of 6 seconds using the fourth-order Runge-Kutta method, with initial condition y0 = 0.9. Chaotic dynamics are highly sensitive to initial conditions, where even a small change in the current state can lead to vastly different outcomes over time. This makes long-term prediction intractable and is commonly known as the butterfly effect [39]. 

Cooperative filtering seeks to build an empirical model by extracting (pseudo-) clean data from the noisy measurements. For unknown dynamics, the signal estimator is coupled with the weight parameter estimator. The cubature Kalman approach (specifically, the square-root version or SCKF) uses a recurrent neural network (RNN) to model the dynamics: the weights of the RNN are estimated from the latest signal estimate and vice versa. The SSM for the RNN architecture, trained using SCKF, is constructed as 

**==> picture [159 x 26] intentionally omitted <==**

where the input weight W[(i)] , the recurrent weight W[(r)] , and the output weight W[(o)] are matrices of appropriate dimensions (arranged into an orderly weight vector Wi). The process noise is zero-mean Gaussian with covariance Qi, i.e., qi ∼ N (0, Qi), and the measurement noise is ri ∼N (0, Ri). The input ui = [ui, ui−1, · · · , ui−(ℓ−1)] has embedding dimension ℓ = 7, and the self-recurrent hidden layer contains 5 neurons (xi ∈ R[5] ). The hidden layer activation uses the hyperbolic tangent function, while the single output neuron is linear (di ∈ R). The 7-5R-1 RNN consists of 71 weight parameters including bias terms. 

For the FBF and the expFBF, we construct linear models with the same state and input dimensions as the 7-5R-1 RNN, but with more parsimonious architectures. Fig. 3 compares the constructions for the three approaches. The kernel parameters for the state, input, state covariance P1, and weight covariance P4 are as = 0.6, au = 1.8, aP1 = 0.4, and aP4 = 0.2, respectively. The state covariance, output variance, and weight 

9 

**==> picture [155 x 267] intentionally omitted <==**

Fig. 3. Recurrent network trained using (a) Square-Root Cubature Kalman Filter and RNN (b) Functional Bayesian Filter using the tensor-product kernel (c) Explicit Hilbert space FBF using a sum kernel. 

covariance are initialized as σs[2][=][σ] y[2][=][0][.][09][,][σ] P[2] 4[=][10][,] respectively. There are no bias terms for our FBF and expFBF implementations. Using the small-step-size theory framework [40], which self-regularizes KAF, we scale the state Kalman gain K1 by a constant factor of 0.4, and the weight gain K2 by a constant factor of 0.1. Note, the FBF is an online kernel method with a dictionary constructed incrementally with each incoming sample (the initial point is randomly initialized), e.g., after 100 samples, the dictionary size becomes 101. The expFBF is of a fixed construction. We set the number of term for the Taylor series expansion to 4, resulting in n �ψ(s)[=] �5+44 � = 126, and nφ�(u) = �7+44 � = 330. 

A noisy (10 dB SNR) MG chaotic time sequence of 1000 samples is used for training. For each training run, ten batches were made. Each batch consists of 100 time-step updates, from a randomly selected starting point in the training sequence. The state of the RNN at time step i = 0 was assumed to be zero, i.e., x0 = 0. During the test phase, an independent sequence of 100 noisy samples is used with the network (SSM) weights fixed. 

SCKF has been successfully validated to significantly outperform other known nonlinear filters such as EKF and centraldifference Kalman filter (CDKF) and provides improved numerical stability over CKF [37]. It is important to reiterate that the two essential properties of error covariance matrix (symmetry and positive definiteness) are always preserved in FBF, since we are using positive definite kernel functions satisfying Mercer’s conditions, unlike input-space arithmetic operations such as CKF, where these two properties are often lost or destroyed and a square-root version is preferred. 

**==> picture [208 x 240] intentionally omitted <==**

Fig. 4. Ensemble-averaged Mean-Squared Error (MSE) over 50 runs vs. number of batch iterations (each training iteration consists of a 100-sample sequence with random starting point). 

Fig. 4 shows the ensemble-averaged mean square error (MSE) over 50 independent runs versus the number of batch iterations (error bars represent one standard deviation), where each training iteration consists of a 100-sample noisy sequence with random starting point in the 1000-sample training data. The “prior” label denotes the time update using the predictive density before receiving a new measurement; “posterior”, the measurement update from the posterior density. Clearly, the FBF significantly improves the quality of the signal as compared to the SCKF, and the expFBF approximates the performance of the FBF but with the added advantage of a finitedimension construction. The FBF memory and computational complexities for each recursive update are O(n) and O(n[2] ), respectively, where n is the length of the data sequence. This can be quite prohibitive for continuous tracking, and would need to be paired with an appropriate sparsification technique to limit the number of data points or size of the basis used. 

## B. Nonlinear Schr¨odinger Equation 

Next, we consider the expFBF and Koopman operator applied to a canonical second-order nonlinear PDE: the nonlinear Schr¨odinger (NLS) equation 

**==> picture [177 x 21] intentionally omitted <==**

where u(x, t) is a function of space and time, with many applications in theoretical physics, such as modeling the propagation of light in nonlinear optical fields or small-amplitude gravity waves on the surface of deep inviscid fluid. This study expands on the analysis in [41]. By discretizing the spatial variable x, we can Fourier transform the solution in space and employ a fourth-order Runge-Kutta method to step the solution forward in time. 

10 

We can compute the DMD by collecting snapshots of the dynamics over a given time window. Specifically, we consider simulations of the equation with initial data 

**==> picture [166 x 11] intentionally omitted <==**

over the time interval t ∈ [0, π]. The numerical simulation consists of 21 snapshots of the real-part of the dynamics, yielding the input-output snapshot matrices X = [x0, x1, · · · , xm−1] and X[′] = [x1, x2, · · · , xm], with m = 21. Spatially, 32 points are uniformly sampled from [−15, 15], i.e., xi ∈ R[32] . DMD is a batch method, while expFBF is a recursive estimator, iteratively predicates and updates the state and its uncertainty, one step at a time. 

Four different sets of features or observables are considered: 

- 1) The observables used in the DMD reduction are simply the original state variables x = u(x, t) at discrete space and time steps, i.e., gDMD(x) = x. 

- 2) Koopman theory allows a broader set of observables. Here we consider the following sets: 

**==> picture [205 x 25] intentionally omitted <==**

Both require different levels of knowledge or understanding of the underlying latent equations in the dynamical system: the first set of observables g1(x) uses the exact form of the nonlinearity in the NLS equation, which we denote by good embedding. The second, g2(x), is chosen be a more generic quadratic nonlinearity, but uses the absolute value, which is important for the NLS equation due to the nonlinearity in the phase evolution. For the NSL equation, the observables in g2(x) are considered inferior to either the DMD or the judiciously selected g1(x) for the Koopman reconstruction since its nonlinearity does not match that of the dynamics under consideration, which we will refer to as bad embedding [41]. Furthermore, we use a reduced-order linear model constructed by a rank-r truncation of the dominant eigenfunctions, with r = 10. 

- 3) The theory of RKHS enables universal kernel features. Here, we consider� the Gaussian quadrature features gGQ(x) = φ(x) or GQ embedding to approximate the Gaussian kernel (universal approximation property). These observables are agnostic to the state dynamics of the NLS and are instead associated with Mercer kernels. 

The reconstruction errors of the NLS dynamics are shown in Fig. 5. We can see that the choice of observables can significantly impact the performance of the Koopman approximation. Leveraging knowledge of the analytic solution, a judiciously selected observables can outperform generic observables and observables restricted to the original state variables. However, in practice, it is rarely the case that such linearizing transformations are known a priori, let alone knowing the exact equations of the dynamics, to take advantage of the Koopman theory. The GQ observables performed the worst, since it is constructed not for the NLS dynamics, but rather induces an RKHS that approximates uniformly an arbitrary function over any compact domain. Even in this simple example, we see that a model-based method in the RKHS, such as the expFBF, 

**==> picture [175 x 216] intentionally omitted <==**

Fig. 5. Short-term future state reconstruction errors of the NLS dynamics using a standard DMD approximation gDMD(x), the NLS motivated observables g1(x), the generic quadratic observables g2(x), the Gaussian quadrature observable, and the explicit Hilbert space FBF using GQ observable: (a) the NLS reconstruction errors for DMD and expFBF, (b) the MSE summed across space for the four reconstructions. 

**==> picture [175 x 216] intentionally omitted <==**

Fig. 6. Long-term future state reconstruction errors of the NLS dynamics using a standard DMD approximation gDMD(x), the NLS motivated observables g1(x), the generic quadratic observables g2(x), the Gaussian quadrature observable, and the explicit Hilbert space FBF using GQ observable: (a) the NLS reconstruction errors for DMD and expFBF, (b) the MSE summed across space for the four reconstructions. 

can outperform the Koopman theoretic approximation using the same GQ observables. 

The expFBF is a learning algorithm that recursively updates the model parameters and the corresponding state estimations. To highlight this, we expand the number of snapshots in the NLS numerical simulation above from 21 to 101. The longterm prediction reconstruction errors of the NLS dynamics are shown in Fig. 6. We see that given a longer period of 

11 

**==> picture [191 x 235] intentionally omitted <==**

Fig. 7. Long-term future state reconstructions of second-order nonlienar PDE using initial condition u(x, 0) = 2sech(x): (a) NLS measurements, (b) standard DMD approximation gDMD(x), (c) expFBF, (d) the NLS motivated observables g1(x), (e) the generic quadratic observables g2(x), and (f) the Gaussian quadrature observable. 

**==> picture [273 x 169] intentionally omitted <==**

Fig. 9. Reconstruction of the NLS dynamics using (a) a standard DMD approximation gDMD(x), (b) the NLS motivated g1(x), (c) a quadratic observable g2(x) and (d) the GQ observables. The Koopman spectra for each observable is show in the second row. Note that the observable g1(x) produces a spectra which is approximately purely imaginary which is expected of the 2-soliton evolution. But here, we modified the initial condition by changing the scaling from 2 to 3.1. The NLS reconstruction MSE summed across space and plotted against time is shown in (e). 

**==> picture [171 x 11] intentionally omitted <==**

**==> picture [191 x 235] intentionally omitted <==**

Fig. 8. Long-term future state reconstructions of second-order nonlienar PDE using initial condition u(x, 0) = 3.1sech(x): (a) NLS measurements, (b) standard DMD approximation gDMD(x), (c) expFBF, (d) the NLS motivated observables g1(x), (e) the generic quadratic observables g2(x), and (f) the Gaussian quadrature observable. 

adaptation, the expFBF outperforms the Koopman methods, even though the GQ observables are still the worst performing using the Koopman decomposition. The corresponding reconstructions are shown in Fig. 7. 

Next, we investigate the performances’ sensitivity to the initial condition. We modify the coefficient in (69) to 

The reconstructions of the NLS dynamics for 101 time steps using the new initial condition is shown in Fig. 8. We see that the dynamical structures are much more complex and nuanced here than before, and the low-rank DMD and Koopman reconstructions are not able to capture these spatial-temporal structures. Again, the Koopman reconstruction of the GQ embedding performed the worst, but by constructing a statespace model in the RKHS induced by the GQ observables, and using Bayesian updates, we are able to capture the spatiotemporal dynamics with high fidelity. 

Fig. 9 shows the performance when we increase the rank r from 10 to 30. We see that the Koopman methods become unstable by considering more eigenfunctions, and the errors explode in time. The good embedding becomes worse than the bad embedding, since gk1(x) contains a cubic form vs. the quadratic nonlinearity in gk2(x). The Koopman reconstruction using GQ observables now has the best performance among the Koopman methods. This highlights the critical challenge in Koopman theory, selecting meaningful and robust observables. The extended DMD and kernel DMD method were also shown to be highly sensitive to observable selection in [41]. 

Unlike the Koopman decomposition, whose effectiveness hinges almost exclusively on the selection of observables, the KAF operator-theoretic approach we propose here is robust and the feature space deterministically constructed, agnostic to the input dynamics. The Koopman eigenfunctions and eigenvalues capture the evolution of the linearized dynamics on a well-selected observable space while the GQ transformed states induces an RKHS that approximates the universal kernel. Observable selection for the NLS problem was facilitated by precise knowledge of the governing equation. However, in many real-world applications, such expert knowledge is 

12 

absent, and we must rely solely on data. This is precisely the appeal of the methodology we introduced here. 

## V. CONCLUSION 

The theory of RKHS is a powerful, versatile, and theoretically-grounded unifying framework to solve nonlinear problems in data-driven analysis such as signal processing and machine learning. The standard approach relies on the kernel trick to perform pairwise evaluations of a kernel function, which bypasses the explicit feature map (potentially infinitedimensional) but leads to scalability issues for large datasets due to its linear and superlinear growth with respect to the size of the training data. In this paper, we proposed an explicitspace functional Bayesian filter to perform recursive state estimation using linear operators in a finite-dimensional RKHS that approximate the performance of a universal kernel for nonlinear dynamical systems, defined by polynomials such as the Gaussian quadrature and Taylor series features. Compared to the popular Koopman theory and decomposition, which relies heavily on handcrafting a proper set of observables that linearize a nonlinear dynamics, our kernel operator-theoretic approach shifts the focus from feature engineering to adaptive filtering in a predefined RKHS. Simulation results show that this framework is robust and can outperform Koopman decomposition, ideally suited for applications where expert knowledge is absent and we must rely solely on the data. 

In the future we will further reduce the computational complexity of the finite-dimensional explicit space FBF using dimensionality-reduction techniques and manifold learning. We will also apply this framework to model biological systems and signals, such as those observed in neuronal recordings in the brain, which are well-suited for data-driven model discovery techniques, and bio-inspired neuromorphic systems. These are ideally suited for leveraging modern data-driven modeling tools of machine learning to develop dynamical models characterizing the observed data. 

## REFERENCES 

- [1] G. H. Yann LeCun, Yoshua Bengio, “Deep learning,” Nature, vol. 521, pp. 436–444, 2015. 

- [2] G. Hinton, L. Deng, D. Yu, G. E. Dahl, A.-r. Mohamed, N. Jaitly, A. Senior, V. Vanhoucke, P. Nguyen, T. N. Sainath, and B. Kingsbury, “Deep neural networks for acoustic modeling in speech recognition: The shared views of four research groups,” IEEE Signal Processing Magazine, vol. 29, no. 6, pp. 82–97, 2012. 

- [3] A. Krizhevsky, I. Sutskever, and G. E. Hinton, “Imagenet classification with deep convolutional neural networks,” in Advances in Neural Information Processing Systems, F. Pereira, C. Burges, L. Bottou, and K. Weinberger, Eds., vol. 25. Curran Associates, Inc., 2012. 

- [4] I. Goodfellow, J. Pouget-Abadie, M. Mirza, B. Xu, D. Warde-Farley, S. Ozair, A. Courville, and Y. Bengio, “Generative adversarial nets,” in Advances in Neural Information Processing Systems, Z. Ghahramani, M. Welling, C. Cortes, N. Lawrence, and K. Weinberger, Eds., vol. 27. Curran Associates, Inc., 2014. 

- [5] D. W. Otter, J. R. Medina, and J. K. Kalita, “A survey of the usages of deep learning for natural language processing,” IEEE Transactions on Neural Networks and Learning Systems, vol. 32, no. 2, pp. 604–624, 2021. 

- [6] S. Chakraborty, R. Tomsett, R. Raghavendra, D. Harborne, M. Alzantot, F. Cerutti, M. Srivastava, A. Preece, S. Julier, R. M. Rao, T. D. Kelley, D. Braines, M. Sensoy, C. J. Willis, and P. Gurram, “Interpretability of deep learning models: A survey of results,” in 2017 IEEE SmartWorld/SCALCOM/UIC/ATC/CBDCom/IOP/SCI), 2017, pp. 1–6. 

- [7] D. Heaven, “Why deep-learning ais are so easy to fool,” Nature, vol. 574, no. 7777, pp. 163–166, 2019. 

- [8] A. Iyer, K. Grewal, A. Velu, L. O. Souza, J. Forest, and S. Ahmad, “Avoiding catastrophe: Active dendrites enable multi-task learning in dynamic environments,” Frontiers in Neurorobotics, vol. 16, 2022. 

- [9] R. E. Kalman, “A new approach to linear filtering and prediction problems,” Trans. ASME, Series D., Journal of Basic Eng., vol. 82, pp. 35–45, 1960. 

- [10] M. Schmidt and H. Lipson, “Distilling free-form natural laws from experimental data,” Science, vol. 324, no. 5923, pp. 81–85, 2009. 

- [11] M. Raissi, P. Perdikaris, and G. Karniadakis, “Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations,” Journal of Computational Physics, vol. 378, pp. 686–707, 2019. 

- [12] K. Lee and K. T. Carlberg, “Model reduction of dynamical systems on nonlinear manifolds using deep convolutional autoencoders,” Journal of Computational Physics, vol. 404, p. 108973, 2020. 

- [13] S. L. Brunton, M. Budiˇsi´c, E. Kaiser, and J. N. Kutz, “Modern koopman theory for dynamical systems,” SIAM Review, vol. 64, no. 2, pp. 229– 340, 2022. 

- [14] B. O. Koopman, “Hamiltonian systems and transformations in hilbert space,” Proceedings of the National Academy of Sciences of the United States of America, vol. 17, no. 5, pp. 315–318, 1931. 

- [15] B. O. Koopman and J. V. Neumann, “Dynamical systems of continuous spectra,” Proceedings of the National Academy of Sciences of the United States of America, vol. 18, no. 3, pp. 255–263, 1932. 

- [16] J. v. Neumann, “Proof of the quasi-ergodic hypothesis,” Proceedings of the National Academy of Sciences, vol. 18, no. 1, pp. 70–82, 1932. 

- [17] G. D. Birkhoff, “Proof of the ergodic theorem,” Proceedings of the National Academy of Sciences, vol. 17, no. 12, pp. 656–660, 1931. 

- [18] C. W. Rowley, I. Mezi´c, S. Bagheri, P. Schlatter, and D. Henningson, “Spectral analysis of nonlinear flows,” Journal of Fluid Mechanics, vol. 641, p. 115–127, 2009. 

- [19] I. Mezi´c, “Spectral Properties of Dynamical Systems, Model Reduction and Decompositions,” Nonlinear Dynamics, vol. 41, no. 1, pp. 309–325, Aug. 2005. 

- [20] P. J. Schmid, “Application of the dynamic mode decomposition to experimental data,” Experiments in Fluids, vol. 50, no. 4, pp. 1123– 1130, Apr. 2011. 

- [21] S. L. Brunton and J. N. Kutz, Data-driven science and engineering: Machine learning, dynamical systems, and control. Cambridge University Press. 

- [22] M. Lo`eve, Probability Theory, ser. University series in higher mathematics. Van Nostrand, 1960. 

- [23] K. P. F.R.S., “Liii. on lines and planes of closest fit to systems of points in space,” Philosophical Magazine Series 1, vol. 2, pp. 559–572, 1901. 

- [24] D. A. Bistrian and I. M. Navon, “An improved algorithm for the shallow water equations model reduction: Dynamic mode decomposition vs pod,” International Journal for Numerical Methods in Fluids, vol. 78, no. 9, pp. 552–580, 2015. 

- [25] N. Aronszajn, “Theory of reproducing kernels,” Transactions of the American Mathematical Society, vol. 68, no. 3, pp. 337–404, 1950. 

- [26] T. Hofmann, B. Sch¨olkopf, and A. J. Smola, “Kernel methods in machine learning,” The Annals of Statistics, vol. 36, no. 3, pp. 1171 – 1220, 2008. 

- [27] “A kernel-based method for data-driven koopman spectral analysis,” pp. 247–265. 

- [28] K. Fujii and Y. Kawahara, “Dynamic mode decomposition in vectorvalued reproducing kernel hilbert spaces for extracting dynamical structure among observables,” Neural Networks, vol. 117, pp. 94–103, 2019. 

- [29] K. Li and J. C. Pr´ıncipe, “The kernel adaptive autoregressive-movingaverage algorithm,” IEEE Trans. Neural Netw. Learn. Syst., vol. 27, no. 2, pp. 334–346, Feb. 2016. 

- [30] K. Li and J. C. Pr´ıncipe, “Functional bayesian filter,” IEEE Transactions on Signal Processing, vol. 70, pp. 57–71, 2022. 

- [31] K. Li and J. C. Pr´ıncipe, “No-trick (treat) kernel adaptive filtering using deterministic features,” CoRR, vol. abs/1912.04530, 2019. 

- [32] S. Bochner, M. Functions, S. Integrals, H. Analysis, M. Tenenbaum, and H. Pollard, Lectures on Fourier Integrals. (AM-42). Princeton University Press, 1959. 

- [33] T. Dao, C. D. Sa, and C. R´e, “Gaussian quadrature for kernel features,” in Proceedings of the 31st International Conference on Neural Information Processing Systems, ser. NIPS’17. USA: Curran Associates Inc., 2017, pp. 6109–6119. 

- [34] C. A. Micchelli, Y. Xu, and H. Zhang, “Universal kernels,” Journal of Machine Learning Research, vol. 7, no. 95, pp. 2651–2667, 2006. 

- [35] A. Cotter, J. Keshet, and N. Srebro, “Explicit approximations of the gaussian kernel,” CoRR, vol. abs/1109.4603, 2011. 

13 

- [36] B. Zwicknagl, “Power series kernels,” Constructive Approximation, vol. 29, pp. 61–84, 2009. 

- [37] I. Arasaratnam, “Cubature Kalman filtering: Theory & applications,” Ph.D. dissertation, McMaster University, 2009. 

- [38] M. C. Mackey and L. Glass, “Oscillation and chaos in physiological control systems,” Science, vol. 197, no. 4300, pp. 287–289, Jul. 1977. 

- [39] E. Ott, Chaos in dynamical systems, 2nd ed. Cambridge, UK: Cambridge University Press, 2002. 

- [40] S. Haykin, Adaptive Filter Theory, 4th ed. Prentice Hall, 2002. 

- [41] J. N. Kutz, J. L. Proctor, and S. L. Brunton, “Applied koopman theory for partial differential equations and data-driven modeling of spatiotemporal systems,” Complexity, vol. 2018, pp. 1–16, 2018. 

## APPENDIX 

Here, we show how to compute each of the submatrices in (31). Using the state transition (33) and the Taylor series features (20), the state-transition Jacobian in (37) becomes 

**==> picture [192 x 55] intentionally omitted <==**

where the (l, m) element of F1(i) is 

**==> picture [207 x 69] intentionally omitted <==**

where α[(][l][)] = �α[(] 1[l][)][, α] 2[(][l][)][, . . . , α] n[(][l] s[)] � is the multi-indices notation for the multinomial expansion, n = |α[(][l][)] |, and s[α][(][l][)] = α[(] 1[l][)] α[(] 2[l][)] α[(] ns[l][)] s1 s2 · · · sns[,][with][m][=][1][,][ · · ·][, n] s[and][l][=][1][,][ · · ·][, D][de-] noting the l[th] feature or unique monomial of the D-dimensional TS approximation of the Gaussian kernel. We further expand (74) using the product rule: 

**==> picture [242 x 257] intentionally omitted <==**

We can compute (39) and (40) directly as 

**==> picture [209 x 55] intentionally omitted <==**

**==> picture [209 x 55] intentionally omitted <==**

and 

However, a more efficient organization is to break the weight matrix vector Ωi in (29) into individual state dimension components and rewrite (31) as 

**==> picture [211 x 32] intentionally omitted <==**

where Ω[(] i[k][)] are all the weights connected to the k-th output state node (1 ≤ k ≤ ns) and 

**==> picture [207 x 27] intentionally omitted <==**

At each time step i, this process is repeated for each of the ns state components. 

For the case when s is observable (e.g., known nonlinear dynamics) as shown in (34), we can define the state transitions directly in the RKHS, i.e., 

**==> picture [228 x 93] intentionally omitted <==**

where corresponding state-transition matrix simplify to 

Kan Li (S’08) received the B.A.Sc. degree in electrical engineering from the University of Toronto in 2007, the M.S. degree in electrical engineering from the University of Hawaii in 2010, and the Ph.D. degree in electrical engineering from the University of Florida in 2015. He is currently a research scientist at the University of Florida. His research interests include machine learning and signal processing. 

**==> picture [72 x 91] intentionally omitted <==**

Jos´e C. Pr´ıncipe (M’83-SM’90-F’00) is the BellSouth and Distinguished Professor of Electrical and Biomedical Engineering at the University of Florida, and the Founding Director of the Computational NeuroEngineering Laboratory (CNEL). His primary research interests are in advanced signal processing with information theoretic criteria and adaptive models in reproducing kernel Hilbert spaces (RKHS), with application to brain-machine interfaces (BMIs). Dr. Pr´ıncipe is a Fellow of the IEEE, ABME, and AIBME. He is the former Editor in Chief of the IEEE Transactions on Biomedical Engineering, past Chair of the Technical Committee on Neural Networks of the IEEE Signal Processing Society, PastPresident of the International Neural Network Society, and a recipient of the IEEE EMBS Career Award, the IEEE Neural Network Pioneer Award, and the IEEE SPS Claude Shannon-Harry Nyquist Technical Achievement Award. 

