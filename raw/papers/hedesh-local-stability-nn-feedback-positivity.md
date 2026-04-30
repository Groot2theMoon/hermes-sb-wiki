---
title: "Local Stability and Region of Attraction Analysis for Neural Network Feedback Systems under Positivity Constraints"
arxiv: "2505.22889"
authors: ["Hamidreza Montazeri Hedesh", "Moh Kamalul Wafi", "Milad Siami"]
year: 2025
source: paper
ingested: 2026-05-01
sha256: 1213beb037b733728f00a1a41e3a6f93877b9239ae9f5b4083fbf5ba5cb5d07e
conversion: pymupdf4llm
---

# Local Stability and Region of Attraction Analysis for Neural Network Feedback Systems under Positivity Constraints 

Hamidreza Montazeri Hedesh[1] , Moh Kamalul Wafi[1] , and Milad Siami[1] 

Abstract— We study the local stability of nonlinear systems in the Lur’e form with static nonlinear feedback realized by feedforward neural networks (FFNNs). By leveraging positivity system constraints, we employ a localized variant of the Aizerman conjecture, which provides sufficient conditions for exponential stability of trajectories confined to a compact set. Using this foundation, we develop two distinct methods for estimating the Region of Attraction (ROA): (i) a less conservative Lyapunov-based approach that constructs invariant sublevel sets of a quadratic function satisfying a linear matrix inequality (LMI), and (ii) a novel technique for computing tight local sector bounds for FFNNs via layer-wise propagation of linear relaxations. These bounds are integrated into the localized Aizerman framework to certify local exponential stability. Numerical results demonstrate substantial improvements over existing integral quadratic constraint-based approaches in both ROA size and scalability. 

## I. INTRODUCTION 

Neural networks (NNs) are increasingly being used in control systems due to their expressive power and ability to learn complex nonlinear mappings [1]. There are recent interesting usage of NN structures in Control [2], [3]. However, certifying the stability of NN-in-the-loop systems remains a major challenge, particularly when such systems are deployed in safety-critical applications. Traditional Lyapunov-based analysis is often infeasible for high-dimensional or opaque NN controllers, motivating the need for scalable, structureexploiting methods for stability verification. 

Existing techniques that attempt to verify stability for NN feedback—such as those using integral quadratic constraints (IQCs) [4]–[7], sum-of-squares optimization [8], passivitybased approaches [9], circle criterion [10] or global Lipschitz bounds [11]—either scale poorly with system size or result in overly conservative guarantees. Recent advances such as RecurJac [12], CROWN [13], and IBP [14] provide tools for bounding NN outputs, but these have not been explicitly integrated into closed loop system frameworks. There are other useful control methods such as density functions [15] 

> 1H. Montazeri Hedesh, M. K. Wafi, M. Siami are with the Department of Electrical & Computer Engineering, Northeastern University, Boston, MA 02115, USA. (e-mails: {montazerihedesh.h, wafi.m, m.siami}@northeastern.edu). 

This material is based upon work supported in part by the U.S. Office of Naval Research under Grant Award N00014-21-1-2431, in part by the U.S. National Science Foundation under Grant Award 2121121 and Grant Award 2208182, and in part by the DEVCOM Analysis Center and was accomplished under Contract Number W911QX-23-D0002. The views and conclusions contained in this document are those of the authors and should not be interpreted as representing the official policies, either expressed or implied, of the DEVCOM Analysis Center or the U.S. Government. The U.S. Government is authorized to reproduce and distribute reprints for Government purposes notwithstanding any copyright notation herein. 

or positive system methods [16] that has not yet extended into verification of NN in the loop. 

Positive systems offer a favorable structure for a streamlined and scalable stability analysis. These systems have been widely explored in the literature of linear systems [17], [18]. However, their benefits in nonlinear systems have not been extensively studied. The positive Lur’e framework provides a well-established setting for studying absolute stability of complex nonlinear systems. For example, the positive Aizerman conjecture gives sufficient conditions for global exponential stability in this context when the feedback nonlinearity lies within a sector [19]. However, there is currently a lack of techniques that can leverage the structural properties of positive systems to enable scalable and less conservative verification of NN feedback stability. 

This paper addresses this gap by proposing two tractable and scalable methods for local stability analysis and estimating the ROA of positive Lur’e systems with NN feedback, both grounded in a localized version of the positive Aizerman conjecture. The first method uses a Lyapunov-based approach with linear matrix inequalities (LMIs), applicable to general sector-bounded nonlinearities. The second introduces a novel, tight local sector bound for FFNNs, which to the best of our knowledge, is the first such formulation in the literature. This bound is propagated layer by layer through the network and naturally fits within the Aizerman framework, enabling a scalable and certifiable ROA analysis for NN feedback systems. Compared to existing bounds such as RecurJac, CROWN, and IBP, this novel local sector bound—built upon our previously proposed global sector bound [20] and its application in robust stability of NN feedback loops [21]—features a nonaffine linear shape, and is specifically developed for scalable local stability analysis of NN feedback loops. The key contributions of this paper are: (i) A localized variant of the Positive Aizerman Conjecture tailored for local stability analysis and further calculating the corresponding ROA; (ii) A Lyapunov-based method for local stability analysis and ROA estimation in positive Lur’e systems with general sector-bounded feedback; (iii) A novel local sector bound formulation for FFNNs, and further integration of it in a local stability analysis framework for NN feedback loops. 

These contributions are significant since they provide a formal guarantee that despite the nonlinear nature of the NN, there is a specific area in the state space where the system is stabilizable. This result highlights the practical utility of NN controllers in real-world applications, where local stability is often sufficient. Through rigorous analysis 

