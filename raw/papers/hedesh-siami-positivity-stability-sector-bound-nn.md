---
title: "Ensuring Both Positivity and Stability Using Sector-Bounded Nonlinearity for Systems with Neural Network Controllers"
arxiv: "2406.12744"
authors: ["Hamidreza Montazeri Hedesh", "Milad Siami"]
year: 2024
source: paper
ingested: 2026-05-01
sha256: 69dab8ec35b75377fb8846eacc1f361881985322479c0ee3d86ca2d936df6409
conversion: pymupdf4llm
---

## Ensuring Both Positivity and Stability Using Sector-Bounded Nonlinearity for Systems with Neural Network Controllers 

Hamidreza Montazeri Hedesh[1] and Milad Siami[1] Senior Member, IEEE 

**Abstract— This paper introduces a novel method for the stability analysis of positive feedback systems with a class of fully connected feedforward neural networks (FFNN) controllers. By establishing sector bounds for fully connected FFNNs without biases, we present a stability theorem that demonstrates the global exponential stability of linear systems under fully connected FFNN control. Utilizing principles from positive Lur’e systems and the positive Aizerman conjecture, our approach effectively addresses the challenge of ensuring stability in highly nonlinear systems. The crux of our method lies in maintaining sector bounds that preserve the positivity and Hurwitz property of the overall Lur’e system. We showcase the practical applicability of our methodology through its implementation in a linear system managed by a FFNN trained on output feedback controller data, highlighting its potential for enhancing stability in dynamic systems.** 

**Index Terms— Neural Networks, Neural Network Verification, Positive Systems, Neural Network Bound, Stability Analysis** 

## I. INTRODUCTION 

ULTILAYER feedforward neural networks are univerM sal approximators [1]. This fact has led to extensive applications of neural networks (NN) across various fields. In the field of control systems, there has been a longstanding interest in using NNs as controllers in the feedback loop of the systems. However, many challenges have emerged along the way [2]. NN-controllers inherit many challenges due to their complex and highly nonlinear structure. Input sensitivity, lack of robustness, and lack of stability certificates are some of the issues that pose severe risks in safety-critical systems. Consequently, many recent studies have tried to address these shortcomings and propose methods for verification of NNs in closed loop. 

Control theory provides an arsenal of valuable tools conducive to the verification of NN-controllers, such as Lyapunov 

This material is based upon work supported in by grants ONR N00014-21-1-2431, NSF 2121121, NSF 2208182, the U.S. Department of Homeland Security under Grant Award Number 22STESE00001-0302, and by the Army Research Laboratory under Cooperative Agreement Number W911NF-22-2-0001. The views and conclusions contained in this document are solely those of the authors and should not be interpreted as representing the official policies, either expressed or implied, of the U.S. Department of Homeland Security, the Army Research Office, or the U.S. Government. 

> 1H. Montazeri Hedesh and M. Siami are with the Department of Electrical & Computer Engineering, Northeastern University, Boston, MA 02115, USA. (e-mails: {montazerihedesh.h, m.siami}@northeastern.edu). 

functions, robust control techniques, passivity analysis, and Control Barrier Functions (CBFs), among others. Researchers are actively exploring the integration of these tools to develop robust verification methods. In a notable instance, the studies [3], [4] leverage Quadratic Constraints (QCs), combining them with Lyapunov functions for a comprehensive verification approach. The authors continued their work on Integral Quadratic Constraint (IQC) for verification of NNs in [5]. The authors of [6], [7] employ QCs along with the S-procedure to establish stability conditions and address reachability concerns. Some studies like [8] used passivity theorem. The authors in [9] propose the use of CBF to address these challenges, presenting a distinctive perspective. The article [10] used Lur’e systems, Circle, and Popov criteria to analyze the stability of such systems. The study [11] used the Sum of Squares (SOS) method to device Lyapunov functions for stability assurance of NN-controllers in the feedback loop of nonlinear systems. Many other creative methods have been used to verify NNcontrolled systems. [12]–[14]. A comprehensive review of the methodologies used in this domain is presented in [15]. 

These mathematical tools are very useful in the analysis of the highly nonlinear structures inherent in NN-controlled systems. However, they carry their limitations such as complexity and lack of scalability to large systems. Some studies have tried to tackle this drawback [16]. For example, [17], [18] came up with algorithms to split the verification problem into subproblems and solve them more efficiently. Meanwhile, the search for new mathematical tools is still ongoing, and there exist many unexplored useful tools [19]. Recently, one of the fundamental and simple methods for stability verification of nonlinear systems came into light. Aizerman’s conjecture for absolute stability was proven to be wrong universally [20]. However, very recently, the conjecture was proved to hold for the class of positive systems [21]. These new findings opened the way to developing a simple and scalable method for the verification of NN-controllers. Our findings presented in this paper are based on this method. The use of Lur’e systems in the analysis of NNs is not a new concept, and there is literature covering this method such as [22]. However, the use of the Aizerman conjecture was absent due to the general disprove of it. In this article, we use this simple yet resourceful conjecture for positive NN-controlled systems. 