and simulation, this paper provides both theoretical insights and practical guidelines for implementing NN controllers in feedback systems. This opens up new possibilities for using machine learning techniques in classical control theory, where traditional linear control methods fall short [22], [23]. Finally, numerical results demonstrate that our methods outperform existing IQC-based approaches [4] in ROA size and computational efficiency, making them suitable for larger systems where existing verification methods are impractical. 

## A. Notations 

We denote the set of real numbers, real vectors of dimension n, and real matrices of dimension n × m by R, R[n] , and R[n][×][m] . The orders >, <, ≥, and ≤ are interpreted elementwise when applied to vectors and matrices. In addition, the operators ≻ and ≺ denote positive and negative definite matrices. Subsequently, a doubly positive matrix A is both A ≻ 0 and A > 0. The symbol 0 denotes a zero vector of appropriate dimension. We also define R+[n][×][m] := {A ∈ R[n][×][m] | A ≥ 0}. The sets R[n] +[and][R][+][are][defined][similarly.] A Metzler matrix is characterized by having nonnegative offdiagonal elements. 

## II. PROPOSED THEORETICAL FRAMEWORK 

First, we lay the theoretical foundations for presenting our results, encompassing positive Lur’e systems and the positive Aizerman conjecture. throughout the paper, we briefly use positivity for internal positivity. The following definition and lemmas along with their proof can be found in [24]. 

## A. Positive Lur’e Systems 

Consider a linear time invariant (LTI) system of the form: 

**==> picture [205 x 11] intentionally omitted <==**

where A ∈ R[n][×][n] , B ∈ R[n][×][m] , and C ∈ R[p][×][n] are constant matrices. The vectors x(t) ∈ R[n] , u(t) ∈ R[m] , and y(t) ∈ R[p] denote the state, input, and output variables, respectively, with initial condition x(0). 

Definition 1. The system in (1), is called “positive” if, ∀t > 0, we have x(t) ≥ 0, given x(0) := x0 ≥ 0 and u(t) ≥ 0. 

Lemma 1. The system in (1) is positive if and only if A is a Metzler matrix, B ∈ R+[n][×][m] , and C ∈ R[p] +[×][n] . 

Lemma 2. If a positive system in (1) is also asymptotically stable, then there exists a vector v ∈ R[n] +[,][with][v][>][0][,][such] that v[⊤] A < 0. 

We refer the reader to [19] and the references therein for the proof of Lemma 2. For notational simplicity, we omit the explicit time dependence and write x, y and u in place of x(t), y(t), and u(t) whenever the meaning is clear from context. 

To define a positive Lur’e system, we consider the system in (1) under a static nonlinear feedback represented as u = Φ(Cx, .), as illustrated in Fig. 1. The resulting closed-loop dynamics can be written as: 

**==> picture [169 x 11] intentionally omitted <==**

**==> picture [169 x 25] intentionally omitted <==**

**----- Start of picture text -----**<br>
u y = Cx<br>Φ(y) G<br>**----- End of picture text -----**<br>


Fig. 1: Lur’e system with plant G and nonlinear controller Φ. 

where Φ : R[p] × R → R[m] is a multivariate function that satisfies the following assumption. The assumption ensures the existence and uniqueness of solutions. 

Assumption 1. There exists a unique, locally absolutely continuous function χ : R+ → R[n] that satisfies (2) almost everywhere for any x0 ∈ R[n] . Moreover, Φ(0, t) = 0, ∀t ≥ 0, ensuring that x∗ = 0 is an equilibrium point of (2). The function Φ(z, t) is locally Lipschitz in z and measurable in t, with certain mild boundedness assumptions [25, Thm. 54, Prop. C.3.8]. 

Furthermore, to enable stability analysis, it is necessary to characterize the sector bounds of the nonlinear component. For a multi-input multi-output (MIMO) positive system, these bounds are best described using component-wise inequalities. The function Φ is said to be sector bounded in [Σ1, Σ2] if: 

**==> picture [211 x 12] intentionally omitted <==**

where Σ1, Σ2 ∈ R[m][×][p] , and Σ1 ≤ Σ2. 

A positive Lur’e system is defined as a system of the form · (2), where the nonlinearity Φ( ) satisfies the sector condition (3), and the overall system meets the criteria of Definition 1. With this foundation, we are now ready to introduce the positive Aizerman conjecture. 

## B. Positive Aizerman Conjecture 

The Aizerman conjecture is a classical tool for absolute stability analysis in Lur’e systems. Although counterexamples exist for the general case, it holds under more stringent conditions—particularly positive systems [16]. 

The following theorem, originally presented and proved in [19], formalizes the validity of Aizerman’s conjecture for MIMO positive systems. 

Theorem 1. Consider a Lur’e system in (2), where B, C ≥ 0, and Φ is sector bounded in the interval [Σ1, Σ2] in the sense of (3). The system is globally exponentially stable if A + BΣ1C is Metzler and A + BΣ2C is Hurwitz. 

With the preliminaries in place, we now proceed to formally define the problem and outline our approach for analyzing the local stability and ROA of nonlinear Lur’e systems. 

## C. Problem Formulation 

Consider the Lur’e system as defined in (2), with B, C ≥ 0, and the equilibrium point x∗ satisfying 0 = Ax∗ + Bu∗, y∗ = Cx∗, u∗ = Φ(y∗). Let χ(t; x0) denote the solution to the closed-loop system at time t, initialized at x0. Our goal is to analyze the stability of the equilibrium point x∗, and to identify a maximal underapproximation of the set of initial conditions from which the system trajectories converge to this point. This set is commonly referred to as the ROA in 

nonlinear systems literature and is defined as: R := {x0 ∈ R[n] : limt→∞ χ(t; x0) = x∗}. 

In the following sections, we first formulate the localized positive Aizerman conjecture and derive an associated inner approximation of the ROA. Building on this foundation, we then propose two complementary methods to compute inner approximations of ROA for positive Lur’e systems with FFNNs in the feedback loop: (i) a Lyapunov-based approach leveraging locally sector bounded nonlinearity assumptions and LMI optimization, and (ii) a novel NN sector bound, integrated into the framework of the local positive Aizerman conjecture to ensure local stability and estimate the ROA. 

## III. LOCAL STABILITY VIA POSITIVE AIZERMAN CONJECTURE 

We begin by introducing a localized sector condition for nonlinearities, which plays a central role in our analysis. 

Definition 2 (Γ−Sector Bounded Function). Given an interval [Σ1, Σ2] with Σ1, Σ2 ∈ R[m][×][p] and Σ1 ≤ Σ2, a multivariate nonlinear function Φ(y, ·) : R[p] × R → R[m] is said to be Γ−sector bounded within that interval if, for a compact and connected set Γ ⊆ R[p] , the following condition holds: 

**==> picture [190 x 10] intentionally omitted <==**

Using this definition, the following theorem establishes exponential stability of output trajectories that remain inside the Γ set. 

Theorem 2. Consider the Lur’e system given in (2), where B, C ≥ 0 and the nonlinearity Φ is Γ−sector bounded within the interval [Σ1, Σ2] with y∗ ∈ Γ. Suppose that A + BΣ1C is Metzler and A + BΣ2C is Hurwitz; then all the output trajectories that remain within the set Γ are exponentially stable. 

For the sake of brevity, we omit the full proof here; it follows a similar reasoning to the global positive Aizerman conjecture as presented in [19], with the additional assumption that the system trajectory remains confined within the sector bounded region Γ. Following Theorem 2, Lemma 3 provides a sufficient condition for identifying a subset of initial states that guarantees the output trajectory remains within Γ set. 

Lemma 3. Consider a multi-input single-output (MISO) Lur’e system satisfying theorem 2. Let y denote the upper bound of the set Γ in which the nonlinearity is sector bounded. Then, an underapproximation of the ROA is given by the set of initial conditions x0 satisfying: 

**==> picture [152 x 20] intentionally omitted <==**

where v > 0 satisfies v[⊤] (A + BΣ2C) < 0, and vm and vM are the smallest and largest element of v, in turn. 

Proof. We can upper bound the system dynamics in (2) as: 

**==> picture [236 x 11] intentionally omitted <==**

where M := A+ BΣ2C is Metzler and Hurwitz. By Lemma 2, ∃v > 0 such that v[⊤] M < 0 and considering the Lyapunov 

candidate V (x) = v[⊤] x, then its time derivative along system trajectories is: 

**==> picture [172 x 12] intentionally omitted <==**

Since v[⊤] M < 0 and x ≥ 0, we conclude that V[˙] (x) ≤ 0, implying v[⊤] x is non-increasing over time. This gives: 

**==> picture [186 x 12] intentionally omitted <==**

Multiplying both sides of vmx ≤ vM x0 by C yields vmy ≤ vM y0. Now, if vM y0 ≤ vmy, then vmy ≤ vmy, implying y ≤ y. Therefore, all output trajectories starting from 

**==> picture [147 x 20] intentionally omitted <==**

will remain below the threshold y and remain inside Γ, thus ensuring asymptotic stability. 

Remark 1. The Lyapunov function presented in the proof of Lemma 3 with equations (6) and (7), alongside the result of [19, Lem. 2], provides a proof for our Theorem 2. 

## IV. LYAPUNOV BASED METHOD 

An alternative approach to Lemma 3 involves the construction of Lyapunov functions benefitting from sector bounded nonlinearity constraints. The following result establishes a verified quadratic Lyapunov function for general sector bounded systems. 

Theorem 3 (Quadratic certificate). For the Lur’e system (2) with B, C ≥ 0 and a nonlinearity Φ that is Γ-sector bounded on [Σ1, Σ2], if A + BΣ1C is Metzler and A + BΣ2C is Hurwitz, then there exists a doubly positive P ∈ R[n][×][n] such that 

**==> picture [207 x 12] intentionally omitted <==**

Consequently, V (x) = x[⊤] Px is a Lyapunov function certifying local stability; moreover, for some α > 0, the sublevel set Vα = {x : V (x) ≤ α} is compact, positively invariant, and forms an inner approximation of the ROA. 

Moreover, the sublevel sets of V define compact, positively invariant regions around the origin that constitute an inner approximation of the ROA for the nonlinear system. That is, there exists α > 0 such that the set Vα := {x ∈ R[n] | V (x) ≤ α} is entirely contained within the ROA. 

Proof. Consider the quadratic Lyapunov candidate V (x) = x[⊤] Px, where P is a doubly positive matrix satisfying the LMI in (10). Define the time derivative of V along system trajectories: 

**==> picture [229 x 13] intentionally omitted <==**

By the assumption that the nonlinearity Φ is Γ−sector bounded in the interval [Σ1, Σ2], we obtain the inequality: 

**==> picture [185 x 11] intentionally omitted <==**

for some neighborhood D of the origin. Noting that B, P , and x are all nonnegative element-wise and using the 

monotonicity of scalar multiplication under the element-wise inequality (12), we deduce: 

**==> picture [189 x 12] intentionally omitted <==**

Substituting this into the expression for V[˙] (x), we obtain: 