In this paper, we introduce a sector bound for a fully connected FFNN without biases. The sector bound is based on the properties of the activation function of the NN and its 

weights. The establishment of sector bounds was necessitated by their indispensability in our verification methodology. Existing bounds such as IBP [23], Lipschitz constant [24], and Quadratic Constraints as described in [3], [6] lacked the requisite structure for verification via the Aizerman conjecture. Consequently, we devised our own bounds. Our proposed bound diverges significantly from the IBP method and the Lipschitz constant of the NN. The IBP method involves propagating the input through layers, identifying bounds for the output polytopes of each layer. However, the resulting output bound is a set that lacks explicit connection with the input to the NN. Additionally, the Lipschitz constant, being a scalar, may even exceed the sector bound of a given nonlinear function. In contrast, sector bounds establish a direct relationship between the output and input, potentially spanning higher dimensions than a scalar. These characteristics make sector bounds particularly valuable for nonlinear analysis of NNs, notably in the context of the Aizerman and Kalman conjecture. Previous works such as [3] and [6] also utilize sector bounds, albeit restricting the nonlinearity to the NN’s activation functions. In this paper, we introduce a sector bound for the entire NN, motivated by its necessity in addressing the Aizerman conjecture. Using the proposed sector bound, we present our stability theorem. 

The contribution of our work is twofold. First, an introduction of a sector bound for fully connected without biases which can be used further in many applications, like forward reachable sets of NNs, or nonlinear control analysis of the closed loop systems. Moreover, we present a simple verification test for the stability of positive closed-loop systems consisting of NN-controllers and linear time-invariant (LTI) systems. The stability condition is simply based on the calculated sector bounds. It only checks that the upper and lower bounds of the system are Metzler and Hurwitz, respectively. The calculation does not require a huge amount of memory and time, making it suitable for extending to more complex systems and system of systems. Another standout point of this research compared to the literature is that it can handle continuous-time systems. Moreover, this paper addresses global asymptototic stability (within the context of positive systems) of NN-controlled systems, while most of the available verification methods study local stability. 

## A. Notation 

The orders <, ≥, when applied to matrices and vectors, act elementwise. The set of real numbers is denoted by R, and the set of nonnegative real numbers by R+. The set of real n-dimensional vectors and the set of real m × n-dimensional matrices are denoted by R[n] and R[m][×][n] , respectively. For a real matrix (vector) Q, the notation Q > 0 indicates that all elements of Q are positive, Q ≥ 0 indicates that all elements of Q are nonnegative. < and ≤ are defined similarly. We define R[n] +[:=][ {][ν][∈][R][n][:][ν][≥][0][}][.][In][addition,][we][define][R] +[n][×][m] with obvious modifications. 0n and In denote a vector of zeros and the Identity matrix of size n, respectively. Furthermore, given a matrix A, the elementwise absolute value is denoted 

**==> picture [89 x 56] intentionally omitted <==**

Fig. 1: Lur’e system with plant G and nonlinear controller Φ. 

**==> picture [208 x 65] intentionally omitted <==**

With this definition, it is evident that for two real matrices Q and T of compatible dimensions, |QT |abs ≤|Q|abs|T |abs. 

## II. PRELIMINARIES 

## A. Positive Systems 

In the world of control theory, the concept of positive systems plays an important role due to their widespread applicability in various domains such as economics, biology, and engineering. Positive systems are distinguished by their intrinsic property that, given nonnegative initial conditions, their state variables remain non-negative for all future times. This section aims to succinctly define positive systems, outline the essential conditions for their positivity, and explain technical terms. Consider the generic linear control system: 

**==> picture [209 x 11] intentionally omitted <==**

where A ∈ R[n][×][n] , B ∈ R[n][×][m] , and C ∈ R[p][×][n] are constant matrices. In addition, u(t) ∈ R[m] , x(t) ∈ R[n] , and y(t) ∈ R[p] denote input, state, and output variables. 

Definition 1 (Positive Linear System): A linear system, as characterized by (1), is defined to be Positive if, for all t > 0, given initial conditions x(0) ≥ 0 and input u(t) ≥ 0, the state x(t) remains non-negative. 