**==> picture [237 x 29] intentionally omitted <==**

By construction of P , the matrix inequality (10) implies that the right-hand side is strictly negative. Hence, V[˙] (x) < 0 for all x = 0 in some neighborhood of the origin, completing the proof of local asymptotic stability. 

Algorithm 1 ROA Estimation via Lyapunov Sublevel Sets for Lur’e Systems 

Require: Lur’e system matrices A, B > 0, C > 0, nonlinearity Φ(y, .) Γ-sector bounded in [Σ1, Σ2] Ensure: Estimate of ROA 

- 1: Check Sector Conditions: 

- 2: if A + BΣ1C is Metzler and A + BΣ2C is Hurwitz then 3: Proceed to Lyapunov analysis 

- 4: else 

5: Exit: Sector conditions not 

- 6: end if 

- 7: Solve LMI: Find P ≻ 0, P > 0 satisfying 

(A + BΣ2C)[⊤] P + P (A + BΣ2C) ≺ 0 

- 8: if no such P exists then 

Building upon the stability guarantee provided in Theorem 3, we now proceed to define an inner approximation of the ROA for the nonlinear system. It is important to note that, in general, one cannot assert that the entire sector bounded domain Γ corresponds to the ROA. This is due to the possibility that certain trajectories originating within Γ may exit the sector before asymptotically approaching the equilibrium point, thereby violating the required sector condition Σ1y ≤ Φ(y, .) ≤ Σ2y for all t ≥ 0. 

The identification of a subset of Γ that remains forwardinvariant under the flow and for which the sector condition is preserved globally in time is, in general, a nontrivial task, as it necessitates precise characterization of invariant sets embedded within Γ. To circumvent this difficulty, we leverage the candidate Lyapunov function proposed in Theorem 3, and construct a Lyapunov-based estimate of the ROA via its sublevel sets. 

Specifically, we define quadratic sublevel sets of the form Lρ := �x ∈ R[n][ ��] x[⊤] Px ≤ ρ� , where P is a doubly positive matrix satisfying the LMI condition in (10). Instead of exhaustively verifying the sector condition for all trajectories in Γ, we restrict our attention to determining whether the Lyapunov function decreases along system trajectories within a candidate sublevel set. In particular, we evaluate the condition 

**==> picture [229 x 11] intentionally omitted <==**

on the boundary of Lρ, i.e., for all x ∈ ∂Lρ. If (15) holds uniformly on the boundary, then the sublevel set Lρ is forwardinvariant and contained within the ROA. Consequently, the largest value of ρ for which this condition is satisfied defines the maximal certified invariant level set, which we take as an estimate of the ROA. This procedure is formalized in Algorithm 1. 

Remark 2. While this work primarily utilizes a quadratic Lyapunov function of the form V (x) = x[⊤] Px to certify local stability and construct ROA estimates, the proposed methodology can also be applied using a linear copositive Lyapunov function V (x) = v[⊤] x, where v > 0. In particular, under the same sector bounded conditions, if A + BΣ1C is Metzler and A+BΣ2C is Hurwitz, then there definitely exists a vector v satisfying the inequality (A + BΣ2C)[⊤] v < 0, which guarantees local asymptotic stability in the positive orthant. The existence of such v is guaranteed by Lemma 2. 

9: Exit: No suitable Lyapunov function found 

10: end if 

- 11: Define Lyapunov Function: V (x) = x[⊤] Px 

- 12: Initialize ρmax ← 0 

13: for ρ in increasing values do 14: Define sublevel set Lρ = {x | V (x) ≤ ρ} 15: Sample points x on the boundary ∂Lρ 16: for each x on ∂Lρ do 17: Compute V[˙] (x) using V˙ (x) = x[⊤] (A[⊤] P + PA)x + 2x[⊤] PBΦ(Cx, .) 18: if V[˙] (x) ≥ 0 then 19: Break: Sublevel set not invariant 20: end if 21: end for 22: if V[˙] (x) < 0 for all x on ∂Lρ then 23: Update ρmax ← ρ 24: else 25: Break: Maximum invariant sublevel set found 26: end if 27: end for 28: return Lρmax as an estimate of ROA 

This linear formulation offers a computationally efficient alternative, albeit often yielding more conservative ROA estimates than the quadratic case. 

This method is applicable to general nonlinearities, including NNs. It significantly reduces the search space for ROA from arbitrary sets to ellipsoidal regions aligned with Lyapunov levels. By focusing on invariant sublevel sets rather than the global sector region Γ, the approach mitigates the conservatism typically associated with worst-case sector analysis and provides a practically verifiable estimate of the region of attraction. 

## V. LOCAL SECTOR BOUNDS FOR FFNN 

Given that the positive Aizerman conjecture fundamentally relies on the existence of sector bounds for the system nonlinearity, we begin by introducing a novel formulation of local sector bounds for NNs specifically tailored to the stability analysis theorems. To the best of our knowledge, this is the first sector based characterization of its kind within the machine learning literature. 

Relative to other available bounds—norm products [11], CROWN [13], RecurJac [12], and local Lipschitz estimates 

[26]—our construction (i) is tighter than norm-based bounds, (ii) avoids CROWN’s affine offsets, aligning with the linear sector condition in the Aizerman framework, and (iii) fixes sector slopes at the origin rather than taking derivative of the activation function at boundaries of pre-activation logits, cutting computational overhead while preserving fidelity near equilibrium. The method scales to high-dimensional networks without symbolic or gradient calculations. We focus on fully connected FFNNs without biases, although these constraints can be relaxed with a straightforward extension of the method. The network structure is as follows: 

**==> picture [235 x 41] intentionally omitted <==**

where the input is denoted by y ∈ R[n] +[0][,][and][the][output][of] the i-th layer (pre-activation) is given by ν[(][i][)] ∈ R[n][i] for i = 1, . . . , q. Moreover, W[(][i][)] ∈ R[n][i][×][n][i][−][1] is the weight matrix at layer i, and φ[(][i][)] (·) denotes the element-wise activation function applied at that layer. 

To compute the local sector bounds, we employ intervalbased nonaffine linear relaxations of the activation functions, resulting in linear upper and lower approximations of their nonlinear mappings. These linear bounds are then forward propagated through the weight matrices at each layer. This process maintains a linear relation between the input and the propagated bounds at every stage of the network. 

We start from sector bounding the first layer. For the first layer, the pre-activation logits (ν[(1)] = W[(1)] y) are trivially sector bounded in: 

**==> picture [169 x 11] intentionally omitted <==**

Now we propagate this sector bound through the activation function. An explanation of this stage is given in the following subsection. 

A. Propagation of Sector Bounds through Activation Functions 

To carry out the linear relaxations for the activation functions, we first need to compute intervals for the pre-activation logits ν[(][i][)] ∈ R[n][i] at each hidden layer, denoted by ν(i), ν[(][i][)] ∈ R[n][i] . These intervals serve as the foundation for constructing valid linear relaxations of the activation functions. The full procedure for calculating these bounds across the network is summarized in part V-A.1, with additional technical details available in [14]. Given the pre-activation logits calculated from part V-A.1, we propagate sector bounds through the activation function in part V-A.2. 

1) Computation of pre-Activation logits: Consider a fully connected FFNN described in (16). The pre-activation bounds are computed recursively using interval arithmetic as follows. 

Assuming the input y ∈ Γ ⊆ R[n][0] is bounded componentwise by y ≤ y ≤ y, the input bounds propagate through the first layer using: 

**==> picture [223 x 20] intentionally omitted <==**

Since the weights are fixed, these expressions reduce to standard interval linear operations. Specifically, for each component of ν[(1)] : 

**==> picture [193 x 59] intentionally omitted <==**

For subsequent layers i ≥ 2, we apply the same logic to the output bounds of the previous layer’s post-activation: 

**==> picture [238 x 59] intentionally omitted <==**

These recursive bounds can be computed efficiently, and they enable us to define the domain over which linear relaxations of activation functions are constructed. The resulting preactivation intervals [ν(i), ν[(][i][)] ] are then used to form upper and lower linear envelopes for each activation function. 

With the pre-activation logit bounds computed, we are now equipped to propagate sector bounds through activation functions, as shown in the following part. 

2) Sector relaxation of activation functions: To obtain a linear sector representation of the activation outputs ω[(][i][)] = φ(ν[(][i][)] ), we apply linear relaxation techniques to the nonlinear activation function. Assume that the pre-activation logits are sector bounded in 

**==> picture [167 x 12] intentionally omitted <==**

We readily have this assumption met for the first layer as shown in (17). We now derive the corresponding sector bounds for the post-activation output ω[(][i][)] . 

Consider a scalar neuron j at layer i, where the activation output is given by ωj[(][i][)] = φ(νj[(][i][)][)][.][For][concreteness,][we][take] φ = tanh, though the method applies to any monotonic sector bounded activation. Figure 2 illustrates the operations explained in this subsection. We aim to linearly upper and lower bound φ(νj[(][i][)][)][over][its][input][interval][using][slope] parameters: 

**==> picture [172 x 15] intentionally omitted <==**

The coefficients lj[(][i][)] and u[(] j[i][)] are chosen based on the signs (i) of ν j and ν[(] j[i][)][,][as][follows:] 

**==> picture [236 x 47] intentionally omitted <==**

Each of the above cases corresponds to Figures 2a, 2b, and 2c with the parameters α and β defined in the captions. The (i) first two cases are handled by directly replacing ν j and ν[(] j[i][)] with the sector expressions in (24): 

**==> picture [176 x 14] intentionally omitted <==**

**==> picture [156 x 6] intentionally omitted <==**

**==> picture [7 x 6] intentionally omitted <==**

**==> picture [156 x 117] intentionally omitted <==**

**==> picture [7 x 117] intentionally omitted <==**

**==> picture [155 x 6] intentionally omitted <==**

**==> picture [8 x 6] intentionally omitted <==**

**==> picture [155 x 117] intentionally omitted <==**

**==> picture [8 x 117] intentionally omitted <==**

**==> picture [155 x 6] intentionally omitted <==**

**==> picture [8 x 6] intentionally omitted <==**

**==> picture [155 x 117] intentionally omitted <==**

**==> picture [8 x 117] intentionally omitted <==**

**==> picture [475 x 35] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Positive ν: β = [tanh(] ν ν) , α = [tanh(] ν [ν] ) , (b) Negative ν: β = [tanh(] ν [ν] ) , α = [tanh(] ν ν) , (c) Unstable ν: α1 = α2 = [d][ tanh(] d(ν) [ν][)] = 1,<br>βν ≤ tanh(ν) ≤ αν αν ≤ tanh(ν) ≤ βν β1 = [tanh(] ν [ν] ) , β2 = [tanh(] ν ν) ,<br>α1ν ≤ tanh (ν) ≤ α2ν<br>**----- End of picture text -----**<br>


Fig. 2: Illustration of linear relaxation of φ = tanh(ν) under different intervals for ν. 

respectively, where Lj,: denotes the j-th row of matrix L. For the third case (crossing zero), we apply the Cauchy–Schwarz inequality: 