Definition 2 (Metzler Matrix): A matrix M = [mij] ∈ R[n][×][n] is defined as a Metzler matrix if all its off-diagonal elements are non-negative; that is, mij ≥ 0 for all i ̸= j. 

˙ Fact 1: Consider the linear differential equation x = Mx. The system described above is positive if and only if the matrix M is Metzler. Moreover, if M is also Hurwitz, there must exist a vector v ∈ R[n] +[,][v][>][0][with][all][positive][entries][such] that v[T] M < 0 has all negative entries. This fact is adopted from [21] and detailed proofs of the claims can be found in the references therein [25], [26]. Proposition 1: Given a system described by (1) and considering the definition of a positive system as per Definition 1, the system is positive if and only if matrix A is Metzler, and matrices B ∈ R+[n][×][m] and C ∈ R[p] +[×][n] [27]. 

## B. Lur’e Systems and Aizerman’s Conjecture 

The classical framework of Lur’e systems and Aizerman’s conjecture applies to Single Input Single Output (SISO) systems. These involve a SISO linear system interconnected with a nonlinearity in the feedback loop, as shown in Fig. 1. Consider a closed-loop nonlinear control system described by 

**==> picture [207 x 78] intentionally omitted <==**

**----- Start of picture text -----**<br>
ReLu function tanh function<br>2 2<br>0 0<br>-2 -2<br>-2 0 2 -2 0 2<br>x x<br>f(x) f(x)<br>**----- End of picture text -----**<br>


Fig. 2: ReLU and tanh sector-bounded in [0, 1]. 

˙ x(t) = Ax(t) + bΦ(σ), σ = c[T] x(t), where x ∈ R[n] is the state vector, A ∈ R[n][×][n] is the system matrix, b, c ∈ R[n] are constant vectors. The nonlinearity Φ : R �→ R satisfies Φ(0) = 0. Aizerman’s conjecture states that the system is globally asymptotically stable if, for every linearization of Φ within a sector [k1, k2], where k1 and k2 are real constants, the ˙ linearized system x(t) = Ax(t) + bkσ, σ = c[T] x(t), k ∈ [k1, k2], is asymptotically stable. The sector condition is 

**==> picture [185 x 23] intentionally omitted <==**

Note that common NN activation functions, such as tanh and ReLU, satisfy sector bounds within [0, 1]. Fig. 2 illustrates these functions with the global sector [0, 1]. However, exceptions to Aizerman’s conjecture exist, with counterexamples showing systems that meet the conjecture’s criteria but have both a stable equilibrium and a stable periodic solution. Nonetheless, under more stringent conditions, such as system positivity, the conjecture’s validity is reinforced [21]. 

## C. Positive Lur’e Systems 

While the Aizerman conjecture was traditionally associated with SISO systems, this discussion extends to encompass Multi-Input Multi-Output (MIMO) systems. Consider the class of Lur’e systems shown in Fig. 1. Assume the interconnection of the linear system (1) and the static nonlinear feedback u = Φ(y, .). The dynamics of such an interconnection can be succinctly represented by: 

**==> picture [178 x 11] intentionally omitted <==**

where A ∈ R[n][×][n] , B ∈ R[n][×][m] , and C ∈ R[p][×][n] are constant matrices and the multivariate function Φ : R[p] × R �→ R[m] is assumed to satisfy Φ(0, t) = 0, ∀t ≥ 0, ensuring that x∗ = 0 serves as an equilibrium point for (3). A fundamental assumption in this study is the well-posedness of the feedback interconnection depicted in Fig. 1. We assume the existence of a unique and locally absolutely continuous function χ : R+ �→ R[n] that satisfies equation (3) almost everywhere, for any initial condition x(0) ∈ R[n] . The well-posedness of the system is predicated on standard conditions applied to the nonlinearity Φ(z, t): it must be locally Lipschitz in z and measurable in t, along with certain mild boundedness conditions. These prerequisites ensure the existence and uniqueness of the solution, as delineated in foundational control theory literature such as [28, Th. 54, Prop. C.3.8]. 

Given the MIMO system context, the multivariable function Φ transcends the traditional sector bound definition as in (2). Within the context of positive systems, defining a sector bound for the multivariable function Φ is most coherently articulated in terms of componentwise inequalities. For the 

case of positive systems, we define a sector bound for Φ as following. Given two matrices Σ1, Σ2 ∈ R[m][×][p] , with Σ1 ≤ Σ2[1] , the function Φ is considered to be within sector [Σ1, Σ2] if: 

**==> picture [214 x 12] intentionally omitted <==**

By establishing the sector bound within a MIMO system framework, we introduce a lemma from [21] that presents a necessary and sufficient condition for the positivity of a Lur’e system. The lemma, provided below, is included here for reference as it becomes essential later in the paper. 