**==> picture [195 x 13] intentionally omitted <==**

(i) Now, we replace νj and ν[(] j[i][)] by L[(] j,[i] :[)][y][and][U][ (] j,[i] :[)][y][respec-] tively, and since y ≥ 0 for positive systems, we can move the vector y outside the absolute value, yielding: 

**==> picture [202 x 13] intentionally omitted <==**

We now combine equations (26), 27, and (29) to form a unified equation. Let Dlow[(][i][)][, D] up[(][i][)] ∈ R[n][i][×][n][i] be diagonal matrices containing the slope parameters and define adjusted slope matrices L[ˆ][(][i][)] , U[ˆ][(][i][)] ∈ R[n][i][×][n][0] . The post-activation output is sector bounded as: 

**==> picture [190 x 14] intentionally omitted <==**

where: 

**==> picture [242 x 94] intentionally omitted <==**

The construction in (30) enables the propagation of sector bounds through the activation function. In the next step, we propagate these sector bounds through weight matrices. 

## B. Propagation of Sector Bounds through Weight Matrices 

At this step, the bounds are passed through the weight matrices to obtain updated sector bounds. From the last subsection, we can rewrite equation (30) as below: 

**==> picture [243 x 15] intentionally omitted <==**

To propagate this sector constraint through the linear map W[(][i][+1)] , we use the positive and negative decompositions of the weight matrix: 

**==> picture [130 x 16] intentionally omitted <==**

**==> picture [128 x 15] intentionally omitted <==**

so that W[(][i][+1)] = W+[(][i][+1)] + W−[(][i][+1)] . Applying this decomposition, the propagated bounds on ν[(][i][+1)] are given by: 

**==> picture [240 x 32] intentionally omitted <==**

Thus, the pre-activation logits ν[(][i][+1)] are sector bounded with respect to y as: 

**==> picture [183 x 13] intentionally omitted <==**

where the new slope matrices are defined by: 

**==> picture [135 x 28] intentionally omitted <==**

This recursive formulation enables the forward propagation of sector bounds across the weight matrices of each layer. The equation (32) can be fed into equation (24) to close the loop of iteration for layers. 

## C. Sector Bound for the Entire Neural Network 

We now combine the results of the previous two subsections to derive a sector bound for the entire FFNN. We explain how to go step by step to get the whole sector bound. We start from the sector bound of the first layer given in equation (17), and propagate it forward iteratively using the results of Subsections V-A.2 (activation relaxations) and V-B (weight matrix transformations). This process yields a final sector bound for the overall neural network output with respect to its input. We summarize the result in the following. 

Theorem 4 (Local Sector Bound for FFNN). Consider an FFNN as in (16) π : R[p] +[→][R][m][with][sector][bounded] activation functions. Given the set Γ, then the sector bound for the network mapping NN(y) can be calculated as: 

**==> picture [190 x 71] intentionally omitted <==**

and the matrices Dlow[(][i][)][, D] up[(][i][)][,][ ˆ][L][(][i][)][,][U][ˆ][ (][i][)][are defined according] to the activation relaxation scheme described in (31). 

This local sector bound enables the application of the local positive Aizerman conjecture for analyzing the stability of NN feedback systems. In particular, we utilize Theorem 2 and Lemma 3 to certify local exponential stability and estimate the ROA of NN-controlled feedback loops. 

Corollary 1. Consider the Lur’e system defined in (2), where the nonlinearity Φ is realized by an FFNN as described in (16). Given a compact set Γ if the matrix A + Bγ1C is Metzler and A+Bγ2C is Hurwitz, with slope matrices γ1, γ2 computed via (33), then the closed loop system is locally exponentially stable for all trajectories that remain within the set Γ. 

This result follows directly from Theorem 2 and Theorem 4. Furthermore, in the scalar case (i.e., when the Lur’e system is MISO), Lemma 3 can be applied to estimate the region of attraction. To do so, one computes the upper bound of Γ, and then applies the analytical formula in (5) to determine the set of stable initial conditions. 

## VI. NUMERICAL EXAMPLE 

Consider a Lur’e system as in (2), where an open-loop unstable LTI plant is stabilized by an NN controller. The plant dynamics are given by: 

**==> picture [173 x 19] intentionally omitted <==**

Using parametric analysis, we compute the minimal lower sector Σ1 = −3 such that the matrix A + BΣ1C becomes Metzler, and the maximal upper sector Σ2 = −1.276 such that A + BΣ2C is Hurwitz. These values define the stable sector interval [Σ1, Σ2] for the application of Aizerman-type results. A PID controller with gains P = −1.25, I = −0.1, and D = −0.1 is used as a benchmark for generating training data for a stabilizing NN controller. We collect closed loop input-output trajectory data by randomly initializing the system near x0 = [2, 2][⊤] . An FFNN is trained to approximate the stabilizing PID controller. Figure 3a shows the resulting NN and its input-output relation relative to the stable sector bounds [Σ1, Σ2]. It is evident that the trained NN is Γ−sector bounded within the interval. Numerically, we identify the Γ set and its maximal element to be y = 12.2. 

**==> picture [245 x 104] intentionally omitted <==**

**----- Start of picture text -----**<br>
50<br>40<br>30<br>20<br>10<br>0 -12.2 12.2<br>-10<br>-20<br>-30<br>-40<br>-50-15 -10 -5 0 5 10 15<br>**----- End of picture text -----**<br>


(3a) NN output, safe sector bounds, (3b) Stability of trajectories inside and corresponding Γ set. the ROA estimated by Lemma 3. 