Lemma 1: Consider the Lur’e system as described in (3), assuming that both B, C ≥ 0. The system (3) is a positive system for any Φ ∈ Sector[Σ1, Σ2] if and only if the matrix A + BΣ1C is Metzler. 

The proof of the lemma can be found in [21]. Finally we address the positive Aizerman conjectur here. As outlined in the work [21], the Aizerman conjecture is true for positive systems. The authors introduce a theorem that establishes the conditions for the global exponential stability of a positive Lur’e system. 

Theorem 1 (Positive Aizerman [21]): Consider a Lur’e-type system (3) with B, C ≥ 0, and Σ1 and Σ2(Σ1 ≤ Σ2) of appropriate dimension. If A+BΣ1C is Metzler and A+BΣ2C is Hurwitz, then for every nonlinearity Φ ∈ Sector [Σ1, Σ2] in the sense of (4), the Lur’e system (3) is globally exponentially stable. 

This is a significant finding that underscores the viability of Aizerman’s conjecture for positive systems. This theorem is instrumental in analyzing the stability of systems controlled by NN. However, a necessary step is to formulate such NNcontrolled systems within the Lur’e system framework. The next part aims to precisely define the problem, framing it within the context established by our discussion on positive systems and their stability characteristics. 

## D. Problem Formulation 

Building upon our discussion and the theoretical framework established, we proceed to define a specific problem involving an LTI system. The system is mathematically characterized as follows: 

Consider an LTI system defined by (1). For the control policy u(t) consider an output feedback controller π in the feedback loop of the system as shown in Fig. 1. The controller π : R[p] �→ R[m] , is realized as a fully connected FFNN with q layers, delineated by: 

**==> picture [215 x 13] intentionally omitted <==**

**==> picture [215 x 13] intentionally omitted <==**

**==> picture [215 x 13] intentionally omitted <==**

**==> picture [215 x 13] intentionally omitted <==**

where ω[(][i][)] ∈ R[l][i] are the output from the ith layer with l0 and lq+1 being imposed by the input and output size to be p and m respectively. ν[(][i][)] ∈ R[l][i] is the vector of the preactivation logits 

> 1Sign conventions: This article makes no assumptions about the signs of the sector bounds Σ1 and Σ2. 

of the ith layer. The operations of each layer are characterized by a weight matrix W[(][i][)] ∈ R[l][i][×][l][i][−][1] , a bias vector b[(][i][)] ∈ R[l][i] , and an activation function φ[(][i][)] , applied in an elementwise manner. 

**==> picture [214 x 20] intentionally omitted <==**

where ϕ : R �→ R is the scalar activation function of the NN. We assume that the activation function φ is uniform across all layers of the FFNN. This assumption simplifies the presentation of the behavior of the NN; however, this assumption can be relaxed with minor modifications to the notation. We denote the equilibrium state of the system by the set of (x∗, y∗, u∗) where 

**==> picture [253 x 10] intentionally omitted <==**

Our objective is to study global stability of the equilibrium state. To achieve this, we plan to transform the closed-loop system, described by (1) and (5), into a Lur’e-type system. This transformation enables us to use the positive Aizerman theorem as our tool for analyzing the stability of the system. 

**==> picture [85 x 8] intentionally omitted <==**

In this section, we take several steps to present our findings on stability assurance of NN-controlled system. Initially, we reconfigure the system into a Lur’e-type framework. Consequently, the need for sector bounding the nonlinear part urges us to find a sector bound for system’s nonlinear component. We propose a sector bound based on the weights of the NN and the sector bounds of scalar activation function chosen for NN. These crucial steps set the groundwork for applying the positive Lur’e theorem to analyze system stability. 

## A. Neural Network controlled system as Lur’e system 

In this study, we assume the LTI system as in (1) as the linear part of the Lur’e system and consequently include the entire q-layer NN denoted by (5) as the nonlinear part. Now, to complete the definition of the Lur’e system, it is required to sector-bound its nonlinear section. 

In our effort to sector bound the output of NN, we look for Σ1 and Σ2 that satisfy the inequality (4). For a positive system (z ∈ R[n] +[)][we][should][have][the][following:] 

**==> picture [179 x 10] intentionally omitted <==**

Note that the nonlinear activation function, φ, as defined in (6), acts elementwise on its argument. 

Theorem 2: Suppose a fully connected FFNN controller π(.) with q layers, as defined in (5), with weights of each layer shown by W[(][i][)] and the biases b[(][i][)] set to zero. The NN takes z ∈ R[p] +[as][input][and][returns][u][(][z][)][∈][R][m][.][Assume][identical] activation functions for all neurons and assume that the chosen scalar activation function lies in sector [a1, a2], (a1 < a2) and let c = max(|a1|, |a2|). Define 

**==> picture [229 x 34] intentionally omitted <==**

The defined NN is sector-bounded in the following interval: 

Proof: The proof has two parts. First, it uses a mathematical induction to establish that the output of the qth layer (5c) is sector-bounded in −c[q][ ��][q] i=1[|][W][ i][|][abs] � z ≤ π(z) ≤ c[q][ ��][q] i=1[|][W][ i][|][abs] � z. Then it adds the weights of the output layer W[(][q][+1)] to the inequality to establish the theorem. 

Base Case: The sector bounds for the output of the first layer of the NN, defined in (5) with ω[(0)] = z, are given by: 

**==> picture [207 x 12] intentionally omitted <==**

assuming the scalar activation function ϕ lies within the sector [a, b] with c = max(|a|, |b|) and y ∈ R[p] +[.][Note][that][both][sides] of the inequalities are vectors of size R[l][1] and the inequality is elementwise. Here a sector bound for the output of first layer is calculated. 

Inductive Step: Assume the sector bounds hold for the output of ith layer. Specifically, we have: 

**==> picture [243 x 34] intentionally omitted <==**

We seek to prove these bounds extend to output of the i + 1th layer. Through multiplying the output of i-th layer by W[(][i][+1)] ∈ R[l][i][+1][×][l][i] we get: 

**==> picture [251 x 42] intentionally omitted <==**

with the inequalities being elementwise acting on vectors of size R[l][i][+1] . 

Feeding this preactivation logits to the activation function φ[i][+1] , and given φ[i][+1] (.) is in sector [a1, a2], we obtain: 

**==> picture [233 x 29] intentionally omitted <==**

As explained in the notation section, we can use the property |W[(][i][+1)] φ[(][i][)] |abs ≤|W[(][i][+1)] |abs|φ[(][i][)] |abs, and rewrite (12) as: 

**==> picture [242 x 29] intentionally omitted <==**

From (10) we deduce: |φ[(][i][)] (. . . )|abs ≤|c[i][ ��][i] j=1[|][W][ j][|][abs] � z|abs. Note that both c[i] , z ≥ 0 can be moved out of |.|abs. We use the above inequality in (13) and write: 

**==> picture [203 x 69] intentionally omitted <==**

With the result of induction, the qth layer is sector-bounded in [−c[q][ ��][q] i=1[|][W][ i][|][abs] � z, c[q][ ��][q] i=1[|][W][ i][|][abs] � z]. In the second step of the proof, we simply multiply the weights of the output layer W[(][q][+1)] to the nonlinearity. As a result of the same operation in (11) we obtain: 

**==> picture [227 x 31] intentionally omitted <==**

Γ1z ≤ π(z) ≤ Γ2z. (8) 

Given the transformation of the NN-controlled system into a Lur’e configuration (3), with sector-bounded nonlinearity, we employ positive Aizerman’s theorem (Theorem 1) for stability analysis. The conditions for stability assurance are succinctly outlined in the following theorem. 

Theorem 3: Consider a closed-loop system governed by a linear dynamic model described in (1) and controlled by a NN-based policy u(·) = π(Cx) as defined in (5). The NN π(·) comprises q layers, with weights of the ith layer denoted by W[(][i][)] , and biases b[(][i][)] set to zero. All neurons employ an identical scalar activation function sector bounded within [a1, a2], where c = max(|a1|, |a2|). Define the sector bounds Γ1 and Γ2 as (7). The combined system dynamics are given by: 

**==> picture [180 x 10] intentionally omitted <==**

Assume that B, C ≥ 0. Additionally, let the system reach equilibrium at (x∗, y∗, u∗) = 0. If A + BΓ1C is Metzler and A + BΓ2C is Hurwitz, then the closed-loop system exhibits global exponential stability. 

For the proof of Theorem 3, we follow the steps of the proof of Theorem 1 as in [21]. 

Proof: Given x(0) ∈ R[n] +[and][the][NN][controller][π][∈][Sector] [Γ1, Γ2], Lemma 1 guarantees that x(t) ≥ 0 for all t ≥ 0. This permits us to reformulate and approximate equation (14) as: 

**==> picture [241 x 11] intentionally omitted <==**

where M = A + BΓ2C is Metzler and Hurwitz. From Fact 1, it follows that there exists a vector v ∈ R[n] +[with][v][>][ 0][,][and][a] scalar ǫ > 0 such that: 

**==> picture [155 x 11] intentionally omitted <==**