a) Region of Attraction via Local Positive Aizerman: Regarding Lemma 3, we compute v with the max ratio vm/vM = 0.42. Applying equation (5), we obtain the estimate of ROA as Cx0 ≤ 5.12. Figure 3b shows closedloop trajectories demonstrating exponential convergence for initial conditions within this ROA. 

b) Region of Attraction via Lyapunov Method: We now apply the Lyapunov-based approach by solving the matrix inequality (10). This yields a quadratic Lyapunov function 

**==> picture [193 x 19] intentionally omitted <==**

Using Algorithm 1, we estimate the largest sublevel set satisfying V[˙] (x) < 0, resulting in the ROA x[⊤] Plmx ≤ 32. Figure 4a visualizes this approach by showing sublevel sets that remain in the negative V[˙] area, and Figure 4b shows random trajectories starting inside the estimated ROA. 

**==> picture [251 x 93] intentionally omitted <==**

**----- Start of picture text -----**<br>
12 9<br>8<br>10 7<br>8 6<br>5<br>6<br>4<br>4 3<br>2<br>2<br>1<br>0 0 2 4 6 8 10 12 0 0 2 4 6 8 10 12 14 16<br>**----- End of picture text -----**<br>


(4a) Evaluation of V[˙] from equation (11) across R[2] with overlaid sublevel sets of V . 

(4b) Stability of trajectories inside the ROA estimated by Algorithm 1. 

**==> picture [236 x 8] intentionally omitted <==**

**==> picture [10 x 8] intentionally omitted <==**

**==> picture [236 x 177] intentionally omitted <==**

**==> picture [10 x 177] intentionally omitted <==**

Fig. 5: Local sector bounds calculated for given y ∈ Γ using equation (33). The title of each subplot defines the Γ set and the corresponding [γ1, γ2]. c) Local Sector Bound: We now evaluate our proposed local sector bound formulation. As shown in Figure 5, our local sector bounds tightly follow the NN output. This figure demonstrates how the sector bounds evolve as a function of the input range. As expected, the bounds widen with increasing input magnitude and intersect the critical upper sector Σ2 = −1.276 at y ∈ [0, 12.2]. This value represents the largest admissible Γ set. Applying Corollary 1 and Lemma 3 using y = 12.2 recovers the same ROA plot as shown in Figure 3b. Moreover, Figure 6a compares our local sector bounds with the CROWN and IBP bounds calculated using the auto-LIRPA library [13], showing structural differences. 

d) Comparison with IQC-Based Approach: As a benchmark, we compare our method against one of the best approaches in the literature [4], which uses IQCs to bound NN nonlinearities. This method produces a Lyapunov function 

**==> picture [210 x 19] intentionally omitted <==**

and yields a conservative ROA of x[⊤] Pqcx ≤ 1. 

Table I summarizes the comparison of methods in terms of runtime and estimated ROA, while Figure 6b visualizes the corresponding ROA estimates. As shown, the local sector bound approach outperforms the IQC-based method in both scalability and conservatism of ROA estimation. As expected, the Lyapunov method provides the largest underapproximation at the cost of computational complexity. 

|Method|Runtime (s)|ROA|
|---|---|---|
|Local Sector Bound|5×10−4|Cx0 ≤5.12|
|Lyapunov-based Method|5.45|x⊤Plmx≤32|
|IQC-based|1.03|x⊤Pqcx≤1|



TABLE I: Comparison of methods based on runtime and ROA. 

**==> picture [107 x 5] intentionally omitted <==**

**==> picture [5 x 5] intentionally omitted <==**

**==> picture [115 x 4] intentionally omitted <==**

**==> picture [6 x 4] intentionally omitted <==**

**==> picture [107 x 80] intentionally omitted <==**

**==> picture [5 x 80] intentionally omitted <==**

**==> picture [115 x 78] intentionally omitted <==**

**==> picture [6 x 78] intentionally omitted <==**

(6a) Comparison of local sector (6b) Comparison of our estimated bounds vs. CROWN & IBP bounds. ROAs vs. IQC method ROA. 

## VII. CONCLUSION AND FUTURE WORK 

This work presents a comprehensive framework for analyzing the local stability of positive Lur’e systems with NN feedback. By introducing a localized version of the positive Aizerman conjecture, we derive verifiable conditions under which output trajectories confined to a compact set exhibit exponential stability. This theoretical foundation enables us to propose two distinct methods for estimating the ROA around a stable equilibrium. The first method leverages a Lyapunov-based approach, where we construct a quadratic Lyapunov function via LMIs and identify invariant sublevel sets guaranteeing convergence. This method is applicable to arbitrary sector-bounded nonlinearities, including NNs, and benefits from strong guarantees under classical positive system theory. The second method introduces a novel sector bound for FFNNs. By propagating local input bounds through the network using layer-wise linear relaxations, we derive tight, structure-dependent sector bounds without relying on global Lipschitz constants or loose norm-based approximations. This bound is seamlessly integrated into the localized Aizerman framework, enabling efficient stability certification and ROA estimation that scales with network size and complexity. Simulation results demonstrate that both proposed methods outperform existing IQC-based techniques in terms of ROA size and computational efficiency. Future work includes extending the framework to biased and recurrent neural networks, incorporating the novel bounds in 

other stability verification frameworks, and employing this approach for training safe learning-based control policies. 

REFERENCES 

- [1] K. Hornik, M. Stinchcombe, and H. White, “Multilayer feedforward networks are universal approximators,” Neural Networks, vol. 2, no. 5, pp. 359–366, 1989. 