Given that v is strictly positive, we get: 

**==> picture [202 x 13] intentionally omitted <==**

where vm and vM are the minimum and maximum elements of v, respectively. Simple calculations using (16) and (15) yield the result that for almost all t ≥ 0: 

d dt[e][ǫt][v][T][ x][(][t][) =][ ǫe][ǫt][v][T][ x][(][t][)+][e][ǫt][v][T][x][˙][(][t][)][ ≤][e][ǫt][(][ǫv][T][ +][v][T][ M][)][x][(][t][)][ ≤][0][.] 

Since t �→ e[ǫt] v[T] x(t) is nonnegative, (17) yields: 

**==> picture [235 x 12] intentionally omitted <==**

from which the global exponential stability is deduced. ■ 

## IV. EXAMPLES 

In this section, we provide an example to demonstrate the applicability of our theorem. Consider the following system: 

**==> picture [217 x 22] intentionally omitted <==**

The controller is parameterized by an fully connected FFNN with 4 layers, containing 10, 15, 15, 1 neurons in each hidden layer. The activation function tanh, sector-bounded in [0, 1], is selected for all neurons. Biases are set to zero, therefore, (x∗, y∗, u∗) = 0 is an equilibrium point. NN controller is trained to mimic an LQR controller with Q = I2 and R = 1. Upon completion of training, the NN π serves as 

**==> picture [124 x 4] intentionally omitted <==**

**==> picture [6 x 4] intentionally omitted <==**

**==> picture [124 x 4] intentionally omitted <==**

**==> picture [7 x 4] intentionally omitted <==**

**==> picture [124 x 94] intentionally omitted <==**

**==> picture [6 x 94] intentionally omitted <==**

**==> picture [124 x 94] intentionally omitted <==**

**==> picture [7 x 94] intentionally omitted <==**

**==> picture [247 x 19] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) 3-layer NN trained on LQR (b) 4-layer NN trained on LQR<br>with Q = diag(0.3, 3), R = 0.3 with Q = I2 and R = 1.<br>**----- End of picture text -----**<br>


Fig. 3: The sector bounds vs NN output for two different NNs. 

a deterministic controller u(t) = π(Cx). As the result of training, the weights of the NN yield −Γ1 = Γ2 = [2.75, 1.47]. In Fig. 3, the validity of the sector bounds defined by (8) is demonstrated. Fig. 3 shows the NN output for a set of 100 random inputs to lie between the functions Γ1z and Γ2z. As demonstrated in Fig. 3, the bounds obtained by the widest possible Σ1 and Σ2 in Theorem 1 encompass those obtained by Γ1 and Γ2 for two different NNs. As seen in Fig. 3a our obtained bound can be tight, depending on the neural network’s parameters. 

−5.41 0.40 Now, given that A + BΓ1C = 2.17 −6.18 is Metzler � � and A + BΓ2C is Hurwitz with eigenvalues (−6.69, −1.70), we anticipate the global exponential stability of the closedloop system. Figs. 4a and 4b demonstrate stability. In Fig. 4a, the trajectories of the input of the system are shown for 50 random initial conditions. All of the trajectories remain inside the sector and finally converge to equilibrium. Furthermore, Fig. 4b shows the trajectories of the states of the system, for the same random initial conditions. The exponential stability is foreseeable from Fig. 4b. In order to demonstrate the scalability of the approach, we compared the average run-time of our method against the well-known IQC method presented in [3]. Both codes were run on a same benchmark with Matlab. The result is shown in the first row of Table I. In the second and third columns, we compared our sector bounds with one of the conservative bounds from the literature [24] to assess the level of conservatism in our sector bounds. As observed, our sector bounds exhibit better performance. Furthermore, since our sector bound highly depends on each entry of weight matrices, we can leverage this characteristic to train a NN with an additional layer and almost the same sector bounds. An example of such capability is shown in Table I. The addition of a layer had minimal impact on our bound, while increased the other conservative bound. 

TABLE I: Comparison of computation time and bounds. 10/10/1 denotes a 3-layer NN with 10, 10, 1 neurons, respectively. 

|Method<br>Our method|Network Architecture<br>10/10/1|Computation Time (s)<br>2.5×10−5|Bounds<br>±[2.65,1.61]|
|---|---|---|---|
|Our method<br>IQC method⋆[3]<br>Product of Norms ⋆⋆[24]|10/15/15/1<br>10/10/1<br>10/10/1|2.6×10−5<br>0.68<br>——|±[2.75,1.47]<br>——<br>5.83|
|Product of Norms ⋆⋆[24]|10/15/15/1|——|6.45|



> ⋆ IQC does not explicitly provide bounds for entire NN. Therefore, bounds are not reported.[⋆⋆] Not a method to verify stability; only for comparing bounds. Therefore, computation time is not reported. 

**==> picture [249 x 104] intentionally omitted <==**

**----- Start of picture text -----**<br>
100<br>90 x1<br>80 x2<br>70<br>60<br>50<br>40<br>30<br>20<br>10<br>0<br>0 0.5 1 1.5 2 2.5 3<br>Time<br>(a) Trajectories of input and states. (b) Trajectories of states.<br>State Variables<br>**----- End of picture text -----**<br>


Fig. 4: Trajectory of system for 50 random initial conditions. V. DISCUSSION & CONCLUSION 

In this section, we discuss our results and conclude the paper. Our analysis uncovers several critical observations. We expect that increasing the number of layers in the neural network will naturally expand its sector bounds, potentially making it more challenging to verify the stability of a broader range of systems. However, while this is generally the case, the structure of our sector bounds provides some flexibility to offset this expansion, as illustrated in Table I. Moreover, the addition of more layers does not add complexity or difficulty to our method. 

To contextualize our findings, we compare them with previous studies in the field. We note that most studies focus on using Lyapunov functions and solving Linear Matrix Inequalities (LMIs) for stability. These methods are less practical for large systems due to their complexity. Our approach, based on the Aizerman conjecture, offers a simpler alternative that results in a huge improvement of run-time and scalability to larger systems. 

While interpreting the results, it is essential to acknowledge certain limitations. A notable instance is that our bounds can become conservative in some cases. Two examples are shown in Fig. 3 for both conservative and quite precise bounds. One way to overcome this limitation is to adopt local sector bounds, as explained in [3]. This essentially means restricting the inputs to the activation functions, or in another word, reducing the level of stability to local stability of the closed-loop system. Another limitation is the restriction of our sector bound in handling NN with biases. This limitation carries over to our analysis. While our sector bounds can be extended to include biases with some modifications, detailing this would exceed the scope of the current paper. We plan to explore this extension in future work. Another less restrictive assumption is that C, B ≥ 0 as the state transition matrix A is not restricted in the positive Aizerman theorem. Matrix A does not need to be Metzler, and therefore the LTI system does not need to be positive. A verification method based on the positive Aizerman theorem only requires the combined LTI system and NN controller to be positive. 

This study encourages the exploration of basic theorems like the Aizerman and Kalman conjectures for verification of NNs. It opens the door for further investigations into refining sector bounds for NNs to enhance stability analysis. The potential for investigating local sector bounds and the local stability of systems, and examining other NN architectures, such as recurrent neural networks, within the framework of the positive Aizerman theorem presents an intriguing avenue for further 

## study. 

REFERENCES 

- [1] K. Hornik, M. Stinchcombe, and H. White, “Multilayer feedforward networks are universal approximators,” Neural Networks, vol. 2, no. 5, pp. 359–366, 1989. 

- [2] M. Sznaier, A. Olshevsky, and E. D. Sontag, “The role of systems theory in control oriented learning,” in 25th International Symposium on Mathematical Theory of Networks and Systems, 2022. 

- [3] H. Yin, P. Seiler, and M. Arcak, “Stability analysis using quadratic constraints for systems with neural network controllers,” IEEE Transactions on Automatic Control, vol. 67, no. 4, pp. 1980–1987, 2021. 

- [4] H. Yin, P. Seiler, M. Jin, and M. Arcak, “Imitation learning with stability and safety guarantees,” IEEE Control Systems Letters, vol. 6, pp. 409– 414, 2021. 

- [5] F. Gu, H. Yin, L. E. Ghaoui, M. Arcak, P. Seiler, and M. Jin, “Recurrent neural network controllers synthesis with stability guarantees for partially observed systems,” Proceedings of the AAAI Conference on Artificial Intelligence, vol. 36, pp. 5385–5394, Jun. 2022. 

- [6] M. Fazlyab, M. Morari, and G. J. Pappas, “An introduction to neural network analysis via semidefinite programming,” in 2021 60th IEEE Conference on Decision and Control (CDC), pp. 6341–6350, IEEE, 2021. 

- [7] N. Hashemi, J. Ruths, and M. Fazlyab, “Certifying incremental quadratic constraints for neural networks via convex optimization,” in Learning for Dynamics and Control, pp. 842–853, PMLR, 2021. 

- [8] M. Jin and J. Lavaei, “Stability-certified reinforcement learning: A control-theoretic perspective,” IEEE Access, vol. 8, pp. 229086–229100, 2020. 