- [2] G. Goel and P. Bartlett, “Can a transformer represent a kalman filter?,” in 6th Annual Learning for Dynamics & Control Conference, pp. 1502–1512, PMLR, 2024. 

- [3] A. Honarpisheh, M. Bozdag, O. Camps, and M. Sznaier, “Generalization error analysis for selective state-space models through the lens of attention,” arXiv preprint arXiv:2502.01473, 2025. 

- [4] H. Yin, P. Seiler, and M. Arcak, “Stability analysis using quadratic constraints for systems with neural network controllers,” IEEE Transactions on Automatic Control, vol. 67, no. 4, pp. 1980–1987, 2021. 

- [5] C. de Souza, A. Girard, and S. Tarbouriech, “Event-triggered neural network control using quadratic constraints for perturbed systems,” Automatica, vol. 157, p. 111237, 2023. 

- [6] S. V. Noori, B. Hu, G. Dullerud, and P. Seiler, “Stability and performance analysis of discrete-time relu recurrent neural networks,” in 2024 IEEE 63rd Conference on Decision and Control (CDC), pp. 8626–8632, IEEE, 2024. 

- [7] S. V. Noori, B. Hu, G. Dullerud, and P. Seiler, “A complete set of quadratic constraints for repeated relu and generalizations,” arXiv preprint arXiv:2407.06888, 2024. 

- [8] M. Newton and A. Papachristodoulou, “Stability of non-linear neural feedback loops using sum of squares,” in 2022 IEEE 61st Conference on Decision and Control (CDC), pp. 6000–6005, IEEE, 2022. 

- [9] M. Jin and J. Lavaei, “Stability-certified reinforcement learning: A control-theoretic perspective,” IEEE Access, vol. 8, pp. 229086– 229100, 2020. 

- [10] C. Richardson, M. Turner, S. Gunn, and R. Drummond, “Strengthened stability analysis of discrete-time lurie systems involving relu neural networks,” in 6th Annual Learning for Dynamics & Control Conference, pp. 209–221, PMLR, 2024. 

- [11] C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus, “Intriguing properties of neural networks,” arXiv preprint arXiv:1312.6199, 2013. 

- [12] H. Zhang, P. Zhang, and C.-J. Hsieh, “Recurjac: An efficient recursive algorithm for bounding jacobian matrix of neural networks and its applications,” in Proceedings of the AAAI Conference on Artificial Intelligence, vol. 33, pp. 5757–5764, 2019. 

- [13] S. Wang, H. Zhang, K. Xu, X. Lin, S. Jana, C.-J. Hsieh, and J. Z. Kolter, “Beta-crown: Efficient bound propagation with per-neuron split constraints for neural network robustness verification,” Advances in neural information processing systems, vol. 34, pp. 29909–29921, 2021. 

- [14] S. Gowal, K. Dvijotham, R. Stanforth, R. Bunel, C. Qin, J. Uesato, R. Arandjelovic, T. Mann, and P. Kohli, “On the effectiveness of interval bound propagation for training verifiably robust models,” arXiv preprint arXiv:1810.12715, 2018. 

- [15] M. Bozdag, A. Honarpisheh, and M. Sznaier, “Safe control for pursuitevasion with density functions,” IEEE Control Systems Letters, vol. 9, pp. 432–437, 2025. 

- [16] A. Bill, C. Guiver, H. Logemann, and S. Townley, “Stability of nonnegative lur’e systems,” SIAM Journal on Control and Optimization, vol. 54, no. 3, pp. 1176–1211, 2016. 

- [17] B. Shafai and F. Zarei, “Positive stabilization and observer design for positive singular systems,” in Proceedings of the 2024 63rd IEEE Conference on Decision and Control (CDC), Milan, Italy, pp. 16–19, 2024. 

- [18] B. Shafai, F. Zarei, and A. Moradmand, “Stabilization of input derivative positive systems and its utilization in positive singular systems,” in 2024 10th International Conference on Control, Decision and Information Technologies (CoDIT), pp. 615–620, 2024. 

- [19] R. Drummond, C. Guiver, and M. C. Turner, “Aizerman conjectures for a class of multivariate positive systems,” IEEE Transactions on Automatic Control, 2022. 

- [20] H. Montazeri Hedesh and M. Siami, “Ensuring both positivity and stability using sector-bounded nonlinearity for systems with neural network controllers,” IEEE Control Systems Letters, vol. 8, pp. 1685– 1690, 2024. 

- [21] H. M. Hedesh, M. Wafi, B. Shafai, M. Siami, et al., “Robust stability analysis of positive lure system with neural network feedback,” arXiv preprint arXiv:2505.18912, 2025. 

- [22] A. Mashhadireza and A. Sadighi, “Improved tracking performance of a lorentz actuator in contact tasks with model-based iterative learning control,” in 2023 11th RSI International Conference on Robotics and Mechatronics (ICRoM), pp. 821–826, 2023. 

- [23] A. Mashhadireza and A. Sadighi, “Iterative learning control for friction compensation of a lorentz actuator for periodic references,” in 2024 12th RSI International Conference on Robotics and Mechatronics (ICRoM), pp. 697–702, 2024. 

- [24] L. Farina and S. Rinaldi, Positive linear systems: theory and applications. John Wiley & Sons, 2011. 

- [25] E. D. Sontag, Mathematical control theory: deterministic finite dimensional systems, vol. 6. Springer Science & Business Media, 2013. 

- [26] Z. Shi, Y. Wang, H. Zhang, J. Z. Kolter, and C.-J. Hsieh, “Efficiently computing local lipschitz constants of neural networks via bound propagation,” Advances in Neural Information Processing Systems, vol. 35, pp. 2350–2364, 2022. 