- [9] Z. Qin, K. Zhang, Y. Chen, J. Chen, and C. Fan, “Learning safe multi-agent control with decentralized neural barrier certificates,” arXiv preprint arXiv:2101.05436, 2021. 

- [10] C. R. Richardson, M. C. Turner, and S. R. Gunn, “Strengthened Circle and Popov criteria for the stability analysis of feedback systems with ReLU neural networks,” IEEE Control Systems Letters, 2023. 

- [11] M. Newton and A. Papachristodoulou, “Stability of non-linear neural feedback loops using sum of squares,” in 2022 IEEE 61st Conference on Decision and Control (CDC), pp. 6000–6005, IEEE, 2022. 

- [12] A. C. B. de Oliveira, M. Siami, and E. D. Sontag, “On the ISS property of the gradient flow for single hidden-layer neural networks with linear activations,” arXiv preprint arXiv:2305.09904, 2023. 

- [13] S. Commuri and F. L. Lewis, “Cmac neural networks for control of nonlinear dynamical systems: structure, stability and passivity,” Automatica, vol. 33, no. 4, pp. 635–641, 1997. 

- [14] W. Cui, Y. Jiang, B. Zhang, and Y. Shi, “Structured neural-PI control with end-to-end stability and output tracking guarantees,” in Advances in Neural Information Processing Systems (A. Oh, T. Neumann, A. Globerson, K. Saenko, M. Hardt, and S. Levine, eds.), vol. 36, pp. 68434– 68457, Curran Associates, Inc., 2023. 

- [15] C. Dawson, S. Gao, and C. Fan, “Safe control with learned certificates: A survey of neural Lyapunov, barrier, and contraction methods for robotics 

- [16] andO. Gates,control,”M.IEEENewton,Transactionsand K. Gatsis,on Robotics“Scalable, 2023.forward reachability analysis of multi-agent systems with neural network controllers,” in 2023 62nd IEEE Conference on Decision and Control (CDC), pp. 67–72, IEEE, 2023. 

- [17] H. Zhang, T.-W. Weng, P.-Y. Chen, C.-J. Hsieh, and L. Daniel, “Efficient neural network robustness certification with general activation functions,” Advances in neural information processing systems, vol. 31, 2018. 

- [18] S. Chen, E. Wong, J. Z. Kolter, and M. Fazlyab, “Deepsplit: Scalable verification of deep neural networks via operator splitting,” IEEE Open Journal of Control Systems, vol. 1, pp. 126–140, 2022. 

- [19] H. K. Khalil, Control of nonlinear systems. Prentice Hall, New York, NY, 2002. 

- [20] V. Bragin, V. Vagaitsev, N. Kuznetsov, and G. Leonov, “Algorithms for finding hidden oscillations in nonlinear systems. the Aizerman and Kalman conjectures and Chua’s circuits,” Journal of Computer and Systems Sciences International, vol. 50, pp. 511–543, 2011. 

- [21] R. Drummond, C. Guiver, and M. C. Turner, “Aizerman conjectures for a class of multivariate positive systems,” IEEE Transactions on Automatic Control, 2022. 

- [22] J. Soykens, J. Vandewalle, and B. De Moor, “Lur’e systems with multilayer perceptron and recurrent neural networks: absolute stability and dissipativity,” IEEE Transactions on Automatic Control, vol. 44, no. 4, pp. 770–774, 1999. 

- [23] S. Gowal, K. Dvijotham, R. Stanforth, R. Bunel, C. Qin, J. Uesato, R. Arandjelovic, T. Mann, and P. Kohli, “On the effectiveness of interval bound propagation for training verifiably robust models,” arXiv preprint arXiv:1810.12715, 2018. 

- [24] C. Szegedy, W. Zaremba, I. Sutskever, J. Bruna, D. Erhan, I. Goodfellow, and R. Fergus, “Intriguing properties of neural networks,” arXiv preprint arXiv:1312.6199, 2013. 

- [25] A. Berman, M. Neumann, and R. Stern, Nonnegative Matrices in Dynamic Systems. Pure and Applied Mathematics: A Wiley Series of Texts, Monographs and Tracts, Wiley, 1989. 

- [26] W. M. Haddad, V. Chellaboina, and Q. Hui, Nonnegative and compartmental dynamical systems. Princeton University Press, 2010. 

- [27] Y. Ebihara, D. Peaucelle, and D. Arzelier, “Analysis and synthesis of interconnected positive systems,” IEEE Transactions on Automatic Control, vol. 62, no. 2, pp. 652–667, 2016. 

- [28] E. D. Sontag, Mathematical control theory: deterministic finite dimensional systems, vol. 6. Springer Science & Business Media, 2013. 

